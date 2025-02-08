Return-Path: <linux-nfs+bounces-9961-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15375A2D7A1
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 17:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113CC3A7FD5
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Feb 2025 16:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86F91F30BC;
	Sat,  8 Feb 2025 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mFAQtEcx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GkcvXoMe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD64241CA7;
	Sat,  8 Feb 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739033986; cv=fail; b=rFbcjr5lfI6QF04Q/Sd4zxii+ztpVkWIXB+LkcyJdy66jL2bCEASvDNjcz8Zh2Iz1CIwQHLJqGEH7cbWzdJTvQw5wfjU/H6Uiuq4S2aIJU+pEa+g2OkctghJkNpUYEqYQ7Hi7l/wos/ImLvOi9AD0aLph3qPbW9KDZlNCOsESxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739033986; c=relaxed/simple;
	bh=IccsdsWhW4X8sx65ZXBggvbqD+mcsH70F2/mQdw/32Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oo6JUAnVo1D0TJ7y/aUzByPLGOR/3vykCQtBi9KfsWk89cHMF/cbuPP4W4oboKOho4ofBj8adV7chWSNg/HzPVIL07AfNsGNs7uv9RovitdVzsa0FbWBScmY9dd+hd/jOfpGC5qfLi+LSyEK4w8yl4jK2qZOtwj5BsDhYoSS4Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mFAQtEcx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GkcvXoMe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5187UCtT021684;
	Sat, 8 Feb 2025 16:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=U2mPKQt/xtPnalLHgyKYkeALTe9FRlW5vSP3ZEkTH4E=; b=
	mFAQtEcx6IUG6rRG9GOONhIuvvk1XUQt0VLC2zsplSuNhWKrQJYQ6IykbUsMllqf
	JAPbvp1ZNyEWlZGjiUhqdQaV0/qllzCKM/KUzz8nlTH1A2SzRNNfLc39hTbBK/Jt
	tUR+ejo6HDXrmz5qR2cC70MCoiPTYNVmRvsIqcMGoWAWGXXiG82vypHeGw0yD9qy
	NwSARak0MrYyagbkUsnr2sjqz3NAk3/e92uvuSVqfn152NiEBNgMEe31e+1THM0V
	W0fIQHsMsmbkj/s+iNsYoNV90b9hTw5v4jTc3OtyHjaFkoPwC1BNBEvFMqhM9Eai
	SQtCravtn08JifzNd56fSA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q28cvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 16:59:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 518GD6ha037702;
	Sat, 8 Feb 2025 16:59:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p62vcxyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 16:59:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfRHopYRi7/JPUVSE9mR8szAJK/v7QRDqwgV2Yq04b4W07TSJHnrUbwP8ZfiymJkrkGaZlISq6e8yfupm8GgrOGg/ofrsbdrtEGwNVOMbN/3GIK1ttaH0Lhx9tP6nzxyDRYqMDx0P4FXaAnwvWEEmrSz/hmdGSLkp8qd/K1ze2NgblHonyCpd9ik5y7HSLCTr+T2mW/JiSxlyIoeZB/wX5zTnawvdG0MhdAgslHdXZutXgOcf24a13l5eEfqCJ0HwqAWLIrwRTfNZTX/xaOG3fvwTX99iaDCkgPBPegy7vBxrech/vE5FgVTdrvrOqrXaEpkVzKfoXR47Lh83PDUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2mPKQt/xtPnalLHgyKYkeALTe9FRlW5vSP3ZEkTH4E=;
 b=M/tkKKPzL6Yc+Og8u5nPxis4RUlaxucbDTBcRBsQEecEjscBro4z9ZHKaN9UBMc9D22iXd5hUlCbxvRl/qmb7XEhidT8FRZmtWB8OvWJDE04RLW5Bt9DSwmDriJT9a08mBPtdO0dkojJfCCpfY6nPxhNHmEJP5PUvUT4NBJNUhVHmi3Pb5pF64mZvwCFSRF6WvKpblyfl8iBqnIHuy/pkUWnOjzfJSaoZoIOWraovUCxdREeKBX17aHyboQ+O6lbk2SWN7gq0oI53Eab8yamqPnBsOI0mfWNDwavsMxWZ4oKTZHCa6q5RVkdystTt9dgXxI3S5Q8r9CRPhKhNFxEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2mPKQt/xtPnalLHgyKYkeALTe9FRlW5vSP3ZEkTH4E=;
 b=GkcvXoMeUJybxMif0DK9DtRoqSYS2oyLevHwHomO3Lh33WudjgxLb1Or5sNaRiueX5mUe4ZFhqhWWakCGOYI0DRc1EN6xIC291E90GrW/O8YhFZNCsFh3Pzc4Z8GWLgtwl03YQJJYERDxGNR4X1IFW//QuX3oVI+e5Pvntt9L+Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6452.namprd10.prod.outlook.com (2603:10b6:806:2a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Sat, 8 Feb
 2025 16:59:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.012; Sat, 8 Feb 2025
 16:59:30 +0000
