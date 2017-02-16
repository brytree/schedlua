package.path = "../?.lua;"..package.path

Scheduler = require("schedlua.scheduler")()
Task = require("schedlua.task")
local taskID = 0;

local function getNewTaskID()
	taskID = taskID + 1;
	return taskID;
end

local function spawn(scheduler, func, ...)
	local task = Task(func, ...)
	task.TaskID = getNewTaskID();
	Scheduler:scheduleTask(task, {...});
	
	return task;
end


local function task1()
	print("first task, first line")
	Scheduler:yield();
	print("first task, second line")
	Scheduler:yield();
	print("first task, third line")
end

local function task2()
	print("second task, only line")
end

local function task3()
	print("third task, only line")
end

local function main()
	local t1 = spawn(Scheduler, task1)
	local t2 = spawn(Scheduler, task2)
  local t3 = spawn(Scheduler, task3)


	while (true) do
		--print("STATUS: ", t1:getStatus(), t2:getStatus())
		if t1:getStatus() == "dead" and t2:getStatus() == "dead"  and t3:getStatus == "dead" then
			break;
		end
		Scheduler:step()
	end
end

main()

--[[
	Approach is dual: 
	Priority Queue vs Non Priority Queue
	NPQ reduces priority for everything in it every quantum
]]--


