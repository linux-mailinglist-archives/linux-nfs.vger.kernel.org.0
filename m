Return-Path: <linux-nfs+bounces-3347-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4238CC932
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 00:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB41B21BA9
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 22:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE721422AF;
	Wed, 22 May 2024 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="eIXruyi3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2112.outbound.protection.outlook.com [40.107.100.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEEA43147
	for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 22:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418203; cv=fail; b=Ls3XaCuk47ZgWscQfvyehT6v/vYEmptIjs/ckXlgskDn2+mwjoH+Hd/BJN6p0IeYEcx+qltPHcw1zoc9o6GYyxqNyrQ8rZBJFwBgascllsbot6jwP8MeQZ7gSrwp5g3RFsX+fYPz48anqCNjxlQ11JYjyaZeZ8W9RcLqRZlXD7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418203; c=relaxed/simple;
	bh=7p3KRRp08ptBaBi6zp9z3NukGDZlqfGNPzC1+vb1Zcc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=krmiQ6WWuRBobeSsxHFP7KJFzor4wCZbGaG5DLw6jlRzOAhK6wNIun/jVvqfOEg2h/efIqE63dKUoxXBxJkjisR/jFrc9uzkIpNq/kI2/nf0+myRyaAXyWw2J9el8XodGdmkhpF/EA7eKWGArwtECG1itWsG4h3vYV5P1geCme0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=eIXruyi3; arc=fail smtp.client-ip=40.107.100.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdkz2EwjajpE888bpa7uYkj1WazZdS7CPX+uoHCrjuhtWmw1CtROVX+XSmEvCgFTMn/lcxxXCfgFzRTX8PCZjvDfMZOHqE6pipt345A+t/IYoyQbbgKUwW9Ki/uC3iBEw6J3AXSRsO2P5fmKrKu2UWMcnu+1RFTnH0EKiPAfhIVGWJdkdAG0Lu+K+j5gRfsxq0R7H0e1kEkwTmpIUnt4Aap2StXkhKeeKSmoBLmaUyjyMudeiA/NARHE9BkbcvFuLzqRspBrJ+vf9tzs1h97yzsORh6gM4/aWUm+WHejuWCueiph87Y+NZJVq7e3EAGb2auJSr7CxG4MYxWWCBxsXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p3KRRp08ptBaBi6zp9z3NukGDZlqfGNPzC1+vb1Zcc=;
 b=GH27tF67DQeUReoW3dKMpXvxaGN8cqfmn6MNx7+/8s9AXGN6tC2ZUe07JaotNDUFeQKfjHtmr10qq+PegB66jlhlSEryHDZqQ3p/Fw7zDBxcw502sGlKwbdfNvWiJedQIxh9+KYty0OlwdcyXoOpEZK64MtkLNlVA67Yezrf6XI8dF7IX8ontC8GqgSX2MY8Wi5MxQZ8Bi7ZazCPWaZaF++mPHvSgdCwu72iGpkvna+yzCOrxxCMNu+lGTg/PIM0FbTFGe5irygEceAJ6POyTUzRKpWaP2QJ8yvmpzOTd0HzARdH8DdOQ+4yMEEq/6xflz3s6iky5VLIt2zQTUm97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p3KRRp08ptBaBi6zp9z3NukGDZlqfGNPzC1+vb1Zcc=;
 b=eIXruyi3Znqj+SgtpjeiuRAIHmhocZZ/VMj5y9nuaMU2jl7PkTw2ZT/EC6Ckzm+Mjm/h1z+v8gLpGViF4XAck0TucNnRgQNv70Fq575ishMT8RfUOplId8VOwTytTHo+gPSmmvpI/NMX4lMmO239Nn7Pa/iPyXxzKbOj1PER4hI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW4PR13MB5910.namprd13.prod.outlook.com (2603:10b6:303:1b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18; Wed, 22 May
 2024 22:49:57 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%6]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 22:49:57 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "smayhew@redhat.com" <smayhew@redhat.com>, "anna.schumaker@netapp.com"
	<anna.schumaker@netapp.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "neilb@suse.de"
	<neilb@suse.de>
