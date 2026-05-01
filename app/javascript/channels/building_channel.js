import consumer from "channels/consumer"

const building = document.getElementById('building').dataset.buildingId;


consumer.subscriptions.create({channel: "BuildingChannel", building_id: building}, {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to BuildingChannel with building_id: " + building);
  },

  disconnected() {
    // Called when the subscription has been terminated by the server

  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("Received data on BuildingChannel: ", data);
  }
});
