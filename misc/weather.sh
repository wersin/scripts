#!/bin/zsh

weather=""
temp=""
pos=0

strindex() {
  x="${1%%$2*}"
  [[ "$x" = "$1" ]] && echo -1 || echo "${#x}"
}

main()
{

    weather=$(curl -s wttr.in | tac | tac | head -n 7 | awk 'NR==3')
    temp=$(curl -s wttr.in | tac | tac | head -n 7 | awk 'NR==4')
    counter=$(strindex "$temp" "°")
    echo ${temp:$counter-36:$counter+1}
    if [[ $weather == *"Partly cloudy"* ]]; then
        echo "Partly cloudy"
    fi
    echo "$weather"
}

main "$@"


