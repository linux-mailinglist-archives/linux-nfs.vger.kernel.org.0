Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8244C7AD3
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 21:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiB1Umw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 15:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiB1Umw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 15:42:52 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2094.outbound.protection.outlook.com [40.107.95.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369B9220F3
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:42:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZCvlOwHfXZcVS5HJF+c6SpEvh8D27vGNfrE4TqzL8tey1P3YgNbVgW5ChJhvtI6+b16RC7V2f6yp013Az9ZXSvZU8wP2qUorlCv2YHO3VHOQem1DX4mKRZrzweAFcahVrg9tsLpmWSr6Sc0q5WqJyDd5qc9hjjvKcxm7Csa8F0O9AF2Ir5Hpyywk+/WJf7gB75Mq4KoAy2QwMEMXJHxzQajLvDIL5hI+VYT32/4KS30BF+gZIx1sQsJzxj8KdqTJs+gScAijrT1aQJazmkhDAZ6itPAy9ia9h9b0knra5xYpUzUOnuOA3OYdm+46CBsj1450A9Zy8Lx1Dt4ED4Gnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seVaz2g0lgLISO7zr8Mbe5md3aSEFPKEdtjWWjjtS24=;
 b=gC5dmIz6aITti6OZJpHGLLHdAx2oW5+IZv5C7Udhs2xfP4xbxZKMgrXtMAHB44CRcwJsNhJORJeHw92sChBaBwKwYV67H0S/+kQjM74dE3Dw9nH4KdZ73Sl615bJpDB4K0v5d1ln2B6JIXy0asxp3x/BfkENVvWIGvuGR22m0Ssi5sRZu8NWwnzYDp1gfB+g9gpGrgVNWbgwhrgGR4D793/J1UTY67eEcPM22xtxG8HYc6fk/x7FU0U8v8vkWsqCrW53PUCYMZsEHaufLXmYydny4Tdk1lO8R+UrOmjsYyG/5mEdXFhSltN6AS5otwtRmKrJiRmQnHvGnCmGDVicOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seVaz2g0lgLISO7zr8Mbe5md3aSEFPKEdtjWWjjtS24=;
 b=BGM7chSEr6INqTPTSCP40WNhNPl7QLh0Rm0+VK7Aa7fYQ9gvxhPjp8HT9VeS/oprRZQZTeMUqSz+AYi83nIfox7NSSwpSQf09bMdQioyFGUCqhxgbr+dOjdQpJL5sgVfrOhLUS/porsFEIL4PmedRM/DXhWD129wNnXjtdcci7M=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3136.namprd13.prod.outlook.com (2603:10b6:208:154::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Mon, 28 Feb
 2022 20:42:09 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.013; Mon, 28 Feb 2022
 20:42:08 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] NFSv4: Tune the race to set and use the client id
 uniquifier
Thread-Topic: [PATCH] NFSv4: Tune the race to set and use the client id
 uniquifier
Thread-Index: AQHYI1yGsrbFUuqkvUeUFRfAYTkwhKyXsraAgBGBCwCAABW2AIAAG9OAgAARaoCAAAJZgIAAB4aA
Date:   Mon, 28 Feb 2022 20:42:08 +0000
Message-ID: <fd290496bd66b6bf477c961ac716179ecdda13fd.camel@hammerspace.com>
References: <61a5993a1f9bbed2ba1227bd3376e92232e0530a.1645033262.git.bcodding@redhat.com>
         <3EA14A5C-9FF9-4DDC-B530-768A86E2A4E8@redhat.com>
         <0F8CD466-6233-4386-94C5-FC8E5941F9D3@redhat.com>
         <73b61ba083df0a8954979fed11d6398d336ee1d1.camel@hammerspace.com>
         <F853D68C-C066-470E-BCFC-988C3D46ABA8@oracle.com>
         <01c6aeddf91d0e68d7c497456ea96f4f24145059.camel@hammerspace.com>
         <5DB9D3E8-2687-4945-9542-C0ECC58C509A@oracle.com>
In-Reply-To: <5DB9D3E8-2687-4945-9542-C0ECC58C509A@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b50e55b6-f93c-461e-7bf4-08d9fafac9fc
x-ms-traffictypediagnostic: MN2PR13MB3136:EE_
x-microsoft-antispam-prvs: <MN2PR13MB31363360F1712DB3DF56BE0AB8019@MN2PR13MB3136.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v8yE2GdGEGfizr3l2kx75vuDs4/u/x5edL6EXn+lIni1DSlyqmUDKpGXnNOZr887QMv7yuVOIIeY6UCz3KCoqaQdbpGCA+qHTod4ejV7NLaWUz6ow8ytDpovxBXDmS92BuqFEdKe0ilIrIMT+JQB4KjvqywcTB9umowhQG7/bo8MFMd0NlPDgErq9aFpBeoY4v3bkAheJ5nlAjDbvAFCQqcL3d+A4ZwZ7lMjSUcvMV2SvXIMz2xakXQ68n0bBbtET9slLXDuy3J+5DvUldcSe6WzyOW0EbatQVBP9aaM1AW3964p9h1FQ4FDayF4Y9udX0vTQik443HuxjRhPrrkhv4hDoELKzUGfQPQw0Y/BM7R5Vx6hDmEjBw1fVM2Esc6GqL29E3ehv4Q1udyUv1VTMD1IAWkLm1qxDEtnlsNGlaLd4tAqanJbJEit0lQWnG1PIW2X7AdGX2cu42S3cnNm6ghB94d3wJlCzkRJwoZNeBb91wzWTT+W1U6BSJsfJx2QvUcMbqxcwX15k0Asu8vMcBHxr4/Ii2VM1I+5UjXaBPHJwZ0AonebUEDDpAAwTmAO+H8mwb75hL9XQLamo0B4U0cnuoOQzYjBRkPP6RBjH1AbNwGAx3mlnjchcQieSJVrgVbRRMlNbGQ7/PY8cYmMGHbCRNU5hKjrJL33Uvz46qAEznhLe0I+wm0BsJdPtBimvroErOk2o/VMs6zFfvuFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(122000001)(316002)(54906003)(6916009)(5660300002)(8936002)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(66946007)(76116006)(38070700005)(26005)(2616005)(6512007)(6486002)(83380400001)(86362001)(186003)(508600001)(71200400001)(53546011)(6506007)(36756003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjFEQUNBTVozRkpzd2hhYVVTY2YvOEhHVFJRR2owUEtLeDcvbU16VnhTdkM1?=
 =?utf-8?B?WkR6a254YUlxRVBPYlFUaEJtV2RJbytiVmh5QVNpUDlDdVB5b2V2QzdGenNz?=
 =?utf-8?B?Qm9mUmV2c3krWFAxQml1ZlgxMVB3ekZMbjlCQWxmczByZUtZRHBCYjVyY3lP?=
 =?utf-8?B?bHdoN2xSeHQ2ZWJhdExXREszZWkxc0cxdkk1ZmlHcDlobUZ0L0R1Tis0OGVm?=
 =?utf-8?B?NHFEdjJad2ZLVER0Ty9KT1A3aFhXTFk0azZ5T0dnblh2WUs4UmtaWnNQVDFV?=
 =?utf-8?B?cU5OMzIwTi8rbmxUR3ZaSHgyUCswTksrTk5yN0dUdUhRNUcwUXFRSVlRR0VG?=
 =?utf-8?B?b3pnV3M3RFJ0NzhmdUovOG1zeXVXL0ZZM01qaE9kYkg4Yys4VHVLUVdzZXk0?=
 =?utf-8?B?NU8rWHhwNWdzL0pWS3NqNTY1VkxxZktnUGpkdXZRUEU5Q3lCMlNwQWV6d1hE?=
 =?utf-8?B?RXdtVTZaY0hGMjdTUEhKWnU4M0lDTm5Qb1RYVVR1SWZPMDI0SVZEbER3cTJR?=
 =?utf-8?B?MEpnSjdvcnNCK0dlQ1ZOTktHOHpyZVVQcE9nbXk0OEkzL1RQTTZac3BqQU1s?=
 =?utf-8?B?aFFKbFZVbUFKYUptdld6Mmt2UndLaHhwTWpmS2VjemQzbXBROTVNZzJKTENN?=
 =?utf-8?B?blU3MVMxMWRkWnJwOGpXeWsrYWN1enB6bGhRY0NJNUxETXVBQXE3U0lLb2Z1?=
 =?utf-8?B?bTk4V3dRV28wMXVwcnpGR1NBcDhtZS95aG9TNEwzVjNja25nb0dUeUN1a1Vs?=
 =?utf-8?B?ZW1mc3U2ZWlwUUlhWTd1TGYxb3JtOVV1V0xScVpZaE0xQWE2YkJDQkRualBh?=
 =?utf-8?B?RFJBTGUxRENuZFBGZWdOenlrWGZsdlpSY200Wi90Unp5UGlZaElRV3dja2J4?=
 =?utf-8?B?YWpPVmFtUURkWi8vdEc4TW9kZzBtSW5iUjhLNSs2RElPTzd1QlBCS1F2ZzZ1?=
 =?utf-8?B?bXIzRTFscWFySkZzVHF2bW5OSHhVRjZMYTlWUFFWQWtQSzNmZ0tMaCtUbVBs?=
 =?utf-8?B?N3MyQ0xMZGhLTVZhY0Rjd3daTURnbDJCbFlLMW1EVzdKTDAxYWNhYjM5Mk5w?=
 =?utf-8?B?M1hXWmtxQnIwb1p1NjVyWVBWVmVhNktzSzFDZFcxUnZrb1dOSzdOYUpjNzRq?=
 =?utf-8?B?em1objRuMUVZQ3MzQ3JzRW1Pbk1JNGxBMHcxbXRtOHRvZjljWUJudDIvY0RM?=
 =?utf-8?B?dEtsdUJDUU5JUGQwcGNvRzNjRGlKS1B2eXQ5R1ZGdS9BT05ZTkwvMzlsczFB?=
 =?utf-8?B?VzU1WU5oMkpEYmVOQytoQVR1Y3FxeEtUUnFibm5jYUtaV0ZWUVZ2eFZscEU4?=
 =?utf-8?B?cUpxVHZLRE9GTFhnOGFVZFF3WlU1MUlhRmo5bHdaUlVnS3I3V3hjZzJqWHNI?=
 =?utf-8?B?bjdBMUJvOUdNbGREdEc0QlZEV1lEWWFXNmNFNXN1YkRnYkNOeVgvZ2Q2TDc4?=
 =?utf-8?B?TkJwYVo2am1rcmVnVGNlT1VSWnhuNFlqM21tRjd4Rzk0empSbTMxd1F6QTRv?=
 =?utf-8?B?c3FjV0VkdVZKaEJhcitIUVkyS2NPb1pFY3Mxam9NOEJKZy9OMEFHRXdIUlVw?=
 =?utf-8?B?WlhEVHllMnNQdEFwUDc4dEdjM3gxZU5HKy92ZGxlaGt2Q2pNQ0ZxdU82amc5?=
 =?utf-8?B?V09CbW9Tb3Ruc1JOYk4weTR4WVFWSlhJRWtWZHQ3clg4YldDOGNoVGRVNm9m?=
 =?utf-8?B?TjU0WWw2YnJ1d0p5c0wwLzdUTEFjdGozZnVYVVhiQXBVeDVtZVBEdkJ2SkRx?=
 =?utf-8?B?ZEpCb2RTTlFwb1BFbHorcnZNc1hQcjcxa2dhZGhJajN2KzdoWEhJYnNWZ0l0?=
 =?utf-8?B?OWppZmZEVWNwSG55ZXJXaldTUFNJV2VTN1BwTTBuRFlBSCtyYk50azk0TWhh?=
 =?utf-8?B?NGdqMjRNd1BaaFNmcGg3dm8zSGxOMGc2eG53TGxJNWpFZEhuWWkxT3RGZVhG?=
 =?utf-8?B?b2o3aUpjdnpaRFdzSHFEMUhUWFNjbVJFZVhtQ1p6SHl6TDFWWVVFdCswaFlN?=
 =?utf-8?B?U0gxSEhsOEt6cDhLSjhhWWcyRUlRS3UyRExTSUwzSFl5N3FuRU44WmsvQ2Jr?=
 =?utf-8?B?a1ZMUk9CY085TXpQRmFXNlRSZElHVWI1WXFKSzhIL1dja0RCcVJZR201Q1lh?=
 =?utf-8?B?ZkhsdnVaUFlET0FRa21TZENsOEROcmpDZVZIKzBFdWMxQzlOSnBLS2JYZU8w?=
 =?utf-8?Q?gUEvOXRuV026R07wSyvjor8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C29750214B63A4990787588FF076EA3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50e55b6-f93c-461e-7bf4-08d9fafac9fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 20:42:08.5296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ers6baam9X77MVkBsP2+3xPb3hSU/l4yFhNBBt2WpvHk1IZ01Rt1jPIdSsKLYFghhKPu51K/zNN6/demDOITQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTI4IGF0IDIwOjE1ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBGZWIgMjgsIDIwMjIsIGF0IDM6MDYgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gTW9u
LCAyMDIyLTAyLTI4IGF0IDE5OjA0ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4g
PiANCj4gPiA+IA0KPiA+ID4gPiBPbiBGZWIgMjgsIDIwMjIsIGF0IDEyOjI0IFBNLCBUcm9uZCBN
eWtsZWJ1c3QNCj4gPiA+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+
ID4gDQo+ID4gPiA+ID4gQXR0ZW1wdHMgdG8gd29yayB0b3dhcmQgc29sdXRpb25zIGluIHRoaXMg
YXJlYSBzZWVtIHRvIGJlDQo+ID4gPiA+ID4gaWdub3JlZCwNCj4gPiA+ID4gPiB0aGUNCj4gPiA+
ID4gPiBxdWVzdGlvbnMgc3RpbGwgc3RhbmQuwqAgVW50aWwgd2UgY2FuIHNvcnQgb3V0IGFuZCBh
Z3JlZSBvbiBhDQo+ID4gPiA+ID4gZGlyZWN0aW9uLA0KPiA+ID4gPiA+IHNlbGYtTkFDSyB0byB0
aGlzIHBhdGNoLg0KPiA+ID4gPiANCj4gPiA+ID4gQSBuZXcgbW91bnQgb3B0aW9uIGRvZXNuJ3Qg
c29sdmUgYW55IHByb2JsZW1zIHRoYXQgd2UgY2FuJ3QNCj4gPiA+ID4gc29sdmUNCj4gPiA+ID4g
d2l0aA0KPiA+ID4gPiB0aGUgZXhpc3RpbmcgZnJhbWV3b3JrLg0KPiA+ID4gDQo+ID4gPiBJIGRv
bid0IHRoaW5rIGEgbW91bnQgb3B0aW9uIHdhcyBwcm9wb3NlZC4gUmF0aGVyLCB0aGUgbWVjaGFu
aWNzDQo+ID4gPiBvZiB0aGUgdWRldiBydWxlIHdvdWxkIGJlIGRvbmUgYnkgbW91bnQubmZzIHdp
dGhvdXQgYW55IGNoYW5nZXMNCj4gPiA+IHRvIHRoZSBhZG1pbmlzdHJhdGl2ZSBpbnRlcmZhY2Uu
DQo+ID4gPiANCj4gPiANCj4gPiBUaGF0J3Mgbm90IGhvdyBJIHJlYWQgdGhpcyBwcm9wb3NhbDoN
Cj4gPiANCj4gPiA+IERvIHlvdSBzdGlsbCB3YW50IHVzIHRvIGtlZXAgdGhpcyBhcHByb2FjaCwg
b3Igd2lsbCB5b3UgYWNjZXB0IGENCj4gPiBtb3VudA0KPiA+ID4gb3B0aW9uIGFzOg0KPiA+ID4g
LSBmaXJzdCBtb3VudCBpbiBhIG5hbWVzcGFjZSBzZXRzIHRoZSBpZGVudGlmaWVyDQo+ID4gPiAt
IHN1YnNlcXVlbnQgbW91bnRzIHdpdGggY29uZmxpY3RpbmcgaWRlbnRpZmllcnMgcmV0dXJuIGFu
IGVycm9yDQo+ID4gDQo+ID4gDQo+ID4gV2hpY2ggaXMgd2h5IEkgcmVzcG9uZGVkIGFzIEkgZGlk
Lg0KPiANCj4gQWghIFdlbGwsIEkgcmVhZCAibW91bnQgb3B0aW9uIiBhcyAibW91bnQgYWx0ZXJu
YXRpdmUiLCBJIGd1ZXNzDQo+IEkgd2FzIGZpbGxpbmcgaW4gc29tZSBjb250ZXh0IGZyb20gcHJl
dmlvdXMgZGlhbG9nIG9uIHRoZSB0b3BpYy4NCj4gDQo+IEkgYWdyZWUgd2l0aCB5b3UgdGhhdCBh
biBhY3R1YWwgbW91bnQgb3B0aW9uIC0tIHRoYXQgaXMsIGEgbmV3DQo+IGFkbWluaXN0cmF0aXZl
IGludGVyZmFjZSAtLSBpcyBub3QgZGVzaXJhYmxlIG9yIG5lY2Vzc2FyeS4NCj4gDQo+IEJ1dCBJ
IGFzc2VydCB0aGF0IGhhdmluZyBtb3VudC5uZnMgdGFrZSBjYXJlIG9mIGluaXRpYWxpemluZyB0
aGUNCj4gdW5pcXVpZmllciBmb3IgdGhlIG5ldCBuYW1lc3BhY2UgaXMgY29udmVuaWVudCwgYW5k
IGNhbiBiZSBkb25lDQo+IGF1dG9tYXRpY2FsbHkgYW5kIHJlbGlhYmx5Lg0KPiANCg0KQWdhaW4s
IGlmIHdlIGRvIHRoaXMsIHRoZW4gSSdkIHdhbnQgdGhlIGFjdHVhbCB0b29sIHRoYXQgaW5pdGlh
bGlzZXMNCnRoZSB1bmlxdWlmaWVyIHRvIGJlIGEgc2VwYXJhdGUgb25lIHRoYXQgZ2V0cyBjYWxs
ZWQgYnkgbW91bnQgaWYNCm5lY2Vzc2FyeS4NCk90aGVyd2lzZSB3ZSdsbCBoYXZlIHRvIGNvbnNp
ZGVyIGR1cGxpY2F0aW5nIHRoYXQgY29kZSBpbiBidXN5Ym94IGFuZA0KYWxsIHRoZSBvdGhlciB0
b29scyB0aGF0IGhhdmUgcHJpdmF0ZSBpbXBsZW1lbnRhdGlvbnMgb2YgJ21vdW50Jy4NCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
