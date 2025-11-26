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
3. Truy cập:
Master UI: http://localhost:8080
History Server: http://localhost:18080
