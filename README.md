# windows-forensics-tfm
# Examen Forense de un Sistema Windows (TFM)

Este repositorio contiene la documentación, metodología y el desarrollo práctico del Trabajo Fin de Máster (TFM) enfocado en el **Análisis Forense Digital** aplicado a un entorno corporativo Windows tras un ataque de *phishing*.

El proyecto recrea un escenario real donde una negligencia humana compromete activos empresariales, sirviendo de guía tanto para la respuesta técnica ante incidentes como para la correcta preservación de la cadena de custodia de cara a un proceso judicial.

---

## 📋 Descripción del Caso Práctico

La empresa **Futuro 3000** sufre el secuestro de sus cuentas publicitarias en la plataforma Facebook. El origen del ciberincidente radica en un ataque de ingeniería social (*phishing*) dirigido a la responsable del departamento. 

Mediante una plantilla de correo fraudulenta enviada a través de Amazon SES, la víctima es redirigida a una landing page falsa (servidor malicioso controlado por el atacante). Tras introducir las credenciales, el atacante captura el usuario y la contraseña en texto plano, modificando posteriormente el acceso a la plataforma real y desplegando campañas maliciosas.

---

## 🛠️ Entorno de Laboratorio

Para la emulación del ataque y posterior análisis se configuraron dos máquinas virtuales principales:
*   **Máquina Víctima:** Windows 10 Pro de 64 bits (4 GB RAM, 2 Núcleos, Disco de 60 GB), simulando el terminal de la empresa con Google Chrome y antivirus activo.
*   **Máquina Atacante:** Distribución Linux para pentesting equipada con un servidor web Apache (XAMPP) y plantillas de correo generadas en Visual Studio Code.

---

## 🔍 Metodología Forense Aplicada

El análisis sigue las directrices internacionales y el marco del derecho penal español, dividiéndose en cuatro fases fundamentales:

### 1. Evaluación y Datos Volátiles
Recopilación de información crítica en la memoria activa del sistema antes del apagado del terminal:
*   Conexiones de red activas y tablas de enrutamiento (`netstat`, `ipconfig`, `arp -a`).
*   Servicios del sistema y procesos en ejecución (`sc query`, `tasklist`).
*   Volcado completo de la memoria RAM (fichero `.raw` de ~5 GB) utilizando `Dumpit.exe`.
*   Exportación de registros del sistema utilizando comandos `REG EXPORT`.

### 2. Adquisición (Clonado Forense)
*   **Vertiente Legal:** Planificación de la cadena de custodia y preservación de discos físicos en sede judicial bajo supervisión del Letrado de la Administración de Justicia para evitar nulidades procesales.
*   **Vertiente Técnica:** Conexión mediante bloqueador de escritura SATA y uso de **AccessData FTK Imager** para generar una imagen forense idéntica en formato Raw (.dd) con verificación de integridad criptográfica (Hash).

### 3. Análisis de Artefactos e Indicadores de Compromiso (IoC)
*   **Análisis de Sistema (Prefetch y Event Viewer):** Descarte de malware persistente o afectación a binarios críticos del sistema operativo.
*   **Análisis del Navegador (Google Chrome):** Extracción y consulta SQL de la base de datos `History` mediante *SQLite Manager*, localizando el rastro del subdominio fraudulento typo-squatted: `http://192.168.179.130/faceboook`.
*   **Análisis de Tráfico de Red:** Inspección de capturas con **Wireshark** restringiendo el flujo al protocolo HTTP, permitiendo aislar el momento exacto de la inyección de credenciales por método GET/POST exfiltradas hacia el servidor del atacante.
*   **Análisis de Correo Electrónico:** Rastreo de cabeceras en el correo cebo, identificando el dominio origen (`test@bootstrapemail.com`) y los servidores de envío de Amazon.

### 4. Informe Forense y Conclusión
*   Generación de las evidencias que integran el dictamen pericial.
*   Propuesta de medidas de mitigación y concienciación frente a la ingeniería social.

---

## 📂 Estructura del Proyecto

*   `/docs`: Documentación de texto del TFM, metodología y anexos legales.
*   `/scripts`: Comandos y pequeños scripts utilizados para la extracción de logs y registros.
*   `/evidence_samples`: Capturas de configuración de red (`netstat`, `arp`), fragmentos de logs analizados (`setupact.log`, `mrt.log`) y esquemas del phishing desarrollado en PHP/HTML.

---

## 🎓 Autor
*   **Marcos Antonio Agudo Prieto** - *Trabajo Fin de Máster*
