Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9990528653F
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 18:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgJGQuc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 12:50:32 -0400
Received: from mail-eopbgr760107.outbound.protection.outlook.com ([40.107.76.107]:41694
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726388AbgJGQub (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Oct 2020 12:50:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm6yi7dVYg+c4uTBVIsIqGj1wbovetp0A9+EMSH0HnUipRBB8KX77KdFMBIg3Ew4xMertfz5QwR3JHP3fo/tamiET0FVkswwdGkXWk7FosAB7PW7vyHX0ld60JyPE/JET0oqFIxLGru6aG2HnCbOQG3Sam5vpUfxOWOQzF1aocOoxvBEVViyITmwpseam3q19sqJeBG2nrp9BkI+AI9RQ46WZ3iaEi0QZ3DhBLD5cW+UamMz5vuwvGAEcnEhAzNJ8rTeRlBFkxJH/LqfDR6CuwkSjRG153mrTI4Jzn9J9t2dZzIdfBiPwoHTcKwMFBBvGHqi7WE0XWIkTNucl+wIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjDoFp9JKBXTl3q/yvwbtFN+jdnutJeqsoyZRZ7ZJ2I=;
 b=WmNmsJ/VJMkcbdE+EWSRH0s2bajDjB3NeyFRBPs7QQ4c5YssBuN6/GfZW3p/Kp/5cZlWEa80E476Tbe/flVG9W8hIaaqKK6t6+53a2iVcN0xKtSomJH6FOq/TzRQ8uRXQz2iPF1VIZ51Q5xJJSdYXkkHIUiJMgnEY7kikaGBbLw6vmtWzIvmtrv4GZ3dQI0XnRlBvesS49hiNgY1kdjVQea1s9z1w0nGVI2Ts0ycXC5CNDwklgVStiElLXQkNw+/LgLDEOHvaqkwqxSXaMYIVWp3dil+o4Kz9l/3WNePwrrl2Wr1aN/k+1FclLbo7Vtcx22Lvk8vkOHlEfK6ahPFjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjDoFp9JKBXTl3q/yvwbtFN+jdnutJeqsoyZRZ7ZJ2I=;
 b=bXiizXGIna3BTjIGWV+WUTcWV7ys/8mGCeW9qg/BTbdIVSgF9s5xCiVnvxX595GFaYKf5MIJMBRsXzZKinosim1G4vroYmZH3zh2dkxNUngEWY3/UFvH9aBIPvtoUBZfXSvkN2LAF1tINAHj8DidOg+4PVJKbPE0Rd8E3mFzA/g=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB2799.namprd13.prod.outlook.com (2603:10b6:208:f1::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11; Wed, 7 Oct
 2020 16:50:27 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%7]) with mapi id 15.20.3455.021; Wed, 7 Oct 2020
 16:50:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: unsharing tcp connections from different NFS mounts
Thread-Topic: unsharing tcp connections from different NFS mounts
Thread-Index: AQHWm/NG4ET1NagHX0mhv4Iw/L0dZKmK9/iAgAAkV4CAACp7AIAAuvkAgAAYugCAAA3yAIAABV0AgAAC94CAAB7QAIAADG0A
Date:   Wed, 7 Oct 2020 16:50:26 +0000
Message-ID: <e06c31e4211cefda52091c7710d871f44dc9160e.camel@hammerspace.com>
References: <20201006151335.GB28306@fieldses.org>
         <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
         <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
         <20201007001814.GA5138@fieldses.org>
         <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
         <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
         <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>
         <20201007140502.GC23452@fieldses.org>
         <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
         <20201007160556.GE23452@fieldses.org>
In-Reply-To: <20201007160556.GE23452@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc8be85c-4b87-4574-3f57-08d86ae117a0
x-ms-traffictypediagnostic: MN2PR13MB2799:
x-microsoft-antispam-prvs: <MN2PR13MB27997CCB644E2610A607875DB80A0@MN2PR13MB2799.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 41tS+k1uBafCUd2gPWBqPdrQl2oWUUL3TR006J0abR4D+zfG23qKSFKava2UBSHCyCvWDom0COfDna4nUWrUpCa6i234rOI/Y3RUOW2zGxLrDeBZcc2Y8XaISiN7ALfiPmu4MjC/adfDHm6C02HPh5bgxXdGKkrBdaHOKGenkKg8ELHThK/0c74505hi0tjq5pBNEr8enCyecquK1YetO5p8AYfEA05WCPQ8L/vsRb5V5Na8094BRPy/9FcBkH/ac6BCTmz1RiGWyv9w9U4aFeYd+Pa2kubaAOH5ncTwOln9ccaUwHed2hLdV+4Fs3YAlbWFn5ozctlm4YtOGJIuCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(346002)(136003)(366004)(376002)(36756003)(6512007)(4326008)(83380400001)(6506007)(26005)(186003)(53546011)(6486002)(54906003)(316002)(110136005)(2616005)(478600001)(86362001)(5660300002)(66556008)(66946007)(2906002)(66446008)(76116006)(66476007)(64756008)(91956017)(8936002)(8676002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: R/QxJZg4Z5dVCjfo6BejgO/oGoe1hFt6N3oRCu3wXiYvOkP3iQEcv9kfE4bII+jKPo6TkWourUSZVyGTZG/DRn9H2hqA6doma7tq4QZtNO8y+qNk/gVyeZ3BVUOqYuT7AhPn782HVB9Ts3xQMIkmBX6XP8RHX+HTbsv8LC7x30n4sDk0nhhe/JDjodoei378EbHhP1HXzy9lxPev/hoJu6bgyrqeK1ply+E/O2M81YY9bjOc4GttEPSTyCKPw96wYCIcb9uS+RC0/xRRlHQ0zsDwm4Yqs9sVInvABa/jbLOJ30WoQWr8O8XzhaZ/i9eq8hivjqEWoW+1Pvglv6acFiAbTmOtciPnPxyv2P9X/WDy3fkR+18bM8PxsuDAG39rg2NgwUiyLsrUeUK6SFWNRnLEVLt96Wbesrue6vWT3Uy5liekemF4n8qmeR/XsweIviiL9p4sWk7WUZi84xfFL5ZL5uLa7VhnRRgFV+mPvsGettG/yEClxaQybX63CoYPQiY5InYA7KlXTBK87IIkXHMwN50BFNfzQZlojN00/SxqVqT2OI7Y4X+6eux9YiCiYp7mdTBIFUGZkJZnyqLYsBzecVpNrr2/k4VzeET9Vutx7s5i962Fk8vR+/n+Cwzr8MzZUaXyADTv41OSAAaPDQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <298579B53A0564459BF89BEE885F2B6F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8be85c-4b87-4574-3f57-08d86ae117a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 16:50:26.7955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S1R9NIG7BM7d+Sj3KEUK1SgGlrTKocS4xBj8m9KK8RBCkibz+WDbLx/8qjBHO0LpVcwtF+mjcqn5qG8UNgqFOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2799
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTEwLTA3IGF0IDEyOjA1IC0wNDAwLCBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+
IE9uIFdlZCwgT2N0IDA3LCAyMDIwIGF0IDEwOjE1OjM5QU0gLTA0MDAsIENodWNrIExldmVyIHdy
b3RlOg0KPiA+IA0KPiA+ID4gT24gT2N0IDcsIDIwMjAsIGF0IDEwOjA1IEFNLCBCcnVjZSBGaWVs
ZHMgPGJmaWVsZHNAZmllbGRzZXMub3JnPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IE9u
IFdlZCwgT2N0IDA3LCAyMDIwIGF0IDA5OjQ1OjUwQU0gLTA0MDAsIENodWNrIExldmVyIHdyb3Rl
Og0KPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBPY3QgNywgMjAyMCwgYXQgODo1NSBBTSwgQmVuamFt
aW4gQ29kZGluZ3RvbiA8DQo+ID4gPiA+ID4gYmNvZGRpbmdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24gNyBPY3QgMjAyMCwgYXQgNzoyNywgQmVuamFtaW4gQ29k
ZGluZ3RvbiB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIDYgT2N0IDIwMjAsIGF0
IDIwOjE4LCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
ID4gT24gVHVlLCBPY3QgMDYsIDIwMjAgYXQgMDU6NDY6MTFQTSAtMDQwMCwgT2xnYQ0KPiA+ID4g
PiA+ID4gPiBLb3JuaWV2c2thaWEgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCBPY3Qg
NiwgMjAyMCBhdCAzOjM4IFBNIEJlbmphbWluIENvZGRpbmd0b24gPA0KPiA+ID4gPiA+ID4gPiA+
IGJjb2RkaW5nQHJlZGhhdC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gT24gNiBPY3Qg
MjAyMCwgYXQgMTE6MTMsIEouIEJydWNlIEZpZWxkcyB3cm90ZToNCj4gPiA+ID4gPiA+ID4gTG9v
a3MgbGlrZSBuZnM0X2luaXRfe25vbn11bmlmb3JtX2NsaWVudF9zdHJpbmcoKSBzdG9yZXMNCj4g
PiA+ID4gPiA+ID4gaXQgaW4NCj4gPiA+ID4gPiA+ID4gY2xfb3duZXJfaWQsIGFuZCBJIHdhcyB0
aGlua2luZyB0aGF0IG1lYW50IGNsX293bmVyX2lkDQo+ID4gPiA+ID4gPiA+IHdvdWxkIGJlIHVz
ZWQNCj4gPiA+ID4gPiA+ID4gZnJvbSB0aGVuIG9uLi4uLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gQnV0IGFjdHVhbGx5LCBJIHRoaW5rIGl0IG1heSBydW4gdGhhdCBhZ2FpbiBvbiBy
ZWNvdmVyeSwNCj4gPiA+ID4gPiA+ID4geWVzLCBzbyBJIGJldA0KPiA+ID4gPiA+ID4gPiBjaGFu
Z2luZyB0aGUgbmZzNF91bmlxdWVfaWQgcGFyYW1ldGVyIG1pZHdheSBsaWtlIHRoaXMNCj4gPiA+
ID4gPiA+ID4gY291bGQgY2F1c2UgYnVncw0KPiA+ID4gPiA+ID4gPiBvbiByZWNvdmVyeS4NCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQWgsIHRoYXQncyB3aGF0IEkgdGhvdWdodCBhcyB3ZWxs
LiAgVGhhbmtzIGZvciBsb29raW5nDQo+ID4gPiA+ID4gPiBjbG9zZXIgT2xnYSENCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBXZWxsLCBubyAtLSBpdCBkb2VzIGluZGVlZCBjb250aW51ZSB0byB1c2Ug
dGhlIG9yaWdpbmFsDQo+ID4gPiA+ID4gY2xfb3duZXJfaWQuICBXZQ0KPiA+ID4gPiA+IG9ubHkg
anVtcCB0aHJvdWdoIG5mczRfaW5pdF91bmlxdWlmaWVyX2NsaWVudF9zdHJpbmcoKSBpZg0KPiA+
ID4gPiA+IGNsX293bmVyX2lkIGlzDQo+ID4gPiA+ID4gTlVMTDoNCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiA2MDg3IHN0YXRpYyBpbnQNCj4gPiA+ID4gPiA2MDg4IG5mczRfaW5pdF91bmlmb3JtX2Ns
aWVudF9zdHJpbmcoc3RydWN0IG5mc19jbGllbnQgKmNscCkNCj4gPiA+ID4gPiA2MDg5IHsNCj4g
PiA+ID4gPiA2MDkwICAgICBzaXplX3QgbGVuOw0KPiA+ID4gPiA+IDYwOTEgICAgIGNoYXIgKnN0
cjsNCj4gPiA+ID4gPiA2MDkyDQo+ID4gPiA+ID4gNjA5MyAgICAgaWYgKGNscC0+Y2xfb3duZXJf
aWQgIT0gTlVMTCkNCj4gPiA+ID4gPiA2MDk0ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gPiA+ID4g
NjA5NQ0KPiA+ID4gPiA+IDYwOTYgICAgIGlmIChuZnM0X2NsaWVudF9pZF91bmlxdWlmaWVyWzBd
ICE9ICdcMCcpDQo+ID4gPiA+ID4gNjA5NyAgICAgICAgIHJldHVybiBuZnM0X2luaXRfdW5pcXVp
Zmllcl9jbGllbnRfc3RyaW5nKGNscCk7DQo+ID4gPiA+ID4gNjA5OA0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IFRlc3RpbmcgcHJvdmVzIHRoaXMgb3V0IGFzIHdlbGwgZm9yIGJv
dGggRVhDSEFOR0VfSUQgYW5kDQo+ID4gPiA+ID4gU0VUQ0xJRU5USUQuDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gSXMgdGhlcmUgYW55IHByZWNlZGVudCBmb3Igc3RhYmlsaXppbmcgbW9kdWxlIHBh
cmFtZXRlcnMgYXMNCj4gPiA+ID4gPiBwYXJ0IG9mIGENCj4gPiA+ID4gPiBzdXBwb3J0ZWQgaW50
ZXJmYWNlPyAgTWF5YmUgdGhpcyBvdWdodCB0byBiZSBhIG1vdW50IG9wdGlvbiwNCj4gPiA+ID4g
PiBzbyBjbGllbnQgY2FuDQo+ID4gPiA+ID4gc2V0IGEgdW5pcXVpZmllciBwZXItbW91bnQuDQo+
ID4gPiA+IA0KPiA+ID4gPiBUaGUgcHJvdG9jb2wgaXMgZGVzaWduZWQgYXMgb25lIGNsaWVudC1J
RCBwZXIgY2xpZW50LiBGcmVlQlNEDQo+ID4gPiA+IGlzDQo+ID4gPiA+IHRoZSBvbmx5IGNsaWVu
dCBJIGtub3cgb2YgdGhhdCB1c2VzIG9uZSBjbGllbnQtSUQgcGVyIG1vdW50LA0KPiA+ID4gPiBm
d2l3Lg0KPiA+ID4gPiANCj4gPiA+ID4gWW91IGFyZSBzdWdnZXN0aW5nIGVhY2ggbW91bnQgcG9p
bnQgd291bGQgaGF2ZSBpdHMgb3duIGxlYXNlLg0KPiA+ID4gPiBUaGVyZQ0KPiA+ID4gPiB3b3Vs
ZCBsaWtlbHkgYmUgZGVlcGVyIGltcGxlbWVudGF0aW9uIGNoYW5nZXMgbmVlZGVkIHRoYW4ganVz
dA0KPiA+ID4gPiBzcGVjaWZ5aW5nIGEgdW5pcXVlIGNsaWVudC1JRCBmb3IgZWFjaCBtb3VudCBw
b2ludC4NCj4gPiA+IA0KPiA+ID4gSHVoLCBJIHRob3VnaHQgdGhhdCBzaG91bGQgZG8gaXQuDQo+
ID4gPiANCj4gPiA+IERvIHlvdSBoYXZlIHNvbWV0aGluZyBzcGVjaWZpYyBpbiBtaW5kPw0KPiA+
IA0KPiA+IFRoZSByZWxhdGlvbnNoaXAgYmV0d2VlbiBuZnNfY2xpZW50IGFuZCBuZnNfc2VydmVy
IHN0cnVjdHMgY29tZXMgdG8NCj4gPiBtaW5kLg0KPiANCj4gSSdtIG5vdCBmb2xsb3dpbmcuICBE
byB5b3UgaGF2ZSBhIHNwZWNpZmljIHByb2JsZW0gaW4gbWluZD8NCj4gDQoNClRoZSBwcm9ibGVt
IHRoYXQgYWxsIGxvY2tzIGV0YyBhcmUgdGllZCB0byB0aGUgbGVhc2UsIHNvIGlmIHlvdSBjaGFu
Z2UNCnRoZSBjbGllbnRpZCAoYW5kIGhlbmNlIGNoYW5nZSB0aGUgbGVhc2UpIHRoZW4geW91IG5l
ZWQgdG8gZW5zdXJlIHRoYXQNCnRoZSBjbGllbnQga25vd3MgdG8gd2hpY2ggbGVhc2UgdGhlIGxv
Y2tzIGJlbG9uZywgdGhhdCBpdCBpcyBhYmxlIHRvDQpyZXNwb25kIGFwcHJvcHJpYXRlbHkgdG8g
YWxsIGRlbGVnYXRpb24gcmVjYWxscywgbGF5b3V0IHJlY2FsbHMsIC4uLg0KZXRjLg0KVGhpcyBu
ZWVkIHRvIHRyYWNrIHRoaW5ncyBvbiBhIHBlci1sZWFzZSBiYXNpcyBpcyB3aHkgd2UgaGF2ZSB0
aGUNCnN0cnVjdCBuZnNfY2xpZW50LiBUaGluZ3MgdGhhdCBhcmUgdHJhY2tlZCBvbiBhIHBlci1z
dXBlcmJsb2NrIGJhc2lzDQphcmUgdHJhY2tlZCBieSB0aGUgc3RydWN0IG5mc19zZXJ2ZXIuDQoN
Ckhvd2V2ZXIgYWxsIHRoaXMgaXMgbW9vdCBhcyBsb25nIGFzIG5vYm9keSBjYW4gZXhwbGFpbiB3
aHkgd2UnZCB3YW50IHRvDQpkbyBhbGwgdGhpcy4NCg0KQXMgZmFyIGFzIEkgY2FuIHRlbGwsIHRo
aXMgdGhyZWFkIHN0YXJ0ZWQgd2l0aCBhIGNvbXBsYWludCB0aGF0DQpwZXJmb3JtYW5jZSBzdWZm
ZXJzIHdoZW4gd2UgZG9uJ3QgYWxsb3cgc2V0dXBzIHRoYXQgaGFjayB0aGUgY2xpZW50IGJ5DQpw
cmV0ZW5kaW5nIHRoYXQgYSBtdWx0aS1ob21lZCBzZXJ2ZXIgaXMgYWN0dWFsbHkgbXVsdGlwbGUg
ZGlmZmVyZW50DQpzZXJ2ZXJzLg0KDQpBRkFJQ1MgVG9tIFRhbHBleSdzIHF1ZXN0aW9uIGlzIHRo
ZSByZWxldmFudCBvbmUuIFdoeSBpcyB0aGVyZSBhDQpwZXJmb3JtYW5jZSByZWdyZXNzaW9uIGJl
aW5nIHNlZW4gYnkgdGhlc2Ugc2V0dXBzIHdoZW4gdGhleSBzaGFyZSB0aGUNCnNhbWUgY29ubmVj
dGlvbj8gSXMgaXQgcmVhbGx5IHRoZSBjb25uZWN0aW9uLCBvciBpcyBpdCB0aGUgZmFjdCB0aGF0
DQp0aGV5IGFsbCBzaGFyZSB0aGUgc2FtZSBmaXhlZC1zbG90IHNlc3Npb24/DQoNCkkgZGlkIHNl
ZSBJZ29yJ3MgY2xhaW0gdGhhdCB0aGVyZSBpcyBhIFFvUyBpc3N1ZSAod2hpY2ggYWZhaWNzIHdv
dWxkDQphbHNvIGFmZmVjdCBORlN2MyksIGJ1dCB3aHkgZG8gSSBjYXJlIGFib3V0IFFvUyBhcyBh
IHBlci1tb3VudHBvaW50DQpmZWF0dXJlPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
