module Amistad
  module ActiveRecord
    module IsSubject
      extend ActiveSupport::Concern

      included do
        has_many :concerning_actions, :class_name => 'Action', :as => 'subject'
      end

      module ClassMethods

      end

      module InstanceMethods

      end
    end
  end
end
