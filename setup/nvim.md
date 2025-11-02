# Nvim configuration & setup


## jupyter setup

### System dependencies:

Pacman dependencies:
* imagemagick: image.nvim
* python-pynvim: python provider
* python-cairosvg: render transparent svgs
* jupyter: jupyter kernel


AUR dependencies:
* python-jupytext: notebook <-> py conversion
* python-pnglatex: render latex
* python-plotly: plotting
* python-kaleido: plotting

Beware of the requirement for magick (the luarocks package) requires lua51


See [reddit](https://www.reddit.com/r/neovim/comments/17ynpg2/how_to_edit_jupyter_notebooks_in_neovim_with_very/).

### Remote connection:
Start kernel on remote:
```shell
jupyter console --kernel <kernel-name> --ip <ip> -f ~/remote.json
```

then copy file to client:
```shell
scp 1.2.3.4:~/remote.json ./remote.json
```

And run inside neovim:
```
:MoltenInit remote.json
```
TODO: currently this approach does not work for dic lab, maybe go the jupyterhub route or forward all ports mentioned in the json?
    There seems to exist the jupyter console --ssh=<ssh-name>  possibility, did not work for dic

### Rust REPL:
Install [evcxr_jupyter](https://github.com/evcxr/evcxr/tree/main/evcxr_jupyter) from AUR and install its kernel with:

```sh
evcxr_jupyter --install
```

Start the rust kernel using `:MoltenInit rust`.
