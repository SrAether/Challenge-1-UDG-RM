#!/bin/bash

# Validar si se pasaron suficientes argumentos
if [ $# -ne 7 ]; then
  echo "Uso: $0 <nombre_vm> <tipo_so> <num_cpus> <memoria_mb> <vram_mb> <size_disco_gb> <ruta_iso>"
  exit 1
fi

# Obtener los argumentos de la línea de comandos
nombre_vm=$1
tipo_so=$2
num_cpus=$3
memoria_mb=$4
vram_mb=$5
size_disco_gb=$6
ruta_iso=$7

# Calcular el tamaño del disco en MB
size_disco_mb=$((size_disco_gb * 1024))

# Crear el directorio para almacenar los discos duros virtuales
# verificar si discos existe
if [ ! -d "$HOME/discos" ]; then
  mkdir -p "$HOME/discos" || { echo "Error al crear el directorio para almacenar los discos duros virtuales."; exit 1; }
  echo "Se creó el directorio $HOME/discos"
fi
# verificar si el directorio ya existe
if [ ! -d "$HOME/discos/$nombre_vm" ]; then
  mkdir -p "$HOME/discos/$nombre_vm" || { echo "Error al crear el directorio para almacenar los discos duros virtuales."; exit 1; }
  echo "Se creó el directorio $HOME/discos/$nombre_vm"
fi

# Crear la máquina virtual
VBoxManage createvm --name "$nombre_vm" --ostype "$tipo_so" --register || { echo "Error al crear la máquina virtual."; exit 1; }

# Configurar la máquina virtual
VBoxManage modifyvm "$nombre_vm" --cpus "$num_cpus" --memory "$memoria_mb" --vram "$vram_mb" || { echo "Error al configurar la máquina virtual."; exit 1; }

# Configurar la red (NAT)
VBoxManage modifyvm "$nombre_vm" --nic1 nat || { echo "Error al configurar la red."; exit 1; }

# Crear el disco duro virtual
VBoxManage createhd --filename "$HOME/discos/$nombre_vm/$nombre_vm.vdi" --size "$size_disco_mb" --variant Standard || { echo "Error al crear el disco duro virtual."; exit 1; }

# Agregar el controlador SATA
VBoxManage storagectl "$nombre_vm" --name "SATA Controller" --add sata --bootable on || { echo "Error al agregar el controlador SATA."; exit 1; }

# Conectar el disco duro virtual al controlador SATA
VBoxManage storageattach "$nombre_vm" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$HOME/discos/$nombre_vm/$nombre_vm.vdi" || { echo "Error al conectar el disco duro virtual."; exit 1; }

# Agregar el controlador IDE
VBoxManage storagectl "$nombre_vm" --name "IDE Controller" --add ide || { echo "Error al agregar el controlador IDE."; exit 1; }

# Adjuntar la imagen ISO al controlador IDE
VBoxManage storageattach "$nombre_vm" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "$ruta_iso" || { echo "Error al adjuntar la imagen ISO."; exit 1; }

# Habilitar visualización remota
VBoxManage modifyvm "$nombre_vm" --vrde on

# Configuración adicional basada en la comparación

# Controlador gráfico VMSVGA
VBoxManage modifyvm "$nombre_vm" --graphicscontroller vmsvga

# Habilitar IOAPIC
VBoxManage modifyvm "$nombre_vm" --ioapic on

# Habilitar audio
VBoxManage modifyvm "$nombre_vm" --audio-driver pulse --audioout on --audioin on

# Mostrar la información de la máquina virtual
VBoxManage showvminfo "$nombre_vm"

