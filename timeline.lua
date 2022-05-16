--[[Baremetal tween copy in there to avoid external dependecy but really compressed]]local tween={_VERSION='tween 2.1.1',_DESCRIPTION='tweening for lua',_URL='https://github.com/kikito/tween.lua',_LICENSE=[[MIT LICENSE Copyright (c) 2014 Enrique García Cota, Yuichi Tateno, Emmanuel Oga]]}local pow,sin,cos,pi,sqrt,abs,asin=math.pow,math.sin,math.cos,math.pi,math.sqrt,math.abs,math.asin local function linear(t,b,c,d)return c*t/d+b end local function inQuad(t,b,c,d)return c*pow(t/d,2)+b end local function outQuad(t,b,c,d)t=t/d return -c*t*(t-2)+b end local function inOutQuad(t,b,c,d)t=t/d*2 if t<1 then return c/2*pow(t, 2)+b end return -c/2*((t-1)*(t-3)-1)+b end local function outInQuad(t,b,c,d)if t<d/2 then return outQuad(t*2,b,c/2,d) end return inQuad((t*2)-d,b+c/2,c/2,d)end local function inCubic (t,b,c,d)return c*pow(t/d,3)+b end local function outCubic(t,b,c,d)return c*(pow(t/d-1,3)+1)+b end local function inOutCubic(t,b,c,d)t=t/d*2 if t<1 then return c/2*t*t*t+b end t=t-2 return c/2*(t*t*t+2)+b end local function outInCubic(t,b,c,d)if t<d/2 then return outCubic(t*2,b,c/2,d) end return inCubic((t*2)-d,b+c/2,c/2,d)end local function inQuart(t,b,c,d)return c*pow(t/d,4)+b end local function outQuart(t,b,c,d)return -c*(pow(t/d-1,4)-1)+b end local function inOutQuart(t,b,c,d)t=t/d*2 if t<1 then return c/2*pow(t,4)+b end return -c/2*(pow(t-2,4)-2)+b end  local function outInQuart(t,b,c,d)if t<d/2 then return outQuart(t*2,b,c/2,d)end return inQuart((t*2)-d,b+c/2,c/2,d)end local function inQuint(t,b,c,d)return c*pow(t/d,5)+b end local function outQuint(t,b,c,d)return c*(pow(t/d-1,5)+1)+b end local function inOutQuint(t,b,c,d)t=t/d*2 if t<1 then return c/2*pow(t,5)+b end return c/2*(pow(t-2,5)+2)+b end  local function outInQuint(t,b,c,d)if t<d/2 then return outQuint(t*2,b,c/2,d)end return inQuint((t*2)-d,b+c/2,c/2,d)end local function inSine(t,b,c,d)return -c*cos(t/d*(pi/2))+c+b end local function outSine(t,b,c,d)return c*sin(t/d*(pi/2))+b end local function inOutSine(t,b,c,d)return -c/2*(cos(pi*t/d)-1)+b end local function outInSine(t,b,c,d)if t<d/2 then return outSine(t*2,b,c/2,d)end return inSine((t*2)-d,b+c/2,c/2,d)end local function inExpo(t,b,c,d)if t==0 then return b end return c*pow(2,10*(t/d-1))+b-c*0.001 end local function outExpo(t,b,c,d)if t==d then return b+c end return c*1.001*(-pow(2,-10*t/d)+1)+b end local function inOutExpo(t,b,c,d)if t==0 then return b end if t==d then return b+c end t=t/d*2 if t<1 then return c/2*pow(2,10*(t-1))+b-c*0.0005 end return c/2*1.0005*(-pow(2,-10*(t-1))+2)+b end local function outInExpo(t,b,c,d)if t<d/2 then return outExpo(t*2,b,c/2,d)end return inExpo((t*2)-d,b+c/2,c/2,d)end local function inCirc(t,b,c,d)return(-c*(sqrt(1-pow(t/d,2))-1)+b)end local function outCirc(t,b,c,d)return(c*sqrt(1-pow(t/d-1,2))+b)end local function inOutCirc(t,b,c,d)t=t/d*2 if t<1 then return -c/2*(sqrt(1-t*t)-1)+b end t=t-2 return c/2*(sqrt(1-t*t)+1)+b end local function outInCirc(t,b,c,d)if t<d/2 then return outCirc(t*2,b,c/2,d)end return inCirc((t*2)-d,b+c/2,c/2,d)end local function calculatePAS(p,a,c,d)p,a=p or d*0.3, a or 0 if a<abs(c)then return p,c,p/4 end return p,a,p/(2*pi)*asin(c/a)end local function inElastic(t,b,c,d,a,p)local s if t==0 then return b end t=t/d if t==1 then return b+c end p,a,s=calculatePAS(p,a,c,d)t=t-1 return -(a*pow(2,10*t)*sin((t*d-s)*(2*pi)/p))+b end local function outElastic(t,b,c,d,a,p)local s if t==0 then return b end t=t/d if t==1 then return b+c end p,a,s=calculatePAS(p,a,c,d)return a*pow(2,-10*t)*sin((t*d-s)*(2*pi)/p)+c+b end local function inOutElastic(t,b,c,d,a,p)local s if t==0 then return b end t=t/d*2 if t==2 then return b+c end p,a,s=calculatePAS(p,a,c,d)t=t-1 if t<0 then return -0.5*(a*pow(2,10*t)*sin((t*d-s)*(2*pi)/p))+b end return a*pow(2,-10*t)*sin((t*d-s)*(2*pi)/p)*0.5+c+b end local function outInElastic(t,b,c,d,a,p)if t<d/2 then return outElastic(t*2,b,c/2,d,a,p)end return inElastic((t*2)-d,b+c/2,c/2,d,a,p)end local function inBack(t,b,c,d,s)s=s or 1.70158 t=t/d return c*t*t*((s+1)*t-s)+b end local function outBack(t,b,c,d,s)s=s or 1.70158 t=t/d-1 return c*(t*t*((s+1)*t+s)+1)+b end local function inOutBack(t,b,c,d,s)s=(s or 1.70158)*1.525 t=t/d*2 if t<1 then return c/2*(t*t*((s+1)*t-s))+b end t=t-2 return c/2*(t*t*((s+1)*t+s)+2)+b end local function outInBack(t,b,c,d,s)if t<d/2 then return outBack(t*2,b,c/2,d,s)end return inBack((t*2)-d,b+c/2,c/2,d,s)end local function outBounce(t,b,c,d)t=t/d if t<1/2.75 then return c*(7.5625*t*t)+b end if t<2/2.75 then t=t-(1.5/2.75)return c*(7.5625*t*t+0.75)+b elseif t<2.5/2.75 then t=t-(2.25/2.75)return c*(7.5625*t*t+0.9375)+b end t=t-(2.625/2.75)return c*(7.5625*t*t+0.984375)+b end local function inBounce(t,b,c,d)return c-outBounce(d-t,0,c,d)+b end  local function inOutBounce(t,b,c,d)if t<d/2 then return inBounce(t*2,0,c,d)*0.5+b end return outBounce(t*2-d,0,c,d)*0.5+c*0.5+b end local function outInBounce(t,b,c,d)if t<d/2 then return outBounce(t*2,b,c/2,d)end return inBounce((t*2)-d,b+c/2,c/2,d)end tween.easing={linear=linear,inQuad=inQuad,outQuad=outQuad,inOutQuad=inOutQuad,outInQuad=outInQuad,inCubic=inCubic,outCubic=outCubic,inOutCubic=inOutCubic,outInCubic=outInCubic,inQuart=inQuart,outQuart=outQuart,inOutQuart=inOutQuart,outInQuart=outInQuart,inQuint=inQuint,outQuint=outQuint,inOutQuint=inOutQuint,outInQuint=outInQuint,inSine=inSine,outSine=outSine,inOutSine=inOutSine,outInSine=outInSine,inExpo=inExpo,outExpo=outExpo,inOutExpo=inOutExpo,outInExpo=outInExpo,inCirc=inCirc,outCirc=outCirc,inOutCirc=inOutCirc,outInCirc=outInCirc,inElastic=inElastic,outElastic=outElastic,inOutElastic=inOutElastic,outInElastic=outInElastic,inBack=inBack,outBack=outBack,inOutBack=inOutBack,outInBack=outInBack,inBounce=inBounce,outBounce=outBounce,inOutBounce=inOutBounce,outInBounce=outInBounce}local function copyTables(destination,keysTable,valuesTable)valuesTable=valuesTable or keysTable local mt = getmetatable(keysTable)if mt and getmetatable(destination)==nil then setmetatable(destination,mt) end for k,v in pairs(keysTable)do if type(v)=='table'then destination[k]=copyTables({},v,valuesTable[k])else destination[k]=valuesTable[k]end end return destination end local function checkSubjectAndTargetRecursively(subject,target,path)path=path or{}local targetType,newPath for k,targetValue in pairs(target)do targetType,newPath=type(targetValue),copyTables({},path) table.insert(newPath,tostring(k)) if targetType=='number'then assert(type(subject[k])=='number',"Parameter '"..table.concat(newPath,'/').."' is missing from subject or isn't a number")elseif targetType=='table'then checkSubjectAndTargetRecursively(subject[k],targetValue,newPath) else assert(targetType=='number',"Parameter '"..table.concat(newPath,'/') .. "' must be a number or table of numbers") end end end local function checkNewParams(duration,subject,target,easing)assert(type(duration)=='number'and duration>0,"duration must be a positive number. Was "..tostring(duration))local tsubject=type(subject)assert(tsubject=='table'or tsubject=='userdata',"subject must be a table or userdata. Was "..tostring(subject))assert(type(target)=='table',"target must be a table. Was "..tostring(target))assert(type(easing)=='function',"easing must be a function. Was "..tostring(easing))checkSubjectAndTargetRecursively(subject,target)end local function getEasingFunction(easing)easing=easing or"linear"if type(easing)=='string'then local name=easing easing = tween.easing[name] if type(easing)~='function'then error("The easing function name '"..name.."' is invalid") end end return easing end local function performEasingOnSubject(subject,target,initial,clock,duration,easing)local t,b,c,d for k,v in pairs(target)do if type(v)=='table'then performEasingOnSubject(subject[k],v,initial[k],clock,duration,easing)else t,b,c,d=clock,initial[k],v-initial[k],duration subject[k]=easing(t,b,c,d)end end end local Tween = {}local Tween_mt = {__index = Tween}function Tween:set(clock)assert(type(clock)=='number',"clock must be a positive number or 0")self.initial=self.initial or copyTables({},self.target,self.subject)self.clock=clock if self.clock<=0 then self.clock=0 copyTables(self.subject,self.initial)elseif self.clock>=self.duration then self.clock=self.duration copyTables(self.subject,self.target)else performEasingOnSubject(self.subject,self.target,self.initial,self.clock,self.duration,self.easing)end return self.clock>=self.duration end function Tween:reset()return self:set(0)end function Tween:update(dt)assert(type(dt)=='number', "dt must be a number")return self:set(self.clock+dt)end function tween.new(duration,subject,target,easing)easing=getEasingFunction(easing)checkNewParams(duration,subject,target,easing)return setmetatable({duration=duration,subject=subject,target=target,easing=easing,clock=0},Tween_mt)end 

