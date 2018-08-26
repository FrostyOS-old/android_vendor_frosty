for device in $(curl -s https://raw.githubusercontent.com/FrostyOS/android_vendor_frosty/9.0/frosty.devices | sed -e 's/#.*$//')
do
    for var in eng user userdebug; do
        add_lunch_combo frosty_$device-$var
    done
done
