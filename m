Return-Path: <linux-nfs+bounces-6355-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4021B972170
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 19:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16242849D9
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 17:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFB6178CF6;
	Mon,  9 Sep 2024 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="M8m6M1zx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2114.outbound.protection.outlook.com [40.107.220.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFD02263A;
	Mon,  9 Sep 2024 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904579; cv=fail; b=uJyFDWY9PJXTf48tg85Di7luFwQcD0DLQrrITVr3tE5qJ2P8IWdrBOdpYvpMaNylKVvC+FqWjbO6mtr7nVsBDxpcGerc3IsadcxKxUOzYf4PglJgmCh8/8UQUksDfiUTzV5FLU0KObLCAQ8aO2ZJsuh4Dn6H4Req3CivcJYAX+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904579; c=relaxed/simple;
	bh=NxNU6reFuvl9mWcWr3hKXhLEcmzA6aFDetP5yYM2I0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IAENZ+4WIoPEi/TY8LyqL7blnFnt45Ul+HGdhGUVKEA9apmSjzFrurWHUK5IMjubiHtR3X7QquAtqawL6WRJcWZQE1X0ugDcKout98nFw+p7GF+aWlvATUhEOfK9lbIwOJ5cvgcXXzS1Pd4fIS4eoAKEUB1w3wtnwkC+qneNuss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=M8m6M1zx; arc=fail smtp.client-ip=40.107.220.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtmVyr4LhhTghhVPlymSYnMhsrOCsYhGTNRdwSzj6KrDshX7aQKmlOsm81/uXzjRyZEqErdUoi9qJe2aJzJVpXkIcr/5k2UCWlmkm0qWEIAyVJUA8cla10qWpEU90ySwSOB+bVF4SyA6cMtUidhTprV7UaGERKUlMKQV5q/EWuDfarc8Zp2UxVlQNAoTRymQCWK8bGgj8ib0yvaweW3IpsOFBPC1W6iSDjWur62P80HfeyUxvFbHEUuM3Xpfj9rW+5Anju3qRNEtRlRHBbp1qmwPQlSgCqKN967n8uB2C6WjDsOFn1WUJrnnjviEvsk7f0VdRrAZm2r7AhpvWNLqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxNU6reFuvl9mWcWr3hKXhLEcmzA6aFDetP5yYM2I0k=;
 b=qn9rJmygQCWT0sACPgaE4Ihthp7fpn6FOJ935SNlF8mzfJSQ+1GJPMWtBa0xBuKtLCn6gI6yfrk3PZ43UN25zeirH7f6tNl47Gx3ssvlt6nyK4Oqj0FqFPrwFIn14IesDshzHc66qlJNU6eAXpi8/2RI0hS6uDpfZSb4pbaO/USWABwbqjgC7t8q9hyZe4tpAPHa8LDv1r3tYsp5wDUaNb2QqauUIMosxHcMiSZCxXZ7o5uYU0/QBcusJ5gqF+/PA7wEL1t5vciK9ds0D0ZAqAEEjEViBMAYJPAj7KEn3D8RqPTLbWU511dZE5kT7ahpO+Y7AhkyI3vaTHixcpf8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxNU6reFuvl9mWcWr3hKXhLEcmzA6aFDetP5yYM2I0k=;
 b=M8m6M1zxWe7dt5U6sYmiM/+wuPUH7A5I6szVT3oa9WUVZelgRd/NJ9cy4BoffBUfv/iCMQMN5vvtmXxR/Sn3mYs2cyKtKZJ0F+zx0OkPhjux9xmYS3a58Gm5N4eAjnNuRXiA0bvdFL8/VdVTllicbQxm0MTHg1eTprqnUmx6KE4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5870.namprd13.prod.outlook.com (2603:10b6:a03:438::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 9 Sep
 2024 17:56:13 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 17:56:12 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "ovt@google.com" <ovt@google.com>
CC: "anna@kernel.org" <anna@kernel.org>, "jbongio@google.com"
	<jbongio@google.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH 6.1.y] net: tls: handle backlogging of crypto requests
Thread-Topic: [PATCH 6.1.y] net: tls: handle backlogging of crypto requests
Thread-Index: AQHbAtZs9c8IybR6c06BOKhp981Q7bJPvW+A
Date: Mon, 9 Sep 2024 17:56:12 +0000
Message-ID: <84f2415b4d5bb42dc7e26518983f53a997647130.camel@hammerspace.com>
References: <8f2e20f2fc894398da371517c6c8111aba072fb1.camel@kernel.org>
	 <20240909163610.2148932-1-ovt@google.com>
