module Amistad
  module ActiveRecord
    module HasActions
      extend ActiveSupport::Concern

      included do
        has_many :actions
      end

      module ClassMethods
        def predefined_actions
          @@predefined_actions ||= {}
        end

        def predefine_action(action, options = nil)
          predefined_actions[action] = Action.new(options)
        end

        def has_predefined_action(action)
          predefined_actions.has_key?(action)
        end

        def remove_all_predefined_actions
          @@predefined_actions = {}
        end
      end

      module InstanceMethods
        def did(what)
          action = if what.is_a? Symbol
                     self.class.predefined_actions[what].dup
                   else
                     Action.new(:description => what)
                   end
          actions << action
          action
        end
      end
    end
  end
end
