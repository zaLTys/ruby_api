# frozen_string_literal: true

class WikiPost < ApplicationRecord
  has_one_attached :image
  has_one :wiki_post_record, dependent: :destroy
  after_save :create_wiki_post_record

  validates_format_of :title, with: /\A[a-zA-Z0-9\s.,!?:;'-]+\z/

  scope :contributors, -> { pluck(:author).uniq }

  private

  def create_wiki_post_record
    data = {
      id:,
      created_at:,
      updated_at:,
      title:,
      description:,
      author:
    }
    build_wiki_post_record(data:).save!
  end
end
