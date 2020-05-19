# Initialize configuration files and genesis file
tnd init validator --chain-id tn-testnet-1

# Configure your CLI to eliminate need for chain-id flag
tncli config chain-id tn-testnet-1
tncli config output json
tncli config indent true
tncli config trust-node true

# Change default bond token genesis.json
sed -i 's/stake/utnbc/g' ~/.tnd/config/genesis.json

# Copy the `Address` output here and save it for later use
# [optional] add "--ledger" at the end to use a Ledger Nano S
tncli keys add faucet

# Copy the `Address` output here and save it for later use
tncli keys add validator

# Generate the transaction that creates your validator
tnd gentx --name validator --amount=150000000utnbc

# Add both accounts, with coins to the genesis file
tnd add-genesis-account $(tncli keys show faucet -a) 150000000000utnbc
tnd add-genesis-account $(tncli keys show validator1 -a) 150000000000utnbc

# Add the generated bonding transaction to the genesis file
tnd collect-gentxs
tnd validate-genesis

# Now its safe to start `tnd`
tnd start

