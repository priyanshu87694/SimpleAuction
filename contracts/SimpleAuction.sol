// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimpleAuction {
    address payable public benificiary;
    uint public auctionEndTime;
    address public highestBidder;
    uint public highestBid;
    mapping (address => uint) pendingReturns;
    bool ended;

    event AuctionEnded (address winner, uint amount);
    event HighestBidIncreased (address highestBidder, uint amount);

    error AuctionAlreadyEnded ();
    error BidNotHighEnough(uint highestBid);
    error AuctionNotYetEnded();
    error AuctionEndAlreadyCalled();

    constructor (uint biddingTime, address payable benificiaryAddress) {
        benificiary = benificiaryAddress;
        auctionEndTime = block.timestamp + biddingTime;
    }

    function bid () external payable {
        if (block.timestamp > auctionEndTime) {
            revert AuctionAlreadyEnded();
        }
        if (msg.value <= highestBid) {
            revert BidNotHighEnough(highestBid);
        }

        if (highestBid != 0) {
            pendingReturns[highestBidder] = highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncreased(msg.sender, msg.value);
    }

    function withdraw () external payable returns (bool) {
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            pendingReturns[msg.sender] = 0;
            if (!payable(msg.sender).send(amount)) {
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }
    
    function auctionEnd () external payable {
        // Checking condition for auction to end
        if (block.timestamp < auctionEndTime) {
            revert AuctionNotYetEnded();
        }
        if (ended) {
            revert AuctionEndAlreadyCalled();
        }

        // Make the changes that signifies that auction has ended
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);

        // Transfer the highestBid to the benificiary
        benificiary.transfer(highestBid);
    }
}