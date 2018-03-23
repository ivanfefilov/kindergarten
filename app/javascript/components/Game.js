import React from "react";
import PropTypes from "prop-types";

class Game extends React.Component {
  render () {
    return (
      <div>
        <h1>Hello{this.props.gameItems}, </h1>
        <h3>Wow! This is your first react component!</h3>
      </div>
    );
  }
}

Game.propTypes = {
  gameItems: PropTypes.array
};

export default Game
