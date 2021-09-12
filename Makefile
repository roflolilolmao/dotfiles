LOCAL := $(HOME)/.local
LOCAL_BIN := $(LOCAL)/bin
DEV_DIR := $(HOME)/dev
HERE := $(shell pwd)

NEOVIM_DIR := $(DEV_DIR)/neovim
NEOVIM_INSTALL_PREFIX := $(LOCAL)
NEOVIM_FLAGS := -j32
NEOVIM_FLAGS += CMAKE_BUILD_TYPE=Release
NEOVIM_FLAGS += CMAKE_INSTALL_PREFIX=$(NEOVIM_INSTALL_PREFIX)

SM_NAMES := $(shell git submodule --quiet foreach 'printf "$$name "')
SM_INDEXES := $(foreach name,$(SM_NAMES),.git/modules/$(name)/index)
module_path = $(shell git config -f .gitmodules --get submodule.$1.path)
module_paths = $(foreach name,$1,$(call module_path,$(name)))

FZF_NATIVE_PATH := $(call module_path,telescope-fzf-native)

CARGO_BIN = $(HOME)/.cargo/bin

define CARGO_template =
CARGO_PROGRAMS += $$(CARGO_BIN)/$1
$$(CARGO_BIN)/$1: force | $$(CARGO_BIN)/cargo
	@cargo install $2
endef

CARGO_BINARIES := \
    rg,ripgrep \
    delta,git-delta \
    fd,fd-find \
    lsd,lsd \
    bat,bat \
    stylua,stylua \
    fnm,fnm

$(foreach pair,$(CARGO_BINARIES),$($(eval $($(call CARGO_template,$(pair))))))

PYTHON := $(addprefix $(LOCAL_BIN)/,pip pipx pipenv)
PIPX := $(addprefix $(LOCAL_BIN)/,jedi-language-server black isort flake8)

# At least I don't have to sudo install these programs :-|
# https://github.com/Schniz/fnm/issues/475
# https://github.com/Schniz/fnm/issues/486
NODE := $(addprefix $(LOCAL_BIN)/,node markdownlint write-good)

PROGRAMS := \
    /bin/zsh \
    /usr/sbin/man \
    /usr/sbin/unzip \
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
    $(NEOVIM_INSTALL_PREFIX)/.installed_nvim

upgrade: yay submodules neovim

neovim: $(NEOVIM_INSTALL_PREFIX)/.installed_nvim

neovimclean:
	cd $(NEOVIM_DIR) && $(MAKE) distclean

$(NEOVIM_INSTALL_PREFIX)/.installed_nvim: $(NEOVIM_DIR)/.git/index | $(LOCAL)
	cd $(NEOVIM_DIR) \
    && $(MAKE) -s $(NEOVIM_FLAGS) nvim > /dev/null \
    && $(MAKE) -s install > /dev/null
	-@cd $(NEOVIM_DIR) && git log "@{1}.." --oneline --no-decorate
	@touch $@

$(NEOVIM_DIR)/.git/index: force | $(NEOVIM_DIR)
	cd $(NEOVIM_DIR) && git pull > /dev/null

$(NEOVIM_DIR): | $(DEV_DIR)
	cd $(DEV_DIR) && git clone https://github.com/neovim/neovim

$(DEV_DIR) .make $(LOCAL_BIN):
	mkdir -p $@

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
	@git submodule update --remote $(call module_path,$*)

yay: /usr/sbin/yay
	yay -Syu --noconfirm

cargo: $(CARGO_PROGRAMS)

$(CARGO_BIN)/cargo:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y

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
	ln -s "$$(realpath $$(which node))" $@

$(LOCAL_BIN)/markdownlint: | $(LOCAL_BIN)/node
	npm i -g markdownlint-cli
	ln -s "$$(realpath $$(which markdownlint))" $@

$(LOCAL_BIN)/write-good: | $(LOCAL_BIN)/node
	npm i -g write-good
	ln -s "$$(realpath $$(which write-good))" $@

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

$(FZF_NATIVE_PATH)/build/libfzf.so:
	cd $(FZF_NATIVE_PATH) && $(MAKE)

$(LOCAL_BIN)/neuron: | $(LOCAL_BIN)/pip
	python download_latest_github_release.py srid/neuron neuron
	chmod u+x $@

zsh/plugins/fzf/bin/fzf: | $(LINKS)
	zsh/plugins/fzf/install --bin

force: ;
.PHONY: upgrade neovim submodules cargo yay all neovimclean
