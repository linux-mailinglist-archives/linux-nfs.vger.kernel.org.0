Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0253E3DC88E
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Aug 2021 00:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhGaWHZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 31 Jul 2021 18:07:25 -0400
Received: from mail-mw2nam10on2109.outbound.protection.outlook.com ([40.107.94.109]:9440
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229505AbhGaWHY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 31 Jul 2021 18:07:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UarBjdrKR4UZdZQ2cXZAx0ghaa8pM7NydjqExC5KrbPvIblnXrDK5CzwR925FCR124gV/K72Vsf1yAlhIACWzXMrn20TwJVR4VtJ1G8INgGJvCMneARbU7dzJtNVe4RKvPIl6qf18GYveQ2ulfMdN7AcwIpw3tNCGJuOIoFFjyV2Uc2o8oYCnn0jPdzDNzMmZQvj3hvpQBEJ2X83RuNZKz6JevQkcJ7YrXaan58eZcIsAvAQA2DBOfMcn9mCK6JNtNNdxuxS4c6O2UTdObyQR7AQmK+nC6iegh5Rb0kf8pVT0dA29cBzn9IgHWk9yGl1WFfijReusHPKDP6hlicIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzNwlrEseKyrnvOj8zSq1eWL3VSUib6GYKoX4Xu+FT8=;
 b=Aa6FzP8pyuVwKTW1Jw2+7H0m0Z7EaBsxSs+gn1cpEEpQMguWXGle+Nqj4p2fbNt0q1i3GIyg7bi75FkQx6xP/10MeNKqTm16etiLTZ4iWnyi27GhHkInBC/Dje6ilnYt08BURJ3joAneg0/Dop0HwrmI3f7jHFWgYRhmMf/0z2pf3sIuDQxY789Qbeqd79EQqtFF1lbbT8lv1+ZUrE8TuX1Sa5vBrwTRYwZycEvXIX/TNaFU4kWGA/gw8yz1slv8roIx/88Nc+xN5vq0lDJL4dAs7hXcV10A+OF+HYN9lsdPJJBnuAP756wl4/6twuVQ5QYPjtJsfLGZdZYXaEd58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzNwlrEseKyrnvOj8zSq1eWL3VSUib6GYKoX4Xu+FT8=;
 b=WAAmt+YlgYcgajDjYy56JjPc/oaZqT8mNUO7zi2liugkVsi4XoNMoUBuguLFGnrwGoJr6ioCtd0CvXV2Zp6U0v6zXbNsMVeFmbXdEP8gA40OL+TBa0OD9dOQF7Ms0s+MeWKeg02BvFF/qNif3oApu/FSg9JFsmAWRILmBL4RYzU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4762.namprd13.prod.outlook.com (2603:10b6:610:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.14; Sat, 31 Jul
 2021 22:07:13 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%6]) with mapi id 15.20.4394.014; Sat, 31 Jul 2021
 22:07:13 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Eryu Guan <eguan@linux.alibaba.com>
CC:     Hao Xu <haoxu@linux.alibaba.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] common/attr: fix the MAX_ATTRS and MAX_ATTRVAL_SIZE for
 nfs
Thread-Topic: [PATCH] common/attr: fix the MAX_ATTRS and MAX_ATTRVAL_SIZE for
 nfs
Thread-Index: AQHXhUBzlbsTPgEIm0aR2Qd4Pf3zi6tbjE4AgAIaBYA=
Date:   Sat, 31 Jul 2021 22:07:13 +0000
Message-ID: <B6E429FE-2D78-41D0-A55D-C7AA83D62877@hammerspace.com>
References: <20210730124252.113071-1-haoxu@linux.alibaba.com>
 <20210730140134.GM60846@e18g06458.et15sqa>
