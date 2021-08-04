Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1563DF98F
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 04:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhHDCLH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 22:11:07 -0400
Received: from mail-dm6nam12on2095.outbound.protection.outlook.com ([40.107.243.95]:28641
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229892AbhHDCLG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Aug 2021 22:11:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLBVLEldy6pAvvfy/Y6Q/ogoruzkEaMhXUOdad76W2ZeBZaqaYeGJtbOwCTwgAllE5wUsQsuTmOCrBubQW9RDON9xn1F5X0pCjzI5DslsAbuRZY0riib87/kSE2bgpNBoggVk6ZrX6xZltslGUcxQF0wm00zIEXPfh557rkU9C18fDpEjKEOdHUPpGCRs+V3I/Q8AUykNwyeg02ECVUbNtqP5zr42uADPP9tKVGzgAcGMKKOsq/CxFCB3Kl3PfuIIja3zT4WhAbckZb7XY6JDUdz7h6CQ38gvwsWB3SSciYSRiHkTP4/D1AjX/BIiB5nz/mJhXPYSZ1iWYISeU88gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hLHWY/WodGeVrXcuYI4JCEF4si6+yvKsOP4hBCZSkI=;
 b=KGTurVTKsRLQeDC2BDL7psXGcd2iPIOdG5wgRPNqltyqfva9sq4t45mZPEphMmm5AtOgAK6AtX67+Kioq8N3XH2YOQe5N367RuiI5iGZGpBQ8IK/75T0eXlgdQEF1d1/TchHElTiAHI9Q9cXJ3lvefv9J8eqnzoc/SAyHuup+ad1A+GdBveCUC5kypsR0kFivxIqqcmb1ztk6TpSqVi1uf5EdsN6zbwDSUPvCbDtB4mtcLtLBJ8PqhznnlbMEGYgatfPRLFBOirYPYYNuToffWZg9Eq8VgMlTJcsiIFnKzEkA2FWX0PmRjgyEWJjtslMO3X1hnLxK9b+x+HKmLjGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hLHWY/WodGeVrXcuYI4JCEF4si6+yvKsOP4hBCZSkI=;
 b=HQAEMO8DghWJ9+n3aYD8yViKSJ4SNbNiQPW4UPvH3bnFCXTlx7VD3zd/sbKX3xqKJ+NTbPWFN647gdnhkQSA4e/gbkhmiCvQuVgAmzLQe0ETZGfELbPX/0e1F69baenH+aGC3tMtURo5+LsKX8bCfi0Z44HHHDFo0tH7MHOTWjg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3605.namprd13.prod.outlook.com (2603:10b6:610:2c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.10; Wed, 4 Aug
 2021 02:10:51 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%6]) with mapi id 15.20.4394.015; Wed, 4 Aug 2021
 02:10:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "mbenjami@redhat.com" <mbenjami@redhat.com>
CC:     "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: cto changes for v4 atomic open
Thread-Topic: cto changes for v4 atomic open
Thread-Index: AQHXhUZ9owuGm7b0CEqtoxaJkItc06tbmWqAgAao74CAAAokgIAACEIAgABE5YCAAAJWgIAABVuA
Date:   Wed, 4 Aug 2021 02:10:51 +0000
Message-ID: <61dc5d9363a42ed1a875f68a57c912c1745424d3.camel@hammerspace.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
         <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
         <20210803203051.GA3043@fieldses.org>
         <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
         <20210803213642.GA4042@fieldses.org>
         <CAKOnarkuUpd6waieqvWxJDRpLojwXqbNtAFz_bz6Q2k9Xrskgw@mail.gmail.com>
         <CAKOnarmdHgEBTUc87abMqBM_+3QP4JfdT8M9536WDZg-MGEKzA@mail.gmail.com>
