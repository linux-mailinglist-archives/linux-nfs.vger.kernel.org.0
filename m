Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4545A3340
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Aug 2022 02:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiH0Awh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 20:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiH0Awg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 20:52:36 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2123.outbound.protection.outlook.com [40.107.92.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E320ADAEFD
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 17:52:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCsqClADy2hkOMaAe8U7hdpwVe627FiVUX2Qx6XDSRclaX03odFT2AiFhqf6uR8cdS6fapGzdwpVuz9I/U+zs1wWbVXbYUEYJVyYPSRuM4tZShc3gafJqipJj5aGvaknB8xIQoC8xqyRo5CXsg+urRiD3VpKKoPRNekgOrsy0y23ekdpiegyz0a3m8MSYRe5SNZ3aSeZyQBJ4kTzyR2sIo+XZSEkKtQgyTwbnmB86l3ip80HevltZNN2Lnb9EuwxV3Ym015D0WSwWkOCSzqTmde1YJ7vkLN92SAmEULAlW+xPZiWkd3FcT/9rBnhZdJ0oH5QQvPnJ44P/igcxXE2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSAcH4l1ioJd42bHiQNdNaZazaEGlqguGoGipffZViw=;
 b=i9jTjhiomkkpPxXwSies+nn/xeK16xciscSYMHn3Z7iZkIMl2us/Ts00UfOIKAVrXNMTCMAHqMEwGvQvtghj0P9bJc5KeqveK5UGwtMaPTuhLA8fAwFbkDzYSLiPt5fcNXCpYTubAkcCWeXoAt2jlGnjTW4JkZiyl4HqM0PW4WOuwK4t0pFQ+lwLQcnPK/kDbOO7+gngbHoin+tQc834FDwZuJpdhnPo47SqZG8WnEH9GcB6A70hFxWDiPUbZFlKiv3+Deznf4t9xud3Se7d2a9ztFMc0W4xe1nM7ru9enqjpx97amIu+/2TGYgpDuZ4a8k0LqlowJAH13fChw1H4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSAcH4l1ioJd42bHiQNdNaZazaEGlqguGoGipffZViw=;
 b=eGJHnHSdYYNswiyekNJZL2lN7ZheRbSGldFbBJx68NX3RzXaMBGQkp7lRqzsERm1cdwbdXG+ZnXUFbWGazmISPW91OQCPnJ4Wpvs46GnltpRbQijAnCtyaFQfJZ5eT/XKjtiPhtr/hxh7m9dES2P/LswguqSjJI6MfTBMdvGUeY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BYAPR13MB2264.namprd13.prod.outlook.com (2603:10b6:a02:cc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.14; Sat, 27 Aug
 2022 00:52:23 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%4]) with mapi id 15.20.5588.003; Sat, 27 Aug 2022
 00:52:23 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Thread-Topic: [PATCH 0/2] NFS: limit use of ACCESS cache for negative
 responses
Thread-Index: AQHYWqCwBzhUO4xFMUm2kRfU0oEzLK0iTkgAgAAEXYCAAAWigIAABBEAgAACsoCAAAKEgIAAAmYAgAAD74CAn5ulgIAADKiAgAAQloCAAAOHAIAAGXEAgABrh4A=
Date:   Sat, 27 Aug 2022 00:52:23 +0000
Message-ID: <361256cf42393e2af9691b40bd51594ce078f968.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>
         <165274590805.17247.12823419181284113076@noble.neil.brown.name>
         <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>
         <165274805538.17247.18045261877097040122@noble.neil.brown.name>
         <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>
         <165274950799.17247.7605561502483278140@noble.neil.brown.name>
         <3ec50603479c7ee60cfa269aa06ae151e3ebc447.camel@hammerspace.com>
         <165275056203.17247.1826100963816464474@noble.neil.brown.name>
         <d6c351439c71d95f761c89533919850c91975639.camel@hammerspace.com>
         <D788BD7B-029F-4A4C-A377-81B117BD4CD2@redhat.com>
         <a56ca216aef75f419d8a13dd6c7719ef15bbcaab.camel@hammerspace.com>
         <54685EB8-7E6D-4EC4-8A9E-2BF55F41DABA@redhat.com>
         <f5a2163d11f73e24c2106d43e72d0400d5a282b6.camel@hammerspace.com>
         <FA952BF7-1638-4BD1-8DA9-683078CFDE8F@redhat.com>
