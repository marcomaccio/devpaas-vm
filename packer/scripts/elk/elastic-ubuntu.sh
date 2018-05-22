#!/bin/bash -ex

echo "******* ElasticSearch Installation *******"

sudo apt-get update && sudo apt-get install elasticsearch

echo "Copy Elasticsearch config file ..."
sudo cp /tmp/elk/resources/elasticsearch.yml /etc/elasticsearch/
sudo chown root:root /etc/elasticsearch/elasticsearch.yml

sudo systemctl daemon-reload
sudo systemctl enable elasticsearch

echo "Start Elasticsearch service ..."
sudo service elasticsearch start

#echo "Test Elastic Installation ..."
#curl -XGET 'http://localhost:9200/_count?pretty' -d '{ "query": {"match_all":{}}}'
