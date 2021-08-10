Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457943E86D5
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 01:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbhHJXy6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 19:54:58 -0400
Received: from mail-bn7nam10on2125.outbound.protection.outlook.com ([40.107.92.125]:54913
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235508AbhHJXy5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Aug 2021 19:54:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2nbNHcPVu/tpAQmjnai7vJ4g/6a9FX28qo3VQ9dgEE9clp9Y752NarGIFwQ1c1YLBIfFnL7JTPVzQvZuUXLJMCyu9GgE0TOd/W+HKm2dj2eNtXAIt6TDIO3KSQW4wO/hjbA1NCyYdiyVcR1vQ9E8jjFrcCyQ88Tk/mrHaNhmjc8pOyBvrFI/ciK+8uhZADrDyRfTbScKEWXtSDFzxsSbjDh7/ck2cZkIkvxfy68ieUybD5sVqx5CKdZeuF/uys8kUZMmZFr973rYbINuebtdfHP1FduAnBAAuLH5aMfwHqsQiIH1rMdOZlc8D76O71YNucdypay5HSsNPyOHscqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dj0g63Yom8CaBJruOdY+7/4VGVqcxIyV/eV5M+M6lc=;
 b=WnGoWy/pPnh9VRQNkkkpQ002EB2uxAQ8kVWnbwBS9gPbBy7mjGM+TOVFlj9VF1RzE12PuMUE3w2+I3zyt550lvC+6voAvWYC7S4xfFTrg70AupqT2guW5HLQionV6Bqpz6awa55K8ZRTGP1Mt28wwhoremfN+P5U1q9WhPU+XFQjsoxLatc+8AGn3eJOZRp2AoulvbV7NUdvz1p1omcwze416emnaJGX9JNFtS/u3sucDfzqCgQFQ3hFl6nCbRqI5U7yMp7OnMDFyywU1ERiOpF5Dy/E31rMHfdI/ud/x6LNWBnIAinRlyU7rCX5Ruf2NuoiAq1GTtFoqvEqw9x6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dj0g63Yom8CaBJruOdY+7/4VGVqcxIyV/eV5M+M6lc=;
 b=R9cKE8lwS8uJVC9hYDGX1qRfH5Adrkj8BFx5v09ULe7U1xOA3Y4fUUeIkMJnn2PK0NPizYSOEetgEVQZblbcgxs2BArLU6ki5+Sv7guc7Vg3okjLgSol7TMw3cBqQBY4ZOEuz3EJN5jvILvlZb8dTSmwrRUCxYvFe0vm9q5wDhY=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3829.namprd13.prod.outlook.com (2603:10b6:610:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.6; Tue, 10 Aug
 2021 23:54:32 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%8]) with mapi id 15.20.4415.014; Tue, 10 Aug 2021
 23:54:32 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "calum.mackay@oracle.com" <calum.mackay@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: =?utf-8?B?UmU6IG9wZW4oT19UUlVOQykgbm90IHVwZGF0aW5nIG10aW1lIGlmIGZpbGUg?=
 =?utf-8?B?YWxyZWFkeSBleGlzdHMgYW5kIHNpemUgZG9lc24ndCBjaGFuZ2Ug4oCUIHBv?=
 =?utf-8?Q?ssible_POSIX_violation=3F?=
Thread-Topic: =?utf-8?B?b3BlbihPX1RSVU5DKSBub3QgdXBkYXRpbmcgbXRpbWUgaWYgZmlsZSBhbHJl?=
 =?utf-8?B?YWR5IGV4aXN0cyBhbmQgc2l6ZSBkb2Vzbid0IGNoYW5nZSDigJQgcG9zc2li?=
 =?utf-8?Q?le_POSIX_violation=3F?=
