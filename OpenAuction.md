In this lab, you are expected to design an open auction smart contract using solidity programing language.
Your code should implement the following workflow.

1. A constructor function takes two inputs that specify the bidding time and the seller. Within the bidding time, it allows users to submit their bids.
2. A bid function accepts users' bid and compare the current highest with the users' bid.
3. After bidding time eplased, someone can (either the auction winner or the seller) calls auctionEnd() to transfer the highest bid amount to the seller.
4. The other bidders losing the auction call withdraw() to take back their deposits.
