FILES	= \
	.ctags \
	.eslintrc.yml \
	.gemrc \
	.gitconfig \
	.gitconfig.local \
	.gitignore \
	_vimrc \
	.vimrc_first.vim \
	_gvimrc \
	.gvimrc_first.vim \
	.pylintrc \
	.pycodestyle \
	.ycm_extra_conf.py \
	tslint.json \

DIRS	= \
	.phan \
	.phpstan \
	.vim \
	.vscode \
	.cmd \
	.clink

USER_PROFILE = $(subst \,/,${USERPROFILE})

DEST_FILES	= $(patsubst %, ${USER_PROFILE}/%, $(FILES))
DEST_DIRS	= $(patsubst %, ${USER_PROFILE}/%, $(DIRS))

MKLINK_FLAGS =

# -----------------------------------------------

all:

install: mklink

mklink: mklink_f mklink_d

mklink_f: init_f $(DEST_FILES)
init_f:
	$(eval MKLINK_FLAGS := )

mklink_d: init_d $(DEST_DIRS)
init_d:
	$(eval MKLINK_FLAGS := /D)

${USER_PROFILE}/%: ${CURDIR}/%
	@rm -rf $@
	@cmd /c 'mklink ${MKLINK_FLAGS} $(subst /,\,$@) $(subst /,\,$<)'
