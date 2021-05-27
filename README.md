# flutter_app

Simple flutter application

## APK
Файл apk/app-debug.apk

## Демо видео
Файл videos/Flutter app demo.mp4

## Комментарии по кодовой базе приложения (директория lib)

**main.dart**
- метод main (запуск приложения, определяет два провайдера: PostsModel и SettingsModel)
- класс MyApp (главный класс приложения, определяет MaterialApp, в котором стартовым виджетом является AppStatefulWidget)
- класс AppStatefulWidget (создаёт состояние самого виджета на основе класса _AppState)
- класс _AppState (в качестве изменяемой переменной выступает _selectedIndex - индекс отображаемого виджета:
  ProfileWidget, GalleryWidget, AddNewPostWidget и SettingsWidget; изменение значения происходит при вызове обработчика
  события onTap нижней навигационной панели)

**common/popup.dart** - диалоговое окно для вывода уведомления пользователю

**models/gallery.dart**
- класс GalleryModel, предоставляющий моковые данные для GalleryWidget, расположенного в widgets/gallery.dart

**models/posts.dart**:
- класс PostsModel (хранит текущее состояние созданных пользователем постов)
- класс Post (реализует сущность Post)

**models/settings.dart**:
- класс SettingsModel (хранит текущую информацию о пользователе)
- класс Settings (реализует сущность Settings - текущая информация о пользователе)

**widgets/add-new-post.dart**:
- класс AddNewPostWidget (виджет по добавлению нового поста)

**widgets/gallery.dart**:
- класс GalleryWidget (виджет, отображающий страницу "Галерея" с моковыми данными;
  при нажатии на любое фото происходит его отдельный просмотр с возможностью зума)

**widgets/posts-details.dart**:
- класс PostDetails (виджет, отображающий страницу с полной информацией о посте)

**widgets/profile.dart**:
- класс ProfileWidget (виджет, отображающий профиль пользователя и его посты; при нажатии
  на любое из фото происходит отображение виджета PostDetails)

**widgets/settings.dart**:
- класс GalleryWidget (виджет по изменению пользовательской информации)
