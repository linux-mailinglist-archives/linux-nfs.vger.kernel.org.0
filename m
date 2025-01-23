Return-Path: <linux-nfs+bounces-9566-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A20B6A1AC98
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 23:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1670166B0F
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 22:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011221CAA6A;
	Thu, 23 Jan 2025 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dfmk9kW0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sMpNLPdh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4331E4A4;
	Thu, 23 Jan 2025 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670729; cv=fail; b=SdD6tSFg2Am3Xhjj+2EecePB+VvuyNUOaklQn+rQrZJyEZXghS3GcONaA7ZFwA7NvfJp+fRUtGSb6iKuwgWU+XO3vsIZX+r5Aj+wGBOre2D3p8oCp4fGlyVSkJWlpakL96H0gZfi6Jkw+rfPucCACF2qOUHcgm0I6FA9cCWS//c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670729; c=relaxed/simple;
	bh=UQttin5A9yZqReIjgAaTnMBgRXHGcvWZ5BZrGhV+dOg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mroBcL8FgZklrDdltDExacFflxK7/Cho63C7AOi6HocwQaXhyK+OB1z9A1NgggHX8CgNQNZ1rVepFMndmZBBXEZgYmwZ1TN4Cy97AqYvdjES2lIHDLepnFi+VwW/UROA2g11HQ6jMbiL+0ZdxWwDeCZFczDSeXj5CPuTRb/zM4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dfmk9kW0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sMpNLPdh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NKfcG8000393;
	Thu, 23 Jan 2025 22:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YwsCeYfFZgPfKWu6MVCl+y6bHNXRccdmONU9IBNaWws=; b=
	Dfmk9kW0esqf82yv9x9SMR1krfqPaysvdN5I/HdDRvb93rHZyMmEGGV9A3jargrv
	CMd3mVtrb/+KTlW1dWutmia2nsSla8TWEjZEFBax1tNoZd4yr6zLoGdGCB31sTOa
	FjLnpTPRI6NTNidegzQhNqvNXYl3XRgAzAf2iwmBqyKjiK5N4cItBt0HH3ajbuc2
	zLf/Z9Cxls3sg652LFPrWHzsbNOe79XvMeTEJsCAw7/MPtY97igkPt6LZsx4wHWI
	L1tKorhQ3bwMAKZiX/P1jrJdUJgzOI1H61FxqhOnn/ShQ2z2vwA8HoUiOEUETjPF
	3cGaAynfD3oVnl5vGGwA5g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awpx3s1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 22:18:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50NL0eF7030478;
	Thu, 23 Jan 2025 22:18:33 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 449195s71c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 22:18:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFPLAIKE7h4p/ZRmHnYvaHs+WvPvUQV567xZbYMeJy7wxny94iY1Y0joYOxWaNMt4e/4bKOT9pdpxJGmSrtZcH7yEHCPd52MXNE3nqyabWF9aRTruS5vSfztQBwM0ocE+wSsc/XmfkGIQA5ifsK58K6dNNFKUBZLJ1tZy7P+AZjtZ6VSyqwgp+f5pOCT5H4pODRtJaP2E+5YVBLar8P3z5Z4jJ2d+HjHEmn3eIUiakt/x3kMQMZtlA6CU5lkdlIUBi9S+kObx9ubT38eGHwvgt2FqaYcHTolu+CQaoYmDd80wxP8lTqZozRYvpXEBMvlCUL0WHXcU36KnJjXROiQkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwsCeYfFZgPfKWu6MVCl+y6bHNXRccdmONU9IBNaWws=;
 b=iMcRqPQy7p9pUTq1XGYAW4EfCuIg/i6SlXF42BfzcBO679UadbMvCNCGntCxnfCfNhM4jKPUPlLLYHD82QQDiCNIc8lEATLxYTT4qFNWucdt8bkOoELwZra69Gq/A/0l1Rhhp+FEo9vgaWEIpAoW9vEG9TksQJ86g5pML+Fj8BeDrkuyTM2AiV9UVMGixLP03+ZjUWVhcmXEnkmdt5KNmk+8wqUIChpOcqY8+J2GOSVVBQ87KH1AcTbDId2Qk3xCKycwktW/lH6W4in1g5aTBmcABiBC7sHC0JxjfV+wzRvkGqBVl0RAsODLL0UaAAGG8TWhH5afnegi2i/RUckIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwsCeYfFZgPfKWu6MVCl+y6bHNXRccdmONU9IBNaWws=;
 b=sMpNLPdhap1nXIJ7YwInprq64/qjXIRqvd2c9/2j4Xw0ohZgoK1wkUMUh7r6Mn/ihORdkabjWYPfsiaQ16vF73xuYp642UGaNjgDQKkx+1A42E+pUJxcbYhqNehsT1rq/aOQhGfpV+q4oUbkyiuTqePJC511HMGSmZTDTQYlosc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA6PR10MB8111.namprd10.prod.outlook.com (2603:10b6:806:446::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 22:18:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 22:18:31 +0000
Message-ID: <a95521d2-18a2-48d2-b770-6db25bca5cab@oracle.com>
Date: Thu, 23 Jan 2025 17:18:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] nfsd: when CB_SEQUENCE gets NFS4ERR_DELAY, release
 the slot
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
        Kinglong Mee <kinglongmee@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-3-c1137a4fa2ae@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250123-nfsd-6-14-v1-3-c1137a4fa2ae@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0031.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA6PR10MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: efaae8b5-cdf2-44fa-0c5b-08dd3bfbde88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDZuN0h5Vmk2end2TzBkMFZlTUhtb3VHWXpYNFJ1eGZUcU83bCsxZlFjdXVZ?=
 =?utf-8?B?RnB0SUVPaUdKM0lhSlFZRGFiNXkvQkgveWVCWWs4ZlhuNExDZUhhTmc5SUJK?=
 =?utf-8?B?QXpvNCt6TDhwSkZEZXI0RGZmaUlDWTBHNGg2NTA1cTVxbjVCUjAxR1B1Zld1?=
 =?utf-8?B?T3Myc3NJdFBOcXljS2pCaCthSnpFVW1NN25xczN4MFRWTnB6UE1vWWVHejFl?=
 =?utf-8?B?bSsydlZtUFVDbkpQbzNFVG8wZkhBYkFiT3llSk9tdXVQR1hTYWNPVHR6YUJj?=
 =?utf-8?B?UGpWWmFtanNHZEdMc1o5QzdyVzdaVjIvZ0dCZWNYS0M5aUpDNEU0M2p5d2NT?=
 =?utf-8?B?b1hCbjcrWDdtcSs3RVVXa3VoN053dk9mZzZ0Vm5yS2k0VGQ3OHNsNTI3dmlB?=
 =?utf-8?B?clBOUThRd3pDaWR1VEZtaXluZ1NkZlhXNFBXZTV3VEJQWU5sRnFiNmZOWmxw?=
 =?utf-8?B?TGtmdkEyQ3R6eC9SSU56UkRyZWR0OTIvai9nMWFicitYd2Z0Wnl2Z0NFS0RK?=
 =?utf-8?B?elVCTVFPTXFvSk8zSGxSUEMwMDdmdnRRK21zY2hENkNOV0F6dU1YVnlFUE90?=
 =?utf-8?B?SW51NU83TjljQURBRTdCTExRejR4RnlBaGh0eEtzZWJ5OUtLby9FTjJJTURm?=
 =?utf-8?B?KytwY3dVbHUreWQ4NUN6RGNBSVVQL2YwR080Ukt3ejUwUnVuNUR6NHlreXNY?=
 =?utf-8?B?TXFadUJ1MmE0Y09oaHZEK3lIY1k5dmFTYVQ5TlhlMitXVGk2aE44MUlqOVNM?=
 =?utf-8?B?c050bW5VdERpRTZNQXZQRFRsZnpRSEZUR2N6ZVQxQ2hMYnNSaTFoc3craUlI?=
 =?utf-8?B?dk43V2JQUzd5ODNLLy9CK2ZKSENkWlhwOTMrNXMvUHZZWlRmNk4rSm5jQmRF?=
 =?utf-8?B?NGpiMS9UUENoZFMvTGsvYmFKSjJlY3MzRU02TzNiTGZ2THgvcERCdTN3b09o?=
 =?utf-8?B?bHBneDJONWk3V2F6aHkvb21BaXo2aWljQUhzUldia0xqV3NKSTdTdHVkUXYr?=
 =?utf-8?B?a1Jua2ZGZ3liYXFWREI5aUJFaUxWY3hoVGFPUHJnNGhYWFUvTkF2VDZPUXc2?=
 =?utf-8?B?ZVROcm1qblVoWGIxb29lUTFscWs2cG92dDNwM0pvVnpsSTN2eVZqMjNqSjJj?=
 =?utf-8?B?U2FxdFIzbVJDYkNrOGw5ZlJOYTBQOFRXYkIvMmpyNEJmNTV5R0d4aWhaSlE3?=
 =?utf-8?B?Rm9WZEdTMnVuQkQ4MHVRUW9laDVBQXpLUUV2TWZvZmhBMUc3SHJtanJIK2tu?=
 =?utf-8?B?ZmxHQ2l4N1FrSmxmaVExRGljOGFlS05DVk5ydHpwTmt1SEkwdUdsSENZcXRP?=
 =?utf-8?B?eTVvODgwZmh2MHlZOGsvTllGTUlXTUpYQnlxdk1qS3NCT09zaUZoak45aTZm?=
 =?utf-8?B?T29GUE51akFtb2RJeVRKQzRkQ1JYZXFGRkM4Y3Z1RWVPTnZ2ekhYLzVLL0Z1?=
 =?utf-8?B?OHpOd3orSWgzektGM0dmMElON2JqamttdTBHM05EWnJKdlVDZ0thOVZITVNB?=
 =?utf-8?B?cTBTZnJwdkRDaTNuSjJoOUpiQzM3WWlLczNrY3dMNk8vckwvRTAxT0JaUEVi?=
 =?utf-8?B?ZGZmNW1JNnRnQTVGMU8rN29GYzFGTDVqSmpLc1FtQ1VsMTlaNWlhT1JTaUVw?=
 =?utf-8?B?bzgxNU9paXRJcHV2WStOaENtMEFNcTNOd2loOFVzcXowbm5FRlBOMlU0VEtn?=
 =?utf-8?B?N0RUeXhWMjYxNEszWTJGSDAxMmF3Y2lVRDFqa1JkcS9iVk80bEdPcFg1alg2?=
 =?utf-8?B?U2Y3NENYL0dPOTR1OEhVRVVLem50SjNxSUVkTEpWVjI5aUQ5SUR6LzZ0bTJn?=
 =?utf-8?B?cFBnRHR1ZHRRc3pOamJxTmNCRHlpRlBSNzBVbnk4K2Z4T29SVU1CYS81cDBt?=
 =?utf-8?B?UWlaVldSdFBhaXF1bkQ1UCtwQVF0aURidkx2UWRaRXEyeXlYZUNYK1hyZnNE?=
 =?utf-8?Q?qzPpfT9pEcc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTZHQWVFaGdtbkFIWFhJemlTREUwdFlSYnFUeWFKWldIT1RCQXBOY2RKLzVY?=
 =?utf-8?B?TnJaMEJOWnpibGFJVW0vejVvTW14Zm01VG05UDJBaVJ3V0ZvWjRjSXVFalB6?=
 =?utf-8?B?RFZRUGN5enN2OUtaYnErTlBHcS9oRU9RZy8wSFUvOUw1ay9ScUVWaktkMnZ0?=
 =?utf-8?B?eG1ld3F4OHl6N3NnbzF5WUxVOTEybzUyUU5QMUNKcnU4S3d3TmxCNEdaNENl?=
 =?utf-8?B?ZUs5SUxzM21CY0tuNmQ5Ym9vRkZuN2VobzRtYk1qbmFjVmp4Y0h0am9hOTF0?=
 =?utf-8?B?ZEd3Yi9FR3h1UXJSRm5yaTNvYThGV21MMlJiV1FOaUoyNyttanp0QTFnWG1k?=
 =?utf-8?B?SmdCZGRpdWY5cmQrUlpDMFV1amR1R3IvRGRTZDFVNXJrVjhTVjg5Vmwxc0Ux?=
 =?utf-8?B?S050UVhacDhOaU9zWTU3Ymp1QlRHdjJJM21uVy84ZHdoTmVGUWdhQ2JUSmg4?=
 =?utf-8?B?c1p4NzNsbkhLK05Kc0hiejBqbWRFSGZic3dDYmJzRDNDekJuQlQyM25nZXhk?=
 =?utf-8?B?ZkFQRzk5bDR1dmdSSlhobGhaQ3hGcnFUbzVNdUg3Vm93eG9tY1d2QlhUbndx?=
 =?utf-8?B?a3VDUzZ0bnpCK29SL1ZlUUFXNnBFSnlHYnJtUi9WQXBCZVYxd1FWajhBUE5h?=
 =?utf-8?B?VXFPRXR5N3RPVUJLMEhrcUd4V09DeXNYTk1SRkFWdkRsa0VzeHFpbkRrUkwz?=
 =?utf-8?B?TlNFb0RBalg1aHlrY2N1UjhjeStEZHhpZDdIdzFIRFd1TERzMEVtK0tFSnha?=
 =?utf-8?B?ZmVrTzJUMGRGUEpPY1ZUemNxa2FYTExwbDdLckxyU3RPOHZQaXBmdzYzaGJq?=
 =?utf-8?B?ZVhqQUtHMWI4NXF0TjQzRmFRVVRBY2xjNVB4RmI5d0FtNjlDNjdDZ3VjU2Ey?=
 =?utf-8?B?cTBFbm9LWGlQK2JlbHVsSmRkNjMrWXIyRjF5S29mQy9ZRkRGRnFyTmlEVmJE?=
 =?utf-8?B?QkE4QVhWYXRrdXVwU2NDR3JPRzBKbnpXWDl5REppVy9BbXJGOS9USm9udU9M?=
 =?utf-8?B?enV5NCtkY0JNNXlNc2djWThNTm1DbTFiQ0hhbnRZYnFScGs1bHh5cWkvbVN3?=
 =?utf-8?B?QzFFZVl2b1U0RVFXOUZDOHZNU2trdW5DanFUMERsVlNyVHBma25kNUl0bmNn?=
 =?utf-8?B?T3NXd1FZS3d3MjVTL05XeURGQW9WZzE4Q2JlWG9MekVlMlRMbzIrYkdQbkwv?=
 =?utf-8?B?VFMzYnV4REZnYk1BdzNSNnpkWk5FTWtGOWoyN0Eyd2hHNGc5RUNTSXpNZkNm?=
 =?utf-8?B?S3crNnBFSkFUVkU0eTcwQVhLVWJvVzR0R1FDL0tKZCtpczg4VGROa2VVYTFM?=
 =?utf-8?B?di8waHlFZUVhZk8xczZJdWxsemlZN1liZlRrbmUvUG83d1RBcHVVNDRieFB5?=
 =?utf-8?B?N0hJdktiaEZMYWVidlMxbk5EL0lGcTZlTlcwZnViQU8xZjVNRlBJNysvd0VR?=
 =?utf-8?B?bS9XSkFxL0N3bTc3WVdFTCtWMEcrTjBpV0sxdUdyR3cvc2R4Y2FCOFNpQ1ov?=
 =?utf-8?B?eVZDU0lkaHltTnlnUEVEbG13QjZFSHZtVHdCcVdwSHF1ckRrRi9rMjhUaU1R?=
 =?utf-8?B?eXNublpTYTRJYytwd0pUeXFReng5MXY3Q0M2aCtsb2hYMyt0YXFvQUsrc29r?=
 =?utf-8?B?L3RnOGpUME1WR0pBbjVFTC80Z1lEVVVVeVA1U2hiQ29ZcUE3K3RsMC9YNmg0?=
 =?utf-8?B?UlhMb1hjRHMwM3IxSDdVSVpFTjhFSWNpd0N6TDh1Q3lvTFcvQjllZkJiSXpK?=
 =?utf-8?B?Zk5YWWU4WnFtaVRRYk1tQ1RJM1l6S2x4aE03bVJhVVRmVlRCVDV4dkJlNld5?=
 =?utf-8?B?clEwaHJJSUdZdldiRHZ6UzRNUE1GU0N6VG9aSnZ0dStHT1hwU0o1b0ZFVzUy?=
 =?utf-8?B?b21lWmFwTEJyK0JzbnlRMUtBSDJFM3ZtbU5MTEs2UktmaUVlcHV5eDRZSHZM?=
 =?utf-8?B?L2xKSnQwcURRa1VkZ1hQb3AvY1E5NUh5UGd0cjhlZ3ZtMFMrYnBnRGdlUTFa?=
 =?utf-8?B?TVhHK3Z1aXZQV3lWTjMwTjVndWFxczQwZVpZMElYL0FwYTdCY0Z4cVcxeFlE?=
 =?utf-8?B?b09YVkJ3QklVekVRWjNjaGJKN1pZam0rUllDcFZuUFdxUzh3YkxzSVZ0VUtG?=
 =?utf-8?B?bGpjSHk0VW44REJPNUN2d0tGRVg0eG9vQzJ2RyswT0dpd3NidmMxMWpUN3pt?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jaaOx+0gAcBck45Gx3JF1syPZo2TqCp6asDOoZlr0vG4oPP9hlZQCUKsqtOGFUdnWHceCjG5hLRBcq6piqfFB/Miw5R5NmwlVrrGtJrv/GCYS/uAIsll6XvSURkm6JwpU8fhuuMlVbaSadEQsQxJpxuX8xluN94hWVGPuDSDhiXOn9LTi48O3o26Je/Zzs8sCv7CUvnqAvR90PPrxvAVe/l4WHRZsY+uCYCa5R3mPqCO7fD+W0IJF4WRJYeZVRoLSeRP6pxhVI+HjtkLJYNgIbciD0Uua7vlwbnQ/zhoSU9jXp9TuZ99JOS1BiuvBM2Wx2ZBNcQ2nKU8W1KrgIpAoAP69FAtQhJNu7eL2Hs2rnEnyej4YlcwJHu9ACJOh6TkMSYqDJJwF8bdZ8OTB8Wq8moFKrZRWxK1BgDyF/EggMASJ4KbP03ssjWQpZ4dXNAvc49eF2QDMuQf+NloJqsNF//nuHAY+E3wyJQh73XDjvMvwuZb61uT/+hFPgxSekA/ey2uF3jaLICWugVc0/eBqjVtYonh+sSbsPRbOIEvsHb68zKq+yIaUPhAC3Fydo7aADSUoA/By5Ye/GcrUypNyKe04HMLOozipl1+kBgezoM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efaae8b5-cdf2-44fa-0c5b-08dd3bfbde88
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 22:18:31.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17PGFVfnYhxwaQLnkATFgveSgjUcQRCyxwgpkmNQuRHCQE7K5F/PLMUiEefzCw3pxWtwZLL+osZtbzlPNj0Phg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8111
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_09,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=982 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501230161
X-Proofpoint-ORIG-GUID: oIDYjshP3BwdmXEYRtuZIpDw_Jrg4Epu
X-Proofpoint-GUID: oIDYjshP3BwdmXEYRtuZIpDw_Jrg4Epu

