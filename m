Return-Path: <linux-nfs+bounces-13855-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435B6B30321
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 21:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E6D7BAAAA
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 19:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821D82DFA2A;
	Thu, 21 Aug 2025 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PJo04LXr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d/KyddA3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E934DCC4
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805499; cv=fail; b=nyyWoiu01bruTydbIbaqcYuqY7wPKG03/HVvaXu5fPpAejDLrFWTBvj+I9uk79dX62ld9rJGZcRh+ocbHda4+rnN869AmFH71JTv8QLYTojA1UIG3JEcC32mOG4a1cJrfcyTbgtjZUWrGUwIzpOLxWzc9dplVP/fBEhh7GecWII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805499; c=relaxed/simple;
	bh=iP7IihZwUdVy1yhSKXAButA42HPblNZL9jDYB/buuno=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uCXmTiUBblfE1IEkIUHC0zD2tHcGWAKacsVebUaLcAyr3jPTsvPM4aQu5is3O+8sOSMOL3Qv2PaO/tCjLNO+s+yOtgsiop6Pk228Li1AN77Q0w160o/gMX81JXPBg5bStbQY43EnS/zI3FdASq1cyEr5HMjm9SOpN2tqIcPZp6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PJo04LXr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d/KyddA3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LJPxpZ002255;
	Thu, 21 Aug 2025 19:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=etRT8JwWQB8MRiGQXOUiuZdYVQT7EOLT0XWlO+RBDJA=; b=
	PJo04LXr5hJOivY5QxClcYHM/n9Odw2/t1HvJHJn+fopzTDYLm8mdwufQu6Ub3wO
	EMN0oGLUFkQ4eC8TS6qZd9S4YoNbI0SnCnRaSxn0FqZ+8b24CARIHmTQIseIGUl/
	aYkeCdt37dFt8JqkfI9iQvAadLFQURTRq5Nq0uW9LE7zpFXO4tdsOKVrsijyUZ88
	Lps7mMO0B0igh19y4MdB8vJeGoIr4UpMDc9YN2un5/qYTblKbVqXJEzFf/3qQVa8
	P2SID4Mxq9Ofxx1HAPknwne3DgRNDYbDiN3Zu1HV3Q593GLhXkX77xj6FS6c9cnJ
	3QXSHs9rI63P1KBsn1QsEg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0w2ca3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 19:44:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LIDRfU026907;
	Thu, 21 Aug 2025 19:44:47 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48n3sxyrtq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 19:44:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTkov94/cuHFQqSWCFqKhnHloydOtLXhZJKzyS7zXe57GCj8Yi+SBZYADyYghCUF+TqtMzkzkTxCtDIP1lofvMidN8dWZtYM7x1D5urnZLHXfDdodHyMyEGxXaRUUkdM8RdeoIHD88eY/URBWGOFRW25ZV1FC+nwYzwk7MdWQDMtx2NUGHLoKVoAEZw4e+wflYh3jhwTmyB553el+7gMpK6qI7z7Tsettv771+IRxjM2BM9u9uHCSUDGuyCnVQTiQCXj77fL+U+2nT9tuBzI4XBUZ7b1ZKId6rmU5J9RYM5c7arJwUcrxDboNQRU5i/luB+sWbF4UeQ+s5wkVijxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etRT8JwWQB8MRiGQXOUiuZdYVQT7EOLT0XWlO+RBDJA=;
 b=WbX3El4T1m7MvU/HJUxa6baVpAS+5bOpYA8wqDUu0R3TH+genuge8og2wpJAGRNC9PZWk6S7PKmt2JT4z0NdNgWeVwGFrJHVctjHIO1k4Trbsi5qhTUeqZJCJtzG4QpNT+r356G/bURfnajIexTePGcDpn6AALP2Ox6SmvOSBDTcJpZG6tZQyLFy0wrB8o3jDHJ43JNUBZMankuJkIYp6M3dsEVfkbB4FS8jGJIDNkTAoLmt3aVzPu2Qx3odFnjVUZd52pQ+z7+jnS2JX2aFZgm/05n8bTG0f4VrNB7eg+O8lwHPA131NUY9LH6t9+gCc9em+z4HbdYXMAr0A/fprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etRT8JwWQB8MRiGQXOUiuZdYVQT7EOLT0XWlO+RBDJA=;
 b=d/KyddA3NMHKDYzvIeYH4C1AGmlGVM9QQybRXp6g7dePUehl0z8U4p6/0Cg9/YCvLNgr8OOgK2Xvg5OEguJaG1DbrM+EvnTMGIYPLdLfk1R1KUTBiVDTmBkdNje/jjJydlAabWB0tGc/d70yyl5lj+MAIA6w6hnbomnmnojCjoY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5846.namprd10.prod.outlook.com (2603:10b6:510:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 19:44:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 19:44:43 +0000
Message-ID: <d097a22e-fe04-42e3-ad3f-b69a056b5434@oracle.com>
Date: Thu, 21 Aug 2025 15:44:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nfsd: nfserr_jukebox in nlm_fopen should lead to a
 retry
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, neil@brown.name,
        linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com,
        jlayton@kernel.org
References: <20250812160317.25363-1-okorniev@redhat.com>
 <12407545-2fd9-43ac-8766-4fe8a1343b68@oracle.com>
 <CAN-5tyEJPk5RtC7SAFxUotgh4vaytmOyaZyY5Jp+UxYAk_tDdw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyEJPk5RtC7SAFxUotgh4vaytmOyaZyY5Jp+UxYAk_tDdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a0d4e2-449d-4264-b099-08dde0eb2d23
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZXdFMGNKWENaemVVckZlb2FxUmpKN1VQenFQdGdrUWhqcThFYi92Ykh0d1pQ?=
 =?utf-8?B?Z2VmTGdmbUxkdXkxSG92NWw1R3doNEE0djhnSmlyOHJhSHRpMm16SHk0WTB6?=
 =?utf-8?B?bTBVYXJaSmZSU3I5S3Vob0RYVWkwOUR6Zms3VlZZcERDRnBjZ1JFeE10MTFa?=
 =?utf-8?B?QTJ2SWlOT2tpMEhJczNDR1cweUtTb0pOTEltS3daSWJoMzVNTDhSdDZWcFJ2?=
 =?utf-8?B?QnlnUWdQNXRta3RQWHZhRGNBU1lwMEtlcjIwTmFWOFFIL2Iyc2pJVG0rVDly?=
 =?utf-8?B?WGs4aTA2RUVhWGFtUWZUa2o4M2pBODFWTTNRZDJQWTc2VFNBTWlSTEJvRUVK?=
 =?utf-8?B?L0J2WmYrc1pVTCtwRFYxRm5maVBNOE9ZTzM1TUJtcGdPSGdZS3A2OE45VWZO?=
 =?utf-8?B?cHZEVjlKZC9YcmNyemJLbUp6Q1RVVVZBdlJNUThKSm1HV1R3dXZXYkY3S0JJ?=
 =?utf-8?B?SmhqOE9HV1FmQmIyYWVrWnBodzQxYmVsNEFBYVUycnZLNS9DcUtOZ0hXY3Yw?=
 =?utf-8?B?RC9mZVhvdHV2Z3J0OWlXZGFvODBKT05xNCt4QnAySVJUSW5LNll2T2pDdGlo?=
 =?utf-8?B?Qmlsbm1vZm83dTBISFlBM09OeTNSbmt5bW5kUzdvelJ3cnFEUWgvYVl5bE1y?=
 =?utf-8?B?Vkc3NjRiUDM0aTMvUFBiS2I0c2l4SnVtN0xabkludGc4aS9LZll6T243VEdL?=
 =?utf-8?B?NEhiNjUxWDFHZUlFV3VhTzQ0dVVpVmgzRGV0NFBUS1d4RUt2QVByMmJKdTdT?=
 =?utf-8?B?VWVkczVCbFRqWDJkZE1mNnNiY0NGTEM0NFZreWphSDRYSmh1bC9laWhjb3VI?=
 =?utf-8?B?cjJzUEpxUjgyTmxkSHFIU0hhL1haejFTay9LQ1ZqZDBWV0s2M0xHMjdWdUE3?=
 =?utf-8?B?amNjYjgvaFc0d0tDbEVWclRaLzhUN0VnaU1CajF1RWV2Mm0yK0dkblFNVThJ?=
 =?utf-8?B?b0xHSmdSWHVMSlJQMHBXdDBYemhYbU5nVzlWaDMzZjdsZUc3OSt6VThQV2tX?=
 =?utf-8?B?SW50M0Jma2tPTHFXTERkQmFWanlEMldaZFFnNXppaGs5c08zODhQQzVtNnh5?=
 =?utf-8?B?V1dEL2dNS05QckcxeEtWMFZZSm45S0txaTVlWnVNVU1idGthVTdaVmZXaW43?=
 =?utf-8?B?UkplaWlPV3NqWDhwMkFEUGxjVlJEbXFkRFRPQS94NlRtLzd1dm5RTU1XM0xD?=
 =?utf-8?B?Q0JtTk1VUUVDZlgwNGUvYVErdHk1U2FoQUNuRHFONU5TSFFlNlZoNVY4eWpo?=
 =?utf-8?B?L3pUcmcwTTBDOEdwbXdlVEpUaXV2ZXdra2l3Nk9aUUQwQ3dEa3VkZnpZekJQ?=
 =?utf-8?B?cDBhQ0xnR1Iremo0NmpUcHZsVXBMQTB3ajZGbEdsbWVNeENqT3FhT2xSbFF6?=
 =?utf-8?B?TFl5SmdLbHd4SFhlaDBhRnlqUmlXZnRzN0U0Wi92azJDVW9pakhXMzlIL21M?=
 =?utf-8?B?eHZWTVhMYnZJbU1IZGxpSGw3dzhpSCtBT0dvTjFDcVBXZVluVmd4K1QxaGxk?=
 =?utf-8?B?TTJhNzZmL3RTT1IwSWpwZkpFMUVwTmNPUWx1b2tCS2ZQVmNza1l3VUtGRkhn?=
 =?utf-8?B?S0d2Nnp6RDh2UE5NRlRXRUxQV3pVUGwzdWp3cG5aZVZibi9yL0VIaHZQczFV?=
 =?utf-8?B?NTQ5eWh5RkdqWXBGMjR2VEVDeFB1S25DMmhhYmFxbE9aMG9aSXQxNENDTjkz?=
 =?utf-8?B?WUxZZFJmS01pS3luY3F4WTB6ZEMzdDJaSGwvUUJtUnVWUWozb29lWWY1TGx6?=
 =?utf-8?B?d1NrR20xa0FRTHRwMmh4TTFIWDFLdlBlaFZPUHhIaHRDcWdNLzdRTXM4N2p4?=
 =?utf-8?B?TnBHbXpHQjNrdFEwQ1RHNnltUlp1NDVpSElrY2VQaGxpZXlpam04K3ovd1Yz?=
 =?utf-8?B?T1liZHpNaU1LSk9sTzNiRmZkUUFsRndjdUNRSWVGMHBTNTFmZy9EcS8reVBQ?=
 =?utf-8?Q?1pMkHTW4U+k=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?US9vemFZM0h5c2UxMDFGcmk2T2lKZi9maGh1ajZtUE9kZ2pDaFhyUkNDZ1pO?=
 =?utf-8?B?V0FOWHY1ZDZrb3JRZTNXZkc5ZDU2bnl1NStRUzgzV3pnSHNpNVh3OGM1Unl0?=
 =?utf-8?B?YjA2OEEvQlFkN0kzMmIyYnFSNzNuaHg5SmNzOUp5bmpGYk1hbmpmTFZLdnhi?=
 =?utf-8?B?dnpka0d3RjZrN2JRak41T2NYaUtXMEZ3aVZJMDUvVkwxMlhpUXZrYlNJdHhv?=
 =?utf-8?B?Wjk3eHV4eEhGcEswbC9RRmVWS0orbHJ6K1dXa1BBUlQ2b2Fqc2ZNTERRTnNm?=
 =?utf-8?B?bklPSHVHVzFpWnk3ZDR0YVNZem4rSTNhb1NjVk1wcGx5RWQ5c1BZYm9xWENQ?=
 =?utf-8?B?c2Vua2tpQTJGNlIvNG5ERmNNYXpVSDJSd1pRZ1ZhdFVNUU9LSmh1YnBCUUdr?=
 =?utf-8?B?OVJyak9ERUNBZEhpbjJLM3ZHRW9MK1JBNitLcUNXN3lmNVdlTldEdlNwQ056?=
 =?utf-8?B?Qm55MzN5akVjaXNzUUlndzVMMy9aMDVFSjEyRkpjUVE1MlY5WEl4TzVWVHEy?=
 =?utf-8?B?Z1lxekJtOHYyWlR1WkFleHJZYXNqbDJ0NjIzd0xKbFNBN1JaeHFUb0k5c1Jk?=
 =?utf-8?B?K2JwakhrTGlFMTk3SWlxYzdBNUZuK1pFOXBVOXVQYXJ2bDUyQmlQUDloM3dt?=
 =?utf-8?B?cGZNdllrYm1DaFpMV0JXUDlIdndlaFlEd0ZOMEV5YUl3V1NycWZ4RnRUUjhi?=
 =?utf-8?B?cEFVejN2UTlWNUR4c25OM1lUL3BROEVXeHZ6T1l1dFc1SHpCcG9GdHRJZHpC?=
 =?utf-8?B?NWdaVnRnWXpQU0d3WURpTlpWRGVtd3hpRVQrYUU3ZE9NZ3Q1dlhoZXNyTW4w?=
 =?utf-8?B?SnYzWFFSZlV4ZEExMmhqcnFxTndyZmVLdzUvU04wV05DT01MaFEzMnVRQURV?=
 =?utf-8?B?RWZHY2lBbEg3dkt4NzNvelFtZFlqMXAwaE1xazNJNEhGaCsrRmVLVWUrdzFy?=
 =?utf-8?B?c2lydStHeEJiOC9vY3VjZ2FZVnZFSFhrbDFna2pvVzZOSmV2RE4yQmxtYjRI?=
 =?utf-8?B?dnh4WU85S2JlSkgyV01vcnlDcEpUSi9GY01Vak5vN0ZON3hUKzNKMC9WOCti?=
 =?utf-8?B?ZzNzaUhnb1FwVnpucXpEYTFLdnNoT1ZoSnd0aHJuekxwRjZYd3VYUTQ0RWIv?=
 =?utf-8?B?bURZa21aMkZ3L3FnaTlwQ2ZyNC9TTzRIS0ZoZnFraU9RMTlXSG94TkIvL3Jt?=
 =?utf-8?B?N1dIZWF5QUVnMG1UMEpKRXkxSitDcVZOQ2g5UFdBVGpKeXV0SzNWZXFRQURj?=
 =?utf-8?B?UkxhRlRhRnVxRGR6d242dlNQaHE5OHZpTkMyR3QxRTMrTnV4YkdmNjFlc2pv?=
 =?utf-8?B?bm1iWjFHWHl0R3kxTXZBaFI4UVhySFlVdmpWU0tsdTV6cXY2dUpnL1M4b2xv?=
 =?utf-8?B?MWRRaFBlVi9RLzdEZ0k4YVcxYzZlWWdHQWoxcThINlEycVJtWlI5d3RzK2ZC?=
 =?utf-8?B?Y2xpU1RnVTJ0VUN3amVNSVYwNndkVlNVbldEWi9PU3p3ajkrRkU3UVBlU3ZE?=
 =?utf-8?B?ckVyVWFhNzNmMm1rME1ZSSsrTG1uU24xcHV4eDhncXB5bnU0UTlDWHhxTlky?=
 =?utf-8?B?RjlMMlhSdVkrZitNVFRyWll1b1hmc3kxdGNYN0RrRGlPU2hiZ3NQeDN2eE5H?=
 =?utf-8?B?ZXRTUzVqTVR4bWsvNzgyOGtqeHN0UWMreHlCSXVTMEJYcFZhMWtnSmlKQWg0?=
 =?utf-8?B?MHNzbGtLTmlYQjRvTzdTb1JiNlowL25NNk9aMzZTWGczcHNadkNic2ZKQlpX?=
 =?utf-8?B?anJyaWkrbUJ1Nk9UU3lNazJnK29QZysxUXNHMDIreEdwSTNjSm9ORnlwaWpF?=
 =?utf-8?B?REtOL2xrUXVUUlJyTVVsMGZaM2llUjl3Uzh6U085M0t2R25oa1NFTkl2YUR6?=
 =?utf-8?B?c1NKZUF3MnRxZCtVRWd4YWRYaXZKWnhVYUlvSWt2T0lzMkE3Y3B3a05lekU0?=
 =?utf-8?B?K080ZnZTZnVxYTJkem5McjFCdEpvRXBnaHVSdFRveW9TZkZYOXRucysrTy9E?=
 =?utf-8?B?Y3pZOUlRNmdpUXQwQW5pR0JDaGh2MXVNc0ZmcUNjRmVDVlJvWWZ2TlY3RC9z?=
 =?utf-8?B?dVRYMUVvemU4L21RMGVuNmU2V0pTV2RpSmtRTSs5NnhGMnhiYTc5Yk1JOHZr?=
 =?utf-8?Q?7i29xPWUi6u0dhDQDPDQlLG9W?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VsENfdEKhhO9ZIXk36TRNDmYvesfWGdEo3mlHxsP7urTMoeoCJlvBv/nDCry0vloDWb1RgVhdq93YGlQARsRQhRWiTstTtieqS33dLiIBl+VangD4l9SLZT02z/9JSmCsvvrL00pV+RPNolDyF2fZj9DEPKcjOzTlu+Z2HXmpvmADfx/KfybML+mYAXEHn4Ytn2B4yk/Fn/W8Vyr7rVDmt3Bl5cOQsMEU7iCgDTCManzAizxhdVioxaa+6hFThGkppHnplWt/CNlTDmQHnF0cwbnZeZuNUJGHP32/Nw5gBYAdjZ74Jh8iy4aB8CVz+19/weahGVUCwnuCHnnBDwzNxf4PvsmvVnfan00TEmwP4O4sOguEySqeGrOLA3XfhaSJPRJDVhcFA9jdlG91xGPqhlZ1laXSxde8Vo44VDgDmvoklquYeqFbHwAt3xcU/dl3uVpmqIUwtRVgbp0ppwHBmaphLHYUEOfbKux3vwcld9MB4iPP6fEIY0Jgq+OYf5KyXsSVDXVfOPWyjVWRIWNdDk3Don1w3nYudJDARKNMmwV72FnJQ8FpIi3Z1DJ3X6UbPikfBDiWY+ufhc3GtLHYxsLuF7n7yIfLhFeEOUa8nM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a0d4e2-449d-4264-b099-08dde0eb2d23
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 19:44:43.8739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55sXCaQHexshxIojAWeKI+5KpEirdZqe5UMV3ZZEH55vwhLLG6qGKJCYxCJdcQehgbuuBoVCvjqHy/8cyjiAgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508210166
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX95YqHWca+c8e
 asggSBoxKBA7KUosP5Hq9Aw+92ePGaWQNImAs50joEGKjEuCz3yIBKCvoByAlVw2mpDrQxA0Iuu
 7ZF6FQvA8cKvsWHqwVqdf6jCYF26nf3yJ1wPj2G6UfEdFM853Nbn+qD+8evZxfQf4/MzgylZ2+C
 xsONIySZ+6YaOTwvcIElrtTKhycrIiZinNpsVVXJ7cPh9diKWAwQvFtMlVTUIipQF2kazD2r9C/
 toLkvj9QWvEHteMxwk3yxp9h7f+RV7SmsF5F1JnkdVFwiAR8oADeaJFo83ZskVCQ87291qykNFx
 1oLYkLFFkShGtdIAi6+FsEXpHhYlf1xEC/+4cAIbGteEtE3r21+JM0u7lt7Lnvdvp6k7070YPeU
 0viJrS56P5TAy5iB1v3FpmMxCXwAIA==
X-Proofpoint-ORIG-GUID: b789QVyNaG7CUchSN_TzI_XEitqURqz9
X-Proofpoint-GUID: b789QVyNaG7CUchSN_TzI_XEitqURqz9
X-Authority-Analysis: v=2.4 cv=GoIbOk1C c=1 sm=1 tr=0 ts=68a77730 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=Z2oN_auSvsf00YHu8_cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22

On 8/21/25 3:28 PM, Olga Kornievskaia wrote:
> On Thu, Aug 21, 2025 at 3:18 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> OK, let's reset this discussion.
>>
>>
>> On 8/12/25 12:03 PM, Olga Kornievskaia wrote:
>>> When v3 NLM request finds a conflicting delegation, it triggers
>>> a delegation recall and nfsd_open fails with EAGAIN. nfsd_open
>>> then translates EAGAIN into nfserr_jukebox. In nlm_fopen, instead
>>> of returning nlm_failed for when there is a conflicting delegation,
>>> drop this NLM request so that the client retries. Once delegation
>>> is recalled and if a local lock is claimed, a retry would lead to
>>> nfsd returning a nlm_lck_blocked error or a successful nlm lock.
>>
>> If this patch "... solves a problem and a fix is needed" then we need a
>> Fixes: tag so the patch is prioritized and considered for LTS.
> 
> What fixes tag is appropriate here? This is day 0 behaviour but it's
> only a problem since additions of write delegations I believe.

How about:

Fixes: d343fce148a4 ("[PATCH] knfsd: Allow lockd to drop replies as
appropriate")
Suggested-Cc: stable@vger.kernel.org # v6.6

(I'll remove the "Suggested-" when applying the patch)


>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>> ---
>>>  fs/nfsd/lockd.c | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
>>> index edc9f75dc75c..8fdc769d392e 100644
>>> --- a/fs/nfsd/lockd.c
>>> +++ b/fs/nfsd/lockd.c
>>> @@ -57,6 +57,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
>>>       switch (nfserr) {
>>>       case nfs_ok:
>>>               return 0;
>>> +     case nfserr_jukebox:
>>> +             /* this error can indicate a presence of a conflicting
>>> +              * delegation to an NLM lock request. Options are:
>>> +              * (1) For now, drop this request and make the client
>>> +              * retry. When delegation is returned, client's retry will
>>> +              * complete.
>>> +              * (2) NLM4_DENIED as per "spec" signals to the client
>>> +              * that the lock is unavaiable now but client can retry.
>>> +              * Linux client implementation does not. It treats
>>> +              * NLM4_DENIED same as NLM4_FAILED and errors the request.
>>> +              * (3) For the future, treat this as blocked lock and try
>>> +              * to callback when the delegation is returned but might
>>> +              * not have a proper lock request to block on.
>>> +              */
>>
>> s/unavaiable/unavailable
>>
>> Since 2020, kernel coding style uses the "fallthrough;" keyword for
>> switch cases with no "break;".
>>
>> Although, instead of "fallthrough;",
> 
> I'll add that.
> 
>> you could simply remove the
>> nfserr_dropit case in this patch. That would remove the conflict with
>> Neil's patch (if it were to be postponed until after this one).
> 
> I can re-send the patch with the fallthrough added on top of Neil's patch.

If you agree that this fix is appropriate for LTS, then Neil's patch
needs to be rebased on top of this one to facilitate automated LTS
backporting.

I can drop Neil's patch from nfsd-testing and have him submit a
rebased one, once this one is re-applied to nfsd-testing.


>>>       case nfserr_dropit:
>>>               return nlm_drop_reply;
>>>       case nfserr_stale:
>>
>>
>>
>> --
>> Chuck Lever
>>


-- 
Chuck Lever

