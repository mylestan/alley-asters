namespace :plants do
  desc "Deduplicate plants by common name (case insensitive), reassigning associations"
  task dedupe: :environment do
    dupes_found = 0
    removed = 0

    Plant.select("LOWER(name) as lower_name")
         .group("LOWER(name)")
         .having("COUNT(*) > 1")
         .pluck(Arel.sql("LOWER(name)"))
         .each do |lower_name|

      plants = Plant.where("LOWER(name) = ?", lower_name).order(:created_at)
      keeper = plants.first
      duplicates = plants[1..]

      dupes_found += duplicates.size

      duplicates.each do |dupe|
        puts "  Merging '#{dupe.name}' (id: #{dupe.id}) into '#{keeper.name}' (id: #{keeper.id})"

        # Reassign plot associations, skip if already exists
        dupe.plots_plants.each do |pp|
          unless PlotsPlant.exists?(plot_id: pp.plot_id, plant_id: keeper.id)
            pp.update!(plant_id: keeper.id)
          else
            pp.destroy
          end
        end

        dupe.destroy!
        removed += 1
      end
    end

    if dupes_found == 0
      puts "No duplicates found."
    else
      puts "\nDone! Removed #{removed} duplicate(s). #{Plant.count} plants remaining."
    end
  end
end
