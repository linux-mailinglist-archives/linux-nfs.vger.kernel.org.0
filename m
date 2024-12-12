Return-Path: <linux-nfs+bounces-8535-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A48C9EFF48
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Dec 2024 23:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354CC2882B8
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Dec 2024 22:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51741DE3DB;
	Thu, 12 Dec 2024 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ldNQjFOt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qRlAEl2v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F3F1DE3BF;
	Thu, 12 Dec 2024 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042372; cv=fail; b=kBN6B6YOzEkJyOQWl+TpVaZAeIK73X+QdFcUH0GBO5vB9qHe6SFEfid3M0ycG7GeWgbwO9TBIi6p4fpasNI3odHEkUC0YGOOIHGe0aCzdvecltkBx4+GLtaN0vSL15ElXn/8egWL2BTDaG+icl7RCS7/eXwhB7TrdmcuXxfqN0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042372; c=relaxed/simple;
	bh=652rrCIbPuJzKq4NNuggokbjRTmJ/PkwrLNOBAWpjq4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sFhlMEdHyraPIx+p1d6W/NUXzoBffp8aa7mySBqybNM4wyP8Cs38jLS5gtxw+Ll6x+VwaOsy3V0u4LyvUyNVBRcXPJV5nXonCEpzF4Lj5HoF7vTpZ+z6SMsuuu6MVYFkfBF9LcB/ge8pxcmVsi6hy2CFhqPFASUood1enlUF5Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ldNQjFOt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qRlAEl2v; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCJfvWU028759;
	Thu, 12 Dec 2024 21:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jpIJT3GzvqBXt8YyqbkcUFEL8C5Th5+qsmTpjj3vJ+I=; b=
	ldNQjFOt6zky/sCGwc0uDxl7LX/lh0QzNe3LW8wM6bgkER/iERCei0MAAGMwQNh6
	LcvaA8oMGRr+Ab03YlgeoLTP0bXgIXBqHBHfkpw5pDzFJOzfrb+BmUV0MRYm3NSj
	zvVvoSdIt054S9TDBXes/wT6+7Y3jfLazxzAf+zI4TxZdNnzbTj59oqFwqfDdycB
	lHYtPXJSH6UeJRm8hoVdFYtBUKP0zifx6MXEbFm52YM6Vwlp/BnZVPyNHW9Ldh79
	SpxyPbw3MCdUQHXS9A6OUfY7j2zcK69nnU0EYdeIzjk/aqGUutYLOEg56BlEGIiJ
	rD5Or22qeQdf+B7Agg17mw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9av77x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 21:06:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCKGoAM036326;
	Thu, 12 Dec 2024 21:06:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctbydtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 21:06:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EISVG1hKD+aaipCJrk/sPvdfP4jz17eWBBkGDj1Wr0idywPNPYutNtOJfqBIb3HWL/iDLe6YIA5nfh8RW5627brwc0Zf9taJ8VISdG1lNx3wThaFXyNkTt2ILhvbRGmj5PkoJ7V6RXCWHEF7OJ+jfjUDph4zmEvU0e+KLMqqJ6XfVJrqSx9CysSpH9DmdSl0iNFhvwIWlsSjOgpzfBdfb1LA1Mq0EsNmwoxLIbOPdP3pITHDdxr3q4LHj8F3iLRH9Y/ui2AN+wfBLnQNeNppdNDMJjPmRE/Xe471EXXT0H4B/12dU+oBoNbMfVEqMU7hFwxabMu7+HwVtxLw9o7Zbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpIJT3GzvqBXt8YyqbkcUFEL8C5Th5+qsmTpjj3vJ+I=;
 b=SEZQV9Y3jHb1o0x1L8B98gyi9lbxAzKrFNiuI44++BMCtuvUXCJ6SHSifgDbUNYItmTumOzE3DLAEIZs6RUaO0EK/0F3J6C1GRukqyct5CIVstyPmHPbr4MOqb7vjyhfakWhNlsA6+DdFxVme0szpA/EwEXby9pGXafjx/0qkTjrFr/6p8LGF0/EeMLWmiYqBRMRIjrzVMnxmv2iQN2IUmZ6H2qxRYOXYIoiBEyGxHaiv2NFYclrCCz6NR6Bemgkhdml8N5vMZWb2cbrOQQQpsbfkGEgs6+7k8yNzm66RyUrLnqUSxx5JxDnZ1ad6VKh3oEafi0fql/X+t96YBWT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpIJT3GzvqBXt8YyqbkcUFEL8C5Th5+qsmTpjj3vJ+I=;
 b=qRlAEl2vibpPwcrVzVWcbHNGhzpAKVGceA1BwkbEBOKP/C/g24SO0oH5ZJmzBTE80xoDm2sVthIxUXS3B3LSigSgLA8nXcC8iL8HCFAXPraaSFHCyASu1WLH5t4aBQ6bE4pdrGezu+DWdOkmn0KuBMmGvux4bSXoy0aEIwh1u/Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Thu, 12 Dec
 2024 21:06:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 21:06:21 +0000
