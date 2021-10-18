pragma solidity >=0.4.22 <0.7.0;

/*
1. The contract deployer sets the bidding time and seller address.
2. Bidders call bid() to make their bids and send deposits.
3. After bidding time eplased, someone (winner or seller) calls auctionEnd() to transfer the highest bid to the seller.
4. The other bidders losing the auction call withdraw() to take back their deposits. 
*/

contract OpenAuction {
  
    address payable public seller;
    uint public auctionEndTime;

    // Current state of the auction.
    address public highestBidder;
    uint public highestBid;

    // Allow withdraw previous bids
    mapping(address => uint) pendingReturns;

    // Set to true at the end, prevent any change.
    bool ended;

    // Events that will be emitted on changes.
    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    constructor(uint _biddingTime, address payable _seller) public {
        seller = _seller;
        auctionEndTime = now + _biddingTime;
    }

    /// Bid on the auction with the value sent together with this transaction.
    /// The value will only be refunded if a higher bid comes.
    function bid() public payable {
        // Check if bidding period is over.
        require(now <= auctionEndTime,"Auction already ended.");

        // If the bid is not higher, send the money back.
        require(msg.value > highestBid,"There already is a higher bid.");

        if (highestBid != 0) {
            // Put the previous bidder into allowed pendingReturns.
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncreased(msg.sender, msg.value);
    }

    /// Withdraw a bid that was overbid.
    function withdraw() public returns (bool) {
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            // It is important to set this to zero to defend re-entrancy attacks.
            pendingReturns[msg.sender] = 0;

            if (!msg.sender.send(amount)) {
                // No need to call throw here, just reset the amount owing
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    /// End the auction and send the highest bid to the beneficiary.
    function auctionEnd() public {
        // 1. Conditions
        require(now >= auctionEndTime, "Auction not yet ended.");
        require(!ended, "auctionEnd has already been called.");

        // 2. Effects
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);

        // 3. Interaction
        seller.transfer(highestBid);
    }
}
