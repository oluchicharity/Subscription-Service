// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract SubscriptionService {
    address public owner;
    uint256 public subscriptionFee;
    mapping(address => uint256) public subscriberExpiry;

    constructor(uint256 _subscriptionFee) {
        owner = msg.sender;
        subscriptionFee = _subscriptionFee;
    }

    function subscribe() public payable {
        require(msg.value == subscriptionFee, "Incorrect subscription fee");

        if (subscriberExpiry[msg.sender] > block.timestamp) {
            subscriberExpiry[msg.sender] += 30 days;
        } else {
            subscriberExpiry[msg.sender] = block.timestamp + 30 days;
        }
    }

    function isSubscriberActive(address subscriber) public view returns (bool) {
        return subscriberExpiry[subscriber] > block.timestamp;
    }

    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }

    function updateSubscriptionFee(uint256 newFee) public {
        require(msg.sender == owner, "Only owner can update the fee");
        subscriptionFee = newFee;
    }
}
