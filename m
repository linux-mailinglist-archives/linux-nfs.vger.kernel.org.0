Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3FB1D561E
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2020 18:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgEOQcy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 May 2020 12:32:54 -0400
Received: from mail-bn7nam10on2095.outbound.protection.outlook.com ([40.107.92.95]:27872
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbgEOQcx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 15 May 2020 12:32:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDhyRPnJPKTXg1qx/Hzn/8J2/a3QvDKeDlz1iSSNaS8RiqfrwDUI5TSBCQz2mKsJldd/SfPJBBM2UGDdkeqp2th9QaVGTBCdrL2kfcQptDCwGJji3Ko+uTzcjxoKKIlYBMzl4HcNbwm0fyBbUE8QGPJaJ2l2WFAQCptRf61nHe/bOwf3d78OlH5mwtNzSZ3rboGDyiOToZumpD8KO54aMTjQqDVO2sRw78P2TP+GVYSoH28iNplU2/AfaRD8mtuGnCCH+3pubMExG2etqbtxnGnvNguVEgFr7wr1oMQrcVa8U9mtJ3Tk21UM/KOVNdXydLC/A83fn223H5hmZ9BR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bePDDC1xR4e6ZkFo3mviXB6MsHArYFru8BVKiHaLDts=;
 b=FhQBdD3JPEhnH1RX1kCRtNv99B9tGjUH299MSmz346liWYqwBjfEy4c1Mh8+LJnf7QfsMcAg7uOzNTghf1FU0h/hlXpKTJGzx/EUDkZMw2FF2dy9A8Qjlt5g5LcDTgZFn4S7m3M3tuylAwTtCebQ2zHGtR4dk3YascQx1i525jjRJt/C5HxFRNivY30eZuY2QXFYSrUucf9ZJytmiGZx3vyiiAFMZiNI1ltZ0ALR9H6w0wu7R1YEMNUmULrzjS1dV9+htdQDRsy8PUyv8ENuJuJBZat6fgzBiCKqXwZtMwzDBEdf1gRyW9kwE83Jf8wTLEg8uKu6w2PlulbFOLIo6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bePDDC1xR4e6ZkFo3mviXB6MsHArYFru8BVKiHaLDts=;
 b=fcT32BXR7tbJPvigDFTMHkhWZeqi7gxU/cuFdwG3FgGmAE1vT5B0G6X033UEY3l680ecwddyvYh6ZEjXJCRiFcNpXPVnjW2G87n8dOQ6W/eEdpKjgCaXTq/KmGC3GTESvMN4oZvJeqIyP24cxfJ7OjzdcxEIIkaSI63JmzzGH4c=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3350.namprd13.prod.outlook.com (2603:10b6:610:27::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.17; Fri, 15 May
 2020 16:32:50 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.3021.010; Fri, 15 May 2020
 16:32:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: linux-next: Tree for May 15 (nfs/fsinfo.c)
Thread-Topic: linux-next: Tree for May 15 (nfs/fsinfo.c)
Thread-Index: AQHWKs10cNVAkOG0JEGfeV/Heq6q16ipV1UA
Date:   Fri, 15 May 2020 16:32:49 +0000
Message-ID: <ef6274c2de9fcc2e1820db1ac8f0b7602a9fe6b0.camel@hammerspace.com>
References: <20200515224219.48a50b28@canb.auug.org.au>
         <129e8dee-76c3-ba9d-e692-d145653bbaaa@infradead.org>
In-Reply-To: <129e8dee-76c3-ba9d-e692-d145653bbaaa@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canb.auug.org.au; dkim=none (message not signed)
 header.d=none;canb.auug.org.au; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09e10ad4-c08d-4e90-0794-08d7f8ed9bbe
x-ms-traffictypediagnostic: CH2PR13MB3350:
x-microsoft-antispam-prvs: <CH2PR13MB3350994C344CA0139FD1FF59B8BD0@CH2PR13MB3350.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /cQlXk+SA8vYvePilG02PwOiklmJSp2UAMNxW73MOwoRZtgJq+XmwG6T4zB/uUkv07tmphH0fwA7UzsI2tn7LZqzHeOoLNo65gN64SGM4WZZtf1ABHNcItmkYFsLmEN8KsGGKW/Tz/6r5DPF3tgZFwsS6kkeo1yK0G40Phcp1CJ8p9tKakYKXElxU9cES3k27z6dDH9nAomBcvjiCjkCwg9rXkfrNIwnfI2cz0kfrBV+BvO0VrpWbRRH1liGR4duP/FbiOW6muPqHGg8fMWfhYMWH4zBRVyTS4O/NMSsGK+KeH2Y+nJGBJ4lROuxEnDfAIly0NbuA7mk83RZq3p4+XVD9MQsUvxbadrZRq85VXjB8BOPIUS8rs96EfHQIB4+ud/90ZrTfw4JAeig4/QQecUPiUKQSnPZx1xA6Xl6jEz4MiCa240Dj07Gathc8uxS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(366004)(346002)(376002)(136003)(396003)(186003)(6512007)(5660300002)(4326008)(110136005)(54906003)(64756008)(66946007)(76116006)(478600001)(66446008)(66556008)(66476007)(316002)(6486002)(26005)(36756003)(2906002)(8936002)(8676002)(2616005)(53546011)(86362001)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: u2GpYBL/d52xYhd/fr1HgKQHPLq1Hv6bZCoISKdpRxl/8Rf53Rsxz1Qc1OauUnIqJLCsukeCu8PacU4xCGOOeNbLK0dKN1GZoHeU4msnUEFwZRrMuaXN8wIeWUw8UaoGTij8gLyXiuIPEZf+0tjWWBrq3BQRVPx/ua3EJJMHgmIbMCbs+n/6ARCCZdhnl6y36sXNu/EdAmTbx8T+TMEl8XLKEpFpTRMJvLd6FuqjOQbY4vizqDT4W5GdXZwxDtGNsdilFUcofSFzDbkQHa/wZsyVOKn1t5vtQXj+EBI6JHVw/dt2KrOVGBOFf3q4va7fQDqgDNIFwWiJRMN+Xao4RXxVvErJSNQ4WLFy+wPUsw6aSwUx85HX7k417Z5wtyNhJVJHhyW26LDrvWkNjtN/GY2m+gODaXgYyYZLd1n8l5vtay7zMXt+pqKL6I64nQxarAT6LyvKWvneHZzr6jMQ9YnRsjwUhnk+cTsG3E3/M1U=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1356FE35E73C74E9D188775D10C6374@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e10ad4-c08d-4e90-0794-08d7f8ed9bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 16:32:49.9034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61iNPDhHMpMpeKl/VY2La8etG5a79lmRIHh1UnqTR3D2H4DH+UOw3gE56/8dUMQXLVKRPVf3RmRo0Tu7rKcJVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3350
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgUmFuZHksDQoNCk9uIEZyaSwgMjAyMC0wNS0xNSBhdCAwODoyOCAtMDcwMCwgUmFuZHkgRHVu
bGFwIHdyb3RlOg0KPiBPbiA1LzE1LzIwIDU6NDIgQU0sIFN0ZXBoZW4gUm90aHdlbGwgd3JvdGU6
DQo+ID4gSGkgYWxsLA0KPiA+IA0KPiA+IENoYW5nZXMgc2luY2UgMjAyMDA1MTQ6DQo+ID4gDQo+
ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4gPiAtLS0tLS0tLS0tLQ0KPiANCj4gb24gaTM4NjoNCj4gDQo+ICAgQ0Mg
ICAgICBmcy9uZnMvZnNpbmZvLm8NCj4gLi4vZnMvbmZzL2ZzaW5mby5jOiBJbiBmdW5jdGlvbiDi
gJhuZnNfZnNpbmZvX2dldF9zdXBwb3J0c+KAmToNCj4gLi4vZnMvbmZzL2ZzaW5mby5jOjE1Mzox
MjogZXJyb3I6IOKAmGNvbnN0IHN0cnVjdCBuZnNfc2VydmVy4oCZIGhhcyBubw0KPiBtZW1iZXIg
bmFtZWQg4oCYYXR0cl9iaXRtYXNr4oCZDQo+ICAgaWYgKHNlcnZlci0+YXR0cl9iaXRtYXNrWzBd
ICYgRkFUVFI0X1dPUkQwX1NJWkUpDQo+ICAgICAgICAgICAgIF5+DQo+IC4uL2ZzL25mcy9mc2lu
Zm8uYzoxNTU6MTI6IGVycm9yOiDigJhjb25zdCBzdHJ1Y3QgbmZzX3NlcnZlcuKAmSBoYXMgbm8N
Cj4gbWVtYmVyIG5hbWVkIOKAmGF0dHJfYml0bWFza+KAmQ0KPiAgIGlmIChzZXJ2ZXItPmF0dHJf
Yml0bWFza1sxXSAmIEZBVFRSNF9XT1JEMV9OVU1MSU5LUykNCj4gICAgICAgICAgICAgXn4NCj4g
Li4vZnMvbmZzL2ZzaW5mby5jOjE1ODoxMjogZXJyb3I6IOKAmGNvbnN0IHN0cnVjdCBuZnNfc2Vy
dmVy4oCZIGhhcyBubw0KPiBtZW1iZXIgbmFtZWQg4oCYYXR0cl9iaXRtYXNr4oCZDQo+ICAgaWYg
KHNlcnZlci0+YXR0cl9iaXRtYXNrWzBdICYgRkFUVFI0X1dPUkQwX0FSQ0hJVkUpDQo+ICAgICAg
ICAgICAgIF5+DQo+IC4uL2ZzL25mcy9mc2luZm8uYzoxNjA6MTI6IGVycm9yOiDigJhjb25zdCBz
dHJ1Y3QgbmZzX3NlcnZlcuKAmSBoYXMgbm8NCj4gbWVtYmVyIG5hbWVkIOKAmGF0dHJfYml0bWFz
a+KAmQ0KPiAgIGlmIChzZXJ2ZXItPmF0dHJfYml0bWFza1swXSAmIEZBVFRSNF9XT1JEMF9ISURE
RU4pDQo+ICAgICAgICAgICAgIF5+DQo+IC4uL2ZzL25mcy9mc2luZm8uYzoxNjI6MTI6IGVycm9y
OiDigJhjb25zdCBzdHJ1Y3QgbmZzX3NlcnZlcuKAmSBoYXMgbm8NCj4gbWVtYmVyIG5hbWVkIOKA
mGF0dHJfYml0bWFza+KAmQ0KPiAgIGlmIChzZXJ2ZXItPmF0dHJfYml0bWFza1sxXSAmIEZBVFRS
NF9XT1JEMV9TWVNURU0pDQo+ICAgICAgICAgICAgIF5+DQo+IC4uL2ZzL25mcy9mc2luZm8uYzog
SW4gZnVuY3Rpb24g4oCYbmZzX2ZzaW5mb19nZXRfZmVhdHVyZXPigJk6DQo+IC4uL2ZzL25mcy9m
c2luZm8uYzoyMDU6MTI6IGVycm9yOiDigJhjb25zdCBzdHJ1Y3QgbmZzX3NlcnZlcuKAmSBoYXMg
bm8NCj4gbWVtYmVyIG5hbWVkIOKAmGF0dHJfYml0bWFza+KAmQ0KPiAgIGlmIChzZXJ2ZXItPmF0
dHJfYml0bWFza1swXSAmIEZBVFRSNF9XT1JEMF9DQVNFX0lOU0VOU0lUSVZFKQ0KPiAgICAgICAg
ICAgICBefg0KPiAuLi9mcy9uZnMvZnNpbmZvLmM6MjA3OjEzOiBlcnJvcjog4oCYY29uc3Qgc3Ry
dWN0IG5mc19zZXJ2ZXLigJkgaGFzIG5vDQo+IG1lbWJlciBuYW1lZCDigJhhdHRyX2JpdG1hc2vi
gJkNCj4gICBpZiAoKHNlcnZlci0+YXR0cl9iaXRtYXNrWzBdICYgRkFUVFI0X1dPUkQwX0FSQ0hJ
VkUpIHx8DQo+ICAgICAgICAgICAgICBefg0KPiAuLi9mcy9uZnMvZnNpbmZvLmM6MjA4OjEzOiBl
cnJvcjog4oCYY29uc3Qgc3RydWN0IG5mc19zZXJ2ZXLigJkgaGFzIG5vDQo+IG1lbWJlciBuYW1l
ZCDigJhhdHRyX2JpdG1hc2vigJkNCj4gICAgICAgKHNlcnZlci0+YXR0cl9iaXRtYXNrWzBdICYg
RkFUVFI0X1dPUkQwX0hJRERFTikgfHwNCj4gICAgICAgICAgICAgIF5+DQo+IC4uL2ZzL25mcy9m
c2luZm8uYzoyMDk6MTM6IGVycm9yOiDigJhjb25zdCBzdHJ1Y3QgbmZzX3NlcnZlcuKAmSBoYXMg
bm8NCj4gbWVtYmVyIG5hbWVkIOKAmGF0dHJfYml0bWFza+KAmQ0KPiAgICAgICAoc2VydmVyLT5h
dHRyX2JpdG1hc2tbMV0gJiBGQVRUUjRfV09SRDFfU1lTVEVNKSkNCj4gICAgICAgICAgICAgIF5+
DQo+IA0KPiBGdWxsIHJhbmRjb25maWcgZmlsZSBpcyBhdHRhY2hlZC4NCj4gDQoNCldoZXJlIGlz
IHRoaXMgZmlsZSBjb21pbmcgZnJvbT8gSSdtIG5vdCBhd2FyZSBvZiBhbnkgZnMvbmZzL2ZzaW5m
by5jIGluDQp0aGUgY3VycmVudCB0cmVlIG9yIGluIG15IGxpbnV4LW5leHQgZm9yIDUuNywgYW5k
IGEgY3Vyc29yeSBnbGFuY2UgaXMNCnNob3dpbmcgaXQgdXAgaW4gQW5uYSdzIGxpbnV4LW5leHQg
Zm9yIHRoZSA1LjggbWVyZ2Ugd2luZG93Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
