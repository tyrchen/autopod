PROTO_DIR=../protos
PROTO_FILES=tts.proto
PROTOS=$(addprefix $(PROTO_DIR)/, $(PROTO_FILES))
OUTPUT=lib/src/gen

gen:
	protoc -I $(PROTO_DIR) $(PROTOS) --dart_out=$(OUTPUT)
