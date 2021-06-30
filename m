Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7353B8686
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 17:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbhF3Pyq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 11:54:46 -0400
Received: from mail-bn7nam10on2096.outbound.protection.outlook.com ([40.107.92.96]:33666
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235726AbhF3Pyo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 30 Jun 2021 11:54:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrGgSRyY1rv0RcPRS28gXLv9fIlGRtQZ4OvbMIh5sOt+PrWOlrncZggGRT7xSaKwRPZSm/xsMRLq+oK8ceR1MTkgI3ES2tX/Mt34wjt5Z14tWqY+uXUiSeeFecVp1gB5TXiAnyUlfMOXR64jJiY392I7UWWgOYrM5hqzVfBqKDjxOBUvsb4KgJgovCbf4ZXroq/CbN1bkHJNozULciSLcWxUlrp5EAoeBSblXFMjcZJjzXbstd6yMgYzC69hwDwQ7V841xB4d4V412rzY9WzIzPnsJIoKANEiB641epHOnrxq44CD0z06AIg9yk820RdEl4cNOBrQCJHv3p7Cd19JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHIk2kJXgL68oGTqZCt+pyIl0xir7F4ErMFaKAofCS8=;
 b=ToPGAzURY3LmepaYdGL9s3z6QO8V86HpldKArAfcTtcH5vmay6PJ6PVHnV3DdCQDHa91xGuqprfCTnkFnVVcsf5S3sC+pqvYv2VPRtSnnQ2li9ki5joOXHLgD1XIP6eN6JX8gALDdAMlFTVIcgTB9wLL20+48AXN+8xrxl5BwM01swKNqkm7SefvgK+wXGn+01p0kTatm7XIGb+bJwM7DxEBVkgFEfn0yDYTRQtbhwKdwHn9WqUlzwsvs+QutHIsLjeLTj/eaqk582X4eDgzL1+I2B47jrpa61ruuWoAiB8jw/u3Zio/BeqybEXFuzpjZ+MJPhXvxa4NcHTQXs+/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHIk2kJXgL68oGTqZCt+pyIl0xir7F4ErMFaKAofCS8=;
 b=Y/sGS8eZ9oWKK9ST0Clb616qQwL1Ebr5n++sWWzUpscqZpJHaOqnXwzYImG/HCaABKHXvvyPxGiKuO/PtfvbebSoMKZIli3IFAnXtovX5Zrl1J3t13TrNurxkqK1Vx9jAn7f7UPN2l0SUaGvl/5LT4Ck3g5f4QwgwSNQDwJutaU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3669.namprd13.prod.outlook.com (2603:10b6:610:a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.9; Wed, 30 Jun
 2021 15:52:13 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57%4]) with mapi id 15.20.4287.022; Wed, 30 Jun 2021
 15:52:13 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>
Subject: Re: client's caching of server-side capabilities
Thread-Topic: client's caching of server-side capabilities
Thread-Index: AQHXbFuMjtq3PRTcuEmeUcYpGr/LhKsp+uuAgAD5LgCAAA38gIAAAP2AgAGr0wCAAAgqgA==
Date:   Wed, 30 Jun 2021 15:52:13 +0000
Message-ID: <1c36c2e932db265d9e5c1699a657c2706504598d.camel@hammerspace.com>
References: <CAN-5tyEuB5C9u+xZ5L47fSQ9cwZnsbhJuBs+gybU2A-jzAkfog@mail.gmail.com>
         <81154dc28d528402bf5e090a81e6892c7abc431c.camel@hammerspace.com>
         <B0CA736F-E3E8-4446-9A6E-3ADCDD7F8736@oracle.com>
         <CAN-5tyE5Y3+ZPrfAR8=UVdNnWxyzO6a_NTeTsMFH_TyyMqK-bQ@mail.gmail.com>
         <607F15BF-89B4-4123-8223-A3893229D219@oracle.com>
         <20210630152258.GC20229@fieldses.org>
