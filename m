Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437062EFB78
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Jan 2021 23:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbhAHWzp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Jan 2021 17:55:45 -0500
Received: from mail-co1nam11on2121.outbound.protection.outlook.com ([40.107.220.121]:45516
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbhAHWzo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 8 Jan 2021 17:55:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyPSxiwg8rceIxb3ZJs6ReDiwmyPXmBS+B79VYiYOu+89vpdDiwzO+ZbYi5HuxJchLUy4TqCLPbBUorlNsXlCwvns3Y53VyivWPAKf1hP0bszfBMqqJfNTaj/FBzP7xGTMCx1lp/XlNaRv44yk+YRGA+z1KQbl6PxJ7NBMRP48sbMutOpx1IXYYfqO4gGEPW66CCLR1tkbGsxcAi85I9pPTq5UikT+lwoJ/k3S3pZ+N6UksjU6w1n8Hmcumo3i9eo3AsYkg7n1WJoFTBN1LQ3ch20uwhioe+yvv/BZJdtXiRMGw4f4nx/RLokJGLBgV/fcOO7T8/zHFgM0WOU9POFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVgEI+ieZkQHOYhIgaOdc/4ffnLGikbGCwe5h00fUtY=;
 b=BYFPhxUrHOpJkHNFsFZIKUVV28FgImcvsk3xxoONU2CAqnMdgaEA/KzHG/wRPIZePejKxuwIUZ5F2+0+/ZBNAM34isUC6w437l+daWgsUqIWqnSnK97FndX6F4Usl43B/zPS488WZODwWu6ZVNO9473bSds2JvgehZxCOv0xib/wsqkeZJI/43U8FT4DErRR/CbvCElDfVyB+kUuiFOr/9HB0p2bFHRYo43YSk00kRYvxnbknd271G5nF3PLK60E9//dH4LGDyLAJ4Z3nz5aX3ehesB80gNTDn9d5S8T7wKayaK2xxRB50TEMdgOuEnDu8bsUM37Z7DcFo4KsnNztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVgEI+ieZkQHOYhIgaOdc/4ffnLGikbGCwe5h00fUtY=;
 b=SmTKrCbVFUG1Q55NIwe2H7g8LBZg9vkbhgH1tkpKYUr6+Jz3Ui4YG2iQuRd/oyQIjtiDEkJUe1pg7h1NMT0s/nvdt+t/sXXOCrSoiQLvmQO2MFtlTo+RH2fNK1WM880HoVEFuEC3n5yWVPvthBmSYmGf93dCMIoIYWxqtMjBz48=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3735.namprd13.prod.outlook.com (2603:10b6:610:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.3; Fri, 8 Jan
 2021 22:54:50 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f9a6:6c23:4015:b7fc]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f9a6:6c23:4015:b7fc%6]) with mapi id 15.20.3763.004; Fri, 8 Jan 2021
 22:54:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 00/42] Update NFSD XDR functions
Thread-Topic: [PATCH v1 00/42] Update NFSD XDR functions
Thread-Index: AQHW43fKB1OYuGq7GEaxumlcnQjaYaodEswAgADSJoCAAACPgIAAASQAgAABi4CAAAmBAIAAGdEAgABQFQA=
Date:   Fri, 8 Jan 2021 22:54:50 +0000
Message-ID: <6c36769a8e9e47cdd26e3f818917401ba69ff390.camel@hammerspace.com>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
         <20210108031800.GA13604@fieldses.org>
         <FDB7EF17-AD34-4CB5-824D-0DB2F5FA6F6A@oracle.com>
         <20210108155209.GC4183@fieldses.org>
         <FE877FEA-2A2E-4558-9B95-64116804E924@oracle.com>
         <20210108160145.GD4183@fieldses.org>
         <cf8329455c84c2efb76e3824b1639889ea22d716.camel@hammerspace.com>
         <20210108180810.GA10654@fieldses.org>
