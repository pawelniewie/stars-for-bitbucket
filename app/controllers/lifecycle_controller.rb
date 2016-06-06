class LifecycleController < ApplicationController
	include AtlassianJwtAuthentication
	
	before_action :on_add_on_installed, only: [:installed]
	before_action :on_add_on_uninstalled, only: [:uninstalled]

	def installed
		begin
			if current_jwt_user.present? && current_jwt_user.present?
				token = get_access_token
				if token.success?
					user_email = HTTParty.get("#{current_jwt_auth.api_base_url}/2.0/user/emails", {
							headers: {
									'Authorization' => 'Bearer ' + token.data['access_token']
							}
					})
					if user_email.code == 200 && (user_email.parsed_response.is_a? Hash)
						emails = user_email.parsed_response['values']
						email = (emails.select { |email| email['is_confirmed'] && email['is_primary'] } \
							+ emails.select { |email| email['is_confirmed'] } \
							+ emails.select { |email| email['is_primary'] })
												.first['email']

						JwtUserInfo.create(jwt_user_id: current_jwt_user.id, email: email) if email.present?
					end
				end
			end
		rescue => error
			logger.error("Error getting user details #{error}: #{error.backtrace[0..5].join("\n")}")
		end

		head(:no_content)
	end

	def uninstalled
		head(:no_content)
	end

	def get_access_token
		unless current_jwt_auth
			raise 'Missing Authentication context'
		end

		# Expiry for the JWT token is 3 minutes from now
		issued_at = Time.now.utc.to_i
		expires_at = issued_at + 180

		jwt = JWT.encode({
												 iat: issued_at,
												 exp: expires_at,
												 iss: current_jwt_auth.addon_key,
												 sub: current_jwt_auth.client_key
										 }, current_jwt_auth.shared_secret)

		response = HTTParty.post("#{current_jwt_auth.base_url}/site/oauth2/access_token", {
				body: {grant_type: 'urn:bitbucket:oauth2:jwt'},
				headers: {
						'Content-Type' => 'application/x-www-form-urlencoded',
						'Authorization' => 'JWT ' + jwt
				}
		})

		if response.code == 200
			Response.new(200, response.parsed_response)
		else
			Response.new(response.code)
		end
	end

end
