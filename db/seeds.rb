# encoding: utf-8
# Autogenerated by the db:seed:dump task
# Do not hesitate to tweak this to your needs

Curs.create([
  { :nume => "Calcul Numeric", :tip => "curs", :profesor_id => 6, :an_universitar => 2012, :formular_id => 1, :grupa_id => 1202, :semestru => 2 },
  { :nume => "Tehnici de Optimizare", :tip => "curs", :profesor_id => 5, :an_universitar => 2012, :formular_id => 1, :grupa_id => 1199, :semestru => nil },
  { :nume => "Tehnici de Optimizare", :tip => "curs", :profesor_id => 4, :an_universitar => 2012, :formular_id => 1, :grupa_id => 1199, :semestru => nil },
  { :nume => "Criptografie si Securitate", :tip => "curs", :profesor_id => 3, :an_universitar => 2012, :formular_id => 1, :grupa_id => 1202, :semestru => nil },
  { :nume => "Tehnici de Compilare", :tip => "curs", :profesor_id => 2, :an_universitar => 2012, :formular_id => 1, :grupa_id => nil, :semestru => nil },
  { :nume => "Ingineria Programarii", :tip => "curs", :profesor_id => 1, :an_universitar => 2012, :formular_id => 1, :grupa_id => nil, :semestru => nil }
], :without_protection => true )



DataEvaluare.create([
  { :grupa_terminal => false, :data => "2013-05-01" },
  { :grupa_terminal => true, :data => "2013-05-01" }
], :without_protection => true )



EvalCompletata.create([
  { :curs_id => 1583, :incognito_user_token => "ZAYROmu2+jnl75FtlIvQ3A==", :timp => 105, :continut => {"1"=>"1", "3"=>"3", "4"=>"3", "6"=>"5", "7"=>"3", "8"=>"2", "9"=>"4", "10"=>"3", "11"=>"3", "13"=>"5", "14"=>"5", "15"=>"5", "16"=>"5", "17"=>"4", "18"=>"5", "19"=>"5", "20"=>"4", "21"=>"5", "22"=>"4", "23"=>"mai nimic", "24"=>"mai multe exemple", "25"=>"", "26"=>"Da"}, :data => nil },
  { :curs_id => 1556, :incognito_user_token => "7gKraF5OK/c8BfOWR7TxGQ==", :timp => nil, :continut => {}, :data => nil },
  { :curs_id => 1591, :incognito_user_token => "ZAYROmu2+jnl75FtlIvQ3A==", :timp => 1, :continut => {"1"=>"0", "3"=>"0", "4"=>"0", "6"=>"0", "7"=>"0", "8"=>"0", "9"=>"0", "10"=>"0", "11"=>"0", "13"=>"0", "14"=>"0", "15"=>"0", "16"=>"0", "17"=>"0", "18"=>"0", "19"=>"0", "20"=>"0", "21"=>"0", "22"=>"0", "23"=>"", "24"=>"", "25"=>"", "26"=>""}, :data => nil },
  { :curs_id => 6, :incognito_user_token => nil, :timp => nil, :continut => {}, :data => nil },
  { :curs_id => 6, :incognito_user_token => "TUNsSwpIu8JuNcYHRVbp0w==", :timp => 4, :continut => {"1"=>"0", "3"=>"3", "4"=>"4", "6"=>"0", "7"=>"0", "8"=>"0", "9"=>"0", "10"=>"0", "11"=>"0", "13"=>"0", "14"=>"0", "15"=>"0", "16"=>"0", "17"=>"0", "18"=>"0", "19"=>"0", "20"=>"0", "21"=>"0", "22"=>"0", "23"=>"", "24"=>"", "25"=>"", "26"=>""}, :data => nil },
  { :curs_id => 4, :incognito_user_token => "zRFwKL8ZTQf7Sxz91tIorQ==", :timp => 57, :continut => {"1"=>"0", "3"=>"3", "4"=>"4", "6"=>"0", "7"=>"0", "8"=>"0", "9"=>"0", "10"=>"0", "11"=>"0", "13"=>"0", "14"=>"0", "15"=>"0", "16"=>"0", "17"=>"0", "18"=>"0", "19"=>"0", "20"=>"0", "21"=>"0", "22"=>"0", "23"=>"", "24"=>"", "25"=>"", "26"=>""}, :data => nil },
  { :curs_id => 5, :incognito_user_token => "zRFwKL8ZTQf7Sxz91tIorQ==", :timp => 4, :continut => {"1"=>"0", "3"=>"0", "4"=>"3", "6"=>"0", "7"=>"0", "8"=>"0", "9"=>"0", "10"=>"0", "11"=>"0", "13"=>"0", "14"=>"3", "15"=>"0", "16"=>"0", "17"=>"0", "18"=>"0", "19"=>"0", "20"=>"0", "21"=>"0", "22"=>"0", "23"=>"", "24"=>"", "25"=>"", "26"=>""}, :data => nil }
], :without_protection => true )



