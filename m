Return-Path: <linux-nfs+bounces-10988-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C0FA79092
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 16:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742253A7AA6
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7508123A9B0;
	Wed,  2 Apr 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="DosGRcLl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2139.outbound.protection.outlook.com [40.107.236.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9408157493;
	Wed,  2 Apr 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602195; cv=fail; b=ezvdDIUYFDkZLYRrS1eUBExNdWtiP1NJe3hx3RxsKXwIjrFQoTI8Ck/UvddfcYKUZDp27fMrR0fs7u/pW1gSf7wM/xKDTKqTe9vK8UWyVkNDoiDG2jmcdSF4xreprVeE+ayuOIVFIT0Ju+zkoXO9FOlcDwcpbcgxpMfymV13H6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602195; c=relaxed/simple;
	bh=JOX7GTXTMd1THRsHhm92gWRGwuUBGwn56IpgFN4gJKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WQsFq02eskDL6yM7Qb96cCmxI1khuKelBNhFv9wXw7z0xMxDIbCiKHWqxRqM2Yqxh+yLS5f76jNWJ/RvjFxWj1LElfY5akXkLBIrSEcVJ7o8gccg/wBPl6T5lAGbTBglmX4DB11osRhb6K1cc5NjjdN2GtxX2tiBf6VaLKAPt2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=DosGRcLl; arc=fail smtp.client-ip=40.107.236.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+L5smT6+nOS3n+pmcfyLrKWbz4jINSOWnItg+PgsW0KMocraPx6INeswg8zH/Za2Y9UfjGZ7LDNaxdaIOOZ7xfauGSEJcEjR8pDzTl77+dGHOa5pdHyptDbXOuXOjED07PDorc+4fwj1xBPfon46QPHLOsFOOKFOoXuc87ypkrkFZRh1cSDDajJo212f8M10hcX3juEYHk91aKXOdDa3f/7MumIqDp8Ufa5SqTZYAnugYXSXiZis9KG58hGoPiSXLuol6jPTAwkOGFBz9blgG4ZEYdvCzQ5SRo7rFEWs13khZjTjPmpZ2ajnYv1RkQCDzLFjTSn5pfWE5CjGQoWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOX7GTXTMd1THRsHhm92gWRGwuUBGwn56IpgFN4gJKA=;
 b=F4qeU7/CHrRW+GfAn72yZnpucK9367s1JcmV76QN367NJBzKYx+xA/thzg0lUmnR+twqaY0ET1GphRGPAVL0sRnmdP2jn2W5d/E5KyPPIlEjPUwVt3g4otiwegQO+XiCHDk4UFQbB5yFqljOZnsLd0O593ldEoHSh0OUDyOLo+gRFCQ5Z3Xk46nU9J+c0jQfhb4bL2lCxipwcyy6/PQ+YapGDyKzBJ2fJCg4EE/PcPbrvmLKsgJ5ADGxcYLCWeFDqyKQWT5iftzJBea5pKjgZcxdI+D6w/13jMO818LNVOSD2CZAtNq4fIJwy1B1L/iGPfEFybdpWMAq1rIjHLU9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOX7GTXTMd1THRsHhm92gWRGwuUBGwn56IpgFN4gJKA=;
 b=DosGRcLlu0p/55lu2fjufjK2sCiavJOUdRC6lCiaXwmwgTWEONut4Vshn4Oc5N6XaMZyO7oPYFsOH/EgdYjvxQHo1ZqadWEVl4tkncYN69a0OdrhzmBQZ4AbiZvRPI/2+R3gwsCFdvXu8JHqWC82XGWpPfqniiQSzwTU9M4LYhY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3796.namprd13.prod.outlook.com (2603:10b6:a03:22a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Wed, 2 Apr
 2025 13:56:28 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8583.038; Wed, 2 Apr 2025
 13:56:28 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "hch@lst.de" <hch@lst.de>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>
CC: "anna@kernel.org" <anna@kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] nfs: Add missing release on error in
 nfs_lock_and_join_requests()
Thread-Topic: [PATCH] nfs: Add missing release on error in
 nfs_lock_and_join_requests()
