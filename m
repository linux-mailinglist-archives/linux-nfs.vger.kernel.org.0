Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155E921DF6F
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2020 20:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgGMSPK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Jul 2020 14:15:10 -0400
Received: from mail-bn8nam11on2139.outbound.protection.outlook.com ([40.107.236.139]:45280
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729687AbgGMSPJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 13 Jul 2020 14:15:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReA4bhSolPZ07Wr94kJeCLY1gnKY8omLQrjkxKNdMtApOd3DK0CBzIN0wRSY689Tha3Uko1jBPuFpY0c5QTioXgTK/NkiKSr3RtCSbdHu5tzoioJs8ApNwoUVON/dfmAgJJeLYF550frGDD31OnUYpuYOC/Ngl4mRZc76PJsoCnDJmxdxTfMyTcEeTkTTObeL/FDwcinXEC6ytYWfYHBqHOF9iaXqg5FW14ugsSS5A/945uectd2x7AhswhDXN6wzGsWF6yIoBCkyrjUrxHnxJhNWlI2SHRVUWAB2yHnog5fKP4Gx+ODO4u03etxJw+ZuibrSjLMvtjPT3HFZRPFWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63ugjG3LD6sFPwb2N+IKo+7XpRPXo5Ed23bNISYJFiM=;
 b=j7Rba77HhER1ZNL45i/RiLQl5qIcCenPDqA0BVLVMvP2hgKbCCjzS3ytRnSpxJuKKuNDFXXsu/96D117okA6DGCikxdZPIHk0jyQ6rPIxP66yTAbff/dSty8sMmAoEkuH8CiZevvlJXZm+vWvu3r2+6vlg4zjmOB1u2SvSQxLfVwiWNJhRDEY/jttBffckDgpyUD41GdXR5KtYFII9WYB5fpMuf2nYFdWJ6f4iec1LAqQ5lP4s06JbyakRy+sXYfjuOMzfN3pOpHTOtKTOAxwBTwa4cXfxsR8s7Xy3cHcFVT+UrOplXMW4VnKLv3hOkljE60Ql4IVbmw8gtA3tCiKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63ugjG3LD6sFPwb2N+IKo+7XpRPXo5Ed23bNISYJFiM=;
 b=Z5cnCbnUJTstcuVvHWiGs8eqdKkaoMG2LuKH3MVksYy+8qWwd0ghHDOvUUpNahNSgZe2VXIWPnrt8vIh9ocYRe3bPwHsvszFXjmRVQiE5XdkoTjoVgeueWf6bPbdM4VHKjWYRnq2rV5pV/I6fTQN2RbM5gavke/P/Tt3TWSh+1c=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3832.namprd13.prod.outlook.com (2603:10b6:610:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9; Mon, 13 Jul
 2020 18:15:05 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f%3]) with mapi id 15.20.3195.017; Mon, 13 Jul 2020
 18:15:05 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>
Subject: Re: question about handling off an unresponsive server during lease
 renewal
Thread-Topic: question about handling off an unresponsive server during lease
 renewal
