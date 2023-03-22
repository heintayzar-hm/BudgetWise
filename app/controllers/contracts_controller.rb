class ContractsController < ApplicationController
  load_and_authorize_resource param_method: :contract, only: %i[create]

  def new
    @contract = Contract.new
    @groups = current_user.groups
  end

  def create
    @contract = current_user.contracts.build(contract_params)
    @group = Group.find(params[:contract][:group_id])

    if @contract.save
      @contract.groups << @group
      redirect_to root_path
      flash[:success] = "Transcation created successfully"
    else
      @groups = current_user.groups
      render :new
      flash[:error] = "Transcation creation failed"
    end
  end

  private
  def contract_params
    params.require(:contract).permit(:name, :amount).merge(group_id: params[:contract][:group_id])
  end

end
