Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB91412A6
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 22:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgAQVOX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 16:14:23 -0500
Received: from mail-dm6nam10on2111.outbound.protection.outlook.com ([40.107.93.111]:5953
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726566AbgAQVOX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:14:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnbuXSayUQIZA9OWKu1aeeRG+sSDv6w/OdGw3dOS8mjd/haVcgwozOCgrt1dVWU1O1ZFAf05gaQOTnj+/a5Bw3LyrJUFEoy4IrNbpokwcovLLaXMsCqZ9nTvMmHbWDI2so2FQyssmIlF06xwoew80ByOCPF3pXA5jnjw+56YWr31LgFxhEAbtIdlg92kl3w3dv8OLTg9ljvg3QykRyyuR9B+X7UWeEstsNddqSj9gCSes6l9Mf2i+MqXo8iAX6P4GwFuUZgv73m13N07BxEFanOdNVnC6esYdz17yHcZ1PE/+urVMP6aFia7cv6G/AnoU5e7wH1mxucalmllKeKKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QYcqRxIAVhs6pEbSrX6lD9tL9iiU8kkFAAIvMb31hk=;
 b=iFZKPpUsNmnYwiYqGBks9lvFFEOxn1kksUckRzjH32+EaipeDqecHR2O6y/lgPOdu931KZczoxJGCsfAEewY8huBj38rNUUf4y4iUS4wNixYZ8+qHZCIWXrH9muMb1B+FwpO05eQvuvvbNrBskvYlgOx0XAsLwTmBjgo19k0S+FktDWuvaiLCn/4z1D63EHckmIcJZGtD6/e5OZ+KlD4VOVV9JX1orJwYnVB9yRW9bIFy0k5NuvYRKUBrZkk7z4iyJN/0rvgHxZqYtxJAEhVhD5BYNwIuXogTtKD0INnWOK70rxVarPnhL7ntTrbpVzOce0HlPCDF/34qjKBpOzE9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QYcqRxIAVhs6pEbSrX6lD9tL9iiU8kkFAAIvMb31hk=;
 b=AzD6En0fCkd4rGD2OVrD8yHAXoU6K3jM3Rwh4KPb0z/qnfUl+sBINfi+T1j2U6Myz+rM3BFpmXQijSNtRcsfkgLqATPd2euMp0HkzSqT/MEQxadC0KLF7N6g8LS7kO8wURYLtccFtSO+ZrFMv2XdQwh6U/jVp+Zn4SzS1KNrc3Y=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2188.namprd13.prod.outlook.com (10.174.186.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.5; Fri, 17 Jan 2020 21:14:19 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce%7]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 21:14:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
Thread-Topic: [PATCH 1/1] NFSv4.0 allow nconnect for v4.0
Thread-Index: AQHVzKBvmJSkTy1U+UqmLnQQjeZOL6fvW6uAgAABO4A=
Date:   Fri, 17 Jan 2020 21:14:19 +0000
Message-ID: <803ff52e7e4fd7c2b2965368f8cd203b0da28f49.camel@hammerspace.com>
References: <20200116190857.26026-1-olga.kornievskaia@gmail.com>
         <1f3297c1549ad12d47497cd18d2c0d9bc7bc5fe7.camel@netapp.com>
In-Reply-To: <1f3297c1549ad12d47497cd18d2c0d9bc7bc5fe7.camel@netapp.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 408d99e3-55f9-4457-ce99-08d79b923767
x-ms-traffictypediagnostic: DM5PR1301MB2188:
x-microsoft-antispam-prvs: <DM5PR1301MB21883E5BA08CED49021942F8B8310@DM5PR1301MB2188.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39830400003)(366004)(396003)(189003)(199004)(478600001)(5660300002)(71200400001)(110136005)(8936002)(186003)(316002)(86362001)(6512007)(6486002)(2616005)(26005)(36756003)(66556008)(66476007)(64756008)(2906002)(4326008)(66946007)(66446008)(81156014)(8676002)(91956017)(76116006)(81166006)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2188;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bOmZEUY4gElA6cKgvcvbunBcSkjBerZNNF2EsjcBYLp/FE2XVjrMyQbL0E9IYcz3MQpQqZ/KZt28A2dnbkVyxUbXj8/ZPY6O0wQbPApthFphdctRiby+NBoCJ3HVdtwtxYSZBoG7lenoUEwAAHEst1a7D4SSShBhQHS9CRqE444sE/xpY66RHPfslv+pBPHIIfNQIqm0bX9Y1gZLHGRBPjguIkG3bz4Jq0tRmwNWCcJVkIjEslEtswsKEEIjaCF15Xe9sobwLttnxn8Up7kj+biIfmHuUjn2jIlSmkIxC2KRYDihPNeS780HLxBlwQtmvIOP1+soayoXKCxGjCKFHNEg70YAB+seG4RpEgBFRzWDpEg0mjw16Jv/Eg9tgTFVxTuonC5yA5oaMiNHdJNl55VsxiXlnXL4H05PNN8XCZPWXjZlHqQqa4mkHP7BDjEC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E2BDED278F02344B23B3F852F1D8D96@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408d99e3-55f9-4457-ce99-08d79b923767
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 21:14:19.1825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMDiOvDS7966LylnjJd0SpmZjqWncz9X9os0TrTgRxwuBBHEqmusiJkYtuRLSr4TRNk5kzhPtbb6/QrJ09zpcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2188
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTE3IGF0IDIxOjA5ICswMDAwLCBTY2h1bWFrZXIsIEFubmEgd3JvdGU6
DQo+IEhpIE9sZ2EsDQo+IA0KPiBPbiBUaHUsIDIwMjAtMDEtMTYgYXQgMTQ6MDggLTA1MDAsIE9s
Z2EgS29ybmlldnNrYWlhIHdyb3RlOg0KPiA+IEZyb206IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xn
YUBuZXRhcHAuY29tPg0KPiANCj4gSGF2ZSB5b3UgZG9uZSBhbnkgdGVzdGluZyB3aXRoIG5jb25u
ZWN0IGFuZCB0aGUgdjQuMCByZXBsYXkgY2FjaGVzPyBJDQo+IGRpZCBzb21lDQo+IGRpZ2dpbmcg
b24gdGhlIG1haWxpbmcgbGlzdCBhbmQgZm91bmQgdGhpcyBpbiBvbmUgb2YgdGhlIGNvdmVyDQo+
IGxldHRlcnMgZnJvbQ0KPiBUcm9uZDogIlRoZSBmZWF0dXJlIGlzIG9ubHkgZW5hYmxlZCBmb3Ig
TkZTdjQuMSBhbmQgTkZTdjQuMiBmb3Igbm93Ow0KPiBJIGRvbid0DQo+IGZlZWwgY29tZm9ydGFi
bGUgc3ViamVjdGluZyBORlN2My92NCByZXBsYXkgY2FjaGVzIHRvIHRoaXMgdHJlYXRtZW50DQo+
IHlldC4iDQo+IA0KDQpUaGF0IGNvbW1lbnQgc2hvdWxkIGJlIGNvbnNpZGVyZWQgb2Jzb2xldGUu
IFRoZSBjdXJyZW50IGNvZGUgd29ya3MgaGFyZA0KdG8gZW5zdXJlIHRoYXQgd2UgcmVwbGF5IHVz
aW5nIHRoZSBzYW1lIGNvbm5lY3Rpb24gKG9yIGF0IGxlYXN0IHRoZQ0Kc2FtZSBzb3VyY2UvZGVz
dCBJUCtwb3J0cykgc28gdGhhdCBORlN2My92NC4wIERSQ3Mgd29yayBhcyBleHBlY3RlZC4NCkZv
ciB0aGF0IHJlYXNvbiB3ZSd2ZSBoYWQgTkZTdjMgc3VwcG9ydCBzaW5jZSB0aGUgZmVhdHVyZSB3
YXMgbWVyZ2VkLg0KVGhlIE5GU3Y0LjAgc3VwcG9ydCB3YXMganVzdCBmb3Jnb3R0ZW4uDQoNCj4g
VGhhbmtzLA0KPiBBbm5hDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29ybmlldnNrYWlh
IDxrb2xnYUBuZXRhcHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBmcy9uZnMvbmZzNGNsaWVudC5jIHwg
MiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRjbGllbnQuYyBiL2ZzL25mcy9uZnM0
Y2xpZW50LmMNCj4gPiBpbmRleCA0NjBkNjI1Li40ZGYzZmIwIDEwMDY0NA0KPiA+IC0tLSBhL2Zz
L25mcy9uZnM0Y2xpZW50LmMNCj4gPiArKysgYi9mcy9uZnMvbmZzNGNsaWVudC5jDQo+ID4gQEAg
LTg4MSw3ICs4ODEsNyBAQCBzdGF0aWMgaW50IG5mczRfc2V0X2NsaWVudChzdHJ1Y3QgbmZzX3Nl
cnZlcg0KPiA+ICpzZXJ2ZXIsDQo+ID4gIA0KPiA+ICAJaWYgKG1pbm9ydmVyc2lvbiA9PSAwKQ0K
PiA+ICAJCV9fc2V0X2JpdChORlNfQ1NfUkVVU0VQT1JULCAmY2xfaW5pdC5pbml0X2ZsYWdzKTsN
Cj4gPiAtCWVsc2UgaWYgKHByb3RvID09IFhQUlRfVFJBTlNQT1JUX1RDUCkNCj4gPiArCWlmIChw
cm90byA9PSBYUFJUX1RSQU5TUE9SVF9UQ1ApDQo+ID4gIAkJY2xfaW5pdC5uY29ubmVjdCA9IG5j
b25uZWN0Ow0KPiA+ICANCj4gPiAgCWlmIChzZXJ2ZXItPmZsYWdzICYgTkZTX01PVU5UX05PUkVT
VlBPUlQpDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
