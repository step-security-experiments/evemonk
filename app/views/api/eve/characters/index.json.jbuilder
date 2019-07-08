# frozen_string_literal: true

json.total_count @characters.total_count
json.total_pages @characters.total_pages
json.current_page @characters.current_page
json.characters do
  json.array! @characters do |character|
    json.id character.character_id
    json.icon character.icon
    json.birthday character.birthday
    json.description character.description
    json.gender character.gender
    json.name character.name
    json.security_status character.security_status
    json.title character.title

    if character.alliance
      json.partial! partial: 'api/eve/shared/alliance', locals: { faction: character.alliance }
    end

    if character.ancestry
      json.partial! partial: 'api/eve/shared/ancestry', locals: { ancestry: character.ancestry }
    end

    if character.bloodline
      json.partial! partial: 'api/eve/shared/bloodline', locals: { bloodline: character.bloodline }
    end

    if character.corporation
      json.corporation do
        json.id character.corporation.corporation_id
        json.name character.corporation.name
        json.description character.corporation.description
        json.ticker character.corporation.ticker
        json.date_founded character.corporation.date_founded
        json.url character.corporation.corporation_url
        json.member_count character.corporation.member_count
        json.shares character.corporation.shares
        json.tax_rate character.corporation.tax_rate
        json.alliance_id character.corporation.alliance_id
        json.ceo_id character.corporation.ceo_id
        json.creator_id character.corporation.creator_id
        json.faction_id character.corporation.faction_id
        json.home_station_id character.corporation.home_station_id
      end
    end

    if character.faction
      json.partial! partial: 'api/eve/shared/faction', locals: { faction: character.faction }
    end

    if character.race
      json.partial! partial: 'api/eve/shared/race', locals: { race: character.race }
    end
  end
end
