# Tic-Tac-Toe in Assembly (x86)

This project implements the game **Tic-Tac-Toe** (X and O) in **x86 Assembly** language. The game is played between two players, each placing an "X" or an "O" on a 3x3 grid. The goal is to form a complete line, column, or diagonal with your symbol.

## How the Game Works

1. **Game Board**: The game board is represented by a table of 9 cells (3x3), initially filled with `_`.
2. **Players**: Player 1 plays with "X" and goes first, while Player 2 plays with "O".
3. **Moves**: Each player selects a position (row and column) to place their symbol.
4. **Winner/Draw**: The game checks if a player has won or if the game ends in a draw (all cells filled without a winner).
5. **Move Validation**: Each move is validated to ensure the chosen position is not already occupied and is within the valid range (1-3 for rows and columns).

## Implementation Details

- **Language**: The program is written in **x86 Assembly** for 32-bit architecture (compatible with 32-bit systems).
- **System Calls**: The program uses system calls to:
  - **Read user input**: Uses `string.Read` for reading the row and column input from the user.
  - **Display messages**: Uses `char.Print` and `string.PrintEndl` to print status messages (winner, draw, error).
  - **Conversion**: Uses `string.atoi` for converting user input into integer values.

## How to Use

1. **Start the game**: Upon starting, the game will prompt the player to enter the row and column for their move.
2. **Exit**: Press `q` at any time to exit the game.

## Compilation and Running

1. Make sure you have **NASM** (assembler) and **Linux** installed.
2. Compile the source file:

    ```bash
    nasm -f elf32 -o tictactoe.o tictactoe.asm
    ```

3. Link the object file:

    ```bash
    ld -m elf_i386 -s -o tictactoe tictactoe.o
    ```

4. Run the game:

    ```bash
    ./tictactoe
    ```
