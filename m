Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB501286A4E
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 23:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgJGVeV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 17:34:21 -0400
Received: from mail-bn7nam10on2103.outbound.protection.outlook.com ([40.107.92.103]:25345
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbgJGVeU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Oct 2020 17:34:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbX2ArdIFdEJsRJUOunyt78GdPUpIyr59eZD88C+okzlH6MBtcc++PhK1ftO3ypr+LBHES/42kNc4ZS3Ss3iUyRGlRv+MDByl9Sdlki9KwpoE9d8eOKnJDNia2v5rE4FLjpiErUuQhaR/3T7Z0Agq6b9bG3Aau8A2vBg7j8z4g8wrxk5d1grm7CmAC6SQUS4K7XP/ZAE4v8TSoy0QadYsP2rk9YtJd93lOgwjoyRCnNve0zqEgNA6UVvcF7TbxHtCUmeL2LO44eU5R6084uoW2OWD2+mcZxEOzUqAE35rzTzQwYxEzxS8NpeEmMmAy4hZyHuZJMy/oJad/Hmw8Uung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9muBQwnYA4OdQM1N6IgyNC4nOKA+dA3Lkz2dHRhQdQ8=;
 b=eSjTmSxkuQsAuYnNKZGUfEpFjLJar1xmZqA0L4MLMtDd6w/u+TCNKBuxtwwABr96/0illKNBUCaon4B6/8h0YHpqTvX7daqqGJSI7aKLc+CDdkt+KZa9BQpb2xyk9Men+alML9Cvj90pVvLJAMSxk5PNgCLkgR9doS7z9DL+QCiaM5HaU3qAmg69ipX8udfuw3DzFSu+ZUZGoNRzi3n+kX3RUqAgUBwQA0K4cbc5DTcW0jEZcHVPkEYZqJf6nM6VEhFS8y21DQ5IsiERr67JJ8UKGBjubkQQDpwFtp0MxvZPI7NA0j7citM8Ll7uM6TyA2hIZv2jk5YHCeLHM92MyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9muBQwnYA4OdQM1N6IgyNC4nOKA+dA3Lkz2dHRhQdQ8=;
 b=CrNLkOt2Mw2+Yr858yxYR6PGhY4QJwkP5wvNEjHWjMH1y5icVwmouxKBTPtLD4vUdDpqrcbQZkHlmyANnuz+2wZMr6sWpVZnL2/YBVE074SNj+B9y8IKc34quZLndU7axIDmYfsO8SfV+Slev+sE1Tvnz2rRUy2++dIrRxi1U18=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3664.namprd13.prod.outlook.com (2603:10b6:208:19f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.13; Wed, 7 Oct
 2020 21:34:17 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%7]) with mapi id 15.20.3455.021; Wed, 7 Oct 2020
 21:34:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH 2/2] NFSv4: Use the net namespace uniquifier if it is set
Thread-Topic: [PATCH 2/2] NFSv4: Use the net namespace uniquifier if it is set
Thread-Index: AQHWnO4nXiEOgG0hTESyzGmpb01iBamMpsMAgAACloA=
Date:   Wed, 7 Oct 2020 21:34:17 +0000
Message-ID: <9b44b51fd7f65274a76b167b9c0b3231a7d50f99.camel@hammerspace.com>
References: <20201007210720.537880-1-trondmy@kernel.org>
         <20201007210720.537880-2-trondmy@kernel.org>
         <20201007210720.537880-3-trondmy@kernel.org>
         <20201007212500.GI23452@fieldses.org>
