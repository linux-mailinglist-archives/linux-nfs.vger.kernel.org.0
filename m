Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91BA274978
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 21:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgIVTs1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 15:48:27 -0400
Received: from mail-mw2nam10on2097.outbound.protection.outlook.com ([40.107.94.97]:42743
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbgIVTs1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 22 Sep 2020 15:48:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anUwk9QYq+TmJzRDle0uaClX5yZnozqfwwLFmdMnCyVsQ/UYz06wFRbO6HQDHBBiwulnb1dlx4hGxWEk4vO82TBghEZFkwNMw1Afgb+3ecRchnD/k/QnRBIgYvVlpO+klgUnbxbY7lLz/skt1zc7WokE0sH3cQuh+XOgBsx2wRN4rX+Nji+LxgkqS2EgC/Eo/Y6DIYdV9NmpmVHus4Fo5RfvDZbsYX/44WVUTss82uFUN/GCsB9lUQJR4qP2jzT1PRWZGzQPoq3S7PG1EY6D0kBk0el2hI2ZaLAQutf8NF0wghHiXX+A+O15uoz+uZ3aU3nXNuzAkAxdOG9612op2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ubGUi0RgPYtzXdMshVHwlm3KqEP/br3nUo35VyjpBw=;
 b=kLI4bXZxkzZODbW8SLmng8LLwkbJBrI11YD+/EJ5mq3wG7+bfiVA/zVr+x8KvrK53octM+/Pxc11w0VGZPnQeUE3FR/FKm7Qe6B52lum2LRlEk9/g7ojGWM0zEyitw5FOIXni3r6CTjtFwDQ+JCi1RevVRPNxVSL/cQTAhvUK7xr0kl6JJcWVih/VeDlO+xJFYBmU0y1uKIT1GD9Tz6TCT+XI9nHdaMWMi5XtQaXiBQ7qMeskERKgaujKv0p2yabj+NKlvATMRBMtT4Z/cEwl8oq1QSUL7+zY6PSKyPIt9BG42YQTsvWVgu3QzOMgzkPEly6j6l0N5LxwV6iu3eBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ubGUi0RgPYtzXdMshVHwlm3KqEP/br3nUo35VyjpBw=;
 b=OOyLOqVvatOp7TvdpPZOZakEcenkcjOxcyQS/egu79cuNOp8cHL2Ia1fYrxNPVTJfPtB6IjoyaM4Q3xvDMvgnuCvbYbHDg5NHzjBQQYcQTBCUR+LahZhy/394hGULu1S2jrpPfjh32YcazFS3eevMZiaDT2e11vQvSMAg4fY+ec=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB2894.namprd13.prod.outlook.com (2603:10b6:208:ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.10; Tue, 22 Sep
 2020 19:48:24 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%6]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 19:48:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2 v2] NFSv4: Fix a livelock when CLOSE pre-emptively
 bumps state sequence
Thread-Topic: [PATCH 1/2 v2] NFSv4: Fix a livelock when CLOSE pre-emptively
 bumps state sequence
Thread-Index: AQHWkRTNIqDVyz0uzUW0tMAc3PwMmal1EH0A
Date:   Tue, 22 Sep 2020 19:48:24 +0000
Message-ID: <d6c2ce2b4c0517bd430b4005c4c96d118fba6f3a.camel@hammerspace.com>
References: <cover.1600801124.git.bcodding@redhat.com>
         <a641f9a42786d4699ec99cafa14ab5272a9362bf.1600801124.git.bcodding@redhat.com>
