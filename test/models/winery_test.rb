require 'test_helper'

describe Winery do  

  subject { Winery.new }

  describe "db" do 

    describe "columns and types" do 

      it { must have_db_column(:name).of_type(:string) }
      it { must have_db_column(:producer_id).of_type(:integer) }
    end

    describe 'indexes' do 

      it { must have_db_index(:name).unique(true) }
      it { must have_db_index(:producer_id) }
    end
  end

  describe "validations" do

    it { must validate_presence_of(:name) }
  end

  describe "associations" do

    it { must belong_to(:producer) } 
    
    it { must have_many(:addresses_addressable) }
    it { must have_many(:addresses).through(:addresses_addressable) }
    it { must have_many(:accounts) }
    it { must have_many(:carousels) }
    it { must have_many(:certifications_holdable) }
    it { must have_many(:certifications).through(:certifications_holdable) }
    it { must have_many(:images) } 
    it { must have_many(:reviews).through(:wines) }
    it { must have_many(:wines) } 
  end

  describe "methods" do 

    Given(:winery) { FactoryGirl.create(:winery) }
    Given(:wine) { FactoryGirl.create(:wine, winery_id: winery.id) }
    Given(:second_wine) { FactoryGirl.create(:wine, winery_id: winery.id) }

    describe "winery rating when there are" do 
  
      Given!(:three_reviews) do 
        
        %w[85 90 95].each do |rating| 
          FactoryGirl.create(:review, rating: rating, wine_id: wine.id)
        end

        context "three reviews of a single wine" do
        
          # Then { winery.winery_rating.must eq 90}
        end
      end

      describe "three reviews of one and one review of another" do 

        Given(:fourth_review) { create(:review, rating: 50, wine_id: second_wine.id) }  
        # Then { assert_equal winery.winery_rating, 80 }
      end
    end
  end
end