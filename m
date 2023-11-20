Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D513F7F0A70
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 03:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjKTCDW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 21:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjKTCDV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 21:03:21 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FB795
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 18:03:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRBn3/FuEXIXyO8AA80bZ9xjd2dDxCQVXV0nTLhdkox3ZS7F2X+3RLkbT2uIffMIOK6jz31FkBa1LmEggIkCqjTzTzkd9JYihNeHBo1BKhVQiRmWF97DMteGhmrtlZLWkemO6M/J1TkVO/kl9F5d6BSpuckbbacrBhgNf75g4u98WRWLottVLOcrZmG0uwi46OUiFLkFaBobcyeRp6YkwmLnyJQoBeGSlpmgCdJDfrRMc+dGQy5/8qQMBvDnzON+YN6DwUxTZqXy7pwxOtXdIsw8uA7bM+Tody7hKwIzefKjFbQfZgOrnIZHPg7v8tSeYqaWjFixhcSdZUu0opPNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP3Au3HYepTYu+2Qa7eEQzWBY0SLrb2saZMvMHzuqsA=;
 b=Fds9ACLnax19S8UwO0KWKWtsJuTndqL0cfkmrp97DRAOSX7IlyIoiGL6S2PnNLPFbWnMhZywOqSE3+IT8LlhTwHFhRrj5nSVADo4SE7Q38EJ1FlxqtUnn+0R3LhfCSvk8F3jOxikZ4AQWyj3QZ3zTK2J2IfbGFrbj7PSULRcgE7bEHrD8qEo1PWWuInb61FNYcn8CNzxsvsVTpiSCwZleoXzu1Dnaop3+n9Gc7tZ9P6I6S0/rdopnzY30OXrI5lpLcAdDhXc4oi7pohQvyR+K/EB/Ftn9Fplvd/TYcaS/sjx64YzE6RdfCKta8aF08blNVCGJ9dGeGYEC3aeyVE2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP3Au3HYepTYu+2Qa7eEQzWBY0SLrb2saZMvMHzuqsA=;
 b=a8kCCaftxq2CV90Ogm/baIuTVxlCne0N7kC7CCyqEg7h3pTCFCH5/8H5RO9f3bW5an7iRnzaGulUPLK1GTbULA3aJqbjxvSsbqBdcH6BRHYaScrq/1AP+xr6rUzp4M+GRpMuzaiZ8iBhGeqWc31j+SYc2Px8bT6GgPgU9ga6JHo=
Received: from BL3PR13MB5073.namprd13.prod.outlook.com (2603:10b6:208:33c::7)
 by DM8PR13MB5109.namprd13.prod.outlook.com (2603:10b6:8:30::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 02:03:13 +0000
Received: from BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::d405:57ad:ac67:fb8c]) by BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::d405:57ad:ac67:fb8c%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 02:03:12 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "steved@redhat.com" <steved@redhat.com>
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Topic: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
Thread-Index: AQHaGSm5IPgy8h3QmEuPQMOdkvJBtLB/omOAgACnlYCAAAIBgIAAA/eAgAA+KgCAAc03gIAADjwAgAAPjIA=
Date:   Mon, 20 Nov 2023 02:03:12 +0000
Message-ID: <ec326d7e13d12c02fabf8a5fe46f2ad8bf66d368.camel@hammerspace.com>
References: <bug-218138-226593@https.bugzilla.kernel.org/>
         <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
         <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
         <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
         <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com>
         <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
         <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com>
         <9bb44f33-9900-44e1-813d-df1c60d8307c@redhat.com>
         <35ffafefb1596f4941513bc8dd51470fbee842d4.camel@hammerspace.com>
         <F12175F2-9CA3-4C6A-9089-BF5E62A196D0@oracle.com>
