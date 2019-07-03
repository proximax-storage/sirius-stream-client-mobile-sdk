# Destroy cell

`Destroy` fixed size cell is sent by either client or node to destroy the existing circuit.

## Payload

    Error Code             [1 byte]

## Supported error codes

Code|Value|Description
----|-----|-----------
None|0|No error, circuit closed
Error Or Connection Closed|1|General error, broken connection
Protocol Error|2|Malformed message on a circuit
Connect Failed|3|Circuit is enable to establish connection to extend
Node Terminated|4|Node terminated the circuit

[All cells](cell.md)