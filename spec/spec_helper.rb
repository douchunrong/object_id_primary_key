require 'active_record'
require 'byebug'
require 'bson'
require 'object_id_primary_key'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

require_relative 'support/schema'
require_relative 'support/models'
