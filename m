Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D3E20CAB6
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jun 2020 23:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgF1VQm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Jun 2020 17:16:42 -0400
Received: from mail-dm6nam10on2122.outbound.protection.outlook.com ([40.107.93.122]:22336
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbgF1VQm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 28 Jun 2020 17:16:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6Uyh7/I8KSb6oI6hoExsavsLhBqUnKkUF7YQVe+2JF1DBJUC2cIepUGdBuFUkAXhQVc2RzQNniKe3/1gzgxbqZfi492TxRVN7LqyTI3/LfrmtFD+XX9ax1BvKMB8+N0T3iB+bZ6iQYVpdZ4ar4rnTM9Pds6Ll6+9XdEH88mtxAJjz9xVn+opRFAjbCuRm/IcW0oUZYFo0Nw4nEF1rWvolWPKqfpsxl29sG/338FPMInjk4uxBmM1SNHxRkt+X+wJStQBwtTxyNkDNLE0wJ8yHTaxCWalnritofYzTVoWvq+4bPU86R2bEDj+VbKFxm5ducQBN6nXG3LfCpXSQaRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncdeshHCUFcTh14jbDigHOyoLUjNBVoj7wbIDTt0IEw=;
 b=KRcZS+MG/wzVWmitGN4FFch5rluZCelJCFr+Wc5RP01goEEKSjMP2n9D1BG9KVWkJPLIuuj9Lg3o4tsxA09M73uSQu6nADmxTKbNjEr+zJAFEAWqc/JJCmLjwC2H6wM0gVBaEQqOzYvyPJaDbNHyNHJmraw7khIuLY6fUafh8gd3P7iAAMd57JM3WmxMLn1Gq2fiuEQT3XqoaFHl/tn9TIvNPbG5IJ9CJRzhmAUON7JppphlTxM9AHW5jIHQWE3YnINAWtnMjmFKf+vc2CR3IvRxfVs6M5cKcqTC9zdnwjrrG/f//UW3k6OLFgZnOiX/cL5DuUsj9QzzQZxgL9sW/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncdeshHCUFcTh14jbDigHOyoLUjNBVoj7wbIDTt0IEw=;
 b=FqwRUtC/0TGae8X6akqCGI9dg5zXPz9AXwYFzMaQaEHPqR60bq7i8JZG47He6W1qx5Jhwet/ueuh8++WgsCAD2orplpFBfKneAvKW4FUMaCsstEB61//gqIhHw/gMkDhrgzojm0FUQ+Vm5D3hlqMLkswJCshe3sUQScUnEq86Ug=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3799.namprd13.prod.outlook.com (2603:10b6:610:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.10; Sun, 28 Jun
 2020 21:16:38 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f%3]) with mapi id 15.20.3153.016; Sun, 28 Jun 2020
 21:16:38 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] SUNRPC dont update timeout value on connection reset
Thread-Topic: [PATCH 1/1] SUNRPC dont update timeout value on connection reset
Thread-Index: AQHWSXIsArYTKArlwEqCv2M1geuCzqjuWhqAgAA10oA=
Date:   Sun, 28 Jun 2020 21:16:38 +0000
Message-ID: <b9c8d38a17d89c231ed1b11f3e730ab4475ce85a.camel@hammerspace.com>
References: <20200623152409.70257-1-olga.kornievskaia@gmail.com>
         <CAN-5tyHuZwA-mrwUu1U+85-=mAFFtPZZJLAXyKyTaq7vqGwAfw@mail.gmail.com>
