


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
        elevator.move()
 
        elevator.door.status = "opened"
        p "The door is #{elevator.door.status}"
        elevator.door.status = "closed"
        p "The door is #{elevator.door.status}"
    

    end

    def findElevator(requestedFloor, requestedDirection)

        
        if @status == "online"
            @elevatorsList.each do |elevator|   
                if elevator.currentFloor == requestedFloor
                    elevator.floorRequestList.push(requestedFloor)
                    @status = 'busy'
                end    
            end
        end
        if @status == "online"
            @elevatorsList.each do |elevator|   
                if elevator.currentFloor - requestedFloor >= -1 && elevator.currentFloor - requestedFloor <= 1
                    elevator.floorRequestList.push(requestedFloor)
                    @status = 'busy'
                end      
            end
        end
        if @status == "online"
            @elevatorsList.each do |elevator|   
                if elevator.currentFloor - requestedFloor > -2 && elevator.currentFloor - requestedFloor < 2
                    elevator.floorRequestList.push(requestedFloor)
                    @status = 'busy'
                    break
                end    
            end
        end
        if @status == "online"
            @elevatorsList.each do |elevator|   
                if elevator.currentFloor - requestedFloor > -3 && elevator.currentFloor - requestedFloor < 3
                    elevator.floorRequestList.push(requestedFloor)
                    @status = 'busy'
                end  
            end
        end
        if @status == "online"
            @elevatorsList.each do |elevator|   
                if elevator.currentFloor - requestedFloor > -4 && elevator.currentFloor - requestedFloor < 4
                    elevator.floorRequestList.push(requestedFloor)
                    @status = 'busy'
                end  
            end
        end
        if @status == "online"
            @elevatorsList.each do |elevator|   
                if elevator.currentFloor - requestedFloor > -5 && elevator.currentFloor - requestedFloor < 5
                    elevator.floorRequestList.push(requestedFloor)
                    @status = 'busy'
                end 
            end
        end
        if @status == "online"
            @elevatorsList.each do |elevator|   
                if elevator.currentFloor - requestedFloor > -10 && elevator.currentFloor - requestedFloor < 10
                    elevator.floorRequestList.push(requestedFloor)
                    @status = 'busy'
                end  
            end
        end
        if @status == "online"
            @elevatorsList.each do |elevator|   
                if elevator.currentFloor - requestedFloor > -20 && elevator.currentFloor - requestedFloor < 20
                    elevator.floorRequestList.push(requestedFloor)
                    @status = 'busy'
                end 
            end
        end

        @elevatorsList.each do |elevator|
            if elevator.floorRequestList.length > 0
                return elevator
            end
        end

    end

   

end

class Elevator 

    def initialize(_id, _amountOfFloors)
        @ID = _id
        @status = "idle"
        @amountOfFloors = _amountOfFloors
        @direction = "stoped"
        @currentFloor = 1
        @door = Door.new(_id)
        @floorRequestButtonsList = []
        @floorRequestList = []

        self.createFloorRequestButtons(_amountOfFloors)




    end

    attr_accessor :ID
    attr_accessor :status
    attr_accessor :amountOfFloors
    attr_accessor :direction
    attr_accessor :currentFloor
    attr_accessor :door
    attr_accessor :floorRequestButtonsList
    attr_accessor :floorRequestList

    def createFloorRequestButtons(_amountOfFloors)
        buttonFloor = 1
        i = 0
        floorRequestButtonID = 0
        begin 
            i += 1
            floorRequestButton = FloorRequestButton.new(floorRequestButtonID, buttonFloor)
            self.floorRequestButtonsList.push(floorRequestButton)
            buttonFloor += 1
            floorRequestButtonID += 1
        end until i >= _amountOfFloors
    end

    def requestedFloor(floor)
        self.floorRequestList.push(floor)
        self.move()
        self.door.status = "opened"
        p "The door is #{self.door.status}"
        self.door.status = "closed"
        p "The door is #{self.door.status}"
        
    end
        
    

    def move()
        while self.floorRequestList.length > 0 do
            destination = self.floorRequestList[0]
            self.status = "moving"
            if self.currentFloor < destination
                self.direction = "up"
                while self.currentFloor < destination do
                    self.currentFloor = self.currentFloor + 1
                    p "Elevator ##{self.ID} is now at floor #{self.currentFloor}"
                end
            elsif self.currentFloor > destination
                self.direction = "down"
                while self.currentFloor > destination do
                    self.currentFloor =  self.currentFloor - 1
                    p "Elevator ##{self.ID} is now at floor #{self.currentFloor}"
                end
            end
            self.status = "stopped"
            self.floorRequestList.shift()
        end
        self.status = "idle"
     
    end
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
column1.elevatorsList[0].currentFloor = 8
column1.elevatorsList[1].currentFloor = 15


column1.requestElevator(19, "up")
column1.elevatorsList[1].requestedFloor(2)









