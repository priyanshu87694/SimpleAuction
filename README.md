# Simple Auction

## Introduction
This contract implements a auction with a specific time to end provided through the constructor. Until the ending auction event emits the participants can bid and at last highest bid will be transfered to the benificiary and rest all other bids will be returned.

## Getting Started
Clone this repo
Install the dev dependencies, need not to install all
```
yarn add --dev @nomiclabs/hardhat-ethers@npm:hardhat-deploy-ethers ethers @nomiclabs/hardhat-waffle chai ethereum-waffle hardhat hardhat-deploy dotenv
````

## Deploying the contracts
Run
```
hh deploy
```
or
```
yarn hardhat deploy
```