Subject: Re: [PATCH] nfs: don't invalidate dentries on transient errors
Thread-Topic: [PATCH] nfs: don't invalidate dentries on transient errors
Thread-Index: AQHarJYa7KzWRC75vEOyCDZnb71uAbGj248A
Date: Wed, 22 May 2024 22:49:57 +0000
Message-ID: <9ecb1225e5746054c27ca9488d34510147e58edd.camel@hammerspace.com>
References: <20240522221916.447239-1-smayhew@redhat.com>
In-Reply-To: <20240522221916.447239-1-smayhew@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW4PR13MB5910:EE_
x-ms-office365-filtering-correlation-id: deba752b-42da-469d-1b97-08dc7ab1810a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?eVBIL3VmcTZJcnVrb0dBbjFhTFE4S0xyWkE5VTQ3NlBpdldqbGo3dGFFRkZm?=
 =?utf-8?B?VmlYdFZpSi9CczZranRtSUZCL29EMEQzdHRyNWZrQUo2M1JkbGMvNXhxcmRE?=
 =?utf-8?B?NjlaekN1eEZyTE9pWWVBYzdkV01iMW1ldUJNS2RheFllQXY2aXgxczVnSlVD?=
 =?utf-8?B?YnAzZ2RSWHNIeUNBSjdCdjVNemhzOC9JMW9HTkZmUmxJZGlscHNmNkZSTFN1?=
 =?utf-8?B?bm1VbXNPRlJKV0xTYklLMlVubXJhYS9ROHRxaTRlT3JGSmQ2S0pkVUlBZVEw?=
 =?utf-8?B?TTRtNW9NWER5ci9XS1BzU3VILzdLQnNaSHFoMVdNdExRTk94Nk82L0RqWjdB?=
 =?utf-8?B?eE10RGdMa0RUMFlKNGdTclJYOERaVUJTZ3hxeGhOSGxBNTBNWHhLRkptWlJQ?=
 =?utf-8?B?YzM2OC9sZ3llK2x0dHo2Y2FhRFFMU3I4dnJmd3JRNTZnYlMxdklWc1ZlOElK?=
 =?utf-8?B?S2hTVHAwWE9SdHBXRzRqM1VWd1QxM3lYQUlTVkFCZjFXQmUrUE8yZHJMMXNr?=
 =?utf-8?B?T1Z4bEQrTHNnb2RGYWdzZ1BBMWNlTEwwcjd6MzJkK2VOeVkvVWdSM3h4c3BW?=
 =?utf-8?B?WEUwS05Qb3lkU0Q3WWppemZDOG5MekU3clM2VlJsUEV0TnR3MDRRM2NQMzJh?=
 =?utf-8?B?V0t1UXIzOW1yRDk5bWNWRzRNbjRCMEJEWW52d1BabXRmMXVnY1ZycWhCczl5?=
 =?utf-8?B?eUdpSE50czUxWFZSb2tRVHE4TXJuOGtnT2lpYnJQbjQ4NVAxMi9nMWRtZk8z?=
 =?utf-8?B?S2FVSGJsMXprb1Y2QUxUN2lzeTdpVG53MHpVaXJ0eG10ZjZSTzFIZThpcXpr?=
 =?utf-8?B?V1c5NTgzK01XV294YTg1eWZrVk1wSms0MXhBSktKWlZzaFhCSDFWT2luck9S?=
 =?utf-8?B?TmwwUEVlb3g1RmJLbXNHcTUxYnRPQ09ZTEFCSFdPY04zMXFpU0hMbzdKR3Ft?=
 =?utf-8?B?V05NdnE5RDlJcWFxdEd6S3gyVTdZZ01UUWdvbE9na3prSGw3SmUvZTZXRWND?=
 =?utf-8?B?WkU2Qm9jTW9ZMy9sSlh0NXpSaFZITGZiakdieWdWaThuVmVmMXRscHZFbnFl?=
 =?utf-8?B?blJkYjN1Yzd1K2Zkc2ducWd4NUlmd3BJWTl6ZnRzVXh3Mk56K09yMmV2NEZH?=
 =?utf-8?B?c01EeVFnQWxzbFpzc1JESHpVQ2dId21WSDM0Y2wyVWFQQTJ3d24zT3RXalFt?=
 =?utf-8?B?aEFaN29wRlo4ZlA2M1YwaGtOS1QvNXMzKzlVN1hZNU5BWTdwUG9WdzNaNnEx?=
 =?utf-8?B?L1ZEV29Mc2FjWHFjaTlNc01OZ0ZZTEwwYUNiNld0blFWOXZmNU12MlM5UmJT?=
 =?utf-8?B?Mm5lR3NGN3FQOWtlOVd3Z2M3ckdFSVBqaUx3QTd1ajdXd21ZWVYvQXpTZUF6?=
 =?utf-8?B?ZGVOVE9XN29nci9OWkxMZElyWmozRCsvMVRucTFjcGhMc0VnQk9yNkhUbTJh?=
 =?utf-8?B?dDRzME9VVFUzb1dCUTZ3dXpDMGorVFVWUHE3eDYyRHdiVFVCOFYzOFF2SWRN?=
 =?utf-8?B?YlpRUEdUVlFqdFFaVzJXZXVvSGNLai90UnArSmRKUUNISDVhTnBPRW1TZEor?=
 =?utf-8?B?ZGZFcVlkOWRPM3IrUVNIdTlwYmxVVWFUNnN4VXJ6YUVBQWpLMnIrNjFORkZD?=
 =?utf-8?B?QkU5Wk03bUpNVFBGMS92UTVyWDNPSHc2M01RM0U2NnM3cjNwbFlQcnc4WW9T?=
 =?utf-8?B?UE5xUEVHRzNJMEtyMzhXQU42MTNKQ0lVL095MzlNaVB3d05adVJqMVI3Qjg5?=
 =?utf-8?B?aS9CaWlFL1BZaDNQSFBxYitlSkN1MXBxWmVybzNqU2Y3ZHFQamFib1M3U1R2?=
 =?utf-8?B?cTh2cDd0RDBUanY5UzVIUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmlpclZ5aEZYR3NjVHk5MEZqSzJwRmxZUXdrd2JMOGp0NVdiZlMza05EdUVG?=
 =?utf-8?B?L0ptNDBnMU1sNHBjZVFIeXp5WVo1UDlaWEpWTlFoUk5nc3hLWkNyVGhDZnpz?=
 =?utf-8?B?OGVib0ltZ3ZuSHB0ZXN2WWEzV0laR3RBd1F0ZW1lZHJCajBmZUZVZUhZZmlJ?=
 =?utf-8?B?YmhTMWs3U284dm9FTFZrcmtYMmY1UVhia2tnUjRhdkVSb2ZPU1F5YXNYY25Z?=
 =?utf-8?B?SGtPbHdzNXltTU1oMDcvK2J5bEc3K2ZFOFJ2WkdHeHUrdURHeldsRzYrSGdX?=
 =?utf-8?B?aDQvM2g3WFJuYlhkajRiN1pOWm9xQnNCRjFHbmtCViszeHBZaUJHM3BkTmQ2?=
 =?utf-8?B?cGQ4ZU5WNVdHNDhDcll2TzBVKzc1NU9tVEV6R0g0eXB6dEZSZWxzYXlJQTZu?=
 =?utf-8?B?VnRoei8zZGhTTU4vd1VoT3R5ak1VNENObFZZYTduTnl4aUhkVVJmcVk0aWZw?=
 =?utf-8?B?Y3M4L2l2ZG5sandXb1Q4Q0FWVHlLNzZnZmJPZ1dVQXIyRG5acUdJbEtZZ3hB?=
 =?utf-8?B?Q0lHczdzZSsxM2VMbXV1MnZQK3JyM3BMTkNRcVRUclRsZnFZdjBPd1gyVUZk?=
 =?utf-8?B?L1llVzJtNEQ5ei9vdHVMNklkTWp5TGNNT3FHNUdSMkhadlhFQ245SmtlVG5l?=
 =?utf-8?B?UFk0NzNlaTFNdXBobVpOdlZHZVVqWVFITHlpWm5aT3RlZjZqWTd3ektuS0pU?=
 =?utf-8?B?OU1KUncrL0hicFR2ZDlESGw0Tkw2eDZ3MUExbUJvZXpoNDJmY0JCS3lkZGU4?=
 =?utf-8?B?eURvNDNSREJjbFVxbmQybkRabkJlUnA1eEs1cklNR0pHQW5kTHdnRUdyeTNz?=
 =?utf-8?B?UUs1SzM0MXNkRnpDNHNDeVZiZHZIVCtnTWV0NElLWTc4bUkyaEhkdkR6bGVr?=
 =?utf-8?B?VmFORUt5Z05aektzSHg5dC9LbVpYaHNjRkVPNDZXL24yOUZabmZtdEpNQ3Jz?=
 =?utf-8?B?UStsR3RZakdTOVVObkZHN1NTRGdzUUtFNlNJYU14TXc2bzVaRXNyT3BBZzZT?=
 =?utf-8?B?TUJjSXEyR1pocDhBSVJTcUdIVkFpaTg0ellPWXdyN2plT0tQZ3U2bVJmWnA2?=
 =?utf-8?B?angydUJadTY5VXQwK1dNVFROdFptNjVBY1BOd05LZzIrRyt2eUE4S3pzNGRH?=
 =?utf-8?B?Q1VaZUZnbGY2ZTNSYlNUajFYVW9NMS9lbG5aemxvcFVRL2dpTWpoTHY2T0Mw?=
 =?utf-8?B?K1VZb2h1a3Y5SnNiMlZzRWpUbzVqMFFRYUFhVFF3ZGxhU09DRDBjRy84TkVO?=
 =?utf-8?B?bDhZbjVyb1JtVVN4ZXkzL280Ty9ETERPNkZUN05ScEREUGlxTnJMUmV1Q25p?=
 =?utf-8?B?bE42N28zSnZOSkJuL2ZyLzBXWkdEbE5XbCtrdG56RUxpSUhvaHdtVFJBMEg5?=
 =?utf-8?B?U28yaUZ0cXlOS21MallRVCtHREU5TkViRytiMmlFb0tPOUNQTzVRcHNzT1dH?=
 =?utf-8?B?OGdjV090RUJOMlRPdTlFLzRSVXlONkNzSXVGb2c1MkFDdG1QS0pXUEQyMW1O?=
 =?utf-8?B?ekdEd054azJ1bnU2SkVRUzY0QVlqaFN1SXA0Ri9lYVFvSUwwUVRheC9aM29L?=
 =?utf-8?B?bzRpZmNYRFZyMFVpNEZmYjRDdEU5YkNMdzZLdkhKQUhkenBIWVZab1hiNWJu?=
 =?utf-8?B?SnRBN0VFQXg0SkZYc2pOZWk4T0tHT2w4LzVlQkhVWFJ6ME5FUVIwUlh1czI4?=
 =?utf-8?B?NTJqN01HZ2ZLMU5acmswMi9JZE1aTGpLaFAva3JiYi9CWVBjZHpwd2JLZFE2?=
 =?utf-8?B?NzlvemFaRXRzQlc2b20yU1R2eUxvcVltUkE1cVUwcTZraTkxOHFIQTNJMWdr?=
 =?utf-8?B?U1NwN0dHOGpGeXdiK1RHekkzQklEOUZwQTJBMzMxRDlFZFBlQmJrN2xtL3k3?=
 =?utf-8?B?ZDBGTU5DdTM2NGhzZGFLbE1RV2RZa1dDcWszUmVQRUpwcklRY1hnZDlSNVN3?=
 =?utf-8?B?eE1qL2R2Vkk4RnlRSUh6dTNGUDJKaGlnRjN2YVJ0VzNsUTlucmpCbUhkYTZp?=
 =?utf-8?B?UjQzZ3I4bHQyMHdRZXVDK2w1Qm5FNC82UWlDK3VpU3Q0SlZoVTZDMURHdEp2?=
 =?utf-8?B?Rk1Ba0x5N2RONllkcC83c2lNQzNCSnNpSkRnZFRVcitmcVpsNjdoRTVmRlZ4?=
 =?utf-8?B?Vjl3NDJmcUJBUXJGb3RiRTJJYm5LOHVORUpaUTlGOXJFcXNOcU9hTm8rQmd0?=
 =?utf-8?B?dXAzN0ZOWVhMTk9iUGpFSFNJOUNPMHphVlQ2cjZ0c2x1TE1PNkpabHllQXU4?=
 =?utf-8?B?cEY0bXVzWG1KY09kbjcyUTc2UWt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F2C8E1C9861DD46912A0D508F81F255@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: deba752b-42da-469d-1b97-08dc7ab1810a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 22:49:57.2186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90if+PnEoNr57Wl7lQZ89NsZv0rMDACSD9UudOadsuvl+TEZbzPevGJEzl9WRoMN/i9P3blLiwb9HOatEX6FSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5910

