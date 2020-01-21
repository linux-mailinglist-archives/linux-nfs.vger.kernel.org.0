Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87ADE144802
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2020 00:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAUXHQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jan 2020 18:07:16 -0500
Received: from mail-eopbgr680133.outbound.protection.outlook.com ([40.107.68.133]:14912
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbgAUXHQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 Jan 2020 18:07:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZhRZieOXPVwvSz3uZo/odIGU6F/uCdTNw/vpX+SmTZwIi/xrLSnrgE00G0xSv4FjvcBIPrYNzKPy08AST1s1Fdcnx2jB2If3zq7u/XdqdYxSiK6LKau5xjEr4ZkVuPcoizx4rbX+pqgBMRd/UiqH1MbEF7dj0/hBuJdmQhylmkes4ejeQZeLS+w9qtd48bnmJG5M9hEbeZCPUVZndAzZh0flZi01/hMxYU/jmyMOBEN2TtaKR0t2vIseJcrLXZ3PTQZ2WO0oxndnzkRloYhPvmb4ODht2P+fgsZKCt3Cm6P/Xj5aAkAC7a6aryHR3nFW5o4fYxzEIIkNONxQGQ3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbiZeIfp8qSfR+3cI8w9P3hw2AT/CkglVV0T1iNEu5w=;
 b=a8FbTnabnOuw/duwC5oaND+ISVj6Lw78xzs+pwLMlTVwQxy2lE4DnRezz3NJQz2cgWJvZrZS4g5mp+vFOGJQlmynElFZ/BRvwYM3aPtkGa1Yt0z22V1QW2jOFUpbgIL1WgWkJ+aiwjXqpc95jfYXQvuQ+GoL+BRNl46wSBOrmss7+YVD2ZTBf7Hh8CoBisP3r6S01Bb+rQXtDhayjQur56b+OjtTp2PF56boGvzUY3uAa2h9la8eics5BDAzwgdnnBLImBa+apqtUNBKRcX2AcepW8X73WeVerNCtvkYGPWn3VQhtnj6mZwzbZDlDvOQaccryU0Z4Fxr87feSxRSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbiZeIfp8qSfR+3cI8w9P3hw2AT/CkglVV0T1iNEu5w=;
 b=LJdoiAJufafy3WAgfN2RDvpNX2kDTJrBJqIiXr3zMYif0IozivNqmm0L1py7bD0aewFmmJhSW+XAjRVXCj+rY7pqpBd70FALMjljbFo9N5F/fnIMO/X/+2Jd+iu48B4tsZo2BETtc4kQCAMJth49LNrQ8N4PX2w/NskNreOuROQ=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1882.namprd13.prod.outlook.com (10.174.186.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.15; Tue, 21 Jan 2020 23:07:12 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2665.017; Tue, 21 Jan 2020
 23:07:12 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH RESEND 1/6] nfsd: fix filecache lookup
Thread-Topic: [PATCH RESEND 1/6] nfsd: fix filecache lookup
Thread-Index: AQHVxL34ypFC03UqG06fLcP1tCpT2af1ugAAgAAbiAA=
Date:   Tue, 21 Jan 2020 23:07:12 +0000
Message-ID: <20e074d92f514810b0268ea7b76f82b430ae80cf.camel@hammerspace.com>
References: <20200106181808.562969-1-trond.myklebust@hammerspace.com>
         <20200106181808.562969-2-trond.myklebust@hammerspace.com>
         <20200121212838.GC26055@fieldses.org>
In-Reply-To: <20200121212838.GC26055@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [66.201.48.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51eee669-0055-49af-29a2-08d79ec6a633
x-ms-traffictypediagnostic: DM5PR1301MB1882:
x-microsoft-antispam-prvs: <DM5PR1301MB18826C18A5646BFB4A475720B80D0@DM5PR1301MB1882.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39830400003)(366004)(396003)(136003)(199004)(189003)(6486002)(2906002)(4326008)(71200400001)(6506007)(6512007)(6916009)(36756003)(91956017)(478600001)(4744005)(76116006)(66446008)(5660300002)(66946007)(64756008)(66476007)(66556008)(54906003)(86362001)(2616005)(8676002)(8936002)(81166006)(316002)(186003)(26005)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1882;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S7bPGNqBAjwWmv9WodD2oS4FlQUP2/J9nXTxA8FUfOF+xUKCsJ+HeWQoOKYi3TXZg9nSV0becxiGmWXnyTJTtdpXkV49KKtCiwfS5ocJSKhbuDGirVAnHDe7Rtr0KPgU2ZjfP0foHNJXR20+x3cHZkk/fNKDvjv/zQ0L5wGaGYq/0HntBg7puKR94eQpTsEFvBNHl8k8laL4Pwq3FAEDQBYGjFdG5IiPMM1ghbhNtP6FQRrAAnrT0ZGOnAFvht08UG2zCKLO/cPGr2UykCqboi3E3o9Cizyvt+NroYjTTnTNV8P/7k10+/a03t+Jqb4Ihln8mK6fm7yJ7DzA5Ly+Xd3U/xpYUDQ9kR2atlogTP7SDxoWopDlCfy/lEIns+WVyJtXjIvGSpf6UxgycXorkUcPy6dGNf+cV5Nzpyz+Tej84rh3qTmI0IHeJYxSFfy2
x-ms-exchange-antispam-messagedata: cRD71iobAT3nZmFhyUX6tLjsLfwoBDoaXH2fEjvxXDPvhfpkt131f5+HHdbn+2fTNyTLl70BXVbsb0ieibGI9UL6Lfi2zmYWSjZO5BGrnOR6uiTjqZ8XBPtwYmj17bjtrODqigqt2dVFSuQmshBcmQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3313169C477264E93C7349B5C97979D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51eee669-0055-49af-29a2-08d79ec6a633
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 23:07:12.3829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIa946jF/HMTRVGt2oWafIDXHEzadcRc8XA/1pHa/yortmcfq5O2+vO0fAT2XAbjRyl+u6KY0oOHIY6DglnUAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1882
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTAxLTIxIGF0IDE2OjI4IC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIE1vbiwgSmFuIDA2LCAyMDIwIGF0IDAxOjE4OjAzUE0gLTA1MDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiBJZiB0aGUgbG9va3VwIGtlZXBzIGZpbmRpbmcgYSBuZnNkX2ZpbGUg
d2l0aCBhbiB1bmhhc2hlZCBvcGVuIGZpbGUsDQo+ID4gdGhlbiByZXRyeSBvbmNlIG9ubHkuDQo+
IA0KPiBTbywgc3ltcHRvbXMgYXJlIGEgaGFuZz8NCj4gDQo+IFNob3VsZCB0aGlzIGJlIGNjOiBz
dGFibGUsIEZpeGVzOiA2NTI5NGMxZjJjNWUgKCJuZnNkOiBhZGQgYSBuZXcNCj4gc3RydWN0DQo+
IGZpbGUgY2FjaGluZyBmYWNpbGl0eSB0byBuZnNkIikgPw0KDQpJIHdvdWxkIHJlY29tbWVuZCB0
aGF0IHdlIG1ha2UgaXQgYSBzdGFibGUgZml4LCB5ZXMuIFdlJ3ZlIGhpdCBpdA0KaW50ZXJuYWxs
eSwgYW5kIEkgYmVsaWV2ZSBDaHVjayB3YXMgaGl0dGluZyBpdCBhcyB3ZWxsLg0KDQoNCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
