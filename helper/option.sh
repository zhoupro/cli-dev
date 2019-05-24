OPT_VIM_PHP=
OPT_VIM_C=
OPT_VIM_YCM=
OPT_VIM_LUA=
OPT_VIM_GO=
OPT_JAVA=
OPT_LUA=
OPT_PYTHON=
OPT_LEETCODE=
OPT_MAN=

for option
do
	case "$option" in
		--with_vim_php)                          OPT_VIM_PHP=yes                   ;;
		--with_vim_c)                          OPT_VIM_C=yes                   ;;
		--with_vim_ycm)                          OPT_VIM_YCM=yes                   ;;
		--with_vim_lua)                          OPT_VIM_LUA=yes                   ;;
		--with_vim_go)                          OPT_VIM_GO=yes                   ;;
		--with_java)                          OPT_JAVA=yes                   ;;
		--with_lua)                          OPT_LUA=yes                   ;;
		--with_python)                          OPT_PYTHON=yes                   ;;
		--with_leetcode)                          OPT_LEETCODE=yes                   ;;
		--with_man)                          OPT_MAN=yes                   ;;
    esac
done