Message-ID: <2a3c0a1f-0213-4915-a4c0-a2ba31ae1bbc@oracle.com>
Date: Thu, 12 Dec 2024 16:06:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] nfsd: handle delegated timestamps in SETATTR
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20241209-delstid-v5-0-42308228f692@kernel.org>
 <20241209-delstid-v5-9-42308228f692@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241209-delstid-v5-9-42308228f692@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:610:e7::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d53437e-b8d6-4924-0c8c-08dd1af0d3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmlyY0pqVk11WEhoZ3VQM1ZwT1RQNjViSTFoSkRqV2VIRFNJbFYwb0h0Y0ln?=
 =?utf-8?B?TW1uUGxna0VNVUZkWHdTcDF3azAzSzZRLzJLcEVFanprUTBTMEpMVld4KzBr?=
 =?utf-8?B?cCtIOEd5Qm0wcEVaTjFGcTJLbFJHSS8reWJtUXRIanBDTVpDTk5aT3QxL1V4?=
 =?utf-8?B?M0Vsd3VhNTBnQWNLcE1HZ0J0WHZsM1BDSy9PbS9PbkFQL1l5YVNuUWdlQXFE?=
 =?utf-8?B?c2EyY05nTFZGTEZZbmJpVFNMZlJOSzRNZmJPWWpNSlRWWHBJRXQwaVlzblp3?=
 =?utf-8?B?bDJ3OHFrUWJFMHFYeDQ1eFBEczF2b290bndBaGxiWks3dXdmaTRnQURjMmZP?=
 =?utf-8?B?dkNzaGNLM2NxR0JrNm5EQmMzeTQ1L216eG5NS0I5VUlCWDZoRGFSS0NpR0JE?=
 =?utf-8?B?Mm9OaUZwSHdIRUppSjA0NkVHaXJNek5RVEU2bS9UdkllZmlEUkgvbUY2ckFa?=
 =?utf-8?B?SVR1aXM1L1o5Y3pSc0dkd0RHQzh3ZjFRV3psZURIN0xxcWFvUTJVa0ZCUEgv?=
 =?utf-8?B?dCsyUVhVRzNIV1ZWMDJYeHFXc2tzVVZLQVJUcnJydHVvblRsTTc0YVBLVzVZ?=
 =?utf-8?B?WmxpRnJXc215clJrNzBmRHY3WThYVzE1RlZnby94elBVcGc2MGNEMmdZaWpl?=
 =?utf-8?B?bWVBTzZDRlZ1ZjkvaWppN2h2ck03OHVZMmFLK0ROdXZaSkN5dEhVRm5DQVVG?=
 =?utf-8?B?b2pVd25NS3FWRXpBZmJFYTdMV2g4Ym1BWDdzZ01OeFRlTVBBUEd0UDFDdXFq?=
 =?utf-8?B?ZEo1cVB5VnRsaHp6NVRDRTIzWGZ2VjExRG1ZUmpBSFk0Nml5UkRxYmZxVDMv?=
 =?utf-8?B?djVtd3BxNHkxZFFOdW9hWHR1UVBMT2x1S3dMSTFBSkFjWVpDRjZ4LzRteklz?=
 =?utf-8?B?OFNPcXJhVmE4TTdxWUMvaHlNc084dGdJdEtsTmhJcVN6aldMYVoyN0Vubit2?=
 =?utf-8?B?ZitsRFVLcVJycFd0MG41VXI5NGV3R25KMDlOYnJEM1BJZlMrUVN5YW5HNUEw?=
 =?utf-8?B?bXFmaWhWWkxnWEhqek4vRDdocTM1aWkzelkrNnptRlQyVXFKS1JKTWdNV3J2?=
 =?utf-8?B?dit6aCswRklhNG9ZN29PN3ZVUTVVVElmdUwrWEtMbHlpcHhWVUNmZEtuRE45?=
 =?utf-8?B?QStYUmprVXNlTUFWVER3Rk12dUc0YkZnMnJzN3pWd3R2Qm5DT25jdjd3Wjdk?=
 =?utf-8?B?THFHNElYYkFPeHFpaXJZK1BKSXNRM2ExRGtnSGdvRlRQK09Falg3MXBKSzU1?=
 =?utf-8?B?dEgwbnloS1BBd3Q5VzkyQlVnU01ZUjR4SFBWSUZoNitjc1FCZDlpMGc5WDVD?=
 =?utf-8?B?RWluZTBIb1lVaEsySmJSNklKMW85SzdFaGdrNFh5aHpIS3pYSFpvbCtuZWQ4?=
 =?utf-8?B?cCtSMkp2UjdTZWJaMUYraU9XMkVSVzFGMVN3c2FzMVpjU0xacEJvNXFCRzMz?=
 =?utf-8?B?WmpLSVhwSUljeFRtNktpcHZIb1hmQk50UW5CMDcvQVVBd3lVZmUxMHc3bE1X?=
 =?utf-8?B?aGJEb2ZsNjZGN0FHM2VHd3hZWERScCtRZ1VBNTg4cmhSU2dBOWZmRWtsYkFD?=
 =?utf-8?B?enpuN0V1WG5NSTg5dzZXVHhFU2IxcCtML0hicmgvaHR5VSsyMVZ5T0pHSVZC?=
 =?utf-8?B?WU9DNGN3d1FaaFExUTQ2N0ZKdTJqejduU1FJSzlqdk1mblpBYUFPYU5FUFNv?=
 =?utf-8?B?d2YyRE9BMWZyYlJRRTdnU0xIZEhRYnovdjFpcjdRZVZTZHdySnNSZVlLbEZr?=
 =?utf-8?B?Qmk3c1NXbkoxaGdYZU5rNy9SRjkxa2xsaTZ0eHh2cmFVSzBRNVRjWEZlOVpV?=
 =?utf-8?B?ZUxRZ1ZqRmtrVTJhY1JYdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFNEN3BBOHlEejcwYWdxWnJpdXBnQ0JEQndubWE5ZnJBYUwwOGpUeEtpOEw3?=
 =?utf-8?B?b1dzM0dhUVpHL3BnTE93YXFIRkd2aDJ5ZGdpM3NGeDhzMHJqQXFBM00xUCtR?=
 =?utf-8?B?UVFndTRrMkw2UTcxdmduUW5UMTRNMlBwdVBOVG41YWRMVlM3bUpESGdFcnlG?=
 =?utf-8?B?YXJ3UDAzQzdrVkl1RGE4bVBvNjdnUm9LNFpiMjZNaXBoM05ZSm8zN2QzTDI3?=
 =?utf-8?B?Sm9BR3ErUEpHYXpuY2JqQWx5LzI3cHNhSjFGNTNHOHZRNmRhUjREeU10ZEdq?=
 =?utf-8?B?VUZBU3JQa1I4YzBWOUJ4TG9BY1dtRmpVSEtpanAzQUZEaGRJaXJRcmN1ZUNC?=
 =?utf-8?B?Nm1iakgrZlBGbm9KMmxTVUZ4TWpBS3ZNSmZEdlFXb3FYNHhLbmQ3ZHhidkRS?=
 =?utf-8?B?eTVrMTA2NTZoREhTcURIU2IzR2hrZDRYaTRiNGZZNDJkZFR4N3dpU2lwaWZY?=
 =?utf-8?B?OGVxQUFmVUZhU0JyL0hzZHYzWERjclowSUFFdmp2Rlp6Wmt4elZxM0J0cFJD?=
 =?utf-8?B?a2VGdG14RmpacTA2YUhVQzhQaThqcmdORjlnYTZDVEJvWkh0SlRTaHVnd0lX?=
 =?utf-8?B?cVNTSFljMVRtUmRYbFQ1RjNRcTZkRzc1NG9XVjRVdGs4ZGdOTklhV0hETno1?=
 =?utf-8?B?bUZQbnpQY3d5Zm5ZaUpvMkJYVFA3U21qOCtYYVNGVHdEVkV4Q2tEMkJCWGxP?=
 =?utf-8?B?b3NqeDV6Q05mRnRuQVZLbkhDL3VQUTJRRFFlcUZ5UFZIVEpEcm5EZWl0Zzgr?=
 =?utf-8?B?Y0dBV3ZGc1NjTUcrN250THJ1M3FWRTJHbFg3WndaR0NCN0krR2ttRnpCY1hB?=
 =?utf-8?B?V2xWUVkvL0phbHQ0SHZUY1R4VTFXNlRLTFpsQXlEbmhFTVI1L3BFTXhoR1Yx?=
 =?utf-8?B?Qnh0Yjd6WlpXWGFrWENXRkN5dlRnMGhOVFhtRXQ2cnR1K29xRGFXbm9iMzZ2?=
 =?utf-8?B?aG9sU3NFTUpQbTl6SzE4ODhtaTRQQ1NEMllwck5KeExuZWFOSEZlVTBNL2xK?=
 =?utf-8?B?bXRPZjhIVlBEeWZFRjY4Y1BhSmJuTWx0MnRicnZNTVZaRUpKRWNzdGVaSEhT?=
 =?utf-8?B?bXhaL2ZUSitSeHFBRXFuS2RhejVQZEphd3AyTWlScy9FM0lQdkdmVnpsSFFq?=
 =?utf-8?B?WGFwQSs5cGIzbkVtbktTYkNHMnVjVS9kRTVIUU0zZHVVQ2dDSnBLcDZhVys3?=
 =?utf-8?B?bUxQcERIOVByM3l6NGw2Um5pRTJ5bmx0ZEUxZ1BJb0lrMHBNSTJidlRWSzEv?=
 =?utf-8?B?aFVaUFdjRHZOSVJJSkluVWxNRnpaejBGaEZkcEtXNWllWG1RbVdjM0dkNloz?=
 =?utf-8?B?STNtWjFLcTNuRFdsYUoySWpsN2oyQTFTTEJEbU9leFh5N2dQREpKUGl3K2lp?=
 =?utf-8?B?ZWNEajhjdTFhTkdLTWhNNUJFY2Y5ZHVGTUoycG1nSGo4bk1Bc2xSRTQzczl1?=
 =?utf-8?B?SGlualZTMGRKdUw3a1E0N0szd1BuM2RITDdaeUNzYURaRTZGL2ZIRTZrQ3Iw?=
 =?utf-8?B?UHUwTTJublZhSVRwanJUN0JxUVdlS2JtTWNleEJBVkY2N2kxTUZEWkswZEg3?=
 =?utf-8?B?b3ZaSlAwcmk3blJ5bWh3c0c2Nkc3b0V4U3UzVTUvdHdmMkIwMUdXclZZUHlo?=
 =?utf-8?B?THhocjdZVjFkTHp5eUZWSkZhQzd2ODBpUnZ3WEdtdWhLbWhXQU9MUDM1SEY1?=
 =?utf-8?B?TzdXRk5JRXpvS1hNWDhDNkFXRUtSTGlrejg3ODhqZUNPUXg1NlpkY1lXM0da?=
 =?utf-8?B?Y01qVmorcVhqbVY2TGpFUDlPSHdTL2UzNXNvTjhGNzk2cjNmb0dYNmQ3elN1?=
 =?utf-8?B?SnIreEUwQ1gyaTM5cFFONk5kc3BzUnZKOFhCNDRhOHBOYytrbTdYeHZnQmJy?=
 =?utf-8?B?MVM5Sk42SG1lUi9oMDNLMFFzUGsxbjhBVCs1NGRlWVhmMEJtakl5c1FQbkYv?=
 =?utf-8?B?YnNWTjVkWmZRMzlvNnZXclA5bENoUDJWT2JyNHVhUWp4bUYwS09aVlU0MHBh?=
 =?utf-8?B?SXd2eWJnSHVCaXVXMHFZbFlNSDloRlB3UXZhYzdvRDIxUEJIWlN4K1VUMlZT?=
 =?utf-8?B?enpUM1pQMVJyTkhSYW9nRlcwNk9IeHJXNGxsclY4VFMvRFoyMXhQMzIwUHhq?=
 =?utf-8?Q?SycMnjQK5DOPG6l4H7wyvNG6k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ARvzqyOwcJe9gjV8EewYbL/gWhqKwPU/7ffcX6hsK4MEN5TcS6zelL1R0DXPZ1DFdEHjzuF3s+vnwDfGF8KhJNRAZq4HfgnLb512sojXQIhOsdvaYxKZlLW/mrZvFBehTviy91NB2WV8loPTAViZKw3Mi2o/VNSddGK+Pn+vDD3170kJr1Z+TZnts0hJkKAO8xpxynrQfIrysJbA4Y62DpMfNJfjr0q7Qfs8Q7202R61YXBsdlrxWn+BBB5QUKVNECW/ciM5ysSqJdY1QlcF2rNphDkrJBn3vLxKmc3mVOVWj0dJcIl9CIcRhQL7Iuor2n3z8YJgw+sub2SqLBhu16uaEuHRGMdK89VY7da1ODXnOdnDMLv1ANGwpbcLSatRf0sccIQfReXDxUVctzNhLFGtHrfkcGPuAuHuRESoHe4m3RAA1ZoDN0qT2vtrU16wLdQeCVU032XDbRnwqVJ/oMM8rORbQj+py8aYiVBXMwxypRpRj/I5HdYbGpy0cnh9vvpTpSUQ8Lkcj/odPQgpKfWQUa+W2vJ+2dHMQgordZoWVMAKh76Eecr0kTXbSx9dxcRg9aEmhSsszQKPbeOAXXn4O/SeQbmcftgHJ9Opgkk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d53437e-b8d6-4924-0c8c-08dd1af0d3ec
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:06:21.0157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5c5BLzY3egckgsWalSz0ZFEA+BDmi5NZFNrnfAMiPLC1adHlTwS7XW7nQjCO13D/z7eIr6V5/lMvMMQDZEGvfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_10,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=973 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412120153
X-Proofpoint-GUID: FJObqsn3i10_rqkcMN1Hv6qMEW914E6c
X-Proofpoint-ORIG-GUID: FJObqsn3i10_rqkcMN1Hv6qMEW914E6c

