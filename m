Return-Path: <linux-nfs+bounces-20158-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH/+CmBltGlrnQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20158-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 20:28:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 825662894CD
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 20:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47FE630C6EC0
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 19:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB58D1A683F;
	Fri, 13 Mar 2026 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bncUOs3j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iEuuF0Rf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3F3019A6
	for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2026 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430109; cv=fail; b=t6z6T3wNQcmyB+TT9cYYB3WHa7DPERFmSEbWls+65mBI8bjX5Xy32soEirkUWJ134hWfU0ysTV2pv1KRjVDgRuKkwcgZVCjh/m7F6/8Igzx8FVagjv4gsNZBz1HF0YaAznuTgCrgNx0QwwjPybfNGq/yNLUZCHDRpdfy2pDzZzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430109; c=relaxed/simple;
	bh=29fZ600xMmui91xOhlNj9AkwyWP4mARMaFrn/jBZmmo=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FBAY8etC1pf9hp5B8MaX4u9xlKbJ5a6GMLjD0EG6z1KDOHDP0CVJscWGPMP84iqWH8bLKojAnY17tjYDTOXlObx5VWSDHCb6SSJtVnRTBcWmmQrXdOsCbfM/Fv0sKGyOUbga+6nmGreSDpPe5UZQQZZTLaB8SYWzXeKOu0bFU5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bncUOs3j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iEuuF0Rf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DHIrsH1866764;
	Fri, 13 Mar 2026 19:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=05Isil9JVx38DoGYosfOWf1ESqiN1lSYJnMrpuIM5P0=; b=
	bncUOs3jmw3Jo8K48S4UBNDfrK3Meb2RjR66ZPQ8u7JoNEGhgnN7C7FjKVQDj9kf
	u5NkR1UEOBiJF5rYqJB+Mw6+LsmDAIq98c0T75H2K1K5z37xJb/azv3M6ZYS2ozT
	hbA33WC4uM597EhRrGeq3xwQde5zhhDgMuKdmVqARTBQojz1qyNCs0wUdTeYwIEI
	CB9zYJZDO3GTnX+WzBROIKzGU0utRO0akhbhtB60hk2UBiZjv6+RH0vXM1KY4L0W
	kcW1bOd64w9GDpwP3rBtM+VaDq5dOzqg0oNcsdcEwHquLP33zEmWY9ZOULCvTwiC
	slqZX3pbYsqY5IZeupBGUg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cuh4rkevk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 19:28:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62DJBW8e022216;
	Fri, 13 Mar 2026 19:28:22 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cuh5n3pe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 19:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggCIBWysVTBb6qESJ+qdHtm3ajsCnjKPZJlFbi53ahTOqtk/PZ5AbjeZKa1Hg61sP2Abno3sJb3s9KU1c0PtRSah8xUm7evxtMruHlOc7QwSYXa7EoU8BVqKqjpDtJTQs7RDhjA0xhNUpOAeiqgF3sFSD1mJPaI3/W0Rez+N5ZEAQoY99yhgsp8dsPMmOK1tROliZ61qum/cIxeUo+hm24jaFiHVg62xbjn40ySLU7sMMMqz0+9YbD+4zQ0+kbe2SAM8IX41h4PLQl9u8qDne1FsiQR56H80NU84TxdphWkmy2IyrvQtvBlWrXioj9iA8yWgGKPiR5Adtma5uLqVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05Isil9JVx38DoGYosfOWf1ESqiN1lSYJnMrpuIM5P0=;
 b=jbVqTzVpGSqjNrd8veIY7NSoxp+FneResqFVehmwUXqqHtAyhqMsUy4gA7BCuI9dQyDXrJI2YglN7+T++fGLwEceXV7mOAq1n9CNAOi2r8GEyw02UGDQ9SwxDB7GdxebfrcKBGB/7aTlO+5glblcmACK8jRCThRZsK3CP7oKArDhqeUwrbHqwE7x5ItWDnT00uEVZpF/R81zmLRadEmvV86PZ+diWVMU9ItEWf8jJ97efx+GrEL4vYiYaOmrXyStrSUsjJPTpFc0eR413xU9vE/hAtr5/Nc/Y8+CiEj2Q5gAOg4Uq+WsYWVHuD54q2MbRr/0ruitT2HZDQLqnFS39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05Isil9JVx38DoGYosfOWf1ESqiN1lSYJnMrpuIM5P0=;
 b=iEuuF0RftRGRNieBV4PhDSidokzaO/HoyNKfasy3drd7K9Bw2Sgxdwnf5yokh17LPfcLY8ZFVepY2AFRUDAIWxfOdUIk0NAE2moXLN9jYyd6UyjvGxiASyKAlIfvSBOQFcuDD31FFHJ/fHnJcLZXcuY9M2YbjgePYi84cKeiKeA=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by CY8PR10MB6849.namprd10.prod.outlook.com (2603:10b6:930:9d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 19:28:03 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9%5]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 19:28:01 +0000
