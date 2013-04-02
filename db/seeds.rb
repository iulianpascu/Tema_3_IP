# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

IncognitoUser.create(token: "1234",grupa_nume: 344)
IncognitoUser.create(token: "12345",grupa_nume: 341)
IncognitoUser.create(token: "123456",grupa_nume: 342)
IncognitoUser.create(token: "123457",grupa_nume: 344)
IncognitoUser.create(token: "123458",grupa_nume: 344)
IncognitoUser.create(token: "123459",grupa_nume: 344)
IncognitoUser.create(token: "123460",grupa_nume: 344)
IncognitoUser.create(token: "123461",grupa_nume: 344)
IncognitoUser.create(token: "123462",grupa_nume: 344)
IncognitoUser.create(token: "123463",grupa_nume: 344)
IncognitoUser.create(token: "123464",grupa_nume: 344)
IncognitoUser.create(token: "123465",grupa_nume: 344)
IncognitoUser.create(token: "123467",grupa_nume: 344)
IncognitoUser.create(token: "123468",grupa_nume: 344)
IncognitoUser.create(token: "123469",grupa_nume: 344)
IncognitoUser.create(token: "123470",grupa_nume: 344)

Grupa.create(nume: 344, studenti:30)
Grupa.create(nume: 341, studenti:20)
Grupa.create(nume: 342, studenti:22)

EvaluareDisponibila.create(curs_id: 4, grupa_nume: 344)
EvaluareDisponibila.create(curs_id: 2, grupa_nume: 344)
EvaluareDisponibila.create(curs_id: 1, grupa_nume: 344)
EvaluareDisponibila.create(curs_id: 3, grupa_nume: 344)
EvaluareDisponibila.create(curs_id: 5, grupa_nume: 344)
EvaluareDisponibila.create(curs_id: 6, grupa_nume: 344)
EvaluareDisponibila.create(curs_id: 7, grupa_nume: 344)
EvaluareDisponibila.create(curs_id: 8, grupa_nume: 344)

Curs.create(nume: "POO", tip: "curs", profesor_id: 1)
Curs.create(nume: "Programare declarativa", tip: "curs", profesor_id: 2)
Curs.create(nume: "Programare logica", tip: "curs", profesor_id: 2)
Curs.create(nume: "Programare declarativa", tip: "lab", profesor_id: 3)
Curs.create(nume: "POO", tip: "curs", profesor_id: 1)
Curs.create(nume: "Programare declarativa", tip: "curs", profesor_id: 2)
Curs.create(nume: "Tehnici de compilare", tip: "curs", profesor_id: 4)
Curs.create(nume: "Programare declarativa", tip: "lab", profesor_id: 3)

Profesor.create(nume: "Paun", prenume: "Vasile")
Profesor.create(nume: "Cazanescu", prenume: "Emil")
Profesor.create(nume: "Diaconescu", prenume: "Denisa")
