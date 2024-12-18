Return-Path: <linux-nfs+bounces-8657-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 356439F6F2F
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 22:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8156D188F81D
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 21:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C901D1FCFEF;
	Wed, 18 Dec 2024 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HdLD1Hmx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hwB1mxLA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339D1FBE8C
	for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2024 21:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555789; cv=fail; b=QWppUiC9XXojs6IJiDMqXQY+yIGk1jOkWVJHxvQ7ZFstUGuWD4f5sWdDTsAYqMGuD1bcSi0rmQp8RbNgN+I3VGbnLU93Mq7BDkNV5Fr3o7KABW4aQhXvUkJtnkiMbz9k9nOq2//wD354uJOJHH3I/6MCtKup4o+H4DjhgxAo4tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555789; c=relaxed/simple;
	bh=sCr03ut5+4hE48oZiYRzBWjIy1yOZ2YOYRjF/Op4aXU=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=qIDRD6wQUGb5e7obq8oN6GffpAP+vpD5uSFnEI7EaX1LkgQxQ154Ry5kXdi36J7SbsVR1o3u5xm7IXryBm3GbRRApU69n8B1GmhR6m24bz768wWHQ1vV1h88A1oCu94o8xBN5Sx/0wdq7K6ZAJgt+ldLjue5VJIVajnxqed5O2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HdLD1Hmx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hwB1mxLA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIKIeK9013103;
	Wed, 18 Dec 2024 21:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=hXf2TZXhBHgTxyFF
	7kvirbfXfKiyqiEUNbwNDL6e14U=; b=HdLD1Hmxi3jpEEVtIfIEQA3FxIJtkALK
	LXjEgKLENzFo/eP0jCdW+yhXOzsriUDqu0Eb0xgnFUutLBs6AdvS5IEAScAfo5gB
	oHZqztjzZ6zc/lTDAtNind5rbHwncIC6KwfBWApFhZPh6QEgmZ0jowkabXpftkGt
	9VmTKEGgrb88wZBNDYINtI7FqMZrDEyVMSQYWUAN+TixEPUOvjFg+no4PJ9zfj4b
	/qsY/1bviBm9XwxwlLOT3xJU2ssA7r8lxrI2ZddEBekG8VWE9Lov4B/vkAkKJa1j
	dtSMcUtEP3Iid5fqaPrVxUS3r1xYLFLtgDMqQ3VHYoJModbf2KJg2A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj5fegv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 21:03:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIKO8WT019266;
	Wed, 18 Dec 2024 21:03:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fake7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 21:03:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqFUVmRWcI3ExEtLXnquVl9k/l89fU/PlJxJfliiJs0ysV6LvqjLUJDXi+ABwJ+kOHaeMUf+VZYSKNi6c4QxRz/kD3t9dpaKAjfVnNcOKlCuN5Qem0hKNvUfFPUU9rnIJFsr/Mdjls+Uyd+5DEpmOVpiOG8AIohanfmIQPfsuZaBIyAegDvpnV79Uv1y+Z/k8RvU9XUvpS/m9kEYiOfLbpzklIdYmAI3BlZbCG9JhfYHbouOSVI75CNjTNfkj7F5yNCEtj84qcrrgkC45gLYOS1LqSr2dPs6Iv+mqzi3BpN4BzXccRpAc4RZR/U4pL/dbVBFV55NVSfJQ1173OnwTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXf2TZXhBHgTxyFF7kvirbfXfKiyqiEUNbwNDL6e14U=;
 b=HfjdT+gLbgrjMbIfJaTDdczsigUcwnFhhRzu+q5zSFvDA9LIeUqGTDqKZ4e1t3ercHrWOVfMGoUtPHwXuuxwNTBf6wnth4xJJ+fnVy9fYqSsiny2YFwwNs8tZD/5CjY3iX8thGYhfjEWiXDFcxJ6G+BeeQxPX8aCzZ+ZH3YmG7oGXDHapiVkT8vUfIq2wj0ojXGozj3I9gdrw3V7jMsDC1DhWqQ1b5vHFCZAJZ+VTHmAH6LUMIhx6DZzpMVcFKiW0HJjccWooC6oCGMrk7ZDP0cOvrV0ZUOoIapwVBlIVFN1dXFZtjB2NpzLHwRFFt/6ZjfXOqJ9fUFmyLdGiwvBXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXf2TZXhBHgTxyFF7kvirbfXfKiyqiEUNbwNDL6e14U=;
 b=hwB1mxLAdIBubjhwL9+CRzbgpMA+yuQ3tKvwfldaM53MSk89LtSOf9LQ7AlZUT3+NvupqjhvzvwKlZm0lMQKONruDd+hPa6FCp+wgfSrbsFR4Ky3luIhQtbfyAySfnlKj3qxLIdxFzhA1jE1TB7ku00745Dx/4HlYlTuv5u0Ufw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5746.namprd10.prod.outlook.com (2603:10b6:510:126::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 21:03:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 21:03:00 +0000
Message-ID: <b00b609b-13db-4404-8bdb-4550195362cf@oracle.com>
Date: Wed, 18 Dec 2024 16:02:58 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Trond Myklebust <trondmy@kernel.org>, loghyr@hammerspace.com
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: fstests failures with NFSD attribute delegation support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:610:11a::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc663e3-4335-4db0-2758-08dd1fa75ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MStzWDZLR285TE9pOGZBL3JLSDhkR0RxQWIrcTNKYlRuWk1zNDdCZ0l1YmpG?=
 =?utf-8?B?dFI5TzEvSU96ZmJWY1lsWGsrZ3duSmVIZjBBeFpvcVNacWgvTmdjZEtvQzIv?=
 =?utf-8?B?UmtiTlRtNnpTZWluVysvNkxDRnhqRXhBeG5wRURsc2dicklNa0dtOVlvNER0?=
 =?utf-8?B?UmttWS9VRGxqTTFLWC9PY3pkVjNmZm00aVRXdm9RTmx1ZU9UV0lqNDJlVWt3?=
 =?utf-8?B?d2RNTGVXTVE3UUNiVmNoL2RIWnUxdkgxUHJ6VXR2QXNDNjVmdGloRlFyWG8w?=
 =?utf-8?B?QXJkWkJYRCtqa0NVU0hjUXFPV1VHd1RtNWJnWGE4bmo4UjlxYys4SkgwRDhK?=
 =?utf-8?B?QzU4QjdCOGNIN3VsRWJHR0lVR1FqZWZwR24zRDVSN2pZUUd4Lzd3alhvaHdU?=
 =?utf-8?B?TmkxUTliTHQvSzRRR2dDbWRDNHptbjUrcEpvd2R2NjhzcU1vYk9qRG15MTB5?=
 =?utf-8?B?N1ByR3QwTmJob1hsYnpPc1pVWFdiUkYyZ2RCZkV6dTBrcHMvRnkxako4WTk2?=
 =?utf-8?B?ZHp3bzBGVUtYUUVHdmhiOGVhNW1SWFRvUHN1L0dmQ001Zi9TSnlMdXlxalNB?=
 =?utf-8?B?Q1NFVERWblVwbzNwRmNIaW1Uc3ZMRzFHOHlsOTNRcmZOU1o2ZkZoMXV4N1pX?=
 =?utf-8?B?NlRLdTlTTHRsRVR0MDhpbjE0cDFmYnRUNTRJNzBtTFNHRnBlMGgrVFM1eXgw?=
 =?utf-8?B?czBmSVl4U2FPMmJIOTJoVzJlbjAxUEJzbTlBNjFsSnIzMjg2K3F3U3M2M0NI?=
 =?utf-8?B?ZkQ4bEhuVGp0ekMvTjhuMndaOUxQZmpxaWNmN3dsUUlWWkRQOER0L1BVSnJN?=
 =?utf-8?B?MGZodlFka3ZzZmxjRDdwdDk5MzNjSnhpQkpDR2ljN3JZVjY0TStNdWx0L2l6?=
 =?utf-8?B?SFp4NVJXRmxXcTNDcFJlcmJyRERyMm14Wk5vNUFVUHdsanNXaUxEbkc2MFJB?=
 =?utf-8?B?RFB3WUN2Mkh1S2U0WmV6aEppWTViTE42cnVlNkZVS21BYThobUowUzd3TFpj?=
 =?utf-8?B?YWFydnR4YkVJd0RuU2ZNTThlaHhHcy95alcrRG8rWkkwR3NsMTc4aE5Vb1BB?=
 =?utf-8?B?NUJoaDFHdHRtNVUvMmJ1ZVBIcm9EWEVDNHVvTnA1TjBOMC9vT0x2ZVZ5eW1s?=
 =?utf-8?B?bk4vbGRwdXRiRXdxZUNZSGdYUndVRHFvaldYUDlwTlNnbXdPaTVtY3FLZlcw?=
 =?utf-8?B?SVZXcUM4MmJUdHozUnYza0FSdmVudkZ5SUR6eVlUeCt2Skx0OGtPZDFMQ0hW?=
 =?utf-8?B?eUhuNFVDOVBVOHFxeDhQMzgxZGd0ank5YjNBNmkrdExaeFd6cXl6NXd1TC9l?=
 =?utf-8?B?RVpYM1B4dVRIZFF0RmhyRTlkNWRRY2VzMlRIcmRLRjlKT2Y2L1ZTNDNrNUtL?=
 =?utf-8?B?MUJnUkluQk5uaGZSVlFBdWdpMFVSeHpQQXdOVUcvd2tOYk8zRjBvRzVVUGZk?=
 =?utf-8?B?L3Q2RkxnWEwyVmNRV1l0MkJmZmJmbkNrZnpZYUErZWFjeVVLckVoOTJwd21N?=
 =?utf-8?B?WjB0Y0srOHpIalVoQXBTNFlwRG85aFo2MkptblowaXNsMmNjZi9tU1BnaEJN?=
 =?utf-8?B?alpKTUlQU0ZPN3o2a25lQUpJT2h1aXhNaWszcGs5SGZUVFJwVWF1THZSNXM3?=
 =?utf-8?B?QlRGYnhsMWMvMEw2RDg2U01zbXJOdlBDdGRIcGZnT0dXWWZXcVRqVysyeWkv?=
 =?utf-8?B?OTN5bjIzMkRPYUpEMFRITTVPSktucnNmaGZIbHk0WDQ4b0lTc3RkbUdmM3VG?=
 =?utf-8?B?aWtpd0xlSFp4VU12dFE3WXNVVlBFTW1DNmF1dEpmdkxyc0FVdUpyZjhYMFpw?=
 =?utf-8?B?K0FxbWk4U2wyVktDNjQ2UEpkekZkYkFmN0Fad0NHMXpJdllRTnI1T0N5VTIy?=
 =?utf-8?Q?1vulhSJTVil97?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzRLT3hacUs2a3dQeElGWXg4WjVzcmxnaklZV2dXdDBjQ3dkNWw1aXZBK0Zo?=
 =?utf-8?B?WmhuODljZXkvV3k0V2NndEt2UkdPbG12U0dLaFZVQ3VmakFXL1lZMkpRZ3Nq?=
 =?utf-8?B?WTB3aTVmcW5yUnRtVUEvSXZRdFlvajhCMjZONmZtdTJHSU5Id1dtUGNyLytU?=
 =?utf-8?B?WWx5MnQ5aCtHT1lwdG4rdUhmSEpoL3pCejZNbVZUSURtWVBlV1kyS1FPUmlZ?=
 =?utf-8?B?MVdoQVZxek41L0h3V0pCUUV2QWF1ZFhobFdFdnpsSFBrYXBNQkJmeHNmNVJE?=
 =?utf-8?B?cHEwUjRBQkpHZ3lyc0hpb1dZVnVqaWRFc0FVNFBybkp1M0xMbE9ueE5za2pX?=
 =?utf-8?B?Tjk5ZUNGTDRGb25xOURNZU5jajlEQ1BLN09nNndLQTRUSklTRnYwQnJEaG10?=
 =?utf-8?B?cjdLSjg4MnB4U1IyTmxMZVpRTG1UYlZjQkkwMWRwQjBpTy9SM2NJZlk3Y3hF?=
 =?utf-8?B?TWxjUHptaWEzL0MrS21nUExJNm9oV3h5YkVKeTBjbkZKUjNCUFJveUNrSllp?=
 =?utf-8?B?ZTF4RlNpT3pZR2JrUHBVekR4VGNkS1Jua1RSUnNURUJOSzR1VmxrUWpuT0pk?=
 =?utf-8?B?SlJVanR2cGt5aUg2SStSSjN4dXhsZUFGRzNhVW1HVUQ5SGtMdUlrdk1DNXAy?=
 =?utf-8?B?eThHTW1qYUdHWlNocUNlZHl2ekRZTUZwZlB3cThWWWNDS3JhWWhJK2xXNFBJ?=
 =?utf-8?B?VHZsR09CcVlIVW90dTBQWDA0U2g4MS9samUxVThZQUNXbTA0N3Jhb1U2Vlds?=
 =?utf-8?B?V1B0M2J4dDdtSm9YWXRjL3NJVXZpcms4Z09TMFpLZ0hGMDR5R2NVMmJjWTdL?=
 =?utf-8?B?V2xFbzd3SU9JM1J6b0xSdlpZalYzdjZKQ0l4WlE5WmVKRlJWb2M5ei9OTWxL?=
 =?utf-8?B?emdtTTliY3Arb3VCQUZQYzhiNXFsQlJMdkM0T0ZhQXY0citrZ3laMFdPRTVI?=
 =?utf-8?B?OXd1d3pablJrRkdTQ1c3RmpUaWJmbzJHVkY0UG9uY2pSODliMDZuR01vMXpn?=
 =?utf-8?B?Q3laYm83dWpJaUcveWJBQXVoQmltK2dqRW5ua01aQnNQZmo4MTdOV3Uwd09H?=
 =?utf-8?B?YXd6SFN4WCs2aEJEczEvSVRYK3poUjFBbk5jdUNEVVpvK0xWMzh1L29XaVB2?=
 =?utf-8?B?ZkRhcmVjLzNkRXVoZDg2NnltaWpEWjk5R284M1N2eVlvSjlHWitIVGxYLzl2?=
 =?utf-8?B?OFFraGxYV0NPYUNqNnpUblE1dmgzQ3oycDR4clo0dmtDcFdwYXdJNm9jMlk4?=
 =?utf-8?B?UlpJS25FU1h1SmszTXB4dXVseXIvNWR2WGtVNjlZbUFhZlJKQWRiNjRFZmdR?=
 =?utf-8?B?MjkvZGlzeDNVNU9uTEJMMzI1YkJYZXRDOUgzTUxkdTlGeFNodGVIZ0ZQS2tu?=
 =?utf-8?B?QzY1WGlMZXdERjkyZTlieDhNMmlmT0lJdENjU0o4MVdJSm5xQ3p3bENUSnVq?=
 =?utf-8?B?MWYvT2FZWDdOMGMxTTg4OEVqOXRTdHViSkV2MlpmbWsrbUYwM1JicWlOSmFD?=
 =?utf-8?B?bEUrNG5Xekc1dnlTOWdvZmhDMTBnR2xlS1VTQkFPYlhFc0FIbC9ZaDQ4Vk4v?=
 =?utf-8?B?SHplMFdGbFNnSjhXdkhEbmVxWFljRXdod3QzWTVSTXNDZFl3SWVZUERMa2hk?=
 =?utf-8?B?V25lNmRXb2wwajJLRktQSklXeDQzaHpKVk83YStkUlRzcTgzaXl6MkprQng5?=
 =?utf-8?B?VXhWUnFIM3JYM1NPVVZlSWZxd1hxMVR1QzlsdUhhVkJEanpjc0Y0VFQ5ekFZ?=
 =?utf-8?B?VTJ1dTh0WEMvQlRBYlkyUHZtbGVVWFY3N0IzN2NtS205MjBwRWxtdEFabGtC?=
 =?utf-8?B?SkZRT3NyRWdNWjlmM1Z5NklBQ3RncGdrZ3JLbjd1bS9aMnV2MG9wRlorR0w4?=
 =?utf-8?B?aGl5dnVsMW1kMk56Ukw0T21yZDJyMXdRNEN0bXgxUlVUdkxEWjlxYWEzUG5a?=
 =?utf-8?B?ZU1XMGNra1YrZFhnemtpanQxeEZENzA1V3E3d2pwdWVVL1pQK2xZSEg4RGlP?=
 =?utf-8?B?UkkvVE9ubTFlOCtuTnNxcDBaVkIyUC9jYSthNkZaYlVjYnlPYlJCZVBtd1hO?=
 =?utf-8?B?am9OWlhEZ1FOWmsxTThSTFdVakIzb3U2OC9WZXhxZ0d2dHJWRzhMR0d5UTNO?=
 =?utf-8?Q?+iOdFkBd6v+XRDnueCZiSi8qX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	atc19LYVflh9rEVacUiQSIbs0qucAdWMP0DE2aPTyS0plFj8B+dVAzbiAxv0ed5NnwBmueFGOi7O7SREFEJBg1LT0lAoQii+QiXACRLv2P+SRlVcG2BfciEuhPD+I1LxDbT/D3KEzUH5l0upDnNaA1Eu2tP8u4qe3foPyiStkCQ+c23AozuEFwDdGKu7Jhy+RMIlvajcl4WTNBEV7vkMWpgprAyl8BDKTgiEnhoETRyJJN2GxF/beJ6Y/4oh4rLWom19+f4hXng8vnIRiDZ62YEvyjW2+nr06bRmUA8fF17xiGWboMsleLu4iO6S2zOEAWqujxuksqVu2kGBrMrWxfkTWxOZZgqSksqusijm3FVm3je6TG+tFCwDscTb5y/Nm2l89jL0Z712XCwySFAQahlpsVnhD5p2ICMCBdxvx6LV3JH3zjtDnKxZmrSgI0mdG9buhwHcLtZ0O9QVOq9ezFLRqRZ0DzRpT7mV1VeL/S/33RH862vtcztPp1tHcv+oQW8Ot1H/0GN5gUMbSYkt2bhb7hRQ531WBQEfrAEYcx04TsG02+N1aQYF3jI44FmYuBx+xHOrvJuRbM6g7xsd+OcyICqFl2Mssslec87U7nc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc663e3-4335-4db0-2758-08dd1fa75ae0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 21:03:00.2350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: De3hBMceAP9s2qTivupj+rj5pYoI6rVattoS8/nNXmVbjamxKYIF56IGiK7+Wxn7W0DqtfjZIxBo2MBEHwAHXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5746
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_07,2024-12-18_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412180163
X-Proofpoint-GUID: okoI7N7WdcQ4gRo7J_P4JsMrYpUz7LYd
X-Proofpoint-ORIG-GUID: okoI7N7WdcQ4gRo7J_P4JsMrYpUz7LYd

Hi -

I'm testing the NFSD support for attribute delegation, and seeing these
two new fstests failures: generic/647 and generic/729. Both tests emit
this error message:

   mmap-rw-fault: pread /media/test/mmap-rw-fault.tmp (O_DIRECT): 0 != 
4096: Bad address

This is 100% reproducible with the new patches applied to the server,
and 100% not reproducible when they are not applied on the server.

The failure is due to pread64() (on the client) returning EFAULT. On
the wire, the passing test does:

SETATTR (size = 0)
WRITE (offset = 4096, len = 4096)
READ (offset = 0, len = 8192)
READ (offset = 4096, len = 4096)
SETATTR (size = 0)
  [ continues until test passes ]

The failing test does:

SETATTR (size = 0)
WRITE (offset = 4096, len = 4096)
  [ the failed pread64 seems to occur here ]
CLOSE

In other words, in the failing case, the client does not emit READs
to pull in the changed file content.

The test is using O_DIRECT so I function-traced
nfs_direct_read_schedule_iovec(). In the passing case, this function
generates the usual set of NFS READs on the wire and returns
successfully.

In the failing case, iov_iter_get_pages_alloc2() invokes
get_user_pages_fast(), and that appears to fail immediately:

    mmap-rw-fault-623256 [016] 175303.310394: funcgraph_entry: 
         |      get_user_pages_fast() {
    mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry: 
         |        gup_fast_fallback() {
    mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry: 
0.262 us   |          __pte_offset_map();
    mmap-rw-fault-623256 [016] 175303.310395: funcgraph_entry: 
0.142 us   |          __rcu_read_unlock();
    mmap-rw-fault-623256 [016] 175303.310396: funcgraph_entry: 
7.824 us   |          __gup_longterm_locked();
    mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit: 
8.967 us   |        }
    mmap-rw-fault-623256 [016] 175303.310404: funcgraph_exit: 
9.224 us   |      }
    mmap-rw-fault-623256 [016] 175303.310404: funcgraph_entry: 
         |      kvfree() {

My guess is the cached inode file size is still zero.

Any wisdom you can provide would be appreciated!

-- 
Chuck Lever


