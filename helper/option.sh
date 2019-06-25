OPT_PHP=
OPT_C=
OPT_VIM_GO=
OPT_JAVA=
OPT_LUA=
OPT_PYTHON=
OPT_LEETCODE=
OPT_MAN=
OPT_DICT=
OPT_BASH=
OPT_FE=

for option
do
    case "$option" in
        --with_php)                          OPT_PHP=yes                   ;;
        --with_c)                          OPT_C=yes                   ;;
        --with_vim_go)                          OPT_VIM_GO=yes                   ;;
        --with_java)                          OPT_JAVA=yes                   ;;
        --with_lua)                          OPT_LUA=yes                   ;;
        --with_python)                          OPT_PYTHON=yes                   ;;
        --with_leetcode)                          OPT_LEETCODE=yes                   ;;
        --with_man)                          OPT_MAN=yes                   ;;
        --with_dict)                          OPT_DICT=yes                   ;;
        --with_bash)                          OPT_BASH=yes                   ;;
        --with_fe)                          OPT_FE=yes                   ;;
    esac
done
