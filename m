Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438211DBC31
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2020 20:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgETSBL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 May 2020 14:01:11 -0400
Received: from mail-eopbgr760099.outbound.protection.outlook.com ([40.107.76.99]:26360
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbgETSBK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 20 May 2020 14:01:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9y3Q+BKiETlAcOyJ+8iJ25b6RduEUSuqjTQ5FshsgIAwOGvZCaLzDaXQw4ceDhvFQiJpU0OeyRkHSXqiOebOFN+QEvM9WsWdHc8yoO9bMZEnhgpfh7XA+FkskU5hrw7WCWx43JmU4f6ly3N+tUHuBA5jhYFh2uPmHKWfGo1zlEEgr07zcAERumMoBKRhYL1c4l6+Z7i9SO4UP+emqAIFhHKJQjNdoGSEEmwdNYkkAW2uLsA0XOsV3uHzVVxW7C77LnqIULvkSvUvtEJ6Rop5m8Em00izWuro7clUoDRK/0iKsI+2msptsD+sQ8Zl8X6VDJzwBAvHh5eomOOAzSHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyq/0tHuJEATYFx6shf7Kk5W+8BdqFoN4BwerzFZd1w=;
 b=SkYzGHkeZP0kCwoJ/7Eez0g9lwhuEjjeKPXkUEXQ8D/N+w+HRQwBN5Zjie/5u0v7PjAP0dAgAKLuQtg+z7CAHuLDbs9sMh/ln6eYiByZ0hNZevvcDfLF5fu9gjaaLfg3/oVlsTRefskeAdXLg7cC254oIuy2kCCqm2e3UfNyJ2hQLzmZcWUOW3xwvO8H0jdCRctvoAOp2ot4ciBz6KHAItbqdHSW986XH6BWGkPC8il3/cxbbz9G9Uxv8QoQH34CMiU8pMe+i4DUjjW8Gyw6WM2fHjpJ29n68oG58KP0fmBLg6a7kajaQNWcwYny2T/HZBQTozgxu8V5bECgthmhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyq/0tHuJEATYFx6shf7Kk5W+8BdqFoN4BwerzFZd1w=;
 b=XyHdfeABxp3uN31HXWRf67/xaoD5N8eepqqyXWZLofNIwrIrfVs/KgtpWnW+xkVLsqqnCOhXAx7wMX/p4ye1kOKu1OztCo72PMUrBvKutIjGncCWTRt0dlmu57rDtC3WHRhakNnbvkLHN6D2tYFOEDnrQBWpESOiot+MYVd6elY=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3719.namprd13.prod.outlook.com (2603:10b6:610:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11; Wed, 20 May
 2020 18:01:07 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.3021.013; Wed, 20 May 2020
 18:01:07 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "richard.purdie@linuxfoundation.org" 
        <richard.purdie@linuxfoundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "mhalstead@linuxfoundation.org" <mhalstead@linuxfoundation.org>
Subject: Re: TEST_STATEID issues with NFS4.1 and FreeNAS server
Thread-Topic: TEST_STATEID issues with NFS4.1 and FreeNAS server
Thread-Index: AQHWLs6+hWCi0hkMMkOtApoBqM31paixQ6WA
Date:   Wed, 20 May 2020 18:01:07 +0000
Message-ID: <6e7c1125fb5533d1fad5d8b9130761df0fdf3516.camel@hammerspace.com>
References: <09ad6e031e64820f2efd7495d7467e2bb8b51fc5.camel@linuxfoundation.org>
In-Reply-To: <09ad6e031e64820f2efd7495d7467e2bb8b51fc5.camel@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5d2de97-48cc-4c5f-43f6-08d7fce7c55b
x-ms-traffictypediagnostic: CH2PR13MB3719:
x-microsoft-antispam-prvs: <CH2PR13MB3719F4E319A28248E1CC5129B8B60@CH2PR13MB3719.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q7RzI8tkLttoaudBnpEtgo+CQlwuWYIv1z3lBj/a/mY98Z/i2I3avYOVug0P7Gx9sFE5v/6mMJpS2QrpNjsRui6NX7L5OsatJ4HQhphP0cCb5BDYW1RGBYeyMQvybz/+whi6+dy0Zs/WYYK3uwL16mLzTWZI2zvQrgVzjp9S+Gu7PUcYnrk0G0iWusytHoRX3Z6K8TOK6zi2Md/gyS2Zz8kPpNU6lc1LDg6ZeAIQJYnFAeIdwoLDdvpC19S2dknDHUunssBDkgKbbOYosu/Vq1NyFdurRBlWpPVid9QMNxWq6q9MabdpVor3Jl6qolKyNQSCP4hvrpuKJacnomyN7ttm+HMTYGPHSjgaUVqcky6Mix563GkTXmpk5gx0wiKxFtNv0xEUZ6TLvf9W3noZPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(396003)(136003)(366004)(376002)(346002)(186003)(5660300002)(6512007)(26005)(6506007)(2616005)(6486002)(86362001)(71200400001)(4326008)(36756003)(66556008)(8936002)(64756008)(76116006)(8676002)(66446008)(316002)(66476007)(110136005)(2906002)(478600001)(66946007)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: V0zsXPsmyjOc23mPlgp4MyR9KWP63+Ym/pQFMHEN45zAHq1zXuk5212XCxPEvtUma8vlcOdHiI2M7SfGVwrVCAgsOjgAvCyCu9NXMTBNZh6NtMx3ua0hKxGv0Rd4xvzYXK9xL5nqYZnBCyZLJ3UuiZDouULkQJJPZggxwrSZxoylWJFpob8VOzpCYz9jIoazqY1/P4XwvwQmYMx3Oi8JamwpkEmplw/ZIfq/bXNgjrvaqj6ql8ZTiB0UaPzqU/Xwni4oLEydaXJhPNl29JxnDGj61SDW9YACd4KZ4o0qFLEiTlm8lH9jPzc4wwoL+oq1BivB1ySTl0YGMHyAenwv+Q03MnW1DbJL6jNrbsuAI5QbDstUIwXCYaAWgi2KETMb6nHX8vJtRsCxaC58tjBmdGGmWEQ0lTW5iFdyuNHGDFKFYYM40mIPzh8FnuugVxvkgcJcysn/dZk6l2+b5s25DN/yLOzm/NNJQw2iGP+nnGI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7F1B5775DDCE740A25B21868238F347@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d2de97-48cc-4c5f-43f6-08d7fce7c55b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 18:01:07.3413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0VJ2cJuVN5rQDiqrcG0xGb/Np2oq+KR0IT14PhtBIzirBig1MeJ8RxSxcHjA72U9t2OTeyvDmHSb/BalCuqfrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3719
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgUmljaGFyZCwNCg0KT24gV2VkLCAyMDIwLTA1LTIwIGF0IDE4OjQ3ICswMTAwLCBSaWNoYXJk
IFB1cmRpZSB3cm90ZToNCj4gSGksDQo+IA0KPiBXZSBoYXZlIGEgY2x1c3RlciBvZiBtYWNoaW5l
cyB3aGVyZSB3ZSdyZSBvYnNlcnZpbmcgZmlsZSBhY2Nlc3Nlcw0KPiBoYW5naW5nIG92ZXIgTkZT
LiBUaGUgY2xpZW50cyBzaG93aW5nIHRoZSBwcm9ibGVtcyBhcmUgRmVkb3JhIGFuZA0KPiBTVVNF
DQo+IGRpc3Ryb3Mgd2l0aCB0aGUgNS42LjExIGtlcm5lbCwgZS5nLjoNCj4gDQo+IExpbnV4IHZl
cnNpb24gNS42LjExLTEtZGVmYXVsdCAoZ2Vla29AYnVpbGRob3N0KSAoZ2NjIHZlcnNpb24gOS4z
LjENCj4gMjAyMDA0MDYgDQo+IFtyZXZpc2lvbiA2ZGI4MzdhNTI4OGVlM2NhNWVjNTA0ZmJkNWE3
NjU4MTdlNTU2YWMyXSAoU1VTRSBMaW51eCkpIA0KPiAjMSBTTVAgV2VkIE1heSA2IDEwOjQyOjA5
IFVUQyAyMDIwICg5MWMwMjRhKQ0KPiANCj4gSW4gdGhlIGV4YW1wbGUgYmVsb3cgd2Ugc2VlIGEg
Z2l0IGNsb25lIGhhbmcsIGl0cyBoYXZpbmcgdHJvdWJsZQ0KPiByZWFkaW5nIGEgLnBhY2sgZmls
ZSBvZmYgdGhlIE5GUyBzaGFyZSwgdGhlIGdpdCBwcm9jZXNzIGlzIGluIEQNCj4gc3RhdGUuDQo+
IEkndmUgaW5jbHVkZWQgcGFydCBvZiBkbWVzZyBiZWxvdyB3aXRoIHN5c3JxLXcgb3V0cHV0Lg0K
PiANCj4gTW91bnQgb3B0aW9uczoNCj4gDQo+IHJ3LHJlbGF0aW1lLHZlcnM9NC4xLHJzaXplPTEz
MTA3Mix3c2l6ZT0xMzEwNzIsbmFtbGVuPTI1NSxoYXJkLHByb3RvPQ0KPiB0Y3AsdGltZW89NjAw
LHJldHJhbnM9MixzZWM9c3lzLGxvY2FsX2xvY2s9bm9uZQ0KPiANCj4gbW91bnRzdGF0cyBzaG93
czoNCj4gIA0KPiBSRUFEOg0KPiAJNjMyMDE0MjYzIG9wcyAoNjIlKSAJNjI5ODA5MTA4IGVycm9y
cyAoOTklKSANCj4gVEVTVF9TVEFURUlEOg0KPiAgCTM2MzI1NzA3OCBvcHMgKDM2JSkgCTM2MzI1
NzA3OCBlcnJvcnMgKDEwMCUpDQo+IA0KPiB3aGljaCBpcyBhIGNsdWUgb24gd2hhdCBpcyBoYXBw
ZW5pbmcuIEkgZ3JhYmJlZCBzb21lIGRhdGEgd2l0aA0KPiB0Y3BkdW1wDQo+IGFuZCBpdCBzaG93
cyB0aGUgUkVBRCBnZXR0aW5nIE5GUzRFUlJfQkFEX1NUQVRFSUQsIHRoZXJlIGlzIHRoZW4gYQ0K
PiBURVNUX1NUQVRFSUQgd2hpY2ggZ2V0cyBORlM0RVJSX05PVFNVUFAuIFRoaXMgcmVwZWF0cyBp
bmZpbml0ZWx5IGluIGENCj4gbG9vcC4NCj4gDQo+IFRoZSBzZXJ2ZXIgaXMgRnJlZU5BUzExLjMg
d2hpY2ggZG9lcyBub3QgaGF2ZToNCj4gaHR0cHM6Ly9naXRodWIuY29tL0hhcmRlbmVkQlNEL2hh
cmRlbmVkQlNELXN0YWJsZS9jb21taXQvNjNmNmYxOWIwNzU2YjE4ZjJlNjhkODJjYmUwMzdmMjFm
OWE4YzUwMA0KPiBhcHBsaWVkIHNvIGl0IHdpbGwgcmV0dXJuIE5GUzRFUlJfTk9UU1VQUCB0byBU
RVNUX1NUQVRFSUQuDQo+IA0KPiBJIHRoaW5rIHNvbWV0aGluZyBtYXkgYmUgbmVlZGVkIHRvIHN0
b3AgTGludXggZ2V0dGluZyBpbnRvIGFuDQo+IGluZmluaXRlDQo+IGxvb3Agd2l0aCB0aGlzLCBy
ZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhlIHNwZWMgc2F5cyBURVNUX1NUQVRFSUQgY2FuDQo+IGdl
dCBhIE5GUzRFUlJfTk9UU1VQUCBvciBub3Q/DQo+IA0KPiBJIGZyZWVseSBhZG1pdCBJIGtub3cg
bGl0dGxlIGFib3V0IG11Y2ggb2YgdGhpcyBzbyBJJ20gb3BlbiB0bw0KPiBwb2ludGVycy4gSWYg
d2UgZGlkIHJlbW91bnQgYXMgNC4wIHdlIHByb2JhYmx5IHdvdWxkbid0IHNlZSB0aGUgaXNzdWUN
Cj4gYXMgaXQgd291bGQgYXZvaWQgdGhlIFRFU1RfU1RBVEVJRCBjb2RlLg0KDQpURVNUX1NUQVRF
SUQgaXMgbGlzdGVkIGluIFJGQzU2NjEgU2VjdGlvbiAxNyBhcyBSRVFVSVJFRCB0byBpbXBsZW1l
bnQNCmZvciBORlN2NC4xLiBXZSB3aWxsIG5vdCBiZSBhYmxlIHRvIHN1cHBvcnQgYSBzZXJ2ZXIg
dGhhdCB2aW9sYXRlcyB0aGF0DQpyZXF1aXJlbWVudC4NCg0KQ2hlZXJzDQogIFRyb25kDQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
