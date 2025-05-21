# Bokhandel Databashantering

## Översikt
Detta projekt innehåller en SQL-databas för en bokhandel samt Python-skript för att interagera med databasen. Projektet är utvecklat som en del av kursen Databaser vid IT-högskolan.

## Innehåll
- `Labb_2.sql`: SQL-skript för att skapa databasen
- `sql_connection.ipynb`: Jupyter Notebook med Python-kod för att ansluta till och söka i databasen
- `README.md`: Denna fil med projektinformation

## Databasstruktur
Databasen "Bokhandel" består av följande tabeller:
- Böcker: Information om böcker (ISBN13, titel, etc.)
- Författare: Information om författare
- Butiker: Information om bokhandelsbutiker
- LagerSaldo: Lagersaldo för böcker i olika butiker
- Kunder: Kunduppgifter
- Ordrar: Orderinformation
- Orderrader: Detaljer för varje orderrad

## Funktionalitet
### SQL-funktioner
- Vyer för att visa statistik (TitlarPerFörfattare, KundSammanstallning, ButikFörsäljning)
- Lagrade procedurer för att flytta böcker mellan butiker (FlyttaBok)
- Relationer mellan tabeller för att hantera många-till-många-förhållanden

### Python-funktionalitet
- Anslutning till databasen med SQLAlchemy
- Fritextsökning på boktitlar
- Visning av lagersaldo per butik
- Skydd mot SQL-injection genom parametriserade frågor

## Användning
### SQL-skript
1. Öppna SQL Server Management Studio
2. Kör skriptet `Labb_2.sql` för att skapa och fylla i databasen

### Python-skript
1. Öppna Jupyter Notebook
2. Kör `sql_connection.ipynb`
3. Använd funktionerna för att söka efter böcker och visa lagersaldo

## Säkerhet
- Använder parametriserade frågor för att förhindra SQL-injection
- Begränsade rättigheter för databasanvändaren
- Korrekt felhantering för att undvika att känslig information läcker

## Backup
För att skapa en backup av databasen, använd följande SQL-kommando:
```sql
BACKUP DATABASE Bokhandel
TO DISK = N'Valfri sökväg'
WITH FORMAT,
    NAME = 'Bokhandel-Fullständig Databas Backup',
    DESCRIPTION = 'Fullständig backup av Bokhandel-databasen';
```

## Utvecklare
Martin Gustafsson
