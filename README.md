Bridge
======

Simple Sinatra app to provide administrative API for [Namely
Admin](https://github/namely/admin).

If you're on a mac, your `bundle install` may fail at the postgres gem. To install it separately, you will want to do something like this:
```
gem install pg -v 0.17.1 -- --with-pg-config=/Applications/Postgres.app/Contents/Versions/9.3/bin/pg_config --with-pg-include='/Applications/Postgres.app/Contents/Versions/9.3/include/'
```

cURL commands:
* `curl localhost:4567/companies`
* `curl -i -H "Content-Type: application/json" -X POST -d '{"permalink":"namely","emails":["attila1@namely.com"],"command":"lock","authorized_by":"damon1@namely.com"}' http://localhost:4567/companies`
