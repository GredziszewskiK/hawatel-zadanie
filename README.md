# hawatel-zadanie
Zadanie rekrutacyjne - Junior python developer.

---
### Przygotowanie środowiska na Windows:
1. Przygotować wirtualne środowisko ```python -m venv venv_hawatel_zadanie```
2. Uruchomić wirtualne środowisko.
3. Zainstalować niezbędne biblioteki ```pip install -r requirments.txt```
4. Skonfigurować dane dostępu do api i bazy danych w pliku ```config.py```

### Uruchomienie
Skrypt należy uruchamiać przez cli.py np. ```python cli.py --help```.

Dostępne są dwie komendy.
1. ```update-prices``` do aktualizacji cen w dolarach i euro. Za pomocą opcji można wskazać które ceny nalerzy zaktualizować.
2. ```export-products``` do eksportu tabeli produktów.

Każda z komend posiada opcje --help do wyświetlania podpowiedzi.
