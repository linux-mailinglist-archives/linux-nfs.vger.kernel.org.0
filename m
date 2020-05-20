Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AAE1DBC6F
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2020 20:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgETSOT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 May 2020 14:14:19 -0400
Received: from mail-eopbgr760119.outbound.protection.outlook.com ([40.107.76.119]:33218
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726560AbgETSOS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 20 May 2020 14:14:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4zZEkgZO58Pzp9mX9RyaB/PYTOXMIPjHcf0pdVect6SfTRm5iBvQIpA5QkCUDQthYp4IUj8jfnyGIFQdeCxblPNEeCqH9vdoADZn6SvX8HPdTn7BYLXiK9m15HvhKvgTmiOFKIQP+mfpdB2DOKMaNJKpaX9qK8OQtTvJWd5SrMgXzdb/26Cooq77FnvZ/YyD05fx2rqkAUMhnf5h8J/1NvBIk0CGHXyJ29DMWquYBA+B443ZLb1e4eq59lc6AEOZNcgCSLxFDFMmI5ZFx0eWcnyergDqb6VQXNlXHTSrBWIRBAT7oVn6COIEzTNXtsqICzjzJGTSyjZqhi6tzJj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlwtleXWcn8kwPucTaukom6OJRjyPHSQLh9aB93l4WY=;
 b=SR+2gMxe6eh+HUTrCw8HFO1UzCCOcVMdac8EmFKxEBTL32lCo0awQ2UXiKmE3wto8FvbLL7U7EVBshkQU4ZcxR8KPJqlNVXA2GyzJT30ZACZV0r+LSg1SPoPsxbOY3IVWp80InWLsJsjXau1o05/IZXuMFHAGWHAfH91PYRIAeDOX7NP77DNrAEL0xteqoDb9Q6+RKpBXyIMDyYDPOnq/1SOEFt/Sq53jFL1p3GBPAAv4tnVpOZXCCNYypaK/SayKrwGwM6rhU02sP+QK5tD8zNdCOoLpuRNUUk7wkD2kbg93qvYZdK9C7ezSjXIinz51yboHI4Xy0bsxnSysKoNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlwtleXWcn8kwPucTaukom6OJRjyPHSQLh9aB93l4WY=;
 b=P4aaN0apBr6dJaZKveWcHHsAJ6chpCt2rqtXYG3mp4OdyQQdhoS1LaUu6XTlaQ2Ot5owTy35sGkl9XhO1UF67k4gC9uGkJPhmwFVaTzun0HQldk06TWofFLlyIHs7KatPK9/NWeToN8nQZmgbX2+XMfAEhgG0mrwqBVsYEm/qIU=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3672.namprd13.prod.outlook.com (2603:10b6:610:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.13; Wed, 20 May
 2020 18:14:16 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.3021.013; Wed, 20 May 2020
 18:14:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "richard.purdie@linuxfoundation.org" 
        <richard.purdie@linuxfoundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "mhalstead@linuxfoundation.org" <mhalstead@linuxfoundation.org>
Subject: Re: TEST_STATEID issues with NFS4.1 and FreeNAS server
Thread-Topic: TEST_STATEID issues with NFS4.1 and FreeNAS server
Thread-Index: AQHWLs6+hWCi0hkMMkOtApoBqM31paixQ6WAgAABYgCAAAJKAA==
Date:   Wed, 20 May 2020 18:14:16 +0000
Message-ID: <39a42b1e67ae8372ca8ad09c8710d425f823a422.camel@hammerspace.com>
References: <09ad6e031e64820f2efd7495d7467e2bb8b51fc5.camel@linuxfoundation.org>
         <6e7c1125fb5533d1fad5d8b9130761df0fdf3516.camel@hammerspace.com>
         <34c2810e78b6053b23f4d40c981d5609977e262d.camel@linuxfoundation.org>
In-Reply-To: <34c2810e78b6053b23f4d40c981d5609977e262d.camel@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad418065-9d3e-4a93-1035-08d7fce99bc9
x-ms-traffictypediagnostic: CH2PR13MB3672:
x-microsoft-antispam-prvs: <CH2PR13MB3672528CE449AA5E0A4CE092B8B60@CH2PR13MB3672.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RwcRNHZhrmAiLfNPM0lRNiXtWhnZRg6jl8um1L6AGac3/UNI0l1kGdcLR5pAus60U39mEzTseMaepmLELI0B9ahkwR/1GSB0PyYNtkC4l5EqtVAsbbjRnficrRjsCCnsrDh+zEDWk9kkX5B9AcAFwf2MgUZ8YPmcI56n2pKPCJV7ON4S0y26O7sW5KB6vHB4j1NsjN5iLZESLZmfYR5k4+jWMbX/9zYUppCq/vbmZuWPolQO/WbOg0CZzpmar1S5DFrq1e5FitSyzplrT2bfITp89NBn3KulXoBSOj1h5XaKb7Bta38ATDGnNB4iqdRrxpn9yEY24YM15oZMS3LyQMeinKPa+b11wXGlPzExDBOPomCCFehnqDAmTBPRUxjcXS4vQ73/3FpOqyQVHdhwdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(346002)(39830400003)(366004)(376002)(2616005)(71200400001)(66446008)(76116006)(86362001)(66476007)(66556008)(66946007)(64756008)(6512007)(966005)(186003)(478600001)(2906002)(6486002)(36756003)(5660300002)(110136005)(8676002)(6506007)(26005)(316002)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JypaVrUe6iAi/Bm2RQMWbtwZ08PVVrwbOuC+THq0tolG8M+rUf1gchNft1BNHy5JQYC74sOR/EB4LzBfgNrc0P6cK97XoKZfAEFL0ZUXiH3I9mOe9eRzsDQzZ1vOFNsWv8LhTCxRY4Y0+8xEA4Cl4oFW19tKMhq6Gk0g6wRwBtBvwPjmCmNQWLkykn4SeDg7jNhWDhJ7tBn1AYeXsXgWbRYQCl2hvpReQFYfmWDyysSiGgwDoQOW6dCuJW2v7qWTkVWTujUgjeJIgzmFTFERiz7dD+VpasuNE0kiNwBlAHYHBJ9WnxYi0vlXwxrXx1xV77eXav87r608oVtN6XTIL285FrmPF4GpyEGLLEM8DyUsrE4tc4yUKvPinurWZaL+Vw9j1Jx+OioIgK5ev3Rbozzf2yjKPU2Zmu2IRKThnd1DH6MoXeP/cyB846SP6V1yKxDKe5yFUJ7Qs37NJRG6Itutff/H1sx7SFEQ0R267B0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <93B071F3718D124393E20EC40D53557F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad418065-9d3e-4a93-1035-08d7fce99bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 18:14:16.6110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTIQ2LMbhDacCDDb0qQ1xc86AgrVrGF9QfNn+dv99RDUhqzHAmwuiG8KwY7qC8s3GrFsC5A41j1xQ7xIw2MXtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3672
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTIwIGF0IDE5OjA2ICswMTAwLCBSaWNoYXJkIFB1cmRpZSB3cm90ZToN
Cj4gT24gV2VkLCAyMDIwLTA1LTIwIGF0IDE4OjAxICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3Jv
dGU6DQo+ID4gSGkgUmljaGFyZCwNCj4gPiANCj4gPiBPbiBXZWQsIDIwMjAtMDUtMjAgYXQgMTg6
NDcgKzAxMDAsIFJpY2hhcmQgUHVyZGllIHdyb3RlOg0KPiA+ID4gSGksDQo+ID4gPiANCj4gPiA+
IFdlIGhhdmUgYSBjbHVzdGVyIG9mIG1hY2hpbmVzIHdoZXJlIHdlJ3JlIG9ic2VydmluZyBmaWxl
IGFjY2Vzc2VzDQo+ID4gPiBoYW5naW5nIG92ZXIgTkZTLiBUaGUgY2xpZW50cyBzaG93aW5nIHRo
ZSBwcm9ibGVtcyBhcmUgRmVkb3JhIGFuZA0KPiA+ID4gU1VTRQ0KPiA+ID4gZGlzdHJvcyB3aXRo
IHRoZSA1LjYuMTEga2VybmVsLCBlLmcuOg0KPiA+ID4gDQo+ID4gPiBMaW51eCB2ZXJzaW9uIDUu
Ni4xMS0xLWRlZmF1bHQgKGdlZWtvQGJ1aWxkaG9zdCkgKGdjYyB2ZXJzaW9uDQo+ID4gPiA5LjMu
MQ0KPiA+ID4gMjAyMDA0MDYgDQo+ID4gPiBbcmV2aXNpb24gNmRiODM3YTUyODhlZTNjYTVlYzUw
NGZiZDVhNzY1ODE3ZTU1NmFjMl0gKFNVU0UNCj4gPiA+IExpbnV4KSkgDQo+ID4gPiAjMSBTTVAg
V2VkIE1heSA2IDEwOjQyOjA5IFVUQyAyMDIwICg5MWMwMjRhKQ0KPiA+ID4gDQo+ID4gPiBJbiB0
aGUgZXhhbXBsZSBiZWxvdyB3ZSBzZWUgYSBnaXQgY2xvbmUgaGFuZywgaXRzIGhhdmluZyB0cm91
YmxlDQo+ID4gPiByZWFkaW5nIGEgLnBhY2sgZmlsZSBvZmYgdGhlIE5GUyBzaGFyZSwgdGhlIGdp
dCBwcm9jZXNzIGlzIGluIEQNCj4gPiA+IHN0YXRlLg0KPiA+ID4gSSd2ZSBpbmNsdWRlZCBwYXJ0
IG9mIGRtZXNnIGJlbG93IHdpdGggc3lzcnEtdyBvdXRwdXQuDQo+ID4gPiANCj4gPiA+IE1vdW50
IG9wdGlvbnM6DQo+ID4gPiANCj4gPiA+IHJ3LHJlbGF0aW1lLHZlcnM9NC4xLHJzaXplPTEzMTA3
Mix3c2l6ZT0xMzEwNzIsbmFtbGVuPTI1NSxoYXJkLHByDQo+ID4gPiBvdG89DQo+ID4gPiB0Y3As
dGltZW89NjAwLHJldHJhbnM9MixzZWM9c3lzLGxvY2FsX2xvY2s9bm9uZQ0KPiA+ID4gDQo+ID4g
PiBtb3VudHN0YXRzIHNob3dzOg0KPiA+ID4gIA0KPiA+ID4gUkVBRDoNCj4gPiA+IAk2MzIwMTQy
NjMgb3BzICg2MiUpIAk2Mjk4MDkxMDggZXJyb3JzICg5OSUpIA0KPiA+ID4gVEVTVF9TVEFURUlE
Og0KPiA+ID4gIAkzNjMyNTcwNzggb3BzICgzNiUpIAkzNjMyNTcwNzggZXJyb3JzICgxMDAlKQ0K
PiA+ID4gDQo+ID4gPiB3aGljaCBpcyBhIGNsdWUgb24gd2hhdCBpcyBoYXBwZW5pbmcuIEkgZ3Jh
YmJlZCBzb21lIGRhdGEgd2l0aA0KPiA+ID4gdGNwZHVtcA0KPiA+ID4gYW5kIGl0IHNob3dzIHRo
ZSBSRUFEIGdldHRpbmcgTkZTNEVSUl9CQURfU1RBVEVJRCwgdGhlcmUgaXMgdGhlbg0KPiA+ID4g
YQ0KPiA+ID4gVEVTVF9TVEFURUlEIHdoaWNoIGdldHMgTkZTNEVSUl9OT1RTVVBQLiBUaGlzIHJl
cGVhdHMgaW5maW5pdGVseQ0KPiA+ID4gaW4gYQ0KPiA+ID4gbG9vcC4NCj4gPiA+IA0KPiA+ID4g
VGhlIHNlcnZlciBpcyBGcmVlTkFTMTEuMyB3aGljaCBkb2VzIG5vdCBoYXZlOg0KPiA+ID4gaHR0
cHM6Ly9naXRodWIuY29tL0hhcmRlbmVkQlNEL2hhcmRlbmVkQlNELXN0YWJsZS9jb21taXQvNjNm
NmYxOWIwNzU2YjE4ZjJlNjhkODJjYmUwMzdmMjFmOWE4YzUwMA0KPiA+ID4gYXBwbGllZCBzbyBp
dCB3aWxsIHJldHVybiBORlM0RVJSX05PVFNVUFAgdG8gVEVTVF9TVEFURUlELg0KPiA+ID4gDQo+
ID4gPiBJIHRoaW5rIHNvbWV0aGluZyBtYXkgYmUgbmVlZGVkIHRvIHN0b3AgTGludXggZ2V0dGlu
ZyBpbnRvIGFuDQo+ID4gPiBpbmZpbml0ZQ0KPiA+ID4gbG9vcCB3aXRoIHRoaXMsIHJlZ2FyZGxl
c3Mgb2Ygd2hldGhlciB0aGUgc3BlYyBzYXlzIFRFU1RfU1RBVEVJRA0KPiA+ID4gY2FuDQo+ID4g
PiBnZXQgYSBORlM0RVJSX05PVFNVUFAgb3Igbm90Pw0KPiA+ID4gDQo+ID4gPiBJIGZyZWVseSBh
ZG1pdCBJIGtub3cgbGl0dGxlIGFib3V0IG11Y2ggb2YgdGhpcyBzbyBJJ20gb3BlbiB0bw0KPiA+
ID4gcG9pbnRlcnMuIElmIHdlIGRpZCByZW1vdW50IGFzIDQuMCB3ZSBwcm9iYWJseSB3b3VsZG4n
dCBzZWUgdGhlDQo+ID4gPiBpc3N1ZQ0KPiA+ID4gYXMgaXQgd291bGQgYXZvaWQgdGhlIFRFU1Rf
U1RBVEVJRCBjb2RlLg0KPiA+IA0KPiA+IFRFU1RfU1RBVEVJRCBpcyBsaXN0ZWQgaW4gUkZDNTY2
MSBTZWN0aW9uIDE3IGFzIFJFUVVJUkVEIHRvDQo+ID4gaW1wbGVtZW50DQo+ID4gZm9yIE5GU3Y0
LjEuIFdlIHdpbGwgbm90IGJlIGFibGUgdG8gc3VwcG9ydCBhIHNlcnZlciB0aGF0IHZpb2xhdGVz
DQo+ID4gdGhhdA0KPiA+IHJlcXVpcmVtZW50Lg0KPiANCj4gVW5kZXJzdG9vZCwgSSBzdXNwZWN0
ZWQgYXMgbXVjaC4NCj4gDQo+IExvY2tpbmcgc3lzdGVtcyBpbnRvIGFuIGluZmluaXRlIGxvb3Ag
ZG9lc24ndCBzZWVtIGxpa2UgYSBnb29kIHVzZXINCj4gZXhwZXJpZW5jZSB0aG91Z2guIElzIHRo
ZXJlIGEgd2F5IHRvIGhhbmRsZSB0aGF0IG1vcmUgZ3JhY2VmdWxseT8NCj4gDQoNCkFzIEkgaW1w
bGllZCBhYm92ZSwgdGhpcyBpcyBhICdzZXJ2ZXIgZnJvbSBoZWxsJyBzY2VuYXJpbyB0aGF0IHdl
DQpyZWFsbHkgY2FuJ3QgYmUgZXhwZWN0ZWQgdG8gc3VwcG9ydCBhdCBhbGwuIEkgc3VnZ2VzdCBk
b3duZ3JhZGluZyB0bw0KTkZTdjQuMCB1bnRpbCB5b3UgY2FuIGdldCBhIGZpeCBmb3IgdGhlIHNl
cnZlci4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
