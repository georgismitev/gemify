#!/bin/bash

die () {
  echo >&2 "$@"
  exit 1
}

function javascripts_path () {
  echo ${1%%/}/vendor/assets/javascripts
}

[ "$#" -eq 2 ] || die "2 arguments required, $# provided"

# set the gem name
GEMNAME=$1
JSURL=$2
PWD=`pwd`

# remove the gem directory if exists
rm -rf $GEMNAME

# create gem
bundle gem $GEMNAME

cd $GEMNAME

# set javascripts path
JAVASCRIPTS_PATH=$(javascripts_path $PWD $GEMNAME)

# create the vendor/assets directory
mkdir -p $JAVASCRIPTS_PATH

# download the javascript
wget $JSURL -O $JAVASCRIPTS_PATH/$GEMNAME.js

MODULE_NAME=`echo ${GEMNAME:0:1} | tr '[a-z]' '[A-Z]'`${GEMNAME:1}

echo "module $MODULE_NAME
  module Rails
    class Engine < ::Rails::Engine
    end
  end
end" > lib/$GEMNAME.rb

cp ../templates/README.md .
cp ../templates/MIT-LICENSE .

echo '# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "'$GEMNAME'/version"

Gem::Specification.new do |spec|
  spec.name          = "'$GEMNAME'"
  spec.version       = '$MODULE_NAME'::VERSION
  spec.authors       = ["Greg"]
  spec.email         = ["georgi@fonii.com"]
  spec.summary       = %q{Write a short summary. Required.}
  spec.description   = %q{Write a longer description. Optional.}
  spec.homepage      = "https://github.com/rebelact/$GEMNAME"
  spec.license       = "MIT"

  spec.files         = Dir["{lib,vendor}/**/*"] + ["MIT-LICENSE", "README.md"]

  spec.add_dependency "railties", "~> 4.0"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end' > $GEMNAME.gemspec

# build the gem
rake build
  
# temp private token
USERNAME=rebelact
PRIVATE_TOKEN='private-token-goes-here'

# create the repo and push the code
curl -u "$USERNAME:$PRIVATE_TOKEN" https://api.github.com/user/repos -d '{"name":"'$GEMNAME'"}'
git add -A .
git commit -m "initial commit"
git remote add origin git@github.com:$USERNAME/$GEMNAME.git
git push -u origin master

# cleanup
cd .. && rm -rf $GEMNAME
