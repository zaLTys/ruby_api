
# frozen_string_literal: true

module Api
  module V1
    class WikiPostsController < ApplicationController
      include LoggingModule
      def index
        data = {}
        WikiPost.includes(:wiki_post_record).each do |post|
          data[post.id] = post.wiki_post_record.data
        end
        final = WikiPostSerializer.serialize(data)
        render json: final
      rescue StandardError => e

        final = WikiPostSerializer.serialize(data)
        render json: final
      rescue StandardError => e
        binding.debugger
        render json: "Error: #{e.message}"
      end
    end
  end
end
