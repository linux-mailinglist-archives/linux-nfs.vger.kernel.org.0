Return-Path: <linux-nfs+bounces-2213-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 710B48722CB
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 16:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293EF284746
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB261272C3;
	Tue,  5 Mar 2024 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="CU82MlrQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169318613F
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652514; cv=fail; b=SKJH9xxdevNdOcxBaTydKYx2W2FpBMEH1RdY0sqpDNsDfRoWvwypo4xWoTr62q9tVuoxEYemcPc3NnXTAlfhR8g1B3w8Xk4yvzET6lRcBOWkmBjkA+pIxKH1/V7WQvzq5xi4TXD1YiK4IOaDawv1E6YkNHeXOpKfL9YHlMmzK7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652514; c=relaxed/simple;
	bh=p6ssJ4Q88EUddj2I2fOhitPEHXkROZlNNHjJMJQwd+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S0MKhztAeHtS1vMHaYt5EOztomZOts47QM/E35l3BGOif9W2uIvxyW79AWjRa37HrD8BYySc+76I6ri6Wh74iVLxcTNuQaT7CUzG+CHPiaJvLnQxQm8U6FZXj4Jsg4Oze+eK0fwXEkmMuitWVJQ4ESm7hyMdKoT2832INXfH04k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=CU82MlrQ; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gqc7XnQ6upVLxD5FxKkMdLXHql2AXq5gNlbsixRgD3ctoX64zyeCgxnlmu/7w42zIk/3VQX1OMB5pac/JflHlXxI+UZvQ9lshqtrKePbG9K5W80fKdr4Z/QvQUio5CxNYIm6DvNN6qaH3SPCVSseVhZjjnKzAMYQnlOEsAqJRAFlEVFJoe62XLDThJ0tb3JTRs4YWuEVE0YJi3gwsnijypUUhz261a98YL4sOesHn5U9bTF2RHJYWRzVtCKZXIZLTnknoKjFBKKZSNEQ5XDuu1bsi5EiYF9yAy6EAkuGg1zorqHVCF0KdDNMg+EdHQJtkD7UEaCp63d4HzXpxNtt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6ssJ4Q88EUddj2I2fOhitPEHXkROZlNNHjJMJQwd+M=;
 b=IlNcAwqwo7WhVRjIw7uUCoiIO6f2uEDGEyR2w2GN6uq4IC+0/deLxm8gi4XVvJL/B0s70OFaNQxqx8SauT6WObrQHYukdjKuSVO1Aorj4FMLc8tc9LyIiaEVlymEykYoT9p5nXdqAeq/S5Qz0fuswhO+uqIFOVEBsKDw1FAxUMJ/9/ea3jFrTkl7JYt9zef8te+Nye9awoQX8RAO9H1Kco3MJyxgpsFvBapRTnANETMaG9kiDMwc9eW25GvVseR2+CBrfUGA397g+9PgtnebggwQwbRvD7z09OtaczimKFW8EyCm59PuAWFF2ojmqMZqUZI8+Mm5u9htYC/B5aiHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6ssJ4Q88EUddj2I2fOhitPEHXkROZlNNHjJMJQwd+M=;
 b=CU82MlrQgjQHn78TRVpqb0ph6heMxyLLY8PfvQWG+c9ENnc9yIg+40ou9o/C01YXOtN0vlT5NQrUuISiJowaChtFL9LbB1T5MIp5swiFfKFExrZYaSWMFJwyi5YeEuOy9g1OrHxHuaiq8VliD9uceT8ynOv062do+1w0jAckEtU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY1PR13MB6311.namprd13.prod.outlook.com (2603:10b6:a03:531::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 15:28:29 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:28:29 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "chenhx.fnst@fujitsu.com"
	<chenhx.fnst@fujitsu.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH] NFS: add a tracepoint for uniquifier of fscache
