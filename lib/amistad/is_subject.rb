module Amistad
  module IsSubject
    def self.included(receiver)
      if receiver.ancestors.map(&:to_s).include?("ActiveRecord::Base")
        receiver.class_exec do
          include Amistad::ActiveRecord::IsSubject
        end
      else
        raise "Amistad-action only supports ActiveRecord"
      end
    end
  end
end
