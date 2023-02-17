require 'time'
module Serialize
  def serialize_save(*args)
    array = []
    args.each do |a|
      array.push(a)
    end
    save = Marshal.dump(array)
    File.new(Time.now.to_s, 'w').write(save)
  end

  def serialize_load(target)
    save_file = File.open(target)
    load = Marshal.load(save_file)
  end
end