# frozen_string_literal: true

class WikiPostRecord < ApplicationRecord
  belongs_to :wiki_post
  validates :wiki_post, presence: true
end
