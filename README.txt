COOVALLUNA - Sistema de Ahorro y Crédito
Universidad del Valle - Bases de Datos Relacionales

REQUISITOS:
- PostgreSQL 16
- Apache Tomcat 10.1
- Java 17

INSTALACIÓN:
1. Restaurar BD: ejecutar coovalluna_bd.sql en pgAdmin o psql
2. Compilar: mvn clean package
3. Copiar target/coovalluna.war a Tomcat/webapps/
4. Iniciar Tomcat
5. Abrir http://localhost:8080/coovalluna/

USUARIOS DE PRUEBA:
- admin / admin123 (Administrador)
- cajero1 / cajero123 (Asesor/Cajero)
- asociado1 / asociado123 (Asociado)

VIDEO
- https://drive.google.com/file/d/1OOfqVBwz1VqhO_bh3i9k44iR1P7386ot/view?usp=sharing
