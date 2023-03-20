class ContractGroup < ApplicationRecord
  belongs_to :group, foreign_key: 'group_id'
  belongs_to :contract, foreign_key: 'contract_id'
end
