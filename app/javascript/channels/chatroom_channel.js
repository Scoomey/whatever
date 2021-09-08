import consumer from "./consumer";

const initChatroomCable = () => {
  const messagesContainer = document.getElementById('messages');
  const messages = document.querySelector('.messages');

  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        messages.insertAdjacentHTML('beforeend', data);
        messages.scrollTop = messages.scrollHeight;
        document.getElementById('new_message').reset();
        // console.log(data)
      },
    });

  }
}

export { initChatroomCable };
