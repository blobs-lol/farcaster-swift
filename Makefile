bindings:
	# TODO(michael): Pull proto schemas from @farcaster/protobufs
	protoc Protos/*.proto	\
		-I Protos	\
		--swift_out=Sources/Generated	\
		--grpc-swift_out=Client=true,Server=false:Sources/Generated

build:
	swift build

clean:	
	rm -rf Sources/Generated/*.pb.swift .build

test:
	swift test
