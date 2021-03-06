require 'spec_helper'

feature 'User Signs In' do

	context 'when signed in' do
		background do
			pledge = create(:pledge)
			pledge.user.create_venmo_account(first_name: 'Jack', last_name: 'Henley')
			visit root_path
			sign_in_as(pledge.user)
			click_on 'test gift'
		end

		scenario 'Updates a gift successfully' do
			click_on 'Update this campaign'
			fill_in 'Title for campaign', with: 'Old computer for Steve'
			fill_in 'Description of gift:', with: 'Old macbook pro'
			fill_in 'Reason for gift:', with: 'Steves birthday is coming up. Lets get him an old computer!'
			fill_in 'Campaign duration:', with: 'Fri, 30 May 2014'
			fill_in 'Campaign goal:', with: 1500
			click_on 'Update campaign!'
			expect(page).to have_content('Your campaign \'Old computer for Steve\' has been successfully updated.')
		end

		scenario 'Updates a gift unsuccessfully with blank name' do
			click_on 'Update this campaign'
			fill_in 'Title for campaign:', with: ''
			fill_in 'Description of gift:', with: 'Old macbook pro'
			fill_in 'Reason for gift:', with: 'Steves birthday is coming up. Lets get him an old computer!'
			fill_in 'Campaign duration:', with: 'Fri, 30 May 2014'
			fill_in 'Campaign goal:', with: 1500
			click_on 'Update campaign!'
			expect(page).to have_content('Name can\'t be blank')
		end

		scenario 'Updates a gift unsuccessfully with no end date' do
			click_on 'Update this campaign'
			fill_in 'Title for campaign', with: 'Old computer for Steve'
			fill_in 'Description of gift:', with: 'Old macbook pro'
			fill_in 'Reason for gift:', with: 'Steves birthday is coming up. Lets get him an old computer!'
			fill_in 'Campaign duration:', with: ''
			fill_in 'Campaign goal:', with: '1,600'
			click_on 'Update campaign!'
			expect(page).to have_content('End date can\'t be blank')
		end

		scenario 'Updates a gift unsuccessfully with no goal' do
			click_on 'Update this campaign'
			fill_in 'Title for campaign', with: 'Old computer for Steve'
			fill_in 'Description of gift:', with: 'Old macbook pro'
			fill_in 'Reason for gift:', with: 'Steves birthday is coming up. Lets get him an old computer!'
			fill_in 'Campaign duration:', with: 'Fri, 30 May 2014'
			fill_in 'Campaign goal:', with: ''
			click_on 'Update campaign!'
			expect(page).to have_content('Goal can\'t be blank')
		end

	end
end
