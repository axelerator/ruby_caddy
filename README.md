# Ruby Caddy

We recently held the second [ruby golf competition](https://github.com/thomasjachmann/ruby_golf_hamburg_2013) in Hamburg and wanted to have a dashboard with the highscores. This is what we used.

# Usage

Just run the rails app. Every contestant has to register and enter the git url of his fork of [the base repository](https://github.com/thomasjachmann/ruby_golf_hamburg_2013/tree/ready_set_go) containing the tasks.

Then, go to [test_environment](test_environment) and run

```
bundle
bundle exec rake ruby_caddy:test_all
```

This will run in an endless loop and run the test in [test_environment/ruby_golf_test.rb](test_environment/ruby_golf_test.rb), store the test results in the database and recompute the scores of all users.