Message-ID: <ca5ee0dc-9f44-49d9-a55f-d980ba57da68@oracle.com>
Date: Fri, 13 Mar 2026 19:27:59 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: pynfs tests for set-acl-on-file/dir/dev creation time? Re: [PATCH
 v1] NFSD: NFSv4 file creation neglects setting ACL
To: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
References: <20251119005119.5147-1-cel@kernel.org>
 <CA+1jF5pF+K3s9N4p5mc4cxyzg=r5ow5R_T31Eab=DOW5AjBG-g@mail.gmail.com>
 <aSMsb350kJgqysbz@morisot.1015granger.net>
 <CA+1jF5rKuZhjj3POSrgFO8=uNS06gB2y5X+jmDhApDdXW_eLsQ@mail.gmail.com>
 <780e05c1-f790-41e5-a0e5-cf7484e31a92@oracle.com>
 <CA+1jF5rBpt60L3=j=t_msPj_4wMcUXxZW6X0k3sTKQ3mnMb3YQ@mail.gmail.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
In-Reply-To: <CA+1jF5rBpt60L3=j=t_msPj_4wMcUXxZW6X0k3sTKQ3mnMb3YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0132.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::24) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|CY8PR10MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4d97c3-658b-484e-95f2-08de8136a3f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	cKFcyOUgSMm9xSyTK9rx1syiJHc7gK1zin0pFAPJ2tDDcv9oce2n/cXfcFPabtZqUM5fdMyJ4lv+STHTw2PDf9U0wx2BeXnuTljfGP/zScIC72dxKLHNe7Qk15V2j/tY2+3jdGWlnk3LOSRxV+ipOJppROVUor4t6k/ITL+vz8bzkjFF+ibVTSbuOUp3Ns5TjGe48R8TF92CF1AzMTwRXw+a125wPtsKTW7cxxLOF3fLlfuvZOVVKPqGs/LvPI5/8XVmNTgGSAY5SLsAJlDRtgEeNI9j79VfGLLwS5adFvWPuGPPWduFjpbzXTfhEU3l9UPYb01CFAS5qVTTdjQkGOVRWu3bjegPSKV+uSoDfIxkkOnibJpvvtzuUrKq4pherQxUUYWVR4yFMqSUSegm1VWzMYSIyQrzETeIToBbWrzsyiM7k7X8W1J6OLohrUnY8Ll87sByG9i5318pN5WYzy+CoBLSS4bG/ii8exLDaQ6wvW4IP9Opca7rcCXgooVJInKFAs0KuLiuew8Iu5L41iDvzrTivGT7IO1650LjMNHYqMQ0VhVJ24o2P70lYMyny+9caBrqUPLnRKqe4Kcl29OL6NxTf2vFrfA2saK5LN262Lj/w+172qHFA7v4APim0Sigj8xQs65VIQYayUE8ya6+jv4UNqR+m9+qaP7sBAeMYen9NFZFeWiAawGfaPKy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1MwZTliNFBTbUhKRTRrUE9pWlRUUnZmOUx6bEkxQU5uVVdSTTdvWkdmQk5S?=
 =?utf-8?B?MTFBZ1pBMWtLa09QRUQ3dnppTjFwZ09BUmpoUDl4b2hSU1N5NFNwRFNQN25N?=
 =?utf-8?B?d2xWTUpwdWRKYThiZTBKVUVFTVFhZk80YmhIZ0N2SzVGb21xV0RhTWl0L0pw?=
 =?utf-8?B?SG5mSEczMDROUjRJYUxHTmhqaHNlUkZlSTlzcnp6dnc0dHhpOGFRVFZpcEZi?=
 =?utf-8?B?RS9vTllqY0RFYldHYmZ3ZHN2b0ZSSUlXNlhIWWt5L3gxa0lDRnVwSDlnV1Mx?=
 =?utf-8?B?eDNXeUR6ZUdyeVZwVDFLdk9xNmtOSWdkM29PeWYrNXNZa0VzemVhaitrSkNL?=
 =?utf-8?B?cmRzbit4SDM3Q1kzSHMzTklaejdrMnliRTVXWVM5c0VLM2E2QlliUEt4ZEUz?=
 =?utf-8?B?NXlqM29nUWlyY3M2VndDWFJ2c3ZGY1Y2aFMzSU9sRGtyamppWnRuTFBIaG1C?=
 =?utf-8?B?TklxYWJyc3YyUkY5dzUxR2hEQk9OR1lmNVcxWHpxeVppNjRtYWJFT2xUUFJk?=
 =?utf-8?B?TTZzVm0zVG1BS0ZRRUVUYzN1aG5PRUlJTHRMSGxFUWJnM3BFbEl6VnY5Mk1p?=
 =?utf-8?B?RGQ0RHRpS1B6T3B4cXF6bWpLS3VWNExYRS9iL1RjTlNZY1NHSTdOelVUTlhr?=
 =?utf-8?B?cHFvZ1g4TytETm1QeE5jbS8rZU1HYnJVcjNvVm9qbXV6ZDhzMitLUDhxVVRn?=
 =?utf-8?B?eFluWDFrOVNXZWVjVFNTd2dyWG01QlQ5MXlJYkhoMXZ0YVhqcVAvdXNrSzgx?=
 =?utf-8?B?TStWTWpjamp3bHAzU3YrSEdsYkdSTmRWTUZ1K3AvREFoZ3lybnlnMFBOVlZ3?=
 =?utf-8?B?dGw1VkVHY2lzZE9UNno0dDRTSkY4bWF5bmVZdHFlczVmWk90OUh4UlExTkl3?=
 =?utf-8?B?NzFmcm1ibXdWUkE0UUgzVTR1Z2JPdGdKenlzY21ZdXljM0hYOVpYRTdrenhV?=
 =?utf-8?B?b0JRNXo1cC9rWVhzMUlWZytkZ0NXaEZwVHltV1NmbEU0Y2tSVllWT1BvdEZo?=
 =?utf-8?B?NkJScldSVVhHTUZMNm03aEhjNGFhSjd1RUNPZXZIenZqVXkveWZPbkxpUkdW?=
 =?utf-8?B?YUZYSGl2c0RHQmZIQW12Mm5nS012WTdha1lLd0xORWVGcTg2Um5xZUEyOXAx?=
 =?utf-8?B?dFQxQnE1Qk01YUlIWlBTKytCOS9GeE1rSEZBb1c2VXF2cVNBaVZVQ0hGcVUy?=
 =?utf-8?B?QllGVWhTT1QrK0c0dktUWVlnVXNvRUJZOFg1YjQwSjBPSUYzeVdTRzVXbU1W?=
 =?utf-8?B?a3NITVBPZldWYVlUUVBZTXFUUFMrSGVsKzZncDF4eWhQTTYreVJWazFXVllL?=
 =?utf-8?B?VkRiOTcraHpoQWkxZVhDb0ZIL0Q4RWhWbG80alY2NG9TdTVFRERTNUM2d3I5?=
 =?utf-8?B?VFBuVXh3Z0V5UzFoLzFoMjZSWGcza0wxQk9aNjN6MnY2a05iWnNaTzNrZHlO?=
 =?utf-8?B?eVd3eXAvb2tnMmp0bUlLZHdEZXlqdTdrVXJPai9hYWJLR3lkNENhNWFVSWk3?=
 =?utf-8?B?bWY4MGltdExQZ1NLbnhZdzNPUXhmY3JwUy9WYU5nazZSWExxMEhjU2h6eUNi?=
 =?utf-8?B?QklxU1p5Ty9uUlpwQjEyY2YwMkYwRzk5QVQ2Rkt3ZE03MGYxME52QnZYNFFO?=
 =?utf-8?B?aTBZeG5meHRnZDdwTG9sYnlLdUdxVjdKdDFWT1RYeSs1L0lJbjJSZVhjVHNl?=
 =?utf-8?B?dTQra0JpdlpaRFBHVkxIY1lFTER0TWVveW9zdHZjSUUwRzlPYXpBSXJkNWFt?=
 =?utf-8?B?WTZrZzRiY00zbUM3eXE0dHdHVUsvVmswN3c0Z3puNjNMU25yTnZ5OXNLSTJM?=
 =?utf-8?B?bFNLSXliN2J4QzdkM0syZ1RJcnZpbk1aQkp6RlE5bmkyL3pDOTFQWkgzcndR?=
 =?utf-8?B?NmVidjgwL0YwQmNTbWJLYXUrZVpFcUhjekZqNkZjbFFZOVl5Sk5QRWhjdmh2?=
 =?utf-8?B?d2kzS1prNHMvbTd6Mkc4R3pQaWIzc2NNTE1PdThXNGthTk9hUTFERUl5ZUNu?=
 =?utf-8?B?TnJqTmhDY1ViUG9wTVhaZmphRDhnOWJFdFJzdmpJZGdxbkZ3YkNRYzMvOFkx?=
 =?utf-8?B?K2dIZWhXbEMyT01DN2FCbm5lSzlKT0hKSlgyNWZ3bTJ6UStDZVkwNDJLdHBx?=
 =?utf-8?B?WnFkeE4rcHRBTldQSjh4Z045S280enNKL2FpZllLa2huRmpqU3RtYjBJQ3dR?=
 =?utf-8?B?bG9RMDRHZVdTMHdvdXJOTUlQYVZFdnRoeVQwL1o5NXJZMTJ6QnVZTnBMUlI4?=
 =?utf-8?B?V0FuWDR5OWlITWFoZmR2T0VtYWFqWUhYRXZzK3I4MWJsWEQ0eGpURlg1eDlP?=
 =?utf-8?B?NGJKS3d5STZlQVRTZi9VNk9XNHdIK1RZRWpyVUpMQ1dLMVNXUHd0QT09?=
