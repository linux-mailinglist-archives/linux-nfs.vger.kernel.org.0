Return-Path: <linux-nfs+bounces-13937-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A6BB3A2C8
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 16:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE9A1C837E0
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979133128C9;
	Thu, 28 Aug 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kfZBc/pQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NUKoAjRw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B297314A77
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392849; cv=fail; b=ecJEcwd6i7z6NeuZcmwJ22MaPAneUF904jHL2jT79O6Mwf7kIRV4jiO4BrICcO+FccgJmT1a8fNRUY4Ycmtend2LW8JDXZe6p25nNoELvhDuQG0kIgksrtBGUbK3dRY78M+C7OxMF2Vm32xewgQLjP2m6dB+qLBII64TS6FHO84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392849; c=relaxed/simple;
	bh=/36Xg7oLik6Cjzmdy3rcCJQwHc4HLMVLOlo0kpRMsMc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e7latI6AiN8gRD8q4dwRWchAy7g9VeGdUb/VOE8lOp7sZRsUt/XUOby8EdkSvCmejs2PGko9z1YlCjNkou1gvo80Xkld4ldjepIqPCjmVXSx5xMfI0bAdFHpm/1U8UwO7UN8OQ1P67cm8XUVPWktVRfl4TCTJHmQOcWLkUwIuTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kfZBc/pQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NUKoAjRw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SENCIU016319;
	Thu, 28 Aug 2025 14:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=10ok8sBU2SwZj/dfMoiEA+ROn/+5nCqsdIk0BCtPLmQ=; b=
	kfZBc/pQzuKFdYChS9XlQZgUOQihls8gh1IoGBKC2jaQktqBd0oTue7nokSIFb1z
	Kutdh3OcLn7tY7errv9owNR+TuswT3q2Y2LIALNRUdTZvMNI/GPQAfUljJxRMqup
	LOftzSQD75fiouzctoiQun+YCW/WUEjCQLECTL0uePP9ugmkOofp8Z7caLgRGF6h
	SII0GBgdWTme2vQxaI5INJgLB3vsA7V3lauEyUDOHz0E4RFlVpiEFyalUHYpM4kB
	b+3zuYU4HfCZDhUhHDBgwUT7EGedHKZQaArRMIoApB7L1qe/chOvtegqeb4mWVct
	zgqbYWtm5IDI6YaW6IHDsw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q42t8j6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 14:54:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SEq2MU005206;
	Thu, 28 Aug 2025 14:54:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43c45d7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 14:54:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVc+sLvglyAMiICBiIMQ6KsFVYe2nSANVNlI0B3pPXPyUkU+tlRlJUQvxx1QiysOnhrMxzuoDCMUaPQFLQQaC+Ph/ulovQL3gP24B+/Q5xUq8eisd8RxSbjQyoKMtqzvebNBUckMUL0NOa37Dlyqe6mxCYOO5MMgEtJIl9su3Px1q1U3nea8CzYBsCJnIYenP/uCAWvb7HYMCNIsES5A4LtzhoUNuzVe6uVfeqJQ+EQt290Xj1jbCgjFcA8uAlhmmzTKKR06sHuV1Jay6cQ2DcrSz7NrO9dmhPwSzIe/0eZhwK84KTJSOsXWk0ePboix7LmLR65Okix6/wlEbsHCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10ok8sBU2SwZj/dfMoiEA+ROn/+5nCqsdIk0BCtPLmQ=;
 b=anhTdgPYA9dYftPVWDN3z+XOgwMpPdgB27k0I1B8Jjf/Eyu/COpVqZHzNWHc707hiL3bUcgpSdDjsQbSrR6DGuMXnisK4VzKe6tPGwDIWQcUCeh9ebIPQIPGuUrqIFpcTUZB2xOKnHp8Z8xzRf12+9M12GzqdALQlxXAmXfc6ykMMXKB1qSh0gtrdZsxLaD6eXmX/T5H4K2HuX/Fz8dfQcDgMqrER9SpAdQdoBqDo1154crhdLVmILhUAjhNOfZJ9p+gwLU9p/etejkh01+TbGv071nSGZ2nIGNw+V5rKvZUz3g2jVpySYPz7a+cYW8HUiWsWZ4ZKoHb0OvebXcpuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10ok8sBU2SwZj/dfMoiEA+ROn/+5nCqsdIk0BCtPLmQ=;
 b=NUKoAjRwBictf57+K2dhQFWV/N3EGzq50gJSuF94aa06HlguEtiaDEtlAVa3e4zoHmBOOIXbK1xfhjBo9qCWIh7roGYfReKbhsyLe87Kbw6kEfBUWblqL4sp6O/6z1MID98XnNdaVx8ugVAs5ppUlJjyBrX7KsHVgNt5YARx/i0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 14:53:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 14:53:50 +0000
