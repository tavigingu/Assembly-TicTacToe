# Definirea variabilelor
AS = nasm
LD = ld
NASM_FLAGS = -f elf32
LD_FLAGS = -m elf_i386
OBJ_FILES = functions.o TicTacToe.o

# Numele executabilului final
EXEC = tictactoe

# Regula implicită pentru a construi executabilul
all: $(EXEC)

# Regula pentru a construi executabilul
$(EXEC): $(OBJ_FILES)
	$(LD) $(LD_FLAGS) -o $(EXEC) $(OBJ_FILES)

# Regula pentru a asambla fișierele sursă .asm
%.o: %.asm
	$(AS) $(NASM_FLAGS) -o $@ $<

# Curăță fișierele generate (obiecte și executabile)
clean:
	rm -f $(OBJ_FILES) $(EXEC)

# Regula pentru a reconstrui totul
rebuild: clean all

# Regula pentru a rula programul
run: $(EXEC)
	./$(EXEC)
