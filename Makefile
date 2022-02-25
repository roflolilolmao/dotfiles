LOCAL := $(HOME)/.local
LOCAL_BIN := $(LOCAL)/bin
DEV_DIR := $(HOME)/dev
HERE := $(shell pwd)

SM_NAMES := $(shell git submodule --quiet foreach 'printf "$$name "')
SM_INDEXES := $(foreach name,$(SM_NAMES),.git/modules/$(name)/index)
module_path = $(shell git config -f .gitmodules --get submodule.$1.path)
module_paths = $(foreach name,$1,$(call module_path,$(name)))

FZF_NATIVE_PATH := $(call module_path,telescope-fzf-native)

NEOVIM_DIR := $(DEV_DIR)/neovim
NEOVIM_INSTALL_PREFIX := $(LOCAL)
NEOVIM_FLAGS := -j32
NEOVIM_FLAGS += CMAKE_BUILD_TYPE=Release
NEOVIM_FLAGS += CMAKE_INSTALL_PREFIX=$(NEOVIM_INSTALL_PREFIX)

CARGO_BIN := $(HOME)/.cargo/bin

CARGO_PROGRAMS := $(addprefix $(CARGO_BIN)/,rg delta fd lsd bat stylua fnm)
PYTHON := $(addprefix $(LOCAL_BIN)/,pip pipx pipenv)
PIPX := $(addprefix $(LOCAL_BIN)/,jedi-language-server black isort flake8)

# At least I don't have to sudo install these programs :-|
# https://github.com/Schniz/fnm/issues/475
# https://github.com/Schniz/fnm/issues/486
NODE := $(addprefix $(LOCAL_BIN)/,node stylelint eslint_d)
NODE_PROGRAMS := $(addprefix $(LOCAL_BIN)/,markdownlint write-good npx svelte prettier)

PROGRAMS := \
    /bin/zsh \
    /usr/sbin/man \
    /usr/sbin/unzip \
    /usr/sbin/rust-analyzer \
    /usr/sbin/lldb \
    $(LOCAL_BIN)/win32yank.exe \
    $(CARGO_BIN)/cargo \
    $(FZF_NATIVE_PATH)/build/libfzf.so \
    $(LOCAL_BIN)/neuron \
    zsh/plugins/fzf/bin/fzf

LINKS :=  \
    /etc/wsl.conf \
    $(HOME)/.ssh \
    $(HOME)/.zshenv

all: \
    $(LINKS) \
    $(PROGRAMS) \
    $(CARGO_PROGRAMS) \
    $(PYTHON) \
    $(PIPX) \
    $(NODE) \
    $(NODE_PROGRAMS) \
    $(NEOVIM_INSTALL_PREFIX)/.installed_nvim

upgrade: yay all submodules neovim

$(DEV_DIR) .make $(LOCAL_BIN):
	mkdir -p $@

yay: /usr/sbin/yay
	yay -Syu --noconfirm

neovim: $(NEOVIM_INSTALL_PREFIX)/.installed_nvim

neovimclean:
	cd $(NEOVIM_DIR) && $(MAKE) distclean
	rm -r $(NEOVIM_INSTALL_PREFIX)/share/nvim/runtime
	rm $(NEOVIM_INSTALL_PREFIX)/.installed_nvim

$(NEOVIM_INSTALL_PREFIX)/.installed_nvim: $(NEOVIM_DIR)/.git/index | $(LOCAL)
	cd $(NEOVIM_DIR) \
    && $(MAKE) -s $(NEOVIM_FLAGS) nvim \
    && $(MAKE) -s install
	-@cd $(NEOVIM_DIR) && git log "@{1}.." --oneline --no-decorate
	@touch $@

$(NEOVIM_DIR)/.git/index: force | $(NEOVIM_DIR)
	cd $(NEOVIM_DIR) && git pull > /dev/null

$(NEOVIM_DIR): | $(DEV_DIR)
	cd $(DEV_DIR) && git clone https://github.com/neovim/neovim

cargo: $(CARGO_PROGRAMS)

$(CARGO_BIN)/cargo:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y

