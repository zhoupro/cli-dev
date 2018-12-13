#!/bin/bash
rm ~/.hyper.js
cp tools/hyper/hyper.js ~/.hyper.js
! brew cask list | grep hyper  && brew cask install hyper
