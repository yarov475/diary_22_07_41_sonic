from matplotlib import pyplot as plt
from matplotlib import style
import pandas as pd

df_topic_tone = pd.read_csv('../csv/tone_topic_data.csv', delimiter=',')
df_topic_tone = df_topic_tone/100
df_topic_tone['emo']= df_topic_tone['negative'] / 100 + df_topic_tone['positive'] / 100
style.use('fast')
n = df_topic_tone['neutral']
plt.plot(n ,color = 'blue', label = 'Степень нейтральности')

p = df_topic_tone['positive']
plt.plot(p,color = 'green', label = 'Степень позитивночти')

neg = df_topic_tone['negative']
plt.plot(p, color = 'red', label = 'Степень негативности')
plt.xlabel('Колличество тем')
plt.ylabel('Оценка')
emo = df_topic_tone['emo']
plt.plot(emo,color = 'purple', label = 'Степень  общей эмоциональности')
plt.legend()
plt.title('Эмоциональная оценка тем записей 22 июня 1941 года')
plt.show()
fig = plt.figure()
fig.savefig('../img/topic_tone.png')


def print(param):
    pass


print('img/topic_tone.png created')