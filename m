Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB70C12FC06
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 19:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgACSCC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 13:02:02 -0500
Received: from mail-dm6nam10on2108.outbound.protection.outlook.com ([40.107.93.108]:23552
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728236AbgACSCC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 3 Jan 2020 13:02:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miKiiDgfGWADIEN1oIBa8MtqDZqXuaqcs+fepHzJfdR5VzEvcFdarv9PU6QZCITVC0HMHr5TPA73rN2Y1LyRVBYBlC0D8QzjU1goJtlrIOrkbVvf4bLJqi3feIZSvA/jpUtLf9P0r4PSJPzrfHjg1I+TJwd2oEeYcAlG5WLgHM26WKl6l1UwQ9vK2vPlXXYodzQJ2w7VMghItCShMrjuqpB0oxbCqeFXU517FHnT9vZv4YwtY7zPuJWIttlHqmGk9OH1BGZX9fJEOeGyIEAih0QE3UH7HeOAJrU557oZHgautq4UHJ95bYAebv6uv9P6bgFBLog7wisURM3bmLKknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOtcKFBUAk0bwf5trz9hFFC6BMp5t14ISjB6GXNguK0=;
 b=hFucqEYREmoL8N7z2Rr1utLBd5Ze/SrmJY4EG0Ga/PNdAj7pvd9JvlyXTj+I6+kBbfVGOo9Mlpf9LPJff0+g8S3TiYJbHj35YarvZ7HjHTSmUyXgvCJjmZnEVUWsL9E+UPKfeoxXazevkamy0lQZAb0g5afXk56x+kwG5k8M0CwK4wrMKX5Eogm8BOE2WCApW5Orp6Ayumpq+JxteykS97ZxHvm1iaqDfZ9MorET5Las2woPP0/apL0Y5jipI7NgJZVzGyefAjdIs2OydmLK2C8T6ayJTSW6JB3z8UTwVwKADSkHVwF8YyTTwd+ohL40spH+UY0NfEAvrDI3esvJgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOtcKFBUAk0bwf5trz9hFFC6BMp5t14ISjB6GXNguK0=;
 b=V61o8Yyc3x0faYi9HT+cLFy37VIApoviHwtV05RDbu0UZv5Xyz35aNFUGQddy7VwiiiSKfbUtgTor2FCrGoOnQsPrzGRh9bsSY7UieatFxYnQvmwH2tuePnJl2dvR0tFOrx+xJ8v40bKXARunbvwLQJGWrDUkdnIY8jR8B83aXg=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2106.namprd13.prod.outlook.com (10.174.185.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.4; Fri, 3 Jan 2020 18:01:47 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce%7]) with mapi id 15.20.2623.002; Fri, 3 Jan 2020
 18:01:47 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "jlayton@redhat.com" <jlayton@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: CPU lockup in or near new filecache code
Thread-Topic: CPU lockup in or near new filecache code
Thread-Index: AQHVr3a22tGQ3WjzQkKmN7EsuF72/Kez1qgAgAFoF4CAAB3RAIADJ8YAgAgQVQCAGLdKgIAAFNcA
Date:   Fri, 3 Jan 2020 18:01:47 +0000
Message-ID: <90784f104ddb8b423869b1933abd9a12b66c6204.camel@hammerspace.com>
References: <9977648B-7D14-42EB-BD4A-CBD041A0C21A@oracle.com>
         <3af633a4016a183a930a44e3287f9da230711629.camel@hammerspace.com>
         <BDCA1236-A90A-48F6-9329-DE4818298D83@oracle.com>
         <A7C348BD-2543-492A-B768-7E3666734A57@oracle.com>
         <aa7857e4a9ac535e78353db53448efb1b58a57f9.camel@hammerspace.com>
         <980CB8E4-0E7F-4F1D-B223-81176BE15A39@oracle.com>
         <20200103164711.GB24306@fieldses.org>
