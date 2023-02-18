require 'time'
module Serialize
  def serialize_save(name,*args)
    array = []
    args.each do |a|
      array.push(a)
    end
    save = Marshal.dump(array)
    File.new("../save/#{name}", 'w').write(save)
  end

  def serialize_load(target)
    save_file = File.open("../save/#{target}")
    load = Marshal.load(save_file)
  end
end