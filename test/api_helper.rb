def get_kid(kid, auth_token=nil)
  get "/api/v1/kids/#{kid.id}", build_headers(auth_token)
end

def get_kids(auth_token=nil)
  get "/api/v1/kids", build_headers(auth_token)
end

def create_kid(kid, auth_token=nil)
  post '/api/v1/kids', kid.attributes, build_headers(auth_token)
end

def update_kid(kid, auth_token=nil)
  patch "/api/v1/kids/#{kid.id}", kid.attributes, build_headers(auth_token)
end

def delete_kid(kid, auth_token=nil)
  delete "/api/v1/kids/#{kid.id}", {}, build_headers(auth_token)
end

def build_headers(auth_token)
  headers = { 'Accept' => Mime::JSON }
  headers['Authorization'] = "Token token=#{auth_token}" unless auth_token.nil?
  headers
end
