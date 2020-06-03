#!/bin/bash

# Usage info
show_help(){
cat << EOF
Usage: ${0##*/} [-hut] -s SET_NUMBER
    -h              display this help and exit
    -s SET_NUMBER   select server dependent maps set.
    -u              upload geneated maps to the server.
    -t              enable working time calculation.
EOF
}

GEN_ARGS=""
time_enable=0

while getopts "huts:" opt; do
    case "$opt" in
    h)  show_help
        exit 0
        ;;
    s)  server_n=$OPTARG
        echo "Used server $server_n"
        ;;
    u)  GEN_ARGS=$(echo "$GEN_ARGS -u")
        echo "Upload enabled"
        ;;
    t)  time_enable=1
        GEN_ARGS=$(echo "$GEN_ARGS -t")
        echo "Time compute enabled"
        ;;
    esac
done

shift $((OPTIND-1))

time_upload_server_path="vpnmercury:/home/vascom"

if [ $time_enable == "1" ]; then
    time_log_file="/tmp/mapsme_time.log"

    # Clean time log file
    if [ -e $time_log_file ]; then
        rm $time_log_file
    fi
fi

if [ $server_n == 0 ]; then



echo a
elif [ $server_n == 1 ]; then
    mapsme_gen.sh $GEN_ARGS -c 0 "russia" \
    "Russia_Moscow" \
    "Russia_Moscow Oblast_West" \
    "Russia_Moscow Oblast_East" \
    "Russia_Belgorod Oblast" \
    "Russia_Bryansk Oblast" \
    "Russia_Vladimir Oblast" \
    "Russia_Voronezh Oblast" \
    "Russia_Ivanovo Oblast" \
    "Russia_Kaluga Oblast" \
    "Russia_Kostroma Oblast" \
    "Russia_Kursk Oblast" \
    "Russia_Lipetsk Oblast" \
    "Russia_Oryol Oblast" \
    "Russia_Ryazan Oblast" \
    "Russia_Smolensk Oblast" \
    "Russia_Tambov Oblast" \
    "Russia_Tver Oblast" \
    "Russia_Tula Oblast" \
    "Russia_Yaroslavl Oblast" &
    sleep 10

    mapsme_gen.sh $GEN_ARGS -c 1 "russia" \
    "Russia_Bashkortostan" \
    "Russia_Kirov Oblast" \
    "Russia_Mari El" \
    "Russia_Republic of Mordovia" \
    "Russia_Nizhny Novgorod Oblast" \
    "Russia_Orenburg Oblast" \
    "Russia_Penza Oblast" \
    "Russia_Perm Krai_North" \
    "Russia_Perm Krai_South" \
    "Russia_Samara Oblast" \
    "Russia_Saratov Oblast" \
    "Russia_Tatarstan" \
    "Russia_Udmurt Republic" \
    "Russia_Ulyanovsk Oblast" \
    "Russia_Chuvashia"

    wait

    mapsme_gen.sh $GEN_ARGS -c 0 "russia" \
    "Russia_Krasnodar Krai" \
    "Russia_Krasnodar Krai_Adygeya" \
    "Russia_Astrakhan Oblast" \
    "Russia_Volgograd Oblast" \
    "Russia_Rostov Oblast" \
    "Russia_Republic of Kalmykia" &
    sleep 10

    mapsme_gen.sh $GEN_ARGS -c 1 "russia" \
    "Russia_Kurgan Oblast" \
    "Russia_Sverdlovsk Oblast_Ekaterinburg" \
    "Russia_Sverdlovsk Oblast_North" \
    "Russia_Tyumen Oblast" \
    "Russia_Yugra_Khanty" \
    "Russia_Yugra_Surgut" \
    "Russia_Chelyabinsk Oblast" \
    "Russia_Yamalo-Nenets Autonomous Okrug" &
    sleep 10

    mapsme_gen.sh $GEN_ARGS -c 2 "belarus" \
    "Belarus_Brest Region" \
    "Belarus_Homiel Region" \
    "Belarus_Hrodna Region" \
    "Belarus_Maglieu Region" \
    "Belarus_Minsk Region" \
    "Belarus_Vitebsk Region"

    wait

    mapsme_gen.sh $GEN_ARGS -c 0 "ukraine" \
    "Ukraine_Cherkasy Oblast" \
    "Ukraine_Chernihiv Oblast" \
    "Ukraine_Chernivtsi Oblast" \
    "Ukraine_Dnipropetrovsk Oblast" \
    "Ukraine_Donetsk Oblast" \
    "Ukraine_Ivano-Frankivsk Oblast" \
    "Ukraine_Kharkiv Oblast" \
    "Ukraine_Kherson Oblast" \
    "Ukraine_Khmelnytskyi Oblast" \
    "Ukraine_Kirovohrad Oblast" \
    "Ukraine_Kyiv Oblast" \
    "Ukraine_Luhansk Oblast" \
    "Ukraine_Lviv Oblast" \
    "Ukraine_Mykolaiv Oblast" \
    "Ukraine_Odessa Oblast" \
    "Ukraine_Poltava Oblast" \
    "Ukraine_Rivne Oblast" \
    "Ukraine_Sumy Oblast" \
    "Ukraine_Ternopil Oblast" \
    "Ukraine_Vinnytsia Oblast" \
    "Ukraine_Volyn Oblast" \
    "Ukraine_Zakarpattia Oblast" \
    "Ukraine_Zaporizhia Oblast" \
    "Ukraine_Zhytomyr Oblast" \
    "Crimea"

    mapsme_gen.sh $GEN_ARGS -c 0 "poland" \
    "Poland_Greater Poland Voivodeship" \
    "Poland_Kuyavian-Pomeranian Voivodeship" \
    "Poland_Lesser Poland Voivodeship" \
    "Poland_Lodz Voivodeship" \
    "Poland_Lower Silesian Voivodeship" \
    "Poland_Lublin Voivodeship" \
    "Poland_Lubusz Voivodeship" \
    "Poland_Masovian Voivodeship" \
    "Poland_Opole Voivodeship" \
    "Poland_Podlaskie Voivodeship" \
    "Poland_Pomeranian Voivodeship" \
    "Poland_Silesian Voivodeship" \
    "Poland_Subcarpathian Voivodeship" \
    "Poland_Swietokrzyskie Voivodeship" \
    "Poland_Warmian-Masurian Voivodeship" \
    "Poland_West Pomeranian Voivodeship"

    wait

