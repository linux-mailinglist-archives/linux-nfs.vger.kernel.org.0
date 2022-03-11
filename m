Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656BD4D66D3
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Mar 2022 17:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbiCKQwb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Mar 2022 11:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiCKQwa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Mar 2022 11:52:30 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2131.outbound.protection.outlook.com [40.107.92.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EB71D3AE6
        for <linux-nfs@vger.kernel.org>; Fri, 11 Mar 2022 08:51:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTWxpuLm3bS2FvSFk5fsVonoGIeVp2boW1JnGR2jj47NluMZd+0mn6+gRISB1oFsE86Zjzhrz0gvgqRWbq+/wFfDN+P8jp7DuNUDX7koR5KGB/iXxeEZL/WRrZh6LBImd5pQcDRZ6eEA2QnXZo4iROlfBx8D69Wd6e/Xfmd4XTdwIKMLjfyfy1aug8a8ju2ggAGK0U1/rNKAWjODuiVslNULU7GI7r92N04lMjXZ/s9fMXWKKol9t8hzUVaaiXznYsWd5kCkvqBjI5yX3xSle2bXLZ/iMfk2bgel2JhQWil0LQHEKp4zAt3XigFOhTjf0mRctbwpvUL1iBOdN059qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtnY8E3qzvFOurhDkdrgw11qYfKSP81kEOE1PiDxb0k=;
 b=MyN199YvpYsIXDTJZlrE1dbNk5xFw/2Vf42olubE0XNA3jRr/qaMWucgrGcM5M3Qs6tXJ6bbEQXaSC0hi0hEWJXGVsQDIOr0gd2Q2cdVdkSfVj89B3nzIc6kg5U6pAeHORV5+/2wPqWVKcDekR8FqIOPaUIWg8NY3mSPyXE0gFlC1AQorAQJFHceFXrpAhMQhdri6afRNkNrK2dIQ+2L9RUA4S8msdzTP0QINF0T2d8ch+2muZpjf9IdcZh/aLedb4TNOYowzb/IJm2MEkhrpeRoGxF4XD8HoZu8buEJEkuJuVq/br8SzpbxSwzuaKhR5/f557e7aHtEm5XcLG6udA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtnY8E3qzvFOurhDkdrgw11qYfKSP81kEOE1PiDxb0k=;
 b=Ts5nxom4+Kz/1K//vOx2yu+d4kgUqSvQB5jFiinucobajaSn/QG5+kxEcLJBdmUG0pJkCuJJ0rPAFgRI4xQDFVP5/452DD7XXml0oOBDXCgXrLmCJE4cVgb52EjNgOM4NFpmtPLnb0utmW/j/osluITNOyhkKoitft7PRvDRuCk=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 DM6PR13MB2828.namprd13.prod.outlook.com (2603:10b6:5:13e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.9; Fri, 11 Mar 2022 16:51:22 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::2133:d05a:fc92:53ce]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::2133:d05a:fc92:53ce%6]) with mapi id 15.20.5061.018; Fri, 11 Mar 2022
 16:51:21 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v9 23/27] NFS: Convert readdir page cache to use a cookie
 based index
Thread-Topic: [PATCH v9 23/27] NFS: Convert readdir page cache to use a cookie
 based index
Thread-Index: AQHYLDBhnANoa08keUGsN4tf+cdAo6y3iKWAgAGkuYCAAPjQgIAAItCAgAAkrYCAAAprAA==
Date:   Fri, 11 Mar 2022 16:51:21 +0000
Message-ID: <2dad7c315248b6c31b6e2da5857d2c7eb410ff79.camel@hammerspace.com>
References: <20220227231227.9038-1-trondmy@kernel.org>
         <20220227231227.9038-2-trondmy@kernel.org>
         <20220227231227.9038-3-trondmy@kernel.org>
         <20220227231227.9038-4-trondmy@kernel.org>
         <20220227231227.9038-5-trondmy@kernel.org>
         <20220227231227.9038-6-trondmy@kernel.org>
         <20220227231227.9038-7-trondmy@kernel.org>
         <20220227231227.9038-8-trondmy@kernel.org>
         <20220227231227.9038-9-trondmy@kernel.org>
         <20220227231227.9038-10-trondmy@kernel.org>
         <20220227231227.9038-11-trondmy@kernel.org>
         <20220227231227.9038-12-trondmy@kernel.org>
         <20220227231227.9038-13-trondmy@kernel.org>
         <20220227231227.9038-14-trondmy@kernel.org>
         <20220227231227.9038-15-trondmy@kernel.org>
         <20220227231227.9038-16-trondmy@kernel.org>
         <20220227231227.9038-17-trondmy@kernel.org>
         <20220227231227.9038-18-trondmy@kernel.org>
         <20220227231227.9038-19-trondmy@kernel.org>
         <20220227231227.9038-20-trondmy@kernel.org>
         <20220227231227.9038-21-trondmy@kernel.org>
         <20220227231227.9038-22-trondmy@kernel.org>
         <20220227231227.9038-23-trondmy@kernel.org>
         <20220227231227.9038-24-trondmy@kernel.org>
         <A2AAA831-0D58-4FFB-B76C-6D6AF39607EA@redhat.com>
         <9099fead49c961a53027c8ed309a8efd2222d679.camel@hammerspace.com>
         <466F8F77-E052-4D06-A016-946FCBD9C9BF@redhat.com>
         <28acdb3ed40b0ffd4c3ec320cc239f503ae74fcc.camel@hammerspace.com>
         <FDC0812F-DD13-4D13-8F0A-08C5C533B13C@redhat.com>
