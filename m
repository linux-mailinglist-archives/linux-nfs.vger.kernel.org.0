Return-Path: <linux-nfs+bounces-14843-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EE2BB15F7
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Oct 2025 19:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6CA3B73E9
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Oct 2025 17:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4C8255F3F;
	Wed,  1 Oct 2025 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m+Zf2i7o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LXmqhrxv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E17D288DB
	for <linux-nfs@vger.kernel.org>; Wed,  1 Oct 2025 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759340226; cv=fail; b=BaYU5Z0rJeBD+4+Rxn04+rq/FkV83tQPTgxfqHj0AP9GhaEFx6+xd1QAhl5NIxlU5MnbDKXNUQycxm79Oqr2SNYDKH9GOy0Hv7aLUyGS8UhN1m4CXmsiXoQrLVzU7tKU089HZZUYb643Kzud8nTE2NVdJBzUmLCyQNeabupjjqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759340226; c=relaxed/simple;
	bh=9A5SMrUAYq+DuR9Y72MTK4OozIZRGlG3iKcLSMOJ+Eg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CF4J0v6wjQceijkXdA6O/hphAoZRmLO3MeaFNcckxeVkbLb06wcdmKwRXFIOz2mTHSIKo+EnGeOeN0TA7NpKMIn+l6H8VDJ9CpxiKmhjmc8ZSOK1oNmujIakQq63BgDAKQm0FFB7A2UnD7N19ZzqDUcF64E+7yfdgD4sj+MQVSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m+Zf2i7o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LXmqhrxv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FMwZK022857;
	Wed, 1 Oct 2025 17:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oiv20PefeoLpKQFxp5TUEqmmFJXY5UuKwB5cq2uryRs=; b=
	m+Zf2i7ob/5XangMpKoElVZhD3BGPNeEhaxeSgoD3GO3pNM2ufFVu94O3TobRKys
	UFLypkJZgXPYc2WJk6HNcdkphT2kWmt2Y6vPqug3uzZeOj7d+0i5NuJCKxUnTKVJ
	0DjTQQvK01DPZoQ0FADlTtybZKuNs6FpCrXy+HYaPdOGxn88cAhvKtv8jGKrx0Wa
	BcpSs9eXghhU4VTiICkRiPFYfmVSTxPzj9210TMT0i9hcmqbYPV+Qz4HEJgerBcX
	WBJk1asCEE1KjQafTsEVFMNzBFUKDCl3I6OFVUyTm9rty0BJGx5hefC030fWlr7C
	2xXjyIzVTVqpR/wmmKxO9Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gm3bhyg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Oct 2025 17:36:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 591GYxXS012207;
	Wed, 1 Oct 2025 17:36:53 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c9gc3y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Oct 2025 17:36:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qW/VZkVygS0r4FMenssEaiLqlBlCpJmWForo70CkHlDh10yozMCkTk6qd/WA7t77t787VAZSj+P+e2hOzld9VevpFUH3jhK2wzCerp0HEEQB0RKePJgszjUBvd/VwQhq8eNn90ZT5UJtbnjM+UhFzC6tnpWwv7QR2cK8CyQWJkjIR6Jun2yZhivi/S9YY9YGBkF1/r7wstMtfluK7MfBReXNXvwn5OjtupdN0Pmk2w6VcWiErrLa6B2Y2zbUrjyfDiSIBijEh203TYzTx4iDH13kWxLxZGuWPFTT9abxi1emOziQ7TXLb+oxeKXLYFtcNSz/631BEH945LN0DXm2uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiv20PefeoLpKQFxp5TUEqmmFJXY5UuKwB5cq2uryRs=;
 b=Zfq/1hy4a7GVi31Yqh0an9+xRgURxBEIXfi2wg87mllwnMN+sJIaebsEWiWlp1n6k0AUflA2kcSIzk77tDmfD+tehA/xtwwMKKYkTVc0Nq67qJnkvxvjn8kKWGW5ySqQUlYDldA7dT7dUXeMiY3lRjTYJuh0FUQKo5DQjyu6yGWSOiH1nFB72/zKW5LuJEhCShCAbjokVz7XqsH22brYRtOeo8vXcy8v0F7JOcN8EJ2m7E9fPV2qFcXohgF84ohfwKEbwWgvmrePkjJ7l/OOHbYLaigF+gDld7hDaP+fYhbgEOXHXV/by2r89L/0u4mMSNp6YccAvG4c8N3ldI8VVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiv20PefeoLpKQFxp5TUEqmmFJXY5UuKwB5cq2uryRs=;
 b=LXmqhrxvOFgf+pXQ/cBod6eh6hkx6wETkU3bv+DkZunlbQP/QBOZDhOj7aSCxWq5RTaDrEv4yKSd+E043/PIo0Ynn9bBna+EZZv+WR9kggfJBfoLSEHbCcsl6w0ld9sAn/S/OvpDpIq/GoVzdPtRi7yzAdKo/TcwfpEojdZhoow=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MN6PR10MB8143.namprd10.prod.outlook.com (2603:10b6:208:4f5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 17:36:49 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 17:36:49 +0000
Message-ID: <c0dced8a-29d1-4b5c-9fe6-47d065aa7255@oracle.com>
Date: Wed, 1 Oct 2025 10:36:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Fix SCSI reservation conflict causing pNFS
 client to revert I/O to MDS
To: Benjamin Coddington <bcodding@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com, hch@infradead.org,
        linux-nfs@vger.kernel.org
References: <1759249728-29182-1-git-send-email-dai.ngo@oracle.com>
 <475D1227-CB10-461D-9EC1-A303B74A701E@redhat.com>
 <ddcea773-3d9a-47d0-b857-087655b2ec13@oracle.com>
 <AFF0E6AD-F593-4CCE-89E3-AA72E1650D99@redhat.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <AFF0E6AD-F593-4CCE-89E3-AA72E1650D99@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::19) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MN6PR10MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fc89f9-0510-4210-2927-08de0111198d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NjE4WnFscVVZUm02SVY3cStoaFFMZ095eTIrc3kxZk5aa0p3YlNXT3FPTWh1?=
 =?utf-8?B?WFI3dXNqaVhWTEVmTG5PY0FpaDI0YU1lbDNUSnFBMmtHOE5zemwxZkdLN3Br?=
 =?utf-8?B?ZXRnMzNoeVdVT01LMHhqZ0tWUTJmZ1JiSENwTXpacC9VVVkybGNncTRsc0tC?=
 =?utf-8?B?cHlMR24xZGt6VVNJR3NoOGpvbHBESFhMQnBVckwvTVp1anBrM1JpUzdUaVVq?=
 =?utf-8?B?b05TZ3lvaXgzRzdPM09HNmNSTVBWUTIvMG9OM3Z5QlpDMVVEK3V1Y3NyZkpx?=
 =?utf-8?B?Y1VKanJXQkF3YVo2cHNTMHUwblJPZUI3VGlHYUJiVS9DWE93VnFidzd6d2Nl?=
 =?utf-8?B?NDVIUG1oRzlXbWx3Y3hWeXlSajRDSWtyamU1bWdLOFRLRk1BWWJHVjJlVGp4?=
 =?utf-8?B?dksxQVVBc3dSYmVvWHAvSlhuK0JZVU42QTNGRmhiWlNtNUJkdERQUERjcERt?=
 =?utf-8?B?cjdSUHpXL1dSalZWUk9JSThodmtJN3dBYm9YOGtQcmVaazV0aEZVOEJGV3ZZ?=
 =?utf-8?B?RjVrSkxNdmtETWtiNExXVGdSN2piM3JxQmJ0b2J5QnhKckJPN1RSSUtZNm1Y?=
 =?utf-8?B?Rkd0Rk1rRVF1SmprK1RhWXYxWGNwb0N1NVA1NmJPUys1YkgrQUxIQnJadllB?=
 =?utf-8?B?YVQyb0NldG1kcGFLQjV5YWdzdUNBc1dEaDR2T0ZJRmxhWCtNYUhPU3c3VWZQ?=
 =?utf-8?B?RlJtcWFReUF6bmoxU2JaMUhOdzdQQ1l0TlNYWHNicDNKblczL0tNRTVxZGc3?=
 =?utf-8?B?MTlSdGNRWC92eHFBVzdTcUFWZkVFL0N3Vmw4WTJpOS9ISU84MWlFbVBVVUVq?=
 =?utf-8?B?aktPdThmbEtGWHFVZlJMb3FUcUlpSEVYRUpRTGR0dDNCb3FsWkFveHg1WmJE?=
 =?utf-8?B?dU1nRDhTR0w1Y1JCazNXdlpoWnV4KzNCZ1dnbVVnd0NicFhOZmZOblNPckVx?=
 =?utf-8?B?VTNsRTJteWZsU2JabmJhdGZRS2sxZExBZU15QXhKWEI2UFAvS1FCdlpmZ0lG?=
 =?utf-8?B?bHRCMlcwdWJBa05tZlZ3dzJMcnM5bzlOeXc2QlluczY1N2ZrN3V4MDlVRUpm?=
 =?utf-8?B?NmVjN2ttK0lpTDdtcmhvTlQ2YTQvNkY2MUNOcVFnWmoxdk44Y2lVamUyemVL?=
 =?utf-8?B?aS9DUWJXRGxrSmxwNUJCTzBOYVZYNjF4VFlqOXFBTUVHTVpCVWZLMWNXNFor?=
 =?utf-8?B?SnFlN0ljcDdMUjYyUzBOR3ZrY2RZZG93eDQvVTBwN3FLcHNYRkRVRFVad3FC?=
 =?utf-8?B?bjZHQjhhWUptR0Zsc2c4b0d1ZzUvaHRnMGZrUGw1dUEyT0xTcG5HVisxenUr?=
 =?utf-8?B?UUltSW9GRmM2WGxHbG95VmU0ZVFXYnJ3UEhyeThVRGZURzdWZDlmNi9jU3ZU?=
 =?utf-8?B?eEVxT0NJRWJpUkZjdW9TdFlCSkllcW00dEI3TjRNKzhFWlhtazJRSUtFQlRv?=
 =?utf-8?B?YllKeDUxQ3pwMkNoUFBzQ29kZXgvZ1J4WUNURzBnWFdBRGE5S2pYUWRrZ1JF?=
 =?utf-8?B?UjlrV2dSbGFIMUs2Q1ZWT3kwQjFNdjdMeTg4ZFNSandNZFczOGJSbUZmdTlQ?=
 =?utf-8?B?KzBYMnN0dFpmUFEyb3kycHNHd1N5c2pHMGxESnNiYWIzcWFmRFZmRkJhdGpQ?=
 =?utf-8?B?Vit4UzlCcHRJazFZSmp0UmJOc1MvRUlmOW9qNlpYanZIL2xmQUZVWk5aRC9U?=
 =?utf-8?B?ZU9aYzVsdVovM3diVk9YNW42V0FhL2U5ZzBwVnFRem15QXhTL1BOZGl5WERt?=
 =?utf-8?B?clZXYllXUWpaV1pqM0tjUGl2QUJrMkhnQmRDM3NRd0pQeU0zRHI4MTRhZXZS?=
 =?utf-8?B?eVRxS1dReUg4S3lLS29kZlJsYUt1Q0NhS2xFd0JsUVQrUmZWdzFIUnZSakM0?=
 =?utf-8?B?aTZwWTBveVdkMEpTaVRsQkpiV1R4OVJqUy9QWmFxUEJ3dFE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dHJRMW55akJ1cWpIeVVDa0RPak9BTW9OTkZnL3ZtQld1eGp6VzErUGJ0S3U1?=
 =?utf-8?B?QXRQMEVzRFVIU2tjVXZuai9tUFhEbGZPN0lBWUNIK3Y0M2thVGlLaVBzZHp2?=
 =?utf-8?B?ZTErcjdIQUhBQ0N0SE5tTld1UmlOSmZXRHdJQS9xMGF2dCswU05Kc1lTdzdI?=
 =?utf-8?B?U2o5eVZ1U1VEVmp2N2hWcWZYaFdkUWJ6bFUwRHJKWjV4QWhWZm9lVTBSOVhn?=
 =?utf-8?B?SDU4blVIZjk0anJkenJEdU9DYmg5anBXTTFyeWFiNnFIT2RVRXpraTJBdUlu?=
 =?utf-8?B?Ym9NVm5MUVI4ZlN1ZFdEWDd3WEhLK05JaFdBMlhjcnh2dktKVVk3ZFNmN0Nr?=
 =?utf-8?B?RjBBY201ZUw3SXlmMDl1NHBxSEtUZkRzR1Boc0wyRGs2KytCdTcvV3N6VTNQ?=
 =?utf-8?B?MjZBRmp5dEgxZEdzMmI4YnZvUUJYUnVUWFlzYThjNXEzWnh6cVZ1T1RUdFZT?=
 =?utf-8?B?VExLZEFvZjJNR3dBZ0dXdmtsMUh3OUJncDlYQVBKSTlGZDBnZU1vQnFZMmNO?=
 =?utf-8?B?UHdnSW03bDlyVjNKRnBmZS9uN0s0N2VVUTF2RW05Nkx4R3pGcU1mRnppVW9E?=
 =?utf-8?B?MXZlb2Z1U3VteWREL3ExLzR3L3M4SDFXMTNUL3VUdm5lMGlwang4MXlOZ2Jt?=
 =?utf-8?B?U1NWbE5XYXpSNDFXTG5GUitmZFBSc1JXN3BGSHJKU09ycVZIcXFnVGRvYllx?=
 =?utf-8?B?dHVzMFNWU3luT0s3QnZ3d0JNajlRZ3dBQVh2UVlxQkpnU1kzV3c5RVlaY1Nv?=
 =?utf-8?B?YXBtOFRxYytYQUV2bGdHU3E5NVQ2TEp0ZGxBcGJ6YjZjUzZFMkl2UEZPZWRE?=
 =?utf-8?B?QnB4bEc1bzNCWVpQTnVSZUhrWjFwSU9keFlvOUVYMHZwYmk4TFVhRUJvU3Mv?=
 =?utf-8?B?d1Y5SnhqY0wyeS9RSTRxTDhMVFlTNXpoZmttVDRqeVBZb3FsM1FBcEJSaUdz?=
 =?utf-8?B?dWhBYzU5NkJZS3Erc0NIeGVVMndUT3pCMm82cEM3L1VGVklCaHhSN1lQbWZK?=
 =?utf-8?B?MURBUlRZQ1NrM2MxRm1NTk1ZbzExMlJ2cUszTlVFeHFKWUtFd2pGRks3Tlp3?=
 =?utf-8?B?Tk9oYlJQWU5aMjhwTXZxV09xVUJFZU1NRU45SitUU0d1VzU4SkJzMmViancv?=
 =?utf-8?B?TW9TU25GblQ4dnlmbVQzNDZBUUNieFFtQWk5bTNmblhWU0x2TTJiWUNINFdZ?=
 =?utf-8?B?bktBUW1QTEpXN01pR21LMm9nT0N5OUEvRXMvcHhyKzByUE41SWY5Y3FHaVNr?=
 =?utf-8?B?U2pxSkN4MSs2bzkwd2NUbDcyTXdXdWhoMW5hZ2tuQTBkTmtaeDRYS0FYeGMx?=
 =?utf-8?B?N2UzaCtTK2hsd2FkZG9STktNZm1jN1NDQkZick1tY2cyanI5bE9QWE1KcS9O?=
 =?utf-8?B?R2ltWFYyNk5RdTBIL3lPMG80VEU1bHpGS2luVUFheDlRT09LVWlqeVlVY0NT?=
 =?utf-8?B?TU5kc2FUK3FNUCtGd041VUd0dTh5L1BPMU12aWdzcUdzaDBwOFZ4N2c5NVhU?=
 =?utf-8?B?ak56eTNXeUxpOVFwS1hiQ29WbGdpelJleTZMRG5HbDVvZzZWdjAwQWJVNHk0?=
 =?utf-8?B?SHg5ZXRrL2pmTDYxVFYzdG00bjhTb09Tdk9OVWVxUjNHdGYzR25iSm4zYlVu?=
 =?utf-8?B?NWxHd3NMcTdWNW93L0V1bDFmdzNEMlcwV3lHMnNTZjE5QXdVVlFJb0YxTXdX?=
 =?utf-8?B?TTNqK3FRcTloU3E5N3pBOTlwMU1IdTJ6bkhVKzdVTGt1U2JBSTJLenlhYTdE?=
 =?utf-8?B?WnlEYmxheHh1QU5xdHhmMGpsZ1FJTVRtREtCVlFRL1Q2MVVwTlh5bXRHYnY0?=
 =?utf-8?B?cDQybktHV1RtUG1TdGVkUzgzV2FZMFlHQ1lNMHYvM3AvYjZ6cFhJdWU4WHJE?=
 =?utf-8?B?VGNpeG82eUVqeUJUTzVtV1JoaHZqVTNpaWpSV2sxMjNlNFludWJYT2FRT2VD?=
 =?utf-8?B?TlNDVjV1ZVlEWnV3clEvaitTQkdhYW85dFVFRW9Gd2k1c2IzOTJpRVVhcDVB?=
 =?utf-8?B?TnlFdFBCbGFlSlNCZkNVS01iUHk3KzA1NTNXc2JrRWlSWkhKQmcyZmN0UXNS?=
 =?utf-8?B?Nlp5Nmk2TU5rSmxUSVlUMDJ3bFlUTWtqVno2bTlWeFBjWC9BVEVFR3FxSndh?=
 =?utf-8?Q?DNpwZ6z/WsKJOX2F81cbqPGgw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nXywYS7o6CA7RwjYodkgCtNsvkDAtAhncUaYsdwpG4sTUBv+Ej17ZJI+BBVC8cYBTeJehUhVxYhvd7cw5E+JrIz5N0OfXCTtWATya1fboID2z0/KvuV7rEMFjtUCNfjVPpL8+orf/ujwLyt5A2AT2C7uTEUwNHE2iMUp2O+GTV9v76PZVO44p0goB9mlLRm//9GqFamNZ56ibZfzzarpKL9p8aHCND/1kQxuZGFHRPHBZNhAD1RDVLWu2fDxa9qCEMaSx4D13r7RSKf4uQjNmOxGhhVwOdIhMLgdWqiylH1j3x6UUnnQ/CK8LITGm1RnTSu8UWrtu2gIun40p5UKM0vjbRmtSEW5TWERgumm2bg3kgN6gF4usMsotVcNRisR0ezeqSP0an/BxZeORbT/QYEjbCvrUm7kj+zupz6r1k3ezE7QoQ1vASl8dq/1AafO1OiyMdk1UCcwDjF9qlTfwoflCB4TNgrHRBpFxAMgXZ9bFwAiWbnPvV5SjjCpo9VBaYsJhG6BwDmIIY434AlX1C8+nGNK55k7h612iE5SHvhnxwRcCC7XiuFkSkbv4a8Pw2mTggJWui9+Pk8iiheNizTE42AUjCdyx2+rMZNjlJs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fc89f9-0510-4210-2927-08de0111198d
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 17:36:48.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJW2M+YSW8CyvUVtOhTT17jA6gzo6XFw60Wo9xV+SE4TpZk6vx6SdPsUiBm9JbgLiBIJu2ZhpMWdDZ7M9EPT0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010153
X-Proofpoint-GUID: ko8n1rS4N4Dnpc80blzN_xUTd8ntNN6X
X-Authority-Analysis: v=2.4 cv=GsJPO01C c=1 sm=1 tr=0 ts=68dd66b6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=JLDxV_SaAAAA:8 a=cTMn-MkfAAAA:8
 a=Tkzs2uh9MmAJMMnnN3QA:9 a=QEXdDO2ut3YA:10 a=_uzX4oWg-uDLJ6b6Md12:22
 a=07REm91lqynEFC2MfXjm:22 cc=ntf awl=host:12090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MiBTYWx0ZWRfX/osHnxU2dPfB
 zzmgF5PQlUZVQs/TIGe1CYRrs0R5Hkl8SSlYTZwr8q7o+1daIHDRvIOWEt3PtqEzctqTe66egwd
 6rR7Y5g2E8E+NzveM6b689UYFEx7I2OLW73Y4hPY2gQmkbsvcmo2Gi6spvJ5NuP8VvRu9FWRR/v
 2D7sf6HQB+ay2cyN1Qzg6mfYLf2f4DSklf1VgmLY0ZPnmWJ+2vI0k5+Pp1iY3QDeMhWi+KfpPfK
 yYFXgXd8pKVyYNq44rTTFn/qVyqifRDqnAwAIPsGwMnnoAs1GQJknO24QXFkQ62Omqe6yQ20nwl
 PiMqjFOhUnlzDRWVaR5st/xcX+DzclofNE7pp6fDo5Knd04jTyauvUMObD0jh90YuHkgEAnLOJB
 2LQTGQ6KI32VzMh8rfz8EDoiqY9TnbOtcFeHrmFtTjDpiK4TJZM=
