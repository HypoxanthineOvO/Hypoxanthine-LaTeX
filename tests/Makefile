# ==========================================
# Hypoxanthine Tests (Isolation Sandbox)
# ==========================================

# 目标：主线测试与边缘测试分离，避免后续用例增多后混在一起。

HYPO_PATH = ..
HYPO_MK := $(HYPO_PATH)/make/Hypoxanthine.mk
OUT_DIR ?= build

ASSET_DIR := assets
ASSET_TEX := $(ASSET_DIR)/example-image.tex
ASSET_PDF := $(ASSET_DIR)/example-image.pdf



.PHONY: all main class class-en litnote chsh plot edge clean watch help

all: main class class-en litnote chsh

main: $(ASSET_PDF)
	$(MAKE) -f $(HYPO_MK) HYPO_PATH=$(HYPO_PATH) NAME=Main MAIN_FILE=Main.tex OUT_DIR=$(OUT_DIR) all

class: $(ASSET_PDF)
	$(MAKE) -f $(HYPO_MK) HYPO_PATH=$(HYPO_PATH) NAME=ClassNote MAIN_FILE=ClassNote.tex OUT_DIR=$(OUT_DIR) all

class-en: $(ASSET_PDF)
	$(MAKE) -f $(HYPO_MK) HYPO_PATH=$(HYPO_PATH) NAME=ClassNoteEN MAIN_FILE=ClassNoteEN.tex OUT_DIR=$(OUT_DIR) all

litnote: $(ASSET_PDF)
	$(MAKE) -f $(HYPO_MK) HYPO_PATH=$(HYPO_PATH) NAME=LitNote MAIN_FILE=LitNote.tex OUT_DIR=$(OUT_DIR) all

chsh: $(ASSET_PDF)
	$(MAKE) -f $(HYPO_MK) HYPO_PATH=$(HYPO_PATH) NAME=CHSH MAIN_FILE=CHSH.tex OUT_DIR=$(OUT_DIR) all

plot: $(ASSET_PDF)
	$(MAKE) -f $(HYPO_MK) HYPO_PATH=$(HYPO_PATH) NAME=Plot MAIN_FILE=Plot.tex OUT_DIR=$(OUT_DIR) SHELL_ESCAPE=1 all

$(ASSET_PDF): $(ASSET_TEX)
	latexmk -xelatex -interaction=nonstopmode -halt-on-error -outdir=$(ASSET_DIR) $(ASSET_TEX)

edge:
	$(MAKE) -f $(HYPO_MK) HYPO_PATH=$(HYPO_PATH) NAME=ShorthandOff MAIN_FILE=edge/ShorthandOff.tex OUT_DIR=$(OUT_DIR) all
	$(MAKE) -f $(HYPO_MK) HYPO_PATH=$(HYPO_PATH) NAME=BoxesOff MAIN_FILE=edge/BoxesOff.tex OUT_DIR=$(OUT_DIR) all

clean:
	$(MAKE) -f $(HYPO_MK) HYPO_PATH=$(HYPO_PATH) OUT_DIR=$(OUT_DIR) clean
	latexmk -C -outdir=$(ASSET_DIR) $(ASSET_TEX)

watch:
	$(MAKE) -f $(HYPO_MK) HYPO_PATH=$(HYPO_PATH) NAME=Main MAIN_FILE=Main.tex OUT_DIR=$(OUT_DIR) watch

help:
	@echo "Hypoxanthine Tests"
	@echo "  make       - Build mainline test PDF"
	@echo "  make class - Build class test PDF"
	@echo "  make chsh  - Build CHSH test PDF"
	@echo "  make plot  - Build Hypo-Plot test PDF (needs python3 + tikz)"
	@echo "  make edge  - Build edge-case test PDFs"
	@echo "  make watch - Watch & rebuild mainline PDF"
	@echo "  make clean - Remove build directory"
