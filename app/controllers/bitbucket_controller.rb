class BitbucketController < ApplicationController

	def descriptor
		render :descriptor, locals: { 
			base_url: 'https://' + ApplicationController.renderer.defaults[:http_host],
			plugin_key: PluginKeyService::PLUGIN_KEY,
      client_id: Rails.application.secrets.client_id,
			plugin_name: 'Stars for BitBucket' + (Rails.env.production? ? '' : ' [Development]')
		}
	end

end
