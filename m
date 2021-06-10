Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4383A2DC9
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 16:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFJOPb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 10:15:31 -0400
Received: from mail-mw2nam12on2128.outbound.protection.outlook.com ([40.107.244.128]:38120
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230153AbhFJOP3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 10 Jun 2021 10:15:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7Rw+343QzvXrqj5Quw0Or3Mmq2wkV3Reh6XGeUdgwweIlQKUeCfOLt1YlAjALbnLFPjDWy2KQ5m81qJa53+8BGcI2AOTKxsbP1hn0XN3WzgnYoJhDVkneFKNIKtg2VtYtNiDY/HccJYtVRDeuyfBuAPlMvf+ZYEyMdu2ej6SXBzhnYQPsPyKoerHVr0cwL5l8f1Tj0cvM/x0AMZyuiaO5CTeNrmitmVjo08HUJtj6z4ODEmhYW1yuPY373WY18UIj48epH17P2IaBkKbthi9xGVaS+b9L2/eO0GjVX2VSUq7wTJOU4eW8D/q+kO5vYhnR83mw9KZtlYJlT9k6OErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diolKOpyOTVM3N95te4mOafQBEl+Z/rZwy1olaN7i2U=;
 b=kykIgoKopzFz6tCrfn3/iBXJdloFOqT0xwNYuersazPyrwLtCYNYw2pZOcT4EF+t4RfD+2ELtF6iMsCre1P1MJjNEOovO7qZ6IB+3niimdGWfgBDwnL2Yi4R4rcnIan60JAH0m+IwhicB3NTY+W4lh0Qni4BH+MNuVaLp3Qnrua2TzZijP7kiJhHe4jxWbamz7XZdU2wBKWjCzQYJLhd2yCBaHsLlraB1gVmtz4rfxFJPP5fJJ8Mi/jBp9MRzhut3H454fj2+sWF+FhDV1Mz4+le3b0yBbg+sHQahUH0i25msHByV2lra20cFMarCAZ3MJL1oBsclmEnKAGydkbeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diolKOpyOTVM3N95te4mOafQBEl+Z/rZwy1olaN7i2U=;
 b=aO0vkHTudYHXQuJ3a5XKUsjFLjkSuikmiGlGHk7pO8h3JBqRUvpFb2pQ5n9Tu/hYwhcwIzgHG/oyAVX1Noqpd3OQwDqad+n1xIDQ3gzzvLqWCi1n1lP/PgpdY9A+0gQSsIhkaYAbD0ThEHWIAYyryYUQtkNuWBiGN1LUAyuj220=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB3723.namprd13.prod.outlook.com (2603:10b6:5:246::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9; Thu, 10 Jun
 2021 14:13:31 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4242.012; Thu, 10 Jun 2021
 14:13:31 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
Subject: Re: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Topic: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Index: AQHXXXnh3WIMdJRfJ0KF+q50bEsARasNPoYAgAABKgCAAAY7AIAABLOA
Date:   Thu, 10 Jun 2021 14:13:31 +0000
Message-ID: <3658c226b43fb190de38c00e5199ccf35ccc4369.camel@hammerspace.com>
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
         <20210609215319.5518-3-olga.kornievskaia@gmail.com>
         <6C64456A-931F-4CAD-A559-412A12F0F741@oracle.com>
         <6bca80de292b5aa36734e7d942d0e9f53430903b.camel@hammerspace.com>
         <83D9342E-FDAF-4B2C-A518-20BF0A9AD073@oracle.com>
In-Reply-To: <83D9342E-FDAF-4B2C-A518-20BF0A9AD073@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc7fbaa4-b422-4071-6b6e-08d92c19ed07
x-ms-traffictypediagnostic: DM6PR13MB3723:
x-microsoft-antispam-prvs: <DM6PR13MB37238952787551DC25502BD7B8359@DM6PR13MB3723.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FMhiAwXR5ukFGT2jIzi2vtSfg68dEvjzv4C1jnxoxJ/k7B976XXSfZ/uaIMSlH5mCijkX58ZLPBVWJw8gnFEjDM1/fgFuvTzHZB8ev1mzSv9TTei2jsPGsGiELpk6x13PoAYLH3Db9YDwcwT4931z/a/ZH2e5dtPgIXVbGVShe2HDYvxts7pmMH8d2Ta4pBlyV8oRm0O4H8e1hHlnFT3NKDZMiNMSdybyeXiWeo11a/jU7XLMd4drWImIx5wogxk3xMH1z1l7xoB4eOf2PI6h6XkWqjg4ntL9eIZRYJt6C/kn2WHaE4+7XVk6MwpRMTUhCFd23Ada342P/T6+SX8QHCi0riGTaen3pdl+yqPLYpYhiM5TJrS/DLXsg1qXa8ikl0lqwbgp8VZMsT45HDZPW9qoIoVzAS0Gy8PD9hhfE6g1EgQoxDoeSNpGQMDcH06UQQoHNlu/PpA14Z6i3ANgTWIaA/M0X2mEx77YWY3YZs5A6giuqcciVmHZ7LYd1OhDJU1FNvofKIMH43IfiDnZZ2ircNWTZAl+du42h/X4TpVS7RFqVz8rFFV/CRuwTfW2sa38fPG1bVhkgadA+XlelAnn+zz7AXjvys99hjBanI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39830400003)(136003)(346002)(396003)(2616005)(478600001)(8936002)(76116006)(4326008)(6486002)(91956017)(53546011)(6506007)(54906003)(66476007)(6916009)(66946007)(64756008)(26005)(8676002)(66446008)(316002)(66556008)(83380400001)(6512007)(2906002)(36756003)(122000001)(86362001)(71200400001)(38100700002)(5660300002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzNsUXZFaEk4UEYrZC9VMmlYOGxGSnBkdnRXR3NZOWgvUkxhb0xHbWYrMHVl?=
 =?utf-8?B?ZmFadVlTWFhCeEM0czA5MFFtNHhGOG1HeUMrdEdlLzVlYkUzaUtjVUtRVVhw?=
 =?utf-8?B?RjFKcFMxdUxpWWE0TzNQQzdBZ2RUeUNYaC8wUFd1N2hPRHhMeTV3S0ZsWUxy?=
 =?utf-8?B?Z0wvY0dYSmp3R3NzUDdXbS9pbFVuNUs2azBoeU9QRk9BY01hc2ZDaDVwc2Qw?=
 =?utf-8?B?Q244c29TVkZUdHcxWjlzWlIvdnk3REc4YkU4MnEwZnpKM3FEYkY3MHI1b3lr?=
 =?utf-8?B?RlE5VWhuZkFMTHlrWUIyV1JmNTZhUWxzY2JXeHN1aUNGdmFiZ1YxbkNWTHZD?=
 =?utf-8?B?Mzl2bjhMSk82N2U4TlZxczE0MTJNOGQrWE9JR0FsdkJPQ2RGMk9od0czb1Bm?=
 =?utf-8?B?bHVjUzU4MGw1aFovMUgzbVk3TWwxYjVXREFKUnlnT2NjaFhqTkFKNm94Y0FG?=
 =?utf-8?B?VisxR3prRkxnVUxYbGhleFpxVGZuY0NlSm1UZ2puUm54b2dacldSdGc2NGVq?=
 =?utf-8?B?ajlRQkx3aUN5SVhlU21XelEvNUJKV3NrMHZsTWZPMWx6UlV0QUZCOTk0SEMx?=
 =?utf-8?B?dUZCYytnRUc0dGpRb3R6Z0QvQnZGM2I5OTRCVm9TT2laeUtxM08wQlVoU1RP?=
 =?utf-8?B?dVdzcG83NklrZkZ0aFBQdFJBakdTc2xYbDF2MjBnUmRlSlF5MDVTbXZUL1k1?=
 =?utf-8?B?OXZmMk9iOENHa0lCSnBXN1BRYXFqdUVsSHd6amlUT3NsQXhUaDAveXlFS2NM?=
 =?utf-8?B?bi9oRTFNQzVueUpyVllDZ1k4MkNpK1BUbkpZNW9aUjZNZVpscFo0YzdRU1Rn?=
 =?utf-8?B?b2Y1ckVQVmdCcEdBMHJQTUJLSFNFemdKQUMvZ043MktkRlA0Q2IxanZMUmpz?=
 =?utf-8?B?U1JrVTdYdlNqa1V6UmtzRkxETzIzVDdKbnVjdk9QcVBJakVpdjVXRWs5VWZN?=
 =?utf-8?B?SVZLTWkrS2tiWUJpRnAxSDM5cXZjc3V4cWVQNWJVV296K2V0ZUxuSERMeVNP?=
 =?utf-8?B?TjA1aCtQODUyeXBRS2Zvc2NwWkdmeTQzR0ZjSjF3V3JKWUF1eHp6a1BaL0RK?=
 =?utf-8?B?TFJHTkI1VE11WGUyQTlTWDNYVHBqR21naVBWUkJ1L1lBcXdmT2pVVGd3Z2Nz?=
 =?utf-8?B?aVgwOEVpWE5VWEhNQksrd3A4N0hSd01vUjdPdG1Wd3NxdVNDeGdOTE4wdXpV?=
 =?utf-8?B?L2JnWGhoSDRvRzNuUlZQYmRPSTV2Y1VrZmNrbjVJMnA4OGR1R2tGMk5VTUo0?=
 =?utf-8?B?WkQ4aEtxeHRpQ3dRVi9vSEVKaFU1bVRGOWhJRjl4elpOU0trTXF4enVaNXRH?=
 =?utf-8?B?Sm5hbVgwVUJHZ2dIcnJGbWh6NlJmU1pNNjdDVU8vWk44R0dRdndoUDM5dE4z?=
 =?utf-8?B?bUpqdFl0V0xYejU5SEpTVGJXTFR2L21ZbGNLbHg3TTRLNkc3VE5NNEd5YWlh?=
 =?utf-8?B?eDl6dzR1eEhiQkRVN0dRWFlQNCtIMTdlcXFuZVZmNUhsamlEQ25WTEh3dDNR?=
 =?utf-8?B?ZXdpc1NwWmlLK1VXeDJaR3pUM3FkSHd6K3NjMGdTeHY3Y3BZVjY4MDFiODdF?=
 =?utf-8?B?VHlDa0RJbkRFdE96dC9XcmJKSTRNU3FiS2VjQklDdzBQZCtVSkc2N3JRc1g1?=
 =?utf-8?B?OE10VEJwdkxuQlM5TThsTis1OGNvUDUvcG9DMW5jSEtwRmJvY1Z3dXFOSHpE?=
 =?utf-8?B?RHdzb2VROUpzWHU5UDB0TGo4TTgxVlhLQS9Lc2dWRlg1Q0x5Mld4MmdVZUps?=
 =?utf-8?Q?u2F1TiSxdrDN7Z62rwaNLkOuga50EKnuSb5kVUj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <61CE622968AE7F4891E45428DE4B04B1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7fbaa4-b422-4071-6b6e-08d92c19ed07
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 14:13:31.0225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvPukAVC7SY5VLLqF+jEyqdWmnBM4Vu0HLP5ujxltwtG03fIXEFxLicZ01Ti/2AS3ZuFcV45MWICUE+S/VeUUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3723
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTA2LTEwIGF0IDEzOjU2ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBKdW4gMTAsIDIwMjEsIGF0IDk6MzQgQU0sIFRyb25kIE15a2xlYnVz
dCA8DQo+ID4gdHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFRo
dSwgMjAyMS0wNi0xMCBhdCAxMzozMCArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPiA+
ID4gDQo+ID4gPiANCj4gPiA+ID4gT24gSnVuIDksIDIwMjEsIGF0IDU6NTMgUE0sIE9sZ2EgS29y
bmlldnNrYWlhIDwgDQo+ID4gPiA+IG9sZ2Eua29ybmlldnNrYWlhQGdtYWlsLmNvbT4gd3JvdGU6
DQo+ID4gPiA+IA0KPiA+ID4gPiBGcm9tOiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBw
LmNvbT4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgb3B0aW9uIHdpbGwgY29udHJvbCB1cCB0byBo
b3cgbWFueSB4cHJ0cyBjYW4gdGhlIGNsaWVudA0KPiA+ID4gPiBlc3RhYmxpc2ggdG8gdGhlIHNl
cnZlci4gVGhpcyBwYXRjaCBwYXJzZXMgdGhlIHZhbHVlIGFuZCBzZXRzDQo+ID4gPiA+IHVwIHN0
cnVjdHVyZXMgdGhhdCBrZWVwIHRyYWNrIG9mIG1heF9jb25uZWN0Lg0KPiA+ID4gPiANCj4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+
ID4gPiA+IC0tLQ0KPiA+ID4gPiBmcy9uZnMvY2xpZW50LmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgMSArDQo+ID4gPiA+IGZzL25mcy9mc19jb250ZXh0LmPCoMKgwqDCoMKgwqAgfMKgIDggKysr
KysrKysNCj4gPiA+ID4gZnMvbmZzL2ludGVybmFsLmjCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICsr
DQo+ID4gPiA+IGZzL25mcy9uZnM0Y2xpZW50LmPCoMKgwqDCoMKgwqAgfCAxMiArKysrKysrKysr
LS0NCj4gPiA+ID4gZnMvbmZzL3N1cGVyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICsr
DQo+ID4gPiA+IGluY2x1ZGUvbGludXgvbmZzX2ZzX3NiLmggfMKgIDEgKw0KPiA+ID4gPiA2IGZp
bGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0K
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2NsaWVudC5jIGIvZnMvbmZzL2NsaWVudC5jDQo+
ID4gPiA+IGluZGV4IDMzMGY2NTcyN2M0NS4uNDg2ZGVjNTk5NzJiIDEwMDY0NA0KPiA+ID4gPiAt
LS0gYS9mcy9uZnMvY2xpZW50LmMNCj4gPiA+ID4gKysrIGIvZnMvbmZzL2NsaWVudC5jDQo+ID4g
PiA+IEBAIC0xNzksNiArMTc5LDcgQEAgc3RydWN0IG5mc19jbGllbnQgKm5mc19hbGxvY19jbGll
bnQoY29uc3QNCj4gPiA+ID4gc3RydWN0IG5mc19jbGllbnRfaW5pdGRhdGEgKmNsX2luaXQpDQo+
ID4gPiA+IA0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBjbHAtPmNsX3Byb3RvID0gY2xfaW5pdC0+
cHJvdG87DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIGNscC0+Y2xfbmNvbm5lY3QgPSBjbF9pbml0
LT5uY29ubmVjdDsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBjbHAtPmNsX21heF9jb25uZWN0ID0g
Y2xfaW5pdC0+bWF4X2Nvbm5lY3QgPyBjbF9pbml0LQ0KPiA+ID4gPiA+IG1heF9jb25uZWN0IDog
MTsNCj4gPiA+IA0KPiA+ID4gU28sIDEgaXMgdGhlIGRlZmF1bHQgc2V0dGluZywgbWVhbmluZyB0
aGUgImFkZCBhbm90aGVyIHRyYW5zcG9ydCINCj4gPiA+IGZhY2lsaXR5IGlzIGRpc2FibGVkIGJ5
IGRlZmF1bHQuIFdvdWxkIGl0IGJlIGxlc3Mgc3VycHJpc2luZyBmb3INCj4gPiA+IGFuIGFkbWlu
IHRvIGFsbG93IHNvbWUgZXh0cmEgY29ubmVjdGlvbnMgYnkgZGVmYXVsdD8NCj4gPiA+IA0KPiA+
ID4gDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIGNscC0+Y2xfbmV0ID0gZ2V0X25ldChjbF9pbml0
LT5uZXQpOw0KPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgY2xwLT5jbF9wcmluY2lw
YWwgPSAiKiI7DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvZnNfY29udGV4dC5jIGIvZnMv
bmZzL2ZzX2NvbnRleHQuYw0KPiA+ID4gPiBpbmRleCBkOTVjOWEzOWJjNzAuLmNmYmZmNzA5OGY4
ZSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZnMvbmZzL2ZzX2NvbnRleHQuYw0KPiA+ID4gPiArKysg
Yi9mcy9uZnMvZnNfY29udGV4dC5jDQo+ID4gPiA+IEBAIC0yOSw2ICsyOSw3IEBADQo+ID4gPiA+
ICNlbmRpZg0KPiA+ID4gPiANCj4gPiA+ID4gI2RlZmluZSBORlNfTUFYX0NPTk5FQ1RJT05TIDE2
DQo+ID4gPiA+ICsjZGVmaW5lIE5GU19NQVhfVFJBTlNQT1JUUyAxMjgNCj4gPiA+IA0KPiA+ID4g
VGhpcyBtYXhpbXVtIHNlZW1zIGV4Y2Vzc2l2ZS4uLiBhZ2FpbiwgdGhlcmUgYXJlIGRpbWluaXNo
aW5nDQo+ID4gPiByZXR1cm5zIHRvIGFkZGluZyBtb3JlIGNvbm5lY3Rpb25zIHRvIHRoZSBzYW1l
IHNlcnZlci4gd2hhdCdzDQo+ID4gPiB3cm9uZyB3aXRoIHJlLXVzaW5nIE5GU19NQVhfQ09OTkVD
VElPTlMgZm9yIHRoZSBtYXhpbXVtPw0KPiA+ID4gDQo+ID4gPiBBcyBhbHdheXMsIEknbSBhIGxp
dHRsZSBxdWVhc3kgYWJvdXQgYWRkaW5nIHlldCBhbm90aGVyIG1vdW50DQo+ID4gPiBvcHRpb24u
IEFyZSB0aGVyZSByZWFsIHVzZSBjYXNlcyB3aGVyZSBhIHdob2xlLWNsaWVudCBzZXR0aW5nDQo+
ID4gPiAobGlrZSBhIHN5c2ZzIGF0dHJpYnV0ZSkgd291bGQgYmUgaW5hZGVxdWF0ZT8gSXMgdGhl
cmUgYSB3YXkNCj4gPiA+IHRoZSBjbGllbnQgY291bGQgZmlndXJlIG91dCBhIHJlYXNvbmFibGUg
bWF4aW11bSB3aXRob3V0IGENCj4gPiA+IGh1bWFuIGludGVydmVudGlvbiwgc2F5LCBieSBjb3Vu
dGluZyB0aGUgbnVtYmVyIG9mIE5JQ3Mgb24NCj4gPiA+IHRoZSBzeXN0ZW0/DQo+ID4gDQo+ID4g
T2gsIGhlbGwgbm8hIFdlJ3JlIG5vdCB0eWluZyBhbnl0aGluZyB0byB0aGUgbnVtYmVyIG9mIE5J
Q3MuLi4NCj4gDQo+IFRoYXQncyBhIGJpdCBvZiBhbiBvdmVyLXJlYWN0aW9uLiA6LSkgQSBsaXR0
bGUgbW9yZSBleHBsYW5hdGlvbg0KPiB3b3VsZCBiZSB3ZWxjb21lLiBJIG1lYW4sIGRvbid0IHlv
dSBleHBlY3Qgc29tZW9uZSB0byBhc2sgIkhvdw0KPiBkbyBJIHBpY2sgYSBnb29kIHZhbHVlPyIg
YW5kIHNvbWVvbmUgbWlnaHQgcmVhc29uYWJseSBhbnN3ZXINCj4gIldlbGwsIHN0YXJ0IHdpdGgg
dGhlIG51bWJlciBvZiBOSUNzIG9uIHlvdXIgY2xpZW50IHRpbWVzIDMiIG9yDQo+IHNvbWV0aGlu
ZyBsaWtlIHRoYXQuDQo+IA0KPiBJTU8gd2UncmUgYWJvdXQgdG8gYWRkIGFub3RoZXIgYWRtaW4g
c2V0dGluZyB3aXRob3V0IHVuZGVyc3RhbmRpbmcNCj4gaG93IGl0IHdpbGwgYmUgdXNlZCwgaG93
IHRvIHNlbGVjdCBhIGdvb2QgbWF4aW11bSB2YWx1ZSwgb3IgZXZlbg0KPiB3aGV0aGVyIHRoaXMg
bWF4aW11bSBuZWVkcyB0byBiZSBhZGp1c3RhYmxlLiBJbiBhIHByZXZpb3VzIGUtbWFpbA0KPiBP
bGdhIGhhcyBhbHJlYWR5IGRlbW9uc3RyYXRlZCB0aGF0IGl0IHdpbGwgYmUgZGlmZmljdWx0IHRv
IGV4cGxhaW4NCj4gaG93IHRvIHVzZSB0aGlzIHNldHRpbmcgd2l0aCBuY29ubmVjdD0uDQo+IA0K
PiBUaHVzIEkgd291bGQgZmF2b3IgYSAobW9kZXJhdGUpIHNvbGRlcmVkLWluIG1heGltdW0gdG8g
c3RhcnQgd2l0aCwNCj4gYW5kIHRoZW4gYXMgcmVhbCB3b3JsZCB1c2UgY2FzZXMgYXJpc2UsIGNv
bnNpZGVyIGFkZGluZyBhIHR1bmluZw0KPiBtZWNoYW5pc20gYmFzZWQgb24gYWN0dWFsIHJlcXVp
cmVtZW50cy4NCg0KSXQncyBub3QgYW4gb3ZlcnJlYWN0aW9uLiBJdCdzIGluc2FuZSB0byB0aGlu
ayB0aGF0IGNvdW50aW5nIE5JQ3MgZ2l2ZXMNCnlvdSBhbnkgbm90aW9uIHdoYXRzb2V2ZXIgYWJv
dXQgdGhlIG5ldHdvcmsgdG9wb2xvZ3kgYW5kIGNvbm5lY3Rpdml0eQ0KYmV0d2VlbiB0aGUgY2xp
ZW50IGFuZCBzZXJ2ZXIuIEl0IGRvZXNuJ3QgZXZlbiB0ZWxsIHlvdSBob3cgbWFueSBvZg0KdGhv
c2UgTklDcyBtaWdodCBwb3RlbnRpYWxseSBiZSBhdmFpbGFibGUgdG8geW91ciBhcHBsaWNhdGlv
bi4NCg0KV2UncmUgbm90IGRvaW5nIGFueSBhdXRvbWF0aW9uIGJhc2VkIG9uIHRoYXQga2luZCBv
ZiBsYXllcmluZw0KdmlvbGF0aW9uLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==
