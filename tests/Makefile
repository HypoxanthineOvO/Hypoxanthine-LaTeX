# ==========================================
# Hypoxanthine Tests (Isolation Sandbox)
# ==========================================

# 目标：主线测试与边缘测试分离，避免后续用例增多后混在一起。

HYPO_PATH = ..
HYPO_MK := $(HYPO_PATH)/make/Hypoxanthine.mk
OUT_DIR ?= build

.PHONY: all main edge clean watch help

all: main

main:
	$(MAKE) -f $(HYPO_MK) NAME=Main MAIN_FILE=Main.tex OUT_DIR=$(OUT_DIR) all

edge:
	$(MAKE) -f $(HYPO_MK) NAME=ShorthandOff MAIN_FILE=edge/ShorthandOff.tex OUT_DIR=$(OUT_DIR) all

clean:
	$(MAKE) -f $(HYPO_MK) OUT_DIR=$(OUT_DIR) clean

watch:
	$(MAKE) -f $(HYPO_MK) NAME=Main MAIN_FILE=Main.tex OUT_DIR=$(OUT_DIR) watch

help:
	@echo "Hypoxanthine Tests"
	@echo "  make       - Build mainline test PDF"
	@echo "  make edge  - Build edge-case test PDFs"
	@echo "  make watch - Watch & rebuild mainline PDF"
	@echo "  make clean - Remove build directory"