X-Exchange-RoutingPolicyChecked:
	JDLieBrGQmxFn2KBDiIjCqYooraMmXqEbTddA7zhuT1HZBiOYINWsBFA4Ujo4O/1g4eK2WvX5hnD9XgghKyc3xOr3eogZbAhCVM3cBP+wiYt0ZZGdOPhUGqI66+gPh5zmz3PiBTeID9WWnRL3I+D6+ZnSo7FrsBeBN/WN0m1nPRhm2ETC5K4Y+70OBgm9BZsmsBB9R6QDlkdMNKmVmoFn2CCn0x6cpt6TS+nNJktFR29i7ht955Y1JWUXOwWBh8yZy3ZfAMa48wi/5B1aeerhE/dT8HLqo2CNhvcHBffpvISmxPWjJGWX3+MyFwagFL2Qh8EDorCLiJMJH9b1uALcA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZrYM/Bgu7/pplpVeovZ9GL29Mt6BVupNqpI1dG0hkQZsOsrDc1wmG8Tt09nNCDkDt5pfOPkzch4QEoBOt7mr4uubrGy/VYynQeR3+obPpNCobUqkdhLzQUMub4fFvdy/N+AhiRRHoRkGEL8jbSDxznJyiQRjaVC7B5LhlLW+ZLGyWeRZnaRR41Ng7rZGLexN1vvLd0dGoMB0tf9MTPaqXd7f+IuwpDt8Jud6AeOD7Vs25oVMY24tN0SYSTMDDD+YtCrSV0d8UBqCPdNaklpzDAJcqTRF1xUTmRLT88xeUGsCyOwWew6rFmX6cSt/Ym5v1hgHW0alZV4AAQ5dYeG799GYrIUGV2b5RHoi6OMymkKSZ9QVN6JmDYhONNM3Y5fhuE9D/eN5P8DdTIr4fZVjGvczU+a2Uc0lAYFOltI2QEYLn5VGqhQMCeDunjYUMBMBM3Eqznt4Qq95zX86mFLrige8sVGJsWIqfly4LwtqX/94hgz3qaQw7Z3jtRj03ZpVInapm3gLBM6SA62SqU3/gEFqEN2BV5CepNaz9pYpEWlLF0LV1WUT0bsdC8RqEYw3hpc4Fri/3eAyilFAPErDvdw+XbvG8baKvxAhQj47/BM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4d97c3-658b-484e-95f2-08de8136a3f2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 19:28:01.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPdHF5WXW3i0qj+9x6fP7CS82FxprUWtze+ZwUv9hP94EhkWsctL/Y9zTXmyL3D4i7X5RLfweks36H0Lmn98iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6849
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603130155
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE1NSBTYWx0ZWRfX035Bsn/Z7G6S
 Cz32fKQ+WX/1m35JSVa4z1UGtTuMkSCAfGje8NjbLHGajgyZxxzFZdxdQ9AmwyuPk7dSuwkoW3m
 IrhcMYGS3IJts2jeo78yNXUFgECsmcfiDR2ocHLKWvcgrJgPFHlwwgOfQgudhL9MR0jMl9ckKlR
 M732nm4oL99Q+/8IARSvMNxoB/FMITmlU/6c7YfqZ5rL8DK8EHGwtI7DJKE2966zhuKp62+hV33
 D15thWe+Ym9iU44IwlzTm4/24SLoVrBzxvQBUzPAeuIEaTIODKiPB2jp39A3x86x8PDp2rM3bLm
 I5WsO1KS8vkq7GMCLMqZ4ySJvC24owSrSMwjYUR4jXNaEH9GQXfAz4+dYKHV9m9zG9HTMXgQjkS
 8GoMPydVIZv6Fgs0DTTVFUZSKuEk4WdCqTmCryPmcbLa4U21HY4FC1EbwfwKagjXximU7ioeZtx
 bsgXpU/EDWhyIJzhGH025MJU/8y9xe99Y5V/aCaE=
