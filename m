Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B311E6ECC
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2020 00:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436961AbgE1WYz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 May 2020 18:24:55 -0400
Received: from mail-dm6nam11on2126.outbound.protection.outlook.com ([40.107.223.126]:49377
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437165AbgE1WYv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 28 May 2020 18:24:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRMqUvdEvxrUhQ5rXIoV0VdpGXjdApqC8xYBuS88QKOElHxnI8f9/awoe6GvWTTqzEXMTg14iH4sAjw8Wh/w4jOQUDbEW3zoA8rLXmo52Rz5Hgs8iijhEb1LpY4CJ31zdl32Nu9nMTVUIUZPgT2sYHLnCFSzL2hXdPnfQyXR8T3jxpd9VVdRYaMYIX6BiCYHjN73GZcEwFXcKBtNoYUuu7RR80ok1i667h7xXWFgMY5Yb2KFg7ObfMPeINtSueF9JHlcnDGAWWSuEslpjO63K7hRVdxHUDiRwzv7WK5lEN6HGF5HZ/HCb6t7UoB0CR2hGXOG4BSOVQvfDnsQmpOD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od0cmIvwfcbLiUtt8Xb71BhVAVeTjFNu4aiCsPgwyws=;
 b=PNRUJe2SzlQq5X+RfcUfn2S6JZ/kZi3sPhaWHgDHRJUL6Ia02XtXqH06KDa6zYqlW6A854QLD86Kl5R3E0K0ktY0I9p1Km/3byYmvF8Thg25h7xDaO0wPriXNZ6uQswozFLMvqe+fDUPeRpBfmGPnYtdubOhqdfM0s554S2CTLGDP1Nw8Lec5vaW9rBMfp1aV1SrF8GvgLeqJTPhxW/e7HKpZYaih5LJoEHWWRdQGUxpqzMefIcYxJvRl8mKAwACTuORT8V4l4ycnr23WsgswK+QVG3qPv9E+V3WTeMIqJTmPQph4nf9dhYoQAOuhPhoCBgyet/gdq61HDV965/Rrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od0cmIvwfcbLiUtt8Xb71BhVAVeTjFNu4aiCsPgwyws=;
 b=VQQ4XBLYs311PIzjs8IMLZvAPXOqflXyaWJ7dH9rT3uLvEfO9CMpALqFfvi2EZqQhiyUFyRKyWrG3HvW1toPw/CNh7w/1zH5BltoqS5JV4RK059D18snceCSmcEGjNddohtAMfTplBAcdERsXu1+v5rvt7dfRRHkFzYZFxiZWuc=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3814.namprd13.prod.outlook.com (2603:10b6:610:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.7; Thu, 28 May
 2020 22:24:47 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 22:24:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: How to handle revocation of locking state
Thread-Topic: How to handle revocation of locking state
Thread-Index: AQHWNTCSBj8lUsFTaUe5HR+XtfbiCqi9/k+AgAAJUICAAAuSAA==
Date:   Thu, 28 May 2020 22:24:46 +0000
Message-ID: <f2f43e89d259c9bc447f2a7b885f236e88d9b6b3.camel@hammerspace.com>
References: <CAN-5tyE-hr2Fd1dKt=DUrVh-FJXzgGx5zhWr17SSbM1LOZ-pGQ@mail.gmail.com>
         <85234f9bde1c419e1a8d7e8a677e5d324325c56b.camel@hammerspace.com>
         <CAN-5tyHcExq5CqwrU3F4nRptt1=X917jzceUqLCTCUDYQsdsMA@mail.gmail.com>
In-Reply-To: <CAN-5tyHcExq5CqwrU3F4nRptt1=X917jzceUqLCTCUDYQsdsMA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adc5afd1-92bc-4068-211b-08d80355ed66
x-ms-traffictypediagnostic: CH2PR13MB3814:
x-microsoft-antispam-prvs: <CH2PR13MB38147B305A931369B67F5188B88E0@CH2PR13MB3814.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q6N7dwMott4g6QSwQTmeHqrM1XfrP23cVvVxgWE/ug7Py4geMFHu0B623U7NOomHXp4eVXy1uQp2A+4bWV5LL2TQiBFdPejYdzRtctPyckmPePgzeLyBn42FQ8uc391O2KTLVo8EU6hgVedBW2Zh3hOyzMIaG2zawsuV4JJpkRbjf8AjDuUasOsEshugpx5vRh8WadCTq8MUOXI6yCxYUjHEM6yojVKgQsIj8/GpZ0j+dSNl99yri17RBWPX10pVJS6XcOHyy0Lnd/d/+rwuDnvDeCvqYLNpp9/+AxESGG+CzFVJAeiDftKLfeSLTW7SF70sIDLRiyvGWjcwBtKQHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(39830400003)(376002)(346002)(136003)(478600001)(8936002)(86362001)(186003)(36756003)(316002)(6486002)(83380400001)(6916009)(64756008)(66476007)(66556008)(26005)(2906002)(6512007)(4326008)(76116006)(66446008)(66946007)(6506007)(71200400001)(53546011)(2616005)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0TKL43Z3h6ZWLvfM4d5XYvqa4Lc+nyS27F7seFTeoxjmcoO2OshNsEq8/Bx7bqUB8toBFubxkgU9xuxXdDyH40mMTgw7LBHGC9rh7xdnf97R3ZT/BBySftHx3W6gB3bvVU1zVrhrBLLJ+xEPNgp0RnMIuzuoGFA/6saJ0Lfgtlucdpb7CUUwHKUqG8OOYAbKmchSbzn8nmMpcUPXT/JO5ihGG8nihzvXv7lNrN4tQQJsTE4lic6timSwrkSXvTycMS+/WsknPjWF5oD1oCnTEmandtWgbHHttvzQnAv063U2Dsvjm2S7f76v2ey0HEK/0oCCJ8wtfZPkkq6HI0Nc4JlHp6gzH038I3bGRhKE4IO8KwfJqep39HAk3avYKoeskAsgoeoiwLcTM32WErtiy/Q8ELcWy7WDomDJk6f8WnNmP646gFCWRst+bmZdjrv9u9jQbVM8QRxtDGc3bx4BzQ5RZr6otwDivHL4Qal16pU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A6A960B706CCD4FBAAE9E42674D829C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc5afd1-92bc-4068-211b-08d80355ed66
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 22:24:46.2402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UD/Hb6ARKjnYGD2LYnu9bKMIu0iwZNjp2mTnK7xH4MgCTqUOaz2XSUAMACS3Jto4YXi1GloTr7wy9cJfTiU+nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3814
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTA1LTI4IGF0IDE3OjQzIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVGh1LCBNYXkgMjgsIDIwMjAgYXQgNToxMCBQTSBUcm9uZCBNeWtsZWJ1c3QgPA0K
PiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gSGkgT2xnYSwNCj4gPiANCj4g
PiBPbiBUaHUsIDIwMjAtMDUtMjggYXQgMTY6NDIgLTA0MDAsIE9sZ2EgS29ybmlldnNrYWlhIHdy
b3RlOg0KPiA+ID4gSGkgZm9sa3MsDQo+ID4gPiANCj4gPiA+IExvb2tpbmcgZm9yIHJlY29tbWVu
ZGF0aW9uIG9uIHdoYXQgdGhlIGNsaWVudCBpcyBzdXBwb3NlIHRvIGJlDQo+ID4gPiBkb2luZw0K
PiA+ID4gaW4gdGhlIGZvbGxvd2luZyBzaXR1YXRpb24uIENsaWVudCBvcGVucyBhIGZpbGUgYW5k
IGhhcyBhIGJ5dGUtDQo+ID4gPiByYW5nZQ0KPiA+ID4gbG9jayB3aGljaCByZXR1cm5lZCBhIGxv
Y2tpbmcgc3RhdGUuIENsaWVudCBpcyBhY3F1aXJpbmcgYW5vdGhlcg0KPiA+ID4gYnl0ZQ0KPiA+
ID4gcmFuZ2UgbG9jay4gSXQgdXNlcyB0aGUgcmV0dXJuZWQgbG9ja2luZyBzdGF0ZWQgZm9yIHRo
ZSAybmQgbG9jay4NCj4gPiA+IFNlcnZlciByZXR1cm5zIEFETUlOX1JFVk9LRUQuDQo+ID4gPiAN
Cj4gPiA+IEN1cnJlbnRseSB0aGUgY2xpZW50IGdvZXMgaW50byBhbiBpbmZpbml0ZSBsb29wIG9m
IGp1c3QgcmVzZW5kaW5nDQo+ID4gPiB0aGUNCj4gPiA+IHNhbWUgTE9DSyBvcGVyYXRpb24gd2l0
aA0KPiA+ID4gdGhlIHNhbWUgbG9ja2luZyBzdGF0ZWlkLg0KPiA+ID4gDQo+ID4gPiBJcyB0aGlz
IGEgcmVjb3ZlcmFibGUgc2l0dWF0aW9uPyBUaGUgZmFjdCB0aGF0IHRoZSBsb2NrIHN0YXRlIHdh
cw0KPiA+ID4gcmV2b2tlZCwgc2hvdWxkIGl0IGJlIGFuIGF1dG9tYXRpYyBFSU8gc2luY2UgcHJl
dmlvdXMgbG9jayBpcw0KPiA+ID4gbG9zdA0KPiA+ID4gKHNvDQo+ID4gPiB3aHkgYm90aGVyIGdv
aW5nIGZvcndhcmQpPyBPciBzaG91bGQgdGhlIGNsaWVudCByZXRyeSB0aGUgbG9jaw0KPiA+ID4g
YnV0DQo+ID4gPiBzZW5kIGl0IHdpdGggdGhlIG9wZW4gc3RhdGVpZD8NCj4gPiA+IA0KPiA+ID4g
VGhhbmsgeW91Lg0KPiA+IA0KPiA+IEkgdGhpbmsgdGhlIHJpZ2h0IGJlaGF2aW91ciBzaG91bGQg
YmUgdG8ganVzdCBjYWxsDQo+ID4gbmZzX2lub2RlX2ZpbmRfc3RhdGVfYW5kX3JlY292ZXIoKS4g
SW4gcHJpbmNpcGxlIHRoYXQgd2lsbCBlbmQgdXANCj4gPiBlaXRoZXIgcmVjb3ZlcmluZyB0aGUg
bG9jayAoaWYgdGhlIHVzZXIgc2V0IHRoZQ0KPiA+IG5mcy5yZWNvdmVyX2xvc3RfbG9ja3MNCj4g
PiBrZXJuZWwgcGFyYW1ldGVyIHRvICd0cnVlJykgb3IgbWFya2luZyBpdCBhcyBhIGxvc3QgbG9j
aywgdXNpbmcNCj4gPiBORlNfTE9DS19MT1NULg0KPiANCj4gV2h5IHNob3VsZCBhY3F1aXJpbmcg
b2YgdGhlIDJuZCBsb2NrIGRlcGVuZCBvbiByZWNvdmVyaW5nIHRoZSBsb2NrDQo+IHdobydzIHN0
YXRlaWQgaXQgd2FzIHRyeWluZyB0byB1c2U/IEkgdGhpbmsgdGhlIDFzdCBzdGF0ZWlkIGlzIGxv
c3QNCj4gdW5yZWNvdmVyYWJsZT8NCg0KQWdyZWVkLiBIb3dldmVyIHRoYXQgbWVhbnMgdGhlIGFw
cGxpY2F0aW9uIG5lZWRzIHRvIGtub3cgdGhhdCBpdCBtYXkNCmhhdmUgY29ycnVwdCBkYXRhIG9u
IGl0cyBoYW5kcy4gV2UgZG8ga25vdyB0aGF0IHRoaXMgaXMgdGhlIHNhbWUNCmFwcGxpY2F0aW9u
IHRoYXQgdG9vayB0aGUgZmlyc3QgbG9jaywgYmVjYXVzZSBhbnkgY2xvc2Ugb2YgdGhlIGZpbGUN
CihpbmNsdWRpbmcgZHVlIHRvIGFwcGxpY2F0aW9uIGNyYXNoZXMpIHdvdWxkIHJlc3VsdCBpbiB0
aGUgbG9ja3MgYmVpbmcNCnJldHVybmVkLg0KDQpTb21lICpOSVggaW1wbGVtZW50YXRpb25zIGhh
dmUgYSBzcGVjaWFsIFNJR0xPU1Qgc2lnbmFsIHRoYXQgdGhlaXIgTkZTDQpjbGllbnRzIGNhbiB1
c2UgdG8gbGV0IHRoZSBhcHBsaWNhdGlvbiBrbm93IGl0cyBzdGF0ZSB3YXMgbG9zdC4gTGludXgN
CnVuZm9ydHVuYXRlbHkgZG9lcyBub3QgaGF2ZSBzdWNoIGEgc2lnbmFsLCBzbyB3ZSBoYXZlIHRv
IHJlbHkgb24gZXJyb3INCmNvZGVzLg0KDQo+IFJpZ2h0IG5vdyB3aGF0IGhhcHBlbnMgaXMgY29k
ZSBpbml0aWF0ZXMgcmVjb3ZlcnkuIG9wZW4gaXMgc2VudC4gQnV0DQo+IHRoZSByZXRyeSBvZiB0
aGUgMm5kIGxvY2sgaGFzIHRoZSBJTklUSUFMSVpFRF9MT0NLIHNldCBhbmQgc28gaXQNCj4gdGFr
ZXMNCj4gdGhlIGJhZCBsb2NrIHN0YXRlaWQgKGhvdyBhYm91dCBpbnN0ZWFkIGxldHRpbmcgaXQg
dXNlIHRoZSByZWNvdmVyZWQNCj4gb3BlbiBzdGF0ZWlkPykuIEhvdyBhYm91dCBpbnN0ZWFkIGRv
IHRoZSBmb2xsb3cuDQoNCk5GU3Y0LjEgcmVxdWlyZXMgdXMgdG8gY2FsbCBGUkVFX1NUQVRFSUQg
b24gYW55IHN0YXRlaWQgdGhhdCBpcw0KcmV2b2tlZCwgaW4gb3JkZXIgdG8gbGV0IHRoZSBzZXJ2
ZXIga25vdyB3aGVuIHdlJ3ZlIGRpc2NvdmVyZWQgdGhhdCB0aGUNCmxvY2sgd2FzIGxvc3QuIFNv
IHdlIGFsc28gaGF2ZSB0byBnbyB0aHJvdWdoIHRoZSByZWNvdmVyeSBtYWNoaW5lcnkgdG8NCmVu
c3VyZSB0aGF0IGhhcHBlbnMgYmVmb3JlIHdlIGNhbiBkZWFsIHdpdGggdGFraW5nIHRoZSBzZWNv
bmQgbG9jay4NCg0KQ2hlZXJzDQogIFRyb25kDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K
