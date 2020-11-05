Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5892A88D1
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 22:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbgKEVSR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 16:18:17 -0500
Received: from mail-dm6nam12on2138.outbound.protection.outlook.com ([40.107.243.138]:25921
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726729AbgKEVSQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 5 Nov 2020 16:18:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv9T/GzXSz+wWnvEEEJmPstg7HC8nU6e9jXj2r3lSdk4jpi3x+f9IJeoALcnTkhQB6lvF9Y2Q63IjSRtAdEK2nGbDJKcQoQpA6TjePnzEbq1ZU0chhaMg9xiL+wuEQ2Gy71dUXvIbwOmfnVE4/5x6nfudC7VFVdxsIpmx5GdzG7OHAbuZAE+Jjvjd0CEtgzx1jrCSTUr9hoaoNc23w1+u0HFbWP0r0U1p3Ve3y7NEVjeDiLQQbfwZtLSPufFU7nGoF+hYtct6YHC6OHTEa0UfHp81CM59IVhB6TLkWoODDm8U5PtrdrT/UPZZ8UtgAecslpafxBcSZifCP2DlKkw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8vdPpMoNCbrL/K7mXugK7FaNGCRqaXokq1pX9ctff8=;
 b=VxzdZbtnRVMBZcjQVyH4hYXupD1uwL7SIOzRSWFr+ZY/VVmNjJfeYMoIyRLt6i8RNz2nN1wD/XHJejYzdmn3iqrci4uFaGqGHonDd5ywivtwuE48sjEO4glfkI72zYYduhZ+KLPbxSEp3y7PN6XiJQSXFoTXWKtoItpazIqkrrN1o1g+alnp83n4ChPrG+Z8g0ZMwwd/QRmYwRgAocBFxvNwa47k6dB0qd6vvzFPwbIghaIKAuL3Ha5d+INnIIYyBqF8nZyFIvcn1RvfN+KU4y+FqgmFpr6NQus5WwX89ilsr7Lexi6HWVVFyVZ4Sz8Eq/YbilJlyigcPFv4XBPLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8vdPpMoNCbrL/K7mXugK7FaNGCRqaXokq1pX9ctff8=;
 b=BEZhoHbkQozyexOnnzTZDxfdhckPR5aYiX8+1eXvGfXTQjbQkO2T4ck3xxzoESTr5WzwQqQ4ZuwaEdf+4J2f1xIdDSuJL89xux+brJ//oZk61HuXa/mm0IUo+VWPlmDliDtG/33FR+MU29JAjukx/B5mm88A1V8VVWE+pkVW3p4=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by BL0PR13MB4243.namprd13.prod.outlook.com (2603:10b6:208:8f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Thu, 5 Nov
 2020 21:18:11 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Thu, 5 Nov 2020
 21:18:11 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "omosnace@redhat.com" <omosnace@redhat.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH 2/2] NFSv4.2: condition READDIR's mask for security label
 based on LSM state
Thread-Topic: [PATCH 2/2] NFSv4.2: condition READDIR's mask for security label
 based on LSM state
Thread-Index: AQHWs5nJlQ8JP38xrUGk0gCF1Wzr+am54zqAgAAPlYCAABhQAA==
Date:   Thu, 5 Nov 2020 21:18:11 +0000
Message-ID: <a96c14c0f86ec274d5bdc255050ae71238bb43fe.camel@hammerspace.com>
References: <20201105173328.2539-1-olga.kornievskaia@gmail.com>
         <20201105173328.2539-2-olga.kornievskaia@gmail.com>
         <CAFqZXNtjMEF0LO4vtEmcgwydbWfUS36d8g24J6C-NDXORYbEJg@mail.gmail.com>
         <CAN-5tyF+cLpmT=rwAYvQQ445tjFKZtGq+Qzf6rDGg8COPpFRwA@mail.gmail.com>
