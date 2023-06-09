class ContractsController < ApplicationController
  load_and_authorize_resource :contract, only: %i[create]

  def new
    @contract = Contract.new
    @groups = current_user.groups
  end

  def create
    @contract = current_user.contracts.build(contract_params)
    @group = Group.find_by(id: params[:contract][:group_id])

    if @contract.save
      @contract.groups << @group
      flash[:notice] = 'Transaction created successfully.'

      redirect_to root_path
    else
      @groups = current_user.groups
      flash[:alert] = 'Transaction creation failed'
      render :new
    end
  end

  private

  def contract_params
    params.require(:contract).permit(:name, :amount, :group_id)
  end
end
