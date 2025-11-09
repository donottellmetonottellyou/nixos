{ ... }:
{
  boot.kernelParams = [
    # I need new memory...
    "memmap=0x100000$0x14f100000"
    "memmap=0x100000$0x181d00000"
    "memmap=0x100000$0x1e2700000"
    "memmap=0x100000$0x2fa700000"
  ];
}
