Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C62E60ECCE
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 02:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJ0ADN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Oct 2022 20:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiJ0ADK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Oct 2022 20:03:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2117.outbound.protection.outlook.com [40.107.223.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E99773B5;
        Wed, 26 Oct 2022 17:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNni5RRBFy+xpPXW0OVNdVaxyaP/TZ9+gyM6uAkjDkPCWk/38ar+hhPnMFbeyEmjGup09AzyrQ9j0Z+XjTCzxgErrljQL1KIUlV//A/AZetPLS1LFnzGSMsxFNDO5m/oM/tzPpwKDFXd0ETenSPwNHMKKQSRTjpJ9VXt7oGoBXGykPxLEQWd5SBMcZWHw4SMitr0LRCxSKsRZWriOmIDKzU3fE8jxfgcMPDCOVrvtKDTs6gnFAdU8EVSPQjsls6C3ebsOy4KJ4bAUBGEnAZip6HApsqYFrl7kYGCmhExcVJEs5sTkZmKksxSZtoHEiL2A2btooxKab2cD98AWS76Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSV/t79MmIixr6dsQGexVn9UHMU2vwEdDLTGhx2Z1b0=;
 b=aom0cz4J6AdnuUw+XxGq4xF5TElWQeUuT0LW2r+UN+POfBzUNuHyY7N5XozcIao4UF3bvz9k3D2EKNB+jBKtQ506tA1h44u1hkIeCcgLWQZWZ2373hFsq49mWBlHhuqDY8tpW3YwENe2M3NnYmO85G69NtPwD0uKS6SpVdz3Fwv0WXxSxJCpN/71x3ipYvvnv6/qS6kih8OLs6NzDHC+5invkx1oQ4bf+S3ftqcbpSwwEJ2a9mFklnjf6sZW9SYspbDjqJ31CPf0u1B9r/FvS2JYU+ZWpzi1bRMPmLJzGRWEcUNijjt5A4rfE+XOJps1RCskr0CsYBCSlcRamqPiYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSV/t79MmIixr6dsQGexVn9UHMU2vwEdDLTGhx2Z1b0=;
 b=QjMCJ2fK74/EzERP4VOGFQxKKJ1PzEWNvHrndK3U11gSlBwhg23wKT66kZzErBoiVOFG/N0T8fSv9l6SPdRX9jSEG7g/pijiH8nkJ5OKb++vDSMin0Q2o1S6waWO5aZPXKrrg00VkYlU09l4hDIv0pV6ZJZScj+Tf/sccaQZJtg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SJ0PR13MB5524.namprd13.prod.outlook.com (2603:10b6:a03:421::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.18; Thu, 27 Oct
 2022 00:03:07 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::9927:a5a2:43a2:4801%3]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 00:03:07 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     Kees Cook <keescook@chromium.org>, Anna Schumaker <anna@kernel.org>
CC:     kernel test robot <yujie.liu@intel.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dave Jones <davej@codemonkey.org.uk>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2] NFS: Avoid memcpy() run-time warning for struct
 sockaddr overflows
Thread-Topic: [PATCH v2] NFS: Avoid memcpy() run-time warning for struct
 sockaddr overflows
Thread-Index: AQHY4eIXhHjVxdpaDUmTcKhw/diGna4hYrUAgAAIdoA=
Date:   Thu, 27 Oct 2022 00:03:07 +0000
Message-ID: <35A4B422-29FF-4294-8596-D75FC60E55DE@hammerspace.com>
References: <20221017043107.never.457-kees@kernel.org>
 <202210261631.DE7E4761E@keescook>
