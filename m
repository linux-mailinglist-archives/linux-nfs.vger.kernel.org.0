Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665773B6AD1
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 00:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhF1WIt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 18:08:49 -0400
Received: from mail-bn8nam12on2125.outbound.protection.outlook.com ([40.107.237.125]:58976
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233076AbhF1WIr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 28 Jun 2021 18:08:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIBd1iM6FVyIjZL5ase2zRxPMHgHKMN2nZ493bisNlNwnk5stds7dv1g0vCd/NQTZYWzkhnHtB62feDAASCKukuTxFhdaX5RLQ/qTWijoBuczXVggJfLxV5QxrCECmvtokOlsHvRVFmeYtju3HRo81qY2WOHsVpPxVRT9ixdiZqhN1Z31cQKrIQo7o1v4qlcCyYXmnHU7EcqEspopIMXs2ixLrqKDC8A4QAQ23VDj/j3yyUNUraSihfRWMv+dlts82w4ANHafRDigvSuUBXaqdJyE+wVabF8cJnLA0MwnNAeB0E4Hpe5hv+P+1PElKVVjDP58xvaTDXXkjoFthsWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fopBG4xtR4loPZxm3PxKMR0i7X8bKo9GW2XPSK38YDw=;
 b=HOYhGZVxOyzlckS9Z66qdJkwkBGo1acKrWez4tSDqSgxPXAE+CyVunE9Rq5GzRVUpauepguewYCEjkL/IFWpGbfsdHB7uworVnqdzmEzAxj25tEfqMIP9jv3UUe9MJg7E3+CynO0psBodkjQ8ZJm+GdE27bQmrbB6ZmfNK0I7WjjzSP9nqcsZ4BFxNmQLZeqkLO63Cv2kZGErbG/j96hdtsqqpziB0kpXBjOgll6TZzTW6TVWt4gVrqOo3gQqEBL+HtRu1jbW36Xja2PfjtJJBd2AFwKmfR71NNrSEtX2XeEfCisGDrf+HGkG7buE8VX7X3vrul186RHJEwDjRjBnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fopBG4xtR4loPZxm3PxKMR0i7X8bKo9GW2XPSK38YDw=;
 b=EmgAOpK/cIFjjZaI/1wM+E+9eXtwdy0MyhM987WTn4fv4LIzZS9Rph6Bptxzo3LOIHJ0j54wbE8TcKgMw+3kD0ksZYvYD1mMXS5JPVZ8ugPzoaRveH8ot5ROJHEYhdVda4fmTjt/+APiHLFI6yZ6rI79rlhbF1g/vnDmdD/iNt0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4571.namprd13.prod.outlook.com (2603:10b6:610:c0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8; Mon, 28 Jun
 2021 22:06:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05%4]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 22:06:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>
Subject: Re: client's caching of server-side capabilities
Thread-Topic: client's caching of server-side capabilities
Thread-Index: AQHXbFuMjtq3PRTcuEmeUcYpGr/LhKsp+uuA
Date:   Mon, 28 Jun 2021 22:06:18 +0000
Message-ID: <81154dc28d528402bf5e090a81e6892c7abc431c.camel@hammerspace.com>
References: <CAN-5tyEuB5C9u+xZ5L47fSQ9cwZnsbhJuBs+gybU2A-jzAkfog@mail.gmail.com>
In-Reply-To: <CAN-5tyEuB5C9u+xZ5L47fSQ9cwZnsbhJuBs+gybU2A-jzAkfog@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec4fd4c1-2962-4de2-e814-08d93a80f4f6
x-ms-traffictypediagnostic: CH0PR13MB4571:
x-microsoft-antispam-prvs: <CH0PR13MB45717D0E2CA0BDBC2B1F0E9DB8039@CH0PR13MB4571.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oCLjiZ/8Oe4M5++ljxoFqMOVZSjBE8zeYdijEEAo4bWKD21mO7tTQ42IEl0WEszdsm2sH4J348e4R9Fyo6mM5vdeukp0bQ7Wk2GoPUwPq0KJ9wRT2OY+g8U7HOyEers6Q7sbLKCsdZ4wyXfHnt//4xsij5ohyA4XDsvfDJddeCTe3T5zD24LavyBXJITykAFrUgilpX8DXLrgqVItsQAJXZbGqEf49rvJJVPbq63riSiYC2Cnj8hMMbCS/aAe+lwHtaVC+B5SMpD0AYNB9scTERLLXipuyorCcIeb/bn1+RBcNqoRCD1vJVI44yoiRou1MqVtx5i/+haz70karfPUNT2XOzbk/E2FzBChjP0OaK1yljNTPDYhXXaawaDQ78PJWJpZRM1Ge1DgULZTcBiNni4uLLgK9NpS3edCDExkOTkql2ENFknI9Xzsx+9L0/NQ4vRFY2L/WJmhc5MndUSBusAHdu5LRZRbNfJ9ICxJmc+ax0XsQVjxP8lEEv4s3L4sHgUTzPgjy2f6XocrQ7ynKbIqkOP1uqt95ks7cfdYDE1LVQeKjOGYknAKEWpeBHenNCZqS1N9nKyn3MT+4DSEGPUdeXR8tYu7A4++y6rCsVaHMsXtpoby0vPMVQrF23xLabzWLPNUYs7SffRhVuCxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(376002)(39830400003)(6486002)(8676002)(316002)(6506007)(110136005)(8936002)(26005)(186003)(2616005)(478600001)(6512007)(76116006)(36756003)(66476007)(66556008)(5660300002)(83380400001)(2906002)(86362001)(66946007)(71200400001)(64756008)(66446008)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y05ZL1ZaUjR4Z3JsMmN5M2h6bEpLZ2hNRjI1MWl5ZnZGamZGZWd0WGtDaUVU?=
 =?utf-8?B?dXo1TkNub2F5NE5tS0w1MVhtTkpmZ2lzNUs0Z2NDdjFvYnkwYXJiTGlueVhz?=
 =?utf-8?B?bmw2ZGI1NXBRS1JaRnBFR2pmeHlYS3JSTFd6QVludjV6ZkVpaG5Va3ZqSWpz?=
 =?utf-8?B?akNNdEV0WGoxT2c2UytnY0FzR2pROFZvUlM5L0FTZDNaT0xlUW9XQ0ErWVFy?=
 =?utf-8?B?a05IeWlmeUZFdG9WbzhhRDVkb3YyN3ZOd2t4Vzl1QkV1UFBieTFMc2Ywem54?=
 =?utf-8?B?a1pQNzRRcElPZzdwd3Z0dVpqTnNUUnNiY2JMUFkzOHRJQW9HUTBmZUpCWjBH?=
 =?utf-8?B?ZGkvWVRmMGR0QW5CWUNtQmNZWlhrVkFyWXhYZUk5VkFPS0FNRjJ3dCtWOE8y?=
 =?utf-8?B?QnhYcjA2NGdKVjkyYmVnOWJjK1NFNjdYY3hvcmdYR3B3RHV5VnJpaWlmV05n?=
 =?utf-8?B?RDR6bzdpdzdMR1N3M3JTZmU5UWV6UExHVDRUTGkyUkc4OWhFNHQ1UHJ5NXpC?=
 =?utf-8?B?d1VmVURaZnFXelVSMDFkcTQyNEZUeWtkUnJQZFhUMjM5KzVTOVRRYU81NVR3?=
 =?utf-8?B?U1JBMU45TDRjYW1JMkZma3MzR2g0amh4b2hRclQxaFA3aFN6bUNRbHBkS3Ni?=
 =?utf-8?B?NmI0RXdSTmlVRXZ4d2lad1Q3NWJWQTZyZGh1SGNXNEtSaFJFc3BPOHFoYXlX?=
 =?utf-8?B?T2xsenFvZnIwM20xU2tFN2NpTDFRWEQxVWFYcUFCSDBVRTNGcUVVc3REUEQ3?=
 =?utf-8?B?UCtpbG5hbTh1UEJ1bTREL1VXL2htU3VoZUFScE5WZGo1NUxITkdXVVdaaWRH?=
 =?utf-8?B?M1RVdDZTYzE4VXg5NExOcU9YMHd6NTN6dDMrL3ZUcUw1cUZYbDkxVGVkOE02?=
 =?utf-8?B?R2JobHNlZm1KaDBMZXJqQzhWaHZUQzlndzlDU0dMQ0pjdnFndm0yZ3hRZC8w?=
 =?utf-8?B?cUhZZGpEdGVEcW0xdlZzcmdoSHlZRllwVHJldHQybGc5MFBXMWoxTVFySE5C?=
 =?utf-8?B?ZjlveTZYUHZKcFBBcWdlc3B2eEtXSXRObEduWmdac2Q1TTBWTmUyN3BCaEhR?=
 =?utf-8?B?amoycUVReGFZLzVtNzFXRFlSb0ZESWROdDdoTXZSS2VBRUxHSFY5Z1BlVVlL?=
 =?utf-8?B?ZUoyT2tsN1ZlOTBuckN4a1ZtQnJYUjMvSGFQKy90MjFuWXpKODFNZ0ozWDEz?=
 =?utf-8?B?eFR2ZzczTmFkMnVVb1o1WGl2ejM5dDdVN3BQeXRqNURuOGxvVytVNGZCVlBW?=
 =?utf-8?B?OWRDYzU4MHkwcHZ3SXhYNFpITmp6dUhIQXcrTjZ3MzVoRFppSmxRR3dJUFQ0?=
 =?utf-8?B?OGtGV3ZiTHRYQjFMWjkxVitRaVQ2K3p5aVp4Z3FRaWhXMEkrbU80TU9WNW1k?=
 =?utf-8?B?L0YwOGlOUmZ1UFhSMy9MRXFvbzVMczZtMGNsakRjUWlZVUFsS2VQMktKZmhr?=
 =?utf-8?B?L044T0xwa1AzVXF3Y3FyRkpnVmcwRUFwSkYzZlpnK0VPdEJhc3o5KzFmQXpn?=
 =?utf-8?B?MXZXYU9LK2thMGZlWE5wNkJxLzdRV1ZqZUo3dVFKNU5lRVlHaU1hSkxJaWU0?=
 =?utf-8?B?T3JjWEl1dEVGdHRIQ21ZSlRDWGQ5TVBjMjlFTWd1L2c3aDRXbUkxYUpSbjFB?=
 =?utf-8?B?ampBRFg3N3g1QU1xRFJBNVl1OWV5RmVTa3ZlNjNuZ2YzTUdaV2c0ai9FVnRv?=
 =?utf-8?B?SURuREplNW0xVG1LNTliMjEvRGh0d05hTmNJNCtuZlhmc0pBT2NoRVVEU1RI?=
 =?utf-8?Q?OdLQoCwVWHvkeX9wZps3mYEjIe4gk3y6RJdxpfQ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEDD813A3D0FB54E9FF749D0AC005095@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4fd4c1-2962-4de2-e814-08d93a80f4f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 22:06:18.8497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ewn64HWvUIlfutlDPfbKjPAtK9lBt1TMtuDsqgT7/Cw4VcFdmo5uJNrMeH409QjRCsFSICIMdkRH7dyftGhkvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4571
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTI4IGF0IDE2OjIzIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gSGkgZm9sa3MsDQo+IA0KPiBJIGhhdmUgYSBnZW5lcmFsIHF1ZXN0aW9uIG9mIHdoeSB0
aGUgY2xpZW50IGRvZXNuJ3QgdGhyb3cgYXdheSB0aGUNCj4gY2FjaGVkIHNlcnZlcidzIGNhcGFi
aWxpdGllcyBvbiBzZXJ2ZXIgcmVib290LiBTYXkgYSBjbGllbnQgbW91bnRlZCBhDQo+IHNlcnZl
ciB3aGVuIHRoZSBzZXJ2ZXIgZGlkbid0IHN1cHBvcnQgc2VjdXJpdHlfbGFiZWxzLCB0aGVuIHRo
ZQ0KPiBzZXJ2ZXINCj4gd2FzIHJlYm9vdGVkIGFuZCBzdXBwb3J0IHdhcyBlbmFibGVkLiBDbGll
bnQgcmUtZXN0YWJsaXNoZXMgaXRzDQo+IGNsaWVudGlkL3Nlc3Npb24sIHJlY292ZXJzIHN0YXRl
LCBidXQgYXNzdW1lcyBhbGwgdGhlIG9sZA0KPiBjYXBhYmlsaXRpZXMNCj4gYXBwbHkuIEEgcmVt
b3VudCBpcyByZXF1aXJlZCB0byBjbGVhciBvbGQvZmluZCBuZXcgY2FwYWJpbGl0aWVzLiBUaGUN
Cj4gb3Bwb3NpdGUgaXMgdHJ1ZSB0aGF0IGEgY2FwYWJpbGl0eSBjb3VsZCBiZSByZW1vdmVkIChi
dXQgSSdtIGFzc3VtaW5nDQo+IHRoYXQncyBhIGxlc3MgcHJhY3RpY2FsIGV4YW1wbGUpLg0KPiAN
Cj4gSSdtIGN1cmlvdXMgd2hhdCBhcmUgdGhlIHByb2JsZW1zIG9mIGNsZWFyaW5nIHNlcnZlciBj
YXBhYmlsaXRpZXMgYW5kDQo+IHJlZGlzY292ZXJpbmcgdGhlbSBvbiByZWJvb3Q/IElzIGl0IGJl
Y2F1c2UgYSBsb2NhbCBmaWxlc3lzdGVtIGNvdWxkDQo+IG5ldmVyIGhhdmUgaXRzIGF0dHJpYnV0
ZXMgY2hhbmdlZCBhbmQgdGh1cyBhIG5ldHdvcmsgZmlsZSBzeXN0ZW0NCj4gY2FuJ3QNCj4gZWl0
aGVyPw0KPiANCj4gVGhhbmsgeW91Lg0KDQpJbiBteSBvcGluaW9uLCB0aGUgY2xpZW50IHNob3Vs
ZCBhaW0gZm9yIHRoZSBhYnNvbHV0ZSBtaW5pbXVtIG92ZXJoZWFkDQpvbiBhIHNlcnZlciByZWJv
b3QuIFRoZSBnb2FsIHNob3VsZCBiZSB0byByZWNvdmVyIHN0YXRlIGFuZCBnZXQgSS9PDQpzdGFy
dGVkIGFnYWluIGFzIHF1aWNrbHkgYXMgcG9zc2libGUuIERldGVjdGlvbiBvZiBuZXcgZmVhdHVy
ZXMsIGV0Yw0KY2FuIHdhaXQgdW50aWwgdGhlIGNsaWVudCBuZWVkcyB0byByZXN0YXJ0Lg0KDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