define CARGO_template =
$(CARGO_BIN)/$(1): force | $(CARGO_BIN)/cargo
	@cargo install $(2)
endef

$(eval $(call CARGO_template,rg,ripgrep))
$(eval $(call CARGO_template,delta,git-delta))
$(eval $(call CARGO_template,fd,fd-find))
$(eval $(call CARGO_template,lsd,lsd))
$(eval $(call CARGO_template,bat,bat))
$(eval $(call CARGO_template,stylua,stylua))
$(eval $(call CARGO_template,fnm,fnm))

$(LOCAL_BIN)/pip: | $(LOCAL_BIN)
	python -m ensurepip
	python -m pip install --upgrade pip
	python -m pip install rich requests

$(LOCAL_BIN)/pipx $(LOCAL_BIN)/pipenv: | $(LOCAL_BIN)/pip
	python -m pip install $(@F)

$(PIPX): | $(LOCAL_BIN)/pipx
	pipx install $(@F)

$(LOCAL_BIN)/node: | $(CARGO_BIN)/fnm $(LOCAL_BIN)
	fnm install --lts
	ln -sf "$$(realpath $$(which node))" $@

$(LOCAL_BIN)/stylelint: | $(LOCAL_BIN)/node
	npm install --force -g stylelint postcss-scss stylelint-config-sass-guidelines
	ln -sf "$$(realpath $$(which $(@F)))" $@

$(LOCAL_BIN)/eslint_d: | $(LOCAL_BIN)/node
	npm install --force -g eslint_d eslint-config-prettier eslint-plugin-prettier eslint-plugin-svelte3
	ln -sf "$$(realpath $$(which $(@F)))" $@

$(NODE_PROGRAMS): | $(LOCAL_BIN)/node
	npm install --force -g $(@F)
	-ln -sf "$$(realpath $$(which $(@F)))" $@

/usr/sbin/yay: | $(DEV_DIR)
	sudo pacman-mirrors --fasttrack && sudo pacman -Syyu --noconfirm
	sudo pacman -S --needed --noconfirm git base-devel yay

/bin/zsh: | /usr/sbin/yay
	yay -S zsh

/usr/sbin/%: | /usr/sbin/yay
	yay -S $(@F)

$(HOME)/.zshenv: | /bin/zsh
	ln -sf $(HERE)/zsh/.zshenv $(HOME)/.zshenv
	chsh -s /bin/zsh q

/etc/wsl.conf:
	sudo ln -sf $(HERE)/wsl.conf /etc/wsl.conf

$(HOME)/.ssh:
	sudo ln -sf /mnt/c/Users/kelst/.ssh $(HOME)/.ssh

$(LOCAL_BIN)/win32yank.exe: | /usr/sbin/unzip $(LOCAL_BIN)
	curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
	unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
	chmod +x /tmp/win32yank.exe
	mv /tmp/win32yank.exe $(LOCAL_BIN)/

$(LOCAL_BIN)/neuron: | $(LOCAL_BIN)/pip
	python download_latest_github_release.py srid/neuron neuron
	chmod u+x $@

submodules: .make/changes

.make/changes: COMMIT := $(shell mktemp)
.make/changes: $(SM_INDEXES) | .make
	@echo "Automated submodules update." > $(COMMIT)
	@echo "" >> $(COMMIT)
	@git submodule summary >> $(COMMIT)
	-git commit \
        -F $(COMMIT) \
        $(call module_paths,$(patsubst .git/modules/%/index,%,$?)) \
        > /dev/null \
    && git show --no-patch
	@touch $@

.git/modules/%/index: force
	git submodule update --remote $(call module_path,$*)

$(FZF_NATIVE_PATH)/build/libfzf.so: .git/modules/telescope-fzf-native/index
	cd $(FZF_NATIVE_PATH) && $(MAKE) clean && $(MAKE)

zsh/plugins/fzf/bin/fzf: .git/modules/fzf/index | $(LINKS)
	rm $@
	zsh/plugins/fzf/install --bin
	touch $@

force: ;
.PHONY: upgrade neovim submodules cargo yay all neovimclean
