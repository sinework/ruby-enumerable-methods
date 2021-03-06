require_relative '../script'

describe Enumerable do
  let(:test_array1) { [1, 2, 3, 5, 1, 7, 3] }
  let(:test_array2) { %w[ant bear cat] }
  let(:test_array3) { [1, 1, 1] }
  let(:test_array4) { [1, 1, nil] }
  let(:test_array5) { [nil, false, nil] }
  let(:my_proc) { proc { |x| x + 1 } }
  let(:my_block) { |sum, i| sum + i }
  let(:range) { (1...10) }
  let(:search) { proc { |memo, word| memo.length > word.length ? memo : word } }
  let(:hash) { { x: 100, y: 120, u: 150, v: 130 } }

  let(:test_array1_clone) { test_array1.clone }

  # my_each
  describe '#my_each' do
    context 'No block given' do
      it 'should return an enumerable' do
        expect(test_array1.my_each).to be_a(Enumerable)
      end
    end
    context 'Checking for mutuation' do
      it 'Should return the original array' do
        test_array1.my_each { |num| num + 1 }
        expect(test_array1).to eq(test_array1_clone)
      end
    end
    context 'Block given' do
      it 'The return should be the same as the each method' do
        expect(test_array1.my_each { |x| puts x }).to eq(test_array1.each { |x| puts x })
      end
    end
  end
  # My_each_with_index
  describe '#my_each_with_index' do
    context 'No block given' do
      it 'should return an enumerable' do
        expect(test_array3.my_each_with_index).to be_a(Enumerable)
      end
    end
    context 'Checking for mutuation' do
      it 'Should return the original array' do
        test_array1.my_each_with_index { |num| num + 1 }
        expect(test_array1).to eq(test_array1_clone)
      end
    end
    context 'Block given' do
      it 'The return should be the same as each_with_index method' do
        expect(%w[any k a b c d e].my_each_with_index do |item, index|
                 puts "#{item} : #{index}"
               end).to eq(%w[any k a b c d e].each_with_index do |item, index|
                            puts "#{item} : #{index}"
                          end)
      end
    end
  end
  # my_select
  describe '#my_select' do
    context 'No block given' do
      it 'should return an enumerable' do
        expect(test_array3.my_select).to be_a(Enumerable)
      end
    end
    context 'Block given' do
      it 'The return should be the same as the select method' do
        expect(test_array3.my_select(&:even?)).to eq(test_array3.select(&:even?))
      end
    end
    context 'Checking for mutuation' do
      it 'Should return the original array' do
        test_array1.my_select { |num| num + 1 }
        expect(test_array1).to eq(test_array1_clone)
      end
    end
  end
  # my_all?
  describe '#my_all?' do
    context 'Argument is a Regexp' do
      it 'the return should be false for this argument' do
        expect(test_array2.my_all?(/d/)).to eql(false)
      end
    end
    context 'Checking for mutuation' do
      it 'Should return the original array' do
        test_array1.my_all? { |num| num + 1 }
        expect(test_array1).to eq(test_array1_clone)
      end
    end
    context 'No block given' do
      it 'The return should be the same as the all? method' do
        expect(test_array2.my_all? { |word| word.length >= 3 }).to eq(test_array2.all? { |word| word.length >= 3 })
      end
    end
    context 'Checking for Integer' do
      it 'should return true if all condition mathces with the given case' do
        expect(test_array3.my_any? { |x| x.is_a?(Integer) }).to be true
      end
    end
  end
  #   my_any?
  describe '#my_any?' do
    context 'Argument is a Regexp' do
      it 'the return should be false for this argument' do
        expect(test_array2.my_any?(/d/)).to eql(false)
      end
    end
    context 'Checking for mutuation' do
      it 'Should return the original array' do
        test_array1.my_any? { |num| num + 1 }
        expect(test_array1).to eq(test_array1_clone)
      end
    end

    context 'No argument is given' do
      it 'The return should be the same as the all? method' do
        expect(test_array2.my_any? { |word| word.length >= 3 }).to eq(test_array2.any? { |word| word.length >= 3 })
      end
    end
    context 'Checking for Integer' do
      it 'should return true if any condition mathces with the given case' do
        expect(test_array3.my_any? { |x| x.is_a?(Integer) }).to be true
      end
    end
  end
  # my_none?

  describe '#my_none?' do
    it 'loops through the array with string elements and returns the boolean value of true or false based on given condtion' do
      expect(test_array2.my_none? { |word| word.size >= 5 }).to be(true)
    end

    it 'returns true if given case doesnt mathch with the element for every item.' do
      expect([9, 7.14, 8.91, 42].my_none?(Float)).to be(false)
    end

    it 'returns true when all the element in array are nil or false' do
      expect([nil, false].my_none?).to be(true)
    end

    it 'returns true when no block given and if no element of the array passed is equal to argument' do
      expect(test_array2.my_none?(10)).to be(true)
    end

    it 'it returns true when an empty array is given' do
      expect([].my_none?).to be(true)
    end

    it 'Should return the original array' do
      test_array1.my_each_with_index { |num| num + 1 }
      expect(test_array1).to eq(test_array1_clone)
    end

    it 'should return true if none of the condition mathces with the given case' do
      expect(test_array2.my_none? { |x| x.is_a?(Integer) }).to be true
    end
  end

  # my_map

  describe '#my_map' do
    it 'return a new array after executing the given condition for a block' do
      expect(test_array1.my_map { |item| item * 3 }).to eql([3, 6, 9, 15, 3, 21, 9])
    end

    it 'return a new array after executing the given condition for a range' do
      expect(range.my_map { |item| item * 2 }).to eql([2, 4, 6, 8, 10, 12, 14, 16, 18])
    end

    it 'return a new array after executing the given condition for a hash' do
      expect(hash.my_map { |_item, value| value * 2 }).to eql([200, 240, 300, 260])
    end

    it 'loops through the array and return a new array after executing the given proc' do
      expect([1, 2, 3, 4].my_map(&my_proc)).to eql([2, 3, 4, 5])
    end

    it 'when a block is not given then it return an enumerator' do
      expect(test_array1.my_map).to be_a(Enumerator)
    end
  end

  # my_count

  describe '#my_count' do
    it 'returns the number of items in array after looping through the array.' do
      expect(test_array1.my_count(&:odd?)).to eql(6)
    end

    it 'returns the number of items in the array that matches the argument.' do
      expect(test_array3.my_count(1)).to eql(3)
    end

    it 'counts the number of items that are present in the array, when a block is not given' do
      expect(test_array1.my_count).to eql(test_array1.length)
    end

    it 'counts the number of items that are present in the range when a block is not given and a range is given' do
      expect(range.my_count).to eql(range.count)
    end
  end

  # my_inject

  describe '#my_inject' do
    it 'returns the Sum of all the element of the array' do
      expect(test_array1.my_inject(:+)).to eql(22)
    end

    it 'returns the Sum of all the element of the range' do
      expect(range.my_inject { |total, item| total + item }).to eql(45)
    end

    it ' multiply numbers inside an array or range when an accumulator and a symbol are passed as arguments' do
      expect((1..10).my_inject(2, :*)).to eql(7_257_600)
    end

    it 'executes and return the result when an array or a range range is given with proc' do
      expect(test_array2.my_inject(&search)).to eql('bear')
    end
  end
end
