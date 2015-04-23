def create_user(user)
  post '/api/v1/users', user
end

def update_user(user, auth_token=nil)
  patch "/api/v1/users/#{user[:id]}", user.to_json, build_headers(auth_token)
end

def create_session(user)
  post '/api/v1/sessions', user
end

def get_kid(kid, auth_token=nil)
  get "/api/v1/kids/#{kid.id}", {}, build_headers(auth_token)
end

def get_kids(auth_token=nil)
  get "/api/v1/kids", {}, build_headers(auth_token)
end

def create_kid(kid, auth_token=nil)
  post '/api/v1/kids', kid.attributes.to_json, build_headers(auth_token)
end

def update_kid(kid, auth_token=nil)
  patch "/api/v1/kids/#{kid.id}", kid.attributes.to_json, build_headers(auth_token)
end

def delete_kid(kid, auth_token=nil)
  delete "/api/v1/kids/#{kid.id}", {}, build_headers(auth_token)
end

def build_headers(auth_token)
  headers = { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
  headers[:authorization] = "Token token=#{auth_token}" unless auth_token.nil?
  headers
end
