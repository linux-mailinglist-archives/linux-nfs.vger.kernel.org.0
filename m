Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F0552E10A
	for <lists+linux-nfs@lfdr.de>; Fri, 20 May 2022 02:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbiETAS3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 May 2022 20:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245677AbiETAS3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 May 2022 20:18:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2098.outbound.protection.outlook.com [40.107.243.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961946B09A;
        Thu, 19 May 2022 17:18:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ew8P2tJrOK9dyi5em9E8b2v72FvmDcbB9SMLt1OKiuNm1H8Na3plfc9bN9eHPagfMjq+/n3tnLm9U7nBP0zdHK9D050Rx3+Re9ffEdl8u+4GIpTX/a5jH4kWNqdk4+XV+RIvOyRKWQXB5b5Vi+ZuFhkGXgzA/mmU8fTH8UQXU9XjAX2A/UGjL4ubTZcTezxmRo3MwjZHxe4j/fdYeEiYycETWSzaLG8TvbcnumGOuREqPs4WJuzh/ggjks8Qmi7FoyyfBsFegBQx3pbbWfaKkyRCR647xdTuEdtW8oWO0uOwdaiMFG/ngsiiRygIO5NQ5mRwYF1WMl+POC44JcGoig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkcOdd0WkGvWIerdVNSzFoVe4AaNhGxxKcZ3Yfe8DdE=;
 b=ZygMAK3z5lhL2tQsr7fzGaRbBdhgnFaIml2+Wsi6CdjfR5g/GeETOxNDoRoWqxxqo6h9d/ZPnDCnnpPNP0iPQx2DMFO0eayd3WLGEKSEXyHwEd3Jze9bLVGyg9wLCAmn5xeQIERDD4PL4rVbel231zY96KjIIfrdL/igKBglUmv2+LJ08wmvuJcS/yQm1N5sFdVa2qdyXHxQ/HGrP/JYRG9OTx2u0741XlVo3qeir3aZ5ywyVKUM3g3TvTXQjkZP1uS38jpE8zWUD+hBzH3pa1BR+iYP+XGWE/aKbe0uEqSVLIGMrVeKwxYO+BMwTMNd2aj0foGwwADPBiEy2YK/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkcOdd0WkGvWIerdVNSzFoVe4AaNhGxxKcZ3Yfe8DdE=;
 b=Fq/Khq4tVyC8gsry/H5EDUKcYr6Q9xmpqAcHOgCR7D/oEFtODoB0SJBYtIJS09DN2G46mFoyj77MuOaRBcYy+LrS7do/39OsnpTjJCDwCGiPckQt9ZMUTjNOm/fBJcDN4J1k66rWhhP+93lovSA5STNHSjRT+83++4gYvwk6ZXY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH7PR13MB5528.namprd13.prod.outlook.com (2603:10b6:510:131::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.12; Fri, 20 May
 2022 00:18:24 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%6]) with mapi id 15.20.5293.007; Fri, 20 May 2022
 00:18:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "javier.abrego.lorente@gmail.com" <javier.abrego.lorente@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] FS: nfs: removed goto statement
