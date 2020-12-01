Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D092C958F
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 04:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgLADHq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 22:07:46 -0500
Received: from mail-bn8nam12on2137.outbound.protection.outlook.com ([40.107.237.137]:45536
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725859AbgLADHn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Nov 2020 22:07:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DR1KoYqZqvLTS3F14prfw85erQb1SaVPoRIgarMnhqgxNhPx+RHzIcmuNIBoz8PVPbI5eq8i6CtWvuhGHyuh1tnJcfAX/MqDjJWv132aXRTdaqEq67cE67I3aQP6gN5G2K8twKSy774l+ICUWZlyi0xeXMV8FS2q/mdI2VVeccOixMu9nuLZy0/NBp/uoMcjTsMTyn1zeyOMsmSpZ+45PVKqlNeN3c6nICs2O6vBxzVveHUP/OL4fNY6o9scLeSkTWZQSBr2bhPI18N2vAS4NIWpsJSy9hE+swIG0BoFMfEuJqnX+MvWCMtaBMfsmLQU5iIZ++2/EqeUozJ5qHWXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FogPtdIkYeKma5ZQrbbcupp39q7cUz1nB/pBHhvyCVo=;
 b=M+S8REqnaOmBAs9Lxv9w20jQIQP/fXFBTn6EdYH2BVGu5xH9JOlQ9Y4bV4TbWBnbrBHDV2K7i5npJmhk4H1CzQI7O3foROgZYUkRwFnKFRDAOD1/5+PHO0an3T/gFaN+9dvQpTArKg+fSE86HVq+i3ZC9t3j9r6hlUsNSj+tGk/tBahfDA6KccVkkRsfqauRcbZLOuC8EGn9NiY802qCCEvRgqJJws9cjvwT2AfDw6wblGJH16nlqfZPpvf8byUrkDpWWKY3SIt7boxuXaiziF/xKypD/5DgWoXyCWe06N/uhtsnZ+lkdR/uINKWkLSlMbKXcu1xrM+mND9U1Q7Kfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FogPtdIkYeKma5ZQrbbcupp39q7cUz1nB/pBHhvyCVo=;
 b=Js1NICBJZvnNOrhMnz1YRc/G30s5tTxcebWb+RhA9LQGVJhbImiRB2K/fXkHGhsOH0G9+eAVXqFkgemufFq+n5oXNpmzS6iuGrJgG1Suft0TIEuqXm8isTQQDLVHRx2x+XObMmLB61GFDceBdI0/jVyv5pNlzbkQO7HheMM5V/Y=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB4038.namprd13.prod.outlook.com (2603:10b6:208:26a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6; Tue, 1 Dec
 2020 03:06:47 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Tue, 1 Dec 2020
 03:06:47 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@redhat.com" <bfields@redhat.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Thread-Topic: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Thread-Index: AQHWx1999UsH3Pym/kCB2OnbCNS3q6nhSfMAgAAdxACAABzfAIAACquA
Date:   Tue, 1 Dec 2020 03:06:46 +0000
Message-ID: <66f93208c6edf2dad70ee41c349c5130b30b8ed4.camel@hammerspace.com>
References: <20201130212455.254469-1-trondmy@kernel.org>
         <20201130212455.254469-2-trondmy@kernel.org>
         <20201130225842.GA22446@fieldses.org>
         <1b525278a9a7541529290588a83852a0754cee3e.camel@hammerspace.com>
         <20201201022834.GA241188@pick.fieldses.org>
In-Reply-To: <20201201022834.GA241188@pick.fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d10d8626-2a25-4fc1-bf50-08d895a623c3
x-ms-traffictypediagnostic: MN2PR13MB4038:
x-microsoft-antispam-prvs: <MN2PR13MB4038A06FFCC44CEF9B62242BB8F40@MN2PR13MB4038.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: McvWIeBzZXdu9GSm6TqdBwu8g1oa8Zvg3486MFlzfObf0w1CA/N64K/q5odEBBe1dBpZ/40RqUecnONlWw5EmG4e644VccrGE+cSP/k3QpqUQ6Vp8+XRyBHXkw5Y1VARQj9OSKb/2xiDtTK7UVG15ZMFhwP6fcOXB8HQt8RrwZbE77R4DRHiaOIZHv7/J1OJ0qAQMui5kRdWgpfVA8iax8vaXfP1P83qo8VyeUN3g+yz0mOjWc5kry+qLZWjlgyWoBivVa0iKWXF5Y2bsn1yALvw6/BmoYZ7FLWixe1mL4i8H2m7863cg77HVfXoa96otzFnwlJV9GFKbnKReBHrvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39840400004)(346002)(376002)(4001150100001)(66446008)(64756008)(186003)(66556008)(86362001)(66476007)(316002)(91956017)(66946007)(76116006)(26005)(36756003)(2616005)(4326008)(5660300002)(6486002)(6916009)(54906003)(8676002)(83380400001)(6506007)(478600001)(8936002)(71200400001)(6512007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cWZIdUdQbGxxRFVEYkxEYkJNbEt6UmRoWnBUZjRpM242Wk9wVjg4cFFpSjBT?=
 =?utf-8?B?NTdQbWpraFVVNWJqV2NHMzdNZ3llM1hHdU16c0owTExqOHhmREh0RUdLSFhy?=
 =?utf-8?B?ZW9wQTJSYnc0cjNtWTM4ZVRadFFiNXZzTWlDUTFYTi80dEE1eVpjVVhjUVpF?=
 =?utf-8?B?bklVbGovV2ZJVjJnMkJRcDZIYXZ1RkY2K2p0UHZoSlZvRE5RekVNR2xMRkFl?=
 =?utf-8?B?ckdobThhOTBHd0xIU3cwbTlHbVFhQVFFR2d5TVJhNE5KZlBhRWd1WEtDWUxO?=
 =?utf-8?B?d1ZYYkd0UVVrY1F0OGUyM00zOWQxWEhMbzRtWXNFdm8raEhQNnZBRzhCcmRF?=
 =?utf-8?B?S3d2emJqUXEvNW51OVdRSXdsSDVuS203RTFxR01XV2RNTE9hWXV1OFArbmhM?=
 =?utf-8?B?UWxNcXZKTlVuV0xaanp0MDRJaWw2dlV5UllMRnVRRFdaQmRoQWZQOU1qdWoz?=
 =?utf-8?B?TXFuUEdvV1R1cnZUM0w2Um12Z285Sk8yNm8vN25HT2M4b2dZSDhiQXYvclpB?=
 =?utf-8?B?SmdyWmRaMHdORDRWUFB6WDZFVUQ2SW5NWnpZTnVia2dYL2ZpNVE3NG1QTzR2?=
 =?utf-8?B?amJRK0lYWndMM1RVZEc2QURqOTFoK2JLNTQ3RUFFVGh3U3VvdlJDdS9nSU1C?=
 =?utf-8?B?VC9BQ08xV3J4dTdIZ3RvcXQ5QmhCaGdXRmZYYzRWL1FXZTFFci82dFV5ZW0w?=
 =?utf-8?B?R2tYRW1GYlIwK2RMRFZoOWZtMFdzMlNydEVBVGk4NUs1N29rMGJkNHFMRHJq?=
 =?utf-8?B?Y05VWnVsT2FvT2xFMzM0bDdJS0h6c0wxMjlCaXQvSnNRSzlTbmxGNTJvaFM3?=
 =?utf-8?B?VjhqNVNyTW1zTm82S0pYSGFucHJicFkvaWp1TU5SMU5hWkxlc3prNTdla29m?=
 =?utf-8?B?QmdyOFpaak13dWU4SC9lZ2QzWW1Ed1VlU2tqd2hYbUtNU1kyNU9xeSt1YXpo?=
 =?utf-8?B?SlQ4RUF2R1NqUUsrUmJtMW9LZlQ1dUFZZkd1WW5XK1RDbVRYY2tRWWhlV2RV?=
 =?utf-8?B?RmNUbkNwUmNyZzFmaVlORW16TEFmWUZBYkwxcStaSnZNV3NnSVFTNDJnRFZT?=
 =?utf-8?B?bjNCVWJJdTJlSEJ2aS92MUZHV2tHaUZ1N1NKeG9Xd1VHK2VxNFp5dXd0SVIx?=
 =?utf-8?B?Tm5HaER2WlVEWDBDWkdyeTZ5SmVxbmM4a2UvTmp1L2lHejRteHRDTWx0TGh6?=
 =?utf-8?B?T0ZUYjZiUEQ3dDBleE00TS9ITERNdmRyQ1lxZUxVNGY4Qm40bWx6YVNDSlNV?=
 =?utf-8?B?ZW5Hak13ZVFId3ptT28zMVJxeW5oZUJtSE5LaktuQVpLSjJqQUIzYTF5dFVl?=
 =?utf-8?Q?nOFbGvAI1DqZQQhZY/dihJnHr9xsbBxRKF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A7A1924D73FDC4696D68756FBDFC310@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10d8626-2a25-4fc1-bf50-08d895a623c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 03:06:46.7646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdmuyaUXbGao4795qGL9coOVaZQdK1MRmj+ZJExouuHkJqH6LkgdY10P+B9k+GUOonMiFXcRvLfT4pPmBHEx4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4038
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTMwIGF0IDIxOjI4IC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFR1ZSwgRGVjIDAxLCAyMDIwIGF0IDEyOjQ1OjE2QU0gKzAwMDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjAtMTEtMzAgYXQgMTc6NTggLTA1MDAsIEouIEJy
dWNlIEZpZWxkcyB3cm90ZToNCj4gPiA+IFRoaXMgaXMgZ3JlYXQsIHRoYW5rczoNCj4gPiA+IA0K
PiA+ID4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMDQ6MjQ6NTBQTSAtMDUwMCwNCj4gPiA+IHRy
b25kbXlAa2VybmVsLm9yZ8Kgd3JvdGU6DQo+ID4gPiA+IEZyb206IEplZmYgTGF5dG9uIDxqZWZm
LmxheXRvbkBwcmltYXJ5ZGF0YS5jb20+DQo+ID4gPiA+IA0KPiA+ID4gPiBXaXRoIE5GU3YzIG5m
c2Qgd2lsbCBhbHdheXMgYXR0ZW1wdCB0byBzZW5kIGFsb25nIFdDQyBkYXRhIHRvDQo+ID4gPiA+
IHRoZQ0KPiA+ID4gPiBjbGllbnQuIFRoaXMgZ2VuZXJhbGx5IGludm9sdmVzIHNhdmluZyBvZmYg
dGhlIGluLWNvcmUgaW5vZGUNCj4gPiA+ID4gaW5mb3JtYXRpb24NCj4gPiA+ID4gcHJpb3IgdG8g
ZG9pbmcgdGhlIG9wZXJhdGlvbiBvbiB0aGUgZ2l2ZW4gZmlsZWhhbmRsZSwgYW5kIHRoZW4NCj4g
PiA+ID4gaXNzdWluZyBhDQo+ID4gPiA+IHZmc19nZXRhdHRyIHRvIGl0IGFmdGVyIHRoZSBvcC4N
Cj4gPiA+ID4gDQo+ID4gPiA+IFNvbWUgZmlsZXN5c3RlbXMgKHBhcnRpY3VsYXJseSBjbHVzdGVy
ZWQgb3IgbmV0d29ya2VkIG9uZXMpDQo+ID4gPiA+IGhhdmUgYW4NCj4gPiA+ID4gZXhwZW5zaXZl
IC0+Z2V0YXR0ciBpbm9kZSBvcGVyYXRpb24uIEF0b21pY2l0aXkgaXMgYWxzbyBvZnRlbg0KPiA+
ID4gPiBkaWZmaWN1bHQNCj4gPiA+ID4gb3IgaW1wb3NzaWJsZSB0byBndWFyYW50ZWUgb24gc3Vj
aCBmaWxlc3lzdGVtcy4gRm9yIHRob3NlLA0KPiA+ID4gPiB3ZSdyZQ0KPiA+ID4gPiBiZXN0DQo+
ID4gPiA+IG9mZiBub3QgdHJ5aW5nIHRvIHByb3ZpZGUgV0NDIGluZm9ybWF0aW9uIHRvIHRoZSBj
bGllbnQgYXQgYWxsLA0KPiA+ID4gPiBhbmQNCj4gPiA+ID4gdG8NCj4gPiA+ID4gc2ltcGx5IGFs
bG93IGl0IHRvIHBvbGwgZm9yIHRoYXQgaW5mb3JtYXRpb24gYXMgbmVlZGVkIHdpdGggYQ0KPiA+
ID4gPiBHRVRBVFRSDQo+ID4gPiA+IFJQQy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgcGF0Y2gg
YWRkcyBhIG5ldyBmbGFncyBmaWVsZCB0byBzdHJ1Y3QgZXhwb3J0X29wZXJhdGlvbnMsDQo+ID4g
PiA+IGFuZA0KPiA+ID4gPiBkZWZpbmVzIGEgbmV3IEVYUE9SVF9PUF9OT1dDQyBmbGFnIHRoYXQg
ZmlsZXN5c3RlbXMgY2FuIHVzZSB0bw0KPiA+ID4gPiBpbmRpY2F0ZQ0KPiA+ID4gPiB0aGF0IG5m
c2Qgc2hvdWxkIG5vdCBhdHRlbXB0IHRvIHByb3ZpZGUgV0NDIGluZm8gaW4gTkZTdjMNCj4gPiA+
ID4gcmVwbGllcy4NCj4gPiA+ID4gSXQNCj4gPiA+ID4gYWxzbyBhZGRzIGEgYmx1cmIgYWJvdXQg
dGhlIG5ldyBmbGFncyBmaWVsZCBhbmQgZmxhZyB0byB0aGUNCj4gPiA+ID4gZXhwb3J0aW5nDQo+
ID4gPiA+IGRvY3VtZW50YXRpb24uDQo+ID4gPiANCj4gPiA+IEluIHRoZSB2NCBjYXNlIEkgdGhp
bmsgaXQgc2hvdWxkIGFsc28gdHVybiBvZmYgdGhlICJhdG9taWMiIGZsYWcNCj4gPiA+IGluDQo+
ID4gPiB0aGUNCj4gPiA+IGNoYW5nZV9pbmZvNCBzdHJ1Y3R1cmUgdGhhdCdzIHJldHVybmVkIGJ5
IHNvbWUgb3BlcmF0aW9ucy4NCj4gPiA+IA0KPiA+IA0KPiA+IFRvIGFuc3dlciB0aGlzIGNvbW1l
bnQgKHdoaWNoIEkgbWlzc2VkIGVhcmxpZXIpOiBJIGRvbid0IGtub3cgdGhhdA0KPiA+IHdlDQo+
ID4gY2FuIHR1cm4gb2ZmIFdDQyBmb3IgTkZTdjQuIFRoZSBHRVRBVFRSIGlzIGEgY29tcGxldGVs
eSBzZXBhcmF0ZQ0KPiA+IG9wZXJhdGlvbiwgc28gdGhlIHNlcnZlciB3b3VsZCBoYXZlIHRvIHNl
Y29uZC1ndWVzcyB3aGF0IHRoZSBjbGllbnQNCj4gPiBuZWVkcyBpdCBmb3IgaW4gb3JkZXIgdG8g
b3B0aW1pc2UgaXQgYXdheS4NCj4gDQo+IEluIHRoZSB2NCBjYXNlLCB3ZSdyZSBzZXR0aW5nIHRo
ZSAiYXRvbWljIiBmaWVsZCBpbiB0aGUgY2hhbmdlX2luZm80DQo+IHN0cnVjdCB0byB0cnVlIGV2
ZW4gdGhvdWdoIHRoZSByZXR1cm5lZCBjaGFuZ2VhdHRycyBjbGVhcmx5IGFyZW4ndA0KPiBhdG9t
aWMgd2l0aCB0aGUgb3BlcmF0aW9uIGluIHRoZSByZS1leHBvcnQgY2FzZS4NCj4gDQo+IFRoYXQg
YXRvbWljIGZpZWxkIGlzIGluaXRpYWxpemVkIGZyb20gZmhfcG9zdF9zYXZlZCwgc28gd2UganVz
dCBuZWVkDQo+IHRvDQo+IHNldCBpdCB0byBmYWxzZSBpbiB0aGUgdjQgY2FzZSBhcyB3ZSBhcmUg
aW4gdGhlIHYzIGNhc2UgYWxyZWFkeS4NCj4gDQo+IFllcywgaXQncyB0cnVlLCB0aGF0IGRvZXNu
J3QgYWxsb3cgYW55IG9wdGltaXphdGlvbnMgYmVjYXVzZSB3ZSBzdGlsbA0KPiBoYXZlIHRvIGdl
dCB0aGUgcG9zdC1vcCBjaGFuZ2UgYXR0cmlidXRlcy4NCj4gDQo+IEJ1dCBpdCdzIGEgYnVnIHdl
IG1heSBhcyB3ZWxsIGZpeCB3aGlsZSB3ZSdyZSBoZXJlLCBhbmQgaXQgcHJvYmFibHkNCj4gc2lt
cGxpZmllcyB0aGlzIHBhdGNoIGlmIGFueXRoaW5nLi4uLg0KDQpJJ2QgYXJndWUgdGhhdCBpcyBh
IGNvbXBsZXRlbHkgc2VwYXJhdGUgaXNzdWUuIFRoaXMgaXMgYW4gb3B0aW1pc2F0aW9uDQpmb3Ig
TkZTdjMsIHdoZXJlYXMgd2hhdCB5b3UncmUgdGFsa2luZyBhYm91dCBpcyBhdG9taWNpdHkgKHdo
ZXRoZXIgaW4NCmdlbmVyYWwgb3IgZm9yIE5GU3Y0IG9ubHkpLiBJJ2QgdGhlcmVmb3JlIHByZWZl
ciB0byBtYWtlIHRoYXQgYQ0KY29tcGxldGVseSBzZXBhcmF0ZSBleHBvcnQgZmxhZyBzbyB0aGF0
IGl0IGNhbiBiZSB0cmVhdGVkIGFzIHNlcGFyYXRlDQpmdW5jdGlvbmFsaXR5Lg0KDQpBIGxvY2Fs
IGZpbGVzeXN0ZW0gbWlnaHQgY2hvb3NlIHRvIHNldCB0aGUgJ25vbi1hdG9taWMnIGZsYWcgd2l0
aG91dA0Kd2FudGluZyB0byB0dXJuIG9mZiBORlN2MyBXQ0MgYXR0cmlidXRlcy4gWWVzLCB0aGUg
bGF0dGVyIGFyZSBhc3N1bWVkDQp0byBiZSBhdG9taWMsIGJ1dCBhIG51bWJlciBvZiBjb21tZXJj
aWFsIHNlcnZlcnMgZG8gYWJ1c2UgdGhhdA0KYXNzdW1wdGlvbiBpbiBwcmFjdGljZS4NCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
