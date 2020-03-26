Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FC5194ACC
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 22:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgCZVmX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Mar 2020 17:42:23 -0400
Received: from mail-eopbgr760103.outbound.protection.outlook.com ([40.107.76.103]:37312
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbgCZVmX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 26 Mar 2020 17:42:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3E7XCip5zdvZLKZ8YJqnlu2HnL1QNIbsELtMlDv0UKD28jlMVipX9UCaitqkEd6yt59ihJysdA5eq/1ZCR+tI2Uoxn8GPnMk2mVut9AWzRSc9q2S0xUxpeDXhnUYIsGZPQlskmaqI2IrHqTDeColstsnjvaB5Op2KZLlFqRhgcgzXqk0DbKuYKH3XbOb2+YnIVHrPpLxj2vwGjmxy2gS9Q0I/LRramFDweBNY+m99EyPDcqY1v5iHTzn9x75pnUKWWDZE1bcFtlIwIfcD0veRnbQVzBB4+VoQ7DzZVLszLN/vS/tTXLWSzRGvpuR0tAmD0e8X4ikK9mWbUkObWc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8EjjlANm83gVkk1pq41I+Eit/G04X67w/Jj8A8D7bQ=;
 b=FnEvvc+H6TL2G4Y4S2G89/LOlatsnRIoeDoRnWI/Y67Ekgj+a89nO5aP8DKZ2DpACjz+dQql7QnoWNQcjBIORvKM+XDhmYeltFPqjrbSzXdgKxk2xLde+5BP11ltXo06Vu3F6I5ZEHugLkeCWKr822yE9rUanRc/Jhp9XF/JGzWtaEkkeBWi3MNom4ZakH1OY4MD65R1BL1ZrNSKcfDw7M/BOA2wGCX9vPXR5ltQ/OWw821aHog4bSPgoUVT3dyE7J1Bn8K6sIir5HuHJkvNR1Wo8bvvCvXtE+QHaSMv21c26CDcnVEgtSdkkVo4x/zIGDDG0vyhjkvzZzLUICoK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8EjjlANm83gVkk1pq41I+Eit/G04X67w/Jj8A8D7bQ=;
 b=DUYFxIzU6ap/afP9FZziHb1sodxUgwp12c8xgZGJLXy/FttX5rT+jb/FiH3BL5FLpvHhWpFXis+fJVT6CAQGknBdjtElutPYcjgLu+n3X1EXKcOmC32ftcunpl9W0b9sF+WNEfHl/oAvJ7csfqlxxmH5JZMZuD8OFUTdlzLJbGU=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3832.namprd13.prod.outlook.com (2603:10b6:610:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.8; Thu, 26 Mar
 2020 21:42:20 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36%7]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 21:42:20 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "kinglongmee@gmail.com" <kinglongmee@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH] SUNRPC/cache: Allow garbage collection of invalid cache
 entries
Thread-Topic: [PATCH] SUNRPC/cache: Allow garbage collection of invalid cache
 entries
Thread-Index: AQHVyvwJPYRIWp4ZtEelpB+N9lu4ZqgOgFIAgAFulwCAAEEOgIBLl4KAgAARZgA=
Date:   Thu, 26 Mar 2020 21:42:19 +0000
Message-ID: <1a0ce8bb1150835f7a25126df2524e8a8fb0e112.camel@hammerspace.com>
References: <20200114165738.922961-1-trond.myklebust@hammerspace.com>
         <20200206163322.GB2244@fieldses.org>
         <8dc1ed17de98e4b59fb9e408692c152456863a20.camel@hammerspace.com>
         <20200207181817.GC17036@fieldses.org> <20200326204001.GA25053@fieldses.org>
