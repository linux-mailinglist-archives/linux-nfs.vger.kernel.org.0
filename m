Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8706A596604
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Aug 2022 01:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiHPXca (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Aug 2022 19:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiHPXc3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Aug 2022 19:32:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2124.outbound.protection.outlook.com [40.107.237.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935F990C52
        for <linux-nfs@vger.kernel.org>; Tue, 16 Aug 2022 16:32:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLHvHtEdnSfS27DcNXSYdUVZ6PDwiuNIP82KvC3ObtwpzqWPnfPLKlYnAZzuiG9Z3TMh38Z0XFRYKKBWf/A+zhNI93Ve0EmrMsm51Ye4M+BDRSbELrGRIiw0NpSAkVMEngUnRklqLdZawH4MHxeTpRxqvqTBme2gUk1lnlgyWV7YOmmJiAgOgM/9edINxbYqHf6wxXbDs+6IAgJoovmsBl3RMfCcS6yfQtA/7sjdza4q/spQV5DxlxEmoFTPNYRUSilvF522wrc91RF9Yf/8EK04TDRvmnKBKYmsVmPYg863tToMc00J2JelXzXYZRxZv1S3peCw4IQNooO3EJLNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1H5zcMm+G0LdK7vR1pYhzhxUV6FKnM2zHcct8RbQo2c=;
 b=l/B0yya9hGRQXs2wHsJWwPsRW+ZGadQVmuSbf53E0QNEz761ZZn3DupXbHW2RtVr8j1i+a+IhUVZd9sj/Myubgaxc3Hxp9gLp3YLhvygUmeSENf6Tcgqye8bTiAgHxPuPUHu9/mILbtudCWZ3iCQL8ifEuCipIdTCw/zyHLvWoE3uI7TmNBR8pX26KnYCprBWlwBtX2RVMTEr6AWuS/quueaNOGehdeVCddv93ba2cHz+9og8u1CptFZn2ztJ7fTtNCrFshNvXOvEcIyLBwQtDyWIBH+q+QxJPVL2TzDeTKYmQbbhmIimhIk2sKVkn/K8kHeDhVPuxCKZNiFMDe/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1H5zcMm+G0LdK7vR1pYhzhxUV6FKnM2zHcct8RbQo2c=;
 b=Gu7Jq7WjnVvnnTnZVzhXVKSBx4vdbFkORyCq1PBDJ+++kJKbgGvIV3WmS6pw8cmJNAkWbaOH080j86R3cp8BeokNutvXGq0Q9H7o4nzqRzjFdDW1/GE0VA0R+p7yTQzcYSSikLrYXyLV+MhK3TImBNyk+3WLfoAea6MbkDHY31A=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN6PR13MB2961.namprd13.prod.outlook.com (2603:10b6:405:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.15; Tue, 16 Aug
 2022 23:32:25 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6dcb:fcd2:921b:9035%8]) with mapi id 15.20.5546.014; Tue, 16 Aug 2022
 23:32:25 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Thoughts on mount option to configure client lease renewal time.
Thread-Topic: Thoughts on mount option to configure client lease renewal time.
Thread-Index: AQHYsRznZwAN4fzePUaLFPOYoWLddK2xiDWAgACf5wCAAAaJgA==
Date:   Tue, 16 Aug 2022 23:32:25 +0000
Message-ID: <e6bbd3d63f31f268c1e701f586c0f204a1743edd.camel@hammerspace.com>
References: <166060650771.5425.13177692519730215643@noble.neil.brown.name>      ,
 <e75a36e0a8d6a3df74e0083b91babde01fefb6f5.camel@hammerspace.com>
         <166069134019.5425.14734830786295325514@noble.neil.brown.name>
In-Reply-To: <166069134019.5425.14734830786295325514@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cefb7231-d329-4174-b468-08da7fdf9352
x-ms-traffictypediagnostic: BN6PR13MB2961:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NrBw7iX1xg9zU/RIKNxO7kEObF5b64Go8GQl/mM+yVoYScPZAVD+6FPC5GTaRTxOQSnGzjaCl1pNjpTTMrnBBtzpxJWfeWkgt7MQpk4pfV34ssJo6zaFHYmjrsszjEl1zJe0qH8rHzc6KJEFqiRSHVrmKsREmMd8K2Q0kCTLbUzXgTPplg+EWKtlgOi6nZwLBrcbQRtEI+GX/VQpefwszJ37vJb8DLpnpFJtZKRWg+2c64EQl+mBR1NmhNLQ3S36RRR7rq6Hk2ALP/YXeBZcJ/TvoDgekXYhu9CI/TWaHlNP3QE7vGh7wKnehAatZEvouJlDAPJCwSEWrCyWleGNqH6GWmnDiz+jcFAZeVKJbVsAaldMNSiSx9Qrlk25cw04GA6GlXsE+kVWE3QIe8Bqdh6Fxk6rWAxme8h0Vm5uchGNBEWBWLW0vrIozJNVECwJPydpuGsNfDS2SGK4lsBCGjhuQWDZ/f7ItmAv/Q37/QOrPUhxM9e0zIjcxiuVDr8gkGMwBc3y7X6m9/NFkukGMCv5RBU8I0ueo2G+wSNxoFZqV86Lx7C0fS4qpt/RN1zkVkwRteQoh9x11JJKyrXmd5oJZf5YzTp4cE5GML4koHmbOH9E9LTHBduRS/TVSGC4mDG+Ga2yBAFjX1CIL4xYiXjgXMZp3rfJpSfy4Nq6HlW7AXmROw2G1IDLZPtVFNkJWGMOZqdve4hdP5IA24+acmB2HEctVwzycQXSWzCxi458n0MtJNzkIOyUcSIdrhe7yF2MG+uVLivIlX7HuYueFPtQ/YvxLFOvqIA+2iq+3M0nu/xebUim6n2i+Xh7S4X7uvWKbz5ZsR03sY55gGT7nosd2KJCrrAzScsTY8wzpsw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(366004)(396003)(39840400004)(2616005)(38070700005)(38100700002)(122000001)(186003)(83380400001)(8936002)(5660300002)(8676002)(66446008)(64756008)(4326008)(66476007)(66556008)(76116006)(66946007)(2906002)(41300700001)(478600001)(6506007)(26005)(6916009)(6512007)(6486002)(71200400001)(316002)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWhGcGdRQmo5UFZFajg3WFVFWTdWZEdjZ2FWRE9kQ3BkcE9ZUGM0ZThIbStn?=
 =?utf-8?B?dzE1NW1ZSUNGb25aNmpyYjFZcXRhUk9nNXlGang3ZndrWDUzNEs1U2ZWeHJN?=
 =?utf-8?B?aUU1SFF4cUJPWTZTc2h3T1JJMjBiK0pKd3o2ZVVlK2NMaThUd0tMNTEyRjh1?=
 =?utf-8?B?eExxRzNWcUtUV1pJakM4U3VXcFBxNlN1ZGhtYVRTODIzcmdoTzlmQnJNb3o4?=
 =?utf-8?B?eklhQ0ozemQ0RW5PYjJlVFJFZlVPUGFXMTMybG9EdUhWbkZMMFA0YmZLRkZU?=
 =?utf-8?B?VTFyWG1pV1hMaXpoSWtlc2dGa1VWeVNWL1lFZy9PMjFiME1UQmltaktpTFA4?=
 =?utf-8?B?RXZpTC9qcXQ2UjdqdjVBaVpLNWRSaHFmd3lBd1VjTUsvdXZIV0FXRGdJYWEw?=
 =?utf-8?B?WnNPamFvOUhMTUFObjR1SitaU2xUakcxWCtVdmY1RTlLbUsxZkJUMnZPcitu?=
 =?utf-8?B?L09VaEN0QnpEYmVpbmpUKzBacWVLbDhsSkxCaW5qQ0ljdlVaRjkxbVhVTlVU?=
 =?utf-8?B?K2F3Zkt2anZSTUZodU82Q1Q1Ui96RUcxNVJIYVN0OW9XeFcvRUVlV2dQK3JM?=
 =?utf-8?B?WndPclN5QS9sdG9abjZVVzdqT2VZSWdJWVA1REVBeW43TThyZCtaaGhiUk1U?=
 =?utf-8?B?bjFYK005RmdqcW5jWUM5czUxMVRHdEhSQURnNXVIY0xBclVuVDMyMEFuSmJr?=
 =?utf-8?B?c2JHUmlEbTRYK2s2T201MFNSczR3MFU0SFBDY092a2FBQUdDamNJWHY2N2tK?=
 =?utf-8?B?UlJyU2hnUmR2K2xDOHRaSWQyckJKTE1zSXQ4TkdmSDkyQnk3Ty9GVUxwZG1a?=
 =?utf-8?B?Z1k0emVYZFJqamx4NktDcWhUQ1BzTGtUZXo5QVFDd2h2bWdwNi9pNm91Y3do?=
 =?utf-8?B?VnRJdUJ0MFRuWkZ1VlloSEpYMmUvVHFJTkc5RUdNOTJ1b2wrdGFzV3dFSW5a?=
 =?utf-8?B?ZGdEdnJVVWNnRFlnMkswR0ZwN0FhVThCdTFTNGoyUmR4a0IzREZ5TExlclFi?=
 =?utf-8?B?OGI3dzQyL2N5TkVtZURxYms4Wi9UaDY3VVJ4K01VWENwZXpNdE1ja1hXa1VE?=
 =?utf-8?B?N2c3U3JXc0JLR3FiK1VEekVBY2czWjlMeXQxZTVUa3FDcnZsMDFRSXZtNE0r?=
 =?utf-8?B?M21YbS9hdXM5TEdFU0lmME9XMFhRY3c1eFBSQU5YS2FycWdtSVEyR2xWZ1JM?=
 =?utf-8?B?WFFNL21XWkZBWk9BVmRYVFBCZzdGbE9wVkZFTXpsdkl0ckE1QmVmL1JsUXV6?=
 =?utf-8?B?eVVtTWlLTFlmM0Q0Q3V6WHhaRTdxT3FkdXNvelQzRTZxaThLUHNQQ1Zkejd4?=
 =?utf-8?B?dnFRZGZMMjREek1xbWpRWExSNDdSQldTWmVKcUNVUUFZbnNDUXFOMWRiSlFR?=
 =?utf-8?B?KytuWWo5OURycjBobWE5cm0rSjYveHVEM1R0TlRWYWdtM25iYWVUL2ZLeFZk?=
 =?utf-8?B?TzMzRkY3d0xLQUdNTFRCcjZOcENhaXRHQlJUSUYzdVFOV25LWDFwU2lkaTZp?=
 =?utf-8?B?OUFIUjRsRWVlNFBvaGhmVkZYU2RxQmZyZnE4ZEh3MzU4VmtkY1hFTnlSWTFT?=
 =?utf-8?B?QlNldXpab28wNUEzOVB4QXR0WXlNbHliTElqSVNEOERzbDBGclloRFh4Rzly?=
 =?utf-8?B?VXZKWW4yUGxoSHlNemdnSXR1L0RTOGhuSFJYeFFpdUxqbzFyb3JBRFk5d2t1?=
 =?utf-8?B?L2Q3THN4MSttd1JYUDl4aDRzVm5wQ3pkT3prSUlOSHJ1YWJnU2FZRmdEYTNm?=
 =?utf-8?B?Y2ZiUk5VMzhDekxGS2psdzBGaFVnM3MxWDRydGFEWWxkekZGaEhWcmlnUTdi?=
 =?utf-8?B?SzdlRHZnVHBwRlZZL1pyNGgwYVQwMWkzNEF4YmRvWDZpUU1JdGhRSDdyNUZQ?=
 =?utf-8?B?UzJDY012RHRMbW9zNUtmOUZ6b1RnNDFoNGEyUjducWprQUhEOXI0aE5RRnpN?=
 =?utf-8?B?MkwrK1pPeUh1bEJoREhnV0dSbE92OXhFSTdzQlRSaVE3NTh0c0lWOGZueCtx?=
 =?utf-8?B?Y1gwZ1RaYXc2T2w3YmFIK1lZb2FvWGtFVndYbWcrdXVJVWpmaklKMTFVRElC?=
 =?utf-8?B?dHg0QVdIQnU0eXJhQUlqdWN3MnVVVVl5STBIZjJ5M0RGd0tOMk5ycFhLMlBU?=
 =?utf-8?B?c2tjL3BEVVVmRHdOeEIzQXV6b0I1MWlHbjE5OC9lQmxaQjFvcFMwT2FXcnE0?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84B2D8645CE9E344AF24B3C8338B7779@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefb7231-d329-4174-b468-08da7fdf9352
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 23:32:25.2294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tsncBXBPAzy3MY6JJE041XlNpAEiVS1CMAxQHZBWGqYJnlJtTKbynSEtIusc/2BHPTI2/yJVnAPwLOvyCPxilQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB2961
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTE3IGF0IDA5OjA5ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFR1ZSwgMTYgQXVnIDIwMjIsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBUdWUsIDIw
MjItMDgtMTYgYXQgMDk6MzUgKzEwMDAsIE5laWxCcm93biB3cm90ZToNCj4gPiA+IA0KPiA+ID4g
Q3VycmVudGx5IHRoZSBMaW51eCBORlMgcmVuZXdzIGxlYXNlcyBhdCAyLzMgb2YgdGhlIGxlYXNl
IHRpbWUNCj4gPiA+IGFkdmlzZWQNCj4gPiA+IGJ5IHRoZSBzZXJ2ZXIuDQo+ID4gPiBTb21lIHNl
cnZlciB2ZW5kb3JzIChOb3QgRXhhY3RseSBUYXJnZXRpbmcgQW55IFBhcnRpY3VsYXIgUGFydHkp
DQo+ID4gPiByZWNvbW1lbmQgdmVyeSBzaG9ydCBsZWFzZSB0aW1lcyAtIGFzIHNob3J0IGEgNSBz
ZWNvbmRzIGluIGZhaWwtDQo+ID4gPiBvdmVyDQo+ID4gPiBjb25maWd1cmF0aW9ucy7CoCBUaGlz
IG1lYW5zIDEuNyBzZWNvbmRzIG9mIGppdHRlciBpbiBhbnkgcGFydCBvZg0KPiA+ID4gdGhlDQo+
ID4gPiBzeXN0ZW0gY2FuIHJlc3VsdCBpbiBsZWFzZXMgYmVpbmcgbG9zdCAtIGJ1dCBpdCBkb2Vz
IGFjaGlldmUgZmFzdA0KPiA+ID4gZmFpbC1vdmVyLiANCj4gPiA+IA0KPiA+ID4gSWYgd2UgY291
bGQgY29uZmlndXJlIGEgNSBzZWNvbmQgbGVhc2UtcmVuZXdhbCBvbiB0aGUgY2xpZW50LCBidXQN
Cj4gPiA+IGxlYXZlDQo+ID4gPiBhIDYwIHNlY29uZCBsZWFzZSB0aW1lIG9uIHRoZSBzZXJ2ZXIs
IHRoZW4gd2UgY291bGQgZ2V0IHRoZSBiZXN0DQo+ID4gPiBvZg0KPiA+ID4gYm90aA0KPiA+ID4g
d29ybGRzLsKgIEZhaWxvdmVyIHdvdWxkIGhhcHBlbiBxdWlja2x5LCBidXQgeW91IHdvdWxkIG5l
ZWQgYSBtdWNoDQo+ID4gPiBsb25nZXINCj4gPiA+IGxvYWQgc3Bpa2Ugb3IgbmV0d29yayBwYXJ0
aXRpb24gdG8gY2F1c2UgdGhlIGxvc3Mgb2YgbGVhc2VzLg0KPiA+ID4gDQo+ID4gPiBBcyB2NC4x
IGNhbiBlbmQgdGhlIGdyYWNlIHBlcmlvZCBlYXJseSBvbmNlIGV2ZXJ5b25lIGNoZWNrcyBpbiwg
YQ0KPiA+ID4gbGFyZ2UNCj4gPiA+IGdyYWNlIHBlcmlvZCAod2hpY2ggaXMgbmVlZGVkIGZvciBh
IGxhcmdlIGxlYXNlIHRpbWUpIHdvdWxkDQo+ID4gPiByYXJlbHkgYmUNCj4gPiA+IGENCj4gPiA+
IHByb2JsZW0uDQo+ID4gPiANCj4gPiA+IFNvIG15IHRob3VnaHQgaXMgdG8gYWRkIGEgbW91bnQg
b3B0aW9uICJsZWFzZS1yZW5ldz01IiBmb3IgdjQuMSsNCj4gPiA+IG1vdW50cy4NCj4gPiA+IFRo
ZSBjbGllbnRzIHRoZW4gdXNlcyB0aGF0IG51bWJlciBwcm92aWRpbmcgaXQgaXMgbGVzcyB0aGFu
IDIvMw0KPiA+ID4gb2YNCj4gPiA+IHRoZQ0KPiA+ID4gc2VydmVyLWRlY2xhcmVkIGxlYXNlIHRp
bWUuDQo+ID4gPiANCj4gPiA+IFdoYXQgZG8gcGVvcGxlIHRoaW5rIG9mIHRoaXM/wqAgSXMgdGhl
cmUgYSBiZXR0ZXIgc29sdXRpb24sIG9yIGENCj4gPiA+IHByb2JsZW0NCj4gPiA+IHdpdGggdGhp
cyBvbmU/DQo+ID4gPiANCj4gPiA+IE5laWxCcm93bg0KPiA+ID4gwqANCj4gPiANCj4gPiBJIGRv
bid0IHNlZSBob3cgdGhlIE5GUyBjbGllbnQgY2FuIGV2ZXIgZ3VhcmFudGVlIGEgNSBzZWNvbmQg
bGVhc2UNCj4gPiByZW5ld2FsIHRpbWUsIHNvIGFzIGZhciBhcyBJJ20gY29uY2VybmVkLCB0aGlz
IGlzIG5vdCBhIHByb2JsZW0gd2UNCj4gPiBuZWVkDQo+ID4gdG8gc29sdmUuDQo+IA0KPiBJIGNv
bXBsZXRlbHkgYWdyZWUgd2l0aCB0aGUgZmlyc3Qgc3RhdGVtZW50Lg0KPiBUaGUgcHJvYmxlbSB3
ZSBuZWVkIHRvIHNvbHZlIGlzIHdoYXRldmVyIHByb2JsZW0gaXQgaXMgdGhhdCBtb3RpdmF0ZXMN
Cj4gc2VydmVyIHZlbmRvcnMgdG8gcmVjb21tZW5kIHVucmVhbGlzdGljYWxseSBzaG9ydCBsZWFz
ZSB0aW1lcy4NCj4gDQo+IEkgYmVsaWV2ZSB0aGlzIHByb2JsZW0gaXMgZmFpbC1vdmVyIHRpbWUu
DQo+IEFzc3VtaW5nIHRoYXQgYSBzZXJ2ZXIgZmFpbC1vdmVyIGhhcHBlbnMgaW5zdGFudGx5LCBm
dWxsIE5GUyBzZXJ2aWNlDQo+IGRvZXMNCj4gbm90IHJlc3VtZSB1bnRpbCBhZnRlciB0aGUgZ3Jh
Y2UgcGVyaW9kIGNvbXBsZXRlcy4NCj4gDQo+IFByb3ZpZGluZyBjbGllbnRzIHNlbmQgUkVDTEFJ
TV9DT01QTEVURSBhcHByb3ByaWF0ZWx5LCB0aGUgZ3JhY2UNCj4gcGVyaW9kDQo+IGNvdWxkIGVh
c2lseSBiZSBhcyBsb25nIGFzOg0KPiANCj4gwqAgY2xpZW50IHJlbmV3IHRpbWUgKyB0aW1lIHRv
IHJlY2xhaW0gYWxsIHN0YXRlDQo+IA0KPiBhcyBjbGllbnRzIHRoYXQgYXJlIGlkbGUgKG9yIGJ1
c3kgdGhpbmtpbmcsIG5vdCBhY2Nlc3NpbmcgdGhlDQo+IGZpbGVzeXN0ZW0pIHdpbGwgbm90IG5v
dGljZSB0aGUgZmFpbG92ZXIgdW50aWwgdGhleSBzZW5kIGEgcmVuZXcsDQo+IHdoaWNoDQo+IG1h
eSBub3QgYmUgdW50aWwgdGhlIGZ1bGwgcmVuZXcgdGltZSBoYXMgcGFzc2VkLg0KPiANCj4gVGhl
IG9ubHkgcGFydCBvZiB0aGF0IGNhbGN1bGF0aW9uIHRoYXQgY2FuIGJlIGNvbnRyb2xsZWQgaXMg
dGhlDQo+IGNsaWVudA0KPiByZW5ldyB0aW1lLCBhbmRhdCBwcmVzZW50IHRoYXQgY2FuIG9ubHkg
YmUgY29udHJvbGxlZCBieSByZWR1Y2luZyB0aGUNCj4gbGVhc2UgdGltZS7CoCBIZW5jZSB0aGUg
cmVjb21tZW5kYXRpb24gZm9yIGEgc2hvcnQgbGVhc2UgdGltZS4NCj4gDQo+IElmIHdlIGNvdWxk
IHByb3ZpZGUgYW4gYWx0ZXJuYXRlIG1lYW5zIHRvIHJlZHVjaW5nIHRoZSBjbGllbnQgcmVuZXcN
Cj4gdGltZQ0KPiAtIGEgbW91bnQgb3B0aW9uIC0gdGhlbiB0aGVyZSB3b3VsZCBiZSBubyBpbmNl
bnRpdmUgdG8gcmVjb21tZW5kIGFuDQo+IGltcHJhY3RpY2FsbHkgc2hvcnQgbGVhc2UgdGltZS4N
Cj4gDQo+IFRoYW5rcywNCj4gTmVpbEJyb3duDQoNCkluc3RlYWQgb2Ygd2FzdGluZyBhIGxvYWQg
b2YgQ1BVIGN5Y2xlcyBwaW5naW5nIHRoZSBORlMgbGF5ZXIsIHdoeSBub3QNCmZhcm0gdGhpcyBv
dXQgdG8gdGhlIFRDUCBsYXllcj8gV2UgYWxyZWFkeSBoYXZlIGtlZXBhbGl2ZSB0byBlbnN1cmUN
CnRoYXQgdGhlIGNvbm5lY3Rpb24gc3RheXMgdXAuIEFsbCB3ZSByZWFsbHkgbmVlZCBpcyB0byBo
YW5kbGUgdGhlIGNhc2UNCndoZXJlIHRoZSBjb25uZWN0aW9uIGlzIGJyb2tlbiBieSB0aGUgc2Vy
dmVyLg0KDQpTbyB0aGUgc3VnZ2VzdGlvbiB3b3VsZCBiZSB0aGF0IHdoZW4gdGhlIGNvbm5lY3Rp
b24gaXMgYnJva2VuLCB3ZSBzdGFydA0Kc2VuZGluZyBhIFNFUVVFTkNFIHBpbmcgaW4gb3JkZXIg
dG8gZmlndXJlIG91dCB3aGF0IGhhcHBlbmVkLCBhbmQNCndoZXRoZXIgd2UgbmVlZCB0byByZS1l
c3RhYmxpc2ggc3RhdGUuDQoNCk5vIG1vdW50IG9wdGlvbnMgbmVlZGVkLi4uDQoNCi0tIA0KVHJv
bmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
