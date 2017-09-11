class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    if current_user.present?
      collaborators = []
      @wiki.collaborators.each do |collaborator|
        collaborators << collaborator.email
      end
      unless (@wiki.private == false) || (@wiki.private == nil) || current_user.premium? || current_user.admin?
        flash[:alert] = "You Must be a Premium User to Browse Private Wikis."
        if current_user
          redirect_to new_charge_path
        else
          redirect_to new_user_registration_path
        end
      end
    end
  end

  def new
    @wiki = Wiki.new
    # authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    # authorize @wiki

    if @wiki.save
      @wiki.collaborators = Collaborator.update_collaborators(params[:wiki][:collaborators])
      flash[:notice] = 'Wiki was Saved!.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an Error Saving Your Wiki. Please Try Again Later'
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki.assign_attributes(wiki_params)
    authorize @wiki

    if @wiki.save && (@wiki.user == current_user || current_user.admin?)
      @wiki.collaborators = Collaborator.update_collaborators(params[:wiki][:collaborators])
      flash[:notice] = 'Wiki Has Been Updated!.'
      redirect_to @wiki
    elsif @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an Error Updating Your Wiki. Please Try Again Later'
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
