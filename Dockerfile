# Temel imaj olarak OpenJDK 11 kullanıyoruz
FROM openjdk:11-jre-slim

# Çalışma dizinini ayarla
WORKDIR /app

# Maven ile derlenmiş JAR dosyasını kopyala
COPY target/simple-java-app-1.0-SNAPSHOT.jar app.jar

# Uygulamayı çalıştır
ENTRYPOINT ["java", "-jar", "app.jar"]