In-Reply-To: <FDC0812F-DD13-4D13-8F0A-08C5C533B13C@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dd0cbc6-4bd1-4243-2a7c-08da037f5f38
x-ms-traffictypediagnostic: DM6PR13MB2828:EE_
x-microsoft-antispam-prvs: <DM6PR13MB2828D1CFA0F69D390CAE16D1B80C9@DM6PR13MB2828.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QKxWtTuJ0lbVAH1iD26BPwglmuk+2TW0bbgsP888vctxrwh91oVs1i8io9cU2sm7LcZGRpPLAy7EQBHXx9VzoOqbaipIXTEZ9yzi1Q+zL2e0mLmoxQi9MuGEbH8BmWURfnOyHStY4o9GELhSEWxl+txcNwuUW/DBPNf9WXRV8PEc9ycxFl5cGl578gwW9uR0jT8W9wkLCr4+rmwXNNBXrHw/Ij1BdMH2c3LmSPIIyhPbMfLodknixoGZP8pr9a3Taw7uJAEOyrmsPIuqF1FlFCiVuzjTbNcl/6R+1QWbVBI9cOneoVJoP9yMGIpTiO67WRxdxfWxrEc7Eud0Fy0q2Yy7Qh8x8J2Utpf52QyZIXfo4Vz8jRt3Um3d1PQqq8Nv/9DLJg6Hg/ba6BGFFV5CK0KHbg8Tp89mMiujbV1vk5RVEHBj1dP7EEyf0vc9AW4Y5u47WISgmlELuC+bs6FcdsNzK2o86Cw46h7KSG19KJlG9LhAl3kg/ppKqCBCMPkmpDjPjlk/Q+qsqhFHfVDVmJtQqUOgPB2c8VVVOOY4a71UNm2HWfKmSgIqD250lRv9G3ewOBSRpal+SnD6KwW3+JyRib77YacSaoW6tOANKXuoqtBhd9ypy33VTYOawS2LYqRFzAjnafAwEs+6IHovxLexAP8YHUgOboVaxpG1Ni5Tz+RO1TqCa/XXGOiLHiX4D48dFux04UIUC24HWiA/dQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(5660300002)(2906002)(86362001)(66946007)(64756008)(66446008)(76116006)(122000001)(91956017)(8676002)(4326008)(38100700002)(36756003)(8936002)(66556008)(66476007)(316002)(2616005)(26005)(6916009)(186003)(71200400001)(508600001)(6486002)(6512007)(6506007)(53546011)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmNYSGRPN1hIYnNmeVVJRmFrZnV0NGliQUIwZWY5UnYreDM3Zmxmd216dVZo?=
 =?utf-8?B?QXNwS1JDeWI0TGVrNXhjTEtCMnY1dkl1dFdaa0h0WUY5RW95UjNuSFZwVFJV?=
 =?utf-8?B?NGIzWHVCdENEOGc1WWJwMzgvRGh4eVFDZUNscjBQeHlDZWZiMkY2SHFSVWdG?=
 =?utf-8?B?UFB0enJsK0JVczBDeWpRNmNFQzlWM3FZOXI0UFc5R095VDZ0dExEN0dPYTRI?=
 =?utf-8?B?eVBUMmRGRTJnLzVhaTArekQ0SUwxRXBEVkZWdkpLaHBSdU40bzdjMDlMU1lm?=
 =?utf-8?B?dFc2MlYxd2dzSVN3bmFIanJjZ3VtZ3hiS3ZQV0Z5VWtuaGVPd3FkQ3lPOXgw?=
 =?utf-8?B?T2kzVW9JbSs2c0w2bGVoandtenI5QjIwbGdYSkxYUDB1SXVLc2o1cmRldmxs?=
 =?utf-8?B?MFM3d1d4a3NGVUVFRy9iOXZFVHpnelM2NXVRTTU3TCtCQ2ZwTUNyRnB1WjNM?=
 =?utf-8?B?R0ZhLzhMaUlYS1FwS0VSSm1JUmNUaC9JZ09ObXBIUGt3ZDRzS3djZ2g1bm80?=
 =?utf-8?B?T3cyNTNXaG51ZGplU3VySWw5SUVGaGEvTnRHUVFBSlYycDEwMUxWS0dSTW9G?=
 =?utf-8?B?R1BVSlNGclltdjJ5c1JWTlFsdTF1Mmd3VTJ0TkptaU1jbkIxUUc5eXRVdGdO?=
 =?utf-8?B?U2FQeVlEQk1sUmxiMFkzMVJqdWQ4Q3VsTGtNSENaVFVVbVRVWVk1Zzd6dlQ4?=
 =?utf-8?B?RlFsNWwzUWNyb3BrcHgrSk5kbEp3K2tlWkt4eWFSc2hTblh5R1Y0SEpyZTFP?=
 =?utf-8?B?TEFoL1BDRVdDUHQyQmMvWmNNeE5JdlEvQ3luVDdob1NuOWNiaUt0TlIxRGht?=
 =?utf-8?B?MGpHbnYvc3ZDMTNWQUxTVVdOL1gvU2pWeUhrUGV2alJ0allBUHQ3ckozazZQ?=
 =?utf-8?B?V1cvbE5QWFZkT3JJTDI5cTdsVk1zbzJubWVIWEphZkk3eWdGRHhGODZkc3JP?=
 =?utf-8?B?bHd2VDUwajQxY0ttZFdMYU1DTXVBb2NSWU1nVFo1QWZCU0hScmdJby9ZVmU2?=
 =?utf-8?B?ZmY4THAxZFBLcDA2WHZNM0NhdTZrUlZtU1BwcTl1VHZCbkJzWVVwL2EwVVhV?=
 =?utf-8?B?UFRpNGtjQk9YZzY3bEI3S0FPQWFUNEkyRGRGYUVkV3Y1eEUzcmR2NHRYR1Zk?=
 =?utf-8?B?L1V2U1RlOXFCV0tTeTJUc1RmN1hvYmxYNUI3YXN4Sjl4dlZjY1krVGQ5Y1Ew?=
 =?utf-8?B?bmErRUtkSVV5S2FXb3FLRFVoWUZkVjZONXVaR29CYlN4R05vZXk5Y3RLVkVP?=
 =?utf-8?B?cWZpMnYzSGgxeG5YMjhUMHg4MC9IZUxBSFpUUHk3dVpPVU4xMFlNdXdNaGpB?=
 =?utf-8?B?NURnMFRScEZrN3JQaHdROUhZMUdJVDRnSm1DZVQrMlFjMWx5NTczZkQyOVgw?=
 =?utf-8?B?dmRLa1V5VzhiYno4anVDNmxYVWd0WjhTbmRGZEdHZEdtcURnbjBkTTFNUDRG?=
 =?utf-8?B?cjFoNkJlZ09GcmtKMUFUbktIRk1hek83T1ZVRmJaKzRHTmwwVFowaDYrMCt3?=
 =?utf-8?B?VkFGT2E3anBGRmo3Z1UyV2ZGUUNEQzZiWVlBYWVkNlNsT2Zsb2NVeEZWelB2?=
 =?utf-8?B?OEtSeXBoNExUS0toUzB5d0lQQlVZZGdLOE9WOXYreXYxeHo1V3BFM2haZytP?=
 =?utf-8?B?SkFoT0E2bGVMcUpTTEN6ZW42Ny90cnBYRVorRUdseVZINDdNalROSkpuc3d5?=
 =?utf-8?B?UmppckcxZmZkWkJvOWRReFFHQ0Jkc3MvRkpQY25tYmo1TUpCZEJPNy9kYUdz?=
 =?utf-8?B?Y0FVY0djTWhjZEphNVVRSS9od0Z5Q1NQZGgvYW1sSGwzZ2ZqV3UzRFFFUnRM?=
 =?utf-8?B?UWJFUUNtOXRyWUtuNjNTVHhEbm1QcEVBanhGTXZsaXNTamRRU1FOZE9EaE1S?=
 =?utf-8?B?YlNTZElzS1VuanBUNUJtR1g2alZmZGs5Um5XbytsTEZGQ0JWSCttSTJlbkUw?=
 =?utf-8?B?QUZQWE1NeDB1Y1VrR3ZWbGQ3YUtPcVZYY3lNZ0ZKZzBxT1EzbXY3TjBxOG56?=
 =?utf-8?B?T1NDWGQ0b0NnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E627DA97296B6842A45AD9E9905DEE44@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd0cbc6-4bd1-4243-2a7c-08da037f5f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 16:51:21.8186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KawTOi3bsCTLwt6rIOuvcjfyTG6BUmkDixEyEMe2vIr6fHvyGXhb1FeS67D6FuRXW4RW5DMo85KOUqfOjYKj3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2828
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTAzLTExIGF0IDExOjE0IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxMSBNYXIgMjAyMiwgYXQgOTowMiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0K
PiANCj4gPiBPbiBGcmksIDIwMjItMDMtMTEgYXQgMDY6NTggLTA1MDAsIEJlbmphbWluIENvZGRp
bmd0b24gd3JvdGU6DQo+ID4gPiBPbiAxMCBNYXIgMjAyMiwgYXQgMTY6MDcsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiBPbiBXZWQsIDIwMjItMDMtMDkgYXQgMTU6MDEg
LTA1MDAsIEJlbmphbWluIENvZGRpbmd0b24gd3JvdGU6DQo+ID4gPiA+ID4gT24gMjcgRmViIDIw
MjIsIGF0IDE4OjEyLCB0cm9uZG15QGtlcm5lbC5vcmfCoHdyb3RlOg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tPg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJbnN0ZWFkIG9mIHVzaW5nIGEgbGlu
ZWFyIGluZGV4IHRvIGFkZHJlc3MgdGhlIHBhZ2VzLCB1c2UNCj4gPiA+ID4gPiA+IHRoZQ0KPiA+
ID4gPiA+ID4gY29va2llIG9mDQo+ID4gPiA+ID4gPiB0aGUgZmlyc3QgZW50cnksIHNpbmNlIHRo
YXQgaXMgd2hhdCB3ZSB1c2UgdG8gbWF0Y2ggdGhlDQo+ID4gPiA+ID4gPiBwYWdlDQo+ID4gPiA+
ID4gPiBhbnl3YXkuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoaXMgYWxsb3dzIHVzIHRv
IGF2b2lkIHJlLXJlYWRpbmcgdGhlIGVudGlyZSBjYWNoZSBvbiBhDQo+ID4gPiA+ID4gPiBzZWVr
ZGlyKCkNCj4gPiA+ID4gPiA+IHR5cGUNCj4gPiA+ID4gPiA+IG9mIG9wZXJhdGlvbi4gVGhlIGxh
dHRlciBpcyB2ZXJ5IGNvbW1vbiB3aGVuIHJlLWV4cG9ydGluZw0KPiA+ID4gPiA+ID4gTkZTLA0K
PiA+ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4gPiBpcyBhDQo+ID4gPiA+ID4gPiBtYWpvciBwZXJm
b3JtYW5jZSBkcmFpbi4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhlIGNoYW5nZSBkb2Vz
IGFmZmVjdCBvdXIgZHVwbGljYXRlIGNvb2tpZSBkZXRlY3Rpb24sDQo+ID4gPiA+ID4gPiBzaW5j
ZSB3ZQ0KPiA+ID4gPiA+ID4gY2FuDQo+ID4gPiA+ID4gPiBubw0KPiA+ID4gPiA+ID4gbG9uZ2Vy
IHJlbHkgb24gdGhlIHBhZ2UgaW5kZXggYXMgYSBsaW5lYXIgb2Zmc2V0IGZvcg0KPiA+ID4gPiA+
ID4gZGV0ZWN0aW5nDQo+ID4gPiA+ID4gPiB3aGV0aGVyDQo+ID4gPiA+ID4gPiB3ZSBsb29wZWQg
YmFja3dhcmRzLiBIb3dldmVyIHNpbmNlIHdlIG5vIGxvbmdlciBkbyBhIGxpbmVhcg0KPiA+ID4g
PiA+ID4gc2VhcmNoDQo+ID4gPiA+ID4gPiB0aHJvdWdoIGFsbCB0aGUgcGFnZXMgb24gZWFjaCBj
YWxsIHRvIG5mc19yZWFkZGlyKCksIHRoaXMNCj4gPiA+ID4gPiA+IGlzDQo+ID4gPiA+ID4gPiBs
ZXNzDQo+ID4gPiA+ID4gPiBvZiBhDQo+ID4gPiA+ID4gPiBjb25jZXJuIHRoYW4gaXQgd2FzIHBy
ZXZpb3VzbHkuDQo+ID4gPiA+ID4gPiBUaGUgb3RoZXIgZG93bnNpZGUgaXMgdGhhdCBpbnZhbGlk
YXRlX21hcHBpbmdfcGFnZXMoKSBubw0KPiA+ID4gPiA+ID4gbG9uZ2VyDQo+ID4gPiA+ID4gPiBj
YW4NCj4gPiA+ID4gPiA+IHVzZQ0KPiA+ID4gPiA+ID4gdGhlIHBhZ2UgaW5kZXggdG8gYXZvaWQg
Y2xlYXJpbmcgcGFnZXMgdGhhdCBoYXZlIGJlZW4gcmVhZC4NCj4gPiA+ID4gPiA+IEENCj4gPiA+
ID4gPiA+IHN1YnNlcXVlbnQNCj4gPiA+ID4gPiA+IHBhdGNoIHdpbGwgcmVzdG9yZSB0aGUgZnVu
Y3Rpb25hbGl0eSB0aGlzIHByb3ZpZGVzIHRvIHRoZQ0KPiA+ID4gPiA+ID4gJ2xzIC0NCj4gPiA+
ID4gPiA+IGwnDQo+ID4gPiA+ID4gPiBoZXVyaXN0aWMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
SSBkaWRuJ3QgcmVhbGl6ZSB0aGUgYXBwcm9hY2ggd2FzIHRvIGFsc28gaGFzaCBvdXQgdGhlDQo+
ID4gPiA+ID4gbGluZWFybHktDQo+ID4gPiA+ID4gY2FjaGVkDQo+ID4gPiA+ID4gZW50cmllcy7C
oCBJIHRob3VnaHQgd2UnZCBkbyBzb21ldGhpbmcgbGlrZSBmbGFnIHRoZSBjb250ZXh0DQo+ID4g
PiA+ID4gZm9yDQo+ID4gPiA+ID4gaGFzaGVkIHBhZ2UNCj4gPiA+ID4gPiBpbmRleGVzIGFmdGVy
IGEgc2Vla2RpciBldmVudCwgYW5kIGlmIHRoZXJlIGFyZSBjb2xsaXNpb25zDQo+ID4gPiA+ID4g
d2l0aA0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IGxpbmVhcg0KPiA+ID4gPiA+IGVudHJpZXMs
IHRoZXknbGwgZ2V0IGZpeGVkIHVwIHdoZW4gZm91bmQuDQo+ID4gPiA+IA0KPiA+ID4gPiBXaHk/
IFdoYXQncyB0aGUgcG9pbnQgb2YgdXNpbmcgMiBtb2RlbHMgd2hlcmUgMSB3aWxsIGRvPw0KPiA+
ID4gDQo+ID4gPiBJIGRvbid0IHRoaW5rIHRoZSBoYXNoZWQgbW9kZWwgaXMgcXVpdGUgYXMgc2lt
cGxlIGFuZCBlZmZpY2llbnQNCj4gPiA+IG92ZXJhbGwsIGFuZA0KPiA+ID4gbWF5IHByb2R1Y2Ug
aW1wYWN0cyB0byBhIHN5c3RlbSBiZXlvbmQgTkZTLg0KPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gRG9lc24ndCB0aGF0IG1lYW4gdGhhdCB3aXRoIHRoaXMgYXBwcm9hY2ggc2Vla2Rpcigp
IG9ubHkgaGl0cw0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IHNhbWUgcGFnZXMNCj4gPiA+ID4g
PiB3aGVuIHRoZSBlbnRyeSBvZmZzZXQgaXMgcGFnZS1hbGlnbmVkP8KgIFRoYXQncyAxIGluIDEy
NyBvZGRzLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIHBvaW50IGlzIG5vdCB0byBzdG9tcCBhbGwg
b3ZlciB0aGUgcGFnZXMgdGhhdCBjb250YWluDQo+ID4gPiA+IGFsaWduZWQNCj4gPiA+ID4gZGF0
YQ0KPiA+ID4gPiB3aGVuIHRoZSBhcHBsaWNhdGlvbiBkb2VzIGNhbGwgc2Vla2RpcigpLg0KPiA+
ID4gPiANCj4gPiA+ID4gSU9XOiB3ZSBhbHdheXMgb3B0aW1pc2UgZm9yIHRoZSBjYXNlIHdoZXJl
IHdlIGRvIGEgbGluZWFyIHJlYWQNCj4gPiA+ID4gb2YNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IGRp
cmVjdG9yeSwgYnV0IHdlIHN1cHBvcnQgcmFuZG9tIHNlZWtkaXIoKSArIHJlYWQgdG9vLg0KPiA+
ID4gDQo+ID4gPiBBbmQgdGhhdCBjb3VsZCBiZSBkb25lIGp1c3QgYnkgYnVtcGluZyB0aGUgc2Vl
a2RpciB1c2VycyB0byBzb21lDQo+ID4gPiBjb25zdGFudA0KPiA+ID4gb2Zmc2V0IChpbmRleCAy
NjIxNDQgPyksIG9yIHNvbWV0aGluZyBlbHNlIGVxdWFsbHkgZGVhZC1udXRzDQo+ID4gPiBzaW1w
bGUuwqANCj4gPiA+IFRoYXQNCj4gPiA+IGtlZXBzIHRpZ2h0bHkgY2x1c3RlcmVkIHBhZ2UgaW5k
ZXhlcywgc28gd2Fsa2luZyB0aGUgY2FjaGUgaXMNCj4gPiA+IGZhc3Rlci7CoCBUaGF0DQo+ID4g
PiByZWR1Y2VzIHRoZSAiYnVja3Nob3QiIGVmZmVjdCB0aGUgaGFzaGluZyBoYXMgb2YgZWF0aW5n
IHVwDQo+ID4gPiBwYWdlY2FjaGUNCj4gPiA+IHBhZ2VzDQo+ID4gPiB0aGV5J2xsIG5ldmVyIHVz
ZSBhZ2Fpbi7CoCBUaGF0IGRvZXNuJ3QgY2FwIG91ciBjYWNoaW5nIGFiaWxpdHkgYXQNCj4gPiA+
IDMzDQo+ID4gPiBtaWxsaW9uDQo+ID4gPiBlbnRyaWVzLg0KPiA+ID4gDQo+ID4gDQo+ID4gV2hh
dCB5b3Ugc2F5IHdvdWxkIG1ha2Ugc2Vuc2UgaWYgcmVhZGRpciBjb29raWVzIHRydWx5IHdlcmUN
Cj4gPiBvZmZzZXRzLA0KPiA+IGJ1dCBpbiBnZW5lcmFsIHRoZXkncmUgbm90LiBDb29raWVzIGFy
ZSB1bnN0cnVjdHVyZWQgZGF0YSwgYW5kDQo+ID4gc2hvdWxkDQo+ID4gYmUgdHJlYXRlZCBhcyB1
bnN0cnVjdHVyZWQgZGF0YS4NCj4gPiANCj4gPiBMZXQncyBzYXkgSSBkbyBjYWNoZSBtb3JlIHRo
YW4gMzMgbWlsbGlvbiBlbnRyaWVzIGFuZCBJIGhhdmUgdG8NCj4gPiBmaW5kIGENCj4gPiBjb29r
aWUuIEkgaGF2ZSB0byBsaW5lYXJseSByZWFkIHRocm91Z2ggYXQgbGVhc3QgMUdCIG9mIGNhY2hl
ZCBkYXRhDQo+ID4gYmVmb3JlIEkgY2FuIGdpdmUgdXAgYW5kIHN0YXJ0IGEgbmV3IHJlYWRkaXIu
IEVpdGhlciB0aGF0LCBvciBJDQo+ID4gbmVlZCB0bw0KPiA+IGhhdmUgYSBoZXVyaXN0aWMgdGhh
dCB0ZWxscyBtZSB3aGVuIHRvIHN0b3Agc2VhcmNoaW5nLCBhbmQgdGhlbg0KPiA+IGFub3RoZXIN
Cj4gPiBoZXVyaXN0aWMgdGhhdCB0ZWxscyBtZSB3aGVyZSB0byBzdG9yZSB0aGUgZGF0YSBpbiBh
IHdheSB0aGF0DQo+ID4gZG9lc24ndA0KPiA+IHRyYXNoIHRoZSBwYWdlIGNhY2hlLg0KPiA+IA0K
PiA+IFdpdGggdGhlIGhhc2hpbmcsIEkgc2VlayB0byB0aGUgcGFnZSBtYXRjaGluZyB0aGUgaGFz
aCwgYW5kIEkNCj4gPiBlaXRoZXINCj4gPiBpbW1lZGlhdGVseSBmaW5kIHdoYXQgSSBuZWVkLCBv
ciBJIGltbWVkaWF0ZWx5IGtub3cgdG8gc3RhcnQgYQ0KPiA+IHJlYWRkaXIuDQo+ID4gVGhlcmUg
aXMgbm8gbmVlZCBmb3IgYW55IGFkZGl0aW9uYWwgaGV1cmlzdGljLg0KPiANCj4gVGhlIHNjZW5h
cmlvIHdoZXJlIHdlIHdhbnQgdG8gZmluZCBhIGNvb2tpZSB3aGlsZSBub3QgZG9pbmcgYSBsaW5l
YXINCj4gcGFzcw0KPiB0aHJvdWdoIHRoZSBkaXJlY3Rvcnkgd2lsbCBiZSB0aGUgc2Vla2Rpcigp
IGNhc2UuwqAgSW4gYSBsaW5lYXIgd2FsaywNCj4gd2UgaGF2ZQ0KPiB0aGUgY2FjaGVkIHBhZ2Ug
aW5kZXggdG8gaGVscC7CoCBTbyBpbiB0aGUgc2Vla2RpciBjYXNlLCB0aGUgY2hhbmNlcw0KPiBv
Zg0KPiBoYXZpbmcgc29tZW9uZSBhbHJlYWR5IGZpbGwgYSBwYWdlIGFuZCBhbHNvIGhhdmluZyB0
aGUgY29va2llIGJlIHRoZQ0KPiAxIGluDQo+IDEyNyB0aGF0IGFyZSBwYWdlLWFsaWduZWQgKGFu
ZCBzbyBtYXRjaCBhbiBhbHJlYWR5IGNhY2hlZCBwYWdlKSBhcmUNCj4gc21hbGwsIEkNCj4gdGhp
bmsuwqAgVW5sZXNzIHlvdXIgdXNlLWNhc2Ugd2lsbCBvZnRlbiBoaXQgdGhlIGV4YWN0IHNhbWUg
b2Zmc2V0cw0KPiBvdmVyIGFuZA0KPiBvdmVyLg0KDQpGb3IgdGhlIHVzZSBjYXNlIHdoZXJlIHdl
IGFyZSByZWV4cG9ydGluZyBORlMsIGl0IGNhbiBkZWZpbml0ZWx5DQpoYXBwZW4uDQpGaXJzdGx5
LCB0aGUgY2xpZW50cyB1c3VhbGx5IGFyZSByZWFkaW5nIHRoZSByZWV4cG9ydGVkIGRpcmVjdG9y
eQ0KbGluZWFybHksIHNvIHRoZXkgd2lsbCB0ZW5kIHRvIGZvbGxvdyB0aGUgc2FtZSBjb29raWUg
cmVxdWVzdCBwYXR0ZXJucy4NClNlY29uZGx5LCB3ZSdyZSBub3QgZ29pbmcgdG8gcmVwbGF5IHRo
ZSByZWFkZGlyIGZyb20gdGhlIGR1cGxpY2F0ZQ0KcmVwbHkgY2FjaGUgaWYgdGhlIGNsaWVudCBy
ZXNlbmRzIHRoZSByZXF1ZXN0LiBTbyBldmVuIGlmIHlvdSBvbmx5IGhhdmUNCm9uZSBjbGllbnQs
IHRoZXJlIGNhbiBiZSBhIGJlbmVmaXQuDQoNCj4gDQo+IFNvIHdpdGggdGhlIGhhc2hpbmcgYW5k
IHNlZWtkaXIgY2FzZSwgSSB0aGluayB0aGF0IHRoZSBjYWNoZSB3aWxsIGJlDQo+IHByZXR0eQ0K
PiBoZWF2aWx5IGZpbGxlZCB3aXRoIHRoZSBzYW1lIGR1cGxpY2F0ZWQgZGF0YSBhdCB2YXJpb3Vz
IG9mZnNldHMgYW5kDQo+IHJhcmVseQ0KPiB1c2VmdWwuwqAgVGhhdCdzIHdoeSBJIHdvbmRlcmVk
IGlmIHlvdSdkIHRlc3RlZCB5b3VyIHVzZS1jYXNlIGZvciBpdA0KPiBhbmQgZm91bmQNCj4gaXQg
dG8gYmUgYWR2YW50YWdlb3VzLsKgIEkgdGhpbmsgd2hhdCB3ZSd2ZSBnb3QgaXMgZ29pbmcgdG8g
d29yayBmaW5lLA0KPiBidXQgSQ0KPiB3b25kZXIgaWYgeW91J3ZlIHNlZW4gaXQgdG8gd29yayB3
ZWxsLg0KPiANCj4gVGhlIG1ham9yIHBhaW4gcG9pbnQgbW9zdCBvZiBvdXIgdXNlcnMgY29tcGxh
aW4gYWJvdXQgaXMgbm90IGJlaW5nDQo+IGFibGUgdG8NCj4gcGVyZm9ybSBhIGNvbXBsZXRlIHdh
bGsgaW4gbGluZWFyIHRpbWUgd2l0aCByZXNwZWN0IHRvIHNpemUgd2l0aA0KPiBpbnZhbGlkYXRp
b25zIGF0IHBsYXkuwqAgVGhpcyBzZXJpZXMgZml4ZXMgdGhhdCwgYW5kIGlzIGEgaHVnZSBib251
cy7CoA0KPiBPdGhlcg0KPiBzbWFsbGVyIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50cyBhcmUgcGFs
ZSBpbiBjb21wYXJpc29uIGZvciB1cywgYW5kDQo+IG1pZ2h0DQo+IGp1c3QgZ2V0IHVzIGZvcmV2
ZXIgY2hhc2luZyBvbmUgb3IgdHdvIG1pbm9yIG9wdGltaXphdGlvbnMgdGhhdCBoYXZlDQo+IHRy
YWRlLW9mZnMuDQo+IA0KPiBUaGVyZSdzIGEgbG90IG9mIHZhcmlhYmxlcyBhdCBwbGF5LsKgIEZv
ciBzb21lIGNsaWVudC9zZXJ2ZXIgc2V0dXBzDQo+IChsaWtlDQo+IHNvbWUgbG93LWxhdGVuY3kg
UkRNQSksIGFuZCB2ZXJ5IGxhcmdlIGRpcmVjdG9yaWVzIGFuZCBjYWNoZSBzaXplcywNCj4gaXQg
bWlnaHQNCj4gYmUgbW9yZSBwZXJmb3JtYW50IHRvIGp1c3QgZG8gdGhlIFJFQURESVIgZXZlcnkg
dGltZSwgd2Fsa2luZyBsb2NhbA0KPiBjYWNoZXMNCj4gYmUgZGFtbmVkLg0KPiANCg0KU3VyZSwg
c28gYSBkZWRpY2F0ZWQgcmVhZGRpcnBsdXMoKSBzeXN0ZW0gY2FsbCBjb3VsZCBoZWxwIGJ5IHBy
b3ZpZGluZw0KdGhlIHNhbWUga2luZCBvZiBndWlkYW5jZSB0aGF0IHN0YXR4KCkgZG9lcyB0b2Rh
eS4NCg0KPiA+ID4gSXRzIHdlaXJkIHRvIG1lIHRoYXQgd2UncmUgZG9pbmcgZXhhY3RseSB3aGF0
IFhBcnJheSBzYXlzIG5vdCB0bw0KPiA+ID4gZG8sDQo+ID4gPiBoYXNoDQo+ID4gPiB0aGUgaW5k
ZXgsIHdoZW4gd2UgZG9uJ3QgaGF2ZSB0by4NCj4gPiA+IA0KPiA+ID4gPiA+IEl0IGFsc28gbWVh
bnMgd2UncmUgYW1wbGlmeWluZyB0aGUgcGFnZWNhY2hlJ3MgdXNlYWdlIGZvcg0KPiA+ID4gPiA+
IHNsaWdodGx5DQo+ID4gPiA+ID4gY2hhbmdpbmcNCj4gPiA+ID4gPiBkaXJlY3RvcmllcyAtIHJh
dGhlciB0aGFuIHJlLXVzaW5nIHRoZSBzYW1lIHBhZ2VzIHdlJ3JlDQo+ID4gPiA+ID4gc2NhdHRl
cmluZw0KPiA+ID4gPiA+IG91ciB1c2FnZQ0KPiA+ID4gPiA+IGFjcm9zcyB0aGUgaW5kZXguwqAg
RWgsIG1heWJlIG5vdCBhIGJpZyBkZWFsIGlmIHdlIGp1c3QgZXhwZWN0DQo+ID4gPiA+ID4gdGhl
DQo+ID4gPiA+ID4gcGFnZQ0KPiA+ID4gPiA+IGNhY2hlJ3MgTFJVIHRvIGRvIHRoZSB3b3JrLg0K
PiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gSSBkb24ndCB1bmRlcnN0YW5kIHlvdXIgcG9p
bnQgYWJvdXQgJ25vdCByZXVzaW5nJy4gSWYgdGhlIHVzZXINCj4gPiA+ID4gc2Vla3MgdG8NCj4g
PiA+ID4gdGhlIHNhbWUgY29va2llLCB3ZSByZXVzZSB0aGUgcGFnZS4gSG93ZXZlciBJIGRvbid0
IGtub3cgaG93DQo+ID4gPiA+IHlvdQ0KPiA+ID4gPiB3b3VsZA0KPiA+ID4gPiBnbyBhYm91dCBz
ZXR0aW5nIHVwIGEgc2NoZW1hIHRoYXQgYWxsb3dzIHlvdSB0byBzZWVrIHRvIGFuDQo+ID4gPiA+
IGFyYml0cmFyeQ0KPiA+ID4gPiBjb29raWUgd2l0aG91dCBkb2luZyBhIGxpbmVhciBzZWFyY2gu
DQo+ID4gPiANCj4gPiA+IFNvIHdoZW4gSSB3YXMgdGFraW5nIGFib3V0ICdyZXVzaW5nJyBhIHBh
Z2UsIHRoYXQncyBhYm91dCByZS0NCj4gPiA+IGZpbGxpbmcNCj4gPiA+IHRoZQ0KPiA+ID4gc2Ft
ZSBwYWdlcyByYXRoZXIgdGhhbiBjb25zdGFudGx5IGNvbmp1cmluZyBuZXcgb25lcywgd2hpY2gN
Cj4gPiA+IHJlcXVpcmVzDQo+ID4gPiBsZXNzIG9mDQo+ID4gPiB0aGUgcGFnZWNhY2hlJ3MgcmVz
b3VyY2VzIGluIHRvdGFsLsKgIE1heWJlIHRoZSBwYWdlY2FjaGUgY2FuDQo+ID4gPiBoYW5kbGUN
Cj4gPiA+IHRoYXQNCj4gPiA+IHdpdGhvdXQgaXQgbmVnYXRpdmVseSBpbXBhY3Rpbmcgb3RoZXIg
dXNlcnMgb2YgdGhlIGNhY2hlIHRoYXQNCj4gPiA+IC93aWxsLw0KPiA+ID4gcmUtdXNlDQo+ID4g
PiB0aGVpciBjYWNoZWQgcGFnZXMsIGJ1dCBJIHdvcnJ5IGl0IG1pZ2h0IGJlIGlycmVzcG9uc2li
bGUgb2YgdXMNCj4gPiA+IHRvDQo+ID4gPiBmaWxsIHRoZQ0KPiA+ID4gcGFnZWNhY2hlIHdpdGgg
cGFnZXMgd2Uga25vdyB3ZSdyZSBuZXZlciBnb2luZyB0byBmaW5kIGFnYWluLg0KPiA+ID4gDQo+
ID4gDQo+ID4gSW4gdGhlIGNhc2Ugd2hlcmUgdGhlIHByb2Nlc3NlcyBhcmUgcmVhZGluZyBsaW5l
YXJseSB0aHJvdWdoIGENCj4gPiBkaXJlY3RvcnkgdGhhdCBpcyBub3QgY2hhbmdpbmcgKG9yIGF0
IGxlYXN0IHdoZXJlIHRoZSBiZWdpbm5pbmcgb2YNCj4gPiB0aGUNCj4gPiBkaXJlY3RvcnkgaXMg
bm90IGNoYW5naW5nKSwgd2Ugd2lsbCByZXVzZSB0aGUgY2FjaGVkIGRhdGEsIGJlY2F1c2UNCj4g
PiBqdXN0DQo+ID4gbGlrZSBpbiB0aGUgbGluZWFybHkgaW5kZXhlZCBjYXNlLCBlYWNoIHByb2Nl
c3MgZW5kcyB1cCByZWFkaW5nIHRoZQ0KPiA+IGV4YWN0IHNhbWUgc2VxdWVuY2Ugb2YgY29va2ll
cywgYW5kIGxvb2tpbmcgdXAgdGhlIGV4YWN0IHNhbWUNCj4gPiBzZXF1ZW5jZQ0KPiA+IG9mIGhh
c2hlcy4NCj4gPiANCj4gPiBUaGUgc2VxdWVuY2VzIHN0YXJ0IHRvIGRpdmVyZ2Ugb25seSBpZiB0
aGV5IGhpdCBhIHBhcnQgb2YgdGhlDQo+ID4gZGlyZWN0b3J5DQo+ID4gdGhhdCBpcyBiZWluZyBt
b2RpZmllZC4gQXQgdGhhdCBwb2ludCwgd2UncmUgZ29pbmcgdG8gYmUNCj4gPiBpbnZhbGlkYXRp
bmcNCj4gPiBwYWdlIGNhY2hlIGVudHJpZXMgYW55d2F5IHdpdGggdGhlIGxhc3QgcmVhZGVyIGJl
aW5nIG1vcmUgbGlrZWx5IHRvDQo+ID4gYmUNCj4gPiBmb2xsb3dpbmcgdGhlIG5ldyBzZXF1ZW5j
ZSBvZiBjb29raWVzLg0KPiANCj4gSSBkb24ndCB0aGluayB3ZSBjbGVhbiB1cCBiZWhpbmQgb3Vy
c2VsdmVzIGFueW1vcmUuwqAgTm93IHRoYXQgd2UgYXJlDQo+IGdvaW5nDQo+IHRvIHZhbGlkYXRl
IGVhY2ggcGFnZSBiZWZvcmUgdXNpbmcgaXQsIHdlIGRvbid0IGludmFsaWRhdGUgdGhlIHdob2xl
DQo+IGNhY2hlDQo+IGF0IGFueSBwb2ludC7CoCBUaGF0IG1lYW5zIHRoYXQgYSBkaXZlcmdlbmNl
IGR1cGxpY2F0ZXMgdGhlIHBhZ2VjYWNoZQ0KPiB1c2FnZQ0KPiBiZXlvbmQgdGhlIGRpdmVyZ2Vu
Y2UuDQo+IA0KDQpOby4gSSByZWluc3RhdGVkIHRoZSBjYWxsIHRvIG5mc19yZXZhbGlkYXRlX21h
cHBpbmcoKSBpbiB0aGUgbGludXgtbmV4dA0KYnJhbmNoIGFmdGVyIE9sZ2EgZGVtb25zdHJhdGVk
IHRoYXQgTkZTdjMgaXMgc3RpbGwgdHJvdWJsZWQgd2l0aCBjcmFwcHkNCm10aW1lL2N0aW1lIHJl
c29sdXRpb25zIG9uIHRoZSBzZXJ2ZXIgY2F1c2luZyBkaXJlY3RvcnkgY2hhbmdlcyB0byBub3QN
CmJlIHJlZmxlY3RlZCBpbiB0aGUgcmVhZGRpciBjYWNoZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
