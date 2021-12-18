# tiny-postman

a tiny tool for testing rest APIs built in ruby :)

## Installing

First, you need to install the required **Gems** in order to get the script to work.

In order to do so, simply run the following command:

``
bundle install
``

then, run the script:

``
ruby tiny-postman.rb
``

## Usage

At the very first step, the script asks for your **JWT token** in order to add append it to your other requests. your token will be saved in **token.txt**.

For sure you can create the **token.txt** and paste your token in it to save time :)

in order to remove the token of the previous session, just run script with **-remove-token**

``
ruby tiny-postman.rb -remove-token
``

when script asks you for url of api server, just provide it the domian address of your API(s), e.g: 

if you got **https://myawesomeapi.com/api/v1/kaveh-awesome** , then :

A) the url of your api server will be: **https://myawesomeapi.com**

B) and, the enpoint will be **/api/v1/kaveh-awesome**

please note you will be able to call different endpoints as much as you want 