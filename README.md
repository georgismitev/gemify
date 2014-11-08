gemify
======

Creates a gem from a js url and uploads it to github

Before using it
======

  * Make sure you have `wget` installed.
  * Gemify works by downloading the javascript. If you have it locally just give us a shout - we are working on it - https://github.com/rebelact/gemify/issues/5

Usage
======

  * [Obtain a private token from github]( https://help.github.com/articles/creating-an-access-token-for-command-line-use )
  * Replace the USERNAME and PRIVATE_TOKEN with your github username and private token 
  * `./build.sh [name-of-the-gem] [js-url]`

Example
======
`./build.sh gemify-jq http://example.com/jq.js`
