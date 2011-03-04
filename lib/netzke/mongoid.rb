require 'netzke/mongoid/adaptor'
require 'netzke/active_record/attributes'
require 'netzke/active_record/combobox_options'
require 'netzke/active_record/relation_extensions'

module Netzke
  module Mongoid
  end
end

# Extend Mongoid::Document
Mongoid::Document.class_eval do
  include ::Netzke::Mongoid::Adaptor
  include ::Netzke::ActiveRecord::Attributes
  include ::Netzke::ActiveRecord::ComboboxOptions
end
