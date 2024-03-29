module Amistad
  module ActiveRecord
    module ActionModel
      extend ActiveSupport::Concern

      included do
        belongs_to :user
        belongs_to :subject, :polymorphic => true

        validates :user, :presence => true
      end

      module ClassMethods

      end

      module InstanceMethods

      end
    end
  end
end
