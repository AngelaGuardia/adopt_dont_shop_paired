require "rails_helper"

describe PetApplications do

  describe "relationships" do
    it { should belong_to :pet }
    it { should belong_to :applications }
  end
end
