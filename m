Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9D7421337
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbhJDP7H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 11:59:07 -0400
Received: from mail-dm6nam11on2098.outbound.protection.outlook.com ([40.107.223.98]:17377
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236108AbhJDP7F (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 Oct 2021 11:59:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCaCoajkuQI//2LW2Y1TTDrbhI6sagZPI4Y1iz7apu2maTy5GxOcdTWhPgsHIqXi3iK6AC229B8RTvkzHT6E8MkUKQ6egLqU2ZZW7+YYEO6dZ671adbqqfET9oO+cL7pz6uRkDOVcsi1z08AZyzhe++7+BcUuEuKA5rg8ugJpw4Pd5DP9fVyWWp1CptJQEe6Q57JP1uE8RildsaFqgU3uEmVFe1oGif0ZmiQocvlmL7vckjm2Gc/d22edEPn41oh9r8veWbpOyrQJ/p/xuf0pxm0IQVBTKQ1WyBKjuAG8u6RCS4RdjT2k71PZUugoviwIu6mAozPcFJefbVDVGBsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnN08y2PRr95J9PPxrr+2cWvsfHdChrVkyHjFmB30Ho=;
 b=AIcbUv3OlC51Y02/vktkLDcJ2F4ck1FxfyouYJWs76gXaS/ALQ1eO4Ii866AVA/3Uf+uwjU4Qh0g0qoG6iM24WYUSJC3Oggxn2WPDvUeh1AmxHgRCHyy+EnJWh6tzeb205lX8/jLugz+Mniy3+ojvW7cmsy55URoHyQw+b56LMJxNk6VuK1p83mh1WdMyUcWU5PcuXVCp9Ne+S0AX8FFCpsuaoWks3bdPcjVL/T3LOsaCs4IBWCbCDA+kjixM624vPdi8RCAZQOesqCP6fyaNtSmS77682++24l6m65tP+uC11fNuZGRKxwL8krzcaAtlF/74QqUJMwrR7q2Xswqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnN08y2PRr95J9PPxrr+2cWvsfHdChrVkyHjFmB30Ho=;
 b=SaCVsXO6qvbjmZNDmjHh5Vomr6//T9Gn9cQEAlDWZH7fwJjJZf3CN4DObf1AinIWwQgvv+NgwmmWbHpqoD4kzajW6xbwUHySzEiE5UIXN0fqAgmjKHeI3puDWe7+0U9QHAufExCJ0+3KEwsdnS3We4fcHJ+r9Scb6Sp+gH7XPHY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3687.namprd13.prod.outlook.com (2603:10b6:610:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.15; Mon, 4 Oct
 2021 15:57:13 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%6]) with mapi id 15.20.4587.017; Mon, 4 Oct 2021
 15:57:13 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 7/7] NFS: Remove remaining usages of NFSDBG_FSCACHE
Thread-Topic: [PATCH v1 7/7] NFS: Remove remaining usages of NFSDBG_FSCACHE
Thread-Index: AQHXuIwRARwyDr0wykOeHFUASRPtBqvC/+QA
Date:   Mon, 4 Oct 2021 15:57:13 +0000
Message-ID: <5fe74c4fb9d54c775c07d0f94d0ea187f72e15fe.camel@hammerspace.com>
References: <1633288958-8481-1-git-send-email-dwysocha@redhat.com>
         <1633288958-8481-8-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1633288958-8481-8-git-send-email-dwysocha@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07b64743-298d-4287-65e7-08d9874fa1d3
