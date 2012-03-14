user = User.create name: "LC Admin", email: Config["company"]["email"], profile_type: "Admin"
user.password = "lcadmin"
user.password_confirmation = "lcadmin"
user.save