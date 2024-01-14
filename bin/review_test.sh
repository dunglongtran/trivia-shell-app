#!/bin/bash

csv_file="../data/dunglongtran_2024_01_14_22_15.csv"
while true; do
echo
echo "Chọn một trong các tuỳ chọn sau: "
echo "1. Trở lại"
echo "2. Xem kết quả"
echo "3. Thoát"
read -r choice

if [[ $choice =~ ^[0-9]+$ ]]; then

        choice=$(echo $choice | sed 's/[^0-9]*//g')
        break
else
 echo "Loi: Nhap so nguyen duong"
fi

done
echo "Bạn chọn $choice : $csv_file"
case $choice in
        1) bash app.sh;;
        2) bash view_test.sh  $csv_file;;
        3) exit 0;;
        *) echo "Lựa chọn không hợp lệ. Thoát." && exit 1;;
esac