x-ms-traffictypediagnostic: CH2PR13MB3687:
x-microsoft-antispam-prvs: <CH2PR13MB36879A63BD4741B5F33DBE66B8AE9@CH2PR13MB3687.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ck8q/iLnFJ2ry5UkfWMoFyHu+InzPoy7/QrjD8InL2ABM+vKug02SiidT+LIY/EHFHb9+Yv20gZ3F8lD4bGn7U96lHlV8/+l1AMGAu9nh6wlRMmb5dF+O5BFRpwMgCxPxCsurlRATVYX2ZfP7ge/ZGBLkO2n/2FaMamru+avg5D8OxAqiB3rg3R1lvu5K33Xa57aw4hthheZR0xaC7ttNnPYNcS22AHAkaioiNjyPRiiWjkapZvBWwm4z1+6L+oYxuwrx7U455dP+0re75X34FPZsMXX7LKGm2FQQaa9Lg0olGJyHwGL/0ISXeq30LTa4TWwqvtCCZCDiOb1veaLgYZtWicXK31OyxXLtRlweVKD0F3SPIM76TA+5gZFBcUtQ83NLQneu9mOw8yaCXeKmISMEGeVHqvb75lrrYrB/VMLfAyOa07AWLGYXcXuoRS47pi3v+44ED2iC0FmEUTsoFsa4p36kd/wU3ScVRBGIscHboYu1VYCqUWAa8023q8+92u8cI4vBeUpFTO2s8/n2f7SEiSLQehu/acb0xHNzapbdA6xxOqVDr3k4Z+JNI6JwDLf1pT9JSXQU52NzEjDbppXgEcCXV3BaajD910gUEmSi1tLdigQfb4cEE7qdjmAWJ0p8k9YSJV3uE2ARvp3kKmL75Laj7SmUj8iq+UuvyZ+/iPm2D7yG5WPnzcIKkWwa9JL4hfluU9ZB3BeKM9y9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(136003)(39830400003)(508600001)(2906002)(6512007)(186003)(26005)(4326008)(76116006)(316002)(38070700005)(6486002)(66946007)(54906003)(110136005)(86362001)(8936002)(66476007)(66556008)(64756008)(66446008)(8676002)(6506007)(83380400001)(2616005)(71200400001)(5660300002)(36756003)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGZPOERpODJ0bWNNME5wNXZlemhnQ0lBdGxnU3JQVk95Y2hUVnFDME9Gc2xV?=
 =?utf-8?B?NHZWYXZsSTl2THdrem9HaFNZd2JFaTFrZzROdGdSOVJzNTNkMDNVSTVnQStV?=
 =?utf-8?B?eTNZQ2dhVTludWV1RjlZeC8welRZL0tkTGFhMk1HYSs2OUhRSlFOSy9jbXdN?=
 =?utf-8?B?Ymx2MFFmdEQ5OXRiS0NKekNIeG93TXI0VU9jUnlyKzVFTVJ6VVNFUEtlQUpL?=
 =?utf-8?B?V3N1NnpTQ3hYSHROeG54UzNmbUNaWkNYTTRCSk81NG0wam1ld0p6N3hseEp6?=
 =?utf-8?B?WWxTU0FhOGU1WGdROHRaVjlkVEllSmZiNmNBUU5vTGt5T1ZlWTlnY2ppU3FG?=
 =?utf-8?B?TG14a0lTRU8wWnZ5NXFITFQ4SGNsMXBiemlUa1U5cTJXaUxWZW94SklsS0VE?=
 =?utf-8?B?QmppRU5MYzhkdGR2MUJqcTU2d0J2SEdPaGU4Q09IL2JzeXpjRm81SVVGaGho?=
 =?utf-8?B?Z3FTaVBLZkxna2luNm9xNUx4cFB2WUpYRzJKL3lxUmtwZmNKY2lPK1I4OC9M?=
 =?utf-8?B?MWxrNEQ5ZjZpcktSVnFRTTFLc2R1L0FESnhncUdubWYycmxVRm41anpSUER1?=
 =?utf-8?B?OFU3eHFCZzhQNW5TeXU1ZXJYN2Z1L0hadjhHZnFRYXZKWTFTR2doNVJSaDBE?=
 =?utf-8?B?TUg5dm1ldGgvK3VHYTRxUFNUYnhXL3RTRmo5ZUdoMVA2dWJTMVV5bnA0WFZZ?=
 =?utf-8?B?OGtJRkY5VlMyVkUvV2V6TXk5OFdXR0lVNkxuRnA5azFBZ3NpR2ZHUlBpazds?=
 =?utf-8?B?RVNiSjhvMW5neTZuN1FxUE9ucFIwTHdsTUE4dXJESEJSQjBUNi92ZzR3ZlFn?=
 =?utf-8?B?MzlKNloxcVBVeGJrYlI0MlZYdE01bFhZdFFLdEc5SFljVGhDN3R4akV0UGpo?=
 =?utf-8?B?WjF1MFR2OEJlR05veThlVit0RFdrMEtHYWZLU2cxQjhnclRHWVN2UXR6TE9T?=
 =?utf-8?B?eWFMN1crN3Voa1F5TENsL3pDZU5SQlcvUWcyQnlKUXJWbWRvZVJNRW51ZnNP?=
 =?utf-8?B?YjA3SXcvSXI2OEF0Nzl5OGZnc29zMmFYQnJTRWM0K1d0SzhoVlo2SENJMmZ2?=
 =?utf-8?B?YXN6ckkrdi9mTWhMT1lJNDAyMmhMdFBKbU5CSG1Bc0F2ZVhVQVFnUEgzY3RF?=
 =?utf-8?B?emh4SVl2OUNEZnZkakRQdDdjdmlhdTlIS21rd0YzWVFYV2g3dlVKZjRkdUFq?=
 =?utf-8?B?RjVXT2lqL0Q2N2o5VnJVa2MwSGRSbWJjSUZDRmZZZFNvZllrZXQxL3RmaTNs?=
 =?utf-8?B?MUh4WTJjMCtlUU0rcWR3RGowanlVMnZqT3RGRmlyV2taU2U0bnBxZ0JQNWNn?=
 =?utf-8?B?M3BmUjNEZ2dsUE9iQlFybGlDbkVVSXRsbkZkRlZtVUNaaVpybml0SWNqOWF1?=
 =?utf-8?B?V0pVU3RkRnRjVVY4NjZZY2tjOXVFaUgvMzF0V3ZjZ0V6cTh2MUVZdS9zT1Jy?=
 =?utf-8?B?TzFWZmhHZEcrSkZydDdTbG54K09Eczl6dmFpbWxkekpmb3BGeDE3dGoyM2FF?=
 =?utf-8?B?UWlLN0FEcEpSYjg0V2hkV2drSnZERnNDRnNxSlpEMnl6dmNZTlZ4UWNUTFlC?=
 =?utf-8?B?bnZINDR1N0grdEpiVGlQQlhYRGdOYUZZdHNoTjVCM2JVQ0wxVkZwSnFuZmlS?=
 =?utf-8?B?cElpU0Y4WC85eTlwZjFWeDZ6NDBzM2E3K2RhOTA3a0N0UDRaeDdQTW44bE1M?=
 =?utf-8?B?SEFKaFdPSHFkME9xbktEaDRPMFoxOEMrZ2VwRnRPWEc2SDVBUFViZEZVWE1s?=
 =?utf-8?Q?6RSvJPPImBnoQmkobPUNFOgEcBNQOnvqg0LaqMG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FDF6B69977EA044B6F5872B54A78278@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b64743-298d-4287-65e7-08d9874fa1d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 15:57:13.5384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/KVioGnBMg4Y50EBGx6w9s1jj0JJrzAQ/Wb/fZhzwsXcJK+3m2eqTZ96qyPcxjjH6caHoZ7wQ+g7MGB4wXzxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3687
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIxLTEwLTAzIGF0IDE1OjIyIC0wNDAwLCBEYXZlIFd5c29jaGFuc2tpIHdyb3Rl
Og0KPiBUaGUgTkZTIGZzY2FjaGUgaW50ZXJmYWNlIGhhcyByZW1vdmVkIGFsbCBkZnByaW50a3Mg
c28gcmVtb3ZlIHRoZQ0KPiBORlNEQkdfRlNDQUNIRSBkZWZpbmVzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogRGF2ZSBXeXNvY2hhbnNraSA8ZHd5c29jaGFAcmVkaGF0LmNvbT4NCj4gLS0tDQo+IMKg
ZnMvbmZzL2ZzY2FjaGUtaW5kZXguY8KgwqDCoMKgwqAgfCAyIC0tDQo+IMKgZnMvbmZzL2ZzY2Fj
aGUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyIC0tDQo+IMKgaW5jbHVkZS91YXBpL2xpbnV4
L25mc19mcy5oIHwgMiArLQ0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDUg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2ZzY2FjaGUtaW5kZXguYyBi
L2ZzL25mcy9mc2NhY2hlLWluZGV4LmMNCj4gaW5kZXggNGJkNWNlNzM2MTkzLi43MWJiNDI3MDY0
MWYgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9mc2NhY2hlLWluZGV4LmMNCj4gKysrIGIvZnMvbmZz
L2ZzY2FjaGUtaW5kZXguYw0KPiBAQCAtMTcsOCArMTcsNiBAQA0KPiDCoCNpbmNsdWRlICJpbnRl
cm5hbC5oIg0KPiDCoCNpbmNsdWRlICJmc2NhY2hlLmgiDQo+IMKgDQo+IC0jZGVmaW5lIE5GU0RC
R19GQUNJTElUWcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTkZTREJHX0ZTQ0FDSEUN
Cj4gLQ0KPiDCoC8qDQo+IMKgICogRGVmaW5lIHRoZSBORlMgZmlsZXN5c3RlbSBmb3IgRlMtQ2Fj
aGUuwqAgVXBvbiByZWdpc3RyYXRpb24gRlMtDQo+IENhY2hlIHN0aWNrcw0KPiDCoCAqIHRoZSBj
b29raWUgZm9yIHRoZSB0b3AtbGV2ZWwgaW5kZXggb2JqZWN0IGZvciBORlMgaW50byBoZXJlLsKg
IFRoZQ0KPiB0b3AtbGV2ZWwNCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9mc2NhY2hlLmMgYi9mcy9u
ZnMvZnNjYWNoZS5jDQo+IGluZGV4IGQxOTllZTEwM2RjNi4uMDE2ZTZjYjEzZDI4IDEwMDY0NA0K
PiAtLS0gYS9mcy9uZnMvZnNjYWNoZS5jDQo+ICsrKyBiL2ZzL25mcy9mc2NhY2hlLmMNCj4gQEAg
LTIxLDggKzIxLDYgQEANCj4gwqAjaW5jbHVkZSAiZnNjYWNoZS5oIg0KPiDCoCNpbmNsdWRlICJu
ZnN0cmFjZS5oIg0KPiDCoA0KPiAtI2RlZmluZSBORlNEQkdfRkFDSUxJVFnCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgTkZTREJHX0ZTQ0FDSEUNCj4gLQ0KPiDCoHN0YXRpYyBzdHJ1Y3Qg
cmJfcm9vdCBuZnNfZnNjYWNoZV9rZXlzID0gUkJfUk9PVDsNCj4gwqBzdGF0aWMgREVGSU5FX1NQ
SU5MT0NLKG5mc19mc2NhY2hlX2tleXNfbG9jayk7DQo+IMKgDQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL3VhcGkvbGludXgvbmZzX2ZzLmgNCj4gYi9pbmNsdWRlL3VhcGkvbGludXgvbmZzX2ZzLmgN
Cj4gaW5kZXggM2FmZTM3NjdjNTVkLi5jYWE4ZDIyMzQ5NTggMTAwNjQ0DQo+IC0tLSBhL2luY2x1
ZGUvdWFwaS9saW51eC9uZnNfZnMuaA0KPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvbmZzX2Zz
LmgNCj4gQEAgLTUyLDcgKzUyLDcgQEANCj4gwqAjZGVmaW5lIE5GU0RCR19DQUxMQkFDS8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHgwMTAwDQo+IMKgI2RlZmluZSBORlNEQkdfQ0xJ
RU5UwqDCoMKgwqDCoMKgwqDCoMKgwqAweDAyMDANCj4gwqAjZGVmaW5lIE5GU0RCR19NT1VOVMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAweDA0MDANCj4gLSNkZWZpbmUgTkZTREJHX0ZTQ0FDSEXCoMKg
wqDCoMKgwqDCoMKgwqAweDA4MDANCj4gKyNkZWZpbmUgTkZTREJHX1VOVVNFRMKgwqDCoMKgwqDC
oMKgwqDCoMKgMHgwODAwIC8qIHVudXNlZDsgd2FzIEZTQ0FDSEUgKi8NCg0KUGxlYXNlIGxlYXZl
IHRoZSBuYW1lIGFuZCB2YWx1ZSB1bmNoYW5nZWQuIEknbSBmaW5lIHdpdGggYWRkaW5nIHRoZQ0K
Y29tbWVudCB0ZWxsaW5nIHBlb3BsZSBub3QgdG8gYm90aGVyIHVzaW5nIGl0LCBidXQgdGhpcyBp
cyBzdXBwb3NlZCB0bw0KYmUgcGFydCBvZiBhIHVzZXIgQVBJIHNvIGl0IGNhbid0IGJlIG1vZGlm
aWVkIHVubGVzcyB3ZSdyZSBhYnNvbHV0ZWx5DQpjZXJ0YWluIGl0IGlzbid0IGJlaW5nIHVzZWQg
YnkgYW55b25lLg0KDQpUaGUgb3RoZXIgY2hhbmdlcyBhcmUgZmluZS4NCg0KPiDCoCNkZWZpbmUg
TkZTREJHX1BORlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAweDEwMDANCj4gwqAjZGVmaW5lIE5G
U0RCR19QTkZTX0xEwqDCoMKgwqDCoMKgwqDCoMKgMHgyMDAwDQo+IMKgI2RlZmluZSBORlNEQkdf
U1RBVEXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHg0MDAwDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0
DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
