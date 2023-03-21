require 'rails_helper'

RSpec.describe Contract, type: :model do
  describe 'Association Test' do
    it { should belong_to(:author) }
    it { should have_many(:contract_groups).dependent(:destroy) }
    it { should have_many(:groups).through(:contract_groups) }
  end

  describe 'Validation Test' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:amount) }
  end
end
