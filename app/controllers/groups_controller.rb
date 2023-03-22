class GroupsController < ApplicationController
  load_and_authorize_resource :group, only: [:create]

  def index
    @groups = sorting_handler(current_user.groups.all, params.permit(:sortBy, :sortOrder))
    @groups = @groups.includes(icon_attachment: :blob)
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)
    @group.icon.attach(params[:group][:icon])
    if @group.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @group = Group.find_by(id: params[:id])
    return redirect_to root_path if @group.blank?

    @contracts = sorting_handler(@group.contracts, params.permit(:sortBy, :sortOrder))
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def sorting_handler(obj, options = {})
    sort_by = options[:sortBy].presence || :name
    sort_order = options[:sortOrder].presence || :asc

    if %w[name created_at updated_at].include?(sort_by) &&
       %w[asc desc].include?(sort_order)
      obj.order("#{sort_by} #{sort_order}")
    else
      obj.order('updated_at desc') # Default sorting
    end
  end
end
