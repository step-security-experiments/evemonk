# frozen_string_literal: true

require "administrate/base_dashboard"

class CharacterDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    # user: Field::BelongsTo,
    # race: Field::BelongsTo.with_options(class_name: "Eve::Race"),
    # bloodline: Field::BelongsTo.with_options(class_name: "Eve::Bloodline"),
    # faction: Field::BelongsTo.with_options(class_name: "Eve::Faction"),
    # ancestry: Field::BelongsTo.with_options(class_name: "Eve::Ancestry"),
    # alliance: Field::BelongsTo.with_options(class_name: "Eve::Alliance"),
    # corporation: Field::BelongsTo.with_options(class_name: "Eve::Corporation"),
    # current_ship_type: Field::BelongsTo.with_options(class_name: "Eve::Ship"),
    # current_solar_system: Field::BelongsTo.with_options(class_name: "Eve::System"),
    # current_station: Field::BelongsTo.with_options(class_name: "Eve::Station"),
    # wallet_journals: Field::HasMany,
    # wallet_transactions: Field::HasMany,
    # industry_jobs: Field::HasMany,
    name: Field::String,
    birthday: Field::DateTime,
    gender: Field::String,
    description: Field::Text,
    security_status: Field::String.with_options(searchable: false),
    wallet: Field::Number.with_options(decimals: 2),
    charisma: Field::Number,
    intelligence: Field::Number,
    memory: Field::Number,
    perception: Field::Number,
    willpower: Field::Number,
    bonus_remaps: Field::Number,
    last_remap_date: Field::DateTime,
    accrued_remap_cooldown_date: Field::DateTime,
    character_id: Field::Number,
    alliance_id: Field::Number,
    corporation_id: Field::Number,
    race_id: Field::Number,
    bloodline_id: Field::Number,
    ancestry_id: Field::Number,
    faction_id: Field::Number,
    scopes: Field::Text,
    character_owner_hash: Field::String,
    title: Field::String,
    current_solar_system_id: Field::Number,
    current_station_id: Field::Number,
    current_structure_id: Field::Number,
    current_ship_item_id: Field::Number,
    current_ship_name: Field::String,
    current_ship_type_id: Field::Number,
    total_sp: Field::Number,
    unallocated_sp: Field::Number,
    total_unread_count: Field::Number,
    last_clone_jump_date: Field::DateTime,
    last_station_change_date: Field::DateTime,
    esi_token_valid: Field::Boolean,
    esi_token_invalid_at: Field::DateTime,
    esi_last_error: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = [
    # :user,
    :character_id,
    :name,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    # :user,
    # :race,
    # :bloodline,
    # :faction,
    # :ancestry,
    # :alliance,
    # :corporation,
    # :current_ship_type,
    # :current_solar_system,
    # :current_station,
    # :wallet_journals,
    # :wallet_transactions,
    # :industry_jobs,
    :id,
    :name,
    :birthday,
    :gender,
    :description,
    :security_status,
    :wallet,
    :charisma,
    :intelligence,
    :memory,
    :perception,
    :willpower,
    :bonus_remaps,
    :last_remap_date,
    :accrued_remap_cooldown_date,
    :character_id,
    :alliance_id,
    :corporation_id,
    :race_id,
    :bloodline_id,
    :ancestry_id,
    :faction_id,
    :title,
    :current_solar_system_id,
    :current_station_id,
    :current_structure_id,
    :current_ship_item_id,
    :current_ship_name,
    :current_ship_type_id,
    :total_sp,
    :unallocated_sp,
    :total_unread_count,
    :last_clone_jump_date,
    :last_station_change_date,
    :esi_token_valid,
    :esi_token_invalid_at,
    :esi_last_error,
    :created_at,
    :updated_at
  ].freeze

  FORM_ATTRIBUTES = [
    # :user,
    # :race,
    # :bloodline,
    # :faction,
    # :ancestry,
    # :alliance,
    # :corporation,
    # :current_ship_type,
    # :current_solar_system,
    # :current_station,
    :name,
    :birthday,
    :gender,
    :description,
    :security_status,
    :wallet,
    :charisma,
    :intelligence,
    :memory,
    :perception,
    :willpower,
    :bonus_remaps,
    :last_remap_date,
    :accrued_remap_cooldown_date,
    :character_id,
    :alliance_id,
    :corporation_id,
    :race_id,
    :bloodline_id,
    :ancestry_id,
    :faction_id,
    :scopes,
    :character_owner_hash,
    :title,
    :current_solar_system_id,
    :current_station_id,
    :current_structure_id,
    :current_ship_item_id,
    :current_ship_name,
    :current_ship_type_id,
    :total_sp,
    :unallocated_sp,
    :total_unread_count,
    :last_clone_jump_date,
    :last_station_change_date,
    :esi_token_valid,
    :esi_token_invalid_at,
    :esi_last_error
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
