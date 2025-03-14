Return-Path: <linux-nfs+bounces-10618-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB82A61453
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 15:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23BEF1B621A7
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8131FFC66;
	Fri, 14 Mar 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnal.gov header.i=@fnal.gov header.b="vaDN2MKO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SA9PR09CU002.outbound.protection.outlook.com (mail-southcentralusazon11010005.outbound.protection.outlook.com [40.93.193.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDABA1FF7C1
	for <linux-nfs@vger.kernel.org>; Fri, 14 Mar 2025 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964258; cv=fail; b=US2IyNmx4nAHbc/lUM3D26kOUY62uwvnZGY85qGiF28NAmZg7omMvex5cqNp6Og0EAopTfyp5CRQJLYOTld3A0u+jXD1nWT6eMR/UlTCDuIyCU5p7nUwWjhGy1ySTgMWeD42GQ0ca3qxvgqo91PYWVTH4TN0CFderSaAsPVQteI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964258; c=relaxed/simple;
	bh=GQWNtQjMjA5o9iiqpNqwsxXwWsZIUKiO4IOk02jCIEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JY0hnyGpcOL2iXJVkb+aEeQiKGbIzFAzDeEfHwjmPRRFulDqL23PJp96kqJLA/m3OX+0QiPA4TI9ngrpxpsMT5OTkM7U8ePCq5HjIeBM49eUSr5oMNtQBNviKCjvz1EgVnDaEDsa5bAIqy7XSfK1tQrCOEVfrQVIV3MvETo6NKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fnal.gov; spf=pass smtp.mailfrom=fnal.gov; dkim=pass (2048-bit key) header.d=fnal.gov header.i=@fnal.gov header.b=vaDN2MKO; arc=fail smtp.client-ip=40.93.193.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fnal.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnal.gov
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzHYNt78CiUk15kkuSgqRcEquTfKgDjzYs5avtfPLW6XsXpks2JjQFFDu7YldwVcq4OfykaGLaUNLCL/NMQcmiOHgvJ88qY5z26D+KneakLYoXnG2ATNaQcZbvwM3UQdIRXMIL7Z6V+8DTLTNYAw35EpFSGC3hwZ1GcAPs3odMj6hkVH14n5+B0eWDmJjjfCFiGrzZc/zkyMXVHvwcVTlryfnbtKtOC5AbfpFKRalySzp9uvLTwPsOvr+GLl/xm3G3dtQ5a+Bs8VXTOcKbtUQW2y9ryU3c2nmzmZplKmZEXunjLmAATsE2bhBgePJTC3w0/7QNadsMBKqmZnTZpO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQWNtQjMjA5o9iiqpNqwsxXwWsZIUKiO4IOk02jCIEY=;
 b=J26+rbSkOJq0vviVSG9V1oqRSMbGgFk3on681FsGXAwWbzNx0r/oumr6r5XhWsXZcDHVOQP4tv6D4UdKVC9y/Z6YKTCphju8Sp9J0wmvA8S5dvJ/lZsj5jZV6e1M7sSPCqEz/K2oPNL7vxxySphBs7p0jQT0py2rOKiW/UsTS+JEP4D7tKG/TXSyxSzDNkI5dD2+rD9qGP/xPG8Kk9jvvNGU+KcqqGxNPIyj2ENoTODocax6EWdAJX+conANtsuFyOmq2qSkE6aJEAnIYDjhusHWPMglGYf6YT/2gO6PPpiTrgTiOfoSfrN+MvAipxuhlF5Ts+yw6VfnK1wssA09iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fnal.gov; dmarc=pass action=none header.from=fnal.gov;
 dkim=pass header.d=fnal.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fnal.gov; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQWNtQjMjA5o9iiqpNqwsxXwWsZIUKiO4IOk02jCIEY=;
 b=vaDN2MKOGw8PdemF1X9p8KUz4Wb1hbL6tVrDDH3tHIXj4TrnxjYGFYctnAIPRlMGd0pd5Ef/cYP3e+Vs3LpRgszSaEDBWI2fVk00iMDqzA6mf/4olXPyOKM9oH6bbrLE5skhWjTTwcMA5JltF7ql28ZK8+2zQkOxWtVEDp2a77WU/a/WSGVMb71phKQ2cnRfm3p1oc31/enChdDdK5oJptd4zEO1FQzYur1LWG1dsrm6avxIXtd7VqR+N5vO+eHEpqIBFs7tf0MqOCgwGyXgOIyIgqOgCNf6A3FUyM/75p7GRZEJM6/Cc1FX5cPT7VjzuDCwQD1GXuU3uakRth0a+Q==
