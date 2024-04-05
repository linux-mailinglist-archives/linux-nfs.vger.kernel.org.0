Return-Path: <linux-nfs+bounces-2672-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8619989A0A0
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 17:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1F71F244AB
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6E616F27B;
	Fri,  5 Apr 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="JDI/J06A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2137.outbound.protection.outlook.com [40.107.244.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41016EBED
	for <linux-nfs@vger.kernel.org>; Fri,  5 Apr 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329405; cv=fail; b=uR/B0xXq4qUNV6vnISEGTKAUaBmaBy5xyCAeqjefGYZRwVataIX6GkR7zUHYTYninY7ofuLlmHU1OzeEC6fYanvtpzea9JSqODaHwE/tCebMfMph0HXuspx1/IOymdKuHxHaDRrZA9dzcPfClDCRqhsAo9AIfDaZuXb2f1wLs3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329405; c=relaxed/simple;
	bh=jPaopT7RrSPs5vJCVzxRST1fHJ6Rv66KK8QmMt02Zpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SiJZdcPDcYq5KhDjv9muagpeZzn5pL5R2NO8eMYN4zbUArAk4T1OVAPUWSMoJj3FRqI1fmUSLz2d9ZmzBeYaec6K+Sf8FaLkNTz/iW4CYJVY/Pprh1O/Lljt1IPk/c3Uw10m0X6sIxnO9MrrpGrfGa411Scci6IkF9cOADOnbb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=JDI/J06A; arc=fail smtp.client-ip=40.107.244.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQiYP03kuvtH+42DYkOdA73Z58EvScwOfI3yc1zYFEClOIdkJ9fPWwiayru0M09ex1GC9F5jNllSjiQfyFLyMMSWkT3Jrj23dDbJtodCUNchRdytfqYG75HwB/IFHw+FaULj6tISX9OEDWjKHqN20+fXWnafUom9iAheHX6tzg9lEqunw5nHdR1OlM3y6+eOa6RQR6hL3nEyN20qzGY9mwEpEDQQ4okwWwJtk59sOHpacBwcap/WJj1DdAKHxlO1KjZiv9HqEygbT1oGo9EBgoDToTkQUX9Zb2ZLjQVkEUUaseK9gPrHtR3Ys41+FEhTpgsNvpasUh/pGbcZgnt2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPaopT7RrSPs5vJCVzxRST1fHJ6Rv66KK8QmMt02Zpk=;
 b=JtejT/Mv+yJfoMVW1btYntOL9hGfF95yPpQwSZ3Msm+rn30uf0n9M5ZsMqfgWwGcPXovVgO2sDw+piAF5YenEHFQ9v2a7PXArTp4U1FbrEVYsNTDvvMK3H7Y6NBvvVpfwB3xEgTASslVK0wXvEEBfk/xcuDLobukEDUye0H/AJYgw8zUbJ9anihlPVRAjw6OWNrla4wjRMp84bFf2EbXtrNlihWWy4oyhm3j8+SY/TDUb6PFgsMG96ND6mRz59HVnYUiqCnZxYXvEvV6LSZPIaq/A8cxRKQsT62+KTVi6Degk8JfBBhurATxI4UwsMrfJn7SXMB0I+uyy8ZRygxYow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPaopT7RrSPs5vJCVzxRST1fHJ6Rv66KK8QmMt02Zpk=;
 b=JDI/J06AMjjqqUrwqIt3KVlg9IxAR8xOcmkoR6V9fL2/Qv9kHatMiApnZDXJQx2qjChUFr0DhG+Mp/RehIN6m0cFoSm3hPjK1PxqQ5vZ302X0WJ8vsWWF9zyS5RyVkD6wdYqGeQlbsHQEH7BomZJfw/y42iuP7mSa5WnMXapc84=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB5104.namprd13.prod.outlook.com (2603:10b6:408:160::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 15:03:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 15:03:16 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "daire@dneg.com" <daire@dneg.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: directory caching & negative file lookups?
Thread-Topic: directory caching & negative file lookups?
Thread-Index: AQHYvgepinoQ18GCcUu67eOreR0vTa3KmPSAgAAZvoCAAAR6AIOSnVIlgAAENgA=
Date: Fri, 5 Apr 2024 15:03:16 +0000
Message-ID: <17e2bf4c718a7cfdc34131978ad03656d0622de5.camel@hammerspace.com>
References:
 <CAPt2mGOnsA9pcmZQkr2q40d7A+NLj7=xr+dzFh7XwJPdGYW6Hw@mail.gmail.com>
	 <a4abb5fcf94d706cc3f47d6b629763d5b1831c21.camel@hammerspace.com>
	 <CAPt2mGMOSHssr_J6bcf8A8dnU_oHNf_UuHZsDk1WxVi=TUheWA@mail.gmail.com>
	 <561ef18af88ecda0f7b8abf55c1dfb2b66cf5dea.camel@hammerspace.com>
	 <CAPt2mGNm11o3-b+W66eUUj=bvW-XV9wuiU+_uG+zigFPTQ6TwA@mail.gmail.com>
	 <CAPt2mGNYaeMxx4UCEKkaFjxk3K7hAhv8A9ARuPwhLx2yoOBv7Q@mail.gmail.com>
In-Reply-To:
 <CAPt2mGNYaeMxx4UCEKkaFjxk3K7hAhv8A9ARuPwhLx2yoOBv7Q@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB5104:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 x1ojnFcYAiiaRcNaWc5oetMa/SRX432crvkVM+DQFpu0fpDESfpVSak24YVj7QJahhGXHPbh14uieJsgE3P2eyKcy3+Gi+6Zz6AGwKvq8hBONn9Nj9BXu3xXlUXpAtiGlbf6mSxRFNhByuIiIjre0gifI5gnfiCrc76TedSutCpVuaUmEhzW7jhEZVE2vsvunjq0PloiqdUcM86AKBCTzrzhqM8D2gwPy2GdaOLScA1NjzMF+RqaUZH3kZ5vo5UBGNSDpexDL93Z+eqnh1FLSIqAHDpHFDyl+9lFZMR43IAA48694pQBpKmR3LsJulKC0imFzAV/zukql1D//PqwZD3qu9PgkAkaKV+FINx28LVsmzmf26564jwu9LwbLOCldfcG86qNS+dYPjUueut3Nv43OYy65WBfMyjggpH64NjtaSHKQxCQEuwcQyCAxr/yxNE2271HqBjv7VjCKqF9HwtgPrQcC3Iwyf0w7HhBkG//f2Jg7BnvVJZgSLMiCrL/FTMWmJARSgHxepVJ2P7RCtFV0lcCAeEWvhln63DWn4+SLOkb4UVdVH60B+EX+DylJvA0vpEx0FeTljkdN9UXMKCcN+lpgbd3LcBmwdp6/is=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjZjQ1lwNVR4NVFqVWNHdFhETnE3bFFKNDRkYmlESllPK0dwL29VOS9vU0dV?=
 =?utf-8?B?NUttKzl2a3FlTGxZa2dxbGhMRmNSSVdPaU82QWd6YVZqVEcvSmx1ZDI3TUc5?=
 =?utf-8?B?cFhsOVEvSFBlUHBPelBPVGhqOXRLRENLcXQ1YjlWcFl1Z2M1OFhYeGhKL0N2?=
 =?utf-8?B?M2pXLzBhSXRwb0xtSDhPSVZnby9qc1dUK3pFZzRxZ1M3SVMxdzNzT1lZbFBj?=
 =?utf-8?B?WmZWSE1VQkZ5UDR4Sm1TWDE5M0huVi96OGlkVnNiTlVHMVl3bHdibC9QMm04?=
 =?utf-8?B?MGRGL2gwR0g5am1RSkNHS3YyTHk3TExZcVNaN0psa3M1eUJsenE0dXJud3U0?=
 =?utf-8?B?Si9GQnQ0aG9pMWloRWc4RDY1ZmY5Tm1uZU1IYzdQR1hzMzZSeFhtTGhVU3VS?=
 =?utf-8?B?OVludEsrRU95czRmQnB2bEdqcmxWenVlS2RiYjc2TDVLMHRjcHRtZlpMdDNX?=
 =?utf-8?B?VllneHdHZU05bzk3TkRTYlhma3RUeWZ4MlpCQlQrWEVGRU1CTmJhZDhBYWtx?=
 =?utf-8?B?cGtuWE4yNHhrblRkS3pqTXViTVhCU1JZK01JMllYYURHTFI3bWJQQzlvU2xy?=
 =?utf-8?B?MmcydytmbTQrOWI1MWx4U3NPWnpkWE5pbXhYQ2dGd2N6NTM5ckdKSWVGZ3V6?=
 =?utf-8?B?aWc4SnFZa2lLT01UYUxHemptV09ReU9yckFKZzZMNG93emZHU1ZYSWY5OGNs?=
 =?utf-8?B?aFZ6RWdsSXhrU3hLREdJakhYTWJRSzdrZ3puOVc0MFM0UTlpZDNmTm5hdFpo?=
 =?utf-8?B?RVFJbll6TytFWEc3cEsyeFRINFVUVU9sczVqcmRoZllURXpmRUFSZjBnVG0y?=
 =?utf-8?B?eWJFeFk0c0I1ZS9zTWZoZ0VTdlNkOHBmaURHWVg3UVN4YzFOaGtGbmFqeTIv?=
 =?utf-8?B?eHdvOE9RT1Vuc1pJRkV5TEpodndUUTgxMUNQeEZuWXdzQ2owZFRDNUVEK2Fa?=
 =?utf-8?B?ZjRsK1lxSlJTZiswa3BYL2RLVjh2T2l6NlBqL2NJZU5pZ0RyL1JYNHVoTjZU?=
 =?utf-8?B?cUxCdzdoTlJZK0tnYnA4aGNnL2tQM1QxeGJ1OG1xSnB6SkVxZCttLythWmxB?=
 =?utf-8?B?M2R0UmZWWnJBbituUkRRTzlibDJMUlBjL295ODYvaVhaOWpGZnYwNWlHMGZB?=
 =?utf-8?B?K3NieGJEK0pRdy9lY0w4ZjdzTDNQRXlaNStxd2IycnFsSVVyMEJWdkF6S21y?=
 =?utf-8?B?azl0c0RQSHRLNHdqRFdSaTJIZ1lzMXlaNTM2RnozeWs2ZG5UNmlmbGx1TzZr?=
 =?utf-8?B?Q0NXVWl6bmJ6UUVDelNEaUVqSXphUEt3NVlacmtOTG11UGQrWEZpK1lqVyt5?=
 =?utf-8?B?Z1lrakN5b0pPMUQ3ZzNlMEdiVExoa3lDVm00cjBxSTlnTm1ZVHN6azhtMlBa?=
 =?utf-8?B?bEthcndIMEg5Y1htbHVoY0V5UW51dzZ2dHNUc0ZTdHhjVUVTQ2UvNUtXNmZ0?=
 =?utf-8?B?Y0dNTjdZU1hrWFRncndLeG9JTnBjeTJVcUVpSkFNQzdLcVRrbXJSeGtLaXkz?=
 =?utf-8?B?Y2ZyL3BiRlUyNU9zYmlLRysvYUtzT3ptd3p0cjNnTG5LbHVTTy9xSW5ROHNH?=
 =?utf-8?B?QW40c3RlQ3o1R3NmL0l4LzF2RjRwRlZMbEFqWXNXZVduQndjWitwVUlWMEx2?=
 =?utf-8?B?NnVPaW82bkJVY1VQbklTRm04em1ZN2FSZk4xcGpSL1hORkRFbkpWSVRkdzZP?=
 =?utf-8?B?eWcxdkIvcGVtclpFckdhakZYYytNWlVaWVRTYlNyMm53V0RPSDl5SW9HdFRS?=
 =?utf-8?B?ODVoRWNhSkFLblA0Zkl0Y1QxV2dRTTI5cDhQaGsxdEN3Qjk4OXN6Y3I3QjNM?=
 =?utf-8?B?dENSMm1BRjB1MkUrcWtZZFFDSEdoSkpvT2ViUnFIVWxDci90WVFEamVuL1ZD?=
 =?utf-8?B?ZEU5aFJUSnR6eWYwKzhyNGhoRGc3OXhIeHV2bTVVRFk1SzBpZEYxQlBiY2hW?=
 =?utf-8?B?WWJvazdJN1ZTN0NKRkhnOVN4YWMzVU1ZUDRBMlo2MEVZSDE1MEVVcnRCa1ZD?=
 =?utf-8?B?d2NQd2dwM2lCWFJEK3RiS1pibDdnSEFrSThFc3NDNEMralpjaXUxbVhuYktz?=
 =?utf-8?B?cXZ2MnJ5eVErd1l5MHdPTFZDaGVPVVdvNW9aUW1VUlZHYXh4TkRlOVVwdVp6?=
 =?utf-8?B?MmVvKzdsbVZrQUN3bzdGZ3EyRGpPcnJ4eFpmbW1MMlF4QUNVNmZRYSs5a2lG?=
 =?utf-8?B?VUJGbmFPYlo4ZVNBdHV3QUp5YWxHWjJXbkl6Y0Uzd1FIUDV4Rk9vNU43cWMv?=
 =?utf-8?B?bW5EMmlUSTRRK1dDM3d0M1JkMVlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DE68FED797ED4499302296CC8C851F4@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b56ba91e-7bde-4c4a-9315-08dc558185a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 15:03:16.0850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zauoGNo1fXy/x9S20oY2tr95QtIP1FZ6TORdJUA6NnCdxmkYOnQ9WZN5CTXMOxYOpIhkKQxRMSqYbR4lkCngdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5104

T24gRnJpLCAyMDI0LTA0LTA1IGF0IDE1OjQ3ICswMTAwLCBEYWlyZSBCeXJuZSB3cm90ZToNCj4g
QXBvbG9naWVzIGZvciBkcmFnZ2luZyB1cCBhbiBvbGQgdGhyZWFkLCBidXQgSSd2ZSBoYWQgdG8g
dGFja2xlDQo+IHdheXdhcmQgbmVnYXRpdmUgbG9va3VwIHN0b3JtcyBhZ2FpbiBhbmQgSSBoYXZl
IG9idmlvdXNseSBoYWxmDQo+IGZvcmdvdHRlbiB3aGF0IEkgbGVhcm5lZCBpbiB0aGlzIHRocmVh
ZCBsYXN0IHRpbWUgKGV2ZW4gYWZ0ZXINCj4gcmUtcmVhZGluZyBpdCEpLg0KPiANCj4gQ2FuIEkg
anVzdCBhc2sgaWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSBhbmQgdGhhdCB0aGVyZSB3YXMgYW4N
Cj4gaW50ZW50aW9uIGEgbG9uZyB0aW1lIGFnbyB0byBiZSBhYmxlIHRvIHNlcnZlIG5lZ2F0aXZl
IGRlbnRyaWVzIGZyb20NCj4gYQ0KPiAiY29tcGxldGUiIFJFQURESVJQTFVTIHJlc3VsdD8NCj4g
DQo+IGh0dHBzOi8vd3d3LmNzLmhlbHNpbmtpLmZpL2xpbnV4L2xpbnV4LWtlcm5lbC8yMDAyLTMw
LzAxMDguaHRtbA0KPiANCj4gU28gaWYgd2UgZGlkIGEgcmVhZGRpcnBsdXMgb24gYSBkaXJlY3Rv
cnkgdGhlbiBpbW1lZGlhdGVseSBmaXJlZA0KPiByYW5kb20gbm9uIGV4aXN0ZW50IGxvb2t1cHMg
YXQgdGhlIGRpcmVjdG9yeSwgaXQgY291bGQgYmUgc2VydmVkIGZyb20NCj4gdGhlIHJlYWRkaXJw
bHVzIHJlc3VsdD8gaS5lLiBub3QgaW4gcmVhZGRpciByZXN1bHQsIHRoZW4gcmV0dXJuDQo+IEVO
T0VOVA0KPiB3aXRob3V0IG5lZWRpbmcgdG8gYXNrIHNlcnZlcj8NCj4gDQo+IEJ1dCB0aGF0IGlz
IG5vdCB0aGUgY2FzZSB0b2RheSBiZWNhdXNlIHlvdSBjYW4ndCB0cmFjayB0aGUNCj4gImNvbXBs
ZXRlbmVzcyIgb2YgYSBSRUFERElSUExVUyByZXN1bHQgZm9yIGEgZGlyZWN0b3J5IG92ZXIgdGlt
ZSAoaW4NCj4gcGFnZSBjYWNoZSk/IE9yIGlzIGl0IGFsbCBkdWUgdG8gbmVlZGluZyB0byBkZWFs
IHdpdGggY2FzZQ0KPiBpbnNlbnNpdGl2ZQ0KPiBmaWxlc3lzdGVtcyAod2hpY2ggSSB3b3VsZCB0
aGluayBlZmZlY3RzIHBvc2l0aXZlIGxvb2t1cHMgdG9vKT8NCj4gDQo+IEkgZGlkIHRyeSB0byBk
ZWNpcGhlciB0aGUgdjYuNiBmcy9uZnMvZGlyLmMgUkVBRERJUiBiaXRzIGJ1dCBJDQo+IHF1aWNr
bHkNCj4gZ290IGxvc3QuLi4NCj4gDQo+IENoZWVycywNCj4gDQo+IERhaXJlDQoNCklmIHRoZSBx
dWVzdGlvbiBpcyB3aGV0aGVyIHRoZSBjbGllbnQgdHJ1c3RzIHRoYXQgYSBSRUFERElSIGNhbGwg
dG8gdGhlDQpzZXJ2ZXIgcmV0dXJucyBhbGwgdGhlIG5hbWVzIHRoYXQgY2FuIGJlIHN1Y2Nlc3Nm
dWxseSBsb29rZWQgdXAsIHRoZW4NCnRoZSBhbnN3ZXIgaXMgIm5vIi4NCkl0J3Mgbm90IGV2ZW4g
YSBxdWVzdGlvbiBvZiBjYXNlIHNlbnNpdGl2aXR5LiBUaGVyZSBhcmUgcGxlbnR5IG9mDQpzZXJ2
ZXJzIG91dCB0aGVyZSB0aGF0IHdpbGwgYWxsb3cgeW91IHRvIGxvb2sgdXAgbmFtZXMgdGhhdCB3
b24ndCBldmVyDQphcHBlYXIgaW4gdGhlIHJlc3VsdHMgb2YgYSBSRUFERElSIChvciBSRUFERElS
UExVUykgY2FsbC4gSGF2aW5nIGENCmhpZGRlbiAiLnNuYXBzaG90IiBkaXJlY3RvcnkgaXMsIGZv
ciBpbnN0YW5jZSwgYSBwb3B1bGFyIHdheSB0byBwcmVzZW50DQpzbmFwc2hvdHMuDQoNClNvIG5v
LCB3ZSdyZSBub3QgZXZlciBnb2luZyB0byBpbXBsZW1lbnQgYW55IG5lZ2F0aXZlIGRlbnRyeSBj
YWNoZQ0Kc2NoZW1lIHRoYXQgcmVsaWVzIG9uIFJFQURESVIvUkVBRERJUlBMVVMuDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

