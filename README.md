# Have I Been Pwned CLI

Check if your password has been pwned.

Your password will be piped through sha1sum and checked using the [range search](https://haveibeenpwned.com/API/v2#SearchingPwnedPasswordsByRange). This means your password will not be sent to the server.

## How to install

Install [doghum](https://github.com/DokterW/doghum)

`doghum install hibp-cli`

### Roadmap

* Add more features from the Have I Been Pwned [API](https://haveibeenpwned.com/API/v2).

### Changelog

#### 2018-03-01
* Fixed the TUI a bit to make it more clear and to make it ready for more features.

#### 2018-02-29
* Search your password by SHA1 range.
