--神鳥の排撃

--Script by nekrozar
function c101009062.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(101009062,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,101009062+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c101009062.cost)
	e1:SetTarget(c101009062.target)
	e1:SetOperation(c101009062.activate)
	c:RegisterEffect(e1)
	--lvdown
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(101009062,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c101009062.lvtg)
	e2:SetOperation(c101009062.lvop)
	c:RegisterEffect(e2)
end
function c101009062.costfilter(c)
	return c:IsRace(RACE_WINDBEAST) and c:IsDiscardable()
end
function c101009062.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c101009062.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c101009062.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c101009062.thfilter(c)
	return c:GetSequence()<5 and c:IsAbleToHand()
end
function c101009062.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c101009062.thfilter,tp,0,LOCATION_SZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c101009062.thfilter,tp,0,LOCATION_SZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c101009062.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c101009062.thfilter,tp,0,LOCATION_SZONE,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
function c101009062.cffilter(c)
	return c:IsRace(RACE_WINDBEAST) and c:IsLevelAbove(2) and not c:IsPublic()
end
function c101009062.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c101009062.cffilter,tp,LOCATION_HAND,0,1,nil) end
end
function c101009062.lvop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c101009062.cffilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	local sg=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,nil,g:GetFirst():GetCode())
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(-1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=sg:GetNext()
	end
end
