# frozen_string_literal: true

class UrlsController < ApplicationController
  def index
    # recent 10 short urls
    @url = Url.new
    @urls = [
      Url.new(short_url: 'ABCDE', original_url: 'http://google.com', created_at: Time.now),
      Url.new(short_url: 'ABCDG', original_url: 'http://facebook.com', created_at: Time.now),
      Url.new(short_url: 'ABCDF', original_url: 'http://yahoo.com', created_at: Time.now)
    ]
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      redirect_to urls_path
    end
  end

  def show
    #@url = Url.new(short_url: 'ABCDE', original_url: 'http://google.com', created_at: Time.now)
    # implement queries

    @url = Url.find_by(short_url: params[:short_url])
    render 'errors/404', status: 404 if @url.nil?
    @url.update_attributes(:clicks_count, @url.clicks_count + 1)
    
    @daily_clicks = [
      ['1', 13],
      ['2', 2],
      ['3', 1],
      ['4', 7],
      ['5', 20],
      ['6', 18],
      ['7', 10],
      ['8', 20],
      ['9', 15],
      ['10', 5]
    ]
    @browsers_clicks = [
      ['IE', 13],
      ['Firefox', 22],
      ['Chrome', 17],
      ['Safari', 7]
    ]
    @platform_clicks = [
      ['Windows', 13],
      ['macOS', 22],
      ['Ubuntu', 17],
      ['Other', 7]
    ]
  end

  def visit
    # params[:short_url]
    render plain: 'redirecting to url...'
  end

  private
  def url_params
    params.require(:url).permit(:original_url)
end
