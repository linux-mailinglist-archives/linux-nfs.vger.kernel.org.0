Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D8C4D8C54
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Mar 2022 20:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244014AbiCNT0r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Mar 2022 15:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbiCNT0q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Mar 2022 15:26:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2097.outbound.protection.outlook.com [40.107.236.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF643B3E6;
        Mon, 14 Mar 2022 12:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOTyZXObRwttY8AK/HU71+sCPhfs1r4rlZWoAHRI26jP5OdDWCwRNfXIvV3tbdrOuCrDim2YgXgTVkjh2HqnICVDkFhtFFzLfGWRI1zjjCLxpcUz7kHs8IQH55rK5zpbMxzN2PFWm2yfRk8OKNq/E9cMxVt8by2zCYOK9cH2gPAuPeQdOtx1OwCI68tF30nnUnzB+rIF1Sw8RyczVZUmglgEvy5fPbXKOsbuaVVG6qrGra6Tae5MSsq9xeDnL06xZg5e04O8o4ltOy7lXQmy9hWPsMIjHmcSbbHFUELXnp4lTu83yi+8DKyB4+O4N5z0eDNZCmHYM1Og6aog2g494Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9N3eMc4bjFuRMI13t0dPGIERnMbdcveBUuuik34wfo=;
 b=SZ0D7glPb7ISIXnviqp5VwwnKtIGrwRvxabnpvLcDd3Y84DeQhYbYhXoAJhTF9FeQrPh0Xi5KzHJYVJmQKo7dVRYrdpa1pVg4KyCiCRzxihDl6OR3j5hd6qeqlO4bS3MDzDBBC0LKIiMwBzf3SSatjsIQAxWEVLsDjwUXMSwIkHGi+gDY8T3AYjhZRsp40fOYDgUzVIQABvX5JlgsvYWd7PMZQSMQNc4Qil2vlGUBrL6BixPmesc3dZgCa9fGgHvLQi+cmXOoJJ6n7DiY8vdmLIZS4oXozUZiTYj8uGoqHQjrVNfKJ6NHucl9YN5kD/WcYMH/TZ+ddwV4UW36eCb0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9N3eMc4bjFuRMI13t0dPGIERnMbdcveBUuuik34wfo=;
 b=Lkn/xR41klBdHY60ZFQL2lYAl+5L2tNV70GfsiXRwu2ykiUpkQB2SnMA558H62P2JqKBWO98Kk5X/zpGx6ybyRVcCJ2RmROpgUWGTxBj1LqrM+BSybBqKoxDSlYKK+g0g/HkQJpXVcfWc6mOkbpZOUQSAXb1kjGukhDK7eP0jUE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR13MB1610.namprd13.prod.outlook.com (2603:10b6:3:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13; Mon, 14 Mar
 2022 19:25:32 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f%9]) with mapi id 15.20.5081.013; Mon, 14 Mar 2022
 19:25:32 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "harshit.m.mogalapalli@oracle.com" <harshit.m.mogalapalli@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] NFSD: prevent integer overflow on 32 bit systems
Thread-Topic: [PATCH] NFSD: prevent integer overflow on 32 bit systems
Thread-Index: AQHYN606RPyyWL+vCkesSws2pKKZoqy+9RWAgAAmfQCAABEwgIAAFmwA
Date:   Mon, 14 Mar 2022 19:25:32 +0000
Message-ID: <a7ec2df0162554c5cb72a14f038819a695b780a1.camel@hammerspace.com>
References: <20220314140958.GE30883@kili>
         <251A4166-DCCD-4C84-9819-F350D17A7298@oracle.com>
         <20220314170344.GT3315@kadam>
         <D5859D5C-229F-4377-98FE-314EE2C80721@oracle.com>
