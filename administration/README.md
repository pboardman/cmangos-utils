# Administration scripts

## Requirements

- mysql command line client

You can install it with `apt-get install mysql-client` if you have a debian based distro

## config file
just update the config file to match your DB ip, username and password to use the scripts

(You may want to set strict permissions on this file)

## create_account.sh

just run ./create_account without argument and the script will ask you for a username, password and GM level. It will then create an account.
