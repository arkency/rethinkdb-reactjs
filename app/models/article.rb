class Article
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :title, :type => String
  field :text, :type => String
  field :tags, :type => Array
end
