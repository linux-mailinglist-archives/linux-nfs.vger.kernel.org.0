Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 579F42CF8A
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 21:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfE1Td1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 15:33:27 -0400
Received: from mail-eopbgr710115.outbound.protection.outlook.com ([40.107.71.115]:53408
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727250AbfE1Td1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 May 2019 15:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxQozrgAu0KHX0sWSvb4E3vNZ6497pCE0GfTnB1xBC4=;
 b=Xq7wN1ZMipgAVpD3Kf+0QHlM8ucHPWY8mTAn6W7qaqlKUWWcoFheueSScMKm170rS/mOIjjneE9ZEPvZ3XmxO1Xr/2YpvUhfFe3EpAnKfiSrjLOyVdpdffCXfIhWvN0uDVjhlG7ByPwwC8OkD8/3i0WyUmXmjsBBPbXkeWc+dfs=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1771.namprd13.prod.outlook.com (10.171.157.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.8; Tue, 28 May 2019 19:33:24 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1943.016; Tue, 28 May 2019
 19:33:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 5/5] SUNRPC: Reduce the priority of the xprtiod queue
Thread-Topic: [RFC PATCH 5/5] SUNRPC: Reduce the priority of the xprtiod queue
Thread-Index: AQHVAaKLteyD+epX90KQZ+FxPa7AuqZelNIAgCJ4GwCAAAg4gA==
Date:   Tue, 28 May 2019 19:33:23 +0000
Message-ID: <2fd3177890a8c8fba9b40468df213bafa30b5481.camel@hammerspace.com>
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
         <20190503111841.4391-2-trond.myklebust@hammerspace.com>
         <20190503111841.4391-3-trond.myklebust@hammerspace.com>
         <20190503111841.4391-4-trond.myklebust@hammerspace.com>
         <20190503111841.4391-5-trond.myklebust@hammerspace.com>
         <20190503111841.4391-6-trond.myklebust@hammerspace.com>
         <65D12050-BF24-4922-A287-3A4D981BD635@oracle.com>
         <12C94CD2-5E07-4C12-B7F6-78B433327361@oracle.com>
In-Reply-To: <12C94CD2-5E07-4C12-B7F6-78B433327361@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.247.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd6d3064-f17e-4929-4347-08d6e3a3599b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1771;
x-ms-traffictypediagnostic: DM5PR13MB1771:
x-microsoft-antispam-prvs: <DM5PR13MB1771829072D058978C860E6EB81E0@DM5PR13MB1771.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(346002)(39830400003)(366004)(199004)(189003)(53936002)(6512007)(478600001)(118296001)(66946007)(5640700003)(6436002)(66476007)(76116006)(64756008)(66556008)(66446008)(76176011)(229853002)(73956011)(6486002)(6246003)(4326008)(68736007)(14454004)(5660300002)(2906002)(8936002)(81166006)(81156014)(102836004)(446003)(2616005)(11346002)(26005)(486006)(6116002)(2501003)(25786009)(2351001)(3846002)(476003)(99286004)(186003)(7736002)(6506007)(14444005)(256004)(71190400001)(305945005)(66066001)(86362001)(36756003)(71200400001)(6916009)(316002)(53546011)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1771;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wAQheAGPKViMy8cpn89ejg2HfVgTkez3yRxeU9CosWTeHdV6qEgQoUQ9oAwHuPEiqQgjvL9epcZxlbUIZAIyHlJH6YRKbyeHt3oA2RpmRp48SU1Pimeg1c7NbegIZ/5dsfyi1PHQxF2yTlRxLg72770NmoUggE3nfh0Mc2oBsNef/WH15vB7W7YuJYi9FGb7hAQxd88S0BIN9YEaOekysF9Rx68Q75GV3LbfZSpJgzoV1w/Jl4pLqwxth37gshu250xvGYkn2ll1aqUvnPrBqm3szOiD/rCHfhfRwUDty804SOtqQSeoqht27wQCHlkIq3jmdxOoPSebVmX9CnFo23l5lzehj9LBpy70ZCqaMKwEZa/6kKPjkNimFBjelW2xHYoM/ylblIbEiFmETFUAqYMKzxjJ84cVt3LLFRrgfp0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B4CEF7D238C394294F71E6506395E30@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6d3064-f17e-4929-4347-08d6e3a3599b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 19:33:23.9934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1771
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA1LTI4IGF0IDE1OjAzIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
Rm9sbG93aW5nIHVwIG9uIHRoaXMuIE5vdyB3aXRoIGV2ZW4gbW9yZSBkYXRhIQ0KPiANCj4gPiBP
biBNYXkgNiwgMjAxOSwgYXQgNDo0MSBQTSwgQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNs
ZS5jb20+DQo+ID4gd3JvdGU6DQo+ID4gDQo+ID4gDQo+ID4gPiBPbiBNYXkgMywgMjAxOSwgYXQg
NzoxOCBBTSwgVHJvbmQgTXlrbGVidXN0IDx0cm9uZG15QGdtYWlsLmNvbT4NCj4gPiA+IHdyb3Rl
Og0KPiA+ID4gDQo+ID4gPiBBbGxvdyBtb3JlIHRpbWUgZm9yIHNvZnRpcnFkDQo+ID4gDQo+ID4g
SGF2ZSB5b3UgdGhvdWdodCBhYm91dCBwZXJmb3JtYW5jZSB0ZXN0cyBmb3IgdGhpcyBvbmU/DQo+
IA0KPiBJIHRlc3RlZCB0aGlzIHNlcmllcyBvbiBteSAxMi1jb3JlIHR3by1zb2NrZXQgY2xpZW50
IHVzaW5nIGEgdmFyaWV0eQ0KPiBvZiB0ZXN0cyBpbmNsdWRpbmcgaW96b25lLCBmaW8sIGFuZCBm
c3Rlc3RzLiBUaGUgbmV0d29yayB1bmRlciB0ZXN0DQo+IGlzIDU2R2IgSW5maW5pQmFuZCAoVENQ
IHVzZXMgSVBvSUIpLiBJIHRlc3RlZCBib3RoIFRDUCBhbmQgUkRNQS4NCj4gDQo+IFdpdGggbG9j
ayBkZWJ1Z2dpbmcgYW5kIG1lbW9yeSBsZWFrIHRlc3RpbmcgZW5hYmxlZCwgSSBkaWQgbm90IHNl
ZQ0KPiBhbnkgZnVuY3Rpb25hbCByZWdyZXNzaW9ucyBvciBuZXcgbGVha3Mgb3IgY3Jhc2hlcy4g
VGh1cyBJTU8gdGhpcw0KPiBzZXJpZXMgaXMgInNhZmUgdG8gYXBwbHkuIg0KPiANCj4gV2l0aCBU
Q1AsIEkgc2F3IG5vIGNoYW5nZSBpbiBwZXJmb3JtYW5jZSBiZXR3ZWVuIGEgInN0b2NrIiBrZXJu
ZWwNCj4gYW5kIG9uZSB3aXRoIGFsbCBmaXZlIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMgYXBwbGll
ZCwgYXMsIElJUkMsDQo+IHlvdSBwcmVkaWN0ZWQuDQo+IA0KPiBUaGUgZm9sbG93aW5nIGRpc2N1
c3Npb24gaXMgYmFzZWQgb24gdGVzdGluZyB3aXRoIE5GUy9SRE1BLg0KPiANCj4gV2l0aCBSRE1B
LCBJIHNhdyBhbiBpbXByb3ZlbWVudCBvZiA1LTEwJSBpbiBJT1BTIHJhdGUgYmV0d2VlbiB0aGUN
Cj4gInN0b2NrIiBrZXJuZWwgYW5kIGEga2VybmVsIHdpdGggdGhlIGZpcnN0IGZvdXIgcGF0Y2hl
cyBhcHBsaWVkLiBXaGVuDQo+IHRoZSBmaWZ0aCBwYXRjaCBpcyBhcHBsaWVkLCBJIHNhdyBJT1BT
IHRocm91Z2hwdXQgc2lnbmlmaWNhbnRseSB3b3JzZQ0KPiB0aGFuICJzdG9jayIgLS0gbGlrZSAy
MCUgd29yc2UuDQo+IA0KPiBJIGFsc28gc3R1ZGllZCBhdmVyYWdlIFJQQyBleGVjdXRpb24gdGlt
ZSAodGhlICJleGVjdXRlIiBtZXRyaWMpIHdpdGgNCj4gdGhlICJzdG9jayIga2VybmVsLCB0aGUg
b25lIHdpdGggZm91ciBwYXRjaGVzIGFwcGxpZWQsIGFuZCB3aXRoIHRoZQ0KPiBvbmUgd2hlcmUg
YWxsIGZpdmUgYXJlIGFwcGxpZWQuIFRoZSB3b3JrbG9hZCBpcyAxMDAlIDRLQiBSRUFEcyB3aXRo
DQo+IGFuIGlvZGVwdGggb2YgMTAyNCBpbiBvcmRlciB0byBzYXR1cmF0ZSB0aGUgdHJhbnNtaXQg
cXVldWUuDQo+IA0KPiBXaXRoIGZvdXIgcGF0Y2hlcywgdGhlIGV4ZWN1dGUgdGltZSBpcyBhYm91
dCAyLjUgbXNlYyBmYXN0ZXIgKGF2ZXJhZ2UNCj4gZXhlY3V0aW9uIHRpbWUgaXMgYXJvdW5kIDc1
IG1zZWMgZHVlIHRvIHRoZSBsYXJnZSBiYWNrbG9nIHRoaXMgdGVzdA0KPiBnZW5lcmF0ZXMpLiBX
aXRoIGZpdmUgcGF0Y2hlcywgaXQncyBzbG93ZXIgdGhhbiAic3RvY2siIGJ5IDEyIG1zZWMuDQo+
IA0KPiBJIGFsc28gc2F3IGEgMzAgdXNlYyBpbXByb3ZlbWVudCBpbiB0aGUgYXZlcmFnZSBsYXRl
bmN5IG9mDQo+IHhwcnRfY29tcGxldGVfcnFzdCB3aXRoIHRoZSBmb3VyIHBhdGNoIHNlcmllcy4N
Cj4gDQo+IEFzIGZhciBhcyBJIGNhbiB0ZWxsLCB0aGUgYmVuZWZpdCBvZiB0aGlzIHNlcmllcyBj
b21lcyBtb3N0bHkgZnJvbQ0KPiB0aGUgdGhpcmQgcGF0Y2gsIHdoaWNoIGNoYW5nZXMgc3Bpbl9s
b2NrX2JoKCZ4cHJ0LT50cmFuc3BvcnRfbG9jaykgdG8NCj4gc3Bpbl9sb2NrKCZ4cHJ0LT50cmFu
c3BvcnRfbG9jaykuIFdoZW4gdGhlIHhwcnRpb2Qgd29yayBxdWV1ZSBpcw0KPiBsb3dlcmVkIGlu
IHByaW9yaXR5IGluIDUvNSwgdGhhdCBiZW5lZml0IHZhbmlzaGVzLg0KPiANCj4gSSBhbSBzdGls
bCBjb25mdXNlZCBhYm91dCB3aHkgNS81IGlzIG5lZWRlZC4gSSBkaWQgbm90IHNlZSBhbnkgc29m
dA0KPiBsb2NrdXBzIHdpdGhvdXQgdGhpcyBwYXRjaCBhcHBsaWVkIHdoZW4gdXNpbmcgUkRNQS4g
SXMgdGhlIGlzc3VlDQo+IHdpdGggeHBydHNvY2sncyB1c2Ugb2YgeHBydGlvZCBmb3IgaGFuZGxp
bmcgaW5jb21pbmcgVENQIHJlY2VpdmVzPw0KPiANCj4gSSBzdGlsbCBoYXZlIHNvbWUgdGhpbmdz
IEknZCBsaWtlIHRvIGxvb2sgYXQuIE9uZSB0aGluZyBJIGhhdmVuJ3QNCj4geWV0IHRyaWVkIGlz
IGxvb2tpbmcgYXQgbG9ja19zdGF0LCB3aGljaCB3b3VsZCBjb25maXJtIG9yIHJlZnV0ZQ0KPiBt
eSB0aGVvcnkgdGhhdCB0aGlzIGlzIGFsbCBhYm91dCB0aGUgdHJhbnNwb3J0X2xvY2ssIGZvciBp
bnN0YW5jZS4NCj4gDQoNCk9LLiBJIGNhbiBkcm9wIDUvNS4NCg0KVGhlIGlzc3VlIHRoZXJlIHdh
cyBub3QgYWJvdXQgc29mdCBsb2NrdXBzLiBIb3dldmVyIHNpbmNlIHdlIHdlcmUNCnByZXZpb3Vz
bHkgcnVubmluZyBtb3N0IHNvZnQgaXJxcyBhcyBwYXJ0IG9mIHNwaW5fdW5sb2NrX2JoKCksIHRo
ZQ0KcXVlc3Rpb24gd2FzIHdoZXRoZXIgb3Igbm90IHdlIHdvdWxkIHNlZSBtb3JlIG9mIHRoZW0g
bmVlZGluZyB0byBtb3ZlDQp0byBzb2Z0aXJxZC4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgeW91ciBh
bnN3ZXIgdG8gdGhhdCBxdWVzdGlvbiBpcyAnbm8nDQooYXQgbGVhc3QgZm9yIHlvdXIgc3lzdGVt
KS4NCg0KQ2hlZXJzDQogIFRyb25kDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==