Thread-Topic: [PATCH] NFS: add a tracepoint for uniquifier of fscache
Thread-Index: AQHabq8JeeqTXYljjkWTOBegvkPcB7EpRiwA
Date: Tue, 5 Mar 2024 15:28:29 +0000
Message-ID: <4fecefc561df655aefeb68cf716cb3eb0fd2f011.camel@hammerspace.com>
References: <20240305034122.172-1-chenhx.fnst@fujitsu.com>
In-Reply-To: <20240305034122.172-1-chenhx.fnst@fujitsu.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY1PR13MB6311:EE_
x-ms-office365-filtering-correlation-id: bed1557c-6d10-4791-7fa9-08dc3d28e904
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aqmYRJixd8Y+TQPdjsuCbuHPwrJrGwbYfs2UZouDpBJFY86xp75hJBbUBkDvsw6927MqPmVfCRfJuFgo6GsDATu0KTIONBOUYArlyFHB2OyJI22LWLgbBlTvIdKt57wLvrPfZygoRNJpPfGGq3RR8ZK9/jC29bph2u2sS6yZ0oKjzWqZ0a7xByyO4DmHHILN6q5JD0ZRekOoHhczGJQI52gmz7I9U8H5PebetHkFYpTPACbDjgwEIXruPsZRZfmBnHuY2/25HzJy4NlfkefNwHWQohLGrAVtDYo58Mew5lkztLbYfvZKcnIjtZ0NGvdkbUVVv0KyvlYzbL6tn5eTXWOXiMUk0i/n8p5G35HwFIvyqLZo3rS/zv2ouBoh6T5RQGLI/lphLZD7pMAK50dTYJXM/4VGD8NhKupoLna3Ngh5umPX61fu0Ui7gvOyAsAraIk8g9Ha8Na8jYyIlXhNWJ+/+NhzCT067os2R+U0SkiRLLYnv7mgdG4dmVnReHBo79rNUpIYKhdG8+AO4amjlWz7cRdeEk/yb+IatHrd7/LT2bemzWDIilqfnjk1gnxgjUKpMtWhxNA4uNd2/6+bQ4Ay5HBUaFEJAkeCnB0fMpJW4eWTzltI+AavbR2C6joC5jtLFn8Y5VzLnrNWmu0yzaLkY6fIusvk0v8UFka4kvDFdO9ekQqqA53pUjN8O64q+BJ8zVU0V7gH+V3evCk9TA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEpOZnhqTElFU1JROWxmenp1K2hzRGlrUXh0OEl5WUkyZjdTOE41V05QLzV3?=
 =?utf-8?B?cnR5ZGxXU0RUQVR4dFRYYTFjVFJSSGFBQ2dPS3c4ODlkb2MxejFKNlVCQXdF?=
 =?utf-8?B?K2Nkc0NtYWw4T3RNelV3TjVqZFlCSlo3Rmord05sdWRySXd4ckhXako3VW8y?=
 =?utf-8?B?OTBlbXV6Y3hBMDhHRUZ5WGRlOGhxWWdSNnNiSHpYWWN3dDV0MDhuNGRrekI0?=
 =?utf-8?B?T3ZDTFpnOG9TSFJPMUI2TC9ENzkzTzVNbkYzWVVlZVpqT1JpY2Fmek5sMXpP?=
 =?utf-8?B?RUo1UjB2U2daVjBCcVlCd0FBRVFTRURMR2NGVEowY0U5QzVSaVNiYXN2V0Fp?=
 =?utf-8?B?LzYzMFlCbnFuSSsyWlZZd242QllxSW1LUEJmWEV0dVhYL01KNzB2RHlPTVZZ?=
 =?utf-8?B?RnM2Y2s0TzhLSllaZ05waWFBenRGSlNwcXRxYzF5cE1iRzZoZzUwc1VpSWV2?=
 =?utf-8?B?SDZlaE1wNjhlNFNSQksrZGFXUjYxMUw0RTNsWTRwRmpaVzJVNkF4S2M2ZUpD?=
 =?utf-8?B?UzlCd3Fjb3Q1TE5raWtDejJHVmJRNEJGOFp1dFRXSExtcVdTUFFlZU5CbXND?=
 =?utf-8?B?Z1NWMXM2SWVyUG4reW5rdUZtc1ZYOXk2OTZnTGZhRkRBem80WW5aamNNcXVx?=
 =?utf-8?B?K0NiSXdsUlV5K0M2dUVuY01IOXV4ajNTNUkxWVZTN09sandRcktncGJRbzAv?=
 =?utf-8?B?OFNuS3IvT0RTTFQ1bmsyekVuaDBxKzFxM3RBRk41dFFTVkQ3N3pGdVR2d2VD?=
 =?utf-8?B?Mm5aUmd4MnpyVjdGeGZVNzJxTUdYd3pIM3VLMDRqU3pUUUdBWTlCeHZMTnB1?=
 =?utf-8?B?aUh0QWZoTnd2OU5lcHE5TmpoTVhHbFNnS1ozWUtOU2VCb0p4ei83TTZTVDJt?=
 =?utf-8?B?a1NLa2g3U2ttVHo5MWkrakhoN0xjMVRsa0g0VW5WWVFLaTk1NDNqWXYyS0kr?=
 =?utf-8?B?TFlEQVBTUWF0dk5Zc3ZGQlNDNjFoT0hzYkljZzl4eXFHaXBYbHNxR3FMc0dn?=
 =?utf-8?B?U0p0eDZVNEkrUHBoMjhOVCtTVDhGWUxCY3pxc0U3ZGV5UnVhdXBTanI4ZE5V?=
 =?utf-8?B?R0pxREpoRzRUWWpoK3l6NzhwSVkzUzMzK21yUWNFNTY4UWRNQTYyZXpOS0tz?=
 =?utf-8?B?dVhFNGtjZGJPRUsxV1c4TVlqUmF0TXRXYVFncFpFVWlvTDg1R29IUm5RMkxh?=
 =?utf-8?B?bFdlMTFkRTlVTXhSSzhLZjV5ZFBEQnVkb2tQYk1UaExjay9uOWZDTWdrTCt5?=
 =?utf-8?B?NUhuZGRpaWNGMzQrZDVXVko0QmpLZUNGOXlTeVhxMkdUZFlHZGNKaUtzYzFm?=
 =?utf-8?B?YUJqZjVEaTBFL2FGUzlxVFQyaGcySkMrS25Ic0RGbFNrSkYxTlo5Tk9aYUZU?=
 =?utf-8?B?cUdzeUdNVGEwakNEM3g1L254REhqcW5QbVE2ajJaeFMwT2tlMUVvNWZmbkZl?=
 =?utf-8?B?ZzFDblVvVnl0Vkt2K3VpUGo0U1lGUWtUdXRaY0o3MFpaK2FpVE4xWTRBUXhU?=
 =?utf-8?B?UmYrNnVQOUtVYnA4RmdUMFdPOVFjdmxwSTNBK2R6YUV0S3ZJSVpQd1pHdzNK?=
 =?utf-8?B?Z2VEMGJ3Q045NzEwV1VuaHAvU3NESWgvZXBoVy9BbFcrbmlXSS91ak9NcEVl?=
 =?utf-8?B?dzVXUWllL0JEcjluUDV4cEZBMGdBMzlDZG9OeDNSM3RYbUxRM2FFYkVLR1pm?=
 =?utf-8?B?Ky9lQWdEV0NqNFI1YVZiZ3YwMXA0dEFOZExoOGFWL1VIeUt0NGM5RzB4R0Zw?=
 =?utf-8?B?UUtodlRaekZZZ1JOWFEyK1lzUXV4eUkzSExVVTNlZHFHdFEveStSdFEzVlZk?=
 =?utf-8?B?QWljcStSU0VFalU4dWxCMnprbHZjSTBwSkVUZ2JNOWhhU0ZJeEtORFJyT2N6?=
 =?utf-8?B?emQwUU5VMXo3OTNUN250QXBFdlpmNmJEZGFIY005TjloQysxcnZYbTNGdmNa?=
 =?utf-8?B?VE9Vb0ozSmhBNVZlK3UyTFNBMlg2NjVkVW9WdzU4bVptK2tVN05zdTdsd2ZK?=
 =?utf-8?B?WUsvWnVNSWt3OE96VmZzL2gyU2R0YUd6TjIxN0Q1cEt3clp5N09WVStmL0hQ?=
 =?utf-8?B?emRKeTRIMFUvcnN4YkxNUzAwWWxqZjFMd0NPUEprY0FRWjdxbCs0dkQxRStT?=
 =?utf-8?B?akxCb2hYZXlpdCtmb0hmaFh6QlZRdHFyRGNjWElLM25na2NhQm1ueW9rTjdm?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76C27BD59943294C8ED618FCC09D9E0D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed1557c-6d10-4791-7fa9-08dc3d28e904
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 15:28:29.7102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WuYxkktFNQesIQ7hsbL+EzyUWEnQ2vh/scMiiEEyEKKE8xYYCZ/2lQ+3GLGv0otPHG9v8nnJdCZfzUOpjCtnjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6311

