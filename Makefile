default:
	npx hardhat compile
	npx hardhat ignition deploy ./ignition/modules/Market.js --network sepolia
	rm -rf artifacts
	rm -rf cache

compile:
	npx hardhat compile

deploy:
	npx hardhat ignition deploy ./ignition/modules/Market.js --network sepolia

holesky:
	npx hardhat ignition deploy ./ignition/modules/Market.js --network holesky

test:
	npx hardhat test

clean:
	rm -rf artifacts
	rm -rf cache
	rm -rf ignition/deployments