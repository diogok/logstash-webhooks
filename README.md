# Logstash Webhooks

This a test of using logstash as a webhook intermediate.

This reads webhooks sources from Consul and reload logstash config accordinly.

This setup of logstash include persistent queue and configurable retry, so it's useful to decouple the webhook emitter form the webhook receiver while also ensuring to retry safely.

Still have to figure a way to handle long failures of receivers.

## Usage

To start it all use "docker-compose up".
  
  $ docker-compose up

To register a hook in consul create an entry in the key-value store as  webhook/hook-name=url:

  $ curl -X PUT localhost:8500/v1/kv/webhook/myhook -d 'http://myservice.com/webhook'

To send a webhook thru logstash:

  $ curl -X POST localhost:8080/ -H 'Content-Type: application/json' -d '{"to":"myhook","content":{"foo":"bar"}}'

This will enqueue to send {"fo":"bar"} to "http://myservice.com/webhook" with retries if needed.

You can also send to an unregistered url:

  $ curl -X POST localhost:8080/ -H 'Content-Type: application/json' -d '{"to":"url","content":{"foo":"bar"},"url":"http://mycustom"}'

## License

MIT