In-Reply-To: <CAN-5tyF+cLpmT=rwAYvQQ445tjFKZtGq+Qzf6rDGg8COPpFRwA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 196577ad-21b5-4d46-158b-08d881d04cfc
x-ms-traffictypediagnostic: BL0PR13MB4243:
x-microsoft-antispam-prvs: <BL0PR13MB4243BB4040EE80524E7FB72CB8EE0@BL0PR13MB4243.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RyHHQVIZa+4OL2gh7SG/QBZ3hh3H7idED2Z9N1NJ+7GDNOIjaa2sJaoJeTt3K/CqejX7WnzUgnFJX84VFV9Mx6xNd92ZRsaP8WIF4sA22U52n6Uw0d4SoaSEHZ0Dsy3CzshlFjo0oUOztEa9O14cJTKaFhzPKCOfzwLKVimDJgAhtELd/L+9tLrPKftwtHkPAREUvZ9w4T5ajmKBXpEZ78yHdhlEnHr0kLo6QWkFZmKx0YCwFR67dPg57kiKIu/f5DoERHiDCqQzwgVV/VT9wfxC73XfIebh/LI6JvLxnX9eCV+Y8KGjVpXBqXwjOaVFfeu2uypNUlhvxEFnk+gsXWzcHUfof8bAa9SpVzs+8GoW/w0/ceaBVHS3+Opgsmdg/vjKVhzmgwLdgKUw0qKJpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(396003)(39830400003)(136003)(76116006)(8676002)(91956017)(26005)(110136005)(966005)(8936002)(478600001)(53546011)(4326008)(86362001)(83380400001)(15650500001)(6506007)(54906003)(66446008)(5660300002)(64756008)(66476007)(66556008)(6486002)(2906002)(6512007)(66946007)(186003)(71200400001)(2616005)(36756003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: X27MSBCOb5g08gJZCGZbG8hfiwlPoUSUGg1H15xmGYczyCuRYuZuvdxyr5eLsvr8tS4iMLeEBQOkqPrlruYs3Gi5Rbm9jTtA6HKwQyPEdVAlBJ5G2qyc7dnqTGJKWObKVyz/5yPTq9NTtjRVygJyy+53N1FpK+XST/qH6m5tDrMWGtW5/0+/fXC5Jrv44FXIuKVhhNXWAaqCPtE4b2D7ou0xmJDFcU7T8QIAxLGTuZ57vX9DQQdKMDwl8c9oEsW9eYAe7RufY6dTpdIZ5wHmZmEbTE3TWB7hH88Hgf/PMz5qEn/hBUwMfqhO0k9LBCfw3m0TrvgE4MYhkGfvzhnoJxbmWAGvm8ayl7hs3SAAAV3cOlcJX11Qnja4qfGQgKDrIgmg+NHm0aKiJf3gxWdLhZGYWJ9kkeOIkOYHRJ4IUq4QgTo1otzsxFCO7kgFrJhzHc6JZgAaYHLbyLKGInU6u+iB9EhlUlTV/mEZzBYNnBELNwm75tZTipHP0isps4DZfIp906vbVPHl97xvOo3H1bDfPDy8K8HBeMVWzD33xb6c+zixXl25k6f3wg+VGVMowo47+7iOKf20npAUgCIjbv7LgfqmwmJHYuQrbd/7lcJCDCO/0w4AgdzDg6globYQ6oYstHaR3jr/GI7i27I+iw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <51FC12CCE1F7D748A898CC5F7A3E0F17@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196577ad-21b5-4d46-158b-08d881d04cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 21:18:11.6191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IzxB1q+D6Cqj/JuK2xWahquYaJwT4SPiThZF9nZQ/Zh049tHaNofctnmXPIBvDTJrlLMlfYhbzYuHdRcJvsysA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4243
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTA1IGF0IDE0OjUxIC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVGh1LCBOb3YgNSwgMjAyMCBhdCAxOjU1IFBNIE9uZHJlaiBNb3NuYWNlayA8b21v
c25hY2VAcmVkaGF0LmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1LCBOb3YgNSwgMjAy
MCBhdCA2OjMzIFBNIE9sZ2EgS29ybmlldnNrYWlhDQo+ID4gPG9sZ2Eua29ybmlldnNrYWlhQGdt
YWlsLmNvbT4gd3JvdGU6DQo+ID4gPiBGcm9tOiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0
YXBwLmNvbT4NCj4gPiA+IA0KPiA+ID4gQ3VycmVudGx5LCB0aGUgY2xpZW50IHdpbGwgYWx3YXlz
IGFzayBmb3Igc2VjdXJpdHlfbGFiZWxzIGlmIHRoZQ0KPiA+ID4gc2VydmVyDQo+ID4gPiByZXR1
cm5zIHRoYXQgaXQgc3VwcG9ydHMgdGhhdCBmZWF0dXJlIHJlZ2FyZGxlc3Mgb2YgYW55IExTTQ0K
PiA+ID4gbW9kdWxlcw0KPiA+ID4gKHN1Y2ggYXMgU2VsaW51eCkgZW5mb3JjaW5nIHNlY3VyaXR5
IHBvbGljeS4gVGhpcyBhZGRzDQo+ID4gPiBwZXJmb3JtYW5jZQ0KPiA+ID4gcGVuYWx0eSB0byB0
aGUgUkVBRERJUiBvcGVyYXRpb24uDQo+ID4gPiANCj4gPiA+IEluc3RlYWQsIHF1ZXJ5IHRoZSBM
U00gbW9kdWxlIHRvIGZpbmQgaWYgYW55dGhpbmcgaXMgZW5hYmxlZCBhbmQNCj4gPiA+IGlmIG5v
dCwgdGhlbiByZW1vdmUgRkFUVFI0X1dPUkQyX1NFQ1VSSVRZX0xBQkVMIGZyb20gdGhlIGJpdG1h
c2suDQo+ID4gDQo+ID4gSGF2aW5nIHNwZW50IHNvbWUgdGltZSBzdGFyaW5nIGF0IHNvbWUgb2Yg
dGhlIE5GUyBjb2RlIHZlcnkNCj4gPiByZWNlbnRseSwNCj4gPiBJIGNhbid0IGhlbHAgYnV0IHN1
Z2dlc3Q6IFdvdWxkIGl0IHBlcmhhcHMgYmUgZW5vdWdoIHRvIGRlY2lkZQ0KPiA+IHdoZXRoZXIN
Cj4gPiB0byBhc2sgZm9yIGxhYmVscyBiYXNlZCBvbiAoTkZTX1NCKGRlbnRyeS0+ZF9zYiktPmNh
cHMgJg0KPiA+IE5GU19DQVBfU0VDVVJJVFlfTEFCRUwpPyBJdCBpcyBzZXQgd2hlbiBtb3VudGlu
ZyB0aGUgRlMgaWZmIHNvbWUNCj4gPiBMU00NCj4gPiBjb25maXJtcyB2aWEgdGhlIHNlY3VyaXR5
X3NiXypfbW50X29wdHMoKSBob29rIHRoYXQgaXQgd2FudHMgdGhlDQo+ID4gZmlsZXN5c3RlbSB0
byBnaXZlIGl0IGxhYmVscyAob3IgYXQgbGVhc3QgdGhhdCdzIGhvdyBJIGludGVycHJldA0KPiA+
IHRoZQ0KPiA+IGNyeXB0aWMgbmFtZSkgWzFdLiBJdCdzIGp1c3QgYSBzaG90IGluIHRoZSBkYXJr
LCBidXQgaXQgc2VlbXMgdG8NCj4gPiBmaXQNCj4gPiB0aGlzIHVzZSBjYXNlLg0KPiA+IA0KPiA+
IFsxXQ0KPiA+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjEwLXJjMi9zb3Vy
Y2UvZnMvbmZzL2dldHJvb3QuYyNMMTQ4DQo+IA0KPiBWZXJ5IGludGVyZXN0aW5nLiBJIHdhcyBu
b3QgYXdhcmUgb2Ygc29tZXRoaW5nIGxpa2UgdGhhdCBub3Igd2FzIGl0DQo+IG1lbnRpb25lZCB3
aGVuIEkgYXNrZWQgb24gdGhlIHNlbGludXggbWFpbGluZyBsaXN0LiBJIHdvbmRlciBpZiB0aGlz
DQo+IGlzIGEgc3VwcG9ydGVkIGZlYXR1cmUgdGhhdCB3aWxsIGFsd2F5cyBzdGF5PyBJbiB0aGF0
IGNhc2UsIE5GUw0KPiB3b3VsZG4ndCBuZWVkIHRoZSBleHRyYSBob29rIHRoYXQgd2FzIGFkZGVk
IGZvciB0aGlzIHNlcmllcy4gSSB3aWxsDQo+IHRyeSB0aGlzIG91dCBhbmQgcmVwb3J0IGJhY2su
DQoNCk5GU19DQVBfU0VDVVJJVFlfTEFCRUwgaXMganVzdCB0aGUgTkZTIHNlcnZlciBjYXBhYmls
aXR5IGZsYWcuIEl0IHRlbGxzDQp5b3Ugd2hldGhlciBvciBub3QgdGhlIGNsaWVudCBiZWxpZXZl
cyB0aGF0IHRoZSBzZXJ2ZXIgbWlnaHQgc3VwcG9ydA0KTkZTdjQuMiByZXF1ZXN0cyBmb3IgbGFi
ZWxsZWQgTkZTIG1ldGFkYXRhLg0KDQpNeSB1bmRlcnN0YW5kaW5nIG9mIE9sZ2EncyByZXF1aXJl
bWVudCBpcyB0aGF0IHNoZSBuZWVkcyB0byBiZSBhYmxlIHRvDQppZ25vcmUgdGhhdCBmbGFnIGFu
ZCBzaW1wbHkgbm90IHF1ZXJ5IGZvciBsYWJlbGxlZCBORlMgbWV0YWRhdGEgaWYgdGhlDQpORlMg
Y2xpZW50IGlzIG5vdCBjb25maWd1cmVkIHRvIGVuZm9yY2UgdGhlIExTTSBwb2xpY3kuIFRoZSBv
YmplY3RpdmUNCmlzIHRvIGF2b2lkIHVubmVjZXNzYXJ5IFJQQyB0cmFmZmljIHRvIHRoZSBzZXJ2
ZXIgdG8gcXVlcnkgZm9yIGRhdGENCnRoYXQgaXMgdW51c2VkLg0KDQotLSANClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
