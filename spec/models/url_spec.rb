# frozen_string_literal: true

require 'rails_helper'
require 'validate_url/rspec_matcher'

RSpec.describe Url, type: :model do
  describe 'validations' do
    subject(:url) {Url.create!(original_url: original_url, short_url: '')}
    let(:original_url) {'https://www.espn.com'}
    it 'validates original URL is a valid URL' do
      is_expected.to validate_url_of(:original_url)
    end

    it 'validates short URL is present' do
      expect(url.short_url).not_to be_empty
    end

    it 'validates short URL is length of 5' do
      expect(url.short_url.length).to eq 5
    end

    it 'validates short URL contains only capital letters' do
      expect(url.short_url).to match(/\A[A-Z]+\Z/)
    end

    it 'validates short URL is uniqe' do
      url2 = Url.create!(original_url: 'https://www.espn.com', short_url: '')
      expect(url2.short_url).to equal (url.short_url)
    end
  end
end
