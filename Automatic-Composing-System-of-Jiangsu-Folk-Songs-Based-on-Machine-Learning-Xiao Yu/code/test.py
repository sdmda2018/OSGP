import tensorflow as tf
from tensorflow.contrib import rnn
import numpy as np
import matplotlib.pyplot as plt

from util import print_progress
from create_dataset import create_dataset, get_batch
from midi_manipulation import noteStateMatrixToMidi

min_song_length = 128
encoded_songs = create_dataset(min_song_length)

NUM_SONGS = len(encoded_songs)
print(str(NUM_SONGS) + " total songs to learn from")
print(encoded_songs[0].shape)

## Neural Network Parameters
input_size = encoded_songs[0].shape[1]  # The number of possible MIDI Notes
output_size = input_size  # Same as input size
hidden_size = 128  # Number of neurons in hidden layer

learning_rate = 0.001  # Learning rate of the model
training_steps = 200  # Number of batches during training
batch_size = 256  # Number of songs per batch
timesteps = 64  # Length of song snippet -- this is what is fed into the model

assert timesteps < min_song_length

input_placeholder_shape = [None, timesteps, input_size]
output_placeholder_shape = [None, output_size]

input_vec = tf.placeholder("float", input_placeholder_shape)
output_vec = tf.placeholder("float", output_placeholder_shape)

# Define weights
weights = tf.Variable(tf.random_normal([hidden_size, output_size]))

biases = tf.Variable(tf.random_normal([output_size]))


def RNN(input_vec, weights, biases):
    """
    @param input_vec: (tf.placeholder) The input vector's placeholder
    @param weights: (tf.Variable) The weights variable
    @param biases: (tf.Variable) The bias variable
    @return: The RNN graph that will take in a tensor list of shape (batch_size, timesteps, input_size)
    and output tensors of shape (batch_size, output_size)
    """
    # First, use tf.unstack() to unstack the timesteps into (batch_size, n_input).
    # Since we are unstacking the timesteps axis, we want to pass in 1 as the
    #  axis argument and timesteps as the length argument
    input_vec = tf.unstack(input_vec, timesteps, 1)

    '''TODO: Use TensorFlow's rnn module to define a BasicLSTMCell. 
    Think about the dimensionality of the output state -- how many hidden states will the LSTM cell have?'''
    lstm_cell = rnn.BasicLSTMCell(hidden_size)

    # Now, we want to get the outputs and states from the LSTM cell.
    # We rnn's static_rnn function, as described here:
    #  https://www.tensorflow.org/api_docs/python/tf/nn/static_rnn
    outputs, states = rnn.static_rnn(lstm_cell, input_vec, dtype=tf.float32)

    # Next, let's compute the hidden layer's transformation of the final output of the LSTM.
    # We can think of this as the output of our RNN, or as the activations of the final layer.
    # Recall that this is just a linear operation: xW + b, where W is the set of weights and b the biases.
    '''TODO: Use TensorFlow operations to compute the hidden layer transformation of the final output of the LSTM'''
    recurrent_net = tf.matmul(outputs[-1], weights) + biases

    # Lastly, we want to predict the next note, so we can use this later to generate a song.
    # To do this, we generate a probability distribution over the possible notes,
    #  by computing the softmax of the transformed final output of the LSTM.
    '''TODO: Use the TensorFlow softmax function to output a probability distribution over possible notes.'''
    prediction = tf.nn.softmax(recurrent_net)

    # All that's left is to return recurrent_net (the RNN output) and prediction (the softmax output)
    return recurrent_net, prediction


logits, prediction = RNN(input_vec, weights, biases)

# LOSS OPERATION:
'''TODO: Use TensorFlow to define the loss operation as the mean softmax cross entropy loss. 
TensorFlow has built-in functions for you to use. '''
loss_op = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits_v2(
    logits=logits, labels=output_vec))

# TRAINING OPERATION:
'''TODO: Define an optimizer for the training operation. 
Remember we have already set the `learning_rate` parameter.'''
optimizer = tf.train.AdamOptimizer(learning_rate=learning_rate)
train_op = optimizer.minimize(loss_op)

# ACCURACY: We compute the accuracy in two steps.

