require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :owner }
  it { should validate_presence_of :email }
  it { should validate_presence_of :body }
  it { should validate_presence_of :question_id }
  it { should belong_to :question }
end
