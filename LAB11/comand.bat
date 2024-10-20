nasm -f obj 6-1.asm
nasm -f obj module6-1.asm
alink 6-1.obj module6-1.obj -oPE -subsys console -entry start
module6-1.exe
cmd /k