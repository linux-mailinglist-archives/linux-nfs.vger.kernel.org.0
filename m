Return-Path: <linux-nfs+bounces-11049-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FBDA82666
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 15:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A818F4C7BBE
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BA9228CA5;
	Wed,  9 Apr 2025 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LIcJqmT9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uPOhrsfd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914FEEC8;
	Wed,  9 Apr 2025 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744205968; cv=fail; b=UHoYu+tNnoFD4U2CmbWFsVkL9p038DGND24dCjLiQQ1HmzFXhjrPy5DxzFZLMbXcnq3Vgi3d3GaVZeVca8+reOL/d3AzYdh1osdmqzEeSSXxSj5Ih9pfgI+QNKDttYLtrAIm9Bi0bwTzrYWonrGUms7108A5R3h3IlxDEe/rTAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744205968; c=relaxed/simple;
	bh=b2Kas6Ds1yJ4utljpHJuYqw3/UGbenmNP/bJgo7reWA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lc1slktf3FCyf98LmvgK7NrO/P7hTQoN7PbNAjFyE7La1jiVwAUrhurhjpORxdyfJ9qt3TBuGYO2ICIuIi312AI+IAdqkwki8mSEqEA53jKLrL6MApIFUFuBjNV+WVdRXYfpZmffXHZSCNsPL4gRMZdg4zx9N8XUhx7W8W6bpf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LIcJqmT9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uPOhrsfd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5397tugW025286;
	Wed, 9 Apr 2025 13:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ntwBx73OmYh2SG5mql/USukL8hUc/8L2iwhCYhhoIWw=; b=
	LIcJqmT9ohSU6wkGPOK3/uAVG6i9r2BH23FjiHVNUXJgm+/dwwGe9A8lVqWa4u2j
	d387LRM/0gJjvdpLDJcnhirs++CXDBhKmabdmpL49uqQaiF2jdJt5SMvEABjX5z1
	HUmhpQhjvFPJiAdpJiNKDiAMhbsr6sUF9w6wo/GCFhLCp8ODwfCgiDs2huiPrZr5
	gjX5gqWJ6xHzVnSvLqisUpD1QUmbCsxeg+86vIX2ztj8pkqNpa1S21B/HfQS0iof
	+6TpngDIjf8WRJPHIsR+cD+gRUk9Z9UmO7myporXvvoT9iUAoTSrBrPpGaf+bHcD
	3xm9zFDVv4YpRk+/L4aE8g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tvjcy8qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 13:39:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 539DNFDU015897;
	Wed, 9 Apr 2025 13:39:17 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010004.outbound.protection.outlook.com [40.93.10.4])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyh4k54-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 13:39:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOkz6MwJ714OIHsTDGQi4rNQiwXiX7rkzjaJAPRRgfa2Aj+gcGd6qcHNWIx0YYZgobhvpVV7l+2mYiTtVM2sRXC5EQcGhFsZUfPv07gYFSRhhXhniBCzu1UeE1W4F3a0JkS7NfpoPd6/pBOWatYsNg1W+YafsxvOHAGhTqVVTBM0n0pfZIiUUORk0zhBYeutxLQFy3B3FbIDDjAO+255yU4XIhYYYzds0lK+QIOg87pp0ZXq7VHuKkPmzdfMKuCehq1x2o7a/4MEvMKU64nCZ7bwkFXmVqqEwKX1bANn2pH93RDOudt1aGXCAajwhMNd62FVsO0I7Ulv3sxjUsDFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntwBx73OmYh2SG5mql/USukL8hUc/8L2iwhCYhhoIWw=;
 b=db+OIANna1tMPEsFmnlQDeuH4RZd5ISx9rVzIk7EnymoFiVD2sAg7UQTNnXyIE8HRIC8+ERd9XV9FXDI5c1zuYPKZvb8hCUHdtMlE42dG3Av45bpvYxTzVGdYnOuUGpYwRpCRI52HYXnkar7eR+2OfdRdBheVkCKULycdTsBriBAlNcU8H0iPphAcikcKhfjifM7LtrmTZja2iJ44beEv3y2YoW8lBJJ/GIy5uuSsaGm9KW5EB3vpnDyoewoBsEI6Izn/gOu3df6L+V6lLmacBQ8dYMnAHqsWBvHGJtttZ4GV+F2whC2HQB6Y2S0AsoetWllZawQIwE0+kkTu5mpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntwBx73OmYh2SG5mql/USukL8hUc/8L2iwhCYhhoIWw=;
 b=uPOhrsfdTieoVMgAnp0T9bg+NK+vu741UHS8befLLu/6EJrFOzyAF8Omq9sicpxtCDXszn1mZD0mrNQ1q0La1tBkF6ffL08dEQ0i6h+LfxgnPYu3wu9dJ67ySYg0+grnLRMxOstfA9P6BlTN3kuoqirXQQGvmYJVcHRDtCvhR84=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4545.namprd10.prod.outlook.com (2603:10b6:303:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 13:39:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 13:39:12 +0000
Message-ID: <81c2935a-7bb6-4d56-badc-705b60dd1169@oracle.com>
Date: Wed, 9 Apr 2025 09:39:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: add missing selections of CONFIG_CRC32
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20250401220221.22040-1-ebiggers@kernel.org>
 <35874d6a-d5bc-4f5f-a62c-c03a6e877588@oracle.com>
 <20250402162940.GB1235@sol.localdomain> <20250408204514.GA3142638@google.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250408204514.GA3142638@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0041.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: ababce9e-e9e8-4c7e-c939-08dd776be991
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?U2kxcER3eWg4a1FYMnUyRm1OQ3lhVndVd0NjZTBndjZTZGsvNHNJUkV3RDNs?=
 =?utf-8?B?MXRRMy9EalVHR1R6Vm00N1lyYXJPM0lFMHhBUmw3SGZvZ3B0US94dWVHZ1Uw?=
 =?utf-8?B?Yk1GY3BTT3Z0eVc4TDBoelRVWDRuZ0RYL2wyOEh3V0p2OFZ1a3pwZ1ZhTVV4?=
 =?utf-8?B?UVQxTTduWFBFaGg4WGFPZFNYa3doZEtFMjNDa3JqVE0vS0M4LzJzYnB5Ty8r?=
 =?utf-8?B?NjZQMmhCeVc3VzNvKzJWR2tKMWtTb1RJOFQ2QlowS2hZaSttRWlQdmZXeEpx?=
 =?utf-8?B?ajdOeEx6c0ZQZmNCMDdnR1Ric25Tai8vcTF1ZVlDZjVBUXREUnNRa0YveDRS?=
 =?utf-8?B?OXZZZUZPaUpsUGppNyt5cndsdTEzSkhQamNOOGw5T1dOMHl6ZGsvVUlxb2Zo?=
 =?utf-8?B?NWxWSGVHeDk2TWZ0Yk8xV3crYkE1NjBoNmF0c05ka3VoeE9TR0dLa0JJSTdF?=
 =?utf-8?B?TU9FeWljMGVQc2pvOFZhOTBUWU05QzQvUjZtdDNaYWRHaVRlekNTR1hGUzlL?=
 =?utf-8?B?U2oyTzJwUmNKNmJiUEUyOU9KYjVFbi9Pb1FnSGRRVlZlSEwzeC94bnpGZGha?=
 =?utf-8?B?RlZuajNieE15TUJCWWxHVlgxa1BvQk1NWVk5TUlkWDhKN3l5dm1jS3J6eXhO?=
 =?utf-8?B?REdBY3JRcmJ2L1JFVDdacnBnZjFMSDM3clY0bWhaeFpsN2Y0UGlNclQ2d2lh?=
 =?utf-8?B?b1NTQ3JJM3NTZFJuZWFFYTVneStmZUNHb0t2SUtPck9WWThFNlNTYWxweHB3?=
 =?utf-8?B?ZEtSYmYxVDMxVTh2bVJiZ1dNL1dtQ0hFbmthQStMM2tvN1ZOaGthQ1plWDVW?=
 =?utf-8?B?YWd6cXFlcE9tbzFRcXllU0ZzbUc2VUQ4VmVKWDBnOWJ6MitYcnRLakcvcUxB?=
 =?utf-8?B?aTFaSnN2VmZTVHk0WGRrMkFmSG1Ua3IvSTViOHhLRGV3TmZPT24rTitHK1lD?=
 =?utf-8?B?MHVoSUhhVEZ5YW5va0lnM2lpdWFGR3hVaGRFU0RBQVY4N3ZsNnRWdko3T0RP?=
 =?utf-8?B?dkNNY2lWcTk3T2VJUFNwRGsvSk04N0NRVEJQR3M1S1VESmtTOHZ0U1VCYzFL?=
 =?utf-8?B?QjZhcnJOMFdLT2R0cVdCVTljdzNYUTlRVlM2MlZnOCttdEprYk14UUc3Y0Fa?=
 =?utf-8?B?b1hHVVBWVkV1a3JSVHRzeTlDTDhGQmlnTFFacDZrT0FqL01HZTdiaitwZzQx?=
 =?utf-8?B?VWFwdGM0UkdDcTV6Z29QVDNGUW01RVRlSTd1SzhOc2VHK2l3M1JRZFdsL3N3?=
 =?utf-8?B?Vm1lNGh6azRlT2xPQjBOQzdXVFdwZ2hvdGpUTVlVUUt2alBnUG5zQ3FWRFpm?=
 =?utf-8?B?bmU3QTNyb1AzdmVxZ3p6dytXNnRZUkdDMEdFVngvajZPaWYrZXgxTGEzSDZl?=
 =?utf-8?B?TjJkOE14d2hOZXJWSmRYUEtNTkF4NXBRaDY0RklJWEFmbVlycHE3SU9Ydytw?=
 =?utf-8?B?YWNIenJKU293RUs0QTBjMS90YUM3L3lqMG1HZk01VjZsSEtIVkxTSnU4czA5?=
 =?utf-8?B?ZTV6aVFqdEUreU9iak14b1pxUmZqSmVLUEpEb3ZLNTFEaS9MSm03ZWIwUS91?=
 =?utf-8?B?blA2MWJzUlRMbDd3amtsM0NhWjRuV2duK3ZYbnRIMXhrME1DMi9NYzQyVldB?=
 =?utf-8?B?TEFPODE5YllIUlRwUG9GMzVyRHVUV1BCQ3FpUzVxb1NzTE5lYXp2K2lXRW4r?=
 =?utf-8?B?ZU52T3dGak12bW5QR0NmRHpUWTc0d3Z2QXZ3UzBGY2oxSkZ1RmQ5Wkw4Uzl4?=
 =?utf-8?B?YUxGSVcvZEpKdnlFRUYxYS9mMFkzdFY0alBlZTBraUdmVWtpMHZaVE02Lzd2?=
 =?utf-8?B?czRiSUVQWnNlWFlXZTVRaVFBNURLb1hZYkJSTzMvcWtHVmg0dWFtYlk3R003?=
 =?utf-8?B?S1lOcFdhS3BiQ1ZldXZ5YnFSTFJIRndGUzVTWEtwRG1GRzRURmZISXZlbGRQ?=
 =?utf-8?Q?UyTACuiP9Pw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?T2wxbWxaWVhZaDRlTitCaDd3RzFVTmxHR1pxQnAvV01mUjZpbGJtUUwxUU44?=
 =?utf-8?B?bVFMcFYwWVc2SnNDQm5GeUdGck1hcW5IRjByN2xVa1FzZE5sVkd4MEJlbkps?=
 =?utf-8?B?dGIwSjJ1RC9QNlhJWWFzU2YwV0NlZno1a3FIdk5hU1VreHhtWlJCelVKS0RJ?=
 =?utf-8?B?R3RQOG9TT1JEZlFJU3ZKMHpzQUVIckxtK1BUQUtETnJibkowY3hXN3ZuTnBq?=
 =?utf-8?B?QWRpeHIzaXNJdGl5UjlPZlFSOUM0ZnZhSXVSTGNFRjUvc1p1R3RxaEhFRlBj?=
 =?utf-8?B?b0ptbS9TQXJpNFkxdGc2b1FBdHVGU0NyelVSSXFBY2IwN1RyalNRQk9KUmhC?=
 =?utf-8?B?L1cwS3phYkNhMG5rZ29DS2puU2kzU3o5OXpHTDRvcm52QitYL3ZnSFIwenNI?=
 =?utf-8?B?aUlPVGNJM0x4TGtHR1NDYWVDZkxYUG1zRCsrbU12SUU5cmpDSWQ2WDZOQ0dv?=
 =?utf-8?B?MzRLYSt5Nkk1MmJCNzBwakxZRlNCK3VDK0lQa1dqZ0QzNm9BSU1NR1dLa0xD?=
 =?utf-8?B?U2FJbHZJSXRtRkxUVVNrUCtCVEVNeituVUlDbi8wRVRQRXBLOEoyblNjZ09i?=
 =?utf-8?B?VzAwNkM5dlVkVllCRGg5ckg5U2pZRU1JZ2VkRUxndXI1VnJiTXhKMjNlYkxD?=
 =?utf-8?B?Y0ZJT0Z3TS8rM2dEY3U2VVBiV2QxMGFOWGpKNXVqNHowaVdUeEVOT0g4cFZH?=
 =?utf-8?B?Skd5TFcyd3UyQnRrTHlNd2sxZzR4UnAvVUFHNFpkMHpUNlFoQXcrb1V1Sm1I?=
 =?utf-8?B?czZQWlZUVlkzYWkyM0hWd29ZZ3RMRVMyYXJRb3lKVGlSbmE1cldUTzB4M2Ry?=
 =?utf-8?B?T2Exd3VaVG9pbUdYaDNtZHFvaHNXUWZyMDdobk1OMmlGNnMrTTVTdUl6blk0?=
 =?utf-8?B?eVFaNDl4NGQ1T3RWWmRqV3FWeGQxS21uaUFBZHBqNE5hRSsvTXJWSithNGhV?=
 =?utf-8?B?U1JXVGo1SDN1ajNWMjl3RXk5cEhsWjQ0bDlSWW91Ly9GeldnajdNbjZVZzlD?=
 =?utf-8?B?K01FcFA3cGxEanJOM3QwZzJYWDd3bERlQXBXOHVDQ0VQTXFLQm9Ca1RoUnFL?=
 =?utf-8?B?ZVd6T2Q0dGhrSS9CSXBpSkpGdWtyS3dVMlRTK1JwcGZ0aG9xY2VPR1Y3eVR5?=
 =?utf-8?B?ZkxaZ0Nra1RjWmYzdWtTMW1GT0NQS1BVS2dZS095SCt3cXhrMjlwY2JSU2dB?=
 =?utf-8?B?dS8zVk9kRllTRlVQS2RtUHY0ci9SakNDQnZua2x6YXJLVnlacURpOU9WNmZy?=
 =?utf-8?B?Zm5wbHNZM3VFcjZxQVpCMWVkMXg5dGVNaWhjMlBza1FtMzhiaGpnK3ZpTEM5?=
 =?utf-8?B?TWExZCtuMTBqSk9EU0hXZWQ0dlpyWmtGcndxSXRuZmNlcFJvU3NzWnlqRUlM?=
 =?utf-8?B?bFBvemxNSTlMcmtoT0F3YnlRMjlvTVM3QUc4aFQ5Skt0QmdpTFJHcm9Mejd5?=
 =?utf-8?B?cHlWbXdxOHAvTmxXY2hnY1MxSityczRlTG4yWU42K041MitwQmMrTVdjeWZP?=
 =?utf-8?B?NGxSU21sM3ZSYThXblloSEhmOTNoNzhhTUg1M3VyRlZQQVhvZFUvN3ptZlRG?=
 =?utf-8?B?QkVNU1FteFk1Q1RUZzQ5cnVPV1N3Q3RGS21KUm1iNndCdzFqbkg4b1dJa3p6?=
 =?utf-8?B?b01VMVBOV0kwL1Q2MWErZkxzNTZyMmFIZHkrc2JrcUVhT2hDK00wTjczMTNH?=
 =?utf-8?B?ZC9hUXZCQVdNWGl2b2o5SUM4VENXY2lUY2c1eGxkTE93SlhTbVlCMjZsZkFJ?=
 =?utf-8?B?ejZFUHVDam8wSytCOTd3dndlYWJoSnZsMHRMbVNmTzVOK2NxT0cvdGZVSHp4?=
 =?utf-8?B?RlkvM0dGU3lOV05mV2E4MFptQTdrN2J6VllNNGw5R2h5dVExSGJYWnJsN3d2?=
 =?utf-8?B?WXRVZy9yTGNYUVI0L2E2WXlja21Wd0tlbFcxZFF4VnphajUyc2Q4ekViYlFJ?=
 =?utf-8?B?M1M4cXRCSEMxcG1Qd05HZWJVaW82enJEYUtDTVc2RC9GQVk4RUVSNEdGcUtk?=
 =?utf-8?B?Q20vb0RQQ0Z6T09IMEsvdWRFeWo0R2xobzJVdWNBbmtFaEtvMlBVd2s5UHJp?=
 =?utf-8?B?NnZzalh1ZjZweWw0cnMxeUpaYit4ay9FMTVoVlQrWUJLbkhpU3RUYno2WlFS?=
 =?utf-8?Q?U2NcDAKgru/IfaGLS1Sk8zpc/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C3RiG5Q2uDdhjbNFBhCvg3ZetzZ28dvMnv91+9Mqq0R6jAF3iH6HAMNEQ5YaTu9twSsGyqYk0t8SKv2w3sLRU+9nEgK/zFafKKRtizthosPeyVgh/DFl7XTH/COrOZbdcrEfjhA+oaJXQMKfwy7DD/5GP2uGKioMHBMQzT5BhRsUf9/tS30kqN/Z08Kvr3WRwu82YJhFxlhA7R1iX0IXntYv6Ukv3Kmd7snf4v5EPxapvsSdnf2S+Be1xH8vqvO82Ex6Ll0nXbkadr8FqX9g2kBhomM91kpwCAMOmxFIfNmnLdFCYHrIwVIfQtRSErr6UOM4LlReo6mjKieXDdojz8xPUzM+mwMTQA/E8Mb/W0EeBrGIoH3VuWbHOlYHwHmVxMq6wu79m/jQS8+C8s4sX4yFJKesdZgdhx78/qIzm3eOr4RoxBlSMXEoCQXG7sO9t3+NeYdrj6tvEhu29/JqZ4vcK1spN8o8Bm0i2zwTic1FTL0oJ4begljcNmXQ6Ip01WHluqY7eV0tzUCKScE3p31TaKselBw+thqPkSVRN3053j7MZ33/cat6xdNCuTQMKF3FFT6nveJs6Uqe/XV3XT7GqbjqHZRHxcLGB3ksqf8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ababce9e-e9e8-4c7e-c939-08dd776be991
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:39:12.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J352SdQsW09vOh57SwrDmKXRvOS8etnPJF5rkflRKb8hgarg5P2yYnHPAeH/wmjisXeHBYo/d4sCe2oOn+MWug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090083
X-Proofpoint-ORIG-GUID: LhL_ikVElndV6JOYhjqZ01VzD9hUAFAd
X-Proofpoint-GUID: LhL_ikVElndV6JOYhjqZ01VzD9hUAFAd

On 4/8/25 4:45 PM, Eric Biggers wrote:
> On Wed, Apr 02, 2025 at 09:29:41AM -0700, Eric Biggers wrote:
>> On Wed, Apr 02, 2025 at 09:51:05AM -0400, Chuck Lever wrote:
>>> On 4/1/25 6:02 PM, Eric Biggers wrote:
>>>> From: Eric Biggers <ebiggers@google.com>
>>>>
>>>> nfs.ko, nfsd.ko, and lockd.ko all use crc32_le(), which is available
>>>> only when CONFIG_CRC32 is enabled.  But the only NFS kconfig option that
>>>> selected CONFIG_CRC32 was CONFIG_NFS_DEBUG, which is client-specific and
>>>> did not actually guard the use of crc32_le() even on the client.
>>>>
>>>> The code worked around this bug by only actually calling crc32_le() when
>>>> CONFIG_CRC32 is built-in, instead hard-coding '0' in other cases.  This
>>>> avoided randconfig build errors, and in real kernels the fallback code
>>>> was unlikely to be reached since CONFIG_CRC32 is 'default y'.  But, this
>>>> really needs to just be done properly, especially now that I'm planning
>>>> to update CONFIG_CRC32 to not be 'default y'.
>>>
>>> It's interesting that no-one has noticed this before. dprintk is not the
>>> only consumer of the FH hash function: NFS/NFSD trace points also use
>>> it.
>>>
>>> Eric, assuming you would like to carry this patch forward instead of us
>>> taking it through one of the NFS client or server trees:
>>>
>>> Acked-by: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> for the hunks related to nfsd and lockd.
>>
>> Please go ahead and take it through one of the NFS trees.  Thanks!
>>
> 
> I ended up sending in the removal of 'default y' from CONFIG_CRC32 for 6.15.  So
> I recommend that you send this NFS patch in for 6.15 as well, as it's now
> slightly more likely that people can end up with CONFIG_CRC32 disabled (though
> many other parts of the kernel select it anyway, so it still tends to be
> enabled).

I've moved the patch to nfsd-next, which has exposure to community
automated testing robots. If no problems are reported, I will move the
patch to nfsd-fixes and push it to v6.15-rc in a couple of weeks.


-- 
Chuck Lever

