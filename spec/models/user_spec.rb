require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Association Test' do
    it { should have_many(:groups).dependent(:destroy) }
    it { should have_many(:contracts).dependent(:destroy) }
  end

  describe 'Validation Test' do
    it { should validate_presence_of(:name) }
  end
end
