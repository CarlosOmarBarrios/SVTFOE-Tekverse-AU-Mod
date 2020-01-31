function init()
--	self.active = false
--	self.grabbed = false
--	self.timer = 0
--	self.pressed = false
	self.hold = false;
end

function uninit()
	status.clearPersistentEffects("tekversebright");
--	if self.active then
--		mcontroller.controlFace(nil)
--	end

end

function update(args)
	if args.moves["special1"] and not self.hold then
		self.hold = true;
		if #status.getPersistentEffects("tekversebright") ~= 0 then
			status.clearPersistentEffects("tekversebright");
		else
			if status.overConsumeResource("energy", status.resourceMax("energy")/3) then
				status.setPersistentEffects("tekversebright", {"glow"});
			end
		end
	elseif not args.moves["special1"] then
		self.hold = false;
	end
	
end
--[[
function input(args)
--	if args.moves["special"] == 1 then
--		if not self.pressed then
--			self.pressed = true
--			if not self.active then
--				return "active"
--			else
--				return "inactive"
--			end
--		end
--	else
--		self.pressed = false
--	end
--
--
--	if args.moves["primaryFire"] then
--		return "grab"
--	end
--
--	if args.moves["down"] and mcontroller.onGround() then
--		return "crouch"
--	end
--
--	return nil
end

function update(args)
	if args.moves["special"] == 1 then
		if not self.hold then
			self.hold = true;
			if not self.active then
				self.active = true;
			else
				self.active = false;
			end
		end
	else
		self.hold = false;
	end

	--world.debugText("self.active : "..tostring(self.active),{mcontroller.position()[1]-1,mcontroller.position()[2]-4.5},"green");
	if self.active then
		if not self.hasConsumed then
		    --Math.max is used because of the ather status that makes the resourceMax of energy negative
			self.hasConsumed = status.consumeResource("energy", math.max(status.resourceMax("energy")/5));
		end
		if self.hasConsumed then
			status.addEphemeralEffect("glow");
			--world.debugText("isglowy",{mcontroller.position()[1]-1,mcontroller.position()[2]-3.5},"green");
		elseif not self.hasConsumed then
			self.active = false;
			--world.debugText("isglowy",{mcontroller.position()[1]-1,mcontroller.position()[2]-3.5},"red");
		end
	elseif not self.active then
		self.hasConsumed = false;
		status.removeEphemeralEffect("glow")
		--world.debugText("glowy",{mcontroller.position()[1]-1,mcontroller.position()[2]-3.5},"red");
	end
--	local energyUsagePerSecond = tech.parameter("energyUsagePerSecond")
--	local energyUsage = energyUsagePerSecond * args.dt
--	local usedEnergy = 0
--
--	if not self.active and args.actions["active"] then
--		tech.setToolUsageSuppressed(true)
--		self.active = true
--	elseif self.active and args.actions["inactive"] then
--		tech.setToolUsageSuppressed(false)
--		self.active = false
--	end
--
--	if self.active then
--		local diff = world.distance(tech.aimPosition(), mcontroller.position())
--		local aimAngle = math.atan(diff[2],  diff[1])
--		local flip = aimAngle > math.pi / 2 or aimAngle < -math.pi / 2
--		tech.setAnimationState("glowing", "low")
--		if flip then
--			tech.setFlipped(true)
--			mcontroller.controlFace(-1)
--		else
--			tech.setFlipped(false)
--			mcontroller.controlFace(1)
--		end
--		if args.actions["crouch"] then
--			tech.setAnimationState("glowing", "crouch")
--		end
--	else
--		tech.setAnimationState("glowing", "off")
--		mcontroller.controlFace(nil)
--	end

--	if self.active and args.actions["grab"] and tech.consumeTechEnergy(energyUsage) and self.timer <= 0 then
--		local IDs = world.monsterQuery(tech.aimPosition(),5)
--		table.insert(IDs, world.npcQuery(tech.aimPosition(),5)[1])
--		if IDs[1] ~= nil then
--			world.logInfo(tostring("local pos = {mcontroller.xPosition()+5, mcontroller.yPosition()+5};"))
--			local pos = {mcontroller.xPosition()+5, mcontroller.yPosition()+5};
--			world.logInfo(tostring("world.spawnStagehand(pos , magic)"))
--			world.spawnStagehand(pos , "magic")
--			world.logInfo(tostring("self.stagehandId = world.entityQuery(pos,1)"))
--			self.stagehandId = world.entityQuery(pos,1)
--			world.logInfo("world.logInfo(tostring())")
--			world.logInfo(tostring(self.stagehandId))
--			world.logInfo(tostring("world.sendEntityMessage(self.stagehandId[1], dostuff)"))
--			world.sendEntityMessage(self.stagehandId[1], "dostuff")
--			world.logInfo(tostring("world.sendEntityMessage(self.stagehandId[1], die)"))
--			world.sendEntityMessage(self.stagehandId[1], "die")
--			--world.callScriptedEntity(IDs[1], "mcontroller.setVelocity", velocity)
--			--world.callScriptedEntity(IDs[1], "mcontroller.setGravityEnabled", false)
--			--world.monsterQuery(tech.aimPosition(),3, { callScript = "mcontroller.setVelocity", callScriptArgs = { velocity } })
--			self.grabbed = true
--		else
--			world.monsterQuery(tech.aimPosition(),30, { callScript = "mcontroller.setGravityEnabled", callScriptArgs = { true } })
--			self.grabbed = false
--
--		end
--		tech.setAnimationState("glowing", "low")
--		return energyUsage
--	elseif self.grabbed and (not args.actions["grab"] or tech.consumeTechEnergy(energyUsage)) then
--		self.timer = 1
--		world.monsterQuery(tech.aimPosition(),30, { callScript = "mcontroller.setGravityEnabled", callScriptArgs = { true } })
--		--world.npcQuery(tech.aimPosition(),30, { callScript = "mcontroller.setGravityEnabled", callScriptArgs = { true } })
--		tech.setAnimationState("glowing", "low")
--		self.grabbed = false
--	end
--	self.timer = self.timer - args.dt
--	return 0
end
--]]
