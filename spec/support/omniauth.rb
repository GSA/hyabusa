OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:myusa, {
  :info => {
    :email => 'joe@citizen.org',
    :uid => '12345'
  },
  :uid => '12345',
  :credentials => {
    :token => 'foobar123',
  }
})

def login_with_myusa
  visit '/auth/myusa'
end
