Return-Path: <linux-nfs+bounces-2409-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EAE880717
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 23:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440EF1F229C1
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 22:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C00E57880;
	Tue, 19 Mar 2024 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Rhj+mt5s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2097.outbound.protection.outlook.com [40.107.94.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C028A4F200
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885594; cv=fail; b=LupRU5lvFd7vl5c6yfTdn/vuute2fkePG0+hs1IlJuNng9t+n5gBCEcrSy9DZFnSZMjhPOccUxy3KzV0nNmvyTfsPaJTQJ9dYnO8YBkH9ovb5vYncOTmwe5AJVFsu817QAy6qB7F77EnhuChNo6bMDF72h7ig+/YcdiuQNFEq+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885594; c=relaxed/simple;
	bh=AyC9yM0hmJ6IGPkhH1Cy7VqJlwsHaL1lw19zBTDgfLU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mf+PPTbny34ZGt+D6VTSTnqcv07MenXSKjiHGWQpqC5z9o/TiPnbqa1iVJ/wJSr2j/dSp54BgPtPCQ0En3c2hilDig6ZqX3dXonUoGCh5jqDo6JzHRmtQ96GbOqk9zj08FeYlft3JibZVwnqXud4V2rsCsTbEQSWyye9bWv1qEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Rhj+mt5s; arc=fail smtp.client-ip=40.107.94.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6T1CmO/etxJ3bLGA/s2jMJGM/c0X80RwopTx6K78nWfMKGtFDtuOCn9510ELOJGYbQ2LX5cPAGyQUalg72SShh81ocXhDJde2WwBn6wDoFWR8SEKbYO4RzkvM/EhS5y7ETIkrBDTOlqZELP+Y75fQmaAFgQxpaC/czVId3B5/nI/uKfDtWJn+HeEOhd8gajSZ/dDBdAoC1nkRG/YppEkw4t46OkHbZM2VJ+MOqvCtjYlnvNEuYwHQI7KL98CHDo4EUFxPC4Pc7hxR+tKW3L051ficCtMqNctwXf5xoc/sMMYNO9S6NllpR0mWsD4JELGyLjkKPnjVM1vIHqsBK+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyC9yM0hmJ6IGPkhH1Cy7VqJlwsHaL1lw19zBTDgfLU=;
 b=FW55ubGmL9F538U8Q58/936bjk2x6aTp7RispbJ8Iw3OX8Do9nT8jQIGUoGh4N4ZcRR1MSspc5Xj+LLhpb/UKuel3C0nenEgDzoEpIV/5BJwsaPlERFxpxaW1zPZxXhtqC6YoRIXthoPzK7hitAhjvQ/c4svyns9rkyL8JV/HwSndKmtuVSAQCbfq/DvMC6/pa/jeFI0zRNDTCBX4hqKmTqOHZbvcdboTmcsIS0WNwxj/sKr4HOB4xt3HoM6a8dAxMBvorSSrUpeN/qifZyRab8/G/m0mu2Htw7En1biT3fWl7mMHUCvhWu2lYvM62cqwd04eLyRf7+h52l8yN0xKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyC9yM0hmJ6IGPkhH1Cy7VqJlwsHaL1lw19zBTDgfLU=;
 b=Rhj+mt5sel07ZoKErUMaiNskwZsEcsCWJcKzxKoVsSo3WrvXiQsUko0Rmyl3dd5cvEqW1KuQ02CJSiwZwvN90yIVqUD6cJ/f5Rk0+xsdxZ0CEFWOvnFrtyUNqKc+wQgnORFXm7vkHUDr+jX0elgHq0J7rrAXbS+wL0WofDw0fzA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SA1PR13MB5053.namprd13.prod.outlook.com (2603:10b6:806:1aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 21:59:49 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 21:59:49 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "kernel-team@fb.com"
	<kernel-team@fb.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>
Subject: Re: [PATCH][RESEND] sunrpc: hold a ref on netns for tcp sockets
Thread-Topic: [PATCH][RESEND] sunrpc: hold a ref on netns for tcp sockets
Thread-Index: AQHaekjCUG/cd2FObU27nDRAqwBy9Q==
Date: Tue, 19 Mar 2024 21:59:48 +0000
Message-ID: <caa3af93b31b554f0c1e643320041835f0bfe044.camel@hammerspace.com>
References:
 <512efbd56ad3679068759586c6fa9b681aec14f0.1710877783.git.josef@toxicpanda.com>
In-Reply-To:
 <512efbd56ad3679068759586c6fa9b681aec14f0.1710877783.git.josef@toxicpanda.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SA1PR13MB5053:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ppb1LJTn8A0hSfindlXG2HGfUs+kPOzGcVyIm6nKazKMpB/MNJso8Oo1Mtn6sabvDiSM5O6O0SiM0hSfJfEHZlNlzukkQJczpbGs2qzAJEEvW7IV583lhF75mdnAWtc69OpZFXzYMI7f8IFNwUEql5jFW3Y5/QX2xiNQfv9m6uc5QX70iXfUR/IdYaL2xzoNOKm75tK4z2Pm3nXaalStmhx8dnosfAJaNDEVgT1wa3Ovt8SHq1JGjtgNpsm7hXdRQty5WaCvqsnYSbe/ePGDOLWciOdMAQ0HO3oPObBzB8A4MVqV4TxV9qCSvWmxAy8eJ7DQpFur8TxK9C5Uu5rRfGP4XMQKr43Qo8VuPWBwwNWHYBlnN0HL90hbKyBdZenwH2Sel4gg2Qup6MyXOr7e88ROibO+t8ALEPH6MW1+FAu/iOd+t/26YH6yPyX4Ac3tBnsh+Rf9SVhTIYUvbcBKiPENY07YP1DTXw4VlbMq5WkBwOXgdikALMwioqJqBFxMIVU2nqdUy7QlID0V7aoq4O1kcLA6vEh1uV2/3WFPrDuaTJE+w316xpa+feWzI4OhgWe6WfeVPxmHjEVZA+oYLFykmVbW3/u/ylcogMdPxGzc/jBA9dW+6iCCDC56Mj2Oyoxf5YjNND4xvGZykgrTK/L54wGY4YXN2OYc8bipWv0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkFPTmFWb25FNmNSaWlHNjZNOUJMeDVHaGZGbE5EYW9Gam5NcDZZOExGTUpG?=
 =?utf-8?B?RUh2dWhDOWptV2F4QWZzRTQ4dGk3VU9zNXRqYjFxUzV2SGxWNE9YSFIvaVZ3?=
 =?utf-8?B?cHpoMHE4QWhzK1lxZGZucHVBYllMRk0xdmRjTW84ZkdpaDBxOStFUjQzeTlW?=
 =?utf-8?B?SVJnVzR4OEE1QlZsa0dYdUhuQ1IyY3FvV1YyclhOUmxFRUxrUm5IWmhYTXFQ?=
 =?utf-8?B?dEJVdXRxalcvenQwanZDM0ZpNGVLMm1UOG1rUDJlUEdobWV2eDVSQ0lWcmRi?=
 =?utf-8?B?ZE92UW9QTFljc25jMk40M2Z3VTR4RDc4Tm9NZUJxVlFIYUROZzZOcVJ5dVA1?=
 =?utf-8?B?dldpRmowZVhGZGlhMlBVYW8wV2dBVmtOVXNtSHdOS2tkUkNPMXliMVBSSUJX?=
 =?utf-8?B?SGZ5YkNobzQyVEcxUFpybFkrZ0d4aHVYMEZLWktNZ2Y4aHJmcEN1WjhZRXZD?=
 =?utf-8?B?WGFndjlEZWJneGZ6ZjBCRWEybkx1QjNnYlVTaWY1UCtuLyt1ajhCVEFhcVJ1?=
 =?utf-8?B?SW9xem5RQWtjVXRnRndONWdwaXZPNFUzUGlIRFd6N2h3aTFWUGNIYXRyWjgr?=
 =?utf-8?B?dXZGZFV3UFVnd2Y1NnJYOUFXeTBiTVhzTk5ZVGNiNUF6ZC9pOWFBcmtpWUJm?=
 =?utf-8?B?b2d5dXhBQ09TYXk0ZUN3WExGVDJPZGVINVJPYjFPWi9ZUkl6RkFBZE1HS2xB?=
 =?utf-8?B?bm1adXNVNnN4MURGdXdyQnROWjRNSnVySm1xekRJVTJRellRZFRjcDdjVENt?=
 =?utf-8?B?clpRdUpXckxXZnhxUHl0dmRwSmVjdTBCT2FuM25yUEt3dmN2dnZ6V21aYUY2?=
 =?utf-8?B?T1QydDJxYnJzdTRkYmJyNm9sajRIUjFpc2cwOVNFaHdNRzlTMzRaSnlrMVF3?=
 =?utf-8?B?Y1pFWWJvM1Bubm1jMWtQbk9PWDZDQ2RyUURJRjd3K3RVNUxOSk5Xa2JlbUhi?=
 =?utf-8?B?STJzd2RZb3VjMEhrT1VjbVZBSWVyWDVsUlAyc0ZVMkFVVmdUbnl3ai9FclVl?=
 =?utf-8?B?bmJmMmFPWTRTMHVPMmxpaHdWUEtIdVVRek5WWVJFRDhHcDUvdFlrSnE2NENO?=
 =?utf-8?B?SU52cDVjT2FydDBVaVFidXhmMVFrU1MvSWVWa2FKNTBBQzFzU2psU0haYXJQ?=
 =?utf-8?B?Mm5ZMnJETlRDY2tFYzhxL1JXelVVTmRpajVEQkZ0NVV2bXI5bjhhbjI3VGJj?=
 =?utf-8?B?bVk0TXJWNkRWTXVmdXVOTm1RaWRGZXlNaWFITUl1Vll5VG1HcnNYbFU3anV4?=
 =?utf-8?B?TVpUUVlLL0x0enR0a1RaR3N1S0ZDU0JvR3dMS0xPdDNremdQQlF3cjI0aVBV?=
 =?utf-8?B?Q3ZtVkZrbVdzdTNVeWNIZkVvdkxYU1ZrM1ZMR004OHNTTExadmJ3ZFRMQUw3?=
 =?utf-8?B?NXNLK2VyNEdOMUR2dkIxWUxpaWtYZWVSTStHNFUyb0RqY3dWUWFHWmJjbUE3?=
 =?utf-8?B?RU1wVy81aDZXZ09wYVVCTnlvazQrRDY0dERMVTI3OFNPWncxUVZSNzlwMG5X?=
 =?utf-8?B?SXNoWHo0dE1IMTNhNWE0dElxZk1EeGI1NzRBMXFkVUh3L3JLVmprSUNHOWxE?=
 =?utf-8?B?VmRSQUlmR2lUQkVabG1MRGttWnZIZElUNUJDK1VTZjdCVWQrTGN2NDV2cWJo?=
 =?utf-8?B?MjlrQnBsSktZQ1RCakVodWl0NDBSZEhaaDNkMFNEK2NnK202bnlLd1FKZFE5?=
 =?utf-8?B?T3A0M2Rwa3dUdGdURkdISmM3M0Zxc2t2cmhCcU9WYWY0UU94a1V1dzJoVFRU?=
 =?utf-8?B?cExRTFFsM1NTS2t5SWdMTVhlSHZ1bUlldkxVWG85ZlJiREN3ME1LajkyR3ZK?=
 =?utf-8?B?dnhVN0NOY1NOZXFLNDdMRTlONEY1N2RwdnI1c0FlV0UrWUEraFJCbEVTeERW?=
 =?utf-8?B?SGZ1SGo3UjgrelU0L25Ra3ppZ0JvUjlKZWpUZDJUa09HT3JvcGt6UUhTeG90?=
 =?utf-8?B?ZVFEQ3lpTi9WTHFDb1NyUURMblU3cFRxdWE0bU5OUTc0ZUNWYW1DTS83SU9E?=
 =?utf-8?B?OWdNa2N1KzJDckhqc0lVaEg1RGVOSzlyRmppMk9zVWdpUkhnSEpxbS9YZkxD?=
 =?utf-8?B?aWVPTXJTTnBMbU5kTGduTis2SjliWXlxRXE0T2VqT3V6Um1SODd2MHZqUGxh?=
 =?utf-8?B?SVdpV3JWZ2o0MmtIeVd3WkdqYmh5aktuZTV0MWdOMEtFYW5SRUNHcU1KZmxY?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D10FF3B69B710546A5F40F13A0EF9236@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d167b828-0958-41b0-39c4-08dc485fe57a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 21:59:48.8641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfzbxM8wEhmuaRGc+BJ9CL2r5B95DVHRLSIGlV0Q8NNL9ZikSDtdh7uzL3boHdcO2pf4xSn1V5MuptV7V/HvSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5053

T24gVHVlLCAyMDI0LTAzLTE5IGF0IDE2OjA3IC0wNDAwLCBKb3NlZiBCYWNpayB3cm90ZToNCj4g
V2UndmUgYmVlbiBzZWVpbmcgdmFyaWF0aW9ucyBvZiB0aGUgZm9sbG93aW5nIHBhbmljIGluIHBy
b2R1Y3Rpb24NCj4gDQo+IMKgIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwg
YWRkcmVzczogMDAwMDAwMDAwMDAwMDAwMA0KPiDCoCBSSVA6IDAwMTA6aXA2X3BvbF9yb3V0ZSsw
eDU5LzB4N2EwDQo+IMKgIENhbGwgVHJhY2U6DQo+IMKgwqAgPElSUT4NCj4gwqDCoCA/IF9fZGll
KzB4NzgvMHhjMA0KPiDCoMKgID8gcGFnZV9mYXVsdF9vb3BzKzB4Mjg2LzB4MzgwDQo+IMKgwqAg
PyBmaWI2X3RhYmxlX2xvb2t1cCsweDk1LzB4ZjQwDQo+IMKgwqAgPyBleGNfcGFnZV9mYXVsdCsw
eDVkLzB4MTEwDQo+IMKgwqAgPyBhc21fZXhjX3BhZ2VfZmF1bHQrMHgyMi8weDMwDQo+IMKgwqAg
PyBpcDZfcG9sX3JvdXRlKzB4NTkvMHg3YTANCj4gwqDCoCA/IHVubGlua19hbm9uX3ZtYXMrMHgz
NzAvMHgzNzANCj4gwqDCoCBmaWI2X3J1bGVfbG9va3VwKzB4NTYvMHgxYjANCj4gwqDCoCA/IHVw
ZGF0ZV9ibG9ja2VkX2F2ZXJhZ2VzKzB4MmM2LzB4NmEwDQo+IMKgwqAgaXA2X3JvdXRlX291dHB1
dF9mbGFncysweGQyLzB4MTMwDQo+IMKgwqAgaXA2X2RzdF9sb29rdXBfdGFpbCsweDNiLzB4MjIw
DQo+IMKgwqAgaXA2X2RzdF9sb29rdXBfZmxvdysweDJjLzB4ODANCj4gwqDCoCBpbmV0Nl9za19y
ZWJ1aWxkX2hlYWRlcisweDE0Yy8weDFlMA0KPiDCoMKgID8gdGNwX3JlbGVhc2VfY2IrMHgxNTAv
MHgxNTANCj4gwqDCoCBfX3RjcF9yZXRyYW5zbWl0X3NrYisweDY4LzB4NmIwDQo+IMKgwqAgPyB0
Y3BfY3VycmVudF9tc3MrMHhjYS8weDE1MA0KPiDCoMKgID8gdGNwX3JlbGVhc2VfY2IrMHgxNTAv
MHgxNTANCj4gwqDCoCB0Y3Bfc2VuZF9sb3NzX3Byb2JlKzB4OGUvMHgyMjANCj4gwqDCoCB0Y3Bf
d3JpdGVfdGltZXIrMHhiZS8weDJkMA0KPiDCoMKgIHJ1bl90aW1lcl9zb2Z0aXJxKzB4MjcyLzB4
ODQwDQo+IMKgwqAgPyBocnRpbWVyX2ludGVycnVwdCsweDJjOS8weDVmMA0KPiDCoMKgID8gc2No
ZWRfY2xvY2tfY3B1KzB4Yy8weDE3MA0KPiDCoMKgIGlycV9leGl0X3JjdSsweDE3MS8weDMzMA0K
PiDCoMKgIHN5c3ZlY19hcGljX3RpbWVyX2ludGVycnVwdCsweDZkLzB4ODANCj4gwqDCoCA8L0lS
UT4NCj4gwqDCoCA8VEFTSz4NCj4gwqDCoCBhc21fc3lzdmVjX2FwaWNfdGltZXJfaW50ZXJydXB0
KzB4MTYvMHgyMA0KPiDCoCBSSVA6IDAwMTA6Y3B1aWRsZV9lbnRlcl9zdGF0ZSsweGU3LzB4MjQz
DQo+IA0KPiBJbnNwZWN0aW5nIHRoZSB2bWNvcmUgd2l0aCBkcmduIHlvdSBjYW4gc2VlIHdoeSB0
aGlzIGlzIGEgTlVMTA0KPiBwb2ludGVyIGRlcmVmDQo+IA0KPiDCoMKgwqAgPj4+IHByb2cuY3Jh
c2hlZF90aHJlYWQoKS5zdGFja190cmFjZSgpWzBdDQo+IMKgwqDCoCAjMCBhdCAweGZmZmZmZmZm
ODEwYmZhODkgKGlwNl9wb2xfcm91dGUrMHg1OS8weDc5NikgaW4NCj4gaXA2X3BvbF9yb3V0ZSBh
dCBuZXQvaXB2Ni9yb3V0ZS5jOjIyMTI6NDANCj4gDQo+IMKgwqDCoCAyMjEywqDCoMKgwqDCoMKg
wqAgaWYgKG5ldC0+aXB2Ni5kZXZjb25mX2FsbC0+Zm9yd2FyZGluZyA9PSAwKQ0KPiDCoMKgwqAg
MjIxM8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cmljdCB8PSBSVDZfTE9PS1VQX0ZfUkVB
Q0hBQkxFOw0KPiANCj4gwqDCoMKgID4+Pg0KPiBwcm9nLmNyYXNoZWRfdGhyZWFkKCkuc3RhY2tf
dHJhY2UoKVswXVsnbmV0J10uaXB2Ni5kZXZjb25mX2FsbA0KPiDCoMKgwqAgKHN0cnVjdCBpcHY2
X2RldmNvbmYgKikweDANCj4gDQo+IExvb2tpbmcgYXQgdGhlIHNvY2tldCB5b3UgY2FuIHNlZSB0
aGF0IGl0J3MgYmVlbiBjbG9zZWQNCj4gDQo+IMKgwqDCoCA+Pj4NCj4gZGVjb2RlX2VudW1fdHlw
ZV9mbGFncyhwcm9nLmNyYXNoZWRfdGhyZWFkKCkuc3RhY2tfdHJhY2UoKVsxMV1bJ3NrJ10uDQo+
IF9fc2tfY29tbW9uLnNrY19mbGFncywgcHJvZy50eXBlKCdlbnVtIHNvY2tfZmxhZ3MnKSkNCj4g
wqDCoMKgICdTT0NLX0RFQUR8U09DS19LRUVQT1BFTnxTT0NLX1pBUFBFRHxTT0NLX1VTRV9XUklU
RV9RVUVVRScNCj4gwqDCoMKgID4+PiBkZWNvZGVfZW51bV90eXBlX2ZsYWdzKDEgPDwNCj4gcHJv
Zy5jcmFzaGVkX3RocmVhZCgpLnN0YWNrX3RyYWNlKClbMTFdWydzayddLl9fc2tfY29tbW9uLnNr
Y19zdGF0ZS52DQo+IGFsdWVfKCksIHByb2dbIlRDUEZfQ0xPU0UiXS50eXBlXywgYml0X251bWJl
cnM9RmFsc2UpDQo+IMKgwqDCoCAnVENQRl9GSU5fV0FJVDEnDQo+IA0KPiBUaGlzIG9jY3VycyBp
biBvdXIgY29udGFpbmVyIHNldHVwIHdoZXJlIHdlIGhhdmUgYW4gTkZTIG1vdW50IHRoYXQNCj4g
YmVsb25ncyB0byB0aGUgY29udGFpbmVycyBuZXR3b3JrIG5hbWVzcGFjZS7CoCBPbiBjb250YWlu
ZXIgc2h1dGRvd24NCj4gb3VyDQo+IG5ldG5zIGdvZXMgYXdheSwgd2hpY2ggc2V0cyBuZXQtPmlw
djYuZGVmY29uZl9hbGwgPSBOVUxMLCBhbmQgdGhlbiB3ZQ0KPiBwYW5pYy7CoCBJbiB0aGUga2Vy
bmVsIHdlJ3JlIHJlc3BvbnNpYmxlIGZvciBkZXN0cm95aW5nIG91ciBzb2NrZXRzDQo+IHdoZW4N
Cj4gdGhlIG5ldHdvcmsgbmFtZXNwYWNlIGV4aXRzLCBvciBob2xkaW5nIGEgcmVmZXJlbmNlIG9u
IHRoZSBuZXR3b3JrDQo+IG5hbWVzcGFjZSBmb3Igb3VyIHNvY2tldHMgc28gdGhpcyBkb2Vzbid0
IGhhcHBlbi4NCj4gDQo+IEV2ZW4gb25jZSB3ZSBzaHV0ZG93biB0aGUgc29ja2V0IHdlIGNhbiBz
dGlsbCBoYXZlIFRDUCB0aW1lcnMgdGhhdA0KPiBmaXJlDQo+IGluIHRoZSBiYWNrZ3JvdW5kLCBo
ZW5jZSB0aGlzIHBhbmljLsKgIFNVTlJQQyBzaHV0cyBkb3duIHRoZSBzb2NrZXQNCj4gYW5kDQo+
IHRocm93cyBhd2F5IGFsbCBrbm93bGVkZ2Ugb2YgaXQsIGJ1dCBpdCdzIHN0aWxsIGRvaW5nIHRo
aW5ncyBpbiB0aGUNCj4gYmFja2dyb3VuZC4NCj4gDQo+IEZpeCB0aGlzIGJ5IGdyYWJiaW5nIGEg
cmVmZXJlbmNlIG9uIHRoZSBuZXR3b3JrIG5hbWVzcGFjZSBmb3IgYW55IHRjcA0KPiBzb2NrZXRz
IHdlIG9wZW4uwqAgV2l0aCB0aGlzIHBhdGNoIEknbSBhYmxlIHRvIGN5Y2xlIG15IDUwMCBub2Rl
DQo+IHN0cmVzcw0KPiB0aWVyIG92ZXIgYW5kIG92ZXIgYWdhaW4gd2l0aG91dCBwYW5pY2luZywg
d2hlcmVhcyBwcmV2aW91c2x5IEkgd2FzDQo+IGxvc2luZyAxMC0yMCBub2RlcyBldmVyeSBzaHV0
ZG93biBjeWNsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvc2VmIEJhY2lrIDxqb3NlZkB0b3hp
Y3BhbmRhLmNvbT4NCj4gLS0tDQo+IEFwb2xvZ2llcywgSSBqdXN0IGdyZXBwZWQgZm9yIFNVTlJQ
QyBpbiBNQUlOVEFJTkVSUyBhbmQgZGlkbid0DQo+IHJlYWxpemUgdGhlcmUgd2FzDQo+IGEgZGl2
aXNpb24gb2YgdGhlIGNsaWVudCBhbmQgc2VydmVyIHNpZGUgb2YgU1VOUlBDLg0KPiANCj4gwqBu
ZXQvc3VucnBjL3hwcnRzb2NrLmMgfCAyMCArKysrKysrKysrKysrKysrKysrKw0KPiDCoDEgZmls
ZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJw
Yy94cHJ0c29jay5jIGIvbmV0L3N1bnJwYy94cHJ0c29jay5jDQo+IGluZGV4IGJiODEwNTBjODcw
ZS4uZjAyMzg3NzUxYTk0IDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBjL3hwcnRzb2NrLmMNCj4g
KysrIGIvbmV0L3N1bnJwYy94cHJ0c29jay5jDQo+IEBAIC0yMzMzLDYgKzIzMzMsNyBAQCBzdGF0
aWMgaW50IHhzX3RjcF9maW5pc2hfY29ubmVjdGluZyhzdHJ1Y3QNCj4gcnBjX3hwcnQgKnhwcnQs
IHN0cnVjdCBzb2NrZXQgKnNvY2spDQo+IMKgDQo+IMKgCWlmICghdHJhbnNwb3J0LT5pbmV0KSB7
DQo+IMKgCQlzdHJ1Y3Qgc29jayAqc2sgPSBzb2NrLT5zazsNCj4gKwkJc3RydWN0IG5ldCAqbmV0
ID0gc29ja19uZXQoc2spOw0KPiDCoA0KPiDCoAkJLyogQXZvaWQgdGVtcG9yYXJ5IGFkZHJlc3Ms
IHRoZXkgYXJlIGJhZCBmb3IgbG9uZy0NCj4gbGl2ZWQNCj4gwqAJCSAqIGNvbm5lY3Rpb25zIHN1
Y2ggYXMgTkZTIG1vdW50cy4NCj4gQEAgLTIzNTAsNyArMjM1MSwyNiBAQCBzdGF0aWMgaW50IHhz
X3RjcF9maW5pc2hfY29ubmVjdGluZyhzdHJ1Y3QNCj4gcnBjX3hwcnQgKnhwcnQsIHN0cnVjdCBz
b2NrZXQgKnNvY2spDQo+IMKgCQl0Y3Bfc29ja19zZXRfbm9kZWxheShzayk7DQo+IMKgDQo+IMKg
CQlsb2NrX3NvY2soc2spOw0KPiArCQkvKg0KPiArCQkgKiBCZWNhdXNlIHRpbWVycyBjYW4gZmly
ZSBhZnRlciB0aGUgZmFjdCB3ZSBuZWVkIHRvDQo+IGhvbGQgYQ0KPiArCQkgKiByZWZlcmVuY2Ug
b24gdGhlIG5ldG5zIGZvciB0aGlzIHNvY2tldC4NCj4gKwkJICovDQo+ICsJCWlmICghc2stPnNr
X25ldF9yZWZjbnQpIHsNCj4gKwkJCWlmICghbWF5YmVfZ2V0X25ldChuZXQpKSB7DQo+ICsJCQnC
oMKgwqDCoMKgwqAgcmVsZWFzZV9zb2NrKHNrKTsNCj4gKwkJCcKgwqDCoMKgwqDCoCByZXR1cm4g
LUVOT1RDT05OOw0KPiArCQnCoMKgwqDCoMKgwqAgfQ0KPiArCQnCoMKgwqDCoMKgwqAgLyoNCj4g
KwkJCSogRm9yIGtlcm5lbCBzb2NrZXRzIHdlIGhhdmUgYSB0cmFja2VyIHB1dA0KPiBpbiBwbGFj
ZSBmb3INCj4gKwkJCSogdGhlIHRyYWNpbmcsIHdlIG5lZWQgdG8gZnJlZSB0aGlzIHRvDQo+IG1h
aW50YWluZQ0KPiArCQkJKiBjb25zaXN0ZW50IHRyYWNraW5nIGluZm8uDQo+ICsJCQkqLw0KPiAr
CQnCoMKgwqDCoMKgwqAgX19uZXRuc190cmFja2VyX2ZyZWUobmV0LCAmc2stPm5zX3RyYWNrZXIs
DQo+IGZhbHNlKTsNCj4gwqANCj4gKwkJwqDCoMKgwqDCoMKgIHNrLT5za19uZXRfcmVmY250ID0g
MTsNCj4gKwkJwqDCoMKgwqDCoMKgIG5ldG5zX3RyYWNrZXJfYWxsb2MobmV0LCAmc2stPm5zX3Ry
YWNrZXIsDQo+IEdGUF9LRVJORUwpOw0KPiArCQnCoMKgwqDCoMKgwqAgc29ja19pbnVzZV9hZGQo
bmV0LCAxKTsNCj4gKwkJfQ0KPiDCoAkJeHNfc2F2ZV9vbGRfY2FsbGJhY2tzKHRyYW5zcG9ydCwg
c2spOw0KPiDCoA0KPiDCoAkJc2stPnNrX3VzZXJfZGF0YSA9IHhwcnQ7DQoNCkhtbS4uLiBEb2Vz
bid0IHRoaXMgZW5kIHVwIGJlaW5nIG1vcmUgb3IgbGVzcyBlcXVpdmFsZW50IHRvIGNhbGxpbmcN
Cl9fc29ja19jcmVhdGUoKSB3aXRoIHRoZSBrZXJuZWwgZmxhZyBiZWluZyBzZXQgdG8gMD8NCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

