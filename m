Return-Path: <linux-nfs+bounces-3855-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D61909985
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jun 2024 20:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C746282C9E
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jun 2024 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4561DA22;
	Sat, 15 Jun 2024 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tru4CS4u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ogqEataD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4435C1870
	for <linux-nfs@vger.kernel.org>; Sat, 15 Jun 2024 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718474974; cv=fail; b=V3cgZ0txk3iv6opRsA/5aMpfhhrMTIlt1V5r+RZ0eNrcoBwzqT6LqAFF/mycsNkAlHgpCTZZYJFXgfB9aaTR7GzkkBKE7ymYoNyUYv7CE5QqNyWsnHHAEjIdtHwMDEG03iYc76m1VJRNteEtHfh7x+otP7O58Dg3sVdV5ba6GBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718474974; c=relaxed/simple;
	bh=58dvvkWUQCB/pAGcgxrCY1ITcDP4NESzYom7F51DFWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qP+MtEqrUQMlK0uoFFR0VxTgrcTcDUlUin32peFCL2XZPnezT0EeNQ0SFjHwKadRp4jywVTjF1tQbJOtCZxZ0Gd/YIoRw8ZIauNR9S46HMhilQb6hn8qLP3g5w0aLnApZAx14Iuahk35bq/0OYkwjIzSopnTgbOf4i8l/VitbK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tru4CS4u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ogqEataD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45FHDeqH003685;
	Sat, 15 Jun 2024 18:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=58dvvkWUQCB/pAGcgxrCY1ITcDP4NESzYom7F51DF
	WE=; b=Tru4CS4uvMHeGohBa9nFlcjl0Bx4eZmKJrvioT1ywM7rOqG5Usx6MErsX
	IpUE+55VdiEyEDzOrwUZZFtYbUb/3eGQN1rYEkZZ7VD4XMad95UG47lAG3mqAKp/
	AOc4TWhC2uHvAu4Bzjjfvh23SSs/Ekh0R9qDg2mg/E7ePE+Iw0iYhFNChuisjcn+
	OQHMh/SfFz2JtQBsdVvY/7gcLw8ifvDMqKzkJHPs24inLw85u8C1EqjR7yD+exq6
	5BHyg3AJSWe/lkyqy4Y+Yk64QwrkynpynEX04VW02i81WC5GM9HcRr8eyibpIqNb
	mgH40z9weyMzUAy5IdMsJ4dIqGOGw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1r1rk35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Jun 2024 18:09:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45FE2XeG034587;
	Sat, 15 Jun 2024 18:09:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dbg5fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Jun 2024 18:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkhYaL74JlXrcgNGJlvM62ILao3asXGpupdWTWSZYxJpz886eOSzFV8SzACDIfKRksUUrt8rPY+qWVNTRnGVY3vasrotbuyuAn3r6pu7D6/MbMfXHEL59dvIWJr7WEDk1mAHEUThPOLyBtNPgzC6AYi0+BdveHbJfxngjOZIKASRbwPc2qItKTvMMMqd1n54bR5qreJx4qTlJ5qLXRIuRawy1UdAty/0EaMxPgg9KT6x0eb0peU48OCjn4UHDCfpa/CHSASR9wAtn2z/ulwQt2MhzhE9mzbX8c6i2dkv1gh5Uu/wBIVME8jm21zUFwft75c88rZ3uxVoXQmGqw/gJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58dvvkWUQCB/pAGcgxrCY1ITcDP4NESzYom7F51DFWE=;
 b=dWzOCf1R40g/BgN6gk/q5z0zEdiLBNMRlzr+/mjJbcOrDly/YwdEdN2ZOX+IZPLksz4PVqRJWlxGHOwUolj9m/jrsrwImGFH0/Q73D46vBGOtMz5To4lnVa4mbAtFirELJ5rIR1IP/E0CI/g3+9tBpeLpZr9+4BOSesWVSSrxkYE7h9CBVkw09AE70DFvAjOm8HWYxGntJkzWiFWL0nohTorj01uc28p0zvLmRDXTpSzyvPeTYSjyGA5H6eezr5xhalSPD7lOnb+EsC0GG7wby+0dQC/pUWZp2XeWIvtOaPljLS29S89pICtFfBj6a98j7akVGIQq6wwYN5pYwLoow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58dvvkWUQCB/pAGcgxrCY1ITcDP4NESzYom7F51DFWE=;
 b=ogqEataDUY4LUCmgcOsPFtKdHMEma8Qp9WHI5RFfYdiOyvKVXLIGRveKWw+6yRk2NmKuqDjojHABpA4NhodFOXxesXzu7NA0VZAd3z1IttrVOxpNUjKQwYEt+cT7R2HiGfucwuZ5sc9kKr9SSeIOoMgOOOmxjwXskW8ZdFuSR98=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Sat, 15 Jun
 2024 18:09:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7677.027; Sat, 15 Jun 2024
 18:09:20 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: reservation errors during fstests on pNFS block
