Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013DC786137
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Aug 2023 22:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjHWUHj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Aug 2023 16:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbjHWUHi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Aug 2023 16:07:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2097.outbound.protection.outlook.com [40.107.94.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0C0E78
        for <linux-nfs@vger.kernel.org>; Wed, 23 Aug 2023 13:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STa6YLZotVN5q27D5NumQ/jYHr0eaPvBptOUo7tSIgLkgXzM0ImZea+Rrwo9g993OxJt1zMKt1255pfAp/PaFfk2YdnqKD426qd6h+t4063FwexxisNSXS5LKQ1uKw4RmeQPnOGZT/DjdoM5MHc1mc+mUf5YkANATmq0TqhbNuNq6V2NfwHMo5RQzl2A/YZq2GpH+rO2MpnmbtJkyTQIipW/S9hlsU6XcHy0OMei/VdvG9k+0sGtNmYi2ZL8f8T2PR3FQHbDPPoczxxd6ALEauXYpSsbH0/URZNfxNElSv3yzg+VFRJsgKidpsVaAYPc4FiXAg5meKDhSj3DRyx3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S+xH4LS/rvejAnjYI4TpoqcBvVP1jgBIxon6X7zNKg=;
 b=cs/QP0Jvzc4AwUdglFzBxivQHOlBoRbw2bw9Nzi+FTmv5Fbxn2NmAfUpozQqKxB2LvRHLGLsH2NVk39G/1ZeteDp1lwkbijF02fQeo2/gVVZQ+rk/SLFxb3jbIAyNLOtNxxs300BLReNRYyJTY40/7GtgvM1fuZMG5d1jOOOzEWKVnDbyFLiLGXo0UdLKOMTiLgScKOkTHH+YLUiu3fmrWCvTGro4+SEL0IwcrAg8zUBsGcNL9Aq4N50H9bwZys4PaHiPkUN6DlCacOKNDiaboJZqk1gpLhu+FiqJBpok3PUAyB9/ej9ugc614LvkE9RJufsxLH7WheG2gDlhOEshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S+xH4LS/rvejAnjYI4TpoqcBvVP1jgBIxon6X7zNKg=;
 b=UG8gIDIEc/2HZ492txG4ojekv0hARmayGEcVW5vlMcQ4VynQ2NXHbY7Ab890IoSCOJ9kEUyC2eVn/vqc9u1yTj3lVRZyqM9RC8maZ/ptNYyFshD8RDg+2yPl3u7hpHqX6y8rEn7M+pIsrxjzsGl5ay+SrRYmP4roxNfT1rIvB1Q=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB5149.namprd13.prod.outlook.com (2603:10b6:408:150::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 20:07:32 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::3fa6:b553:8f2f:6895%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 20:07:31 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "pedro.principeza@canonical.com" <pedro.principeza@canonical.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "tiago.pasqualini@canonical.com" <tiago.pasqualini@canonical.com>
Subject: Re: Question on RPC_TASK_NO_RETRANS_TIMEOUT /
 NFS_CS_NO_RETRANS_TIMEOUT for NFSv3
Thread-Topic: Question on RPC_TASK_NO_RETRANS_TIMEOUT /
 NFS_CS_NO_RETRANS_TIMEOUT for NFSv3
Thread-Index: AQHZ1fySI+6vQIy7QUeWgU0m2YwTw6/4TuoA
Date:   Wed, 23 Aug 2023 20:07:31 +0000
Message-ID: <af74ab2ade42450f7c5a9b9e1da84435474fd0f6.camel@hammerspace.com>
References: <CA+PbK_6rL3FQLfSLSVb4vSV+psgRBv7iBY40viAYQPkkWiWLEA@mail.gmail.com>
In-Reply-To: <CA+PbK_6rL3FQLfSLSVb4vSV+psgRBv7iBY40viAYQPkkWiWLEA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BN0PR13MB5149:EE_
x-ms-office365-filtering-correlation-id: 09b1e134-7d25-4868-e819-08dba414955b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wmOFdzDcC7cQ7aJBZdBrP6ZNR6t/hkne0B8wdeOeLVUdEV4vVP2sDeAIM1xSv71xd2T7cuFysz4h7UpPWUIr81WXiC5qVAd3Ypx8C7xtPRsb++MKRPVFLhcytckArrdtlLFshW3pu6NTqnhS9jJc4+kp/xyo+CGma9I1AbTQhCTCoJc6yXJNedAD2ZZnYRG+UlTS6XN8772NfwJIKCqN/PKEO/mzV30vKOy9Fbio05RJyhrW7TgNfRE/31tWg8kGvG8hX1HhX7JF3/9zJCsucmvrXYdw7JFbRWiNhqC5sz4lq9tZsV9cJHR7iJaSq8TlICY0+5Nj2YE/dkzm3vi+/BOjLh0vkNiX3jL+rUtSpp2jSmkwuSTP3P+yJl+2i0Q2DM9KsEBilzM4OcgSmo3BRwcpOVvUee1xWZ1MUYVXsn/a8DqO45mESJBXHMnRdGwHiQeo2ay/Z1k/BFY7eRY/QHVz9hCI2RFfRBpABX/fEZrZdT+r+EgtSGv48p55PI1O9J8+7JMEnr3dJG+KZLd5glLE+4WiS4YFK52JFe/jyH7gSOUGGpsBuhwFOSyNVfynblxYyqo1WioXN508JnBY3XS2F/qPXUeLJpZw2dKVFUGYCNdfl+sM6T3CRzX7DejOJEhjyk7LkGjhEbqPiHav/fwvIGCiTs2WTO1nnR0q7IG6M2qUiKP4qlQO+ztro6bIJtivS+K/waM50dHNykEgTdjqcg/PXa7ZJf5uBJ5iDmM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39850400004)(376002)(396003)(186009)(1800799009)(451199024)(66899024)(83380400001)(2906002)(38070700005)(38100700002)(122000001)(86362001)(36756003)(41300700001)(6512007)(110136005)(66446008)(76116006)(66946007)(64756008)(66476007)(66556008)(6506007)(6486002)(316002)(2616005)(8676002)(8936002)(4326008)(12101799020)(478600001)(71200400001)(26005)(966005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjkxaGIya2VPNzlabEZQOENsRE0yZ3gwOFpuZmNDbUVGdk5USjVEU05kUG5O?=
 =?utf-8?B?UmtGQTUwQW93ZStHUWRlUWhNeU53T2hVcllyekIxN29rZHlaNUFkdFlWN251?=
 =?utf-8?B?MWRodVlRck1yTUY4dmE5WGJqVjhDL0M2QTI3cjlJa1RMZTFwSUtIY3Z2bVM5?=
 =?utf-8?B?Y2FtME5ZYU5kNXYvajBvSDNEYklJS3UrR3c1V1hDNFFIR0FGT0NxNUVqMUxY?=
 =?utf-8?B?ckZwMVAzakZzZUtteFV5VXdKMGQ1UGduRXhta1hPQjN4cE1tbWpDaFdYQ2M5?=
 =?utf-8?B?WGlpUVZlN2FVYXZ6cy9kSkxPL2xZRGVwYU50TDdQbW9RNlppWUVWZE1aZnhZ?=
 =?utf-8?B?SnJsNGN5MkRIZmhYNzR6WnR6YTZ2ai8vbytJMzZrZ2hvaTE5ZTF4dWliVkds?=
 =?utf-8?B?UjRUcC9jVVJ4SnpMMklLQmpPQmtiTHdYc2QvNVdNMEwzc3BMMmx4cVQ1NW1n?=
 =?utf-8?B?T0NYMDZTYnJ5UFlIdmJZZStxenJNdjU3enhSY0lkN29xa3p4SDJyUSs4eExz?=
 =?utf-8?B?Tm1kU0laaXM1Rit5NURiQkF0NFZOMkx5cVVzRkVLUFpkeDhjUDRlc3hKNnRX?=
 =?utf-8?B?ZCttSE1CZkF6Z2pQQlNUQnA3L3V0OFRyeCtwekJIT3JXNG0vSEwrZmVWc1ZH?=
 =?utf-8?B?Y3F1WGdFR1BWNVdYZXlqeXY0dS8wZFF1UHlrTkVCWm95bGJXaGtWenpWbEZI?=
 =?utf-8?B?MElKMjJhNjJlcGx5cHd4bGkxS3B2aXBmN2l6UEw5T09pdEx2MDBrY2UrZGNh?=
 =?utf-8?B?Mkc0R3lQaGNMOSsyemtRWS9zbG1wY3c3UDllTjJrcHhBRU1aQmJDTzR1Y2hl?=
 =?utf-8?B?NmwzYlFRb0dUMWt1dTBWQ3lOVFNWZ1lub0UyK21VTmtOYXdLTjIzUDlKdW1m?=
 =?utf-8?B?a0RUTkVxUlN6aUtubVlNNkZjNG94clFzQmhyNXVpMW15MlZYMGRtYzlSQkk2?=
 =?utf-8?B?UzJUZ0ZJbHpCdmpBMzlTRGVMZGkrczJVZmE0Z2lvZ1ZhZU9YeDludDc2bE9Z?=
 =?utf-8?B?OFFUUEVSWk5kUlJacy9YTHRvQjVsNllEdUkxOGhpZ3p1VTdYK2ZlMHdHWHg5?=
 =?utf-8?B?ODNDM1h1TFc4M25vZUJid3ErejZqdVdrRnhhRUQzZ0owMUVIbHllYmkrY3NF?=
 =?utf-8?B?bldNaUc4OEttTWlWUjdlUURnNlZsNjhIR3pHK3pGWmtlZUdhMTVsMHZHWVhE?=
 =?utf-8?B?N0JicVRhVFpvSDJSeG12SmZrWUVLcjdwRDBCbjVPeS96NFFjb0JNUEg3MDVP?=
 =?utf-8?B?WERCUUZjQkRucG16WFRuRWlwRVhHakNiWEhPcktOQW52Vkxta2dBbFdwajV5?=
 =?utf-8?B?d21NSFJ4bmlyR0wwZm1RRnZCeTdBVktpU1BJU1FyWndIbkh3M21ncVpYWUxO?=
 =?utf-8?B?ODAySTR6SExIbnAxV3pObnpQMmNsQkpVMVVVWjNCZUN3MjF5TytjRFoyUUVs?=
 =?utf-8?B?clI3QWJsV2JmbTBMaUlpV09iRW1VR09wZ0VPQ1VRS3AwdGFTNjRhWFZ3MlI2?=
 =?utf-8?B?VDFMT0RJYkY2c3ZiTldIenplV3B3VWhVTUJlQUhjeTRGYzBJZEwxWm1NWFRx?=
 =?utf-8?B?R2swZENIaHZPbDcrMlVIWEFBcE9mVkZCaXo4SmNIOUR3NjBsSlMzcFlLVGM5?=
 =?utf-8?B?NDVPT0grUGNDZmJhSkdDcTJZN09aSE1paDRkbHJVZzlkMVlpV1duY2hkSHdn?=
 =?utf-8?B?Y1ZudVQrZDhybUhFWFkvN0VRU3NjbjgwVzZoeFRFU0R5QTlUZDRvTy84NWpY?=
 =?utf-8?B?Uy91YjFxaVRQeVoyTW1EUCtjWHVsd3RIQklUSHN2MlRXV0tSNDNDWWNkZHQ2?=
 =?utf-8?B?anI1L2FTSTcwcVpCOXRJNC81dUFFWFhKdklsWGFDRHNnWitKYVFnREs1SHky?=
 =?utf-8?B?N1N6S0hncEQxL052K0traVl2akFZL3d2MEVGNHVGcEhIYjVmLzJYVEM4WDFp?=
 =?utf-8?B?ZVBvajNlcjV6dXdsWGEreC9tV3Z2eUxUK0tIMFlpM2ZnNkxzZms2RC9wV2Z6?=
 =?utf-8?B?Y0ZwM2dVbFJXTEVwMUhwb1VNN3JWcXFyYXNVMGtMbi81eTYvMmpJUk9reFVL?=
 =?utf-8?B?eFNVSTIzZmNiSU5FUTgwQ0hFbS9GSmZ4d29yS0c0ck9JVUJlSUtKRFRSVTF3?=
 =?utf-8?B?MU9taXI5V1VKSXNRbGVnazRxbWI2dFV6OWxUUTRtR3dnTFQ0RFJuMUNzMGJm?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FE852DC4C8A8C478725F34010948EBE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b1e134-7d25-4868-e819-08dba414955b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 20:07:31.5095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zt/09H9ZpV56/eQEh2IEEcFySVJOuGutUzoDUt8OxQjxAzic93VozEhhxcWNq6jgbbDrttIQwsQ2BqoH4Nf8fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTIzIGF0IDE2OjU5IC0wMzAwLCBQZWRybyBQcmluY2lwZXphIHdyb3Rl
Og0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHBlZHJvLnByaW5jaXBlemFAY2Fu
b25pY2FsLmNvbS4gTGVhcm4NCj4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0DQo+IGh0dHBzOi8v
YWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbsKgXQ0KPiANCj4gSGksIHRoZXJl
IQ0KPiANCj4gV2UgaGF2ZSBzb21lIHNoYXJlcyB0aGF0IHVzZSBORlN2MyB3aXRoIFRDUCBhbmQg
S2VyYmVyb3MgYW5kIGhhdmUNCj4gYmVlbg0KPiBoaXR0aW5nIGFuIGludHJpZ3VpbmcgaXNzdWUg
d2l0aCB0aG9zZS4gV2UgaGF2ZSBub3RpY2VkIHRoYXQgbmV0d29yaw0KPiBpbnN0YWJpbGl0aWVz
IGhhdmUgYmVlbiBjYXVzaW5nIHNvbWUgJ1Blcm1pc3Npb24gZGVuaWVkJyBlcnJvcnMgb24NCj4g
ZmlsZXMuDQo+IA0KPiBUaGUgY3VycmVudCBzY2VuYXJpbyB3ZSBoYXZlIGlzIGJhc2VkIG9uIE5G
U3YzIG92ZXIgVENQIGNsaWVudHMsDQo+IGNvbmZpZ3VyZWQgd2l0aCBLZXJiZXJvcyAoa3JiNXAp
IGF1dGhlbnRpY2F0aW9uIGFnYWluc3QgYSBOZXRBcHAgTkZTDQo+IFNlcnZlciAoT05UQVApLsKg
IFRoaXMgaXMgaGFwcGVuaW5nIHJlZ2FyZGxlc3Mgb2YgdGhlIEtlcm5lbCB3ZSB1c2UNCj4gKG91
ciBtYWluIHRlc3RzIGJlYXIgNC4xNSBhbmQgNS4xNSBnZW5lcmljIFVidW50dSBLZXJuZWxzIC0g
ZnJvbQ0KPiBCaW9uaWMgYW5kIEphbW15KSwgYW5kIHdlIGhhdmUgbm90IGZvdW5kIGFueSBpbnRl
cmVzdGluZyBjb21taXRzIGluDQo+IGVpdGhlciBjb21wb25lbnRzIHVwc3RyZWFtIHRoYXQgd291
bGQgY2hhbmdlIHRoZSBiZWhhdmlvdXIgaW4gaGFuZC4NCj4gDQo+IFdlIHRyYWNrZWQgdGhvc2Ug
aXNzdWVzIGRvd24gYW5kIGZvdW5kIG91dCB0aGF0IHRoZSAnUGVybWlzc2lvbg0KPiBkZW5pZWQn
IGhhcHBlbnMgYmVjYXVzZSBvdXIgcGFja2V0cyBhcmUgZmFpbGluZyB0aGUgR1NTIGNoZWNrc3Vt
WzFdLg0KPiBXZSBrZXB0IGludmVzdGlnYXRpbmcgYW5kIGRpc2NvdmVyZWQsIGFmdGVyIHNvbWUg
dGNwZHVtcCwgdGhhdCB0aGlzDQo+IGhhcHBlbnMgYmVjYXVzZSB0aGUgY2xpZW50IHJldHJhbnNt
aXRzIFJQQyBwYWNrZXRzLCB3aGljaCBpbmNyZWFzZXMNCj4gdGhlIEdTUyBzZXF1ZW5jZSBudW1i
ZXIuIE1lYW53aGlsZSwgdGhlIHJlc3BvbnNlIHRvIHRoZSBvcmlnaW5hbA0KPiBwYWNrZXQgZ2V0
cyByZWNlaXZlZCwgYnV0IHRoZSBjaGVja3N1bSBmYWlscyBiZWNhdXNlIHRoZSBjbGllbnQgaXMN
Cj4gZXhwZWN0aW5nIGEgZGlmZmVyZW50IEdTUyBzZXF1ZW5jZSBudW1iZXIuDQo+IA0KPiBUaGlz
IGNhbiBiZSBhdm9pZGVkIHdpdGggTkZTdjQgYmVjYXVzZSB0aGUgUlBDIGNsaWVudCBpcyBjcmVh
dGVkIHdpdGgNCj4gYSAibm8gcmV0cmFucyB0aW1lb3V0IiBmbGFnWzJdLiBTdWNoIGEgZmxhZyBp
cyBub3Qgc2V0IGFuZCBpcw0KPiBpbXBvc3NpYmxlIHRvIHNldCBvbiBORlN2My4gV2UgZGlkIHNv
bWUgaW52ZXN0aWdhdGlvbiBhbmQgdGhvdWdodA0KPiB0aGF0DQo+IHNldHRpbmcgdGhpcyBmbGFn
IHdvdWxkIGZpeCBvdXIgcHJvYmxlbXMgd2l0aG91dCB0aGUgbmVlZCB0byBtb3ZlIHRvDQo+IE5G
U3Y0Lg0KPiANCj4gT3VyIHF1ZXN0aW9uIGlzOiBpcyB0aGVyZSBhIHJlYXNvbiB0aGlzIGZsYWcg
aXMgbm90IGJlaW5nIHNldCBub3IgaXMNCj4gaXQgcG9zc2libGUgdG8gc2V0IGl0IGZvciBORlN2
Mz8gSXMgdGhlcmUgc29tZXRoaW5nIG9uIE5GU3YzIHRoYXQNCj4gZGVtYW5kcyBSUEMgcmV0cmFu
c21pc3Npb25zIGV2ZW4gd2l0aCBUQ1A/wqAgT25lICJoaW50IiB3ZSBoYXZlIGNvbWUNCj4gYWNy
b3NzIGlzIHRoYXQgaXQgaXMgKmV4cGxpY2l0bHkgbWVudGlvbmVkKiBpbiBORlN2NCdzIFJGQyBb
M10sIGFuZA0KPiB0aGVyZSBpcyBub3RoaW5nIGluIE5GU3YzIGF0IGFsbCAtIG1vc3QgbGlrZWx5
IGR1ZSB0byB0aGUgZmFjdCB3ZSdyZQ0KPiBkZWFsaW5nIHdpdGggYSBzdGF0ZWxlc3MgcHJvdG9j
b2wuDQo+IA0KPiBBbnkgY29tbWVudHMgd291bGQgYmUgZ3JlYXRseSBhcHByZWNpYXRlZCBoZXJl
IQ0KPiANCj4gVGhhbmsgeW91LA0KPiANCj4gWzFdDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2
YWxkcy9saW51eC9ibG9iL3Y1LjE1L25ldC9zdW5ycGMvYXV0aF9nc3MvZ3NzX2tyYjVfdW5zZWFs
LmMjTDE5NA0KPiBbMl0gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvdjUu
MTUvZnMvbmZzL2NsaWVudC5jI0w1MjENCj4gWzNdIGh0dHBzOi8vZGF0YXRyYWNrZXIuaWV0Zi5v
cmcvZG9jL2h0bWwvcmZjNzUzMCNzZWN0aW9uLTMuMS4xDQoNCk5GU3YzIHNlcnZlcnMgYXJlIGFs
bG93ZWQgdG8gZHJvcCByZXF1ZXN0cywgYW5kIE5GU3YzIGNsaWVudHMgYXJlDQpleHBlY3RlZCB0
byByZXRyYW5zbWl0IHRoZW0gd2hlbiB0aGlzIGhhcHBlbnMuIE5GU3Y0IHNlcnZlcnMgbWF5IG5v
dA0KZHJvcCByZXF1ZXN0cywgYW5kIE5GU3Y0IGNsaWVudHMgYXJlIGV4cGVjdGVkIG5ldmVyIHRv
IHJldHJhbnNtaXQNCih1bmxlc3MgdGhlIGNvbm5lY3Rpb24gYnJlYWtzKS4gRm9yIHRoYXQgcmVh
c29uIHdlIGRvIHNldA0KUlBDX1RBU0tfTk9fUkVUUkFOU19USU1FT1VUIG9uIE5GU3Y0IGFuZCBk
byBub3Qgb24gTkZTdjMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K
