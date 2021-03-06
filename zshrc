# basic
export LANG=ja_JP.UTF-8
autoload -U compinit
compinit -u
autoload -U colors
colors

# git
autoload -Uz vcs_info

# 表示フォーマットの指定
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
  if [ $TERM = "screen" ]; then
    echo -ne "\ek$(basename $SHELL)\e\\"
  fi
  psvar=()
  LANG=ja_JP.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
RPROMPT="%1(v|%F{green}%1v%f|)"

# プロンプト表示形式
PROMPT='%(5~,%-2~/.../%2~,%~)%# '

# Emacsキーバインド
bindkey -e

# 履歴
HISTFILE=$HOME/.zsh-history
HISTSIZE=1000
SAVEHIST=1000

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt append_history

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups

# コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space

# シェルのプロセスごとに履歴を共有
setopt share_history

# history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store

# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

# 補完候補が複数ある時に、一覧表示する
setopt auto_list

# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完する
#setopt auto_menu

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# ディレクトリスタックに同じディレクトリを追加しないようになる
setopt pushd_ignore_dups

# 8 ビット目を通すようになり、日本語のファイル名などを見れるようになる
setopt print_eightbit

# 色を使う
setopt prompt_subst

# ビープ音を鳴らさないようにする
setopt NO_beep

# 補完で大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Colorize
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
case "${OSTYPE}" in
  darwin*)
    alias ls="ls -G"
    ;;
  linux*)
    alias ls='ls --color'
    ;;
esac

# Use user local
export PATH=/usr/local/bin:$PATH

# java
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"
alias be='bundle exec'

# nodenv
export PATH=$HOME/.nodebrew/current/bin:$PATH

# myqsl
export PATH=/usr/local/mysql-5.6/bin:$PATH

# redis
export PATH=/usr/local/redis-2.8/bin:$PATH

# cdd
if [ -f /usr/local/bin/cdd ]; then
  source /usr/local/bin/cdd
  chpwd() {
    _cdd_chpwd
  }
fi

# 環境ごと
[ -f ~/.zshrc.private ] && source ~/.zshrc.private
