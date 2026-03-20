import "dotenv/config"; 
// 구형 require 대신 최신 import 문법을 사용합니다!

import "@nomicfoundation/hardhat-toolbox";



/** @type import('hardhat/config').HardhatUserConfig */
// 구형 module.exports 대신 최신 export default 문법을 사용합니다!
export default {
  solidity: "0.8.24", // 우리가 작성한 0.8.x 버전에 맞춥니다
  networks: {
    // 세폴리아 테스트넷 설정
    sepolia: {
      url: process.env.ALCHEMY_RPC_URL, // 알케미 우체국 주소
      accounts: [process.env.PRIVATE_KEY] // 내 지갑 인감도장
    }
  }
};