Formular.create([
  { :continut => "{\"chestionar\":[{\"intrebare\":[{\"enunt\":\"1. Prezenta mea la curs se incadreaza in intervalul:\"},{\"rasp\":\"0-25%\"},{\"rasp\":\"25-50%\"},{\"rasp\":\"50-75%\"},{\"rasp\":\"75-100%\"}]},{\"label\":\"2. Cum apreciati materia cursului:\"},{\"intrebare\":[{\"enunt\":\"2.1 Nivelul de dificultate al materiei a fost\"},{\"rasp\":\"Prea scazut(a)\"},{\"rasp\":\"Scazut(a)\"},{\"rasp\":\"Bun(a)\"},{\"rasp\":\"Ridicat(a)\"},{\"rasp\":\"Prea ridicat(a)\"}]},{\"intrebare\":[{\"enunt\":\"2.2 Densitatea materiei a fost\"},{\"rasp\":\"Prea scazut(a)\"},{\"rasp\":\"Scazut(a)\"},{\"rasp\":\"Bun(a)\"},{\"rasp\":\"Ridicat(a)\"},{\"rasp\":\"Prea ridicat(a)\"}]},{\"label\":\"3. In ce masura sunteti de acord sau nu, cu urmatoarele aprecieri asupra cursului:\"},{\"intrebare\":[{\"enunt\":\"3.1 La inceputul semestrului, am fost informat asupra obiectivelor si cerintelor (prezenta, note)\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"intrebare\":[{\"enunt\":\"3.2 Cursul a fost bine structurat\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"intrebare\":[{\"enunt\":\"3.3 Gradul de dificultate a fost adecvat cu pregatirea mea anterioara\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"intrebare\":[{\"enunt\":\"3.4 Cunostiintele dobandite au fost in concordanta cu obiectivele anuntate la inceputul cursului\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"intrebare\":[{\"enunt\":\"3.5 Bibliografia recomandata a fost disponibila\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"intrebare\":[{\"enunt\":\"3.6 Bibliografia recomandata a fost utila\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"label\":\"4. In ce masura sunteti de acord sau nu, cu urmatoarele aprecieri asupra modului de predare al profesorului:\"},{\"intrebare\":[{\"enunt\":\"4.1 A respectat materia din programa\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"intrebare\":[{\"enunt\":\"4.2 Expunerea sa a fost riguroasa si inteligibila\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"intrebare\":[{\"enunt\":\"4.3 A fost explicata utilitatea / importanta cursului in pregatirea profesionala\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"intrebare\":[{\"enunt\":\"4.4 Mi-a dat impresia ca stapaneste materia predata\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"intrebare\":[{\"enunt\":\"4.5 A transmis cunostiintele intr-o maniera pe care am inteles-o, inclusiv notiunile pe care le-am considerat dificile\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"intrebare\":[{\"enunt\":\"4.6 Consider ca ritmul predarii a fost satisfacator\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"intrebare\":[{\"enunt\":\"4.7 S-a exprimat coerent si clar\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"intrebare\":[{\"enunt\":\"4.8 A prezentat materia intr-o maniera interesanta\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"intrebare\":[{\"enunt\":\"4.9 A fost punctual si a utilizat corespunzator timpul programat activitatii didactice\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"intrebare\":[{\"enunt\":\"4.10 A fost usor abordabil, disponibil si a tratat studentii cu respect\"},{\"rasp\":\"Dezacord total\"},{\"rasp\":\"Dezacord partial\"},{\"rasp\":\"Neutru\"},{\"rasp\":\"Acord partial\"},{\"rasp\":\"Acord total\"}]},{\"intrebare\":[{\"enunt\":\"5. Ce mi-a placut:\"}]},{\"intrebare\":[{\"enunt\":\"6. Cum consider ca va putea fi imbunatatit:\"}]},{\"intrebare\":[{\"enunt\":\"7. Alte comentarii:\"}]},{\"intrebare\":[{\"enunt\":\"8. Consider ca forma si continutul acestui formular sunt corespunzatoare cursului evaluat (DA/NU):\"}]}]}" }
], :without_protection => true )



