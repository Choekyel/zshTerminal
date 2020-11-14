# Add '~/bin' to the '$PATH'
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
for file in ~/.{zshrc,aliases}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

## Git auto-complete
#if [ -f ~/.git-completion.bash ]; then
#	source ~/.git-completion.bash
#fi

# Setting PATH for Python 3.9
# The original version is saved in .zprofile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
# export PATH
