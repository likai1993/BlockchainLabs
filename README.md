# Auction contracts

Excercise 1
====
In this lab, you are expected to design an open auction smart contract **openAuction** using solidity programing language.
Your code should implement the following logic.

1. The smart contract deployer specifies how long the *bidding time* will last for and who will be the *beneficiary* when deploying the contract. 

2. After the contract is deployed, within the bidding time, any insterested bidders can submit their bids and deposit the bidding value to the contract. After the bidding time, the contract does not accept any bids. 

3. After the bidding time, the bidder submitting the **second highest** bid wins the auction, and his deposit is transfered to the beneficiary.

4. The other bidders losing the auction is able to *withdraw* their deposits.

Excersice 2
====
The above excercise aims to implement the open auction protocol, in this excercise, you are required to implement a blinded auction protocol and write a **blindAuction** smart contract.  In a blinded auction, there are two periods, one is called bidding period when users need to submit their hash to hide their bidding amounts, the other is called reveal period when users need to reveal their real bidding amounts (the preimage of submitted hash) after the bidding period.

The requirements of contract are:

1. The contract deployer specifies the *biddimg time*, *reveal time*, and *beneficiary*.
2. The insterested bidders should hide their real bidding amount by submitting a *hash* and depositing an arbitrary amount of value. Specifically, the hash is computed over a triplet of [fake (boolean), amount (int), secret(bytes32)]), each bidder needs to call this function multiple times to submit different hashes (computed from different triplets) to hide their real bids. 
3. The contract only accept bids during the bidding time, and after that the reveal time ticker starts. 
4. During the reveal time, each bidder need to reveal each of their previous submitted hash by sending the raw triplets to the contract. The contract then check if the hash of each raw triplet is equal to the submitted hash. If not, the contract do not allow the bidder to withdraw the corresponding deposits.
5. After the reveal time, the **second highest bidder** will be the winner and his deposit will be transfered to the beneficiary.
6. The other bidders losing the auction *withdraw* their deposits.
