Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E864442D0
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Nov 2021 14:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhKCN5e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Nov 2021 09:57:34 -0400
Received: from mail-dm6nam11on2136.outbound.protection.outlook.com ([40.107.223.136]:13591
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232051AbhKCN53 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Nov 2021 09:57:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOIIrVToDWn+H5CxTFd4o1CSqA3CS4CYHrb/okQDzbjoKCy33W5eJxlq7EglTzcwg108rgmRncxpa8g9Ze0SCvHhth3su60W2DnQV91b7b5HSGAsLW9DNCfKiYP+dWisTyU1Um5zkHY5aJ932ZWJKGQdMf+IkPFRk6RUr54Xn+O0XajBxxn9719E3BVoXEaUWP64pV0qmtMQPUNYhJIAanm7wj+4sYEX/GS6wHeciD/Pv1KTNyyy7IXqQQdfJM5IpOY4CXSz5x3wwhSr55XHaSqh25VtQ1Wcx2FSgPF6feRkpdBnteOkoVhEHw/AKwf9YHqtWvQoi1+v6KDMOyUQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txLk80q4M+3mWRiW0J7LprVuzxD4Pc7O6STVyHqMg4I=;
 b=iFk7xw183VWVUv1fkG64txyXKl8U8Hth8RbEcvr+XC79krkE4kM0M/xPUR96umUP2Zo1LN0Ig6AgYDd5NZORO4kbjbeM1IEuZkpGLehwePTExdkuFPJG0JgS0qwAOy5NSxkXvnsBjmSvXMLFmZ7/001Cd5AZ7XFRT/tZN1RbIJNScr9hxB4wpJf/O4LmbvciwR7n7zLieZMLA4iT0grrA2SyM7VS/aA/SJz/B8I+YsvHS8dL5SJKnwpDMMhfzx90v13qfke00OGpTFlDhyNl4DRpM5D39+jGpJDR4xDa64ftkTBfRdFiewMp80iaFfGXYplfKdi1FKU5xH3cOR3Mvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txLk80q4M+3mWRiW0J7LprVuzxD4Pc7O6STVyHqMg4I=;
 b=bF8Z/kYRph0Rmw4/tLAC8Nl6IAk4pvkf+99iGRkWFFPFdh9AqvxETYiRTwJgdSqpzmgGMudNZViC/SloD1DCrEKhZ96SzZJh/b+xPYr6irRADSJpkpfUKirRKrxGpb0Gp6fsQfiwJw2TLKBr4UsozLNwZQJLDOo7YA3bRiIYyUI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4714.namprd13.prod.outlook.com (2603:10b6:610:c2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.6; Wed, 3 Nov
 2021 13:54:49 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%8]) with mapi id 15.20.4669.010; Wed, 3 Nov 2021
 13:54:49 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 2/9] nfs: remove unused header <linux/pnfs_osd_xdr.h>
Thread-Topic: [PATCH 2/9] nfs: remove unused header <linux/pnfs_osd_xdr.h>
Thread-Index: AQHX0DVQ984FywqRDkeU7h4MdEH9Tqvw1XOAgAD6RICAAASXgA==
Date:   Wed, 3 Nov 2021 13:54:49 +0000
Message-ID: <c86b2be8e11f8586098bf202831c592f8d92476e.camel@hammerspace.com>
References: <20211102220203.940290-1-corbet@lwn.net>
         <20211102220203.940290-3-corbet@lwn.net>
         <08d283fbedab1be09a9dd6cf5a296c6a465a9394.camel@hammerspace.com>
         <87bl312wc2.fsf@meer.lwn.net>
In-Reply-To: <87bl312wc2.fsf@meer.lwn.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lwn.net; dkim=none (message not signed)
 header.d=none;lwn.net; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 753af12e-3fa2-4906-7efc-08d99ed180b6
