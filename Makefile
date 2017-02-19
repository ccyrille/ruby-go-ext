.PHONY: default bench content

default:
install:
	go get github.com/paulmach/go.geo
	go build -buildmode=c-shared -o ext/poly/poly.so ext/poly/poly.go
	gem install bundler
	bundle install

benchmark:
	ruby ./examples/benchmark.rb
