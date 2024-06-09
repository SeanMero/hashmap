class HashMap < Array
  attr_accessor :capacity, :load_factor, :num_keys

  def initialize(capacity = 16, load_factor = 0.75)
    super
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

  def set(key, value)
    hashed_key = hash(key) % capacity
    if self[hashed_key].nil?
      self[hashed_key] = { key => value }
    else
      self[hashed_key][key] = value
    end

    # grow more buckets when needed
    num_keys += 1
    capacity *= 2 if num_keys > capacity * load_factor
  end
end
