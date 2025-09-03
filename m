Return-Path: <linux-nfs+bounces-14011-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A03B42650
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 18:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1DC1BA2CBA
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 16:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA8428151C;
	Wed,  3 Sep 2025 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sAZzlJq2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ejlcpX9l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3F12BE646
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915949; cv=fail; b=Pl3WT7oM3AZ5fmjg0eg0rlIKsqyhZFc6fhmGHSwNrc6lP1xGzenIm8AIoufcuBlx0pD+ed2yvViGKyddxpCzMeRPqahy1VqPc/GKSQWk0HNJSALSnt2Eid8idpEyrrzz9dQhVb1669ahRIkyrZf1EBOG70TFxKkB6+7b/d69eq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915949; c=relaxed/simple;
	bh=k7XrApI9/SJQ5cXXwKPVlHZCZlVwtyTjwVIkw1NUw80=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t/07PEYutQsgQ9Djg6xrvlkFk5YRECU4CajHySNJWPRRUF2qYbLyVELQaezsoTER6dxUI6tJCa6PyTeNPYfNsLqn0J7mt2fEcPH6qLFn0//4Nb69rYyyXI+UAKlIHHM0rFuitVGGnFSlIuE3ldAT5ecb+nHyCqnWqhH7aMML7lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sAZzlJq2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ejlcpX9l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839NF3Y017533;
	Wed, 3 Sep 2025 16:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=p7Ep0xci18/5jrCL3w92tB1FYtvqFK6DXjA5R0oz7wk=; b=
	sAZzlJq2IUhbko7U5+8gUs0AUKTRUw1uSHzz7GWQe0L6Q5vzDfZM7iIRk8EufGhn
	Uqnkf4cqfcqr+8DXlejysOcLwS1R9ZNPtDH3NP2KTX1+GBFFbO434Gjs6qpo2SNF
	sfo25uk9qBMEvSpL8ENi89VJN/aCUBKaVVWxt9r7O+11mKEafzwX50lYCY2yqnkv
	5pfl7ld34NhSQRr1L8zUV/B5UxvC29WHZdkWomaeEZ+qKe3yTtyX8ZydkhwDb02G
	CrTl+MYGRAaLRMuQoIr/BB3iSwq0ln7/qDY1NirPnnERbhb+DMC8Lwgw4kSAi+ve
	qsCoVy0/I/+yY6HWNY7sxQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmbepxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 16:12:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583EjwMb031052;
	Wed, 3 Sep 2025 16:12:23 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqram0fp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 16:12:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBA0t0DyXIeTRScAJEWfAEf7KsbtfaWh/huYmLJgpZW1BdjHe2k3v7K2UjUhXJWAQqV286PP+60gCaZ3oipiUBeFZV16LuXSoh9WmVWsuSDMvHLEaKJAwr7R1rg19FODt+jamF6PC6ijX/Yelfuw/gTkF59x4r7IwNnvybL/lR7XLCZ7kVHnxiXC8Jymgxppi2Vz8YSd/qCSCUR5VgfqepDcb7lLjVetjLDGAtvIKwzQIkThk0ImPalg72IM0F2K9d/CABojecQpODlH7rVZCfJ7y/k6hZ6Dl1NqjtAJIPU5Jh6/4N1vQDx40dRxOSr8HboYJmvk60GWIN0CX5Jp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7Ep0xci18/5jrCL3w92tB1FYtvqFK6DXjA5R0oz7wk=;
 b=Ng/ipyO5Os8JshLsPKeiE3uTjVOo1JeqqmXOBJmcZNqocwbY/MlWgWQn1Gp4ny4Uol74Bh+nK+eR8ifkKd5WwMMau94QrFFChg9/0hUVc2TY32NjndwY3SzWPqDewrvQL64XIxusc41XwKB2yx6ocr6vZc/9AJzawBnf7aAw5g0gOm1Hgblx3+YUuexNJNd6IFI1nFwMb2MP8MXK5XNMVQAgM1ONSehjCG7VsujJd5cNydEq7LLXQnPr/Kd1toNhRoVuKxRD46GZtRMYyiT4jag4Vlbd9MrqiHfTFxc4Eh2MQJEXwmORiLZmwfiZqjqWrxZgaI2HvVK2dORzTvIcFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7Ep0xci18/5jrCL3w92tB1FYtvqFK6DXjA5R0oz7wk=;
 b=ejlcpX9lq/TXLw44EZgBMYMkwKbyx0P9KmNKO5RJ7sIrGHhQbCnNkh3ENz8i/vZUSWeo5x6uI/Kj3stNSwfE6HiZCaUVmgvNBF43IOhH+rguzWbj5qmv85ZO/1LEOMNx3Gi+6bY0YqV/5WcHJH0NY/nsXnXyxZZemskmu12iPOE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6331.namprd10.prod.outlook.com (2603:10b6:806:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 16:12:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 16:12:12 +0000
Message-ID: <b514a3b1-ae0e-4803-81e3-ef2d1de18a6d@oracle.com>
Date: Wed, 3 Sep 2025 12:12:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] NFSD: add io_cache_read controls to debugfs
 interface
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
 <20250826185718.5593-4-snitzer@kernel.org>
 <1c69b5dd-ec65-438f-9b9c-af8013619afa@oracle.com>
 <aLhZsfJMwsGu1eu3@kernel.org> <aLhmnwNasNnZIew1@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aLhmnwNasNnZIew1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 56347ea0-050f-4619-ec42-08ddeb04a439
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?enE4UU56cVNXRVdnQzVKZE9KcmlCbkJvRXpEYWI4VkVzb3k3VDgwRG1FMVh0?=
 =?utf-8?B?cjdJTDE2eDcxNEJVNjJONUZ1RWdCNjlNRUVWeEVMSjRYVWo0T1ErWFJ4K2d6?=
 =?utf-8?B?dTBWUktINnRhOHBGYzdmdlJ1S2tEclZQRkxZblFvQmNEK0NoTDROdlVjSzlM?=
 =?utf-8?B?dmhRVWEvRmRyWUI5emsyNG9rVVg0Y3dtUnk4UVFtQU5QeUlmSVRxSkRadzNR?=
 =?utf-8?B?V1VEclBnSFhmOEh2NXZRZDg1QVB3T2x0aWtNMU55bldENnBFdEdQVDU5NXVH?=
 =?utf-8?B?elFxemFGdFNSR0xjbEYySXYxKzF6LzBsRHdGWEMwNUcwc0MwYzhSZ1o1YTNI?=
 =?utf-8?B?T3J2Wmp1R1JmV2xncUo4TyttRWxTSHdIaVZManBXbVVHSHl5UEZZaGc5VlRh?=
 =?utf-8?B?Z0M3QXY2MWNieEQ2YTdaYVpxN2hLT1JWM1p1dTdmNUhWNmxSbytFeU14NDRO?=
 =?utf-8?B?Q3l5QmdyN0krR0Z6SEJ6TGtDM09yYVlacGk0enBGcG1kcDMzZUc1ckk3bm9M?=
 =?utf-8?B?YUdhRDZyVXRUaU13Zm1uNUpoTmhuTjA5MGEzeFJPVzlmbERuaTkzemR6WlQ0?=
 =?utf-8?B?ekdyU2MvalJJVEQ4bUMyVkpMaXhsbDA2Mk9lNlllbGRCOVczMDFXWlVxaWph?=
 =?utf-8?B?UjhjdUwwVG52clM5RHIyWmlkUmJaSjRvNWJQaG9qTHpUNm1VckpJRm1UVEor?=
 =?utf-8?B?RERIUTRXRDBQNjZFeCtIOFl6Yi9kMnJIc3ZaT0NGcGx2Uy9USFlzZnJpWmZE?=
 =?utf-8?B?YjAvRXRpTEZRalBWWHhQR0ozdXpXRmkxSE8rTWxlSDJsdXlaQlFnbHhKWkt4?=
 =?utf-8?B?bkVOdVdieEtPRWJLY0kwK1Y1c1gwQ3lmbFN0d1B2bTRjRktvVDdZT3hLWU9x?=
 =?utf-8?B?ODUrZ1ZUTnB1NW8xQldhNEVNVktnZ29jRXVsK2ZWUWpNQTFBNUZEdlVXelZr?=
 =?utf-8?B?eS9jb1RWcjNySGJ5aS9hQWNiUkI0SjhmSEdOUmF6Tm41b3RlcE9FSnZmNTlF?=
 =?utf-8?B?SU5LWEQ4NVVZMTYySU5jWXFac0ZJVVIvQlNta1AvMEF1SEtBVWg1czNJYjVm?=
 =?utf-8?B?ODgwOHRkTDNpSUlocW02SUh6VDFOWUdhZEprSVZhbWVWbEc0OG9EM0UzK2du?=
 =?utf-8?B?TmsvcnBBb2pJZlEyOGlnV0t4MVdQSGR4Z00rK1lSS1h3RE1QZVdSZEsraXps?=
 =?utf-8?B?THo3bkZnN09pcTBGeEk1aTIrcVZIc0ExcDM3bVBWalY0NTRoTWpFbUxiUWRH?=
 =?utf-8?B?SVYzM1dGTU16RWZhb21OZlJTYkU3bTArTllDS0ZPNTdoZUZ5dGZWWGNXNjN3?=
 =?utf-8?B?SW9yc09UMEZOVzBPM1Z6Y1AwTW1kdnViQ3pXY25Ebm9wUytoVU9GOXdoU0xs?=
 =?utf-8?B?eXE4TDNFQTVXakMxTGtCaThyanl5U3lkdFJQSU5pR3UrOUdlQ2M2M0gxTG9M?=
 =?utf-8?B?T21PS01pcExoOUs3emlEZjQrUzRqUjN1TmtmMHNtV2ZOM0pGdlRBRHdGa1Aw?=
 =?utf-8?B?N0ZmRU9NRnR1bTIzam5ZeWZ6U1cwRWVXT05HRGZEdVlwcjIvYXBJMjU0dSth?=
 =?utf-8?B?RlhFNG0vM0lDckhBOG5jTUlaRnI2eFl0TDEwbXVkWWM0Nlllclcrc1lNdjkz?=
 =?utf-8?B?aVFUYUVJQVZVVVhnT2FNbEVxV216UHNwRGY3ZHZjVG9SWWNVbmdzS3hrb2gx?=
 =?utf-8?B?ZlZEQkdmMEhPK2YxRlkyUFBGTkFyOXBkc2N5dm1YZzV2bXBkRWZ6VnJFa0xz?=
 =?utf-8?B?ZU5RejkvOWZoS0J5bmtjaERqQjRwZHBsTmZseUhRUnVzTmFiME96YUJlckwz?=
 =?utf-8?B?MmpiRHA3SWV1YnUrY01JZVk3NHdoQ1BTbnlHSC9aVGFWeXFrelNwMWYvcHJQ?=
 =?utf-8?B?VkJMMEJCYnd0bXk2dGVLRjA4bnJZRGV4VE01SVpoVW9BRGNFQVR4WXNJbzh5?=
 =?utf-8?Q?xod55i2JXDE=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OHZBUDdYUXJkbTMva0g3cGdvc0ZidkhWU1BRTmhnK0tDN3AvRUVhWWNKMDlB?=
 =?utf-8?B?VC9OWDhVVWc2ZnFlREJUZTVoemFJWjloT0E5d1RmMGQ2T2IweUZLdHhWYW5Q?=
 =?utf-8?B?NW1WcnB5TTVXYk9TOEZDN0RUZkxLMU4wMHZnWkFKbmdUSTdEMnJNUzJGcWdW?=
 =?utf-8?B?NVJXeW5hSGVibWhHWW5ITzZzSW9MZmhXd1NLSENBNlZWUHc1MG9NVkNiSVdy?=
 =?utf-8?B?MEpoa0s4VzFuRjU3WDR2OXV5YW40MXZYRVFaOEdsbDF1SXJEZEsydDBleURp?=
 =?utf-8?B?bFlOaTVHa1lmZDcyUTRhRmpEZzA5VmVkdnV5L0srM2tiTldHekNGcVZKeGsw?=
 =?utf-8?B?WkhtcTg2QWFGUTA0b0NrNm1kOGE0YmxvOThaUGdwWUdmSkFoOUl1Wm1WUGFM?=
 =?utf-8?B?OWJaeEtBbkl4RjF1Mmw0QjVQTStMci85TjFwL2ptclNFUk5pMnVleW92L2J0?=
 =?utf-8?B?MHZObDg4eVY3eEIvVDZGbEIydG1wQjUzMnNyMUJuRGF0SmU0cFNObWlQS1BB?=
 =?utf-8?B?VUV0ZERvQjJLLzdHVHIvaXZEalZILzlWL0E1Yi9tWWYvalFyVTlNeHpUZzY3?=
 =?utf-8?B?L3lCWG9pWE5sdE92VExXeWErTk5id3VlV0tLdUJIZTlRdVJ2UmJUQlFGVDNt?=
 =?utf-8?B?K1M3emdLdCs1aFBxdllwcjVQd2tFT2tTeDBabE5pMFo4YWdKa0E0ZzYzQ0JV?=
 =?utf-8?B?ajdPalhna0JWMlA4cE5GWEtWM1BndFRodVh0eHBOeHRJQThvVXBROVNxOWpk?=
 =?utf-8?B?VUthbHlndURrRjlHT0RyWGZQWHNBYXlwM25uckRnMTZuRTRzSkZUUDh3Nmhy?=
 =?utf-8?B?a3h3cWZROU0xNjVhdTRWRDVPbVR5SWVtM2o5b3RvMzJsb2orRmNvR0ZkMFRH?=
 =?utf-8?B?NDhtMzRSa1RZRFZOMStYdmE4ZU5YZDZNUXJqYy93RlFST0RQWkZGM0F5THFx?=
 =?utf-8?B?RlZOYVJ4bUhSRTJ0dkF4M2E0T0R0aDgxVkxlRnRZTUg0U3RGaTZBL1RWT0hO?=
 =?utf-8?B?bi9pcGFHNjhpY3F1Tkx4THFSQmpGOHVVMjIyb0xIMDF0ZURybnZTUnVER3BV?=
 =?utf-8?B?TnJibnZ5ZDE0ZFVHQlhBWktuSEc4eE14VENtT2UrcUJFaFQ1ZkhZUGNsN3FZ?=
 =?utf-8?B?cVd1c002Z2cyOGY1MDJHU1RBR2VlSGpyKzNuc3o3N3dmSFEvT1F1VytoRjZ2?=
 =?utf-8?B?dWVvWThxWXh4S2ZmWmh1NXN1Z3pMOU9GUnBwQTlGSFlkK0RwV21STmpHZm1C?=
 =?utf-8?B?RkxKYW4zdWlENVE3dHFKaWhWV25VYThsS3U0Tks4QkIrdERsYW9hWmljQXhF?=
 =?utf-8?B?am10U3ZDWm1JSWk0Vkc3WHpHcXJFRGx1Z3A0R2NNcUJBa2M0djhJZStmdDRG?=
 =?utf-8?B?K0tPWmR3eDR6Z2dTOU50VDBXanlIbnFkSnJrcjUrNmdnNDVrenJya3pKcC81?=
 =?utf-8?B?NmRmNHdRSm5BWktkRXpnWHhibmd4Q1E2WWhvRDBrTFI4ajZGLzFKMmFSckJ6?=
 =?utf-8?B?MUl5WkJLTnVtblF5K0pmYzJjMG5xc0JGb3EzZEZXbWd1S3IvZUxqbzJHbW9o?=
 =?utf-8?B?am9QbDZXNGhRRllBaU1zMHd6U2RvbVkwL3V3ZW5Sd0cyK1NZWDdXMTlNdEgw?=
 =?utf-8?B?djB6MitSNFdEdFAwNW9raGwxR2M5TmZSZHAzakJ6SUlvNHNJSytvb1k4YndD?=
 =?utf-8?B?YUYreGlsbGtVcXdzdVF0NHVQQXJUOVF3cTNSc3h1bzlLRUlnaU1VRy8rb0Vz?=
 =?utf-8?B?SWF4NmpPT0Vpdk1YeGlGZmgvWnV1V0sxWFlhWVpPelFCV2RnN0FkQTU5RUNB?=
 =?utf-8?B?eHlkbWp6aDBhUjFpcE41M1pqUjhBajJYREdMOGVOM003ektCWmRqMDRibFJi?=
 =?utf-8?B?R3JEaGh5RXpKSDVTeDVSU1RsdXdGNzltZjRabm1NbWtmNHR4Ry9Icy90Rm85?=
 =?utf-8?B?QUJhczdkbDZzOVVxTlFJbk5IdmZObG5mRW9VTHdicVI4Wm5uWWQyOVY2R0k4?=
 =?utf-8?B?d3d6SzV3d29CZmFjeFRkTnRPUm1OeFRjZC9vMVRISTdPVFNhQXhMWjVxV3NH?=
 =?utf-8?B?OU4wRjQ4WlRDdzZVdTZnTWVzWFkyV3NPcmFXRFNUVEJUcU1ZemgyOGNRdys3?=
 =?utf-8?Q?Mmd8RTy1A4R1s6LfgmndM9xXk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4iz3eks7LWlKGvwqA/7Oz4XmAjiMHhYD/PiPJUwSWNQ270CNU6QObSukTtEW9sbmHpmLjMpgcT2jiTCDi8/3LGaFvu2wb+Q1h/jniebVT5SylUMtMBkNdRTdSRQnZ4UWkHGRVv0RNmfsEH5m3Ew2qDbO65f8rTr/n6Wvu2sSBgUB2uYakw4iFKOIHmZWcy5kpc6gJLUNma4cE/NyQIqj2aTIcDqOM4C4rOqaD9fEIHLZzVCi87AKZN65TCrAOuCxL14vCBnR6oEFYNgCWe4JZ7iiJzl3E1qXqMYrabfnrzemnNo5aSZCG3mqkOkN4YB3nzGX3xeWNofqSCo2sYpjzloogzKRmB0mmDSbMoaxGcvOH2B3mq4rYj9VVsDhsoB5bNFEWUxuEAmT/g/s4wOub/UrsEJ/wlRLKMmJXo251gyu4451VeS6Rm0Ey/FNxOEzHFL3/77A/BmnezRzxnKFZOspNZC5NvCaBbDXV69lWHrLAMDMAKB3DmkMROkcOhSzJ+VnYroH9phm+SDjQSLmAZOliYkpieJz41WxE+dAAT7OLmblpqrAubrbFh3IcTfRyLzx6L24R1akyjWWCbAUwWASFEG2QRZ0v6DVxoSHpUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56347ea0-050f-4619-ec42-08ddeb04a439
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 16:12:12.6690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHjkkHR2ynefvYlZEjyci0ObZaPQaKjYgoyEOJv98j9E1YR1CXHzVlXUaZLKPWSBpSnbB4rLnDaLulTHMa1t1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030162
X-Proofpoint-ORIG-GUID: 1jzJlEKa2gXj4F1ZvTujSdzJ0t-YIRDf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX9aMAryCinGZV
 Yr9FBvTru3hfMIP7uGEbpJPkZNGggLW/WRfRd05PuAtoo/BGNZmgu+eB8A8GHLocnjoddj+jTy5
 7zfdBjuGK0bgduOaP6O0MpQewVGX9Qmz+qq7q/jPyInvGej3wWaMDLrKCKH4LgDNUjNPD8BHrmQ
 aP0Gsl9tLnp/KJepW5CT812yUQHkRXyL82q+sgQ9lf02ocTR9k0dOX6h9EuzaV9Sxwpm4E6QLtX
 OE/C2woPwvw0P0lPOMT19K/PRZhs72MMS37VFMuNFhs9OtnRlYsR3zFAxN4uFPpoBVG+fRDUg0j
 4IqVoc3E2enm0BtG6WEUQd2O9gzvSbkm75mPAV4gqsuYrSLMytFAElyybcwIZhDa068KIG6yR4f
 hqo8TpFe0nueY9pv+2pXKKkAijNvLw==
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b868e8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=TBxQpckpaE9_97u3WisA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13602
X-Proofpoint-GUID: 1jzJlEKa2gXj4F1ZvTujSdzJ0t-YIRDf

