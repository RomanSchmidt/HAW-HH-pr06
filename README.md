# Ruby PR06

```
PR06 HAWariten
Author: Roman Schmidt, Daniel Osterholz
```

Wir haben in dieser Version 06 die Version 05.2 übernommen und die bei der letzten Abnahme erwähnten Fehler korrigiert.
Damit haben wir auch die 1 zu 1* Beziehung korrigiert. Dadurch sind jedoch viele Probleme aufgetaucht.

Wir können keine Ranges bauen, da sonst die succ Methode nicht in der Lage ist von sich selbst ein Objekt zu erstellen,
dass das gleiche Subattribut hat, jedoch sich selbst verändert.

Anhand des Beispiels der Adresse ist zu zeigen, dass eine Adresse ohne Partner nicht existieren kann. Um einen
angrenzenden Partner mit der gleichen Adresse erstellen zu können, muss der Partner jedoch eine Adresse bekommen um
existieren zu können. Dadurch verändert sich jedoch nicht nur der Partner allein, sonder entweder hat er eine andere
Adresse, oder die bestehende Adresse hat ein weiteres Attribut, wodurch sich das angrenzende Objekt in mehr als nur
einem Punkt unterscheidet und eine Range nicht möglich ist.

Ähnlich verhält es sich bei der Variante, dass eine neue Adresse erstellt wird mit dem gleichen Kunden. Dadurch muss
der Kunde umziehen. Wenn er aber der letzte bei der Adresse vorher war, wird die 1 zu 1* Beziehung zerstört.

Diese Problematik zieht sich durch mehrere Aufgabenstellungen. Vor allem durch Range – Implementierungen.

Wir haben mehrere Stellen im Code auskommentiert. Die Tests mit Ranges und das Entfernen des letzten Kunden aus dem
registered_partners Set um wenigstens einige Tests zu zeigen, dass sie den Anforderungen entsprechen.