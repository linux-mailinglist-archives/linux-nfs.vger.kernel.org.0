Return-Path: <linux-nfs+bounces-6599-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A7D97EC31
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 15:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373F128280D
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 13:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4347199231;
	Mon, 23 Sep 2024 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GoGxyjxV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u5ZQc+P6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C285C53373
	for <linux-nfs@vger.kernel.org>; Mon, 23 Sep 2024 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727097762; cv=fail; b=FEa3QhgVoi39ZNdyY3vrGni6nYenH8bqnghGNW9KJB3P8+WF4X/yB2nOvOdftVmjALm8plB9Ilus19SDw0xdSskodtVhEXlHyJyQJXQdk67mw1xQGF8DbIgYMADW5qcGIbOvJhCvX8MZTKMYkZs0wkhOR4bbLXPQI/iP5ccAfn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727097762; c=relaxed/simple;
	bh=+8PxmGtTnLgORqZuOS8kabz64/dZtcmF0hRTeQbVRZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ihAjJ3rxXM5wIfZ+4eFIJDsgzbHicj8d/AQcvOhtmKZN++Mk3wJ22kYVm9rxMLYClihZrCO8XH/pjbP68Rs3F+WYqOBLtbs8beJ16WaVGG9om8i+LLOBRABptmHvO7FKsQkqP6aANF9h5CSzUPc3k9xPqB9iZ8cUw8NoyC/qIP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GoGxyjxV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u5ZQc+P6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NBiVsY018030;
	Mon, 23 Sep 2024 13:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=+8PxmGtTnLgORqZuOS8kabz64/dZtcmF0hRTeQbVR
	ZE=; b=GoGxyjxVq6t0IAm+ZZ/5TQCPSBYtViSjAk3p8JCYIht5C5Dg/LVp7uxyh
	Gqg+UQCXrLiPrGPGnyJ+HQuhtywGwlR1ZwsyKMh7a3iq8NbmAIAyfYesyDSxCuvU
	Bu3Ef/cZilQajt3zuUiStxI6lJPpM+gcFnOQdakcoR6Q8y39QAsNPOkrD5z6SjcL
	coTKh6+Haxv1oIt1pLxr/HPy8z7HaR2Pn6pgMy/pU/2CPOkJQ3yzQY9lhX40WWq0
	0WdXDj14aVPZqL61M4Y5CvnMOm8+04qcidaJaKD7ItN7eQDVCC5wZqLx3wsUwWIf
	eg3BfYnETjSCOifyntDx+sraoC6hg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41snrt25kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 13:22:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NC6LZJ024850;
	Mon, 23 Sep 2024 13:22:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk7scyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 13:22:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbQ2U5iqRW8E6qkpDeFYllxQ2Zo1PFvPLPr0rEY9pkQUOLGGg3HI8ghF043kRokuIcF6EF3H8XgSI3rli+rng3dmS21z/7UgdTmpEsjftyPatSftZE5kDbLbLFCjwY38Wo4nLeWeWlElds+fINP1NeLOrrxtB6GwDuG8iCiNFTFfBzRUnEAxLrYm1GrqBrz+TukZghVCyWeOca9mjlk7Yu5LD5GXHb8GqRM7TamC46DG30Mw2GjX6goyeBBrJYKlmRlGCbJL+XDfuV6WM1e+ZngZWf7zBAtIdwscak865Qr1Sy4v84Hi07WTmwxnk5YJwFrUyuohlC0y7K2CK5Tmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8PxmGtTnLgORqZuOS8kabz64/dZtcmF0hRTeQbVRZE=;
 b=cYKHe1c5yJWiPFFCqX1OSB/7g/kybYYKTNTfyk/wRXVx5Nv6AXAg5RMeXifv0GSt5uDcdWjCcnCtXGgiG7d3wEk/HpxBS0gkMH4j68C+yOARbpOHjvXuUaGA0HuatR9S7CPQtEaO1x6/I2fq2jrlSAY3+LSjh+oKbZX5cUzrFF1gxmhpjAnvzlA2OGYH0QwDcAJP0jg89ic3kGwo7rMkz57RYdUaQiSIQzaONUjmtsQvEmJfOpGcps5zDdOPmMY0X7IKj3DguNTQdzKeQUYK19ZEhxhiKoCoFkgwAFIZ80Kimry6QC2T4HEsk7vPl6AJpRjhwgGczkZnX0ThgJWkjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8PxmGtTnLgORqZuOS8kabz64/dZtcmF0hRTeQbVRZE=;
 b=u5ZQc+P695NnzeGehYUJjSLJNQbSnocibiFEFkHf1U+BzzSPUWN5YzCM8hfuMc1d6/hMtqx9O+A7mbDuChsOyKTOIcI3Ozc21GBdGRyfILRogJl+rNlCgzUCeqG5zeYsBef3dQiSI+YyFGY3BNS6L+1DKqJyqIAIsY0pdgQTjgs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6050.namprd10.prod.outlook.com (2603:10b6:208:38a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Mon, 23 Sep
 2024 13:22:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 13:22:35 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: =?utf-8?B?QmVub8OudCBHc2Nod2luZA==?= <benoit.gschwind@minesparis.psl.eu>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfsd endlessly in uninterruptible sleep (D state)
Thread-Topic: nfsd endlessly in uninterruptible sleep (D state)
Thread-Index: AQHbDbQfUJ6VoE7cB0Wq7I8NNH1z0LJlW9gA
Date: Mon, 23 Sep 2024 13:22:35 +0000
Message-ID: <F7F4ADA9-9EEC-4607-A695-BB953FF91C8B@oracle.com>
References: <29d539955368d357750e17bd615e2ae5f10e826a.camel@minesparis.psl.eu>
In-Reply-To:
 <29d539955368d357750e17bd615e2ae5f10e826a.camel@minesparis.psl.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6050:EE_
x-ms-office365-filtering-correlation-id: 6b6028c8-a199-497e-d78c-08dcdbd2c98e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bm5BeFUySktWdERjU01CUDRrZVpiNi9zQ1VNMmF1ZzJiZXFJckhQQU9WWDl3?=
 =?utf-8?B?bjJmaDc3OU9LOFZvSkl1SHZyV0RsMWF4Vm96MTk2YnE2SHNBU0pHV280Y2Yv?=
 =?utf-8?B?cmhtcVJRNDBkME5jWXpieVR4QS9hRlAwYUFXQjVDMGNHalE4MHJMTk81RXYw?=
 =?utf-8?B?d09SbVpzVHBJTElQZTB1NFZpL1pDUEJ3cHIybzEwcHM3cVhhLzRFMU5ZbE9n?=
 =?utf-8?B?V28xVFA0UnkzTWprVXFPQkZvMlFVQXRvRVd2c2lEZ3ZWTjNQeHgvRFd1bmMw?=
 =?utf-8?B?eUFrZytMUnZ6Zk5lSzVLK2dURWRsU1l2V1YxWG4zSW9Fc0duSE1YelNiVXJq?=
 =?utf-8?B?TDZDRm9jVlRXNTFCM1NhSW5laHZGdTRyek80c25kYkVKZXdQQ3E4d3hqRTBY?=
 =?utf-8?B?bXVUc2NoUGNhV01jd0k5dnRiSzQwSVIza3NzTlFlMDdqalZtMFMzMVNmTlU2?=
 =?utf-8?B?REprNVJPNHFKQUQvWHpLWWlTeDNsVmRMT1NZekxGTUNsbDFyMEkvRVRNbjRR?=
 =?utf-8?B?OW82SjM4Z2toVEtKNTQ5UE84bDFrVktpaGNpZ3NIN255Q0hOVTZESlJYTmJH?=
 =?utf-8?B?WWxSOEpiZGUzSU1qN3hCaUdmUnlORU9oYjV5MVdrMW1US0Vackp3bkplMnI1?=
 =?utf-8?B?L2RQdWtrUUtCckd0a2k5TkpMRDNNS0tkTElWVU4xNFNsYkFzT0FpdlRjNzJh?=
 =?utf-8?B?N29PWGNIU2ZHWC9PYjdPbVluQzBVcGlYbHFUMmUxWThKOXc2eXJsUE9naytw?=
 =?utf-8?B?b2FYMjlwU01WSzJ0ci9vbERaL3ZBaUxpcDl5ZDlxNGwvWEQxNGtxdDgyWVRa?=
 =?utf-8?B?cS9DUXpuNFpRaGFvdGRhc2ZYNGRiNFF0YVl1Y2U4ZUN0NThSWk0zLzFMdjdT?=
 =?utf-8?B?OUVMcnJDTGpkU2E3MjJoYTdiKzEyWCtqVElVMDFBNEdJM08wUEpSMXE5MkN4?=
 =?utf-8?B?bmpCZ1VNcllHUjBoblNaV3VLdlhhT3plZTdqc2hIWjdleE1mSzdBbU9MTk0z?=
 =?utf-8?B?eWJKQzRadlFLaGRmejMvRWR2S1QzQlhLSmRBaHdFSlhyaWY2Vk52SFdiVXdz?=
 =?utf-8?B?QVZ0MzRuREYvejgrbnpqUlVkM2RDbHFFQjZZOEdhYkFybGNQQzgzYTBrUUFx?=
 =?utf-8?B?RGNDNVg2elVVMHBNWFdmRGd0M3NaSzJSZEpjbUZUVUVhWEt1VGVkSVZvT2g1?=
 =?utf-8?B?VTVVeGZZajBpUW1VYmZkNlhQN2NJbTB5ajZqVTZoRGg2a2l3WmFTamFCdFc5?=
 =?utf-8?B?YUdKUW00bmxWbWdzNDI3MkdOMFBNalo5UEduQnJvUTBGYmJMYXI2K3gyN1Nv?=
 =?utf-8?B?RGo3cWt5aTNYS0JaZk0rM2ZTbHRrUEd2TmZhL0x0WFluUkxySVRaSUNDWERj?=
 =?utf-8?B?RTQydHBCd2hBa2N3RGN3K1A5bVlyZXArcVdWRnp4Y2g1L2xNZlRNaHBqVTBG?=
 =?utf-8?B?MHFGUnF6cXVtS2xoTi9uY1FXLzFtd2Q1cW5ienR0WE9WazdHTWdEbDJjYmhN?=
 =?utf-8?B?Q3FZdExpK1Y1aDZ6RlhnbFcrdkNRUEdodjZhQWV0ZDYzQkd2QmZDSEFMQ2wy?=
 =?utf-8?B?Z1pCc0pTQ1FmbFBVcVppUlhBTXJ3Uko5Z0RjVlgrZlNEaGpMSTZzbVJ4UXB2?=
 =?utf-8?B?ejBqa3NBc0VBa2FmTFB1Rkd5WmZYdlIzVzZPbmE2alZvRU1CK1FrYy9HVkI3?=
 =?utf-8?B?VGhSODVhWFFPd2toanllZGRPSmJ6ZXVyR0N3SnJ0ZXZwYUVKTDczMUNzNEZQ?=
 =?utf-8?B?ckdZbUhOQWZVbmhCQ1F0aHB0aDhLQzBscFhyc3gzYjA5NVVOVDI0M2szeFQ2?=
 =?utf-8?B?VkR6TWpwemF1NVNDNzd3QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a21VQ01UTElwakdxbGdXTzVmSkdXOHJWcWNkZEd2V0F1a2N4U0lkTklCN2dj?=
 =?utf-8?B?TXFFMkViK056UWpncnBvcC9HR3ljcE11Qk9YcEtCakg4MnAyTUYxc0RxV1p3?=
 =?utf-8?B?K1J5ZUoyMzRCUDZQL3dIdWZ5RHg1T2RiK2F4VzBrU0FEZjVma2lZQTg3ci9l?=
 =?utf-8?B?bWZDOXVzL2VsNWNncEFHMDlLWS9ucm9oMXM0aDJoTkk0U2JTeWdiYTN0WnU5?=
 =?utf-8?B?T010cThHRE1ncDhoVVl4M3BnbHN2alF4S2JqWDVUY0JpMjNNUnhweGhlUDM4?=
 =?utf-8?B?b3h2clZmOURSNUNERGpMeFRkeTNHZlB1Rkw0UEhtUjlmSm94V2lHc2hTVTZS?=
 =?utf-8?B?ZlNIUFVxQWVUUUR3cnlOWVI0QnhRcm1MTEw4VmE3c3dsZHhhemFhU3hUU0JQ?=
 =?utf-8?B?TFd1SXl5NFl2dzBmaHFBTjhCU04rL0hqTGdrNlBIT2NvaGFUaE42ZXJ2ZGZE?=
 =?utf-8?B?aVZZM3U4cWNwTjIwR2tBSHAwWHRjZVdyeWdGVHJRVGVLajEwNXIrZU1pTWp4?=
 =?utf-8?B?Sjd0LzA1b3JkWnorMWpGK2t5ekVBWHVUaFh2QkpWZzhJVzZDbE1kdCtTbHJL?=
 =?utf-8?B?OFl1NG9INjJJd0xTb0tMdnRLVGNYYndtOVVnYU96TFNaZnQ3bDd0T00vMldI?=
 =?utf-8?B?WUJxM21lTzBZamszdWVDSFAxUzRjY3JSUU1hVkRXc1lQbjdmRDgvSU1FbjNE?=
 =?utf-8?B?bG9RblZqcTY3TGFBVS9tZ1gzQjNEN0o5a0NuV1M4NFF4OUtUSHBDT2gyOVND?=
 =?utf-8?B?QTN3V0kyNnFjTnNpaGI2TGl3Smhha3FTL2dzWmE5Q1JDWGY3VFBwWVdVYTBF?=
 =?utf-8?B?TUMxOGMyQk9pMDRuUnpUcFlWVzJNeHhVRFcxM094UzR3MGtmQ2xMZlhtTG9R?=
 =?utf-8?B?ZjJ0ZWQ0SGJhbkFWNWZwb1BOZVhsSUFKbU1PaDVaemxLUm1iS3Z5R2phMnlq?=
 =?utf-8?B?ZWl4ZEV2ZEVhTURHWjRWZ1ErcTZveEJUYjM5R05oWTBtQmZDbWRDUGRxaG9X?=
 =?utf-8?B?aUlkS0FmWHhVUHFGY1BtMnRaZThtckRVU054MHE0M1BpVTU5NXlnR3ZQNXlB?=
 =?utf-8?B?cnYxUmxaNVQxQlkrR0JTOG9KVmpTdDBEQlR4RG94ZTY3QW1qZFJzU1ZvZ1h2?=
 =?utf-8?B?ekFIbExLbVZGZFNYQ1ZjZTdWZXlhL3RKUUl5QllQb1ROcHErdENONVI4Wkd4?=
 =?utf-8?B?YmZNSHJ6eFlOV3dXV2o4OC9adTM0c3V3L1FCTTFBVnNuci9kNk43WExaN3M2?=
 =?utf-8?B?YXlJUHFmRDd2QU5FUStFdmFkQU8vT2dacERuaytlYVRKeEcreGtWYVRvUm1x?=
 =?utf-8?B?a2NIZzZyY2RHQTJXNnJHaVIwS0F5ZUY0TlR0U3FuUW9SN3ZaMU8zMmNQVmxO?=
 =?utf-8?B?VVlVMGdlRjNjTnd1amEvYjVIU2g5TXhBeEROMkw0SzNvb1QyNm0vbWh0a1di?=
 =?utf-8?B?dFlrN1RYT1U5ckQ0Y3Nqbk1xMnlhR0dhOXkwYXQwMGVFbll1azExQVdKVGtm?=
 =?utf-8?B?MnlsVE1KNXh6REhNcXNIRVlpUWdvSC9rRER2VERhSFhEcW1SWklraUQ1QmNY?=
 =?utf-8?B?ZkFoTHg4MGdTOWNmL1Vtb0dFWXlYUnN0OGhxaW1UMmNxcWlxWHY0SDUwQmJ2?=
 =?utf-8?B?c3FwYXlkR0Y3RVZrcG40d1Jya2FVdVBqYlJVSG1UbFl0SGJsVEIwbjhNcWlF?=
 =?utf-8?B?dDI2a3lPR0N3N2NoTlNYNjAzU081TDc4aXhHcHVWZ0dVUy9EWEhGV0RRZGN6?=
 =?utf-8?B?TUQ5NW5jWThhMzMzM2V1ek9Jb2RwUUhIT3hEWDl3dlc1YVdtZlEvZnptaG00?=
 =?utf-8?B?L3k4bmtrd3U5WnptdGd6bjFKZGl1UmRreHNHVHVFQzlRVy9JWG1wY3pTVFgr?=
 =?utf-8?B?YkNuSkgyakoxMi9vdWZISUZ6cUd6dElaS2UwQlIwR0NHa2xQcWdVUmZldWJS?=
 =?utf-8?B?SFdGMzlNY1pNaC91SGpmVGhmSVRwYWJmNVAydlQvQlJvWTAzYXJ1azBkYVBV?=
 =?utf-8?B?eTI5M0Z3Smd1VnJzUm1ETlhNOCtSM2NZc2diSHRwMDMzbUhrVU9pVWhUa0tt?=
 =?utf-8?B?SG9xbHJiVkl6ME4xUThPMVAyZVF0anJ2MjdMNk5HUndSK0s3V2ZRMy90T0dp?=
 =?utf-8?B?cTRDMmFKYWF1S2hoZlJLRVBUdlJ2OE1WTDNKOGV5d0wrQ0pxcWVHUnRXcnpi?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02312CBC44A42143B047F33BCFFFE37F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FsbPUKpxTFaMzxmzYo2KAzHPo6BsCGYcKvisTnyNSeSavZCPw/KocYF8ptFuQWjlwf8gemoECiPsL1gq65f+uKGDFR5vfzu36cBlHyLizPxK7OS74cUY9abOmgrh9duJ5nOtpkXonCByf0ZkGSnJavy/DwTnN4LD8zrEQddnUGvWnMCYX+8tEslPM4w7r7p5bCUwPvI3zImKeNfsItEbeSoFGkNC4K0lDF4yfqX6MISSHCRLUs0JT3VUHRDG+6lFDVqk4Ipi+9TnZ3cz088UCyPRMnmgqQ4bPf4JoQ5LH/Sj1F1PVzBtm+pIAErhbR+Mrz6gJEV3scWseH3ztctn5k5JNZ3tfluJoeVnxgZErH1xOQZ9YXbYa5iEmYOnLLSwoBj4PoENziApRE4CNVL9W/LdNER4uNoTAqy8Zy6uGy6jiD3r9yAV7baPhofDr/vpbBQtZxaMeYJMffHb5PmLGSwmeB+EkEYPVKeVPuXIZTEuuTzbg3Kzjy5PXcUoudvsbrz6jbh3sSwSvE+xxWRP5MC5b8P7edThF1PJz3V6h0EqlQhFcK29+O5jUEFjd0U0vKHUoIwrs1xvrVtwOLlZXoq55fhsH7Lm83kogiw1Y/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6028c8-a199-497e-d78c-08dcdbd2c98e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 13:22:35.0436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcI3ZBTTkAccXdCcOEwYtVgS+FnjJ19QGPezajF2zeWY8uL4Psx+7ls4a3Bk8FK5ArQFrlhB3K2i4YM0BYju9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_05,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=940 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409230098
X-Proofpoint-GUID: Jaup05ooiL-1MCVndx5OFgqH7T1r7TVf
X-Proofpoint-ORIG-GUID: Jaup05ooiL-1MCVndx5OFgqH7T1r7TVf

DQoNCj4gT24gU2VwIDIzLCAyMDI0LCBhdCA4OjIw4oCvQU0sIEJlbm/DrnQgR3NjaHdpbmQgPGJl
bm9pdC5nc2Nod2luZEBtaW5lc3BhcmlzLnBzbC5ldT4gd3JvdGU6DQo+IA0KPiBIZWxsbywNCj4g
DQo+IEluIHNvbWUgd29ya2xvYWQgb24gdGhlIHNlcnZlciBzaWRlIEkgZ2V0IG5mc2QgaW4gdW5p
bnRlcnJ1cHRpYmxlIHNsZWVwDQo+IGFuZCBuZXZlciBsZWF2ZSB0aGlzIHN0YXRlLiBUaGUgY2xp
ZW50IGlzIGJsb2NrZWQgZW5kbGVzc2x5LCB1bnRpbCBJDQo+IHJlYm9vdCB0aGUgc2VydmVyLg0K
PiANCj4gSG93IGNhbiBJIGRpYWdub3NlL2FuYWx5emUgdGhlIGlzc3VlID8NCg0KV2hlbiBORlNE
IGdldHMgaW50byB0aGlzIHN0YXRlOg0KDQogJCBzdWRvIGVjaG8gdCA+IC9wcm9jL3N5c3JxLXRy
aWdnZXINCg0KVGhlbiBleGFtaW5lIHRoZSBrZXJuZWwgbG9nIHRvIGZpbmQgdGhlIGJhY2sgdHJh
Y2UNCm9mIHRoZSBibG9ja2VkIHByb2Nlc3MuIElmIHRoZSBjYXVzZSBpc24ndCBpbW1lZGlhdGVs
eQ0Kb2J2aW91cywgdGhlbiBwb3N0IHRoZSBiYWNrIHRyYWNlIGhlcmUgb24gdGhpcw0KbWFpbGlu
ZyBsaXN0Lg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

