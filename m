Return-Path: <linux-nfs+bounces-2114-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B65386B9B6
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 22:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033322860F3
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 21:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6AA86241;
	Wed, 28 Feb 2024 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="NEzRXQ4T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2095.outbound.protection.outlook.com [40.107.223.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1045E3FB9E
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154969; cv=fail; b=ocHzRRi6gopOTDvJi6wHmBaw/srCJKEcY+DN8Pot3gLZuAQeQgysPd6S67G4KogSqahDjfwjtvY+4C7ZVxi8p5L+zIjgi+1wcSQD+Aarrx/6h1V07CAx0u4A7D2qFpfSakhdnjlb8tA3U9sEB3gVmTNuVXJG24XHP2+rLCGIEUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154969; c=relaxed/simple;
	bh=RBw7Jlf9hlLwt6bIpDxe1PxCHf/ZqE9J3elmAhzZqV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HflUxZpOethE+BJnh7euB9y8tO/B2teJNJiWXj0Xvw+hePYepjyPnoyDD9hrmFjyMiv7gQ0YZ92cdwiJhiJaHdI6KsCdpjVBRL58Wcu22ZQjt1l/6jmZOlRZuAWCJebM9WHBDAx/8CIl4LMRRpJZehAlVTzvHijVFCiDgxnRcew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=NEzRXQ4T; arc=fail smtp.client-ip=40.107.223.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/3EAslr+W4tYmJwfj8y65/890g25gwgt1JauRonMaxwB/PPr5BNv01k4lkTZpyBsKI3wxJ7iScpGD+d56SSVGZrJtmwaMsvGoVwsHssvYW2S1XuExgZ851I8bfAyplzbRkRrXb4rzXMUYasKoSYZPkdIullxudqmsajyl8vD4tZIgiUcnJGdYGnCyoAEYnGeZtmMxJ4z6YOdJ0kiKk0NRINN9rpMcUW29YankL+TcNCbmswMzYXnIgV/HGuAUYpEwB60GP99qVpzqq8U+h7J0PAZ8Fp7VsnHsklAMEWKbJdT9H6E31pxkH5HtzMOCkGbjfi42JxSvnQ+bo8VkO6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBw7Jlf9hlLwt6bIpDxe1PxCHf/ZqE9J3elmAhzZqV0=;
 b=AHigl4sIeyG/CBxN0dLvB8mWC3vlO7cP/NoALlBP447KKg3JwcIe52Nil0tkfepxPwlNxYQID9/8mvx5TnbhSBq+qVfxwxgdB9tgBULpZ8UgOinn69VIUePM90W4Hb50HZKvIMPcbvnJqnrDzrMxD4qmNefHgN8DVQm6cuCE6zlpjSQgDTRNC+LKexAM7sbt7zWZEA8FNZzy1Q6AnUfNkGfX0UseSDGnIJ5djBd0TRl03gCyg5WB6dPrApg6BUCrofH6UDCZcSfiMLQVSdyv5Mo5ahbDBkVYljhwtshnV4dAUA1dLc/z30R4+oKyiP6xECMgYwrhdJQDACEPD/hSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBw7Jlf9hlLwt6bIpDxe1PxCHf/ZqE9J3elmAhzZqV0=;
 b=NEzRXQ4T4I6H03/hTuZCEJsckTYdq9r2vr6DmL0UKZUxQfYMKz6rUJtag3HRpOI3T/wSMwaMVR8ge+SrmaKuig8eE5EvRzOB+8Csw9KbCNKnvKjyFhuqs5zexVlf2tbHZPiKNCNaEq9jfJzRDfYEwGNwt3Hejh5Q525hJVQ2kR8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4668.namprd13.prod.outlook.com (2603:10b6:610:ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 21:16:01 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::b349:9f81:ad39:865c%4]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 21:16:01 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "neilb@suse.de" <neilb@suse.de>
CC: "zhitao.li@smartx.com" <zhitao.li@smartx.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Restore -EIO as error to return when "umount -f"
 aborts request.
