Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D8D9D7E3
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 23:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfHZVCg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 17:02:36 -0400
Received: from mail-eopbgr770135.outbound.protection.outlook.com ([40.107.77.135]:16865
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbfHZVCf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 17:02:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW9svnwz3tTVS9liAzaNndeLVHifWGUtT3dCI+u3794NPDQRBzCtjQkgx8/FseL8O8GW++6QmKCMKZseY8F8hm7Q+5fyrugB/97H/myr+r0O+mKCCUbN58nHvv6mUFyN+e+VLaaBQz7fsEmg/PhH1o8k4kq/wo1PeHItGNtoweTTFEpkqI/UU/52/aaEoSotH+LK3yC9mTbGAc0KC7EDBVtwqvwSfykH2MPBHMaVbBY4P0iWXBP51LYFjrI8TKOIeD+1aliWiewhfDcXKUzmhWYCO0zl41Jh2LALKV4xaqNNPUnzSnlcn+KYGcT/+W0vLpCywy2bAoMFRSkWC5vI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJoVjvMl8qqFwZLO7WkFaf4E3MdbaiBErkQHKH9YVZo=;
 b=cKsMv+xgGIMvoKAycmzORuQ6EaJeiVhZdta6bmlc3VntAatVP7yngQNobrbRhlhZHy4aucYWqCzTbhmhIItLiAvtfhdnAbfdlNB7X+m8NSe1VRZND1fEXkpYhzsadqr7IQQu6vwUA04S6a05qLHvrxsJ89K8Wl2a/yXWAzqZIMPEOI98p1zRtc4mKKZz1cTQFm+C+sSWh9SpOaRlIy9MG8cuM3vne5UPiKTtnaZGjMveyN57oEUY/MpSClICP0uLQCQjou3MCJE7llQGogCI4PuYKNqkQbmK/2nlXFauvqRmb+vg/Rq1f6Cb7cgiGFNgtf9l4SD/Yxq1LnxzXXjJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJoVjvMl8qqFwZLO7WkFaf4E3MdbaiBErkQHKH9YVZo=;
 b=BSlPevFpSSU9/5npDTvRq7RB95gAO8WzTiIKFF8DzmU5epvjXmZFBViBj9mJ+/3nzvAEtJZyiEEKQjBwfgxbujt3U0ICJdYR8j7kzJHh0dDN7sUcPGi6rHvyOlDwhFcQ//vEYxJohbyFqSESSYrR6YndcvY0+/Z7ALesBxzNvk0=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1018.namprd13.prod.outlook.com (10.168.236.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.15; Mon, 26 Aug 2019 21:02:31 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75%7]) with mapi id 15.20.2220.013; Mon, 26 Aug 2019
 21:02:31 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Thread-Topic: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Thread-Index: AQHVXC7WXUD5cV8FEUS4EYbsSk6I0qcN59MAgAAC84A=
Date:   Mon, 26 Aug 2019 21:02:31 +0000
Message-ID: <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
         <20190826205156.GA27834@fieldses.org>
In-Reply-To: <20190826205156.GA27834@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 564ee2fd-e95f-4ddb-4f67-08d72a68b5ea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1018;
x-ms-traffictypediagnostic: DM5PR13MB1018:
x-microsoft-antispam-prvs: <DM5PR13MB101881AAAC7A84EF950DAFCCB8A10@DM5PR13MB1018.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(346002)(396003)(136003)(376002)(39840400004)(52314003)(189003)(199004)(86362001)(2906002)(118296001)(6116002)(3846002)(256004)(14444005)(71190400001)(2501003)(5660300002)(71200400001)(66066001)(36756003)(14454004)(478600001)(76176011)(66946007)(76116006)(91956017)(64756008)(6506007)(2351001)(229853002)(53936002)(54906003)(25786009)(6486002)(6436002)(316002)(66446008)(5640700003)(99286004)(66476007)(66556008)(6512007)(1730700003)(8676002)(6246003)(486006)(8936002)(81156014)(476003)(446003)(2616005)(11346002)(81166006)(4326008)(6916009)(186003)(102836004)(305945005)(26005)(7736002)(17423001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1018;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZmsY/+eUliH1ORl/2IH9dfE27xZlfT8o9VDiufNOeFBt4oPhSCt3q1tn6VVQFmJV7vuVHvOFde1OQzanThl0WFGs9NGCez01H4228S9RvX/BtXcq6GoNUVb+vF+v3SyN/wpNMICJc4eAXo3zoHWSc9XIyQSWlCjT/lvnC1wGPRO8BPtop/x2nGtARCI6aBKPKxoAOjxhQKXIzTkLtLwvE48lp3gXPduLpkY8Ppw5enNfZMm8rA3p2FkT49Myb/wc+oL7cBlag/AXkryk0evL0n4+LASTAJPGi1v9jQ0TsQvP4JX7TveZlQVC8AUfzg8D75au3KSAne3bEXZ33x6AmrsOR2uAap8rrmLlL0h6TWpx0/fis/MgjxGTWZRPqU7Lu2QuLBIB1DT1YhoBXOUbhhgSThY2kygRcai0yXzWEp4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B585434BD639004BB51EEE7AB9B25047@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564ee2fd-e95f-4ddb-4f67-08d72a68b5ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 21:02:31.1992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQomA3j7K5fF4xABtu5gBVFMFVbu+UqAatIYO63IuRmy321dIivmx4Yu7PFtJ1yTOqOZdxUuzWVTjXeuG+0DHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1018
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTI2IGF0IDE2OjUxIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDI2LCAyMDE5IGF0IDEyOjUwOjE4UE0gLTA0MDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiBSZWNlbnRseSwgYSBudW1iZXIgb2YgY2hhbmdlcyB3ZW50IGludG8g
dGhlIGtlcm5lbCB0byB0cnkgdG8gZW5zdXJlDQo+ID4gdGhhdCBJL08gZXJyb3JzIChzcGVjaWZp
Y2FsbHkgd3JpdGUgZXJyb3JzKSBhcmUgcmVwb3J0ZWQgdG8gdGhlDQo+ID4gYXBwbGljYXRpb24g
b25jZSBhbmQgb25seSBvbmNlLiBUaGUgdmVoaWNsZSBmb3IgZW5zdXJpbmcgdGhlIGVycm9ycw0K
PiA+IGFyZSByZXBvcnRlZCBpcyB0aGUgc3RydWN0IGZpbGUsIHdoaWNoIHVzZXMgdGhlICdmX3di
X2VycicgZmllbGQgdG8NCj4gPiB0cmFjayB3aGljaCBlcnJvcnMgaGF2ZSBiZWVuIHJlcG9ydGVk
Lg0KPiA+IA0KPiA+IFRoZSBwcm9ibGVtIGlzIHRoYXQgZXJyb3JzIGFyZSBtYWlubHkgaW50ZW5k
ZWQgdG8gYmUgcmVwb3J0ZWQNCj4gPiB0aHJvdWdoDQo+ID4gZnN5bmMoKS4gSWYgdGhlIGNsaWVu
dCBpcyBkb2luZyBzeW5jaHJvbm91cyB3cml0ZXMsIHRoZW4gYWxsIGlzDQo+ID4gd2VsbCwNCj4g
PiBidXQgaWYgaXQgaXMgZG9pbmcgdW5zdGFibGUgd3JpdGVzLCB0aGVuIHRoZSBlcnJvcnMgbWF5
IG5vdCBiZQ0KPiA+IHJlcG9ydGVkIHVudGlsIHRoZSBjbGllbnQgY2FsbHMgQ09NTUlULiBJZiB0
aGUgZmlsZSBjYWNoZSBoYXMNCj4gPiB0aHJvd24gb3V0IHRoZSBzdHJ1Y3QgZmlsZSwgZHVlIHRv
IG1lbW9yeSBwcmVzc3VyZSwgb3IganVzdCBiZWNhdXNlDQo+ID4gdGhlIGNsaWVudCB0b29rIGEg
bG9uZyB3aGlsZSBiZXR3ZWVuIHRoZSBsYXN0IFdSSVRFIGFuZCB0aGUgQ09NTUlULA0KPiA+IHRo
ZW4gdGhlIGVycm9yIHJlcG9ydCBtYXkgYmUgbG9zdCwgYW5kIHRoZSBjbGllbnQgbWF5IGp1c3Qg
dGhpbmsNCj4gPiBpdHMgZGF0YSBpcyBzYWZlbHkgc3RvcmVkLg0KPiANCj4gVGhlc2Ugd2VyZSBs
b3N0IGJlZm9yZSB0aGUgZmlsZSBjYWNoaW5nIHBhdGNoZXMgYXMgd2VsbCwgcmlnaHQ/ICBPcg0K
PiBpcw0KPiB0aGVyZSBzb21lIHJlZ3Jlc3Npb24/IA0KDQpDb3JyZWN0LiBUaGlzIGlzIG5vdCBh
IHJlZ3Jlc3Npb24sIGJ1dCBhbiBhdHRlbXB0IHRvIGZpeCBhIHByb2JsZW0gdGhhdA0KaGFzIGV4
aXN0ZWQgZm9yIHNvbWUgdGltZSBub3cuDQoNCj4gDQo+ID4gTm90ZSB0aGF0IHRoZSBwcm9ibGVt
IGlzIGNvbXBvdW5kZWQgYnkgdGhlIGZhY3QgdGhhdCBORlN2MyBpcw0KPiA+IHN0YXRlbGVzcywN
Cj4gPiBzbyB0aGUgc2VydmVyIG5ldmVyIGtub3dzIHRoYXQgdGhlIGNsaWVudCBtYXkgaGF2ZSBy
ZWJvb3RlZCwgc28NCj4gPiB0aGVyZQ0KPiA+IGNhbiBiZSBubyBndWFyYW50ZWUgdGhhdCBhIENP
TU1JVCB3aWxsIGV2ZXIgYmUgc2VudC4NCj4gPiANCj4gPiBUaGUgZm9sbG93aW5nIHBhdGNoIHNl
dCBhdHRlbXB0cyB0byByZW1lZHkgdGhlIHNpdHVhdGlvbiB1c2luZyAyDQo+ID4gc3RyYXRlZ2ll
czoNCj4gPiANCj4gPiAxKSBJZiB0aGUgaW5vZGUgaXMgZGlydHksIHRoZW4gYXZvaWQgZ2FyYmFn
ZSBjb2xsZWN0aW5nIHRoZSBmaWxlDQo+ID4gICAgZnJvbSB0aGUgZmlsZSBjYWNoZS4NCj4gPiAy
KSBJZiB0aGUgZmlsZSBpcyBjbG9zZWQsIGFuZCB3ZSBzZWUgdGhhdCBpdCB3b3VsZCBoYXZlIHJl
cG9ydGVkDQo+ID4gICAgYW4gZXJyb3IgdG8gQ09NTUlULCB0aGVuIHdlIGJ1bXAgdGhlIGJvb3Qg
dmVyaWZpZXIgaW4gb3JkZXIgdG8NCj4gPiAgICBlbnN1cmUgdGhlIGNsaWVudCByZXRyYW5zbWl0
cyBhbGwgaXRzIHdyaXRlcy4NCj4gDQo+IFNvdW5kcyBzZW5zaWJsZSB0byBtZS4NCj4gDQo+ID4g
Tm90ZSB0aGF0IGlmIG11bHRpcGxlIGNsaWVudHMgd2VyZSB3cml0aW5nIHRvIHRoZSBzYW1lIGZp
bGUsIHRoZW4NCj4gPiB3ZSBwcm9iYWJseSB3YW50IHRvIGJ1bXAgdGhlIGJvb3QgdmVyaWZpZXIg
YW55d2F5LCBzaW5jZSBvbmx5IG9uZQ0KPiA+IENPTU1JVCB3aWxsIHNlZSB0aGUgZXJyb3IgcmVw
b3J0IChiZWNhdXNlIHRoZSBjYWNoZWQgZmlsZSBpcyBhbHNvDQo+ID4gc2hhcmVkKS4NCj4gDQo+
IEknbSBjb25mdXNlZCBieSB0aGUgInByb2JhYmx5IHNob3VsZCIuICBTbyB0aGF0J3MgZnV0dXJl
IHdvcms/ICBJDQo+IGd1ZXNzDQo+IGl0J2QgbWVhbiBzb21lIGFkZGl0aW9uYWwgd29yayB0byBp
ZGVudGlmeSB0aGF0IGNhc2UuICBZb3UgY2FuJ3QNCj4gcmVhbGx5DQo+IGV2ZW4gZGlzdGluZ3Vp
c2ggY2xpZW50cyBpbiB0aGUgTkZTdjMgY2FzZSwgYnV0IEkgc3VwcG9zZSB5b3UgY291bGQNCj4g
dXNlDQo+IElQIGFkZHJlc3Mgb3IgVENQIGNvbm5lY3Rpb24gYXMgYW4gYXBwcm94aW1hdGlvbi4N
Cg0KSSdtIHN1Z2dlc3Rpbmcgd2Ugc2hvdWxkIGRvIHRoaXMgdG9vLCBidXQgSSBoYXZlbid0IGRv
bmUgc28geWV0IGluDQp0aGVzZSBwYXRjaGVzLiBJJ2QgbGlrZSB0byBoZWFyIG90aGVyIG9waW5p
b25zIChwYXJ0aWN1bGFybHkgZnJvbSB5b3UsDQpDaHVjayBhbmQgSmVmZikuDQoNCj4gLS1iLg0K
PiANCj4gPiBTbyBpbiBvcmRlciB0byBpbXBsZW1lbnQgdGhlIGFib3ZlIHN0cmF0ZWd5LCB3ZSBm
aXJzdCBoYXZlIHRvIGRvDQo+ID4gdGhlIGZvbGxvd2luZzogc3BsaXQgdXAgdGhlIGZpbGUgY2Fj
aGUgdG8gYWN0IHBlciBuZXQgbmFtZXNwYWNlLA0KPiA+IHNpbmNlIHRoZSBib290IHZlcmlmaWVy
IGlzIHBlciBuZXQgbmFtZXNwYWNlLiBUaGVuIGFkZCBhIGhlbHBlcg0KPiA+IHRvIHVwZGF0ZSB0
aGUgYm9vdCB2ZXJpZmllci4NCj4gPiANCj4gPiBUcm9uZCBNeWtsZWJ1c3QgKDMpOg0KPiA+ICAg
bmZzZDogbmZzZF9maWxlIGNhY2hlIGVudHJpZXMgc2hvdWxkIGJlIHBlciBuZXQgbmFtZXNwYWNl
DQo+ID4gICBuZnNkOiBTdXBwb3J0IHRoZSBzZXJ2ZXIgcmVzZXR0aW5nIHRoZSBib290IHZlcmlm
aWVyDQo+ID4gICBuZnNkOiBEb24ndCBnYXJiYWdlIGNvbGxlY3QgZmlsZXMgdGhhdCBtaWdodCBj
b250YWluIHdyaXRlIGVycm9ycw0KPiA+IA0KPiA+ICBmcy9uZnNkL2V4cG9ydC5jICAgIHwgIDIg
Ky0NCj4gPiAgZnMvbmZzZC9maWxlY2FjaGUuYyB8IDc2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLQ0KPiA+IC0tLS0tLQ0KPiA+ICBmcy9uZnNkL2ZpbGVjYWNoZS5oIHwg
IDMgKy0NCj4gPiAgZnMvbmZzZC9uZXRucy5oICAgICB8ICA0ICsrKw0KPiA+ICBmcy9uZnNkL25m
czN4ZHIuYyAgIHwgMTMgKysrKystLS0NCj4gPiAgZnMvbmZzZC9uZnM0cHJvYy5jICB8IDE0ICsr
Ky0tLS0tLQ0KPiA+ICBmcy9uZnNkL25mc2N0bC5jICAgIHwgIDEgKw0KPiA+ICBmcy9uZnNkL25m
c3N2Yy5jICAgIHwgMzIgKysrKysrKysrKysrKysrKysrLQ0KPiA+ICA4IGZpbGVzIGNoYW5nZWQs
IDExNSBpbnNlcnRpb25zKCspLCAzMCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiAtLSANCj4gPiAy
LjIxLjANCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIs
IEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
