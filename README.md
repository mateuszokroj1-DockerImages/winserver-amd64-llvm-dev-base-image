# Windows Server LLVM Dev Base Image

Windows development image based on Windows Server LTSC 2025 Server Core. It
includes LLVM and common C/C++ development tools, plus Git, .NET, Rust,
Python, Java, Node.js, MSYS2, Docker CLI, and vcpkg.

## Operating system and architecture

- **Base image:** `mcr.microsoft.com/windows/servercore:ltsc2025`.
  The tag is refreshed by Docker during builds with `--pull`; it is not pinned
  to an immutable digest.
- **Architecture:** Windows amd64.
- **User:** `ContainerUser`.
- **Working directory:** `C:\Users\ContainerUser`.

Windows containers require a compatible Windows host with Windows container
support enabled. A Linux Docker daemon cannot build or run this image.

## Build

```powershell
docker build --pull -t mateuszokroj1/winserver-amd64-llvm-dev-base:latest .
```

## Installed tools

| Tool | Version / source |
|---|---|
| Windows Server | LTSC 2025 Server Core |
| Chocolatey | 2.7.5; package SHA-512 and bootstrap script SHA-256 are verified |
| Git for Windows | 2.56.1 |
| Git LFS | 3.8.1 |
| .NET SDK | 11.0.100 |
| Rust | 1.99.1 |
| rustup | 1.27.1 |
| CMake | 4.5.0 |
| LLVM | 23.1.3 |
| Python | 3.15.2 |
| OpenJDK | 27.0.1.3 |
| MSYS2 | 20260927.0.0 |
| Node.js | 26.13.1 |
| Docker | Docker CLI 29.9.3; no Docker daemon |
| vcpkg | Revision `2ebb714221ad4e482e596d64c129f63fbbfb3fd5` |

Chocolatey package versions are pinned in the Dockerfile and installed with
checksum verification. Transient package-feed failures are retried up to
three times. The vcpkg checkout is checked against its pinned revision before
bootstrapping.

## Usage

Start an interactive PowerShell session as the unprivileged container user:

```powershell
docker run --rm -it --user ContainerUser --workdir C:\Users\ContainerUser `
  mateuszokroj1/winserver-amd64-llvm-dev-base:latest powershell
```

`VCPKG_ROOT` points to `C:\Users\ContainerUser\vcpkg`, which is also added to
`PATH`. The image contains Docker client tools only; using Docker commands
requires access to a compatible host Docker daemon. Do not expose a host Docker
endpoint to untrusted containers.

## CI and vulnerability scanning

The pull-request workflow builds the image with `--pull` and runs Docker Scout.
The workflow fails if the image has critical or high severity findings.