x-ms-traffictypediagnostic: CH0PR13MB4714:
x-microsoft-antispam-prvs: <CH0PR13MB47146693B467D5047B876798B88C9@CH0PR13MB4714.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P1Nljc/6aiOHcdPOfsbB+slpnxSvdx7g5qg8/p7EvjQNwwjeDKJJxOqL1pXzWeHE26L9u00xpA3FMeGUVEmy39/RZuuCNj0yb6y2f7zpiFJfE9BFRkn/HOmd1GqGYD/dGwYBtWaz1sFXRou6T6fVhT6js7UJZP96rVum3+g/akNuAKnk+Xa9vwqZKd23b+dNAkJEwtcs3dLjVIvwmbGhGO3Iwuahn6WFU4x8ElYfI030Rjs1OJ9tKs00sZK5ImKkcluJjBynL4LlvCRzMF2qJ8VX1KXf8HV3YNrH4j4rWLE0x0/HnRl5/VJ7ldHX2SvH1QWgT5PRIakRwgcef3lFBlnp9RXZVq6TVOh26ZDA0dEAP3OCP2LYOFGBl4FAl87swYKw3EnbYOzoM0O/8bi+F1jl9Rq8wm0G6hbFowXSrKB360gj3HIuDaQFhMnCZ1a8Juma/7crmU6e+lvYQIjr6s6K9Ufxt6z/0fS9ofDHDMdEpEMqGB6xBPJc8Ib8ZFkfhiTNrzikvABERFV4zhEufuLBOh3rSt/JHq0LtV/cKWM9VwzdYbBGAmzp0/7rKsfc2ZFHNvmqpetgXIflrNqgNq6ej7w0pzWIyki0etvqjwwFJxoDrguisJH8bT1sapWQemWQq0roa5cFXtEv1wf/s/qXd+2iWlOi4LnZKTRsNnQ+3xOcq7I64ylgUlOktA+H+dI+iuzUY5eKAYZkS/xjRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(316002)(5660300002)(38070700005)(83380400001)(2616005)(36756003)(508600001)(2906002)(66476007)(66556008)(64756008)(66446008)(186003)(66946007)(54906003)(76116006)(4326008)(6486002)(38100700002)(122000001)(8676002)(4744005)(8936002)(6506007)(110136005)(86362001)(71200400001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azZkb1l5R2h6N1QveTkvMFdSbXJRbjNURzFIcU9SQ2ZjZGZMTWVsRWs5VE5m?=
 =?utf-8?B?aENaS3V3WUZuNDRyODV5NWk3bDFlUHRrMXZXVmt2V0RPN1FDNkZJZCs1cnVh?=
 =?utf-8?B?NmNBNXFaMnJaNHlXZXI1QzU0Ly9oemVaamhCa3RwOWkwMWRsRmZpSEJyL1JD?=
 =?utf-8?B?U1RLSFlOV1Z3bnVkODZKamY4ZTY5YnZBeUI1bTRXRHlOeW5Dd2tvTWpyVDNs?=
 =?utf-8?B?ajR3K3RVa1pTVHNBc2xuQzNZNXZUREJPZ3I5d0RORVlpOTcyeERmZEZpRzlP?=
 =?utf-8?B?NzNWMS81TmlwdUZQSmY5cCs0TmlFR3FZQ1NhREVaN3g2ZnNOWFpMWXZzRENY?=
 =?utf-8?B?c2JtWFdEV2p5OStwMitEUzlhUC9UdnNQcU1NU1dBRHJpNS9oM1Q2V3pKVE1n?=
 =?utf-8?B?ajEySGtQZEJQWHNaNzNwOHg4SERtcHA5Vkw0cnp6VHRUZWJuNHA2VkVUa0ZN?=
 =?utf-8?B?VXE2eExYRjU1Z3k3L0RFN2xsSTVGZlNZL29ETFhFZlVxV1VnUEFpT2QzRnZV?=
 =?utf-8?B?T2JHMmZFaUZoVVhKYmszaDRwOTRKUTZYUjFOeEsrSGJoMVZkYVZqbjVpZ0I2?=
 =?utf-8?B?bExuU3pFUEZOeFUrUHFqaDBsVVN0VExFdlJBL1lTcVRIRmtqcGtrTTU1cXht?=
 =?utf-8?B?OS9BV3VZV0hjRVE2TlpYRmg3dVYySDBPT0VIWG5haGZtd2FNblJoNEZxNXpB?=
 =?utf-8?B?SHI2ekRIQ0tYakVLZTAydHFhUzlOQzdXOWxOWlhSamkvYWlWTWMrbk53djBH?=
 =?utf-8?B?bURDbS9EVlN0bVFPWXRvektwbFhFNU9TbXNLOGg3LzJPbHh1Qm9kRTRCRDFy?=
 =?utf-8?B?SlNKTFpQNGg4MEpzNC9ydkNJY3NuTVJLM3VzSnNvRFBMYVdScDBmSGdNRlRk?=
 =?utf-8?B?ZW1GT21VWC9IT0lha2FaaWVOdEc1QjF3WG1RYUZnOHRvUGcwVW9UTEY0Uy9m?=
 =?utf-8?B?ZlU1VzZFT1daL1FnYVJ5NUYvRDFJV3BHblhlMS8zb2RkSGxkU3laS1lEWW5O?=
 =?utf-8?B?UkI4ODB1RVFXWjlSZ3RGNmJLeXk2YVpvZmFaN05xcVBBMjNBQk1MUjQ0U3dB?=
 =?utf-8?B?cEh1TGRaRXFGaENyUUJ1WWRTRDRXd1B5RmNnNENabE9NNXBESHVsaDN1OXR4?=
 =?utf-8?B?QXJEUGVvd2p5bjc1Z1JjWFVFN2Zhbm1jT2xUc3dHdVBYKzJzK0xRTnBOZVFk?=
 =?utf-8?B?RVpuS1dIbEdMSm1zV3c1S2NYRThGM1pTc1BpdjVRSk5jbVdleEZ2Um5oYkNy?=
 =?utf-8?B?Z1h3eDhVdXQydjQzRnJ0SWNoK0w0UEZnc1BqaGRvYjAvQ3RGREpHQzVub0N5?=
 =?utf-8?B?YWhQY3FSNi9vNldtY3pudHlOTGFPdmhQR3BxbEtLdHMrdWg1ZkhhMjg5ZCs1?=
 =?utf-8?B?SG5aeWNvMytvQzd5NmNhV2RhZCs4Rk1QbG5MNFZmSUM0Z3JNTW5XOExqemtK?=
 =?utf-8?B?amdkTitFcUhiWnlqUTA4R01lQ2V0WGdSY1pIL3NWcFMrRGQwOUZyNjVFZ3FE?=
 =?utf-8?B?NXJmNVM3Rk54dHRNalJhTUc4c29ObFQ1OVBrWExlTFRhNjY1ZTc0cy9IOGdk?=
 =?utf-8?B?eDhWVzVkZldaU1JrUFdVbXdCdzlSVWRIN2dvZzE4R3lrdVB1NHh4VVJUSXRU?=
 =?utf-8?B?aWN4QkJmYnJEQkk5OHA5Tm83Nm0yOHlPQWU0OHRwbWE1QmNlazRLTllQbDhz?=
 =?utf-8?B?a1NoenZOZ0g4KzlZK3NCNFFZNnBpemR0RU9WZWtwVWE1aEJkZitUWmI1djB2?=
 =?utf-8?B?Q094eHRqdXBwM0VYd2F2Y0hZSWpPSnR2dlZPbmFLZnFEdVVHMHdOOE1ESVpO?=
 =?utf-8?B?c1ZUbFhHZEgvTVBrWGVFbDR4SHB5NGtRRndCQS9zNmdUa3Z6UmNUSllFdnlS?=
 =?utf-8?B?Uk5QMW53OFdVTXRHSUdZWmNiTDRac0xqamJGenlhTm9QMnNLSy9pcVJkQkds?=
 =?utf-8?B?RzIxdXl2V0VtV3owcFM3cjArVGRIbHUzTlBTK0J1RDJmVkRrTHRhYVlyUTg3?=
 =?utf-8?B?K3JWN2hyTmpkdEdYTXNjK2kwUjBpVjM1S0h1OEtjd2dMVUQ1NXlwbU15WkRr?=
 =?utf-8?B?TUpkcVpqbjVaR3IwZEw0WEtYNDh2VktHUGFTT3RRRWk3NGx2Wm52bDNpYmc1?=
 =?utf-8?B?cW9qUk93WU9zS2hCRUk1SVRwRkxFZnVLSUJ4b3pDSUtxSWtzTHdacUFrbXZM?=
 =?utf-8?Q?u3YAan7TPpAy7jATk/tB1J8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1650A46B683D8449829771F954178694@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753af12e-3fa2-4906-7efc-08d99ed180b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2021 13:54:49.2989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ok09STuP95Y/gh2+mrJ5fbAylZEHct0v4/giJwaa1g7RYpbgUdGJMEY3Wwv97wsTorWR4u238hwNjvStbJgvOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4714
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTExLTAzIGF0IDA3OjM4IC0wNjAwLCBKb25hdGhhbiBDb3JiZXQgd3JvdGU6
DQo+IFRyb25kIE15a2xlYnVzdCA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyaXRlczoNCj4g
DQo+ID4gSGkgSm9uLA0KPiA+IA0KPiA+IE9uIFR1ZSwgMjAyMS0xMS0wMiBhdCAxNjowMSAtMDYw
MCwgSm9uYXRoYW4gQ29yYmV0IHdyb3RlOg0KPiA+ID4gQ29tbWl0IDE5ZmNhZTNkNGYyZGQgKCJz
Y3NpOiByZW1vdmUgdGhlIFNDU0kgT1NEIGxpYnJhcnkiKQ0KPiA+ID4gZGVsZXRlZA0KPiA+ID4g
dGhlIGxhc3QNCj4gPiA+IGZpbGUgdGhhdCBpbmNsdWRlZCA8bGludXgvcG5mc19vc2RfeGRyLmg+
IGJ1dCBsZWZ0IHRoYXQgZmlsZQ0KPiA+ID4gYmVoaW5kLsKgDQo+ID4gPiBJdCdzDQo+ID4gPiB1
bnVzZWQsIGdldCByaWQgb2YgaXQgbm93Lg0KPiA+ID4gDQo+ID4gPiBDYzogQ2hyaXN0b3BoIEhl
bGx3aWcgPGhjaEBsc3QuZGU+DQo+ID4gPiBDYzogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+ID4gQ2M6IEFubmEgU2NodW1ha2VyIDxhbm5hLnNj
aHVtYWtlckBuZXRhcHAuY29tPg0KPiA+ID4gQ2M6IGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5vcmcN
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+DQo+
ID4gDQo+ID4gQXJlIHlvdSBzZW5kaW5nIHRoaXMgZGlyZWN0bHkgdG8gTGludXMgb3IgZG8geW91
IHdhbnQgbWUgdG8gdGFrZSBpdA0KPiA+IHRocm91Z2ggdGhlIE5GUyBjbGllbnQgdHJlZT8gSSdt
IGZpbmUgZWl0aGVyIHdheS4NCj4gDQo+IEdvIGFoZWFkIGFuZCB0YWtlIGl0LCBwbGVhc2UsIGlm
IHRoYXQgd29ya3M7IGl0J3MgYSBiaXQgb2ZmLXRvcGljIGZvcg0KPiBteQ0KPiBkb2NzIHRyZWUu
DQo+IA0KDQoNCldpbGwgZG8uIFRoYW5rcywgSm9uIQ0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
