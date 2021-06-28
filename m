Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8823B68D8
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 21:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhF1TMF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 15:12:05 -0400
Received: from mail-mw2nam10on2137.outbound.protection.outlook.com ([40.107.94.137]:9089
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233962AbhF1TME (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 28 Jun 2021 15:12:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ftaa6sSpVlfsP5B/cL//dbDQbTkZPl4BCmG0htjAz2ThJ/Qejh6VQ4xqutB6AmUiYNB3qhy+l+U7cgr16gzlk1/tQrf9a9Ex3GbwaPdm7JXlSdzi758wWMw0CiWDUdI9SQ2frSmH1BjSAYmishTGkL5i75wqgf09SVCvC7i2rRtltlOerkLBnE/N3HNLQ/WefIo/FBdMS3e/u1Txlpb1IM864qIdKQxtqa1RV1rIMX6XaejC2XSD8qamywhnMcQpZuv3RgfqLAifFoOxgubbMq4eQXQfXbI3KGXHuNc6wO/O0DfiYf7VLXKurZe7ghdURQCdTJ2NHS7ElO8E5CEdww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZUcYOP24gHQFrK35ZghpUe5EtHe/TaBWPgyoXitbFw=;
 b=apKgsBjY/e6QhnmpsvNudrYzR3FLahKoo+8sIl3A6UPVrkBRYHW93u1luu0Yb7fSMDHKOrahkMM6AnW1NvMEbxn1bPGG96DltmVCDTHDU9KCmwMsmbQ5vGlbfeKz8u+gzbW+gvj+5oC6qRMrOmO7CUY90mnM90JpudyEdN8+VRKPXsrBy33pFCtpC4r2YUZ8EDMU/YW5FRJ7CpbyQ2k9EMJ2usgx2mFa70MayNGZBdlsBtNaPLJ+orjx/2KTOrOwGKgCdAoYp3G5OyougfHqzIptnZt9O0OnjD9vboYPSsrEEacutbj2Ix8byb9qwYYy5HtVOakiVrwVhmHJ1qurfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZUcYOP24gHQFrK35ZghpUe5EtHe/TaBWPgyoXitbFw=;
 b=gNiEWKxYiUNEOOfZkD8EeClQEU7trScqEv7OyHJ6I2wITVw3056FVetfH86ataCHZMWXAZx0K9A8x+tmgf4G2Y4PLm3MrKSqucZpcFpAwT7ZFrsiw5qsrkZRbmmgLT6w6LEMN+xpRrR0OgwwVmbvJv9NMq+CjeuknUg76pkqcKc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4410.namprd13.prod.outlook.com (2603:10b6:610:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.15; Mon, 28 Jun
 2021 19:09:36 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05%4]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 19:09:36 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 4/4] NFS: Fix fscache read from NFS after cache error
Thread-Topic: [PATCH 4/4] NFS: Fix fscache read from NFS after cache error
Thread-Index: AQHXbESDVNEfZ6l1Z0mr+wlKyxwP6KspybkA
Date:   Mon, 28 Jun 2021 19:09:35 +0000
Message-ID: <efc373dd3f321f2f45e749a5edb383f2a11a7b78.camel@hammerspace.com>
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
         <1624901943-20027-5-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1624901943-20027-5-git-send-email-dwysocha@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4defc939-eacd-4163-3658-08d93a68452a
x-ms-traffictypediagnostic: CH2PR13MB4410:
x-microsoft-antispam-prvs: <CH2PR13MB4410027D88E16C49A9310FB4B8039@CH2PR13MB4410.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qwFCeLGKsp3ZR1anBpX+HexjG8D5jVWvvHU183Bqx97R1hQvjf553pcI4fXnWpFkoDh5Wdc6V6Q2pYyXFLJOM/Gr3zs8eIswCq+I/6HTHjOW6JGX7xP/dnyqwnzzw/8Q/zfTMjx3bOG5ZZLlGXBdma+aI6DCHRQ5E/t4YXU60/Pp3ZJEa36rhAbNLkJq5uM0M68/wADaQJn4xNO36DPYndkgiMRQDhyuxWkcUmFPcXS/NSyHM6VIQBmeVSIcVJ2DaRFpLbh8gVJT1foo7blTjgxDVW7EXGIBy7cYmTB+Q4hbwFT/eJ2tl2JFtbweuzMgOilVTO0MNHXfJ5684RnvGbck9GfbE8nYnAs1lZoJbUMujWtZpxLIlTru3RMUa32pYNTCsSs0Ymu8KM5w5WCIeOQZTAoC++2c3tF5aKYtl1g6fNvpMXNRxRZcQfD46Mmbeh0l4wkJqbA/bZU1TUpPCn5cHO3GPzim6X48cixJqt5GwXN5wmCKVFDyR8dJvWnIpDBXV6JYSq1p7szVyprMBD4z8VbJmRw/13nR/dMBofBECWu4mfjn/mrl29VICbdgbpDePKEworhuEFxS8Of9IdhnA7LY/6zsncVL0KlCiB0alhiQSNc9jpUZpJXzCNJNYH22bOZUJTNQxmg2Mt8OUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(366004)(39840400004)(346002)(76116006)(6506007)(186003)(6512007)(86362001)(110136005)(122000001)(38100700002)(64756008)(8936002)(4326008)(66446008)(8676002)(2906002)(66946007)(2616005)(478600001)(71200400001)(66476007)(36756003)(6486002)(83380400001)(26005)(316002)(66556008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejFGekhGQ1dlaDkyWHNPQ0lJRE5yRnB0UmpQOWE0QUs0aUQ5V2RLd2ZUMFJ3?=
 =?utf-8?B?MVZCb3lyUmdFb0kxUXd5RllMK3MwVHl6N0p1U3N6T3owUFJNUXAvcXlKVXFv?=
 =?utf-8?B?SHVvWWlON3RjTjBzYUxkUU1rQlZEYzYxRzhWaHN0ZmdqajcxK1dpQjZ0QnRG?=
 =?utf-8?B?cG9JRVFjNFJzVzRDa2VxZXJaTFZXWnExY2hXZDV1ZHFQSWhGcHNmR2MxVkJN?=
 =?utf-8?B?MGd4RU44M1ZIWVZ0bE9aZEJ2N2RTbCt0cDE2U3V4dHArYy9IK0Zpd3RlOVRO?=
 =?utf-8?B?bTlCdmF5cWJHUVdFTE1OQ01ZU3dJT0liS09FeGxVTTdHZmMwU3IrTngzVGhM?=
 =?utf-8?B?aFUvZzAvRDNUS0dxT0NBOWpIQ05WWUE0N3ZSRjBIcWE2UEJjMGVyLzZGZklG?=
 =?utf-8?B?MmZKc0ZLUVFDcTJNR3ExTVVGS3hra1NmL2JabTc2VlBrUEV3a0h6alFua0Nw?=
 =?utf-8?B?Mm1RRDNFM1JlZ0pUTG1kYkcvYVBXNTk2Zmp5RERBZFJ4cHdLOFdwYjZiZDRH?=
 =?utf-8?B?Wk5xSkl0SC83K291L0orZGlpWVVuN2dpanphWklMZlUvd3ZvZmNURjRKRHpi?=
 =?utf-8?B?UlR1Q2VKclZuZGZ4OXlrREZyalFNaWl3MXVlSXBHUlBGdkF4am1nWXFxcFYw?=
 =?utf-8?B?dVZPcTVLbENJbkVxODd0cFNydVh2N1lDWHVRa1lyc096QlhwWURQYzB1d3NL?=
 =?utf-8?B?WTNkYTBrZkRMekR2M2hpRWpOYmFMcXYrSXR5d2ZobUFDaTdsMWVnRUFnYTNO?=
 =?utf-8?B?UTNKeTdBTGYvTEZUWEhDU09zcG50ekJVbU5PNXNISFJEU0M2bVFqSnNjQmJa?=
 =?utf-8?B?REtHTmdpZ01RNkVkVmlQSnozUURDbFFIN2k5dmhUZkpNSzUvM0g1QUVMRUpO?=
 =?utf-8?B?c3ErMERoM2ozNllacEkwT1ppVVNhZ1UzOUhBenNrcTZ3Q1pUUWtPZEN2N1JJ?=
 =?utf-8?B?SHJ1R3BBdDdFS1RCcGltenpXR1lMNnZlUzFGSWk3aE92UjE2VDVMeTdkOFd5?=
 =?utf-8?B?Q0toY0wrVEFTc3M0cXp1UndyTk1QRzR0SVRudXdZMXJPOGp5dUo4U244NzM2?=
 =?utf-8?B?ZHpmV2I2VjZzMzJFdkdYaHgwSVRQTmlCaUxEd3IwMkZSV2dzeWxJaEkremtv?=
 =?utf-8?B?blVIVWFHc2FwQ3YvSkxqTnd2VWl2cUlKZS9IMlJaYVAwdFp4S2F2WWdKTVdp?=
 =?utf-8?B?Qmd1SVlzYnVxZ05reXE4aWdGNGRFbFYzeUZLR0hPcUxEbzI5disrK2U0VXoz?=
 =?utf-8?B?TEZ3d3NKeG0wSTdkUnM3K2tYY2RuZ0JxZVBlK0YwV0o4ZEpaenFZdEpZeUZq?=
 =?utf-8?B?U2dwSm1vbWZ6cXFtRStTd1E0aGVPYjRkYnVFWm1FRW81OStmV3NXaFd1UnU4?=
 =?utf-8?B?UTdpMlJDSGRRejRJTS9GT0FrOHBSbnE4dE5NQXg5QWtFMVBLZVFERzEyVi9v?=
 =?utf-8?B?NTI5S0NyckVNeWRGaFpiKzJWRE1zOGtPRnBGNHppUXNEd3V2a2RWNk85THk4?=
 =?utf-8?B?ci92YWMvS3h2SElxbUlmdGRTWjZaRG1HU2s3ZUt2emM4MFVCWUlxdktBdGc0?=
 =?utf-8?B?ZnQ0dWZaMnZHQmNleU1CWGk2MmZJRHJteTVva2FNQzFidXkwK2xhL24ySU5p?=
 =?utf-8?B?OE5MaWtJUEhqY2N3TFl0cXFIa2RIL0Q3TWlZNzBOQnVoa0JubG9Pek0wZ3hC?=
 =?utf-8?B?NmdCUjZXaHM0bnVhMDVsM2MrWi9ReTNpdEdLQU5hN1ZySzZaYyszMWE2enNG?=
 =?utf-8?Q?e9AZuqlKoYL62uK5kB7/oc0dCIR/riIDZSIcWQp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <172D463449A48547801B32C1477E8D3E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4defc939-eacd-4163-3658-08d93a68452a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 19:09:36.0392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwrtSVY46aWe9xtUuLC8WBPNHklOiwFp7loPa/izr9jPPuNgtsSkULb06lb/fZc97wxHybN8NkLB7ZA5JQqWlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4410
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTI4IGF0IDEzOjM5IC0wNDAwLCBEYXZlIFd5c29jaGFuc2tpIHdyb3Rl
Og0KPiBFYXJsaWVyIGNvbW1pdHMgcmVmYWN0b3JlZCBzb21lIE5GUyByZWFkIGNvZGUgYW5kIHJl
bW92ZWQNCj4gbmZzX3JlYWRwYWdlX2FzeW5jKCksIGJ1dCBuZWdsZWN0ZWQgdG8gcHJvcGVybHkg
Zml4dXANCj4gbmZzX3JlYWRwYWdlX2Zyb21fZnNjYWNoZV9jb21wbGV0ZSgpLsKgIFRoZSBjb2Rl
IHBhdGggaXMNCj4gb25seSBoaXQgd2hlbiBzb21ldGhpbmcgdW51c3VhbCBvY2N1cnMgd2l0aCB0
aGUgY2FjaGVmaWxlcw0KPiBiYWNraW5nIGZpbGVzeXN0ZW0sIHN1Y2ggYXMgYW4gSU8gZXJyb3Ig
b3Igd2hpbGUgYSBjb29raWUNCj4gaXMgYmVpbmcgaW52YWxpZGF0ZWQuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBEYXZlIFd5c29jaGFuc2tpIDxkd3lzb2NoYUByZWRoYXQuY29tPg0KPiAtLS0NCj4g
wqBmcy9uZnMvZnNjYWNoZS5jIHwgMTQgKysrKysrKysrKysrLS0NCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9m
cy9uZnMvZnNjYWNoZS5jIGIvZnMvbmZzL2ZzY2FjaGUuYw0KPiBpbmRleCBjNGMwMjFjNmViYmQu
LmQzMDhjYjdlMWRkNCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL2ZzY2FjaGUuYw0KPiArKysgYi9m
cy9uZnMvZnNjYWNoZS5jDQo+IEBAIC0zODEsMTUgKzM4MSwyNSBAQCBzdGF0aWMgdm9pZA0KPiBu
ZnNfcmVhZHBhZ2VfZnJvbV9mc2NhY2hlX2NvbXBsZXRlKHN0cnVjdCBwYWdlICpwYWdlLA0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lkICpjb250ZXh0LA0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgZXJyb3IpDQo+IMKgew0KPiArwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgbmZzX3JlYWRkZXNjIGRlc2M7DQo+ICvCoMKgwqDCoMKgwqDCoHN0
cnVjdCBpbm9kZSAqaW5vZGUgPSBwYWdlLT5tYXBwaW5nLT5ob3N0Ow0KPiArDQo+IMKgwqDCoMKg
wqDCoMKgwqBkZnByaW50ayhGU0NBQ0hFLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAiTkZTOiByZWFkcGFnZV9mcm9tX2ZzY2FjaGVfY29tcGxldGUNCj4gKDB4JXAvMHglcC8l
ZClcbiIsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhZ2UsIGNvbnRleHQs
IGVycm9yKTsNCj4gwqANCj4gLcKgwqDCoMKgwqDCoMKgLyogaWYgdGhlIHJlYWQgY29tcGxldGVz
IHdpdGggYW4gZXJyb3IsIHdlIGp1c3QgdW5sb2NrIHRoZQ0KPiBwYWdlIGFuZCBsZXQNCj4gLcKg
wqDCoMKgwqDCoMKgICogdGhlIFZNIHJlaXNzdWUgdGhlIHJlYWRwYWdlICovDQo+IMKgwqDCoMKg
wqDCoMKgwqBpZiAoIWVycm9yKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
U2V0UGFnZVVwdG9kYXRlKHBhZ2UpOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHVubG9ja19wYWdlKHBhZ2UpOw0KPiArwqDCoMKgwqDCoMKgwqB9IGVsc2Ugew0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVzYy5jdHggPSBjb250ZXh0Ow0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgbmZzX3BhZ2Vpb19pbml0X3JlYWQoJmRlc2MucGdpbywgaW5v
ZGUsIGZhbHNlLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmbmZzX2FzeW5jX3JlYWRfY29tcGxldGlvbl9v
cHMpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyb3IgPSByZWFkcGFnZV9h
c3luY19maWxsZXIoJmRlc2MsIHBhZ2UpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKGVycm9yKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybjsNCg0KVGhpcyBjb2RlIHBhdGggY2FuIGNsZWFybHkgZmFpbCB0b28uIFdo
eSBjYW4gd2Ugbm90IGZpeCB0aGlzIGNvZGUgdG8NCmFsbG93IGl0IHRvIHJldHVybiB0aGF0IHJl
cG9ydGVkIGVycm9yIHNvIHRoYXQgd2UgY2FuIGhhbmRsZSB0aGUNCmZhaWx1cmUgY2FzZSBpbiBu
ZnNfcmVhZHBhZ2UoKSBpbnN0ZWFkIG9mIGRlYWQtZW5kaW5nIGhlcmU/DQoNCj4gKw0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmZzX3BhZ2Vpb19jb21wbGV0ZV9yZWFkKCZkZXNj
LnBnaW8pOw0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiDCoH0NCj4gwqANCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
