import React from "react";
import PropTypes from "prop-types";

class Game extends React.Component {
  
  state = {
    gameItems: [],
    currentItem: 0,
    gameStarted: false,
    gameFinished: false,
    correctAnswers: 0,
    incorrectAnswers: 0,
    answerReceived: false,
    receivedAnswerIsCorrect: false
  }
  
  componentDidMount = () => {
    $.getJSON('/game_items.json', (response) => {
        console.log(response);
        this.setState({ gameItems: response })
    });
  };
  
  startGame = () => {
    console.log("Игра началась");
    this.setState({ gameStarted: true, gameFinished: false, currentItem: 0, correctAnswers: 0, incorrectAnswers: 0 });
  };
  
  makeAnswer = (item, answer) => {
    let answerIsCorrect = item.eatable == answer;
    let newIncorrectAnswers = this.state.incorrectAnswers;
    let newCorrectAnswers = this.state.correctAnswers;
    if (answerIsCorrect) {
      newCorrectAnswers += 1;
    } else {
      newIncorrectAnswers += 1;
    };
    this.setState({ answerReceived: true, 
                    receivedAnswerIsCorrect: answerIsCorrect,
                    correctAnswers: newCorrectAnswers, 
                    incorrectAnswers: newIncorrectAnswers });
  };
  
  goToNextQuestion = () => {
    let newCurrentItem = this.state.currentItem + 1;
    let gameIsFinished = newCurrentItem >= this.state.gameItems.length;
    this.setState({ currentItem: newCurrentItem, 
                    gameFinished: gameIsFinished,
                    answerReceived: false  });
  }
  
  renderAnswerResult = () => {
    if (this.state.receivedAnswerIsCorrect) {
      return (
        <div className="thumbnail">
          <img src="/images/success_emoji.jpg" />
          <div className="caption text-center">
            <h3>Молодец! Правильно!</h3>
            <p>
              <button type="button" className="btn btn-primary" onClick={() => this.goToNextQuestion()}>Следующий вопрос</button>
            </p>
          </div>
        </div>
      );
    } else {
      return (
        <div className="thumbnail">
          <img src="/images/error_emoji.jpg" />
          <div className="caption text-center">
            <h3>Неправильно.</h3>
            <p>
              <button type="button" className="btn btn-primary" onClick={() => this.goToNextQuestion()}>Следующий вопрос</button>
            </p>
          </div>
        </div>
      );
    } 
  };
    
  renderStartGameButton = () => {
    return (
      <div className="text-center">
        <button type="button" className="btn btn-primary" onClick={() => this.startGame()}>Начать игру</button>
      </div>
    )  
  };
  
  renderGameFinished = () => {
    return (
      <div className="thumbnail">
        <div className="caption text-center">
          <h3>Игра окончена.</h3>
          <div>Правильных ответов: {this.state.correctAnswers}</div>
          <div>Неправильных ответов: {this.state.incorrectAnswers}</div>
          <p style={{marginTop: "15px"}}>
            <a className="btn btn-default" role="button" onClick={() => this.startGame()}>Начать заново</a> 
          </p>
        </div>
      </div>
    )
  }
  
  renderQuestion = () => {
    let item = this.state.gameItems[this.state.currentItem];
    return (
      <div className="thumbnail">
        <img src={item.image_path} />
        <div className="caption text-center">
          <h3>Съедобное?</h3>
          <p>
            <a className="btn btn-default" role="button" onClick={() => this.makeAnswer(item, true)}>ДA</a> 
            <a className="btn btn-default" role="button" style={{marginLeft: "15px"}} onClick={() => this.makeAnswer(item, false)}>НЕТ</a>
          </p>
        </div>
      </div>
    )
  }
  
  render () {
    return (
      <div>
        <h1 className="text-center">Съедобное - Несъедобное</h1>
        <div style={{marginTop: "50px"}}>
          <div className="row">
            <div className="col-md-6 col-md-offset-3">
              { !this.state.gameStarted && !this.state.gameFinished &&
                this.renderStartGameButton()
              }
              { this.state.gameStarted && !this.state.gameFinished && !this.state.answerReceived &&
                this.renderQuestion()
              }
              { this.state.gameStarted && !this.state.gameFinished && this.state.answerReceived &&
                this.renderAnswerResult()
              }
              { this.state.gameFinished &&
                this.renderGameFinished()
              }
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default Game