In-Reply-To: <CAN-5tyHuZwA-mrwUu1U+85-=mAFFtPZZJLAXyKyTaq7vqGwAfw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d4b1ba9-a7e0-4bb4-5822-08d81ba88bd6
x-ms-traffictypediagnostic: CH2PR13MB3799:
x-microsoft-antispam-prvs: <CH2PR13MB3799DA52BC9A42CF6409F5A5B8910@CH2PR13MB3799.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0448A97BF2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iLIPLlO/l0gbMgd9AfsUwuURMQIkUI28Fiocwag9RNNEt2zz1TF4Bm+eHmuN0gWhY3e/zzI88g33UOnaxCCg1C8W/OCGnynvhIf38oNdZHQY8UtZnXC7quJWA+tHg6G8izoiEy3dwJF7QXw5WD3GZbychDSGNV0bZyzy+Qs+QCkdLaD++pSpYkIbp9iSgiEO1dsRNCdWcSgHM7P571bzuTr+NLzskZBlpMfcPpg4Sh/jnAp/XvKs3RB1SbNDh8opXsGHmQ3QS5M9Lj1Ga/GP6ze5AnaC7Iuej+0z6toknRTXE+vPStSit6FtidyLi4IwKXVmP3CZHeqI7hK8SnLPbWT1kq2PaVnSbBoq+gK3Er8yCIslCIsbDzJRjQZUUXga
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(366004)(6486002)(2906002)(66556008)(53546011)(66476007)(86362001)(71200400001)(83380400001)(66446008)(76116006)(64756008)(66946007)(8676002)(36756003)(6512007)(508600001)(8936002)(2616005)(4326008)(110136005)(26005)(186003)(15650500001)(5660300002)(6506007)(192303002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: j8QIdhHMZ33GRuJzgtB15SO7oh3MgYUBqqH39TKcpsWlAZ1K5Pq1XLDvakr/7wEg9g/mK2XSdfzZhZeuV6Q0hbPn7jfT442FlO1C+dnX0KMXpjVumVeSzhfl65bnpTYPk5k0KrvRCn5MdC2R6gyJQIWCFJN5v01s0ZpxSdoEGoxAlKQ0l+H1AJUGvckz2v3mm+LoqZM/rd9o670GbswL2Q/4dk4DmilMmR7Np/hab8s1YI8kxuQ55PPA+jV6p4NiO5cUoFWoWAuA3/Y07MANTx3qYsQvOu5++Da1FCMFBg91hFnq2l1JxR5Svwlpa1ddY4IedE2dhRo8ojs+gGbOCgZi3d+7b2FcdNmvKKwOqIJIIUcsrZXczpAIdbP5S8NlD7jtHm6vrOTgzWo/tm5C3mFvP5nbCtFkWc5ZdYsc+sXdN9MpHs2NYv4yqBhFF5ua1Df7VO2+kvqQumjBraBCo90OBCG2j2RCF2NmvLLQZyA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B39A88FA902F4A4F8E2FF245663D88D7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4b1ba9-a7e0-4bb4-5822-08d81ba88bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2020 21:16:38.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXg2RzaPIM6qPqd23d4qkBrocNobSUS+fBngHhWDLZ6WLKswENY8a7IMct+a/LGk7iNAW9U2GwCeYnN+kH9Abw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3799
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIwLTA2LTI4IGF0IDE0OjAzIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gVHJvbmQvQW5uYSwNCj4gDQo+IEFueSBjb21tZW50cyBvbiB0aGlzIHBhdGNoPw0KPiAN
Cj4gT24gVHVlLCBKdW4gMjMsIDIwMjAgYXQgMTE6MjIgQU0gT2xnYSBLb3JuaWV2c2thaWENCj4g
PG9sZ2Eua29ybmlldnNrYWlhQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gQ3VycmVudCBiZWhhdmlv
dXI6IGV2ZXJ5IHRpbWUgYSB2MyBvcGVyYXRpb24gaXMgcmUtc2VudCB0byB0aGUNCj4gPiBzZXJ2
ZXINCj4gPiB3ZSB1cGRhdGUgKGRvdWJsZSkgdGhlIHRpbWVvdXQuIFRoZXJlIGlzIG5vIGRpc3Rp
bmN0aW9uIGJldHdlZW4NCj4gPiB3aGV0aGVyDQo+ID4gb3Igbm90IHRoZSBwcmV2aW91cyB0aW1l
ciBoYWQgZXhwaXJlZCBiZWZvcmUgdGhlIHJlLXNlbnQgaGFwcGVuZWQuDQo+ID4gDQo+ID4gSGVy
ZSdzIHRoZSBzY2VuYXJpbzoNCj4gPiAxLiBDbGllbnQgc2VuZHMgYSB2MyBvcGVyYXRpb24NCj4g
PiAyLiBTZXJ2ZXIgUlNULXMgdGhlIGNvbm5lY3Rpb24gKHByaW9yIHRvIHRoZSB0aW1lb3V0KSAo
ZWcuLA0KPiA+IGNvbm5lY3Rpb24NCj4gPiBpcyBpbW1lZGlhdGVseSByZXNldCkNCj4gPiAzLiBD
bGllbnQgcmUtc2VuZHMgYSB2MyBvcGVyYXRpb24gYnV0IHRoZSB0aW1lb3V0IGlzIG5vdyAxMjBz
ZWMuDQoNCkFoLi4uIFRoZSBwcm9ibGVtIGhlcmUgaXMgY2xlYXJseSAnMy4nIGluY3JlbWVudGlu
ZyB0aGUgdGltZW91dCB2YWx1ZQ0KYmVmb3JlIHdlJ3ZlIGFjdHVhbGx5IGhpdCBhIG1pbm9yIG9y
IG1ham9yIHRpbWVvdXQuLi4NCg0KU28gSSB0aGluayB3ZSB3YW50IHRvIGxvb2sgY2FyZWZ1bGx5
IGF0IHhwcnRfYWRqdXN0X3RpbWVvdXQoKS4gVGhlDQpmaXJzdCBydWxlIHRoZXJlIHNob3VsZCBi
ZSB0aGF0IGlmIHdlJ3JlIGJlbG93IHRoZSB0aHJlc2hvbGQgZm9yIGENCm1pbm9yIHRpbWVvdXQs
IHdlIGp1c3Qgd2FudCB0byBleGl0IHdpdGhvdXQgY2hhbmdpbmcgYW55dGhpbmcuDQoNClRoZSBz
ZWNvbmQgcnVsZSBpcyB0aGVuIHRoYXQgaWYgd2UncmUgYmVsb3cgdGhlIHRocmVzaG9sZCBmb3Ig
YSBtYWpvcg0KdGltZW91dCwgdGhlbiB3ZSBhZGp1c3QgdGhlIHRpbWVvdXQgdmFsdWUgYnkgZG91
YmxpbmcgaXQgKGlmIHRvLQ0KPnRvX2V4cG9uZW50aWFsKSBvciBhZGRpbmcgdGhlIHZhbHVlIHRv
LT50b19pbmNyZW1lbnQgKGlmICF0by0NCj50b19leHBvbmVudGlhbCkgYW5kIHRoZW4gZXhpdC4N
Cg0KRmluYWxseSwgaWYgdGhpcyBpcyBhIG1ham9yIHRpbWVvdXQsIHdlIHJlc2V0IHJlcS0+cnFf
dGltZW91dCB0byB0by0NCj50b19pbml0dmFsLCByZXNldCByZXEtPnJxX3JldHJpZXMsIGNhbGwg
eHBydF9yZXNldF9tYWpvcnRpbWVvKCksIHJlc2V0DQp0aGUgUlRUIGNvdW50ZXJzIGFuZCByZXR1
cm4gRVRJTUVET1VULg0KDQpOb25lIG9mIHRoaXMgc2hvdWxkIGJlIHNwZWNpZmljIHRvIHlvdXIg
Y29ubmVjdGlvbiByZXNldCBjYXNlLiBUaGlzIGlzDQpob3cgd2Ugd2FudCB0aW1lb3V0cyB0byB3
b3JrIGluIHRoZSBnZW5lcmljIGNhc2UsIHNvIHdlIG5lZWQgdG8gZml4DQp0aGF0Lg0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