X-Proofpoint-ORIG-GUID: ko8n1rS4N4Dnpc80blzN_xUTd8ntNN6X


On 10/1/25 3:54 AM, Benjamin Coddington wrote:
> On 30 Sep 2025, at 17:41, Dai Ngo wrote:
>
>> Hi Ben,
>>
>> On 9/30/25 12:15 PM, Benjamin Coddington wrote:
>>> Hi Dai,
>>>
>>> On 30 Sep 2025, at 12:28, Dai Ngo wrote:
>>>
>>>> When servicing the GETDEVICEINFO call from an NFS client, the NFS server
>>>> creates a SCSI persistent reservation on the target device using the
>>>> reservation type PR_EXCLUSIVE_ACCESS_REG_ONLY. This setting restricts
>>>> device access so that only hosts registered with a reservation key can
>>>> perform read or write operations. Any unregistered initiator is completely
>>>> blocked, including standard SCSI commands such as READCAPACITY.
>>> SBC-4, table 13 shows that READ CAPACITY should be allowed from any I_T
>>> nexus, no matter the state of the reservation on the LU.
>>>
>>> Is it possible that your SCSI implementation might be out of the spec?  Also
>>> possible that SBC-4 has been updated, I haven't been following the SCSI
>>> specification updates..
>>>
>>> Ben
>> I don't have access to SBC-4 spec, t10.org does not allow guest access
>> to their docs. Can you please share the content of table 13 here?
> The document's licensing prohibits me from doing this, I'm sorry to report.
> I have a single-user copy that prohibits me from copying or transmitting any
> part or whole.  Looks like you can get SBC-5 from the ANSI webstore for $60:
>
> https://urldefense.com/v3/__https://webstore.ansi.org/standards/incits/incits5712025__;!!ACWV5N9M2RV99hQ!N4FtetrpMVBPf88WPTlz6EuwsK0kPhNqw04MXvtXGUwMzzAf0NPkCYhL5HYx32ZZVogW2MKS0Jr8P8M$
>
> The reason your patch caught my eye was because we'd previously fixed the
> same problem in the SCSI LIO target.

Thank you Ben, I'll get the spec from the ANSI webstore.

-Dai

>
> Ben
>

