# Auction contracts

Excercise 1
====
In this exercise, you are expected to design an open auction smart contract **openAuction** using solidity programing language. In an open auction, every participant is able to see the highest bid in the current period. Your code should implement the following logic.

1. Your contract constructor function should specify how long the *bidding time* will be and who will be the *beneficiary*.

2. A function __submitBid()__ can accept bids from any pariticipants and accepts their deposits within the bidding time. After the bidding time elapsed, no one can submit bids. The function only accepts a bid that beats the current highest bid. Within the bidding time, each bidder can submit bids multiple times. 

3. A funcion __auctionEnd()__ can be called after the bidding time which will select the bidder who submits the **second highest** bid as the winner. His deposit is transfered to the beneficiary.

4. The other bidders losing the auction is able to call the __withdraw()__ function to take back their deposits.

Excersice 2
====
In this excercise, you are required to implement a blinded auction protocol and write a **blindAuction** smart contract. In a blinded auction, paritipants are not allowed to see other bidders' bids and the highest bid. There will be two time periods, the first one is called bidding period, within which each pariticipant can submit a hash string to represent their bids. The other is called reveal period, within which each pariticipant need to reveal their real bids (the preimage of submitted hash). The bidding period starts and ends strictly before the reveal period.

Your contract should implement the following lodic.

1. The contract deployer specifies the *bidding time*, *reveal time*, and *beneficiary*.
2. The insterested bidders should hide their real bids by submitting a *hash* and transfer an arbitrary amount of value as the deposit. Specifically, the hash can be computed from a triplet of [fake (boolean), amount (int), secret(bytes32)]), each bidder needs to call this function multiple times to submit different hashes (computed from different triplets) to hide their real bids. 
3. The contract only accept bids during the bidding time, and after that no one can submit bids and the reveal timer ticker starts. 
4. During the reveal time, each bidder need to reveal each of their previous submitted hash by sending the raw triplets to the contract. The contract then check if the hash of each raw triplet is equal to the submitted hash. If not, the contract do not allow the bidder to withdraw the corresponding deposits.
5. After the reveal time, the **second highest bidder** will be the winner and his deposit will be transfered to the beneficiary.
6. The other bidders losing the auction *withdraw* their deposits.
