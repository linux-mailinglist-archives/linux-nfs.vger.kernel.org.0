Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3B7140DB1
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 16:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAQPRb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 10:17:31 -0500
Received: from mail-dm6nam11on2128.outbound.protection.outlook.com ([40.107.223.128]:7649
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728739AbgAQPRb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 Jan 2020 10:17:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcfeAfNjR5Nb0zjVpQEFo1GwVso90WW+CXivcmMI3/FruBxpnwiLw9+sBLcYEKdWxzZk07IiG4K3WFcjvUMhUzeb/VnMfvzya4gK0VvTB0UMRJrQo0vIA5KZwu1cK40QHIweSKobBK0nHS8Dz6IpcSlnbO92zKX00R5em/KRyV2727UoahYs1W3VlSNaTZF5PoMG/fFia5HEUqU9sGNDAcx237X9I0ac2Hrl0Xvp/8zBme4JCCytRnwl36vUvZUFoSRVQ5J3G2yXbMUY1sZ+yhUKC27oLXTkePzIKOFW9yLIB0/Roa1B25D3HBkSlAZrJ7LrIYcuhwL8wvkWS4sJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPEESz0h4GAJfXfw6KBxyuiW4NE561uUlacL3M6Ieow=;
 b=EpS2tHSNRflg0Bft97nYz+cvuAY35bwjGwbvBAHX67UmfGAcd1oOaAEmmVOvo5p9P8aeuZIKjqiKZSk9ULpT8AvPgJiGJL2sCC3jb0S+yOr55aA2gg61+anDF+JP9xcW0HhheLBSu+TREtCRQrpzDDvBuigvqyDpXmSVYNLCZX/Hc8ailneLEeU0eLg4HUIBmiWohDbbKen8e41k5TdezcL9e60Cv9J2Zih2YfwshrAReW8SgsLC8kdyBwjs8gKhVO/jLFEDffVDEPwHzXIT5RCDhtPVjmZXJfd/yK1bK5SY8omLUEQgwWJ3b0sybcgehdZ/9j739Nz1+2t6NGDC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPEESz0h4GAJfXfw6KBxyuiW4NE561uUlacL3M6Ieow=;
 b=LNsct4UoydeePSMU9GPxDiqKjRs61MjJSdZvoY+g5lEGIF3d0+G8lNUhWzuo769Bq/O2OIWa8tuhEWkZ/Notv2mKJ4mBnSaX9RYAFcCZIYDAgT3GG6wtsSn7jI+q1wZyHC7hqbDRq4S237wVJevpM5o3CByKtpzmQKcNru3vLEQ=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2012.namprd13.prod.outlook.com (10.174.184.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.15; Fri, 17 Jan 2020 15:17:28 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce%7]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 15:17:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dhowells@redhat.com" <dhowells@redhat.com>,
        "krzk@kernel.org" <krzk@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [BISECT BUG] NFS v4 root not working after 6d972518b821 ("NFS:
 Add fs_context support.")
Thread-Topic: [BISECT BUG] NFS v4 root not working after 6d972518b821 ("NFS:
 Add fs_context support.")
Thread-Index: AQHVzGDcRnNYGCrUqUi6gbIzdqfifqfu6amAgAAF1ICAAAjdAIAAAViA
Date:   Fri, 17 Jan 2020 15:17:28 +0000
Message-ID: <b31b09abeea4982e038b0e66e45889bb2c9df750.camel@hammerspace.com>
References: <20200117144055.GB3215@pi3>
         <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com>
         <433863.1579270803@warthog.procyon.org.uk>
         <461540.1579273958@warthog.procyon.org.uk>
In-Reply-To: <461540.1579273958@warthog.procyon.org.uk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9e87eb7-71b3-4ef0-49be-08d79b605dc4
x-ms-traffictypediagnostic: DM5PR1301MB2012:
x-microsoft-antispam-prvs: <DM5PR1301MB2012FE4CA92886A70EE3C963B8310@DM5PR1301MB2012.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(71200400001)(316002)(26005)(2906002)(36756003)(110136005)(54906003)(86362001)(5660300002)(6506007)(6512007)(2616005)(4326008)(8676002)(76116006)(91956017)(66946007)(8936002)(66446008)(64756008)(66556008)(66476007)(478600001)(186003)(6486002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2012;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XtaC9J2vDVRMvge+ffAgc+oA/+wqkLbF3zqcn+KBfRW186dVyDEM6EGqAAHP8WDZJ87ys6yqVloKLVwLPsZxKKEiqhGpKRgBLWmI1RAC/lc0XSZS9YI7zTMOVGUfS6Fx1HECTfQjl/sbyIkDKTLHlHnJD3HojCAGTpF2GV28afVK522AblgtY5HK8DgvUtl8//UyH0lkq3Wuc/hSzhnGxDsmi17O4+gcVxM744KrYLuEvf/scFfZm0f1xsgTR+5wNLOHgjmlI9t3P0Bgnr0Qyybtmip1xTZQ4yNG/2F1IY9X7yj9ou4oXVZK0dqrD/iiLNCiQc+6uh5oFDJt8ahvKDlapJpt3R6tpgJ/IIrz0eizw2CCX6mL0o/UCB6wScEjO9ZOC6RXkC4Yb0moX7KnrE4bu7aQeaEPtCBnlvBfJjfdSzonRMbdzU3dY9+fYzOd
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <33D5DEF522EFBC48B0D33AEB6DBDA338@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e87eb7-71b3-4ef0-49be-08d79b605dc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 15:17:28.7016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xb/wOXihpR+MGQlPcJNmoLxjKaY+T5vnrrxsYYSeFlY86m7I0BFhvZk5QRRhjWfxuSvNhxEAYsJzxx1j6IZZVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2012
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTE3IGF0IDE1OjEyICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gPiBt
b3VudC5uZnM0IC1vIHZlcnM9NCxub2xvY2sgMTkyLjE2OC4xLjEwOi9zcnYvbmZzL29kcm9pZGhj
MQ0KPiA+IC9uZXdfcm9vdA0KPiANCj4gT2theSwgaXQgbG9va3MgbGlrZSB0aGUgbW91bnQgY29t
bWFuZCBtYWtlcyB0d28gYXR0ZW1wdHMgYXQgbW91bnRpbmcuDQo+IEZpcnN0bHksIGl0IGRvZXMg
dGhpczoNCj4gDQo+ID4gWyAgIDIyLjkzODMxNF0gTkZTT1AgJ3NvdXJjZT0xOTIuMTY4LjEuMTA6
L3Nydi9uZnMvb2Ryb2lkaGMxJw0KPiA+IFsgICAyMi45NDI2MzhdIE5GU09QICdub2xvY2s9KG51
bGwpJw0KPiA+IFsgICAyMi45NDU3NzJdIE5GU09QICd2ZXJzPTQuMicNCj4gPiBbICAgMjIuOTQ4
NjYwXSBORlNPUCAnYWRkcj0xOTIuMTY4LjEuMTAnDQo+ID4gWyAgIDIyLjk1MjM1MF0gTkZTT1Ag
J2NsaWVudGFkZHI9MTkyLjE2OC4xLjEyJw0KPiA+IFsgICAyMi45NTY4MzFdIE5GUzQ6IENvdWxk
bid0IGZvbGxvdyByZW1vdGUgcGF0aA0KPiANCj4gV2hpY2ggYWNjZXB0cyB0aGUgInZlcnM9NC4y
IiBwYXJhbWV0ZXIgYXMgdGhlcmUncyBubyBjaGVjayB0aGF0IHRoYXQNCj4gaXMNCj4gYWN0dWFs
bHkgdmFsaWQgZ2l2ZW4gdGhlIGNvbmZpZ3VyYXRpb24sIGJ1dCB0aGVuIGZhaWxzDQo+IGxhdGVy
LiAgU2Vjb25kbHksIGl0DQo+IGRvZXMgdGhpczoNCj4gDQo+ID4gWyAgIDIyLjk3MTAwMV0gTkZT
T1AgJ3NvdXJjZT0xOTIuMTY4LjEuMTA6L3Nydi9uZnMvb2Ryb2lkaGMxJw0KPiA+IFsgICAyMi45
NzUyMTddIE5GU09QICdub2xvY2s9KG51bGwpJw0KPiA+IFsgICAyMi45Nzg0NDRdIE5GU09QICd2
ZXJzPTQnDQo+ID4gWyAgIDIyLjk4MTI2NV0gTkZTT1AgJ21pbm9ydmVyc2lvbj0xJw0KPiA+IFsg
ICAyMi45ODQ1MTNdIE5GUzogVmFsdWUgZm9yICdtaW5vcnZlcnNpb24nIG91dCBvZiByYW5nZQ0K
PiA+IG1vdW50Lm5mczQ6IE51bWVyaWNhbCByZXN1bHQgb3V0IG9mIHJhbmdlDQo+IA0KPiB3aGlj
aCBmYWlscyBiZWNhdXNlIG9mIHRoZSBtaW5vcnZlcnNpb249MSBzcGVjaWZpY2F0aW9uLCB3aGVy
ZSB0aGUNCj4ga2VybmVsDQo+IGNvbmZpZyBkaWRuJ3QgZW5hYmxlIE5GU19WNF8xLg0KPiANCj4g
SXQgbG9va3MgbGlrZSBpdCBvdWdodCB0byBoYXZlIGZhaWxlZCBwcmlvciB0byB0aGVzZSBwYXRj
aGVzIGluIHRoZQ0KPiBzYW1lIHdheToNCj4gDQo+IAkJY2FzZSBPcHRfbWlub3J2ZXJzaW9uOg0K
PiAJCQlpZiAobmZzX2dldF9vcHRpb25fdWwoYXJncywgJm9wdGlvbikpDQo+IAkJCQlnb3RvIG91
dF9pbnZhbGlkX3ZhbHVlOw0KPiAJCQlpZiAob3B0aW9uID4gTkZTNF9NQVhfTUlOT1JfVkVSU0lP
TikNCj4gCQkJCWdvdG8gb3V0X2ludmFsaWRfdmFsdWU7DQo+IAkJCW1udC0+bWlub3J2ZXJzaW9u
ID0gb3B0aW9uOw0KPiAJCQlicmVhazsNCj4gDQoNCkl0IGxvb2tzIGxpa2Ugc29tZW9uZSBjaGFu
Z2VkIHRoZSByZXR1cm4gdmFsdWUgZnJvbSB0aGUgb2xkIEVJTlZBTCB0bw0Kc29tZXRoaW5nIGVs
c2U/IFRoZSAiTnVtZXJpY2FsIHJlc3VsdCBvdXQgb2YgcmFuZ2UiIG1lc3NhZ2UgYWJvdmUNCnN1
Z2dlc3RzIGl0IGhhcyBiZWVuIGNoYW5nZWQgdG8gRU9WRVJGTE9XLCB3aGljaCBwcm9iYWJseSBp
cyBub3QNCnN1cHBvcnRlZCBieSAnbW91bnQnLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==
