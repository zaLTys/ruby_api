# frozen_string_literal: true

class WikiPostSerializer
  def self.serialize(data)
    final = {}
    #binding.debugger
    final['records'] = data.count
    final['results'] = data

    final.to_json
  end
end
