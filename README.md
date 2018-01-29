# aichi13
Project Management of the Aich13 indicators

## Documentation standard

```r
# Function description
# @param (type) parameter description
# @return (type) result description
```

## File names
* lower case
* no spaces, only underlines

## Git branching

* **master**: only for releases, don't touch!
* **develop**: current development, changes to share with the team
* **issue##**: your current resolving issue, document first the issue

## Data sources

| Variable |  Name | Source |
| ------------- | ------------- |------------- | 
|Elevation | [SRTM 90m Digital Elevation Data](http://srtm.csi.cgiar.org/) | CGIAR|
|Bioclimatic variables |   [WorldClim Version2](http://worldclim.org/version2) | WordlClim|
|solar radiation| [WorldClim Version2](http://worldclim.org/version2) | WordlClim|
|wind speed| [WorldClim Version2](http://worldclim.org/version2) | WordlClim|
|water vapor pressure| [WorldClim Version2](http://worldclim.org/version2) | WordlClim|

## Data files

| Folder  | File|  Description |
| ------------- | ------------- | ------------- |
| WEP  | WEP.csv  | World Economic Plants databse |
| GBIF  | gbif.zip |GBIF download of Plantae from 1950 to date |
| GENESYS  | ciat.20171127.csv.gz  | GENESYS Original occurrence records   |
| CWR| cwr.zip  |Crop Wild Relatives database of CIAT   |
| COUNTRY  | countryISO.csv  |Country names, ISO 3166-1 alpha-3 and alpha-2  |





## Modeling parameters

**Principal modeling**: maxent2

**Alternative modeling**: CA50

**Resolution**: 2.5 arc minutes

K=5 mean as final evaluation

## Modeling evaluation

AUC mean >= 0.7

SDAUC < 0.15

ASD15 <= 10%

CAUC >= 0.4


