Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B68E4878EA
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jan 2022 15:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiAGO0o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jan 2022 09:26:44 -0500
Received: from mail-dm6nam11on2127.outbound.protection.outlook.com ([40.107.223.127]:7081
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239184AbiAGO0l (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 7 Jan 2022 09:26:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DddmmfJK0qlwssNwqR+05M0S14hVx0HSrmU3BeytoD2sSvMGU7CsrOyA+rHckShUokVJuFB1mv0wqujyyYXDoN/AUeeE1fVeCYaSrBOU3coFj1cxdYG/x0YdL6wePVG05CUGT/sr70kJfa9Q6d40AoLDglfqZWPdG/MfuVRl3an83tRpfUVugwS4A/I43nu5kFcRba5R+LlWBpvmO67lVY9u40TV4YOEUn9pBahRYcdh6IRJK2/tIec8g32f5os65sHhNuLjeTNdm9QSLheQiScGkS9U626kLs/Z8I8hWxDvLVGHa6J9eiuPiYKeMD2bWLT9l/Fdf47AJAWpcJVl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zttnjCzaV39+ZEqGky9OVvIiMkq5dubesexuZ4FdzR8=;
 b=C5DnmaRKhesqrbtHy4LOdvlDlmR4zfKV92TKg17UsP5bbRuR5yTScDOoWBMbZfhQYEwMPRRC8onQ57fHxBkp3vB/3Ro77YBOX8/89JUT3Emmq1tUxbT1+vL4LxmGiHfZGJGjkoJ1XkRLflAFmfzaz4Qwap5srB3dfXiufIL/tbLbf4vK840HgIdar4Cu+Z13WURrrJPQcAjrMV54/VaO+GByWQOyhCxUJwCC/7BQIYz5xjVIJT84pG7Yn8403WXlRj0ty4S0FGmpVusf2xMgmmeFvbOCGiJU0gOT3RIy8AJixa5th+V6Dk4+6Z3jQAn3UfH3Q7Mu2XDSOLE3UmJrhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zttnjCzaV39+ZEqGky9OVvIiMkq5dubesexuZ4FdzR8=;
 b=NhnBPPRHqyr+EFWPQMvawr4atGr5VmYB2t7sNJjZxxRGWTcNVg25ej499BdsieYr8umA3Pc7W5jBb1Zo13ekDY4dqBy7DR/MSzqkkFEJFUV7G9E6F1g/u9VmKd+STp9SrlGf1K7tpMzi5ejSxLFu0q6MasB3myOVOo5At0eZB7s=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB3310.namprd13.prod.outlook.com (2603:10b6:208:159::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.5; Fri, 7 Jan
 2022 14:26:35 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 14:26:37 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 6/8] NFSv4: Support the offline bit
Thread-Topic: [PATCH v2 6/8] NFSv4: Support the offline bit
Thread-Index: AQHX+1WTGjBbvvuDs02w5/KaavWL6qxXrZCAgAAA6oA=
Date:   Fri, 7 Jan 2022 14:26:37 +0000
Message-ID: <91d002bfefa641a8b9d6010dfa4b482343ead6da.camel@hammerspace.com>
References: <20211227190504.309612-1-trondmy@kernel.org>
         <20211227190504.309612-2-trondmy@kernel.org>
         <20211227190504.309612-3-trondmy@kernel.org>
         <20211227190504.309612-4-trondmy@kernel.org>
         <20211227190504.309612-5-trondmy@kernel.org>
         <20211227190504.309612-6-trondmy@kernel.org>
         <20211227190504.309612-7-trondmy@kernel.org>
         <CAFX2JfnXtm90Tn7Y4h04Ca+fxqxjesP1CjOpEHOKBRVPNPum5A@mail.gmail.com>
In-Reply-To: <CAFX2JfnXtm90Tn7Y4h04Ca+fxqxjesP1CjOpEHOKBRVPNPum5A@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43f9968b-4bce-4684-3138-08d9d1e9b6fd
x-ms-traffictypediagnostic: MN2PR13MB3310:EE_
x-microsoft-antispam-prvs: <MN2PR13MB331074692BA18A277EF90608B84D9@MN2PR13MB3310.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z5MDr5TIThAm6EkGmhwqQECTTHSGbWvXMUonyCQqZ7OYUXKTc5u7oGO1Eswyagg09GeZv+X+Ee+FayX6gNMKYonM34L5pOZUShlI5KKT4NbtsRv8tqYr9RMC8OWyGi23gEtD2u8KABmRj/FzhuwtOjqTKjwldVF8rqRstovpYeXOtC1x8ejswD0xuGOczqEcfTlQsuqtvU6ex+OkK5PFqLBRNR8QEeneYrw2oFBusLZ/6O4WTrqzMI/d0FUGwAT5PMvtUF67etlisBEp7HWWA+q+MLa2Gvql94BPLZ/yGf9oOGsSp6xyvb2GI/7pzCo3bLRuBeyCQpknv+w7MQ1q1QB86ZC3w+04MkQcE2xMNslNE/MxvKUL6KtrWqByWFkmjmmVJQHWCV+cdPk8VVFDgAQZ0rh4KAendeqqo3OK7nWAkas/SFok0auROQsb6Hfa9rknSo0E9/D4QSsXT0saU4Q7b1Dme0GnexTYM2EyiEjCUtn9vlgjqV8kCNJZVpvKK9TMlcZQEOrcCGf9aVh1+EWMvIVkk9Nh0pfEF04QXSwSjIsOcle6yOXMpz0jPfLWALn4SLYwkRzj1PrVxeWb2iikxZUUqSzkIhCY5p8jbwh/LGT1qqcanD9SLBsC44AcX82DvXZMXIu2KxsEG2nTlcuR8iv8OCwrUJHsn+xWEPaDK8JqMK30U0eh4LUeQPoUFEsh0pMktZgH9l3FZwbAmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(136003)(39830400003)(396003)(346002)(376002)(2906002)(38100700002)(2616005)(186003)(71200400001)(26005)(508600001)(5660300002)(38070700005)(86362001)(6486002)(316002)(76116006)(36756003)(110136005)(83380400001)(8936002)(6506007)(53546011)(6512007)(66946007)(66476007)(66446008)(64756008)(66556008)(122000001)(4326008)(8676002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmQvS1NSRDJCd2JRSm4zTUZ4M1dWSEZQTGxZOGtuWWpTZ2R6a0Rjb0Y0dlE1?=
 =?utf-8?B?cjVtUXZ5NUczNjI0Y25QV0p5MUlPbXBVanNPYjNFcjhFVkx1RFRLR0o5M2R2?=
 =?utf-8?B?RWowRzAxQWlidnZPZnRHU3B2R2hUbHVUeWJDR3o3dlczNUFKNVRrVWliOVNh?=
 =?utf-8?B?cGhkR3BXZlB6K1Rmd2l2NEN1NmI5TThqQzhFL0xWT2JsVGcxZkpQVUIzU0E4?=
 =?utf-8?B?UVQ3MnBPWmZybXNIV3FuZ0ZXcGZQTGxlbllSNENsTHd1Zzc4ZGF2OSt4ZE0z?=
 =?utf-8?B?V21YYmdQU2FlaEVXNW1CWjd3bnJTY2VJdENXYXkvVDdmZER3bzE5ZW1MeVc3?=
 =?utf-8?B?TzBWbHNxMjFKNWEwK2xhUytDbnZJNWkrbnBMdWFPa0JNNjF4bUdMVC9xcnVp?=
 =?utf-8?B?R05BTDVLeHpwb2RRUkU5bjA1M3cwQXA2UXh1VDREWmlKcTNXTTh2bnRFTGtK?=
 =?utf-8?B?ejJSOGRFdVEvNXdxS1RqRml4STRvSFh1dkJLYUxBWHRGalFjWC9pNnZwaGU2?=
 =?utf-8?B?cXY5OEZuR05HZ2VrQk0xeVp3NkpPNFkxNjJuUVJaVGZUeE9oQ1Mrd0wxNE85?=
 =?utf-8?B?dE1RQ2JEaHoxVnNPYjBuclorL3Y5WlFhcEtNeWsxK1YvdXFrSVlMMk1xQS80?=
 =?utf-8?B?eEplN3ZHSmdsNEdPNXpYcS8zYmQ0RUlRd3VEWE1MbWJJV0dZM0FYMm16cStW?=
 =?utf-8?B?OVo1ZUN2UzJLQmZqaWFpVHpPenRFZnY5ZjhwUEJsZW5mRHExMU1nSHdQeTNN?=
 =?utf-8?B?S3kzaHUxNlk3aXh6aUF3MkxIK2FpMFBDY2FHQ2JDS2xhU2JaQ0FwSFpwMkUr?=
 =?utf-8?B?WWl2enlFczRON08wRm95dUxmcnhoNHFBMWEvVkZMWWZWV1JHNWhUOStoVEpw?=
 =?utf-8?B?QnJnOGVINGt3VDhnMkNSU1FoUTFHZm1oNkxIUjFXemRhTVFaS0VudTk1SCty?=
 =?utf-8?B?a2d6RUFNMW1hcTRsa2tUVXFxUVFjVGIrZ3BVREUvNEdyVzRBMGJkcWNwazBq?=
 =?utf-8?B?TXFHYlZjYmZPNEFLaTJ2SGdQaXNCS0h1QkVTTGVmNFI0S1NzVjBaU3h6VDdE?=
 =?utf-8?B?YWU4eThZVm5FSmJrM3oxaUw0TE0yWUFEWjc2TnphQmJZWnA4WXgyMVJVNTUx?=
 =?utf-8?B?WEVENnUwQkhIKzVQMzl5YUkxNzN1OEtoV0FqUm5STytzUWQ0QWJmcEphbUpr?=
 =?utf-8?B?TUdNWXpVVXdQYlRNMktvVnhybHNMNlh6N2VYRmNXbDk4SllUS0ZWNVNiNE1L?=
 =?utf-8?B?dXpSVGI2TjdWYjg4WWRtbTU3bWk2WVFvSkJVemFVU1BZTDVRV09xaWNwUTFX?=
 =?utf-8?B?RGNzTnpZaG5UQ05YMjJQRnNEb0lacVBSNVI4eVFZUUtQeXhNQVZrU2ExclRE?=
 =?utf-8?B?VVBQMDl6c2VFSHNhQkthR2pmMTZDeGE5eHUydkV0K1lFa0Y5cmYxWVZOZ3Np?=
 =?utf-8?B?YVozTkdKWWdYVCtkUU5IMmhUZXIvMlNJb2hCUHJwelREUFMxRVdINEhlaFNL?=
 =?utf-8?B?RWU3YjVDdDNoaEljUG5BOGQ3VzFFeGs5Q0FPNTlEM2U1MzFUZS9qaDY1azZF?=
 =?utf-8?B?Rk9vUTNxVm92c0lEVUJrY0JQRUtOTFFrQVpEbG5iNVQ3NTBpTEdpTmRNOEQ1?=
 =?utf-8?B?bDFwcFZwTzZOM2dkajcvbnUyWnMzM2xodHUyc0IwOWo2Szd0VDlUVk9qUmZQ?=
 =?utf-8?B?bXJOUzUwM1NEc1pvUmVXT0FnbjJaMDJSMHorL1NaekdUU0VGK21OWEdrbkth?=
 =?utf-8?B?SW9WZWw4U1RZWDF4RzNvbmtMNURSN296SWpUbmFsUzZtL2VVS3NhMlJvMGYx?=
 =?utf-8?B?VGh4b3FnR0IvdjBFamFzUzJXZHZnTXM5RXBhY3hkQnJNNjZsQk5DWVBMRWdV?=
 =?utf-8?B?YklMUTBxcHZlRXZoNExKazhCSENLUmJsQTFTNXlUK0R6NzhMUzNSd3NwYlU2?=
 =?utf-8?B?cmlhNzZuMTJEcEk5TXVMYWNKKytUZm52aERVY0VlOGhrSEY3V3NobnA0ZTdG?=
 =?utf-8?B?VitVeDZuanViTFhpU2hYMFJwOEpiUk9HN0tpbG5KRWJsOTh5QWFMdVJsS1Q2?=
 =?utf-8?B?azYxWEFyRWY1TWg2N2pielNkdkVBUURzQWVKWWJrU3FRZThmNTVwTUZkT3BK?=
 =?utf-8?B?cW5rZVVDaDJIbWMxM3dKU2dVeDkzSU9PejRla0JNYXd2NW82WkxSK0l5VWNa?=
 =?utf-8?Q?x7W5AgFDbPzngQHLLL7CmYI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AFBD7C3DBECBC47BDDEBB1EA0A33256@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f9968b-4bce-4684-3138-08d9d1e9b6fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 14:26:37.4858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C29c50NrJu4QMSvhMQDT7alhfMqv0kme5nme3mnszp8h8LVGl8kyElzPbpg9jVC4MB1X0rmhpxA13F3SQ9DIjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3310
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTAxLTA3IGF0IDA5OjIzIC0wNTAwLCBBbm5hIFNjaHVtYWtlciB3cm90ZToK
PiBIaSBUcm9uZCwKPiAKPiBPbiBUdWUsIERlYyAyOCwgMjAyMSBhdCAzOjAzIEFNIDx0cm9uZG15
QGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25k
Lm15a2xlYnVzdEBwcmltYXJ5ZGF0YS5jb20+Cj4gPiAKPiA+IEFkZCB0cmFja2luZyBvZiB0aGUg
TkZTdjQgJ29mZmxpbmUnIGF0dHJpYnV0ZS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQg
TXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAcHJpbWFyeWRhdGEuY29tPgo+ID4gU2lnbmVkLW9m
Zi1ieTogTGFuY2UgU2hlbHRvbiA8bGFuY2Uuc2hlbHRvbkBoYW1tZXJzcGFjZS5jb20+Cj4gPiBT
aWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20+Cj4gPiAtLS0KPiA+IMKgZnMvbmZzL2lub2RlLmPCoMKgwqDCoMKgwqDCoMKgwqAgfCAx
MSArKysrKysrKysrKwo+ID4gwqBmcy9uZnMvbmZzNHByb2MuY8KgwqDCoMKgwqDCoCB8wqAgNiAr
KysrKysKPiA+IMKgZnMvbmZzL25mczR0cmFjZS5owqDCoMKgwqDCoCB8wqAgMyArKy0KPiA+IMKg
ZnMvbmZzL25mczR4ZHIuY8KgwqDCoMKgwqDCoMKgIHwgMzEgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLQo+ID4gwqBpbmNsdWRlL2xpbnV4L25mczQuaMKgwqDCoCB8wqAgMSArCj4gPiDC
oGluY2x1ZGUvbGludXgvbmZzX2ZzLmjCoCB8wqAgMSArCj4gPiDCoGluY2x1ZGUvbGludXgvbmZz
X3hkci5oIHzCoCA1ICsrKystCj4gPiDCoDcgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9pbm9kZS5jIGIv
ZnMvbmZzL2lub2RlLmMKPiA+IGluZGV4IDQ2NzNiMDkxZWEzMS4uMzNmNDQxMDE5MGI2IDEwMDY0
NAo+ID4gLS0tIGEvZnMvbmZzL2lub2RlLmMKPiA+ICsrKyBiL2ZzL25mcy9pbm9kZS5jCj4gPiBA
QCAtNTI4LDYgKzUyOCw3IEBAIG5mc19maGdldChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1
Y3QgbmZzX2ZoCj4gPiAqZmgsIHN0cnVjdCBuZnNfZmF0dHIgKmZhdHRyKQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5mc2ktPmFyY2hpdmUgPSAwOwo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG5mc2ktPmhpZGRlbiA9IDA7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgbmZzaS0+c3lzdGVtID0gMDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG5mc2ktPm9mZmxpbmUgPSAwOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlub2RlX3NldF9pdmVyc2lvbl9yYXcoaW5vZGUsIDApOwo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlub2RlLT5pX3NpemUgPSAwOwo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNsZWFyX25saW5rKGlub2RlKTsKPiA+IEBAIC02MDYsNiArNjA3LDEw
IEBAIG5mc19maGdldChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QKPiA+IG5mc19maCAq
ZmgsIHN0cnVjdCBuZnNfZmF0dHIgKmZhdHRyKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH0gZWxzZSBpZiAoZmF0dHJfc3VwcG9ydGVkICYKPiA+IE5GU19BVFRSX0ZBVFRSX1NQ
QUNFX1VTRUQgJiYKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZmF0dHItPnNpemUgIT0gMCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzX3NldF9jYWNoZV9pbnZhbGlkKGlub2RlLAo+ID4g
TkZTX0lOT19JTlZBTElEX0JMT0NLUyk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAoZmF0dHItPnZhbGlkICYgTkZTX0FUVFJfRkFUVFJfT0ZGTElORSkKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZnNpLT5vZmZsaW5lID0gKGZh
dHRyLT5oc2FfZmxhZ3MgJgo+ID4gTkZTX0hTQV9PRkZMSU5FKSA/IDEgOiAwOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZSBpZiAoZmF0dHJfc3VwcG9ydGVkICYgTkZTX0FU
VFJfRkFUVFJfT0ZGTElORSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBuZnNfc2V0X2NhY2hlX2ludmFsaWQoaW5vZGUsCj4gPiBORlNfSU5PX0lOVkFM
SURfV0lOQVRUUik7Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZnNf
c2V0c2VjdXJpdHkoaW5vZGUsIGZhdHRyKTsKPiA+IAo+ID4gQEAgLTIyNzQsNiArMjI3OSwxMiBA
QCBzdGF0aWMgaW50IG5mc191cGRhdGVfaW5vZGUoc3RydWN0IGlub2RlCj4gPiAqaW5vZGUsIHN0
cnVjdCBuZnNfZmF0dHIgKmZhdHRyKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG5mc2ktPmNhY2hlX3ZhbGlkaXR5IHw9Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHNhdmVfY2FjaGVfdmFsaWRpdHkgJgo+ID4gTkZTX0lOT19JTlZB
TElEX0JMT0NLUzsKPiA+IAo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoZmF0dHItPnZhbGlkICYgTkZT
X0FUVFJfRkFUVFJfT0ZGTElORSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5m
c2ktPm9mZmxpbmUgPSAoZmF0dHItPmhzYV9mbGFncyAmCj4gPiBORlNfSFNBX09GRkxJTkUpID8g
MSA6IDA7Cj4gPiArwqDCoMKgwqDCoMKgIGVsc2UgaWYgKGZhdHRyX3N1cHBvcnRlZCAmIE5GU19B
VFRSX0ZBVFRSX09GRkxJTkUpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZnNp
LT5jYWNoZV92YWxpZGl0eSB8PQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHNhdmVfY2FjaGVfdmFsaWRpdHkgJgo+ID4gTkZTX0lOT19JTlZBTElEX1dJ
TkFUVFI7Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoCAvKiBVcGRhdGUgYXR0cnRpbWVvIHZhbHVl
IGlmIHdlJ3JlIG91dCBvZiB0aGUgdW5zdGFibGUKPiA+IHBlcmlvZCAqLwo+ID4gwqDCoMKgwqDC
oMKgwqAgaWYgKGF0dHJfY2hhbmdlZCkgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIG5mc19pbmNfc3RhdHMoaW5vZGUsIE5GU0lPU19BVFRSSU5WQUxJREFURSk7Cj4gPiBkaWZm
IC0tZ2l0IGEvZnMvbmZzL25mczRwcm9jLmMgYi9mcy9uZnMvbmZzNHByb2MuYwo+ID4gaW5kZXgg
NGU2Y2M1NDAxNmJhLi43MTNhNzFmYjMwMjAgMTAwNjQ0Cj4gPiAtLS0gYS9mcy9uZnMvbmZzNHBy
b2MuYwo+ID4gKysrIGIvZnMvbmZzL25mczRwcm9jLmMKPiA+IEBAIC0yMTksNiArMjE5LDcgQEAg
Y29uc3QgdTMyIG5mczRfZmF0dHJfYml0bWFwWzNdID0gewo+ID4gwqAjaWZkZWYgQ09ORklHX05G
U19WNF9TRUNVUklUWV9MQUJFTAo+ID4gwqDCoMKgwqDCoMKgwqAgRkFUVFI0X1dPUkQyX1NFQ1VS
SVRZX0xBQkVMCj4gPiDCoCNlbmRpZgo+ID4gK8KgwqDCoMKgwqDCoCB8IEZBVFRSNF9XT1JEMl9P
RkZMSU5FCj4gPiDCoH07Cj4gCj4gVGhpcyB3b24ndCBjb21waWxlIGlmIENPTkZJR19ORlNfVjRf
U0VDVVJJVFlfTEFCRUw9bjoKPiAKPiBmcy9uZnMvbmZzNHByb2MuYzoyMTg6OTogZXJyb3I6IGV4
cGVjdGVkIGV4cHJlc3Npb24gYmVmb3JlIOKAmHzigJkgdG9rZW4KPiDCoCAyMTggfMKgwqDCoMKg
wqDCoMKgwqAgfCBGQVRUUjRfV09SRDJfT0ZGTElORQoKT2guLi4gQ2FuIHlvdSBmaXggaXQgdXAg
YnkganVzdCBtb3ZpbmcgdGhhdCAnfCcgaW5zaWRlIHRoZSAjaWZkZWY/CgoKCi0tIApUcm9uZCBN
eWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK
