Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4529A288
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2019 00:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbfHVWDi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Aug 2019 18:03:38 -0400
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:26467 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732794AbfHVWDh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Aug 2019 18:03:37 -0400
IronPort-SDR: 2CdSOZwWcv4gaxUCIudidhj0Jn66rmesdFVuOZnetxPGFyzCEZ6/Cm+tWZ7ET96vjACs1RsdvN
 TK8LoFBuSNwKAwfo/TRuLUouvRFgzdrKjQFmG36Fp6xLuTuDvoiBKg2HOEogsZAzs5qLfbWNu8
 c9Ym5K75ezhekSigfTVAk6R5e5pu1d1KTbFBKzKH2EGEtrhQAydRcE4Q9TJ4BZE9uD4Qx+qD9N
 cKf5/nt7px0qZmcINbQ+wMB/ruVWRF6zMNbVeetOhZQfEtfF281sxGRg3LZTTQXXX6w12pZWFa
 7wE=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 150097197
IronPort-PHdr: =?us-ascii?q?9a23=3A7SHINBesDMrN7TJ/eeQoo5XllGMj4e+mNxMJ6p?=
 =?us-ascii?q?chl7NFe7ii+JKnJkHE+PFxlwGUD57D5adCjOzb++D7VGoM7IzJkUhKcYcEFn?=
 =?us-ascii?q?pnwd4TgxRmBceEDUPhK/u/dyM9EdhQfFps43H9LFRYCM/lIVDevy764A=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EnAABxEF9dhzgqL2hlGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBZ4FFUHB1BAsqCoQWg0cDhTKFPIJcmjgDGBclAQgBAQEBAQE?=
 =?us-ascii?q?BAQEHASUIAgEBAoQ9AheCbDgTAgkBAQUBAQEBAQYEAgIQAQEBCA0JCCmFNAy?=
 =?us-ascii?q?CdARNOTIBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAg0?=
 =?us-ascii?q?HJAwtAQEBAxIREQwBATcBDwIBCBgCAiYCAgIwFRACBA4ngwABgWoDHQEOn2Y?=
 =?us-ascii?q?9AmICC4EEKYhgAQFygTKCewEBBYEyAQMCBgGBCIJcGEIIgUwDBoEMKIwBBoF?=
 =?us-ascii?q?BPoE4DIJfPoJhAQEDgUgWgwuCWIwsEoJahz6UHW0JAoIdhmmNTgYbgjGLSYp?=
 =?us-ascii?q?QlSsYkC8CBAIEBQIOAQEFgWeBenITO4JsgkIMDgmDT2qEKoU/QAExgSmKTgG?=
 =?us-ascii?q?BIAEB?=
X-IPAS-Result: =?us-ascii?q?A2EnAABxEF9dhzgqL2hlGgEBAQEBAgEBAQEHAgEBAQGBZ?=
 =?us-ascii?q?4FFUHB1BAsqCoQWg0cDhTKFPIJcmjgDGBclAQgBAQEBAQEBAQEHASUIAgEBA?=
 =?us-ascii?q?oQ9AheCbDgTAgkBAQUBAQEBAQYEAgIQAQEBCA0JCCmFNAyCdARNOTIBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAg0HJAwtAQEBAxIRE?=
 =?us-ascii?q?QwBATcBDwIBCBgCAiYCAgIwFRACBA4ngwABgWoDHQEOn2Y9AmICC4EEKYhgA?=
 =?us-ascii?q?QFygTKCewEBBYEyAQMCBgGBCIJcGEIIgUwDBoEMKIwBBoFBPoE4DIJfPoJhA?=
 =?us-ascii?q?QEDgUgWgwuCWIwsEoJahz6UHW0JAoIdhmmNTgYbgjGLSYpQlSsYkC8CBAIEB?=
 =?us-ascii?q?QIOAQEFgWeBenITO4JsgkIMDgmDT2qEKoU/QAExgSmKTgGBIAEB?=
X-IronPort-AV: E=Sophos;i="5.64,418,1559538000"; 
   d="scan'208";a="150097197"
