Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061A72865EC
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 19:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgJGR3c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 13:29:32 -0400
Received: from mail-bn8nam11on2114.outbound.protection.outlook.com ([40.107.236.114]:47552
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbgJGR3b (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Oct 2020 13:29:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5wPRyHWEy3rmXtk1QVPHZGttvwiRVWTie5g589cHKTryGSteFZL9gq1UyxpTSSmGEQGzHjPPdnofR7bhGlHkSLQ4Jq16/cX23rStAm7iPU/r1OA0OGYxpRybQrw1grBtjr4B1E2b5uT4LX1cA5pNTUcG0U167EdAkWsp8Ov2BoXkc4M9XudTRCpXDPQoRvAyDwYOg11+6VzpNiRLEzqsPPw/nFkW04nALQqx8dVNSol+VAGBdr/KsBjdWCYhxhKO/wTCwLXrQ9uABmboYwioz028bvrbQspJgFy/ysopuw5jxYqWZ1xFLQF4p9LEOFc/shaF2l+5sjZMbi5ylP0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DNzvd7WMA9i9jfqQy67nUMNkZDP/eWe8oEiHm73nXs=;
 b=hpwO4hgZHt7e+bnFJaO9dgvvwwLiAQCJAMbI1DI3FHOxyjziqmq9BMoVfbAr4Q5maczQGuM8anP3Ln6P5oNDalZNluREdMKKN2R3z6qdUyC54gBlTfdj70AYeHqaJpa/mlyH/meiIXivaX2F/7nAxeWPY+tWfi1JXohFp1h6wqbA2U8KP8Ql+5ZWirBKU+ZnZCEYFZa+wA7VGmf24PxBBY5pPig8g8p2pTV/UZfUg0VIF9oc8g2HfYSH0p63+uafgrevvgiikr3LhFjxWF3XPCJyNZMxqzwhnUXEHq/cPIN0Rhz7yrPw2qZIQSgXjACjVDQBJutl0+fhhVe39schPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DNzvd7WMA9i9jfqQy67nUMNkZDP/eWe8oEiHm73nXs=;
 b=CdRafnC2WJEr/FxrNJzg3tKF1z3UU4WBPXflfEJ6NMONMq2SFV43TngpOTaulqYLxB900r27KflJIURvt6H/espGdRwixGOWbBJnZqedluOvntwG0a4CzyWQWcnvDwDoCYNA9ilJjmFqFXiyimDfmHElK6vuk+qRXRC42uOrkwA=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3941.namprd13.prod.outlook.com (2603:10b6:208:24e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.13; Wed, 7 Oct
 2020 17:29:26 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%7]) with mapi id 15.20.3455.021; Wed, 7 Oct 2020
 17:29:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: unsharing tcp connections from different NFS mounts
Thread-Topic: unsharing tcp connections from different NFS mounts
Thread-Index: AQHWm/NG4ET1NagHX0mhv4Iw/L0dZKmK9/iAgAAkV4CAACp7AIAAuvkAgAAYugCAAA3yAIAABV0AgAAC94CAAB7QAIAACtUAgAAIvoCAAAO/AA==
Date:   Wed, 7 Oct 2020 17:29:26 +0000
Message-ID: <5998d49f790736aa49e7a2ac89b555bc99f3b543.camel@hammerspace.com>
References: <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
         <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
         <20201007001814.GA5138@fieldses.org>
         <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
         <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
         <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>
         <20201007140502.GC23452@fieldses.org>
         <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
         <20201007160556.GE23452@fieldses.org>
         <6d9aee613e9fb25509c9317910189ee37a2e4b43.camel@hammerspace.com>
         <20201007171559.GF23452@fieldses.org>
In-Reply-To: <20201007171559.GF23452@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d72c5827-063d-44fe-405f-08d86ae68a2f
x-ms-traffictypediagnostic: MN2PR13MB3941:
x-microsoft-antispam-prvs: <MN2PR13MB39416EF111B4AFC52D502DF3B80A0@MN2PR13MB3941.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PiWdhUnrXjvc4OEwZ5T3yMpbN6kCwggEFRqIT1yU8UToYpvOHmVbDK7tCNCD3DQ4AvmevfUJVnzDoFKWhYicW27nYloglgDm3+T1+6f5QYQsd/SmFPRxc0dOVrGjnsznEBAWTrmYleOIT8KPJqpirn32ov/eA0E5sGR5rKJ1LZ/eCimjRigdSvilVph1T3q0lEMGHFbvAgI8HZLB0pejdgl2VCvudi6GlJWsALAzCUBdaBjMJb6JCbdPY6GfHtyu9pl+gH/tNLrc8F9s4jLToMlNGsAbF2B00pne8dyPRa8f8Ygr68/Wi1RX15sTgERMYVOVt+olPNcdj894gBQjFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(396003)(366004)(136003)(346002)(5660300002)(2906002)(316002)(86362001)(6916009)(4326008)(66946007)(6486002)(83380400001)(66556008)(64756008)(66446008)(66476007)(478600001)(54906003)(26005)(36756003)(76116006)(6506007)(91956017)(71200400001)(8676002)(8936002)(6512007)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: S5+dT5QXFhqewHf8TMkjFr6EPtaGV1EWI/maVGyXNNqQEBERnMot5azPKZ2GVpfIF8Y+NPUuvEw4rlS7va2t7E+Sv2TyPEWD3BGc/veYLn3XBGrPAg4CXElxQVyJ1mNhppxeBduRXf9J8jP7+w9aRdVt2qNSImTOdTF4kjyDYnFBPV9Gdp5AYouUnOMD04YFBATlNfDVpJdjpYVdqtWj1Amx63ACn6dxDmU3SYWd68G4uZEWdW8NKQlFkYdSy8KM3n8gAjmtcrdDmBf/JY2CjX8JfuaquwNyklIRyTjKBT/QhKzoH7dX6tDmA98hLDhIJ19QXUF4xXusZ6y9jZx8qejeByGI5z0YZgKVaLEBtZ4ScLpivDg9MnAaoxvCkDam12g1MCFANai+yyyjTDn0m0wAmf3W7sYwaYlaNgZ+TMzb0KINI4bvOT6/9uXo9zCKRr7qCrzcTF0sWqag/sK0zUfTFG7EiVI3oWazdUdxpOW04EAWHJipR1fkVPwBgEHr1reBqhZ8AnXHDIpjkr9kBqxfaJ/W7TJOZdoXhHJltRDAYipJUZ0xpJzYAEGLdSDfaKIDr46iIfp7iZAOUPHYOJQH0wqnZC+53vDvvKLtqKzH729GbjPIcZSRU5eIKOg2A4nIkgbiJcE1qKy2Ujg4kg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <27BD28545C20694DA3C6710329608D1C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72c5827-063d-44fe-405f-08d86ae68a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 17:29:26.4647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MifHuzY9ybdUtjbZDE9AaE5DeLn1ErffGeHCxNG91HnFL9FhO2+HCQkOoeZNLhWJ3x7zT2wq/xCSfS9wE+NF1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3941
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTEwLTA3IGF0IDEzOjE1IC0wNDAwLCBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+
IE9uIFdlZCwgT2N0IDA3LCAyMDIwIGF0IDEyOjQ0OjQyUE0gLTA0MDAsIFRyb25kIE15a2xlYnVz
dCB3cm90ZToNCj4gPiBUaGUgcHJvYmxlbSB0aGF0IGFsbCBsb2NrcyBldGMgYXJlIHRpZWQgdG8g
dGhlIGxlYXNlLCBzbyBpZiB5b3UNCj4gPiBjaGFuZ2UNCj4gPiB0aGUgY2xpZW50aWQgKGFuZCBo
ZW5jZSBjaGFuZ2UgdGhlIGxlYXNlKSB0aGVuIHlvdSBuZWVkIHRvIGVuc3VyZQ0KPiA+IHRoYXQN
Cj4gPiB0aGUgY2xpZW50IGtub3dzIHRvIHdoaWNoIGxlYXNlIHRoZSBsb2NrcyBiZWxvbmcsIHRo
YXQgaXQgaXMgYWJsZQ0KPiA+IHRvDQo+ID4gcmVzcG9uZCBhcHByb3ByaWF0ZWx5IHRvIGFsbCBk
ZWxlZ2F0aW9uIHJlY2FsbHMsIGxheW91dCByZWNhbGxzLA0KPiA+IC4uLg0KPiA+IGV0Yy4NCj4g
DQo+IExvb2tzIHRvIG1lIGxpa2UgY2xfb3duZXJfaWQgbmV2ZXIgYWN0dWFsbHkgY2hhbmdlcyBv
dmVyIHRoZSBsaWZldGltZQ0KPiBvZg0KPiBhIG1vdW50IGV2ZW4gaWYgeW91IGNoYW5nZSBuZnM0
X3VuaXF1ZV9pZC4NCg0KSXQgbmV2ZXIgY2hhbmdlcyBvdmVyIHRoZSBsaWZldGltZSBvZiB0aGUg
bmZzX2NsaWVudC4gSWYgaXQgZGlkLCB3ZSdkDQpiZSBpbnZpdGluZyBmdW4gc2NlbmFyaW9zIGlu
IHdoaWNoIHdlIGVuZCB1cCBjb25mbGljdGluZyB3aXRoIG91cnNlbGYNCm92ZXIgbG9ja3MgZXRj
Lg0KDQo+IA0KPiA+IFRoaXMgbmVlZCB0byB0cmFjayB0aGluZ3Mgb24gYSBwZXItbGVhc2UgYmFz
aXMgaXMgd2h5IHdlIGhhdmUgdGhlDQo+ID4gc3RydWN0IG5mc19jbGllbnQuIFRoaW5ncyB0aGF0
IGFyZSB0cmFja2VkIG9uIGEgcGVyLXN1cGVyYmxvY2sNCj4gPiBiYXNpcw0KPiA+IGFyZSB0cmFj
a2VkIGJ5IHRoZSBzdHJ1Y3QgbmZzX3NlcnZlci4NCj4gPiANCj4gPiBIb3dldmVyIGFsbCB0aGlz
IGlzIG1vb3QgYXMgbG9uZyBhcyBub2JvZHkgY2FuIGV4cGxhaW4gd2h5IHdlJ2QNCj4gPiB3YW50
IHRvDQo+ID4gZG8gYWxsIHRoaXMuDQo+ID4gDQo+ID4gQXMgZmFyIGFzIEkgY2FuIHRlbGwsIHRo
aXMgdGhyZWFkIHN0YXJ0ZWQgd2l0aCBhIGNvbXBsYWludCB0aGF0DQo+ID4gcGVyZm9ybWFuY2Ug
c3VmZmVycyB3aGVuIHdlIGRvbid0IGFsbG93IHNldHVwcyB0aGF0IGhhY2sgdGhlIGNsaWVudA0K
PiA+IGJ5DQo+ID4gcHJldGVuZGluZyB0aGF0IGEgbXVsdGktaG9tZWQgc2VydmVyIGlzIGFjdHVh
bGx5IG11bHRpcGxlIGRpZmZlcmVudA0KPiA+IHNlcnZlcnMuDQo+IA0KPiBZZWFoLCBob25lc3Rs
eSBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIGRldGFpbHMgb2YgdGhhdCBjYXNlIGVpdGhlci4NCj4g
DQo+IChUaGVyZSBpcyBvbmUgcmVsYXRlZCB0aGluZyBJJ20gY3VyaW91cyBhYm91dCwgd2hpY2gg
aXMgaG93IGNsb3NlIHdlDQo+IGFyZQ0KPiB0byBrZWVwaW5nIGNsaWVudHMgaW4gZGlmZmVyZW50
IGNvbnRhaW5lcnMgY29tcGxldGVseSBzZXBhcmF0ZSAod2hpY2gNCj4gd2UnZCBuZWVkLCBmb3Ig
ZXhhbXBsZSwgaWYgd2Ugd2VyZSB0byBldmVyIHBlcm1pdCB1bnByaXZpbGVnZWQgbmZzDQo+IG1v
dW50cykuICBJdCBsb29rcyB0byBtZSBsaWtlIGFzIGxvbmcgYXMgdHdvIG5ldHdvcmsgbmFtZXNw
YWNlcyB1c2UNCj4gZGlmZmVyZW50IGNsaWVudCBpZGVudGlmaWVycywgdGhlIGNsaWVudCBzaG91
bGQga2VlcCBkaWZmZXJlbnQgc3RhdGUNCj4gZm9yDQo+IHRoZW0gYWxyZWFkeT8gIE9yIGlzIHRo
ZXJlIG1vcmUgdG8gZG8gdGhlcmU/KQ0KDQpUaGUgY29udGFpbmVyaXNlZCB1c2UgY2FzZSBzaG91
bGQgYWxyZWFkeSB3b3JrLiBUaGUgY29udGFpbmVycyBoYXZlDQp0aGVpciBvd24gcHJpdmF0ZSB1
bmlxdWlmaWVycywgd2hpY2ggY2FuIGJlIGNoYW5nZWQNCnZpYSAvc3lzL2ZzL25mcy9uZXQvbmZz
X2NsaWVudC9pZGVudGlmaWVyLg0KDQpJbiBmYWN0LCB0aGVyZSBpcyBhbHNvIGEgdWRldiB0cmln
Z2VyIGZvciB0aGF0IHBzZXVkb2ZpbGUsIHNvIG15IHBsYW4NCmlzIChpbiBteSBjb3Bpb3VzIHNw
YXJlIHRpbWUpIHRvIHdyaXRlIGEgL3Vzci9saWIvdWRldi9uZnMtc2V0LQ0KaWRlbnRpZmllciBo
ZWxwZXIgaW4gb3JkZXIgdG8gbWFuYWdlIHRoZSBjb250YWluZXIgdW5pcXVpZmllciwgdG8gYWxs
b3cNCmdlbmVyYXRpb24gb24gdGhlIGZseSBhbmQgcGVyc2lzdGVuY2UuDQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
