Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038112B3C17
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Nov 2020 05:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgKPE2C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 15 Nov 2020 23:28:02 -0500
Received: from mail-dm6nam11on2098.outbound.protection.outlook.com ([40.107.223.98]:35876
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbgKPE2B (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 15 Nov 2020 23:28:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Waliw4CtdpTQMER7tEoFKj1JiE3jota1SsVYvjxDNb2rUEpRTrr1KXGQzm3/G1JBrbZjNnWjoixqI4ZxRULomLIwgzZwymr+rk7DTwA4LHofnM6yUoai8aT3y3VGSIISVvF2hx7IdFscdBEUxYJNIF7ZiDUcxNj4huMjM1tGjdDqUkJJz1/zJqjIhPZTXWH11VA9jdIlgh6GokXaNP/BLUEpuK8lcrG6vVI19xZmYNXNd7RMbj/ix1vZU+b9txlH/MaRgCOKOWT5uWjcpISHgSd4cifWpLNU4ILmlZIdUG4Jw1d65TWL4VNP2DnRyyMfXVCZRjs3JOVLBSEQ4c5M4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MspzVjq93QjyCaeqRmyvoLSNbRfR8fqg1V7hCrNxzwE=;
 b=dTqPodfcQEjA1hSlaH/PzPHDiX8IoB16MnGl2qfg4reSi/e6kBq7m6bG+4n4+Hj5OVnWVeNQIo0EnEEPl1BGv+9nWDiu8DfRiYYNdUQmCJgTm/L3Fd3xwAF7gHUQiaU6OQZm03U62tnE5Xsnm0IHtAW1z+B2kq4gW2UzZrpGTpXhMQphNWoaK68mIZfLNQPYaVfCNvQrZfg2z/ncueSOqXTg8ef8gK4o2BbGiRD7cYFF5MRmQRmpw+19LgV1GW5PNj3eEinGeJSmWavTpTY2OI+/jm/8YDcKPw68HdFNM99A/mG/YEjoJbbZ7ivr3+4TND92NWJXDoPu7AWyXa9eOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MspzVjq93QjyCaeqRmyvoLSNbRfR8fqg1V7hCrNxzwE=;
 b=TnHPVN2kH85T48Yj9c4nAkK1r1g+lM3+N6vSBP0woUNZyoXOAhuAzyzKvkSrANEmXL0YgGKU+4isJbcCjxD3m1G4PyEA8W6Lw2F7eYkwwM2gXNeB3/7IFkjDH08tocHRBIJWiihdOkSMAh3AK3zJloPXLSqOPvr6nqFjC6uvkLw=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3407.namprd13.prod.outlook.com (2603:10b6:208:163::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.16; Mon, 16 Nov
 2020 04:27:56 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3589.016; Mon, 16 Nov 2020
 04:27:56 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS: only invalidate dentrys that are clearly invalid.
Thread-Topic: [PATCH] NFS: only invalidate dentrys that are clearly invalid.
Thread-Index: AQHWu8R1m5j20T9EEUSCuq70JTb/pqnKKisA
Date:   Mon, 16 Nov 2020 04:27:55 +0000
Message-ID: <d2fabd4b78dda3bd52519b84f50785dbcc2d40fb.camel@hammerspace.com>
References: <87361aovm3.fsf@notabene.neil.brown.name>
In-Reply-To: <87361aovm3.fsf@notabene.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75c589b1-b893-42bc-1e83-08d889e7fdbe
x-ms-traffictypediagnostic: MN2PR13MB3407:
x-microsoft-antispam-prvs: <MN2PR13MB3407EDA39BF4237137975C26B8E30@MN2PR13MB3407.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DoaBbY2nnMQ6elcF9cinXsfX7BXTPyWmqMmBsuRJxIHJCDYWa1+7z7+RausIX94YzzUZd4tHT3nHpa9p/sgWpn3VVLcuCzHxFjoez1XdXpmbHzHnAWMeMX3FXwJfW7CryCQfiR1HdXjI7YTnCGQv7ocEWBc4K804junsD8y8C5gmVgPVIKpmo1N+uBkCIUwrttSAYV/o79wZqsFVT36EDIR9MDSYbLDq0ztEJbF2617ky1byIpKJ528+FFI3AoXGFxKLPYAsihniFtWSaeUmsNiSp1adPokRWczWzq5HWpmjhHgiwih1UtmhcaAqUVvPtEJxaMGfmfjabNd83TXhUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(136003)(376002)(346002)(366004)(36756003)(8676002)(6506007)(8936002)(86362001)(110136005)(6486002)(4326008)(316002)(54906003)(2616005)(83380400001)(71200400001)(478600001)(4001150100001)(66476007)(6512007)(186003)(76116006)(91956017)(64756008)(66446008)(66556008)(66946007)(2906002)(26005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nJTw/yNccXllqboPWDvxv/IzHjuPiXGkC6SuoLiQDP8ws1qLGccB3oeIOaIrQtoTP4tuj8oP51NY25DVAaij2HZo3aG1ItDwYE08VSra88uoUuTy7uFpH5LEqtcD5NuH545Bt6fc7D/kUV5KWheztl8jDJJy4xK1AjV8FwoL2S3mct5q1uaE3itxAxMpLv16IKaKBS9LSZGtvC641ds9mbf0u/BZZXD5+lIJBr2EVTI56T8kIwdlModUT4jzXPOwVAu8WZZ6OoWsoWcWr8lgSXBXuvbzEhPcN8XNNSO7Onb7XR7jhJ+AzTpoQMTDjsDsPUqTyEGuVUYKfUcLBnkjNOkTjllDoCydTHisncLOCquLPTSM22yFlwsuVg+HLx2BhaoMpSn7JZ2APiE3oA5nKfKdqZlooQqEaLGANl0p5TW6TATGE4WpkREWm9h7h0ykI9n5esbRO5fNCC5FOfurV3Ta2dzmrsDJ0GwK/MePrtaPKSSyniC7ZjoX5RPmqOPLCdr2qbLhjRmnSRCi/H4BduHAxl/5jzxaPQivvrpBF+MbJfba8r9YdB/Vo7V5P8PUQ6lG3LHQdZ+Z2WIrXsDPuqdCDqi0bGKNrKCz0e6Oh7QRaVcgPg6eYdb9UE7/27iAB0m89Su3yHxg2b+jWVkUlw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <810355CD3A125A4EBA6781ECB9B060AF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c589b1-b893-42bc-1e83-08d889e7fdbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 04:27:55.9634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AO2/qh6ZtwI6B36YXqC/7tcoXg3feBBFBjH506uXYSpbydRy7RbKDkZAUlvdb9lUc5t+Mbs3KkKvdjrDYFV/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3407
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTE2IGF0IDEzOjU5ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiBQcmlvciB0byBjb21taXQgNWNlYjlkN2ZkYWFmICgiTkZTOiBSZWZhY3Rvcg0KPiBuZnNfbG9v
a3VwX3JldmFsaWRhdGUoKSIpDQo+IGFuZCBlcnJvciBmcm9tIG5mc19sb29rdXBfdmVyaWZ5X2lu
b2RlKCkgb3RoZXIgdGhhbiAtRVNUQUxFIHdvdWxkDQo+IHJlc3VsdA0KPiBpbiBuZnNfbG9va3Vw
X3JldmFsaWRhdGUoKSByZXR1cm5pbmcgdGhhdCBlcnJvciBjb2RlICgtRVNUQUxFIGlzDQo+IG1h
cHBlZA0KPiB0byB6ZXJvKS4NCj4gU2luY2UgdGhhdCBjb21taXQsIGFsbCBlcnJvcnMgcmVzdWx0
IGluIHplcm8gYmVpbmcgcmV0dXJuZWQuDQo+IA0KPiBXaGVuIG5mc19sb29rdXBfcmV2YWxpZGF0
ZSgpIHJldHVybnMgemVybywgdGhlIGRlbnRyeSBpcyBpbnZhbGlkYXRlZA0KPiBhbmQsIHNpZ25p
ZmljYW50bHksIGlmIHRoZSBkZW50cnkgaXMgYSBkaXJlY3RvcnkgdGhhdCBpcyBtb3VudGVkIG9u
LA0KPiB0aGF0IG1vdW50cG9pbnQgaXMgbG9zdC4NCj4gDQo+IElmIHlvdToNCj4gwqAtIG1vdW50
IGFuIE5GUyBmaWxlc3lzdGVtIHdoaWNoIGNvbnRhaW5zIGEgZGlyZWN0b3J5DQo+IMKgLSBtb3Vu
dCBzb21ldGhpbmcgKGUuZy4gdG1wZnMpIG9uIHRoYXQgZGlyZWN0b3J5DQo+IMKgLSB1c2UgaXB0
YWJsZXMgKG9yIHNjaXNzb3JzKSB0byBibG9jayB0cmFmZmljIHRvIHRoZSBzZXJ2ZXINCj4gwqAt
IGxzIC1sIHRoZS1tb3VudGVkLW9uLWRpcmVjdG9yeQ0KPiDCoC0gaW50ZXJydXB0IHRoZSAnbHMg
LWwnDQo+IHlvdSB3aWxsIGZpbmQgdGhhdCB0aGUgZGlyZWN0b3J5IGhhcyBiZWVuIHVubW91bnRl
ZC4NCj4gDQo+IFRoaXMgY2FuIGJlIGZpeGVkIGJ5IHJldHVybmluZyB0aGUgYWN0dWFsIGVycm9y
IGNvZGUgZnJvbQ0KPiBuZnNfbG9va3VwX3ZlcmlmeV9pbm9kZSgpIHJhdGhlciB0aGVuIHplcm8g
KGV4Y2VwdCBmb3IgLUVTVEFMRSkuDQo+IA0KPiBGaXhlczogNWNlYjlkN2ZkYWFmICgiTkZTOiBS
ZWZhY3RvciBuZnNfbG9va3VwX3JldmFsaWRhdGUoKSIpDQo+IFNpZ25lZC1vZmYtYnk6IE5laWxC
cm93biA8bmVpbGJAc3VzZS5kZT4NCj4gLS0tDQo+IMKgZnMvbmZzL2Rpci5jIHwgOCArKysrKy0t
LQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2Rpci5jIGIvZnMvbmZzL2Rpci5jDQo+IGluZGV4IGNi
NTJkYjlhMGNmYi4uZDI0YWNmNTU2ZTllIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvZGlyLmMNCj4g
KysrIGIvZnMvbmZzL2Rpci5jDQo+IEBAIC0xMzUwLDcgKzEzNTAsNyBAQCBuZnNfZG9fbG9va3Vw
X3JldmFsaWRhdGUoc3RydWN0IGlub2RlICpkaXIsDQo+IHN0cnVjdCBkZW50cnkgKmRlbnRyeSwN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2ln
bmVkIGludCBmbGFncykNCj4gwqB7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaW5vZGUgKmlu
b2RlOw0KPiAtwqDCoMKgwqDCoMKgwqBpbnQgZXJyb3I7DQo+ICvCoMKgwqDCoMKgwqDCoGludCBl
cnJvciA9IDA7DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBuZnNfaW5jX3N0YXRzKGRpciwgTkZT
SU9TX0RFTlRSWVJFVkFMSURBVEUpOw0KPiDCoMKgwqDCoMKgwqDCoMKgaW5vZGUgPSBkX2lub2Rl
KGRlbnRyeSk7DQo+IEBAIC0xMzcyLDggKzEzNzIsMTAgQEAgbmZzX2RvX2xvb2t1cF9yZXZhbGlk
YXRlKHN0cnVjdCBpbm9kZSAqZGlyLA0KPiBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksDQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbmZzX2NoZWNrX3ZlcmlmaWVyKGRpciwgZGVudHJ5LCBmbGFncyAm
IExPT0tVUF9SQ1UpKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyb3Ig
PSBuZnNfbG9va3VwX3ZlcmlmeV9pbm9kZShpbm9kZSwgZmxhZ3MpOw0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGlmIChlcnJvcikgew0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChlcnJvciA9PSAtRVNUQUxFKQ0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChlcnJvciA9PSAtRVNU
QUxFKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBuZnNfemFwX2NhY2hlcyhkaXIpOw0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlcnJvciA9IDA7
DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQ0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9i
YWQ7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQ0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoG5mc19hZHZpc2VfdXNlX3JlYWRkaXJwbHVzKGRpcik7DQo+IEBA
IC0xMzk1LDcgKzEzOTcsNyBAQCBuZnNfZG9fbG9va3VwX3JldmFsaWRhdGUoc3RydWN0IGlub2Rl
ICpkaXIsDQo+IHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCj4gwqBvdXRfYmFkOg0KPiDCoMKgwqDC
oMKgwqDCoMKgaWYgKGZsYWdzICYgTE9PS1VQX1JDVSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gLUVDSElMRDsNCj4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIG5mc19s
b29rdXBfcmV2YWxpZGF0ZV9kb25lKGRpciwgZGVudHJ5LCBpbm9kZSwgMCk7DQo+ICvCoMKgwqDC
oMKgwqDCoHJldHVybiBuZnNfbG9va3VwX3JldmFsaWRhdGVfZG9uZShkaXIsIGRlbnRyeSwgaW5v
ZGUsIGVycm9yKTsNCg0KV2hpY2ggZXJyb3JzIGRvIHdlIGFjdHVhbGx5IG5lZWQgdG8gcmV0dXJu
IGhlcmU/IEFzIGZhciBhcyBJIGNhbiB0ZWxsLA0KdGhlIG9ubHkgZXJyb3JzIHRoYXQgbmZzX2xv
b2t1cF92ZXJpZnlfaW5vZGUoKSBpcyBzdXBwb3NlZCB0byByZXR1cm4gaXMNCkVOT01FTSwgRVNU
QUxFLCBFQ0hJTEQsIGFuZCBwb3NzaWJseSBFSU8gb3IgRVRpTUVET1VULg0KDQpXaHkgd291bGQg
aXQgYmUgYmV0dGVyIHRvIHJldHVybiB0aG9zZSBlcnJvcnMgcmF0aGVyIHRoYW4ganVzdCBhIDAg
d2hlbg0Kd2UgbmVlZCB0byBpbnZhbGlkYXRlIHRoZSBpbm9kZSwgcGFydGljdWxhcmx5IHNpbmNl
IHdlIGFscmVhZHkgaGF2ZSBhDQpzcGVjaWFsIGNhc2UgaW4gbmZzX2xvb2t1cF9yZXZhbGlkYXRl
X2RvbmUoKSB3aGVuIHRoZSBkZW50cnkgaXMgcm9vdD8NCg0KPiDCoH0NCj4gwqANCj4gwqBzdGF0
aWMgaW50DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
