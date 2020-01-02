# frozen_string_literal: true

###############################################################################
# Create User
###############################################################################
user = User.find_or_initialize_by(email: 'test@test.com')
user.update!(password: 'testtest', confirmed_at: Time.now)

###############################################################################
# Create Links
###############################################################################
LINKS_TO_CREATE = [
  OpenStruct.new(url: 'http://www.google.com', status: 'approved'),
  OpenStruct.new(url: 'http://www.tacos.com', status: 'pending'),
  OpenStruct.new(url: 'http://www.hello.com', status: 'failed_safety_check')
]

link_creator = Links::Creator.new(safety_checker: NullLinkSafetyCheckJob)

LINKS_TO_CREATE.each do |seed|
  link = Link.find_by(url: seed.url)

  if link
    link.update! status: seed.status
  else
    link_creator.create(url: seed.url, status: seed.status)
  end
end
