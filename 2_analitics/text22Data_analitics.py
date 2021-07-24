import pandas as pd
import re
from wordcloud import WordCloud

import matplotlib as mpl
import matplotlib.pyplot as plt

paper = pd.read_csv('../csv/22Data.csv', delimiter=',')

paper['text_processed'] = \
    paper['text'].map(lambda x: re.sub('[,\.!?]', '', x))
# Convert the titles to lowercase
paper['text_processed'] = \
    paper['text_processed'].map(lambda x: x.lower())
# Print out the first rows of papers
paper['text_processed'].head()

# Join the different processed titles together.
long_string = ','.join(list(paper['text_processed'].values))
# Create a WordCloud object
wordcloud = WordCloud(background_color="black", max_words=5000, contour_width=3, contour_color='steelblue')
# Generate a word cloud
wordcloud.generate(long_string)
# Visualize the word cloud
wordcloud.to_image()
wordcloud = wordcloud.to_file(
    '../img/world_cloud22data_text.png')


print('world_cloud22data_text.png created in /img')