In-Reply-To: <a641f9a42786d4699ec99cafa14ab5272a9362bf.1600801124.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6a5b835-9c02-4e6e-081e-08d85f3077a7
x-ms-traffictypediagnostic: MN2PR13MB2894:
x-microsoft-antispam-prvs: <MN2PR13MB28949F422FD46C0396BBE182B83B0@MN2PR13MB2894.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0rYnVL0vC8iUU0Nm1teDSG6cLODT8bnwQm10daZERvUMC0umFC2d8lP9EJmP2voO7loN8dXdj3/k103WNXHCSAFUZ4Y9BXoPdlyxS29Ans4i+o2cSCXM+VfpOSJy/pIUpQa0HalIZf/eD/gmnNEY8CVYN2LgXelIO1LveGCxceio6MJU2FzHuu15YjIzekyORvDJTSNbDugxZ7/6bLc8SbNXNX40ujttvueKvGZlpnwNDJqku5EjoV6CNq10tsIl+/gylgkER9nU/TjpwVwHBs4J38ueNotKS5WXtYDI0xTF5LcOgXMOCYYbfRTMfaQRUfd8KSNf9HViV812FOxl86w3qFC/9Z/8TmIdNWBTXuzzis1VreTpUjzDSUUS2D9/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(396003)(136003)(366004)(376002)(6512007)(2906002)(66946007)(76116006)(6506007)(86362001)(6486002)(5660300002)(91956017)(4326008)(71200400001)(36756003)(64756008)(66556008)(66476007)(66446008)(8936002)(110136005)(2616005)(83380400001)(8676002)(26005)(186003)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ACo5vaTF7F38Q1JmOJs+Z0P8pe4rcqT7nEkRb7inxfCwom5cb+4EY6sKmnJ48P9jjPqDV9JJKFVKq0y3zyImdHaAYfjC1/3kcCsSLkPCQ+31vVgD6SwcB4DwmwyoUzA5gjOgisne8eS9FTP7kZcnKS/RE9HbeUv1N/gUKsVNX+nb2vXb7Txhmi6kPbioerOVJndB+botB4xCyGxqM9Y2bnEECusyStVvPXiWC8ENRL3rKsYiVJYoFrMTKbvHrzKA379CA2HXWfgzCl58Efh64i2WOC3AfoKaKxH+h6xKiDZZAv9ASkZSYm9F1hm2FKgh0Np8fSCK25Qg+uhJN15AOos7CtrXc9D7S8OERN3faDpYCAghWgkvWXrS4AEn/jZ34Exzxu1W8QFZGebULV/BVusH717mIPn1LKsBYphKkKHGPHYoYkvvJiNgYyogxL6+qkUVy9SlWHjlgOnFAHxojFyUTu1rr4t4taodU7IsUEwdHM9G5Db03q09BfGJoRnL2hv0ab7+c+giD+kWuE4ikad+6U7T5nyL4YXTrNJ5ZRBjeq7e4iau9lm/8JFtLs9lCAueJRS/KAc+ozOQLXnRco4OrgVBP4Es2YB3nscBEFjjX9lvkP7t5bENDgUpf5bijjw1KXume551vMIulVzLPg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <80C872BDE54AA04EBBB8B3307E374B37@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a5b835-9c02-4e6e-081e-08d85f3077a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 19:48:24.0940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoP4FG7SxqU/yUfZIw+gFmsGCm3l6hg6gdovQzhh6Wdw1/RKfYkcla/h4EUE2frt0gAd8GIqE3mWBZoVJ77R3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2894
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTIyIGF0IDE1OjE1IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBTaW5jZSBjb21taXQgMGUwY2IzNWI0MTdmICgiTkZTdjQ6IEhhbmRsZSBORlM0RVJS
X09MRF9TVEFURUlEIGluDQo+IENMT1NFL09QRU5fRE9XTkdSQURFIikgdGhlIGZvbGxvd2luZyBs
aXZlbG9jayBtYXkgb2NjdXIgaWYgYSBDTE9TRQ0KPiByYWNlcw0KPiB3aXRoIHRoZSB1cGRhdGUg
b2YgdGhlIG5mc19zdGF0ZToNCj4gDQo+IFByb2Nlc3MgMSAgICAgICAgICAgUHJvY2VzcyAyICAg
ICAgICAgICBTZXJ2ZXINCj4gPT09PT09PT09ICAgICAgICAgICA9PT09PT09PT0gICAgICAgICAg
ID09PT09PT09DQo+ICBPUEVOIGZpbGUNCj4gICAgICAgICAgICAgICAgICAgICBPUEVOIGZpbGUN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJlcGx5IE9QRU4gKDEp
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSZXBseSBPUEVOICgy
KQ0KPiAgVXBkYXRlIHN0YXRlICgxKQ0KPiAgQ0xPU0UgZmlsZSAoMSkNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJlcGx5IE9MRF9TVEFURUlEICgxKQ0KPiAgQ0xP
U0UgZmlsZSAoMikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJl
cGx5IENMT1NFICgtMSkNCj4gICAgICAgICAgICAgICAgICAgICBVcGRhdGUgc3RhdGUgKDIpDQo+
ICAgICAgICAgICAgICAgICAgICAgd2FpdCBmb3Igc3RhdGUgY2hhbmdlDQo+ICBPUEVOIGZpbGUN
Cj4gICAgICAgICAgICAgICAgICAgICB3YWtlDQo+ICBDTE9TRSBmaWxlDQo+ICBPUEVOIGZpbGUN
Cj4gICAgICAgICAgICAgICAgICAgICB3YWtlDQo+ICBDTE9TRSBmaWxlDQo+ICAuLi4NCj4gICAg
ICAgICAgICAgICAgICAgICAuLi4NCj4gDQo+IEFzIGxvbmcgYXMgdGhlIGZpcnN0IHByb2Nlc3Mg
Y29udGludWVzIHVwZGF0aW5nIHN0YXRlLCB0aGUgc2Vjb25kDQo+IHByb2Nlc3MNCj4gd2lsbCBm
YWlsIHRvIGV4aXQgdGhlIGxvb3AgaW4gbmZzX3NldF9vcGVuX3N0YXRlaWRfbG9ja2VkKCkuICBU
aGlzDQo+IGxpdmVsb2NrDQo+IGhhcyBiZWVuIG9ic2VydmVkIGluIGdlbmVyaWMvMTY4Lg0KPiAN
Cj4gRml4IHRoaXMgYnkgZGV0ZWN0aW5nIHRoZSBjYXNlIGluIG5mc19uZWVkX3VwZGF0ZV9vcGVu
X3N0YXRlaWQoKSBhbmQNCj4gdGhlbiBleGl0IHRoZSBsb29wIGlmOg0KPiAgLSB0aGUgc3RhdGUg
aXMgTkZTX09QRU5fU1RBVEUsIGFuZA0KPiAgLSB0aGUgc3RhdGVpZCBzZXF1ZW5jZSBpcyA+IDEs
IGFuZA0KPiAgLSB0aGUgc3RhdGVpZCBkb2Vzbid0IG1hdGNoIHRoZSBjdXJyZW50IG9wZW4gc3Rh
dGVpZA0KPiANCj4gRml4ZXM6IDBlMGNiMzViNDE3ZiAoIk5GU3Y0OiBIYW5kbGUgTkZTNEVSUl9P
TERfU1RBVEVJRCBpbg0KPiBDTE9TRS9PUEVOX0RPV05HUkFERSIpDQo+IENjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnICMgdjUuNCsNCj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gQ29kZGluZ3Rv
biA8YmNvZGRpbmdAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBmcy9uZnMvbmZzNHByb2MuYyB8IDI3
ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2Vy
dGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0
cHJvYy5jIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gaW5kZXggNmU5NWM4NWZlMzk1Li45ZGIyOWE0
Mzg1NDAgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9uZnM0cHJvYy5jDQo+ICsrKyBiL2ZzL25mcy9u
ZnM0cHJvYy5jDQo+IEBAIC0xNTg4LDE4ICsxNTg4LDI1IEBAIHN0YXRpYyB2b2lkDQo+IG5mc190
ZXN0X2FuZF9jbGVhcl9hbGxfb3Blbl9zdGF0ZWlkKHN0cnVjdCBuZnM0X3N0YXRlICpzdGF0ZSkN
Cj4gIHN0YXRpYyBib29sIG5mc19uZWVkX3VwZGF0ZV9vcGVuX3N0YXRlaWQoc3RydWN0IG5mczRf
c3RhdGUgKnN0YXRlLA0KPiAgCQljb25zdCBuZnM0X3N0YXRlaWQgKnN0YXRlaWQpDQo+ICB7DQo+
IC0JaWYgKHRlc3RfYml0KE5GU19PUEVOX1NUQVRFLCAmc3RhdGUtPmZsYWdzKSA9PSAwIHx8DQo+
IC0JICAgICFuZnM0X3N0YXRlaWRfbWF0Y2hfb3RoZXIoc3RhdGVpZCwgJnN0YXRlLT5vcGVuX3N0
YXRlaWQpKSB7DQo+IC0JCWlmIChzdGF0ZWlkLT5zZXFpZCA9PSBjcHVfdG9fYmUzMigxKSkNCj4g
Kwlib29sIHN0YXRlX21hdGNoZXNfb3RoZXIgPSBuZnM0X3N0YXRlaWRfbWF0Y2hfb3RoZXIoc3Rh
dGVpZCwNCj4gJnN0YXRlLT5vcGVuX3N0YXRlaWQpOw0KPiArCWJvb2wgc2VxaWRfb25lID0gc3Rh
dGVpZC0+c2VxaWQgPT0gY3B1X3RvX2JlMzIoMSk7DQo+ICsNCj4gKwlpZiAodGVzdF9iaXQoTkZT
X09QRU5fU1RBVEUsICZzdGF0ZS0+ZmxhZ3MpKSB7DQo+ICsJCS8qIFRoZSBjb21tb24gY2FzZSAt
IHdlJ3JlIHVwZGF0aW5nIHRvIGEgbmV3IHNlcXVlbmNlDQo+IG51bWJlciAqLw0KPiArCQlpZiAo
c3RhdGVfbWF0Y2hlc19vdGhlciAmJg0KPiBuZnM0X3N0YXRlaWRfaXNfbmV3ZXIoc3RhdGVpZCwg
JnN0YXRlLT5vcGVuX3N0YXRlaWQpKSB7DQo+ICsJCQluZnNfc3RhdGVfbG9nX291dF9vZl9vcmRl
cl9vcGVuX3N0YXRlaWQoc3RhdGUsDQo+IHN0YXRlaWQpOw0KPiArCQkJcmV0dXJuIHRydWU7DQo+
ICsJCX0NCj4gKwl9IGVsc2Ugew0KPiArCQkvKiBUaGlzIGlzIHRoZSBmaXJzdCBPUEVOICovDQo+
ICsJCWlmICghc3RhdGVfbWF0Y2hlc19vdGhlciAmJiBzZXFpZF9vbmUpIHsNCg0KV2h5IGFyZSB3
ZSBsb29raW5nIGF0IHRoZSB2YWx1ZSBvZiBzdGF0ZV9tYXRjaGVzX290aGVyIGhlcmU/IElmIHRo
ZQ0KTkZTX09QRU5fU1RBVEUgZmxhZ3MgaXMgbm90IHNldCwgdGhlbiB0aGUgc3RhdGUtPm9wZW5f
c3RhdGVpZCBpcyBub3QNCmluaXRpYWxpc2VkLCBzbyBob3cgZG9lcyBpdCBtYWtlIHNlbnNlIHRv
IGxvb2sgYXQgYSBjb21wYXJpc29uIHdpdGggdGhlDQppbmNvbWluZyBzdGF0ZWlkPw0KDQo+ICAJ
CQluZnNfc3RhdGVfbG9nX3VwZGF0ZV9vcGVuX3N0YXRlaWQoc3RhdGUpOw0KPiAtCQllbHNlDQo+
ICsJCQlyZXR1cm4gdHJ1ZTsNCj4gKwkJfQ0KPiArCQlpZiAoIXN0YXRlX21hdGNoZXNfb3RoZXIg
JiYgIXNlcWlkX29uZSkgew0KDQpEaXR0by4NCg0KPiAgCQkJc2V0X2JpdChORlNfU1RBVEVfQ0hB
TkdFX1dBSVQsICZzdGF0ZS0+ZmxhZ3MpOw0KPiAtCQlyZXR1cm4gdHJ1ZTsNCj4gLQl9DQo+IC0N
Cj4gLQlpZiAobmZzNF9zdGF0ZWlkX2lzX25ld2VyKHN0YXRlaWQsICZzdGF0ZS0+b3Blbl9zdGF0
ZWlkKSkgew0KPiAtCQluZnNfc3RhdGVfbG9nX291dF9vZl9vcmRlcl9vcGVuX3N0YXRlaWQoc3Rh
dGUsDQo+IHN0YXRlaWQpOw0KPiAtCQlyZXR1cm4gdHJ1ZTsNCj4gKwkJCXJldHVybiB0cnVlOw0K
PiArCQl9DQo+ICAJfQ0KPiAgCXJldHVybiBmYWxzZTsNCj4gIH0NCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
