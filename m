Return-Path: <linux-nfs+bounces-10698-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEC0A699B2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 20:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545783B5FC9
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Mar 2025 19:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054D721148F;
	Wed, 19 Mar 2025 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M+2vd+VG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xiVpua5Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C21DE884
	for <linux-nfs@vger.kernel.org>; Wed, 19 Mar 2025 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413473; cv=fail; b=hy0MGpVt+FyxM0tY4jGoCnfzbZ84jdX2B0QcrxOnU2o07FaGJE8qhoqHKpMpDfPgL/h6TEsBtpHO6lhK0CYHdN9DJWaQ0fF68FqXU255ko24by4pd6w3iGPJ0rqsHDGwj1zRem2x2id0tZ8U3drbboOdw0sSQeINt/1uGClx4Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413473; c=relaxed/simple;
	bh=G9xa5OpAbjd2kR0BUuzB8LgELDy2VsgVJI8hCT/OM7M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KgLyVfqsnubzQ9oBh+muTHssaObMumn6sFMF7nhVjmrSLJHNBK3kS8SkcTj+DEISArk+M/ioQNNLxMPxtFmczN0cIjZFA5ysZPdCVFg05bnv6L+zPp8cuqtkN9s2NJ2abisYSXeI/o2v76gTy6XfhFcclcQadvdsdbbKVSV8QX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M+2vd+VG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xiVpua5Z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JItkXY011227;
	Wed, 19 Mar 2025 19:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=G9xa5OpAbjd2kR0BUuzB8LgELDy2VsgVJI8hCT/OM7M=; b=
	M+2vd+VGxoHijH7EqOqbzlA9D11xkoo8PT0c/x/VQYKnBetkdTAbOci7se8uU6xe
	Aneoh1U/fW+Yu5HWrrFuBIvSYS2RYrFszAVA4zuapEElErGC6DqrTgnU644e3Xn/
	+UHdCgoSC3vsi5bCXU1d9m1JuXePe8A5sTXoVAz99TMtitIssdbEOGJkdWzofMiz
	DNImOa+so4Qu7NYnEMffrJz1jQGDOOaK+2MhzDUJ3tesScY9FsQpB2Z+z5tHhOKj
	L0lCQs1ZTHxlfEy88Njssk+oxbhWrFrSvE9nQesvNGyvAU/hPaO5WJO1x/CWFOn6
	HTppGhtQ43HfA8TOae5ahw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1s8vaku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 19:44:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52JJYKOP022411;
	Wed, 19 Mar 2025 19:44:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxehbfp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 19:44:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEYcCz+RsigQo/AE0P6AwhY7As4Fwqb99lyn7n4soO23h8zooHl+jhIkjKs8MkXbyMkoKdqwB5HVlRt28zlz9x9PypeBU50D/fb2m6PA9akpPWhxdF+LsDnCRM4uRFpJYMIe41Q8rFkloHK3RpkNmmIVL1RxSxMYooB5a5XnIEyU04sap333UX48xdRYJHi8ZBNFlH7qWeYKziPrs/ccOL1f8WIW8n8YAK3VlcDz4uid+CcvI/hoX5MhhG0WMVJ53Uf3RFRYV3j8zKKfYTYv+3dFK1b8dKQKzo16qKx4qKQhg0Rl66xfmz99kTTE7W0jyEI9f9MEPUwjKh9AY07vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9xa5OpAbjd2kR0BUuzB8LgELDy2VsgVJI8hCT/OM7M=;
 b=NdqA/HSxIqP2INYYGJE2xrc3gYX1n3KvXnsTslgv4y1CmH9daNGYWsaRKBk7HIdQD1FrdCjlzFQuPkJ42aNmma2dvMZA/GNbWWKNAq+oBgcIbkkU0PlbliH0RFQMjpTX9kTrLc3IoUTZi4ZA80TBzuRJJMTkdasoE7MrYJrXNemCpkcZkVP/plXYoIrpwW1IJjs/4y8/TvP5QS8YjwuEAfIXhlFd0Rds/Txx9/mXYfJCInDclF9Ak0+2Ly2BFxXrfqU6HfE6BAinLrkR4x3fZlDh+4lzVILaZLzh1Q8WEw+10WBx2KhzjXfnXg7Od6ym0/8ri1gR0yS6uv0oYfcWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9xa5OpAbjd2kR0BUuzB8LgELDy2VsgVJI8hCT/OM7M=;
 b=xiVpua5ZFQqUBNN3sKjNhGEGFiAA53F47+zcgssWxA6e3yLEhff/s/qcPyFcMehN5vYudfQTDh5Sork7JuHG1ngkZyJtxDB9Ni4yWxclGTug3vRBdTmBY9gsPXZQEUnvyuz0ufiR7mbAz/5YG4zv0YfNgWTFMumO6NWM2yomhp4=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MN6PR10MB8118.namprd10.prod.outlook.com (2603:10b6:208:4fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:44:19 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 19:44:19 +0000
Message-ID: <bb4bfbfb-50df-4578-ae26-83b9d16e150e@oracle.com>
Date: Wed, 19 Mar 2025 12:44:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Tom Talpey <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <543f93fd-3b5a-4e4a-b2b0-0a1b7e1e8361@oracle.com>
 <37313734-890a-4ab6-a2f8-0ee5668c1298@oracle.com>
 <ba129a50-a4cc-4294-94bb-c75b13454e47@oracle.com>
 <e2b24cc2-c135-43d2-8c21-8bb59a723c5c@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <e2b24cc2-c135-43d2-8c21-8bb59a723c5c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:a03:114::29) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MN6PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: eece8a44-5dff-4df8-ea9f-08dd671e706b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHJtYXFrMzBVYm9IRWlvVDFYalVEenJwRndWdW0rRjJqS1o4UkMzY2VST3VC?=
 =?utf-8?B?emd6bC8velV6RXI4OVkydWZSWWRrKy9pY0Mrcm5xK2hHcGxiVkZ0R1FDbUQ4?=
 =?utf-8?B?bmd0VzNKbVl3aCtaUVJJTW5XUUJTWlZtM0ZQYUpWUG10Vms5R1ZnUUpDQ2Nu?=
 =?utf-8?B?SGh6akNGWnpMWDJBaUtVZldmQTIweXRQTVhNQ2RsM2l3ZXFwbHgvWG9iRy9h?=
 =?utf-8?B?d0Q5c3kzc1VaVzJsaUcrdmxPaXA1a0s3NVF3Um9tMEhpaHFjM1ltR1pDdnRs?=
 =?utf-8?B?TG50NUJVTldsNS9nVW5nUUJFQXRmYVNLK0Uvclg5V3JGVUJUSFJ3OFFrZVh4?=
 =?utf-8?B?NmdpUXhsQlNpdnpGcXJRaDJGQWhteVFUNzRTUWdjaEhOd2pWK0YvcENLWWM1?=
 =?utf-8?B?N1kxT1l5YmZHdU5ocTgrbEVuMUdPcFl0eU1VMUhKelVSMDBhMUh4M0QzZW5U?=
 =?utf-8?B?OGg1R2YvWTI1Vkg1Q2YyMEd1NkIxNGFFc1paOU9QM2NoNThIQlJzQmxvc2hI?=
 =?utf-8?B?OExhQ2daamJZbEV2QU41dlcwQ0FUWnNYSGpnM0l4R3ROOERRMHVhQTR5VHBh?=
 =?utf-8?B?R2gwU3hUbkFnMWRrQ3Z1RVZvOGUwMy9PdXo3WWJaeG8weUNSZ3R2a1p2WmdB?=
 =?utf-8?B?dUFiMVl4S0lQaFBTT3kwUnlwL2kwU2FJTVczekJkaUlVUzNJUGVhYWprUS9l?=
 =?utf-8?B?NHZKb1ZpbTRqKy9FUDY0WTJKdE81M0tBU0hUOTFkTFJLU0pBMHd1M3FmOVVj?=
 =?utf-8?B?S09NYzdOeE12SUxGUUx2MzVIVEkwK01vK09PN1dML1dIWmo3UVN0ZEllLy9a?=
 =?utf-8?B?Y2RGRUdnNjNMcS95NDlkRUYvOEdUSGhPUFpxVHdTQUtsQTB0TGJsZGRrOHM4?=
 =?utf-8?B?cXVjbEVNZ3lrakhaZER1Yk5ma1gyYm9INThTSmNhS2JYRFlxem5kWnE0S2VJ?=
 =?utf-8?B?UE5GeEtsTDhsYmxsZGl1ekhCSjEzbnFFUkRZN1k4aGkvT1hxcXp2bEp0cXZQ?=
 =?utf-8?B?Z0ZoS3FTQXBOM1pOamlvd2E0YWJsTyt0YTdya0g2aXRyaHRWY283NjJVZE0v?=
 =?utf-8?B?VG5seFlHUUp5dW5WSExUZHFveEI1SXJJQmtCZHBGOVd1L1RSSDhWWTZLMzZD?=
 =?utf-8?B?cFlEUHl5b0c5RTdnK3hCSVBsVWh4Y2xxbWpNS0htTVZ0dytrUXBORTl4dnFu?=
 =?utf-8?B?OThYVVo5aUpiS3E5L3IwMXovMUZuUkhySGdxWjBMTWtkNG5oYTViMUZKMGJ1?=
 =?utf-8?B?WHNOWkhZSnluWFltdlE1cXRtbGkvcm9JQkE2VGQ0YjZ5VG9XOU9sRmxPV3VI?=
 =?utf-8?B?d0pXVjA2cVpQaGFzMjQ2dy9qdmY5QVpTQ0tlcWZwVDJKKysxMnI5anBmdlZ6?=
 =?utf-8?B?Nm53SGl3NnpSNzlyVzQzTE9ZUzNId1Y3cU5WL2NxOHBmOUd3TzA0RlU5bUFt?=
 =?utf-8?B?Wk9aK3daNSs2MVdpWUtWQjJPSWM5dEdQWFQ5b3ZhWWMrUFd4dWZjcWQ1KzU4?=
 =?utf-8?B?cENEaU1od084YVpjYWZhQXBSWmZ3WGpPYmwrMGpWSllyNHRoK1pNUldvMG5H?=
 =?utf-8?B?TDVHOG5JNVkzSlBHT25JTytHbEYweWpxenJrTXR3OVBHYVJpMU9pQ1dxZXE0?=
 =?utf-8?B?ZlBhUnNnWjkxNVRzeWdmV0lBdGtteFY0alpsdjVZVzlnWnNPVjJ3RzIxOUFy?=
 =?utf-8?B?M0RRS3hobGJPekl0TEV1RzZrWUlXOFIvQ2kyRzZjM1NrczRyM21XMysxVm1N?=
 =?utf-8?B?dVNpRVIxRXJpTFJkR3I5SXh5M2E4TGRhQ1VNZ3RGT0VocnQxTzI0UzFCb3Yz?=
 =?utf-8?B?L1UwRVJlbWQ0YWFaeURacCtmcjRxaFo2RGJwcXppWmFOeFByUDZsVUx4ZG90?=
 =?utf-8?Q?A1BLMFURaoIul?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bExSbEpOR3FnUGxyKzU1bFMwcy9UOEdBcVZBd251aU9od0FiSTJNM2d0bW9k?=
 =?utf-8?B?SC85MDcwWHNvc0IvdzlZUUZsZ0w2ZWxMR1crVVJ6S0h6bldLSzdsRlZ3OURS?=
 =?utf-8?B?eFNwQXc1MGZFbnVqRzZ2KzVSRkx1UnhCaE5lZ2pWYkR0bjVBOXZUOFYvdVF4?=
 =?utf-8?B?VTRjTmZOUUdtYXZPV3pyZEVURThOTVlCVksxZ2JJN2s3OFhPb2NLVkRPR0tG?=
 =?utf-8?B?Y2FpZUpyT1ZCaGg3NEtEVWFONHRncHRFbi9pL3RTSmxXU0s2b3plTHRjZmVE?=
 =?utf-8?B?Q21HWWpJMXZ6MkFLMXNweFIvOUlwclBRSUVBcGRvQWR4THd1N1RiRG1aZjZ3?=
 =?utf-8?B?N0liUXBFZXJBQVBsbTNQSVR5M1hsSWM4V3pPM0VnNCtJdW0zOXFyMENYdVBR?=
 =?utf-8?B?Q3A2Wkp0WCtMWldPUkQrZlQyRTdGQU1JcFREZVlNbE5XektTWHNuLzlnYk5R?=
 =?utf-8?B?WUozZlRET2x1dWlreWcyQkJtbjJOQ01FNHZGdnVkaWtxclp6SlVlb3NpM1VD?=
 =?utf-8?B?U1FEL2tUZ1VpcTZrZnZVZDFGazVUN0dDakxzRW96d3owRFJmZ2FLelkwS0lN?=
 =?utf-8?B?VG83cVFsSksrOVRLbi81UUE3MUpQMDNWWi8zOGlUV0kzTDQvZDlGZFAvb1pr?=
 =?utf-8?B?SXc4c2VhV1dUMjdFNXdEQ2FiZDFncnNiaUVwL0RSa1JSSC9QV054K0dzYjhl?=
 =?utf-8?B?ajY4eGdENlZSOWYwSTBtaUtxV0V5alVZZXo1UlNtZHdQRnBqK2lkR2tyem1B?=
 =?utf-8?B?OFZCWE9RcWUyY3hXa3ZVazcyeUtDMXQwTFFOWXlybUtpRUhLbi95RnNIc0ZJ?=
 =?utf-8?B?SE9sWEg1dnNJYW5pR0xhTkVJd0tjUGhjUTRkN3phYys5QzVtcFA1US9lYXp3?=
 =?utf-8?B?a1ZaZm41ekdsM2dPYXlmSmRzNUNYNk5TaXVjK1hibmU3QkVNS1Z3bDE4MU5I?=
 =?utf-8?B?ZGFOS3ZIKzAvaVBQWjFXNVEycDIvaFp6TWdqQ3R5QUI4eDJwTSs4NTFWNXgy?=
 =?utf-8?B?MkdhSTROWnlSOTFIdDhLSlRnY0dIY0JwSjI5MTl5ZlBTTnpHdFJUT0tEdXNW?=
 =?utf-8?B?RFBUS05TU0hhTVdlYVhIRXJNODZUV1dpT3M5Lzc2aGZUMU1wVmpLTmZIVWhu?=
 =?utf-8?B?NTFOS0wwRDUyMWcvUUJJWjFtZ3JmUjRqeGFHVERFSndRdG1hMzA0NGxic2wr?=
 =?utf-8?B?dk1NR3c5NHkyNGVuSWo5akpGRmJwTnNaTnovRXdsdnA1THBIVkZZL0NMM3RM?=
 =?utf-8?B?MVJJZU9QUEpEU0VPRFI4YVFnSzJDb21Qb3hGdWNIUkR2ODBkaXhIT1NiZkp5?=
 =?utf-8?B?Q21abHFKcFk1RWlYVmRMRjVGcHNUZVhNZnpweHk1NzkzREl1cDh2N2Qvcnkz?=
 =?utf-8?B?R2xpN2l0SXV5ZjYzY2pmLzhhRytZSzNxUkFwQnNYVzhaNEhlWWpiOFIyNXAy?=
 =?utf-8?B?TGNWbmZpa0Rpcm12WHJxWTZXU2ZkMDdLbUk4MWRFSURPQVA3bGZoMzY5d2Vk?=
 =?utf-8?B?cDk5Z09sN3BZV21DQ1JaVWREeU4vRDZEZmxqdGN1VEViZmhNbktQbFdaQllF?=
 =?utf-8?B?azlKSEd0OFU2cDdKbGhtRE0xN05NSHJsR2p5QmZOUFZYWFVPN2c0RWdHYkk0?=
 =?utf-8?B?ZUVWS000NFBZWWM0YkNNbzk3Q0QxNlhzOGdjMmdUMllpNlZqY0EyU1hZOG5Y?=
 =?utf-8?B?ODZLbzVpWWNDMXBpSm1Vc3k3VDltbkt5N01qMTBwK2N0TTh2WlBpYkFFMTFy?=
 =?utf-8?B?aUpPNmpsMHFLaUpwb3o0QVhJS1VxTmxNclRqbmxJSWRhQS81OEd3elVjblJl?=
 =?utf-8?B?WHNXdUZrTmpOR1lYWDdRODhJNU4vSTZKUFV5K1dnMERzazllSHNDcHBWa2VJ?=
 =?utf-8?B?bFhGVGhkVC9wdGV1emUxSldxZlozTC9TVFhrUm5OMzc0M3pFYWFWTUV6SE9y?=
 =?utf-8?B?eUhjL3lOaEhWZVYvQVBxRmRqbkZlbm9wR2tMNEdRbEZPSGNsU29PWkdqSjNT?=
 =?utf-8?B?ditZT2lNVi85a2Q5Z0s3T0h2Y2Mxc2xRWU42L2VyM0N2Y3dGVm9Mem5KZldZ?=
 =?utf-8?B?bHNwaklHVm1ZN0xPL3B3M0JTYk5MK2U5QWVhNkVKMW9uOW1xOU1BdFBzSlh3?=
 =?utf-8?Q?xAzXvMOVxNzaWQU4Gd5AJJq6N?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DbW06FDElDnppsxFPOOajmHkTjSXDyfiUm1lMRKV4HT2Vf1ovqumZyytpyHj6FMYEWdNvvDBZHd/1zWNON7vawACsMIVowH7ey7YVogYgQRwguSFw7752zSK1WmZJkxo0ufbt7YDxzrBUfove8RsRyIA/XSdc0E7LYLAWV/iymdY15xZWFeqQWbWNA6NE/n3jaef0JysOfLH2yH5lTNDXN+d8xehT6U/OZgjbkPOpfX4LuxCb1L+snwlHv99BJWNfYk1yYwPO0+PrNV4aHGl93pB6ln29tfNaKTn2J2xSfSJ5dk3QzphbqSk4SY2Vy4lr4EwTtR5HD8YIjUupvnB4cI96sSnlGamaecBFJbNp/kHw+Vh4vuwuASlOmLGxS8FVBW1xDHPE8KzO0sXv51Z4uL3Y2H4zT6k23QAaaMPhosDBW7FgfMYCMJw0BTDNfW8ym24Kypxn83IwVwOjQh+FjUzS/lJ2kO/9d2Sw7FXI1ljmsMMfpUn7B9DoABJucZNMXNhMevUK9vuiUUS1uIr7o7XoDVXgFj7/swUY32kuPiDCSyWyv+oL7v4DHAKuzKjQrNl5W6phGbW/8boA2GJg6V1SJSRYurPSE+4dmowohk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eece8a44-5dff-4df8-ea9f-08dd671e706b
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:44:19.0675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acwUrJ7PY4LVklURORLPsJKgxWzAbE4utLfbQg++ncD5jyJq/8LKq2CjA8FpGX0SprB0o4Dm0OAXRCCacU3vxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_07,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503190132
X-Proofpoint-ORIG-GUID: c9BGs4SqYcUVcqTRxmn6QuRqBjsaCSlH
X-Proofpoint-GUID: c9BGs4SqYcUVcqTRxmn6QuRqBjsaCSlH


