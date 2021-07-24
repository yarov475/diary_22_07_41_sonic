from dostoevsky.tokenization import RegexTokenizer
from dostoevsky.models import FastTextSocialNetworkModel
from normalize_topic_data1 import res

tokenizer = RegexTokenizer()
model = FastTextSocialNetworkModel(tokenizer=tokenizer)
out = open('msg_sent.txt', 'w', encoding='utf8')

messages = res
results = model.predict(messages, k=2)

for message, sentiment in zip(messages, results):

    print(sentiment, file=out)

print('text_topic_to_txt.py=>msg_sent.txt')
