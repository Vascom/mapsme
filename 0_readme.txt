Создаём свежие карты для mapsme

Все действия осуществляются от обычного пользователя.

Вначале надо скачать и собрать необходимый инструментарий.
Для этого должны быть установлены git, gcc-c++ >= 7.0, cmake3 >= 3.2, python3, pip (pip3),
qt5-qtbase-devel, sqlite-devel.
Также требуется ~5ГБ свободного места на жёстком диске. И хотя бы 4ГБ ОЗУ.

Итак, приступим.
Пункты 1.x выполняются один раз на новой системе либо при желании обновить
инструментарий.
1.1 Создаём каталог, где всё будет, чтобы не забивать домашнюю директорию
    mkdir mapsme
    cd mapsme

1.2 Клонируем репозиторий. Он займёт ~4ГБ места.
    git clone --recurse-submodules -j8 https://github.com/mapsme/omim.git
В старых версиях git нет параметров -j и --shallow-submodules, так что их можно убрать, если не клонируется.

1.3 Версия сборочного инструментария должна строго совпадать с версией программы, под которую
собираем карты. Например, если программа версии 9.5.2, то надо перейти в ветку release-95
    cd omim
    git checkout release-95

1.4 Собираем необходимые бинарники. В зависимост от мощности CPU процесс может затянуться.
    echo | ./configure.sh
    tools/unix/build_omim.sh -sr generator_tool

1.5 Доустанавливаем необходимые модули python и копируем шаблон настроек сборки карт
    cd tools/python/maps_generator
    pip3 install --user -r requirements.txt
    cp var/etc/map_generator.ini.default var/etc/map_generator.ini

1.6 Обновим пути, чтобы всё лежало в одном каталоге mapsme
    sed -i 's|~/omim-build-release|~/mapsme/omim-build-release|' var/etc/map_generator.ini
    sed -i 's|OMIM_PATH: ~/omim|OMIM_PATH: ~/mapsme/omim|' var/etc/map_generator.ini
    sed -i 's|DEBUG: 1|DEBUG: 0|' var/etc/map_generator.ini
    sed -i 's|~/osmtools|~/mapsme/osmtools|' var/etc/map_generator.ini
Каталог в котором будет происходить сборка карт и лежать итоговые файлы 
    sed -i 's|~/maps_build|~/mapsme/maps_build|' var/etc/map_generator.ini
Если хотите ускорить сборку или не желаете убивать ваш SSD, рекомендую создать ramdisk и указать его для maps_build.
Например /mnt/ramdisk/maps_build вместо ~/mapsme/maps_build
Потребуется дополнительно 4-12ГБ в ОЗУ.

На этом первоначальная настройка завершена.


На втором этапе собираем сами карты.
Не забывайте, что при обновлении основной программы MapsMe надо перейти на соответствующю
ветку и пересобрать инструментарий (пп. 1.3-1.4).

2.0 Переходим в нужный каталог, если мы ещё не там
    cd ~/mapsme/omim/tools/python/maps_generator

2.1 Настраиваем шаблон на нужный регион.

Для простоты возьмём Центральный федеральный округ России, г. Москва.
Потребуется в файле var/etc/map_generator.ini заменить строки
# PLANET_URL:
# PLANET_MD5_URL:
на
PLANET_URL: https://download.geofabrik.de/russia/central-fed-district-latest.osm.pbf
PLANET_MD5_URL: https://download.geofabrik.de/russia/central-fed-district-latest.osm.pbf.md5

Это можно сделать в вашем любимом текстовом редакторе, но я приведу команды,
используемые в консоли или скрипте.
    sed -i 's|.*PLANET_URL.*|PLANET_URL: https://download.geofabrik.de/russia/central-fed-district-latest.osm.pbf|' var/etc/map_generator.ini
    sed -i 's|.*PLANET_MD5_URL.*|PLANET_MD5_URL: https://download.geofabrik.de/russia/central-fed-district-latest.osm.pbf.md5|' var/etc/map_generator.ini

2.2 Теперь генерируем файл карты.
Сборка одного региона на Intel Core i7-4770 3900МГц занимает около часа.
И загрузка pbf файла тоже займёт время и место, он ~550МБ.

Названия регионов можно посмотреть в ~/mapsme/omim/data/borders. Также их можно
перечислять через запятую в параметре --countries.
    cd ..
    python3 -m maps_generator --countries="Russia_Moscow" --skip="coastline"


Готовый файл можно найти в
~/mapsme/maps_build/<дата и время запуска генератора>
