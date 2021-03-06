include Warden::Test::Helpers
Warden.test_mode!

# Feature: User delete
#   As a user
#   I want to delete my user profile
#   So I can close my account
feature 'User delete', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Assistant user can delete own account
  #   Given I am signed in
  #   When I delete my account
  #   Then I should see an account deleted message
  scenario 'assistant user can delete own account' do
    user = FactoryGirl.create(:user, :assistant)
    login_as(user, :scope => :user)
    visit edit_user_registration_path(user)
    click_button 'Cancel my account'
    expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  end

end




