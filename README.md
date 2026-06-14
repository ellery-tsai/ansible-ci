# ansible-ci

用於 Ansible 專案 CI/CD 的 Docker 容器映像，內含以下工具：

| 工具 | 用途 |
|------|------|
| [ansible-lint](https://ansible.readthedocs.io/projects/lint/) | 檢查 Ansible playbook 與 role 的語法和最佳實踐 |
| [yamllint](https://yamllint.readthedocs.io/) | 檢查 YAML 檔案格式 |
| [SonarQube Scanner CLI](https://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/scanners/sonarscanner/) | 靜態程式碼分析與品質掃描 |

## 建置映像

```bash
docker build -t ansible-ci .
```

如需指定 SonarQube Scanner 版本：

```bash
docker build --build-arg SONAR_SCANNER_VERSION=6.2.1.4610 -t ansible-ci .
```

## 使用方式

### ansible-lint

```bash
docker run --rm -v /path/to/your/ansible:/work ansible-ci ansible-lint playbook.yml
```

### yamllint

```bash
docker run --rm -v /path/to/your/ansible:/work ansible-ci yamllint .
```

### SonarQube Scanner

專案根目錄需有 `sonar-project.properties`：

```bash
docker run --rm \
  -v /path/to/your/project:/work \
  -e SONAR_HOST_URL=https://your-sonarqube-server \
  -e SONAR_TOKEN=your_token \
  ansible-ci sonar-scanner
```

## 映像規格

- **Base image**: `python:3.12-slim`
- **SonarQube Scanner 安裝路徑**: `/opt/sonar-scanner`
- **工作目錄**: `/work`
- **預設指令**: `bash`
