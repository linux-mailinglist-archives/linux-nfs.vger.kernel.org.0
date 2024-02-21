Return-Path: <linux-nfs+bounces-2042-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C383E85DC09
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Feb 2024 14:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514701F220EC
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Feb 2024 13:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DBF7BB0B;
	Wed, 21 Feb 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Je1gF3Vp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2123.outbound.protection.outlook.com [40.107.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB5347A7C;
	Wed, 21 Feb 2024 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523305; cv=fail; b=JpVrbsEunTHsOw3x2y7ayWNrlupXiyLLjzG23DjTgXgKYpVR+NZp8AIp2YGMe0Ws6IuNUKGb25XFO1eCbQPki1l/1Q7jnyWBBXoekwW7tu3WpvJFkDMVq2r7IbbKIebLMz6klAitCufosWr/CRp+zgmacaBsWcwHeoXUV53tdkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523305; c=relaxed/simple;
	bh=oAZIP6xbMijqRnSomzY/lRrOimaqxW0fQvPUKZQtBZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O5m7SGEqHgBM3zJ5XD5Sa8U1Ml3+AH42+JiCdgnCTVOh0iAfGgZy+qIZeAMKIxZfUjTLSh4DXS+quRYNl4yviQSSHgWJCQLCiRhE3oE277GPRMEY9IXl2cWSns5p1AHBubcnn473W/DKkvuWLMEAIjFwCDdwBk7iKPcaPlcjF+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Je1gF3Vp; arc=fail smtp.client-ip=40.107.223.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXIJ1DBq2uk8OSPOXzVH8ivQ3Gz+xm0JWHhLaVa9ZZcnLiyizCZXB9V0hif6dZz7PLPubV4+vmNHHzvDDpmjcW64puwNMQ7Lyr317rLUyE8OwkuF/inr7sQ0HfhG5fpzk+PDVDNJTO4cRtJP8J0pRbdaAyVMQ8HFZHVXb6495nbiQ3f0BKnLc9ezAP/uKFt9cjScb0ZrVWzywMLcbuAgXVMxfBnfDSDVpfYVNm0YpcXhgRMZX+w75QVE60AJbu+A8OSAxSO3pXCEEM43P4JSCjJb1WEaxqB+0aTRLi5tURbNjdS8mO6wTjHblNT765MNT1PTuybAXHoCdnQDUTyBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAZIP6xbMijqRnSomzY/lRrOimaqxW0fQvPUKZQtBZE=;
 b=cw0Fu6tsjV6+Uk/R5mZiH5q2eHJ4ualjjQXvaCqZWRn3IZNMTs/QBoxzKhINsduU6nlmb3qj+Es9o+rgPJCP5PU6KxSeZ6crs2o8TWddnao1D+pyULpDsT8qu0PZbahnNDVkF4oHZO02dhT3FBcV/bp0sGUKmrFOfYgXNnn5Ar8pQniqdSrluwTNWFm9xuylRYXJyd84raePeg42Y7RpwdyLdnMunCkYRrV+ny7cuLr3ITYsy+dGjFOXcXP+12U3sXdt5pMcOXy/VQpYn1JLr3wdgv0M990p+3nP9YlwuGZHxSmNJBMuXRHb0hDfb4775ktJfWoW804lFY15N2xQ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAZIP6xbMijqRnSomzY/lRrOimaqxW0fQvPUKZQtBZE=;
 b=Je1gF3Vp3oQ97pglhlNLz9IRSKAgmQbLABePQYD0lzgdsDMUg1V/MbYMZxSLBtma16qmNAByYdAYbg8YuZH4DHmR5XTWKmvnttvSWXlkak48JwavO5GrKsCsZ02PYmlvY/E+hp76kh1I7n6iGOo0yIUcohIbfOjEmRJj51sgBHU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4748.namprd13.prod.outlook.com (2603:10b6:610:c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.42; Wed, 21 Feb
 2024 13:48:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 13:48:19 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "chuck.lever@oracle.com" <chuck.lever@oracle.com>, "zhitao.li@smartx.com"
	<zhitao.li@smartx.com>, "tom@talpey.com" <tom@talpey.com>, "anna@kernel.org"
	<anna@kernel.org>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "neilb@suse.de" <neilb@suse.de>,
	"kolga@netapp.com" <kolga@netapp.com>
CC: "huangping@smartx.com" <huangping@smartx.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: NFS client IO fails with ERESTARTSYS when another mount
 point with the same export is unmounted with force [NFS] [SUNRPC]
Thread-Topic: PROBLEM: NFS client IO fails with ERESTARTSYS when another mount
 point with the same export is unmounted with force [NFS] [SUNRPC]
Thread-Index: AQHaZJ7Q0fUwEoXw10Oowo706qnhILEU0AGA
Date: Wed, 21 Feb 2024 13:48:19 +0000
Message-ID: <77a58302766cb6c8fac45682ede63569df80cd5d.camel@hammerspace.com>
References:
 <CAPKjjnrYvzH8hEk9boaBt-fETX3VD2cjjN-Z6iNgwZpHqYUjWw@mail.gmail.com>
In-Reply-To:
 <CAPKjjnrYvzH8hEk9boaBt-fETX3VD2cjjN-Z6iNgwZpHqYUjWw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH0PR13MB4748:EE_
x-ms-office365-filtering-correlation-id: 3275411b-18d8-45d0-db71-08dc32e3c310
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 h/tJHksPXzGZxMig3oSj3RBTawm2aLRkDKxE+3p91GRCSP2BFRWHrtxXV0sXqLiaqBKxUAlgZllTdikDAgHn/cK67sFw2hynp9f/KNQawADhRNhpgBaSCme2F4w439PGFfYnqMMMslevma8+ajp9g8tNy81eaz1G+AI7HnefcV2vVaKgPldeVf1J0eWnyZWERkJl8IeVQ/IB9saF0BMS4PTa8bflbmOxPduGhq9alnH0TEtW5KiNz+n8dOezXQjaMpmFZlAGab9VJ49trPvTPadxkxwwaaaLyWxjhngHsuBPAMdM36vrpo+DkZftkb8TPrDSxvHdxgiDgaLQodoUYanp+9xguXOFu8RPUXCbUR7LK7vd38SNppc+u1k9KkYxDf0dLc1WcPFOQaA+hyWLwyOgbIoWqkJ5m8tl1FmVUm0tnMweg8X6VlObq7zy3lwO0Z1sKOXs4myhVAmDJODCUDIWtq81HWleWcvVvJxQ1mEF+K6klNzj/Nt/kmPpy4IDStDnhwQeYC2rXVGQLsI4C9b73Te7q855BctfLykwFmPxCfQTmWgk4pBY3cw4AWyF+s1PHQhyJOLnx6SUvCCe1q+XO9IG8zTuM5NmhO7u/2zdle8Jgnv+TdUp4zN3AWIS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230473577357003)(230273577357003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akwrZWxtUkQzVGtnYUlQUkg5NHQxTExremNRM3RZcHh0UVdhK0RWOTZyNjJt?=
 =?utf-8?B?NEpnV0NFdjd4V3oyQlVGbkNsZFlmRXQ3dDcxd0ZpTElZL2dRcHhVY2ZZT3pk?=
 =?utf-8?B?bFVTV3Z2aUF0bjlJYkxnMGFvR2E5SU1uN3hGb3NuZkZBeGsrcUFrY1RsY2dj?=
 =?utf-8?B?MkFiQzVOd3J4dERUV29WYU9BUkpUZllEclVkNTNyV1NrbytMTEJNaC9sbkg3?=
 =?utf-8?B?UmZ2STVOL2JoVGZYRkI3MCtUcTZJd0VtZ0R1NzZuTEphYzc0SkpVUnk1Ykdj?=
 =?utf-8?B?b1gwTGhsQVJjWHo4UUZKY09zck8yUmpIQ21xSWNOQXdleUhRbXkzamhyTnRO?=
 =?utf-8?B?Q20wZ01uZTgxTXM2WndDOVAxS0sxNzB3cnFnc29LKzloRnhMYk5YZ0JhR3g0?=
 =?utf-8?B?MnU3K2xOaCtVMXU1Um1DZzVEL0xCdktzSmV5NDg1MEdLbEpuOXUwelV3LzBr?=
 =?utf-8?B?ZjRPcTdOczIzL2o5ajRNT3p1L05PcDJJMWllbWZzNWEvSktoZWcyNHZkV0NI?=
 =?utf-8?B?eGtFYWlHN3pzdXlib2xicDhLZnFWMHE4d2Y4V0ZoYmM4Tld2eW1SNlV5SlVR?=
 =?utf-8?B?Wm5KTjlHOWxiMHZqT3dscFdHTFN3UmlqdllmV2F5elN4MnU1bktDUTlNZUNi?=
 =?utf-8?B?dm5Ib29sWGhkT0MxbDZiTERiTDhzV1BkeWdHODZFd2Q4dFNMblNKQVhvU3Bj?=
 =?utf-8?B?aGRVM2dBMXpRZmJ4cnRmdnd3OXFLUVkxVlAvbVBxejBwWXpFWCtqWjNiaEdt?=
 =?utf-8?B?bk0wVFhoRlA4M0F2dXFybm5OL1NGVXZxTGFTSmZBZlV5NG9aVGNRK1lBZmFB?=
 =?utf-8?B?NEE5QkVHRjQxWUx5MmNoQW5TODE3cXNNNThGamt1dmZzM2pkdkM3QmhIZXd1?=
 =?utf-8?B?NnRSWmdISGNtOXVUUWgxR2lmeEtyd2kwTGl3a2R1TDM2ZktONm9peWZ4dkxi?=
 =?utf-8?B?UTlMVDNuVmdWMWJMTkZvUGRGUlhuakViYUJxQnBSdXBheWxJUVgwUTI1eis3?=
 =?utf-8?B?Umt2TGtMZTJrbFdtQ3FvZlYyaGUzVWppcU5mWHhodmNuZmp1Q2pRSDZPMVBS?=
 =?utf-8?B?bXhqTUdNTklGWFBqeWhJTjdUVDRVcC9NclBGZjcralR5QXpPSnBYbXNUeE5w?=
 =?utf-8?B?eGxZcFpMd0E5V1NsallNVGJ0VTRHQlhhS1puUVpwRU1UemtXdCtXV0JoQjVT?=
 =?utf-8?B?Q2lwd0VwbThUV3lEdUNRbHA4YWFoTngzSUhkamRpQzkyUzdPR3RrdWFmclBJ?=
 =?utf-8?B?OW5ZcEtJRjhZdVFVVDNBdkpjTVpONjNSYmF2aTVva1JOMkFIZ05HS1pTMEhM?=
 =?utf-8?B?QmlyUGcraGk1Z2tzaGw3OTgwUVNrWWx6TXlUTDFkMVc1Z25hclpoNVFtL3dp?=
 =?utf-8?B?TDRnTEFraGJDZldsWU9ubmNjMDhrbmVwUGs5c0I1VlU4RXBGWFZ2T2tPOWti?=
 =?utf-8?B?dzRuUjl3TmpsdjI4d2VKWStTc1paZ1RTd2ZGMFIvVGwxV1YxeFY5MWY4SFFI?=
 =?utf-8?B?bHhucjdWeFBXbUllTDBNVTdFdUxMMFV3STJrOHB6U1NDQk9teGJvVEF0Z0pl?=
 =?utf-8?B?cFN1WnpDdnQwaUFIYkFYamJZV3FLYWtHL0JnRUU3MkVaWFdXYTYyNEVyZFE5?=
 =?utf-8?B?blpXYjB2ZzN5c3M5RmdRVTdzZ24wYXpPbWZNU2pzMEphaUpnemlMZ2VydldM?=
 =?utf-8?B?YkdEYWY3UVZVV1U4L3BKZExoaHpzMnpqakhqdmlBN0RQOHdpL2l3OE84Ly9S?=
 =?utf-8?B?U2JLRGF4cnpSWm0xc1JIVlJqTjg3aUVNVTYyQW1LNDZqNXlNNWxuNEdUK1Bj?=
 =?utf-8?B?TGZpUUJUNXJRVlZkbGl6VU1jZ2xRWEM1U0czNlMrMzJ2R0djaWFXakFVMXpx?=
 =?utf-8?B?djlNbnhhTHFydlYvUWhGRDAzb1FOM0RLWisyZ2xPMU9IajBkV1R1Y3pTcUp0?=
 =?utf-8?B?ZmdKK2tRdUdtZjhLcmtTbWVXY1BvTXBIRVFqelVQaE9FYW56VkpaYTZxSTcz?=
 =?utf-8?B?THc4K1dFclRLNC9xREk3MmNSY1I4WjZxWlJTbFBHV3FJTFRMRWtwSGtZVlg1?=
 =?utf-8?B?VWd0TTN6UWFjOXZITnc4UjVBYUhKQWxNdXA3a1Z3SzZWbFlwRXFSS2ZxbjlX?=
 =?utf-8?B?cVA0OTVONklEL2diVlQ5UFcyT3M4bFV3WFI5YVVWdmFEbGJqK0xpcmFWaEdR?=
 =?utf-8?B?U1pLTTllRE94UVI0S29Ldmp5WW5qY25TTXM1dEZUV0FXVDlvNTdnNFpjajdp?=
 =?utf-8?B?V3UxUmU2Y2pWdTl2eWR1WkMxcldBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <116C16FBC0121C458D005F474058D130@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3275411b-18d8-45d0-db71-08dc32e3c310
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 13:48:19.1278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrxwA76E/dYRLm2zWlBW+evCI1kjpZpULs6la4Qs2oiLOeSvI8AMxh7PHdh8qiPIty32CvVIhPVtJnSWWJ8BMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4748

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDE2OjIwICswODAwLCBaaGl0YW8gTGkgd3JvdGU6DQo+IFtZ
b3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gemhpdGFvLmxpQHNtYXJ0eC5jb20uIExlYXJu
IHdoeSB0aGlzDQo+IGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2Vu
ZGVySWRlbnRpZmljYXRpb27CoF0NCj4gDQo+IEhpLCBldmVyeW9uZSwNCj4gDQo+IC0gRmFjdHM6
DQo+IEkgaGF2ZSBhIHJlbW90ZSBORlMgZXhwb3J0IGFuZCBJIG1vdW50IHRoZSBzYW1lIGV4cG9y
dCBvbiB0d28NCj4gZGlmZmVyZW50IGRpcmVjdG9yaWVzIGluIG15IE9TIHdpdGggdGhlIHNhbWUg
b3B0aW9ucy4gVGhlcmUgaXMgYW4NCj4gaW5mbGlnaHQgSU8gdW5kZXIgb25lIG1vdW50ZWQgZGly
ZWN0b3J5LiBBbmQgdGhlbiBJIHVubW91bnQgYW5vdGhlcg0KPiBtb3VudGVkIGRpcmVjdG9yeSB3
aXRoIGZvcmNlLiBUaGUgaW5mbGlnaHQgSU8gZW5kcyB1cCB3aXRoICJVbmtub3duDQo+IGVycm9y
IDUxMiIsIHdoaWNoIGlzIEVSRVNUQVJUU1lTLg0KPiANCg0KQWxsIG9mIHRoZSBhYm92ZSBpcyB3
ZWxsIGtub3duLiBUaGF0J3MgYmVjYXVzZSBmb3JjZWQgdW1vdW50IGFmZmVjdHMNCnRoZSBlbnRp
cmUgZmlsZXN5c3RlbS4gV2h5IGFyZSB5b3UgdXNpbmcgaXQgaGVyZSBpbiB0aGUgZmlyc3QgcGxh
Y2U/IEl0DQppcyBub3QgaW50ZW5kZWQgZm9yIGNhc3VhbCB1c2UuDQoNCi0tIA0KVHJvbmQgTXlr
bGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

