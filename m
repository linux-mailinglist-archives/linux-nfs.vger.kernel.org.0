Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E98142EA72
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Oct 2021 09:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhJOHoZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Oct 2021 03:44:25 -0400
Received: from mail-dm6nam10on2133.outbound.protection.outlook.com ([40.107.93.133]:48438
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231635AbhJOHoZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 15 Oct 2021 03:44:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYyN74Y8cAkfpc8lFg2w47T3UP0Ep9Bm16ZO4S8pd/MD5pkDAjw6qZIr7s8ATQVA043bTS9zshAg/1CY56zED2R9SoW99mKS2gqP2/Xwu2U42R5E6fvJYA5ND95uM8VyR7jqHl56bIdhB3Dbse75V9zyxE55g01ZTVftpWFtSgZ1FhG6siOF3AsPbEsXJIXSQPsBRD43GcNTZNAqC0PPKfLcUKt/oTiyMPxAshknPHWBTV8RAP5KoZoAJvyT5JimaZ7dEFbB8rXMEot++UAQY5TGyf+d4PHMnZ/7+vZlP0cRyDWE6bw3fd4Q5zXhhdZ/DKkWVdrNhwv8nRks/6DJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukc5Byc9wRFRZA7PkIZqQGmdRVfKYKU9dHjmC8twkm4=;
 b=SpZsMSZ3+5P9IWIRFBjVhany3m44G+wiEXx6wdvxoDp+4QHKtKBsWh/+WVXv+BuieFdqYxRD7WSQqKyAk9riE1/+wZKIDoSgRMS9awG+VMl6pT/idyenjfL33JnoF3k20I2A6Z6T/5fAQQ1FPqXy+600rTgpw0U0Gsey5l91U4lh+DZG0MTlIrYoF3M381P5ZWrUQVzuX3k23kTGfm/6kGlomkZwRWTf2dYvr9A8+zWsEbWSbJvhoLBusQnCUpJRsvQG5Gk8ia094c7wKcDQ5eOHgvcyz0aFAgspYnPfDWEhIFbDgz4g7Cqs8l4yDKgrGtqaSZDU+all6MKJHGRrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukc5Byc9wRFRZA7PkIZqQGmdRVfKYKU9dHjmC8twkm4=;
 b=Ml6SF1pC+3rkt0N1r6AsuwZBrr6tcyXDoXuwwqbFQcy1i2nN1cdN0pmybL05PYjmIuic0wL2oEtyWUZppFqS5ss/0woKuydg31Vp6K7nF2r3J546GcetPD//9Jk/S488bb2FVTy40MoDtjtyn3iR3LIZ6XpUBTHANlBchFKhQkY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3573.namprd13.prod.outlook.com (2603:10b6:610:26::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.12; Fri, 15 Oct
 2021 07:42:16 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%7]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 07:42:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] NFS: Convert from readpages() to readahead()
Thread-Topic: [PATCH 1/1] NFS: Convert from readpages() to readahead()
Thread-Index: AQHXu9PCRhIgoA2dZ0ipW9xtm9oQyavJJJ0AgAqUEYA=
Date:   Fri, 15 Oct 2021 07:42:16 +0000
Message-ID: <1fe6dbeac820b58f0790dcff492b62b7dd7e4fea.camel@hammerspace.com>
References: <1633649528-1321-1-git-send-email-dwysocha@redhat.com>
         <1633649528-1321-2-git-send-email-dwysocha@redhat.com>
         <3F1E7B93-EB8D-4744-8143-D44654CA6451@oracle.com>
