// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.
String csv_list_of_countries = '''
alpha-2,alpha-3,num-3,name,currency,language,predial,timezone,de,es
AD,AND,20,Andorra,EUR,en,376,1,Andorra,Andorra
AE,ARE,784,United Arab Emirates,AED,ar,971,4,Vereinigte Arabische Emirate,Emiratos Árabes Unidos
AF,AFG,4,Afghanistan,AFN,fa,93,4.5,Afghanistan,Afganistán
AG,ATG,28,Antigua and Barbuda,XCD,en,1268,-4,Antigua und Barbuda,Antigua y Barbuda
AI,AIA,660,Anguilla,XCD,en,1264,-4,,
AL,ALB,8,Albania,ALL,en,355,1,Albanien,Albania
AM,ARM,51,Armenia,AMD,hy,374,4,Armenien,Armenia
AO,AGO,24,Angola,AOA,pt,244,1,Angola,Angola
AQ,ATA,10,Antarctica,,,,,,
AR,ARG,32,Argentina,ARS,es,54,-3,Argentinien,Argentina
AS,ASM,16,American Samoa,USD,en,1684,-11,,
AT,AUT,40,Austria,EUR,de,43,1,Österreich,Austria
AU,AUS,36,Australia,AUD,en,61,9,Australien,Australia
AW,ABW,533,Aruba,AWG,es,297,-4,,
AX,ALA,248,Åland Islands,EUR,sv,35818,2,,
AZ,AZE,31,Azerbaijan,AZN,az,994,4,Aserbaidschan,Azerbaiyán
BA,BIH,70,Bosnia and Herzegovina,MA,hr,387,1,Bosnien und Herzegowina,Bosnia y Herzegovina
BB,BRB,52,Barbados,BBD,en,1246,-4,Barbados,Barbados
BD,BGD,50,Bangladesh,BDT,en,880,6,Bangladesch,Bangladés
BE,BEL,56,Belgium,EUR,nl,32,1,Belgien,Bélgica
BF,BFA,854,Burkina Faso,XOF,fr,226,0,Burkina Faso,Burkina Faso
BG,BGR,100,Bulgaria,BGN,bg,359,2,Bulgarien,Bulgaria
BH,BHR,48,Bahrain,BHD,ar,973,3,Bahrain,Baréin
BI,BDI,108,Burundi,BIF,fr,257,2,Burundi,Burundi
BJ,BEN,204,Benin,XOF,fr,229,1,Benin,Benín
BL,BLM,652,Saint Barthélemy,EUR,fr,590,-4,,
BM,BMU,60,Bermuda,BMD,en,1441,-4,,
BN,BRN,96,Brunei Darussalam,BND,ms,673,8,Brunei,Brunéi
BO,BOL,68,Bolivia,BOB,es,591,-4,Bolivien,Bolivia
BQ,BES,535,Bonaire,USD,,5997,-4,,
BR,BRA,76,Brazil,BRL,pt,55,-4,Brasilien,Brasil
BS,BHS,44,Bahamas,BSD,es,1242,-5,Bahamas,Bahamas
BT,BTN,64,Bhutan,BTN,dz,975,6,Bhutan,Bután
BV,BVT,74,Bouvet Island,NOP,,,,,
BW,BWA,72,Botswana,BWP,en,267,2,Botswana,Botsuana
BY,BLR,112,Belarus,BYN,ru,375,3,Belarus,Bielorrusia
BZ,BLZ,84,Belize,BZD,en,501,-6,Belize,Belice
CA,CAN,124,Canada,CAD,en,1,-5,Kanada,Canadá
CC,CCK,166,Cocos (Keeling) Islands,AUD,en,6189162,6.5,,
CD,COD,180,Democratic Republic Congo,CDF,fr,243,1,Demokratische Republik Kongo,República Democrática del Congo
CF,CAF,140,Central African Republic,XAF,fr,236,1,Zentral­afrikanische Republik,República Centroafricana
CG,COG,178,Congo,XAF,fr,242,1,Kongo,República del Congo
CH,CHE,756,Switzerland,CHF,de,41,1,Schweiz,Suiza
CI,CIV,384,Côte d'Ivoire,XOF,fr,225,0,Elfenbeinküste,Costa de Marfil
CK,COK,184,Cook Islands,NZD,en,682,-10,,
CL,CHL,152,Chile,CLP,es,56,-5,Chile,Chile
CM,CMR,120,Cameroon,XAF,en,237,1,Kamerun,Camerún
CN,CHN,156,China,CNY,zh,86,8,China,China
CO,COL,170,Colombia,COP,es,57,-5,Kolumbien,Colombia
CR,CRI,188,Costa Rica,CRC,es,506,-6,Costa Rica,Costa Rica
CU,CUB,192,Cuba,CUP,es,53,-5,Kuba,Cuba
CV,CPV,132,Cabo Verde,CVE,,238,-1,Kap Verde,Cabo Verde
CW,CUW,531,Curaçao,ANG,nl,5999,-4,,
CX,CXR,162,Christmas Island,AUD,en,6189164,7,,
CY,CYP,196,Cyprus,EUR,en,357,2,Zypern,Chipre
CZ,CZE,203,Czechia,CZK,cs,420,1,Tschechien,República Checa
DE,DEU,276,Germany,EUR,de,49,1,Deutschland,Alemania
DJ,DJI,262,Djibouti,DJF,fr,253,2,Dschibuti,Yibuti
DK,DNK,208,Denmark,DKK,da,45,1,Dänemark,Dinamarca
DM,DMA,212,Dominica,XCD,es,1767,-4,Dominica,Dominica
DO,DOM,214,Dominican Republic,DOP,es,1809,-4,Dominikanische Republik,República Dominicana
DZ,DZA,12,Algeria,DZD,fr,213,1,Algerien,Argelia
EC,ECU,218,Ecuador,USD,es,593,-6,Ecuador,Ecuador
EE,EST,233,Estonia,EUR,en,372,2,Estland,Estonia
EG,EGY,818,Egypt,EGP,ar,20,2,Ägypten,Egipto
EH,ESH,732,Western Sahara,MAD,ar,,,,
ER,ERI,232,Eritrea,ERN,en,291,3,Eritrea,Eritrea
ES,ESP,724,Spain,EUR,es,34,1,Spanien,España
ET,ETH,231,Ethiopia,ETB,so,251,3,Äthiopien,Etiopía
FI,FIN,246,Finland,EUR,en,358,2,Finnland,Finlandia
FJ,FJI,242,Fiji,FJD,en,679,12,Fidschi,Fiyi
FK,FLK,238,Falkland Islands (Malvinas),FKP,en,500,-3,,
FM,FSM,583,Micronesia (Federated States of),USD,en,691,10,Mikronesien,Micronesia
FO,FRO,234,Faroe Islands,DKK,fo,298,1,,
FR,FRA,250,France,EUR,fr,33,1,Frankreich,Francia
GA,GAB,266,Gabon,XAF,fr,241,1,Gabun,Gabón
GB,GBR,826,United Kingdom,GBP,en,44,0,England,Reino Unido
GD,GRD,308,Grenada,XCD,en,1473,-4,Grenada,Granada
GE,GEO,268,Georgia,GEL,ka,995,4,Georgien,Georgia
GF,GUF,254,French Guiana,EUR,fr,594,-3,,
GG,GGY,831,Guernsey,GBP,en,44,1,,
GH,GHA,288,Ghana,GHS,en,233,0,Ghana,Ghana
GI,GIB,292,Gibraltar,GIP,en,350,1,,
GL,GRL,304,Greenland,DKK,da,299,-2,,
GM,GMB,270,Gambia,GMD,en,220,0,Gambia,Gambia
GN,GIN,324,Guinea,GNF,pt,224,0,Guinea,Guinea
GP,GLP,312,Guadeloupe,EUR,es,590,-4,,
GQ,GNQ,226,Equatorial Guinea,XAF,fr,240,1,Äquatorialguinea,Guinea Ecuatorial
GR,GRC,300,Greece,EUR,gr,30,2,Griechenland,Grecia
GS,SGS,239,South Georgia and Sandwich Islands,,,500,-2,,
GT,GTM,320,Guatemala,GTQ,es,502,-6,Guatemala,Guatemala
GU,GUM,316,Guam,USD,en,1671,10,,
GW,GNB,624,Guinea-Bissau,XOF,pt,245,0,Guinea-Bissau,Guinea-Bisáu
GY,GUY,328,Guyana,GYD,en,592,-4,Guyana,Guyana
HK,HKG,344,Hong Kong,HKD,zh,852,8,,
HM,HMD,334,Heard and McDonald Islands,AUD,,,,,
HN,HND,340,Honduras,HNL,es,504,-6,Honduras,Honduras
HR,HRV,191,Croatia,HRK,hr,385,1,Kroatien,Croacia
HT,HTI,332,Haiti,HTG,es,509,-5,Haiti,Haití
HU,HUN,348,Hungary,HUF,en,36,1,Ungarn,Hungría
ID,IDN,360,Indonesia,IDR,en,62,8,Indonesien,Indonesia
IE,IRL,372,Ireland,EUR,en,353,0,Irland,Irlanda
IL,ISR,376,Israel,ILS,en,972,2,Israel,Israel
IM,IMN,833,Isle of Man,GBP,en,44,0,,
IN,IND,356,India,INR,en,91,5.5,Indien,India
IO,IOT,86,British Indian Ocean Territory,USD,en,246,6,,
IQ,IRQ,368,Iraq,IQD,ar,964,3,Irak,Irak
IR,IRN,364,Iran,IRR,ar,98,3.5,Iran,Irán
IS,ISL,352,Iceland,ISK,en,354,0,Island,Islandia
IT,ITA,380,Italy,EUR,it,39,1,Italien,Italia
JE,JEY,832,Jersey,GBP,en,441534,0,,
JM,JAM,388,Jamaica,JMD,en,1876,-5,Jamaika,Jamaica
JO,JOR,400,Jordan,JOD,ar,962,2,Jordanien,Jordania
JP,JPN,392,Japan,JPY,ja,81,9,Japan,Japón
KE,KEN,404,Kenya,KES,en,254,3,Kenia,Kenia
KG,KGZ,417,Kyrgyzstan,KGS,ru,996,5,Kirgisistan,Kirguistán
KH,KHM,116,Cambodia,KHR,km,855,7,Kambodscha,Camboya
KI,KIR,296,Kiribati,AUD,en,686,13,Kiribati,Kiribati
KM,COM,174,Comoros,KMF,fr,269,3,Komoren,Comoras
KN,KNA,659,Saint Kitts and Nevis,XCD,ees,1869,-4,St. Kitts und Nevis,San Cristóbal y Nieves
KP,PRK,408,North Korea,KPW,,850,8.5,Nord-Korea,Corea del Norte
KR,KOR,410,South Korea,KRW,,82,9,Süd-Korea,Corea del Sur
KW,KWT,414,Kuwait,KWD,ar,965,3,Kuwait,Kuwait
KY,CYM,136,Cayman Islands,KYD,en,1345,-5,,
KZ,KAZ,398,Kazakhstan,KZT,ru,76,5,Kasachstan,Kazajistán
LA,LAO,418,Laos,LAK,lo,856,7,Laos,Laos
LB,LBN,422,Lebanon,LBP,ar,961,2,Libanon,Líbano
LC,LCA,662,Saint Lucia,XCD,es,1758,-4,St. Lucia,Santa Lucía
LI,LIE,438,Liechtenstein,CHF,de,423,1,Liechtenstein,Liechtenstein
LK,LKA,144,Sri Lanka,LKR,ta,94,5.5,Sri Lanka,Sri Lanka
LR,LBR,430,Liberia,LRD,en,231,0,Liberia,Liberia
LS,LSO,426,Lesotho,LSL,en,266,2,Lesotho,Lesoto
LT,LTU,440,Lithuania,EUR,en,370,2,Litauen,Lituania
LU,LUX,442,Luxembourg,EUR,de,352,1,Luxemburg,Luxemburgo
LV,LVA,428,Latvia,EUR,lv,371,2,Lettland,Letonia
LY,LBY,434,Libya,LYD,ar,218,1,Libyen,Libia
MA,MAR,504,Morocco,MAD,fr,212,0,Marokko,Marruecos
MC,MCO,492,Monaco,EUR,fr,377,1,Monaco,Mónaco
MD,MDA,498,Moldova,MDL,ru,373,2,Moldau,Moldavia
ME,MNE,499,Montenegro,EUR,en,382,1,Montenegro,Montenegro
MF,MAF,663,Saint Martin (French part),EUR,fr,590,-4,,
MG,MDG,450,Madagascar,MGA,en,261,3,Madagaskar,Madagascar
MH,MHL,584,Marshall Islands,USD,en,692,12,Marshallinseln,Islas Marshall
MK,MKD,807,North Macedonia,MKD,sq,,,Nordmazedonien,Macedonia del Norte
ML,MLI,466,Mali,XOF,fr,223,0,Mali,Malí
MM,MMR,104,Myanmar,MMK,en,95,6.5,Myanmar,Birmania
MN,MNG,496,Mongolia,MNT,mn,976,7,Mongolei,Mongolia
MO,MAC,446,Macao,MOP,zh,853,8,,
MP,MNP,580,Northern Mariana Islands,NOK,en,1670,10,,
MQ,MTQ,474,Martinique,EUR,fr,596,-4,,
MR,MRT,478,Mauritania,MRU,fr,222,0,Mauretanien,Mauritania
MS,MSR,500,Montserrat,XCD,en,1664,-4,,
MT,MLT,470,Malta,EUR,en,356,1,Malta,Malta
MU,MUS,480,Mauritius,MUR,en,230,4,Mauritius,Mauricio
MV,MDV,462,Maldives,MVR,en,960,5,Malediven,Maldivas
MW,MWI,454,Malawi,MWK,en,265,2,Malawi,Malaui
MX,MEX,484,Mexico,MXN,es,52,-7,Mexiko,México
MY,MYS,458,Malaysia,MYR,en,60,8,Malaysia,Malasia
MZ,MOZ,508,Mozambique,MZN,pt,258,2,Mosambik,Mozambique
NA,NAM,516,Namibia,NAD,en,264,1,Namibia,Namibia
NC,NCL,540,New Caledonia,XPF,fr,687,11,,
NE,NER,562,Niger,XOF,fr,227,1,Niger,Níger
NF,NFK,574,Norfolk Island,AUD,en,6723,11,,
NG,NGA,566,Nigeria,NGN,en,234,1,Nigeria,Nigeria
NI,NIC,558,Nicaragua,NIO,es,505,-6,Nicaragua,Nicaragua
NL,NLD,528,Netherlands,EUR,nl,31,1,Niederlande,Países Bajos
NO,NOR,578,Norway,OMR,se,47,2,Norwegen,Noruega
NP,NPL,524,Nepal,NPR,ne,977,5.75,Nepal,Nepal
NR,NRU,520,Nauru,AUD,en,674,12,Nauru,Nauru
NU,NIU,570,Niue,NZD,en,683,-11,,
NZ,NZL,554,New Zealand,NZD,en,64,12,Neuseeland,Nueva Zelanda
OM,OMN,512,Oman,PKR,ar,968,4,Oman,Omán
PA,PAN,591,Panama,USD,es,507,-5,Panama,Panamá
PE,PER,604,Peru,PEN,es,51,-5,Peru,Perú
PF,PYF,258,French Polynesia,XPF,fr,689,-10,,
PG,PNG,598,Papua New Guinea,PGK,en,675,10,Papua-Neuguinea,Papúa Nueva Guinea
PH,PHL,608,Philippines,PHP,es,63,8,Philippinen,Filipinas
PK,PAK,586,Pakistan,USD,en,92,5,Pakistan,Pakistán
PL,POL,616,Poland,PLN,pl,48,1,Polen,Polonia
PM,SPM,666,Saint Pierre and Miquelon,EUR,fr,508,-3,,
PN,PCN,612,Pitcairn,NZD,en,64,-8,,
PR,PRI,630,Puerto Rico,USD,es,1787,-4,,
PS,PSE,275,Palestine,PAB,ar,970,2,Palästina,
PT,PRT,620,Portugal,EUR,pt,351,0,Portugal,Portugal
PW,PLW,585,Palau,,en,680,9,Palau,Palaos
PY,PRY,600,Paraguay,PYG,es,595,-4,Paraguay,Paraguay
QA,QAT,634,Qatar,QAR,ar,974,3,Katar,Catar
RE,REU,638,Réunion,EUR,fr,262,4,,
RO,ROU,642,Romania,RON,en,40,2,Rumänien,Rumania
RS,SRB,688,Serbia,RSD,sr,381,1,Serbien,Serbia
RU,RUS,643,Russian Federation,RUB,ru,7,7,Russland,Rusia
RW,RWA,646,Rwanda,RWF,en,250,2,Ruanda,Ruanda
SA,SAU,682,Saudi Arabia,SAR,ar,966,3,Saudi-Arabien,Arabia Saudita
SB,SLB,90,Solomon Islands,SBD,en,677,11,Salomonen,Islas Salomón
SC,SYC,690,Seychelles,SCR,fr,248,4,Seychellen,Seychelles
SD,SDN,729,Sudan,SDG,ar,249,3,Sudan,Sudán
SE,SWE,752,Sweden,SEK,sv,46,1,Schweden,Suecia
SG,SGP,702,Singapore,SGD,zh,65,8,Singapur,Singapur
SH,SHN,654,Saint Helena,SHP,en,290,0,St. Helena,
SI,SVN,705,Slovenia,EUR,sl,386,1,Slowenien,Eslovenia
SJ,SJM,744,Svalbard and Jan Mayen,NOK,nb,4779,1,,
SK,SVK,703,Slovakia,EUR,sk,421,1,Slowakei,Eslovaquia
SL,SLE,694,Sierra Leone,SLL,en,232,0,Sierra Leone,Sierra Leona
SM,SMR,674,San Marino,EUR,it,378,1,San Marino,San Marino
SN,SEN,686,Senegal,XOF,fr,221,0,Senegal,Senegal
SO,SOM,706,Somalia,SOS,ar,252,3,Somalia,Somalia
SR,SUR,740,Suriname,SRD,nl,597,-3,Suriname,Surinam
SS,SSD,728,South Sudan,SSP,ar,211,3,Südsudan,Sudán del Sur
ST,STP,678,Sao Tome and Principe,STN,pt,239,0,São Tomé und Príncipe,Santo Tomé y Príncipe
SV,SLV,222,El Salvador,SVC,es,503,-6,El Salvador,El Salvador
SX,SXM,534,Sint Maarten (Netherlands),ANG,nl,1721,-4,,
SY,SYR,760,Syrian,SYP,ar,963,2,Syrien,Siria
SZ,SWZ,748,Eswatini,SZL,en,,,Eswatini,Suazilandia
TC,TCA,796,Turks and Caicos Islands,USD,es,1649,-5,,
TD,TCD,148,Chad,XAF,fr,235,1,Tschad,Chad
TF,ATF,260,French Southern Territories,EUR,fr,,,,
TG,TGO,768,Togo,XOF,fr,228,0,Togo,Togo
TH,THA,764,Thailand,THB,th,66,7,Thailand,Tailandia
TJ,TJK,762,Tajikistan,TJS,tg,992,5,Tadschikistan,Tayikistán
TK,TKL,772,Tokelau,NZD,en,690,13,,
TL,TLS,626,Timor-Leste,USD,pt,,,Osttimor,Timor Oriental
TM,TKM,795,Turkmenistan,TMT,tk,993,5,Turkmenistan,Turkmenistán
TN,TUN,788,Tunisia,TND,fr,216,1,Tunesien,Túnez
TO,TON,776,Tonga,TOP,en,676,13,Tonga,Tonga
TR,TUR,792,Turkey,TRY,tr,90,3,Türkei,Turquía
TT,TTO,780,Trinidad and Tobago,TTD,es,1868,-4,Trinidad und Tobago,Trinidad y Tobago
TV,TUV,798,Tuvalu,AUD,en,688,12,Tuvalu,Tuvalu
TW,TWN,158,Taiwan,TWD,zh,886,8,Taiwan,
TZ,TZA,834,Tanzania,TZS,sw,255,3,Tansania,Tanzania
UA,UKR,804,Ukraine,UAH,ru,380,2,Ukraine,Ucrania
UG,UGA,800,Uganda,UGX,sw,256,3,Uganda,Uganda
US,USA,840,United States of America,USD,en,1,-7,U.S.A.,Estados Unidos
UY,URY,858,Uruguay,UYU,es,598,-3,Uruguay,Uruguay
UZ,UZB,860,Uzbekistan,UZS,uz,998,5,Usbekistan,Uzbekistán
VA,VAT,336,Holy See,EUR,,,,Vatikan,
VC,VCT,670,Saint Vincent and the Grenadines,XCD,es,1784,-4,St. Vincent und die Grenadinen,San Vicente y las Granadinas
VE,VEN,862,Venezuela,VES,es,58,-4,Venezuela,Venezuela
VG,VGB,92,Virgin Islands (British),USD,en,,,Jungferninseln (England),
VI,VIR,850,Virgin Islands (U.S.),USD,en,1340,-4,Jungferninseln (U.S.),
VN,VNM,704,Vietnam,VND,vi,84,7,Vietnam,Vietnam
VU,VUT,548,Vanuatu,VUV,fr,678,11,Vanuatu,Vanuatu
WF,WLF,876,Wallis and Futuna,XPF,fr,681,12,,
WS,WSM,882,Samoa,WST,en,685,13,Samoa,Samoa
YE,YEM,887,Yemen,YER,ar,967,3,Jemen,Yemen
YT,MYT,175,Mayotte,EUR,fr,262269,3,,
ZA,ZAF,710,South Africa,ZAR,af,27,2,Südafrika,Sudáfrica
ZM,ZMB,894,Zambia,ZMW,en,260,2,Sambia,Zambia
ZW,ZWE,716,Zimbabwe,ZWL,sn,263,2,Simbabwe,Zimbabue
''';
