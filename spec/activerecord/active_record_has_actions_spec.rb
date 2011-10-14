require 'spec_helper'

describe Amistad::ActiveRecord::HasActions do
  before(:each) do
    %w(Jane David).each do |name|
      instance_variable_set("@#{name.downcase}".to_sym, User.create(:name => name))
    end
  end

  context "when defining action for user" do
    before(:each) do
      User.remove_all_predefined_actions
      User.predefined_actions.empty?.should be_true
    end

    it "should add action to predefined actions" do
      User.has_predefined_action(:something).should be_false
      User.predefine_action :something
      User.has_predefined_action(:something).should be_true
    end

    it "should add action with description to available actions" do
      User.has_predefined_action(:something).should be_false
      User.predefine_action :something, { :description => 'Something' }
      User.has_predefined_action(:something).should be_true
      User.predefined_actions[:something].description.should == 'Something'
    end
  end

  context "when creating action for user" do
    before(:each) do
      Action.delete_all
      User.remove_all_predefined_actions

      User.has_predefined_action(:anything).should be_false
      User.predefine_action :anything, { :description => 'Anything'}
      User.has_predefined_action(:anything).should be_true
    end

    it "should create action" do
      @jane.did('nothing').should be_true
      @jane.actions.size.should == 1
      @jane.actions.first.description.should == 'nothing'
    end

    it "should use predefined action" do
      @jane.did(:anything).should be_true
      @jane.actions.size.should == 1
      @jane.actions.first.description.should == 'Anything'
    end

    it "should leave predefined action untouched" do
      @jane.did(:anything).should be_true

      User.predefined_actions[:anything].user_id.should be_nil
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
