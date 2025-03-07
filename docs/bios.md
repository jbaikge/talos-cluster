# BIOS Settings

BIOS Version 2.17.1245 (2017)

## Main

Each node had an older version of the BIOS and was causing issues during the DXE initialization phase (code 60). Each node got upgraded to Version 2.2 with a build date of 11/22/2019.

Below are the initial BIOS versions of each node:

| Node      | Motherboard | Ver. | Build Date  |
| --------- | ----------- | ---- | ----------- |
| nana      | A1SRi-2758F | 2.1  | 2018-01-18  |
| bartlebee | A1SRi-2758F | 2.0  | 2017-07-24  |
| frisky    | A1SRi-2758F | 2.1  | 2018-01-18  |
| muffin    | A1SRi-2758F | 2.1  | 2018-01-18  |

## Advanced

### Boot Feature

CSM Support: Disable (Do second, reboot)

### CPU Configuration

Keep defaults

### Chipset Configuration

#### North Bridge

Keep defaults

#### South Bridge

##### USB Configuration

Keep defaults

### SATA Configuration

Keep defaults

### PCIe/PCI/PnP Configuration

- PCIe Slot 1 Bifurcation: 4X4X
- Launch Video OpROM Policy: UEFI (Do first, reboot)

### ACPI Settings

Keep defaults

### Super IO Configuration

Keep defaults

### Serial Port Console Redirection

Keep defaults

### iSCSI Configuration

Keep defaults

## IPMI

Version 2.23

### BMC Network Configuration

Keep defaults

## Event Logs

### Change Settings

Keep defaults

## Boot

- Boot Option #1: UEFI: Patriot M.2 P320 128GB
- Boot Option #2: UEFI: USB
- Boot Option #2: UEFI: Built-in EFI Shell

_Note:_ In order to get the 128GB drive as an option, enter "Hard Drive BBS Priorities" and use +/- to move it to the top

## Security

### Secure Boot Menu

1.
