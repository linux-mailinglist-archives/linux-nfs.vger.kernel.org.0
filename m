Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46142DDAC1
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Dec 2020 22:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgLQVUs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Dec 2020 16:20:48 -0500
Received: from mail-mw2nam10on2125.outbound.protection.outlook.com ([40.107.94.125]:19168
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729108AbgLQVUs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 17 Dec 2020 16:20:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUxG/qOQ/uOTGRYWzrktTbpHWAuqTdLaaCwoe0aGitiBod7dSpkhQbccCjIgdVROdg8tatJ3FxHgC9urWo9LUr63AZ9lnK7yVFmVPVJgKVmbonFR/cMR8zcM/oTDWStsMLwxziZTYuBrE0Mzz3mNt6wximkDCuWwfddSpNp/2Ha1AH5QkjOOw6a9QgScN/wW3xnPCVLNkkJhjUh5MTVK7cfWTddOWU2AD1r3nCBQHtoVQ5iJRJUhCDrFrmswUcMJUm9EMkXowiGB8zlg8i8qyWVaQel+5dvRWTIvvFhe4hh9T1Rpy1XbxNOVBAX4EtX2uVmE8Eqrgz28SCJkXYu5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZNd+hdmfl8lkNXfWfxl6brY4aG0rBK4TkDdgw8mrKk=;
 b=Ywv+0KDmKBTrP0qNB34ZJhQbk0u/d7dF/uWU5Ia300hceCQ4T0N3UvxTjSDMY/EfzoXJROQXwOHh6f9tmlkHspls4ovlV5FTQ6t3S1/kbRceWm0W2BxcBC67AZnI/fzO5/LyJsCSei6wPEhjdNbSTzYtNDZykoX6dfK3q3k6pMtRQZmbVjt+HFLm8DeJqpJpXo5u0SyQne1MTyAFagE7PY9mKYDM873aKpzw4G+2flHPTPW3PG/IhXs8QZxiXF3THvUnW2CxEVvNv/HY1ZfipagCLV21jrKx69B9T0lzxtaK/L1dvCW6bzf/MwDX/Ms6Y3UoG/qjpxaUHZGy/rAGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZNd+hdmfl8lkNXfWfxl6brY4aG0rBK4TkDdgw8mrKk=;
 b=QuL52x4ccVp1V1jH5mQ7kk/FX0DkzE8IfUO7vH6xZ6+aW+SIXTT5zhjIOuMZMlJSsTwdwFed1GFz4pz+AbXFE02kN8fpTNBcoA8zyVQajEz++6c43aWiedfFuxJP5+9yu/l7ao0ZNgOY96oq/cafo/zybAnWjbRam3fa7gu0clA=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3485.namprd13.prod.outlook.com (2603:10b6:208:161::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.19; Thu, 17 Dec
 2020 21:19:55 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%8]) with mapi id 15.20.3700.018; Thu, 17 Dec 2020
 21:19:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "konstantin@linuxfoundation.org" <konstantin@linuxfoundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull NFS client changes for 5.11
Thread-Topic: [GIT PULL] Please pull NFS client changes for 5.11
Thread-Index: AQHW1J8iUwXTPNIWjkGM7oCEKx5v/an7vFYAgAAPIAA=
Date:   Thu, 17 Dec 2020 21:19:54 +0000
Message-ID: <faf1df209849d1a8f242f50a709ca52f01f33ef3.camel@hammerspace.com>
References: <a47c68f255f9fd9361f0c17ccf1273d905fd0bd1.camel@hammerspace.com>
         <CAHk-=wi74uq4CGeWtSYfMcdgWdpkiwbM5u7ULryCOPM1ZAdFXw@mail.gmail.com>