T24gV2VkLCAyMDI0LTA1LTIyIGF0IDE4OjE5IC0wNDAwLCBTY290dCBNYXloZXcgd3JvdGU6DQo+
IFRoaXMgaXMgYSBzbGlnaHQgdmFyaWF0aW9uIG9uIGEgcGF0Y2ggcHJldmlvdXNseSBwcm9wb3Nl
ZCBieSBOZWlsDQo+IEJyb3duDQo+IHRoYXQgbmV2ZXIgZ290IG1lcmdlZC4NCj4gDQo+IFByaW9y
IHRvIGNvbW1pdCA1Y2ViOWQ3ZmRhYWYgKCJORlM6IFJlZmFjdG9yDQo+IG5mc19sb29rdXBfcmV2
YWxpZGF0ZSgpIiksDQo+IGFueSBlcnJvciBmcm9tIG5mc19sb29rdXBfdmVyaWZ5X2lub2RlKCkg
b3RoZXIgdGhhbiAtRVNUQUxFIHdvdWxkDQo+IHJlc3VsdA0KPiBpbiBuZnNfbG9va3VwX3JldmFs
aWRhdGUoKSByZXR1cm5pbmcgdGhhdCBlcnJvciAoLUVTVEFMRSBpcyBtYXBwZWQgdG8NCj4gemVy
bykuDQo+IA0KPiBTaW5jZSB0aGF0IGNvbW1pdCwgYWxsIGVycm9ycyByZXN1bHQgaW4gbmZzX2xv
b2t1cF9yZXZhbGlkYXRlKCkNCj4gcmV0dXJuaW5nIHplcm8sIHJlc3VsdGluZyBpbiBkZW50cmll
cyBiZWluZyBpbnZhbGlkYXRlZCB3aGVyZSB0aGV5DQo+IHByZXZpb3VzbHkgd2VyZSBub3QgKHBh
cnRpY3VsYXJseSBpbiB0aGUgY2FzZSBvZiAtRVJFU1RBUlRTWVMpLg0KPiANCj4gRml4IGl0IGJ5
IHBhc3NpbmcgdGhlIGFjdHVhbCBlcnJvciBjb2RlIHRvDQo+IG5mc19sb29rdXBfcmV2YWxpZGF0
ZV9kb25lKCksDQo+IGFuZCBsZWF2aW5nIHRoZSBkZWNpc2lvbiBvbiB3aGV0aGVyIHRvwqAgbWFw
IHRoZSBlcnJvciBjb2RlIHRvIHplcm8gb3INCj4gb25lIHRvIG5mc19sb29rdXBfcmV2YWxpZGF0
ZV9kb25lKCkuDQo+IA0KPiBBIHNpbXBsZSByZXByb2R1Y2VyIGlzIHRvIHJ1biB0aGUgZm9sbG93
aW5nIHB5dGhvbiBjb2RlIGluIGENCj4gc3ViZGlyZWN0b3J5IG9mIGFuIE5GUyBtb3VudCAobm90
IGluIHRoZSByb290IG9mIHRoZSBORlMgbW91bnQpOg0KPiANCj4gLS0tODwtLS0NCj4gaW1wb3J0
IG9zDQo+IGltcG9ydCBtdWx0aXByb2Nlc3NpbmcNCj4gaW1wb3J0IHRpbWUNCj4gDQo+IGlmIF9f
bmFtZV9fPT0iX19tYWluX18iOg0KPiDCoMKgwqAgbXVsdGlwcm9jZXNzaW5nLnNldF9zdGFydF9t
ZXRob2QoInNwYXduIikNCj4gDQo+IMKgwqDCoCBjb3VudCA9IDANCj4gwqDCoMKgIHdoaWxlIFRy
dWU6DQo+IMKgwqDCoMKgwqDCoMKgIHRyeToNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvcy5n
ZXRjd2QoKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBvb2wgPSBtdWx0aXByb2Nlc3Npbmcu
UG9vbCgxMCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwb29sLmNsb3NlKCkNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBwb29sLnRlcm1pbmF0ZSgpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY291bnQgKz0gMQ0KPiDCoMKgwqDCoMKgwqDCoCBleGNlcHQgRXhjZXB0aW9uIGFzIGU6DQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJpbnQoZiJGYWlsZWQgYWZ0ZXIge2NvdW50fSBpdGVy
YXRpb25zIikNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcmludChlKQ0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGJyZWFrDQo+IC0tLTg8LS0tDQo+IA0KPiBQcmlvciB0byBjb21taXQgNWNl
YjlkN2ZkYWFmLCB0aGUgYWJvdmUgY29kZSB3b3VsZCBydW4gaW5kZWZpbml0ZWx5Lg0KPiBBZnRl
ciBjb21taXQgNWNlYjlkN2ZkYWFmLCBpdCBmYWlscyBhbG1vc3QgaW1tZWRpYXRlbHkgd2l0aCAt
RU5PRU5ULg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2NvdHQgTWF5aGV3IDxzbWF5aGV3QHJlZGhh
dC5jb20+DQo+IC0tLQ0KPiDCoGZzL25mcy9kaXIuYyB8IDI0ICsrKysrKysrKysrLS0tLS0tLS0t
LS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvZGlyLmMgYi9mcy9uZnMvZGlyLmMNCj4gaW5k
ZXggYWM1MDU2NzFlZmJkLi5kOTI2NGVkNGFjNTIgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9kaXIu
Yw0KPiArKysgYi9mcy9uZnMvZGlyLmMNCj4gQEAgLTE2MzUsNiArMTYzNSwxNCBAQCBuZnNfbG9v
a3VwX3JldmFsaWRhdGVfZG9uZShzdHJ1Y3QgaW5vZGUgKmRpciwNCj4gc3RydWN0IGRlbnRyeSAq
ZGVudHJ5LA0KPiDCoAkJaWYgKGlub2RlICYmIElTX1JPT1QoZGVudHJ5KSkNCj4gwqAJCQllcnJv
ciA9IDE7DQo+IMKgCQlicmVhazsNCj4gKwljYXNlIC1FU1RBTEU6DQo+ICsJY2FzZSAtRU5PRU5U
Og0KPiArCQllcnJvciA9IDA7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgLUVUSU1FRE9VVDoNCj4g
KwkJaWYgKE5GU19TRVJWRVIoaW5vZGUpLT5mbGFncyAmIE5GU19NT1VOVF9TT0ZUUkVWQUwpDQo+
ICsJCQllcnJvciA9IDE7DQo+ICsJCWJyZWFrOw0KPiDCoAl9DQo+IMKgCXRyYWNlX25mc19sb29r
dXBfcmV2YWxpZGF0ZV9leGl0KGRpciwgZGVudHJ5LCAwLCBlcnJvcik7DQo+IMKgCXJldHVybiBl
cnJvcjsNCj4gQEAgLTE2ODAsMTggKzE2ODgsOCBAQCBzdGF0aWMgaW50IG5mc19sb29rdXBfcmV2
YWxpZGF0ZV9kZW50cnkoc3RydWN0DQo+IGlub2RlICpkaXIsDQo+IMKgDQo+IMKgCWRpcl92ZXJp
ZmllciA9IG5mc19zYXZlX2NoYW5nZV9hdHRyaWJ1dGUoZGlyKTsNCj4gwqAJcmV0ID0gTkZTX1BS
T1RPKGRpciktPmxvb2t1cChkaXIsIGRlbnRyeSwgZmhhbmRsZSwgZmF0dHIpOw0KPiAtCWlmIChy
ZXQgPCAwKSB7DQo+IC0JCXN3aXRjaCAocmV0KSB7DQo+IC0JCWNhc2UgLUVTVEFMRToNCj4gLQkJ
Y2FzZSAtRU5PRU5UOg0KPiAtCQkJcmV0ID0gMDsNCj4gLQkJCWJyZWFrOw0KPiAtCQljYXNlIC1F
VElNRURPVVQ6DQo+IC0JCQlpZiAoTkZTX1NFUlZFUihpbm9kZSktPmZsYWdzICYNCj4gTkZTX01P
VU5UX1NPRlRSRVZBTCkNCj4gLQkJCQlyZXQgPSAxOw0KPiAtCQl9DQo+ICsJaWYgKHJldCA8IDAp
DQo+IMKgCQlnb3RvIG91dDsNCj4gLQl9DQo+IMKgDQo+IMKgCS8qIFJlcXVlc3QgaGVscCBmcm9t
IHJlYWRkaXJwbHVzICovDQo+IMKgCW5mc19sb29rdXBfYWR2aXNlX2ZvcmNlX3JlYWRkaXJwbHVz
KGRpciwgZmxhZ3MpOw0KPiBAQCAtMTczNSw3ICsxNzMzLDcgQEAgbmZzX2RvX2xvb2t1cF9yZXZh
bGlkYXRlKHN0cnVjdCBpbm9kZSAqZGlyLA0KPiBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksDQo+IMKg
CQkJIHVuc2lnbmVkIGludCBmbGFncykNCj4gwqB7DQo+IMKgCXN0cnVjdCBpbm9kZSAqaW5vZGU7
DQo+IC0JaW50IGVycm9yOw0KPiArCWludCBlcnJvciA9IDA7DQo+IMKgDQo+IMKgCW5mc19pbmNf
c3RhdHMoZGlyLCBORlNJT1NfREVOVFJZUkVWQUxJREFURSk7DQo+IMKgCWlub2RlID0gZF9pbm9k
ZShkZW50cnkpOw0KPiBAQCAtMTc4MCw3ICsxNzc4LDcgQEAgbmZzX2RvX2xvb2t1cF9yZXZhbGlk
YXRlKHN0cnVjdCBpbm9kZSAqZGlyLA0KPiBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksDQo+IMKgb3V0
X2JhZDoNCj4gwqAJaWYgKGZsYWdzICYgTE9PS1VQX1JDVSkNCj4gwqAJCXJldHVybiAtRUNISUxE
Ow0KPiAtCXJldHVybiBuZnNfbG9va3VwX3JldmFsaWRhdGVfZG9uZShkaXIsIGRlbnRyeSwgaW5v
ZGUsIDApOw0KPiArCXJldHVybiBuZnNfbG9va3VwX3JldmFsaWRhdGVfZG9uZShkaXIsIGRlbnRy
eSwgaW5vZGUsDQo+IGVycm9yKTsNCg0KV29uJ3QgdGhpcyBub3cgY2F1c2UgdXMgdG8gc2tpcCB0
aGUgc3BlY2lhbCBoYW5kbGluZyBvZiB0aGUgcm9vdA0KZGlyZWN0b3J5IGluIG5mc19sb29rdXBf
cmV2YWxpZGF0ZV9kb25lKCkgaWYgdGhlIGNhbGwgdG8NCm5mc19sb29rdXBfdmVyaWZ5X2lub2Rl
KCkgZmFpbHMgd2l0aCBhbiBlcnJvcj8NCg0KPiDCoH0NCj4gwqANCj4gwqBzdGF0aWMgaW50DQoN
Ci0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

