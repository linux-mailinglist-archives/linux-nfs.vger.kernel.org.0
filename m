Return-Path: <linux-nfs+bounces-2563-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AAC892315
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Mar 2024 18:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9094285A8F
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Mar 2024 17:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DEC13342F;
	Fri, 29 Mar 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TLk84Dyf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L5HpyKGw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980AE139D0E
	for <linux-nfs@vger.kernel.org>; Fri, 29 Mar 2024 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735060; cv=fail; b=FT2wcjz+w2LxUtDsmgLuPu8Wcu5coTXWAGa59lN/zbI6T2A7HduYPuPBviILkhPSDWBDGwIv9Zsx7ApzcHdJe3k2g1U19PRd1mnBn/7BO/7wCU3pApviu2Pit3FrwJacrLbx+dpQeEQ/+UIU4YLskAueTQsndg2PTQDMqJ0gXi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735060; c=relaxed/simple;
	bh=xD0cCALc7KV+YLbPG0t4Wt5XT6Bs3B3ptpwb3JL0yHk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OwNayo/jpuvTQFZmSreUSXu0odt/ku2RkNYVl+QKRqlY0js7eDcv+pF3f9nUqc6/UZNOf10q0kXr5XgQ57piriDa4ilJALhGK8Zua7qKUq51067CrQ/PHej0UaWrdGA5gU74ChHy3tGOGM5qyPq3p9LLGfp1pL5wRgZGHqukWoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TLk84Dyf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L5HpyKGw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42TFNrAU016570;
	Fri, 29 Mar 2024 17:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=k+rBTy8sB0LFs+EbqUTcWVXMRaJDIbBu4ndqwLBh+KM=;
 b=TLk84Dyfx0Dc+EC2FZlhlZZChsf9HMsFQRD1YRgt+Uq4YRRjtM0ZPoL+68wLMpCVlyBX
 MfDdqePC8sU1WFRij34o04XmSb1vstYJdVvxd8rKcwkTEjy/xT0q/zaGz0XVqMr1K1+c
 Q0H4BDkCqllFj75s3YfNBH3L0Df/hFPZeUWsz+uc0vZEmh/A+TfSkyElx9ML5lEmxvH8
 knLYYu9Gz1ya8dWty22flUfjB/WaXhDNKqQLOveTY/DjBNoF4LZqTNKx8P5eAc5gxMQA
 xCtp1Jbmajf6lE74+XtkFcC+Qh0uK6P+a0aNmZ08X4X21eHtOzr8YyHSvNskQoyHOCiY 5w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1pybv0hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 17:57:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42TH0430018186;
	Fri, 29 Mar 2024 17:57:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhbrm5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 17:57:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CE5cqc2p8ZlCBchGGjX276plvxj+6VQTBRxBxC6SxNwVyghyFZLTgXtlO20GitBmPJFKYqqRslHcDKmj/xwM7mrPaApeNd9xRKUJVDJQjaZU+Jr5ubmEmMtTD0gY8svBtTz5Q1WkSTmQOTUkSNFi1G33ac2sZeuu/sZBL4fREt61xjAzTDL76cii3yp6cXJex9Nz/2G1zRWsu7g5cblxv/VBStR9MqhuUyzz2qw1xq/+BQ+xoyESD/AYdu5c4qnsyWF8znSgtVRlqCRgvu6KTrc39WfQ6x5UeRXCwk1GMGieeWo/BnFZG+kPbTZkvl76R05ARV1Dp16RF70ixhuLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+rBTy8sB0LFs+EbqUTcWVXMRaJDIbBu4ndqwLBh+KM=;
 b=dAzUy6hX4cTy3R3SGtP/QnzDFrGykYpTnm9TNQpccoE3rGdPsQZQ7G8fVqBUPZAIop69CpgUDVDjt0G6NpeRM+Swp2Iek8v+7Mm48GGeue1X+JHg6kdyRis5WkP542lBxe5+427k/hBSZNnFzU9zKOBKrE60wuU8ad5suOh4Tn/RNJLUaybnPHhqnQpWZW711DUjDgRPobvgWtUfiGaARztgpmbctQ3jkplYbtU87+3sqWJBQ3LybbKjZtLfd10THKjzOfCeRBwhZN1tsuO9PgZszQBvwZH6x9749MPTL91QongWQ63dhyPzhsc9F59s8os8FhCHWCyHJgXT2d7/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+rBTy8sB0LFs+EbqUTcWVXMRaJDIbBu4ndqwLBh+KM=;
 b=L5HpyKGwpoBzJiKHGVBDGkloeJM68vYEJTLtbZQNveT4RRMcjiXssP4zJSf13WTvmvJ4wxkTuUB2RISuByLq2+IxcTL1puTdc/CaZ2S3w68vezxB6VzzGJeuRYKD9g1nvcU6tIpgWKuVMdbzoNROQhwkn1aLWJrKdRs/b48Z2tA=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MW4PR10MB6512.namprd10.prod.outlook.com (2603:10b6:303:22d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 17:57:26 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 17:57:26 +0000
Message-ID: <97387ec5-bcb4-4c5e-81af-a0038f7fc311@oracle.com>
Date: Fri, 29 Mar 2024 10:57:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <1711476809-26248-1-git-send-email-dai.ngo@oracle.com>
 <ZgMToHNkkGEHNb/y@tissot.1015granger.net>
 <69914825-e9d5-4859-a5a8-60d17e8e8bf6@oracle.com>
 <ZgV5zwR0q/vjBAtI@tissot.1015granger.net>
 <88fac8af-c194-452b-94eb-7658b9056246@oracle.com>
 <c97be8b9-c0ba-4f2d-9340-78368008ba4b@oracle.com>
 <ZgbWevtNp8Vust4A@tissot.1015granger.net>
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ZgbWevtNp8Vust4A@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR20CA0010.namprd20.prod.outlook.com
 (2603:10b6:510:23c::7) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MW4PR10MB6512:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TOQURC0VS09l3yCymy+b1Mw05XKrRDIItAVIMA19rjKcqbx536l1p9KbN9EFpws0/YcqBrVcsmMc2CLqn+phh2SK203ChIV1/xFbhF46glpvvr+QuYqMvvWFycoNBLsSYY70L3c2P9l3OFr3c0WmD+gvv1bFzZYyrV1Yk0L4ozD41xmL9TaC3hKvhOEt8jhz2m/+DXNEaCOkVZlQEQImeuBkkeFHWmGxQU/iopw1WZy4/v9CJChkZQGljiSUAcNb0o+FwM0UDAuXrZygCtZtp9HANIZXsnpXvf0DEKTiINazfmkQbZCP/NPHE858TcVxytVp4/ITPIB01xDhsn5HFQ0pDwTG70x2Yjxcu3B0YEFLtwQIOrNgy/RTsiNZ13jx4bWprTQ0T/Umv/B+1/+CNy4fI/ciUdGYsKXK29GPc7hK4SRyZA2p6+A5Z0UA37KKIvY/JHIHToM7R1bGYh4dv9FxT2859JxO1xrDTeNEFdepAJdfjJ/6uMKjPOU+Qd1PJNgmt/3bGcrS2qdm7LK4DrPamoG6/2/V2y/erAPyK9ixrPiIyrweC3XpomsWW4HLuOtGsyIAGQ1EEsWrVSvKgkD816A8HqvlVujk6JW3cx0TFQYytf6squ3w6tStAVCxxdmzrXgcYdijI9mAlDXez/u36vb45bAyZSdkhnoLbPw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SkV6MDZVWVZSaVdrU0pvWlBwUEc5bXcvL1dNODRudDJYREREa3hlTWUzVVlm?=
 =?utf-8?B?cEdqNjdicThGaGQrUzE3MzBMVVFSelJ1d2J2ZHFod1g3K3VUT25LVjd0NU5M?=
 =?utf-8?B?T1FXblZHcVQxUzNnN1l2VXV0aDhVOHA2N0hEUENKdlEzN3NZemJhNUQ1VXFK?=
 =?utf-8?B?TDBJT2VQTGNvQTIyV245bjJ0OFMwUFNjd3JiOER5UCtVbXk1aG1WR1BacXQ1?=
 =?utf-8?B?ejAzV1NJU2tBWEpUYzFkN0F4SGQ4R1VvZWRsWXNWV0dsclE1WnlaYmhXTklK?=
 =?utf-8?B?M1hTUjFqcDFSSGNMNXdnOU9wV3R3L0ZjMzFPdGRXbnVRN2xSWDdFTVJNVnRM?=
 =?utf-8?B?ZitoVS9acHlDSWF3WWJEQ1pHSWhyN0lJcUEzbGJLc1ZBc25wNk9sMTYwNlNY?=
 =?utf-8?B?TS9EQW5SK25tSU0xZmUxN05uUEdYR2JNeUNZS1N5ZXhBRlRCNThVV1ZXckNV?=
 =?utf-8?B?RytUWU5ENnVON2tNWmlUM1NnQUxhM2c4bEkydDVwUjJCNGEwRXNiN0tqV1lE?=
 =?utf-8?B?eVowcEdzNXAwU1JmLy9jd0Y3ZUdWT1RsY01VdjF2N3VyblVqMDNxYUNERVp3?=
 =?utf-8?B?UCsvcnVPUmowTDJJdE1paVp5YlY2QWcvaUZKY2Z2c202NFU1MWhPZkVBNWNh?=
 =?utf-8?B?d01RZnpIblBBS0xMOExqVmNsSTZDOHhYTFZCN1lONHdhZmdsQlY5Y3gyQ251?=
 =?utf-8?B?NlFhcVZaZmxuaFM2emJIbDM1UGJTV0pPcWQ4dE5qSFlidFc4Zy8wbkRZZXNv?=
 =?utf-8?B?QUpnTDNNdjF1T2hDMktrQ2VyOXA5YXFBbi90M1BKaUpkSlFBemMrRG03TVN0?=
 =?utf-8?B?L3cydi8rb09MV29NZ3RvUlBxNlM2d2o4V3hocEJBaGpwenBuMHBxQmxmS0dK?=
 =?utf-8?B?Z0gvM1Q2UWNCdXo0bVBXc3BQR0VMSElHQmFZRUhCVnY3QW4vWkoxY3BMTDZH?=
 =?utf-8?B?bHNzenZsUHZBT3lJVThIaTBJNmsxTnRadlZ6MWhZdEZNcGthdDV0bnFtQ2NJ?=
 =?utf-8?B?bUlpSnZPQUdSTFFMWWxvUDMveXZHSE0vV3RPV1N0NTNqYWhkUmZuOXo1Y1BP?=
 =?utf-8?B?ZWx5anBXdUkwZ2VzK3hmbUVSVDZQME1xVUlNL04rb0lVSHZGazdCRjhpM1l6?=
 =?utf-8?B?cW5xUnNPVVhRakQzR1kzbUhvNjRVWjQyV0FhbDBwVncvbzhXaERrTUEzQWtq?=
 =?utf-8?B?WEtGR2RROE9aTjRlZ1k5THpGak0wcmdsVnNJMWFiQmdkTmlERzdQSjBmekxi?=
 =?utf-8?B?SzdZejE5ZDZzTG5ZUDFpKzc0OGw0WUQ1dGxiK1NtTGozMC9wV2xlUGJ4Vy9m?=
 =?utf-8?B?bTh4d0NKUi9hYk1FTk1mN0V6Wmg4OHFCaitDRHpnYVV4MUgyL2ZtSzRETVVt?=
 =?utf-8?B?M3pkdFhsWnRBTUcvenIwUExLaElCMTFsZFhhVjNNeUZxeU8reU9ad05wS1hD?=
 =?utf-8?B?Nlc4anhjYWlVUW40U1M3djh2UXBOVGovOC95RStlOTFXOStudGlQUlhqMlRH?=
 =?utf-8?B?dTQ5WkVJWC9QQURVb2MzUzh4MExjUVZ1K0hSNnQ2UnZnNWJFMGtJSWdMNGZ0?=
 =?utf-8?B?ME4wOFZRa0lmTkY3OWdpWm9GcmJlR2JkS1VUZFFSWDQzcmNFbElhM0JyK1hZ?=
 =?utf-8?B?WW05dW44NHBFMGN4aDdSZHdnSjlWeE9UZTUxOGxrVWJ1S0F4VFAvLzVHNldF?=
 =?utf-8?B?Y2EvNHlyZG5abkxweG4zbjFPTm1MallkMGNIdVNqWUlNL2E3eFR6dE9zV0JR?=
 =?utf-8?B?ZnVvYUYzTGNxVmxDVzFNbGwyVHpBVzM3YlppOFM0MUVMOTdLQ1RYaFdhSG5N?=
 =?utf-8?B?Rit2RS9Dc3FVOVhVMmxrTlNRa1V0QTJJK2Jvb1RneTJiMVJZUGx5aHBLOWJ6?=
 =?utf-8?B?MFZydWRCRThRVkJLZUZSNERTR0lhaG1tMEp0TTlYbCtaTzJoNmk5SFpLRWlv?=
 =?utf-8?B?RklLaDQ3VmJlajF5Q0hhaUtFSW1TdHY0MnhOTU5BUWlkTkw0MUlmZ0RhWUs4?=
 =?utf-8?B?bVZyUEcxRm0xVGR2Y2NYMUg5d25Jd01KblJmRXJ6QktNNEM4SjBLem84bnZW?=
 =?utf-8?B?OVdaNXRYQmQxaCtWMDI4VWk2SG4vWEJPUHN3c2pJb3p0WVVZOFNhc2NuQkVD?=
 =?utf-8?Q?QmOy27iE42CwcFgwdktutTXs+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dYpblD9KeE8kkfPABLkYSMuJwuKZkUM349I+UVjs0M8+XLUKJLoPqrK5EwZnoEv7FhyLrp3z2nt72w9lZ0wJQ6PpVpEtV/t2o59ltI8Jq0VbpMqx+8rorVncZjEAHpw+28N3aOA7L+uCRWcDBFPr8w2IcXcQHlKP2n7G3+6lpjrksuosqTIdX5vcvbdjoAWyOLu/bRkrCKYv3pGJGCakLVRLBYyDO83QKm8qfLW3/BmLJUd8RSmbbaJU8TH8Xb8MU513AD8UJvu2344Rr3iOAmyUYtr/7yP9rIei4G8IBeeY77sRC4n+nbMfwO4HlZd/JEedgw6i/nacZHUOh7lsWQEJzdJBC5vZAL+nppbfUQ0aHsbhJFIT61dk76sPlofUS3gfsfXppCB+fTzJJv3wr5ohc2i3adgrrpMBFZEFTQzhmJhb0Vvnd4iOnSDN5xmXS6Q9s0lclxbw4TzSLyglvJI8r3P6qK5sJRkPqSJGTk40OhPuJAJRT6GhHeWcN4y8dIskKmAzLXGA8F/2qq80XOIX6LEFM5biDxzosWoOiOItIb4aBj/17HkbogmE1aPGcRAT+I0HSHgSOJH3xXCSRqx2T1L33mPBnbC81vG+FEU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72805a83-3a8b-4583-6a1f-08dc5019b13f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 17:57:25.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYdQUYFu9ZR6LpDMyjrMapsMz7998c4MMPlFB26B2LEBLUL3ctZeAcJtJjyeWLu1F7UsVl658/7Ny+Wt0C2+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6512
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403290159
X-Proofpoint-GUID: gXFdMjYi3yOjQxjPhNYKArFirSH-qqs8
X-Proofpoint-ORIG-GUID: gXFdMjYi3yOjQxjPhNYKArFirSH-qqs8


On 3/29/24 7:55 AM, Chuck Lever wrote:
> On Thu, Mar 28, 2024 at 05:31:02PM -0700, Dai Ngo wrote:
>> On 3/28/24 11:14 AM, Dai Ngo wrote:
>>> On 3/28/24 7:08 AM, Chuck Lever wrote:
>>>> On Wed, Mar 27, 2024 at 06:09:28PM -0700, Dai Ngo wrote:
>>>>> On 3/26/24 11:27 AM, Chuck Lever wrote:
>>>>>> On Tue, Mar 26, 2024 at 11:13:29AM -0700, Dai Ngo wrote:
>>>>>>> Currently when a nfs4_client is destroyed we wait for
>>>>>>> the cb_recall_any
>>>>>>> callback to complete before proceed. This adds
>>>>>>> unnecessary delay to the
>>>>>>> __destroy_client call if there is problem communicating
>>>>>>> with the client.
>>>>>> By "unnecessary delay" do you mean only the seven-second RPC
>>>>>> retransmit timeout, or is there something else?
>>>>> when the client network interface is down, the RPC task takes ~9s to
>>>>> send the callback, waits for the reply and gets ETIMEDOUT. This process
>>>>> repeats in a loop with the same RPC task before being stopped by
>>>>> rpc_shutdown_client after client lease expires.
>>>> I'll have to review this code again, but rpc_shutdown_client
>>>> should cause these RPCs to terminate immediately and safely. Can't
>>>> we use that?
>>> rpc_shutdown_client works, it terminated the RPC call to stop the loop.
>>>
>>>>
>>>>> It takes a total of about 1m20s before the CB_RECALL is terminated.
>>>>> For CB_RECALL_ANY and CB_OFFLOAD, this process gets in to a infinite
>>>>> loop since there is no delegation conflict and the client is allowed
>>>>> to stay in courtesy state.
>>>>>
>>>>> The loop happens because in nfsd4_cb_sequence_done if cb_seq_status
>>>>> is 1 (an RPC Reply was never received) it calls nfsd4_mark_cb_fault
>>>>> to set the NFSD4_CB_FAULT bit. It then sets cb_need_restart to true.
>>>>> When nfsd4_cb_release is called, it checks cb_need_restart bit and
>>>>> re-queues the work again.
>>>> Something in the sequence_done path should check if the server is
>>>> tearing down this callback connection. If it doesn't, that is a bug
>>>> IMO.
>> TCP terminated the connection after retrying for 16 minutes and
>> notified the RPC layer which deleted the nfsd4_conn.
> The server should have closed this connection already.

Since there is no delegation conflict, the client remains in courtesy
state.

>   Is it stuck
> waiting for the client to respond to a FIN or something?

No, in this case since the client network interface was down server
TCP did not even receive ACK for the transmit so the server TCP
kept retrying.

>
>
>> But when nfsd4_run_cb_work ran again, it got into the infinite
>> loop caused by:
>>       /*
>>        * XXX: Ideally, we could wait for the client to
>>        *      reconnect, but I haven't figured out how
>>        *      to do that yet.
>>        */
>>        nfsd4_queue_cb_delayed(cb, 25);
>>
>> which was introduced by c1ccfcf1a9bf. Note that I'm using 6.9-rc1.
> The whole paragraph is:
>
> 1503         clnt = clp->cl_cb_client;
> 1504         if (!clnt) {
> 1505                 if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
> 1506                         nfsd41_destroy_cb(cb);
> 1507                 else {
> 1508                         /*
> 1509                          * XXX: Ideally, we could wait for the client to
> 1510                          *      reconnect, but I haven't figured out how
> 1511                          *      to do that yet.
> 1512                          */
> 1513                         nfsd4_queue_cb_delayed(cb, 25);
> 1514                 }
> 1515                 return;
> 1516         }
>
> When there's no rpc_clnt and CB_KILL is set, the callback
> operation should be destroyed immediately. CB_KILL is set by
> nfsd4_shutdown_callback. It's only caller is
> __destroy_client().
>
> Why isn't NFSD4_CLIENT_CB_KILL set?

Since __destroy_client was not called, for the reason mentioned above,
nfsd4_shutdown_callback was not called so NFSD4_CLIENT_CB_KILL was not
set.

Since the nfsd callback_wq was created with alloc_ordered_workqueue,
once this loop happens the nfsd callback_wq is stuck since this workqueue
executes at most one work item at any given time.

This means that if a nfs client is shutdown and the server is in this
state then all other clients are effected; all callbacks to other
clients are stuck in the workqueue. And if a callback for a client is
stuck in the workqueue then that client can not unmount its shares.

This is the symptom that was reported recently on this list. I think
the nfsd callback_wq should be created as a normal workqueue that allows
multiple work items to be executed at the same time so a problem with
one client does not effect other clients.

-Dai

>
>

