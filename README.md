nDelius Monitoring
====
Monitoring for the nDelius projects.
 
The project is based on Smashing:[https://github.com/Smashing/smashing](https://github.com/Smashing/smashing)


Build
----
```
gem install bundler
bundle install
```

Run
----
```
smashing start
```

Local
----
http://localhost:3030/circle

Heroku
----
https://ndelius-monitoring.herokuapp.com/circle

Development
----
This is a Ruby on Rails application. To add new features or make changes there are three main areas to touch - 
jobs, dashboards and widgets. 

The jobs 'circle_ci.rb' and 'health.rb' gather data from CI and the service health and info end points.

The 'circle.erb' dashboard is a Rails template that displays the data. 

We use two widgets on the UI, 'circle_ci' and 'server_status_squares'. Check 'server_status_squares.coffee' for status
color logic.

Further Reading on Smashing
----
Check out http://smashing.github.io/ for more information.