Return-Path: <linux-nfs+bounces-5203-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BFD94334F
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jul 2024 17:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D7E1C242E0
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jul 2024 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CE717BA3;
	Wed, 31 Jul 2024 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="H8h01x0a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2097.outbound.protection.outlook.com [40.107.236.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA567171AA
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jul 2024 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439651; cv=fail; b=gQsHUH5NPMz3ulzt5wCK9w8bnmRo8H7pNN3ohqS3asZWYwBi1S4gcNf0DKHkHnc9uxCz0OTMfwDsigOLnptuCiqsvKlZ4DA9ektJLIyfJ6Ar/4aVPYMn27W6YLZPQEwF09GgpIYiQArN1355F1p5iFq9M9NeFCREV5PLfsnzlWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439651; c=relaxed/simple;
	bh=kr/Xhd1d7dESsC1VuxFhwMw11NLpkePSUlFRExjXuG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/34tQqNEAWqvYV208mEEcKmwBuVjvQLH9Bn1eNdBG5jXZaOnEkHzWuFDz5kaJaNAqUZ9Cxm/tfy0Knonk8svXS5jjLY0A4djKMc9LKoWWobBFGHFhzQUXL1ILQ3GPfculBre+92mvf6qxV18e0XcLIdXAp6tVlA8l0VD29bcJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=H8h01x0a; arc=fail smtp.client-ip=40.107.236.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpKAj8peZoK2PhcWxtOTRS8pmFzGfdV+b2StzDz9PJ7gPigiMp9ibJUPppq0clp9V5sL0TnvJ8OrVwHr1g50pbi0C2eCBzsDP/mWgD5nSTdbzlWdjTdI1Pglw4jrjlfZe0r+z6+wRK2O8E/0On0QIRx8hQ65ByykCH242NM5lbkzST0QBktw5GbB7GYfJk/j38fgnuda/xP3x+fBZWNkflsP3BVqSrEI5uxjL8oGxAML7xDcyoWAxGEnWYt4boJ5Jp1SCNVsdOWR6zm6F1LTFBbvjJ5jN+WjT2pP9RLhOE3IpsBRAHdhR5i4EseRS1X5SM52KpWmNLaKlEDrsL4BJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kr/Xhd1d7dESsC1VuxFhwMw11NLpkePSUlFRExjXuG4=;
 b=ZpvV2t7yARQKbxpff67jgOMcy4s8xFGYX5C9eEQ7unWdNz8SbVpiVzfcTH4uatQz3RX4QDY7oOMSzBTi857iVWqmThDN4mE0h5eWObDHP0WeS3OJ0JS4dH1DeNZt5MX7JFJJlLjOirVFzLp3iEuUe1bvP8CsAH06mklCCocAD31lz31P4ORxT+q+bPrkB4dLQMWTve5zkBVMnjTh7bsFJwMUvOr/Wr7OnKSkwXbqF/qkeqSbB3Zs6UWMcjcyO90n3BmpusgxAYWap7p/FO2l5KcO+e/S/Bmbj2FrKdb5JWYd+ce8HpehRNyf4gpg6msYZXYqC9cYcrFi4oSu3Co8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr/Xhd1d7dESsC1VuxFhwMw11NLpkePSUlFRExjXuG4=;
 b=H8h01x0aiMEDJU3g0RufoTKW3fkSNBkL08qUgtr4WZo7M0DAcUaHiXF0Q9nYFaEfmr/hfQbvnysSwLt9JNNPWfz9tirvQpz2FENXlt1ldOiqh8qJboauErnojrK7i53y6AmK+wUtPYnOqpjEZVBRnWWNvyNRzcoR2vh2VwNBRSE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM8PR13MB5080.namprd13.prod.outlook.com (2603:10b6:8:23::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Wed, 31 Jul 2024 15:27:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 15:27:19 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>, "hristo@venev.name"
	<hristo@venev.name>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "blokos@free.fr"
	<blokos@free.fr>, "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: kernel 6.10
Thread-Topic: kernel 6.10
Thread-Index:
 AQHa1uRgrsAgQ2eJa0qLuYQQmTl24rH5h2cAgAeGIYCAAF4sAIAJ8j8AgAAGkQCAAH9ogIAFKo0A
Date: Wed, 31 Jul 2024 15:27:19 +0000
Message-ID: <eba1f68169ce0bfdd5e0881e04f67b0c57d6ce2e.camel@hammerspace.com>
References: <b78c88db-8b3a-4008-94cb-82ae08f0e37b@free.fr>
	 <3feb741cb32edd8c48a458be53d6e3915e6c18ed.camel@hammerspace.com>
	 <zyclq4jtvvtz6vamljvfiw6cgnr763yvycl3ibydybducivhqh@lj2hgweowpsa>
	 <3bd0bfc1fced855902c8963d03e8041f4452b291.camel@hammerspace.com>
	 <47219e1df5edbfaf7e8a64ebf543a908511ace85.camel@venev.name>
	 <5412f22e497b11c1cd3fc8b8d8f30d372b68cd03.camel@venev.name>
	 <sl7cfmykqthhjss3qxeg2aweykff2gurcjqczfry62ne6edrfa@oocwcci6im3o>
In-Reply-To: <sl7cfmykqthhjss3qxeg2aweykff2gurcjqczfry62ne6edrfa@oocwcci6im3o>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM8PR13MB5080:EE_
x-ms-office365-filtering-correlation-id: 905c4ab1-86a8-4726-bf59-08dcb1754437
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|41080700001;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGZZd25hSzZFK0UxYjJPdGFCMHFsSnF6RXo4anZEWkN1VkpVL3ZkdXVYV3Fl?=
 =?utf-8?B?M1lid045NTN4UXVGK0VSd092b2lMTVpmM0hGMGFOWkFjWCtTS1UvMjVrRGc4?=
 =?utf-8?B?ZnJib2xCZEN5d1hxUlJ4UTVmNGZjMnRnMlFkV1Q0cHFzdUVpcGhFMlpRUzhB?=
 =?utf-8?B?TEtVZzNMeHpxam9XalpOeTFZQmRqQThXUkRvTTlVQnR0RWw1WUNqeVZWOVBE?=
 =?utf-8?B?SDQrZmxJWU1JVlhmWVJNb1I3UndHeFd3ck1NVnR1N2pKUUZPUDkxM2k0MHVP?=
 =?utf-8?B?dytMczRJQlB2bE13QjdtbGhUc0NDYVJtajBRbVdBQWdNTGt5YnRONjl0dzNG?=
 =?utf-8?B?TUFvdWR3dlljWno4SW1ZbUp2NHRPa000UURVUWVFNzZ1YUNpMDdDbUhBOWw3?=
 =?utf-8?B?STBDVFcwL3p0dGJVZXRnT0hkdXcwQ0lKRlp2VEpqei84OUhSaFFscWhnMzVL?=
 =?utf-8?B?cVB3ZmRwVURSL21oVFgxNmpzVHZYb0YyV3hoSURYd1ExejkrV1RhYnZONUUr?=
 =?utf-8?B?L0lUbTBIeTBPRVpKa1Y3S0dTN0V3QWJZTTRVa1hkUk5hR2x4d0dHdzk0dTN3?=
 =?utf-8?B?Ym9hNzN1TU5wNmdzeEhGQkJINk5Mcm1iVGs3V3RBbHFvRWVITHkwOGRqNFJa?=
 =?utf-8?B?TzZGa2VISDMwWjA4b3RHT1pGZ0NqYkxqQWFsV0QrNjdhQTVrMU9CYTBkT2pu?=
 =?utf-8?B?R1pObUNsQ3pCc2ZCcDdqNlhuM0ZTaXIvQ201TXh6L2htelloWWxOM2toUVht?=
 =?utf-8?B?bnpMQ09MVEh3bUs1WUZkQThmcnhHUGpleDZxdHdRdDVQQUcxUExDTDBnbDc0?=
 =?utf-8?B?ak8wNmxJbkpyOWNRc1dsVWE5V0pmRkgyT0U3OTM1d3lwOFhOUlFVSGVOcWpm?=
 =?utf-8?B?Y2N0OUtqd0Y3cTgrY0Y2T3FleGs5bUNsY1h5ZEREK1g1OW9aOVlkYnFHOVcy?=
 =?utf-8?B?cVUyN0VnU0FjNWNnZUxYVlcxNGVSU2JwV1Q5RGVOUWI3MmFqUnBsSWtFOVdN?=
 =?utf-8?B?d3hnUS9qb3o4SGYzczl5VERRazM5MWg1K095K1grZzRzdCsrcWhqNGxwWmZW?=
 =?utf-8?B?Snc4UStlejVVMVJ6RWxVaHJtaVJocnZ2Z0NRYVlGSTZXWmQwMFRGdytodmg4?=
 =?utf-8?B?ODBhQ2hyWi9oRmFQRW5oZHdYSENPN3pqbWhZeU1QaTB3TTdkdXliYXpCRDM2?=
 =?utf-8?B?VUU5elpRZnJvQzBrb0U2ajRHelZGcnR0aVdnL1RDSi9MaCtINVBBQlF5b0Jq?=
 =?utf-8?B?djUvdGlhRXZscGxsTjI2WmQ3ZHN6ell0OTFqVlhCQXZSMzZwSHdjK2dzcmRm?=
 =?utf-8?B?V2p2U2tCdmIyTzJTVis3N1QwM1BKMXZuc291OFRDcEt5V0xTY1pXbTlSSUdl?=
 =?utf-8?B?U3BaQlVpYVJzM3FTcXF5NTNHbTA4MVcyVUNKV0h4aU14ME9FWHE2Sy9SMmlD?=
 =?utf-8?B?VGdmRWtEck53TnlRckw3Y3d1OC9iWjBwT3BoYXNKYTh4K2phcEhSMDJPZmFx?=
 =?utf-8?B?T2xkdTBnZ1FjVkZDUm94cncvSXlXV242ZFd4SXpuR2lNZFBxTjhUM1Bob1A0?=
 =?utf-8?B?QStmZXp3ejRkV3luN3lya2FyVVE3TDRMM3JjYVp3cXl6MCt0dEtuNzkyT2pn?=
 =?utf-8?B?a1V1SUhwZ1VqSFFadDlhM256NGhPRGVVWjBaLzhlRzJCcjJaNlVtWnhTeURJ?=
 =?utf-8?B?b2NkU3NJcUtITlJhaVVkalErSHNqTzc5MmIrNDYvckdTTUlPeXA5R1JxZytw?=
 =?utf-8?B?Nk4yRkZGR092NkJ5OTB5b2FwaytHd1RlWHdEKzg1YXQxdnhVRjZicEhqQlRv?=
 =?utf-8?B?dm9pWjlZNTVqajh1VkhDaDkrMDRESnBFazZKUnE4UCtITC9taFpWdHBGUjdz?=
 =?utf-8?B?NVl2UTdPZ2NRblF4NTZZdUNVUkNCTXN0MjF1cEF0ZlYzMitHZ0o4QjF0RzYz?=
 =?utf-8?Q?B9D6oVpNdEHv8PogfzXrNq73qXy3vjO7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(41080700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGc2RlZCZ2tJckdoS3VlTkh2dE1vSnN6c2MxcERQOG9nNEVhSkgzQnRMc2tw?=
 =?utf-8?B?aCtqTUNsZnJvMVZaN0VtVjFYMWlPWlcxSU11enFlMkJRYzBqS09CaE1BTStY?=
 =?utf-8?B?V1VaVHd3anZqanFVY0sxMjJsVmIvbFN4RzlRMVZ3aDRvRHJINmRDMlBHWDdI?=
 =?utf-8?B?WmcrOGk4UnVwOGtuUzRNcjJteXRSaEs4WFZZcUc1c0RnU3lZQ2VOU0EwamJj?=
 =?utf-8?B?T0wxeGovZUk0Z2tBK0JJNlNxUno2c2hZdVY2VzZZSmswVmV0VDlHNEMrWXpJ?=
 =?utf-8?B?VDE4MUhjSkkvTE5KMnh2WXUyWVZOQmJZMlJoc1hDSTI1bkFETDNaN05hZlE3?=
 =?utf-8?B?NjBLT01lUzRJZTlWRVBNc2pDMDhta25DQ0hpZXFJODRVYWhLaURCYXc1OVg1?=
 =?utf-8?B?djR3Nk14cHgyQkhvTmQ2UUlNL003a0NOaDFyR1FNc3J3dTZNMGlNUXZRbWNZ?=
 =?utf-8?B?eUwrRUpIU0RBcWZXUnNQODJVaUhoZlc0WVhrK2U1c0lvQzJYTWl1NHZjdWg1?=
 =?utf-8?B?SlA0Mlk0bzh6UWs0dndua29RNEg1L2ZPRXA1VWtyd1JndzFPMThsYXZrL1Yy?=
 =?utf-8?B?d1FNSjF4NGdTR01KektTOXRaUzV5Sk13U2J1dk5zWHFLRXEzR2VzN0dXd1po?=
 =?utf-8?B?TStNZmpUek0ySHJnVkc3MEFQT1RWNTFRRGtJYS9qYml0eGlGcnhLNTVib3ZL?=
 =?utf-8?B?NmlmQkFtcXZDNGh0OFJZRktoZ1Q0ZE8vbzNkRS9aenpHRllvRlAzakRkbS9Y?=
 =?utf-8?B?d0pJRXdET2g0QTloM1BnUWwrdk42VDNGV20zV3o1U1RJQlVINThiRXRmOHJX?=
 =?utf-8?B?azAyN08wRW84TzVpWTZVWjdIL1FEdTZaS3JtRWNwZjhtSVFabEE1WjlPSTF1?=
 =?utf-8?B?b1hRTUtuT0RHaGVlV3UrWExrVDliMURQMXExalNqT2M5b0Q2bXUxZjBoMk9J?=
 =?utf-8?B?ak5rVHV0WFNLVDhXdFhLWTJuQ04rTGZ1cXFnaWFiMkx4eWszMUFNNTNXc21a?=
 =?utf-8?B?YUR3MHhBWjZDcGlIdWQ0dXkrQkhoR0JSZ25CVUgzMXRuQTVUUmtrQ2VaVzNH?=
 =?utf-8?B?VjVaZVJXZ21WblpTSTVVQy9SSTlxa0RDWU1FdWZ1czhZelBIaGxjUEJCQkhB?=
 =?utf-8?B?ZS9tb2NpSXptZmg4Tm5NclY1OUt4QjRRV2w1R285cGdoU0xpUmg1L0J1Y0F1?=
 =?utf-8?B?ZkRmMnBTc2M4bDExaTJSa0U5SklVcTdpcDBWNzFpeGpmeWEvd0FxcmpVaG9B?=
 =?utf-8?B?VXliZksxT0VKVklqMHlwZFRhV21xNW43VEhmMFBHWjlEdHMrL2RYSVJYZ3RR?=
 =?utf-8?B?ODlraUNmM3FiTG9PQjdKOUdqL3pjRitoMExsZTAxRHdUbTF5RnBUdUUxWkRp?=
 =?utf-8?B?WTdYclR4akRNbmp0VnBBK2RaVGQ0UE9NQkYwQzBSMitnTkcydCtPOXpqOG1r?=
 =?utf-8?B?Uk1pRlhyaHBiQXNKcnc0Wk9qMWVYZVNSdVdxZDA5SmJqSHhqYlVFSFduWkpx?=
 =?utf-8?B?QmxZZEx0QkZVVDdUaGFadkFVVWxuQk5lRXlHRTh1UDNEazdLaHlIdEhudXUz?=
 =?utf-8?B?RkNWK05XR1NVbUhOVjgrTmNDaE9pTEQ1a2RNUlEwZG1TUnFHWlBEZWRZSlJX?=
 =?utf-8?B?bUR4OEY5RUdvOUxIRzNpcVVCdXdFOUxyWEUzNkJOWDBleW5KeUV1TzlrZWw0?=
 =?utf-8?B?alk2a2JpUW5qemFCZ2RxdU1JZ2NENnpoYnp5Q20rOHRCM2haNlhFV3JRckRL?=
 =?utf-8?B?RXpzTTRmeGlibXN6WW11SnVEQVJUY2ptNXJtajNDYnVjeDNGT3JZWGlycS9p?=
 =?utf-8?B?UWV1dGFaUllIVTlJMCtIMVNHMHErT1BwRmtFaVl4K0Q0Rm84MTlBNFkvdEpn?=
 =?utf-8?B?NitPVU1xUWpNUkZGcHFxTnNEME5manozZjNYdXZER2dZSEN0Y0xza2NBa0F2?=
 =?utf-8?B?dWFVRnhURWJWM2R0RFF3NWliYkxKSHhGRVJvME9EQ0dLdHVWWFlIUVlsT0t6?=
 =?utf-8?B?V0FJb3duOG1XaTBDdlovN1JMMmNMNUZHMCtXUjhCY1RDbi8xQUErdDRPdkJ6?=
 =?utf-8?B?VUR2dFU1RytFSTE5RTFPNDA1SHpmTElRWjlDRitDM3B1UVR2VHB3L0FBVHRo?=
 =?utf-8?B?NHB5ZXpWeVdxWG5OMnExd0tIZjlBdy9RN0ZNN1hlWVBLV1Z5a0N4Wm1SNHhN?=
 =?utf-8?B?eHdQYzZJL0dyMW44V1RJNzFXT2VPbEdkRWFsRFplMHd1L3d2Tm5TSkplVnJm?=
 =?utf-8?B?c04zaTUvZktyMFF1TnROMEdVOTl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23499D655CB5854EA5F3677E33560453@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 905c4ab1-86a8-4726-bf59-08dcb1754437
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 15:27:19.3103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B75dBeaUp+l35wNwfgtiYnAXYjBweXpaMHN/Ijz9SVh/2TuLfxGuRH1soGY4LreE3B9VHGbOndndVTB5NmdpXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5080

T24gU3VuLCAyMDI0LTA3LTI4IGF0IDExOjMzICswMzAwLCBEYW4gQWxvbmkgd3JvdGU6DQo+IE9u
IDIwMjQtMDctMjggMDI6NTc6NDIsIEhyaXN0byBWZW5ldiB3cm90ZToNCj4gPiBPbiBTdW4sIDIw
MjQtMDctMjggYXQgMDI6MzQgKzAyMDAsIEhyaXN0byBWZW5ldiB3cm90ZToNCj4gPiA+IE9uIFN1
biwgMjAyNC0wNy0yMSBhdCAxNjo0MCArMDAwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+
ID4gPiBPbiBTdW4sIDIwMjQtMDctMjEgYXQgMTQ6MDMgKzAzMDAsIERhbiBBbG9uaSB3cm90ZToN
Cj4gPiA+ID4gPiBPbiAyMDI0LTA3LTE2IDE2OjA5OjU0LCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gPiA+ID4gPiBbLi5dDQo+ID4gPiA+ID4gPiAJZ2RiIC1iYXRjaCAtcXVpZXQgLWV4ICds
aXN0DQo+ID4gPiA+ID4gPiAqKG5mc19mb2xpb19maW5kX3ByaXZhdGVfcmVxdWVzdCsweDNjKScg
LWV4IHF1aXQgbmZzLmtvDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
SSBzdXNwZWN0IHRoaXMgd2lsbCBzaG93IHRoYXQgdGhlIHByb2JsZW0gaXMgb2NjdXJyaW5nDQo+
ID4gPiA+ID4gPiBpbnNpZGUNCj4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gZnVuY3Rpb24g
Zm9saW9fZ2V0X3ByaXZhdGUoKSwgYnV0IEknZCBsaWtlIHRvIGJlIHN1cmUgdGhhdA0KPiA+ID4g
PiA+ID4gaXMNCj4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gY2FzZS4NCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiBJIHdvdWxkIHN1c3BlY3QgdGhhdCBgLT5wcml2YXRlX2RhdGFgIGdldHMgY29y
cnVwdGVkIHNvbWVob3cuDQo+ID4gPiA+ID4gTWF5YmUNCj4gPiA+ID4gPiB0aGUgZm9saW9fdGVz
dF9wcml2YXRlKCkgY2FsbCBuZWVkcyB0byBiZSBwcm90ZWN0ZWQgYnkgZWl0aGVyDQo+ID4gPiA+
ID4gdGhlDQo+ID4gPiA+ID4gJm1hcHBpbmctPmlfcHJpdmF0ZV9sb2NrLCBvciBmb2xpbyBsb2Nr
Pw0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gSWYgdGhlIHByb2JsZW0gaXMgaW5kZWVk
IGhhcHBlbmluZyBpbiAiZm9saW9fZ2V0X3ByaXZhdGUoKSIsDQo+ID4gPiA+IHRoZW4NCj4gPiA+
ID4gdGhlDQo+ID4gPiA+IGRlcmVmZXJlbmNlZCBhZGRyZXNzIHZhbHVlIG9mIDAwMDAwMDAwMDAw
MDAzYTYgd291bGQgc2VlbSB0bw0KPiA+ID4gPiBpbmRpY2F0ZQ0KPiA+ID4gPiB0aGF0IHRoZSBw
b2ludGVyIHZhbHVlIG9mICdmb2xpbycgaXRzZWxmIGlzIHNjcmV3ZWQgdXAsIGRvZXNuJ3QNCj4g
PiA+ID4gaXQ/DQo+ID4gPiANCj4gPiA+IFRoZSBOVUxMIGRlcmVmZXJlbmNlIGFwcGVhcnMgdG8g
YmUgYXQgdGhlIGBXQVJOX09OX09OQ0UocmVxLQ0KPiA+ID4gPndiX2hlYWQNCj4gPiA+ICE9DQo+
ID4gPiByZXEpO2AgY2hlY2suDQo+ID4gPiANCj4gPiA+IE9uIG15IGtlcm5lbCB0aGUgb2Zmc2V0
IGluc2lkZSBgbmZzX2ZvbGlvX2ZpbmRfcHJpdmF0ZV9yZXF1ZXN0YA0KPiA+ID4gaXMNCj4gPiA+
ICsweDNmLCBidXQgdGhlIGFkZHJlc3MgaXMgYWdhaW4gMHgzYTYsIG1lYW5pbmcgdGhhdCBgcmVx
YCBpcyBmb3INCj4gPiA+IHNvbWUNCj4gPiA+IHJlYXNvbiBzZXQgdG8gMHgzNTYgKHRoZSBjcmFz
aCBpcyBvbiBgY21wICVyYnAsMHg1MCglcmJwKWApLg0KPiA+IA0KPiA+IC4uLiBhbmQgMHgzNTYg
aGFwcGVucyB0byBiZSBORVRGU19GT0xJT19DT1BZX1RPX0NBQ0hFLiBNYXliZSB0aGUNCj4gPiBO
RVRGU19SUkVRX1VTRV9QR1BSSVYyIGZsYWcgaXMgbG9zdCBzb21laG93Pw0KPiANCg0KV2h5IGlz
IG5ldGZzIHNldHRpbmcgZm9saW8tPnByaXZhdGUgYXQgYWxsIHdoZW4gaXQgaXMgcnVubmluZyBv
biB0b3Agb2YNCk5GUz8gSXQgZG9lc24ndCBvd24gdGhhdCBmaWVsZC4NCg0KTkZTIHVzZXMgZm9s
aW8tPnByaXZhdGUgdG8gY2FjaGUgYSBwb2ludGVyIHRvIGFueSB3cml0ZSByZXF1ZXN0cyB0aGF0
DQphcmUgcGVuZGluZyBmb3IgdGhhdCBmb2xpby4NCg0KPiBTZWVtcyBORVRGU19GT0xJT19DT1BZ
X1RPX0NBQ0hFIHJlbGF0ZXMgdG8gZnNjYWNoZSB1c2UsIHlvdSBhcmUNCj4gYWN0aXZhdGluZyB0
aGF0LCByaWdodD8NCj4gDQo+IEFsc28gaW4gYWRkaXRpb24gdG8gbXkgc3VnZ2VzdGlvbiBlYXJs
aWVyLCBJIHRoaW5rIHBlcmhhcHMgd2UgbmVlZCB0bw0KPiB1c2UgYGZvbGlvX2F0dGFjaF9wcml2
YXRlYCBhbmQgYGZvbGlvX2RldGFjaF9wcml2YXRlYCBpbnN0ZWFkIG9mDQo+IGRpcmVjdGx5IHVz
aW5nIGBmb2xpb19zZXRfcHJpdmF0ZWAsIGZvciB3aGljaCB0aGUgTkZTIGNsaWVudCBzZWVtcyB0
bw0KPiBiZQ0KPiB0aGUgb25seSBkaXJlY3QgdXNlci4NCg0KTm8uIFRoZSBvbmx5IGRpZmZlcmVu
Y2UgdGhlcmUgaXMgdGhhdCBmb2xpb19hdHRhY2hfcHJpdmF0ZSB0YWtlcyBhbg0KZXh0cmEgcmVm
ZXJlbmNlIHRvIHRoZSBmb2xpbywgd2hpY2ggc2hvdWxkIGJlIHJlZHVuZGFudCBnaXZlbiB0aGF0
DQpuZnNfcGFnZV9hc3NpZ25fZm9saW8oKSBhbHJlYWR5IGRvZXMgdGhpcyBmb3IgdXMuDQoNCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