In-Reply-To: <FA952BF7-1638-4BD1-8DA9-683078CFDE8F@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66b013d5-3d44-4042-00b6-08da87c6677e
x-ms-traffictypediagnostic: BYAPR13MB2264:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aRmJP3MFZScPau/I5k7q4C/msmiandYLegMAITBq/d2ubLLvN/97oW5xPmyNkw73S5sIC/4/8JX5rZICYRqxvHsyn0Kj1jBsIAmKpfQb7fmRwQL9cLfeWdxNh1JX97a9Z7hjFAkapMMNVHQ/Wu6E0a3f+Cb+soP0jsxCYSj6RLn8gsvU4uZagJSdGlmAc7UcejF7Hja+hvj1eKiBJCVXUd3I1Y9+nrPNaMT7a9LJVh8SRDyxgox/n1P8fQysvalp+VLF95thKsLx047xfnKgwuyPiMQQIjR86BVrMJgo2eTlHQcZd0VkMkrG7Ry54LC1Tvxgylrd9EvVv3ZqQn7TFBc/sC61LjgHU/YhcRJZYiWM/I+cG/rdORe8oG/Dt0hJxpTUJvdfvoVkm6pzJA7lhznzYXo9w5OpR/HejE8EtjsFmxaZ7L1haalX1l3W6oU4crNZlGXmcVWskY/aDYW37+j7SSsNQc/fhUGKjSZgIil/q2LZL13D9Kk5yI/nLfu2SMo+WvndfdMZekFefy6lZLxjNlt/TZE8eXnGQ22F7dD45yLXBrJ8Z5CiwWKdT9hZ3niFMT1gG/Z7sKSFWm6gqqyOgZhdXW7QRDAJbvzhb3rgDd7paHDu88M5gIaS0iFgjPsLWpyAm6ZFh7UxRFV2mOnYVfLDX9MI26lK7n4rNL6dY61Ugr62QzkTqUG/4MVP00yENtbLndss8e78xmF1peSwZNCrdxwApm7w2MFhBO+Zbnv7Xe0K5L7SdAxBdpKkzo/S6JsEt3G80P9bGpLfjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39830400003)(136003)(396003)(376002)(366004)(346002)(6486002)(71200400001)(86362001)(53546011)(26005)(36756003)(83380400001)(38100700002)(6506007)(41300700001)(6512007)(122000001)(66556008)(66946007)(2616005)(8936002)(64756008)(186003)(2906002)(66446008)(66476007)(5660300002)(4326008)(54906003)(76116006)(38070700005)(6916009)(316002)(8676002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3Z5RWU2TmxiZ0pxZU9vSGNlSysvdFA3d1p4OG8zK3Q4WmxTOFZXZHRyeTFv?=
 =?utf-8?B?aEpoM1ZpY3VWbnBKQkV2Q2pvSTRPZFlPYWpUeGZ2YmVrR3k1T3NmVWZvVEYv?=
 =?utf-8?B?aWt3azZlSDVsY0lobU1wSWVoK3BHbVFJVis1TlNMOXZsK3o1cjd1eDd6WjMw?=
 =?utf-8?B?TnYzbmlzaGp2UXAyRmlOUngxNjRNK2FXNFRDK3RTRTF0QVhESWp4M21kUVZ0?=
 =?utf-8?B?b2NPUnNwd2QzMTArYm4yV0dPUy9DOUIvU2hpQU5rSGdUWmZ4cnBLNHRzbVRJ?=
 =?utf-8?B?Um9aVWJZdkRObmo1c0NWMisxQ2I0bUhWR3cxWUJSUTBFWU5ySlFLelFEVHJx?=
 =?utf-8?B?MWVmazhySjZiZ1E5UlRKeWJLNGxvYVdrOUV0SG4xUm4yRnA4NTFsOXVhWkFH?=
 =?utf-8?B?YVY4NjZ0VUZjKzgzTmNVUlZpL1RCWFJHY3RqN0tXaVF1NnFTek9RaVNuQlZk?=
 =?utf-8?B?TG1PcWI3Y0szeDcrREk2bWR2N25iWnIwaUlyT09wdUJhTFFsaEdPWEl1c1Vw?=
 =?utf-8?B?cGgwdHBNeFE4aFJRZ3FKb211YUp4QWR4Tjd4Yy9qbkFOdnNKV3ZIMk15aXB2?=
 =?utf-8?B?SE1iL2FVdE4yUkJBMzlxeGxsMi95UENra3B0S0RINUFyQk9zRjlOaHcrU3VI?=
 =?utf-8?B?UTJSeXc1ZHNjZElyYnRoZ29QNFFocnJZMjE2eWRJTUt2Nk1ha3doS1gra0FM?=
 =?utf-8?B?WGlXbHhLQTdmYmhKVnpUY0NLamVqYzE1Kzg4Q2U1MWVOR05QWWZKNllXekJz?=
 =?utf-8?B?OW9mbTNsa3VKZTIzMTBvS25UTHRvZEt2ZTk2RlVhcjY3bU4rc1VtdmMwcmdx?=
 =?utf-8?B?dTNzamROZ2tmQnpKOHgzVDVITDJQeCtETndVaml2LzhVdldZaU1xMDdRMS92?=
 =?utf-8?B?VXBTSGd0QmxFNWVTOGt4Rys0NEZqcGVqcGszdkFEL0ZPa0tObXljZ3lLTldj?=
 =?utf-8?B?OFlZWS9sNUpKdVZZSldwT1NwOFIxM3V2WkFBY09aL0NLb25Td0prTHBVai9X?=
 =?utf-8?B?Z012VjB2eWtIY2doMXJTYkw2UmRRVU94MzN0LzFQbU5STEw3MStMc1VldGR2?=
 =?utf-8?B?cmI2YVdsZHZDMjk3dUZjaDVBa3hiNjh4WTFzRGlmTWF5MU9YRXdjVnhVdE9Z?=
 =?utf-8?B?VTlBTU5GbU5DTmtHNVJrQ1Q0WGk3WEkzYVp2QkUyQTA2QkZqdkhhWEZqQ0Vh?=
 =?utf-8?B?VUZRVDlvTkZKRFpPbGJtTWdXTitIZlRNMDlOeGhDOGFaQnQvT0hEajYzVnN0?=
 =?utf-8?B?bjg3bS9YcXJXeE9JT3pRT2RUbFpNR2RTWGFoUWpQNGdXbDRTamptUnJiM2RR?=
 =?utf-8?B?TUE1c2NlR0JTdTg1YmdMYVduam5zcThNVkFhMXJIdTVyTmF6dUtIOFkrZXpp?=
 =?utf-8?B?bXd3VkdWV0N1VWRqeWhnZEJQRDRDZ1lxdWZZaUFMWWdua1hWMk5zQTcvWEhq?=
 =?utf-8?B?MFpXaHpwOTdsd2NsNFN2ekVnWUlnYTdGQkJqWEc1S2czTTU5LytVRWpxTGU2?=
 =?utf-8?B?RThvR25UMlBVbWNqRytzRy95Y1krWlBJRko0N1g1WGphRjFKMjVCemJ4RTZO?=
 =?utf-8?B?aTdYTjdmaGJCL1Y5S21RbjBZYXVCaWJULzdUZnNGV0ZZRHRzb3FNZEdOSVdx?=
 =?utf-8?B?VjM5dmVQb01UU2p1RVdXYkFFeFVSbUNnSG5UbUE5UGlpdForK2RTQnM1MVQ1?=
 =?utf-8?B?TnNpek5TNmdYRnlIdzY0dlRnN1pDQ0NqamtEeGc4UmJxdTN0enVlQTZ1a2xx?=
 =?utf-8?B?bFNrQVVXUXE4aENlMDNaL2VqNk4zcVBOM2Qxb0UzTURJQld2blg2dWprTHdN?=
 =?utf-8?B?T1ZIamF6cXBxMDE5clZaeGRaUDJyRHUwbFZvUVhldEZWL0VwRjdSUVV1VUhP?=
 =?utf-8?B?OWpaenA5OGp0dkgvYTVYMThFc3ZQdlVPbVhtQktGN2QrREIrYjR3dDlqek03?=
 =?utf-8?B?T1dkcGNDZXZLRTBJK21CYjRqWTZsdzZJSy9pWU1XNTNDNEdVeDlwem0yM3JI?=
 =?utf-8?B?elp5cFJMYnR5NnJFU1dJVzJsbmYza2h5bFZmQ1FmckhUMnRyQ2lFWXM3QzhP?=
 =?utf-8?B?OWhZQlBjOFNPSzVIdGlYWnJXd2J4czB6b2l4d0RKa0I0enF3SnA5L1VTUk1r?=
 =?utf-8?B?WHQ2N0tHMUptVmROUWhEdm50azlVV2JRVXRYdHJNY3FmejFnWEJiM3E0UHNh?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3103E53F2175684FB817C51380918F96@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b013d5-3d44-4042-00b6-08da87c6677e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2022 00:52:23.5463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1VUY5o43glkptdPh95GPO7k58YDBXa85NPOLA7kaJGQfey2a05ccwh9RnVE/leb+9dx3+J3E74MnkRZY8A19Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2264
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTI2IGF0IDE0OjI3IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyNiBBdWcgMjAyMiwgYXQgMTI6NTYsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gPiBVc2VyIGdyb3VwIG1lbWJlcnNoaXAgaXMgbm90IGEgcGVyLW1vdW50IHRoaW5nLiBJdCdz
IGEgZ2xvYmFsDQo+ID4gdGhpbmcuDQo+IA0KPiBUaGUgY2FjaGVkIGFjY2VzcyBlbnRyeSBpcyBh
IHBlci1pbm9kZSB0aGluZy4NCg0KVGhhdCdzIGlycmVsZXZhbnQuIFdlIGFscmVhZHkgaGF2ZSBj
b2RlIHRoYXQgZGVhbCB3aXRoIHBlci1pbm9kZQ0KY2hhbmdlcy4gVGhvc2UgY2hhbmdlcyBoYXBw
ZW4gd2hlbiB0aGUgb3duZXIgY2hhbmdlcywgdGhlIGdyb3VwIG93bmVyDQpjaGFuZ2VzLCB0aGUg
bW9kZSBjaGFuZ2VzIG9yIHRoZSBBQ0wgY2hhbmdlcy4NCg0KVGhlIHByb2JsZW0gdGhhdCB5b3Un
cmUgYXNraW5nIHRvIGJlIHNvbHZlZCBpcyB3aGVuIHRoZSBsb29rdXAga2V5IGZvcg0KZXZlcnkg
c2luZ2xlIGFjY2VzcyBlbnRyeSBhY3Jvc3MgdGhlIGVudGlyZSB1bml2ZXJzZSBjaGFuZ2VzIGJl
Y2F1c2UNCnNvbWVvbmUgZWRpdGVkIGEgZ3JvdXAgZm9yIGEgZ2l2ZW4gcGVyc29uLCBhbmQgdGhl
IHNlcnZlciBwaWNrZWQgdXAgb24NCnRoYXQgY2hhbmdlIGF0IHNvbWUgdGltZSBhZnRlciB0aGUg
TkZTIGNsaWVudCBwaWNrZWQgdXAgb24gdGhhdCBjaGFuZ2UuDQoNCj4gDQo+ID4gQXMgSSBzYWlk
LCB3aGF0IEknbSBwcm9wb3NpbmcgZG9lcyBhbGxvdyB5b3UgdG8gc2V0IHVwIGEgY3JvbiBqb2IN
Cj4gPiB0aGF0DQo+ID4gZmx1c2hlcyB5b3VyIGNhY2hlIG9uIGEgcmVndWxhciBiYXNpcy4gVGhl
cmUgaXMgYWJzb2x1dGVseSBubyBleHRyYQ0KPiA+IHZhbHVlIHdoYXRzb2V2ZXIgcHJvdmlkZWQg
YnkgbW92aW5nIHRoYXQgaW50byB0aGUga2VybmVsIG9uIGEgcGVyLQ0KPiA+IG1vdW50DQo+ID4g
YmFzaXMuDQo+IA0KPiBTdXJlIHRoZXJlIGlzIC0gdGhhdCdzIHdoZXJlIHdlIGNvbmZpZ3VyZSBt
YWpvciBORlMgY2xpZW50IGJlaGF2aW9ycy4NCj4gDQo+IEkgdW5kZXJzdGFuZCB3aGVyZSB5b3Un
cmUgY29taW5nIGZyb20sIGJ1dCBpdCBzZWVtcyBzbyBiaXphcnJlIHRoYXQgYQ0KPiBwcmV2aW91
cw0KPiBiZWhhdmlvciB0aGF0IG11bHRpcGxlIG9yZ2FuaXphdGlvbnMgYnVpbHQgYW5kIGRlcGVu
ZCB1cG9uIGhhcyBiZWVuDQo+IHJlbW92ZWQNCj4gdG8gb3B0aW1pemUgcGVyZm9ybWFuY2UsIGFu
ZCBub3cgd2Ugd2lsbCBuZWVkIHRvIHRlbGwgdGhlbSB0aGF0IHRvDQo+IHJlc3RvcmUNCj4gaXQg
d2UgbXVzdCB3cml0ZSBjcm9uIGpvYnMgb24gYWxsIHRoZSBjbGllbnRzLsKgIEkgZG9uJ3QgdGhp
bmsgdGhlcmUncw0KPiBiZWVuIGENCj4gZGVwZW5kZW5jeSBvbiBjcm9uIHRvIGdldCBORlMgdG8g
d29yayBhIGNlcnRhaW4gd2F5IHlldC4NCj4gDQo+IEEgbW91bnQgb3B0aW9uIGlzIG11Y2ggZWFz
aWVyIHRvIGRlcGxveSBpbiB0aGVzZSBvcmdhbml6YXRpb25zIHRoYXQNCj4gaGF2ZQ0KPiBhdXRv
ZnMgZGVwbG95ZWQsIGFuZCBkb2N1bWVudGluZyBpdCBpbiBORlMoNSkgc2VlbXMgdGhlIHJpZ2h0
IHBsYWNlLg0KPiANCj4gSWYgdGhhdCdzIGp1c3Qgbm90IGFjY2VwdGFibGUsIGF0IGxlYXN0IGxl
dCdzIGp1c3QgbWFrZSBhIHR1bmVhYmxlDQo+IHRoYXQNCj4gZXhwaXJlcyBlbnRyaWVzIHJhdGhl
ciB0aGFuIGEgdHJpZ2dlciB0byBmbHVzaCBldmVyeXRoaW5nLsKgIFBsZWFzZQ0KPiBjb25zaWRl
cg0KPiB0aGUgY29uZmlndXJhdGlvbiBzcHJhd2wgb24gdGhlIE5GUyBjbGllbnQsIGFuZCBsZXQg
bWUga25vdyBob3cgdG8NCj4gcHJvY2VlZC4NCj4gDQoNCkNhbiB3ZSBwbGVhc2UgdHJ5IHRvIHNv
bHZlIHRoZSByZWFsIHByb2JsZW0gZmlyc3Q/IFRoZSByZWFsIHByb2JsZW0gaXMNCm5vdCB0aGF0
IHVzZXIgcGVybWlzc2lvbnMgY2hhbmdlIGV2ZXJ5IGhvdXIgb24gdGhlIHNlcnZlci4NCg0KUE9T
SVggbm9ybWFsbHkgb25seSBleHBlY3RzIGNoYW5nZXMgdG8gaGFwcGVuIHRvIHlvdXIgZ3JvdXAg
bWVtYmVyc2hpcA0Kd2hlbiB5b3UgbG9nIGluLiBUaGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgdGhl
IE5GUyBzZXJ2ZXIgaXMgdXBkYXRpbmcNCml0cyBydWxlcyBjb25jZXJuaW5nIHlvdXIgZ3JvdXAg
bWVtYmVyc2hpcCBhdCBzb21lIHJhbmRvbSB0aW1lIGFmdGVyDQp5b3VyIGxvZyBpbiBvbiB0aGUg
TkZTIGNsaWVudC4NCg0KU28gaG93IGFib3V0IGlmIHdlIGp1c3QgZG8gb3VyIGJlc3QgdG8gYXBw
cm94aW1hdGUgdGhlIFBPU0lYIHJ1bGVzLCBhbmQNCnByb21pc2UgdG8gcmV2YWxpZGF0ZSB5b3Vy
IGNhY2hlZCBmaWxlIGFjY2VzcyBwZXJtaXNzaW9ucyBhdCBsZWFzdCBvbmNlDQphZnRlciB5b3Ug
bG9nIGluPyBUaGVuIHdlIGNhbiBsZXQgdGhlIE5GUyBzZXJ2ZXIgZG8gd2hhdGV2ZXIgdGhlIGhl
bGwNCml0IHdhbnRzIHRvIGRvIGFmdGVyIHRoYXQuDQpJT1c6IElmIHRoZSBzeXNhZG1pbiBjaGFu
Z2VzIHRoZSBncm91cCBtZW1iZXJzaGlwIGZvciB0aGUgdXNlciwgdGhlbg0KdGhlIHVzZXIgY2Fu
IHJlbWVkeSB0aGUgcHJvYmxlbSBieSBsb2dnaW5nIG91dCBhbmQgdGhlbiBsb2dnaW5nIGJhY2sg
aW4NCmFnYWluLCBqdXN0IGxpa2UgdGhleSBkbyBmb3IgbG9jYWwgZmlsZXN5c3RlbXMuDQoNCg0K
ODwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpGcm9tIDcyZDViOGI2
YmIwNTNmZjM1NzRjNGRjYmY3ZWNmMzEwMmU0M2I1YjggTW9uIFNlcCAxNyAwMDowMDowMCAyMDAx
DQpGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+
DQpEYXRlOiBGcmksIDI2IEF1ZyAyMDIyIDE5OjQ0OjQ0IC0wNDAwDQpTdWJqZWN0OiBbUEFUQ0hd
IE5GUzogQ2xlYXIgdGhlIGZpbGUgYWNjZXNzIGNhY2hlIHVwb24gbG9naW4NCg0KUE9TSVggdHlw
aWNhbGx5IG9ubHkgcmVmcmVzaGVzIHRoZSB1c2VyJ3Mgc3VwcGxlbWVudGFyeSBncm91cA0KaW5m
b3JtYXRpb24gdXBvbiBsb2dpbi4gU2luY2UgTkZTIHNlcnZlcnMgbWF5IG9mdGVuIHJlZnJlc2gg
dGhlaXINCmNvbmNlcHQgb2YgdGhlIHVzZXIgc3VwcGxlbWVudGFyeSBncm91cCBtZW1iZXJzaGlw
IGF0IHRoZWlyIG93biBjYWRlbmNlLA0KaXQgaXMgcG9zc2libGUgZm9yIHRoZSBORlMgY2xpZW50
J3MgYWNjZXNzIGNhY2hlIHRvIGJlY29tZSBzdGFsZSBkdWUgdG8NCnRoZSB1c2VyJ3MgZ3JvdXAg
bWVtYmVyc2hpcCBjaGFuZ2luZyBvbiB0aGUgc2VydmVyIGFmdGVyIHRoZSB1c2VyIGhhcw0KYWxy
ZWFkeSBsb2dnZWQgaW4gb24gdGhlIGNsaWVudC4NCldoaWxlIGl0IGlzIHJlYXNvbmFibGUgdG8g
ZXhwZWN0IHRoYXQgc3VjaCBncm91cCBtZW1iZXJzaGlwIGNoYW5nZXMgYXJlDQpyYXJlLCBhbmQg
dGhhdCB3ZSBkbyBub3Qgd2FudCB0byBvcHRpbWlzZSB0aGUgY2FjaGUgdG8gYWNjb21tb2RhdGUg
dGhlbSwNCml0IGlzIGFsc28gbm90IHVucmVhc29uYWJsZSBmb3IgdGhlIHVzZXIgdG8gZXhwZWN0
IHRoYXQgaWYgdGhleSBsb2cgb3V0DQphbmQgbG9nIGJhY2sgaW4gYWdhaW4sIHRoYXQgdGhlIHN0
YWxlbmVzcyB3b3VsZCBjbGVhciB1cC4NCg0KU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0
IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KLS0tDQogZnMvbmZzL2Rpci5jICAg
ICAgICAgICB8IDIyICsrKysrKysrKysrKysrKysrKysrKysNCiBpbmNsdWRlL2xpbnV4L25mc19m
cy5oIHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvZnMvbmZzL2Rpci5jIGIvZnMvbmZzL2Rpci5jDQppbmRleCA1ZDZjMmRkYzdlYTYuLjVl
MDljYjc5NTQ0ZSAxMDA2NDQNCi0tLSBhL2ZzL25mcy9kaXIuYw0KKysrIGIvZnMvbmZzL2Rpci5j
DQpAQCAtMjk0OSw5ICsyOTQ5LDI4IEBAIHN0YXRpYyBzdHJ1Y3QgbmZzX2FjY2Vzc19lbnRyeSAq
bmZzX2FjY2Vzc19zZWFyY2hfcmJ0cmVlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGNvDQogCXJldHVy
biBOVUxMOw0KIH0NCiANCitzdGF0aWMgdTY0IG5mc19hY2Nlc3NfbG9naW5fdGltZShjb25zdCBz
dHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssDQorCQkJCSBjb25zdCBzdHJ1Y3QgY3JlZCAqY3JlZCkN
Cit7DQorCWNvbnN0IHN0cnVjdCB0YXNrX3N0cnVjdCAqcGFyZW50Ow0KKwl1NjQgcmV0Ow0KKw0K
KwlyY3VfcmVhZF9sb2NrKCk7DQorCWZvciAoOzspIHsNCisJCXBhcmVudCA9IHJjdV9kZXJlZmVy
ZW5jZSh0YXNrLT5yZWFsX3BhcmVudCk7DQorCQlpZiAocGFyZW50ID09IHRhc2sgfHwgY3JlZF9m
c2NtcChwYXJlbnQtPmNyZWQsIGNyZWQpICE9IDApDQorCQkJYnJlYWs7DQorCQl0YXNrID0gcGFy
ZW50Ow0KKwl9DQorCXJldCA9IHRhc2stPnN0YXJ0X3RpbWU7DQorCXJjdV9yZWFkX3VubG9jaygp
Ow0KKwlyZXR1cm4gcmV0Ow0KK30NCisNCiBzdGF0aWMgaW50IG5mc19hY2Nlc3NfZ2V0X2NhY2hl
ZF9sb2NrZWQoc3RydWN0IGlub2RlICppbm9kZSwgY29uc3Qgc3RydWN0IGNyZWQgKmNyZWQsIHUz
MiAqbWFzaywgYm9vbCBtYXlfYmxvY2spDQogew0KIAlzdHJ1Y3QgbmZzX2lub2RlICpuZnNpID0g
TkZTX0koaW5vZGUpOw0KKwl1NjQgbG9naW5fdGltZSA9IG5mc19hY2Nlc3NfbG9naW5fdGltZShj
dXJyZW50LCBjcmVkKTsNCiAJc3RydWN0IG5mc19hY2Nlc3NfZW50cnkgKmNhY2hlOw0KIAlib29s
IHJldHJ5ID0gdHJ1ZTsNCiAJaW50IGVycjsNCkBAIC0yOTc5LDYgKzI5OTgsOCBAQCBzdGF0aWMg
aW50IG5mc19hY2Nlc3NfZ2V0X2NhY2hlZF9sb2NrZWQoc3RydWN0IGlub2RlICppbm9kZSwgY29u
c3Qgc3RydWN0IGNyZWQgKg0KIAkJc3Bpbl9sb2NrKCZpbm9kZS0+aV9sb2NrKTsNCiAJCXJldHJ5
ID0gZmFsc2U7DQogCX0NCisJaWYgKChzNjQpKGNhY2hlLT50aW1lc3RhbXAgLSBsb2dpbl90aW1l
KSA8IDApDQorCQlnb3RvIG91dF96YXA7DQogCSptYXNrID0gY2FjaGUtPm1hc2s7DQogCWxpc3Rf
bW92ZV90YWlsKCZjYWNoZS0+bHJ1LCAmbmZzaS0+YWNjZXNzX2NhY2hlX2VudHJ5X2xydSk7DQog
CWVyciA9IDA7DQpAQCAtMzA1OCw2ICszMDc5LDcgQEAgc3RhdGljIHZvaWQgbmZzX2FjY2Vzc19h
ZGRfcmJ0cmVlKHN0cnVjdCBpbm9kZSAqaW5vZGUsDQogCQllbHNlDQogCQkJZ290byBmb3VuZDsN
CiAJfQ0KKwlzZXQtPnRpbWVzdGFtcCA9IGt0aW1lX2dldF9ucygpOw0KIAlyYl9saW5rX25vZGUo
JnNldC0+cmJfbm9kZSwgcGFyZW50LCBwKTsNCiAJcmJfaW5zZXJ0X2NvbG9yKCZzZXQtPnJiX25v
ZGUsIHJvb3Rfbm9kZSk7DQogCWxpc3RfYWRkX3RhaWwoJnNldC0+bHJ1LCAmbmZzaS0+YWNjZXNz
X2NhY2hlX2VudHJ5X2xydSk7DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9uZnNfZnMuaCBi
L2luY2x1ZGUvbGludXgvbmZzX2ZzLmgNCmluZGV4IDc5MzFmYTQ3MjU2MS4uZDkyZmRmZDI0NDRj
IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9uZnNfZnMuaA0KKysrIGIvaW5jbHVkZS9saW51
eC9uZnNfZnMuaA0KQEAgLTU5LDYgKzU5LDcgQEAgc3RydWN0IG5mc19hY2Nlc3NfZW50cnkgew0K
IAlrdWlkX3QJCQlmc3VpZDsNCiAJa2dpZF90CQkJZnNnaWQ7DQogCXN0cnVjdCBncm91cF9pbmZv
CSpncm91cF9pbmZvOw0KKwl1NjQJCQl0aW1lc3RhbXA7DQogCV9fdTMyCQkJbWFzazsNCiAJc3Ry
dWN0IHJjdV9oZWFkCQlyY3VfaGVhZDsNCiB9Ow0KLS0gDQoyLjM3LjINCg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
