Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3FF313F11
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Feb 2021 20:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbhBHTdM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Feb 2021 14:33:12 -0500
Received: from mail-bn7nam10on2139.outbound.protection.outlook.com ([40.107.92.139]:2897
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235494AbhBHTcc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Feb 2021 14:32:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENRtxbBsVPs6ZJlMqOFgpQZQjOcRmccpGm27p2E/Cvp/UgvNLSFvz5iAsFOGdO5ZEn9qt2+pgT8Q6pWUJ40MmHPDSlrMmHUXO6CZ76krJtQL9xQdWi2KXwIYXTyoYGxlTRwL8tkw5hx/02WR7Jg19CcFb6FQkfbP5J8rCpc6svbVeBO/EtCdXwg+vD7+E0WDcm0KRio2H6fyny9svAAeOhjdTyZPc8Y1xqmp/K7rOshrRyfdRYHGAW++AXjW/OUTzlaHk6NyuMSrqapVeGWXmtCKus7hpJ9lJR2eF/7eM2FiF7jNSW0uc/AFOtrcKTAzRxvjP57exy9btAKzaezRBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrImwTnIJLykSDiOuPm0aXrsPtOcwFTE46mqHOxZ5/I=;
 b=F1FwfBDseHGm4K6EWRXTUzlq1r0h90edV9I+uVYSyVPSRlbrHTYpGJ7YhLtVGRkGEGT5vW9+nM2EVEDCSofBohOPM0D2AsPLjigUK6qYoEDxQ2wfM8qOFIRtuABuhdw1cC3tkd7VPiwFx6W4YevnCi7wiEktMfsX/ijPRntqwF3ro/oVE2sfcS8Q2YF7i9H+GoQptlRYujhLJNJX74JFQ3jrv+OxLlQ1jnkcgaKEYe8UlVkV3ARoUFzmFp9j3yYvqQEYLNv9LWnobBhD1/8ujWiEOg5j3kzmqSASdQe5MwR5VJykgx2p6AtsmCnMAVEc0QDE87ko9vtlujHuHUfxxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrImwTnIJLykSDiOuPm0aXrsPtOcwFTE46mqHOxZ5/I=;
 b=Unj5WO1PbN7fhOmyAisImEta4FY1FDA5d2wBfMyY9tPP0N2qjl/14j/hEuEBM+phc/a4UxNcAnMENHr8btlK8mV6ETJL2mZ9Utpr1NxFuau8eQTs3mZYfFpiz0Ze4EnvMEOp8YktXg2UHXPHWRsvGSjVIqWXM0rcT4O2I4275ZE=
Received: from (2603:10b6:610:21::29) by
 CH2PR13MB3766.namprd13.prod.outlook.com (2603:10b6:610:9d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.8; Mon, 8 Feb 2021 19:31:38 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3846.025; Mon, 8 Feb 2021
 19:31:38 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "guy@vastdata.com" <guy@vastdata.com>,
        "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: we don't support removing system.nfs4_acl
Thread-Topic: [PATCH] nfs: we don't support removing system.nfs4_acl
Thread-Index: AQHW9cYMuXIITkQqQEuvjSotXZGpBqo9sNIAgAAiJoCAABBKgIAABEGAgARP34CAABWNgIAEmAoAgAfRg4A=
Date:   Mon, 8 Feb 2021 19:31:38 +0000
Message-ID: <6dc98a594a21b86316bf77000dc620d6cca70be6.camel@hammerspace.com>
References: <20210128223638.GE29887@fieldses.org>
         <95e5f9e4-76d4-08c4-ece3-35a10c06073b@vastdata.com>
         <cbc7115cc5d5aeb7ffb9e9b3880e453bf54ecbdb.camel@hammerspace.com>
         <20210129023527.GA11864@fieldses.org> <20210129025041.GA12151@fieldses.org>
         <7a078b4d22c8d769a42a0c2b47fd501479e47a7b.camel@hammerspace.com>
         <20210131215843.GA9273@fieldses.org> <20210203200756.GA30996@fieldses.org>
In-Reply-To: <20210203200756.GA30996@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9ec3d7f-8466-486f-ab09-08d8cc6827a7
x-ms-traffictypediagnostic: CH2PR13MB3766:
x-microsoft-antispam-prvs: <CH2PR13MB3766225B51D14CED7BBE8302B88F9@CH2PR13MB3766.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JvLI4jaukqUHt3pA8L4iGqwVUt5Tvrr/0o8+/D7P+pJ1OaKKTNRrZC7VQaKLn3kt5GCKerHUbJVE9SBGAzj5o05ZqMlKKm7wTC+tx7hDF86pPTWD95BbXah7RmZXBFqM8pZysa762GXBHu0Z5TrGpygUm7Ev8Z/u/6gEtawOZ6/B4K3bT0Ih5e0ZXuh58k12tYMGyUE8mhq1VzDvd9SeH7uvjgGoZq4+5BP6e/wtZxrU2R2stGAXyPMzeQNrt83/FE6OC/rdjuH18SgIgdh1hn14AAdoOtC0VfIK59mm+x2L+FKJ/Sgs0/h+9YC1NpSp3KkrTnuelNxobgRtgknuToc7e7JaOLzL3KenxgawvqmzTxxAdRC/VTpV+BnvP826WJ2XYr1/9frPvENytPjuO97qjw4qD552FW2/3V/Y3NjQvIK8W468utDjszRJAz7ECNYRG4wIZMtvq6hkyaWF0wZv7nrCbZnuVeuNcSgglJ/Zvw4mhAd+JqkMOcP1HaLgSEFQ0cU322PzdJrIInCuhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39830400003)(396003)(376002)(136003)(26005)(86362001)(4326008)(316002)(36756003)(8676002)(478600001)(186003)(83380400001)(2906002)(54906003)(2616005)(6506007)(5660300002)(8936002)(6512007)(66556008)(66476007)(66946007)(76116006)(66446008)(64756008)(71200400001)(6486002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VGRJUmFqbXZHZFBXZmduU3M0N1JVQ3grdy92RlM0MzFKc1FldDkzc244bVhF?=
 =?utf-8?B?cVZjeTgwRkhnUDlLcjREaGhnbExvV1AyZDRhQWZYWWJsTEVMNHNTOGRlUW9W?=
 =?utf-8?B?T3NEZ01WUjJMN1FWRVFDZU5sTTgrSmE3aHBHL2tXYzhON2lOcW1EbDdiZVJw?=
 =?utf-8?B?MGFMZk1jQUdWbXpSay9SVzJobUh0VWNyVDJJY0FiU1VXRUVrS1cwalFHS1pO?=
 =?utf-8?B?RXpQRFBPUy9HRmI0b2xwQWVJczUxKzZBT3JQOFVvUG4zWFl0Rjl3WlA0SGVG?=
 =?utf-8?B?NkdaZTBSUkdFc2tGWUhKSzgveDBqMTNRLzVrOE9jQ2s2QjJycEhlL1BKZ1BB?=
 =?utf-8?B?azE3T2JNa2J6bGFkdXR0R3BLNDVLRytmdHplRWR0cktwNG44ZGxYd3FURStB?=
 =?utf-8?B?d0RWdGkycHR4RzRaVk5DV3pyNDRPeHZZZ1BwT0VuUTN2a2JvZFVVMTBSZ0JE?=
 =?utf-8?B?cWVxNDNZWGZDVndDTXYzN1ZkcHlQZ1J4OGZlenJsU2Q4aXd4MTdjR2Y3SkF3?=
 =?utf-8?B?RG9wSXpLMkRQZWUxTndmSVpRQjFMNWh5NzhLejhSM08yUmZWTGlpVFR2SE1H?=
 =?utf-8?B?SVh6WHpxRDFSdEVMaCsySy9zY1p3aXdCZkFkcWJYaGUzUm8vRThIdklTZTN1?=
 =?utf-8?B?VW03eURHOTJZbGEvcnBRZnp5MWI2WUh2N1dPVzhLSDVRdzRYVjRlQkVYUGU3?=
 =?utf-8?B?RjhpWTFaaCtYYm5Rc1I5YjFYOVI4OUJsZVQrM1I3UERFSHZzSSttbUlaclBs?=
 =?utf-8?B?djVKODc4K1NQQ21ITm1PV1h0UkVibVJJWXhQeHNKeE5VRmFLRUVPQzN2MmhI?=
 =?utf-8?B?S3lCb3FVZU5GVC9rVGRGWXFPUnI4Q1p0Tlc5RVdKVGg4US80QTE0RFJ6VXo3?=
 =?utf-8?B?bDFLZFg5dVRhNm96QzhCSkxqZ3NDVEhHVFRIMFUrK1p6cW0yWDEyQ3ZWRFRI?=
 =?utf-8?B?RWNwM0FLUnBaVEFMaTVmWnVXUmxMYjRmRThQT3h6eHV3Z3hjVGtnaSsvMkh3?=
 =?utf-8?B?V2xhT0ZhVGs4OFZJajEvazVTUHpDc0lqcXpuWTJ3TEd2Qmw3SDlWNkx1MnAx?=
 =?utf-8?B?UjRwSmc0d3J1Qk5IL243ekF6N2lpeUxKeWF1S2JwSFc2K1p3d0pBT2F0YWN3?=
 =?utf-8?B?bFdEQ3VpVU15U08yMng1Tjg1UWRnK3BhM0liVjUwaU5kK0FscmdoVFoyRUNG?=
 =?utf-8?B?TjhNbTdiODVueTEwZ2w4SkpMaCsvQ0pzcmUrakx1elhiQWlUdjBlVGEvbTQy?=
 =?utf-8?B?UFdScStlNW1CM1VyWU5YM09sL1VXN1RIMEVMQUlSaDMzeHlVT1V4TEprSWx4?=
 =?utf-8?B?d2Nsa3FPM1lqekR5ckpNWHNWaGhaTmdNMzVIaTFQMzB3cWNEbnRWQWtGTnhC?=
 =?utf-8?B?RXgyU2ozY0VGbTRiV0VtY1praHdOcUk1bW1nNU1kWndrSFpXenNqbW9qanVa?=
 =?utf-8?B?TWtIZmZQT3pObkxtcldlQkdqL0E0Vmp0UmpYcWdkM3FOOG5NM2tsNWFKdTZ3?=
 =?utf-8?B?TTlTN1ZkbmU2NlF1dGFMSk52UVpKbnN4eFNyNnJycDRDd3V5V2cyaTBweXF3?=
 =?utf-8?B?bXlOVE9zWE81dDF3YXQ5RjYwVmRYSjlVUEpDdERUYnV2Q3lTOUlET0RtbUNZ?=
 =?utf-8?B?NUNINlpxQWI2anNtZURGYzlWd0M5VUFUa3RYdUpkMHo2enpvUlVSY2VQRFlO?=
 =?utf-8?B?cmw4ZHpTbW84clhnb0JXdmNPeUY3bWtCSFBPTy9IME0zMFo2RHpzMkNKZllY?=
 =?utf-8?Q?nU9dd69Pl2RdMMzZOUZXtgUIFXkjCskf1XW8kiI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1AF83D7A050614BA4AFA3B520F3107D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ec3d7f-8466-486f-ab09-08d8cc6827a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 19:31:38.6120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EugB45wyBKovsxR720rWSfgpkXZEArmkkC2VqfZ4kOGf4b4lpaWg4IafIFM6aBz6rviSvOjgu0A9LUB1B9eg5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3766
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTAyLTAzIGF0IDE1OjA3IC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gU3VuLCBKYW4gMzEsIDIwMjEgYXQgMDQ6NTg6NDNQTSAtMDUwMCwgYmZpZWxk
c0BmaWVsZHNlcy5vcmfCoHdyb3RlOg0KPiA+IE9uIFN1biwgSmFuIDMxLCAyMDIxIGF0IDA4OjQx
OjM3UE0gKzAwMDAsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+IE9uIFRodSwgMjAyMS0w
MS0yOCBhdCAyMTo1MCAtMDUwMCwgYmZpZWxkc0BmaWVsZHNlcy5vcmfCoHdyb3RlOg0KPiA+ID4g
PiBPbiBUaHUsIEphbiAyOCwgMjAyMSBhdCAwOTozNToyN1BNIC0wNTAwLA0KPiA+ID4gPiBiZmll
bGRzQGZpZWxkc2VzLm9yZ8Kgd3JvdGU6DQo+ID4gPiA+ID4gTm90ZSB0aGF0IHRoaXMgcGF0Y2gg
ZG9lc24ndCBwcmV2ZW50IGFuIGFwcGxpY2F0aW9uIGZyb20NCj4gPiA+ID4gPiBzZXR0aW5nIGEN
Cj4gPiA+ID4gPiB6ZXJvLWxlbmd0aCBBQ0wuwqAgVGhlIHhhdHRyIGZvcm1hdCBpcyBYRFIgd2l0
aCB0aGUgZmlyc3QgZm91cg0KPiA+ID4gPiA+IGJ5dGVzDQo+ID4gPiA+ID4gcmVwcmVzZW50aW5n
IHRoZSBudW1iZXIgb2YgQUNFcywgc28geW91J2Qgc2V0IGEgemVyby1sZW5ndGgNCj4gPiA+ID4g
PiBBQ0wgYnkNCj4gPiA+ID4gPiBwYXNzaW5nIGRvd24gYSA0LWJ5dGUgYWxsLXplcm8gYnVmZmVy
IGFzIHRoZSBuZXcgdmFsdWUgb2YgdGhlDQo+ID4gPiA+ID4gc3lzdGVtLm5mczRfYWNsIHhhdHRy
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEEgemVyby1sZW5ndGggTlVMTCBidWZmZXIgaXMgd2hh
dCdzIHVzZWQgdG8gaW1wbGVtZW50DQo+ID4gPiA+ID4gcmVtb3ZleGF0dHI6DQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gaW50DQo+ID4gPiA+ID4gX192ZnNfcmVtb3ZleGF0dHIoc3RydWN0IGRlbnRy
eSAqZGVudHJ5LCBjb25zdCBjaGFyICpuYW1lKQ0KPiA+ID4gPiA+IHsNCj4gPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgLi4uDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBoYW5kbGVy
LT5zZXQoaGFuZGxlciwgZGVudHJ5LCBpbm9kZSwgbmFtZSwNCj4gPiA+ID4gPiBOVUxMLCAwLA0K
PiA+ID4gPiA+IFhBVFRSX1JFUExBQ0UpOw0KPiA+ID4gPiA+IH0NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBUaGF0J3MgdGhlIGNhc2UgdGhpcyBwYXRjaCBjb3ZlcnMuDQo+ID4gPiA+IA0KPiA+ID4g
PiBTbywgSSBzaG91bGQgaGF2ZSBzYWlkIGluIHRoZSBjaGFuZ2Vsb2csIGFwb2xvZ2llcy0tdGhl
DQo+ID4gPiA+IGJlaGF2aW9yDQo+ID4gPiA+IHdpdGhvdXQNCj4gPiA+ID4gdGhpcyBwYXRjaCBp
cyB0aGF0IHdoZW4gaXQgZ2V0cyBhIHJlbW92ZXhhdHRyLCB0aGUgY2xpZW50IHNlbmRzDQo+ID4g
PiA+IGENCj4gPiA+ID4gU0VUQVRUUiB3aXRoIGEgYml0bWFwIGNsYWltaW5nIHRoZXJlJ3MgYW4g
QUNMIGF0dHJpYnV0ZSwgYnV0IGENCj4gPiA+ID4gemVyby1sZW5ndGggYXR0cmlidXRlIHZhbHVl
IGxpc3QsIGFuZCB0aGUgc2VydmVyIChjb3JyZWN0bHkpDQo+ID4gPiA+IHJldHVybnMNCj4gPiA+
ID4gQkFEWERSLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gSSBkb24ndCBzZWUgYW55dGhpbmcg
aW4gdGhlIHNwZWMgdGhhdCBwcm9oaWJpdHMgYSB6ZXJvIGxlbmd0aA0KPiA+ID4gYXJyYXkNCj4g
PiA+IHNpemUgZm9yIG5mczQxX2FjZXM8PiBvciBzdGF0ZXMgdGhhdCBzaG91bGQgcmV0dXJuDQo+
ID4gPiBORlM0RVJSX0JBRFhEUi4gV2h5DQo+ID4gPiBzaG91bGRuJ3Qgd2UgYWxsb3cgdGhhdD8N
Cj4gPiANCj4gPiBBZ2FpbjogSSBhZ3JlZS7CoCBBbmQgd2UgZG8gYWxsb3cgdGhhdCwgYm90aCBi
ZWZvcmUgYW5kIGFmdGVyIHRoaXMNCj4gPiBwYXRjaC4NCj4gPiANCj4gPiBUaGVyZSdzIGEgZGlm
ZmVyZW5jZSBiZXR3ZWVuIGEgU0VUQVRUUiB3aXRoIGEgemVyby1sZW5ndGggYm9keSBhbmQNCj4g
PiBhDQo+ID4gU0VUQVRUUiB3aXRoIGEgYm9keSBjb250YWluaW5nIGEgemVyby1sZW5ndGggQUNM
LsKgIFRoZSBmb3JtZXIgaXMNCj4gPiBiYWQNCj4gPiBwcm90b2NvbCwgdGhlIGxhdHRlciBpcywg
SSBhZ3JlZSwgZmluZS4NCj4gDQo+IEFyZSB3ZSBvbiB0aGUgc2FtZSBwYWdlIG5vdz/CoCBPciBz
aG91bGQgSSB1cGRhdGUgdGhlIGNoYW5nZWxvZyBhbmQNCj4gcmVzZW5kPw0KPiANCg0KT0suIFNv
IHlvdSdyZSBub3QgcmVhbGx5IHNheWluZyB0aGF0IHRoZSBTRVRBVFRSIGhhcyBhIHplcm8gbGVu
Z3RoDQpib2R5LCBidXQgdGhhdCB0aGUgQUNMIGF0dHJpYnV0ZSBpbiB0aGlzIGNhc2UgaGFzIGEg
emVybyBsZW5ndGggYm9keSwNCndoZXJlYXMgaW4gdGhlICdlbXB0eSBhY2wnIGNhc2UsIGl0IGlz
IHN1cHBvc2VkIHRvIGhhdmUgYSBib2R5DQpjb250YWluaW5nIGEgemVyby1sZW5ndGggbmZzYWNl
NDw+IGFycmF5LiBGYWlyIGVub3VnaC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5G
UyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJz
cGFjZS5jb20NCg0KDQo=
