NAME ?= Inferno-Nougat-v1.9-mido

DATE := $(shell date +'%Y%m%d-%H%M')

ZIP := $(NAME)-$(DATE).zip

EXCLUDE := Makefile *.git*

all: $(ZIP)

$(ZIP):
	@echo "Creating ZIP: $(ZIP)"
	@zip -r9 "$@" . -x $(EXCLUDE)
	@echo "Generating SHA1..."
	@sha1sum "$@" > "$@.sha1"
	@cat "$@.sha1"
	@echo "Done."

clean:
	@rm -vf "$(NAME)-"*.zip*
	@rm -vf anykernel/Image.gz-dtb
	@rm -vf META-INF/com/google/android/aroma/changelog.txt
	@echo "Done."
