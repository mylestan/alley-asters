namespace :plots do
  desc "Import all plots from Google Map KML data and enrich with old webpage data + photos"
  task import: :environment do
    # ─── KML data by layer ───────────────────────────────────────────────
    kml_plots = [
      # Alley Asters Plots (planted, managed by us)
      { name: "3614 Wyoming (East)",     lat: 38.5987721, lng: -90.2434659, status: "planted", managed_by_us: true },
      { name: "3614 Wyoming (West)",     lat: 38.5987817, lng: -90.2435715, status: "planted", managed_by_us: true },
      { name: "3884 Connecticut",        lat: 38.600284,  lng: -90.2495534, status: "planted", managed_by_us: true },
      { name: "3880 Connecticut",        lat: 38.6002971, lng: -90.2496714, status: "planted", managed_by_us: true },
      { name: "3891 Connecticut",        lat: 38.6011576, lng: -90.2496846, status: "planted", managed_by_us: true },
      { name: "3893 Connecticut",        lat: 38.6011691, lng: -90.2498053, status: "planted", managed_by_us: true },
      { name: "3847 Connecticut (East)", lat: 38.6010155, lng: -90.2482195, status: "planted", managed_by_us: true },
      { name: "3847 Connecticut (West)", lat: 38.6010066, lng: -90.2481397, status: "planted", managed_by_us: true },
      { name: "3812 Juniata",           lat: 38.6009398, lng: -90.2469183, status: "planted", managed_by_us: true },
      { name: "3883 Juniata",           lat: 38.6020267, lng: -90.2493174, status: "planted", managed_by_us: true },
      { name: "3807 Humphrey",          lat: 38.599069,  lng: -90.2470663, status: "planted", managed_by_us: true },
      { name: "4020 Hartford",          lat: 38.6023623, lng: -90.2535182, status: "planted", managed_by_us: true },
      { name: "Mann Elementary",         lat: 38.6023197, lng: -90.2537186, status: "planted", managed_by_us: true },
      { name: "4045 Humphrey",          lat: 38.5996454, lng: -90.2548544, status: "planted", managed_by_us: true },
      { name: "4309 Norfolk",           lat: 38.6255696, lng: -90.2570371, status: "planted", managed_by_us: true },
      { name: "3711 Humphrey",          lat: 38.5989565, lng: -90.2459166, status: "planted", managed_by_us: true },
      { name: "3892 Hartford",          lat: 38.6021651, lng: -90.2496449, status: "planted", managed_by_us: true },
      { name: "3874 Hartford",          lat: 38.6020473, lng: -90.2490019, status: "planted", managed_by_us: true },
      { name: "3920 Potomac",           lat: 38.5941258, lng: -90.2519528, status: "planted", managed_by_us: true },
      { name: "3801 Humphrey",          lat: 38.5990485, lng: -90.2468294, status: "planted", managed_by_us: true },
      { name: "4021 Juniata",           lat: 38.6023042, lng: -90.2535001, status: "planted", managed_by_us: true },
      { name: "3883 Hartford",          lat: 38.6029503, lng: -90.2492,    status: "planted", managed_by_us: true },
      { name: "3727 Hartford",          lat: 38.6026147, lng: -90.2456231, status: "planted", managed_by_us: true },
      { name: "3636 Arsenal",           lat: 38.6025006, lng: -90.2438191, status: "planted", managed_by_us: true },
      { name: "4000 Wyoming",           lat: 38.5995446, lng: -90.2532503, status: "planted", managed_by_us: true },
      { name: "3975 Wyoming",           lat: 38.6003439, lng: -90.2527288, status: "planted", managed_by_us: true },
      { name: "3895 Connecticut",       lat: 38.6011691, lng: -90.2498053, status: "planted", managed_by_us: true },

      # Planned
      { name: "3734 Utah",          lat: 38.5969333, lng: -90.2469339, status: "planned", managed_by_us: true },
      { name: "3909 Juniata",       lat: 38.6019932, lng: -90.2501678, status: "planned", managed_by_us: true },
      { name: "3961 Juniata",       lat: 38.6021816, lng: -90.2520421, status: "planned", managed_by_us: true },
      { name: "3610 Utah",          lat: 38.5966111, lng: -90.2437198, status: "planned", managed_by_us: true },
      { name: "3957 Juniata",       lat: 38.6021792, lng: -90.2520153, status: "planned", managed_by_us: true },
      { name: "4048 Wyoming",       lat: 38.599701,  lng: -90.2548849, status: "planned", managed_by_us: true },
      { name: "3700 Connecticut",   lat: 38.599869,  lng: -90.2453085, status: "planned", managed_by_us: true },
      { name: "3966 Juniata",       lat: 38.601263,  lng: -90.2524586, status: "planned", managed_by_us: true },
      { name: "3730 Connecticut W", lat: 38.5969038, lng: -90.246742,  status: "planned", managed_by_us: true },
      { name: "3730 Connecticut E", lat: 38.5968912, lng: -90.2466106, status: "planned", managed_by_us: true },
      { name: "3854 Connecticut",   lat: 38.6001885, lng: -90.2486091, status: "planned", managed_by_us: true },
      { name: "3850 Connecticut",   lat: 38.6001785, lng: -90.2485025, status: "planned", managed_by_us: true },
      { name: "3853 Wyoming",       lat: 38.6001052, lng: -90.2484851, status: "planned", managed_by_us: true },
      { name: "3879 Wyoming",       lat: 38.6002183, lng: -90.2494099, status: "planned", managed_by_us: true },
      { name: "3888 Connecticut",   lat: 38.6003184, lng: -90.2497908, status: "planned", managed_by_us: true },
      { name: "3873 Wyoming",       lat: 38.600205,  lng: -90.2492751, status: "planned", managed_by_us: true },

      # Potential
      { name: "3647 Wyoming",      lat: 38.5997382, lng: -90.2444911, status: "potential", managed_by_us: true },
      { name: "3810 Arsenal",      lat: 38.6027571, lng: -90.2465287, status: "potential", managed_by_us: true },
      { name: "3722 Arsenal",      lat: 38.602662,  lng: -90.2455242, status: "potential", managed_by_us: true },
      { name: "3718 Arsenal",      lat: 38.6026509, lng: -90.2454028, status: "potential", managed_by_us: true },
      { name: "3721 Hartford",     lat: 38.6025977, lng: -90.2454243, status: "potential", managed_by_us: true },
      { name: "3657 Hartford",     lat: 38.6024933, lng: -90.2445178, status: "potential", managed_by_us: true },
      { name: "3979 Hartford",     lat: 38.6032322, lng: -90.2523797, status: "potential", managed_by_us: true },
      { name: "4006 Wyoming",      lat: 38.599566,  lng: -90.2534661, status: "potential", managed_by_us: true },
      { name: "3724 Wyoming",      lat: 38.5990287, lng: -90.2461022, status: "potential", managed_by_us: true },
      { name: "4056 Hartford",     lat: 38.6024759, lng: -90.2547563, status: "potential", managed_by_us: true },
      { name: "4040 Hartford",     lat: 38.6024199, lng: -90.2540628, status: "potential", managed_by_us: true },
      { name: "4004 Hartford",     lat: 38.6023042, lng: -90.2529045, status: "potential", managed_by_us: true },
      { name: "3730 Utah",         lat: 38.5969075, lng: -90.2467415, status: "potential", managed_by_us: true },
      { name: "3655 Wyoming",      lat: 38.5997609, lng: -90.2447154, status: "potential", managed_by_us: true },
      { name: "3800 Connecticut",  lat: 38.6001603, lng: -90.2466465, status: "potential", managed_by_us: true },
    ]

    # ─── Enrichment data from the old webpage ────────────────────────────
    # Keyed by plot name as it appears in kml_plots above
    enrichment = {
      "3884 Connecticut" => {
        first_planted: Date.new(2023, 10, 1),
        plants_removed: "daylilies, chameleon plant",
        initial_plant_count: 30,
        square_footage: 100,
        notes: "The front of these beds are community herb gardens."
      },
      "3891 Connecticut" => {
        first_planted: Date.new(2024, 10, 1),
        plants_removed: "n/a - was bare dirt",
        initial_plant_count: 13,
        square_footage: 10
      },
      "3847 Connecticut (East)" => {
        first_planted: Date.new(2024, 10, 1),
        plants_removed: "hostas",
        initial_plant_count: 18,
        square_footage: 25
      },
      "3614 Wyoming (East)" => {
        first_planted: Date.new(2024, 10, 1),
        plants_removed: "daylilies and grasses",
        initial_plant_count: 30,
        square_footage: 55
      },
      "4020 Hartford" => {
        first_planted: Date.new(2024, 10, 1),
        plants_removed: "n/a - mulched dirt",
        initial_plant_count: 30,
        square_footage: 55
      },
      "3895 Connecticut" => {
        first_planted: Date.new(2024, 10, 1),
        plants_removed: "misc weeds",
        initial_plant_count: 15,
        square_footage: 25,
        notes: "A butterfly garden is being attempted behind the recycling bin. Along the side of the garage, a less formal planting of golden ragwort and cliff goldenrod was used."
      },
      "Mann Elementary" => {
        first_planted: Date.new(2024, 10, 1),
        plants_removed: "misc weeds",
        initial_plant_count: 130,
        square_footage: 200
      },
      "4309 Norfolk" => {
        first_planted: Date.new(2024, 10, 1),
        plants_removed: "n/a - mulched dirt",
        initial_plant_count: 60,
        square_footage: 65
      },
      "3807 Humphrey" => {
        first_planted: Date.new(2025, 4, 1),
        plants_removed: "n/a - bare dirt",
        initial_plant_count: 25,
        square_footage: 30
      },
      "3801 Humphrey" => {
        first_planted: Date.new(2025, 4, 1),
        plants_removed: "Tall grasses",
        initial_plant_count: 5,
        square_footage: 6
      },
      "3711 Humphrey" => {
        first_planted: Date.new(2025, 4, 1),
        plants_removed: "bare dirt",
        initial_plant_count: 5,
        square_footage: 6
      },
      "3975 Wyoming" => {
        first_planted: Date.new(2025, 4, 1),
        plants_removed: "bare dirt",
        initial_plant_count: 10,
        square_footage: 6
      },
      "3920 Potomac" => {
        first_planted: Date.new(2025, 4, 1),
        plants_removed: "bare dirt",
        initial_plant_count: 10,
        square_footage: 12
      },
      "4045 Humphrey" => {
        first_planted: Date.new(2024, 10, 1),
        plants_removed: "grass",
        initial_plant_count: 60,
        square_footage: 100
      }
    }

    # ─── Photo data from old webpage ─────────────────────────────────────
    # Keyed by plot name, maps to image directory and ordered [filename, caption] pairs
    photos_data = {
      "3884 Connecticut" => {
        dir: "3884-connecticut",
        images: [
          ["IMG_3719.jpg", "Initial planting (east bed)"],
          ["IMG_5119.jpg", "1st year spring (east bed)"],
          ["IMG_5225.jpg", "1st year summer (east bed)"],
          ["IMG_5053.jpg", "1st year (west bed)"],
        ]
      },
      "3891 Connecticut" => {
        dir: "3891-connecticut",
        images: [
          ["IMG_5318.jpg", "Before"],
          ["IMG_5712.jpg", "Initial planting"],
        ]
      },
      "3847 Connecticut (East)" => {
        dir: "3847-connecticut",
        images: [
          ["IMG_5761.jpg", "Before (east bed)"],
          ["IMG_5820.jpg", "Initial planting"],
          ["IMG_7522.jpg", "1st year"],
          ["IMG_5760.jpg", "Before (west bed)"],
          ["IMG_5819.jpg", "Initial planting"],
          ["IMG_7524.jpg", "1st year"],
        ]
      },
      "3614 Wyoming (East)" => {
        dir: "3614-wyoming",
        images: [
          ["IMG_5396.jpg", "Before, trimmed (east bed)"],
          ["IMG_5397.jpg", "Solarization"],
          ["IMG_5831.jpg", "Initial planting"],
          ["IMG_8060.jpg", "1st year"],
          ["IMG_5394.jpg", "Before, trimmed (west bed)"],
          ["IMG_5395.jpg", "Solarization"],
          ["IMG_7459.jpg", "Initial planting"],
          ["IMG_8061.jpg", "1st year"],
        ]
      },
      "4020 Hartford" => {
        dir: "4020-hartford",
        images: [
          ["IMG_5763.jpg", "During planting"],
          ["IMG_5785.jpg", "Initial planting"],
          ["IMG_7528.jpg", "1st year"],
        ]
      },
      "3895 Connecticut" => {
        dir: "3895-connecticut",
        images: [
          ["IMG_5283.jpg", "Before (east bed)"],
          ["IMG_9508.jpg", "Cleared (east bed)"],
          ["IMG_5755.jpg", "Initial planting (east bed)"],
          ["IMG_5849.jpg", "Initial planting (west bed)"],
        ]
      },
      "Mann Elementary" => {
        dir: "mann-elementary",
        images: [
          ["IMG_5431.jpg", "Before"],
          ["IMG_5626.jpg", "Solarization"],
          ["IMG_5854.jpg", "Initial planting"],
          ["IMG_7529.jpg", "1st year (spring)"],
          ["IMG_8156.jpg", "1st year (summer)"],
        ]
      },
      "4309 Norfolk" => {
        dir: "4309-norfolk",
        images: [
          ["IMG_5846.jpg", "Initial planting"],
          ["IMG_8086.jpg", "1st year (summer)"],
        ]
      },
      "3807 Humphrey" => {
        dir: "3807-humphrey",
        images: [
          ["IMG_7011.jpg", "Before"],
          ["IMG_7198.jpg", "Initial planting"],
        ]
      },
      "3801 Humphrey" => {
        dir: "3801-humphrey",
        images: [
          ["IMG_7604.jpg", "Initial planting"],
        ]
      },
      "3711 Humphrey" => {
        dir: "3711-humphrey",
        images: [
          ["IMG_6302.jpg", "Before"],
          ["IMG_7455.jpg", "Initial planting"],
        ]
      },
      "3975 Wyoming" => {
        dir: "3975-wyoming",
        images: [
          ["IMG_5330.jpg", "Before"],
          ["IMG_7577.jpg", "Initial planting"],
          ["IMG_8675.jpg", "0th year (fall)"],
        ]
      },
      "3920 Potomac" => {
        dir: "3920-potomac",
        images: [
          ["IMG_7486.jpg", "Before"],
        ]
      },
      "4045 Humphrey" => {
        dir: "4045-humphrey",
        images: [
          ["IMG_5422.jpg", "Before"],
          ["IMG_5853.jpg", "Initial planting"],
          ["IMG_7531.jpg", "1st year (spring)"],
        ]
      },
    }

    # ─── Import ──────────────────────────────────────────────────────────
    created = 0
    updated = 0
    photos_attached = 0

    kml_plots.each do |entry|
      plot = Plot.find_or_initialize_by(name: entry[:name])
      is_new = plot.new_record?

      plot.assign_attributes(
        latitude: entry[:lat],
        longitude: entry[:lng],
        status: entry[:status],
        managed_by_us: entry[:managed_by_us]
      )

      # Apply enrichment data if available
      if enrichment[entry[:name]]
        plot.assign_attributes(enrichment[entry[:name]])
      end

      plot.save!

      if is_new
        created += 1
      else
        updated += 1
      end

      # Attach photos if available and not already attached
      if photos_data[entry[:name]] && plot.photos.empty?
        photo_info = photos_data[entry[:name]]
        photo_info[:images].each_with_index do |(filename, caption), index|
          path = Rails.root.join("public", "img", "opt", photo_info[:dir], filename)
          next unless File.exist?(path)

          photo = plot.photos.create!(caption: caption)
          photo.image.attach(
            io: File.open(path),
            filename: filename,
            content_type: "image/jpeg"
          )
          photos_attached += 1
        end
      end

      puts "  #{is_new ? '+' : '~'} #{plot.name} (#{plot.status})"
    end

    puts "\nDone! Created: #{created}, Updated: #{updated}, Photos attached: #{photos_attached}"
    puts "Total plots: #{Plot.count}"
  end
end
