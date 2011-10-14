require 'spec_helper'

describe Amistad::ActiveRecord::HasActions do
  before(:each) do
    %w(Jane David).each do |name|
      instance_variable_set("@#{name.downcase}".to_sym, User.create(:name => name))
    end
  end

  context "when creating action for user" do
    before(:each) do
      Action.delete_all
    end

    it "should create action with string" do
      @jane.did('nothing').should be_true
      @jane.actions.size.should == 1
      @jane.actions.first.description.should == 'nothing'
    end
  end

  context "when listing actions for user" do
    before(:each) do
      Action.delete_all

      (@something = @jane.did('something')).should be_true
      @something.description.should == 'something'

      (@anything = @jane.did('anything')).should be_true
      @anything.description.should == 'anything'
    end

    it "should list all actions" do
      @jane.actions.should =~ [@something, @anything]
      @david.actions.should =~ []
    end
  end
end
