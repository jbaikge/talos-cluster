# Power Consumption

In order to measure power consumption, the entire block of servers and the switch are plugged into a Z-Wave outlet with power monitoring. This outlet reports power usage to Home Assistant where the data is available.

## Individual Power Draw

| Appliance                       | Draw    |
| ------------------------------- | ------: |
| Unifi Pro Max 24                | 13.10 W |
| Server (Off, IPMI disconnected) | 4.63 W  |
| Server (Off, IPMI connected)    | 5.75 W  |
| Server (On, idle)               | 22.25 W |
| Server (On, 100% CPU)           | 34.45 W |

## Overall Power Draw

| Scenario                | Draw    |
| ----------------------- | ------: |
| Switch on; Servers off  | 36.10 W |
| Switch on; Servers idle | TBD W   |
