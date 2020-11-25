Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D160F2C35B1
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 01:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgKYAgp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 19:36:45 -0500
Received: from mail-mw2nam10on2102.outbound.protection.outlook.com ([40.107.94.102]:41057
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbgKYAgo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Nov 2020 19:36:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRj6vW/RLer1H9bpvmrveVjFiz+EHSP/IbMdQfkrPuALSc8YAhfkR2zd3nZifK8Ze0UFwzsyLK7wb+5Jg+4JghLofPP4ebTiLNyLHV4cgPT1/INDuua9DuGrvxDooqEqcE2dR7EUGwZD+KIUvKbELl7NjXGwPyoJT0yOxVzG6n/y2xq7aQCT4IuPXnAPJJ5U9IXx8WRBndZGmw0zlQAqOhXT+xpl4c+gTs/drkch1wSjGDCr5HFEpW/w5EboocYtCWgxbeGpVurJKs6epRSkWh9HYR+FFUx9XRxW7IHECze9lO+LS+ZkVro1MLDtzMGF+LjFAWdpbo5NALXsuaaRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbqUC2gXEe5LM/kU1IKVXG+uNwekNVY70X1SHH4UZ2k=;
 b=FY0Axa0INFdAVbEA1mYKxFv+36eDvg9oVx2biTOuoF/ypFkC112Ux45gt2ktfovz+SqB34uDpciuJE7ejz891R+nnnztpdNBum56O9Vx3KqlpaOw1cZ9SjU6QLGOqn2Cgd7Tz8bOQnKsffusMpkm0n8a2G3JX5Uqyz6VDl8O3TEm55fMJLDbZouPkwUQ++sfzS9vhLR12iKpDlEXOe7HQqQd410BSxS3M7zq1PJomAGKgTftFEo6/ldhU+d5BbO/dJDFA/2HQQ70DwYMG0G/5CicwrDPv2II82mdt3sSmqmq2fqMcVZiPFtlKy1JejZLe0oEfQYem0P/KRi/Zbvlkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbqUC2gXEe5LM/kU1IKVXG+uNwekNVY70X1SHH4UZ2k=;
 b=S5WPgVZgkLtrEPAxQ8KpwKzTGjPIflhp2Z9UqDUcftAf0zFGpCLtoWih6r57JurFGLT3ffSo4ZzhqrC9TDCT/0nqzK+fDBTbb1LLzn9c+KG7Sff2gF8hgOCpTvC4amySSrY/3NNMmcTtPNnazXt5KqTEezCwT45lTBBUQkEhiAU=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by BL0PR13MB4419.namprd13.prod.outlook.com (2603:10b6:208:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.13; Wed, 25 Nov
 2020 00:36:42 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3611.020; Wed, 25 Nov 2020
 00:36:42 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] Fix various issues in the SUNRPC xdr code
Thread-Topic: [PATCH v2 0/9] Fix various issues in the SUNRPC xdr code
Thread-Index: AQHWwmjfwELMdH++00y7mVYsFk0+kqnXdH0AgAABfYCAAEVeAIAAReoA
Date:   Wed, 25 Nov 2020 00:36:42 +0000
Message-ID: <245cbfff1a71061299d82afd216b355477919e59.camel@hammerspace.com>
References: <20201124135025.1097571-1-trondmy@kernel.org>
         <20201124161250.GA1091@fieldses.org> <20201124161809.GB1091@fieldses.org>
         <20201124202626.GA7173@fieldses.org>
In-Reply-To: <20201124202626.GA7173@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0562eeb-876b-4784-1c49-08d890da2e14
x-ms-traffictypediagnostic: BL0PR13MB4419:
x-microsoft-antispam-prvs: <BL0PR13MB441964E9EAFEA18E54626A83B8FA0@BL0PR13MB4419.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W1wzPtW3UkfMLo6Et4K3b0SiI21ZJJ0YbU8D7dLHdBqkduXxWzyzmluWhqb7S8zuIJ02aVitiRADFnvofh501jtzaPg4mHgPKU4duhEUNaPcm73B+YWaweWtOcf4cuhLs0p5I+m6YxGlEYcwxNX14sfO6su9dO3NpI5CF+LlTh8scMMQePUapyjM911LMocoMN9gptiw9EFJQf7wCXxlmPWWNZlqjP2ZUJQo+bnz2ZdjpDTBbtGIgdcNrG0gaPnHRYRtvJ/zi3+Z2BtMZBb1IPF/QUFIv4etbIhcSTWvWQDfc67X+c33eCg0xFWnuoP/K8RVSQ8isRslRg7ixOSJxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(136003)(346002)(396003)(376002)(366004)(5660300002)(2906002)(66476007)(6916009)(76116006)(91956017)(2616005)(478600001)(6486002)(66946007)(4001150100001)(66446008)(64756008)(66556008)(6506007)(8676002)(83380400001)(6512007)(86362001)(316002)(26005)(36756003)(186003)(71200400001)(4326008)(54906003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: v3Wri5rgUACX1kE7KGPdPiYdx3PWFM7tIA5dqwv9LScdhR5p+G1lPT/Sf7/LjPT4xOk5i6UWhuRomkgO0Wa6APeSclLpg2rFgYUqPPMjFu/Gm+Ic/9dN7J2ovc0oVMj1fyw9Ke5LsUp8Wu4b5XCZTQRvCk8iSw4H+qW605fZ2DpkfPN5XA+WimN2uozV7xh2BWClYKIK8P/838lC8acKfzMmChclYRf2VmDNggQWTsx09FS9v5tjL19uVzt35KBZZqN7O4WEvKRMqABBjTmB3FxNxVVrap2PoPFFzNAiGW1GZimkZ0GK7j1LGs9tn5GUIyuwGxqDACymzGGy1KnkA55uWZVOJisJcIskar404FC5Zd14w24Cnq8ARnkoTGfOWeCMbb4w8YRBbQNdq/xBZRqnUowWPfClgUrJlvGCqSUgwDBbUEWguJJk3/u8lwcLYjKRn+8f3xJdjlCxLGX6bj36J7LyfZ6KCQb1CfI9bpQP6q/RZM7gIUQyK14haFHDM2mfS+GDAxVBUDymADeMnHBWSw9nQZa7nXiJOHu5N6DXHmuAf+hsCvAh8tE8K3xa9smfUrsHgSmnVZuCA0yEXTfiBNBJtm8Q6r6LXzMXgbQ5Nh+1Pt/Z0aKsTNxEn7Xz3MN0/4rgW+b0DJSWamaP/V6QNm/ZcVvkWDxinq5LqzkiojTrguFPOmunsxbyMOz3gCyZ/rEmMR3JkiHRZOX9H6TINxXCweHxqONr8/2jI6zFwsWKgSHtt+WHKGeUXCahJG3wrIjgsM3D9Pk3KFHvKx2BetQ7G8FSAZi3gTFSy/vZ6uSIlmMzQfs3tOsTczUHfGPt3qm4s7K7eIRgSFWA3A7C4zhpSB81SNN7UaskKpwPm5AtAMZZLesC7RUcxHqoq51Umayn4uuQ/2NnqDp42Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <29FC4C74382C9E4EB38DBCF09E29314F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0562eeb-876b-4784-1c49-08d890da2e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 00:36:42.1632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+B2FcngUu6dFxWk1Yw3v9ZiZlhRTn+C4o1R+ElOoYcxPV6HThap55cnyjT1QDTesjoF7NkHuCH3JgYD8r84zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4419
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTI0IGF0IDE1OjI2IC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFR1ZSwgTm92IDI0LCAyMDIwIGF0IDExOjE4OjA5QU0gLTA1MDAsIEouIEJydWNlIEZp
ZWxkcyB3cm90ZToNCj4gPiBPbiBUdWUsIE5vdiAyNCwgMjAyMCBhdCAxMToxMjo1MEFNIC0wNTAw
LCBiZmllbGRzIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMDg6NTA6MTZB
TSAtMDUwMCwNCj4gPiA+IHRyb25kbXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gPiA+IEZyb206
IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+
ID4gDQo+ID4gPiA+IFdoZW4gbG9va2luZyBhdCB0aGUgaXNzdWVzIHJhaXNlZCBieSBUaWdyYW4n
cyB0ZXN0aW5nIG9mIHRoZQ0KPiA+ID4gPiBORlMgY2xpZW50DQo+ID4gPiA+IHVwZGF0ZXMsIEkg
bm90aWNlZCBhIGNvdXBsZSBvZiB0aGluZ3MgaW4gdGhlIGdlbmVyaWMgU1VOUlBDIHhkcg0KPiA+
ID4gPiBjb2RlDQo+ID4gPiA+IHRoYXQgd2FudCB0byBiZSBmaXhlZC4gVGhpcyBwYXRjaCBzZXJp
ZXMgcmVwbGFjZXMgYW4gZWFybGllcg0KPiA+ID4gPiBzZXJpZXMgdGhhdA0KPiA+ID4gPiBhdHRl
bXB0ZWQgdG8ganVzdCBmaXggdGhlIFhEUiBwYWRkaW5nIGluIHRoZSBORlMgY29kZS4NCj4gPiA+
ID4gDQo+ID4gPiA+IFRoaXMgc2VyaWVzIGZpeGVzIHVwIGEgbnVtYmVyIG9mIGlzc3VlcyB3LnIu
dC4gYm91bmRzIGNoZWNraW5nDQo+ID4gPiA+IGluIHRoZQ0KPiA+ID4gPiB4ZHJfc3RyZWFtIGNv
ZGUuIEl0IGNvcnJlY3RzIHRoZSBiZWhhdmlvdXIgb2YgeGRyX3JlYWRfcGFnZXMoKQ0KPiA+ID4g
PiBmb3IgdGhlDQo+ID4gPiA+IGNhc2Ugd2hlcmUgdGhlIFhEUiBvYmplY3Qgc2l6ZSBpcyBsYXJn
ZXIgdGhhbiB0aGUgYnVmZmVyIHBhZ2UNCj4gPiA+ID4gYXJyYXkNCj4gPiA+ID4gbGVuZ3RoIGFu
ZCBzaW1wbGlmaWVzIHRoZSBjb2RlLg0KPiA+ID4gDQo+ID4gPiBJJ20gc2VlaW5nIHRoaXMgb24g
dGhlIGNsaWVudCB3aXRoIHJlY2VudCB1cHN0cmVhbSArIHRoZXNlDQo+ID4gPiBwYXRjaGVzLg0K
PiA+IA0KPiA+IFVuZm9ydHVuYXRlbHkgdGhhdCB3YXMgaW4gdGhlIG1pZGRsZSBvZiBhIHNlcmll
cyBvZiB0ZXN0cywgYW5kIEknbQ0KPiA+IG5vdA0KPiA+IHN1cmUgZXhhY3RseSB3aGF0IHRyaWdn
ZXJlZCBpdC0tSSdtIGd1ZXNzaW5nIGN0aG9uIHNwZWNpYWwgb3Zlcg0KPiA+IGtyYjVpLg0KPiA+
IEknbGwgbGV0IHlvdSBrbm93IHdoYXQgZWxzZSBJIGNhbiBmaWd1cmUgb3V0Lg0KPiANCj4gWWVh
aCwgcmVwcm9kdWNlYWJsZSBieSBydW5uaW5nIGN0aG9uIC1zIG92ZXIga3JiNWksIGFuZCBpdCBm
aXJzdA0KPiBzaG93cw0KPiB1cCB3aXRoIHRoZSBsYXN0IHBhdGNoLCAiTkZTdjQuMjogRml4IHVw
IHJlYWRfcGx1cygpIHBhZ2UgYWxpZ25tZW50Ii4NCg0KT0ssIHRoYW5rcyEgSSdsbCBqdXN0IGRy
b3AgdGhhdCBvbmUgdGhlbi4gSSBkb24ndCB0aGluayBpdCByZWFsbHkNCnN1ZmZpY2VzIHRvIGZp
eCBSRUFEX1BMVVMgYXMgaXQgc3RhbmRzLg0KDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K