On 12/9/24 4:14 PM, Jeff Layton wrote:
> Allow SETATTR to handle delegated timestamps. This patch assumes that
> only the delegation holder has the ability to set the timestamps in this
> way, so we allow this only if the SETATTR stateid refers to a
> *_ATTRS_DELEG delegation.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/nfsd/nfs4proc.c  | 31 ++++++++++++++++++++++++++++---
>   fs/nfsd/nfs4state.c |  2 +-
>   fs/nfsd/nfs4xdr.c   | 20 ++++++++++++++++++++
>   fs/nfsd/nfsd.h      |  5 ++++-
>   4 files changed, 53 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index f8a10f90bc7a4b288c20d2733c85f331cc0a8dba..fea171ffed623818c61886b786339b0b73f1053d 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1135,18 +1135,43 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>   		.na_iattr	= &setattr->sa_iattr,
>   		.na_seclabel	= &setattr->sa_label,
>   	};
> +	bool save_no_wcc, deleg_attrs;
> +	struct nfs4_stid *st = NULL;
>   	struct inode *inode;
>   	__be32 status = nfs_ok;
> -	bool save_no_wcc;
>   	int err;
>   
> -	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
> +	deleg_attrs = setattr->sa_bmval[2] & (FATTR4_WORD2_TIME_DELEG_ACCESS |
> +					      FATTR4_WORD2_TIME_DELEG_MODIFY);
> +
> +	if (deleg_attrs || (setattr->sa_iattr.ia_valid & ATTR_SIZE)) {
> +		int flags = WR_STATE;
> +
> +		if (setattr->sa_bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS)
> +			flags |= RD_STATE;
> +
>   		status = nfs4_preprocess_stateid_op(rqstp, cstate,
>   				&cstate->current_fh, &setattr->sa_stateid,
> -				WR_STATE, NULL, NULL);
> +				flags, NULL, &st);
>   		if (status)
>   			return status;
>   	}
> +
> +	if (deleg_attrs) {
> +		status = nfserr_bad_stateid;
> +		if (st->sc_type & SC_TYPE_DELEG) {
> +			struct nfs4_delegation *dp = delegstateid(st);
> +
> +			/* Only for *_ATTRS_DELEG flavors */
> +			if (deleg_attrs_deleg(dp->dl_type))
> +				status = nfs_ok;
> +		}
> +	}
> +	if (st)
> +		nfs4_put_stid(st);
> +	if (status)
> +		return status;
> +
>   	err = fh_want_write(&cstate->current_fh);
>   	if (err)
>   		return nfserrno(err);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c882eeba7830b0249ccd74654f81e63b12a30f14..a76e35f86021c5657e31e4fddf08cb5781f01e32 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5486,7 +5486,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
>   static inline __be32
>   nfs4_check_delegmode(struct nfs4_delegation *dp, int flags)
>   {
> -	if ((flags & WR_STATE) && deleg_is_read(dp->dl_type))
> +	if (!(flags & RD_STATE) && deleg_is_read(dp->dl_type))
>   		return nfserr_openmode;
>   	else
>   		return nfs_ok;
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 0561c99b5def2eccf679bf3ea0e5b1a57d5d8374..ce93a31ac5cec75b0f944d288e796e7a73641572 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -521,6 +521,26 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
>   		*umask = mask & S_IRWXUGO;
>   		iattr->ia_valid |= ATTR_MODE;
>   	}
> +	if (bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
> +		fattr4_time_deleg_access access;
> +
> +		if (!xdrgen_decode_fattr4_time_deleg_access(argp->xdr, &access))
> +			return nfserr_bad_xdr;
> +		iattr->ia_atime.tv_sec = access.seconds;
> +		iattr->ia_atime.tv_nsec = access.nseconds;
> +		iattr->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET | ATTR_DELEG;
> +	}
> +	if (bmval[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
> +		fattr4_time_deleg_modify modify;
> +
> +		if (!xdrgen_decode_fattr4_time_deleg_modify(argp->xdr, &modify))
> +			return nfserr_bad_xdr;
> +		iattr->ia_mtime.tv_sec = modify.seconds;
> +		iattr->ia_mtime.tv_nsec = modify.nseconds;
> +		iattr->ia_ctime.tv_sec = modify.seconds;
> +		iattr->ia_ctime.tv_nsec = modify.seconds;
> +		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
> +	}
>   
>   	/* request sanity: did attrlist4 contain the expected number of words? */
>   	if (attrlist4_count != xdr_stream_pos(argp->xdr) - starting_pos)
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 004415651295891b3440f52a4c986e3a668a48cb..f007699aa397fe39042d80ccd568db4654d19dd5 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -531,7 +531,10 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
>   #endif
>   #define NFSD_WRITEABLE_ATTRS_WORD2 \
>   	(FATTR4_WORD2_MODE_UMASK \
> -	| MAYBE_FATTR4_WORD2_SECURITY_LABEL)
> +	| MAYBE_FATTR4_WORD2_SECURITY_LABEL \
> +	| FATTR4_WORD2_TIME_DELEG_ACCESS \
> +	| FATTR4_WORD2_TIME_DELEG_MODIFY \
> +	)
>   
>   #define NFSD_SUPPATTR_EXCLCREAT_WORD0 \
>   	NFSD_WRITEABLE_ATTRS_WORD0
> 

