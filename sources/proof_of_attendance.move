module ProofOfAttendance::POAP {
    use std::string;
    use std::vector;
    use aptos_framework::timestamp;
    use aptos_framework::coin::{Self};
    use aptos_framework::aptos_coin::AptosCoin;
    use aptos_framework::account;
    
    #[test_only]
    use aptos_framework::account::create_account_for_test;

    /// Event struct to store event details
    struct Event has key {
        event_id: u64,
        host: address,
        start_time: u64,
        end_time: u64,
        attendees: vector<address>,
        max_capacity: u64,
        is_active: bool,
        entry_fee: u64,
        early_bird_discount: u64,
        early_bird_deadline: u64,
    }

    /// Attendance record struct
    struct Attendance has key {
        event_id: u64,
        timestamp: u64,
        tier: u8
    }

    /// Error codes
    const ENO_EVENT: u64 = 1;
    const EEVENT_INACTIVE: u64 = 2;
    const EEVENT_FULL: u64 = 3;
    const EALREADY_REGISTERED: u64 = 4;
    const EINVALID_TIME: u64 = 5;
    const EINSUFFICIENT_BALANCE: u64 = 6;

    public fun init_event(
        account: &signer,
        event_id: u64,
        start_time: u64,
        end_time: u64,
        max_capacity: u64,
        entry_fee: u64,
        early_bird_discount: u64,
        early_bird_deadline: u64
    ) {
        let event = Event {
            event_id,
            host: account::get_address(account),
            start_time,
            end_time,
            attendees: vector::empty(),
            max_capacity,
            is_active: true,
            entry_fee,
            early_bird_discount,
            early_bird_deadline
        };
        move_to(account, event);
    }

    public entry fun register_attendance(
        account: &signer,
        host: address,
        event_id: u64,
        tier: u8
    ) acquires Event {
        let event = borrow_global_mut<Event>(host);
        assert!(event.event_id == event_id, ENO_EVENT);
        assert!(event.is_active, EEVENT_INACTIVE);
        
        let attendee = account::get_address(account);
        assert!(!vector::contains(&event.attendees, &attendee), EALREADY_REGISTERED);
        
        let current_time = timestamp::now_seconds();
        assert!(current_time >= event.start_time && current_time <= event.end_time, EINVALID_TIME);
        assert!(vector::length(&event.attendees) < event.max_capacity, EEVENT_FULL);

        // Calculate fee
        let fee = if (current_time < event.early_bird_deadline) {
            event.entry_fee - event.early_bird_discount
        } else {
            event.entry_fee
        };

        // Process payment
        if (fee > 0) {
            coin::transfer<AptosCoin>(account, host, fee);
        };

        // Record attendance
        let attendance = Attendance {
            event_id,
            timestamp: current_time,
            tier
        };

        vector::push_back(&mut event.attendees, attendee);
        move_to(account, attendance);
    }

    #[test(host = @0x1, attendee = @0x2)]
    public fun test_event_creation_and_registration(
        host: &signer,
        attendee: &signer
    ) acquires Event {
        // Setup
        create_account_for_test(account::get_address(host));
        create_account_for_test(account::get_address(attendee));
        
        // Create event
        init_event(
            host,
            1, // event_id
            0, // start_time
            100000, // end_time
            100, // max_capacity
            0, // entry_fee
            0, // early_bird_discount
            0 // early_bird_deadline
        );

        // Register attendance
        register_attendance(
            attendee,
            account::get_address(host),
            1, // event_id
            1 // tier
        );

        // Verify
        let event = borrow_global<Event>(account::get_address(host));
        assert!(vector::length(&event.attendees) == 1, 1);
        assert!(*vector::borrow(&event.attendees, 0) == account::get_address(attendee), 2);
    }
}