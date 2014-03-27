class Gift < ActiveRecord::Base
	has_many :pledges
	has_many :users, through: :pledges

	validates :name, presence: true
	validates :end_date, presence: true
	validates :goal, presence: true
	validates_numericality_of :goal, on: :create
	validates_numericality_of :goal, on: :update

	# This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar,
  	:default_url => "/missing.png",
  		styles: {
		    thumb: '100x100>',
		    square: '200x200#',
		    medium: '300x300>',
		    large: '500x500>'
  		},
  	default_style: :large

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def check_if_funded
  	pledge_sum = Pledge.sum(:amount, conditions: {gift_id: self.id})
  	if pledge_sum >= self.goal
  		self.funded = true
  		self.save
      return true
  	else
      false
    end
  end

  def charge_gift_pledges
  	gift_creator = User.find(self.pledges.where(owner: true).first.user_id)
  	pay_to = gift_creator.venmo_account.venmo_id
  	pledges = self.pledges.where(owner: false, status: nil)

  	pledges.each do |pledge|
      pledge.process_pledge(pay_to)
  	end
  end

  def check_gift_payments
    binding.pry
    all_pledge_status = self.pledges.map do |pledge|
      pledge.status
    end
  end

  def send_gift_emails
    self.pledges.each do |pledge|
      # send email for each pledge
    end
  end

end
