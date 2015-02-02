from Bio import Entrez
import numpy as np
### pull info from pubmed api
outDir = '/Users/hogstrom/Dropbox (MIT)/pubmed_scrp'

### efetch example
Entrez.efetch(id="57240072")
Entrez.email = "Your.Name.Here@example.org"
handle = Entrez.efetch(db="nucleotide", id="57240072", rettype="gb", retmode="text")


### esummary example
handle = Entrez.esummary(db="journals", id="30367")
record = Entrez.read(handle)
handle.close()
print record[0]["Id"]
print record[0]["Title"]

### search putbmed return record IDs
# handle = Entrez.esearch(db="pubmed", term="cancer",retmax=10)
handle = Entrez.esearch(db="pubmed", term="nature reviews drug discovery",retmax=10)
record = Entrez.read(handle)
handle.close()
record['IdList']


### get esummary info (abstract + author info etc)
# handle = Entrez.esummary(db="journals", id="30367")
#efetch.fcgi?db=pubmed&retmode=text&rettype=abstract&id=25081398
handle = Entrez.efetch(db="pubmed", id="25081398", retmode="text", rettype="abstract")
handle = Entrez.efetch(db="pubmed", id="25081398", rettype="abstract")
record = Entrez.read(handle)
handle.close()
print record[0]["Id"]

### search for specific email in abstract
# handle = Entrez.efetch(db="pubmed", id="25081398", rettype="abstract")
# search_term = ".com&Cambridge, MA"
# search_term = ".com&Boston"
# search_term = "Novartis&Cambridge, MA"
# oFile = outDir + '/Novartis_tbl.txt'
search_term = "oncotype dx"
oFile = outDir + '/breast_cancer_tbl.txt'
handle = Entrez.esearch(db="pubmed", rettype="abstract", term=search_term,retmax=100)
# handle = Entrez.esearch(db="pubmed", rettype="abstract", term="Cambridge, MA",retmax=10)
record = Entrez.read(handle)
handle.close()
idList = record['IdList']

### retrieve article info
handle = Entrez.efetch(db="pubmed", id=idList, rettype="abstract")
abstract_records = Entrez.read(handle)
handle.close()

#loop through for each - save article info
articles_dict = {}
for a_rec in abstract_records:
    article_dict = {}
    # title
    article_dict['journal'] = a_rec['MedlineCitation']['Article']['Journal']['Title']
    # date
    date_entry = a_rec['MedlineCitation']['Article']['ArticleDate']
    if date_entry:
        article_dict['Date'] = date_entry[0]['Year']
    # title
    art_title = a_rec['MedlineCitation']['Article']['ArticleTitle']
    art_title = ''.join([i if ord(i) < 128 else ' ' for i in art_title]) #remove non ascii
    art_title = art_title.encode('utf-8') 
    article_dict['Title'] = art_title
    # authors
    authorList = a_rec['MedlineCitation']['Article']['AuthorList']
    author_number = len(authorList)
    article_dict['last_author'] = authorList[-1]['LastName']
    if authorList[-1]['AffiliationInfo']: 
        article_dict['last_author_affiliation'] = authorList[-1]['AffiliationInfo'][0]['Affiliation']
    pID = a_rec['MedlineCitation']['PMID']
    articles_dict[str(pID)] = article_dict
aFrm = pd.DataFrame(articles_dict)
aFrm = aFrm.T # transpose
# save file
aFrm.to_csv(oFile,sep='\t')

# journal_name = record[0]['MedlineCitation']['Article']['Journal']['Title']
# abstract_text = record[0]['MedlineCitation']['Article']['Abstract']

### desired out-pu
#author, email, journal article, title, date, location, pubmed_id
