Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5F6332FD0
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 21:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhCIUXQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 15:23:16 -0500
Received: from mail-bn8nam12on2092.outbound.protection.outlook.com ([40.107.237.92]:44704
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229948AbhCIUWz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 9 Mar 2021 15:22:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCIgPssDvGlSEXuRqcdtJblr/pt/WYbaTEdFpnxetLiNWMqW2eN3po2nHPeFj19bDh4iJeuSyuF2pnculd2TrPLn8VRdHkk7JTX9QYo9kMINrO42NcPMzaG/i7ZCt/SCR9fLjGi49kSOOXlaTsZkuZ2Dv9TRbIDm0GS4dYxexpryZITJNHUiFJtKE/KSbdtemRZGEq+ar4CSxT9ZwkSpb/KtKxLcsEU0cpdyYUquIeMuRPT9sRm80JsQeL9n2uHTf2FdELVvel7psYiQBhReGhv2SZLeHYj9pmE3h/0W+caYp6LeuwphmMMDe2QD2lf/AgU62rklWXpHuRKkRl0R2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yr1suPYBTCIW1He5XZGeqbqS44+K31bHYtTrVpvi3K4=;
 b=a8/9bsBvRoK7S+oXNmHTUo2ltXlPj1luyON03Kggkel7rse0w61MjXR43hOdaxC+Tf7ARUXIa2WbULTq2/WI0hQPW+tPf3ooRQGP/cKFjcVQ5riMcRfsSnErnZZTHpldDpqLi0xVwZrEaJg3YCklbQKhIYnlDhlHiO3i9eOs5bcxtK7SjXNA9O2znxBhj7Dcn5iWS1Q57G02zZydo1FQWJVZjn5e1FrQdcOxSCC0w7ntPvuhoObYsbwCYd39EDfvg62Sy2kvrCb0oUanJ9tgUJjs/CMTkQpTNpljomIT54ZmKX0iEVSR45CNhY86f74ro/EvtsgVfQg0QFdFgez0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yr1suPYBTCIW1He5XZGeqbqS44+K31bHYtTrVpvi3K4=;
 b=e8UuZa5RHDTlO8wHuHRhxbbyBRwVzevCdGgihPz5RSvLRALv+8xS+kbWNFOIabtO+3Nkka7BzCARa0XspVifondK56/YIPgnmdjCXFFS0l+1VaPb+XNRuwvormonIExNhkHZbzCspX4jombe2Ao/GoD8dNi2vrFs6mQPPplClIg=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH0PR13MB4763.namprd13.prod.outlook.com (2603:10b6:610:c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.24; Tue, 9 Mar
 2021 20:22:53 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 20:22:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@redhat.com" <bfields@redhat.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/1] NFSD: fix error handling in callbacks
Thread-Topic: [PATCH 1/1] NFSD: fix error handling in callbacks
Thread-Index: AQHXFPJtj0F8JgkddEiUQJPR5oySTqp7ykSAgABPy4A=
Date:   Tue, 9 Mar 2021 20:22:52 +0000
Message-ID: <4ca27c770577376b0a39f0cfcfb529b96d6d5aae.camel@hammerspace.com>
References: <20210309144127.57833-1-olga.kornievskaia@gmail.com>
         <YEeWK+gs4c8O7k0u@pick.fieldses.org>
In-Reply-To: <YEeWK+gs4c8O7k0u@pick.fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [50.124.244.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f371540c-f67b-4559-541c-08d8e3391e22
x-ms-traffictypediagnostic: CH0PR13MB4763:
x-microsoft-antispam-prvs: <CH0PR13MB4763C1BCE8C9003334A59A2CB8929@CH0PR13MB4763.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dEHXu5jPupXy8nPljHfA7cheVOlCWSlSeDl2bl1Nn/1Osmtz9rc4V3TAmiS4inYNKGdEh2vPN+ZiHSoYRK1QPb1SDiLekoW2GNYHy05av0EaAHFqgLySB6KTodPoVuaNjOQ2q7xiQ+B3LxqrjMbjbYn093sgOdh+OPP+t022u172/q4QZvm/pWdlnAplCZsRdyH/SCoF8UyrCEm4JE/WRnp33uprwIBBtQ8Gx0ifFR1OjOEld60b9L30ztyncRdd6ExttEb9Hpqtd8aW56ykSDiEc2gSG5tjeR91+p+NucGF4lbec8SibuyF5+Be2lGgr6q5EaLQFyyq9T3af7BrvL9Z97md3dKswuYsQ9FqxeueW3c/Qr94tQXYPaO6J0r07nJWeden8pEClKVTAtzqTSr3BXUTtKXxfRB7JzwqMZN7wri7m8KIv2FJAbtNMBTf847oEt9WfDA2Wqpmu2G1cmXXKGQgRdQEfabn6e0E6J6YNP8ZNgUZMDb9Jed+v1J/1OUb4U9ogZhHidH6REkShW11yWH+rY58scTGqIeh8BhHP+1GdE8XfqzJjYaywGV8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(376002)(136003)(366004)(396003)(346002)(64756008)(6506007)(66556008)(8936002)(4326008)(6486002)(86362001)(36756003)(66446008)(5660300002)(2906002)(316002)(478600001)(66476007)(71200400001)(6512007)(110136005)(186003)(54906003)(2616005)(8676002)(66946007)(76116006)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BXjIfxp0AFk2yPe6842VFDsgdKLjIO4x8Kyv26Wh6Mx7Fi32r3jkwJaSK7Zd0x72Y74TDhLfqQPKSv6h2gMFe+FooQQyuRAdcm00+cvi3YNevTY7JIgeP8BAeF8nx4jH/oaFcXo71U/z8jebd9qY3mPRkDclS+pE4qL5fp54H26z+R6TKv1mIPSsvWzA9lLihUZUBJNd/HNwOSLH+Dd7UVheKdtOq6svjIn3cDgFTwmRPMk6AnN9M+eIkao6Eale/qBoIzvmRkWKEW0Hi9b/Qn1mQ+3hQoKTDWQZ9O+SoxIhVzciBESP4OIPE0dUljTHccV23q+2bqcesrj1XwcCLJ14kjmRmq869QlIog5fVOw6X6g08QqgioJnZF8gckKdH0TRevOF6vjwK90CUcLlOgMoOYduIGs241nTf54y29hfYdkBVD8HD1rqmxxJ8p8LuMURk98Ckq09XlzGo2W7HEzSBda0yoaXkcwE+WY5kpWnqk2bfSwBEaqCWiLA7YpkEfv36uuauCkMlETWVWFWzKGlJThLq5wj68kLIq3XfY34MqlvOee0I9dE9HkotNBR9bIGXgnFLIIRov515qIo3jhN1ekQj9CyVTAW+QNib9AlCEWackkJowo02QDkEs724ufrRHtrLgm8Gkgj4c8Ua+dqoQvr9gcqlf/C6RSkll+MVQqrb8Q+9zxu/bV+ipHWC3mBsomd1UoFDwtJvtwtLnfU+cyO7zx2Ur/FZAUV7R63uA9jasqjvjCNSsL72L5s
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC0016B6DF62554AA9CF439B379ADF2B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f371540c-f67b-4559-541c-08d8e3391e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 20:22:52.9733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: STMrmnBTqPbb++9Eo2m68j3yHFzwV0Ajz3Kbcq06oHCcW/GRtc8OfUWd4n7xy49qCpOMWmnZyiD9INLmuRpcpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4763
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTAzLTA5IGF0IDEwOjM3IC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFR1ZSwgTWFyIDA5LCAyMDIxIGF0IDA5OjQxOjI3QU0gLTA1MDAsIE9sZ2EgS29ybmll
dnNrYWlhIHdyb3RlOg0KPiA+IEZyb206IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAu
Y29tPg0KPiA+IA0KPiA+IFdoZW4gdGhlIHNlcnZlciB0cmllcyB0byBkbyBhIGNhbGxiYWNrIGFu
ZCBhIGNsaWVudCBmYWlscyBpdCBkdWUgdG8NCj4gPiBhdXRoZW50aWNhdGlvbiBwcm9ibGVtcywg
d2UgbmVlZCB0aGUgc2VydmVyIHRvIHNldCBjYWxsYmFjayBkb3duDQo+ID4gZmxhZyBpbiBSRU5F
VyBzbyB0aGF0IGNsaWVudCBjYW4gcmVjb3Zlci4NCj4gDQo+IEkgd2FzIGxvb2tpbmcgYXQgdGhp
cy7CoCBJdCBsb29rcyB0byBtZSBsaWtlIHRoaXMgc2hvdWxkIHJlYWxseSBiZQ0KPiBqdXN0Og0K
PiANCj4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgMToNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAodGFzay0+dGtfc3RhdHVzKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZnNkNF9tYXJrX2NiX2Rvd24oY2xwLCB0YXNrLT50a19z
dGF0dXMpOw0KPiANCj4gSWYgdGtfc3RhdHVzIHNob3dlZCBhbiBlcnJvciwgYW5kIHRoZSAtPmRv
bmUgbWV0aG9kIGRvZXNuJ3QgcmV0dXJuIDANCj4gdG8NCj4gdGVsbCB1cyBpdCBzb21ldGhpbmcg
d29ydGggcmV0cnlpbmcsIHRoZW4gdGhlIGNhbGxiYWNrIGZhaWxlZA0KPiBwZXJtYW5lbnRseSwg
c28gd2Ugc2hvdWxkIG1hcmsgdGhlIGNhbGxiYWNrIHBhdGggZG93biwgcmVnYXJkbGVzcyBvZg0K
PiB0aGUNCj4gZXhhY3QgZXJyb3IuDQoNCkkgZGlzYWdyZWUuIHRhc2stPnRrX3N0YXR1cyBjb3Vs
ZCBiZSBhbiB1bmhhbmRsZWQgTkZTdjQgZXJyb3IgKHNlZQ0KbmZzZDRfY2JfcmVjYWxsX2RvbmUo
KSkuIFRoZSBjbGllbnQgbWlnaHQsIGZvciBpbnN0YW5jZSwgYmUgaW4gdGhlDQpwcm9jZXNzIG9m
IHJldHVybmluZyB0aGUgZGVsZWdhdGlvbiBiZWluZyByZWNhbGxlZC4gV2h5IHNob3VsZCB0aGF0
DQpyZXN1bHQgaW4gdGhlIGNhbGxiYWNrIGNoYW5uZWwgYmVpbmcgbWFya2VkIGFzIGRvd24/DQoN
Cj4gDQo+IC0tYi4NCj4gDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogT2xnYSBLb3JuaWV2c2th
aWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+ID4gLS0tDQo+ID4gwqBmcy9uZnNkL25mczRjYWxsYmFj
ay5jIHwgMSArDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9uZnM0Y2FsbGJhY2suYyBiL2ZzL25mc2QvbmZzNGNhbGxi
YWNrLmMNCj4gPiBpbmRleCAwNTJiZTViZjllZjUuLjczMjU1OTJiNDU2ZSAxMDA2NDQNCj4gPiAt
LS0gYS9mcy9uZnNkL25mczRjYWxsYmFjay5jDQo+ID4gKysrIGIvZnMvbmZzZC9uZnM0Y2FsbGJh
Y2suYw0KPiA+IEBAIC0xMTg5LDYgKzExODksNyBAQCBzdGF0aWMgdm9pZCBuZnNkNF9jYl9kb25l
KHN0cnVjdCBycGNfdGFzaw0KPiA+ICp0YXNrLCB2b2lkICpjYWxsZGF0YSkNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN3aXRjaCAodGFzay0+dGtfc3RhdHVzKSB7DQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjYXNlIC1FSU86DQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjYXNlIC1FVElNRURPVVQ6DQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGNhc2UgLUVBQ0NFUzoNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZnNkNF9tYXJrX2NiX2Rvd24oY2xwLCB0YXNr
LT50a19zdGF0dXMpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQ0KPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7DQo+ID4gLS0gDQo+ID4gMi4y
Ny4wDQo+ID4gDQo+IA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
DQoNCg==