Received: from PH0PR09MB11599.namprd09.prod.outlook.com (2603:10b6:510:2aa::9)
 by BLAPR09MB6307.namprd09.prod.outlook.com (2603:10b6:208:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 14:57:34 +0000
Received: from PH0PR09MB11599.namprd09.prod.outlook.com
 ([fe80::7c3d:ada9:5944:a121]) by PH0PR09MB11599.namprd09.prod.outlook.com
 ([fe80::7c3d:ada9:5944:a121%3]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 14:57:34 +0000
From: "Andrew J. Romero" <romero@fnal.gov>
To: Scott Mayhew <smayhew@redhat.com>, Benjamin Coddington
	<bcodding@redhat.com>
CC: Steved <steved@redhat.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: RE: GSSPROXY ( for NFS with sec=krb5, krb5i  , krb5p ) is development
 still active or is it being depreciated
Thread-Topic: GSSPROXY ( for NFS with sec=krb5, krb5i  , krb5p ) is
 development still active or is it being depreciated
Thread-Index: AduTpkJL3Z+Uz30mSiOYGbEcxqj6hQAZCTBgADQygwAABSPGAAAAPbog
Date: Fri, 14 Mar 2025 14:57:34 +0000
Message-ID:
 <PH0PR09MB1159944D3ADD4DCBC9D02C298A7D22@PH0PR09MB11599.namprd09.prod.outlook.com>
References:
 <PH0PR09MB115997CF2D7A117949CDDB375A7D02@PH0PR09MB11599.namprd09.prod.outlook.com>
 <PH0PR09MB115990D120B04F28C93F4014CA7D32@PH0PR09MB11599.namprd09.prod.outlook.com>
 <E11151A2-D253-4F26-BB94-5CDA22FEF1B6@redhat.com> <Z9RBEmMDJ_3FtEDq@aion>
In-Reply-To: <Z9RBEmMDJ_3FtEDq@aion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fnal.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR09MB11599:EE_|BLAPR09MB6307:EE_
x-ms-office365-filtering-correlation-id: 973a9f5b-7083-42db-8ebf-08dd63088dd9
x-fermilab-ob: 1
x-fermilab-sender-location: inside
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yis2Y1FCZ050RVBkWlFWKzdQOEZLVksyUG0rdnpKVTZOby9zSXdGUkZQYW9E?=
 =?utf-8?B?THA2T1lEaHkzZkdIU2IwTWREQVBiTnF3eUIrS1NVbjFGM0xJUG9ic2hoNWRT?=
 =?utf-8?B?TnQ5am5ETGxUTkZRZlVwM0s4OXlyejBZSHlYbTVEM0ZKQ2c0VXlqbHdIWUVj?=
 =?utf-8?B?VnZ1NW56a2lQaGkxUkJ0WGljNGMxcm9vTVErdEVQK3FtcjJWaHJ2c28xMWpk?=
 =?utf-8?B?YVdlRVVjbndUQ2RFeE5NQ1R2U0pjSnJzeEpyOThNblh3OFh3Zkxab3NnYUtR?=
 =?utf-8?B?UDk3Y0dhZmwxR0grdUxudG5UU1dmbXc1NDlOZzhhYjRBVU1YcjZkRHppZVBX?=
 =?utf-8?B?VzNUb09nUjlSRHg5Z3N4MitZYUJwZFYzelNxSlE4NkpHR3ZKUUFESGc3SU5j?=
 =?utf-8?B?K1YraW55ZVkrRHlQR1JjRWY0dCthWkM2bG5nMmNIc3d0ZDk4TlZRSEtjMXJH?=
 =?utf-8?B?aDFyeDJ6eEpvSEtDSUFxRjdVWmZRU1RxTExvSXNhdkZGVDVWV3RSeWFoeFpz?=
 =?utf-8?B?SW0rZ2kwZTlQbU5WaFRxbDFSbSt0enZ1N2duZ09lT2V4UWsyazJvY2ZPWFJE?=
 =?utf-8?B?WlFpNHJXcG9WcDJFUGlVWEpXSUNrSkVsZFBRL0x4Yi9wVDhsTDhIeVM2QVF2?=
 =?utf-8?B?b3BCQk9YekRCS1diVlFTV09uNmsvZjVFcTB5VVJwUFgzbW1ZTWsvTW4vSGUv?=
 =?utf-8?B?eWttcjB0QTNQQU41cWZibFM2OVduTFc2cHJuVTVJZUt0SElJRktabWM0c0pN?=
 =?utf-8?B?bThueDNSS01Ccm1HcVN3a2ZlOWsvYkk3M0NDbit1QjRSUjlWcWV5aWNFNTBh?=
 =?utf-8?B?d2VONVgybElBT1JjdHN3TkZNTWhITzhaN3RFWHI4b3cxM2ZXWmVhclJDNHdX?=
 =?utf-8?B?V0RVU2JwRlVkYkg2aDJtVmlVdndHQzFZR3Y2RWNka1Jhckw0NS9rOG9DL0tY?=
 =?utf-8?B?Q21VTXhhMXY3eUhkRnhxM2dYb2xTN3d0dzY2dlgrTGMzZTBVQXJOUEI0Znpu?=
 =?utf-8?B?R0taMFk5eFVmWWs3ODQzV2pZT0VIb3c3bnFqQVYyMWhBWm9td3RJZ3dyb0lp?=
 =?utf-8?B?NDdxeHVDVTJXYXVFSVR1TncwWnBwb2xjMnZ6eEdPamtUUVBZWnFhZWk5dUNN?=
 =?utf-8?B?aDdtM2UxVWdNd0R1bktIWDRpOHY2SHp3c0x5TDRrOEx4bE8wbVg4eVRxY0s3?=
 =?utf-8?B?M1c4ZUVCTXlSb3kycytiWjhGRi9QZkZQR1RONGlvdHRZNEE1MDZPNzM4Z1N5?=
 =?utf-8?B?MmlITzJsUnhMTmFxZFZyOUtHQVdpRzE3eHo4ZkFnTTdYaFJFK05ueUVPR3Vj?=
 =?utf-8?B?ZUEzSzVNTzhJbXVjK1REaC9ud0lQWEt2ZXVZNjFzczNVQlUzclF1K2lQYjQw?=
 =?utf-8?B?NFdNa2hFdy94QlJFMjZ4T05ibDNSamhpa2VPeXVXM1VEcE9mN2owQk5UMTA3?=
 =?utf-8?B?aUgxRXNUblJWN0pNNkhRWVJLbW14WHNqSFhpY0Z3QzNJSXMxSjRqL1JNZDMx?=
 =?utf-8?B?WEhuVysyb3ZJZGxpdE5KVkpEK0VwTitwbGtKYkp5cUdRVmEwQ0Z3R0tmdm10?=
 =?utf-8?B?RlhYN2IrUDRnSG9EK2V4QTMyTTZqTjhqLzh4d3BhMVFscU1FbmQyWDJNb2cy?=
 =?utf-8?B?RENuWUpZRVo4Nm9keUM1OUdVZkRETGlseGNyMG1EMDdTNjRXczJuYmlwL2o4?=
 =?utf-8?B?UjcvaUlhaDdtKy9NcHpEanhlazBReGVveFJqR3M3Nnpib3JMSTJiYldvVnpq?=
 =?utf-8?B?RE84aFpHUnlaaFp1Q2NzMkxkczdJN2JqdUVRVERzbUpNT2Z6TFNxZWxoU1E5?=
 =?utf-8?B?TXRjd2IyanIxT1VNRXdNaVVEemdGaW1YMHkzSGM2RFRJOXBnMlE2UktLMkgx?=
 =?utf-8?B?Vi9iUE1rSE5BcVp5QTVWNXJKZ0FwcEtWR255UWVnd2pUekZmWlgrc095cUFa?=
 =?utf-8?Q?+iFl+u+DRyc7vRhfxoiaODNVC7XKER0w?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR09MB11599.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZklNUVVFM211UjZLaTVkTEMzbmRKK1Q1dmZiMCsxanpYUDJPMkV1eG9CcVN5?=
 =?utf-8?B?MFhUTThUdWNkR0ZxWi8zWWVSZHBNSnN3cUpZZVdIdjhlZys2cXR4L0lackRF?=
 =?utf-8?B?UC9KZEhlQ3N6NUpOK3VuS2JUVFlvRTVoWDZQaFdFRWFTTGpmenlxbGpvN3pM?=
 =?utf-8?B?VTBYeWxHNWExMVY1K0E3c1l0Skc1Z2pmT3B1eVh0ZXBrMnl0NFY4RkF0L0FR?=
 =?utf-8?B?SldxbnlIZnh5N1d5RitQTWhXWTNLVGp4K0ZFeGdwOGRHRCtRUllWUVJDWC9X?=
 =?utf-8?B?RTlNb3Zsb2tTcStiT1JtWHptcnorYm4veEhYQlRqRlpPZW9leHlPRGZtSXRx?=
 =?utf-8?B?aTZKMGFoVHpqYlQ4QUZYUGRTK0d2UVRmZERsSWE2Nm9md2xzQURWTVEvWkg0?=
 =?utf-8?B?TXpXWldRTU5ZVXN6bks5QkNvRU5udkh0cTdpbEk2cm4zQWlXQ29yRDZrL25x?=
 =?utf-8?B?aUZnRVpncEFTYWtDdnN6akE3R0FrVW1lRGlSN2ptd1lYRGJpSzdoZ2swMHBO?=
 =?utf-8?B?MmZUS2xVV053WGJBeVorZW1IbjBEb2J3NFZwVnY5cXFTemZLZ1QvMVhSNzlJ?=
 =?utf-8?B?Zk5YSEU4MnZCQ0JxY0ZyNVBESmhXRjR1UGlXTFdpOUZyNzNnejNkWTFDOFIv?=
 =?utf-8?B?bUFPQWxKeG1UcHJ5WlNPWFBGU2JiYXJZTkpQS3Nrci9idk1HcGZyL1M5RXYy?=
 =?utf-8?B?UEdxTjFqTHduRUJldUNvZW54T2xqTW9rYnpzZmtSQnMxRlVzOTFLZTN0T1FR?=
 =?utf-8?B?aGVIWUNoNFZKMzZITDJoMXRvL08wS0Q2SzVDdUcwL25YSkg5MmNvZ2doclNl?=
 =?utf-8?B?TzFid3NzSWpjQ2NSRU1teG9RYytqOXNTeXdReWdlZnlQWlZGVlhBNnNqSVl6?=
 =?utf-8?B?bWxnd215NXozSmg1K2g2WSs1TW5jcGIyNDg3amhIUWJZWXVCU05xbUZ2ZmJR?=
 =?utf-8?B?cXg1cjJMNnR4bjNmUmptUEdDQ1ZKOFBEYyt2U1paUS9ZN1FlZmdkM0haWG12?=
 =?utf-8?B?UmdaWStTMjE3VUNYVzlreW1QU1NVZTJLZTdBTjd2RXRJOEF5MGdrLzI5VWV4?=
 =?utf-8?B?N05PVCtGV0t4Y2dZVU9EeWxQUUphSkNqekJEelNzK2tKbWV1RjVMaFplL2xK?=
 =?utf-8?B?S1ZrdEV3TWs2ZFhTZzU3ZS9jSkxSUDB0S20reG13VUJlSSs2MHJIb05pbTBR?=
 =?utf-8?B?bHhtT2tTSWk3aEVUa1hQT1Rzd1RnaUxjRVEzR2tPbHNVbGh2UlZhaGZmVVBH?=
 =?utf-8?B?dWNGbm1VaXg3YnFya0Nib3Nib1FDUFdFRXRVUlpzcWZOdTBlZTkwVVZaeDhR?=
 =?utf-8?B?Mm9tZ0IyajZ6cmloNW05T1BOSjJvTldGdTJlT05lcGV3NXZSaDE3WTVMSUVC?=
 =?utf-8?B?N3JLUk5qK3l6azVJU0RaRjFKaEQyNExaa3ByckUvMy9zd2puMDdqNEJZOEhu?=
 =?utf-8?B?NXc1cERYUlUyZTlrL051S1hGYVR1MTN3M0RHdUFpUW9ta2NPdXM1RXYvMG02?=
 =?utf-8?B?VFhHcXhqT2RLVll4QWRXendvZTNIMTh6LzVOcU9EdHQvVlJHaHMybTc5SUFF?=
 =?utf-8?B?WDBHN0UzYk5xLzhXTWM5aW5JMmVCazdZbG5EWmhlQTMvYll0bkdPTUp0TUs5?=
 =?utf-8?B?TWlOWGViMHNUUHMraHdsMHlxazd2UWZGSjBKeFl6NzR6RHorZHNhMXFQb2sy?=
 =?utf-8?B?M0NUYWwwaG1UTWdyUm80Y1hBb2dPODVCNUp0bEFTZFBmMzhDbTdyTWF5WGNi?=
 =?utf-8?B?Ny9ZbDhEajgwNSswQVRIR3FyQlNTajRhN2RFVlFjQkNibmYxNjdmaVdtRVdn?=
 =?utf-8?B?UnB3a1dvS2dQUGYyYzc5R0IxZUpqWU9WM1R2TGVHdytkRnlxUWgwR2ZUbGRz?=
 =?utf-8?B?M2FQTjR1dnJkTDZVSmVtTC94SXFBTGFpZmtnVFl3VVk1bjQ5MHQ5UmFGMXJZ?=
 =?utf-8?B?ejBNQnlST3I5emtUVUFTZ2d6S0F3c0hOc0dQRnRPODNYU3R2NEpLM1g4bVp1?=
 =?utf-8?B?dHRCbFBmL3RBUmxYZ2plMXp2K1RmcXRsbzhJOEZYSWllNllaZ3VxcmZTd1B0?=
 =?utf-8?B?M0g1S2N3TXJ4TExCdlpQS0MrS3N4ZitMVi9FUWNsTlhWOVVyZExyeU1aeFFn?=
 =?utf-8?B?dkErd1NJcDgyM2NsUExpbldBZ1FmTmttbG9SRkZzdjVraU45YS9Na0YwQVla?=
 =?utf-8?Q?CnV/w4khth2thli4p20L9YR4HxoUguUytaAUEKgMSGr8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fnal.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR09MB11599.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973a9f5b-7083-42db-8ebf-08dd63088dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 14:57:34.6660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d5f83d3-d338-4fd3-b1c9-b7d94d70255a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR09MB6307

DQoNCj4gRnJvbTogU2NvdHQgTWF5aGV3IDxzbWF5aGV3QHJlZGhhdC5jb20+DQo+IA0KPiBBbmRy
ZXcgLSBjYW4geW91IHByb3ZpZGUgYSBzcGVjaWZpYyBSSEVMIHBhY2thZ2UgdmVyc2lvbiB3aGVy
ZSB5b3Ugc2F3IHRoaXMNCj4gZG9jdW1lbnRlZCBpbiBnc3NkLm1hbiAob24gdGhlIG9mZiBjaGFu
Z2UgSSBtaXNzZWQgc29tZXRoaW5nKT8NCj4gDQoNCkhpIFNjb3R0DQoNCkl0IHdhcyBhIHdoaWxl
IGFnbyB3aGVuIHdlIHdyb3RlIG91ciBpbnRlcm5hbCBwcm9jZWR1cmVzLg0KSSB0aG91Z2h0IEkg
bGVhcm5lZCBvZiB0aGUgc2V0dGluZyB1c2UtZ3NzLXByb3h5PXllcyAgZnJvbQ0KVGhlIG1hbiBw
YWdlOyBob3dldmVyLCBJIG1heSBoYXZlIGxlYXJuZWQgdGhpcyBmcm9tIGFub3RoZXIgc291cmNl
DQooIGdzc3Byb3h5IGRvY3Mgb24gZ2l0aHViID8gKSBteSBtZW1vcnkgaXMgYmx1cnJ5IC4uLg0K
DQo+IEVpdGhlciB3YXksIEkgYWdyZWUgdGhpcyBzaG91bGQgYmUgZG9jdW1lbnRlZC4NCg0KV2Ug
Ym90aCBhZ3JlZSBvbiB0aGlzIA0KDQpUaGFua3MgIQ0KDQpBbmR5IFJvbWVybw0KDQo=

