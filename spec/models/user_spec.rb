require 'spec_helper'

describe User do
  it do 
    create :user # Rails 4 workaround
    should validate_uniqueness_of :email 
  end

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_confirmation_of :password }
end
