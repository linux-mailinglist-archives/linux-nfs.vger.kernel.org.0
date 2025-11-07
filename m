Return-Path: <linux-nfs+bounces-16172-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DE4C406AD
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 15:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF03E3AEF3B
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054E12BD5B9;
	Fri,  7 Nov 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eSlfW22S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fNAw+TNa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1519CCF7
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526914; cv=fail; b=MdTuXHYCcjE40rLiqefsVDMNCJlzR1M7V5Px+1XLruOvsJ/V+rrVCmktI+EOe9VjAAzqO2vpt2a3L1b28jtHYuY6ZBuQ55/9NircCESWgSIE/3+WyP0v4vyYno4gX4jktZm6U5/2ZVrA/31qlUH20reGthOE+o6eCZDxhe6Xw54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526914; c=relaxed/simple;
	bh=O7NGfpELsrFVQs8j3XU6EQTtV0Z/Ckm5KMEMImgzzbE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d6+kBdlYSR/rzkN93NCCsdvAg8Wy1sli676W0adSr2YtnbGl51ChJmb8rWrGj6pCWxdvhSNh60PfrAFVG3jgl2Tue5mzgulxGrumWClfMw+kRp8jqj942J9smOzgWlQCAQ//RjpZBiD6R4qcJIbUuZ3/EY+Zx7WBmWnkm3tHLMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eSlfW22S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fNAw+TNa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7EJUIm031871;
	Fri, 7 Nov 2025 14:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+IG28YeOXtlqr8j5VWV1M95e/s48wfRTUWdjnT5M0nA=; b=
	eSlfW22SsjLkgzlzOG0bnwNt2WYIQXU0ktXVO/B0tHH0r6j3HRx9wgUNxRlHJs1J
	d8XSED2NYQ063XjuaXOH4HClaffuPSziFUUgvh+8KhL/dojjTkqV1lLDzz5frcng
	Qo9M2KWtPrmGmSToBY0yKBhiYzEbd8BYLZRqBP5ZSxPUUtJOlu5jsxcapksSmAJX
	h2A5BVh1mKGgT9v9InCObGzN6hr/bMict6KJXjW8WnsHdomh7sut45dI5FK0xPV7
	sxslZwMY2QXwDAZLGXETQh+p+oU07BFBicGDNIPEXPYsPQl3z3BQdRWflT+lGsHr
	ZhAG6ePuGQD0cHx5zJ9/lQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9je90253-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 14:48:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7Dcwva010914;
	Fri, 7 Nov 2025 14:48:28 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nduxtp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 14:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlFANo4dB6uFAH5dUKxkKDkkxw7RoL9xDHmPFnl67QY5WI+gxz3nqJZy5QnhRCYicNQ3rY/3KGMfDxXCmnCtCziYk1UnYuxd+j++33hrRxS9l0JgTvVViaZkrSia2Jxum7/3FnjIm4E7ibgemJPKiQdbKJS3B5a/gh4XwNGgej9ehX44kqfmBiosxYVKNCPoDmJX/BFY1LeV3+OTT+2+62FtTfXohH/0lO08oELUKXD9oUPV6/IrL1H2pnjtgRpnm5VcOmYlmVVgJFy/4HTis5qAHEshzFxMmyT0IXs8flaDavPj+eZb87guJDuHdeLzvtv50rker68l+Zd7FoXKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IG28YeOXtlqr8j5VWV1M95e/s48wfRTUWdjnT5M0nA=;
 b=FpDR9JC156Empx8RhJqODcoD8tr+tjefFRfYQa6i2yO6M1OvfGlfnqM++GrZN/sXXMeMhRPXpxp6rzh29f/ndbWkz4RbDDeWHT9Q0RNVPKIL6JsZKVODMfl/+x02YpK3tmXxB44MMZmqA6FVMTliefvS6NDeoNanAzgOwgS1bzdJOx7+Y2D7jEQxVz1qiT1XEYBDdM+UYK2+U5nhv5wMKa+1FfJjUQrntN6HWdsX8FWszWdu6fQSDCdUZ9m2A1g0Ru0y9z1nEUECLi3MpF6PoSsBpUf7yNNnehDGaEN9mmueLtsJb7mXUusEKfwjBegeL345IKanAHsgBrWzdiQK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IG28YeOXtlqr8j5VWV1M95e/s48wfRTUWdjnT5M0nA=;
 b=fNAw+TNa0rDo12skmefKqq2y3kglpxL+V7FqTAsqLWbo3BVdBPuadHV7vBavHpblV77ZCvSmvYWhSMj48KQTQqjzyixnoQIvpR8tEUty+S17Z53DitIvUretHKOqN3E/yq0hneP/ZvzimuJftr9efj01/PllSbjjErbC/4PlMUE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6860.namprd10.prod.outlook.com (2603:10b6:610:14d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Fri, 7 Nov
 2025 14:48:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 14:48:08 +0000
Message-ID: <99dd427d-a16e-4494-a4b1-ff65488181ee@oracle.com>
Date: Fri, 7 Nov 2025 09:48:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] NFSD: add new NFSD_IO_DIRECT variants that may
 override stable_how
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20251105174210.54023-1-snitzer@kernel.org>
 <20251105174210.54023-3-snitzer@kernel.org>
 <c1f4d144-826e-4c27-821c-47652a7b67d2@oracle.com>
 <aQ0CUPcYYg6-5IJ1@kernel.org>
 <7d9bcc0c-d997-4fb9-aa0c-831b8f08a9b0@oracle.com>
 <aQ0noN473a-QFqpz@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aQ0noN473a-QFqpz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:610:cd::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: c38eb4e8-2c10-431d-52ef-08de1e0caa6e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NVNETXJGMVhzQWFubmR4OVJEdE1QWDZpSUJ0YVBWUG02WGNQaWVSM00rSWpL?=
 =?utf-8?B?TmpVcTZJR2FjZ0dDR3NXR3FiVW9QWDNuMnFZQzZjMEZlUkR4eHl6QW9Pc2k0?=
 =?utf-8?B?U0JGVTBlQXFOb25wS3FoeWYvRnFyNUFXaUxrNTkvQmJlQUJrcFQxeTFZem9j?=
 =?utf-8?B?VjB0RHZndWZ6MXkrK3JzditPWFh2UlFiNWZIdjUrSzVTZGNIczJsTUpIVVpO?=
 =?utf-8?B?aVpmTFpQdnVNSG95L1ZXd3pXdy9QNTRhNWptOXp2T2pmWlpCVnlTV0pOeUI2?=
 =?utf-8?B?TnZMb0ZUQnhhaDRnQnJBZXlKMmlSVUp5NXljbDlrZXg2ZlBqSHg3RVgvRmpC?=
 =?utf-8?B?aHp0czQ3Q28zRHNPU21FdjZFZFBVUmhWWUlYWm5IUjV1VGZxeVI5aE1qTGdj?=
 =?utf-8?B?MlB5dUVNS1UrUUY5dXdPUzIyS29kbTNnR1kzMml3QVNBY1JWSzhqd3cyb3J0?=
 =?utf-8?B?SStXWG56OHRwZTNOeldLTVFVRTU1Y09IL1R6cGdDNHlvSDBUZXZTNmNOa2hh?=
 =?utf-8?B?QmpBTjhJUE1qSUJ1eDJZdEwxbzNpZ3U4N0lqcUd4MXNMRHptbUJBSEw5RXIv?=
 =?utf-8?B?QURGbGRwWVFtNWhWNWdUSzFnTFNxRlZPbkJaOWFOWGQrV3RrWEhIVEJibkU0?=
 =?utf-8?B?L3dkbFhDR0lGRlhKdEZSWFVtS2dkeEh2dTlwVGxGaFFHbnlmUDVySlZCSWdR?=
 =?utf-8?B?N1RSRVlJR0RxN3JmbU8ycUV5KzZJUm1rdUM0d1VTVDBMUS9HYUZxWEZVWHo5?=
 =?utf-8?B?eXlqcU5HN2wyay95SWE3RTI5YkQ3ZEl3NW1BRkVKU3gwM3UxbGRLcGRPa05U?=
 =?utf-8?B?OHoxSFN6RTMwMTVPTGhVYjNOOWhzKzRJS3JXM2d0NGo4MFVRbFRxN1dERVdU?=
 =?utf-8?B?Wk1oRit4MzV3RUpCQmdxL3hMdXE2ZEhBT09BSkQ3K3MwbVJwZlFrOFFCK0h6?=
 =?utf-8?B?dlE5Z1pzUGVvWUZ0ekVURGE0cUNzU1RQUERiQXQ0U1lVcmoyNzVsVFRyOGMv?=
 =?utf-8?B?Yk13Mmc2dGJlcUl4RVl2ZVp3U0pZeTB1VU5lTXhObVpXT05XMVdONXY1R0du?=
 =?utf-8?B?TFJuaGxHTkRORnczc0VyRmV6S3QySzRSQ2lXV2NkZmVVQWJuWG9uZ0ZmQWxG?=
 =?utf-8?B?dHQ0R1NYMDRISGQ2Tlg3MGQxaGROSnkzNzhVRW5rTGZrbmRxNlJzTUkvaDh1?=
 =?utf-8?B?S3Q2NlFHWThQSEMya0pMTHdnQnFyRnpqMWQyekVqRDliRnp2RVJCKzhSU0ZC?=
 =?utf-8?B?ekNaU1pJV0hxTHdaN2NvVzgyU0NaRkVtZVhKUlFsS3ZESldWeTNGbHkvYzRn?=
 =?utf-8?B?UDQyN2dDdTBDeVZNVVdlMXR4cWZ1d3ZTT0RhVytLYWs1VFN3NXdSMkNMcHNo?=
 =?utf-8?B?Y0ZTM3lyaU1Xbko2U0N0UmxwMmxUcU92TlZkS0ZOY2d6T0pZZW5mQWlscHhU?=
 =?utf-8?B?eEhCckY0Rk15Q2Q4d21GWlZidTFWa1VQMTV3WkRsNE44VzlWa0Q3aTVuNmtU?=
 =?utf-8?B?cXFpT3VXM0ZsaktoNFptS0pLUGJWTy92L1RlZUNyLzlTcktEZC91RGVhQ3Na?=
 =?utf-8?B?SG95TzJnMlJKbVJxTFpDdTRieEpJV0NQanN5ak1pNk90OXNGbTJXN21zUXRj?=
 =?utf-8?B?Uy9zY0s3dlhpcXhxMWVSZENpb1J1T0lmUkRFZzNLeHhIWUNid01OS1JBZld2?=
 =?utf-8?B?TUxpd282M3BGbVp5WmtTcVhCa2R2QmRUNGJHTVZwa21tT2FuTHRTVDNSSERB?=
 =?utf-8?B?LzdzQWgydXhEdnZNcUphS2dIQjV5eEtqZk5xSllRQ2hWdUZMbzl2am9aUnU1?=
 =?utf-8?B?T0RFM0tiOVNWbmtXR01xczhabFdtUllEcU13ZDB3R3dWKzQ2QUlGdXhaanNz?=
 =?utf-8?B?RjlSK2RwYzJ3ajdkM1RJd3RMa05ubzBsZWxIUVRYTzgvazNXRGNpallKVWNt?=
 =?utf-8?Q?cfxW2N+JVhuW7Xw6uGU0I2TITp6wIeoM?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?clQ0djlmTHZBOHNoWjhKbkloRWRsZ3B4c3A2S2t4alFrWVZieDY3dGU2QlYw?=
 =?utf-8?B?eDIrUm1EZE5BaFVyN3VKZWxSNVlyS0dXbkl0RFhhK0dudFVQd3JiRVlEb3k3?=
 =?utf-8?B?SXNkT0g1MkVCVjFJemNFSXUxMytzZnRQTnJQV01iTTRvNXpwTFI2SW9QWmRM?=
 =?utf-8?B?WElkTWJaWEptcmhrUFJ2REJZQkozZC91cE9NTjFIWGFDRWQyU09sellhTWVI?=
 =?utf-8?B?c1dDYVJZbG5XZWZnNlJoQ0dyNDhCRTVPRVl6VG11Smt2SEpCd1UxUUNaRTdW?=
 =?utf-8?B?K0p0SW9EV0ZSakxvaWRvSWViYzV2MzFtMHFpK0JqRTI0L05RT21UYUlGVzcy?=
 =?utf-8?B?bEdZV2tpQWdwTGVpUk8relRLRWUwQkd0WjYycmtvTFBwaUNjejZ5TzRuakpn?=
 =?utf-8?B?UE1BZ3kwK0VneFZWdW52ZXRJWERvN01DOGkwZUxTRTJ4TlIxZmxQU000M1Nj?=
 =?utf-8?B?cG1MSEFZSmsrdXBxK1NmeEZrTkp0V0pLSkRmTExWVGRjNFphRlVzZ2NsQlVD?=
 =?utf-8?B?TDRFUDl1Znc1c0RyWVprUzlPaWllNWlWTzlzVk1VQlpvaXRJbnptYXp2NTVT?=
 =?utf-8?B?NVlFMmZWN0Q0Q1grakgvQUVod0ZwdzdFR2RYUEdaMWRXRWNaS1FqZDc0L0dI?=
 =?utf-8?B?K3NZblFvUVJmMlBQMWJjbzVSQVJXaUFrbHhZeE80SmlMMldTQWFyK0M3Zy8z?=
 =?utf-8?B?enY1dXNHbk9nNEFuMTlzWG85UDB3MzFoK0JlZTJRYTkzOVhSakVrYU5GckZY?=
 =?utf-8?B?L3RDeXJ4RFVSL0x2U2dTRnByNEFIVWhGbUJ2S1ZaWFovaEZ1T21iVUJLZG8y?=
 =?utf-8?B?Rm00ZE9xa2RoU3BPSXRONnQwWHNwK1ovbEJsT3RBS2c4Zml4TVdCT0poYlgx?=
 =?utf-8?B?ZnFXcjhuOUJpVFJkWDZZeVlST1dWOXBZYkVZRWtaRHhnVWl1ZnkrV3ViUG5O?=
 =?utf-8?B?UVZ6aHFHOFM1cnpWZ3FNRldxZ3FIcGlPWnlDWTR5d0Q3dlJ5ak1FWDFNUEJl?=
 =?utf-8?B?M3dUR2dYT3ZpVm1Gd3dDYW91SFJRYVpXMDA2S1JabWdEU0hSc1J4OW1DMCt1?=
 =?utf-8?B?Mnc4d2dQRWEyelF0MS9CdUxYM3VDUmhKL1YwWWlMSUxFSU9mbndXMC9JaHBQ?=
 =?utf-8?B?QXgxMHZtVEFiT2x5bUxrclBQSHBJSWZCVldrN05rdnIrUkRxYmEyeFRnbXVw?=
 =?utf-8?B?cXR2M2l4M0U3cG9aU2FXb1NBSUhUOHNVN0c4QjNjQ3l2ZnN4OURVbFVZTkZU?=
 =?utf-8?B?U3piNCtFR1JnSVlvdDFZR1pwL2RkZEdONFN6b3NpdStWSzdKQ29xOVU2WFdr?=
 =?utf-8?B?c2c1eEJKMlZWdy9QQWJHK1dYalg1TkxDaXRvbk82MnYzNm9PU0d5S21PYkY3?=
 =?utf-8?B?dm1LRHlFczJqQndVL2JWdjVPYjQ0NG1iMitMbmdMSE9SdWNEcHBJcFh2ODZH?=
 =?utf-8?B?clFUTmpWQjd2aU1IUUNDeWNqNHAvdlQ1dGpSeG5rTXBZNTZJQXVpRWZtMWVS?=
 =?utf-8?B?cVlqeVJjSndHOUJNcENaZHNvZEZXWHVsT05sSThqUy9oTlEvSENWTFJneW9h?=
 =?utf-8?B?anRkNDhrTXo4Vno2K2RxU0wyYkpNRUxHZjB1RVFsZUw4Y3M0NXFUZW1rU3JK?=
 =?utf-8?B?Y1k4VXFveGhSSjhUYkUyOXR3MVNNSmZXTWFsTER4dldTeVQwZTlKWGppbWRv?=
 =?utf-8?B?d2x0SkIyLzNYTTdGMGhUR3JqTkxzMndrWTVQYUlxeGtqeFQrWk5iTTEyM2Ny?=
 =?utf-8?B?ZnRjZjFieFhzcE9wNWFDQjM5amdFRjBxdWtib2dCVUd0OHJXSXByalF4TFp6?=
 =?utf-8?B?a1BLK0E1d0tjeVE3M2oyeGlySVZPU0p4aURJSVEzR3NMQVRXNlhBS2lvR25w?=
 =?utf-8?B?bFNCdXR3VWJWTERsR0dTQ1lpZy8rYi9TbFltWEhHV2dhRjdCMU1WSGFkR2pH?=
 =?utf-8?B?ZkF5R2ZkR1hCYXJCQXF6N1YwVTZnelFWMDQrZm00UlRPUVcwY1o1QXA3d1ZF?=
 =?utf-8?B?MHJtTzRwckJFOWRiZk0rVWRYbEVTVk1nOUt0TEhuN0RCdWpFcExqdDdmb2xu?=
 =?utf-8?B?WjlsVmIrVGh4ZmF4ckJrWjJxK1RkN00xOWI0cG5kNVo2UDFKRUNvbzg0QU1M?=
 =?utf-8?Q?pMtam1ZHV4YkVywCMtdNEHcT5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YP4E64mlUEr9Gqh6DfmtZ745MnVIUaQId6WYOhLgruWK0EqfTcVDSou041HOIdcEflOH0NJoBLbpTg5XZSLwAKMbDjeY/DmcLvLpzAtjXn2XXRGScKHs6Wcl7yoBhWik7FfQEcV+cc4Z/vfxlcalg+IrZH+aj5BbhtFs0Rq/5SaBykaRTdLhXEZbZEGTtZhH6rYfjSANTyrGk1NMoVSIMV12FfQs4tmJUKe6ZLgoE/uvwCK6QFK7+mXleokjOAU0Zijgy2UgP9tzQmTXksEeV7sKyrgGEbquhqbQH9TnsVsRFcb2IAJZGCu2IkQi78mbNppQy9AbByK+S/89eFOv98kWcGJxIJI6xvXS78yG49UH7+32fiHQNX5XeZjgpdJxPOETe64BiuQ/wKPi2JGzywUFXRNvELKxuO5ea71CZ8sivWUvmZBqqqc5Ttdiag5IZT1U93EF0V2vN29Id4GnyuwA7IzgkmqZKT7a+jAzxDal/P0Ekj7aOjMngWHgX8vi7EEsx6yA1OR5EBdxDFzcxkAlp55QLWvXvKu785xeSwjV/3G52Oa9c77DI5AGCXD06yIXA4wPJDwC+2+FmKqpp2IwXurPGaSwv1NxOxPfUe8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38eb4e8-2c10-431d-52ef-08de1e0caa6e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 14:48:08.2799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rILQX5s+9DkFociAdZyhRhD+b/l0nAp3HbHWD9x5aKCS2AYWwAyBrYrKubUYhRZAfgjauo3qActE0za4kY1xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=650
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDExOCBTYWx0ZWRfX6agflevDi3DK
 sH3RkuhVI5QpsDXZmRRTD7ztX/RvRMcpUBl0nv/w19kmWMufkFwk2xSAoB7gKw3OGzeKov89azK
 jriIkjJYFVGopXUUcYpbonP3tRLop9X1g2HpfN3iuJNhHpu01RCriJIczdSj32Q4IaFFwOoS8bC
 mak/LqjV6T8dWUZiQV7s1Vi5BoZVJJ3Wg7y1UGSpNs1BMXgfJt35ZoDAC2gyqaMmGL3DxJIrU4F
 LKviZp3m6LnE/bLG1FVztPzhfgeZHcu9/KtN+LIFGV7Bb9nFegtSiObywEM2n+q6vbU1J9qrc07
 XgNUMACjcZsHK7Eki5tWPZn2qgF18I0HtbXQ4ysdvuMNIg2IiBWmkrMAD1uWN/sgsbrKjCoATdA
 58oTwjRfxQcCDRenX3jXtrMs8Ewjpg==