Message-ID: <ba414445-a31b-4f37-9520-94a0fbbbba55@oracle.com>
Date: Thu, 28 Aug 2025 10:53:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/7] NFSD: issue READs using O_DIRECT even if IO is
 misaligned
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
 <20250826185718.5593-6-snitzer@kernel.org>
 <f7aee927-e4fc-44da-a2b6-7fd90f90d90e@oracle.com>
 <aK9fZR7pQxrosEfW@kernel.org>
 <6f5516a5-1954-4f77-8a07-dacba1fb570c@oracle.com>
 <aK-Reg6g8ccscwMu@kernel.org>
 <09eca412-b6e3-4011-b7dd-3a452eae6489@oracle.com>
 <aLAOsGUIvONZvfX7@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aLAOsGUIvONZvfX7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:610:e7::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY5PR10MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c6c87e-94d6-4bc0-501f-08dde642b34f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SmtvVFRicVp5YlB2MFJvN3pGV1BtL2thK2gzUEw3cElDNExHaXB6dzQwSW5q?=
 =?utf-8?B?dUc3U09tSXlFRTRzY3R6b0tKY21rMm8veDI3VlpCNmYrTEt4YnBtMHRVdkhE?=
 =?utf-8?B?QW53MGE4c3QvdnZCTmJubU8yaHdEUmQ4MHRIM2ZVRUNRb0R0MFByaSs3b1E1?=
 =?utf-8?B?TlgxSDlNQmx6b0U4UGF3dVJMV1JSU0pNcHdnWnloNVFWVzZMdGlEMnFKeHRj?=
 =?utf-8?B?Vm16TEptekdXMS90RHJmakZpODlORGtoeHlvd1ZzQUVFUmJNQ2Fkb1dlVHdv?=
 =?utf-8?B?V095cTA0dXZFeGxTMzRHY1NvZk5xaGtMWTF2MHVtQzFic1BaN3lCcHpTdlhK?=
 =?utf-8?B?OFNSVFl4Sk1EZHRIRzdvR3ZvSytTM1JPYzVJanFrc2RJcFYwRGV2V0Y2Q0Ev?=
 =?utf-8?B?dytnd2prdyt4ckdaZFl3ZnVmd21DUkpqSU5sejBORFhJWG1ya0c3c3ZQY1dC?=
 =?utf-8?B?eWxMc1Q4bWtHendDT2pNYXpPc0JCNk1RblJ5ZklZYWhadk51LzBUWDJFL2J1?=
 =?utf-8?B?c2s1NUJzU3VzUzYrQWg3cUY3bmgrZmNFa1ZmMEVJQkZRK3NFdFZNcURwUDhj?=
 =?utf-8?B?RnZaSGZoVmVpRjNNY2pWVjIxOE8rNGVTOHJUQWxKRFpFUFVGNUpydmFOQjhT?=
 =?utf-8?B?bXdRUnJaNUdMbGh3NlFmS2tLckxpcW95bzRGMWZteFU0WEtXUXI1SGF2aW03?=
 =?utf-8?B?WTgyVXRJVCtrbDBnbSs0RmFUcytiUUhjWjVhclRGWVZzakRkZ2hIbGp0RFhs?=
 =?utf-8?B?RnJEVmx0NXFSK05WanRQUWhid0Q4ZTNsTlkzVW95algvemsrQmtnOXVEbng2?=
 =?utf-8?B?azdLdlJDTVNTTEw3M29tc3VHVldUWmN4aTRXS0dpYzZBeUVJeEEveGpYODR3?=
 =?utf-8?B?dW1wWHl2NnNsMkFXY3YxUndmNTNxR3kvVTh4eTQ4MDFxNHdRZDZaUmFEMzgr?=
 =?utf-8?B?NlNLVE9PSGl0YW92Z3orbzhkaFNpcDRPMW52QVBXeWIrZjJxRmdQV0pNU0ZF?=
 =?utf-8?B?OUR4cU96RjVIR3ZYdUZ1NUlabFM3d1h0VWdobzJEQ0hsREVySTV0Rnlxb21I?=
 =?utf-8?B?c2lubXZ4NnJuM0Z4L2FuSE82aVVwK2RXbnZYOElVREdGT05ORnRuanVOZndz?=
 =?utf-8?B?MTdmWHZmMWNQUENtK0pheVF3cDNxWTVuRHd5U0xMYkg0NjRGL1FJUjlmQlM4?=
 =?utf-8?B?YVpyYWlZTnpnWXR0SVlCZG1oc3VYV0wwNEtkQnBjS0ZObEFtN3Mxa3Jlb0Mz?=
 =?utf-8?B?eDYxMWJ6QjVtd0ZhVnppblZRdC9tL1ZaK01TcnovZXdKcys3b1hENk5IVUJZ?=
 =?utf-8?B?UE5NTGZoQmpmTFlIU0hVZWxJR0gvSWdhQ2RERXBIR3NJc3Z5ZTlLcHF3SGRk?=
 =?utf-8?B?SVJ1Q2RXLzhqenEzZkVZYUNJVzNJdmR1aGNlQTZ5VW1qQkNUd3JqUzhvYndC?=
 =?utf-8?B?QjVmMGxZc2tscEVBNEFiRnV2M1h3djJ6RndkSTJzZzF0cHdtdkZMNWFwQk1u?=
 =?utf-8?B?TWRTczdWcGxaa3RJZkJ2MmduY3RtejV4VjYwVXpPYWdQN0hvQi9nbXVnQm5q?=
 =?utf-8?B?UE45cnlVeVI4dHovSFZ5VVlPSkZsWTZZWHllV3JKQ1IzT3R2R01QSmJBcnB5?=
 =?utf-8?B?UnBqc1FLOGt6ODNmeVN6eUhVc3d3cTZDcllybHFVUzJhZmd4U21Sb01mYVRL?=
 =?utf-8?B?UTNZQllqeFd1c3NyUC9ZeDllcjJSN1VJM2tRbDBXMFR6SVhlMllxWGNNb3dx?=
 =?utf-8?B?bWRNbERjTWFkN3l0c3JZdkZ6b0JLN1Rpb05UcWVqcDRLdGhlRFoycjJRVEV5?=
 =?utf-8?B?UXJRaWphNWphUTV1ODd5SlVCNGdHMXJIMTlnUEF1K2laSkg1UjZkVjZPRXBU?=
 =?utf-8?B?NnE0SVhQZW45TDZnZVg5cFRIVHExTWpURGFBbEZCVUR1Y3JlK1lHdS9sU2dP?=
 =?utf-8?Q?1nH+VZv1pYg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VGtxb2wxQ0xPSG5WR01xbGJHMHptTkV4bGc5WjZrNFlVbTZ4ZHRQYUhXK29F?=
 =?utf-8?B?WU1zNTJ1b25tRitseEN4NHVmT0tTVnFrOFNxOHI4MlhzUWtVdWF6d1R1cGps?=
 =?utf-8?B?S2M4dnlTTnUzOUY5N1hpUWJaUit0THFrOUNHcVBzb0lzRmJZeSt2MDhBM3lw?=
 =?utf-8?B?K1dDUVJkMWV3OWVNcTdVVU1JMHpZcktQUEozbVFyb0lWeGsvOHhVWFFaWWNs?=
 =?utf-8?B?d1Q1RUJUdER6M3NxcHFTZ2dpYlRRdkEwUjJCMVAvSW5MTkxUVzR5RTBUNXV2?=
 =?utf-8?B?L09NV0IyYTZQanVKeC9TTVRXS3ZIcU5mMVdpTjcwRGplSHNaamFISE5xQ0th?=
 =?utf-8?B?eXdOWXpac0ZjcmUzcEltcEk5eE5lWWsxZVdFSXM3b1FQMzZnOTVYUzk2dUhI?=
 =?utf-8?B?Lzc3OWFpaHE5dmhOTnVoc1FwSmEyNE8rVmR2Y00rQmtxZHEzMXp1cVVOckZy?=
 =?utf-8?B?OW9Sbkxlc3NJYzhhMGhqVGU2Z2dhWlo1MitQNWs1cWtBSlQ5a0tsSVdoUzVK?=
 =?utf-8?B?MEN1V0pQWXA3TzJiMExwa3JCaktJVjNUQklvSWxVQVp1bFB5Y0xVWUpqT1N0?=
 =?utf-8?B?UUlTZmNBQUpCZTdkUjdhVE1RSGRtQU5KYW1MK0pGK1V2MDB5aTA0UXd6VnZ2?=
 =?utf-8?B?Tk9YNHRTQXhIU1NzbDI4QXcyS2huN2IzaW9YMVNYdXZLTzhjMUNwZXhlQ2JH?=
 =?utf-8?B?eFpFWFoyMFBoRUx2VDB6cmp5V1NiVFlHZEZ5c0F4YWRnUStrNDA3T2R6cEFK?=
 =?utf-8?B?OVYvUkU3WlZpdGp2SFYvOFRoRDRoTVlGQlA3QWFtTERXbU5ua0txejJHdE9R?=
 =?utf-8?B?Mmx1eDJBbEUrOFUzK0V4UnNjRExoTXl1QURIbTVVMWpwcGhZWENaSXc0TDZ3?=
 =?utf-8?B?NEx0SlROMEFxL2ZiMUVTTHBteGxqSEpiYXZKMUx1ZWZlcWs4NkZPN3RZYlpH?=
 =?utf-8?B?RHdvbDRrWmtKZEJUKzQ4aWs1TzVkUldGdDVUQi9Fek9rQ0YwTWpUSVlaaUFa?=
 =?utf-8?B?blVxckJud3N1ZUprOVlSQUcvQlRQWDYySmxTMTd3bjJXTXNlM0FBU2tKbmZR?=
 =?utf-8?B?V2o4QUFSbWRzTWpXRmZucnFwS2hadzRSUElEK3lVd1ZtbFhZWlBqY2dNb0No?=
 =?utf-8?B?dzZDUk11ckZ4T1ZScGVaUE5pTS9TZHJ6aFV4K25iT0JVRHBCWkxxQnlxbFZy?=
 =?utf-8?B?TjZQak1JQTVwVndQRmg4MVZ3cG53cWY5Q3hxRGp1TkVvQ2JEQ1ozM0thL0lP?=
 =?utf-8?B?NW5PY0xobzJUUFM3aExIUWNhZjZ2aS8vc1g4ZS85bTQ0cS9JSEZCZUZGTXdV?=
 =?utf-8?B?NkNQNUtOdUdDTFhDNUFKbnBiQ1BGOUhOS2taNVkzNzdRK3pGV1lzYnhTS000?=
 =?utf-8?B?dUg5WXJZNHh4a2V6MjhxcGpFbUhvY1ZjODRpdW9vVmJpejVTT2RxVGN4Wnhw?=
 =?utf-8?B?am1tM2lYS09Pc1Nna3VJWlBNRGN4ODVON2FTWml6QXhUYmtRSUl3amlTTFkx?=
 =?utf-8?B?bzRuU1dScVhwOENueE5McWlYbGpuaVpwQXNJcUZTSzZITUkrNG1ncW5EaEdr?=
 =?utf-8?B?dXpFUzIxbmlCeTVBODUrVmVoaVFhRmp2ODlwTnp0VkNyN0VGNXhLclpxa250?=
 =?utf-8?B?MHRwM256RFhqVy80cVBHL3U0WkVJQzlDcDRmYVJWSGxQV1loTGs3bFNycW9U?=
 =?utf-8?B?V0hnZDNHUGpPN3VZZlg1MnA1SUJJWnNiWTgrRnVxK0pwQzh1bDZyekpGN0VZ?=
 =?utf-8?B?L0VKbEdyREVvL1dFSFI3NHNSczRGZmdYWERnU0tMNlh5MDRobU1JcmJoMnlS?=
 =?utf-8?B?dE04ZisyNC9wcEJ3a1V4cDJnbWtTK21NTXJpdjhKUWE2QnNHcExiNCs4Rnc5?=
 =?utf-8?B?QmVBV1JNa05VOFN1cEp4ZEtPWUhKWXBYRVhnTXF1Zm8vb0lOUDhHYnlsRTNs?=
 =?utf-8?B?aStZZFFtVDZoOEZZRTdyUlZxOUduOW1BclZqSkRHUWQrbFdvL2VjWnh0RG83?=
 =?utf-8?B?SW5FdldkWklCNGh3bGJCWE5SZmx3NmxvZUZFMUdxTDRDUncyRm5qZlIxeUV4?=
 =?utf-8?B?bDQ5eFh0a1V6aEV6ZmFTMmZkVGtOQ1pEclVwOTB1ZUN0RWhDOG5tczZPNGRN?=
 =?utf-8?B?VHN5TGNBamJXVnhCbmFJcGlTRjU3V3hRYVNYTzR5RkNGbXpHelNoeUYrSW1a?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qym/KdcRuYC/kEsmETVKHPsV6TQGOVeYU5gaOKB9Lk8MpKvkGdoq9ESaxIGE/oMWeglCwyZs6U74MQbgWlUOMvvnz3fVvC7KhA+aJ/prYREe/2zapl4JHILQBYoslTjJWRd5gVy38xyxE8mLz1DLyZuDYTKU2Od9D5z0MHSStJZf2m7x6v2JM4yiE2vNB2j6rxssCO5rArXHRfoKW9DAQM3R2N9yjfWJAT74DCXhnMgvl+C6IPB3W9UmtuzBLxnuy/XDrGwbLgjihLgw9AZkkqCazVYHmvcqdkh9Mfw/vIBMb5e3KETaMFkHRh6cjbqo5yAk8DDQC8QqLVw6n42SbVs3EPUFgDLp7SS0aCU7VcgWvh2CV0F7EGCIK+uIaPk+zOiqB82DoYH4YUfVqXdyLbqAdfLAnWYpGrdoYpItUudyQZAyikv61fufvI2algDmttQgvsIxg4u8vj8CPv2TTXyFdXke6Dqy6clcICbmmVFVS6mr9AvFAU9t/ExgbMJiux/+inhYZeNl+9ka/iS8z/Dvz86EcMxqOcg1jR8bbjhvTlZ9ic2n6bIfPsPoxDA7LEFdWv8oRDsc/iC5oVIgrJLlg/Es30z3U8TIFd23cK8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c6c87e-94d6-4bc0-501f-08dde642b34f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 14:53:50.8663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnxUeffcpv1hJ9M3v2odgllQSxArtLr79cZDRGbkwE+JNjnufQvTt9FwAA8xr02Gs4ju37Ag0lPRBcjeO6qjjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMyBTYWx0ZWRfX45U7lI9pJ4Yg
 n3Kd9/KP/3OSoDMvrwl9qFwLIvOEo0H5PxjtFW7EZ6iLyFNSegZYDcbfMWz+eW0/7vKbUzLerv5
 SonuaHN2Sh8r615kD2U18Y2VdS4F+yPQdxC7xUhBnDHaosMiiMgAnTnRQM6kMtcuTHVUCV7cq5i
 KfevnK1AL+vgyoCPeP+0BHIyyinhbxNWy1QcNrXwOWdZ0OUGDuVIslxqtQDTunerhHez77WzcKt
 RkIgui3+0d9jBuLu9XoedOOrcIlyowbujN+YNajyTILgOTTIg+9XvUsSpNibbXdigrx40F0M826
 OuV2sCltxuFFRQLOnlWoVO8lmBrN1co+MtV5xFffaSun+xFBVCoeUQVBxUxq4mq6P/61ipSMo5r
 Gc9mlOvN
