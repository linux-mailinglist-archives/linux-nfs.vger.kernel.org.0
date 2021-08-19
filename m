Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C963F19E9
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Aug 2021 15:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhHSNCS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Aug 2021 09:02:18 -0400
Received: from mail-mw2nam12on2117.outbound.protection.outlook.com ([40.107.244.117]:11713
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239249AbhHSNCS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Aug 2021 09:02:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GveQGpRAlYi2q22/rglG3Q6ZhpyHpiaTrcj6OFjfGcAiAQXI7wgCb/bU+JNNXNBejZiIH4YrC2b01LpRRKtcRcLs7NJRVrj/EUTtIt+1WmSRPSCJQvwuPCr3IXOold2CrY01e1yeepXd9klu9DnIOWY0d8wb5aTk6Hk6KeX1jT8qpzYAj388mG3k4ODSkOrdrJh4xphtDB2a8qw5qmbsSF2azFQXsBgVBo7DVK4o7zhIEoj9l/uYMqbUtxWhAYQgCSzA0B3gTWiV0flqeC3Ut/VQTs/ofoSB51pSP4NYJ+6FuFu0I4gy5QL0ACEcxgJcbLRtwnPqAYVqwqY0/BSYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBrz6UlhgnS5IM1OiokmtAsmvPDZf2+Kl1tXkTx0M9s=;
 b=LxWevGhjLmwfgmcYPsuXyYKVVxZOEcoznMGJGl0HKrC0QA+cfUPjsM+CY3jO4D1cIOrpVPVqSN8ckMMG3RbkjKEIvEnAlG5HXmw2w/g2axyCgnPW/uDJUTJNXTDkuDD9gO98hjMdaNV6MpqWyQWfQHQwn2kpBHVsjnY6y2b1UR4ejVAY/YVcXql0zcwPz2RgxIRCJIyXJuu0OoaQpsGHo4+79YVtPzZbLztQ2HUXxrxTvywY3xYz53SWqiGfGO9hB6oz/ovPD4p8Xuo5XeMJHPZvODZoSo1hSuICXdBAZ9j7szbqvp4posUi7MRILUzV9fGeXZqQEpDfyIh/6QZH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBrz6UlhgnS5IM1OiokmtAsmvPDZf2+Kl1tXkTx0M9s=;
 b=XIpPMRr18hbEWutuFyWstI06wRby0bWplAgZD3Jmp0UEb0Ty8KpbP5dwbeF+rDBYtBh6mQ90nKPQlKswk2WM3vlEFHxIwTu+61uQMqTcLrm1PePuadvFm1cxqKUqaQXs3Ag80TWS/q8Xbs1+T+8KPZR0W7JNHaHL/+gyMtTZ6ig=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3752.namprd13.prod.outlook.com (2603:10b6:610:a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9; Thu, 19 Aug
 2021 13:01:38 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%7]) with mapi id 15.20.4457.006; Thu, 19 Aug 2021
 13:01:37 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v1] SUNRPC: Ensure backchannel transports are marked
 connected
Thread-Topic: [PATCH v1] SUNRPC: Ensure backchannel transports are marked
 connected
