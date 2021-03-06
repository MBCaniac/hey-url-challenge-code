# frozen_string_literal: true

class Url < ApplicationRecord
  # scope :latest, -> {}
  validates_url :original_url
  validates :original_url, presence: true

  after_create :create_short

  def create_short
    update(short_url: generate_short)
  end

  def generate_short
    return initial_short unless Url.all.pluck(:short_url).include?(initial_short)
    additional_short
  end

  def initial_short
    temp = original_url.gsub!(/[^A-Za-z]/, '')
    @initial_short ||= temp.upcase[temp.length-5, 5]
  end

  def additional_short
    temp2 = original_url.gsub!(/[^A-Za-z]/, '')
    @additional_short ||= temp2.upcase[temp2.length-6, 5]
  end
end