In-Reply-To: <202210261631.DE7E4761E@keescook>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.200.110.1.12)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|SJ0PR13MB5524:EE_
x-ms-office365-filtering-correlation-id: 7fa9d169-7f06-43e8-ab27-08dab7aea0bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qXodDATj2DzUZbfNc5/ypVOjhHJ5GFLGKuaJi8gBSNc9uHowrDaxlo3R7cs/cz1wA3wxF5OnwAQC78ISgMlJ7OPyEEKKmcSGtsdb2aR5l7dgkZd3D/sielOcb9ef/TzIkLrgf64NZv7kArtKBEkLGChse/UsUepzszK6DvIIQzH7gCXWfzDObcmCSQmIiktz2/OfLdhOTTvYVm2GRc2fCGzunAJz4cfjNI1asnP+nkAEkLd4Hbp8BABNrb5JOMuOmrAZ14cj95MDF/3NSW00WhEbNtgLkVEXDmgGiWu7miZgaH8jGCzBJzeULVfYAOrfIrel7AhwdG0u9ZtgpESi8W885KNWce3he/gXaiPWkpqsZ2Jhw9EYDbas24t3i0MZ1gnX3bfnUvo/q3AgvHlq6GfTZ+pdqsLmAXyQMHpKi3h3lGbxrbOEmpKn9ONaWlfC7VadJAVgNSMx9MFSMWOyg5+WxEOmZIA81QjxOChLFfV3zZASdHant73IeV2+aN0aHKsmVLKh3dOQLUkhqtLNt6iHE2rxCdnmETFjnW4wduJFI6mJVs7gaXiPvKTVqSw7aSSfolBsy6H5BgcBMwiB9SHe1zEGXwyBGSMALp/acA+OlAljafhrMSmx9vO2F06bgT+j36MR0yvr8TEWVC13pZxO0+JbK3F52sTabzP4L0CVvv1dDQkQlFr4Dsqdbx3sLVJjdO4EyHDM73JOpGEKWYxrFplz/ZuJ0p20lnw8j3iZgpqhylwMIwSDLkd/PXip51WJV0/mUyuszlCICYXtCrgJ1jh+/ucUwaJ42BbL/Qji0l4qVR8hAuNPhRuwOCSXIEqpvNQUa7V9RWCGGLy1TzETgCDC6Qy9DoipyIuFrlmH30pFgL3Zf3Zjv++7JD5x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39840400004)(376002)(396003)(366004)(346002)(451199015)(122000001)(186003)(26005)(110136005)(53546011)(86362001)(38100700002)(2906002)(6506007)(6512007)(6486002)(966005)(2616005)(5660300002)(71200400001)(54906003)(478600001)(41300700001)(316002)(66476007)(8936002)(38070700005)(76116006)(33656002)(66946007)(66556008)(64756008)(36756003)(8676002)(66446008)(83380400001)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjRiMW5lVDJHSjJtd0gxNk96YUZncHFtWTg4Vnlod2lnLzRIL3hLQ2RScDlx?=
 =?utf-8?B?WUNkRUxuWEhBWXl1Vzd3YVFTMytTSllKZVoySktQak1WN3RQRUJHMDFYMXdl?=
 =?utf-8?B?djBmaW1vLzBicm84ZEljZ0JmUWlwSlFDaG1FemtaTnkrSmFvTW05YWFsNGR1?=
 =?utf-8?B?Y0wzMGs1dS96WmM3Zm96YzB2UkFIL2JQWkJwNWw2Slc5VGcvQlJrdE00RTVL?=
 =?utf-8?B?VDk5aWZwaEtPcGRzVUMwS2dUVWF3OVpQY05DV0p0SUliSmF3NmxaWEVHRWFB?=
 =?utf-8?B?UWZaTUVUOGVJZXlWZEVRVmFrZmxSSU0ralkxa2hqOEVZVzFLdTk1dU5OUXZn?=
 =?utf-8?B?blkzZkhSVW1HTU44cmtMbzNBUjMzOEM4VmRFektPdXFDckQ3WTlmU1c5M1Bq?=
 =?utf-8?B?Nk1vUVk5QnVlWm15TDdHSHR6NTRRdXFiYXUwcDhlSXBkM0VQNXdSWlRvaU9l?=
 =?utf-8?B?allBeEtIb0dCYUJoaFBubXU2Yld3U1dvZEtNZlFoRW9qZTd1dkdaY3RGQkNM?=
 =?utf-8?B?M2ZIOTlqaFRxSjgzbWpJN3o3RHRmSDAxT0xHRS9qNnZOUTd3MGdnNzBZTlBp?=
 =?utf-8?B?Sm9DVzZEdGwvNzM4QWZvWG1sOGhPeGMzVklVM04yS29EdU1oK3Q4SjB0aGZz?=
 =?utf-8?B?dkZ2YkNIV2d2QnRRM0YwWm9yU1hza0krM3VnRGdXbDlYekhORXJRR0FnTEpW?=
 =?utf-8?B?NmZUdWptb2tUWVRaQzJ6NXZ2NFFPZEtIMWUra1BxcTlGOTR4VUlSUHg2Mnd2?=
 =?utf-8?B?UXVTZ0dIcXJoZDB4aldhbjI3TEtyQTZoa1FYaDhERzhNTFZoM1ZmNGxxSnh3?=
 =?utf-8?B?TklVU04vUWF0cm1ZdXVCa1RUL1UwVWoyZGY0YS9kL3ZWMUlhS1U4bEZVYkhl?=
 =?utf-8?B?bFlYNTJSQ0R3UTJLQll6b09ad0VqdWFVWjB0aUxCTmhuODR1MnhpdTk2MnJm?=
 =?utf-8?B?TXM4aEZvK3R4L052OFNQSDJ5V3IrUHhPUWU1RHI4U0pvenNiU2lUdDNJTk1x?=
 =?utf-8?B?b2RNL3IvelBsWVNCUzhseVN2OExONGQ2YUR1V2h2akRiMExBQXg0aUQ1bEc5?=
 =?utf-8?B?ZVJhYlRPVml3UDJuV205ek9CQmtzT3pkbEw0c0xNakN4bkN0cCtTK1NmVEcz?=
 =?utf-8?B?N1ZEMFpCalArODJNdm9aUSt6QXc4RW1SOWhIYnc0Qkdrb1dLT2hBTi9zSjJC?=
 =?utf-8?B?UTJWSjZzcnoxUkY4dk9yNXZHZEVEWkVCRjVrU1h3eVpOT2lFYitKQ3RDTlds?=
 =?utf-8?B?WGdNS1JiS1NxMHdiYmNVSlpaVzlnV1B6cmtKZjBtSkhybEhqaDJMM2YvYmw3?=
 =?utf-8?B?SnV5em5uUmFJTDcyNTFCTXRMQjhHUFI3OEZicFBTU09xRnp3REU4T09wSzZK?=
 =?utf-8?B?TDIvWlZuS0NZU1VmNXRQWUppU1hEWFN6enpsT3h3TU1relNHbHBNYkp3NHpE?=
 =?utf-8?B?djBwTjZ6T1dSQmh0RDZ5eVNhaUlUdEVhVTBrdkcyejc2WlpxVytBY2xGQzBk?=
 =?utf-8?B?Zm1uVFBubzc1NTJOMVpoMWdTTm9hUHIrNm0rQ0dFdlN4Z1dpQ1pQdVdGc1kr?=
 =?utf-8?B?VDJtSDVqM3RVQzlUUCtKcG1tZTNxN01nOGJGMGhWNU42bjV6eldnTm9DTjBt?=
 =?utf-8?B?L0ZDTUJkSEVvTHhpRWJOMVBiWHZCQ3JmRWVCSFo0Q2pHdGF1aitnQ3ZFdE52?=
 =?utf-8?B?RjhsVlpQWFF6UzIxem8wc1pxc0RvdkRYNDNYRFBwYjNla0wzM3FycEJwVEFp?=
 =?utf-8?B?L08weDBuSEhEcHRyTndEOGVNTlJGTUVNMHpiejJ2alE4ZDE0Y2JnWlhuQVln?=
 =?utf-8?B?S3ZtaDVxQm1hN0c1UytCRWdvMnh0eHZ0OS9saTlpWVl2a2wwTWVLYUZmejdv?=
 =?utf-8?B?aDgzRXZiaHBYMXlKWWhvUmgreUo3ZEV4OFRUaHVsU3grQzFBVDVHcytwbjFL?=
 =?utf-8?B?VVM4NU8vNTlEbFUrL0gvRS9QNVZDM25MWmYwdCtJY2F4cjdxb3RlM00vNXpo?=
 =?utf-8?B?RkxkSGpEVTFwK09HdGxsZzFudVlpNk93ZnZKSHgwbCtOalZiRFJBOGdIWW8v?=
 =?utf-8?B?aXZZL2RQSlRRNCtsOThJZk40UXFkUWlxVTA2bEZDWG1aVnZRdnBMdnpyQ3Qy?=
 =?utf-8?B?Y3FJSEtVV0pUcVI5WXNGRXBxWGo3Y1dnNGJ0ZFl5SFJxbGk1cUZ6ZjhpODhT?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D65EC88408E09459B6268D0E9D9E352@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa9d169-7f06-43e8-ab27-08dab7aea0bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 00:03:07.4698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knr3rz8oXYlCfSFokXGow8bnjORuD5MocdBxwKvBjhuLNUm9ySIywFlyhBPiamhnH91yK2iFjDHsXzl+H+Tq0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gT2N0IDI2LCAyMDIyLCBhdCAxOTozMiwgS2VlcyBDb29rIDxrZWVzY29va0BjaHJv
bWl1bS5vcmc+IHdyb3RlOg0KPiANCj4gT24gU3VuLCBPY3QgMTYsIDIwMjIgYXQgMDk6MzY6NTBQ
TSAtMDcwMCwgS2VlcyBDb29rIHdyb3RlOg0KPj4gVGhlICduZnNfc2VydmVyJyBhbmQgJ21vdW50
X3NlcnZlcicgc3RydWN0dXJlcyBpbmNsdWRlIGEgdW5pb24gb2YNCj4+ICdzdHJ1Y3Qgc29ja2Fk
ZHInICh3aXRoIHRoZSBvbGRlciAxNiBieXRlcyBtYXggYWRkcmVzcyBzaXplKSBhbmQNCj4+ICdz
dHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZScgd2hpY2ggaXMgbGFyZ2UgZW5vdWdoIHRvIGhvbGQgYWxs
IHRoZQ0KPj4gc3VwcG9ydGVkIHNhX2ZhbWlseSB0eXBlcyAoMTI4IGJ5dGVzIG1heCBzaXplKS4g
VGhlIHJ1bnRpbWUgbWVtY3B5KCkNCj4+IGJ1ZmZlciBvdmVyZmxvdyBjaGVja2VyIGlzIHNlZWlu
ZyBhdHRlbXB0cyB0byB3cml0ZSBiZXlvbmQgdGhlIDE2DQo+PiBieXRlcyBhcyBhbiBvdmVyZmxv
dywgYnV0IHRoZSBhY3R1YWwgZXhwZWN0ZWQgc2l6ZSBpcyB0aGF0IG9mICdzdHJ1Y3QNCj4+IHNv
Y2thZGRyX3N0b3JhZ2UnLiBQbHVtYiB0aGUgdXNlIG9mICdzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFn
ZScgbW9yZQ0KPj4gY29tcGxldGVseSB0aHJvdWdoLW91dCBORlMsIHdoaWNoIHJlc3VsdHMgaW4g
YWRqdXN0aW5nIHRoZSBtZW1jcHkoKQ0KPj4gYnVmZmVycyB0byB0aGUgY29ycmVjdCB1bmlvbiBt
ZW1iZXJzLiBBdm9pZHMgdGhpcyBmYWxzZSBwb3NpdGl2ZSBydW4tdGltZQ0KPj4gd2FybmluZyB1
bmRlciBDT05GSUdfRk9SVElGWV9TT1VSQ0U6DQo+PiANCj4+ICBtZW1jcHk6IGRldGVjdGVkIGZp
ZWxkLXNwYW5uaW5nIHdyaXRlIChzaXplIDI4KSBvZiBzaW5nbGUgZmllbGQgIiZjdHgtPm5mc19z
ZXJ2ZXIuYWRkcmVzcyIgYXQgZnMvbmZzL25hbWVzcGFjZS5jOjE3OCAoc2l6ZSAxNikNCj4+IA0K
Pj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDx5dWppZS5saXVAaW50ZWwuY29tPg0K
Pj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIxMDExMDk0OC4yNmI0MzEy
MC15dWppZS5saXVAaW50ZWwuY29tDQo+PiBDYzogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPj4gQ2M6IEFubmEgU2NodW1ha2VyIDxhbm5hQGtlcm5l
bC5vcmc+DQo+IA0KPiBGcmllbmRseSBwaW5nIC0tIHRoaXMgbmVlZHMgdG8gbGFuZCBpbiB2Ni4x
IHRvIGF2b2lkIHRoZXNlIHdhcm5pbmdzLg0KPiBTaG91bGQgSSBjYXJyeSB0aGlzIGluIHRoZSBo
YXJkZW5pbmcgdHJlZSBpbnN0ZWFkPw0KPiANCj4gVGhhbmtzIQ0KDQpBbm5hLCB0aGlzIGlzIHlv
dXIgY2FsbCBzaW5jZSB5b3XigJlyZSB0aGUg4oCYNi4xIG5mcyBjbGllbnQgbWFpbnRhaW5lcuKA
mS4uLg0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg==
