APP_NAME=helm-secrets
VERSION=1.1.$(GO_PIPELINE_COUNTER)
helm-package:
	helm init
	helm package --version $(VERSION) $(APP_NAME)

helm-push:
	helm registry login -u $QUAY_USERNAME -p $QUAY_PASSWORD quay.io
	cd $APP_NAME
	helm registry push quay.io

deploy:
	helm  upgrade --install  $(APP_NAME)-$(VERSION).tgz

clean:
	rm -rf *.tgz
