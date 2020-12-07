// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.
/// Columns are: code2, code3, language, name, predial, codenum, timezone
String csv_list_of_countries = '''
AF,AFG,fa,Afghanistan,93,4,4.5
AX,ALA,sv,Åland Islands,35818,248,2
AL,ALB,en,Albania,355,8,1
DZ,DZA,fr,Algeria,213,12,1
AS,ASM,en,American Samoa,1684,16,-11
AD,AND,en,Andorra,376,20,1
AO,AGO,pt,Angola,244,24,1
AI,AIA,en,Anguilla,1264,660,-4
AQ,ATA,,Antarctica,,10,
AG,ATG,en,Antigua and Barbuda,1268,28,-4
AR,ARG,es,Argentina,54,32,-3
AM,ARM,hy,Armenia,374,51,4
AW,ABW,es,Aruba,297,533,-4
AU,AUS,en,Australia,61,36,9
AT,AUT,de,Austria,43,40,1
AZ,AZE,az,Azerbaijan,994,31,4
BS,BHS,es,Bahamas,1242,44,-5
BH,BHR,ar,Bahrain,973,48,3
BD,BGD,en,Bangladesh,880,50,6
BB,BRB,en,Barbados,1246,52,-4
BY,BLR,ru,Belarus,375,112,3
BE,BEL,nl,Belgium,32,56,1
BZ,BLZ,en,Belize,501,84,-6
BJ,BEN,fr,Benin,229,204,1
BM,BMU,en,Bermuda,1441,60,-4
BT,BTN,dz,Bhutan,975,64,6
BO,BOL,es,Bolivia,591,68,-4
BQ,BES,,"Bonaire, Sint Eustatius and Saba",5997,535,-4
BA,BIH,hr,Bosnia and Herzegovina,387,70,1
BW,BWA,en,Botswana,267,72,2
BV,BVT,,Bouvet Island,,74,
BR,BRA,pt,Brazil,55,76,-4
IO,IOT,en,British Indian Ocean Territory,246,86,6
BN,BRN,ms,Brunei Darussalam,673,96,8
BG,BGR,bg,Bulgaria,359,100,2
BF,BFA,fr,Burkina Faso,226,854,0
BI,BDI,fr,Burundi,257,108,2
CV,CPV,,Cabo Verde,238,132,-1
KH,KHM,km,Cambodia,855,116,7
CM,CMR,en,Cameroon,237,120,1
CA,CAN,en,Canada,1,124,-5
KY,CYM,en,Cayman Islands,1345,136,-5
CF,CAF,fr,Central African Republic,236,140,1
TD,TCD,fr,Chad,235,148,1
CL,CHL,es,Chile,56,152,-5
CN,CHN,zh,China,86,156,8
CX,CXR,en,Christmas Island,6189164,162,7
CC,CCK,en,Cocos (Keeling) Islands,6189162,166,6.5
CO,COL,es,Colombia,57,170,-5
KM,COM,fr,Comoros,269,174,3
CG,COG,fr,Congo,242,178,1
CD,COD,fr,"Congo, Democratic Republic of the",243,180,1
CK,COK,en,Cook Islands,682,184,-10
CR,CRI,es,Costa Rica,506,188,-6
CI,CIV,fr,Côte d'Ivoire,225,384,0
HR,HRV,hr,Croatia,385,191,1
CU,CUB,es,Cuba,53,192,-5
CW,CUW,nl,Curaçao,5999,531,-4
CY,CYP,en,Cyprus,357,196,2
CZ,CZE,cs,Czechia,420,203,1
DK,DNK,da,Denmark,45,208,1
DJ,DJI,fr,Djibouti,253,262,2
DM,DMA,es,Dominica,1767,212,-4
DO,DOM,es,Dominican Republic,1809,214,-4
EC,ECU,es,Ecuador,593,218,-6
EG,EGY,ar,Egypt,20,818,2
SV,SLV,es,El Salvador,503,222,-6
GQ,GNQ,fr,Equatorial Guinea,240,226,1
ER,ERI,en,Eritrea,291,232,3
EE,EST,en,Estonia,372,233,2
SZ,SWZ,en,Eswatini,,748,
ET,ETH,so,Ethiopia,251,231,3
FK,FLK,en,Falkland Islands (Malvinas),500,238,-3
FO,FRO,fo,Faroe Islands,298,234,1
FJ,FJI,en,Fiji,679,242,12
FI,FIN,en,Finland,358,246,2
FR,FRA,fr,France,33,250,1
GF,GUF,fr,French Guiana,594,254,-3
PF,PYF,fr,French Polynesia,689,258,-10
TF,ATF,fr,French Southern Territories,,260,
GA,GAB,fr,Gabon,241,266,1
GM,GMB,en,Gambia,220,270,0
GE,GEO,ka,Georgia,995,268,4
DE,DEU,de,Germany,49,276,1
GH,GHA,en,Ghana,233,288,0
GI,GIB,en,Gibraltar,350,292,1
GR,GRC,gr,Greece,30,300,2
GL,GRL,da,Greenland,299,304,-2
GD,GRD,en,Grenada,1473,308,-4
GP,GLP,es,Guadeloupe,590,312,-4
GU,GUM,en,Guam,1671,316,10
GT,GTM,es,Guatemala,502,320,-6
GG,GGY,en,Guernsey,44,831,1
GN,GIN,pt,Guinea,224,324,0
GW,GNB,pt,Guinea-Bissau,245,624,0
GY,GUY,en,Guyana,592,328,-4
HT,HTI,es,Haiti,509,332,-5
HM,HMD,,Heard Island and McDonald Islands,,334,
VA,VAT,,Holy See,,336,
HN,HND,es,Honduras,504,340,-6
HK,HKG,zh,Hong Kong,852,344,8
HU,HUN,en,Hungary,36,348,1
IS,ISL,en,Iceland,354,352,0
IN,IND,en,India,91,356,5.5
ID,IDN,en,Indonesia,62,360,8
IR,IRN,ar,Iran (Islamic Republic of),98,364,3.5
IQ,IRQ,ar,Iraq,964,368,3
IE,IRL,en,Ireland,353,372,0
IM,IMN,en,Isle of Man,44,833,0
IL,ISR,en,Israel,972,376,2
IT,ITA,it,Italy,39,380,1
JM,JAM,en,Jamaica,1876,388,-5
JP,JPN,ja,Japan,81,392,9
JE,JEY,en,Jersey,441534,832,0
JO,JOR,ar,Jordan,962,400,2
KZ,KAZ,ru,Kazakhstan,76,398,5
KE,KEN,en,Kenya,254,404,3
KI,KIR,en,Kiribati,686,296,13
KP,PRK,,"Korea, North",850,408,8.5
KR,KOR,,"Korea, Republic of",82,410,9
KW,KWT,ar,Kuwait,965,414,3
KG,KGZ,ru,Kyrgyzstan,996,417,5
LA,LAO,lo,Laos,856,418,7
LV,LVA,lv,Latvia,371,428,2
LB,LBN,ar,Lebanon,961,422,2
LS,LSO,en,Lesotho,266,426,2
LR,LBR,en,Liberia,231,430,0
LY,LBY,ar,Libya,218,434,1
LI,LIE,de,Liechtenstein,423,438,1
LT,LTU,en,Lithuania,370,440,2
LU,LUX,de,Luxembourg,352,442,1
MO,MAC,zh,Macao,853,446,8
MG,MDG,en,Madagascar,261,450,3
MW,MWI,en,Malawi,265,454,2
MY,MYS,en,Malaysia,60,458,8
MV,MDV,en,Maldives,960,462,5
ML,MLI,fr,Mali,223,466,0
MT,MLT,en,Malta,356,470,1
MH,MHL,en,Marshall Islands,692,584,12
MQ,MTQ,fr,Martinique,596,474,-4
MR,MRT,fr,Mauritania,222,478,0
MU,MUS,en,Mauritius,230,480,4
YT,MYT,fr,Mayotte,262269,175,3
MX,MEX,es,Mexico,52,484,-7
FM,FSM,en,Micronesia (Federated States of),691,583,10
MD,MDA,ru,"Moldova, Republic of",373,498,2
MC,MCO,fr,Monaco,377,492,1
MN,MNG,mn,Mongolia,976,496,7
ME,MNE,en,Montenegro,382,499,1
MS,MSR,en,Montserrat,1664,500,-4
MA,MAR,fr,Morocco,212,504,0
MZ,MOZ,pt,Mozambique,258,508,2
MM,MMR,en,Myanmar,95,104,6.5
NA,NAM,en,Namibia,264,516,1
NR,NRU,en,Nauru,674,520,12
NP,NPL,ne,Nepal,977,524,5.75
NL,NLD,nl,Netherlands,31,528,1
NC,NCL,fr,New Caledonia,687,540,11
NZ,NZL,en,New Zealand,64,554,12
NI,NIC,es,Nicaragua,505,558,-6
NE,NER,fr,Niger,227,562,1
NG,NGA,en,Nigeria,234,566,1
NU,NIU,en,Niue,683,570,-11
NF,NFK,en,Norfolk Island,6723,574,11
MK,MKD,sq,North Macedonia,,807,
MP,MNP,en,Northern Mariana Islands,1670,580,10
NO,NOR,se,Norway,47,578,2
OM,OMN,ar,Oman,968,512,4
PK,PAK,en,Pakistan,92,586,5
PW,PLW,en,Palau,680,585,9
PS,PSE,ar,"Palestine, State of",970,275,2
PA,PAN,es,Panama,507,591,-5
PG,PNG,en,Papua New Guinea,675,598,10
PY,PRY,es,Paraguay,595,600,-4
PE,PER,es,Peru,51,604,-5
PH,PHL,es,Philippines,63,608,8
PN,PCN,en,Pitcairn,64,612,-8
PL,POL,pl,Poland,48,616,1
PT,PRT,pt,Portugal,351,620,0
PR,PRI,es,Puerto Rico,1787,630,-4
QA,QAT,ar,Qatar,974,634,3
RE,REU,fr,Réunion,262,638,4
RO,ROU,en,Romania,40,642,2
RU,RUS,ru,Russian Federation,7,643,7
RW,RWA,en,Rwanda,250,646,2
BL,BLM,fr,Saint Barthélemy,590,652,-4
SH,SHN,en,"Saint Helena, Ascension and Tristan da Cunha",290,654,0
KN,KNA,ees,Saint Kitts and Nevis,1869,659,-4
LC,LCA,es,Saint Lucia,1758,662,-4
MF,MAF,fr,Saint Martin (French part),590,663,-4
PM,SPM,fr,Saint Pierre and Miquelon,508,666,-3
VC,VCT,es,Saint Vincent and the Grenadines,1784,670,-4
WS,WSM,en,Samoa,685,882,13
SM,SMR,it,San Marino,378,674,1
ST,STP,pt,Sao Tome and Principe,239,678,0
SA,SAU,ar,Saudi Arabia,966,682,3
SN,SEN,fr,Senegal,221,686,0
RS,SRB,sr,Serbia,381,688,1
SC,SYC,fr,Seychelles,248,690,4
SL,SLE,en,Sierra Leone,232,694,0
SG,SGP,zh,Singapore,65,702,8
SX,SXM,nl,Sint Maarten (Netherlands),1721,534,-4
SK,SVK,sk,Slovakia,421,703,1
SI,SVN,sl,Slovenia,386,705,1
SB,SLB,en,Solomon Islands,677,90,11
SO,SOM,ar,Somalia,252,706,3
ZA,ZAF,af,South Africa,27,710,2
GS,SGS,,South Georgia and the South Sandwich Islands,500,239,-2
SS,SSD,ar,South Sudan,211,728,3
ES,ESP,es,Spain,34,724,1
LK,LKA,ta,Sri Lanka,94,144,5.5
SD,SDN,ar,Sudan,249,729,3
SR,SUR,nl,Suriname,597,740,-3
SJ,SJM,nb,Svalbard and Jan Mayen,4779,744,1
SE,SWE,sv,Sweden,46,752,1
CH,CHE,de,Switzerland,41,756,1
SY,SYR,ar,Syrian Arab Republic,963,760,2
TW,TWN,zh,"Taiwan, Province of China",886,158,8
TJ,TJK,tg,Tajikistan,992,762,5
TZ,TZA,sw,"Tanzania, United Republic of",255,834,3
TH,THA,th,Thailand,66,764,7
TL,TLS,pt,Timor-Leste,,626,
TG,TGO,fr,Togo,228,768,0
TK,TKL,en,Tokelau,690,772,13
TO,TON,en,Tonga,676,776,13
TT,TTO,es,Trinidad and Tobago,1868,780,-4
TN,TUN,fr,Tunisia,216,788,1
TR,TUR,tr,Turkey,90,792,3
TM,TKM,tk,Turkmenistan,993,795,5
TC,TCA,es,Turks and Caicos Islands,1649,796,-5
TV,TUV,en,Tuvalu,688,798,12
UG,UGA,sw,Uganda,256,800,3
UA,UKR,ru,Ukraine,380,804,2
AE,ARE,ar,United Arab Emirates,971,784,4
GB,GBR,en,United Kingdom,44,826,0
US,USA,en,United States of America,1,840,-7
UM,UMI,,United States Minor Outlying Islands,,581,
UY,URY,es,Uruguay,598,858,-3
UZ,UZB,uz,Uzbekistan,998,860,5
VU,VUT,fr,Vanuatu,678,548,11
VE,VEN,es,Venezuela (Bolivarian Republic of),58,862,-4
VN,VNM,vi,Vietnam,84,704,7
VG,VGB,en,Virgin Islands (British),,92,
VI,VIR,en,Virgin Islands (U.S.),1340,850,-4
WF,WLF,fr,Wallis and Futuna,681,876,12
EH,ESH,ar,Western Sahara,,732,
YE,YEM,ar,Yemen,967,887,3
ZM,ZMB,en,Zambia,260,894,2
ZW,ZWE,sn,Zimbabwe,263,716,2''';