In-Reply-To: <CAHk-=wi74uq4CGeWtSYfMcdgWdpkiwbM5u7ULryCOPM1ZAdFXw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f01c597-e134-4461-2fc1-08d8a2d17fc8
x-ms-traffictypediagnostic: MN2PR13MB3485:
x-microsoft-antispam-prvs: <MN2PR13MB348514D79B07E7F3B6EBA2ACB8C40@MN2PR13MB3485.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4B9EwvBzcAe0xaCg/+Nw6MfMtBJet4HQnaOLK4f9fQ61UEnfLjVLCYnEnfX9ppkPgoTsMfJrG5V3CGluHMjDasZqlS8Me6zL27nZWjuZQr4HL14k6J51WO4ewFCWesovHjtBX+iHJ2c8pC+fbkvIw+tugQ3N95PwvST4rWesWFkRR/S8+Pf1Ehi5l69dwvBVq/lod4ZefnrR3eSUcPm7D6tNXCEHbhHtnGkS1f3vT+IXOeQqlswqt3aVhouol9AREMKL62sSoy9Mg5gfVtdaJaCbWP9kMq2NXr5E/GNeiMRLI5ZAvIIVDnfrr6tuYIEUVMLZjYOnjJuZZ4KeXstiAzxRsx3lrV5A94t33H71BKc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(39840400004)(346002)(8676002)(64756008)(6506007)(5660300002)(2616005)(4001150100001)(6486002)(86362001)(478600001)(71200400001)(8936002)(316002)(186003)(110136005)(83380400001)(4326008)(4744005)(26005)(54906003)(6512007)(66556008)(91956017)(66476007)(53546011)(66446008)(66946007)(36756003)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?d0tnb0tQR2hPUENsM2pDd1FnYWg2UGxvZWp4OEtSSmUwcEU1N2lnM3pOTTlY?=
 =?utf-8?B?RHN5L05GMDlkQVErM1psTnp5VjNYUUlQdHdRZi9QL0VBQlltN2s4Wm1zazR2?=
 =?utf-8?B?SmRQbm1UdmZkUjhIcml0K0NJWjJWaUQ3cGN0VFJWd3poZk9hRnN2OEhQVlhX?=
 =?utf-8?B?ejBXOWsyZXZOUU1KOFRTdFhJZ0hXWEJVeStXKzNVeEFaVU8xRzRZWjA0NUJy?=
 =?utf-8?B?TG5SbklON2p2MzNDQjZDOHlnMm9mK2ZadisyWjdIT0o0RFpMWU51ZC9JRmZ6?=
 =?utf-8?B?NkIrTWhvOEhpZndJZUREMU9IZ04yVXowL2ZBMW14dmlXUENVVjE4Mno0VGpK?=
 =?utf-8?B?YzBYTmNoc2xSTGFiWHl5RTlMYWszcGlhT1EyaXF0T2JIU0dhR2ljcnZjYTE0?=
 =?utf-8?B?L1ZFMzBhZ1cvWkI3cWVXeHZSM0pRaUV4SXlkWTdRTFIxQ2o5SkRvMTNxVHNX?=
 =?utf-8?B?bXJuMkhqdmFUZGtGZGw4b2U1TFdLcUZOb2pxYU9yaVg1Q2ZteWFvVndYV1g0?=
 =?utf-8?B?OG5sbGpzL2FyZWlqMkVpUnBqTXhNbHN0cU1RYjFkVU5PTmd0ZncydVFWVmxo?=
 =?utf-8?B?dkFhZ2pWS1BBUkVuTkFvVXdxd2FBYmEzYVNaN3dqRkJLNzZhWjVLQmpwc1Vu?=
 =?utf-8?B?b2xvOWFiaE52TFd0Ry83Q1VLdzhIU2srcjRPVTlROEtobktGRDFNV2Zrb0RQ?=
 =?utf-8?B?cTJHd2xEcVNEL2pTN2piSlFOVjFIcjQ5MHJBK2ZuclcxSjluVkFmd3orR21M?=
 =?utf-8?B?cVh3eERNR1p5THhkNGRtN0tPQWxuTDM5UjVuM2R0QmpjUmtSR3ZsR3duWjZj?=
 =?utf-8?B?bEZaS1hRTjI2S1RiaEV5NEJFbEVCazhzRHNRcTVvdjd5b2MxTGxpc0t6TXA5?=
 =?utf-8?B?cVF0YlBQdG5GYmkyMElzRWRoRTRsSWVINkxlWUJMYm1uSGVEd3VPNW9QdWtL?=
 =?utf-8?B?eTViMWRNN0FCMmFRUXpKSW9VRDdOcUNFY1pueWRRVXFzTXNZSUNoSHFGY2pG?=
 =?utf-8?B?RGlrWVQ4NzVnZy91ekZXbkc4Q3d1QjNsWGtDL2RwNkM3bFdzWW9NcE15a3BW?=
 =?utf-8?B?YVJ4M2hRZVh5aXN6WGdJbTkyYmpEZTRVOXJVUlVCaW4xdHRqbHZna2VJc0Nq?=
 =?utf-8?B?NUw5SFJ5dy9vNFY5QUdacWxxbUwxQ2dYQXFYWUxwSmVydWVXcjcrMTZVc3dy?=
 =?utf-8?B?ZXBLU1hHVEhCRnVDT2lNaFV6M0cwY3dZRGpuZ2tGR1BVamo4eWN1VDl4b2NS?=
 =?utf-8?B?bmdWdXlxeWtobHMyRUR5NDNnNU9xQjNOQW9ETXRQVnRzTThCYTNuUDgwVCta?=
 =?utf-8?Q?KmizMrIe2cQT7akbDeTo3zkMBONWLaopoR?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8646D5B5BBD5DC4691A3100176AAD755@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f01c597-e134-4461-2fc1-08d8a2d17fc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 21:19:54.7440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d986UiRvICQnRnvyK+YS0/e94F4knC/TbePRQk3Q/9YFot3T/WUUtAJayhiW+Iaaok83PbcVnV2m8+TuQYQoyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3485
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTE3IGF0IDEyOjI1IC0wODAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gT24gVGh1LCBEZWMgMTcsIDIwMjAgYXQgMTA6MDUgQU0gVHJvbmQgTXlrbGVidXN0DQo+IDx0
cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gwqAgZ2l0Oi8vZ2l0Lmxp
bnV4LW5mcy5vcmcvcHJvamVjdHMvdHJvbmRteS9saW51eC1uZnMuZ2l0IHRhZ3MvbmZzLQ0KPiA+
IGZvci0NCj4gPiA1LjExLTENCj4gPiANCj4gPiBmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAg
dG8NCj4gPiA1MjEwNGYyNzRlMmQ3ZjEzNGQzNGJhYjExY2FkYTg5MTNkNDU0NGUyOg0KPiANCj4g
cHItdHJhY2tlci1ib3QgZG9lc24ndCBzZWVtIHRvIGhhdmUgcmVhY3RlZCB0byB0aGlzIGVtYWls
Lg0KPiANCj4gSSBzdXNwZWN0IGl0J3MgYmVjYXVzZSBvZiB0aGUgb2RkIGFuZCB1bmZvcnR1bmF0
ZSBsaW5lIGJyZWFrcyBpbiBpdCwNCj4gYnV0IHdobyBrbm93cy4gTWF5YmUgaXQncyBqdXN0IGRl
bGF5ZWQgKGJ1dCB0aGUgb3RoZXIgZmlsZXN5c3RlbQ0KPiBwdWxscw0KPiBzZWVtIHRvIGhhdmUg
YmVlbiB0cmFja2VkKS4NCj4gDQo+IEFueXdheSwgaXQncyBwdWxsZWQsIGV2ZW4gaWYgdGhlIGF1
dG9tYXRpb24gc2VlbXMgdG8gbm90IGhhdmUNCj4gbm90aWNlZC4NCj4gDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgTGludXMNCg0KVGhhbmtzISBNdWNoIGFwcHJlY2lhdGVkLg0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
