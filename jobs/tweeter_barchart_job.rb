# Note: change this to obtain your chart data from some external source

require "kafka"

kafka = Kafka.new(
 seed_brokers: ["broker.kafka.l4lb.thisdcos.directory:9092"],
 client_id: "tweeter-dashboard",
)

consumer = kafka.consumer(group_id: "tweet-consumer")

consumer.subscribe("tweets")

#consumer.each_message do |message|
# puts message.topic, message,partition
# puts message.offset, message.key, message.value
#end

labels = ['January', 'February', 'March', 'April', 'May', 'June', 'July']
data = [
  {
    label: 'First dataset',
    data: Array.new(labels.length) { rand(40..80) },
    backgroundColor: [ 'rgba(255, 99, 132, 0.2)' ] * labels.length,
    borderColor: [ 'rgba(255, 99, 132, 1)' ] * labels.length,
    borderWidth: 1,
  }, {
    label: 'Second dataset',
    data: Array.new(labels.length) { rand(40..80) },
    backgroundColor: [ 'rgba(255, 206, 86, 0.2)' ] * labels.length,
    borderColor: [ 'rgba(255, 206, 86, 1)' ] * labels.length,
    borderWidth: 1,
  }
]
options = { }

send_event('barchart', { labels: labels, datasets: data, options: options })
