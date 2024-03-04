Return-Path: <linux-nfs+bounces-2172-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B048708DB
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 18:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A547B1F25AD8
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F4E60253;
	Mon,  4 Mar 2024 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="QySWWXRk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2136.outbound.protection.outlook.com [40.107.220.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256CB612F6
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575058; cv=fail; b=LUOxAOMg+nAETXMyZZFxLFxHTZUGLpq42CA8lSKNLxMfNEv7jTGdwUP0SZQqyn0zrYqaBL8WgC+4Q/KMut+u0Csp0rAnz9E+fq42q3qBOvIlmh0U3RuhcztFxk6nrtcO1+yGdipx+OUosGIxvy0CoqG+u5MLRgr+QaVswrB3Ryg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575058; c=relaxed/simple;
	bh=dLQUDkDOsFGoN3zM8LUZbVnpfCYAcylPGcqqdvVEsLM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kxL440i50NEKVnQRW7OAI9cQLGL8C05BwmLuJlrFz/e21XPM20+5vKXI1mW4E0jwx44PBrVqHlzDblArMMBTvtBrZreDnXX8ab5X4ERlE+6qH2hIjUYdco/FK6EWat6PWGQtCCuT7vj7VE4JuSGEy6L0B+UBQounrvesqvqIcuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=QySWWXRk; arc=fail smtp.client-ip=40.107.220.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyXjDSN5nS6J6pR5ZPbBBBE/vHk2M/nRA4YAd9vGFgY7M/8e4MTCinE2GL9b7LgDtBB5ScFLiBcMj7jjnFpTkD65s/7UqmDpCQfvqjJjLDmsZnS4Es3YU2ftzWwD1fz/Fda3nf0qNsAHaNn/fCg0HbSxbeacRydsHU6jHBkwtNOhixL3+hr/V53YLLRlC4OJywsPW/9VQ+ucxDaEKWiYdzlF9oQLstezgpfY0/EiectXW586t+ExyHRnIUJDf01K20IXa+Cot+cBaHCkIxfJ6KOrk0NpRVrsTokND1wdwNRinbRCA+r74zKGflkFQWgYrIH28JqyujBVvsi4+IwIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLQUDkDOsFGoN3zM8LUZbVnpfCYAcylPGcqqdvVEsLM=;
 b=a0uJ00OFXWLXlp7xKjMjhCeHCBitUn9n+moeYV38NAuqiXJ3oW1ynz0qQEmR1W8ZG0X5YtLXc4fXGwCUWI/GuyFegmVN9Z2dLQ/rHMv3bdKKI9iyUSJ4mnXktqQMnPg8ECHeQofCMBpkCJ/4T/7kxcptXT9aYvvHR/4NXbCg34X8+0diYoJVY77Kr/7B+E4d+oHfijWHEANSU6hCc+JXHTVoSW+G0dmbVmOfXtNKCdtjXBLy+mZyHoz5U/Hk57+diXEKPpsl+j01Q7KdII71BbSBQjVD3yfufIWnFcNUtbVFTOBjUct9+Q9BL8AshJoqbZrLcQVVezJcjc4Q8/ZosQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLQUDkDOsFGoN3zM8LUZbVnpfCYAcylPGcqqdvVEsLM=;
 b=QySWWXRkqC1H/5X/6dFzKkwm9r4YsB365lueHUKjjMiOkqUTD68RTNbdlv2OPNPPMIcSjuKnf5tybpz7F/rvQjZLDbIESKv5g4HjaRqkuOTD2w+4AQxaUwFvNGM3x1gvMXycMq/IBsAwdE4D9p5Yt8aJohCGKRu0561aj2eEIVI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4474.namprd13.prod.outlook.com (2603:10b6:610:6d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 17:57:32 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 17:57:32 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] nfs: fix UAF in direct writes