Thread-Index: AQHXjkCPYsHMnhvAmkypMjg3Qd+XfattaZ6A
Date:   Tue, 10 Aug 2021 23:54:32 +0000
Message-ID: <42e1ac079a305ce85de66882c99110c6ed05164b.camel@hammerspace.com>
References: <2460b04f-c699-971b-2b44-f6ec059e3b58@oracle.com>
In-Reply-To: <2460b04f-c699-971b-2b44-f6ec059e3b58@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de7600e6-9eeb-4b64-ff4f-08d95c5a3355
x-ms-traffictypediagnostic: CH2PR13MB3829:
x-microsoft-antispam-prvs: <CH2PR13MB3829891C51393CB6881A0260B8F79@CH2PR13MB3829.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZbwgGEiMwDUA9ouL/0FOIzQgRct4TDMb3wgLmJtZ7jyuvs8Q+WQakNKwb//RWASUsXLtawPW0RtF9KEuBVy6itYlRlpmaZc4CxuW8S8wVp79RlkUzhpnjnAO6meAM1/9FbLPk5Qlz5D/SOwb9lrubX5E47TSNrMabDYIKBhhsAoCvzelHdtirJkXXqJSp9BV45aMbdtXuQhSHImBTUdPDWbaH0zJy7yrmYCvntQwbLNokVO6xgl9LkfRHpoMKZdaMZCaD2kMcPDwGxvyvoda2UP5iGVKuywpGifvjzm1I+BW+QMEQo6zb7oXfgZcPL9+RrdCImCRAPbBJl9NO3YWEKyY8HNWVwUtvrV2bptmRnxqeoOqHjBlWbzQF45CmkoDerxVYFFREup+GYKEVGq1cgvNwM13u/qJjcTlEGTj7emIJAoi6diK2cHLB6bYFeKF0Lcls5Axm1CNbYqPul7+HPBUNJLZJYykFuchBkRB6KIXleM8bYPFq/Fzt7PwesAV168wnmIxoqmA972e1i5P9WOrpBdH+6Sz9iVr87o51XduGUMQo8706DDkP7VITqnJSgzbeXto8Yk11F28ildsYRHE3Hlewenfxc8e5Sn4Gi/97ujd2zLmm5I8LHKeyR1fykWhXjAbLV2XfuKurC7BmMfkeaTFc3tu8z33BFLJuwUWlo5SO5sGbEu3xoWuOQTICa+1fDR6XKd8AcJD4D8si0acDbEsmi8kLm/22KyRNRUbKweFQlZ69weITRAWXn7I/4SnXlklL+Lmxgl/A1sfH7hzRmXTVoZupkkZjBAHi+g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(136003)(366004)(396003)(376002)(36756003)(6512007)(38100700002)(6506007)(478600001)(83380400001)(186003)(6916009)(122000001)(8936002)(6486002)(4326008)(2906002)(76116006)(66446008)(66476007)(66946007)(26005)(66556008)(64756008)(38070700005)(71200400001)(316002)(2616005)(5660300002)(86362001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUhXOEFHQng4aWpYQjZya0NHWGxpRm1HcGxWS1VEaSs3TWlsVUNuNE1vUkR4?=
 =?utf-8?B?RWdKOWhEOVFMUjJESzZENE81dW4yK3ovYk9aeCtCQXB3RUhXMG9SMk1CZS9W?=
 =?utf-8?B?aFkwL1lXVEZSMmhwUnVQdTBCamVwaDYrTG1pKzRVQ01WL3NreEFKaWc3Z0FR?=
 =?utf-8?B?c3VRczNHbGxobmJqcXJkZUxTWEw5Q3BWa0VnMFRUMjQyNE9IR0kwckhJang1?=
 =?utf-8?B?MmhpT3ljTXhkWS9wRTJYeURmQzg4T2hWa0ptZEkxNU5EYUdVdnozWDQ4c3l5?=
 =?utf-8?B?ZkZGVkdMeXlzUC9TZlh0OG0valpOa1VhOEhpblgwZ1Q0Q0xueW5Iei9hNmxo?=
 =?utf-8?B?RkFWR2pQeXdxY25hRFd2MWJFVVF1RnNsc3FFV3NOOVE1RCs3aTRYRTlCT3do?=
 =?utf-8?B?RGF3ak5KMm01aGJIS3JPdlRPdS9GaDBSWXlEQnFXczZFWmxqT2IxZkZVUUpX?=
 =?utf-8?B?N1VJQmlla0x0VWhxYWFRRVZCNkQyc1l1Z2hkSEd2Zm10amE2SGdSei9NUTk3?=
 =?utf-8?B?ZGFlK2VZYk9zZWgzNTVrM2pXM2dvZjdsSHhGdkg0ZjFjTmNLemwwMGNKdS9L?=
 =?utf-8?B?TFVMYzhqRFhGS09IamdSNDVFdG5WaHB0bU9teGs5bFBDTzI2RG1ydlNEZlhS?=
 =?utf-8?B?WWFEbzNYV2w4bXNqZjUxa2phZVMwczlSYTBxY3hVT3J5RlpMZmVGMUZoaHRJ?=
 =?utf-8?B?VDN4bzNHbzJjVVlBMUo4WldVUGRQVTJiU1pwZklSalNhZk1JMVdidGxUd08r?=
 =?utf-8?B?V3BGRmZZZkxUaDAyNDZ1MUpjL2M3czg5T0V5b2NEQW04aEV5Tm02Z1cwSllI?=
 =?utf-8?B?T2IxcWdaZExRZGFVT0lCME0zblExMFgyQXhna0szQjVSVGNFaWJ0LzZGaElr?=
 =?utf-8?B?aTRSQThLT3J3S0ROcUpMcjFSMTU4MnVHbFJOenNkRU02MG04dDdseTBPcjcr?=
 =?utf-8?B?Y1BLVnJ2Wk5GcGlteDNyb0pqazRub2F0TjBYNEFqK1c4ZGZ6Sk5UQ3V5Wnpn?=
 =?utf-8?B?dTFkTm5GWk5uOHRhL3o2czlmblY5aTZla285eFdabGp6Q3BJeG11YklzbTVs?=
 =?utf-8?B?N2V2eGxhcTlBbnVBQjJwbGZLL0pDODRwV282TkkrWmNFbGtUUUZDbHhqZWJ6?=
 =?utf-8?B?UkMzSmhFaXBKNnd3L1RST29DVUEyYmZDcm5LeE83WmFhZ1BzK2dPUjA2a2dF?=
 =?utf-8?B?KzVycUthTTJyVlZUSFpzVjQyQ2pIdllSZ1BWTlFUSTZkd0pncS9lcVA1V2tH?=
 =?utf-8?B?QmxtMUYxZFBwQS96VmZxNFJ1WTE4cXdNZjhjeXNVbXZ1QnViSjUxVUFWVzRz?=
 =?utf-8?B?eFJCSTUyUWZVNmdVbS9nbDNRTXZLYlF2VWtjWFFUVGRDbE0vMEYxQXF1Q2xD?=
 =?utf-8?B?dUdGNjNlK2NXZ3NUNXZ1K21LVTUyUVVlTDVQSFpBWkRyN3FPdmdWQjhJZFFy?=
 =?utf-8?B?UkxMTFpUMU9wYVQ3TWh1UDBQZi9oRXVobzRRdTZJSXBJdDVhaUhCZGF1aEhv?=
 =?utf-8?B?Zzd4bHB0c3JzbjExOVJLNkd4UlFDNDlXem5SaGNwTHdMd0xVY21QdnEvNlB5?=
 =?utf-8?B?WWllWjhzTk9lZzZ3S3pHTFZKWDBXaFJ5TWh5MXdPSDNZbVNueTZSdW1ocTlO?=
 =?utf-8?B?VTlvREc4T1F1c2FGS0ZRNm5VRDRqR25wTDBPZE1aTzVsTVdrZ1UrOCtUd1FS?=
 =?utf-8?B?WGtXbnVQTTJUZHc4TGQ0NWk4YUYwZ1lLMTRrTFZHQ21GU1ZJTmt1MWJsV3dx?=
 =?utf-8?Q?GjBUma42uU9tmRbXgzrGpjAzGKBhw+rkmnaFDSG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <784657EFAEEE624DB32F140460C4E102@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7600e6-9eeb-4b64-ff4f-08d95c5a3355
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 23:54:32.6636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Nl31vwxCh5oIIqVmW6wEpw3z0BNKwCFQbF4ES7A4eGZeECs0GthQaNSc9l3krEsViUvHuV62YrLmQHtPI3Xdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3829
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA4LTExIGF0IDAwOjM2ICswMTAwLCBDYWx1bSBNYWNrYXkgd3JvdGU6DQo+
IGhpIFRyb25kLA0KPiANCj4gSSBoYWQgYSByZXBvcnQgdGhhdCBiYXNoIHNoZWxsICJ0cnVuY2F0
ZSIgcmVkaXJlY3Rpb24gd2FzIG5vdCB1cGRhdGluZyANCj4gdGhlIG10aW1lIG9mIGEgZmlsZSwg
aWYgdGhhdCBmaWxlIGFscmVhZHkgZXhpc3RlZCwgYW5kIGl0cyBzaXplIHdhcyANCj4gYWxyZWFk
eSB6ZXJvLg0KPiANCj4gVGhhdCdzIHRyaXZpYWwgdG8gcmVwcm9kdWNlLCBoZXJlIG9uIHY1LjE0
LXJjMywgTkZTdjQuMSBtb3VudDoNCj4gDQo+ICMgZGF0ZTsgPiBmaWxlMQ0KPiBUdWUgMTAgQXVn
IDE0OjQxOjA4IFBEVCAyMDIxDQo+ICMgbHMgLWwgZmlsZTENCj4gLXJ3LXItLXItLSAxIHJvb3Qg
cm9vdCAwIEF1ZyAxMCAxNDo0MSBmaWxlMQ0KPiANCj4gIyBkYXRlOyA+IGZpbGUxDQo+IFR1ZSAx
MCBBdWcgMTQ6NDM6MDYgUERUIDIwMjENCj4gIyBscyAtbCBmaWxlMQ0KPiAtcnctci0tci0tIDEg
cm9vdCByb290IDAgQXVnIDEwIDE0OjQxIGZpbGUxDQo+IA0KPiANCj4gQW4gc3RyYWNlIChvZiB0
aGUgc2Vjb25kLCBhYm92ZSkgc2hvd3MgdGhhdCB0aGUgYmFzaCBzaGVsbCBpcyB1c2luZyANCj4g
b3BlbihPX1RSVU5DKToNCj4gDQo+IDEwNTgxIDE0OjUyOjM2Ljk2NTA0OCBvcGVuKCJmaWxlMSIs
IE9fV1JPTkxZfE9fQ1JFQVR8T19UUlVOQywgMDY2NikgPSAzDQo+IDwwLjAxMjEyND4NCj4gDQo+
IGFuZCBhIHBjYXAgc2hvd3MgdGhhdCB0aGUgY2xpZW50IGlzIHNlbmRpbmcgYW4gT1BFTihPUEVO
NF9OT0NSRUFURSksIA0KPiB0aGVuIGEgQ0xPU0UsIGJ1dCBubyBTRVRBVFRSKHNpemU9MCkuDQo+
IA0KPiANCj4gSSB0aGluayB0aGlzIG1pZ2h0IGJlIGJlY2F1c2Ugb2YgdGhpcyBvcHRpbWlzYXRp
b24sIGluIHRoZSBpbm9kZQ0KPiBzZXRhdHRyIA0KPiBvcCBuZnNfc2V0YXR0cigpOg0KPiANCj4g
wqDCoMKgwqDCoMKgwqDCoGlmIChhdHRyLT5pYV92YWxpZCAmIEFUVFJfU0laRSkgew0KPiANCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDigKYNCj4gDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaWYgKGF0dHItPmlhX3NpemUgPT0gaV9zaXplX3JlYWQoaW5vZGUp
KQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhdHRy
LT5pYV92YWxpZCAmPSB+QVRUUl9TSVpFOw0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiANCj4gwqDC
oMKgwqDCoMKgwqDCoC8qIE9wdGltaXphdGlvbjogaWYgdGhlIGVuZCByZXN1bHQgaXMgbm8gY2hh
bmdlLCBkb24ndCBSUEMgKi8NCj4gwqDCoMKgwqDCoMKgwqDCoGlmICgoKGF0dHItPmlhX3ZhbGlk
ICYgTkZTX1ZBTElEX0FUVFJTKSAmDQo+IH4oQVRUUl9GSUxFfEFUVFJfT1BFTikpID09IDApDQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+IA0KPiBhbmQsIGlu
ZGVlZCwgdGhlcmUgaXMgbm8gY2hhbmdlIGhlcmU6IHRoZSBmaWxlIGFscmVhZHkgZXhpc3RzLCBh
bmQgaXRzIA0KPiBzaXplIGRvZXNuJ3QgY2hhbmdlLg0KPiANCj4gSG93ZXZlciwgUE9TSVggc2F5
cywgZm9yIG9wZW4oKToNCj4gDQo+ID4gSWYgT19UUlVOQyBpcyBzZXQgYW5kIHRoZSBmaWxlIGRp
ZCBwcmV2aW91c2x5IGV4aXN0LCB1cG9uIHN1Y2Nlc3NmdWwNCj4gPiBjb21wbGV0aW9uLCBvcGVu
KCkgc2hhbGwgbWFyayBmb3IgdXBkYXRlIHRoZSBsYXN0IGRhdGEgbW9kaWZpY2F0aW9uDQo+ID4g
YW5kDQo+ID4gbGFzdCBmaWxlIHN0YXR1cyBjaGFuZ2UgdGltZXN0YW1wcyBvZiB0aGUgZmlsZS4N
Cj4gDQo+IFtodHRwczovL3B1YnMub3Blbmdyb3VwLm9yZy9vbmxpbmVwdWJzLzk2OTk5MTk3OTkv
ZnVuY3Rpb25zL29wZW4uaHRtbF0NCj4gDQo+IHdoaWNoIHN1Z2dlc3QgdGhhdCB0aGlzIG9wdGlt
aXNhdGlvbiBtYXkgbm90IGJlIHZhbGlkLCBpbiB0aGlzIGNhc2UuDQo+IA0KPiBbdGhlcmUncyBh
IHNpbWlsYXIgaXNzdWUgcGVyaGFwcyBmb3IgZnRydW5jYXRlKCkgd2hlcmUgdGhlIHNpemUgZG9l
c24ndA0KPiBjaGFuZ2VdDQo+IA0KPiANCj4gSSBoYXZlbid0IHlldCB3b3JrZWQgb3V0IHdoZXRo
ZXIgaW4gdGhpcyBjYXNlIGl0J3MgZGVsaWJlcmF0ZSwgYnV0IG5vdCANCj4gUE9TSVggY29tcGxp
YW50LCBvciBhY2NpZGVudGFsLg0KPiANCj4gd291bGQgYXBwcmVjaWF0ZSBhbnkgY29tbWVudHM/
DQo+IA0KDQpJIHZhZ3VlbHkgcmVjYWxsIHRoYXQgdGhlIE9wZW4gR3JvdXAgaGFzIGJlZW4gcmF0
aGVyIHdpc2h5IHdhc2h5IGFib3V0DQp0aGlzIGJlaGF2aW91ciBwcmV2aW91c2x5Lg0KDQo8bG9v
a3NcPg0KDQpZZXAsIGZvciBzb21lIHZlcnNpb25zIG9mIHRoZSBTaW5nbGUgVW5peCBTcGVjLCB0
aGUgY3VycmVudCBORlMgY2xpZW50DQpiZWhhdmlvdXIgd2FzIG1hbmRhdGVkLiBGb3IgaW5zdGFu
Y2UNCmh0dHBzOi8vcHVicy5vcGVuZ3JvdXAub3JnL29ubGluZXB1YnMvMDA5Njk1Mzk5L2Z1bmN0
aW9ucy90cnVuY2F0ZS5odG1sDQpzdGF0ZXMgdGhhdCB0aGUgYy9tdGltZSBjaGFuZ2UgaWYgYW5k
IG9ubHkgaWYgdGhlIGZpbGUgc2l6ZSBjaGFuZ2VkLg0KDQpJT1c6IFRoZSBwcm9ibGVtIGhlcmUg
aXMgdGhhdCBQT1NJWCwgYW5kIHRoZSBlYXJsaWVyIFNVUyBoYXZlIGRpdmVyZ2VkLg0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
