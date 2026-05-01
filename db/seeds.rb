Admin.find_or_create_by!(email: "alleyasters@gmail.com") do |admin|
  admin.password = "password"
end

plots_data = [
  {
    name: "3884 Connecticut St",
    first_planted: Date.new(2023, 10, 1),
    plants_removed: "daylilies, chameleon plant",
    initial_plant_count: 30,
    square_footage: 100,
    latitude: 38.600284,
    longitude: -90.2495534,
    notes: "The front of these beds are community herb gardens.",
    managed_by_us: true,
    status: "planted"
  },
  {
    name: "3891 Connecticut St",
    first_planted: Date.new(2024, 10, 1),
    plants_removed: "n/a - was bare dirt",
    initial_plant_count: 13,
    square_footage: 10,
    latitude: 38.6011576,
    longitude: -90.2496846,
    managed_by_us: true,
    status: "planted"
  },
  {
    name: "3847 Connecticut St",
    first_planted: Date.new(2024, 10, 1),
    plants_removed: "hostas",
    initial_plant_count: 18,
    square_footage: 25,
    latitude: 38.6010155,
    longitude: -90.2482195,
    managed_by_us: true,
    status: "planted"
  },
  {
    name: "3614 Wyoming St",
    first_planted: Date.new(2024, 10, 1),
    plants_removed: "daylilies and grasses",
    initial_plant_count: 30,
    square_footage: 55,
    latitude: 38.5987721,
    longitude: -90.2434659,
    managed_by_us: true,
    status: "planted"
  },
  {
    name: "4020 Hartford St",
    first_planted: Date.new(2024, 10, 1),
    plants_removed: "n/a - mulched dirt",
    initial_plant_count: 30,
    square_footage: 55,
    latitude: 38.6023623,
    longitude: -90.2535182,
    managed_by_us: true,
    status: "planted"
  },
  {
    name: "3895 Connecticut St",
    first_planted: Date.new(2024, 10, 1),
    plants_removed: "misc weeds",
    initial_plant_count: 15,
    square_footage: 25,
    latitude: 38.6011691,
    longitude: -90.2498053,
    notes: "A butterfly garden is being attempted behind the recycling bin. Along the side of the garage, a less formal planting of golden ragwort and cliff goldenrod was used.",
    managed_by_us: true,
    status: "planted"
  },
  {
    name: "Mann Elementary",
    first_planted: Date.new(2024, 10, 1),
    plants_removed: "misc weeds",
    initial_plant_count: 130,
    square_footage: 200,
    latitude: 38.6023197,
    longitude: -90.2537186,
    managed_by_us: true,
    status: "planted"
  },
  {
    name: "4309 Norfolk",
    first_planted: Date.new(2024, 10, 1),
    plants_removed: "n/a - mulched dirt",
    initial_plant_count: 60,
    square_footage: 65,
    latitude: 38.6255696,
    longitude: -90.2570371,
    managed_by_us: true,
    status: "planted"
  },
  {
    name: "3807 Humphrey",
    first_planted: Date.new(2025, 4, 1),
    plants_removed: "n/a - bare dirt",
    initial_plant_count: 25,
    square_footage: 30,
    latitude: 38.599069,
    longitude: -90.2470663,
    managed_by_us: true,
    status: "planted"
  },
  {
    name: "3801 Humphrey",
    first_planted: Date.new(2025, 4, 1),
    plants_removed: "Tall grasses",
    initial_plant_count: 5,
    square_footage: 6,
    latitude: 38.5990485,
    longitude: -90.2468294,
    managed_by_us: true,
    status: "planted"
  },
  {
    name: "3711 Humphrey",
    first_planted: Date.new(2025, 4, 1),
    plants_removed: "bare dirt",
    initial_plant_count: 5,
    square_footage: 6,
    latitude: 38.5989565,
    longitude: -90.2459166,
    managed_by_us: true,
    status: "planted"
  },
  {
    name: "3975 Wyoming",
    first_planted: Date.new(2025, 4, 1),
    plants_removed: "bare dirt",
    initial_plant_count: 10,
    square_footage: 6,
    latitude: 38.6003439,
    longitude: -90.2527288,
    managed_by_us: true,
    status: "planted"
  },
  {
    name: "3920 Potomac",
    first_planted: Date.new(2025, 4, 1),
    plants_removed: "bare dirt",
    initial_plant_count: 10,
    square_footage: 12,
    latitude: 38.5941258,
    longitude: -90.2519528,
    managed_by_us: true,
    status: "planted"
  },
  {
    name: "4045 Humphrey",
    first_planted: Date.new(2024, 10, 1),
    plants_removed: "grass",
    initial_plant_count: 60,
    square_footage: 100,
    latitude: 38.5996454,
    longitude: -90.2548544,
    managed_by_us: true,
    status: "planted"
  },
  # Planned plots
  {
    name: "3734 Utah",
    latitude: 38.5969333,
    longitude: -90.2469339,
    managed_by_us: true,
    status: "planned"
  },
  {
    name: "3909 Juniata",
    latitude: 38.6019932,
    longitude: -90.2501678,
    managed_by_us: true,
    status: "planned"
  },
  {
    name: "3961 Juniata",
    latitude: 38.6021816,
    longitude: -90.2520421,
    managed_by_us: true,
    status: "planned"
  },
  {
    name: "3610 Utah",
    latitude: 38.5966111,
    longitude: -90.2437198,
    managed_by_us: true,
    status: "planned"
  },
  {
    name: "3957 Juniata",
    latitude: 38.6021792,
    longitude: -90.2520153,
    managed_by_us: true,
    status: "planned"
  },
  {
    name: "4048 Wyoming",
    latitude: 38.599701,
    longitude: -90.2548849,
    managed_by_us: true,
    status: "planned"
  },
  {
    name: "3700 Connecticut",
    latitude: 38.599869,
    longitude: -90.2453085,
    managed_by_us: true,
    status: "planned"
  },
  {
    name: "3966 Juniata",
    latitude: 38.601263,
    longitude: -90.2524586,
    managed_by_us: true,
    status: "planned"
  },
  {
    name: "3730 Connecticut W",
    latitude: 38.5969038,
    longitude: -90.246742,
    managed_by_us: true,
    status: "planned"
  },
  {
    name: "3730 Connecticut E",
    latitude: 38.5968912,
    longitude: -90.2466106,
    managed_by_us: true,
    status: "planned"
  },
  {
    name: "3854 Connecticut",
    latitude: 38.6001885,
    longitude: -90.2486091,
    managed_by_us: true,
    status: "planned"
  },
  {
    name: "3850 Connecticut",
    latitude: 38.6001785,
    longitude: -90.2485025,
    managed_by_us: true,
    status: "planned"
  },
  {
    name: "3853 Wyoming",
    latitude: 38.6001052,
    longitude: -90.2484851,
    managed_by_us: true,
    status: "planned"
  },
  {
    name: "3879 Wyoming",
    latitude: 38.6002183,
    longitude: -90.2494099,
    managed_by_us: true,
    status: "planned"
  },
  {
    name: "3888 Connecticut",
    latitude: 38.6003184,
    longitude: -90.2497908,
    managed_by_us: true,
    status: "planned"
  },
  {
    name: "3873 Wyoming",
    latitude: 38.600205,
    longitude: -90.2492751,
    managed_by_us: true,
    status: "planned"
  },
  # Potential plots
  {
    name: "3647 Wyoming",
    latitude: 38.5997382,
    longitude: -90.2444911,
    managed_by_us: true,
    status: "potential"
  },
  {
    name: "3810 Arsenal",
    latitude: 38.6027571,
    longitude: -90.2465287,
    managed_by_us: true,
    status: "potential"
  },
  {
    name: "3722 Arsenal",
    latitude: 38.602662,
    longitude: -90.2455242,
    managed_by_us: true,
    status: "potential"
  },
  {
    name: "3718 Arsenal",
    latitude: 38.6026509,
    longitude: -90.2454028,
    managed_by_us: true,
    status: "potential"
  },
  {
    name: "3721 Hartford",
    latitude: 38.6025977,
    longitude: -90.2454243,
    managed_by_us: true,
    status: "potential"
  },
  {
    name: "3657 Hartford",
    latitude: 38.6024933,
    longitude: -90.2445178,
    managed_by_us: true,
    status: "potential"
  },
  {
    name: "3979 Hartford",
    latitude: 38.6032322,
    longitude: -90.2523797,
    managed_by_us: true,
    status: "potential"
  },
  {
    name: "4006 Wyoming",
    latitude: 38.599566,
    longitude: -90.2534661,
    managed_by_us: true,
    status: "potential"
  },
  {
    name: "3724 Wyoming",
    latitude: 38.5990287,
    longitude: -90.2461022,
    managed_by_us: true,
    status: "potential"
  },
  {
    name: "4056 Hartford",
    latitude: 38.6024759,
    longitude: -90.2547563,
    managed_by_us: true,
    status: "potential"
  },
  {
    name: "4040 Hartford",
    latitude: 38.6024199,
    longitude: -90.2540628,
    managed_by_us: true,
    status: "potential"
  },
  {
    name: "4004 Hartford",
    latitude: 38.6023042,
    longitude: -90.2529045,
    managed_by_us: true,
    status: "potential"
  },
  {
    name: "3730 Utah",
    latitude: 38.5969075,
    longitude: -90.2467415,
    managed_by_us: true,
    status: "potential"
  },
  {
    name: "3655 Wyoming",
    latitude: 38.5997609,
    longitude: -90.2447154,
    managed_by_us: true,
    status: "potential"
  },
  {
    name: "3800 Connecticut",
    latitude: 38.6001603,
    longitude: -90.2466465,
    managed_by_us: true,
    status: "potential"
  }
]

plots_data.each do |data|
  plot = Plot.find_or_initialize_by(name: data[:name])
  plot.assign_attributes(data)
  plot.save!
end

puts "Seeded #{Plot.count} plots"