Thread-Topic: reservation errors during fstests on pNFS block
Thread-Index: AQHavmmwJwrL3nOnBk+LjtpoM19XRLHHda8AgAAS+oCAAAs0gIAAAdcAgAGLtgA=
Date: Sat, 15 Jun 2024 18:09:20 +0000
Message-ID: <3B61FCDD-2684-4E5E-9790-2CEFDF69539D@oracle.com>
References: <34F83726-2A28-4E29-A40E-A01BED7744EC@oracle.com>
 <Zmxx-H2KrT5QpJ-g@infradead.org>
 <C02C8230-4ACA-4F2D-AC28-B9583ADCADA5@oracle.com>
 <ZmyLSZGWDeaIXdx4@infradead.org>
 <ED7EB3B3-F56A-451F-A639-D30BBA125EE6@oracle.com>
In-Reply-To: <ED7EB3B3-F56A-451F-A639-D30BBA125EE6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5550:EE_
x-ms-office365-filtering-correlation-id: 9486400d-adab-4def-acd9-08dc8d6647b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bHgvS1ptZ0RQbVZkWW0wbFU2bmo5a3FkNUVZZ2RibjBoZktwNnRZYTUrd3JS?=
 =?utf-8?B?ZTRDaEF4Mi9LYnExNkdaTlAySkZIVXMxVnJQdzNjNmxJSzFMSXdsYklGUWdM?=
 =?utf-8?B?WGtiRjV0aHNveUdnSWlKbGdNQ1doUWpOZ1B2dUV2VDNhTnFzUm1XSHVwekpU?=
 =?utf-8?B?dnp2OXBjN041QjR5Q2FQQ1RsRGpURFBLS2g0bm5KdjVOY1Yva2JjL3hUajBB?=
 =?utf-8?B?YVlJaWxvNXpFTU9wcVZGNERxTW9teFlYWEcwa3lSMUlOdno2aTBFN1BjSThE?=
 =?utf-8?B?TXgwRGxtR1ZhRUw5cFVtS1VGS3JNSk9hQlpLeTJSU3U2RU0wRW5wbXJ5a3hq?=
 =?utf-8?B?Y2xIOTRvbWc2cVBHR2JQaDNpckhHbk83OWlaa2dGTytlSVJhZ2Y4bzBxbzFN?=
 =?utf-8?B?WCt6Z2lKUUp6NVZhYVRlajJVaG9CS3QvQW9LT1VJTXFhVTFEZTQ2Q0x4aVRL?=
 =?utf-8?B?ZkJ3M0RLUW50dk9KUDNKNEZaV3VxUEI5RGpLZlRJREVnSUlTKzI0RCtJemtj?=
 =?utf-8?B?dzB1azhHR3dVUytLMnI2MVF1cnpDUFVVcmwvcDNNcHhxVHROSU9ZbmxjbDFu?=
 =?utf-8?B?ZHkwTkhyZEx1dTViTEZ5U0RSdnNEbkE4SlBNZWxxcWQ4L0VLOUEvQVg1M1kw?=
 =?utf-8?B?VjNDVSs4N2FnNFhUWC83b0MzTzFNcVNZUkZJODlYM2FONVAzMm0xcXZDclRF?=
 =?utf-8?B?M2JtTW5FUkV1OUQ4YkJvWTdBbU91OTEzeThhTitkc0V5T3NVQmlRa1AzcVFi?=
 =?utf-8?B?TlNMTHNPYklVeXpwck1OV1cwK3dBcXpDbkRkWTNSa0orS1VqNnNhcExLSkdB?=
 =?utf-8?B?OFBQWERxdEZTOXh4UU95dGxCQ1dJQ1lkZitDN3E5ZGR2WGlGV0lQSmNLSVRD?=
 =?utf-8?B?SUZjbFRsTzEvVk04YjJmRHkyaFB4NjhFNEl4aEpxTjVvUi9lakN5MG5WZkFp?=
 =?utf-8?B?Z3F5UlJRNnFSdzNFTDhjZWlZaWtOcXp1MUhDaXNMTFlrN0d1dkFlb0xvWTI0?=
 =?utf-8?B?ZGpGNjBmRWhwbFhBVGpJRGs3cmJxdHUxdDluckJ3M0NYUnBQempRdG0yQkZD?=
 =?utf-8?B?S21DcFV0RGQvYnZrZVU2MWxoOWFJNS9ST1JBamdSbUJtY01zNGEyYklzczdh?=
 =?utf-8?B?Vnh6SlYwNndGOHBaMmZBL0hKUUIvNFdEYzZ4ZlYwblFQQ2U1ZGRZRjdPZVp3?=
 =?utf-8?B?NmVEUlpRZnYzckhlKzkzT0Zjd3NMYWdtRVdzK0ZBV0xVS2k1VURtTWYvNy9o?=
 =?utf-8?B?eWZzbU91UE1PTm1oM21CQ0ovZkRnRkVCaWFFZEtwaGllRzRMdDAvRVNCWk9W?=
 =?utf-8?B?ZU1Pd3hzSVpDTVVJMC9qVDhPTjBIRjJ4RFBqaUNIUlBmeXg2SHF2cU9uUUhw?=
 =?utf-8?B?c01VWmtzcUlVaGhudGYxcTg5bS9SanJiKzZvSVpvREY4SXNkUStISllqKy9m?=
 =?utf-8?B?QkVEOVlqVnpLTW9ZZGxuLzYxUmdMTVZpejFlMVRhdXRLcUU4bXQyU05mRk92?=
 =?utf-8?B?aWNjZy96Mm5DRWJsL2tkUnltSUEyaUdINWxnLzA2eklLT3F2ZkNqZTNXTXpm?=
 =?utf-8?B?Y2F6L1RuaFU4MlVUakRHcENXZEFFekRDZDc4RHhocnE1QVFwdUlwSXQ0eVAr?=
 =?utf-8?B?SHRIbm1ZVURnU0ljMG5LK05BODBwRVNPQmlZM1M3UEF3Ry9CclJVQVZKUXly?=
 =?utf-8?B?SmpuNWx0Vk9Ba21mTUFMaS8rbkVRUVhCQXVBSUhxVGVscitRZnBLQVZqd0c3?=
 =?utf-8?B?TVlGcjZtOEExMWwzeU45Z2FRUXhKdVJldHUvMnhkQjRyOGEwUE45LzY0TXpk?=
 =?utf-8?Q?xn/1ETlJJlS/fiB9M5ccwdK4gxsbF/pIWRFNA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aTZ6ditKZUZQQ29lcCtPL0Y1ZEJtOEtmeFZxUmdidGxVUTJjQmtsZDNaNlR3?=
 =?utf-8?B?TjdQa012S2ZObzQ2cEdEdlFBamR0ZCtVNHY1QWZwMStQVnhyM3RlRWNYQ3Zl?=
 =?utf-8?B?cmdRVUxlRmkwbXhtVk4xVzB1N29RdnVhSXA2NGtBRkdvM0J0NmRsOGthY1U4?=
 =?utf-8?B?UldGNVZBOXpWNERVM28xQjZBVUt2VU5PQTF3Z0ZnT3gvUzRpZTFUNWwvUnVt?=
 =?utf-8?B?SjhDMWtsUTNreEltdnhNakRya1NscUxhRFB3YnRkRytxZVFvS2FZNEVGa2dX?=
 =?utf-8?B?Rm94NVFlcUlaMUg2VmdSa3c0aExXOFhEM3FEWlgwZlhUbG5UYXpQaGJBRitt?=
 =?utf-8?B?SG9yVm9wTjJxR2lZdXM4MEVQSFQ1NjdUV0hpUU55UzJDRkx5OXRaOGVqaGFm?=
 =?utf-8?B?ZUwwVUlTSzhCRkRLMUJNNlhTVEg3WGwwa2pjK2J0WVVJbnEvdnNZeW1kZUNo?=
 =?utf-8?B?cldra2ZsR1ByRm84RzhKbXQwbmZ4QVl3ejdsVEZmZDZxbDdROVd5ZUg0OEhy?=
 =?utf-8?B?MHBhRzBhbzE2Q2orVlBvVTVsak1GUmFkZG03R2kxdmUyUm5wOFliVE53LzNO?=
 =?utf-8?B?dDBSQ1dwUzVxZllZZk5OVDdpcVF0STlxY2Vva1dWQkJELzNDV01PSkV6VW9h?=
 =?utf-8?B?ZkZTaUErbVY2Y3B4QUZnSEJyUzJ3ajRQUEduMHpCYnRJRlVzRStMTFkyMllV?=
 =?utf-8?B?TVQrbzNvRUFoMUphTlhNT0ZHVzNnMTdpU29KUFBuQ29QSWFQTUg4M3ZacXlo?=
 =?utf-8?B?MnIwdXdKMTVWazJiazU3S3lkUWJaMjNxeVJXZjFCMmwwMXRUMk8zLzkvdWZM?=
 =?utf-8?B?Rlh2dnRETmlDWXFDWU9Zb2hYZWRiL0F3alc4NUlGQ2RNZXpaUE4xMmhobGY0?=
 =?utf-8?B?ck1VbEVXb3h6MXJqQVBXYWtuYmh5M3h0QThMWUFVaWF3N1J5bE1lS1QxY3JO?=
 =?utf-8?B?V2FaYTRSZm84TEtaSFVlRU9OVWJZZVA4ZmE4UEM5VWJYV2syY0ZkVWxtZnZw?=
 =?utf-8?B?T3hEZWJtQ3RaWVk3citPVGcwWk5QUlk5ZERmUUlRTzVPNFhpWk85Uks5UGtD?=
 =?utf-8?B?V2FYR0hqczdtYzhhNy83M2NBMFlML2dVVnNCWWU2ZTVxNHpzMG9ESFZGaThT?=
 =?utf-8?B?WjF5ZTloSURSSHNKeHlFT3RMdnhhMzM3UDRxZ1orWDY2U29JUnhUV1hPRnpF?=
 =?utf-8?B?OG1mNCtzekp5bEI2ZlZDajZCNW05V1lUMFYwMnVIRXZrL2RUZ3lMd3BrdGxJ?=
 =?utf-8?B?cEQ1MnhvOVVEcTlLa0doVUNML2NQQW00TFJkcmhGaEVWZzRTa3NLV1paVTQ4?=
 =?utf-8?B?VitySjBvRTgzMDd5VDhiSGFIZWYwcDB6QVJTeTlidmVYenQwY2l4dWhMUmRV?=
 =?utf-8?B?dHg1OHRZNGNpWjFWUmhPTXhIQzN2QXp1Y1J0U2swT09QaUdTejEyRGF1bG9U?=
 =?utf-8?B?UFBubWJ5eTlzcktBZEV0aG90MS95VHFCa1czM2xyN2FQekFOZmxsdTdTOUZt?=
 =?utf-8?B?ZFk2MFlPbWU1THIyNDRNQ1E4T04vck1FRlp2S29iRldmUWo1TjdRbTBkOTJn?=
 =?utf-8?B?M2NvT0VpNWFiL0F1TWs2L1N6Y3lOUTRhSEI3QjV6dzJmUGNVKzR0UlY2L1hO?=
 =?utf-8?B?R0xpQzVqR2xYRDQ2MklFc0NKVjJhWXpCWVErQ3lrelJWSmMxMzVRWi8xOHZa?=
 =?utf-8?B?NlVrYmt4Z1BrMEE0Z2hXdGVNNGp3RzVxYWUxUThlSkI3ajc1bjErdm1pZXpU?=
 =?utf-8?B?T0tNbHc2UG9KUjdqMnkvQ1J1RGFXR2E4OHpwcWwwMERIVGNucGw3QkhFOElq?=
 =?utf-8?B?R3VKS2VTL2lzT0dsQUtsRE16WW5XZFhSRGlaRGhYS0o2RXFqME5ydW9XNzY1?=
 =?utf-8?B?S0xiYzh5azI1Zk1JdVlNa0liYWU5V0EyVyt6MnB4Y1ROSWhidTllZTA2K0NS?=
 =?utf-8?B?eFFwVFFhRWViRU5TTTN6a1ZMbk1GQmZHTHNhOFRmODVtallTeG9CQm50YXpU?=
 =?utf-8?B?L01kMHloRmRJc2xYVWRLeWxtclpYYWc5cE9RNHgxSzdlYmM0d3pVSzlqK2wv?=
 =?utf-8?B?bS9Qb2xPQk1XdGtaWkJzdjVwYzc4QUVoWmlpalBoNUIxR3M2VGZFNWFDYlRq?=
 =?utf-8?B?amt0My83SGl4YnBoQkxudkxPZnErSFZLWUFRNXM5WVIyWW5MbDlMTW92SU11?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <982829D3EC82724BACF4600F78B688BB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UlxSc23T4AfBrJ597FjCJsRvBtqH5NmtJIap+4sNomJrT8V7nNfA6biBQFn7aJG2aPcV12ZPRgTrQOZd7FDKS7SMrZutovLWZ3crTdN+u/NJHhdUWNKkiV+Hd/2S66Gpmywq19iV/j2z8n1b++xFEIt+xjks1sdTtn/UtDjVfgp/FAsJrmUyM2D4gb0BNLhvODb64RfzJ51jXRvftxn3PORrGMItd0eGEkRNbQeag9RWg7LTLca3UMs5dQ+XXO6Jxw9ehcYLGxbmuiOyu+H2NCmFPZoCoYNYw1MBl6lemEbmUu26/4Tp5tZ5WJzLNHvveprne5FJgIoJGWN+pyOU8p1/Bnpw7I4UccvKz271qROv0xa7eNTvZ0yWqrB7MZwJIK2X0/bG6c5ZufYcAW2W1if+cTW0o/9Zq77r5JQRPxOTj6H7lS4f4MYaRlNu3TNhZjSiLwoZgw0ot8LPCASdxhyrlbx8n/eMBqGpYm4EmCIKi/nlPIXrunHSOjlhrEnBS220Oe9adROiwM5frPWHuFeuYAgQr1csAGKrPlRVrdMyptYz22ZMleMm2RYA1zvpKd99iQefiOzS98+RYrwYoBXd6/0rBz/uhe4v0qJ3MmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9486400d-adab-4def-acd9-08dc8d6647b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2024 18:09:20.8332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jo618qQ7RoaFcHAPU6F33A9Xsjp1xEflVLufBSds3un/8Jw3oyXYs8dqpsBb//eZYji3upCMdGraXPWfTnqb8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5550
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-15_14,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406150138
X-Proofpoint-ORIG-GUID: GhqP9PPpKc7f0vuYW73Up23ESH1o3sAf
X-Proofpoint-GUID: GhqP9PPpKc7f0vuYW73Up23ESH1o3sAf

