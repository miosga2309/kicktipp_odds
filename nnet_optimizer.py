import pandas as pd
from keras.models import Sequential
from keras.layers import Dense
from keras.optimizers import SGD
from keras.utils import to_categorical
from matplotlib import pyplot

# load data and split features into independent X and dependent Y
df = pd.read_csv("/Users/jonasmiosga/Desktop/kicktipp_odds/df_nn.csv")
v_ind = ["hodds_mean","dodds_mean","aodds_mean","HomeTeam.Augsburg","HomeTeam.Bayern.Munich",
"HomeTeam.Bielefeld","HomeTeam.Darmstadt","HomeTeam.Dortmund","HomeTeam.Ein.Frankfurt",
"HomeTeam.FC.Koln","HomeTeam.Fortuna.Dusseldorf","HomeTeam.Freiburg","HomeTeam.Hamburg",
"HomeTeam.Hannover","HomeTeam.Hertha","HomeTeam.Hoffenheim","HomeTeam.Ingolstadt",
"HomeTeam.Leverkusen","HomeTeam.M.gladbach","HomeTeam.Mainz","HomeTeam.Nurnberg",
"HomeTeam.Paderborn","HomeTeam.RB.Leipzig","HomeTeam.Schalke.04","HomeTeam.Stuttgart",
"HomeTeam.Union.Berlin","HomeTeam.Werder.Bremen","HomeTeam.Wolfsburg","AwayTeam.Augsburg",
"AwayTeam.Bayern.Munich","AwayTeam.Bielefeld","AwayTeam.Darmstadt","AwayTeam.Dortmund",
"AwayTeam.Ein.Frankfurt","AwayTeam.FC.Koln","AwayTeam.Fortuna.Dusseldorf",
"AwayTeam.Freiburg","AwayTeam.Hamburg","AwayTeam.Hannover","AwayTeam.Hertha",
"AwayTeam.Hoffenheim","AwayTeam.Ingolstadt","AwayTeam.Leverkusen","AwayTeam.M.gladbach",
"AwayTeam.Mainz","AwayTeam.Nurnberg","AwayTeam.Paderborn","AwayTeam.RB.Leipzig",
"AwayTeam.Schalke.04","AwayTeam.Stuttgart","AwayTeam.Union.Berlin","AwayTeam.Werder.Bremen",
"AwayTeam.Wolfsburg"]
v_dep = ["FTHG0", "FTHG1","FTHG2","FTHG3","FTHG4","FTHG5","FTHG6","FTHG7","FTHG8",
"FTAG0","FTAG1","FTAG2","FTAG3","FTAG4","FTAG5","FTAG6"]
Xtrain = df[v_ind][0:1529]
Xtest = df[v_ind][1530:1557]
Ytrain = df[v_dep][0:1529]
Ytest = df[v_dep][1530:1557]

# define the keras model
model = Sequential()
model.add(Dense(16, input_dim=len(v_ind), activation='relu'))
model.add(Dense(32, activation='relu'))
model.add(Dense(len(v_dep), activation='sigmoid'))

# compile the model
opt = SGD(lr=0.01, momentum=0.9)
model.compile(loss='categorical_crossentropy', optimizer=opt, metrics=['accuracy'])

# fit model
history = model.fit(Xtrain, Ytrain, validation_data=(Xtest, Ytest), epochs=100, verbose=0)

# evaluate the model
train_acc = model.evaluate(Xtrain, Ytrain, verbose=0)
test_acc = model.evaluate(Xtest, Ytest, verbose=0)
print("train_acc: "+str(train_acc))
print("test_acc: "+str(test_acc))
#print('Train: %.3f, Test: %.3f' % (train_acc, test_acc))

# plot loss during training
pyplot.subplot(211)
pyplot.title('Loss')
pyplot.plot(history.history['loss'], label='train')
pyplot.plot(history.history['val_loss'], label='test')
pyplot.legend()

# plot accuracy during training
pyplot.subplot(212)
pyplot.title('Accuracy')
pyplot.plot(history.history['accuracy'], label='train')
pyplot.plot(history.history['val_accuracy'], label='test')
pyplot.legend()
pyplot.show()
