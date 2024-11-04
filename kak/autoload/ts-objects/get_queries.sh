# toml make jsx fish cmake
for lang in python yaml json c; do
    curl -sL "https://github.com/helix-editor/helix/blob/master/runtime/queries/$lang/textobjects.scm?raw=true" >queries/$lang.scm
done
