Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29067D2CC7
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 16:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfJJOqo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 10:46:44 -0400
Received: from mail-eopbgr730139.outbound.protection.outlook.com ([40.107.73.139]:60646
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfJJOqo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 10 Oct 2019 10:46:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnUYil4/6MI4Pa2QjmYXW2sTUhKqEL7xKM9LCIcp31E1UZoPr3rl2jQGXnZh4omFF20oNud+txBGbJN+tU4EawsVIZ2ljPU1Ivz8Yy4FU6FvRvl22TvbfzyMUTl0jF8JyiSepobgU+TXKGaRRee7Ex3WYEa9oH8Fkc1IPCXFRN9OZHiM9t+BaokTqJ2zThNq4GDqJHdon9Wya8kAH15gn4irVAHDNG1f8NXkjOHYDN3KpDa2OOdDwY59rYm5eXOnnMlzx7J01LSgQWQ7mmtnveC7rORH8LWj4uANWLUwdD4/9zF/bBaToIrHKk6lGbjvyP2yEUL9vr9w8XQgu1/CSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpxiHHFsK08QkDs9VRx8YHaGVTnxtaD+I3A+UIxsIgw=;
 b=W2fJPZExbJ7DreAiMq3G0fTMdW2zt9tspbKqsQC6urnOUNyXIKRohYm6F5G8ZOu4q85fI1WphD5TyHNTOEd9rawHR8vKEUOxOTHn8WEmZc95JCRaltvRFy1RHHQRq9sA6EXTJzKwGUIcfLL8CdRI7Az/6hnkphOV1kC565RjsAA+1U8ExoUNaFeR14c06dzWELCGKwTlCnxs6PcGqfONIsjqkYo66aZFUxc9GBI85RYXJSdD9Tprri2V6gA5nh0ep8Ki68AsXaMq0zeDZiXyn/ADIVVbH1nFHI4Lg9/PY/4meeJaCC5YXY3B2Rtj7qsD0KgsVyluHGlsUuGaAWLeWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpxiHHFsK08QkDs9VRx8YHaGVTnxtaD+I3A+UIxsIgw=;
 b=FhifBekRPOX2k8oDh6A0C9hHd5j3IQf49NOla9R33OY//gqghYgT04ui1x2tf/TdC9CLU924Z28E3aXDl6UP4xb5MIIeDFtaPRh2uSOmLw1PYBv4iezjWUxkMSB1zNND6oceZDg2gZ+QAPa+2ztHPaFC7dKGZYdjiq0c2PKtJL0=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1340.namprd13.prod.outlook.com (10.168.113.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 14:46:40 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::d1be:764d:9347:764e]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::d1be:764d:9347:764e%10]) with mapi id 15.20.2347.016; Thu, 10 Oct
 2019 14:46:40 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jencce.kernel@gmail.com" <jencce.kernel@gmail.com>
Subject: Re: [PATCH] NFSv4: fix stateid refreshing when CLOSE racing with OPEN
Thread-Topic: [PATCH] NFSv4: fix stateid refreshing when CLOSE racing with
 OPEN
Thread-Index: AQHVfz4Dej3IfeNfekKrfX0XpGLKm6dT9I4A
Date:   Thu, 10 Oct 2019 14:46:40 +0000
Message-ID: <f81d80f09c59d78c32fddd535b5604bc05c2a2b5.camel@hammerspace.com>
References: <20191010074020.o2uwtuyegtmfdlze@XZHOUW.usersys.redhat.com>
In-Reply-To: <20191010074020.o2uwtuyegtmfdlze@XZHOUW.usersys.redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a177c067-857b-4b9b-05b1-08d74d90a91b
x-ms-traffictypediagnostic: DM5PR13MB1340:
x-microsoft-antispam-prvs: <DM5PR13MB1340DF190276FE91A51A7DE9B8940@DM5PR13MB1340.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(136003)(376002)(346002)(396003)(199004)(189003)(4001150100001)(316002)(229853002)(305945005)(71190400001)(71200400001)(25786009)(8936002)(76176011)(14454004)(102836004)(86362001)(66066001)(6506007)(5660300002)(6246003)(6512007)(26005)(6486002)(91956017)(66446008)(3846002)(7736002)(2906002)(76116006)(64756008)(66556008)(66946007)(2501003)(8676002)(36756003)(66476007)(6116002)(478600001)(446003)(2616005)(476003)(11346002)(118296001)(486006)(256004)(81156014)(186003)(99286004)(81166006)(14444005)(110136005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1340;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LRI9h2hgGQQX3QPRJbI94oADBkkulVFNXnhgs4BrTsI1Z958QxkVXmJLJM2o9PghmHrbZ6TIJzOw9Ik/tR6tm98fdIj04AMQd1NW5InRlQk8PRChmE3N/4K3z5qbvcJJ8B/V3v8aQYh515K+ql/IggKJHbZEaghOqAJybs4Y0V4aySnlB4Z4b25cRasHbMaD2A/mrlpMXqWAv/13dHFgUjheVrc3TUuhp63jh5gXE1p9KPlbPH1ofmNMaPM2KrnWMk71KzDX5FMeAQ/rHaHdTwxEu7QYSKLJpcazF8ubk8MryipWQKBMZ8DU8BJYzgxEg23FGflQkIysi7OifKIh/PE7SzD54WdbvaqFKwzTVXPbcFjE6bV8+An/+OI0SlK0YPGILDgpxQZOLb/jMWoIynmovBnaxSs5dTUFU+AhMx0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D634695A14355B46A74CB620CFE1035C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a177c067-857b-4b9b-05b1-08d74d90a91b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 14:46:40.2365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCJbcXv7CXemS9Yy5WNjb40nnatT26Xgq7G6BHeQPImXgnfJGPmK9+WMOQIUD8L7VYUEP5vLQ9TowdNiYmd+GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1340
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTEwLTEwIGF0IDE1OjQwICswODAwLCBNdXJwaHkgWmhvdSB3cm90ZToNCj4g
U2luY2UgY29tbWl0Og0KPiAgIFswZTBjYjM1XSBORlN2NDogSGFuZGxlIE5GUzRFUlJfT0xEX1NU
QVRFSUQgaW4gQ0xPU0UvT1BFTl9ET1dOR1JBREUNCj4gDQo+IHhmc3Rlc3RzIGdlbmVyaWMvMTY4
IG9uIHY0LjIgc3RhcnRzIHRvIGZhaWwgYmVjYXVzZSByZWZsaW5rIGNhbGwNCj4gZ2V0czoNCj4g
ICArWEZTX0lPQ19DTE9ORV9SQU5HRTogUmVzb3VyY2UgdGVtcG9yYXJpbHkgdW5hdmFpbGFibGUN
Cj4gDQo+IEluIHRzaGFyayBvdXRwdXQsIE5GUzRFUlJfT0xEX1NUQVRFSUQgc3RhbmRzIG91dCB3
aGVuIGNvbXBhcmluZyB3aXRoDQo+IGdvb2Qgb25lczoNCj4gDQo+ICA1MjEwICAgTkZTIDQwNiBW
NCBSZXBseSAoQ2FsbCBJbiA1MjA5KSBPUEVOIFN0YXRlSUQ6IDB4YWRiNQ0KPiAgNTIxMSAgIE5G
UyAzMTQgVjQgQ2FsbCBHRVRBVFRSIEZIOiAweDhkNDRhNmIxDQo+ICA1MjEyICAgTkZTIDI1MCBW
NCBSZXBseSAoQ2FsbCBJbiA1MjExKSBHRVRBVFRSDQo+ICA1MjEzICAgTkZTIDMxNCBWNCBDYWxs
IEdFVEFUVFIgRkg6IDB4OGQ0NGE2YjENCj4gIDUyMTQgICBORlMgMjUwIFY0IFJlcGx5IChDYWxs
IEluIDUyMTMpIEdFVEFUVFINCj4gIDUyMTYgICBORlMgNDIyIFY0IENhbGwgV1JJVEUgU3RhdGVJ
RDogMHhhODE4IE9mZnNldDogODUxOTY4IExlbjoNCj4gNjU1MzYNCj4gIDUyMTggICBORlMgMjY2
IFY0IFJlcGx5IChDYWxsIEluIDUyMTYpIFdSSVRFDQo+ICA1MjE5ICAgTkZTIDM4MiBWNCBDYWxs
IE9QRU4gREg6IDB4OGQ0NGE2YjEvDQo+ICA1MjIwICAgTkZTIDMzOCBWNCBDYWxsIENMT1NFIFN0
YXRlSUQ6IDB4YWRiNQ0KPiAgNTIyMiAgIE5GUyA0MDYgVjQgUmVwbHkgKENhbGwgSW4gNTIxOSkg
T1BFTiBTdGF0ZUlEOiAweGEzNDINCj4gIDUyMjMgICBORlMgMjUwIFY0IFJlcGx5IChDYWxsIElu
IDUyMjApIENMT1NFIFN0YXR1czoNCj4gTkZTNEVSUl9PTERfU1RBVEVJRA0KPiAgNTIyNSAgIE5G
UyAzMzggVjQgQ2FsbCBDTE9TRSBTdGF0ZUlEOiAweGEzNDINCj4gIDUyMjYgICBORlMgMzE0IFY0
IENhbGwgR0VUQVRUUiBGSDogMHg4ZDQ0YTZiMQ0KPiAgNTIyNyAgIE5GUyAyNjYgVjQgUmVwbHkg
KENhbGwgSW4gNTIyNSkgQ0xPU0UNCj4gIDUyMjggICBORlMgMjUwIFY0IFJlcGx5IChDYWxsIElu
IDUyMjYpIEdFVEFUVFINCj4gDQo+IEl0J3MgZWFzeSB0byByZXByb2R1Y2UuIEJ5IHByaW50aW5n
IHNvbWUgbG9ncywgZm91bmQgdGhhdCB3ZSBhcmUNCj4gbWFraW5nDQo+IENMT1NFIHNlcWlkIGxh
cmdlciB0aGVuIE9QRU4gc2VxaWQgd2hlbiByYWNpbmcuDQo+IA0KPiBGaXggdGhpcyBieSBub3Qg
YnVtcGluZyBzZXFpZCB3aGVuIGl0J3MgZXF1YWwgdG8gT1BFTiBzZXFpZC4gQWxzbw0KPiBwdXQg
dGhlIHdob2xlIGNoYW5naW5nIHByb2Nlc3MgaW50byBzZXFsb2NrIHJlYWQgcHJvdGVjdGlvbiBp
biBjYXNlDQo+IHJlYWxseSBiYWQgbHVjaywgYW5kIHRoaXMgaXMgdGhlIHNhbWUgbG9ja2luZyBi
ZWhhdmlvciB3aXRoIHRoZQ0KPiBvbGQgZGVsZXRlZCBmdW5jdGlvbi4NCj4gDQo+IEZpeGVzOiAw
ZTBjYjM1YjQxN2YgKCJORlN2NDogSGFuZGxlIE5GUzRFUlJfT0xEX1NUQVRFSUQgaW4NCj4gQ0xP
U0UvT1BFTl9ET1dOR1JBREUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNdXJwaHkgWmhvdSA8amVuY2Nl
Lmtlcm5lbEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZnMvbmZzL25mczRwcm9jLmMgfCAxMyArKysr
KysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRw
cm9jLmMNCj4gaW5kZXggMTFlYWZjZi4uNmRiNWEwOSAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL25m
czRwcm9jLmMNCj4gKysrIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gQEAgLTMzMzQsMTIgKzMzMzQs
MTMgQEAgc3RhdGljIHZvaWQNCj4gbmZzNF9zeW5jX29wZW5fc3RhdGVpZChuZnM0X3N0YXRlaWQg
KmRzdCwNCj4gIAkJCWJyZWFrOw0KPiAgCQl9DQo+ICAJCXNlcWlkX29wZW4gPSBzdGF0ZS0+b3Bl
bl9zdGF0ZWlkLnNlcWlkOw0KPiAtCQlpZiAocmVhZF9zZXFyZXRyeSgmc3RhdGUtPnNlcWxvY2ss
IHNlcSkpDQo+IC0JCQljb250aW51ZTsNCj4gIA0KPiAgCQlkc3Rfc2VxaWQgPSBiZTMyX3RvX2Nw
dShkc3QtPnNlcWlkKTsNCj4gIAkJaWYgKChzMzIpKGRzdF9zZXFpZCAtIGJlMzJfdG9fY3B1KHNl
cWlkX29wZW4pKSA8IDApDQo+ICAJCQlkc3QtPnNlcWlkID0gc2VxaWRfb3BlbjsNCj4gKw0KPiAr
CQlpZiAocmVhZF9zZXFyZXRyeSgmc3RhdGUtPnNlcWxvY2ssIHNlcSkpDQo+ICsJCQljb250aW51
ZTsNCg0KV2hhdCdzIHRoZSBpbnRlbnRpb24gb2YgdGhpcyBjaGFuZ2U/IE5laXRoZXIgZHN0X3Nl
cWlkIG5vciBkc3QtPnNlcWlkDQphcmUgcHJvdGVjdGVkIGJ5IHRoZSBzdGF0ZS0+c2VxbG9jayBz
byB3aHkgbW92ZSB0aGlzIGNvZGUgdW5kZXIgdGhlDQpsb2NrLg0KDQo+ICAJCWJyZWFrOw0KPiAg
CX0NCj4gIH0NCj4gQEAgLTMzNjcsMTQgKzMzNjgsMTYgQEAgc3RhdGljIGJvb2wNCj4gbmZzNF9y
ZWZyZXNoX29wZW5fb2xkX3N0YXRlaWQobmZzNF9zdGF0ZWlkICpkc3QsDQo+ICAJCQlicmVhazsN
Cj4gIAkJfQ0KPiAgCQlzZXFpZF9vcGVuID0gc3RhdGUtPm9wZW5fc3RhdGVpZC5zZXFpZDsNCj4g
LQkJaWYgKHJlYWRfc2VxcmV0cnkoJnN0YXRlLT5zZXFsb2NrLCBzZXEpKQ0KPiAtCQkJY29udGlu
dWU7DQo+ICANCj4gIAkJZHN0X3NlcWlkID0gYmUzMl90b19jcHUoZHN0LT5zZXFpZCk7DQo+IC0J
CWlmICgoczMyKShkc3Rfc2VxaWQgLSBiZTMyX3RvX2NwdShzZXFpZF9vcGVuKSkgPj0gMCkNCj4g
KwkJaWYgKChzMzIpKGRzdF9zZXFpZCAtIGJlMzJfdG9fY3B1KHNlcWlkX29wZW4pKSA+IDApDQo+
ICAJCQlkc3QtPnNlcWlkID0gY3B1X3RvX2JlMzIoZHN0X3NlcWlkICsgMSk7DQoNClRoaXMgbmVn
YXRlcyB0aGUgd2hvbGUgaW50ZW50aW9uIG9mIHRoZSBwYXRjaCB5b3UgcmVmZXJlbmNlIGluIHRo
ZQ0KJ0ZpeGVzOicsIHdoaWNoIHdhcyB0byBhbGxvdyB1cyB0byBDTE9TRSBmaWxlcyBldmVuIGlm
IHNlcWlkIGJ1bXBzIGhhdmUNCmJlZW4gbG9zdCBkdWUgdG8gaW50ZXJydXB0ZWQgUlBDIGNhbGxz
IGUuZy4gd2hlbiB1c2luZyAnc29mdCcgb3INCidzb2Z0ZXJyJyBtb3VudHMuDQpXaXRoIHRoZSBh
Ym92ZSBjaGFuZ2UsIHRoZSBjaGVjayBjb3VsZCBqdXN0IGJlIHRvc3NlZCBvdXQgYWx0b2dldGhl
ciwNCmJlY2F1c2UgZHN0X3NlcWlkIHdpbGwgbmV2ZXIgYmVjb21lIGxhcmdlciB0aGFuIHNlcWlk
X29wZW4uDQoNCj4gIAkJZWxzZQ0KPiAgCQkJZHN0LT5zZXFpZCA9IHNlcWlkX29wZW47DQo+ICsN
Cj4gKwkJaWYgKHJlYWRfc2VxcmV0cnkoJnN0YXRlLT5zZXFsb2NrLCBzZXEpKQ0KPiArCQkJY29u
dGludWU7DQo+ICsNCg0KQWdhaW4sIHdoeSB0aGlzIGNoYW5nZSB0byBjb2RlIHRoYXQgZG9lc24n
dCBhcHBlYXIgdG8gbmVlZCBwcm90ZWN0aW9uPw0KSWYgdGhlIGJ1bXAgZG9lcyBzdWNjZWVkIGFi
b3ZlLCB0aGVuIGxvb3BpbmcgYmFjayB3aWxsIGFjdHVhbGx5IGNhdXNlDQp1bnByZWRpY3RhYmxl
IGJlaGF2aW91ci4NCg0KPiAgCQlyZXQgPSB0cnVlOw0KPiAgCQlicmVhazsNCj4gIAl9DQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
