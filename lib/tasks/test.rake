namespace :ruby_caddy do
  desc "updates test results for all users"
  task test_all: :environment do
    while true
      User.all.each do |user|
        puts "==================== #{user.name} = #{user.git_uri}"
        user.test
      end
      pause = (ENV["SLEEP"] || 60).to_i
      puts "==================== sleeping for #{pause} seconds"
      sleep pause
    end
  end
end
