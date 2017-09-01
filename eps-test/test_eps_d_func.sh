#!/bin/bash
#eps daemon must be running 
#start eps daemon in debug modus
#in the root cmakelist comment release mode and uncomment debug
#mode run cmake and make again

#prompt colors
red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 4)
normal=$(tput sgr0)

#remove --user when no in debug mode
cmd="busctl --user call moveii.eps /moveii/eps moveii.eps"
version="$cmd getVersion"
conf="$cmd getConfiguration"
beacon_data="$cmd getBeaconData"
temp="$cmd getTemperatures"
subsys="$cmd getSubSysState"
charge_state="$cmd getChargeState"
energy="$cmd isEnergyAvailable"
ttc="$cmd setTTCWatchdogLimit"
switch_on="$cmd switchOn"
switch_off="$cmd switchOff"
reset_pdm="$cmd resetAllPDMs"
reset_ttc="$cmd resetTTCNode"
reset_pcm="$cmd resetPCM"

version_test() {
    version=( $(eval $version) )
    printf "${blue}Version:${normal} %s\n" "${version[1]}"
}

conf_test() {
    conf=( $(eval $conf) )
    printf "\n${blue}Running Conf:${normal}\n\t%s\n" "${conf[3]}"
    printf "\tTLM Freq: ${conf[6]}\n"
    printf "\tStore freq: ${conf[9]}\n"
    printf "\tLog Level: ${cond[12]}\n"
}

beacon_test() {
    beacon_data="$(eval $beacon_data)"
    printf "\n${blue}Raw Beacon Data:${normal} %s\n" "$beacon_data"
}

temperature_test() {
    #TODO: tmp div 100 and substract 273
    temp=( $(eval $temp) )
    printf "\n${blue}Temperatures:${normal}\n" 
    c_temp=$(calc ${temp[2]} / 100 - 273)
    printf "\t%s\n" "EPS-Board:        $c_temp" #"${temp[2]}"
    #echo "$((${temp[2]} / 100 - 273))"
    c_temp=$(calc ${temp[3]} / 100 - 273)
    printf "\t%s\n" "BAT-Motherboard: $c_temp"
    #echo "$((${temp[3]} / 100 - 273))"
    c_temp=$(calc ${temp[4]} / 100 - 273)
    printf "\t%s\n" "BAT-Daugtherboard 1: $c_temp"
    #echo "$((${temp[4]} / 100 - 273))"
    c_temp=$(calc ${temp[5]} / 100 - 273)
    printf "\t%s\n" "BAT-Daugtherboard 2: $c_temp"
    #echo "$((${temp[5]} / 100 - 273))"
}

subsys_test() {
    subsys=( $(eval $subsys) )
    printf "\n${blue}Subsystem State${normal}\n"
    if [ "${subsys[1]}" == "true" ]; then
        printf "\t${green}All Subsystems OK${normal}\n"
    else
        #fail
        printf "\t${red}Out of system limits range${normal}\n"
    fi
}

charge_test() {
    #u get percentage between 0 and 1
    charge_state=( $(eval $charge_state) )
    printf "\n%s\n" "${blue}Battery State:${normal} ${charge_state[1]}"
}

energy_test() {
    #max 20Wh
    #python 3.6.0
    current_energy=$(python -c "print (${charge_state[1]} * 20)")
    printf "\n%s\n" "${blue}Current Energy:${normal} $current_energy Wh"
    energy="$energy d $current_energy"
    #printf "%s\n" "$energy"

    energy=( $(eval $energy) )
    #energy=$(eval $energy)
    #printf "%s\n" "$energy"
    printf "\n${blue}Available Energy${normal}\n"
    if [ "${energy[1]}" == "true" ]; then
        printf "\t${green}Enough energy.${normal}\n"
    else
        #fail
        printf "\t${red}Not enough energy.${normal}\n"
    fi
}

