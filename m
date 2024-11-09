Return-Path: <linux-nfs+bounces-7812-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A049C2886
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 01:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD1B2855D5
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58027647;
	Sat,  9 Nov 2024 00:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="ecgp3C9m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD338B
	for <linux-nfs@vger.kernel.org>; Sat,  9 Nov 2024 00:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731110588; cv=fail; b=lHZeSYXqNBCqlLjBew/qjHfvBIPK7t2rUjPiC1QkDN5YweesJVsvRk3f5Ag4Hdmg4+eSEpiyFuQytk++4xIiXD4KI63ISJw1vElp3Znc8njJOvfgaGu78UvcYFB7CeTOl8c2mblhJY+OggXtTWqFiqWRVcEnCQMdUego+J5gapU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731110588; c=relaxed/simple;
	bh=15shKohuaD2312rVr8KiG216XwkNX5+TPVZJS2vGfSo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q+HXPKgCeTL47LNc3d4YBPq7+VAIY+rR4f7y114CjOpH1CE6DUh7MANuH+jmOBAq8unsFiIcuHuTw44aCc7s2rUHonSKshCfBvdbX1BRlErxexXMuDC4SgyPGzg7J5D4b4ngYz9CfGZ+PMYsnckV8xveMzDS2X1E+VlNXE7mGK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=ecgp3C9m; arc=fail smtp.client-ip=40.107.220.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VH2fEBlETUEDFCOYCEnXoNQcEzJ2CWg0nYs8jLyoVmz2p01FFJs6R69Mfa7YBc40AOT7Ukkd9gO/fWUNuoFpMwpd5P2SAwMAgIm0K+/3jaFh03QqTlMCXzx6Y/xOcnQ8EiS/Fc1X4bzjHj0JXe3KoM4fwuX6ZmytbJ7RjA8EFaND82+z8E8fqDrlF+ymO6x0/k7B+Jmuvb8+e4+3VKUFio/EJb4G999KDJBR7rkQ5Kk7sUf9xl36BeXeK+nBYYp5KOCdQbuNdQgxWLjeHuvkin13J/LO6hUJNWAX4RqkhUqQVT+7ojnRZvdVsas/hzpmyxr6NzdF+76eeykUBYEoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15shKohuaD2312rVr8KiG216XwkNX5+TPVZJS2vGfSo=;
 b=uQVx7Kw7xdpfkvXXTJh/dsybRWcrzBImLIgbWo+iZ15dgy2/AJcimPgZQxmdcgOT2sRuMcIWeq+wKlqScRP+E0VSdovtrgHNVvNZGHz6y3Vu5U4ZIlwEBH4uukd9vrkQvqwrYQ2Z13al/dcmSD8yopI5AGGpmIbQGKmLdqKxCAUiNDzxm0AF4nDnCC1Pv2ta+7YU3gSC+ZOkDDTOW8ic6Ff3ww2RxdomNsXAiLogL9QklppMTq5hcdoo7DFKgRHv8/sBphaivaof56iIVdmm4/Ts00kNFkGs0cCr/juQ4Y32RY/dk2ChxrXE48Bcxrlx13gpK8ZP3VyPFtOsb1hyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15shKohuaD2312rVr8KiG216XwkNX5+TPVZJS2vGfSo=;
 b=ecgp3C9m7uSbPP3U3qsLIPSOdj/dJlKTI40iALm1sr2NblYzHPUB611/Dmtncr2L9FwaROfZI91bH7KsuhVAVlwQJbl2fPGIcj0qVmUYpyWVyOkr7Z+SKt1Qox6asEJ75vCPnug/BwEo62Em/OrMtGrvZ0qLff4GC+p6CyZGevg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO6PR13MB5353.namprd13.prod.outlook.com (2603:10b6:303:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Sat, 9 Nov
 2024 00:03:03 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%5]) with mapi id 15.20.8137.019; Sat, 9 Nov 2024
 00:03:03 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "dai.ngo@oracle.com" <dai.ngo@oracle.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: extremely long cl_tasks list
