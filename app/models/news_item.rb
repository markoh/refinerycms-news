class NewsItem < ActiveRecord::Base

  alias_attribute :content, :body
  validates_presence_of :title, :content, :publish_date

  has_friendly_id :title, :use_slug => true

  acts_as_indexed :fields => [:title, :body]

  default_scope :order => "publish_date DESC"

  # If you're using a named scope that includes a changing variable you need to wrap it in a lambda
  # This avoids the query being cached thus becoming unaffected by changes (i.e. Time.now is constant)
  scope :published, lambda {
    where( "publish_date < ?", Time.now )
  }
  scope :latest, lambda { |*l_params|
    published.limit( l_params.first || 10)
  }

  def not_published? # has the published date not yet arrived?
    publish_date > Time.now
  end

  # for will_paginate
  def self.per_page
    20
  end

end