elif [ $server_n == 2 ]; then
    mapsme_gen.sh $GEN_ARGS -c 0 "russia" \
    "Russia_Arkhangelsk Oblast_Central" \
    "Russia_Arkhangelsk Oblast_North" \
    "Russia_Vologda Oblast" \
    "Russia_Republic of Karelia_South" \
    "Russia_Republic of Karelia_North" \
    "Russia_Komi Republic" \
    "Russia_Leningradskaya Oblast_Karelsky" \
    "Russia_Leningradskaya Oblast_Southeast" \
    "Russia_Murmansk Oblast" \
    "Russia_Nenets Autonomous Okrug" \
    "Russia_Novgorod Oblast" \
    "Russia_Pskov Oblast" \
    "Russia_Saint Petersburg" &
    sleep 10

    mapsme_gen.sh $GEN_ARGS -c 1 "russia" \
    "Russia_Altai Krai" \
    "Russia_Altai Republic" \
    "Russia_Buryatia" \
    "Russia_Zabaykalsky Krai" \
    "Russia_Irkutsk Oblast" \
    "Russia_Kemerov Oblast" \
    "Russia_Krasnoyarsk Krai_North" \
    "Russia_Krasnoyarsk Krai_South" \
    "Russia_Novosibirsk Oblast" \
    "Russia_Omsk Oblast" \
    "Russia_Tomsk Oblast" \
    "Russia_Tuva" \
    "Russia_Khakassia"

    wait

    mapsme_gen.sh $GEN_ARGS -c 0 "russia" \
    "Russia_Amur Oblast" \
    "Russia_Jewish Autonomous Oblast" \
    "Russia_Kamchatka Krai" \
    "Russia_Magadan Oblast" \
    "Russia_Primorsky Krai" \
    "Russia_Sakha Republic" \
    "Russia_Sakhalin Oblast" \
    "Russia_Khabarovsk Krai" \
    "Russia_Chukotka Autonomous Okrug" &
    sleep 10

    mapsme_gen.sh $GEN_ARGS -c 1 "russia" \
    "Russia_Republic of Dagestan" \
    "Russia_Ingushetia" \
    "Russia_Kabardino-Balkaria" \
    "Russia_Karachay-Cherkessia" \
    "Russia_North Ossetia-Alania" \
    "Russia_Stavropol Krai" \
    "Russia_Chechen Republic"

    wait

    mapsme_gen.sh $GEN_ARGS -c 0 "russia" "Russia_Kaliningrad Oblast" &
    sleep 10
    mapsme_gen.sh $GEN_ARGS -c 1 "estonia" "Estonia_East" "Estonia_West" &
    sleep 10
    mapsme_gen.sh $GEN_ARGS -c 2 "latvia" "Latvia" &
    sleep 10
    mapsme_gen.sh $GEN_ARGS -c 3 "georgia" "Georgia" "Abkhazia" "South Ossetia" &
    sleep 10
    mapsme_gen.sh $GEN_ARGS -c 4 "armenia" "Armenia" &
    sleep 10
    mapsme_gen.sh $GEN_ARGS -c 5 "azerbaijan" "Azerbaijan" "Nagorno-Karabakh" &
    sleep 10
    mapsme_gen.sh $GEN_ARGS -c 6 "mongolia" "Mongolia" &
    sleep 10
    mapsme_gen.sh $GEN_ARGS -c 7 "north-korea" "North Korea" &
    sleep 10
    mapsme_gen.sh $GEN_ARGS -c 8 "turkmenistan" "Turkmenistan" &
    sleep 10
    mapsme_gen.sh $GEN_ARGS -c 9 "kyrgyzstan" "Kyrgyzstan" &
    sleep 10
    mapsme_gen.sh $GEN_ARGS -c 10 "tajikistan" "Tajikistan" &
    sleep 10
    mapsme_gen.sh $GEN_ARGS -c 11 "uzbekistan" "Uzbekistan" &

    wait

    mapsme_gen.sh $GEN_ARGS -c 0 "lithuania" "Lithuania_East" "Lithuania_West" &
    sleep 10
    mapsme_gen.sh $GEN_ARGS -c 1 "kazakhstan" "Kazakhstan_North" "Kazakhstan_South" &

    wait

    mapsme_gen.sh $GEN_ARGS -c 0 "finland" \
    "Finland_Eastern Finland_North" \
    "Finland_Eastern Finland_South" \
    "Finland_Northern Finland" \
    "Finland_Southern Finland_Helsinki" \
    "Finland_Southern Finland_Lappeenranta" \
    "Finland_Southern Finland_West" \
    "Finland_Western Finland_Jyvaskyla" \
    "Finland_Western Finland_Tampere"

