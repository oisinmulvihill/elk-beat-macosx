export NAMESPACE=elkbeats

# default set up to run with docker compose managed services:

.DEFAULT_GOAL := all

.PHONY: all collect run up down ps clean

all:
	echo "Please choose a make target to run."

clean:
	rm -rf dist/ build/
	rm -f README.pdf
	find . -iname '*.pyc' -exec rm {} \; -print


# "Running Filebeat with the setup command will create the index pattern and 
# load visualizations , dashboards, and machine learning jobs."
#
# https://www.elastic.co/guide/en/beats/filebeat/7.10/running-on-docker.html#_run_the_filebeat_setup
#
setup:
	./filebeat setup -e \
		-strict.perms=false \
		-E setup.kibana.host=localhost:5601 \
		-E output.elasticsearch.hosts=["localhost:9200"] \
		-c config/filebeat.yml

run:
	./filebeat -e -strict.perms=false -c config/filebeat.yml

runcontainer:
	docker run --rm \
		--user=root \
		--network=elkbeats_elastic \
		--volume="${PWD}/config/filebeat.yml:/usr/share/filebeat/filebeat.yml:ro" \
		--volume="/var/logs:/host/var/logs:ro" \
		-it docker.elastic.co/beats/filebeat:7.10.0 \
		filebeat -e -strict.perms=false -E output.elasticsearch.hosts=["es01:9200"] 

up:
	docker-compose --project-name ${NAMESPACE} up --remove-orphans

ps:
	docker-compose --project-name ${NAMESPACE} ps

down:
	docker-compose --project-name ${NAMESPACE} logs -t
	docker-compose --project-name ${NAMESPACE} down --remove-orphans
