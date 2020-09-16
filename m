Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C1D26C562
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Sep 2020 18:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgIPQyV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 12:54:21 -0400
Received: from mail-bn8nam11on2120.outbound.protection.outlook.com ([40.107.236.120]:40889
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbgIPQxJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Sep 2020 12:53:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfO+sJJm9yJJosT0KqoM176zl15PkSRoFuTm3LELKMQKs+WQ/4JcfZXhp4YG9AzNKXXoV6qF1UHmScWqgo7/teXEsuAyIHBcghpwuiGxR4Lx+57dQMTedTDl2Vyp5PeGTbhyx0O25rfNGfxLZ2o5n5DrXDsZK37YeFZyrzkHtfjJbx3RKIKDxRFWALLiznC6nPocFRGnGFeLjp23QsLFLAhggN4Erinjafra2/idHo/nPExhVVhKA1JbAaxp0jOO2WpGoyKxQiKCCXOPW7mvUSPtPocL90g+Hhm6gRHRZ9Q8E16UQFZ1Pc80OcKMMXL4kCq/Xy14pzByOiHWiuZm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqUgaqzxFrGPUQNb1NszfJL69QWMBqEpOa5xn+d/n3U=;
 b=AsPZitXYCqac7mw7rFTKCovdC6iroANh2R4bxfzJjseJtMkfevpJh408GiFoRcH1k5jBg6hrGZ9bYxO87xBUUwf+NQCMXOUKYdO4WOIFAtrpHPAx1/lInsdh8WN//Iex5ARmTRBKndXQU2hmWLUtH/4KAol4/7IjIxwyX/R0M9u4elKqhaTs93NeiVO+UtXoZdC7+9g764jE2QbRPcc0SocJCtPdPaFZLjdjfoSGwMUXepS1fLKqAZ6Jk+tq6py4doS6G7vhCmZy0Ltluidff9EjdJ15Ly4CUQH0BIAfKSZOpXXfiaCaznjFd6XlbBefH6F1JuxjmkhLhh1yDMe85g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqUgaqzxFrGPUQNb1NszfJL69QWMBqEpOa5xn+d/n3U=;
 b=WFZNqNltlPujeTbfQDU84yFJyHS95YlQcKV5L7kenuG+zSble63+nmVw1DjtiOQcvb6eOHB0hsXJ1k90dzrjDBXDGk3YoD8LrXxJezOS17WABSl/ApUacV7qRjTsASi1Y/A9KrKG5hCXOOEx47sXhUCUvlpj7BMSm2U0BULTQbE=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3245.namprd13.prod.outlook.com (2603:10b6:208:152::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.8; Wed, 16 Sep
 2020 16:36:44 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%6]) with mapi id 15.20.3412.004; Wed, 16 Sep 2020
 16:36:44 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Nagendra.Tomar@microsoft.com" <Nagendra.Tomar@microsoft.com>
CC:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: reset cookieverf even when no cached pages
Thread-Topic: [PATCH] nfs: reset cookieverf even when no cached pages
Thread-Index: AdaLdYAHSfC4FmukRxSfbPzbpNbQ4QAw4uWAAAEERFAAApxggA==
Date:   Wed, 16 Sep 2020 16:36:44 +0000
Message-ID: <6c1b52e4eceba8bac7d60cc92470ae80b3846d6a.camel@hammerspace.com>
References: <SG2P153MB02316AF481EB246AED91DCB69E200@SG2P153MB0231.APCP153.PROD.OUTLOOK.COM>
         <1fdce3fc0981916f8d3829933db61a3f78aebde3.camel@hammerspace.com>
         <SG2P153MB023125DD453D879416DDBA389E210@SG2P153MB0231.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SG2P153MB023125DD453D879416DDBA389E210@SG2P153MB0231.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2f580d6-70fd-4b14-788a-08d85a5eb293
