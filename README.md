# install-monerod

# To build the image, run this command.
docker build --tag custom-monero-node:latest .


# To run this container, run this command.
docker run --detach --name monero-node --restart=always --publish 18080:18080 --publish 18089:18089 --volume monero-data:/var/lib/monero custom-monero-node