--[[now back to bussiness]]
local timeline = {
	_VERSION		 = 'timeline v0.1',
	_DESCRIPTION = 'time dependent event manager',
	_URL = 'https://www.github.com/alejandro-alzate/timeline',
	_LICENSE = [[
		MIT LICENSE

		Copyright (c) 2022 Alejandro Alzate Sánchez

		Permission is hereby granted, free of charge, to any person obtaining a
		copy of this software and associated documentation files (the
		"Software"), to deal in the Software without restriction, including
		without limitation the rights to use, copy, modify, merge, publish,
		distribute, sublicense, and/or sell copies of the Software, and to
		permit persons to whom the Software is furnished to do so, subject to
		the following conditions:

		The above copyright notice and this permission notice shall be included
		in all copies or substantial portions of the Software.

		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
		OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
		MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
		IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
		CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
		TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
		SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	]],
	_CONTRIBUTING = [[
		· Bug reports,
		· Pull requests,
		· Etc.

		Are welcome
		on the github page check timeline._URL
	]],
}

local timeline={}
local tm={}
timeline.verbose = false

function tm.update(self, dt)
	if type(dt) == 'number' then
		self.clock = self.clock + dt
	end
	if self.source then
		if self.source.tell then
			self.clock = self.source:tell()
		end
	end
	for i,v in pairs(self.eventList) do
		self.eventList[i].tween:set(self.clock-v.start)
		v.state = 'empty'
		if self.clock-v.start > 0 then
			v.state = 'alive'
			if v.tween.duration+v.start < self.clock then
				v.state = 'dead'
			end
		end
	end
