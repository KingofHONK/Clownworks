/obj/item/weapon/storage/wallet
	name = "wallet"
	desc = "It can hold a few small and personal things."
	storage_slots = 20
	icon = 'icons/obj/wallet.dmi'
	icon_state = "wallet"
	w_class = W_CLASS_SMALL
	use_to_pickup = TRUE
	autoignition_temperature = AUTOIGNITION_ORGANIC //leather
	can_only_hold = list(
		"/obj/item/weapon/spacecash",
		"/obj/item/weapon/card",
		"/obj/item/clothing/mask/cigarette",
		"/obj/item/device/flashlight/pen",
		"/obj/item/seeds",
		"/obj/item/stack/medical",
		"/obj/item/toy/crayon",
		"/obj/item/weapon/coin",
		"/obj/item/weapon/reagent_containers/food/snacks/customizable/candy/coin",
		"/obj/item/weapon/reagent_containers/food/snacks/chococoin",
		"/obj/item/weapon/dice",
		"/obj/item/weapon/disk",
		"/obj/item/weapon/implanter",
		"/obj/item/weapon/lighter",
		"/obj/item/weapon/match",
		"/obj/item/weapon/paper",
		"/obj/item/weapon/pen",
		"/obj/item/weapon/photo",
		"/obj/item/weapon/reagent_containers/dropper",
		"/obj/item/tool/screwdriver",
		"/obj/item/blueprints/construction_permit",
		"/obj/item/weapon/stamp")
	slot_flags = SLOT_ID|SLOT_BELT
	quick_equip_priority = list(slot_wear_id)

	var/obj/item/weapon/card/id/front_id = null


/obj/item/weapon/storage/wallet/remove_from_storage(obj/item/W as obj, atom/new_location, var/force = 0, var/refresh = 1)
	. = ..(W, new_location)
	if(.)
		if(W == front_id)
			front_id = null
			update_icon()

/obj/item/weapon/storage/wallet/handle_item_insertion(obj/item/W as obj, prevent_warning = 0)
	. = ..(W, prevent_warning)
	if(.)
		if(!front_id && istype(W, /obj/item/weapon/card/id))
			front_id = W
			update_icon()

/obj/item/weapon/storage/wallet/update_icon()
	if(front_id)
		icon_state = "walletid_[front_id.icon_state]"
	else
		icon_state = "wallet"


/obj/item/weapon/storage/wallet/GetID()
	return front_id

/obj/item/weapon/storage/wallet/get_owner_name_from_ID()
	if(front_id)
		return front_id.get_owner_name_from_ID()
	return ..()

/obj/item/weapon/storage/wallet/GetAccess()
	var/obj/item/I = GetID()
	if(I)
		return I.GetAccess()
	else
		return ..()



/obj/item/weapon/storage/wallet/random/New()
	..()
	var/item1_type = pick(/obj/item/weapon/spacecash,
		/obj/item/weapon/spacecash/c10,
		/obj/item/weapon/spacecash/c100,
		/obj/item/weapon/spacecash/c1000)
	var/item2_type
	if(prob(50))
		item2_type = pick(/obj/item/weapon/spacecash,
		/obj/item/weapon/spacecash/c10,
		/obj/item/weapon/spacecash/c100,
		/obj/item/weapon/spacecash/c1000)
	var/item3_type = pick( /obj/item/weapon/coin/silver, /obj/item/weapon/coin/silver, /obj/item/weapon/coin/gold, /obj/item/weapon/coin/iron, /obj/item/weapon/coin/iron, /obj/item/weapon/coin/iron )

	spawn(2)
		if(item1_type)
			new item1_type(src)
		if(item2_type)
			new item2_type(src)
		if(item3_type)
			new item3_type(src)

/obj/item/weapon/storage/wallet/trader/New()
	..()
	dispense_cash(rand(150,250),src)

/obj/item/weapon/storage/wallet/nt
	icon_state = "wallet-NT"

/obj/item/weapon/storage/wallet/nt/update_icon()
	return
