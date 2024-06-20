.PHONY: gen apk web win ncommit pull ico

gen:
	flutter pub run build_runner build --delete-conflicting-outputs

apk:
	flutter build apk 

web:
	flutter run -d web 

win:
	flutter run -d windows

ncommit:
	git add .
	git commit -m "ncommit"
	git push origin main 

pull:
	git add .
	git commit -m "ncommit"
	git pull origin main

ico:
	flutter pub get
	flutter pub run flutter_launcher_icons