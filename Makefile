# Makefile for building and serving the blog locally

# Port to serve the blog on
PORT ?= 8080
PUBLIC_DIR = public

.PHONY: all install build serve clean help

# Default target: build the website
all: build

# Install dependencies if node_modules does not exist
install:
	@if [ ! -d "node_modules" ]; then \
		echo "Installing npm dependencies..."; \
		npm install; \
	fi

# Compile / build the blog
build: install
	@echo "Building the blog..."
	@chmod +x build.sh
	@./build.sh
	@echo "============================================="
	@echo "Build complete! Output generated in: $(PUBLIC_DIR)/"
	@echo "============================================="

# Start a local web server (automatically checks for npx or python3)
serve: build
	@echo "Starting local web server on port $(PORT)..."
	@echo "---------------------------------------------"
	@echo "👉 Open your browser at: http://localhost:$(PORT)/blog/"
	@echo "---------------------------------------------"
	@if command -v npx >/dev/null 2>&1; then \
		npx serve -l $(PORT) $(PUBLIC_DIR); \
	elif command -v python3 >/dev/null 2>&1; then \
		python3 -m http.server $(PORT) --directory $(PUBLIC_DIR); \
	else \
		echo "Error: Neither 'npx' nor 'python3' was found in your PATH."; \
		echo "Please install Node.js (npm) or Python 3 to serve the site."; \
		exit 1; \
	fi

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	@rm -rf $(PUBLIC_DIR)
	@echo "Cleanup finished."

# Help information
help:
	@echo "Usage:"
	@echo "  make          - Build the website (compile markdown posts and copy assets)"
	@echo "  make serve    - Build the website and start a local web server"
	@echo "  make clean    - Clean up build artifacts ($(PUBLIC_DIR) folder)"
	@echo "  make install  - Install npm dependencies"
	@echo "  make help     - Show this help message"
	@echo ""
	@echo "You can change the default port (8080) by passing PORT parameter, e.g.:"
	@echo "  make serve PORT=9000"