Thread-Index: AQHbo77fv9EA5h4ey0uppPZKPE3K1rOQZo6A
Date: Wed, 2 Apr 2025 13:56:28 +0000
Message-ID: <80670aa0fdb2b0c818a9217929e38df61fef1689.camel@hammerspace.com>
References: <3aaaa3d5-1c8a-41e4-98c7-717801ddd171@stanley.mountain>
In-Reply-To: <3aaaa3d5-1c8a-41e4-98c7-717801ddd171@stanley.mountain>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY5PR13MB3796:EE_
x-ms-office365-filtering-correlation-id: 98a30df2-e722-40ef-6d90-08dd71ee2a77
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MlZlL2pzSTMyRjFzb1FhcDFCMGlySFZRWW1DL1gzY3EwUi9FWW1OcGExNklP?=
 =?utf-8?B?cHUxY0hvNThuUFBPY3JTY282VnFYSzZBVm1kUnNpODlnU1pwMDBUVkZkdnJG?=
 =?utf-8?B?VjdSZFNXZ0NheDY0MG9uamJUWG5IdWdaZ1lWMmFRWUJDcGNqOGJ1bGtBSmY0?=
 =?utf-8?B?ODVuSmZHczlsd0EvM2plLzBNSmlkT3RodkpQWit4Rng4WG1GM3Qvc0tEOUVV?=
 =?utf-8?B?WlNwSHJsSnNKTXExYnYxVjlJSU9mRmhZaTh4Ykw3UXVJYkFkN3JCeXBlRGlJ?=
 =?utf-8?B?bTlRSmFWN0ZEZWJHV0FKNUt4Q2pjQndUSXVQcEVibTdYRWE1ZUFNR0o3RGc4?=
 =?utf-8?B?akZlb3paT09rcFE5N2Y1RmlrWUVuZEU5L0JVRkxPcURHOEZTU0YvMHNYeG1B?=
 =?utf-8?B?T0NnSXV4Wml3ajZ6TGpHY1VVNWNWY3hrTWE3cVcwQXBBK1JOWVMxbUJxRFda?=
 =?utf-8?B?cXZxOWtrTlNBUzBOZTlUVER3dW9kVXdMcTMzbWxjZUhVTGgvUTlobHVSeGJX?=
 =?utf-8?B?UXdZajZMcUFHV3Y5RnBzZldqT2YrZ2lpdi91WFRBeGJZSEdqRUNjTzRvYVhC?=
 =?utf-8?B?R2h2OW40WUFiQVZQTy9OemRpa3ZTZXNlN2Z3OGRQeC9HdFJsZk96NlJJR2Rl?=
 =?utf-8?B?L0NEN1ZFSjJ2RWRvN212b1hidE90akd0Vy80WHBueE9ybzJac1NyQWQ0Vm5o?=
 =?utf-8?B?UlJzRTZSaGk2YVlRMk83bExpVmJTMGxraEd0RkdVZ0NING9zN00wK2dwcldE?=
 =?utf-8?B?R3ZPVnJBdFJoa1lRd0lpdXpJUmt2aWZ2eExGdlU2V25TdmJTc1FLV2dBYlA1?=
 =?utf-8?B?RXJXbjFNSXFhcjFYTFNVWGp0OE5ES3lJQzZPOUVjTTkwV1lhMUphNkd1M2Fy?=
 =?utf-8?B?YUQxRXliWmNpOXd2RFlKUXkxUFZkU1pHVHI3K20rU095L05qQTBFWkdzOHZr?=
 =?utf-8?B?cCtwbnB4QXROOEpaWEpwbEFSektWWnQ2QVpkTmdGQXljajE4VjZqb2VyS1h2?=
 =?utf-8?B?SzFkRlJQLzdUSDBZWEFPUm9kS2h3bk9DQWg0L3h4YzBuSmpNSFNiaHJaSVhD?=
 =?utf-8?B?WExsbDRCZWd6N3JrdS9qd2VUckxwZjk5aWdFVktYdkdaejFsVnlsa1RVeXNO?=
 =?utf-8?B?VVdmVTM4TURyVCtyc3NZWkJ0a29maXJSN00rRHFFWmJkZFU4NmJGdDJqVFBZ?=
 =?utf-8?B?RG1zbkpZWVZMUS9OZmVJRWNIS0ltM3RWM1dGaXRIZ1V3U1NKVldaaVQzZ0tT?=
 =?utf-8?B?ajZ1U1laeXFYVFh3NGszbklmL0xJZitzdElsTS9vWDI1ZTVKVEFMOUJoWEVt?=
 =?utf-8?B?WWp0VHJLMFhqOGlOWVBHUjYrVnpuRTdCeEhCL0ZnZWJKNXVZeGtYQ0JSM3pk?=
 =?utf-8?B?N1Mzbjl1VkNVM00xTVFXZm5UQkErRlNzWVdweEJuV3M1ZC9nU1ZPZTJNTFB0?=
 =?utf-8?B?QmkzZDV0cFYvSDNUcGcxa2NJV0R2Wkg3czdCN0dydHhldjNnY0F4TlNoR1pa?=
 =?utf-8?B?V1l2bXFVNU5YSXdsTFB3dkRuc2xkNTY3MXhsNkQvRUhnL3lYYTVYRjZvd0JM?=
 =?utf-8?B?UldzdTJRMVZ1cmVza2h4UTZIZ2U4UWQyNTVTaElpYnVpRG9SaFZwWWx1WTVl?=
 =?utf-8?B?dU9DeThhNi9IOTVIMkFkM3U3UlBsdko5UmxRaE1CQ1BCaFZRVklmUkt4d2E0?=
 =?utf-8?B?MzVXMy9qS1VpajFxbjJqNHVzTXJtQk9rYTFpclMxYktNZzBDaVk2N0ZWV0R2?=
 =?utf-8?B?NnRzVkRGOEZnTDNkZnV0TGQwbTlvMEJQUWZXNmlVM25qRWllZ2tUTDI5cjlE?=
 =?utf-8?B?TUxpdWE4dHcyR0F5bXU5RFlUNEpxL0NCb0E1ZFJtY3hsQ3dBL0ZXbENhcEt0?=
 =?utf-8?B?VWRTb09OTUY2ZGVGZkhPMnZHVFo4K3Q2Z1JhUTRIRDlUVk5Rc3Z5ZEovV3hp?=
 =?utf-8?B?cFQxUTlXUkpzWXk1czV5WDk0MHU4Z09HTnltOTdTMDR4cmhlSldPdmY2V3ZI?=
 =?utf-8?B?a3hUQ0pBTGJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0k1d1N6ZTByTWgxR1FrNzJTV0d3bjZzcHExM1RISytzWCtCdlpmTGVNTW9K?=
 =?utf-8?B?SGpiSENRSTYrTnFCNTFlUjRabWpxcjBxcXJObm93YkkxYUNrYldpdkFrSXVy?=
 =?utf-8?B?VldJMmRmT2ZhQjNKMHZQK0plRUZ0TnhiQWlxYkFKRGttRHRGRzEvMzNnMXBh?=
 =?utf-8?B?Q2JoV3B1SUxZYW0rYldwTE14a0l4UkRQUSs5dGMwZlRvNVdjZVpKMkwxU09p?=
 =?utf-8?B?RU43b083QWxDbzlrdWZybXVsS2hEUGhUdDIxckxORGpncFUvcVVGaUs2cXpm?=
 =?utf-8?B?ZGdWaDE2S2U0Qi9YOExmM01KeGpoY2xQcHpTTTR6bGIyYzFGRzVxcG41UUtJ?=
 =?utf-8?B?WTZFQ1JyNmZKRVlwUlZ3WEczNnRObjJOSUxKalBDREhUTkVkV01OLy9DMzlv?=
 =?utf-8?B?cG1MZVRrNW9XUmg0empxNGlSdDRWN2JHdEtLbU8vcFpRWUc0WDVWUEQyZUhK?=
 =?utf-8?B?WE5zZVY2V0tkZk93VlRYNDBtNS80Q3Q2L21CbFJTU2V6ekRxMWVBT01DOUw3?=
 =?utf-8?B?M0hwRy9sdGFPYUI1d3ZDMUNuUG9seW1XRjdBZkFjUVpmaHB6OWpTUUxpV3VZ?=
 =?utf-8?B?dFdCSmNjOUw2QTdGL2dDOEVsaWpaeE11elNKVWdZbTNKS3NiZmg3YUhnZE5a?=
 =?utf-8?B?YVQzbXVSVXJSdmREajd3eGJZQk1UWDJ5S2dhb015azloc053UjJxNTFrMWZG?=
 =?utf-8?B?SkppVGIxSkE1WkZtaElYamt0cE41MzNUQmQ4cVpVaUpJQU80Rkk0OWx5QTh5?=
 =?utf-8?B?V3FjQUgya2JZcUl5Q21aTWJmeFNzMWhNbHN5VVZ1eEhUWUlZbGl3VEhQeEFP?=
 =?utf-8?B?cWFnQmZxMEFRUll6a2xod3ZnWTdMNlBQV3dNTHhBOGFhTXFjOWM2TkoyTUto?=
 =?utf-8?B?UEVNc2RDenprM25sV0hvWlZva0pCOGczQkpLTFprU0dNVHBnUDRwV1JnOEFx?=
 =?utf-8?B?TFowY3lKQXpMeEgxQ0NIdTJYYzdwTTRocG5pUHpXdENadU45YVJHdzJPVDhv?=
 =?utf-8?B?d0lRMkc1djBWZlpxMGhPTDNxZXljYU9HYjd0TXM4YjU5MXhTWllnSEdWK0RJ?=
 =?utf-8?B?a3dWN1grSjA2a3JUV1hZOUVBRDFzeTAwcTZmMlM4NTJTSHN1ZC9QcEFOMWpp?=
 =?utf-8?B?TzZIN2FxVXpodlZ2dUJKaE5IbmlPVmxnc1ZzTnQ3WHl5dHErNENsK2FSMGFl?=
 =?utf-8?B?V3RDN2J2b1BEaXFQNHZ4bTlEQkNnTzVXbWZZeVpMUVlwTCtWVFVnSE5tWXBS?=
 =?utf-8?B?N2hPSFoxRldVRTBra3MzTDZLNm1KRnVHb1FISmxpTHdJVDhjY0lTMzBIbnJD?=
 =?utf-8?B?Y29qNUtaVVFpcTBsK2VJdkxBYS9mVnNVcDFDRjR4SGduNEI0RmRraHlHank5?=
 =?utf-8?B?a1FLcy9IZit6U1Nsck4xbzl2YStWN0w2bTF6bUthTzRMandnbXJFQ0JwYWxI?=
 =?utf-8?B?UHo4Mmo3UVZqOWV2ei9sOFZQa1Z0Sms4QkRXZjcwdGNMbkxtTG9HaFpQdC80?=
 =?utf-8?B?d1pPcmc2MlMwQzRyR3dNY3JoRU5WWEl1eXgycldHMGZFOUVtN2VydE1nL011?=
 =?utf-8?B?ZXhiVjZRcmFaOC8wZmx2VTFJQW9zSndIcmJxL281VU14Z3F3TXRxazlWc1ZE?=
 =?utf-8?B?SUEyNlJrU1poME13ZVlyd0IrOGZOTWhYY3dndFBRZFJvUVdLd0NrNzFkdzJO?=
 =?utf-8?B?cWtOZTNwUU4vQTZDb1AzOUw2cHQ5OFcvL3h1MVJCVFVxamV5YnRHekRyMjNU?=
 =?utf-8?B?NUJiVXVMQkFSTys3a1NrdDdQMHlEYjM5VkZrNUVpNGFXb3dwVlhOU20wcjht?=
 =?utf-8?B?NFlLdXNjUkxUcWVoM0tJVitzaHZFM1daQzhXZGhUb21yYlpLemhjWVZVcnpL?=
 =?utf-8?B?dW9lMjlLcEYxU3NjV0Rsc0FrbU0vSG9XaFNzMUNIOXZwNXEwSXFLcStITFZo?=
 =?utf-8?B?ODFhZnZ3V0MvS0Zqa2ZuV2ZQQWJydkZJTzJMY09hcXdOMUQraVcrMmFuQkNm?=
 =?utf-8?B?SGR3eGgyMkR0Z21pcGgwTkcrc3JPMExHZjlrU3dVNEdBenJRQk8xOHl6Y1FE?=
 =?utf-8?B?TVdqalREMlhuY0ptN2k2bnRsZy8rVklaZmlmbyt1ZWpSZUU4Sm42RWhScDZU?=
 =?utf-8?B?RFhnZytVVmw5M1YrdGpZT0FtY0Uyc1FYVHNWaVBmWXRqVFJ2aERKdlFRL1ZG?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E6C163F1A76C947A64D6CEE2AD73086@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a30df2-e722-40ef-6d90-08dd71ee2a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 13:56:28.4490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Z1wDugg2b4xP4xtDG8Vcc4mrRG9+Piej/U9OnguWaW8wsd1F/Vbtl23m0GQ+xS3bSfuKlS4MaB0479lOFSh0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3796

