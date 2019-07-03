# Padding cell

Padding cell is a fixed size cell with payload of all zeros. The cell is being sent periodically on every open TLS connection
if there is no other outgoing activity happening within the last 30 seconds disregarding circuits or streams presence at the moment.
All receiving parties ignore padding cell without acknowledging. Padding cell is no-circuit cell and must carry circuit ID equal zero.

[All cells](cell.md)