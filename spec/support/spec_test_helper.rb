module SpecTestHelper

  def json
    JSON.parse(response.body)
  end
  
end
