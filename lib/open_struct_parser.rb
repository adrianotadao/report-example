class OpenStructParser < HTTParty::Parser
  def parse
    return if body.nil?
    JSON.parse(body, object_class: OpenStruct)
  end
end