Thread-Topic: [PATCH] NFS: Restore -EIO as error to return when "umount -f"
 aborts request.
Thread-Index: AQHaafjC4+/NX6jkqka0/mDT/Cdqm7EgQrSA
Date: Wed, 28 Feb 2024 21:16:01 +0000
Message-ID: <81a96f8af0eb1b4d6ddaa44a451d8b2af4e7fa16.camel@hammerspace.com>
References: <170909199843.24797.6320949640369986924@noble.neil.brown.name>
In-Reply-To: <170909199843.24797.6320949640369986924@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH0PR13MB4668:EE_
x-ms-office365-filtering-correlation-id: e28bd789-24f6-47a2-661c-08dc38a276fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sKa457f8hhDwr0Ng1ES4pj8HkmkEybHyVv/W2m5WDyfWAocfgMb55cidDTwHV6Vv4qeF9om3FzrM22qCpCN7A9VhCtiqjFhwQf2oCRUIysYnPqRHefD37SL3wI5Gr0NDfgULlshIdFF+zP46cpDOHSp/D9U5miTQi8cQYeMhdDrMS7IBVbTE5nacHU1uTZNgLVXBq66fVp9govRif3S5mWlfvVRmBDIsJQ4F8UW5+PtU9WB+c4ESGHKEJo/oe8/tvoGfv7aPaV+zQlNjLE28dl8X+VmFlQAHwQZ4sIcWiOuhxfXG7XYzjyfhZ6AzuN+gH6O2vZLxok00HgMFZVI63RSz81YzHjP9yya6ut5ArFoONuZGWfzd9vqnt0h1Z4TNEHLLVu3GpvPYPn1EwD49iEYD8lZUZmv2LuqRxBrNdUIFonHNWoLBd9gGSEK+XRgYDjz3g8l0B2QqLs9Nx71jXULX2UBSRrSaW3eNnaxuTa1dXhKxIboRGse1n65OGrKHdHb7tgNRN3iUmzGbg5kBLLAasVITakt4XQApwu3bqlCmrowcCgzpX9sgQHchSMDPWCQ31bZBJOgn/0fLf6nNDKl4nwhbopGPI4NZJdQZaMTbSXU7fgl6oeXu5dFzlnKqUGC7a7kZjZCa3zSObD4sjCYGQYvWodw2UEhUpbO4vnw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WE5OQU5IT0FMekVlaDlCUlNGSS9LV2liY1lrOEVDQ0U1YUdNZThvc3UxOGVE?=
 =?utf-8?B?MUJCb1Rxd1ZuUzJwdTRQUU1MVkkxVVkyVzZBQ1FCRGs2QjJXamNRcXBjcytB?=
 =?utf-8?B?ekhqekd0YjJBTU04c1FUS0grZFFIYk12YnpveFNPUXlhbjVIUHlwYlRwV3Fh?=
 =?utf-8?B?QkRVOXZISTIzWUMzSWJsR3hRQUpSZVA0N0h4TmtOZWZBNGFwNmxlU0ZjL1hC?=
 =?utf-8?B?d2dPemdCR3lCRXNlUmtIVS8yM2pENzRwTDRwNGZiZTJnSVZqQ1JFa29mbG5G?=
 =?utf-8?B?YlNuUFRrNWozZFJOVGdWckRjNktnbDQ3WmhEQ2FqZm9qREwwUVZUZzlZdEtW?=
 =?utf-8?B?OXBRZVpJcUlWVWRVbGpHTjI4bU1rdngrcWVabXlsSEpjb3hoaW1NVVZnV2tw?=
 =?utf-8?B?SmFuMkMwWkNOQ0R2S05SQ0YxK1BpRFdUN3dMd2tHMjhvaEF3UTNIbTJZeE40?=
 =?utf-8?B?VEJMcDNLY1daem5wUlloYTcvUlFSL2JOL2s2M1dKQWl1SlNLRGozK1paVUNZ?=
 =?utf-8?B?VTZaYm5nU3pGMEhDZUFDdVcvMlBEellNWHg3OFpWNmJ3WEJFaklUVmx3VGV2?=
 =?utf-8?B?eU9NR0NUNStOSiszbG84dDkzcnplSVBEZjdlRE5odzBuTmlScEhUdUlIQSs1?=
 =?utf-8?B?NldqWWNucCtNZ3JJOEdyRHBYbzFTeHh0STVZSU0wNFgwUFQ5ZEQ2NTAzQzRq?=
 =?utf-8?B?KyswdW5sQnRSRlZrbUlkb2hGd29UdTRiemk0cUJ1dVA0eGI5aTNndmRhZ2VJ?=
 =?utf-8?B?VFlwMFpHV3VJTVc4eGowMXAvVWFBcG02WlF6dkdqbm1BU2duZUpONFBlSWwx?=
 =?utf-8?B?Ump2U1JsTjFTNFBhMTFzY0dYampSTG1oU09CekU0YmlBSTZLR0hCVHgrNHFZ?=
 =?utf-8?B?SU5EUytuRjdObGpTckF1OXd5L2tRcW9Zc1g5b0dHbHdlSTgwZkNjRURLd1BJ?=
 =?utf-8?B?eE05clJBSzFxMkJZcERPV2t0ZmdzU1krc0xKbXlKR1h3c1ZnNEM0Nmt5SUt1?=
 =?utf-8?B?SUNYc2Zlc1FzMWowbjloVHdNYVJud2JMdHlHSlNNTmJFV3dEd1p3d3RKODRp?=
 =?utf-8?B?MlN1MCtDV1ptNnlYZ2NPNmlNbHM4ZTc1SWhDYzNMQkZqS1hqRXVvOGI3OWU3?=
 =?utf-8?B?QzdKc0lsb3NnWkdYUXNtNHQ1dzZ4MUxjaEN5M3F6S1hjUzkyaWo5Ni9mZXBS?=
 =?utf-8?B?bW84N2NOOVhXTDZTMWVaVmluRmtWRGxYUElld0JjbTNJdHNadjUvRlBhN2xF?=
 =?utf-8?B?cnVHSkpPUE5xMDlLdTJqWGkrc3V6Y05BUms1b2dKQ21rNXNWWlM0YzBrZFJx?=
 =?utf-8?B?eitDUko3T1FMd0ZVcGZQd1h0RUtWR0tUSFd0OTFCNVRNSXV5U0Z2cFdHSVU0?=
 =?utf-8?B?czZMN0J1cngrS25vN0FjNWd4a1Z2V1Y1RjFSQ0FrMDlwZ2hOTFVMdGtrV2hk?=
 =?utf-8?B?SjBWK2gxYWJORm5hYjF3VHRJa3M1Y0VBSmxHV1VkYU1OZk1LWXpoVjE5U1hz?=
 =?utf-8?B?YWMxVWUyajlmemJpM25WSzRUZEJLeTdrQ3JDTEdrRUk1aFFGb1NVcTZHdnlV?=
 =?utf-8?B?WmgraFg1eVlRVGw2Y3ZtY0hHRnhzbWZPZ1M0K0tzYXREdWlVSS8ySkdxWm4w?=
 =?utf-8?B?aHhiLzBJYWVFZ0psaGptcGF2ME5BUDZlQ1dMMWthdkd3RmRkVnBHYlhqNnBq?=
 =?utf-8?B?a2NrcG5nQ1dRd09aTDJmcmM5NnZod0l2NEZucVA0Y0o5TVhjZEVBTVZUa3Zi?=
 =?utf-8?B?RzErNXEraXVKdlVraU93QUxhb0piMGM0TVp2T2VFVjVpbjdyU3dNZDd5Z082?=
 =?utf-8?B?ZlVoak5nZVpJRytHaGJ6UXNOTE5LRndVcFBvM2x2NmxPQUJ2YXBQeHVwZXRB?=
 =?utf-8?B?VnhsdGZwTFBuV2ZyYXdrS1VSZTRFQlQ2Rk9LVUZ0UnNObThtbG16cHZPSDR5?=
 =?utf-8?B?MmVrRmpDWFJoWUg5V3dLYTJPSVd3dHhrNFpaSkNYVVhGOUx5U1dyNnVoSEtQ?=
 =?utf-8?B?R3U4SDdWQWRDeGNVVW55RGFFUWdNNTl2aHZXWG1nRStXdzRKV1piUVFDUmdm?=
 =?utf-8?B?ZzBtUW4weHFoM0JpVk9kbzJacFhjbnRkL1dsR29kcDRKa1hBdVcwekpUMDNh?=
 =?utf-8?B?ckZ3OG80bnhLODVnZVdYSUV6Mmh0SnB4T0NaK2wvNVRneUhSUHViTjlHL0JB?=
 =?utf-8?B?LzZMcW1VVWVNcFd6T2NUWjlWUjlXOFM5ei82dExxRHZhb2dSWXVPbWVwdDV4?=
 =?utf-8?B?T2paNWFyUUZEUjJxSEhxN0lhK2xRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC067C22EC089A48807C61AD68E3EEBD@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e28bd789-24f6-47a2-661c-08dc38a276fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 21:16:01.1335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wru3U7fb7TRU1J/OtduGcyEgopDcd9XOGn8B8yNUu1652FD7U2D6/9e8SDYWRuRSjLceLbG0GpExXHeOCwVBjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4668

