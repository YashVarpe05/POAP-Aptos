# Proof of Attendance Protocol (POAP) on Aptos

## Introduction

The **Proof of Attendance Protocol (POAP)** on the Aptos blockchain is a decentralized solution designed to streamline event management and attendance verification using blockchain technology. POAP enables event hosts to create, manage, and track participation seamlessly while providing attendees with a frictionless registration process, automated fee payments, and verified attendance records. Whether hosting large conferences or community events, POAP ensures transparent and immutable proof of participation.

## Vision

The POAP protocol envisions transforming how events are managed globally by creating a decentralized system that promotes trust, transparency, and automation. The vision focuses on building:

- **Elevated Participation**: Encourage genuine engagement through seamless participation mechanisms and incentives.
- **Decentralized Trust**: Use open and tamper-proof attendance records managed by smart contracts to eliminate fraud and enhance reliability.
- **Empowered Communities**: Democratize event hosting, making it more accessible, inclusive, and transparent.

POAP's goal is to empower communities to gather, interact, and grow through secure, verified, and memorable experiences.

## Features

### Current Features
- **Event Creation and Management**: Hosts can create new events with unique IDs, time constraints, and limited capacities.
- **Verified Attendance**: Attendee participation is validated and recorded immutably on-chain, ensuring transparency.
- **Automated Fee Payments**: The protocol allows fee-based participation, including early-bird discounts, enforced through smart contracts.

### Key Components
1. **Event Struct**: Represents event details such as event ID, host address, start and end times, maximum capacity, attendees list, entry fees, and early-bird discounts.
2. **Attendance Struct**: Captures attendance records, including event ID, registration timestamp, and tier information.
3. **Smart Contracts**: Handle event creation, participant registration, and payment processing securely and automatically.

### Usage
- **Event Initialization**: Create an event with parameters like event ID, start and end times, maximum capacity, entry fee, early-bird discount, and deadlines.
- **Attendance Registration**: Participants register for events, and the system automatically verifies eligibility, processes payments, and records their attendance.

## Future Goals

We are committed to expanding and enhancing the POAP ecosystem with the following objectives:

1. **NFT Attendance Badges**: Introduce non-fungible tokens (NFTs) as unique attendance badges that can be displayed, traded, or redeemed for rewards.
2. **AI-Powered Insights**: Leverage AI for actionable insights on attendee behavior, engagement trends, and personalized recommendations for future events.
3. **Smart Tiered Ticketing**: Develop a flexible ticketing system that supports tier-based rewards, discounts, and loyalty programs.
4. **Cross-Platform Integration**: Integrate POAP with virtual meeting platforms, social networks, and the metaverse for enhanced engagement.
5. **Decentralized Identity (DID) Support**: Enable users to control and verify their identity using decentralized solutions for better privacy and trust.
6. **Customizable Event Logic**: Allow hosts to design custom event logic with gamification, VIP access, and reward systems enforced by smart contracts.
7. **Real-Time Interaction**: Facilitate interactive features such as live polls, Q&A sessions, and dashboards during events.
8. **Mobile-First Interface**: Optimize the user experience for mobile devices, making event management and participation accessible on the go.

## Smart Contract Address

- **Deployed Contract Address**:`0x42b28ed9d9b5eafc140d4f8dd3f5868176e3d77bcdea93de2aba2c2fdb41689d`

---

## Developer Guide

### Prerequisites
- Aptos CLI installed
- Knowledge of Move language and smart contract development

### Setup and Usage

1. **Initialize Event**: Use `init_event` function to create a new event with specified parameters.
2. **Register Attendance**: Use `register_attendance` to register participants, with built-in checks for event capacity, eligibility, and payments.

### Testing
The module contains a built-in `test_event_creation_and_registration` function to simulate creating and registering for events, useful for testing and debugging.

## Contributions

Contributions are welcome! Please follow the standard [Aptos developer guidelines](https://aptos.dev) for building and testing modules. Submit issues, feature requests, and pull requests to improve the protocol.
