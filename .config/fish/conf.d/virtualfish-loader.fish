set -g VIRTUALFISH_VERSION 2.5.2
set -g VIRTUALFISH_PYTHON_EXEC /Users/marco/.local/pipx/venvs/virtualfish/bin/python
if test ! -e $VIRTUALFISH_PYTHON_EXEC
    # TODO: let the user know to `pipx install virtualfish --includedeps` and `vf install`
    exit
end
source /Users/marco/.local/pipx/venvs/virtualfish/lib/python3.10/site-packages/virtualfish/virtual.fish
emit virtualfish_did_setup_plugins
