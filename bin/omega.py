#!/usr/bin/env python
 
import sys
import xapian
                                                                                          
try:
    database = xapian.Database('info')
 
    enquire = xapian.Enquire(database)
                                                                 
    query_string = str.join(' ', sys.argv[1:])
                                                         
    qp = xapian.QueryParser()
    stemmer = xapian.Stem("english")
    qp.set_stemmer(stemmer)
    qp.set_database(database)
    qp.set_stemming_strategy(xapian.QueryParser.STEM_SOME)
    query = qp.parse_query(query_string)
 
    enquire.set_query(query)
    matches = enquire.get_mset(0, 10)
                                                                  
    print "%i results found." % matches.get_matches_estimated()
    print "Results 1-%i:" % matches.size()                                       
                       
    for m in matches:
        print "%i: %i%% docid=%i [%s]" % (m.rank + 1, m.percent, m.docid,
 m.document.get_data())
 
except Exception, e:
    print >> sys.stderr, "Exception: %s" % str(e)
    sys.exit(1)
