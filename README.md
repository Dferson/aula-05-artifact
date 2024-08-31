# GitHub Actions Workflow - Aula 05 Artifact

Este repositório contém um workflow do GitHub Actions configurado para executar builds e baixar artefatos para diferentes sistemas operacionais. O workflow foi criado como parte do exercício da **Aula 05**.

## Configuração do Workflow

O arquivo de workflow `go-example.yml` está configurado para:

- Executar automaticamente a cada 15 minutos, de segunda a sábado.
- Iniciar dois novos jobs após a conclusão bem-sucedida do job `build-go`.

### 1) Agendamento do Workflow

No arquivo `go-example.yml`, foi adicionado um scheduler para executar o evento `push` a cada 15 minutos, de segunda a sábado. O cron utilizado para esta configuração é o seguinte:

```yaml
on:
  schedule:
    - cron: '*/15 * * * 1-6'
  push:
    branches:
      - main
```

### 2) Novos Jobs no Workflow

Foram adicionados dois novos jobs no workflow `go-example.yml`, que dependem do job `build-go`. Abaixo estão os detalhes de cada job:

#### 1º Job: `download-and-run-linux`

- **Identificador**: `download-and-run-linux`
- **Nome**: Download and run Linux
- **Runner**: Ubuntu latest
- **Passos**:
  1. **Checkout do repositório**:
     ```yaml
     - name: Checkout repository
       uses: actions/checkout@v3
     ```
  2. **Download do artefato**:
     ```yaml
     - name: Download Linux artifact
       uses: actions/download-artifact@v3
       with:
         name: linux
     ```
  3. **Executar o script `run.sh`**:
     ```yaml
     - name: Run script
       run: source ./run.sh
     ```

#### 2º Job: `download-only-windows`

- **Identificador**: `download-only-windows`
- **Nome**: Download Windows
- **Runner**: Windows latest
- **Passos**:
  1. **Checkout do repositório**:
     ```yaml
     - name: Checkout repository
       uses: actions/checkout@v3
     ```
  2. **Download do artefato**:
     ```yaml
     - name: Download Windows artifact
       uses: actions/download-artifact@v3
       with:
         name: windows
     ```

### Dependências entre Jobs

Os dois novos jobs (`download-and-run-linux` e `download-only-windows`) são executados após a conclusão bem-sucedida do job `build-go`. A configuração de dependência é especificada como segue:

```yaml
jobs:
  build-go:
    # Configuração do job build-go...

  download-and-run-linux:
    needs: build-go
    # Configuração do job download-and-run-linux...

  download-only-windows:
    needs: build-go
    # Configuração do job download-only-windows...
```

---
