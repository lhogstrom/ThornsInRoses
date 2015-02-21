from Bio import Entrez
import numpy as np
import pandas as pd 

### pull info from pubmed api
outDir = '/Users/hogstrom/Dropbox (MIT)/pubmed_scrp'
Entrez.email = "Your.Name.Here@example.org"

### search for specific email in abstract
# handle = Entrez.efetch(db="pubmed", id="25081398", rettype="abstract")
# search_term = ".com&Cambridge, MA"
# search_term = ".com&Boston"
#search_term = "Novartis&Cambridge, MA"
search_term = "adjuvant&breast&Cambridge, MA"
oFile = outDir + '/adjuvant_therapy_tbl.txt'
# search_term = "Oncotype&Cambridge"
# oFile = outDir + '/oncotype_dx_tbl.txt'
handle = Entrez.esearch(db="pubmed", rettype="abstract", term=search_term,retmax=100)
# handle = Entrez.esearch(db="pubmed", rettype="abstract", term="Cambridge, MA",retmax=10)
record = Entrez.read(handle)
handle.close()
idList = record['IdList']
if len(idList) == 0:
    print "no resutlts for query: " +search_term
else:
    ### retrieve article info
    handle = Entrez.efetch(db="pubmed", id=idList, rettype="abstract")
    abstract_records = Entrez.read(handle)
    handle.close()
    #loop through for each - save article info
    articles_dict = {}
    for a_rec in abstract_records:
        article_dict = {}
        if a_rec.has_key('BookDocument'): # if book skip
            continue
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
        if authorList[-1].has_key('LastName'): # check author name is listed
            article_dict['last_author'] = authorList[-1]['LastName']
        if authorList[-1]['AffiliationInfo']: 
            article_dict['last_author_affiliation'] = authorList[-1]['AffiliationInfo'][0]['Affiliation']
        pID = a_rec['MedlineCitation']['PMID']
        articles_dict[str(pID)] = article_dict
    aFrm = pd.DataFrame(articles_dict)
    aFrm = aFrm.T # transpose
    # save file
    #aFrm.to_csv(oFile,sep='\t', encoding='utf-8')
# journal_name = record[0]['MedlineCitation']['Article']['Journal']['Title']
# abstract_text = record[0]['MedlineCitation']['Article']['Abstract']

# read abstract
# handle = Entrez.efetch(db="pubmed", id="25081398", retmode="text", rettype="abstract")
# handle.read()


### desired out-pu
#author, email, journal article, title, date, location, pubmed_id


