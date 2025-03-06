-- Eliminar la base de datos "tarea2" si ya existe
DROP DATABASE IF EXISTS tarea2;

-- Crear la base de datos "tarea2" con codificación UTF-8
CREATE DATABASE tarea2 CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Usar la base de datos "tarea2"
USE tarea2;

-- Crear la tabla de usuarios
CREATE TABLE usuarios (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(64) NOT NULL,
    email VARCHAR(64) NOT NULL UNIQUE,
    password VARCHAR(128) NOT NULL
);

-- Crear la tabla de roles
CREATE TABLE roles (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(64) NOT NULL UNIQUE
);

-- Crear la tabla intermedia para la relación muchos a muchos entre usuarios y roles
CREATE TABLE usuario_roles (
    usuario_id BIGINT,
    rol_id BIGINT,
    PRIMARY KEY (usuario_id, rol_id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (rol_id) REFERENCES roles(id)
);

-- Insertar roles en la tabla roles
INSERT INTO roles (nombre) VALUES ('ROLE_ADMIN'), ('ROLE_USER');

-- Eliminar el usuario 'admin' si ya existe
DROP USER IF EXISTS 'admin'@'localhost';
FLUSH PRIVILEGES;

-- Crear el usuario 'admin' con la contraseña 'admin'
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';

-- Otorgar todos los permisos sobre la base de datos "tarea2" al usuario 'admin'
GRANT ALL PRIVILEGES ON tarea2.* TO 'admin'@'localhost';

-- Aplicar los cambios
FLUSH PRIVILEGES;
o    Actualiza el archivo application.properties:
# Configuración de la base de datos
spring.datasource.url=jdbc:mysql://localhost:3306/tarea2
spring.datasource.username=admin
spring.datasource.password=admin
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# Configuración de JPA
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

# Configuración de Thymeleaf
spring.thymeleaf.cache=false
o    Comprobar la conexión con su aplicación:
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySQLController {

    // Parámetros de conexión
    private static final String URL = "jdbc:mysql://localhost:3306/practica2?useSSL=false&serverTimezone=UTC";
    private static final String USER = "admin"; // Usar el nuevo usuario 'admin'
    private static final String PASSWORD = "admin"; // Contraseña 'admin'

    public static void main(String[] args) {
        Connection connection = null;

        try {
            // Conectar a la base de datos
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Conexión exitosa a la base de datos MySQL");

        } catch (SQLException e) {
            System.out.println("Error al conectar a la base de datos: " + e.getMessage());
        } finally {
            try {
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                    System.out.println("Conexión cerrada");
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar la conexión: " + e.getMessage());
            }
        }
    }
}