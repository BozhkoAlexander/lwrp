function replaceModel()
	txd = engineLoadTXD('/models/weapons/cuntgun.txd', true)
	engineImportTXD(txd, 357)
	dff = engineLoadDFF('/models/weapons/cuntgun.dff', 357)
	engineReplaceModel(dff, 357)
	
	txd = engineLoadTXD('/models/weapons/sniper.txd', true)
	engineImportTXD(txd, 358)
	dff = engineLoadDFF('/models/weapons/sniper.dff', 358)
	engineReplaceModel(dff, 358)

	txd = engineLoadTXD('/models/weapons/ak47.txd', true)
	engineImportTXD(txd, 355)
	dff = engineLoadDFF('/models/weapons/ak47.dff', 355)
	engineReplaceModel(dff, 355)
	
	txd = engineLoadTXD('/models/weapons/colt45.txd', true)
	engineImportTXD(txd, 346)
	dff = engineLoadDFF('/models/weapons/colt45.dff', 346)
	engineReplaceModel(dff, 346)
	
	txd = engineLoadTXD('/models/weapons/mp5lng.txd', true)
	engineImportTXD(txd, 353)
	dff = engineLoadDFF('/models/weapons/mp5lng.dff', 353)
	engineReplaceModel(dff, 353)
	
	txd = engineLoadTXD('/models/weapons/m4.txd', true)
	engineImportTXD(txd, 356)
	dff = engineLoadDFF('/models/weapons/m4.dff', 356)
	engineReplaceModel(dff, 356)
	
	txd = engineLoadTXD('/models/weapons/tec9.txd', true)
	engineImportTXD(txd, 372)
	dff = engineLoadDFF('/models/weapons/tec9.dff', 372)
	engineReplaceModel(dff, 372)
	
	txd = engineLoadTXD('/models/weapons/micro_uzi.txd', true)
	engineImportTXD(txd, 352)
	dff = engineLoadDFF('/models/weapons/micro_uzi.dff', 352)
	engineReplaceModel(dff, 352)
end
addEventHandler('onClientResourceStart', getResourceRootElement(getThisResource()), replaceModel)