--千年の啓示

--Scripted by mallu11
function c100424006.initial_effect(c)
	aux.AddCodeList(c,10000010)
	--activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100424006,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1,100424006)
	e1:SetCost(c100424006.thcost)
	e1:SetTarget(c100424006.thtg)
	e1:SetOperation(c100424006.thop)
	c:RegisterEffect(e1)
	--Reborn
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100424006,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,100424106)
	e2:SetCondition(c100424006.rbcon)
	e2:SetCost(c100424006.rbcost)
	e2:SetTarget(c100424006.rbtg)
	e2:SetOperation(c100424006.rbop)
	c:RegisterEffect(e2)
end
function c100424006.costfilter(c)
	return c:IsRace(RACE_DIVINE) and c:IsAbleToGraveAsCost()
end
function c100424006.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100424006.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100424006.costfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c100424006.thfilter(c)
	return c:IsCode(83764718) and c:IsAbleToHand()
end
function c100424006.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100424006.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c100424006.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c100424006.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c100424006.rbcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsStatus(STATUS_EFFECT_ENABLED)
end
function c100424006.rbcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() end
	Duel.SendtoGrave(c,REASON_COST)
end
function c100424006.rbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,100424006)==0 end
end
function c100424006.rbop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,100424006)~=0 then return end
	local c=e:GetHandler()
	--rebirth
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(41044418)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetCondition(c100424006.tgcon)
	e2:SetOperation(c100424006.tgop)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	Duel.RegisterFlagEffect(tp,100424006,RESET_PHASE+PHASE_END,0,1)
end
function c100424006.tgfilter(c)
	return c:IsFaceup() and c:IsCode(10000010) and c:IsSummonType(SUMMON_TYPE_SPECIAL+200)
end
function c100424006.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100424006.tgfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c100424006.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c100424006.tgfilter,tp,LOCATION_MZONE,0,nil)
	Duel.HintSelection(g)
	Duel.SendtoGrave(g,REASON_RULE)
end
