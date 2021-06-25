Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602B43B476C
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Jun 2021 18:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhFYQah (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Jun 2021 12:30:37 -0400
Received: from mail-bn8nam11on2131.outbound.protection.outlook.com ([40.107.236.131]:19360
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230013AbhFYQag (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 25 Jun 2021 12:30:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+iyh1sHiqEHsW0aZewS4vh9CAvYrYPYhNHHzo7OOv6B7xT8pkp3nhwFvTdGHv4Ow20p0CnDJcKSYUCCQZJ4yABBmarwFmUfPvpik3/B9emjyVpszTpnObhDDXSvkOFKBGX0aDUDCMfIeWdiHrEon8t58HC4xUXoUo4H3uzhYSFp0905FMp49OLRacsLdg6LSvhnmRFyg9owgecfkHVOZ9lzCPs7ruOTtC0G1XpfU6RS8SeSd/i9iFWZp/MEnf+WbcSe96iN4zuB6+FzBA0bSUWuUvXEnT8Xo9TQBxWE5iuznL/vx5mOQUfNdwSbBwWCAo8J5mDFfF4FUHetOtUGQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jNWkp9m1hUf8fRWUxIKXoUSo8P2Ja99/feff+LcqJo=;
 b=M02E3AryTPjiQVRENw53i4ai/da6GRy+2MeoexkzezYlHhH3Vw9PFbrfuW2kH6OHNaWFnSg2n5dLNgi3U+lVHAjNyM5sH9QfV9lVxdarcytbumg3mS7gaSX2hTIVdsF2lu5WlVwOCtko7lOACwz/JxkEdu8nBLOI8jdO8KKSWWjEO2Mk1JCaINGe17DYQ626tzDmO08mbfLZv5vEtliinY1jlkWx8JkHtmFdLao2/6bgF63WfB0IHXV7OeYKj+XB5L4DK7vOFrK3XBaHkhBbmfIDJcK5gHS+XArweDoyhmJ7lBqUmDCV9TGsysw/Cz8HRYw4CfNa8XfElksR2enc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jNWkp9m1hUf8fRWUxIKXoUSo8P2Ja99/feff+LcqJo=;
 b=VdxLLGq6c3lZDN748cWqkMoWvoS5ZR2czhQpfnMLz+rVYfZZbr+eSbUEpS+HN3QCiBlA4IVBCE9vNvfvQP7X/LOgwcx7NRbDHqWenLoxEHityk55BMM+bRjnr84ypRIyA81ROrB8rjbwFaN5V7iI5NtIstw4bT2shEQK1DYiQJY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3317.namprd13.prod.outlook.com (2603:10b6:610:2d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7; Fri, 25 Jun
 2021 16:28:13 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05%4]) with mapi id 15.20.4264.021; Fri, 25 Jun 2021
 16:28:12 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Prevent a possible oops in the nfs_dirent()
 tracepoint
Thread-Topic: [PATCH] NFSD: Prevent a possible oops in the nfs_dirent()
 tracepoint
Thread-Index: AQHXadSSY72lgbY6MU6xHAIFBHV+9qsk6oSA
Date:   Fri, 25 Jun 2021 16:28:12 +0000
Message-ID: <b71c76c0fb21ebb35e1f91864bbb411a4c895370.camel@hammerspace.com>
References: <162463396907.1820.8112792283525036426.stgit@klimt.1015granger.net>
In-Reply-To: <162463396907.1820.8112792283525036426.stgit@klimt.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebd85fe5-5b4f-4900-4101-08d937f63a57
x-ms-traffictypediagnostic: CH2PR13MB3317:
x-microsoft-antispam-prvs: <CH2PR13MB331737349413398FC509CC2BB8069@CH2PR13MB3317.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxK6rt/6Nv2P+gS9PlHT2+HhP1mJ/dWJTPj+KaC2KaSma3g8FtGrdC22iZ0vYZoAwogxxBMCsYLjNk0qHvIbIW9zycRDsZizx6byLI8O1eCc/e6IPM5pXbEJ1TyLAXuy1p4KK+0H3lN01RoodITkKl8pyxd2KtqKuJlk5wm+0OFq2WZ/mJaDMXRF0NNumT67MuGf4z1ihgeHfD/y7Nz+qFNMtEpWe3mX/IHxxGE/1f/hl41cfpDzsIbO2gbQFQtl6R9Tytt/z6RRYAkrQ4sp0NWdvtBLviooJ65ynK7DWy8SLcNhDspU8/7u8ObXdYuQRj8Xe0jDIoUJEg/r+mGRqANdNepH8fMuQiWBEDsMELHbY1kUw7g6Mao/Va7z4lv2GonNeoMyGtPbqDpoMRDYrNUlLDxCwnjJwmb1p0feRYR6FaWCYmsxgZDqkhJU8Y3IjLGN2lCuGBY6SQZBH3JgoALYtL9vxJVFs37Y3DirT5e4xozIO2cfDHxJYhNeE39ZqwpLlAdgjgC4X68pDFsgBfG4KLEewgY4vvPef41iDSby1ZSkwf6qV6klo9O2FUR7qz3T1yWHBYBZqkrqKWYEB2+UDIc+TnBL9dffXdzJmJU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39830400003)(376002)(396003)(366004)(110136005)(86362001)(5660300002)(2906002)(6506007)(2616005)(71200400001)(8676002)(186003)(66556008)(64756008)(4326008)(6512007)(26005)(76116006)(66446008)(8936002)(83380400001)(36756003)(316002)(66946007)(122000001)(6486002)(478600001)(38100700002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkM1R3dDdFlnc3JiOEFtMC8rSXFtZHdsS3RBRENKNS9TSnIrY3JmNzFjdVpk?=
 =?utf-8?B?ZEUrV3NkcWd1bTBvaTdHM2pWWGZrckVucmN2dFVJUFBBWGJSUWxaVWdTOGly?=
 =?utf-8?B?RXA1UWFNOXQxWUJTU2F2L2RHMEhtZ2NuMXI5ckIwQlJyVnhKK3NONG9EMmNF?=
 =?utf-8?B?SFpWczYxVkgrUTQzbllKU3pRYk1XVkZieVNDUzE0R1c0VVlTb0VyV2R4WVZl?=
 =?utf-8?B?Q29TZ094Z1ZVcjFEb0JvT1BGaVUyZlpuMU4yWjAyUGlwT2ZBUFAxdGpjdDNz?=
 =?utf-8?B?ODljL24xcEpGODVZUUNrSFlaOHZjN0hCYWRPcURtRnliU2JjOVlpOENJNXpq?=
 =?utf-8?B?VjY4bU0yQTZmd1h0MVgvbnZSTlR0aDV3UnduZi9YM09mWENiYzY1TFJ1anVk?=
 =?utf-8?B?ck9senBOSU1SWEU2ZldMd0FpVkhwRGhqWVRINVZvZlBxZ2hKZlhxRUlEZldt?=
 =?utf-8?B?UjlQbVltMGRkVGMwMlpwTEpVZTE4RW5pYTFwSjhqTEFoeHZ4RUJYRW1EZzE0?=
 =?utf-8?B?QWJVcnlHZjZrL2F5TnR1NWhxU24rSkpWeWVSL3NuSVdvaXJhdHU5TGxoMCtD?=
 =?utf-8?B?N3RsYllsSlg0RlRBM2xOSEN0RHVMUUxxZTdJYjhtUExCZFJxNmVFcVV5RmEx?=
 =?utf-8?B?eXVtNldrVVFHM3F2Y1hWdGxpZS9LYTFYZ1AwNUlFQm14bDNubGNoQWRRR0NY?=
 =?utf-8?B?VmR6VzkxcHhlaXBvYUs3NnFvcTBhNmhWb0FqNDhwZi9YSnFWcEdxNU5zVGVC?=
 =?utf-8?B?dTMyMXFIcGlZRC9CaCt4TG1HY2tPMjJyTjFoQ3c2YkR0SlpwSXZMalZ6SVNE?=
 =?utf-8?B?bUoxK1pJVk94TThRK01jeW9rd2xVa1VKSWE2TGFLeTF0YitFTVcyTnBkV2t5?=
 =?utf-8?B?aGwrVjZBYWtpZ2dqUEE3Sm8vQUpIb1ZHaVBqd0pVQlRrS3FUR1pKdGoySUJM?=
 =?utf-8?B?a2kwc2xsa2pNZmFRY08yOTBUbWt5OHRINTQvQVFmL0pWUUd2dlFjcHNKdnYx?=
 =?utf-8?B?TVI3U0gzVlRkbjhpK2d2OTZiN041UlI1dXpnRTZSQVZDNkp2TnpiWTJZUG9P?=
 =?utf-8?B?MjNBVWxKcWpydmFyaVlhZDB0THhLWm9aMVVGUVo5eTJ6ZVRRbmt2TStrb0lN?=
 =?utf-8?B?YTlDYzg1Zm5LRzg2V2xGSXFTS2RYNm1xRENYdjNlY2UzS01IK2F4bStoTnNp?=
 =?utf-8?B?ajRLdVJXSEhqKzQxcGg3T3ZYRHQ1YzJtUC9JMHJ6bnR4eVcwSzM3RFd4K2pm?=
 =?utf-8?B?R3gxZ1FuZjFZa2xad0t1bGtpZ24yakM5MHBINktVUXAwbEZWd2o0aStMR1R6?=
 =?utf-8?B?WU9PbkxXKzdrMGovWDhsMEw1YzZ6eVVrUk1aalNWaDRrdmowVHZPUEtJTkY0?=
 =?utf-8?B?RGdqSTNWcys5NEV2UTBpUmZMUFdDVENkeUpqaktQMjUvaDRLNG1PLzZjcXhF?=
 =?utf-8?B?VGZRS2xVVDl6RTNIaWNIc0VZNGN2eWQrRmtkT0FBajNHdHE0S2JuNFdCVkxt?=
 =?utf-8?B?ZmhDeGVkYTJIZVFNdEl4QWlLSGNHTDh1QTJzSU9VT2N3VzV4MytlQTkwQU8y?=
 =?utf-8?B?by9YYm5jNlZKYVNiSjJQNzdvcUNSV05aSkRxN2xhZnVyNWdlMG5YbzI4V2hu?=
 =?utf-8?B?SGo3RmQxeXlZbzhHVzFiM3dRWmNSU2dXVnJSVWdJV0dUbTR4dmwvTmsyNk5p?=
 =?utf-8?B?S2szb3RhNWxzajBXVnhvdU5ZQU84UUpEL1ZmaFBHRnRGM25hT1NxRmpiOURH?=
 =?utf-8?Q?gpAmFk2LkL/JaML2G48igf3WaOIXTucztJSYIV1?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8103B4B187247E4D9B85E8AA9751211B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd85fe5-5b4f-4900-4101-08d937f63a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 16:28:12.8561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: evEf2PFdLygpveN3aH3kRt3Y6ced+chKC4CyRm4eeugoifdFnsV0YXDnq995+ik8EDGkkyhODin/qJppkKgZqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3317
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTA2LTI1IGF0IDExOjEyIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
VGhlIGRvdWJsZSBjb3B5IG9mIHRoZSBzdHJpbmcgaXMgYSBtaXN0YWtlLCBwbHVzIF9fYXNzaWdu
X3N0cigpDQo+IHVzZXMgc3RybGVuKCksIHdoaWNoIGlzIHdyb25nIHRvIGRvIG9uIGEgc3RyaW5n
IHRoYXQgaXNuJ3QNCj4gZ3VhcmFudGVlZCB0byBiZSBOVUwtdGVybWluYXRlZC4NCj4gDQo+IEZp
eGVzOiA2MDE5Y2UwNzQyY2EgKCJORlNEOiBBZGQgYSB0cmFjZXBvaW50IHRvIHJlY29yZCBkaXJl
Y3RvcnkNCj4gZW50cnkgZW5jb2RpbmciKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8
Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4gLS0tDQo+IMKgZnMvbmZzZC90cmFjZS5oIHzCoMKg
wqAgMSAtDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9mcy9uZnNkL3RyYWNlLmggYi9mcy9uZnNkL3RyYWNlLmgNCj4gaW5kZXggMjdhOTNlYmQx
ZDgwLi44OWRjY2NlZDUyNmEgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mc2QvdHJhY2UuaA0KPiArKysg
Yi9mcy9uZnNkL3RyYWNlLmgNCj4gQEAgLTQwOCw3ICs0MDgsNiBAQCBUUkFDRV9FVkVOVChuZnNk
X2RpcmVudCwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX2VudHJ5LT5pbm8g
PSBpbm87DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX19lbnRyeS0+bGVuID0g
bmFtbGVuOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1lbWNweShfX2dldF9z
dHIobmFtZSksIG5hbWUsIG5hbWxlbik7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBfX2Fzc2lnbl9zdHIobmFtZSwgbmFtZSk7DQo+IMKgwqDCoMKgwqDCoMKgwqApLA0KPiDCoMKg
wqDCoMKgwqDCoMKgVFBfcHJpbnRrKCJmaF9oYXNoPTB4JTA4eCBpbm89JWxsdSBuYW1lPSUuKnMi
LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fZW50cnktPmZoX2hhc2gsIF9f
ZW50cnktPmlubywNCj4gDQo+IA0KDQpXaHkgbm90IGp1c3Qgc3RvcmUgaXQgYXMgYSBOVUwgdGVy
bWluYXRlZCBzdHJpbmcgYW5kIHNhdmUgYSBmZXcgYnl0ZXMNCmJ5IGdldHRpbmcgcmlkIG9mIHRo
ZSBpbnRlZ2VyLXNpemVkIHN0b3JhZ2Ugb2YgdGhlIGxlbmd0aD8NCg0KLS0gDQpUcm9uZCBNeWts
ZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
