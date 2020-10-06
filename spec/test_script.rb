require_relative "../script.rb"

describe Enumerable do

    let(:test_array1) { [1, 2, 3, 5, 1, 7, 3] }
    let(:test_array2) { %w[ant bear cat] }
    let(:test_array3) { [1, 1, 1] }
    let(:test_array4) { [1, 1, nil] }
    let(:test_array5) { [nil, false, nil] }
    let(:my_proc) { proc { |x| x + 1 } }
    let(:my_block) { |sum, i| sum + i }

    describe "#my_each" do
        context "No block given"
        # it "the return should be enumerable" do
        #     expect (test_array1.my_each).to be_a(Enumerable)
        # end
        context "Block given"
        it "The return should be the same as the each method" do
            expect(test_array1.my_each {|x| puts x}).to eq(test_array1.each {|x| puts x})
        end

    end
end