On 3/19/25 12:24 PM, Chuck Lever wrote:
> On 3/19/25 3:00 PM, Dai Ngo wrote:
>> On 3/19/25 11:28 AM, Chuck Lever wrote:
>>> Hi Dai, thanks for starting this conversation.
>>>
>>> [ adding Mike -- IIRC localio is facing a similar issue ]
>>>
>>> On 3/19/25 2:22 PM, Dai Ngo wrote:
>>>> Hi,
>>>>
>>>> Currently when the local file system needs to be unmounted for
>>>> maintenance
>>>> the admin needs to make sure all the NFS clients have stopped using any
>>>> files
>>>> on the NFS shares before the umount(8) can succeed.
>>>>
>>>> In an environment where there are thousands of clients this manual
>>>> process
>>>> seems almost impossible or impractical. The only option available now
>>>> is to
>>>> restart the NFS server which would works since the NFS client can
>>>> recover its
>>>> state but it seems like this is a big hammer approach.
>>> Well we could do this instead by having the server pretend to reboot for
>>> only clients that have mounted the export that is going away. That way
>>> any clients that don't have an interest in the unexported/unmounted file
>>> system don't have to deal with state recovery.
>> Is there a way to restart the NFS server for just the export that's going
>> away?
> There is not a way do that, currently, though it's a feature that has
> been discussed for years.
>
>
>> How do we specify an export when doing 'systemctl restart nfs-
>> server'.
> I would think that the emulated restart for select exports would be
> handled entirely in the kernel, and not via systemd.
>
>
>>>> Ideally, when the umount command is run there is a callback from the VFS
>>>> layer
>>>> to notify the upper protocols; NFS and SMB, to release its states on
>>>> this file
>>>> system for the umount to complete.
>>>>
>>>> Is there any existing mechanism to allow NFSD to release its states
>>>> automatically on unmount?
>>> Can you explain why you don't believe unexport is the right place to
>>> trigger remote file closure?
>> Yes, unexport is another place that can be enhanced to trigger the
>> releasing
>> of all states of the export that going away. For this to work, the downcall
>> mechanism between exportfs and the kernel needs to be enhanced to specify
>> the export that is going away. This approach would eliminate the need for
>> VFS involvement.
>>
>> Currently when 'exportfs -u' is called, exportfs makes a downcall to the
>> kernel to clear the cache of ALL exports and not just the one that going
>> away.
> Clearing the export cache is OK. That just means that new client
> requests will trigger an upcall tp repopulate the kernel's export cache.
> That is a much smaller bump in the performance road than a full server
> restart.

It's not just clearing the export cache. Since we do not know which export is
going away we have to release the states of all files that using the exports.
Meaning all NFS clients have to recover their states. Perhaps this still has
less impact than a full server restart.

-Dai

>
>

