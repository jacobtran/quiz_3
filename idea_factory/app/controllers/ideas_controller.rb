class IdeasController < ApplicationController
  # this `before_action` will call the `find_idea` method before executing
  # any other action.
  # we can specify :only or :except to be more speicfic about the actions
  # which the before_action apply to
  # before_action :find_idea, except: [:new, :create, :index]
  before_action :find_idea, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user, except: [:index, :show]

  before_action :authorize_user, only: [:edit, :update, :destroy]

  def new
    @idea = Idea.new
  end

  def create
    # params => {"idea"=>{"title"=>"hello world", "body"=>"something here"}}
    # idea       = Idea.new
    # idea.title = params[:idea][:title]
    # idea.body  = params[:idea][:body]

    @idea      = Idea.new idea_params
    @idea.user = current_user
    if @idea.save
      # all these formats are possible ways to redirect in Rails:
      # redirect_to idea_path({id: @idea.id})
      # redirect_to idea_path({id: @idea})
      # redirect_to @idea
      flash[:notice] = "Idea Created Successfully!"
      redirect_to idea_path(@idea)
    else
      # This will render app/views/ideas/new.html.erb template
      # we need to be explicit about rendering the new template becuase the
      # default behaviour is to render `create.html.erb`
      # you can specify full path such as: render "/ideas/new"
      flash[:alert] = "Idea wasn't created. Check errors below"
      render :new
    end
  end

  # GET: /ideas/13
  def show
    @idea.view_count += 1
    @idea.save
    @comment = Comment.new
  end

  def index
    @ideas = Idea.all
  end

  def edit
  end

  def update
    # We call the update with sanitized params
    if @idea.update idea_params
      # we redirect to the idea show page
      redirect_to(idea_path(@idea), {notice: "Idea updated!"})
    else
      render :edit
    end
  end

  def destroy
    @idea.destroy
    # we redirect to the index page
    redirect_to ideas_path, notice: "Idea deleted!"
  end

  private

  def idea_params
    # using params. require ensures that there is a key called `idea` in my
    # params. the `permit` method will only allow paramsters that you explicitly
    # list, in this case: title and body
    # this is called Strong Paramters
    
    # params.require(:idea).permit([:title, :body, :image])
    params.require(:idea).permit([:title, :body, :category_id, {tag_ids: []}])
  end

  def find_idea
    @idea = Idea.find params[:id]
  end

  def authorize_user
    unless can? :manage, @idea
      redirect_to root_path, alert: "access denied!"
    end
  end

end
