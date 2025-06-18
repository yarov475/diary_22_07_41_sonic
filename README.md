# Sonification of Eyewitness Accounts of the Great Patriotic War

This project explores the use of sonification as a tool for emotional data exploration. It focuses on diary entries from eyewitnesses of the Great Patriotic War, specifically from June 22, 1941, sourced from prozhito.org. The goal is to transform qualitative emotional data from these historical texts into an auditory experience, allowing for a deeper understanding and emotional engagement with the past.

## Sonification Process

The sonification process involves four main steps:

### 1. Data Selection and Preparation
The primary data consists of diary entries from June 22, 1941, the first day of the Great Patriotic War. These entries were obtained from [prozhito.org](http://prozhito.org/). Scripts for fetching and preparing this data can be found in the `1_fetching_data/` directory.

### 2. Qualitative to Quantitative Data Conversion
To analyze the emotional content of the diary entries, an algorithmic approach is used. The "Dostoevsky" library (see `dostoevsky/` directory) is employed to assess the emotional tone of the text, categorizing segments as negative, neutral, or positive. The script `tone_value/text_to_santiment.py` (likely a typo in the article, assuming it means `sentiment`) is an example of this process. The output of this stage is a table of emotional assessments.

### 3. Data Mapping to Sound Parameters
This step, often referred to as the "mapping problem," involves translating the quantitative emotional data (and potentially other textual features) into sound parameters. These parameters are then used to control sound synthesis in SuperCollider. The SuperCollider script `sonification/superCollider/ful_data_22_algo.scd` exemplifies this mapping process.

### 4. Algorithmic Processing and Sound Generation
The final sound composition is generated using SuperCollider (sclang), a powerful environment for audio synthesis and algorithmic composition. Prototyping or client interaction might involve tools like `sonification_react_network_client/`, which could be the "twotone" equivalent mentioned in the article, facilitating the exploration of sound design choices.

## Significance

This project demonstrates a novel approach to engaging with historical texts and the emotional experiences they convey. By transforming diary entries into sound, it offers a unique way to:
- Explore complex emotional data in humanities research.
- Foster deeper emotional engagement with historical events.
- Contribute to the preservation of historical memory through innovative means.

The sonification of these eyewitness accounts provides a powerful tool for researchers and the public alike to connect with the past on an affective level.
