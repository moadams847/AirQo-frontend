import React, { useState } from 'react';
import clsx from 'clsx';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/styles';
import {
  Card,
  CardHeader,
  CardContent,
  CardActions,
  Divider,
  Grid,
  Button,
  TextField
} from '@material-ui/core';

const useStyles = makeStyles((theme) => ({
  container: {
    display: 'flex',
    flexWrap: 'wrap',
  },
  textField: {
    marginLeft: theme.spacing.unit,
    marginRight: theme.spacing.unit,
  },
  dense: {
    marginTop: 16,
  },
  menu: {
    width: 200,
  },
  root: {}
}));


const AccountDetails = props => {
  const { className, mappeduserState, mappedAuth, ...rest } = props;

  const { user } = mappedAuth;
  console.log("the user is here: ")
  console.dir(user);

  const classes = useStyles();

  const initialState = {
    firstName: user.firstName,
    lastName: user.lastName,
    email: user.email,
    phoneNumber: '',
  };

  const [form, setState] = useState(initialState);

  const handleChange = (e) => {
    setState({
      ...form,
      [e.target.id]:e.target.value
    })
    
      };

  const states = [
    {
      value: 'Kyagwe',
      label: 'Kyagwe'
    },
    {
      value: 'Bukoto',
      label: 'Bukoto'
    },
    {
      value: 'Nansana',
      label: 'Nansana'
    }
  ];

  const clearState = ()=>{
    setState({...initialState});
  };

  const onSubmit = (e) =>{
    e.preventDefault();
    const userData = {
      firstName: form.firstName,
      lastName: form.lastName,
      email: form.email,
      phoneNumber: form.phoneNumber,
    };
    console.log(userData);
    props.mappedUpdateAuthenticatedUser(userData);
 clearState();
  }

  return (
    <Card {...rest} className={clsx(classes.root, className)}>
      <form autoComplete="off" noValidate>
        <CardHeader subheader="The information can be edited" title="Profile" />
        <Divider />
        <CardContent>
          <Grid container spacing={3}>
            <Grid item md={6} xs={12}>
              <TextField
                fullWidth
                helperText="Please specify the first name"
                label="First name"
                margin="dense"
                id="firstName"
                onChange={handleChange}
                required
                value={form.firstName}
                InputProps={{ disableUnderline: true }}
              />
            </Grid>
            <Grid item md={6} xs={12}>
              <TextField
                fullWidth
                label="Last name"
                margin="dense"
                id="lastName"
                onChange={handleChange}
                required
                value={form.lastName}
                InputProps={{ disableUnderline: true }}
              />
            </Grid>
            <Grid item md={6} xs={12}>
              <TextField
                fullWidth
                label="Email Address"
                margin="dense"
                id="email"
                onChange={handleChange}
                required
                value={form.email}
                InputProps={{ disableUnderline: true }}
             
              />
            </Grid>
            <Grid item md={6} xs={12}>
              <TextField
                fullWidth
                label="Phone Number"
                margin="dense"
                id="phoneNumber"
                onChange={handleChange}
                value={form.phoneNumber}
                InputProps={{ disableUnderline: true }}
              />
            </Grid>
            {/* <Grid
              item
              md={6}
              xs={12}
            >
              <TextField
                fullWidth
                label="Preferred Locations"
                margin="dense"
                name="state"
                onChange={handleChange}
                required
                select
                // eslint-disable-next-line react/jsx-sort-props
                SelectProps={{ native: true }}
                value=""
                variant="outlined"
              >
                {states.map(option => (
                  <option
                    key={option.value}
                    value={option.value}
                  >
                    {option.label}
                  </option>
                ))}
              </TextField>
            </Grid>
            <Grid
              item
              md={6}
              xs={12}
            >
              <TextField
                fullWidth
                label="Country"
                margin="dense"
                name="country"
                onChange={handleChange}
                required
                value="Uganda"
                // defaultValue="Uganda"
                variant="outlined"
              />
            </Grid> */}
          </Grid>
        </CardContent>
        <Divider />
        <CardActions>
          <Button color="primary" variant="contained" onClick={onSubmit}>
            Save details
          </Button>
        </CardActions>
      </form>
    </Card>
  );
};

AccountDetails.propTypes = {
  className: PropTypes.string,
  mappedAuth: PropTypes.object.isRequired
};

export default AccountDetails;