In-Reply-To: <20200326204001.GA25053@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15e843bc-6bd3-4cb3-793c-08d7d1ce8fb1
x-ms-traffictypediagnostic: CH2PR13MB3832:
x-microsoft-antispam-prvs: <CH2PR13MB3832895C4B0C123B66333A0DB8CF0@CH2PR13MB3832.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(346002)(396003)(366004)(136003)(6916009)(4326008)(81156014)(91956017)(478600001)(76116006)(81166006)(8936002)(36756003)(2906002)(8676002)(26005)(186003)(6506007)(5660300002)(54906003)(316002)(86362001)(6512007)(6486002)(66946007)(66556008)(64756008)(66446008)(71200400001)(2616005)(66476007)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR13MB3832;H:CH2PR13MB3398.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l78cwHRHSONgw+BY3ckENnO9Pk9WbgpA5gDnDXc1XWsnM0J+3zgHz8WMGUG3xnI1bq/muXRXPUCtULz7gE0Yc3AbnZqdIC4eQI2e/4ymv7PUw0q6aYrn24FU2U7A1HPQT9vIinNMXls+7i3MmsDu9bx8oVBKpiUbtqSihQaeTKpgJ4jGISm44vMCCUsE3yd8mLxdomE0oMbK3JRQU8YfklgknR1HK5lM6U2iU3JUzg/Te3Md8Mwe/EDtm6V3/UUykz2CRcVAwzPMiH/KoCMzOfPDVIWbJfqjVDs+x7PtsO1tkfdR4z+qirLtTHYFkelNxuixSa0/Hd2ncbtiUmVOYdWkdO5r+L2KljdciWHu14oc81b6rz0L54btTOgVTH2RUJ3QRcEYEf0c6g27j0ikywSEBHKfmEljdmEeoYpOrX+y04uZoAczTvinD2n4d6zNb/9FN+axR16KhA227sraDnW9xCNqWmq+wPlMmdipFji0Wrg/Zd4nlHw12MYGuZCAO75yn6uJfhigzycK68c4Ig==
x-ms-exchange-antispam-messagedata: Fg3bjSXx3wzvHHUICjN/yhhSQGjO6BUbhu2ndP248Y/KOQFJTPNI+rmGVJ3Qn6CyeF6UxLX6TBwJn11xGkLCSWGYX8Jtu9wdvC6JAXIrFapKxPGS2pMo0Srb7al82G07HWgvrc1DdSJNlM0J8G+ZPQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <458D4CBABB4DD44495AF48DC3E5054A0@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e843bc-6bd3-4cb3-793c-08d7d1ce8fb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 21:42:19.8156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 53AsQtKgWV7x7sEU+W0K+GySsII7wXq4pvMkKBVS9/r9nF/xl6a+vLk+87AUvyfrud8yHSfHbpGi1JpLVRW0bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3832
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgQnJ1Y2UsDQoNCk9uIFRodSwgMjAyMC0wMy0yNiBhdCAxNjo0MCAtMDQwMCwgYmZpZWxkc0Bm
aWVsZHNlcy5vcmcgd3JvdGU6DQo+IFNvcnJ5LCBqdXN0IGdldHRpbmcgYmFjayB0byB0aGlzOg0K
PiANCj4gT24gRnJpLCBGZWIgMDcsIDIwMjAgYXQgMDE6MTg6MTdQTSAtMDUwMCwgYmZpZWxkc0Bm
aWVsZHNlcy5vcmcgd3JvdGU6DQo+ID4gT24gRnJpLCBGZWIgMDcsIDIwMjAgYXQgMDI6MjU6MjdQ
TSArMDAwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gT24gVGh1LCAyMDIwLTAyLTA2
IGF0IDExOjMzIC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwg
SmFuIDE0LCAyMDIwIGF0IDExOjU3OjM4QU0gLTA1MDAsIFRyb25kIE15a2xlYnVzdA0KPiA+ID4g
PiB3cm90ZToNCj4gPiA+ID4gPiBJZiB0aGUgY2FjaGUgZW50cnkgbmV2ZXIgZ2V0cyBpbml0aWFs
aXNlZCwgd2Ugd2FudCB0aGUNCj4gPiA+ID4gPiBnYXJiYWdlDQo+ID4gPiA+ID4gY29sbGVjdG9y
IHRvIGJlIGFibGUgdG8gZXZpY3QgaXQuIE90aGVyd2lzZSBpZiB0aGUgdXBjYWxsDQo+ID4gPiA+
ID4gZGFlbW9uDQo+ID4gPiA+ID4gZmFpbHMgdG8gaW5pdGlhbGlzZSB0aGUgZW50cnksIHdlIGVu
ZCB1cCBuZXZlciBleHBpcmluZyBpdC4NCj4gPiA+ID4gDQo+ID4gPiA+IENvdWxkIHlvdSB0ZWxs
IHVzIG1vcmUgYWJvdXQgd2hhdCBtb3RpdmF0ZWQgdGhpcz8NCj4gPiA+ID4gDQo+ID4gPiA+IEl0
J3MgY2F1c2luZyBmYWlsdXJlcyBvbiBweW5mcyBzZXJ2ZXItcmVib290IHRlc3RzLiAgSSBoYXZl
bid0DQo+ID4gPiA+IHBpbm5lZA0KPiA+ID4gPiBkb3duIHRoZSBjYXVzZSB5ZXQsIGJ1dCBpdCBs
b29rcyBsaWtlIGl0IGNvdWxkIGJlIGEgcmVncmVzc2lvbg0KPiA+ID4gPiB0byB0aGUNCj4gPiA+
ID4gYmVoYXZpb3IgS2luZ2xvbmcgTWVlIGRlc2NyaWJlcyBpbiBkZXRhaWwgaW4gaGlzIG9yaWdp
bmFsDQo+ID4gPiA+IHBhdGNoLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gQ2FuIHlvdSBwb2lu
dCBtZSB0byB0aGUgdGVzdHMgdGhhdCBhcmUgZmFpbGluZz8NCj4gPiANCj4gPiBJJ20gYmFzaWNh
bGx5IGRvaW5nDQo+ID4gDQo+ID4gCS4vbmZzNC4xL3Rlc3RzZXJ2ZXIucHkgbXlzZXJ2ZXI6L3Bh
dGggcmVib290DQo+ID4gCQkJLS1zZXJ2ZXJoZWxwZXI9ZXhhbXBsZXMvc2VydmVyX2hlbHBlci5z
aA0KPiA+IAkJCS0tc2VydmVyaGVscGVyYXJnPW15c2VydmVyDQo+ID4gDQo+ID4gRm9yIGFsbCBJ
IGtub3cgYXQgdGhpcyBwb2ludCwgdGhlIGNoYW5nZSBjb3VsZCBiZSBleHBvc2luZyBhIHB5bmZz
LQ0KPiA+IHNpZGUNCj4gPiBidWcuDQo+IA0KPiBGcm9tIGEgdHJhY2UsIGl0J3MgY2xlYXIgdGhh
dCB0aGUgc2VydmVyIGlzIGFjdHVhbGx5IGJlY29taW5nDQo+IHVucmVzcG9uc2l2ZSwgc28gaXQn
cyBub3QgYSBweW5mcyBidWcuDQo+IA0KPiA+ID4gVGhlIG1vdGl2YXRpb24gaGVyZSBpcyB0byBh
bGxvdyB0aGUgZ2FyYmFnZSBjb2xsZWN0b3IgdG8gZG8gaXRzDQo+ID4gPiBqb2Igb2YNCj4gPiA+
IGV2aWN0aW5nIGNhY2hlIGVudHJpZXMgYWZ0ZXIgdGhleSBhcmUgc3VwcG9zZWQgdG8gaGF2ZSB0
aW1lZCBvdXQuDQo+ID4gDQo+ID4gVW5kZXJzdG9vZC4gIEkgd2FzIGN1cmlvdXMgd2hldGhlciB0
aGlzIHdhcyBmb3VuZCBieSBjb2RlDQo+ID4gaW5zcGVjdGlvbiBvcg0KPiA+IGJlY2F1c2UgeW91
J2QgcnVuIGFjcm9zcyBhIGNhc2Ugd2hlcmUgdGhlIGxlYWsgd2FzIGNhdXNpbmcgYQ0KPiA+IHBy
YWN0aWNhbA0KPiA+IHByb2JsZW0uDQo+IA0KPiBJJ20gc3RpbGwgY3VyaW91cy4NCj4gDQo+ID4g
PiBUaGUgZmFjdCB0aGF0IHVuaW5pdGlhbGlzZWQgY2FjaGUgZW50cmllcyBhcmUgZ2l2ZW4gYW4g
aW5maW5pdGUNCj4gPiA+IGxpZmV0aW1lLCBhbmQgYXJlIG5ldmVyIGV2aWN0ZWQgaXMgYSBkZSBm
YWN0byBtZW1vcnkgbGVhayBpZiwgZm9yDQo+ID4gPiBpbnN0YW5jZSwgdGhlIG1vdW50ZCBkYWVt
b24gaWdub3JlcyB0aGUgY2FjaGUgcmVxdWVzdCwgb3IgdGhlDQo+ID4gPiBkb3duY2FsbA0KPiA+
ID4gaW4gZXhwa2V5X3BhcnNlKCkgb3Igc3ZjX2V4cG9ydF9wYXJzZSgpIGZhaWxzIHdpdGhvdXQg
YmVpbmcgYWJsZQ0KPiA+ID4gdG8NCj4gPiA+IHVwZGF0ZSB0aGUgcmVxdWVzdC4NCj4gDQo+IElm
IG1vdW50ZCBpZ25vcmVzIGNhY2hlIHJlcXVlc3RzLCBvciBkb3duY2FsbHMgZmFpbCwgdGhlbiB0
aGUNCj4gc2VydmVyJ3MNCj4gYnJva2VuIGFueXdheS4gIFRoZSBzZXJ2ZXIgY2FuJ3QgZG8gYW55
dGhpbmcgd2l0aG91dCBtb3VudGQuDQo+IA0KPiA+ID4gVGhlIHRocmVhZHMgdGhhdCBhcmUgd2Fp
dGluZyBmb3IgdGhlIGNhY2hlIHJlcGxpZXMgYWxyZWFkeSBoYXZlIGENCj4gPiA+IG1lY2hhbmlz
bSBmb3IgZGVhbGluZyB3aXRoIHRpbWVvdXRzICh3aXRoIGNhY2hlX3dhaXRfcmVxKCkgYW5kDQo+
ID4gPiBkZWZlcnJlZCByZXF1ZXN0cyksIHNvIHRoZSBxdWVzdGlvbiBpcyB3aGF0IGlzIHNvIHNw
ZWNpYWwgYWJvdXQNCj4gPiA+IHVuaW5pdGlhbGlzZWQgcmVxdWVzdHMgdGhhdCB3ZSBoYXZlIHRv
IGxlYWsgdGhlbSBpbiBvcmRlciB0bw0KPiA+ID4gYXZvaWQgYQ0KPiA+ID4gcHJvYmxlbSB3aXRo
IHJlYm9vdD8NCj4gDQo+IEknbSBub3Qgc3VyZSBJIGhhdmUgdGhpcyByaWdodCB5ZXQuICBJJ20g
anVzdCBzdGFyaW5nIGF0IHRoZSBjb2RlIGFuZA0KPiBhdA0KPiBLaW5nbG9uZyBNZWUncyBkZXNj
cmlwdGlvbiBvbiBkNmZjODgyMWMyZDIuICBJIHRoaW5rIHRoZSB3YXkgaXQgd29ya3MNCj4gaXMN
Cj4gdGhhdCBhIGNhc2ggZmx1c2ggZnJvbSBtb3VudGQgcmVzdWx0cyBpbiBhbGwgY2FjaGUgZW50
cmllcyAoaW5jbHVkaW5nDQo+IGludmFsaWQgZW50cmllcyB0aGF0IG5mc2QgdGhyZWFkcyBhcmUg
d2FpdGluZyBvbikgYmVpbmcgY29uc2lkZXJlZA0KPiBleHBpcmVkLiAgU28gY2FjaGVfY2hlY2so
KSByZXR1cm5zIGFuIGltbWVkaWF0ZSBFVElNRURPVVQgd2l0aG91dA0KPiB3YWl0aW5nLg0KPiAN
Cj4gTWF5YmUgdGhlIGNhY2hlX2lzX2V4cGlyZWQoKSBsb2dpYyBzaG91bGQgYmUgc29tZXRoaW5n
IG1vcmUgbGlrZToNCj4gDQo+IAlpZiAoaC0+ZXhwaXJ5X3RpbWUgPCBzZWNvbmRzX3NpbmNlX2Jv
b3QoKSkNCj4gCQlyZXR1cm4gdHJ1ZTsNCj4gCWlmICghdGVzdF9iaXQoQ0FDSEVfVkFMSUQsICZo
LT5mbGFncykpDQo+IAkJcmV0dXJuIGZhbHNlOw0KPiAJcmV0dXJuIGgtPmV4cGlyeV90aW1lIDwg
c2Vjb25kc19zaW5jZV9ib290KCk7DQo+IA0KPiBTbyBpbnZhbGlkIGNhY2hlIGVudHJpZXMgKHdo
aWNoIGFyZSB3YWl0aW5nIGZvciBhIHJlcGx5IGZyb20gbW91bnRkKQ0KPiBjYW4NCj4gZXhwaXJl
LCBidXQgdGhleSBjYW4ndCBiZSBmbHVzaGVkLiAgSWYgdGhhdCBtYWtlcyBzZW5zZS4NCj4gDQo+
IEFzIGEgc3RvcGdhcCB3ZSBtYXkgd2FudCB0byByZXZlcnQgb3IgZHJvcCB0aGUgIkFsbG93IGdh
cmJhZ2UNCj4gY29sbGVjdGlvbiIgcGF0Y2gsIGFzIHRoZSAocHJlZXhpc3RpbmcpIG1lbW9yeSBs
ZWFrIHNlZW1zIGxvd2VyDQo+IGltcGFjdA0KPiB0aGFuIHRoZSBzZXJ2ZXIgaGFuZy4NCj4gDQoN
CkkgYmVsaWV2ZSB5b3Ugd2VyZSBwcm9iYWJseSBzZWVpbmcgdGhlIGVmZmVjdCBvZiB0aGUNCmNh
Y2hlX2xpc3RlbmVyc19leGlzdCgpIHRlc3QsIHdoaWNoIGlzIGp1c3Qgd3JvbmcgZm9yIGFsbCBj
YWNoZSB1cGNhbGwNCnVzZXJzIGV4Y2VwdCBpZG1hcHBlciBhbmQgc3ZjYXV0aF9nc3MuIFdlIHNo
b3VsZCBub3QgYmUgY3JlYXRpbmcNCm5lZ2F0aXZlIGNhY2hlIGVudHJpZXMganVzdCBiZWNhdXNl
IHRoZSBycGMubW91bnRkIGRhZW1vbiBoYXBwZW5zIHRvIGJlDQpzbG93IHRvIGNvbm5lY3QgdG8g
dGhlIHVwY2FsbCBwaXBlcyB3aGVuIHN0YXJ0aW5nIHVwLCBvciBiZWNhdXNlIGl0DQpjcmFzaGVz
IGFuZCBmYWlscyB0byByZXN0YXJ0IGNvcnJlY3RseS4NCg0KVGhhdCdzIHdoeSwgd2hlbiBJIHJl
c3VibWl0dGVkIHRoaXMgcGF0Y2gsIEkgaW5jbHVkZWQgDQpodHRwczovL2dpdC5saW51eC1uZnMu
b3JnLz9wPWNlbC9jZWwtMi42LmdpdDthPWNvbW1pdGRpZmY7aD1iODQwMjI4Y2Q2MDk2YmViZTE2
YjNlNGViNWQ5MzU5N2QwZTAyYzZkDQoNCndoaWNoIHR1cm5zIG9mZiB0aGF0IHBhcnRpY3VsYXIg
dGVzdCBmb3IgYWxsIHRoZSB1cGNhbGxzIHRvIHJwYy5tb3VudGQuDQoNCk5vdGUgdGhhdCB0aGUg
cGF0Y2ggc2VyaWVzIEkgc2VudCBpbmNsdWRlcyBhIGJ1bmNoIG9mIGtlcm5lbA0KdHJhY2Vwb2lu
dHMgdGhhdCB3ZSBjYW4gZW5hYmxlIHRvIGhlbHAgZGVidWdnaW5nIGlmIHdlIHNlZSBhbnl0aGlu
Zw0Kc2ltaWxhciBoYXBwZW5pbmcgaW4gdGhlIGZ1dHVyZS4NCg0KQ2hlZXJzDQogIFRyb25kDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