DQoNCj4gT24gSnVuIDE0LCAyMDI0LCBhdCAyOjMz4oCvUE0sIENodWNrIExldmVyIElJSSA8Y2h1
Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPj4gT24gSnVuIDE0LCAyMDI0LCBhdCAy
OjI24oCvUE0sIENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+
PiANCj4+IE9uIEZyaSwgSnVuIDE0LCAyMDI0IGF0IDA1OjQ2OjIxUE0gKzAwMDAsIENodWNrIExl
dmVyIElJSSB3cm90ZToNCj4+PiANCj4+PiBJIGNhbiBnbyBiYWNrIGFuZCB0cnkgcmVwcm9kdWNp
bmcgd2l0aCBqdXN0IGdlbmVyaWMvMDY5IGFuZA0KPj4+IHRjcGR1bXAgYXMgYSBmaXJzdCBzdGVw
LiBJcyB0aGVyZSBhIHdheSBJIGNhbiB0ZWxsIHRoYXQgdGhlDQo+Pj4gUFIgZXJyb3JzIGFyZSBu
b3QgcmVwb3J0aW5nIGEgcG9zc2libGUgZGF0YSBjb3JydXB0aW9uPw0KPj4gDQo+PiB4ZnN0ZXN0
cyBpbiBnZW5lcmFsIGRvZXMgZGF0YSB2ZXJpZnljYXRpb24gdG8gY2hlY2sgZm9yIGRhdGEgaW50
ZWdyaXR5LA0KPj4gc28gd2Ugc2hvdWxkIG5vdCByZWx5IG9uIGtlcm5lbCBtZXNzYWdlcy4NCj4+
IA0KPj4gSSdtIGEgYml0IGJ1c3kgcmlnaHQgbm93LCBidXQgSSdsbCB0cnkgdG8gcmVwcm9kdWNl
IHRoaXMgbG9jYWxseSBuZXh0DQo+PiB3ZWVrLg0KPiANCj4gVGhhbmtzLCBJJ2xsIGFsc28gdHJ5
IHRvIGludmVzdGlnYXRlIGZ1cnRoZXIuDQoNClRoaXMgaXMgMTAwJSByZXByb2R1Y2libGUgaW4g
bXkgc2V0IHVwLg0KDQpibF9hbGxvY19sc2VnKCkgY2FsbHMgdGhpczoNCg0KIDU2MSBzdGF0aWMg
c3RydWN0IG5mczRfZGV2aWNlaWRfbm9kZSAqDQogNTYyIGJsX2ZpbmRfZ2V0X2RldmljZWlkKHN0
cnVjdCBuZnNfc2VydmVyICpzZXJ2ZXIsDQogNTYzICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1
Y3QgbmZzNF9kZXZpY2VpZCAqaWQsIGNvbnN0IHN0cnVjdCBjcmVkICpjcmVkLA0KIDU2NCAgICAg
ICAgICAgICAgICAgZ2ZwX3QgZ2ZwX21hc2spDQogNTY1IHsgDQogNTY2ICAgICAgICAgc3RydWN0
IG5mczRfZGV2aWNlaWRfbm9kZSAqbm9kZTsNCiA1NjcgICAgICAgICB1bnNpZ25lZCBsb25nIHN0
YXJ0LCBlbmQ7DQogNTY4DQogNTY5IHJldHJ5Og0KIDU3MCAgICAgICAgIG5vZGUgPSBuZnM0X2Zp
bmRfZ2V0X2RldmljZWlkKHNlcnZlciwgaWQsIGNyZWQsIGdmcF9tYXNrKTsNCiA1NzEgICAgICAg
ICBpZiAoIW5vZGUpDQogNTcyICAgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PREVW
KTsNCg0KbmZzNF9maW5kX2dldF9kZXZpY2VpZCgpIHRyaWVzIHRvIGJlIGNsZXZlciBhbmQgZG8g
YSBsb29rdXAgd2l0aG91dA0KdGhlIHNwaW4gbG9jayBmaXJzdC4NCg0KSWYgaXQgY2FuJ3QgZmlu
ZCBhIG1hdGNoaW5nIGRldmljZWlkLCBpdCBjcmVhdGVzIGEgbmV3IGRldmljZV9pbmZvDQood2hp
Y2ggY2FsbHMgYmxfYWxsb2NfZGV2aWNlaWRfbm9kZSwgYW5kIHRoYXQgcmVnaXN0ZXJzIHRoZSBk
ZXZpY2Uncw0KUFIga2V5KS4NCg0KVGhlbiBpdCB0YWtlcyB0aGUgbmZzNF9kZXZpY2VpZF9sb2Nr
IGFuZCBsb29rcyB1cCB0aGUgZGV2aWNlaWQgYWdhaW4uDQpJZiBpdCBmaW5kcyBpdCB0aGlzIHRp
bWUsIGJsX2ZpbmRfZ2V0X2RldmljZWlkKCkgZnJlZXMgdGhlIHNwYXJlDQoobmV3KSBkZXZpY2Vf
aW5mbywgd2hpY2ggdW5yZWdpc3RlcnMgdGhlIFBSIGtleSBmb3IgdGhlIHNhbWUgZGV2aWNlLg0K
DQpBbnkgc3Vic2VxdWVudCBJL08gZnJvbSB0aGlzIGNsaWVudCBvbiB0aGF0IGRldmljZSBnZXRz
IEVCQURFLg0KDQpUaGUgdW1vdW50IGxhdGVyIHVucmVnaXN0ZXJzIHRoZSBkZXZpY2UncyBQUiBr
ZXkgYWdhaW4uDQoNClNlZW1zIGxpa2UgUFIga2V5IHJlZ2lzdHJhdGlvbiBzaG91bGQgYmUgZG9u
ZSBmcm9tIGEgbW9yZQ0KaWRlbXBvdGVudCBjb250ZXh0Li4uPw0KDQoNCi0tDQpDaHVjayBMZXZl
cg0KDQoNCg==

