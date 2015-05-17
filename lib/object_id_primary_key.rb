require "object_id_primary_key/version"

module ObjectIdPrimaryKey
  extend ActiveSupport::Concern

  included do
    self.primary_key = :id
    before_create :set_object_id
    before_update :validate_object_id
  end

  private

  def validate_object_id
    raise 'Invalid ObjectId' if !BSON::ObjectId.legal?(self.id)
  end

  def set_object_id
    if self.id.nil?
      self.id = BSON::ObjectId.new.to_s
    else
      validate_object_id
    end
  end
end
