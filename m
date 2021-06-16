Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7982D3A9C72
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 15:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhFPNtX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 09:49:23 -0400
Received: from mail-bn8nam12on2107.outbound.protection.outlook.com ([40.107.237.107]:1792
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233621AbhFPNtV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Jun 2021 09:49:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8+rJGGp9naL4IFzo+Wb5PLdgP4gBMtABTDF3o+UUkOck3+b8HesGFYTcMo8HdVwsCNBMpjOHPYJPD+xzeMDH8h3YcxEArM4WvmHAxqihB4ieEjy/kdKK3eDua9ZfHjjXRqIUVDt2mJ7rZYyWsKXmPme0xpEDALBaTbBOdaYaCsIM6cWomABMrhJqb30yJqhM6kseNZUpk7dBfH3D/rfgGp0hUTSg5OggD1rVTIXE6fvB2AIFjqwlqRQDb9/wxoah5pcUvtNisuAKNa7c6ljKrZ2H9H+na0ZXApdrmJ0Bb/tX4xJF0m32Sm8GR/HxqpAwDUsvyGbmkk9kenz/E4UFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXdxP/rNZmTLtwyfM6r4Utjmn00PQ+lhdbxYXQJAwxU=;
 b=EnMee2W1Zw1SsyGijn/G/BgzMac++i11YDjVd4zGH8wEv0+h8p0VOWHOh8DVxSW8PDfge4dbI85my4dVxb7rNSXlzPfyRRvIVP7HUtWpMwXJSbaKF3H1QjXsqZLXjLj6Imv1dx0sMwW4Apjc5XgkdRUFFz3wwLCIp6W84qRCR+Gu23+MmUAbXaWjsNbEjQvuEmP/iOsEt46ob3fecu7JwGUa2kjcqzO0WEK2LbnAU9qhxpCA8XzouGYT8/m/BjPVwGowexX/udZ3q5B43V53OQrS09sywRIvTXoGwUItvOPSs2IN13wHOG1NhUICLJOemfRMvsUOoDYf8ddnsVShBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXdxP/rNZmTLtwyfM6r4Utjmn00PQ+lhdbxYXQJAwxU=;
 b=Zvb2aF19ZyxJToAaGSRhg1Cz+B+AnbjN3VdOA45O3xyTjHMW67q1qesCi+RRlYaMlX+b4xp+ki+kLNFUkZHTME455dF+1OtMz8T2LGvRR7Flu/NzzZOMvdsYo1B6+twSZG5+RhhfG4KeGCY0NWaModlcPkykRoNWwhGrUOhAEMM=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB3866.namprd13.prod.outlook.com (2603:10b6:5:241::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.12; Wed, 16 Jun
 2021 13:47:13 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4242.018; Wed, 16 Jun 2021
 13:47:13 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>
CC:     "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: set block size according to pnfs_blksize first
Thread-Topic: [PATCH] nfs: set block size according to pnfs_blksize first
Thread-Index: AQHXYq1gTBPriIHjLEyaSjnxbRPdFqsWptwA
Date:   Wed, 16 Jun 2021 13:47:13 +0000
Message-ID: <4898aa11dc26396c13bbc3d8bf18c13efe4d513a.camel@hammerspace.com>
References: <1623847469-150122-1-git-send-email-hsiangkao@linux.alibaba.com>
In-Reply-To: <1623847469-150122-1-git-send-email-hsiangkao@linux.alibaba.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a7b39d1-b5f1-4ac2-65af-08d930cd3f37
x-ms-traffictypediagnostic: DM6PR13MB3866:
x-microsoft-antispam-prvs: <DM6PR13MB3866AA3E0193A5E30148AB38B80F9@DM6PR13MB3866.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oOd7m5hnPfH0hvln07p9wss54ElC+bWsi0Q/SdMTImUsiG+QpzENbbFxJurmLuoKei/Lr86OsEsg1HmSIuyehOmNZWVz/xdJiwXF7iUMLRXVHzt/xS3qftxK0zTSaAuizOSwEf4f2t6XTc9gdKLCFD9AmAlpBFY4htt4SVoM6qdLe9zyKvvsSVkAoUuR9Bmc4bfGZPv7aEcjn95q8B1TJUnxXAOQXJC9huDki/H5P33tBEtQhZ5HkEQGrjtP3gidbSMoNTFSt+l/U7wUAkKkYmIx5l+tqZ21NpFVMtggAxNDh6IKPyQolZXnltAbrcJw//FeFHO+5YmmMmiy8KFglzSaBPMsGl5yxm4AbOGNc5W0OqNRt6Mbp4vFhKF5GikOXoStrTtnR0hIREpuJLxZt0doypQZ+5IT/Nv7zX/nBi9s8BHsBH0yUro2tF+nCjRgiSkjO6/4y/SBRvwohb1b/EnqiTzYpJx4q8XW+bGiwT5VlBGkvYs82T5QX2xQfdcpPO3ZREqSuf44TNAnfBEhM37ItwN2/g1VWAQd/+DPM+LQ17KIHlXAfGRIhwmCZwyYKITrROyKL2pQaTK9TIfU9mZUINS0z7ngrKW6yP99NH6bqrn+qtoudM/DLBCNethIHaRZg8IFlxF9RD613XOxZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(136003)(346002)(376002)(396003)(6512007)(6486002)(122000001)(38100700002)(478600001)(26005)(8936002)(6506007)(2906002)(8676002)(36756003)(83380400001)(316002)(66556008)(66446008)(66476007)(110136005)(86362001)(4326008)(71200400001)(66946007)(76116006)(91956017)(64756008)(2616005)(5660300002)(186003)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGkrbEdwanhOdHZqd0grYUhHb3RWbzgzVmdMcytMc01lbFVWN2l2OUpjQUpM?=
 =?utf-8?B?SzRxQkNKNWx6bWpkR0tjZkJGaG1kTE5oNDNhTkJ5MnN2dW9lK3R0SDNJWndG?=
 =?utf-8?B?SXF6KzlTZDNTWEtHcGZjcm9ETmtCVXBPMTBQRyt5aGYrZVNvZWxTU1AxQ295?=
 =?utf-8?B?NHZuajM2ZWtVVk5mTTBrMitKZFlEQ1A4eE11ZkJna1RQckZpQkRaYlovbTZ5?=
 =?utf-8?B?NjAyRUlpdk1YZFRzTHdiZmV6MDJhQnhwaXpydm51ZzFuZTVhZnhwQmxQYWVB?=
 =?utf-8?B?aWNmaG1zNWZEcG5lblQyaXNXaTJvbU11eVlVN0h0dWtHRXJuakdCQlFPTnhC?=
 =?utf-8?B?TjhCcFUzVU1XcXE1Sk16UGZ2N2tFOTk3MzVOR3FnVmN4WUZEZjY2ZzRTcG1m?=
 =?utf-8?B?ZTIyNUtIdWVMaUpaYlJaN0JyZHhjdWowWjYycStvSW4zQk9CUFNNSkhQWjdK?=
 =?utf-8?B?RTVPMVVlcTNLeTkzNGZoWk9DYjFXeVRNeWRtOHQvYVphcVFZUDRZek83SFlV?=
 =?utf-8?B?RmRhSlVNeHhTdi9JS2xqNDNoYk8rejliMWlsU21pQ2dEZ2VoTVRHc0FvSmdG?=
 =?utf-8?B?Njg2TmR5QnhrRTEzRmkwcW92eDd3NjNZZEhPVi81TVhwNE5CeXJvbkVhVXdL?=
 =?utf-8?B?N1JOUDBMWXRUakhQZHNJaS91aFA0UFRvZEpzcXhnRFdFRnIxYVVQV2dXQlVK?=
 =?utf-8?B?SmlHdWlra1IvRG9EcnRZaHBIZGovSjhDK3pBbDg0YlRuM3RjV08xUW5Jb09R?=
 =?utf-8?B?ZXdVUTVCRGl4ZlFseTRoRVdkcENZRk42aCtpTWxlQzhXSFBPcDlyOGdsVTNV?=
 =?utf-8?B?dDFySStWRmdsMG14Y3BkNzllY2VhdXByM0MrQkpDZ0psdFVVY3VBU2lQWjhK?=
 =?utf-8?B?VmJ0R1RqSVlYVi9xSzQvcjlhaG1heXNCUnFyUS9mSTJkN2QzM1JJWFdsN0ZB?=
 =?utf-8?B?UmRNYlQzWnZkaG93Y29scklsb0k1a21FQ0d4Q0dZcnEvdmFBaGE3RkRkcnZ2?=
 =?utf-8?B?dnBQbHBUK1dyM284ZEhGNzhtSnY1ZGdnYitxek41dnBnWUQzTUQySG9Ca0cy?=
 =?utf-8?B?QzgrTkdxV2N4SXdSWjZ5QjY5VkJiVGlBdjA3TjZSMzBiUUR6a0dHWUlPc2NV?=
 =?utf-8?B?QnIvODdtRU1yTGljTk1PbkI4MGpVMU9ha1lKZ20vY1VSaGduYk8ra0pubEg5?=
 =?utf-8?B?UkI4eFFLaGN6Q2IvTjdGR09vYmNMUk9NaUc1WlJUZTNKVWRVVmtVZ0dadXZ3?=
 =?utf-8?B?TkswZ2tXeUdSMEhhQU1Edjd3S1ZwZmtKaWlmL3dnWTIzNFZkWmNkcjFTN2pJ?=
 =?utf-8?B?bklZSnUrOTIrQmRuWTl0VllCclV1cXVtem1mTlFJUVpyRlc2NDZzVWFRR3cr?=
 =?utf-8?B?aWRjVXc1M1A5U1VsWEJkaWlHT1d0QjQ3RzkyRHFwcVhsUllycGc2Tkp2OGp0?=
 =?utf-8?B?RkVuNjZDWDQyNENvRUZQK1FIVDBscFJkV0l4NFlQR0FQNDVhT3U4bWEyZ3F2?=
 =?utf-8?B?YVJ0NUlTYU52VkJEczdHYWdHZDYxN0NTVm4zTnBoYmRuSHJES0g3a2E3Misz?=
 =?utf-8?B?cVFScDRQdWlyWitsSnZmMWhRODZwcG13dkN6ZU0yNk5YT3FMZ1ZJWEdubGo0?=
 =?utf-8?B?WXkxNC85bEo1WG01cmU4Rlg1K3RwbFJydm45M2V3RFc3c2JNWTJOQzZMVEZR?=
 =?utf-8?B?dy9ueCtVRG1OblFOSXlCd2hRalkzQlA2eWZla0lHT1VhYjRYejB2eE9CS2tJ?=
 =?utf-8?Q?c5ghD5TyUhogfalNJVLjsZAvpEhgSXS73gd7yLX?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0660B29719EFBC448FCAE78CC9D4A856@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7b39d1-b5f1-4ac2-65af-08d930cd3f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 13:47:13.5206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35ceTxzaPdUy1o7xPs+5j8vIkG7hR3wp6lIbjvUkxhfmbp6v+L2tZAiwawx3nj2LA9qyy6eIme7l0XHADfPXzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3866
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTE2IGF0IDIwOjQ0ICswODAwLCBHYW8gWGlhbmcgd3JvdGU6DQo+IFdo
ZW4gdGVzdGluZyBmc3Rlc3RzIHdpdGggZXh0NCBvdmVyIG5mcyA0LjIsIEkgZm91bmQgZ2VuZXJp
Yy80ODYNCj4gZmFpbGVkLiBUaGUgcm9vdCBjYXVzZSBpcyB0aGF0IHRoZSBsZW5ndGggb2YgaXRz
IHhhdHRyIHZhbHVlIGlzDQo+IMKgIG1pbihzdF9ibGtzaXplICogMyAvIDQsIFhBVFRSX1NJWkVf
TUFYKQ0KPiANCj4gd2hpY2ggaXMgNDA5NiAqIDMgLyA0ID0gMzA3MiBmb3IgdW5kZXJsYXlmcyBl
eHQ0IHJhdGhlciB0aGFuDQo+IFhBVFRSX1NJWkVfTUFYID0gNjU1MzYgZm9yIG5mcyBzaW5jZSB0
aGUgYmxvY2sgc2l6ZSB3b3VsZCBiZSB3c2l6ZQ0KPiAoPTEzMTA3MikgaWYgYnNpemUgaXMgbm90
IHNwZWNpZmllZC4NCj4gDQo+IExldCdzIHVzZSBwbmZzX2Jsa3NpemUgZmlyc3QgaW5zdGVhZCBv
ZiB1c2luZyB3c2l6ZSBkaXJlY3RseSBpZg0KPiBic2l6ZSBpc24ndCBzcGVjaWZpZWQuIEFuZCB0
aGUgdGVzdGNhc2UgaXRzZWxmIGNhbiBwYXNzIG5vdy4NCj4gDQo+IENjOiBUcm9uZCBNeWtsZWJ1
c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+IENjOiBBbm5hIFNjaHVtYWtl
ciA8YW5uYS5zY2h1bWFrZXJAbmV0YXBwLmNvbT4NCj4gQ2M6IEpvc2VwaCBRaSA8am9zZXBoLnFp
QGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBHYW8gWGlhbmcgPGhzaWFuZ2th
b0BsaW51eC5hbGliYWJhLmNvbT4NCj4gLS0tDQo+IENvbnNpZGVyaW5nIGJzaXplIGlzIG5vdCBz
cGVjaWZpZWQsIHdlIG1pZ2h0IHVzZSBwbmZzX2Jsa3NpemUNCj4gZGlyZWN0bHkgZmlyc3QgcmF0
aGVyIHRoYW4gd3NpemUuDQo+IA0KPiDCoGZzL25mcy9zdXBlci5jIHwgOCArKysrKystLQ0KPiDC
oDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZnMvbmZzL3N1cGVyLmMgYi9mcy9uZnMvc3VwZXIuYw0KPiBpbmRleCBmZTU4
NTI1Y2ZlZDQuLjUwMTVlZGYwY2Q5YSAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL3N1cGVyLmMNCj4g
KysrIGIvZnMvbmZzL3N1cGVyLmMNCj4gQEAgLTEwNjgsOSArMTA2OCwxMyBAQCBzdGF0aWMgdm9p
ZCBuZnNfZmlsbF9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sNCj4gKnNiLCBzdHJ1Y3QgbmZzX2Zz
X2NvbnRleHQgKmN0eCkNCj4gwqDCoMKgwqDCoMKgwqDCoHNucHJpbnRmKHNiLT5zX2lkLCBzaXpl
b2Yoc2ItPnNfaWQpLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiJXU6JXUi
LCBNQUpPUihzYi0+c19kZXYpLCBNSU5PUihzYi0+c19kZXYpKTsNCj4gwqANCj4gLcKgwqDCoMKg
wqDCoMKgaWYgKHNiLT5zX2Jsb2Nrc2l6ZSA9PSAwKQ0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgc2ItPnNfYmxvY2tzaXplID0gbmZzX2Jsb2NrX2JpdHMoc2VydmVyLT53c2l6ZSwN
Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHNiLT5zX2Jsb2Nrc2l6ZSA9PSAwKSB7DQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgYmxrc2l6ZSA9IHNlcnZlci0+cG5m
c19ibGtzaXplID8NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBzZXJ2ZXItPnBuZnNfYmxrc2l6ZSA6IHNlcnZlci0+d3NpemU7DQoNCk5BQ0suIFRoZSBw
bmZzIGJsb2NrIHNpemUgaXMgYSBsYXlvdXQgZHJpdmVyLXNwZWNpZmljIHF1YW50aXR5LCBhbmQN
CnNob3VsZCBub3QgYmUgdXNlZCB0byBzdWJzdGl0dXRlIGZvciB0aGUgc2VydmVyLWFkdmVydGlz
ZWQgYmxvY2sgc2l6ZS4NCkl0IG9ubHkgYXBwbGllcyB0byBJL08gX2lmXyB0aGUgY2xpZW50IGlz
IGhvbGRpbmcgYSBsYXlvdXQgZm9yIGENCnNwZWNpZmljIGZpbGUgYW5kIGlzIHVzaW5nIHBORlMg
dG8gZG8gSS9PIHRvIHRoYXQgZmlsZS4NCg0KSXQgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCB4YXR0
cnMgYXQgYWxsLg0KDQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNiLT5z
X2Jsb2Nrc2l6ZSA9IG5mc19ibG9ja19iaXRzKGJsa3NpemUsDQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmc2ItDQo+ID5zX2Jsb2Nrc2l6ZV9iaXRzKTsNCj4gK8Kg
wqDCoMKgwqDCoMKgfQ0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgbmZzX3N1cGVyX3NldF9tYXhi
eXRlcyhzYiwgc2VydmVyLT5tYXhmaWxlc2l6ZSk7DQo+IMKgwqDCoMKgwqDCoMKgwqBzZXJ2ZXIt
Pmhhc19zZWNfbW50X29wdHMgPSBjdHgtPmhhc19zZWNfbW50X29wdHM7DQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
