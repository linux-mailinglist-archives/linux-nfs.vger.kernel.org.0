Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6255D5A3427
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Aug 2022 05:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiH0Di7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 23:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH0Di6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 23:38:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2107.outbound.protection.outlook.com [40.107.243.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB85C2F9C
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 20:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVoA/geotyZlSFmhv45u0GNA1Jwfe3gxuaee/ldRrCTVETR333AJEvoQa9jRbAjdK5A3QPD8CbARhgLaoBUx3jIRu0YP3UXpH2w3eGuxkLmz4nrVgQUa79pzD/Hmo47MuXZO+wph0svySo3qgKQQVT2HJtt3r1ZetzzX0sfr58qd8RF9RYoHwa2xxgza6rYh6ifloRxDiOHcfxmolRWgo38TVWE72UcNCvBf3JPGEl32TSiSpHdN4yugY9lmWcoaLZiSExs8bH80jQZAoMyXPsbUDoAnMPh8v+gDVOvlrqr3ZQk1aqxXy5udRU7s/IWPZXkv8Z24qWr8rYUZHA9wuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOjd/TUH/Yeb2uV62hN4GSJZzA9XzP6rhlmfnMCFTfw=;
 b=ZdzVe4eImkwxWEYQnLVx58s5p+90SnqdQvpGkzCJU0x2I91BsAkkXARAE822qvtNMyriZ+K15AFwHYoVLPWugLd0fb761QOur6KS0O/NbpGC5jh0fEGkZleFQpxukldnGc7XNkXndRrGYD4GX5IdcHgZ8v5O5fAkK4Z/5YDbqS10F4TtVgnYb4qEnaePFiV8zpnbH3w5knTMyAYwE5ZUoL4MevYsKQh8UBmaXmsxs98qllEkivfNuesdtSS1O1WWY65IIHptVKAez2TL3MrbtvCCgAtN5ZMGy6u6ZKHlYT6oR5PBqQw2Ga/vu42COlLF8ylIpmTYgOb19m9LXfSqww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOjd/TUH/Yeb2uV62hN4GSJZzA9XzP6rhlmfnMCFTfw=;
 b=QM98jp1z71dc0Na1S95GU3eA5hkHY/PmQZTHMwXHC1XonFbzV6I/mddThdgcXc9tOGnPe/s69Nr3qopimNEE9scOyJf4dgWEXKAy10efvNC8DbHsnZ64zdwUkfgXPhjHv9ZkC6VL1RkyVQjKQND44DGnX2zP9u9HWPTLGYtCShY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3615.namprd13.prod.outlook.com (2603:10b6:208:16c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sat, 27 Aug
 2022 03:38:51 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%4]) with mapi id 15.20.5588.003; Sat, 27 Aug 2022
 03:38:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Thread-Topic: [PATCH 0/2] NFS: limit use of ACCESS cache for negative
 responses
Thread-Index: AQHYWqCwBzhUO4xFMUm2kRfU0oEzLK0iTkgAgAAEXYCAAAWigIAABBEAgAACsoCAAAKEgIAAAmYAgAAD74CAn5ulgIAADKiAgACEsICAAELlgA==
Date:   Sat, 27 Aug 2022 03:38:49 +0000
Message-ID: <c64f102712ed8a5d728c2bf74592715891302f78.camel@hammerspace.com>
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
 <a56ca216aef75f419d8a13dd6c7719ef15bbcaab.camel@hammerspace.com>
         <166155716162.27490.17801636432417958045@noble.neil.brown.name>
