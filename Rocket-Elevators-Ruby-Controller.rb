


class Column


    def initialize(_id, _amountOfFloors, _amountOfElevators)
        @ID = _id
        @status = "online"
        @elevatorsList = []
        @callButtonsList = []
        self.createCallButtons(_amountOfFloors)
        self.createElevators(_amountOfFloors, _amountOfElevators)
    end

    attr_accessor :ID
    attr_accessor :status
    attr_accessor :elevatorsList
    attr_accessor :callButtonsList
    attr_accessor :createCallButtons
    attr_accessor :createElevators

    def createCallButtons(_amountOfFloors)
        buttonFloor = 1
        callButtonID = 1

        i = 0   
        begin
            i += 1
            if buttonFloor < _amountOfFloors
                callButtons = CallButton.new(callButtonID, buttonFloor, "up")
                @callButtonsList.push(callButtons)
                callButtonID += 1   
            end    

            if buttonFloor > 1
                callButtons = CallButton.new(callButtonID, buttonFloor, "down")
                @callButtonsList.push(callButtons)
                callButtonID += 1    
            end    
            buttonFloor += 1
         end until i >= _amountOfFloors  
    end

    def createElevators(_amountOfFloors, _amountOfElevators)
        i = 0
        elevatorID = 1
        begin 
            elevator = Elevator.new(elevatorID, _amountOfFloors)
            @elevatorsList.push(elevator)
            elevatorID += 1
            i += 1

        end until i >= _amountOfElevators
    end    

    def requestElevator(_floor, _direction)
        elevator =  self.findElevator(_floor, _direction)
    end

    def findElevator(requestedFloor, requestedDirection)
        bestElevatorInformation = {
            bestElevator: 0,
            bestScore: 5,
            referenceGap: 10000000,
        }

        

        @elevatorsList.each {
            |elevator| 
            puts elevator
            if requestedFloor == elevator.currentFloor && elevator.status == 'stopped' && requestedDirection == elevator.direction
                bestElevatorInformations = self.checkIfElevatorIsBetter(1, elevator, bestElevatorInformations, requestedFloor)
            elsif requestedFloor > elevator.currentFloor && elevator.direction == 'up' && requestedDirection == elevator.direction
                bestElevatorInformations = self.checkIfElevatorIsBetter(2, elevator, bestElevatorInformations, requestedFloor)
                
            elsif requestedFloor < elevator.currentFloor && elevator.direction == 'down' && requestedDirection == elevator.direction   
                bestElevatorInformations = self.checkIfElevatorIsBetter(2, elevator, bestElevatorInformations, requestedFloor)
                
            elsif elevator.status == 'idle' 
                bestElevatorInformations = self.checkIfElevatorIsBetter(3, elevator, bestElevatorInformations, requestedFloor)
                
            else 
                bestElevatorInformations = self.checkIfElevatorIsBetter(4, elevator, bestElevatorInformations, requestedFloor)
            end    
            return bestElevatorInformations.bestElevator
        }
 

    end

    def checkIfElevatorIsBetter(scoreToCheck, newElevator, bestElevatorInformations, floor)
       
       
        puts "hello"

    end

end

class Elevator 

    def initialize(_id, _amountOfFloors)
        @ID = _id
        @status = "idle"
        @amountOfFloors = _amountOfFloors
        @direction = "null"
        @currentFloor = 1
        @door = Door.new(_id)
        @floorRequestButtonsList = []
        @floorRequestList = []

    end

    attr_accessor :ID
    attr_accessor :status
    attr_accessor :amountOfFloors
    attr_accessor :direction
    attr_accessor :currentFloor
    attr_accessor :door
    attr_accessor :floorRequestButtonsList
    attr_accessor :floorRequestList

end


class CallButton 

    def initialize(_id, _floor, _direction)
        @ID = _id
        @status = "off"
        @floor = _floor
        @direction = _direction
    end

    attr_accessor :ID
    attr_accessor :status
    attr_accessor :floor
    attr_accessor :direction
   

end


class FloorRequestButton 

    def initialize(_id, _floor)
        @ID = _id
        @status = "off"
        @floor = _floor
    end

    attr_accessor :ID
    attr_accessor :status
    attr_accessor :floor

end


class Door 

    def initialize(_id)
        @ID = _id
        @status = "closed"
    end

    attr_accessor :ID
    attr_accessor :status

end



column1 = Column.new(1, 20, 2)

column1.requestElevator(10, "up")



p column1.inspect

