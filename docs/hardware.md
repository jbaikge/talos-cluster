# Hardware

## Nodes

Each node is named after a character from the Bluey TV series

### Kubernetes

- Bartlebee
- Frisky
- Muffin

### Backup

Nana is responsible for taking in backups from the cluster and packaging them for relay up to a cloud provider like Backblaze for off-site storage.

Additionally, Nana will run the Z-wave JS UI and CUPS printing servers as only one server can have USB cables plugged into it.

## Specifications

Each node is a 1U Supermicro 5018A-FTN4 with the following specifications:

- CPU: [Atom C2758](https://www.intel.com/content/www/us/en/products/sku/77988/intel-atom-processor-c2758-4m-cache-2-40-ghz/specifications.html) @ 2.4GHz
- RAM: 2x 8GB DDR3 ECC @ 1600 MHz
- Drive Adapter: M.2 NVMe PCI-e dual bay adapter
- Boot Drive: 128GB Patriot Memory P320 NVMe SSD
- Networking: 4x 1 gigabit ports

The three Kubernetes nodes have the following data drive: 4TB Crucial P3 Plus NVMe SSD

The one backup node has the following data drive: 4TB Western Digital Green HDD