X-Authority-Analysis: v=2.4 cv=QstTHFyd c=1 sm=1 tr=0 ts=690e06be cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uVe8gjz3LEj8ShX5vVgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9XdCJcA1UH16-zkocqwJNaFgSh5tvo9H
X-Proofpoint-GUID: 9XdCJcA1UH16-zkocqwJNaFgSh5tvo9H

On 11/6/25 5:56 PM, Mike Snitzer wrote:
> On Thu, Nov 06, 2025 at 03:35:29PM -0500, Chuck Lever wrote:
>> On 11/6/25 3:17 PM, Mike Snitzer wrote:
>>>> I asked for the use of a file_sync export option because we need to test
>>>> the BUFFERED cache mode as well as DIRECT. So, continue to experiment
>>>> with this one, but I don't plan to merge it for now.
>>> Doesn't the client have the ability to control NFS_UNSTABLE,
>>> NFS_DATA_SYNC and NFS_FILE_SYNC already?  What experiment are you
>>> looking to run?
>>>
>>> If just looking to compare NFS_FILE_SYNC performance of
>>> NFSD_IO_BUFFERED versus NFSD_IO_DIRECT then using the client control
>>> is fine right?
>>
>> Not necessarily. You can mount with "sync" but for large application
>> write requests, that might still generate UNSTABLE + immediate COMMIT.
> 
> OK, I'll take a closer look at NFS client controls for stable_how,
> because NFSD clearly handles NFS_DATA_SYNC and NFS_FILE_SYNC so I just
> assumed its because the client does actually send them.

Clients do send them sometimes. The question here is what happens if
NFSD promotes all of them unconditionally. I'm not sure a client can
be made to send all FILE_SYNC (even the big writes) without code
changes.


>> And as I said above, "no plan to merge it for now," meaning it's still
>> on the table for sometime down the road. I have some other ideas I'm
>> cooking up, such as using BDI congestion to control NFS WRITE
>> throttling.
> 
> Hmm, I thought the BDI congestion infra got killed (by Jan Kara and
> others).. which made me sad because when it was first introduced it
> was amazing at solving some complex deadlocks (but we're talking 20
> years ago now).  So I haven't kept my finger on the pulse of what is
> still available to us relative to BDI congestion.

My (naive) audit suggests that, under memory pressure, the generic
write path will throttle writes by delaying the return from the
function (balance_dirty_pages and friends). What we might be seeing is
that this throttling is not aggressive enough to serve NFSD well.

When the base direct write patches are further along, I'll post my
RFC patches and copy fsdevel, and we can explore this more.



-- 
Chuck Lever

