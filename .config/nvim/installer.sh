#!/bin/bash

npm -g i pyright bash-language-server --force
npm -g i yaml-language-server --force
npm -g i @ansible/ansible-language-server --force
GO111MODULE=on go install mvdan.cc/sh/v3/cmd/shfmt@latest
pip install black
pip3 install black