ttc_test() {
    rand=$(shuf -i 0-90 -n 1)
    ttc="$ttc q $rand"
    ttc=( $(eval $ttc) )
    printf "\n${blue}Setting telemetry node timer:${normal}"
    if [ "${ttc[1]}" == "true" ]; then
        printf "\t${green}I2C call issued.${normal}\n"
    else
        #fail
        printf "\t${red}I2C call not issued.${normal}\n"
    fi
}

switch_test() {
    mod[0]="SBAND"
    mod[1]="2SMARD1"
    mod[2]="2SMARD2"
    mod[3]="PLTHM"
    mod[4]="ADCS5V"
    mod[5]="ADCS3V3"

    for i in {1..10}
    do
        rand=$(shuf -i 0-5 -n 1)
        #just to decide wehter to turn a pdm on or off
        on_off=$(shuf -i 0-10000 -n 1)
        on_off=$(($on_off % 2)) 
        if [ $on_off -eq 0 ]; then
            switch_on_s="$switch_on s \"${mod[$rand]}\""
            switch_on_s=( $(eval $switch_on_s) )
            printf "\n${blue}Switching ${mod[$rand]} on:\n${normal}"
            if [ "${switch_on_s[1]}" == "true" ]; then
                printf "\t${green}${mod[$rand]} switched on\n${normal}"
            else
                printf "\t${red}Couldn't switch ${mod[$rand]} on\n${normal}"
            fi
        else
            switch_off_s="$switch_off s \"${mod[$rand]}\""
            switch_off_s=( $(eval $switch_off_s) )
            printf "\n${blue}Switching ${mod[$rand]} off:\n${normal}"
            if [ "${switch_off_s[1]}" == "true" ]; then
                printf "\t${green}${mod[$rand]} switched off\n${normal}"
            else
                printf "\t${red}Couldn't switch ${mod[$rand]} off\n${normal}"
            fi
        fi
    done
}

reset_pdms_test() {
    printf "\n${blue}Reseting PDMs:${normal}\n"
    reset_pdm=( $(eval $reset_pdm) )
    if [ "${reset_pdm[1]}" == "true" ]; then
        printf "\t${green}Succesfully reseted PDMs\n${normal}"
    else
        printf "\t${red}Couldn't reset PDMs\n${normal}"
    fi
}

reset_ttc_test() {
    printf "\n${blue}Reseting Telemetry and Telecommand node:${normal}\n"
    reset_ttc=( $(eval $reset_ttc) )
    if [ "${reset_ttc[1]}" == "true" ]; then
        printf "\t${green}Succesfully reseted TTC Nodes.\n${normal}"
    else
        printf "\t${red}Couldn't reset TTC Nodes.\n${normal}"
    fi
}

reset_pcm_test() {
    pcm[0]="UHFVHF"
    pcm[1]="CDH"
    reset_pcm_u="$reset_pcm s \"${pcm[0]}\""
    reset_pcm_u=( $(eval $reset_pcm_u) )
    printf "\n${blue}Reseting UHFVHF${normal}\n"
    if [ "${reset_pcm_u[1]}" == "true" ]; then
        printf "\t${green}Successfully reseted UHFVHF PCM${normal}\n"
    else
        printf "\t${red}Couldn't reset UHFVHF PCM${normal}\n"
    fi
    reset_pcm_u="$reset_pcm s \"${pcm[1]}\""
    reset_pcm_u=( $(eval $reset_pcm_u) )
    printf "\n${blue}Reseting CDH${normal}\n"
    if [ "${reset_pcm_u[1]}" == "true" ]; then
        printf "\t${green}Successfully reseted CDH PCM${normal}\n"
    else
        printf "\t${red}Couldn't reset CDH PCM${normal}\n"
    fi
}

main() {
    version_test
    #getConfiguration not implemented yet ?
    conf_test
    beacon_test
    temperature_test
    subsys_test
    charge_test
    energy_test
    ttc_test
    switch_test
    reset_pdms_test
    reset_ttc_test
    reset_pcm_test
}
main "$@"
