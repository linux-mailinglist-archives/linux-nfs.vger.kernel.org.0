Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FAC33C123
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Mar 2021 17:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhCOQES (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Mar 2021 12:04:18 -0400
Received: from mail-eopbgr700120.outbound.protection.outlook.com ([40.107.70.120]:51104
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232149AbhCOQEM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 15 Mar 2021 12:04:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVeTKe58kLyJGQZKqGnGgB6S+UOVXj+zvJPipBEgHZc8RS71iFujKSRwRDEehEITjKyg9DcVGv1VVHkSsmlRVeyPg3elJlC72A4sA+1jpkk3pkwmvkAU6jER02y7yBOGqYupOJAw0U7xySrJJHnYuELkD/leVzNM3MHlSXxRSK7ZieBp/x5PMmpt77to1ScAbh9hhyR7oDOwjWYDxjidWHbVLPOa/yPMeCSgKPqq/BLOLD5/OtcfApUk15nps5VOnZfOqSsFVwzAQfDcoyaIZeT8sIZMr2GaZRw5p4XrGovqgph1ThrQzVfSnUL2TVAWBDBTMj7YiMkZBjwhKUudDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgZEQEdSrar4Lh0Zj6Cw/WS8yh2utiIjP8t9/Nu32cs=;
 b=ccGNjImaZEjIDHVmttgMNPRnWdj48MVjqZbeSEfxpKVVg9Cu9We/zpT7Qixph5fNJK16fD1Yi+xJbkz8uq4Vd1ymMglppHJJHjW+sNb2g3MHrnbtGGlbv+F1xdTRDVVeMDCX+ijNeo8vsqZ7J0U/tYsiZZaM8GlZntdcFnC8ewuXwytFlcYr4aMF+aiZr1/09Jz0S0M5YucgPbEIXIK1k21+j10BxEO4GNjpM7CnuR4bk1J8IEH5CFyENiDf4KM+C3SLUu+kbmRsh+0igyWkhu/Y8zDqYyzeNVqZCQ2U3qYx90UgAViO/pDUCMqVvRCPD+kjBuQVgSgIN6dz2TvJ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgZEQEdSrar4Lh0Zj6Cw/WS8yh2utiIjP8t9/Nu32cs=;
 b=GHoIdUKftksQQ4XCCiJseSWJBRm4XdWPvMXABBnDcdPsUbhHphGttzgA1bJ6dkk1EKWObQhhqy/luIE3nrPpYA4QrH5M9iIWbDqQ5k/+2AD1rzOBvPWREel/7vb2I3g/xPYSEdw4wNZyYJ0F5gSi9KdSwGPriq2/T+eU3+3dFwM=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH0PR13MB4729.namprd13.prod.outlook.com (2603:10b6:610:d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11; Mon, 15 Mar
 2021 16:04:05 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3955.010; Mon, 15 Mar 2021
 16:04:05 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@redhat.com" <bfields@redhat.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH] nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs is
 unmounted
Thread-Topic: [PATCH] nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs
 is unmounted
Thread-Index: AQHXGE01uwS1nZ4gC0yGl2iynxTjiKqFI1eAgAAVsgA=
Date:   Mon, 15 Mar 2021 16:04:05 +0000
Message-ID: <51c84f27cf5c950c63ef2be570fd647d93d80036.camel@hammerspace.com>
References: <20210313210847.569041-1-trondmy@kernel.org>
         <YE9zQQhyfHmLLVVJ@pick.fieldses.org>
In-Reply-To: <YE9zQQhyfHmLLVVJ@pick.fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1b90251-5dbf-4871-accf-08d8e7cbf549
x-ms-traffictypediagnostic: CH0PR13MB4729:
x-microsoft-antispam-prvs: <CH0PR13MB47290B8EEDB1DA2BACEA2DABB86C9@CH0PR13MB4729.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /7XgG5MvS28HF3LrGx0XckLIIpSJZCkYpFygHp9j0kNLJPGolrfCLq/ElwOAJZZHs7HVBikSkN6i8pDV/b+nN9kFbdYhUbERy6skSLByO/R/KG2JcqDXjHX6aJHizGEoLQ4hDo78NYDYH58PuZ+I6P3G0NQd658zLDz4PI9x80gq26FjlkGOGAAC3DGlTstxWUzGjyw/OO6lSA1l0V5whXIe9cu6UK1l0gufGFuNppmw/bgVInSGT2ocVMMtnAjJTGIVjyx/idFK6cu5AJkND2sT74mnjvo19z+1ijr0S1N1kLIaPKviOkWcvyJTDNvPwjDCDLUed+dlCIr4HUtsgddljrFU5ROuXssXWXRjcfoIB9bBXxTPQJRJ8W7GzR73/OleqphKRbFvwMYUqnGV3Izc+9FENnF3L8qmdRkIg7unuZr/f5JHRH1IlowDAhztZ/bs09NWbXNcvI/axLlet1DMhQm0wQh0l0puMJt7ygxx9DixHs8oMUKMAX+k1wCGlwzuPSRoCWhsXr/SFaqstfvrnjgwPbo/aotRv1CFamlZ2dmo83vQ9mDLfeU2NXRE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(376002)(39830400003)(66446008)(64756008)(66556008)(478600001)(2616005)(26005)(76116006)(66476007)(8676002)(186003)(6486002)(5660300002)(66946007)(2906002)(86362001)(6512007)(4326008)(6506007)(110136005)(316002)(54906003)(71200400001)(36756003)(83380400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dkVwMThhUkU0NHlseEQwV3EybThWenkrR1JnTGYyZWNVeklnM1EvNG02UEVJ?=
 =?utf-8?B?Vm14R0E2bGl4blN5ZVh6aEsrZmp5cmlUTG5DclM2Sy9GQkdpNnhUa2hDcFFo?=
 =?utf-8?B?UC9ORU1FekozZm9tcEV3Mi9nWVlJeWhxZ2oyYXB1TjhKa2J1dlArV2R4NnFo?=
 =?utf-8?B?a29Xd3J4NUY1Rm9BSndhV0pOd3UvWTh4UTFWQmtwYnRwTnk4ZUlUblRBZWk1?=
 =?utf-8?B?RW1hTkNxRzZ1ZHF0K25KRXNsVmhZMlhrbURxcENGNE1FNWxWR2gzMjc2bzRH?=
 =?utf-8?B?K3hQT1N4RmltSjMrYVpuL2p1d05rYThlL1RpQ2s1empncnJkNG5sdVVpRTBa?=
 =?utf-8?B?Sms5ZVV3SHI4MUJCNGxIRXZHUHNkcktZalVuVkJ6cGcxajYwV1dtUXVZTm03?=
 =?utf-8?B?QVVMckNBNzhrWW9kVXpQbCt3bmNKY2l1ZS9BWVNpY0pUSE56RHc1aThmNDA3?=
 =?utf-8?B?QWJtOG5NV3psRDBjM0J4bTJvQSt1Zzh6M092bUtKcTFYUE5mZ1pYZFdpeWhU?=
 =?utf-8?B?b0FKUDErVlY0cDlLUnFrUVV6aU1WVVMzaWR5N09iM2lJUEhJdjZZNTVjT2FC?=
 =?utf-8?B?dnYrMzUyMlpVa2NDNGxqNU1zeEFCMHYwSW4xck9ZUnl5WXh3eisvR2tST2lH?=
 =?utf-8?B?U2lRT1RWSUEvcThyZ2JsZ2JId3BsMlpxTmN6c3N3bVNjMkxGWDJDV2FhWFV3?=
 =?utf-8?B?eDl3Yi9EdVp3OTFLUFVLNU1Oa1lQQWQ4RDdtaVRacWZQTFl0Mk9NMk9MK1dK?=
 =?utf-8?B?T3hkT245YkVFUjFXdjRVb2NEMjQwVTFxNm93Q3g4U01Ocjl5RDJNZ0Y2cFFC?=
 =?utf-8?B?L3IyT1ZDeWRRMHFoN1B1Q3JZRzR4SjErem8ybnpuOG83RFJyK1d6ZXYzVGxt?=
 =?utf-8?B?M2tpN25tSFB1czZoN0xWeWI1V1pwTFJqRnlibXQvMFN2Z1AzL2dlK1pZYkxF?=
 =?utf-8?B?NDlmdVZKem1CZlovaERYeG4vTkI5ZVRFT0poMXBDL0tPcDV6czcvYllEOVlS?=
 =?utf-8?B?RFVOSTF5N0FCblNFUGczeWorN1NEV3hsZ0toSjNLZTFSYXJqWTB2MHM0aWhq?=
 =?utf-8?B?b3hqMCtKYUZiVWFpNGxaU1BhRVczM1NJUlliaGlVQ1F4N01sVzZyeDFmT2lP?=
 =?utf-8?B?Q2FjMU01QUhrekRKQ0hxajY5V0ZQd2k2K0ZnUzJxNG9ybTN6N25XSk83NG9P?=
 =?utf-8?B?MzhjWDhaRk0yRitqeUVuWS9yTFhwL0NrYU1yV29MR1c2TUJVS0l0YTBkRTJO?=
 =?utf-8?B?T3NwTDgvQ05GY0N6TE5LR1l0eWY4akdpbEdQQ0dsVEd3Zk53MUFQVjJVb1NW?=
 =?utf-8?B?QVdlTm80c2gvWFZYZ1ZMOEw5TzNCY0tIYW1CNmhsaHdmZ1RvK3dvSzJzR1Ix?=
 =?utf-8?B?QnprdDA4bDJsM1I1YnhOaENnYlpQWXA4VmIzaTFCUGdzbXJLYzZUWFhmdURH?=
 =?utf-8?B?RVhlZDJzZ2dGUVJIVTdzNk5HbEZwS1RGcUltbnpscXVTT01HZTZrY2FzSWhx?=
 =?utf-8?B?bGQ1c1pMZE4ybTByQTJRT1llR3hTS1NCcGN3MnVXZmtJZ2V2SDlKRXVKYzBh?=
 =?utf-8?B?ZkI3aHpJOTlCZTFtaUgyaFJEZjJlT3NMQ1oyenRzYmZ3NzF3ZC8xeEkxN3JI?=
 =?utf-8?B?QVoxa3BVNUR2bTVnYnhQZ0VpMWhDYkcraTVRUEtPWmsyVGJmUFJUekU1UkZM?=
 =?utf-8?B?RUtlVlpCWVNmN2s4R3F6MTVnQU1acVQ0UE9RWVZGMnN3OE5CMHRqd3cxRGs3?=
 =?utf-8?Q?JbDgXXgoML80sitTQa8a8Ro3cbtpkV+QqxAc9pC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <73B5A71C63C6854E81F5827CE18B812C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b90251-5dbf-4871-accf-08d8e7cbf549
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 16:04:05.0849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZYyoXTvRXU15PTcEYuCYmnpZ57W/LLTd6F2any4EqU99YySowPnFAHyvfszgcaDPeMtKdLgDZtfXslG5etcsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4729
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTE1IGF0IDEwOjQ2IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFNhdCwgTWFyIDEzLCAyMDIxIGF0IDA0OjA4OjQ3UE0gLTA1MDAsIHRyb25kbXlAa2Vy
bmVsLm9yZ8Kgd3JvdGU6DQo+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IA0KPiA+IEluIG9yZGVyIHRvIGVuc3VyZSB0aGF0IGtu
ZnNkIHRocmVhZHMgZG9uJ3QgbGluZ2VyIG9uY2UgdGhlIG5mc2QNCj4gPiBwc2V1ZG9mcyBpcyB1
bm1vdW50ZWQgKGUuZy4gd2hlbiB0aGUgY29udGFpbmVyIGlzIGtpbGxlZCkgd2UgbGV0DQo+ID4g
bmZzZF91bW91bnQoKSBzaHV0IGRvd24gdGhvc2UgdGhyZWFkcyBhbmQgd2FpdCBmb3IgdGhlbSB0
byBleGl0Lg0KPiA+IA0KPiA+IFRoaXMgYWxzbyBzaG91bGQgZW5zdXJlIHRoYXQgd2UgZG9uJ3Qg
bmVlZCB0byBkbyBhIGtlcm5lbCBtb3VudCBvZg0KPiA+IHRoZSBwc2V1ZG9mcywgc2luY2UgdGhl
IHRocmVhZCBsaWZldGltZSBpcyBub3cgbGltaXRlZCBieSB0aGUNCj4gPiBsaWZldGltZSBvZiB0
aGUgZmlsZXN5c3RlbS4NCj4gDQo+IFRoZSBuZnNkIGZpbGVzeXN0ZW0gaXMgcGVyLWNvbnRhaW5l
ciwgYW5kIHRocmVhZHMgYXJlIGdsb2JhbCwgc28gSQ0KPiBkb24ndA0KPiB1bmRlcnN0YW5kIGhv
dyB0aGlzIHdvcmtzLg0KPiANCg0KVGhlIGtuZnNkIHRocmVhZHMgYXJlIG5vdCBnbG9iYWwuDQoN
ClRoZXkgYXJlIGFzc2lnbmVkIGF0IGNyZWF0aW9uIHRpbWUgdG8gYSBzdHJ1Y3Qgc3ZjX3NlcnYs
IHdoaWNoIGlzIGENCnBlci1jb250YWluZXIgb2JqZWN0LiBBcyB5b3Ugc2F5IGFib3ZlLCBhbGwg
dGhlIGNvbnRyb2wgc3RydWN0dXJlcyBpbg0KdGhlIG5mc2QgZmlsZXN5c3RlbSBhcmUgcGVyLWNv
bnRhaW5lci4NCg0KV2l0aG91dCB0aGlzIGZhaWxzYWZlIHRoYXQgc2h1dHMgZG93biB0aG9zZSB0
aHJlYWRzIHdoZW4gdGhlIGNvbnRhaW5lcg0KaXMga2lsbGVkLCB0aGVuIHlvdSBlbmQgdXAgd2l0
aCBvcnBoYW5lZCB0aHJlYWRzLiBUaGlzIGlzIGEgcmVhbA0KcHJvYmxlbSB3aGVuIGRvY2tlciBj
cmFzaGVzIGFuZCBnZXRzIHJlc3RhcnRlZCAob3IgaWYgeW91IGRvIGEgJ2tpbGwgLQ0KOScgb24g
dGhlIGtuZnNkIGNvbnRhaW5lcidzIGluaXQgcHJvY2VzcykuDQoNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
