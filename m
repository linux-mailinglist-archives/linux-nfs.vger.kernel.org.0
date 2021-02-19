Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7400031FFB7
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 21:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhBSUIS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 15:08:18 -0500
Received: from mail-mw2nam10on2113.outbound.protection.outlook.com ([40.107.94.113]:44449
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229555AbhBSUIP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 19 Feb 2021 15:08:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMSiB3ll5WxT+KRfCWYrafWja0+cPu5KxPJvm8NpmsbWTeeCqxJhj5K4gylG/KDy+/aIuNMyzqpk4aKfNnsLmx7/jh5/29XruwISQTmvG1RWX44q3/w43l10cw1MgfSNn99g/4azx5aIa8/skcbxLlgW7/tmwTyGb1rrBL09EWRwCx/2km58vE2OSjS7YzDsig6YEnxrFGuQE6Nfnwg99P24/XFa1i3srduDzUaOlAnbE92kWXPv+WIpXzhYfRZ2Fm2LJ/C2iSNI1oiDHjML//tQT6pa02pCM/2fpCS/pljceZOLIvEDTTU+7JhdhG8XcQXyDlIf864b81Dcu5SPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0ybscqcnMLaYFF4VCo3oaj8TyffdXh5wdC06aa5rYY=;
 b=Wzz55sQWUBD4ROu8rP0JIe7jhsfMneWDVZ8DrSl93qCGvaUxo5bPJzZ//zgi0gN3/GHcW3zouqt0Jrgrp80nud+gw6+kzUgiA5U0HB4a1kHovsYOvYw3NzsO3mJAReDXLdAK9B9kKHdDs1gSjJtY0fIqHkFDNxQ0DhK04SJYLI2BZ1Fog47G2JYE/Rr0zQ+5x8beKK1ozlUS7DQHrXvvKJbOFDIJ3E+0at0q2+OW/7K0o05f+7ZOGPGMXpRLRr8JcBZmx2E5YZne4HRNLhyZWJ319l7Gmvxh7XUQlMfQB/5mhvd5lQmWuvWRcPjZw9azcTkz12uWVv23d2OVXCAJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0ybscqcnMLaYFF4VCo3oaj8TyffdXh5wdC06aa5rYY=;
 b=UxcNaoFzIawPAH2WZGyl5sI5S3u+eBbWqAwIcpmpclUx8AYK2NzpjngQW3liT4mWJPGtNUgsFTHMpuMGV2H4eaQsq0sruK8p4puzwxUL1L7xtgt1QpRhQylhmW4QW+dj3orT/utyjDDy/gvXbWplzis6Dcu0g5csS1uTsWQ3ljw=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3623.namprd13.prod.outlook.com (2603:10b6:610:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11; Fri, 19 Feb
 2021 20:07:20 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3868.025; Fri, 19 Feb 2021
 20:07:20 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] NFSv4 account for selinux security context when
 deciding to share superblock
Thread-Topic: [PATCH v2 2/2] NFSv4 account for selinux security context when
 deciding to share superblock
Thread-Index: AQHXBi9e6cNIt3rRBUGTinwY+Y3SlKpfI2oAgACXVQCAAC6HAA==
Date:   Fri, 19 Feb 2021 20:07:19 +0000
Message-ID: <9fa77d94ac515e4318877607ec9e65a4eee2856c.camel@hammerspace.com>
References: <20210218195046.19280-2-olga.kornievskaia@gmail.com>
         <20210219081908.GQ2087@kadam>
         <CAN-5tyGrDtfLBXg42XLzp2med482QWPKN_KGXwNH_SP3V5buew@mail.gmail.com>
In-Reply-To: <CAN-5tyGrDtfLBXg42XLzp2med482QWPKN_KGXwNH_SP3V5buew@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec82cd6b-92cb-4499-70a8-08d8d511f6a4
x-ms-traffictypediagnostic: CH2PR13MB3623:
x-microsoft-antispam-prvs: <CH2PR13MB36233E855777D153880EBC9CB8849@CH2PR13MB3623.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y2yDh0cQjxxiSaANl8nH4fkBMkpSh1T88vXoluOfkbV4FdlPOPdutJhfJFZfThLgMvwI2GsaQvx2weY17Yw27s4rDQkxRFu2NvOF8gjutvql/8M4ZC5wWpvQggGrgpw3sMCHmp+DoRMj1SUycmH7HSd0iA499Y3UULh+iKaOnyy7iat5pIROA8lJbKArN7oJUcJ55DAIFrE8jVe0aefGB1cXaojNOpnSVdPRxf2A4CdwjzSzKG+DK8SQPuUK5gKehJAReeBbSjElFDuGo8ka71dwRfIB7g2X9DfkK4kMkH6i5u/p81+lzPwEteEo7XDqm5a03FtViNlgkFqKXp20IKrJ2ZfFfcWWIMk23Qyz2g6LjF1lSnQM2gUNQdAwiDkx4I/Q5V90U5hMGD15oPLUbioN95XirBlnS2lbwz7rkwUOr/nU7gFoFshtG5ikZbZcAswvb1H5C0kM8q7PzpbjjeXxe7e7GUJjZPGJD6HvnbuZ3cXca/bt82/j6Btyc6PuGhHl6Uy69z8rLnqUfm1ZQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(366004)(376002)(346002)(396003)(478600001)(66446008)(6512007)(66556008)(36756003)(4326008)(316002)(8936002)(66946007)(54906003)(6506007)(110136005)(8676002)(186003)(76116006)(26005)(2906002)(2616005)(6486002)(5660300002)(71200400001)(66476007)(64756008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cWNYbzRHT3cvU29Vc2M5UGFDejRMRnBnamRPZ0t5cVFLY3hLZGpEc0NEN1NK?=
 =?utf-8?B?L1hDeS9obHBnVGdzdi9qNmVQUHpJTWozZkRIQWprRGI3LzBCQVpBb0s2Tnlm?=
 =?utf-8?B?VGJJbHdycjVSNnZtSnZOUGNPQkRwaDB5N09IY05XNENGTzRiZFRVeVc4cXRS?=
 =?utf-8?B?aWxvc0hFRFliWHdkVmN6RFJRNC9TWXpwbk0rTm03V283K2Z3dGd2VGFBSEV6?=
 =?utf-8?B?LzlCL2lNT3VxRENXWG56aDYzL2Y2Nk9yRUN0VWtIbHAzMHQ0cllPMkhuUmN4?=
 =?utf-8?B?WDJoVUJKZnpsSmFYR2U1ZHZIYjF2MWVrMzYyalE4Z1NQdGZHbFd4TkxEL3Vz?=
 =?utf-8?B?b2NleENjeWNkcTdEd0ZZUEdSZE16bnRJUDVUOU84YnFTVDBndnVXdDdzemZG?=
 =?utf-8?B?RnE1bjE2SmxYaDhDalhZdzIrSlhKYzI5YlhDbnBVVjVHSHN3SjlySGZEcTFs?=
 =?utf-8?B?d2xXWU16SllMblFEMzVmRG1uZjI5eXk1OUN1OG9kTnp2VTV0VVBXcGJVY3Zn?=
 =?utf-8?B?VlFXTSs4M3Vzd09ZZUZ4RTdhNUQvVVVOc2pwZlVmL0hHZkptd0VobXRjR1pW?=
 =?utf-8?B?bFhKOTdPTVIxa2hNemh1SlRUYmVCWU54R09LdEk5aUU5V2ppZjJqNU5UcUor?=
 =?utf-8?B?T0JGK2VRV2xEVlJrYUhVWVhaTFFTZVdHSktNOXNhZGNnTm55Q3lMbk84UnJr?=
 =?utf-8?B?T0VBNkdybFFjYXFCSFE0MGxCbkszWlk4QUxMb2xNcERnUHRTRlIxOHBxME5L?=
 =?utf-8?B?UTBkd09CMFpmbnJ6cnIwYUVmd2kzOTZsTDhuazFCbkxTeGJkMmU3aHRNWVhC?=
 =?utf-8?B?dlo1Y1ZRR1ZWeEtwVE9uc3B1NGtTZzBlU2hwMC9DNHAyMi85aTR6R2l2YVN4?=
 =?utf-8?B?TDVwRDd2c3JNRTRSVTYyYkdzYmV2ZHJPVXhlRU1DbFFldzJkSjZDNUlRa0M4?=
 =?utf-8?B?NENxc1RWMzhDRFc2NVV5Z0IwZTUxVTBrVzcwRStpSFg0YmY1d0Jnd2JTck81?=
 =?utf-8?B?Y1RYUXYwRyt3Nzg0dVVpYVo4Z0N0anJwRGlUdnYvc3V2d1BSM3VFWVpia1ZW?=
 =?utf-8?B?Y0t6VG16SG0rdWtIVGZLcWJpTEN5eHUrL1hNUmxSYlhtZjRLY3ZYZ2VxakdX?=
 =?utf-8?B?SGxDcG9vTGxFZnVCT3NQQ3dPMnFITUFtVGJmdzRLNGtaeGw1VjhYWTFSanpu?=
 =?utf-8?B?UjlUOUJraGZCeEpvYmZHajRVang5RE4yYlVmaGhZQ3dVWDBBcXp4UEkydVV2?=
 =?utf-8?B?bDlLK1VZM3VIcDg2VFFDUWJYUlRORGRwVS9SdXUzU1ZoTTBCdzlXR3M4aVc5?=
 =?utf-8?B?MzZvRW5oNk9JR0MzN29naUJIamo4dFV1MlVWUkJ4UTVDQ0NKNGpXcWhTaCtW?=
 =?utf-8?B?bUhBV21OdmIyaTU3dEpESGdIZDhXaWxtNVh0eU5STDk2ZldhZEVUMXhXWlps?=
 =?utf-8?B?bFpHNDdQTFFYaC9pcjgrM3ZVV0JwNDRoVEY0amZYdnhZVFBiOUl1UUNhV0s4?=
 =?utf-8?B?TTkwVXVaci91VG9oeTN5UEZaSmNKRmZpdEhXNjI2RnpHK0lsd20yc2lTbTBU?=
 =?utf-8?B?YUZnc1M0RWw0c1BNYmRMSWt3S0NTUFphdlE1d3ZIei9PN3RlbnRrTEV6bnJV?=
 =?utf-8?B?elJsb3FCczd4NjNaLzJTZ3FDSWM0Qzd1aThlODVNanBSVDZPcnUrS0VkdldO?=
 =?utf-8?B?Z2lnWVZmNWFLcGxGZzNzQXorcHhLdnRHNnhsckQvaHlTQjF1dFBnVTE0L3ZV?=
 =?utf-8?Q?IANJt5bLDTqIZZWCIx1kZbgW3NyHcw908ex+9I2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DE7654C7CBE4548BA656C7BF99DEB24@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec82cd6b-92cb-4499-70a8-08d8d511f6a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 20:07:20.0608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPtkhK93mj4tZof9KxyKs1YL0tcF83+SPDOQhMEVs81298V/0q6GZDxP0yWg6biGRC1dbgjOcG0MAvt4uQX/2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3623
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTAyLTE5IGF0IDEyOjIwIC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gVHJvbmQvQW5uYSwNCj4gDQo+IEknZCBsaWtlIHlvdXIgb3BpbmlvbiBoZXJlLiBTb21l
IHN0YXRpYyBjaGVja2luZyBmbGFncyBhICJjdHgiDQo+IGFzc2lnbm1lbnQgaW4gbmZzX2ZpbGxf
c3VwZXIoKSBpbiB0aGUgbmV3IHBhdGNoLiBJbiBhbiBleGlzdGluZyBjb2RlDQo+IHRoZXJlIGlz
IGEgY2hlY2sgZm9yIGl0IGlzIE5VTEwgYmVmb3JlIGRlcmVmZXJlbmNpbmcuIEhvd2V2ZXIsICJj
dHgiDQo+IGNhbiBuZXZlciBiZSBudWxsLiBuZnNfZ2V0X3RyZWVfY29tbW9uKCkgd2hpY2ggY2Fs
bHMgbmZzX2ZpbGxfc3VwZXIoKQ0KPiBhbmQgcGFzc2VzIGluICJjdHgiIGdldHMgaXQgZnJvbSB0
aGUgcGFzc2VkIGluICJmc19jb250ZXh0Ii4gSWYgdGhlDQo+IHBhc3NlZCBpbiBhcmcgY2FuIGJl
IG51bGwgdGhlbiB3ZSBhcmUgZGVyZWZlcmVuY2luZyBpbiB2YXIgYXNzaWdubWVudA0KPiBzbyB0
aGluZ3Mgd291bGQgYmxvdyB1cCB0aGVyZS4gU28gImN0eCIgY2FuIG5ldmVyIGJlIG51bGwuDQo+
IA0KPiBTaG91bGQgSSBjcmVhdGUgYW5vdGhlciBjbGVhbiB1cCBwYXRjaCB0byByZW1vdmUgdGhl
IGNoZWNrIGZvciBudWxsDQo+IGN0eCBpbiBuZnNfZmlsbF9zdXBlcigpIHRvIG1ha2Ugc3RhdGlj
IGFuYWx5emVycyBoYXBweT8NCj4gDQoNClllcywgYXQgdGhpcyBwb2ludCwgbmZzX2ZpbGxfc3Vw
ZXIoKSBpcyBvbmx5IGNhbGxlZCBmcm9tDQpuZnNfZ2V0X3RyZWVfY29tbW9uKCksIHdoaWNoIHdv
dWxkIGNyYXNoIGFuZCBidXJuIHdlbGwgYmVmb3JlIGlmIGN0eA0Kd2VyZSBhbiBpbnZhbGlkIHBv
aW50ZXIuDQoNClNvIHBsZWFzZSBnbyBhaGVhZCwgYW5kIHJlbW92ZSB0aGUgY2hlY2sgZm9yIGN0
eCBiZWluZyBOVUxMIGluDQpuZnNfZmlsbF9zdXBlcigpLg0KDQotLSANClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
