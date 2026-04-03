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
- `prod-kc.tfvars.example`의 `CHANGE_ME`, `replace-me` 등 모든 예시 값은 실제 환경에 맞는 값으로 변경해야 합니다.
- `ssm_kms_key_arns`를 비워두면 기본 KMS 키(`alias/aws/ssm`)를 사용합니다. 현재 모듈은 SSM 파라미터 생성 시 `key_id`를 지정하지 않으므로 커스텀 KMS 키 지정 시 복호화 권한 불일치가 발생할 수 있습니다.
- 백엔드 배포는 Backend 레포의 GitHub Actions에서 SSH로 EC2에 배포합니다.
