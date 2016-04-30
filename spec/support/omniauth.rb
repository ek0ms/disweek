def set_omniauth(opts = {})
  default = { provider: "instagram",
              uid: "1234",
              info: {
                nickname: "instajeff",
                image: "https://scontent.cdninstagram.com/t51.2885-19/s150x150/13129995_1532469667058834_410948918_a.jpg"
              }
            }

  credentials = default.merge(opts)
  provider = credentials[:provider]
  user_hash = credentials[provider]

  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
    uid: credentials[:uid],
    info: {
      nickname: "instajeff",
      image: "https://scontent.cdninstagram.com/t51.2885-19/s150x150/13129995_1532469667058834_410948918_a.jpg"
    }
  })
end

def set_invalid_omniauth(opts = {})

  credentials = { :provider => :instagram,
                  :invalid  => :invalid_crendentials
                 }.merge(opts)

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]
end
