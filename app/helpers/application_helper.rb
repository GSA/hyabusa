module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.simple_fields_for(association, new_object, child_index: id, html: { class: '.form-inline' }) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def gravatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)

    if ENV['RAILS_ENV'] == 'production'
      default = "#{root_url}assets/guest.png"
      default = CGI.escape(default)
    else
      default = 'blank'
    end

    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{default}"
  end
end
