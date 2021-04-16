Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6493616DB
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 02:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhDPAkm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 20:40:42 -0400
Received: from mail-mw2nam10on2121.outbound.protection.outlook.com ([40.107.94.121]:27585
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234708AbhDPAkm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 15 Apr 2021 20:40:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaClme1fYkhEUsfAQu1elCbhOgacichh5f4bqzH8BNI4cgF5pMB8f9kIstbW+rQeZ899Bw7PsRsorCUmqwuPa3WTgb1aALk17V1ECHOfTfqCJ5Ie14NFfZbo4czfrLz4tdEVnpwBkiee3AxeDvE3kfo6nI42xBMF3y02HFD4fFYwxjWHFqjSwpRcUrfu9u6rwf0YbB3ISXRENGo2c/mxTbQmxJHNYzOpE3+tORmcnvp5lnQdy9hs8S1AYTlZ2wE1fWeG3egA7PM2LYdxKF+4fXrE/+GiOgmYvhDs5fSb+SaBD6jn8v1kHot5ZGZQxE8GmeNVrUFi7/+ifIn0bW6DjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDPogcsKToD6XUIz7zz+uWH3lhp2g0zCa5o9nEB8EuQ=;
 b=IJMD2KLtxSeQy/Ym55S0cG4ln8p1R8ZF6Y5DuLwEixPKit/M6OwLAmQ9DSgu1OjfExFAZyY8eoMzfNU74bUl91iaI1VFhhDVl2YjBYlfcQ4TULaXExeRswkyWBIjN7izyu8oOJMfQvB+kGkE7+zfuk83tgULehvLzgoF5h9tR/OcQlMayThcY8HK5paVGuzIOSONiZYy1krwtLRaslZZvFToegbsrAAusKD5+ER+gzGGedHILtX4hi1u8CJtKfHQD0oC74FdqdLXIjDlb3Cfps40L1gf1rLEBW3y6A8DW77g/IjTql5ew5aKjrX6lIJb0XERMN14OBYTiJPYoIqsMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDPogcsKToD6XUIz7zz+uWH3lhp2g0zCa5o9nEB8EuQ=;
 b=bMNt1QOK4rju8bcTB4rYqq2TZj9gA3GuKVQvAtrX6G/tgzGaFwXPdUs6bWQto3Gc9Xk7Z70iW5eKcGeHO7hv/M2cHtNhyHZA/1XXrJhfY8+C3aQLxgWILqfks5xf8vU3tkVNuLnrK4iR9qFl0QuYghR2pk5DsNofakpZyioJzlY=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB2377.namprd13.prod.outlook.com (2603:10b6:5:ca::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.14; Fri, 16 Apr
 2021 00:40:16 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0%4]) with mapi id 15.20.4065.006; Fri, 16 Apr 2021
 00:40:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "ajmitchell@redhat.com" <ajmitchell@redhat.com>,
        "SteveD@RedHat.com" <SteveD@RedHat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Thread-Topic: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Thread-Index: AQHXMVl4VT45tjmxiUS0kqeKowHWU6q0qJsAgAEODwCAABHMAIAAc2kAgAATkIA=
Date:   Fri, 16 Apr 2021 00:40:16 +0000
Message-ID: <ee4bff1c4705ee61f04377bf024fe4bae540d858.camel@hammerspace.com>
References: <20210414181040.7108-1-steved@redhat.com>
         <AA442C15-5ED3-4DF5-B23A-9C63429B64BE@oracle.com>
         <5adff402-5636-3153-2d9f-d912d83038fc@RedHat.com>
         <366FA143-AB3E-4320-8329-7EA247ADB22B@oracle.com>
         <bf7a7563989477a30490e3982665f90bdcfa1016.camel@hammerspace.com>
