Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A408C2AC802
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 23:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgKIWGZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 17:06:25 -0500
Received: from mail-eopbgr750101.outbound.protection.outlook.com ([40.107.75.101]:58944
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbgKIWGX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Nov 2020 17:06:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+i9ZB4p5Qg82sUtFU/TnBHz/1GUCH8k9q4St+uSZ9pDVMO81U6l7xbALnnxuR/rxH1yLPVnxJj8BzJcjz7eyG1C9nuVGzJSWcg532+xY3X4xsBA74U1MqR13dcQrztNAyou/Hh0vdA/uuWTojQpFfLKXozxhSQWZvB7MBqRq1jRrsKNhEUTH0Ys6DF/jYCmKWoYfCcCVZ0+31j/RHhcmTPpDY55SbTEzj6wD3bGQbdSSs1bMyAJTB9vqNfQppmF8WqAtzTk1GBp0PhdCXfFH5XL+xGbE/8V2BZLNWyNStJw/yVkWnfW3U1IBciyDn551NyIPEuM6ii/emDYTDZy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzT4Kj8Ds3FvfrcIwwFzLdG3qJGfpO6JkJNzXFuBAXM=;
 b=KN1CLr8+3sf67l5JdZohIl1lOspYNJAAmrH3t0FYJhYCFe2tiuuPvurhv/8ldwPkl6ipNyneMwgt5WOsinBCzfFLufQxiKF3/VhbUp/hWynqrl01LK08NAVHfLXGwRFbs7DNbMoXTS66s5u0NGzi4ABvx27eq2sTux3/oJ6DOe4Co+UN7uK4Xp2WwJpj+kE863RGgICRaUEQU1oB4oO1dBzAEWxtYBOTWDuHri46bzA1/o+JkxfW3nKbC0oQ15XoxWIfk2UKBt192M93QyIP/H6n0ExX6zPUPdUDK8EU33BKHUdaFyxV5zOETAsKx6W6QMgJHgeaGuB9iM4d2H+bjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzT4Kj8Ds3FvfrcIwwFzLdG3qJGfpO6JkJNzXFuBAXM=;
 b=bS4v8idw0IImLLlZMkqw6W4+Suk/o3nKvL5jsF0n/Qsy1CDmsaO+sM5lTQ/oCvgrYgxTo3fxsGvK+veolyf90uJifS6JBfiuhPVwkVDqQXbIRupfKQXped25R0CVMXirtWoJZTTZ8yT/Lc9+jCJasytZjIprMVj8WltKWHaRIXg=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3390.namprd13.prod.outlook.com (2603:10b6:208:163::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21; Mon, 9 Nov
 2020 22:06:18 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Mon, 9 Nov 2020
 22:06:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] SUNRPC: xprt_load_transport() needs to support the
 netid "rdma6"
Thread-Topic: [PATCH v2 1/5] SUNRPC: xprt_load_transport() needs to support
 the netid "rdma6"
Thread-Index: AQHWtt4wJmvWIqsO0Uq/iwdKELJe16nAVs4AgAAEjAA=
Date:   Mon, 9 Nov 2020 22:06:18 +0000
Message-ID: <f5f3d846dc339fa9b79533235cb7971dd5c8a71d.camel@hammerspace.com>
References: <20201109211029.540993-1-trond.myklebust@hammerspace.com>
         <20201109211029.540993-2-trond.myklebust@hammerspace.com>
         <1BBDFE45-EFF6-4997-A6C1-E4BB07863ACB@oracle.com>
In-Reply-To: <1BBDFE45-EFF6-4997-A6C1-E4BB07863ACB@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ed914b0-2d6a-46af-a4e2-08d884fbaf46
x-ms-traffictypediagnostic: MN2PR13MB3390:
x-microsoft-antispam-prvs: <MN2PR13MB3390A82D09E57099910D4E48B8EA0@MN2PR13MB3390.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XOr8N8maNzvjM0PTJr6QGNUVdBS0iZZNdD75bJ+fJf+EDFe9gzR+Nt6GT2sPuGsYX+RpiVXMVGgTNjSPlHJXVUz9z9DIpqQDgKbldRa/SGQ/9XabTpNi+5I1FjkgGEa8i28bJ/hmOw1xEY6qRIIMiXmzLduXW0Cp0DgogzHJtUdcgW/TsknvePpqrX7TEzeOoRLpHtwNcfkRkEMVv3aNWxRUeyBf9KSpIP2yri25Ol6nbBJ50uXDGsSo7lnQ64q7wZ5aCFTR/NkI5r4G0bT+ZwEgk+VhBqTAJdCjk2AkkEnnrKUTTvvjMpKCJxJUvQMqrHJ3P+RBSxq/xY+9ir0U4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(136003)(346002)(376002)(396003)(8936002)(5660300002)(8676002)(6486002)(66946007)(2616005)(6512007)(316002)(66476007)(76116006)(36756003)(478600001)(91956017)(66556008)(66446008)(64756008)(26005)(186003)(4326008)(6916009)(86362001)(53546011)(6506007)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 55LAaCqybegI0CRJ9/r99TADDnaKjASIIpPDzMXAkDHl9G5+ZaOq4F+JkDSOE4YRCE/37oEZbyXEtw5kr6/dx+5jfBSKvxsvcdjPs7j+H//EGophgvjVWNzfL3aZw4O5iwcZKqe0PeBoAd2dzfmfB3mPo6p0W/q6JCYRhWreHaGDj24kS7YOVwZOEPgwi3vI5fmJytHOOoQenV14CjXVlX6xHIlQvFcS+4eh8j6Y42rzms9wWwrc+lKCGbfUxiw4QdPrtHJNFZa0ACyK4RdVUt04ZFY9mCpbnGHVJf2ZfH8lE5/ZRrLfj+5yzskcjKWhTyZQWYnB0lsmwQlplvyA80nibzWUC35dfpyH3XFWYMUfohW9gLaNJs4gM7icHUDsj2bAOgJ57pZg01Fv3YU4W7FL2fapZaPgJQvHAXXX+928AxEtKxKGhywuWWdbyBRoikTmHIGKSoVbaYRuopRI2SgUUfGrvF1J/2cRX/uRxM+wkyhtNYx7muPQvjY4sn/s2HmUOLc2bpyzzSscySkMk1WH0hFQq/pYemN4q1wlw6lIJaMmoX+WhIOHxnVePnp4PFncRWF1KqLMj+IcZEmDyqzc4rmtcw//odFqRIJ/j8jnIrkPfgTZUY201FKp+RHrARr55T3l+aJrIq+LX7V/cA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E75BFAC374F3984FA4C9320FA51EA4D6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed914b0-2d6a-46af-a4e2-08d884fbaf46
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 22:06:18.2845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95tYasF2oZ7rYC2qUnBxe4GQf/UQOYVEZDBK2J/PjLWaYUYrIv144he67ltrhy03aWveHOY7JLATqDZ74N0OlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3390
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTA5IGF0IDE2OjUwIC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
DQo+IA0KPiA+IE9uIE5vdiA5LCAyMDIwLCBhdCA0OjEwIFBNLCB0cm9uZG15QGdtYWlsLmNvbcKg
d3JvdGU6DQo+ID4gDQo+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tPg0KPiA+IA0KPiA+IEFjY29yZGluZyB0byBSRkM1NjY2LCB0aGUgY29y
cmVjdCBuZXRpZCBmb3IgYW4gSVB2NiBhZGRyZXNzZWQgUkRNQQ0KPiA+IHRyYW5zcG9ydCBpcyAi
cmRtYTYiLCB3aGljaCB3ZSd2ZSBzdXBwb3J0ZWQgYXMgYSBtb3VudCBvcHRpb24gc2luY2UNCj4g
PiBMaW51eC00LjcuIFRoZSBwcm9ibGVtIGlzIHdoZW4gd2UgdHJ5IHRvIGxvYWQgdGhlIG1vZHVs
ZQ0KPiA+ICJ4cHJ0cmRtYTYiLA0KPiA+IHRoYXQgd2lsbCBmYWlsLCBzaW5jZSB0aGVyZSBpcyBu
byBtb2R1bGVhbGlhcyBvZiB0aGF0IG5hbWUuDQo+IA0KPiBUcnlpbmcgdG8gd3JhcCBteSBoZWFk
IGFyb3VuZCB0aGlzLiBXaG8gaXMgZm9ybWluZyB0aGUgbGVnYWN5IG5hbWVzDQo+ICJ4cHJ0cmRt
YTYiIGFuZCAic3ZjcmRtYTYiID8NCg0KSSBkb24ndCBjYXJlIGFib3V0ICJzdmNyZG1hNiIsIGJl
Y2F1c2Ugbm90aGluZyB1c2VzIHRoYXQgbmFtZSwgQUZBSUNTLA0KYmVjYXVzZSBfX3dyaXRlX3Bv
cnRzX2FkZHhwcnQoKSBhcHBlYXJzIHRvIHVzZSB0aGUgInRyYW5zcG9ydCBuYW1lIiwNCndoYXRl
dmVyIHRoYXQgaXMuDQoNCj4gVGhlIG1vZHVsZSBuYW1lIHRoZXNlIGRheXMgaXMgInJwY3JkbWEi
LiBTZWVtcyBsaWtlIHlvdSBzaG91bGQgZml4DQo+IHRoZSBjb2RlIHRoYXQgaXMgdHJ5aW5nIHRv
IGxvYWQgdGhlc2UgYnkgdGhlIHdyb25nIG5hbWUgcmF0aGVyIHRoYW4NCj4gYWRkaW5nIG1vcmUg
bGVnYWN5IG5hbWVzLg0KDQpObywgSSdtIG5vdCBnb2luZyB0byBkbyB0aGF0Lg0KDQpUaGUgaW50
ZW50aW9uIHdhcyBhbHdheXMgdGhhdCB4cHJ0X2xvYWRfdHJhbnNwb3J0KCkgc2hvdWxkIHRha2Ug
dGhlDQpuZXRpZCBhcyBpdHMgYXJndW1lbnQuIEZ1cnRoZXJtb3JlLCBpdCBtYWtlcyBubyBzZW5z
ZSBmb3IgZWl0aGVyIHRoZQ0KTkZTIG9yIGdlbmVyaWMgUlBDIGxheWVycyB0byBoYXZlIHRvIGZp
Z3VyZSBvdXQgaG93IGJ5IHRoZW1zZWx2ZXMgaG93DQp0byB0cmFuc2xhdGUgbmV0aWRzIGludG8g
dHJhbnNwb3J0IG1vZHVsZSBuYW1lcy4NCg0KPiANCj4gPiBGaXhlczogMTgxMzQyYzVlYmU4ICgi
eHBydHJkbWE6IEFkZCByZG1hNiBvcHRpb24gdG8gc3VwcG9ydA0KPiA+IE5GUy9SRE1BIElQdjYi
KQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbT4NCj4gPiAtLS0NCj4gPiBuZXQvc3VucnBjL3hwcnRyZG1hL21vZHVsZS5j
IHwgMiArKw0KPiA+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94cHJ0cmRtYS9tb2R1bGUuYw0KPiA+IGIvbmV0L3N1bnJw
Yy94cHJ0cmRtYS9tb2R1bGUuYw0KPiA+IGluZGV4IDYyMDMyN2MwMTMwMi4uZmI1NTk4MzYyOGI0
IDEwMDY0NA0KPiA+IC0tLSBhL25ldC9zdW5ycGMveHBydHJkbWEvbW9kdWxlLmMNCj4gPiArKysg
Yi9uZXQvc3VucnBjL3hwcnRyZG1hL21vZHVsZS5jDQo+ID4gQEAgLTIzLDcgKzIzLDkgQEAgTU9E
VUxFX0FVVEhPUigiT3BlbiBHcmlkIENvbXB1dGluZyBhbmQgTmV0d29yaw0KPiA+IEFwcGxpYW5j
ZSwgSW5jLiIpOw0KPiA+IE1PRFVMRV9ERVNDUklQVElPTigiUlBDL1JETUEgVHJhbnNwb3J0Iik7
DQo+ID4gTU9EVUxFX0xJQ0VOU0UoIkR1YWwgQlNEL0dQTCIpOw0KPiA+IE1PRFVMRV9BTElBUygi
c3ZjcmRtYSIpOw0KPiA+ICtNT0RVTEVfQUxJQVMoInN2Y3JkbWE2Iik7DQo+ID4gTU9EVUxFX0FM
SUFTKCJ4cHJ0cmRtYSIpOw0KPiA+ICtNT0RVTEVfQUxJQVMoInhwcnRyZG1hNiIpOw0KPiA+IA0K
PiA+IHN0YXRpYyB2b2lkIF9fZXhpdCBycGNfcmRtYV9jbGVhbnVwKHZvaWQpDQo+ID4gew0KPiA+
IC0tIA0KPiA+IDIuMjguMA0KPiA+IA0KPiANCj4gLS0NCj4gQ2h1Y2sgTGV2ZXINCj4gDQo+IA0K
PiANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
