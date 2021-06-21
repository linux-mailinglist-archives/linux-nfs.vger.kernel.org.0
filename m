Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85B63AF403
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jun 2021 20:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhFUSGK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Jun 2021 14:06:10 -0400
Received: from mail-mw2nam10on2133.outbound.protection.outlook.com ([40.107.94.133]:41697
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232027AbhFUSCY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 21 Jun 2021 14:02:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQVJ3jUh9fcJM5YPVaWMakOlec4hR6Oj3JxVuG/LwYcuD/f0QVx5d+yEX4W9H6GRfbLzu/ncpyjrk9j3/p1gwyOG9uNgMn6krK/fxR5Xo3BFuYswMNBUMUU2H5wj31sHPCtQ+0WdkgYFKEfdp9aHtbHW6huE33lDvQPc/3YkerTyUGsG/l91/EsLsJESJmLPC1p+d6G3diXqgGARA8Bf+WkASM8vQf+xGo86A2fdSciFMwUaZpgNdi8doVDiJ6DNb2B2vNCerF71QZSVN/hKSaSc5qaKnMkczrYlISyAmqX5OMJEPngYoRBHA87YPkB/Q9MIEF8zSRKvMK1J6Y00kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txsiuk0GoNhicXlCSThozF4E7cdjOzphJfzi3WvAmgQ=;
 b=d/su9IzlZhsBrM8MK5EWHyQHicStD7bdYzONkt9FIn6cjm48wTZJAm8nyz5ACy/ZfqilixTsTqqp+NEJmAEvs3etylcDBzs1zFB5gwxTXv3CK9CFuIfqPzbBm6ki1u9M4dUaIGZe+cKZJnGtw+D91szvuFDsjaRoZjFRLpTVjrZmNsfm1TFZoeBTOsUkqJ37yDmgVSTZZOPQyFEdX6XE8Ortjh00/CdN6K0MI3ikTSE03i3C6uuN4FrsLallVFpkqyZuvv/IB1l/hCpBbKBhEHmClq5GUlnqJ55WAeS+ZeXpvejuWGxkcBRXut+WgLGj9kMHwv6KIfIUYCKvqZqlyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txsiuk0GoNhicXlCSThozF4E7cdjOzphJfzi3WvAmgQ=;
 b=Xm6qW1QGHdP7hpPls+NXCkrKNtTJMEa1lOm3P8TnIesPU96drfNkf3mBBCmjnPFN+q/TA4Bn/BxkaUgKynAODmZ261n18HqugSe2fb1+nvCHEFQArtoaGBmR6wxIcCOImD42vEbz88Tq4Amii+KRmjWD2jVF3saqOImpLBlV3lM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3383.namprd13.prod.outlook.com (2603:10b6:610:14::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7; Mon, 21 Jun
 2021 18:00:06 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05%4]) with mapi id 15.20.4264.017; Mon, 21 Jun 2021
 18:00:06 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH] nfsd: Reduce contention for the nfsd_file nf_rwsem
Thread-Topic: [PATCH] nfsd: Reduce contention for the nfsd_file nf_rwsem
Thread-Index: AQHXY9BFOPrj5d3Km06dLrDzFdiFU6sesysAgAATu4A=
Date:   Mon, 21 Jun 2021 18:00:06 +0000
Message-ID: <ff7400e35ec0b227de4546c608d231caed921d5b.camel@hammerspace.com>
References: <20210617232652.264884-1-trondmy@kernel.org>
         <1669C849-D7DC-46C1-B6B6-F2C79C819710@oracle.com>