x-ms-traffictypediagnostic: MN2PR13MB3245:
x-microsoft-antispam-prvs: <MN2PR13MB324512E279F182B562B5E797B8210@MN2PR13MB3245.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cJ1BxVjIW+VGMUtv7ekD4yLn7i6ZdiA9LAkABihreQBq8cmasetZzO/rkNgUTE/Kps2l7MMmG53Qo0goY9qT/6U4b9041txdUvtD21WvZvVGLWJRtA1DmXDfG+asFz1jsyIBaJAmOm4yZtwQIVsxpLmIe4dXO3J7qCZes9ajlKjrF25Qth0fDKYV8TBT8VWD959+jppcrifBzgB78VjDlgDCu0iBk/cPgbSiymg3FF7uO60HRYDa1VMEWslLm+TlZdhRGd30RTyITHd/CKkeY8vDaATU482yd1NlCsljZvEB1QlNprjmN+/tj0Z86fVP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(39830400003)(376002)(91956017)(8936002)(76116006)(71200400001)(2616005)(110136005)(4326008)(5660300002)(6486002)(36756003)(66446008)(316002)(83380400001)(8676002)(66556008)(478600001)(6506007)(2906002)(26005)(66946007)(64756008)(6512007)(186003)(66476007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bp3sRPtjnRCpF4TA4a0Rqfgb2G3H8DgHIUDVwtXw3NOOhF+c11q3coC4TX+i3/0mhQ5sSVLOtCws5ngidNBVdEjnKpmhj+aggv5O3WOYEr16mWqXW4dF3nnQefI5n2qLuy77C926v1dlNWSne5M9SRfYM0mjX041N+3gk4KyYfd7qR3aO1/spPdJ2GfzajD53aWx0KeYQPMoyRszr8GIdeLVQ3WgW6qmQGPb8979Kozwu39UP4nt9fbemSgwLN8GY/xqGOcKR+lkuXmD7Z4HmtDjeoI8aih7dtswkoqMsqV32mpFKHitXbaxC6YCJFkfdMFpokYPH/gjexGxvHwCx7DxcEpv+uodvb6NIKZwXGuvcNpNhL8jYfiYeI1B03xSAmvndHpcurzpDSEc+W0dZwiJhta6iQiWJ7FjPhmJQcywLRaRy893u+6PwE2OR+iUOdmYaOsXwUNwe/EeACk0aCIcwmGqJ0cJHGoljW1pfOs//KOwwXfP1pRw8SQ4+UdOK6MH61VSRUZJJhb+kSo1zaQdKlxncaAuau+0kY7A+THFdFksfzDCNINKPxGmmozo+Wy6KX/rT1Jmpgur9UYOAafvlvJPBh3h0jQxt/EPzig5A5w4HHKz+pFsV4bQnmEo3Hrx8JENXVa+wy9TCVzqmg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <264D82A6AB5D2B4BA88E2F74E179E096@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f580d6-70fd-4b14-788a-08d85a5eb293
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 16:36:44.1463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqH9031wfrAfjlKAI2q+fSKRA+yvLw7Ebo6kNL/oFEwXtyTJwCGOmPlFM+jpYh1wVpqcR3wHp4jhl4pBpqJDHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3245
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTA5LTE2IGF0IDE1OjU4ICswMDAwLCBOYWdlbmRyYSBUb21hciB3cm90ZToN
Cj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLCBUcm9uZC4NCj4gDQo+IFRoaXMgaXMgd2hhdCBo
YXBwZW5zIHcvbyB0aGlzIHBhdGNoLiBMZXRzIHRha2UgdGhlIGNhc2Ugb2YgbmV3IGZpbGUNCj4g
YmVpbmcgDQo+IGNyZWF0ZWQuICANCj4gDQo+IG5mczNfZG9fY3JlYXRlKCktPg0KPiBuZnNfcG9z
dF9vcF91cGRhdGVfaW5vZGUoKS0+DQo+IG5mc19wb3N0X29wX3VwZGF0ZV9pbm9kZV9sb2NrZWQo
KSwgc2V0cyBORlNfSU5PX0lOVkFMSURfREFUQSB0bw0KPiBtYXJrIHRoZSBjYWNoZWQgZGlyZWN0
b3J5IGRhdGEgYXMgaW52YWxpZCwgc28gdGhhdCBsYXRlciB3aGVuIHdlIGRvIGENCj4gcmVhZGRp
ciwgDQo+IA0KPiBuZnNfcmVhZGRpcigpLT4NCj4gbmZzX3JldmFsaWRhdGVfbWFwcGluZygpLT4N
Cj4gbmZzX2ludmFsaWRhdGVfbWFwcGluZygpLCB1bm1hcHMgdGhlIG1hcHBpbmcgKmFuZCogcmVz
ZXRzIHRoZQ0KPiBjb29raWV2ZXJmLg0KPiANCj4gVGhpcyBjYXVzZXMgdXMgdG8gY29ycmVjdGx5
IGFzayBmb3IgZnJlc2ggZGlyIGNvbnRlbnRzIHVzaW5nIGENCj4gY29va2lldmVyZj0wDQo+IGFu
ZCBjb29raWU9MCAoZXhhY3RseSB3aGF0IHRoZSBSRkMgZXhwZWN0cyB1cyB0byBkbykuIEFsbCBn
b29kIHRpbGwNCj4gaGVyZS4NCj4gTm93IGNvbnNpZGVyIHRoZSBjYXNlIHdoZXJlIA0KPiBuZnNf
cG9zdF9vcF91cGRhdGVfaW5vZGVfbG9ja2VkKCktPm5mc19zZXRfY2FjaGVfaW52YWxpZCgpIGZv
dW5kIHRoYXQNCj4gZGlyDQo+IHBhZ2VzIGFyZSBhbHJlYWR5IHVubWFwcGVkLiBUb2RheSB3ZSBq
dXN0IGNsZWFyIHRoZQ0KPiBORlNfSU5PX0lOVkFMSURfREFUQQ0KPiBmbGFnIHNpbmNlIHdlIG5v
dGUgdGhhdCBubyBjYWNoZWQgZGlyIHBhZ2VzIGFuZCBoZW5jZSBubyBpbnZhbGlkYXRpb24NCj4g
bmVlZGVkLiANCj4gV2l0aG91dCB0aGUgTkZTX0lOT19JTlZBTElEX0RBVEEsIG5mc19yZWFkZGly
KCkgbm93IG1ha2VzIGEgUkVBRERJUg0KPiBSUEMNCj4gd2l0aCBhIG5vbi16ZXJvIGNvb2tpZXZl
cmYgYW5kIGNvb2tpZT0wLiBUaGlzIGlzIG5vbi1zdGFuZGFyZA0KPiBjb21iaW5hdGlvbiBvZiAN
Cj4gY29va2l2ZXJmIGFuZCBjb29raWUgZm9yIGFza2luZyBmcmVzaCBkaXIgY29udGVudHMuDQoN
Ck5vIGl0IGlzIG5vdCAnbm9uLXN0YW5kYXJkJy4gVGhlIGxhbmd1YWdlIHVzZWQgaW4gUkZDNTY2
MSBpcyBhcw0KZm9sbG93czoNCg0KICAgVGhlIHJlcXVlc3QncyBjb29raWV2ZXJmIGZpZWxkIHNo
b3VsZCBiZSBzZXQgdG8gMCB6ZXJvKSB3aGVuIHRoZQ0KICAgcg0KZXF1ZXN0J3MgY29va2llIGZp
ZWxkIGlzIHplcm8gKGZpcnN0IHJlYWQgb2YgdGhlIGRpcmVjdG9yeSkuICBPbg0KICAgc3Vicw0K
ZXF1ZW50IHJlcXVlc3RzLCB0aGUgY29va2lldmVyZiBmaWVsZCBtdXN0IG1hdGNoIHRoZSBjb29r
aWV2ZXJmDQogICByZXR1cg0KbmVkIGJ5IHRoZSBSRUFERElSIGluIHdoaWNoIHRoZSBjb29raWUg
d2FzIGFjcXVpcmVkLiAgSWYgdGhlDQogICBzZXJ2ZXINCmRldGVybWluZXMgdGhhdCB0aGUgY29v
a2lldmVyZiBpcyBubyBsb25nZXIgdmFsaWQgZm9yIHRoZQ0KICAgZGlyZWN0b3J5LA0KdGhlIGVy
cm9yIE5GUzRFUlJfTk9UX1NBTUUgbXVzdCBiZSByZXR1cm5lZC4NCg0KTm90ZSB0aGF0IHRoZXJl
IHRoZXJlIGlzIG5vIFJGQyAyMTE5IG5vcm1hdGl2ZSBNVVNUIG9yIGV2ZW4gYSBTSE9VTEQuDQpX
ZSB0aGVyZWZvcmUgZXhwZWN0IHRvIGJlIGFibGUgdG8gcmV1c2UgdGhlIGNvb2tpZSB2ZXJpZmll
ciB3aXRoIGEgemVybw0KY29va2llIGluIG9yZGVyIHRvIHZhbGlkYXRlIHRoYXQgdGhlIGNvb2tp
ZXMgdGhhdCBvdXIgY2xpZW50IG1heSBzdGlsbA0KYmUgY2FjaGluZyAoZS5nLiBpbiBhbm90aGVy
IG9wZW4gZmlsZSBjb250ZXh0KSBhcmUgZ29vZC4NCg0KPiBOb3RlIHRoYXQgc2VydmVycyB0aGF0
IGRvbid0IGNhcmUgYWJvdXQgdGhlIGNvb2tpZXZlcmYgZG8gbm90IGNhcmUNCj4gYWJvdXQgdGhp
cw0KPiBub24tc3RhbmRhcmQgY29tYmluYXRpb24gYW5kIHRoZXkgd29yayBmaW5lIHcvbyB0aGUg
cGF0Y2gsIGJ1dA0KPiBzZXJ2ZXJzIHRoYXQNCj4gd2FudCBjb29raWV2ZXJmIHRvIGJlIDAgdG8g
c2lnbmFsIGZyZXNoIGRpciByZWFkIG1heSBub3QgdHJlYXQgaXQNCj4gd2VsbC4NCg0KU2VlIGFi
b3ZlLiBUaGUgc3RhbmRhcmQgZG9lcyBub3QgcmVxdWlyZSB0aGlzIGJlaGF2aW91ciBvZiB0aGUg
Y2xpZW50Lg0KDQo+IFRoZSBwYXRjaCB0cmllcyB0byBtYWtlIHN1cmUgdGhhdCB3ZSByZXNldCB0
aGUgY29va2lldmVyZiBldmVuIGZvcg0KPiB0aGUgY2FzZQ0KPiB3aGVyZSBkaXIgcGFnZXMgc29t
ZWhvdyBnb3QgcHVyZ2VkIHdoZW4gd2UgcmVhY2hlZA0KPiBuZnNfc2V0X2NhY2hlX2ludmFsaWQo
KQ0KPiBhYm92ZS4NCj4gSSBmZWx0IG5mc19zZXRfY2FjaGVfaW52YWxpZCgpIGlzIHRoZSByaWdo
dCBwbGFjZSB0byByZXNldCB0aGUNCj4gY29va2l2ZXJmLCBhcyANCj4gd2hlbmV2ZXIgIHdlIHNl
dCBkaXIgY2FjaGUgYXMgaW52YWxpZCwgb24gbmV4dCByZWFkZGlyIHdlIHdvdWxkIGxpa2UNCj4g
dG8gcmVhZCANCj4gdGhlIGVudGlyZSBkaXIgIGZyb20gdGhlIHNlcnZlciBhbmQgZm9yIHRoYXQg
d2UgbmVlZCB0byBzZW5kDQo+IGNvb2tpZXZlcmY9MC4NCj4gDQo+ID4gU28gdGhlIHJpZ2h0IHBs
YWNlIHRvIGRvIHRoaXMgc2V0L3Jlc2V0IG9mIHRoZSB2ZXJpZmllciBpcyBpbiB0aGUNCj4gPiBy
ZWFkZGlyIGNvZGUNCj4gDQo+IFllcywgYnV0IHdlIGRvbid0IGRvIHRoYXQgaWYgdGhlIE5GU19J
Tk9fSU5WQUxJRF9EQVRBIGlzIG5vdCBzZXQuDQo+IA0KPiBUaGFua3MsDQo+IFRvbWFyDQo+IA0K
DQpFaXRoZXIgd2F5LCBhcyBJIHNhaWQgcHJldmlvdXNseSwgdGhlIHBhdGNoIGlzIGluY29ycmVj
dCBzaW5jZSBpdCBpcw0Kc2V0dGluZyB0aGUgdmVyaWZpZXIgdG8gemVybyBpbiBhIGNvbnRleHQg
d2hlcmUgaXQgY2Fubm90IGd1YXJhbnRlZQ0KdGhhdCB0aGUgbmV4dCBjb29raWUgc2VudCBpbiBh
IFJFQURESVIgY2FsbCB3aWxsIGJlIGEgemVyby4gSSBhZ3JlZQ0KdGhhdCB0aGUgY29kZSBpbiBu
ZnNfcmV2YWxpZGF0ZV9tYXBwaW5nKCkgaXMgZXF1YWxseSBicm9rZW4sIGJ1dCB0aGF0J3MNCm5v
dCBhIHJlYXNvbiB0byBwcm9wYWdhdGUgdGhlIGJ1Zy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QN
CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
