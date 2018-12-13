#!/bin/bash
rm ~/.hyper.js
! brew cask list | grep hyper  && brew cask install hyper
cp ./hyper.js ~/.hyper.js
