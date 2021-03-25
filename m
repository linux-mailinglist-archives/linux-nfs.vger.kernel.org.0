Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477D8348678
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Mar 2021 02:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhCYBjg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Mar 2021 21:39:36 -0400
Received: from mail-dm3nam07on2137.outbound.protection.outlook.com ([40.107.95.137]:54362
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230016AbhCYBj2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 24 Mar 2021 21:39:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQnebYTAsrUyY365jAhILZ5nkzoEAPjm3MtSa9S5bXQsg3WcOmCo02kAmLyegfAmLZuoApp0tD5/o+BjuaRV+6Afly2KdZAm+3c3JuJgL4YtWToktzpeNNxGu+v+asxDn83R1gXxP23BkbP8FIh8Qa0465wyUXo8EElCvIzoISBk3CPHejqWrgM3zLOF7mBK3LWEnD/sw4yZl1/SDAo1opJAbHP1QsRYoFn91iaFc9IcZBqpDz0UmaNzzm/CQau638XXN5nmE4rCG84dTWeYjA2HMcC7VqsJ3WQxwRd6CP15eN7K3MwzuQKowlTpO7uisXWsfFRuvGWZFbfqcl4V8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRb9SpeoVZyV6VVZqEql8WG42DSgpJXVCtSYXCStFCE=;
 b=J72EYXX2WIyAxQ3eTQ3HwsHWxgQvM+bJnjE1hSF/wbQqiJJc5hY9lIurPzWgMTuJq2qkwBUxdFJVmPzU+ffH4i8UY31RY9cgmzZ7ilrmjvp5eVfVY/7F6uaeeyDUSHKYg2CMLEVCh+i08RZf7x03HEXcl6oC8Nrihna89XaWwbvQsjUt6t+m2k9QeTESIMfBemIYvR8JNcDMQAq3ygkk+Ji+b72kvurDOqDQ+rWisWz3P7h44ZuGsfeuO5a+vowYhnPALbvz3RH3rb54rNnsCFM0FNvv34+Cu73CS9IMSRDSCc36q+G4chhsBvAcDChoAEqnVlJzGs3kx6/vc7D5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRb9SpeoVZyV6VVZqEql8WG42DSgpJXVCtSYXCStFCE=;
 b=AQbLIK4PkY0wWaz/xlJ+FyUyXVrmpxSPLteZYWiEUmBcHddV+ohiYZZQL0Y8aky/VkM2R3LL4jeJLF53x3uyjswj0VrnpJ+3juUynM7RIRkT3+BkDHE+RFG+L4Mz0WqpMdIqaKfwwG1irbbluC4Tin2TAZst5sVWZOR9HEh5er4=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3558.namprd13.prod.outlook.com (2603:10b6:610:2c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9; Thu, 25 Mar
 2021 01:39:18 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3977.026; Thu, 25 Mar 2021
 01:39:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@redhat.com" <bfields@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH] NFS: fix nfs_fetch_iversion()
Thread-Topic: [PATCH] NFS: fix nfs_fetch_iversion()
Thread-Index: AQHXIOeT6CWkg3bvZ020WefkaB7PS6qTphqAgABHaoA=
Date:   Thu, 25 Mar 2021 01:39:17 +0000
Message-ID: <9da4fcc8f12c3985606a88c74e3c0e60b6389e18.camel@hammerspace.com>
References: <20210324195353.577432-1-trondmy@kernel.org>
         <YFut25Sq1wvv8Zii@pick.fieldses.org>
In-Reply-To: <YFut25Sq1wvv8Zii@pick.fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 486e75eb-1e43-4b60-519b-08d8ef2ece36
x-ms-traffictypediagnostic: CH2PR13MB3558:
x-microsoft-antispam-prvs: <CH2PR13MB3558A7A9171C200C3ED0BBC3B8629@CH2PR13MB3558.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oPcXBV96qP/W3WJU514olQ1MRaAnApkLw0bTqUAjTh02EMV9rDHBOHPEDRxj3J5luMVt69iUQqObmkkOj/9dGKk+4kuD0ss6BKi451ZM+tKoiuRHiIUmUWDedAAA19KukRePacV4MOZ+w3YUvcr4zfSvBNeE+Yf1R6egkHk1Tag1trc5dfxiaL0Fxgj1j29iKgKE3ZBN2ZmI98IwM/4JVXPSsFBFW4EfhUSUclpfKMOdFpzIZfef6XU/VzaqkoFdfS7VpxS5r+F9/Rf/yvDOJZ2GDymG6mTc322Dd4i6AkZemzyMjueSWej3F6RRxS1stygbgMhkjnKst+uDD4I6mWe0dai2CrmQGfzEILeI5lIOzLGyjzouS13Xt5ILD9oj5MCkxA0G7zRuQ2Eic2jcOd1ivFcFOMNMU81o+6vsPdHGp8ezjBmTHETHH/iYmwAm9A0TP3yU++XqMvYfturro3LqVak0/i6u4eqb2Yx/ZtrYJyhGGqRuAQFmEXTwn6FWmHo3xwJEFVbRdTY1L2hMIgouvkUOOKJOD4MCErW6VPuqWoTGlGS+PzU9yljTHnWLruPTZ0hGvM6a2xQ/A1s0dIOyjFWBRqhPtiuG2QV0vRkTBddo7TJNHyiWy19eObYlWq3szTSWE7HrreEUYdxzg9yPM64AjLxmFiw9Oa8BM64=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39840400004)(366004)(396003)(376002)(64756008)(66446008)(66476007)(6512007)(76116006)(36756003)(66946007)(83380400001)(66556008)(8936002)(6506007)(8676002)(5660300002)(186003)(4326008)(2906002)(38100700001)(478600001)(2616005)(86362001)(316002)(71200400001)(6486002)(54906003)(6916009)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RnpITWptQndRZExYTng3N05jLzVJWWsyV3lSemdpM3NMOHFpUlRkWFN1d1pi?=
 =?utf-8?B?eU0wdWQ5cHg2MStZRGVqQUVUaVl2WVE2WUtQaDBTbnNBeUpkY0hDTlEzRzRp?=
 =?utf-8?B?TGQyQ0pLWnR3ODVaVjhXak9MdFFjRzlFYzE3anZJQUVHTFJydmE3Zmd4SDhO?=
 =?utf-8?B?QmFFMElMVDhQRHhEaDVVemQ1NmtaaTlVZUdoSmRNREZjNjdmUTRkZytQSnc3?=
 =?utf-8?B?Q1B0aEVwYWFjL1doaHN5dDQ0ZXc0K2xGaCtvMXRHdlRjRFAzRXdET0laRmZn?=
 =?utf-8?B?TWhXOUJvQm9CSXhxelNZa3ZIMThzcFhVUWtpZ3ZJYURrd3JRV3FFWTd0WW9U?=
 =?utf-8?B?aVZvUVZGa292eGJZekVuSmdOUjl0NnYyOVFuQkM3b1ZmVkxyZDlKNUZvSmEw?=
 =?utf-8?B?UHQzS2YzRE5Rdmo0YmRWOFZydllFbUlzYnNYWmdKZUErU1czcjk3eWtXZTNV?=
 =?utf-8?B?bWk5TDVkUmNwNm43SGZCQ0NROWVEMjZEZGcwcWJ1L0dPT2xBZzN4UXgzWjFI?=
 =?utf-8?B?Z1pJeVZRN1gxeW9yNHJmOG1KUWxuMUpHWkVuendnZkVSazI4VUdJbHZSNTBm?=
 =?utf-8?B?RzZFMVlmT1F3V1hxRkp6VVhuUGljZmx2TzBJWVZBSlF6KzYxZ2FsZzZ4VkVY?=
 =?utf-8?B?Rjd6QVU2UjlYdzlOcSt0eFltb1piY2YvVEpWb3c1ZUVOd3FQVmRTdjUzRkN2?=
 =?utf-8?B?eWYzUVlKemFNSnlMcVNSUTZtZEpXV2w4aUxscCtIZmRTcXlOc0l5N0YvQkdw?=
 =?utf-8?B?T2ErQzNwTUJFS3ZDR1NBYk9ndVpIVHNQcVp5UXBHNEloSWR1RXo3WXAwS1Ba?=
 =?utf-8?B?VG9aVFJ2ZkMyOCtFeWQ3RTV3cUpvajJBUERmRkxnVlQ1QjliZGZ0WFhFQVd6?=
 =?utf-8?B?a0VkWGtHdE9sdzc1UzJZamRGeVNWYlVXT3JjSjNRYWtUb1Bmd3N1eUNxZW1F?=
 =?utf-8?B?Nk9lc3pPbW8zVHBVdUFOcGxjcWdUZnJYWDVMM1dTQjRJSGxYNTNRaytuRWsx?=
 =?utf-8?B?enJlMjBEQzhoS0xRME9QczZFMVFXencyU01IRlV5QmFKbE8vUVQ1bmkvVXJE?=
 =?utf-8?B?ZDExUE5hVEtNaE00OTBHVWZ3bHRHRkhzb3ZPR1ZZYThSdG1UWFRxek8xL2gr?=
 =?utf-8?B?eGtqRGNablNJOEp0ZGFnMzFjODNoQ2ZUcTkrVVZnVXlncWNVcXBoZHg3MS9P?=
 =?utf-8?B?bG9rMjZwcnZEV2U0ZWt3NGNnS1hyM2ROQVRqT09NK3dSMkRIWU44NzJaWjgv?=
 =?utf-8?B?OUl4Tm1zUXZIN0dpMUZ3b1I2UUFzMFUxZng0QVFiSXpOQlJvNm9HWmxHcUc5?=
 =?utf-8?B?SWUwQUlrOEhvTzZEWitWT2ZqbUtjdmxHUyt2WUNxQ1R5OFIwM3dSbWhaUW1n?=
 =?utf-8?B?N2Q1QUFJNXVHZ0MrSlYwQ1pKRXJBNG9yZUVWYjNyemRsTzNNckdQdFhDLzRi?=
 =?utf-8?B?WHFtNzBIM2xGRkIyNnIvbUJsRDB0N0tjeDBBbUkwVXRXTG1rSW5CazM2a09U?=
 =?utf-8?B?REdtMWlXWTVWY1lkdWo1Q1lHRTEvYTk3WUZNNzhVSHNtK0FSMXVwLzhubk52?=
 =?utf-8?B?NjBTcXRtZ3dnTUxFMkZ4aXlwSHJEMDM5dEl5TnNQeFVwMmZSOUNhQ3l3Ung4?=
 =?utf-8?B?N1AwN2hBMy9iQmduL0R6dytnVTFQUnprQzlYb0dBMys4TGV6Qk9DKzJDdnBL?=
 =?utf-8?B?MEo2clpodlpJbXVMZ25ka3dFdjVtTi9nZDdEMDRMS0NxSStiQzEzK1Q0Skhs?=
 =?utf-8?Q?Yoez+ckp9lTtOhRKBkzMdKHhM3tN2VfLrVyarAu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <551286EC3B55C849B8575BA1BDCE4F97@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486e75eb-1e43-4b60-519b-08d8ef2ece36
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 01:39:17.8996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsnLYJf2E63/++KVnO9UO/9K5GbFBcq/nSaFYoLcfpaus2gDRDnwW9UldCsR+cLIOQbt6Uvnc3+2X6kfWGf34A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3558
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTAzLTI0IGF0IDE3OjIzIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFdlZCwgTWFyIDI0LCAyMDIxIGF0IDAzOjUzOjUzUE0gLTA0MDAsIHRyb25kbXlAa2Vy
bmVsLm9yZ8Kgd3JvdGU6DQo+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IA0KPiA+IFRoZSBjaGFuZ2UgYXR0cmlidXRlIGlzIGFs
d2F5cyBzZXQgYnkgYWxsIE5GUyBjbGllbnQgdmVyc2lvbnMgc28NCj4gPiBnZXQgcmlkDQo+ID4g
b2YgdGhlIG9wZW4tY29kZWQgdmVyc2lvbi4NCj4gDQo+IFRoYW5rcyENCj4gDQo+IEknbSB1bmNs
ZWFyIHdoZXRoZXIgdGhlcmUncyBhIHVzZXItdmlzaWJsZSBidWcgaGVyZSBvciB3aGV0aGVyIGl0
J3MNCj4gbWFpbmx5IGNsZWFudXA/DQo+IA0KDQpJdCBpcyBtYWlubHkgYWJvdXQgZW5zdXJpbmcg
dGhhdCByZXZhbGlkYXRpb24gaXMgZG9uZSBjb3JyZWN0bHkuIEl0IGlzDQphIHBlcmZvcm1hbmNl
IGlzc3VlLCBidXQgaXMgYWxzbyBhYm91dCBlbnN1cmluZyB0aGF0IHdlIGFsbCBmZWVkIGludG8N
CnRoZSBzYW1lIHZhbGlkaXR5IGNoZWNraW5nIGNvZGUuDQoNCj4gLS1iLg0KPiANCj4gPiBGaXhl
czogM2NjNTVmNDQzNGI0ICgibmZzOiB1c2UgY2hhbmdlIGF0dHJpYnV0ZSBmb3IgTkZTIHJlLQ0K
PiA+IGV4cG9ydHMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGZzL25mcy9leHBvcnQu
YyB8IDE1ICsrKystLS0tLS0tLS0tLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9leHBv
cnQuYyBiL2ZzL25mcy9leHBvcnQuYw0KPiA+IGluZGV4IGYyYjM0Y2ZlMjg2Yy4uYjM0N2UzY2Uw
Y2M4IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mcy9leHBvcnQuYw0KPiA+ICsrKyBiL2ZzL25mcy9l
eHBvcnQuYw0KPiA+IEBAIC0xNzEsMTcgKzE3MSwxMCBAQCBzdGF0aWMgdTY0IG5mc19mZXRjaF9p
dmVyc2lvbihzdHJ1Y3QgaW5vZGUNCj4gPiAqaW5vZGUpDQo+ID4gwqB7DQo+ID4gwqDCoMKgwqDC
oMKgwqDCoHN0cnVjdCBuZnNfc2VydmVyICpzZXJ2ZXIgPSBORlNfU0VSVkVSKGlub2RlKTsNCj4g
PiDCoA0KPiA+IC3CoMKgwqDCoMKgwqDCoC8qIElzIHRoaXMgdGhlIHJpZ2h0IGNhbGw/OiAqLw0K
PiA+IC3CoMKgwqDCoMKgwqDCoG5mc19yZXZhbGlkYXRlX2lub2RlKHNlcnZlciwgaW5vZGUpOw0K
PiA+IC3CoMKgwqDCoMKgwqDCoC8qDQo+ID4gLcKgwqDCoMKgwqDCoMKgICogQWxzbywgbm90ZSB3
ZSdyZSBpZ25vcmluZyBhbnkgcmV0dXJuZWQgZXJyb3IuwqAgVGhhdA0KPiA+IHNlZW1zIHRvIGJl
DQo+ID4gLcKgwqDCoMKgwqDCoMKgICogdGhlIHByYWN0aWNlIGZvciBjYWNoZSBjb25zaXN0ZW5j
eSBpbmZvcm1hdGlvbiBlbHNld2hlcmUNCj4gPiBpbg0KPiA+IC3CoMKgwqDCoMKgwqDCoCAqIHRo
ZSBzZXJ2ZXIsIGJ1dCBJJ20gbm90IHN1cmUgd2h5Lg0KPiA+IC3CoMKgwqDCoMKgwqDCoCAqLw0K
PiA+IC3CoMKgwqDCoMKgwqDCoGlmIChzZXJ2ZXItPm5mc19jbGllbnQtPnJwY19vcHMtPnZlcnNp
b24gPj0gNCkNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGlub2Rl
X3BlZWtfaXZlcnNpb25fcmF3KGlub2RlKTsNCj4gPiAtwqDCoMKgwqDCoMKgwqBlbHNlDQo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiB0aW1lX3RvX2NoYXR0cigmaW5v
ZGUtPmlfY3RpbWUpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChuZnNfY2hlY2tfY2FjaGVfaW52
YWxpZChpbm9kZSwgTkZTX0lOT19JTlZBTElEX0NIQU5HRSB8DQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+ID4gTkZTX0lOT19SRVZBTF9QQUdFQ0FDSEUp
KQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX25mc19yZXZhbGlkYXRlX2lu
b2RlKHNlcnZlciwgaW5vZGUpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBpbm9kZV9wZWVr
X2l2ZXJzaW9uX3Jhdyhpbm9kZSk7DQo+ID4gwqB9DQo+ID4gwqANCj4gPiDCoGNvbnN0IHN0cnVj
dCBleHBvcnRfb3BlcmF0aW9ucyBuZnNfZXhwb3J0X29wcyA9IHsNCj4gPiAtLSANCj4gPiAyLjMw
LjINCj4gPiANCj4gDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K
