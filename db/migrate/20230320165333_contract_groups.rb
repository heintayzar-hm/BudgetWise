class ContractGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :contract_groups do |t|
      t.references :contract, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.timestamps
    end
  end
end
