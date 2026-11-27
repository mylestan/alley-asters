namespace :plots do
  desc "Parse existing plot names into address, sub_location, and name fields"
  task parse_names: :environment do
    Plot.find_each do |plot|
      original = plot.name

      if original.match(/^(\d+\s+.+?)\s*\((.+)\)$/)
        # "3614 Wyoming (East)" → address: "3614 Wyoming", sub_location: "East"
        plot.address = $1.strip
        plot.sub_location = $2.strip
        plot.name = nil
      elsif original.match(/^(\d+\s+\S+)\s+([NSEW]{1,3}|[Ee]ast|[Ww]est|[Nn]orth|[Ss]outh)$/)
        # "3730 Connecticut E" → address: "3730 Connecticut", sub_location: "E"
        plot.address = $1.strip
        plot.sub_location = $2.strip
        plot.name = nil
      elsif original.match(/^\d+\s+/)
        # "3884 Connecticut" → address: "3884 Connecticut"
        plot.address = original
        plot.name = nil
      else
        # "Mann Elementary" → name stays, no address
        plot.address = nil
      end

      plot.save!
      parts = [ plot.address, plot.sub_location, plot.name ].compact.reject(&:blank?)
      puts "  #{original} → address: #{plot.address.inspect}, sub: #{plot.sub_location.inspect}, name: #{plot.name.inspect}"
    end

    puts "\nDone! #{Plot.count} plots parsed."
  end
end