Thread-Index: AQHXlPXbrsxTI02VrkeJ/wH346Zxu6t6ysMA
Date:   Thu, 19 Aug 2021 13:01:37 +0000
Message-ID: <ed3fbd005a9a2e3a6217085ebe05e80cd78766ba.camel@hammerspace.com>
References: <162937592206.2298.13447589794033256951.stgit@klimt.1015granger.net>
In-Reply-To: <162937592206.2298.13447589794033256951.stgit@klimt.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbd85b21-8089-4e6c-8b92-08d963117af6
x-ms-traffictypediagnostic: CH2PR13MB3752:
x-microsoft-antispam-prvs: <CH2PR13MB37522972D234613A36B9C43CB8C09@CH2PR13MB3752.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/qMvqGQ2aiyymLr3PHfU5dlqtAks687qzKtLj532OwXroQhZp/P+qD5ToXIu3vgzLD0/1xAUFiQSuDevpEjbVyh/XLnbJFYdCR+o9PhOGShRZqHCU6b2y5Hh8zZnoUnw7RnqsA/81v6U4FB74FeoZX892qlSvJvI4g1SE9fKl13W5bODXD+7YBjlsHnmlL+5UUIRCqGJ99g7afzcqveT3jQJeGDKxvnZT0+djeETVb/7kis+5T31EdM0Z7iqhss27h2KlGgvzLZ4l4t2PRBI9bwqtVhtTsFVcyNGSuPcX0ceWGhPleB13p7qelOzHsCHk/i+LdrkJQUF2kd3YCqBOG8ZhWiDrZpQEt2D1lXUHyrjcKJaBSaw9DQaNfHWAuyo+EwVLjYY/n7Dv27quLdK55iFyhHf6txtHPYljdJbMLwAkIUpEyINk6v4yTrfzWDWfaGqpgHIce1SWVwIUebM6v0V6dVfWkvM7bZB3JzcQb/OHJPVey6k44W+M2T9+bMgkLhZDI2G59X0paiRWj0hdtRYHycuKmpslvaGaaM0sOlPC70sirYGrudhcrPjqobdQsNLqctsOaQfDbzpYHoTHY3eGC0sX8vs4usehgEYnC/N50l7kK26qMn4b8sNhHwVIITC40kft0H+OA9UzkinhYaNw2icDF+BC9Cc+CCoKWbX+FHzjlKvF7Sd/n3cJh9va/mlEOvvUrYCRPpiQG8o81fVi16f238zV1xWguUp70=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(376002)(396003)(366004)(136003)(110136005)(26005)(2906002)(38100700002)(6506007)(478600001)(66946007)(6486002)(8936002)(71200400001)(122000001)(66556008)(66446008)(76116006)(64756008)(38070700005)(8676002)(66476007)(186003)(6512007)(5660300002)(86362001)(36756003)(2616005)(316002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDJoVmxmTTlNTG1TVGl0QUNmQUpuYk9JZndDY1puVm1DbXlHVFF6ZkdrY01G?=
 =?utf-8?B?bWFHc3RGbEw3RFJyT3ZjMWU4TG9VK2NvMlV1MkVxTzl1ZzFDalRUYSt0VWw2?=
 =?utf-8?B?NHlwZm1NanVXQXRhZi85dlgzbzdvRndPaHNER0FhcmlaRk55Q3ROUUovMGFZ?=
 =?utf-8?B?Y21ieTZQZ0Y1NldzRGR6MThJbnUwU3pNVE9zUEtPUVVmelo2OEZkbUcrSVM4?=
 =?utf-8?B?NlVYNXFBa3FJNytvSjdSRDhSTXFNbGFhRkVBZFEySGN3Zm8rTTljRjc0emtx?=
 =?utf-8?B?NXMvZEJVWUlmUVhDNEhqbHBWdUM3OVo1bDBBcitrWG5weFhkMXBuVGcxcGRj?=
 =?utf-8?B?czdYbHFNNm1qbkhGVUJDMDM4VlY0N2ZnN1ZVMVBOZ2NDUUd2V3VYWXZ4bklB?=
 =?utf-8?B?TVcxNkh2VHgwUWpqTFExaVRQRGx5R2twWmZtdDY3MVF2L3E3blZMWTBYQUgv?=
 =?utf-8?B?K0FwWTNWbmxVL2lqMTRBdGRVQ1d0NzEvN2tROTllV1JJR3pFdi8wbi9pcG9z?=
 =?utf-8?B?YXlCRVR2dStUclZFOERWaHVjOHpMM2taS3dNUjBnQmVWUjhHb2d3blYwelNr?=
 =?utf-8?B?eFJIWUxuOGVzOUZTTjdna2NUUVJiekZ3dGIyM3lPRjFLMnBhM2ozdVlPZlRS?=
 =?utf-8?B?MGhYN0Q1YXpBb3ZMUjZWMUJ5RUlSaW5heGh5NXR2VjBod1ZvbjY1MyttaVJh?=
 =?utf-8?B?TWtueUVJd1NQajU3UTh2Vm5NQWRjV0lLNHBDSVNOM3h3YzdNSDZsYXZCUkNH?=
 =?utf-8?B?TzQ4dGZKeHVxQUtVN2VuZEo5S0RCZS9sNjNzVVhieFRYRDRWUHh4NVQ2Ukdz?=
 =?utf-8?B?bGhzZnJCT1NrZnhDdFJNWjVpZm1Ya3BjVUx4WklOeklOWERRci9yczFRMnRL?=
 =?utf-8?B?Q2pJcGU4QmMwMGo0RDNrWlh0NGJ2emZqSFJiczJEbWRxRXVBTTZqMlJ1aUQ3?=
 =?utf-8?B?MlRXekEwMThhUExvdUYwYUE4bmZMOWJSYm9ZZjk3MmRmMjZURXMxK3lIa01Q?=
 =?utf-8?B?U1VWSTZqQ3J4NlBRbkZabXg3MzJmZzNHTDROQzExUytuc3ZFQ3dPRVVYWWlp?=
 =?utf-8?B?b2poOUU0UzR0VkZnd2V2Q1k0VjcyMGNPRnhMZ1JIZ2ZaWmQ1OXRjMW5wRGt6?=
 =?utf-8?B?MEZXRmhZOGFzQUMvNW4vbk1lcEtGRVUxNzc5b1RCdVNmSDZWeFVsbGZDeGFy?=
 =?utf-8?B?MnhFbDE0UFEzR1RTdnRvang3RUNxckp0eUVHTUI1dUdIeHdzU1lWOXNBUWlK?=
 =?utf-8?B?RGNQU1F0dU4vNllFdDJqamFlbjdvQjBpK2JjRk9kRzV4V2FSU1Q1T05iY2E5?=
 =?utf-8?B?TzJJdkJ6YnZNcWFUSHJoNndrSGhhcWh5QXJNT0NETTRKcUx4ZkNWNTYzY1BO?=
 =?utf-8?B?Tk1OQVl0M3VDTk04b2hCbUhtWlh6VXZpNEZZODNqQUhNRlJ4TCs0M2lVdU9V?=
 =?utf-8?B?ak4xVnVubmtNN2RKVGRjYy9CcGtzMU1mRkV2V2d4SmRrcTNjUzYrTGplWjdB?=
 =?utf-8?B?dk9rMmlPN2hjb2JyakM4dkJXcmM1OE1lUGlCNnV2Q1pFMnJGZGh5NHhTNCta?=
 =?utf-8?B?UC9BLzBheDF1WE1KK2tLTlgyQW5aTWVkY2xUaGpPZlFGUS9vc1dWQU90cmJF?=
 =?utf-8?B?andhUytMVzQrM0ZlN0U0MVNGREF3RW1zNGFYWmVpY1pkeWtQeU9QMUY5Y0RT?=
 =?utf-8?B?QWh5eXFkVU1KamREd0JMVkNub2Z0dGErTG5VbkFVN3VMS1J0NElpWitJd0NZ?=
 =?utf-8?Q?7GjO8SiqjEi10T5wTQ/D6I8o37bJM81OYyMXk3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D660F36D3A014A4DB9E001193CAED54F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd85b21-8089-4e6c-8b92-08d963117af6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 13:01:37.6525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlROBGy7m1Bq188srVtytTTLkCzWirCdNdXESeYGaLCIGKN2oa9eT65hP+iV16pJ+rRy/mJKaCwjr3/P05yKAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3752
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTA4LTE5IGF0IDA4OjI5IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
V2l0aCBORlN2NC4xKyBvbiBSRE1BLCBiYWNrY2hhbm5lbCByZWNvdmVyeSBhcHBlYXJzIG5vdCB0
byB3b3JrLg0KPiANCj4geHBydF9zZXR1cF94eHhfYmMoKSBpcyBpbnZva2VkIGJ5IHRoZSBjbGll
bnQncyBmaXJzdCBDUkVBVEVfU0VTU0lPTg0KPiBvcGVyYXRpb24sIGFuZCBpdCBhbHdheXMgbWFy
a3MgdGhlIHJwY19jbG50J3MgdHJhbnNwb3J0IGFzDQo+IGNvbm5lY3RlZC4NCj4gDQo+IE9uIGEg
c3Vic2VxdWVudCBDUkVBVEVfU0VTU0lPTiwgaWYgcnBjX2NyZWF0ZSgpIGlzIGNhbGxlZCBhbmQN
Cj4geHB0X2JjX3hwcnQgaXMgcG9wdWxhdGVkLCBpdCBtaWdodCBub3QgYmUgY29ubmVjdGVkIChm
b3IgaW5zdGFuY2UsDQo+IGlmIGEgYmFja2NoYW5uZWwgZmF1bHQgaGFzIG9jY3VycmVkKS4gRW5z
dXJlIHRoYXQgY29kZSBwYXRoIHJldHVybnMNCj4gYSBjb25uZWN0ZWQgeHBydCBhbHNvLg0KPiAN
Cj4gUmVwb3J0ZWQtYnk6IFRpbW8gUm90aGVucGllbGVyIDx0aW1vQHJvdGhlbnBpZWxlci5vcmc+
DQo+IFNpZ25lZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0K
PiAtLS0NCj4gwqBuZXQvc3VucnBjL2NsbnQuYyB8wqDCoMKgIDEgKw0KPiDCoDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMvY2xudC5j
IGIvbmV0L3N1bnJwYy9jbG50LmMNCj4gaW5kZXggOGI0ZGU3MGU4ZWFkLi41NzA0ODBhNjQ5YTMg
MTAwNjQ0DQo+IC0tLSBhL25ldC9zdW5ycGMvY2xudC5jDQo+ICsrKyBiL25ldC9zdW5ycGMvY2xu
dC5jDQo+IEBAIC01MzUsNiArNTM1LDcgQEAgc3RydWN0IHJwY19jbG50ICpycGNfY3JlYXRlKHN0
cnVjdA0KPiBycGNfY3JlYXRlX2FyZ3MgKmFyZ3MpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgeHBydCA9IGFyZ3MtPmJjX3hwcnQtPnhwdF9iY194cHJ0Ow0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICh4cHJ0KSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHhwcnRfZ2V0KHhwcnQpOw0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHhwcnRfc2V0X2Nvbm5lY3RlZCh4
cHJ0KTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIHJwY19jcmVhdGVfeHBydChhcmdzLCB4cHJ0KTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB9DQo+IMKgwqDCoMKgwqDCoMKgwqB9DQo+IA0KPiANCg0KTm8uIFRoaXMg
aXMgd3JvbmcuIElmIHRoZSBjb25uZWN0aW9uIGdvdCBkaXNjb25uZWN0ZWQsIHRoZW4gdGhlIGNs
aWVudA0KbmVlZHMgdG8gcmVjb25uZWN0IGFuZCBidWlsZCBhIG5ldyBjb25uZWN0aW9uIGFsdG9n
ZXRoZXIuIFdlIGNhbid0IGp1c3QNCm1ha2UgcHJldGVuZCB0aGF0IHRoZSBvbGQgY29ubmVjdGlv
biBzdGlsbCBleGlzdHMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K