end

function tm.set(self, v)
	if type(v) == 'number' then
		self.clock = v
	else
		print('[TIMELINE][ERROR   ]: Caught an invalid value in the set method')
	end
end

function tm.reset(self)
	self.clock = 0
	return true
end

function tm.new(self, start, duration, subject, target, easeFunc, relative)
	assert(type(self)=='table', 'This is a method use it in a timeline object: object:method(args)')
	assert(type(start)=='number')
	assert(type(duration)=='number')
	local new={
		start=start,
		duration=duration,
		easeFunc=easeFunc or 'linear',
		subject=subject,
		target=target,
		tween=tween.new(duration, subject, target, easeFunc),
		state='empty',
	}
	if not relative then
		new.duration=start-duration
		new.tween=tween.new(duration, subject, target, easeFunc)
	end
	return table.insert(self.eventList, new)
end

function timeline.newBox(duration) --[[Makes an box where the event will put in]]
	return {
		clock=0,
		duration=duration or 10,
		eventList={},
		update=tm.update,
		set=tm.set,
		reset=tm.reset,
		new=tm.new,
		draw=tm.draw,
		getValue=tm.getValue,
		setDuration=tm.setDuration,
		setVerbosity=tm.setVerbosity,
		attachSource=tm.attachSource,
		detachSource=tm.detachSource,
	},
	true
