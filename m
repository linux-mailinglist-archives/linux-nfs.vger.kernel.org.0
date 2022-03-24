Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF924E6A7A
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Mar 2022 23:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355245AbiCXWCx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 18:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355231AbiCXWCv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 18:02:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2108.outbound.protection.outlook.com [40.107.244.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D6CB91BA
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 15:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=matZApOCR1sCYHDNcG3SeCpGVQgQIqCbNn/6tob/pKt8whTORreyB6rHHA0tDIAAljB+7bHRHV8wRgD7if7ogl4tcTKTIB0IyJauK676lzsonV8ZLfvXQwcpJBKSmr/bLOZq/JrP7lFEF003GOfW5cuOCusnk0xGXjBUysO/hPnpjVJF6mAfCWTk5oFYxLdDna+80cshbDcEdIrqQvXOtOo8rkGVSUuf9IevWLxW1cQg4KHzP9ca9vKsWqydWPzGkpiSTnXbx1/4XDTfD8Fr24rGmEkLs/oDJxCN+fcn7Co9d8LlQc0e6MACQy0APNQTAENHimHTKPU4ltdOqSRNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXZekReOORCT5M9rBSpBMo4FoBMYxYTTTs2UNhZ1R9k=;
 b=GLmEm1AmSNQtAT32XyqmuHRVkkK1PClkL/fgn38cscEqBAbd7CLMe2y0qt/OEQL4Jpw6FSbOmfGJaDLcjExVZX6maXp6QN+Elan5fwX/QB4cHeqGjd2SoHqiZGbS+QpAQy98UAkcJrdOYuMd26uyUuGlAz7yAOZKInmfthtENywPXhec7ysAcqhRjSQGHr/CVqSOFgO3COoJJDW62rlYlAy62+wv+rtxpokSXHBYcamh/YisP+dZL6eA6soDeNeKlLVyrUlao1Qkmo+TU31V2DYp1OAtK7DBvv6VyzIW3Hp9x6TVfMeqR76t3Tp5gH4jv/ir5atT/0j7639/YjijBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXZekReOORCT5M9rBSpBMo4FoBMYxYTTTs2UNhZ1R9k=;
 b=KA/FPBKEcnvYoZ4vtU67ck5aYuLcT120765x2f4sAvucbIHCtLl/Or6QvSykjZiEx1m8yAEvJ6xnJ/enqDSeqBft0O2GSpsnAV1lJKYOFty8ahvr3gbbzUoKBTDbQISnp7UP8rMHDYFeYN45eoq3bK8oWS4JStwxKxOCRsXpZZ0=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 SN6PR13MB2413.namprd13.prod.outlook.com (2603:10b6:805:5c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.8; Thu, 24 Mar 2022 22:01:13 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::2133:d05a:fc92:53ce]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::2133:d05a:fc92:53ce%8]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 22:01:13 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] SUNRPC: Do not dereference non-socket transports in
 sysfs
Thread-Topic: [PATCH 1/2] SUNRPC: Do not dereference non-socket transports in
 sysfs
Thread-Index: AQHYP8e26iJ+RH7mvEKlnUExzepx/6zPEJIAgAAFNwA=
Date:   Thu, 24 Mar 2022 22:01:13 +0000
Message-ID: <708667abb8e46695915c40aa8e33776f806f84f4.camel@hammerspace.com>
References: <20220324213345.5833-1-trondmy@kernel.org>
         <80AE76C3-4D6D-4495-AD45-34EC73B12CEE@oracle.com>
