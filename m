Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4152472020
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 05:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhLMEwo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Dec 2021 23:52:44 -0500
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com ([104.47.56.175]:13955
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229990AbhLMEwo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 12 Dec 2021 23:52:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbIRjjZwovts7C6ol5gcqs9OY99hxAJK9NIZ+eUvlb4STS6p79sFKmyD7DD/edLeEODF/F09SlJAw+WXUQ0Lds4Urc+u5A0opr9//Y4zV4gfhGkuTStY5mIzK97xdP+hcDMxFfoxfJTrG/lLsg6XgB/BCMqt6M0AWooNPC5gZheoO3Ik7S8T9zs/FGnLtWZwDZza76u8iC15V0Kt6WhNw/WPC4EkTOV0pIgqBFewjmj4hTxDAvzSVDC5vaZOhjBB4ro+DsmhZQ4Sim3Wb+GSwGCk85F1psXFc4xhrEaPecfAu+AhETKKQed8f3L3GZZXHOWN10BypNRdCJlobO5Lug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHnfhdFl1lQ4oOgx5d77BZaGylhQmi93oMWGdSeOXA4=;
 b=i5ZmyUMuf6uF7zFcARxhxspkteWj6tv1Jg1IyLNiYmBqsRl0nqBM2PkWa2zznZECrKt8IZC4eUUEgchbvNkfUlli0cMqUX7h/yOdzPahAvPPtTjFrsKCBd4Q6rBMA/eYNyOdqJKH9q0pvaYIJWQx4XEdzOc2o5PgB/AB28UHDL/gcQYNfkSxrRt4GoUhqKnHjCoy9bnOF1817NBGENJvP1UhByGbgRM/XMUQCxiMWPHo0zJ02HqZK7F3Oo+p5tt2S++oDoUx9ChCB4xSFDzLkOJjoYlPKYkVH0ZtrAaDTt51C6xhVCFNu8XIB8MrRm0jkN9bpIKBlBGPtbCypqvUZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHnfhdFl1lQ4oOgx5d77BZaGylhQmi93oMWGdSeOXA4=;
 b=OikpiXgEtzhkRgfqWGk4fmT2rFi2FrjCNTu8j+EPA0YQ3gNk+3JoOPDYbDGFlFbMF+g6pywRSTnrgkLHB/FrLBMU/wM7KVbUq0WOrTAZhR0BhZ4xR+NKr0R2XQTvjRRqEKNIh3Zqxnrn9W8ygMw2AEZypwgrRoUCtCMbMFuAfE0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3448.namprd13.prod.outlook.com (2603:10b6:610:28::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.7; Mon, 13 Dec
 2021 04:52:42 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4801.013; Mon, 13 Dec 2021
 04:52:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rtm@csail.mit.edu" <rtm@csail.mit.edu>
Subject: Re: NFS client can crash server due to overrun in
 nfsd4_decode_bitmap4()
Thread-Topic: NFS client can crash server due to overrun in
 nfsd4_decode_bitmap4()
Thread-Index: AQHX2NFD/g3zem0kKUiGVIkOdZv7kKwB8uWAgAAFgACAAAGpAIAt4ZkAgAAkkACAAAipAA==
Date:   Mon, 13 Dec 2021 04:52:41 +0000
Message-ID: <a8d3392e2a4e287b343fa5189b615e98a862fc4c.camel@hammerspace.com>
References: <97860.1636837122@crash.local>
         <11B4530A-C0A0-4779-A9BA-F0E19B62C5A6@oracle.com>
         <20211113212544.GA27601@fieldses.org>
         <9A3E5D78-AE3C-4F45-8CB1-10F2EDA1D911@oracle.com>
         <20211213021048.GA20814@fieldses.org>
         <4D63A33B-5E6C-4703-BD02-9E6D43782BD4@oracle.com>
In-Reply-To: <4D63A33B-5E6C-4703-BD02-9E6D43782BD4@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a75b3b0-a201-4d9f-b637-08d9bdf46543
x-ms-traffictypediagnostic: CH2PR13MB3448:EE_
x-microsoft-antispam-prvs: <CH2PR13MB344842E9E289CA7E74F7572EB8749@CH2PR13MB3448.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BRxbDXUPvQcBlL43RBfcCipI87fjZUUqlCL/Af9CR5Xn+fgwgR/9auJDn/kKfwgdhTfqJvIRUSaTjyIHIHX7zGDCD9a309Zh290/FlreSlrBDsWKaCd8aItdlZqVOGfCuLxZjmOZHgwWHQAWLiX467+yJjKi90PHXf/9prEGOqjbOBw20jucVQVJZnS5vFWyDyQqkEkIBKqcwbRs5kENCnWouL9FK2EWKuDyWHZ+UTzKKMHRRSl8YYISSyjn8+4hjI0ux74haXzSn2TkIdrgZ7GaHIvNUa7cqd6ZqvmcPr3ZXm130G08d6uhansBSxb2SJ7Nqp6V41A3gHT/GE7GTmUL3o2373m+SByJqBzOZBlt8T8aJPyaqDWmFWOqhREYb9uiSvKcRXaMZ9SoUkXjl4z2DubRHzIlL+GxKqiN/O7PMiPvNPIrHMryQAT9tEcQKALDZEZUKIO8GnLj2jA5LOfkYWHIbv9RYK1V3WWfNCoxSKabkOAySUwetdzQr3ajlufBSMVkW8IgxaHGX2GyWoi5LUc9JAPachJbTSCTZT7Ty7j8Y4Mq+bb//8C5FgRFXW0pydOr243PJ/irI7XO2zJkRFGYNPJFnFiNKFWEbHeVegQJisP9zSGtAMChljOcjFmLjgjaps07zQZxnUUFTbAvi2wZnJHkU6cKgdiqNcEAdf2EBJT4zo4Toxw5sw/hrC3FzuaYwrizKfimS+1Eh0+wBdAcC1ph/AZZgGJhGZCN5yGch7TgZqV4/+yiHNsU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(39830400003)(346002)(396003)(376002)(38070700005)(83380400001)(4326008)(8936002)(36756003)(66446008)(4001150100001)(2906002)(64756008)(66476007)(5660300002)(8676002)(66556008)(6506007)(6512007)(54906003)(110136005)(2616005)(26005)(53546011)(186003)(316002)(122000001)(38100700002)(66946007)(76116006)(6486002)(71200400001)(86362001)(508600001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmRFK1haT09XVUtkQmJYY0RVcHFDVGtBMEVvL1dyZG5jL3l2MVFRaXJ6TkVj?=
 =?utf-8?B?TWY1NzJKaVdiTEJXL3B2K1FicHg2ZE4wdHgxRWZHckxpWUxaNk5nSnUva0s3?=
 =?utf-8?B?T3R2T25XUE1iL2pkTWN5YkhZRlhQTVZaQ1lsQktDejQ4M2t5YmdLeXRrTUU4?=
 =?utf-8?B?MUZsRkMvMjNCa3N6bFhHWVVCa0JaWE9VVWJsbll3VFRuRGpkK3Q1WjVjVlhL?=
 =?utf-8?B?dmtMN0dTdlJZZDFwUDJRR0lndFlScTdTTnVoKzNZQkdNdldiaENmenBETkwv?=
 =?utf-8?B?d0FTOTQvNTV5SWNYOThxemxFT0FZNGRBejYrQ1RROWJ5WkJiL3ZBaDhTZTdz?=
 =?utf-8?B?dVhJaTRHUmpmNkFPUVF6WmRMVmg1VEdPb2t0dWVyZ3ZhemZXN0pLMG8xaGJi?=
 =?utf-8?B?V0V2NElCNk5zeTBsdmN6TXp0a3RaMkF3ZkN5UHpUYnpEZzZGWVU2TjlieEZS?=
 =?utf-8?B?c20zSjBIQ3dISUlBSlE5WkRxUDJna2EvZnZ0ZVB4QzNLVEVBRXJyNEh0T3p2?=
 =?utf-8?B?NUpvYWIzRUYvR3VrOFg5NjBYZG9NUThHQ2JJaEU1TzZ5WTZDYlBwRzFZS2Rx?=
 =?utf-8?B?bFRhc3VGUVpBQkN6RHhsMnltYWlNRjhhZjNENXBibGJtbHJHcHRURkFDRWlh?=
 =?utf-8?B?NDY5azNPSEJuNmdPeTZ0SjNaTTAzdENNR0doTXkxclRERXorQjlLTTBIa29I?=
 =?utf-8?B?aUdaMkxQeUltRlFyVFhIWVRqRUsyYVpvaTJCUWlxK1pLU0tZZzUwWlB3Y0dm?=
 =?utf-8?B?YUxtdFAyUTlEZ3JUZWRaeXozOHNES0ZQaVhpYXh4QWlrQlE3ZXBiMFJzd2FT?=
 =?utf-8?B?UDdXdTNUU1Vsa0pFb1JsZytXR1ZjVEtoUHNrcndia1cwY1ZPM0RHQzBmRXRt?=
 =?utf-8?B?Y2NGT0tUNXpCRmNhSHdRcDBZVDhRbEJ3L0ovL3k5TURMTEd2NEdNRTBoTWM5?=
 =?utf-8?B?Uk1pNi9sK0E0cUpQbGVTckJ4UWxlL3ZWTlUwSnVFY0tOTERBVmFDMDZYYXFw?=
 =?utf-8?B?ZVpPTnlteDJaS2FRODhjZ1VpeWM0T0hTVER2REJtamVyT3dXaE00ODcwb0Js?=
 =?utf-8?B?a0tWTFllQ3c1MTg5Yy9WM3BnUEtiSTE3MG1xNzFtbHdzQTFjU3ZMSUNRSlpI?=
 =?utf-8?B?TGZXbUFaeWIxcnF1RmRNSkRPRFFJbU5kMmthcTB4SmNUODE1dnVJaVN4VTYz?=
 =?utf-8?B?aXdmVXFPNHd2TktiMW02WEEvbFpORWNlYjZPMGNtZlMxQ3o2UmFhT1p3TlpX?=
 =?utf-8?B?dFphbjdWaGt5OUlKVmJFTDV1UXEyQ2o2ZFRhOTk4N2pvY0tQdC9UN1FhM0Js?=
 =?utf-8?B?c3JqR2tEM1l1aWQ5R0s4dkNPU2xwY2ZBclIvL3ZkaXVvZGZieFNoYTkwOXc3?=
 =?utf-8?B?NUFvOEM3akgwVGEyVXVaR3VYZTNpaTNKdUhnZkNRcjFsY2tiZnBsaVhrSCtO?=
 =?utf-8?B?Tm9sNWVXT0xua1BCTlNoM1phVUIwWXI5VWtXUlR1ZVl3ci9BQ0tiMDJ5Mm85?=
 =?utf-8?B?dFkxYnFibWMyMXc4bGdEdFMzSGdDbVllbEdITkVuMGhwOGF1emdIaFdtZGNC?=
 =?utf-8?B?cnJoRGVpUXE2V2RFbXFpL0g5aTFJNUdodmZJK2pyMDZ0YTBXc2RQUDZjZ05K?=
 =?utf-8?B?alovTDIrVTUvb3BPdUUwQk16cW5ndERWaDVOSHR0TnIyWFZyR3N6NG94ajlC?=
 =?utf-8?B?MXJ3NFdWZzlnU2xqZTNtZ2wxVXhSeTRYTVVVSlEwcGJsdTdvckFOWkQxdHBx?=
 =?utf-8?B?b2RUUCtDUGZMM0VHbUhyQkl5UER3d2QvYzZSb2xmYzltSW5QL2p3dTYyNGZI?=
 =?utf-8?B?eEh6Nk5oUlhXTE93K3cyMEZyUVlwTC82TkNWSHhRYjVxaWZWMkpkWTZOdU1W?=
 =?utf-8?B?WlZrY1M0MTVvRWoybEhjS28zc0U5KytiL1g5cTJ4Z1FSajBMd2JkTm4zUjFj?=
 =?utf-8?B?VDR2clJ2bGQ3dVNSMzVqYWRZQ1h6VGxLcEljTGlqVVZTdEhrbWJRS0VQRWQ3?=
 =?utf-8?B?UHFNK1Buc3c5Ulg5RFprdjhpSldXU1N0WmxxU1lZb09CTlZRSGc5eTZzdCtX?=
 =?utf-8?B?cnI5eERxS0g0RnJzb2V4M3JOeGlFZWlHRW01cUpqMm9uUU1JWWwydjJiZllh?=
 =?utf-8?B?bVhaYXpHdEFEcjhJQmZ1Tk9iamM2cUJ1VlZBaCs1T3JDbXVrWFErcDVJVlBZ?=
 =?utf-8?Q?lcbHjDXgcc9XF2FiIw+GBGM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD751E930D0E294B9B6FF9C4E2BD3B82@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a75b3b0-a201-4d9f-b637-08d9bdf46543
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 04:52:41.5314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4q47Y2ThVoB90lY0oZqU1yz1b2IMmETrMbBf1kuWF9VvJLHw9MR5ks/BamC1SLOGN8rPIc8sROVE32yW6fQaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3448
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTEyLTEzIGF0IDA0OjIxICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiA+IE9uIERlYyAxMiwgMjAyMSwgYXQgOToxMCBQTSwgQnJ1Y2UgRmllbGRzIDxiZmll
bGRzQGZpZWxkc2VzLm9yZz4NCj4gPiB3cm90ZToNCj4gPiANCj4gPiDvu79PbiBTYXQsIE5vdiAx
MywgMjAyMSBhdCAwOTozMTo0MFBNICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4g
PiBTdXJlLCBidXQgdGhhdCdzIG1vcmUgcmVzdHJpY3RpdmUgdGhhbiB3aGF0IHRoZSBvbGQgZGVj
b2Rlcg0KPiA+ID4gZGlkLiBJIGhhdmUgdGhpcyBpbnN0ZWFkIChhbHNvIHlldCB0byBiZSB0ZXN0
ZWQpOg0KPiA+ID4gDQo+ID4gPiDCoMKgIE5GU0Q6IEZpeCBleHBvc3VyZSBpbiBuZnNkNF9kZWNv
ZGVfYml0bWFwKCkNCj4gPiA+IA0KPiA+ID4gwqDCoCBydG1AY3NhaWwubWl0LmVkdcKgcmVwb3J0
czoNCj4gPiA+ID4gbmZzZDRfZGVjb2RlX2JpdG1hcDQoKSB3aWxsIHdyaXRlIGJleW9uZCBibXZh
bFtibWxlbi0xXSBpZiB0aGUNCj4gPiA+ID4gUlBDDQo+ID4gPiA+IGRpcmVjdHMgaXQgdG8gZG8g
c28uIFRoaXMgY2FuIGNhdXNlDQo+ID4gPiA+IG5mc2Q0X2RlY29kZV9zdGF0ZV9wcm90ZWN0NF9h
KCkNCj4gPiA+ID4gdG8gd3JpdGUgY2xpZW50LXN1cHBsaWVkIGRhdGEgYmV5b25kIHRoZSBlbmQg
b2YNCj4gPiA+ID4gbmZzZDRfZXhjaGFuZ2VfaWQuc3BvX211c3RfYWxsb3dbXSB3aGVuIGNhbGxl
ZCBieQ0KPiA+ID4gPiBuZnNkNF9kZWNvZGVfZXhjaGFuZ2VfaWQoKS4NCj4gPiA+IA0KPiA+ID4g
wqDCoCBSZXdyaXRlIHRoZSBsb29wcyBzbyBuZnNkNF9kZWNvZGVfYml0bWFwKCkgY2Fubm90IGl0
ZXJhdGUNCj4gPiA+IGJleW9uZA0KPiA+ID4gwqDCoCBAYm1sZW4uDQo+ID4gPiANCj4gPiA+IMKg
wqAgUmVwb3J0ZWQgYnk6IDxydG1AY3NhaWwubWl0LmVkdT4NCj4gPiA+IMKgwqAgRml4ZXM6IGQx
YzI2M2EwMzFlOCAoIk5GU0Q6IFJlcGxhY2UgUkVBRCogbWFjcm9zIGluDQo+ID4gPiBuZnNkNF9k
ZWNvZGVfZmF0dHIoKSIpDQo+ID4gPiDCoMKgIFNpZ25lZC1vZmYtYnk6IENodWNrIExldmVyIDxj
aHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZz
ZC9uZnM0eGRyLmMgYi9mcy9uZnNkL25mczR4ZHIuYw0KPiA+ID4gaW5kZXggMTA4ODNlNmQ4MGFj
Li5jMmY3NTMyMzNmY2YgMTAwNjQ0DQo+ID4gPiAtLS0gYS9mcy9uZnNkL25mczR4ZHIuYw0KPiA+
ID4gKysrIGIvZnMvbmZzZC9uZnM0eGRyLmMNCj4gPiA+IEBAIC0yODgsMTIgKzI4OCw4IEBAIG5m
c2Q0X2RlY29kZV9iaXRtYXA0KHN0cnVjdA0KPiA+ID4gbmZzZDRfY29tcG91bmRhcmdzICphcmdw
LCB1MzIgKmJtdmFsLCB1MzIgYm1sZW4pDQo+ID4gPiDCoMKgwqDCoMKgwqAgcCA9IHhkcl9pbmxp
bmVfZGVjb2RlKGFyZ3AtPnhkciwgY291bnQgPDwgMik7DQo+ID4gPiDCoMKgwqDCoMKgwqAgaWYg
KCFwKQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbmZzZXJyX2Jh
ZF94ZHI7DQo+ID4gPiAtwqDCoMKgwqDCoMKgIGkgPSAwOw0KPiA+ID4gLcKgwqDCoMKgwqDCoCB3
aGlsZSAoaSA8IGNvdW50KQ0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm12
YWxbaSsrXSA9IGJlMzJfdG9fY3B1cChwKyspOw0KPiA+ID4gLcKgwqDCoMKgwqDCoCB3aGlsZSAo
aSA8IGJtbGVuKQ0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm12YWxbaSsr
XSA9IDA7DQo+ID4gPiAtDQo+ID4gPiArwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBibWxl
bjsgaSsrKQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm12YWxbaV0gPSAo
aSA8IGNvdW50KSA/IGJlMzJfdG9fY3B1cChwKyspIDogMDsNCj4gPiA+IMKgwqDCoMKgwqDCoCBy
ZXR1cm4gbmZzX29rOw0KPiA+ID4gfQ0KPiA+ID4gDQo+ID4gPiBUaGlzIGFsbG93cyB0aGUgY2xp
ZW50IHRvIHNlbmQgYml0bWFwcyBsYXJnZXIgdGhhbiBibXZhbFtdLA0KPiA+ID4gYXMgdGhlIG9s
ZCBkZWNvZGVyIGRpZCwgYW5kIGVuc3VyZXMgdGhhdCBkZWNvZGVfYml0bWFwKCkNCj4gPiA+IGNh
bm5vdCB3cml0ZSBmYXJ0aGVyIHRoYW4gQGJtbGVuIGludG8gdGhlIGJtdmFsIGFycmF5Lg0KPiA+
IA0KPiA+IEJ1dCBJIG5vdGljZSBub3cgdGhhdCB5b3VyIHRyZWUgaGFzICJORlNEOiBSZXBsYWNl
DQo+ID4gbmZzZDRfZGVjb2RlX2JpdG1hcDQoKSIsIHdoaWNoIGRvZXMgZXJyb3Igb3V0IG9uIGxh
cmdlIGJpdG1hcHMuDQo+ID4gKE5vdGljZWQgYmVjYXVzZSBweW5mcyBjaGVja3MgZm9yIHRoaXMg
Y2FzZSAoc2VlIEdBVFQ0cyBhbmQNCj4gPiBzaW1pbGFyKSBhbmQNCj4gPiBpcyBzZWVpbmcgQkFE
WERSIHJldHVybnMpLg0KPiANCj4gROKAmW9oISBJIGNhbiBkcm9wIOKAnFJlcGxhY2UgbmZzZDRf
ZGVjb2RlX2JpdG1hcDQoKeKAnSBvciB3ZSBjYW4gdXBkYXRlDQo+IHRoZSBnZW5lcmljIGhlbHBl
ciB0byBoYW5kbGUgbGFyZ2UgYml0bWFwcy4gRHJvcHBpbmcgdGhlIGNsZWFuLXVwDQo+IHNlZW1z
IHNhZmVyLg0KPiANCg0KVGhlIHhkcl9zdHJlYW1fZGVjb2RlX3VpbnQzMl9hcnJheSgpIGdlbmVy
aWMgaGVscGVyIGFscmVhZHkgaGFuZGxlcw0KbGFyZ2UgYml0bWFwcy4gSXQgd2lsbCBkZWNvZGUg
YXMgbWFueSBlbnRyaWVzIGFzIHdpbGwgZml0IGluIEBhcnJheSwNCmJ1dCByZXR1cm4gLUVNU0dT
SVpFIHRvIGxldCB5b3Uga25vdyB0aGF0IHNpemUgd2FzIHRydW5jYXRlZC4NCg0KSU9XOiB5b3Ug
c2hvdWxkIHRyZWF0IC1FTVNHU0laRSBhcyBhIHNpZ24gdGhhdCBAYXJyYXlfc2l6ZSBlbGVtZW50
cw0Kd2VyZSBhY3R1YWxseSBkZWNvZGVkLCByYXRoZXIgdGhhbiBhcyBhIHNpZ24gdGhhdCBubyBl
bGVtZW50cyB3ZXJlDQpkZWNvZGVkLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==