X-Proofpoint-ORIG-GUID: 8MudT5hqrB7R7JfXIHMk4wXvbLVsa4EU
X-Authority-Analysis: v=2.4 cv=RqfFLDmK c=1 sm=1 tr=0 ts=68b06d8b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=3BWVR2VbRt__NC8b-o4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8MudT5hqrB7R7JfXIHMk4wXvbLVsa4EU

On 8/28/25 4:09 AM, Mike Snitzer wrote:
> On Wed, Aug 27, 2025 at 09:57:39PM -0400, Chuck Lever wrote:
>> On 8/27/25 7:15 PM, Mike Snitzer wrote:
>>> On Wed, Aug 27, 2025 at 04:56:08PM -0400, Chuck Lever wrote:
>>>> On 8/27/25 3:41 PM, Mike Snitzer wrote:
>>>>> Is your suggestion to, rather than allocate a disjoint single page,
>>>>> borrow the extra page from the end of rq_pages? Just map it into the
>>>>> bvec instead of my extra page?
>>>>
>>>> Yes, the extra page needs to come from rq_pages. But I don't see why it
>>>> should come from the /end/ of rq_pages.
>>>>
>>>> - Extend the start of the byte range back to make it align with the
>>>>   file's DIO alignment constraint
>>>>
>>>> - Extend the end of the byte range forward to make it align with the
>>>>   file's DIO alignment constraint
>>>
>>> nfsd_analyze_read_dio() does that (start_extra and end_extra).
>>>
>>>> - Fill in the sink buffer's bvec using pages from rq_pages, as usual
>>>>
>>>> - When the I/O is complete, adjust the offset in the first bvec entry
>>>>   forward by setting a non-zero page offset, and adjust the returned
>>>>   count downward to match the requested byte count from the client
>>>
>>> Tried it long ago, such bvec manipulation only works when not using
>>> RDMA.  When the memory is remote, twiddling a local bvec isn't going
>>> to ensure the correct pages have the correct data upon return to the
>>> client.
>>>
>>> RDMA is why the pages must be used in-place, and RDMA is also why
>>> the extra page needed by this patch (for use as throwaway front-pad
>>> for expanded misaligned DIO READ) must either be allocated _or_
>>> hopefully it can be from rq_pages (after the end of the client
>>> requested READ payload).
>>>
>>> Or am I wrong and simply need to keep learning about NFSD's IO path?
>>
>> You're wrong, not to put a fine point on it.
> 
> You didn't even understand me.. but firmly believe I'm wrong?
> 
>> There's nothing I can think of in the RDMA or RPC/RDMA protocols that
>> mandates that the first page offset must always be zero. Moving data
>> at one address on the server to an entirely different address and
>> alignment on the client is exactly what RDMA is supposed to do.
>>
>> It sounds like an implementation omission because the server's upper
>> layers have never needed it before now. If TCP already handles it, I'm
>> guessing it's going to be straightforward to fix.
> 
> I never said that first page offset must be zero.  I said that I
> already did what you suggested and it didn't work with RDMA.  This is
> recall of too many months ago now, but: the client will see the
> correct READ payload _except_ IIRC it is offset by whatever front-pad
> was added to expand the misaligned DIO; no matter whether
> rqstp->rq_bvec updated when IO completes.
> 
> But I'll revisit it again.