In-Reply-To: <20240909163610.2148932-1-ovt@google.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5870:EE_
x-ms-office365-filtering-correlation-id: 021bc92d-ae79-40f7-dc6e-08dcd0f8b167
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1FiY3lrek9EeVJCUmRBNnRyWE5RTzZpSCtSOTR3WDZ3R21KQmdtOGxNOXJH?=
 =?utf-8?B?STVGWGxpN3hIc004T2kwZW96TURReGd3SHhSMFpMMWdFMkNNNnovZEhTQjZU?=
 =?utf-8?B?b3ZERCtvVUdrOUtuUUZvcHFaelBreDdDaDFPUk4xZDFtd2l5WTNQRGF6ZDFY?=
 =?utf-8?B?VjMvalZLaVZIRTZyelpLaHdZVldZQ05kQ0I3Z1JZanRVcldUWDF1OXVCNXBR?=
 =?utf-8?B?WEVjYmFCRTd2VmErekxUWXREV1pjYzQyKzNtSmlEK3BqT2FIRVFGcGVKcDN5?=
 =?utf-8?B?MXJnVW04L2tKODhITlArVGhXeUpralhCK0NTOTVjWW0yYXZIeGNGNFBkMjdT?=
 =?utf-8?B?bWlObVlERERmclA1YVNTK21MRlhYMUxXY1E0dmY0Q2s5TmZLbkRxbEJDemgv?=
 =?utf-8?B?NVh1ZlNUQnBHbFZwWTRyMUhyMVF3TEtSV3k5WVFVaHI5RlBKbmNNTys2c2tp?=
 =?utf-8?B?cTAwMHlRWVgwcTFoaEVtOUlVSFBVWFNKeGs3V3M2MHpkS0dSeWRkZjhOdGw4?=
 =?utf-8?B?ZXpiSUw0WldlMFdESVdKbThITklkSnhSZnduY3JSSmZYV2duNUNUQndIZ2Zz?=
 =?utf-8?B?cExvTERMUlFFaG1KSVZoSWVMdzh0azVvdUxkSzluaXNrdVczYndjZVlpTXp1?=
 =?utf-8?B?Q2t2UDhtdXRFRy8wRmxWaGNNUWJMS2p0RCt6WGg2cE1GZ1hBS0dRUkt3bHBi?=
 =?utf-8?B?Rnd1bkd4S0R0MDlsWW0vM1BkaGZOYk1PMUVuRDJJRDRaZjdoZmZGSUJnTXNo?=
 =?utf-8?B?V01WWVlPKzlwMnBGOUQ3cFhHMDFTeEtCQUN0OVByS1JhR1FhZDhJOERkSGRL?=
 =?utf-8?B?b01tN1JEZVAxVFYybElDWjZDM3orQkJFMTg0OWZPYitjNVY1c29jbE9mVWVS?=
 =?utf-8?B?UnU5eDN6d0d5c2dEaUFVWnVWUVMybFcyaTg1Nzl6Q05rYzVvTDVPYlFoZU5N?=
 =?utf-8?B?VTdocmlpRWZQekdITmE1c1lCRTFicE9yR1ViS08wbG5tdThmYmhGQUgzT3Av?=
 =?utf-8?B?VzRPVUJIY0ZxcXFMM3FQaDJSQmZLTmdLVUhmeUhmSWRLQ1dVYlA4VkhWQjIz?=
 =?utf-8?B?Y0JBZnpxZU9Sc1NFRFJBUVh3NzZSNUQ1dHFWa1VVNjNrUHhsTEdIR0I2KzZv?=
 =?utf-8?B?Q0MxQmtvbkdFUkJFUmtjanpVcFJNZlVmeDlGWUhQNVBIakNqRCtkVmFsWmY3?=
 =?utf-8?B?SzhkUTFTekl1Q2xOOTQ0Y3VvMFRmQ0p5cW9JZlllc280V214UTNITzBoRHFZ?=
 =?utf-8?B?clZKclpwSTV3cW1uVytnWW9aNzdIRnlkSDJxd3hsbTNJZDlybGpVb0xKaGt4?=
 =?utf-8?B?blVNY2paQTZzMXVkSG5tT2pTWGRiOUJENnlJb2lTc2M1YjBzZ0s2OVFMd25Z?=
 =?utf-8?B?MVN6aENqTk9BRmpJNnhJTUljeXhnM3ppMmcwU2VWS2NrVkx4bDhvNnJWRVR4?=
 =?utf-8?B?dkpTTGFHbisxUE1ZRnprc243M0lXWSswNTRZb25qdi9SWUkrWklIQnpWY0No?=
 =?utf-8?B?cEtRbDdDVFA2OVdkdzJjS01ROGFGb1U5amFKZmY3MVhCTGg3RWY4eGFWaGNw?=
 =?utf-8?B?cWhwemdVOTVyV2U2cklMVC8zMk5FZ2hkWElKTDZCcWg5Z0l3MzhkcEEzQ0V1?=
 =?utf-8?B?U2FHREhHcG0reFNPS3dXVFF1SkFGRFhkNFc2b1BaUVZ1dkoyVW9MQkxRSWFo?=
 =?utf-8?B?UlR1bVdVcUpROWpLdTF5T3dSNjVhRXdYRDNZOFIxa3YyL2k2SVNLajFrWkYz?=
 =?utf-8?B?RHlTeitDU1M5VGdUczJWRXlCczUzYVFiZm4rWURNMFBWT2lvS1VrR1k1bE9O?=
 =?utf-8?B?V0NVK1VEanQ2bWFEV3VZdGlUb2ZkbGVNUGpNb3JRM0ovY2lRWjkyNmZXTW16?=
 =?utf-8?B?VUp6QkRZbVRzWlZleWdtWVZLTzh5T0hwSzd3TEF2Q3NvUXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEpJbnd6QW5aRGtHYmJoMzBYMmY0eVdSK243TUtRckk3b1haOGtOdVVOUnRv?=
 =?utf-8?B?TCs5V1YwbVNUeUVwOGd1L0tvOCsvN3JoNFJMMzFHTEpGRDBWb2VsZUdNTTJB?=
 =?utf-8?B?Y09USm5JT3hlQ3llWGNWZWMyTThTTmUyZGpmNUFGTFVKd3pUcVA5NWpYTnBt?=
 =?utf-8?B?UmtIelFBS2hlRW15RVpBSVFSYmEzdHpmQVFvTUlHUjZRamFTM3NFMm81U3Jo?=
 =?utf-8?B?SHZWc1dVOVk0VTJkT3F3bTNhL3dCdG11NzI1ZkJzN2V2a0FYbEl5aW9DNEQr?=
 =?utf-8?B?MC9XcmxBeW1IbzM3KzZMOEtRY1RrejBldklWelZSaW9DdTREV1JCcldXN2Zx?=
 =?utf-8?B?QnZsV3haenU4UERKWDFIcmt5Y0o5RVMwSjVhM0ZiZFdCMDJsdURlSi81VFJD?=
 =?utf-8?B?OGVpZjV2NFFXZWk5S05OTUJkSE13MFFMY3RINEhCSnY5UkRvUExCWEdsZTZT?=
 =?utf-8?B?R2FQY2RXQVVsaFl4allJM3pxNnUrbVk1ZWRSRUw3MjhoTzhMcURKYVVRYXVR?=
 =?utf-8?B?TC8yOTJSeUdxMnQ5aUY3a3NvLzI3WUNvdENiNFdIa0xVUTRvM2w0WnlXWFJG?=
 =?utf-8?B?cnMyZ1AwT3pwVG1pTStzRFdTQ1VGdURmc2t1N2IvMkhiRjlkY001bzBNd09i?=
 =?utf-8?B?bCtjODFCQWFZWVBmM0NObHVYL2xGYm1Wc3N4QVVvcExndkl3ZnhKMkpHeVJn?=
 =?utf-8?B?Q0NzeTlFVElxZVZ3UTcwek05OGRBbWFTdDVuanFjVEVQY2p4VHlhOFNRSi9h?=
 =?utf-8?B?bW43ZDgyQzlVNTM3Zm1UM0tPbVBCYnhQZmlzTVFRZHBicHBscW0wblBRYmky?=
 =?utf-8?B?c2lSZkwvU3A4WGdkQkNySmgzaDB5emxHaG5FWnBsbEF3TkRja2ZwYnhCU1pX?=
 =?utf-8?B?OHV2RGVEY3hTZ1ZNZ3YyNml5aVZFVXVscHRoWFlVeUJJUWJuSHdkRXhmNmlt?=
 =?utf-8?B?Q0hqeEo2RzNSZ0pQWlFibzB5NG1OQ2QwK0dTZ3dFOG9FQ3VEaWVFcnZyeFNr?=
 =?utf-8?B?N3VsMU5oQWR4QUVST0F2bEVPSU5wOVF3ZnBrTGt2c1FhRE1DRFhTNlRzT3U5?=
 =?utf-8?B?Y0ErWU5KMXZTZFFld2t6cndud0dCSitXLzB4b1BwUzFBQ0hjYWVENjhJaHpH?=
 =?utf-8?B?Y3RESlp0SVpQc2h2T1MvZld3UDQwQmpvL3kwTE5BQ1psOHdjcHg3cGtua0hU?=
 =?utf-8?B?MXp0K2wwSktZbUY4VHorWTF2RFg1cFJTakFlT1hRcWI1NGNSVnBpMVZ2b2ZN?=
 =?utf-8?B?ZEZYakxzZi8waUFwbnhmaDBYQXk1RjRVc0t3ZHE5OFMvOHkzRWNWeXZHUk1w?=
 =?utf-8?B?ajRzTHFkUnFnOUEwUGxyRUpnT2JDZ1VvbHo0RWhEdEZpZVNacXVlSFlNSjNL?=
 =?utf-8?B?b2xqMmtZNktUaDgycXZOUEdZa2FoREVFaFBoUG9WejFxTUpZeXNFeHVnMzh5?=
 =?utf-8?B?aHNkY2M4QldYcmdvSUFNRVZwa1ZIOFhjc2V0RTBmNHBtM1I5ZVNyaHp5Zm1Y?=
 =?utf-8?B?NlVkejcrZk1wN284TnNBOEVmQ3I1SjExM2w4WG9PZnZKUmpWUnhmV2hvaGdC?=
 =?utf-8?B?cUZ3N0R1UnN0V0dnemI1U0VOQTJyem1pZzc2WEpuRFJUVS9GUnROM1FPY3No?=
 =?utf-8?B?Vk1BZE9QV2plNVlPWGxEdkVqckdqNDBRWkY2Z1VSUlJOZVNKWm16N3hWbCtS?=
 =?utf-8?B?dTNJaFc3d2dGVzFhWTZINHJJMjVWTmthQjJtVmkvdXl0eSt3aHprU0pzY2hr?=
 =?utf-8?B?c1pCWEUyUTY4TDdUQjNEMjhPZzhkRVdSMDRSQ0JyVlBuSTJLWXRMNFMxd1pH?=
 =?utf-8?B?VW5wOUd0SWlvckVHWVJVZ2NiNU04R3Y2MWswU0tkd3c2NEh6U2JWNHRnRHlW?=
 =?utf-8?B?enByS1dLOFJlZFlXQkFETXdOSmNBRmt1amRNMkl0RHE2dGV6cXRWcGJwUVFh?=
 =?utf-8?B?R3dkVWNHT0pSY3E5cFljV2RQdXZzTFRqbXhOd1YyLzEvcGdNSjcvSHRFL2Q5?=
 =?utf-8?B?Mm5wZlBGTmlFV0ptbEw4RXJob1ZhTVgvYXlqR28waGMzdU4xR202WG5kYkcy?=
 =?utf-8?B?VXpLZW1zOE9pL0Z2bDA3U0twWlpHS2d0OTYzR0gvV0hNTndlRXFIU3B0R1Mr?=
 =?utf-8?B?VGlJbFR0ZUExckFTTEFGeHRoM1kyME1HUks0Qno1THMvU0tXODBRZXJiaGhB?=
 =?utf-8?B?dFFBUFMyMVExRkp2VFNsYUVxZ0JRTVUydVZKUi9GT093dE4rLzNMOWd4VkVn?=
 =?utf-8?B?bFNJcERIN1BiWFpzdUZncTZlSklBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <618BC97B1070E7498642160E64A5E867@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 021bc92d-ae79-40f7-dc6e-08dcd0f8b167
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 17:56:12.6263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Olg8RuAt22I+r6k/jB5SBakUujsg69qp01HyZUxfV+L742UZRKv1DFHcfN43uDObsNF/2inJF645zFy3iQzOQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5870

