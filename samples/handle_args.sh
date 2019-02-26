#!/bin/sh


handle_input()
{
    # if value is expected the add ':' after the letter
    while getopts "d:hf" opt; do
        case $opt in
        d)
            d_opt=$OPTARG
            ;;
        h)
            echo "Does not expect any value"
            ;;
        f)
            echo "Does also not expect any value"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        esac
    done
}

main()
{
    handle_input $@

    if [ -z ${d_opt+x} ]; then
        echo "d was not set"
    else
        echo "d value was $d_opt"
    fi

    exit 0
}

main "$@"
