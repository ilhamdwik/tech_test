# 1. Theoretical Answer

### What are the main differences between Cloud Run, Compute Engine, and GKE in GCP? When would you choose each one?
```
Cloud Run adalah layanan serverless dari Google Cloud yang memungkinkan menjalankan aplikasi berbasis kontainer tanpa perlu mengelola infrastruktur.

Compute Engine adalah layanan infrastruktur sebagai layanan (IaaS) dari Google Cloud yang memungkinkan pengguna membuat dan menjalankan mesin virtual (VM) di atas infrastruktur global Google, sebanding dengan Amazon EC2 dan Azure Virtual Machines.

Google Kubernetes Engine (GKE) adalah layanan Kubernetes terkelola dari Google Cloud yang menyederhanakan penempatan, pengelolaan, dan penskalaan aplikasi terkontainerisasi (dalam kontainer) di cloud. 
GKE memungkinkan developer untuk menjalankan klaster Kubernetes dengan infrastruktur yang dikelola otomatis oleh Google, menyediakan fitur seperti penskalaan otomatis, ketersediaan tinggi, keamanan, dan integrasi dengan layanan Google Cloud lainnya, sehingga mempermudah pengelolaan aplikasi skala besar. 
```

### Explain the concept of Infrastructure as Code (IaC) and its main benefits.
```
IaC (Infrastructure as Code) berarti mengelola infrastruktur menggunakan kode, biasanya dengan alat seperti Terraform atau Deployment Manager. 
IaC memungkinkan kontrol versi, pengulangan, dan konsistensi di seluruh lingkungan. 
Manfaatnya meliputi penerapan yang lebih cepat, pengurangan kesalahan manusia, rollback yang lebih mudah, dan peningkatan kolaborasi melalui GitOps. IaC juga menyederhanakan penskalaan dan pemulihan bencana.
```

### How would you configure IAM roles & policies to ensure secure CI/CD deployment in GCP?
```
Ikuti prinsip hak istimewa terkecil—berikan hanya peran yang diperlukan ke akun layanan CI/CD. 
Misalnya, izinkan Penulis Artifact Registry, Admin Cloud Run (atau Admin GKE/Compute, tergantung target), dan Pengguna Akun Layanan. 
Gunakan akun layanan terpisah untuk pipeline yang berbeda (build, deploy).
```

### If an application in Cloud Run frequently experiences latency spikes during autoscaling, what troubleshooting steps would you take?
```
Pertama, periksa apakah latensi berasal dari cold start dengan menganalisis metrik permintaan/instans. 
Tingkatkan instans minimum untuk mengurangi cold start jika perlu. Tinjau pengaturan konkurensi (terlalu rendah dapat menyebabkan lonjakan penskalaan). Analisis dependensi backend (misalnya, database, API eksternal) untuk menemukan hambatan. 
Pantau juga alokasi CPU/memori dan pertimbangkan untuk menggunakan Cloud Profiler/Trace untuk wawasan performa yang lebih mendalam.
```

### What is the difference between monitoring and logging, and how would you integrate both in GCP?
```
Pemantauan melacak kesehatan dan performa sistem (metrik seperti CPU, latensi, waktu aktif), sementara pencatatan mencatat data peristiwa detail (jejak permintaan, kesalahan, jejak tumpukan). 
Di GCP, pemantauan ditangani oleh Cloud Monitoring, dan pencatatan oleh Cloud Logging. 
Keduanya terintegrasi melalui metrik yang berasal dari log (metrik berbasis log). Hal ini memungkinkan pembuatan peringatan dari log sekaligus memvisualisasikan metrik di dasbor untuk observabilitas penuh.
```

# 5. Troubleshooting Scenario (Case Study)
## Scenario:
### Questions:
- An application running on Compute Engine frequently goes down due to full memory usage.
- Logs indicate a memory leak in the application, but developers cannot fix it in the short term.
- What quick win steps would you take to maintain application availability?
- What are the long-term solutions to prevent this issue from happening again?

```
Langkah-Langkah (Jangka Pendek)

Siapkan pemeriksaan kesehatan dengan Managed Instance Groups (MIG) sehingga VM yang tidak sehat dibuat ulang secara otomatis.

Tambahkan pemantauan + peringatan di Cloud Monitoring untuk memicu pengaktifan ulang saat memori melewati ambang batas.

Tingkatkan sementara memori VM atau tambahkan lebih banyak instans di belakang penyeimbang beban untuk menyebarkan lalu lintas.

Gunakan pekerjaan cron atau skrip untuk memulai ulang aplikasi/layanan secara berkala sebelum memori terisi penuh.


Solusi Jangka Panjang

Perbaiki kebocoran memori aplikasi dalam kode sebagai solusi permanen.

Pindahkan beban kerja ke kontainer (GKE/Cloud Run) dengan batasan sumber daya dan mulai ulang otomatis jika terjadi kegagalan.

Perkuat jaringan CI/CD dengan pengujian beban dan tekanan untuk mendeteksi kebocoran memori sebelum produksi.

Tetapkan perencanaan kapasitas dan kebijakan penskalaan otomatis berdasarkan tren penggunaan memori yang diamati.

Terapkan praktik terbaik observabilitas (dasbor, peringatan, pembuatan profil) untuk mendeteksi masalah serupa sejak dini.
```