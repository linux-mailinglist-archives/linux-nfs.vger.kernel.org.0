Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6311E3E4EE1
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 00:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhHIWCC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 18:02:02 -0400
Received: from mail-dm6nam10on2090.outbound.protection.outlook.com ([40.107.93.90]:24104
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232947AbhHIWCB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Aug 2021 18:02:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7Hk0zacBWl8sQWf5zRj0o+eiCDz/iuegtwOLRE552bcL8xrdWrTLHAc7ArmRSytLtkJ3vFiqcd7cmWw3iZHLV+oCDDHXty1V7VSzyOQSfwf1DDJV/xsPBUniT0hvvBbgJ2SSAM40O+Ht/sOzwQFd6BBH2sqho547y4i+tbbD5KatU6HYWTX36wQ/qbKm3KINSPc8yhe4OR1Uhm96UOrA8lnbyotX4zPv766u6kGwX1Z8o8f/rcwdvdNA/5hV819/5TUKapW3sEnRoViMgKAfFYQWfnyCRAIvRuWl5RBu33SAzY+u3/fnKoGHSBG14Aq6ZiyJAoVN4fje0pAJ7QoiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C758me0T2YPquH+uxJ3sKdR15mkuwjGF478Z+oMn5os=;
 b=ezqTAtM1xOpU5ZB5dtO4/XoIbY60q6SkvDH4inGwEdp4iN3svuhvzRq6iBerlVvFFaR1//bn1UFhHXYK07yYMfsQ0QRQwpuML3pMWkQ1YhDi8twRFBT3mCddg48IDrFbKvn1LxbgsQNTCFSyS70BM90/aran61HYrm9HeYwoupOALpeKAr8W7oGMM9K/ZJURZHh27UWiGtwlEJBJ2vpp4Yoi5gt/KmgksVDQeSgnhc32pHHjJQ9qpQQXl7GwkYBr3bsk7tgVmWiUyC7CQr6m3Pd21GN+WJuuSjRgcjkB5qZeHgyHkCcErHJcI2XpvCyqV/DRY3hzZrkDLws+22/+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C758me0T2YPquH+uxJ3sKdR15mkuwjGF478Z+oMn5os=;
 b=uhUaadLpgFNzVE+fFDIW7DwPBBkdWBIigc+U1cu1VpCJPaHx/8SXpjNeEZUJ7+DlFbC40+Jv0iyvelsrkRiCZxODT6LzZboyU/2Ngs4o7+mE1fw2DsEYFi6QkbYMAJxGl55Z5cnXIkJ83fy+rTAJeNV+EfaAwVHLWUxpy1k9cxY=
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by MN2PR14MB3407.namprd14.prod.outlook.com (2603:10b6:208:1aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Mon, 9 Aug
 2021 22:01:39 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::b821:bf6:30b6:e56d]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::b821:bf6:30b6:e56d%6]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 22:01:39 +0000
From:   Charles Hedrick <hedrick@rutgers.edu>
To:     Timothy Pearson <tpearson@raptorengineering.com>
CC:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: xSdTgH983VDBQkCAmg52fDts9flGRnsuG+zO3JoCWACAAAPHgIAACdwAgAACeYCAAAYTAIAADpYAgAAAaoCAAAIdgIAAAvmAgAAAhwASVj4mvf9tcHuA7mVOwCCRmsQTgA==
Date:   Mon, 9 Aug 2021 22:01:39 +0000
Message-ID: <EC809F03-464E-4F82-BB2B-DD62EF17C9AB@rutgers.edu>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
 <F5179A41-FB9A-4AB1-BE58-C2859DB7EC06@rutgers.edu>
 <1065010667.1047836.1628533859535.JavaMail.zimbra@raptorengineeringinc.com>
 <19368DD0-74CA-4DB7-9C1F-707106B50635@rutgers.edu>
 <20210809184911.GD8394@fieldses.org>
 <15AD846A-4638-4ACF-B47C-8EF655AD6E85@rutgers.edu>
 <81413392.1050622.1628535375526.JavaMail.zimbra@raptorengineeringinc.com>
 <FE5ABF17-F030-4A58-9150-49BAB4E8D208@rutgers.edu>
 <921953712.1074013.1628545770061.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <921953712.1074013.1628545770061.JavaMail.zimbra@raptorengineeringinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: raptorengineering.com; dkim=none (message not signed)
 header.d=none;raptorengineering.com; dmarc=none action=none
 header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5a1cd00-0179-49ce-295e-08d95b8143ce