Grupa.create([
  { :nume => 344, :studenti => 2, :terminal => true, :an => 3, :serie => 34, :specializare => "info" },
  { :nume => 201, :studenti => 23, :terminal => false, :an => 2, :serie => 20, :specializare => "mate" },
  { :nume => 342, :studenti => 1, :terminal => true, :an => 3, :serie => 34, :specializare => "info" },
  { :nume => 331, :studenti => 0, :terminal => true, :an => 3, :serie => 33, :specializare => "info" },
  { :nume => 341, :studenti => 1, :terminal => true, :an => 3, :serie => 34, :specializare => "info" },
  { :nume => 343, :studenti => 1, :terminal => true, :an => 3, :serie => 34, :specializare => "info" },
  { :nume => 333, :studenti => 1, :terminal => true, :an => 3, :serie => 33, :specializare => "info" },
  { :nume => 334, :studenti => 5, :terminal => true, :an => 3, :serie => 33, :specializare => "info" }
], :without_protection => true )



IncognitoUser.create([
  { :token => "7gKraF5OK/c8BfOWR7TxGQ==", :grupa_nume => 344 },
  { :token => "TUNsSwpIu8JuNcYHRVbp0w==", :grupa_nume => 344 },
  { :token => "ZAYROmu2+jnl75FtlIvQ3A==", :grupa_nume => 342 },
  { :token => "RZGWJdw04TkQiJkOyr2Wpg==", :grupa_nume => 341 },
  { :token => "zRFwKL8ZTQf7Sxz91tIorQ==", :grupa_nume => 343 },
  { :token => "Tt3XWa3zqsckyW5LBtFeEA==", :grupa_nume => 333 },
  { :token => "eS+PhwXvvksvyt3c0zP26w==", :grupa_nume => 334 },
  { :token => "Du6VLyRuHBimi70bwiaI6w==", :grupa_nume => 334 },
  { :token => "I9ic9xVy8aDAJkvVnWj1WA==", :grupa_nume => 334 },
  { :token => "hoUBulx63c7rjlIbZkgxaw==", :grupa_nume => 334 },
  { :token => "3JRCnfavHBifxuWd0xgBsw==", :grupa_nume => 334 }
], :without_protection => true )



Profesor.create([
  { :nume => "Gramatovici", :prenume => "Radu", :departament => "Informatica" },
  { :nume => "Georgescu", :prenume => "Geanina", :departament => "Informatica" },
  { :nume => "Atanasiu", :prenume => "Adrian", :departament => "Informatica" },
  { :nume => "Batatorescu", :prenume => "Anton", :departament => "Informatica" },
  { :nume => "Patriche", :prenume => "Monica", :departament => "Informatica" },
  { :nume => "Stanica", :prenume => "Daniel", :departament => "Matematica" }
], :without_protection => true )



SesiuneActiva.create([
  { :incognito_user_token => "TUNsSwpIu8JuNcYHRVbp0w==", :incepere_data => "2013-05-03 20:25:31" }
], :without_protection => true )


