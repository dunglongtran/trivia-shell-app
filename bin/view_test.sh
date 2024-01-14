#!/bin/bash

# Xác định file kết quả của người dùng
#user_result_file="../data/${USERNAME}_$(date "+%Y_%m_%d_%H_%M").csv"
user_result_file="../data/dunglongtran_2024_01_14_02_09.csv"
questions_file="../data/questions.csv"

# Kiểm tra sự tồn tại của file
if [ ! -f "$user_result_file" ] || [ ! -f "$questions_file" ]; then
    echo "File kết quả không tồn tại."
    exit 1
fi
index=0
# Xử lý và hiển thị từng câu hỏi
while IFS=',' read -r user_question user_answer answer_time; do
    if [ "$index" -eq 0 ]; then
        index=$((index+1))
        continue
    fi
    # Tìm câu trả lời và thời gian trả lời của người dùng cho câu hỏi này
    while IFS=',' read -r question correct_answer _ option_a option_b option_c; do
        if [ "$question" == "$user_question" ]; then
            break
        fi
    done < "$questions_file"

    echo "Câu hỏi $index: $question"
    for option in a b c; do
        option_var="option_$option"
        echo -n "["
        if [[ "${!option_var}" == "$correct_answer" &&  "${!option_var}" == "$user_answer" ]]; then
            echo -n "o"
        elif [ "${!option_var}" == "$correct_answer" ]; then
            echo -n "o"
        elif [ "${!option_var}" == "$user_answer" ]; then
            echo -n "x"
        else
            echo -n " "
        fi
        echo "] $option. ${!option_var}"
#        if [ "${!option_var}" == "$user_answer" ]; then
#            echo " -> Trả lời trong $answer_time giây"
#        fi
    done

#    if [[ $user_answer == "Không hợp lệ" || $user_answer == "Hết thời gian" ]]; then
#        echo "Câu trả lời của bạn: $user_answer -> Trả lời trong $answer_time giây"
#    fi
    if [ -z "$answer_time" ]; then
        answer_time=0
    fi
     if [[ $user_answer == "Không hợp lệ" ]]; then
            echo "Câu trả lời của bạn là $user_answer."
    elif [[ $user_answer == "Hết thời gian" ]]; then
            echo "Bạn đã trả lời vượt quá thời gian là $answer_time giây"
    else
            echo "Bạn đã trả lời trong $answer_time giây"
    fi
    echo
    index=$((index+1))
 done < "$user_result_file"

echo "Kết thúc xem bài kiểm tra."