In-Reply-To: <20210630152258.GC20229@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e83a106-df47-4cd7-587b-08d93bdf0711
x-ms-traffictypediagnostic: CH2PR13MB3669:
x-microsoft-antispam-prvs: <CH2PR13MB3669E010E36B9B32832D424BB8019@CH2PR13MB3669.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tdAhwOeJpwcD9nOzBQkvIm0Ltlg3YRmsCgVtYbO8tSNaVWZdSH0gK3hFmdiR7h8AUwJ1qkDzngc6Uelb8Et2AsH16XAFe7hoyQKRe5l3VbeUospPCLFOfSP5eFaFF/zC0yY216pZ2gYVokWsIgjqK83hr9N9CXnik/CWxzsBwWRBEfGuH64FTPSUydv3fiiO058/qmT2ytxlk9wYGaUJcQi0f1LRxv8FPQFzPX/eMhj59ZZUCy2W/BJx+U36utO29cTa633K1C69PUHuqkXiY2I5WEkDs3nMWg21RGKWwkI7afPwxlk6W4cw0MRKLuOD/gS1OIu9SXSbE43rixKwnsEtLc6hSTOnSW+G5Ei+cn3CLtH63MAxCCvcsOX6QhXIZElJdDVSoQGRfnKlBSDdr5fppnUG5QUEz7zuSyIuL2a62YXn0UQ9Sp0LJUUJnXNreehIvxo/u+9dxQiHI14+94ZfMhq36PZWnk7azfFV8iK3qROFY8VImNwxfE57BZNLVPZ0R/hqzHW5/fVZspJRw1ObGFR71PSRI+cwPfb9fvrfrIDRg0LvN9LFWzMVJ7xg5S6rQdG8juds+l3Tr1y7uodG1kzCBLYNrsILt28Ehx9eSu7QJBN5dpgKTd8W06s176TkNrnqOom0Xx2bhEwnrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39830400003)(396003)(366004)(122000001)(186003)(8936002)(38100700002)(6506007)(53546011)(86362001)(6486002)(2906002)(4326008)(6512007)(8676002)(316002)(26005)(478600001)(71200400001)(2616005)(110136005)(36756003)(83380400001)(66556008)(66476007)(66946007)(76116006)(64756008)(66446008)(5660300002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkd3MlV0QTNFb2Y5R0lvUDFLSWM0d2tMODZ3V0V4OGRhbm00SDgyMnd5S0Zi?=
 =?utf-8?B?ejQ2eE50Y0w5WmdkQzN2TTI3SjFabitkVTlCVlVqNTBYQXovTko0WHNFMnhS?=
 =?utf-8?B?ZzZ1UmwzeGFEMzRTc0VMYURMVjIyN05pb1o4QXRmWVpRTkxPMlUxZkcwSFBv?=
 =?utf-8?B?alp2UUtvQzJBUXlCRlNPZ005aG5FLzJUTW1Obk5WSHhwTE1FdU12NW0vVGY0?=
 =?utf-8?B?MXdGamU1ZVJrYThyZ2dkcnpGZE5HcEcyaWxJaFM4S1NySFBEWmVNUDZ3MlV3?=
 =?utf-8?B?U01YbGJVaVJxcmpDSVlUbldkS3BkbHBTUmNzaW8rRUoxdTFOSFdnK0d6VHhp?=
 =?utf-8?B?dDZTdFkrVHN5cDArNS9TdDYvSVpnYk95T3BDbG9EeUFNWlBBc2ppeTFERFVD?=
 =?utf-8?B?K2JsZitncGRaYndNSnVSSWttUEZlNDRvVWFLbktsUkdKT29QZG1ucWMwdkxr?=
 =?utf-8?B?ZDFqQXdybFMyMTczOENVdXZRMnZJZURXNkJYVytTNm5HUHY2d0tOYnVaYXJV?=
 =?utf-8?B?Z1hGMHl1TGdqR1NCL3JwMUpIb2FUQkQvZVJRTytsSXdWOUxDZURZdDhFemZI?=
 =?utf-8?B?SVpxSlVUUloxUjNYV3BXZ0ZQRWRySXpvcWN5VjZVZUhJMEMwNm5PZU5SZkJO?=
 =?utf-8?B?bzJVYzdMdWF4NFNPMTk1ZFNQUEpKcHZvcDhRQ2Zob3FmV3htNVBVN0VFWGRT?=
 =?utf-8?B?K3lLcWRRcEdCWnVrWVJneHF4d3oxQ3I0UlFDZytwMHRyOFM5cDcyZHlnUnFD?=
 =?utf-8?B?U0JCckMyNFluZTYzZnRKSC9tRmI1Qk9qam1hVHJ4VVBlSnNZM01pL3FHcHM1?=
 =?utf-8?B?TnNuem1YazhtcXM2cENXMlhjM0E1ZHJwZ0JWU0pwVDFDSHhxTnNrNjhKV21N?=
 =?utf-8?B?bUdObmx1NFR3Snc2N2hveGpUMUdQYjc2WGp1MW5xWThyYkphK1ZxdDYyNnZ2?=
 =?utf-8?B?VTVDQXA4U3haVTdIZjdLUWc5ZWRmVTF0N24rKzBnMSt1UnZWWmtFdkJMWjNM?=
 =?utf-8?B?SUQyVks0ZWFwZ05PdUpuRjNGNGVqZzF5Rk1hcE1Ca1lUMVVETEJpTXdvSHlM?=
 =?utf-8?B?RWxTa1gwMXk4NTBYYXduQVB3SVRJTyswRSt0cDZOMmo2V1kyR01Ba2lLdEg2?=
 =?utf-8?B?RnpNZ3l4b3hWVzJWUllZS1JOVmxXNE44RE0wUEdHeW12QkVqTzVIbHZVV0JU?=
 =?utf-8?B?bE9wYXI2VXA1eGJuRXZqY3B4bVU3cFZvd1E4NmwrK1hXbCtFS3gxMU5USmVM?=
 =?utf-8?B?QUhTWUUvcC9NU0l4NzRGdGhTZHZLd2t4UDIxSktHR3lGLzhESHVTNVBFSFFs?=
 =?utf-8?B?SUp6NHQzM2JKM1pHcnJyNlJpY1B0NzMzT0tOOThjZ2MwVzVsZzk3Q0pXTlZh?=
 =?utf-8?B?Y0tPRDRGRTIxYzhjbGtvOGpHdHZrUHdoUUt0SmNZdUhyd1dzUEMrYmc5WEN3?=
 =?utf-8?B?TzhiZ1VYcU82OStsSmpzT2JFV21UaVVFK0djTkpuNG9IMnBJQWp5M3kvOVdO?=
 =?utf-8?B?TkVOVTJNNEZlYjE5akJ0anFHK0E5MG1jNzhBeDNUMTh3b1hzeHR5d1NCaHVZ?=
 =?utf-8?B?R1FaNjFBeFlZeVJrajBvUTJycUw2WXRiUlZwUDZJVTRsd3lwdzRBZ0RUSDRs?=
 =?utf-8?B?cnZjRTA1U1pRUUYrK0h2NndjV0VVQ2s2ZW9iZWNXN2JxaUswVG15WlZ0Zk5Q?=
 =?utf-8?B?S1JLRXJiM1Bva3Nza2FadlhORU1HcFpEVXBsenpHQVRZQ0g2dzVISHFQdXEz?=
 =?utf-8?Q?OTv+PE30SGRwEr9ZXeMMSd/Knj8fMPBhZwFgPCs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <515A62A6BD305947A0A0D2F09DA65C97@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e83a106-df47-4cd7-587b-08d93bdf0711
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 15:52:13.1112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ENh8KusKknXrrRZnOEBbpPg/h0af+PyWrsibpFwQHbnQVxL/esZr84rNMN+hM9i2ulwy1KqsHHMVRyW6VifoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3669
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTMwIGF0IDExOjIyIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFR1ZSwgSnVuIDI5LCAyMDIxIGF0IDAxOjUxOjQzUE0gKzAwMDAsIENodWNrIExldmVy
IElJSSB3cm90ZToNCj4gPiANCj4gPiANCj4gPiA+IE9uIEp1biAyOSwgMjAyMSwgYXQgOTo0OCBB
TSwgT2xnYSBLb3JuaWV2c2thaWEgPGFnbG9AdW1pY2guZWR1Pg0KPiA+ID4gd3JvdGU6DQo+ID4g
PiANCj4gPiA+IE9uIFR1ZSwgSnVuIDI5LCAyMDIxIGF0IDg6NTggQU0gQ2h1Y2sgTGV2ZXIgSUlJ
DQo+ID4gPiA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4g
PiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gT24gSnVuIDI4LCAyMDIxLCBhdCA2OjA2IFBNLCBUcm9u
ZCBNeWtsZWJ1c3QNCj4gPiA+ID4gPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIE1vbiwgMjAyMS0wNi0yOCBhdCAxNjoyMyAtMDQwMCwg
T2xnYSBLb3JuaWV2c2thaWEgd3JvdGU6DQo+ID4gPiA+ID4gPiBIaSBmb2xrcywNCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gSSBoYXZlIGEgZ2VuZXJhbCBxdWVzdGlvbiBvZiB3aHkgdGhlIGNs
aWVudCBkb2Vzbid0IHRocm93DQo+ID4gPiA+ID4gPiBhd2F5IHRoZQ0KPiA+ID4gPiA+ID4gY2Fj
aGVkIHNlcnZlcidzIGNhcGFiaWxpdGllcyBvbiBzZXJ2ZXIgcmVib290LiBTYXkgYSBjbGllbnQN
Cj4gPiA+ID4gPiA+IG1vdW50ZWQgYQ0KPiA+ID4gPiA+ID4gc2VydmVyIHdoZW4gdGhlIHNlcnZl
ciBkaWRuJ3Qgc3VwcG9ydCBzZWN1cml0eV9sYWJlbHMsIHRoZW4NCj4gPiA+ID4gPiA+IHRoZQ0K
PiA+ID4gPiA+ID4gc2VydmVyDQo+ID4gPiA+ID4gPiB3YXMgcmVib290ZWQgYW5kIHN1cHBvcnQg
d2FzIGVuYWJsZWQuIENsaWVudCByZS1lc3RhYmxpc2hlcw0KPiA+ID4gPiA+ID4gaXRzDQo+ID4g
PiA+ID4gPiBjbGllbnRpZC9zZXNzaW9uLCByZWNvdmVycyBzdGF0ZSwgYnV0IGFzc3VtZXMgYWxs
IHRoZSBvbGQNCj4gPiA+ID4gPiA+IGNhcGFiaWxpdGllcw0KPiA+ID4gPiA+ID4gYXBwbHkuIEEg
cmVtb3VudCBpcyByZXF1aXJlZCB0byBjbGVhciBvbGQvZmluZCBuZXcNCj4gPiA+ID4gPiA+IGNh
cGFiaWxpdGllcy4gVGhlDQo+ID4gPiA+ID4gPiBvcHBvc2l0ZSBpcyB0cnVlIHRoYXQgYSBjYXBh
YmlsaXR5IGNvdWxkIGJlIHJlbW92ZWQgKGJ1dA0KPiA+ID4gPiA+ID4gSSdtIGFzc3VtaW5nDQo+
ID4gPiA+ID4gPiB0aGF0J3MgYSBsZXNzIHByYWN0aWNhbCBleGFtcGxlKS4NCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gSSdtIGN1cmlvdXMgd2hhdCBhcmUgdGhlIHByb2JsZW1zIG9mIGNsZWFy
aW5nIHNlcnZlcg0KPiA+ID4gPiA+ID4gY2FwYWJpbGl0aWVzIGFuZA0KPiA+ID4gPiA+ID4gcmVk
aXNjb3ZlcmluZyB0aGVtIG9uIHJlYm9vdD8gSXMgaXQgYmVjYXVzZSBhIGxvY2FsDQo+ID4gPiA+
ID4gPiBmaWxlc3lzdGVtIGNvdWxkDQo+ID4gPiA+ID4gPiBuZXZlciBoYXZlIGl0cyBhdHRyaWJ1
dGVzIGNoYW5nZWQgYW5kIHRodXMgYSBuZXR3b3JrIGZpbGUNCj4gPiA+ID4gPiA+IHN5c3RlbQ0K
PiA+ID4gPiA+ID4gY2FuJ3QNCj4gPiA+ID4gPiA+IGVpdGhlcj8NCj4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gVGhhbmsgeW91Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEluIG15IG9waW5pb24s
IHRoZSBjbGllbnQgc2hvdWxkIGFpbSBmb3IgdGhlIGFic29sdXRlIG1pbmltdW0NCj4gPiA+ID4g
PiBvdmVyaGVhZA0KPiA+ID4gPiA+IG9uIGEgc2VydmVyIHJlYm9vdC4gVGhlIGdvYWwgc2hvdWxk
IGJlIHRvIHJlY292ZXIgc3RhdGUgYW5kDQo+ID4gPiA+ID4gZ2V0IEkvTw0KPiA+ID4gPiA+IHN0
YXJ0ZWQgYWdhaW4gYXMgcXVpY2tseSBhcyBwb3NzaWJsZS4NCj4gPiA+ID4gDQo+ID4gPiA+IEkg
MTAwJSBhZ3JlZSB3aXRoIHRoZSBhYm92ZS4gSG93ZXZlci4uLg0KPiA+ID4gPiANCj4gPiA+ID4g
DQo+ID4gPiA+ID4gRGV0ZWN0aW9uIG9mIG5ldyBmZWF0dXJlcywgZXRjDQo+ID4gPiA+ID4gY2Fu
IHdhaXQgdW50aWwgdGhlIGNsaWVudCBuZWVkcyB0byByZXN0YXJ0Lg0KPiA+ID4gPiANCj4gPiA+
ID4gQSBzZXJ2ZXIgcmVib290IGNhbiBiZSBwYXJ0IG9mIGEgZmFpbG92ZXIgdG8gYSBkaWZmZXJl
bnQNCj4gPiA+ID4gc2VydmVyLiBJDQo+ID4gPiA+IHRoaW5rIGNhcGFiaWxpdHkgZGlzY292ZXJ5
IG5lZWRzIHRvIGhhcHBlbiBhcyBwYXJ0IG9mIHNlcnZlcg0KPiA+ID4gPiByZWJvb3QNCj4gPiA+
ID4gcmVjb3ZlcnksIGl0IGNhbid0IGJlIG9wdGltaXplZCBhd2F5Lg0KPiA+ID4gDQo+ID4gPiBD
YW4geW91IGNsYXJpZnkgd2hhdCB5b3UgbWVhbiBieSBhICJmYWlsb3ZlciB0byBhIGRpZmZlcmVu
dA0KPiA+ID4gc2VydmVyIj8NCj4gPiANCj4gPiBJUC1iYXNlZCBmYWlsb3ZlciBtZWFucyB0aGF0
IGEgc2VydmVyIGNhbiBjcmFzaCwgYW5kIGl0cyBwYXJ0bmVyDQo+ID4gY2FuDQo+ID4gZGV0ZWN0
IHRoYXQgYW5kIHRha2Ugb3ZlciB0aGUgSVAgYWRkcmVzcyBhbmQgZXhwb3J0cyBvZiB0aGUgZmFp
bGVkDQo+ID4gc2VydmVyLiBUaGUgcmVwbGFjZW1lbnQgc2VydmVyIGRvZXNuJ3QgaGF2ZSB0byBo
YXZlIGV4YWN0bHkgdGhlDQo+ID4gc2FtZQ0KPiA+IHNldCBvZiBjYXBhYmlsaXRpZXMuDQo+IA0K
PiBTbyBpdCBjb3VsZCBhbHNvIGxvc2UgY2FwYWJpbGl0aWVzPw0KPiANCj4gSSdtIGEgbGl0dGxl
IG5lcnZvdXMgYWJvdXQgc2VydmVyIGZlYXR1cmVzIGJlaW5nIGNoYW5nZWQgb3V0IGZyb20NCj4g
dW5kZXINCj4gdGhlIGNsaWVudCB3aGlsZSB0aGUgY2xpZW50IGhhcyB0aGUgc2VydmVyIG1vdW50
ZWQuDQo+IA0KPiBCdXQsIEkgZG9uJ3Qga25vdywgbG9va2luZyBxdWlja2x5IHRocm91Z2ggdGhl
IGxpc3Qgb2YgTkZTX0NBUF8qDQo+IGRlZmluaXRpb25zIGluIG5mc19mc19zYi5oLCBJJ20gbm90
IGNvbWluZyB1cCB3aXRoIGEgY2FzZSB3aGVyZSB3ZQ0KPiBjb3VsZG4ndCBoYW5kbGUgaXQsIG1h
eWJlIGl0J3MgT0suDQo+IA0KPiAtLWIuDQoNCkknbSBub3QgdGFraW5nIGFueSBwYXRjaGVzIGZv
ciB0aGUgc2VydmVyIHJlYm9vdCBjYXNlLiBJZiBzb21lb25lIHdhbnRzDQp0byBkbyBpdCBmb3Ig
dGhlIG1pZ3JhdGlvbiBjYXNlLCB0aGVuIGZpbmU6IHRoYXQncyBub3QgYSBjYXNlIHRoYXQgaXMN
CmNvbW1vbiBvciB0aGF0IHJlcXVpcmVzIHBlcmZvcm1hbmNlLiBIb3dldmVyIHJlcHJvYmluZyBh
bGwgbW91bnRlZA0KZmlsZXN5c3RlbXMgb24gZXZlcnkgc2VydmVyIHJlYm9vdCBpcyBOQUNLZWQu
DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
