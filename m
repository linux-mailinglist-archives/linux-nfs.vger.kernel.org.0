Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5948151F05
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2020 18:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgBDRNo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Feb 2020 12:13:44 -0500
Received: from mail-dm6nam12on2104.outbound.protection.outlook.com ([40.107.243.104]:57505
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727382AbgBDRNn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Feb 2020 12:13:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kd7SE8MO1eYZUT7k9orlbfw+1fcLtxTAdGnviv3Z05KrcmCzv9sl52PCjw2Ry0I2aKdcOrmfxjM7rnWva/76XRF0WMvGCgCYUfwGcaJfMqX3pocXulGDAooeDNVCi3E1dKX969PSF0SpDvdiIuCRNRrKUv+Hjhb+OcTgCxi++9C4381FkkjKo7OKp27MAmQj2Qi6rq4z1zRNGc91cgVrRtVYLF5LsDs8MpIME09wWsRxdI6KjQQm/QGq0ONkBFEGPVhi5qoWKdfVdYPnauE6YmNQDirb44DP3FGJmiI2B87b9nGdbqZzHhyqAJoXIcNS0Nj/147pMevtl4+g29u/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLxQrS3wcCQbCPZSYyv21XyugFveXUqjH2JhQecyh4c=;
 b=kuGOr7rhsv+ywRxP41QolaG48IyCbdfB2QpMhpbw2/q4FlLpegCLQhXHh7VtxR3tjLUhr74Uw05oRAaEdPCCQk9TG7LJcYlFPFs6VOvlvND/7X8HJs/ytJNUcIDhvRQ4ivPDvI5SE8vp0i0dP8NwEF80y//D2DFbKiqFZJ77FcuZRniYXAPS+NclNU5DaOiMQ9YOem/d9BxuaQbX5caarQOtmujZbPw2mmb+5WTxltLAw37JrsWs6HsbNN2r61UgA3+HC9Xmzyd5ZZx+2cL3J8YiWZmLigIsBDewFNbueoddB4UdlzUrO46YuNhEmxesMDHnCZJdA4TV1y1XzdGEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLxQrS3wcCQbCPZSYyv21XyugFveXUqjH2JhQecyh4c=;
 b=T3t8hH7/LpZDjanVVTN0F+7F3+BwebnTULff5fBDC6SE2kQeAClKnK1RcBF1QLmJVYgwG5WiUgRvmTrCcsF9/rh0a7HhYdZbxUu/TwWjKURJo9Dw9c/0QfxjZ78KnOvc1emRn7a5FYhCWIOWFzpjOyUOBUbTZP90640WPIKvTso=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2124.namprd13.prod.outlook.com (10.174.185.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.19; Tue, 4 Feb 2020 17:13:41 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2707.018; Tue, 4 Feb 2020
 17:13:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>,
        "SteveD@RedHat.com" <SteveD@RedHat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] manpage: Add a description of the 'nconnect' mount
 option
Thread-Topic: [PATCH 1/2] manpage: Add a description of the 'nconnect' mount
 option
Thread-Index: AQHV1rtiY+PbLnmEZUOEKWD862nBgqgJm/2AgAGr2wCAAAeTgA==
Date:   Tue, 4 Feb 2020 17:13:40 +0000
Message-ID: <e96d7688a52b4f7d54e492b5f2dc9e4070cf240d.camel@hammerspace.com>
References: <20200129154703.6204-1-steved@redhat.com>
         <CAN-5tyF1NUt2emuPGYF+-3s9cJPwox1uoh0uVzxArRJtzPXMTA@mail.gmail.com>
         <4c48901d-3e37-31fc-a032-0326bda51b25@RedHat.com>
In-Reply-To: <4c48901d-3e37-31fc-a032-0326bda51b25@RedHat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d516783c-d008-4989-515c-08d7a99594f6
x-ms-traffictypediagnostic: DM5PR1301MB2124:
x-microsoft-antispam-prvs: <DM5PR1301MB2124EEB053DDC07F025A64E3B8030@DM5PR1301MB2124.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39850400004)(396003)(136003)(189003)(199004)(110136005)(316002)(186003)(6512007)(76116006)(478600001)(6506007)(66446008)(66946007)(66476007)(53546011)(5660300002)(2616005)(66556008)(64756008)(91956017)(26005)(86362001)(36756003)(4326008)(2906002)(6486002)(81156014)(81166006)(8676002)(71200400001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2124;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F5qe2zKYbUa0AvoaRCsdSKiXm7wEeEyFTTKaMnv+OY7mr0705nsBd4kwP3M4+mytfCF4mtuos8bgt581B3tEhdmKB1fc2qGhUILMeT0B6+TDCzWgzdXT3osJDc5f9lmadkavVpnJGd6nIc5gWv1wUL0tsi9hERvvrRt6n5z0qCeNW4xze6NLn0R4oye7PEAFFp9/WKDfJxb5M1vu61dfHayN/DRbLFGUg3bFLljTqnwJl+uhNd9ggurw2IuqNaiJkpP8poPMwnMVsDqM5X4lASnTS7sKN40fWAxasNZxd0Wm3R+87EIlnJ0nq3JiBreEtKF1Bd1PwyVfDKinnLE8jncDfcSEaEe8atmrHg3DZIyXgHAT80kQj9oRbjUhmeqOxXtBNXlTs9CyseQ2L8rlVfTEdfTE74Rci2xl9LQ/hCvGWBkSxGzLpFN/f3QPAExO
x-ms-exchange-antispam-messagedata: qOCupj0t/RJHD4ppwGL5Mf12aSvZFrGs8NugTS25j5DZClo3VEuZkY5MWLM4ls6J2oYLMu5ROo1UMXC0W2Bm5aAwGE6+pOyZ3IlYgkEdgt03m2vUovCTzk4fmT9uLeH34Sgk9kfj4BEcpECNmoPgTw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <568053B83AF4C9469167167FF5BECCEA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d516783c-d008-4989-515c-08d7a99594f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 17:13:40.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQdJIeer1kJwbqgWuabedJpWfhEgcB2T9WXemUdE+RJhWOb0X9UmqS58UM++z331tHv0e6HFmQ6PD1zm1rPTAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2124
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTA0IGF0IDExOjQ2IC0wNTAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0K
PiBUcm9uZCwNCj4gDQo+IE9uIDIvMy8yMCAxMDoxNSBBTSwgT2xnYSBLb3JuaWV2c2thaWEgd3Jv
dGU6DQo+ID4gTG9va3MgZ29vZCBidXQgY2FuIHdlIGFkZCBjbGFyaWZpY2F0aW9uIHRoYXQgbmNv
bm5lY3QgaXMgc3VwcG9ydGVkDQo+ID4gZm9yDQo+ID4gMy4wIGFuZCA0LjErPw0KPiBEbyB5b3Ug
aGF2ZSBhbiBvcGluaW9uIG9uIHRoaXM/IFNob3VsZCB3ZSBkb2N1bWVudCB0aGUgcHJvdG9jb2xz
IHRoYXQNCj4gYXJlIHN1cHBvcnRlZD8NCg0KVW5sZXNzIHRoZXJlIGlzIGFuIGFjdHVhbCBwcm90
b2NvbCByZWFzb24gZm9yIGRvaW5nIHNvLCBJJ2QgcmF0aGVyIG5vdA0KdGhhdCB3ZSBiZSBvbiB0
aGUgcmVjb3JkIGFzIHNheWluZyB0aGF0IE5GU3Y0LjAgd2lsbCByZW1haW4NCnVuc3VwcG9ydGVk
Lg0KSW4gb3RoZXIgd29yZHMsIEknZCBsaWtlIHVzIHRvIGtlZXAgb3BlbiB0aGUgcG9zc2liaWxp
dHkgdGhhdCB3ZSBtaWdodA0KYWRkIE5GU3Y0LjAgc3VwcG9ydCBpbiB0aGUgZnV0dXJlLCBzaG91
bGQgc29tZW9uZSBuZWVkIGl0Lg0KDQpDaGVlcnMNCiAgVHJvbmQNCg0KDQo+IHN0ZXZlZC4NCj4g
DQo+ID4gT24gV2VkLCBKYW4gMjksIDIwMjAgYXQgMTA6NDcgQU0gU3RldmUgRGlja3NvbiA8c3Rl
dmVkQHJlZGhhdC5jb20+DQo+ID4gd3JvdGU6DQo+ID4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3Qg
PHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gPiANCj4gPiA+IEFkZCBhIGRl
c2NyaXB0aW9uIG9mIHRoZSAnbmNvbm5lY3QnIG1vdW50IG9wdGlvbiBvbiB0aGUgJ25mcycNCj4g
PiA+IGdlbmVyaWMNCj4gPiA+IG1hbnBhZ2UuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IFN0ZXZlIERpY2tzb24gPHN0ZXZlZEByZWRoYXQuY29tPg0KPiA+ID4g
LS0tDQo+ID4gPiAgdXRpbHMvbW91bnQvbmZzLm1hbiB8IDE3ICsrKysrKysrKysrKysrKysrDQo+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlm
ZiAtLWdpdCBhL3V0aWxzL21vdW50L25mcy5tYW4gYi91dGlscy9tb3VudC9uZnMubWFuDQo+ID4g
PiBpbmRleCA2YmE5Y2VmLi44NDQ2MmNkIDEwMDY0NA0KPiA+ID4gLS0tIGEvdXRpbHMvbW91bnQv
bmZzLm1hbg0KPiA+ID4gKysrIGIvdXRpbHMvbW91bnQvbmZzLm1hbg0KPiA+ID4gQEAgLTM2OSw2
ICszNjksMjMgQEAgdXNpbmcgYW4gYXV0b21vdW50ZXIgKHJlZmVyIHRvDQo+ID4gPiAgLkJSIGF1
dG9tb3VudCAoOCkNCj4gPiA+ICBmb3IgZGV0YWlscykuDQo+ID4gPiAgLlRQIDEuNWkNCj4gPiA+
ICsuQlIgbmNvbm5lY3Q9IG4NCj4gPiA+ICtXaGVuIHVzaW5nIGEgY29ubmVjdGlvbiBvcmllbnRl
ZCBwcm90b2NvbCBzdWNoIGFzIFRDUCwgaXQgbWF5DQo+ID4gPiArc29tZXRpbWVzIGJlIGFkdmFu
dGFnZW91cyB0byBzZXQgdXAgbXVsdGlwbGUgY29ubmVjdGlvbnMgYmV0d2Vlbg0KPiA+ID4gK3Ro
ZSBjbGllbnQgYW5kIHNlcnZlci4gRm9yIGluc3RhbmNlLCBpZiB5b3VyIGNsaWVudHMgYW5kL29y
DQo+ID4gPiBzZXJ2ZXJzDQo+ID4gPiArYXJlIGVxdWlwcGVkIHdpdGggbXVsdGlwbGUgbmV0d29y
ayBpbnRlcmZhY2UgY2FyZHMgKE5JQ3MpLCB1c2luZw0KPiA+ID4gbXVsdGlwbGUNCj4gPiA+ICtj
b25uZWN0aW9ucyB0byBzcHJlYWQgdGhlIGxvYWQgbWF5IGltcHJvdmUgb3ZlcmFsbCBwZXJmb3Jt
YW5jZS4NCj4gPiA+ICtJbiBzdWNoIGNhc2VzLCB0aGUNCj4gPiA+ICsuQlIgbmNvbm5lY3QNCj4g
PiA+ICtvcHRpb24gYWxsb3dzIHRoZSB1c2VyIHRvIHNwZWNpZnkgdGhlIG51bWJlciBvZiBjb25u
ZWN0aW9ucw0KPiA+ID4gK3RoYXQgc2hvdWxkIGJlIGVzdGFibGlzaGVkIGJldHdlZW4gdGhlIGNs
aWVudCBhbmQgc2VydmVyIHVwIHRvDQo+ID4gPiArYSBsaW1pdCBvZiAxNi4NCj4gPiA+ICsuSVAN
Cj4gPiA+ICtOb3RlIHRoYXQgdGhlDQo+ID4gPiArLkJSIG5jb25uZWN0DQo+ID4gPiArb3B0aW9u
IG1heSBhbHNvIGJlIHVzZWQgYnkgc29tZSBwTkZTIGRyaXZlcnMgdG8gZGVjaWRlIGhvdyBtYW55
DQo+ID4gPiArY29ubmVjdGlvbnMgdG8gc2V0IHVwIHRvIHRoZSBkYXRhIHNlcnZlcnMuDQo+ID4g
PiArLlRQIDEuNWkNCj4gPiA+ICAuQlIgcmRpcnBsdXMgIiAvICIgbm9yZGlycGx1cw0KPiA+ID4g
IFNlbGVjdHMgd2hldGhlciB0byB1c2UgTkZTIHYzIG9yIHY0IFJFQURESVJQTFVTIHJlcXVlc3Rz
Lg0KPiA+ID4gIElmIHRoaXMgb3B0aW9uIGlzIG5vdCBzcGVjaWZpZWQsIHRoZSBORlMgY2xpZW50
IHVzZXMgUkVBRERJUlBMVVMNCj4gPiA+IHJlcXVlc3RzDQo+ID4gPiAtLQ0KPiA+ID4gMi4yMS4x
DQo+ID4gPiANCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