T24gTW9uLCAyMDI0LTA5LTA5IGF0IDE2OjM2ICswMDAwLCBPbGVrc2FuZHIgVHltb3NoZW5rbyB3
cm90ZToNCj4gPiA+IG5mczQxX2luaXRfY2xpZW50aWQgZG9lcyBub3Qgc2lnbmFsIGEgZmFpbHVy
ZSBjb25kaXRpb24gZnJvbQ0KPiA+ID4gbmZzNF9wcm9jX2V4Y2hhbmdlX2lkIGFuZCBuZnM0X3By
b2NfY3JlYXRlX3Nlc3Npb24gdG8gYSBjbGllbnQNCj4gPiA+IHdoaWNoDQo+ID4gPiBtYXkNCj4g
PiA+IGxlYWQgdG8gbW91bnQgc3lzY2FsbCBpbmRlZmluaXRlbHkgYmxvY2tlZCBpbiB0aGUgZm9s
bG93aW5nIHN0YWNrDQo+IA0KPiA+IE5BQ0suIFRoaXMgd2lsbCBicmVhayBhbGwgc29ydHMgb2Yg
cmVjb3Zlcnkgc2NlbmFyaW9zLCBiZWNhdXNlIGl0DQo+ID4gZG9lc24ndCBkaXN0aW5ndWlzaCBi
ZXR3ZWVuIGFuIGluaXRpYWwgJ21vdW50JyBhbmQgYSBzZXJ2ZXIgcmVib290DQo+ID4gcmVjb3Zl
cnkgc2l0dWF0aW9uLg0KPiA+IEV2ZW4gaW4gdGhlIGNhc2Ugd2hlcmUgd2UgYXJlIGluIHRoZSBp
bml0aWFsIG1vdW50LCBpdCBhbHNvIGRvZXNuJ3QNCj4gPiBkaXN0aW5ndWlzaCBiZXR3ZWVuIHRy
YW5zaWVudCBlcnJvcnMgc3VjaCBhcyBORlM0RVJSX0RFTEFZIG9yDQo+ID4gcmVib290DQo+ID4g
ZXJyb3JzIHN1Y2ggYXMgTkZTNEVSUl9TVEFMRV9DTElFTlRJRCwgZXRjLg0KPiANCj4gPiBFeGFj
dGx5IHdoYXQgaXMgdGhlIHNjZW5hcmlvIHRoYXQgaXMgY2F1c2luZyB5b3VyIGhhbmc/IExldCdz
IHRyeQ0KPiA+IHRvDQo+ID4gYWRkcmVzcyB0aGF0IHdpdGggYSBtb3JlIHRhcmdldGVkIGZpeC4N
Cj4gDQo+IFRoZSBzY2VuYXJpbyBpcyBhcyBmb2xsb3dzOiB0aGVyZSBhcmUgc2V2ZXJhbCBORlMg
c2VydmVycyBhbmQgc2V2ZXJhbA0KPiBwcm9kdWN0aW9uIG1hY2hpbmVzIHdpdGggbXVsdGlwbGUg
TkZTIG1vdW50cy4gVGhpcyBpcyBhIGNvbnRhaW5lcml6ZWQNCj4gbXVsdGktdGVubmFudCB3b3Jr
ZmxvdyBzbyBldmVyeSB0ZW5uYW50IGdldHMgaXRzIG93biBORlMgbW91bnQgdG8NCj4gYWNjZXNz
IHRoZWlyDQo+IGRhdGEuIEF0IHNvbWUgcG9pbnQgbmZzNDFfaW5pdF9jbGllbnRpZCBmYWlscyBp
biB0aGUgaW5pdGlhbA0KPiBtb3VudC5uZnMgY2FsbA0KPiBhbmQgYWxsIHN1YnNlcXVlbnQgbW91
bnQubmZzIGNhbGxzIGp1c3QgaGFuZyBpbg0KPiBuZnNfd2FpdF9jbGllbnRfaW5pdF9jb21wbGV0
ZQ0KPiB1bnRpbCB0aGUgb3JpZ2luYWwgb25lLCB3aGVyZSBuZnM0X3Byb2NfZXhjaGFuZ2VfaWQg
aGFzIGZhaWxlZCwgaXMNCj4ga2lsbGVkLg0KPiANCj4gVGhlIGNhdXNlIG9mIHRoZSBuZnM0MV9p
bml0X2NsaWVudGlkIGZhaWx1cmUgaW4gdGhlIHByb2R1Y3Rpb24gY2FzZQ0KPiBpcyBhIHRpbWVv
dXQuDQo+IFRoZSBmb2xsb3dpbmcgZXJyb3IgbWVzc2FnZSBpcyBvYnNlcnZlZCBpbiBsb2dzOg0K
PiDCoCBORlM6IHN0YXRlIG1hbmFnZXI6IGxlYXNlIGV4cGlyZWQgZmFpbGVkIG9uIE5GU3Y0IHNl
cnZlciA8aXA+IHdpdGgNCj4gZXJyb3IgMTEwDQo+IA0KDQpIb3cgYWJvdXQgc29tZXRoaW5nIGxp
a2UgdGhlIGZvbGxvd2luZyBmaXggdGhlbj8NCjg8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCkZyb20gZWI0MDJiNDg5YmIwZDBhZGExYTNkZDkxMDFkNGQ3
ZTE5MzQwMmU0NiBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCk1lc3NhZ2UtSUQ6IDxlYjQwMmI0
ODliYjBkMGFkYTFhM2RkOTEwMWQ0ZDdlMTkzNDAyZTQ2LjE3MjU5MDQ0NzEuZ2l0LnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQpGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQpEYXRlOiBNb24sIDkgU2VwIDIwMjQgMTM6NDc6MDcg
LTA0MDANClN1YmplY3Q6IFtQQVRDSF0gTkZTdjQ6IEZhaWwgbW91bnRzIGlmIHRoZSBsZWFzZSBz
ZXR1cCB0aW1lcyBvdXQNCg0KSWYgdGhlIHNlcnZlciBpcyBkb3duIHdoZW4gdGhlIGNsaWVudCBp
cyB0cnlpbmcgdG8gbW91bnQsIHNvIHRoYXQgdGhlDQpjYWxscyB0byBleGNoYW5nZV9pZCBvciBj
cmVhdGVfc2Vzc2lvbiBmYWlsLCB0aGVuIHdlIHNob3VsZCBhbGxvdyB0aGUNCm1vdW50IHN5c3Rl
bSBjYWxsIHRvIGZhaWwgcmF0aGVyIHRoYW4gaGFuZyBhbmQgYmxvY2sgb3RoZXIgbW91bnQvdW1v
dW50DQpjYWxscy4NCg0KUmVwb3J0ZWQtYnk6IE9sZWtzYW5kciBUeW1vc2hlbmtvIDxvdnRAZ29v
Z2xlLmNvbT4NClNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbT4NCi0tLQ0KIGZzL25mcy9uZnM0c3RhdGUuYyB8IDYgKysrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvbmZzL25m
czRzdGF0ZS5jIGIvZnMvbmZzL25mczRzdGF0ZS5jDQppbmRleCAzMGFiYTFkZWRhYmEuLjU5ZGNk
ZjliYzdiNCAxMDA2NDQNCi0tLSBhL2ZzL25mcy9uZnM0c3RhdGUuYw0KKysrIGIvZnMvbmZzL25m
czRzdGF0ZS5jDQpAQCAtMjAyNCw2ICsyMDI0LDEyIEBAIHN0YXRpYyBpbnQgbmZzNF9oYW5kbGVf
cmVjbGFpbV9sZWFzZV9lcnJvcihzdHJ1Y3QgbmZzX2NsaWVudCAqY2xwLCBpbnQgc3RhdHVzKQ0K
IAkJbmZzX21hcmtfY2xpZW50X3JlYWR5KGNscCwgLUVQRVJNKTsNCiAJCWNsZWFyX2JpdChORlM0
Q0xOVF9MRUFTRV9DT05GSVJNLCAmY2xwLT5jbF9zdGF0ZSk7DQogCQlyZXR1cm4gLUVQRVJNOw0K
KwljYXNlIC1FVElNRURPVVQ6DQorCQlpZiAoY2xwLT5jbF9jb25zX3N0YXRlID09IE5GU19DU19T
RVNTSU9OX0lOSVRJTkcpIHsNCisJCQluZnNfbWFya19jbGllbnRfcmVhZHkoY2xwLCAtRUlPKTsN
CisJCQlyZXR1cm4gLUVJTzsNCisJCX0NCisJCWZhbGx0aHJvdWdoOw0KIAljYXNlIC1FQUNDRVM6
DQogCWNhc2UgLU5GUzRFUlJfREVMQVk6DQogCWNhc2UgLUVBR0FJTjoNCi0tIA0KMi40Ni4wDQoN
Cg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

