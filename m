Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719AB5AC855
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Sep 2022 02:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiIEAt7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Sep 2022 20:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIEAt6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Sep 2022 20:49:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FDD13D05
        for <linux-nfs@vger.kernel.org>; Sun,  4 Sep 2022 17:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDpiSpN7Cc6qVGx0LZpgZ3IsNLPcmps+/Cjs2ZeA2oUgoELUOxucErPGCj0JQ4anL8ajoY48KbxsB44MsgECOUET5XDFIem27Rtm7EZbUZ+iXBnKeEUQLcDUb0NhbtEa6ac9mSPyfwZTZxIo8N7UDxMt1mrWUuMbSUj0jMf+Ntt8Spd/WNBEjUESJfi1Wo8WvxHdCHBXMmgohY6LLFV7pmgenYQnJSZf3sB4plDTsKtNQGF/1ExguVlPEyrpKLhynfoLCep1OCpSRXlgTtA0Ke9C11GfII/gCPwLzY28vgoRh8WmVuQgg/HVNdczdukiZGwIq8lcNrzFY6+tIGaThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUxU6KM5NEBddcbmRgQHudwdNsOWi5uWNj8vDKTdEN0=;
 b=j65kNs7RT+bdHtc0engqgSFlZqSbwKSGC3anDigtUwS3SEQt6fhr8GVSZH5kPUfQ7sJ0tgU8eWOG8u+PLK0W+xscaM1aMNlYNbveDAt3PmsvYFEb1sS5wsePZMfUYQGqey95PZixuetPfiOduIAuERioi4mvN3X3C1MK6itOni2iogY5dPUy6wyHF7mkP62JRocWhJqEF3vMYWzGqg1a2CGNfuETWJOzyc3vyGnH5eUIOmyvvAR+bMEn+1o69oFIeljHTXWPAhXrfAK/f7rZa613GcCRHs5dbp2hr+jgV63hAU6d54zGMEb4IPGORCZbh8x42Crnv7pS3jYVyCU9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUxU6KM5NEBddcbmRgQHudwdNsOWi5uWNj8vDKTdEN0=;
 b=eAxQ9mUCD/ljmWXIFH3TIxldtS3NZ2SNk3sVePNX6I9ImcXkjqwUDnwUFcLj9E/dxzpRidQzaehuXNEEUXzy/anc/2nRU1OhCmoDfUAhD9cndJ1oH3Af7cDGLcWIjwXqMVF69rw8bM6XAinHMUab2G3j2CpMu1A7uNJN432o/ME=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3643.namprd13.prod.outlook.com (2603:10b6:5:242::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.11; Mon, 5 Sep
 2022 00:49:53 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.011; Mon, 5 Sep 2022
 00:49:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Thread-Topic: [PATCH 0/2] NFS: limit use of ACCESS cache for negative
 responses
Thread-Index: AQHYWqCwBzhUO4xFMUm2kRfU0oEzLK0iTkgAgAAEXYCAAAWigIAABBEAgAACsoCAAAKEgIAAAmYAgAAD74CAn5ulgIAADKiAgACEsICAAELlgIAC38AAgAD0fYCAB5X6AIAAYkyAgAIShYCAAAN5gIAACAOAgAALQQA=
Date:   Mon, 5 Sep 2022 00:49:53 +0000
Message-ID: <23bc916cd8ca2a7b4d1effaefd173a05e8c1af03.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>   ,
 <165274590805.17247.12823419181284113076@noble.neil.brown.name>        ,
 <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>       ,
 <165274805538.17247.18045261877097040122@noble.neil.brown.name>        ,
 <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>       ,
 <165274950799.17247.7605561502483278140@noble.neil.brown.name> ,
 <3ec50603479c7ee60cfa269aa06ae151e3ebc447.camel@hammerspace.com>       ,
 <165275056203.17247.1826100963816464474@noble.neil.brown.name> ,
 <d6c351439c71d95f761c89533919850c91975639.camel@hammerspace.com>       ,
 <D788BD7B-029F-4A4C-A377-81B117BD4CD2@redhat.com>      ,
 <a56ca216aef75f419d8a13dd6c7719ef15bbcaab.camel@hammerspace.com>       ,
 <166155716162.27490.17801636432417958045@noble.neil.brown.name>        ,
 <c64f102712ed8a5d728c2bf74592715891302f78.camel@hammerspace.com>       ,
 <166172952853.27490.16907220841440758560@noble.neil.brown.name>        ,
 <22601f2b7ced45d3b5f44951970f79c22490aced.camel@kernel.org>    ,
 <166219906850.28768.1525969921769808093@noble.neil.brown.name> ,
 <1cfb40103f3f539973587f4565af79d5dc439096.camel@hammerspace.com>       ,
 <166233410596.1168.312161459644850792@noble.neil.brown.name>   ,
 <2e5b8af112d8440757681a1f71de4ec0cc57ae90.camel@hammerspace.com>
         <166233657158.1168.394810496332729625@noble.neil.brown.name>
In-Reply-To: <166233657158.1168.394810496332729625@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB3643:EE_
x-ms-office365-filtering-correlation-id: 9966be2a-422a-411a-5b9d-08da8ed88beb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Sp71Wdl3Y4knlxknyBbgmA0U7AdFhv/IBnlV4kGn2iLM8Y6pEA34msMpIUUfAO9MyEnUTlE58yRVp2ws8gFLejbGjUzt9ZO1rmvI3A6uMolnp/zzltCKynA2xPSwnUmxpuFKnu71IbxxnBkIm+nrV13+SzyRlTlDbCmLsILykqBtOYb+L0GqaQdceuNO1OGL+UPZyq6bIboEIHS+2zUXyOJz9mhPSShDSwwj3eiKFqNIMyVS+k6nyVKiHsab4hfrlEbJjw2zqqWZZ9GtMi1NlykzG/8yc6qLNn0NeorTW3/VPqwkPfvq77WAy3Dd53xlxAUHANM9xJZGB9IP23w0yMzTnghEI5Opf0N7xvPekSq3U6NLyl3arMywgCZecF+wwO/qZM8eq711LVjKNtGF60gUK6Q4/SSW/8nxLtT9RKLUrogFJjUM0slvGGNwdDnbEB1wwX2zOgiREKyuqzSElVL9CxJ61UtKav0GxqceGvGwR6VYtu39CMMb3bZOhkv3Xzm32qHBSnR09Q+exQrhG2Ob9kBB02709VKVIFD0e5E03gOwy0CEGS+4so7AM2qe6l4Sa8964qgZeSJ0StZ0kaZJsLIZtb4xUu2BuToKJX2QGqiyk7jgdLmVzxNjFcjuK8Ra2e5IuVZOELa4ZnM1Q3Iale6VdKDISpnc5+Oo+UV7SRUHnoRNgRHWV3uN4DDOZ/5RBbrKcvtAE5J+r//dlCw7gCS31mDjDN4LbcczgxYex1f0bx/zr1+MfD4QGR5Tjrt36ZhYK0QZoHw0mcr06d3th9a9kKOGfuVsF8n3VaCsx/o1DMrmtux4qTmTbjp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39830400003)(366004)(376002)(396003)(136003)(2616005)(186003)(41300700001)(71200400001)(478600001)(6486002)(26005)(6512007)(6506007)(86362001)(38070700005)(38100700002)(122000001)(83380400001)(316002)(5660300002)(8936002)(54906003)(6916009)(2906002)(64756008)(76116006)(36756003)(66446008)(66946007)(8676002)(4326008)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTc0SXVNanpKUk4vbGt0WFNVazg2RmxFbXlwNHNma2dlUnhaVkxWbjJORDky?=
 =?utf-8?B?TkNJTllKMjhwQXZjdzZJOFd2TjZoN0YrdTVxdERQa2VsYkRJeFlnMXpIZVh6?=
 =?utf-8?B?TzNTUitmZFdXQzE1dmdEaSt4cmtDalBCOGhtZDhNWDVqUE1KZ3A3SERRM0gv?=
 =?utf-8?B?Nk5UZDM5WGlGbEdURHRlbktWajB2YURjM1BBTnpGVUxGcXpMQ1NhZDdZNUpR?=
 =?utf-8?B?QytLQzNubldIVWthQ00yOUNnL3RnNzIwS2xoZmJFanFUQ1lNdDlnR2NPVEs4?=
 =?utf-8?B?Y3NZeEV5anpXWEEwbnQ0aVFoQks2NGpoQVpMdGo5V3QwM0x1a0NMTmQyUmRl?=
 =?utf-8?B?c3ZOTWJnSHVBMlF0QjZmS1pZNHV0VEhGaVVCQUZSYlFTVUVYb3d5cktUbUJ3?=
 =?utf-8?B?b1VUUzdzMmtHTVBacjcxTXBqQ00xZUg0a3YyU0Z4dXRzYk4zT08wZllEcnFT?=
 =?utf-8?B?blRFZGJKWFJZZUwra1l5NDBiVFRUMjVMak1RZVh2NVhOeDhoY2ZHVG0xbTBE?=
 =?utf-8?B?cW9tZXkveXVmM3ROWEgxckVVbEpTc1hrTUQ3V3RWNUxRbFhNYmFGVEljVU1r?=
 =?utf-8?B?c21BaEd3bkJKRnpZUlJrbDR0eWFVSmMwT0JMQ2FXcGROaE1VdUF5aTA2VmJ2?=
 =?utf-8?B?cGFRZEdYNFNwSGJjL0FtaS9qZUl6NUM1ckdGZG5NelRPeWVHOUJZb3Q0Qktj?=
 =?utf-8?B?L0kyTnd0cDJkMjJkNHg3UTdGTXFtZWI0OGt5T3UrNDdodlNYcE1wUURPZXhz?=
 =?utf-8?B?Smd2ellYUWVZY3ZNUktWeVJNWVMrc0Q0ZkkyeFFwdnc4V3lxK3lUL0tZRHZN?=
 =?utf-8?B?NVg1Z29PQnQyNkpMQnd5YitwbVlVVk1lNzQ4V1VDK2x3THBtR3RpcWFsS0NB?=
 =?utf-8?B?OWpVTEZSL3p4RzRRZktiV3FpTld5SjZXcUVRTS9sbm9jSnFSSDNuT2Z2NEtx?=
 =?utf-8?B?dWxwSDVoQkh4ZFJQdVo0QXZQbXQxVWw2YkxjTkE2NFNXUXNUVWVjMkxJZTFj?=
 =?utf-8?B?NlNrZlpKVHZVSWhzQk5ILzJXMmVnM0QvN2dhbUZEK3k1MUFlcnhJWG54ZzRm?=
 =?utf-8?B?V1VtVzdnY1NPZTZjQ2tnVzdNRm9RUHkzcjJDanplNXBTTHRqeWg0ckZQRktm?=
 =?utf-8?B?M3FydWFiQTBUOEpLVEZHR0puQ1FPajJpQjMvSUg0ODhlbkxsSGllNFVEN3dE?=
 =?utf-8?B?ZkJycmZybzQ5dU9nVTJZbG1obXIwa2g2cFg4WWRJYlV1SEFzV3JmSGVUU0c5?=
 =?utf-8?B?WTZwY0R2NVFicUI4UERjSEl0YXBjbCtNUFNKaXF2U2g3YkhaWCs2UG1KaDFu?=
 =?utf-8?B?YVZYVjZSMER3U2RvNnRaRmV2enUvYzJzUVcwTkZtSGQ1OGY5K1BxZnJxc1lq?=
 =?utf-8?B?VWlTamx1UTlxdjRjMjVKclYwenkxbXpJZzVlTlh4enFrVEFvMGc1NVFuYjFv?=
 =?utf-8?B?emZ0MGcyaW54ZTYvK0NHVW1leUg4NGUreXlsTlJKajkvaUdrTkVUWER3OSsx?=
 =?utf-8?B?SGo2SGpncEJBVXR6aWdYRTVTZGdUUEh6OEQxR1NNQnY2SzQ4SkEzVmRiSVdk?=
 =?utf-8?B?MGh5bFJzbUVhSTZDcXdhdm5BcjFmbGdTWndrVDJSMUc4UlJMNkRWM1JSVWgr?=
 =?utf-8?B?aGhZSk9qSnp6eGpENXVwWkJNYlBKVkxTeXVVQm1TK0RmTFp6MTRLMWZuMkFI?=
 =?utf-8?B?WlliTlVXU3pJZnhXSWcwTnFKWkxoaG9ZNW5wS0lkWjFKSmx2ZzlHYjk5Q1VN?=
 =?utf-8?B?ZFFvTlRIOUFUNUFKNzdwY0VsMG5kSVlEd2UvaWZuQjQxQUhZemdCVGNENEkw?=
 =?utf-8?B?bk9xQTUydStrWmdCTURrV0RCb0RVb0JVTE04M2VmcllGaXF3VWJhQldMdURi?=
 =?utf-8?B?QWFDMmlTSnhoNUJObTVVQ01GQnN2dDVUN210ci9EbVRLbUUza1ZjR2lqcHlB?=
 =?utf-8?B?V25FUk5hZW13TXJHcjY4TFBCNitwdHFMWjFscmtIR0FTdU42aUJienNYbkdL?=
 =?utf-8?B?dUlmQzRtL1FuQVJvamtSc1ZKTHZweGJGd1JYcDM3N3JUdVJwU2RoL2VNcDVp?=
 =?utf-8?B?Q0xtU2JRREF5Zkx2YUlHaXR3ckZjZ0pQVEpsVmlJNnFYbWQwejhlQ0hUY2tL?=
 =?utf-8?B?M1BWUE9LdU96ZFRxUVZiZkU0VDE2UWNGbGxxR0JFTW9GUjRUOXc3UUFuS2c5?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02275E31BF8E4B48B7C970A222F3BDB9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3643
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTA5LTA1IGF0IDEwOjA5ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IE1vbiwgMDUgU2VwIDIwMjIsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBNb24sIDIw
MjItMDktMDUgYXQgMDk6MjggKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+IA0KPiA+ID4g
V2hlbiBJIHdhcyBmaXJzdCBwcmVzZW50ZWQgd2l0aCB0aGlzIHByb2JsZW0gSSB0aG91Z2h0DQo+
ID4gPiBsb2dvdXQvbG9naW4NCj4gPiA+IHdhcw0KPiA+ID4gdGhlIGFuc3dlciBhbmQgZXZlbiBw
cm92aWRlZCBhIHBhdGNoIHdoaWNoIHdvdWxkIG1lYW4gZGlmZmVyZW50DQo+ID4gPiBsb2dpbnMN
Cj4gPiA+IGdvdCBkaWZmZXJlbnQgY2FjaGUga2V5cy7CoCBUaGlzIHdhc24ndCB2ZXJ5IHdlbGwg
cmVjZWl2ZWQgYmVjYXVzZQ0KPiA+ID4gaXQNCj4gPiA+IHVzZWQgdG8gd29yayB3aXRob3V0IGxv
ZyBvdXQvaW4gKGJlY2F1c2Ugd2UgZGlkbid0IGNhY2hlIGFjY2Vzcw0KPiA+ID4gaW5kZWZpbml0
ZWx5KSwgYnV0IHRoZSBraWxsZXIgd2FzIHRoYXQgaXQgZGlkbid0IGV2ZW4gd29yaw0KPiA+ID4g
cmVsaWFibHkgLQ0KPiA+ID4gYmVjYXVzZSBvZiBwcm9wYWdhdGlvbiB2YXJpYWJpbGl0eS4NCj4g
PiANCj4gPiBUaGVuIHRoZSBvbnVzIGlzIHVwb24geW91IGFuZCB0aGUgcGVvcGxlIHdobyBkb24n
dCB3YW50IHRoZSB0d28NCj4gPiBwcm9wb3NlZCBzb2x1dGlvbnMgdG8gZmlndXJlIG91dCBuZXcg
b25lcy4gVGltZW91dHMgYXJlIG5vdA0KPiA+IGFjY2VwdGFibGUuDQo+IA0KPiBXaHkgbm90P8Kg
IFRoZXkgaGF2ZSBhbHdheXMgYmVlbiBwYXJ0IG9mIE5GUy4NCg0KSW4gbW9kZXJhdGlvbiwgeWVz
LiBIb3dldmVyIHdlIGRvbid0IGdyYXR1aXRvdXNseSBmbGluZyB0aGVtIGF0IGV2ZXJ5DQpwcm9i
bGVtIGZvciB0aGUgdmVyeSBnb29kIHJlYXNvbiB0aGF0IHRoZXkgdGVuZCB0byBjcmVhdGUgbW9y
ZSBwcm9ibGVtcw0KdGhhbiB0aGV5IHNvbHZlLiBMb29rIGF0IHRoZSBwcm9saWZlcmF0aW9uIG9m
IG1vdW50IG9wdGlvbnMgdGhhdA0KYWxyZWFkeSBleGlzdCB0byBzb2x2ZSB0aGUgYmFzaWMgcHJv
YmxlbSBvZiB0dW5pbmcgb2YgYWxsIHRoZSB0aW1lb3V0cw0KdGhhdCB3ZSBhbHJlYWR5IGhhdmUu
DQoNCj4gQnV0IGxldCdzIGZvcmdldCBhYm91dCB0aW1lb3V0cyBmb3IgdGhlIG1vbWVudC4NCj4g
WW91IHN0aWxsIGhhdmVuJ3QgYW5zd2VyZWQgbXkgcXVlc3Rpb246wqAgV2hhdCBpcyB0aGUgY29z
dCBvZiBub3QNCj4gY2FjaGluZw0KPiBuZWdhdGl2ZSBhY2Nlc3MgcmVzdWx0cz8/DQo+IA0KDQpX
aGF0IG1ha2VzIHlvdSB0aGluayB0aGV5IGFyZSByYXJlIGVub3VnaCB0byBjb21wYXJlIHRvIHRo
ZSAxIGluIGENCmJpbGxpb24gY2FzZXMgeW91J3JlIHRhbGtpbmcgYWJvdXQ/IFlvdSdyZSB0aGUg
b25lIHdobyBpcyBjbGFpbWluZw0Kd2l0aG91dCBvZmZlcmluZyBhbnkgc2hyZWQgb2YgcHJvb2Yg
dGhhdCBuZWdhdGl2ZSByZXN1bHRzIGFyZSByYXJlLg0KDQpBcyBmYXIgYXMgSSdtIGNvbmNlcm5l
ZCwgYWxsIGl0IHRha2VzIGlzICRQQVRIIGNvbXBvbmVudCB0aGF0IGRvZXMgbm90DQpoYXZlIGxv
b2t1cCByaWdodHMgc2V0IHRvIGFsbG93ICdvdGhlcicsIG9yIGRpdHRvIGZvciBhIGxpYnJhcnkg
b3INCmNvbmZpZyBmaWxlIHBhdGggY29tcG9uZW50LiBBbHRlcm5hdGl2ZWx5LCB5b3UgaGFwcGVu
IHRvIGhhdmUgYSBmaWxlDQp0aGF0IGlzIG5vdCBleGVjdXRhYmxlIGluICRQQVRILCBidXQgd2l0
aCBhIG5hbWUgdGhhdCBtYXRjaGVzIGEgcmVhbA0KZXhlY3V0YWJsZSBmdXJ0aGVyIGRvd24gdGhl
IGxpc3QuIFN1ZGRlbmx5IHlvdSBhcmUgaGFtbWVyaW5nIHRoZSBzZXJ2ZXINCmRlc3BpdGUgdGhl
IGZhY3QgdGhhdCB0aGUgcGVybWlzc2lvbnMgYXJlIG5ldmVyIG9ic2VydmVkIHRvIGNoYW5nZS4N
Cg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