Thread-Topic: [PATCH 2/2] nfs: fix UAF in direct writes
Thread-Index: AQHaa/iVDeXLuY29ykyibJe+Be7gpbEn4ugA
Date: Mon, 4 Mar 2024 17:57:32 +0000
Message-ID: <8d7c4e27bc29c3280ba016d45e96efba02eba818.camel@hammerspace.com>
References: <cover.1709311699.git.josef@toxicpanda.com>
	 <d4a26214294fb967a6d828b8d750215f7a6e4897.1709311699.git.josef@toxicpanda.com>
In-Reply-To:
 <d4a26214294fb967a6d828b8d750215f7a6e4897.1709311699.git.josef@toxicpanda.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH2PR13MB4474:EE_
x-ms-office365-filtering-correlation-id: cd22011f-0c29-4ac6-cc0f-08dc3c7490aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 upUYnWvw2yGNrnm7LPXSusxN/oLtw2SKSW/Wx3n32DvBL7x4vEUhsh+S4qkqun2D8QYTDtR1fuk76a/XlqbVdO9ZaNUnBt4XU1vFot+OYHyAc1YK/VIpnITk407O+KAxuVKVgvMPvyFrmR0rYhGqcltDG6i32yzbWw7mdXnjSSElTl+5R/WkBG+tziNqT2a6gfXyNL5wmN1cjfYdSqsCu73iqUTzzPV1Impo6EML4QkOzadK8UyRAGzxkG1H68jSzs+tOdg5Lg2RrTqiItK157hhmwxGZvTwd9hK99L0OTnnIcyTsqCI+HYJmPFX6xHgIN5v2nKOW7Pcbnu4tg29zuB5sl0zluMiOcsdtue2OW8cb/Zhvufmur31znUIDHBerpgvdzVAPB2VU5B+eVEz7NMaSj3EjHn21y0LZYWb9bRj/kX/7sXy8uT2WQZfLddkytDMRd9XMWpRfdW86mpScFtHXRL+7trPdFBA1Xlvs8j3N7f/MJyQcoiDNvgQF+e/WSxCD+NRLlkDTcRAwpjoD6PLOm+8AtXf892ceCekuDvNTmf17816EtR5sGFk6Oou0YSB3qNcn7yB33PpWLfyOOO7f+V65KBUvglrjIJg9ha3n8eBDAsPxpsSJ1ySd1ZWOj8PZOuHhMjA9o4ALbWATCCtMJ4tkbb7pdSsTQKOiG8NiBjDqSbyjR86hFGU2Sx+BongoAWaJyLHiXJnEeguPLLC05snlbbmw9TLq5PMpOU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFZFOEcvVkZRZGNWYVR5N1BzbDk5YzZianZGU3RIZTVhZWNBMldLTmIrRmhS?=
 =?utf-8?B?MEdXVHA4Z3VlLzd6RlBDVW1Ia2F6Y00zT21MQWNEZDlSbFRhKzQ1Z2ZRSTNN?=
 =?utf-8?B?TllsY1UxcTRWZHh6UmlZN1RvMTlKYVhmN0Q1eSsvTEJ5aUtuclFWaldkdmVQ?=
 =?utf-8?B?TnkvWFE1MmRLQUV0dUNLa0l2Zm1salp6K2dQOVFsMTEzZzk3Y3lkQnNzMHdS?=
 =?utf-8?B?dzg1L0dFaHNBTVE0ZWR6WDgvMHVGVFlhb2lybXpES1lRckp1dGlsOG5CempO?=
 =?utf-8?B?RFlSUzVSNnpOR0F3MllpRFFYeWdsRkZiRnhrS08xVkFnMEFuOWhFUkRLM0p4?=
 =?utf-8?B?bUk0K1BEeW5wd1dkOHlmbGU4eHpNVXFxUkF2aFdOVkpZdFRwdXV6cjlORisx?=
 =?utf-8?B?c1lvdFQ1bUt1UEQ5Tm1PSHNGK25lZk9NRDBBVjJzaGtyNzR3ODRRK214YzNi?=
 =?utf-8?B?b3hKaWJDNWw2TFVJU2R5NG1GZjR2YmZjTjBDY0hsditXTUI2RzVaOUJsYWp6?=
 =?utf-8?B?bm4wVkhCcHd3MVF0Mk9Od2JlOVJqSVJZcm9ObDRyVEYrMTM0NmlzMXMyTzJG?=
 =?utf-8?B?azNkaEVOUU43M1VBNlJLc0lSNVVocUZHam80bnR1ZlNwWW5Ndmo0SUVZNFpt?=
 =?utf-8?B?d2pnYkpLMTA0U3RxRG5qdSs2YVZOZzV1TnY0V2toNlRDSy9vNWtsUVZsYTlr?=
 =?utf-8?B?MHEvbkJPZHZMQWtqa1RlOUNmREVkS0Z3OXFOZU9BVXRpdTBONFEvOG9tVWVD?=
 =?utf-8?B?ZlNIN21iZld0akxHRHZqcldMQUVGRDNWV0FpTG9LSmVpWUlWTTl5OXYzM0c0?=
 =?utf-8?B?NTNSUUsrdGRiaTZOL1hoSzBOMGU0a2oyTGZ0dGQ2UzRhb1pQc3JVd3VibGtC?=
 =?utf-8?B?bWQwVDhVZHRsQ1U3TlFrczJraThFTHFUbzdSekVEbG1lMjcwUmlTM056NnB1?=
 =?utf-8?B?bnRYS0p1citGZ3EzQmxWQlQ0M1Jic1lFNFZHRlcrRXhYWGdRMG1RYTAxTFpF?=
 =?utf-8?B?elJRa010QVhoa2lCVXAwMTh1bmFYTDJpZnMxR1pnOWNWUVBNL0ZDNEIrS1ly?=
 =?utf-8?B?YkhoZjVQRzF0TTBaMGh5NHlkY3VNdjZWQ1lkMzJmeUhjai9qMUp4S2tmYTJF?=
 =?utf-8?B?eWh2VG52a3VTbnZaSHdYTDRBNXBlRitEV0lnMTU0TkUyUHh2dGlDT3oyTXVk?=
 =?utf-8?B?YVFDS05aRlBsNWNoOUJhN2V0QWp2REhCN3didU9MVzlmT3p4WmN5RC9Wazk2?=
 =?utf-8?B?WkJiaXhkcXFLK0Y5REczeUgzYXMrTzVvU3V4dUhjOStnemNOUTNZQ0k1T2to?=
 =?utf-8?B?dTl0SDlIWWVteTVWbzZ2djBtckEyYlcxU3JDd3gxWVRJMlhEZWladVJnb3dH?=
 =?utf-8?B?ZEE4MmdzR0tLcjRqUXZwM241dGdGTER1NkZqL1lCazloUk9YOXN3TkxPVmtz?=
 =?utf-8?B?V2E0UDFNWmRnQ0tQMzgrMm9XeGdoZ2hZbU5JU1JRcHZMZ3hxSVNZNEJlUW9Y?=
 =?utf-8?B?bjBLN0lwcHdid0tjdVErVDVmeWZkZktvY05Ta1g1SnBiT1NxckNFUndqYlFu?=
 =?utf-8?B?aE1ZODlSWDZDWm41VG1UQi9YSFRJNWpGNlBVVWFjcENsckNrLzdsRHlkWHJ5?=
 =?utf-8?B?MStrZTJWdFYwZlhPcE13YXpCWTRPOWNzaXA4T0FWSFo4dUNWVnkwRHRON3Mz?=
 =?utf-8?B?QmR6bHczQWhiTmI3czJpazZtOWhwNXY2QVBqMHU3c3ZITEljWW1nc0k3eWRy?=
 =?utf-8?B?dTFEamRVRG9xazlOZGVpZmlJZkNxcCttRTNkeEg4SUtNUnNhTDFjd1FOa0tH?=
 =?utf-8?B?bFZVd1RvWkUvc3FZcE1EQlNVdzNneHhodXNkbmg1SytNdnNCTTJwbG1LbnIz?=
 =?utf-8?B?ditVaXovbmNSaUY3Sld1Um5VZVNNeFByK0IrUkUyVXNNTm0vM2tieUYvM1lr?=
 =?utf-8?B?dTQ3dDliS21FU2QzakZpR1VqYWJjTmJsSDRBbVEvOUtjTkRtY0Nab29xWFE1?=
 =?utf-8?B?SUp6TStxMGNlTkJiZ0wrWFZSbWt6REsydFo4RlNoWEpQYVNpQXkzNFBuZXBq?=
 =?utf-8?B?TWV3YW9qSFpkam5RVmU1ODg4SEFSNUdXbWdJMDY5SlJWc3o0cWQ5RVZMUldi?=
 =?utf-8?B?MDVKUlVKRUhGYytZOUl2dlVHVWt4UlR2NS9Fc2VNUVEyZnRJWkN4SGtJVEJk?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E525CE0C14D134CB7B93ED0B321CB88@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd22011f-0c29-4ac6-cc0f-08dc3c7490aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 17:57:32.0236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUMejCYLxOcQ6TMV787L0Bqwb3n9bEjBAWgtHVqz6FRwY6n4q7BuULzG8nUt3U3z/xHtfzuGbO+Ejr7hE+w3qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4474

