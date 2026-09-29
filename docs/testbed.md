# MeshShield AI — Kế hoạch testbed

> Trạng thái: planned. Provider, region, địa chỉ và port dưới đây là đề xuất; chưa xác nhận có VM thật.

## Node dự kiến

| Node | Provider/region đề xuất | OS/arch | Service IP | Vai trò |
|---|---|---|---|---|
| A | AWS, Singapore | Ubuntu 24.04 / amd64 | 10.200.0.2/32 | Client/edge |
| B | Google Cloud, Tokyo | Ubuntu 24.04 / amd64 | 10.200.0.3/32 | Trusted relay |
| C | AWS, Virginia | Ubuntu 24.04 / amd64 | 10.200.0.4/32 | Server/core |

Region không bảo đảm đường relay nhanh hơn direct. Nếu đổi provider hoặc region vì chi phí/quota, cập nhật bảng theo VM thực tế và giữ ít nhất hai provider.

## Interface và UDP port dự kiến

| Node | Interface | Peer | UDP listen port cục bộ | Endpoint peer |
|---|---|---|---:|---|
| A | wg-ac | C | 51820 | C_PUBLIC:51820 |
| A | wg-ab | B | 51821 | B_PUBLIC:51820 |
| B | wg-ba | A | 51820 | A_PUBLIC:51821 |
| B | wg-bc | C | 51821 | C_PUBLIC:51821 |
| C | wg-ca | A | 51820 | A_PUBLIC:51820 |
| C | wg-cb | B | 51821 | B_PUBLIC:51821 |

`A_PUBLIC`, `B_PUBLIC`, `C_PUBLIC` là placeholder. Chưa mở port hay tạo interface.

## AllowedIPs tối thiểu dự kiến cho workload A↔C

| Node/interface | Peer | Prefix workload |
|---|---|---|
| A / wg-ac | C | 10.200.0.4/32 |
| A / wg-ab | B | 10.200.0.4/32 |
| B / wg-ba | A | 10.200.0.2/32 |
| B / wg-bc | C | 10.200.0.4/32 |
| C / wg-ca | A | 10.200.0.2/32 |
| C / wg-cb | B | 10.200.0.2/32 |

Đây chưa phải file cấu hình chạy được. Địa chỉ từng link, prefix của B, địa chỉ probe và cách quản lý các route trùng đích vẫn cần thiết kế trước khi triển khai.

## Inventory và bằng chứng thực tế

Lưu public IP và thông tin quản trị thực tế trong `private/inventory.txt` trên máy phát triển; thư mục `private/` được Git bỏ qua. Không commit SSH private key hoặc mật khẩu.

| Node | VM đã tạo? | Provider/region thực tế | Public IP đã ghi vào local inventory? |
|---|---|---|---|
| A | TODO | TODO | TODO |
| B | TODO | TODO | TODO |
| C | TODO | TODO | TODO |

Chỉ thay TODO khi đã kiểm tra VM thật. Lưu kết quả đo sau này tại `docs/evidence/`.
