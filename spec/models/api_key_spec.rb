require 'rails_helper'

describe ApiKey do
  it { should belong_to(:user) }

  it { should validate_presence_of(:user) }

  it { should validate_presence_of(:key_id) }

  it { should validate_presence_of(:v_code) }
end
