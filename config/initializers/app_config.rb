AppConfig = YAML.load_file("#{Rails.root}/config/app_config.yml")

# HEROKU
Secrets = Rails.env == "production" ? ENV : YAML.load_file("#{Rails.root}/config/secrets.yml")