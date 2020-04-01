Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5554319B7F9
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2020 23:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbgDAVz3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Apr 2020 17:55:29 -0400
Received: from mail-dm6nam12on2102.outbound.protection.outlook.com ([40.107.243.102]:15424
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733095AbgDAVz2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Apr 2020 17:55:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYX8ycdnoYBOTWRWuUx3e/zEIfs1OFIvEZ+H7VKXpZSSC/ogP+Boc+wOYDjMam7FOo1MHN9WM1/3YKbfJsHjPEyFwKl4LuhgljgQnfvxMr7Ctyn7N2NtSA+XE6N+Cu8fmNt/ZOvhceakiP82PjpdusHdX1V6aEjUDoDCVBe5rNAInHkzuLqB0mqB6yrCP9kcJjvC5GCWt4pHDVXsJRTLlZ+KsDJs5FiiSycnRdgnS0aUqM2ihkQkJ4ZQS3W47CZqud1i7DM/kT2jqFCI67c09eFgVlTrQvSjOb/zSX4KNMcPs7fFfMpIaPcf6pv/ob85J+DL72v5+pr7QN0Sg8llig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKuIZr10NwD0IRUmjwE4zH5lk16GX1+5RhhFNLfyKPg=;
 b=VmcxV/uSco/W+0EOHbQSlGe+PfOPOPfbxJ/DHFw8Hk8iUvfR7FUMql07xGDqn/V3texl6A+vP56WpIYMEkCR0kBjUwRSquDLSc7aRwL/n5s0OTZNIpi7Rg/NRDuucU+BnEvQ7zoQ+Or50vtUqnKzoh1Nm9kstTwxIQe9yzwndj5TSu28a0KcvJfo7QVGzw1HST2ybKrrFhriQWQBKJmSvIHRT0HtH9FyfYnmVYMQLPTVVEksPPZBeY0P7DhH7rj2cnAKZZCGQyWAjhivxY7uAD0NxOXpS3J4dQkZkq2IMzOIouj/jKD1wXVHAXDvMqx8WfRncDD30FuoMAqL9PYoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKuIZr10NwD0IRUmjwE4zH5lk16GX1+5RhhFNLfyKPg=;
 b=WWmnUl2i/0+JhMsApBZ0a7P7nVxRZ27gGFx0vV/w4eeqKqm17KfaGsfqsfww2Pesvq2GprzMQ/KL4+WD+7rHi/sS/HTdRvc10wQTCtCBh8NHOT6GxS2+zLfwwhBzuY/SSlMkRxdJ6hbaRjNqSwtTn+NbJakmIo99LHjfzgAUbDQ=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3302.namprd13.prod.outlook.com (2603:10b6:610:25::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Wed, 1 Apr
 2020 21:55:26 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36%7]) with mapi id 15.20.2878.012; Wed, 1 Apr 2020
 21:55:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH RFC] sunrpc: Ensure signalled RPC tasks exit
