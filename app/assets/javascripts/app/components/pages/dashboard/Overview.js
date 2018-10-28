import React, {Component} from 'react';
import {Chip, Paper} from 'material-ui';
import {paperStyle} from '../../common/styles';

class Blank extends Component {
  constructor(props){
    super(props)
    this.state = {
      chipData: [
        'Ruby on Rails',
        'Bootstrap',
        'Material UI',
        'ReactJS',
        'Redux',
        'React Router',
        'Browserify',
        'Babelify'
      ],
      style: {
        chip: {
          margin: 4,
        },
        wrapper: {
          display: 'flex',
          flexWrap: 'wrap',
        },
      }
    };
  }


  render() {
    const { chipData, style } = this.state;
    return (
      <div>over</div>


    );
  }

}

export default Blank;
