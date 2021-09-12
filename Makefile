LOCAL := $(HOME)/.local
DEV_DIR := $(HOME)/dev

all: neovim submodules

NEOVIM_DIR := $(DEV_DIR)/neovim
NEOVIM_INSTALL_PREFIX := $(LOCAL)
NEOVIM_FLAGS := -j32
NEOVIM_FLAGS += CMAKE_BUILD_TYPE=Release
NEOVIM_FLAGS += CMAKE_INSTALL_PREFIX=$(NEOVIM_INSTALL_PREFIX)

neovim: $(NEOVIM_INSTALL_PREFIX)/.installed_nvim

neovimclean:
	cd $(NEOVIM_DIR) && $(MAKE) distclean

$(NEOVIM_INSTALL_PREFIX)/.installed_nvim: $(NEOVIM_DIR)/.git/index
	cd $(NEOVIM_DIR) \
    && $(MAKE) -s $(NEOVIM_FLAGS) nvim > /dev/null \
    && $(MAKE) -s install > /dev/null \
    && git log "@{1}.." --oneline --no-decorate
	@touch $@

$(NEOVIM_DIR)/.git/index: $(NEOVIM_DIR) force
	cd $< && git pull > /dev/null

$(NEOVIM_DIR): $(DEV_DIR)
	cd $< && git clone https://github.com/neovim/neovim

$(DEV_DIR) .make:
	mkdir -p $@

SM_NAMES := $(shell git submodule --quiet foreach 'printf "$$name "')
SM_INDEXES := $(foreach name,$(SM_NAMES),.git/modules/$(name)/index)
module_path = $(shell git config -f .gitmodules --get submodule.$1.path)
module_paths = $(foreach name,$1,$(call module_path,$(name)))

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

CARGO_BIN = $(HOME)/.cargo/bin

define CARGO_template =
CARGO_PROGRAMS += $$(CARGO_BIN)/$1
$$(CARGO_BIN)/$1: force | $$(CARGO_BIN)/cargo
	@cargo install $2
endef

$(eval $(call CARGO_template,rg,ripgrep))
$(eval $(call CARGO_template,delta,git-delta))
$(eval $(call CARGO_template,fd,fd-find))
$(eval $(call CARGO_template,lsd,lsd))
$(eval $(call CARGO_template,stylua,stylua))
$(eval $(call CARGO_template,fnm,fnm))

cargo: $(CARGO_PROGRAMS)

$(CARGO_BIN)/cargo:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y

PROGRAMS := \
    /bin/zsh \
    /usr/sbin/man \
    /usr/sbin/unzip \
    $(LOCAL)/bin/win32yank.exe \
    $(CARGO_BIN)/cargo

LINKS :=  \
    /etc/wsl.conf \
    $(HOME)/.ssh \
    $(HOME)/.zshenv

first_install: $(LINKS) $(PROGRAMS) all

/usr/sbin/yay: $(DEV_DIR)
	sudo pacman-mirrors --fasttrack && sudo pacman -Syyu --noconfirm
	sudo pacman -S --needed git base-devel --noconfirm
	cd $< && git clone https://aur.archlinux.org/yay.git
	cd $</yay && makepkg -si --noconfirm
	rm -rf $</yay

/bin/zsh: /usr/sbin/yay
	yay -S zsh

/usr/sbin/%: /usr/sbin/yay
	yay -S $(@F)

$(HOME)/.zshenv /etc/wsl.conf $(HOME)/.ssh &: /bin/zsh
	chsh -s /bin/zsh q
	ln -s zsh/.zshenv $(HOME)/.zshenv
	sudo ln -sf wsl.conf /etc/wsl.conf
	sudo ln -s /mnt/c/Users/kelst/.ssh $(HOME)/.ssh

$(LOCAL)/bin/win32yank.exe: /usr/sbin/unzip
	curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
	unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
	chmod +x /tmp/win32yank.exe
	mv /tmp/win32yank.exe $(LOCAL)/bin

force: ;
.PHONY: all neovim submodules cargo yay first_install neovimclean
