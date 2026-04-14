# Usar la imagen oficial de Node.js como base
	FROM node:14

	# Crear el directorio de trabajo dentro del contenedor
	WORKDIR /usr/src/app

	# Copiar los archivos package.json y package-lock.json
	COPY package*.json ./

	# Instalar las dependencias
	RUN npm install

	# Copiar el resto de los archivos de la aplicación
	COPY . .

	# Exponer el puerto en el que la app estará corriendo
	EXPOSE 3000

	# Comando para iniciar la aplicación
	CMD ["node", "app.js"]