T24gV2VkLCAyMDI0LTAyLTI4IGF0IDE0OjQ2ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiBXaGVuICJ1bW91bnQgLWYiIGlzIHVzZWQgdG8gYWJvcnQgYWxsIG91dHN0YW5kaW5nIHJlcXVl
c3RzIG9uIGFuIE5GUw0KPiBtb3VudCwgc29tZSBwZW5kaW5nIHN5c3RlbWNhbGxzIGNhbiBiZSBl
eHBlY3RlZCB0byByZXR1cm4gYW4gZXJyb3IuDQo+IEN1cnJlbnRseSB0aGlzIGVycm9yIGlzIEVS
RVNUQVJUU1lTIHdoaWNoIHNob3VsZCBuZXZlciBiZSBleHBvc2VkIHRvDQo+IGFwcGxpY2F0aW9u
cyAoaXQgc2hvdWxkIG9ubHkgYmUgcmV0dXJuZWQgZHVlIHRvIGEgc2lnbmFsKS4NCj4gDQo+IFBy
aW9yIHRvIExpbnV4IHY1LjIgRUlPIHdvdWxkIGJlIHJldHVybmVkIGluIHRoZXNlIGNhc2VzLCB3
aGljaCBpdCBpcw0KPiBtb3JlIGxpa2VseSB0aGF0IGFwcGxpY2F0aW9ucyB3aWxsIGhhbmRsZS4N
Cj4gDQo+IFRoaXMgcGF0Y2ggcmVzdG9yZXMgdGhhdCBiZWhhdmlvdXIgc28gRUlPIGlzIHJldHVy
bmVkLg0KPiANCj4gUmVwb3J0ZWQtYW5kLXRlc3RlZC1ieTogWmhpdGFvIExpIDx6aGl0YW8ubGlA
c21hcnR4LmNvbT4NCj4gQ2xvc2VzOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1u
ZnMvQ0FQS2pqbnJZdnpIOGhFazlib2FCdC1mRVRYM1ZEMmNqak4tWjZpTmd3WnBIcVlVald3QG1h
aWwuZ21haWwuY29tLw0KPiBGaXhlczogYWU2N2JkMzgyMWJiICgiU1VOUlBDOiBGaXggdXAgdGFz
ayBzaWduYWxsaW5nIikNCj4gU2lnbmVkLW9mZi1ieTogTmVpbEJyb3duIDxuZWlsYkBzdXNlLmRl
Pg0KPiAtLS0NCj4gwqBpbmNsdWRlL2xpbnV4L3N1bnJwYy9zY2hlZC5oIHwgMiArLQ0KPiDCoG5l
dC9zdW5ycGMvY2xudC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0NCj4gwqBuZXQvc3Vu
cnBjL3NjaGVkLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDYgKysrLS0tDQo+IMKgMyBmaWxlcyBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9zdW5ycGMvc2NoZWQuaA0KPiBiL2luY2x1ZGUvbGludXgvc3VucnBj
L3NjaGVkLmgNCj4gaW5kZXggMmQ2MTk4N2IzNTQ1Li5lZDNhMTE2ZWZkNWQgMTAwNjQ0DQo+IC0t
LSBhL2luY2x1ZGUvbGludXgvc3VucnBjL3NjaGVkLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9z
dW5ycGMvc2NoZWQuaA0KPiBAQCAtMjIyLDcgKzIyMiw3IEBAIHZvaWQJCXJwY19wdXRfdGFzayhz
dHJ1Y3QgcnBjX3Rhc2sNCj4gKik7DQo+IMKgdm9pZAkJcnBjX3B1dF90YXNrX2FzeW5jKHN0cnVj
dCBycGNfdGFzayAqKTsNCj4gwqBib29sCQlycGNfdGFza19zZXRfcnBjX3N0YXR1cyhzdHJ1Y3Qg
cnBjX3Rhc2sgKnRhc2ssIGludA0KPiBycGNfc3RhdHVzKTsNCj4gwqB2b2lkCQlycGNfdGFza190
cnlfY2FuY2VsKHN0cnVjdCBycGNfdGFzayAqdGFzaywgaW50DQo+IGVycm9yKTsNCj4gLXZvaWQJ
CXJwY19zaWduYWxfdGFzayhzdHJ1Y3QgcnBjX3Rhc2sgKik7DQo+ICt2b2lkCQlycGNfc2lnbmFs
X3Rhc2soc3RydWN0IHJwY190YXNrICosIGludCk7DQo+IMKgdm9pZAkJcnBjX2V4aXRfdGFzayhz
dHJ1Y3QgcnBjX3Rhc2sgKik7DQo+IMKgdm9pZAkJcnBjX2V4aXQoc3RydWN0IHJwY190YXNrICos
IGludCk7DQo+IMKgdm9pZAkJcnBjX3JlbGVhc2VfY2FsbGRhdGEoY29uc3Qgc3RydWN0IHJwY19j
YWxsX29wcyAqLA0KPiB2b2lkICopOw0KPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy9jbG50LmMg
Yi9uZXQvc3VucnBjL2NsbnQuYw0KPiBpbmRleCBjZGEwOTM1YTY4YzkuLmNkYmRmYWUxMzAzMCAx
MDA2NDQNCj4gLS0tIGEvbmV0L3N1bnJwYy9jbG50LmMNCj4gKysrIGIvbmV0L3N1bnJwYy9jbG50
LmMNCj4gQEAgLTg5NSw3ICs4OTUsNyBAQCB2b2lkIHJwY19raWxsYWxsX3Rhc2tzKHN0cnVjdCBy
cGNfY2xudCAqY2xudCkNCj4gwqAJdHJhY2VfcnBjX2NsbnRfa2lsbGFsbChjbG50KTsNCj4gwqAJ
c3Bpbl9sb2NrKCZjbG50LT5jbF9sb2NrKTsNCj4gwqAJbGlzdF9mb3JfZWFjaF9lbnRyeShyb3Zy
LCAmY2xudC0+Y2xfdGFza3MsIHRrX3Rhc2spDQo+IC0JCXJwY19zaWduYWxfdGFzayhyb3ZyKTsN
Cj4gKwkJcnBjX3NpZ25hbF90YXNrKHJvdnIsIC1FSU8pOw0KDQpycGNfa2lsbGFsbF90YXNrcygp
IGlzIGNhbGxlZCBieSBycGNfc2h1dGRvd25fY2xpZW50KCkuIEl0IGlzIG5vdA0Kb2J2aW91cyB0
byBtZSB0aGF0IEVJTyBpcyBhbiBhcHByb3ByaWF0ZSByZXR1cm4gdmFsdWUgaW4gYWxsIHRoZSBj
YXNlcw0Kd2hlcmUgdGhhdCBpcyBiZWluZyBjYWxsZWQuDQoNCklmIHdlJ3JlIGdvaW5nIHRvIHJl
cGxhY2UgRVJFU1RBUlRTWVMsIHRoZW4gd2h5IHdvdWxkIHdlIG5vdCB3YW50IHRvIGdvDQpmb3Ig
RUlOVFI/DQoNCj4gwqAJc3Bpbl91bmxvY2soJmNsbnQtPmNsX2xvY2spOw0KPiDCoH0NCj4gwqBF
WFBPUlRfU1lNQk9MX0dQTChycGNfa2lsbGFsbF90YXNrcyk7DQo+IGRpZmYgLS1naXQgYS9uZXQv
c3VucnBjL3NjaGVkLmMgYi9uZXQvc3VucnBjL3NjaGVkLmMNCj4gaW5kZXggNmRlYmY0ZmQ0MmQ0
Li5lNGYzNmZlMTY4MDggMTAwNjQ0DQo+IC0tLSBhL25ldC9zdW5ycGMvc2NoZWQuYw0KPiArKysg
Yi9uZXQvc3VucnBjL3NjaGVkLmMNCj4gQEAgLTg1MiwxNCArODUyLDE0IEBAIHZvaWQgcnBjX2V4
aXRfdGFzayhzdHJ1Y3QgcnBjX3Rhc2sgKnRhc2spDQo+IMKgCX0NCj4gwqB9DQo+IMKgDQo+IC12
b2lkIHJwY19zaWduYWxfdGFzayhzdHJ1Y3QgcnBjX3Rhc2sgKnRhc2spDQo+ICt2b2lkIHJwY19z
aWduYWxfdGFzayhzdHJ1Y3QgcnBjX3Rhc2sgKnRhc2ssIGludCBlcnIpDQo+IMKgew0KPiDCoAlz
dHJ1Y3QgcnBjX3dhaXRfcXVldWUgKnF1ZXVlOw0KPiDCoA0KPiDCoAlpZiAoIVJQQ19JU19BQ1RJ
VkFURUQodGFzaykpDQo+IMKgCQlyZXR1cm47DQo+IMKgDQo+IC0JaWYgKCFycGNfdGFza19zZXRf
cnBjX3N0YXR1cyh0YXNrLCAtRVJFU1RBUlRTWVMpKQ0KPiArCWlmICghcnBjX3Rhc2tfc2V0X3Jw
Y19zdGF0dXModGFzaywgZXJyKSkNCj4gwqAJCXJldHVybjsNCj4gwqAJdHJhY2VfcnBjX3Rhc2tf
c2lnbmFsbGVkKHRhc2ssIHRhc2stPnRrX2FjdGlvbik7DQo+IMKgCXNldF9iaXQoUlBDX1RBU0tf
U0lHTkFMTEVELCAmdGFzay0+dGtfcnVuc3RhdGUpOw0KPiBAQCAtOTkyLDcgKzk5Miw3IEBAIHN0
YXRpYyB2b2lkIF9fcnBjX2V4ZWN1dGUoc3RydWN0IHJwY190YXNrICp0YXNrKQ0KPiDCoAkJCSAq
IGNsZWFuIHVwIGFmdGVyIHNsZWVwaW5nIG9uIHNvbWUgcXVldWUsIHdlDQo+IGRvbid0DQo+IMKg
CQkJICogYnJlYWsgdGhlIGxvb3AgaGVyZSwgYnV0IGdvIGFyb3VuZCBvbmNlDQo+IG1vcmUuDQo+
IMKgCQkJICovDQo+IC0JCQlycGNfc2lnbmFsX3Rhc2sodGFzayk7DQo+ICsJCQlycGNfc2lnbmFs
X3Rhc2sodGFzaywgLUVSRVNUQVJUU1lTKTsNCj4gwqAJCX0NCj4gwqAJCXRyYWNlX3JwY190YXNr
X3N5bmNfd2FrZSh0YXNrLCB0YXNrLT50a19hY3Rpb24pOw0KPiDCoAl9DQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

