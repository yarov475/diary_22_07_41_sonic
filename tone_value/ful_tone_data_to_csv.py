from text_topic_to_txt import results
import csv

# header = ['positive', 'negative', 'neutral','skip','speech']
mlt = 1000
positive = []
neutral = []
negative = []
skip = []
speech = [],

total_CSV = []
to_csv = [neutral, negative, positive,skip,speech]
for dic in results:

    for tone in results:

        if 'neutral' in tone:
            neutral.append(tone['neutral'])
        else:
            neutral.append(0)

        if 'negative' in tone:
            negative.append(tone['negative'])
        else:
            neutral.append(0)
        if 'positive' in tone:
            positive.append(tone['positive'])
        else:
            positive.append(0)
        if 'skip' in tone:
            positive.append(tone['skip'])
        else:
            positive.append(0)
        if 'speech' in tone:
            positive.append(tone['speech'])
        else:
            positive.append(0)

with open('../csv/tone_topic_full_data.csv', 'w', newline='') as csvfile:
    sonic = csv.writer(csvfile, delimiter=',',
                       quotechar='|', quoting=csv.QUOTE_MINIMAL)

    data = list(zip(positive, negative, neutral))
    # sonic.writerow(header)
    for row in data:
        row = list(row)
        sonic.writerow(row)



print("full_data_to_sound.py=>tone_topic_full_data.csv")