In-Reply-To: <D5859D5C-229F-4377-98FE-314EE2C80721@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78005c9d-ba8c-4dbc-3b5e-08da05f0681e
x-ms-traffictypediagnostic: DM5PR13MB1610:EE_
x-microsoft-antispam-prvs: <DM5PR13MB1610012DA2E38C652899FA06B80F9@DM5PR13MB1610.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RD9AQEpSx5yMnmOOkzd3Lvp8ZUI0+p+zu5OeIFGGLH4Q3Fnd3o0XoKejiGGUekCanO4rbaZ2x2eAzcmfC/D/mkxs12jV6tMLwrELWlvZILkp5ehpIUkAbL3kr/oNoTqQuf36KHBePc2hPkeLjuD7Y/HVXBKz474HjrGPfzwlivBRnzn3rA1vXMzOKXgd0bdRPsFQplr6RKrJFFv7XMDZvsSxYJy6gydW48J1AyIu3S0cHT6M1rIKccXI7Pbl1Sf9ZQBLx789fR2Pf0Se7gCMZIEXAIFxfKA8l93A6U6EsM/3NtGkw9ggwntwDqqjt/+5DolkVoWJV2uXoCQQ6EZvJ4UqV7Bfgodj4Jl7tN78yobWcrC7uByTkGHtn2NnOXH/U1NjPCOEyVQHHYhRfStuk5wnpAXM1rEQXJysPoopt6ilKSrMUs/X2lDaX3SwPz7SEB4r0SvdsODWbShLqMYG9uhN77JSbLK04+v04nTxSiG6G8Ze5iHOgbXVgf5kHbtOlEmiJrcF2yb6GQfKerJO5XnmPk9RgyX2UMblOwOh8NyTqc89+oBuO6PloCKxx1wtbyQ7GOi7UhYv8Uhv1CXgy8hwKIDM535LdiRl743DQ4D9Lu0LooBzRrljm4ITZtCIu8nqH2qTSzB1mVk/6A3wxR1a+j7DU+nArrILu1zXwvSDArcVw9nqrvQMjNd/x1hy5hO0/eczqNBGR4tLGAz9KQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6506007)(76116006)(6512007)(110136005)(54906003)(508600001)(66556008)(66476007)(66446008)(64756008)(66946007)(36756003)(8676002)(4326008)(6486002)(71200400001)(38070700005)(122000001)(86362001)(2906002)(2616005)(8936002)(53546011)(38100700002)(5660300002)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGlmdDhEeU5KdVNHZlB5WlpwMDM0Q3NEMVdQU0tJRVFlQXlwYkljWmIvUkNx?=
 =?utf-8?B?Nk5DRk5XOWsvSFFLczFYUTY2V3ZPYjBGUHY3OXEyMmlIQlJublIvTUtCdExX?=
 =?utf-8?B?UTYzTFhnQlFsNGdTNGpzYTNpWkwxM0pjVHJzYWtSQ24wUittbWxrSVQ1VUFX?=
 =?utf-8?B?b3g4VDVWa05DQlNlSEtkNWIwWUZKdTF2ZVJ0S3huN3dpWExIZ29NZnAzcnJU?=
 =?utf-8?B?aDI3cUhjc1ZDZHYreCtCbkYveWVxWWZsUlpBbDg2a1dQQ2JrY0VzNFBGTmp3?=
 =?utf-8?B?R2t2YVo1dHRqaERXeXN2UjVRQ09ueDErT3RsaTBCZGt0N3pmMFZMaHRaNTJ1?=
 =?utf-8?B?aG9OQTNBT0lwOGtBdU5ld0FFOHFXdjlOSXZLeU93TWlCWEM0VW5kSkxJeGk5?=
 =?utf-8?B?MU1EM2FsOWhkandvbm42Nk84UkVTRzNqN1NmRmRzNTQ4Z3dsNzE1a253ZDNp?=
 =?utf-8?B?NVZ1QzU3ZFRaa1ZUSG93R25JeDVNb2NXajJLM2ZMTW9QcHUrMmp4UmIzdWpH?=
 =?utf-8?B?UjJtVXBaaHZjTnBEdmFhWU5aRVZTSURLRDJvYW55VjJMN3hIYTNPNHUrMDRZ?=
 =?utf-8?B?cndwQk1tYmwyVW14cXQxeVFaenZKVWlpeVNJYzMyL1R5V0UxUUFzNllTRlFp?=
 =?utf-8?B?Y0xlRlNjRFBwWnh3Nzl0b1JmMGlMMXBQeEhDclhxKzVIMWd0NWcraXI3S1Vv?=
 =?utf-8?B?QjVjK2dsaG01WEFCcUh4WmlCR0l3QzZnaTAvRmZia2srQ2ZWaDhkOU8yblUz?=
 =?utf-8?B?a3BtMHRWazVqdTRzdDhnZ01iRWxldXFjVkh4MWlTR2ZYbnpmZ0k2RlBIcnRZ?=
 =?utf-8?B?RGxDUVVLbDdTT3ozVEJRMGQ1dFVaMG0rV3pHeFVYdUhkaWN2YTVVMWhjR1Nq?=
 =?utf-8?B?VnpYa2lzK004SzZIb2NUOVVMTGFFQzN2WlR0QWhhUHJZSkF2VkdvaFdTS2xu?=
 =?utf-8?B?RVIyTTBWN3NFd0s1SzZ0NkIzc2pkZktxUWxMWUZEbzFtdmRNZytOTGJ3M3pI?=
 =?utf-8?B?cnd3ZmVack5vbWJDaGZiTS9pelljS0tzb2NvWDZPMnUzL2hJb08yTWcyMzAx?=
 =?utf-8?B?THVFb2NBREd2aU1QOFdaeGZYVUtDM2xEK3hDT0FqNWRXcFJ6Y055UHJza1Uz?=
 =?utf-8?B?SVlsVFZBbFpkczZkNlZZWlNOMXdsdlhtb2RFTnFQS3k0TTc5Kzl1a2sySyt3?=
 =?utf-8?B?MTVNcnEyNnp6UmRjVUpvakdmTEdkTlIxSGdLVDdacW5LY0xTQW9sQVA2S2ZS?=
 =?utf-8?B?dCtTeWVheU9CMHBSY0k3WGpZcTl6cmtNRk1WNEhoR3c0Y0RidjFQZnpEUmh1?=
 =?utf-8?B?bFBiZDI5am53dml0QzdsdWRRQXVRZ1crRUFISzVwV0UwTWNRWHpZUCsrc0JL?=
 =?utf-8?B?NjlONU5EREI5bnpYSGt1Y1l1czdxd1lHSmxPNWRiOHpsQ0dhL2psMW9MYVk4?=
 =?utf-8?B?RWlTZkhGbFNsTzllTVJKVythQ1FPcGhJOEdtSVlTQ1BOMGo5Z0duMTFmUkph?=
 =?utf-8?B?RmRxT3RNTTUzbm1LaE90eUpDNTM5YjBPcjNaU3VmTTd3QzFpd0EzVEVlZVhS?=
 =?utf-8?B?ZnVneHVBZmVHdUNFVytMY0p0bUFnNEN2WU1KVklQVzhUNzNyU1pBQ2lpdVll?=
 =?utf-8?B?b1Bac0ttc2Z5eEhHSFhZRHFDNnAzeEhRYS80TFkvZVBVTmxyd29VQ0FxdzVG?=
 =?utf-8?B?MG1VZkEwMU1OcElqbXZ2eWtDMFMxSFVUeTBxSGJsVVFrVDBNSHJZQnpDeDlS?=
 =?utf-8?B?aGh2MDViUTFXdGEyUFVBU3Vjdk1hbHhOTU9ZTjRiLzNDMFFrL1lGdUcvTzd4?=
 =?utf-8?B?QlBqSlNJQ2dQYzBBMHA4RmZ6UG9BSkwrTU4xVGtSS0QxaTRGWksvWnNVS1F5?=
 =?utf-8?B?L2YydDM0MjFCK1craUJsK0VlUFJEWk93YTNHVWZFSXoyNTcyUzhaY09Cd2lC?=
 =?utf-8?B?bG90OElKU0tldTBiM1d4Y1U3TW9CcUxjZ0FsV3ZSU0VHRi9QMVRDOW9UVEMy?=
 =?utf-8?B?dUhPc0Rwd0JBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <483DE023EC986E4E9D580E789EE6EAE9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78005c9d-ba8c-4dbc-3b5e-08da05f0681e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 19:25:32.2510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nnlpfy4eG0xkgnUpBpYnIvlEwCl9aIf38A87QiYk561RasYNgJBvc7kRbQ9/A95lspwS6p7UtDDx/bW1v1yItw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1610
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAzLTE0IGF0IDE4OjA1ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBNYXIgMTQsIDIwMjIsIGF0IDE6MDMgUE0sIERhbiBDYXJwZW50ZXIN
Cj4gPiA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24s
IE1hciAxNCwgMjAyMiBhdCAwNTo0NTo1OVBNICswMzAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+ID4gPiBIaSBEYW4tDQo+ID4gPiANCj4gPiA+ID4gT24gTWFyIDE0LCAyMDIyLCBhdCAxMDow
OSBBTSwgRGFuIENhcnBlbnRlcg0KPiA+ID4gPiA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPiB3
cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIGEgMzIgYml0IHN5c3RlbSwgdGhlICJsZW4gKiBz
aXplb2YoKnApIiBvcGVyYXRpb24gY2FuIGhhdmUNCj4gPiA+ID4gYW4NCj4gPiA+ID4gaW50ZWdl
ciBvdmVyZmxvdy4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50
ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IEl0J3Mg
aGFyZCB0byBwaWNrIGEgRml4ZXMgdGFnIGZvciB0aGlzLi4uwqAgVGhlIHRlbXB0YXRpb24gaXMg
dG8NCj4gPiA+ID4gc2F5Og0KPiA+ID4gPiBGaXhlczogMzdjODg3NjNkZWY4ICgiTkZTdjQ7IENs
ZWFuIHVwIFhEUiBlbmNvZGluZyBvZiB0eXBlDQo+ID4gPiA+IGJpdG1hcDQiKQ0KPiA+ID4gPiBC
dXQgdGhlcmUgd2VyZSBpbnRlZ2VyIG92ZXJmbG93cyBpbiB0aGUgY29kZSBiZWZvcmUgdGhhdCBh
cw0KPiA+ID4gPiB3ZWxsLg0KPiA+ID4gPiANCj4gPiA+ID4gaW5jbHVkZS9saW51eC9zdW5ycGMv
eGRyLmggfCAyICsrDQo+ID4gPiA+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4g
PiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N1bnJwYy94ZHIuaA0K
PiA+ID4gPiBiL2luY2x1ZGUvbGludXgvc3VucnBjL3hkci5oDQo+ID4gPiA+IGluZGV4IGI1MTk2
MDlhZjFkMC4uNjFiOTJlNmI5ODEzIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L3N1bnJwYy94ZHIuaA0KPiA+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3N1bnJwYy94ZHIuaA0K
PiA+ID4gPiBAQCAtNzMxLDYgKzczMSw4IEBAIHhkcl9zdHJlYW1fZGVjb2RlX3VpbnQzMl9hcnJh
eShzdHJ1Y3QNCj4gPiA+ID4geGRyX3N0cmVhbSAqeGRyLA0KPiA+ID4gPiANCj4gPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoGlmICh1bmxpa2VseSh4ZHJfc3RyZWFtX2RlY29kZV91MzIoeGRyLCAmbGVu
KSA8IDApKQ0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAt
RUJBRE1TRzsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKGxlbiA+IFVMT05HX01BWCAvIHNp
emVvZigqcCkpDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
LUVCQURNU0c7DQo+ID4gPiANCj4gPiA+IElJVUMgeGRyX2lubGluZV9kZWNvZGUoKSByZXR1cm5z
IE5VTEwgaWYgdGhlIHZhbHVlIG9mDQo+ID4gPiAibGVuICogc2l6ZW9mKHApIiBpcyBsYXJnZXIg
dGhhbiB0aGUgcmVtYWluaW5nIFhEUiBidWZmZXINCj4gPiA+IHNpemUuIEkgZG9uJ3QgYmVsaWV2
ZSB0aGlzIGV4dHJhIGNoZWNrIGlzIG5lY2Vzc2FyeS4NCj4gPiA+IA0KPiA+IA0KPiA+IFllcywg
YnV0IGJlY2F1c2Ugb2YgdGhlIGludGVnZXIgb3ZlcmZsb3cgdGhlbiAibGVuICogc2l6ZW9mKCpw
KSkiDQo+ID4gd2lsbA0KPiA+IGJlIGEgdmVyeSByZWFzb25hYmxlIHNtYWxsIG51bWJlci4NCj4g
DQo+IEdvdCBpdC4NCg0KU2hvdWxkbid0IHdlIHRlY2huaWNhbGx5IHJhdGhlciBzcGVjaWZ5IFNJ
WkVfTUFYIGluc3RlYWQgb2YgVUxPTkdfTUFYDQpzaW5jZSB4ZHJfaW5saW5lX2RlY29kZSgpIHRh
a2VzIGEgc2l6ZV90Pw0KDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K
