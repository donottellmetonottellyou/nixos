{ ... }:
{
  boot.kernelParams = [
    "memmap=0x10000$0x14f1f0000"
    "memmap=0x10000$0x2fa7f0000"
  ];
}
