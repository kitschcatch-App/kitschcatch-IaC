# Terraform Remote State Bootstrap

이 스택은 Terraform 원격 상태 저장용 S3 버킷과 DynamoDB Lock 테이블을 생성합니다.

## 사용 방법

```bash
cd bootstrap/state-backend
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

생성 후 각 환경(`environments/dev-kc`, `environments/prod-kc`)의 `backend.hcl` 값에 버킷/테이블명을 반영합니다.
