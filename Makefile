default:
	make assets-build
	make package-build
	make upload
package-build:
	rm -rf dist
	python setup.py bdist_wheel --universal
upload:
	twine upload dist/*
tag:
	git tag $(TAG) -m '$(MSG)' && git push --tags origin master
delete-tag:
	git tag --delete $(TAG); git push --delete origin $(TAG)
assets-build:
	make assets-clean
	NODE_ENV=production parcel build --public-url='/assets' -d scylla/assets frontend/src/index.html
assets-dev:
	parcel --public-url='/assets' frontend/src/index.html
assets-clean:
	rm -rf scylla/assets
	rm -rf build/lib/scylla/assets
	rm -rf dist/scylla/scylla/assets
doc:
	make doc-en
	make doc-zh
doc-en:
	cd docs/source && sphinx-apidoc -f -o . ../../scylla
	cd docs && PYTHONPATH=../ make html
doc-zh:
	cd docs_zh/source && sphinx-apidoc -f -o . ../../scylla
	cd docs_zh && PYTHONPATH=../ make html