In-Reply-To: <20210730140134.GM60846@e18g06458.et15sqa>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d3f0bf7-6908-470c-4f7d-08d9546f8d36
x-ms-traffictypediagnostic: CH0PR13MB4762:
x-microsoft-antispam-prvs: <CH0PR13MB4762AEC737CBD2DD654A1DA1B8ED9@CH0PR13MB4762.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BoFtXGCaTTdIlYXpG3iv4teBttsMFRu+kxquEMBsB9W0YIe5FqLTy6uAZjNtm+9+ioCRYdgv+dJ8J4N1g6r4DuPQDxA33FBbic+LX4iFfIeEWj1vFTjA9hpKvXpyWozh0gYGfnEYEMBaslRgU0L6GjE4atIwmt2jl0H0MvhQCb0h+U3O1cl66aYzbcjq6no5zV6SukoWLM3vFJbx4dx/hq7iWpJNDGJBk4zsIo8PajHhD+lEcroKUIhps8LYOV4ngL1T+wyNRg/7MtDgldCDjH6blPbuRRVZYf+7gbBccILH0VuadTYkoAS5xAGn9+OPFBJbtAs/gRJMUWSxGpejH0Rupm4QW9qvNzf25ToDKy1eK6lzKdvgG2bRlBZFwxirVHVItEYfRTnYJclFzaqXSyuqxW0w8+zWIU30AciMwbe9I5cBD37oDuv8L0+5NcWvGytq4AMiIhnYf0K778XhSbCXcEMPLY/7ivW6LF9+l2NvhabQKzrIi7ziHBio2Wft6HTtlnhZFPsEmnDGyxBEMw+BwM8T63DrAzY+H23lFxSl5LBXMXN9KpurGweUyKHkRvCZ88JYRR7yL3K6AVb2v+oMM22DSGNnVRsM7zdaEjy1aeR3u+aJGJ79KX+39Jr78dzr3ks8fEoM9C1AGZ/zU+IKparSbJPy7oWP+CNY7yk0vu6eJUsTzboj/4Fr4dbGWOk4pfIQJN6yg/KfiRUtAKS2+i1iwG0oqEj8jbXi6AcZ96s8yPzNxi+yWbJMA08b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(26005)(8936002)(71200400001)(2906002)(38070700005)(53546011)(8676002)(64756008)(66556008)(66476007)(66946007)(66446008)(6506007)(76116006)(54906003)(86362001)(6916009)(2616005)(186003)(6512007)(38100700002)(508600001)(5660300002)(83380400001)(122000001)(6486002)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3dCTDQyUk1TWnNoWndFdlN4RU9pVnhmbUhITmpCb1Y1aVBYdGVFaDRMWlgw?=
 =?utf-8?B?L1BrSkVEZExSdzYxU1l4NkQwQ2xSd09rUGNQek0xdmtKbGF3bml3R3RQdk54?=
 =?utf-8?B?dFpmczViSytRb1kwQlRUYzkzYm5IcEtwQlRzZ0ZKS25nQnNNRGRiQXdjakF3?=
 =?utf-8?B?bEo3YzBTWkFTcXBGL3VtZGFYSUFZWndJLy9QRmpRdGZwNnJ6dWR0ZE9CU1RT?=
 =?utf-8?B?MFAxRXhCdVNxZ0pFc1lMeUdPdi9GQm0yeS9samx1VEJBUTVVdmFWMzlJQTNO?=
 =?utf-8?B?WUpqK3NLdXhibHc1U3dubktRYXQvZk1Wa0wrRVI1K0hJbXRieVBCalBoTFB0?=
 =?utf-8?B?d0RQaHJIN21HemY5bkJJN2M1bFg3aTQvdjZ3THNaWDBmVHV1U1lCakhZMDk2?=
 =?utf-8?B?N08vY0cveUJBQzV4b3IzMTlxcldZcFMvQVlIdklXQW1Ia09YbkQwSTR2eDB3?=
 =?utf-8?B?QnF0QndGL3BONWpnTVVhbTlnc01MMHNSaTlVcVRmd0s2d0xGUGlWcVpiSXBi?=
 =?utf-8?B?MFp0SzdYa2VDRmh0REM1Z2gyd3FZalNPOTY4c2R6Qi9uc1dHYXBiWTE5QlFF?=
 =?utf-8?B?bWxHSjJWS0FpNlZHU0tmekNDUEl5RWh1bzJROUI2Sm1DZ2Z4M1dwbzNPcFJs?=
 =?utf-8?B?V3pWSkh5eTZSbmdsbDB1dnl2eE9VbExTM0w4aVc3Mk9zcEdUU3RiaEVuK1gv?=
 =?utf-8?B?T0JVR3FJMmlGOWVSTTNla3d3V2pZcGE5TU1nb1I5SVl1Vlo3RE5uQTNqWFJP?=
 =?utf-8?B?SEJqZlh3RDgrUy9hREFSeEl3ZjAySFd0TXdQanQ0SHNZRlRnck5yRUVmR3lo?=
 =?utf-8?B?THdMbGRNbEp2b3NKdU41WW92ck5IUmk2M093NUg3QzlCN0lOd0lRY2lGY1VY?=
 =?utf-8?B?QmJZaHZDS2R3cDV0anA0cGJ1NjFwNEROcGZxZkViRzFuNVc0bmVFUlRRdDZa?=
 =?utf-8?B?VU1uUWxZUUVCZ05BbGF4RmhTSWNjYnpSR2tKNlJpdG1PUzZKbE9qZE9CanNh?=
 =?utf-8?B?dkdsQWs2dENoa1lNQjdySlRjMFU0QVFteC9WOUdHMzdXdjhFSGVCdGJ4OWZu?=
 =?utf-8?B?em9RYlhrSnh5NHlFcU9HajZEVDl2R3hPaG4rN1o5TEE5L3o5azA0c290ZmFu?=
 =?utf-8?B?VFZHQjkzMWREWGZSdWJhcHFpRzhpUGNWckowM1BPZHVUalh3Q1MzMFRKU2p6?=
 =?utf-8?B?QnhFV2tIMkduQUlLZ3FieXJWcE94S1ZVSVJ2TzZCRkhUTmt3VFVLOWFoNmNJ?=
 =?utf-8?B?NHZxR2RuZTBveVJVdEN0TGUvdEVnU2dyUVRCemZuWnhRSDVLdnVVZllUMkRi?=
 =?utf-8?B?TTZOalVjVmpRQWpsQU1YNVQ2SkJhTFRzaVcvOWkrMXl3NjV6K25OcThWYnVB?=
 =?utf-8?B?YVN6TEVBandRVFRtWmFzTng2KzNQeHBmZlhkQkVCK3V0byt6NW1NbkZyVFpl?=
 =?utf-8?B?ZEZDTGI2MkhnTGJMWDFHSHZtKzc5REFqSjBvMkdDbGVZeGdlUDFUYnRaUkRh?=
 =?utf-8?B?bm1Cb3cxRXVzQmpqWFRWdFlKWGZHaDB6TmF5MFJ0STQvbzhuTnpTZGpESTl1?=
 =?utf-8?B?eHh4RXVhZXJSNW5OU3NPaXkvMEY0RGFXYWgzSzNHL1hwOTJhMDBFZDlUSE9W?=
 =?utf-8?B?MDFlQVcwQnA2KzFONzErdVFRMUp5dnVFRGc1d2poNWY4alc2YlNHL2pyalZS?=
 =?utf-8?B?RENHdGtKb2pudXVXUlozTDZ2SytOMXlqc3gyVE1aY3UyZzB2REo2SGQwZG1m?=
 =?utf-8?Q?jqktmINQArhYbwYyAiZrEeldE7Hq/xpK7oyIbDq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6EB79BEAC972943975FE6838EC5238C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3f0bf7-6908-470c-4f7d-08d9546f8d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2021 22:07:13.4754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mP6nBlvwv24wvj9VHeeT2PFbccrvH5C19SVi9hTBM/rpHYmDOLsOxuTz/oBHXLHccA0kgvmmSohjobEBDDi0Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4762
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gSnVsIDMwLCAyMDIxLCBhdCAxMDowMSwgRXJ5dSBHdWFuIDxlZ3VhbkBsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6DQo+IA0KPiBbY2MgbGludXgtbmZzIGZvciByZXZpZXddDQo+IA0K
PiBPbiBGcmksIEp1bCAzMCwgMjAyMSBhdCAwODo0Mjo1MlBNICswODAwLCBIYW8gWHUgd3JvdGU6
DQo+PiBUaGUgYmxvY2sgc2l6ZSBvZiBsb2NhbGZzIGZvciBuZnMgbWF5IGJlIG11Y2ggc21hbGxl
ciB0aGFuIG5mcyBpdHNlbGYuDQo+PiBTbyB3ZSdkIGJldHRlciBzZXQgTUFYX0FUVFJTIGFuZCBN
QVhfQVRUUlZBTF9TSVpFIHRvIDQwOTYgdG8gYXZvaWQNCj4+ICdubyBzcGFjZScgZXJyb3Igd2hl
biB3ZSB0ZXN0IGFkZGluZyBhIGJ1bmNoIG9mIHhhdHRycyB0byBuZnMuDQo+PiANCj4+IFNpZ25l
ZC1vZmYtYnk6IEhhbyBYdSA8aGFveHVAbGludXguYWxpYmFiYS5jb20+DQo+IA0KPiBTaW5jZSB0
aGUgeGF0dHIgc3VwcG9ydCBpcyByZWxhdGl2ZWx5IG5ldyAobWVyZ2VkIGEgeWVhciBhZ28gZm9y
DQo+IE5GU3Y0LjIpLCBJJ2QgbGlrZSBuZnMgZm9sa3MgdG8gdGFrZSBhIGxvb2sgYXMgd2VsbC4N
Cj4gDQo+PiAtLS0NCj4+IA0KPj4gSXQncyBiZXR0ZXIgdG8gc2V0IEJMT0NLX1NJWkUgdG8gYF9n
ZXRfYmxvY2tfc2l6ZSAkdmFyaWFibGVgDQo+PiBoZXJlICR2YXJpYWJsZSBpcyB0aGUgbG9jYWxm
cyBmb3IgbmZzLCBzaW5jZSBJJ20gbm90IGZhbWlsaWFyIHdpdGgNCj4+IHhmc3Rlc3RzLCBhbnlv
bmUgdGVsbCB3aGF0J3MgdGhlIG5hbWUgb2YgaXQuDQo+IA0KPiBmc3Rlc3RzIGRvZXNuJ3Qga25v
dyB0aGUgZXhwb3J0ZWQgZmlsZXN5c3RlbSB1bmRlciBORlMsIHNvIEkgZG9uJ3QgdGhpbmsNCj4g
d2UgY291bGQgdGhlIGJsb2NrIHNpemUgb2YgaXQuDQo+IA0KPj4gDQo+PiBjb21tb24vYXR0ciB8
IDExICsrKysrKysrKy0tDQo+PiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvY29tbW9uL2F0dHIgYi9jb21tb24vYXR0
cg0KPj4gaW5kZXggNDJjZWFiOTIzMzVhLi5hODMzZjAwZTA4ODQgMTAwNjQ0DQo+PiAtLS0gYS9j
b21tb24vYXR0cg0KPj4gKysrIGIvY29tbW9uL2F0dHINCj4+IEBAIC0yNTMsOSArMjUzLDEzIEBA
IF9nZXRmYXR0cigpDQo+PiANCj4+ICMgc2V0IG1heGltdW0gdG90YWwgYXR0ciBzcGFjZSBiYXNl
ZCBvbiBmcyB0eXBlDQo+PiBjYXNlICIkRlNUWVAiIGluDQo+PiAteGZzfHVkZnxwdmZzMnw5cHxj
ZXBofG5mcykNCj4+ICt4ZnN8dWRmfHB2ZnMyfDlwfGNlcGgpDQo+PiAJTUFYX0FUVFJTPTEwMDAN
Cj4+IAk7OyANCj4+ICtuZnMpDQo+PiArCUJMT0NLX1NJWkU9NDA5Ng0KPj4gKwlsZXQgTUFYX0FU
VFJTPSRCTE9DS19TSVpFLzQwDQo+PiArCTs7DQo+PiAqKQ0KPj4gCSMgQXNzdW1lIG1heCB+MSBi
bG9jayBvZiBhdHRycw0KPj4gCUJMT0NLX1NJWkU9YF9nZXRfYmxvY2tfc2l6ZSAkVEVTVF9ESVJg
DQo+PiBAQCAtMjczLDEyICsyNzcsMTUgQEAgeGZzfHVkZnxidHJmcykNCj4+IHB2ZnMyKQ0KPj4g
CU1BWF9BVFRSVkFMX1NJWkU9ODE5Mg0KPj4gCTs7DQo+PiAtOXB8Y2VwaHxuZnMpDQo+PiArOXB8
Y2VwaCkNCj4+IAlNQVhfQVRUUlZBTF9TSVpFPTY1NTM2DQo+PiAJOzsNCj4+IGJjYWNoZWZzKQ0K
Pj4gCU1BWF9BVFRSVkFMX1NJWkU9MTAyNA0KPj4gCTs7DQo+PiArbmZzKQ0KPj4gKwlNQVhfQVRU
UlZBTF9TSVpFPTM4NDANCj4+ICsJOzsNCj4gDQo+IFdoZXJlIGRvZXMgdGhpcyB2YWx1ZSBjb21l
IGZyb20/DQo+IA0KPiBUaGFua3MsDQo+IEVyeXUNCj4gDQo+PiAqKQ0KPj4gCSMgQXNzdW1lIG1h
eCB+MSBibG9jayBvZiBhdHRycw0KPj4gCUJMT0NLX1NJWkU9YF9nZXRfYmxvY2tfc2l6ZSAkVEVT
VF9ESVJgDQo+PiAtLSANCj4+IDIuMjQuNA0KDQpUaGUgYWJvdmUgaGFja2VyeSBwcm92ZXMgYmV5
b25kIGEgc2hhZG93IG9mIGEgZG91YnQgdGhhdCB0aGlzIHRlc3QgaXMgdXR0ZXJseSBicm9rZW4u
IEZpbGVzeXN0ZW0gYmxvY2sgc2l6ZXMgaGF2ZSBub3RoaW5nIGF0IGFsbCB0byBkbyB3aXRoIHhh
dHRycy4NCg0KUGxlYXNlIG1vdmUgdGhpcyB0ZXN0IGludG8gdGhlIGZpbGVzeXN0ZW0tc3BlY2lm
aWMgY2F0ZWdvcmllcyBvciBlbHNlIHJlbW92ZSBpdCBhbHRvZ2V0aGVyLiBJdCBkZWZpbml0ZWx5
IGRvZXMgbm90IGJlbG9uZyBpbiDigJhnZW5lcmlj4oCZLg0KDQoNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg==
