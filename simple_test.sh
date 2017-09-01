#!/bin/bash
#eps daemon must be running 
#start eps daemon in debug modus
#in the root cmakelist comment release mode and uncomment debug
#mode run cmake and make again

#remove --user when no in debug mode
cmd="busctl call moveii.eps /moveii/eps moveii.eps"
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
    printf "Version: %s\n" "${version[1]}"
}

conf_test() {
    conf=( $(eval $conf) )
    printf "\nRunning Conf:\n\t%s\n" "${conf[3]}"
    printf "\tTLM Freq: ${conf[6]}\n"
    printf "\tStore freq: ${conf[9]}\n"
    printf "\tLog Level: ${cond[12]}\n"
}

beacon_test() {
    beacon_data="$(eval $beacon_data)"
    printf "\nRaw Beacon Data: %s\n" "$beacon_data"
}

temperature_test() {
    temp=( $(eval $temp) )
    printf "\nTemperatures:\n" 
    #c_temp=$(calc ${temp[2]} / 100 - 273)
    printf "\t%s\n" "EPS-Board:        ${temp[2]}"
    #c_temp=$(calc ${temp[3]} / 100 - 273)
    printf "\t%s\n" "BAT-Motherboard: ${temp[3]}"
    #c_temp=$(calc ${temp[4]} / 100 - 273)
    printf "\t%s\n" "BAT-Daugtherboard 1: ${temp[4]}"
    #c_temp=$(calc ${temp[5]} / 100 - 273)
    printf "\t%s\n" "BAT-Daugtherboard 2: ${temp[5]}"
}

subsys_test() {
    subsys=( $(eval $subsys) )
    printf "\nSubsystem State\n"
    if [ "${subsys[1]}" == "true" ]; then
        printf "\tAll Subsystems OK\n"
    else
        printf "\tOut of system limits range\n"
    fi
}

battery_test() {
    #u get percentage between 0 and 1
    charge_state=( $(eval $charge_state) )
    printf "\n%s\n" "Battery State: ${charge_state[1]}"

    #max 20Wh
    #python 3.6.0
    #current_energy=$(python -c "print (${charge_state[1]} * 20)")
    printf "\n%s\n" "Current Energy: ${current_state[1]} Wh"
    #energy="$energy d $current_energy"
    energy="$energy d ${current_state[1]}"
    energy=( $(eval $energy) )
    printf "\nAvailable Energy\n"
    if [ "${energy[1]}" == "true" ]; then
        printf "\tEnough energy.\n"
    else
        #fail
        printf "\tNot enough energy.\n"
    fi
}

ttc_test() {
    rand=$(shuf -i 0-90 -n 1)
    ttc="$ttc q $rand"
    ttc=( $(eval $ttc) )
    printf "\nSetting telemetry node timer:"
    if [ "${ttc[1]}" == "true" ]; then
        printf "\tI2C call issued.\n"
    else
        #fail
        printf "\tI2C call not issued.\n"
    fi
}

switch_test() {
    mod[0]="SBAND"
    mod[1]="2SMARD1"
    mod[2]="2SMARD2"
    mod[3]="PLTHM"
    mod[4]="ADCS5V"
    mod[5]="ADCS3V3"

    #switch on
    for i in {0..5}
    do
        switch_on_s="$switch_on s \"${mod[$i]}\""
        switch_on_s=( $(eval $switch_on_s) )
        printf "\nSwitching ${mod[$i]} on:\n"
        if [ "${switch_on_s[1]}" == "true" ]; then
            printf "\t${mod[$i]} switched on\n"
        else
            printf "\tCan't switch ${mod[$i]} on\n"
        fi
    done

    for i in {0..5}
    do
        #rand=$(shuf -i 0-5 -n 1)
        #just to decide wehter to turn a pdm on or off
        #on_off=$(shuf -i 0-10000 -n 1)
        switch_off_s="$switch_off \"s\" \"${mod[$i]}\""
        #printf "%s\n" "$switch_off_s"
        switch_off_s=( $(eval $switch_off_s) )
        printf "\nSwitching ${mod[$i]} off:\n"
        if [ "${switch_off_s[1]}" == "true" ]; then
            printf "\t${mod[$i]} switched off\n"
        else
            printf "\tCouldn't switch ${mod[$i]} off\n"
        fi
    done
}

reset_pdms_test() {
    printf "\nReseting PDMs:\n"
    reset_pdm=( $(eval $reset_pdm) )
    if [ "${reset_pdm[1]}" == "true" ]; then
        printf "\tSuccesfully reseted PDMs\n"
    else
        printf "\tCouldn't reset PDMs\n"
    fi
}

reset_ttc_test() {
    printf "\nReseting Telemetry and Telecommand node:\n"
    reset_ttc=( $(eval $reset_ttc) )
    if [ "${reset_ttc[1]}" == "true" ]; then
        printf "\tSuccesfully reseted TTC Nodes.\n"
    else
        printf "\tCouldn't reset TTC Nodes.\n"
    fi
}

reset_pcm_test() {
    pcm[0]="UHFVHF"
    pcm[1]="CDH"
    reset_pcm_u="$reset_pcm s \"${pcm[0]}\""
    reset_pcm_u=( $(eval $reset_pcm_u) )
    printf "\nReseting UHFVHF\n"
    if [ "${reset_pcm_u[1]}" == "true" ]; then
        printf "\tSuccessfully reseted UHFVHF PCM\n"
    else
        printf "\tCouldn't reset UHFVHF PCM\n"
    fi
    reset_pcm_u="$reset_pcm s \"${pcm[1]}\""
    reset_pcm_u=( $(eval $reset_pcm_u) )
    printf "\nReseting CDH\n"
    if [ "${reset_pcm_u[1]}" == "true" ]; then
        printf "\tSuccessfully reseted CDH PCM\n"
    else
        printf "\tCouldn't reset CDH PCM\n"
    fi
}

main() {
    version_test
    #getConfiguration not implemented yet ?
    conf_test
    #beacon_test
    #temperature_test
    #subsys_test
    #battery_test
    #ttc_test
    switch_test
    #reset_pdms_test
    #reset_ttc_test
    #reset_pcm_test
}
main "$@"