T24gRnJpLCAyMDI0LTAzLTAxIGF0IDExOjQ5IC0wNTAwLCBKb3NlZiBCYWNpayB3cm90ZToNCj4g
SW4gcHJvZHVjdGlvbiB3ZSBoYXZlIGJlZW4gaGl0dGluZyB0aGUgZm9sbG93aW5nIHdhcm5pbmcg
Y29uc2lzdGVudGx5DQo+IA0KPiAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0N
Cj4gcmVmY291bnRfdDogdW5kZXJmbG93OyB1c2UtYWZ0ZXItZnJlZS4NCj4gV0FSTklORzogQ1BV
OiAxNyBQSUQ6IDE4MDAzNTkgYXQgbGliL3JlZmNvdW50LmM6MjgNCj4gcmVmY291bnRfd2Fybl9z
YXR1cmF0ZSsweDljLzB4ZTANCj4gV29ya3F1ZXVlOiBuZnNpb2QgbmZzX2RpcmVjdF93cml0ZV9z
Y2hlZHVsZV93b3JrIFtuZnNdDQo+IFJJUDogMDAxMDpyZWZjb3VudF93YXJuX3NhdHVyYXRlKzB4
OWMvMHhlMA0KPiBQS1JVOiA1NTU1NTU1NA0KPiBDYWxsIFRyYWNlOg0KPiDCoDxUQVNLPg0KPiDC
oD8gX193YXJuKzB4OWYvMHgxMzANCj4gwqA/IHJlZmNvdW50X3dhcm5fc2F0dXJhdGUrMHg5Yy8w
eGUwDQo+IMKgPyByZXBvcnRfYnVnKzB4Y2MvMHgxNTANCj4gwqA/IGhhbmRsZV9idWcrMHgzZC8w
eDcwDQo+IMKgPyBleGNfaW52YWxpZF9vcCsweDE2LzB4NDANCj4gwqA/IGFzbV9leGNfaW52YWxp
ZF9vcCsweDE2LzB4MjANCj4gwqA/IHJlZmNvdW50X3dhcm5fc2F0dXJhdGUrMHg5Yy8weGUwDQo+
IMKgbmZzX2RpcmVjdF93cml0ZV9zY2hlZHVsZV93b3JrKzB4MjM3LzB4MjUwIFtuZnNdDQo+IMKg
cHJvY2Vzc19vbmVfd29yaysweDEyZi8weDRhMA0KPiDCoHdvcmtlcl90aHJlYWQrMHgxNGUvMHgz
YjANCj4gwqA/IFpTVERfZ2V0Q1BhcmFtc19pbnRlcm5hbCsweDIyMC8weDIyMA0KPiDCoGt0aHJl
YWQrMHhkYy8weDEyMA0KPiDCoD8gX19idGZfbmFtZV92YWxpZCsweGEwLzB4YTANCj4gwqByZXRf
ZnJvbV9mb3JrKzB4MWYvMHgzMA0KPiANCj4gVGhpcyBpcyBiZWNhdXNlIHdlJ3JlIGNvbXBsZXRp
bmcgdGhlIG5mc19kaXJlY3RfcmVxdWVzdCB0d2ljZSBpbiBhDQo+IHJvdy4NCj4gDQo+IFRoZSBz
b3VyY2Ugb2YgdGhpcyBpcyB3aGVuIHdlIGhhdmUgb3VyIGNvbW1pdCByZXF1ZXN0cyB0byBzdWJt
aXQsIHdlDQo+IHByb2Nlc3MgdGhlbSBhbmQgc2VuZCB0aGVtIG9mZiwgYW5kIHRoZW4gaW4gdGhl
IGNvbXBsZXRpb24gcGF0aCBmb3INCj4gdGhlDQo+IGNvbW1pdCByZXF1ZXN0cyB3ZSBoYXZlDQo+
IA0KPiBpZiAobmZzX2NvbW1pdF9lbmQoY2luZm8ubWRzKSkNCj4gCW5mc19kaXJlY3Rfd3JpdGVf
Y29tcGxldGUoZHJlcSk7DQo+IA0KPiBIb3dldmVyIHNpbmNlIHdlJ3JlIHN1Ym1pdHRpbmcgYXN5
bmNocm9ub3VzIHJlcXVlc3RzIHdlIHNvbWV0aW1lcw0KPiBoYXZlDQo+IG9uZSB0aGF0IGNvbXBs
ZXRlcyBiZWZvcmUgd2Ugc3VibWl0IHRoZSBuZXh0IG9uZSwgc28gd2UgZW5kIHVwDQo+IGNhbGxp
bmcNCj4gY29tcGxldGUgb24gdGhlIG5mc19kaXJlY3RfcmVxdWVzdCB0d2ljZS4NCj4gDQo+IFRo
ZSBvbmx5IG90aGVyIHBsYWNlIHdlIHVzZSBuZnNfZ2VuZXJpY19jb21taXRfbGlzdCgpIGlzIGlu
DQo+IF9fbmZzX2NvbW1pdF9pbm9kZSwgd2hpY2ggd3JhcHMgdGhpcyBjYWxsIGluIGENCj4gDQo+
IG5mc19jb21taXRfYmVnaW4oKTsNCj4gbmZzX2NvbW1pdF9lbmQoKTsNCj4gDQo+IFdoaWNoIGlz
IGEgY29tbW9uIHBhdHRlcm4gZm9yIHRoaXMgc3R5bGUgb2YgY29tcGxldGlvbiBoYW5kbGluZywg
b25lDQo+IHRoYXQgaXMgYWxzbyByZXBlYXRlZCBpbiB0aGUgZGlyZWN0IGNvZGUgd2l0aCBnZXRf
ZHJlcSgpL3B1dF9kcmVxKCkNCj4gY2FsbHMgYXJvdW5kIHdoZXJlIHdlIHByb2Nlc3MgZXZlbnRz
IGFzIHdlbGwgYXMgaW4gdGhlIGNvbXBsZXRpb24NCj4gcGF0aHMuDQo+IA0KPiBGaXggdGhpcyBi
eSB1c2luZyB0aGUgc2FtZSBwYXR0ZXJuIGZvciB0aGUgY29tbWl0IHJlcXVlc3RzLg0KPiANCj4g
QmVmb3JlIHdpdGggbXkgMjAwIG5vZGUgcm9ja3NkYiBzdHJlc3MgcnVubmluZyB0aGlzIHdhcm5p
bmcgd291bGQgcG9wDQo+IGV2ZXJ5IDEwaXNoIG1pbnV0ZXMuwqAgV2l0aCBteSBwYXRjaCB0aGUg
c3RyZXNzIHRlc3QgaGFzIGJlZW4gcnVubmluZw0KPiBmb3INCj4gc2V2ZXJhbCBob3VycyB3aXRo
b3V0IHBvcHBpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb3NlZiBCYWNpayA8am9zZWZAdG94
aWNwYW5kYS5jb20+DQoNCkkgdGhpbmsgdGhpcyBkZXNlcnZlcyB0byBiZSBhIHN0YWJsZSBwYXRj
aC4gVGhhbmtzIGZvciBmaW5kaW5nIGl0IQ0KDQo+IC0tLQ0KPiDCoGZzL25mcy9kaXJlY3QuY8Kg
wqDCoMKgwqDCoMKgIHwgMTEgKysrKysrKysrLS0NCj4gwqBmcy9uZnMvd3JpdGUuY8KgwqDCoMKg
wqDCoMKgwqAgfMKgIDIgKy0NCj4gwqBpbmNsdWRlL2xpbnV4L25mc19mcy5oIHzCoCAxICsNCj4g
wqAzIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2RpcmVjdC5jIGIvZnMvbmZzL2RpcmVjdC5jDQo+IGluZGV4
IGJlZmNjMTY3ZTI1Zi4uNmI4Nzk4ZDAxZTNhIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvZGlyZWN0
LmMNCj4gKysrIGIvZnMvbmZzL2RpcmVjdC5jDQo+IEBAIC02NzIsMTAgKzY3MiwxNyBAQCBzdGF0
aWMgdm9pZCBuZnNfZGlyZWN0X2NvbW1pdF9zY2hlZHVsZShzdHJ1Y3QNCj4gbmZzX2RpcmVjdF9y
ZXEgKmRyZXEpDQo+IMKgCUxJU1RfSEVBRChtZHNfbGlzdCk7DQo+IMKgDQo+IMKgCW5mc19pbml0
X2NpbmZvX2Zyb21fZHJlcSgmY2luZm8sIGRyZXEpOw0KPiArCW5mc19jb21taXRfYmVnaW4oY2lu
Zm8ubWRzKTsNCj4gwqAJbmZzX3NjYW5fY29tbWl0KGRyZXEtPmlub2RlLCAmbWRzX2xpc3QsICZj
aW5mbyk7DQo+IMKgCXJlcyA9IG5mc19nZW5lcmljX2NvbW1pdF9saXN0KGRyZXEtPmlub2RlLCAm
bWRzX2xpc3QsIDAsDQo+ICZjaW5mbyk7DQo+IC0JaWYgKHJlcyA8IDApIC8qIHJlcyA9PSAtRU5P
TUVNICovDQo+IC0JCW5mc19kaXJlY3Rfd3JpdGVfcmVzY2hlZHVsZShkcmVxKTsNCj4gKwlpZiAo
cmVzIDwgMCkgeyAvKiByZXMgPT0gLUVOT01FTSAqLw0KPiArCQlzcGluX2xvY2soJmRyZXEtPmxv
Y2spOw0KPiArCQlpZiAoZHJlcS0+ZmxhZ3MgPT0gMCkNCj4gKwkJCWRyZXEtPmZsYWdzID0gTkZT
X09ESVJFQ1RfUkVTQ0hFRF9XUklURVM7DQo+ICsJCXNwaW5fdW5sb2NrKCZkcmVxLT5sb2NrKTsN
Cj4gKwl9DQo+ICsJaWYgKG5mc19jb21taXRfZW5kKGNpbmZvLm1kcykpDQo+ICsJCW5mc19kaXJl
Y3Rfd3JpdGVfY29tcGxldGUoZHJlcSk7DQo+IMKgfQ0KPiDCoA0KPiDCoHN0YXRpYyB2b2lkIG5m
c19kaXJlY3Rfd3JpdGVfY2xlYXJfcmVxcyhzdHJ1Y3QgbmZzX2RpcmVjdF9yZXEgKmRyZXEpDQo+
IGRpZmYgLS1naXQgYS9mcy9uZnMvd3JpdGUuYyBiL2ZzL25mcy93cml0ZS5jDQo+IGluZGV4IGJi
NzlkM2E4ODZhZS4uNWQ5ZGM2YzA1MzI1IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvd3JpdGUuYw0K
PiArKysgYi9mcy9uZnMvd3JpdGUuYw0KPiBAQCAtMTY1MCw3ICsxNjUwLDcgQEAgc3RhdGljIGlu
dCB3YWl0X29uX2NvbW1pdChzdHJ1Y3QNCj4gbmZzX21kc19jb21taXRfaW5mbyAqY2luZm8pDQo+
IMKgCQkJCcKgwqDCoMKgwqDCoCAhYXRvbWljX3JlYWQoJmNpbmZvLQ0KPiA+cnBjc19vdXQpKTsN
Cj4gwqB9DQo+IMKgDQo+IC1zdGF0aWMgdm9pZCBuZnNfY29tbWl0X2JlZ2luKHN0cnVjdCBuZnNf
bWRzX2NvbW1pdF9pbmZvICpjaW5mbykNCj4gK3ZvaWQgbmZzX2NvbW1pdF9iZWdpbihzdHJ1Y3Qg
bmZzX21kc19jb21taXRfaW5mbyAqY2luZm8pDQo+IMKgew0KPiDCoAlhdG9taWNfaW5jKCZjaW5m
by0+cnBjc19vdXQpOw0KPiDCoH0NCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbmZzX2Zz
LmggYi9pbmNsdWRlL2xpbnV4L25mc19mcy5oDQo+IGluZGV4IGY1Y2U3YjEwMTE0Ni4uZDU5MTE2
YWM4MjA5IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L25mc19mcy5oDQo+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvbmZzX2ZzLmgNCj4gQEAgLTYxMSw2ICs2MTEsNyBAQCBpbnQgbmZzX3diX2Zv
bGlvX2NhbmNlbChzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiBzdHJ1Y3QgZm9saW8gKmZvbGlvKTsN
Cj4gwqBleHRlcm4gaW50wqAgbmZzX2NvbW1pdF9pbm9kZShzdHJ1Y3QgaW5vZGUgKiwgaW50KTsN
Cj4gwqBleHRlcm4gc3RydWN0IG5mc19jb21taXRfZGF0YSAqbmZzX2NvbW1pdGRhdGFfYWxsb2Mo
dm9pZCk7DQo+IMKgZXh0ZXJuIHZvaWQgbmZzX2NvbW1pdF9mcmVlKHN0cnVjdCBuZnNfY29tbWl0
X2RhdGEgKmRhdGEpOw0KPiArdm9pZCBuZnNfY29tbWl0X2JlZ2luKHN0cnVjdCBuZnNfbWRzX2Nv
bW1pdF9pbmZvICpjaW5mbyk7DQo+IMKgYm9vbCBuZnNfY29tbWl0X2VuZChzdHJ1Y3QgbmZzX21k
c19jb21taXRfaW5mbyAqY2luZm8pOw0KPiDCoA0KPiDCoHN0YXRpYyBpbmxpbmUgYm9vbCBuZnNf
aGF2ZV93cml0ZWJhY2tzKGNvbnN0IHN0cnVjdCBpbm9kZSAqaW5vZGUpDQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

