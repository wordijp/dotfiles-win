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
	.ycm_extra_conf.py \
	tslint.json \
	cmd_autorun.bat \
	cmd_macros.txt \
	cmd_macro_cd.bat

DIRS	= \
	.phan \
	.phpstan \
	.vim \
	.vscode

CUR_DIR	= $(subst /,\,${CURDIR})

DEST_FILES	= $(patsubst %, ${USERPROFILE}\\%, $(FILES))
DEST_DIRS	= $(patsubst %, ${USERPROFILE}\\%, $(DIRS))

# -----------------------------------------------

all:

install: mklink

mklink: $(DEST_FILES) $(DEST_DIRS)

${USERPROFILE}\\%: ${CUR_DIR}\\%
	@if [ -d "$<" ]; then         \
		cmd /c "mklink /D $@ $<"; \
	else                          \
		cmd /c "mklink $@ $<";    \
	fi
