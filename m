Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F9659AA17
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Aug 2022 02:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245307AbiHTAeo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Aug 2022 20:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245321AbiHTAek (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Aug 2022 20:34:40 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEB31CFE1
        for <linux-nfs@vger.kernel.org>; Fri, 19 Aug 2022 17:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1J22Th6+G8GEZgRnhr+ZprIZUwG5xv/HSLknncbvKSfVzIIhRwp2BtKn0YAREP+nWpRuvHm0SFfC3fcSpUtpUfoyMNuxuSa6Z3FesGe8FFW/eujRdFAGEVjTyMQbvrnf6pJUbhyhD9t8YKNnsuyg5Za63reddNNps1WslwrMqqbOlVheqO0upkA0Ahm9aaP1vJSWRaMERasvSnR+mB9BcJC/dIwgBmdoRDYrQZ0o/kvr0KchYlGUiBBCFiMvxMObS11PdwSF31PsyXWMxcp8x9myeaIdF+1bm1wNrB9sofuAeDU5Iu6VWbHFDjBg4R13xVfSDBRG6Q9Yg2W8Zp8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZ9SrSBwXbYH8Q6WO5EgDnVm7I6rUgBH4kogNaAHV/w=;
 b=d6E44qPrttbdu+enc1/QuPtcJcGP8/GHlQdZfn9c7tJBDlBoInS38deIR9xf0RRn5Fco3r9WkuDcVHMG/+J3i8i3qczymQ+X4PzKEusYj9sd2GiFNDYz3ekD1LhxZALYyzhnT+nezsNIoFjhb4N5y23mJXrz/uGJYsWz4Kv2uTcAifBkeKDKKHW7CugL/n0f84CchxDbUL7BFN5dQJF+EnUiLw2AD3L2vm6Y8n5LIBIdTXwS/uqpCGWquustEIPXz4Pi9q0pO51G6ZPH9ett3JVtYSClIsgwXcTCINsxr/+GVKogerUjG6CF1PkvSzDUzTYc30Tsuz0NE0jNGnY/CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ9SrSBwXbYH8Q6WO5EgDnVm7I6rUgBH4kogNaAHV/w=;
 b=C9opX4MGDX2xcioYb7j9L5FTzj4dmQpXF/br1o4KhjT/eRa1dxT6pe3MdX+pqi+0XVUZ6UZMAirmR7nyLA7f7/ppgES/VgOHOm1CFgfrGDK6BqzmG7B2Cp1ufWNtFG371y3g9E+Edu9QGW1V4cM0YTL0po7pvUus0D3cI3FyPg8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR13MB1765.namprd13.prod.outlook.com (2603:10b6:903:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.4; Sat, 20 Aug
 2022 00:34:33 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035%8]) with mapi id 15.20.5566.004; Sat, 20 Aug 2022
 00:34:33 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "hooanon05g@gmail.com" <hooanon05g@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
Subject: Re: [PATCH v2] NFS: unlink/rmdir shouldn't call d_delete() twice on
 ENOENT
Thread-Topic: [PATCH v2] NFS: unlink/rmdir shouldn't call d_delete() twice on
 ENOENT
Thread-Index: AQHYs14Y8o8H+uhWfkyevwHHj+bLPq21W3aAgADwNACAAJ9hAIAAB24A
Date:   Sat, 20 Aug 2022 00:34:33 +0000
Message-ID: <b9a31b7bd904f8005cfdc87c8f04a46511faaef5.camel@hammerspace.com>
References: <166086695960.5425.17748020864798390841@noble.neil.brown.name>
         <d6a1c7378a4c666be93d22707405e0e0136a01fa.camel@hammerspace.com>
         <CAN-5tyHdSSfJLVff0DsW1+zq=tTxF152fA_BipN1He=q1LroZA@mail.gmail.com>
         <CAN-5tyFFXGadpyT0mR7-YTAQmzi0w7k950T6Tnh=KhnZ1OF+Rw@mail.gmail.com>
