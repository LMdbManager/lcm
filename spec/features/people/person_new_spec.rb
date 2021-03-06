# Feature: Create a new person
#   as authorized user
#   I want to create a new person

feature 'Person new', :devise do
  # an administrator can create a new person
  #   Given I exist as a user
  #   And I am signed in
  #   And I am administrator
  #   When I visit the page for creating a person
  #   Then the page for creating a person is shown
  scenario 'show page to create Person' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    visit new_person_path
    expect(page).to have_content 'New Person'
  end

  # scenario with German language
  #   Given I exist as a user
  #   And I am signed in
  #   And I am administrator
  #   When I visit the page for creating a person
  #   Then 
=begin
  scenario 'show German page to create Person' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    I18n.locale = :de
    visit new_person_path
    expect(page).to have_content 'astname'
  end
=end

  # an assistant can not create a new person
  #   Given I exist as a user
  #   And I am signed in
  #   And I am assistant
  #   When I create a person
  #   Then the page will show "access denied"
  scenario 'create Person as assistant' do
    user = FactoryGirl.create(:user, :assistant)
    signin(user.email, user.password)
    visit new_person_path(locale: :de)
    fill_in 'Nachname', with: 'Test-Nachname'
    click_button 'Person erstellen'
    expect(page).to have_content 'Access denied'
  end

  # an administrator can create a new person
  #   Given I exist as a user
  #   And I am signed in
  #   And I am administrator
  #   When I create a person
  #   Then the page for the newly created person is shown
  scenario 'create Person as admin' do
    user = FactoryGirl.create(:user, :admin)
    signin(user.email, user.password)
    visit new_person_path(locale: :de)
    fill_in 'Nachname', with: 'Test-Nachname'
    click_button 'Person erstellen'
    expect(page).to have_content 'Test-Nachname'
  end

end
