module ApplicationHelper
    def gravatar_for(blogger, options= { size: 80})
        email_address = "test@example.com"
        hash = Digest::MD5.hexdigest(email_address)
        size = options[:size]
        gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
        image_tag(gravatar_url, alt: email_address, class:"rounded shadow mx-auto d-block")
    end

end