module Amistad
  module ActiveRecord
    module ActionModel
      def self.included(receiver)
        receiver.class_exec do
          include InstanceMethods

          belongs_to :user

          validates :user, :presence => true
        end
      end

      module InstanceMethods

      end
    end
  end
end
