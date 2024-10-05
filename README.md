
# Challenge-1-UDG-RM

Este repositorio contiene un script en Bash que permite crear y configurar máquinas virtuales en VirtualBox de manera automatizada, utilizando parámetros de entrada. El script está diseñado para ser sencillo y flexible, lo que facilita la creación de máquinas virtuales con diferentes configuraciones de hardware y software.

## Requisitos

- Tener instalado [VirtualBox](https://www.virtualbox.org/) en tu sistema.
- Tener un archivo ISO del sistema operativo que deseas instalar en la máquina virtual.
- El script está pensado para ejecutarse en sistemas tipo UNIX (Linux o macOS).

## Uso del Script

El script `crear-mv-con-arg.sh` acepta los siguientes parámetros:

```bash
./crear-mv-con-arg.sh <nombre_vm> <tipo_so> <num_cpus> <memoria_mb> <vram_mb> <size_disco_gb> <ruta_iso>
```

### Parámetros:

- `nombre_vm`: Nombre de la máquina virtual.
- `tipo_so`: El tipo de sistema operativo, por ejemplo `Ubuntu_64`, `ArchLinux_64`.
- `num_cpus`: Número de CPUs que tendrá la máquina virtual.
- `memoria_mb`: Cantidad de memoria RAM en MB para la máquina virtual.
- `vram_mb`: Cantidad de memoria de video (VRAM) en MB.
- `size_disco_gb`: Tamaño del disco duro virtual en GB.
- `ruta_iso`: Ruta completa al archivo ISO del sistema operativo que se utilizará para la instalación.

### Ejemplo de uso:

```bash
./crear-mv-con-arg.sh "mi_vm" "Ubuntu_64" 2 2048 16 20 "/ruta/al/archivo.iso"
```

Este comando creará una máquina virtual llamada `mi_vm` con las siguientes características:
- 2 CPUs
- 2048 MB de RAM
- 16 MB de VRAM
- Disco duro de 20 GB
- Archivo ISO especificado para instalar el sistema operativo

## Funcionalidades del Script

1. **Validación de argumentos**: El script verifica si se pasan los argumentos necesarios antes de proceder.
2. **Creación de directorios**: Se asegura de que existan directorios para almacenar los discos virtuales en `$HOME/discos`.
3. **Creación de la máquina virtual**: Utiliza `VBoxManage` para crear y configurar la máquina virtual con el nombre y tipo de sistema operativo especificados.
4. **Configuración del hardware**:
   - CPUs, memoria RAM, y VRAM según lo indicado en los parámetros.
   - Configuración de red utilizando NAT.
   - Creación y conexión de discos duros virtuales.
   - Adjuntar una imagen ISO al controlador IDE para la instalación del sistema operativo.
5. **Habilitar audio y video**:
   - Configuración del audio utilizando PulseAudio.
   - Controlador gráfico configurado como `VMSVGA`.
6. **Visualización remota**: Habilita el acceso remoto a la máquina virtual mediante VRDE.
7. **Mostrar información**: Al final, muestra la información de la máquina virtual creada.

## Ejecución del Script

Para ejecutar el script, asegúrate de haber clonado el repositorio y tener los permisos adecuados:

```bash
git clone https://github.com/SrAether/Challenge-1-UDG-RM.git
cd Challenge-1-UDG-RM
chmod +x crear-mv-con-arg.sh
./crear-mv-con-arg.sh "nombre_vm" "tipo_so" "num_cpus" "memoria_mb" "vram_mb" "size_disco_gb" "ruta_iso"
```

## Contribuciones

Si deseas contribuir a este proyecto, puedes hacer un fork del repositorio, realizar tus cambios y enviar un Pull Request. ¡Toda contribución es bienvenida!
