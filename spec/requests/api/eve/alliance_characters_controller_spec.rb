# frozen_string_literal: true

require 'rails_helper'

describe Api::Eve::AllianceCharactersController do
  describe '#index' do
    it 'returns list of Eve Alliance Characters' do
      create(:eve_alliance,
             alliance_id: 123,
             creator_corporation_id: 2222,
             creator_id: 3333,
             date_founded: 'Sun, 03 May 2015 19:45:17 UTC +00:00',
             executor_corporation_id: 4444,
             faction_id: 5555,
             name: 'Alliance name',
             ticker: 'ALLIANCE_TICKER')

      create(:eve_corporation,
             alliance_id: 123,
             corporation_id: 456,
             name: 'Character corporation name',
             description: 'Character corporation description',
             ticker: 'TICKER',
             date_founded: 'Sun, 03 May 2015 19:45:17 UTC +00:00',
             corporation_url: 'https://evemonk.com/',
             member_count: 2000,
             shares: 1000,
             tax_rate: 0.99,
             ceo_id: 1234,
             creator_id: 4321,
             faction_id: 777,
             home_station_id: 999)

      create(:eve_alliance_corporation,
             alliance_id: 123,
             corporation_id: 456)

      create(:eve_character,
             alliance_id: 123,
             character_id: 123_123_123,
             corporation_id: 456,
             ancestry_id: 10,
             name: 'Character name',
             description: 'Character description',
             gender: 'male',
             birthday: 'Sun, 03 May 2015 19:45:17 UTC +00:00',
             security_status: 1.1)

      create(:eve_ancestry,
             ancestry_id: 10,
             name: 'Ancestry name',
             bloodline_id: 12,
             description: 'Ancestry description',
             short_description: 'Ancestry short description',
             icon_id: 14)

      get '/api/eve/alliances/123/characters'

      expect(response).to have_http_status(:ok)

      puts JSON.parse(response.body)

      expect(JSON.parse(response.body)).to eq('total_count' => 1,
                                              'total_pages' => 1,
                                              'current_page' => 1,
                                              'characters' => [{
                                                'id' => 123_123_123,
                                                'icon' => 'https://imageserver.eveonline.com/Character/123123123_512.jpg',
                                                'birthday' => '2015-05-03T19:45:17Z',
                                                'description' => 'Character description',
                                                'gender' => 'male',
                                                'name' => 'Character name',
                                                'security_status' => '1.1',
                                                'alliance' => {
                                                  'id' => 123,
                                                  'creator_corporation_id' => 2222,
                                                  'creator_id' => 3333,
                                                  'date_founded' => '2015-05-03 19:45:17 UTC',
                                                  'executor_corporation_id' => 4444,
                                                  'faction_id' => 5555,
                                                  'name' => 'Alliance name',
                                                  'ticker' => 'ALLIANCE_TICKER'
                                                },
                                                'ancestry' => {
                                                  'id' => 10,
                                                  'name' => 'Ancestry name',
                                                  'bloodline_id' => 12,
                                                  'description' => 'Ancestry description',
                                                  'short_description' => 'Ancestry short description',
                                                  'icon_id' => 14
                                                },
                                                'corporation' => {
                                                  'id' => 456,
                                                  'name' => 'Character corporation name',
                                                  'description' => 'Character corporation description',
                                                  'ticker' => 'TICKER',
                                                  'date_founded' => '2015-05-03T19:45:17Z',
                                                  'url' => 'https://evemonk.com/',
                                                  'member_count' => 2000,
                                                  'shares' => 1000,
                                                  'tax_rate' => '0.99',
                                                  'alliance_id' => 123,
                                                  'ceo_id' => 1234,
                                                  'creator_id' => 4321,
                                                  'faction_id' => 777,
                                                  'home_station_id' => 999
                                                }
                                              }])
    end
  end
end
