Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354581B1840
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 23:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDTVUn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 17:20:43 -0400
Received: from mail-co1nam11on2097.outbound.protection.outlook.com ([40.107.220.97]:52321
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbgDTVUm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 Apr 2020 17:20:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UR5VTzWPdJUa5y5bncOGXI0dnsoXEB+wa/c8gBFhaTcnhKHEEk8JF5nn9ORHrDWzH12WWtO7r8Dz8RYtgTAQ8iZ3GvNCUlll18Y+HKFTiB52zPE7R2TdHiIIDpIElHf7hRDVNM5SEvDjZ0x97v8DMzcQLmEhkx+SQJZI26D7SvKlZl15DKM9Nwa4FX1KLHub8lf/vBZxtCb2ltAXaLZ2BYZSGheXdVwyYcL0ct1l8G2exTyaWZMr2bb72xd7lBOqUKeFyI+ZBgfY6gdKKBAgVc2qmyEJlHbFoKQWSEGXqOK22T3BwiUOD6Vfh8OZWGCszjqTgbvyaf7uxh+xubZTyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frN3d16VKfvYKGVPybh3ukIxyQnNWcrGBbukWCUCuHU=;
 b=gtFANpzK3aF36IIKmTmIEEIXKDwbIhAqygJosnlFuuCmwqduslQUHwGayDnqTylEHo52a8uLTsIVSRXBk8vfxnyreXvFnT2xsQZ+0Ri2BayQ7g9YPzcnew+x2ZswdULXz2ZNaRAPfpIFcchbyJv35Ol5CoVIK+LgAHi+TpIcRUGv+ZApAr7xE6JshKIZc3+zGhF2xmxkrhozaEt7cBzHW5wtJsQfdkp99PRN/gbp+AE8LG9cUl7YyuaKRd3UI4LKIkBqJLfAx4zsbi+DQxwWclHLahhwMW2YTlMxNvmtKqHdLYvl05/CjfgKoUNa+UqkpOPRJ9w97Cldbg1robUTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frN3d16VKfvYKGVPybh3ukIxyQnNWcrGBbukWCUCuHU=;
 b=a7hY+OZljx8JphqyzopSD0v3dKj854qAeEBTn4juhrksxKCWmZ0QNCCxzc5kQIW1PLkzrGECzsjtOtoYG4+5+o2QK5vyQU+uvTZc+uKxVx8wGSG4pohelc4I0fdz289ZAqQMUYCrQt04KYtXzX5rhLUWX+wybB+cDVv947Yx9hA=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3815.namprd13.prod.outlook.com (2603:10b6:610:91::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6; Mon, 20 Apr
 2020 21:20:39 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2937.011; Mon, 20 Apr 2020
 21:20:39 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
Thread-Topic: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
Thread-Index: AQHWFMsRjFm2JNXk8kav0WOkI+SUpah9cM+AgAADbACAAApfgIAAB24AgAAB0wCABIX4AIAAA9IAgAALwoCAAAGUAIAAQ8uAgAAJagCAAB1LgA==
Date:   Mon, 20 Apr 2020 21:20:39 +0000
Message-ID: <fbd6f65b176449e7a1abd5731361ad4e6fa15900.camel@hammerspace.com>
References: <20200417151540.22111-1-olga.kornievskaia@gmail.com>
         <9c6c72708f360f543e2b8caaf56cc074aa825c96.camel@hammerspace.com>
         <CAN-5tyHQ_Gs-HmWLdbQYz1o8UyB2jv_oD2EtJP94qgtrfeK52Q@mail.gmail.com>
         <7dd1b9300d2a0ec1a31fb3879c62a94f535ccad5.camel@hammerspace.com>
         <CAN-5tyEbi8Z8bxU1enkkhjAyJj-nb9=j33xcLi7FE2+A79-qng@mail.gmail.com>
         <52b65780986192bb635638d4615176bbc1ad579c.camel@hammerspace.com>
         <CAN-5tyFjohv0YQOgtsoxcqL+eUxNXGRZOfd5zOvm_8nCOnJhJg@mail.gmail.com>
         <402396992273d33f880af913134b063819ab1d22.camel@hammerspace.com>
         <CAN-5tyFJQiG6osJ-gW-XHpQZm9SE0oJumRRfTTYkk-dEqDrYcg@mail.gmail.com>
         <CAN-5tyFLusaQbzw2uN9DUtytrWsuQrrYGz44X=Cvj1WS=gD=Hg@mail.gmail.com>
         <2e691fb93a4b6d362cdfd85feaaa9cfbfc68709c.camel@hammerspace.com>
         <CAN-5tyE2ix4urwhFN_ctcPoTwDrWu5jM2gEbuD4cvc-_k6NVvg@mail.gmail.com>
In-Reply-To: <CAN-5tyE2ix4urwhFN_ctcPoTwDrWu5jM2gEbuD4cvc-_k6NVvg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e4e6ca1-fe21-4bc1-1801-08d7e570acb9
x-ms-traffictypediagnostic: CH2PR13MB3815:
x-microsoft-antispam-prvs: <CH2PR13MB3815AB2FCF8D74876586A147B8D40@CH2PR13MB3815.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(346002)(136003)(39830400003)(366004)(53546011)(6506007)(8936002)(4326008)(2616005)(66556008)(86362001)(66476007)(64756008)(66946007)(76116006)(91956017)(66446008)(5660300002)(478600001)(36756003)(71200400001)(186003)(26005)(8676002)(54906003)(6512007)(316002)(81156014)(6486002)(2906002)(6916009);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ScJlSOw34Y4M+RgJhNgWZKayjafKFGuY8sKWXJZ7A1iL2gKWbyoP6eXqAkW3KacGxBk/Ihb/6ktnAR2utffP9u3CTYrBk/bspnFHV2/ijgmBI4dCgxiKouetQ8XlCt1MypKaQdPr1DovuxF71UoKnF+IlwNYvSw1eCMZ7LCx3ZdZ43rJDvPi1WcfVLDVhFxp7eubCia0tKXd5kjeI8PlzoLnMZn1eHhnSza4wXFnkpkhgHc/w7My4JZaVA2pFW3h9+x9PWGIhdKkK1clu78wrVF/Q+YpoIZQmuYHzVlGNYOnDJgVwaNEigLYFor0H/Xmxk2TSzfeztM+4iu098trsvmcYinggAb5wAzc9aitV4kW5AKlusT2LBDmP0BW5mKwNdmhfF6xIQpK9A4NIaOSIc5VwjkPT6ev9MAMerNFtpF4nK+fGpXh98XhQ3zRjB7O
x-ms-exchange-antispam-messagedata: BKJxLPyzXvYiVJjSBL1coj5BhFkNE6ZYeu9qMbVLGTi5oKrPbG9soo//0zWH0UI4fkb+ztzBABcsVB10l3o4KLDbs5A9h1vtCKtLUHN1iw7cURJJvdmnP2M3VbCQs4o14s5L40bY+X+g60JS3P+jvCwkz14LvM4BkT2/VTOpA6LAv0VVrZzUETheU4+4FOL9cumY/P2ZZtGeG1i/nCDeN4pzH7IJuc21vdDNY1rx/p97P7jrR6iVEjTM7YUOkw+rOrw+nHFC58mUW8C+dsZCv04pstodJwyTmKXPWtfaISJJXZlgyFfjjUpfa61keNYs2WrYkakGhMvO036s8+g5tMIvePTEa0ROdpNo9HSLi9iR6MHcFRL75Y4eCHdJ9Qsx4M9ciLIQxP3r0rfQsiCEgemoKKchiHQBAuYL8UG3Mm2mnQMXTcBP5hddWfzbe9TXSY5AcGTo9heaaBBGj5ot0I2AX+j3gxWGLuA1OZBogGDwsbu3qMavHRkd5JK4flmPOVlKSbKAmE7QffQDbzvXRyhJLfst8+k0o0jq6Eo1BvpKGIga8cA58UFzMHhC1ofT+PIrF1IMixKBUwkCm4BWpKBAOMioXq3Vc/YR3bcU3p1Gw+QNgK2WSByzZUxvlPW9/8OQz1fSxJpfROse0HgLkLv+orDSQ3j42S5ndplCk+WaERX9OrNgBT1O3o5I5y72mVOLG5mQB0oo9rWW02pvBnF/wQk/J+MvUSNCeoCHgUGW4Ym9r2Dn2yK2LlsuA1tE3GwKlJtefIT/v0c1Mz2SnrZwR3URxSjdSixiZ5WUmaM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <066C39B96052934FA3A66CC60BBA742C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4e6ca1-fe21-4bc1-1801-08d7e570acb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 21:20:39.2154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SHUnJ2uZH0IUtzzxmDm6cGuGxXSj/CeZHcsKLiiYmD9XL7RIvFaOiVbMTaSb+npdHuvQ1t5esZT1f9i+nuL9iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3815
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTIwIGF0IDE1OjM1IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gTW9uLCBBcHIgMjAsIDIwMjAgYXQgMzowMiBQTSBUcm9uZCBNeWtsZWJ1c3QgPA0K
PiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gT24gTW9uLCAyMDIwLTA0LTIw
IGF0IDEwOjU5IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+IA0KPiA+ID4g
T24gTW9uLCBBcHIgMjAsIDIwMjAgYXQgMTA6NTMgQU0gT2xnYSBLb3JuaWV2c2thaWEgPA0KPiA+
ID4gb2xnYS5rb3JuaWV2c2thaWFAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+ID4gWWVzIHdlIGFy
ZSBjb25zaXN0ZW50IGluIHJlcXVlc3RpbmcgdG8gc2FtZSBjb25uZWN0aW9uIHRvIHdpdGgNCj4g
PiA+ID4gdGhlDQo+ID4gPiA+IHNhbWUgY2hhbm5lbCBiaW5kaW5nLCBidXQgd2UgZG9uJ3Qgc2Vu
ZCBCSU5EX0NPTk5fVE9fU0VTU0lPTiBhcw0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gZmlyc3QgdGhp
bmcgb24gdGhlICJtYWluIiBjb25uZWN0aW9uIChpZSBjb25uZWN0aW9uIHRoYXQgY2FyZWQNCj4g
PiA+ID4gdGhlDQo+ID4gPiA+IENSRUFURV9TRVNTSU9OIGFuZCB3YXMgYm91bmQgdG8gZm9yZSBh
bmQgYmFjayBjaGFubmVsIGJ5DQo+ID4gPiA+IGRlZmF1bHQpLg0KPiA+ID4gPiBXaGVuIHRoYXQg
Y29ubmVjdGlvbiBpcyByZXNldCwgdGhlIGZpcnN0IHRoaW5nIHRoYXQgaGFwcGVucyBpcw0KPiA+
ID4gPiB0aGUNCj4gPiA+ID4gY2xpZW50IHJlLXNlbmRzIHRoZSBvcGVyYXRpb24gdGhhdCB3YXMg
bm90IHJlcGxpZWQgdG8uIFRoYXQgaGFzDQo+ID4gPiA+IGENCj4gPiA+ID4gU0VRVUVOQ0UgYW5k
IGJ5IHRoZSBydWxlIHRoZSBzZXJ2ZXIgYmluZHMgdGhhdCBjb25uZWN0aW9uIHRvDQo+ID4gPiA+
IHRoZQ0KPiA+ID4gPiBmb3JlIGNoYW5uZWwgb25seSAoYW5kIHNldHMgdGhlIGNhbGxiYWNrIGJl
aW5nIGRvd24pLiBXZSB0aGVuDQo+ID4gPiA+IHNlbmQNCj4gPiA+ID4gQklORF9DT05OX1RPX1NF
U1NJT04gYW5kIHJlcXVlc3QgRk9SRV9PUl9CT1RIIHdoZXJlIHRoaXMgaGFzDQo+ID4gPiA+IGFs
cmVhZHkgYmVlbiBib3VuZCB0byBGT1JFIG9ubHkuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBI
b3cgYWJvdXQgdGhpczogYmVmb3JlIHdlIHNlbmQgQklORF9DT05OX1RPX1NFU1NJT04gd2l0aA0K
PiA+ID4gZm9yZV9vcl9ib3RoLCB3ZSBzb21laG93IGFsd2F5cyByZXNldCB0aGUgY29ubmVjdGlv
biAobWF5YmUgeW91DQo+ID4gPiB3ZXJlDQo+ID4gPiBzdWdnZXN0aW9uIHRoYXQgYWxyZWFkeSBh
bmQgaSB3YXNuJ3QgZm9sbG93aW5nKS4NCj4gPiANCj4gPiBOby4gSSBkaWRuJ3QgcmVhbGlzZSB0
aGF0IHdlIHdlcmUgYmVpbmcgYXV0b21hdGljYWxseSBzZXQgdG8ganVzdA0KPiA+IHRoZQ0KPiA+
IGZvcmUgY2hhbm5lbC4gSG93ZXZlciBhcyBJIHNhaWQgZWFybGllciwgdGhlIHNwZWMgc2F5cyB0
aGF0IHRoZQ0KPiA+IHNlcnZlcg0KPiA+IE1VU1QgcmVwbHkgd2l0aCBORlM0RVJSX0lOVkFMIGlu
IHRoaXMgY2FzZS4gSXQgaXMgbm90IGFsbG93ZWQgdG8NCj4gPiBqdXN0DQo+ID4gcmV0dXJuIE5G
UzRfT0sgYW5kIHNpbGVudGx5IHNldCB0aGUgd3JvbmcgY2hhbm5lbCBiaW5kaW5nLg0KPiANCj4g
SG93J3MgdGhpczoNCj4gY2xpZW50IHNlbmRzIEJJTkRfQ09OTl9UT19TRVNTSU9OIHdpdGggRk9S
RV9PUl9CT1RILCBzZXJ2ZXIgc2VsZWN0DQo+IEZPUkUgY2hhbm5lbC4gY29ubmVjdGlvbiBicmVh
a3MgYmVmb3JlIHRoZSByZXBseSBnZXRzIHRvIHRoZSBjbGllbnQuDQo+IENsaWVudCByZXNlbmRz
LiBJcyB0aGUgc2VydmVyIHN1cHBvc2UgdG8gbm93IGZhaWwgd2l0aCBFUlJfSU5WQUw/DQo+IA0K
PiBUaGVyZSBhY3R1YWxseSBpcyBzdWNoIGEgdGhpbmcgYmV0d2VlbiBkZW1hbmQgYW5kIHJlcXVl
c3QuIEZPUkUgYW5kDQo+IEJBQ0sgYXJlIGRlbWFuZHMgYW5kIEZPUkVfT1JfQk9USCBhbmQgQkFD
S19PUl9CT1RIIGFyZSByZXF1ZXN0cy4gVGhlDQo+IHNwZWMgd3JpdGVzIG9ubHkgYWJvdXQgZGVt
YW5kcyBhbmQgbm90IHRoZSByZXF1ZXN0cy4gSSBiZWxpZXZlIHRoYXQncw0KPiBpbnRlbnRpb25h
bCBiZWNhdXNlIEJJTkRfQ09OTl9UT19TRVNTSU9uIGRvZXNuJ3QgaGF2ZSBhIHNlcXVlbmNlIGFu
ZA0KPiBub3QgcHJvdGVjdGVkIGJ5IHJlcGx5IHNlc3Npb24gc2VtYW50aWNzLg0KDQpPSy4gSG93
ZXZlciBpZiB3ZSB0YWtlIHRoYXQgaW50ZXJwcmV0YXRpb24sIHRoZW4gdGhlIHF1ZXN0aW9uIGlz
IHdoeQ0Kd291bGQgdGhlIHNlcnZlciBkb3duZ3JhZGUgb3VyIEZPUkVfT1JfQk9USCB0byBGT1JF
IGFuZCB3aGF0IGlzIHRoZQ0KcG9pbnQgb2YgdGhlIGNsaWVudCBldmVuIHJldHJ5aW5nIGF0IGFs
bCBpbiB0aGF0IGNhc2U/DQoNClRoZSBzZXJ2ZXIgY2FuIGFsd2F5cyByZWplY3QgdGhlIGNsaWVu
dCdzIGJhY2sgY2hhbm5lbCBjcmVhdGlvbg0KYXR0ZW1wdCwgYnV0IGRvaW5nIHNvIGhhcyBjb25z
ZXF1ZW5jZXM6IGl0IG1lYW5zIHRoZXJlIGlzIG5vIHdheSB0bw0KaGFuZCBvdXQgZGVsZWdhdGlv
bnMgb3IgbGF5b3V0cy4gU28gSSdtIGNvbmZ1c2VkIGJ5IHRoZSBjb25jZXB0IG9mIGENCnNlcnZl
ciB0aGF0IHNldHMgU0VRNF9TVEFUVVNfQ0JfUEFUSF9ET1dOIG9yDQpTRVE0X1NUQVRVU19DQl9Q
QVRIX0RPV05fU0VTU0lPTiwgYnV0IHRoZW4gZG9lc24ndCBhbGxvdyB0aGUgY2xpZW50IHRvDQpz
ZXQgYSBiYWNrIGNoYW5uZWwuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tDQoNCg0K
