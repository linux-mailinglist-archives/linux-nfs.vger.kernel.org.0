Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B810A3A06C1
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 00:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhFHW34 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 18:29:56 -0400
Received: from mail-sn1anam02on2128.outbound.protection.outlook.com ([40.107.96.128]:16647
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229526AbhFHW34 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 8 Jun 2021 18:29:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMY1HZ+mLnhQt8QKz5jhcSLToCHYTmYKV27wE10++OTLsNaQUl88ecWi7Gaq6CHY6j0RtyWfmlRKf5DXeVP110tiuAvjUCpr2xGIA9nlDmz7dqA9kUPLmKNhoQpNSq3o7zGycSiqhxcyiEY6ZVQCUzp1WjywyDzrCv2JU+QUzZSFDW08yclaLDyshOQag9By3Ih+s67GhhIxulK2ZAdSlwygkCyXZso9H0A+SD/rWORtulEy/q5XrjtmGO/x7etERTooRhUx3R1J7xiKYXNjTs7VFR3tDxXSWm8+cj9G/x91cATu6I8746hu75R++Bl7V9XRRUxGashji7u1cYprmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsDTrPVffwvAe+nuS2M7CDOHyHDoT9URPvTvsfkkDTM=;
 b=loAuAro1y073GIrFAPwxHmDSWGdr8ceA5ORkfmCBC4wSUyvo7hM4G+J/Jrq31eSoEvVkC28+mAgeeynDbIErteZLfbxycM673dGCP9cyfeYjiE4oz6IgOeCeQJ0Uk2m1js6PLBip6KqpzB7Inp6dcChyHTzwGw5KdgZ4jz6PdhQKFhcnk3WQw0ZG+J6UyrTX+tzwBvF8n8kI11up/WMnjEQBGR4sdex4yFeovyZJZEIzTAcBHl/Voo4Dec9uzftCNmvB0fD7SnHB3LILwmuMqX1kT0R4PudpwcCPgc1wlTKZgbtCHdYPVf9+dEcn6ZIaKUvsgRW4rhHRdQn+jxdV5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsDTrPVffwvAe+nuS2M7CDOHyHDoT9URPvTvsfkkDTM=;
 b=XpS+RL2X4HiNnSFzYh5tERKKwu00ilF5IQ8i3vJPK7TOHZdeu4mfkeOxsthFdbmoHgX5LA81duGM6EB4ktnMAo8x6rqYL0CziXcOfhOp+CIv5arumlc4t9wyO4dg38oZmLGjIuwaPdY29xm/gW+B3ngJ8O51OVlEeH+fgKg8g/w=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM5PR13MB0988.namprd13.prod.outlook.com (2603:10b6:3:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9; Tue, 8 Jun
 2021 22:27:56 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 22:27:56 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Topic: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Index: AQHXXJZ2q4Fg/jBv8EW7vOhaPbIm9asKlDaAgAAEKoCAAALKAIAACWKAgAAJNoCAAAGBAIAAAp2A
Date:   Tue, 8 Jun 2021 22:27:56 +0000
Message-ID: <358d1ea7b7e9cd59fb01470e0ac978520788c013.camel@hammerspace.com>
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
         <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com>
         <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
         <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com>
         <CAN-5tyGP7UtcWcWzNiE9k+=Er+BhjO3dMJAe484htUOSry9gow@mail.gmail.com>
         <4c73319e5b826a8f3c9a29b085c42e181150d08c.camel@hammerspace.com>
         <CAN-5tyFrhpyT9_Gfz0CRDv_-ecKRGE7ma0+WUWQot0qgS38wxg@mail.gmail.com>
In-Reply-To: <CAN-5tyFrhpyT9_Gfz0CRDv_-ecKRGE7ma0+WUWQot0qgS38wxg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44d3b5d0-7573-4dfe-6c36-08d92accaa4d
x-ms-traffictypediagnostic: DM5PR13MB0988:
x-microsoft-antispam-prvs: <DM5PR13MB0988CD8D8716B260260D5A01B8379@DM5PR13MB0988.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hhn8+ix/YxyV3NsM5XnUaNxGk9HGDkrVfoTs7Rzpi+wo1OiSuiOx/YLYwrWm6UkGgdKvs4LlSdaHEzyiux9SewKnSFxFX1SZvF5lj1uRwPRxNLgNL8PFmrbH9T5I4A4cJPwiPI7gVBdq/q0XB9MXaKhhL5qU68QwCN/4TGp78RgzhRnVPh4eAa74yOnOWvqeHECMV/uktltl2I16S7B7h1AWor+/C0DVDMii5Ly++D25hn2Pf+NE/GF3wjsZvPMK07+46DI+AYiicalfn3SbHebtFO6R1M7625Aw4wIQZ/cQ1ybgzuDPyX8VLb2LsKIHS5VkJibghAsUj/mNwPfj25CXsAK1CLkv8v6aH5UP7lR4w4Fh1mZ7+GYMN/HnVTugUOxBtvpXyNYYkBO0hkkCyZYz3KssGA2X1zlrGE9p/z5tHPXBGYxSfcTx23mOpTq3l3yjMOTyrinmqkiF2DzB2hTCiaXB9Y/e6wiDrnGJHhHJ+LgPBAmP0nplCXOSs1U+zuOv2L/Y39WWuB7mijQwfqm5BJH/KO0cAKYof8u1ieFubJFiiE87V3EJEuRT9FCqHQesq9vHTfEB8eu0LBHTyPBrAsfZt+VhQo5zarnx+g8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(4326008)(38100700002)(53546011)(6506007)(36756003)(64756008)(66476007)(66946007)(26005)(54906003)(76116006)(86362001)(498600001)(5660300002)(91956017)(66446008)(66556008)(83380400001)(8936002)(6486002)(2616005)(71200400001)(122000001)(2906002)(8676002)(186003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzNiMURaS1l0MzFCK0Yrb1JDalRiM1kra094NjBCV2FXMmMyZFZUb0FhSXV2?=
 =?utf-8?B?cXppNDBqU3RwMFc3SzhLMlAyV3NGR0NUUHdsRngzN0JOeSttYUZsSlBnUlRw?=
 =?utf-8?B?cDJPSjgwYUsyUEgwd05hQUl3UGowR0xuYU13VnlWRVBPckxLc1ZJK0NqcHhz?=
 =?utf-8?B?dnlYTkJlSTFydGVJWFZDS0wyNWhIS2w0T2lyLzJMN3Q1c0t0TjBVZUhvRm90?=
 =?utf-8?B?aDU5RGg4SHlHNTdHdTFYenc0YWo0dytyWDFyNHJHaTBxRG93S1Jtd1g5Q2dW?=
 =?utf-8?B?RmpWVXNxUnJVZG1TUWdWSDdpMmxCL1RER1JDRmZjWkZFUFpqTHhLdzc0bjBF?=
 =?utf-8?B?QXc0VUxSSC8yNHAxOWtqa0VSODIxMVhScDRPM1JRMmZzQTlUTDdiQzlpalBP?=
 =?utf-8?B?Rjc2RUNIbG9RSEpsQ3dEVy9ZQ0FhM1Ixb3ZrdW5xY09hbXdHNzhaVFBrYlIv?=
 =?utf-8?B?M0RubFdyM3FFbTU5SGJwa1dhRnN0b2tQVEV1S2lWamQ4akcrcmREc3RHZGxZ?=
 =?utf-8?B?QkVtQU5RSzk1bDFkMFhKeVNkU0VMb0xPd1JKWkRGMXZ3QVhycElENjVSSldZ?=
 =?utf-8?B?d3RHWWtUZXlqaVp0R2RmbTZZNm5MdkNXdjNpYzRjeEIwTGQyNlgzVjd0czRC?=
 =?utf-8?B?VFhhNkJBcDJIU1o3aGZHMkhObFQxelhjWnRpbndzcFRnVXBSejUvZFBrWmZT?=
 =?utf-8?B?NDRpK0J4c0J1NURFZzBYVnZ5YWx1cTV3ejl1TGhWZUlZaVZKbjk3YzY5TTR5?=
 =?utf-8?B?amdTZWNxbjFQVm1rWTFEeTBBSEhuMXdWS1UzdVUvMmU3TXpkdWlnNDE5TlhU?=
 =?utf-8?B?M3MvVTBnNjE0ckxWTzlZdFdRd0VEL0tDbFdmTTZBd3JMLyswK0VJKy9WeWxU?=
 =?utf-8?B?TlU0VGErYWQ5dzErTzZ2MXhQak1SRG1EN2pEZDhvS2NYNFFmemxNZEhjTC8x?=
 =?utf-8?B?UlhIZzY4Z3NEbDVSQUs0ODBmTEF2N25OYzRhLzl1VG5nbVhNTDM5S0FHcHhk?=
 =?utf-8?B?YmhnL09sb2ZVazBEYU9lMVBITXFlTUEwbVRURlhQc2k3bm1KMm5namwvYUxK?=
 =?utf-8?B?NGIxdkZIaktuRCtKSUNBUW93bEIrSWNnUHNkN2dnL0x6QVZZK2tIbjhaQWNB?=
 =?utf-8?B?N28vcHh4ek1SS2U2VnNPZncwK1ZWV2QxNFdCWWF4T1VZN0xVYVB4NHdJZ09k?=
 =?utf-8?B?ejFPVk1WTmZMU2xZKzJlWm1RWFBjWjIzbjlXQ3E2dGFob1ZaMlU3d3RPSDlC?=
 =?utf-8?B?bE9lcEpWalZjYXJpMUd0NC8vVmNjaU1HWkNKcGxFS3IzektKOC9heWwyRDZR?=
 =?utf-8?B?NVdML1FuVnRhc256ZlZOTlVlWFYyUlZyd1lwUllqQ2FmS0hGKzR0MGdOakhp?=
 =?utf-8?B?aGd5NTZuck1VaW9ESENvRlVyZkhaa3p2UXNJV1pQbWdYUmYzSTlqVXFQTUZx?=
 =?utf-8?B?bFM4amcrY0FzNGRXdWVMS3hxUTYwRThOVHNGZ2Z0ZHNKTG55MjBTSFRWcytG?=
 =?utf-8?B?VUtVSk5JZHFvdi9UVm93MThTOFZNM3dxUVdHbkErNXVMdU9nM1VxcUE3VHp2?=
 =?utf-8?B?b0hXa1hBalR2Z1hJejc2alUvOGtBVnRqUkFEWFpyZm9OSGhsNDJYT09iZW9R?=
 =?utf-8?B?cTVheG5RZXJHTWhZQzlVSUxhbGNGUHN2U1lFVzBxSVlKOXJyOEU2YVVzZGFI?=
 =?utf-8?B?Vzl1TEtvOVA4NmQ3MmtpY2ViT0dnQnA2ditqZzQ1YjUvNzRNRWY0REwzWXpT?=
 =?utf-8?Q?MBxOQoJsaDjP0YH3I5e7LAcTBrdEm7zGN9ScZU5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5FCD08EB91C8B43A8F6BB5BD0844C38@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d3b5d0-7573-4dfe-6c36-08d92accaa4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 22:27:56.7057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUbB1MzlflyD7jQr+A9Liijiv6YKycj2Yh5yBx8fNMXtgmRxtXqk9uQ7OgOuP+xcLBwBfErH7C/f8Oa///fTig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB0988
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTA4IGF0IDE4OjE4IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVHVlLCBKdW4gOCwgMjAyMSBhdCA2OjEzIFBNIFRyb25kIE15a2xlYnVzdCA8IA0K
PiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVHVlLCAyMDIx
LTA2LTA4IGF0IDE3OjQwIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+IE9u
IFR1ZSwgSnVuIDgsIDIwMjEgYXQgNTowNiBQTSBDaHVjayBMZXZlciBJSUkgPA0KPiA+ID4gY2h1
Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4g
DQo+ID4gPiA+ID4gT24gSnVuIDgsIDIwMjEsIGF0IDQ6NTYgUE0sIE9sZ2EgS29ybmlldnNrYWlh
IDwNCj4gPiA+ID4gPiBvbGdhLmtvcm5pZXZza2FpYUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IE9uIFR1ZSwgSnVuIDgsIDIwMjEgYXQgNDo0MSBQTSBDaHVjayBMZXZl
ciBJSUkgPA0KPiA+ID4gPiA+IGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBPbiBKdW4g
OCwgMjAyMSwgYXQgMjo0NSBQTSwgT2xnYSBLb3JuaWV2c2thaWEgPA0KPiA+ID4gPiA+ID4gPiBv
bGdhLmtvcm5pZXZza2FpYUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gRnJvbTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+ID4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBBZnRlciB0cnVua2luZyBpcyBkaXNjb3ZlcmVkIGlu
DQo+ID4gPiA+ID4gPiA+IG5mczRfZGlzY292ZXJfc2VydmVyX3RydW5raW5nKCksDQo+ID4gPiA+
ID4gPiA+IGFkZCB0aGUgdHJhbnNwb3J0IHRvIHRoZSBvbGQgY2xpZW50IHN0cnVjdHVyZSBiZWZv
cmUNCj4gPiA+ID4gPiA+ID4gZGVzdHJveWluZw0KPiA+ID4gPiA+ID4gPiB0aGUgbmV3IGNsaWVu
dCBzdHJ1Y3R1cmUgKGFsb25nIHdpdGggaXRzIHRyYW5zcG9ydCkuDQo+ID4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0
YXBwLmNvbT4NCj4gPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiA+IGZzL25mcy9uZnM0Y2xp
ZW50LmMgfCA0MA0KPiA+ID4gPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gPiA+ID4gPiA+IDEgZmlsZSBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCsp
DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRj
bGllbnQuYyBiL2ZzL25mcy9uZnM0Y2xpZW50LmMNCj4gPiA+ID4gPiA+ID4gaW5kZXggNDI3MTkz
ODRlMjVmLi45ODRjODUxODQ0ZDggMTAwNjQ0DQo+ID4gPiA+ID4gPiA+IC0tLSBhL2ZzL25mcy9u
ZnM0Y2xpZW50LmMNCj4gPiA+ID4gPiA+ID4gKysrIGIvZnMvbmZzL25mczRjbGllbnQuYw0KPiA+
ID4gPiA+ID4gPiBAQCAtMzYxLDYgKzM2MSw0NCBAQCBzdGF0aWMgaW50DQo+ID4gPiA+ID4gPiA+
IG5mczRfaW5pdF9jbGllbnRfbWlub3JfdmVyc2lvbihzdHJ1Y3QgbmZzX2NsaWVudCAqY2xwKQ0K
PiA+ID4gPiA+ID4gPiDCoMKgwqDCoCByZXR1cm4gbmZzNF9pbml0X2NhbGxiYWNrKGNscCk7DQo+
ID4gPiA+ID4gPiA+IH0NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ICtzdGF0aWMgdm9p
ZCBuZnM0X2FkZF90cnVuayhzdHJ1Y3QgbmZzX2NsaWVudCAqY2xwLA0KPiA+ID4gPiA+ID4gPiBz
dHJ1Y3QNCj4gPiA+ID4gPiA+ID4gbmZzX2NsaWVudCAqb2xkKQ0KPiA+ID4gPiA+ID4gPiArew0K
PiA+ID4gPiA+ID4gPiArwqDCoMKgwqAgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgY2xwX2FkZHIs
IG9sZF9hZGRyOw0KPiA+ID4gPiA+ID4gPiArwqDCoMKgwqAgc3RydWN0IHNvY2thZGRyICpjbHBf
c2FwID0gKHN0cnVjdCBzb2NrYWRkcg0KPiA+ID4gPiA+ID4gPiAqKSZjbHBfYWRkcjsNCj4gPiA+
ID4gPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCBzb2NrYWRkciAqb2xkX3NhcCA9IChzdHJ1Y3Qgc29j
a2FkZHINCj4gPiA+ID4gPiA+ID4gKikmb2xkX2FkZHI7DQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDC
oCBzaXplX3QgY2xwX3NhbGVuLCBvbGRfc2FsZW47DQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoCBz
dHJ1Y3QgeHBydF9jcmVhdGUgeHBydF9hcmdzID0gew0KPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC5pZGVudCA9IG9sZC0+Y2xfcHJvdG8sDQo+ID4gPiA+ID4gPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLm5ldCA9IG9sZC0+Y2xfbmV0LA0KPiA+ID4gPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5zZXJ2ZXJuYW1lID0gb2xkLT5jbF9ob3N0bmFt
ZSwNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIH07DQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoCBz
dHJ1Y3QgbmZzNF9hZGRfeHBydF9kYXRhIHhwcnRkYXRhID0gew0KPiA+ID4gPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5jbHAgPSBvbGQsDQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDC
oCB9Ow0KPiA+ID4gPiA+ID4gPiArwqDCoMKgwqAgc3RydWN0IHJwY19hZGRfeHBydF90ZXN0IHJw
Y2RhdGEgPSB7DQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmFkZF94
cHJ0X3Rlc3QgPSBvbGQtPmNsX212b3BzLQ0KPiA+ID4gPiA+ID4gPiA+c2Vzc2lvbl90cnVuaywN
Cj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuZGF0YSA9ICZ4cHJ0ZGF0
YSwNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIH07DQo+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiA+ID4gK8KgwqDCoMKgIGlmIChjbHAtPmNsX3Byb3RvICE9IG9sZC0+Y2xfcHJvdG8pDQo+ID4g
PiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiA+ID4gPiA+ID4g
PiArwqDCoMKgwqAgY2xwX3NhbGVuID0gcnBjX3BlZXJhZGRyKGNscC0+Y2xfcnBjY2xpZW50LA0K
PiA+ID4gPiA+ID4gPiBjbHBfc2FwLA0KPiA+ID4gPiA+ID4gPiBzaXplb2YoY2xwX2FkZHIpKTsN
Cj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIG9sZF9zYWxlbiA9IHJwY19wZWVyYWRkcihvbGQtPmNs
X3JwY2NsaWVudCwNCj4gPiA+ID4gPiA+ID4gb2xkX3NhcCwNCj4gPiA+ID4gPiA+ID4gc2l6ZW9m
KG9sZF9hZGRyKSk7DQo+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIGlm
IChjbHBfYWRkci5zc19mYW1pbHkgIT0gb2xkX2FkZHIuc3NfZmFtaWx5KQ0KPiA+ID4gPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gPiA+ID4gPiA+ID4gKw0KPiA+
ID4gPiA+ID4gPiArwqDCoMKgwqAgeHBydF9hcmdzLmRzdGFkZHIgPSBjbHBfc2FwOw0KPiA+ID4g
PiA+ID4gPiArwqDCoMKgwqAgeHBydF9hcmdzLmFkZHJsZW4gPSBjbHBfc2FsZW47DQo+ID4gPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHhwcnRkYXRhLmNyZWQgPSBuZnM0X2dl
dF9jbGlkX2NyZWQob2xkKTsNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHJwY19jbG50X2FkZF94
cHJ0KG9sZC0+Y2xfcnBjY2xpZW50LCAmeHBydF9hcmdzLA0KPiA+ID4gPiA+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcnBjX2NsbnRfc2V0dXBfdGVz
dF9hbmRfYWRkX3hwcnQsDQo+ID4gPiA+ID4gPiA+ICZycGNkYXRhKTsNCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gSXMgdGhlcmUgYW4gdXBwZXIgYm91bmQgb24gdGhlIG51bWJlciBvZiB0cmFu
c3BvcnRzIHRoYXQNCj4gPiA+ID4gPiA+IGFyZSBhZGRlZCB0byB0aGUgTkZTIGNsaWVudCdzIHN3
aXRjaD8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIGRvbid0IGJlbGlldmUgYW55IGxpbWl0cyBl
eGlzdCByaWdodCBub3cuIFdoeSBzaG91bGQgdGhlcmUNCj4gPiA+ID4gPiBiZSBhDQo+ID4gPiA+
ID4gbGltaXQ/IEFyZSB5b3Ugc2F5aW5nIHRoYXQgdGhlIGNsaWVudCBzaG91bGQgbGltaXQgdHJ1
bmtpbmc/DQo+ID4gPiA+ID4gV2hpbGUNCj4gPiA+ID4gPiB0aGlzIGlzIG5vdCB3aGF0J3MgaGFw
cGVuaW5nIGhlcmUsIGJ1dCBzYXkgRlNfTE9DQVRJT04NCj4gPiA+ID4gPiByZXR1cm5lZA0KPiA+
ID4gPiA+IDEwMA0KPiA+ID4gPiA+IGlwcyBmb3IgdGhlIHNlcnZlci4gQXJlIHlvdSBzYXlpbmcg
dGhlIGNsaWVudCBzaG91bGQgYmUNCj4gPiA+ID4gPiBsaW1pdGluZw0KPiA+ID4gPiA+IGhvdw0K
PiA+ID4gPiA+IG1hbnkgdHJ1bmthYmxlIGNvbm5lY3Rpb25zIGl0IHdvdWxkIGJlIGVzdGFibGlz
aGluZyBhbmQNCj4gPiA+ID4gPiBwaWNraW5nDQo+ID4gPiA+ID4ganVzdCBhDQo+ID4gPiA+ID4g
ZmV3IGFkZHJlc3NlcyB0byB0cnk/IFdoYXQncyBoYXBwZW5pbmcgd2l0aCB0aGlzIHBhdGNoIGlz
DQo+ID4gPiA+ID4gdGhhdA0KPiA+ID4gPiA+IHNheQ0KPiA+ID4gPiA+IHRoZXJlIGFyZSAxMDBt
b3VudHMgdG8gMTAwIGlwcyAoZWFjaCByZXByZXNlbnRpbmcgdGhlIHNhbWUNCj4gPiA+ID4gPiBz
ZXJ2ZXINCj4gPiA+ID4gPiBvcg0KPiA+ID4gPiA+IHRydW5rYWJsZSBzZXJ2ZXIocykpLCB3aXRo
b3V0IHRoaXMgcGF0Y2ggYSBzaW5nbGUgY29ubmVjdGlvbg0KPiA+ID4gPiA+IGlzDQo+ID4gPiA+
ID4ga2VwdCwNCj4gPiA+ID4gPiB3aXRoIHRoaXMgcGF0Y2ggd2UnbGwgaGF2ZSAxMDAgY29ubmVj
dGlvbnMuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgcGF0Y2ggZGVzY3JpcHRpb24gbmVlZHMgdG8g
bWFrZSB0aGlzIGJlaGF2aW9yIG1vcmUgY2xlYXIuDQo+ID4gPiA+IEl0DQo+ID4gPiA+IG5lZWRz
IHRvIGV4cGxhaW4gIndoeSIgLS0gdGhlIGJvZHkgb2YgdGhlIHBhdGNoIGFscmVhZHkNCj4gPiA+
ID4gZXhwbGFpbnMNCj4gPiA+ID4gIndoYXQiLiBDYW4geW91IGluY2x1ZGUgeW91ciBsYXN0IHNl
bnRlbmNlIGluIHRoZSBkZXNjcmlwdGlvbg0KPiA+ID4gPiBhcw0KPiA+ID4gPiBhIHVzZSBjYXNl
Pw0KPiA+ID4gDQo+ID4gPiBJIHN1cmUgY2FuLg0KPiA+ID4gDQo+ID4gPiA+IEFzIGZvciB0aGUg
YmVoYXZpb3IuLi4gU2VlbXMgdG8gbWUgdGhhdCB0aGVyZSBhcmUgZ29pbmcgdG8gYmUNCj4gPiA+
ID4gb25seQ0KPiA+ID4gPiBpbmZpbml0ZXNpbWFsIGdhaW5zIGFmdGVyIHRoZSBmaXJzdCBmZXcg
Y29ubmVjdGlvbnMsIGFuZCBhZnRlcg0KPiA+ID4gPiB0aGF0LCBpdCdzIGdvaW5nIHRvIGJlIGEg
bG90IGZvciBib3RoIHNpZGVzIHRvIG1hbmFnZSBmb3Igbm8NCj4gPiA+ID4gcmVhbA0KPiA+ID4g
PiBnYWluLiBJIHRoaW5rIHlvdSBkbyB3YW50IHRvIGNhcCB0aGUgdG90YWwgbnVtYmVyIG9mDQo+
ID4gPiA+IGNvbm5lY3Rpb25zDQo+ID4gPiA+IGF0IGEgcmVhc29uYWJsZSBudW1iZXIsIGV2ZW4g
aW4gdGhlIEZTX0xPQ0FUSU9OUyBjYXNlLg0KPiA+ID4gDQo+ID4gPiBEbyB5b3Ugd2FudCB0byBj
YXAgaXQgYXQgMTYgbGlrZSB3ZSBkbyBmb3IgbmNvbm5lY3Q/IEknbSBvayB3aXRoDQo+ID4gPiB0
aGF0DQo+ID4gPiBmb3Igbm93Lg0KPiA+ID4gDQo+ID4gPiBJIGRvbid0IHVuZGVyc3RhbmQgd2h5
IGEgc2V0dXAgd2hlcmUgdGhlcmUgWCBOSUNzIG9uIGVhY2ggc2lkZQ0KPiA+ID4gKGNsaWVudC9z
ZXJ2ZXIpIGFuZCBYIG1vdW50cyBhcmUgZG9uZSwgdGhlcmUgd29uJ3QgYmUgdGhyb3VnaHB1dA0K
PiA+ID4gb2YNCj4gPiA+IGNsb3NlIHRvIFggKiB0aHJvdWdocHV0IG9mIGEgc2luZ2xlIE5JQy4N
Cj4gPiANCj4gPiBUaGF0IHN0aWxsIGRvZXMgbm90IG1ha2UgdGhlIHBhdGNoIGFjY2VwdGFibGUu
IFRoZXJlIGFyZSBhbHJlYWR5DQo+ID4gc2VydmVyDQo+ID4gdmVuZG9ycyBzZWVpbmcgcHJvYmxl
bXMgd2l0aCBzdXBwb3J0aW5nIG5jb25uZWN0IGZvciB2YXJpb3VzDQo+ID4gcmVhc29ucy4NCj4g
DQo+IFdoeSBhcmUgdGhlcmUgc2VydmVycyBwcmVzZW50aW5nIG11bHRpcGxlIElQIGFkZHJlc3Nl
cyBhbmQgcmV0dXJuaW5nDQo+IHRoZSBzYW1lIHNlcnZlciBpZGVudGl0eSBpZiB0aGV5IGNhbiBu
b3Qgc3VwcG9ydCB0cnVua2luZz8gVGhhdCBzZWVtcw0KPiB0byBiZSBnb2luZyBhZ2FpbnN0IHRo
ZSBzcGVjPw0KDQpUaGF0J3Mgbm90IGEgcXVlc3Rpb24gSSBjYW4gYW5zd2VyLCBidXQgSSdtIG5v
dCB0aGlua2luZyBvZiBvdXIgc2VydmVyDQpvciB0aGUgTGludXggc2VydmVyLg0KDQo+IA0KPiA+
IFRoZXJlIG5lZWRzIHRvIGJlIGEgd2F5IHRvIGVuc3VyZSB0aGF0IHdlIGNhbiBrZWVwIHRoZSBj
dXJyZW50DQo+ID4gY2xpZW50DQo+ID4gYmVoYXZpb3VyIHdpdGhvdXQgcmVxdWlyaW5nIGNoYW5n
ZXMgdG8gc2VydmVyIEROUyBlbnRyaWVzLCBldGMuDQo+IA0KPiBPaywgaG93IGFib3V0IHdlIGlu
dHJvZHVjZSBhIG1vdW50IG9wdGlvbiwgImVuYWJsZV90cnVua2luZyIsIGFuZCBpZg0KPiB0aGF0
J3MgcHJlc2VudCB3ZSB3b3VsZCBub3QgY29sbGFwc2UgdHJhbnNwb3J0cz8NCg0KSSdkIHN1Z2dl
c3QgbWFraW5nIGl0ICdtYXhfY29ubmVjdD1YJyBzbyB0aGF0IHdlIGNhbiBhY3R1YWxseSBzZXQg
YQ0KbGltaXQgbGlrZSB3ZSBkbyBmb3IgbmNvbm5lY3QuIFRoYXQgbGltaXQgcHJvYmFibHkgbmVl
ZHMgdG8gYmUgbG93ZXINCmJvdW5kZWQgYnkgdGhlIHZhbHVlIG9mIG5jb25uZWN0Lg0KDQo+IA0K
PiA+ID4gDQo+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIGlmICh4cHJ0
ZGF0YS5jcmVkKQ0KPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHB1dF9j
cmVkKHhwcnRkYXRhLmNyZWQpOw0KPiA+ID4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gPiA+IC8qKg0KPiA+ID4gPiA+ID4gPiAqIG5mczRfaW5pdF9jbGllbnQgLSBJbml0
aWFsaXNlIGFuIE5GUzQgY2xpZW50IHJlY29yZA0KPiA+ID4gPiA+ID4gPiAqDQo+ID4gPiA+ID4g
PiA+IEBAIC00MzQsNiArNDcyLDggQEAgc3RydWN0IG5mc19jbGllbnQNCj4gPiA+ID4gPiA+ID4g
Km5mczRfaW5pdF9jbGllbnQoc3RydWN0IG5mc19jbGllbnQgKmNscCwNCj4gPiA+ID4gPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB3b24ndCB0cnkgdG8gdXNlIGl0Lg0KPiA+ID4g
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLw0KPiA+ID4gPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzX21hcmtfY2xpZW50X3JlYWR5KGNscCwgLUVQRVJNKTsN
Cj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAob2xkLT5jbF9tdm9w
cy0+c2Vzc2lvbl90cnVuaykNCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbmZzNF9hZGRfdHJ1bmsoY2xwLCBvbGQpOw0KPiA+ID4gPiA+ID4g
PiDCoMKgwqDCoCB9DQo+ID4gPiA+ID4gPiA+IMKgwqDCoMKgIGNsZWFyX2JpdChORlNfQ1NfVFNN
X1BPU1NJQkxFLCAmY2xwLT5jbF9mbGFncyk7DQo+ID4gPiA+ID4gPiA+IMKgwqDCoMKgIG5mc19w
dXRfY2xpZW50KGNscCk7DQo+ID4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gPiA+IDIuMjcuMA0K
PiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiA+
IENodWNrIExldmVyDQo+ID4gPiA+IA0KPiA+ID4gPiAtLQ0KPiA+ID4gPiBDaHVjayBMZXZlcg0K
PiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+IA0KPiA+IC0tDQo+ID4gVHJvbmQgTXlr
bGVidXN0DQo+ID4gTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KPiA+
IHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCj4gPiANCj4gPiANCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
