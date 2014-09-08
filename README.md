gemify
======

Creates a gem from a js url and uploads it to github

Usage
======

  * [Obtain a private token from github]( https://help.github.com/articles/creating-an-access-token-for-command-line-use )
  * Replace the USERNAME and PRIVATE_TOKEN with your github username and private token 
  * `./build.sh [name-of-the-gem] [js-url]`

Example
======
`./build.sh gemify-jq http://example.com/jq.js`
