require "object_id_primary_key/version"

module ObjectIdPrimaryKey
  extend ActiveSupport::Concern

  included do
    self.primary_key = :id
    before_create :set_object_id
  end

  private

  def set_object_id
    self.id = BSON::ObjectId.new.to_s
  end
end
