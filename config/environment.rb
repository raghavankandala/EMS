# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Saaku20::Application.initialize!

ENV['RECAPTCHA_PUBLIC_KEY'] = '6Le15QsAAAAAAK9ekV-VAVpMHzTh18n0jnTCi6iN'
ENV['RECAPTCHA_PRIVATE_KEY'] = '6Le15QsAAAAAAEsH0eS9rdaLfIgkLF_4PfaRuyg4'

