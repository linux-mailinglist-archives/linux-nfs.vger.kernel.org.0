Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA9A184876
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2020 14:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCMNuo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Mar 2020 09:50:44 -0400
Received: from mail-co1nam11on2105.outbound.protection.outlook.com ([40.107.220.105]:33135
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726323AbgCMNuo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Mar 2020 09:50:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iD+JC9g/X6+i/rYOGPNWbLMh/kkA+EMmB6S3KKoLkEgS/O6UzyJZ2ey+vlYDI4Lqdm+i9MXJDxE5gkHqMjGdCgPmynpM+lkvrQyLP5jsV0AqFpbOCXA+68X4ZvY/0nt6pS2VH0WRuH9LEFvbZPegqQRcDchPweg0xO2z0obK8GiN7MsHsh5HsRhIXJrCCwTSgdZA2VdieU6bZiYDAuddIxEMGWvBKUbrVJVDaazX3A2tt9PaWS2ORJkFzMtAFoYP3ifNOM1ax/sdWzRYkD8SbrkdRki/pJ/l1SjCPY9xbAZhLNO1/qqDPM1oGqdJ2sWEmBPKAKzre4u4mz7w7dc74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN3KSAZCYf+e91VxcBNUKjbXlQFEfaOrIWcmWfR+qCs=;
 b=FlygdV9De97m/mEQkJaw0nXJFCbRiNk+RGEBWAWzIuKy5tOx6aTMurbaoayKQurzDw12g2D1i+RAJma7nS3fgJMkZtFa7jprqvzD5qjQsFGVeIkjKZhQvkCs4BmNnZ/i0oqs/mzNk8CWv6K+ps+BVtd/fBb0cgPRR9V6fWVxuQwtteU7JNanc2wUjdm2GJivso6O5CcqTj8xlP9zoKvfAEoacNV1NntQcnPyTVulgOAnHVxGGG4h1L1H3hbokZaibe8M8Aqvnihp5qyPQ3PNRsNq+Zar78YP/YC0Q6mrf47MRU1F/BnPvHsEdOmnZCEZlbRlY5QAK0vbJppBjV1/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN3KSAZCYf+e91VxcBNUKjbXlQFEfaOrIWcmWfR+qCs=;
 b=AKKdd8tS9drDEjJXH3hzAtPJUx0kYb7EV+HgOx69TFJhEVCnxiZf7Xk9E6gPlBvJdtVrgIEQtW9r5cSA9moULrbEd5jrUulRbwPK/KqCnuGV8rJRBYrfzbIBbSI7ZZGaahk0NPl1upXPCLElcF0LGhtnt9WcMtteIgnTBpWL2XU=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (2603:10b6:4:34::34)
 by DM5PR1301MB1962.namprd13.prod.outlook.com (2603:10b6:4:31::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.9; Fri, 13 Mar
 2020 13:50:39 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2814.018; Fri, 13 Mar 2020
 13:50:38 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "fllinden@amazon.com" <fllinden@amazon.com>,
        "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 03/13] NFSv4.2: query the server for extended attribute
 support
Thread-Topic: [PATCH 03/13] NFSv4.2: query the server for extended attribute
 support
Thread-Index: AQHV998vv0PI2kCOxkaGqYUZpy0TZqhFIw8AgABNQICAAAbIgIAA6XKAgAAseIA=
Date:   Fri, 13 Mar 2020 13:50:38 +0000
Message-ID: <6792d6a6012a241b8bd1555eea8c592ff318a444.camel@hammerspace.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
         <20200311195613.26108-4-fllinden@amazon.com>
         <530167624.4533477.1584029710746.JavaMail.zimbra@desy.de>
         <20200312205139.GA32293@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
         <20200312211555.GA5974@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
         <948465413.4651196.1584097887947.JavaMail.zimbra@desy.de>
In-Reply-To: <948465413.4651196.1584097887947.JavaMail.zimbra@desy.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5213fd4a-5784-4179-1fe8-08d7c7558393
x-ms-traffictypediagnostic: DM5PR1301MB1962:
x-microsoft-antispam-prvs: <DM5PR1301MB19625C4DA97F132903910DEDB8FA0@DM5PR1301MB1962.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39830400003)(396003)(366004)(346002)(199004)(6506007)(186003)(8676002)(81156014)(6486002)(26005)(316002)(81166006)(76116006)(2616005)(66446008)(8936002)(110136005)(5660300002)(2906002)(86362001)(6512007)(4326008)(71200400001)(66946007)(66476007)(36756003)(478600001)(66556008)(64756008)(54906003)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1962;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xts+3UxHbz37A3qst2ok5hkJrQOBuQ0hB0jJLatlX1qu9nQsTEYOVXxp08J9c9EMmlGeiUsrdt2GAzgSGxdB3BWpxkyXBolg2OPWj/sA76vYH1b6mBZbyg+QGgz31+HtvXpuW+4NzcEA5K5MECRR/Q2VUyekpOXh1vvwaPxAoFaC4f3p8riViSrHfUBp7lDJeqkmOVKfqJ/ZMgPFN/4IZYimOAVSs+RCe4DHsDn+O0Z3nB3aWiCSTBcLSnDtKRmDj+JhpoYgHcpHYI29B7Qf0ejFA4zUVC/+pkNRRHXVf68DKrVLt8J6ynD6fRRWcJNP3xL+rrd/CCVX/Og2/Y/OhbXGs66Ar1cWfo1luYUz+/RJyprK88znCNJQ1JM2v9nf11CpSnry9SHgs1mupdWEsoKLWNPiJwF2ZlHxoCSTxa984iCdKC/HUOrAKf29MNFw
x-ms-exchange-antispam-messagedata: 101jJDp3JzK4dXGt3FOjY7lb/SzkXrmORtEtQ3Q1mT7+bE1HHOunawAm3cIv/HFWKk1HBBj18bU9qNTmtkFrRdabw2TS345y8qYY55I4bjA7SxVYg5p0dAV6RyVFoA0qF2+FdsbQzDO48nkA3j1ARQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADAD14F26B3E314C8F8B056906B0E322@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5213fd4a-5784-4179-1fe8-08d7c7558393
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 13:50:38.9479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWVoj+X5qxwabsSOMAPDEIh3bTHjqXrLJAKREKNQ+0Gg70AhhOLlg8qTjBgWONtPrMkkSHWzGlgjxgoXAqiVSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1962
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTEzIGF0IDEyOjExICswMTAwLCBNa3J0Y2h5YW4sIFRpZ3JhbiB3cm90
ZToNCj4gSGkgRnJhbmssDQo+IA0KPiBJIHRoaW5rIHRoZSB3YXkgaG93IHlvdSBoYXZlIGltcGxl
bWVudGVkIGlzIGFsbW9zdCBjb3JyZWN0LiBZb3UgcXVlcnkNCj4gc2VydmVyIGZvciBzdXBwb3J0
ZWQgYXR0cmlidXRlcy4gQXMgcmVzdWx0IGNsaWVudCB3aWxsIGdldCBhbGwNCj4gYXR0cmlidXRl
cw0KPiBzdXBwb3J0ZWQgYnUgdGhlIHNlcnZlciBhbmQgaWYgRkFUVFI0X1hBVFRSX1NVUFBPUlQg
aXMgcmV0dXJuZWQsIHRoZW4NCj4gY2xpZW50DQo+IGFkZHMgeGF0dHIgY2FwYWJpbGl0eS4gVGhp
cyB0aGUgd2F5IGhvdyBJIHJlYWQgcmZjODI3Ni4gRG8geW91IGhhdmUgYQ0KPiBkaWZmZXJlbnQN
Cj4gb3Bpbmlvbj8NCj4gDQoNCid4YXR0cl9zdXBwb3J0JyBzZWVtcyBsaWtlIGEgcHJvdG9jb2wg
aGFjayB0byBhbGxvdyB0aGUgY2xpZW50IHRvDQpkZXRlcm1pbmUgd2hldGhlciBvciBub3QgdGhl
IHhhdHRyIG9wZXJhdGlvbnMgYXJlIHN1cHBvcnRlZC4NCg0KVGhlIHJlYXNvbiB3aHkgaXQgaXMg
YSBoYWNrIGlzIHRoYXQgJ3N1cHBvcnRlZF9hdHRycycgaXMgYWxzbyBhIHBlci0NCmZpbGVzeXN0
ZW0gYXR0cmlidXRlLCBhbmQgdGhlcmUgaXMgbm8gdmFsdWUgaW4gYWR2ZXJ0aXNpbmcNCid4YXR0
cl9zdXBwb3J0JyB0aGVyZSB1bmxlc3MgeW91ciBmaWxlc3lzdGVtIGFsc28gc3VwcG9ydHMgeGF0
dHJzLg0KDQpJT1c6IHRoZSBwcm90b2NvbCBmb3JjZXMgeW91IHRvIGRvIDIgcm91bmQgdHJpcHMg
dG8gdGhlIHNlcnZlciBpbiBvcmRlcg0KdG8gZmlndXJlIG91dCBzb21ldGhpbmcgdGhhdCByZWFs
bHkgc2hvdWxkIGJlIG9idmlvdXMgd2l0aCAxIHJvdW5kDQp0cmlwLg0KDQo+IFJlZ2FyZHMsDQo+
ICAgIFRpZ3Jhbi4NCj4gDQo+IC0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0NCj4gPiBGcm9t
OiAiRnJhbmsgdmFuIGRlciBMaW5kZW4iIDxmbGxpbmRlbkBhbWF6b24uY29tPg0KPiA+IFRvOiAi
VGlncmFuIE1rcnRjaHlhbiIgPHRpZ3Jhbi5ta3J0Y2h5YW5AZGVzeS5kZT4NCj4gPiBDYzogIlRy
b25kIE15a2xlYnVzdCIgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+LCAiQW5uYQ0K
PiA+IFNjaHVtYWtlciIgPGFubmEuc2NodW1ha2VyQG5ldGFwcC5jb20+LCAibGludXgtbmZzIg0K
PiA+IDxsaW51eC1uZnNAdmdlci5rZXJuZWwub3JnPg0KPiA+IFNlbnQ6IFRodXJzZGF5LCBNYXJj
aCAxMiwgMjAyMCAxMDoxNTo1NSBQTQ0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDMvMTNdIE5G
U3Y0LjI6IHF1ZXJ5IHRoZSBzZXJ2ZXIgZm9yIGV4dGVuZGVkDQo+ID4gYXR0cmlidXRlIHN1cHBv
cnQNCj4gPiBPbiBUaHUsIE1hciAxMiwgMjAyMCBhdCAwODo1MTozOVBNICswMDAwLCBGcmFuayB2
YW4gZGVyIExpbmRlbg0KPiA+IHdyb3RlOg0KPiA+ID4gMSkgVGhlIHhhdHRyX3N1cHBvcnQgYXR0
cmlidXRlIGV4aXN0cw0KPiA+ID4gMikgVGhlIHhhdHRyIHN1cHBvcnQgYXR0cmlidXRlIGV4aXN0
cyAqYW5kKiBpdCdzIHRydWUgZm9yIHRoZQ0KPiA+ID4gcm9vdCBmaA0KPiA+ID4gDQo+ID4gPiBD
dXJyZW50bHkgdGhlIGNvZGUgZG9lcyAyKSBpbiBvbmUgb3BlcmF0aW9uLiBUaGF0IG1pZ2h0IG5v
dCBiZQ0KPiA+ID4gMTAwJQ0KPiA+ID4gY29ycmVjdCAtIHRoZSBSRkMgZG9lcyBtZW50aW9uIHRo
YXQgKHNlY3Rpb24gOC4yKToNCj4gPiA+IA0KPiA+ID4gIkJlZm9yZSBpbnRlcnJvZ2F0aW5nIHRo
aXMgYXR0cmlidXRlIHVzaW5nIEdFVEFUVFIsIGEgY2xpZW50DQo+ID4gPiBzaG91bGQNCj4gPiA+
ICBkZXRlcm1pbmUgd2hldGhlciBpdCBpcyBhIHN1cHBvcnRlZCBhdHRyaWJ1dGUgYnkgaW50ZXJy
b2dhdGluZw0KPiA+ID4gdGhlDQo+ID4gPiAgc3VwcG9ydGVkX2F0dHJzIGF0dHJpYnV0ZS4iDQo+
ID4gPiANCj4gPiA+IFRoYXQncyBhICJzaG91bGQiLCBub3QgYSAiTVVTVCIsIGJ1dCBpdCdzIHN0
aWxsIHdhdmluZyBpdHMgZmluZ2VyDQo+ID4gPiBhdCB5b3Ugbm90IHRvIGRvIHRoaXMuDQo+ID4g
PiANCj4gPiA+IFNpbmNlIDguMi4xIHNheXM6DQo+ID4gPiANCj4gPiA+ICJIb3dldmVyLCBhIGNs
aWVudCBtYXkgcmVhc29uYWJseSBhc3N1bWUgdGhhdCBhIHNlcnZlcg0KPiA+ID4gIChvciBmaWxl
IHN5c3RlbSkgdGhhdCBkb2VzIG5vdCBzdXBwb3J0IHRoZSB4YXR0cl9zdXBwb3J0DQo+ID4gPiBh
dHRyaWJ1dGUNCj4gPiA+ICBkb2VzIG5vdCBwcm92aWRlIHhhdHRyIHN1cHBvcnQsIGFuZCBpdCBh
Y3RzIG9uIHRoYXQgYmFzaXMuIg0KPiA+ID4gDQo+ID4gPiAuLkkgdGhpbmsgeW91J3JlIHJpZ2h0
LCBhbmQgdGhlIGNvZGUgc2hvdWxkIGp1c3QgdXNlIHRoZQ0KPiA+ID4gZXhpc3RlbmNlDQo+ID4g
PiBvZiB0aGUgYXR0cmlidXRlIGFzIGEgc2lnbmFsIHRoYXQgdGhlIHNlcnZlciBrbm93cyBhYm91
dCB4YXR0cnMgLQ0KPiA+ID4gb3BlcmF0aW9ucyBzaG91bGQgc3RpbGwgZXJyb3Igb3V0IGNvcnJl
Y3RseSBpZiBpdCBkb2Vzbid0Lg0KPiA+ID4gDQo+ID4gPiBJJ2xsIG1ha2UgdGhhdCBjaGFuZ2Us
IHRoYW5rcy4NCj4gPiANCj4gPiAuLm9yLCBhbHRlcm5hdGl2ZWx5LCBvbmx5IHF1ZXJ5IHhhdHRy
X3N1cHBvcnQgaW4NCj4gPiBuZnM0X3NlcnZlcl9jYXBhYmlsaXRpZXMsDQo+ID4gYW5kIHRoZW4g
aXRzIGFjdHVhbCB2YWx1ZSwgaWYgaXQgZXhpc3RzLCBpbiBuZnM0X2ZzX2luZm8uDQo+ID4gDQo+
ID4gQW55IG9waW5pb25zIG9uIHRoaXM/DQo+ID4gDQo+ID4gLSBGcmFuaw0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
