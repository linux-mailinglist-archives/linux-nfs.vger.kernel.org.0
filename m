Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A27C2807BE
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Oct 2020 21:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgJAT3y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 15:29:54 -0400
Received: from mail-bn8nam12on2134.outbound.protection.outlook.com ([40.107.237.134]:6477
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729993AbgJAT3y (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 1 Oct 2020 15:29:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAeHfkYVtnGcZKL6nuQ7zLG3UP0PgfeGqAloI7ixQiihb0s/XBB7mGkKex4QIR5pCShMmNWG4ehbO2hYsKlnCc9KH5kVXit5i9R3GNkUkP146fzJ5m5+BP3mqPDdfz2bIIrlzOHMkr4KoR0MPkhVtAVO/cLECbD4aOga90fUjj9bPWoblC28P6QNZQ0FtBtijx1nlWdl5HPwAmCIkNZ7k2dQ3ilAno5p5DYpv7rDq4aP2uMhwxvT6ZBmLM99kqoJfZqPc52QLWnve7kVMtrNbRYz6sqmuU+MAnHt/qT1VFU3oyEFCknKgJnU1n8r5JM9YW5ooSvjg7pbir9QYSdUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oZ+8Mqa0m0fr5Qnx1JpFkC8RqyrD4RJz+bT0sw1usk=;
 b=biQmVSDG8dvFZsLK23qt/mU0Vqo5GjjxvsAfiC7laO/aWtfpiMOjocxami8R9WAEgr59PiERdzXLCdTxeGGyfrNMwUKpEtnrYG1Kf4weshxG1WvtHvF39zSa4QtaKm8uuJrnpxrJL6zW7erietkrW0ieopdjIpGQR6espWFnu9SEsUcotM70r9dCiHE2rZ0TtU1GXHK1XZIFEM0JBe4x0tiP0W86itU5WeYWYLyQHNoKuhb5tTcbV/IEif4GpVHLk31UKSEU6BzUIMBEH/wvUikb49v9eA+9GHtQ9rYENQx0ve1houbcjr/w+6sSDhoY0o9QF2JsGzT0b57EuPrBDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oZ+8Mqa0m0fr5Qnx1JpFkC8RqyrD4RJz+bT0sw1usk=;
 b=dLO7J/9tUuVnx5wZQIiX5+5D0n9uNoMC6DRZ5u/HFFZ3HlFw5DVOnfTD9j8F080insNrYdC8PM4sYW2lhHQ5VmmSESFCzcYjdY7bnTeiumkQ+SwQHkeuNgVtt/RyCPv+E2Ooc16fu3zKLuxfNRWOcESlakme8VoN7GQjJJtNjQ8=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3373.namprd13.prod.outlook.com (2603:10b6:208:16a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.16; Thu, 1 Oct
 2020 19:29:51 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%6]) with mapi id 15.20.3433.037; Thu, 1 Oct 2020
 19:29:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: [Linux-cachefs] Adventures in NFS re-exporting
Thread-Topic: [Linux-cachefs] Adventures in NFS re-exporting
Thread-Index: fNDm/l4o9cYx5Rz5g0S1EO4zMAtIR1/IOmk+iGKBtwAAMJPuAAABg7oAAAAMOAAAACH6AA==
Date:   Thu, 1 Oct 2020 19:29:51 +0000
Message-ID: <a6294c25cb5eb98193f609a52aa8f4b5d4e81279.camel@hammerspace.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
         <1155061727.42788071.1600777874179.JavaMail.zimbra@dneg.com>
         <97eff1ee2886c14bcd7972b17330f18ceacdef78.camel@kernel.org>
         <20201001184118.GE1496@fieldses.org>
         <1424d45ba1d140bfcff4ae834c70b0a79daa6807.camel@hammerspace.com>
         <20201001192602.GF1496@fieldses.org>
In-Reply-To: <20201001192602.GF1496@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d333458-aea8-4419-e575-08d866405e26
x-ms-traffictypediagnostic: MN2PR13MB3373:
x-microsoft-antispam-prvs: <MN2PR13MB337386D220ED55B6AA98AAAEB8300@MN2PR13MB3373.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CQ0WUh2viJDd0H5+16vMihre1CI1uONXQZZ5ch+WOpDmGzhhiwmV/491nTkAmyYmv2OoveTAoBN/sSuUATqWu4rg3kJLcovz+FEs0hss2x8YyZMcqQT8PMptNNNJ/r2CqTNfaP48dN1LjHBJLqLXwr96TOPSSEATxzadBQQy1k5xMQvcNc1wIsRNN7Nk7/Dbojc+msIWrmtSETC5beR/WUlx546RdecBytrPS75rrEeJw/A5F5UP2iOP9QGzmzAW3TogeY/iovbb9uHIrIBXJu4YU0SGLNrWZ+yYBTUuJCfax3DvyqhkrLpiZfJqkBkmisJvWs0fYBD9QSHjgQZiZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(366004)(39840400004)(66446008)(66556008)(66476007)(64756008)(83380400001)(36756003)(2906002)(66946007)(8676002)(86362001)(91956017)(8936002)(6512007)(76116006)(6916009)(26005)(6486002)(6506007)(186003)(71200400001)(2616005)(478600001)(5660300002)(316002)(4326008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: h3ml7Cfvq2vhZ0J28yn4GF9P0CcBo9PgkTPOf7oo5DbXi5jKwRQIUdzcIQC/x7+q8v3Re3Gem8HwkFUCLVjQMEaBhYHVfY0ePzcd7+AzFYsg7KwJZJWR0PQA3OZWKlC8oFidOehK7jXY3/BzE/1xt4PaqEQzrQKsZdftbkBlz2vTDUChl2EmHAwW6o8kUpj7rm04Txj0q7XH6TBVqBdF2MloQCWT/jbjf4iz66fd8WJmYTbD1f58ld9jIXsdeskPclNKpPdfvzZX2Dsx7KAo2xK5Rvwz9yYB8h74LpDFyoNmadCZjuli9p34W5r2W0wbq8qwiEMChp4setm5NuSl/71h7gbjBjVAzeOsqVCVYuKjNoeqURTZgMwfPtSTiJ0VxWNhsoDwiqe/LEHUGK3NgcSNzp1hCV8JPdIUH+RgJ501WgUlmJtS9nQzezH9OyzNuUPwxJGEGaiga5bhqpvVFq3QSXG1MWSaxOi2JSmIDxCmFUcpFzfbg3txFARZMf2RdYr68nxp7BFNtFimihi/UOfz5CV+z5J3wSR0/iKJIkoQMRvCzUb+o09ErXI5jhncwLLxB1GSSgu3L6RTQSkn4dR3d007d/hR+A4lqx3eKcDbWCfwEJyb4ueECb/84oPTY/2U4E71ahoINLIy+QWVUg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ADE38E92137614485C33ED99D6E56B1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d333458-aea8-4419-e575-08d866405e26
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 19:29:51.5327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9E33MaL7hOCe2ZVzfVUEoLjUN5V+jZPVOEQ83YJBLW3UmcmosuAZ6KkWMEITVyPAPh0IYl2FgvQGT0ehAVNAuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3373
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTEwLTAxIGF0IDE1OjI2IC0wNDAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gVGh1LCBPY3QgMDEsIDIwMjAgYXQgMDc6MjQ6NDJQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMC0xMC0wMSBhdCAxNDo0MSAtMDQwMCwg
Si4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMDM6
MzA6MjJQTSAtMDQwMCwgSmVmZiBMYXl0b24gd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgMjAyMC0w
OS0yMiBhdCAxMzozMSArMDEwMCwgRGFpcmUgQnlybmUgd3JvdGU6DQo+ID4gPiA+ID4gVGhpcyBw
YXRjaCBoZWxwcyB0byBhdm9pZCB0aGlzIHdoZW4gYXBwbGllZCB0byB0aGUgcmUtZXhwb3J0DQo+
ID4gPiA+ID4gc2VydmVyIGJ1dCB0aGVyZSBtYXkgYmUgb3RoZXIgcGxhY2VzIHdoZXJlIHRoaXMg
aGFwcGVucyB0b28uDQo+ID4gPiA+ID4gSQ0KPiA+ID4gPiA+IGFjY2VwdCB0aGF0IHRoaXMgcGF0
Y2ggaXMgcHJvYmFibHkgbm90IHRoZSByaWdodC9nZW5lcmFsIHdheQ0KPiA+ID4gPiA+IHRvDQo+
ID4gPiA+ID4gZG8gdGhpcywgYnV0IGl0IGhlbHBzIHRvIGhpZ2hsaWdodCB0aGUgaXNzdWUgd2hl
biByZS0NCj4gPiA+ID4gPiBleHBvcnRpbmcNCj4gPiA+ID4gPiBhbmQgaXQgd29ya3Mgd2VsbCBm
b3Igb3VyIHVzZSBjYXNlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IC0tLSBsaW51eC01LjUuMC0x
LmVsNy54ODZfNjQvZnMvbmZzL2lub2RlLmMgICAgIDIwMjAtMDEtMjcNCj4gPiA+ID4gPiAwMDoy
MzowMy4wMDAwMDAwMDAgKzAwMDANCj4gPiA+ID4gPiArKysgbmV3L2ZzL25mcy9pbm9kZS5jICAy
MDIwLTAyLTEzIDE2OjMyOjA5LjAxMzA1NTA3NCArMDAwMA0KPiA+ID4gPiA+IEBAIC0xODY5LDcg
KzE4NjksNyBAQA0KPiA+ID4gPiA+ICANCj4gPiA+ID4gPiAgICAgICAgIC8qIE1vcmUgY2FjaGUg
Y29uc2lzdGVuY3kgY2hlY2tzICovDQo+ID4gPiA+ID4gICAgICAgICBpZiAoZmF0dHItPnZhbGlk
ICYgTkZTX0FUVFJfRkFUVFJfQ0hBTkdFKSB7DQo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgIGlm
ICghaW5vZGVfZXFfaXZlcnNpb25fcmF3KGlub2RlLCBmYXR0ci0NCj4gPiA+ID4gPiA+IGNoYW5n
ZV9hdHRyKSkgew0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBpZiAoaW5vZGVfcGVla19pdmVy
c2lvbl9yYXcoaW5vZGUpIDwgZmF0dHItDQo+ID4gPiA+ID4gPiBjaGFuZ2VfYXR0cikgew0KPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIENvdWxkIGl0IGJlIGEgcmFjZSB3aXRo
IHdyaXRlYmFjaz8NCj4gPiA+ID4gPiAqLw0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmICghKGhhdmVfd3JpdGVycyB8fA0KPiA+ID4gPiA+IGhhdmVfZGVsZWdhdGlvbikpIHsN
Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludmFsaWQgfD0NCj4g
PiA+ID4gPiBORlNfSU5PX0lOVkFMSURfREFUQQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdpdGgg
dGhpcyBwYXRjaCwgdGhlIHJlLWV4cG9ydCBzZXJ2ZXIncyBORlMgY2xpZW50IGF0dHJpYnV0ZQ0K
PiA+ID4gPiA+IGNhY2hlIGlzIG1haW50YWluZWQgYW5kIHVzZWQgYnkgYWxsIHRoZSBjbGllbnRz
IHRoYXQgdGhlbg0KPiA+ID4gPiA+IG1vdW50DQo+ID4gPiA+ID4gaXQuIFdoZW4gbWFueSBodW5k
cmVkcyBvZiBjbGllbnRzIGFyZSBhbGwgZG9pbmcgc2ltaWxhcg0KPiA+ID4gPiA+IHRoaW5ncyBh
dA0KPiA+ID4gPiA+IHRoZSBzYW1lIHRpbWUsIHRoZSByZS1leHBvcnQgc2VydmVyJ3MgTkZTIGNs
aWVudCBjYWNoZSBpcw0KPiA+ID4gPiA+IGludmFsdWFibGUgaW4gYWNjZWxlcmF0aW5nIHRoZSBs
b29rdXBzIChnZXRhdHRycykuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gUGVyaGFwcyBhIG1vcmUg
Y29ycmVjdCBhcHByb2FjaCB3b3VsZCBiZSB0byBkZXRlY3Qgd2hlbiBpdCBpcw0KPiA+ID4gPiA+
IGtuZnNkIHRoYXQgaXMgYWNjZXNzaW5nIHRoZSBjbGllbnQgbW91bnQgYW5kIGNoYW5nZSB0aGUg
Y2FjaGUNCj4gPiA+ID4gPiBjb25zaXN0ZW5jeSBjaGVja3MgYWNjb3JkaW5nbHk/IA0KPiA+ID4g
PiANCj4gPiA+ID4gWWVhaCwgSSBkb24ndCB0aGluayB5b3UgY2FuIGRvIHRoaXMgZm9yIHRoZSBy
ZWFzb25zIFRyb25kDQo+ID4gPiA+IG91dGxpbmVkLg0KPiA+ID4gDQo+ID4gPiBJJ20gbm90IGNs
ZWFyIHdoZXRoZXIgVHJvbmQgdGhvdWdodCB0aGF0IGtuZnNkJ3MgYmVoYXZpb3IgaW4gdGhlDQo+
ID4gPiBjYXNlDQo+ID4gPiBpdA0KPiA+ID4gcmV0dXJucyBORlM0X0NIQU5HRV9UWVBFX0lTX01P
Tk9UT05JQ19JTkNSIG1pZ2h0IGJlIGdvb2QgZW5vdWdoDQo+ID4gPiB0bw0KPiA+ID4gYWxsb3cN
Cj4gPiA+IHRoaXMgb3Igc29tZSBvdGhlciBvcHRpbWl6YXRpb24uDQo+ID4gPiANCj4gPiANCj4g
PiBORlM0X0NIQU5HRV9UWVBFX0lTX01PTk9UT05JQ19JTkNSIHNob3VsZCBub3JtYWxseSBiZSBn
b29kIGVub3VnaA0KPiA+IHRvDQo+ID4gYWxsb3cgdGhlIGFib3ZlIG9wdGltaXNhdGlvbiwgeWVz
LiBJJ20gbGVzcyBzdXJlIGFib3V0IHdoZXRoZXIgb3INCj4gPiBub3QNCj4gPiB3ZSBhcmUgY29y
cmVjdCBpbiByZXR1cm5pbmcgTkZTNF9DSEFOR0VfVFlQRV9JU19NT05PVE9OSUNfSU5DUiB3aGVu
DQo+ID4gaW4NCj4gPiBmYWN0IHdlIGFyZSBhZGRpbmcgdGhlIGN0aW1lIGFuZCBmaWxlc3lzdGVt
LXNwZWNpZmljIGNoYW5nZQ0KPiA+IGF0dHJpYnV0ZSwNCj4gPiBidXQgd2UgY291bGQgZml4IHRo
YXQgdG9vLg0KPiANCj4gQ291bGQgeW91IGV4cGxhaW4geW91ciBjb25jZXJuPw0KPiANCg0KU2Ft
ZSBhcyBiZWZvcmU6IHRoYXQgdGhlIGN0aW1lIGNvdWxkIGNhdXNlIHRoZSB2YWx1ZSB0byByZWdy
ZXNzIGlmDQpzb21lb25lIG1lc3NlcyB3aXRoIHRoZSBzeXN0ZW0gdGltZSBvbiB0aGUgc2VydmVy
LiBZZXMsIHdlIGRvIGFkZCBpbg0KdGhlIGNoYW5nZSBhdHRyaWJ1dGUsIGJ1dCB0aGUgdmFsdWUg
b2YgY3RpbWUudHZfc2VjIGRvbWluYXRlcyBieSBhDQpmYWN0b3IgMl4zMC4NCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
