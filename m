Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC7931AE42
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Feb 2021 23:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBMWLT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Feb 2021 17:11:19 -0500
Received: from mail-bn8nam12on2128.outbound.protection.outlook.com ([40.107.237.128]:13121
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229647AbhBMWLR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 13 Feb 2021 17:11:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhHEMAzipkLt0sMd0HHi0HVzp+FZLQ2uOGCWPVEoySkwDgDpSSWRJWmiBjpBbzZU109flOGx0VgiqddrnLa2Fp0RD+7QA4g44xALzSDN1ClfxtOfbBahdaSz7SX471qcFGk1t1Va3bFjT1GaqdNoVl+Bv5jgytVSHlJhWasldKzdT1TdA7aYSBs3A80SrwpjlAVdy6xzhbLrcMZMeAzyxLqEj1J/smAx4sRPn1Upvf+OtP72DT1qnDx3HfgPgr3gsgoxoAEVF+fe6tVxtcb1zUInJzazoceB7HCmENyOvciFBJg2SpgvqgbO1RYow4iL7YnKdsM69/topO7Sfh9wQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jbI+/buGjCtQApKHZT2mE6xJIPhcOVo6RyE4VhUIvc=;
 b=jmM1vfVSZ4uCW148h0aZnhElJZiGqFmxYuMGKfxe6AvURPbzRBpcuwudZWjH8dMSOPMYpVeCs7aJ55vKCm4lKt3LtCCj8qSsHPIswIKNnfVE+dvJodXtiQOMjzifEQw6Z9sKAs/NMmX0BoozFWhDy3IUH+eJhQjtDle4c6gi7tGnPVMQ+X5JWiikQUqAc6yLN+I7B0RNoRYMRIY5gXvLj94U7E6KvnI6Hl9TUj09O0I8MSxd43M5fZjSXgPh7PgEfaE4ug331k5XytjVrgCJLfTilsHduHOjAPlXnCgtj3uWHB8TyrNISVehWDCcwDg8bqf0dda+KoARvt55UG432Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jbI+/buGjCtQApKHZT2mE6xJIPhcOVo6RyE4VhUIvc=;
 b=Tx6UbmOYN47/I9AFEwV99jiPNnWwzVE5xMu/Hi77eY2/JvSnJYL64jLjNo3eWSvD272VmhIj5Xxeu1b7cgkRNdyn62AFAB3AOdEKglR93TU2ACV1ZpY8KTl8FkNF2O1ZDf84yw+xx/qEsT3QdbK8LT9NRCq6uNbr/RKWJcTd/Ik=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB4428.namprd13.prod.outlook.com (2603:10b6:610:65::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12; Sat, 13 Feb
 2021 22:10:22 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3868.019; Sat, 13 Feb 2021
 22:10:21 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Topic: [PATCH] SUNRPC: Use TCP_CORK to optimise send performance on the
 server
Thread-Index: AQHXAkaKHQ4x2Pj5G0O0h0qlFPlIMKpWoMuAgAAErYA=
Date:   Sat, 13 Feb 2021 22:10:21 +0000
Message-ID: <f025fa709f923255b9cb8e76a9b5ad4cca9355c4.camel@hammerspace.com>
References: <20210213202532.23146-1-trondmy@kernel.org>
         <952C605B-C072-4C6B-B9C0-88C25A3B891E@oracle.com>
In-Reply-To: <952C605B-C072-4C6B-B9C0-88C25A3B891E@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 124453ce-c66a-440a-0522-08d8d06c27fc
x-ms-traffictypediagnostic: CH2PR13MB4428:
x-microsoft-antispam-prvs: <CH2PR13MB44282AED60B6EF168444A87CB88A9@CH2PR13MB4428.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ITlVIE9fo1PsCAU6DZTSu6edBkpBjkuc4d6guDAW2Dy/PJgUsuXUhWB5werxztFlAuKkW0mDLh7VisIQ9ZGovsb0TpA3jMPgauCdx0bfIP/afRt82TMtYj88xklL2tDMfrBShrQjeQUpLq7AZitkEDcv378/GU9ogsJTjRbd5DU7PjCqt7hRmPE30djp3qDVA2GXC5gNgcC9hiPqS+Bff7JgSv+hEAEEau29EL+3YNySiWCRzJp8cb56jD3YC2IOj5b4rrhU6kwcsQQ5sIE3SNJpkncBwbX6oWFmnNC5B4BzZyT8SdR6+7Wt+eHYfXTZdDcjYtcZ3HjZur+A+jelVF0JaRUc+zoLHSYRlOBAwATUDw9LFv4JdH8a9quuUZTpf4TBzHEG9ZSY2GfAar5fakSNnFxXWGZcJoAgg/eWNudJg3rKLdj008zER5RwIH72R3DpA1H1o7GSeuB7PNK+Z/ei7ArYjWaoISXv+S9dl5jUpQVugW325/Gs4jX2hIt3+IvYUZeVTg4UAI2uQQdrTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(8936002)(66446008)(2906002)(54906003)(36756003)(8676002)(6916009)(83380400001)(508600001)(5660300002)(66946007)(6486002)(76116006)(6512007)(186003)(26005)(66476007)(64756008)(66556008)(86362001)(4326008)(71200400001)(53546011)(2616005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dDBmTEdRUFUwOXN1S2gwS3VoTnJVbjdCay9RNnYyNFJrNGZIcmFvSTVxSnE3?=
 =?utf-8?B?SXlWeVhROFZTR1FoY3BGd3RLVmZhRFd2OTIxUWZlb1EwVVdsLzFDOGFiQTky?=
 =?utf-8?B?Q2tra1hlRzZSK0Y2ZEg0ci9KKzV0akdJVDlLNXV1YmZSZVptNU5oQm5oSU1T?=
 =?utf-8?B?SEVCb0o3ZHNqd2JBckF4cWc0b3dhUXdHamdSL2s0WXVpZ2R6OTlmNzc1UTJq?=
 =?utf-8?B?TW5aQjh0eFJ4TURJUEdDYzRZb29tdFNpMi84aGhad20vYUFsd2dNNE1SVDNP?=
 =?utf-8?B?RWxLK21wQi83L0s5eWZHd2JkM0x6OGlydVV6cU9jQ2tMbFo4QkVrekVYMGJO?=
 =?utf-8?B?TmJ4MTZHMHgwQnhJdG9pUk9RVFNvNXVzSUJucFRiN3VHQmxDa3oxT1p4dFJm?=
 =?utf-8?B?NDhvMm03UExBWnZCR0Y3UGtIOG1EbitNZTh6cTFFUUJIOGdmR2UzcFhzRGh6?=
 =?utf-8?B?U3dGbzliNnJnbC81NkVmam1pSWpQMFd3RURjdGJobVRkMThYd1IwMzJwejd0?=
 =?utf-8?B?alNVZS8yUmJCUFJtU3RaTkxBR3JlZ1A0Qkw2blBiQytKVTdGT3IxR2MwS0M5?=
 =?utf-8?B?cllnb0xGNU5MMkNsQnovR2RPdG1tR2JSZ2lPMmlIL2YrcEwzVnNUNzFsRVB2?=
 =?utf-8?B?WHAyamc2Tk95UERHOEJ2Q3BMSkcrR2RiWlh1bHBQelh1RGJYWlpMVThYZnJI?=
 =?utf-8?B?Y0JZcjZnVHg4M0wwSnBvczNYV0dCZkxiT0VMVzY4Unh3Z0t2d3FsbHJQd2w1?=
 =?utf-8?B?VEMwRXVJYkVtK2V5MFR0OVJrNHVjbnJiRjZqRlh0Um9Zc1JsWGw4SGFwZksx?=
 =?utf-8?B?OHo1TzdySitTYWxKS0d0SlNkdWZkMmJQcGtKdTdPdytNQkRzMmliTWQ0VmhZ?=
 =?utf-8?B?enUrbUdDakd5YVAzTXBlanpyZ1hkdjcwWkxqRi9yWXZ5UDlPNGhlM3JLRGRz?=
 =?utf-8?B?b2R3LzRyeWNtZVZrM3ZUQlN5ZjBmYnRtdjVZM0QzdTFUWGllMytIREdaK0sv?=
 =?utf-8?B?aFR2b2ZXWjNCYlZad3V4SFdZclVpR2VZQmhlYzhOS20rMnQwZ1hXZ3kxTkNx?=
 =?utf-8?B?aCthc0hkaHQvSCtkZEpCTm5LcmMvWGNLYmFpTXNUSTZWZi9RNm5MMUREMmlm?=
 =?utf-8?B?L0tKY2t5SXF2cVlxY0UrNW1ZM0VldUpnL2FCYW1QUEpMOEFjaW1iZmZoN3JO?=
 =?utf-8?B?eXFMQmREVjJtNkNua3F4cU4xYVBNSy9LNnRiU2JzYTBkSG9mQWlaMkRCT0xG?=
 =?utf-8?B?eW1mZGVSbEV0MS9CMDg1NUJoRGJUV3ZrbzcweDdxQ3lFaWszT3lPNmp2cExm?=
 =?utf-8?B?SnBlVEVmMlFOeFhZdVhVYndoZncyOXlnRWEvdkpSTlZnRU0wS2xyMllZTUp2?=
 =?utf-8?B?T0x0Y3BUWHF2NE0vMFo0U2J3OFVVWE5LbGc5MFM2ZjQyeDNUNk9GTjhQVm9v?=
 =?utf-8?B?czVvaSsxWW1PK0dJZXdtRWtJWGRXazNKRzc4bUhyZkVYWEFBTHNNa0I3a3BP?=
 =?utf-8?B?L0I0RXd5RUZ1aWFjZFBWN01ubWg3Zkl3aHluWXJrMjE0OVVST0xDRXVydURw?=
 =?utf-8?B?eXA5bFVET0RPOXRTbSswT0tlOU5mTERvWXZjL3RGSm1XT1l1MGRUcHl5TG4v?=
 =?utf-8?B?NjYvNmovMFZGVHIybEl2VkQzQlk4czl0a3JtaEJpL3R2UHZ0VW5VUDJEdkMy?=
 =?utf-8?B?TENzd2ZXTTJUUG52R2NmTTI1K1MxSlMrSm1XS2wzVzB6US82U012OWY5UTdJ?=
 =?utf-8?Q?bB+h3zEZj/NnBhv0VMTmlzWmyLpCPRspLKcc0UY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5DF3936B6321947B2E240F5D14DA6F8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124453ce-c66a-440a-0522-08d8d06c27fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2021 22:10:21.7269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5AGq5A0BeYAz3kbUaGbHuRKaPMLyFYSYWqSLF17pUuPwRUR8eStFPd8YjaOJzFHwUF4xXhllnbx9a8jXKKY4KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4428
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIxLTAyLTEzIGF0IDIxOjUzICswMDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
SGkgVHJvbmQtDQo+IA0KPiA+IE9uIEZlYiAxMywgMjAyMSwgYXQgMzoyNSBQTSwgdHJvbmRteUBr
ZXJuZWwub3JnwqB3cm90ZToNCj4gPiANCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gDQo+ID4gVXNlIGEgY291bnRlciB0byBr
ZWVwIHRyYWNrIG9mIGhvdyBtYW55IHJlcXVlc3RzIGFyZSBxdWV1ZWQgYmVoaW5kDQo+ID4gdGhl
DQo+ID4geHBydC0+eHB0X211dGV4LCBhbmQga2VlcCBUQ1BfQ09SSyBzZXQgdW50aWwgdGhlIHF1
ZXVlIGlzIGVtcHR5Lg0KPiANCj4gSSdtIGludHJpZ3VlZCwgYnV0IElNTywgdGhlIHBhdGNoIGRl
c2NyaXB0aW9uIG5lZWRzIHRvIGV4cGxhaW4NCj4gd2h5IHRoaXMgY2hhbmdlIHNob3VsZCBiZSBt
YWRlLiBXaHkgYWJhbmRvbiBOYWdsZT8NCj4gDQoNClRoaXMgZG9lc24ndCBjaGFuZ2UgdGhlIE5h
Z2xlL1RDUF9OT0RFTEFZIHNldHRpbmdzLiBJdCBqdXN0IHN3aXRjaGVzIHRvDQp1c2luZyB0aGUg
bmV3IGRvY3VtZW50ZWQga2VybmVsIGludGVyZmFjZS4NCg0KVGhlIG9ubHkgY2hhbmdlIGlzIHRv
IHVzZSBUQ1BfQ09SSyBzbyB0aGF0IHdlIGRvbid0IHNlbmQgb3V0IHBhcnRpYWxseQ0KZmlsbGVk
IFRDUCBmcmFtZXMsIHdoZW4gd2UgY2FuIHNlZSB0aGF0IHRoZXJlIGFyZSBvdGhlciBSUEMgcmVw
bGllcw0KdGhhdCBhcmUgcXVldWVkIHVwIGZvciB0cmFuc21pc3Npb24uDQoNCk5vdGUgdGhlIGNv
bWJpbmF0aW9uIFRDUF9DT1JLK1RDUF9OT0RFTEFZIGlzIGNvbW1vbiwgYW5kIHRoZSBtYWluDQpl
ZmZlY3Qgb2YgdGhlIGxhdHRlciBpcyB0aGF0IHdoZW4gd2UgdHVybiBvZmYgdGhlIFRDUF9DT1JL
LCB0aGVuIHRoZXJlDQppcyBhbiBpbW1lZGlhdGUgZm9yY2VkIHB1c2ggb2YgdGhlIFRDUCBxdWV1
ZS4NCg0KPiBJZiB5b3UgZXhwZWN0IGEgcGVyZm9ybWFuY2UgaW1wYWN0LCB0aGUgZGVzY3JpcHRp
b24gc2hvdWxkDQo+IHByb3ZpZGUgbWV0cmljcyB0byBzaG93IGl0Lg0KDQpJIGRvbid0IGhhdmUg
YSBwZXJmb3JtYW5jZSBzeXN0ZW0gdG8gbWVhc3VyZSB0aGUgaW1wcm92ZW1lbnQNCmFjY3VyYXRl
bHkuIEhvd2V2ZXIgSSBhbSBzZWVpbmcgYW4gbm90YWJsZSBpbXByb3ZlbWVudCB3aXRoIHRoZQ0K
ZXF1aXZhbGVudCBjbGllbnQgY2hhbmdlLiBTcGVjaWZpY2FsbHksIHhmc3Rlc3RzIGdlbmVyaWMv
MTI3IHNob3dzIGENCn4yMCUgaW1wcm92ZW1lbnQgb24gbXkgVk0gYmFzZWQgdGVzdCByaWcuDQoN
Cj4gKFdlIHNob3VsZCBoYXZlIERhaXJlIHRyeSB0aGlzIGNoYW5nZSB3aXRoIGhpcyBtdWx0aS1j
bGllbnQNCj4gc2V0dXApLg0KPiANCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVi
dXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IC0tLQ0KPiA+IGluY2x1
ZGUvbGludXgvc3VucnBjL3N2Y3NvY2suaCB8IDIgKysNCj4gPiBuZXQvc3VucnBjL3N2Y3NvY2su
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgIHwgOCArKysrKysrLQ0KPiA+IDIgZmlsZXMgY2hhbmdlZCwg
OSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvc3VucnBjL3N2Y3NvY2suaA0KPiA+IGIvaW5jbHVkZS9saW51eC9zdW5ycGMv
c3Zjc29jay5oDQo+ID4gaW5kZXggYjdhYzdmZTY4MzA2Li5iY2M1NTVjN2FlOWMgMTAwNjQ0DQo+
ID4gLS0tIGEvaW5jbHVkZS9saW51eC9zdW5ycGMvc3Zjc29jay5oDQo+ID4gKysrIGIvaW5jbHVk
ZS9saW51eC9zdW5ycGMvc3Zjc29jay5oDQo+ID4gQEAgLTM1LDYgKzM1LDggQEAgc3RydWN0IHN2
Y19zb2NrIHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgLyogVG90YWwgbGVuZ3RoIG9mIHRoZSBkYXRh
IChub3QgaW5jbHVkaW5nIGZyYWdtZW50DQo+ID4gaGVhZGVycykNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgICogcmVjZWl2ZWQgc28gZmFyIGluIHRoZSBmcmFnbWVudHMgbWFraW5nIHVwIHRoaXMgcnBj
OiAqLw0KPiA+IMKgwqDCoMKgwqDCoMKgwqB1MzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBza19kYXRhbGVuOw0KPiA+ICvCoMKgwqDCoMKgwqDCoC8qIE51bWJlciBv
ZiBxdWV1ZWQgc2VuZCByZXF1ZXN0cyAqLw0KPiA+ICvCoMKgwqDCoMKgwqDCoGF0b21pY190wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBza19zZW5kcWxlbjsNCj4gDQo+IENhbiB5b3Ug
dGFrZSBhZHZhbnRhZ2Ugb2YgeHB0X211dGV4OiB1cGRhdGUgdGhpcyBmaWVsZA0KPiBvbmx5IGlu
IHRoZSBjcml0aWNhbCBzZWN0aW9uLCBhbmQgbWFrZSBpdCBhIHNpbXBsZQ0KPiBpbnRlZ2VyIHR5
cGU/DQo+IA0KPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHBhZ2UgKsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBza19wYWdlc1tSUENTVkNfTUFYUEFHRVNdO8KgwqDCoMKgwqDCoC8qDQo+ID4g
cmVjZWl2ZWQgZGF0YSAqLw0KPiA+IH07DQo+ID4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMvc3Zj
c29jay5jIGIvbmV0L3N1bnJwYy9zdmNzb2NrLmMNCj4gPiBpbmRleCA1YTgwOWM2NGRjN2IuLjIz
MWY1MTBhNDgzMCAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvc3VucnBjL3N2Y3NvY2suYw0KPiA+ICsr
KyBiL25ldC9zdW5ycGMvc3Zjc29jay5jDQo+ID4gQEAgLTExNzEsMTggKzExNzEsMjMgQEAgc3Rh
dGljIGludCBzdmNfdGNwX3NlbmR0byhzdHJ1Y3Qgc3ZjX3Jxc3QNCj4gPiAqcnFzdHApDQo+ID4g
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHN2Y190Y3BfcmVsZWFzZV9ycXN0KHJxc3RwKTsNCj4gPiAN
Cj4gPiArwqDCoMKgwqDCoMKgwqBhdG9taWNfaW5jKCZzdnNrLT5za19zZW5kcWxlbik7DQo+ID4g
wqDCoMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJnhwcnQtPnhwdF9tdXRleCk7DQo+ID4gwqDCoMKg
wqDCoMKgwqDCoGlmIChzdmNfeHBydF9pc19kZWFkKHhwcnQpKQ0KPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXRfbm90Y29ubjsNCj4gPiArwqDCoMKgwqDCoMKgwqB0
Y3Bfc29ja19zZXRfY29yayhzdnNrLT5za19zaywgdHJ1ZSk7DQo+ID4gwqDCoMKgwqDCoMKgwqDC
oGVyciA9IHN2Y190Y3Bfc2VuZG1zZyhzdnNrLT5za19zb2NrLCAmbXNnLCB4ZHIsIG1hcmtlciwN
Cj4gPiAmc2VudCk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHhkcl9mcmVlX2J2ZWMoeGRyKTsNCj4g
PiDCoMKgwqDCoMKgwqDCoMKgdHJhY2Vfc3Zjc29ja190Y3Bfc2VuZCh4cHJ0LCBlcnIgPCAwID8g
ZXJyIDogc2VudCk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChlcnIgPCAwIHx8IHNlbnQgIT0g
KHhkci0+bGVuICsgc2l6ZW9mKG1hcmtlcikpKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZ290byBvdXRfY2xvc2U7DQo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKGF0b21pY19k
ZWNfYW5kX3Rlc3QoJnN2c2stPnNrX3NlbmRxbGVuKSkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgdGNwX3NvY2tfc2V0X2Nvcmsoc3Zzay0+c2tfc2ssIGZhbHNlKTsNCj4gPiDC
oMKgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZ4cHJ0LT54cHRfbXV0ZXgpOw0KPiA+IMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gc2VudDsNCj4gPiANCj4gPiBvdXRfbm90Y29ubjoNCj4gPiArwqDC
oMKgwqDCoMKgwqBhdG9taWNfZGVjKCZzdnNrLT5za19zZW5kcWxlbik7DQo+ID4gwqDCoMKgwqDC
oMKgwqDCoG11dGV4X3VubG9jaygmeHBydC0+eHB0X211dGV4KTsNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIC1FTk9UQ09OTjsNCj4gPiBvdXRfY2xvc2U6DQo+ID4gQEAgLTExOTIsNiArMTE5
Nyw3IEBAIHN0YXRpYyBpbnQgc3ZjX3RjcF9zZW5kdG8oc3RydWN0IHN2Y19ycXN0DQo+ID4gKnJx
c3RwKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGVyciA8IDApID8g
ZXJyIDogc2VudCwgeGRyLT5sZW4pOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBzZXRfYml0KFhQVF9D
TE9TRSwgJnhwcnQtPnhwdF9mbGFncyk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHN2Y194cHJ0X2Vu
cXVldWUoeHBydCk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgYXRvbWljX2RlYygmc3Zzay0+c2tfc2Vu
ZHFsZW4pOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJnhwcnQtPnhwdF9tdXRl
eCk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUFHQUlOOw0KPiA+IH0NCj4gPiBAQCAt
MTI2MSw3ICsxMjY3LDcgQEAgc3RhdGljIHZvaWQgc3ZjX3RjcF9pbml0KHN0cnVjdCBzdmNfc29j
aw0KPiA+ICpzdnNrLCBzdHJ1Y3Qgc3ZjX3NlcnYgKnNlcnYpDQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBzdnNrLT5za19kYXRhbGVuID0gMDsNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoG1lbXNldCgmc3Zzay0+c2tfcGFnZXNbMF0sIDAsIHNpemVvZihz
dnNrLQ0KPiA+ID5za19wYWdlcykpOw0KPiA+IA0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB0Y3Bfc2soc2spLT5ub25hZ2xlIHw9IFRDUF9OQUdMRV9PRkY7DQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRjcF9zb2NrX3NldF9ub2RlbGF5KHNrKTsNCj4gPiAN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNldF9iaXQoWFBUX0RBVEEsICZz
dnNrLT5za194cHJ0LnhwdF9mbGFncyk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBzd2l0Y2ggKHNrLT5za19zdGF0ZSkgew0KPiA+IC0tIA0KPiA+IDIuMjkuMg0KPiA+IA0K
PiANCj4gLS0NCj4gQ2h1Y2sgTGV2ZXINCj4gDQo+IA0KPiANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
