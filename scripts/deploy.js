async function main() {
  const HelloWorld = await ethers.getContractFactory("L1L2");

  // Start deployment, returning a promise that resolves to a contract object
  const hello_world = await HelloWorld.deploy(
    "0xde29d060D45901Fb19ED6C6e959EB22d8626708e"
  );
  console.log("Contract deployed to address:", hello_world.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
