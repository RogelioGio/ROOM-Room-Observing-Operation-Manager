import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="date-range"
export default class extends Controller {
  static targets = ["start", "end", "checkbox", "startTime", "endTime"]

  connect() {
    this.handleDateChange() 
    this.handleTimeChange()
  }

  handleTimeChange() {
    this.constrainedTime()
  }

  constrainedTime() {
    const startTime = this.startTimeTarget.value
    const endTime = this.endTimeTarget.value

    if (startTime) {
      this.endTimeTarget.min = startTime
      if (endTime && endTime < startTime) {
        this.endTimeTarget.value = startTime
      }
    }
  }

  handleDateChange() {
    this.constrainEndDates()
    this.toggleCheckboxes()
  }

  constrainEndDates() {
    const startValue = this.startTarget.value;
    const endValue = this.endTarget.value;
    const today = this.todayValue;

    if (startValue && startValue < today) {
      this.startTarget.value = today;
    }

    if (this.startTarget.value) {
      this.endTarget.min = this.startTarget.value;
      if (endValue && endValue < this.startTarget.value) {
        this.endTarget.value = this.startTarget.value;
      }
    }
  }

  toggleCheckboxes() {
    const startStr = this.startTarget.value
    const endStr = this.endTarget.value

    // If dates aren't filled, keep checkboxes enabled
    if (!startStr || !endStr) {
      this.checkboxTargets.forEach(cb => cb.disabled = false)
      return
    }

    // Creating dates this way avoids timezone shifts
    const startDate = new Date(startStr)
    const endDate = new Date(endStr)

    // Calculate absolute difference in days
    const diffTime = Math.abs(endDate - startDate)
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24))
    
    console.log(`Days apart: ${diffDays}`) // Check this in F12 console

    // Logic: Disable if 7 days or less
    const shouldDisable = diffDays <= 7

    this.checkboxTargets.forEach(cb => {
      cb.disabled = shouldDisable
      
      if (shouldDisable) {
        cb.checked = false
        cb.parentElement.classList.add('opacity-40', 'cursor-not-allowed')
      } else {
        cb.parentElement.classList.remove('opacity-40', 'cursor-not-allowed')
      }
    })
  }
}
