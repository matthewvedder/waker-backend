path = "/home/vedder/Downloads/PNG/"
filenames = Dir.entries(path).select {|f| !File.directory? f}

filenames.each do |filename|
  name = filename.split('.')[0].split('-').join(' ').titlecase
  asana = Asana.new(name: name)
  asana.save
  asana.thumbnail.attach(io: File.open(path + filename), filename: 'filename')
end


# sequence = Sequence.new(user: User.first, name: 'Test Sequence')
# sequence.save
# Asana.all.each { |asana| AsanaInstance.create!(sequence: sequence) }

# lorum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
#
# sequence.asana_instances.each do |asana_instance|
#   asana_instance.notes = lorum[0...rand(1000)]
#   asana_instance.save!
# end
