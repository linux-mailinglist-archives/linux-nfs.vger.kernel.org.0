Return-Path: <linux-nfs+bounces-2265-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F548784CE
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 17:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116BE281DDA
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 16:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA204C631;
	Mon, 11 Mar 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="E9nfpAUb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2124.outbound.protection.outlook.com [40.107.243.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449C44AEC3
	for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173845; cv=fail; b=jvJdaUOs4TPYeTI4oQUEQVr8Yz/Jfs1rR4kymywmb3K0QDRp6gwZz5pvSPfb6TmfchT2MpLZUqIOAG+6hnUHZ4N3XNBQeyOoJezmrl6DnRHrBK0f+zQxVEr1e8ifIzaqjJ+LTaZgBNaQz7rKFrv/+qK/igBner1/mZ22+10lR5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173845; c=relaxed/simple;
	bh=FdMve5fnhnNpiNXN4qfTCg9nwKIC7OwnYKQ9/E+Ll/Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R3ApcO0E/tcqX+9LIKAWeWKp1UWF2ReKR3VlGwT5T2UBOxCqHqCTQf8iIB08xma21aTNIE+9azW3XmVOttdljZwdjrI6Ci9ErxvXRn6oNMths32SjhGGlabm64lGQn57OMhBlNBChiSKDa2LXmlt97/JqNF40mkt1J0jXtu/d0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=E9nfpAUb; arc=fail smtp.client-ip=40.107.243.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epC9p96mIqmB12S1+EpnEvtdks/wV6IwxPWwSSQtX0EOwL7Qn2xo24vlklVo0oaYaBoRsoPe7yUZSehUlQ9lnZ/37j4+SK4lR0jsaZ63XYGl1Y5l91avLo2KZJTno6JNoSj4P2bSdeeOFZiwoRQ7Ww6CmTtdH4J7b8fGV5l7UYNkoynApHWgWJgUPq+wflooSpFoFKhYvOYeG8UryHJ37wSuLyU8CsgzmXZOJug7Z14WgNGY+ul0F5ol6SGuwLzFtSTEQztuxenVD41NC7mBEJKRen9Yv8CLiT3C/0ibHGgUStpcUjRMfhPS5litMK7jLx5F86cAM7rX+UXx3R+mOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdMve5fnhnNpiNXN4qfTCg9nwKIC7OwnYKQ9/E+Ll/Y=;
 b=gyxSV/oe3CV1jk926vKexuZpnvojdY8eQ/DeYlVtXD8ti7HBPdSACqH7ZJJzhRvWnQJP4nU4XWCIQjotJ8W5F6HX4jRbPaRZrYz4usGA/CXFP3qZW4Nb0Koy2GpC/w/mEplbDsF7NqCd40HccnAHQ+wQeHZ5BTvH6r1CKrvr+N/ZTVVEAzL7yMANdJMVoMPyjae4R95W/ftES7t0kZaV5XizTQjCqi1lL7KGHkrEn5qgK4TpDZj0JvJByPVNLwKOgf3237a4WFFqZXL7Qls71bW2jc3Oq5Ws9EWvJGhE+1WTtd1L4PaTPe2LS1XYaWld1ec/E2I6d/uwXHTNjl5BtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdMve5fnhnNpiNXN4qfTCg9nwKIC7OwnYKQ9/E+Ll/Y=;
 b=E9nfpAUbrMCM8MXUHK98veQ00PttAqGN2llXaEmok+t8fgb+dTohcgZJS4hIvIYNUMSQxV6WQLW8rSw006wRzu3b4uiwVXANJktg/uI3aawROXU0DyHIx53Kwo2TGuhBggtzvb9iuhP6b1ZwjHsvYoVO5ckQxJbxTAiNrRc8Ymo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW4PR13MB5989.namprd13.prod.outlook.com (2603:10b6:303:1b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 16:17:20 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:17:20 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfs: fix panic when nfs4_ff_layout_prepare_ds() fails
Thread-Topic: [PATCH v2] nfs: fix panic when nfs4_ff_layout_prepare_ds() fails
Thread-Index: AQHac8aDvpHapxGXjk2hyK//gSh11LEyt58A
Date: Mon, 11 Mar 2024 16:17:19 +0000
Message-ID: <7f4eb4c997d8b527689bf76f4fe7c0263eee507c.camel@hammerspace.com>
References:
 <5a244749e5bfefd921cb296c9e7b16fe4990f440.1710169883.git.josef@toxicpanda.com>
In-Reply-To:
 <5a244749e5bfefd921cb296c9e7b16fe4990f440.1710169883.git.josef@toxicpanda.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW4PR13MB5989:EE_
x-ms-office365-filtering-correlation-id: fe2c2167-4ff6-4c34-88e1-08dc41e6ba11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 On0MGWBJYtwu/Y09pTS2wL5cXOng29HenoTDR7PNGObC6IFGbgny2GwyioNfK2ExtHmiBGt2XgmyQvqb3zV+PlqsoKrQlM5QOht4IuD5KSEDH7ZB+y5HqUZtLmalZ+9uv9vwwvdDjCgFIh0St4lXpBT1zYNPsjkVQjPsAqwfX6YiBVhTWsWIiUSujor2WfUVIpldUuMPRjTgir9Lrp1OP2y7IPEiHEFi8qHS9FcsVXEbXlRktt3CxUdQeRTD9ZKcTos89IUvlbJe3c+RSyryUpGC9e1B8rwY9kEbfJAT+Vnsk3pUv14gPiHNY7Q4O/ScyY6ix+ETQ99orb5lb8gXarQY2647S/jkHaIlb+4xB+IQj/bKhl0KAT3F+SsQcw5JhgJz/APUuE3kUJfJC2ierhzVSJgqmW+O2RkDPwk3uRvSYmxKvB/VgBJ2SMo56gc41VO7fp+CEPTyQre+NcACtSId4sRROWRKI85dBi/wUbjuIx3nIjJ1JM5S9j8crYPYDNCucW6zgpQ/YSBR81XsdOkxucMoQKuKBnxXL1Je79jeaUoK0pfyjMvIwHsMtrLciBUXPzt13xHOlw9pTrsfeHtw8E6nCJLqvPmo5zUMX6+oz/YC0nGCvp7GF3ASGWP/Nz6sWgUhBX2z3WyBaZMdVfaxGYfDSsWODBC8n/wNgOuIajZmjXo3QkRF6me83iDnGJwDBCWNFw+/4su6bbYvwg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXUxdDRhbmZhU256VHBoVHE3SW1qbHBIUUdVaXYwTExaK0ZqYlk2Y1pMSVdr?=
 =?utf-8?B?eWhZbGt1RHFPUFNjOFV6VGV6SkU0MnhNMWxONzhKZEo5RmJELzR0Z3Zya0R5?=
 =?utf-8?B?YWZrOHFlZmlEdmFSU05sNElwZ1BRWTM0YjE0VlVGSWZVdmpDTDFLYmxydkMv?=
 =?utf-8?B?QnRtSGpzYVZwNXpBeDlBVGlNb0RucTVFYWVhWG1jVnBMUWRSUGdZdS94SXhq?=
 =?utf-8?B?c1VqY0I3a3hOdC8yOWhWdGVTTmVjcDJjLzhIQWVXak9HZFVzRVFEN205dnZH?=
 =?utf-8?B?YTlzY094TnpvcE5LSHZ4dzZaOGR5UjVPajVWV2x1Wk5NVkg2Q3VtVnJocVJ4?=
 =?utf-8?B?N0s1bkk2dG1ESHN6VGRSeWZLMHlMSUdJUmhOZk12K1V0Rlo3Zi9DdWtqQUxp?=
 =?utf-8?B?Mk1wbTEybldLYUltckZqdWVtZG9iVDZaQmcxUlVkRHByZ0N5UTFFSnFieDhk?=
 =?utf-8?B?S1hja1RUWkNsbUw1TWxoTXVaMkRxTXM2bkZwU0swZmQ5OHhuRmFIaFZsT1dK?=
 =?utf-8?B?bEVLcm9VdStmZGlIY213QTRlY1c5aXFjQjhpUEtzcUxJYWdkcVNHL3ByWWE2?=
 =?utf-8?B?dTZ2RmNqRGVnajc2clBjRHR1SGE4OGlWNGtJcUMyM0huUU9KVzBWVnFmTzdj?=
 =?utf-8?B?QktENkQ4K2crRUJialRVSndvTnJJTFd5a1ZvaWdOWUkvbXByemFZTVBReHdF?=
 =?utf-8?B?WWg0bTRUeWwydVhmZFlqNzVDV3YvRFZqZEhraDNIZ2k5V0JUZXd0d2JuSmhw?=
 =?utf-8?B?bkRjY3p1NE5NdmV5blJBMXlSNlZMOEkxcHNnUHYyN1VBTlpUL0NrQ3hsYjlN?=
 =?utf-8?B?U3VkR0VMUU1wNDMrbGt0QWpGVFhBR2Q5RDBsSFFGOWlrcFZsY0o5anpwcWFu?=
 =?utf-8?B?bHRuNTJNbXh1VXVVTFRRbk8wODdqeDQ0c0Z3VXpaV0RnL3k3cDQ2UFd2Si9n?=
 =?utf-8?B?YTV1OHZ6OEtOM2NGZjQ3d1JueHFUY3MzZXNDcnNjbnJ3a09hMFdnYVB5K3Yx?=
 =?utf-8?B?WUFockJxQ3I4U2E4aFhWNWN5TS83VzFoWXUrUnFtR0pscFlNVWZWVVBwMkMw?=
 =?utf-8?B?WkoySFpBblB3V1g1UHZPOEw5MmVkOXAzTnMrNTZwVDliVTh4ZWZxemlNa2dl?=
 =?utf-8?B?a0Q2RTNGeWlQMjJNcnBFTHpSWHh6d3RCM0FqRGlaTjBNYzRRMTVEUFZIQjlK?=
 =?utf-8?B?T2YwMUVkc1RqeHJRR3hLSkc0VVdaUFB0dGFsa1lnWitBdS9PdFcxUDNvTHJa?=
 =?utf-8?B?dU9TN2ZCdUIvQ2FtMjFJejA3bnpqQ0xtV2FOUEdXWUNxczVValRxVWhMTmF2?=
 =?utf-8?B?V3JUemJRL0lvQlh3Q3FETUw1RTNWYTB1M2ZwTTR5cmRDRVpOd3I2eFFHVm9J?=
 =?utf-8?B?WktDaTBad0lrV0tDc2xQQkMrVC9XZFNUbVNHbXNlNGhZaWtucEhrb0tpZE1U?=
 =?utf-8?B?Zm9IancvRjhSRWxmZmVjU1JaZnRXWmtkWk5TZUJxQVdDK3JhS1REanVqZ1NT?=
 =?utf-8?B?UmZBU3ZTNVd1M0hyemFNMnJENUwwWFFKWlcvQ09SenlacTczcUY0ZHlQcm9M?=
 =?utf-8?B?TU5KZUViSUdXZ1VZN2pTdW1pK2h3WFBNNi9OSXhIdEh1bXBLVm5iUFBjOXZz?=
 =?utf-8?B?QU5IRXZ3T1VsYWV6VGRIZGlUUXpJdFF6YmJBV2owbzkxbGJpdCtEai9TTlJK?=
 =?utf-8?B?N0RTY1dYMUZsVU1ZNWVLYlA2TVoyQ3BuczVMVDFrMFZVeUNWMXRQc1Y5dWFR?=
 =?utf-8?B?SU04VXl4MVJvR1FUS1AwNXgrekFIY2dXMW9NMmZMWGs0R0poSjl5MmFQd1Mx?=
 =?utf-8?B?MERXVVkwZjlvR2dlUkhCSWxNN3hZVlYyK3lWOHBNMm9LYWc4WFVHbXg4eTlZ?=
 =?utf-8?B?UkllWkwrMjg0Vm5xLy9CQ1BCY1gxNzZ6N3hRQ2hDRm9UaWxmeUZDMWJObDlj?=
 =?utf-8?B?d1N2TFFtM3Q2NTViTml6cm5xZ2gwSFlTYWFJbTNGK2RXWElIT3VML0tSZk53?=
 =?utf-8?B?VDRraVN2MTJYM01SYm5RdzJyS1ZzR3dka2RKK0lVMk9pVklSQ2h5NlZaUmlR?=
 =?utf-8?B?U2xjT2orQytJRUltYk1JbUFTeGxJOU9vS1JWaHRJMGlXTGgzUzdNeWxoSndM?=
 =?utf-8?B?aTcycVE5cU5LbFMyWlJtbnd3UGQ5bEVVVVFmazMvOEpOcGJQZEwvNXRROUg5?=
 =?utf-8?B?dGJ1N29idVB6VGZQQTlOemlGdFR6blRKdDd5bE93ZjBnbG13eGJSODRUZkVt?=
 =?utf-8?B?SysrdnhIckZrMXp3RTIxa2JvT3dRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <100953887413714CB6D2B65C0785EF8A@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2c2167-4ff6-4c34-88e1-08dc41e6ba11
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 16:17:19.9217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6I9snxma0i2kP+09uykVyawYs8u4VBzR1f7Y3E3oopxKUyMa3sN1KOQmOLtefOQVM3Bi/OCJfeyLrJDFbZLKlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5989

T24gTW9uLCAyMDI0LTAzLTExIGF0IDExOjExIC0wNDAwLCBKb3NlZiBCYWNpayB3cm90ZToNCj4g
V2UndmUgYmVlbiBzZWVpbmcgdGhlIGZvbGxvd2luZyBwYW5pYyBpbiBwcm9kdWN0aW9uDQo+IA0K
PiBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAw
MDAwMDAwNjUNCj4gUEdEIDJmNDg1ZjA2NyBQNEQgMmY0ODVmMDY3IFBVRCAyY2M1ZDgwNjcgUE1E
IDANCj4gUklQOiAwMDEwOmZmX2xheW91dF9jYW5jZWxfaW8rMHgzYS8weDkwIFtuZnNfbGF5b3V0
X2ZsZXhmaWxlc10NCj4gQ2FsbCBUcmFjZToNCj4gwqA8VEFTSz4NCj4gwqA/IF9fZGllKzB4Nzgv
MHhjMA0KPiDCoD8gcGFnZV9mYXVsdF9vb3BzKzB4Mjg2LzB4MzgwDQo+IMKgPyBfX3JwY19leGVj
dXRlKzB4MmMzLzB4NDcwIFtzdW5ycGNdDQo+IMKgPyBycGNfbmV3X3Rhc2srMHg0Mi8weDFjMCBb
c3VucnBjXQ0KPiDCoD8gZXhjX3BhZ2VfZmF1bHQrMHg1ZC8weDExMA0KPiDCoD8gYXNtX2V4Y19w
YWdlX2ZhdWx0KzB4MjIvMHgzMA0KPiDCoD8gZmZfbGF5b3V0X2ZyZWVfbGF5b3V0cmV0dXJuKzB4
MTEwLzB4MTEwIFtuZnNfbGF5b3V0X2ZsZXhmaWxlc10NCj4gwqA/IGZmX2xheW91dF9jYW5jZWxf
aW8rMHgzYS8weDkwIFtuZnNfbGF5b3V0X2ZsZXhmaWxlc10NCj4gwqA/IGZmX2xheW91dF9jYW5j
ZWxfaW8rMHg2Zi8weDkwIFtuZnNfbGF5b3V0X2ZsZXhmaWxlc10NCj4gwqBwbmZzX21hcmtfbWF0
Y2hpbmdfbHNlZ3NfcmV0dXJuKzB4MWIwLzB4MzYwIFtuZnN2NF0NCj4gwqBwbmZzX2Vycm9yX21h
cmtfbGF5b3V0X2Zvcl9yZXR1cm4rMHg5ZS8weDExMCBbbmZzdjRdDQo+IMKgPyBmZl9sYXlvdXRf
c2VuZF9sYXlvdXRlcnJvcisweDUwLzB4MTYwIFtuZnNfbGF5b3V0X2ZsZXhmaWxlc10NCj4gwqBu
ZnM0X2ZmX2xheW91dF9wcmVwYXJlX2RzKzB4MTFmLzB4MjkwIFtuZnNfbGF5b3V0X2ZsZXhmaWxl
c10NCj4gwqBmZl9sYXlvdXRfcGdfaW5pdF93cml0ZSsweGYwLzB4MWYwIFtuZnNfbGF5b3V0X2Zs
ZXhmaWxlc10NCj4gwqBfX25mc19wYWdlaW9fYWRkX3JlcXVlc3QrMHgxNTQvMHg2YzAgW25mc10N
Cj4gwqBuZnNfcGFnZWlvX2FkZF9yZXF1ZXN0KzB4MjZiLzB4MzgwIFtuZnNdDQo+IMKgbmZzX2Rv
X3dyaXRlcGFnZSsweDExMS8weDFlMCBbbmZzXQ0KPiDCoG5mc193cml0ZXBhZ2VzX2NhbGxiYWNr
KzB4Zi8weDMwIFtuZnNdDQo+IMKgd3JpdGVfY2FjaGVfcGFnZXMrMHgxN2YvMHgzODANCj4gwqA/
IG5mc19wYWdlaW9faW5pdF93cml0ZSsweDUwLzB4NTAgW25mc10NCj4gwqA/IG5mc193cml0ZXBh
Z2VzKzB4NmQvMHgyMTAgW25mc10NCj4gwqA/IG5mc193cml0ZXBhZ2VzKzB4NmQvMHgyMTAgW25m
c10NCj4gwqBuZnNfd3JpdGVwYWdlcysweDEyNS8weDIxMCBbbmZzXQ0KPiDCoGRvX3dyaXRlcGFn
ZXMrMHg2Ny8weDIyMA0KPiDCoD8gZ2VuZXJpY19wZXJmb3JtX3dyaXRlKzB4MTRiLzB4MjEwDQo+
IMKgZmlsZW1hcF9mZGF0YXdyaXRlX3diYysweDViLzB4ODANCj4gwqBmaWxlX3dyaXRlX2FuZF93
YWl0X3JhbmdlKzB4NmQvMHhjMA0KPiDCoG5mc19maWxlX2ZzeW5jKzB4ODEvMHgxNzAgW25mc10N
Cj4gwqA/IG5mc19maWxlX21tYXArMHg2MC8weDYwIFtuZnNdDQo+IMKgX194NjRfc3lzX2ZzeW5j
KzB4NTMvMHg5MA0KPiDCoGRvX3N5c2NhbGxfNjQrMHgzZC8weDkwDQo+IMKgZW50cnlfU1lTQ0FM
TF82NF9hZnRlcl9od2ZyYW1lKzB4NDYvMHhiMA0KPiANCj4gSW5zcGVjdGluZyB0aGUgY29yZSB3
aXRoIGRyZ24gSSB3YXMgYWJsZSB0byBwdWxsIHRoaXMNCj4gDQo+IMKgID4+PiBwcm9nLmNyYXNo
ZWRfdGhyZWFkKCkuc3RhY2tfdHJhY2UoKVswXQ0KPiDCoCAjMCBhdCAweGZmZmZmZmZmYTA3OTY1
N2EgKGZmX2xheW91dF9jYW5jZWxfaW8rMHgzYS8weDg0KSBpbg0KPiBmZl9sYXlvdXRfY2FuY2Vs
X2lvIGF0IGZzL25mcy9mbGV4ZmlsZWxheW91dC9mbGV4ZmlsZWxheW91dC5jOjIwMjE6MjcNCj4g
wqAgPj4+IHByb2cuY3Jhc2hlZF90aHJlYWQoKS5zdGFja190cmFjZSgpWzBdWydpZHgnXQ0KPiDC
oCAodTMyKTENCj4gwqAgPj4+DQo+IHByb2cuY3Jhc2hlZF90aHJlYWQoKS5zdGFja190cmFjZSgp
WzBdWydmbHNlZyddLm1pcnJvcl9hcnJheVsxXS5taXJybw0KPiByX2RzDQo+IMKgIChzdHJ1Y3Qg
bmZzNF9mZl9sYXlvdXRfZHMgKikweGZmZmZmZmZmZmZmZmZmZWQNCj4gDQo+IFRoaXMgaXMgY2xl
YXIgZnJvbSB0aGUgc3RhY2sgdHJhY2UsIHdlIGNhbGwNCj4gbmZzNF9mZl9sYXlvdXRfcHJlcGFy
ZV9kcygpDQo+IHdoaWNoIGNvdWxkIGVycm9yIG91dCBpbml0aWFsaXppbmcgdGhlIG1pcnJvcl9k
cywgYW5kIHRoZW4gd2UgZ28gdG8NCj4gY2xlYW4gaXQgYWxsIHVwIGFuZCBvdXIgY2hlY2sgaXMg
b25seSBmb3IgaWYgKCFtaXJyb3ItPm1pcnJvcl9kcykuwqANCj4gVGhpcw0KPiBpcyBpbmNvbnNp
c3RlbnQgd2l0aCB0aGUgcmVzdCBvZiB0aGUgdXNlcnMgb2YgbWlycm9yX2RzLCB3aGljaCBoYXZl
DQo+IA0KPiDCoCBpZiAoSVNfRVJSX09SX05VTEwobWlycm9yX2RzKSkNCj4gDQo+IHRvIGtlZXAg
ZnJvbSB0cmlwcGluZyBvdmVyIHRoaXMgZXhhY3Qgc2NlbmFyaW8uwqAgRml4IHRoaXMgdXAgaW4N
Cj4gZmZfbGF5b3V0X2NhbmNlbF9pbygpIHRvIG1ha2Ugc3VyZSB3ZSBkb24ndCBwYW5pYyB3aGVu
IHdlIGdldCBhbg0KPiBlcnJvci4NCj4gSSBhbHNvIHNwb3QgY2hlY2tlZCBhbGwgdGhlIG90aGVy
IGluc3RhbmNlcyBvZiBjaGVja2luZyBtaXJyb3JfZHMgYW5kDQo+IHdlDQo+IGFwcGVhciB0byBi
ZSBkb2luZyB0aGUgY29ycmVjdCBjaGVja3MgZXZlcnl3aGVyZSwgb25seQ0KPiB1bmNvbmRpdGlv
bmFsbHkNCj4gZGVyZWZlcmVuY2luZyBtaXJyb3JfZHMgd2hlbiB3ZSBrbm93IGl0IHdvdWxkIGJl
IHZhbGlkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9zZWYgQmFjaWsgPGpvc2VmQHRveGljcGFu
ZGEuY29tPg0KPiAtLS0NCj4gdjEtPnYyOg0KPiAtIE15IGJhZCwgSSBtaXNzZWQgdGhlIGZvcm1h
dHRpbmcgb2YgdGhlIGRyZ24gb3V0cHV0IGFuZCBpdCBsb29rZWQNCj4gbWFuZ2xlZC4NCj4gDQo+
IMKgZnMvbmZzL2ZsZXhmaWxlbGF5b3V0L2ZsZXhmaWxlbGF5b3V0LmMgfCAyICstDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZnMvbmZzL2ZsZXhmaWxlbGF5b3V0L2ZsZXhmaWxlbGF5b3V0LmMNCj4gYi9mcy9uZnMv
ZmxleGZpbGVsYXlvdXQvZmxleGZpbGVsYXlvdXQuYw0KPiBpbmRleCBlZjgxN2EwNDc1ZmYuLjNl
NzI0Y2I3ZWYwMSAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL2ZsZXhmaWxlbGF5b3V0L2ZsZXhmaWxl
bGF5b3V0LmMNCj4gKysrIGIvZnMvbmZzL2ZsZXhmaWxlbGF5b3V0L2ZsZXhmaWxlbGF5b3V0LmMN
Cj4gQEAgLTIwMTYsNyArMjAxNiw3IEBAIHN0YXRpYyB2b2lkIGZmX2xheW91dF9jYW5jZWxfaW8o
c3RydWN0DQo+IHBuZnNfbGF5b3V0X3NlZ21lbnQgKmxzZWcpDQo+IMKgCWZvciAoaWR4ID0gMDsg
aWR4IDwgZmxzZWctPm1pcnJvcl9hcnJheV9jbnQ7IGlkeCsrKSB7DQo+IMKgCQltaXJyb3IgPSBm
bHNlZy0+bWlycm9yX2FycmF5W2lkeF07DQo+IMKgCQltaXJyb3JfZHMgPSBtaXJyb3ItPm1pcnJv
cl9kczsNCj4gLQkJaWYgKCFtaXJyb3JfZHMpDQo+ICsJCWlmIChJU19FUlJfT1JfTlVMTChtaXJy
b3JfZHMpKQ0KPiDCoAkJCWNvbnRpbnVlOw0KPiDCoAkJZHMgPSBtaXJyb3ItPm1pcnJvcl9kcy0+
ZHM7DQo+IMKgCQlpZiAoIWRzKQ0KDQpUaGF0IGlzIHRydWx5IHdlaXJkLi4uIEkgaGF2ZSB0aGUg
YWJvdmUgY29ycmVjdCBpbiB0aGUgb3JpZ2luYWwgcGF0Y2gsDQp3aGljaCBpcyBzdGlsbCBpbiB0
aGUgSGFtbWVyc3BhY2UgcmVwby4gSG93ZXZlciB0aGUgcG9ydCB0byB1cHN0cmVhbQ0KYXBwZWFy
cyB0byBoYXZlIGludHJvZHVjZWQgdGhlIGJ1Zy4NCg0KVGhhbmtzIHNvIG11Y2ggZm9yIGNhdGNo
aW5nIHRoaXMsIEpvc2VmIQ0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==

