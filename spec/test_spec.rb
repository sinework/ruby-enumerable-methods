require_relative "../script.rb"

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

# my_each
  describe '#my_each' do
    context 'No block given' do
      it 'should return an enumerable' do
        expect(test_array1.my_each).to be_a(Enumerable)
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

   # my_none?

  describe '#my_none?' do
    it "loops through the array with string elements and returns the boolean value of true or false based on given condtion" do
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
      expect(test_array1.my_map). to be_a(Enumerator)
    end
	end
end