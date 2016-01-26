require 'active_support/concern'
require 'base64'
require 'bson'
require "object_id_primary_key/version"

module ObjectIdPrimaryKey
  extend ActiveSupport::Concern

  included do
    self.primary_key = :id
    before_create :set_object_id
    before_update :validate_object_id
  end

  def base64_id
    # to_bson returns a BSON::ByteBuffer now, which must be explicitly cast to
    # a string
    return Base64.urlsafe_encode64(BSON::ObjectId.from_string(self.id).to_bson.to_s)
  end

  class_methods do
    def find_by_base64_id(str)
      return find(BSON::ObjectId.from_data(Base64.urlsafe_decode64(str)).to_s)
    end
  end

  private

  def validate_object_id
    # Note: This regex is stricter that ObjectId.legal? to exclude newlines
    # and enforce lowercase hex characters, since SQL is case sensitive.
    raise 'Invalid ObjectId' unless self.id =~ /\A[0-9a-z]{24}\z/
  end

  def set_object_id
    if self.id.nil?
      self.id = BSON::ObjectId.new.to_s
    else
      validate_object_id
    end
  end
end
