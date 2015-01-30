from Bio import Entrez
### pull info from pubmed api


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
handle = Entrez.esearch(db="pubmed", rettype="abstract", term="pfizer.com",retmax=10)
record = Entrez.read(handle)
handle.close()


### desired out-put
#author, email, journal article, title, date, location
