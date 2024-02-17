Return-Path: <linux-nfs+bounces-2001-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DA0858CEC
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 03:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3E01C211CE
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Feb 2024 02:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F016C171D1;
	Sat, 17 Feb 2024 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="aw38enrc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2104.outbound.protection.outlook.com [40.107.92.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9907E5381
	for <linux-nfs@vger.kernel.org>; Sat, 17 Feb 2024 02:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708135254; cv=fail; b=lZo74kRHUCYuQ3gfO7J8ZxkiHRAcf9Zr7kQANYd24pXoaKHD9u/srBVelwN9VSxZGlmGjutEK4S8TsjfrVvhE2z1aBQH134dvX7Zi7kJu+o0fAGQ7TuS7Z7/+XaCgd0Y4M5JI9d/KZD3SHHme+rz8ZsBPigeW8Dd3l00UZRyxiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708135254; c=relaxed/simple;
	bh=Iln3kAgVzpHYGv62FgT5hQ+fouyMeQ9bECiPqN8/36k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WxXD7wnC/hI/ZhIGrfQZNteNqOPaXGiKZn8TWTBzzcw8V2Pv+a38HeT8UVKBbECEt0AcHowd17FsRJr+vGgHhBJdLJZxo36yInQ3G8n6uGpjNR4HS8I5q0WuvQfaNJy5c0AD/kbNyuop5DIlY5hYQTXlRAdb8QC7JxKs+pqtJ+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=aw38enrc; arc=fail smtp.client-ip=40.107.92.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5SrtRszG5evVFUto94yRz7PvBHAEGdkfX+CBMgV5H9Gy5nPgzGkUUNNlQ7FB1vtv+BvDjabue94HcjTI6ffrDPSxd6viomiE3twm2IclgZSq7V153a1gYa4kbldfGK9TWtbv+ViJ3UJuzB62u+K2s+/9tnFLvNtPNhEJsHn160feerwv0kOpD84YihjDYcGGtdXcA9hVOhXl6nzjctHf/JldRSjZSnKY4ljrIN/OoR3dCE2GwSzqIIEVP3nRHdkCgFCQs083bz4zsMP+5kbFIm1SRaHWAWKVMSZN/WBMBrXBCl0JKcQuUXepUGs2A7XQtNdFgwMOFb1IuASFid+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iln3kAgVzpHYGv62FgT5hQ+fouyMeQ9bECiPqN8/36k=;
 b=V6EK1hYoZwDVvDExHqrRnjmYyhw1/YolaA8gXhbk4V70p58A9ahEDhAXihoWpqbs81KRwgRPkSC5lwJRSIQHvzwMzpJk3BKCG4ClPLH2146RADYpV5iI/5r4e5LcvnIvo6UWxENIc04+jnGCrtm+1BRNQNnzWePKp50IlMZY7Kno4MfMpwCkqt6c/y7jfuTwyWXflXk5X6zuLDuKGPSM6JYvRmaVRRLPUShpHyl0dcVDTwX+3G/wYv5Ntscg4Iejvt+DF7omHm/2XNFoduYQjate+klOa2pAKhQ+gOxxI1EPBmIhFlmxGzpEazq1/51JU8bg633+BdjQATNynmf7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iln3kAgVzpHYGv62FgT5hQ+fouyMeQ9bECiPqN8/36k=;
 b=aw38enrcqgU8ePu8dRP7FnZ2jq62Bu+I/lCTWea0bW/dvOt0qqThOPcsDpfxML/oXofq9QmsBesIoUmR9R5FheuYFGhq99K6tmYOYfyZMpCWDBtM0wxat0j+82kttYe4Fjnfnt1dVsObVqSGRQEv49G9nCSg5R3RYYMP1X+LqqU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by LV8PR13MB6326.namprd13.prod.outlook.com (2603:10b6:408:180::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Sat, 17 Feb
 2024 02:00:48 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c%4]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 02:00:47 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"dan.f.shelton@gmail.com" <dan.f.shelton@gmail.com>
Subject: Re: PATCH [v3 0/2] NFSD: use CB_GETATTR to handle GETATTR conflict
 with write delegation
Thread-Topic: PATCH [v3 0/2] NFSD: use CB_GETATTR to handle GETATTR conflict
 with write delegation
Thread-Index: AQHaYFsjrx+cpQF0SkyXZ7YNLld19bENoLuAgAAozAA=
Date: Sat, 17 Feb 2024 02:00:47 +0000
Message-ID: <ab13f901c00cc1ee2bd61df169327ceaff2f99bf.camel@hammerspace.com>
References: <1708034722-15329-1-git-send-email-dai.ngo@oracle.com>
	 <CAAvCNcDDb4L2tcbBCcufFg=TLeFSrui4MHFuEeNUA+1VZyXLxQ@mail.gmail.com>
