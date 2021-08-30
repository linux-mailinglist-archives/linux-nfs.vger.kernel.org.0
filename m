Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA073FBB12
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 19:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbhH3Rf7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 13:35:59 -0400
Received: from mail-dm3nam07on2093.outbound.protection.outlook.com ([40.107.95.93]:28768
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238264AbhH3Rfs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Aug 2021 13:35:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgARvtuLvxySZ/Eq0xT/5g0j20U+zyIfKlX4JPuYR7bq9efxMSinub6E2BqJ1KT4c0uLTkONu27U6STtKwctc0caLl+gkTQ0b05JBwaDQsSLM9vNOFmvoO0EIdzU6wayBwB8NQMcuoE8Jbc3zu1Uz71iKI0mW5m761OKCHqBiKzAlYkboFuc/RTXKhhsXdRdRyRLtlU4uwRP0AddTzI1ojOhxPin3H69aJpWcIxsgrAeIN8FjfDjT/UKONqq+LwUxsAckW0Mjh4FFZFYAlipGFBgtJOv1xPJqXXU7x4BeMCY/++Kg8Kuz4hQvBDnssjApiT9EbS3oH4a/TIxdjNMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JbliGUOe2vaV059ZvWHj5nxalGD3/WfjQ0QqNRFvfk4=;
 b=YT/eMNqo+H69ue/FDQbzW0LtYy6YmQAD9fE4DZQMO9C65kpb0sgGNsIt5VqQQSwNl+78dEW8RuoGBDjGH4W3PLrSwA/1GO4HDIG6gVppvBVtM5y8ONzIGHCf+okKa029BlcPCkmShyeDipvoCMrILoXExE4C/cYrN6OXicrcuMh4XeUf7ILLpBz98swuuQSH44GTG0CDtQdWSZQdw/wnXDre4JGBkwXeLaqmoeyid64JLHFu73GMSlrvRK0GdnAAI5ywJgohWaZEN3X5nq7sE4hYbOKN364uvxKRmo4edeqKburPRm2IUbmoDxyK70LkP8WYzRkPG0gBwYW3btlQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbliGUOe2vaV059ZvWHj5nxalGD3/WfjQ0QqNRFvfk4=;
 b=YsgrS6a/ZatAWoXbqOzFQ+kbkpsWSYZYgfui6jSYLTdzuaCMav2wuwS5b57lR291RTVLSNAOmCb6CYXt2Rg9Zlt42v6LfO4NwopG5oVDLa0aSgdC+ZvfXN5crPDRYHeUqVhoU7ebmu62pRrHlidgng/q850FKOBlRa8M97euOZo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5097.namprd13.prod.outlook.com (2603:10b6:610:ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.12; Mon, 30 Aug
 2021 17:34:51 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%7]) with mapi id 15.20.4478.017; Mon, 30 Aug 2021
 17:34:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Topic: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Index: AQHXnb+CbAHCmXSSW0GqOAKXfQ2+oquMRqQAgAAFx4CAAALBAA==
Date:   Mon, 30 Aug 2021 17:34:51 +0000
Message-ID: <04f975f95126921f3d239a7a9d80ced2d88b05ff.camel@hammerspace.com>
References: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
         <20210830165302.60225-2-olga.kornievskaia@gmail.com>
         <F7F9A947-B282-416F-BC65-796BF325054F@oracle.com>
         <CAN-5tyEB9nv576uJijBtyhv2pqAHGNB4yeKo=F21btOkVQuaDQ@mail.gmail.com>
