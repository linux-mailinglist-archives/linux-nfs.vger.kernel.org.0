Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95ABB3AF639
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jun 2021 21:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhFUThp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Jun 2021 15:37:45 -0400
Received: from mail-dm3nam07on2091.outbound.protection.outlook.com ([40.107.95.91]:42145
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230076AbhFUThp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 21 Jun 2021 15:37:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0jvP7XK3YUauj9kmRZNIOJk1qyFUqImgKGNdtEWIq5cA5biFSPB4gAXBQebpJ5jTL1qdGVI2mo6eVTeoViQ1gXe9YJSULqFTXS2pTp7tR1ojQYXro1xK4Q2kJQpK6di1pEEIi92xY4pJNpBV3O8V//Mlzj++leoZfxMyUP6l3/lVE6aiuzXq0nrCdyRJgZaazZqweUaFDWcaQr9nVtuZQVW8NR6tIJHhCTcaKVmTs03QWsKcOZK+xyhjTnF6qFKuneoERe5OprFZQf8GjU25pW2Hx7G9mtwScOE+tXE12mVcO3OXC+wkP42dWgC9KyOrsXxpJjtzHFRH9UPYALgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ScZk0OwLF1ryA/505LqtqvVmrimU+HBwAqdVjXESzI=;
 b=LRSpD78Ha8Ah+53ogGuqOOst2TXgC8fG/PF7atIkGI0ItzaGGbYFKprGTsg5//YOXmQCxkbBaTRwd2UVx+9Y0bYbRMt3cJjGhqb1oYSYaJ1fOUZ+a2VCzTij16F7NNhvNmJDmD+EBmGr1/I3IhPBJJZbTIAlpsuAF7MGkBXIRNCXVYuwFGc4TD3IJH6FJpJgJ1QQ5X5UwBUye5MuVNyg/mNl7tGhv6gWe8a+MawafB51MQDzbTWBMKTd8P10qMURYB/0vBkw81vHMIeAtikXoodVNWM3ycTqyziLHb4h2xYv6OCxccrjKa5cR+InVvPfmHm+ersXpjeDuHsVHYgr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ScZk0OwLF1ryA/505LqtqvVmrimU+HBwAqdVjXESzI=;
 b=MVGN3ECEYlecnS4v98g0wHX6UYZ1YeZEanrcxAY80V/pwZuwxVS2rFWDs1sa0ZSV07VNoqD5LgYHLF0SQYhdy6K+C4OmZBfRRP8VoPkA6WBifjI7n7VvEY/l+EhJPCcHwERELSciSXG2Mk0Q9GPBbOqSQg6IMxml4pZZC0CTP8E=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3413.namprd13.prod.outlook.com (2603:10b6:610:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.14; Mon, 21 Jun
 2021 19:35:26 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05%4]) with mapi id 15.20.4264.017; Mon, 21 Jun 2021
 19:35:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH] nfsd: Reduce contention for the nfsd_file nf_rwsem
Thread-Topic: [PATCH] nfsd: Reduce contention for the nfsd_file nf_rwsem
Thread-Index: AQHXY9BFOPrj5d3Km06dLrDzFdiFU6sesysAgAATu4CAAAe0gIAACvSAgAAH+4A=
Date:   Mon, 21 Jun 2021 19:35:26 +0000
Message-ID: <c8c85d73c334653269d09b41e454587deb6c8160.camel@hammerspace.com>
References: <20210617232652.264884-1-trondmy@kernel.org>
         <1669C849-D7DC-46C1-B6B6-F2C79C819710@oracle.com>
         <ff7400e35ec0b227de4546c608d231caed921d5b.camel@hammerspace.com>
         <F48D54BC-24F6-4E92-9C1E-773E5C5E29DA@oracle.com>
         <b49ec15528377bfa2f4707610440e9da73ea7456.camel@hammerspace.com>
