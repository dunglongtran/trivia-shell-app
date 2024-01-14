#!/bin/bash


# Hiển thị menu chính
show_menu() {
    echo "Bạn có thể thực hiện các chưc năng sau:"
    echo "1. Làm bài kiểm tra"
    echo "2. Xem lại kết quả"
    echo "3. Thoát"
    echo -n "Vui lòng chọn một tùy chọn: "
}

# Xử lý lựa chọn
handle_choice() {
    case $1 in
        1) bash start_test.sh;;
        2) bash list_test.sh;;
        3) exit 0;;
        *) echo "Lựa chọn không hợp lệ";;
    esac
}

echo
echo "Chào mừng $USER_NAME!"
echo
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