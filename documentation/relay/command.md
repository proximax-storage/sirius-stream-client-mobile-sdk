# Relay commands

`Relay` cells could carry following relay commands:

Command|ID|Description|Level
-------|--|-----------|-----
Extend|1|[Extend the circuit](extend.md)|Onion
Extended|2|[Circuit extended confirmation](extended.md)|Onion
Escape|3|[Switch from onion to application level](escape.md)|Application
Establish Rendezvous|4|[Establish rendezvous point](establishrendezvous.md)|Rendezvous
Rendezvous Established|5|[Rendezvous established confirmation](rendezvousestablished.md)|Rendezvous
Join Rendezvous|6|[Join rendezvous point](joinrendezvous.md)|Rendezvous
Rendezvous Joined 1|7|[Rendezvous joined confirmation](rendezvousjoined1.md)|Rendezvous
Rendezvous Joined 2|8|[Rendezvous joined confirmation](rendezvousjoined2.md)|Rendezvous

[Relay cell](../binary/relay.md)