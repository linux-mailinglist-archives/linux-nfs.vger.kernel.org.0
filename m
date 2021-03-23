Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4D234671C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 19:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhCWSCD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 14:02:03 -0400
Received: from mail-eopbgr1320130.outbound.protection.outlook.com ([40.107.132.130]:57568
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230370AbhCWSBx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 14:01:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd/ypMTWJbc1VDFC64emzCRjBVIN3Gli3ewRr7eiAOkBnFK/WvVgDTfuF2gD8Vb8lpXimUHcrPrfzIKqZvv21WDlpVbggBdvwEQzxYT3RlNsI2FditwlOreDoI/BdrvJ4+GjzGmRC2huSZjYle8WpSR8DkSDG/KPHKu/1hgktzxVW3GvxITEK2oMWd84F7Mdo54h3kLfttdXnpxJmCpLTlYWrWTWnbh+GK0+dxYOE1i4mDaH73yQEx4GmhgUHmJ/yJxy+alnVdL+g+EWk8YdqaWFVuz6aH2Y1s/Jxra83bWq4QIO6MS0EmFIT/REL/Hybby4zquAWV8zTz8sxWhxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUK/6Amz9tPAiH1UVz7JVcCXD+foKSr7lqpJTPso6VE=;
 b=Bvb0qaBwdY81ZCS/FevhWqV6nI4zrRyTR8ARnB+LSWnvEktGbW1JKldt7ub8f4pwcU5qkkYcm8Nl30IKdPhLulC+DAZjGBoJ1q5sjmaYWr4jBErtf+Mkzb6wUGCyZ9UInlw8hL1U+Z+WVN1/KIFywF7RWV11j1/c1jgFO7PJhzrLGwiHVqrgsyK1nZPBPI25m7NawLQSmW8v2LacK4bhJaCkrc2dUxkFcNEnWDFG9+Ci8NpCeIQ1FD0ZyJL1533OxoiapLIksjE1JJl33IHAKJd+Jogf0AlWq0PirmNfH7vhXWfAikTNqO1zBy4lPTRKLf+huxgw/3s6jltxuv+zeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUK/6Amz9tPAiH1UVz7JVcCXD+foKSr7lqpJTPso6VE=;
 b=Sj3I0vURI2P8sJN2+b0KgrvdBw8x3FeOjnlk8us9/wcHIdZc1buEBQA7H3Se+GXWQdn30BnaOmxFV30JIPZFln/iFc6TqV+iemEUpRGd2B6AQdZi36f9SbEeYQuY2OKKubwSbEDMuCHKmojThKoVhtutmBC+JeIgb6vVQhldSNA=
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM (2603:1096:0:4::11) by
 SG2P153MB0254.APCP153.PROD.OUTLOOK.COM (2603:1096:4:df::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.2; Tue, 23 Mar 2021 18:01:49 +0000
Received: from SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488]) by SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd6e:9dc1:85ac:f488%5]) with mapi id 15.20.3999.008; Tue, 23 Mar 2021
 18:01:48 +0000
From:   Nagendra Tomar <Nagendra.Tomar@microsoft.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: RE: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Topic: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Index: Adcfp3hcmhRvn3IHQv25MQlIHJPMUAARGOoAAAMHR+AAAek9AAAAU0WQAAIhaYAAALhG4A==
Date:   Tue, 23 Mar 2021 18:01:48 +0000
Message-ID: <SG2P153MB0361455966B8436516A355729E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
References: <SG2P153MB0361E2D69F8AD8AFBF9E7CD89E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <CD47CE3E-0C07-4019-94AF-5474D531B12D@oracle.com>
 <SG2P153MB0361BCD6D1F8F86E0648E3EB9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <5B030422-09B7-470D-9C7A-18C666F5817D@oracle.com>
 <SG2P153MB0361DC1EF8EDD02356D29E579E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <575FF32B-463E-41D8-882F-6A746DF7FDFA@oracle.com>
