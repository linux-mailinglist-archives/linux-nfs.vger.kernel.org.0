Return-Path: <linux-nfs+bounces-2553-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5317890FA7
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Mar 2024 01:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9711F26054
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Mar 2024 00:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC6E1171D;
	Fri, 29 Mar 2024 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HHgyuHyQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b91rKdzG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C779D1
	for <linux-nfs@vger.kernel.org>; Fri, 29 Mar 2024 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672273; cv=fail; b=dwmRH3PajrsOXHVL5TLYPH+8zOhd7YVy33qMbgeMXdhjYzyE0ommOA7mP8Hv17TcRURkJ7hd4SVsgaLrBe3e55j0Tk8slS48uy7QLPm4nUBp9qUe/SGClIAgUDs5EL08fNjzPxlYiO15j39xOIw6wSgSOacghKLTUpU5AR8vgws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672273; c=relaxed/simple;
	bh=p7m5RkIAVFPkIv1cV21ncMJfM+1JoDwu27MzbqB3mi8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8juc1nRIxZmUlxEMcpb6EANu0b+sqIaZVXmwNGVOhCvdrD+MhNPMvMEGhBY2ngTgGPt8GGSvv74pfgsDTISLm+vID1154+OBzN7+yXFwANcDgfgxwHH2clnLg671gvxvD/0cjv4yJlomZXMYGv9Z0G9gTv1hMch0oVXTqPOo1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HHgyuHyQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b91rKdzG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42T0PQXM009358;
	Fri, 29 Mar 2024 00:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tN4bvKDNl7km7B1i+8JGv8cQLvR1figj5Ljny3cii2U=;
 b=HHgyuHyQxwDbaYOBjes54UiNYlOVfpz78EaCw4PBaGoWT5U8c205X/OuFs+YpraC4yF1
 B0uSB2UkasfbWpIhGjCXulDbfkzYeApegLR/PIjO8BVidpGeBVV85JuZ3JqESKvAWr31
 rR2Qc7rmPDwKkFVt833FOGJaNYpcH++nfcKZ4u8URaBJDlybRFl0VR3zlY6DMwH0e44D
 G/j4pREhxstP+fCslcp7vPkeMX31sSQDllQWvKWrXjHHQU5fk2Mhu4dy7ZaCjLuG0Ex5
 wNad6gY4P2m/9SySWOOlbWm2jD47pdMaD/Iu/n3Ll7moPJRirXbvz7H6pvzxuv3IHEYo BQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1np2jvyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 00:31:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42SMJxvu018097;
	Fri, 29 Mar 2024 00:31:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhavyqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 00:31:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmdGbIw36tc5gPtKLpGKf3POdzkvmBw9LjuDtJ6YUQwSuXysNefjZwOnIj5lawnyGrkjSj8DenDmlqAyWLarsGHTvYLBgCWOzjqgC1g7ah8lCJ7/1s0840mmxUQVllZtoao8fJeySJzgVaiBGbJatEWNpMBP8nyocMUknIiqhsoxVcQBgovhCzfsxLDWtI4d0X8/R/tAlgEUzQeLyRrnb4xD9SGSgthU+hgTfd03duZnRilm0NqFf9aF4YZEFU4aHfvVjfQmaC1Bg71DLovntifTOZfIQmglvlVIj3ZEpEkbQ/r4gwIJLi9CusjOU0vmNFUpoMOn0/vFeDPMzaf1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tN4bvKDNl7km7B1i+8JGv8cQLvR1figj5Ljny3cii2U=;
 b=PuQiMrICOBfvgis2jGBWIFnatgUd0FD5ZY7OCcyewruq4/jsEX0cFiW7vTvOLsawHXLscUYkW4AeOCwdQElwbUOZSghCz22RdmpCvsXunyZirwhhqkOwEiC7J1noLJ8Xz5DYi4RTxvV2/MzSoGyG/JoFfv+ZiLTyX4f7tHC3uYj+3AwVyyKc02+CJSA02XP+/loAfP9Yww0HICVLyYHvJi7ZF6PRizWrsKjcvcW+rkoY4DnYTCI1AMmlD6FHSM4/uq+nFQ1mnk6BWFjEujg1l/Iu4Yttc6z5b2r64okyACdE//vHJPeG5FdLEk5fZ0nZX6wiv0euWV3eJ2vOSbP8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tN4bvKDNl7km7B1i+8JGv8cQLvR1figj5Ljny3cii2U=;
 b=b91rKdzGGbkMWXzHNp00qA80nOVascblgymvbUYp+knG/upvDRA/CpqKXdtT9osEymsAa6jFupuCmNgCcsbThwmrq19R+1HlDUCUidKZ3eLORYy+uuUvp2HyCTx+Km2rHBKO+mk0kKYNSpDyyUlCiSjiX8O/KYFEv24GhNyVDkM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SA1PR10MB7699.namprd10.prod.outlook.com (2603:10b6:806:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 00:31:05 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7409.038; Fri, 29 Mar 2024
 00:31:05 +0000
Message-ID: <c97be8b9-c0ba-4f2d-9340-78368008ba4b@oracle.com>
Date: Thu, 28 Mar 2024 17:31:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <1711476809-26248-1-git-send-email-dai.ngo@oracle.com>
 <ZgMToHNkkGEHNb/y@tissot.1015granger.net>
 <69914825-e9d5-4859-a5a8-60d17e8e8bf6@oracle.com>
 <ZgV5zwR0q/vjBAtI@tissot.1015granger.net>
 <88fac8af-c194-452b-94eb-7658b9056246@oracle.com>
In-Reply-To: <88fac8af-c194-452b-94eb-7658b9056246@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH1PEPF0001330E.namprd07.prod.outlook.com
 (2603:10b6:518:1::9) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SA1PR10MB7699:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EALVbHAr7mJyjppkOfM8CVV8LNoYV4O6UHbMIeHMplHE/l5kJLmBdQqn+xnD/v/z3YzOraPpYt9TbzlkSHWgNMGcXBFjOxwgHTrPlpe+fF87XW5OHFWJAfdvccKGhJfToK3al4Yx+iLHkuwOnlMa7tl1yi8PKPdmIVRRtiYAWit2tFp/hoGSSZW9dhrRvYCO+PZOYbecvxVGZm8LhylmgA6Sxb4roeRMbpy36zTc5wccG1TPehivsQ9BnKDfzkV9n4o5KqyuOSsQP2/Xtl+8eelqK1eIOD4YDrEUkdTDBxIQEJ6ebgPxTcCK1VnVCxCNLoSTDxoBZJMSFltWJFDnRbW5SBVVBryWRBZg8t00mtXtnwPjyV6lSzDncfD47TfPbOKg+NasiSAyN2JURmuNcLDVqqT3Bol/HLM1BVcWpV4KXE2rbVdNjiMd77CTjmRUusJbbhbRc/XKRJkfUrnOjLE6lEKF+2SYbbO3lUomLVPCXpcZg/jnPw3Kje0mFW0vp1hYkcZ3eHiBgOS1C9t+dxOI1SFDAEmhvUktN4QmDkls2NXFLmeAy2yJmzrn3X7MQs0n4qMgKsUx7uNDH1LKKVQaT/npssEMYbGQEw7W1I0EXCrVsXBeujXcR8Hm9teSJoKEziL65nGgYWOUfVQtgvZVx31uNVHe7oOSOw9tW4Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QVdicllYWWxZVmg2bWJTdG56RUFqNEs4SDJ1dTYwL0hZY0JyRVFpbEIzV1NW?=
 =?utf-8?B?MFlnbWlMR0VhOUJ6T3JlVTNEbjZkV1hlbjNCc2VaL1ZxRGp3VWRpWlBsU0kx?=
 =?utf-8?B?Y1hDYS9DMTljL1FRWnYyVll3NlRGOW9RYy94cUhOSU9EVVBhZTNIbXlTanhV?=
 =?utf-8?B?TU5MTS8wa1JYQldyM25KU3AvdlFPZnRXcms0ZXhxZVJrQ0crWTQ5ZXJJS2k1?=
 =?utf-8?B?VjJtOTErTmZ0dWhDUTJ4Mmw0WG1yZDRLRUUzeVdmV0E5TEJOQnpZdFl5ZHNZ?=
 =?utf-8?B?Wi91SXBLSi96SXRaZm9lZEdhWW9EV0ZLV3hIblRCYnROcDFoQmEyV2IxMzg2?=
 =?utf-8?B?TVpEcGkwQmV4cGtOV01RbXZCYWUzRWxZT0FDdWZ0dFVCNUVRaE11ZC9TOXVL?=
 =?utf-8?B?VnlhZ0NMNlVoWWs0ang2V0xIcXJpNlNEZU5ydXdPQS83UlVnUk12NzYzZTcr?=
 =?utf-8?B?UUhPTGlNbUhORXlyTUZZZ3JJTEh0MlVlNkZ2OHNZQVdFOHFTM3dCcnEyUmJM?=
 =?utf-8?B?bWw5T2xpbHd4blZDcW02V3hMd1FjL3h6bVFsZUVxQlBBN0I1QTcrcW15T0pq?=
 =?utf-8?B?MlMrS2o3aXR5Z24rcUVJSWpTRzExaXRPREc2WmJxelZTVW05V1gxQmoxUUVn?=
 =?utf-8?B?bnU2a0thRitnbi9JeFBXMmZnUFR6emJIMlVyZzZ2ZU5GZ0hZT0pNdnU5cDM4?=
 =?utf-8?B?cHBTdFlIY3V2azJjcnhzTHN2Y1VNYXh6QTFMQmIxVDZkRlhMRDMrZHFwU2FX?=
 =?utf-8?B?UGxPNTN6OXU2ZnBqUm5xbVlZaGhTWG8relNZZFJvRGJNZmpOa1hlNDhEckNQ?=
 =?utf-8?B?Tm5SM01NcGhwNTY3MnpKSHl3Sm41S2RHRE9FSm9PcUxhc3ViSHBVbmVkQ2hL?=
 =?utf-8?B?ZWZrUVRWc3RkU2F4dktSR0U0Q241bGoyQmhwWkkvbWxsQm9hUThBL1JjVzNx?=
 =?utf-8?B?QkwwWXllU1daUEFKdm1mV0FNU1lMNDRLYmdzWjEwOWdRcVR6ZE81WEpCd2wr?=
 =?utf-8?B?RDBvb0QrTG1pbmVrL1lvUUc1bVBJU21xSGhGcnp2UEdLd2ZEVTV4ZkFTblRL?=
 =?utf-8?B?YXM5ajFNQzZsWFFtaHZ4bWl0TkJOc1F1V01tUnZnN0MxdWpwUnJ1ZjREVE9M?=
 =?utf-8?B?T3FEd2QzTDEzUVdoNUQ5WXRoU2tVZXpoRmpWVWpMWWtrdWJVdUFMOGtoQ014?=
 =?utf-8?B?TjRqTTZrckhYVG01VkZ5c0Fidjlpd0V5VGlvY3NzVFZ6bnRld0dYeU5ObHp1?=
 =?utf-8?B?Wis5ZHJWTFE1Qnh4R3RwM0ZvM3Q0dGsxR3FjTnR0aVNZZXpqeStPQkJuZ0lk?=
 =?utf-8?B?aHc3YnpSRC8vOWljbmhvRVRrekJGSkdhSmwxclFCNUoyQ0JpekJ6NkRmRUxh?=
 =?utf-8?B?V2FmNjIwcSszanlSOXh6dG9xWXQ3TjMvazN4NXpMcGRaeXZDa29mRytWSVpN?=
 =?utf-8?B?UW42YlJZclE0QkRrRnNmUGw5UDJEVUo4SEUyUXVLalBkYkxlVm5wWDY5ZGpL?=
 =?utf-8?B?RnIxdWtMbVdqYnYvTS9UN2o4WkRwNFhMelJsbWdNOUl3WXZGS3djNU1sczJt?=
 =?utf-8?B?ZWxyUnhmc0lyQmdmakFRZGg1ckIxYnNWOENRZlRaVjdRcDhudENkSVBRQ0hS?=
 =?utf-8?B?anFQWHFyUjd6ZzNDUFF4UlVEM1NKTDRJYi9mV0ViQ2FySjlUUmlyS25CR2la?=
 =?utf-8?B?aEVHaXR2SE8xM0Q3ak14cC9xRFExRkkva2RJVk80Z2FMYlY3Q200d3E4dFBt?=
 =?utf-8?B?eVB3eENDQ2NTeENOVW8rVWFhTmZFN1hmRDBVaTFZT0c2bjlSU2cxOFU2eEJ2?=
 =?utf-8?B?NXJUUmx0WW9oMjlQSVI2MDBrNG1qditVVE9sL0NtWFhuUHAzQno1dHJpbEVS?=
 =?utf-8?B?VnVDVWNveGZ6NGJxNlpuVUd3SDZEY2tJTzVKWU9HZTZTVWlYM1Zmclh5Njk5?=
 =?utf-8?B?ZWQzL0dWd2J1THQvUU9LNmdkOUFUbEdia1RVcXNFdE1UdVA0NFhTMWdqaEhw?=
 =?utf-8?B?aElKSHE2NWVHWjBaeHpaVnJCbUhyMjlGNzVYbkFGU2orSU1VWW1UTEt3WGNC?=
 =?utf-8?B?SHVCbFgxeUdvcGdEbjdhMzFZRFptdmdyV1pUL3RkV1o1cG5aV3BaYTQ3bWVU?=
 =?utf-8?Q?5ruQaims5DT0QmkN53qsk4JMv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dP2SZ8kT7dvz6q3ARqTYPYEKYkU0dnL2zw6S11/Ks0P5ZgbW4Rbmr5VlOoaAG/eKLdC2bRMNCg7XYZYIEBOtq53kL+SIG69ccN/zPaXVGcWkc4xL/nqXKbrZs9699YkfCnda6umbBIx8P3KxWHBW1w5kM3kIcREhV1LLVCnfXc7D5jIOabJdrNvMKYlkkB5yKUKBT85o0sVAeTBqwe3iNM/++VEwcFrf4I81p+jx4b5J4+FxR6qQV6u+Nrv5ORaRSuTzbVCM6ixvlIXubj7iVPS6YGB0duI8Q+Z7VQNbQVb/Y3Hhw/a7+eeyx8wydWgANKwtOwjlDceTocBGL5i/k/EgvoNX1PRk/RbUi22HBfww6iLIAVFK+S0xNYsVCoYayKgqsSjQAuCE8EwbrVpougvspkGhTYptynmV9S48mb6jiN6lp+MuX8GavaNbRf4uLj5xZLArpartsMjUiOTxH/Pli5na5VjwLX/125pqChR10BetlOYZUUD5uOFbYxQ3hniG+x6TKUcgQajL1oZjQOupDqLiCUzU/9B69RtH9A1eIxFSjklAE+gpvVe1ZFrG5Ben3W5KsGkXI/WEXaLg4d5Jp/u7p/dhZY13aFBUZjw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d6a91b-575f-401b-54e5-08dc4f8784e2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 00:31:05.0422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FB5OETpmWSryXRKTOiGNRicNaEFMYQ++XOyaczqNUVDm0N9ElVqT+FEP+1Nbgb3IWScIAYJarSm0U/g5Lhq9Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_19,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403290002
X-Proofpoint-GUID: FDYpfkaBC88NH2DLqkNuv8DFcYa0pCwU
X-Proofpoint-ORIG-GUID: FDYpfkaBC88NH2DLqkNuv8DFcYa0pCwU


On 3/28/24 11:14 AM, Dai Ngo wrote:
>
> On 3/28/24 7:08 AM, Chuck Lever wrote:
>> On Wed, Mar 27, 2024 at 06:09:28PM -0700, Dai Ngo wrote:
>>> On 3/26/24 11:27 AM, Chuck Lever wrote:
>>>> On Tue, Mar 26, 2024 at 11:13:29AM -0700, Dai Ngo wrote:
>>>>> Currently when a nfs4_client is destroyed we wait for the 
>>>>> cb_recall_any
>>>>> callback to complete before proceed. This adds unnecessary delay 
>>>>> to the
>>>>> __destroy_client call if there is problem communicating with the 
>>>>> client.
>>>> By "unnecessary delay" do you mean only the seven-second RPC
>>>> retransmit timeout, or is there something else?
>>> when the client network interface is down, the RPC task takes ~9s to
>>> send the callback, waits for the reply and gets ETIMEDOUT. This process
>>> repeats in a loop with the same RPC task before being stopped by
>>> rpc_shutdown_client after client lease expires.
>> I'll have to review this code again, but rpc_shutdown_client
>> should cause these RPCs to terminate immediately and safely. Can't
>> we use that?
>
> rpc_shutdown_client works, it terminated the RPC call to stop the loop.
>
>>
>>
>>> It takes a total of about 1m20s before the CB_RECALL is terminated.
>>> For CB_RECALL_ANY and CB_OFFLOAD, this process gets in to a infinite
>>> loop since there is no delegation conflict and the client is allowed
>>> to stay in courtesy state.
>>>
>>> The loop happens because in nfsd4_cb_sequence_done if cb_seq_status
>>> is 1 (an RPC Reply was never received) it calls nfsd4_mark_cb_fault
>>> to set the NFSD4_CB_FAULT bit. It then sets cb_need_restart to true.
>>> When nfsd4_cb_release is called, it checks cb_need_restart bit and
>>> re-queues the work again.
>> Something in the sequence_done path should check if the server is
>> tearing down this callback connection. If it doesn't, that is a bug
>> IMO.

TCP terminated the connection after retrying for 16 minutes and
notified the RPC layer which deleted the nfsd4_conn.

But when nfsd4_run_cb_work ran again, it got into the infinite
loop caused by:
      /*
       * XXX: Ideally, we could wait for the client to
       *      reconnect, but I haven't figured out how
       *      to do that yet.
       */
       nfsd4_queue_cb_delayed(cb, 25);

which was introduced by c1ccfcf1a9bf. Note that I'm using 6.9-rc1.


-Dai

>
> I will check to see if TCP eventually closes the connection and
> notifies the RPC layer. From network traces, I see TCP stopped
> retrying after about 7 minutes. But even 7 minutes it's a long
> time we should not be hanging around waiting for it.
>
>>
>> Btw, have you checked NFSv4.0 behavior?
>
> Not yet.
>
>>
>>
>>>> I can see that a server shutdown might want to cancel these, but why
>>>> is this a problem when destroying an nfs4_client?
>>> Destroying an nfs4_client is called when the export is unmounted.
>> Ah, agreed. Thanks for reminding me.
>>
>>
>>> Cancelling these calls just make the process a bit quicker when there
>>> is problem with the client connection, or preventing the unmount to
>>> hang if there is problem at the workqueue and a callback work is
>>> pending there.
>>>
>>> For CB_RECALL, even if we wait for the call to complete the client
>>> won't be able to return any delegations since the nfs4_client is
>>> already been destroyed. It just serves as a notice to the client that
>>> there is a delegation conflict so it can take appropriate actions.
>>>
>>>>> This patch addresses this issue by cancelling the CB_RECALL_ANY 
>>>>> call from
>>>>> the workqueue when the nfs4_client is about to be destroyed.
>>>> Does CB_OFFLOAD need similar treatment?
>>> Probably. The copy is already done anyway, this is just a notification.
>> It would be a nicer design if all outstanding callback RPCs could
>> be handled with one mechanism instead of building a separate
>> shutdown method for each operation type.
>
> cb_recall ties to the individual delegation and cb_recall_any ties
> to the nfs4_client. We can check the delegation and the client to
> see if there are pending callbacks. Currently cb_offload is stand-alone
> and not tied to anything, kzalloc the callback on the fly and send
> it out so there is no way to find out if there is pending callback.
>
> -Dai
>
>>
>>
>>> -Dai
>>>
>>>>
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> ---
>>>>>    fs/nfsd/nfs4callback.c | 10 ++++++++++
>>>>>    fs/nfsd/nfs4state.c    | 10 +++++++++-
>>>>>    fs/nfsd/state.h        |  1 +
>>>>>    3 files changed, 20 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>> index 87c9547989f6..e5b50c96be6a 100644
>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>> @@ -1568,3 +1568,13 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
>>>>>            nfsd41_cb_inflight_end(clp);
>>>>>        return queued;
>>>>>    }
>>>>> +
>>>>> +void nfsd41_cb_recall_any_cancel(struct nfs4_client *clp)
>>>>> +{
>>>>> +    if (test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags) &&
>>>>> + cancel_delayed_work(&clp->cl_ra->ra_cb.cb_work)) {
>>>>> +        clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
>>>>> +        atomic_add_unless(&clp->cl_rpc_users, -1, 0);
>>>>> +        nfsd41_cb_inflight_end(clp);
>>>>> +    }
>>>>> +}
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index 1a93c7fcf76c..0e1db57c9a19 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -2402,6 +2402,7 @@ __destroy_client(struct nfs4_client *clp)
>>>>>        }
>>>>>        nfsd4_return_all_client_layouts(clp);
>>>>>        nfsd4_shutdown_copy(clp);
>>>>> +    nfsd41_cb_recall_any_cancel(clp);
>>>>>        nfsd4_shutdown_callback(clp);
>>>>>        if (clp->cl_cb_conn.cb_xprt)
>>>>>            svc_xprt_put(clp->cl_cb_conn.cb_xprt);
>>>>> @@ -2980,6 +2981,12 @@ static void force_expire_client(struct 
>>>>> nfs4_client *clp)
>>>>>        clp->cl_time = 0;
>>>>>        spin_unlock(&nn->client_lock);
>>>>> +    /*
>>>>> +     * no need to send and wait for CB_RECALL_ANY
>>>>> +     * when client is about to be destroyed
>>>>> +     */
>>>>> +    nfsd41_cb_recall_any_cancel(clp);
>>>>> +
>>>>>        wait_event(expiry_wq, atomic_read(&clp->cl_rpc_users) == 0);
>>>>>        spin_lock(&nn->client_lock);
>>>>>        already_expired = list_empty(&clp->cl_lru);
>>>>> @@ -6617,7 +6624,8 @@ deleg_reaper(struct nfsd_net *nn)
>>>>>            clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
>>>>>                            BIT(RCA4_TYPE_MASK_WDATA_DLG);
>>>>>            trace_nfsd_cb_recall_any(clp->cl_ra);
>>>>> -        nfsd4_run_cb(&clp->cl_ra->ra_cb);
>>>>> +        if (!nfsd4_run_cb(&clp->cl_ra->ra_cb))
>>>>> +            clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
>>>>>        }
>>>>>    }
>>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>>> index 01c6f3445646..259b4af7d226 100644
>>>>> --- a/fs/nfsd/state.h
>>>>> +++ b/fs/nfsd/state.h
>>>>> @@ -735,6 +735,7 @@ extern void nfsd4_change_callback(struct 
>>>>> nfs4_client *clp, struct nfs4_cb_conn *
>>>>>    extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct 
>>>>> nfs4_client *clp,
>>>>>            const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op 
>>>>> op);
>>>>>    extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
>>>>> +extern void nfsd41_cb_recall_any_cancel(struct nfs4_client *clp);
>>>>>    extern int nfsd4_create_callback_queue(void);
>>>>>    extern void nfsd4_destroy_callback_queue(void);
>>>>>    extern void nfsd4_shutdown_callback(struct nfs4_client *);
>>>>> -- 
>>>>> 2.39.3
>>>>>
>
-- 
Cell: (949) 378-1341


