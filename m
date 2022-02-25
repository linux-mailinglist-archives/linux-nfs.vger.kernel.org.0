Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F654C3CAB
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 04:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiBYDvy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 22:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbiBYDvx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 22:51:53 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2126.outbound.protection.outlook.com [40.107.220.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981F520A94A
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 19:51:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsHDsiB0g/cAPIGklADPQxz4D0ZRKwfAeNVD4tzQK8MCtD2dhpH/a+RY9wQTR1RfcLLnwC5HTbxj8dFwFm9km9YRNKPWP0xqkuUT6vwnLeqH5r2WLd7294nRuarMFALsgPBXiL6qozaNXj36wtq4bmwZ9vac3Pj5bYZT+rgdTZgpFnhATvFllpqMGrz7iRj7JyVdlqSSL59jJx85QyvkYTMhplxjm6wPydtkNytFtOXY999tt23buKxzoQVV7Q/IgIAfw/v5xKW/0ITH4ptppynxQBGtrILvxVctL+e132mRaiLnTKjQNbXOJsdqJin5URCnh95RQWCtT0B0uIgWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nib/0EOe7agh/UyOfyrSi+iHTQrlwNojgYQP9cw8Cys=;
 b=LohXtj/eZEdyKZKRQIm68K5EvP8IlG+411KGs2LlXdtZz6SD+NJpD9GoIQexPtjuoeGqTOMGJVmMcEGrdVAKTlQaZqRXY4fxIsXJ5/tN7BBfE+LzHPbose0+okAS8VqN9hc+ckSB15gFGicz94eYg41QsZ56GGd/6iI6R7blPQWEb6pn1XAJdlqlaVpOklr2zFHm3My2fBqetIdqVW7zXMufNxef/i/6EHBctBF4CCrWs/l+r/PaNv8FX8oMQQtM4jk6fpRTzm7Wh6NrbFNUUMH4JmKUne/QwTGXB600O3HUkD/M32N0aB39fhD5xRzlOjDQ285d1hUVHNOeGKnW1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nib/0EOe7agh/UyOfyrSi+iHTQrlwNojgYQP9cw8Cys=;
 b=EGrp9w3aVqD+kau8JrzadCxbIe0reLAAgXJGNUltt9q4i8rmrRvfUN3aWDcXQmbbY6wR3wgvdkbxZopiF6DSRWaIEXnIVH42J3+MQm8Dmi1C7unpKdhAsKo/BCyMWgFS8/5y5y0sx2PAO6Vi1ORAgflPkqegp+sGEk4qzpDTAtI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY3PR13MB4897.namprd13.prod.outlook.com (2603:10b6:a03:366::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Fri, 25 Feb
 2022 03:51:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.009; Fri, 25 Feb 2022
 03:51:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 05/21] NFS: Store the change attribute in the directory
 page cache
Thread-Topic: [PATCH v7 05/21] NFS: Store the change attribute in the
 directory page cache
Thread-Index: AQHYKPs4DPebyPXb0kmsTNMhrdh+Eqyiyo0AgADBr4CAABeuAA==
Date:   Fri, 25 Feb 2022 03:51:18 +0000
Message-ID: <9506801a7b7b6330ce2807721da5e03d77cf5c78.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
         <20220223211305.296816-2-trondmy@kernel.org>
         <20220223211305.296816-3-trondmy@kernel.org>
         <20220223211305.296816-4-trondmy@kernel.org>
         <20220223211305.296816-5-trondmy@kernel.org>
         <20220223211305.296816-6-trondmy@kernel.org>
         <0DBE97BF-3A88-49FD-B078-012B5EDA5849@redhat.com>
         <1ca16f7e7be9588d15525e3afa4f7a80eb66b12b.camel@hammerspace.com>
In-Reply-To: <1ca16f7e7be9588d15525e3afa4f7a80eb66b12b.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22390f9a-6ac0-414a-7ae9-08d9f8121433
x-ms-traffictypediagnostic: BY3PR13MB4897:EE_
x-microsoft-antispam-prvs: <BY3PR13MB489744568BC8AFEC2D06B0B0B83E9@BY3PR13MB4897.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uo5zipoJWV0KwTmOBnVEIPLn/QKRDN2vyT+sul+E8c/IHmH9g602mIB2JKcM6Xi22K/OIAbrMxU9tL9U4P9AgrOqBNZeIV4Wanu4EUYJsmr+sYAlM8fNZr2Hrmy1oGdvZsJI4sm2QTVxn7BopvdtmS+Ri8H2Ny5XFpfup3ZYTh0S4mjQzjwxLPilj+8VjH/LYUcqLDVdNc313oW4cCND8ymnfZseYLs7ApMQcMhnsmkAkoUSeSVswcUEwm/hvoHbn5OsF63aS3vFSdY1wBlTVgo+lWGQXlTYNWRfGh4rS/DgnO9/ZXdkswv4A6/8mWiwHJvTAtk19WCLXsOZjw0Zgm1GbFfpxA9tH20WEeI6WXtoh+yciz6KCysGoy3GaCAEIQL1wz5OCWEOhhRdEBh1joeNvv4ytKuG8+s2WrIg3mi1K2uC0dzIE4E5vhHuFItoyX338BcVh5b2PnbeLvUifq85zcv8EAyRj0iXPmT+3CSYzW1SvKq5qDFxz5ihEk2jVVI7CkCNCG/t2+KoiaYyMl+ZS+R0kgFckHCSDIp67Xghy/nubB6E6kD4h/+o97/5m8C8S35mtsRWKjjjcqxkTVcJliQ9qlCol9NbIlVZMbiKIzA/Nm3EW7+yS9EDUwP0NO1kN7Dcmzz2i5TUmG1qPaeIW92vvPZoqhMtVHGTNOHyAFXOl9zzc236sCnLDtspdQOQpkL09bCLfQR5LvCzvNtCsx/dl3u810qNbufbFtE4rgg7FJoCj+I+2yjD2VmK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(136003)(39840400004)(396003)(376002)(366004)(6512007)(38100700002)(53546011)(316002)(6506007)(26005)(38070700005)(2616005)(71200400001)(5660300002)(2906002)(8936002)(186003)(76116006)(8676002)(66946007)(122000001)(86362001)(6916009)(83380400001)(6486002)(66556008)(66476007)(36756003)(4326008)(66446008)(508600001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFFxbWwzc1dQTkRib1RMdGg0d1RDQ1VaMVZpWUt5Qm5BSDBJTXlPVzdFaHV0?=
 =?utf-8?B?U0tYdU5wbWRmZ2FqMGNYcXFwWlhPNFNhRmZlMlNBWER4cUowSmpIUk1ZZEwz?=
 =?utf-8?B?L3V1M2dWQzVwTW90MUliVDd5V1JRcHRVVHAvRzlLcWl5NVFObEJLODlqWFRp?=
 =?utf-8?B?T3ZRMnE0Tktod1BORXNuWFEzMjQ4WW8xSUp0QnQ1bHhDSXZBUnhlQjNaWmFx?=
 =?utf-8?B?TkhkUytDQ2NFdDZzVjZERHdtYmpjRENUaDlXZnoyTGRCOTI1UmVjRGFlckNv?=
 =?utf-8?B?SWV4OVY4RE1obUZ4RDkvQ0E0eWU0OFk3OTgyR3A2bnpCUVdhZDdlQ0RVbyth?=
 =?utf-8?B?MjdXQlFmUlV3YUdaM1I3MnFrN2x3T05iZjNuYU1CanhOdVFKMkptQzVZY1Z6?=
 =?utf-8?B?Ui9OVjFOcU1PdmhDOUlsZ3lOeUhpQS9ZSnk5VlcrOExiYlNSZnBRbWNxS0J6?=
 =?utf-8?B?aDJ3bFQrNlBBSzJIZ3o0MXd5dGpwOU01d3gyOThJc0NnMkltVUdLeVBRMUZo?=
 =?utf-8?B?NVJnWVNBczFrY2xEdTFkZWpoeHd0M2Z4UktSeWplMVAwZjA3VlR1SHBQUkhG?=
 =?utf-8?B?WU9WR2lCN2NydVo5d0hUbGNROWhHcDRxeXdaK25IamtkVStjdGk5U1hRRVB1?=
 =?utf-8?B?RllYek9sbEZNQTlpTU1KNjlya2tvclI5TW5GeXNhU0JscXpkT1NtZW1FYnJ4?=
 =?utf-8?B?KzJkeVFEeHh0ZGxPcUpNdWZJajMrZWdDWTBWcnEvdTdLdDZBOGd1QUNlRzdZ?=
 =?utf-8?B?N21mWjhocW1kV0NTbCt3Rnk1eFdYdVBsdzl4Wk9QY2VrTHdIS1dxZk1YbWN6?=
 =?utf-8?B?SHhMcERCY3hjbVp2NVN4M3hCUlIyZ2hNdU5WT1JteEIyTUUzQWVJNDhwNk5a?=
 =?utf-8?B?R3ZiMHBBejRwT2Zid01pOEg5TFp1cS91MGV3eWR4KzJIZlZjQk1UNW1oWkpn?=
 =?utf-8?B?eDR3NGZhY2kzZWpCUUpHOHBLMFN3NWRWNkM0VUdTK0c0Vk91TXkrbzVlREU0?=
 =?utf-8?B?Kys2di9RZGZkd3dxdldIWkRsZG5melFCRnp0VXg0OUJWV3BBT0RpM1lKVUU1?=
 =?utf-8?B?aGkvMUw2cVMzRUM2MEQ2RW0rb1JsYnMvVlhZRGlCUnJpMVpyVGpLS3hvM1ZJ?=
 =?utf-8?B?c3A1SW40dWhoTWIxRkVTUzlqQUViTGhpdVUvUVdLaUxFVU52MnAwbUl2TUFG?=
 =?utf-8?B?eFNZYmx0UWdZZHMrcnlab1AzTVptbVBORy9od1dUK0pvWHByVk5HaGJ3WnlE?=
 =?utf-8?B?MUtNWUFqdzRTN3dWeDdiTWZPVk1KOWVaN1BpMWdRNzhTZ3VXbjh5UmRJbFpy?=
 =?utf-8?B?em9relR0SE5CUEJvdkFGRFd4dndTWVFzS2hpZXBkRUNBZkh1RWowa3VjeXhI?=
 =?utf-8?B?THExTkFqQjkwM3hRV2Y3YStwNDR4ZWhwQnBwZ2ZFeVFQN29IV0RjejFuVm02?=
 =?utf-8?B?dGQzVjRpRkxEWFVMKzNJY09HckozVUpwS040dEJnQ3ZrelgwdGNhSTNtMGFm?=
 =?utf-8?B?Q1kvcTRBdmh3ZlF2YStmWnNScnprNTlzcjFHK0Q1bkdlRFpsWmo4R0RZTlBL?=
 =?utf-8?B?TUxyYnVDUWl0cG0wajI5R1JBNHJhc1lLZ3RLa2s1SGM1WXVvMXpJSFh3aVNX?=
 =?utf-8?B?Y2duaHFxZWNCVk42R05WampNK2ltNU1EUGdLVmxzQVl3RTh1YVZyMnFvT0pk?=
 =?utf-8?B?clVBamxVWEVGSGZoTnM3ZjZ0UkMxS1R6RE5nZUlLTWtxb0FWUHp3OHEzVmVS?=
 =?utf-8?B?NG5iWDBodnl3bVc4dEhUdFNrTndTck16SzhxdHpiSzB2ektuc1ZoTkxJQmFa?=
 =?utf-8?B?bWRjSXUvRndQMlZsOU85b0NlNkVkOTZwQXRVKzNyRit3dEpBZWVWOHVDYjhZ?=
 =?utf-8?B?TnZYcU9IZXdpSjlnam1saUoydDFEc1JPaWZqWXFlV0FobmNKZDRSMnlrWWZF?=
 =?utf-8?B?eEdSa0szd2Y5WmE5SlBNY2p0NkZKZDY5blg2cHNkWWF4WFZyQVhnL0VDdVdr?=
 =?utf-8?B?OVg4MHgvVWFUdWt1cjZWMkRDNGtzb0hIVUpFc3BHSUNCTmpDUmNkdGQwaktY?=
 =?utf-8?B?b0JrcFkzYnN6R3dab3RWTWV6S3pTaGsrM1ZaVTJReURBdTkvbjI1UGExL2Rh?=
 =?utf-8?B?LzJrMVFlekFTS3RpYWdnM1ZsQktoYUY1Y2xuckt2NmZOSFJhQ09aKzlMQ2Ni?=
 =?utf-8?Q?29mNxdg91I7mEIC2DaSzANg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ACECE7E8286984EB70F8667FD16B485@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22390f9a-6ac0-414a-7ae9-08d9f8121433
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 03:51:18.0872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNolvnAAGgnCL8Cbjvbyax99f0+s/kr4EHnB3PPOhw7bvkGzfbh3g2Cl5M+VbgN9fG/b2BHlBD+0wOqbB43NAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4897
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTAyLTI1IGF0IDAyOjI2ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
Cj4gT24gVGh1LCAyMDIyLTAyLTI0IGF0IDA5OjUzIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9u
IHdyb3RlOgo+ID4gT24gMjMgRmViIDIwMjIsIGF0IDE2OjEyLCB0cm9uZG15QGtlcm5lbC5vcmfC
oHdyb3RlOgo+ID4gCj4gPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbT4KPiA+ID4gCj4gPiA+IFVzZSB0aGUgY2hhbmdlIGF0dHJpYnV0ZSBh
bmQgdGhlIGZpcnN0IGNvb2tpZSBpbiBhIGRpcmVjdG9yeSBwYWdlCj4gPiA+IGNhY2hlCj4gPiA+
IGVudHJ5IHRvIHZhbGlkYXRlIHRoYXQgdGhlIHBhZ2UgaXMgdXAgdG8gZGF0ZS4KPiA+ID4gCj4g
PiA+IFN1Z2dlc3RlZC1ieTogQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNvZGRpbmdAcmVkaGF0LmNv
bT4KPiA+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tPgo+ID4gPiAtLS0KPiA+ID4gwqBmcy9uZnMvZGlyLmMgfCA2OCAKPiA+
ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+
ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkK
PiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvZGlyLmMgYi9mcy9uZnMvZGlyLmMKPiA+
ID4gaW5kZXggZjIyNThlOTI2ZGYyLi41ZDkzNjdkOWI2NTEgMTAwNjQ0Cj4gPiA+IC0tLSBhL2Zz
L25mcy9kaXIuYwo+ID4gPiArKysgYi9mcy9uZnMvZGlyLmMKPiA+ID4gQEAgLTEzOSw2ICsxMzks
NyBAQCBzdHJ1Y3QgbmZzX2NhY2hlX2FycmF5X2VudHJ5IHsKPiA+ID4gwqB9Owo+ID4gPiAKPiA+
ID4gwqBzdHJ1Y3QgbmZzX2NhY2hlX2FycmF5IHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgdTY0IGNo
YW5nZV9hdHRyOwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgdTY0IGxhc3RfY29va2llOwo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IHNpemU7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqB1
bnNpZ25lZCBjaGFyIHBhZ2VfZnVsbCA6IDEsCj4gPiA+IEBAIC0xNzUsNyArMTc2LDggQEAgc3Rh
dGljIHZvaWQgbmZzX3JlYWRkaXJfYXJyYXlfaW5pdChzdHJ1Y3QgCj4gPiA+IG5mc19jYWNoZV9h
cnJheSAqYXJyYXkpCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBtZW1zZXQoYXJyYXksIDAsIHNpemVv
ZihzdHJ1Y3QgbmZzX2NhY2hlX2FycmF5KSk7Cj4gPiA+IMKgfQo+ID4gPiAKPiA+ID4gLXN0YXRp
YyB2b2lkIG5mc19yZWFkZGlyX3BhZ2VfaW5pdF9hcnJheShzdHJ1Y3QgcGFnZSAqcGFnZSwgdTY0
IAo+ID4gPiBsYXN0X2Nvb2tpZSkKPiA+ID4gK3N0YXRpYyB2b2lkIG5mc19yZWFkZGlyX3BhZ2Vf
aW5pdF9hcnJheShzdHJ1Y3QgcGFnZSAqcGFnZSwgdTY0IAo+ID4gPiBsYXN0X2Nvb2tpZSwKPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHU2NCBjaGFuZ2VfYXR0cikKPiA+ID4gwqB7Cj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmZzX2NhY2hlX2FycmF5ICphcnJheTsKPiA+IAo+ID4g
Cj4gPiBUaGVyZSdzIGEgaHVuayBtaXNzaW5nIGhlcmUsIHNvbWV0aGluZyBsaWtlOgo+ID4gCj4g
PiBAQCAtMTg1LDYgKzE4NSw3IEBAIHN0YXRpYyB2b2lkIG5mc19yZWFkZGlyX3BhZ2VfaW5pdF9h
cnJheShzdHJ1Y3QKPiA+IHBhZ2UgCj4gPiAqcGFnZSwgdTY0IGxhc3RfY29va2llLAo+ID4gwqDC
oMKgwqDCoMKgwqDCoCBuZnNfcmVhZGRpcl9hcnJheV9pbml0KGFycmF5KTsKPiA+IMKgwqDCoMKg
wqDCoMKgwqAgYXJyYXktPmxhc3RfY29va2llID0gbGFzdF9jb29raWU7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgIGFycmF5LT5jb29raWVzX2FyZV9vcmRlcmVkID0gMTsKPiA+ICvCoMKgwqDCoMKgwqAg
YXJyYXktPmNoYW5nZV9hdHRyID0gY2hhbmdlX2F0dHI7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgIGt1
bm1hcF9hdG9taWMoYXJyYXkpOwo+ID4gwqAgfQo+ID4gCj4gPiA+IAo+ID4gPiBAQCAtMjA3LDcg
KzIwOSw3IEBAIG5mc19yZWFkZGlyX3BhZ2VfYXJyYXlfYWxsb2ModTY0IGxhc3RfY29va2llLAo+
ID4gPiBnZnBfdCBnZnBfZmxhZ3MpCj4gPiA+IMKgewo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgc3Ry
dWN0IHBhZ2UgKnBhZ2UgPSBhbGxvY19wYWdlKGdmcF9mbGFncyk7Cj4gPiA+IMKgwqDCoMKgwqDC
oMKgwqBpZiAocGFnZSkKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5mc19y
ZWFkZGlyX3BhZ2VfaW5pdF9hcnJheShwYWdlLCBsYXN0X2Nvb2tpZSk7Cj4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZnNfcmVhZGRpcl9wYWdlX2luaXRfYXJyYXkocGFnZSwg
bGFzdF9jb29raWUsCj4gPiA+IDApOwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHBhZ2U7
Cj4gPiA+IMKgfQo+ID4gPiAKPiA+ID4gQEAgLTMwNCwxOSArMzA2LDQ0IEBAIGludCBuZnNfcmVh
ZGRpcl9hZGRfdG9fYXJyYXkoc3RydWN0Cj4gPiA+IG5mc19lbnRyeQo+ID4gPiAqZW50cnksIHN0
cnVjdCBwYWdlICpwYWdlKQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiA+ID4g
wqB9Cj4gPiA+IAo+ID4gPiArc3RhdGljIGJvb2wgbmZzX3JlYWRkaXJfcGFnZV9jb29raWVfbWF0
Y2goc3RydWN0IHBhZ2UgKnBhZ2UsIHU2NAo+ID4gPiBsYXN0X2Nvb2tpZSwKPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHU2NCBjaGFuZ2VfYXR0cikKPiA+IAo+ID4gSG93IGFib3V0ICJu
ZnNfcmVhZGRpcl9wYWdlX3ZhbGlkKCkiP8KgIFRoZXJlJ3MgbW9yZSBnb2luZyBvbiB0aGFuIGEK
PiA+IGNvb2tpZSBtYXRjaC4KPiA+IAo+ID4gCj4gPiA+ICt7Cj4gPiA+ICvCoMKgwqDCoMKgwqDC
oHN0cnVjdCBuZnNfY2FjaGVfYXJyYXkgKmFycmF5ID0ga21hcF9hdG9taWMocGFnZSk7Cj4gPiA+
ICvCoMKgwqDCoMKgwqDCoGludCByZXQgPSB0cnVlOwo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoGlmIChhcnJheS0+Y2hhbmdlX2F0dHIgIT0gY2hhbmdlX2F0dHIpCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBmYWxzZTsKPiA+IAo+ID4gQ2FuIHdlIHNraXAg
dGhlIG5leHQgdGVzdCBpZiByZXQgPSBmYWxzZT8KPiAKPiBJJ2QgZXhwZWN0IHRoZSBjb21waWxl
ciB0byBkbyB0aGF0Lgo+IAo+ID4gCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChhcnJheS0+c2l6
ZSA+IDAgJiYgYXJyYXktPmFycmF5WzBdLmNvb2tpZSAhPQo+ID4gPiBsYXN0X2Nvb2tpZSkKPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IGZhbHNlOwo+ID4gPiArwqDC
oMKgwqDCoMKgwqBrdW5tYXBfYXRvbWljKGFycmF5KTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgcmV0
dXJuIHJldDsKPiA+ID4gK30KPiA+ID4gKwo+ID4gPiArc3RhdGljIHZvaWQgbmZzX3JlYWRkaXJf
cGFnZV91bmxvY2tfYW5kX3B1dChzdHJ1Y3QgcGFnZSAqcGFnZSkKPiA+ID4gK3sKPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgdW5sb2NrX3BhZ2UocGFnZSk7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoHB1dF9w
YWdlKHBhZ2UpOwo+ID4gPiArfQo+ID4gPiArCj4gPiA+IMKgc3RhdGljIHN0cnVjdCBwYWdlICpu
ZnNfcmVhZGRpcl9wYWdlX2dldF9sb2NrZWQoc3RydWN0Cj4gPiA+IGFkZHJlc3Nfc3BhY2UgCj4g
PiA+ICptYXBwaW5nLAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBwZ29mZl90IGluZGV4LAo+ID4gPiB1NjQKPiA+ID4gbGFzdF9jb29raWUpCj4gPiA+IMKgewo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHBhZ2UgKnBhZ2U7Cj4gPiA+ICvCoMKgwqDCoMKg
wqDCoHU2NCBjaGFuZ2VfYXR0cjsKPiA+ID4gCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBwYWdlID0g
Z3JhYl9jYWNoZV9wYWdlKG1hcHBpbmcsIGluZGV4KTsKPiA+ID4gLcKgwqDCoMKgwqDCoMKgaWYg
KHBhZ2UgJiYgIVBhZ2VVcHRvZGF0ZShwYWdlKSkgewo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgbmZzX3JlYWRkaXJfcGFnZV9pbml0X2FycmF5KHBhZ2UsIGxhc3RfY29va2ll
KTsKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChpbnZhbGlkYXRlX2lu
b2RlX3BhZ2VzMl9yYW5nZShtYXBwaW5nLCBpbmRleAo+ID4gPiArCj4gPiA+IDEsIC0xKSA8IDAp
Cj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmZz
X3phcF9tYXBwaW5nKG1hcHBpbmctPmhvc3QsIG1hcHBpbmcpOwo+ID4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgU2V0UGFnZVVwdG9kYXRlKHBhZ2UpOwo+ID4gPiArwqDCoMKgwqDC
oMKgwqBpZiAoIXBhZ2UpCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gTlVMTDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgY2hhbmdlX2F0dHIgPSBpbm9kZV9wZWVrX2l2
ZXJzaW9uX3JhdyhtYXBwaW5nLT5ob3N0KTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKFBhZ2VV
cHRvZGF0ZShwYWdlKSkgewo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYg
KG5mc19yZWFkZGlyX3BhZ2VfY29va2llX21hdGNoKHBhZ2UsCj4gPiA+IGxhc3RfY29va2llLAo+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNoYW5nZV9hdHRy
KSkKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gcGFnZTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5mc19yZWFk
ZGlyX2NsZWFyX2FycmF5KHBhZ2UpOwo+ID4gCj4gPiAKPiA+IFdoeSB1c2UgaV92ZXJzaW9uIHJh
dGhlciB0aGFuIG5mc19zYXZlX2NoYW5nZV9hdHRyaWJ1dGU/wqAgU2VlbXMKPiA+IGhhdmluZyBh
Cj4gPiBjb25zaXN0ZW50IHZhbHVlIGFjcm9zcyB0aGUgcGFjaGVjYWNoZSBhbmQgZGlyX3Zlcmlm
aWVycyB3b3VsZCBoZWxwCj4gPiBkZWJ1Z2dpbmcsIGFuZCB3ZSd2ZSBhbHJlYWR5IGhhdmUgYSBi
dW5jaCBvZiBtYWNoaW5lcnkgYXJvdW5kIHRoZQo+ID4gY2hhbmdlX2F0dHJpYnV0ZS4KPiAKPiBU
aGUgZGlyZWN0b3J5IGNhY2hlX2NoYW5nZV9hdHRyaWJ1dGUgaXMgbm90IHJlcG9ydGVkIGluIHRy
YWNlcG9pbnRzCj4gYmVjYXVzZSBpdCBpcyBhIGRpcmVjdG9yeS1zcGVjaWZpYyBmaWVsZCwgc28g
aXQncyBub3QgYXMgdXNlZnVsIGZvcgo+IGRlYnVnZ2luZy4KPiAKPiBUaGUgaW5vZGUgY2hhbmdl
IGF0dHJpYnV0ZSBpcyB3aGF0IHdlIGhhdmUgdHJhZGl0aW9uYWxseSB1c2VkIGZvcgo+IGRldGVy
bWluaW5nIGNhY2hlIGNvbnNpc3RlbmN5LCBhbmQgd2hlbiB0byBpbnZhbGlkYXRlIHRoZSBjYWNo
ZS4KCkkgc2hvdWxkIHByb2JhYmx5IGVsYWJvcmF0ZSBhIGxpdHRsZSBmdXJ0aGVyIG9uIHRoZSBk
aWZmZXJlbmNlcyBiZXR3ZWVuCnRoZSBpbm9kZSBjaGFuZ2UgYXR0cmlidXRlIGFuZCB0aGUgY2Fj
aGVfY2hhbmdlX2F0dHJpYnV0ZS4KCk9uZSBvZiB0aGUgbWFpbiByZWFzb25zIGZvciBpbnRyb2R1
Y2luZyB0aGUgbGF0dGVyIHdhcyB0byBoYXZlCnNvbWV0aGluZyB0aGF0IGFsbG93cyB1cyB0byB0
cmFjayBjaGFuZ2VzIHRvIHRoZSBkaXJlY3RvcnksIGJ1dCB0bwphdm9pZCBmb3JjaW5nIHVubmVj
ZXNzYXJ5IHJldmFsaWRhdGlvbnMgb2YgdGhlIGRjYWNoZS4KCldoYXQgdGhpcyBtZWFucyBpcyB0
aGF0IHdoZW4gd2UgY3JlYXRlIG9yIHJlbW92ZSBhIGZpbGUsIGFuZCB0aGUKcHJlL3Bvc3Qtb3Ag
YXR0cmlidXRlcyB0ZWxsIHVzIHRoYXQgdGhlcmUgd2VyZSBubyB0aGlyZCBwYXJ0eSBjaGFuZ2Vz
CnRvIHRoZSBkaXJlY3RvcnksIHdlIHVwZGF0ZSB0aGUgZGNhY2hlLCBidXQgd2UgZG8gX25vdF8g
dXBkYXRlIHRoZQpjYWNoZV9jaGFuZ2VfYXR0cmlidXRlLCBiZWNhdXNlIHdlIGtub3cgdGhhdCB0
aGUgcmVzdCBvZiB0aGUgZGlyZWN0b3J5CmNvbnRlbnRzIGFyZSB2YWxpZCwgYW5kIHNvIHdlIGRv
bid0IGhhdmUgdG8gcmV2YWxpZGF0ZSB0aGUgZGVudHJpZXMuCkhvd2V2ZXIgaW4gdGhhdCBjYXNl
LCB3ZSBfZG9fIHdhbnQgdG8gdXBkYXRlIHRoZSByZWFkZGlyIGNhY2hlIHRvCnJlZmxlY3QgdGhl
IGZhY3QgdGhhdCBhbiBlbnRyeSB3YXMgYWRkZWQgb3IgZGVsZXRlZC4gV2hpbGUgd2UgY291bGQK
ZmlndXJlIG91dCBob3cgdG8gcmVtb3ZlIGFuIGVudHJ5IChhdCBsZWFzdCBmb3IgdGhlIGNhc2Ug
d2hlcmUgdGhlCmZpbGVzeXN0ZW0gaXMgY2FzZS1zZW5zaXRpdmUpLCB3ZSBkbyBub3Qga25vdyB3
aGVyZSB0aGUgZmlsZXN5c3RlbQphZGRlZCB0aGUgbmV3IGZpbGUsIG9yIHdoYXQgY29va2llcyB3
YXMgYXNzaWduZWQuCgpUaGlzIGlzIHdoeSB0aGUgaW5vZGUgY2hhbmdlIGF0dHJpYnV0ZSBpcyBt
b3JlIGFwcHJvcHJpYXRlIGZvciBpbmRleGluZwp0aGUgcGFnZSBjYWNoZSBwYWdlcy4gSXQgcmVm
bGVjdHMgdGhlIGNhc2VzIHdoZXJlIHdlIHdhbnQgdG8gcmV2YWxpZGF0ZQp0aGUgcmVhZGRpciBj
YWNoZSwgYXMgb3Bwb3NlZCB0byB0aGUgZGNhY2hlLgoKLS0gClRyb25kIE15a2xlYnVzdApMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlCnRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20KCgo=