In-Reply-To: <20200103164711.GB24306@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26af4814-6163-4bf6-767b-08d790770000
x-ms-traffictypediagnostic: DM5PR1301MB2106:
x-microsoft-antispam-prvs: <DM5PR1301MB2106411E49E252B640860D50B8230@DM5PR1301MB2106.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(346002)(39830400003)(396003)(189003)(199004)(4326008)(110136005)(5660300002)(71200400001)(186003)(26005)(53546011)(2616005)(316002)(91956017)(86362001)(66946007)(6506007)(54906003)(76116006)(66476007)(64756008)(66556008)(66446008)(36756003)(8936002)(6486002)(81166006)(8676002)(2906002)(478600001)(81156014)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2106;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VhDYdixXA04iImXfYmXV15n0hlrZYOjduNNfwCDF2hLmqk14giC0ZRvKXXzYznHiQC0Rs4FBeeB+VCLdF/ofNxRBV7WaaDVR04zOQaIHYdcdxGTMTZtfTVxSzwRVzr8fEPXA+5kRqOTUwu1FQkv8qvkWeMmJLeUeMZdgTybzq76M+XU9hNLPGgpAXOK1vx8FeEA+bqoyPhaO/ThOzDSl+pV9AZl+2aMpHOAlTnY5VmTOgDv1IwfR79Z0h3fUV+hT6wupv795Ow1AA180R653h0cOvCbqTdVv9HMduV5xQHbw7X95j+3CLrCy0bvywWtyHjj7GzhQmtTfLYtKOTG4kw6uByNlUq7twOjeRU4rOcyb9Ux+iTwQahS+cwzr3nEKV6Nbfe8VvddLoNHV2Hlb8RF5rRy4Uh9l1qgZS02bw5T88rmMatfIsCsNu9Je1AFB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF4BAB3D299DC44882D60C2329107F29@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26af4814-6163-4bf6-767b-08d790770000
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 18:01:47.0573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYTaY9TrKGV0aP64meZGySQSlt0vfdiuSrbj/YODxp4uybMvTaFe7ShP17y0/erA26tuK1ZV8bkpFbXflV3LFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2106
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTAzIGF0IDExOjQ3IC0wNTAwLCBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+
IE9uIFdlZCwgRGVjIDE4LCAyMDE5IGF0IDA2OjIwOjU2UE0gLTA1MDAsIENodWNrIExldmVyIHdy
b3RlOg0KPiA+ID4gT24gRGVjIDEzLCAyMDE5LCBhdCAzOjEyIFBNLCBUcm9uZCBNeWtsZWJ1c3Qg
PA0KPiA+ID4gdHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gRG9lcyBzb21l
dGhpbmcgbGlrZSB0aGUgZm9sbG93aW5nIGhlbHA/DQo+ID4gPiANCj4gPiA+IDg8LS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiBGcm9tIGNh
ZjUxNWM4MmVkNTcyZTRmOTJhYzgyOTNlNWRhNDgxOGRhMGM2Y2UgTW9uIFNlcCAxNyAwMDowMDow
MA0KPiA+ID4gMjAwMQ0KPiA+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+ID4gRGF0ZTogRnJpLCAxMyBEZWMgMjAxOSAxNTowNzoz
MyAtMDUwMA0KPiA+ID4gU3ViamVjdDogW1BBVENIXSBuZnNkOiBGaXggYSBzb2Z0IGxvY2t1cCBy
YWNlIGluDQo+ID4gPiBuZnNkX2ZpbGVfbWFya19maW5kX29yX2NyZWF0ZSgpDQo+ID4gPiANCj4g
PiA+IElmIG5mc2RfZmlsZV9tYXJrX2ZpbmRfb3JfY3JlYXRlKCkga2VlcHMgd2lubmluZyB0aGUg
cmFjZSBmb3IgdGhlDQo+ID4gPiBuZnNkX2ZpbGVfZnNub3RpZnlfZ3JvdXAtPm1hcmtfbXV0ZXgg
YWdhaW5zdCBuZnNkX2ZpbGVfbWFya19wdXQoKQ0KPiA+ID4gdGhlbiBpdCBjYW4gc29mdCBsb2Nr
IHVwLCBzaW5jZSBmc25vdGlmeV9hZGRfaW5vZGVfbWFyaygpIGVuZHMNCj4gPiA+IHVwIGFsd2F5
cyBmaW5kaW5nIGFuIGV4aXN0aW5nIGVudHJ5Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4g
PiAtLS0NCj4gPiA+IGZzL25mc2QvZmlsZWNhY2hlLmMgfCA4ICsrKysrKy0tDQo+ID4gPiAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4g
PiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9maWxlY2FjaGUuYyBiL2ZzL25mc2QvZmlsZWNhY2hlLmMN
Cj4gPiA+IGluZGV4IDljMmIyOWUwNzk3NS4uZjI3NWMxMWM0ZTI4IDEwMDY0NA0KPiA+ID4gLS0t
IGEvZnMvbmZzZC9maWxlY2FjaGUuYw0KPiA+ID4gKysrIGIvZnMvbmZzZC9maWxlY2FjaGUuYw0K
PiA+ID4gQEAgLTEzMiw5ICsxMzIsMTMgQEAgbmZzZF9maWxlX21hcmtfZmluZF9vcl9jcmVhdGUo
c3RydWN0DQo+ID4gPiBuZnNkX2ZpbGUgKm5mKQ0KPiA+ID4gCQkJCQkJIHN0cnVjdCBuZnNkX2Zp
bGVfbWFyaywNCj4gPiA+IAkJCQkJCSBuZm1fbWFyaykpOw0KPiA+ID4gCQkJbXV0ZXhfdW5sb2Nr
KCZuZnNkX2ZpbGVfZnNub3RpZnlfZ3JvdXAtDQo+ID4gPiA+bWFya19tdXRleCk7DQo+ID4gPiAt
CQkJZnNub3RpZnlfcHV0X21hcmsobWFyayk7DQo+ID4gPiAtCQkJaWYgKGxpa2VseShuZm0pKQ0K
PiA+ID4gKwkJCWlmIChuZm0pIHsNCj4gPiA+ICsJCQkJZnNub3RpZnlfcHV0X21hcmsobWFyayk7
DQo+ID4gPiAJCQkJYnJlYWs7DQo+ID4gPiArCQkJfQ0KPiA+ID4gKwkJCS8qIEF2b2lkIHNvZnQg
bG9ja3VwIHJhY2Ugd2l0aA0KPiA+ID4gbmZzZF9maWxlX21hcmtfcHV0KCkgKi8NCj4gPiA+ICsJ
CQlmc25vdGlmeV9kZXN0cm95X21hcmsobWFyaywNCj4gPiA+IG5mc2RfZmlsZV9mc25vdGlmeV9n
cm91cCk7DQo+ID4gPiArCQkJZnNub3RpZnlfcHV0X21hcmsobWFyayk7DQo+ID4gPiAJCX0gZWxz
ZQ0KPiA+ID4gCQkJbXV0ZXhfdW5sb2NrKCZuZnNkX2ZpbGVfZnNub3RpZnlfZ3JvdXAtDQo+ID4g
PiA+bWFya19tdXRleCk7DQo+ID4gPiANCj4gPiANCj4gPiBJJ3ZlIHRyaWVkIHRvIHJlcHJvZHVj
ZSB0aGUgbG9ja3VwIGZvciB0aHJlZSBkYXlzIHdpdGggdGhpcyBwYXRjaA0KPiA+IGFwcGxpZWQg
dG8gbXkgc2VydmVyLiBObyBsb2NrdXAuDQo+ID4gDQo+ID4gVGVzdGVkLWJ5OiBDaHVjayBMZXZl
ciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4gDQo+IEknbSBhcHBseWluZyB0aGlzIGZvciA1
LjUgd2l0aCBDaHVjaydzIHRlc3RlZC1ieSBhbmQ6DQo+IA0KPiAgICAgRml4ZXM6IDY1Mjk0YzFm
MmM1ZSAibmZzZDogYWRkIGEgbmV3IHN0cnVjdCBmaWxlIGNhY2hpbmcgZmFjaWxpdHkNCj4gdG8g
bmZzZCINCj4gDQoNCkkndmUgZ290IG1vcmUgY29taW5nLiBXZSd2ZSBiZWVuIGRvaW5nIGRhdGEg
aW50ZWdyaXR5IHRlc3RzIGFuZCBoYXZlDQpoaXQgc29tZSBpc3N1ZXMgYXJvdW5kIGVycm9yIHJl
cG9ydGluZyB0aGF0IG5lZWQgdG8gYmUgZml4ZWQgaW4ga25mc2QNCmluIG9yZGVyIHRvIGF2b2lk
IHNpbGVudCBjb3JydXB0aW9uIG9mIGRhdGEuDQoNCkknbGwgYmUgc2VuZGluZyBhIGJ1bGsgcGF0
Y2hzZXQgZm9yIDUuNSBzb29uLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==
