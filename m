Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AB3369BCA
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Apr 2021 23:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244077AbhDWVHV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Apr 2021 17:07:21 -0400
Received: from mail-eopbgr680090.outbound.protection.outlook.com ([40.107.68.90]:20239
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244029AbhDWVHH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 23 Apr 2021 17:07:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gj6ANGXQhS6j5ycfQW2AlbEHLVUQOfnj6aHSRXTXraRZ027gOauA2iru2TDQrFcNmVQkj02UClWDaDaT7u/UupQrPSR86ZSrXfsqvLZwtj8Vk7RMsjm0O8zfzz7m8p+ZynAFPppvkGAIuz58ZBOJPTzkDXN107hd5SR0lji8Kcx+zC/CTGZe1dWAsu/oSjY8ezjIptmaT4NNZrUhhkfGQ/Uk2MQ7HLWhSw4H1z9rHKnu12Ehn5xNrKdpDMgMlOuTTkiwtSBZDXp2hRMItNELQu4sUUx/Rti9Ty7MsbWSGgMgAtjXq3r51onNTC0B3YbVcl1TBbyvCEdZ0UYOUVt4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rknbQUN2ezhCaNdESFjTFBUWIKh1M5nyxx9RQEKLqpw=;
 b=diUiCESUuVIyfbELvxiUUhfJE6W7SeWqDboM/9Uakax3ZtNkyLiMYg1OI4D3UzH8hec6kTZPRW/2LxT6R+ulhkiGkil8jSMx0joveN2uStLJVPSC0ER6xiEQpO2j/3Vln8R3P/JPowBpgQ29iNcIMwxwm+5Vhu1pgO6AZcqb/lpa1BGVpqrhy/Cz5zBBBVrySEQgpv8gauKX17fvJ3upwEwgoe4S5ZP1pQ4I1mnnQKttK6/WJBz+ix8UfCKCVHcMvKPyiQ5tNyJr9DE9lQWQ8oPNPgWC1shdaU6IjNdgjM4h/YR0gF/N7f9A8Wv/bnKxdmz/htbbrf4Y61OK024sew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rknbQUN2ezhCaNdESFjTFBUWIKh1M5nyxx9RQEKLqpw=;
 b=OZZFF50oYGk+ermJf6bo9RNmO7TeYQdJjAF/YbJ83bPVuNux6CqGmVTsEYMELqMpfF+n88xjITa4QsT7QvXodMixncNf0JnQ9/5UW3bFZTUghNCOAs/aBOIvmKQuk9f7cBiNV1vOFVkT1inmmyWu3Wgyi0J4J4h7Sn7il3zDsUs=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB3820.namprd13.prod.outlook.com (2603:10b6:5:245::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.15; Fri, 23 Apr
 2021 21:06:28 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0%4]) with mapi id 15.20.4087.017; Fri, 23 Apr 2021
 21:06:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 07/26] xprtrdma: Improve locking around rpcrdma_rep
 destruction
Thread-Topic: [PATCH v3 07/26] xprtrdma: Improve locking around rpcrdma_rep
 destruction
Thread-Index: AQHXNUYor6w5EFWlLUq08aFp3pnm76rCnoCA
Date:   Fri, 23 Apr 2021 21:06:28 +0000
Message-ID: <89d2e2bbc40d953e28c4e4d56be0b5c83c25dc23.camel@hammerspace.com>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
         <161885534259.38598.17355600080366820390.stgit@manet.1015granger.net>
