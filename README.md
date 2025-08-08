# 📝 Todo App

Una aplicación Flutter para gestionar tareas. Incluye funciones como listado de tareas más filtro entre pendientes y completas, creación de tareas con asistencia de IA, editar tareas, eliminar tareas, estadísticas y soporte para temas claro/oscuro.

Funciona tanto en dispositivos Android e IOS.

---

## 🚀 Requisitos

Antes de comenzar, asegúrate de tener lo siguiente instalado:

- ✅ [Flutter SDK](https://docs.flutter.dev/get-started/install)
- ✅ [Android Studio](https://developer.android.com/studio) o [Visual Studio Code](https://code.visualstudio.com/)
- ✅ Un emulador configurado o un dispositivo físico conectado
- ✅ Git

Verifica que Flutter está correctamente instalado:

```bash
flutter doctor
```

## 📦 Instalación
Clona el repositorio y navega al directorio del proyecto:

```bash
git clone git@github.com:BSolPercyTomicha/todo_app.git
cd todo_app
```

Completa los siguientes campos en el archivo `.env` con tus credenciales de Azure OpenAI:
```bash
AZURE_OPENAI_API_VERSION=...
AZURE_OPENAI_ENDPOINT=...
AZURE_OPENAI_API_KEY=...
AZURE_OPENAI_DEPLOYMENT_NAME=...
```

Instala las dependencias del proyecto:

```bash
flutter pub get
```
## ▶️ Ejecución
Lanza la app en un emulador o dispositivo conectado:

```bash
flutter run
```
> También puedes abrir el proyecto en tu IDE y presionar el botón Run ▶️.

## 🧪 Ejecutar Pruebas
Para ejecutar un archivo de prueba específico (por ejemplo `task_filter_chips_test.dart`):

```bash
flutter test test/widgets/task_filter_chips_test.dart
```

Para ejecutar todas las pruebas:

```bash
flutter test
```

## 📁 Estructura del Proyecto
```bash
lib/
├── ia/
│   └── clients/
├── features/
│   └── task/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       ├── presentation/
│       │   ├── bloc/
│       │   ├── pages/
│       │   └── widgets/
├── shared/
├── theme/
│   └── presentation/
│       └── bloc/
test/
└── app.dart
└── di.dart
└── main.dart
```
## 🎨 Funcionalidades
- Listado de tareas
- Filtrar por: Pendientes, Todas o Completadas
- Editar y eliminar tareas
- Ver estadísticas de tareas
- Cambiar entre tema claro y oscuro
- Navegación entre pantallas
- Crear nuevas tareas
- Generación automática de descripciones para tareas mediante IA


## 🧑‍💻 Autor
Desarrollado por Desarrollado por [Percy Tomicha](https://github.com/BSolPercyTomicha)