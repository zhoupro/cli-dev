#!/bin/bash
function c_post(){ 
	#-------------------------------------------------------------------------------
	# compile ycm_core
	#-------------------------------------------------------------------------------
	#系统名称
	com_codename=$(awk -F "=" ' $1 == "DISTRIB_ID" {print $2}' /etc/lsb-release|tr '[:upper:]' '[:lower:]')
	if [ ! -f ~/.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so ] ; then
	  mkdir ycm_build
	  cd ycm_build || exit
	  if [ "$com_codename"x = "deepin"x ] ; then
		  wget http://releases.llvm.org/5.0.0/clang+llvm-5.0.0-x86_64-linux-gnu-debian8.tar.xz
		  tar xJvf clang+llvm-5.0.0-x86_64-linux-gnu-debian8.tar.xz
		  cmake -G "Unix Makefiles"  -DPATH_TO_LLVM_ROOT=./clang+llvm-5.0.0-x86_64-linux-gnu-debian8    . ~/.vim/bundle/YouCompleteMe/third_par  ty/ycmd/cpp
	  elif [ "$com_codename"x = "ubuntu"x ] ; then
		  wget http://releases.llvm.org/5.0.0/clang+llvm-5.0.0-linux-x86_64-ubuntu16.04.tar.xz
		  tar xJvf clang+llvm-5.0.0-linux-x86_64-ubuntu16.04.tar.xz
		  cmake -G "Unix Makefiles"  -DPATH_TO_LLVM_ROOT=./clang+llvm-5.0.0-linux-x86_64-ubuntu16.04    . ~/.vim/bundle/YouCompleteMe/third_par  ty/ycmd/cpp
	  fi

	  cmake --build . --target ycm_core --config Release
	  cd ..
	  rm -rf ycm_build
	fi
	#-------------------------------------------------------------------------------
	# get the ycm conf
	#-------------------------------------------------------------------------------

	if [ ! -f ~/.vim/ycmconf/ycm.c.py ] ; then

	  wget https://raw.githubusercontent.com/zhouzheng12/newycm_extra_conf.py/master/ycm.c.py
	  mkdir -p ~/.vim/ycmconf
	  cp ycm.c.py ~/.vim/ycmconf/ycm.c.py
	  rm -f ycm.c.py
	fi
	if [ ! -f ~/.vim/c_cnt.sh ] ; then
	  cp ./c_cnt.sh  ~/.vim/c_cnt.sh
	fi
}

function c_pre(){
    apt-get install -y --no-install-recommends autoconf automake cmake    
}

function c_vimrc(){
 echo "hhh"
}
