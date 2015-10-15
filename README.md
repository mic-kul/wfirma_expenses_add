## WFirma Expensess ADD
To prosty skrypt, logujący się na konto WFirma i dodający fakturę wydatkową.
Powstał z powodu braku obsługi wydatków w oficjalnym API.

Konstruktor głownej metody przyjmuje następujące argumenty:

* login
* hasło
* nip
* numer faktury
* kwota brutto
* data - wszystkie daty w polach w panelu WFirma wypełniane są identycznie (skrypt został stworzony głównie do księgowania faktur z OVH)


Przykład użycia:

```
Wfirma::Expenses::Add.new('login@mail.com', 'haslo123.321', '9998880011', 'FV1/2015', '123.00', '2015-10-10').run!
```