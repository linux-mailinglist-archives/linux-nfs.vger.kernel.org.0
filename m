Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB3B1B440F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2020 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgDVMML (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Apr 2020 08:12:11 -0400
Received: from mail-dm6nam12on2137.outbound.protection.outlook.com ([40.107.243.137]:7591
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbgDVMMK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 22 Apr 2020 08:12:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgSGcMkZOviZfakPH/Fu4Iwmvqdrl2Qtl+5AGd0BaheKRNxUSE2I0UOtijL4XKTVxvBhVqAE2Kt65yzoGJqT51CgGolbQ2JYilncOAVTl/FRxVatr8H+RrlkLhoDsdozEHPbWBFX+G81tM2ao99gCVIYy1jsHrrBIixRK01BI9szqzv3iPrQstSf7B+uknP5mCuj3CiPa8IfyXsJup4Rf8I9sFkqUuVHBEa1lmaplcOjVJgdmoXUQpujSiPKi/poBhLql5tL9BbTneLFiQYL1+2aHSArigyxbqEdjqKXZHC+wau2iIZGI4yKsk7tMu+zOFk2akTGaeDt7C6YRQ+4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdOkCrISjZmoqd9c7yNnt+XHr8HdRrHP9XgYAr1dn/M=;
 b=G/TaJ3ihIILx8ioxzvE+eX1Kgdzfo+2Xep6pox3cNnWla6DZb9FdZwWt4Sc03+kRbN0lYd5MJWJ/wYQyGuahTabZUi5Kqp3qgxT0mgrYOUn7Qy7X1oxfzHH3fYrV3kf0awT7OT2exG8rvHvkDgAFKYoXW800711ukwLMSm5VYSn43HydKOMO2gHvCil7HassHqmjZtGAyac5+7aNj3ZiwsenwfpScoUMZDTan+KIsDRVuJnhZqtiG/ygKA4b3OO2M3Rq2IF79NEr8oE/JBt/KeZPiLZgp4NfVVMKt+BFxBzWHxh6I43r0ly2cfr+Kv7QqZBH4Sl3g06JYw9M7KfnDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdOkCrISjZmoqd9c7yNnt+XHr8HdRrHP9XgYAr1dn/M=;
 b=HbUCFDjsLV0pYp6Pa4RpWbujb39lShVfcakNjT1HZeLTmGWai/lVDmG1WOEnOMs2cvzAEsKxbiJykSD4rZVjgQtprAjEb76EDF02QNzY03o8GsFIfHLU0USBGft5bWpfmpMobXQLsvAJP34uqlDVZCiY55RXdhPYEY041AJAVco=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3576.namprd13.prod.outlook.com (2603:10b6:610:27::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6; Wed, 22 Apr
 2020 12:12:08 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 12:12:08 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "teroincn@gmail.com" <teroincn@gmail.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [BUG] fs: nsf: does there exist a memleak in function
 nfs4_run_open_task?
Thread-Topic: [BUG] fs: nsf: does there exist a memleak in function
 nfs4_run_open_task?
Thread-Index: AQHWGFDKBBhMuVYBaUOy/K08wFwHd6iFDdgA
Date:   Wed, 22 Apr 2020 12:12:08 +0000
Message-ID: <997651b82c2657b7818f00f2bcfdc009ef6b723a.camel@hammerspace.com>
References: <CANTwqXDJi1LuT1Q382R6qFHm7qMqx6My6aCR0pejNR8BqzFLKg@mail.gmail.com>
In-Reply-To: <CANTwqXDJi1LuT1Q382R6qFHm7qMqx6My6aCR0pejNR8BqzFLKg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67e1467e-633f-456b-cd4e-08d7e6b66105
x-ms-traffictypediagnostic: CH2PR13MB3576:
x-microsoft-antispam-prvs: <CH2PR13MB35766D67C8263102A4BB12E1B8D20@CH2PR13MB3576.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(366004)(376002)(26005)(4326008)(5660300002)(508600001)(966005)(2906002)(86362001)(36756003)(110136005)(6512007)(71200400001)(2616005)(186003)(66476007)(6486002)(8936002)(91956017)(81156014)(66946007)(6506007)(8676002)(76116006)(66556008)(66446008)(64756008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y8AqR3edCbXjXgHfyjcjSICuu0fQNg9EMaYx60kr7cFbyPiJ+DMm1evqc/X0r3M8OYJ7gqIR38DrwaLLJeCHM7ed+WVEjkVdv7A+4LEzC/hqjM/2/1T4trGYTcSHFUVEw8mV46SRHktNZDVw3woVVQwtyvzhDGtzqv/Q9sLGPHO0asUZRKK//od25KAHu4aNJ9nCu6PBFHTZYIKvdvvrjtOxXVwLdSFL0tOca17GIjRPPSq1oK9QhPQUQLnltXr64Vat7uafJHRd60MDfexj4oBjDaAHiwPnsBGMvuZnrBnExaHqQTAD8eVPgsBvWUOnqC+VtwkdvZTk4YHxTr3y+gmJXVJd86Kt3sRDnR+/1D3AIlvcuxB9OKfQVDJhKKosBSuz5AeufWrvxfEYuo4wfU4oHNw/QTilhHQA0b0UkqwUcfDCNxO4IKF6MfgfhHRAMkLPiDZj2EUp81eyempgSQTsOvD5rf5+oBrJH6ZZ0CJpxPE8HrvFhJ9pJE//oftWw66p+LQkgxTiwVosg9a2eg==
x-ms-exchange-antispam-messagedata: VfAo7oo9SVtaqE4DxhlaQWnEXD79u2rzpM+skhAqfljKxSNQh95I75m1elaBTLqNwbPB4ShbRy6XSlZWbxk/h0sQY5QSckXBWxZj5sgWOyswDqFXprvBy3n/zHl1VHV23AdR9B4GCRdgBgn1wWnADnsL3gaDrsmnWxbL8zNm6rthrcQ+jdYA5XJjDLxJppxLfK+mVuXt9dK7slZSnHuzOEKgk3CKUwfBvrwB9h66LnxXr5Kc7cAjs64ZT4CehlXYAdx7zppasC5wENDytt7ym56/OkSB3B5x3xhvgnoyyXRrEtgZbJtITuZBTjkgTd2xW6F/6QJTIQ88RtBoGxRfxzK3EZpf2HDxUUtxHy1hMEYOqp5EXY3lnHMQVQW4T+UKvGNWQFzX2Sne8p9lkj61MVC4a2LG8fOveNEWkjSDlAx4cs3avRpo7niUnbxb4tPjmY98AsuINPd/aS1bFGtgulkAZFcLUHh1DPVOkAqW5ZvKZwpXA4wvI95en1Zz16/3zll+tCToQPDuFvso2HS9Tp0VJOUv1xKqp83K2gida4OCQpZTusWaZ+XB2owW5la1UzVdYvU7KqMUqAZQ7met7WsSYTOFm578I+w77prMf2v7BPJpuqI7E6fQwpUAYSed/yAQl1soMuA7pw1MNnJzDLXUBv2sOiRfLZRhLOZr5uYQg/+WtcmNZIE1kWm4WourvGSU83Q+aCjdSoXJINE80BnBLYaLq5qexfa4fsYdQBailDMP+Ij/YBCHPNFsbbwfrj1EU8OgcRpHKclzRj7Azk9P79E3NPFcM5d/HtssjHc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <67AC41FE8E7A8A448F5A138ABFCB551C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e1467e-633f-456b-cd4e-08d7e6b66105
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 12:12:08.0831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPbWEArR4v4/4okfmgNIz1KhvMIfY8/ztD6BSL9EXm4sITtnxozFbYVVCENXo31i8eRkXbIyOmSVuTq/6UyD1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3576
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTA0LTIyIGF0IDEwOjUwICswODAwLCDkur/kuIAgd3JvdGU6DQo+IEhpLCBh
bGw6DQo+IFdoZW4gcmV2aWV3aW5nIHRoZSBjb2RlIG9mICBuZnM0X3J1bl9vcGVuX3Rhc2ssIGlm
IHRoZSBycGNfdGFzayBzdGFydA0KPiBmYWlsZWQsIHRoZSBvcGVuZGF0YSByZWZlcmVuY2UgaGVs
ZCBmcm9tIGtyZWZfZ2V0IHdvdWxkIG5vdCBiZQ0KPiByZWxlYXNlZCBldmVuIHJldHVybiB0byB1
cHBlciBjYWxsZXJzLg0KPiBJJ20gd29uZGVyIHRoYXQgZG9lcyAgdGhlcmUgbGVhayB0aGUgb3Bl
bmRhdGE/DQo+IA0KPiBzdGF0aWMgaW50IG5mczRfcnVuX29wZW5fdGFzayhzdHJ1Y3QgbmZzNF9v
cGVuZGF0YSAqZGF0YSwgaW50DQo+IGlzcmVjb3ZlcikNCj4gew0KPiAgICAgICAuLi4NCj4gICAg
ICAgc3RydWN0IHJwY190YXNrX3NldHVwIHRhc2tfc2V0dXBfZGF0YSA9IHsNCj4gICAgICAgLi4u
DQo+IC4gICAgIGNhbGxiYWNrX29wcyA9ICZuZnM0X29wZW5fb3BzLA0KPiAuICAgICBjYWxsYmFj
a19kYXRhID0gZGF0YSwNCj4gICAgICAgLi4uDQo+ICAgICAgIH07DQo+ICAgICAgIGludCBzdGF0
dXM7DQo+IA0KPiAgICAgICBuZnM0X2luaXRfc2VxdWVuY2UoJm9fYXJnLT5zZXFfYXJncywgJm9f
cmVzLT5zZXFfcmVzLCAxKTsNCj4gICAgICAga3JlZl9nZXQoJmRhdGEtPmtyZWYpOw0KPiAgICAg
ICAuLi4NCj4gDQo+ICAgICAgdGFzayA9IHJwY19ydW5fdGFzaygmdGFza19zZXR1cF9kYXRhKTsN
Cj4gICAgICBpZiAoSVNfRVJSKHRhc2spKQ0KPiAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUih0
YXNrKTsNCj4gICAgICBzdGF0dXMgPSBycGNfd2FpdF9mb3JfY29tcGxldGlvbl90YXNrKHRhc2sp
Ow0KPiAgICAgaWYgKHN0YXR1cyAhPSAwKSB7DQo+ICAgICAgICAgICAgZGF0YS0+Y2FuY2VsbGVk
ID0gdHJ1ZTsNCj4gICAgICAgICAgICBzbXBfd21iKCk7DQo+ICAgICAgfSBlbHNlDQo+ICAgICAg
ICAgICBzdGF0dXMgPSBkYXRhLT5ycGNfc3RhdHVzOw0KPiAgICAgIHJwY19wdXRfdGFzayh0YXNr
KTsNCj4gDQo+ICAgICAgcmV0dXJuIHN0YXR1czsNCj4gfQ0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiANCg0KUGxlYXNlIHNlZSBjb21taXQgNjJiMjQxN2U4NGJhICgNCmh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQv
P2lkPTYyYjI0MTdlODRiYQ0KKQ0KDQpUaGFua3MNCiAgVHJvbmQNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
