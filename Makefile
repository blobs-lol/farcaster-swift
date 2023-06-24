bindings:
	# TODO(michael): Pull proto schemas from @farcaster/protobufs
	protoc Protos/*.proto	\
		-I Protos	\
		--swift_out=Sources/Generated	\
		--grpc-swift_out=Client=true,Server=false:Sources/Generated

build:
	make bindings
	swift build

clean:	
	rm -rf Sources/Generated/*.pb.swift .build

.PHONY: example
example:
	make build
	swift run Example

lint:
	swiftlint --strict

test:
	swift test
