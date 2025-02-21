Return-Path: <linux-nfs+bounces-10274-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2E0A3FAFF
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 17:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0269D188F56B
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069A921507B;
	Fri, 21 Feb 2025 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="QsTTl9B9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2120.outbound.protection.outlook.com [40.107.102.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98EC215163
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154411; cv=fail; b=dYBQ9RtgJheI9nAdFFk1qhYBKkqksomKoRMXKmFRGRsi+jmBsijPB1IXk8koVzSAHJHLirAT+9llz/IT3tOUOVrMM9X1CEUte2niQd8EGHIjrAq2dW1feHXG/8umL2mlhtuFLrGMrjDbn9VfmG1DiInAYXDkLxsvVpn80UVCmMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154411; c=relaxed/simple;
	bh=1uueg+BctMOUd8IVPx1CIg6OP7kfJGmix+qZ4Ax+4Js=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OrRpagN34KsVFM8gPIqmUhUWTuiHRAMvRay9g/f/N+Y5rtwvjMB4FH34OO4xbfGReBV1cek0ShV5gYJSqEtIFEVdSfGLmvOh7BsBiDljEDRbf+p53ZE7OHNS64TdITCRdhZlZtKayJgsH0LeixhzWvLL59pvOlPfRXxWvvekjsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=QsTTl9B9; arc=fail smtp.client-ip=40.107.102.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zlg/BzmyVtnxud9tQfRdU1ByBfSWBHfdDoVRPEot/0f3LXilZdVnnoFiydTqGNugYcXoD926oxAIS8m3WeP0D7sgQhXNO25WX7y4P9uR2a+PvX6KUH2VzrrZyru0gNkOjrji/28+7J6V8zksox4uaUS1lGlN37XYYPnbzVv1lcC6yy/U19tm1+CJ7EsHMszlx/qYou+zxagcIixmWmjLnP4AKnoNY3Zt6hwoIoZNNxEwyh0GBH0XOwQ2XQJjlaUZZ8KDwkX6qlXDZLmrxV9tCYTR8MAkbeJjPQE90DU6s3ut3wLL8Pv0Sdzf7/IF4b4u1QNFPHwgdtTGYm2hmQC0sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uueg+BctMOUd8IVPx1CIg6OP7kfJGmix+qZ4Ax+4Js=;
 b=JidfUROT0F9GOCbOJdaOsoYlcR6tmcVuaXEKhknLpNba/1cwlyoQ9GJAHesevpJCXOnTP34EJRaK2nuhaVezwSG6CtiAbgbHFJp6fNYuSjH9kEihKk5uFXUfli29GleO4qAzXMNaQQdqqYk1v/mKQYHexcDS4n6jhVvN6uaOBl6m0HK5sMhW1EcSc4mwMvF21nJ67f70tWDnpAlzgECo4p9vwRff/nz8RTL/IRnA9vHEdwrDB2hS5roMaguTjJREdn7PY34acZeMMEYS6RWtlWyPxmCBl2Q0JcjQcbS7RzZIDAMwmjC3QCPixh8rfm+P79VUBAy/qwsXApIrxSUS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uueg+BctMOUd8IVPx1CIg6OP7kfJGmix+qZ4Ax+4Js=;
 b=QsTTl9B9BXR9kKcrGaVDSsfMyFwgoIQK91X8ZCW6UaOW8mDPQUZRjdwUupDbF68UBjEQ4GAz0+UJTsToCrCrusHd9ZhgLvFnRpGWUqiroKA1PsbhnCcsQ5kloOCJGcBi65F2hFBsEjgi4I5k+ainozb9p8VtzMLDO13IaAhKXQU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB5117.namprd13.prod.outlook.com (2603:10b6:408:160::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 16:13:27 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 16:13:27 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "snitzer@kernel.org" <snitzer@kernel.org>, "jlayton@kernel.org"
	<jlayton@kernel.org>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC: "okorniev@redhat.com" <okorniev@redhat.com>, "tom@talpey.com"
	<tom@talpey.com>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "neilb@suse.de" <neilb@suse.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: nfsd: add the ability to enable use of RWF_DONTCACHE for all nfsd
 IO
Thread-Topic: nfsd: add the ability to enable use of RWF_DONTCACHE for all
 nfsd IO
Thread-Index: AQHbhHG829RmuJMFp0e5I1R2FeBUXbNR4KqAgAADEACAAAMGAIAAB26A
Date: Fri, 21 Feb 2025 16:13:26 +0000
Message-ID: <7b1574e2499da99986c432f815abccb2e5a6c7f5.camel@hammerspace.com>
References: <20250220171205.12092-1-snitzer@kernel.org>
	 <ce92e5f6-d7cb-47ef-ad96-d334212a51f1@oracle.com>
	 <Z7iVdHcnGveg-gbg@kernel.org>
	 <b101b927807cc30ce284d6be9aca5cbb92da8f94.camel@kernel.org>
	 <Z7idYDSHD_hcLL9b@kernel.org>
	 <6bd2aa18-e52b-47e6-9151-4ff80d1a39b8@oracle.com>
In-Reply-To: <6bd2aa18-e52b-47e6-9151-4ff80d1a39b8@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB5117:EE_
x-ms-office365-filtering-correlation-id: b14ce6e7-659a-467a-7448-08dd5292ac83
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGJnd0lpRm81ZHNMNEJ3Y3ovbTF6ditzK3NWRlVoWXpIUGFFWmNvRnhoNDcw?=
 =?utf-8?B?aXppbFBPMmJrWitBQ0poNjRUTU5YTG5zRzhiQUN2QUViSHUyVUJqNmRoZXVU?=
 =?utf-8?B?Z3E5MDVIU1ZrbU4rTVM2dWNOd3ErZmd6L2JOV3dGOEhwRFFHbHhqZTQrWVNa?=
 =?utf-8?B?OXhMcXRiZU5KMWJsWGhKOWxGRXl2YkRoakFXdzl2MTFDVnFyaVk5cWNtajZP?=
 =?utf-8?B?RDVFT1pzZHhpV3loVUZaVjJhcHU3SzNIYXl6L3NUZUFEZk5BbkZxdWZad3hH?=
 =?utf-8?B?V1BlQ251TEFBWldNRHlVZEtFblp1REluMlRxN3UwRWhvb2JYcWhoaWl6TTBE?=
 =?utf-8?B?cHc2K3d3YXpFTU5XWXFtdzF3eU9VcGRvMXpIUHptZTBudHhxQjNqT0RKZjZa?=
 =?utf-8?B?NjNRN09VQlRtMHNPdFlXMzZDejdFYVhLQzMyUkJJa0d3V05vTElrdmgzcWFr?=
 =?utf-8?B?RUdlYTU3NVlFNUErK3NrbmxwblZFM0E5VENoUWFSV0t4NXFWcUdIYW1FUUFp?=
 =?utf-8?B?SVVUT1ZJU205OGhpRVUvdFFTTFN0Y0JISk1CYmhnbE16a0FyQTZIdWRzQnRt?=
 =?utf-8?B?R2swbzNOakMrQ1ZmNVdWWVlkdXNGNzd2NS9nVENpL01sSEtyVDZVbmkraDZH?=
 =?utf-8?B?dkd5cUhxTnNLSVRQTnhYa3I1c01IMlhDTTFQZmJ4T3BUbjdmNnNWb1dTZWtj?=
 =?utf-8?B?bHJGNmlhMmNtNjRMalJ5T0U4RjZFTkg5dnk1RndXNTRqaitWdFB1TFlkbHBH?=
 =?utf-8?B?NzdvZi9iSmt1ekNrSnU1THhlOTdLaUVOR3lodnRBL09Ib2piY3k3Z0Y0S1I5?=
 =?utf-8?B?OVVta1RYNmNwRThYcGlVMUJwZUNIeTNkeHA2anRUOFdHR0VPN2MwTzJDTlRG?=
 =?utf-8?B?TzJuZmFNSm5tY21IU2FDTFRHbnh2cmVGaTg5R0ZsVUVuS3prbGxFRGtQYUcr?=
 =?utf-8?B?RjFPN1F6WFBMbkFIelZKdTh3NmlMS3RZVHF1dEhRTWY3RklpRkVVVU5tT2RT?=
 =?utf-8?B?SW54US9LY000bTlUWitxaTNaaFM5NGtZUUllaWJNZ3FzOEcyR3kwd3ZteVNn?=
 =?utf-8?B?bmxmLzVteWxGZVJDNnFyUlJnMllDRzZGdE1kQnhQeFVreUY5TlFYdGoxa2w5?=
 =?utf-8?B?U0xVdFNKcXFPeGVlUnRDRUYvTmwwWmROeGVJRElIL2NtVDhzTFJWTWRhdmRQ?=
 =?utf-8?B?V3ZvVlM5aTV5eit5SU5SQVJTUTgrdEQ2Z0xDNVhKZHczQWJLUUx5cHYrQUFJ?=
 =?utf-8?B?VTFiS0lVM3RQMytYSll1RzI2aW9JanpsaGhTWmUxVk5tWnppMzhuRTNBVEk1?=
 =?utf-8?B?RndsQjloaVlleUJKU2NUQXlrZzhmSVpKalBoZk80ZTlITkNQanFpOXk3NjZy?=
 =?utf-8?B?ejN2QUUya1QxYkFDdDJ3djZxOEhTNVU2UG5ZeTVnNk93cGdpMytka3VraUdz?=
 =?utf-8?B?ekZURVRuQ29OL2R2a0hkMjFwc2Z6R2RFMUJpMThhQ0ZCSCtLSFFKVXNMbWQr?=
 =?utf-8?B?c1pOMUVvUXBhbEptOVgycVpESUV0UGhLMjZFbkF3U2U1ZXNiZkZPd2lPMnQ5?=
 =?utf-8?B?dXdjVE94MzNqRG9Zd0xpbmpHcEhTNVplMkZ3S2l0TGlxVzZGRW9VMXo5bDNx?=
 =?utf-8?B?eXJ1VUlLcUgram5vV29LQlpSVENlTlp6bTBkZWw5eTBaUC9tQlptdDRMckcz?=
 =?utf-8?B?QTdyR0lkYkRmVFdZbTMwYjJ3eXU5M3Nlb2lOU05rSGswb3lobmdrZUkwWjE2?=
 =?utf-8?B?K0lPTkJqSFR6Y1dKLzBSTnVINVowMHI0bTZWNG5UNG81TTJwZHF1Y21aUm85?=
 =?utf-8?B?cVVyVXRoNmNmUVhwZ05Ua05vSDY2RVZCenpsZ3N3Tk95eUtGdXlIUTl0U0Y4?=
 =?utf-8?B?WlkyRTREa2dHbkRud1JBK2JoVVFzU3YxMHgwT0duMFR2Nmh4TW1qcitSS2NK?=
 =?utf-8?Q?dpluEaXBbRCGgeFIucnTXcjx1jmwElav?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eEprbkRvVW9XdzlrR3phemM0Z2szcDdQUnBybG5GU2JGZUQxa2FKeVhNbEdw?=
 =?utf-8?B?ZjdHamVxWWtFOE1QeEpldHczTzlQNWo4eHBCdjhVMTYvMmIyWHcyNXRXV2lP?=
 =?utf-8?B?b1pWd1FLdXJraTdJazdlQzN1bUlsSnQ3cGE1V0V5dm9leGJWU2tBVGloTEZL?=
 =?utf-8?B?ZEtlc3NuTXN4dzNjNjQrbEdidmk5dW5LRFJ4Rjk3bkFJdEp1emFCanVSVERq?=
 =?utf-8?B?MGxMK3FEYUU1eEZxNEhQTjNQUDBkUEFRZmxCWWZVOHJ2UndMYXRIM0V6ZkVk?=
 =?utf-8?B?NlJEZ3FoOTg3VnNxZUx4dHhFSEcyWi9wdS9iVXl6NDV6WndJM3grVFpNZ3pJ?=
 =?utf-8?B?T0libWhvNzc3VzVTZDhqUEo3Rm5NL0E1V2l2UUNsZnhIR05TZHFHOWVQU2tw?=
 =?utf-8?B?aXlvSkNwOHV4aWN3MksyMitjSHV1QkU1ZGg5a2puVU05MzJmd2F5SzdXTExB?=
 =?utf-8?B?bXk2K25WSmxORWV4c2tuV0JRdTF3MURQVzNxUWxpT1lKS1VYQS92VW5zck9D?=
 =?utf-8?B?NFdBYUtKSmVCM3Q1YURIelFCNVAyTW9hWGZqRDdoYjJhclkwRWJtajdOalZy?=
 =?utf-8?B?WlJpZFROWm1SYm0va0NtK0QxczJDcHBMTFVPSjNxWDg2ZjloN2l6U1JOU2xQ?=
 =?utf-8?B?QzlQdlBJV1lwMnI0ckp1V0JFQ2c5bWNSbkkxZ0RZT3ZGekozWFBEYzVueDE2?=
 =?utf-8?B?MnRUQmpseE1YRWZJTWJpZnRmTlU2VFdPTkxhUzJ4TDJLa1FYY2lQYVd6ZFlP?=
 =?utf-8?B?eHl1MzVGeU1TVndVOFU0VjIyekUveXJpRVlIQnBISHViOUcrako2VEg0KzBX?=
 =?utf-8?B?L3JxSWx0U3pRNXNuTzAycHU0c0xYd1MxQlhSc1BTcEc4NFZhQVBNZ0RkMStW?=
 =?utf-8?B?U0xnZE5JMTNSTHk4ZVFwY3JkODVuQkVibkl4WE9VN0tORFVudDE3RGJMdExn?=
 =?utf-8?B?b0pvUHgrQjg1anhCL25rRFprVTNVWVR4L1MxMFV0ZVVsZWdxWkRBZkVTakl0?=
 =?utf-8?B?M3hZd3NIWnp6d1dxUVFoNlVJeU1aVGpkd2JzWHBwbHVWRURsSFJ4RzIzYzV2?=
 =?utf-8?B?V2pSMXhHQ2RHZXZ0RzUrMlIvMHVaanU3ZHZqK2hRM0lLTmp5UWhQRFlPOVhD?=
 =?utf-8?B?WnVyWnhKV1V5UFY0dDE3QVl0T3Yrc1p2b2tmcEpOM2w3TUJTTG0rcVhHNE9o?=
 =?utf-8?B?RTZrVUN4b1pWRDhEblk3ckk4OGJLMlUrYlhNS3lMQXVZdy9tMXhXdTJpdmlD?=
 =?utf-8?B?Mk9WNDFqOUk4bEphVXlqMlpMNzJkT3lVQStOSm1INHdvNWZZYzhYSmlKam1Q?=
 =?utf-8?B?bVdTeXdockNUdlVQSWg5Qno5Q1hISnpINFhWK1VUZFpGaFJndXA4SFAyeWxX?=
 =?utf-8?B?Y0JaMkowUkYrb3J1T1MyM3ZqV1pZM1ZZR3dnbGVkQ0JPMDNjeWZDRFNKMFFI?=
 =?utf-8?B?aE1DcFU1VlduMk92b3ptdGlFVTNuSlFqaDJKTnFoTHRzcGdvckRoWTFIMElo?=
 =?utf-8?B?TFYwUDd0endpdWVQN1FIYWhCVWd2RlNsMUZwNndsWFcxa2J6dE0zK0ZEbW16?=
 =?utf-8?B?dzdMK2tLOWhnRE9HZzZNM3FISWpqeGJwaUNZRzJUaTlaLzNuc2RIQ3lGRnBO?=
 =?utf-8?B?OEI2Z2dlTk1wUlpXRTF1c0V3RkhlenE4N29Sd3pMbXRzcEYzMi95OVdtVDAx?=
 =?utf-8?B?bjlsYmVXQndxUjV3Um1sK3VmQ3hSN3FEdU1lQlVNNjMyQXZuRDRRUGM0YWhQ?=
 =?utf-8?B?eUpkQ0s2MkJCTWdQSUZ6UFJCbGVid3pxZmZiVHJaUVZpUXpOb21UY1N6b0JS?=
 =?utf-8?B?KzM5THJrcVFOUXRiaXpCL3U1Zk9YaXVKT2JHQi9xcXhlcEJsWTBqUmwyUkNI?=
 =?utf-8?B?aDBMLzVYektYZW9TaDFZVGh5dVljTjlNeXFCaFBHa1Q3dWxuK0d6RWx1alRl?=
 =?utf-8?B?ZnplbzRONG9TWGRaVEhpZTJkNUJxTFdkK2twaHlrMnZEVkxOb1lnSXZLRGUw?=
 =?utf-8?B?dzNtSFRMWlFnL1lmZWZidFJlVGpLL1NaL1RrS3BJUVR4dEVIVFhlRVh3MlFQ?=
 =?utf-8?B?OFhlaTJiSzduZ2h0SldoT09uVE5BR3pocW1PcnhBQ2lpUGd6K0kzbHJ4TldS?=
 =?utf-8?B?TzZzZ1lDV0VEOVpxZWhGb01URzNtYnlRdkNPQ1phY2h1TmY3OVNKa1B5eGhE?=
 =?utf-8?B?QnB1SnhHR0RNMnpkaS96bkxTTnl2VXVCNWV4YzJGaFVTVzJJK3NtZ1YvSW1p?=
 =?utf-8?B?ZFFXOVpQNU41bDhTcEY5a1Rlak1nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A767612F1CF16468445849DE463E7D3@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b14ce6e7-659a-467a-7448-08dd5292ac83
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 16:13:26.9262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJT08diOwcshpu2rbDkFeJg7FKcgYsvldVm8gCkdTDb4Ge0S5ujfcsM7g5iFDza5jSzM4Rud+iHIcwXldB8J5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5117

T24gRnJpLCAyMDI1LTAyLTIxIGF0IDEwOjQ2IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gMi8yMS8yNSAxMDozNiBBTSwgTWlrZSBTbml0emVyIHdyb3RlOg0KPiA+IE9uIEZyaSwgRmVi
IDIxLCAyMDI1IGF0IDEwOjI1OjAzQU0gLTA1MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPiA+ID4g
T24gRnJpLCAyMDI1LTAyLTIxIGF0IDEwOjAyIC0wNTAwLCBNaWtlIFNuaXR6ZXIgd3JvdGU6DQo+
ID4gPiA+IE15IGludGVudCB3YXMgdG8gbWFrZSA2LjE0J3MgRE9OVENBQ0hFIGZlYXR1cmUgYWJs
ZSB0byBiZQ0KPiA+ID4gPiB0ZXN0ZWQgaW4NCj4gPiA+ID4gdGhlIGNvbnRleHQgb2YgbmZzZCBp
biBhIG5vLWZyaWxscyB3YXkuwqAgSSByZWFsaXplIGFkZGluZyB0aGUNCj4gPiA+ID4gbmZzZF9k
b250Y2FjaGUga25vYiBza2V3cyB0b3dhcmQgdG9vIHJhdywgbGFja3MgcG9saXNoLsKgIEJ1dA0K
PiA+ID4gPiBJJ20NCj4gPiA+ID4gaW5jbGluZWQgdG8gZXhwb3NlIHN1Y2ggY291cnNlLWdyYWlu
ZWQgb3B0LWluIGtub2JzIHRvDQo+ID4gPiA+IGVuY291cmFnZQ0KPiA+ID4gPiBvdGhlcnMnIGRp
c2NvdmVyeSAoYW5kIGFuc3dlcnMgdG8gc29tZSBvZiB0aGUgcXVlc3Rpb25zIHlvdQ0KPiA+ID4g
PiBwb3NlDQo+ID4gPiA+IGJlbG93KS7CoCBJIGFsc28gaG9wZSB0byBlbmxpc3QgYWxsIE5GU0Qg
cmV2aWV3ZXJzJyBoZWxwIGluDQo+ID4gPiA+IGNhdGVnb3JpemluZy9kb2N1bWVudGluZyB3aGVy
ZSBET05UQ0FDSEUgaGVscHMvaHVydHMuIDspDQo+ID4gPiA+IA0KPiA+ID4gPiBBbmQgSSBhZ3Jl
ZSB0aGF0IHVsdGltYXRlbHkgcGVyLWV4cG9ydCBjb250cm9sIGlzIG5lZWRlZC7CoCBJJ2xsDQo+
ID4gPiA+IHRha2UNCj4gPiA+ID4gdGhlIHRpbWUgdG8gaW1wbGVtZW50IHRoYXQsIGhvcGVmdWwg
dG8gaGF2ZSBzb21ldGhpbmcgbW9yZQ0KPiA+ID4gPiBzdWl0YWJsZSBpbg0KPiA+ID4gPiB0aW1l
IGZvciBMU0YuDQo+ID4gPiANCj4gPiA+IFdvdWxkIGl0IG1ha2UgbW9yZSBzZW5zZSB0byBob29r
IERPTlRDQUNIRSB1cCB0byB0aGUgSU9fQURWSVNFDQo+ID4gPiBvcGVyYXRpb24gaW4gUkZDNzg2
Mj8gSU9fQURWSVNFNF9OT1JFVVNFIHNvdW5kcyBsaWtlIGl0IGhhcw0KPiA+ID4gc2ltaWxhcg0K
PiA+ID4gbWVhbmluZz8gVGhhdCB3b3VsZCBnaXZlIHRoZSBjbGllbnRzIGEgd2F5IHRvIGRvIHRo
aXMgb24gYSBwZXItDQo+ID4gPiBvcGVuDQo+ID4gPiBiYXNpcy4NCj4gPiANCj4gPiBKdXN0IHRo
aW5raW5nIGFsb3VkIGhlcmUgYnV0OiBVc2luZyBhIERPTlRDQUNIRSBzY2FscGVsIG9uIGEgcGVy
DQo+ID4gb3Blbg0KPiA+IGJhc2lzIHF1aXRlIGxpa2VseSB3b3VsZG4ndCBwcm92aWRlIHRoZSBy
ZXF1aXJlZCBwYWdlIHJlY2xhaW0NCj4gPiByZWxpZWYNCj4gPiBpZiB0aGUgc2VydmVyIGlzIGJl
aW5nIGhhbW1lcmVkIHdpdGggbm9ybWFsIGJ1ZmZlcmVkIElPLsKgIFN1cmUgdGhhdA0KPiA+IHBh
cnRpY3VsYXIgRE9OVENBQ0hFIElPIHdvdWxkbid0IGNvbnRyaWJ1dGUgdG8gdGhlIHByb2JsZW0g
YnV0IGl0DQo+ID4gd291bGQgc3RpbGwgYmUgaW1wYWN0ZWQgYnkgdGhvc2Ugbm90IG9wdGluZyB0
byB1c2UgRE9OVENBQ0hFIG9uDQo+ID4gZW50cnkNCj4gPiB0byB0aGUgc2VydmVyIGR1ZSB0byBu
ZWVkaW5nIHBhZ2VzIGZvciBpdHMgRE9OVENBQ0hFIGJ1ZmZlcmVkIElPLg0KPiANCj4gRm9yIHRo
aXMgaW5pdGlhbCB3b3JrLCB3aGljaCBpcyB0byBwcm92aWRlIGEgbWVjaGFuaXNtIGZvcg0KPiBl
eHBlcmltZW50YXRpb24sIElNTyBleHBvc2luZyB0aGUgc2V0dGluZyB0byBjbGllbnRzIHdvbid0
IGJlIGFsbA0KPiB0aGF0IGhlbHBmdWwuDQo+IA0KPiBCdXQgdGhlcmUgYXJlIHNvbWUgYXBwbGlj
YXRpb25zL3dvcmtsb2FkcyBvbiBjbGllbnRzIHdoZXJlIGV4cG9zdXJlDQo+IGNvdWxkIGJlIGJl
bmVmaWNpYWwgLS0gZm9yIGluc3RhbmNlLCBhIGJhY2t1cCBqb2IsIHdoZXJlIE5GU0Qgd291bGQN
Cj4gYmVuZWZpdCBieSBrbm93aW5nIGl0IGRvZXNuJ3QgaGF2ZSB0byBtYWludGFpbiB0aGUgam9i
J3Mgd3JpdHRlbiBkYXRhDQo+IGluDQo+IGl0cyBwYWdlIGNhY2hlLiBJIHJlZ2FyZCB0aGF0IGFz
IGEgbGF0ZXIgZXZvbHV0aW9uYXJ5IGltcHJvdmVtZW50LA0KPiB0aG91Z2guDQo+IA0KPiBKb3Jn
ZSBwcm9wb3NlZCBhZGRpbmcgdGhlIE5GU3Y0LjIgSU9fQURWSVNFIG9wZXJhdGlvbiB0byBORlNE
LCBidXQgSQ0KPiB0aGluayB3ZSBmaXJzdCBuZWVkIHRvIGEpIHdvcmsgb3V0IGFuZCBkb2N1bWVu
dCBhcHByb3ByaWF0ZSBzZW1hbnRpY3MNCj4gZm9yIGVhY2ggaGludCwgYmVjYXVzZSB0aGUgc3Bl
YyBkb2VzIG5vdCBwcm92aWRlIHNwZWNpZmljcywgYW5kIGIpDQo+IHBlcmZvcm0gc29tZSBleHRl
bnNpdmUgYmVuY2htYXJraW5nIHRvIHVuZGVyc3RhbmQgdGhlaXIgdmFsdWUgYW5kDQo+IGltcGFj
dC4NCj4gDQo+IA0KDQpUaGF0IHB1dHMgdGhlIG9udXMgb24gdGhlIGFwcGxpY2F0aW9uIHJ1bm5p
bmcgb24gdGhlIGNsaWVudCB0byBkZWNpZGUNCnRoZSBjYWNoaW5nIHNlbWFudGljcyBvZiB0aGUg
c2VydmVyIHdoaWNoOg0KICAgQS4gSXMgYSB0ZXJyaWJsZSBpZGVh4oSiLiBUaGUgYXBwbGljYXRp
b24gbWF5IGtub3cgaG93IGl0IHdhbnRzIHRvIHVzZQ0KICAgICAgdGhlIGNhY2hlZCBkYXRhLCBh
bmQgYmUgYWJsZSB0byBzb21ld2hhdCBjb25maWRlbnRseSBtYW5hZ2UgaXRzDQogICAgICBvd24g
cGFnZWNhY2hlLiBIb3dldmVyIGluIGFsbW9zdCBhbGwgY2FzZXMsIGl0IHdpbGwgaGF2ZSBubyBi
YXNpcw0KICAgICAgZm9yIHVuZGVyc3RhbmRpbmcgaG93IHRoZSBzZXJ2ZXIgc2hvdWxkIG1hbmFn
ZSBpdHMgY2FjaGUuIFRoZQ0KICAgICAgbGF0dGVyIHJlYWxseSBpcyBhIGpvYiBmb3IgdGhlIHN5
c2FkbWluIHRvIGZpZ3VyZSBvdXQuDQogICBCLiBJcyBpbXByYWN0aWNhbCwgYmVjYXVzZSBldmVu
IGlmIHlvdSBjYW4gZmlndXJlIG91dCBhIHBvbGljeSwgaXQNCiAgICAgIHJlcXVpcmVzIHJld3Jp
dGluZyB0aGUgYXBwbGljYXRpb24gdG8gbWFuYWdlIHRoZSBzZXJ2ZXIgY2FjaGUuDQogICBDLiBX
aWxsIHJlcXVpcmUgYWRkaXRpb25hbCBBUElzIG9uIHRoZSBORlN2NC4yIGNsaWVudCB0byBleHBv
c2UgdGhlDQogICAgICBJT19BRFZJU0Ugb3BlcmF0aW9uLiBZb3UgY2Fubm90IGp1c3QgbWFwIGl0
IHRvIHBvc2l4X2ZhZHZpc2UoKQ0KICAgICAgYW5kL29yIHBvc2l4X21hZHZpc2UoKSwgYmVjYXVz
ZSBJT19BRFZJU0UgaXMgZGVzaWduZWQgdG8gbWFuYWdlIGENCiAgICAgIGNvbXBsZXRlbHkgZGlm
ZmVyZW50IGNhY2hpbmcgbGF5ZXIuIEF0IGJlc3QsIHdlIG1pZ2h0IGJlIGFibGUgdG8NCiAgICAg
IHJhbGx5IG9uZSBvciB0d28gbW9yZSBkaXN0cmlidXRlZCBmaWxlc3lzdGVtcyB0byBpbXBsZW1l
bnQNCiAgICAgIHNpbWlsYXIgZnVuY3Rpb25hbGl0eSBhbmQgc2hhcmUgYW4gQVBJLCBob3dldmVy
IHRoZXJlIGlzIG5vDQogICAgICBjaGFuY2UgdGhpcyBBUEkgd2lsbCBiZSB1c2VmdWwgZm9yIG9y
ZGluYXJ5IGZpbGVzeXN0ZW1zLg0KDQotLSANClRyb25kIE15a2xlYnVzdCBMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tDQo=

