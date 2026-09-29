# MeshShield AI — Kiến trúc MVP

> Trạng thái hiện tại: planned. Hai Go entrypoint mới là scaffold; các chức năng mạng chưa được triển khai.

## Mục tiêu

Đánh giá hai đường truyền cho workload A↔C:

- Direct: A–C.
- Relay: A–B–C qua trusted relay B.

Testbed dự kiến có ba Linux gateway trên ít nhất hai cloud provider. Heuristic được xây trước; phương pháp học chỉ được đánh giá sau khi có baseline và dữ liệu benchmark.

## Thành phần dự kiến

| Plane | Thành phần | Nhiệm vụ |
|---|---|---|
| Data plane | WireGuard và định tuyến Linux tại A, B, C | Chuyển gói qua direct hoặc relay |
| Control plane | Controller và Go agent | Phân phối policy, áp dụng tuyến cục bộ, rollback |
| Measurement plane | Prober trong Go agent | Đo đường truyền cho heuristic và benchmark |

Vị trí controller, giao thức phân phối policy, địa chỉ probe và chi tiết triển khai chưa chốt.

## Service IP dự kiến

| Node | Service IP | Vai trò |
|---|---|---|
| A | 10.200.0.2/32 | Client/edge |
| B | 10.200.0.3/32 | Trusted relay |
| C | 10.200.0.4/32 | Server/core |

Các địa chỉ này mới là đề xuất, chưa được gán lên VM.

## Luồng gói

- Direct: A gửi tới C/32 qua `wg-ac`; C gửi về A/32 qua `wg-ca`.
- Relay: A gửi tới C/32 qua `wg-ab`; B nhận trên `wg-ba`, chuyển tiếp qua `wg-bc`; C nhận trên `wg-cb`. Chiều về đi C → B → A.

WireGuard mã hóa theo từng liên kết A–B và B–C. B thuộc trust boundary vì phải xử lý gói IP giữa hai liên kết.

## Định tuyến và rollback

A phải chọn một tuyến hoạt động tới C/32; C phải có tuyến về A/32 phù hợp. Khi dùng relay, B cần tuyến chuyển tiếp tới cả A/32 và C/32. Việc chỉ đổi tuyến tại A có thể khiến hai chiều không nhất quán.

`AllowedIPs` trên các interface direct và relay có thể chứa cùng đích /32. Cách quản lý route hoặc policy routing phải được chốt trước khi cấu hình WireGuard. Không thay default route của VM trong MVP.

Agent dự kiến lưu tuyến đang hoạt động, áp dụng tuyến mới, kiểm tra lưu lượng đi và về, rồi rollback và ghi lỗi nếu kiểm tra thất bại. Hiện chưa có logic rollback.

## Tài liệu liên quan

- [ADR phạm vi MVP](adr/0001-mvp-scope.md)
- [Kế hoạch testbed](testbed.md)