In-Reply-To: <CAN-5tyEB9nv576uJijBtyhv2pqAHGNB4yeKo=F21btOkVQuaDQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baaf4217-32bf-466e-acfa-08d96bdc78b7
x-ms-traffictypediagnostic: CH0PR13MB5097:
x-microsoft-antispam-prvs: <CH0PR13MB50971FE9BD1256B0EA9418C6B8CB9@CH0PR13MB5097.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SANSsw3s4PLd2r1DPkfWKTcRFn3NgxhjGST6+Y3QwjFANsteI30iKW56sWCzwh9I8dw6tt+UIWrlELayO42dzW9QiIBe2eJyjhcyA/JSnIWPGL6wm3Ew5UoKz4u+LrTibAj1rjy/o+bXYp7Ahw5yIwRb1j2WBWi+axOei6xzmnZ26qm69OxklatQoo8HQLqGA6FqtWXTCvrlGuZjLUt2JysIYCB9+E5aO5WfxjIixSYhag+HCkO2mJo6QkXjgDOs4xnRIpphaAcoaatqc45jDB+Y/MdK5gsMkM9crFcAgm0FEo3p0HrUYZ6KvxHfFzvMUkT92ueYlQ8c6HzdWW7FE9mTCnBAGOyk+Jv4QEfI807mO9GJ3z534g4nd9UuNuNynolcT8V5gkFKRzq8Vg81+qxfaZ02dCCGbtuT42bcKl9NjUFiDGrZzKL31HXAPEnra3CAzC28wlKsxK7LN5zAlLLWEIwL044y68SgvsjhHGsgTuFq5dx4OFZWKERG52Kw0/EB+/zJAfy0I2buYoJPOGPYTl5M2w7RC2DFD7HHjnE1FLLVfgJ55UXMG/u+hF0b2kfdzYKTcGaf7pc8e62lsYcXXozkA7KJVS2EzD62fUfK8GP94ibcEhJmj0HtHFbI5LrIT5KHs0/kt4nRspBU86OlGSkzaY8xftoxLYb6eYLrJiCKvgSJfIimQcwkOfUgfuag89CS/WigLALUZKFR5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39830400003)(366004)(396003)(346002)(136003)(122000001)(6506007)(6512007)(26005)(53546011)(66476007)(5660300002)(36756003)(6486002)(478600001)(38070700005)(186003)(71200400001)(8936002)(76116006)(66446008)(2906002)(2616005)(4326008)(110136005)(66946007)(8676002)(54906003)(66556008)(38100700002)(83380400001)(64756008)(86362001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0M5UnN5RXIwYUN0NTd2VjRtVXpkYmlHRXZTejdqSktDMUx2T0VKYWdBNHNu?=
 =?utf-8?B?WTN2R2Q2dmFhNXNOendKU3UzbFZjV0tTbnkyMnB2V3d5UC8wUmhzbEVnbjkr?=
 =?utf-8?B?YXN1S1NwNjgzcmxnQ1VicE42VG9DQ2l1a1B6eE9nM3NtSTNtY09NUGlTajBI?=
 =?utf-8?B?dW1md0RPUWlCS21LVE9va3oxQUdqVzlnVjdiTTcwU2JmUk5lcEM2cFJzNUxq?=
 =?utf-8?B?eDR1Y0cwSzZmR0JSTFhVVk9uWklLNjVDWGlWcWJYQm9hVWRhZThLVTZyMFdp?=
 =?utf-8?B?MVhXTDEyZEFrQlFJVFIwZWJYaytWS1BMaTViTWRVYkVFc28xd25NMHUxQ2sy?=
 =?utf-8?B?RWFXbXdKR21PSTVsekdDWkVLcU9xWkkrbnFFWHp4Lzk1LzEvVy9lTU9ZMllK?=
 =?utf-8?B?ZGFDT3VvWDE1S1V0TzMyZzhnWXJBRkFtVzNpTi96Q3FFZnQ3bVV4aUI5Ly9a?=
 =?utf-8?B?bjl3M1I4M1ptbGFGVUt2aXdSS0tHS1N0cmRwdmRFZ0hCSTVWSTUzcmFMRTZJ?=
 =?utf-8?B?QmxyYUlqT2lPQlFMSWFXUW1EeEFsdXdESEFoVDYwbzhYbkRUU0RIZGVkTjdD?=
 =?utf-8?B?NW4vYWRkOVBzZi9mbkJ5eVJSM2tlbG5QNTFqcVdQQ0cxcVA0VkRrajNucm1C?=
 =?utf-8?B?WFBsUldHSjVaZVAyRnRHcGZzcmFvWnlXTEtHb29BcGZQVWQwcndtc3Y2SGZI?=
 =?utf-8?B?em9pNVdTS2p0anZlTVk5dlRudFA4RlFQU3BoOUdLeDJubC9zN3JYQWliU1J5?=
 =?utf-8?B?RDhNeTkrbXd4eWdGYm0zZDlhRDRIdzNDanVEUk9sYzV5akVkZkpYZ1VNeUxP?=
 =?utf-8?B?Z2cvMW5laGQvVnhXZGVtTkFyV01vazVsdWV4Yk1ydGduZDRKV0RISmhyU0Rp?=
 =?utf-8?B?OTN2RlV4bWxRS0VobFBQbjZtSkFIbjZLWUtlTEh3MytEY1Z6bTJwZ0tZTHZI?=
 =?utf-8?B?Smt2bnE0bTNnTDE0SVdnNnBheWtqajBsV1hzWGhsQUk0d1JzcXJ4TGlDMnNI?=
 =?utf-8?B?b21pdmc3cUpjVVVZUXhTUEpoMk9kSFN6OVRweE1mS05USVVEVTlKSGpjVklY?=
 =?utf-8?B?VzdzbzI2Z3JZbTBOTjdrZDlWTk56K3dEYS9MamY1VmhUREp2cGJRVk5PUUFh?=
 =?utf-8?B?QVB6VXorVGNFTUZ1eElHQlRiVFR0b3d5a2pkTWlKclNkdHVWd3loTE9qUk40?=
 =?utf-8?B?RVhYbmZ3TUF4QUU3V3JDaU44NklsOFZEQzIzdjVBSTNHNCtnb2UvUkpLR2h3?=
 =?utf-8?B?MjJyaEVCLzlHaTVXRllMbVd4SGhHTElrWW9xVDFlTU5PQ2VwYzNCUmFlMEFU?=
 =?utf-8?B?NDFyVm4yc1ZHT0tkUjhXd2lweW5NblhXbG5QbzM5ZkhIYk00NnAvaVdaN3Y2?=
 =?utf-8?B?OFNVQ256alg0VkJiaFBYQnVxNmxaVWRGRHR1YnpJMHRZUE10S0crdnpRZjkv?=
 =?utf-8?B?cnZHYTBEaXdaTGI4MEwxbjRIbWdsalB4aHJlQzRZTjJnanU2RjZ6dDhmcXl6?=
 =?utf-8?B?Q29OdGxORUdzeWhBT2xSYzA0d1dSRVBuSlB3UzBMbUNwM1RJR0g4NW1GODV4?=
 =?utf-8?B?Tmg5U21raEhraXo1eUJnM0Iza3ZtTnZjM01lc0VrOXJ6Q2xBM3h2SmF3RE1D?=
 =?utf-8?B?b1FqSDMyYmFJWlFuWjB0cE0xWjhneWFWQ1ZrQzNPZVlRNHJnVnowbXh4L0Fi?=
 =?utf-8?B?Uy9JSDgzRGlEL1JxdWZPQnNoa2pRb2VqWGVxYlU1SDhuTE5GcnRzNC9ZcXdX?=
 =?utf-8?Q?8z/80xoHoyfAeun+27UoWsm77i7UVmCtBiCKQY+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B35FFA443A4FE45A184EB6B7D0FD880@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baaf4217-32bf-466e-acfa-08d96bdc78b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 17:34:51.0592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5GXKRnUNevxjG3Hi8rGTlWH75jM/zeQAeaJ7gT/OK8dZI8PFBegoYgfA1yfmpwx+nm7QVWbwPlp5G8XyxU3gLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5097
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTMwIGF0IDEzOjI0IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gTW9uLCBBdWcgMzAsIDIwMjEgYXQgMTowNCBQTSBDaHVjayBMZXZlciBJSUkNCj4g
PGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEhpIE9sZ2EtDQo+ID4g
DQo+ID4gPiBPbiBBdWcgMzAsIDIwMjEsIGF0IDEyOjUzIFBNLCBPbGdhIEtvcm5pZXZza2FpYQ0K
PiA+ID4gPG9sZ2Eua29ybmlldnNrYWlhQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiANCj4gPiA+
IEZyb206IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiA+ID4gDQo+ID4g
PiBHaXZlbiB0aGUgcGF0Y2ggIkFsd2F5cyBwcm92aWRlIGFsaWduZWQgYnVmZmVycyB0byB0aGUg
UlBDIHJlYWQNCj4gPiA+IGxheWVycyIsDQo+ID4gPiBSUEMgb3ZlciBSRE1BIGRvZXNuJ3QgbmVl
ZCB0byBsb29rIGF0IHRoZSB0YWlsIHBhZ2UgYW5kIGFkZCB0aGF0DQo+ID4gPiBzcGFjZQ0KPiA+
ID4gdG8gdGhlIHdyaXRlIGNodW5rLg0KPiA+ID4gDQo+ID4gPiBGb3IgdGhlIFJGQyA4MTY2IGNv
bXBsaWFudCBzZXJ2ZXIsIGl0IG11c3Qgbm90IHdyaXRlIGFuIFhEUg0KPiA+ID4gcGFkZGluZw0K
PiA+ID4gaW50byB0aGUgd3JpdGUgY2h1bmsgKGV2ZW4gaWYgc3BhY2Ugd2FzIHByb3ZpZGVkKS4g
SGlzdG9yaWNhbGx5DQo+ID4gPiAoYmVmb3JlIFJGQyA4MTY2KSBTb2xhcmlzIFJETUEgc2VydmVy
IGhhcyBiZWVuIHJlcXVpcmluZyB0aGUNCj4gPiA+IGNsaWVudA0KPiA+ID4gdG8gcHJvdmlkZSBz
cGFjZSBmb3IgdGhlIFhEUiBwYWRkaW5nIGFuZCB0aHVzIHRoaXMgY2xpZW50IGNvZGUNCj4gPiA+
IGhhcw0KPiA+ID4gZXhpc3RlZC4NCj4gPiANCj4gPiBJIGRvbid0IHVuZGVyc3RhbmQgdGhpcyBj
aGFuZ2UuDQo+ID4gDQo+ID4gU28sIHRoZSB1cHBlciBsYXllciBkb2Vzbid0IHByb3ZpZGUgWERS
IHBhZGRpbmcgYW55IG1vcmUuIFRoYXQNCj4gPiBkb2Vzbid0DQo+ID4gbWVhbiBTb2xhcmlzIHNl
cnZlcnMgc3RpbGwgYXJlbid0IGdvaW5nIHRvIHdhbnQgdG8gd3JpdGUgaW50byBpdC4NCj4gPiBU
aGUNCj4gPiBjbGllbnQgc3RpbGwgaGFzIHRvIHByb3ZpZGUgdGhpcyBwYWRkaW5nIGZyb20gc29t
ZXdoZXJlLg0KPiA+IA0KPiA+IFRoaXMgc3VnZ2VzdHMgdGhhdCAiQWx3YXlzIHByb3ZpZGUgYWxp
Z25lZCBidWZmZXJzIHRvIHRoZSBSUEMgcmVhZA0KPiA+IGxheWVycyIgYnJlYWtzIG91ciBpbnRl
cm9wIHdpdGggU29sYXJpcyBzZXJ2ZXJzLiBEb2VzIGl0Pw0KPiANCj4gTm8sIEkgZG9uJ3QgYmVs
aWV2ZSAiQWx3YXlzIHByb3ZpZGUgYWxpZ25lZCBidWZmZXJzIHRvIHRoZSBSUEMgcmVhZA0KPiBs
YXllcnMiIGJyZWFrcyB0aGUgaW50ZXJvcGVyYWJpbGl0eS4gVEhJUyBwYXRjaCB3b3VsZCBicmVh
ayB0aGUNCj4gaW50ZXJvcC4NCj4gDQo+IElmIHdlIGFyZSBub3Qgd2lsbGluZyB0byBicmVhayB0
aGUgaW50ZXJvcGVyYWJpbGl0eSBhbmQgc3VwcG9ydCBvbmx5DQo+IHNlcnZlcnMgdGhhdCBjb21w
bHkgd2l0aCBSRkMgODE2NiwgdGhpcyBwYXRjaCBpcyBub3QgbmVlZGVkLg0KDQpXaHk/IFRoZSBp
bnRlbnRpb24gb2YgdGhlIGZpcnN0IHBhdGNoIGlzIHRvIGVuc3VyZSB0aGF0IHdlIGRvIG5vdCBo
YXZlDQpidWZmZXJzIHRoYXQgYXJlIG5vdCB3b3JkIGFsaWduZWQuIElmIFNvbGFyaXMgd2FudHMg
dG8gd3JpdGUgcGFkZGluZw0KYWZ0ZXIgdGhlIGVuZCBvZiB0aGUgZmlsZSwgdGhlbiB0aGVyZSBp
cyBzcGFjZSBpbiB0aGUgcGFnZSBidWZmZXIgZm9yDQppdCB0byBkbyBzby4gVGhlcmUgc2hvdWxk
IGJlIG5vIG5lZWQgZm9yIGFuIGV4dHJhIHRhaWwgaW4gd2hpY2ggdG8NCndyaXRlIHRoZSBwYWRk
aW5nLg0KDQpUaGlzIG1lYW5zIHRoYXQgdGhlIFJETUEgYW5kIFRDUCBjYXNlcyBzaG91bGQgZW5k
IHVwIGRvaW5nIHRoZSBzYW1lDQp0aGluZyBmb3IgdGhlIGNhc2Ugb2YgdGhlIFNvbGFyaXMgc2Vy
dmVyOiB0aGUgcGFkZGluZyBpcyB3cml0dGVuIGludG8NCnRoZSBwYWdlIGJ1ZmZlci4gVGhlcmUg
aXMgbm90aGluZyB3cml0dGVuIHRvIHRoZSB0YWlsIGluIGVpdGhlciBjYXNlLg0KDQo+IA0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+IG5ldC9zdW5ycGMveHBydHJkbWEvcnBjX3JkbWEuYyB8IDE1IC0tLS0t
LS0tLS0tLS0tLQ0KPiA+ID4gMSBmaWxlIGNoYW5nZWQsIDE1IGRlbGV0aW9ucygtKQ0KPiA+ID4g
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94cHJ0cmRtYS9ycGNfcmRtYS5jDQo+ID4g
PiBiL25ldC9zdW5ycGMveHBydHJkbWEvcnBjX3JkbWEuYw0KPiA+ID4gaW5kZXggYzMzNWMxMzYx
NTY0Li4yYzQxNDZiY2YyYTggMTAwNjQ0DQo+ID4gPiAtLS0gYS9uZXQvc3VucnBjL3hwcnRyZG1h
L3JwY19yZG1hLmMNCj4gPiA+ICsrKyBiL25ldC9zdW5ycGMveHBydHJkbWEvcnBjX3JkbWEuYw0K
PiA+ID4gQEAgLTI1NSwyMSArMjU1LDYgQEAgcnBjcmRtYV9jb252ZXJ0X2lvdnMoc3RydWN0IHJw
Y3JkbWFfeHBydA0KPiA+ID4gKnJfeHBydCwgc3RydWN0IHhkcl9idWYgKnhkcmJ1ZiwNCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhZ2VfYmFzZSA9IDA7DQo+ID4gPiDCoMKgwqDC
oMKgIH0NCj4gPiA+IA0KPiA+ID4gLcKgwqDCoMKgIGlmICh0eXBlID09IHJwY3JkbWFfcmVhZGNo
KQ0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4gPiA+IC0NCj4g
PiA+IC3CoMKgwqDCoCAvKiBXaGVuIGVuY29kaW5nIGEgV3JpdGUgY2h1bmssIHNvbWUgc2VydmVy
cyBuZWVkIHRvIHNlZSBhbg0KPiA+ID4gLcKgwqDCoMKgwqAgKiBleHRyYSBzZWdtZW50IGZvciBu
b24tWERSLWFsaWduZWQgV3JpdGUgY2h1bmtzLiBUaGUNCj4gPiA+IHVwcGVyDQo+ID4gPiAtwqDC
oMKgwqDCoCAqIGxheWVyIHByb3ZpZGVzIHNwYWNlIGluIHRoZSB0YWlsIGlvdmVjIHRoYXQgbWF5
IGJlIHVzZWQNCj4gPiA+IC3CoMKgwqDCoMKgICogZm9yIHRoaXMgcHVycG9zZS4NCj4gPiA+IC3C
oMKgwqDCoMKgICovDQo+ID4gPiAtwqDCoMKgwqAgaWYgKHR5cGUgPT0gcnBjcmRtYV93cml0ZWNo
ICYmIHJfeHBydC0+cnhfZXAtDQo+ID4gPiA+cmVfaW1wbGljaXRfcm91bmR1cCkNCj4gPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7DQo+ID4gPiAtDQo+ID4gPiAtwqDCoMKg
wqAgaWYgKHhkcmJ1Zi0+dGFpbFswXS5pb3ZfbGVuKQ0KPiA+IA0KPiA+IEluc3RlYWQgb2YgY2hl
Y2tpbmcgZm9yIGEgdGFpbCwgd2UgY291bGQgY2hlY2sNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDC
oCBpZiAoeGRyX3BhZF9zaXplKHhkcmJ1Zi0+cGFnZV9sZW4pKQ0KPiA+IA0KPiA+IGFuZCBwcm92
aWRlIHNvbWUgdGFpbCBzcGFjZSBpbiB0aGF0IGNhc2UuDQo+IA0KPiBJIGRvbid0IGJlbGlldmUg
dGhpcyBpcyBhbnkgZGlmZmVyZW50IHRoYW4gd2hhdCB3ZSBoYXZlIG5vdy4gSWYgdGhlDQo+IHBh
Z2Ugc2l6ZSBpcyBub24tNGJ5dGUgYWxpZ25lZCB0aGVuLCB3ZSB3b3VsZCBzdGlsbCBhbGxvY2F0
ZSBzaXplIGZvcg0KPiB0aGUgcGFkZGluZyB3aGljaCAiU0hPVUxEIE5PVCIgYmUgdGhlcmUuIEJ1
dCB5ZXMgaXQgaXMgYWxsb3dlZCB0byBiZQ0KPiB0aGVyZS4NCj4gDQo+IFRoZSBwcm9ibGVtLCBh
cyB5b3Uga25vdyBmcm9tIG91ciBvZmZsaW5lIGRpc2N1c3Npb24sIGlzIGFsbG9jYXRpbmcNCj4g
dGhlIHRhaWwgcGFnZSBhbmQgaW5jbHVkaW5nIGl0IGluIHRoZSB3cml0ZSBjaHVuayBmb3IgdGhl
IE52aWRpYQ0KPiBlbnZpcm9ubWVudCB3aGVyZSBOdmlkaWEgZG9lc24ndCBzdXBwb3J0IHVzZSBv
ZiBkYXRhICh1c2VyKSBwYWdlcyBhbmQNCj4gbmZzIGtlcm5lbCBhbGxvY2F0ZWQgcGFnZXMgaW4g
dGhlIHNhbWUgc2VnbWVudC4NCj4gDQo+IEFsdGVybmF0aXZlbHksIG15IGFzayBpcyB0aGVuIHRv
IGNoYW5nZSBycGNyZG1hX2NvbnZlcnRfaW92cygpIHRvDQo+IHJldHVybiAyIHNlZ3MgaW5zdGVh
ZCBvZiBvbmU6IG9uZSBmb3IgdGhlIHBhZ2VzIGFuZCBhbm90aGVyIGZvciB0aGUNCj4gdGFpbC4N
Cj4gDQo+ID4gDQo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJwY3JkbWFfY29udmVy
dF9rdmVjKCZ4ZHJidWYtPnRhaWxbMF0sIHNlZywgJm4pOw0KPiA+ID4gLQ0KPiA+ID4gLW91dDoN
Cj4gPiA+IMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KG4gPiBSUENSRE1BX01BWF9TRUdTKSkNCj4g
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlPOw0KPiA+ID4gwqDCoMKg
wqDCoCByZXR1cm4gbjsNCj4gPiA+IC0tDQo+ID4gPiAyLjI3LjANCj4gPiA+IA0KPiA+IA0KPiA+
IC0tDQo+ID4gQ2h1Y2sgTGV2ZXINCj4gPiANCj4gPiANCj4gPiANCg0KLS0gDQpUcm9uZCBNeWts
ZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
