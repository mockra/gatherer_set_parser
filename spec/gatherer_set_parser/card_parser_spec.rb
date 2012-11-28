require 'gatherer_set_parser_spec'
require 'fakeweb'

describe GathererSetParser::CardParser do

  let(:parsed_card) { GathererSetParser::CardParser.new card }

  describe '#parse_card' do
    let(:card) { Nokogiri::HTML open('spec/support/flipped_creature.html') }

    it 'should return a hash' do
      parsed_card.attributes.should be_a Hash
    end

    it 'should have a title' do
      parsed_card.attributes[:title].should_not be_nil
    end
  end

  describe '#card_attributes' do
    context 'back of flip card' do
      let(:card) { Nokogiri::HTML open('spec/support/flipped_creature.html') }

      it 'should return the correct title' do
        parsed_card.title.should == "Tovolar's Magehunter"
      end

      it 'should return a card type' do
        parsed_card.type.should == 'Creature'
      end

      it 'should match the species type' do
        parsed_card.sub_type.should == 'Werewolf'
      end

      it 'should have the correct power' do
        parsed_card.power.should == 5
      end

      it 'should have the correct toughness' do
        parsed_card.toughness.should == 5
      end

      it 'should have no loyalty' do
        parsed_card.loyalty.should be_nil
      end

      it 'should have a cmc' do
        parsed_card.cmc.should == 0
      end

      it 'should have the correct rarity' do
        parsed_card.rarity.should == 'Rare'
      end

      it 'should have text' do
        parsed_card.text.should =~ /transform/i
      end

      it 'should have the correct mana cost' do
        parsed_card.mana_cost.should == []
      end

      it 'should have the correct image url' do
        parsed_card.image_url.should =~
          /\/Handlers\/Image\.ashx\?multiverseid\=253429\&type\=card/
      end
    end

    context 'an instant/sorcery' do
      let(:card) { Nokogiri::HTML open('spec/support/instant.html') }

      it 'should have no power' do
        parsed_card.power.should be_nil
      end

      it 'should have no loyalty' do
        parsed_card.loyalty.should be_nil
      end

      it 'should have the correct type' do
        parsed_card.type.should == 'Instant'
      end

      it 'should have the correct rarity' do
        parsed_card.rarity.should == 'Uncommon'
      end

      it 'should have the correct mana cost' do
        parsed_card.mana_cost.should == %w[1 U]
      end

      it 'should have no sub type' do
        parsed_card.sub_type.should be_nil
      end
    end

    context 'land' do
      let(:card) { Nokogiri::HTML open('spec/support/land.html') }

      it 'should have the correct mana cost' do
        parsed_card.mana_cost.should == []
      end

      it 'should have no power' do
        parsed_card.power.should be_nil
      end
    end

    context 'planeswalker' do
      let(:card) { Nokogiri::HTML open('spec/support/planeswalker.html') }

      it 'should have a title' do
        parsed_card.title.should =~ /Tamiyo/i
      end

      it 'should have no power' do
        parsed_card.power.should be_nil
      end

      it 'should have no toughness' do
        parsed_card.power.should be_nil
      end

      it 'should have loyalty' do
        parsed_card.loyalty.should == 4
      end

      it 'should have the correct type' do
        parsed_card.type.should == 'Planeswalker'
      end

      it 'should have the correct rarity' do
        parsed_card.rarity.should == 'Mythic Rare'
      end

      it 'should have the correct mana cost' do
        parsed_card.mana_cost.should == %w[3 U U]
      end

      it 'should have correct gatherer url' do
        parsed_card.gatherer_url.should =~
          /Card\/Details\.aspx\?multiverseid\=240070/
      end
    end

    context 'phyrexian' do
      let(:card) { Nokogiri::HTML open('spec/support/phyrexia.html') }

      it 'should have the correct mana cost' do
        parsed_card.mana_cost.should == %w[X G/P]
      end
    end

    context 'enchant' do
      let(:card) { Nokogiri::HTML open('spec/support/enchant.html') }

      it 'should have the correct mana cost' do
        parsed_card.mana_cost.should == %w[4 B B]
      end
    end

    context 'gold' do
    end

    context 'dual_land' do
      let(:card) { Nokogiri::HTML open('spec/support/dual_land.html') }

      it 'should have the correct text' do
        parsed_card.text.should =~ /U/i
      end
    end

    context 'legendary' do
    end

    context 'artifact' do
    end
  end

end