In-Reply-To: <166155716162.27490.17801636432417958045@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d16babd-9712-4ad3-1e78-08da87dda7db
x-ms-traffictypediagnostic: MN2PR13MB3615:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XdxlxQlmRVd6rLzLuOwkJbx9ttDrPSCj7Jf4rWinK+O5Xb1OW1ZVT7juR6FESuT8iLRBGAGAcdYlExSpT9CPHsFBTE5xacYRUc7UZRq55+0GAmxngmfIzn2hCoteqbW235B7bRFNFeK+MCCD/q3aoHlivBUrDdbmhycq1ku+7Wn2bCK9c2Q7WqfckM6pjrCwdsx/1l6pRzlTLKvIwcunLAbtc3rT4syVNciSNFd1HYbw1hGXaDCLgUlqkoLafP7bv/i4ah0HtAVHOOsBIdOQM/4q/187cuS2ZAKROBze9S8fYltUrqJZaCk7UM4mreHb61J6X5DXRgpWcUgyR6rHq38HL9OG8/61LRUGZDEnHjKr2K8NOEwWEmuMKvCt9fTko57szPy7LYl+4zuc5tT0lk/bkI7xQJXpwBxts2mgQ9OOgmDDXrhLkh9g2AVG7xrORzfk3PFmL7OYRZqueTcPqgfl6KQHQ0R4vYk5d87jG4pkr56fbBFvToAK78D/EYKvOBHnjrx2kLIAKOwkBE0UH7zpmBh48x2cj7ez/tcv7Hzdri2qEQRdivoFidC/LYKu0pcwA0vZwDwhDcGPhD2X5vG/DwNyITrroYH8YwkP5ZbUtC7UDX4KujmP9equDrnh/WQbiF3nIC9/olkMs5RjgJ62dhn7N38LwaBHJk/tTBpVW7TlBCelhjrpJVd4N/dY8NI+EP0OpPeNsfL1z7bP9Vv+VFh4R4Q18y0waeaI05D7iWccQYUY20D/F8Y97vxkk7gf9oLVTCGZGHziBnNRbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(39840400004)(396003)(366004)(83380400001)(86362001)(38070700005)(71200400001)(66476007)(4326008)(38100700002)(6486002)(76116006)(66446008)(122000001)(66556008)(64756008)(8936002)(478600001)(2906002)(8676002)(6512007)(316002)(6916009)(66946007)(2616005)(54906003)(186003)(5660300002)(53546011)(36756003)(41300700001)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU42UUxVb2F0TzJsTnY4RHRSalZrYnBVMm1Eak4zbVhmUU5TcGMya0FhWGpv?=
 =?utf-8?B?dU50WVdQVEp1bjYyWldtNCswOGU4c0R4Mmd4Qll1WHU4UzhodkV6SzJmaVd4?=
 =?utf-8?B?clNiNTBQYnBYc3NaNHNhQjBDVmtBMHNOT3pwVGw5UTExRlQ1aGwzbjJkcTRX?=
 =?utf-8?B?cCtSR0lZRlRJU0dCcDJBUDRsS2J2dEl5ZHFkTm5wVnFtQ3duV3lpTkQ0enlo?=
 =?utf-8?B?Ti95cVpPZ3QrNTNRU3dwaUJVMXJNaWJGYS9HNXhrZ3p0SjdSam1mODFyZUdG?=
 =?utf-8?B?SkEyWHRrWHpGV3JWN3RlaEFONGozQ3B3V2M3MTh0T0ozcGp2T2VhNUpLVzlV?=
 =?utf-8?B?U2orbVRWMisvU21LUTJEdTdVYTNLd2kwcWFzbndpaURpTVJKZEZyODdiR0RP?=
 =?utf-8?B?SEVXcS9Za25hMzlUdENxZEVacU1MajRHNUJ4WXgyQXpSdjFpUDhyRDJEMVVm?=
 =?utf-8?B?Z1U3WkZhWTM0SXVkMEx3RGZKb003ck1EL04wdkZMTHk3Z1p6ZFRXejNhSGk3?=
 =?utf-8?B?MmhjZ1pKaXVUc20zL3hnbW56NkkyNkFQSlZvQzIyNW9zRUcwSFdNWEpWUVpw?=
 =?utf-8?B?c0luNE16QmlYY3E3RFJySUdpT2k0bVlUQ21SbFNkd2dXNDZtYUF0SUJXZThz?=
 =?utf-8?B?ektGaUlFQnBDdllhVXFkLzFzZEhFY1JBb21jRnpjTFdRSXVIQnpVWVZpUStJ?=
 =?utf-8?B?WFYwNkpKaDgycTF4clRzalNONVZXV09DRGVMbXE4S3QydDR3YkpBcjlwWndm?=
 =?utf-8?B?TFY2S0xaMlBKV3V6WFFraVVUUHFNV1paOERFRUJLaW5MM1gxOEdBVzBFVEts?=
 =?utf-8?B?U2dOQ1dmVGMrL1hhckYvQmIrTUdpSHJVdGxJSzRvYzlNSWNVbnBhN2hpTExk?=
 =?utf-8?B?MkxHYklyVE5JN1hUK3pDU3FmMXlMQkVzbmhrTk1YNVUwV2d2NE84dThMMFRD?=
 =?utf-8?B?bW1GWmVTcVZiZXhMK2FoYk9MUmJQNVM0dm5KSTlGR0FpcTBOM1hSOTBveHJO?=
 =?utf-8?B?cWxjcmprd2ZxYmV0djRSWjVOeFBLSUd5YTEwYmJRK2RwTFY4c0pKa2lDaitJ?=
 =?utf-8?B?L01Uek1Hdy8rektOb3AxNXF5WkQ5blI5T21kT3ZzNi96VjNkY2RLbUtEbmxs?=
 =?utf-8?B?bi9TNm1aaktoejlLWHF0bGFlVUY5eUN5MERUc2twaDd1bVZYRFdXNU14UmFM?=
 =?utf-8?B?SHVtcjFSaUs4NW1ESVQ2MDVqNVpmK0I3YXJ1NzJ4NGlYWjA4NHVNNjJjN1lk?=
 =?utf-8?B?VmVsNTJNVU9CZW94RFkrWVdkRWY5UDh3MlpMYTdoNWZlVlZpTHAyT1NiMmVV?=
 =?utf-8?B?VTJGNXZOV1hHLzlhSm5PcGVtUnA0d3AzSVBzZ05OMThTNHNuZGlCcDZ1b1Nm?=
 =?utf-8?B?N3B1WTNPT0VsdjJmYWtVM0greDk0b1BUOGFOTFJmQVhuSEJjN29QbHV0dTNB?=
 =?utf-8?B?WElVMllQMEFYWXNuSEl2S05oNjFLVzJDZ1FqQzRuYllnNDh6OTNjSWJwZ2Fs?=
 =?utf-8?B?WFcwYnJES2txajN1TW13cDhXejd6VHFteUREU25SYzA2QjhFeVlCQ0tOWXcy?=
 =?utf-8?B?OXpBSWFtNVdFNGxBZGp6U1VQSnhaY0NoWVNVQlczcHJDVkIwZGNHUk9MU1BV?=
 =?utf-8?B?K21sTHNvVmhmU0M1VGdLSlJzWDZQaFlGYWp1Smx5YnlFUENDNzRDMFVpbUtj?=
 =?utf-8?B?VFI1UkN3TG85ejEwRDF2UTgzczRwcldvLy9yUU9sazBxaHBMZ0hXdllVMGVq?=
 =?utf-8?B?TXlZcnZKNzI0Z1psSUpwd1VBRlBXWGtOdHBBaFAyTGJLVTVOWnBTUG1iUWFu?=
 =?utf-8?B?blZrRnZVVUtTT1lNMGJzMFB0Qnp2eld2aU5SejhIOGluMTQwcGZxQWZUVXZH?=
 =?utf-8?B?TFg0dW15WUF2MFFqS0JiaThzdWxwa1ZYT0czYlZRL2ZOK05xMDNYMmVCajJ0?=
 =?utf-8?B?dWdOK0ZkNnpoK2t6K0xLcHVBZHhlUENsZEhnck5MeFFSUEVhTGh1aytjZnVC?=
 =?utf-8?B?TW4valJDeDA1Mldhd3FMVjRNZ05OZjRsRVdLZzRQTFFnaFo1MjFESWlLRjN5?=
 =?utf-8?B?YjVURVRWSCtiY0hSSDA4ZGhSb1ZJSjBnbnpoR1h6UnBpeVhIWThGU3pyL3Jm?=
 =?utf-8?B?c2JBMkxkdjZIOUhHbVlETDZVN2dVTWRZaHdNMlhxcnBhM3QweUR0ZjZKUVJj?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79EBD5CDC72E46458E96E2D6C172C9D2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d16babd-9712-4ad3-1e78-08da87dda7db
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2022 03:38:49.9868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sut8fXbijRSQzuXJnGNOTfJyFWZegr+gB9ohUjvLY9J8ijdJLYCivtM+Dn7XxteMqccLju8BbsP7cWpCUfSWRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIyLTA4LTI3IGF0IDA5OjM5ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFNhdCwgMjcgQXVnIDIwMjIsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBGcmksIDIw
MjItMDgtMjYgYXQgMTA6NTkgLTA0MDAsIEJlbmphbWluIENvZGRpbmd0b24gd3JvdGU6DQo+ID4g
PiBPbiAxNiBNYXkgMjAyMiwgYXQgMjE6MzYsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+
ID4gU28gdW50aWwgeW91IGhhdmUgYSBkaWZmZXJlbnQgc29sdXRpb24gdGhhdCBkb2Vzbid0IGlt
cGFjdCB0aGUNCj4gPiA+ID4gY2xpZW50J3MNCj4gPiA+ID4gYWJpbGl0eSB0byBjYWNoZSBwZXJt
aXNzaW9ucywgdGhlbiB0aGUgYW5zd2VyIGlzIGdvaW5nIHRvIGJlDQo+ID4gPiA+ICJubyINCj4g
PiA+ID4gdG8NCj4gPiA+ID4gdGhlc2UgcGF0Y2hlcy4NCj4gPiA+IA0KPiA+ID4gSGkgVHJvbmQs
DQo+ID4gPiANCj4gPiA+IFdlIGhhdmUgc29tZSBmb2xrcyBuZWdhdGl2ZWx5IGltcGFjdGVkIGJ5
IHRoaXMgaXNzdWUgYXMgd2VsbC7CoA0KPiA+ID4gQXJlDQo+ID4gPiB5b3UNCj4gPiA+IHdpbGxp
bmcgdG8gY29uc2lkZXIgdGhpcyB2aWEgYSBtb3VudCBvcHRpb24/DQo+ID4gPiANCj4gPiA+IEJl
bg0KPiA+ID4gDQo+ID4gDQo+ID4gSSBkb24ndCBzZWUgaG93IHRoYXQgYW5zd2VycyBteSBjb25j
ZXJuLg0KPiANCj4gQ291bGQgeW91IHBsZWFzZSBzcGVsbCBvdXQgYWdhaW4gd2hhdCB5b3VyIGNv
bmNlcm5zIGFyZT/CoCBJIHN0aWxsDQo+IGRvbid0DQo+IHVuZGVyc3RhbmQuIA0KPiBUaGUgb25s
eSBwZXJmb3JtYW5jZSBpbXBhY3QgaXMgd2hlbiBhIHBlcm1pc3Npb24gdGVzdCBmYWlscy7CoCBJ
biB3aGF0DQo+IGNpcmN1bXN0YW5jZSBpcyBwZXJtaXNzaW9uIGZhaWx1cmUgZXhwZWN0ZWQgb24g
YSBmYXN0LXBhdGg/DQo+IA0KDQpZb3UncmUgdHJlYXRpbmcgdGhlIHByb2JsZW0gYXMgaWYgaXQg
d2VyZSBhIHRpbWVvdXQgaXNzdWUsIHdoZW4gY2xlYXJseQ0KaXQgaGFzIG5vdGhpbmcgYXQgYWxs
IHRvIGRvIHdpdGggdGltZW91dHMuIFRoZXJlIGlzIG5vIHByb2JsZW0gb2YNCidncm91cCBtZW1i
ZXJzaGlwIGNoYW5nZXMgb24gYSByZWd1bGFyIGJhc2lzJyB0byBiZSBzb2x2ZWQuDQoNClRoZSBw
cm9ibGVtIHRvIGJlIHNvbHZlZCBpcyB0aGF0IG9uIHRoZSB2ZXJ5IHJhcmUgb2NjYXNpb24gd2hl
biBhIGdyb3VwDQptZW1iZXJzaGlwIGRvZXMgY2hhbmdlLCB0aGVuIHRoZSBzZXJ2ZXIgYW5kIHRo
ZSBjbGllbnQgbWF5IHVwZGF0ZSB0aGVpcg0KdmlldyBvZiB0aGF0IG1lbWJlcnNoaXAgYXQgY29t
cGxldGVseSBkaWZmZXJlbnQgdGltZXMuIEluIHRoZQ0KcGFydGljdWxhciBjYXNlIHdoZW4gdGhl
IGNsaWVudCB1cGRhdGVzIGl0cyB2aWV3IG9mIHRoZSBncm91cA0KbWVtYmVyc2hpcCBiZWZvcmUg
dGhlIHNlcnZlciBkb2VzLCB0aGVuIHRoZSBhY2Nlc3MgY2FjaGUgaXMgcG9sbHV0ZWQsDQphbmQg
dGhlcmUgaXMgbm8gcmVtZWR5Lg0KDQpTbyBteSBjb25jZXJucyBhcmUgYXJvdW5kIHRoZSBtaXNt
YXRjaCBvZiBwcm9ibGVtIGFuZCBzb2x1dGlvbi4gSSBzZWUNCm11bHRpcGxlIGlzc3Vlcy4NCg0K
ICAgMS4gWW91ciB0aW1lb3V0cyBhcmUgcGVyIGlub2RlLiBUaGF0IG1lYW5zIHRoYXQgaWYgaW5v
ZGUgQSBzZWVzIHRoZQ0KICAgICAgcHJvYmxlbSBiZWluZyBzb2x2ZWQsIHRoZW4gdGhlcmUgaXMg
bm8gZ3VhcmFudGVlIHRoYXQgaW5vZGUgQg0KICAgICAgc2VlcyB0aGUgc2FtZSBwcm9ibGVtIGFz
IGJlaW5nIHNvbHZlZCAoYW5kIHRoZSBjb252ZXJzZSBpcyB0cnVlDQogICAgICBhcyB3ZWxsKS4N
CiAgIDIuIFRoZXJlIGlzIG5vIHF1aWNrIG9uLXRoZS1zcG90IHNvbHV0aW9uLiBJZiB5b3VyIGFk
bWluIHVwZGF0ZXMgdGhlDQogICAgICBncm91cCBtZW1iZXJzaGlwLCB0aGVuIHlvdSBhcmUgb25s
eSBndWFyYW50ZWVkIHRoYXQgdGhlIGNsaWVudA0KICAgICAgYW5kIHNlcnZlciBhcmUgaW4gc3lu
YyBvbmNlIHRoZSBzZXJ2ZXIgaGFzIHBpY2tlZCB1cCB0aGUgc29sdXRpb24NCiAgICAgIChob3dl
dmVyIHlvdSBhcnJhbmdlIHRoYXQpLCBhbmQgdGhlIGNsaWVudCBjYWNoZSBoYXMgZXhwaXJlZC4N
CiAgICAgIElPVzogeW91ciBvbmx5IHNvbHV0aW9uIGlzIHRvIHdhaXQgMSBjbGllbnQgY2FjaGUg
ZXhwaXJhdGlvbg0KICAgICAgcGVyaW9kIGFmdGVyIHRoZSBzZXJ2ZXIgaXMga25vd24gdG8gYmUg
Zml4ZWQgKG9yIHRvIHJlYm9vdCB0aGUNCiAgICAgIGNsaWVudCkuDQogICAzLiBUaGVyZSBpcyBu
byBzb2x1dGlvbiBhdCBhbGwgZm9yIHRoZSBwb3NpdGl2ZSBjYWNoZSBjYXNlLiBJZiB5b3VyDQog
ICAgICBzeXNhZG1pbiBpcyB0cnlpbmcgdG8gcmV2b2tlIGFuIGFjY2VzcyBkdWUgdG8gYSBncm91
cCBtZW1iZXJzaGlwDQogICAgICBjaGFuZ2UsIHRoZWlyIG9ubHkgc29sdXRpb24gaXMgdG8gcmVi
b290IHRoZSBjbGllbnQuDQogICA0LiBZb3UgYXJlIHR5aW5nIHRoZSBhY2Nlc3MgY2FjaGUgdGlt
ZW91dCB0byB0aGUgY29tcGxldGVseQ0KICAgICAgdW5yZWxhdGVkICdhY3JlZ21pbicgYW5kICdh
Y2Rpcm1pbicgdmFsdWVzLiBOb3Qgb25seSBkb2VzIHRoYXQNCiAgICAgIG1lYW4gdGhhdCB0aGUg
ZGVmYXVsdCB2YWx1ZXMgZm9yIHJlZ3VsYXIgZmlsZXMgYXJlIGV4dHJlbWVseQ0KICAgICAgc21h
bGwgKDMgc2Vjb25kcyksIG1lYW5pbmcgdGhhdCB3ZSBoYXZlIHRvIHJlZnJlc2ggZXh0cmVtZWx5
DQogICAgICBvZnRlbi4gSG93ZXZlciBpdCBhbHNvIG1lYW5zIHRoYXQgeW91IGhhdmUgdG8gZXhw
bGFpbiB3aHkNCiAgICAgIGRpcmVjdG9yaWVzIGJlaGF2ZSBkaWZmZXJlbnRseSAobG9uZ2VyIGRl
ZmF1bHQgdGltZW91dHMpIGRlc3BpdGUNCiAgICAgIHRoZSBmYWN0IHRoYXQgdGhlIGdyb3VwIG1l
bWJlcnNoaXAgY2hhbmdlZCBhdCBleGFjdGx5IHRoZSBzYW1lDQogICAgICB0aW1lIGZvciBib3Ro
IHR5cGVzIG9mIG9iamVjdC4NCiAgICAgICAgIDEuIEJvbnVzIHBvaW50cyBmb3IgZXhwbGFpbmlu
ZyB3aHkgb3VyIGRlZmF1bHQgdmFsdWVzIGFyZSBkZXNpZ25lZA0KICAgICAgICAgICAgZm9yIGEg
Z3JvdXAgbWVtYmVyc2hpcCB0aGF0IGNoYW5nZXMgZXZlcnkgMyBzZWNvbmRzLg0KICAgNS4gJ25v
YWMnIHN1ZGRlbmx5IG5vdyB0dXJucyBvZmYgYWNjZXNzIGNhY2hpbmcsIGJ1dCBvbmx5IGZvcg0K
ICAgICAgbmVnYXRpdmUgY2FjaGVkIHZhbHVlcy4NCg0KDQotLSANClRyb25kIE15a2xlYnVzdCBM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQo=
