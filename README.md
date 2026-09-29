# MeshShield AI

MeshShield AI là MVP nghiên cứu chọn đường truyền cho workload A↔C trong testbed multi-cloud. Dự án so sánh đường A–C trực tiếp với đường A–B–C qua trusted relay B.

## Phạm vi MVP

- Ba Linux gateway trên ít nhất hai cloud provider.
- Mỗi liên kết A–C, A–B và B–C dùng interface WireGuard riêng ở mỗi đầu.
- Go agent dự kiến đo đường truyền, chuyển tuyến cục bộ và rollback.
- Controller dự kiến phân phối policy.
- Xây heuristic trước; sau đó đánh giá phương pháp học như LinUCB so với static direct, static relay và heuristic.

## Trạng thái hiện tại

Ngày 1: scaffold Go và tài liệu thiết kế. Hai entrypoint agent/controller chỉ in thông báo kiểm tra build. Chưa triển khai cloud testbed, WireGuard, chuyển tuyến, rollback, controller chức năng, benchmark hoặc AI. Chưa có kết quả đo latency, throughput hay failover.

## Môi trường phát triển

- Ubuntu 24.04 LTS, amd64.
- Go 1.27.1 theo `go.mod`.
- Git và GNU Make.

## Kiểm tra scaffold

Tại thư mục gốc repo:

    go version
    make fmt
    make verify
    ./bin/meshshield-agent
    ./bin/meshshield-controller

`go test ./...` có thể báo `[no test files]`. Build thành công ở giai đoạn này chưa chứng minh chức năng mạng.

## Tài liệu

- [Quyết định phạm vi MVP](docs/adr/0001-mvp-scope.md)
- [Kiến trúc](docs/architecture.md)
- [Kế hoạch testbed](docs/testbed.md)
