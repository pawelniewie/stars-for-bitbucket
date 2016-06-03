class AllStarsController < ApplicationController

  include AtlassianJwtAuthentication

  # will respond with head(:unauthorized) if verification fails
  before_action only: [:show] do |controller|
    controller.send(:verify_jwt, PluginKeyService::PLUGIN_KEY)
  end

  def show
    render :show, locals: {
        repos: Repo.where(jwt_token_id: current_jwt_auth.id).order(:repo_name).all,
        base_url: current_jwt_auth.base_url
    }
  end

end