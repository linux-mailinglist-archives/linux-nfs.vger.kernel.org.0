Return-Path: <linux-nfs+bounces-8949-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7CBA04755
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 17:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4931888BD1
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F13519CC05;
	Tue,  7 Jan 2025 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Is5I5g5w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gUkWR7HI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C8215C13A
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269017; cv=fail; b=drYlsQaFGM+gfjGpZO/0E7Ya5ZQtrDbSJ/5vjrZ8JzH9PYs5qo/xeMFf2BvHme6dcv2aLh82oYFlJF2nCJBjk7bPxkjfs9B4s22/U9cKE3k40hNuGR1b9A0X+rWaNGvzfzV/ktN9icxbMNfHJr2cp4cYvvqzw08cSdsTrMbQsNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269017; c=relaxed/simple;
	bh=jUL9tOTNWq44Ic4s9oeZo1b4dfbVm/rPOoSUgSC1P4M=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iOC+7S5WVIhWMQU/AIC4/L9oozZxS5bp+LxvxAR8lhMbc5RM+tXAl28cH71z/5Hi0iccUUsHGsJ3W+c2NqkXeXI6dIoRUWcUs/jCuDwmy8XszrQ6jCXnL6jlXAzHY38LIFv39srcTtTLBkxozS/cVeH0QHpc3e3tkWKVWq9MVS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Is5I5g5w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gUkWR7HI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507Gtn8W028002;
	Tue, 7 Jan 2025 16:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=j4xqYN30BGI7geC3wv1hFDPH9Yb4wkjvcuv/cmt42Io=; b=
	Is5I5g5waAnQqL2xINMHPqH0cgmChRs3459FL/XzA1M/J/FcfRq/U+sbn+si9DE0
	uF0yCPhAFnAw35VGjp8pFWhOztLG32nzd49bb6GQYr5QhiK9swPpnawtHWdJmBR5
	oR4GomiRCqlZjwMPGIOsrM3exq8F1HXtw35Wk7DbNNJqPjQWR0SocPWzFA8Z5Wyf
	zrDbhbLIVoAUV7N3Z9QmRPZc0FmSp7LXrAlyx2/frL94rCmrljVVhBm+QOjn2vCI
	NOmRgqLA3eknn1YeKYE4/egzhk7BSM15ZR34esB7sYKKuQSjljmKqdlOK4YN1+gt
	jqKUZCQghrQMcdSlTDAgMw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk05f0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 16:56:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 507FVsvH027484;
	Tue, 7 Jan 2025 16:56:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue8yjts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 16:56:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haaq8HwtAEF2ayHlhv32TECI8Zl3yiUBMcFUJRi72Ea+1fly0gKl1gTC5p3Nxhj7a+w/bNWM7QUBM3aa1UrEM3RFLrnJIGCdIXgM16VMVt7YXgQ8IE7g2seLBx0sgYtsDpU3RoN1qOXW6etlemrRsruNyF7o2wxFX9ciMLtTCnjihCBnmZsbzSCeaeOlvMKs7dkCmjPn4z7fu2UWQwa+S2gCsP6yPmFUNs6crQjZiVauug1u6MjnvU8i/eY8MSEjmotbg7M/VujLfidrAmPsZIocStQZR8hBeB59T8L5XV19Uy9HShNxxXZ4U3sQDO1OIYeMO3/wBAmpNxAyYHeJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4xqYN30BGI7geC3wv1hFDPH9Yb4wkjvcuv/cmt42Io=;
 b=akVeeeMDShoplZa7h+ZRgCcj3wwvQ3/poynEJurwBPf41/uvEY1zrd1TRyOg2GghzpQu+F9LdO2wGRB1b6ahIQ15WwxDxxQy17VxuFfa8ysrE/3cwRapgftF5JKs0L02j+IaMUj1v6mlU5TD7OJ0CvJnmsoX1YeQmEhSfBdUrwctXrUxwMA1vzxRLZnBsyZDFJG1lZER+q5dfOdySV2ZyXImPnUKgNCuk0Hn/90kgPuviL6Wdlz2e/CQZKCLmRB4w7Vz2v0a2FveapbnKAsLS+23bUN4Epf/2/laJl1pZXlUI3db8flqnwje1lVmnoOfioKznm07yjZfoVyb2Upg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4xqYN30BGI7geC3wv1hFDPH9Yb4wkjvcuv/cmt42Io=;
 b=gUkWR7HItXP+RadstBuYVU60/iNkiCmDAQUp52x+2WrusMyOyTnLtggJvy3r6s3QKhTYL3LOZaL/LgylA8GQe7bSNbUxnplyBu8EFdovl3ukkoDgjqvirrmd7oh+yGmz5/IWxq9OZd9MBXm/r/ybvjKJ5N9qBBkcrW/A+Xoha4o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6221.namprd10.prod.outlook.com (2603:10b6:8:c1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.10; Tue, 7 Jan 2025 16:56:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 16:56:49 +0000
Message-ID: <01ebe998-9475-4ee1-bc7c-c1dd05a45985@oracle.com>
Date: Tue, 7 Jan 2025 11:56:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Needed: ADB (WRITE_SAME) support in Linux nfsd
To: Anna Schumaker <anna.schumaker@oracle.com>
References: <CALWcw=Gg33HWRLCrj9QLXMPME=pnuZx_tE4+Pw8gwutQM4M=vw@mail.gmail.com>
 <e3d4839b-0aa0-42f5-b3d1-4fd2d150da75@oracle.com>
Content-Language: en-US
Cc: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <e3d4839b-0aa0-42f5-b3d1-4fd2d150da75@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:610:118::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce5fcb7-459c-43a6-f9e7-08dd2f3c4720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHg1UitlUU1WQkNPWDVVdDZ4b2VqTFkrWWJYdGZWVFh1NE50ak5jNUJPKysv?=
 =?utf-8?B?aHdnVGVxa0p4SmRVdXpmUlNsY3pnN1Fja1dVSk9GWUZXTnZOWktjUU9pRS8w?=
 =?utf-8?B?MDMrcVNFOE9scCtzTUplNW9FLzRISktPOGR2Um1mcnIzNmJkajREdzB0Z3Jq?=
 =?utf-8?B?MG5KanZaMzFWZVJ5REZ0SzhMTVRrck1XUVBlcXBnMkVCcndoZjVIak5aNEow?=
 =?utf-8?B?aUxIM0NoZi9vL281UEZNU3BMQXQyZktkN2dsZnJFM1RxQlJMUUhJMW5LNlpX?=
 =?utf-8?B?T1Fjc0dtRkVxMzFjcDVxSnlVcUdzejVXbE1BcHZYNk0zdXhYZDJ2bEpPUDN5?=
 =?utf-8?B?UU85SkYyR01nKzBRRHZjVHRvWm42TS9LOG9xazFhNjhtY051S3UxTDZsNFRN?=
 =?utf-8?B?VlNZY215TVVNWkswMUFaMWtNakc2QndYUStYL0ZtRk1XNDNrbmZIMkRvVUx2?=
 =?utf-8?B?UFpETVZBYTQwN3ozbGs0SkJmYVVJckdINnFxUCthQjNmcXhiRVZKVnU5VDhv?=
 =?utf-8?B?WjBFV0hVaWt1M0ZjMExIYkordlRWZm5EQjRUbTVPd3Rsak1XZVluSDJic1l4?=
 =?utf-8?B?Z1VXVW54YVRYellrZ2RENjhqR1JOSkZRNHNvVTVucE4rK1pwNGhWZzR3WkVs?=
 =?utf-8?B?R2I1cHlQQWJEZUNJYk1IMFRGM0ZBSWdSZldmRVRsa3hKd0xmR1VrTGRWc2k0?=
 =?utf-8?B?ZDc1ZXZ6NE12SkxnSTZlaDNVN3YzMXRoU01xdHJ5L01WZHVxRkUrMlNxN280?=
 =?utf-8?B?Umdkblh5R0VkQnZQdTFWODUzWENwcTRMcnphcDY1ZEpzSjNUeFVCNkcvVkFt?=
 =?utf-8?B?elNFWm14em03aU9hcFN3RHpBd2FLWVZ3YzA3NHJ3VEl1dWJKS1NWbDNKRGhu?=
 =?utf-8?B?bXp4dlkxUW4zWlkzQVFYOWJjTVVDa1ZpRVorZVFhZHZzV0MvS29GSDJKQmZI?=
 =?utf-8?B?RFpSSHE3M2dlN3lTcmxLaDlBL1diTGU3a0dET0haQXRsU284QXYraDZyV0xZ?=
 =?utf-8?B?bjBBNzdFQ0NDdGE4c3pjelVtZUNLdXJUbHFDakhiTjBNZEZ1c1k1SUttNUxu?=
 =?utf-8?B?OUVDZE8wdENsTk9Fc1VRS1MxWWlXS2RZMlFMSm80TDQxeHVrdGxCME9ESjYv?=
 =?utf-8?B?T1oxQXJHbXp0eVB5dUhnQmdqeThUeE5OS0xiQm40WitXVHpHa3Nwa1JWd1Ew?=
 =?utf-8?B?eTh3ZExISGtycFUzTDJMM0czWFFYb09TSkJJL2s5UFV3M0ZTb0hTeExUYm53?=
 =?utf-8?B?aXlmSXhKZkM3MGx0cVhYNTM2SmVSVVRtZW9VZzArNVY1R3Fsbnl1elBybHJQ?=
 =?utf-8?B?eGQ2ZitiR1hZYzAvT3lxRU5iWGR4WTZjMTlLQTJGdDJ1Q1VVaXB4THRvdk11?=
 =?utf-8?B?RlpOVmk2b3dhNmlSS3pObURLbnBBQW43S2VXNk5DSUdPVHNGSFZiN3lZNjdt?=
 =?utf-8?B?UlNIWURYK255VUg4eEw1NTd1TkJMTHZUenE0WjhydTlyVHYvQmdUdXh3L1FT?=
 =?utf-8?B?b2I4dE4wdHVKTWY0OHRMZ2RISnpQbzE1Z0NtTFo3SWZ1bWlMdUFWcUt4OHNo?=
 =?utf-8?B?blZhenAyLy9FRVNWdlpSMCtha2xSUzVXdUc0YTEzMzdmOGRBQ1pQNUJlOHA4?=
 =?utf-8?B?YnpHUnAzZUo0RjUreStZMHhrRDk0OUVobnd4QmczbG9abWVTSEwvWXFhU01u?=
 =?utf-8?B?WDJRdWRaQUM0MllTNEFVUHNOYzJKZnBYanJORE1IY3dMcTU3S3R0emtHMTY3?=
 =?utf-8?B?ZTZXVnd2RFlESDZod0h2cXRPZ2pwK2UwQ0FzY1FkZHVEZU5ZT3V4Q0JyRDlu?=
 =?utf-8?B?YlNieUd5NnFBMUtXLzNma1ozZHE2T1VrUVd2UzFpU1NSa2pPS2N0aDRLM1BC?=
 =?utf-8?Q?EV7h113Mip3+j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUt1T0hMTlNodkZ6Q254VThOYWYyeEhZbzYrbXByYjZRVnNCSnAyai9JczlI?=
 =?utf-8?B?ZE4xTERGckUxSjR5cFJqRFFOTkRNczg0RnVRVlVDN3FwN2h3eE94VWhyVElk?=
 =?utf-8?B?Z2d0elpJaEFGRElzVjM5SWJPZnY0UHhtOWJ6QlltN0lhRWRDaHJHOTZEWmRT?=
 =?utf-8?B?YklNaUdaU01DWXQ0TytGZ2dZTG0zaVZoQmxzenkvd0tHZDJ2b0I1U01vVS9h?=
 =?utf-8?B?dVJtRXI2akRnM2psaVhVZkI1NWJuVDBNS0Q0L3RoYjk3QnNmVlJYR3lYdEYz?=
 =?utf-8?B?U0Rxb0QvVVFEQStCUG9WWklTYWNkWDNLcnI1WGF3NlZIT01rb2RURGxNQTlH?=
 =?utf-8?B?aWlsRzE1VTdOT2ZnVUJaRXdLQ0ZhUHBad2cyZlVEcjJvMVpiL200M25VRWt3?=
 =?utf-8?B?amdmQWFjWk1wRWhpU2dvSWpXcGZrU3R5RTBYSWtuVjJKd0xJU1NzZDMzMnpE?=
 =?utf-8?B?cGY2QkhHZnVtVDNSZUoyZFpEbmFuWTNkWlNXRk5CQW1nM0V6cTVyTndManVS?=
 =?utf-8?B?aWhEZk5WUWpuekFVeWlWVjNFTVFHNUxuTm82NGlINmt4aHNuWDNGTWJ0TlRq?=
 =?utf-8?B?ZEt5VnZOUFVBaEZkc0NMK0hRUk43NjVUMUpDb2lNc011ZHFOcFRnYW1HRlJ5?=
 =?utf-8?B?ZTRaaitVNVFVK09najYyZTlpYndRQVJ5RVFjODNYd0pYRE9iSlNwSGJoamNJ?=
 =?utf-8?B?TFExcWJXK1U3M2hWYkREV2pKdjVHTGYyeHdrZEI4a2dVZXd2M3Q1Y1ZiNDZX?=
 =?utf-8?B?S3hGd216allRRmJYWThDZXhWdFU3ZVgxQ2hSQ3VicWRLRTRzWGxxMEtUVFJN?=
 =?utf-8?B?cDErL0wzSEFmL3JleU5MZU8za1RKQ2QxMG1oY0tXcGUxQllWMnhINUlIbTFs?=
 =?utf-8?B?UDA2R1JZSENJU1lGMlV2TkpKSnYzUW9XQmxLQzdMWkwzQXMvRFp1eDgwRk5N?=
 =?utf-8?B?YUlmbkdqNTR2NEN6cS84VWFkQnpNWXlHZXdPdVFXZk5QNVoveDhjczViVEFq?=
 =?utf-8?B?b1ArbXdaN0hBbEVRdUhQaDR1UnYrZGZ3cW82K0RxMEVscllwZCttcXRidGVu?=
 =?utf-8?B?WUpJbzVkd1dnYzVqSFNNS1J2UTJLYWFBLzRjakNrL1BYSDZNekpKVTJsd3JY?=
 =?utf-8?B?RUhUR1k0b2pBTFc3RGRPd0kvckkvNVJOL2VQYW9wUDYvTE4rOFRvbUJJNDZH?=
 =?utf-8?B?Rjc2TVVDVVlPOEU0TU4vWmN5cVhNc04wT0kxU1NMSFhPK1puZU82VlljOUtV?=
 =?utf-8?B?dS96SVFhbDhEclpJTy9TamlpVllQSm9hWmo1QW9wejcvcWtaU29KcnpXRjY5?=
 =?utf-8?B?TG0ySWVvWTJPSjRkeUZvTTFYajBYa205VTg4K3lPZmlJVG5GU0ZXQVgxT0J1?=
 =?utf-8?B?bFNiNmNxNCt3TTJRS1BKTnU2cVFTRGY3dXdVZVNONXlyUWU1blprUDNiZ2VV?=
 =?utf-8?B?dDFxQmorYWJGM09RQlJKK3FYM3ZDZ0ZBanNteS9nQXlTU1oxcXcyY0RpK0xP?=
 =?utf-8?B?d2tkUldRMW1ZWXdmL2d1V09oSzhpUy9RZ3hKYXhGbVNHdnJxc2hvQnk4S0w0?=
 =?utf-8?B?VDltZGFGSzZUbit0WXFtUEkrVnhhUjYveTQydmxHdGRxT25NR1lFUmdRbHRE?=
 =?utf-8?B?dFBBZXhpK2gzUVpoeW9RWTJTRzVpOEhoMlE2TlppRE5HRWNJNmFZb0tjdG5S?=
 =?utf-8?B?aWFENFltY29SdHVrdTFqWjJMb0VjYjByR1JaNFdKRnhieWwwNndqeTlycHRv?=
 =?utf-8?B?aXFibGF1ZjgyYXkreEphQnBkamh3M2lvWnViUlRWbDM3MFVaVm5OWGZhR0ZO?=
 =?utf-8?B?bDZONFVoYldkVW10L3hrYmhKOE5pYWhWT0VHVDh1cVUvQUJRcUsrWHFJL0Ex?=
 =?utf-8?B?OHQvcjQzbHMvZXdzdkNuaUdhQWVUTmRwRVhraExYMDB1S2lqRUV5OHdybTMw?=
 =?utf-8?B?ajJUMmxmR3pBVnJiNnptek4yYnFNcThJZmFFYnJYMUxLejYxTVdlN3RVdEtW?=
 =?utf-8?B?bUdKRTAyenplOEsremJtTnIxOWxVdUV4SkJNM2U5U2d4dDlHY1JYY2kvTWov?=
 =?utf-8?B?Y202K2J5dU11V0xaMUNSdklyN1lXNXdlWTkzUTkrTkcyZHRteUpQblBZSHhL?=
 =?utf-8?B?ZkVEQThmTWltdi9OQjRkT01icm9qekFxRDlYU2FadmlHd3NvR2g2dFc5aS8v?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pq0goMvv0pW4o8bFW/XOPXedU8H56sh+ueH6DDNSsUQ9S5jnKf0Yo06h6+IQD1/HcN3RE/+sVer0EGAypqw4qwYPZkcJ5terB67BQJ8aprmRtPZv6DCS6AdBTkePtcNGCF6F/gV6zYKLeOb/5Lo11BZ5LRMQVFT6+KzrhpUlMmIpwX3wQsAktPvhDj0/BviCiTbH9plgN3ymjCvey+dult07DF38ote6eNX9XXhPT7eNWO2ZO/YfvtPJ0Vc0VO8gYo+T6eBFVrJLqPJpERaVtuNFDp8iWlmwCqxYTfv95H/vEh8s9oin+sJppUFhI1BdpoJMl+zDBl7OnEeBryvA8JE2zW5UEHcgdJwDMvLHSFKPG2h1lrpKX/a7AZx5hh1vrn15TRttw00QYgdxdJTlcEWUyIVq36D30shoFC7oRXVknt/8XhWAl89oonO6WGfXQ/c0fQSnoMh61WLAwhNPwhJ4585SQqgjQrT6amNVA2HL7uy2kL0QFjchfVt3XYY9h2uQsiDLakY5z/JxytccYTPeBzpIDDW4sP6tI2/TXtz5Ie931aRWlfpWAEgIxWNDEHuF9u6T0ZRC37npQw2cE7s6wav2PJ8kiwqynkkaYAM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce5fcb7-459c-43a6-f9e7-08dd2f3c4720
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 16:56:49.5536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcCFcxoIe/imPiAj/gc2eI+azC1gwtLLWPMwxjffc0rKzdTA+1Ak1tE0YaACaOiGqJa4IaNEV3AU5iKYejrCng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-07_04,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501070141
X-Proofpoint-ORIG-GUID: sXoFgSVRyocJMJa34Vb48AEi7258qUyC
X-Proofpoint-GUID: sXoFgSVRyocJMJa34Vb48AEi7258qUyC

On 1/7/25 10:10 AM, Anna Schumaker wrote:
> Hi Takeshi,
> 
> On 1/6/25 6:56 PM, Takeshi Nishimura wrote:
>> Dear list,
>>
>> how can we get ADB (WRITE_SAME) support in (Debian) Linux nfsd, and an
>> ioct() in Linux nfsd client to use it?
> 
> Thanks for the request! Just so you're aware of the process, this email list is for upstream Linux kernel development. If we decide to go ahead with adding WRITE_SAME support it'll be up to Debian later to enable it (that part is out of our hands, and isn't up to us).
> 
>>
>> We have a set of custom "big data" applications which could greatly
>> benefit from such an acceleration ABI, both for implementing "zero
>> data" (fill blocks with 0 bytes), and fill blocks with identical data
>> patterns, without sending the same pattern over and over again over
>> the network wire.
> 
> Having said that, I'm not opposed to implementing WRITE_SAME. I wonder if we could somehow use it to build support for fallocate's FALLOC_FL_ZERO_RANGE flag at the same time.
> 
> I'm also wondering if there would be any advantage to local filesystems if this were to be implemented as a generic system call, rather than as an NFS-specific ioctl(), since some storage devices have a WRITE_SAME operation that could be used for acceleration. But I haven't convinced myself either way yet.

This is a good topic for discussion at LSF!


-- 
Chuck Lever

