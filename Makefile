IMAGE := lagoonplatform/ansible-docker-alpine

test:
	true

image:
	docker build -t $(IMAGE) .

push-image:
	docker push $(IMAGE)

