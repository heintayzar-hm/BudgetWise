class GroupsController < ApplicationController
  load_and_authorize_resource :group, only: [:create]
  def index
    @groups = sorting_handler(current_user.groups.all.includes(icon_attachment: :blob),
                              params.permit(:sortBy, :id, :sortOrder))
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)
    @group.icon.attach(params[:group][:icon])
    if @group.save
      flash[:notice] = 'Group was successfully created.'

      redirect_to root_path
    else
      flash[:alert] = 'Group creation failed'

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

    case sort_by.to_sym
    when :name, :created_at, :updated_at
      sort_by_default(obj, sort_by, sort_order)
    when :amount
      sort_by_amount(obj, sort_order)
    else
      obj.order('updated_at desc') # Default sorting
    end
  end

  def sort_by_default(obj, sort_by, sort_order)
    if %w[asc desc].include?(sort_order)
      obj.order("#{sort_by} #{sort_order}")
    else
      obj.order("#{sort_by} asc") # Default sort order
    end
  end

  def sort_by_amount(obj, sort_order)
    if obj.first.model_name == 'Contract'
      obj.order("amount #{sort_order} nulls last")
    elsif obj.first.model_name == 'Group'
      obj = obj.sort_by(&:total)
      obj = obj.reverse if sort_order == 'desc'
      obj
    else
      obj.order('updated_at desc') # Default sorting
    end
  end
end
