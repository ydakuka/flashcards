require 'rails_helper'

describe 'External request' do
  describe 'search queries FactoryGirl users on Flickr' do
    let(:required_hash_keys) { ["id", "secret", "server", "farm", "title"] }

    before(:each) do
      uri = URI('https://api.flickr.com/services/rest/?method=flickr.photos.search')
      response = Net::HTTP.get(uri)
      @data_hash = JSON.parse(response)
    end

    it 'returns a hash of photos' do
      expect(@data_hash).to be_instance_of(Hash)
    end

    it "returns success status" do
      expect(@data_hash["stat"]).to eq("ok")
    end

    it "returns 10 elements" do
      data = @data_hash["photos"]["photo"]
      expect(data.count).to eq(10)
    end

    it "must have some keys for image" do
      data = @data_hash["photos"]["photo"]
      first_photo = data.first
      expect(first_photo.keys).to include(*required_hash_keys)
    end
  end
end
