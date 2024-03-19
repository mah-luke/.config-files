# TMUX setup

for remote hosts with tmux (e.g. into ~/.profile or ~/.bashrc):

```bash
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
  tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux && logout
fi
```
