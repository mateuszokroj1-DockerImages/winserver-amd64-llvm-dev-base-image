FROM mcr.microsoft.com/windows/servercore:ltsc2025

USER ContainerAdministrator

RUN choco install git
RUN choco install git-lfs
RUN choco install dotnet-11.0-sdk
RUN choco install rust
RUN choco install rustup.install
RUN choco install cmake
RUN choco install llvm
RUN choco install python
RUN choco install openjdk
RUN choco install msys2
RUN choco install nodejs

USER ContainerUser
WORKDIR $HOME

RUN git clone https://github.com/microsoft/vcpkg.git
RUN vcpkg/bootstrap-vcpkg.bat

ENV VCPKG_ROOT $HOME/vcpkg
ENV PATH $VCPKG_ROOT:$PATH

RUN echo $PATH
