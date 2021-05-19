Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FFC389403
	for <lists+linux-nfs@lfdr.de>; Wed, 19 May 2021 18:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbhESQoV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 May 2021 12:44:21 -0400
Received: from mail-bn7nam10on2129.outbound.protection.outlook.com ([40.107.92.129]:28000
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237611AbhESQoU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 19 May 2021 12:44:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ff+l44jcNq2/ZX3knnpUFCUK7T5GEwZ1VlgRpSRuFrTFxde0xxYpg+k0STSt8ta6IDumvxdAdL3vdhUGEBdHLlWhsOW6732KLLa2Fu3tOob1fSemJ0lr5DxlgDfQQUBEbRyeNu+AsDRsbgcfolLEshafIma/WK9SF9x/jXsmiJoKsKA8kATyPu8Bv55VcgLaOlcr9IGFhlWzZwjE7RntnP07Rp7omBum3ZlVC7+S+4Z1FAIPUkL2HGFB5OpFX89KqEvoHqASo0XO9QQ6Lzb/cgAzeLnzWKdKOMHM5GG6hPVEMKqA3TpKbASmw1wMziCdXxUTnym3o2fpik3GKd0sQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XThEJ9oCorM+x+fYGX+6QicLlC7kntTD3pNExrpNKig=;
 b=QSPCF8EOwB90GEy9ZVWk9UjOyI+8UtpO06B8tU/r7L96keVMw97RKtIydY59JGyAH2iDLZSO5cSoNiWUkiQponUmGBnSznol8EXlZKfDVZ6cZ0u/dqDxWqmkjJ4jLjrDqaIXDVaG6YHIZE11ZXC0uqiNsNkPpnPCDAonvckt8Evmqur+ftIZytcP0ZP/f5vp1F30y7I0tky+YJ6zhRxX6VP1Ojl2X262G8WA68QpjXnXkrtmVUXBHd0xFj1GUUGAtiP/NZ36IR682N+73MibOzpyNJ28vJ9sI4zi87iZWQuPqDNjAPHLNXkiuvDVUUUqn1kE4k42ZUOcqOyIIcucCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XThEJ9oCorM+x+fYGX+6QicLlC7kntTD3pNExrpNKig=;
 b=CquejCl6R4Nnygkcch8Qx6wvxFXDFLRtPcAuM7hltZ4IHL9Sqx92O4DtZVqzDRB4ztwFMrfdpyjfR3R4XMd74unuPX75bj77+cwY2VobGWjY7XH4+jSXw/+iDyrvnA6+seCnA2v+CIMfhmwn1tZBFIyNKw+ogeWVUhOZpGGx5UI=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DS7PR13MB4576.namprd13.prod.outlook.com (2603:10b6:5:3a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.12; Wed, 19 May
 2021 16:42:59 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4150.011; Wed, 19 May 2021
 16:42:58 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
CC:     "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>
Subject: Re: [PATCH] NFSv4: Fix a NULL pointer dereference in
 pnfs_mark_matching_lsegs_return()
Thread-Topic: [PATCH] NFSv4: Fix a NULL pointer dereference in
 pnfs_mark_matching_lsegs_return()
Thread-Index: AQHXTMjzMuvFfY0eZUu//wumtfc5h6rrAnmA
Date:   Wed, 19 May 2021 16:42:58 +0000
Message-ID: <9b54027028a9a7322b6f06748c4499174a238866.camel@hammerspace.com>
References: <20210519160635.333057-1-Anna.Schumaker@Netapp.com>
In-Reply-To: <20210519160635.333057-1-Anna.Schumaker@Netapp.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12cd0da3-2f73-44bd-8040-08d91ae528f7
x-ms-traffictypediagnostic: DS7PR13MB4576:
x-microsoft-antispam-prvs: <DS7PR13MB4576F9E4EB6F3DEE2EAA826AB82B9@DS7PR13MB4576.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gztPRfJjVHqTe6v5T2C34gYBKMHrEdBOIQlMgYdDmnHf2RBLYEhaXnNsfYBE4sRHEFiFXPMsHG7JfDyQRglwMOcj4WHi95KD14gXILIRVnWSSNzIutHekvJq72kvWzDv1d/fIRKEdXsgss8bnzsvs44iHrNwLnL7cRJpcUCUTBtLbf8RRTj3xh8wcOA53UDuDSZJKQgoXdW6kubNye5vpsyIYzuEczY5zugnqi17lagE/JW0QjkRQ1Gx3tSaBNRa7u24IbU9nxKOF/k17t4u58t2bLkRujxIQ8goM49yhpF4etVS4CmfqW8lX94T7crWyhksVcf1amuDvs6Dqbn2i8LX7Kf31ZaXQi5uGNMDlOLj9TGRdqa9APrkV/WjZ6Y67VCsb6fHyuC6aEf+agvt/bQ5uuLlH65r2ikXeqem0NPgyqRfX0ywtPRNZNz7gVLRodYT6zXThwkLdvvsKFPYEIog61tg1eHqi1lZf/1dCT0QATM04V6KhgmRX+hG47dAgW6DBi1zfGgQA49LQujlqFbXF7yVR8VoI7Q6ZwE+a+Rx29lzwI/vR+x4kHlY6w4yR5idoDl98UqOCWfXkFIvuDS3kzZteFDml8LRQtLXajs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(396003)(346002)(376002)(366004)(186003)(122000001)(66446008)(64756008)(316002)(110136005)(8936002)(8676002)(83380400001)(38100700002)(66556008)(4326008)(6506007)(26005)(2616005)(6486002)(6512007)(76116006)(36756003)(5660300002)(66476007)(2906002)(71200400001)(478600001)(66946007)(91956017)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QkV2SXFEekx0OGY0RVY1TWY4M2luTE1XQ1Y1bnFSSkphK2VQZUg1c0p1M01l?=
 =?utf-8?B?d2ZhRnpRL1c0dlBTV0kza2pEaHF3WFJVRUxINnZVTTE0dkcvOHdSSDVnaCtC?=
 =?utf-8?B?eU5NT1VYSURwOStESGJDelo3Yis2cE92RnRLQWdCTUwzeHVuaVFIOXhSU252?=
 =?utf-8?B?cXIweElvYW9ZcGdYRzV1cEYvcVl2cHR5V1g4MjcxSyszNHUwYmRCaVV1NHNh?=
 =?utf-8?B?cEdja01vb2c2ZEVzcitEWWdYT2xJOTJoS0FCQ0x6NUt5M0RKWXp5YmRTOUc3?=
 =?utf-8?B?VmFacm9tRnlhM21qYjBoeTlQK08vTDZKRU5qVlFFNjJhaURCdGxRc1Z3blNs?=
 =?utf-8?B?d25adlJzNEQ2TUVMSDZmamd2UHlZTVhoRjk3TzZKS3ZNZSswS1duUUZReURQ?=
 =?utf-8?B?c3JKUTIvbGxlcmIvYTd5ZmQ3STlEUUJWdXlHYUFxeFNpcnM0c1VjdFlKZENL?=
 =?utf-8?B?YXlYQ05XNmJBTHVMOWdPZExLdDAzREdIZ3BnMlhxY1c1QnJNQy9sNk1BdTht?=
 =?utf-8?B?bWlkdk9oSlFXYzRjTXVMd2FsL3FZY05yb2Zud2hySGlCNE50eE9RK2J6TlNt?=
 =?utf-8?B?MzZhNEpXRDY1TjlSQ0VCZ0ppY0hIZEdSQTc5QVZhWXVhQWlrQmlSaWhYL2lj?=
 =?utf-8?B?bS8rclFWcW44UTc1eUN0OWVHakJlcDMyT3grS2loUzFxVlZSa3dNT2VpWlpm?=
 =?utf-8?B?aW5xdEVnWXhNcDFKN3VwZE1GYWlWMGhCdmtmZmFSMHJsNzFHaFU1SHZCOWpa?=
 =?utf-8?B?MjIrOE02MjByVnphdmRZSEFaREhJczNkYnppZkJJYjh5T0FVUUE5cExIQlVL?=
 =?utf-8?B?anNqT2FCV0RaeFZUOU5JeXVtNS96NlBCbFlZWUdSUGVwYmMveE82c0VuK0V1?=
 =?utf-8?B?MHJvY0x1VVc1Q0w2QmhpVk92UytGNnNvM2JJMkVaRkpibEwyVUFwZE5oOWJ1?=
 =?utf-8?B?TmZoUG9zcVdpUXhoU1d0eVNuSEFYRkI5eXhxeG85Y3Y3M1hWalBCT0F1eGdO?=
 =?utf-8?B?ZnFoN0Y1a1dEeEJYRFAvczJiWVE1WEo1NmkxTTU5R2cvU2Vjc3lGMm85bklq?=
 =?utf-8?B?dVRjV0VtYUlPM2p0Z0hhZHkvaHFpZ1dBdkRiSi93RGs2bGU0SWRPYWFlZnZY?=
 =?utf-8?B?Um5FM2hVWkJTdUpPT0F3bVEyb3JsaWtJTjBUc1oycDNHWVhIbFJValYwS3RU?=
 =?utf-8?B?M29CazNhTGtRbmJLQy91WXBHTlFBVm0wdXRkaUliK054bS8vYnVFMDNaeGdY?=
 =?utf-8?B?VzJkakxxZ1htSUY3V1MvbGN5SGNhTE15bXBNN3Z2Q3diTm90SGE1NVd1Ri9p?=
 =?utf-8?B?eGMwMmF6SmwxYW9BNEVqSzN5UkZWM3VxWUFhcVh3MUphdk1rNHQzYkRmOE5M?=
 =?utf-8?B?WWxTdk5RRllrblBZaDZ4OVh2dllkSHVKbkVtS01IeFFLNjk5dDFRcWhZZXdR?=
 =?utf-8?B?eXd2K1NUQlplZHcrZDJpT2VvQWlWTi95LzNMeGVjSGQzSmM5UkZvbVhOTkZD?=
 =?utf-8?B?aFdTU0VaeHBDUithdlhPcHcwRWpPUW9pYVZmOHk2TG1WbXhwOHJFeDdBUjNN?=
 =?utf-8?B?a2pxQldYUnBGb25XZmF6ZTJQenBIcjVveTVTeGI4bzVpOVQ1cUxqUlBjQW1M?=
 =?utf-8?B?a2krQ3ZhcEdsQzZNRWE2QldJUU5yeHAwNWsra0tJNzgwYXo1Y3hkVXo1UCtj?=
 =?utf-8?B?STRxOHIwTWdDOEgwRGNtenpYMC80aHhMbjRNM3JhSUgxMW1USkJORzFCeVJn?=
 =?utf-8?Q?r3HJ9/L/tvZZ5wr8cQgP+gLmt+p8A/hk2mx+ZHW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1923633957DCF84E9B732050B3F0C448@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cd0da3-2f73-44bd-8040-08d91ae528f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 16:42:58.4607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5krYewBHm+xLv8uXnExLGTlsXlBsO1TVrfOQuOsrXSzndNQZZFfUxB1KEaO/HaBFac5+KSScMqz/j2UOZxZ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4576
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA1LTE5IGF0IDEyOjA2IC0wNDAwLCBzY2h1bWFrZXIuYW5uYUBnbWFpbC5j
b20gd3JvdGU6DQo+IEZyb206IEFubmEgU2NodW1ha2VyIDxBbm5hLlNjaHVtYWtlckBOZXRhcHAu
Y29tPg0KPiANCj4gQ29tbWl0IGRlMTQ0ZmY0MjM0ZiBjaGFuZ2VzIF9wbmZzX3JldHVybl9sYXlv
dXQoKSB0byBjYWxsDQo+IHBuZnNfbWFya19tYXRjaGluZ19sc2Vnc19yZXR1cm4oKSBwYXNzaW5n
IE5VTEwgYXMgdGhlIHN0cnVjdA0KPiBwbmZzX2xheW91dF9yYW5nZSBhcmd1bWVudC4gVW5mb3J0
dW5hdGVseSwNCj4gcG5mc19tYXJrX21hdGNoaW5nX2xzZWdzX3JldHVybigpIGRvZXNuJ3QgY2hl
Y2sgaWYgd2UgaGF2ZSBhIHZhbHVlDQo+IGhlcmUNCj4gYmVmb3JlIGRlcmVmZXJlbmNpbmcgaXQs
IGNhdXNpbmcgYW4gb29wcy4NCj4gDQo+IEknbSBhYmxlIHRvIGhpdCB0aGlzIGNyYXNoIGNvbnNp
c3RlbnRseSB3aGVuIHJ1bm5pbmcgY29ubmVjdGF0aG9uDQo+IGJhc2ljDQo+IHRlc3RzIG9uIE5G
UyB2NC4xL3Y0LjIgYWdhaW5zdCBPbnRhcC4NCj4gDQo+IEZpeGVzOiBkZTE0NGZmNDIzNGYgKCJO
RlN2NDogRG9uJ3QgZGlzY2FyZCBzZWdtZW50cyBtYXJrZWQgZm9yIHJldHVybg0KPiBpbiBfcG5m
c19yZXR1cm5fbGF5b3V0KCkiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBwLmNvbT4NCj4g
LS0tDQo+IMKgZnMvbmZzL3BuZnMuYyB8IDQgKystLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL3Bu
ZnMuYyBiL2ZzL25mcy9wbmZzLmMNCj4gaW5kZXggMDNlMGIzNGM0YTY0Li42ZDcyMGFmYjdiNzAg
MTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9wbmZzLmMNCj4gKysrIGIvZnMvbmZzL3BuZnMuYw0KPiBA
QCAtMjQ4NCwxMiArMjQ4NCwxMiBAQCBwbmZzX21hcmtfbWF0Y2hpbmdfbHNlZ3NfcmV0dXJuKHN0
cnVjdA0KPiBwbmZzX2xheW91dF9oZHIgKmxvLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzZXRfYml0KE5GU19MU0VHX0xBWU9VVFJFVFVSTiwgJmxz
ZWctDQo+ID5wbHNfZmxhZ3MpOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0N
Cj4gwqANCj4gLcKgwqDCoMKgwqDCoMKgaWYgKHJlbWFpbmluZykgew0KPiArwqDCoMKgwqDCoMKg
wqBpZiAocmVtYWluaW5nICYmIHJldHVybl9yYW5nZSkgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHBuZnNfc2V0X3BsaF9yZXR1cm5faW5mbyhsbywgcmV0dXJuX3JhbmdlLT5p
b21vZGUsDQo+IHNlcSk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IC1FQlVTWTsNCj4gwqDCoMKgwqDCoMKgwqDCoH0NCj4gwqANCj4gLcKgwqDCoMKgwqDCoMKgaWYg
KCFsaXN0X2VtcHR5KCZsby0+cGxoX3JldHVybl9zZWdzKSkgew0KPiArwqDCoMKgwqDCoMKgwqBp
ZiAocmV0dXJuX3JhbmdlICYmICFsaXN0X2VtcHR5KCZsby0+cGxoX3JldHVybl9zZWdzKSkgew0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBuZnNfc2V0X3BsaF9yZXR1cm5faW5m
byhsbywgcmV0dXJuX3JhbmdlLT5pb21vZGUsDQo+IHNlcSk7DQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQoNClRoaXMgcGF0Y2ggd291bGQgbWVhbiB3ZSBmYWls
IHRvIG1hcmsgdGhlIGxheW91dCBmb3IgcmV0dXJuIGluDQpzaXR1YXRpb25zIHdoZXJlIHdlIGNs
ZWFybHkgc2hvdWxkIGJlIGRvaW5nIHNvLiBUaGUgbGFjayBvZiBhDQpyZXR1cm5fcmFuZ2UgZG9l
c24ndCBpbmRpY2F0ZSB0aGF0IHdlIGRvbid0IHdhbnQgdG8gcmV0dXJuIGFueSBsYXlvdXRzLA0K
YnV0IHJhdGhlciB0aGF0IHdlIHdhbnQgdG8gcmV0dXJuIGFsbCBsYXlvdXRzLg0KDQpJIHN1Z2dl
c3QgcmF0aGVyIGNoYW5naW5nIHRoZSBjYWxsZXIsIF9wbmZzX3JldHVybl9sYXlvdXQoKSB0byBt
b3ZlDQp0aGF0IGRlY2xhcmF0aW9uIG9mICdzdHJ1Y3QgcG5mc19sYXlvdXRfcmFuZ2UgcmFuZ2Un
IG91dCBvZiB0aGUgaWYNCnN0YXRlbWVudCBzbyB0aGF0IGl0IGNhbiBiZSBwYXNzZWQgYXMgYW4g
YXJndW1lbnQgaW5zdGVhZCBvZiBOVUxMLg0KDQo+IMKgwqDCoMKgwqDCoMKgwqB9DQoNCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
