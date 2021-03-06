module Enumerable
  # -----------my_each methods--------------

  def my_each
    return to_enum(:my_each) unless block_given?

    index = 0
    arr = to_a
    while index < arr.length
      yield(arr[index])
      index += 1
    end
    self
  end

  # -----------my_each_with_index----------------------

  def my_each_with_index
    return to_enum unless block_given?

    arr = to_a
    index = 0
    while index < arr.length
      yield(arr[index], index)
      index += 1
    end
    self
  end

  # -----------my_select----------------------

  def my_select
    return to_enum unless block_given?

    selected = []
    arr = to_a
    arr.my_each { |x| selected.push(x) if yield(x) }
    selected
  end

  #--------------------my_all-----------------------
  def my_all?(args = nil)
    if args.nil? == false && args.is_a?(Class) == false
      if args.is_a?(Regexp)
        my_each { |i| return false unless !i[args].nil? || i[args] == 1 } # if Regexp
      else
        my_each { |i| return false unless i == args }
      end
    elsif args.is_a?(Class)
      my_each { |i| return false unless i.is_a?(args) }

    # if not Regexp

    elsif args.nil? && block_given?
      my_each { |i| return false unless yield i }
    else
      my_each { |i| return false if i.nil? || i == false }
    end
    true
  end
  #-------------------my_any?-----------------------

  def my_any?(args = nil)
    if args.nil? == false && args.is_a?(Class) == false
      if args.is_a?(Regexp)
        my_each { |i| return true if !i[args].nil? || i[args] == 1 } # if Regexp
      else
        my_each { |i| return true if i == args }
      end
    elsif args.is_a?(Class)
      my_each { |i| return true if i.is_a?(args) }
    elsif args.nil? && block_given?
      my_each { |i| return true if yield i }
    else
      my_each { |i| return true if i == true }
    end
    false
  end

  #-------------------my_none?-----------------------
  def my_none?(args = nil)
    if args.nil? == false && args.is_a?(Class) == false
      if args.is_a?(Regexp)
        my_each { |i| return false if i =~ args } # if Regexp
      else
        my_each { |i| return false unless i != args }
      end
    elsif args.is_a?(Class)
      my_each { |i| return false if i.is_a?(args) }

    elsif args.nil? && block_given?
      my_each { |i| return false if yield i }
    else
      my_each { |i| return false if i == true }
    end
    true
  end

  #-------------------my_count-----------------------
  def my_count(args = nil)
    count = 0
    if !args.nil?
      my_each { |x| count += 1 if x == args }
    elsif args.nil? && block_given?
      my_each { |x| count += 1 if yield x }
    else my_each { count += 1 }
    end
    count
  end

  #-------------------my_map-----------------------
  def my_map(args = nil)
    return to_enum(:my_map) if args.nil? && !block_given?

    mapped = []
    if args.nil?
      my_each_with_index { |i, j| mapped[j] = yield i }
    else
      my_each_with_index { |i, j| mapped[j] = args.call(i) }
    end
    mapped
  end
  #-------------------my_inject-----------------------

  def my_inject(arg1 = nil, arg2 = nil)
    if block_given?
      acc = arg1
      my_each { |item| acc = acc.nil? ? item : yield(acc, item) }
      acc
    elsif arg1.is_a?(Symbol) || arg1.is_a?(String)
      acc = nil
      my_each { |item| acc = acc.nil? ? item : acc.send(arg1, item) }
      acc
    elsif arg2.is_a?(Symbol) || arg2.is_a?(String)
      acc = arg1
      my_each { |item| acc = acc.nil? ? item : acc.send(arg2, item) }
      acc
    else
      raise LocalJumpError, 'No block Given or Empty Argument' unless !arg1.nil? && !arg2.nil? && !block_given?
    end
  end
end
#-------------------multiply_els-----------------------
def multiply_els(arg)
  raise TypeError, 'No Array Given' if arg.nil? || !arg.is_a?(Array)

  arg.my_inject { |result, element| result * element }
end

puts [1, 2, 3, 5, 1, 7, 3].my_each == [1, 2, 3, 5, 1, 7, 3].each