elif [ $server_n == 3 ]; then
    mapsme_gen.sh $GEN_ARGS -c 0 "czech-republic" \
    "Czech_Jihovychod_Jihomoravsky kraj" \
    "Czech_Jihovychod_Kraj Vysocina" \
    "Czech_Jihozapad_Jihocesky kraj" \
    "Czech_Jihozapad_Plzensky kraj" \
    "Czech_Karlovasky kraj" \
    "Czech_Moravskoslezsko" \
    "Czech_Olomoucky kraj" \
    "Czech_Praha" \
    "Czech_Severovychod_Kralovehradecky kraj" \
    "Czech_Severovychod_Liberecky kraj" \
    "Czech_Severovychod_Pardubicky kraj" \
    "Czech_Stredni Cechy_East" \
    "Czech_Stredni Cechy_West" \
    "Czech_Ustecky kraj" \
    "Czech_Zlinsky Kraj"

   mapsme_gen.sh $GEN_ARGS -c 0 "serbia" "Serbia" &
   sleep 10
   mapsme_gen.sh $GEN_ARGS -c 1 "slovakia" \
   "Slovakia_Region of Banska Bystrica" \
   "Slovakia_Region of Bratislava" \
   "Slovakia_Region of Kosice" \
   "Slovakia_Region of Nitra" \
   "Slovakia_Region of Presov" \
   "Slovakia_Region of Trencin" \
   "Slovakia_Region of Trnava" \
   "Slovakia_Region of Zilina" &
   sleep 10
   mapsme_gen.sh $GEN_ARGS -c 2 "slovenia" "Slovenia_East" "Slovenia_West" &

   wait

   mapsme_gen.sh $GEN_ARGS -c 0 "hungary" \
   "Hungary_Kozep-Magyarorszag" \
   "Hungary_Northern Great Plain" \
   "Hungary_Transdanubia" &
   sleep 10
   mapsme_gen.sh $GEN_ARGS -c 1 "romania" \
   "Romania_Centre" \
   "Romania_North_East" \
   "Romania_North_West" \
   "Romania_South" \
   "Romania_South_East" \
   "Romania_South_West" \
   "Romania_West" &
   sleep 10
   mapsme_gen.sh $GEN_ARGS -c 2 "bosnia-herzegovina" \
   "Bosnia and Herzegovina_Brcko district of Bosnia and Herzegowina" \
   "Bosnia and Herzegovina_Entity Federation of Bosnia and Herzegovina" \
   "Bosnia and Herzegovina_Republic of Srpska" &

   wait
elif [ $server_n == "2d" ]; then
    mapsme_gen.sh $GEN_ARGS -c 0 -p "russia" \
    "Russia_Moscow" \
    "Russia_Moscow Oblast_West"

else
    echo "Need to select server"
    exit 1
fi

if [ $time_enable == "1" ]; then
    scp $time_log_file $time_upload_server_path/mapsme_time_$server_n.log
fi

if [ -e $HOME/osmctools ]; then
    rm -rf $HOME/osmctools
fi
