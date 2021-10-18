In this lab, you are expected to implement the blinded auction smart contract with the solidity programing language. In a blinded auction, there are two periods, one is called bidding period when users need to submit their hash of their bidding amounts, the other one is called reveal period when users need to reveal their bidding amounts (the preimage of submitted hash) after the bidding period.

 
Your code should implement the following workflow.

1. The contract deployer sets the bidding time, reveal time, and seller address.
2. During the bidding time, each bidder calls bid() to submit their bid (should be a hash of bytes32) and send the deposits (amounts of Ether). Specifically, the hash is computed over a triplet of \[fake (boolean), amount (int), secret(bytes32)\]), each bidder needs to call this function multiple times to submit different hashes (computed from different triplets) to hide their real biding amount.
3. After the bidding time eplased, reveal time ticker starts. Each bidder calls reveal() to reveal each of their submitted bids in step 2.
4. After the reveal time elapsed, someone calls auctionEnd() to finish the auction and transfer the highest bid to the seller.
5. The other bidders call withdraw() to take back their deposits. 
