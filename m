Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28F64865E4
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 15:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbiAFOP1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 09:15:27 -0500
Received: from mail-dm6nam08on2125.outbound.protection.outlook.com ([40.107.102.125]:38049
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240016AbiAFOPS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 6 Jan 2022 09:15:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHYR15ISWOnaSMfixkf8KOZiDuZWfSTk3ZBA2/xJJBQrbXFAarYZ6oRuZgSJd7wuMPT4I0+HzrvToicg+Y58nsYx2MzaY2KwYDIKMHcW8Ejgb+trT2pT3CsEvnFd21qZZ5ak7mGiMAmND0qEvdC0MWn+4J/JuZq9mz7MYw7oTm1umiR367Df94MvUN6sWXHG8Ido30V0BFS51rL4sKWC8WU5I26m7HO5SSn7FcQTtjXlPW1LEFJGcp4OEoFSwhT/mV4r5Zo1Xb37oD6m1yeKgKw04FfMVW50urPssc+4rzgXPBEyRvcBWbb7Bt97E4zirXfKUWVGt0rByB26/in96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es/lapKVrNvzcSOmtUwTiiaiFCeiOdznVtGrOvtPb2U=;
 b=YWB7SHa3CWmYmWxmYxO2bNE9vaIKVHH9FfW7K1NdB/E08qt5QhvFe5rEHD2yJp3FI4K4DDnzxWTyg5NwnwFBswVzIBrvvPXgT+325h7Cg9kWNj16ExUjjT0Sz+J1QLzOcctnkuNi/cHCTCoLTvWDjESjI0+JGwc5mB2bS3PKaDW6vG2dEHwseakjXJaSdy7YnnWaL6mgOABz2IRgQvTi/O+Y5uBIximwhlAhBMsQ2pqNNYn5kmqcK62cu5lzu54oRg9WOCIXlf6tU1IlhxvT/FLA83ydNJGp+rdzoMrA2aaH/P+QaLpy1Vi68zufU43cA8ElSdE5kL5ie8rUGx6TfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es/lapKVrNvzcSOmtUwTiiaiFCeiOdznVtGrOvtPb2U=;
 b=YslYI62Ud7ikipIbG9XDRPDNYubp5/rirnbrdmnwbeH8sh84joeihBnj0UkEetkaYRkApflwzKCQFLxeUJALsBrm2HQctiZcAOkhyaCmQuA2tGjXf2Fai/jO8ACtHoW5I2q+a+OctBcG5uUWGx/5TBxLZBj2CusTf/7VWV8ucpU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MWHPR13MB1054.namprd13.prod.outlook.com (2603:10b6:300:13::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.4; Thu, 6 Jan
 2022 14:15:15 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 14:15:14 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "ondrej.valousek.xm@renesas.com" <ondrej.valousek.xm@renesas.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Topic: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Thread-Index: AQHX84heTqWsdlviIkSCjyYpUqzp8qxR4CyAgAAAK4CAAsPkgIAAAVsAgAAIb4CAAAQPgIABJyiAgABPV4A=
Date:   Thu, 6 Jan 2022 14:15:14 +0000
Message-ID: <a12cfed3e997507ec837aefbd63aa4ff7b34fd4d.camel@hammerspace.com>
References: <20211217204854.439578-1-trondmy@kernel.org>
         <20220103205103.GI21514@fieldses.org>
         <2b27da48604aaa34acce22188bfd429037540a89.camel@hammerspace.com>
         <DU2PR10MB5096010E9570E2718198EDD5E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
         <20220105151008.GB24685@fieldses.org>
         <DU2PR10MB5096501FB8A162D18CF1F1F2E14B9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
         <20220105155451.GA25384@fieldses.org>
         <DU2PR10MB5096923D24D76EC264A51EBFE14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DU2PR10MB5096923D24D76EC264A51EBFE14C9@DU2PR10MB5096.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c32ee5e9-dbe3-4e5e-29c5-08d9d11ef590
x-ms-traffictypediagnostic: MWHPR13MB1054:EE_
x-microsoft-antispam-prvs: <MWHPR13MB105400D07DC8727662960E0CB84C9@MWHPR13MB1054.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qLNAd4Jt02ZyYLqam1S29kKKv5FhPO5+Evmeqr77SrU8o0WMMMurn1IBrQFywWXVm2wepZpYXR2t9gp0XMJm/57xdeKyMOtrm7i3gmt2mfqe1X7fQMl8y7g8G9Xe3i/Wkbznxr6h4Jzmut5ykEa8ImcADqAaVyrV9m30XB9tzgfwwqKcd18uHbe6BdN8s0G5/odY+/sqmFaFCVKkRdi1eJMW2GYttD9EmWcFExOlRwUoV16rbqUHCMuLaBYe/EnIFEILKg2oEWK4KE9Y2N5fvQhzBKlUF3LdiRRxLgf8hF2ELIGGi7Oh3aIDgNS1mFpU7nHGRwwlKZ2GY9ggvhdsjFWMsMvIlNM8XuvpFLU1zOKMTDj8EUqsoEiJju7vXyF7PKYn2toIViW1ax2bYgZEOuOYPdLV1lh569ssDr/XQehYYtOgFTTAHg1PFs+UJU37riTUurgQ7eMeI067s6ldcVvejXMPYHSr43ZKqUmK+15QdV9dClxNbav8yzEs8G73KKXQfE+BU3fBb1nOTgWJ777dn8B1OlUixScG0Sk4AEcQkk+rUgYOtSjU/jKrO15q5eIFgyhNuPVFBqI6hXT2Pq6d/vQEHQMjMjK2PmJxgXXeG90EigT79d4ESFrCdIZX8ixaT9qnL8Ii6oKAzYB7Yqds3AC1K+NYtaXf8qMzi1H5K2RHQ5SjtTwlGKWxA8tWIGNKkMVGRSswXMcSyeujP47mvHL1iN1Ots1hxz+JKnJWcZmBg9mxnwwywAiQVQHd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(136003)(366004)(39830400003)(376002)(83380400001)(122000001)(36756003)(38100700002)(2906002)(4744005)(38070700005)(66946007)(8676002)(4326008)(316002)(8936002)(71200400001)(66446008)(64756008)(5660300002)(86362001)(508600001)(66476007)(76116006)(26005)(186003)(110136005)(54906003)(6506007)(2616005)(6486002)(66556008)(6512007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU5JZCtsU0JtQzJuMzZ0OUNVeTN5ckI2blI5aU82bzAxU3RYemt3cWtBNHNV?=
 =?utf-8?B?aC92WVRGc2JIeEIzSnpvOHlIYkFhVmR0Z2dVQlNoUU0yZFZTbURJbjkySC9Q?=
 =?utf-8?B?WXlha3paVGVMSzVid2xPcklXdmRhMVFhaUF1VUxLRG1FUjNZSjhsWDYxelFS?=
 =?utf-8?B?dTg0Q3h6cHNKaFBEQ0RJVXRLVUc4c2s3b1V2UzRkZldwOTh5MUdFVUJxN3RE?=
 =?utf-8?B?RXNDaTdJdG8xY0lvOTYvV25TM084MmdtTWFhNldTZEFkelJ5YjdjR0pQanp5?=
 =?utf-8?B?NUVVbklLNW9lMitmQkVTWUlCdGxoV0dxTU5EZVVqM2s4ZVN5QnRKMG8zVlFu?=
 =?utf-8?B?K2hVQURFVU1WQ2JES0ZVdTNjNW9HaEFkL1FMM3plR0lhc2VTdEcwcHFpZ1ZT?=
 =?utf-8?B?citaVzk2dzFYS3QyZnBTZXp3dXEzd1B3bktXYkZJZVNXY1U1UnowZmdXazJ5?=
 =?utf-8?B?QzE4Y1pDdkJ0QmJvRjVRYVg1YWUwcHFPbHEzWnpJUmhsS0JHaWJ3TUlMdzhD?=
 =?utf-8?B?cHlaK1l6djB6Z1pHODFkUk90TlpDbXVKWnBLdGJMUC9Wd0c5RU5mTDdmTmJP?=
 =?utf-8?B?M21uNEI4SFpoeWtsZDNDODBpNjloZitJWi9SR3h3ZmwrVmdHSWlsd0V5WGhu?=
 =?utf-8?B?dTZqdjNkM2FpSnc5SkV2RjJHNkJYd21zL3BiZlRTYnNFRkF3TzFmMUZQbzZB?=
 =?utf-8?B?MFp1QzF3bFdGNkRFYmJiTmo2RnRLTWt3c0tNak9wZ0tieXN0NUxabXJqZitX?=
 =?utf-8?B?R1RTQkdLTVlJd3NqR0pCeWlLdUM0VXRoVUJoWE44UmFVakJ1UEJzVjlyNXIy?=
 =?utf-8?B?YVRxVkRlY2c1K21KNHpENnQvZ0JwY0ttM01yMmFhMFIyMGY3d3NaOCtYQXJs?=
 =?utf-8?B?TkxlWmN5R3dFNnN5ZUordm1odEZ2Sk8xdGJqR0x6akc2OXdwbDY1QVdKOTNT?=
 =?utf-8?B?R3hIQkdlbGFzOEM3QTBYTGZWVUlKYm5KUHFmSmFQY01mSHlFUEdzS0ZRZWRG?=
 =?utf-8?B?dUFjTXhBMFR4elM3UExPS2tNaUEzTXpZWFdQSEh2ak5VOHJTTE1neXRFVVJM?=
 =?utf-8?B?SzlXUjlrWTRydTd5QjBEOXdVblFlbGFhNnV3eWd2UnkvaWx2cHM1cGZVVDJD?=
 =?utf-8?B?Y1NiMSt0eUhXS3BDbVlSYzB4ajQ1SUgzVUhtYkhhQ1BnK2llUFNwdmUyVHht?=
 =?utf-8?B?WTZMdG9YRmtPcENsTnZKNXVUYlBYVjU4V255NXkwYjFnS0I0R0xMZW5JY0tH?=
 =?utf-8?B?QUQvdEJJOWlmbHhuSmd1eHhTMllWY0pWdmJWcExZR0lDVGRuVEg0Smh6UmpV?=
 =?utf-8?B?M1E3bEVBUWY5RkFKZ3hFcGNEdlc1YVdtbDIvOC9FeWgvamZxSnlPTTNBOVhB?=
 =?utf-8?B?NUFnbWJlcnp3dmN3SEU5MVl2aFdWOWpjMzRXVTNCREQ5MVExTUpaSVdpUWxL?=
 =?utf-8?B?YTI0OGtUc1JlakNCek5mZWV0TTdHZzlLZytnYTR0RjNHMnFOaTlrcXduSkI4?=
 =?utf-8?B?T3A5N1FiUWwyY2JpQ2tnbFBzTVVMblpyOURudWZWQWw0cTB3WmpkQUJvNWVa?=
 =?utf-8?B?b3VnZ3MwZWdhVk5MOXlIZDBBa2h0YWZYZjZNUUxoVlVmZ1BrczhsMmgwTEpD?=
 =?utf-8?B?UklhUkZDK05ONXVUcHJSQUoycmRvMVk0eGpUbFFpalJ4YVJveldKVmQyMHdk?=
 =?utf-8?B?ZEUrMEtkd2Q4S1REMDE3dkpmeXkxQXhTUS9sVDhvTzV2T1dnTzRGMXhDRFN3?=
 =?utf-8?B?RVlTOG9XNFNJdnl3QzZwckZpSXlDajdkb2lQWitYTlN6QTQ2Rk0wQ2ZsdVl1?=
 =?utf-8?B?Nm00OGhoN2xBNnoyazJoSDU3bTFBWkgxaExiNmRhTG5UckZ0YXVoK1JPcGFk?=
 =?utf-8?B?Y1ozTkdJRzduVTlrdGh5NXlVYUFWMFhPZkJ5cFpramlEem90TU9HWjFMMldZ?=
 =?utf-8?B?WkdRQ05uTlFoTzNvNlI3NXdibXN5cVNRV3EwTXpILzh1a1Z4NE9GN1o1cXls?=
 =?utf-8?B?U3BoQXU1MDdZWHZMdFB4cjc3MHJaNWg4aG41NVcrNFFDVWV3UnJEajlpMFg3?=
 =?utf-8?B?KzF2MHB0VllubGlxTUM3M1FJNmhzVERMazFFVkVheFh4WVZGc3VsS1g5cEpz?=
 =?utf-8?B?ZmZmSWhsQnpmUWxYV0NmQWdCcWNCN1NOdUdGS01LZitOMW1ZeWpWeGYyaDQv?=
 =?utf-8?Q?WviiWhE/Ma75T+//wCSc8AU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDD5BE32A3B1924AAFAD972FFE3FF655@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32ee5e9-dbe3-4e5e-29c5-08d9d11ef590
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 14:15:14.7471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkMZvjWE0yGaFpbjVuyRlwRpYkgyEHHTBDUUet2g9wV1P85Z7XRfTaDvIMXynZhDQzgb8kjvUJu/Rf1GX8ZCFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1054
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTA2IGF0IDA5OjMxICswMDAwLCBPbmRyZWogVmFsb3VzZWsgd3JvdGU6
Cj4gTG9va3MgbGlrZSB0aGlzIHNob3VsZCBkbyBJIGd1ZXNzLi4uCj4gCj4gZGlmZiAtLWdpdCBh
L2ZzL25mc2QvbmZzNHhkci5jIGIvZnMvbmZzZC9uZnM0eGRyLmMKPiBpbmRleCA1YTkzYTVkYjRm
YjAuLmJlNDdlMWRkNmRhNSAxMDA2NDQKPiAtLS0gYS9mcy9uZnNkL25mczR4ZHIuYwo+ICsrKyBi
L2ZzL25mc2QvbmZzNHhkci5jCj4gQEAgLTMyNjUsNiArMzI2NSwxNCBAQCBuZnNkNF9lbmNvZGVf
ZmF0dHIoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwKPiBzdHJ1Y3Qgc3ZjX2ZoICpmaHAsCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHAgPSB4ZHJfZW5jb2RlX2h5cGVyKHAsIChzNjQp
c3RhdC5tdGltZS50dl9zZWMpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqcCsr
ID0gY3B1X3RvX2JlMzIoc3RhdC5tdGltZS50dl9uc2VjKTsKPiDCoMKgwqDCoMKgwqDCoCB9Cj4g
K8KgwqDCoMKgwqDCoCAvKiBzdXBwb3J0IGZvciBidGltZSBoZXJlICovCj4gK8KgwqDCoMKgwqDC
oMKgIGlmIChibXZhbDEgJiBGQVRUUjRfV09SRDFfVElNRV9DUkVBVEUpIHsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHAgPSB4ZHJfcmVzZXJ2ZV9zcGFjZSh4ZHIsIDEyKTsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghcCkKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9yZXNvdXJjZTsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHAgPSB4ZHJfZW5jb2RlX2h5cGVyKHAsIChzNjQp
c3RhdC5idGltZS50dl9zZWMpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKnAr
KyA9IGNwdV90b19iZTMyKHN0YXQuYnRpbWUudHZfbnNlYyk7Cj4gK8KgwqDCoMKgwqDCoMKgIH0K
PiDCoMKgwqDCoMKgwqDCoCBpZiAoYm12YWwxICYgRkFUVFI0X1dPUkQxX01PVU5URURfT05fRklM
RUlEKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBrc3RhdCBwYXJl
bnRfc3RhdDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTY0IGlubyA9IHN0YXQu
aW5vOwo+IAoKWW91IGFsc28gbmVlZCB0byB1cGRhdGUgdGhlIHZhbHVlIG9mIE5GU0Q0X1NVUFBP
UlRFRF9BVFRSU19XT1JEMSB0bwpyZWZsZWN0IHRoZSBuZXcgc3VwcG9ydCBmb3IgRkFUVFI0X1dP
UkQxX1RJTUVfQ1JFQVRFLgoKCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK
