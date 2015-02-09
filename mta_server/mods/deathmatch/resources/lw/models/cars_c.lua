function replaceWeapons()
	txd = engineLoadTXD('/models/transporter.txd', true)
	engineImportTXD(txd, 355)
	dff = engineLoadDFF('/models/transporter.dff', 355)
	engineReplaceModel(dff, 355)
end
addEventHandler ( 'onClientResourceStart', getResourceRootElement(getThisResource()), replaceWeapons)