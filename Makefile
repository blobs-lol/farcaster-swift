bindings:
	# TODO(michael): Pull proto schemas from @farcaster/protobufs
	protoc -I Protos --swift_out=Sources/Generated Protos/*.proto

build:
	swift build

clean:	
	rm -rf Sources/Generated/*.pb.swift .build

test:
	swift test