X-Utexas-Seen-Outbound: true
Received: from mail-by2nam03lp2056.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.56])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 22 Aug 2019 17:03:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCSeBc26ZU+AJK0UqAVGM8HHSwAYPYDVeBexezjNSytv61Js8YrCFPrqduzcj60+2v+YZl/qFvla+exgwjyHEKMQ9JJfcLdCTPsdFn6xAvleRb2fE2hFBN/ATCWYCMkHki2HQsO5VyU4+h+LTTIiiXa64V2SOx3bInLKyzYp4tLCDsXAp0qI6r4ESw4+cZ8ijvijqB8OqylkZAs0OYeIEEY1V6TNJ1kWb35GYFWCc2oz4gzAxSvMWkc3fizjWx/zuHy0UduyLPh4zGy6BND3OuBhAoAHVSDLWm3Usa/qcp2rn0PBK9+WrnsBR/yaXIk0XqrEwKbxDhabKZtPgE1Ptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg8nlbXOTQa0dz+qiTgb3ddgXhjgSESqjfZv1Fx3pBo=;
 b=l3IcBEeUewNsMhIgvtZTkzejxcEoFpNVgKz3aSuuaI4nnbnsKRAo8WIlQqGHF1o8wJxomQ6gNdMeX/8u3ASGW9ftPUZi79mm5nazy1C6AeGseuz/S95fWXk+Z/upA2Ee5Vbb4dytBXYg6MQlF0KIOtcX6MPDRtNlbDF089qGN7qIO8ui6CIYeCweOyrmnY9Qvo2zGf2Ay0Uvja1RZBeY/7J8RoT5wdQ2eGmmMWscliNWcvjSSa4aO3xDXFUqmRS55X0QOLKl/o6JMbtwC65gzlCYEMA/IqSocf2E6OQzHBFuzJPg8s0A0Oi7149kGVYC+/alLvUOonsg3vRekUxy1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector2-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg8nlbXOTQa0dz+qiTgb3ddgXhjgSESqjfZv1Fx3pBo=;
 b=RFLRXLfpVDnvO6rsDTy9nrdrngbeVHY6XN5ygghMfJFhx/31/CojGSgfM172LS88rfN9d5fj1aiKfhvVFlty5lpikPqbcBQIi9TBqYnKnSwa89dVii+humbk+edNRo2tXBqEe4ISUL/5Hr0SZBMm69ONnp4S0QInp9s9vqNgdEI=
Received: from DM5PR0601MB3606.namprd06.prod.outlook.com (10.167.108.144) by
 DM5PR0601MB3654.namprd06.prod.outlook.com (10.167.108.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 22:03:34 +0000
Received: from DM5PR0601MB3606.namprd06.prod.outlook.com
 ([fe80::6dec:6d3b:c9d9:7a41]) by DM5PR0601MB3606.namprd06.prod.outlook.com
 ([fe80::6dec:6d3b:c9d9:7a41%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 22:03:34 +0000
From:   "Goetz, Patrick G" <pgoetz@math.utexas.edu>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Does NFSv4 translate POSIX ACL's?
Thread-Topic: Does NFSv4 translate POSIX ACL's?
Thread-Index: AQHVV4YD8bGOXAW/2kOmYaroxDGJAqcEaDQAgANTnwA=
Date:   Thu, 22 Aug 2019 22:03:34 +0000
Message-ID: <68652a23-ce70-4550-b68a-137593738d4e@math.utexas.edu>
References: <87bee5fc-5461-01b2-ad9d-9c60e86396c1@math.utexas.edu>
 <20190820191528.GA9039@fieldses.org>
In-Reply-To: <20190820191528.GA9039@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:610:20::24) To DM5PR0601MB3606.namprd06.prod.outlook.com
 (2603:10b6:4:7c::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgoetz@math.utexas.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [128.83.133.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f5c273d-6b51-4507-a4d0-08d7274c9361
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR0601MB3654;
x-ms-traffictypediagnostic: DM5PR0601MB3654:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <DM5PR0601MB3654664F7468C8E57C28357483A50@DM5PR0601MB3654.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(199004)(189003)(6512007)(14454004)(786003)(6306002)(316002)(229853002)(186003)(6486002)(6436002)(446003)(86362001)(81166006)(66066001)(4326008)(31696002)(81156014)(8676002)(11346002)(14444005)(2616005)(256004)(76176011)(476003)(6246003)(2906002)(88552002)(486006)(8936002)(53936002)(52116002)(66446008)(64756008)(66556008)(305945005)(66476007)(99286004)(7736002)(102836004)(478600001)(25786009)(75432002)(6916009)(6506007)(6116002)(31686004)(3846002)(386003)(71190400001)(966005)(71200400001)(26005)(53546011)(66946007)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0601MB3654;H:DM5PR0601MB3606.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: math.utexas.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aXBJPCy6UVQV9v/qIGE+JJldbncVmdRhYwLgiXlbnGplVJMTFJ+VpOrHeXWOnISFkdcbwQZvj3ify/deSdrJgb6pFAAr9n/MxR6eguliadmdBtZQ50G2TV5T6lm3aHBDJgKxOQSzC+RIc7A/3tA3WcDUvXfHb2Mra5THnu7v7uEYZvAVxn5uS5O12bMHTgpXaxe+WnkZ6ign3rvXq2aqsEFm/zVuUWK9vqvSHV5puiK+SVMeOyGXqRd8NPbS6EE2UvVBx9A6+2ILt3yYyJxpsyeSRbUd6s3EyDvOLGp6FlJsQzezeuzjGhPzDdgIabzrjxi3IoLoUty8sJWAURipXZ6KH8qDsYN9xj8eSv8HPbFS8K9L0Vg6+L9QZoJQk6i1gfiWTmLUlPq1bD66htgYeZiijWhXGPRluku4mhNH4uw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <961ECA50060A214ABC5AC6DCE1C53368@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5c273d-6b51-4507-a4d0-08d7274c9361
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 22:03:34.1234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46fcoUORJ8EjJD/rlKg/mI5CoN0PhBwFMYwVFzUu0keEI+l4fveOEgUnDnw3PqAadso5ruX2cPo+Bqp80aZO0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0601MB3654
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgLQ0KDQpZZXMsIHRoaXMsIGFsb25nIHdpdGggRGFuaWVsJ3MgY29tbWVudCwgd2FzIGVub3Jt
b3VzbHkgaGVscGZ1bCBpbiANCmFsbG93aW5nIG1lIHRvIGZpZ3VyZSBvdXQgd2hhdCB3YXMgZ29p
bmcgd3JvbmcuICBUaGFuayB5b3UhDQoNCg0KT24gOC8yMC8xOSAyOjE1IFBNLCBKLiBCcnVjZSBG
aWVsZHMgd3JvdGU6DQo+IE9uIFR1ZSwgQXVnIDIwLCAyMDE5IGF0IDA2OjM1OjE2UE0gKzAwMDAs
IEdvZXR6LCBQYXRyaWNrIEcgd3JvdGU6DQo+PiBQb3N0aW5nIHRvIHRoaXMgbGlzdCBvdXQgb2Yg
ZGVzcGVyYXRpb24sIGFzIEkndmUgZXhoYXVzdGVkIGFsbCB0aGUgb3RoZXINCj4+IHJlc291cmNl
cyBJIGNhbiBnZXQgbXkgaGFuZHMgb24uDQo+IA0KPiBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5k
IHRoZSBzZXR1cCBleGFjdGx5LCBidXQgaXQgZG9lc24ndCBhcHBlYXIgdG8NCj4gaGF2ZSBhbnl0
aGluZyB0byBkbyB3aXRoIEFDTHMgZXhhY3RseSwgaXQncyB1c2VycyB0aGF0IGFyZSB0aGUgcHJv
YmxlbS4NCj4gWW91J2QgaGF2ZSBleGFjdGx5IHRoZSBzYW1lIHByb2JsZW0gaWYgeW91IHdlcmUg
dXNpbmcgb25seSBtb2RlIGJpdHMuDQo+IA0KPiBBbGwgTkZTIHBlcm1pc3Npb25zIGFyZSBldmFs
dWF0ZWQgcHJldHR5IG11Y2ggb25seSBvbiB0aGUgc2VydmVyIHNpZGUuDQo+IFdoZW4geW91IHJl
YWQgYSBkaXJlY3RvcnksIGZvciBleGFtcGxlLCB0aGUgY2xpZW50IGRvZXNuJ3QgZmV0Y2ggdGhl
IEFDTA0KPiBhbmQgbW9kZSBiaXRzIGFuZCBjaGVjayBwZXJtaXNzaW9ucyBpdHNlbGYuICBJdCBq
dXN0IHNlbmRzIHRoZSBSRUFERElSDQo+IChvciBhbiBBQ0NFU1MgY2FsbCkgd2l0aCBycGMgY3Jl
ZGVudGlhbHMgaWRlbnRpZnlpbmcgdGhlIHVzZXIgcGVyZm9ybWluZw0KPiB0aGUgY2FsbCwgYW5k
IGl0J3MgdXAgdG8gdGhlIHNlcnZlciB3aGV0aGVyIG9yIG5vdCB0byByZXR1cm4gYQ0KPiBwZXJt
aXNzaW9uIGVycm9yLg0KPiANCj4gR3JvdXBzIGFyZSBoYW5kbGVkIGRpZmZlcmVudGx5IGRlcGVu
ZGluZyBvbiB0aGUgc2VjdXJpdHkgZmxhdm9yLS1pZg0KPiB5b3UncmUgdXNpbmcga2VyYmVyb3Ms
IGl0J3MgdXAgdG8gdGhlIHNlcnZlciB0byBkZWNpZGUgd2hpY2ggZ3JvdXAgeW91cg0KPiB1c2Vy
IGlzIGEgbWVtYmVyIG9mLiAgSWYgeW91J3JlIHVzaW5nIGF1dGhfc3lzL2F1dGhfdW5peCwgdGhl
biB0aGUNCj4gY2xpZW50IHNlbmRzIGEgbGlzdCBvZiBncm91cHMgd2l0aCBlYWNoIHJwYyBjYWxs
LiAgKEJ1dCB0aGUgTGludXggc2VydmVyDQo+IGhhcyBhIC0tbWFuYWdlLWdpZHMgb3B0aW9uIHRo
YXQgdGVsbHMgdGhlIHNlcnZlciB0byBpZ25vcmUgdGhhdCBhbmQgdXNlDQo+IHNlcnZlciBzaWRl
IGdyb3VwIG1lbWJlcnNoaXBzLikNCj4gDQo+IEhvcGUgdGhhdCBoZWxwcy4gIFRoaXMgZG9lc24n
dCBsb29rIGxpa2UgYW55dGhpbmcgdG8gZG8gd2l0aCBBQ0wNCj4gbWFwcGluZywgaW4gYW55IGNh
c2UuDQo+IA0KPiAtLWIuDQo+IA0KPiANCj4+IFRoZSBmdWxsIGJsb3duIGlzc3VlIGhhcyBiZWVu
IHBvc3RlZCBoZXJlOg0KPj4NCj4+ICAgDQo+PiBodHRwczovL3VuaXguc3RhY2tleGNoYW5nZS5j
b20vcXVlc3Rpb25zLzUzNjMwMC93aHktaXMtbmZzdjQtbm90LXRyYW5zbGF0aW5nLXBvc2l4LWFj
bHMtaW4tYS11c2FibGUtd2F5DQo+Pg0KPj4gSSBoYXZlIGFuIE5GU3Y0IGV4cG9ydGVkIGZvbGRl
ciAoYmFzZSBmaWxlc3lzdGVtOiBYRlMpIHdoaWNoIG11c3QgYWZmb3JkDQo+PiByZWFkIGFjY2Vz
cyB0byBhIHByb2dyYW0gb24gZm9sZGVycyB3aGljaCBhcmUgb3RoZXJ3aXNlIGhpZGRlbiBmcm9t
IHRoZQ0KPj4gcHVibGljLiAgT24gdGhlIE5GUyBzZXJ2ZXI6DQo+Pg0KPj4gICAgIHJvb3RAa3Jh
a2VuOi9FTS9FTXRpZnMjIGdldGZhY2wgcGdvZXR6DQo+PiAgICAgIyBmaWxlOiBwZ29ldHoNCj4+
ICAgICAjIG93bmVyOiBwZ29ldHoNCj4+ICAgICAjIGdyb3VwOiBjbnMtY25zaXRsYWJ1c2Vycw0K
Pj4gICAgIHVzZXI6OnJ3eA0KPj4gICAgIGdyb3VwOjpyLXgNCj4+ICAgICBvdGhlcjo6LS0tDQo+
PiAgICAgZGVmYXVsdDp1c2VyOjpyd3gNCj4+ICAgICBkZWZhdWx0OnVzZXI6Y3J5b3NwYXJjX3Vz
ZXI6ci14DQo+PiAgICAgZGVmYXVsdDpncm91cDo6ci14DQo+PiAgICAgZGVmYXVsdDptYXNrOjpy
LXgNCj4+ICAgICBkZWZhdWx0Om90aGVyOjotLS0NCj4+DQo+PiAgICAgcm9vdEBrcmFrZW46L0VN
L0VNdGlmcyMgaWQgY3J5b3NwYXJjX3VzZXINCj4+ICAgICB1aWQ9MTAxNyhjcnlvc3BhcmNfdXNl
cikgZ2lkPTEwMTcoY3J5b3NwYXJjX3VzZXIpDQo+PiBncm91cHM9MTAxNyhjcnlvc3BhcmNfdXNl
cikNCj4+DQo+Pg0KPj4gVGhlIE5GUyBjbGllbnQgYXBwZWFycyB0byBiZSB0cmFuc2xhdGluZyB0
aGUgUE9TSVggQUNMOg0KPj4NCj4+ICAgICByb290QGphdmVsaW5hOi9FTS9FTXRpZnMjIG5mczRf
Z2V0ZmFjbCBwZ29ldHoNCj4+ICAgICBBOjpPV05FUkA6cndhRHh0VGNDeQ0KPj4gICAgIEE6OkdS
T1VQQDpyeHRjeQ0KPj4gICAgIEE6OkVWRVJZT05FQDp0Y3kNCj4+ICAgICBBOmZkaTpPV05FUkA6
cndhRHh0VGNDeQ0KPj4gICAgIEE6ZmRpOjEwMTc6cnh0Y3kNCj4+ICAgICBBOmZkaTpHUk9VUEA6
cnh0Y3kNCj4+ICAgICBBOmZkaTpFVkVSWU9ORUA6dGN5DQo+Pg0KPj4gICAgIHJvb3RAamF2ZWxp
bmE6L0VNL0VNdGlmcyMgaWQgY3J5b3NwYXJjX3VzZXINCj4+ICAgICB1aWQ9MTAxNyhjcnlvc3Bh
cmNfdXNlcikgZ2lkPTEwMTcoY3J5b3NwYXJjX3VzZXIpDQo+PiBncm91cHM9MTAxNyhjcnlvc3Bh
cmNfdXNlcikNCj4+DQo+PiBIb3dldmVyLA0KPj4NCj4+ICAgICBjcnlvc3BhcmNfdXNlckBqYXZl
bGluYTovRU0vRU10aWZzJCB3aG9hbWkNCj4+ICAgICBjcnlvc3BhcmNfdXNlcg0KPj4gICAgIGNy
eW9zcGFyY191c2VyQGphdmVsaW5hOi9FTS9FTXRpZnMkIGxzIHBnb2V0eg0KPj4gICAgIGxzOiBj
YW5ub3Qgb3BlbiBkaXJlY3RvcnkgJ3Bnb2V0eic6IFBlcm1pc3Npb24gZGVuaWVkDQo+Pg0KPj4g
SG9zdCBPUyBvbiBib3RoIG1hY2hpbmVzOiBVYnVudHUgMTguMDQNCj4+IE5GUyB2ZXJzaW9uOiAx
LjMuNA0KPj4gTW91bnQgZW50cnkgaW4gL2V0Yy9mc3RhYjoNCj4+ICAgICBrcmFrZW4uYmlvc2Np
LnV0ZXhhcy5lZHU6L0VNICAvRU0gIG5mczQgIF9uZXRkZXYsYXV0byAgMCAgMA0KPj4NCj4+DQo+
PiBJIGZvdW5kIHRoaXMgZG9jdW1lbnQgdGhhdCBCcnVjZSB3cm90ZToNCj4+DQo+PiAgICAgaHR0
cHM6Ly90b29scy5pZXRmLm9yZy9odG1sL2RyYWZ0LWlldGYtbmZzdjQtYWNsLW1hcHBpbmctMDIN
Cj4+DQo+PiBidXQgaXQgZG9lc24ndCBhcHBlYXIgdG8gaGF2ZSByaXNlbiB0byB0aGUgbGV2ZWwg
b2YgUkZDPyAgUkZDIDc1MzANCj4+IGRvZXNuJ3QgYXBwZWFyIHRvIGhhdmUgYW55dGhpbmcgdG8g
c2F5IG9uIHRoZSBtYXR0ZXIuICBTaW5jZSB0aGUNCj4+IHByb2Nlc3NpbmcgcHJvZ3JhbSBwcmlt
YXJpbHkgcnVucyBvbiB0aGUgd29ya3N0YXRpb25zLCBJIG5lZWQgdG8gbWFrZQ0KPj4gdGhpcyB3
b3JrIHNvbWVob3csIGFuZCBjYW4ndCBhZGQgdGhlIHByb2dyYW0gdXNlciB0byB0aGUgdXNlciBn
cm91cCBhcw0KPj4gZXhwbGFpbmVkIGluIHRoZSBTdGFja0V4Y2hhbmdlIHBvc3QuDQo+Pg0KPj4N
Cj4+PiBUaGlzIG1lc3NhZ2UgaXMgZnJvbSBhbiBleHRlcm5hbCBzZW5kZXIuIExlYXJuIG1vcmUg
YWJvdXQgd2h5IHRoaXMgPDwNCj4+PiBtYXR0ZXJzIGF0IGh0dHBzOi8vbGlua3MudXRleGFzLmVk
dS9ydHljbGYuICAgICAgICAgICAgICAgICAgICAgICAgPDwNCj4gDQo=