For the record, this email thread is the very first time I've heard that
you tried the simple approach and that it worked with TCP and not with
RDMA. I wish I had known that a while ago.


>>>>> NFSD using DIO is optional. I thought the point was to get it as an
>>>>> available option so that _others_ could experiment and help categorize
>>>>> the benefits/pitfalls further?
>>>>
>>>> Yes, that is the point. But such experiments lose value if there is no
>>>> data collection plan to go with them.
>>>
>>> Each user runs something they care about performing well and they
>>> measure the result.
>>
>> That assumes the user will continue to use the debug interfaces, and
>> the particular implementation you've proposed, for the rest of time.
>> And that's not my plan at all.
>>
>> If we, in the community, cannot reproduce that result, or cannot
>> understand what has been measured, or the measurement misses part or
>> most of the picture, of what value is that for us to decide whether and
>> how to proceed with promoting the mechanism from debug feature to
>> something with a long-term support lifetime and a documented ABI-stable
>> user interface?
> 
> I'll work to put a finer point on how to reproduce and enumerate the
> things to look for (representative flamegraphs showing the issue,
> which I already did at last Bakeathon).
> 
> But I have repeatedly offered that the pathological worst case is
> client doing sequential write IO of a file that is 3-4x larger than
> the NFS server's system memory.
> 
> Large memory systems with 8 or more NVMe devices, fast networks that
> allow for huge data ingest capabilities.  These are the platforms that
> showcase MM's dirty writeback limitions when large sequential IO is
> initiated from the NFS client and its able to overrun the NFS server.
> 
> In addition, in general DIO requires significantly less memory and
> CPU; so platforms that have more limited resources (and may have
> historically struggled) could have a new lease on life if they switch
> NFSD from buffered to DIO mode.
> 
>>> Literally the same thing as has been done for anything in Linux since
>>> it all started.  Nothing unicorn or bespoke here.
>>
>> So let me ask this another way: What do we need users to measure to give
>> us good quality information about the page cache behavior and system
>> thrashing behavior you reported?
> 
> IO throughput, CPU and memory usage should be monitored over time.

