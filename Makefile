APP_NAME=helm-secrets
CURRENT_WORKING_DIR=$(shell pwd)
VERSION=1.1.$(GO_PIPELINE_COUNTER)
helm-package:
	helm package --version $(VERSION) $(APP_NAME)

helm-push:
	helm registry login -u $QUAY_USERNAME -p $QUAY_PASSWORD quay.io
	helm registry push quay.io

deploy:
	helm  upgrade --install --reuse-values $(APP_NAME)  $(APP_NAME)-$(VERSION).tgz

clean:
	rm -rf *.tgz