T24gV2VkLCAyMDI1LTA0LTAyIGF0IDE0OjAyICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBDYWxsIG5mc19yZWxlYXNlX3JlcXVlc3QoKSBvbiB0aGlzIGVycm9yIHBhdGggYmVmb3JlIHJl
dHVybmluZy4NCj4gDQo+IEZpeGVzOiBjM2YyMjM1NzgyYzMgKCJuZnM6IGZvbGQgbmZzX2ZvbGlv
X2ZpbmRfYW5kX2xvY2tfcmVxdWVzdCBpbnRvDQo+IG5mc19sb2NrX2FuZF9qb2luX3JlcXVlc3Rz
IikNCj4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8u
b3JnPg0KPiAtLS0NCj4gRnJvbSBzdGF0aWMgYW5hbHlzaXMgYW5kIHVudGVzdGVkLsKgIFByZXR0
eSBzdXJlIGl0J3MgY29ycmVjdCwNCj4gdGhvdWdoLsKgIDspDQo+IA0KPiDCoGZzL25mcy93cml0
ZS5jIHwgNCArKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy93cml0ZS5jIGIvZnMvbmZzL3dyaXRl
LmMNCj4gaW5kZXggYWEzZDhiZWEzZWMwLi4yM2RmOGIyMTQ0NzQgMTAwNjQ0DQo+IC0tLSBhL2Zz
L25mcy93cml0ZS5jDQo+ICsrKyBiL2ZzL25mcy93cml0ZS5jDQo+IEBAIC01NzksOCArNTc5LDEw
IEBAIHN0YXRpYyBzdHJ1Y3QgbmZzX3BhZ2UNCj4gKm5mc19sb2NrX2FuZF9qb2luX3JlcXVlc3Rz
KHN0cnVjdCBmb2xpbyAqZm9saW8pDQo+IMKgDQo+IMKgCXdoaWxlICghbmZzX2xvY2tfcmVxdWVz
dChoZWFkKSkgew0KPiDCoAkJcmV0ID0gbmZzX3dhaXRfb25fcmVxdWVzdChoZWFkKTsNCj4gLQkJ
aWYgKHJldCA8IDApDQo+ICsJCWlmIChyZXQgPCAwKSB7DQo+ICsJCQluZnNfcmVsZWFzZV9yZXF1
ZXN0KGhlYWQpOw0KPiDCoAkJCXJldHVybiBFUlJfUFRSKHJldCk7DQo+ICsJCX0NCj4gwqAJfQ0K
PiDCoA0KPiDCoAkvKiBFbnN1cmUgdGhhdCBub2JvZHkgcmVtb3ZlZCB0aGUgcmVxdWVzdCBiZWZv
cmUgd2UgbG9ja2VkDQo+IGl0ICovDQoNClllcCwgdGhhdCdzIGEgc2xhbSBkdW5rLiBUaGFua3Mg
Zm9yIHNwb3R0aW5nIGl0IQ0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==

