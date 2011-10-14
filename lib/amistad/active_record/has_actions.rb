module Amistad
  module ActiveRecord
    module HasActions
      def self.included(receiver)
        receiver.class_exec do
          include InstanceMethods

          has_many :actions
        end
      end

      module InstanceMethods
        def did(what)
          action = Action.new(:description => what)
          actions << action
          action
        end
      end
    end
  end
end