In-Reply-To: <bf7a7563989477a30490e3982665f90bdcfa1016.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 513c97ee-0728-42c4-6354-08d9007034a1
x-ms-traffictypediagnostic: DM6PR13MB2377:
x-microsoft-antispam-prvs: <DM6PR13MB2377D190460D4C074B2209A5B84C9@DM6PR13MB2377.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EQceOYMcOh7TQdjyeGGYOAgA7VsHZV3XL9wq3RTgvJzBTrvbYrgRYO0VDebqGYk3TCn5KypEw7fcbR4C1f7rRvk0XcbX341w7uugHoshjBiQb92aelq5zttf4GiJJ6SdznXx/UqinK9S4oLBBSdgu02KTWGWIWU1egGx9qhSYjW0mpJfeOhUzbeGeK1TT1nJVNzrLTlKk00Eb82XARZanvhAITYpvvPa7X9hseAH8Xrj5dasX9xgP+dYdqoc30bH6OFU+czLCaLuEFvVEjciA3P7zadc30KeeDJV4uA3+8oLPCWvBgXZsMbpYw87QzGMGZ/CREEhYFjOo2xUH/O0XpuRApDC6MvrE+QdZcjc/MtIDNjCOyYVDO5al7OpZgu4suAeSD7q/MwTw51hqdSrIhNWEjeG3r/r7VvfvmSDnIcKSUcXd2UgBa9L7+QW1SjKxjJWVQGDVNLGBZ++WV6ofnB/PCbn8lzpoODni1RtuAr8Xm5iM0my70XFF63Cb1CfRRlY0JzI/sEg8b1oXJgQDYFLUz9r+drMukn1vsw3WsDWLM27/mKkjOw92C/TmlK2pCGIPJUm3w57bFiJ0770eicYlrxBSm7IN/x2JcYX5RQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39840400004)(396003)(376002)(366004)(6506007)(316002)(4326008)(86362001)(71200400001)(66556008)(53546011)(66446008)(91956017)(5660300002)(64756008)(66946007)(66476007)(36756003)(122000001)(6486002)(8936002)(2906002)(2616005)(38100700002)(6512007)(26005)(83380400001)(8676002)(110136005)(186003)(478600001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cjJTVzBQdXF4Y0tHdkU2ZjZnMWpYblo3YUpRM3dsSHhENEtkdVlneUJmVWVW?=
 =?utf-8?B?bGRRZUFOZTlpMWtSWDlwbnhLblBpd0pGZnFMZW00TmxmS3p5OWlFaFVPZVdP?=
 =?utf-8?B?Uk5SaTA0VDlGcEVnSktKeC9uRWJVWFFJRXlYZmc1TXlVUkFtREJqUE9Kc2tM?=
 =?utf-8?B?WWJWcVQ5NklEajZnMjM5c2tWUHJDY1lTc1hrRnBqeXNSOGRDMUhBdHdodFUz?=
 =?utf-8?B?SWYrRmNvbDFDR2orR1dyeS9yYXh3L0dFZWVKR05HM1hTcy9kcklLVXNlN2U1?=
 =?utf-8?B?YmRON0ZHNjh0akVGSzNTcGZrZGUxcVdFYWhQOHFyeDJyRXlyWVMyc3RzWE1Y?=
 =?utf-8?B?NHdpeHlERjN2WWlKRkZ5SmZHK1cyR1FHamR1TmxnN2FKL0R1dXdvb1kwUmZp?=
 =?utf-8?B?NCtzQWlTTFR6NXFjKy91UEFHMTBibGRPVUVtU0tyUjRRczZSZG1NWkU2SEdC?=
 =?utf-8?B?K1BRMlF2azZGaFl2V3pSSHpEN2VaaExyYWlMNTZjdEpONnVsSVM5M3NpL1lk?=
 =?utf-8?B?eFhrZzJWU0VuVTFxY3IrbTBrTVYzWFlZbEg0YkNULy80dkxwTFRJZDNsSjh4?=
 =?utf-8?B?OC9nM0JiR1doblpXb3g4SlpoQVJ5M2IyK2QzWHUyQnN3c2dtQ2pvSFJuKzZD?=
 =?utf-8?B?SGxoOTN5NUFDeWZRS21iTVF5eTFkOTcwbjRnYjd4bXcvWjNYbGhHQkVBbVRk?=
 =?utf-8?B?cnZiZmxiakl3TzZMN2Uwb0NCVWdyMldDbkw1TGxHWjNzU1prZWhLU0tMYTMz?=
 =?utf-8?B?UndIdXZjZy9MbnMvRHFiRFlQWlc1RVhiWGgzYzR5dUlBbnhoeU56VUhndEFW?=
 =?utf-8?B?UTJncnlJdHVaQTVWV3FZRUl5enF0MGhueWxLSldLK3Y3VHVVR1Z0UityWXBt?=
 =?utf-8?B?ZHRHWmd2OTdGbERsenlsek5zMm1TdUVGMmdmU3QzUzNwOVJWYmxHR0htU28w?=
 =?utf-8?B?VVBodVp4OWg5aEhRZ25FZGRYR0Y4QnowM2NaYVNpNkF3RWpvQlNuSk5mMkZR?=
 =?utf-8?B?MnlKTG5xTVNPdkRuMmxFMkZlY2IzNXU5U3BZaFR0dWUzSWMwVWkrQ3pJT3pB?=
 =?utf-8?B?RCtBbWdEMmlyNTJnVkdISFUwUHBreDVxTmhubDJPTjBLOERLWG1EdXk5MHF2?=
 =?utf-8?B?S3pJaE9yOTRtOWJPeXA3Vm1Ea2VjTG9yR0NCczVTZFlyWGN5Z3k3bzk1UTRu?=
 =?utf-8?B?TkJpdFNXYlVLcitqMXcyWVk1dTZqYVRlRTU3ZWdXU2pSZjI0bU1VTEg3emIz?=
 =?utf-8?B?SHNhbHNWUzhMR0J0Zlc5bWdqZ2xFbDhOekFuNUJMaEpwV2M5ZXgrM0ZWMGhk?=
 =?utf-8?B?NWY4MWpFdkhsTTFFNHVkcGxiVDVMSjU0b1RLYkhTcVl4UW0xWmJ0MWk4bXp3?=
 =?utf-8?B?SXprL3ZpYzNISFg5ZGtTa2lXcE1ReXFDWktMWGVyVWl4OEovTFlJVXZUeUVO?=
 =?utf-8?B?bk1VT2VraGtrNlhHaUN2ejM0M3A4bTNxRXIrMWtQZGlOMXJKNzVHSFF4VW1G?=
 =?utf-8?B?bmdVV2hxcXRYYnBROVM4b0IvQjBldWlLbWM3RTIzejJ5MmdyYVZML2p0V0wr?=
 =?utf-8?B?WjNUbktoSzNadS9WN2JHWTNmUkw3bXdqTE45cmhXOFhlRDVPZERnM1pSY29n?=
 =?utf-8?B?RWUwbElrVUdxRThjRWpQWVBkTEJGb0RvTUN6WUJ1bmZvUGJ2dFBTSmw1aHJN?=
 =?utf-8?B?azdhQkw5eVdtRDZjT0JWeFl6Yy9iZjBQZXFMZk1ucjdLckVPY3JqN0ZFWDB3?=
 =?utf-8?Q?iGukXD3StIZDoR6rKh+5xiXJbOuho4GJNpSahYp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D34CC761CBDD58449899D288C33ABAD4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513c97ee-0728-42c4-6354-08d9007034a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 00:40:16.8337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5RtAMFAS+tjJN/8OD2zBVHJQhaYFogJpnHccaRuBQGMIXXsxrriY2GwrqnGmTkqtPBGGYg+KmL7P+3JIaXWBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2377
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTA0LTE1IGF0IDIzOjMwICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFRodSwgMjAyMS0wNC0xNSBhdCAxNjozNyArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdy
b3RlOg0KPiA+IA0KPiA+IA0KPiA+ID4gT24gQXByIDE1LCAyMDIxLCBhdCAxMTozMyBBTSwgU3Rl
dmUgRGlja3NvbiA8U3RldmVEQFJlZEhhdC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+IA0KPiA+
ID4gSGV5IENodWNrISANCj4gPiA+IA0KPiA+ID4gT24gNC8xNC8yMSA3OjI2IFBNLCBDaHVjayBM
ZXZlciBJSUkgd3JvdGU6DQo+ID4gPiA+IEhpIFN0ZXZlLQ0KPiA+ID4gPiANCj4gPiA+ID4gPiBP
biBBcHIgMTQsIDIwMjEsIGF0IDI6MTAgUE0sIFN0ZXZlIERpY2tzb24gPFN0ZXZlREByZWRoYXQu
Y29tPg0KPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IO+7v1RoaXMgaXMg
YSB0d2VhayBvZiB0aGUgcGF0Y2ggc2V0IEFsaWNlIE1pdGNoZWxsIHBvc3RlZCBsYXN0DQo+ID4g
PiA+ID4gSnVseSBbMV0uDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGF0IGFwcHJvYWNoIHdhcyBkcm9w
cGVkIGxhc3QgSnVseSBiZWNhdXNlIGl0IGlzIG5vdCBjb250YWluZXItDQo+ID4gPiA+IGF3YXJl
Lg0KPiA+ID4gPiBJdCBzaG91bGQgYmUgc2ltcGxlIGZvciBzb21lb25lIHRvIHdyaXRlIGEgdWRl
diBzY3JpcHQgdGhhdCB1c2VzDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBleGlzdGluZyBzeXNmcyBB
UEkgdGhhdCBjYW4gdXBkYXRlIG5mczRfY2xpZW50X2lkIGluIGEgbmFtZXNwYWNlLg0KPiA+ID4g
PiBJDQo+ID4gPiA+IHdvdWxkIHByZWZlciB0aGUgc3lzZnMvdWRldiBhcHByb2FjaCBmb3Igc2V0
dGluZyBuZnM0X2NsaWVudF9pZCwNCj4gPiA+ID4gc2luY2UgaXQgaXMgY29udGFpbmVyLWF3YXJl
IGFuZCBtYWtlcyB0aGlzIHNldHRpbmcgY29tcGxldGVseQ0KPiA+ID4gPiBhdXRvbWF0aWMgKHpl
cm8gdG91Y2gpLg0KPiA+ID4gQXMgSSBzYWlkIGluIGluIG15IGNvdmVyIGxldHRlciwgSSBzZWUg
dGhpcyBtb3JlIGFzIGludHJvZHVjdGlvbiBvZg0KPiA+ID4gYSBtZWNoYW5pc20gbW9yZSB0aGFu
IGEgd2F5IHRvIHNldCB0aGUgdW5pcXVlIGlkLg0KPiA+IA0KPiA+IFllcCwgSSBnb3QgdGhhdC4N
Cj4gPiANCj4gPiBJJ20gbm90IGFkZHJlc3NpbmcgdGhlIHF1ZXN0aW9uIG9mIHdoZXRoZXIgYWRk
aW5nIGENCj4gPiBtZWNoYW5pc20gdG8gc2V0IGEgbW9kdWxlIHBhcmFtZXRlciBpbiBuZnMuY29u
ZiBpcyBnb29kDQo+ID4gb3Igbm90LiBJJ20gc2F5aW5nIG5mczRfY2xpZW50X2lkIGlzIG5vdCBh
biBhcHByb3ByaWF0ZQ0KPiA+IHBhcmFtZXRlciB0byBhZGQgdG8gbmZzLmNvbmYuIENhbiB5b3Ug
cGljayBhbm90aGVyDQo+ID4gbW9kdWxlIHBhcmFtZXRlciBhcyBhbiBleGFtcGxlIGZvciB5b3Vy
IG1lY2hhbmlzbT8NCj4gPiANCj4gPiANCj4gPiA+IFRoZSBtZWNoYW5pc20gYmVpbmcNCj4gPiA+
IGEgd2F5IHRvIHNldCBrZXJuZWwgbW9kdWxlIHBhcmFtcyBmcm9tIG5mcy5jb25mLiBUaGUgc2V0
dGluZyBvZg0KPiA+ID4gdGhlIGlkIGlzIGp1c3QgYSBzaWRlIGVmZmVjdC4uLiANCj4gPiA+IA0K
PiA+ID4gV2h5IHNwcmVhZCBvdXQgdGhlIE5GUyBjb25maWd1cmF0aW9uP8KgIFdoeSBub3QNCj4g
PiA+IGp1c3Qga2VlcCBpdCBpbiBvbmUgcGxhY2UuLi4gYWthIG5mcy5jb25mPw0KPiA+IA0KPiA+
IFdlIG5lZWQgdG8gdW5kZXJzdGFuZCB3aGV0aGVyIGEgbW9kdWxlIHBhcmFtZXRlciBpcyBub3QN
Cj4gPiBnb2luZyB0byB3b3JrIGluIG5mcy5jb25mIGJlY2F1c2UgdGhhdCBzZXR0aW5nIG5lZWRz
IHRvDQo+ID4gYmUgbmFtZXNwYWNlLWF3YXJlLiBJbiB0aGlzIGNhc2UsIHRoaXMgc2V0dGluZyBk
b2VzIGluZGVlZA0KPiA+IG5lZWQgdG8gYmUgbmFtZXNwYWNlLWF3YXJlLiBuZnMuY29uZiBpcyBu
b3QgYXdhcmUgb2YNCj4gPiBuZXR3b3JrIG5hbWVzcGFjZXMuDQo+ID4gDQo+ID4gDQo+ID4gPiBQ
bHVzIHdlIGNvdWxkIGRvY3VtZW50IGFsbCB0aGUga2VybmVsIHBhcmFtcyBpbiBuZnMuY29uZg0K
PiA+ID4gYW5kIHRoZSBuZnMuY29uZiBtYW4gcGFnZS4gVGhlIG9ubHkgZG9jdW1lbnRhdGlvbiBJ
IGtub3cgDQo+ID4gPiBvZiBpcyBpbiB0aGUga2VybmVsIHRyZWUuDQo+ID4gDQo+ID4gT0ssIGJ1
dCB0aGF0J3Mgbm90IHJlbGV2YW50IHRvIHdoZXRoZXIgbmZzLmNvbmYgaXMgdGhlDQo+ID4gcmln
aHQgcGxhY2UgdG8gc2V0IG5mczRfY2xpZW50X2lkLg0KPiA+IA0KPiA+IA0KPiA+ID4gQXMgZmFy
IGFzIG5vdCBiZWluZyBjb250YWluZXItYXdhcmUuLi4gdGhhdCBtaWdodCB0cnVlDQo+ID4gPiBi
dXQgaXQgZG9lcyBub3QgbWVhbiBpdHMgbm90IHVzZWZ1bCB0byBzZXQgdGhlIGlkIGZyb20NCj4g
PiA+IG5mcy5jb25mLi4uDQo+ID4gDQo+ID4gWWVzLCBpdCBkb2VzIG1lYW4gdGhhdCBpbiB0aGF0
IGNhc2UuIEl0J3MgY29tcGxldGVseQ0KPiA+IGJyb2tlbiB0byB1c2UgdGhlIHNhbWUgbmZzNF9j
bGllbnRfaWQgaW4gZXZlcnkgbmV0d29yaw0KPiA+IG5hbWVzcGFjZS4NCj4gPiANCj4gPiANCj4g
PiA+IEFjdHVhbCBJIGhhdmUgY3VzdG9tZXJzIGFza2luZyBmb3IgdGhpcyB0eXBlDQo+ID4gPiBv
ZiBmdW5jdGlvbmFsaXR5DQo+ID4gDQo+ID4gQXNrIHlvdXJzZWxmIHdoeSB0aGV5IG1pZ2h0IHdh
bnQgaXQuIEl0J3MgcHJvYmFibHkgYmVjYXVzZQ0KPiA+IHdlIGRvbid0IHNldCBpdCBjb3JyZWN0
bHkgY3VycmVudGx5LiBJZiB3ZSBoYXZlIGEgd2F5IHRvDQo+ID4gYXV0b21hdGljYWxseSBnZXQg
aXQgcmlnaHQgZXZlcnkgdGltZSwgdGhlcmUncyByZWFsbHkgbm8NCj4gPiBuZWVkIGZvciB0aGlz
IHNldHRpbmcgdG8gYmUgZXhwb3NlZC4NCj4gPiANCj4gPiBJIGRvIGFncmVlIHRoYXQgaXQncyBs
b25nIHBhc3QgdGltZSB3ZSBzaG91bGQgYmUgc2V0dGluZw0KPiA+IG5mczRfY2xpZW50X2lkIHBy
b3Blcmx5LiBJIHdvdWxkIHJhdGhlciBzZWUgYSB1ZGV2IHNjcmlwdA0KPiA+IGRldmVsb3BlZCAo
eW91LCBtZSwgb3IgQWxpY2UgY291bGQgZG8gaXQgaW4gYW4gYWZ0ZXJub29uKQ0KPiA+IGZpcnN0
LiBJZiB0aGF0IGRvZXNuJ3QgbWVldCB0aGUgYWN0dWFsIGN1c3RvbWVyIG5lZWQsIHRoZW4NCj4g
PiB3ZSBjYW4gcmV2aXNpdC4NCj4gPiANCj4gDQo+IFJpZ2h0LiBUaGUgb25seSBzZW5zaWJsZSBz
b2x1dGlvbiBpbiBhIGNvbnRhaW5lcmlzZWQgd29ybGQgaXMgYSB1ZGV2DQo+IHNjcmlwdCB0aGF0
IHNldHMgL3N5cy9mcy9uZnMvbmV0L25mc19jbGllbnQvaWRlbnRpZmllciB3aGVuIHRyaWdnZXJl
ZC4NCj4gDQo+IE5vdGUgdGhhdCB3ZSByZWFsbHkgd2FudCBzb21ldGhpbmcgdGhhdCBnZW5lcmF0
ZXMgYSByYW5kb20gdXVpZCwgYW5kDQo+IHRoZW4gcGVyc2lzdHMgaXQgc28gdGhhdCBpdCBjYW4g
YmUgcmV0cmlldmVkIG9uIHJlYm9vdCBvciByZXN0YXJ0IG9mDQo+IHRoZSBjb250YWluZXIuIFNv
bWV0aGluZyBzaW1pbGFyIHRvIHN5c3RlbWQtbWFjaGluZS1pZC1zZXR1cCwgYnV0IHRoYXQNCj4g
Y2FuIGJlIGNhbGxlZCBmcm9tIHVkZXYuDQo+IA0KDQpIZXJlIGlzIGEgc2tlbGV0b24gZXhhbXBs
ZToNCg0KW3Jvb3RAbGVpcmEgcnVsZXMuZF0jIGNhdCAvZXRjL3VkZXYvcnVsZXMuZC81MC1uZnM0
LnJ1bGVzIA0KQUNUSU9OPT0iYWRkIiBLRVJORUw9PSJuZnNfY2xpZW50IiBBVFRSe2lkZW50aWZp
ZXJ9PT0iKG51bGwpIiBQUk9HUkFNPSIvdXNyL3NiaW4vbmZzNF91dWlkIiBBVFRSe2lkZW50aWZp
ZXJ9PSIlYyINCg0KW3Jvb3RAbGVpcmEgcnVsZXMuZF0jIGNhdCAvdXNyL3NiaW4vbmZzNF91dWlk
IA0KIyEvYmluL2Jhc2gNCiMNCmlmIFsgISAtZiAvZXRjL25mczRfdXVpZCBdDQp0aGVuDQoJdXVp
ZD0iJCh1dWlkZ2VuIC1yKSINCgllY2hvIC1uICR7dXVpZH0gPiAvZXRjL25mczRfdXVpZA0KZWxz
ZQ0KCXV1aWQ9IiQoY2F0IC9ldGMvbmZzNF91dWlkKSINCmZpDQplY2hvICR7dXVpZH0NCg0KDQpP
YnZpb3VzbHksIHRoZSAvdXNyL3NiaW4vbmZzNF91dWlkIHdvdWxkIG5lZWQgdG8gYmUgZmxlc2hl
ZCBvdXQgYQ0KbGl0dGxlIG1vcmUgdG8gZW5zdXJlIHRoYXQgdGhlIGZpbGUgL2V0Yy9uZnM0X3V1
aWQgYWN0dWFsbHkgY29udGFpbnMgYQ0KdXVpZCBpbiB0aGUgcmlnaHQgZm9ybWF0LCBidXQgeW91
IGdldCB0aGUgZ2lzdC4uLg0KDQpXaXRoIHRoZSBhYm92ZSBhZGRpdGlvbnMsIEkgZW5kIHVwIHdp
dGggYSByZXBlYXRhYmxlDQoNCltyb290QGxlaXJhIHJ1bGVzLmRdIyBtb2Rwcm9iZSBuZnM0DQpb
cm9vdEBsZWlyYSBydWxlcy5kXSMgY2F0IC9zeXMvZnMvbmZzL25ldC9uZnNfY2xpZW50L2lkZW50
aWZpZXIgDQo3ZjlmMjExYi0wMjUzLTRlZjgtYTk3MC1iMWIwZjYwMGFmMDINCltyb290QGxlaXJh
IHJ1bGVzLmRdIyBjYXQgL2V0Yy9uZnM0X3V1aWQgDQo3ZjlmMjExYi0wMjUzLTRlZjgtYTk3MC1i
MWIwZjYwMGFmMDINCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
DQo=
