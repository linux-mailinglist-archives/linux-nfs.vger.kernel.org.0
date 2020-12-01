Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4252C95BC
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 04:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgLADXx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 22:23:53 -0500
Received: from mail-bn7nam10on2106.outbound.protection.outlook.com ([40.107.92.106]:47297
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbgLADXw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Nov 2020 22:23:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6is9H936iFyU2e+2vy9SN/+UtUxr9557rz04R5hW28aJzZY2CwMsYyGXEdGurKvaIznd2C0M3lEWoIywpG1a4nnrrF4mCx/61wGxzwLeLq2W0JAEL1FsP0AHoqj6TZtYalLMCo3aQNeNkXhPgwDegfIc6bc7dMyV+VoEI9RoMd8pGxZjjMzp20giN7UvXUaBXndshy2iwtoO5hCuI1S1R8tggN1xO8tqLZzH7CGNcu20zKzxyWpH7aqvBvKZ6hqmGoWZWN47g5mbH8xyxX1uC/X2W3hJTUFmI2WwbpxwmLmHDTZQ/7jU0kAyVUI8Mmo6gzae2dR3WsLchfTlYGfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/VxIFp20xfNyyvRjsQ1P3bkA1SRaeM/kY7BhJdICrQ=;
 b=b6vFmUTnKjCtcQEPrqILoCWIllOIxLyfNYKLY3h1XyPwJ5uDiib/g8eqWGxiWIQMkECmZA6AiNfMZEEa/YGcoE8/VtdlxHAWaZ74Ibj+jtHAleAfSIlroKDWDPYBaYHR3FgSSmRk8wvwi4WSuwUb81zTilLawFDAp9HROgsM9F6Q4c/eNe8yCYqNC9ggZC3MX6NSjq/n9mltG10+oba4f/KXE48CWuiImOa44tHMjHqRPPD8alkWE9WcftzfpIHHHs309hvZHqat7mGTdHkhbV7x5X2JJZRPRGjYsFSLbaxWSlovhs6JPG8NGulncsw3CWcRKxKKzHncPzUlb34sbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/VxIFp20xfNyyvRjsQ1P3bkA1SRaeM/kY7BhJdICrQ=;
 b=Q1ehFQDV8Ziw4BuP1lTBJozudIZRwpiQUbS7PaO70UQNHezQgmh7Qu7qqJLaDGoSfYBJcQTWMjlgiV8sYnul1uMgY/2A3pSPtsz0IGRTXg1KK/ebpU/k01xfZt4tirO2bPshiRvKhOtRZM5YBW8VI1nF4Rm5s3A81+DKLsvdRk4=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB2765.namprd13.prod.outlook.com (2603:10b6:208:f4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6; Tue, 1 Dec
 2020 03:23:00 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Tue, 1 Dec 2020
 03:23:00 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Thread-Topic: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct
 export_operations
Thread-Index: AQHWx1999UsH3Pym/kCB2OnbCNS3q6nhSfMAgAAdxACAABzfAIAACquAgAABUwCAAAFoAIAAAc0A
Date:   Tue, 1 Dec 2020 03:23:00 +0000
Message-ID: <a1db16841eb3e710a0245234c88ef2ceea2336fb.camel@hammerspace.com>
References: <20201130212455.254469-1-trondmy@kernel.org>
         <20201130212455.254469-2-trondmy@kernel.org>
         <20201130225842.GA22446@fieldses.org>
         <1b525278a9a7541529290588a83852a0754cee3e.camel@hammerspace.com>
         <20201201022834.GA241188@pick.fieldses.org>
         <66f93208c6edf2dad70ee41c349c5130b30b8ed4.camel@hammerspace.com>
         <20201201031130.GD22446@fieldses.org>
         <213a0908e8c9e743d6ae4d6f3b2679e2e879cce4.camel@hammerspace.com>
In-Reply-To: <213a0908e8c9e743d6ae4d6f3b2679e2e879cce4.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94a00859-f851-43d7-db31-08d895a867d9
x-ms-traffictypediagnostic: MN2PR13MB2765:
x-microsoft-antispam-prvs: <MN2PR13MB2765241D652ECB10BE98DF3FB8F40@MN2PR13MB2765.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZ4aNSXg+mW8hwc030zAYWhU7nmejRHWXu4f9KHzeNejHRkYKU3nIFQ9NeSdRC7YgN61U0zR7GYI/bp4PWOrL+NFx/X/un5CgFHLvbtYbTKKMNRCP1eISslU32/3/w+ZjVaIoqjGAsiiW8Az2NQe+4+HUQE3VoqFeWpsUlD/kafFQS6mHcXr27KASQx5+5rPh8SMNtndCdU4drVAy+O9ixTR5rvcqkVVF/+68z34csi+77WSPMn8kHAjIl1DhWd6bmpoINiDv2blsE27rWeceGEXbM2g7H/CcKBhEOIQaM60phscRW/Wby4+sHbPWAh9acEmftlg02YoEdTLt//kpqYzQjpkUzapC/M1UkBFqZBc/JcSpGFbi8+ax0X4RTCLdcdy7D9joH5Eq6eE0y3qxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(396003)(39840400004)(36756003)(16799955002)(86362001)(6916009)(8676002)(478600001)(6486002)(186003)(5660300002)(8936002)(64756008)(66556008)(6506007)(4001150100001)(66476007)(66446008)(4326008)(71200400001)(6512007)(966005)(54906003)(76116006)(66946007)(91956017)(2616005)(2906002)(83380400001)(316002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?enN0Rk1OLzRXdHhxZFpxTlFZZEhxbnpPNE5rcWRKWEt1dG5HbnVEaDBxNGVN?=
 =?utf-8?B?VHQvL2RoR01NUDJXSkRHRVAxUmdHb3E1TDIvWHpENmNoTUxmbXhUR2ZJdXFK?=
 =?utf-8?B?NVRJS1VneXBsRzZpdDJOK1lhUFhWM3R4c2V6NWdPUm9ZY1BvZ1R4Mk9GVmJr?=
 =?utf-8?B?Ly9XTHYvV1ZSN2RaKy8yNGNjTlNRd0k2QkJReTQ1N3MwM0hrWU0zK2d6RUN4?=
 =?utf-8?B?dzloTk9taUtJK0hQdFR0QmNVbXF5YWZwaXBzUlZhb0h5V1hNWXl3R3NSRjF2?=
 =?utf-8?B?VlE0aHRLTEN2b1h6aE5WU0lLZGFGYmF2ZnRzNVFvOFk1aWlsZFgxYlMzNXpY?=
 =?utf-8?B?ZnliUTlvUnltck5CWThKeUpVaFpWU0dqRFJDVi9VTXVLbGJDTEtTVlJHS0lG?=
 =?utf-8?B?N0NHUnE4NkgvTlZFWDE0V2JNVyszOG9xN2pTcUdleGZ6Q0w1VmM1WVVsb3RT?=
 =?utf-8?B?N1drdkVjSWFsaDFlandaNjdTcEVnclJGYTlFOVVnTWJPRis2WDM5czFFOFh6?=
 =?utf-8?B?N3FrdldCRWdtRWdKOEcvZ3NSSFhveCszMjhDcE1TZUg3eHkyb1lQdGQzZEhR?=
 =?utf-8?B?RUlHbWtMa1NHKzFSV3dBTHoxWDVjMWlFckVzYXYvenJ1M2d4NlZWZkVqZWg2?=
 =?utf-8?B?UWExd0ZLRy9tdG4rN2g3UEt0dUgrRkpjc2FiUDhjSUU2d21EUEV4UXpkSDdi?=
 =?utf-8?B?TWVkUklWYkdFWUhnenZ3bDlXMmh0QjZMUmpUQ2xHSjAvbHlLT1pJSVNXd240?=
 =?utf-8?B?bFk2dEVZTmRpNkY2ZDA1bFF5T3E1WmdBc0xuZWFYK241N3czSEpaczFCSkdX?=
 =?utf-8?B?K1Q1YXA5akNNNlY3M3hmUExXVlV6TXhybTFvZTRUSkI1ajk0UkRLZUxRZXlE?=
 =?utf-8?B?NEl0YmlISmVLRGxQQlFnd005R0tia2JXd1ZlakhaS1dtZGM5RHRjWWdVeDVl?=
 =?utf-8?B?L2l4WmNGSk0weXcyNmRoSHE3aVk1ZjVnNjQvNWlHamZwV1FkQmRNREo3V2Z4?=
 =?utf-8?B?clA3dE11OVVUSDA0dVY3bFpySGhqeGxUbEZ2YlkvQlZkMWpMRUJpNUxTcDA1?=
 =?utf-8?B?ZDZMcGJMYkpLY3YxazJ0a3RFTlFJbUlHMldsQkVvV3YzOXZJRnNVWkxKRjJw?=
 =?utf-8?B?TjZJYW9xYXZQRG5Za1p0Q2UzMWdYT3NvT0llSDc5aXIvU2lmNUN2NVU3bWZr?=
 =?utf-8?B?TGhHTWE3bmIyN2duUENZK053L0J0eXFra2RoQ1p5NHRKQ1hyc0pGazVoSm4v?=
 =?utf-8?B?b1FpMmJuWFU1ZVErK0dzNWZZWG81ZVNQb21nYkJnbno0aVJQdngyZHQ2TkVm?=
 =?utf-8?Q?ZZ6LiK5hSb/cKsKSwLtuH1I1kwdIKOceiK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4490176153BC7D48B4EB487647E94799@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a00859-f851-43d7-db31-08d895a867d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 03:23:00.1005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +EdEpum36q+0loHLlP6jhMxNNRh/8tdfWw4Re+ki5pMZ9mvRgVhHaYHFy3la2jWLIVQtAR5W4C17o5JJ8XZn1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2765
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTEyLTAxIGF0IDAzOjE2ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIE1vbiwgMjAyMC0xMS0zMCBhdCAyMjoxMSAtMDUwMCwgYmZpZWxkc0BmaWVsZHNlcy5v
cmfCoHdyb3RlOg0KPiA+IE9uIFR1ZSwgRGVjIDAxLCAyMDIwIGF0IDAzOjA2OjQ2QU0gKzAwMDAs
IFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+IEEgbG9jYWwgZmlsZXN5c3RlbSBtaWdodCBj
aG9vc2UgdG8gc2V0IHRoZSAnbm9uLWF0b21pYycgZmxhZw0KPiA+ID4gd2l0aG91dA0KPiA+ID4g
d2FudGluZyB0byB0dXJuIG9mZiBORlN2MyBXQ0MgYXR0cmlidXRlcy4gWWVzLCB0aGUgbGF0dGVy
IGFyZQ0KPiA+ID4gYXNzdW1lZA0KPiA+ID4gdG8gYmUgYXRvbWljLCBidXQgYSBudW1iZXIgb2Yg
Y29tbWVyY2lhbCBzZXJ2ZXJzIGRvIGFidXNlIHRoYXQNCj4gPiA+IGFzc3VtcHRpb24gaW4gcHJh
Y3RpY2UuDQo+ID4gDQo+ID4gV2hhdCBkbyB5b3UgbWVhbiBieSBhYnVzaW5nIHRoYXQgYXNzdW1w
dGlvbj8NCj4gPiANCj4gPiBJIHRob3VnaHQgdGhhdCBsZWF2aW5nIG9mZiB0aGUgcG9zdC1vcCBh
dHRycyB3YXMgdGhlIHYzIHByb3RvY29sJ3MNCj4gPiB3YXkNCj4gPiBvZiBzYXlpbmcgdGhhdCBp
dCBjb3VsZG4ndCBnaXZlIHlvdSBhdG9taWMgd2NjIGluZm9ybWF0aW9uLg0KPiA+IA0KPiANCj4g
SSBtZWFuIHRoYXQgYSBudW1iZXIgb2YgY29tbWVyY2lhbCBzZXJ2ZXJzIHdpbGwgaGFwcGlseSBy
ZXR1cm4gTkZTdjMNCj4gcHJlL3Bvc3Qtb3BlcmF0aW9uIFdDQyBpbmZvcm1hdGlvbiB0aGF0IGlz
IG5vdCBhdG9taWMgd2l0aCB0aGUNCj4gb3BlcmF0aW9uIHRoYXQgaXMgc3VwcG9zZWQgdG8gYmUg
J3Byb3RlY3RlZCcuIFRoaXMgaXMsIGFmdGVyIGFsbCwgd2h5DQo+IHRoZSBORlN2NCAic3RydWN0
IGNoYW5nZV9pbmZvNCIgYWRkZWQgdGhlICdhdG9taWMnIGZpZWxkIGluIHRoZSBmaXJzdA0KPiBw
bGFjZS4NCg0KQlRXOiBUbyBiZSBmYWlyLCBzbyBkb2VzIGtuZnNkLi4uDQoNCkF0IEhhbW1lcnNw
YWNlLCB3ZSBoYWQgc29tZSByZWFsIHByb2JsZW1zIHJlY2VudGx5IGR1ZSB0byBYRlMgZXhwb3J0
cw0KcmV0dXJuaW5nIG5vbi1hdG9taWMgdmFsdWVzIGZvciB0aGUgInNwYWNlIHVzZWQiIGZpZWxk
LiBTcGVjdWxhdGl2ZQ0KcHJlYWxsb2NhdGlvbiBpcyBhIHJlYWwgYml0Y2g6DQpodHRwczovL3hm
cy5vcmcvaW5kZXgucGhwL1hGU19GQVEjUTpfV2hhdF9pc19zcGVjdWxhdGl2ZV9wcmVhbGxvY2F0
aW9uLjNGDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