X-Authority-Analysis: v=2.4 cv=FL0WBuos c=1 sm=1 tr=0 ts=69b46557 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=P6JkxrBpAAAA:8
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=iT4ZeSVlAAAA:8
 a=IhFbgbYyjnBD56vPVCkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dwOG0T2NmQ8MtARghG3a:22 a=B1tqfP-ccRqU1F-Hp2K2:22 cc=ntf awl=host:12272
X-Proofpoint-ORIG-GUID: w9lOFkucitbvRjtzNZ0X4aX_nx3IGhCb
X-Proofpoint-GUID: w9lOFkucitbvRjtzNZ0X4aX_nx3IGhCb
X-Spamd-Result: default: False [1.35 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-20158-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calum.mackay@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid,linux-nfs.org:url,nrubsig.org:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 825662894CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13/03/2026 7:48 am, Aurélien Couderc wrote:
> https://git.linux-nfs.org/?p=cdmackay/pynfs.git;a=summary appears to
> be down at the moment. Could you please post the URL of the commits
> once the site is up again?

hi Aurélien,

The site seems to be up at the moment, albeit rather slow to respond.

I don't look after the site itself, so I'm not sure if there are ongoing 
issues.

best wishes,
calum.

> 
> Aurélien
> 
> On Wed, Mar 11, 2026 at 10:36 PM Calum Mackay <calum.mackay@oracle.com> wrote:
>>
>> Apologies; I have a number of patches queued up that I need to push out.
>> Will do that asap.
>>
>> best wishes,
>> calum.
>>
>> On 01/03/2026 12:29 pm, Aurélien Couderc wrote:
>>> On Sun, Nov 23, 2025 at 4:46 PM Chuck Lever <cel@kernel.org> wrote:
>>>>
>>>> On Sun, Nov 23, 2025 at 03:54:48PM +0100, Aurélien Couderc wrote:
>>>>> On Wed, Nov 19, 2025 at 1:51 AM Chuck Lever <cel@kernel.org> wrote:
>>>>>>
>>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>>
>>>>>> An NFSv4 client that sets an ACL with a named principal during file
>>>>>> creation retrieves the ACL afterwards, and finds that it is only a
>>>>>> default ACL (based on the mode bits) and not the ACL that was
>>>>>> requested during file creation. This violates RFC 8881 section
>>>>>> 6.4.1.3: "the ACL attribute is set as given".
>>>>>>
>>>>>> The issue occurs in nfsd_create_setattr(), which calls
>>>>>> nfsd_attrs_valid() to determine whether to call nfsd_setattr().
>>>>>> However, nfsd_attrs_valid() checks only for iattr changes and
>>>>>> security labels, but not POSIX ACLs. When only an ACL is present,
>>>>>> the function returns false, nfsd_setattr() is skipped, and the
>>>>>> POSIX ACL is never applied to the inode.
>>>>>>
>>>>>> Subsequently, when the client retrieves the ACL, the server finds
>>>>>> no POSIX ACL on the inode and returns one generated from the file's
>>>>>> mode bits rather than returning the originally-specified ACL.
>>>>>>
>>>>>> Reported-by: Aurélien Couderc <aurelien.couderc2002@gmail.com>
>>>>>> Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
>>>>>> Cc: Roland Mainz <roland.mainz@nrubsig.org>
>>>>>> X-Cc: stable@vger.kernel.org
>>>>>> Signed-off-by: Chuck Lever <cel@kernel.org>
>>>>>
>>>>> As said the patch works, but are there any tests in the Linux NFS
>>>>> testsuite which cover ACLs with multiple users and groups, at OPEN and
>>>>> SETATTR time?
>>>>
>>>> I developed several new pynfs [1] tests while troubleshooting this
>>>> issue. I'll post them soon.
>>>>
>>>> --
>>>> Chuck Lever
>>>>
>>>> [1] git://git.linux-nfs.org/projects/cdmackay/pynfs.git
>>>
>>> https://git.linux-nfs.org/?p=cdmackay/pynfs.git;a=summary was not
>>> updated since 10 months. Are the patches stuck, or something else
>>> happened
>>>
>>> Aurélien
>>
>>
> 
> 