x-ms-traffictypediagnostic: MN2PR14MB3407:
x-microsoft-antispam-prvs: <MN2PR14MB3407F7B172C0AC4BE464278AAAF69@MN2PR14MB3407.namprd14.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o+O2UoUkNxdYZ09lVZlG3fGjgoN8EFl6lPB+k/yUVLSHVcO3nwsIX/X2qz0722QLQyPaE2HxynAOi70Edml8yxcIOOZMC3NTbaU0MOh9gxTCY8wgJWNeGtY+UjbeaGyCxd2kOPegZiFHRf3SJzwycHCMfJXkBBIgSG4JtNuR/4j1Wcq5rQbXJ2w9gxEncdVfjahmtObVUWcf29nRvOuAW/32p9tz+CTauSzuIl4LzE4qJAVMcef6ssVQSkgm9idg66ueaQANDIVbhHVx4/C7rsrnhWXCvOGctwgHclXWSw+NvxVwebTLwUbSW+4XZtB4NWMUrMlIoQPBBeFMFeR8W7TaZNaC86KdXLDb5fd+mf+NQYWvevTUdNSDMfhKVdHjAj6GCCMQ6rhcCaIju4gRmiNTCD2swy37cSQaFiMF+NKBauyRXS5jFr/CvRsgcLajGVHERZ7cSse/4MjTEcKZcVwALDvDGTAg55gnN49cdVgkjkoDvMlhRluOuk6YBk689jtKytbc4ZpdA08jdsMDuZLWujpDaGiqFQTQw+JBW0ILTp3iwqXor/XtZcLB0m/mc01+qkYOPM4M9qlvcFjTI1OUJbsgkfFFQXOjknxp1e7lW8ZUPckbmTyOu5yif5cdZV/EluzaRTJVRCamIhHx+dlfMK2utOsJWm1HHxl0qwE/kaBjpzgxlC+pbH7W046C89TMxN8B6abiHfBjiBFx2bgY7BKhmI/Xd0ahm2TIryE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(2616005)(83380400001)(6512007)(6486002)(75432002)(36756003)(2906002)(33656002)(86362001)(71200400001)(66574015)(6916009)(66446008)(64756008)(53546011)(66476007)(66556008)(122000001)(66946007)(76116006)(186003)(38100700002)(26005)(54906003)(8936002)(478600001)(316002)(786003)(4326008)(38070700005)(8676002)(6506007)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFNQZHdDM3NGWnZ3dDJPQnd2bWtVc2xTZ3FocnhaK2lrdnVmUmlmdUw3ME1I?=
 =?utf-8?B?dkxXWTFPYWVtNGxRT285YnoyeXI4aDd1QWYvZmozRnFqdHFoamJUY2RUUDZQ?=
 =?utf-8?B?Vi9wc0x3U3BlY1g5bnZkV3pPZWpCTXIxZGl2WXNyRE5OemNHSFMyMDU2VUNQ?=
 =?utf-8?B?U1Jtamc2cExVMjNkdmgrQXU3R1U0WXFsUTZIVkJaRlVraGRMVnpLMG4yQ0lJ?=
 =?utf-8?B?RDRUWlZBakhNdXhIWU5tNTcvQnE1cHZCSDZYRkZkY1RrU1JjS3cyTDZmNm5v?=
 =?utf-8?B?d3dCMk10K3BGMG9KN21Nd0l6dEw1TXZ4d3pOUDBDaVl6Vlk1YTMrc1VINFBM?=
 =?utf-8?B?LzltUVNiYXdRcVZpN3ZaWndEWFNUY0VLVkdVWC83MHZCdDFpeDRYYktXRUdl?=
 =?utf-8?B?d3d5VWdBUmpRclZzMkR3MVVpM2ZNNDZTN1NtaUdRNGI4YTh5bGhxK1VUVlE1?=
 =?utf-8?B?WGZoUVhHeU4wVnVmb1FvMnBiQzJIeVJBdWRBQ3c2VW1BYmQ5bzh2aUYxMEZT?=
 =?utf-8?B?a291UGNOVGtrNUNpbEZrMHRud3pqZ3FaSGVoM1JBbnNOWW5vakh1VUpkSnE3?=
 =?utf-8?B?ZEdYMzJlS3NZUmxhVitDUmFGRUdVOHR6UVFVSFc4cCsxQi9qempLSXRvRFdI?=
 =?utf-8?B?SVRySGpseG1McWVQeXF1RmQ4NTdlQmVMS1Rxdk4rOU8yaEZydjk5VXcyelIv?=
 =?utf-8?B?dmh4YmNGK2trN1NPcHNvQXMwQ3JxWXBqbDZiNmpKVXF6L0RDUS95RWUwSHZQ?=
 =?utf-8?B?SDA0Q2c3bDVHTk45N0lna05JQkFDUXYwY0MwcEdaTVdua09DWG5MbkZWM2FG?=
 =?utf-8?B?WFQveFVRWXpKMlk4VVE1aGFtcUVIYndoNGF5ajVlemJUN01pVmRkZmpOSzRn?=
 =?utf-8?B?Y1MwdjVydW9RZTNzQmtZdmQzak55dlQrTVNWYXVQTVA2NERjeHBmdzdHR1lz?=
 =?utf-8?B?ZW05dHAwZ1FGNVFYN2FXRVdaQ2wrSUtYUmJqLzE1aXZmWEdRbENkV0ZlSzh1?=
 =?utf-8?B?dUpyaGNNOFV3OUFUellIb0g2K0IrR0xwbnBnU0ZJbzdEb0ZtMWZGUktNZkZR?=
 =?utf-8?B?VGpZM3lacDJKbmQ0cjhYTUcyeEpCOG84M3huakRvQlV3dEYveHRQZllKVC9l?=
 =?utf-8?B?ZC83RktBZ0JGMEVkQm1ac0JHTU95QUpNb0ZCYkM1ZlJOQTE2SWxnYWxOczVh?=
 =?utf-8?B?eEJSdmQrcW5UbEFFcENYN3RNMXl1WWU2dElWWERFVjdHY1IvbkNvUmc2RUlm?=
 =?utf-8?B?aEZJbmQzVEVKRzlCNy9uUFVzZm5VM1dNWmdmb2xKZGx1UUIvNXR2Skh2cFNR?=
 =?utf-8?B?WE1PWTNmQlRZNXpKNXc2UXZBbndBdDdDV1NrSFRMVC9aME1seWFWMTdyVnIr?=
 =?utf-8?B?MkhYaVBVN0VsM0xsVytieERqVDk0eUFNWFlYMWpMQkdmWmZPSnU3S3FOcDN4?=
 =?utf-8?B?b1JiU1J4bVRpbVJSVVNJMENFR2F6RVh2Ukd3OTZlaC9XY3hDdHVVT2p6Wlo4?=
 =?utf-8?B?NE9YTnRzNE53dGdoOGE1ZlZqcXpicGZ4VlhRdHZNN0M2NzFHUFdjU3gxb1dG?=
 =?utf-8?B?SUp2c2puZklMNVlPdmlNSjV5SC9xWE9IT1FWckRVVWVCbmVCVmVJRVJuRDly?=
 =?utf-8?B?S0UvMG5VOTc4VFMySzhDWHlOMW5MS0pNcklUM3BrdGdObDZTQnJIOVpTbXlz?=
 =?utf-8?B?MGttSTlRVUE5NTV5UHhHZW5CNG9zMnFTeDBtTFNST0FSUzBtd0MvdUNxS2t2?=
 =?utf-8?Q?oDAiH15tgJG0BFr7fW51mLvK7sAxE0xEtMu9q7h?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <18C8C6B630BA0C45BD621C841E749B06@namprd14.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a1cd00-0179-49ce-295e-08d95b8143ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 22:01:39.5541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jllMnnFgSfrSZSJplkqoPwXyTTlbBLdFjZFL+kAgu9O+C5jSu2MpMGcxKhJN2+18l55DwZ/YvK+vPDia/4gXtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB3407
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

