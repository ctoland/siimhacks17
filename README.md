docker build -t siim17 .
docker run -it siim17 "bundle exec rake test"
docker run -itP siim17
