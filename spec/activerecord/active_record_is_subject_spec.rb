require 'spec_helper'

describe Amistad::ActiveRecord::IsSubject do
  before(:all) do
    Action.delete_all
    %w(Jane David).each do |name|
      instance_variable_set("@#{name.downcase}".to_sym, User.create(:name => name))
    end
  end

  it "should store concerning actions" do
    action = Action.create(:user => @jane,
                           :description => "#{@jane.name} sent message to #{@david.name}",
                           :subject => @david)

    @david.concerning_actions.size.should == 1
    @david.concerning_actions.first.should == action
  end
end
