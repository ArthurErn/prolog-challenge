
Este projeto foi desenvolvido como parte de um desafio técnico proposto para uma vaga de desenvolvedor Flutter Pleno na empresa Prolog.
O objetivo do desafio foi construir uma aplicação Flutter que consome uma API para exibir informações detalhadas sobre pneus, utilizando boas práticas de desenvolvimento mobile e otimização de performance.

## Versões utilizadas:
```
Flutter (Channel stable, 3.22.2, on Microsoft Windows [versÆo 10.0.22631.4112], locale pt-BR)
Dart SDK version: 3.4.3 (stable) (Tue Jun 4 19:51:39 2024 +0000) on "windows_x64"
VS Code (version 1.92.2)
```

## Dependências:
```
http: ^1.2.2
flutter_dotenv: ^5.0.2
intl: ^0.19.0
carousel_slider: ^4.0.0
```

## Estrutura do projeto:
```
lib/
├── custom/
│   └── app_colors.dart
├── model/
│   ├── tire_current_retread.dart
│   ├── tire_disposal.dart
│   ├── tire_installed.dart
│   ├── tire_make.dart
│   ├── tire_model.dart
│   ├── tire_size.dart
│   └── tire.dart
├── services/
│   └── api_service.dart
├── view/
│   ├── splashscreen.dart
│   ├── tire_info.dart
│   └── tire_list_screen.dart
└── main.dart
```
## Instalação:
1. Clone o repositório:
    git clone https://github.com/usuario/nome-do-projeto.git
2. Instale as dependências:
    flutter pub get
3. Rode o projeto:
    flutter run