eWVzLCBidXQgdGhlIHRpbWluZyBtYXkgYmUgZGlmZmVyZW50LiBXaGVuIGEgbmV3IGZpbGUgaXMg
Y3JlYXRlZCwgaW5vdGlmeSB3aWxsIHRlbGwgQU1QIGFib3V0IGl0LCBhbmQgQU1QIHdpbGwgaW1t
ZWRpYXRlbHkgcmVhZCBpdC4NCg0KPiBPbiBBdWcgOSwgMjAyMSwgYXQgNTo0OTozMCBQTSwgVGlt
b3RoeSBQZWFyc29uIDx0cGVhcnNvbkByYXB0b3JlbmdpbmVlcmluZy5jb20+IHdyb3RlOg0KPiAN
Cj4gSSdtIG5vdCBzdXJlIHRoYXQgaXMgbXVjaCBkaWZmZXJlbnQgdGhhbiB0aGUgbG9hZCBwYXR0
ZXJucyB3ZSBlbmQgdXAgZ2VuZXJhdGluZywgd2l0aCBtaXhlZCByZW1vdGUgYW5kIGxvY2FsIEkv
Ty4gIEknZCB0aGluayB0aGF0IHN1Y2ggYSBzY2VuYXJpbyBpcyBmYWlybHkgdHlwaWNhbCwgZXNw
ZWNpYWxseSB3aGVuIGZhY3RvcmluZyBpbiBiYWNrdXAgcHJvY2Vzc2VzLg0KPiANCj4gLS0tLS0g
T3JpZ2luYWwgTWVzc2FnZSAtLS0tLQ0KPj4gRnJvbTogImhlZHJpY2siIDxoZWRyaWNrQHJ1dGdl
cnMuZWR1Pg0KPj4gVG86ICJUaW1vdGh5IFBlYXJzb24iIDx0cGVhcnNvbkByYXB0b3JlbmdpbmVl
cmluZy5jb20+DQo+PiBDYzogIkouIEJydWNlIEZpZWxkcyIgPGJmaWVsZHNAZmllbGRzZXMub3Jn
PiwgIkNodWNrIExldmVyIiA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4sICJsaW51eC1uZnMiDQo+
PiA8bGludXgtbmZzQHZnZXIua2VybmVsLm9yZz4NCj4+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDks
IDIwMjEgMzo1NDoxNyBQTQ0KPj4gU3ViamVjdDogUmU6IENQVSBzdGFsbCwgZXZlbnR1YWwgaG9z
dCBoYW5nIHdpdGggQlRSRlMgKyBORlMgdW5kZXIgaGVhdnkgbG9hZA0KPiANCj4+IEkganVzdCBy
ZWFsaXplZCB0aGVyZeKAmXMgb25lIHRoaW5nIHlvdSBzaG91bGQga25vdy4gV2UgcnVuIENpc2Nv
4oCZcyBBTVAgZm9yDQo+PiBFbmRwb2ludHMgb24gdGhlIHNlcnZlci4gVGhlIGdvYWwgaXMgdG8g
ZGV0ZWN0IG1hbHdhcmUgdGhhdCBvdXIgdXNlcnMgbWlnaHQgcHV0DQo+PiBvbiB0aGUgZmlsZSBz
eXN0ZW0uIFR5cGljYWxseSBvbmUgaXMgd29ycmllZCBhYm91dCBtYWx3YXJlIGluc3RhbGxlZCBu
IGNsaWVudCwNCj4+IGJ1dCB3ZeKAmXJlIGNvbmNlcm5lZCB0aGF0IGRldmVsb3BlcnMgbWF5IGJl
IHVzaW5nIGphdmEgYW5kIHB5dGhvbiBsaWJyYXJpZXMgd2l0aA0KPj4ga25vd24gaXNzdWVzLCBh
bmQgdGhvc2Ugd2lsbCBjb21tb25seSBiZSBzdG9yZWQgb24gdGhlIHNlcnZlci4NCj4+IA0KPj4g
SWYgQU1QIGlzIGRvaW5nIGl0cyBqb2IsIGl0IHdpbGwgY2hlY2sgbW9zdCBuZXcgZmlsZXMuIEni
gJltIG5vdCBzdXJlIHdoZXRoZXIgdGhhdA0KPj4gY3JlYXRlcyBhdHlwaWNhbCB1c2FnZSBvciBu
b3QuDQo+PiANCj4+PiBPbiBBdWcgOSwgMjAyMSwgYXQgMjo1NjoxNSBQTSwgVGltb3RoeSBQZWFy
c29uIDx0cGVhcnNvbkByYXB0b3JlbmdpbmVlcmluZy5jb20+DQo+Pj4gd3JvdGU6DQo+Pj4gDQo+
Pj4gQ2FuIGNvbmZpcm0gLS0gc2FtZSBnZW5lcmFsIGJhY2t0cmFjZSBJIHNlbnQgaW4gZWFybGll
ci4NCj4+PiANCj4+PiBUaGF0IG1lYW5zIHRoZSBidWcgaXM6DQo+Pj4gMS4pIE5vdCBhcmNoaXRl
Y3R1cmUgc3BlY2lmaWMNCj4+PiAyLikgTm90IGZpbGVzeXN0ZW0gc3BlY2lmaWMNCj4+PiANCj4+
PiBJIHdhcyBvcmlnaW5hbGx5IGNvbmNlcm5lZCBpdCB3YXMgcmVsYXRlZCB0byBCVFJGUyBvciBQ
T1dFUi1zcGVjaWZpYywgZ29vZCB0bw0KPj4+IHNlZSBpdCBpcyBub3QuDQo+Pj4gDQo+Pj4gLS0t
LS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQ0KPj4+PiBGcm9tOiAiaGVkcmljayIgPGhlZHJpY2tA
cnV0Z2Vycy5lZHU+DQo+Pj4+IFRvOiAiSi4gQnJ1Y2UgRmllbGRzIiA8YmZpZWxkc0BmaWVsZHNl
cy5vcmc+DQo+Pj4+IENjOiAiVGltb3RoeSBQZWFyc29uIiA8dHBlYXJzb25AcmFwdG9yZW5naW5l
ZXJpbmcuY29tPiwgIkNodWNrIExldmVyIg0KPj4+PiA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4s
ICJsaW51eC1uZnMiDQo+Pj4+IDxsaW51eC1uZnNAdmdlci5rZXJuZWwub3JnPg0KPj4+PiBTZW50
OiBNb25kYXksIEF1Z3VzdCA5LCAyMDIxIDE6NTE6MDUgUE0NCj4+Pj4gU3ViamVjdDogUmU6IENQ
VSBzdGFsbCwgZXZlbnR1YWwgaG9zdCBoYW5nIHdpdGggQlRSRlMgKyBORlMgdW5kZXIgaGVhdnkg
bG9hZA0KPj4+IA0KPj4+PiBJIGhhdmUuIEkgd2FzIHRyeWluZyB0byBhdm9pZCBhIHJlYm9vdC4N
Cj4+Pj4gDQo+Pj4+IEJ5IHRoZSB3YXksIGFmdGVyIHRoZSBmaXJzdCBmYWlsdXJlLCBkdXJpbmcg
cmVib290LCBzeXNsb2cgc2hvd2VkIHRoZSBmb2xsb3dpbmcuDQo+Pj4+IEnigJltIHVuY2xlYXIg
d2hhdCBpdCBtZWFucywgYnUgdGl0IGxvb2tzIGlrZSBpdCBtaWdodCBiZSBmcm9tIHRoZSBmYWls
dXJlDQo+Pj4+IA0KPj4+PiANCj4+Pj4gDQo+Pj4+PiBPbiBBdWcgOSwgMjAyMSwgYXQgMjo0OSBQ
TSwgSi4gQnJ1Y2UgRmllbGRzIDxiZmllbGRzQGZpZWxkc2VzLm9yZz4gd3JvdGU6DQo+Pj4+PiAN
Cj4+Pj4+IE9uIE1vbiwgQXVnIDA5LCAyMDIxIGF0IDAyOjM4OjMzUE0gLTA0MDAsIGhlZHJpY2tA
cnV0Z2Vycy5lZHUgd3JvdGU6DQo+Pj4+Pj4gRG9lcyBzZXR0aW5nIC9wcm9jL3N5cy9mcy9sZWFz
ZXMtZW5hYmxlIHRvIDAgd29yayB3aGlsZSB0aGUgc3lzdGVtIGlzDQo+Pj4+Pj4gdXA/IEkgd2Fz
IGV4cGVjdGluZyB0byBzZWUgbHNsb2NrcyB8IGdyZXAgREVMRSB8IHdjIGdvIGRvd24uIEl04oCZ
cyBub3QuDQo+Pj4+Pj4gSXTigJlzIHN0YXlpbmcgYXJvdW5kIDE4NTAuDQo+Pj4+PiANCj4+Pj4+
IEFsbCBpdCBzaG91bGQgZG8gaXMgcHJldmVudCBnaXZpbmcgb3V0ICpuZXcqIGRlbGVnYXRpb25z
Lg0KPj4+Pj4gDQo+Pj4+PiBCZXN0IGlzIHRvIHNldCB0aGF0IHN5c2N0bCBvbiBzeXN0ZW0gc3Rh
cnR1cCBiZWZvcmUgbmZzZCBzdGFydHMuDQo+Pj4+PiANCj4+Pj4+Pj4gT24gQXVnIDksIDIwMjEs
IGF0IDI6MzAgUE0sIFRpbW90aHkgUGVhcnNvbg0KPj4+Pj4+PiA8dHBlYXJzb25AcmFwdG9yZW5n
aW5lZXJpbmcuY29tPiB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IEZXSVcgdGhhdCdzICpleGFj
dGx5KiB3aGF0IHdlIHNlZS4gIEV2ZW50dWFsbHksIGlmIHRoZSBzZXJ2ZXIgaXMNCj4+Pj4+Pj4g
bGVmdCBhbG9uZSBmb3IgZW5vdWdoIHRpbWUsIGV2ZW4gdGhlIGxvZ2luIHN5c3RlbSBzdG9wcyBy
ZXNwb25kaW5nDQo+Pj4+Pj4+IC0tIGl0J3MgYXMgaWYgdGhlIEkvTyBzdWJzeXN0ZW0gZGVncmFk
ZXMgYW5kIGV2ZW50dWFsbHkgYmxvY2tzDQo+Pj4+Pj4+IGVudGlyZWx5Lg0KPj4+Pj4gDQo+Pj4+
PiBUaGF0J3MgcHJldHR5IGNvbW1vbiBiZWhhdmlvciBhY3Jvc3MgYSB2YXJpZXR5IG9mIGtlcm5l
bCBidWdzLiAgU28gb24NCj4+Pj4+IGl0cyBvd24gaXQgZG9lc24ndCBtZWFuIHRoZSByb290IGNh
dXNlIGlzIHRoZSBzYW1lLg0KPj4+Pj4gDQo+Pj4+PiAtLWIuDQoNCg==