In-Reply-To: <1669C849-D7DC-46C1-B6B6-F2C79C819710@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94f1496e-608f-4b14-a6cb-08d934de6718
x-ms-traffictypediagnostic: CH2PR13MB3383:
x-microsoft-antispam-prvs: <CH2PR13MB3383031EB2994E9E423FBDD0B80A9@CH2PR13MB3383.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oKw26h6VaJ5teVqptWwRKt+80C/JqlD+OKPg/fkrtFTq+OQuDYsETDzKMoA5EnvYbl7ITJ9QGrjnVS0zDseuaZmDiP0kTFEbbfAbaS8YRR4UN0/qoBtSEewbYVyKz+AjpqV/BaoJgQGyE2u+ABeQ+ifznpFc25UvHLcSq5bAdHdjtv8MkYiYCvQdz6nJ7RfPBQdxXFpZalfyHv2fBpp1c/5/zZvGSISYJsJr9wuhks2BfeRl7U2Eq5iSQkR/9h/nJ9qd7t+do+QqV6Wzlb5ZdF6l+dBIkJHvDQeF1qY6rtOujTz+JvuWHjtykQWQBrAQ+bs1nUgcz/2sbCgzWJdIBwN9Hpnpr/Z6qt/jBXoumLmYgUkYRkhIBGeo6ulet2cnjE3z/e+wD6inJtvtTdg8ykp+KHHa4on8RnKSSaPYszL/oCzqPv2mxzGV2Yr+EA593VzG+/69/99Qt2qZdBwgejAkcIuYbhwlpgDyYcxgT92u2ydo6c6yn5Rc1siXlXz0EnUNaVy/NxJbnogjco6viAMl5qxZ6uO6JQ1YBKgOJfaGOzuizM7wd+JAmGiR+xhWZbfy+p50bvspVcBxvJBVCnh6apoHMgNOp+N7B++8vf4WlOUhyMkvaVzkFeOQKxfCtjx5gbtB5oEsEi3LPoXRLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(366004)(376002)(346002)(136003)(26005)(71200400001)(8676002)(38100700002)(122000001)(316002)(83380400001)(5660300002)(4326008)(2906002)(54906003)(76116006)(36756003)(66946007)(110136005)(6486002)(66476007)(8936002)(2616005)(53546011)(186003)(66556008)(6512007)(6506007)(86362001)(64756008)(66446008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTBGOEJtZ2ZCMFpkRUtDOEZaZTM2TE9CZ0hmcE4wc2l3Z1hnbnllMkIzU1Er?=
 =?utf-8?B?blhSYyt4RHljSkRRbHM1R045QjJ0NkI1TUZRbHVoaUdPcyt1cTlyZHV5ZnNa?=
 =?utf-8?B?KytEYTdZRlBUbHByUkdwNFBwekhoWGhJYVcyMTYrQndSTUYwUEJJVEtpVkp6?=
 =?utf-8?B?RUcrRFB5UThHdlAxSzkzN3B1c3lrcnFJdkR3citnTytKU0VvSVVOcXZxMTZN?=
 =?utf-8?B?aEhwbGpXNmZKaUtiSjM5ZmEyNk42Vkp2ZDZ6V2lyOStWeVRUZi81Uitzazly?=
 =?utf-8?B?OVFCbDZQVHUzVWVEQ0tOQlg1RGJONVFYdkg4ODZTbVhZQTJybnJoVXoweEpP?=
 =?utf-8?B?K0FDd2ZKK21wbjQ3UXh3MzBFZzY5NURMTWRhL1dUdDY4b0VBN3dFQ3U5TGtI?=
 =?utf-8?B?bkhGcE9acG9jc2pGbkpzREJUdzVwSnpGcVkyMFdDQ0dFT2ZJZTE0blFqamtI?=
 =?utf-8?B?VDhTeFp2SHRkY0IwVU43amVXRmxieUlBNS9najZvZi9aZVkwbWEvVWxMcjdh?=
 =?utf-8?B?NEt6bWlyUHBKWmRFVkZvRjVVVWw3RUFLbkkyVFR1RUJRVGg5ME5FZmppVTNV?=
 =?utf-8?B?Qlhxekp6dFArZld4eWpQYzB1VTJ3NUJaa0tuMjkyMjl4VXVDbThnV2hiQjBD?=
 =?utf-8?B?dGZGOEp6OFNvQk1tdERQNjJmZFNOTFVLSEJRYXZZcmVSTUEyNEtuRFAvUnBk?=
 =?utf-8?B?RXpHZ0ErRk9JS040QVZsaWwyQUs1RHEvTWJZSzJHWHBWTmZpQk5McVRhK1Fa?=
 =?utf-8?B?dkxTVEtEci9lWXR5UWpOZXNySHViVVk4TTdDMVVXTmZkak00MzM2SWZNNzJw?=
 =?utf-8?B?dEx6TytldjVTSE9lWXhIQ0Z5R2thUkRhS1pGall4Q3lKMVZGY2ZDK25ZVXAy?=
 =?utf-8?B?ckhtQ3hwcTNVclpVVUdSOEVBcmo1cUdoZnExVkF1djU2YVh4QTJCeC9SWDRP?=
 =?utf-8?B?d2R3UFE1bzVSSTNwdEJ4eHZVaWtrREtvVkVqN0hsZ29kdk83NWpRaVEzUDI3?=
 =?utf-8?B?aFozT1lqRFl4UWdIK21CSFE4anR4OGxZZ1hmekxmZk53NWRoRkhueXpGcHhq?=
 =?utf-8?B?Ukc0SXZaTUpwZkcyTytvbUhZeWp0RXg5T2MyVmZBVTF6czBVbUl0S0VKUlJw?=
 =?utf-8?B?TVN2eEdReFZrYWR2elQwaWxLMXdzdG51UVkycnk2MnFqZ1J0RTdBdkI0Zk5P?=
 =?utf-8?B?dWk1K2Y3QlBQQzlhbDRzT0x2YlRocThIVnBzejRGem1GaWxrTFFMbHV2STdX?=
 =?utf-8?B?VC8xeHNJMWFNbndXWFBrU1YxSFNHYks4NVF3V0M3SW9lRk9vT0VTWkRUcDVL?=
 =?utf-8?B?a3dGY1R6bml6Y2MwM2FCd2hudkN2dDNtWmQ3eXMzVFEyWXJ0eFdpdnVXWjRV?=
 =?utf-8?B?WFo0Vml3S2Z5aE1hajE0VE84djE0Q1dDOWtFZUdsaXlVOUQ5RnpmQjJocDd3?=
 =?utf-8?B?L01ETnNWOGFQZ3VNaE5SaVBDRkV2N2NabzhtM3FzNkFuTG9UYlc0ZHY0bDBQ?=
 =?utf-8?B?cC9ZQVpBSGZQZjR6TmJGUkRBQWRUZWd6TWttYmp1eGd2V09KbjhXRWFTdVoy?=
 =?utf-8?B?ZDBwY2RSL0ZqUHg1K2RTK2lmTk1pMmp2KzhJVXhhcDArb0ppQ0dPWmJEQnlr?=
 =?utf-8?B?VjlNSk1admNUWXBBQWlZSmgrRDJZekVqcEV5S25OTTAyUVpqcVZHSDlqbHg5?=
 =?utf-8?B?TjE5VStlbFhlQmlpblh6RWpsYmdPU2QrbHdDSmx2SnduL2lsUytwaXVRZ01m?=
 =?utf-8?Q?cc6K4Kih9ESfJLfmqp74hmqpxHTQ8qcE30nr7TN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8A08AF143E80F4E9A2AB271E745EB07@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f1496e-608f-4b14-a6cb-08d934de6718
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 18:00:06.5384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0KPX7cpDgDPOkhPUzjdnQR1Rm8OUG8ZNtIdo7nP/Ocun8Aw4TyF9tRkD7P32TBwlqLH/U/46B6DbWreamw1YPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3383
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTIxIGF0IDE2OjQ5ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IEhpLQ0KPiANCj4gPiBPbiBKdW4gMTcsIDIwMjEsIGF0IDc6MjYgUE0sIHRyb25kbXlAa2Vy
bmVsLm9yZ8Kgd3JvdGU6DQo+ID4gDQo+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IA0KPiA+IFdoZW4gZmx1c2hpbmcgb3V0IHRo
ZSB1bnN0YWJsZSBmaWxlIHdyaXRlcyBhcyBwYXJ0IG9mIGEgQ09NTUlUDQo+ID4gY2FsbCwgdHJ5
DQo+ID4gdG8gcGVyZm9ybSBtb3N0IG9mIG9mIHRoZSBkYXRhIHdyaXRlcyBhbmQgd2FpdHMgb3V0
c2lkZSB0aGUNCj4gPiBzZW1hcGhvcmUuDQo+ID4gDQo+ID4gVGhpcyBtZWFucyB0aGF0IGlmIHRo
ZSBjbGllbnQgaXMgc2VuZGluZyB0aGUgQ09NTUlUIGFzIHBhcnQgb2YgYQ0KPiA+IG1lbW9yeQ0K
PiA+IHJlY2xhaW0gb3BlcmF0aW9uLCB0aGVuIGl0IGNhbiBjb250aW51ZSBwZXJmb3JtaW5nIEkv
Tywgd2l0aA0KPiA+IGNvbnRlbnRpb24NCj4gPiBmb3IgdGhlIGxvY2sgb2NjdXJyaW5nIG9ubHkg
b25jZSB0aGUgZGF0YSBzeW5jIGlzIGZpbmlzaGVkLg0KPiA+IA0KPiA+IEZpeGVzOiA1MDExYWY0
YzY5OGEgKCJuZnNkOiBGaXggc3RhYmxlIHdyaXRlcyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogVHJv
bmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiANCj4gVGhl
IGdvb2QgbmV3cyBpcyBJJ3ZlIGZvdW5kIG5vIGZ1bmN0aW9uYWwgcmVncmVzc2lvbnMuIFRoZSBi
YWQNCj4gbmV3cyBpcyBJIGhhdmVuJ3Qgc2VlbiBhbnkgZGlmZmVyZW5jZSBpbiBwZXJmb3JtYW5j
ZS4gSXMgdGhlcmUNCj4gYSBwYXJ0aWN1bGFyIHRlc3QgdGhhdCBJIGNhbiBydW4gdG8gb2JzZXJ2
ZSBpbXByb3ZlbWVudD8NCg0KSSdkIGV4cGVjdCB0aGF0IHJlLWV4cG9ydGVkIE5GUyB3b3VsZCBi
ZSB0aGUgYmVzdCB0ZXN0IHNpbmNlIGZzeW5jKCkgaXMNCmEgaGlnaCBsYXRlbmN5IG9wZXJhdGlv
biB3aGVuIHRoZSBwYWdlIGNhY2hlIGlzIGxvYWRlZC4gWW91IGFsc28gd2FudA0KdG8gdXNlIGEg
Y2xpZW50IHdpdGggcmVsYXRpdmVseSBsaW1pdGVkIG1lbW9yeSBzbyB0aGF0IGl0IHdpbGwgdHJ5
IHRvDQpyZWNsYWltIG1lbW9yeSBieSBwdXNoaW5nIG91dCBkaXJ0eSBwYWdlcyBhbmQgZG9pbmcg
Q09NTUlULg0KDQo+IA0KPiBJIHdvbmRlciBhYm91dCBhZGRpbmcgYSBGaXhlczogdGFnIGZvciBh
IGNoYW5nZSB0aGF0IHRoZSBwYXRjaA0KPiBkZXNjcmlwdGlvbiBkZXNjcmliZXMgYXMgYW4gb3B0
aW1pemF0aW9uLg0KDQpJJ3ZlIG9jY2FzaW9uYWxseSBoaXQgT09NIHNpdHVhdGlvbnMgaW4gdGhl
IHJlLWV4cG9ydCBjYXNlIHdoZW4gdGhlIHIvdw0KbG9jayBjb250ZW50aW9uIGNhdXNlcyBzb2Z0
ZXJyIGZhaWx1cmUgdG8gYmUgc2VyaWFsaXNlZC4NCmkuZS4gaWYgdGhlIHNlcnZlciBpcyBkb3du
LCBhbmQgeW91J3JlIGVzc2VudGlhbGx5IGhvcGluZyB0aGF0IHRoZSBuZnNkDQp0aHJlYWRzIHdp
bGwgZ2l2ZSB1cCBhbmQgcmV0dXJuIEVKVUtFQk9YL05GUzRFUlJfREVMQVkgdG8gdGhlIGNsaWVu
dCwNCnRoZW4gdGhhdCBsb2NrIGVuc3VyZXMgdGhhdCB0aHJlYWRzIGZhaWwgb25lLWJ5LW9uZSAo
Z3JhYiBsb2NrLCB3cml0ZSwNCnRpbWVvdXQsIHJlbGVhc2UgbG9jaykgaW5zdGVhZCBvZiBiZWlu
ZyBhYmxlIHRvIGFsbCBmYWlsIGF0IG9uY2UNCih3cml0ZSwgdGltZW91dCkuDQoNCj4gDQo+IA0K
PiA+IC0tLQ0KPiA+IGZzL25mc2QvdmZzLmMgfCAxOCArKysrKysrKysrKysrKysrLS0NCj4gPiAx
IGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC92ZnMuYyBiL2ZzL25mc2QvdmZzLmMNCj4gPiBpbmRleCAx
NWFkZjFmNmFiMjEuLjQ2NDg1YzA0NzQwZCAxMDA2NDQNCj4gPiAtLS0gYS9mcy9uZnNkL3Zmcy5j
DQo+ID4gKysrIGIvZnMvbmZzZC92ZnMuYw0KPiA+IEBAIC0xMTIzLDYgKzExMjMsMTkgQEAgbmZz
ZF93cml0ZShzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3QNCj4gPiBzdmNfZmggKmZocCwg
bG9mZl90IG9mZnNldCwNCj4gPiB9DQo+ID4gDQo+ID4gI2lmZGVmIENPTkZJR19ORlNEX1YzDQo+
ID4gK3N0YXRpYyBpbnQNCj4gPiArbmZzZF9maWxlbWFwX3dyaXRlX2FuZF93YWl0X3JhbmdlKHN0
cnVjdCBuZnNkX2ZpbGUgKm5mLCBsb2ZmX3QNCj4gPiBvZmZzZXQsDQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbG9m
Zl90IGVuZCkNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBhZGRyZXNzX3NwYWNl
ICptYXBwaW5nID0gbmYtPm5mX2ZpbGUtPmZfbWFwcGluZzsNCj4gPiArwqDCoMKgwqDCoMKgwqBp
bnQgcmV0ID0gZmlsZW1hcF9mZGF0YXdyaXRlX3JhbmdlKG1hcHBpbmcsIG9mZnNldCwgZW5kKTsN
Cj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldCkNCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsNCj4gPiArwqDCoMKgwqDCoMKgwqBmaWxlbWFwX2Zk
YXRhd2FpdF9yYW5nZV9rZWVwX2Vycm9ycyhtYXBwaW5nLCBvZmZzZXQsIGVuZCk7DQo+ID4gK8Kg
wqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gLyoNCj4gPiDCoCogQ29t
bWl0IGFsbCBwZW5kaW5nIHdyaXRlcyB0byBzdGFibGUgc3RvcmFnZS4NCj4gPiDCoCoNCj4gPiBA
QCAtMTE1MywxMCArMTE2NiwxMSBAQCBuZnNkX2NvbW1pdChzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3Rw
LCBzdHJ1Y3QNCj4gPiBzdmNfZmggKmZocCwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGVycikN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Ow0KPiA+IMKgwqDC
oMKgwqDCoMKgwqBpZiAoRVhfSVNTWU5DKGZocC0+ZmhfZXhwb3J0KSkgew0KPiA+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnQgZXJyMjsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaW50IGVycjIgPSBuZnNkX2ZpbGVtYXBfd3JpdGVfYW5kX3dhaXRfcmFuZ2Uo
bmYsDQo+ID4gb2Zmc2V0LCBlbmQpOw0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZG93bl93cml0ZSgmbmYtPm5mX3J3c2VtKTsNCj4gPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZXJyMiA9IHZmc19mc3luY19yYW5nZShuZi0+bmZfZmlsZSwgb2Zmc2V0
LCBlbmQsDQo+ID4gMCk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICgh
ZXJyMikNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGVycjIgPSB2ZnNfZnN5bmNfcmFuZ2UobmYtPm5mX2ZpbGUsIG9mZnNldCwNCj4gPiBlbmQsIDAp
Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3dpdGNoIChlcnIyKSB7DQo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjYXNlIDA6DQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmZzZF9jb3B5X2Jvb3RfdmVy
aWZpZXIodmVyZiwNCj4gPiBuZXRfZ2VuZXJpYyhuZi0+bmZfbmV0LA0KPiA+IC0tIA0KPiA+IDIu
MzEuMQ0KPiA+IA0KPiANCj4gLS0NCj4gQ2h1Y2sgTGV2ZXINCj4gDQo+IA0KPiANCg0KLS0gDQpU
cm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UN
CnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