In-Reply-To: <b49ec15528377bfa2f4707610440e9da73ea7456.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 241c32de-b0fe-44b0-ede4-08d934ebb89b
x-ms-traffictypediagnostic: CH2PR13MB3413:
x-microsoft-antispam-prvs: <CH2PR13MB3413BDEBCFA8B8DF7D5EAC55B80A9@CH2PR13MB3413.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ocorYVGtzrXH2eqWo05kQ4/nx6ak13azjJFGPO92Lqaithh0oatM1RH0aK10aS7F+6844z4GGXC2MHYBoh1+EwdJ3HpCETKFCIRSKjslEXrnh++DtxPJ62T2ShOKrppxNjr+lifdcCNc6McBuAg4MvOzeocop7zU5Vn4a5WvyUmtIFTcNabxtLHjz3FLIGEWIwxS8dndQrGCfNpZcSNtA8UDnXKNg+iBvo4kfx4hg/wiC+NuPC2ic7yag1y1dK3SsJiAoI2VVJGwdWkAueikC8u3NHDP2w7rMVnUl2XkHsYJa8HcZiQJV0nFVpQ73kDWyaLu6CQo4suUuOyT4czXFZmkS146O3XTyXVVuXxHEBt6/xFHBMpu+W4+8vMTvO/S9jjjh3GSjbPwjxslgbf9kzuVsiuxWatxkBrhYXPypTdCOFw6/5nyEQ7Bb54gFsciI9m7dGIs7IEG91HJJSzSiqlo4N0HVuX+0PYEtR56DZg8a1xjfuT6rCWMk8pzTmx60LUiqa2tzCpI5bi9aSRwl3lKmMVgBtRoLAy1kBTGbfzpNdXGNopG3szfdz/jmtZJJaaXMwZM/tndxP5vrtKb3KOtVxvFMdPey9/Srfi4jDSony9p9zHBHQR77F67pZdknD+MIa5L9eHZIA+OXq0ftA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(136003)(39830400003)(366004)(6486002)(2616005)(86362001)(6506007)(71200400001)(36756003)(4326008)(6916009)(478600001)(5660300002)(2906002)(54906003)(53546011)(83380400001)(6512007)(26005)(8676002)(8936002)(38100700002)(186003)(76116006)(64756008)(66476007)(122000001)(316002)(66946007)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3ROUmZIVVB0NjgyZUVrZmJzaTk0NWV5Z01JcFVEdDY5d2NZc1ZsNGhqREZa?=
 =?utf-8?B?TFBHeTdEbGtUaW9WekVrMHJBaml0NXZaSXBzRk1ENjJ0MUZxV3NzMXZmcFo3?=
 =?utf-8?B?cldEb2tsQkhqbWdkVEVhaHZIcVZkT2I5VnNGaDNHY2VWbGh1VWRscnZHSE8w?=
 =?utf-8?B?c1hIYWNVejRhRzZtbENWQmpRN2VRODVVcjVvNE1ZY0dxdkJ3dFQ4RGtXRGsx?=
 =?utf-8?B?NXY4RzZDQ2hqWWpyYmdHQVZnT0NDZjRQU2VDMkxCVWg0UmU1WWwwVU1MRUQ2?=
 =?utf-8?B?UmpYR2xTNE1ZY2VlWU5tM2hISWRwWXRicFo5VXVJclBIRGVjV0J0eE9nWk45?=
 =?utf-8?B?MGVVVmNXd1F4eUZ4VCt2alZjeFAxY3dBLzRkS3Z1S204cklPYVdRMHRka29w?=
 =?utf-8?B?RzI4cWxyRVRaRGUzc1kzbTEzdElPMUptZ3hReTd4OUluWEE0RXk5Zm1nWkJI?=
 =?utf-8?B?eXRaZ01SOHk0RFU1V1ZVTm1pdmtXZlkxWlZRcTM4TVA1eFhnMmRQazNHMCs4?=
 =?utf-8?B?SUNHUGcrbVpqK3lVZk5QNkEwQ0x3RnpYcnR0YWx6dkRpNzZnemZQNjMwM3dm?=
 =?utf-8?B?MlI2akZRZ2J6MmR3UW84MWNJellmMERPUitxZi9qM0RTcFNwWm5zQnh3bmF3?=
 =?utf-8?B?UUZuaGZKek5ydE4zWWpsRVM5MlQ0Wmo1OXRjVytZQmErd2tqSWtQZkRxVFE0?=
 =?utf-8?B?LzAxWmlWV1VKKzk3b2YvUjdrRDVDaTR1bHNtdTJCaklYeXQ1MFAwTTEyMis4?=
 =?utf-8?B?bmgwUHg0dlpUWFArSGJveEpobm9hNCtzS01GV1hXMHUzZENtRmpiQmJLeVdX?=
 =?utf-8?B?aStBZjZVdGl2MnpmVkVzbU5xdHdWQ0ZDMjZjdlA2OFV0dDJiVEtQbnBtczJG?=
 =?utf-8?B?UUVrbEw0Mjd1Ny9rcTRnMGM2emNxZHNDcXFDbDJPdWZsVGtwVTBkWmRyZmdn?=
 =?utf-8?B?UzNTeDAxSVc4SjBoL1pvVittT0tGVWpwVFNIb0pPK0w5bVRjNE5DZks0bld1?=
 =?utf-8?B?dlczSDAxeWJjUHJOdDlKNVFlSHIvS25sZGpROXJCOGYzamE0NFNyV2lBY0RB?=
 =?utf-8?B?YWN0VDlVbVVrY2g1aHVST2RCVHVwYWlmeWo5UFdZZ3laWDFHNW00L3d1SHJh?=
 =?utf-8?B?Y1lVYWx1NzlLcUlsZW40Y015cGtLWm80Nkg2QkZuaU9vT0xDNFkwNFhFN05R?=
 =?utf-8?B?dGlBaXhocTlTVDc1RW8yQlJaa0tRZEx1am5oY2pzK1VNdWFDektIQzRBN08y?=
 =?utf-8?B?ZUxwVkJpZzlZQWcwRkQ4QWhzSjJuWXNlN2pQVGZ3Z3ZTOXZxRzE3V2FIWm8x?=
 =?utf-8?B?Y1l1S3prbTZHS3BvUlE5NldGZ043aFd1VTdxSFBNYmNESGNUZU50NGt4T08z?=
 =?utf-8?B?ZXhTeUpOb3pCUFV4eVd3dlZHdCtlbGpRSlBMdStyS1poR2FzTk5iajFOU1N5?=
 =?utf-8?B?eXpsbEFDQmloZzM5R2ZMNFNpRmVpLzQrR2RTcFZlSjREQldNZXNxb1d2NC95?=
 =?utf-8?B?NWUvNDNTcHIwV3duV0VaT0I2S2VoRUt4a1EyVDgyZk9PTnViWllPdjBTMlA0?=
 =?utf-8?B?VXZ6Ym1RdG9sZ1dFT01SUHZkM00xa0tvWFE3VkwxZE4reTAwZGhvcjlkeU95?=
 =?utf-8?B?K3IxUkM0dmdDNHBhNUdSWnFJSFMzZUdzd2ZBQ3cwTzlGL1QwSXNCNmtJQzFB?=
 =?utf-8?B?SzZXWVFZSXN2b0NCczV3NWhoT0FnbFdUR2h0WlpKZTNhOWtoTUMrc2xwZlVS?=
 =?utf-8?Q?F3gUHIGnjeAw8CGwlSI8zWyF1B+hMZZqhU+7nK6?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <960024EC84ED1343BB221694A148F1DF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241c32de-b0fe-44b0-ede4-08d934ebb89b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 19:35:26.7935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3rAQgF/MdQpMri/lesnEnD6hFyrfkmCCLCPAnwLGooOOUFH+bOflI134m2T4mAP4iW8MMFXcyhS4sNx3C5aoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3413
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTIxIGF0IDE1OjA2IC0wNDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIE1vbiwgMjAyMS0wNi0yMSBhdCAxODoyNyArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdy
b3RlOg0KPiA+IA0KPiA+IA0KPiA+ID4gT24gSnVuIDIxLCAyMDIxLCBhdCAyOjAwIFBNLCBUcm9u
ZCBNeWtsZWJ1c3QNCj4gPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4g
PiANCj4gPiA+IE9uIE1vbiwgMjAyMS0wNi0yMSBhdCAxNjo0OSArMDAwMCwgQ2h1Y2sgTGV2ZXIg
SUlJIHdyb3RlOg0KPiA+ID4gPiBIaS0NCj4gPiA+ID4gDQo+ID4gPiA+ID4gT24gSnVuIDE3LCAy
MDIxLCBhdCA3OjI2IFBNLCB0cm9uZG15QGtlcm5lbC5vcmfCoHdyb3RlOg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbT4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBXaGVuIGZsdXNoaW5nIG91dCB0aGUgdW5z
dGFibGUgZmlsZSB3cml0ZXMgYXMgcGFydCBvZiBhDQo+ID4gPiA+ID4gQ09NTUlUDQo+ID4gPiA+
ID4gY2FsbCwgdHJ5DQo+ID4gPiA+ID4gdG8gcGVyZm9ybSBtb3N0IG9mIG9mIHRoZSBkYXRhIHdy
aXRlcyBhbmQgd2FpdHMgb3V0c2lkZSB0aGUNCj4gPiA+ID4gPiBzZW1hcGhvcmUuDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gVGhpcyBtZWFucyB0aGF0IGlmIHRoZSBjbGllbnQgaXMgc2VuZGluZyB0
aGUgQ09NTUlUIGFzIHBhcnQNCj4gPiA+ID4gPiBvZg0KPiA+ID4gPiA+IGENCj4gPiA+ID4gPiBt
ZW1vcnkNCj4gPiA+ID4gPiByZWNsYWltIG9wZXJhdGlvbiwgdGhlbiBpdCBjYW4gY29udGludWUg
cGVyZm9ybWluZyBJL08sIHdpdGgNCj4gPiA+ID4gPiBjb250ZW50aW9uDQo+ID4gPiA+ID4gZm9y
IHRoZSBsb2NrIG9jY3VycmluZyBvbmx5IG9uY2UgdGhlIGRhdGEgc3luYyBpcyBmaW5pc2hlZC4N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBGaXhlczogNTAxMWFmNGM2OThhICgibmZzZDogRml4IHN0
YWJsZSB3cml0ZXMiKQ0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdA0K
PiA+ID4gPiA+IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+ID4gPiANCj4g
PiA+ID4gVGhlIGdvb2QgbmV3cyBpcyBJJ3ZlIGZvdW5kIG5vIGZ1bmN0aW9uYWwgcmVncmVzc2lv
bnMuIFRoZSBiYWQNCj4gPiA+ID4gbmV3cyBpcyBJIGhhdmVuJ3Qgc2VlbiBhbnkgZGlmZmVyZW5j
ZSBpbiBwZXJmb3JtYW5jZS4gSXMgdGhlcmUNCj4gPiA+ID4gYSBwYXJ0aWN1bGFyIHRlc3QgdGhh
dCBJIGNhbiBydW4gdG8gb2JzZXJ2ZSBpbXByb3ZlbWVudD8NCj4gPiA+IA0KPiA+ID4gSSdkIGV4
cGVjdCB0aGF0IHJlLWV4cG9ydGVkIE5GUyB3b3VsZCBiZSB0aGUgYmVzdCB0ZXN0IHNpbmNlDQo+
ID4gPiBmc3luYygpIGlzDQo+ID4gPiBhIGhpZ2ggbGF0ZW5jeSBvcGVyYXRpb24gd2hlbiB0aGUg
cGFnZSBjYWNoZSBpcyBsb2FkZWQuIFlvdSBhbHNvDQo+ID4gPiB3YW50DQo+ID4gPiB0byB1c2Ug
YSBjbGllbnQgd2l0aCByZWxhdGl2ZWx5IGxpbWl0ZWQgbWVtb3J5IHNvIHRoYXQgaXQgd2lsbA0K
PiA+ID4gdHJ5DQo+ID4gPiB0bw0KPiA+ID4gcmVjbGFpbSBtZW1vcnkgYnkgcHVzaGluZyBvdXQg
ZGlydHkgcGFnZXMgYW5kIGRvaW5nIENPTU1JVC4NCj4gPiANCj4gPiBJIHRob3VnaHQgSSB3YXMg
aGl0dGluZyB0aG9zZSBsb3ctbWVtb3J5IGNhc2VzIHdpdGggZGlyZWN0IEkvTw0KPiA+IHRlc3Rp
bmcuIDxzaHJ1Zz4NCj4gDQo+IElmIHlvdSBkbyBPX0RJUkVDVCB3aXRoIDEwME1CIHdyaXRlKCkg
Y2FsbHMsIHRoZW4gbWF5YmUuIElmIHlvdSB1c2UgPA0KPiAxTUIgd3JpdGUoKXMgdGhlbiB5b3Un
bGwgcmFyZWx5IGlmIGV2ZXIgaGl0IGFueSBDT01NSVQgY2FsbHMuDQoNCkxldCBtZSBjb3JyZWN0
IG15c2VsZjogWW91J2QgbmVlZCB0byBkbyBhaW8vZGlvIHdpdGggMTAwTUIgd3JpdGUgc3lzdGVt
DQpjYWxscyBzbyB0aGF0IHRoZSBmbHVzaCBwYXJ0IG9mIHRoZSBDT01NSVQgb3BlcmF0aW9uIHRh
a2VzIHNpZ25pZmljYW50DQp0aW1lIG9uIHRoZSBzZXJ2ZXIsIGFuZCBjYW4gaW50ZXJmZXJlIHdp
dGggb3RoZXIgQ09NTUlUIG9wZXJhdGlvbnMuDQoNCj4gDQo+ID4gDQo+ID4gDQo+ID4gPiA+IEkg
d29uZGVyIGFib3V0IGFkZGluZyBhIEZpeGVzOiB0YWcgZm9yIGEgY2hhbmdlIHRoYXQgdGhlIHBh
dGNoDQo+ID4gPiA+IGRlc2NyaXB0aW9uIGRlc2NyaWJlcyBhcyBhbiBvcHRpbWl6YXRpb24uDQo+
ID4gPiANCj4gPiA+IEkndmUgb2NjYXNpb25hbGx5IGhpdCBPT00gc2l0dWF0aW9ucyBpbiB0aGUg
cmUtZXhwb3J0IGNhc2Ugd2hlbg0KPiA+ID4gdGhlDQo+ID4gPiByL3cNCj4gPiA+IGxvY2sgY29u
dGVudGlvbiBjYXVzZXMgc29mdGVyciBmYWlsdXJlIHRvIGJlIHNlcmlhbGlzZWQuDQo+ID4gPiBp
LmUuIGlmIHRoZSBzZXJ2ZXIgaXMgZG93biwgYW5kIHlvdSdyZSBlc3NlbnRpYWxseSBob3Bpbmcg
dGhhdA0KPiA+ID4gdGhlDQo+ID4gPiBuZnNkDQo+ID4gPiB0aHJlYWRzIHdpbGwgZ2l2ZSB1cCBh
bmQgcmV0dXJuIEVKVUtFQk9YL05GUzRFUlJfREVMQVkgdG8gdGhlDQo+ID4gPiBjbGllbnQsDQo+
ID4gPiB0aGVuIHRoYXQgbG9jayBlbnN1cmVzIHRoYXQgdGhyZWFkcyBmYWlsIG9uZS1ieS1vbmUg
KGdyYWIgbG9jaywNCj4gPiA+IHdyaXRlLA0KPiA+ID4gdGltZW91dCwgcmVsZWFzZSBsb2NrKSBp
bnN0ZWFkIG9mIGJlaW5nIGFibGUgdG8gYWxsIGZhaWwgYXQgb25jZQ0KPiA+ID4gKHdyaXRlLCB0
aW1lb3V0KS4NCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gLS0tDQo+ID4g
PiA+ID4gZnMvbmZzZC92ZnMuYyB8IDE4ICsrKysrKysrKysrKysrKystLQ0KPiA+ID4gPiA+IDEg
ZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnNkL3Zmcy5jIGIvZnMvbmZzZC92ZnMuYw0K
PiA+ID4gPiA+IGluZGV4IDE1YWRmMWY2YWIyMS4uNDY0ODVjMDQ3NDBkIDEwMDY0NA0KPiA+ID4g
PiA+IC0tLSBhL2ZzL25mc2QvdmZzLmMNCj4gPiA+ID4gPiArKysgYi9mcy9uZnNkL3Zmcy5jDQo+
ID4gPiA+ID4gQEAgLTExMjMsNiArMTEyMywxOSBAQCBuZnNkX3dyaXRlKHN0cnVjdCBzdmNfcnFz
dCAqcnFzdHAsDQo+ID4gPiA+ID4gc3RydWN0DQo+ID4gPiA+ID4gc3ZjX2ZoICpmaHAsIGxvZmZf
dCBvZmZzZXQsDQo+ID4gPiA+ID4gfQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ICNpZmRlZiBDT05G
SUdfTkZTRF9WMw0KPiA+ID4gPiA+ICtzdGF0aWMgaW50DQo+ID4gPiA+ID4gK25mc2RfZmlsZW1h
cF93cml0ZV9hbmRfd2FpdF9yYW5nZShzdHJ1Y3QgbmZzZF9maWxlICpuZiwNCj4gPiA+ID4gPiBs
b2ZmX3QNCj4gPiA+ID4gPiBvZmZzZXQsDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbG9mZl90IGVuZCkN
Cj4gPiA+ID4gPiArew0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IGFkZHJlc3Nfc3Bh
Y2UgKm1hcHBpbmcgPSBuZi0+bmZfZmlsZS0NCj4gPiA+ID4gPiA+Zl9tYXBwaW5nOw0KPiA+ID4g
PiA+ICvCoMKgwqDCoMKgwqAgaW50IHJldCA9IGZpbGVtYXBfZmRhdGF3cml0ZV9yYW5nZShtYXBw
aW5nLCBvZmZzZXQsDQo+ID4gPiA+ID4gZW5kKTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gK8Kg
wqDCoMKgwqDCoCBpZiAocmV0KQ0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiByZXQ7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBmaWxlbWFwX2ZkYXRhd2Fp
dF9yYW5nZV9rZWVwX2Vycm9ycyhtYXBwaW5nLCBvZmZzZXQsDQo+ID4gPiA+ID4gZW5kKTsNCj4g
PiA+ID4gPiArwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiA+ID4gPiA+ICt9DQo+ID4gPiA+ID4g
Kw0KPiA+ID4gPiA+IC8qDQo+ID4gPiA+ID4gwqAqIENvbW1pdCBhbGwgcGVuZGluZyB3cml0ZXMg
dG8gc3RhYmxlIHN0b3JhZ2UuDQo+ID4gPiA+ID4gwqAqDQo+ID4gPiA+ID4gQEAgLTExNTMsMTAg
KzExNjYsMTEgQEAgbmZzZF9jb21taXQoc3RydWN0IHN2Y19ycXN0ICpycXN0cCwNCj4gPiA+ID4g
PiBzdHJ1Y3QNCj4gPiA+ID4gPiBzdmNfZmggKmZocCwNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oCBpZiAoZXJyKQ0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3Rv
IG91dDsNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBpZiAoRVhfSVNTWU5DKGZocC0+ZmhfZXhw
b3J0KSkgew0KPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCBlcnIy
Ow0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCBlcnIyID0NCj4g
PiA+ID4gPiBuZnNkX2ZpbGVtYXBfd3JpdGVfYW5kX3dhaXRfcmFuZ2UobmYsDQo+ID4gPiA+ID4g
b2Zmc2V0LCBlbmQpOw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBkb3duX3dyaXRlKCZuZi0+bmZfcndzZW0pOw0KPiA+ID4gPiA+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycjIgPSB2ZnNfZnN5bmNfcmFuZ2UobmYtPm5mX2ZpbGUs
IG9mZnNldCwNCj4gPiA+ID4gPiBlbmQsDQo+ID4gPiA+ID4gMCk7DQo+ID4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFlcnIyKQ0KPiA+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnIyID0gdmZzX2ZzeW5jX3Jhbmdl
KG5mLT5uZl9maWxlLA0KPiA+ID4gPiA+IG9mZnNldCwNCj4gPiA+ID4gPiBlbmQsIDApOw0KPiA+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzd2l0Y2ggKGVycjIpIHsNCj4g
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSAwOg0KPiA+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzZF9jb3B5
X2Jvb3RfdmVyaWZpZXIodmVyZiwNCj4gPiA+ID4gPiBuZXRfZ2VuZXJpYyhuZi0+bmZfbmV0LA0K
PiA+ID4gPiA+IC0tIA0KPiA+ID4gPiA+IDIuMzEuMQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4g
PiA+ID4gLS0NCj4gPiA+ID4gQ2h1Y2sgTGV2ZXINCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4g
PiANCj4gPiA+IA0KPiA+ID4gLS0gDQo+ID4gPiBUcm9uZCBNeWtsZWJ1c3QNCj4gPiA+IExpbnV4
IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCj4gPiA+IHRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20NCj4gPiANCj4gPiAtLQ0KPiA+IENodWNrIExldmVyDQo+ID4gDQo+
ID4gDQo+ID4gDQo+IA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBt
YWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0K
DQoNCg==
