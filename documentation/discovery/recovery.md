# Discovery - Recovery 

### When a new Discovery instance is brought online it is important to note the following:

* ### It will immediately start collecting publish messages in its local list.

* ### It will immediately have a public listing available with its own verified and validated items along with its own signature.

* ### It will immediately request the most recent final publication of the list from the other known trusted discovery nodes in turn. 

* ### It will immediately attempt to became part of the Raft cluster as a "Candidate". 

* ### It will continue serving its own local list unless it receives a validated public list from its previous request to the other known trusted discovery nodes or it becomes part of the Raft cluster and receives an updated list via Consensus. 

* ### Discovery nodes always check the expiration on their consensus lists before serving. If it is outdated it will serve a fresh copy of its local list with only its own signature included. 