In-Reply-To: <F12175F2-9CA3-4C6A-9089-BF5E62A196D0@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR13MB5073:EE_|DM8PR13MB5109:EE_
x-ms-office365-filtering-correlation-id: 3da921ce-db4f-4a89-671c-08dbe96cd9f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f44p+kYruAxVP1Mad4KtOFUbRB+3CZuuKcIGib0sUTEKTOmMaO94WX9K5rFwT4nWfhC1SAeZuR6nJf8p2ELoWOXK1VNvpRWKzvSMsfZItnCoe/TuPGGSYWblZLmkSeYQ5lbaPTKs8OVYTf6hbPoUKO7cfjPnyER8ebLY75w4d+e2OC6ZS1Ab9lTR3JPFspDzxXvL3ib12isCr572SmEduouTtBRajpwj6cbod9guxourGqVITsEtD0COSd0KiFKGiI6ipNpcXb/ax4WFi6XJxU0NUViuADze1x2nVmHXD0H7ASJeBSV2Oq37dUKVO2rXiPHUZeAr0/hN0Tr1agH+3RkmMUV8Ko4NyfxAj3WMlfstJmq2wUo8zpx3WuAm521mTXwkZmkZXIwo89ngQxFndNCzgPmjmZ0hf13FPkma+ZWeaye3EN9O/GxNevO7ae1qZNBCiyWcvmlJ/t5Zi+qQ4w02qBiYAv6umPw3+60j4Pr5qQkCbDej/C1mqVJG4qazS09Kb9vflhyoI6yAFfQifOXI33znqyqbV/ZowZJ1XK9s3EVnRYITWQFGCyHPAon5uXkj6h7rLR+XHsGxjPl/Kq8Fdt7ARQb+S2ETJTELNYIjBTGKCe9PdBOFrhRgh0qYrlOIef97onKwGshikT8n6ZtRq0+Gf4wxey7MtFFDAasWijUIjaNx9Gf4/VITskJ6vlCa+FCIwA9Dp6t9o71jq4iQSp6WARsqB7IIojkBSuA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR13MB5073.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39830400003)(396003)(366004)(376002)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(36756003)(86362001)(38100700002)(38070700009)(122000001)(91956017)(66946007)(76116006)(66556008)(66476007)(6916009)(66446008)(64756008)(54906003)(8676002)(8936002)(4326008)(316002)(41300700001)(15650500001)(5660300002)(4001150100001)(2906002)(6512007)(6506007)(53546011)(2616005)(71200400001)(26005)(478600001)(6486002)(43043002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFI5NEhXWWZZZXFhTTZrdHBidTB2YzMwdHJXbkNYV0Z2bmcxM2F3L3RFc1hC?=
 =?utf-8?B?V0FBNFNxK3FwaFJpUUxzRGJpT0lSclpSbTdsTFN2MzgzTTVOQVNZSjExbmJs?=
 =?utf-8?B?eExkWG1xdDFpWTZrcVdRN0tpWStJcTdkb1lpVGlpK0FjUENxZTlJdi94R1Uy?=
 =?utf-8?B?MmRWeVZOQVB6TXBxOFJIUmYrVHBCdVkxbS9ubmFEd0ZKRWxOV3pwY25pKzAw?=
 =?utf-8?B?a2grWmJ6YkpTWkZxem84ZVFmTmNCNU1kc1YvNVp2SGpWSFpHbFNvdUVCMjc3?=
 =?utf-8?B?NTRkZnczdmFEL3ZTcm5YRjF3bWFrOHJJMTRJZWVsaCtJVXplNEx2a3c2eEJU?=
 =?utf-8?B?UGpwMVkwYjAvWlZ2MWlNWGkxNUlIM2E1QU93cWhPRzNxNlhjN3RVZEZHZWV5?=
 =?utf-8?B?Rnl2OGZQQWxBdEl0QUZ1Qy9TRU1lcG1pbVlEMEhmR3V3azBGY0xoUlhkT3B6?=
 =?utf-8?B?OVFsaE9QekFWakZpVUlkTUR6c0Y5V1NLeEJyTXNnMDRZeS9wc2REeGc1M2dj?=
 =?utf-8?B?aUl0MmFRVE1wT2ZjdlIwa05EcDE1RTgxZVlFT2Ywc0E3KzRMN0l6VEdnK0hH?=
 =?utf-8?B?VVFNbkp6cjFLcTcyQjZJMUp3VWk4Q2FEYUtqN2RJZTBXYm02MWxKODB2UWw4?=
 =?utf-8?B?QjZSajJoQW1FdlFzOUtxRFFRMTdEM1ZpcURabyt3dk1abStEWCtDdlN2RWVJ?=
 =?utf-8?B?T1VpTGVSQmZnV0lzSzUvQzdRR08yVEk4Ri9DejNDdW9Nd0l5NktEYzNqS21m?=
 =?utf-8?B?U2NMQTdXQ3RHelpVTW5oMVpwajNZcHpDVDk5Q05TTVFQa3MwaCt0ZlBuSXJr?=
 =?utf-8?B?NVo3WjB4S3NJYWFyYjJiV0NKWmE3V3hEN3BjbG5GV3pmc1ZQcUZzRHU3bG0z?=
 =?utf-8?B?dFpxSnZ2NCtnRTFZNjF6SXo2RHRsZkg2Z1JkSzBWTGE5SkhqUUpObkQ2MEo4?=
 =?utf-8?B?RW9xVnJsbjBROUNtT3lQdzkxWTFOREpKaU9tREZWZmQ5SG1BTlBLbUhOUGZ5?=
 =?utf-8?B?dGVkV0RpaGlmcGJNaE1RZmUwQjJvMVRVQW4wc1pwZnhCUTNRMG9Fc2xBVVJV?=
 =?utf-8?B?Y1B6elg0VjVRVkxxRXR4Y1I0Vk5wc3VFQUgxYTkzeDFnVGhCUWhjTS9IUzk4?=
 =?utf-8?B?SVdEV1lFNTdSU0pSY0dhakNmRlN5NzVzRExDcC9rcWhFN1k2TTBXVVhxQXlW?=
 =?utf-8?B?RERqRFhHQlpyazVlUnd6YzcyYXd2VnlWdU5QaU5wQlVtUzQzZUhreFQ1dXIy?=
 =?utf-8?B?QVRzUGZlQzVoK0FUTm1zOWUvWXRxVmEvYWRKaFRkeTZ6cTlaRTlJQmZlR21T?=
 =?utf-8?B?dzQ3OUJraUU4TjFXdDVRbzlvZ2JtbDFZd3ZWZ1piNnNPYXlrNDJjQXFjS2J2?=
 =?utf-8?B?M0l2a3NWbEFjekFDRWxKaTFXR1JMOWNCNk1iczJva0taRjJJQXpjUHFTRUI0?=
 =?utf-8?B?T3ljMkJTdmRLNHRGWVFyQmtxRXdXL24rSHkvZVAvc2U1bUZyWUpjbS82UmFK?=
 =?utf-8?B?eS9vdHdNUUQwMjdVV1ZGenVHSmJIWFpDdmtRUWRDZ21tUG01aWI2Y0FUSXRB?=
 =?utf-8?B?bVA1MFNzTGhUaDJkbDRONzZUYlc5MTk0bjVaMjNiWWl4SkROODVnVnp0MnhY?=
 =?utf-8?B?UjNmcVN6cEczSDliL2xzZTkyLzZ4MTlVRlBQTFFFckp2Vk43MnJ4dFJkWk10?=
 =?utf-8?B?dTVUV2pMN2tNQm9GS3FDdlFsMHhOaWV2bVdJclhkcmRCR01SWTB5ZGhWT0JO?=
 =?utf-8?B?dnltOFBuaXNIL2x3WVJRSDNnQlBPNkd5RzVuc2RVeGxSZEgxQTF0OGkvYTVU?=
 =?utf-8?B?ZXEzUHRyemlGL09HQUl6eTkwd1A4WlFrTWhKdFZxR0x5eGlXdUFpOHNib3NX?=
 =?utf-8?B?RTkrcHFlb0hVVTFzMTBnVlQ2d1k4WDZ3Z2tUTFJ4eExhUW9YK3g0Z09obVhk?=
 =?utf-8?B?U0wyY0hHSmNlMUhGM1ZWbTRtVVJpOVVtWmducWx3d0Uzejc2VEh2dndzelhB?=
 =?utf-8?B?Q284UXh2Q05NRUJaRzdlZUtoSlBuR09jYm1jMEtPb3MzOUhzSjhiSWp2NklK?=
 =?utf-8?B?M2dWYmtTNWR1c0xrTFdDNjBpYUpneXpwckk1Uk1nYysvRXd1TDZNYW1rWGdN?=
 =?utf-8?B?bkJ4ZTdEbHQwWWwzOGtOZnVMS29sUE5CdHQ1QWJZTnc1S3NMbEoreDRSSDhV?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6283E99EE71114695CEDFEB56B0D96C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR13MB5073.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da921ce-db4f-4a89-671c-08dbe96cd9f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 02:03:12.4745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JCTzwx8+3JYAZLqmMB/x5tYaqXNg3lujg4Fl0S+9vjNu9GWJK6Hh6MZacPjJaHIEHxLZ9isNpa4L8FGXYBgfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTExLTIwIGF0IDAxOjA3ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBOb3YgMTksIDIwMjMsIGF0IDc6MTbigK9QTSwgVHJvbmQgTXlrbGVi
dXN0DQo+ID4gPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBT
YXQsIDIwMjMtMTEtMTggYXQgMTU6NDUgLTA1MDAsIFN0ZXZlIERpY2tzb24gd3JvdGU6DQo+ID4g
PiANCj4gPiA+IA0KPiA+ID4gT24gMTEvMTgvMjMgMTI6MDMgUE0sIENodWNrIExldmVyIElJSSB3
cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+ID4gT24gTm92IDE4LCAyMDIzLCBhdCAxMTo0OeKAr0FN
LCBUcm9uZCBNeWtsZWJ1c3QNCj4gPiA+ID4gPiA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdy
b3RlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIFNhdCwgMjAyMy0xMS0xOCBhdCAxNjo0MSAr
MDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+
IE9uIE5vdiAxOCwgMjAyMywgYXQgMTo0MuKAr0FNLCBDZWRyaWMgQmxhbmNoZXINCj4gPiA+ID4g
PiA+ID4gPGNlZHJpYy5ibGFuY2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gT24gRnJpLCAxNyBOb3YgMjAyMyBhdCAwODo0MiwgQ2VkcmljIEJsYW5j
aGVyDQo+ID4gPiA+ID4gPiA+IDxjZWRyaWMuYmxhbmNoZXJAZ21haWwuY29tPiB3cm90ZToNCj4g
PiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBIb3cgb3ducyBidWd6aWxsYS5saW51eC1u
ZnMub3JnPw0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gQXBvbG9naWVzIGZvciB0aGUg
dHlwZSwgaXQgc2hvdWxkIGJlICJ3aG8iLCBub3QgImhvdyIuDQo+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiBCdXQgdGhlIHByb2JsZW0gcmVtYWlucywgSSBzdGlsbCBkaWQgbm90IGdldCBh
biBhY2NvdW50DQo+ID4gPiA+ID4gPiA+IGNyZWF0aW9uDQo+ID4gPiA+ID4gPiA+IHRva2VuDQo+
ID4gPiA+ID4gPiA+IHZpYSBlbWFpbCBmb3IgKkFOWSogb2YgbXkgZW1haWwgYWRkcmVzc2VzLiBJ
dCBhcHBlYXJzDQo+ID4gPiA+ID4gPiA+IGFjY291bnQNCj4gPiA+ID4gPiA+ID4gY3JlYXRpb24N
Cj4gPiA+ID4gPiA+ID4gaXMgYnJva2VuLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUcm9u
ZCBvd25zIGl0LiBCdXQgaGUncyBhbHJlYWR5IHNob3dlZCBtZSB0aGUgU01UUCBsb2cgZnJvbQ0K
PiA+ID4gPiA+ID4gU3VuZGF5IG5pZ2h0OiBhIHRva2VuIHdhcyBzZW50IG91dC4gSGF2ZSB5b3Ug
Y2hlY2tlZCB5b3VyDQo+ID4gPiA+ID4gPiBzcGFtIGZvbGRlcnM/DQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gSSdtIGNsb3NpbmcgaXQgZG93bi4gSXQgaGFzIGJlZW4gcnVuIGFuZCBwYWlkIGZvciBi
eSBtZSwgYnV0DQo+ID4gPiA+ID4gSQ0KPiA+ID4gPiA+IGRvbid0DQo+ID4gPiA+ID4gaGF2ZSB0
aW1lIG9yIHJlc291cmNlcyB0byBrZWVwIGRvaW5nIHNvLg0KPiA+ID4gPiANCj4gPiA+ID4gVW5k
ZXJzdG9vZCBhYm91dCBsYWNrIG9mIHJlc291cmNlcywgYnV0IGlzIHRoZXJlIG5vLW9uZSB3aG8g
Y2FuDQo+ID4gPiA+IHRha2Ugb3ZlciBmb3IgeW91LCBhdCBsZWFzdCBpbiB0aGUgc2hvcnQgdGVy
bT8gWWFua2luZyBpdCBvdXQNCj4gPiA+ID4gd2l0aG91dCB3YXJuaW5nIGlzIG5vdCBjb29sLg0K
PiA+ID4gPiANCj4gPiA+ID4gRG9lcyB0aGlzIGFubm91bmNlbWVudCBpbmNsdWRlIGdpdC5saW51
eC1uZnMub3JnDQo+ID4gPiA+IDxodHRwOi8vZ2l0LmxpbnV4LW5mcy5vcmcvPiBhbmQNCj4gPiA+
ID4gd2lraS5saW51eC1uZnMub3JnIDxodHRwOi8vd2lraS5saW51eC1uZnMub3JnLz4gYXMgd2Vs
bD8NCj4gPiA+ID4gDQo+ID4gPiA+IEFzIHRoaXMgc2l0ZSBpcyBhIGxvbmctdGltZSBjb21tdW5p
dHktdXNlZCByZXNvdXJjZSwgaXQgd291bGQNCj4gPiA+ID4gYmUgZmFpciBpZiB3ZSBjb3VsZCBj
b21lIHVwIHdpdGggYSB0cmFuc2l0aW9uIHBsYW4gaWYgaXQgdHJ1bHkNCj4gPiA+ID4gbmVlZHMg
dG8gZ28gYXdheS4NCj4gPiA+IA0KPiA+ID4gSWYgeW91IG5lZWQgcmVzb3VyY2VzIGFuZCB0aW1l
Li4uIFBsZWFzZSByZWFjaCBvdXQuLi4NCj4gPiA+IA0KPiA+ID4gVGhpcyBpcyBhIGNvbW11bml0
eS4uLiBJJ20gc3VyZSB3ZSBjYW4gZmlndXJlIHNvbWV0aGluZyBvdXQuDQo+ID4gPiBCdXQgcGxl
YXNlIHR1cm4gaXQgYmFjayBvbi4NCj4gPiA+IA0KPiA+IA0KPiA+IFNvIGZhciwgSSd2ZSBoZWFy
ZCBhIGxvdCBvZiAnd2Ugc2hvdWxkJywgYW5kIGEgbG90IG9mICd3ZSBjb3VsZCcuDQo+ID4gDQo+
ID4gV2hhdCBJIGhhdmUgeWV0IHRvIGhlYXIgYXJlIHRoZSBtYWdpYyB3b3JkcyAiSSB2b2x1bnRl
ZXIgdG8gaGVscA0KPiA+IG1haW50YWluIHRoZXNlIHNlcnZpY2VzIi4NCj4gDQo+IEkgdm9sdW50
ZWVyIHRvIGhlbHAuIEkgY2FuIGRvIGFzIG11Y2ggb3IgYXMgbGl0dGxlIGFzIHlvdSBwcmVmZXIu
DQo+IEFuZCBJIHZvbHVudGVlciB0byBsZWFkIGFuIGVmZm9ydCB0byBlaXRoZXI6DQo+IA0KPiBh
KSBmaW5kIGEgcmVwbGFjZW1lbnQgaXNzdWUgdHJhY2tpbmcgc2VydmljZSwgb3INCj4gDQo+IGIp
IGZpbmQgYSB3YXkgdG8gYXJjaGl2ZSB0aGUgY29udGVudCBvZiB0aGUgYnVnemlsbGEgaWYgd2Ug
YWdyZWUNCj4gdGhlcmUgaXMgbm8gbW9yZSBuZWVkIGZvciBhIGJ1Z3ppbGxhLmxpbnV4LW5mcy4N
Cj4gDQo+IE9yIGJvdGguDQo+IA0KPiBUaGVyZSBpcyBubyB3YXkgZm9yIHVzIHRvIGtub3cgaG93
IG11Y2ggZWZmb3J0IGl0IHRha2VzIGlmIHlvdQ0KPiBzdWZmZXIgaW4gc2lsZW5jZSwgbXkgZnJp
ZW5kLg0KDQpUaGUgcG9pbnQgaXMgdGhhdCBlbWFpbCBoYXMgZXZvbHZlZCBvdmVyIHRoZSAxOCB5
ZWFycyBzaW5jZSBJIHNldCB1cA0KdGhlIHZlcnkgZmlyc3QgbGludXgtbmZzLm9yZy4gSSBoYXZl
IG5vdCBoYWQgdGltZSB0byBrZWVwIHVwIHdpdGggdGhlDQpyZXF1aXJlbWVudHMgb2YgYWRkaW5n
IHN1cHBvcnQgZm9yIERNQVJDLCBTUEYsIGV0Yy4gd2hpY2ggaXMgd2h5DQpDZWRyaWMncyBhY2Nv
dW50IHNldHVwIGVtYWlsIGlzIHByb2JhYmx5IGluIGhpcyBzcGFtIGZvbGRlciwgYXNzdW1pbmcN
CnRoYXQgdGhlIGdtYWlsIHNlcnZlciBldmVuIGFjY2VwdGVkIGl0IGF0IGFsbC4NCg0KRnVydGhl
cm1vcmUsIGJvdGggdGhlIHdpa2ltZWRpYSBhbmQgYnVnemlsbGEgaW5zdGFuY2VzIGFyZSBmYXIg
ZnJvbQ0KcnVubmluZyB0aGUgbW9zdCByZWNlbnQgY29kZSB2ZXJzaW9ucyBhbmQgSSdtIHN1cmUg
dGhlcmUgYXJlIHBsZW50eSBvZg0Kd2VsbCBrbm93biBzZWN1cml0eSBob2xlcyBldGMgdG8gZXhw
bG9pdC4gU28gYm90aCBjb2RlIGJhc2VzIGhhdmUgYmVlbg0KbmVlZGluZyBhbiB1cGdyYWRlIGZv
ciBhIHdoaWxlIG5vdy4NCg0KRmluYWxseSwgdGhlIFZNIGl0c2VsZiBpcyBzdGlsbCBydW5uaW5n
IFJIRUwvQ2VudE9TIDcsIGFuZCBJJ2QgbGlrZSB0bw0Kc2VlIGl0IG1pZ3JhdGVkIHRvIGEgcGxh
dGZvcm0gdGhhdCBpcyBpcyBzdGlsbCBtYWludGFpbmVkLg0KDQpBbGwgdGhlc2UgdGFza3Mgd291
bGQgbmVlZCBoZWxwIGZyb20gdGhlIHBlcnNvbiAob3IgcGVvcGxlPykgd2hvDQp2b2x1bnRlZXJz
IHRvIG1haW50YWluIHRoZSBidWd6aWxsYSArIHdpa2kgc2VydmljZXMuIFNvbWUgb2YgdGhlbSB3
b3VsZA0KbmVlZCB0byBiZSAxMDAlIG93bmVkIGJ5IHRoYXQgcGVyc29uLCBhbmQgb3RoZXJzIChs
aWtlIHRoZSBwbGF0Zm9ybQ0KdXBncmFkZSkgd291bGQgbmVlZCBhIGxvdCBvZiBjb29yZGluYXRp
b24gd2l0aCBtZS4NCg0KSU9XOiBJJ20gbm90IGFkdm9jYXRpbmcgZWl0aGVyIHdheS4gSSBjYW4g
dW5kZXJzdGFuZCB3YW50aW5nIHRvIG1pZ3JhdGUNCmF3YXkgZnJvbSB0aGUgY3VycmVudCBzZXR1
cCB0byBzb21ldGhpbmcgdGhhdCBpcyBtYWludGFpbmVkIGJ5IHNvbWVvbmUNCmVsc2UuIEhvd2V2
ZXIgaWYgYW55b25lIGRvZXMgd2FudHMgdG8gdGFrZSBvbiB0aGUgam9iIG9mIGhlbHBpbmcgdG8N
Cm1haW50YWluIHRoZSBjdXJyZW50IHNldHVwLCB0aGVuIHRoZXkgbmVlZCB0byBrbm93IHRoYXQg
aXQgd2lsbCBpbnZvbHZlDQpyZWFsIHdvcmsuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K