Thread-Topic: extremely long cl_tasks list
Thread-Index: AQHbMjTdaR2jMP9inU+XdmfB6qYQoLKuERGA
Date: Sat, 9 Nov 2024 00:03:02 +0000
Message-ID: <c278cba3f388eafa578f82dfddb219ddbdd8c01b.camel@hammerspace.com>
References: <7536acf7-da4d-45c9-8e29-f72300bfd098@oracle.com>
In-Reply-To: <7536acf7-da4d-45c9-8e29-f72300bfd098@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO6PR13MB5353:EE_
x-ms-office365-filtering-correlation-id: d9c9e683-08b0-43d9-588d-08dd0051e14a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TktqUHRjU0Q0YWFING1qMlJ5Z1FHSXZ0UEtsU2hZUTV2SWM1WXVnQWQvd1Uv?=
 =?utf-8?B?bTMyUytxbkJrRGlXK3VZemppdVRUdXR5ckxCeXYxTk1iN0xZTDRFbHhieWpB?=
 =?utf-8?B?QlJ2am5Ka1N0a2JEU2ZzRUtVVGNZOVVnL3RoNkc2S2o1SWJrL2lUbThJaXow?=
 =?utf-8?B?TmZSZUVWSHZETTJGMmJmSDkvSmlIeEtxb0kzZitnek5zY0xiQXlIRk15RFVw?=
 =?utf-8?B?RzJSd0xmL1ltMUNLb3ZFVFY2ZE5YdlpBYzhzK2ltZWRhVjBjb2srR2lNcUt5?=
 =?utf-8?B?ZmRrYmNTWGRSZUwvS1J2WFJXZURiRVFuRlN5VnpmL0M1RW1VUmp6UEpKbGs1?=
 =?utf-8?B?a1NEOVFOcVBoL3JsRmNxaFRrdGMxdEptV2d4ZllOdDdNdmlJRFhXY0YxaUdr?=
 =?utf-8?B?cE1mWEg4YVdxam91bkRlazFDbUxxcGxGdFNrd3hiOFNXQVlkM0xydFUxYzhx?=
 =?utf-8?B?aVRzZkFGVEZnUTdJNHdiWWVGczJ4TEtsRkYwNTlWS0lXZGM2bTM5MUFzT0NU?=
 =?utf-8?B?Y1ZBTHhzVHVLR3QxMk1TbTcrOWN3V2RndG5lZWdmSnhYZGlESzE2M2JpNE5q?=
 =?utf-8?B?dFM5VWlpaXo3VTNEVTZ6THI1MmZZVUJ6dTV4eThYRmtydE82N1J6RjRkNzE1?=
 =?utf-8?B?Ym5ZMFlLKzZtVGQ2bUcrVXRRdmluUllHczRUMThJVzBZcW05TW5QYmJvTmtR?=
 =?utf-8?B?Wm5FcHRRckNhd0QwMEhxQzNXdjhNNVVPUTFISUJWMlZxaUQ5aUhSZ1dPY2xO?=
 =?utf-8?B?bndMakNnNmpGaXRXVjYxNnBlWGRsRkJDckhMMHFELzF6N3FlU1d0R2NNbllu?=
 =?utf-8?B?RVFGMGRSUDBaRTcrNzI0Q2FBUWtZOVpqZlR6KzlZcUFlYW5DNzZtZ2R1U1Jz?=
 =?utf-8?B?Rjg0YWVWenNMSTF6aHNieldQd3BHczh1eDYyS2ZLWTkzaUhxdXpYSzF3b2JH?=
 =?utf-8?B?YmhYSXdSaStNRzA1UTdyeUhiOFFZVnhNbk9rYW1xRWpzYmhyTXpkVlVMQVEy?=
 =?utf-8?B?SU4wQkJNVllPRWNML2QxWlQwQ1ZYazNaSFFWSTJOTmU3cHJwdzR2RWhTdkE4?=
 =?utf-8?B?V1h0TG5WUGg5SFNVUXlRU1poMGE0b2tNWnBxQi9MSlVOUGQ1S2NJL1o0RHYz?=
 =?utf-8?B?UXNzcUZGSkliNERCQ3I0VVlxRk5wUDlTMnJTS0dNdVFhY0huR0ZrUWd4YzVo?=
 =?utf-8?B?djZXWWlLS0VYNjhpNWxPSG9uTU40VTdwMTNMRjNiWFloYXdDb21DVTNsNmdY?=
 =?utf-8?B?cTEzd25TdlNFaGFBLzNrdmtHVzVxYndET2RsQVlvSlJTNVlLVkkrYkx2U2pu?=
 =?utf-8?B?eHYybkRtN3gyd09mSWFabmpyWmhUbEVvOVJTU2tnRWkrZEdwc2FyWGlhUlQz?=
 =?utf-8?B?Q0RHdm9ha25sUGVjNHhSSlNPZGZBcVp5Z3FVcEpHYVE3OWRiSFN1ZTh0cHpl?=
 =?utf-8?B?bXpRZnczejZ3VTFMVFprdEswS2RyTHpFMFR3UWJkd25ZMUlmNVdMMUMycVc4?=
 =?utf-8?B?OUZUTHNibGI2enpzb21hWmRzaCtnSVdjQTJBOVA2Y3VvNk14OGFpTW0ySmVp?=
 =?utf-8?B?YTNFVURYL2Q2OXJUK2FrZFpmb1FjUkgzd3VOMUVhY2FjdmhXTDVGcHVhWjNY?=
 =?utf-8?B?Ynk1aEdMS1QzdEdVbmxOK0VtNi82WXkybU12VmZiUmVVaFVjTStIMnRnY3Qy?=
 =?utf-8?B?czVHVDVLSklkK0JXdGRrQjZSN1puQ2xzWVRWSUtaenRYdXJ6MzVod1NmYWNG?=
 =?utf-8?B?OCtvL1czMEszZVp3NGxzVVZPQ0o2M2lYOTM3cHNxVzBHUGdVQTU0OW9aaHlq?=
 =?utf-8?Q?Dv51OvyhXFQ+Le+TgjYmY4CjYAzxvRnql10To=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXBrTUp0ZVNuRCtSTmNpcDhTSVc1Z09aVWkrU1ZWVStyMXRYMnlWdTZ2Yzd2?=
 =?utf-8?B?NmVmeVE5ek50T2tMd3BueHJlbWoxSTlkOWtqRjJzaWIyMWkzV0pyVTh5dXYv?=
 =?utf-8?B?TWhvSkgvZjhMc3oyWXpxRHlMY24yUXlGT3dFVnNaQzRrandIdmRkU0dHWEMw?=
 =?utf-8?B?eFhrK1pBd096a25OZzB4Z2xYczJDcGJuYWUrTXFVSjNJOHhIcEFhdTlXbmti?=
 =?utf-8?B?T0h6b0pPaFA0MUNSU3pncERWaXVyQzlDb3B0b2ZUeDRSZ3RrWGN2WUV6Uzhv?=
 =?utf-8?B?UFhvZWRJbXFGc2FiL0c4bis0SGNSU0E3VkxtRnE4dFVlTTBkQXZOVUpuUVFx?=
 =?utf-8?B?Vkp2UUs4bFMwSkpLZXBIWWpzNmRFYkNTU2szSzZ0cG85bHNtVGxZMXIrbHNS?=
 =?utf-8?B?bFdHZXVKa0hEUXVrR1ZWSDkrbFlkY1gySVFHZWtHTXcwYWtiTnlrS2pRWnMy?=
 =?utf-8?B?UllJbUk4QkY2clo1U3BmMHpqRlUva3pMcEFDN1h4Y01FWEdnVWtaSXA3blZE?=
 =?utf-8?B?cnFuSC9IN1g0L3pRWFpOWEJDelM5azJVWlNLN2dsbm1xdENXT2VaSnVtaHBz?=
 =?utf-8?B?ZzZFR3UzU3FweGR6T3N3a2psR05KSXN0dDNtdVNXNXpPenZPYlU1d1lWSzFv?=
 =?utf-8?B?VktzV0Z3NFFRRW05TkdaOWhCd29tNis1M0x6cEI2L2xkZ1g4Qm5XV2Ivcmd3?=
 =?utf-8?B?cVVJRmd4WVNsQjNiMVRUU1JvTnpWbWhHNU1Hd1dPMS95bjZHUVB3WnNFVnox?=
 =?utf-8?B?RmwzVXptTEM2aVEydy9KSG9ySFRQZ3l2SDVCSHdkUEVlUVpoNG5neklwYkUx?=
 =?utf-8?B?NTY0WkFVZ3I5REwzZGZQZ3N0MG9DRTFvc3JlbE54K09pNTQrSVZtcWFqU3ZX?=
 =?utf-8?B?YTlPbnhiSTRkUVMvcXh2TGNPWHd5eWJsU0hHcnVRZmluRk12NXByMk1QN3Zp?=
 =?utf-8?B?bS8xdTFzMGJuanI3ZlJBNlhnRjB3US9FODdBTlZVUllPc2FiNzFUSmRiaVg4?=
 =?utf-8?B?Q2R0RWY3R05ZeE9hT3ZYN0RibllWT3liVWliZjdEbXhZeFY2enN0UzFYUytu?=
 =?utf-8?B?TXcrc0Ewc3Irb0psU3FGVk1peTB0a1pLaGVtVURIOVUvVW1yUm9ndVRONlB3?=
 =?utf-8?B?VGNzR095RXJXQnpDeXEveHZDWm5CWkpDRVlYcWVVeEZKRzN3MlFFTytzQ0pE?=
 =?utf-8?B?bytxTnljS0pmZmhBNlBhZHFnaGVaR1hSVWwxeEdZSXFubjRRUkVEc3hFT29Z?=
 =?utf-8?B?NGxHTzQzVGJhVEJrZE9KdzRYejZLalBtVWhnVSttRThJOHVaRHBIaEdjMWdO?=
 =?utf-8?B?NkcrblcrbEpsWjVQN3IvR0tkckY1ZFFOV0ducFZjYVY4cnA3SFhRQjFEN0JR?=
 =?utf-8?B?V1NQNlVwMlltNnk0elY1MjdIQzBGeHlZRkxtdWF1N2lLdnJjeW85OVRTblFy?=
 =?utf-8?B?R1Mxbm4yRWhqakM1UVd3d3JUTW1wNVJWZ0ViWk12bWY3YlVzdk5DdEZNNGZh?=
 =?utf-8?B?bEZ1TWp5WUh6UmZtQW5iUnpkbmVaUURpQUlueVA1U0d6bktRM2dVZ24yQnA0?=
 =?utf-8?B?VGkwM0VKeWRkeGhXdWtZcVJoeExZVStlSkNCY2Z2NEM5aGNPMTc2M0R2Vmkx?=
 =?utf-8?B?Qk4vdUdQUFhNRGoxK1JXSWZ6dSs1SG5Iek5HL0JhbUNLYmdva3h4dllXK3Qx?=
 =?utf-8?B?Q3pUNENIakZjZE9ERGNGV3FUWW90QUNldVlSbE0xRFk5UGkxZDFXanhDdFhh?=
 =?utf-8?B?ODZKYkpVcUpYTDFJN1JVbkVGejZlRXFxeDIvckhBcVRwaWxZYTVFaDRrSGYz?=
 =?utf-8?B?L2Z6U0NrUk92c0FaT0ZKNVRRaVVFbHdZc002VjliNEdtRVRGYXRidVJReUIy?=
 =?utf-8?B?RDJVbVgrVTFIUGhnZ2tPNkc3cXVXenI5TndISXJNTXUvOE9qRmhFVmIvZmE0?=
 =?utf-8?B?bG9acDhHb1hTQmwwR3RLb0JJd2V2cHlqT1BXMWJ0azJ5RXducVBKTXd3SHZ2?=
 =?utf-8?B?bG5mQVluSmxPOWJ4cDE2R3pRdUxCeG9pZU85clhKd1FPamgwQkp0YmNoalVT?=
 =?utf-8?B?N0kzUFg2ZXVWckJHMVQ1WEFXazNaVlhwOExXOXFGU0E1dVlsVTBFODllT0hQ?=
 =?utf-8?B?QVJTV2REYmkxTUcwZEl0Q3lvZCsvYlZtdnVkWmEybUd2cTdma3cvYTZZdzhM?=
 =?utf-8?B?aUxGNVFBWFV6cW12UTIrQmdpOGxPT0lMK0tNTy81T0RGNHNTMDhtSWFta0lx?=
 =?utf-8?B?TmVndm9maC9nQmtrUXFWN3ZyS0JnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <870AA36D838CE6428DECE3E9515F9A36@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c9e683-08b0-43d9-588d-08dd0051e14a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2024 00:03:02.8479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QDWr0Qi6n1oWgTCa1ZSgM7fNGOtv4YRjjqhpv0WCeNTeoYng/yTg8eXWf4FqgsgMY8KpuEygWaz+iJAyPwC+Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB5353