In-Reply-To:
 <CAAvCNcDDb4L2tcbBCcufFg=TLeFSrui4MHFuEeNUA+1VZyXLxQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|LV8PR13MB6326:EE_
x-ms-office365-filtering-correlation-id: c629f2f7-8e89-436c-3a34-08dc2f5c4202
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FzembHWyfl+92xg4KNAoKyjSdSCFwiPCNnprEaTeUvsLSAx+QxJJFYOt7Vz+m1FTCSa3F8KMo6PpaWv2S/B4KaSZ1Rv9EyRO5FsPrNJsQ98kiLdiEwdn2dnW+WrEuQfdq836LGU6jm29M5u+/5R1CxIrY2oJ65Ejg1xm4DpzRdrRJrvZRhtE6fRajDRYt9zQEp7KlG8DvhoS737NhOmdIDvLIsbKqrqfAGrVFjObtITde9rQQJRBQD5fxSG16yVku1o3SDQsSV0AlzYdDJH+vvnncAS5ncmtn/AyYQAx8psRE75bz/Udf5lc5z6EwzM6xQyZ5G5t1c2PmXqOg4xz6nVubKJW2ue2QkP1y5isHVSyNdQzTUH4BrTB0i4vQ0J+HqvssPt0JmSnxyqlBOXfGi2VYKszKibG2FvRYR8HBfDvYr4nkIBVTWlNJGug+VYXMvNOmdqhkvgQNQIzld3AfO70jofEIbWqIuFTV+QOcxqYc8Nvm+mwG+eHIjcUQMR6a5i8CTF2/5BuDkgaP2dPjiliku+OGtqXqBWONxOEpJ37wGxvIGqIn/uwXJgTAU6J1K5kCIi+eBgARqTTzBPjHN6YrR7ltMWpz1IywFdplbia2O+6Xu6N4hgiyPQdYmiD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39840400004)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(86362001)(122000001)(38100700002)(36756003)(5660300002)(66946007)(2906002)(38070700009)(66446008)(76116006)(66476007)(64756008)(41300700001)(8936002)(8676002)(66556008)(6512007)(316002)(6486002)(6506007)(478600001)(71200400001)(110136005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEE0ZU5Bb1pzMXNmVmFPL0cyTlhoRTQrU09xUm9YWjNYR3ZVSEFidGlsSmo3?=
 =?utf-8?B?UXRYTXpLcGRKWkNmaDJTcUVvaGtSbDZyY0xOcjc0N3Bqc3A0a1ZnK2JvSGc5?=
 =?utf-8?B?OEZhQVlaZ0hsb0JtaVA1QWpRS3JsNms3SCswMTBwcGpTNFZYMFNuSE9YdnBw?=
 =?utf-8?B?a1FIdE02MjQwTmR3RFRNVG9KbkRML3JmSUJSa3haWHQ4RE8xNnRkeE1CNW9H?=
 =?utf-8?B?MzFNS0JkQ0J3SVJObmF5amYzZVorNG5RM0g0eWpMNkZQS290Z1ZUdFJlZHZU?=
 =?utf-8?B?S01kM1VUU0Fod25iM3dvaGczSTNNRUQ2ZDJra2NBRkpXdXpqdXVzTWZ1dUtO?=
 =?utf-8?B?ODZHRmI1TDR3ODFZenh1RlNoSWttYkd5Q2Z2T1VtOVdOdXBYUEs2T1NxYVlS?=
 =?utf-8?B?eXJvUEZmVEVkVk5MWXlFcW54NmJyUzZzaG5ObnZxTnI4S1YxeExKSWRMcjJO?=
 =?utf-8?B?aE5CdEYvSnBGZXpIN2MzTWZOTGVkcHVuNU0wOGQ1S2Z2Mk9MMDVRL1hVbXYv?=
 =?utf-8?B?NkJEaW1BTDllcGZxWnFRbXFKTWMxVUkxY0s5SnZHbUtvWGpnTEZBTDVkbUlR?=
 =?utf-8?B?NjZuYUl4WGd5Q3JIdWdQbnNEclR3dUdsT1dBZG5pYS9lSDdtZ0crZ3NtUTZt?=
 =?utf-8?B?NWNrMVBVeXMrb1RCYTU0d3lyWnlIVVRoT0tpK0dDR1hSWjdlMjRKdnFXZjZz?=
 =?utf-8?B?dWc3eE1xZjZzQnpWMGFPdTFSMmJrUzRYWWZyeTF0bm5KbHp0T2FRZVVQclVX?=
 =?utf-8?B?cGZZK2hiUnlyV1VwUGJKSUppa09VLzl0clVUaCtYcDF5QUowMGY0NC9LZ2ln?=
 =?utf-8?B?ZVNFUVZaeGxUM2FIanNrb2hqRFQ1TWtjYzBlWCsxRmdCL2FvcFhrRHpNNzVB?=
 =?utf-8?B?WUFjZExhUDl3L3RZendGU05hb284bDBaN2V6Mmlmc2ZmcXZ4bkkzNFl3NUhM?=
 =?utf-8?B?WWE5REV2akMzYTZ0MjkyWFBQdEM0WFlqU0RhQldUUTl3VEZHSVZ5ZEpFdVVY?=
 =?utf-8?B?Z21tdFUxQ25EUVdYU3BTQVlROXNBeHFtSm12OFZ4bytYMW9PQW05elNaN2pK?=
 =?utf-8?B?VUxCcC9vbjdTSDBKODI1SVI2UVluVWRreUgremtIQWNPcUU1TGp5S1d0WUpm?=
 =?utf-8?B?YUM3VGhCa2VoSDF5Z092dXJ0a2pIR09jeE9RZHFHd1FRRTE2RDY2OElMUjQv?=
 =?utf-8?B?UFZ0OGpYakpacmd0UFkzdERBZm1IZEpUYlhlSWI3N1dIZWJ3aTloZkJZckdO?=
 =?utf-8?B?MTFlVzlSK2hIRHVUVUo2bmowWFpiYlV1Z0JaRVdjeTI5YmhWeVMwKzFsQkxR?=
 =?utf-8?B?YUJIdkVFM0NSbXNpdW43cC9KZENKUDhYN0xqVEsvQVdRMStSOGhJWUtpcVc2?=
 =?utf-8?B?SVhVbk81S0lON2FNOVVnM1dCdlhjVmV2S1pLZERNU09vMU92aXM1U2xVa1Iv?=
 =?utf-8?B?U2Nxa2R5SW9NU3JkOWpwdm1EcHNKeDJ0VjRxOUlIakZ5TFRCUmtocGJ3RUxP?=
 =?utf-8?B?ZVBuMUFGcVMrYmlxVHlydWk4REZHdytrbVFnL0tnVFhWTjVGZnl3ZEtJMng5?=
 =?utf-8?B?ZXcwZkR2a2l4ZWdxWU1Qb2RERUZOZWF6WXhwRzl6M00wUTkxL0ZINnpCeVVH?=
 =?utf-8?B?T3BBRUs0ZEFHaEZMYnNWSE01NlFoMUlTVlo0ZGdrNG56RURIRlAvZGhlVWFn?=
 =?utf-8?B?aTg4TkJEUlZLU3BXL0FPclJTc3hqZ1RqajhGR0QwMnJHSVRRRjVvcnVMaW16?=
 =?utf-8?B?UXJjQ0hQZkRFVG83WjV3Y2JYWVBIVGlvenJuak1GK1NVZVIxWjZqQmZuTXhN?=
 =?utf-8?B?bWZ4T2tQL2x3am1xQ0UySkpnOFVHYlJDckVTUVR2V0pUSWVyWDdkSzlESEdB?=
 =?utf-8?B?MCtjNTFVZXJxRVdCVjBxV1BxUmFHUEVhTWJ5RWFNZDUvK3hFb21oLzJ3ako3?=
 =?utf-8?B?Umc2WjZ3TzdrbzhJZks4aExaTHVHdEUwQ25wa1gzYXFVRUlZY1RFUG0yM0o2?=
 =?utf-8?B?VVRHdHV4ZHlEQUh0c0pKeDhSQnFxQzA0bEtNU1loa2haL040L0hPQ0VseFp1?=
 =?utf-8?B?aE5jRlRSYW5tYzg5bXBIeWhBU3Y0bHo0YU5TWDZoU3BjaFlKeEVpZndaU0l1?=
 =?utf-8?B?SmVUcjF4SEIyNXNjY09vSnM5Y1dyQ3lRU0FBbk9aL1VWUk9hSGVQNkY0disz?=
 =?utf-8?B?T2t6T3ZrR1VlRlBqcGxFWldGWCs1TFVSRVd0aGpxMDQ3VERmVCtGVUlUdWhw?=
 =?utf-8?B?anQ4UlZPWFhLY2FRNmZ4amZ5TnBnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A2890EE5F0DE1478846F7FC999552C4@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c629f2f7-8e89-436c-3a34-08dc2f5c4202
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2024 02:00:47.0607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4D+XvWanfSl9eBMhSuuljFOUUyhVbiZVkBN7IpVqvL7Sf2ZfS3AuRT96IKewC9JaFnxk/mNku/3S8jX8BPAbqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6326

T24gU2F0LCAyMDI0LTAyLTE3IGF0IDAwOjM0ICswMTAwLCBEYW4gU2hlbHRvbiB3cm90ZToNCj4g
T24gVGh1LCAxNSBGZWIgMjAyNCBhdCAyMzoxMSwgRGFpIE5nbyA8ZGFpLm5nb0BvcmFjbGUuY29t
PiB3cm90ZToNCj4gPiANCj4gPiBDdXJyZW50bHkgR0VUQVRUUiBjb25mbGljdCB3aXRoIGEgd3Jp
dGUgZGVsZWdhdGlvbiBpcyBoYW5kbGVkIGJ5DQo+ID4gcmVjYWxsaW5nIHRoZSBkZWxlZ2F0aW9u
IGJlZm9yZSByZXBseWluZyB0byB0aGUgR0VUQVRUUi4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIHNl
cmllcyBhZGQgc3VwcG9ydHMgZm9yIENCX0dFVEFUVFIgY2FsbGJhY2sgdG8gZ2V0IHRoZQ0KPiA+
IGxhdGVzdA0KPiA+IGNoYW5nZV9pbmZvIGFuZCBzaXplIGluZm9ybWF0aW9uIG9mIHRoZSBmaWxl
IGZyb20gdGhlIGNsaWVudCB0aGF0DQo+ID4gaG9sZHMNCj4gPiB0aGUgZGVsZWdhdGlvbiB0byBy
ZXBseSB0byB0aGUgR0VUQVRUUiBmcm9tIHRoZSBzZWNvbmQgY2xpZW50Lg0KPiA+IA0KPiA+IE5P
VEU6IHRoaXMgcGF0Y2ggc2VyaWVzIGlzIG1vc3RseSB0aGUgc2FtZSBhcyB0aGUgcHJldmlvdXMg
cGF0Y2hlcw0KPiA+IHdoaWNoDQo+ID4gd2VyZSBiYWNrZWQgb3V0IHdoZW4gdW4gdW5yZWxhdGVk
IHByb2JsZW0gb2YgTkZTRCBzZXJ2ZXIgaGFuZyBvbg0KPiA+IHJlYm9vdA0KPiA+IHdhcyByZXBv
cnRlZC4NCj4gPiANCj4gPiBUaGUgb25seSBkaWZmZXJlbmNlIGlzIHRoZSB3YWl0X29uX2JpdCgp
IGluDQo+ID4gbmZzZDRfZGVsZWdfZ2V0YXR0cl9jb25mbGljdCB3YXMNCj4gPiByZXBsYWNlZCB3
aXRoIHdhaXRfb25fYml0X3RpbWVvdXQoKSB3aXRoIDMwbXMgdGltZW91dCB0byBhdm9pZCBhDQo+
ID4gcG90ZW50aWFsDQo+ID4gRE9TIGF0dGFjayBieSBleGhhdXN0aW5nIE5GU0Qga2VybmVsIHRo
cmVhZHMgd2l0aCBHRVRBVFRSDQo+ID4gY29uZmxpY3RzLg0KPiANCj4gSSBoYXZlIGEgY29uY2Vy
biBhYm91dCB0aGlzIHN0YXRpYyBhbmQgdmVyeSB0aW55IHRpbWVvdXQuDQo+IFdoYXQgd2lsbCBo
YXBwZW4gaWYgdGhlIElDTVB2NiBsYXRlbmN5IGlzIHdlbGwgb3ZlciAzMG1zLCBsaWtlIDY2MG1z
DQo+IChhdmVyYWdlIDI1MG1iaXQvcyBzYXRlbGxpdGUgbGF0ZW5jeSk/DQo+IA0KPiBXb3VsZCB0
aGF0IG5vdCBydWluIGRlbGVnYXRpb25zPw0KDQpUaGF0J3MgYSB2ZXJ5IHZhbGlkIHBvaW50LCBu
b3QgbGVhc3QgYmVjYXVzZSBjbGllbnRzIGRvIG5vdCBvcHRpbWlzZQ0KZm9yIGJhY2sgY2hhbm5l
bCBSUEMgY2FsbHMsIGFuZCBiZWNhdXNlIHRoZSBjb25zZXF1ZW5jZXMgb2YgYSB0aW1lb3V0DQp3
b3VsZCBiZSBlaXRoZXIgdG8gcmVjYWxsIHRoZSBkZWxlZ2F0aW9uIG9yIHRvIGZlbmNlIHRoZSBj
bGllbnQuIFRoZQ0KZm9ybWVyIGp1c3QgbWFrZXMgYSBiYWQgYmFjayBjaGFubmVsIHNpdHVhdGlv
biB3b3JzZS4gVGhlIGxhdHRlciBqdXN0DQppbnRlcnJ1cHRzIEkvTyBmb3Igbm8gZ29vZCByZWFz
b24NCi4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

