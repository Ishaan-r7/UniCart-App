const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    unique: true,
    validate: {
      validator: (value) => {
        const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return value.match(re);
      },
      message: 'Please Enter a Valid email address',
    },
  },
  password: {
    required: true,
    type: String,
    minlength: [6, 'Password should have at least 6 characters'],
  },
  address: {
    type: String,
    default: '',
  },
  type: {
    type: String,
    default: 'user',
  },
  //Cart
});

// Hash the password before saving the user document to MongoDB
userSchema.pre('save', async function (next) {
  const salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);
  next();
});

// Compare the password provided by the user to the password stored in the database
async function comparePassword(password) {
  return await bcrypt.compare(password, this.password);
}

userSchema.methods.comparePassword = comparePassword;

const User = mongoose.model('User', userSchema);

module.exports = User;
