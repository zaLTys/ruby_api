# frozen_string_literal: true

module Api
  module V1
    class WikiPostsController < ActionController::API
      include ActionController::HttpAuthentication::Token::ControllerMethods
      require 'csv'
      # skip_before_action :verify_authenticity_token
      before_action :authenticate

      TOKEN = ENV['WIKI_API_KEY']

      include LoggingModule

      def show
        @wiki_post = WikiPost.find(params[:id])
        render json: @wiki_post
      end

      def create
        @wiki_post = WikiPost.new(wiki_post_params)

        if @wiki_post.save
          render json: @wiki_post, status: :created
        else
          render json: @wiki_post.errors, status: :unprocessable_entity
        end
      end

      def update
        @wiki_post = WikiPost.find(params[:id])

        if @wiki_post.update(wiki_post_params)
          render json: @wiki_post, status: :ok
        else
          render json: @wiki_post.errors, status: :unprocessable_entity
        end

      end

      def destroy
        @wiki_post = WikiPost.find(params[:id])
        @wiki_post.destroy
        head :no_content
      end

      def index
        @wiki_posts = WikiPost.all
        render json: @wiki_posts
      end

      def csv_index
        @wiki_posts = WikiPost.all
        csv_data = CSV.generate do |csv|
          csv << ["ID", "Title", "Description", "Author"]
          @wiki_posts.each do |post|
            csv << [post.id, post.title, post.description, post.author]
          end
        end
        send_data csv_data, filename: "wiki_posts.csv", type: "text/csv"
      end

      # def index
      #   data = {}
      #   WikiPost.includes(:wiki_post_record).each do |post|
      #     data[post.id] = post.wiki_post_record.data
      #   end
      #   final = WikiPostSerializer.serialize(data)
      #   render json: final
      # rescue StandardError => e
      #
      #   final = WikiPostSerializer.serialize(data)
      #   render json: final
      # rescue StandardError => e
      #   binding.debugger
      #   render json: "Error: #{e.message}"
      # end

      private

      def wiki_post_params
        params.permit(:title, :description, :author)
      end

      def authenticate
        authenticate_or_request_with_http_token do |token, options|
          ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
        end
      end
    end
  end
end
