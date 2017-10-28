require 'spec_helper'

RSpec.describe Rsteamshot::Screenshot do
  let(:title) { 'A NEW HAND TOUCHED THE BEACON' }
  let(:details_url) { 'http://steamcommunity.com/sharedfiles/filedetails/?id=789436652' }
  subject(:screenshot) { described_class.new(title, details_url) }

  context '#get_details' do
    it 'populates other fields' do
      VCR.use_cassette('screenshot_get_details') do
        screenshot.get_details

        expect(screenshot.full_size_url).to eq('https://steamuserimages-a.akamaihd.net/ugc/230074563809665585/590A645C1B9155C2742484ED2B66F60CE2A62DD8/')
        expect(screenshot.medium_url).to eq('https://steamuserimages-a.akamaihd.net/ugc/230074563809665585/590A645C1B9155C2742484ED2B66F60CE2A62DD8/?interpolation=lanczos-none&output-format=jpeg&output-quality=95&fit=inside|1024:576&composite-to%3D%2A%2C%2A%7C1024%3A576&background-color=black')
        expect(screenshot.user_name).to eq('cheshire137')
        expect(screenshot.user_url).to eq('http://steamcommunity.com/id/cheshire137')
        expect(screenshot.date).to eq(DateTime.parse('2016-10-29 9:45'))
      end
    end
  end
end
