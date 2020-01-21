import { Socket } from "phoenix";
import "phoenix_html";
import LiveSocket from "phoenix_live_view";
import "../css/app.css";

let Hooks = {};
Hooks.Todo = {
  mounted() {
    this.el.addEventListener("dblclick", e => {
      const toggle = this.el.querySelector(".toggle");

      this.pushEvent("edit", {
        "todo-id": toggle.getAttribute("phx-value-todo-id")
      });
    });
  },
  updated() {
    const edit = this.el.querySelector(".edit");
    edit.focus();
    edit.setSelectionRange(edit.value.length, edit.value.length);
  }
};

const liveSocket = new LiveSocket("/live", Socket, {
  hooks: Hooks
});

liveSocket.connect();
