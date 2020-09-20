# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
module Enumerable

  # -----------my_each methods--------------
  def my_each
    return to_enum unless block_given?
    arr=to_a
    index=0
    while(index<arr.length)
      yield(arr[index])
      index +=1
  end
   self
end


# -----------my_each_with_index----------------------


def my_each_with_index
  return to_enum unless block_given?
  arr=to_a  
  index=0
  while(index<arr.length)
    yield(arr[index],index)
    index +=1
end
 self
end

# -----------my_select----------------------

def my_select
  return to_enum unless block_given?
  selected=[]
  arr=to_a
  arr.my_each{|x| selected.push(x) if yield(x)}
  return selected

  
end

# puts re=["ayu","bele","hi"].my_select{|x| x!="ayu"}








end