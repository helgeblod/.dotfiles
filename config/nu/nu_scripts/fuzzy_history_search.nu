# def fuzzy_history_search [] { cat $nu.history-path | fzf | clip }
def hst [] {
	let x = (history | reverse | each { echo [$it (char nl)] } | str collect | fzf --header '[HISTORY]')
	let y = $'tell application "System Events" to keystroke "($x)"'
	osascript -e $y
}
