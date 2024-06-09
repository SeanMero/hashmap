class HashMap < Array
  attr_accessor :capacity, :load_factor, :num_keys

  def initialize(capacity = 16, load_factor = 0.75)
    @capacity = capacity
    @load_factor = load_factor
    @num_keys = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  # set the value associated with a key
  # if the key already exists, it will be overwritten
  def set(key, value)
    hashed_key = hash(key) % capacity
    if self[hashed_key].nil?
      self[hashed_key] = { key => value }
    else
      self[hashed_key][key] = value
    end

    # grow more buckets when needed
    self.num_keys += 1
    self.capacity *= 2 if self.num_keys > self.capacity * self.load_factor
  end

  # get the value associated with a key
  # return nil if key is not in the hash map
  def get(key)
    hashed_key = hash(key) % capacity
    if self[hashed_key].nil?
      nil
    else
      self[hashed_key][key]
    end
  end

  def has?(key)
    hashed_key = hash(key) % capacity
    self[hashed_key] != nil
  end

  def remove(key)
    hashed_key = hash(key) % capacity
    if self[hashed_key].nil?
      nil
    else
      self[hashed_key].delete(key)
    end
  end

  def length
    self.num_keys
  end

  def clear
    self.each do |elem|
      next if elem.nil?

      elem.each_key { |key| elem.delete(key) }
    end
  end
end
