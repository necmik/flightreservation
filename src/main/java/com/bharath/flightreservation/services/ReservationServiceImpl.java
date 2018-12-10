package com.bharath.flightreservation.services;

import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bharath.flightreservation.dto.ReservationRequest;
import com.bharath.flightreservation.entities.Flight;
import com.bharath.flightreservation.entities.Passenger;
import com.bharath.flightreservation.entities.Reservation;
import com.bharath.flightreservation.repos.FlightRepository;
import com.bharath.flightreservation.repos.PassengerRepository;
import com.bharath.flightreservation.repos.ReservationRepository;
import com.bharath.flightreservation.util.EmailUtil;
import com.bharath.flightreservation.util.PDFGeneterator;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Value("${com.bharath.flightreservation.itinerary.dirpath}")
	private String ITINERARY_DIR;

	@Autowired
	FlightRepository flightRepository;
	
	@Autowired
	PassengerRepository passengerRepository;
	
	@Autowired
	ReservationRepository reservationRepository;
	
	@Autowired
	PDFGeneterator pdfGenerator;
	
	@Autowired
	EmailUtil emailUtil;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ReservationServiceImpl.class);
	
	@Override
	@Transactional
	public Reservation bookFlight(ReservationRequest request) {
		LOGGER.info("bookFlight()");
		//Make Payment
		
		Long flightId = request.getFlightId();
		LOGGER.info("fetching flight for flight id:" + flightId);
		Optional<Flight> flightOpt = flightRepository.findById(flightId);
		if (!flightOpt.isPresent()) return null;
		Flight flight = flightOpt.get();
		
		Passenger passenger = new Passenger();
		passenger.setFirstName(request.getPassengerFirstName());
		passenger.setLastName(request.getPassengerLastName());
		passenger.setPhone(request.getPassengerPhone());
		passenger.setEmail(request.getPassengerEmail());
		LOGGER.info("Saving the passenger:" + passenger);
		Passenger savedPassenger = passengerRepository.save(passenger);
		
		Reservation reservation = new Reservation();
		reservation.setFlight(flight);
		reservation.setPassenger(savedPassenger);
		reservation.setCheckedIn(false);
		LOGGER.info("Saving the reservation:" + reservation);
		Reservation savedReservation = reservationRepository.save(reservation);
		
		LOGGER.info("Generating the itinearary");
		String filePath = ITINERARY_DIR+ savedReservation.getId() +".pdf";
		pdfGenerator.generateItenary(savedReservation, filePath);
		LOGGER.info("Emailing the itinearary");
		emailUtil.sendItenarity(passenger.getEmail(), filePath);
		
		return savedReservation;
	}

}
