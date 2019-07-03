# Discovery Multi-Signature Consensus

### The ultimate goal of Discovery is to provide a trusted list of all known authority and onion nodes publically to the network. In order to do this securely and also support scaling for very large networks each Discovery instance has the ability to operate collaboratively with other Discovery nodes as follows:


* ### When three or more Discovery nodes are running they will automatically work together to form a cluster and attempt to elect a leader. 


* ### If a Discovery node is not part of a cluster of at least three it is considered operating in standalone mode. In this mode the list generated and served will only be verified and signed by this single standalone Discovery node instance. 

* ### We are guaranteed that there will be one and only one Discovery leader node. Every other node will be deemed a follower.

* ### If the Discovery leader node loses communication with the cluster or does something that is not considered appropriate by a majority of the followers it will be demoted and a new leader will be elected.

* ### All Discovery nodes will maintain their own list of published items regardless of whether it is a leader, follower or operating in standalone mode.

* ### After adding a publish item to its own list, follower Discovery nodes will _sign_ each original incoming packet and forward it to the leader node. 

* ### The leader node will collect all forwarded publish items, including the ones in its own list, and maintain a collaborative list that is read-only accessible to the followers. Hence the pool of publish items known to any one discovery node will also be known to all. If the leader drops out, ownership of the collaborative list will be transferred to the new leader. The leader verfies the both the signatures of the discovery node forwarding the packet as well as the signature on the packet itself. The latter being a re-verification since the forwarder does this as well. 

* ### Each element in the collaborative list will contain the original published item packet along with the signature (and expiration) of every discovery node from which it has been originally received, verified and forwarded. The result is a list of nodes along with the discovery cluster's validation awareness for each in the form of a sublist of discovery signatures.

* ### The leader discovery node will periodically pause adding to the collaborative list while still continuing to collect publish items in a local queue. During this state it will contact the other follower discovery nodes and request for them to _vote_ on the authenticity of the shared (and now frozen) collaborative list. At this time the discovery leader will also cast its own vote.

* ### The discovery leader will wait a configurable amount of time for all followers to respond to the vote request. This is termed a "Voting Round". A vote of YES is indicated by a response containing the signature of the follower discovery node's read-only view of the collaborative list. 

* ### Discovery nodes (leader and followers) will vote YES on the frozen collaborative list if 75% or more of the entries are valid _(configurable)_. During this process each publish item is examined and determined valid only if the number of trusted discovery signatures attached is >= 50% of all the known discovery nodes _(again configurable)_. Signatures are not counted if they have expired or can not be validated.  

* ### Once the alotted time to receive votes has been exceeded the leader will _Calculate Consensus_ on the current frozen collaborative list. 

* ### Each vote signature is validated against the leader's view of the collaborative list.  If the leader gets 50% or more valid signatures via votes out of all the known discovery nodes then Consensus has been reached. 

* ### If Consensus is determined the set of voting discovery signatures is dispatched from the leader to all the followers. Each follower verifies the signature list again and if its ok makes the frozen list and the signatures available publically. 