Message-ID: <610bc63d-1ce3-40d1-aa42-bfb22dc26ac4@oracle.com>
Date: Sat, 8 Feb 2025 11:59:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] nfsd: only check RPC_SIGNALLED() when restarting
 rpc_task
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
 <20250207-nfsd-6-14-v5-3-f3b54fb60dc0@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250207-nfsd-6-14-v5-3-f3b54fb60dc0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:610::24)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: a995dd70-49ea-43a6-92f0-08dd4861f443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXVJc044ZWtMbGZCK2wyQ2lpL3dHdW1sTmR5Y0MwNFNYNXkxQ2I5YlNXVlk5?=
 =?utf-8?B?V1k2aFBySno2MHFNTjBtaTg0Nm1XMmdXMk9ZYXRWc1lmOE4yYjVyd01VVGpI?=
 =?utf-8?B?WTczNERML3MzdXY4ZllnNzR3WG1lQ0s3N1RtTXF2QXY4d3N2TVEyT2d0Nlhk?=
 =?utf-8?B?OWJyOVEzdzFvL0FPZUQ1YjF6ZE9pYVllc1RUWDVWeHNwZmRjUjZGNkxXS1Fu?=
 =?utf-8?B?c2Q2M1doUlhtbTdBQlRQWnVWa0FJNDZLRTBqRTNUc1pkOEw2NFBxVHBMZG5w?=
 =?utf-8?B?S1duVS9mM2txVVVkWnp3dTZheUlVOW4vSlpDcFdQTHU5Mjdzb29haW5JcW5l?=
 =?utf-8?B?WFJxREVlczlZenZGaUlLOGhiQlRmNmJpOTVmWHBBQmZobHQ0S1FiRkkyajFF?=
 =?utf-8?B?ZC90dk1lZnIvai9qMTZhMWN4ZGF4d1VxYnB0U0IxZW5MUlorR3pRMVdFZ0Q3?=
 =?utf-8?B?bzFSNStXRENGdWNsbTBReGZGTkZSQno5OFpGSlNqdnVUek91bGpmUkRuS1Z3?=
 =?utf-8?B?dys5VzVocHh1ZzQxSkxkb2VhUGgzNHQzMTQ3V2tJeDNMWG5XVm0zT0U2dnFk?=
 =?utf-8?B?RmNYYmlReTRTZzB3dW1oUFBMRExlMjBQYVdZRjk5eHZwTmRFVmtOL1RBNk9W?=
 =?utf-8?B?WWdIbUZpMUI3NDlNeHdWM2hwNVVOVW1jUHUxRWREdmpCcDZyYVFGa2Y0SkZM?=
 =?utf-8?B?dDdyVVl3Ty9ZZTM5eTkwL3laOW1ESUU5eFA3Y1RIOHM4MDhDVklLRDlweksr?=
 =?utf-8?B?MVdFcTQ2cDJDZ2tYUmpweEsyamVaN2VORWJ4R2lFeWRvSC83dy9YWXpETks1?=
 =?utf-8?B?S3lmak11ZzhLREJkaTM3QUVCRzVDZlVYNG5lWkk4VHFYanY3VnhiNDdTU1I5?=
 =?utf-8?B?azlnT0ozMGhwMkhRSHY3bmZBeDZidXRIYmVRS1RJNjUxbGFvcmZTTFI0UlpV?=
 =?utf-8?B?eWdiMC9hNE1sL3hjNVJUK3o0dkhaYUpsZ2pCWktVc1F3S2ZoQkZlZW5jTW51?=
 =?utf-8?B?SngyNjI4aVdRSVJmTHBNQUFxRFZ4TitucWdXNXV3RWlsV0hwaXE3dzZnTmRB?=
 =?utf-8?B?UHZYZFU5eFBEZEI1TERhL3RPMWxaYVJPNWhKRlNCNld3eE4xbG00U2N2aDhk?=
 =?utf-8?B?Yk91TE1YUjhoK2l2bkVjaXNuWWUwbCtDNWJic3JncWlveHRtcHNPNmxrZm53?=
 =?utf-8?B?M0I4YXlnSkVjSWlVNW12bFVvS0xPNnUrMzdYaXFpd1pPbnc4cWpSSnBiS3J5?=
 =?utf-8?B?aHJ1NEs5ZFlKdVZRaFpDSzRoaTVFUHBsL1AxdGVZc0xMZWxEUkJaTnhrTFdl?=
 =?utf-8?B?KzdjRklkK3RweDBkRVIvRmxObDcxUldoNWw4Qzc2MThvL2VxZXQ2L3R0NW9B?=
 =?utf-8?B?dDZaU1hIc2c4dmp6VkZHeGhlY1JaV3I4SzR5R25qUTFsZ2Q3ZmMrdnFZaEYz?=
 =?utf-8?B?Y256eUYvUGEyOGE5M0lTU0E5clI3UDBRb0pTUk9JMU1jZE0xbDFEdUg0UUFw?=
 =?utf-8?B?MU94SWZCTVc3MmhZMjJIR1g2ZmhKVThpVjd3WUc2SFVFYTJDdFJkbmZLcTBk?=
 =?utf-8?B?VFJmRlFnTW5tRkszZDh3a25mZW9qY3hsNE5VMi9xaHNkWWJCR2QyVEN3bk5E?=
 =?utf-8?B?NVdPbW16dTNBMC9Xd1A0KzFrWmQ5MmIxV0NyZGVHaVdLbTBLMFdXRHRGRmFv?=
 =?utf-8?B?Z0QxRkVhT0IwUW9NTmxxaHcrQUxicUx5Y0R4ZVcwVjB0ZklDeTh1KzZZQ2Vv?=
 =?utf-8?B?Tms4eWQrVmxRZFZmMzcyQS9UVUZ3Z2xRSTM3cmIrdDdQUjVSTytYOExXOEFR?=
 =?utf-8?B?OHkvYms0VnB1dldGdEVrc0dYNXRQdXZsc1FYOWFRUGhlM3JhMG1ZTVd6UHVk?=
 =?utf-8?Q?Z+5sQ6J7MJa9L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2NxQ0RnQlQvS2Z6dEJtdGRNdlhQTE1hNEFHbUR6SlVhczg5QWdkdk02a0h5?=
 =?utf-8?B?dlJSWlJNQjd4eG5raXR2RjRrbDRnZmxQVWxPV0JSeDZHeXlTejhiRjB0R2lB?=
 =?utf-8?B?Y0wyRkE3UUwrNWFlb0F0cjhCZFVha0ZGWGVQVys3SHZDa1BzbGxDSmxaRDRB?=
 =?utf-8?B?RXJkaTFNMlI1MTlQbVVQRFlNT014VjBGWUIyZTlRaFQrdWxSbXMxZGFDMVdh?=
 =?utf-8?B?TW9rOWgveEFSdFpnQzEvZlNJR3ZFVDJDT1VoTUx5MjNQbDlJeFI3UytlTzZE?=
 =?utf-8?B?T1ZZY1ZuNUpaMnNqc2JsVHc1eE40cnBNTnF4SUhSc1BhUjhRNDlKN2ZHZmZO?=
 =?utf-8?B?K2thcmZWYnZPdGZYakJqdGlVZnBHKzVQd0xhNWVYMGVRSzR5aU45NC81d3N4?=
 =?utf-8?B?aERkaWtvMEtYSTRnY1JIcktJanU3ZGtiNjlnckV4ZG1SU20zMmJXUUFFRWNZ?=
 =?utf-8?B?TzhVa08vdDRiUStTcmlsd3BuSkZrdDEzbDFpL0VsSk0wMEFwaTg5QnorMFk5?=
 =?utf-8?B?TEt2ZS96TVVBNGs4RTFVek13bXREOWdxWitVUmtoaVhUd3o3WEdZdEtpNnVH?=
 =?utf-8?B?RXZHekFCTXlnSG81enA4dHVkSStSMlhGSXE3U0lrZlJ6Qk8zRFZCM3FDaTVh?=
 =?utf-8?B?TS95b2k2QkgvUCtxaTZJNjJYM1FFNkkyR1p0U3IrR3FOMmtqbjFPMDBLY2Va?=
 =?utf-8?B?SkIrOWRmejVZVU81N24wcXdnRzUya0wwNXYxRjJxRzhqWE5WWmxZQVp2NWJU?=
 =?utf-8?B?bXozYzhTcStRcGtEZ1lCWkNaQUVQV0xjdENDdzA3N0dUd1owVzJLWkZYOUJ6?=
 =?utf-8?B?aFZyclNlZmR2aUNSVGtVOVhKY1ZnQktqeFhZYXZON3N2TmVDTjB5QW03eFYv?=
 =?utf-8?B?bG04cnVLY0hCbXIyZVgrTkVVZnk5TDVtQzNpQytkbWZkNFh2UzhGRlNQcTJa?=
 =?utf-8?B?TkFRZGFrMGFUd1B4RjlhdnUzMFQ0K2Frd21ib2lvcjByaDRwMXZBeEV0VjRB?=
 =?utf-8?B?WVY1L0paNFJyTFJpTHIyV0xVU05XT2JFSktJSDNNUVJvSUgzRDVqMkZ4OGcz?=
 =?utf-8?B?dC9lZjBxVzFJdFdleU1KMFlkQkZ3dFNUM2R6RUlocEk0RU9NTDlaQ3krbWtT?=
 =?utf-8?B?elZ5anhiNFg1UHAyWnZZeVFlS2RBSlQwT1l3aE5KbmwwY1BYUUEzNjV5eFdo?=
 =?utf-8?B?Y1JNYUswQWRpRXNoWWVFTmczVzVQcjBydng2S0JGMlF3MFdIcjBodWpkalhF?=
 =?utf-8?B?ZGx2VXA3NjFKU0pMT1FqRnNoc2s4WnEyTnMyYWc2YzlzOWlmVFkyNW0xNmxT?=
 =?utf-8?B?YXRpUTg4VXJpeXFlYjZhNlJVUEVxOW9vRlUvcDU2aWRQN1R2b0JUU21kSTEx?=
 =?utf-8?B?Z3IzM2NKZlVzSmlBS2ZKSUE5b1ExQjhZc0dqS3NZTGgrcmllc25RbjdGSlpG?=
 =?utf-8?B?UXl1SWtod29jRnZ5VDJaQ2VNelJPN3hXRXdkbWpxWkNnVUt5Q0hWV24wM3dr?=
 =?utf-8?B?b055WW9EZmRXd2MwZGRqd09aZkM2WEcrdDhCVDdUSG5waHBETnhtbHg1cDl4?=
 =?utf-8?B?Vit6dEd2UlBlTVRZWmcyaVk1dEZyK2FOZmJCMlRqUUtwc0lRdnN1YUFud2Zk?=
 =?utf-8?B?bTIzek5Eb0ZiaHNYOTZTZkhzMFFwN1hlOVBOb2xIU3Q1ZlJHazl6M214NTNo?=
 =?utf-8?B?NlZXMG1xblh6OFJON0RaZGpuVVN2c3kzVnFWbUdQdEZvb1hUTzFxd1M5cXF4?=
 =?utf-8?B?Q3RZeDhmVlpkZU12K295MTZvbWtIOU1jUFFQTW1NakJ5OVVkNE5mQWtCbGxJ?=
 =?utf-8?B?TWRIbXp5Mk9CcEhPd1M1ejZYb1dJS294QTlqY3B6SEF5RU1OVnljaUJWLzgw?=
 =?utf-8?B?cXY2b25STTZVVkR4cEJIZHVDYWFrQ3p6Mm5KWndsbUdVQm5nbUQveUJCUC80?=
 =?utf-8?B?RzYzMFo1VDVCMDRINVpVbmQ0YWdJeGlrSTlabXpPYWR6UkRVcjNFRlF3eFBm?=
 =?utf-8?B?RFhYWGNweWlTZUNFYjZjTXpmZHQxSkllSFBvY055NXlXNHNHdGRXbmNqenl1?=
 =?utf-8?B?bmdkaXBFa3MxVG5VbHduNTY4dU1TeDlzd3ZTc2phWWJPZzJPTlpDZnZMVnFB?=
 =?utf-8?B?VTJSUlZ6aEg1cHExTlJmTmt4cFJZVW9XTFFnT002YVlxTlBDRzRHd3h5L3Ji?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	igpKJjkpJogn88S2ptZykCbr0a78FJlpW3QgoDAx1PnZ9omxbULA6HkNVtEk2gxu0ujot7Y2WNNx7cLe5uVhog/JXzv1j2BRFrp1AOt1E/i8eR+n8ecgqJQgUgId4+g9mKicCBH0XQ0xww3d+dOcWiy5ucY0mPozOb7OW5Ik0xwOJ2xMtTur74UW7YRPoNQiszqdGFUhS+V2kzGlwTNDY/Sm4OYezVmclTbOdSrAFp5yLE60vOy4XiaVkGR/gkY1SPAvqID1vfsqik5OKpCMvF3qs0TjhD+U9zmWv3wp+WblAfSCor4Pk+wQSNTnn01GVRvVWJxkeB4BEosGzXzGBlVjsLQUknO9n7+gwoI3Af5N5XUAC/Zeb1xVkr/JFqqOAs+kjZkprWpzMJP+aESH56Qyz12NtQEAANlzFd5almtXDG7S61Es++AWk0UCE6CbYeb3jbITHbHdPGtUJFfk+AGQLTKske5PUQDbb/t//4qMF4zHDb3nV3bNQkXglFRFRvuLIHsiQ8+BfCVvw/b77RiB4I3f5EAs7NfEAafvRjfCfzPtgnybm955b+395Jb6xdIcQG78mHYTvn/IpSGnqqdnDqEb8SnE8LcAkAMoEjQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a995dd70-49ea-43a6-92f0-08dd4861f443
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 16:59:30.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/wgGXSIvNB9A6uZSMsgXWjaL78DDPHAcQ/D5vcDeH6ar2Jqzs1t4zXyP4sEtCR3i6PC9YxqjQB2fgwcEdBoUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6452
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-08_06,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502080143
X-Proofpoint-GUID: GygiJMLmU-8YoOsG3lkUytUL261CN9XG
X-Proofpoint-ORIG-GUID: GygiJMLmU-8YoOsG3lkUytUL261CN9XG

