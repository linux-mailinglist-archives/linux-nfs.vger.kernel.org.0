Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A64B1B0BFD
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 15:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgDTM76 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 08:59:58 -0400
Received: from mail-bn8nam11on2090.outbound.protection.outlook.com ([40.107.236.90]:17453
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727997AbgDTM74 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 Apr 2020 08:59:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJgm8ByAeavVY2C1Z5e1lNqv436U0EzkBoOHlRAa9ZsOYJLdxJZPOlvN76iLGm73xOuQD2kzXszY/LuvReboQ9+IdFkDth/kiDhIbGRFolV04fIlAcMRxkqjQ0N0ZLI5uQ9IolbPCzUXkkCaZSNc6a6EbGKuitr082IEXuLJpyi+OFArwcJUhPoFUqn04OI8uwLVf53MFx4iuB7bsPQ8fy3Y0QPl9v0M5E7tx9D4XpCilt4i3E+SLZOmq0cXdmMK7pUzPUdFluZ13lVAZ/h/jQfS2V+0zj5QIx4LF2ghbD8tMZYjvgLvdnLyVfkLBUqSA37KefIu8gwLaTne0afpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNUTpXLxVw22FrPqKSdiBc2LEeXXyz9zkZeq/OEZbCM=;
 b=oZkU0rzaETvw5wWwGzBMLgtWBgLLRiHnFdMZTlqdnIrNZlzqPTWzyeJ2gP63B2uRjfqFOp9lxsU4/glWLeTk20FvOxFpLCeytqJ2krTDYwPBcXkxeo1akk7YtAZUsvDVVZDQA6LcCGsFVcbwNfTj4vASf0lGZ1/29VsCQF8yCvEg6Kf5SxBb1xVfxlxz8X++PENbNcsSHXuojUp2GkfrgnxvwiXz/dqyOtGz/ccM5foeZdqptCQ2VmkZlGUxeP4fkOg5GonchHDhfeke4WVj5GBQ6aVTphupHEZ8vkTsf/1Rvr8HNPnYsQqNKbBl35zQ5bp/wn4LZr1Nj/iLv5Brgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNUTpXLxVw22FrPqKSdiBc2LEeXXyz9zkZeq/OEZbCM=;
 b=Nj1piSFnTTPg+xlSVptaDBeilZK7ot1hLnQwnkpapMEmhEmsbectFZwcPXGf9Q39mptl5G235ttGTiC7pERO1p/+M91dIftO52xtYPZXTDBWwlupJk57ARKGJQCj7+Nk0+LI7mPl2OXRlY6XqBu08hot01OL3G6r0LRosi5Uo5o=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3496.namprd13.prod.outlook.com (2603:10b6:610:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6; Mon, 20 Apr
 2020 12:59:52 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2937.011; Mon, 20 Apr 2020
 12:59:52 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "akpm@osdl.org" <akpm@osdl.org>,
        "xiyuyang19@fudan.edu.cn" <xiyuyang19@fudan.edu.cn>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "agruenba@redhat.com" <agruenba@redhat.com>,
        "okir@suse.de" <okir@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "tanxin.ctf@gmail.com" <tanxin.ctf@gmail.com>,
        "yuanxzhang@fudan.edu.cn" <yuanxzhang@fudan.edu.cn>,
        "kjlu@umn.edu" <kjlu@umn.edu>
Subject: Re: [PATCH] nfs: Fix potential posix_acl refcnt leak in nfs3_set_acl
Thread-Topic: [PATCH] nfs: Fix potential posix_acl refcnt leak in nfs3_set_acl
Thread-Index: AQHWFta2cwgyqFk5TU+ydXFUjCaulaiB7LGAgAAKgYCAAAJHAA==
Date:   Mon, 20 Apr 2020 12:59:52 +0000
Message-ID: <52a445020247f4dbe810ce757e48cd563a69c4ce.camel@hammerspace.com>
References: <1587361410-83560-1-git-send-email-xiyuyang19@fudan.edu.cn>
         <7b95f2ac1e65635dcb160ca20e798d95b7503e49.camel@hammerspace.com>
         <20200420125141.18002-1-agruenba@redhat.com>
In-Reply-To: <20200420125141.18002-1-agruenba@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32783e68-6fe2-4122-0752-08d7e52ab75e
x-ms-traffictypediagnostic: CH2PR13MB3496:
x-microsoft-antispam-prvs: <CH2PR13MB34960FA97851C6A5238CD96CB8D40@CH2PR13MB3496.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39830400003)(346002)(136003)(366004)(396003)(71200400001)(186003)(2616005)(7416002)(6512007)(81156014)(4326008)(6486002)(8936002)(8676002)(36756003)(5660300002)(76116006)(91956017)(66946007)(54906003)(110136005)(316002)(6506007)(86362001)(2906002)(66476007)(478600001)(64756008)(66556008)(66446008)(26005);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B8nSvac+na1QkqszUFa6Qa3xE3ACQnh+Gs6eZvpwxXlyA/NW1uwr8XtgF2gfyafYKtZ2j8jWJwbS4g8tJ6qq0ErQues41A1mIFGMGpS0e+BAj32H1kkM2FVcxILuwKYNaKRg8MPbinx4+gQlMCh4LqB3SAovcwkJ1K4tKmg0g2AagzFHRE+uqytrg5jp4C9/iJ2XMk8BRMnmP2ttC+BkIQlJJtDQmJi6jb+GXt+GJ1xfW6T/45seNw0HWOKFB8whMYYgOwq9EGM9v9ZMOln5EbabW+oMVK6l8vkSAROH52Hpvnca/IqeN0bvHS6qlXcfCzVFSWQL7kotWmNxT6QOKpL65sZQlIfF+uYx9eCraka/lrBIHw9EM3Yi4jvfbGwKbHPQy82HuWnJiZ1sQBlWEBI2pC+k+GUuHJcCCxpudUyP5OdpFXd3Rnm6YEMjcl8J
x-ms-exchange-antispam-messagedata: gDOFA2djVuqIgOysl7JAqAP8HhAZMXyIvgofepCbluxS7tRI40oP+IzmuDmInRDEKplkls19h3SpweRdpA4b/YQ383fy/KZt3h9rhxo3CcCY/tmRoO+vBsQ/Fi4enYUXejIuemUWzBEhBxbD49DpJOkd9wlel6Sz3d9C/hhM6uZV/9mx3Y+i0nc9ZI0UtKDYxPZqf7VBtplh84JWc+NOrTGlbIS81BoJRiZr/AbNkLReQoYdwfO/qbTmdu3kKD+NSaRETMn07X98ccAhPObQgEo2OG5MoO6qs7AEG1tYMVCwJU4pbWTQ7e973d0K8n/gsfI/i3Nx2VAhIvh6yiZYW+qBEqA1Poc45H7jcH9lFwSLJwnVRTtMkxLtUBwlNW3Ns1PNaYkqUf3M8++N3Mgp+B+4Qn/AJ+HPSvrpZqrK2N4kj1RWD2rBmNTsalu1p1quqoxtHH9NZCiBsALSp6jntDuJnd30aERXiK8wjwYdi1AB/9Pne8wsxwmFNhw9+FeVu/D4eU9jtaztMqCN4smwhDR5FI8nb8mLyu4h6BIX1aiGnZsI3PXAqm2R/NLKJ815ln2oszc4ZxmtGxGWA/sP4wFsAh6ZnbOgqJQYkcWoMga+ZEM22OseKwhBBgyxo6TwbJ3q+6J/FWFqZLNLShJ82mAjErYQH0tqTCbVJSm9L4j/nSDRm34BBMB4UVoElZ4VOu4b0jHdIp5kMURDU8d6E6iH0OLd8Gc0ka7VT+grJ3c6sinCWpavIH/N6LzQFXbJ6fFhdUDIAKh/zgCQNsnlyWvuIerNA1PBa1j+Sjhdato=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C692E65B68AA0E41952FAE2CB5F81E23@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32783e68-6fe2-4122-0752-08d7e52ab75e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 12:59:52.2545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJHnrFY4AqSHMU+yMHgsnxKxbcaGuDLhEphM2cfKf+FGOkALzb/q7BZX+YSG0GbHyJwv1uRpbcxrgcKozU2NWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3496
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTIwIGF0IDE0OjUxICswMjAwLCBBbmRyZWFzIEdydWVuYmFjaGVyIHdy
b3RlOg0KPiBBbSBNby4sIDIwLiBBcHIuIDIwMjAgdW0gMTQ6MTUgVWhyIHNjaHJpZWIgVHJvbmQg
TXlrbGVidXN0IDwNCj4gdHJvbmRteUBoYW1tZXJzcGFjZS5jb20+Og0KPiA+IEkgZG9uJ3QgcmVh
bGx5IHNlZSBhbnkgYWx0ZXJuYXRpdmUgdG8gYWRkaW5nIGEgJ2RmYWxsb2MnIHRvIHRyYWNrDQo+
ID4gdGhlDQo+ID4gYWxsb2NhdGVkIGRmYWNsIHNlcGFyYXRlbHkuDQo+IA0KPiBTb21ldGhpbmcg
bGlrZSB0aGUgYXR0YWNoZWQgcGF0Y2ggc2hvdWxkIHdvcmsgYXMgd2VsbC4NCj4gDQo+IFRoYW5r
cywNCj4gQW5kcmVhcw0KPiANCj4gLS0tDQo+ICBmcy9uZnMvbmZzM2FjbC5jIHwgMzIgKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRp
b25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzM2Fj
bC5jIGIvZnMvbmZzL25mczNhY2wuYw0KPiBpbmRleCBjNWMzZmM2ZTZjNjAuLmYxNTgxZjExYzIy
MCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL25mczNhY2wuYw0KPiArKysgYi9mcy9uZnMvbmZzM2Fj
bC5jDQo+IEBAIC0yNTMsMzcgKzI1Myw0MSBAQCBpbnQgbmZzM19wcm9jX3NldGFjbHMoc3RydWN0
IGlub2RlICppbm9kZSwNCj4gc3RydWN0IHBvc2l4X2FjbCAqYWNsLA0KPiAgDQo+ICBpbnQgbmZz
M19zZXRfYWNsKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBwb3NpeF9hY2wgKmFjbCwgaW50
DQo+IHR5cGUpDQo+ICB7DQo+IC0Jc3RydWN0IHBvc2l4X2FjbCAqYWxsb2MgPSBOVUxMLCAqZGZh
Y2wgPSBOVUxMOw0KPiArCXN0cnVjdCBwb3NpeF9hY2wgKm9yaWcgPSBhY2wsICpkZmFjbCA9IE5V
TEw7DQo+ICAJaW50IHN0YXR1czsNCj4gIA0KPiAgCWlmIChTX0lTRElSKGlub2RlLT5pX21vZGUp
KSB7DQo+ICAJCXN3aXRjaCh0eXBlKSB7DQo+ICAJCWNhc2UgQUNMX1RZUEVfQUNDRVNTOg0KPiAt
CQkJYWxsb2MgPSBkZmFjbCA9IGdldF9hY2woaW5vZGUsDQo+IEFDTF9UWVBFX0RFRkFVTFQpOw0K
PiAtCQkJaWYgKElTX0VSUihhbGxvYykpDQo+IC0JCQkJZ290byBmYWlsOw0KPiArCQkJZGZhY2wg
PSBnZXRfYWNsKGlub2RlLCBBQ0xfVFlQRV9ERUZBVUxUKTsNCj4gKwkJCXN0YXR1cyA9IFBUUl9F
UlIoZGZhY2wpOw0KPiArCQkJaWYgKElTX0VSUihkZmFjbCkpDQo+ICsJCQkJZ290byBvdXQ7DQo+
ICAJCQlicmVhazsNCj4gIA0KPiAgCQljYXNlIEFDTF9UWVBFX0RFRkFVTFQ6DQo+ICAJCQlkZmFj
bCA9IGFjbDsNCj4gLQkJCWFsbG9jID0gYWNsID0gZ2V0X2FjbChpbm9kZSwgQUNMX1RZUEVfQUND
RVNTKTsNCj4gLQkJCWlmIChJU19FUlIoYWxsb2MpKQ0KPiAtCQkJCWdvdG8gZmFpbDsNCj4gKwkJ
CWFjbCA9IGdldF9hY2woaW5vZGUsIEFDTF9UWVBFX0FDQ0VTUyk7DQo+ICsJCQlzdGF0dXMgPSBQ
VFJfRVJSKGFjbCk7DQo+ICsJCQlpZiAoSVNfRVJSKGFjbCkpDQo+ICsJCQkJZ290byBvdXQ7DQo+
ICAJCQlicmVhazsNCj4gIAkJfQ0KPiAgCX0NCj4gIA0KPiAgCWlmIChhY2wgPT0gTlVMTCkgew0K
PiAtCQlhbGxvYyA9IGFjbCA9IHBvc2l4X2FjbF9mcm9tX21vZGUoaW5vZGUtPmlfbW9kZSwNCj4g
R0ZQX0tFUk5FTCk7DQo+IC0JCWlmIChJU19FUlIoYWxsb2MpKQ0KPiAtCQkJZ290byBmYWlsOw0K
PiArCQlhY2wgPSBwb3NpeF9hY2xfZnJvbV9tb2RlKGlub2RlLT5pX21vZGUsIEdGUF9LRVJORUwp
Ow0KPiArCQlzdGF0dXMgPSBQVFJfRVJSKGFjbCk7DQo+ICsJCWlmIChJU19FUlIoYWNsKSkNCj4g
KwkJCWdvdG8gb3V0Ow0KPiAgCX0NCj4gIAlzdGF0dXMgPSBfX25mczNfcHJvY19zZXRhY2xzKGlu
b2RlLCBhY2wsIGRmYWNsKTsNCj4gLQlwb3NpeF9hY2xfcmVsZWFzZShhbGxvYyk7DQo+ICtvdXQ6
DQo+ICsJaWYgKGFjbCAhPSBvcmlnKQ0KPiArCQlwb3NpeF9hY2xfcmVsZWFzZShhY2wpOw0KPiAr
CWlmIChkZmFjbCAhPSBvcmlnKQ0KPiArCQlwb3NpeF9hY2xfcmVsZWFzZShkZmFjbCk7DQo+ICAJ
cmV0dXJuIHN0YXR1czsNCj4gLQ0KPiAtZmFpbDoNCj4gLQlyZXR1cm4gUFRSX0VSUihhbGxvYyk7
DQo+ICB9DQo+ICANCj4gIGNvbnN0IHN0cnVjdCB4YXR0cl9oYW5kbGVyICpuZnMzX3hhdHRyX2hh
bmRsZXJzW10gPSB7DQo+IA0KPiBiYXNlLWNvbW1pdDogYWU4M2QwYjQxNmRiMDAyZmU5NTYwMWU3
Zjk3ZjY0YjU5NTE0ZDkzNg0KDQpXZWxsLCB0aGF0IHNob3VsZCBPb3BzIHdoZW4gZWl0aGVyIElT
X0VSUihhY2wpIG9yIElTX0VSUihkZmFjbCkNCnRyaWdnZXJzLCBzaG91bGRuJ3QgaXQ/IPCfmYIN
Cg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
