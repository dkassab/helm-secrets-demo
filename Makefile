APP_NAME=helm-secrets-pgp
CURRENT_WORKING_DIR=$(shell pwd)

QUAY_REPO=dkassab
QUAY_USERNAME?="unknown"
QUAY_PASSWORD?="unknown"

GO_PIPELINE_COUNTER?="unknown"

# Construct the tag.
VERSION=1.1.$(GO_PIPELINE_COUNTER)
helm-package:
	helm init
	helm package --version $(VERSION) $(APP_NAME)

helm-push:
	helm registry login -u $QUAY_USERNAME -p $QUAY_PASSWORD quay.io
	cd $APP_NAME
	helm registry push quay.io

deploy:
	helm secrets upgrade --install -f secrets.dev.yaml  $(APP_NAME)-$(VERSION).tgz

clean:
	rm -rf *.tgz
