module.exports = async ({ getNamedAccounts, deployments }) => {
    const { deploy, log } = deployments;
    const { deployer } = await getNamedAccounts();
  
    // Deploy the OnChainNFT contract
    const nftContract = await deploy('OnChainNFT', {
      from: deployer,
      log: true,
    });
  
    log('✅ Contract deployed to:', nftContract.address);
  
    // Sample SVG to mint
    const svg = `<svg xmlns='http://www.w3.org/2000/svg' width='1024' height='1024'>
        <defs><clipPath id='a'><path d='M0 0h1024v1024H0z'/></clipPath></defs>
        <g clip-path='url(#a)'>
          <path d='M0 0h1024v1024H0z'/>
          <path fill='#fff' d='M0 241h1024v20H0zM0 502h1024v20H0zM0 763h1024v20H0z'/>
          <path fill='#fff' d='M241 0h20v1024h-20z'/>
        </g>
      </svg>`;
  
    // Mint the SVG as an NFT
    const nftInstance = await ethers.getContract('OnChainNFT', deployer);
    const txn = await nftInstance.mint(svg);
    const txnReceipt = await txn.wait();
  
    // Extracting the tokenId from the event
    const event = txnReceipt.events?.find((event) => event.event === 'Minted');
    const tokenId = event?.args['tokenId'];
  
    log(
      '🎨 Your minted NFT:',
      `https://testnets.opensea.io/assets/${nftContract.address}/${tokenId}`
    );
  };
  
  module.exports.tags = ['OnChainNFT'];
  