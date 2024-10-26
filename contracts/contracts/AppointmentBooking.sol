// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AppointmentBooking {
    struct Appointment {
        address patient;
        uint256 date;
        bool confirmed;
    }

    mapping(uint256 => Appointment) public appointments;
    uint256 public appointmentCount;
    address public admin;

    event AppointmentBooked(uint256 appointmentId, address patient, uint256 date);
    event AppointmentConfirmed(uint256 appointmentId);
    event AppointmentCancelled(uint256 appointmentId);

    constructor() {
        admin = msg.sender; // Set the contract creator as the admin
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can perform this action");
        _;
    }

    function bookAppointment(uint256 date) public {
        appointmentCount++;
        appointments[appointmentCount] = Appointment(msg.sender, date, false);
        emit AppointmentBooked(appointmentCount, msg.sender, date);
    }

    function confirmAppointment(uint256 appointmentId) public onlyAdmin {
        appointments[appointmentId].confirmed = true;
        emit AppointmentConfirmed(appointmentId);
    }

    function cancelAppointment(uint256 appointmentId) public onlyAdmin {
        delete appointments[appointmentId];
        emit AppointmentCancelled(appointmentId);
    }
}
