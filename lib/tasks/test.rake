namespace :ruby_caddy do
  desc "updates test results for all users"
  task test_all: :environment do
    while true
      User.all.each do |user|
        puts "==================== #{user.name} = #{user.git_uri}"
        begin
          user.test
        rescue => e
          puts e
        end
      end
      pause = (ENV["SLEEP"] || 60).to_i
      puts "==================== sleeping for #{pause} seconds"
      sleep pause
    end
  end
  task clean: :environment do
    TestResult.destroy_all
  end
end
