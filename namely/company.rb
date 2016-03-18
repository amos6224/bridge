class Company < ActiveRecord::Base
  def to_json
    {
      id: permalink,
      permalink: permalink,
      name: name,
      created_at: created_at,
    }
  end
end