In-Reply-To: <CAKOnarmdHgEBTUc87abMqBM_+3QP4JfdT8M9536WDZg-MGEKzA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45c9507a-9ffe-4ada-0dd1-08d956ed1552
x-ms-traffictypediagnostic: CH2PR13MB3605:
x-microsoft-antispam-prvs: <CH2PR13MB3605822AFC127BDF2EF06928B8F19@CH2PR13MB3605.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R6fUqbLhAmt77pF4n69/j7WjRL4BFvafYJSc+rwIY7rwiFoPeJ7S6S0+88ndqNoL3uWJR1sr6cWoNHmQ7HPoyrzXiVWwtIwEPRHqfhJNeahdc4Rafnb6ARQ7u10mO/5vpQNX5qiZrWX537AcPEfujQGdPO9HD+eiFzyGerT6pQFzieJfGjV8DzzU8owURBlExTpyzO3X132oVr/PebWMIc8bfeOM2iwP0zMNJCwHRHmX3vn0EnNh6FaEVMzsFm2paqCrOs4YKrtbonSAVsoyZDmmZA19cgczN449O/LWM+LQRfjzGWypqGgbFweLmeH7CVvt/vC8MClMeXteDucMr5qjs4QCW5/TX3+Nq77F5aOUYm/b7gLH2en37hXPuaJCBxjqO6PaNHYbbwv8oRN4ISL1uy677rpRN7cV/Pi/F9QJZO74vHjZ7zRtwnPavFxREjTfajc8hEMGwAdsPNP0PGkdElXNdSnhwAKh9swGM9N81GHDB0hWHvxClVSnzIRkyFIW5GR1FNa6aIybYu2eV4YyVSNwAlOhNzQROwzQEz6QedtcZf4Q9uq1dm3FSC0C35rXlR0wyzfLTj6UoB5/fmJpB3b5Qn6CavLX5OXLtyLpGmKo35KqoN0AK3qHLMEWUNjB6DJBGDxU2RM5Ko7EZ1Qu2ckEdRwney6ueg28D5neiUqMF13rTDCD+hMEJsINJXg0qZUAUDAJ9YAmNK70U1cKdbs2tPvHNA80KUqnYhKWEUWkgdBFPhHjnhrBVPugVeW+1TyifADOEoTuMb2RAQYM8QbxFCBG3iA5UTRN3RsHfBqXnAtqJO6G+rt0F8dN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(966005)(54906003)(66446008)(8936002)(66476007)(66556008)(64756008)(4326008)(6512007)(110136005)(83380400001)(76116006)(66946007)(38100700002)(316002)(38070700005)(122000001)(2906002)(5660300002)(19273905006)(86362001)(26005)(36756003)(8676002)(186003)(71200400001)(2616005)(53546011)(6506007)(6486002)(563064011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWZYWC9sK25HemY5bjhFNUxiT0JtcVIwM0hsSWJFdktUc1JVM0RkTFNGVC9a?=
 =?utf-8?B?ZG9LN0lCTE9PeXFNT29hNXlCQlYwc1hxVEFXbUZvaFI1RTZrYkJCSWErL0ZQ?=
 =?utf-8?B?QW1IbTM1RlBCSnhCRlYrdndER1JxS0o4Vyt0M056N3ZNd0p5TlZ0L2Uzb2M4?=
 =?utf-8?B?RmtKUmtJZUZBczhtZnoxcmQ5SXNiNzRQS0hZd2k0dkJIbHp3eTVPTU5VQUxL?=
 =?utf-8?B?NGZReTV6QjJCRXZSM2puR0R2aHFZUDBZcnRpbGhpYm9vdHlCSXB4Zi9RSisr?=
 =?utf-8?B?RXk2bHBoaG5Bdjk4OHVwN0k4cFE2VExFSmJsQ1ppNkpKWjJUY3JhODFEdnVR?=
 =?utf-8?B?TzBRUmFKN1lBY3VmR2F5UkdRUFUxUHNHbjU1U3BiTUU4b1F2RUVEdDlsdTZi?=
 =?utf-8?B?RE9SbGUvK3VOVjM1TlRJbXJBT2R3cllnRm1MeHRjOFR1L29YNWFWWkhDdmwx?=
 =?utf-8?B?OHFnbVdXMllRRkhYWjU2bmtmV3pZeVNXa1hRVmNzNkhNbWNaaDNJc1RHTVk3?=
 =?utf-8?B?cXVUbXRRLzZVS0N3UytsdWJHUEhObXZGWHh3UFFCYTJ1V3BaMWptdFB5by96?=
 =?utf-8?B?UEc3VkRvY2lVUDl6MVd3YnRBM0REQVVhRnNxRmZ3RVd0RS9hb0NLckJ2elda?=
 =?utf-8?B?S3luWnJaRERUd2ZDejI1WmdLK2JwVk9OQTV0SFREWmtzSHhBaHIwSE5HdWtQ?=
 =?utf-8?B?TkJNWTRVMVp1a1BsV1h1NUdjTWYydmkwa1hUK3E2ZkJPaHY0L3hyYjhwRmpC?=
 =?utf-8?B?a3pwZm1jN2p4R040cURNSnNuVUd6RWRUaWwveFhDb2FKenhOT01tQUhiblJP?=
 =?utf-8?B?WUJWaTFOeXdrNXNUbzFncFY2dmFZMEdRVHVvN25EL014Q3lNN29VcFBKaXVP?=
 =?utf-8?B?blk1NjFtTHErcXhyY24zUFd6azE5NS9Belh6QkRmbVMrRmVoMndVZGJhVlNC?=
 =?utf-8?B?WEZFdXFGQVZvNTRSWjdwbmI1cFFnOXEvc3Iyb1pYQWxaYTJaeDU3ZmxzVzA2?=
 =?utf-8?B?YTI4bE15M05tek5sTk5tb2RucWlRQlhyb1I5M0NTa3pIZDVNOHZvdXprODMx?=
 =?utf-8?B?cHhmTkpCU2lqdGVRY2RyUFRMWElIdElpQ3BCc2xjazAxYnlZU29jcnVGazV4?=
 =?utf-8?B?UGtwSnlWSHB0bGRkTkN1RXREWmRYS2FuU1VHUm42NVk4VDZFYXhHa3V3RW90?=
 =?utf-8?B?UHgwaTNtRXFuNFVzRDdRRElLUHgzRm9ZOEpIUmtNU043RkxYYzlWdEU3K1pL?=
 =?utf-8?B?aXJaT2hHSVBkNjBPcWRFWmd3cmZ6RFBsVnFmSGQrWkVBMjA3dlFOZ0I2ak02?=
 =?utf-8?B?cnpyZjd5T2pqVXZvWDhXcGZLZmxUZExoYnBWTDkzSmxnZ1VKT0E2ODJpM1di?=
 =?utf-8?B?andVMms4RFp5WUNrc3JKdWgrajFnRTdJNzl3TTZIT2IwQmRUcU1JNktZS1lI?=
 =?utf-8?B?d01xQXhIRExDcTZ1RjB3MzdIL0RVR3loOFQvVjhRUXB4S2NyUEhhYm1zd0tK?=
 =?utf-8?B?WVBnUDRkd213NnplczNLV1JFbGp5NTZLY1IrdlVoWGcwZkkrZzFlNWY4Tzdt?=
 =?utf-8?B?M2k3ZWxkRmtMSXlTcUZNTnVKN2JCWlErL0NZR241MDFmQjlRKzFiUnRPcWVm?=
 =?utf-8?B?V015S0hHRXNydW5BajA1K2lHNjVZVlBReEFGTE9EMXhqeFdUb2tMQXBheEZs?=
 =?utf-8?B?cUNSOTV5VC9KZHBNT000NURFdzBZQnN4K1JvSEh0bFE4S2FwdWcrWFRWQ25m?=
 =?utf-8?Q?DDpP0h+tPg33NRGVC1OG+IdSmOF0k0ewujOXu9Z?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFC0E070A37AA44E85F59CDCE6FBF566@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c9507a-9ffe-4ada-0dd1-08d956ed1552
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 02:10:51.2949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xekRpEfdpsEXg+IecHegbntyrqN9i7WbQwEYXpGhAYZZBjCQwR9iyFTdWtPLHYQKlXTvzoTUL25WHxavDg7eyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3605
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCk9uIFR1ZSwgMjAyMS0wOC0wMyBhdCAyMTo1MSAtMDQwMCwgTWF0dCBCZW5qYW1pbiB3cm90
ZToNCj4gKHdobyBoYXZlIHBlcmZvcm1lZCBhbiBvcGVuKQ0KPiANCj4gT24gVHVlLCBBdWcgMywg
MjAyMSBhdCA5OjQzIFBNIE1hdHQgQmVuamFtaW4gPG1iZW5qYW1pQHJlZGhhdC5jb20+DQo+IHdy
b3RlOg0KPiA+IA0KPiA+IEkgdGhpbmsgaXQgaXMgaG93IGNsb3NlLXRvLW9wZW4gaGFzIGJlZW4g
dHJhZGl0aW9uYWxseSB1bmRlcnN0b29kLsKgDQo+ID4gSQ0KPiA+IGRvIG5vdCBiZWxpZXZlIHRo
YXQgY2xvc2UtdG8tb3BlbiBpbiBhbnkgd2F5IGltcGxpZXMgYSBzaW5nbGUNCj4gPiB3cml0ZXIs
DQo+ID4gcmF0aGVyIGl0IHNldHMgdGhlIGNvbnNpc3RlbmN5IGV4cGVjdGF0aW9uIGZvciBhbGwg
cmVhZGVycy4NCj4gPiANCg0KT0suIEknbGwgYml0ZSwgZGVzcGl0ZSB0aGUgb2J2aW91cyB0cm9s
bC1iYWl0Li4uDQoNCg0KY2xvc2UtdG8tb3BlbiBpbXBsaWVzIGEgc2luZ2xlIHdyaXRlciBiZWNh
dXNlIGl0IGlzIGltcG9zc2libGUgdG8NCmd1YXJhbnRlZSBvcmRlcmluZyBzZW1hbnRpY3MgaW4g
UlBDLiBZb3UgY291bGQsIGluIHRoZW9yeSwgZG8gc28gYnkNCnNlcmlhbGlzaW5nIG9uIHRoZSBj
bGllbnQsIGJ1dCBub25lIG9mIHVzIGRvIHRoYXQgYmVjYXVzZSB3ZSBjYXJlIGFib3V0DQpwZXJm
b3JtYW5jZS4NCg0KSWYgeW91IGRvbid0IHNlcmlhbGlzZSBiZXR3ZWVuIGNsaWVudHMsIHRoZW4g
aXQgaXMgdHJpdmlhbCAoYW5kIEknbQ0Kc2VyaW91c2x5IHRpcmVkIG9mIHBlb3BsZSB3aG8gd2hp
bmUgYWJvdXQgdGhpcykgdG8gcmVwcm9kdWNlIHJlYWRzIHRvDQpmaWxlIGFyZWFzIHRoYXQgaGF2
ZSBub3QgYmVlbiBmdWxseSBzeW5jZWQgdG8gdGhlIHNlcnZlciwgZGVzcGl0ZQ0KaGF2aW5nIGRh
dGEgb24gdGhlIGNsaWVudCB0aGF0IGlzIHdyaXRpbmcuIGkuZS4gdGhlIHJlYWRlciBzZWVzIGhv
bGVzDQp0aGF0IG5ldmVyIGV4aXN0ZWQgb24gdGhlIGNsaWVudCB0aGF0IHdyb3RlIHRoZSBkYXRh
Lg0KVGhlIHJlYXNvbiBpcyB0aGF0IHRoZSB3cml0ZXMgZ290IHJlLW9yZGVyZWQgZW4gcm91dGUg
dG8gdGhlIHNlcnZlciwNCmFuZCBzbyByZWFkcyB0byB0aGUgYXJlYXMgdGhhdCBoYXZlIG5vdCB5
ZXQgYmVlbiBmaWxsZWQgYXJlIHNob3dpbmcgdXANCmFzIGhvbGVzLg0KDQpTbywgbm8sIHRoZSBj
bG9zZS10by1vcGVuIHNlbWFudGljcyBkZWZpbml0ZWx5IGFwcGx5IHRvIGJvdGggcmVhZGVycw0K
YW5kIHdyaXRlcnMuDQoNCj4gPiBNYXR0DQo+ID4gDQo+ID4gT24gVHVlLCBBdWcgMywgMjAyMSBh
dCA1OjM2IFBNIGJmaWVsZHNAZmllbGRzZXMub3JnDQo+ID4gPGJmaWVsZHNAZmllbGRzZXMub3Jn
PiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gT24gVHVlLCBBdWcgMDMsIDIwMjEgYXQgMDk6MDc6MTFQ
TSArMDAwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIDIwMjEtMDgt
MDMgYXQgMTY6MzAgLTA0MDAsIEouIEJydWNlIEZpZWxkcyB3cm90ZToNCj4gPiA+ID4gPiBPbiBG
cmksIEp1bCAzMCwgMjAyMSBhdCAwMjo0ODo0MVBNICswMDAwLCBUcm9uZCBNeWtsZWJ1c3QNCj4g
PiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIEZyaSwgMjAyMS0wNy0zMCBhdCAwOToyNSAt
MDQwMCwgQmVuamFtaW4gQ29kZGluZ3Rvbg0KPiA+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4g
PiA+IEkgaGF2ZSBzb21lIGZvbGtzIHVuaGFwcHkgYWJvdXQgYmVoYXZpb3IgY2hhbmdlcyBhZnRl
cjoNCj4gPiA+ID4gPiA+ID4gNDc5MjE5MjE4ZmJlDQo+ID4gPiA+ID4gPiA+IE5GUzoNCj4gPiA+
ID4gPiA+ID4gT3B0aW1pc2UgYXdheSB0aGUgY2xvc2UtdG8tb3BlbiBHRVRBVFRSIHdoZW4gd2Ug
aGF2ZQ0KPiA+ID4gPiA+ID4gPiBORlN2NCBPUEVODQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiBCZWZvcmUgdGhpcyBjaGFuZ2UsIGEgY2xpZW50IGhvbGRpbmcgYSBSTyBvcGVuIHdvdWxk
DQo+ID4gPiA+ID4gPiA+IGludmFsaWRhdGUNCj4gPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4g
PiA+IHBhZ2VjYWNoZSB3aGVuIGRvaW5nIGEgc2Vjb25kIFJXIG9wZW4uDQo+ID4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gPiBOb3cgdGhlIGNsaWVudCBkb2Vzbid0IGludmFsaWRhdGUgdGhlIHBh
Z2VjYWNoZSwgdGhvdWdoDQo+ID4gPiA+ID4gPiA+IHRlY2huaWNhbGx5DQo+ID4gPiA+ID4gPiA+
IGl0IGNvdWxkDQo+ID4gPiA+ID4gPiA+IGJlY2F1c2Ugd2Ugc2VlIGEgY2hhbmdlYXR0ciB1cGRh
dGUgb24gdGhlIFJXIE9QRU4NCj4gPiA+ID4gPiA+ID4gcmVzcG9uc2UuDQo+ID4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gPiBJIGZlZWwgdGhpcyBpcyBhIGdyZXkgYXJlYSBpbiBDVE8gaWYgd2Un
cmUgYWxyZWFkeQ0KPiA+ID4gPiA+ID4gPiBob2xkaW5nIGFuDQo+ID4gPiA+ID4gPiA+IG9wZW4u
DQo+ID4gPiA+ID4gPiA+IERvIHdlDQo+ID4gPiA+ID4gPiA+IGtub3cgaG93IHRoZSBjbGllbnQg
b3VnaHQgdG8gYmVoYXZlIGluIHRoaXMgY2FzZT/CoCBTaG91bGQNCj4gPiA+ID4gPiA+ID4gdGhl
DQo+ID4gPiA+ID4gPiA+IGNsaWVudCdzIG9wZW4NCj4gPiA+ID4gPiA+ID4gdXBncmFkZSB0byBS
VyBpbnZhbGlkYXRlIHRoZSBwYWdlY2FjaGU/DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiBJdCdzIG5vdCBhICJncmV5IGFyZWEgaW4gY2xvc2UtdG8tb3BlbiIgYXQg
YWxsLiBJdCBpcyB2ZXJ5DQo+ID4gPiA+ID4gPiBjdXQgYW5kDQo+ID4gPiA+ID4gPiBkcmllZC4N
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSWYgeW91IG5lZWQgdG8gaW52YWxpZGF0ZSB5b3Vy
IHBhZ2UgY2FjaGUgd2hpbGUgdGhlIGZpbGUgaXMNCj4gPiA+ID4gPiA+IG9wZW4sDQo+ID4gPiA+
ID4gPiB0aGVuDQo+ID4gPiA+ID4gPiBieSBkZWZpbml0aW9uIHlvdSBhcmUgaW4gYSBzaXR1YXRp
b24gd2hlcmUgdGhlcmUgaXMgYSB3cml0ZQ0KPiA+ID4gPiA+ID4gYnkNCj4gPiA+ID4gPiA+IGFu
b3RoZXINCj4gPiA+ID4gPiA+IGNsaWVudCBnb2luZyBvbiB3aGlsZSB5b3UgYXJlIHJlYWRpbmcu
IFlvdSdyZSBjbGVhcmx5IG5vdA0KPiA+ID4gPiA+ID4gZG9pbmcNCj4gPiA+ID4gPiA+IGNsb3Nl
LQ0KPiA+ID4gPiA+ID4gdG8tb3Blbi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBEb2N1bWVudGF0
aW9uIGlzIHJlYWxseSB1bmNsZWFyIGFib3V0IHRoaXMgY2FzZS7CoCBFdmVyeQ0KPiA+ID4gPiA+
IGRlZmluaXRpb24gb2YNCj4gPiA+ID4gPiBjbG9zZS10by1vcGVuIHRoYXQgSSd2ZSBzZWVuIHNh
eXMgdGhhdCBpdCByZXF1aXJlcyBhIGNhY2hlDQo+ID4gPiA+ID4gY29uc2lzdGVuY3kNCj4gPiA+
ID4gPiBjaGVjayBvbiBldmVyeSBhcHBsaWNhdGlvbiBvcGVuLsKgIEkndmUgbmV2ZXIgc2VlbiBv
bmUgdGhhdA0KPiA+ID4gPiA+IHNheXMgIm9uDQo+ID4gPiA+ID4gZXZlcnkgb3BlbiB0aGF0IGRv
ZXNuJ3Qgb3ZlcmxhcCB3aXRoIGFuIGFscmVhZHktZXhpc3Rpbmcgb3Blbg0KPiA+ID4gPiA+IG9u
IHRoYXQNCj4gPiA+ID4gPiBjbGllbnQiLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoZXkgKnVz
dWFsbHkqIGFsc28gcHJlZmFjZSB0aGF0IGJ5IHNheWluZyB0aGF0IHRoaXMgaXMNCj4gPiA+ID4g
PiBtb3RpdmF0ZWQgYnkNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiB1c2UgY2FzZSB3aGVyZSBv
cGVucyBkb24ndCBvdmVybGFwLsKgIEJ1dCBpdCdzIG5ldmVyIG1hZGUNCj4gPiA+ID4gPiBjbGVh
ciB0aGF0DQo+ID4gPiA+ID4gdGhhdCdzIHBhcnQgb2YgdGhlIGRlZmluaXRpb24uDQo+ID4gPiA+
ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBJJ20gbm90IGZvbGxvd2luZyB5b3VyIGxvZ2ljLg0KPiA+
ID4gDQo+ID4gPiBJdCdzIGp1c3QgYSBxdWVzdGlvbiBvZiB3aGF0IGV2ZXJ5IHNvdXJjZSBJIGNh
biBmaW5kIHNheXMgY2xvc2UtDQo+ID4gPiB0by1vcGVuDQo+ID4gPiBtZWFucy7CoCBFLmcuLCBO
RlMgSWxsdXN0cmF0ZWQsIHAuIDI0OCwgIkNsb3NlLXRvLW9wZW4gY29uc2lzdGVuY3kNCj4gPiA+
IHByb3ZpZGVzIGEgZ3VhcmFudGVlIG9mIGNhY2hlIGNvbnNpc3RlbmN5IGF0IHRoZSBsZXZlbCBv
ZiBmaWxlDQo+ID4gPiBvcGVucyBhbmQNCj4gPiA+IGNsb3Nlcy7CoCBXaGVuIGEgZmlsZSBpcyBj
bG9zZWQgYnkgYW4gYXBwbGljYXRpb24sIHRoZSBjbGllbnQNCj4gPiA+IGZsdXNoZXMgYW55DQo+
ID4gPiBjYWNoZWQgY2hhbmdzIHRvIHRoZSBzZXJ2ZXIuwqAgV2hlbiBhIGZpbGUgaXMgb3BlbmVk
LCB0aGUgY2xpZW50DQo+ID4gPiBpZ25vcmVzDQo+ID4gPiBhbnkgY2FjaGUgdGltZSByZW1haW5p
bmcgKGlmIHRoZSBmaWxlIGRhdGEgYXJlIGNhY2hlZCkgYW5kIG1ha2VzDQo+ID4gPiBhbg0KPiA+
ID4gZXhwbGljaXQgR0VUQVRUUiBjYWxsIHRvIHRoZSBzZXJ2ZXIgdG8gY2hlY2sgdGhlIGZpbGUN
Cj4gPiA+IG1vZGlmaWNhdGlvbg0KPiA+ID4gdGltZS4iDQo+ID4gPiANCj4gPiA+ID4gVGhlIGNs
b3NlLXRvLW9wZW4gbW9kZWwgYXNzdW1lcyB0aGF0IHRoZSBmaWxlIGlzIG9ubHkgYmVpbmcNCj4g
PiA+ID4gbW9kaWZpZWQgYnkNCj4gPiA+ID4gb25lIGNsaWVudCBhdCBhIHRpbWUgYW5kIGl0IGFz
c3VtZXMgdGhhdCBmaWxlIGNvbnRlbnRzIG1heSBiZQ0KPiA+ID4gPiBjYWNoZWQNCj4gPiA+ID4g
d2hpbGUgYW4gYXBwbGljYXRpb24gaXMgaG9sZGluZyBpdCBvcGVuLg0KPiA+ID4gPiBUaGUgcG9p
bnQgY2hlY2tzIGV4aXN0IGluIG9yZGVyIHRvIGRldGVjdCBpZiB0aGUgZmlsZSBpcyBiZWluZw0K
PiA+ID4gPiBjaGFuZ2VkDQo+ID4gPiA+IHdoZW4gdGhlIGZpbGUgaXMgbm90IG9wZW4uDQo+ID4g
PiA+IA0KPiA+ID4gPiBMaW51eCBkb2VzIG5vdCBoYXZlIGEgcGVyLWFwcGxpY2F0aW9uIGNhY2hl
LiBJdCBoYXMgYSBwYWdlDQo+ID4gPiA+IGNhY2hlIHRoYXQNCj4gPiA+ID4gaXMgc2hhcmVkIGFt
b25nIGFsbCBhcHBsaWNhdGlvbnMuIEl0IGlzIGltcG9zc2libGUgZm9yIHR3bw0KPiA+ID4gPiBh
cHBsaWNhdGlvbnMNCj4gPiA+ID4gdG8gb3BlbiB0aGUgc2FtZSBmaWxlIHVzaW5nIGJ1ZmZlcmVk
IEkvTywgYW5kIHlldCBzZWUgZGlmZmVyZW50DQo+ID4gPiA+IGNvbnRlbnRzLg0KPiA+ID4gDQo+
ID4gPiBSaWdodCwgc28gYmFzZWQgb24gdGhlIGRlc2NyaXB0aW9ucyBsaWtlIHRoZSBvbmUgYWJv
dmUsIEkgd291bGQNCj4gPiA+IGhhdmUNCj4gPiA+IGV4cGVjdGVkIGJvdGggYXBwbGljYXRpb25z
IHRvIHNlZSBuZXcgZGF0YSBhdCB0aGF0IHBvaW50Lg0KPiA+ID4gDQo+ID4gPiBNYXliZSB0aGF0
J3Mgbm90IHByYWN0aWNhbCB0byBpbXBsZW1lbnQuwqAgSXQnZCBiZSBuaWNlIGF0IGxlYXN0DQo+
ID4gPiBpZiB0aGF0DQo+ID4gPiB3YXMgZXhwbGljaXQgaW4gdGhlIGRvY3VtZW50YXRpb24uDQo+
ID4gPiANCj4gPiA+IC0tYi4NCj4gPiA+IA0KPiA+IA0KPiA+IA0KPiA+IC0tDQo+ID4gDQo+ID4g
TWF0dCBCZW5qYW1pbg0KPiA+IFJlZCBIYXQsIEluYy4NCj4gPiAzMTUgV2VzdCBIdXJvbiBTdHJl
ZXQsIFN1aXRlIDE0MEENCj4gPiBBbm4gQXJib3IsIE1pY2hpZ2FuIDQ4MTAzDQo+ID4gDQo+ID4g
aHR0cDovL3d3dy5yZWRoYXQuY29tL2VuL3RlY2hub2xvZ2llcy9zdG9yYWdlDQo+ID4gDQo+ID4g
dGVsLsKgIDczNC04MjEtNTEwMQ0KPiA+IGZheC7CoCA3MzQtNzY5LTg5MzgNCj4gPiBjZWwuwqAg
NzM0LTIxNi01MzA5DQo+IA0KPiANCj4gDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K