Thread-Topic: [PATCH] FS: nfs: removed goto statement
Thread-Index: AQHYa9MBSjk/aQO7f0KHHjBbxLKzjK0m5pQA
Date:   Fri, 20 May 2022 00:18:24 +0000
Message-ID: <e0e87e36a886ddc79ae68456b247632f00ebd39b.camel@hammerspace.com>
References: <20220519225115.35431-1-javier.abrego.lorente@gmail.com>
In-Reply-To: <20220519225115.35431-1-javier.abrego.lorente@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c0129d3-1509-4438-6816-08da39f6411f
x-ms-traffictypediagnostic: PH7PR13MB5528:EE_
x-microsoft-antispam-prvs: <PH7PR13MB5528AFD0E0071A1D680FD0BEB8D39@PH7PR13MB5528.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hE4X5wM9/3RI2QS2tNkVlp4ucDaZlIG/8FTYPj4NChSoNdQDLS0LEe+FWZ0gbkL+C88mL1Smz+TuZWz5+RcSSv2jsabN/9D2Y3EUqlYEYRARJ3drMouYrXsif8WrS55sYQ7o5SsfQo24M0WWTJcRe3H6P5Aif/9G0mgrBia9KLPY4srGMo7nQoe4+iRmlwtPA5sUP1smJMuctn1V9bjj1j/+OLKPNMGG9rj4bu6lDgno6N+SH/jJ3rS92cyi+x37uKyaC4xfcZMFR+dg67AMHW5GnvB30KpkCHNMajXZNo0x/SxStJ+XfOVMTkhrDJIuWUpbFtM/SIMXTw6REEOGhISqr7CA2Wc2bhsnYIpU9TU2l0c7+7RvnC31ltyjXWsLkH0DOkJ6VolCLQoGs0LzhszuCGc9w8PLb2/+f8ov3wfCPMH1yrW9+Nb7fJp9F+lqjdte/A0+PqD1r4CoAh79BYyWHAjf7PaajkSJyY+wql2wHmG1gxEnqQmltGJbpYsryGQOtP8lt17y+EPNwOIJ4GEhxZnD8Ady+cYdtaJSD1maCeyPU1ZTYHTdSnHQxyl/aYZ/4tQdVlGfQJLCtzUeORx3jdwKLXjXxgDNMH0uYA8qTB9EandtsfLUcDjyEApcp85g/tQCNmmzbxMLWWqP1qWPU7KOfWH/jtz2Ah438qQ0+I0yiwuO8No0UW5/7gd117wrq/rTnckaASwytikYO6kBTelGMGxFqI8+zlEQ2wdOzRlM+/VbbeijBpT69NVx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(6506007)(2616005)(26005)(508600001)(5660300002)(6512007)(36756003)(83380400001)(2906002)(86362001)(122000001)(66556008)(4326008)(76116006)(110136005)(38100700002)(54906003)(66446008)(66476007)(64756008)(316002)(8936002)(71200400001)(38070700005)(186003)(6486002)(966005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnJheFZjaU9RcjZKSERQc0JXQVAvTFBnWnBuZE5vaGQrSWRxSE1lcXZQTDBr?=
 =?utf-8?B?cnVMUGMwdGc0L1VTanpGN0RySTNabFZjU2krY3JJNGFXTWdDREZsWmRMSUUy?=
 =?utf-8?B?Yi9TQ0tqbmFscFA0YVFwM1U5dmxET0RkL1YyZGNTSTdGVCtXVGk0bkJ0byts?=
 =?utf-8?B?SEFSRHZQM2dSZGF0K2tXTGVZdkY4Um5hYm1BMnZRc1l1Q0JvUHNGb3FaaEE2?=
 =?utf-8?B?ZklTc2cyWGxITGtwaEVuL1U5UTdYL0VQZFBhMW4wblA2Q1RqSm9pT3E1eGJl?=
 =?utf-8?B?QThlOEJORTVmNWtLMGsvOGpMVU43azlOM1B3aGd2RnJzOHJpQzB6K1ROc0RE?=
 =?utf-8?B?WVVEeWFsdk1hZDBCcndad3lIbE02ZjIvN0UzOWdMQXE2V2dsTitYd1BLTGhm?=
 =?utf-8?B?OXl4YzBuMXZzUmxHcHFnU0xwTExjeTA3NFBLU2cxOUtlWTJDanl2YnZ4RU5M?=
 =?utf-8?B?cng0ZnJNSFBGTDlXa0Q3ODRaTEpWNk1xR2liQkVLc24ycXVXa0p6S0o5b0Jv?=
 =?utf-8?B?UUR0c1Z5RlIrZFZHVkczK3hFMjl4YkdjS3ZWVXI5RjZwZE5rM2JlZWNhOWVG?=
 =?utf-8?B?dVpZRVRYYmo0T29pN3pTQTk5bTBoQnFQZElhUzhrMXluM3ZWemhCVTVGWUl4?=
 =?utf-8?B?bGdvb1YxN293bHkrMU9QMFlVU1hRQXlQNlowdTl6MjdxRDBMYlpWdUxHMDda?=
 =?utf-8?B?c3BFRzgyTS9EcGg2allaSVQvcEUraXpTOSsvN3Z4U0xsWjVYeGdnMVVTQy9K?=
 =?utf-8?B?MVptZCthME1xQ25USE9henJIRWVKeVJWWUtuRnc2TFJTSk04elB5QzR1dm5a?=
 =?utf-8?B?ZWFLMGorRnpxK0FyZytKYlp5NUVCV2hWM1d3VzVLMDJoTjF5NG1wL2puekQw?=
 =?utf-8?B?YkNGOXBaRVpMVktWaXdFdDFtWnIrNlhjVjRhbEtjM1BjWnk4UVhya2JGWEk0?=
 =?utf-8?B?bUFDVlJYZ3N4c0IyVjdVSHZoNTVPR09aVEtZaVhEVmJCbWg2WkpUQ0t4RFI1?=
 =?utf-8?B?aHg2M2dNaWNWMUdBTHlnOWtNWmlUcWtHeWcxanJ1Z0U5eWt1ZFFjMmd6dHI4?=
 =?utf-8?B?ZTkycGhLdkxUZmF2NVlDRlNXY1RFMjBaV0lnbXBqMkxXRkl5Y2RtRHFzTm96?=
 =?utf-8?B?dktRdW1GYmF4ZUw1aStCWU80WWtxcW5yaWdpYytrSkFTdXBPT2pVN1BnVElE?=
 =?utf-8?B?VGcvZ0lIUFJVT0lPMUFHOU9DbEdHZjR6UU9wWTdaZ3U0b3VWeG5XWkxpMXVo?=
 =?utf-8?B?ejZyQTVsbEdzNU5xLy9hMDRZeHkrcU1RTU5PWW1BZkNPcDlMVzZSYS81alIw?=
 =?utf-8?B?c2xPanVkeVdqTGRvTUhrRXNHY1Q4bHhQaXBkeFdLYzlkZFpORjFFdUNkb29C?=
 =?utf-8?B?OHhQdUJhc2lOM1hSWVpaZFFNbFptV3RYbi9xZi9VZVBCc05LR3ordDNzODhk?=
 =?utf-8?B?ZlZhbUFWZi9aa1AzUnhMa1pQUjJLTjdTTk13TXpyRS83ZEJxa1pvOFV1eGVs?=
 =?utf-8?B?MlZCUkdrOXVIT25FdFQ2SWpLQVpWZ1FQWlhlS2s5NXJxMDhxbWZ5NzFQT1F5?=
 =?utf-8?B?aUhKcUptakdnWjFvaXNHTjdybXZkMWR1ZWw2cHRHSlRlU24zNXMzUDc1ZE5R?=
 =?utf-8?B?U0J1ZUhXaUN5TmhvYkJTayt4ektGb2lZMXVmZDlIZ1F1NHJiTkwrWmdaSHlG?=
 =?utf-8?B?aCtmbHkrTElCaDNoSElnY0dTaHh4WTRBRFZxZFA2bnY4dUJpOXp6TVE1cmZP?=
 =?utf-8?B?bEFHS0h6UEpPcW9vTWg2Y01yQUxPcitXb0V4aloyd3B5dmYwbnErRTNCeTZI?=
 =?utf-8?B?eTBmY1NhSnE0L09MMXhVb3A3bkU2ODNYM0ZscGNmbjI1N2RFSVU2aVlBS0dl?=
 =?utf-8?B?T3FvNTBoM3c1RkpaQjVGNW80dUVJUnZZaVQ0QlRFTGlYcGVhMHc3UXd3cjd4?=
 =?utf-8?B?aWVBU2Vjd1loMWtrMVk0UHlJb0dtcitGS1Jvby90ZTZnckhXZG9BUXMyK29t?=
 =?utf-8?B?MWM4VXl5VFBBTGg4WDNpSitmQlQ0YnNsSnJjR0RNQkM4WHdEbWQyY3VQaHFO?=
 =?utf-8?B?ems2bWdNSk1KUm4wb3pPYVllVU5mekx2Q0xZMjlISXRlODhteTVEUGVad0dE?=
 =?utf-8?B?YTFYNTFIcVVWQXNqR0dEOVNZc2VNZXdrTHltN3ZnQ3JQYnZoU3p2eDVkallQ?=
 =?utf-8?B?Nm9WekRiMW5TeXUxYkl0UXdrWWk3cWVLSitEVmhOck80ZTgzdU5zcU52MC9L?=
 =?utf-8?B?RnhGK1EwYW9jVVBySjVxcklIM3l0UjNBZUFueXl6bzNBODY2WkdhVzZjS1FG?=
 =?utf-8?B?RytlMWhMY0FwVnRZYzlSVEloL2htVklhaks5WVk5ekFwbXJUNkNRekNpL2Zq?=
 =?utf-8?Q?HwX8mJuq2H6wNvNk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3A4DA17292F5149ACD03BE115057F51@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0129d3-1509-4438-6816-08da39f6411f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 00:18:24.3505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 529LEJHuJVuUXpeIkI8cA0wPsVGmGko9hqH1VX24EfzGjDR8Xvr2WITQFMFDWuj2eFdMWpxbYvOv3Dyql7Onbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5528
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTA1LTIwIGF0IDAwOjUxICswMjAwLCBKYXZpZXIgQWJyZWdvIHdyb3RlOgo+
IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gamF2aWVyLmFicmVnby5sb3JlbnRlQGdt
YWlsLmNvbS4KPiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQKPiBodHRwczovL2FrYS5t
cy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24uXQo+IAo+IEluIHRoaXMgZnVuY3Rpb24g
Z290byBjYW4gYmUgcmVwbGFjZWQuIEF2b2lkaW5nIGdvdG8gd2lsbCBpbXByb3ZlIHRoZQo+IHJl
YWRhYmlsaXR5Cj4gCj4gU2lnbmVkLW9mZi1ieTogSmF2aWVyIEFicmVnbzxqYXZpZXIuYWJyZWdv
LmxvcmVudGVAZ21haWwuY29tPgo+IC0tLQo+IMKgZnMvbmZzL25mczQyeGF0dHIuYyB8IDMyICsr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTMgaW5z
ZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0
MnhhdHRyLmMgYi9mcy9uZnMvbmZzNDJ4YXR0ci5jCj4gaW5kZXggZTdiMzRmN2UwLi4yZmM4MDY0
NTQgMTAwNjQ0Cj4gLS0tIGEvZnMvbmZzL25mczQyeGF0dHIuYwo+ICsrKyBiL2ZzL25mcy9uZnM0
MnhhdHRyLmMKPiBAQCAtNzQzLDI1ICs3NDMsMTkgQEAgdm9pZCBuZnM0X3hhdHRyX2NhY2hlX3Nl
dF9saXN0KHN0cnVjdCBpbm9kZQo+ICppbm9kZSwgY29uc3QgY2hhciAqYnVmLAo+IMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCBuZnM0X3hhdHRyX2VudHJ5ICplbnRyeTsKPiAKPiDCoMKgwqDCoMKgwqDC
oCBjYWNoZSA9IG5mczRfeGF0dHJfZ2V0X2NhY2hlKGlub2RlLCAxKTsKPiAtwqDCoMKgwqDCoMKg
IGlmIChjYWNoZSA9PSBOVUxMKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
bjsKPiAtCj4gLcKgwqDCoMKgwqDCoCBlbnRyeSA9IG5mczRfeGF0dHJfYWxsb2NfZW50cnkoTlVM
TCwgYnVmLCBOVUxMLCBidWZsZW4pOwo+IC3CoMKgwqDCoMKgwqAgaWYgKGVudHJ5ID09IE5VTEwp
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4gLQo+IC3CoMKgwqDC
oMKgwqAgLyoKPiAtwqDCoMKgwqDCoMKgwqAgKiBUaGlzIGlzIGp1c3QgdGhlcmUgdG8gYmUgYWJs
ZSB0byBnZXQgdG8gYnVja2V0LT5jYWNoZSwKPiAtwqDCoMKgwqDCoMKgwqAgKiB3aGljaCBpcyBv
YnZpb3VzbHkgdGhlIHNhbWUgZm9yIGFsbCBidWNrZXRzLCBzbyBqdXN0Cj4gLcKgwqDCoMKgwqDC
oMKgICogdXNlIGJ1Y2tldCAwLgo+IC3CoMKgwqDCoMKgwqDCoCAqLwo+IC3CoMKgwqDCoMKgwqAg
ZW50cnktPmJ1Y2tldCA9ICZjYWNoZS0+YnVja2V0c1swXTsKPiAtCj4gLcKgwqDCoMKgwqDCoCBp
ZiAoIW5mczRfeGF0dHJfc2V0X2xpc3RjYWNoZShjYWNoZSwgZW50cnkpKQo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGtyZWZfcHV0KCZlbnRyeS0+cmVmLCBuZnM0X3hhdHRyX2ZyZWVf
ZW50cnlfY2IpOwo+IC0KPiAtb3V0Ogo+IC3CoMKgwqDCoMKgwqAga3JlZl9wdXQoJmNhY2hlLT5y
ZWYsIG5mczRfeGF0dHJfZnJlZV9jYWNoZV9jYik7Cj4gK8KgwqDCoMKgwqDCoCBpZiAoY2FjaGUg
PT0gTlVMTCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGtyZWZfcHV0KCZjYWNo
ZS0+cmVmLCBuZnM0X3hhdHRyX2ZyZWVfY2FjaGVfY2IpOwo+ICvCoMKgwqDCoMKgwqAgfSBlbHNl
IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqIFRoaXMgaXMganVzdCB0aGVyZSB0byBiZSBhYmxlIHRvIGdldCB0byBidWNr
ZXQtCj4gPmNhY2hlLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogd2hpY2ggaXMg
b2J2aW91c2x5IHRoZSBzYW1lIGZvciBhbGwgYnVja2V0cywgc28KPiBqdXN0Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB1c2UgYnVja2V0IDAuCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnRyeS0+YnVj
a2V0ID0gJmNhY2hlLT5idWNrZXRzWzBdOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoIW5mczRfeGF0dHJfc2V0X2xpc3RjYWNoZShjYWNoZSwgZW50cnkpKQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrcmVmX3B1dCgmZW50cnkt
PnJlZiwKPiBuZnM0X3hhdHRyX2ZyZWVfZW50cnlfY2IpOwo+ICvCoMKgwqDCoMKgwqAgfQo+IMKg
fQo+IAoKVGhpcyAiY2xlYW51cCIgaGFzIGNsZWFybHkgbm90IHNlZW4gYW55IHRlc3RpbmcgYXQg
YWxsLCBzaW5jZSBpdAphcHBlYXJzIHRvIGNhbGwga3JlZl9wdXQoJmNhY2hlLT5yZWYsKSB3aGVu
IGNhY2hlID09IE5VTEwsIGFuZCBpdCBsZWFrcwp0aGUgc2FtZSByZWZlcmVuY2UgaW4gdGhlIGNh
c2Ugd2hlcmUgY2FjaGUgIT0gTlVMTC4gTm90IHRvIG1lbnRpb24gdGhlCmZhY3QgdGhhdCBpdCBy
ZW1vdmVzIHRoZSBhbGxvY2F0aW9uIG9mIGVudHJ5IGFsdG9nZXRoZXIuCgpUaGFua3MsIGJ1dCBJ
IHRoaW5rIHdlJ2xsIHBhc3MuCgotLSAKVHJvbmQgTXlrbGVidXN0CkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UKdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQoK
Cg==
