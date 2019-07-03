# AuthBypass cell

`AuthBypass` cell is a variable size cell with no payload. This cell is sent by initiator as a response to
`AuthChallenge` cell if the initiating side doesn't want to authenticate. If node does not support the `AllowBypass`
authentication method it will destroy the circuit.

[All cells](cell.md)