In-Reply-To: <575FF32B-463E-41D8-882F-6A746DF7FDFA@oracle.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [122.172.188.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5bbb2a4-6763-45ee-651d-08d8ee25bae0
x-ms-traffictypediagnostic: SG2P153MB0254:
x-microsoft-antispam-prvs: <SG2P153MB025482F5EC39EC95843FB82E9E649@SG2P153MB0254.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:392;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iMqf/3OEHyIeQUp9F9GSH00IFItS5G2VE3jqQbNcEXQvnUsmxc5ODmQybVvrvAMIC9ep6KDOneszXNY0GHLoM5Y9unVCs+YtwtgmgE7x9hqLVMN4KN/Lr5l79LWG3mO8wDKOSxnDnjFio9OosSPuoEMDNFvX5wlFZS1l++woTPOJNVw4dd3UvnlHp/T8TCdtgEnNJu+g3LwBYcR978aXr4HGhs+YOI9sNEf0iLaZwS1tV7AFq3lRkDy7hVJfkdOE9v2PpkQ0/tv0iDz6fGvCozMv+BWtBL0LckMLVfDdtUbV2j3TvxVbMs8iVGBBbx1UJzt+Jv8byGVZTg+RUoWLk5CLcYpUOyoSY9xHEuzRMXFAg+uuJ3UjAlEw2NxkIfiTreqJ9m6ts5D/S23uZ6nrqkr6TQbXfOvD2R91wsPzxxSV2/4xbGp+G6FKg7j5XYU1kCvmOBgEgV3I2uDq/j2deCi3x6G1DnT9xaGYqNHLJvN6rmbG0NUwzsrPE23KBmfiMaYlebZRp32fsjxl9i1Z39w3naIN7Z4qIbhSsGPrHeIzitRLHpL1S67QeErCeq3kwd0ILUt0JLtF7Yku2LmSSbPUbxtZtr952/nzprLSynGPBCUSH3Fsf84UsFu/2hIl6CvXunUX72Jknj6d1MS+tSfh2DWYZmxS1tDV8oGSgXE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0361.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(66446008)(66556008)(54906003)(82960400001)(8676002)(82950400001)(66476007)(38100700001)(2906002)(8990500004)(33656002)(55236004)(8936002)(86362001)(64756008)(83380400001)(10290500003)(186003)(76116006)(5660300002)(26005)(6506007)(498600001)(66946007)(52536014)(53546011)(6916009)(55016002)(71200400001)(9686003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N2hlRmxnRGc4dDB6YTE0NE9hby80M3VkcHNiVXg5OWp3Uk5NOXZRVTRxUXpL?=
 =?utf-8?B?TGRDWW4wWHpDYytvTGxLMlBEZFZmZWh5bkhaYUp3bFBxQU50TnN3SzRQaWd6?=
 =?utf-8?B?Unh4UmtnNGIvZDF0djNpSVNBRGVxN2JtUjBqYmo3elN3VG10RjBlRG9lTDNE?=
 =?utf-8?B?WUlKTnZxeDFFMC8weTV4Smd3WmZjYklUQjlIbnBrbWFGOUdrVjcyMCtqTXY1?=
 =?utf-8?B?Q0xxa1I1ZUtRdVVqQTllYXFuN2gzRVdpOUhIRFdXUENiMXRWdE9OeExCRWN3?=
 =?utf-8?B?dGxXSW9jL3A1dEVKSlRQdnNOOWFiVEVDUTkxWURLREQzSkpnaDlJUFZsRnJO?=
 =?utf-8?B?NElpb2pRYmdxQWJTaVlFL3owT2ZiemVMTXZDWGhoUlVwODJCZzFEVXhmcU9B?=
 =?utf-8?B?R3UxVUVVaFFPL296TWEzamI3QlN1dUlQMDJRb0lYTkhGU2hFSU16ekJWUmdL?=
 =?utf-8?B?TmJGUlZXN1BYbEtoZXo0QUh5djFVVFJYN1hmUDhjR1hZY1U2cjlTYW5WQjJT?=
 =?utf-8?B?cTJCdlVjL05aY2NpSkRZcHU5eUpSd2cxVm9hcGhJMHF5d2RzQW1yOXVYMXZV?=
 =?utf-8?B?ZzJUQUlUbGtEdTRia0g3YnFBVW9JamJ2SnZYdEludzRXeHNOQ2d3bnBlWHNp?=
 =?utf-8?B?eU91RGNaK2ZkWjhKai9VZzlhSjgwcUd1MHd1ZmdlTmxEa0ZRcW1XZWZmYTIz?=
 =?utf-8?B?RUdEdnYwQlZMWi92Y1ZaTDBTQ2dad0Q3OGtGdGJod3Y3UjhPSUFxRVp0UGlE?=
 =?utf-8?B?Z0x1ckx4ejR2U1UvMmRuYzRMSHVTMkxET3oyZVdoZnc2ZUlFekNja1ZuVlFF?=
 =?utf-8?B?OFp2NGVtSDNEanRtK3VhbVhsbWhwVllSTnVpdDBJOVNTV09Nc1BjWlFMUUNH?=
 =?utf-8?B?MCtjY1U3MXBYV1FGNm9XTFJvSGtKb2VqRVdFaW0rYzRUcHlpV28wSFNTZHNx?=
 =?utf-8?B?MmxKQmlremFwNnUrZ0VIUzMxNTVEMmFEY2x4QlJSSVI0anphbHBReGpJM0h3?=
 =?utf-8?B?QjJBeGR1b0VLbDZyVzFpRFgyS05oTmR0SURGMW54MlUwMzY3QWwyTjR5ZkFw?=
 =?utf-8?B?Tkgvc2QzT0ZwdkFVblJNVGZNb1lRNWgybXJQb3NMZ0NDMnI2cy93K3dEWDNS?=
 =?utf-8?B?UitMaTRxTVJ5c1J6ZkNtYkpQRmpKdkgxTDVjVUplUk9wYlR4SWpJZS9Ndk43?=
 =?utf-8?B?MmtjaDVVcXZTZjlSQnZLQ3ZJaUk2cmZnYndLNWg5ZjhuMk9NZGQrRkppWUZV?=
 =?utf-8?B?MXVzQW9UbzJoSVpWMjljTnB3OURhTVdoNEVuREt2eHRZS29rcGk4UHJDZ2Mv?=
 =?utf-8?B?cXQ5bzFoa2NUU1h1czY2bDB3VnBSWmtxWWFydldwazhOMnlQdWc4WE56UGlE?=
 =?utf-8?B?RVo4V2NCc25tUWhHcWp4VVcxeUhPYXRvWEwrWGU3ZUd5aGtiM2RjWEdxL3Ux?=
 =?utf-8?B?V3NhbklQSDBUTlVkWHgwaFRUM2QxNWcwMDgrVytqN0s0bEpEdG93T3RwTlhY?=
 =?utf-8?B?L1UwZCs3emRIZ2htYTIzeHhXVGRUVmt5TndlaEVmVFdTelZaSVRRWkNIRUlx?=
 =?utf-8?B?VGMvdDFTRmZFMjh4TE9BNXdLL2pBTkltZ3dNQk1lWHpaVEE5c3ZHWXJUSjFC?=
 =?utf-8?B?M3NIRmJucFFONzVXdnkyZUd6MUx1U2UzbVRidFN3S3M4TUNjbnkvREsyNXJx?=
 =?utf-8?B?SVc2YVVpbS8wU2gvWjc4WGxUUC92ZE40VjVnbXp4dzlWbVkrQytSa3N0MFVD?=
 =?utf-8?Q?TjcR05EYFWFRGc6ERzopl/ogsCprHpSdZC5joe8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0361.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bbb2a4-6763-45ee-651d-08d8ee25bae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 18:01:48.7084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkLaon3/5ym4YB4K71eoPWTJDhRlfgO1HZ3h+GYCFMPjAx5foENvvAjyHhbS4vM7nfn/avs1Mv2bfFw4sZaP1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0254
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

ID4gPiBPbiBNYXIgMjMsIDIwMjEsIGF0IDEyOjI5IFBNLCBOYWdlbmRyYSBUb21hcg0KPiA8TmFn
ZW5kcmEuVG9tYXJAbWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+ID4NCj4gPj4+IE9uIE1hciAyMywg
MjAyMSwgYXQgMTE6NTcgQU0sIE5hZ2VuZHJhIFRvbWFyDQo+ID4+IDxOYWdlbmRyYS5Ub21hckBt
aWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPj4+DQo+ID4+Pj4+IE9uIE1hciAyMywgMjAyMSwgYXQg
MTo0NiBBTSwgTmFnZW5kcmEgVG9tYXINCj4gPj4+PiA8TmFnZW5kcmEuVG9tYXJAbWljcm9zb2Z0
LmNvbT4gd3JvdGU6DQo+ID4+Pj4+DQo+ID4+Pj4+IEZyb206IE5hZ2VuZHJhIFMgVG9tYXIgPG5h
dG9tYXJAbWljcm9zb2Z0LmNvbT4NCj4gPj4+Pg0KPiA+Pj4+IFRoZSBmbGV4ZmlsZXMgbGF5b3V0
IGNhbiBoYW5kbGUgYW4gTkZTdjQuMSBjbGllbnQgYW5kIE5GU3YzIGRhdGENCj4gPj4+PiBzZXJ2
ZXJzLiBJbiBmYWN0IGl0IHdhcyBkZXNpZ25lZCBmb3IgZXhhY3RseSB0aGlzIGtpbmQgb2YgbWl4
IG9mDQo+ID4+Pj4gTkZTIHZlcnNpb25zLg0KPiA+Pj4+DQo+ID4+Pj4gTm8gY2xpZW50IGNvZGUg
Y2hhbmdlIHdpbGwgYmUgbmVjZXNzYXJ5IC0tIHRoZXJlIGFyZSBhIGxvdCBtb3JlDQo+ID4+Pj4g
Y2xpZW50cyB0aGFuIHNlcnZlcnMuIFRoZSBNRFMgY2FuIGJlIG1hZGUgdG8gd29yayBzbWFydGx5
IGluDQo+ID4+Pj4gY29uY2VydCB3aXRoIHRoZSBsb2FkIGJhbGFuY2VyLCBvdmVyIHRpbWU7IG9y
IGl0IGNhbiBhZG9wdCBvdGhlcg0KPiA+Pj4+IGNsZXZlciBzdHJhdGVnaWVzLg0KPiA+Pj4+DQo+
ID4+Pj4gSU1ITyBwTkZTIGlzIHRoZSBiZXR0ZXIgbG9uZy10ZXJtIHN0cmF0ZWd5IGhlcmUuDQo+
ID4+Pg0KPiA+Pj4gVGhlIGZ1bmRhbWVudGFsIGRpZmZlcmVuY2UgaGVyZSBpcyB0aGF0IHRoZSBj
bHVzdGVyZWQgTkZTdjMgc2VydmVyDQo+ID4+PiBpcyBhdmFpbGFibGUgb3ZlciBhIHNpbmdsZSB2
aXJ0dWFsIElQLCBzbyBJSVVDIGV2ZW4gaWYgd2Ugd2VyZSB0byB1c2UNCj4gPj4+IE5GU3Y0MSB3
aXRoIGZsZXhmaWxlcyBsYXlvdXQsIGFsbCBpdCBjYW4gaGFuZG92ZXIgdG8gdGhlIGNsaWVudCBp
cyB0aGF0IHNpbmdsZQ0KPiA+Pj4gKGxvYWQtYmFsYW5jZWQpIHZpcnR1YWwgSVAgYW5kIG5vdyB3
aGVuIHRoZSBjbGllbnRzIGRvIGNvbm5lY3QgdG8gdGhlDQo+ID4+PiBORlN2MyBEUyB3ZSBzdGls
bCBoYXZlIHRoZSBzYW1lIGlzc3VlLiBBbSBJIHVuZGVyc3RhbmRpbmcgeW91IHJpZ2h0Pw0KPiA+
Pj4gQ2FuIHlvdSBwbHMgZWxhYm9yYXRlIHdoYXQgeW91IG1lYW4gYnkgIk1EUyBjYW4gYmUgbWFk
ZSB0byB3b3JrDQo+ID4+PiBzbWFydGx5IGluIGNvbmNlcnQgd2l0aCB0aGUgbG9hZCBiYWxhbmNl
ciI/DQo+ID4+DQo+ID4+IEkgaGFkIHRob3VnaHQgdGhlcmUgd2VyZSBtdWx0aXBsZSBORlN2MyBz
ZXJ2ZXIgdGFyZ2V0cyBpbiBwbGF5Lg0KPiA+Pg0KPiA+PiBJZiB0aGUgbG9hZCBiYWxhbmNlciBp
cyBtYWtpbmcgdGhlbSBsb29rIGxpa2UgYSBzaW5nbGUgSVAgYWRkcmVzcywNCj4gPj4gdGhlbiB0
YWtlIGl0IG91dCBvZiB0aGUgZXF1YXRpb246IGV4cG9zZSBhbGwgdGhlIE5GU3YzIHNlcnZlcnMg
dG8NCj4gPj4gdGhlIGNsaWVudHMgYW5kIGxldCB0aGUgTURTIGRpcmVjdCBvcGVyYXRpb25zIHRv
IGVhY2ggZGF0YSBzZXJ2ZXIuDQo+ID4+DQo+ID4+IEFJVUkgdGhpcyBpcyB0aGUgYXBwcm9hY2gg
KHdpdGhvdXQgdGhlIHVzZSBvZiBORlN2MykgdGFrZW4gYnkNCj4gPj4gTmV0QXBwIG5leHQgZ2Vu
ZXJhdGlvbiBjbHVzdGVycy4NCj4gPg0KPiA+IFllYWgsIGlmIGNvdWxkIGhhdmUgY2xpZW50cyBh
Y2Nlc3MgYWxsIHRoZSBORlN2MyBzZXJ2ZXJzIHRoZW4gSSBhZ3JlZSwgcE5GUw0KPiA+IHdvdWxk
IGJlIGEgdmlhYmxlIG9wdGlvbi4gVW5mb3J0dW5hdGVseSB0aGF0J3Mgbm90IGFuIG9wdGlvbiBp
biB0aGlzIGNhc2UuIFRoZQ0KPiA+IGNsdXN0ZXIgaGFzIDEwMCdzIG9mIG5vZGVzIGFuZCBpdCdz
IG5vdCBhbiBvbi1wcmVtIHNlcnZlciwgYnV0IGEgY2xvdWQgc2VydmljZSwNCj4gPiBzbyB0aGUg
c2ltcGxpY2l0eSBvZiB0aGUgc2luZ2xlIExCIFZJUCBpcyBjcml0aWNhbC4NCj4gDQo+IFRoZSBj
bGllbnRzIG1vdW50IG9ubHkgdGhlIE1EUy4gVGhlIE1EUyBwcm92aWRlcyB0aGUgRFMgYWRkcmVz
c2VzLCB0aGV5IGFyZQ0KPiBub3QgZXhwb3NlZCB0byBjbGllbnQgYWRtaW5pc3RyYXRvcnMuIElm
IHRoZSBNRFMgYWRvcHRzIHRoZSBsb2FkIGJhbGFuY2VyJ3MgSVANCj4gYWRkcmVzcywgdGhlbiB0
aGUgY2xpZW50cyB3b3VsZCBzaW1wbHkgbW91bnQgdGhhdCBzYW1lIHNlcnZlciBhZGRyZXNzIHVz
aW5nDQo+IE5GU3Y0LjEuDQoNCkkgdW5kZXJzdGFuZC9hZ3JlZSB3aXRoIHRoZSAiY2xpZW50IG1v
dW50cyB0aGUgc2luZ2xlIE1EUyBJUCIgcGFydC4gV2hhdCBJIG1lYW50IA0KYnkgInNpbXBsaWNp
dHkgb2YgdGhlIHNpbmdsZSBMQiBWSVAiIGlzIHRvIG5vdCBoYXZpbmcgdG8gaGF2ZSBzbyBtYW55
IHJvdXRhYmxlIA0KSVAgYWRkcmVzc2VzLCBzaW5jZSB0aGUgY2xpZW50cyBjb3VsZCBiZSBvbiBh
ICh2ZXJ5KSBkaWZmZXJlbnQgbmV0d29yayB0aGFuIHRoZSANCnN0b3JhZ2UgY2x1c3RlciB0aGV5
IGFyZSBhY2Nlc3NpbmcsIGV2ZW4gdGhvdWdoIGNsaWVudCBhZG1pbnMgd2lsbCBub3QgZGVhbCB3
aXRoDQp0aG9zZSBhZGRyZXNzZXMgdGhlbXNlbHZlcywgYXMgeW91IG1lbnRpb24uDQoNCj4gDQo+
IFRoZSBvdGhlciBhbHRlcm5hdGl2ZSBpcyB0byBtYWtlIHRoZSBsb2FkIGJhbGFuY2VyIHNuaWZm
IHRoZSBGSCBmcm9tIGVhY2gNCj4gTkZTIHJlcXVlc3QgYW5kIGRpcmVjdCBpdCB0byBhIGNvbnNp
c3RlbnQgTkZTdjMgRFMuIEkgc3RpbGwgcHJlZmVyIHRoYXQNCj4gb3ZlciBhZGRpbmcgYSB2ZXJ5
IHNwZWNpYWwtY2FzZSBtb3VudCBvcHRpb24gdG8gdGhlIExpbnV4IGNsaWVudC4gQWdhaW4sDQo+
IHlvdSdkIGJlIGRlcGxveWluZyBhIGNvZGUgY2hhbmdlIGluIG9uZSBwbGFjZSwgdW5kZXIgeW91
ciBjb250cm9sLCBpbnN0ZWFkDQo+IG9mIG9uIDEwMCdzIG9mIGNsaWVudHMuDQoNClRoYXQgaXMg
b25lIG9wdGlvbiBidXQgdGhhdCBtYWtlcyBMQiBhcHBsaWNhdGlvbiBhd2FyZSBhbmQgcG90ZW50
aWFsbHkgbGVzcyANCnBlcmZvcm1hbnQuIEFwcHJlY2lhdGUgeW91ciBzdWdnZXN0aW9uLCB0aG91
Z2ghDQpJIHdhcyBob3BpbmcgdGhhdCBzdWNoIGEgY2xpZW50IHNpZGUgY2hhbmdlIGNvdWxkIGJl
IHVzZWZ1bCB0byBwb3NzaWJseSBtb3JlIA0KdXNlcnMgd2l0aCBzaW1pbGFyIHNldHVwcywgYWZ0
ZXIgYWxsIGZpbGUtPmNvbm5lY3Rpb24gYWZmaW5pdHkgZG9lc24ndCBzb3VuZCB0b28gDQphcmNh
bmUgYW5kIG9uZSBjYW4gdGhpbmsgb2YgYmVuZWZpdHMgb2Ygb25lIG5vZGUgcHJvY2Vzc2luZyBv
bmUgZmlsZS4gTm8/DQoNCj4gDQo+IA0KPiAtLQ0KPiBDaHVjayBMZXZlcg0KPiANCj4gDQoNCg==
