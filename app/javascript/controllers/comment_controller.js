import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "hide", "unhide"]

  toggle(event) {
    event.preventDefault()
    this.formTarget.classList.toggle("d-none")
  }

  show(event) {
    event.preventDefault()
    this.unhideTarget.classList.remove("d-none")
    this.hideTarget.classList.add("d-none")
  }

  makeVisible(event) {
    event.preventDefault()
    const viewer = document.querySelector('meta[name="user-id"]').content
    const protected_links = document.getElementsByClassName('protected-links')

    for (let i = 0; i < protected_links.length; i++) {
      const link = protected_links[i]

      if (viewer === link.getAttribute('data-user-id')) {
        link.classList.remove('d-none')
      }
    }
  }
}
