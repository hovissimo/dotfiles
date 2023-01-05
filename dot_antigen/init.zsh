#-- START ZCACHE GENERATED FILE
#-- GENERATED: Mon Dec  5 11:59:38 AM PST 2022
#-- ANTIGEN develop
_antigen () {
	local -a _1st_arguments
	_1st_arguments=('apply:Load all bundle completions' 'bundle:Install and load the given plugin' 'bundles:Bulk define bundles' 'cleanup:Clean up the clones of repos which are not used by any bundles currently loaded' 'cache-gen:Generate cache' 'init:Load Antigen configuration from file' 'list:List out the currently loaded bundles' 'purge:Remove a cloned bundle from filesystem' 'reset:Clears cache' 'restore:Restore the bundles state as specified in the snapshot' 'revert:Revert the state of all bundles to how they were before the last antigen update' 'selfupdate:Update antigen itself' 'snapshot:Create a snapshot of all the active clones' 'theme:Switch the prompt theme' 'update:Update all bundles' 'use:Load any (supported) zsh pre-packaged framework') 
	_1st_arguments+=('help:Show this message' 'version:Display Antigen version') 
	__bundle () {
		_arguments '--loc[Path to the location <path-to/location>]' '--url[Path to the repository <github-account/repository>]' '--branch[Git branch name]' '--no-local-clone[Do not create a clone]'
	}
	__list () {
		_arguments '--simple[Show only bundle name]' '--short[Show only bundle name and branch]' '--long[Show bundle records]'
	}
	__cleanup () {
		_arguments '--force[Do not ask for confirmation]'
	}
	_arguments '*:: :->command'
	if (( CURRENT == 1 ))
	then
		_describe -t commands "antigen command" _1st_arguments
		return
	fi
	local -a _command_args
	case "$words[1]" in
		(bundle) __bundle ;;
		(use) compadd "$@" "oh-my-zsh" "prezto" ;;
		(cleanup) __cleanup ;;
		(update|purge) compadd $(type -f \-antigen-get-bundles &> /dev/null || antigen &> /dev/null; -antigen-get-bundles --simple 2> /dev/null) ;;
		(theme) compadd $(type -f \-antigen-get-themes &> /dev/null || antigen &> /dev/null; -antigen-get-themes 2> /dev/null) ;;
		(list) __list ;;
	esac
}
antigen () {
  local MATCH MBEGIN MEND
  [[ "$ZSH_EVAL_CONTEXT" =~ "toplevel:*" || "$ZSH_EVAL_CONTEXT" =~ "cmdarg:*" ]] && source "/home/hovis/.antigen/antigen.zsh" && eval antigen $@;
  return 0;
}
typeset -gaU fpath path
fpath+=(/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib /home/hovis/.antigen/bundles/arialdomartini/oh-my-git /home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/ssh-agent) path+=(/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib /home/hovis/.antigen/bundles/arialdomartini/oh-my-git /home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/ssh-agent)
_antigen_compinit () {
  autoload -Uz compinit; compinit -i -d "/home/hovis/.antigen/.zcompdump"; compdef _antigen antigen
  add-zsh-hook -D precmd _antigen_compinit
}
autoload -Uz add-zsh-hook; add-zsh-hook precmd _antigen_compinit
compdef () {}

if [[ -n "/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh" ]]; then
  ZSH="/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh"; ZSH_CACHE_DIR="/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/cache/"
fi
#--- BUNDLES BEGIN
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/bzr.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/clipboard.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/cli.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/compfix.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/completion.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/correction.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/diagnostics.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/directories.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/functions.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/git.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/grep.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/history.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/key-bindings.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/misc.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/nvm.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/prompt_info_functions.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/spectrum.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/termsupport.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/theme-and-appearance.zsh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/vcs_info.zsh';
source '/home/hovis/.antigen/bundles/arialdomartini/oh-my-git/base.sh';
source '/home/hovis/.antigen/bundles/arialdomartini/oh-my-git/prompt.sh';
source '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/ssh-agent/ssh-agent.plugin.zsh';
source '/home/hovis/.antigen/bundles/arialdomartini/oh-my-git-themes/arialdo-granzestyle.zsh-theme.antigen-compat';

#--- BUNDLES END
typeset -gaU _ANTIGEN_BUNDLE_RECORD; _ANTIGEN_BUNDLE_RECORD=('https://github.com/robbyrussell/oh-my-zsh.git lib plugin true' 'https://github.com/arialdomartini/oh-my-git.git / plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/ssh-agent plugin true' 'https://github.com/arialdomartini/oh-my-git-themes.git arialdo-granzestyle.zsh-theme theme true')
typeset -g _ANTIGEN_CACHE_LOADED; _ANTIGEN_CACHE_LOADED=true
typeset -ga _ZCACHE_BUNDLE_SOURCE; _ZCACHE_BUNDLE_SOURCE=('/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/bzr.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/clipboard.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/cli.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/compfix.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/completion.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/correction.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/diagnostics.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/directories.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/functions.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/git.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/grep.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/history.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/key-bindings.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/misc.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/nvm.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/prompt_info_functions.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/spectrum.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/termsupport.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/theme-and-appearance.zsh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/lib/vcs_info.zsh' '/home/hovis/.antigen/bundles/arialdomartini/oh-my-git//' '/home/hovis/.antigen/bundles/arialdomartini/oh-my-git///base.sh' '/home/hovis/.antigen/bundles/arialdomartini/oh-my-git///prompt.sh' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/ssh-agent' '/home/hovis/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/ssh-agent/ssh-agent.plugin.zsh' '/home/hovis/.antigen/bundles/arialdomartini/oh-my-git-themes/arialdo-granzestyle.zsh-theme' '/home/hovis/.antigen/bundles/arialdomartini/oh-my-git-themes/arialdo-granzestyle.zsh-theme')
typeset -g _ANTIGEN_CACHE_VERSION; _ANTIGEN_CACHE_VERSION='develop'
typeset -g _ANTIGEN_THEME; _ANTIGEN_THEME='arialdomartini/oh-my-git-themes arialdo-granzestyle'

#-- END ZCACHE GENERATED FILE