On 1/23/25 3:25 PM, Jeff Layton wrote:
> RFC8881, 15.1.1.3 says this about NFS4ERR_DELAY:
> 
> "For any of a number of reasons, the replier could not process this
>   operation in what was deemed a reasonable time. The client should wait
>   and then try the request with a new slot and sequence value."

A little farther down, Section 15.1.1.3 says this:

"If NFS4ERR_DELAY is returned on a SEQUENCE operation, the request is
  retried in full with the SEQUENCE operation containing the same slot
  and sequence values."

And:

"If NFS4ERR_DELAY is returned on an operation other than the first in
  the request, the request when retried MUST contain a SEQUENCE operation
  that is different than the original one, with either the slot ID or the
  sequence value different from that in the original request."

My impression is that the slot needs to be held and used again only if
the server responded with NFS4ERR_DELAY on the SEQUENCE operation. If
the NFS4ERR_DELAY was the status of the 2nd or later operation in the
COMPOUND, then yes, a different slot, or the same slot with a bumped
sequence number, must be used.

The current code in nfsd4_cb_sequence_done() appears to be correct in
this regard.


> This is CB_SEQUENCE, but I believe the same rule applies. Release the
> slot before submitting the delayed RPC.
> 
> Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/nfsd/nfs4callback.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index bfc9de1fcb67b4f05ed2f7a28038cd8290809c17..c26ccb9485b95499fc908833a384d741e966a8db 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1392,6 +1392,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>   		goto need_restart;
>   	case -NFS4ERR_DELAY:
>   		cb->cb_seq_status = 1;
> +		nfsd41_cb_release_slot(cb);
>   		if (!rpc_restart_call(task))
>   			goto out;
>   
> 


-- 
Chuck Lever