Thread-Topic: [PATCH RFC] sunrpc: Ensure signalled RPC tasks exit
Thread-Index: AQHWCF0MlHCtjD63TkyOwrXd+41btahkz8WA
Date:   Wed, 1 Apr 2020 21:55:26 +0000
Message-ID: <6d1e88145119587069a0077df8b31c9b80656d68.camel@hammerspace.com>
References: <20200401193559.6487.55107.stgit@manet.1015granger.net>
In-Reply-To: <20200401193559.6487.55107.stgit@manet.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f60d5371-d0fd-45f0-6f88-08d7d6876307
x-ms-traffictypediagnostic: CH2PR13MB3302:
x-microsoft-antispam-prvs: <CH2PR13MB33026149F6880D9A5BB4FA1EB8C90@CH2PR13MB3302.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(396003)(39830400003)(366004)(346002)(136003)(76116006)(81156014)(91956017)(81166006)(66946007)(6506007)(8676002)(71200400001)(8936002)(2616005)(110136005)(316002)(186003)(478600001)(86362001)(6512007)(36756003)(26005)(5660300002)(66476007)(66556008)(64756008)(66446008)(2906002)(6486002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mi5vN7EPJWRkeBCutwUAaDdyeqbgScb9cRZXtvKG0stiUAUhGrxF1gFDQAt9sK8BQzoXuPGcNp9puFBU/bBDsCTU4WniiuD9XYvP2sZ6EIuBEPnj9puxdP+9/8HAaVgHD0ZTmcLsFNFns/MD/Mz2cjv2LCV6rlsU+72jSxHXl1IUYmvqjW4p4mpnGzO2WSHGtDLjLHaMuNtOuhrWoQ4YQNrXwpM6ueJ6Vz0f5SwSzpQsgHx/xX2fRSYUeqWo7n4gVxIq2JdodrNZ5KLnCs43pcw+W5AcF53XYSYct9PckrbPtyHmMAmKmDfOE0IbfU4Ysj711/p2LOT+ES8Y+t2vHVvO4A/lrZ41KYn8ErLrmVtIJAr85cBCJODzKSigwVc0bx0nxvEoLj+asBHRjSJ75NCQmmlVrZk8Y0Emdgl4hh1Whzyh6jeuswhQtBLrOPbB
x-ms-exchange-antispam-messagedata: Fu52UcZam816Vxh19HWIUxzm4H/0CefZzgMjydglMJ+cMzaLrFh+yIIYZ9kZPECuhWk0SEo4eeC+SMD81OZpZIi88qphPT8W+cgmvN2ZG4IqoiXLhPD1jW6zalgodoaXGfa320r+tBhW/5XH7KvM7g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2F89BA018331C40B31437BC4A64CABA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60d5371-d0fd-45f0-6f88-08d7d6876307
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 21:55:26.5136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Ipn5E9jN9SMgF6lPC4Yc210bjkL3WQyGB0ThmHljBy/GYHhhIBRnaZBCvKJqYNH5nI8awDc2ZeLfwwwWL8Wkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3302
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTA0LTAxIGF0IDE1OjM3IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
SWYgYW4gUlBDIHRhc2sgaXMgc2lnbmFsZWQgd2hpbGUgaXQgaXMgcnVubmluZyBhbmQgdGhlIHRy
YW5zcG9ydCBpcw0KPiBub3QgY29ubmVjdGVkLCBpdCB3aWxsIG5ldmVyIHNsZWVwIGFuZCBuZXZl
ciBiZSB0ZXJtaW5hdGVkLiBUaGlzIGNhbg0KPiBoYXBwZW4gd2hlbiBhIFJQQyB0cmFuc3BvcnQg
aXMgc2h1dCBkb3duOiB0aGUgcmVtYWluaW5nIHRhc2tzIGFyZQ0KPiBzaWduYWxsZWQsIGJ1dCB0
aGUgdHJhbnNwb3J0IGlzIGRpc2Nvbm5lY3RlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENodWNr
IExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiAtLS0NCj4gIG5ldC9zdW5ycGMvc2No
ZWQuYyB8ICAgMTQgKysrKysrLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBJbnRlcmVzdGVkIGluIGNvbW1lbnRzIGFuZCBz
dWdnZXN0aW9ucy4NCj4gDQo+IE5lYXJseSBldmVyeSB0aW1lIG15IE5GUy9SRE1BIGNsaWVudCB1
bm1vdW50cyB3aGVuIHVzaW5nIGtyYjUsIHRoZQ0KPiB1bW91bnQgaGFuZ3MgKGtpbGxhYmx5KS4g
SSB0cmFja2VkIGl0IGRvd24gdG8gYW4gTkZTdjMgTlVMTCByZXF1ZXN0DQo+IHRoYXQgaXMgc2ln
bmFsbGVkIGJ1dCBsb29wcyBhbmQgZG9lcyBub3QgZXhpdC4NCj4gDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvbmV0L3N1bnJwYy9zY2hlZC5jIGIvbmV0L3N1bnJwYy9zY2hlZC5jDQo+IGluZGV4IDU1ZTkw
MDI1NWIwYy4uOTA1YzMxZjc1NTkzIDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBjL3NjaGVkLmMN
Cj4gKysrIGIvbmV0L3N1bnJwYy9zY2hlZC5jDQo+IEBAIC05MDUsNiArOTA1LDEyIEBAIHN0YXRp
YyB2b2lkIF9fcnBjX2V4ZWN1dGUoc3RydWN0IHJwY190YXNrICp0YXNrKQ0KPiAgCQl0cmFjZV9y
cGNfdGFza19ydW5fYWN0aW9uKHRhc2ssIGRvX2FjdGlvbik7DQo+ICAJCWRvX2FjdGlvbih0YXNr
KTsNCj4gIA0KPiArCQlpZiAoUlBDX1NJR05BTExFRCh0YXNrKSkgew0KPiArCQkJdGFzay0+dGtf
cnBjX3N0YXR1cyA9IC1FUkVTVEFSVFNZUzsNCj4gKwkJCXJwY19leGl0KHRhc2ssIC1FUkVTVEFS
VFNZUyk7DQo+ICsJCQlicmVhazsNCj4gKwkJfQ0KPiArDQoNCkhtbS4uLiBJJ2QgcmVhbGx5IHBy
ZWZlciB0byBhdm9pZCB0aGlzIGtpbmQgb2YgY2hlY2sgaW4gdGhlIHRpZ2h0IGxvb3AuDQpXaHkg
aXMgdGhpcyBOVUxMIHJlcXVlc3QgbG9vcGluZz8NCg0KPiAgCQkvKg0KPiAgCQkgKiBMb2NrbGVz
cyBjaGVjayBmb3Igd2hldGhlciB0YXNrIGlzIHNsZWVwaW5nIG9yIG5vdC4NCj4gIAkJICovDQo+
IEBAIC05MTIsMTQgKzkxOCw2IEBAIHN0YXRpYyB2b2lkIF9fcnBjX2V4ZWN1dGUoc3RydWN0IHJw
Y190YXNrICp0YXNrKQ0KPiAgCQkJY29udGludWU7DQo+ICANCj4gIAkJLyoNCj4gLQkJICogU2ln
bmFsbGVkIHRhc2tzIHNob3VsZCBleGl0IHJhdGhlciB0aGFuIHNsZWVwLg0KPiAtCQkgKi8NCj4g
LQkJaWYgKFJQQ19TSUdOQUxMRUQodGFzaykpIHsNCj4gLQkJCXRhc2stPnRrX3JwY19zdGF0dXMg
PSAtRVJFU1RBUlRTWVM7DQo+IC0JCQlycGNfZXhpdCh0YXNrLCAtRVJFU1RBUlRTWVMpOw0KPiAt
CQl9DQo+IC0NCj4gLQkJLyoNCj4gIAkJICogVGhlIHF1ZXVlLT5sb2NrIHByb3RlY3RzIGFnYWlu
c3QgcmFjZXMgd2l0aA0KPiAgCQkgKiBycGNfbWFrZV9ydW5uYWJsZSgpLg0KPiAgCQkgKg0KPiAN
Ci0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
