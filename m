Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084393A2EB6
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhFJO56 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 10:57:58 -0400
Received: from mail-bn8nam12on2102.outbound.protection.outlook.com ([40.107.237.102]:9953
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230298AbhFJO55 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 10 Jun 2021 10:57:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaZM1thK81HHj2Nj5MkZNJ0SDlPRUA+ebF7VOCPGKTVjMd9uCia5+HGqkFZ/6g2wxN2SDmxO2BLxRtmlyOOhTIUs5l0sJEfyFdZPz7J2EVW7pIdSO0xcBw/VNLr4vUrAbyDnxsLbWmiobb6BxpDOQ6j0YMsXNQDSiGCnYFw45W/5sXZquOR/ljQySHICJ+gZ7z0GiICxrRz6SwQqUbGms5x89ZUVGxGDUvgrQ9V/STfZEObNnKSbKH4iEBoXowX1uaiqpmYYIFPZwcsTeKX6fRkufwa1+1jkBgl5nagBRzEkk6YcTxEWffxHKCOBomQU1tApmTlGmlxTvfhgTAuikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxYxGOKJ3bYJ7V+YGCVSofMAeNucj1yHLdAMCFrN4nc=;
 b=W5ls0UagSz5/jIdYKeEhN5DReMyCOOVSu1yimb3ScywnotuSdP+N8TfLn86R7RKqseAm3iZY5hSpE9ftC9Eu/Fe278BPy99ASYuUSJloV8NmO9evhT3WgRkh2VLyT0jI5KTY3a33okcLzCWwXKWGQN7DfWDqMMoRySvfcwIpnXH4iOysqX5ABsngID1L7gyg1ubwg5c9pXgRLDA9bLQ4T69Ft9+QRg/CJnIQBc3UuroqGC6FAoCMGUpK1egpbc/o9DnsIHoQs6OXqK0wTZGj00wQBoK+98zyt90X3FX2G7ERH8mX0IKNkC7ornMgv+wEwkyN+17y/f/ZnXYYaCGNnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxYxGOKJ3bYJ7V+YGCVSofMAeNucj1yHLdAMCFrN4nc=;
 b=Nwr1JcgTHlmDg45KSFDXt3J5OsYmRkuuzK+0svg/fL1FEUH0sa+O5Ey4KHaGVJahcWzP1Hje9130hN7SnVdudoVbS12r5MXnjyEUiI0+Ra6wHxymivmO85MCVoOEsn2VXR3ipYiGbqyoi8cRrqbX8/6cQQmBAs03aIHzRKyng0s=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB2426.namprd13.prod.outlook.com (2603:10b6:5:c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.12; Thu, 10 Jun
 2021 14:55:59 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4242.012; Thu, 10 Jun 2021
 14:55:59 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Topic: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Index: AQHXXXnh3WIMdJRfJ0KF+q50bEsARasNPoYAgAABKgCAAAY7AIAABLOAgAAFEgCAAAbMgA==
Date:   Thu, 10 Jun 2021 14:55:58 +0000
Message-ID: <c7a7a04adbe261d5ca104780c290a44ede1ed4c2.camel@hammerspace.com>
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
         <20210609215319.5518-3-olga.kornievskaia@gmail.com>
         <6C64456A-931F-4CAD-A559-412A12F0F741@oracle.com>
         <6bca80de292b5aa36734e7d942d0e9f53430903b.camel@hammerspace.com>
         <83D9342E-FDAF-4B2C-A518-20BF0A9AD073@oracle.com>
         <3658c226b43fb190de38c00e5199ccf35ccc4369.camel@hammerspace.com>
         <CAN-5tyF3BSDvsegLWM6hAOY9QDMbG1LUg9YykXi8rwDcNVXqbA@mail.gmail.com>
In-Reply-To: <CAN-5tyF3BSDvsegLWM6hAOY9QDMbG1LUg9YykXi8rwDcNVXqbA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93610dbd-12bc-461c-2ca8-08d92c1fdbad
x-ms-traffictypediagnostic: DM6PR13MB2426:
x-microsoft-antispam-prvs: <DM6PR13MB2426C68B113AE38394605FD9B8359@DM6PR13MB2426.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ca74Sjaw633B1lM/IkBBMMjv1bWGytLCOR20w70foilqEgxIC0CFE3DUrjRrsrRJ1b630MNwQTYes8/2NNbHBdNpGWMwDXPQLxUpfMqe0xmjVuzJpQcDmdPYXawfMAQUtKuAfgRkedam46ggXE9YEPUJVgTvzC2WctLL73DeS5vRcWHOhhfnTtTGgSD8Uxr0vH/kfSTVWojBPU+Lgc12nsC3dMi6kvHZh45CooehxsF2UZHSGhrd+g8nO1fD5Ac2Xsh+riixQBnK+jR+iKKqR5aLx1u4z2LZcyKjGpIcmgh9j8Aw2ZmKBLoUGkf0mmkRY8Jr2kj+V9dvEa//z0cAMOJytsyQBHegHZJ3Ks0leoeHiIvU2oIa/wjAgAJag5hMN1XVbWwLMKXZVRfzWlS1agS3qIHDbZfri0fyQ2NrWB8JtjD3ObXeHJud9/gz+ERg6jchPbI4j85Y7YX0UWvw8kldsx1zY3wQ6MjXlB3IxGjvai9lx5m4ZBbL0/QD4OqJgrZOLyKTH6wfal79OLl2gUjZly5R1+/W+29lUD23g3qIcNvlyFJ7OUmFnXNIvCyk+g85w1/fzIx3wD0i+5nCUHN+0FfRFfGy9oPqH94ynY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(396003)(136003)(39830400003)(4326008)(8936002)(66946007)(91956017)(8676002)(316002)(6916009)(2616005)(6486002)(2906002)(26005)(36756003)(122000001)(186003)(6506007)(53546011)(54906003)(38100700002)(6512007)(5660300002)(86362001)(478600001)(83380400001)(64756008)(66556008)(76116006)(66446008)(66476007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eThaVkJ6QmJJWmV3WmNybWo1aktBbjhrbU5QSGh6NEc1aSsyeEpvZi90Qk56?=
 =?utf-8?B?RmhMZ2ZBV1Nkdm9DRHRlVWtDbFFjWWZaeUxJV1RLdDVQemY1TzFXclczSHZw?=
 =?utf-8?B?L3ZyL3ZhR29kazdpWUJDMDVsZmVyYVh4U3FTT3dON2ExUkZ6clNIUmNWeW5v?=
 =?utf-8?B?VDN5WWhBVHVUYzBtdEJsNjlEYXNhaU00bXJhSWhBekMwNE53N0E4MVJmRysz?=
 =?utf-8?B?aDkvRk54SFl5azhPemk2UjB5eXRZSWpjUXdBSmpvZzRCSGxuRDNtQktkS1pL?=
 =?utf-8?B?ME5wWHNLRDMwOE9CeGRMUExkV2xBZ1JLOFFLbnorWWd1NTVSb2JlOW1yM1Rr?=
 =?utf-8?B?QnEyVFN1RlVpNnhSNCswQ0wxT1JrT3g4R3NoRlp0Q2c0TTdBYkpNa3dEZlJh?=
 =?utf-8?B?cWVCelRsd3pGTTJnTmZFelIzQ0JNM3M1QW1qQnl5MWR3enpxWmFheFliajBm?=
 =?utf-8?B?ckF1TTJ6YWU2Wk5qdnY1REVKMmpScG1aM1VwSDRKWWJvVjdSNXlCZU5nbVhp?=
 =?utf-8?B?R0YzV3ZxNG5GcHdEcXowckNIblVud0E0eDVscjFJMFdvZFprdkMvZGx3eXh5?=
 =?utf-8?B?QmNIQ2FabUdYblBRTWxSRmZTYlpsZytkUnlNTElmY2lucnkvdWp4cHVkTXRS?=
 =?utf-8?B?TnZFZDBLZ0liN2dDeHZNU0hHRlZ0YnhwaEZTaEpvbjdYNkkveFdnMWZROFRv?=
 =?utf-8?B?c3RjTSttdWJPdm0yU1ZCSFUzcUNPWTkwYlVoZTlHR0dkVXc2MllPcjRiTDI2?=
 =?utf-8?B?MUxXVDM5L0l0SitHb0JsTXJjVWpQbWJ3b2tYcWFEcUtQUVA5TUVjeVR3OEJK?=
 =?utf-8?B?MUxyZ1ZwcXhxN3lwV3FXcE5sMEErbWNOeFJRRGNzT2pVM0s5Wm00OXVBSXlq?=
 =?utf-8?B?V2hzQnZmT2NjMnJRUzc1VXdZRy91eHNBbUJyRDJuZWRVRG5FMTlYd0JmdGRU?=
 =?utf-8?B?dEpndkJUZ2VsbmhlRmh2MUtRRGxmdngrWThEclh0TmFDZFM2OWhOYTlNSUJE?=
 =?utf-8?B?andMYmlSeDRHSjROc2JhUmY1Q0x4SVlhbUp0M3RJY1NYanZBd25ZajBQa2E1?=
 =?utf-8?B?dkx0dlRLampycU9mZW4wUm5IZFdHMy9leTVWL3dRazBaNDlRV1cwcTgrTDli?=
 =?utf-8?B?NmVRKzBzTXh1eGZkTTFNSExWVjV1Z1dBcmYzQkZHVytSc283ZzJBQ3lmd2VK?=
 =?utf-8?B?VndSb0VnUWR2a0FZb0pRQVpBVm5sM3VLdGZDamw2RnIwSkI3ZXZGY3cwc0dh?=
 =?utf-8?B?TnpEd2p3Y1lBeGhWZzZtYm9JMDZLZXFOSzNCaVZsYmozbjJDRzlyTWw0bzhJ?=
 =?utf-8?B?b3g1dFlHWktEU24wYnZ1QlFlSU93R24vUVFTaWVYQkI3WmN0S3FsemtwZURz?=
 =?utf-8?B?bDhvR0xzYjhib1hJNjkySWFCSVdybkdCUlhEWVdJWFJBY2xYNk1oSXlaSEtK?=
 =?utf-8?B?RHV5OEE1MHdJeStqRDRxNmlra2FlY0pSOUd2MnN0bDRxT0NBM0Jlby9XT2N2?=
 =?utf-8?B?ak9yUktqb3daYzF6N2o1SElpYkd4TlBBb3pMeTVxVGdqeUVvSnRUKzZ6QUZ1?=
 =?utf-8?B?Vi8rdEdwWG5ZdkQ4Zk9WRWJxWmNwWkpoakRjWVowaXFlRFF6RDJiTzl3L0Q3?=
 =?utf-8?B?SmwzMng3eGxpQ0lmMU94ZlV4bGVzbUU5QThPazZDWElwVWFhUFJCdWdrdWE1?=
 =?utf-8?B?MEhYNlVLRENaUHdMMGNQR0NOUFNiWUJLdGw4ZmRNY3BCWFBOZkdPKzYvQlpN?=
 =?utf-8?Q?v4Q+35Vkw9v+wFVQsewWIp5qzt0FZ98b1FLWvS8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1538B6ED58FC44F9B36831198390191@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93610dbd-12bc-461c-2ca8-08d92c1fdbad
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 14:55:58.9300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLHlsKHrAeNXdDo7dk2Minf+Jy6UuaNs1bKZ2kytL71Yn478UeofPYAK+97R9ClqcrxOVZjP/8ra8seNkzzTqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2426
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTA2LTEwIGF0IDEwOjMxIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVGh1LCBKdW4gMTAsIDIwMjEgYXQgMTA6MTMgQU0gVHJvbmQgTXlrbGVidXN0DQo+
IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1LCAyMDIx
LTA2LTEwIGF0IDEzOjU2ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4gPiANCj4g
PiA+IA0KPiA+ID4gPiBPbiBKdW4gMTAsIDIwMjEsIGF0IDk6MzQgQU0sIFRyb25kIE15a2xlYnVz
dCA8DQo+ID4gPiA+IHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+ID4gDQo+
ID4gPiA+IE9uIFRodSwgMjAyMS0wNi0xMCBhdCAxMzozMCArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJ
IHdyb3RlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT24gSnVuIDksIDIw
MjEsIGF0IDU6NTMgUE0sIE9sZ2EgS29ybmlldnNrYWlhIDwNCj4gPiA+ID4gPiA+IG9sZ2Eua29y
bmlldnNrYWlhQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEZy
b206IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBUaGlzIG9wdGlvbiB3aWxsIGNvbnRyb2wgdXAgdG8gaG93IG1hbnkgeHBydHMg
Y2FuIHRoZQ0KPiA+ID4gPiA+ID4gY2xpZW50DQo+ID4gPiA+ID4gPiBlc3RhYmxpc2ggdG8gdGhl
IHNlcnZlci4gVGhpcyBwYXRjaCBwYXJzZXMgdGhlIHZhbHVlIGFuZA0KPiA+ID4gPiA+ID4gc2V0
cw0KPiA+ID4gPiA+ID4gdXAgc3RydWN0dXJlcyB0aGF0IGtlZXAgdHJhY2sgb2YgbWF4X2Nvbm5l
Y3QuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29ybmll
dnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiBm
cy9uZnMvY2xpZW50LmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+ID4gPiA+ID4gPiBm
cy9uZnMvZnNfY29udGV4dC5jwqDCoMKgwqDCoMKgIHzCoCA4ICsrKysrKysrDQo+ID4gPiA+ID4g
PiBmcy9uZnMvaW50ZXJuYWwuaMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKysNCj4gPiA+ID4gPiA+
IGZzL25mcy9uZnM0Y2xpZW50LmPCoMKgwqDCoMKgwqAgfCAxMiArKysrKysrKysrLS0NCj4gPiA+
ID4gPiA+IGZzL25mcy9zdXBlci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArKw0KPiA+
ID4gPiA+ID4gaW5jbHVkZS9saW51eC9uZnNfZnNfc2IuaCB8wqAgMSArDQo+ID4gPiA+ID4gPiA2
IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvY2xpZW50LmMgYi9mcy9uZnMv
Y2xpZW50LmMNCj4gPiA+ID4gPiA+IGluZGV4IDMzMGY2NTcyN2M0NS4uNDg2ZGVjNTk5NzJiIDEw
MDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZnMvbmZzL2NsaWVudC5jDQo+ID4gPiA+ID4gPiArKysg
Yi9mcy9uZnMvY2xpZW50LmMNCj4gPiA+ID4gPiA+IEBAIC0xNzksNiArMTc5LDcgQEAgc3RydWN0
IG5mc19jbGllbnQNCj4gPiA+ID4gPiA+ICpuZnNfYWxsb2NfY2xpZW50KGNvbnN0DQo+ID4gPiA+
ID4gPiBzdHJ1Y3QgbmZzX2NsaWVudF9pbml0ZGF0YSAqY2xfaW5pdCkNCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgY2xwLT5jbF9wcm90byA9IGNsX2luaXQtPnByb3Rv
Ow0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgY2xwLT5jbF9uY29ubmVjdCA9IGNsX2luaXQt
Pm5jb25uZWN0Ow0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBjbHAtPmNsX21heF9jb25uZWN0
ID0gY2xfaW5pdC0+bWF4X2Nvbm5lY3QgPw0KPiA+ID4gPiA+ID4gY2xfaW5pdC0NCj4gPiA+ID4g
PiA+ID4gbWF4X2Nvbm5lY3QgOiAxOw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNvLCAxIGlzIHRo
ZSBkZWZhdWx0IHNldHRpbmcsIG1lYW5pbmcgdGhlICJhZGQgYW5vdGhlcg0KPiA+ID4gPiA+IHRy
YW5zcG9ydCINCj4gPiA+ID4gPiBmYWNpbGl0eSBpcyBkaXNhYmxlZCBieSBkZWZhdWx0LiBXb3Vs
ZCBpdCBiZSBsZXNzIHN1cnByaXNpbmcNCj4gPiA+ID4gPiBmb3INCj4gPiA+ID4gPiBhbiBhZG1p
biB0byBhbGxvdyBzb21lIGV4dHJhIGNvbm5lY3Rpb25zIGJ5IGRlZmF1bHQ/DQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBjbHAtPmNsX25ldCA9IGdl
dF9uZXQoY2xfaW5pdC0+bmV0KTsNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgwqAgY2xwLT5jbF9wcmluY2lwYWwgPSAiKiI7DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
ZnMvbmZzL2ZzX2NvbnRleHQuYyBiL2ZzL25mcy9mc19jb250ZXh0LmMNCj4gPiA+ID4gPiA+IGlu
ZGV4IGQ5NWM5YTM5YmM3MC4uY2ZiZmY3MDk4ZjhlIDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEv
ZnMvbmZzL2ZzX2NvbnRleHQuYw0KPiA+ID4gPiA+ID4gKysrIGIvZnMvbmZzL2ZzX2NvbnRleHQu
Yw0KPiA+ID4gPiA+ID4gQEAgLTI5LDYgKzI5LDcgQEANCj4gPiA+ID4gPiA+ICNlbmRpZg0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAjZGVmaW5lIE5GU19NQVhfQ09OTkVDVElPTlMgMTYNCj4g
PiA+ID4gPiA+ICsjZGVmaW5lIE5GU19NQVhfVFJBTlNQT1JUUyAxMjgNCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBUaGlzIG1heGltdW0gc2VlbXMgZXhjZXNzaXZlLi4uIGFnYWluLCB0aGVyZSBhcmUg
ZGltaW5pc2hpbmcNCj4gPiA+ID4gPiByZXR1cm5zIHRvIGFkZGluZyBtb3JlIGNvbm5lY3Rpb25z
IHRvIHRoZSBzYW1lIHNlcnZlci4gd2hhdCdzDQo+ID4gPiA+ID4gd3Jvbmcgd2l0aCByZS11c2lu
ZyBORlNfTUFYX0NPTk5FQ1RJT05TIGZvciB0aGUgbWF4aW11bT8NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBBcyBhbHdheXMsIEknbSBhIGxpdHRsZSBxdWVhc3kgYWJvdXQgYWRkaW5nIHlldCBhbm90
aGVyIG1vdW50DQo+ID4gPiA+ID4gb3B0aW9uLiBBcmUgdGhlcmUgcmVhbCB1c2UgY2FzZXMgd2hl
cmUgYSB3aG9sZS1jbGllbnQgc2V0dGluZw0KPiA+ID4gPiA+IChsaWtlIGEgc3lzZnMgYXR0cmli
dXRlKSB3b3VsZCBiZSBpbmFkZXF1YXRlPyBJcyB0aGVyZSBhIHdheQ0KPiA+ID4gPiA+IHRoZSBj
bGllbnQgY291bGQgZmlndXJlIG91dCBhIHJlYXNvbmFibGUgbWF4aW11bSB3aXRob3V0IGENCj4g
PiA+ID4gPiBodW1hbiBpbnRlcnZlbnRpb24sIHNheSwgYnkgY291bnRpbmcgdGhlIG51bWJlciBv
ZiBOSUNzIG9uDQo+ID4gPiA+ID4gdGhlIHN5c3RlbT8NCj4gPiA+ID4gDQo+ID4gPiA+IE9oLCBo
ZWxsIG5vISBXZSdyZSBub3QgdHlpbmcgYW55dGhpbmcgdG8gdGhlIG51bWJlciBvZiBOSUNzLi4u
DQo+ID4gPiANCj4gPiA+IFRoYXQncyBhIGJpdCBvZiBhbiBvdmVyLXJlYWN0aW9uLiA6LSkgQSBs
aXR0bGUgbW9yZSBleHBsYW5hdGlvbg0KPiA+ID4gd291bGQgYmUgd2VsY29tZS4gSSBtZWFuLCBk
b24ndCB5b3UgZXhwZWN0IHNvbWVvbmUgdG8gYXNrICJIb3cNCj4gPiA+IGRvIEkgcGljayBhIGdv
b2QgdmFsdWU/IiBhbmQgc29tZW9uZSBtaWdodCByZWFzb25hYmx5IGFuc3dlcg0KPiA+ID4gIldl
bGwsIHN0YXJ0IHdpdGggdGhlIG51bWJlciBvZiBOSUNzIG9uIHlvdXIgY2xpZW50IHRpbWVzIDMi
IG9yDQo+ID4gPiBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiA+ID4gDQo+ID4gPiBJTU8gd2UncmUg
YWJvdXQgdG8gYWRkIGFub3RoZXIgYWRtaW4gc2V0dGluZyB3aXRob3V0DQo+ID4gPiB1bmRlcnN0
YW5kaW5nDQo+ID4gPiBob3cgaXQgd2lsbCBiZSB1c2VkLCBob3cgdG8gc2VsZWN0IGEgZ29vZCBt
YXhpbXVtIHZhbHVlLCBvciBldmVuDQo+ID4gPiB3aGV0aGVyIHRoaXMgbWF4aW11bSBuZWVkcyB0
byBiZSBhZGp1c3RhYmxlLiBJbiBhIHByZXZpb3VzIGUtbWFpbA0KPiA+ID4gT2xnYSBoYXMgYWxy
ZWFkeSBkZW1vbnN0cmF0ZWQgdGhhdCBpdCB3aWxsIGJlIGRpZmZpY3VsdCB0bw0KPiA+ID4gZXhw
bGFpbg0KPiA+ID4gaG93IHRvIHVzZSB0aGlzIHNldHRpbmcgd2l0aCBuY29ubmVjdD0uDQo+ID4g
PiANCj4gPiA+IFRodXMgSSB3b3VsZCBmYXZvciBhIChtb2RlcmF0ZSkgc29sZGVyZWQtaW4gbWF4
aW11bSB0byBzdGFydA0KPiA+ID4gd2l0aCwNCj4gPiA+IGFuZCB0aGVuIGFzIHJlYWwgd29ybGQg
dXNlIGNhc2VzIGFyaXNlLCBjb25zaWRlciBhZGRpbmcgYSB0dW5pbmcNCj4gPiA+IG1lY2hhbmlz
bSBiYXNlZCBvbiBhY3R1YWwgcmVxdWlyZW1lbnRzLg0KPiA+IA0KPiA+IEl0J3Mgbm90IGFuIG92
ZXJyZWFjdGlvbi4gSXQncyBpbnNhbmUgdG8gdGhpbmsgdGhhdCBjb3VudGluZyBOSUNzDQo+ID4g
Z2l2ZXMNCj4gPiB5b3UgYW55IG5vdGlvbiB3aGF0c29ldmVyIGFib3V0IHRoZSBuZXR3b3JrIHRv
cG9sb2d5IGFuZA0KPiA+IGNvbm5lY3Rpdml0eQ0KPiA+IGJldHdlZW4gdGhlIGNsaWVudCBhbmQg
c2VydmVyLiBJdCBkb2Vzbid0IGV2ZW4gdGVsbCB5b3UgaG93IG1hbnkgb2YNCj4gPiB0aG9zZSBO
SUNzIG1pZ2h0IHBvdGVudGlhbGx5IGJlIGF2YWlsYWJsZSB0byB5b3VyIGFwcGxpY2F0aW9uLg0K
PiA+IA0KPiA+IFdlJ3JlIG5vdCBkb2luZyBhbnkgYXV0b21hdGlvbiBiYXNlZCBvbiB0aGF0IGtp
bmQgb2YgbGF5ZXJpbmcNCj4gPiB2aW9sYXRpb24uDQo+IA0KPiBJJ20gbm90IHN1Z2dlc3Rpbmcg
dG8gcHJvZ3JhbW1hdGljYWxseSBkZXRlcm1pbmUgdGhlIG51bWJlciBvZiBOSUMgdG8NCj4gZGV0
ZXJtaW5lIHRoZSB2YWx1ZSBvZiBtYXhfY29ubmVjdC4NCj4gPiANCg0KTm8sIGJ1dCB0aGF0J3Mg
d2hhdCBDaHVjayBhcHBlYXJlZCB0byBiZSBzdWdnZXN0aW5nIGluIG9yZGVyIHRvIGF2b2lkDQp0
aGUgbmVlZCBmb3IgdGhlIG1vdW50IG9wdGlvbi4NCg0KVG8gbWUsIHRoZSBtYWluIHJlYXNvbiBm
b3IgdGhlIG1vdW50IG9wdGlvbiBpcyB0byBhbGxvdyB0aGUgdXNlciB0bw0KbGltaXQgdGhlIG51
bWJlciBvZiBuZXcgSVAgYWRkcmVzc2VzIGJlaW5nIGFkZGVkIHNvIHRoYXQgaWYgdGhlIEROUw0K
c2VydmVyIGlzIGNvbmZpZ3VyZWQgdG8gaGFuZCBvdXQgbG90cyBvZiBkaWZmZXJlbnQgYWRkcmVz
c2VzIGZvciB0aGUNCnNhbWUgc2VydmVybmFtZSwgdGhlIHVzZXIgY2FuIGJhc2ljYWxseSBzYXkg
J25vLCBJIGp1c3Qgd2FudCB0byB1c2UgdGhlDQpvbmUgSVAgYWRkcmVzcyB0aGF0IEknbSBhbHJl
YWR5IGNvbm5lY3RlZCB0bycgKGkuZS4gbWF4X2Nvbm5lY3Q9MSkuIEkNCmNhbiBpbWFnaW5lIHRo
YXQgc29tZSBjbHVzdGVyZWQgc2V0dXBzIG1pZ2h0IG5lZWQgdGhhdCBhYmlsaXR5IGluIG9yZGVy
DQp0byB3b3JrIGVmZmljaWVudGx5Lg0KDQpJJ20gZmluZSB3aXRoIHRoZSBpZGVhIG9mIG5jb25u
ZWN0IHNldHRpbmcgdGhlIG51bWJlciBvZiBjb25uZWN0aW9ucw0KcGVyIElQIGFkZHJlc3MsIGJ1
dCB0aGF0IHdvdWxkIG5lZWQgc29tZSBwbHVtYmluZyBpbg0KcnBjX2NsbnRfdGVzdF9hbmRfYWRk
X3hwcnQoKSB0byBhbGxvdyB1cyB0byBhZGQgdXAgdG8gJ25jb25uZWN0JyBjb3BpZXMNCm9mIGEg
Z2l2ZW4gdHJhbnNwb3J0Lg0KUHJlc3VtYWJseSBycGNfeHBydF9zd2l0Y2hfaGFzX2FkZHIoKSB3
b3VsZCBuZWVkIHRvIHJldHVybiBhIGNvdW50IG9mDQp0aGUgbnVtYmVyIG9mIGNvcGllcyBvZiB0
aGUgdHJhbnNwb3J0IHRoYXQgYXJlIGFscmVhZHkgcHJlc2VudCBzbyB0aGF0DQp3ZSBjYW4gZGVj
aWRlIHdoZXRoZXIgb3Igbm90IHdlIHNob3VsZCBhZGQgYSBuZXcgb25lLg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
