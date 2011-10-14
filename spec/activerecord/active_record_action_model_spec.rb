require 'spec_helper'

describe Amistad::ActiveRecord::ActionModel do
  before(:all) do
    %w(Jane David).each do |name|
      instance_variable_set("@#{name.downcase}".to_sym, User.create(:name => name))
    end
  end

  it "should validate presence of the user's id" do
    action = Action.new
    action.valid?.should be_false
    action.errors.should include(:user)
    action.errors.size.should == 1
  end
end
