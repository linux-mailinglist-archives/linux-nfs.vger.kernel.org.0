Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32538527526
	for <lists+linux-nfs@lfdr.de>; Sun, 15 May 2022 05:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiEODYF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 23:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiEODYE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 23:24:04 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2122.outbound.protection.outlook.com [40.107.95.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A752D1F9
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 20:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhG4lXJZv67Hed1C/DmffEDIk7N22Imo7D901eSSzhmencI14M58CvDjIs45xMOVSpgPSGQEUypoCjwxL0+RVVGmnnqGsi0vrud8zQyJOHCM/Pkar2LKwMph5rMP7sV9by9I+x1d3mh2iAEYXKrcpj4oMjaqO6yjC2fVoGnoFQuBaR8mkF0XGuATwankHLDbindlh/yM3XWJjYvHWzRsf0g4tdGG6txRMXKruNht4qkLc7GI1sGVomI5tHh0xFgrfH59wm8cOA/LkN3Rs5xm3V7Vc+7XcbTw9ME8B+yaLA9bc1Rnjm1hacY8twbezHleZehEjDetLyKdY8UgXQBbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbu7kFDyjaxPmGdTLOBPyd05TGRi36hJD0GVm4mH4vI=;
 b=Ldbvbx7MKgydAlV+uT6nLMWhCLdZqBsDHO8ZNiV2qFWq2Ke6YhXI43RPAdFXiG+y0vU4ufvI2QBwOZ4S2bbHi6VgG2xTHihPA8fN0KlU4120f0Abu0whNqUcdXxpno+JYqIYY+GmSZfWHACtjq/1wTqH5UE64KHquraM+4J4sz2v4lIoEl9R1KTU7h8KN+PNjfQJsvf1p2HxJF2olKfn4MTe82LqyRk7HtwB1KZqK0t4uaDosibPwh9+/r0nz5XkJfcBvJUjmMTauI7fzq4eLREeqMEbKhsRvzsWqbSw9UwFc0CJPbRPYhDHCsPfo9cTm8f3PDEFJku1azYXJSj9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbu7kFDyjaxPmGdTLOBPyd05TGRi36hJD0GVm4mH4vI=;
 b=DIqSmHeMYLOqgw8BRyb0pL8Yspm6FZUXcL3GXjdaQWQZK8qJv4ehkkXWlAHtObOb1pEE5i0m2ea1jDAabn3VKMkG2O+n6i66v3RnNENm8yFaHzC+C7YIjvRzJMqREbX2aH5ixRvmMGYDmNm6AcPl6+MHDooAh15wwM7gotM2UyQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MWHPR13MB1582.namprd13.prod.outlook.com (2603:10b6:300:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.10; Sun, 15 May
 2022 03:23:59 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%6]) with mapi id 15.20.5273.012; Sun, 15 May 2022
 03:23:58 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>
Subject: Re: [PATCH 0/6] Allow nfs4-acl-tools to access 'dacl' and 'sacl'
Thread-Topic: [PATCH 0/6] Allow nfs4-acl-tools to access 'dacl' and 'sacl'
Thread-Index: AQHYZ6IS7jvgNvakCU+hxxui/sa/Sq0fL6IAgAAXhAA=
Date:   Sun, 15 May 2022 03:23:57 +0000
Message-ID: <15c4602658aff025b6d84e2b9461378930cbd802.camel@hammerspace.com>
References: <20220514144436.4298-1-trondmy@kernel.org>
         <20220515015946.GB30004@fieldses.org>
