Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1E514F3A6
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2020 22:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgAaVTH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jan 2020 16:19:07 -0500
Received: from mail-mw2nam10on2106.outbound.protection.outlook.com ([40.107.94.106]:41440
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbgAaVTG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 31 Jan 2020 16:19:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNPSGxEhpMAJ3K/yBs5jBMvMaIsfNGhlEv4MWkVeKInHAvGjXP9DH/fKQJkEQuVgEnlEu3JTWzBxSrV3SNSWRcCHmOJlH622+Dx9juxHwcBzgg+UhivKTFlbX3cG+GEX5e46mlDLEFnyCAbF9UFh2S0LsEVpAkv/ea3Xdau2N8LuGU9ZwJrniSRUBhJdgRTtAmUX/dUxWVAsd7Ls2GM0K4FB1hgVakhTrSEtpUf4R+xRjEkjiCc5Ik7ppFS2eUmoEd8W9JdoxV7N6/h+sIxyHaK2Ukoc4ZEjCmIykBtNdNBYPccapsjz3iTSFbxhS/drwmozUSxRE522rnJQsecGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5epQsUW+d+C3+pCh2g5pK0k0jvxjp2oTmglH+JxGoQ=;
 b=V7/Q4CcZI5+DImRsW8V3sHO2RGN8aXV+3+XyxomFZQ6/J5rDbOQ1iDQuBbyEezOzxsHaho+rVlJ3AyH+BKpHHXdeWseKetWAw74NIbEYm+cCrslYTphlBdzpZgJOyf2dqPr9ezUE7MTwO/ZpthvQsihdBAfJ7cLyC09uIBfiI2OylmPO7hajJqVqwk4YaeZINjgFgR+TDrrLFK5FiW2k8yc/R83BFgWRX4Tbe009tqShrtWe3HtfhJkZCwBKeZkvVOj5MXQCNxrEwtN5IioOPAMPpnlcFk9xqy6Cdq9ZYL3yIFg5oq8THktbJV5YqRKiYB/ssuGUGkV6BcBgeXjPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5epQsUW+d+C3+pCh2g5pK0k0jvxjp2oTmglH+JxGoQ=;
 b=Q48mc1swiSwqAkk/+73Oj6yp1c5LZTgHtaEg0+gLf7YvsQNFcAH28gFwTCOEtJAaw8OrczuE4qRWkGrkNFPFeMnr/Q+/Z5FRK8kdzfGpmZIt1/TWqPBKRYR+/clVKP0Bk1dp2dMCdAmNaEbpt2Yvat6O1mb2DRxEHYE7mwcNrPs=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2172.namprd13.prod.outlook.com (10.174.182.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.9; Fri, 31 Jan 2020 21:19:00 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2686.028; Fri, 31 Jan 2020
 21:19:00 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC2 2/3] SUNRPC: Track current encode position in struct
 xdr_stream
Thread-Topic: [PATCH RFC2 2/3] SUNRPC: Track current encode position in struct
 xdr_stream
Thread-Index: AQHV2Hbh2TOa2xFgPUa9oAIXTDfWTKgFRyqA
Date:   Fri, 31 Jan 2020 21:19:00 +0000
Message-ID: <5ec32538a1d05e2459fadc5ce84ebe9be42f6f27.camel@hammerspace.com>
References: <20200131203727.31409.63652.stgit@bazille.1015granger.net>
         <20200131204152.31409.48018.stgit@bazille.1015granger.net>
In-Reply-To: <20200131204152.31409.48018.stgit@bazille.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f722a182-7fe1-41f8-20a8-08d7a69330c1
x-ms-traffictypediagnostic: DM5PR1301MB2172:
x-microsoft-antispam-prvs: <DM5PR1301MB2172305BF2A441636D65058EB8070@DM5PR1301MB2172.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39830400003)(366004)(396003)(376002)(189003)(199004)(316002)(110136005)(86362001)(8936002)(54906003)(71200400001)(6486002)(8676002)(81156014)(186003)(2616005)(478600001)(6506007)(4326008)(66476007)(81166006)(6512007)(2906002)(91956017)(76116006)(36756003)(66446008)(5660300002)(66556008)(64756008)(66946007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2172;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GUw2Uv/fajvOqK0jAq6RcPwtDJcgw5r78eCzl2Gzp4p7CZ6xFjfdRZz+rjh5yfdw3eYhqm9SJsp1bvmGr4CD8uRTCLjj7YxNXOKXhoz/QWHavJh0f3MhJ/IWG6KuNiNwC9mcXHRmNbM9HviW5x97Skb6x9F34uh09kVoH8VPY/3kwjLz15Gm9Wwr/e1nSx2b4tC2FxWYY9D0sTOyBYh2FMdNZZMF3GuSCgGyHBbA0u56J4as3O1iUui24b38fmVuw8iPh/C9TxaeigdTeGd0Fi52onM+lSwhBV+7zudHveR7QZqDiSmHpD3/vvPFPvsHKBMa3Fp8wivMkCwiox8pOiLsqMs6rP4hyOh3DBo4Qri2pjGkxaKPn4mu/Ma3hOZr9d8Sr8Bvk47adzBemjwMm9/7O2L5/hoi6Mn2YjKkEG3+VFvJu3u7w4NALJAMqrlu
x-ms-exchange-antispam-messagedata: LmO6hyrBU2nKKAc5p1glrZlFZQH2CxJidqlNLZjTi/1E5gin8aodhfvoBKKp1HDfiO6/sro7Dqlg46xtsGYo1SjBJ2QBVb66IugUiu20+5nQqRAXdHWTEJCCp63x7lT6IvoqU/YfjngZA9HgHE5q+A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D28919C6C1872349A59726D718003205@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f722a182-7fe1-41f8-20a8-08d7a69330c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 21:19:00.3321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6xnOOJQyLDOTZ5Nqw+8EUG3dB0df400JlOBW4BQ9WHNJJXIDBJ9CzsOnxrFPgANuWFOaySTzC8oNxiCKqObPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2172
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTMxIGF0IDE1OjQxIC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
TWFpbnRhaW4gYSBieXRlLW9mZnNldCBjdXJzb3IgaW4gc3RydWN0IHhkcl9zdHJlYW0uIFRoaXMg
d2lsbCBiZQ0KPiB1c2VkIGluIGEgc3Vic2VxdWVudCBwYXRjaC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPiAtLS0NCj4gIGZzL25m
c2QvbmZzNHByb2MuYyAgICAgICAgIHwgICAgMSArDQo+ICBpbmNsdWRlL2xpbnV4L3N1bnJwYy94
ZHIuaCB8ICAgIDEgKw0KPiAgbmV0L3N1bnJwYy94ZHIuYyAgICAgICAgICAgfCAgICAyICsrDQo+
ICAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Zz
L25mc2QvbmZzNHByb2MuYyBiL2ZzL25mc2QvbmZzNHByb2MuYw0KPiBpbmRleCA0Nzk4NjY3YWY2
NDcuLjljZDYxMDQ4NWY3ZCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzZC9uZnM0cHJvYy5jDQo+ICsr
KyBiL2ZzL25mc2QvbmZzNHByb2MuYw0KPiBAQCAtMTkwNCw2ICsxOTA0LDcgQEAgc3RhdGljIHZv
aWQgc3ZjeGRyX2luaXRfZW5jb2RlKHN0cnVjdCBzdmNfcnFzdA0KPiAqcnFzdHAsDQo+ICAJeGRy
LT5pb3YgPSBoZWFkOw0KPiAgCXhkci0+cCAgID0gaGVhZC0+aW92X2Jhc2UgKyBoZWFkLT5pb3Zf
bGVuOw0KPiAgCXhkci0+ZW5kID0gaGVhZC0+aW92X2Jhc2UgKyBQQUdFX1NJWkUgLSBycXN0cC0+
cnFfYXV0aF9zbGFjazsNCj4gKwl4ZHItPnBvcyA9IGhlYWQtPmlvdl9sZW47DQo+ICAJLyogVGFp
bCBhbmQgcGFnZV9sZW4gc2hvdWxkIGJlIHplcm8gYXQgdGhpcyBwb2ludDogKi8NCj4gIAlidWYt
PmxlbiA9IGJ1Zi0+aGVhZFswXS5pb3ZfbGVuOw0KPiAgCXhkci0+c2NyYXRjaC5pb3ZfbGVuID0g
MDsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3VucnBjL3hkci5oIGIvaW5jbHVkZS9s
aW51eC9zdW5ycGMveGRyLmgNCj4gaW5kZXggYjQxZjM0OTc3OTk1Li4yY2E0NzliMDcwOGUgMTAw
NjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc3VucnBjL3hkci5oDQo+ICsrKyBiL2luY2x1ZGUv
bGludXgvc3VucnBjL3hkci5oDQo+IEBAIC0yMzIsNiArMjMyLDcgQEAgc3RydWN0IHhkcl9zdHJl
YW0gew0KPiAgCXN0cnVjdCBrdmVjICppb3Y7CS8qIHBvaW50ZXIgdG8gdGhlIGN1cnJlbnQga3Zl
YyAqLw0KPiAgCXN0cnVjdCBrdmVjIHNjcmF0Y2g7CS8qIFNjcmF0Y2ggYnVmZmVyICovDQo+ICAJ
c3RydWN0IHBhZ2UgKipwYWdlX3B0cjsJLyogcG9pbnRlciB0byB0aGUgY3VycmVudCBwYWdlICov
DQo+ICsJdW5zaWduZWQgaW50IHBvczsJLyogY3VycmVudCBlbmNvZGUgcG9zaXRpb24gKi8NCj4g
IAl1bnNpZ25lZCBpbnQgbndvcmRzOwkvKiBSZW1haW5pbmcgZGVjb2RlIGJ1ZmZlciBsZW5ndGgg
Ki8NCg0KSXMgdGhlcmUgYW55IHJlYXNvbiBub3QgdG8gbWFrZSB0aGlzIGFuIGFub255bW91cyB1
bmlvbj8gJ3BvcycgaXMgdXNlZA0Kb25seSB3aGVuIGVuY29kaW5nLCBhbmQgJ253b3JkcycgaXMg
b25seSB3aGVuIGRlY29kaW5nLiBOZXZlciB0aGUgdHdhaW4NCnNoYWxsIG1lZXQuLi4NCg0KPiAg
DQo+ICAJc3RydWN0IHJwY19ycXN0ICpycXN0OwkvKiBGb3IgZGVidWdnaW5nICovDQo+IGRpZmYg
LS1naXQgYS9uZXQvc3VucnBjL3hkci5jIGIvbmV0L3N1bnJwYy94ZHIuYw0KPiBpbmRleCBmMzEw
NGJlOGZmNWQuLmI4Yjc4ODc2YTliZCAxMDA2NDQNCj4gLS0tIGEvbmV0L3N1bnJwYy94ZHIuYw0K
PiArKysgYi9uZXQvc3VucnBjL3hkci5jDQo+IEBAIC01NDIsNiArNTQyLDcgQEAgdm9pZCB4ZHJf
aW5pdF9lbmNvZGUoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwNCj4gc3RydWN0IHhkcl9idWYgKmJ1
ZiwgX19iZTMyICpwLA0KPiAgCQlidWYtPmxlbiArPSBsZW47DQo+ICAJCWlvdi0+aW92X2xlbiAr
PSBsZW47DQo+ICAJfQ0KPiArCXhkci0+cG9zID0gaW92LT5pb3ZfbGVuOw0KPiAgCXhkci0+cnFz
dCA9IHJxc3Q7DQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MX0dQTCh4ZHJfaW5pdF9lbmNvZGUpOw0K
PiBAQCAtNjQ0LDYgKzY0NSw3IEBAIF9fYmUzMiAqIHhkcl9yZXNlcnZlX3NwYWNlKHN0cnVjdCB4
ZHJfc3RyZWFtDQo+ICp4ZHIsIHNpemVfdCBuYnl0ZXMpDQo+ICAJZWxzZQ0KPiAgCQl4ZHItPmJ1
Zi0+cGFnZV9sZW4gKz0gbmJ5dGVzOw0KPiAgCXhkci0+YnVmLT5sZW4gKz0gbmJ5dGVzOw0KPiAr
CXhkci0+cG9zICs9IG5ieXRlczsNCj4gIAlyZXR1cm4gcDsNCj4gIH0NCj4gIEVYUE9SVF9TWU1C
T0xfR1BMKHhkcl9yZXNlcnZlX3NwYWNlKTsNCj4gDQoNCllvdSBzaG91bGQgZml4IHVwIHhkcl9l
bmNvZGVfd3JpdGUoKSBhcyB3ZWxsIGZvciBjb25zaXN0ZW5jeS4NCg0KDQpOb3cgd2l0aCBhbGwg
dGhhdCBzYWlkLCB3aHkgZG8gd2UgbmVlZCBib3RoIHhkci0+cG9zIGFuZCB4ZHItPmJ1Zi0+bGVu
PyANClRoZXkgc2hvdWxkIGFsd2F5cyBob2xkIHRoZSBzYW1lIHZhbHVlLg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
