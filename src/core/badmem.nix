{ ... }:
{
  boot.kernelParams = [
    # Map 0x2fa7f3700-0x2fa7f37ff inclusive as bad memory
    "memmap=0x100$0x2fa7f3700"
  ];
}
