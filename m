Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2103369BF0
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Apr 2021 23:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhDWVRi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Apr 2021 17:17:38 -0400
Received: from mail-eopbgr680102.outbound.protection.outlook.com ([40.107.68.102]:22645
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232479AbhDWVRg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 23 Apr 2021 17:17:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqfmUgo9xevhzutiIBNwO7uFzARh/Q3VyYg62owoC8s1+Ar3TpGvphBE5aE4H8uva1lA3WS065RiturbB5Zwd8PrLeYmDUzVRmAKBRKkPHBP8jckXlTGxpjSWvZpmhuEKzrAypmVEnaoBQ0jZ+R4osgrH6EN/P9JjoHbUcKvy/2qVHbasM/jUbUe9uxlmXSAqc0kfeqXrWZ6sal3DT3KghxuiLse5pFy+x1tQBjiQLYSr0HK34oQMfZugg0Zyx3dV073hzn/UTUdeq/TAcacXRq2LY2HLU0EX58D8XJMHJTzh7hS9mBzGu3VPA0bpgxfF6KIrm4dgQw5ImKOPfspMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGbxSgz0kr5gwcdjXhRMcWFkGl6y1ac26OC4PXM3qw4=;
 b=BwpJbGGcgVDQFBQ2gefac8jNVIhRnzUNyoiiI7z8LVFdY8YwrZZX7resm/V7UE/xpHkXvkPNYdbxB6giHeQFDFkixDWv33fEJyKALRzFS0x1ltJlwwhKeD/IW3cOfrFCAxC16lgJVXpxXAkhmRQgrgK0vHmkm2WqaXwxpxpThU8yz0IB/DiA99tgSh/M4IBjLsu05rFCw76OdFlucpRUnYDQMtPc2ipSbSZz4U7KVnNBZc+npMQHSPLzhrntmx/AsQnVJN9G9qQfI5pB82+dvDVH3Hvp2Di4G6ENgXNuqz2SXFYH6Wo7B+O9L5VAeLum7PmZAwcCF3YjvM5EZ/BV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGbxSgz0kr5gwcdjXhRMcWFkGl6y1ac26OC4PXM3qw4=;
 b=QD6ZzyL8eWmJapiLbUEkr4zwQQjctl3T5M+QLuO+CMmGBclXpY2MaykOQsB65XB/bpBVDN6Vf66sxoxTaeWdSe8VYi2MBPkx/QjDZO8RxeSqxqzSkG/XFZ3bkvv8tJEEhc7OqXkIZoJeX5g1ugbLeZzxb3SWTzXNBse62gwFcdA=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB2537.namprd13.prod.outlook.com (2603:10b6:5:bd::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.7; Fri, 23 Apr
 2021 21:16:58 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0%4]) with mapi id 15.20.4087.017; Fri, 23 Apr 2021
 21:16:58 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 06/13] sunrpc: add IDs to multipath
Thread-Topic: [PATCH v2 06/13] sunrpc: add IDs to multipath
Thread-Index: AQHXMnPxVhf0Sic6X0qLQowRSuwopqrCpxIA
Date:   Fri, 23 Apr 2021 21:16:57 +0000
Message-ID: <ffecdfb0ce5a488bc770e0535dc66c54cc095f47.camel@hammerspace.com>
References: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
         <20210416035226.53588-7-olga.kornievskaia@gmail.com>
