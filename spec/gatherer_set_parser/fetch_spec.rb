require 'gatherer_set_parser_spec'

describe GathererSetParser::Fetch do

  let(:gatherer) { GathererSetParser::Fetch.new 'Dark Ascension' }

  describe '.new' do
    it 'should assign the set_name' do
      gatherer.set_name.should == 'Dark Ascension'
    end
  end

  describe '#response_body' do
    use_vcr_cassette 'dark_ascension'

    it 'should contain every page' do
      gatherer.complete_set.count.should == 7
    end

    it 'should contain a magic card' do
      gatherer.complete_set.last.text.should =~ /wakedancer/i
    end

    it 'should have the complete set of cards' do
      gatherer.cards.count.should == 171
    end
  end

end