In-Reply-To: <20201007212500.GI23452@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 891f4ca8-f890-469d-21f4-08d86b08beb0
x-ms-traffictypediagnostic: MN2PR13MB3664:
x-microsoft-antispam-prvs: <MN2PR13MB3664E0E02DC11C2383B272FDB80A0@MN2PR13MB3664.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: geB+YjcOCerPKHRFFknrLcO7+v70aKUSU7NRpjpIdEGVNKABq1wzJA2w0eLDokEexotj7xFItT7sl3sHItjNAs2ZsJLmQ3JX9qR7DxGTHSpWVVZJWRbP0AF3VLYe28CSVxDKodQErYd43dfy1pN2dAwcrVrCyv27viYm21tRA4/a5SzTNvaot8SyvU7LD9BOwAwiX7uuC72xz44aUq1fUBN56YUAiR2/L/nKBwtgZbMCxxjHsNkFYNBFTQ673W7d62bmqUNNMScs3+jWRoRkgWpoWJlGwdA1yNnnaDsmBv2Lk0rFnGje57dtUXmnOhenRWb7RyZ5/1UYg8nO3mJ4rA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(39840400004)(396003)(5660300002)(66476007)(64756008)(66946007)(478600001)(71200400001)(6486002)(66556008)(83380400001)(66446008)(76116006)(91956017)(186003)(110136005)(86362001)(2616005)(6506007)(2906002)(6512007)(54906003)(8676002)(36756003)(316002)(4326008)(26005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MAL14SUqe1z7i8GKptXbAdne7gEz4WtyBSE1/iSRus00ljrZrKeaUoXUjUEbXOkQ15uKhNc36pnNHImN2kUIErwghMWXB6w/Gc5RyFwEogB1F3H3hRxssN7epJFR7RlM1kMahAZWgJYmPGqIxNERkV0aVOf3HtHf9+JxW+KJdUifu5V+kmiKZl41AVtdVsQ9l3eRY9BlzD9/hDUOs51H3zuow6V2Rhie8jl25gygEgRq7XVPKWyxwO2Fr1aVK5iUlLbw8mTGArDMDpaYLeyCgufPWAPRu+JdVi0OFsFqc8SPzT0S5ZcYFqN06w4eSKq0quCLlFumz7nG4eHXUrwFc4kQ1BeqL+lZrMaruS942ppFtoLt4cR6xmsA+E/lT/bkr5c0j+cBJLZCcDWxD7rnCkccgfqVU9dckDAsIpUY2MgCuHICpZQWqxyR5M7p44mvojHPpbCOiOzIOCUJVE0QKnrKl5v0UR0fuUnBny+KOJ7LX5gyOCFsoDnews2w6MgBb8fcP3ISwha552Ym73hPn0JQYyWuL2Pj/CAcXpMa1Wv4koF1UY0bWiw04V7S2ilZ2mVFnKm1wM8V1baUSrdUFG609dbPpCW9e4vm0L0MfYJgAAF/VZoJmEg8TL8LRemOQZNtTKbEDfzlf8uifSZIZA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9344975A2DF26E4581BAB2DD1CD5BE34@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891f4ca8-f890-469d-21f4-08d86b08beb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 21:34:17.4257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRR3ympXArQQQrUtcY6a0JlREhCZf4CntLAtxhWuON05JOq5lnawi9QmJgSUT9gA7Yx5lRv0kgW0Igz7ImPdqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3664
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTEwLTA3IGF0IDE3OjI1IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFdlZCwgT2N0IDA3LCAyMDIwIGF0IDA1OjA3OjIwUE0gLTA0MDAsIHRyb25kbXlAa2Vy
bmVsLm9yZyB3cm90ZToNCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gDQo+ID4gSWYgYSBjb250YWluZXIgc2V0cyBhIG5ldCBu
YW1lc3BhY2Ugc3BlY2lmaWMgdW5pcXVpZmllciwNCj4gDQo+IFdoYXQgeW91J3JlIGFjdHVhbGx5
IGNoZWNraW5nIGlzIGlmIG5uLT5uZnNfY2xpZW50ICE9IE5VTEwsIGFuZA0KPiB0aGF0J3MNCj4g
cHJldHR5IG11Y2ggYWx3YXlzIHRydWUuICAoVGhlIG9ubHkgdGltZSBpdCdzIE5VTEwgaXMgYW4g
YWxsb2NhdGlvbg0KPiBmYWlsdXJlIGluIHNvbWUgaW5pdGlhbGl6YXRpb24gY29kZSwgSSB0aGlu
ay4pDQo+IA0KPiA+ICsJc3RydWN0IG5mc19uZXQgKm5uID0gbmV0X2dlbmVyaWMoY2xwLT5jbF9u
ZXQsIG5mc19uZXRfaWQpOw0KPiA+ICsJc3RydWN0IG5mc19uZXRuc19jbGllbnQgKm5uX2NscCA9
IG5uLT5uZnNfY2xpZW50Ow0KPiA+ICsJY29uc3QgY2hhciAqaWQ7DQo+ID4gKwlzaXplX3QgbGVu
Ow0KPiA+ICsNCj4gPiAgCWJ1ZlswXSA9ICdcMCc7DQo+ID4gKw0KPiA+ICsJaWYgKG5uX2NscCkg
ew0KPiANCj4gQXJlIHlvdSBzdXJlIHlvdSBkb24ndCBtZWFuDQo+IA0KPiAJaWYgKG5uX2NscC0+
aWRlbnRpZmllcikNCj4gDQo+ID8NCj4gDQo+IEkgdGhpbmsgdGhhdCdzIGhvdyB5b3UgdGVsbCBp
ZiBzb21lb25lJ3Mgc2V0IGl0Lg0KDQpXZSdyZSBub3QgaG9sZGluZyB0aGUgcmN1X3JlYWRfbG9j
aygpIGhlcmUsIHNvIHRoZXJlIGlzIG5vIHBvaW50IGluDQpkZXJlZmVyZW5jaW5nIHRoZSBpZGVu
dGlmaWVyIHBvaW50ZXIuIFRoYXQgd291bGQgY2F1c2UgYSB0b2N0b3UgcmFjZS4uLg0KDQo+IA0K
PiAtLWIuDQo+IA0KPiA+ICsJCXJjdV9yZWFkX2xvY2soKTsNCj4gPiArCQlpZCA9IHJjdV9kZXJl
ZmVyZW5jZShubl9jbHAtPmlkZW50aWZpZXIpOw0KPiA+ICsJCWlmIChpZCAmJiAqaWQgIT0gJ1ww
JykNCj4gPiArCQkJbGVuID0gc3RybGNweShidWYsIGlkLCBidWZsZW4pOw0KPiA+ICsJCXJjdV9y
ZWFkX3VubG9jaygpOw0KPiA+ICsJCWlmIChsZW4pDQo+ID4gKwkJCXJldHVybiBsZW47DQoNCk9v
cHMuIEhvd2V2ZXIgSSBkbyBuZWVkIHRvIGVuc3VyZSB0aGF0ICdsZW4nIGlzIGFsd2F5cyBpbml0
aWFsaXNlZA0KaGVyZS4NCg0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgCWlmIChuZnM0X2NsaWVudF9p
ZF91bmlxdWlmaWVyWzBdICE9ICdcMCcpDQo+ID4gIAkJcmV0dXJuIHN0cmxjcHkoYnVmLCBuZnM0
X2NsaWVudF9pZF91bmlxdWlmaWVyLCBidWZsZW4pOw0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gQEAg
LTYwMzQsNyArNjA1MSw3IEBAIG5mczRfaW5pdF9ub251bmlmb3JtX2NsaWVudF9zdHJpbmcoc3Ry
dWN0DQo+ID4gbmZzX2NsaWVudCAqY2xwKQ0KPiA+ICAJCTE7DQo+ID4gIAlyY3VfcmVhZF91bmxv
Y2soKTsNCj4gPiAgDQo+ID4gLQlidWZsZW4gPSBuZnM0X2dldF91bmlxdWlmaWVyKGJ1Ziwgc2l6
ZW9mKGJ1ZikpOw0KPiA+ICsJYnVmbGVuID0gbmZzNF9nZXRfdW5pcXVpZmllcihjbHAsIGJ1Ziwg
c2l6ZW9mKGJ1ZikpOw0KPiA+ICAJaWYgKGJ1ZmxlbikNCj4gPiAgCQlsZW4gKz0gYnVmbGVuICsg
MTsNCj4gPiAgDQo+ID4gQEAgLTYwODEsNyArNjA5OCw3IEBAIG5mczRfaW5pdF91bmlmb3JtX2Ns
aWVudF9zdHJpbmcoc3RydWN0DQo+ID4gbmZzX2NsaWVudCAqY2xwKQ0KPiA+ICAJbGVuID0gMTAg
KyAxMCArIDEgKyAxMCArIDEgKw0KPiA+ICAJCXN0cmxlbihjbHAtPmNsX3JwY2NsaWVudC0+Y2xf
bm9kZW5hbWUpICsgMTsNCj4gPiAgDQo+ID4gLQlidWZsZW4gPSBuZnM0X2dldF91bmlxdWlmaWVy
KGJ1Ziwgc2l6ZW9mKGJ1ZikpOw0KPiA+ICsJYnVmbGVuID0gbmZzNF9nZXRfdW5pcXVpZmllcihj
bHAsIGJ1Ziwgc2l6ZW9mKGJ1ZikpOw0KPiA+ICAJaWYgKGJ1ZmxlbikNCj4gPiAgCQlsZW4gKz0g
YnVmbGVuICsgMTsNCj4gPiAgDQo+ID4gLS0gDQo+ID4gMi4yNi4yDQotLSANClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