Hi Jeff-

After this patch is applied, I see failures of the git regression suite
on NFSv4.2 mounts.

Test Summary Report
-------------------
./t3412-rebase-root.sh                             (Wstat: 256 (exited 
1) Tests: 25 Failed: 5)
   Failed tests:  6, 19, 21-22, 24
   Non-zero exit status: 1
./t3400-rebase.sh                                  (Wstat: 256 (exited 
1) Tests: 38 Failed: 1)
   Failed test:  31
   Non-zero exit status: 1
./t3406-rebase-message.sh                          (Wstat: 256 (exited 
1) Tests: 32 Failed: 2)
   Failed tests:  15, 20
   Non-zero exit status: 1
./t3428-rebase-signoff.sh                          (Wstat: 256 (exited 
1) Tests: 7 Failed: 2)
   Failed tests:  6-7
   Non-zero exit status: 1
./t3418-rebase-continue.sh                         (Wstat: 256 (exited 
1) Tests: 29 Failed: 1)
   Failed test:  7
   Non-zero exit status: 1
./t3415-rebase-autosquash.sh                       (Wstat: 256 (exited 
1) Tests: 27 Failed: 2)
   Failed tests:  3-4
   Non-zero exit status: 1
./t3404-rebase-interactive.sh                      (Wstat: 256 (exited 
1) Tests: 131 Failed: 15)
   Failed tests:  32, 34-43, 45, 121-123
   Non-zero exit status: 1
./t1013-read-tree-submodule.sh                     (Wstat: 256 (exited 
1) Tests: 68 Failed: 1)
   Failed test:  34
   Non-zero exit status: 1
./t2013-checkout-submodule.sh                      (Wstat: 256 (exited 
1) Tests: 74 Failed: 4)
   Failed tests:  26-27, 30-31
   Non-zero exit status: 1
./t5500-fetch-pack.sh                              (Wstat: 256 (exited 
1) Tests: 375 Failed: 1)
   Failed test:  28
   Non-zero exit status: 1
./t5572-pull-submodule.sh                          (Wstat: 256 (exited 
1) Tests: 67 Failed: 2)
   Failed tests:  5, 7
   Non-zero exit status: 1
Files=1007, Tests=30810, 1417 wallclock secs (11.18 usr 10.17 sys + 
1037.05 cusr 6529.12 csys = 7587.52 CPU)
Result: FAIL

The NFS client and NFS server under test are running the same v6.13-rc2
kernel from my git.kernel.org nfsd-testing branch.


-- 
Chuck Lever

