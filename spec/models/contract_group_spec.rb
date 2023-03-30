require 'rails_helper'

RSpec.describe ContractGroup, type: :model do
  describe 'Association Test' do
    it { should belong_to(:group) }
    it { should belong_to(:contract) }
  end
end
