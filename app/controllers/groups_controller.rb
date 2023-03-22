class GroupsController < ApplicationController
  load_and_authorize_resource :group, only: [:create]

  def index
    @groups = sort_groups(current_user.groups.all,params.permit(:sortBy, :sortOrder))
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

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def sort_groups(groups, options = {})
    sort_by = options[:sortBy].presence || :name
    sort_order = options[:sortOrder].presence || :asc

    if %w[name created_at updated_at].include?(sort_by) &&
        %w[asc desc].include?(sort_order)
      groups.order("#{sort_by} #{sort_order}")
    else
      groups.order(:name) # Default sorting
    end
  end
end
