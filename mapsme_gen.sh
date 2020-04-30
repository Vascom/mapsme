#!/bin/bash

# Usage info
show_help(){
cat << EOF
Usage: ${0##*/} [-hut] -c CONF_NUM COUNTRY REGION...
    -h          display this help and exit
    -c CONF_NUM select config number.
    -u          upload geneated maps to the server.
    -t          enable working time calculation.
EOF
}

conf_num=0
upload=0
time_enable=0

while getopts "hutc:" opt; do
    case "$opt" in
    h)  show_help
        exit 0
        ;;
    c)  conf_num=$OPTARG
        echo "Used config $conf_num"
        ;;
    u)  upload=1
        echo "Upload enabled"
        ;;
    t)  time_enable=1
        echo "Time compute enabled"
        ;;
    esac
done

shift $((OPTIND-1))

upload_server_path="vpnmercury:/var/www/webdav/mapsme"

if [ $time_enable == "1" ]; then
    time_log_file="/tmp/mapsme_time.log"

    # Compute working time start
    DT_START=$(date +%s)
fi

#Reset color
Color_Off='\e[0m'       # Text Reset
#Colors
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow

build_dir_name="/mnt/ramdisk/maps_build_$conf_num"
conf_file="$build_dir_name/map_generator.ini"

pl_url_s="https://download.geofabrik.de/"
main_region="russia"
sub_region="$1-latest.osm.pbf"
with_regions=0

# Select country
case "$1" in
    "russia"        )   main_region="russia"
                        with_regions=1 ;;
    "belarus"       )   main_region="europe" ;;
    "ukraine"       )   main_region="europe" ;;
    "georgia"       )   main_region="europe" ;;
    "estonia"       )   main_region="europe" ;;
    "latvia"        )   main_region="europe" ;;
    "lithuania"     )   main_region="europe" ;;
    "finland"       )   main_region="europe" ;;
    "poland"        )   main_region="europe" ;;
    "czech-republic")   main_region="europe" ;;
    "armenia"       )   main_region="asia" ;;
    "azerbaijan"    )   main_region="asia" ;;
    "kazakhstan"    )   main_region="asia" ;;
    "mongolia"      )   main_region="asia" ;;
    "north-korea"   )   main_region="asia" ;;
    "uzbekistan"    )   main_region="asia" ;;
    "turkmenistan"  )   main_region="asia" ;;
    "kyrgyzstan"    )   main_region="asia" ;;
    "tajikistan"    )   main_region="asia" ;;
    "tunisia"       )   main_region="africa" ;;
    *               )   echo "Need country"
                        exit 1 ;;
esac
shift

# select region
if [ $with_regions -eq 1 ]; then
    case "$1" in
        "Russia_Moscow"                     ) sub_region="central-fed-district-latest.osm.pbf" ;;
        "Russia_Bashkortostan"              ) sub_region="volga-fed-district-latest.osm.pbf" ;;
        "Russia_Krasnodar Krai"             ) sub_region="south-fed-district-latest.osm.pbf" ;;
        "Crimea"                            ) sub_region="crimean-fed-district-latest.osm.pbf" ;;
        "Russia_Arkhangelsk Oblast_Central" ) sub_region="northwestern-fed-district-latest.osm.pbf" ;;
        "Russia_Kaliningrad Oblast"         ) sub_region="kaliningrad-latest.osm.pbf" ;;
        "Russia_Republic of Dagestan"       ) sub_region="north-caucasus-fed-district-latest.osm.pbf" ;;
        "Russia_Kurgan Oblast"              ) sub_region="ural-fed-district-latest.osm.pbf" ;;
        "Russia_Altai Krai"                 ) sub_region="siberian-fed-district-latest.osm.pbf" ;;
        "Russia_Amur Oblast"                ) sub_region="far-eastern-fed-district-latest.osm.pbf" ;;