In-Reply-To: <20220515015946.GB30004@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96c06a05-04a3-4654-831e-08da36225936
x-ms-traffictypediagnostic: MWHPR13MB1582:EE_
x-microsoft-antispam-prvs: <MWHPR13MB158286AE2F1258AAE100375AB8CC9@MWHPR13MB1582.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IbzVljPvG1Qva9vqQD99QOG0TJRP1Kx5chVuBv11FqEmiyuppjLBx88U8j5bCxc11I1yBoKfjO5VS9V2lyDdTtUcZv6LIhBu4d+EKVoMJoXZkxyCX7TkJd4Wn6PUIVeVQy1qOjefdZWwBkJQrAFDc4NGN4aQBnY1Ahw8O+s5Bmn5JNK9dVGiGwNKuc4KF27nb+yk25BmTbga3TMmuGnEW6cZSmKyOJaVZL27TM1Y3X7Awnynb76i8+n3f5iL4xY74UgDaWrNh22VZExAAq4IqnNT4suCAQQOQpq5IuJss6KHrb1qbDKXpWULKh4v5W9gpoiC2aG2UxwsMip8pvmjxhmvUIAY6zMkHOy7vefFpZvnOQYq0YaWmTJFrKwSlALbmh9CpHAocu4e7PW0uGBP6MtLgSCHlkncuPDJvL6L32FHIRoeCjt4rZO1nhvijUyrmoUzIWoNPudEzueL/X3YpAq+tCZoP/kSxaBsPxbV8rhtWzOwBBNNf+kshEQE0y9gdSCqvAmtrm8YCkq5NEQfDXZkiwdxeIHDiIo89qHrHbovZjoy4wYJDhKf3YkAjlVsVnxVUmJtfTMZ8S+oMt/Db9rZaFsBtpCohthDoSczdWXxTW+X1gIzP9n+ntbvOAZusX9qSqRSVwQ+0mohGa504yf89DGFnt3FP87H69G/i0cK70wsFF3xx2YJGku0mHE6lQcaKxGEUfWzS0uWkemf9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(4326008)(66446008)(8676002)(64756008)(66476007)(66556008)(8936002)(66946007)(76116006)(5660300002)(36756003)(2616005)(6486002)(71200400001)(86362001)(26005)(6506007)(186003)(38070700005)(38100700002)(2906002)(122000001)(54906003)(6512007)(83380400001)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEZ4RHZFdnRtaWFSVk5iNDJKL2QzQ3gyYkhiQ2FNRlM3ZlpGcjV1REdVSzNl?=
 =?utf-8?B?emErNXczd3ZCcnRBREFQZENWMDZkNDI3VlArQ0hrUE1PbmZqTnBjdm1YQzFS?=
 =?utf-8?B?eHk5cFliUnUxclBoQ2ZNQmMvRnhmMFNOM0xZNmVZRURMTjk4bmdJQmhoQkZ0?=
 =?utf-8?B?cWNDQ1FkSHhyWXpjcU1WaFc3YXhIRVJtRm9vQitVYlZqNWdYRTNNWm1SWUlx?=
 =?utf-8?B?WkNZdnlkVlFPOEFtMUpNUVJKNit2M0d5dGFLR1JFOGc2aFJEdXhrNHpRVFlt?=
 =?utf-8?B?WDRUeE9DVEx4Q0pFT3FmTTRSVis2cWVuWVhRNk5va1krNk1UaVVtVFhtUVRk?=
 =?utf-8?B?UHZHU1UyMkNGQ3d4YUNQS21Zbmpzd3RWOXIzbklYSVRMcnhwWGNxMVNJSUZQ?=
 =?utf-8?B?b1RFYUJLWWJzN01OcXFEQ2M0bURGdFRVVk9KTHJ0cDIzWENZYjZUdzdTREF2?=
 =?utf-8?B?L1h0RVVBRGNyQUVmUzYzK1AwK080cU16MUdJNDNic0FJQStHVjBYK0xwTVhz?=
 =?utf-8?B?UG4zQlBWQzZVMTdiakhYZWRSVGxpcmxtQjJRMkZqVXRodWNCQjlIMVZ6eC9W?=
 =?utf-8?B?WWtwYjN1WG5BM1BaUzY3ZE5oV1lyNW5PWHdaUmkzeFljYXdlYmwyWU0wK1Nr?=
 =?utf-8?B?RkhzZjJGbHVtQjZyT2dVT0crVVU0c2tMcXhTYTl5N2Q0TCtHS3lsTmVVREpO?=
 =?utf-8?B?T0hUK0pKUFdobU1CbzBldmtZcnFHSlZkdjMwQk9zVFQyYlBnWFVlZ2dORisz?=
 =?utf-8?B?NUZoOUVla2lqcnI3WHk2UDhUZUxHdVNRYm5RMVUwY1R1TUtoUEZMZDRoQzEv?=
 =?utf-8?B?aS9zU2ZYcURPZno4SjNjQTRRdk1NNlB4WHpXdENxSWVnNGpRaXFqOWhRNUVv?=
 =?utf-8?B?STVtMlNHMnRiaEhtaDg0bi8waE5mZnlwTzZTekFESUhFU1ZIL2laaHlyd3Vn?=
 =?utf-8?B?MHdmUzhWNzQxZmdra1o1TFNKcDhoYXJYd2g4WnN1cHZZNmJ1S1Z1RHpwclVn?=
 =?utf-8?B?QU84eVNxdE0xcU1RS1oxTlNxNnF1TUpFWHorV2k1MkVRZFRJeUJ5cmNRdkdS?=
 =?utf-8?B?MmVKRmpDdERVRWUvVVB5RmNSRjRVTG90TWJEV3JjOUFueE1TTUlTanBVSEJ6?=
 =?utf-8?B?ZDV6cEhMYW11VlhwWUZUTEVBUnVodFFTN3d0WEtyZjd0bTJIN1N4WWF4RnVG?=
 =?utf-8?B?ZnVsUGV1WFdvTit1Rlo1MUtvbmdWSjJnL01XYzNuVEI1eUlJSStZMzNwUDVB?=
 =?utf-8?B?WWpwaXBnYnlQMVhBdE92Z0dYRHR2aklZOEQ3Ritja01vcC9iUzBtYUdiZHdi?=
 =?utf-8?B?Ky9kb0UxNWFtVURFdnNMQmFTdUNWQnl3aGtYSVpsa1prcUNWNnJQZ1JKOFJm?=
 =?utf-8?B?T2t5cHJRK1JZQUN5NTZUbHROSmVleC9xQllMQnNZdWxFSGg5ZFV6Mmlud3p6?=
 =?utf-8?B?NUl4dG1xdmlIOVBUWTA1VDIzRGx4a3BjM2FBMW1zNFU3ZHhBK2VkMi83WUp5?=
 =?utf-8?B?N1RpWW9GZVowSlVzenZCTTJUb1VJa3IrakQ1Qzc2dFVyUjBaZGpVM3ZrZjVt?=
 =?utf-8?B?U1RPYlpJR2R6SGxvT0VJS3FDTGVsTDZCTzd5WWJ0bThUSVVpaW40RXBnTkpu?=
 =?utf-8?B?SnBtR3BRd0pvbmRhSExwUzdDM3RiVDZ1d1E5Qk5GelNLYzhkRStkekZKTFVy?=
 =?utf-8?B?dURFN2gvS0hKR1QwYTRKUTI1KzZRYm8rWmRrMi85cWFTc1NMYTlOUEpudnRJ?=
 =?utf-8?B?WUxSLzVWN0lBOVlPMjI2aGV1OFg3MWVVdThWcGpOYnV5RXlVUWFqYnJ5VWxB?=
 =?utf-8?B?RFVQZSt4aWZBcXkxQWpudzFleE16a1Nib01IWGZ5YWd1UFBEM2t4T3d6Mi8v?=
 =?utf-8?B?b3htMlQ2b3JuSHoxVW5mNTNDRTBLMmMyeTVkczBHaG5mbVFtcUJmNXM4ekhi?=
 =?utf-8?B?Q01UN0k3Sm5WREc2NlJlTUhBQkxkS294TnhtYVZoeHBOSGpZbDZJKzJFOXFi?=
 =?utf-8?B?Vi9FckJIeEZiZ01jYkdpZlU4djNkZ3NwdlRmYldHNHBLTUNUTHo3UUpoVWF6?=
 =?utf-8?B?eWFRWis0azR5VXVaWHhDLzdlSGZvYWRvcnVMdDd1bmQ3WHh1MUxjbFFlbG5j?=
 =?utf-8?B?QmFWVExPdnRqbExQNGhxYStNQ25sNmhMMEZsWDBaNnNyRDlSTmZOMWVqSVBm?=
 =?utf-8?B?SlZXcWJQNFh0NzduUnhabDZNRk5VVEp3MHVYcGI1MWoxWVJNUXVnRUovWm9h?=
 =?utf-8?B?WElIR24wbDBtZnB3N2tiNml6SXlGWC9HNHhBczZVd1RPKy9aZlNmamljcWdL?=
 =?utf-8?B?U3V3U3pULzVrSG1pTk9NVFphcmQxRmhnc1F0ZVp0RkhlVkl1bTNGZW4xcHVM?=
 =?utf-8?Q?suUHDju2BiNtQO+8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD83D9CA3A32DC4990BB00C7D3758C04@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c06a05-04a3-4654-831e-08da36225936
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2022 03:23:57.9722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+7chV4JmC8Uu6Cu6XpO4uGtBUqYDg43QD5iZiK/TgBf6fMu9fiBm0To311qm75yszzbka2bXvft+jR+lFephA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1582
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDIyLTA1LTE0IGF0IDIxOjU5IC0wNDAwLCBKLkJydWNlIEZpZWxkcyB3cm90ZToN
Cj4gT24gU2F0LCBNYXkgMTQsIDIwMjIgYXQgMTA6NDQ6MzBBTSAtMDQwMCwgdHJvbmRteUBrZXJu
ZWwub3JnwqB3cm90ZToNCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gDQo+ID4gVGhlIGZvbGxvd2luZyBwYXRjaCBzZXQgbWF0
Y2hlcyB0aGUga2VybmVsIHBhdGNoZXMgdG8gYWxsb3cgYWNjZXNzDQo+ID4gdG8NCj4gPiB0aGUg
TkZTdjQuMSAnZGFjbCcgYW5kICdzYWNsJyBhdHRyaWJ1dGVzLiBUaGUgY3VycmVudCBwYXRjaGVz
IGFyZQ0KPiA+IHZlcnkNCj4gPiBiYXNpYywgYWRkaW5nIHN1cHBvcnQgZm9yIGVuY29kaW5nL2Rl
Y29kaW5nIHRoZSBuZXcgYXR0cmlidXRlcyBvbmx5DQo+ID4gd2hlbg0KPiA+IHRoZSB1c2VyIHNw
ZWNpZmllcyB0aGUgJy0tZGFjbCcgb3IgJy0tc2FjbCcgZmxhZ3Mgb24gdGhlIGNvbW1hbmQNCj4g
PiBsaW5lLg0KPiANCj4gU2VlbXMgbGlrZSBhIHJlYXNvbmFibGUgdGhpbmcgdG8gZG8uDQo+IA0K
PiBJJ2QgcmF0aGVyIG5vdCBiZSByZXNwb25zaWJsZSBmb3IgbmZzNC1hY2wtdG9vbHMgYW55IGxv
bmdlciwgdGhvdWdoLg0KPiANCj4gLS1iLg0KDQpJIHN1c3BlY3RlZCB0aGF0IG1pZ2h0IGJlIHRo
ZSBjYXNlLCBidXQgc2luY2UgeW91IGhhdmVuJ3QgbWFkZSBhbnkNCmFubm91bmNlbWVudHMgYWJv
dXQgYW55Ym9keSBlbHNlIHRha2luZyBvdmVyLCBJIGZpZ3VyZWQgSSdkIHN0YXJ0IGJ5DQpzZW5k
aW5nIHRoZXNlIHRvIHlvdS4NCg0KU28gd2hvIHNob3VsZCB0YWtlIG92ZXIgdGhlIG5mczQtYWNs
LXRvb2xzIG1haW50YWluZXIgcm9sZT8gSXMgdGhhdA0Kc29tZXRoaW5nIFJlZCBIYXQgbWlnaHQg
YmUgaW50ZXJlc3RlZCBpbiBkb2luZywgb3Igc2hvdWxkIEkgdm9sdW50ZWVyDQp0byBkbyBpdCB3
aGlsZSB3ZSB3YWl0IGZvciBzb21lYm9keSB0byBnZXQgc28gZmVkIHVwIHRoYXQgdGhleSBkZWNp
ZGUNCnRvIHN0ZXAgaW4/DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K