On 2/7/25 4:53 PM, Jeff Layton wrote:
> nfsd4_cb_sequence_done() currently checks RPC_SIGNALLED() when
> processing the compound and releasing the slot. If RPC_SIGNALLED()
> returns true, then that means that the client is going to be torn down.
> 
> Don't check RPC_SIGNALLED() after processing a successful reply.
> Instead, only check that before restarting the rpc_task. If that returns
> true, then requeue the callback.

This might seem like a nit, but this paragraph didn't make sense to me
at all until I changed s/only check that before/check that only before/.


> Also, handle rpc_restart_call() and rpc_restart_call_prepare() failures
> correctly, by requeueing the callback.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4callback.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index bb5356e8713a8840bb714859618ff88130825efd..1e601075fac02bd5f01ff89d9252ab23d08c4fd9 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1385,8 +1385,8 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  		goto requeue;
>  	case -NFS4ERR_DELAY:
>  		cb->cb_seq_status = 1;
> -		if (!rpc_restart_call(task))
> -			goto out;
> +		if (RPC_SIGNALLED(task) || !rpc_restart_call(task))
> +			goto requeue;
>  		rpc_delay(task, 2 * HZ);
>  		return false;
>  	case -NFS4ERR_BADSLOT:
> @@ -1402,14 +1402,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  	}
>  	trace_nfsd_cb_free_slot(task, cb);
>  	nfsd41_cb_release_slot(cb);
> -
> -	if (RPC_SIGNALLED(task))
> -		goto requeue;
> -out:
>  	return ret;
>  retry_nowait:
> -	rpc_restart_call_prepare(task);
> -	goto out;
> +	/*
> +	 * RPC_SIGNALLED() means that the rpc_client is being torn down and
> +	 * (possibly) recreated. Requeue the call in that case.
> +	 */
> +	if (!RPC_SIGNALLED(task)) {
> +		if (rpc_restart_call_prepare(task))
> +			return false;
> +	}
>  requeue:
>  	nfsd41_cb_release_slot(cb);
>  	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
> 


-- 
Chuck Lever

