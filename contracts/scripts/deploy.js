const main = async () => {

  const contractNames = [
      "LandRegister",  
  ];

  for(let i = 0; i<contractNames.length; i++){
      try {
          const contractFactory = await hre.ethers.getContractFactory(contractNames[i]);
          const _contract = await contractFactory.deploy();
          await _contract.deployed();
          console.log(`${contractNames[i]} contract deployed to: ${_contract.address}`);
      } catch (error) {
          console.log(error);
          process.exit(1);
      }
  }
};
  
main();