In-Reply-To: <3F1E7B93-EB8D-4744-8143-D44654CA6451@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97e80e5b-9a3b-4b63-bfca-08d98faf4f73
x-ms-traffictypediagnostic: CH2PR13MB3573:
x-microsoft-antispam-prvs: <CH2PR13MB3573CF8E7D7CCE06559FA1F6B8B99@CH2PR13MB3573.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CLM+RNeLBySMEu9KDOxCAf1/Bm65++93WZnfBYXzlSHKJ6BuJ8/qQcKSEvTgHyTYE2APHn7rUI/wxL2Wbj+DevoW9rTcBMZJmB+teA4maMYEna+FRD3XKYcaYjpW4xNM3NnuS5Tthw6DrCZKc8Lu6xu+Y0AzhWCnxsfekuFb1vTq0hf0Gh65IyBCUUf8cdNzAklfZxbUNzNchm/m6C4E0JDOYGg9nvJ6fJZgpzG2ep5nMcB9sfVBYLSl7V4Ah93jHii4NImRGz5VnOvbOQMz5+ZE0lCrmYdK0FBiAp0ksqZLBCoMs8DLH/UewrvwHBp1dHnSg44xvKpL/SN6HzbvT0sX5vLFK4LrqTERPUwLBrjOejLqmJ7/jF4TBKibsDCF8shiGr0bu9zMS2z06WKavM86AOvt+ET2yufRP30l66fFKbRt95CMZbUEjGUcIuMXzhUvDgxC2fS1TEAz3ODSZPlHVWVIv6d1PXSyWMkWI1A2p5JrcvIEmh/5T6UWH0acCI8JPCGPh0BLA2UAdWlDD8kZXBlB73DUusUbKv5/wOdj9bK+7LbjvVIA1tLzPCCM8ZhH6jPc2HeEeX3qSg51NFdNWy9rEHF9tAg6EMb5lc4x3K+3dRqnvbcP1nP567KHhP20zlgcexNS88VqLsyrdcLIJ6vtd5zbKvw8tzY4Pr1+jLGY+EmfRbmR7Pl5362DXt5rzNaEg0VFBDvCTAYUqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(4326008)(186003)(2616005)(8936002)(86362001)(6506007)(83380400001)(5660300002)(71200400001)(2906002)(66556008)(508600001)(38100700002)(66476007)(8676002)(26005)(6512007)(76116006)(91956017)(64756008)(36756003)(38070700005)(122000001)(54906003)(66946007)(53546011)(110136005)(66446008)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFVXbVVPRmVkTktsTjQrWG5QM2VyMG1nb2ZMakNBRE5maU0wMWhSUnIwSVp5?=
 =?utf-8?B?TS9jSUVraTQ3a0lMUFNVcXRyQzJ0WnYrSXZTbVh0ZzlGTytKN3ZMY1djaVlX?=
 =?utf-8?B?QzFobUFGeHd0eDJ4MG52Z3o2N1poMXh3bkgxUVBUUlpQenFWanpUbXBsM0ZF?=
 =?utf-8?B?OGRGOGp2RTJtV2Q4YUdBR1R1ckRvekhnd1Nqa3MxOUJmQitFeEs2TnVyMTkz?=
 =?utf-8?B?NldlR1ExeHQ1dmFkWSsyeHhDMUd3cEJ2ZVUyWTZQUXo2dnRJNkE3am8wVEUx?=
 =?utf-8?B?ZDN5T3VsRUpCOFZxdzVXUlozd3pxaXkyNWVGY0oxZGpKa1RKenkvNGsxK3RB?=
 =?utf-8?B?dnlpUUJhL1BGYnQ5Tkt5UzMrc0lOVUtjY0ZBRHZmWkgzdmVuS3A4Y2NLOUlt?=
 =?utf-8?B?MkZ2dWJML085R01IY0RLQVp4LzgxbmYrdVdib1BoUDJFWFRQMWg0UXIwMVJS?=
 =?utf-8?B?ZmRDeTZqSHV3bDdoRElvd1Q4ZWlZRFpyTUV4U2VVS0dyRnVPcUg2T3hCd2RD?=
 =?utf-8?B?YzhDK3VpVUd5YVc5TEd6dnBCSFhaUmFrMHllQnRYSUV6MzZuR0dncDA3VCtY?=
 =?utf-8?B?QllVM291WWhoM2RzQVRWTlNNQ3lXSS9LTnVyU2JPNkJycGhDdGNXaTVWaTBj?=
 =?utf-8?B?MkswSUlSOFUwcmdjZ2tQNHlTLzRuUW1OMmFic2xIMzZkTVFzVmdyQXRHeERP?=
 =?utf-8?B?aENOL2JRVzZVb3oxOGV5eDI0SDhTSXVzY1czc0VBUWhpUmtzVExRR3Q0OE5V?=
 =?utf-8?B?NTZYVEZqRUQwck9LaUYvdWM2SmpmKy9MOGtScW1wWXRxMXN2NWx2d1E4RFhY?=
 =?utf-8?B?QWkxZk8vUnJNSUl3TGVRaXNNRTdCUnZIZ3g2T3Bmbzh1aXdVRjVTYVdiMjI2?=
 =?utf-8?B?TnVsSGxQQzc1bUdTYm4yU0w2UHp1Y2NjbFgzQUNPbUNIYXZNQzFqNjNkTGsr?=
 =?utf-8?B?bldoRFYzNHVUczdoWFJHRjFUUnJlUkF5cjZkVnJpSVFVNjJ4YmhCbHBEaVhR?=
 =?utf-8?B?dDloZ0VBMmxmY3NtQ2JPSDl2L3dIa1RFUVVXZVRyT2FSUGVvM2tyUG1mckZl?=
 =?utf-8?B?WE1MWXhyaDZiM1A3N2tYeXhRN25DY2hxVGd6QVdiMmFNUlRxN1F1dk5TWHVB?=
 =?utf-8?B?bVlwZ2FxYmpxT3FQZnhWSUpCQ0g5NnNza2ZtWlFEOEVndWx6UG1KQk5RRjZ2?=
 =?utf-8?B?UXo2Qzd1M3IwZ0FQSU4wQUlKK3ROSjl6UDRDTFlVMHdzR1lSMGxtTHNXTGtK?=
 =?utf-8?B?TitGMjZQUlc2QkI0Qkw3V2cxc3JtemlZVEt2MGJoY0UxRVhLNnQ1NkR0bXJo?=
 =?utf-8?B?M3FtQVZHZEhrbnI4dkhrS1dFU3Rlb3NCdFppU29LQjgzTVM0T3NFOXZzRnNS?=
 =?utf-8?B?NkZGVUZlU2l5VUNpd1FaSUdTR2duUzBLYUxjeXNDcWpTK1FQYS9HSFpiSG5m?=
 =?utf-8?B?cURJTjNUc0wwYzg0bnc3UlJjdDBtNmRHdXcvdDkyblJaOEpYcStvaDVoRzhK?=
 =?utf-8?B?ejFTUUZPZkhwZTlyak9BbXh6ZkZ4QzZYK3JTUkZJam9iNHlhZERMZDU3dmV1?=
 =?utf-8?B?T0NpZCs0dFQya1gxdVpwSFJRSVUwNVc0YVhtMWpESkFLZ3RML3BHYUFhZGps?=
 =?utf-8?B?R1dYeERnY1RFNkFoc2NveFJCd0NDTkR6V2hUbGVlK0FKSmkyVUtZWUNoSm1u?=
 =?utf-8?B?YlY0SGgyaXJwbzUzMEZSTXZ6eTl4UUNRc1o1UW1TN3dVYmVOdDlFVFk3WFlq?=
 =?utf-8?B?b0syTmc0SHpIR1JMY2R5WFMrWTExamQ3aHZ4NjBLbzVTeEU1dmtieXQyUE1B?=
 =?utf-8?B?UHJsT0lNcXd1aW8xOVdSdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <52605B26948F08419EE8C5E29235C3E6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e80e5b-9a3b-4b63-bfca-08d98faf4f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 07:42:16.1718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMTMeWx1x9ZlpsjnkGk0I0DW/LVlm2kAj9eqx8DiIKTUyIy1JRR9xcX8BGsKRhE9+Q5ZCryxrNzo38ZpmfhfjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3573
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTEwLTA4IGF0IDE0OjA5ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBPY3QgNywgMjAyMSwgYXQgNzozMiBQTSwgRGF2ZSBXeXNvY2hhbnNr
aSA8ZHd5c29jaGFAcmVkaGF0LmNvbT4NCj4gPiB3cm90ZToNCj4gPiANCj4gPiBDb252ZXJ0IHRv
IHRoZSBuZXcgVk0gcmVhZGFoZWFkKCkgQVBJIHdoaWNoIGlzIHRoZSBwcmVmZXJyZWQgQVBJDQo+
ID4gdG8gcmVhZCBtdWx0aXBsZSBwYWdlcywgYW5kIHJlbmFtZSB0aGUgTkZTSU9TXyogY291bnRl
cnMgYW5kIHRoZQ0KPiA+IHRyYWNlcG9pbnQgYXMgbmVlZGVkLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IERhdmUgV3lzb2NoYW5za2kgPGR3eXNvY2hhQHJlZGhhdC5jb20+DQo+ID4gLS0tDQo+
ID4gZnMvbmZzL2ZpbGUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICstDQo+ID4g
ZnMvbmZzL25mc3RyYWNlLmjCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4gPiBmcy9uZnMv
cmVhZC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyMSArKysrKysrKysrKysrKystLS0t
LS0NCj4gPiBpbmNsdWRlL2xpbnV4L25mc19mcy5owqDCoMKgwqAgfMKgIDMgKy0tDQo+ID4gaW5j
bHVkZS9saW51eC9uZnNfaW9zdGF0LmggfMKgIDYgKysrLS0tDQo+ID4gNSBmaWxlcyBjaGFuZ2Vk
LCAyMSBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZnMvbmZzL2ZpbGUuYyBiL2ZzL25mcy9maWxlLmMNCj4gPiBpbmRleCAyMDlkYWMyMDg0Nzcu
LmNjNzZkMTdmYTk3ZiAxMDA2NDQNCj4gPiAtLS0gYS9mcy9uZnMvZmlsZS5jDQo+ID4gKysrIGIv
ZnMvbmZzL2ZpbGUuYw0KPiA+IEBAIC01MTksNyArNTE5LDcgQEAgc3RhdGljIHZvaWQgbmZzX3N3
YXBfZGVhY3RpdmF0ZShzdHJ1Y3QgZmlsZQ0KPiA+ICpmaWxlKQ0KPiA+IA0KPiA+IGNvbnN0IHN0
cnVjdCBhZGRyZXNzX3NwYWNlX29wZXJhdGlvbnMgbmZzX2ZpbGVfYW9wcyA9IHsNCj4gPiDCoMKg
wqDCoMKgwqDCoMKgLnJlYWRwYWdlID0gbmZzX3JlYWRwYWdlLA0KPiA+IC3CoMKgwqDCoMKgwqDC
oC5yZWFkcGFnZXMgPSBuZnNfcmVhZHBhZ2VzLA0KPiA+ICvCoMKgwqDCoMKgwqDCoC5yZWFkYWhl
YWQgPSBuZnNfcmVhZGFoZWFkLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqAuc2V0X3BhZ2VfZGlydHkg
PSBfX3NldF9wYWdlX2RpcnR5X25vYnVmZmVycywNCj4gPiDCoMKgwqDCoMKgwqDCoMKgLndyaXRl
cGFnZSA9IG5mc193cml0ZXBhZ2UsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoC53cml0ZXBhZ2VzID0g
bmZzX3dyaXRlcGFnZXMsDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnN0cmFjZS5oIGIvZnMv
bmZzL25mc3RyYWNlLmgNCj4gPiBpbmRleCA3OGIwZjY0OWRkMDkuLmQyYjIwODA3NjVhNiAxMDA2
NDQNCj4gPiAtLS0gYS9mcy9uZnMvbmZzdHJhY2UuaA0KPiA+ICsrKyBiL2ZzL25mcy9uZnN0cmFj
ZS5oDQo+ID4gQEAgLTkxNSw3ICs5MTUsNyBAQA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgKQ0KPiA+ICk7DQo+ID4gDQo+ID4gLVRSQUNFX0VWRU5UKG5mc19hb3BzX3JlYWRw
YWdlcywNCj4gPiArVFJBQ0VfRVZFTlQobmZzX2FvcHNfcmVhZGFoZWFkLA0KPiANCj4gSW4gdjIg
YW5kIHYzIG9mIG15IHBhdGNoLCB0aGlzIHRyYWNlcG9pbnQgaGFzIGFscmVhZHkgYmVlbg0KPiBy
ZW5hbWVkIHRvIG5mc19hb3BfcmVhZGFoZWFkLg0KDQpEb2VzIHRoYXQgbWVhbiB5b3UncmUgZ29p
bmcgdG8gcmVzZW5kLCBDaHVjaz8gQWxsIEkgaGF2ZSBpcyB5b3VyIHYxLi4NCg0KDQoNCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
