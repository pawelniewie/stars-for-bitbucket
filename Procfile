web: bundle exec puma -t 6:6 -p ${PORT:-3000} -e ${RACK_ENV:-development}
release: bundle exec rake db:migrate