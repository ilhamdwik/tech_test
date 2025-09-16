# Infrastructure as Code (IaC) – GCP Cloud SQL + VPC + Cloud Run

## Folder ini berisi konfigurasi Terraform untuk membuat infrastruktur di Google Cloud Platform (GCP) yang meliputi:

- [VPC dengan subnet publik dan privat]
- [Cloud SQL (PostgreSQL) dengan Private IP]
- [(Opsional) Cloud Run service yang terkoneksi ke Cloud SQL melalui VPC]


## Struktur Folder & File

- [provider.tf: konfigurasi provider GCP]
- [variables.tf: definisi variabel seperti project_id, region, db_name, db_user, db_password dll]
- [vpc.tf: konfigurasi VPC, subnet publik & privat]
- [cloudsql.tf: provisioning Cloud SQL Postgres dengan Private IP & peering]
- [cloudrun.tf: (jika ada) konfigurasi Cloud Run + VPC Connector agar bisa akses Cloud SQL]
- [outputs.tf: output berguna seperti Cloud Run URL, connection name Cloud SQL, dll]


## Cara Provision

```
Langkah-langkah untuk menjalankan Terraform:

Clone repo

git clone https://github.com/ilhamdwik/tech_test.git
cd tech_test/iac


Buat file terraform.tfvars di direktori iac/, isi dengan konfigurasi Anda, contohnya:

project_id   = "YOUR_GCP_PROJECT_ID"
region       = "asia-southeast2"

db_name      = "nama_database"
db_user      = "nama_user"
db_password  = "db_password"


Inisialisasi Terraform:

terraform init


Lihat rencana perubahan:

terraform plan


Terapkan infrastrukturnya:

terraform apply


Konfirmasi dengan yes bila diminta.
```


## Apa yang Akan Dibuat

Setelah terraform apply selesai, akan dibuat:

- [VPC bernama app-vpc (atau nama sesuai variabel Anda) dengan dua subnet: Subnet publik dan Subnet privat]
- [Cloud SQL PostgreSQL dengan Private IP, hanya bisa diakses melalui jaringan privat (melalui VPC + peering)]
- [(Opsional) Cloud Run Service yang menggunakan VPC Connector agar bisa mengakses database di privat subnet]


## Cara Developer Akses Database

### Karena database menggunakan Private IP, tidak bisa diakses langsung dari internet. Beberapa opsi untuk akses developer:

- [Gunakan Cloud SQL Auth Proxy → developer jalankan proxy di laptop atau VM, koneksi aman ke DB.]
- [Buat bastion host (VM) di dalam VPC / subnet privat yang punya akses ke database, developer SSH ke bastion dan dari situ konek ke DB.]
- [Jika dibutuhkan, tambahkan IP publik developer di authorized_networks (tetapi ini kurang aman).]


## Outputs

### Setelah selesai provisioning, Terraform akan mengeluarkan beberapa output penting:

- [cloudsql_connection_name (nama koneksi Cloud SQL)]
- [cloud_run_url (jika Cloud Run dibuat)]
- [(Bisa ditambah) IP privat dari Cloud SQL, user/password database]


## Cleanup / Menghapus Semua

### Kalau ingin menghapus semua infrastruktur yang dibuat:

```
terraform destroy
```

Periksa kembali resources yang akan dihapus, lalu konfirmasi yes.