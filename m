Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04184E6CE5
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Mar 2022 04:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiCYDyL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 23:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiCYDyK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 23:54:10 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2120.outbound.protection.outlook.com [40.107.212.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431D8B919E
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 20:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncVNaPp2zA7Tm1F12O/wEvXIYuIfjZz27fLX/XCYF9tXCJPMjjhmhcIaOmCOC+S705iOODtOBE9k99X70ZZ8prn9zr7daw8NoXi1Mpv4gXgyMxhWvuTW5OFBWPDGPNY2mePkAyQAsuL2ZKOPxim62U+4Jqcnm8d2qESHjWnBpW+1tFVmDKnH7yA68saA2OXLigYuvnr+akzSlpKr/KhlX6eJTvdebW6HPRBYctFwwhWI0vxrIAbaXBZQvdRjfJyD4it2BdnzMwHjsFmM0sHisLY/xU2b1MOW063KIaPm12Z73H0u2H0tQSQqs8krVE5KII60XWLq7BKCltglteSDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6lxe9maF0uwFEuMbMfIxddPOwP5qxiDSbJ+fN8S4zo=;
 b=gzGA+78IeT0rzl8/LUm0S4+VffgAoFva1jUd150OhlG/ucM3IWVBTnYFGuZr7ynVcW+Fe+sXHnfnq0aZM81wXiz0RyieQPYE6fgEaW72dPpMLxUy8TJZf+w4Cp76FaAlG9Ocn7AeKme2N3oIzVsmdCG33rbj929s/4BVKwhYFFX5uxh+yOX8431oYcXZeCMZpw6zB5zMiRSKgRcWi7nmidQk4K53arPgxfrWqbE5wbVN8X5WGwhjEeWFCeHbcbxI54y1Yc03UQAz7ZcdsH5jmoyLU1oEhAD/Z5CDmDuqCleedWVkXkdgV+aNCtSrMlGY7cHF1RRap55qreevG52pCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6lxe9maF0uwFEuMbMfIxddPOwP5qxiDSbJ+fN8S4zo=;
 b=OIWYARHGofKAyAbpT293U8BdIhxgEyCVMzAwIkkQfsnHPE1agysecyeHLFkMcKUwGPHStoIEUxfZxdY0Yw9XAph/GyW2gxYyb5+qUofOo/iBlVxVqWpqvsKLMFD9SiIGcxPqTSN4pE1/84QmZZURMF3BoVhSS16d5LVtGHTAtKE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MWHPR1301MB2064.namprd13.prod.outlook.com (2603:10b6:301:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.8; Fri, 25 Mar
 2022 03:52:33 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 03:52:33 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH RFC] NFSD: Instantiate a filecache entry when creating a
 file
Thread-Topic: [PATCH RFC] NFSD: Instantiate a filecache entry when creating a
 file
Thread-Index: AQHYP8uo0WXZgCK6JkiCUMP0y6+YoKzPI6kAgAAdMwCAADcMAA==
Date:   Fri, 25 Mar 2022 03:52:32 +0000
Message-ID: <6921be3a442479678c83199f1d42600b24f2b62e.camel@hammerspace.com>
References: <164815968129.1809.12154191330176123202.stgit@manet.1015granger.net>
         <83b0b0292bda06ffa56487ea1a019ea142107fa3.camel@hammerspace.com>
         <E31250AB-636B-4AE6-8A31-69A3C26223EF@oracle.com>
In-Reply-To: <E31250AB-636B-4AE6-8A31-69A3C26223EF@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0270093-da74-48e0-ffb4-08da0e12e47f
x-ms-traffictypediagnostic: MWHPR1301MB2064:EE_
x-microsoft-antispam-prvs: <MWHPR1301MB206429829BD193CBE71A28EBB81A9@MWHPR1301MB2064.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ns8R26kktQH/1D1V5Uum+Clp6bGfjI48fAS3awspdwt9ugY0vkT/0Faov2eRiRHJEhoWJcnrIZPjlanwZ6/bGSCLXMV1/L/R9LIe7GU1wH5Dldosyib/hjf1OPDJrlIfukhV13s+IH7G2rINNUKR/Xb2l2uBrWtyYJG0DCqJ5N9Cfp/aGAc6JgkZiG4Pg0qJx3+d1nGXRQ8y8ojNDEFXacm/W85fR0Akp85OIg72yAs+YwLsMS7mQY9sJzpoIx3c6mBpUBiO1urMkkgBZ/wI4dowVNZpnTPvwZaK1SMtrc77zZv2ziXsUwI9OI1LoEW3tEbKTgM/UVvbUX/5g+i9ceQqnpustidgjrfwXe4i6zkJW2korJe0VFJg4AP0ZiKi30WWYmRMZRrxi/EpDWP1+qF/47SkZfM2mZUc1a3DV1lF0BC3gz8PCPntYk925Z94t4nBtOL9id2rLlBKKe9vW9N+0GoomWNIHTx5GK+BkqWCeuAKSB3Kz5kp9pyoNyYsqrLeSIXj5d7qcAsyCP1wQMoboBpzHAik6uQUNQfDXFTt2LvShTUJNnmQUVzMuJH63yVAXVPW+gwD73W4kHp266IyqXnWIPSGu0He9aDfRUYSpd8ndLa5BW2I/zycWWc7/73oAucSos9f6HKovXkcBMAVIR9MBwnq0eUM0rI9G9uYrA9FhQS/AtEI1VqnxQeMroCwb2YsyijExXHnE0Nh/1ZWiLIMVx4NVDlxhtYeX3rJx/yIKYCblGpwGEPhJ6lBkxN2XfwiCTHK6u9AHB1U1/v2ke7aUVmPs0UYSG+5t4vLD3rIK46t4fJnbVmytNoGKoA7ZNnfTKBFaMNeKQH50X9cPSjLQDy6niHJfCGRRsmqp9U2TlLCmYNRt1+P86XH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(5660300002)(6916009)(36756003)(2616005)(26005)(316002)(186003)(54906003)(6506007)(6512007)(76116006)(66556008)(8676002)(53546011)(38070700005)(83380400001)(64756008)(66446008)(966005)(66476007)(66946007)(86362001)(71200400001)(6486002)(508600001)(4326008)(122000001)(38100700002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzNFekRHdkhQNHA4WXRiNUNlOC9FRnZwdHJTVTU2dkNCMEw5SXVpWVhIY3dw?=
 =?utf-8?B?K294cEF4bUsxalY5UzI0YzE3N2V6Z21zNVh5UWx5ZGNLRGlKME1UWktmY2xC?=
 =?utf-8?B?RHcyZkE1QWl6TG5SVzlZV0llMFMzbStTSEsyY0J6aXFuNTd4Z3p5VnhLQXZ4?=
 =?utf-8?B?cmVWYy9tQlAxOEZPeThsVnVwWEtMZXJJbmVsOEttSVNWOUltNkk3WDJQaktR?=
 =?utf-8?B?NEx0RG9kNURFbUZRL2tEREZ1MGZXUWdvUFl4a08rQWZJZlJ4MVdaWjcrTzk5?=
 =?utf-8?B?ZGVhUkpFNmx6MFlCd2FVNWJ2NmRJWFlPNGZuZWozckRHdll4b2QzRlRJcXdK?=
 =?utf-8?B?ZUZXUStyait2Y2lybEVsL1VQeU5XZzBVRnduTE1Wa0FLUEFERXcwa1hpcHNw?=
 =?utf-8?B?eXVsK0I4aUxtckUzOEF6aE1VUkFqbklQQmpYaUNMNE9kL1NVa3l2ejFFQmxS?=
 =?utf-8?B?SXhXdE9hZnhUdTBrckMvTFF1YXBEdnhOd290YTBiRVpMSHVhQlIxeUJpb0Fs?=
 =?utf-8?B?Nmh2dG05WVhxcjFoYndrQUV0eTdTelRTTjl6d003bVlSRzAyQU9VTVJ1aWQ1?=
 =?utf-8?B?Zkd1dG93MGo1U2VlaHBZWGxEZW5mbWRRTE9CV29HWWorUkJWNHhBakZQKzBo?=
 =?utf-8?B?RVQ3byt1SEZpV2xFVmc5bnN3Qm03SnlmdmJHY1cwOUsyV2RNMm1mOHZMOXVX?=
 =?utf-8?B?Z2REVVpQeE91Nm5hUjZ0MmxuaWxwdytHRTJDWlRBdTF3UjZVem9yWG1TWXBk?=
 =?utf-8?B?Zm52RU05OE5nZm9oR2VySzhHc2JVb1hhOWJlUmlWYlhUc000RHIzNHFXc1Fw?=
 =?utf-8?B?ZjdIU3UvYmRYTUhOdnRVbmV2eDh6Uk9vT09XRThsaWhmV0RKWEZ6RkE1dEly?=
 =?utf-8?B?YlRFUlZ2M3VHMnFrTTVZRjN6MlZRRy9XVkpWcW01YjRQb0dpWXBCWVBwQkx0?=
 =?utf-8?B?Q2JFWXAyamErSzMvWExYdXhJdkJ1UEZYN254Wll5bDNEa2d5T2grVlJzQTZv?=
 =?utf-8?B?Z21zeitSNjhsT045SUZsOEYxa0hqU3hRdmZCbEhnT2dwZ2hFYnFvbkYxbjlq?=
 =?utf-8?B?azhYdGhVN2xPaXRkdXhMVTFxNDVLTDFnK2x5Y2hMWGk0R3JGUmpNNDdaRzMy?=
 =?utf-8?B?OStPTTFnSE02WlE5Q3pkUFdnNC93cUV1QVlrUU0xenpEVFBlL1ord3RUUUdW?=
 =?utf-8?B?citIckc3T1U2cFBOSnVSNlhmL1FrZXoyelFRbU5vaDJEZnZxdTVDQ3p4RmZU?=
 =?utf-8?B?ZUdUT09yTXRmNVVpZEJQejBySkN2SFN5cEJNNVZEcFBLaHBablIvRnN4OG1s?=
 =?utf-8?B?TytKTUpwRVhubFQ2NU5sYVBTNktyRUkvTW5hMU00eEQzdVBXVnNrZlJ5WGE1?=
 =?utf-8?B?cndoMmR3dGxTQTBMUnorWkZNSkFmMmc2RmNMQnM3dDJnVTFLRXR5UDZOVmNK?=
 =?utf-8?B?bzVUankxWU5EV0JoTTEvRE42SG1oVWRoTHJwVnMrMVpSY3U5dUgyZnRidlFv?=
 =?utf-8?B?cGJCRVVuQzVSSUZzUzVnbi8zOHYwazhkeWt2UmV1MG5TaDBhemE4c1JHRC80?=
 =?utf-8?B?bGd3OS9hbmE1YkVTaDhMbjVVYzJZQ2JYTWtDOEEyNEJ2dmNrcVowbHZ0azdN?=
 =?utf-8?B?N2Rmc1psc1ZTTzJpV1dHdC8vV3cvNDUrTTBHcGhlZXV4cHV0SEFnOGMyUGQ4?=
 =?utf-8?B?T3VoN0tDUGNqRGZpNmxVdlN1RllhaG84QURDUUttU2ROZ2tjY3RnSEIyYWFJ?=
 =?utf-8?B?a3ZJMWFZMUU4cnRENHdyUE85ampxbXlzUTFGdmhHZnlXNnRZL0lRVzh4RS9Y?=
 =?utf-8?B?aFQ4Rk5yN2lIWnd6c0diclU0QjArQVVHbHRwcGJ2eWNlMXJObEY1RktiOWZj?=
 =?utf-8?B?Z0xXaTEvYlZrM1lmY3hwM0lGM2xFTldRc0ZXL0hzbGhlTmh1K1VVQjh1YnFx?=
 =?utf-8?B?eUZZNklJcURtM1lmNzBuUFl5RGZzOUZBTzBxTHgzNGt5ZytKRS90aHZSVzJB?=
 =?utf-8?B?M3pHQ3F0VE9RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <084057B3B5C6BF44980E132D7CE26E9E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0270093-da74-48e0-ffb4-08da0e12e47f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 03:52:32.8235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A+0tFd+3LGdRAC1XueF/SiuxVdoc+2ff7X1Equ/lJ6RyJ4rMEWgVNujC9900CS2oe+INxEdMErdPFECzmfPOVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1301MB2064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTAzLTI1IGF0IDAwOjM1ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBNYXIgMjQsIDIwMjIsIGF0IDY6NTEgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1
LCAyMDIyLTAzLTI0IGF0IDE4OjA4IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+IFRo
ZXJlIGhhdmUgYmVlbiByZXBvcnRzIG9mIHJhY2VzIHRoYXQgY2F1c2UgTkZTdjQgT1BFTihDUkVB
VEUpIHRvDQo+ID4gPiByZXR1cm4gYW4gZXJyb3IgZXZlbiB0aG91Z2ggdGhlIHJlcXVlc3RlZCBm
aWxlIHdhcyBjcmVhdGVkLiBORlN2NA0KPiA+ID4gZG9lcyBub3Qgc2VlbSB0byBwcm92aWRlIGEg
c3RhdHVzIGNvZGUgZm9yIHRoaXMgY2FzZS4NCj4gPiA+IA0KPiA+ID4gVGhlcmUgYXJlIHBsZW50
eSBvZiB0aGluZ3MgdGhhdCBjYW4gZ28gd3JvbmcgYmV0d2VlbiB0aGUNCj4gPiA+IHZmc19jcmVh
dGUoKSBjYWxsIGluIGRvX25mc2RfY3JlYXRlKCkgYW5kIG5mczRfdmZzX2dldF9maWxlKCksDQo+
ID4gPiBidXQNCj4gPiA+IG9uZSBvZiB0aGVtIGlzIGFub3RoZXIgY2xpZW50IGxvb2tpbmcgdXAg
YW5kIG1vZGlmeWluZyB0aGUgZmlsZSdzDQo+ID4gPiBtb2RlIGJpdHMgaW4gdGhhdCB3aW5kb3cu
IElmIHRoYXQgaGFwcGVucywgdGhlIGNyZWF0b3IgbWlnaHQgbG9zZQ0KPiA+ID4gYWNjZXNzIHRv
IHRoZSBmaWxlIGJlZm9yZSBpdCBjYW4gYmUgb3BlbmVkLg0KPiA+ID4gDQo+ID4gPiBJbnN0ZWFk
IG9mIG9wZW5pbmcgdGhlIG5ld2x5IGNyZWF0ZWQgZmlsZSBpbg0KPiA+ID4gbmZzZDRfcHJvY2Vz
c19vcGVuMigpLA0KPiA+ID4gb3BlbiBpdCBhcyBzb29uIGFzIHRoZSBmaWxlIGlzIGNyZWF0ZWQs
IGFuZCBsZWF2ZSBpdCBzaXR0aW5nIGluDQo+ID4gPiB0aGUNCj4gPiA+IGZpbGUgY2FjaGUuDQo+
ID4gPiANCj4gPiA+IFRoaXMgcGF0Y2ggaXMgbm90IG9wdGltYWwsIG9mIGNvdXJzZSAtIHdlIHNo
b3VsZCByZXBsYWNlIHRoZQ0KPiA+ID4gdmZzX2NyZWF0ZSgpIGNhbGwgaW4gZG9fbmZzZF9jcmVh
dGUoKSB3aXRoIGEgY2FsbCB0aGF0IGNyZWF0ZXMNCj4gPiA+IHRoZQ0KPiA+ID4gZmlsZSBhbmQg
cmV0dXJucyBhICJzdHJ1Y3QgZmlsZSAqIiB0aGF0IGNhbiBiZSBwbGFudGVkDQo+ID4gPiBpbW1l
ZGlhdGVseQ0KPiA+ID4gaW4gbmYtPm5mX2ZpbGUuDQo+ID4gPiANCj4gPiA+IEJ1dCBmaXJzdCwg
SSB3b3VsZCBsaWtlIHRvIGhlYXIgb3BpbmlvbnMgYWJvdXQgdGhlIGFwcHJvYWNoDQo+ID4gPiBz
dWdnZXN0ZWQgYWJvdmUuDQo+ID4gPiANCj4gPiA+IEJ1Z0xpbms6IGh0dHBzOi8vYnVnemlsbGEu
bGludXgtbmZzLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MzgyDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBD
aHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gwqBm
cy9uZnNkL3Zmcy5jIHzCoMKgwqAgOSArKysrKysrKysNCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC92ZnMu
YyBiL2ZzL25mc2QvdmZzLmMNCj4gPiA+IGluZGV4IDAyYTU0NDY0NWI1Mi4uODBiNTY4ZmExMmYx
IDEwMDY0NA0KPiA+ID4gLS0tIGEvZnMvbmZzZC92ZnMuYw0KPiA+ID4gKysrIGIvZnMvbmZzZC92
ZnMuYw0KPiA+ID4gQEAgLTE0MTAsNiArMTQxMCw3IEBAIGRvX25mc2RfY3JlYXRlKHN0cnVjdCBz
dmNfcnFzdCAqcnFzdHAsDQo+ID4gPiBzdHJ1Y3QNCj4gPiA+IHN2Y19maCAqZmhwLA0KPiA+ID4g
wqDCoMKgwqDCoMKgwqAgX19iZTMywqDCoMKgwqDCoMKgwqDCoMKgIGVycjsNCj4gPiA+IMKgwqDC
oMKgwqDCoMKgIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBob3N0X2VycjsNCj4gPiA+IMKg
wqDCoMKgwqDCoMKgIF9fdTMywqDCoMKgwqDCoMKgwqDCoMKgwqAgdl9tdGltZT0wLCB2X2F0aW1l
PTA7DQo+ID4gPiArwqDCoMKgwqDCoMKgIHN0cnVjdCBuZnNkX2ZpbGUgKm5mOw0KPiA+ID4gwqAN
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgIC8qIFhYWDogU2hvdWxkbid0IHRoaXMgYmUgbmZzZXJyX2lu
dmFsPyAqLw0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgZXJyID0gbmZzZXJyX3Blcm07DQo+ID4gPiBA
QCAtMTUzNSw2ICsxNTM2LDE0IEBAIGRvX25mc2RfY3JlYXRlKHN0cnVjdCBzdmNfcnFzdCAqcnFz
dHAsDQo+ID4gPiBzdHJ1Y3QNCj4gPiA+IHN2Y19maCAqZmhwLA0KPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlhcC0+aWFfYXRpbWUudHZfbnNlYyA9IDA7DQo+ID4gPiDCoMKg
wqDCoMKgwqDCoCB9DQo+ID4gPiDCoA0KPiA+ID4gK8KgwqDCoMKgwqDCoCAvKiBBdHRlbXB0IHRv
IGluc3RhbnRpYXRlIGEgZmlsZWNhY2hlIGVudHJ5IHdoaWxlIHdlDQo+ID4gPiBzdGlsbA0KPiA+
ID4gaG9sZA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgICogdGhlIHBhcmVudCdzIGlub2RlIG11dGV4
LiAqLw0KPiA+ID4gK8KgwqDCoMKgwqDCoCBlcnIgPSBuZnNkX2ZpbGVfYWNxdWlyZShycXN0cCwg
cmVzZmhwLCBORlNEX01BWV9XUklURSwNCj4gPiA+ICZuZik7DQo+ID4gPiArwqDCoMKgwqDCoMKg
IGlmIChlcnIpDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBUaGlzIHdv
dWxkIGJlIGJhZCAqLw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBv
dXQ7DQo+ID4gPiArwqDCoMKgwqDCoMKgIG5mc2RfZmlsZV9wdXQobmYpOw0KPiA+IA0KPiA+IFdo
eSByZWx5IG9uIHRoZSBmaWxlIGNhY2hlIHRvIGNhcnJ5IHRoZSBuZnNkX2ZpbGU/IElzbid0IGl0
IG11Y2gNCj4gPiBlYXNpZXINCj4gPiBqdXN0IHRvIHBhc3MgaXQgYmFjayBkaXJlY3RseSB0byB0
aGUgY2FsbGVyPw0KPiANCj4gTXkgdGhvdWdodCB3YXMgdGhhdCB0aGUgInN0cnVjdCBmaWxlICoi
IGhhcyB0byBlbmQgdXAgaW4gdGhlDQo+IGZpbGVjYWNoZSBhbnl3YXksIGV2ZW4gaW4gdGhlIE5G
U3YzIGNhc2UuIElmIEkgZG8gdGhpcyByaWdodCwNCj4gSSBjYW4gYXZvaWQgdGhlIHN1YnNlcXVl
bnQgY2FsbCB0byBuZnNkX29wZW5fdmVyaWZpZWQoKSwgd2hpY2gNCj4gc2VlbXMgdG8gYmUgdGhl
IHNvdXJjZSBvZiB0aGUgcmFjeSBjaG1vZCBiZWhhdmlvciBJIG1lbnRpb25lZA0KPiBhYm92ZS4g
VGhhdCBtaWdodCBoZWxwIE5GU3YzIHRvbywgd2hpY2ggd291bGQgbmVlZCB0byByZWNyZWF0ZQ0K
PiB0aGUgInN0cnVjdCBmaWxlICoiIGluIG5mc2RfcmVhZCgpIG9yIG5mc2Rfd3JpdGUoKSBhbnl3
YXkuDQo+IA0KPiA+IFRoZXJlIGFyZSBvbmx5IDIgY2FsbGVycyBvZiBkb19uZnNkX2NyZWF0ZSgp
LCBzbyB5b3UnZCBoYXZlDQo+ID4gbmZzZDNfcHJvY19jcmVhdGUoKSB0aGF0IHdpbGwganVzdCBj
YWxsIG5mc2RfZmlsZV9wdXQoKSBhcyBwZXINCj4gPiBhYm92ZSwNCj4gPiB3aGVyZWFzIHRoZSBO
RlN2NCBzcGVjaWZpYyBkb19vcGVuX2xvb2t1cCgpIGNvdWxkIGp1c3Qgc3Rhc2ggaXQgaW4NCj4g
PiB0aGUNCj4gPiBzdHJ1Y3QgbmZzZDRfb3BlbiBzbyB0aGF0IGl0IGNhbiBnZXQgcGFzc2VkIGlu
dG8NCj4gPiBkb19vcGVuX3Blcm1pc3Npb24oKQ0KPiA+IGFuZCBldmVudHVhbGx5IG5mc2Q0X3By
b2Nlc3Nfb3BlbjIoKS4NCj4gDQo+IE5laXRoZXIgbmZzZDRfcHJvY2Vzc19vcGVuMigpIG9yIGRv
X29wZW5fcGVybWlzc2lvbigpIHNlZW0NCj4gZGlyZWN0bHkgaW50ZXJlc3RlZCBpbiB0aGUgbmZz
ZF9maWxlIC0tLSBpdCdzIGFsbCB1bmRlciB0aGUNCj4gY292ZXJzLCBpbiBuZnM0X2dldF92ZnNf
ZmlsZSgpLiBCdXQgeWVzLCBhICJzdHJ1Y3QgbmZzZDRfb3BlbiINCj4gaXMgcGFzc2VkIHRvIGFu
ZCB2aXNpYmxlIGluIG5mczRfZ2V0X3Zmc19maWxlKCksIGFzIGlzIHRoZQ0KPiBvcGVuLT5vcF9j
cmVhdGVkIGJvb2xlYW4uDQoNCkhhdmluZyBhIG5mc2RfZmlsZSBpbiB0aGUgZmlsZSBjYWNoZSBk
b2Vzbid0IHByZXZlbnQgYW55b25lIGZyb20NCmNoYW5naW5nIHRoZSBtb2RlLCBvd25lciBhbmQg
c2hhcmUgYWNjZXNzIGxvY2tzIG9uIHRoZSBmaWxlIGJlZm9yZSB5b3UNCmNhbiBkbyB0aGUgbmV4
dCBzZXQgb2YgcGVybWlzc2lvbnMgY2hlY2tzIGFmdGVyIGRyb3BwaW5nIGxvY2tzLCBub3INCmRv
ZXMgaXQgZXZlbiBndWFyYW50ZWUgdGhhdCB5b3Ugd2lsbCBzdGlsbCBoYXZlIGFuIG9wZW4gZGVz
Y3JpcHRvciB3aGVuDQp0aGUgY2FsbCB0byBuZnNkNF9wcm9jZXNzX29wZW4yKCkgb2NjdXJzLg0K
DQpNYWtpbmcgdGhlIGZpbGUgZGVzY3JpcHRvciBvcGVuKCkgYW5kIHNoYXJlIGxvY2sgc2V0dGlu
Z3MgYXRvbWljIHdpdGgNCnRoZSBmaWxlIGNyZWF0aW9uLCBhbmQgZW5zdXJpbmcgdGhhdCB0aGUg
cmVzdWx0aW5nIGRlc2NyaXB0b3IgaXMgcGFzc2VkDQphbG9uZyBhbGwgdGhlIHdheSB0aHJvdWdo
IHRoZSBPUEVOIHByb2Nlc3NpbmcgaXMgdGhlIG9ubHkgd2F5IHRvIGF2b2lkDQp0aGVzZSBUT0NU
T1UgcHJvYmxlbXMuIFllcywgdGhleSBhcmUgc3RpbGwgYSBwcm9ibGVtIGZvciBORlN2MywgYnV0
DQp0aGF0J3MgYSBwcm90b2NvbCBpc3N1ZSB0aGF0IE5GU3Y0IHdhcyBzdXBwb3NlZCB0byBmaXgu
DQoNCj4gDQo+IA0KPiA+ID4gKw0KPiA+ID4gwqAgc2V0X2F0dHI6DQo+ID4gPiDCoMKgwqDCoMKg
wqDCoCBlcnIgPSBuZnNkX2NyZWF0ZV9zZXRhdHRyKHJxc3RwLCByZXNmaHAsIGlhcCk7DQo+ID4g
PiDCoA0KPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiAtLSANCj4gPiBUcm9uZCBNeWtsZWJ1c3QN
Cj4gPiBMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQo+ID4gdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KPiANCj4gLS0NCj4gQ2h1Y2sgTGV2ZXINCj4gDQo+
IA0KPiANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
