import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { ethers } from "hardhat";

const SubscriptionServiceModule = buildModule("SubscriptionServiceModule", (m) => {
    const subscriptionFee = ethers.parseEther("0.01"); 

    const deploySubscriptionService = m.contract("SubscriptionService", [subscriptionFee]);

    return { deploySubscriptionService };
});

export default SubscriptionServiceModule;