#         "Poland_Greater Poland Voivodeship" ) sub_region="https://download.geofabrik.de/europe/poland-latest.osm.pbf" ;;
#         "Poland_Kuyavian-Pomeranian Voivodeship")sub_region="kujawsko-pomorskie-latest.osm.pbf" ;;
#         "Poland_Lesser Poland Voivodeship"  ) sub_region="malopolskie-latest.osm.pbf" ;;
#         "Poland_Lodz Voivodeship"           ) sub_region="lodzkie-latest.osm.pbf" ;;
#         "Poland_Lower Silesian Voivodeship" ) sub_region="dolnoslaskie-latest.osm.pbf" ;;
#         "Poland_Lublin Voivodeship"         ) sub_region="lubelskie-latest.osm.pbf" ;;
#         "Poland_Lubusz Voivodeship"         ) sub_region="lubuskie-latest.osm.pbf" ;;
#         "Poland_Masovian Voivodeship"       ) sub_region="mazowieckie-latest.osm.pbf" ;;
#         "Poland_Opole Voivodeship"          ) sub_region="opolskie-latest.osm.pbf" ;;
#         "Poland_Podlaskie Voivodeship"      ) sub_region="podlaskie-latest.osm.pbf" ;;
#         "Poland_Pomeranian Voivodeship"     ) sub_region="pomorskie-latest.osm.pbf" ;;
#         "Poland_Silesian Voivodeship"       ) sub_region="slaskie-latest.osm.pbf" ;;
#         "Poland_Subcarpathian Voivodeship"  ) sub_region="podkarpackie-latest.osm.pbf" ;;
#         "Poland_Swietokrzyskie Voivodeshi"  ) sub_region="swietokrzyskie-latest.osm.pbf" ;;
#         "Poland_Warmian-Masurian Voivodeship") sub_region="warminsko-mazurskie-latest.osm.pbf" ;;
#         "Poland_West Pomeranian Voivodeship") sub_region="zachodniopomorskie-latest.osm.pbf" ;;
        *                                   ) echo "Need region"
                                              exit 2 ;;
    esac
fi

declare -a COUNT
max_count=$#

for i in $(seq 1 $max_count);do
    COUNT[$i]=$1
    shift
done

COUNTRIES=${COUNT[1]}
for i in $(seq 2 $max_count);do
    COUNTRIES=$(echo $COUNTRIES,${COUNT[$i]})
done

# Create build directory on ramdisk
if [ ! -e $build_dir_name ]; then
    mkdir $build_dir_name
else
    rm -rf $build_dir_name/*
fi

# Change config to build requested maps
pushd ~/mapsme/omim/tools/python
    cp maps_generator/var/etc/map_generator.ini $conf_file
    sed -e "s|.*PLANET_URL.*|PLANET_URL: ${pl_url_s}${main_region}/${sub_region}|" \
        -e "s|.*PLANET_MD5_URL.*|PLANET_MD5_URL: ${pl_url_s}${main_region}/${sub_region}.md5|" \
        -e "s|/mnt/ramdisk/maps_build.*|$build_dir_name|" \
        -e "s|OSM_TOOLS_PATH: ~/osmctools|OSM_TOOLS_PATH: $build_dir_name/osmctools|" \
        -i $conf_file

# Run maps build
    python3 -m maps_generator --config $conf_file --countries="$COUNTRIES" --skip="Coastline"
#     python3 -m maps_generator --config $conf_file --countries="$COUNTRIES" --skip="coastline,routing_transit"
popd

# Upload maps to server
if [ $upload -eq 1 ]; then
    if [ $? -eq 0 ]; then
        for i in $(seq 1 $max_count);do
            echo "$i $max_count"
            find $build_dir_name -name "${COUNT[$i]}.mwm" -exec scp {} $upload_server_path \;
        done
        rm -rf $build_dir_name
    else
        for i in $(seq 1 $max_count);do
            find $build_dir_name -name "${COUNT[$i]}.mwm" -delete
        done
        echo -e "${Red}Build failed!${Color_Off}"
        exit 3
    fi
fi

if [ $time_enable == "1" ]; then
    # Compute working time end
    DT_END=$(date +%s)
    work_m=$(echo "($DT_END - $DT_START)/60" | bc -l)
    echo ${main_region}-${sub_region} $work_m >> $time_log_file
fi