Thread-Index: AQHWWT9rWuVQMnzVjk+qh8egK2wx5qkF0JAA
Date:   Mon, 13 Jul 2020 18:15:05 +0000
Message-ID: <690aeae28fcf2a19c9094e4489f617ccc40c1663.camel@hammerspace.com>
References: <CAN-5tyF+NOK3bZpuTSEjnuuY3XnjrarUwHcvh5TEgCBebW=KHA@mail.gmail.com>
In-Reply-To: <CAN-5tyF+NOK3bZpuTSEjnuuY3XnjrarUwHcvh5TEgCBebW=KHA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 317d9d0a-dd14-4d4d-3c01-08d82758ab51
x-ms-traffictypediagnostic: CH2PR13MB3832:
x-microsoft-antispam-prvs: <CH2PR13MB3832313BA1D8BDB8D39B8589B8600@CH2PR13MB3832.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v6etzgI8/I/0NqNVwSGdNMN+Dicep1IwyRKMRqi6orBnp8l84kg1hod9kzHMeBZ4HfP9CUTh+3YtOGVVBOgs5o+/lXKGBGGn9127UdjePBB0jF0uG42lQrt9+jLuL62yCVL6u4ZLN7xYeYqeKIORRGLpoSc4F0tCOq8pFGitY7r6keCu2C9N1Zss0/82EG2Mw77zpYoghRzJW4kueWMHRClBKxQj0wFJm4MSmTOIh0rMkMd1W9wrvKlAo4r0AdgNxGAnDU1xOUwzHlWyN/bSvVukC867rtDuYNJ0jIc/rj1ZyVAoEKFPiYgCjfcV4OC/4+mgflV6ip3te5qPHXhkPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(346002)(376002)(39830400003)(366004)(71200400001)(5660300002)(316002)(8936002)(2616005)(8676002)(83380400001)(36756003)(478600001)(86362001)(76116006)(26005)(66946007)(186003)(6512007)(64756008)(6486002)(2906002)(66556008)(66446008)(6506007)(110136005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fj/1qzhHnlLi5oFd6dqmzDHk4UldkQlChit8+w2/1roAsVg5VwWYr2Js/C/oXK2CKKTRNvTxarGz3C/x99OrdIwmI5DySg7Mv1hMPsqbbx/GOFenwKj4kib58lM496cqrMlkUaFG3ja6EJO94Aj6eHFbCE+rNLALR6OaIa27apui2ZfySXpiQ28x75Ok10FdANmvEa4+6TC9d5Lus7/t8WY0Sze+w68R6bD5C1y02ohdkVYs1gJq2NcKopbTLYh7oxDcE1rBQqX7eos9N6jnDqimCLkIDG2rw2kIobnOWRdenOhat95O9fmhObCr/+37wSsIF21DRk3jWFBd5XHvTiJOH8jmuVMxO/pighSIfknIMSiM5NRfqNTroECixxMKxNvwkNs/r7FGhWaoKaK6zMiHhBxvwhBeiWu4nEn0JC08Izuejl61rZrqjNsotwgN17taXVXSHzweEw+4h1bWBAJjeU9gFBkFxbsr2pADEA0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <809E051FBE15164C8EC9F0A9857271F2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317d9d0a-dd14-4d4d-3c01-08d82758ab51
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 18:15:05.6189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vd9GovEEp4atftQh97w69HGAkGyO8cTRu36dOWe/DxT4+5RgpfFNDlwyBKOUEK4Nk01mKjXQvpQIXTVr8HVBsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3832
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYQ0KDQpPbiBNb24sIDIwMjAtMDctMTMgYXQgMTM6NTkgLTA0MDAsIE9sZ2EgS29ybmll
dnNrYWlhIHdyb3RlOg0KPiBIaSBUcm9uZCwNCj4gDQo+IFRvIHRoZSBiZXN0IG9mIHlvdXIga25v
d2xlZGdlLCBkb2VzIHRoZSBjbGllbnQgaW1wbGVtZW50IHRoaXMgcGFydCBvZg0KPiB0aGUgc3Bl
YyB0aGF0IGRlYWxzIHdpdGggd2hlbiB0aGUgc2VydmVyIGlzbid0IHJlc3BvbmRpbmcgYW5kIHRo
ZQ0KPiBsZWFzZSBpcyB0aW1pbmcgb3V0Lg0KPiANCj4gUkZDNTY2MSBzZWN0aW9uIDguMyB0YWxr
cyBhYm91dDoNCj4gDQo+IFRyYW5zcG9ydCByZXRyYW5zbWlzc2lvbiBkZWxheXMgbWlnaHQgYmVj
b21lIHNvIGxhcmdlIGFzIHRvDQo+ICAgICAgIGFwcHJvYWNoIG9yIGV4Y2VlZCB0aGUgbGVuZ3Ro
IG9mIHRoZSBsZWFzZSBwZXJpb2QuICBUaGlzIG1heSBiZQ0KPiAgICAgICBwYXJ0aWN1bGFybHkg
bGlrZWx5IHdoZW4gdGhlIHNlcnZlciBpcyB1bnJlc3BvbnNpdmUgZHVlIHRvIGENCj4gICAgICAg
cmVzdGFydDsgc2VlIFNlY3Rpb24gOC40LjIuMS4gIElmIHRoZSBjbGllbnQgaW1wbGVtZW50YXRp
b24gaXMNCj4gbm90DQo+ICAgICAgIGNhcmVmdWwsIHRyYW5zcG9ydCByZXRyYW5zbWlzc2lvbiBk
ZWxheXMgY2FuIHJlc3VsdCBpbiB0aGUNCj4gY2xpZW50DQo+ICAgICAgIGZhaWxpbmcgdG8gZGV0
ZWN0IGEgc2VydmVyIHJlc3RhcnQgYmVmb3JlIHRoZSBncmFjZSBwZXJpb2QNCj4gZW5kcy4NCj4g
ICAgICAgVGhlIHNjZW5hcmlvIGlzIHRoYXQgdGhlIGNsaWVudCBpcyB1c2luZyBhIHRyYW5zcG9y
dCB3aXRoDQo+ICAgICAgIGV4cG9uZW50aWFsIGJhY2tvZmYsIHN1Y2ggdGhhdCB0aGUgbWF4aW11
bSByZXRyYW5zbWlzc2lvbg0KPiB0aW1lb3V0DQo+ICAgICAgIGV4Y2VlZHMgYm90aCB0aGUgZ3Jh
Y2UgcGVyaW9kIGFuZCB0aGUgbGVhc2VfdGltZSBhdHRyaWJ1dGUuICBBDQo+ICAgICAgIG5ldHdv
cmsgcGFydGl0aW9uIGNhdXNlcyB0aGUgY2xpZW50J3MgY29ubmVjdGlvbidzDQo+IHJldHJhbnNt
aXNzaW9uDQo+ICAgICAgIGludGVydmFsIHRvIGJhY2sgb2ZmLCBhbmQgZXZlbiBhZnRlciB0aGUg
cGFydGl0aW9uIGhlYWxzLCB0aGUNCj4gbmV4dA0KPiAgICAgICB0cmFuc3BvcnQtbGV2ZWwgcmV0
cmFuc21pc3Npb24gaXMgc2VudCBhZnRlciB0aGUgc2VydmVyIGhhcw0KPiAgICAgICByZXN0YXJ0
ZWQgYW5kIGl0cyBncmFjZSBwZXJpb2QgZW5kcy4NCj4gDQo+ICAgICAgIFRoZSBjbGllbnQgTVVT
VCBlaXRoZXIgcmVjb3ZlciBmcm9tIHRoZSBlbnN1aW5nDQo+IE5GUzRFUlJfTk9fR1JBQ0UNCj4g
ICAgICAgZXJyb3JzIG9yIGl0IE1VU1QgZW5zdXJlIHRoYXQsIGRlc3BpdGUgdHJhbnNwb3J0LWxl
dmVsDQo+ICAgICAgIHJldHJhbnNtaXNzaW9uIGludGVydmFscyB0aGF0IGV4Y2VlZCB0aGUgbGVh
c2VfdGltZSwgYSBTRVFVRU5DRQ0KPiAgICAgICBvcGVyYXRpb24gaXMgc2VudCB0aGF0IHJlbmV3
cyB0aGUgbGVhc2UgYmVmb3JlIGV4cGlyYXRpb24uICBUaGUNCj4gICAgICAgY2xpZW50IGNhbiBh
Y2hpZXZlIHRoaXMgYnkgYXNzb2NpYXRpbmcgYSBuZXcgY29ubmVjdGlvbiB3aXRoDQo+IHRoZQ0K
PiAgICAgICBzZXNzaW9uLCBhbmQgc2VuZGluZyBhIFNFUVVFTkNFIG9wZXJhdGlvbiBvbiBpdC4g
IEhvd2V2ZXIsIGlmDQo+IHRoZQ0KPiAgICAgICBhdHRlbXB0IHRvIGVzdGFibGlzaCBhIG5ldyBj
b25uZWN0aW9uIGlzIGRlbGF5ZWQgZm9yIHNvbWUNCj4gcmVhc29uDQo+ICAgICAgIChlLmcuLCBl
eHBvbmVudGlhbCBiYWNrb2ZmIG9mIHRoZSBjb25uZWN0aW9uIGVzdGFibGlzaG1lbnQNCj4gICAg
ICAgcGFja2V0cyksIHRoZSBjbGllbnQgd2lsbCBoYXZlIHRvIGFib3J0IHRoZSBjb25uZWN0aW9u
DQo+ICAgICAgIGVzdGFibGlzaG1lbnQgYXR0ZW1wdCBiZWZvcmUgdGhlIGxlYXNlIGV4cGlyZXMs
IGFuZCBhdHRlbXB0IHRvDQo+ICAgICAgIHJlY29ubmVjdC4NCj4gDQo+IFNFUVVOQ0Ugb3AgaXMg
c2VudCBhbmQgc2VydmVyIHJlYm9vdGVkLCBpdCdzIGNvbWluZyB1cCAoYnV0IG5vdA0KPiByZXNw
b25kaW5nKS4NCj4gQXQgdGhlIFRDUCBsYXllciwgVENQIGlzIGV4cG9uZW50aWFsbHkgYmFja2lu
ZyBvZmYgYmVmb3JlIHJldHJ5aW5nLg0KPiBBdA0KPiBzb21lIHBvaW50IHRoZSB0aW1lb3V0IGdv
ZXMgbW9yZSB0aGFuIDEwMHMuIFdoaWNoIG1lYW5zIHRoYXQgYnkgdGhlDQo+IHRpbWUgdGhlIGNs
aWVudCByZXNlbmRzIHRoZSBzZXJ2ZXIgaXMgdXAgYW5kIG91dCBvZiBncmFjZS4NCj4gDQo+IERv
ZXMgdGhlIGNsaWVudCBoYXZlIGFueSBjb250cm9sIG92ZXIgbm90IGxldHRpbmcgdGhlIFRDUCB3
YWl0IGZvcg0KPiBsb25nZXIgdGhhbiB0aGUgbGVhc2UgcGVyaW9kIGFuZCBpbnN0ZWFkLCBpdCBu
ZWVkcyB0byBhYm9ydCB0aGUNCj4gY29ubmVjdGlvbiBhbmQgc3RhcnQgdGhlIG5ldyBvbmU/IEkg
bWVhbiBJIHNvcnQgb2YgZmluZCB0aGUgMm5kDQo+IHBhcmFncmFwaCBpbiBjb250cmFkaWN0aW9u
IHRvIHRoZSBmYWN0IHRoYXQgdGhlIGNsaWVudCBtdXN0IG5ldmVyDQo+IGdpdmUNCj4gdXAgb24g
d2FpdGluZyBmb3IgYSByZXBseSBmcm9tIHRoZSBzZXJ2ZXI/IEJ1dCBtYXliZSB0aGlzIGlzIGEN
Cj4gc3BlY2lhbA0KPiBjYXNlIHdoZXJlIHRoZSBjbGllbnQgaXMgc3VwcG9zZWQgdG8ga25vdyBp
dHMgbGVhc2UgaGFzbid0IGJlZW4NCj4gcmVuZXdlZCBhbmQgaXQncyBPSyB0byBnaXZlIHVwPw0K
DQpUaGF0IGlzIHdoYXQgdGhpcyBjb2RlIGlzIHN1cHBvc2VkIHRvIGVuc3VyZToNCg0KLyoqDQog
KiBuZnM0X3NldF9sZWFzZV9wZXJpb2QgLSBTZXRzIHRoZSBsZWFzZSBwZXJpb2Qgb24gYSBuZnNf
Y2xpZW50DQogKg0KICogQGNscDogcG9pbnRlciB0byBuZnNfY2xpZW50DQogKiBAbGVhc2U6IG5l
dyB2YWx1ZSBmb3IgbGVhc2UgcGVyaW9kDQogKi8NCnZvaWQgbmZzNF9zZXRfbGVhc2VfcGVyaW9k
KHN0cnVjdCBuZnNfY2xpZW50ICpjbHAsDQogICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBs
ZWFzZSkNCnsNCiAgICAgICAgc3Bpbl9sb2NrKCZjbHAtPmNsX2xvY2spOw0KICAgICAgICBjbHAt
PmNsX2xlYXNlX3RpbWUgPSBsZWFzZTsNCiAgICAgICAgc3Bpbl91bmxvY2soJmNscC0+Y2xfbG9j
ayk7DQoNCiAgICAgICAgLyogQ2FwIG1heGltdW0gcmVjb25uZWN0IHRpbWVvdXQgYXQgMS8yIGxl
YXNlIHBlcmlvZCAqLw0KICAgICAgICBycGNfc2V0X2Nvbm5lY3RfdGltZW91dChjbHAtPmNsX3Jw
Y2NsaWVudCwgbGVhc2UsIGxlYXNlID4+IDEpOw0KfQ0KDQpUaGUgY2FsbCB0byBycGNfc2V0X2Nv
bm5lY3RfdGltZW91dCgpIGl0ZXJhdGVzIHRocm91Z2ggYWxsIG9mIHRoZQ0KdHJhbnNwb3J0cyBh
c3NvY2lhdGVkIHdpdGggdGhhdCBzZXJ2ZXIsIGFuZCBjYWxscyB4cHJ0LT5vcHMtDQo+c2V0X2Nv
bm5lY3RfdGltZW91dCgpIHdpdGggdGhlIGFwcHJvcHJpYXRlIGNvbm5lY3QgYW5kIHJlY29ubmVj
dA0KdGltZW91dHMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K