On 9/3/25 12:02 PM, Mike Snitzer wrote:
> On Wed, Sep 03, 2025 at 11:07:29AM -0400, Mike Snitzer wrote:
>> On Wed, Sep 03, 2025 at 10:38:45AM -0400, Chuck Lever wrote:
> 
>>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>>> index 1cd0bed57bc2f..6ef799405145f 100644
>>>> --- a/fs/nfsd/nfsd.h
>>>> +++ b/fs/nfsd/nfsd.h
>>>> @@ -153,6 +153,15 @@ static inline void nfsd_debugfs_exit(void) {}
>>>>  
>>>>  extern bool nfsd_disable_splice_read __read_mostly;
>>>>  
>>>> +enum {
>>>> +	NFSD_IO_UNSPECIFIED = 0,
>>>> +	NFSD_IO_BUFFERED,
>>>> +	NFSD_IO_DONTCACHE,
>>>> +	NFSD_IO_DIRECT,
>>>> +};
>>>> +
>>>> +extern u64 nfsd_io_cache_read __read_mostly;
>>>
>>> And then here, initialize nfsd_io_cache_read to reflect the default
>>> behavior. That would be NFSD_IO_BUFFERED for now... then later we might
>>> want to change it to NFSD_IO_DIRECT, for instance.
>>>
>>> Same suggestion for 4/7.
>>
>> Ah ok, I can see the way forward to default to NFSD_IO_BUFFERED but
>> _not_ default to it when erroring (if the user specified some unknown
>> value).
>>
>> I'll run with that (despite just asking Jeff's opinion above, I'm the
>> one who came up with the awkward UNSPECIFIED state when honoring
>> Jeff's early feedback).
> 
> Here is the incremental diff (these changes will be folded into
> appropriate patches in v9):
> 
> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
> index 8878c3519b30c..173032a04cdec 100644
> --- a/fs/nfsd/debugfs.c
> +++ b/fs/nfsd/debugfs.c
> @@ -43,11 +43,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
>   * /sys/kernel/debug/nfsd/io_cache_read
>   *
>   * Contents:
> - *   %1: NFS READ will use buffered IO
> - *   %2: NFS READ will use dontcache (buffered IO w/ dropbehind)
> - *   %3: NFS READ will use direct IO
> + *   %0: NFS READ will use buffered IO
> + *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
> + *   %2: NFS READ will use direct IO
>   *
> - * The default value of this setting is zero (UNSPECIFIED).
>   * This setting takes immediate effect for all NFS versions,
>   * all exports, and in all NFSD net namespaces.
>   */
> @@ -90,11 +89,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
>   * /sys/kernel/debug/nfsd/io_cache_write
>   *
>   * Contents:
> - *   %1: NFS WRITE will use buffered IO
> - *   %2: NFS WRITE will use dontcache (buffered IO w/ dropbehind)
> - *   %3: NFS WRITE will use direct IO
> + *   %0: NFS WRITE will use buffered IO
> + *   %1: NFS WRITE will use dontcache (buffered IO w/ dropbehind)
> + *   %2: NFS WRITE will use direct IO
>   *
> - * The default value of this setting is zero (UNSPECIFIED).
>   * This setting takes immediate effect for all NFS versions,
>   * all exports, and in all NFSD net namespaces.
>   */
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index fe935b4cda538..412a1e9a2a876 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -154,8 +154,7 @@ static inline void nfsd_debugfs_exit(void) {}
>  extern bool nfsd_disable_splice_read __read_mostly;
>  
>  enum {
> -	NFSD_IO_UNSPECIFIED = 0,
> -	NFSD_IO_BUFFERED,
> +	NFSD_IO_BUFFERED = 0,

Thanks, this LGTM. Two additional remarks:

1. I think that the "= 0" is unneeded here because C enumerators always
start at 0.

2. I'm wondering if this enum definition should be moved to a uapi
header. Thoughts? This is experimental, and not a fixed API. So maybe
it needs to stay in fs/nfsd/nfsd.h.

(I'm probably going over ground that has already been covered.)


>  	NFSD_IO_DONTCACHE,
>  	NFSD_IO_DIRECT,
>  };
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 5e700a0d6b12e..403076443573f 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -50,8 +50,8 @@
>  #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
>  
>  bool nfsd_disable_splice_read __read_mostly;
> -u64 nfsd_io_cache_read __read_mostly;
> -u64 nfsd_io_cache_write __read_mostly;
> +u64 nfsd_io_cache_read __read_mostly = NFSD_IO_BUFFERED;
> +u64 nfsd_io_cache_write __read_mostly = NFSD_IO_BUFFERED;
>  
>  /**
>   * nfserrno - Map Linux errnos to NFS errnos
> @@ -1272,8 +1272,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		break;
>  	case NFSD_IO_DONTCACHE:
>  		kiocb.ki_flags = IOCB_DONTCACHE;
> -		fallthrough;
> -	case NFSD_IO_UNSPECIFIED:
> +		break;
>  	case NFSD_IO_BUFFERED:
>  		break;
>  	}
> @@ -1605,8 +1604,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		break;
>  	case NFSD_IO_DONTCACHE:
>  		kiocb.ki_flags |= IOCB_DONTCACHE;
> -		fallthrough;
> -	case NFSD_IO_UNSPECIFIED:
> +		fallthrough; /* must call nfsd_issue_write_buffered */

Right. In this case, the NFSD_IO_BUFFERED arm is more than just a
"break;" so, not as brittle as the nfsd_iter_read() switch statement.
The comment is helpful, though; I'm not suggesting a change, just
observing.


>  	case NFSD_IO_BUFFERED:
>  		host_err = nfsd_issue_write_buffered(rqstp, file,
>  						nvecs, cnt, &kiocb);


-- 
Chuck Lever

