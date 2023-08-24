Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576CD7874CC
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 18:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbjHXQCN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 12:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242370AbjHXQBy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 12:01:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2130.outbound.protection.outlook.com [40.107.220.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5D01993
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 09:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzyehQOCLhhEl4UtslnwSw4kL0tZFd1ZClL8O37mWKVxdRHfZhO7pcrnPnX8EDMCYk3mgXW7rmEZYfpq3nvSYXTIHCA5S+vuN2y/N5RMYrqvfv9PXrBxvv0U92Ob086UIsC9j6pEBT0zKfGLx2QBkBCoV/Q/9VpwM0m3rVVFt/2TN82N0CeGhfTARNJ9y6DfuzZplvkcBNnaaYTQbVk86BitwhGtr8i96muAMd27QK6J14pVF/HFXbUngIU40wFAq06BoRzkUthLvIeEjquvRnMsPNFqtYOe/vh6JhE6BjdyOBZ2MS5Ptu9LfPVsH3J0qBL087y8grGST3/76YILUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryaKaY4VlmzZGyaEmVW1gX8uXbSpj8VGRWc9LVU1j5I=;
 b=HCL7bgVYJPBkQ9P6jAmVbO0ZqwODPgT6u/LPh2l6H8+84DFiJRlGD+9ezeJzvXTqza9qSFov597RNclW+r/cUYSTGJYMj5nLbyk1a3+/GVq8vb7WcN9BkjLSOOkpwrpz4fP6B7TbXIdmEc+CTZK2wZXR6YRsHKJDNUkf60gDtwXk0yH1Qyg26eo6FmQvGKkWlyBkJtP/jsaFS2FVRGl9ISRQ00oQ3fpYG1ZHzhOM+u78jEXSdun5MQpEoLrpJzwQDiyJDBd8NdTs7iz/ODbUIr33jGpeU2sudbEA++5ALNHAACPyu8B1zN9JX+a50pSmmBYdTdv9xVlz0k7qhQrRfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryaKaY4VlmzZGyaEmVW1gX8uXbSpj8VGRWc9LVU1j5I=;
 b=Bl0Vpk3caAU9m8lQKcG5RF4w/IaiY/dmPyHGU6EE+nIvoMuITH18l4kySz/5/6BQJdl8Ld4S+Cudaizoj0KJahi31De+TuSaJsMaHFaJqcDwwti06xWYFM4Iziy6b3xjppEcn1YvV25PbsUY2CqbbSRkn9YXPpsAt/pKTsqe1OA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BL3PR13MB5121.namprd13.prod.outlook.com (2603:10b6:208:350::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:01:47 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:01:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] nfs42: client needs to update file mode after
 ALLOCATE op
Thread-Topic: [PATCH v2 1/1] nfs42: client needs to update file mode after
 ALLOCATE op
Thread-Index: AQHZ1qM5a8kJqkV85kS+OyPQjyhCTK/5m0iA
Date:   Thu, 24 Aug 2023 16:01:46 +0000
Message-ID: <c02190c39f123a16aeae70fd65a68fba4aa70b6f.camel@hammerspace.com>
References: <1692892434-4887-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1692892434-4887-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BL3PR13MB5121:EE_
x-ms-office365-filtering-correlation-id: 8861c0b3-e9fa-4c00-3e4d-08dba4bb6b21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fbud22ivkQQi8hvtDw9Hh8AC4rOAFHL4yJ2RfF7FTwmNm0MQq6n4qQILIPDhMxqcEPdk7mSBD/XRECTc570g1VP1a9vGqTv38hXNoUj4KGZrIxU1SCXDtxIknxfihKL8pX84P+dhb2Suzsq/+LquE84gJPCbJ5A6rDvyv91JTfN1ifbbvmdlT94PbtK67pSyQVsTCKeBep8XbC4m5DStLb8hPznMLL395HdNlescPwMz9F9GR7gYffIAPwpuCxtcDYJ5+o+tSEAHIuFyfUlpr3QQTiKBt/AXDFskUiut5JHeIoE4Jaoa35ChCz/13WVWNwD156mOw1w+Oo95jCHskBzDiCt7W0TS8D6FgrJJe/hK8aA1+SvIMF5A+8pASMthajMNe90hDqbCsWw9UoRnxbdjqwJGlN/KE/aOKp3jt2cKaByHOLP9OFhf2xCCOxBpnrR3XeliA88wZ+/DUaTniFbXlawvZkM2sMe2b0pcg6M0Mu0qIgkN2w42HQUpz7a19g8ZBg0dpqTyIc/7fSj6bXehVWnPuv0h9dXij/FjEQaj3uIaekO6h1aQYNGrcvIW8Vy6O4vBb2xJBpm5fBR4cafaedG0JvzVwWZAYhKl47XYuRDf6StFRYMLDbxcAYjlZwqSvIBjXNvuFbSgD28ofiVn+VG5a4kEoc/tIWWbb8NUde/LVpzMzQQgVMQVT5X9I6+hx82ljRHmV/P9xWpoSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39850400004)(396003)(451199024)(186009)(1800799009)(64756008)(66446008)(76116006)(66476007)(66946007)(66556008)(316002)(122000001)(478600001)(110136005)(26005)(38070700005)(38100700002)(71200400001)(12101799020)(86362001)(6486002)(6506007)(41300700001)(6512007)(8936002)(4326008)(8676002)(2616005)(5660300002)(2906002)(83380400001)(15650500001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3Z3WGVlb1NYR1dRYzZzN0hnZEJHOC9aRE9CSi9MT0FzTXZKay8rb2pIckxC?=
 =?utf-8?B?dzFudG4rTGpWZm5DVXpJZ21FcDBndkFaOERGc3VpclBsU1ByQ0k1QkUzNlJy?=
 =?utf-8?B?Kzk5LzBkeXhlMXZuRXJQQjNsdFBjNkpKZ09uRTlXM0tGR3dSbzU2RXFqdEZu?=
 =?utf-8?B?Ti9tMStSZ2M1dlQzcUphZmFDMzRVMDVIRGI1MHJ2d2g5aXd5R0dGd0p1cEV2?=
 =?utf-8?B?VFB6dmJyR2NXUnJkdGVKbVlCK2JwZGp6cHJkWEFFbkdlMkpiSHcxNExIZUVC?=
 =?utf-8?B?WXF6Z0cvZE5XcmdYVk9GeVdJNHBQVSs4V0poUnJ6S09wd2FuLzlObGhyV2RW?=
 =?utf-8?B?akVZRFg5TDF5SmpxdFZNSkxqd2h3UzBGQ2hONytxcE9Namx1czR1YVF5L2tL?=
 =?utf-8?B?NGpPUWhmMWNXMXhtdnlrNkRRaGRxZ0JsTlM0aFRzcERlSmMzNnhNVHVJT0NC?=
 =?utf-8?B?YWpmVXduVUN5emZRU0FSMUN4dWFhUmluYW9sRWJiZzNISHZWdWZ0d2VLQ3o0?=
 =?utf-8?B?emg4NUJCSUtmc2o1d3dwVEhFZVNURG9GaEpKeE5JUS9pSkJ0MTBHK1lSdFFp?=
 =?utf-8?B?dmdKdmZISmp5WjRoZlJXT1Bzc0pTU2l2dzBsUWhWQi9uOGtJeVhkS2JmWWUw?=
 =?utf-8?B?dERyNnVBb3lXOTJIbzhoNTA5MEtzL2p4aVA4K0prVTM1blF5S0xyNjRpdFpx?=
 =?utf-8?B?a3h1dnFmcGh4T1NvaCtXS1Vka2NGYk5GRnYvSWJ3d0VxclpFdzZZR2dDc3NX?=
 =?utf-8?B?OEVZalVkYzdZeVRCV2lQbE1NMEw3T21Bc0lmVlNHU2xSMGZ1azd6RDJyaThh?=
 =?utf-8?B?QzZyelhSYUYvYVVBcitXNW1qV2ZmOHF5UHpxc0JnQjdnaklhN0gxdTJyU25L?=
 =?utf-8?B?bTB5YncvVGM1T0ZFYXNHek01Yjg5cFlUZXpMbFVxUVZXeVRPcXlJbWZFYTVj?=
 =?utf-8?B?VzAxekRDeERGWXl3MVFURG5kejMyV1BQWnFRRUlBVlJXc2g3VEcrS280UmhB?=
 =?utf-8?B?ellHcGNzNlYvMDlXaE51TFB1bTUzQU1HMzU3dmZWRWREeEZ4ZVF5TGFiSDIx?=
 =?utf-8?B?NE1JdjJXdmRpUEFNZVhHN3d2WTN2eG5CaS9XYnZBTG5rcUxSNzlvM3UwRFZH?=
 =?utf-8?B?T2tyV09wS3pVaDlVRG9vUkM3WXlGN0RCeEVvWmtrZE8vVC9yT0R1SVZFcE5U?=
 =?utf-8?B?UWM0ZUFjQXdldzlsVU1RbnBvdnAzNUQvSzRqTjBvZi9ZakJqcWltR3R3RVh2?=
 =?utf-8?B?SFBYc2QvdFFzRjdWVlRvTUZNNHJSb3VUV2dIc3pIZjJhUlJJVTV6WVcvU1JJ?=
 =?utf-8?B?NytpTHg3bnhoT3JzY1hWQzh6Y3ZEbkV2c0ltbXNzYm5XcVBGVWtRRjNBKzE1?=
 =?utf-8?B?bTN6cHc5V3k0aUFpb3JhalBXWE5FK0F0Mk9LM2NFT0Fza2lrV1lRb0VpUkNq?=
 =?utf-8?B?TDQ4ajJHdmNyY1FWNmF1bHpmQ3BjSE9yam5YOXcvTm1mL0g0MkdJaEdJdU5P?=
 =?utf-8?B?ZGlXelZqTU1icEozZjJaeHQvSlRWSUlTSlZSdXUyMnh1NDNPM1k5NGZBdHA4?=
 =?utf-8?B?OEhjN1ppVUNLR3Q5NEkySVNaTUxOZ09PRlBpUXhRWGM1ek1oNmk1dUJIUDll?=
 =?utf-8?B?QldsYmNmSkxpTjZUMlBSU0NpSlVOSUl2ZFNrZEUzbWp6Q3lMczZ0U3dPZGF6?=
 =?utf-8?B?bmdveVVYM21HKzRTUUNOYUsvL0lCeWNFa01OL2IxUjFXbmJReHl5OE5Fc2x6?=
 =?utf-8?B?VUR5ZXlFMFBud3ZTT3lIVmVjM21vYm9kUWV2Si9UbXdUSmNtYU85NHFua3gy?=
 =?utf-8?B?VXdPekcvc1dOd0hUUGxRNG12VWRTWkVrdldTT3VKNDE3L1NNcC8xdlBOSXhs?=
 =?utf-8?B?Q01IbXMyZ285ZFAxb1ZQWmNmdFF1Y2t3clVyeWxSTFBPci9MeUxMdDlTUTB2?=
 =?utf-8?B?OHdMT2FqUWQ0UHBwRDh0SVNnTnRVeCtGdEtrNFQwWHFDSHNLd216VTQzdUp5?=
 =?utf-8?B?MmVKRTJoNVBZMS84UEEvM2g5SXN4d2RvY1NsbnR3SllJeXpHM1BqbHZPQVJN?=
 =?utf-8?B?dTIwU043cEZtZXM3OGsyVzRGdWtmcWxwemtzUlRDTGRRTnk1akJ5YmZqLzdu?=
 =?utf-8?B?R3pEWURuYnRLaUFZSzNvekNxM3VSSjl2VU1CeTFSWGlnY1pTNGlsT3NlNzNQ?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <514C54C6296C3449B04E13D81D27C0AC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8861c0b3-e9fa-4c00-3e4d-08dba4bb6b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 16:01:46.6204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/cqwZiuvp10KpTqaKg0WEQkdXABGA5UdxnUGRwSSjPtbAkLTiBKNc4QMae7qWOU3Nrs+PhBzkdJZk7xmsGS2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTI0IGF0IDA4OjUzIC0wNzAwLCBEYWkgTmdvIHdyb3RlOg0KPiBUaGUg
TGludXggTkZTIHNlcnZlciBzdHJpcHMgdGhlIFNVSUQgYW5kIFNHSUQgZnJvbSB0aGUgZmlsZSBt
b2RlDQo+IG9uIEFMTE9DQVRFIG9wLiBUaGUgR0VUQVRUUiBvcCBpbiB0aGUgQUxMT0NBVEUgY29t
cG91bmQgbmVlZHMgdG8NCj4gcmVxdWVzdCB0aGUgZmlsZSBtb2RlIGZyb20gdGhlIHNlcnZlciB0
byB1cGRhdGUgaXRzIGZpbGUgbW9kZSBpbg0KPiBjYXNlIHRoZSBTVUlEL1NHVUkgYml0IHdlcmUg
c3RyaXBwZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYWkgTmdvIDxkYWkubmdvQG9yYWNsZS5j
b20+DQo+IC0tLQ0KPiDCoGZzL25mcy9uZnM0MnByb2MuYyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9m
cy9uZnMvbmZzNDJwcm9jLmMgYi9mcy9uZnMvbmZzNDJwcm9jLmMNCj4gaW5kZXggNjM4MDJkMTk1
NTU2Li5kM2QwNTAxNzE4MjIgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9uZnM0MnByb2MuYw0KPiAr
KysgYi9mcy9uZnMvbmZzNDJwcm9jLmMNCj4gQEAgLTcwLDcgKzcwLDcgQEAgc3RhdGljIGludCBf
bmZzNDJfcHJvY19mYWxsb2NhdGUoc3RydWN0IHJwY19tZXNzYWdlDQo+ICptc2csIHN0cnVjdCBm
aWxlICpmaWxlcCwNCj4gwqDCoMKgwqDCoMKgwqDCoH0NCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDC
oG5mczRfYml0bWFza19zZXQoYml0bWFzaywgc2VydmVyLT5jYWNoZV9jb25zaXN0ZW5jeV9iaXRt
YXNrLA0KPiBpbm9kZSwNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgTkZTX0lOT19JTlZBTElEX0JMT0NLUyk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTkZTX0lOT19JTlZBTElEX0JMT0NLUyB8DQo+IE5G
U19JTk9fSU5WQUxJRF9NT0RFKTsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoHJlcy5mYWxsb2Nf
ZmF0dHIgPSBuZnNfYWxsb2NfZmF0dHIoKTsNCj4gwqDCoMKgwqDCoMKgwqDCoGlmICghcmVzLmZh
bGxvY19mYXR0cikNCg0KQWN0dWFsbHkuLi4gV2FpdC4uLiBXaHkgaXNuJ3QgdGhlIGV4aXN0aW5n
IGNvZGUgc3VmZmljaWVudD8NCg0KICAgICAgICBzdGF0dXMgPSBuZnM0X2NhbGxfc3luYyhzZXJ2
ZXItPmNsaWVudCwgc2VydmVyLCBtc2csDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICZhcmdzLnNlcV9hcmdzLCAmcmVzLnNlcV9yZXMsIDApOw0KICAgICAgICBpZiAoc3RhdHVzID09
IDApIHsNCiAgICAgICAgICAgICAgICBpZiAobmZzX3Nob3VsZF9yZW1vdmVfc3VpZChpbm9kZSkp
IHsNCiAgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fbG9jaygmaW5vZGUtPmlfbG9jayk7DQog
ICAgICAgICAgICAgICAgICAgICAgICBuZnNfc2V0X2NhY2hlX2ludmFsaWQoaW5vZGUsIE5GU19J
Tk9fSU5WQUxJRF9NT0RFKTsNCiAgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZp
bm9kZS0+aV9sb2NrKTsNCiAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICAgICAgc3RhdHVz
ID0gbmZzX3Bvc3Rfb3BfdXBkYXRlX2lub2RlX2ZvcmNlX3djYyhpbm9kZSwNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlcy5mYWxs
b2NfZmF0dHIpOw0KICAgICAgICB9DQoNCldlIGV4cGxpY2l0bHkgY2hlY2sgZm9yIFNVSUQgYml0
cywgYW5kIGludmFsaWRhdGUgdGhlIG1vZGUgaWYgdGhleSBhcmUNCnNldC4NCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
