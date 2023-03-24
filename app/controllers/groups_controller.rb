class GroupsController < ApplicationController
  load_and_authorize_resource :group, only: [:create]
  def index
    @groups = sorting_handler(current_user.groups.all.includes(icon_attachment: :blob), params.permit(:sortBy,:id, :sortOrder))

  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)
    @group.icon.attach(params[:group][:icon])
    if @group.save
      flash[:notice] = "Group was successfully created."

      redirect_to root_path
    else
      flash[:alert] = "Group creation failed"

      render :new
    end
  end

  def show
    @group = Group.find_by(id: params[:id])
    return redirect_to root_path if @group.blank?

    @contracts = sorting_handler(@group.contracts, params.permit(:sortBy, :sortOrder, :id))
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end

  def sorting_handler(obj, options = {})
    sort_by = options[:sortBy].presence || :name
    sort_order = options[:sortOrder].presence || :asc
    if %w[name created_at updated_at].include?(sort_by) &&
       %w[asc desc].include?(sort_order)
      obj.order("#{sort_by} #{sort_order}")
    elsif sort_by == 'amount' &&  %w[asc desc].include?(sort_order) && obj.first.model_name == 'Contract'
      obj.order("amount #{sort_order} nulls last")
    elsif sort_by == 'amount' &&  %w[asc desc].include?(sort_order) && obj.first.model_name == 'Group'
      return obj.sort_by { |group| group.total }.reverse if sort_order == 'desc'
      return obj.sort_by { |group| group.total } if sort_order == 'asc'
    else
      obj.order('updated_at desc') # Default sorting
    end
  end
end
