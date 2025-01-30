SOLC = solc
BUILD_DIR = build

SRC = $(shell find contracts -type f -name "*.sol")
BIN = $(patsubst contracts/%.sol, $(BUILD_DIR)/%.bin, $(SRC))
ABI = $(patsubst contracts/%.sol, $(BUILD_DIR)/%.abi, $(SRC))

all: $(BIN) $(ABI)

$(BUILD_DIR)/%.bin $(BUILD_DIR)/%.abi: contracts/%.sol
	mkdir -p $(BUILD_DIR)/$(dir $*)
	$(SOLC) --bin --abi $< -o $(BUILD_DIR)/$(dir $*)

clean:
	rm -rf $(BUILD_DIR)