My point is users need a recipe for what to monitor, ie clear specific
instructions, and that recipe needs to be applied the same way by every
experimenter (because, as I say below, we too are collecting data about
the user's experience with this feature).

Can you provide a few specific instructions that experimenters can
follow on how to monitor and report these metrics? Simply copy-paste
what you and your test team have been using to observe system behavior.


>> For example: I can enable direct I/O on NFSD, but my workload is mostly
>> one or two clients doing kernel builds. The latency of NFS READs goes
>> up, but since a kernel build is not I/O bound and the client page caches
>> hide most of the increase, there is very little to show a measured
>> change.
>>
>> So how should I assess and report the impact of NFSD doing direct I/O?
> 
> Your underwhelming usage isn't what this patchset is meant to help.

Again, my point is, how are users who try the debug option going to
know that their workload is or is not of interest? We're not
providing such documentation. Users are just going to turn this on and
try it.

But consider that one of our options is to make direct I/O the default.
We need to know how smaller workloads might be impacted by this new
default. The maintainers are part of this experiment as much as
potential users are. We need to collect data to understand how to make
this work part of the first world administrative API.


>> See -- users are not the only ones who are involved in this experiment;
>> and they will need guidance because we're not providing any
>> documentation for this feature.
> 
> Users are not created equal.  Major companies like Oracle and Meta
> _should_ be aware of NFSD's problems with buffered IO.  They have
> internal and external stakeholders that are power users.
> 
> Jeff, does Meta ever see NFSD struggle to consistently use NVMe
> devices?  Lumpy performance?  Full-blown IO stalls?  Lots of NFSD
> threads hung in D state?

I have no idea why you think I don't understand those facts, but you are
still missing my point. NFSD maintainers are part of this experimental
set up as much as users are. We need good information to decide how to
shape this feature going forward. Let's build a plan to get that
information.


>>>> If you would rather make this drive-by, then you'll have to realize
>>>> that you are requesting more than simple review from us. You'll have
>>>> to be content with the pace at which us overloaded maintainers can get
>>>> to the work.
>>>
>>> I think I just experienced the mailing-list equivalent of the Detroit
>>> definition of "drive-by".  Good/bad news: you're a terrible shot.
>>
>> The term "drive-by contribution" has a well-understood meaning in the
>> kernel community. If you are unfamiliar with it, I invite you to review
>> the mailing list archives. As always, no-one is shooting at you. If
>> anything, the drive-by contribution is aimed at me.
> 
> It is a blatant miscategorization here. That you just doubled down
> on it having relevance in this instance is flagrantly wrong.

First of all, "drive-by contribution" is not meant to be pejorative.
It is what it is: someone throws you a patch and then goes away. It is
a fact of life for open source maintainers.

I'm simply trying to get a sense of your commitment to finishing this
work and staying with it going forward. You keep telling me "well I have
other things to do." What do you think that indicates to a busy
maintainer? That you will be around to finish the feature? Or rather
that your employer is going to yank you onto other projects, leaving us
stuck with the work of finishing it?

You have rejected one or more reasonable review comments and maintainer
requests. That doesn't convince me you are willing to collaborate with
us on maintaining the feature.

My biggest concern here is how much more work maintaining NFSD will be
once this change goes in. It's a major feature and a significant change.
It will require a lot of code massage in the short- and medium-term,
just as a start.

Maybe I'm assuming that you, as a kernel maintainer yourself, already
understand that this mind set and this calculus is part of my email replies.

So, I'm being frank. I'm not trying to offend or belittle.


> Whatever compells you to belittle me and my contributions, just know
> it is extremely hard to take. Highly unproductive and unprofessional.
I can't control how you understand my emails. If you choose to be
offended even though I'm trying to have an honest discussion, there's
nothing I can do about it.

I can't control /if/ you understand my emails. I'm repeating myself
quite a bit here because a lot of what I say sails past you. You read
things into what I say that I don't intend, and you miss a lot of what
I did intend. There's nothing I can do about that either.

I can't control your unproductive and unprofessional behavior. You keep
rejecting valid review comments and maintainer requests with comments
like "I don't feel like it" and "your reason for wanting this change is
invalid" and "you are wasting my time". Again, this suggests to me that
maintaining this feature will be a lot more work than it could be, and
that is an ongoing concern.

If there's something that offends you, the professional response on your
part is to point that out to me in the moment rather than trying to spit
back. Because most likely, I wasn't intending to offend at all. If you
keep that in mind while reading my emails, you might have an easier time
of it.


-- 
Chuck Lever

