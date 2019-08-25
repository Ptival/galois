all: checkout

GALOIS=$(shell pwd)

CODESCAPE_PROJECTS=\
	codescape\
	polysemy

SAW_PROJECTS=\
	abcBridge\
	aig\
	binary-symbols\
	crucible\
	crucible-jvm\
	crucible-llvm\
	crucible-saw\
	crux\
	cryptol\
	cryptol-verifier\
	elf-edit\
	flexdis86\
	galois-dwarf\
	jvm-parser\
	jvm-verifier\
	llvm-pretty\
	llvm-pretty-bc-parser\
	llvm-verifier\
	macaw-base\
	macaw-x86\
	macaw-symbolic\
	macaw-x86-symbolic\
	parameterized-utils\
	saw-core\
	saw-core-aig\
	saw-core-coq\
	saw-core-sbv\
	saw-core-what4\
	saw-script\
	what4

build:
	nix-shell

checkout:
	for i in ${SAW_PROJECTS}; do (\
		echo "\n\n\n>>>>> $$i"; \
		cd scripts; \
		GALOIS=${GALOIS} ./checkout.sh saw $$i; \
	); done
	echo "DONE"

default-nix:
	for i in ${CODESCAPE_PROJECTS}; do (\
		echo "\n\n\n>>>>> $$i"; \
		cd scripts; \
		GALOIS=${GALOIS} ./generate-default-nix.sh codescape $$i; \
	); done
	for i in ${SAW_PROJECTS}; do (\
		echo "\n\n\n>>>>> $$i"; \
		cd scripts; \
		GALOIS=${GALOIS} ./generate-default-nix.sh saw $$i; \
	); done
	echo "DONE"

.PHONY: all checkout clean update