In-Reply-To: <20210416035226.53588-7-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38018426-8a48-4ff2-f7f5-08d9069d20d6
x-ms-traffictypediagnostic: DM6PR13MB2537:
x-microsoft-antispam-prvs: <DM6PR13MB25372BB2845956963A1E08A5B8459@DM6PR13MB2537.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: siIjaS0XaHcfsnQ9NxMheinUT1c7T8lWWWefKAbP4HUJSoeGHl5ZXTpYQWahMX3QnE1+UzEAdPYXIVisyk6Q4+HclInvATRkS3jK+Hf1Xmva2HLt/u4F3rcL5vRXLho1qA5Tzk5g0BHgEfG7svZF7qd17zk+aKMjmi+jCjhQqLx0LG8lUmoqlQla3F8fnBGSh4l5G8JuEZAoIZmVisuIPUetwUpNu6OcEbVgzk3KD35tuyV/M44UPgD3ILf1ZK8GalRMGENaCcB9rPbL6ZbcGMyHuQjrXMvmHWghXe59Q+azG1f4pBpYLWpK9A3EhN65BYrgryxzsSxci4sdMmL/kR6jyekpkq48rvAIRxgJLjTS2c5OjNT5bWT8/psEoPJGW/KLDryPF9T4qnz+rDQegV1tHgFIVDZuSvhBK/ZoWmigEDE9yBgMgpuVdyyBRTAh844wXuN6r8h8w6B7MGY/TWhQgUDnokJrKHM2XmmDpjXKzJ7Wer92MLksOk82/qY4S98fZoGzsVWfHb8WZAgS/fQYIROm0wW/oLBmw3OyZKFilNTGTpPnV4ZorrSWRezuRR4sC8u+h/Y5sucGFGlyQ9lIfztSXviIAIR0+BQm1xM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(346002)(39840400004)(136003)(36756003)(66446008)(110136005)(4326008)(66556008)(8676002)(8936002)(86362001)(2906002)(2616005)(186003)(91956017)(83380400001)(26005)(38100700002)(66476007)(122000001)(71200400001)(5660300002)(316002)(6506007)(64756008)(66946007)(6512007)(478600001)(76116006)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UC9MUytsOHlXYmdOdEZsUlQrVFplbXRWL3FTeXFUalJDNVVFUWY0SkNZeHVn?=
 =?utf-8?B?eG42K0FBcVljeVZxdkZ2a0dzY3JIbkwyVGYwbWh2WHVjREl6aWJoYlhMTVBv?=
 =?utf-8?B?UmdxK0lNZUlJMm1SZTV4VnhZK2J6WVExRGdGb2RRcmFjZVp0T3lyVEFKaCto?=
 =?utf-8?B?dkZlVDVTeDU5cEtmZWI5SXZJajFzV0hkRGh5Y1h1TkI3c2tTM2VLcE1uK3hS?=
 =?utf-8?B?SmRheTBFZ2MwcGJQTzZ3V09jbEFYNU00YVVQVld1RGNrck5WSGR1NzVPM2NZ?=
 =?utf-8?B?REs5RTFVQ1hjWU1scTFUOWZGNDlhUFdMNjZjcDBZZjE4Vy9LRlB5aDRDZWtW?=
 =?utf-8?B?Y3pJWEV0d2ZxSkY3STVKUjBGakYrOFpmT0NwT2ZrMmRYcHZxRUZYeHJoM3hm?=
 =?utf-8?B?aFRHcUgwMmwwYmExS1MwTkRXOWpXQmdJWnJaVXdLcWhDRms2Z1pRQUd5eXJJ?=
 =?utf-8?B?N2RxL0VKTWh6MjVqUUZXT3NEUEtBNnJ3Vk5IN1o4MnN0Wk9zZWRIT1BBK2tT?=
 =?utf-8?B?MTBLT2hpNnhxbXVkc0FFTzVIbUJiTFFnOFJzZ2lyeXJrV0c2cm12MjdkbjNK?=
 =?utf-8?B?V0pTM214VGYxdmNHK3FHaFZzdjdTZXhRZ0RPVW05M2dFOW9zc0s5d3ZuNmpO?=
 =?utf-8?B?c0pkVFh3WjdJZGRKSVZ1S3h0cld2VmtkZWR0T3JwTXJRMDVZYUl3N3Mra01x?=
 =?utf-8?B?QnF2WHZtcUtycTUzaWFNaWdMNkt1bEw3emtHZEZsN3JBYzZyQWpzeVRYNER5?=
 =?utf-8?B?SHBQM0pRbDJWU2tlK1FBek1SbmlhYU5nTm94RHdBdXdzQVhnTVBsbGl6VmhV?=
 =?utf-8?B?VmNHb3MxQlZmSnJ1RmFvTmI5alpWbkZGeG8xd01UNE5oQnNJU3ZYQlJTNzMy?=
 =?utf-8?B?TEh0bjR4R0FYWG0yeGt4dnRyeUxSQzJ4ZXZXUm5XczBrK255OFJBT2graVoy?=
 =?utf-8?B?MEtEWjdTNXJzc0cxMHV6dGw2aHZ4M0d0dWJaK3pCTHljYlptM1RDSnczSFZR?=
 =?utf-8?B?SmxBdTNFd2pXcWwrbXNiMXJvTjZhNGNPZXRKWHB0dG9raWlwdkpmVFBKdjBa?=
 =?utf-8?B?bUR6eFVkTmlZWHFFaCtnOEI5eWlNMU02OEpHbWtGZDFGd0ZiVEhoSGVTR1Ns?=
 =?utf-8?B?RXYxZlFscytFL2FPT0d2Y1RLMVg1WExtOHhZU2xraStiWno2RHl0SHVxamU5?=
 =?utf-8?B?aDNTZTkwUXQ4ckVUOGlwTWsvbG11ZnRXaG84VWRGT3hhR0NCUWxLd1dmR0w1?=
 =?utf-8?B?NDVmTjhxZHN1S2ZocE4rT0hJb25OOEdlYzl3UFdjNGpYcmZVNzIrVVgyWUNF?=
 =?utf-8?B?R0hiRGVkb3lxVnRKREQ3TE45dHdqcXFJZEovNld5cGJ0NkpaN0NRZ3VKWEhM?=
 =?utf-8?B?UnNlNzBwWU9HL05tWGNUMkpzMFp4UnlaajQvdUVMaXNNN245bDNYQllaOHRw?=
 =?utf-8?B?ajNNZmY5Y2pnN1BpK0dLVmw5dVI1K0VSUElIME9yQzgxd1BWZTZORUdJc2JK?=
 =?utf-8?B?cWJoK1FmckVENjN6SHJjU241UWMxdzVUVXNRc3owczFmRlpOWGtJbFBpdnUv?=
 =?utf-8?B?UENBUEE4MVhiUThNazRqdzc5aXA3ZTlyRzZKYkVjelc5RDZiZzVoTi9YOVQx?=
 =?utf-8?B?NWwyOGN0Y3FwdjEvSzdEbXl1eXBvRVRwTUJqaEdiTXhNSTZlTTBHY0FUbHVv?=
 =?utf-8?B?MlRDd3orUURxS3cvTXF6Tk5aVVBXT09oQzlkb2c1UTNEOVBZR3lKN3ZXUGZ6?=
 =?utf-8?Q?lQDZFdZ5vAfig949u7aiENyLUqtP8ia79CMPM+y?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F1DEDCA459D8140A5F050FA0349DDD6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38018426-8a48-4ff2-f7f5-08d9069d20d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 21:16:57.8444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McSqiqg0exkp7V79pLI93V6KfBTmyAp6FJPE8ZUu0vNw62rqhoSTGVhjVz78WnPMN/TsVNSa2cU7Ofyxf/z+bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2537
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTA0LTE1IGF0IDIzOjUyIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gRnJvbTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+IA0KPiBU
aGlzIGlzIHVzZWQgdG8gdW5pcXVlbHkgaWRlbnRpZnkgc3VucnBjIG11bHRpcGF0aCBvYmplY3Rz
IGluIC9zeXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gQWxvbmkgPGRhbkBrZXJuZWxpbS5j
b20+DQo+IC0tLQ0KPiDCoGluY2x1ZGUvbGludXgvc3VucnBjL3hwcnRtdWx0aXBhdGguaCB8wqAg
NCArKysrDQo+IMKgbmV0L3N1bnJwYy9zdW5ycGNfc3ltcy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCAxICsNCj4gwqBuZXQvc3VucnBjL3hwcnRtdWx0aXBhdGguY8KgwqDCoMKgwqDCoMKg
wqDCoMKgIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqAzIGZpbGVzIGNoYW5n
ZWQsIDMxIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N1
bnJwYy94cHJ0bXVsdGlwYXRoLmgNCj4gYi9pbmNsdWRlL2xpbnV4L3N1bnJwYy94cHJ0bXVsdGlw
YXRoLmgNCj4gaW5kZXggYzZjY2UzZmJmMjlkLi5lZjk1YTZmMThjY2YgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvbGludXgvc3VucnBjL3hwcnRtdWx0aXBhdGguaA0KPiArKysgYi9pbmNsdWRlL2xp
bnV4L3N1bnJwYy94cHJ0bXVsdGlwYXRoLmgNCj4gQEAgLTE0LDYgKzE0LDcgQEAgc3RydWN0IHJw
Y194cHJ0X3N3aXRjaCB7DQo+IMKgwqDCoMKgwqDCoMKgwqBzcGlubG9ja190wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHhwc19sb2NrOw0KPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGtyZWbC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHhwc19rcmVmOw0KPiDCoA0KPiArwqDCoMKgwqDCoMKg
wqB1bnNpZ25lZCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB4cHNfaWQ7DQo+IMKgwqDCoMKg
wqDCoMKgwqB1bnNpZ25lZCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB4cHNfbnhwcnRzOw0K
PiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeHBz
X25hY3RpdmU7DQo+IMKgwqDCoMKgwqDCoMKgwqBhdG9taWNfbG9uZ190wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHhwc19xdWV1ZWxlbjsNCj4gQEAgLTcxLDQgKzcyLDcgQEAgZXh0ZXJuIHN0cnVjdCBy
cGNfeHBydCAqeHBydF9pdGVyX2dldF9uZXh0KHN0cnVjdA0KPiBycGNfeHBydF9pdGVyICp4cGkp
Ow0KPiDCoA0KPiDCoGV4dGVybiBib29sIHJwY194cHJ0X3N3aXRjaF9oYXNfYWRkcihzdHJ1Y3Qg
cnBjX3hwcnRfc3dpdGNoICp4cHMsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Y29uc3Qgc3RydWN0IHNvY2thZGRyICpzYXApOw0KPiArDQo+ICtleHRlcm4gdm9pZCB4cHJ0X211
bHRpcGF0aF9jbGVhbnVwX2lkcyh2b2lkKTsNCj4gKw0KPiDCoCNlbmRpZg0KPiBkaWZmIC0tZ2l0
IGEvbmV0L3N1bnJwYy9zdW5ycGNfc3ltcy5jIGIvbmV0L3N1bnJwYy9zdW5ycGNfc3ltcy5jDQo+
IGluZGV4IGI2MWI3NGMwMDQ4My4uNjkxYzAwMDBlOWVhIDEwMDY0NA0KPiAtLS0gYS9uZXQvc3Vu
cnBjL3N1bnJwY19zeW1zLmMNCj4gKysrIGIvbmV0L3N1bnJwYy9zdW5ycGNfc3ltcy5jDQo+IEBA
IC0xMzQsNiArMTM0LDcgQEAgY2xlYW51cF9zdW5ycGModm9pZCkNCj4gwqDCoMKgwqDCoMKgwqDC
oHJwY19zeXNmc19leGl0KCk7DQo+IMKgwqDCoMKgwqDCoMKgwqBycGNfY2xlYW51cF9jbGlkcygp
Ow0KPiDCoMKgwqDCoMKgwqDCoMKgeHBydF9jbGVhbnVwX2lkcygpOw0KPiArwqDCoMKgwqDCoMKg
wqB4cHJ0X211bHRpcGF0aF9jbGVhbnVwX2lkcygpOw0KPiDCoMKgwqDCoMKgwqDCoMKgcnBjYXV0
aF9yZW1vdmVfbW9kdWxlKCk7DQo+IMKgwqDCoMKgwqDCoMKgwqBjbGVhbnVwX3NvY2tldF94cHJ0
KCk7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdmNfY2xlYW51cF94cHJ0X3NvY2soKTsNCj4gZGlmZiAt
LWdpdCBhL25ldC9zdW5ycGMveHBydG11bHRpcGF0aC5jIGIvbmV0L3N1bnJwYy94cHJ0bXVsdGlw
YXRoLmMNCj4gaW5kZXggNzhjMDc1YTY4YzA0Li5iNzFkZDk1YWQ3ZGUgMTAwNjQ0DQo+IC0tLSBh
L25ldC9zdW5ycGMveHBydG11bHRpcGF0aC5jDQo+ICsrKyBiL25ldC9zdW5ycGMveHBydG11bHRp
cGF0aC5jDQo+IEBAIC04Niw2ICs4NiwzMCBAQCB2b2lkIHJwY194cHJ0X3N3aXRjaF9yZW1vdmVf
eHBydChzdHJ1Y3QNCj4gcnBjX3hwcnRfc3dpdGNoICp4cHMsDQo+IMKgwqDCoMKgwqDCoMKgwqB4
cHJ0X3B1dCh4cHJ0KTsNCj4gwqB9DQo+IMKgDQo+ICtzdGF0aWMgREVGSU5FX0lEQShycGNfeHBy
dHN3aXRjaF9pZHMpOw0KPiArDQo+ICt2b2lkIHhwcnRfbXVsdGlwYXRoX2NsZWFudXBfaWRzKHZv
aWQpDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqDCoGlkYV9kZXN0cm95KCZycGNfeHBydHN3aXRjaF9p
ZHMpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IHhwcnRfc3dpdGNoX2FsbG9jX2lkKHN0cnVj
dCBycGNfeHBydF9zd2l0Y2ggKnhwcykNCj4gK3sNCj4gK8KgwqDCoMKgwqDCoMKgaW50IGlkOw0K
PiArDQo+ICvCoMKgwqDCoMKgwqDCoGlkID0gaWRhX3NpbXBsZV9nZXQoJnJwY194cHJ0c3dpdGNo
X2lkcywgMCwgMCwgR0ZQX0tFUk5FTCk7DQoNClRoaXMgcmVhbGx5IG5lZWRzIHRvIHVzZSB0aGUg
c2FtZSBhbGxvY2F0aW9uIG1vZGUgYXMgdGhlIGNhbGxlciBpbg0KeHBydF9zd2l0Y2hfYWxsb2Mo
KQ0KDQo+ICvCoMKgwqDCoMKgwqDCoGlmIChpZCA8IDApDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gaWQ7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgeHBzLT54cHNfaWQg
PSBpZDsNCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2
b2lkIHhwcnRfc3dpdGNoX2ZyZWVfaWQoc3RydWN0IHJwY194cHJ0X3N3aXRjaCAqeHBzKQ0KPiAr
ew0KPiArwqDCoMKgwqDCoMKgwqBpZGFfc2ltcGxlX3JlbW92ZSgmcnBjX3hwcnRzd2l0Y2hfaWRz
LCB4cHMtPnhwc19pZCk7DQo+ICt9DQo+ICsNCj4gwqAvKioNCj4gwqAgKiB4cHJ0X3N3aXRjaF9h
bGxvYyAtIEFsbG9jYXRlIGEgbmV3IHN0cnVjdCBycGNfeHBydF9zd2l0Y2gNCj4gwqAgKiBAeHBy
dDogcG9pbnRlciB0byBzdHJ1Y3QgcnBjX3hwcnQNCj4gQEAgLTEwMyw2ICsxMjcsNyBAQCBzdHJ1
Y3QgcnBjX3hwcnRfc3dpdGNoICp4cHJ0X3N3aXRjaF9hbGxvYyhzdHJ1Y3QNCj4gcnBjX3hwcnQg
KnhwcnQsDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoeHBzICE9IE5VTEwpIHsNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzcGluX2xvY2tfaW5pdCgmeHBzLT54cHNfbG9jayk7DQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKga3JlZl9pbml0KCZ4cHMtPnhwc19rcmVm
KTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHhwcnRfc3dpdGNoX2FsbG9jX2lk
KHhwcyk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeHBzLT54cHNfbnhwcnRz
ID0geHBzLT54cHNfbmFjdGl2ZSA9IDA7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgYXRvbWljX2xvbmdfc2V0KCZ4cHMtPnhwc19xdWV1ZWxlbiwgMCk7DQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgeHBzLT54cHNfbmV0ID0gTlVMTDsNCj4gQEAgLTEzNiw2ICsx
NjEsNyBAQCBzdGF0aWMgdm9pZCB4cHJ0X3N3aXRjaF9mcmVlKHN0cnVjdCBrcmVmICprcmVmKQ0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
cnBjX3hwcnRfc3dpdGNoLCB4cHNfa3JlZik7DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqB4cHJ0
X3N3aXRjaF9mcmVlX2VudHJpZXMoeHBzKTsNCj4gK8KgwqDCoMKgwqDCoMKgeHBydF9zd2l0Y2hf
ZnJlZV9pZCh4cHMpOw0KPiDCoMKgwqDCoMKgwqDCoMKga2ZyZWVfcmN1KHhwcywgeHBzX3JjdSk7
DQo+IMKgfQ0KPiDCoA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
DQoNCg==
