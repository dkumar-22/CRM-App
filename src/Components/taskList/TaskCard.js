import * as React from 'react';
import CssBaseline from '@mui/material/CssBaseline';
import Box from '@mui/material/Box';
import Container from '@mui/material/Container';
import { makeStyles } from '@mui/styles';

const useStyles =makeStyles({
  root:{
    background: 'white',
  }
})
const TaskCard = () => {
  const classes = useStyles();
  return (
    <React.Fragment className ={classes.root}>
      <CssBaseline />
      <Container >
        <Box sx={{ height: '100vh' }} >

        </Box>
      </Container>
    </React.Fragment>
  );
}

export default TaskCard