In-Reply-To: <20210108180810.GA10654@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 072f532c-eb3d-4d57-ad9c-08d8b42867c6
x-ms-traffictypediagnostic: CH2PR13MB3735:
x-microsoft-antispam-prvs: <CH2PR13MB37354985543F4082F876D8B2B8AE0@CH2PR13MB3735.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IaLtF/m+cR3F7VdE/y0ctBxAawzKWJkcC4TZlvr3gTGBYGW4NQ7blV5yFBBTRzo6NAt8KT2ohXFQNb0DVmXS7TCGcSsp2eLRGRSyPMcP9wkijGntMxxH15HHXGQsd7xkXKNrKs0DuOPFxVrdtRC0KhSTEmWmUkueBGxNDgy4DNllI7YXsiFxTBT5mhSkExj0tQrE2aU5AexYCBMTM6c+5KrKmRy1crEM8nztHHhXPUZ1PB1bj/vdLXxNUbVpPsaMIqC9pE3NWEmnFNkx1TKleCL7wU5GvYBIM5xrsXJxpLYvpcCVSRg4sgnmKAJXtuvma2K8k7cFzLPOVXNCXq6Lg9JzjpS8v7Pn1SpPBRBBW0m6s7WLXbC6/0hEJDLLoLrHiB3l74h3/BWm/vmdZZnnwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39840400004)(376002)(136003)(366004)(396003)(8936002)(71200400001)(6506007)(316002)(5660300002)(478600001)(4326008)(6486002)(26005)(6512007)(8676002)(66446008)(66556008)(2906002)(66476007)(186003)(2616005)(64756008)(86362001)(76116006)(54906003)(6916009)(36756003)(83380400001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SFFTZThBbWdOSzV2MzB0L0l3S1AreldNVkJIaXMrWTNiZjdWTXN4aDJuRExH?=
 =?utf-8?B?KzgzbWtmZmdUY3BqK3dLci9hbk9jRXd4aTlIdW5LRnVaVUtQM2hzV0NETkZG?=
 =?utf-8?B?QWt6Z1NGcXFvT3pnbVZCbElMYlRHWHRVTnNPYWVETE9wU1g4K0MremxhUnZa?=
 =?utf-8?B?cTBsejVZSENGQWJ2WkJTTlNDS2VBQzN3VlNtaUN1RFZRN2Nrekk4RlladDll?=
 =?utf-8?B?ckgrUG9KRzJKUXdwbi9oaFRjZzNHdlovTmVOYjBERFZEdlZNUzlTbHZ6c2o0?=
 =?utf-8?B?YklCeXBoSHpIQ21yYU5XUXROTDBTZ09hdEN1clFVWmpHc3JuV3FGNGdrQUp5?=
 =?utf-8?B?c2NjbEI2eVVVZWRBa0JPU3VmYzdjd1lIc0QxMy93bXQvZm9tQ2d0eEwrM1Ux?=
 =?utf-8?B?U3QyZVpnNWdES2djRFlreUFsTURwYzIybVVTdjlkZHlxVE5HaEdyOXFqTm1o?=
 =?utf-8?B?aTQ0NkFFY2hrZG1Za1ZER0F1TGFCWEF1ZEZJcW1rRVU0UUozSjYrTDYrUFdk?=
 =?utf-8?B?bndNYnkwYkNab1EwWU1lZXI1YThmRlN1VG5GcDBLSkJHMTBJQm1sRnN1ZWNC?=
 =?utf-8?B?bnJXaUtDQWFvOGY5TVh4bGRWQVIzalQwUEJXaktuNWFZN3lpLzlmRmhlS3hW?=
 =?utf-8?B?VG9Ec1JocDVxMzA3YVFkZytHQWRGRzNTZXFJNlZsSzgybHZyQnJ6M240QWsx?=
 =?utf-8?B?UTBGTHhPSm9rU1N6Qm5qWjJTVXEzYURsTXVJWCtXY0tpVDdBbzNzRnNHbmlJ?=
 =?utf-8?B?SG4xaWV1U0kveFU2Wkt3ZEVCbVc4N3IxalBsZzAzVThpSEtud3NCcHVtVVRW?=
 =?utf-8?B?c1JIdDBXSHhENUxsMDlaVzh4aHM1TUQ4QlkwR1FoVjUxYzNBcTNNcnlia3ZS?=
 =?utf-8?B?RVd2bm5LenU3NisveFRGanlBZzdDRzdvQ0NxNGhCM1MyN0xnU3ppZXB4Ykxy?=
 =?utf-8?B?YVZiK05BNVE1Y3NCWFR1ODJKM2cyTnhJOWQyd3g4TzNHMFZDNHA3eUpQNjFh?=
 =?utf-8?B?VjRyQndRcGtvOUFSdXBYUmV4TS92bG5sZ3JaSlhpeE5adGFxc0JZKy9oMHRj?=
 =?utf-8?B?Zlk5Q3RtRXBySXJ4M0tjMm04YmQ3L01JZFhoYy9qcVBxd0VjUStnd2VyTVps?=
 =?utf-8?B?QWVXVWRIdFZPdXVhaHFzSlhxNXBkOWsyaWdsb0Uya3Q0YWVyOHVzZ0ZBRlJF?=
 =?utf-8?B?LzRkTituRW4xWmsyTUlVSEQ0Um5lZ3J0RUYzVmsrYjBtNSt1d2FnYzhic25q?=
 =?utf-8?B?c1pKWkl6ZFB4VVdGWis1ZEhpQzFJRWIwdlhTMVArZXd5dTY0TjBkTlBzMWFm?=
 =?utf-8?Q?BHssFFbsWRF9LvZwmRyfXwv4itauIQ+cH9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <75F6B16A2E5FC340A7106F643FCAF45E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072f532c-eb3d-4d57-ad9c-08d8b42867c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 22:54:50.4331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCcklXfLm61yG4zZDerF9rlLIOV+tYnfZLkemcOQQuSUnQZOaNdrBqm+VkyGVrKwo0wyG9wFD27iewg0fy0aGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3735
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTAxLTA4IGF0IDEzOjA4IC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gRnJpLCBKYW4gMDgsIDIwMjEgYXQgMDQ6MzU6NTBQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IEp1c3QgaWdub3JlIGdlbmVyaWMvNDY1LiBBcyBmYXIgYXMg
TkZTIGlzIGNvbmNlcm5lZCwgdGhlIHRlc3QgaGFzDQo+ID4gdXR0ZXJseSBib3JrZWQgYXNzdW1w
dGlvbnMgYWJvdXQgT19ESVJFQ1Qgb3JkZXJpbmcuDQo+IA0KPiBUaGFua3MsIGFkZGluZyB0byBt
eSBsaXN0IG9mIHRlc3RzIHRvIHNraXAuwqAgU2hvdWxkIHdlIHJlcG9ydCBpdCBhcw0KPiBhbg0K
PiB4ZnN0ZXN0cyBidWc/DQo+IA0KPiAoSXMgdGhlIHRlc3QganVzdCB3cm9uZywgb3IgaXMgdGhp
cyBzb21lIG5vbi1zdGFuZGFyZCBidXQgZG9jdW1lbnRlZA0KPiBORlMNCj4gYmVoYXZpb3IsIG9y
IHNvbWV0aGluZyBlbHNlPykNCj4gDQo+IC0tYi4NCg0KSSdtIG5vdCBzdXJlIHdobyBkZWNpZGVk
IHRoZSBvcmRlcmluZyByZXF1aXJlbWVudHMgZm9yIE9fRElSRUNULCBidXQgaW4NCm9yZGVyIHRv
IGZpeCB0aGUgZ2VuZXJpYy80NjUgY2FzZSwgSSdkIGVpdGhlciBoYXZlIHRvIG9yZGVyIGFsbCBy
ZWFkcw0Kd2l0aCBhbGwgb3V0c3RhbmRpbmcgd3JpdGVzIG9yIGltcGxlbWVudCBzb21lIGtpbmQg
b2YgcmFuZ2UgbG9ja2luZyB0bw0KZG8gaXQgaW4gYSBtb3JlIGZpbmUtZ3JhaW5lZCB3YXkuDQoN
CldlIGRvIG9yZGVyIGJ1ZmZlcmVkIEkvTyBhbmQgT19ESVJFQ1QsIHNvIHRoYXQgYmFja3VwIHBy
b2dyYW1zIGNhbiBkbw0KdGhlaXIgdGhpbmcgb24gZGF0YWJhc2VzIHRoYXQgdXNlIE9fRElSRUNU
LiBIb3dldmVyIHdlIGRvIGFzc3VtZSB0aGF0DQphbnlvbmUgdXNpbmcgT19ESVJFQ1QgZm9yIEkv
TyBpcyBkb2luZyB0aGVpciBvd24gc3luY2hyb25pc2F0aW9uLg0KDQotLSANClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
