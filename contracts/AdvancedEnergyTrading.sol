// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdvancedEnergyTrading {
    // Structure for energy offers
    struct Offer {
        uint id;
        address creator;
        uint energyAmount; // Energy amount in kWh
        uint price;        // Price per kWh in wei
        bool isBuyOffer;   // True for buy offers, False for sell offers
        bool active;       // Offer status: active/inactive
    }

    // Structure for reputation scores
    struct User {
        uint completedTrades;
        uint reputationScore; // Based on trade history
    }

    uint public offerCount = 0; // Counter for offer IDs
    mapping(uint => Offer) public offers; // Mapping of offers by ID
    mapping(address => User) public users; // Mapping of users to their reputation

    // Events for logging activities
    event OfferCreated(uint id, address indexed creator, uint energyAmount, uint price, bool isBuyOffer);
    event OfferMatched(uint id, address indexed counterparty, uint energyAmount, uint totalPrice, bool isBuyOffer);
    event ReputationUpdated(address indexed user, uint newReputationScore);

    // Modifier to ensure the offer is active
    modifier onlyActiveOffer(uint offerId) {
        require(offers[offerId].active, "Offer is not active");
        _;
    }

    // Function to create a new offer (buy or sell)
    function createOffer(uint energyAmount, uint price, bool isBuyOffer) public {
        require(energyAmount > 0, "Energy amount must be greater than zero");
        require(price > 0, "Price must be greater than zero");

        offers[offerCount] = Offer(offerCount, msg.sender, energyAmount, price, isBuyOffer, true);
        emit OfferCreated(offerCount, msg.sender, energyAmount, price, isBuyOffer);
        offerCount++;
    }

    // Function to match an offer (counterparty completes the trade)
    function matchOffer(uint offerId) public payable onlyActiveOffer(offerId) {
        Offer storage offer = offers[offerId];
        uint totalPrice = offer.energyAmount * offer.price;

        if (offer.isBuyOffer) {
            // Seller matches a buy offer
            require(msg.value == 0, "No payment required for matching buy offer");
            require(address(this).balance >= totalPrice, "Insufficient contract balance");

            payable(msg.sender).transfer(totalPrice);
        } else {
            // Buyer matches a sell offer
            require(msg.value >= totalPrice, "Insufficient payment");
            payable(offer.creator).transfer(totalPrice);
        }

        offer.active = false;
        updateReputation(msg.sender);
        updateReputation(offer.creator);

        emit OfferMatched(offerId, msg.sender, offer.energyAmount, totalPrice, offer.isBuyOffer);
    }

    // Function to update reputation scores
    function updateReputation(address user) internal {
        users[user].completedTrades++;
        users[user].reputationScore = calculateReputation(users[user].completedTrades);
        emit ReputationUpdated(user, users[user].reputationScore);
    }

    // Reputation calculation logic (example: score increases with number of trades)
    function calculateReputation(uint completedTrades) public pure returns (uint) {
        if (completedTrades <= 5) {
            return completedTrades * 10; // Example logic
        } else {
            return 50 + (completedTrades - 5) * 5; // Example logic
        }
    }

    // Helper function to fetch active offers
    function getActiveOffers(bool isBuyOffer) public view returns (Offer[] memory) {
        uint activeCount = 0;
        for (uint i = 0; i < offerCount; i++) {
            if (offers[i].active && offers[i].isBuyOffer == isBuyOffer) {
                activeCount++;
            }
        }

        Offer[] memory activeOffers = new Offer[](activeCount);
        uint index = 0;
        for (uint i = 0; i < offerCount; i++) {
            if (offers[i].active && offers[i].isBuyOffer == isBuyOffer) {
                activeOffers[index] = offers[i];
                index++;
            }
        }
        return activeOffers;
    }
}
