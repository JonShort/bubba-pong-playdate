# Bubba Pong

![Game splash screen](/Source/Images/card.png "Game splash screen")

Bubba the ping-pong grandmaster challenges you to a first-to-five game of ping-pong.

## How to play

Moving your bat left and right, try to hit the ball past Bubba - who is guarding the top of the screen.

<img width="397" alt="Gameplay" src="https://user-images.githubusercontent.com/21317379/192146490-8230c34e-5817-4f8d-85e4-99b7ee5435dd.png">

## Controls

- `d-pad left` - move left
- `d-pad right` - move right
- `b` - speed up movement (press and hold)

## Acknowledgements

Character "Bubba the panda" created by [@paulwallas](https://github.com/paulwallas)

Game inspired by the web-based [bubba-pong](https://github.com/eddielee6/Bubba-Pong) by [@eddielee6](https://github.com/eddielee6)

---

## Development

Development of this game requires the [playdate SDK](https://play.date/dev/), which includes a compiler CLI and device simulator.

### Architecture

Documentation on the architecture of this game can be found in the [Architecture folder](./Architecture/).

### Compiling

The game is compiled with the playdate SDK command-line tool, which accepts an input (Source), and produces an output `.pdx` file (bubba-pong-playdate.pdx).

```bash
pdc Source bubba-pong-playdate.pdx
```

> note: the `-s` flag can be used to strip debug from the output (e.g. for a release build)

### Running the game with Playdate Simulator

Once compiled, the game can be run within the simulator by opening the `.pdx` output file.

On macOS you can `open` the `.pdx` file from the terminal, which is very fast

```bash
open bubba-pong-playdate.pdx
```

### Running the game on an actual Playdate device

Once the game is running within the simulator, make sure your playdate is connected and turned on.

Choose "Upload Game to Device" from the Simulator's "Device" menu.

> note: the "Device" menu only appears when a playdate is connected
