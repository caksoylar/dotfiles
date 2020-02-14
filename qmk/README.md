# Keymap Layout for Iris rev. 4

This is a mostly vanilla layout which was initially generated using the QMK
Configurator. Some additions were made to enable `Ctrl+GUI` key combinations,
the encoder and a tmux layer. Mouse keys are enabled in `rules.mk` to use
mouse wheel codes.

The encoder currently does the following:
- In the default layer, performs mouse wheel up and down, tap plays/pauses
- In layer 1, turns volume up and down
- In layer 2, changes RGB hue

The tmux layer on 3 sends a prefix (`Ctrl+Space`) before any pressed key.
