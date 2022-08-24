Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6095559FF7C
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Aug 2022 18:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbiHXQ1K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Aug 2022 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiHXQ1J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Aug 2022 12:27:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2130.outbound.protection.outlook.com [40.107.220.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F29F94127
        for <linux-nfs@vger.kernel.org>; Wed, 24 Aug 2022 09:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fj30pQ2RplzigIuFNNse6vCKPvqE2Di4mMIs3c8GzPqB45rsawYsqhfn1LMRzX6sExFTw9WkUPNYUKQ72qMiz+hAt+Pw0wGhb5RBVHc95Np5U5D8GNDLKyVFc+Slnia4DFn0kMaoWBIEH/2NOwdQImdpvNwecBKEzHwEHkjT6us6N+ri1jik9+K+xHXng00Fa5D7BHn0q91LYBRTDfiUQmnpI1Sr5dCG/B46E4D3kVRTZrFKNaAotuduMwh3a53QgDyrl7RZD7rJqSuZyVw+XmUssjbWsTOW16gCDm7pjmkOZDtbmor4pe7lZS8ZUnFwROis2sNjOG3o5B5Ze1IjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QitPiGEkEDlXQ1zKXanj8LrRC78KVKEOxcR2rVQdVPc=;
 b=GA4qf7xKFbpHVYM4x2qscab2a/AZiCU9o7LtaP1VqwHEv6VGIVlxVkDhY/OXhYppOGHb4cD978d0DzhRpJMti9/SsDIc+PCjbNalS8vEr4c4KeL0CQjeJokf/w84VEWuWY63GyoBhSWrpmq4YXuECElo7DciWO4RJIlDWcF0kjGbzA0N0BEHYr+XdJmnewz2wJ+2t4LisCcFRALXPV6Fi0Mdv1+Zw6zwPBugTVLwPTWYIRbqucEhKMrVVd469tQYi4chAIJV4HYmT/iqiSX9QvocV4ZMctbMoLxO6oVEOUUAza7tH1rT48RWe+wCwzoSHKjkQ1HAovpbKRzbq04arw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QitPiGEkEDlXQ1zKXanj8LrRC78KVKEOxcR2rVQdVPc=;
 b=cX2kE06i9cJyfe9K+b/ptD/0sPSnYJhwF296Vnx6H55Do7f+5rrKe58fiicjelgQwa82xMe+DOk0c5BVeU0mX5N+dvmi+XC8Aw1MiA5PXp2aGKJ8xVYzujKjAnwxw4rxjXkzX0jecY78RQ4wcfQR0YR3HnKNfRQRM6S99GMysAo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM5PR13MB1035.namprd13.prod.outlook.com (2603:10b6:3:79::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 16:27:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5566.014; Wed, 24 Aug 2022
 16:27:04 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "daire.byrne@gmail.com" <daire.byrne@gmail.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "benmaynard@google.com" <benmaynard@google.com>
Subject: Re: [RFC PATCH 2/3] NFS: Add support for netfs in struct nfs_inode
 and Kconfig
Thread-Topic: [RFC PATCH 2/3] NFS: Add support for netfs in struct nfs_inode
 and Kconfig
Thread-Index: AQHYt5zQc0jiP02yL0Kjw6guU1m2RK29/pOAgAAFTACAAAEnAIAAErsAgAAlsoA=
Date:   Wed, 24 Aug 2022 16:27:04 +0000
Message-ID: <5ab3188affa7e56e68a4f66a42f45d7086c1da23.camel@hammerspace.com>
References: <da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com>
         <20220824093501.384755-1-dwysocha@redhat.com>
         <20220824093501.384755-3-dwysocha@redhat.com>
         <429ecc819fcffe63d60dbb2b72f9022d2a21ddd8.camel@hammerspace.com>
         <CALF+zOknvMZyufSUD-g9Z9Y5RfwE-vUFT+CF0kxqbcpR=yJPJw@mail.gmail.com>
         <216681.1661350326@warthog.procyon.org.uk>
In-Reply-To: <216681.1661350326@warthog.procyon.org.uk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e887ad54-5dce-4071-214b-08da85ed7b43
x-ms-traffictypediagnostic: DM5PR13MB1035:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w8u2GmFV/CtED2on0G6dbzV62cwpI05Kgev2s0qA5D40PbRYpAi84VXjFlXadfyUqYJ4HpXEixjjkLz1LKsqLli/im3taFJdxNnl8X6ruLLaWnSbtT/esXtOqAWKPQYi1PmdkOaVHQlm+ZKaH3K0xy7qehopWRcxkouUv2ciF8OKa6g0Lr82IF3A/XPtoS9UdoRvIHiBolr4MZckFvXwjZIpfeXBwa29EBK/GHeR3YHpHgRhWSfkPQpqGq45S2pX82RQ6Up3rvYqFHx3cDMULSCAAnko/5wqPce+OtQAn6W//Nib/dFjOm9am/mj13NGwr4jF5NvdzqIl6gR6q7gAmpbIc/M0AwZ7r1dym1kPhb4poyfePlEX7MNmINYjLbfsRblirwvyAqQ7ysB2LiCxWUlwDyJHrNzgJbBOTPHEH1C/zjkjEyYcIWT7Trk9IPyAJB0HBIYH+fvXb1Gm0uL5ulrj/FrY1kDH4SS/ooW+PBpd5seYFxKSNCRsLin9i8dbdQs8ratxpAriD27g6dru61yCtFLnfSTHS3DUQEWcY2yr3RyvXNCZwYbq1V6S43SRxX0D34WUkDAtQCFWHOhGXkUvClPfcLGmkdB5YMZtJkCfvGQjgOvRjYpL4DtF8cEOoVGlPwUdUL6vMCi3n2/QUGDgsAvxLjHVUKqgDgqD4tUo32O0/o0y/vl7mVXGKqFhpFEoaZO981DYFvAaNFxW3A4YiVJRtYbHz+jS6B7dydDDNbRcYls6wGn7bej35Ko2ZRrewrmjovhoUjTjB3R8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(39840400004)(376002)(346002)(41300700001)(2906002)(38100700002)(86362001)(38070700005)(6486002)(478600001)(2616005)(186003)(6512007)(83380400001)(26005)(4326008)(71200400001)(6506007)(5660300002)(122000001)(8936002)(36756003)(66476007)(66946007)(6916009)(66446008)(66556008)(64756008)(8676002)(76116006)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU5wZXR1NTZiMlJQSUJTUjlWLzZCTXFhWENvTXFEd21BNld4Sm9yZERMdjVM?=
 =?utf-8?B?aUhkL0RQMnUzNnBXT0dZVFNHM01vUnZIT0RVMng4TWNlZ3BLSEJOczNYL1Ez?=
 =?utf-8?B?c2dheVJuUDFRdm5iSk9QUHNOdVoreXlERXRtQS9wVVpyQlYzWTQySmg5NkRX?=
 =?utf-8?B?SjZnd2szYk1vMXBKbDI1ZjNxK1pIbVh4UncrczRqREpxNy8xTUJPYjNPakNj?=
 =?utf-8?B?S2RBQXIxK05JckkvNWsxdDZYdHBuZThySHUrZzkycUc2SGxMcGx6ZzhEZ0hP?=
 =?utf-8?B?RzNHL3ZyVXdSakpZVkxZNGFqakQrRmpaczhnK29VcTFxdlIwd3BFWEtRVHVN?=
 =?utf-8?B?UWd3TjhsVWxjNW5iM2wwRmtsaW9GdzJlRWE1c3k0Q2dlaUNmemNwNHhqWmpJ?=
 =?utf-8?B?c05wemNUOFV3RWovUEk0V1k0RDByMGVpUDVjb200MmNWMSt1Wkc4RHRzNm4v?=
 =?utf-8?B?UEg2RGVYUmV4UVFTVUs1STBYZGFXL2o3QXZHQWxRSE85SEM1MWdhZk5RdHdl?=
 =?utf-8?B?b25OS2xyOEdXbkduaFFxMFRSZWVDVm9FZ1NOeXU2NjhSR29oZUY1T2tESElz?=
 =?utf-8?B?ek9KM0xXdTlsdXBUU0VZQ2dmL1JmemYybWg5MTFPcXJwa2Zpb2VjVEh3dWhr?=
 =?utf-8?B?US9yc1AyTVZNY2FYY3crYXFIS2QwWVYyelF5czlkejdKYWZuYm9XN0pzVjg3?=
 =?utf-8?B?Ujg3SytWM211c0JPcnhJMGNSaHloejVTK2xSSEMzWXRwNUZjalE5Y0RSRlhy?=
 =?utf-8?B?VFFRTUFHODg4K2ttUXVwYjFXTitjdFpVczROemVaSURhalNWbHg0SEVRei9v?=
 =?utf-8?B?YVErbHZFVU5YSVJiYjJvRnBWMk9Tdlg0Rm1FNEcwT3d3Q1UvSXl3RHFvNEhv?=
 =?utf-8?B?bHpEQVRrUlczRCtOSDZLcXhjaWY0VG5wajEvSi82ekdJclZVMy9CRGpHMHdF?=
 =?utf-8?B?TDdtN0VRNzlQdFY3UUxhTVpRK1ZhVnlZL3VIODQ0TndsWlYyMi9mM0JaaTh4?=
 =?utf-8?B?Nk9xSU1MQTZwbWt0QXM1TEZBWityM1JSb1QrZjlJdSsrYzQ2R0h0VTB5cUpZ?=
 =?utf-8?B?aUh5dmZmRWp0cllybVBFdzIvbWpZNkVNbnY1VkV4ZmFBandRRWpZZ2xYZEZK?=
 =?utf-8?B?SHA4U251My8zazd5MlpUQVh3YVFjMkIwQm01MXFsVmRCdlA3R2ZhOG1XYjF5?=
 =?utf-8?B?UFlqZSsxZURka1hYbzJReXVCTG0xRE10THcrbWZoTzQxc0RPMVZRWGJSNWx1?=
 =?utf-8?B?Rm9ZU0FSSkgveXdlY1VTUVp5cE91eGgwZFRNMER0dlhVc2tBM3BnbWFnTTlZ?=
 =?utf-8?B?NDlvTDNVc3NETzA1SHozc2ordkExNkRoOGtsQUhXeGY5VDNOSDNYTnZnNEJw?=
 =?utf-8?B?cjRvd3BCSkloUTZBVzFsN3BRSitjYnBGNHNuVnVRbTIwT3B6K1A3QVRHTGFu?=
 =?utf-8?B?YU5OSU5QVit3Zmsvem94TnI3ZVJMRWtDK1B2ZnBkdW5HZnRWMWFUVVdyWnRG?=
 =?utf-8?B?a3VwSFFmeE1Qc1VoVXRIbjJGUnlsRHpCZnRDQVE0TGpFdUlGcG5KNlhRa2RM?=
 =?utf-8?B?bCswUVI2d3NrVXhMMTR4TFNQdFU3YnY3cnlOZUk1a0pDTXR6cTlKQ2NUYi9o?=
 =?utf-8?B?YzMvTnNBcmxPY25ZR1haMWFEOEdVa0xVTUdHOWZCZmgySk9XQWRweHFIbFZ4?=
 =?utf-8?B?ZEhTY3VkVG82dXZwN1JBa1RySUNyRHpLbEdaSXhPaTRTS0ZBS1duTVpxeUkx?=
 =?utf-8?B?SkZzZDhMOHlDSlNwcFBTYk9oR25iOG1QNUQyNHRBTzNVU2poKzR3S2lHcDlC?=
 =?utf-8?B?WDBEWGUxUmZVY0RtSUVDc0d5UTl3V0dPMi9SNnhjVmhhSVZ3cWo0QnNPQTQz?=
 =?utf-8?B?VzJjQUhKNEp4ajY5SnhqZzJpdzdhQm9QajdSL3ZIWVIyYTdGTjEvMXUrVnRj?=
 =?utf-8?B?KzYvZlA0bCt5VXNUdnNDQWdvbWIxY0NhaGtZditnVnBWM2szRmdnWksrV0tP?=
 =?utf-8?B?VFlzVXJ2Ry9YUGU4aUY0OVRoMDZMMUQ5Vmt2cS9wV0FFbldWc2VERUVUclVq?=
 =?utf-8?B?SndEQkV2QzA2Sk10K3liV2ZldnRueCs5ZlRmREdZM21sbTVVam8yZktDeEZv?=
 =?utf-8?B?dUZGbEJTTi8yTllhRzQybEl2K2toQUNMUEJ1STJJNSt3OVNZcXZpenJxZnhQ?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E576AAC17F45E459BE099D236F00D1A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e887ad54-5dce-4071-214b-08da85ed7b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 16:27:04.7617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VdxG8bGjNFcYUI1xCu3lQkJgrganEKOzYj1pGFeSXpdEjtnZDjYBPEMcAcR1BThjmsg7LeWKReb8BzF7/nNtNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTI0IGF0IDE1OjEyICswMTAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gDQo+
ID4gQXMgbG9uZyBhcyBpdCBpcyBhbiBvcHQtaW4gZmVhdHVyZSwgSSdtIE9LLiBJIGRvbid0IHdh
bnQgdG8gaGF2ZSB0bw0KPiA+IGNvbXBpbGUgaXQgaW4gYnkgZGVmYXVsdC4NCj4gPiBBIGNhY2hl
ZnMgc2hvdWxkIG5ldmVyIGJlY29tZSBhIG1hbmRhdG9yeSBmZWF0dXJlIG9mIG5ldHdvcmtlZA0K
PiA+IGZpbGVzeXN0ZW1zLg0KPiANCj4gbmV0ZnNsaWIgaXMgaW50ZW5kZWQgdG8gYmUgdXNlZCBl
dmVuIGlmIGZzYWNoZSBpcyBub3QgZW5hYmxlZC7CoCBJdCBpcw0KPiBpbnRlbmRlZA0KPiB0byBt
YWtlIHRoZSB1bmRlcmx5aW5nIG5ldHdvcmsgZmlsZXN5c3RlbSBtYWludGFpbmVyJ3MgbGlmZSBl
YXNpZXINCj4gYnk6DQo+IA0KPiDCoC0gTW92aW5nIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBhbGwg
dGhlIFZNIG9wcyBmcm9tIHRoZSBuZXR3b3JrDQo+IGZpbGVzeXN0ZW1zIGFzDQo+IMKgwqAgbXVj
aCBhcyBwb3NzaWJsZSBpbnRvIG9uZSBwbGFjZS7CoCBUaGUgbmV0d29yayBmaWxlc3lzdGVtIHRo
ZW4ganVzdA0KPiBoYXMgdG8NCj4gwqDCoCBwcm92aWRlIGEgcmVhZCBvcCBhbmQgYSB3cml0ZSBv
cC4NCj4gDQo+IMKgLSBNYWtpbmcgaXQgc3VjaCB0aGF0IHRoZSBmaWxlc3lzdGVtIGRvZXNuJ3Qg
aGF2ZSB0byBkZWFsIHdpdGggdGhlDQo+IGRpZmZlcmVuY2UNCj4gwqDCoCBiZXR3ZWVuIERJTyBh
bmQgYnVmZmVyZWQgSS9PDQo+IA0KPiDCoC0gSGFuZGxpbmcgVk0gZmVhdHVyZXMgb24gYmVoYWxm
IG9mIGFsbCBmaWxlc3lzdGVtcy7CoCBUaGlzIGdpdmVzIHRoZQ0KPiBWTSBmb2xrDQo+IMKgwqAg
b25lIHBsYWNlIHRvIGNoYW5nZSBpbnN0ZWFkIG9mIDUrLsKgIG1wYWdlIGFuZCBpb21hcCBhcmUg
c2ltaWxhcg0KPiB0aGluZ3MgYnV0DQo+IMKgwqAgZm9yIGJsb2NrZGV2IGZpbGVzeXN0ZW1zLg0K
PiANCj4gwqAtIFByb3ZpZGluZyBmZWF0dXJlcyB0byB0aG9zZSBmaWxlc3lzdGVtcyB0aGF0IGNh
biBzdXBwb3J0IHRoZW0sDQo+IGVnLjoNCj4gDQo+IMKgwqAgLSBmc2NyeXB0DQo+IMKgwqAgLSBj
b21wcmVzc2lvbg0KPiDCoMKgIC0gYm91bmNlIGJ1ZmZlcmluZw0KPiDCoMKgIC0gbG9jYWwgY2Fj
aGluZw0KPiDCoMKgIC0gZGlzY29ubmVjdGVkIG9wZXJhdGlvbg0KPiANCj4gDQo+IEN1cnJlbnRs
eSBuZnMgaW50ZXJhY3RzIHdpdGggZnNjYWNoZSBvbiBhIHBhZ2UtYnktcGFnZSBiYXNpcywgYnV0
DQo+IHRoaXMgbmVlZHMNCj4gdG8gY2hhbmdlOg0KPiANCj4gwqAoMSkgTXVsdGlwYWdlIGZvbGlv
cyBhcmUgbm93IGEgdGhpbmcuwqAgWW91IG5lZWQgdG8gcm9sbCBmb2xpb3Mgb3V0DQo+IGludG8g
bmZzDQo+IMKgwqDCoMKgIGlmIHlvdSdyZSBnb2luZyB0byB0YWtlIGFkdmFudGFnZSBvZiB0aGlz
LsKgIEFsc28sIHlvdSBtYXkgaGF2ZQ0KPiBub3RpY2VkDQo+IMKgwqDCoMKgIHRoYXQgYWxsIHRo
ZSBWTSBpbnRlcmZhY2VzIGFyZSBiZWluZyByZWNhc3QgaW4gdGVybXMgb2YgZm9saW9zLg0KDQpS
aWdodCBub3csIEkgc2VlIGxpbWl0ZWQgdmFsdWUgaW4gYWRkaW5nIG11bHRpcGFnZSBmb2xpb3Mg
dG8gTkZTLg0KDQpXaGlsZSBiYXNpYyBORlN2NCBkb2VzIGFsbG93IHlvdSB0byBwcmV0ZW5kIHRo
ZXJlIGlzIGEgZnVuZGFtZW50YWwNCnVuZGVybHlpbmcgYmxvY2sgc2l6ZSwgcE5GUyBoYXMgY2hh
bmdlZCBhbGwgdGhhdCwgYW5kIHdlIGhhdmUgaGFkIHRvDQplbmdpbmVlciBzdXBwb3J0IGZvciBk
ZXRlcm1pbmluZyB0aGUgSS9PIGJsb2NrIHNpemUgb24gdGhlIGZseSwgYW5kDQpidWlsZGluZyB0
aGUgUlBDIHJlcXVlc3RzIGFjY29yZGluZ2x5LiBDbGllbnQgc2lkZSBtaXJyb3JpbmcganVzdCBh
ZGRzDQp0byB0aGUgZnVuLg0KDQpBcyBJIHNlZSBpdCwgdGhlIG9ubHkgdmFsdWUgdGhhdCBtdWx0
aXBhZ2UgZm9saW9zIG1pZ2h0IGJyaW5nIHRvIE5GUw0Kd291bGQgYmUgc21hbGxlciBwYWdlIGNh
Y2hlIG1hbmFnZW1lbnQgb3ZlcmhlYWQgd2hlbiBkZWFsaW5nIHdpdGggbGFyZ2UNCmZpbGVzLg0K
DQo+IA0KPiDCoCgyKSBJIG5lZWQgdG8gZml4IHRoZSBjYWNoZSBzbyB0aGF0IGl0IG5vIGxvbmdl
ciB1c2VzIHRoZSBiYWNraW5nDQo+IMKgwqDCoMKgIGZpbGVzeXN0ZW0ncyBtZXRhZGF0YSB0byB0
cmFjayBjb250ZW50LsKgIFRvIG1ha2UgdGhpcyB1c2UgbGVzcw0KPiBkaXNrc3BhY2UsDQo+IMKg
wqDCoMKgIEkgd2FudCB0byBpbmNyZWFzZSB0aGUgY2FjaGUgYmxvY2sgc2l6ZSB0bywgc2F5LCAy
NTZLIG9yIDJNLg0KPiANCj4gwqDCoMKgwqAgVGhpcyBtZWFucyB0aGF0IHRoZSBjYWNoZSBuZWVk
cyB0byBoYXZlIGEgc2F5IGluIGhvdyBiaWcgYSByZWFkDQo+IHRoZQ0KPiDCoMKgwqDCoCBuZXR3
b3JrIGZpbGVzeXN0ZW0gZG9lcyAtIGFuZCBhbHNvIHRoYXQgYSBzaW5nbGUgY2FjaGUgcmVxdWVz
dA0KPiBtaWdodCBuZWVkDQo+IMKgwqDCoMKgIHRvIGJlIHN0aXRjaGVkIHRvZ2V0aGVyIGZyb20g
bXVsdGlwbGUgcmVhZCBvcHMuDQo+IA0KPiDCoCgzKSBNb3JlIHBhZ2VjYWNoZSBjaGFuZ2VzIGFy
ZSBsdXJraW5nIGluIHRoZSBmdXR1cmUsIHBvc3NpYmx5DQo+IGluY2x1ZGluZw0KPiDCoMKgwqDC
oCBnZXR0aW5nIHJpZCBvZiB0aGUgY29uY2VwdCBvZiBwYWdlcyBlbnRpcmVseSBmcm9tIHRoZSBw
YWdlY2FjaGUuDQo+IA0KPiBUaGVyZSBhcmUgdXNlcnMgb2YgbmZzICsgZnNjYWNoZSBhbmQgd2Un
ZCBsaWtlIHRvIGNvbnRpbnVlIHRvIHN1cHBvcnQNCj4gdGhlbSBhcw0KPiBiZXN0IGFzIHBvc3Np
YmxlIGJ1dCB0aGUgY3VycmVudCBjb2RlIG5vdGljYWJseSBkZWdyYWRlcyBwZXJmb3JtYW5jZQ0K
PiBoZXJlLg0KPiANCj4gVW5mb3J0dW5hdGVseSwgSSdtIGFsc28gZ29pbmcgdG8gbmVlZCB0byBk
cm9wIHRoZSBmYWxsYmFjayBpbnRlcmZhY2UNCj4gd2hpY2ggbmZzDQo+IGN1cnJlbnRseSB1c2Vz
IGluIHRoZSBuZXh0IGNvdXBsZSB2ZXJzaW9ucywgd2UgaGF2ZSB0byBhdCBsZWFzdCBnZXQNCj4g
dGhlDQo+IGZzY2FjaGUgZW5hYmxlZCBjb252ZXJzaW9uIGRvbmUuDQo+IA0KPiBJJ3ZlIGJlZW4g
ZGVhbGluZyB3aXRoIHRoZSBWTSwgOXAsIGNlcGggYW5kIGNpZnMgcGVvcGxlIG92ZXIgdGhlDQo+
IGRpcmVjdGlvbg0KPiB0aGF0IG5ldGZzbGliIG1pZ2h0IG5lZWQgdG8gZ28gaW4sIGJ1dCBmb3Ig
bmZzLCBpdCdzIHR5cGljYWxseSBiZWVuIGENCj4gZmxhdA0KPiAibm8iLsKgIEkgd291bGQgbGlr
ZSB0byB3b3JrIG91dCBob3cgdG8gbWFrZSBuZXRmc2xpYiB3b3JrIGZvciBuZnMNCj4gYWxzbywg
aWYNCj4geW91J3JlIHdpbGxpbmcgdG8gZGlzY3VzcyBpdC4NCj4gDQo+IEkgd291bGQgYmUgb3Bl
biB0byBoYXZpbmcgYSBsb29rIGF0IGltcG9ydGluZyBuZnMgcGFnZSBoYW5kbGluZyBpbnRvDQo+
IG5ldGZzbGliDQo+IGFuZCB3b3JraW5nIGZyb20gdGhhdCAtIGJ1dCBpdCBzdGlsbCBuZWVkcyB0
byBkZWFsIHdpdGggKDEpIGFuZCAoMikNCj4gYWJvdmUsIGFuZA0KPiBJIHdvdWxkIGxpa2UgdG8g
bWFrZSBpdCBwYXNzIGl0ZXJhdG9ycyBkb3duIHRvIHRoZSBsb3dlciBsYXllcnMgYXMNCj4gYnVm
ZmVyDQo+IGRlc2NyaXB0aW9ucy7CoCBJdCdzIGFsc28gdmVyeSBjb21wbGljYXRlZCBzdHVmZi4N
Cj4gDQo+IEFsc286DQo+IA0KPiDCoC0gSSd2ZSBub3RlZCB0aGUgbmZzX3BhZ2Ugc3RydWN0cyB0
aGF0IG5mcyB1c2VzIGFuZCBJJ20gbG9va2luZyBhdCBhDQo+IHdheSBvZg0KPiDCoMKgIGhhdmlu
ZyBzb21ldGhpbmcgc2ltaWxhciwgYnV0IGhlbGQgc2VwYXJhdGVseSBzbyB0aGF0IG9uZSBzdHJ1
Y3QNCj4gY2FuIHNwYW4NCj4gwqDCoCBhbmQgc3RvcmUgaW5mb3JtYXRpb24gYWJvdXQgbXVsdGlw
bGUgZm9saW9zLg0KPiANCj4gwqAtIEknbSBsb29raW5nIGF0IHB1bnRpbmcgd3JpdGUtdG8tdGhl
LWNhY2hlIHRvIHdyaXRlcGFnZXMoKSBvcg0KPiBzb21ldGhpbmcgbGlrZQ0KPiDCoMKgIHRoYXQg
c28gdGhhdCB0aGUgVk0gZm9sa3MgY2FuIHJlY2xhaW0gdGhlIFBHX3ByaXZhdGVfMiBmbGFnIGJp
dCwNCj4gc28gdGhhdA0KPiDCoMKgIHdvbid0IGJlIGF2YWlsYWJsZSB0byBuZnMgZWl0aGVyIGlu
IHRoZSBmdXR1cmUuDQo+IA0KPiDCoC0gYW9wcy0+d3JpdGVfYmVnaW4oKSBhbmQgLT53cml0ZV9l
bmQoKSBhcmUgZ29pbmcgdG8gZ28gYXdheS7CoCBJbg0KPiBuZXRmc2xpYg0KPiDCoMKgIHdoYXQg
SSdtIHRyeWluZyB0byBkbyBpcyBtYWtlIGEgIm5ldGZzX3BlcmZvcm1fd3JpdGUiIGFzIGENCj4g
cGFyYWxsZWwgdG8NCj4gwqDCoCBnZW5lcmljX3BlcmZvcm1fd3JpdGUoKS4NCj4gDQoNCldoYXQg
cHJvYmxlbXMgd291bGQgYW55IG9mIHRoaXMgc29sdmUgZm9yIE5GUz8gSSdtIHdvcnJpZWQgYWJv
dXQgdGhlDQpjb3N0IG9mIGFsbCB0aGlzIHByb3Bvc2VkwqBjb2RlIGNodXJuIGFzIHdlbGw7IGFz
IHlvdSBzYWlkICdpdCBpcw0KY29tcGxpY2F0ZWQgc3R1ZmYnLCBtYWlubHkgZm9yIHRoZSBnb29k
IHJlYXNvbiB0aGF0IHdlJ3ZlIGJlZW4NCm9wdGltaXNpbmcgYSBsb3Qgb2YgY29kZSBvdmVyIHRo
ZSBsYXN0IDI1LTMwIHllYXJzLg0KDQpIb3dldmVyIGxldCdzIHN0YXJ0IHdpdGggdGhlICJ3aHk/
IiBxdWVzdGlvbiBmaXJzdC4gV2h5IGRvIEkgbmVlZCBhbg0KZXh0cmEgbGF5ZXIgb2YgYWJzdHJh
Y3Rpb24gYmV0d2VlbiBORlMgYW5kIHRoZSBWTSwgd2hlbiBvbmUgb2YgbXkNCnByaW1hcnkgY29u
Y2VybnMgcmlnaHQgbm93IGlzIHRoYXQgdGhlIHN0YWNrIGRlcHRoIGtlZXBzIGdyb3dpbmc/DQoN
Ci0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
