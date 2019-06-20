# cli develop env
### os
* ubuntu
* centos
* mac
### language
- php
- c/c++
- go
- bash
- viml
- java
- python
- lua
### setup
#### ubuntu
 ```bash
 ./init.sh --with_php --with_vim_c --with_vim_ycm --with_vim_go --with_java \
--with_lua  --with_leetcode --with_man --with_dict --with_bash
 ```
#### mac and centos
./init.sh

### usage
* leader  ,
* <Leader>cf  clang format
* <Leader>w   search copy word


### language server

#### java

* Install Eclipse JDT Language Server

```bash
mkdir -p ~/lsp/eclipse.jdt.ls
cd ~/lsp/eclipse.jdt.ls
curl -L https://download.eclipse.org/jdtls/milestones/0.35.0/jdt-language-server-0.35.0-201903142358.tar.gz -O
tar xf jdt-language-server-0.35.0-201903142358.tar.gz
```
* Create executable jdtls in path (e.g., /usr/local/bin/jdtls), with content

```bash
#!/usr/bin/env sh

server="/root/lsp"

java \
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -noverify \
    -Xms1G \
    -jar $server/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.*.jar \
    -configuration $server/eclipse.jdt.ls/config_linux/ \
    "$@"
```
* Add to your vim config:

```viml
let g:LanguageClient_serverCommands = {
    \ 'java': ['/usr/local/bin/jdtls', '-data', getcwd()],
    \ }
```
#### php
* install intelephense
```bash
npm -g install intelephense
```
* add to your vim script
```viml
let g:LanguageClient_serverCommands = {
\ 'php': ['node', '/usr/local/lib/node_modules/intelephense/lib/intelephense.js', '--stdio'],
    \ }
```
### python
* install python language server
```bash
pip install python-language-server
```

* add to your vimscript
```viml
let g:LanguageClient_serverCommands = {
\ 'python': ['pyls'],
    \ }
```
### lua
* install lua language server
```bash
apt install  lua5.3-dev luarocks
luarocks install --server=http://luarocks.org/dev lua-lsp
```
* add to vim config
```viml
let g:LanguageClient_serverCommands = {
\ 'lua': ['lua-lsp'],
    \ }
```
### fe
* install css js typescript language server
```bash
npm install -g typescript typescript-language-server
npm install -g vscode-css-languageserver-bin
```

* add to vim config
```viml
let g:LanguageClient_serverCommands = {
\ 'css': ['css-languageserver',  '--stdio'],
\ 'less': ['css-languageserver',  '--stdio'],
\ 'sass': ['css-languageserver',  '--stdio'],
\ 'javascript': ['typescript-language-server',  '--stdio'],
\ 'javascript.jsx': ['typescript-language-server',  '--stdio'],
\ 'typescript': ['typescript-language-server',  '--stdio'],
\ 'typescript.tsx': ['typescript-language-server',  '--stdio'],
\ }
```
### bash
* install bash language server
```bash
sudo npm i -g bash-language-server --unsafe-perm

```
* add to vim config
let g:LanguageClient_serverCommands = {
\ 'sh': ['bash-language-server','start'],
    \ }

