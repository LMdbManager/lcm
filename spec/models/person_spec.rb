# == Schema Information
#
# Table name: people
#
#  pid                    :integer          not null, primary key
#  email                  :string           default("")
#  encrypted_password     :string           default("")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  region_id              :integer
#  firstname              :string
#  lastname               :string
#  callby                 :string
#  sex                    :string
#  title                  :string
#  country                :string
#  region                 :string
#  zip                    :string
#  city                   :string
#  street                 :string
#  housenumber            :string
#  birthday               :date
#  state                  :string
#  date                   :string
#  phone_private          :string
#  phone_work             :string
#  phone_mobile           :string
#  notes                  :string
#  do_not_contact         :boolean
#  access                 :integer
#


RSpec.describe Person, :type => :model do

  subject { build(:person) }

  it { should respond_to(:firstname ) }
  it { should respond_to(:lastname ) }
  it { should respond_to(:fullname ) }

  it { should belong_to(:region) }

  it { should have_many(:calls) }

  it { should have_many(:person_event_assignments) }
  it { should have_many(:person_team_assignments) }

  describe "a newly created person"  do

    it "should get a new pid after saving" do
      expect(subject.pid). to be nil
      subject.save!
      expect(subject.pid). to be > 0
    end

    it "should have a default country" do
      expect(subject.country).to eq("DE")
    end

  end

end
