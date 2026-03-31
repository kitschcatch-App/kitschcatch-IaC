# dev-kc Terraform

## 초기화

```bash
cd environments/dev-kc
cp backend.hcl.example backend.hcl
terraform init -backend-config=backend.hcl
```

## 계획/적용

```bash
cp dev-kc.tfvars.example dev-kc.tfvars
terraform plan -var-file=dev-kc.tfvars
terraform apply -var-file=dev-kc.tfvars
```

## 주의 사항

- PostgreSQL은 AWS RDS가 아니라 Supabase를 사용합니다.
- `ssm_parameters` 값은 예시이므로 실제 민감정보로 변경해야 합니다.
- 백엔드 배포는 Backend 레포의 GitHub Actions에서 SSH로 EC2에 배포합니다.
