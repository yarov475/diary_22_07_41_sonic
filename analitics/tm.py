import gensim
import gensim.corpora as corpora
# Create Dictionary
from topic_model import data_words

id2word = corpora.Dictionary(data_words)
# Create Corpus
texts = data_words
# Term Document Frequency
corpus = [id2word.doc2bow(text) for text in texts]
# View
print(corpus[:1][0][:30])
out = open('topic_data1.txt','w', encoding='utf8')
# number of topics
num_topics = 200
# Build LDA model
lda_model = gensim.models.LdaMulticore(corpus=corpus,
                                       id2word=id2word,
                                       num_topics=num_topics)
s = lda_model.print_topics()# Print the Keyword in the 10 topics


print(lda_model.print_topics(), file=out)
doc_lda = lda_model[corpus]