T24gRnJpLCAyMDI0LTExLTA4IGF0IDE1OjIwIC0wODAwLCBEYWkgTmdvIHdyb3RlOg0KPiBIaSBU
cm9uZCwNCj4gDQo+IEN1cnJlbnRseSBjbF90YXNrcyBpcyB1c2VkIHRvIG1haW50YWluIHRoZSBs
aXN0IG9mIGFsbCBycGNfdGFzaydzDQo+IGZvciBlYWNoIHJwY19jbG50Lg0KPiANCj4gVW5kZXIg
aGVhdnkgd3JpdGUgbG9hZCwgd2UndmUgc2VlbiB0aGlzIGxpc3QgZ3Jvd3MgdG8gbWlsbGlvbnMN
Cj4gb2YgZW50cmllcy4gRXZlbiB0aG91Z2ggdGhlIGxpc3QgaXMgZXh0cmVtZWx5IGxvbmcsIHRo
ZSBzeXN0ZW0NCj4gc3RpbGwgcnVucyBmaW5lIHVudGlsIHRoZSB1c2VyIHdhbnRzIHRvIGdldCB0
aGUgaW5mb3JtYXRpb24gb2YNCj4gYWxsIGFjdGl2ZSBSUEMgdGFza3MgYnkgZG9pbmc6DQo+IA0K
PiAjwqAgY2F0IC9zeXMva2VybmVsL2RlYnVnL3N1bnJwYy9ycGNfY2xudC9OL3Rhc2tzDQo+IA0K
PiBXaGVuIHRoaXMgaGFwcGVucywgdGFza3Nfc3RhcnQoKSBpcyBjYWxsZWQgYW5kIGl0IGFjcXVp
cmVzIHRoZQ0KPiBycGNfY2xudC5jbF9sb2NrIHRvIHdhbGsgdGhlIGNsX3Rhc2tzIGxpc3QsIHJl
dHVybmluZyBvbmUgZW50cnkNCj4gYXQgYSB0aW1lIHRvIHRoZSBjYWxsZXIuIFRoZSBjbF9sb2Nr
IGlzIGhlbGQgdW50aWwgYWxsIHRhc2tzIG9uDQo+IHRoaXMgbGlzdCBoYXZlIGJlZW4gcHJvY2Vz
c2VkLg0KPiDCoMKgwqDCoMKgIA0KPiBXaGlsZSB0aGUgY2xfbG9jayBpcyBoZWxkLCBjb21wbGV0
ZWQgUlBDIHRhc2tzIGhhdmUgdG8gc3BpbiB3YWl0DQo+IGluIHJwY190YXNrX3JlbGVhc2VfY2xp
ZW50IGZvciB0aGUgY2xfbG9jay4gSWYgdGhlcmUgYXJlIG1pbGxpb25zDQo+IG9mIGVudHJpZXMg
aW4gdGhlIGNsX3Rhc2tzIGxpc3QgaXQgd2lsbCB0YWtlIGEgbG9uZyB0aW1lIGJlZm9yZQ0KPiB0
YXNrc19zdG9wIGlzIGNhbGxlZCBhbmQgdGhlIGNsX2xvY2sgaXMgcmVsZWFzZWQuDQo+IA0KPiBV
bmRlciBoZWF2eSBsb2FkIGNvbmRpdGlvbiB0aGUgcnBjX3Rhc2tfcmVsZWFzZV9jbGllbnQgdGhy
ZWFkcw0KPiB3aWxsIHVzZSB1cCBhbGwgdGhlIGF2YWlsYWJsZSBDUFVzIGluIHRoZSBzeXN0ZW0s
IHByZXZlbnRpbmcgb3RoZXINCj4gam9icyB0byBydW4gYW5kIHRoaXMgY2F1c2VzIHRoZSBzeXN0
ZW0gdG8gdGVtcG9yYXJpbHkgbG9jayB1cC4NCj4gwqAgDQo+IEknbSBsb29raW5nIGZvciBzdWdn
ZXN0aW9ucyBvbiBob3cgdG8gYWRkcmVzcyB0aGlzIGlzc3VlLiBJIHRoaW5rDQo+IG9uZSBvcHRp
b24gaXMgdG8gY29udmVydCB0aGUgY2xfdGFza3MgbGlzdCB0byB1c2UgeGFycmF5IHRvIGVsaW1p
bmF0ZQ0KPiB0aGUgY29udGVudGlvbiBvbiB0aGUgY2xfbG9jayBhbmQgd291bGQgbGlrZSB0byBn
ZXQgdGhlIG9waW5pb24NCj4gZnJvbSB0aGUgY29tbXVuaXR5Lg0KDQoNCk5vLiBXZSBhcmUgZGVm
aW5pdGVseSBub3QgZ29pbmcgdG8gYWRkIGEgZ3Jhdml0eS1jaGFsbGVuZ2VkIHNvbHV0aW9uDQps
aWtlIHhhcnJheSB0byBzb2x2ZSBhIGNvcm5lci1jYXNlIHByb2JsZW0gb2YgbGlzdCBpdGVyYXRp
b24uDQoNCkZpcnN0bHksIHRoaXMgaXMgcmVhbGx5IG9ubHkgYSBwcm9ibGVtIGZvciBORlN2MyBh
bmQgTkZTdjQuMCBiZWNhdXNlDQp0aGV5IGRvbid0IGFjdHVhbGx5IHRocm90dGxlIGF0IHRoZSBO
RlMgbGF5ZXIuDQoNClNlY29uZGx5LCBoYXZpbmcgbWlsbGlvbnMgb2YgZW50cmllcyBhc3NvY2lh
dGVkIHdpdGggYSBzaW5nbGUgc3RydWN0DQpycGNfY2xudCwgbWVhbnMgbGl2aW5nIGluIGxhdGVu
Y3kgaGVsbCwgd2hlcmUgd2FraW5nIHVwIGEgc2xlZXBpbmcgdGFzaw0KY2FuIG1lYW4gbGl2aW5n
IG9uIHRoZSBycGNpb2QgcXVldWUgZm9yIHNldmVyYWwgMTAwbXMgYmVmb3JlIGV4ZWN1dGlvbg0K
c3RhcnRzIGR1ZSB0byB0aGUgc2hlYXIgdm9sdW1lIG9mIHRhc2tzIGluIHRoZSBxdWV1ZS4NCg0K
U28gSU1ITyBhIGJldHRlciBxdWVzdGlvbiB3b3VsZCBiZTogIldoYXQgaXMgYSBzZW5zaWJsZSB0
aHJvdHRsaW5nDQpzY2hlbWUgZm9yIE5GU3YzIGFuZCBORlN2NC4wPyINCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

