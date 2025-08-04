# 📝 Todo App

Una aplicación Flutter para gestionar tareas pendientes. Incluye funciones como filtros, creación de tareas, estadísticas, y soporte para temas claro/oscuro.

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
Para ejecutar un archivo de prueba específico (por ejemplo `test_widgets.dart`):

```bash
flutter test test/test_widgets.dart
```

Para ejecutar todas las pruebas:

```bash
flutter test
```

## 📁 Estructura del Proyecto
```bash
lib/
├── features/
│   └── task/
│       ├── presentation/
│       │   ├── pages/
│       │   └── widgets/
├── theme/
│   └── presentation/
│       └── bloc/
└── app.dart
└── main.dart
```
## 🎨 Funcionalidades
- Crear nuevas tareas
- Filtrar por: Pendientes, Todas o Completadas
- Ver estadísticas de tareas
- Cambiar entre tema claro y oscuro
- Navegación entre pantallas


## 🧑‍💻 Autor
Desarrollado por Desarrollado por [Percy Tomicha](https://github.com/BSolPercyTomicha)