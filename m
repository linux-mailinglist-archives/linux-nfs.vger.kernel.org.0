Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D244C7278
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 18:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiB1RZj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 12:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiB1RZh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 12:25:37 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2135.outbound.protection.outlook.com [40.107.237.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658C345502
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 09:24:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqHrT4Ae+D0MI+UT+eOwM2e8sNtZda4o7km8v4QX6UnQKbUr3TBiqg5eEERuxZx/sRnnkNMpGkHSrxSDimNC0QNSDKpq2emdKuOsBoFGsScrP6MVgrcQh9483e7ZiZbKmpPA8kyJnHxrpPAHCues/x77Ja5iVavby+aVzuzwDw7X/Ru0gLCy5VK9UyQbk+OPd1NgDSM4nzFDxrUnHDVZ8NdyqhxHzgMFcQD0c7bhjqkv/mUrMWpkSvoEW1vd8bNvamBOUQMUo3ghRSAKp7RnB0ExYdcyakT36585IEq6C88BWb7H3iHJVanqDd34qGkTmMSPzQnegzy65EDE0otpxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Em1nDNjlFkdoaWp443AvE6Zhy/C/IhJ4RX9Q+hNsigo=;
 b=a02aZqfVZzTSzF48VJXSoLc+RWt108r/2z/WrTK3zsGKjAmUxIzCY/snJVI3xNoKfIRsQvn0o0WXU498t7YjBaeAzq1oEg+5Ojm0aNvQoeaC/Ja0rZw5ON4UFD8hxP2sVAzWwINu7J62SN/UwPHBeW8+B3y0KQ2un30Ia7LhwPK3sGHqghrEaj79d12h40FKo72TwJEebJEV++mmZXRfU8na8plFUHqUXmbbqHtpf6VWLQLWbp9DdrC2K/hD9mkp/TXiXc4dPsu2tJ+pMtd+SV+UzvPCftTQejqT9Teybu67s3fsoVpyfDkZmUmpiH1n4Lul+MH7GTJoohFIuvassQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em1nDNjlFkdoaWp443AvE6Zhy/C/IhJ4RX9Q+hNsigo=;
 b=UXGNwxgpNR43A/K9lBiti1g/8E268XhV6S0zbncH6RUt2WQRk2V3ubHHqYEKxOsUTv6hJfVby+spV8T6Nr3h5obYY9i1+KDrDOKR70nSonbRpos2nzYuJyLKIpNUpNg/yR3oXlfBh2evYCwO2BfRfxsn6vFbKdRjFiKRX3ZXUqY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3870.namprd13.prod.outlook.com (2603:10b6:208:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Mon, 28 Feb
 2022 17:24:54 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.013; Mon, 28 Feb 2022
 17:24:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: Tune the race to set and use the client id
 uniquifier
Thread-Topic: [PATCH] NFSv4: Tune the race to set and use the client id
 uniquifier
Thread-Index: AQHYI1yGsrbFUuqkvUeUFRfAYTkwhKyXsraAgBGBCwCAABW2AA==
Date:   Mon, 28 Feb 2022 17:24:54 +0000
Message-ID: <73b61ba083df0a8954979fed11d6398d336ee1d1.camel@hammerspace.com>
References: <61a5993a1f9bbed2ba1227bd3376e92232e0530a.1645033262.git.bcodding@redhat.com>
         <3EA14A5C-9FF9-4DDC-B530-768A86E2A4E8@redhat.com>
         <0F8CD466-6233-4386-94C5-FC8E5941F9D3@redhat.com>
In-Reply-To: <0F8CD466-6233-4386-94C5-FC8E5941F9D3@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 450fcba2-4d72-4a78-00d6-08d9fadf3c22
x-ms-traffictypediagnostic: MN2PR13MB3870:EE_
x-microsoft-antispam-prvs: <MN2PR13MB38707117FD813455FC10F7D3B8019@MN2PR13MB3870.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kc/boy0o0AVABokvJgfVY5u3QG3DjFNLXu7TQAp/cfGllc6mUdSOisI6Wd1gjISviA8ZrDd3tYxQtkaabLDoKzhW73V8Ayt2bTG3oEwfky0XgKC5bmUBaKpIqwGiUSJks6dQZ0W0nD/gEwb4hOw9uXtdfXTWOTYUJua6PZmNFfbGRnaer1dYQG8mMF6Oa+tY1ZCnhFfElhcSWUQlyfJFysa28eOavyl606yQMNzpn8A8/LnP7lKjoIOp6QG+WPN/nrVpuff8AmPkFbydy4g5lOXez05dUmon9bA/qMVl1V+CzAqDpPNYSTuUUEvCrPqVLmXAtGdV/DzzZx0W/utd5V6NODlhVqtS6x7hHbJWW5PQtE/8U2rzU+ebj4uXg3fg501Kffk01bIc1PO7klLNSn69XIOBX4ysjbRfH8YYNOihKwN2CbEPTQJ952BIlZSGj5L0SlVRL8S8RyUW+pNtb2Q/nm2ilkvv7hzVa1IpfeLAchVXG41bd1CQ1COvRszuckXwKYWk0QNKeKxacHbgxw8KvPJYrMHr3uIbTmjZh+YNkOROv3VBH3iykkrWUuqANTRLr6OEZUIEwPSVtaGkXJtYECuLRRB6NaFZICGzzXc60nqofAxp7+XsnZ3oIGPOTLSo8yZ1MgQfTpzQEwIhgul6gGaGvuZycfC4Ytcy/VF9FIaLy/0rMbbO2GIz+mXKNx+Z97R3upu9ehuAv44dkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(36756003)(2906002)(8936002)(66556008)(83380400001)(66476007)(76116006)(64756008)(66946007)(8676002)(4326008)(186003)(26005)(71200400001)(53546011)(2616005)(508600001)(6506007)(6512007)(38100700002)(86362001)(6486002)(5660300002)(110136005)(38070700005)(122000001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MSs0UlFEeGkyK0RvcytkWDV6WHJMVnVvZkJ3Y3pxUVZmejRZNUhkUWJsMFgw?=
 =?utf-8?B?M01BS0JwT2JWTFZ1S3RwYUFycFErN1JvdVhJTjVsbzJOYXVOMmFWY2ZqL2I4?=
 =?utf-8?B?dFA1L2NyWFpJN255VytUYTZXNFZqM2NTYmRja29ub3NTaitFRXh3dHNyU2hQ?=
 =?utf-8?B?ZndvNExUNTlON0J6YkRDUXM0UE8waTc2S2J5VWcwNDVUUHp2bHNyNlcvZDk0?=
 =?utf-8?B?SGdCZG1qUERiSUVhV2xNZHM5UU1keDdCa3ZIRCt3NEltU1A3ME45cmtxcmVG?=
 =?utf-8?B?aTRUcityM1pSNHpaaFZQOHJEZlZkUG9La2I0d2QyWVJVZGdIZ1Y3OE9pM3po?=
 =?utf-8?B?VHcwdHZBVDdzMFFTVStGcEtOWEJXdnh4Wi9od3JKZ1pYSjdVZ2VUT2pXVS9i?=
 =?utf-8?B?azRoVVB5ZnQwc21iaHhUT1dLbk1HMHZtQkhNYWV3N2hIa004cUNYWVB3Zk43?=
 =?utf-8?B?ajEzeDBqWm5YMFdrY3NrVjM5WlB5ODc3R0dvWmF4bTYvN2k5ZVFFMi9HRit1?=
 =?utf-8?B?R1BtWXNVdnFRRjJFMlFkTG1Pd1ltUXk1akZySDQrVUFUbUxEZ1NaOWlWWmVr?=
 =?utf-8?B?OUN3THRSL0F3OXhrWkRDL0VHZitqME9IeVZucGFSbC9KSUk0VTF5VUZDaWRq?=
 =?utf-8?B?TjlwS2JvYXpkc2hObUZ0UE15TGpZajR0bUdqekNRbHp2YmQ5RWtiRVkvL0ZC?=
 =?utf-8?B?SGFUQXZaZ1lNcTN6azNFOWxVZWxsQzJIM3VNYkVQalRMVk5UeFhtL05pMVhG?=
 =?utf-8?B?ajBDR0F5UllycnFRYlNZeXJlanZhNGRkNk1tejN3UitNRTdPUVFxTWlVUFBy?=
 =?utf-8?B?RVpibFpSVmQ0anQ0cElZcXdXYk9zV1drNnZnVG9QWmY5aHFlbVpKaGdEK0M1?=
 =?utf-8?B?YlpGbFNYZ21na25vZzdoaGhKcE1teWlMdVUwUTFseG1IQzJod2JxKzRDN3FK?=
 =?utf-8?B?M2NOVi96dDM3V25Hd1RKQnJzN3FZc1RxRFMzSW94bHUzZm1ta2Y0OTBVay9B?=
 =?utf-8?B?Y2c3VWRIQ2t3cEhQWVJKcnUwdVNVWjdUeG90VVR5STBSVTZRY0lMWE9vUnA2?=
 =?utf-8?B?SFlsSFVSaDliQUpCUm1wVUpjczhhWGYzcHhiRWJEY2NxY01ZT2xqSlA0dGJ5?=
 =?utf-8?B?Z3N3b3ZDR1lTRGNFdXFJc3lWakozZUZwaHRMQlZHVUJORSt6N0JhZDhUQUJN?=
 =?utf-8?B?dG9LTVcxMXExYTFob1E2UU9PYmFKUDdtMWlqa05wTnpJRGNmTm9ML0JoRjdh?=
 =?utf-8?B?TjNyY2I0YlVCbkZDRzVBTFVSckQ1VlVZNVNKbXhKODVVOGtNUjlBV2VmNmpQ?=
 =?utf-8?B?Z0ZNa0RDblJsSC9YTC9xRURYOXUzK016cGdudVJ5OEUvaEpPQnluNG1TdmZQ?=
 =?utf-8?B?aXZqRXZvd3hGTmh2YU05N3BqNVBXRThCcDhtL29WRU9DTGRHd2FUS3R3U2U4?=
 =?utf-8?B?V1B5YWEvaXZKVzVvd2tESmVTQ3QwdHFPWTgwaG5XL0l3VUI2RjlYREVQVTRS?=
 =?utf-8?B?S1NtbWFmZjdJSThENzdmbENBU3h6ejM0a2FkQWI0am45WVhxSTBBREdkQnpq?=
 =?utf-8?B?U3VVZkZxellyZ1BLWjhld2pwc0IvODZBM1pTdmZuM0J6QUdLMFFjRHJhbENM?=
 =?utf-8?B?c1NjVFQ4M1NyTVEyRnlheW5GYjlYZnM3WjJBZ2R2VVJQbEliV1JQTEFqdFFX?=
 =?utf-8?B?WUpwV1prbU1YRjNBWWUvTXVmZFNoL3dqczBtMFA2WWJKeERVSXFub1BrTjdk?=
 =?utf-8?B?MG1JZ3F5NXZzc212NWtFRVlsRVhhZHE4R0MvWlhVS0hab1U2TnpYeW41Sitj?=
 =?utf-8?B?ZTJTb0NGQ042RnozaVZGYXVUUjA3VE1RNFZHanh0cjdzOWg2ajQxZWxTTFFW?=
 =?utf-8?B?TENxQUVaWFpVWThTMzNlT2NxOXF4RlhWNWdZc0RqSXBSUkJJRXpORUlqSVJR?=
 =?utf-8?B?dTZKejVKaDROSEhPQ29jTjNPOC9WY0pUcjRVZ28rcHBVTjN6THZ0QnN5Ykha?=
 =?utf-8?B?UGJNNzZQM1RpWG90ZW5MTjJsQ2VkK0l6ZlB3R0d5eFdwYU1vM3h3T2EvcFZw?=
 =?utf-8?B?TTFucCt6ZnV4MnZzdE5tc21aUEtqMUNaZjNmUS9NQklIeVFXaTdKejFPV2tH?=
 =?utf-8?B?YmNrZEJidmxKWDZEM01kSGN0U1NRdDF0Q2ZZWVRzTGVBTEtCUWE3SmJYQzBJ?=
 =?utf-8?Q?E7XJBYf1f3ya11cGioj3kH0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86091330C5BC304AA4D5848A3FBACDB6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450fcba2-4d72-4a78-00d6-08d9fadf3c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 17:24:54.1415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KcHk3dU3IMxFrHgIXEjVVR2vTAfeOgpZSFxJ3gBUOcs8myQpLFN7DnbR1iuQx0Ad+Gze0oZEmYrAinw5wfMbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3870
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTI4IGF0IDExOjA3IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAxNyBGZWIgMjAyMiwgYXQgNzo0OCwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90
ZToNCj4gDQo+ID4gVHJvbmQgYW5kIEFubmEsIHRoaXMgcGF0Y2ggbWFrZXMgb2J2aW91cyBvbmUg
cHJvYmxlbSB3aXRoIHRoZSB1ZGV2IA0KPiA+IGFwcHJvYWNoLg0KPiA+IFdlIGNhbm5vdCBkZXBl
bmQgZnVsbHkgb24gc3RhYmxlIHVuaXF1aWZpZXJzLsKgIFRoZSBjb252ZXJzYXRpb24gb24NCj4g
PiB0aGUNCj4gPiB1c2Vyc3BhY2Ugc2lkZSBoYXMgY29tZSBmdWxsIGNpcmNsZSB0byBhc3NlcnRp
bmcgd2UgdXNlIGEgbW91bnQgDQo+ID4gb3B0aW9uLg0KPiA+IA0KPiA+IERvIHlvdSBzdGlsbCB3
YW50IHVzIHRvIGtlZXAgdGhpcyBhcHByb2FjaCwgb3Igd2lsbCB5b3UgYWNjZXB0IGENCj4gPiBt
b3VudA0KPiA+IG9wdGlvbiBhczoNCj4gPiDCoC0gZmlyc3QgbW91bnQgaW4gYSBuYW1lc3BhY2Ug
c2V0cyB0aGUgaWRlbnRpZmllcg0KPiA+IMKgLSBzdWJzZXF1ZW50IG1vdW50cyB3aXRoIGNvbmZs
aWN0aW5nIGlkZW50aWZpZXJzIHJldHVybiBhbiBlcnJvcg0KPiA+IA0KPiA+IElmIHdlIGtlZXAg
dGhpcyB1ZGV2IGFwcHJvYWNoLCB0aGlzIHBhdGNoIGlzbid0IG5lY2Vzc2FyeSBidXQgZG9lcyAN
Cj4gPiBncmVhdGx5DQo+ID4gcmVkdWNlIHRoZSBjaGFuY2VzIG9mIGhhdmluZyBjbGllbnRzIHdp
dGggdW5zdGFibGUgaWRlbnRpZmllcnMuDQo+ID4gDQo+ID4gTm8gb25lIGNhbiBiZSBibGFtZWQg
Zm9yIGlnbm9yaW5nIHRoaXMsIGJ1dCBpdCB3b3VsZCBiZSBhIHJlbGllZiB0bw0KPiA+IGdldCB0
aGlzDQo+ID4gcHJvYmxlbSBzb2x2ZWQgc28gaXQgY2FuIHN0b3AgYnVybmluZyBvdXIgdGltZS4N
Cj4gPiANCj4gPiBQbGVhc2UgYWR2aXNlLA0KPiA+IEJlbg0KPiANCj4gQXR0ZW1wdHMgdG8gd29y
ayB0b3dhcmQgc29sdXRpb25zIGluIHRoaXMgYXJlYSBzZWVtIHRvIGJlIGlnbm9yZWQsDQo+IHRo
ZQ0KPiBxdWVzdGlvbnMgc3RpbGwgc3RhbmQuwqAgVW50aWwgd2UgY2FuIHNvcnQgb3V0IGFuZCBh
Z3JlZSBvbiBhDQo+IGRpcmVjdGlvbiwNCj4gc2VsZi1OQUNLIHRvIHRoaXMgcGF0Y2guDQoNCkEg
bmV3IG1vdW50IG9wdGlvbiBkb2Vzbid0IHNvbHZlIGFueSBwcm9ibGVtcyB0aGF0IHdlIGNhbid0
IHNvbHZlIHdpdGgNCnRoZSBleGlzdGluZyBmcmFtZXdvcmsuDQoNClRoZSBwcm9ibGVtIHdlJ3Jl
IHRyeWluZyB0byBzb2x2ZSBpc24ndCAiSG93IGRvIEkgc2V0IHRoZSBzdGFibGUNCnVuaXF1aWZp
ZXIgaW4gYSBjb250YWluZXI/Ig0KWW91IGNhbiBhbHJlYWR5IGRvIHRoYXQgYnkgbWFudWFsbHkg
c2V0dGluZyB0aGUgY29ycmVjdCB2YWx1ZSBpbg0KL3N5cy9mcy9uZnMvbmV0L25mc19jbGllbnQv
aWRlbnRpZmllci4gVGhlcmUgaXMgbm8gbmVlZCBmb3IgYSBuZXcNCmtlcm5lbCBtb3VudCBvcHRp
b24uDQoNClRoZSByZWFsIHByb2JsZW0gdGhhdCB3ZSBhcmUgdHJ5aW5nIHRvIHNvbHZlIGlzOiAi
SG93IGRvIEkgZW5zdXJlIHRoYXQNCmEgc3RhYmxlIHVuaXF1aWZpZXIgaXMgYWx3YXlzIHNldCBi
eSB0aGUgdXNlcj8iDQoNCldoaWxlIHlvdSBjb3VsZCBoYXZlICJtb3VudCIgZG8gdGhhdCwgaXQg
aXMgbm90IGdvaW5nIHRvIGJlIHNvbHZlZCBieQ0KYWRkaW5nIGEgbWFuZGF0b3J5IG1vdW50IG9w
dGlvbi4gSXQgaXMgZmFyIGJldHRlciB0byBoYXZlIGEgc2VwYXJhdGUNCmhlbHBlciB0aGF0IGdl
bmVyYXRlcyBhbmQgcGVyc2lzdHMgdGhhdCBzdGFibGUgdW5pcXVpZmllciBpbiBhIHdlbGwtDQpr
bm93biBsb2NhdGlvbi4gSWYgeW91IHdhbnQgdG8gY2FsbCB0aGF0IGhlbHBlciBmcm9tICdtb3Vu
dCcgd2hlbiBpdA0Kc2VlcyB0aGF0IHRoZSAvc3lzL2ZzLy4uLiBwc2V1ZG8tZmlsZSBpcyBlbXB0
eSwgdGhlbiBieSBhbGwgbWVhbnMsDQpob3dldmVyIHRoZSBwb2ludCBpcyB0aGF0IHRoZSBzb2x1
dGlvbiBuZWVkcyB0byBhcHBseSB0byBleGlzdGluZw0Kc2V0dXBzIHdpdGhvdXQgYW55IGZ1cnRo
ZXIgY2hhbmdlcy4NCg0KSSdtIGhhcHB5IHRvIHNldCB1cCBhIGtlcm5lbCBwYXRjaCB0aGF0IGlu
aXRpYWxpc2VzIHRoZSBwc2V1ZG8tZmlsZQ0KYmFzZWQgdW5pcXVpZmllciBmb3IgaW5pdF9uZXQg
ZnJvbSB0aGUgbW9kdWxlIHBhcmFtZXRlci4gVGhhdCBjb3VsZA0KaGVscCBlbnN1cmUgdGhhdCB3
ZSB3b24ndCBvdmVycmlkZSBhbnkgZXhpc3Rpbmcgc2V0dGluZyBmb3IgdGhlIGhvc3QuDQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
