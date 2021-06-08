Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6FC3A06E4
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 00:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhFHWdj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 18:33:39 -0400
Received: from mail-dm6nam11on2117.outbound.protection.outlook.com ([40.107.223.117]:48993
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234779AbhFHWdi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 8 Jun 2021 18:33:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnK6Tif4RuahqzJZWoX2cyygBHUxOsghovr/JqAEPYmPR1VKTLzQijq7CDocV2DM/CYwjt3tpt3pVdUCp1tdTB5PAtZJ4+wYjNzyxtRFXXeTiaJC7hsozFlTQiLZeyY3w3EGH0gU5HPXt2uZFIljE0nAg0y1OhD/L7L3JM8K4uodCijxnpLz730HQ+Y4laTHztICTWrUeC/KcP996ZVjAgn3jFc/XM6xubwdIVENtsBavDC+xlkRBbcRlQFkjBcZyFlYR26rad8vkdTV6hzJdNuJ5Go8DVaYTcqaMIyZy61dxQgNjQTbbPj9X8ABBorTe7/RAXN4JJC2FVPri0Suog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrPzLQWNStiWP0r4Yh4C37G53deLi2ZwCl1FCVpgHmQ=;
 b=Y5r3i8bLBjd2aZyZc81/IFpm/9pi597wXfzdsrQ+qW5y6E2XwIHRBGeoW2lgCl4v9aFRF1lsssGsbxZIki13VwGHOxctXpkRG7Yxq4vq3oDQ0XW9JEO5TLiZx3YzupFh74bTLsRAAHdzdkvl8gqg/GWJXb1NXUXsmLKxSiHKaFJPgZg2bzKC0NobAGprE33WGXD04Rk+CUX/MYmOIaKGnZrlxjF7hMoQOxN1DDoXgj08uxBD3iokQ7iYbE5IGMuIWYoVNO5DKQfdHWIVUa4wCtc2FSC9qvmcGarvEy1yQPcUcLW/J8fwkj2OenCuOXsGlPKmFHtU4/dqFCibxs4fIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrPzLQWNStiWP0r4Yh4C37G53deLi2ZwCl1FCVpgHmQ=;
 b=JGg1shTI21Eunkh1Lsh/1Ug/wj/zy57ovrcJq+uedbYFmxBWePi/cPFdx6oWn7sdLODsWnX1JlAe6b8beJNF39Y1aBnp0DaUp8heO/zRe5hgZFZJsWwTqyr7H1Jm9jUi2n/dGLIcYytxUj36NAqavYwO5QEyyIcoiCbzPgG8HGM=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DS7PR13MB4574.namprd13.prod.outlook.com (2603:10b6:5:3ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9; Tue, 8 Jun
 2021 22:31:42 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 22:31:42 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Topic: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Index: AQHXXJZ2q4Fg/jBv8EW7vOhaPbIm9asKlDaAgAAEKoCAAALKAIAAA5OAgAAB/QCAAAE6AIAAArsAgAALcACAAALLAA==
Date:   Tue, 8 Jun 2021 22:31:42 +0000
Message-ID: <ba534fc8bb625870f31c086528c7f6d879b9156e.camel@hammerspace.com>
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
         <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com>
         <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
         <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com>
         <da738bdd35859aba7bdbed30da10df4e2d4087d2.camel@hammerspace.com>
         <1753b60c2cc23e6e650357fbf710ef4450310d76.camel@hammerspace.com>
         <CAN-5tyHsVprR9_0Q98X8Dd5zYgaX79V7R76KPSzDwQFMYL2qcA@mail.gmail.com>
         <e136a646089d862c476b555ea6b009cf19f5fadd.camel@hammerspace.com>
         <CAN-5tyG+fmfXsgT6rEURBKT3xUn5_pgwY=JzYCtFWKPpbnkzZQ@mail.gmail.com>
In-Reply-To: <CAN-5tyG+fmfXsgT6rEURBKT3xUn5_pgwY=JzYCtFWKPpbnkzZQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cbc9330-c553-4975-365c-08d92acd3102
x-ms-traffictypediagnostic: DS7PR13MB4574:
x-microsoft-antispam-prvs: <DS7PR13MB4574D303AE499A86F5AD13DFB8379@DS7PR13MB4574.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hj6exSoefs/gmxZPudbvorlS4D4BhlibTfcfhIebbO6SARio54/Y5kTV4fRF+0TMBrZyeGuKtw6xSpDn3yt6Msoqnf6H47v0anPhozCuZuNY9lXZmvLdYEf5JJVhvSoebSGaqLQQBAKSwHxGGbiXicqslAUPV5tuTL5QG+gjBfv71XfEcl5B3zDwokiGyEE8jdqF5BQprcsz/6Pg1x54vRIStFbIpvAxh/fcx2eNTxYSc+54gkXeuQY4ar3blVBsdR3VGSthfVWquxo1qF99oXeJc4EJTV65UMLbpymxnCoSWrxfiCYMsEF42DcBYoV2CYB7wTX4rk8+XCWRDJIq4I7V04YxQpv3R3zdwZh2zYYJiZP/VsuJGWA9QUtaoI7iHYnvhYkhA0mtfPuzcarKesDraLRx9iFWmoB9ndiB1S/UN6luvX8kZY8MXl3KWycuq5s+wO8gkfwlEfBZPj+MqOwmOaNbTGqeDb0Th3bAdaAA3Zm1PociR3gVvmL1mD3ghhQNNMhPh+96+hcy9NVVRi9yXW4+UxoBYbWhgasH0i2Dt8oZ8ceSKQ9HREdsilhYxAG6mbD+J0/FIwzctoUXIePpIkTsvfKmsmp5RMHg8Xw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(4326008)(2906002)(8676002)(38100700002)(6512007)(53546011)(186003)(122000001)(6506007)(71200400001)(54906003)(66556008)(5660300002)(36756003)(2616005)(498600001)(86362001)(8936002)(6486002)(76116006)(66446008)(66946007)(6916009)(26005)(64756008)(91956017)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0pxR0cvbEJuUGJMeWZFdXB5ZC84M0xyUFY5MjZHR2k5M2dJUVpPaTlSQ09V?=
 =?utf-8?B?U28xZDBmZW4vOGZKLzFVZ2JGYytZdHZSTG9EV0lkaXNjRFBETnU5UmRVYWRW?=
 =?utf-8?B?NC9sb09EMnVXYkVRM0hCOGRZVko0QlZrd3R1b0p0S21iSGwvSHFJVGcvandI?=
 =?utf-8?B?NmZWVmltMDZkQ2NIaTVIT2pqWnFOaXVFbWNEQkJXa0w5dE1aWnhlN1lUUDdS?=
 =?utf-8?B?aDZpSUdtTWZBMDlwN1lIbjJYSjgwMXBjaVBtOWVBMVhMOGVjQzNzOGs3eDZ4?=
 =?utf-8?B?R0twajNWL29IYWRZaHRNZmt4NWU1YU5iZDVaQzFjdjloOFVFRVlaOTIzNTBv?=
 =?utf-8?B?MzV5TytmUzY3ejlBaXJRVUUzK1JpcDNqWXVzVlBMSWJJSWhYMmIvYmp2NG1D?=
 =?utf-8?B?K3ZkVmhxK0prYlVjaXdLbldoaHc1OXV0S0I5SVpiMkxnd1VhU3hWUGFRd3Nw?=
 =?utf-8?B?b29wRURMUmhOWDBvOE5ha09HSll2Y0ZyenlsZ3VQbGRTSHFlbVhqL0t3aHVJ?=
 =?utf-8?B?NEM3Z1FmeVJpY1V3dVdxY1V1bENHUEs3aXYyK2ZZTm1oeWlKeGxkS1JDejUw?=
 =?utf-8?B?c0NOdjFnNFhHd1dQUElvRFVOb3FzeWZIbXBhUDhvcGhkL3pnZlJUbjBrRmJ4?=
 =?utf-8?B?TTg0MTk4ZldqL3N6c0dTdktxVldJMENtZnZDcEs0OW00NTY2cjVFQ3F6REE3?=
 =?utf-8?B?UlVoY0R0QWx0N0h4SkZ0SkFKRWUvREs5K2RyMXZ4WHFtMWE1TWxjbmZ2VHo5?=
 =?utf-8?B?ZEhrNG5Cb2U5QU5KbC96MEEzYzRhQXlhWGhRUGN1K1RuOEFxeldEN2wvZmNE?=
 =?utf-8?B?dHI4dlJOWXJweGlicjBBVHhNeCtzTnEyT0pvZjA4OGhPaFliMm5HdFdyUTVJ?=
 =?utf-8?B?MnZkdTB3bWJoa21oY3IzQlgycCtDZUJnWFMzTmRSck5veHVIbWhXdmdEWHF6?=
 =?utf-8?B?cXp2WWZjd01xWERidDJCaFVmLzd6VFY5czVRampMUEkvSk41NHdjVUkwSTN0?=
 =?utf-8?B?QjBoVy9HN0VCaWpZVVZNeGxIZWtwVC94aWV5OWRvL0tuQ3B2UUEySUxwbDVl?=
 =?utf-8?B?QVpIM1FrU2R5c245TzE3a2lUSHhOL3FPMkU4UlZGelJaVmloazRSVmdCWTY1?=
 =?utf-8?B?V1IrZ1lrWHNuTWNqZU9vUldXT3JRcnJaT0JLdTZtR3hvRWV3K1pWRmdOSXpL?=
 =?utf-8?B?Y28xcEJzZ01EelFQbXZYZjUvZVlUZ0U2eWJKQmNidWJnT2Mxc0RtOExDRThG?=
 =?utf-8?B?VVBmNkR1Wlh5ZDh3NUtaYzdNV2d0cDRWVVNhUzg2MWNDU2VqSG9kSWhzOWl3?=
 =?utf-8?B?QWhHekRZUHpjUnRsTVRZbU9MUEJsRVRHTUY0aUVmeEtZb1l0YTNWMW10enZn?=
 =?utf-8?B?Ky82ckgzSmhCNExoT1hId3JvOHpMdG13QnFsRHJmd1hnbUhTTzQ1QUVheXls?=
 =?utf-8?B?b0g0STN3bi91YlNzcXZuWDdkMC9qQk9UZXorc3gvNzY2NUVMRDh5QjZYZVlk?=
 =?utf-8?B?aXgyVWI3UlpoczM4enE3UnlQdC9nZ0o5bFpleEt6R0FNY1lJL21OZHhVTnlV?=
 =?utf-8?B?OHAxU2tySDNrVi9wTTBQcTh6eTFvdzRCcitIMHhkb0lhbXBNQU1Jd0hQc2hC?=
 =?utf-8?B?Q3Rha3M2MjNlUEhKaG9UUkJuU3J4enlvOTcwMUJvNlEzK01RbC9VWXZReDNN?=
 =?utf-8?B?eExUQUFZdGZzbXJ5b3hzQUF1VmN3R3hLVEJtWW9NN3g2QUhsY2dMN2JPL3BV?=
 =?utf-8?Q?aljll7n71Ro/TSDWW0NUEG2zA3Z4cK3L6DmFVW5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <837EA667FE9FE240970DC1812C2FE554@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbc9330-c553-4975-365c-08d92acd3102
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 22:31:42.7321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGay6+eR17QFo/KMhr68ovJ+XHRy874KuXFynlQSBFXuklKFPjXE9QZFimmhsbAS0faRTQ7Qcifi5P92dqp+hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4574
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTA4IGF0IDE4OjIxIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVHVlLCBKdW4gOCwgMjAyMSBhdCA1OjQxIFBNIFRyb25kIE15a2xlYnVzdCA8IA0K
PiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVHVlLCAyMDIx
LTA2LTA4IGF0IDE3OjMwIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+IE9u
IFR1ZSwgSnVuIDgsIDIwMjEgYXQgNToyNiBQTSBUcm9uZCBNeWtsZWJ1c3QgPA0KPiA+ID4gdHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gT24gVHVlLCAy
MDIxLTA2LTA4IGF0IDIxOjE5ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+
ID4gT24gVHVlLCAyMDIxLTA2LTA4IGF0IDIxOjA2ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3Jv
dGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBPbiBKdW4gOCwg
MjAyMSwgYXQgNDo1NiBQTSwgT2xnYSBLb3JuaWV2c2thaWEgPA0KPiA+ID4gPiA+ID4gPiBvbGdh
Lmtvcm5pZXZza2FpYUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gT24gVHVlLCBKdW4gOCwgMjAyMSBhdCA0OjQxIFBNIENodWNrIExldmVyIElJSSA8DQo+
ID4gPiA+ID4gPiA+IGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+
ID4gT24gSnVuIDgsIDIwMjEsIGF0IDI6NDUgUE0sIE9sZ2EgS29ybmlldnNrYWlhIDwNCj4gPiA+
ID4gPiA+ID4gPiA+IG9sZ2Eua29ybmlldnNrYWlhQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+IEZyb206IE9sZ2EgS29ybmlldnNrYWlhIDxr
b2xnYUBuZXRhcHAuY29tPg0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiBB
ZnRlciB0cnVua2luZyBpcyBkaXNjb3ZlcmVkIGluDQo+ID4gPiA+ID4gPiA+ID4gPiBuZnM0X2Rp
c2NvdmVyX3NlcnZlcl90cnVua2luZygpLA0KPiA+ID4gPiA+ID4gPiA+ID4gYWRkIHRoZSB0cmFu
c3BvcnQgdG8gdGhlIG9sZCBjbGllbnQgc3RydWN0dXJlIGJlZm9yZQ0KPiA+ID4gPiA+ID4gPiA+
ID4gZGVzdHJveWluZw0KPiA+ID4gPiA+ID4gPiA+ID4gdGhlIG5ldyBjbGllbnQgc3RydWN0dXJl
IChhbG9uZyB3aXRoIGl0cyB0cmFuc3BvcnQpLg0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBw
LmNvbT4NCj4gPiA+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiA+ID4gZnMvbmZzL25m
czRjbGllbnQuYyB8IDQwDQo+ID4gPiA+ID4gPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gPiA+ID4gPiAxIGZpbGUgY2hhbmdlZCwgNDAg
aW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvZnMvbmZzL25mczRjbGllbnQuYw0KPiA+ID4gPiA+ID4gPiA+ID4gYi9mcy9uZnMv
bmZzNGNsaWVudC5jDQo+ID4gPiA+ID4gPiA+ID4gPiBpbmRleCA0MjcxOTM4NGUyNWYuLjk4NGM4
NTE4NDRkOCAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2ZzL25mcy9uZnM0Y2xpZW50
LmMNCj4gPiA+ID4gPiA+ID4gPiA+ICsrKyBiL2ZzL25mcy9uZnM0Y2xpZW50LmMNCj4gPiA+ID4g
PiA+ID4gPiA+IEBAIC0zNjEsNiArMzYxLDQ0IEBAIHN0YXRpYyBpbnQNCj4gPiA+ID4gPiA+ID4g
PiA+IG5mczRfaW5pdF9jbGllbnRfbWlub3JfdmVyc2lvbihzdHJ1Y3QgbmZzX2NsaWVudA0KPiA+
ID4gPiA+ID4gPiA+ID4gKmNscCkNCj4gPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgIHJldHVybiBu
ZnM0X2luaXRfY2FsbGJhY2soY2xwKTsNCj4gPiA+ID4gPiA+ID4gPiA+IH0NCj4gPiA+ID4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gK3N0YXRpYyB2b2lkIG5mczRfYWRkX3RydW5rKHN0
cnVjdCBuZnNfY2xpZW50ICpjbHAsDQo+ID4gPiA+ID4gPiA+ID4gPiBzdHJ1Y3QNCj4gPiA+ID4g
PiA+ID4gPiA+IG5mc19jbGllbnQgKm9sZCkNCj4gPiA+ID4gPiA+ID4gPiA+ICt7DQo+ID4gPiA+
ID4gPiA+ID4gPiArwqDCoMKgwqAgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgY2xwX2FkZHIsIG9s
ZF9hZGRyOw0KPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCBzb2NrYWRkciAqY2xw
X3NhcCA9IChzdHJ1Y3Qgc29ja2FkZHINCj4gPiA+ID4gPiA+ID4gPiA+ICopJmNscF9hZGRyOw0K
PiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCBzb2NrYWRkciAqb2xkX3NhcCA9IChz
dHJ1Y3Qgc29ja2FkZHINCj4gPiA+ID4gPiA+ID4gPiA+ICopJm9sZF9hZGRyOw0KPiA+ID4gPiA+
ID4gPiA+ID4gK8KgwqDCoMKgIHNpemVfdCBjbHBfc2FsZW4sIG9sZF9zYWxlbjsNCj4gPiA+ID4g
PiA+ID4gPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgeHBydF9jcmVhdGUgeHBydF9hcmdzID0gew0KPiA+
ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuaWRlbnQgPSBvbGQtPmNs
X3Byb3RvLA0KPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAubmV0
ID0gb2xkLT5jbF9uZXQsDQo+ID4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC5zZXJ2ZXJuYW1lID0gb2xkLT5jbF9ob3N0bmFtZSwNCj4gPiA+ID4gPiA+ID4gPiA+ICvC
oMKgwqDCoCB9Ow0KPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCBuZnM0X2FkZF94
cHJ0X2RhdGEgeHBydGRhdGEgPSB7DQo+ID4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC5jbHAgPSBvbGQsDQo+ID4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqAgfTsNCj4g
PiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgcnBjX2FkZF94cHJ0X3Rlc3QgcnBjZGF0
YSA9IHsNCj4gPiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmFkZF94
cHJ0X3Rlc3QgPSBvbGQtPmNsX212b3BzLQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiBzZXNzaW9uX3Ry
dW5rLA0KPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuZGF0YSA9
ICZ4cHJ0ZGF0YSwNCj4gPiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoCB9Ow0KPiA+ID4gPiA+ID4g
PiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIGlmIChjbHAtPmNsX3Byb3RvICE9
IG9sZC0+Y2xfcHJvdG8pDQo+ID4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybjsNCj4gPiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoCBjbHBfc2FsZW4gPSBycGNf
cGVlcmFkZHIoY2xwLT5jbF9ycGNjbGllbnQsDQo+ID4gPiA+ID4gPiA+ID4gPiBjbHBfc2FwLA0K
PiA+ID4gPiA+ID4gPiA+ID4gc2l6ZW9mKGNscF9hZGRyKSk7DQo+ID4gPiA+ID4gPiA+ID4gPiAr
wqDCoMKgwqAgb2xkX3NhbGVuID0gcnBjX3BlZXJhZGRyKG9sZC0+Y2xfcnBjY2xpZW50LA0KPiA+
ID4gPiA+ID4gPiA+ID4gb2xkX3NhcCwNCj4gPiA+ID4gPiA+ID4gPiA+IHNpemVvZihvbGRfYWRk
cikpOw0KPiA+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIGlm
IChjbHBfYWRkci5zc19mYW1pbHkgIT0gb2xkX2FkZHIuc3NfZmFtaWx5KQ0KPiA+ID4gPiA+ID4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4gPiA+ID4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqAgeHBydF9hcmdzLmRzdGFkZHIgPSBjbHBf
c2FwOw0KPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHhwcnRfYXJncy5hZGRybGVuID0gY2xw
X3NhbGVuOw0KPiA+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKg
IHhwcnRkYXRhLmNyZWQgPSBuZnM0X2dldF9jbGlkX2NyZWQob2xkKTsNCj4gPiA+ID4gPiA+ID4g
PiA+ICvCoMKgwqDCoCBycGNfY2xudF9hZGRfeHBydChvbGQtPmNsX3JwY2NsaWVudCwNCj4gPiA+
ID4gPiA+ID4gPiA+ICZ4cHJ0X2FyZ3MsDQo+ID4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCj4gPiA+ID4gPiA+ID4gPiA+IHJwY19j
bG50X3NldHVwX3Rlc3RfYW5kX2FkZF94cHJ0LA0KPiA+ID4gPiA+ID4gPiA+ID4gJnJwY2RhdGEp
Ow0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IElzIHRoZXJlIGFuIHVwcGVyIGJv
dW5kIG9uIHRoZSBudW1iZXIgb2YgdHJhbnNwb3J0cw0KPiA+ID4gPiA+ID4gPiA+IHRoYXQNCj4g
PiA+ID4gPiA+ID4gPiBhcmUgYWRkZWQgdG8gdGhlIE5GUyBjbGllbnQncyBzd2l0Y2g/DQo+ID4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJIGRvbid0IGJlbGlldmUgYW55IGxpbWl0cyBleGlz
dCByaWdodCBub3cuIFdoeSBzaG91bGQNCj4gPiA+ID4gPiA+ID4gdGhlcmUNCj4gPiA+ID4gPiA+
ID4gYmUgYQ0KPiA+ID4gPiA+ID4gPiBsaW1pdD8gQXJlIHlvdSBzYXlpbmcgdGhhdCB0aGUgY2xp
ZW50IHNob3VsZCBsaW1pdA0KPiA+ID4gPiA+ID4gPiB0cnVua2luZz8NCj4gPiA+ID4gPiA+ID4g
V2hpbGUNCj4gPiA+ID4gPiA+ID4gdGhpcyBpcyBub3Qgd2hhdCdzIGhhcHBlbmluZyBoZXJlLCBi
dXQgc2F5IEZTX0xPQ0FUSU9ODQo+ID4gPiA+ID4gPiA+IHJldHVybmVkDQo+ID4gPiA+ID4gPiA+
IDEwMA0KPiA+ID4gPiA+ID4gPiBpcHMgZm9yIHRoZSBzZXJ2ZXIuIEFyZSB5b3Ugc2F5aW5nIHRo
ZSBjbGllbnQgc2hvdWxkIGJlDQo+ID4gPiA+ID4gPiA+IGxpbWl0aW5nDQo+ID4gPiA+ID4gPiA+
IGhvdw0KPiA+ID4gPiA+ID4gPiBtYW55IHRydW5rYWJsZSBjb25uZWN0aW9ucyBpdCB3b3VsZCBi
ZSBlc3RhYmxpc2hpbmcgYW5kDQo+ID4gPiA+ID4gPiA+IHBpY2tpbmcNCj4gPiA+ID4gPiA+ID4g
anVzdCBhDQo+ID4gPiA+ID4gPiA+IGZldyBhZGRyZXNzZXMgdG8gdHJ5PyBXaGF0J3MgaGFwcGVu
aW5nIHdpdGggdGhpcyBwYXRjaCBpcw0KPiA+ID4gPiA+ID4gPiB0aGF0DQo+ID4gPiA+ID4gPiA+
IHNheQ0KPiA+ID4gPiA+ID4gPiB0aGVyZSBhcmUgMTAwbW91bnRzIHRvIDEwMCBpcHMgKGVhY2gg
cmVwcmVzZW50aW5nIHRoZQ0KPiA+ID4gPiA+ID4gPiBzYW1lDQo+ID4gPiA+ID4gPiA+IHNlcnZl
cg0KPiA+ID4gPiA+ID4gPiBvcg0KPiA+ID4gPiA+ID4gPiB0cnVua2FibGUgc2VydmVyKHMpKSwg
d2l0aG91dCB0aGlzIHBhdGNoIGEgc2luZ2xlDQo+ID4gPiA+ID4gPiA+IGNvbm5lY3Rpb24NCj4g
PiA+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiA+ID4ga2VwdCwNCj4gPiA+ID4gPiA+ID4gd2l0aCB0
aGlzIHBhdGNoIHdlJ2xsIGhhdmUgMTAwIGNvbm5lY3Rpb25zLg0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiBUaGUgcGF0Y2ggZGVzY3JpcHRpb24gbmVlZHMgdG8gbWFrZSB0aGlzIGJlaGF2aW9y
IG1vcmUNCj4gPiA+ID4gPiA+IGNsZWFyLg0KPiA+ID4gPiA+ID4gSXQNCj4gPiA+ID4gPiA+IG5l
ZWRzIHRvIGV4cGxhaW4gIndoeSIgLS0gdGhlIGJvZHkgb2YgdGhlIHBhdGNoIGFscmVhZHkNCj4g
PiA+ID4gPiA+IGV4cGxhaW5zDQo+ID4gPiA+ID4gPiAid2hhdCIuIENhbiB5b3UgaW5jbHVkZSB5
b3VyIGxhc3Qgc2VudGVuY2UgaW4gdGhlDQo+ID4gPiA+ID4gPiBkZXNjcmlwdGlvbg0KPiA+ID4g
PiA+ID4gYXMNCj4gPiA+ID4gPiA+IGEgdXNlIGNhc2U/DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IEFzIGZvciB0aGUgYmVoYXZpb3IuLi4gU2VlbXMgdG8gbWUgdGhhdCB0aGVyZSBhcmUgZ29p
bmcgdG8NCj4gPiA+ID4gPiA+IGJlDQo+ID4gPiA+ID4gPiBvbmx5DQo+ID4gPiA+ID4gPiBpbmZp
bml0ZXNpbWFsIGdhaW5zIGFmdGVyIHRoZSBmaXJzdCBmZXcgY29ubmVjdGlvbnMsIGFuZA0KPiA+
ID4gPiA+ID4gYWZ0ZXINCj4gPiA+ID4gPiA+IHRoYXQsIGl0J3MgZ29pbmcgdG8gYmUgYSBsb3Qg
Zm9yIGJvdGggc2lkZXMgdG8gbWFuYWdlIGZvcg0KPiA+ID4gPiA+ID4gbm8NCj4gPiA+ID4gPiA+
IHJlYWwNCj4gPiA+ID4gPiA+IGdhaW4uIEkgdGhpbmsgeW91IGRvIHdhbnQgdG8gY2FwIHRoZSB0
b3RhbCBudW1iZXIgb2YNCj4gPiA+ID4gPiA+IGNvbm5lY3Rpb25zDQo+ID4gPiA+ID4gPiBhdCBh
IHJlYXNvbmFibGUgbnVtYmVyLCBldmVuIGluIHRoZSBGU19MT0NBVElPTlMgY2FzZS4NCj4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEknZCB0ZW5kIHRvIGFncmVlLiBJZiB5b3Ug
d2FudCB0byBzY2FsZSBJL08gdGhlbiBwTkZTIGlzIHRoZQ0KPiA+ID4gPiA+IHdheQ0KPiA+ID4g
PiA+IHRvDQo+ID4gPiA+ID4gZ28sDQo+ID4gPiA+ID4gbm90IHZhc3QgbnVtYmVycyBvZiBjb25u
ZWN0aW9ucyB0byBhIHNpbmdsZSBzZXJ2ZXIuDQo+ID4gPiA+ID4gDQo+ID4gPiA+IEJUVzogQUZB
SUNTIHRoaXMgcGF0Y2ggd2lsbCBlbmQgdXAgYWRkaW5nIGFub3RoZXIgY29ubmVjdGlvbg0KPiA+
ID4gPiBldmVyeQ0KPiA+ID4gPiB0aW1lDQo+ID4gPiA+IHdlIG1vdW50IGEgbmV3IGZpbGVzeXN0
ZW0sIHdoZXRoZXIgb3Igbm90IGEgY29ubmVjdGlvbiBhbHJlYWR5DQo+ID4gPiA+IGV4aXN0cw0K
PiA+ID4gPiB0byB0aGF0IElQIGFkZHJlc3MuIFRoYXQncyB1bmFjY2VwdGFibGUuDQo+ID4gPiAN
Cj4gPiA+IE5vdCBpbiBteSB0ZXN0aW5nLiBNb3VudHMgdG8gdGhlIHNhbWUgc2VydmVyIChzYW1l
IElQKSBkaWZmZXJlbnQNCj4gPiA+IGV4cG9ydCB2b2x1bWVzIGxlYWQgdG8gdXNlIG9mIGEgc2lu
Z2xlIGNvbm5lY3Rpb24uDQo+ID4gPiA+IA0KPiA+IA0KPiA+IEFoLi4uIE5ldmVyIG1pbmQuIFRo
ZSBjb21wYXJpc29uIGlzIG1hZGUgYnkNCj4gPiBycGNfY2xudF9zZXR1cF90ZXN0X2FuZF9hZGRf
eHBydCgpLCBhbmQgdGhlIGFkZHJlc3MgaXMgZGlzY2FyZGVkIGlmDQo+ID4gaXQNCj4gPiBpcyBh
bHJlYWR5IHByZXNlbnQuDQo+ID4gDQo+ID4gSG93ZXZlciB3aHkgYXJlIHlvdSBydW5uaW5nIHRy
dW5raW5nIGRldGVjdGlvbiBhIHNlY29uZCB0aW1lIG9uIHRoZQ0KPiA+IGFkZHJlc3MgeW91J3Zl
IGp1c3QgcnVuIHRydW5raW5nIGRldGVjdGlvbiBvbiBhbmQgaGF2ZSBkZWNpZGVkIHRvDQo+ID4g
YWRkPw0KPiANCj4gQmVjYXVzZSB0aGF0J3Mgd2hlcmUgd2UgZGV0ZXJtaW5lZCB0aGF0IHRoZXNl
IGFyZSBkaWZmZXJlbnQgY2xpZW50cw0KPiBhbmQgYXJlIHRydW5rYWJsZT8gQnV0IEkgZ3Vlc3Mg
YWxzbyBmb3IgdGhlIGVhc2Ugb2YgcmUtdXNpbmcgZXhpc3RpbmcNCj4gY29kZS4gVGhlcmUgaXMg
bm8gaG9vayB0byBjcmVhdGUgYW4geHBydCBhbmQgYWRkIGl0IHRvIGFuIGV4aXN0aW5nDQo+IFJQ
Qw0KPiBjbGllbnQuIE9uZSBjYW4gYmUgY3JlYXRlZC4NCg0KV2h5IG5vdCBycGNfY2xudF9hZGRf
eHBydCgpPyBUaGF0J3Mgd2hhdCBwTkZTIHVzZXMgZm9yIHRoaXMgY2FzZS4NCg0KDQoNCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
