path = "../public/asanas/PNG/"
filenames = Dir.entries(path).select {|f| !File.directory? f}

filenames.each do |filename|
  name = filename.split('.')[0].split('-').join(' ').titlecase
  if (name.present?)
    asana = Asana.new(name: name, file_name: filename)
    asana.save
  end
end


sequence = Sequence.new(user: User.first, name: 'Test Sequence')
sequence.save
Asana.all.each { |asana| AsanaInstance.create!(sequence: sequence, asana: asana) }

lorum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

sequence.reload
sequence.asana_instances.each do |asana_instance|
  asana_instance.notes = lorum[0...rand(1000)]
  asana_instance.save!
end

# bash script for resizing
list=$(ls *.png)
for img in $list; do
convert $img -thumbnail 200x200 $img
done

tags = [
  'backbend',
  'forward fold',
  'twist',
  'standing',
  'seated',
  'arm balance',
  'inversion',
  'lateral',
  'neutral',
  'lunge',
  'floor'

  # 'shoulders',
  # 'hips',
  # 'groin',
  # 'internal rotation',
  # 'external rotation'

  # 'upregulating',
  # 'downregulating',

  # 'primary series',
  # 'light on yoga',
  # 'fundamental',
  # 'advanced',
]
