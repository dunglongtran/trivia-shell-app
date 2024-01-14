#!/bin/bash

# Hiển thị menu chính
show_menu() {
    echo "Chào mừng đến với Ứng dụng Kiểm tra Trực tuyến"
    echo "1. Đăng nhập"
    echo "2. Đăng ký"
    echo "3. Thoát"
    echo -n "Vui lòng chọn một tùy chọn: "
}

# Xử lý lựa chọn
handle_choice() {
    case $1 in
        1) bash signin.sh;;
        2) bash signup.sh;;
        3) exit 0;;
        *) echo "Lựa chọn không hợp lệ";;
    esac
}

# Vòng lặp chính
while true; do
    show_menu
    read -r choice
if [[ $choice =~ ^[0-9]+$ ]]; then

        choice=$(echo $choice | sed 's/[^0-9]*//g') 
        break
else 
 echo "Loi: Nhap so nguyen duong"
fi
done
 handle_choice $choice