require 'gatherer_set_parser_spec'

describe GathererSetParser::QueryString do

  let(:gatherer) { GathererSetParser::Fetch.new 'Dark Ascension' }

  describe '#escaped_set' do
    it 'should escape set_name to query string' do
      gatherer.escaped_set.should == 'Dark%20Ascension'
    end
  end

  describe '#query_string' do
    it 'should contain the entire query' do
      gatherer.query_string.should ==
        'output=standard&set=[%22Dark%20Ascension%22]'
    end
  end

end