# First, we need to determine the predicted next note and the true next note, across the training batch,
#  and then determine whether our prediction was correct.
# Recall that we defined the placeholder output_vec to contain the true next notes for each song snippet in the batch.
'''TODO: Write an expression to obtain the index for the most likely next note predicted by the RNN.'''
true_note = tf.argmax(output_vec, 1)
pred_note = tf.argmax(prediction, 1)
correct_pred = tf.equal(pred_note, true_note)

# Next, we obtain a value for the accuracy.
# We cast the values in correct_pred to floats, and use tf.reduce_mean
#  to figure out the fraction of these values that are 1's (1 = correct, 0 = incorrect)
accuracy_op = tf.reduce_mean(tf.cast(correct_pred, tf.float32))

# INITIALIZER:
# Finally we create an initializer to initialize the variables we defined in Section 2.2.2
# We use TensorFlow's global_variables_initializer
init = tf.global_variables_initializer()

# 1) Launch the session
sess = tf.InteractiveSession()

# 2) Initialize the variables
sess.run(init)

# 3) Train!
display_step = 1  # how often to display progress
for step in range(training_steps):
    # GET BATCH
    # Add the line to get training data batch (see util.get_batch or whatever for args) FIX THIS !
    '''TODO: Fill in the function call to obtain a training data batch. 
    Hint: See the file util/create_dataset.py.'''
    batch_x, batch_y = get_batch(encoded_songs, batch_size, timesteps, input_size, output_size) 

    # TRAINING: run the training operation with a feed_dict to fill in the placeholders
    '''TODO: Feed the training batch into the feed_dict.'''
    feed_dict = {
        input_vec: batch_x,  
        output_vec: batch_y  
    }
    sess.run(train_op, feed_dict=feed_dict)

    # DISPLAY METRICS
    if step % display_step == 0 or step == 1:
        # LOSS, ACCURACY: Compute the loss and accuracy by running both operations
        loss, acc = sess.run([loss_op, accuracy_op], feed_dict=feed_dict)
        suffix = "\nStep " + str(step) + ", Minibatch Loss= " + \
                 "{:.4f}".format(loss) + ", Training Accuracy= " + \
                 "{:.3f}".format(acc)

        print_progress(step, training_steps, barLength=50, suffix=suffix)

writer = tf.summary.FileWriter("/home/elias/Downloads/introtodeeplearning_labs-master/lab1/graph", graph=tf.get_default_graph())

#      music generating
GEN_SEED_RANDOMLY = True  # Use a random snippet as a seed for generating the new song.
if GEN_SEED_RANDOMLY:
    ind = np.random.randint(NUM_SONGS)
else:
    ind = 41  # "How Deep is Your Love" by Calvin Harris as a starting seed

gen_song = encoded_songs[ind][:timesteps].tolist() 

# generate music!
for i in range(500):
    seed = np.array([gen_song[-timesteps:]])
    # Use our RNN for prediction using our seed!
    '''TODO: Write an expression to use the RNN to get the probability for the next note played based on the seed.
    Remember that we are now using the RNN for prediction, not training.'''
    predict_probs = sess.run(prediction, feed_dict={input_vec: seed})

    # Define output vector for our generated song by sampling from our predicted probability distribution
    played_notes = np.zeros(output_size)
    '''TODO: Sample from the predicted distribution to determine which note gets played next.
    You can use a function from the numpy.random library to do this.
    Hint 1: range(x) produces a list of all the numbers from 0 to x
    Hint 2: make sure predict_probs has the "shape" you expect. you may need to flatten it: predict_probs.flatten()'''
    print
    np.argmax(predict_probs[0])
    plt.plot(predict_probs[0])
    sampled_note = np.random.choice(range(output_size), p=predict_probs[0])
    # sampled_note = np.argmax(predict_probs[0])
    played_notes[sampled_note] = 1
    gen_song.append(played_notes)

noteStateMatrixToMidi(gen_song, name="/home/elias/Downloads/introtodeeplearning_labs-master/lab1/generated/gen_song_0")
noteStateMatrixToMidi(encoded_songs[ind], name="/home/elias/Downloads/introtodeeplearning_labs-master/lab1/generated/base_song_0")
print("saved generated song! seed ind: {}".format(ind))
