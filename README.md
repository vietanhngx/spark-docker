# Spark Docker Cluster (v3.5.7)

Môi trường phát triển Apache Spark sử dụng Docker Compose.

## Cấu hình
- **Spark:** 3.5.7
- **Java:** OpenJDK 17
- **Base Image:** Python 3.10

## Cách chạy
1. Cài đặt Docker Desktop.
2. Chạy lệnh:
   ```bash
   docker-compose up -d --build
3. Truy cập Web UI
   
   Sau khi khởi động thành công, bạn có thể truy cập:

   - Spark Master UI: http://localhost:8080 (Quản lý Cluster & Worker)

   - Spark History Server: http://localhost:18080 (Xem lại lịch sử các Job đã chạy)
### Hướng dẫn chạy Spark Job
1. Để chạy một file Python (PySpark) bất kỳ, hãy sử dụng cú pháp lệnh sau tại terminal (folder gốc của dự án):
   ```bash
   docker exec spark-master bin/spark-submit \
     --master spark://spark-master:7077 \
     /opt/spark/data/<ten_file_cua_ban>.py
2. Giải thích chi tiết câu lệnh

| Thành phần lệnh | Giải thích ý nghĩa |
| :--- | :--- |
| **`docker exec spark-master`** | Ra lệnh cho Docker: *"Hãy truy cập vào container có tên là `spark-master` để thực hiện lệnh này"*. |
| **`bin/spark-submit`** | Gọi công cụ **Spark Submit**. Đây là script chuẩn của Spark dùng để gửi ứng dụng (job) lên cluster. |
| **`--master spark://...:7077`** | Khai báo địa chỉ của **Master Node**. Tham số này giúp job biết ai là người quản lý tài nguyên để xin cấp phát (CPU/RAM). |
| **`/opt/spark/data/...`** | Đường dẫn tới file code **bên trong môi trường Docker**. |

> ** Lưu ý:** Do chúng ta đã cấu hình `volumes` trong file docker-compose, nên mọi file nằm trong thư mục `./data` ở máy thật sẽ tự động xuất hiện tại `/opt/spark/data` bên trong Docker.
