module PluginKeyService

	PLUGIN_KEY = 'stars' + (Rails.env.production? ? '' :  '.' + Rails.env)

end