In-Reply-To: <CAN-5tyFFXGadpyT0mR7-YTAQmzi0w7k950T6Tnh=KhnZ1OF+Rw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8db3332c-d25e-4f9b-8f30-08da8243c0ca
x-ms-traffictypediagnostic: CY4PR13MB1765:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g9SiU4MGmFR7kh4j933i2jGzNqz6MTOKXZwWS98oUiMa5lhjyEMT3G+EoerNaTl8byqKIkeufoW+aI+cCTopGMDmi2mCrcgtkcCPyTXdxRetzgbDcMP1Ldmt3F3Q5VUV4k3cl6BM7q2m/gicCP1bvLlViHHNlGmrfUTID9uVsPFoaUCLJik2i+aDxqh6lbOjD45SBQGXI0N8P5QAypyLjNSNAGSKRBoPrQJzhZxpkO2YAQZuxkRHbh2oGcv5Karcnt0sIzMb5cN9lb/5wimeNWyh8YZPTV2bHoRmnDu96LQPWZvMNCyNzeJe85wUC2nI5kXLGtX19MW3g8e/2HDhay0Kanv6fdosuSFVV43fGmLBTTB2eZd249XZvwYoXvnD+NzZctrBKPQiBtcN6+YKEo5gnrbEHyaZLJR/pn/6GowlHDh++x/hZ+17nJ1FBBUpur9dZ986MR0MBZ93NO5wxAYb1kISCqixh5DmDe0CbcaKWe1J9nLDBj9u/xVo7h1ZCbT29LR8/s0QDWNLiOplhc+STVIX96JaDGBRSR8vrK7u4ZOmLz/zc9p0CGqee7bnV+RQZatArnkw4r2f2JftFpshzg5QizSONpt71Fc5GE/EBHPSkFFhRDjHVlFbHNZX4xV+hoIaIfdeHPQsfwnmroanHHck/lSuc20C75EOF7txtRh72dGEGmgXfRyvz0yOtXrhaLXJvBahwQR/yVe3Ho2SCXq4hkCWX0S12vxEuy0WvB2TqCQ5u1ICBHsn1yWPbEhDiOx0RlycTUh1fSkYsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(376002)(366004)(39830400003)(316002)(4326008)(64756008)(66476007)(54906003)(66446008)(66556008)(8676002)(6916009)(76116006)(66946007)(5660300002)(8936002)(2906002)(38100700002)(122000001)(36756003)(86362001)(38070700005)(6506007)(478600001)(6486002)(71200400001)(53546011)(41300700001)(2616005)(186003)(26005)(6512007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajV3VStpTmZ5cVVXcmdZSWNRTmdkS3NscnREaVhRWHJ4RGVBbnRqNG1GWlFp?=
 =?utf-8?B?SHlWSWVXNjZtamw1QzB1S0lFdGVkYVJieEloN3RCOUo2WmVVL2psR3QwYnVz?=
 =?utf-8?B?UVFpMSthbzFVSzF1OC9SbTBQVUhoWEswaG8zd2cvdjRxdld4V1JBVTVidUdt?=
 =?utf-8?B?TTJqSFgwMWNaSjN5UjJCTm5PUFhyWk1UNXhzbkw4L0F5d0JGK1ZqYXpLL28v?=
 =?utf-8?B?dktlanUvLyt3blpQekZCdVBsaU9IQjdESmZOb3Roa3FCM0JjUUY1Vk5XNnpN?=
 =?utf-8?B?RjdNTzZBRUNBb0ZSeWVlTkNQRE82eFErT2xwK0VTTEhrbFpRaFJXcjVWdGlx?=
 =?utf-8?B?V2RxOXAwRDZ2Y0lzVTlGbllISCtJdmFXUHp3SlM1KzlNQjBvVVBiQjFzeHJB?=
 =?utf-8?B?ZGJBWGRHVGRBd1pCT1R2RW9mOExoRkZXN2tNY1JMRU8vZlZuaWxBTkNnLzVn?=
 =?utf-8?B?NHc1cHdsKy92UFhyR2c5bEJKRW1Ud3ZjNGxRTlIyYmdzMHVEeWowL3Evc203?=
 =?utf-8?B?d2FLYmFLZ0ROc0s0MVRIRHVjVkh2UGhTU1YzWHBMaFZrQU5FK2dOSk05bkRJ?=
 =?utf-8?B?SlZrZ2lNL2srVng4TUxtY3NGRU1KZk5mZUZCZnAxd2lmNWZlaXhmS0VRdU1C?=
 =?utf-8?B?b1E2MEVCQmVkZkZScHZaeElRV0xDVHI1NElLTzNxL3hpTElWemZEdEs2dW5n?=
 =?utf-8?B?cTBoTFM5NnV3NUlhb0dHNUtNN3Z4MmVVWVVmb1pZS29DSWdxK3YzUU1FSDRX?=
 =?utf-8?B?V3RxSUNpUHFJUjNBaGovRlU2czQ5OHJvaWJFeGdiVzRZd1Y0REhiemFqLzZY?=
 =?utf-8?B?UHg1Vm1YOWV2VDhFWGpOSEw5UjlEd2FZWm85VnFZU0g4cHRnVXNxY1dJM3J6?=
 =?utf-8?B?L0xRWlY3OGhiR2MrRHNsRWpubDBWV3p3ajBDN1RhNnZncnp1VmJ0aUxHK2xD?=
 =?utf-8?B?L0ZDeUFxbE9PZjZRQVJsTmJnZzM2Y0cvb2N3UUVqSzh2dzJmc3d2OTJoMlNS?=
 =?utf-8?B?TkdaK0pnb3ZkVk81bDJmait0elE2NjhoV0pZamJ0Nkdxb2J5ZkMwWUhzRE9l?=
 =?utf-8?B?TWxld0N0NXZ5RkVVYUMwSDIreWxnR0o2S20zdzBWOEx5ZjZEcEJQdG0wUzgr?=
 =?utf-8?B?Q2ZxR29FazRVL1FBMjFwakFEZHM2cmtrWVpmMHY5WlF4ZjIrQUQvNklsTERh?=
 =?utf-8?B?MWFJcXU5ZHBRR0JQYytPWUlTanhBbXlNSkRhdzNNUVhjOXlaenAzMnN5NHk1?=
 =?utf-8?B?bnNBTHdTM3RnMnNUTkcxbjFkMGlFVGpqRGtMNUVxNlRYVXdwNXZhaDcyaEFJ?=
 =?utf-8?B?dUtYQ1RNekFjckErV3VmTyttY3BrREVDYlkvWGh1N0UzbHRoZHpzRk1VWUsw?=
 =?utf-8?B?NC9hTUNPY0lWWmJydGcwQ2FFbWJPWDlKTkV2VFpFdzdBQW9MbjQvc3F1MVEr?=
 =?utf-8?B?LzVSQWNVaTNELzV4L3FkZDg2R1EwTUJiNzJWVXFSSVdIK2JjV3NCQTlFWXJj?=
 =?utf-8?B?cEczN2hVYTY5bVJKTW1QamxGc3g5R1pyblM4eUlPbW9aWVNtR29tR1JlWUti?=
 =?utf-8?B?L3BQb3EyQnJ5TVJPcEF5YW1LNmt6Q0l4YjlReVlCNUVKSWV0TXdUZnBmeWdM?=
 =?utf-8?B?V0I2bHZhN1A0a1ZzaEpNcStnYkxGTXppaWZnQzlaUkxISHY1dEI2M1cwQytU?=
 =?utf-8?B?eGxVeDd4aitaRm4yTnZKclZCRDRoRjF3WjQ0cjljNXhFeWVaaSszbjljRUNM?=
 =?utf-8?B?T282SWF2a2hzbnh6TEtuMk41bG9wNkU2UWdFdks5eHZCa0loZEtnY0k2dGJX?=
 =?utf-8?B?OVh4MEQrYUVDanRPT3NBL3J1d21UYnI4andwN3BQaDVQdEpGUXZiUDZlYVlz?=
 =?utf-8?B?amZ4ajFPc0RSSVRZQ092RDBSaFQyNHU4a0c2am5DYWxtUVoxV0JzTWx2Y1BE?=
 =?utf-8?B?cXE3aHVSTDQvdHRlYkJvN3hLRDZBUU93bDdwZHJXdlNNUTdpUVhXZlpuYkZk?=
 =?utf-8?B?NXFsaFhKelJjMG1mWVJNUmdlbC9ITjJvNDZpamJtMSszQ0lHYXBwUW5SNVFN?=
 =?utf-8?B?WThXS3hCQnM3blZqNkNwd3BHckVmZ2tPK3BaYkltWS8vTXBheStaU0xvN25t?=
 =?utf-8?B?SWNCL1lPc2h3V3dVSUpEV1d0TW9ZVk9qVXBkZTREMkdEUVg1NXFlc3JNeG1H?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D97F2B11DB25C44EA7713B773D33DFB0@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db3332c-d25e-4f9b-8f30-08da8243c0ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2022 00:34:33.4954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39WMWfr8H0/tCrSoJerXUcgOmKe8saX96DvBXeRVi35VdOcKYE5BJRXoIp/grAF5fLzzkNeda3ViPQSmUzacfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1765
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTE5IGF0IDIwOjA3IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gRnJpLCBBdWcgMTksIDIwMjIgYXQgMTA6MzcgQU0gT2xnYSBLb3JuaWV2c2thaWEg
PGFnbG9AdW1pY2guZWR1Pg0KPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUaHUsIEF1ZyAxOCwgMjAy
MiBhdCA4OjE3IFBNIFRyb25kIE15a2xlYnVzdA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNv
bT4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IE9uIEZyaSwgMjAyMi0wOC0xOSBhdCAwOTo1NSArMTAw
MCwgTmVpbEJyb3duIHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gbmZzX3VubGluaygpIGNhbGxz
IGRfZGVsZXRlKCkgdHdpY2UgaWYgaXQgcmVjZWl2ZXMgRU5PRU5UIGZyb20NCj4gPiA+ID4gdGhl
DQo+ID4gPiA+IHNlcnZlciAtIG9uY2UgaW4gbmZzX2RlbnRyeV9oYW5kbGVfZW5vZW50KCkgZnJv
bQ0KPiA+ID4gPiBuZnNfc2FmZV9yZW1vdmUgYW5kDQo+ID4gPiA+IG9uY2UgaW4gbmZzX2RlbnRy
eV9yZW1vdmVfaGFuZGxlX2Vycm9yKCkuDQo+ID4gPiA+IA0KPiA+ID4gPiBuZnNfcm1kZGlyKCkg
YWxzbyBjYWxscyBpdCB0d2ljZSAtIHRoZQ0KPiA+ID4gPiBuZnNfZGVudHJ5X2hhbmRsZV9lbm9l
bnQoKQ0KPiA+ID4gPiBjYWxsDQo+ID4gPiA+IGlzIGRpcmVjdCBhbmQgaW5zaWRlIGEgcmVnaW9u
IGxvY2tlZCB3aXRoIC0+cm1kaXJfc2VtDQo+ID4gPiA+IA0KPiA+ID4gPiBJdCBpcyBzYWZlIHRv
IGNhbGwgZF9kZWxldGUoKSB0d2ljZSBpZiB0aGUgcmVmY291bnQgPiAxIGFzIHRoZQ0KPiA+ID4g
PiBkZW50cnkNCj4gPiA+ID4gaXMNCj4gPiA+ID4gc2ltcGx5IHVuaGFzaGVkLg0KPiA+ID4gPiBJ
ZiB0aGUgcmVmY291bnQgaXMgMSwgdGhlIGZpcnN0IGNhbGwgc2V0cyBkX2lub2RlIHRvIE5VTEwg
YW5kDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBzZWNvbmQNCj4gPiA+ID4gY2FsbCBjcmFzaGVzLg0K
PiA+ID4gPiANCj4gPiA+ID4gVGhpcyBwYXRjaCBndWFyZHMgdGhlIGRfZGVsZXRlKCkgY2FsbCBm
cm9tDQo+ID4gPiA+IG5mc19kZW50cnlfaGFuZGxlX2Vub2VudCgpDQo+ID4gPiA+IGxlYXZpbmcg
dGhlIG9uZSB1bmRlciAtPnJlbWRpcl9zZW0gaW4gY2FzZSB0aGF0IGlzIGltcG9ydGFudC4NCj4g
PiA+ID4gDQo+ID4gPiA+IEluIG1haW5saW5lIGl0IHdvdWxkIGJlIHNhZmUgdG8gcmVtb3ZlIHRo
ZSBkX2RlbGV0ZSgpIGNhbGwuwqANCj4gPiA+ID4gSG93ZXZlcg0KPiA+ID4gPiBpbg0KPiA+ID4g
PiBvbGRlciBrZXJuZWxzIHRvIHdoaWNoIHRoaXMgbWlnaHQgYmUgYmFja3BvcnRlZCwgdGhhdCB3
b3VsZA0KPiA+ID4gPiBjaGFuZ2UNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IGJlaGF2aW91ciBvZiBu
ZnNfdW5saW5rKCkuwqAgbmZzX3VubGluaygpIHVzZWQgdG8gdW5oYXNoIHRoZQ0KPiA+ID4gPiBk
ZW50cnkNCj4gPiA+ID4gd2hpY2gNCj4gPiA+ID4gcmVzdWx0ZWQgaW4gbmZzX2RlbnRyeV9oYW5k
bGVfZW5vZW50KCkgbm90IGNhbGxpbmcgZF9kZWxldGUoKS7CoA0KPiA+ID4gPiBTbyBpbg0KPiA+
ID4gPiBvbGRlciBrZXJuZWxzIHdlIG5lZWQgdGhlIGRfZGVsZXRlKCkgaW4NCj4gPiA+ID4gbmZz
X2RlbnRyeV9yZW1vdmVfaGFuZGxlX2Vycm9yKCkNCj4gPiA+ID4gd2hlbiBjYWxsZWQgZnJvbSBu
ZnNfdW5saW5rKCkgYnV0IG5vdCB3aGVuIGNhbGxlZCBmcm9tDQo+ID4gPiA+IG5mc19ybWRpcigp
Lg0KPiA+ID4gPiANCj4gPiA+ID4gVG8gbWFrZSB0aGUgY29kZSB3b3JrIGNvcnJlY3RseSBmb3Ig
b2xkIGFuZCBuZXcga2VybmVscywgYW5kDQo+ID4gPiA+IGZyb20NCj4gPiA+ID4gYm90aA0KPiA+
ID4gPiBuZnNfdW5saW5rKCkgYW5kIG5mc19ybWRpcigpLCB3ZSBwcm90ZWN0IHRoZSBkX2RlbGV0
ZSgpIGNhbGwNCj4gPiA+ID4gd2l0aA0KPiA+ID4gPiBzaW1wbGVfcG9zaXRpdmUoKS7CoCBUaGlz
IGVuc3VyZXMgaXQgaXMgbmV2ZXIgY2FsbGVkIGluIGENCj4gPiA+ID4gY2lyY3Vtc3RhbmNlDQo+
ID4gPiA+IHdoZXJlIGl0IGNvdWxkIGNyYXNoLg0KPiA+ID4gPiANCj4gPiA+ID4gRml4ZXM6IDNj
NTkzNjZjMjA3ZSAoIk5GUzogZG9uJ3QgdW5oYXNoIGRlbnRyeSBkdXJpbmcNCj4gPiA+ID4gdW5s
aW5rL3JlbmFtZSIpDQo+ID4gPiA+IEZpeGVzOiA5MDE5ZmIzOTFkZTAgKCJORlM6IExhYmVsIHRo
ZSBkZW50cnkgd2l0aCBhIHZlcmlmaWVyIGluDQo+ID4gPiA+IG5mc19ybWRpcigpIGFuZCBuZnNf
dW5saW5rKCkiKQ0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOZWlsQnJvd24gPG5laWxiQHN1c2Uu
ZGU+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoGZzL25mcy9kaXIuYyB8IDMgKystDQo+ID4gPiA+
IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4g
PiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9kaXIuYyBiL2ZzL25mcy9kaXIuYw0KPiA+
ID4gPiBpbmRleCBkYmFiM2NhYTE1ZWQuLjhmMjZmODQ4ODE4ZCAxMDA2NDQNCj4gPiA+ID4gLS0t
IGEvZnMvbmZzL2Rpci5jDQo+ID4gPiA+ICsrKyBiL2ZzL25mcy9kaXIuYw0KPiA+ID4gPiBAQCAt
MjM4Miw3ICsyMzgyLDggQEAgc3RhdGljIHZvaWQNCj4gPiA+ID4gbmZzX2RlbnRyeV9yZW1vdmVf
aGFuZGxlX2Vycm9yKHN0cnVjdCBpbm9kZSAqZGlyLA0KPiA+ID4gPiDCoHsNCj4gPiA+ID4gwqDC
oMKgwqDCoMKgwqAgc3dpdGNoIChlcnJvcikgew0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBjYXNl
IC1FTk9FTlQ6DQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRfZGVsZXRl
KGRlbnRyeSk7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChkX3Jl
YWxseV9pc19wb3NpdGl2ZShkZW50cnkpKQ0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZF9kZWxldGUoZGVudHJ5KTsNCj4gPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5mc19zZXRfdmVyaWZpZXIoZGVudHJ5LA0KPiA+ID4g
PiBuZnNfc2F2ZV9jaGFuZ2VfYXR0cmlidXRlKGRpcikpOw0KPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIGNhc2UgMDoN
Cj4gPiA+IA0KPiA+ID4gT0suIEkndmUga2lja2VkIHYxIG91dCBvZiBteSBsaW51eC1uZXh0IGJy
YW5jaCwgYW5kIGFwcGxpZWQgdjIgdG8NCj4gPiA+IG15DQo+ID4gPiB0ZXN0aW5nIGJyYW5jaC4g
SSdsbCB0cnkgdG8gZ2l2ZSBpdCBzb21lIHRlc3RpbmcgdG9tb3Jyb3cuDQo+ID4gPiANCj4gPiA+
IE9sZ2EsIHdpbGwgeW91IGJlIGFibGUgdG8gdGVzdCB2MiB0byBzZWUgaWYgaXQgZml4ZXMgeW91
ciBidWcNCj4gPiA+IHJlcG9ydCBhcw0KPiA+ID4gd2VsbD8NCj4gPiANCj4gPiBXaWxsIGRvLg0K
PiANCj4gRmluaXNoZWQgdGVzdGluZyBzdWNjZXNzZnVsbGx5LiBUZXN0ZWQtYnkuDQoNClRoYW5r
cyENCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
