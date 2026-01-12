# ==========================================
# Hypoxanthine Build System Core
# ==========================================

# 1. 默认配置 (可被外部覆盖)
NAME    ?= Main
OUT_DIR ?= build
TOOL    ?= latexmk
# 关键：-outdir 指定输出目录，-file-line-error 方便 VS Code 捕获错误
FLAGS   ?= -xelatex -synctex=1 -interaction=nonstopmode -file-line-error -outdir=$(OUT_DIR)

# 2. 伪目标定义
.PHONY: all clean watch help prepare

# 3. 默认目标
all: prepare $(NAME).pdf

# 4. 编译规则
$(NAME).pdf: $(MAIN_FILE)
	@echo "🧪 [HYX-Build] Compiling $(NAME)..."
	$(TOOL) $(FLAGS) $(MAIN_FILE)
	@echo "✅ [HYX-Build] Success! Output is in $(OUT_DIR)/$(NAME).pdf"

# 5. 辅助功能
prepare:
	@mkdir -p $(OUT_DIR)

clean:
	@echo "🧹 [HYX-Build] Cleaning build artifacts..."
	rm -rf $(OUT_DIR)

watch: prepare
	@echo "👀 [HYX-Build] Entering watch mode (Ctrl+C to stop)..."
	$(TOOL) $(FLAGS) -pvc $(MAIN_FILE)

help:
	@echo "Hypoxanthine Build System"
	@echo "  make        - Build the PDF"
	@echo "  make watch  - Auto-recompile on save"
	@echo "  make clean  - Remove build directory"