In-Reply-To: <80AE76C3-4D6D-4495-AD45-34EC73B12CEE@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54fbf476-cdb2-4150-c01c-08da0de1d02e
x-ms-traffictypediagnostic: SN6PR13MB2413:EE_
x-microsoft-antispam-prvs: <SN6PR13MB2413313DD352818F11B1FEAFB8199@SN6PR13MB2413.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 32VEbDJWfGwZ78pWZFUxLeYNlOA4fQyGi9k9nFiRF8vbcj17cZLN1WojeY8COLzP8mfLFNN64Te9Kjcnl9GnTPruhnDea4k4yjunxKuzeC6DHxON5OmSmP6CmW975ebnyPqgZ0SHIj5fArz7oo/4e4GVhlGBJ2cchLPuUMnWWmiFTw869rDwkXDHWXsxGD1yshaRrdB5O/Igv/OiLESt0ayreABPOU2etD/buYB/oE+bw1ElyYPtBGA1vfrqt09WIAC7g9sMZujFnMLoSk1Drw9i3zutMK8jpSj+tU2Myj+xTBPQHfmAkGicRp1lyryUIlxan9BvXKk+NTG64/KRUoKBSYphgzVXYiHPld/pI0gGd2Kb9fqNSQbNVMCn/GtO3JT9EgkYjz50xqcx9w1HK68nZ1InM7srPo28WM2Dd7J3NU50FiDFZL4GWqQuqz65V5c1k5vFmkwMnp+t6FoiDd8ZrZEm/U754MD5BCoxCwynZawgGdhBaSZQudtQfQzxAmriuaSn4UStX5K3u7THrQXlEOn4bWdY67z4UUNI+q8RSLunTq0u6yGprF8mQeLgHfbAHDRgfRT1fC0xCoWnM35Vu7UiqeGT6DOPO3e+ubI5pybLCilsRsINRMSp8y1Djd5g4iHaEAA6bSbuSq+/QXP6KXDne6FjifsAptTYTuoCV4atQbNmMzQs/o9kjdPPYf80QI54qiHzy5cj72t0CdkHcZePmfs8ZazZ6yabuAuaqC/Yi39UWpI9L6TiGodi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2616005)(26005)(71200400001)(53546011)(83380400001)(6512007)(2906002)(5660300002)(8936002)(6506007)(316002)(91956017)(6486002)(6916009)(508600001)(76116006)(66446008)(66476007)(66556008)(66946007)(64756008)(4326008)(8676002)(36756003)(122000001)(38100700002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVFZQnhTSERaTHZNTHlrbCs1TGIvb0UvRmhUcUVjWmFLa0pXeWlKaWdjK3J5?=
 =?utf-8?B?Y2J1MFRHcWlCZU9NTUswQXU3cXUrdFVybVk4SE9Yd1draXd3NVpRUURyb0Mr?=
 =?utf-8?B?TG5GQ1dKUVpUR0dkQm9pdGI0LzdVTGh6NGVucS8yVkxFd1BGRUlKNE9oUnZN?=
 =?utf-8?B?NE0vL3g0a1B0TzAzZHNuYnd3RzBIVnBpb0lQUmo0K1RoaHRCSFd5K2p1TzN5?=
 =?utf-8?B?KzlCbXRVN1JLNjNyc0FiNVBxUTdoeCtDN1RKS1ZWclFhWUtPTEFIR1lLN3Br?=
 =?utf-8?B?cDVYaUtla29RdkljMHgrNTNQQm9USk9UZUdlbVpORnpiZk9mNkxrUG1YN25L?=
 =?utf-8?B?YnRpalpQVnNEZHBKcjEwTjkzVTZvSFZjY3N5Z1lqU2s1cE1TQkp5RkRrWnk2?=
 =?utf-8?B?ajhpRzFKSEZUUGdlWW84NjJKRjhLa1pRNFN3WGZ0L0l3VXdGUTlnbnNpNEVS?=
 =?utf-8?B?WE1HRUhBakhVWWJRUmxtT29QMXNKUW8vU1IrQ3V5YUptQ1cyWXVsN3lXNFpk?=
 =?utf-8?B?a3ZIdENXZFhIMkFUVC9kbk1XYjYvd0VUM2c5ZUdMTDBmTmFIVWhPZG9rdEFx?=
 =?utf-8?B?WStFbnVUQmNMYkxEOHRwYmVSWTlNZmZ5eEl6TllSeE45VDNIMkN3dXRyZDhE?=
 =?utf-8?B?NkJReWRjQm85b2NidHpCbkc5aXkwZjV2VGNPLzZKOUVtMDFoMmw0c29hVnAy?=
 =?utf-8?B?SkV6azZaaXArZXlxWGNjUlBJTXVSMHQ3d2RhcHNCVzNlUFhIRmhEeGVMSE1C?=
 =?utf-8?B?d1lXbW5HU2JMdUp3UzE3eEI2d1Z4bUFoVGlBQnZUcU1JUldxaHFMdDBIWWtr?=
 =?utf-8?B?MHR5TStZZ1BaTGROeXY2bHRKVXpTZ2dyazkxKzFaSXdlZFpkc3lkSDlVd1NR?=
 =?utf-8?B?aW5OZjN3Q09xb0RuTURiV2pBR2dkN3ZXNXJ5THBBTTlVckNqNEpSM1VYVzF6?=
 =?utf-8?B?dm41QkUydlJ3RC9hSHc4OHJHVERZSDllM3M0QkprZWhkb1JoTmNxaDlIZUpE?=
 =?utf-8?B?QzViTmFiYm1yajMyTUx1ZUJZM09OMkpST0t4djUySWpMdEIxS1VIQWV4ZlRJ?=
 =?utf-8?B?S2lVZmNyZFZ1L3pEK045RktFU0wrempDOEkyVm5HNXZtNUp5RHpBSDlXdkhX?=
 =?utf-8?B?cFFsaXprUnNnWFVha2VxSnRIT3M4U2VtRmFiTUhzMG9MbFRuNzBPRDJtR0Qr?=
 =?utf-8?B?VzdiMDFHSUFsd3dab1IwYVFURjN5UnBmR21BdDVFUEFWTDFsbVo4cUJld2k2?=
 =?utf-8?B?OGUxZ2cvT0xNZldNaEZreWtNQUk0eUdGYXc5bVp1cEVmclpHNCtwaDRPYmxp?=
 =?utf-8?B?U1REdFJIM1hDYTJvZVA2bGFyb3ZoU05teC9FUFRJNXFUKzYxOVBiV3RDellx?=
 =?utf-8?B?RExnRWh6R29ibG9GM2czaDVtSjNBSUpkMkRWTlhGMEp0SVUyN1N5WFZjVFRZ?=
 =?utf-8?B?NDdYQkl1dUVPM24xNlBvaEJzaElXdU82NURoTWJVaUc4NW1nWjY2dWF0UzFP?=
 =?utf-8?B?b245NmVTWE9iSnlYSnRZSk0zZUFzZjBhcDlBVTAwYmJmRTgxUUc5eGxVM0J0?=
 =?utf-8?B?UEVzSmszNmVTd2JJc3Q5SGRDVnpreVV6V09qcnA3enhJLzVHbitjQ0d4L0VI?=
 =?utf-8?B?M0hZZTJHemx0YkZzdkg2dzlLZDNxbjZ3SC96cXFOVE1ndXN0M2F6NGlwZEdo?=
 =?utf-8?B?QkpQYlc1UjErZm1wRzZDZ0haZWtvNlNGZG1yTkhoN2N4OTd3TktQVmdvZzNK?=
 =?utf-8?B?Y1R5bFhlcjA0RlBQNEVCd0UxNGtGVTFJWmEyZDBleEZrMWFtOWRYTkI2bUg3?=
 =?utf-8?B?VFZRY2E1TVlJQjlPTnpIWHNBdFcySU1ZMGY0Z1pIbTVSMGVBLzVtZG1IMmxw?=
 =?utf-8?B?VjdDbE01bHlzVVV6cXhpZlhYRWVGUUJNaFBJRTdacXBscVNsVWxCQnlhQTlj?=
 =?utf-8?B?MjJzMVBUQVdRMkNBNitZWjJYb2RPbUducUt3UjZLTWFxb2VWOWk0UzNJTWJN?=
 =?utf-8?B?c3RUeUJJMGZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A603303F3F6CF74B9757E3E7BBF883A8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fbf476-cdb2-4150-c01c-08da0de1d02e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 22:01:13.6624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KgSyFuSazhxlfBP23KCs30mpZjq0J5zkemovHVaedc6QIMNh2VvHZaPpEIMaQ5sckulFMiGrD+dus9bO73KuTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2413
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTAzLTI0IGF0IDIxOjQyICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
Cj4gCj4gCj4gPiBPbiBNYXIgMjQsIDIwMjIsIGF0IDU6MzMgUE0sIHRyb25kbXlAa2VybmVsLm9y
Z8Kgd3JvdGU6Cj4gPiAKPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbT4KPiA+IAo+ID4gRG8gbm90IGNhc3QgdGhlIHN0cnVjdCB4cHJ0IHRv
IGEgc29ja194cHJ0IHVubGVzcyB3ZSBrbm93IGl0IGlzIGEKPiA+IFVEUCBvcgo+ID4gVENQIHRy
YW5zcG9ydC4gT3RoZXJ3aXNlIHRoZSBjYWxsIHRvIGxvY2sgdGhlIG11dGV4IHdpbGwgc2NyaWJi
bGUKPiA+IG92ZXIKPiA+IHdoYXRldmVyIHN0cnVjdHVyZSBpcyBhY3R1YWxseSB0aGVyZS4gVGhp
cyBoYXMgYmVlbiBzZWVuIHRvIGNhdXNlCj4gPiBoYXJkCj4gPiBzeXN0ZW0gbG9ja3VwcyB3aGVu
IHRoZSB1bmRlcmx5aW5nIHRyYW5zcG9ydCB3YXMgUkRNQS4KPiA+IAo+ID4gRml4ZXM6IGU0NDc3
M2RhZjg1MSAoIlNVTlJQQzogQWRkIHNyY2FkZHIgYXMgYSBmaWxlIGluIHN5c2ZzIikKPiA+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1
c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+Cj4gPiAtLS0KPiA+IG5ldC9zdW5y
cGMvc3lzZnMuYyB8IDMyICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tCj4gPiAxIGZp
bGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRp
ZmYgLS1naXQgYS9uZXQvc3VucnBjL3N5c2ZzLmMgYi9uZXQvc3VucnBjL3N5c2ZzLmMKPiA+IGlu
ZGV4IDA1Yzc1OGRhNmE5Mi4uOGNlMDUzZjg0NDIxIDEwMDY0NAo+ID4gLS0tIGEvbmV0L3N1bnJw
Yy9zeXNmcy5jCj4gPiArKysgYi9uZXQvc3VucnBjL3N5c2ZzLmMKPiA+IEBAIC0xMDcsMjIgKzEw
NywzNCBAQCBzdGF0aWMgc3NpemVfdAo+ID4gcnBjX3N5c2ZzX3hwcnRfc3JjYWRkcl9zaG93KHN0
cnVjdCBrb2JqZWN0ICprb2JqLAo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBycGNfeHBydCAq
eHBydCA9IHJwY19zeXNmc194cHJ0X2tvYmpfZ2V0X3hwcnQoa29iaik7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2Ugc2FkZHI7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
c3RydWN0IHNvY2tfeHBydCAqc29jazsKPiA+ICvCoMKgwqDCoMKgwqDCoGNvbnN0IGNoYXIgKmZt
dCA9ICI8Y2xvc2VkPlxuIjsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzc2l6ZV90IHJldCA9IC0xOwo+
ID4gCj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAoIXhwcnQgfHwgIXhwcnRfY29ubmVjdGVkKHhwcnQp
KSB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeHBydF9wdXQoeHBydCk7Cj4g
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9UQ09OTjsKPiA+IC3C
oMKgwqDCoMKgwqDCoH0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmICgheHBydCB8fCAheHBydF9jb25u
ZWN0ZWQoeHBydCkpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7
Cj4gPiAKPiA+IC3CoMKgwqDCoMKgwqDCoHNvY2sgPSBjb250YWluZXJfb2YoeHBydCwgc3RydWN0
IHNvY2tfeHBydCwgeHBydCk7Cj4gPiAtwqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZzb2NrLT5y
ZWN2X211dGV4KTsKPiA+IC3CoMKgwqDCoMKgwqDCoGlmIChzb2NrLT5zb2NrID09IE5VTEwgfHwK
PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoCBrZXJuZWxfZ2V0c29ja25hbWUoc29jay0+c29jaywg
KHN0cnVjdCBzb2NrYWRkcgo+ID4gKikmc2FkZHIpIDwgMCkKPiAKPiBUaGlzIHdvdWxkIGJlIGEg
bGl0dGxlIG5pY2VyIGlmIGl0IHdlbnQgdGhyb3VnaCB0aGUgdHJhbnNwb3J0Cj4gc3dpdGNoIGlu
c3RlYWQuIEJ1dCBpc24ndCB0aGUgc29ja2V0IGFkZHJlc3MgYXZhaWxhYmxlIGluIHRoZQo+IHJw
Y194cHJ0Pwo+IAoKSSBhZ3JlZSB0aGF0IGEgZm9sbG93IHVwIHBhdGNoIGNvdWxkIG1vdmUgdGhp
cyBhbmQgdGhlIG90aGVyIHNvY2tldC0Kc3BlY2lmaWMgY29kZSB0byB0aGUgc3dpdGNoLiBIb3dl
dmVyIHRoZSBwb2ludCBvZiB0aGlzIHBhdGNoIGlzIHRvCnByb3ZpZGUgYSBzdGFibGUgZml4IGZv
ciB0aGUgbWVtb3J5IHNjcmliYmxlLgoKLi4uYW5kIG5vLCB0aGUgc291cmNlIGFkZHJlc3MgaXMg
bm90IGF2YWlsYWJsZSBpbiB0aGUgcnBjX3hwcnQuIE9ubHkKdGhlIGRlc3RpbmF0aW9uIGFkZHJl
c3MgaXMgc3RvcmVkIHRoZXJlLgoKPiA+ICvCoMKgwqDCoMKgwqDCoHN3aXRjaCAoeHBydC0+eHBy
dF9jbGFzcy0+aWRlbnQpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoGNhc2UgWFBSVF9UUkFOU1BPUlRf
VURQOgo+ID4gK8KgwqDCoMKgwqDCoMKgY2FzZSBYUFJUX1RSQU5TUE9SVF9UQ1A6Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gPiArwqDCoMKgwqDCoMKgwqBkZWZh
dWx0Ogo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZtdCA9ICI8bm90IGEgc29j
a2V0PlxuIjsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7Cj4g
PiArwqDCoMKgwqDCoMKgwqB9Owo+ID4gCj4gPiAtwqDCoMKgwqDCoMKgwqByZXQgPSBzcHJpbnRm
KGJ1ZiwgIiVwSVNjXG4iLCAmc2FkZHIpOwo+ID4gLW91dDoKPiA+ICvCoMKgwqDCoMKgwqDCoHNv
Y2sgPSBjb250YWluZXJfb2YoeHBydCwgc3RydWN0IHNvY2tfeHBydCwgeHBydCk7Cj4gPiArwqDC
oMKgwqDCoMKgwqBtdXRleF9sb2NrKCZzb2NrLT5yZWN2X211dGV4KTsKPiA+ICvCoMKgwqDCoMKg
wqDCoGlmIChzb2NrLT5zb2NrICE9IE5VTEwpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXQgPSBrZXJuZWxfZ2V0c29ja25hbWUoc29jay0+c29jaywgKHN0cnVjdAo+ID4g
c29ja2FkZHIgKikmc2FkZHIpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
IChyZXQgPj0gMCkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXQgPSBzcHJpbnRmKGJ1ZiwgIiVwSVNjXG4iLCAmc2FkZHIpOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmbXQgPSBOVUxMOwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+
IMKgwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJnNvY2stPnJlY3ZfbXV0ZXgpOwo+ID4gK291
dDoKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChmbXQpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0ID0gc3ByaW50ZihidWYsIGZtdCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgeHBy
dF9wdXQoeHBydCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldCArIDE7Cj4gPiB9Cj4g
PiAtLSAKPiA+IDIuMzUuMQo+ID4gCj4gCj4gLS0KPiBDaHVjayBMZXZlcgo+IAo+IAo+IAoKLS0g
ClRyb25kIE15a2xlYnVzdApMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
CnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20KCgo=
