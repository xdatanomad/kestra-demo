## Populate Kestra Postgres database with Demo Activity

Original link:
https://github.com/kestra-io/kestra-ee/issues/2774#issuecomment-4074411875

### How to use

```bash
docker compose up -d postgres
cat scripts/seed_demo_data.sql | docker compose exec -T postgres psql -U kestra
docker compose up -d kestra

# bring down the cluster
docker compose down
```