T24gVHVlLCAyMDI0LTAzLTA1IGF0IDExOjQxICswODAwLCBDaGVuIEhhbnhpYW8gd3JvdGU6Cj4g
W1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBjaGVuaHguZm5zdEBmdWppdHN1LmNvbS4g
TGVhcm4gd2h5Cj4gdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91
dFNlbmRlcklkZW50aWZpY2F0aW9uwqBdCj4gCj4gQWRkIGEgdHJhY2Vwb2ludCB0byB0aGUgbW91
bnQgZnNjPXh4eCBvcHRpb24KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaGVuIEhhbnhpYW8gPGNoZW5o
eC5mbnN0QGZ1aml0c3UuY29tPgo+IC0tLQo+IMKgZnMvbmZzL2ZzX2NvbnRleHQuYyB8IDMgKysr
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2Zz
L25mcy9mc19jb250ZXh0LmMgYi9mcy9uZnMvZnNfY29udGV4dC5jCj4gaW5kZXggODUzZThkNjA5
YmIzLi5mZDg4MTMyMjJjZDIgMTAwNjQ0Cj4gLS0tIGEvZnMvbmZzL2ZzX2NvbnRleHQuYwo+ICsr
KyBiL2ZzL25mcy9mc19jb250ZXh0LmMKPiBAQCAtNjUyLDYgKzY1Miw5IEBAIHN0YXRpYyBpbnQg
bmZzX2ZzX2NvbnRleHRfcGFyc2VfcGFyYW0oc3RydWN0Cj4gZnNfY29udGV4dCAqZmMsCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN0eC0+ZnNjYWNoZV91bmlxID0gTlVMTDsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gwqDCoMKgwqDCoMKgwqAgY2Fz
ZSBPcHRfZnNjYWNoZToKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXBhcmFt
LT5zdHJpbmcpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGdvdG8gb3V0X2ludmFsaWRfdmFsdWU7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dHJhY2VfbmZzX21vdW50X2Fzc2lnbihwYXJhbS0+a2V5LCBwYXJhbS0+c3RyaW5nKTsKClRoZSBk
ZXNjcmlwdGlvbiBkb2VzIG5vdCBtYXRjaCB0aGUgY29udGVudHMgb2YgdGhlIHBhdGNoLiBXaHkg
d291bGQgd2UKbmVlZCB0aGF0IGV4dHJhIGNoZWNrIG9uIHRvcCBvZiB0aGUgb25lcyBtYWRlIGJ5
IGZzX3BhcmFtX2lzX3N0cmluZygpPwoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y3R4LT5vcHRpb25zIHw9IE5GU19PUFRJT05fRlNDQUNIRTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAga2ZyZWUoY3R4LT5mc2NhY2hlX3VuaXEpOwo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjdHgtPmZzY2FjaGVfdW5pcSA9IHBhcmFtLT5zdHJpbmc7Cj4gLS0KPiAy
LjM5LjEKPiAKCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK

