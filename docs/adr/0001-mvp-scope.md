# ADR 0001: Phạm vi MVP MeshShield AI

- Status: Accepted
- Date: 2026-09-29
- Accepted by: project owner

## Context

MeshShield AI cần đánh giá việc chọn đường truyền cho workload giữa A và C trong testbed multi-cloud. Tài liệu phải phân biệt thiết kế dự kiến với chức năng đã triển khai và kết quả đã đo.

## Decision

1. Testbed dự kiến gồm ba Linux gateway A, B, C trên ít nhất hai cloud provider.
2. Workload A–C có hai lựa chọn: direct A–C và relay A–B–C. B là trusted relay.
3. Mỗi liên kết A–C, A–B, B–C dùng một interface WireGuard riêng tại mỗi đầu.
4. WireGuard bảo vệ từng liên kết. B xử lý gói IP khi chuyển tiếp, nên không tuyên bố relay được mã hóa đầu cuối A–C.
5. Go agent tại node sẽ đo chất lượng đường truyền, chuyển tuyến cục bộ theo policy và rollback nếu kiểm tra thất bại. Controller sẽ phân phối policy.
6. Xây heuristic trước. Sau đó mới đánh giá phương pháp học như LinUCB bằng benchmark so với static direct, static relay và heuristic.
7. Chỉ cho phép các prefix cần thiết trong WireGuard AllowedIPs. Không thay default route của VM bằng 0.0.0.0/0 tùy tiện.
8. Ngày 1 chỉ có cấu trúc repo, hai Go entrypoint dạng scaffold và tài liệu. Cloud VM, WireGuard, agent/controller chức năng, benchmark và AI chưa được triển khai.

## Consequences

- Cần thiết kế tuyến đi và tuyến về cho cả direct lẫn relay; B phải chuyển tiếp hai chiều.
- A và C có cùng đích /32 qua các interface khác nhau. Phải chốt cách quản lý route trước khi bật đồng thời.
- Agent cần lưu tuyến cũ, kiểm tra tuyến mới và khôi phục khi chuyển tuyến thất bại.
- Không công bố số liệu latency, throughput hoặc failover trước khi thực sự đo.
