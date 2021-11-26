#!/bin/sh

# If database exists, migrate. Otherwise create
bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:create && bundle exec rails db:migrate 2>/dev/null
echo "Done!"
