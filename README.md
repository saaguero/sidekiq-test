# Installation

The project has support with docker-compose, so it's a matter of just executing the following:

```bash
docker-compose build
```

# Usage

- Run everything (redis, sidekiq, web server) with the following:

```bash
docker-compose up
```

- In another terminal, run irb with a couple of sidekiq jobs to test:

```bash
docker-compose run --rm web bundle exec irb -r /myapp/worker.rb

OurWorker.set(queue: :default).perform_async("hard")
OurWorker.set(queue: :critical).perform_async("super_hard")
OurWorker.set(queue: :low).perform_async("easy")
```

You should see in the firt terminal the logs for these jobs being run and completed.

You can use the sidekiq web page to see all the details going to http://127.0.0.1:8080.

You can also open http://127.0.0.1:8080/metrics for prometheus metrics, it uses the gem: https://github.com/Strech/sidekiq-prometheus-exporter.
