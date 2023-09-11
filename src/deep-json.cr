require "json"

module DeepJSON
  extend self
  alias Result = Array(String)

  def get(path : String, data : JSON::Any)
    keys = parse_path(path)

    keys.each do |key|
      if is_anchor?(key)
        data = data.size
        break
      end
      if is_int?(key)
        key = key.to_i32
        data = read_by_index(key, data)
        break
      end
      key = key.to_i32 if data.as_a? # if array, set key as index
      data = read_by_key(key, data)
    end

    data
  end

  def parse_path(path : String) : Result
    keys = path.split(/(?<!\\)\./)     # split by non-escaped dot
    keys.map! { |k| k.gsub(/\\/, "") } # remove backslash
  end

  private def read_by_key(key : String | Int32, value : JSON::Any)
    begin
      value.dig(key)
    rescue
      raise Exception.new("Key #{key} not found")
    end
  end

  private def read_by_index(index : Int32, value : JSON::Any)
    begin
      value[index]
    rescue
      raise Exception.new("Invalid index #{index}, should be < #{value.size}")
    end
  end

  private def is_anchor?(key)
    return true if key == "#"
  end

  private def is_int?(key)
    return true if key.to_i32?
  end
end
