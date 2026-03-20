import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("PHashRegistryModule", (m) => {
  
  const authenticator = m.contract("PHashRegistry");

  return { authenticator };
});