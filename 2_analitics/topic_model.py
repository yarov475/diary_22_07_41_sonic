from text22Data_analitics import paper
from tm.utils import simple_preprocess
import nltk

import tm
import tm.corpora as corpora

out = open('../txt/row.txt','w', encoding='utf8')
nltk.download('stopwords')
from nltk.corpus import stopwords

stop_words = stopwords.words('russian')
stop_words.extend(['в', 'на', 'и', 'не', 'за', 'b', 'евгения', 'михаиловна'])


def sent_to_words(sentences):
    for sentence in sentences:
        # deacc=True removes punctuations
        yield (tm.utils.simple_preprocess(str(sentence), deacc=True))


def remove_stopwords(texts):
    return [[word for word in simple_preprocess(str(doc))
             if word not in stop_words] for doc in texts]


data = paper.text_processed.values.tolist()
data_words = list(sent_to_words(data))
# remove stop words
data_words = remove_stopwords(data_words)
print(data_words[:1][0][:30])
print('row.txt created')



# Create Dictionary
id2word = corpora.Dictionary(data_words)
# Create Corpus
texts = data_words
# Term Document Frequency
corpus = [id2word.doc2bow(text) for text in texts]
# View
print(corpus[:1][0][:30])



out1 = open('/tone_value/topic_data1.txt', 'w',
            encoding='utf8')
# number of topics
num_topics = 2
# Build LDA model
lda_model = tm.models.LdaMulticore(corpus=corpus, id2word=id2word, num_topics=num_topics)
s = lda_model.print_topics()  # Print the Keyword in the 10 topics
print(s)
doc_lda = lda_model[corpus]
print(lda_model.print_topics())

print('topic_data1.txt created')