end

function tm.setVerbosity(self, toggle)
	if toggle == true then
		self.verbose = 1
		return
	end
	if toggle == false then
		self.verbose = 0
		return
	end
	if type(toggle) == 'number' then
		self.verbose = toggle
		return
	end
	self.verbose = 0
end

function tm.setDuration(self, duration)

	self.duration = duration
end

function tm.getValue(self, target)
	for k,v in pairs(self) do
		if k == target then
			return v
		end
	end
	return nil
end

function tm.setValue(self, target, value)
	for k,v in pairs(self) do
		if k==target then
			v = value
		end
	end
end

if love then --[[We are in love! (u gotcha?)]]
	function tm.draw(self, x, y, w, h)
		x = x or 0
		y = y or 0
		w = w or 800
		h = h or 100
		r, g, b, a = love.graphics.getColor()
		if loveframes then
			--TODO loveframes integration
			return
		else
			love.graphics.setColor(0.5, 0.5, 0.5, 0.9)
			love.graphics.rectangle('fill', x, y, w, h, w/32, h/16)
			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.line(0+x, (h/3)+y, w+x, (h/3)+y)
			love.graphics.circle('fill', (((self.clock/self.duration)*w)+5)+x, (h/3)+y, 5)
			local empty = 0
			local dead = 0
			local alive = 0
			local text = 'State of the objects in this point:\n'
			for i,v in ipairs(self.eventList) do
				print(i,v.state)
				if v.state == 'empty' then
					empty = empty + 1
				end
				if v.state == 'dead' then
					dead = dead + 1
				end
				if v.state == 'alive' then
					alive = alive + 1
				end
			end
			text = text..'Running: '..alive..'\tWaiting: '..empty..'\tKilled: '..dead
			love.graphics.print(text, (((self.clock/self.duration)*w)+5)+x, (h/3)+14+y)
			love.graphics.setColor(r, g, b, a)
		end
	end
	function tm.attachSource(self, source)
		if self.source then
			self.clock = 0
			if self.source.stop then
				self.source.stop()
			end
		end
		if type(source)==text then
			self.source = love.audio.newSource(source, stream)
		end
		function self.play(self)
			self.source:play = self.source.play
		end
		function self.stop(self)
			self.source:stop = self.source.stop
		end
		function self.rewind(self)
			self.source:rewind = self.source.rewind
		end
		function self.seek(self)
			self.source:seek = self.source.seek
		end
		function self.tell(self)
			self.source:tell = self.source.tell
		end
	end
	function tm.detachSource(self)
		self.play   = nil
		self.stop   = nil
		self.rewind = nil
		self.seek   = nil
		self.tell   = nil
	end
end

if not love then --[[They don't love us :(]]
	print("[TIMELINE][WARNING]: The interpreter don\'t love us, Because of that some features are disabled")
	print("[TIMELINE]           if you are running LÖVE2D and this seems odd,")
	print("[TIMELINE]           make sure if this is not the main thread do require('love') at the top of the")
	print("[TIMELINE]           script, if is not the case sadly this features are too dependent to LÖVE2D's")
	print("[TIMELINE]           framework and for stability gets disabled, if you are too dissapointed, the")
	print("[TIMELINE]           LÖVE2D's framework is strongly recomended to use.")
end

return timeline