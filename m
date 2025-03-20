Return-Path: <linux-nfs+bounces-10726-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D2CA6AC82
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 18:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49422176FA7
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 17:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84896223336;
	Thu, 20 Mar 2025 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AhASX4b3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h769CKvB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0B1D7E41
	for <linux-nfs@vger.kernel.org>; Thu, 20 Mar 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493216; cv=fail; b=QShSEh0Lp8F/LVP/0quk6LNUsWaZMVfJaFATTOs2vIdGx6M3Eqr8V99BgulMfJQrN1vf4TPbtjZyPEs7zdt6LGaGuJcFqu+6fGjgtm1XvR+1x3rfq6PWvo6lxbXyoBDYB649VzfP9sj4u9QkkqH468gAiRGwMFbbSoBvqUCAqIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493216; c=relaxed/simple;
	bh=5xoQMhg5aFehiooy/4o7lzAmb3axcg1gZ0a42EizZVs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pcf2zQ+OgvvognwRvZ0feG6sg7+RO3PGsRxL02e2OEdz713aSRP0fjj/UC55QGl2y8jXaYhIfb+2vBhQIhJWuvC3Pv6bjJTf+WbVleAajEOjrPMOMj2T55RV+vBFJPSrJTmGos1btXto2GZ9eAAUthxUphcTYQ4m186RiNiOPBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AhASX4b3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h769CKvB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KGiw03012313;
	Thu, 20 Mar 2025 17:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MD9BQ0b3R5hLRJPxnw3c/okKLHSnyuiei7R4A1vKjDw=; b=
	AhASX4b3E1y8usHPSurG9Mh+nm11y6hoh0OLbNPYRDnMCK55rUfb6JbkK9Gj2inW
	KFxZdJtUDIgCQHqRQZ3sxtBNH2C4+ztL6IxQx0ySs7F/QUdKqYnfesSxAtx7uuWs
	UkfkR86v8ANAYVoq2OwIdJy3xHwylHd0bT7WyjosfaebJGbTldstgoUlpeyfF8AH
	CJkt/p7wR40ildaW1RJcMg52CVWgtCXNgmtUqJCDz+Zxn1MqDKYZRUoIJNRFsaWx
	BlJU74RdLvG1isdzZNbYmUyLZ3DdmfgSZx22pzRYJpp0gHUJY7PrVLQmFdP0j4QZ
	yObDdUzUWRe0ppKWaYvVzQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1ka76b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 17:53:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KH0EA7022316;
	Thu, 20 Mar 2025 17:53:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc8wyjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 17:53:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4CyIHB8452n4lHCue25b7/+3+0+vIalNyaKkEoFPyCaYLdtl6XFhbfF21+LHZ9E05IK2vdqum96ypuCwN9whPskBuJKVad3MgAZWWgPbYF3fz+SCZcxBb7W69gkuWbTjlrmIvjHe63oYzY3dsLOHwX96eOt3wunyJal6YbxCTeJV9rOjXekZgmcqBKM2MqxGOwP6XF0Lmm0mvV9mpDe2VFxc8cxAXHBC6NPrsOpoOeRc+8g+IH4k6C8aTp0jjzA052mVpdpjTlTb9irPC0YReXzDf22RmHLcQ0Vx5cWmAAyc8abIr+qo3c7MNSlUldEEAqvM8fxEybq9P3WpUfjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MD9BQ0b3R5hLRJPxnw3c/okKLHSnyuiei7R4A1vKjDw=;
 b=gQu/gnPSsMy+TBdrlI9HKKWl5Kh5BkkzbyoA/wmZ04nPoTjrVF/Ml8IHbQ1yNNuDzXFWf8m4BauJ0noHT3gPc/2+2lT8N2Xp/0JB4zIsg3Rx5AJP3s64NK/ib6wiMf1KpGK4p1IPjm2/O4gqxTbgZdKGifvk7z3Xs5krOe7x9P+GPUb8X6BqQSjxyWJie7cwy5Azpey+rmxQsTAQOKB95CWoEKuy0hMx8th6KU7L9WRXM7OuF1/+l+hZ7jOnxOzTRFgT8hf323gZ7Pt79dNXUYOTz6Ty6G1IO7S2ciB77y4jwS9Im+BCCa8cN99IPMjuM7ed5oClJaMYuGdCD8Z+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD9BQ0b3R5hLRJPxnw3c/okKLHSnyuiei7R4A1vKjDw=;
 b=h769CKvBWwChTB9Njrz2+QhXg7zur0QMcG7mGb+plppotLP92DEYwZQSJj6jLRpm/CUfROWVB/c7hAyTqwRBQTaVqZbpj7VBfUi5F06dNWPLRtA3cQ9Vgsg2Tc0ZZd3hwqSHbuuHGR/OV5vXLxQOb07k7VTOh8zpwL2lGj7UZko=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7720.namprd10.prod.outlook.com (2603:10b6:510:2fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 17:53:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 17:53:20 +0000
Message-ID: <0750ef11-f189-4937-b893-a3edd2ef1afb@oracle.com>
Date: Thu, 20 Mar 2025 13:53:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD automatically releases all states when underlying file
 system is unmounted
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <543f93fd-3b5a-4e4a-b2b0-0a1b7e1e8361@oracle.com>
 <174242076022.9342.12166225816627715170@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <174242076022.9342.12166225816627715170@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: e0bb115a-13c0-4d94-238e-08dd67d819f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3IzZlJITXpuWFVQUi9mTXh4ZGtxcE5jVFZtVFV2bE5zSG12WFFnOVFpeDhL?=
 =?utf-8?B?WHJaMk9OeTdOTDkvVmF1NkZ4dy9vR05SZkhNa2Yyb3h6Y0x5WXRFTW9OQmFF?=
 =?utf-8?B?dk5wa1VlbFVUOFA4TThDSm5yL2pKMzBTc1hPbUN0enFIQ1UrOEFzZEZwTW1h?=
 =?utf-8?B?YjJCVGRqV2RUTmhpa3lHMzh3elR2SG1oYzlVVlBGZ3JtL0hPYkU3V1ZuZ1dU?=
 =?utf-8?B?ZkJlV1g3UVVsaW5IRFg0T1ZYRjRmSEhTNm1mVm9HRGdZbFNZcDN0MEdFL1RO?=
 =?utf-8?B?MFZPUTRvL0xnRDRUUmtsWitCZFdNMGZBbTRVc01rNlhVOS8xK2lRRkRwVWF1?=
 =?utf-8?B?d2JTcC9iMDRQeWVKeXdaY2sycEp6aXpOR0RGWHh4TnZjY0IrTVFpenJ3SEdV?=
 =?utf-8?B?ZmhKR2QrQ0xFSXEyUHBRSklZMFN0RFpPck5BdU03NHNudk1UWHZvQ2N1WklQ?=
 =?utf-8?B?MU44NDhuRytOSHZMZkkwaFdVWmNDSm1UTzNDYzZWQVZPMGc5Vk5HYXpFOXFM?=
 =?utf-8?B?TUZ1YjltNHo1YVRXSHRGbVJFOGZaVW1BRHRNUVY0VzE4eEV4dWJvdkllV0dx?=
 =?utf-8?B?S0RiZzJiSXhCblY1SC95OUkrOFkvZ0hSRy9XUEh3aWNzWGFCR3hTTXlIYlo1?=
 =?utf-8?B?NGFodWtJV0hCT0lVUmhsNlBsUnkwMU1jaDVIVkVKc0NoN2pRNytFVGpDd0V0?=
 =?utf-8?B?KzdSVmg3eEdFSXlSSmlodU9CZ2o0SVZEV0U0bHAzZnI2cnRMWWp0eHBGVFN6?=
 =?utf-8?B?dXdQb0E1d0VxWDNsajJmQjBlK2c1QzVBYXNVcm8rSUZCMWtLTU1RWFQxRGgv?=
 =?utf-8?B?dGJNS0Z4RFFYc0VkL3VCSVpkdFlNWHJDblBnazBCWTRjclVLT1ZFYVUvcWZk?=
 =?utf-8?B?S1dnQUYzT2cva09KU0xUcW1vZDg5QURFMXFwMUVYcHhIeWoyUjNsTlZlWVJH?=
 =?utf-8?B?WHlJSm5ldVE1T0RDUVhhKzBPdmZkZDdqQy9WWVZNMlZ1UGVVRGlhNUMrYkN1?=
 =?utf-8?B?VXJoQjlpMFVVN2JjeWV0aHFPWm9XekRZUGQ1R3FPbllWUjVGUk0rRjAwWHdL?=
 =?utf-8?B?RnZramx0RE9xZyt2dzJJOW5tTk5neHlxTHRQRkhwVTZCVlNwSnN3cm1wNmhw?=
 =?utf-8?B?aE5jd3Q0WTRrcUx4cHE5NWhmWWxVQ1lmemw1VkVtcFB4WWswa0NGSUt1alN2?=
 =?utf-8?B?Rmw3TThjUUhiNHlTL1VaTFVla0ZkaXprVWxRdEh3aUF1QXVVSDI0cXYrMFQ3?=
 =?utf-8?B?Q0NQbjdTM3Y0V09oUnhjM3l1dDk5bHF0TmtBNXk5eVpDZWY0U0hQaHc1U3JO?=
 =?utf-8?B?WjFOSHFUMGJJWmM4MDNrUjZJK0Nra0NVTXF0ZGZwbHVzOWxTY1JJRnZ3aWhE?=
 =?utf-8?B?VmlwbFBOTFdjcERwbFdIb0c5TERsYWtkaUpnM3hTcUIvQkVhdjVRYWRBc1BV?=
 =?utf-8?B?MTlSMlZXOXhRQjYxU1c0a25JcFRmT25FV1RaQUd4ZGNmN1hYL0FJQm5QS3hF?=
 =?utf-8?B?ZDV5ZnZmNmFkeVhWRHpqcnJxb1VUMjRBS0oreFFDd0JFbUJBaXRmZzNZMWVt?=
 =?utf-8?B?ZGVnZUwzUytIMnpGT0dIZUdOQ2RPTFFRODN3V1lwbGc1MXNYTm9Yd3JCZ0k1?=
 =?utf-8?B?b3hBTytsMHNrczdMaTZ2OFc5MGFWblNUMk9leHB0U1psWE43Q2xyYkJuTFhC?=
 =?utf-8?B?c1Q0ckczWnNlQzlROFBld0ZFU3BsVXIySnBRK3FOaHVDY3FoRlJaeUE1dW5j?=
 =?utf-8?B?NWppWU80TEd3bVdrTGZTaTRTK3dXalIxTS9NZjh4eVk4SzBPV1FDWUZpaWRR?=
 =?utf-8?B?TGhXeGIzTExtNmFHTlhwSVpqdm0xelNnbmJVK0p5ZHRabmlPc01xUlRYUkN0?=
 =?utf-8?Q?tWeJ1cKgoFr1R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXJ4eGFZdGJ5SVR6RmdOMjlaOTVZQjd3dERjOXhiUVJCYzNEVmxVM0s4YmdP?=
 =?utf-8?B?TmwvTVo0WThSWFdYZmt5MVkzTlhCejBXc3NLQVViSEFTUUpZYnJ2MXRpSHVp?=
 =?utf-8?B?UG1weVhwZnN5eDZIdUFXd3dmWDVTMGRRTWUxa1Raby9iYVE4RVlGYy9rVHV3?=
 =?utf-8?B?RmJVdFo5SmNWQTVwWUNtOW5tUG42WDFZMFVDYy8wWGUrWGZUN2xjNC9COG1M?=
 =?utf-8?B?N2NnNUxRR3AyTkc5ZGdneEFXajhLNkt4V3d4VHlLdTVKRlA2QjNEVG5HK2RY?=
 =?utf-8?B?WllxYlNFdTc3b1hJVGcrdHVUelBTMGFEN3RUWDQxN3pQRm8rMlRURS9qcmVi?=
 =?utf-8?B?b0U0Vk5YU09DN0RYUE9sRXozcnR4ZVQyS1NwU2k3eG5uZGJSVnc4WGs4d1p4?=
 =?utf-8?B?RkJoYWNmRGxRRHVTKzdUNHJhZlFHd3ppSmlNdXJXdFZzMDJUTEZRdnNKM3g2?=
 =?utf-8?B?ZWVkdE0rSXRoT3AxNExzdWw5NXRTdWFneEhvR3E1N0sxNllQdHFvbGp2TmRx?=
 =?utf-8?B?Rnp3Sm80OEpQYi9Od3V3Smp6VWl3Y1YxejFPZG8zTi9uYXBFY3pjLzRXSUIr?=
 =?utf-8?B?SXROVjkzZUZUQU93bzBtdkp4TXlKUFFnL3pHTUVORDZLbjN1bU1kT203OWRo?=
 =?utf-8?B?d0dLRDhzY2czdTl5VUF2RDc5WEhxbG9MTGsrTUlaTFNsWjRxeGxuRWIwK20v?=
 =?utf-8?B?L0J1Z1NyMTNRR2VTWm5jdnIzRm1QTmM0WlVZTUZ2YVFyNi9jQ0EySVp1Qmp5?=
 =?utf-8?B?cHVmQm9mNWVHYTJ1d3JpWGhWbC9XclliL2NtaUQ5cmNpemZudXVpZGo3aVBa?=
 =?utf-8?B?T29Db21OMUJ2V2lxRytFbnZtVEtacllyVlZUTmRha1gyV0dEcnR3MFMvK01k?=
 =?utf-8?B?WlNEN1h1RER1ZDF0MmdGWDI2MUMvOTJ3M1l6RExHMThqZUhJNDZNdVowYyt3?=
 =?utf-8?B?YnZUUTRsTXhhUlVaU0I3NUhKbStIeG1ma2FCendZNHJ6VlE4RjV2eGZvd3RO?=
 =?utf-8?B?N3ZXU3pXUE1heGEyS3Z5Y3VCSndKNDMxNjhFK0U1K0lsY3lYMXIzVDMzbjlz?=
 =?utf-8?B?K1V1eENhM004bjZqTTl1NmRTUFNmYkhLQVExbmFZTzlZNXV6UTZweHpVSnVo?=
 =?utf-8?B?emtveHN5SVJ6ZVh2bkdRa2w0UnJwb2RYL1ZWcWlUam9BSzlkYjVNdm1UOVFs?=
 =?utf-8?B?VzhMdG5HRDRVdlhjbTlrN1lZSVR4M29SQWR0STBlRVRXbTY0QnVHdjZMTnNx?=
 =?utf-8?B?UzN4ZEhUWVdJMU1BWHJXa0gvQ2xSa2F6WFJLakg0NGJiaHdhdCtIUStiMEpL?=
 =?utf-8?B?UWQ0OTZUb2s1NWdra0VyaXlzSTBIV0diVHdSVGdhcFVJWlYxZ1NIRUlZRkFs?=
 =?utf-8?B?blZGbC9hL240TnVYTXFGemZvT3BraTNTRSt0dkFQS2ZuaW1JdTRMZ2ZSWVM3?=
 =?utf-8?B?Z3loRnE0WW9FM1ZVTXdyOFlhNVF5aFZ4Wi9vcDFXQWVrNmVTcnlrbjFXZXBz?=
 =?utf-8?B?SW9OeXlqbEd0VWNpbFF2VG1OZmZTWmNqMmtzSTRyUE95L2Nac0NBdXFUSy92?=
 =?utf-8?B?Um5sdTQrcnBWUTF2THZKRndwUkM0MWVPSFVXcGtQQ1VVaWNOVnNXUXdaWDhV?=
 =?utf-8?B?VGdGWjFmbXpzL0g0KzNCV2ozZHBHQ2pLdWMxa056WWhhYkxkSHlrVDdiZkRD?=
 =?utf-8?B?WEFTSXRMMW5jdTR6b2VFNG5WYnpsNDBGMTU1eGdrNEhyUmtZR3V6Q2hQV3dn?=
 =?utf-8?B?WEdIbUJmeUNFckJwZG1Eekp4T2ZOczZEWGJxRk8zZnpMcWplbSszdGtWMFYx?=
 =?utf-8?B?VWozaDhibHU0NXVtRE4za01aTmpmNjhZRWtCeXplcml0OExlZW5oU0c2aEhM?=
 =?utf-8?B?dkl2OE9TZkZzK3lDZlY1RFgvUWlOZzA3NXI0a0IzOUhFaThGTEtFMzN6US9B?=
 =?utf-8?B?R2N3WEh5ZnY0NVQ4Tktmd0wvZGlyWHFXTzN3T0tNQ3BjcjlvaXRWM1oyUkpB?=
 =?utf-8?B?a2RuTWw0WHVIazFWT1NiZnBjVnhLeDJIK2Q5bnZuRDVvRDhyUFRVSjd0YVhv?=
 =?utf-8?B?K29zb212ckFNdVQ4MEN1V1A0bmdNQkxjdG9YUXRUS1dqT0IxNTV3bkwwSFF1?=
 =?utf-8?B?cCtXRno3Z29vT3ZFbWxYc0t3NEc0RGw3MGtuN0o5RUtDY2xNa0pkU2U0WnE2?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cmB+xEU+9m3RV68/lCUTlL6Lbnv5FPRs0jmK1x0J6dVApO2CaYd3xb99wDw7rtP8kPC4dFzJ5uAMQfYkNbzdcLC1YdAbq9hIMHElK5HtObQqV31QJn8jaA4GT4fz60CuHfWAg5zoDgCz5gGka4hN3QcW+3gUdNTFZAvb8gZ286/xpQKrFIo/GruhXh2bBvG9ixA+ubTO6wVpUdUTqD/xHi8EcHxx9WihtJNN1vw66yAoFuWQBxSHngi0m3r06cWT92le9pDktJ+4tySSSL/zM76DPwWpI5Jsqfd9s8Fh8L+GY2axWHTM8+qcB8fr+4mLyMd2iKj8uwbNEo/jAt7UR0woRfXBwZI7y4bxj8N0PYtkXVZrviyUAUuRiiyTwgvXEd+Dh5s5Smey+z3Z1TZSX8BA6bdKV48pvZtZclmyTfXZnJWndo4OrmTp2sLgKYOdw9stbXKWMcJ/xGdW7eznACMayZXFJvJtyXp9//lqVTsTtnl7z6QwxX2FsAuJOHDRa5cnLgS0etkOU0XY9zW8Dy/82ibD35zayZRFW0M0Uui3G5MQN647uiMRRWtLzhuyjvyBOZNwKqRWbZl8/x5Bki8YfB8X/oN0ZdkMKTO4FZk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bb115a-13c0-4d94-238e-08dd67d819f5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:53:20.3935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPZ0RIrcJ3sM5fVqSFwLme7MD4g47LJKQLe3aHct2GzzFRLHesXhnj77L0KDVRul+u7vhND2lfaTPXwZcamr/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200115
X-Proofpoint-GUID: M4O65HmlZdtYyaHccGE7nS2hffLI9BtV
X-Proofpoint-ORIG-GUID: M4O65HmlZdtYyaHccGE7nS2hffLI9BtV

On 3/19/25 5:46 PM, NeilBrown wrote:
> On Thu, 20 Mar 2025, Dai Ngo wrote:
>> Hi,
>>
>> Currently when the local file system needs to be unmounted for maintenance
>> the admin needs to make sure all the NFS clients have stopped using any files
>> on the NFS shares before the umount(8) can succeed.
> 
> This is easily achieved with
>   echo /path/to/filesystem > /proc/fs/nfsd/unlock_filesystem
> 
> Do this after unexporting and before unmounting.

Seems like administrators would expect that a filesystem can be
unmounted immediately after unexporting it. Should "exportfs" be changed
to handle this extra step under the covers? Doesn't seem like it would
be hard to do, and I can't think of a use case where it would be
harmful.


> All state for NFSv4 exports, and all NLM locks for NFSv2/3 exports, will
> be invalidated and files closed.  NFSv4 clients will get
> NFS4ERR_ADMIN_REVOKED when they attempt to use any state that was on
> that filesystem.

I'm wondering if this mechanism also flushes courtesy client state for
the file system that is about to be exported... it should, if it does
not already take care of that.


> (I don't think this flushes the NFSv3 file cache, so a short delay might
>  be needed before the unmount when v3 is used.  That should be fixed)
> 
> NeilBrown
> 
> 
>>
>> In an environment where there are thousands of clients this manual process
>> seems almost impossible or impractical. The only option available now is to
>> restart the NFS server which would works since the NFS client can recover its
>> state but it seems like this is a big hammer approach.
>>
>> Ideally, when the umount command is run there is a callback from the VFS layer
>> to notify the upper protocols; NFS and SMB, to release its states on this file
>> system for the umount to complete.
>>
>> Is there any existing mechanism to allow NFSD to release its states automatically
>> on unmount?
>>
>> Unmount is not a frequent operation. Is it justifiable to add a bunch of complex
>> code for something is not frequently needed?
>>
>> I appreciate any opinions on this issue.
>>
>> Thanks,
>> -Dai
>>
>>
>>
>>
>>    
>>
>>
> 


-- 
Chuck Lever

