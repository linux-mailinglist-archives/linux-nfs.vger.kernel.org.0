Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8A85ABF91
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Sep 2022 17:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiICPtu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Sep 2022 11:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiICPts (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Sep 2022 11:49:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54972183A0
        for <linux-nfs@vger.kernel.org>; Sat,  3 Sep 2022 08:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO99mCNpe+FIMFCi3cNzxxmHGhHrT2MzNV1gOpthgEH/qXXLSxNCwumWdu05UTwI9EUpOF+jMq87u1n58y6/FreMIfA8Homv5SSz+yv64qU9eZjV3FIqy20oO//Gizf5NPh7m5AoWjksUbmghPLDCHKIUz5EAiZgFrhE3Pe2Y6oCgzQs0wNEZJ0ICy6FRXY27N7HkzJka8p+Vu2xGD3+Z1N0kXZ/Wkh/lAh67ZA9pnJUqA0FKXClkIEmvMVu9wc28Zu9mb/lICHOBCRmoUKkNul3FrCZqy4Cl0n594aLeihDy3tKn61xlVHFgvDsw/oScj6a8TqASY6tNLdnF/SDkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dzLwIue4W2n5c+bb9VrBUQOB4U81dE9VPYCMsrd1dI=;
 b=ATPrjPhZ6cjS4cgbJ/hID0ZIkH/0o5UdFTV2HHXqcGUr8QbT29JuwpU5TWWcl1E/EvQ4WpbXgzzXk/hOji5GRI2Ek4/Lzjrf4TNCb9Pu0jQ31milIsIhcQTD9kJD+c2Oj7fm9uPATba41wLCliASOdLFaSyQ31Gjj7XF6KP9GWgnyrZsWN8eKL8JdqQk4TlSLVMZ9fD5aGZhWGDLzKZoy6d6k/BMpr064Ott+FxmW7FvEe+7RoFTvbs96PNxVRErm5Fn9DXglXBHDX69LfJvqBA8DTj0BajUIn3DllhUq0B9LmVfJ4CJZwORXAUeXprjJ/Ppst4O0egdpQ7WfFazKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dzLwIue4W2n5c+bb9VrBUQOB4U81dE9VPYCMsrd1dI=;
 b=FUOatKnk/olf5ipLrkclzkwFnghC/F1WTcQLuYu6gTYaRFA3Kmsy03i5NUxtdql3RwZyO07BX3JWJi9GwH1syikn8yJwT3ZK0nUdXldjMlsA3fqEhirHrf9YzwhQAkJ4L7l0b9Am9ZrF6vMP/nmQwAz666evmkQHZaBSwaXOg0Q=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3737.namprd13.prod.outlook.com (2603:10b6:5:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.6; Sat, 3 Sep
 2022 15:49:43 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.007; Sat, 3 Sep 2022
 15:49:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Thread-Topic: [PATCH 0/2] NFS: limit use of ACCESS cache for negative
 responses
Thread-Index: AQHYWqCwBzhUO4xFMUm2kRfU0oEzLK0iTkgAgAAEXYCAAAWigIAABBEAgAACsoCAAAKEgIAAAmYAgAAD74CAn5ulgIAADKiAgACEsICAAELlgIAC38AAgAD0fYCAB5X6AIAAYkyA
Date:   Sat, 3 Sep 2022 15:49:43 +0000
Message-ID: <1cfb40103f3f539973587f4565af79d5dc439096.camel@hammerspace.com>
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
 <22601f2b7ced45d3b5f44951970f79c22490aced.camel@kernel.org>
         <166219906850.28768.1525969921769808093@noble.neil.brown.name>
In-Reply-To: <166219906850.28768.1525969921769808093@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB3737:EE_
x-ms-office365-filtering-correlation-id: 51231aba-b510-4d31-4d80-08da8dc3eb3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tLJJ1CrP8PJOciZCroVPC5A6uLJF+hhfLhudIyaM0kbnvBrrv5yHVZlCIkGCfD37inDuHdNWRrr7DW6dTQkNBZZFVd9Fp4NBoXBOu949o6n/gpIvdVh1VlVmXt2RmSPFOB3SfGSbd7b5zQg12q8j6/feCgkSDgBshsAMJNvYrhuT1RizaNaALKXvN4f9Bn34mlChB+SEA75mCXWkZ+wJ4M6wX5R0gwohnq8zvOKWUpaWSEi3qqkDy/lV48cl/eh62a/E8craF0fL3uNPoAlFeiDrfqwzXnwf/Yp2dtmk6uhPYj2JGL1w2dOjtmV876I3rRGjSjoLTA4VUs7tkhsKpF9dx6vVVbiT9qss8XAaZ6W3cXlycdXntjXq0NZ8HajyziOz8L5YLegUvE1NBOSgugVWO8l8f/vqekU3ISBAhWP0mgcL+9NF7qWRO22JvHO21WIGX93p7eh0lbU2arMuBonYzbNJNfqKvfMDu8OlMYgw8vOc8Z4TVz9+sRjFflS0rJZ1IyCQnwGJY+6ouJNH80t2AzBniVYNIs2Us1KJ98xKvb4ijc+uXjeUaHWR7HMiD2tl/LwbugVDtml6HadJiRfr8JStoSr+d70i6qAksDKQ8mKoLlFfbgSxUIq9hQTl1dwQBo4xFi1B/E56yN2QinD40QwJ+qPItcKntuTkhzsazOFP86eCx/Q26GyLhbfOOvIPt4emGHaBx1hCew1VJQ/90yV0dClb7EdmQ1oEj3JEJMgakRdaerh5aGGNb/o8CQ1SrGkvaBwyYjVIG5CX3WsLtkHBxNOjTpUMlHiZLmjtuYttkfj40w+DStlE2iAl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(346002)(376002)(136003)(366004)(396003)(5660300002)(83380400001)(41300700001)(36756003)(38070700005)(2906002)(8936002)(4326008)(2616005)(8676002)(186003)(478600001)(26005)(6506007)(6512007)(38100700002)(64756008)(122000001)(66946007)(66556008)(66446008)(76116006)(86362001)(66476007)(110136005)(316002)(54906003)(6486002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVhPa3JLNkJCeVMwaytEUWdGeDgxRWNYcFcxM3pkOFVjN3FtWUwrM3YxRWxy?=
 =?utf-8?B?Ymh6WTErWkdxWmxoQ3hiOTlkUUJhRUZ0eWFSY0FqYW5Iajg0UXhsUHdXKzZO?=
 =?utf-8?B?RnNIQWRlUzZSUldVREQ0OVJRYzZqQ2VWcDZGRWVWem1vMjE2M2JZNFZ1bkZz?=
 =?utf-8?B?TkQ3ZThUMVJ2VFpEMUVlTUpaWllxVXJZSGpmcnFkRXEyeEhnOUJkT2FXMHA4?=
 =?utf-8?B?bERNZHNtcjNpK3QxdjJyL2tnL1pmeTV5YVNpMmRVZGYvbU4wanpnK0hQb2Q5?=
 =?utf-8?B?ckJZNjN4OHBzMFFDa1UrbTBCM1hocjVLTXBIQjRCTWl0ZmFOeDg2RXd0ZlRr?=
 =?utf-8?B?Q0Z5N2VtYnp4ajlXbmtVZzdrSkN1YXpQUHV0Ym5JZ28xR2J3anJSL0NkN1ky?=
 =?utf-8?B?SzNGUkRlNkx4VXRHOG5uQUVwUk9SOWNlZXFpT2RQa1NSZWlsNHdNaXRVVW81?=
 =?utf-8?B?WHJOZFRVUmNaTGxDcXY5RWl5S1dkK3dYamp6ZHpyNldjMDg0aUlqMjNXQXU2?=
 =?utf-8?B?Yk1HWldwT084V0hiSVpOOExNL2x1T2cwa2JiMWRJSjJ0Kys5bDM0MkhjbDhR?=
 =?utf-8?B?dmxLNVdmM1hSbGk0NGVMOS8vY3YzYWNLL0FJRWdKWVhrWldhQUdUQzNzU245?=
 =?utf-8?B?OVBDQmJCbGFDdGpHK2NKaThxcmxlTFAxSkhyTDZOMXUzWGFTL1J0WGEvRzVu?=
 =?utf-8?B?cFVJQlYzWVh4bEMvMjRnZVJDV2VvTzZJMVlyYk90eDJmdTQ2WXlveDRMUXhy?=
 =?utf-8?B?dE1PemRwa2tXQ1JXWXFkMWhWMVJLSGc4RVF1N1lUVWJ5YlVCV2ZsazNrR3Jq?=
 =?utf-8?B?bHNkOHZvdzVQMkI3Zy9pN0lxRlJLZ1FnbjJBekNhTWwrNzFZbUkvL292bW8r?=
 =?utf-8?B?TC9ReVA2YWhuLzFpM0U1RDhhc3VLelh2UlEyZGgySS9hc2x1emorZG1YWGpB?=
 =?utf-8?B?WGxQci9aU3E0ekVtamJ5SFUwWDgxMDlxc21PRlg4VW1rV0Z4N0lOZmk1QWwx?=
 =?utf-8?B?OXNRekEwTzc4eC9EVk84cllxblNXcWR4MnUzUU1WQzlpZmJucS9iQmNtVXdJ?=
 =?utf-8?B?S2FDOUEwdngyYStEQ1lETjQrWnV1ODJEd2FrSytILzEyQlZQU2l0RzljZkFt?=
 =?utf-8?B?em1NQ2wzVG9BVWpvdWtrRHJEWGhPQStIdllURzZRMWMrWGtDZmpWcVVLZWRh?=
 =?utf-8?B?UDN5YlBwRHFaYzVsNEt1WkJhTHltTVRxUjlRTDc0QldGVmN1ZTVmUmZLTVFi?=
 =?utf-8?B?REhieFF2RndTSHBCZXJjSDBVVSszdk5UWDQvSENpV2JwSW8xNEU0UURZNmJX?=
 =?utf-8?B?bVIxTWdVUWlRbFVJWm5iY29QOUVndVJRa1hxd3lWZTg5bzgvNUluSTdONlp6?=
 =?utf-8?B?T28xRi9nT1BRaHlLQzRoN3V5Z1Z6WjM3WjI1NVJVRk1VMjQrbWZDVjZKbzRV?=
 =?utf-8?B?LzZKVWloMzU3WkxRNzU5RVlYVW9qdzYvUmFwNTVUUC8xVFJObUllSGFGZUJK?=
 =?utf-8?B?V2g2dm5QemY4UDV0T1R5NjlyVzhDOEh5VEV3YUwvRmdZeGx0TzJVbmU3Q1Vp?=
 =?utf-8?B?VHZUcitvL3lkUUZOK2JLeERnTlc4TlA0MHZpSE5hMFplbDJDWXNweGE5YUEv?=
 =?utf-8?B?Y2dwWVJOVGVwS1lvOTV6RjhyeGNOSnRhc202NCsrV2RFSU5wc0cxdyt6Mnl2?=
 =?utf-8?B?dDJMTVJQWTN0dUN3N2tUblYzaGJCYTI3R0RieVBOMnRVVmZ3T3RGbnBqNDF3?=
 =?utf-8?B?czRiZ0ZFQTl2ejdhaEhEelFnZU5Vc0JMVlA3T2RGcEIyYzZHWUt6MU40cXlO?=
 =?utf-8?B?MHdNd0RsNjh0VVpYekhnZklhVFJKK0dUSXBTZU9YRG9WZWNFZUhvek13VXVC?=
 =?utf-8?B?Y29EOWJuUEpOaGRzTnZCUk5nVVdmYitMNE1vNnYyUjBZdXFqc3JRL3BPMlQ1?=
 =?utf-8?B?SUttendrZG1UVDdIQWxHNld3LzFtWnUxVWQ1Wi9rWW5Ed2Y3ODRSLzdSRWtv?=
 =?utf-8?B?cXQwZFlNa0l2cDh5U3lpY1orTmY1NHVFMmJBMDFyYnhaOEZFVDhKemc2QTRl?=
 =?utf-8?B?NHk5bW1HNzJsZW42K3FwdHRkYUJBTlJqMGJkR29ZMEFiWlZDZkhVWXlpZWZX?=
 =?utf-8?B?dng4MkJoMnU3ait4MEQ4TXdUWGV1M2UyZkwwREtWaWR2MlBjUFBUMjQ2T0Jj?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18F79878F32DD24BA6B9862E6A71A27C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3737
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIyLTA5LTAzIGF0IDE5OjU3ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IFRo
ZSB3aG9sZSBwb2ludCBvZiB0aGUgTkZTIEFDQ0VTUyByZXF1ZXN0IGlzIHRoYXQgdGhlIGNsaWVu
dCBjYW5ub3QNCj4ga25vdw0KPiBob3cgdG8gaW50ZXJwcmV0IGFueSBhY2Nlc3MgY29udHJvbHMg
dGhhdCB0aGUgc2VydmVyIG1pZ2h0IGhhdmUgaW4NCj4gcGxhY2UuwqAgV2hvIGtub3dzLCB0aGV5
IG1pZ2h0IGV2ZW4gYmUgdGltZSBiYXNlZCBhY2Nlc3MgY29udHJvbHMNCj4gKGdhbWVzIGNhbiBv
bmx5IGJlIHBsYXllZCBvbiB0aGUgd2Vla2VuZCkuwqAgT2ssIHRoYXQgaXMgYSBiaXQNCj4gZXh0
cmVtZSwNCj4gYnV0IHRoZSBwcmluY2lwbGUgcmVtYWlucy4NCj4gDQo+ICpZb3UqIG1pZ2h0ICJr
bm93IiB0aGF0IHRoZXJlIGFyZSB0d28gcGllY2VzIChpbiB0aGlzIHNwZWNpZmljDQo+IGV4YW1w
bGUpDQo+IGFuZCB0aGF0IG9uZSBkb2Vzbid0IGRpcmVjdGx5IHJlbGF0ZSB0byB0aGUgaW5vZGVz
LCBidXQgdGhlIE5GUw0KPiBjbGllbnQNCj4gZG9lc24ndCBrbm93IHRoYXQuwqAgVGhlIE5GUyBj
bGllbnQgb25seSBrbm93cyB0aGF0IGl0IGNhbiByZXF1ZXN0DQo+IEFDQ0VTUw0KPiBpbmZvcm1h
dGlvbiBmb3IgYSBmaWxlaGFuZGxlIGluIHRoZSBjb250ZXh0IG9mIGEgY3JlZGVudGlhbC7CoCBU
aGUNCj4gTGludXgNCj4gTkZTIGNsaWVudCB0aGVuIGNhY2hlcyB0aGF0IGFnYWluc3QgdGhlIGlu
b2RlIChzbyBpdCBpcyBhbGwgc29tZWhvdw0KPiByZWxhdGVkIHRvIHRoZSBpbm9kZSkuDQo+IA0K
PiBUaGUgc3BlYyBkb2Vzbid0IGdpdmUgdGhlIGNsaWVudCBwZXJtaXNzaW9uIHRvIGNhY2hlZCB0
aGVzZSBkZXRhaWxzDQo+IEFUDQo+IEFMTC7CoCBDYWNoaW5nIHBvc2l0aXZlIHJlc3VsdHMgbWFr
ZXMgcGVyZmVjdCBzZW5zZSBmcm9tIGEgcGVyZm9ybWFuY2UNCj4gcGVyc3BlY3RpdmUgYW5kIGlz
IGVhc2lseSBkZWZlbnNpYmxlLsKgIENhY2hpbmcgbmVnYXRpdmUgcmVzdWx0cyAuLi7CoA0KPiBu
b3QNCj4gc28gbXVjaC4NCg0KT2YgY291cnNlIHRoZSBzcGVjIGFsbG93cyB0aGUgY2xpZW50IHRv
IGNhY2hlIHBlcm1pc3Npb25zIGluIGJvdGggTkZTdjMNCmFuZCBORlN2NC4gT3RoZXJ3aXNlIHRo
ZXJlIHdvdWxkIGJlIG5vIHdheSB3ZSBjb3VsZCBjYWNoZSBvYmplY3RzIGF0DQphbGwuIEVuYWJs
aW5nIHRoZSBjbGllbnQgdG8gZ2F0ZSBhY2Nlc3MgdG8gY2FjaGVkIGRhdGEgc3VjaCBhcw0KZGly
ZWN0b3J5IGNvbnRlbnRzLCBhbmQgY2FjaGVkIGRhdGEgd2l0aG91dCB0cm91YmxpbmcgdGhlIHNl
cnZlciBpcyB0aGUNCndob2xlIHBvaW50IG9mIHRoZSBBQ0NFU1Mgb3BlcmF0aW9uLiBXaXRob3V0
IHRoYXQgYWJpbGl0eSwgd2Ugd291bGQNCmhhdmUgdG8gYXNrIHRoZSBzZXJ2ZXIgZXZlcnkgdGlt
ZSBhIHVzZXIgdHJpZWQgdG8gJ2NkJyBpbnRvIGENCmRpcmVjdG9yeSwgY2FsbGVkIG9wZW4oKSwg
Y2FsbGVkIGdldGRlbnRzKCksIGNhbGxlZCByZWFkKCksIGNhbGxlZA0Kd3JpdGUoKSwgLi4uIFdp
dGhvdXQgdGhhdCBhYmlsaXR5LCBORlN2NCBkZWxlZ2F0aW9ucyB3b3VsZCBiZQ0KcG9pbnRsZXNz
LCBiZWNhdXNlIHdlJ2QgaGF2ZSB0byBnbyBhbmQgYXNrIHRoZSBzZXJ2ZXIgZm9yIGFsbCB0aGVz
ZQ0Kb3BlcmF0aW9ucy4NCkkga25vdyB0aGUgc3BlYyBpcyBsaXR0ZXJlZCB3aXRoIG1lYWx5IG1v
dXRoZWQgIlRoZSBzZXJ2ZXIgY2FuIHJldm9rZQ0KYWNjZXNzIHBlcm1pc3Npb24gYXQgYW55IHRp
bWUiIHN0YXRlbWVudHMgaW4gdmFyaW91cyBzcG90cywgYnV0IHRoYXQNCmxvb2tzIG1vcmUgbGlr
ZSBzb21ldGhpbmcgdG8gcGxhY2F0ZSBhIHJldmlldyBieSB0aGUgSUJNIGxlZ2FsIHRlYW0NCih5
ZXMsIGl0IGhhcHBlbmVkKSByYXRoZXIgdGhhbiBhIGJhc2ljIGFzc3VtcHRpb24gdGhhdCB3YXMg
ZW5naW5lZXJlZA0KaW50byB0aGUgcHJvdG9jb2wuIFRoZSBwcm90b2NvbCBzaW1wbHkgY2Fubm90
IHdvcmsgYXMgZGVzY3JpYmVkIGluDQpSRkM1NjYxIGFuZCBSRkM3NTMwIHdpdGhvdXQgdGhlIGFz
c3VtcHRpb24gdGhhdCB5b3UgY2FuIGNhY2hlLg0KDQpUaGUgb3RoZXIgcG9pbnQgaXMgdGhhdCBh
Y2Nlc3MgY2FjaGUgY2hhbmdlcyBkdWUgdG8gQUQvTERBUC9OSVMgZ3JvdXANCm1lbWJlcnNoaXAg
dXBkYXRlcyBoYXBwZW4gb25jZSBpbiBhIGJsdWUgbW9vbiwgYW5kIHdoZW4gdGhleSBkbywgdGhl
eQ0KYWZmZWN0IF9BTExfIGNhY2hlZCB2YWx1ZXMgZm9yIHRoYXQgdXNlciwgYW5kIG5vdCBqdXN0
IG9uZSBhdCBhIHRpbWUuDQpXaGVuIHRob3NlIHRoaW5ncyBkbyBoYXBwZW4sIHRoZSB1c2VyIG5v
cm1hbGx5IGV4cGVjdHMgdG8gaGF2ZSB0byBsb2cNCm91dCBhbmQgdGhlbiBsb2cgYmFjayBpbiBz
byB0aGF0IHRoZSBuZXcgZ3JvdXAgbWVtYmVyc2hpcHMgYXJlDQpyZWZsZWN0ZWQgaW4gdGhhdCB1
c2VyJ3MgY3JlZCAoYXMgcGVyIFBPU0lYIHByZXNjcmliZWQgYmVoYXZpb3VyKS4gVGhhdA0Kd2ls
bCBjYXVzZSB0aGUgTkZTIGNsaWVudCB0byBzZW5kIG5ldyBBQ0NFU1MgY2FsbHMgdG8gdGhlIHNl
cnZlciwNCmJlY2F1c2UgdGhlIG5ldyBjcmVkIHdpbGwgbm90IGJlIGZvdW5kIGluIHRoZSBleGlz
dGluZyBhY2Nlc3MgY2FjaGUuDQpUaGUgb25seSBjYXNlIHdoZXJlIHRoaXMgYXNzdW1wdGlvbiBm
YWlscywgaXMgaWYgdGhlIHNlcnZlciBpcw0KaW1wbGVtZW50aW5nIHRoZSAnLS1tYW5hZ2UtZ2lk
cycgYmVoYXZpb3VyLCBhbmQgY2FjaGVzIGl0cw0KcmVwcmVzZW50YXRpb24gb2YgdGhlIHVzZXIn
cyBjcmVkcyBwYXN0IHRoZSB0aW1lIHdoZW4gdGhlIHVzZXIgbG9nZ2VkDQpvdXQgYW5kIGxvZ2dl
ZCBpbiBhZ2Fpbi4NClNvIHRoaXMgaXMgbGl0ZXJhbGx5IGEgMSBpbiBhIGJpbGxpb24gY2hhbmNl
IHByb2JsZW0gdGhhdCB5b3UncmUgYXNraW5nDQp1cyB0byBmaXguIE9wdGltaXNpbmcgZm9yIHRo
YXQgY2FzZSBieSBhZGRpbmcgaW4gYSB0aW1lb3V0IHRoYXQgYWZmZWN0cw0KYWxsIGNhY2hlZCBh
Y2Nlc3MgdmFsdWUgaXMganVzdCBub3QgaW4gdGhlIGNhcmRzLg0KDQpJJ3ZlIGFscmVhZHkgc2Vu
dCBvdXQgYSBwYXRjaCB0aGF0IGZvcmNlcyByZWFsaWdubWVudCBvZiB0aGUgTkZTIGNsaWVudA0K
YmVoYXZpb3VyIHdpdGggdGhhdCBvZiBQT1NJWCBieSByZXF1aXJpbmcgdGhlIGNsaWVudCB0byBy
ZWNoZWNrIGNhY2hlZA0KYWNjZXNzIHZhbHVlcyBmb3IgYW4gZXhpc3RpbmcgY3JlZGVudGlhbCBh
ZnRlciBhIG5ldyBsb2dpbiwgYnV0IGRvZXMNCm5vdCBhZGQgYW55IGZ1cnRoZXIgaW1wZWRpbWVu
dHMgdG8gdGhlIGFjY2VzcyBjYWNoZS4gV2h5IGlzIHRoYXQNCmFwcHJvYWNoIG5vdCBzdWZmaWNp
ZW50Pw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
