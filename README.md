# Asistente de Tránsito IA - Código Nacional de Tránsito Colombia

Aplicación Flutter que permite consultar la **Ley 769 de 2002 del Código Nacional de Tránsito de Colombia** a través de un chat inteligente powered by OpenAI. Utiliza un modelo fine-tuned especializado en legislación de tránsito colombiana.

## 🚗 Características

- **Chat Inteligente**: Interfaz de chat moderna y responsive
- **IA Especializada**: Modelo OpenAI fine-tuned específicamente en la Ley 769 de 2002
- **Respuestas Precisas**: Información exacta sobre multas, sanciones, procedimientos y normativas
- **Español Colombiano**: Respuestas con acentuación y terminología correcta
- **Multiplataforma**: Funciona en Web, Android, iOS, Windows, macOS y Linux

## 🛠️ Configuración del Proyecto

### Prerrequisitos

- Flutter SDK (>=3.7.2)
- Dart SDK
- Cuenta de OpenAI con acceso a API
- Modelo fine-tuned de OpenAI (opcional, se puede usar GPT-4 estándar)

### Instalación

1. **Clonar el repositorio**
```bash
git clone <repository-url>
cd codigo_transito_devpaul
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Configurar variables de entorno**

Crea un archivo `.env` en la raíz del proyecto con el siguiente contenido:

```env
# OpenAI Configuration
OPENAI_API_KEY=tu_api_key_de_openai_aquí
OPENAI_MODEL=tu_modelo_fine_tuned
```

**⚠️ Importante**: 
- Reemplaza `tu_api_key_de_openai_aquí` con tu API key real de OpenAI
- Reemplaza `tu_modelo_fine_tuned` con tu modelo fine-tuned

- El modelo puede ser un fine-tuned personalizado o un modelo estándar como `gpt-4o-mini`
- **NUNCA** subas el archivo `.env` a control de versiones

4. **Generar código (si usas build_runner)**
```bash
dart run build_runner watch
```

5. **Ejecutar la aplicación**
```bash
flutter run
```

## 📱 Uso

1. Abre la aplicación
2. Navega a "Consultar Ley de Tránsito"
3. Escribe tu pregunta sobre el código de tránsito
4. Recibe respuestas precisas y actualizadas

### Ejemplos de Consultas

- "¿Cuáles son las multas por exceso de velocidad?"
- "¿Qué documentos debo portar al conducir?"
- "¿Cuándo se suspende la licencia de conducción?"
- "¿Qué es una comparendo y cómo se paga?"

## 🏗️ Arquitectura

```
lib/
├── config/           # Configuración de tema y rutas
├── infrastructure/   # Servicios externos (OpenAI API)
├── presentation/     # UI y providers (Riverpod)
│   ├── providers/    # Estado de la aplicación
│   └── screens/      # Pantallas de la app
└── main.dart        # Punto de entrada
```

## 🔧 Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo multiplataforma
- **Riverpod**: Gestión de estado reactiva
- **OpenAI API**: Inteligencia artificial conversacional
- **flutter_chat_ui**: Interfaz de chat moderna
- **flutter_dotenv**: Gestión de variables de entorno
- **http**: Cliente HTTP para API calls

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## Contact

Developed by:
- Paul Realpe
- Jimmy Realpe

Email: co.devpaul@gmail.com

Phone: 3148580454

<a href="https://devpaul.pro">https://devpaul.pro/</a>

Feel free to reach out for any inquiries or collaborations!
