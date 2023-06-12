Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5303372D3A4
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 23:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjFLVyl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 17:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbjFLVyc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 17:54:32 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2113.outbound.protection.outlook.com [40.107.96.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6538510F2
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 14:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I004Z5A5ui878I+c/NyspLmdpfa1yNEvII713unrxVQ1rShzJqP6m9OmnXpkzf7LKrzF8zMY7gStbuhQi3ljxwrf9r89e6YPYPp7VhUJcNTvLuAOpThr6F3qTi0l4/++vGJ/9AozxD9LH3lPnMwl2NMd/Qr36qFJ+jhR7BwouAZDFE0ZFEKqaEpZYqJ+rR84Ow8613TjOmZ0vLyt/IBTgRkJeLIp6GmeXqxNn30apotsWFhkqGfvPGLoYBF0TKfhDQWzIlYBYBqy6JfeVp+i4MkZcNHi7ZlJJM0NpnmgrCnNl4QfI/wBjCrffr9VY9+M8tcz2zatKryEBuB3xysuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+IUN/XSYbNgmwWtZaiT/XneAx3up8YqxXJF3n+vCZ0=;
 b=A46Y+ityaBSD+Fd7DDccEwFPKHjrxV4KXmUNhkAEwVRwJ+qBl2TxrmqOyx97wqwM3FLMzK45I2BiDGRMm4j/V10C0jbgM8ULsp0YPBL8EUnUZC+aocpr6iiwbzgW7DWRWjDNNbuqbaF2O2Gd4xxjbkGE5m9uLQ2G1yvnOgJuWCe7ZxobY7f8Zt2DFHC2g1D8ou4gKlooiAMuPj9v4N8W0IzzzyEqUzZjcc4PhyywyA5YOhKi6kdW4IbAdRllXBCDOmK7/muTc2s4vSrPGBK0z7SnMF3ocL0TlSp2JOWa6p6qwCGavxDnsHolBcaLUpfe9ql20Ly5NBE5GyXOuyzIDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+IUN/XSYbNgmwWtZaiT/XneAx3up8YqxXJF3n+vCZ0=;
 b=AzomYJf7sRSTIuGsk8BYWhE2G7qF9f9XCOr4IN8U+nps2wMNJdfI2leiNRdXnQva+lkdae26hHya9k3aNYafgtZjlNnDYOOZW0arl3pzyNhExJdHjjto93uEExMZ2YnmsSTQcYqX1jiPcw3sd5ewNNeA394L9eUrgYp6Q31sd+4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO6PR13MB6047.namprd13.prod.outlook.com (2603:10b6:303:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 21:54:27 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8%6]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:54:27 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "cperl@janestreet.com" <cperl@janestreet.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: Too many ENOSPC errors
Thread-Topic: Too many ENOSPC errors
Thread-Index: AQHZmixcHGuNgpUrYkSLHkSz8pXLeq+BYVYAgAXeawCAABlYAIAAGcuAgAAFXgCAABiNAIAACd0AgAAHiwCAABpZAA==
Date:   Mon, 12 Jun 2023 21:54:27 +0000
Message-ID: <818cc533af390e197e09beb87f1c8f6715c03059.camel@hammerspace.com>
References: <CAAih9mhU-UKGvSKBsCqRmkN6zvsD_ThofU94tCOECVJ2G9iW=w@mail.gmail.com>
         <9b3e6161f290246eb8003767b2b34596a10f5d71.camel@kernel.org>
         <CAAih9miBhTWZVt2N_39tzzOfJfjyUKeq30tD2OOQZdQhRSFhSw@mail.gmail.com>
         <cd4e8b16a8c154e6bda38021eef2c0d56badb43c.camel@kernel.org>
         <71b3ff942fdf6f070f6cd59f29e04081d3f94c38.camel@kernel.org>
         <CAAih9mhcOq2XqL0Q0sgkrpfJudpL9knV8yq+Uk1s2mJRRxau8Q@mail.gmail.com>
         <6c16c58a9e6de330eab68aadd4714954df41dd1c.camel@kernel.org>
         <fe258f94cf0d4f4731d4affbb78777706692bd20.camel@hammerspace.com>
         <77344fe208d76fa98ba24d79f2246e34ae20b543.camel@kernel.org>
In-Reply-To: <77344fe208d76fa98ba24d79f2246e34ae20b543.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO6PR13MB6047:EE_
x-ms-office365-filtering-correlation-id: 8792daed-4eb9-4ef0-e7bf-08db6b8f97d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8xptK/LrkxEYLja6spcXGSdVe0r1p+q1opfShRHV2uAXvT4uQ0rJ4uiVV7agfBAc+Fahn2PHpCVmPRbIQnKK6uPZzmA16jaabuX7JUEtPWIdGgt4pxengN+Tpn+bbfvLo0svnMBXTwIrRXzHfFDHSQa10h3Ktp0PEe3Yr2WE2yj3+qefLcYDVsm7Z38v+aBPVyLPiPTq97oDTKYmuUiC4QqWLEWowRBFDn47S1KfqDASYdtANXKPpRoz6M5xjqeLcceaEYvr7ajbh2aYIhMSIgIJlxpRBFO8x2ZuWwDyx5SQ0PqYlTaf3d6349YLFwoGrMmymMS0TccxprhZE5/uGeo5ndg7mxfGotdEahhOk/yOxfHGUXRwDQz4WgVxrOBbcdZXd6YrAVvg8gheFlxDobovv1KWFENDZUnt1OVs1PwUdTGeK5am4uUSdcuuFnIVWrdE1vo0hmNc1OyfrVLAPkL94W5lHQS37EnXnwqaLdNoZ7wmSzoZ+38BLxBI+qJfa3oI9no+oPG6ExwCj+2Kupzqdvj/yK29GyL0r/L8xIFlzSnaIeNJaIGREKcoYlE0W59VWS7BjF3jIJBda97/2G0uBudFdMuYQg3UBOT6E7mg1HczQ9dPpUnblnm85m66
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39840400004)(396003)(346002)(136003)(376002)(451199021)(4326008)(66946007)(76116006)(66446008)(66476007)(64756008)(66556008)(36756003)(186003)(478600001)(54906003)(110136005)(2616005)(2906002)(8676002)(316002)(41300700001)(86362001)(6486002)(6506007)(53546011)(38070700005)(71200400001)(8936002)(122000001)(83380400001)(5660300002)(3480700007)(38100700002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ti9XQnB2Wkc5N2Yxd2g0Q2lmdzZWWmVyc1A5Q0FiTnFzdnAxd1V3Y2w2bDVV?=
 =?utf-8?B?TWpHRUxMcURjalp0alhCc3B2R24vYk5jaC85Zmo2cGlFNFRCdm1lSXl1MHJa?=
 =?utf-8?B?bTZjamkvdFg3RFlVemtkYUVMSExETUM5Nk5YeEdyS09KTVV0R0IzM2hpOThq?=
 =?utf-8?B?WFErVGgwZ2tQQVR4UW1NQXlXNXdHbkNVb3NTQjFYMXlLemV4bys2YndZakJr?=
 =?utf-8?B?UW5ha25kZHU2ZkNNTUhEMEFXU3FYYVJ0Sm11N1V0OVdEbVdzQTkyRVNjd3R5?=
 =?utf-8?B?bkVNa0xGY0ZXdXgvVFc0a2xZTkJBdFg0Y1ZWZXV4d0xYcnFtQ2txUERQTVB5?=
 =?utf-8?B?MlZYU0V4Vm51akJ4QWp3cytrOUF0ak91WXRpNDZvV25UYVU2QVh5TUdZV2Rz?=
 =?utf-8?B?ZzlWZXdvenBPZmFYMWNrQjYzTWhUSkYvZGZTL3FqWkZZaXZJcGNadlBQR0JR?=
 =?utf-8?B?Y0tDM2ZwRTlMUkVrdkNXSnVSQWk5RHlaMFVXSVBHUUJVVXE5VjNRV01Xb0NY?=
 =?utf-8?B?YmsvUit0UWVxU0pnTnFnL2FMSSsxbGh2Tlk1SUgvOUxYc0pQOFRpSldGekpW?=
 =?utf-8?B?ZUtiRlVjVWtpc3hOYnVIY1hxcHRwbzRLMU1SbXpmYTFtaUZEbDZwbFJkRVpK?=
 =?utf-8?B?eXJvZzBxUk5CVkJaMHZ2UGxOeXllZHJERnY4RStxMDhnd3c4blFqd1JkSm9Z?=
 =?utf-8?B?UWZ1WTZldTY1ZzZmOXlTNXovaWd0QlZSRkFNZ1J2VkgxeklUYWZpWDVWVSs2?=
 =?utf-8?B?M0pBbHVZajBNcTE4RkZCR3NUdk5TYUQvNENRakgvK0hKWXBvQXJOK1FtZ0x1?=
 =?utf-8?B?cURHQ3d1YkVYU05ZN1hwb09IcnpWQVBrV21VN0VUMGdjUVBIRlI3ZmFYZjBR?=
 =?utf-8?B?WmVDdFpHZ05KRFpKd2N3R1M2NHg5WS9lQTVYcktSS1J5SnhBTVhxczhIS3Q4?=
 =?utf-8?B?cHhGMUVnSTI2NmxRYWJNeVZLZ3ZhRjdjSjg0ZnZPdzljLyt6UmVFcG9qaTl2?=
 =?utf-8?B?bEhUd09LNXU4ZVhvTnJKUUEzRjg5VEZmejU3ZlZCL3RiZ1FjQTNHQjdoRTVy?=
 =?utf-8?B?Y1htODV0blp5M2t6dWJ2azRmV2ZCbEQ2T214ZEVmanlpWG5DNGdSNEI4U1pu?=
 =?utf-8?B?RnFoUXZsblRZVm5JTWZkOUFjUnhoMGU1STcrMDZSVWh3OFlGcW5lVDQ3eG5a?=
 =?utf-8?B?OEtaV1k5bjU4OXg3ZHdjbTJMVklWd0tVQndOaTNwMStET3EyQm9BZ1NBU2lz?=
 =?utf-8?B?NldnSnoyWDhMcVhmdlQ0WWxTS3d0RUlhN3R5WWpKQUlhU1ExT2E5N1J1Rzhj?=
 =?utf-8?B?eWcvVkxWSHNXakNicDJEOTUxMUpkQnBRbyttbHJ4SHRtS1NNMXdFWVdsZXJ0?=
 =?utf-8?B?eVRPWE1SZERzMjdoSGJTOWZHUmhFbHJyL3BIYnJtTWlpeklGZGFiQ3NOS2Q1?=
 =?utf-8?B?bGFNVEFwTU5ibzgrYmFGTXdWTjlTWTQ2K2VCZ0dHSHJQQ0hBZ3V5NVh5TnFH?=
 =?utf-8?B?NTc2Qy8zRTUwWm5ldVZycmFYNWs4SytxeWE5TUJLakFqSnhLd1FrNExIbjNL?=
 =?utf-8?B?Qnp5Q3hPR0FIOTVidDhJZzRTY1Z0cDVibVJzVHZSK1dhU0Q5NkFkenp0Nlcy?=
 =?utf-8?B?VE5OdzFoK1UySkE4eUFqZ2pzS2RJaWs1R2p4YnhCaldvOXp3NHBjcG9QZFVO?=
 =?utf-8?B?SjRCOURpRlJnRTFubm9aSzlmeFpvYVNTTURSZFBzbjhqenozT25sZUsvZkFz?=
 =?utf-8?B?NWl5YmtRMnR0T3RYME5zU2lMM01zYWFndWdWWHhBd05CejdicDhHMEE3UWpL?=
 =?utf-8?B?cDNKS3oxVFVKY3BzVFBjWGFZL2djcXEwdXl6TldSUVY4cWtlZXh6MzJvaGVi?=
 =?utf-8?B?YmdyL3M4VzRXVlBMMWprWHhuQ1Y1bTRJdExuVDFKdlczeStrUS8zb3ExMS9p?=
 =?utf-8?B?c2JpSkZDQjNncUV1UzQvTmVHcUJpTmlsM3hvZU91UXgzUjJENE9FMEN2ZGkv?=
 =?utf-8?B?aXRaZTFGNnU0UEVCSVZMQVlvUytkdXNuUjNkMUJrQUREZHQ2RnZ0a0hCSHVh?=
 =?utf-8?B?TUdGMkNlb2RWZ2dhYVJveEZOQXJ1YVlkMDF2ZzIvcVJWZ1pmWmo4Z1dOM2tO?=
 =?utf-8?B?YnUrdGkzMzFPck1tdGNkT3ZoNUNTdzVvc25TdGRoZFlmQWI5OG1yU0hoNmFY?=
 =?utf-8?B?MGhETzMrNmtZdkdGaFdIQzEwRjBWd01jWHIzZk9neTlzaXRyV28za09CT1U4?=
 =?utf-8?B?eEpzN2pjZ201a050MHJ3cTFjUEtRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EBB25AFA0E07F46A5F5D98174EC5DA8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8792daed-4eb9-4ef0-e7bf-08db6b8f97d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 21:54:27.4532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6FEmKhjuhaxmIpLs/2KuqW4yZpzhnttQOl0ffWhWF+xA++YrPrQHKbLbd6jU6TgWmQrT52uYrA5AGXKvaAocog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB6047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTEyIGF0IDE2OjIwIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gTW9uLCAyMDIzLTA2LTEyIGF0IDE5OjUzICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gTW9uLCAyMDIzLTA2LTEyIGF0IDE1OjE3IC0wNDAwLCBKZWZmIExheXRvbiB3cm90
ZToNCj4gPiA+IE9uIE1vbiwgMjAyMy0wNi0xMiBhdCAxMzo0OSAtMDQwMCwgQ2hyaXMgUGVybCB3
cm90ZToNCj4gPiA+ID4gT24gTW9uLCBKdW4gMTIsIDIwMjMgYXQgMTozMOKAr1BNIEplZmYgTGF5
dG9uDQo+ID4gPiA+IDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+ID4gPiA+IHdyb3RlOg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IE9uIE1vbiwgMjAyMy0wNi0xMiBhdCAxMTo1OCAtMDQwMCwgSmVmZiBM
YXl0b24gd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEdvdCBp
dDogSSB0aGluayBJIHNlZSB3aGF0J3MgaGFwcGVuaW5nLg0KPiA+ID4gPiA+ID4gZmlsZW1hcF9z
YW1wbGVfd2JfZXJyDQo+ID4gPiA+ID4gPiBqdXN0IGNhbGxzDQo+ID4gPiA+ID4gPiBlcnJzZXFf
c2FtcGxlLCB3aGljaCBkb2VzIHRoaXM6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGVycnNl
cV90IGVycnNlcV9zYW1wbGUoZXJyc2VxX3QgKmVzZXEpDQo+ID4gPiA+ID4gPiB7DQo+ID4gPiA+
ID4gPiDCoMKgwqDCoMKgwqDCoCBlcnJzZXFfdCBvbGQgPSBSRUFEX09OQ0UoKmVzZXEpOw0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCAvKiBJZiBub2JvZHkgaGFzIHNl
ZW4gdGhpcyBlcnJvciB5ZXQsIHRoZW4gd2UgY2FuDQo+ID4gPiA+ID4gPiBiZQ0KPiA+ID4gPiA+
ID4gdGhlIGZpcnN0LiAqLw0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKCEob2xkICYg
RVJSU0VRX1NFRU4pKQ0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG9sZCA9IDA7DQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gb2xkOw0KPiA+ID4g
PiA+ID4gfQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBCZWNhdXNlIG5vIG9uZSBoYXMgc2Vl
biB0aGF0IGVycm9yIHlldCAoRVJSU0VRX1NFRU4gaXMNCj4gPiA+ID4gPiA+IGNsZWFyKSwNCj4g
PiA+ID4gPiA+IHRoZSB3cml0ZQ0KPiA+ID4gPiA+ID4gZW5kcyB1cCBiZWluZyB0aGUgZmlyc3Qg
dG8gc2VlIGl0IGFuZCBpdCBnZXRzIGJhY2sgYSAwLA0KPiA+ID4gPiA+ID4gZXZlbg0KPiA+ID4g
PiA+ID4gdGhvdWdoIHRoZQ0KPiA+ID4gPiA+ID4gZXJyb3IgaGFwcGVuZWQgYmVmb3JlIHRoZSBz
YW1wbGUuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoZSBhYm92ZSBiZWhhdmlvciBpcyB3
aGF0IHdlIHdhbnQgZm9yIHRoZSBzYW1wbGUgdGhhdCB3ZQ0KPiA+ID4gPiA+ID4gZG8gYXQNCj4g
PiA+ID4gPiA+IG9wZW4oKQ0KPiA+ID4gPiA+ID4gdGltZSwgYnV0IG5vdCB3aGF0J3MgbmVlZGVk
IGZvciB0aGlzIHVzZS1jYXNlLiBXZSBuZWVkIGENCj4gPiA+ID4gPiA+IG5ldw0KPiA+ID4gPiA+
ID4gaGVscGVyIHRoYXQNCj4gPiA+ID4gPiA+IHNhbXBsZXMgdGhlIHZhbHVlIHJlZ2FyZGxlc3Mg
b2Ygd2hldGhlciBpdCBoYXMgYWxyZWFkeSBiZWVuDQo+ID4gPiA+ID4gPiBzZWVuOg0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBlcnJzZXFfdCBlcnJzZXFfcGVlayhlcnJzZXFfdCAqZXNlcSkN
Cj4gPiA+ID4gPiA+IHsNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqAgcmV0dXJuIFJFQURfT05DRSgq
ZXNlcSk7DQo+ID4gPiA+ID4gPiB9DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IC4uLmJ1dCB3
ZSdsbCBhbHNvIG5lZWQgdG8gZml4IHVwIGVycnNlcV9jaGVjayB0byBoYW5kbGUNCj4gPiA+ID4g
PiA+IGRpZmZlcmVuY2VzDQo+ID4gPiA+ID4gPiBiZXR3ZWVuIHRoZSBTRUVOIGJpdC4NCj4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gSSdsbCBzZWUgaWYgSSBjYW4gc3BpbiB1cCBhIHBhdGNoIGZv
ciB0aGF0LiBTdGF5IHR1bmVkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoaXMgbWF5IG5vdCBi
ZSBmaXhhYmxlIHdpdGggdGhlIHdheSB0aGF0IE5GUyBpcyB0cnlpbmcgdG8NCj4gPiA+ID4gPiB1
c2UNCj4gPiA+ID4gPiBlcnJzZXFfdC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgZnVuZGFt
ZW50YWwgcHJvYmxlbSBpcyB0aGF0IHdlIG5lZWQgdG8gbWFyayB0aGUgZXJyc2VxX3QNCj4gPiA+
ID4gPiBpbg0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IG1hcHBpbmcgYXMgU0VFTiB3aGVuIHdl
IHNhbXBsZSBpdCwgdG8gZW5zdXJlIHRoYXQgYSBsYXRlcg0KPiA+ID4gPiA+IGVycm9yDQo+ID4g
PiA+ID4gaXMNCj4gPiA+ID4gPiByZWNvcmRlZCBhbmQgbm90IGlnbm9yZWQuDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gQnV0Li4uaWYgdGhlIGVycm9yIGhhc24ndCBiZWVuIHJlcG9ydGVkIHlldCBh
bmQgd2UgbWFyayBpdA0KPiA+ID4gPiA+IFNFRU4NCj4gPiA+ID4gPiBoZXJlLA0KPiA+ID4gPiA+
IGFuZCB0aGVuIGEgbGF0ZXIgZXJyb3IgZG9lc24ndCBvY2N1ciwgdGhlbiBhIGxhdGVyIG9wZW4g
d29uJ3QNCj4gPiA+ID4gPiBoYXZlIGl0cw0KPiA+ID4gPiA+IGVycnNlcV90IHNldCB0byAwLCBh
bmQgdGhhdCB1bnNlZW4gZXJyb3IgY291bGQgYmUgbG9zdC4NCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBJdCdzIGEgYml0IG9mIGEgcGl0eTogYXMgb3JpZ2luYWxseSBlbnZpc2lvbmVkLCB0aGUgZXJy
c2VxX3QNCj4gPiA+ID4gPiBtZWNoYW5pc20NCj4gPiA+ID4gPiB3b3VsZCBwcm92aWRlIGZvciB0
aGlzIHNvcnQgb2YgdXNlIGNhc2UsIGJ1dCB3ZSBhZGRlZCB0aGlzDQo+ID4gPiA+ID4gcGF0Y2gN
Cj4gPiA+ID4gPiBub3QNCj4gPiA+ID4gPiBsb25nIGFmdGVyIHRoZSBvcmlnaW5hbCBjb2RlIHdl
bnQgaW4sIGFuZCBpdCBjaGFuZ2VkIHRob3NlDQo+ID4gPiA+ID4gc2VtYW50aWNzOg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IMKgwqDCoCBiNDY3OGRmMTg0YjMgZXJyc2VxOiBBbHdheXMgcmVwb3J0
IGEgd3JpdGViYWNrIGVycm9yIG9uY2UNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIGRvbid0IHNl
ZSBhIGdvb2Qgd2F5IHRvIGRvIHRoaXMgdXNpbmcgdGhlIGN1cnJlbnQgZXJyc2VxX3QNCj4gPiA+
ID4gPiBtZWNoYW5pc20sDQo+ID4gPiA+ID4gZ2l2ZW4gdGhlc2UgY29tcGV0aW5nIG5lZWRzLiBJ
J2xsIGtlZXAgdGhpbmtpbmcgYWJvdXQgaXQNCj4gPiA+ID4gPiB0aG91Z2guDQo+ID4gPiA+ID4g
TWF5YmUNCj4gPiA+ID4gPiB3ZSBjb3VsZCBhZGQgc29tZSBzb3J0IG9mIHN0b3JlIGFuZCBmb3J3
YXJkIG1lY2hhbmlzbSBmb3INCj4gPiA+ID4gPiBmc3luYw0KPiA+ID4gPiA+IG9uIE5GUz8NCj4g
PiA+ID4gPiBUaGF0IGNvdWxkIGdldCByYXRoZXIgY29tcGxleCB0aG91Z2guDQo+ID4gPiA+IA0K
PiA+ID4gPiBDYW4vc2hvdWxkIGl0IGJlIG1hcmtlZCBTRUVOIHdoZW4gdGhlIGluaXRpYWwgY2xv
c2UoMikgZnJvbQ0KPiA+ID4gPiB0ZWUoMSkNCj4gPiA+ID4gcmVwb3J0cyB0aGUgZXJyb3I/DQo+
ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBOby4gTW9zdCBzb2Z0d2FyZSBkb2Vzbid0IGNoZWNrIGZv
ciBlcnJvcnMgb24gY2xvc2UoKSwgYW5kIGZvcg0KPiA+ID4gZ29vZA0KPiA+ID4gcmVhc29uOiB0
aGVyZSdzIG5vIHJlcXVpcmVtZW50IHRoYXQgYW55IGRhdGEgYmUgd3JpdHRlbiBiYWNrDQo+ID4g
PiBiZWZvcmUNCj4gPiA+IGNsb3NlKCkgcmV0dXJucy4gQSBzdWNjZXNzZnVsIHJldHVybiBpcyBt
ZWFuaW5nbGVzcy4NCj4gPiA+IA0KPiA+ID4gSXQgdHVybnMgb3V0IHRoYXQgTkZTdjQgKHVzdWFs
bHkpIHdyaXRlcyBiYWNrIHRoZSBkYXRhIGJlZm9yZSBhDQo+ID4gPiBjbG9zZQ0KPiA+ID4gcmV0
dXJucywgYnV0IHlvdSBkb24ndCB3YW50IHRvIHJlbHkgb24gdGhhdC4NCj4gPiA+IA0KPiA+ID4g
PiBQYXJ0IG9mIHRoZSByZWFzb24gSSBoYWQgb3JpZ2luYWxseSBhc2tlZCBhYm91dA0KPiA+ID4g
PiBgbmZzX2ZpbGVfZmx1c2gnDQo+ID4gPiA+IChpLmUuDQo+ID4gPiA+IHdoYXQgY2xvc2UoMikg
Y2FsbHMpIHVzaW5nIGBmaWxlX2NoZWNrX2FuZF9hZHZhbmNlX3diX2VycicNCj4gPiA+ID4gaW5z
dGVhZA0KPiA+ID4gPiBvZg0KPiA+ID4gPiBgZmlsZW1hcF9jaGVja193Yl9lcnInIHdhcyBiZWNh
dXNlIEkgd2FzIGRyYXduIHRvIGNvbXBhcmluZw0KPiA+ID4gPiBgbmZzX2ZpbGVfZmx1c2gnIGFn
YWluc3QgYG5mc19maWxlX2ZzeW5jJyBhcyBpdCBzZWVtcyBsaWtlIGluDQo+ID4gPiA+IHRoZQ0K
PiA+ID4gPiAzLjEwDQo+ID4gPiA+IGJhc2VkIEVMNyBrZXJuZWxzLCB0aGUgZm9ybWVyIHVzZWQg
dG8gZGVsZWdhdGUgdG8gdGhlIGxhdHRlcg0KPiA+ID4gPiAoYnkNCj4gPiA+ID4gd2F5DQo+ID4g
PiA+IG9mIGB2ZnNfZnN5bmMnKSBhbmQgc28gdGhleSBoYWQgY29uc2lzdGVudCBiZWhhdmlvciwg
d2hlcmVhcw0KPiA+ID4gPiBub3cNCj4gPiA+ID4gdGhleQ0KPiA+ID4gPiBkbyBub3QuDQo+ID4g
PiANCj4gPiA+IEkgdGhpbmsgdGhlIHByb2JsZW0gaXMgaW4gc29tZSBvZiB0aGUgY2hhbmdlcyB0
byB3cml0ZSB0aGF0IGhhdmUNCj4gPiA+IGNvbWUNCj4gPiA+IGludG8gcGxheSBzaW5jZSB0aGVu
LiBUaGV5IHRyaWVkIHRvIHVzZSBlcnJzZXFfdCB0byB0cmFjayBlcnJvcnMNCj4gPiA+IG92ZXIN
Cj4gPiA+IGENCj4gPiA+IHNtYWxsIHdpbmRvdywgYnV0IHRoZSB1bmRlcmx5aW5nIGluZnJhc3Ry
dWN0dXJlIGlzIG5vdCBxdWl0ZQ0KPiA+ID4gc3VpdGVkDQo+ID4gPiBmb3INCj4gPiA+IHRoYXQg
YXQgdGhlIG1vbWVudC4NCj4gPiA+IA0KPiA+ID4gSSB0aGluayB3ZSBjYW4gZ2V0IHRoZXJlIHRo
b3VnaCBieSBjYXJ2aW5nIGFub3RoZXIgZmxhZyBiaXQgb3V0DQo+ID4gPiBvZg0KPiA+ID4gdGhl
DQo+ID4gPiBjb3VudGVyIGluIHRoZSBlcnJzZXFfdC4gSSdtIHdvcmtpbmcgb24gYSBwYXRjaCBm
b3IgdGhhdCBub3cuDQo+ID4gPiANCj4gPiANCj4gPiBUaGUgY3VycmVudCBORlMgY2xpZW50IGNv
ZGUgdHJpZXMgdG8gZG8gaXRzIGJlc3QgdG8gbWF0Y2ggdGhlDQo+ID4gZGVzY3JpcHRpb24gaW4g
dGhlIG1hbnBhZ2VzIGZvciBob3cgZXJyb3JzIGFyZSByZXBvcnRlZDogd2UgdHJ5IHRvDQo+ID4g
cmVwb3J0IHRoZW0gZXhhY3RseSBvbmNlLCBlaXRoZXIgaW4gd3JpdGUoKSBvciBmc3luYygpLg0K
PiA+IFdlIGRvIHN0aWxsIHJldHVybiBlcnJvcnMgb24gY2xvc2UoKSwgYnV0IHRoYXQga2luZCBv
Zg0KPiA+IG9wcG9ydHVuaXN0aWMNCj4gPiBlcnJvciByZXR1cm4gbWFrZXMgc3VyZSB0byB1c2Ug
ZmlsZW1hcF9jaGVja193Yl9lcnIoKSBzbyB0aGF0IHdlDQo+ID4gZG9uJ3QNCj4gPiBicmVhayB0
aGUgd3JpdGUoKSArIGZzeW5jKCkgZG9jdW1lbnRlZCBzZW1hbnRpY3MuDQo+ID4gDQo+ID4gVGhl
IGlzc3VlIG9mIHBpY2tpbmcgdXAgZXJyb3JzIHVzaW5nIGVycnNlcV9zYW1wbGUoKSBiZWZvcmUg
ZXZlbg0KPiA+IGFueQ0KPiA+IEkvTyBoYXMgYmVlbiBhdHRlbXB0ZWQgaGFzIGJlZW4gcmFpc2Vk
IGJlZm9yZSwgYnV0IEFGQUlLLCB0aGUNCj4gPiBjdXJyZW50DQo+ID4gYmVoYXZpb3VyIGRvZXMg
YWN0dWFsbHkgbWF0Y2ggdGhlIHByb21pc2VzIG1hZGUgaW4gdGhlIG1hbnBhZ2VzLA0KPiA+IGFu
ZCBpdA0KPiA+IG1hdGNoZXMgd2hhdCBjYW4gaGFwcGVuIHdpdGggb3RoZXIgZmlsZXN5c3RlbXMu
DQo+ID4gSSBkb24ndCB3YW50IHRvIHNwZWNpYWwgY2FzZSB0aGUgTkZTIGNsaWVudCwgYmVjYXVz
ZSB0aGF0IGp1c3QNCj4gPiBsZWFkcyB0bw0KPiA+IHBlb3BsZSBnZXR0aW5nIGNvbmZ1c2VkIGFz
IHRvIHdoZXRoZXIgb3Igbm90IGl0IHdpbGwgd29yayBjb3JyZWN0bHkNCj4gPiB3aXRoIGFwcGxp
Y2F0aW9ucyBzdWNoIGFzIHBvc3RncmVzcWwuDQo+ID4gDQo+IA0KPiBUaGUgcG9pbnQgaGVyZSB3
b3VsZCBiZSB0byBicmluZyBORlMgbW9yZSBpbnRvIGxpbmUgd2l0aCBob3cgb3RoZXINCj4gZmls
ZXN5c3RlbXMgYmVoYXZlLiBBcyBDaHJpcyBwb2ludGVkIG91dCwgb3RoZXIgZmlsZXN5c3RlbXMg
ZG9uJ3QNCj4gcmVwb3J0DQo+IGFuIGVycm9yIG9uIGEgbmV3IHdyaXRlKCkganVzdCBiZWNhdXNl
IHRoZXJlIHdhcyBhbiBlYXJsaWVyLCB1bnNlZW4NCj4gd3JpdGViYWNrIGVycm9yIG9uIHRoZSBz
YW1lIGlub2RlLg0KDQpUaGF0J3Mgbm90IHF1aXRlIHRydWUuDQoNCmdlbmVyaWNfd3JpdGVfc3lu
YygpIHdpbGwgcmV0dXJuIHdoYXRldmVyIHZmc19mc3luY19yYW5nZSgpIHJldHVybnMsIHNvDQph
bnl0aGluZyBpbnZvbHZpbmcgT19EU1lOQyBvciBPX1NZTkMgb3IgdGhlIG5ld2VyIHB3cml0ZXYy
KCkgUkZXX0RTWU5DDQovIFJGV19TWU5DIGZsYWdzIGhhcyB0aGUgcG90ZW50aWFsIHRvIGJlaGF2
ZSBqdXN0IGxpa2UgTkZTLg0KDQpUaGUgZGlmZmVyZW5jZSBpcyB0aGF0IE5GUyBjYW4gZG8gdGhp
cyB3aXRoIG9yZGluYXJ5IGJ1ZmZlcmVkIHdyaXRlcw0KdG9vLg0KDQo+IA0KPiBJIHRoaW5rIHdl
IGNhbiBhY2hpZXZlIHRoaXMgYnkgY2FydmluZyBvdXQgYW5vdGhlciBmbGFnIGJpdCBmcm9tIHRo
ZQ0KPiBlcnJzZXFfdCBjb3VudGVyLsKgSSdtIGJ1aWxkaW5nIGFuZCB0ZXN0aW5nIGEgcGF0Y2gg
bm93LCBhbmQgSSdsbCBwb3N0DQo+IGl0DQo+IG9uY2UgSSdtIGNvbnZpbmNlZCBpdCdzIHNhbmUu
DQo+IA0KPiBDaGVlcnMsDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K
