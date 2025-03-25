Return-Path: <linux-nfs+bounces-10857-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BF7A709C7
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 20:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1278018969D2
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 18:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2D119D086;
	Tue, 25 Mar 2025 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="TRv9PyIu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2094.outbound.protection.outlook.com [40.107.243.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4D1E1E09
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928653; cv=fail; b=u8B6vwZFycK++ELRnXCky95WEp+37O5OxLGXdeIxoWgR+GUw7d6G/EJnj2VoGD/i+vE9ay80EwOJBBW2qhHt6IJuglXpx7K5o7dKVTDuDb569S8bDHz5wcT6LuzyxXpInrtUEb4sAJ9MnX+KXb7P0ooq95hUHCGCw3jUJxhj79g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928653; c=relaxed/simple;
	bh=bQT8+hbxBU/BL1b0pGpEc8wxT5QwfTgNtYH8vd7Bk3w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MneQpJnsFWZb06i2scWBcLAg6P1iKn95mi4yI11ESo3YmXNBH/e2Ka1dzg10H3U1maaLSVgARKYp6ZqPwQ0E5y1YAfFPMllxSDBn07xkRsT+5e0kq9pRbdUSoqdlRPWO+04k27ZjwxbGXkYInmtq08H63w+2yishqixK+PvDJ2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=TRv9PyIu; arc=fail smtp.client-ip=40.107.243.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Im7XzaDv73STTKNQ57I5ZEz8APuFm3ZJLuYzdQznYnOugseMIxstgtC/1XR6oCOstJgaMNPX3FQQuBe15la9LqMUvSTQirtUWjKvRmgIubtNY+VnCelCg0LbWGyGzYD2i0maBsyj2RArfuJ4y/oID5dgS3CoASM09Ut6nQlKyAKy4Ug9sRUUfymxW6mKI/SXNExndqABX0Y4L9Bu9pQMPtyaoxORQ4jbtG4MiZhMts+sHSXhMRarFrZ3e63KoFvIKhAmjm0TaQgQbxeayAODF2IB/aom8XJXugQzFPI2ED1PoxFFoi6V5tCREvnLT5jO0OdJ8HGmyOu1iDBUk2hoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQT8+hbxBU/BL1b0pGpEc8wxT5QwfTgNtYH8vd7Bk3w=;
 b=VtGWAQln2gJMb4JKWPwrU7B+/EJ6ZzmBVnq0b3Cz/aOWzdtg/KNUB4HTXHPKZlxzThuaXPWcPkVpocx4YVbo5ecDbJ2lNSdEVV1sDpUb4sis8IardCyS7f59Xt5Bceh+GUGk2mkFYwob5Zz4HpPuWZFn0yPUge13YdWEEQ27NCfhRV9JUNN57sQrDjeyN/UHk/HBUugnatyDQ2xm9VvfaolmcKQxJCa3RL0CQwsrAsx9XyHrojSGmW1EvwFOk5AhGXdnzD2SV1HFGpGG7XjStdY0/r9xb7hKdfUPK+/SweXcNwdiJIHhDaPIBmOzcfVZHcmVGHN8WW+y6IJ5+xuHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQT8+hbxBU/BL1b0pGpEc8wxT5QwfTgNtYH8vd7Bk3w=;
 b=TRv9PyIuamQbKbxHt0iXEPPEzPdGxyLhmFH1tttUS5FSdIWzs3ygfOhrpQ1+fCTAdBKH1UIZgfMv9IsZ3M9c4KSElviO75S581D/B75jJo9MoGnUbfWLfliZ/RFC7d9V75yCws161Ml0hR9bsTaEZdHVPC3fNw4knwqyBHdwpC4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by LV8PR13MB6549.namprd13.prod.outlook.com (2603:10b6:408:1e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 18:50:48 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 18:50:48 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [PATCH v2 4/4] NFSv4: Treat ENETUNREACH errors as fatal for state
 recovery
Thread-Topic: [PATCH v2 4/4] NFSv4: Treat ENETUNREACH errors as fatal for
 state recovery
Thread-Index: AQHbnaGgynXUIeQMIkamWDaZ/QD0NrOEJXqAgAAM5oA=
Date: Tue, 25 Mar 2025 18:50:48 +0000
Message-ID: <fba769b9743aaaf2a3f5eeacb88ee3a2e7604301.camel@hammerspace.com>
References: <cover.1742919341.git.trond.myklebust@hammerspace.com>
		 <b1989a8316da4dcaaaaedad3b9d234d212be1083.1742919341.git.trond.myklebust@hammerspace.com>
	 <3c94f6980a3bb02c1106ff8c44e8dad39c249299.camel@kernel.org>
In-Reply-To: <3c94f6980a3bb02c1106ff8c44e8dad39c249299.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|LV8PR13MB6549:EE_
x-ms-office365-filtering-correlation-id: 117bab72-60ad-4c51-7ac5-08dd6bcdf54d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVVWNTFnQ0xjdE8wOEJ6TGlzUS9WNXhhZ1RnU0xreTNnUy9pcXVwYW1HT3Jj?=
 =?utf-8?B?WHdLYURPc2hYeDU3N21zYk1lZDhvTGlKeUYyTExyOUFTMDV1V01BUThtdnhs?=
 =?utf-8?B?NG02bVVRUU01MFZlalRwSDZBWGdtNTlNc0FPRER1Rkl1VUdmTjFkWmZIdnpn?=
 =?utf-8?B?dVU1bVVnNXp1SkI3QUtkQlN3RjRpbXZ3aGZSei95Y1pGS1ZQV0pDbVhMMUIx?=
 =?utf-8?B?NWRISXM2NHJ2TjVZZ0p0cmlQS2d2aVF2SEhNMmxodjNqSTVKK29MVU81Q3cy?=
 =?utf-8?B?NGFnZjlkb2hnSFNENytBcUJ0TVdreW9FZWJZa3duM3B2dW1oSHVVaEN6VjZ1?=
 =?utf-8?B?TnlQMHczRDVSUk5XdzBUNWJmeFNUVllBb0N5TWJmWmpHd21nSDhlYzRnTWsv?=
 =?utf-8?B?bXN1d3dUMkZFZDdzaHVwbW8wRG1LbGRlRnNBWm5aQ2dOMlN1c05CS2g5S0h3?=
 =?utf-8?B?QjkvNktKMGNjYTB0V0g5Z01wdDVuL2NXVXhHZ0R2OS85aGJldVl4ZmpGeG5L?=
 =?utf-8?B?MmZ1QXhON1VOQWdZd3RqMzRBVE14cmp4NUYvUnRuYVVXTzluQTgyYUVCSEU0?=
 =?utf-8?B?T29Nc3VBMzAyZDhua2ZQdmV5emVqK25BaUVVdHg2dEVHT2YxanFtMlRidC9J?=
 =?utf-8?B?RmRHdHB1VThqSmVPMXdTZEtRY1pTZU5Qb2lDbTd0OXBMMi92aTJjaTRvbHJ0?=
 =?utf-8?B?bGF3d0pqMU8yelo2THRJZU1adlczWDFXQ3lLNWZ2T09QUVp0RTlXa3R1L2Vm?=
 =?utf-8?B?andKa09qS0ZOZzZzYVNmcmFYbVZOTFFjMTJtN0s3RkRobVY0ZVM4d3NkMGZy?=
 =?utf-8?B?eThyc01BdDI2RDQ4T1N0MUhjMC9OcFBFRUFnRklOQTJoK3VPTmpZS2dMRWtB?=
 =?utf-8?B?RFNMYU5EY2RPWTJyQWJVbHVLRFBodUdabkNTNndSM3pKNEhOb3I1ZnRXRlpo?=
 =?utf-8?B?Zm5vdzNCcHI3WlJlTENuSlJGemk5WUtQanFqcWpreklIV04wenVHRmtJQ01D?=
 =?utf-8?B?ZlcyTTA2eHYzS3doZm5BUjFSbjdzMlByV0VIZ1FmS2h3WVo4VXJ6T2Jqc3hq?=
 =?utf-8?B?MEtDU3pPQnI0bVF6RlBWZU1VRmdzakQ3cFI0RXVGajBicVk3cWhRQlBIRVVj?=
 =?utf-8?B?MVBYOHVrUCtSalpCQitoSnhaUUpkOE5aelNDR214MzdsZUdYeWZ2OURuYktQ?=
 =?utf-8?B?eDlPOG9hbFVzTjdreU5Qd0x6YjFacWtlY2JMY2NuWGRGUllhL1QzejQ2U3h4?=
 =?utf-8?B?VmZicHE0ZTZqdGd2aHNDZlhlY2xCMFpFVDVmcG52UllYUE9RbXdtc1BvcWdu?=
 =?utf-8?B?QUNHWnhHOCtKVEd2eHdmWk5jVnNjdmRRWHNtTkhlU0d3bEpuQmVVVEhkU3NK?=
 =?utf-8?B?THc1UmVIK0E2RnRzMUxlNVg5Rm82NXErYWptMnhqcEhnZ1g3azQzUXNCUUlu?=
 =?utf-8?B?dTJOdWlVWWpDeXcreWcvRHI4Z3FkZ1I3NURRNytFSlc4dlVONHVzS1d6bHZS?=
 =?utf-8?B?Zm5GYVBPV0M0aWVDUjBuTjlpSFVEUWkyRWh3eDRPanZtc2IyamU5ZlJRay9P?=
 =?utf-8?B?TUpSRmxUSWpIRHZ5cnU1NG1CSitPQkpTRy9USnZ2Y2xQSURBaElsa2k5ZDV5?=
 =?utf-8?B?Vk9hOHROT0F4UG9QSldESFZ1M0UvK3ZCRWY0blQvSStxVy9GWVBQYUM3VFFk?=
 =?utf-8?B?UUROaEpxZE0yZ1dkeDYvem9jdm9oTGpucmFFd1lLajJoNnlacW1uYW1KRUdC?=
 =?utf-8?B?Z002NVI0blpDamVFWEFYVHhZY3NZbDNOVzhySS83VUF0OHJWU1Nrcm5LQTl3?=
 =?utf-8?B?ZlluK2NCVE4xQWNtcWx4V1VvZDlKU0JYNXY1ZVhXaDVaUFhEVGZxMnpNQzEx?=
 =?utf-8?B?dTdFWVErWVZtWmxyS0pPbmMxY3RtVlVtNlJFcUx2VXJBTEZOQ1Y2d2hSWnlT?=
 =?utf-8?B?d3FiNjJJdzI4bFp1dWNqS1Y1RGgvSStJTHNHLy81YWI4WHNBcG1BUW4rNWt6?=
 =?utf-8?B?WHJWSFJnTTR3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OG1UTlBaTndhVDNuWVM1anJmZVZDTVB0QTZjcXdOTFN6RlJpL2lYSW5NOHR3?=
 =?utf-8?B?alRnd1NwN29vVkYxMjVDWC9ueWFKSmlUWCtCTjU1OUIyemN5N2g1SHlHdExP?=
 =?utf-8?B?eVRMV0VEZis3WUdxOVFGQVJwNjJvWlR2cmpkZTRVOU5QTk9UV2FoTDE4dUxW?=
 =?utf-8?B?WW9naUw1cXN3YU1BUHBQbnFrajc3STJBeHNEWWlYVVRxZE1iR204Y3ZLQkFJ?=
 =?utf-8?B?RmRnU2FkaVJmWGYvYjRMQ3NZN1NCS21uUTQ1MGoxZ1hRbXRMOFU0OHFSS1pL?=
 =?utf-8?B?VmlLanpQTmF4K1phdnFWU2FiUUZFTEVOU3MzbUlENXh1TVo0cXUzZStKam51?=
 =?utf-8?B?Sjl1U2hJdTZQUUM2T0hhaWVRblJ0cHc4dFNXWFMzSlBEaWZnVTVYQmdrbWFt?=
 =?utf-8?B?amZLTlpWelRoS2cyc1VtZ2JFRVVWdmtzUXBpc1d2a3huQlRpODdkNkJLSlYx?=
 =?utf-8?B?cTRRSThJYTd1MzYvY3B0TzZvUGUza2ticnQzM2tGVmo1eDNOdUgxTWZWT01y?=
 =?utf-8?B?ci9SdXhhbWZjZWk2UHgySW5tL3d1a3oxRklwUkNVYk00SVJISzE5ZnVoc1hj?=
 =?utf-8?B?QndnY3QyNFN0QXJWQ2JOTm9vaW9rS011RzNvY2MwZC9sT2pVOEQ1bXNDNFBl?=
 =?utf-8?B?dS9xd2tDT00ydzZ3US8zN2d5aURYaXdVWGRuN2xQZHdKNk9Vci9CaGROWEpQ?=
 =?utf-8?B?VXJTakljaG14MUs3MGpwZk9vTzdUS210RnhwOFM4ZzBUMVVKWUdnU2VSZEdy?=
 =?utf-8?B?RmpSM1VqU29TWWtYQUk3K1k4YVFCTzVjTjZMNDV0dno0TzlVeWhrd2M0VVhX?=
 =?utf-8?B?Y2dwTzFIV0R4b0tlWElSKzhFZFh1NlhSUklGdm9VUHlVNzZOeEhjRm5LVXZB?=
 =?utf-8?B?ZTl4NDlPRCtIZkhuK1RaV0Exa2ZiM25ObnZ6dFY1alVBU05hY3IwVGNTU1dW?=
 =?utf-8?B?ek5nLzIzMHg1bm5qc2I1QWJGaE1lNHFZZzdGRFlZck1XNE0wWmdPYlRFY1Fa?=
 =?utf-8?B?bjBjV3dyclEyRloxV1hSa2ZMandaZkFxSHpyc0NTRGpDNVFqY1Z0UTEvSmk3?=
 =?utf-8?B?Ykc1a2NQM29WQ2tVMVR6R0NTRnV1M3BuS0syeG44TjZsdjJ4YUN2UjczMU1v?=
 =?utf-8?B?ZVM1aDFxN3RpaUxzbzFRUEZaWU9xb3psVDd6RlYwYVVsVlAxcE83QzdoVExH?=
 =?utf-8?B?TzFRNDZFdzJwM3h3Yk10d2tIWW40Mm1lLzV5Zm9Xay9jVkhWem0zRUdqNkNB?=
 =?utf-8?B?TUFUSDNQY0tOU0NuVDYzQ05VaWNUQndZRThVZnVDWGt5ZFlZS2lNWTg5UDR5?=
 =?utf-8?B?dEUxRTZ2RkJaeTZYNXIxNXJQN0lvNzEycVAySVhQMVNudHN6enlRTHFzWWdP?=
 =?utf-8?B?bzBKdjNkVXJVU0lmNHByRGFDUkxqb1BwM3RQOS94b1BIaTIxZlVhT1JoKy9h?=
 =?utf-8?B?ZEpxeC8wU0lncjluZ1BGTW4rYnZJaFV3MTFUakI1ZFBLUnN6Y1RTeUdieU5D?=
 =?utf-8?B?NG5LTXVxdjFWMzA2NnJRNmlGaDlLTUwvM3NnajZML3dtQVRqQXZKaUQ2c2Nw?=
 =?utf-8?B?bVhWWDlia3F6ZGVvOGRWUzNDWFZTZzdCZiswYkVxTUM3cjFqLzM2eEpxTFlI?=
 =?utf-8?B?MTMyTUxPeHgrSVhzWmZ3dU1jNUMwU2ZlZDJLSzliYW05czBIWktvcGtvTmMx?=
 =?utf-8?B?M3g4Z0w4eWlTbThsUTdMWTcyaWJiQTNNdXF4ZitsZTFSRktJNkcvaFNzT0dI?=
 =?utf-8?B?ajRXWnlMclQvZmdJOE41NXhmZ2xzL3VOV2l2VGdtMzBqZ1NtajNuemtWS2Jm?=
 =?utf-8?B?UVZ1ZDIzcFA0SU92WFhQbzBnZ1Z6STRUeHoraVZ0dEhVNE41R3hvd1FOeHM2?=
 =?utf-8?B?TGI2SFlhN0h6ZzFqSzVWTDVQRHMram1HNHVYd1dRK0FuQ2o3QzJ2Nk9sby9v?=
 =?utf-8?B?M1RSb2laUjlLbkdranRpSFlESTFiY1E4Z2Z0Tmlheis0am8vUWE5dUFYV0Q1?=
 =?utf-8?B?eVZsODBqRWxiTEthRHNUTzQrV1dvTFNGTU5UVndQb0w2b2I0TDJ6WmdGOGtO?=
 =?utf-8?B?OXBrZmxVOTZoZklRZ0hYSWdkd0k2b24yQS92TjFaNmZqeVlLWmRMOVNkYk9h?=
 =?utf-8?B?S3NJZHZVT0J0am1MelZ3L0lpc2NEYUZmOUxzVlBJYmYwR3JnUFF6RHRDUDJK?=
 =?utf-8?B?TCt4T25GbzA1V2R3ZXplZ0Nmb1hTUUE3RmNyOVU1K3lxMGg3WlZuNWQ5VFlv?=
 =?utf-8?B?QTVrVVVaaFFmQTQ5YWlUOVNaeUlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F38F1D50738D514EBFD6B9398C2C03BA@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 117bab72-60ad-4c51-7ac5-08dd6bcdf54d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 18:50:48.4223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W43XtLHCIgPZ5Dv7f1EM2QB+IgFWZiDeSX2J1nMEtwi6bj/DmDGbbTSkteHyIwCVJ+PiBYNGRq7NWeMyFrOBrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6549

T24gVHVlLCAyMDI1LTAzLTI1IGF0IDE0OjA0IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVHVlLCAyMDI1LTAzLTI1IGF0IDEyOjE3IC0wNDAwLCB0cm9uZG15QGtlcm5lbC5vcmfCoHdy
b3RlOg0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbT4NCj4gPiANCj4gPiBJZiBhIGNvbnRhaW5lcmlzZWQgcHJvY2VzcyBpcyBraWxsZWQg
YW5kIGNhdXNlcyBhbiBFTkVUVU5SRUFDSCBvcg0KPiA+IEVORVRET1dOIGVycm9yIHRvIGJlIHBy
b3BhZ2F0ZWQgdG8gdGhlIHN0YXRlIG1hbmFnZXIsIHRoZW4gbWFyayB0aGUNCj4gPiBuZnNfY2xp
ZW50IGFzIGJlaW5nIGRlYWQgc28gdGhhdCB3ZSBkb24ndCBsb29wIGluIGZ1bmN0aW9ucyB0aGF0
DQo+ID4gYXJlDQo+ID4gZXhwZWN0aW5nIHJlY292ZXJ5IHRvIHN1Y2NlZWQuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZnMvbmZzL25mczRzdGF0ZS5jIHwgMTAgKysrKysrKysr
LQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNHN0YXRlLmMgYi9mcy9uZnMvbmZzNHN0
YXRlLmMNCj4gPiBpbmRleCA3MzhlYjI3ODkyNjYuLjE0YmEzZjk2ZTZmYyAxMDA2NDQNCj4gPiAt
LS0gYS9mcy9uZnMvbmZzNHN0YXRlLmMNCj4gPiArKysgYi9mcy9uZnMvbmZzNHN0YXRlLmMNCj4g
PiBAQCAtMjczOSw3ICsyNzM5LDE1IEBAIHN0YXRpYyB2b2lkIG5mczRfc3RhdGVfbWFuYWdlcihz
dHJ1Y3QNCj4gPiBuZnNfY2xpZW50ICpjbHApDQo+ID4gwqAJcHJfd2Fybl9yYXRlbGltaXRlZCgi
TkZTOiBzdGF0ZSBtYW5hZ2VyJXMlcyBmYWlsZWQgb24NCj4gPiBORlN2NCBzZXJ2ZXIgJXMiDQo+
ID4gwqAJCQkiIHdpdGggZXJyb3IgJWRcbiIsIHNlY3Rpb25fc2VwLCBzZWN0aW9uLA0KPiA+IMKg
CQkJY2xwLT5jbF9ob3N0bmFtZSwgLXN0YXR1cyk7DQo+ID4gLQlzc2xlZXAoMSk7DQo+ID4gKwlz
d2l0Y2ggKHN0YXR1cykgew0KPiA+ICsJY2FzZSAtRU5FVERPV046DQo+ID4gKwljYXNlIC1FTkVU
VU5SRUFDSDoNCj4gPiArCQluZnNfbWFya19jbGllbnRfcmVhZHkoY2xwLCAtRUlPKTsNCj4gPiAr
CQlicmVhazsNCj4gDQo+IFNob3VsZCB0aGlzIGJlIGNvbmRpdGlvbmFsIG9uIGNsbnQtPmNsX25l
dHVucmVhY2hfZmF0YWwgYmVpbmcgdHJ1ZT8NCg0KSSBzaG91bGQgaG9wZSBub3QuIFdlIHNob3Vs
ZG4ndCBldmVyIGJlIHNlZWluZyB0aGVzZSBlcnJvcnMgaGVyZSBpZiBpdA0KaXMgZmFsc2UuDQoN
Cj4gwqANCj4gPiArCWRlZmF1bHQ6DQo+ID4gKwkJc3NsZWVwKDEpOw0KPiA+ICsJCWJyZWFrOw0K
PiA+ICsJfQ0KPiA+IMKgb3V0X2RyYWluOg0KPiA+IMKgCW1lbWFsbG9jX25vZnNfcmVzdG9yZSht
ZW1mbGFncyk7DQo+ID4gwqAJbmZzNF9lbmRfZHJhaW5fc2Vzc2lvbihjbHApOw0KPiANCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

