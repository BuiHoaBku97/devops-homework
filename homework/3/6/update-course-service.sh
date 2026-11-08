#!/bin/bash

# Đường dẫn tới file log
LOG_FILE="/opt/rikkei/deploy.log"

# Hàm ghi log kèm thời gian
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# --- BẮT ĐẦU QUÁ TRÌNH TRIỂN KHAI ---
log_message "[START] Bắt đầu tiến trình cập nhật rikkei-course-service..."

# 1. Kiểm tra sự tồn tại của container bằng Filter chính xác
CONTAINER_NAME="rikkei-course-service"
CONTAINER_EXISTS=$(docker ps -a --filter "name=^/${CONTAINER_NAME}$" -q)

if [ -n "$CONTAINER_EXISTS" ]; then
    log_message "Phát hiện container '$CONTAINER_NAME' đang tồn tại. Tiến hành dừng và xóa..."
    
    # Dừng container
    docker stop "$CONTAINER_NAME" >> "$LOG_FILE" 2>&1
    log_message "Đã dừng container '$CONTAINER_NAME'."
    
    # Xóa container
    docker rm "$CONTAINER_NAME" >> "$LOG_FILE" 2>&1
    log_message "Đã xóa container '$CONTAINER_NAME'."
else
    log_message "Container '$CONTAINER_NAME' chưa tồn tại. Bỏ qua bước xóa."
fi

# 2. Khởi chạy lại container mới từ image nginxdemos/hello ở cổng 8081
log_message "Đang khởi chạy container mới từ image 'nginxdemos/hello' trên cổng 8081..."

docker run -d \
  --name "$CONTAINER_NAME" \
  -p 8081:80 \
  nginxdemos/hello >> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
    log_message "[SUCCESS] Khởi chạy container '$CONTAINER_NAME' mới thành công ở cổng 8081."
else
    log_message "[ERROR] Thất bại khi khởi chạy container '$CONTAINER_NAME'."
fi

log_message "[END] Kết thúc tiến trình."
echo "--------------------------------------------------" >> "$LOG_FILE"
