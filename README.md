# CompuNubeLAb_SistemasDistribuidores

## Informe ejecutivo (laboratorio: aplicación distribuida con Docker Compose y balanceo NGINX en Gitpod)

### Contexto y justificación del entorno
Para la ejecución del laboratorio se utilizó **Gitpod** como entorno de desarrollo en la nube. Esta decisión se tomó debido a limitaciones del equipo local, donde se evidenció un **Docker desactualizado** y un **WSL (Windows Subsystem for Linux) también desactualizado**, lo cual afectaba la compatibilidad y estabilidad del montaje. Adicionalmente, la **red local presentaba lentitud** por alta concurrencia de descargas, incrementando los tiempos de instalación y construcción de imágenes.  
Gitpod permitió contar con un entorno reproducible, accesible desde el navegador y con soporte adecuado para contenedores, reduciendo fricciones operativas y acelerando el despliegue.

### Objetivo del laboratorio
Implementar y desplegar una **aplicación sencilla en Node.js** dentro de un esquema tipo “sistema distribuido” usando **contenedores Docker**, ejecutando **múltiples instancias** del servicio y un **balanceador de carga NGINX**, para demostrar:
- distribución de tráfico (balanceo),
- escalabilidad horizontal,
- y tolerancia a fallos ante la caída de un nodo.

### Desarrollo de la solución
Se construyó una aplicación básica en **Node.js (Express)** cuyo endpoint principal (`/`) responde un mensaje indicando el **hostname del contenedor**, con el fin de identificar desde qué nodo se atiende cada solicitud.

Luego se definieron los archivos de contenerización y orquestación:

- **Dockerfile:** se utilizó una imagen base de **Node.js** para empaquetar la aplicación, instalar dependencias y exponer el puerto del servicio.
- **docker-compose.yml:** se configuraron **dos instancias** de la aplicación (por ejemplo, `web1` y `web2`) como servicios independientes.  
- **nginx.conf + servicio nginx:** se incorporó un contenedor **NGINX** como **balanceador de carga**, configurado con un `upstream` que apunta a las instancias Node.js. NGINX distribuye las solicitudes entrantes entre `web1` y `web2`.

Finalmente, se ejecutó el despliegue con **Docker Compose**, construyendo la imagen de la aplicación y levantando todos los servicios en conjunto. La validación se realizó accediendo al endpoint del balanceador y recargando varias veces, observando que las respuestas alternaban entre los hostnames de los contenedores, evidenciando el balanceo.

### Prueba de tolerancia a fallos (rebalanceo)
Para simular una caída de un nodo, se **detuvo intencionalmente** uno de los servicios web (por ejemplo, `web1`). Tras esta interrupción, el sistema mantuvo la disponibilidad: el balanceador continuó atendiendo solicitudes redirigiéndolas automáticamente a la(s) instancia(s) restante(s) activa(s).  
Esto demostró el comportamiento esperado de **tolerancia a fallos**, donde el servicio sigue operativo aunque un nodo deje de responder, y el tráfico se redistribuye hacia los nodos disponibles.

### Conclusión
El laboratorio cumplió el objetivo de demostrar, en un entorno controlado (Gitpod), un despliegue basado en contenedores con **múltiples nodos**, **balanceo de carga** y **continuidad operativa** ante fallos. El uso de Gitpod permitió mitigar problemas del entorno local (versiones desactualizadas y red lenta) y asegurar un despliegue consistente y repetible.
