Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E13473553
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 20:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbhLMTzA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Dec 2021 14:55:00 -0500
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com ([104.47.59.172]:28267
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242293AbhLMTzA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 13 Dec 2021 14:55:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZpTpOP3EV0z9VlzfdMXqnj5fvYkDms3bUSyNDswkeOaWTGKxQXKxMPYKwmizPfM/VYB48EuF5gU/FMZ5waTaLAbo+J+VDeRGBw2ch18eMmSG/CroSHmY9q/xOlPGfdgqqvriVYkBdLLkIVxBH95POEGZ3uxkL9z8J+LeSapu0msgTTR7zGxkhCdBWhoJbZfFmeGsIaDSXzHfq/GUKXgXye7V2amLV2IHlbpKqnWJSwWehjytdNmTaSIhqgGKfVokwdBMlTFFdOYxOltF0tSw3vnWgd5jL6ugN2rXGP1mRit8IMF4NLipVGvO5o35rXxzzy1lGGcEWNCWm5ulk1CXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bY5Q5bzOrU96UIQQAMtp/8W6iOukaVeFZGI8y/3Z1Vg=;
 b=RLARBqE/W/inlHH5ZNDG5ApIoW398eNFHtBulOcChF6iFq9964aOjzJtKmZ8BQv0AU0Sw1q2XTqNYr+cwfPCIJlP8ZY49bzhJQboEXkxJiD79ai6po/yWudfcM+mBvGP08Wn7a/C6Xzwv+BQ6E57QnPNhcFMR0/QWJAl2P2J7aoVTzlfwviIpb4J4pfxb9LdUrRRqT3wXfTXWY/oKW6ra0/p7l9w+GKXyqXycOHMnnqi1oqLIjyUYiUpZyM6NV3vRFnmTUjUu5zO8ZWreELhkznuRjIq52L6jh1xQRpCcEdJ7Vry4es1cUPoJ/NYfwkeRV1z9ACdtCC3PcV/1kMOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY5Q5bzOrU96UIQQAMtp/8W6iOukaVeFZGI8y/3Z1Vg=;
 b=S534o7TN5OCBX6qt+30tNiOZkoxoYticUgBUmPcyuUeNs/ul3RuFtbE6LKkxK2I8VnR4aZC32Ekx8Cq+qz0fJY3VthaHSXdLOTbbJHxW1g2ach8gNR+v168pSNCk8vCpBtYmhfZbSDARBcWogrwybBbm0/2/ACALEIwJCD329Y8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3416.namprd13.prod.outlook.com (2603:10b6:610:16::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.13; Mon, 13 Dec
 2021 19:54:58 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4801.013; Mon, 13 Dec 2021
 19:54:57 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "rmacklem@uoguelph.ca" <rmacklem@uoguelph.ca>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: knfsd server returns writeverf of all 0 bits (but was not
 rebooted)
Thread-Topic: knfsd server returns writeverf of all 0 bits (but was not
 rebooted)
Thread-Index: AQHX7VIEQoc8yG9ZVUucpKOORDcyuqww2GaAgAADj4A=
Date:   Mon, 13 Dec 2021 19:54:57 +0000
Message-ID: <6672752c94036f159816c19756fe4d77ca9bddd8.camel@hammerspace.com>
References: <YQXPR0101MB09686CB60B96426316F4252ADD709@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
         <E98AB758-5406-449B-96E7-C7FBD0BA98B3@oracle.com>
In-Reply-To: <E98AB758-5406-449B-96E7-C7FBD0BA98B3@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17587faa-a010-4066-a396-08d9be7270ee
x-ms-traffictypediagnostic: CH2PR13MB3416:EE_
x-microsoft-antispam-prvs: <CH2PR13MB34163C893F36AC48F2A7409BB8749@CH2PR13MB3416.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cp5H+SuIv/k6uB5BTErkyOD3LIZAGmrYXQ4DtPB7Ap2dHNJT7o+nEIDJUL2qJBGY10gu+xRLSjfZ2OtAZeOTD3FZ4m9Fga21tdHlpcxwA9KFzdgqusO0kRjJrItC+xvwVnPqYgdoGmpxEasFLj4KxoDOaRsJBZP423WU4QbwNI77SfabOY1H2Eil6L0ck/ITG1+a+YXodtW4T/xM/k6JkQ2nVH5uUbOC74jyn40oSxOb40IYidqWpWh5q2YgDdsaVKFOe5bXKTk3Duug5lqnbGdqafgho6HkJ4ZJQbRFw47px/NNxZQd7qE/jOv4SrI9/8M81pGcHPybOWwRXe0INmXUWN+lYv2JSz93Rv7rvdU9CE1RmAivdNhpKQ7pbWR+R42B+Q2uORMKnZZmBwdQLJMUBPhH+J0QVAk65DvyXqdstsGs5tRMDGyQkbwOL/nZ+zak7ixV9DtLR/hWfBnvN9EmsKqYHyT6gE/nIa+vfD1s+VN2Ea93Odtt31ADLiHqQTM3IQZczrCrzuJ5CduL8asEL0nBN0UuFh14OSMFpIKTZkcMmy0hkJ5Ab6iVbaAuKVPUCrPIKh7yNK5S4SDEQ8FaYVA0hMDZyWBCxK3/EBtX2ND6WQoCoMOMkIoDDHTrEEFx+uZalk15ziLCWAsfJzPFG3HtBJOFk6L0GzOA+Q0DNtN+FgzqIy9bt+MNv/j0kk6AWoPjHthbUPmpz9Z5LBOuIS29oVSzxSFOefdVa3ZS1v/ku6F7hLkr7LKyLcS/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(396003)(376002)(346002)(39830400003)(136003)(186003)(26005)(38100700002)(36756003)(122000001)(2906002)(66556008)(8676002)(86362001)(4326008)(508600001)(316002)(5660300002)(6506007)(66446008)(64756008)(66946007)(296002)(66476007)(6486002)(2616005)(38070700005)(53546011)(6512007)(71200400001)(83380400001)(8936002)(76116006)(110136005)(4001150100001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE5CSUEyMjM3WEtFNjFhL1QvaldCY1F5cWtvRDRHUWQ5ZkVvRXZ6ckhwd1gy?=
 =?utf-8?B?RzRPK2ZST0YrMThjcXI5SzhsUUwwR0U1bGpmOFNjWFNpWjI4UFBIY2VLbDYv?=
 =?utf-8?B?cS9TdnQvMS9nc29lMElTNmNjZVJ4TDdGcjROWDVXMXRZVWRjU0xEYzIzUW9L?=
 =?utf-8?B?WENUeTBnaDViRXpXdHdJdEhlYXE1cjl2MUoxeDk2akJqRkxwZ2E4ckZsOTZN?=
 =?utf-8?B?R3lMWk1JQlJEcTRsZnZNVVpPS3h3blRFbzdBcGl1S2U5NVBIem9ieFJqZFE0?=
 =?utf-8?B?alE4VDZLK2ltS0svdVhnVW9DZDFFcGlDRFA3QnhGcWZCbnU1cG5Pa1JTNjlk?=
 =?utf-8?B?YkdJUko5a2w0YWJBTm53YkRXYTBZdWZEeXovSTdWUWRpUEFQNDlPcFlNM0pK?=
 =?utf-8?B?WUxlcEYvMENWVjlnQ01TRDRFR25NbFVmWURMT013OFpSUTRUQmRCYWxBZXlj?=
 =?utf-8?B?UUlhUDBlVEM1eFgwa1ZrTjdPdDlnbDZuVEtNMTd5dkZNdFpZK2tVMFFJVnpQ?=
 =?utf-8?B?SjgyamRGOGZOQkVTY3BPYkV4L0NBRUVqM2ltMHZjZFBVdCt3MmVUUTBCS252?=
 =?utf-8?B?L0ZuSndZdjlwUEoxTzRsOFFEVFJmV3FjRHN0a29wQlZTWjRvUENDWWo0Nkx1?=
 =?utf-8?B?ZS9BVnlTR2xBN1VCcmFNMERVT0xUalRKbkY2VDZoWEJEaUVuN1FzWkd3VFo1?=
 =?utf-8?B?NW9TTEN0dlRiR0NvaDBzTEJzU2k5V3NhZFZpdjFqeEJ5Q0Fxek01WTM2Z2F5?=
 =?utf-8?B?UXZMRVlUdHJBUE1nOHlCQ3ZTMHZJelp5bm1jWkxQR1hna0hZYytlamkyOG54?=
 =?utf-8?B?RW16THVsb2t0ajdmVitEZllXbWs1RyswelBURHlwLzR0cERwQ042Z1VBUklE?=
 =?utf-8?B?dElPWlFVZUFXT01jYU5qRklvSXlya3p0OFdTWklFZFVLYkIzZkdtTEd3eG81?=
 =?utf-8?B?L1F4RThqU3hOTGMzZGl4MHNXc0JPWkw5T01CWm9VQVRtd0VzUUYxNjNObTR2?=
 =?utf-8?B?ZE5JMzI0NDAwR1lpYzF0aUZOSG83MVpSdFJYTDFMWldQbEY4TUVwcldmZnVM?=
 =?utf-8?B?bldudXU1NXFTSTNNazVpSnN2bHF2dHZqV0pJUkxKNDFFNDNadUVkNVdxb1pk?=
 =?utf-8?B?bXY2VmhZTS9LbU81a240TElvT09JMmVzNm5Teml3emFuMTUrbXZLUWFwNE43?=
 =?utf-8?B?QzZhdlhLRjVaNHFPQ3RrdnRISU1IbUNNNWp0SHA4ZTgyREdURnhBK1pia09i?=
 =?utf-8?B?MTE2QWNWUTZ4dDVHVjlTa0M5SXVsM2JuZFpiQ3k3Q0piYndPV0RmdkRjSFlW?=
 =?utf-8?B?WXVpN3YySW1BSTZnZjVrcUVZclg3bW1DMTdEdkUya3NoZThhN0FMMkFrc2hE?=
 =?utf-8?B?OHBNT3drdUgxNFl6YS9hSXZQZGl5blJET0psZVJvNVVYbFlMS1Eza0ZLREFw?=
 =?utf-8?B?RkNFcTZPemk2NTdYWmlRbFNHS0RoVWR3YmIyM1NERE1wVVkrWG8yZWU0M1l0?=
 =?utf-8?B?cHkxUWwzTjIzL2lzemtKeE1DTVQ1c3FyYis4TU1jUWRFTmZueW9acXhFb2FH?=
 =?utf-8?B?QzFERFpXRkFaYXhwbklOZFRsSGtOajBodmlGT3llZ2VHWHkrOUoxRk9vOU9s?=
 =?utf-8?B?Qk8vQ1ZVMWxvRkdTMDBOZ2xOaGdlWG9KVStjUnluc0diVTVYK2w1L1hKTGVx?=
 =?utf-8?B?Nkk4aDlGbjVWOHlHd2RvTU5oakRKSUtwTHZ1c3ZaZ3lpOHozTlM3WlF3TkxF?=
 =?utf-8?B?S1UwSklMdUlEY1dTckFxYktQWUFldk5sbld1RVhKY0FZVHNqY29vQ2g4dlRy?=
 =?utf-8?B?am9hTzFWalY4NXBUK1FtUkY3YlQwcEtiTitaNmVEMW14MU1JVDdtc283ODNH?=
 =?utf-8?B?UFVtbVY3eHZjc0dGZ1NxL0VTVmhDQ1kyaVFyUVhyc09KYXZUbnBaNWtPaU9s?=
 =?utf-8?B?a3YyYUVsaE1RdmpWWUdVSUY1aFpmTlRMcmtaOHdQQ1IvSHRMOWltN3NjR09X?=
 =?utf-8?B?bHVGbStNRHBvN2FKb1RGNHl1NDNvMTEvaTZLNmVlTkR1eTZKOVRzZ0JsYkdj?=
 =?utf-8?B?Y3F6d0x4OGtUTU05Zjk1aEhFODAwN3R4VndEVHkxamdzOG5sUXBmaURFSDM3?=
 =?utf-8?B?dmF1RVFtZUIxcldTZGl1T01qNEpLM1IrSHduNE13VlgyS2syM2wwZFlYSHQ2?=
 =?utf-8?Q?+CmfF08KpjRJJbDsRQ9XTHU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3088481024BB44CB490381D6148DAAD@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17587faa-a010-4066-a396-08d9be7270ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 19:54:57.8199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jH7yBtnglQSfeCBs7a/Ce4JUEunF5luoywAHMAQBvZuiNP6nf5yz7qGaDcVoAv/RvWKcU3uUWOy0rBUfSwLFtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3416
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTEyLTEzIGF0IDE5OjQyICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IEhpIFJpY2stDQo+IA0KPiA+IE9uIERlYyA5LCAyMDIxLCBhdCA2OjE1IFBNLCBSaWNrIE1h
Y2tsZW0gPHJtYWNrbGVtQHVvZ3VlbHBoLmNhPg0KPiA+IHdyb3RlOg0KPiA+IA0KPiA+IEhpLA0K
PiA+IA0KPiA+IFdoZW4gdGVzdGluZyBhZ2FpbnN0IHRoZSBrbmZzZCBpbiBhIExpbnV4IDUuMTUu
MSBrZXJuZWwsIEkgcmVjZWl2ZWQNCj4gPiBhDQo+ID4gd3JpdGUgcmVwbHkgd2l0aCBGSUxFX1NZ
TkMgYW5kIGEgd3JpdGV2ZXJmIG9mIGFsbCAwIGJ5dGVzLg0KPiA+IChQcmV2aW91cyB3cml0ZSB2
ZXJpZmllcnMgd2VyZSBub3QgYWxsIDAgYnl0ZXMuKQ0KPiA+IA0KPiA+IFRoZSBzZXJ2ZXIgc2Vl
bWVkIHRvIGJlIGZ1bmN0aW9uaW5nIG5vcm1hbGx5IGFuZCBoYWQgbm90IHJlYm9vdGVkLg0KPiA+
IA0KPiA+IElzIHRoaXMgaW50ZW5kZWQgYmVoYXZpb3VyPw0KPiA+IA0KPiA+IE5vcm1hbGx5IEkg
d291bGQgbm90IGV4cGVjdCB0aGUgd3JpdGV2ZXJmIGluIGEgV3JpdGUgb3BlcmF0aW9uDQo+ID4g
cmVwbHkNCj4gPiB0byBjaGFuZ2UgdW5sZXNzIHRoZSBzZXJ2ZXIgaGFkIHJlYm9vdGVkLCBidXQg
SSBjYW4gc2VlIHRoZXJlIG1pZ2h0DQo+ID4gYmUgY2lyY3Vtc3RhbmNlcyB3aGVyZSB0aGUga25m
c2Qgc2VydmVyIHdhbnRzIGFsbCBub24tRklMRV9TWU5DDQo+ID4gd3JpdGVzIHRvIGJlIHJlZG9u
ZSBieSB0aGUgY2xpZW50IGFuZCB3b3VsZCBjaG9vc2UgdG8gY2hhbmdlIHRoZQ0KPiA+IHdyaXRl
dmVyZi4NCj4gPiBIb3dldmVyLCBjaGFuZ2luZyBpdCB0byBhbGwgMCBieXRlcyBzZWVtcyBwYXJ0
aWN1bGFybHkgb2RkPw0KPiANCj4gSSBkb24ndCBpbW1lZGlhdGVseSBzZWUgYSBjb2RlIHBhdGgg
Zm9yIFdSSVRFIG9yIENPTU1JVCB0aGF0IHdvdWxkDQo+IHNldCB0aGUgdmVyaWZpZXIgdG8gemVy
b2VzLiBXaGVuIExpbnV4IE5GU0QgcmVzZXRzIGl0cyB3cml0ZQ0KPiB2ZXJpZmllciwNCj4gaXQg
c2V0cyBpdCB0byB0aGUgY3VycmVudCB0aW1lLg0KPiANCj4gRG8geW91IGhhdmUgYSByZXByb2R1
Y2VyIHlvdSBjYW4gc2hhcmU/DQo+IA0KDQpSaWNrIGlzIHVzaW5nIEZJTEVfU1lOQywgd2hlcmVh
cyBuZnNkX3Zmc193cml0ZSgpIG9ubHkgYWN0dWFsbHkgc2V0cw0KdGhlIGJvb3QgdmVyaWZpZXIg
aWYgdGhlIHdyaXRlIGlzIHVuc3RhYmxlIG9yIERBVEFfU1lOQy4NCg0KLS0gDQpUcm9uZCBNeWts
ZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
