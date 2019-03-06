# Art Perpetual Contract

Welcome to a new form of art auctions. Inspired by thoughts in the book Radical Markets (link to book/website) this perpetual contract aims to provide a proving ground for the auctions theory described in Radical Markets. 

Goals:
* Allow Artists to sell their own digital artwork without neededing a clearinghouse, set thier own price, and benefit from each additional sale.
* Let potential buyers bid on the price of the artwork perpetually
* Discourage squatting on artwork by owners
* Realize longer term Perpetual Auction ideals

## ELI5

The perpetual art contract begins when artists create an piece of artwork and submit it to an ipfs node. They then upload the ipfs hash to the smart contract which begins an auction for ownership of that artwork. A 24 hour period begins where anyone can bid on the artwork, with the smart contract saving the bidder and their bid. When a user bids higher than the current bid, the funds are returned to the previous highest bidder and the new bidder becomes the highest bidder. Once the 24 hour period is over the Smart contract awards the artist, dev Fund, and charity with the awarded funds from the highest bidder. The bidder then receives a NFT of the artwork they are able to display anywhere for a period of one month. After the month is over the auction begins again. This time, the minimum bid is the current bid and the current owner only needs to match the difference of the current bid and previous bid.

## Technical Details

The smart contract will be realized in Solidity and pushed to the Public Ethereum Network. When the artist creates a contract an NFT token is minted and assigned to the artist. Upon completion of a bidding session the NFT token is transfered and awarded to the winner. The NFT token will be unable to be transfered until the next bidding session in which the cycle starts over again. The dev owner of this project will maintain the ipfs nodes.

## Edge Cases
* If a owner wants to sell the artwork he can chose to during the next sale cycle.
* If no one bids on the piece for more than a year, the price begins to decline by a certain % each cycle.


## Pay Breakdown
* Artist:    40%
* Owner:     30%
* Charity:   20%
* Dev:       10%



## Example
Artist 1 creates artwork and uploads it to an ipfs node.
Buyer 1 buys the artwork and is the new owner.
Sale cycle 1 comes up.
Buyer 2 bids the current price of the artwork.
Possible options:
Buyer 1 now has to match the current price of the bid, which means he has to pay 2x for the piece?
Buyer 1 now has to match the difference between the current price and bid price.
Buyer 1 should have some incentive to keep the price????