In-Reply-To: <161885534259.38598.17355600080366820390.stgit@manet.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfa68d13-f19d-4489-7f74-08d9069ba9ae
x-ms-traffictypediagnostic: DM6PR13MB3820:
x-microsoft-antispam-prvs: <DM6PR13MB3820B8B1A9E0E42C3E8BB85EB8459@DM6PR13MB3820.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:167;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eBezE53XEu3xNWgFCXYX0seWR+ayQwhOztIsiJ0FpDMS1T0DWMzkxsfAPgC9dQipfx/IC0c0drCdbUseyyevsmqjsxyph6oAISJD/vGFN8XJnoY7sosHk02a/Bcjps6udPcf03l8HiBkgukwui5v0yYbdgwoRBbiyCxpYeR+GQT/c84QKA4hHgqUGGBDme8lMo29uQloZQDigUEEo+nyW/BEYSiMnVu83D+4Q9VpFu+twIes/z+ILPd/fejEC+xOx6cWLEgR1ABKR/TCsaEwkaALOXv06cXBA5VzW0CwLExGWaT8oNY1T71O9C043B2ZcZ8ummQmlX6Q1YRtbytaEzChdr098BCzRxskGP5WyVwIGNtVEHde8jNHgnfzPVFrqfpN2tokod4deml9IlNyq//gHzUO7nlM6ledfxNVzHIJf7vH9c1NFIJOYcZawqz1WKvasQ0u5+dpyqSmmsq4t6l345GYFXqYK8qywdG1pqj/ElDoc5cn86MNTRYkGuyh/26+MMPdZPSswCtjotKwJRDpejN9a0E6QDYKo55plEnK/OY90ttzNs8Cq8VQT2BSs5toh0YOqpXZbJ8mZsCgXRGLb2ng+BdZez7xWXZe5DA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(346002)(136003)(39840400004)(86362001)(2616005)(8676002)(6916009)(122000001)(76116006)(66446008)(8936002)(478600001)(66556008)(26005)(38100700002)(83380400001)(4326008)(6486002)(66476007)(66946007)(6512007)(64756008)(186003)(91956017)(2906002)(54906003)(316002)(71200400001)(5660300002)(6506007)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RFg0QnJvOFRoVm5qb1ZZYUJ0L2RnOEJGZEU0NzBvN1J3dzZxZng2dHdhK1Fu?=
 =?utf-8?B?MEx5eVA3VG1GMVpGNm84cWJCUnpLOEpGOXduRTZyMXFUVUtVU09MYmNJaE9t?=
 =?utf-8?B?RVN2S0RoM0ZyRWdmZytOTk0weVZXM0V4VkxYRlYwSDJaMUtuUHJRNEVHUXQ4?=
 =?utf-8?B?QUZWLzRaVUNLUXNQYW5RZjB3a082N1p4OTdVcFJtaTRubXRFQXRPNmxjMHZU?=
 =?utf-8?B?WVNLaVhmV1Q1M0NrdkUwVXluNWs5YTZZVTZIQzEraFNuNmdXSGxYY0NmZjdO?=
 =?utf-8?B?QXlrSkpCWE9oMWFOcEVrNms2OGw2Z254QU5UM29aRnRVNGRNUUF6Ny9IaWEw?=
 =?utf-8?B?cE1TcVVjQVdxc04yUHRjaWJldC9JN2hCNG00N20veEsvZllHVmhhMGE2SnZD?=
 =?utf-8?B?VnJtaXlXaHhGNERoR1RPWndaZmRKN3VzcWhjNlY1dU9rSGl1eUhuOGpqak1C?=
 =?utf-8?B?VDVqMFZSS2d2eUlJUnQ2VUpxTFFlOENCbERJMzlRaEc5VTV3RERIQmpvOTRr?=
 =?utf-8?B?ZXBkVEpFYm4vRlRNS1JIWDcxaGxFS05HampEZ2duV2drWVpLSmgyY1U3NlRp?=
 =?utf-8?B?ZjRYZ095MU9rRFA3T3dzOFNub1hnN3NyQzhGaHhEOUlOVEV3aFYybGp6VGgr?=
 =?utf-8?B?UUhiaXFYelcvR1ZKUEFLRnJhQ0ZaV2VjZHFOakhORm1FZjc3bVMvbnpURTdE?=
 =?utf-8?B?UjlwdDNXVXZYZndWS2dQTXZKSU9OenU2cks5UXpqYUtCVEFZcldRNzBxQU1u?=
 =?utf-8?B?QnJkeGVpcDhwZXgwZVdEZ0lFdngxR1dOZnZic1FCanJKZ2lKaXQ0bnc2aUZI?=
 =?utf-8?B?KzlqdGZwT3lwQUkxdDFjYkJqMzlmTHNVUkV3RGZzN3U5ODFlWjlRczdINzZh?=
 =?utf-8?B?UlY5ZnJ2c2puck9vN080RUpjT3hyRHlNNEEvZUxzVjJwMUtXdHRkZTB3MDkr?=
 =?utf-8?B?RzZiRnZOZ0crS2RMdmh5RDNodHE0Q1FzbFBWMlEvdEdVK0c3SzZqS28xRDdK?=
 =?utf-8?B?d0lUcmJmUUFsQk5pczZKYitnVkx5VUxickxMN1lBcnUrQm9ZalJpemRMaU43?=
 =?utf-8?B?M1NPWWhldXhWT0FQN3JRSkVHWWdScXFKZU5aSlhJelBLWDZUN29wcHBoR2ZU?=
 =?utf-8?B?ZnB3b0FMK01Iby91QWhtaXFScVNDYkh2V294QXZ1djJIN09YNkNMeCsrUlFi?=
 =?utf-8?B?YVRHOStKNmV2WmI1SFdtL2VJN1hmVDBRcDlDdTlxdmJTWmd1aTNMc1ArMWho?=
 =?utf-8?B?WGo3UXF5VmRFSDFqQ1NsZjZSbjl6RWIyVUNtdzRmWmU2RU4zdU02eWxGSlBj?=
 =?utf-8?B?dkNvRlRsdmpxeTRTN0c5cUFzZDhwUnl1em4rSTM0UFJsdFdVR0duRTcrSjFW?=
 =?utf-8?B?Z2c1WDZnZzI5WjZMWEIxNW9EbHhSbStYcEM2eDhYbmFBU3hlSWpjbzVUY2tG?=
 =?utf-8?B?QkdWdFo5c09XbGZ4M1p5OGUzOWw5anozKzdyekt0KytLOVYrb0h0aGM2RlI3?=
 =?utf-8?B?VnFlcVgyRnVNdE5EVkNEMWFnMGpKeldvL2REMUFNMk8rZ1RpWm5tYmE5SWZ3?=
 =?utf-8?B?Sk5lY0JPRys4WVd6NlVLRmhxRFlQQjQzblRidWRxdm1vcklqS0dEOEhPUVls?=
 =?utf-8?B?cXVMZ2U4d05KQVJUU21mQ0ViOW96VTdoY0IzTVdOaGFDWnN3T1Vid2dDQU5J?=
 =?utf-8?B?WVFzU0pzTWY1bmxZN1NjZHVVRVY2dk1TU1ljalZwbzQzRTM3MU1QM3RjTG1u?=
 =?utf-8?Q?qVznEdP6f18bY+rKEbxaIEsuJDv5HbqnJ9s47cg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AFCE80B6204B142A79576A6F67553D9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa68d13-f19d-4489-7f74-08d9069ba9ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 21:06:28.4685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSUDgTX2Efi8Mvxs5/9786RoPS1tMqq6hBxf4OYWgUDpMk4Lxly57vMkK64DO5DQFq85MEpHtqzxCOlqWVcEHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3820
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA0LTE5IGF0IDE0OjAyIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
Q3VycmVudGx5IHJwY3JkbWFfcmVwc19kZXN0cm95KCkgYXNzdW1lcyB0aGF0LCBhdCB0cmFuc3Bv
cnQNCj4gdGVhci1kb3duLCB0aGUgY29udGVudCBvZiB0aGUgcmJfZnJlZV9yZXBzIGxpc3QgaXMg
dGhlIHNhbWUgYXMgdGhlDQo+IGNvbnRlbnQgb2YgdGhlIHJiX2FsbF9yZXBzIGxpc3QuIEFsdGhv
dWdoIHRoYXQgaXMgdXN1YWxseSB0cnVlLA0KPiB1c2luZyB0aGUgcmJfYWxsX3JlcHMgbGlzdCBz
aG91bGQgYmUgbW9yZSByZWxpYWJsZSBiZWNhdXNlIG9mDQo+IHRoZSB3YXkgaXQncyBtYW5hZ2Vk
LiBBbmQsIHJwY3JkbWFfcmVwc191bm1hcCgpIHVzZXMgcmJfYWxsX3JlcHM7DQo+IHRoZXNlIHR3
byBmdW5jdGlvbnMgc2hvdWxkIGJvdGggdHJhdmVyc2UgdGhlICJhbGwiIGxpc3QuDQo+IA0KPiBF
bnN1cmUgdGhhdCBhbGwgcnBjcmRtYV9yZXBzIGFyZSBhbHdheXMgZGVzdHJveWVkIHdoZXRoZXIg
dGhleSBhcmUNCj4gb24gdGhlIHJlcCBmcmVlIGxpc3Qgb3Igbm90Lg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IC0tLQ0KPiDCoG5l
dC9zdW5ycGMveHBydHJkbWEvdmVyYnMuYyB8wqDCoCAzMSArKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94cHJ0cmRtYS92ZXJicy5jDQo+
IGIvbmV0L3N1bnJwYy94cHJ0cmRtYS92ZXJicy5jDQo+IGluZGV4IDFiNTk5YTYyM2VlYS4uNDgy
ZmRjOWUyNWMyIDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBjL3hwcnRyZG1hL3ZlcmJzLmMNCj4g
KysrIGIvbmV0L3N1bnJwYy94cHJ0cmRtYS92ZXJicy5jDQo+IEBAIC0xMDA3LDE2ICsxMDA3LDIz
IEBAIHN0cnVjdCBycGNyZG1hX3JlcCAqcnBjcmRtYV9yZXBfY3JlYXRlKHN0cnVjdA0KPiBycGNy
ZG1hX3hwcnQgKnJfeHBydCwNCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBOVUxMOw0KPiDCoH0N
Cj4gwqANCj4gLS8qIE5vIGxvY2tpbmcgbmVlZGVkIGhlcmUuIFRoaXMgZnVuY3Rpb24gaXMgaW52
b2tlZCBvbmx5IGJ5IHRoZQ0KPiAtICogUmVjZWl2ZSBjb21wbGV0aW9uIGhhbmRsZXIsIG9yIGR1
cmluZyB0cmFuc3BvcnQgc2h1dGRvd24uDQo+IC0gKi8NCj4gLXN0YXRpYyB2b2lkIHJwY3JkbWFf
cmVwX2Rlc3Ryb3koc3RydWN0IHJwY3JkbWFfcmVwICpyZXApDQo+ICtzdGF0aWMgdm9pZCBycGNy
ZG1hX3JlcF9kZXN0cm95X2xvY2tlZChzdHJ1Y3QgcnBjcmRtYV9yZXAgKnJlcCkNCg0KVGhlIG5h
bWUgaGVyZSBpcyBleHRyZW1lbHkgY29uZnVzaW5nLiBBcyBmYXIgYXMgSSBjYW4gdGVsbCwgdGhp
cyBpc24ndA0KY2FsbGVkIHdpdGggYW55IGxvY2s/DQoNCj4gwqB7DQo+IC3CoMKgwqDCoMKgwqDC
oGxpc3RfZGVsKCZyZXAtPnJyX2FsbCk7DQo+IMKgwqDCoMKgwqDCoMKgwqBycGNyZG1hX3JlZ2J1
Zl9mcmVlKHJlcC0+cnJfcmRtYWJ1Zik7DQo+IMKgwqDCoMKgwqDCoMKgwqBrZnJlZShyZXApOw0K
PiDCoH0NCj4gwqANCj4gK3N0YXRpYyB2b2lkIHJwY3JkbWFfcmVwX2Rlc3Ryb3koc3RydWN0IHJw
Y3JkbWFfcmVwICpyZXApDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBycGNyZG1hX2J1
ZmZlciAqYnVmID0gJnJlcC0+cnJfcnhwcnQtPnJ4X2J1ZjsNCj4gKw0KPiArwqDCoMKgwqDCoMKg
wqBzcGluX2xvY2soJmJ1Zi0+cmJfbG9jayk7DQo+ICvCoMKgwqDCoMKgwqDCoGxpc3RfZGVsKCZy
ZXAtPnJyX2FsbCk7DQo+ICvCoMKgwqDCoMKgwqDCoHNwaW5fdW5sb2NrKCZidWYtPnJiX2xvY2sp
Ow0KPiArDQo+ICvCoMKgwqDCoMKgwqDCoHJwY3JkbWFfcmVwX2Rlc3Ryb3lfbG9ja2VkKHJlcCk7
DQo+ICt9DQo+ICsNCj4gwqBzdGF0aWMgc3RydWN0IHJwY3JkbWFfcmVwICpycGNyZG1hX3JlcF9n
ZXRfbG9ja2VkKHN0cnVjdA0KPiBycGNyZG1hX2J1ZmZlciAqYnVmKQ0KPiDCoHsNCj4gwqDCoMKg
wqDCoMKgwqDCoHN0cnVjdCBsbGlzdF9ub2RlICpub2RlOw0KPiBAQCAtMTA0OSw4ICsxMDU2LDE4
IEBAIHN0YXRpYyB2b2lkIHJwY3JkbWFfcmVwc19kZXN0cm95KHN0cnVjdA0KPiBycGNyZG1hX2J1
ZmZlciAqYnVmKQ0KPiDCoHsNCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBycGNyZG1hX3JlcCAq
cmVwOw0KPiDCoA0KPiAtwqDCoMKgwqDCoMKgwqB3aGlsZSAoKHJlcCA9IHJwY3JkbWFfcmVwX2dl
dF9sb2NrZWQoYnVmKSkgIT0gTlVMTCkNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJwY3JkbWFfcmVwX2Rlc3Ryb3kocmVwKTsNCj4gK8KgwqDCoMKgwqDCoMKgc3Bpbl9sb2NrKCZi
dWYtPnJiX2xvY2spOw0KPiArwqDCoMKgwqDCoMKgwqB3aGlsZSAoKHJlcCA9IGxpc3RfZmlyc3Rf
ZW50cnlfb3JfbnVsbCgmYnVmLT5yYl9hbGxfcmVwcywNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcnBjcmRtYV9yZXAsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcnJfYWxsKSkgIT0gTlVMTCkgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgbGlzdF9kZWwoJnJlcC0+cnJfYWxsKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHNwaW5fdW5sb2NrKCZidWYtPnJiX2xvY2spOw0KPiArDQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBycGNyZG1hX3JlcF9kZXN0cm95X2xvY2tlZChyZXApOw0K
PiArDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzcGluX2xvY2soJmJ1Zi0+cmJf
bG9jayk7DQo+ICvCoMKgwqDCoMKgwqDCoH0NCj4gK8KgwqDCoMKgwqDCoMKgc3Bpbl91bmxvY2so
JmJ1Zi0+cmJfbG9jayk7DQo+IMKgfQ0KPiDCoA0KPiDCoC8qKg0KPiANCj4gDQoNCi0tIA0KVHJv
bmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
