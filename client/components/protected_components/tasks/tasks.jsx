import React from 'react';

export default class Tasks extends React.Component {
  constructor(props) {
    super(props);
    console.log(props.currentUser.id);
    this.state = {
      user_id: props.currentUser.id,
      body: ''
    };
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.createTask(this.state).then(
      () => this.setState({
        body: ''
      })
    );
  }


  updateBody (e) {
    this.setState({
      body: e.target.value
    });
  }

  render() {
    return (
      <form
        onSubmit={e => this.handleSubmit(e)}
        className='message-input'>
        <input
          type='text'
          value={this.state.body}
          onChange={e => this.updateBody(e)}
          placeholder='Enter a task...' />
        <input type='submit' value='Send' />
      </form>
    );
  }

}