Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282A01CDB8E
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2020 15:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgEKNnf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 May 2020 09:43:35 -0400
Received: from mail-dm6nam12on2119.outbound.protection.outlook.com ([40.107.243.119]:19905
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729279AbgEKNne (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 11 May 2020 09:43:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpepM42wP6mnoSwP6OKjq6O8FPBsqnDWtEx3pE+CmKzauckeLBbaSvH0NkaI5gyzFPu5VFGs6TLZO29BIhYHcgt/nOiEkh9jm2vvvpArLd4VGyN4kmBmaZxStckOx4t7S43N3oH5dhJxb4WYmiR06s1Y85FhyJ/3oWutRENcgl1qPExdv0CU8/soJg8NUr3VzNzhH7wcDpI8XdApKT1V25zUAD0AKQJ09imhbNZisotV5ad4SqWA0amZqKXxCJ3fZSLEieFcXkx49/b+jr/1c9sUETmirTQzRA5Ov2P07JwiG5ynplJWigyK7lhA+Xy4vFd/TTWmtIISmKtGg3Mwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSbSV0WByo55vhJ0zXWLIXp2BHliKRtI1aXDjv/4P04=;
 b=bnUkvXRH1G2SBlk61uRH+pmC5AXDSS4ZhG3p7f/YLfQfsFfCYYl+Dy0LmMIbBRaSFhtvQeKkqqyp/Vb3Mzwe7XAbAx4Spv6yTp8+OIuasdUNVnTxiwJgtyPgKj2+LALiYycp2/Foxat3gF+eqOZLDlmRcNhzGiUjthDGpnR9ToSRHDAZinYQs1jmzFXB7UEuWZbkdTlFIsUYQz0puhsJyIaR/zm5llF6zxggE8G6QE/NAjQb0deACShH+fdqTQSP/w/+3Ba2vbwSAQOlYgFgst3uF1COdO2vO5Hr/DIVm0tLThatnEdqvXQdlxuLPNHygppPuiUtMQBxZrso5/yz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSbSV0WByo55vhJ0zXWLIXp2BHliKRtI1aXDjv/4P04=;
 b=WSNkWiBK2YrtEp7/wPjt9//TjYdLuglgzELpl/J6dXvu/5yrmG5wAvx9xkLVGRkPHDSDrjnOLrHJlWczsSfP9YTIJRcjtZyMtrIz6GE6MSDwTtwjCgbLRkcuTu/A1jovzi9gD5GXOre9hviUeKDvk5I61w7+rozw08n8gx0Uf9Y=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3542.namprd13.prod.outlook.com (2603:10b6:610:2d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.13; Mon, 11 May
 2020 13:43:31 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.3000.016; Mon, 11 May 2020
 13:43:30 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>
CC:     "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: fix NULL deference in nfs4_get_valid_delegation
Thread-Topic: [PATCH] nfs: fix NULL deference in nfs4_get_valid_delegation
Thread-Index: AQHWJYbDNgK8V2iNQEu3XsLCRGdi86iiz2IAgAASXYCAAAeBgA==
Date:   Mon, 11 May 2020 13:43:30 +0000
Message-ID: <8f9f84f11df6f5caf054d1eada2d91ea158a6882.camel@hammerspace.com>
References: <20200508221935.GA11225@fieldses.org>
         <20200511121054.l2j34vnwqxhvd2ao@gabell>
         <20200511131637.GA8629@fieldses.org>
In-Reply-To: <20200511131637.GA8629@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3b95a43-2958-45a5-8007-08d7f5b14adc
x-ms-traffictypediagnostic: CH2PR13MB3542:
x-microsoft-antispam-prvs: <CH2PR13MB35423A793E8FA2B02551A8CFB8A10@CH2PR13MB3542.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J7XJNM/4KwvDfugQTZDbB2eiTQtuVPvUTBZtr+ELMPud3e3GX5xBKxN1BtOBGEFLaH7gi6EpNBjqCuyvkpopzyHgjp1x/SQ3s9aXYgXtRgMcLIdEzaQ46UBjXcFNQgcInxGYbwZBxeElecRKM67iYusFJ5XIhykIOXUEUsse6JSLCXyroHPljGIL3fvX0X5PGUeUZZDAEfAWf8mifjuRZsNu93F8a16ttcDFkvGa+HmbrF6dX3KspN6C1aoxju99vdWfUN747adzFBMFWneE4pEHybOHrodvO7/ZisvypjleDJJawyXXrmZSt8LHAro2+G9zJ8VWSddUFUS7rQybKA42IOX4rgOrdTG93WCtfHITNN5zDhioSVhV6B/YxwgVN+GKMb1ju7zMDFO6k+iiNQ51VphFZmb2gh5gT5LcclbpOoHE8Y24pFmdmRCuC3owR5EJx07HW69lauesRF6bQRdi8/B1lttLJ5Dc3oma1vpcmdHJmcmxAkQV8+lButPlATUhT2m9vZNIx5cZiUXLxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(39830400003)(366004)(346002)(376002)(33430700001)(64756008)(316002)(66446008)(54906003)(110136005)(86362001)(478600001)(66476007)(71200400001)(66556008)(6486002)(4326008)(66946007)(91956017)(76116006)(2616005)(5660300002)(186003)(2906002)(33440700001)(6506007)(36756003)(8936002)(8676002)(26005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qNbldjiTgE/JRehybBgGlhJChYV5ta5C9jtvKsMumuCqgW/fjkc7WJsKZH/RrfurupEao5qWN8SqWQaYGzU63FQHj9fRZMsmqAIWlCf2ku3G2nweC1zkRunr3tdrExzmQH4ORn3krHc/vBuV4LmCASxd1jom+snEVj/5kv8NV3PEZ9sGRkHtFjkLhvYiQIY6COTEkA4179tVH4FbOHIwCsfiba2BzbALsrRjdbUcaaeqiBD4FVV5LI0W1RGSx1MaMOxtgqI6HHlAjwsDXHl57RGuF+P/QovVSSp8zBZv5xuDEoIx7KgL/WHbNjb/XTNCzUytjzuNMJh9jzZ363CorKj6wayUTXp8QTpYZtjo+fTUX/AKJ3pZwKyqsPLjbg1ek+ppFx56SA2ZhRAirmscPm8/X8cTqBMypu9Jyyq/NlpfxOUJDIjHMwbq5MErrjZmaN7Hk1x32mq4LN3i47opjs4YUSiLxPv3WoRw/7JEf5o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <88E33A56F2B71B47873F77E01A693EAC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b95a43-2958-45a5-8007-08d7f5b14adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 13:43:30.8866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVBns9pmtlB6RQUx1Fh9SwpSXfAbdAb+X2qmowAmd5XbGt57z+noGRspzOgNvc5JN5YyVfEUU1G/5o32PiJSSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3542
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTA1LTExIGF0IDA5OjE2IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IFRoYW5rcywgYXBwbHlpbmcuLS1iLg0KPiANCg0KWW91J3JlIGFwcGx5aW5nPyBTbyBzaG91
bGQgSSByZW1vdmUgaXQgZnJvbSB0aGUgTkZTIGNsaWVudCBidWdmaXhlcz8NCg0KPiBPbiBNb24s
IE1heSAxMSwgMjAyMCBhdCAwODoxMDo1NEFNIC0wNDAwLCBNYXNheW9zaGkgTWl6dW1hIHdyb3Rl
Og0KPiA+IE9uIEZyaSwgTWF5IDA4LCAyMDIwIGF0IDA2OjE5OjM1UE0gLTA0MDAsIEouIEJydWNl
IEZpZWxkcyB3cm90ZToNCj4gPiA+IEZyb206ICJKLiBCcnVjZSBGaWVsZHMiIDxiZmllbGRzQHJl
ZGhhdC5jb20+DQo+ID4gPiANCj4gPiA+IFdlIGFkZCB0aGUgbmV3IHN0YXRlIHRvIHRoZSBuZnNp
LT5vcGVuX3N0YXRlcyBsaXN0LCBtYWtpbmcgaXQNCj4gPiA+IHBvdGVudGlhbGx5IHZpc2libGUg
dG8gb3RoZXIgdGhyZWFkcywgYmVmb3JlIHdlJ3ZlIGZpbmlzaGVkDQo+ID4gPiBpbml0aWFsaXpp
bmcNCj4gPiA+IGl0Lg0KPiA+ID4gDQo+ID4gPiBUaGF0IHdhc24ndCBhIHByb2JsZW0gd2hlbiBh
bGwgdGhlIHJlYWRlcnMgd2VyZSBhbHNvIHRha2luZyB0aGUNCj4gPiA+IGlfbG9jaw0KPiA+ID4g
KGFzIHdlIGRvIGhlcmUpLCBidXQgc2luY2Ugd2Ugc3dpdGNoZWQgdG8gUkNVLCB0aGVyZSdzIG5v
dyBhDQo+ID4gPiBwb3NzaWJpbGl0eQ0KPiA+ID4gdGhhdCBhIHJlYWRlciBjb3VsZCBzZWUgdGhl
IHBhcnRpYWxseSBpbml0aWFsaXplZCBzdGF0ZS4NCj4gPiA+IA0KPiA+ID4gU3ltcHRvbXMgb2Jz
ZXJ2ZWQgd2VyZSBhIGNyYXNoIHdoZW4gYW5vdGhlciB0aHJlYWQgY2FsbGVkDQo+ID4gPiBuZnM0
X2dldF92YWxpZF9kZWxlZ2F0aW9uKCkgb24gYSBOVUxMIGlub2RlLg0KPiA+ID4gDQo+ID4gPiBG
aXhlczogOWFlMDc1ZmRkMTkwICJORlN2NDogQ29udmVydCBvcGVuIHN0YXRlIGxvb2t1cCB0byB1
c2UgUkNVIg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSi4gQnJ1Y2UgRmllbGRzIDxiZmllbGRzQHJl
ZGhhdC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBmcy9uZnMvbmZzNHN0YXRlLmMgfCAyICstDQo+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4g
PiANCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNHN0YXRlLmMgYi9mcy9uZnMvbmZzNHN0
YXRlLmMNCj4gPiA+IGluZGV4IGFjOTM3MTVjMDVhNC4uYThkYzI1Y2U0OGJiIDEwMDY0NA0KPiA+
ID4gLS0tIGEvZnMvbmZzL25mczRzdGF0ZS5jDQo+ID4gPiArKysgYi9mcy9uZnMvbmZzNHN0YXRl
LmMNCj4gPiA+IEBAIC03MzQsOSArNzM0LDkgQEAgbmZzNF9nZXRfb3Blbl9zdGF0ZShzdHJ1Y3Qg
aW5vZGUgKmlub2RlLA0KPiA+ID4gc3RydWN0IG5mczRfc3RhdGVfb3duZXIgKm93bmVyKQ0KPiA+
ID4gIAkJc3RhdGUgPSBuZXc7DQo+ID4gPiAgCQlzdGF0ZS0+b3duZXIgPSBvd25lcjsNCj4gPiA+
ICAJCWF0b21pY19pbmMoJm93bmVyLT5zb19jb3VudCk7DQo+ID4gPiAtCQlsaXN0X2FkZF9yY3Uo
JnN0YXRlLT5pbm9kZV9zdGF0ZXMsICZuZnNpLT5vcGVuX3N0YXRlcyk7DQo+ID4gPiAgCQlpaG9s
ZChpbm9kZSk7DQo+ID4gPiAgCQlzdGF0ZS0+aW5vZGUgPSBpbm9kZTsNCj4gPiA+ICsJCWxpc3Rf
YWRkX3JjdSgmc3RhdGUtPmlub2RlX3N0YXRlcywgJm5mc2ktPm9wZW5fc3RhdGVzKTsNCj4gPiA+
ICAJCXNwaW5fdW5sb2NrKCZpbm9kZS0+aV9sb2NrKTsNCj4gPiA+ICAJCS8qIE5vdGU6IFRoZSBy
ZWNsYWltIGNvZGUgZGljdGF0ZXMgdGhhdCB3ZSBhZGQNCj4gPiA+IHN0YXRlbGVzcw0KPiA+ID4g
IAkJICogYW5kIHJlYWQtb25seSBzdGF0ZWlkcyB0byB0aGUgZW5kIG9mIHRoZSBsaXN0ICovDQo+
ID4gPiAtLSANCj4gPiANCj4gPiBUaGFuayB5b3UgZm9yIHBvc3RpbmcgdGhlIHBhdGNoISBJdCB3
b3JrcyBmb3Igb3VyIGJveC4NCj4gPiBQbGVhc2UgZmVlbCBmcmVlIHRvIGFkZDoNCj4gPiANCj4g
PiAgICAgICAgIFJldmlld2VkLWJ5OiBTZWlpY2hpIElrYXJhc2hpIDxzLmlrYXJhc2hpQGZ1aml0
c3UuY29tPg0KPiA+ICAgICAgICAgVGVzdGVkLWJ5OiBEYWlzdWtlIE1hdHN1ZGEgPG1hdHN1ZGEt
ZGFpc3VrZUBmdWppdHN1LmNvbT4NCj4gPiAgICAgICAgIFRlc3RlZC1ieTogTWFzYXlvc2hpIE1p
enVtYSA8bS5taXp1bWFAanAuZnVqaXRzdS5jb20+DQo+ID4gDQo+ID4gV2l0aG91dCB0aGUgcGF0
Y2gsIHRoZSBzeXN0ZW0gd2hpY2ggaXMgYSBORlN2NCBjbGllbnQgaGFzIGJlZW4NCj4gPiBjcmFz
aGVkIHJhbmRvbWx5LiBUaGUgcGFuaWMgbG9nIGlzIHN1Y2ggYXM6DQo+ID4gDQo+ID4gICAgQlVH
OiB1bmFibGUgdG8gaGFuZGxlIHBhZ2UgZmF1bHQgZm9yIGFkZHJlc3M6IGZmZmZmZmZmZmZmZmZm
YjANCj4gPiAgICAuLi4NCj4gPiAgICBSSVA6IDAwMTA6bmZzNF9nZXRfdmFsaWRfZGVsZWdhdGlv
bisweDYvMHgzMCBbbmZzdjRdDQo+ID4gICAgLi4uDQo+ID4gICAgQ2FsbCBUcmFjZToNCj4gPiAg
ICAgbmZzNF9vcGVuX3ByZXBhcmUrMHg4MC8weDFjMCBbbmZzdjRdDQo+ID4gICAgIF9fcnBjX2V4
ZWN1dGUrMHg3NS8weDM5MCBbc3VucnBjXQ0KPiA+ICAgICA/IGZpbmlzaF90YXNrX3N3aXRjaCsw
eDc1LzB4MjYwDQo+ID4gICAgIHJwY19hc3luY19zY2hlZHVsZSsweDI5LzB4NDAgW3N1bnJwY10N
Cj4gPiAgICAgcHJvY2Vzc19vbmVfd29yaysweDFhZC8weDM3MA0KPiA+ICAgICB3b3JrZXJfdGhy
ZWFkKzB4MzAvMHgzOTANCj4gPiAgICAgPyBjcmVhdGVfd29ya2VyKzB4MWEwLzB4MWEwDQo+ID4g
ICAgIGt0aHJlYWQrMHgxMGMvMHgxMzANCj4gPiAgICAgPyBrdGhyZWFkX3BhcmsrMHg4MC8weDgw
DQo+ID4gICAgIHJldF9mcm9tX2ZvcmsrMHgyMi8weDMwDQo+ID4gDQo+ID4gQWZ0ZXIgYXBwbGll
ZCB0aGUgcGF0Y2gsIHRoZSBwYW5pYyBpcyBnb25lLg0KPiA+IA0KPiA+IFRoYW5rcyENCj4gPiBN
YXNhDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
