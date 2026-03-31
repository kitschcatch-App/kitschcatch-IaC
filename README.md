# kitschcatch-IaC

Kitschcatch 백엔드 인프라(IaC) 저장소입니다.

## 아키텍처 반영 범위

- 경로: `Route53 -> ACM -> ALB -> EC2(Nginx + Spring + Redis Docker Compose) -> Supabase(PostgreSQL), S3`
- DB는 AWS RDS를 생성하지 않고 Supabase를 외부 의존성으로 사용합니다.
- 환경은 `dev-kc`, `prod-kc` 디렉토리로 분리합니다.

## 디렉토리 구조

- `bootstrap/state-backend`: Terraform remote state용 S3 + DynamoDB 생성
- `modules/network_inputs`: 기존 VPC/서브넷/Hosted Zone 데이터 참조
- `modules/edge_tls`: ACM, ALB, Listener, Target Group
- `modules/backend_host`: EC2, EIP, Security Group, IAM, user-data
- `modules/storage`: 애플리케이션 S3 버킷
- `modules/config_ssm`: SSM 파라미터 + EC2 role read policy
- `environments/dev-kc`: 개발 환경 루트
- `environments/prod-kc`: 운영 환경 스켈레톤

## 빠른 시작

1) Remote state 부트스트랩

```bash
cd bootstrap/state-backend
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

2) dev-kc 배포

```bash
cd environments/dev-kc
cp backend.hcl.example backend.hcl
cp dev-kc.tfvars.example dev-kc.tfvars
terraform init -backend-config=backend.hcl
terraform plan -var-file=dev-kc.tfvars
terraform apply -var-file=dev-kc.tfvars
```

## 주의 사항

- `backend.hcl`, 실제 `*.tfvars`는 Git에 커밋하지 않습니다.
- SSM 파라미터 예시 값(`CHANGE_ME`)은 실제 값으로 교체 후 적용합니다.
- 백엔드 애플리케이션 컨테이너 배포는 Backend 레포 GitHub Actions(SSH)에서 수행합니다.
