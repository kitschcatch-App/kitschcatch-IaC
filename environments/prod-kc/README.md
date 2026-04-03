# prod-kc Terraform

## 초기화

```bash
cd environments/prod-kc
cp backend.hcl.example backend.hcl
terraform init -backend-config=backend.hcl
```

## 계획/적용

```bash
cp prod-kc.tfvars.example prod-kc.tfvars
terraform plan -var-file=prod-kc.tfvars
terraform apply -var-file=prod-kc.tfvars
```

## 주의 사항

- PostgreSQL은 AWS RDS가 아니라 Supabase를 사용합니다.
- `ssm_parameters`는 기본값이 없으므로 `prod-kc.tfvars`에서 반드시 명시해야 합니다.
- `prod-kc.tfvars.example`의 `CHANGE_ME` 값은 실제 민감정보로 변경해야 합니다.
- `ssm_kms_key_arns`를 비워두면 `alias/aws/ssm`을 사용하고, 값을 지정하면 해당 KMS 키로만 복호화 권한이 제한됩니다.
- 백엔드 배포는 Backend 레포의 GitHub Actions에서 SSH로 EC2에 배포합니다.
