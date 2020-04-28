Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D0A1BC6E7
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2020 19:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgD1Rlc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Apr 2020 13:41:32 -0400
Received: from mail-dm6nam12on2096.outbound.protection.outlook.com ([40.107.243.96]:45185
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728333AbgD1Rlc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 Apr 2020 13:41:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG6v5/5tyQoiZLmeF7ddDpcYcqDrnUWRnj3Pf//y+dcnMRxM8v6/dJCFE1SXQ5fQgeNNMf0Gcu1O3bIltBkWS7b3GdToTm0FhnS56+INEfd1tJBBHyoTjaXEW2r8Ntv2UIi6q0yxlhQuVNEcbf5aWOjLIlBWzBVrna5djpnSQYMrKgiuvn3TmMz/r9cXBLs36DCaWbbTE+qbh2n9F3ubxcrJcQXeTxFZYW1Tqu/3g04jiRYItL9SfEw8fus2AVnupMS6x20TwMlko96MIiWR0Drs80AQ9qdagEVsBA68RrOrVqjzMbKYo/6KJ8EYJRgF1y12l3LgsscS8F6sOJTd/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2HS8iRqf0NE8du44H47W8z9rpTnaW9ju9lVBUpawxw=;
 b=Q0Ku1mJZtx9D0N2X/goho8EE60/f63Hso9odfkvUwYSkGFin8ulCmcgU30VBTyYqoXcpbot1iZ5vxL5GaAGJO63g+PEozdyOiR+YNZWl9alA82nMoPB7rkM3KXYqNVElfL0ZL+UTRuMFTUILDiPnB2oeTpCP48vejbcF14m+nIPKvNyn9XvNnEp1hO4aB1KgfWmB1uECe8RZEKL/youPaXwApYn+4h8pgouoYSbstX0QB34cuHWMPzzj5Ou19E3XuQ1yFtd0IhU/EHCWPXQ/tvXqGR2NtB1SjpPZvPOQuVDydWwNt0E9pusWSrdOmNvYUDvAicMfDvGAsUIR+qxZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2HS8iRqf0NE8du44H47W8z9rpTnaW9ju9lVBUpawxw=;
 b=e6USUfrYaukpnHniLEcDxbS7vV1zs9nZBZAG3razzW7QC17YwUvI6vqvL2+9dbumNG9NRSBP6pYtNmeWMXEqKa4bExFp4lZQfWitr99AjS7/DeaaYCvXMq/11jG9cw3S1IULkKl8dhRjaC/Ls/1R8VMoJG6UMcNP49mHY3dNvs0=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3464.namprd13.prod.outlook.com (2603:10b6:610:2f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.14; Tue, 28 Apr
 2020 17:41:27 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2958.014; Tue, 28 Apr 2020
 17:41:27 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] NFSv4: Use GFP_ATOMIC under spin lock in
 _pnfs_grab_empty_layout()
Thread-Topic: [PATCH -next] NFSv4: Use GFP_ATOMIC under spin lock in
 _pnfs_grab_empty_layout()
Thread-Index: AQHWHS05VL6mSwc/D0e0O30+XKm+g6iOzh+A
Date:   Tue, 28 Apr 2020 17:41:26 +0000
Message-ID: <db4bae1f410091808dafa36f446f14f9679aead9.camel@hammerspace.com>
References: <20200428071932.69976-1-weiyongjun1@huawei.com>
In-Reply-To: <20200428071932.69976-1-weiyongjun1@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 783e992c-c328-4986-665f-08d7eb9b60bb
x-ms-traffictypediagnostic: CH2PR13MB3464:
x-microsoft-antispam-prvs: <CH2PR13MB34649410695E584FD1DA2650B8AC0@CH2PR13MB3464.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0387D64A71
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2fGtZFjdsJa94SYzRjIirHdCKVzaZb7RoUYouA4IT5OZIsfb+pw3pcqNvRYaOQOT5R244EFIa++Hio1M5BxBOfEw2LEfEuTUybDjkzbTebswQ++2EPhD5l/TNjbelnO+sa05M+zlwK25USDm7wQQxvNfF3FQr7JPL3o/AaPoIHHDqLxuswp47BB2lTrJr0O++oXf7NoS7eenBZOqvMf7W1mO713QTnUOhcAsXE49ZIueY+nxoG4ufw6Suc5cZ3Fz1/N2ENFzKtftOBAgCFbXkQadmEz2ctNfja2f2y4WbnXujGNMUL3ox+hMsDRMbA2/sYQHzUhU8fSam3k0JU2kgSgGv36rtn3IoxsSZLOr6M7kX6jBZk6NePFRIgrblomuoKxg2H8NllSp2KsEdsRpw/Wpas01iVZ2QMJA00viXwvgVWDfNYDnTujEzYVvtYpG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(136003)(376002)(346002)(396003)(366004)(66556008)(76116006)(478600001)(5660300002)(66946007)(6486002)(91956017)(66476007)(4744005)(186003)(6506007)(26005)(2906002)(2616005)(66446008)(6512007)(64756008)(4326008)(316002)(36756003)(8936002)(86362001)(110136005)(54906003)(71200400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SLBxYv52ay+PH1EiDZ3aqmaqLc0J7slSP7uHoaHpCDK40uJ7ppiXpo52fRNkQ+X8oRSszrd9KKEDyDAomrqzLwLKYVXeaPiY+zRMmGCmIfIB3ZT8whjDeypG4o69c4DR7Gv1TwaPQjm0GcGwi2FukRbebDfWvKvkonstQWPZy+AYE8IBakqxHg48MKNG9+UHHPon2BqJzaJH1Nz3Fj/LqvRbujjjEgbDLcG8NIJVqDOrGDHH3wKIGLxXVmACP21xCBnHsn0HwfDOju8CYJx4yshjY/GFAoa3gyMFpymlxpNIjzhoq+PG+ezlRZ5u3K2UyUwQURg33uV3KGzBoayyH9b5EiRozVWulmgyCrNmItYFJTescjPlT5jcogDSc5AB1/pWwGP1WfXveSgo84BZYivigxcObLXwXkE/r55MBbTgQ9gUgVTMiFQ3yqhmRQ6Knd0V4YXFGnDPgLX3+x7uGZV7viqVGo4dosRnFl055I4OaRhcrPixlhDyMoAv3Zv3GKDpGwLq8ZZm6rDhnIfNTzzLIw1OqrI4mXevieYLi+afPdG6WxemqeftvaAqKs4dvCM7W/7/Rok5AsA8pgO9zi5TJpattxbiDFFFrQ743QSjUw78sMu0qf+eez1m9nFji7mu6xB0/60WPUPnelTHCBNjyNxmZOlK+NMcmwn7fBN6EOxAH4yyoMjZDvaITyfqr/tO8fFnMOJo7Jv6zmWdghp3t/OPLYpHYDtWv0MF46r16IhcfQZS+IAlhWIrn3Ru5LcAaSznRhFaOdTeWjBje3FW84eUnBwLwFi9x18Wdl8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDDFBE54747E974AB5E46DD63D4096F2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783e992c-c328-4986-665f-08d7eb9b60bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 17:41:26.8908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CexGW8yhq6g2MOeqBCGBoEoouy6/gBKBl8iw39TIMhUy5YP3bvIy3YawvKg4IVVeCFLHguGTHUXZN+B7x4RBkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3464
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTI4IGF0IDA3OjE5ICswMDAwLCBXZWkgWW9uZ2p1biB3cm90ZToNCj4g
QSBzcGluIGxvY2sgaXMgdGFrZW4gaGVyZSBzbyB3ZSBzaG91bGQgdXNlIEdGUF9BVE9NSUMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBXZWkgWW9uZ2p1biA8d2VpeW9uZ2p1bjFAaHVhd2VpLmNvbT4N
Cj4gLS0tDQo+ICBmcy9uZnMvcG5mcy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL3BuZnMu
YyBiL2ZzL25mcy9wbmZzLmMNCj4gaW5kZXggZGQyZTE0ZjU4NzVkLi5kODRjMWI3YjcxZDIgMTAw
NjQ0DQo+IC0tLSBhL2ZzL25mcy9wbmZzLmMNCj4gKysrIGIvZnMvbmZzL3BuZnMuYw0KPiBAQCAt
MjE3MCw3ICsyMTcwLDcgQEAgX3BuZnNfZ3JhYl9lbXB0eV9sYXlvdXQoc3RydWN0IGlub2RlICpp
bm8sDQo+IHN0cnVjdCBuZnNfb3Blbl9jb250ZXh0ICpjdHgpDQo+ICAJc3RydWN0IHBuZnNfbGF5
b3V0X2hkciAqbG87DQo+ICANCj4gIAlzcGluX2xvY2soJmluby0+aV9sb2NrKTsNCj4gLQlsbyA9
IHBuZnNfZmluZF9hbGxvY19sYXlvdXQoaW5vLCBjdHgsIEdGUF9LRVJORUwpOw0KPiArCWxvID0g
cG5mc19maW5kX2FsbG9jX2xheW91dChpbm8sIGN0eCwgR0ZQX0FUT01JQyk7DQo+ICAJaWYgKCFs
bykNCj4gIAkJZ290byBvdXRfdW5sb2NrOw0KPiAgCWlmICghdGVzdF9iaXQoTkZTX0xBWU9VVF9J
TlZBTElEX1NUSUQsICZsby0+cGxoX2ZsYWdzKSkNCj4gDQo+IA0KPiANCg0KTkFDSy4gVGhlcmUg
aXMgbm8gYWxsb2NhdGlvbiB1bmRlciB0aGUgc3BpbmxvY2suDQoNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
