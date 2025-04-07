Return-Path: <linux-nfs+bounces-11023-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1005A7E058
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 16:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2F43A9907
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Apr 2025 13:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781C24A21;
	Mon,  7 Apr 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jz5+XMr1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nAPX5cBH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7F35972
	for <linux-nfs@vger.kernel.org>; Mon,  7 Apr 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034328; cv=fail; b=BJEuur4Oo1vQuydIa4z62HnVMcmjJYFKxIUE4XhL8w+1hdCA5JYQwkcgK7FhAlXvQrJQTuEodwEC6m6mCp+gbf9GRd31Z9BWwkU3yefNx+skYcaMjqwNfibOHctDF1FJ34TaG0+AB+wRZ3IO4Cp9uswn8oFfFZ/zY4g7GHPKjPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034328; c=relaxed/simple;
	bh=UyoOvzl+xcdQ3bh5qw4Q/FP8Nk/hyMpJZD2c+/Zd++s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dTepV2u0OKLEEYIyjFvhXQoYqcnM1WnXtefn/tsfnyR/H9J8AsXq7aj1ha2Jx9vaSSZXGdzSMiCN7a7U6OkZauoCWa82HBbL4DRUHk1Ij/4VE0Q4pLvkSrZMgYarL/LXoCwzRzya7IWOd9VXAmMZcWQFXES0C82jf/zESg0+2KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jz5+XMr1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nAPX5cBH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537DH3HW002081;
	Mon, 7 Apr 2025 13:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=d6njymYV+hhHPGsETOxm9J/oOHnbF6aAMT8foqUHwlE=; b=
	jz5+XMr1I3mwFnOMw45TGdcjga+Ut/5nRkhc1Gbc3rkzopRF8yWM81hD20nhLdpg
	LEv4fdV7FJEYPpZR6mwVcwNaSWCLy/9u94v4VO8iQ4bAwjBGg/7tX5U+lGbYaipE
	lcvsqBS7mk1UN9w9RtxSjEQhV6++E2JN2/5EPo/c3zdJlWRPTXnh5ErFLV5E4nuX
	VO/OKJj0e4rvSyyYdhyJ/t/vHLLpGP0grpnD8K0+PmZKPt+BrrJ5A95Rh5ffmktq
	x6Wk7hcTVDwcVrGiWZwg62N0eDU19+qLsdX88O3NWR6y2SJ4VYzh2IU1gAn3qDvn
	1UPm3oAXvhZsOg9pWamkbw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tvd9tkvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 13:58:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 537DT2uB013701;
	Mon, 7 Apr 2025 13:58:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttye3965-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 13:58:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eH0mij1+/9vzJ+DD1N5j4/nOW6Bp3dW3klt1nu8U72AmDl0zN6btFc1RAw9djGOJYB9BgsudhxtGSRYi5a/hQfr1LOAhh0oMgNRXhGJNMhf/Q4JiNevj1+y5bE6w//yP8CXStHptnDnhzMgMnMM7X0p+JVck5XxbwNLuJqJe1tuRO0g6UFCPBIRQngreBvOe/T3vavch6x8cLxZDMktjRw/ry4d+SbPviVY9KWhbdYPyKAbyEVb5zBcpNC48VMLSkYyg8ARyx5ddhyDIv1iPUsnp1R4U6nQ2DUYvtVpD09M0SAn6G4y0AncjAq7UM8BprMJCxhvADTMucHsNyEaNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6njymYV+hhHPGsETOxm9J/oOHnbF6aAMT8foqUHwlE=;
 b=dfBLpYXBEjnSDwVposk1nb7ODk9HWXdWJsgKBgqtwtyos9iejg0gAR5FJhx9GiCsllG2hI6HJmjFBD8AJ5ZFwjqC1H2X/VZE4cUzxZztGs3zw2sqJDjDA4v179JrZvGUBuE7Uo3zNb2ktTqZH3agkgBZf9Qyoy5yaHawLVm874m24d/US5UYDLo7q2KYi+WBCBvMkdlmHf28habWYCWLPgtxvapme1SRBd9SVOLV9NHbgHNvUWVPuPSX0r7Ecq0ySHGOSjyaLbVlYXZAzeZ/qE3tsqEWMR1ZZ5baFBVyClrC4cYuRxS2ilV+q6AvRttFA9jAiRWgBv43aV/3dy6BcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6njymYV+hhHPGsETOxm9J/oOHnbF6aAMT8foqUHwlE=;
 b=nAPX5cBHHYet0l9BdjcTX/xANosLJtEJDiXx4dBtbfFhNkDY+iBwAwAtKnQVJwtXwvMISFGoX86WFnfE2xhaPp4ytSE+kC1SAoXBFRhX7V1SQOR7QaKn/+e6+p77wdYlf2HgmAW+SlPa8mrISlPb0bUW4BQbK1LD9l/2uQ5ibno=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8369.namprd10.prod.outlook.com (2603:10b6:208:582::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Mon, 7 Apr
 2025 13:58:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 13:58:39 +0000
Message-ID: <94cf9bfa-dda1-49f3-baf7-dd755ff6a77d@oracle.com>
Date: Mon, 7 Apr 2025 09:58:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Increase RPCSVC_MAXPAYLOAD to 8M, part DEUX
To: Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALXu0UdddwbzGUUzKdbxpb-yC-FVMhbdcd-P+OLSDNvjZeByGw@mail.gmail.com>
 <CALXu0Ueh2uLMJUimG8ngFaW=soxvQj4ZaakmgpGZn5BRSWvMHQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALXu0Ueh2uLMJUimG8ngFaW=soxvQj4ZaakmgpGZn5BRSWvMHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:610:cc::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: cee6623e-4d16-48db-4b1f-08dd75dc4cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eW9PSXJtUHhZSVRZWXBiR2JjOWZXbDROWlFmMFc2THV2UzZRdENGeWp1c0pk?=
 =?utf-8?B?ejNRWVNCaVUxb2lleUhnbmFidTdVbC9mRFMzOUQ3TzEwL2FzTS84Z2Uyek8w?=
 =?utf-8?B?dGt5UkQ5bXBaQXl0VEdONnNuR2VHREpwaEsxc3V2cUZ5RjJBVGdORmo3K04x?=
 =?utf-8?B?VmpHNXo4cC9uampPblUwazMzWEcrUEk0aHA2dXJSQUNFRXdxNW5TL1RZU0ZG?=
 =?utf-8?B?Wk9PbWtRckZEUGNVZWMvL2t6TlFSSTVRSTFJN1lyN3c4WE1kRGJpcGwvNnFx?=
 =?utf-8?B?aGdxLzhDQzdhYkxSUXFaSyt2U2RkUXRqM1JVVmgyTWxhS0RqK2hkT3AwUU52?=
 =?utf-8?B?TXlJTVZxVndhUjg2SjV0eklhYkRETDVzbkd6SVN6V1d4U0lQNGxGdng4Vlo3?=
 =?utf-8?B?VlFMbVc3cHBDa1FQMzRFdTJJY2k4TDJWUU0rclM4RHpkcGV5WFBmS0Q0K2RK?=
 =?utf-8?B?aEM3dnFnWDJBZVhuNjlQNTM0NE9wSW0xVWwyM3h4Mk9rcDVKREtaVjN0S0J5?=
 =?utf-8?B?b1JLOUl6MXliTndTRlFGRlltWUdhOFFkcnAwZXIxcDNuV3hyeFNURkY5dGJl?=
 =?utf-8?B?Z2kzV0tGUDBQQ2Q2NEN2VHp5MWFOWWhCYUg3aE5uaDRsV0NFOGpmRlFITGRH?=
 =?utf-8?B?T2dPSTU4NEVTUHdFbjF2NEc4RmlYM0M5NXlCWFVxY3lsdjRORlZoS1dkS0dN?=
 =?utf-8?B?cUk4Zll4L3RHNzAvTVJPcFFiaEJMbnhNQTdUQitGUzJMcFU0QUwvS0F0QXBp?=
 =?utf-8?B?SXd6b2EycmxRVkduSzdzanpQa1FrUkRuN2xpUXFhTWMvTUhwUThacDRkSit3?=
 =?utf-8?B?dTU3SEVtZzNKVUM2ZjBxV0tMYldya0Z5MGVRMmxBaW00K254bE93UjFpTzlO?=
 =?utf-8?B?WDRhb1BMSm51RERzNkNVWHZ0VlJyTS96MlZrZE5teHhpQ0c2Y242WE4zeE9x?=
 =?utf-8?B?SW5tOCtqd002K3BiUUZiODM5ZlRMNmw5VnM5akE4M0t1QTZKYmxpbEFPdDRH?=
 =?utf-8?B?eDhIcmVVeklDMGtHVHdyOFJSaWhjRVZhSG1Ta2hGTlFCTjltOERJSHpWMldu?=
 =?utf-8?B?aldPQUxGeDBqbWZ0S2xlTGh5N3FaOHFIazhnN0JFNnVxMnhjR2RRWTBtc1dk?=
 =?utf-8?B?bWNmWS9hdHByTnFSa212ZjgvbzY4cVkzaThyUzFKcXVVREZ1emh1YWxYQWkw?=
 =?utf-8?B?VTBhUkpYcGVMNzlzY2xCNXFDUE5iTDk0aEhsdnBEYk93YjBaclVJWHFGNW1J?=
 =?utf-8?B?V3dya1J3YzRHYkpxM0dnQlNuZXdDZ2NkNmdjNDZRWm5MOW9aYkhPNXcrVVNH?=
 =?utf-8?B?Tm4wQ0FGZXgyUTE1dTdzUjdJTHY2TlNFYXV2S3B1SFRsT1d6b2pCRzhTVzd2?=
 =?utf-8?B?dFJKRUl3RklKbk1DeUNGUm1xM2UvT1VwVnQrRWJMeWR2UGNhNkFKdlhxMGow?=
 =?utf-8?B?M1N0NitENzZwUlBmMnE5cysyVWZiaURkSmVLWnJpaDg4SXFreGxJTEZCdnFj?=
 =?utf-8?B?ckx3c01hUEpLZk9vd3FLTi9LNzFBQTA3QzZMVCtuZHRicVlSb015bWorby9k?=
 =?utf-8?B?ajNXVUdicWlES3lTVkpQOUdSbGZLN2FYdUw5SDZmczQ4VWZWWXB6TjV2MEtm?=
 =?utf-8?B?NTJSV1ZNc2diUTNkNjNqM3JzWTBwekRKNGhla1I4dUxjNkxkektqWGNQRVZX?=
 =?utf-8?B?VkJUa0dVZE4yUWhNQzhTNGxmSUlXMVdkMXRwbEJ1aDVkZHdsckc3UTF4MU5G?=
 =?utf-8?B?Q0l6OWkrdzl2bXpGWTVZelBqWG5Ra0diQ0dUR21ra1FFQzgvVFI5T0FDTTNR?=
 =?utf-8?B?WmwveWZrUG1aQnBBS2hobnhBNzlTSW82TmsvcmVuSlY2VVNaQm8rQUNTdGJz?=
 =?utf-8?Q?6VQU35le3IWwq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHNLYUxlQjh2ckxKTS9mWmxPTWZvTStHcjBjd0dYMkRjMytWdlV3bVFCU0dO?=
 =?utf-8?B?Ymh1SW9DWTl5TTEvbTdSbTJucXlaNmtqSlJ2cG01eXZ3OGMxSTY5SWNMOEV1?=
 =?utf-8?B?Ym9KY1ptMGNLS1ZDSHdXY2hVU2poM2hncGJmSUdKRjFLWlZhL09wd2k5aU95?=
 =?utf-8?B?YU9UYlpxeUZDa0p5MWJaKzZzV0ZpRGI1dW1NdHZza0dsUzhrSFBlNnZ0aWxJ?=
 =?utf-8?B?eCswcksxWFhXUmdzNmUyaXdBUnVZdnRnOGZSMW1HeWRGS041dGRRUXZMV01C?=
 =?utf-8?B?VlY1Y3F0SWlQTEU5ZTMvQmFwOTFOblczNmxyd2hhVHNPSE1kendtWTNURis3?=
 =?utf-8?B?ZFRYdU5rWTlFSjVkdTRvUnpVWUM0RTJWWGlibmJNRGlQcS9qL0crSGxzaWJG?=
 =?utf-8?B?QlkzM1JEeUJPcTZrRWp5aDlJSlRSRHNBUXhDVTlUcFBmOUxZRzFoV2lxZ1hJ?=
 =?utf-8?B?eE9SSGRqY240d3l2M2dDZWVtZUU1Y3RMT01TUTV3YkVWWVFYZ2FSaDkzMjJV?=
 =?utf-8?B?QzJ2WXVXWjhIUlN2cDVlODBSU3pSWlNTSlFxMlE4dkRub2VyUklKUDcwejR3?=
 =?utf-8?B?WDNRQSt5eUh4K2NHbnhLUlYvZ0tacmF5MHB5NXVKWlJYazd0NVBBUkcxbk1J?=
 =?utf-8?B?RURPRlk2akxRbTFVU0pJRmdGc1cvU2plS3d0QXJsbmUzZzRHa3U1MVVSZEw2?=
 =?utf-8?B?TjBGUVpLdEhKTzZ2eDRmUkVlTC9pNERQKytaaXNrK2xIYzRhOXNwYXpTOXNE?=
 =?utf-8?B?a2VhVU8yZW9FK2YyWW8wR1YvZ2lnRmdaOHFQYmEzdmM4U3FwOFBPUWJFWEYr?=
 =?utf-8?B?Vkl1MWJieWN2MGFWRWZzbXBwUk5zdk9KOG9CajBUV2FibGsra3U3VTdCOVJw?=
 =?utf-8?B?OGFtUEZoMmdBVmpES2luMEJzb3VJMkhNanJPTTRNdXhsYjJoMHRJK296bHIw?=
 =?utf-8?B?VHZvVDJLQm41V0xJaWRjVzRXQ29XbmJxUXZMTG5nZGo0VU9rRm02YklhcmVu?=
 =?utf-8?B?M3A0SnFlR0JzVHEyUUF0Y08yRXFMOUQ4RFRlU2FBTVhCQ1kxL1hiU045NzBR?=
 =?utf-8?B?OVVMV0tGbTM5SFExV3F2Vk1PbTVJd2xwb3RSVzNsenQ3RlFWVTAzaVNZWVZy?=
 =?utf-8?B?WVRBekVoZWFBUXFqOHl0c0J1YmJGdGNTclVMT0IvZlI3NThCVmhLNzU2NVAx?=
 =?utf-8?B?d1c1UHo4WEpZcFg3NUZsNitQQk55dXh4MWhTckVzbDBCTGVvbDVsdXNJbkQy?=
 =?utf-8?B?R05nTHpWVzEvbTI2SHJqRkQvV201aGsyVFNoNHgzMngzRGlmQXhTd1VKbWh2?=
 =?utf-8?B?b1JrMzI0aFRHRExLZ0xKVTVuM1FhM1pRVFJDaDB0V0FFbWJwdEx2dG5mdDJH?=
 =?utf-8?B?OVltRFJMR0RjZjVHTzdTK2hXOTBaRlZlQ1duNlozMlN4dWQxNU1VWFZtNFVx?=
 =?utf-8?B?WWFCWmRWMGhhYUt6U0xQYkc0Vk40QVdWMzRFeTlNQ1JaenJNcno0WGVuRnJL?=
 =?utf-8?B?czN6Rk9pZ1RmUXlXamYwNVlhOHVHdWlBaVR5cXlVL1VLd3VYMVNSaElzOWxL?=
 =?utf-8?B?bXlPa1NxRFRFQXBnYVl5OXE3STUwWS91cnZCNy9CaE81YUhCL21rNDNUQWd2?=
 =?utf-8?B?bTRVR2RpdnJVU1FKK2pyOG5kMmI1WFhoUmFXa2c0SUI5cWFLT1VXeEo0ZlJ3?=
 =?utf-8?B?TFFWazNEbFU5MHVCeWYwbG5pR05HcjN2Qit2TFNLWGJzbjZlMVQzZW9kN3FM?=
 =?utf-8?B?bW16MXBIeDJBc0FKcDQzaE1aNFVPNXE1MHIzT20xVEZjdkovMjgvNnVrSTRv?=
 =?utf-8?B?V3pEaFhZWEhKOFkyZzFOUXFpRkh2R3B1c05lVW56bi9wS093MTRNMkdYVUxW?=
 =?utf-8?B?UzlYWjRhMC8wV1AzOVc0cGtRdncrbFFqYkc5aE5tcGk0WnBnRW1VVUpadWs1?=
 =?utf-8?B?dlJBTnZtUDUwMVhLZkJPQ1pqSEtjVHhnLzFqL2NJUEUxdVpYRm82bTcxVU00?=
 =?utf-8?B?anZMSENsejFMMEIrSUJVVDB2ZnFSbWRxckdvQXd0VjMrVm9hSHRMb1F4bjBo?=
 =?utf-8?B?cDl6bVhtUk1zNnBISkMyTFVZRndIUTIvYWt6RE9hZFZVRk14bHVpTkpvQTQ1?=
 =?utf-8?Q?GFhUwiZZgjxG6TxEMyjQZ3Fce?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xQZxc905BIJYrhnnGDoL/z/3aBxhrjK400DrUToUMEkUR8gCH5DRkSP477Ii3iQOrW8TE6k7o2v5DLnJ7o8lNt1mU/xhIiXS0MYrgNLwLW1Immp80vcynOr5YAfWvESQ17WitpquYSaokodoJNeVm2q//LWHuAQ5Izq4EBZPZmOeWWNN77FU1cF5bVZxNYuPZo5D3GHO2kFeQeoEpq5MA2KVILtEsWvQWpBv5/BgdJgekcQYa504ZAr3ogFqT3YxFwHDG1r6zl2H6QxcyquTg/AYb91AV8goA8vTj8SA3jiTWXXCAXG2UWIBH2JB/B7GNKUmQmQTCfD2kajhothWBpSaWvU65PBOU/s5HQOuoMHWrAcE+9eLdafcyI+G0aL4x/3HOMcLSyhiN7KYUt2KyUyMBC2HtDclmzu8kxs72StpGGZIwdM+8ln2yQfLmLuw5oQg65ve1dAjgLe4VwX+Eos3U665Z8FlrZtnMLd0+iE1O3wZO7KNq1Y48jB9qsKRMoQF5se9G/nLVz2MwnIJ/elNzrI8PP9h5bBGl2mRA8iYaV3GwCcXmCYi/PMGcNkwldyrYOCLDZfCxW3NMhFyS0kGfhINF/6VowUy/TaLT5k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee6623e-4d16-48db-4b1f-08dd75dc4cb4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:58:39.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gBnpBBusNByJCTobbmPrrYzO41Op9traOVw8YQfEhT4liREw77/nYT4X52GbIVLCcwpS937inej3Tkc1aERBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504070098
X-Proofpoint-ORIG-GUID: dod9E6LPtun99Pdw-vCza3xmlyKOT1_R
X-Proofpoint-GUID: dod9E6LPtun99Pdw-vCza3xmlyKOT1_R

On 4/7/25 7:34 AM, Cedric Blancher wrote:
> On Wed, 22 Jan 2025 at 11:07, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>>
>> Good morning!
>>
>> IMO it might be good to increase RPCSVC_MAXPAYLOAD to at least 8M,
>> giving the NFSv4.1 session mechanism some headroom for negotiation.
>> For over a decade the default value is 1M (1*1024*1024u), which IMO
>> causes problems with anything faster than 2500baseT.
> 
> Chuck pointed out that the new /sys/kernel/debug/ subdir could be used
> to host "experimental" tunables.

Indeed. That hurdle will be addressed in v6.16. The patch that adds the
new debugfs directory for NFSD is now in nfsd-next.


> Plan:
> Add a /sys/kernel/debug/nfsd/RPCSVC_MAXPAYLOAD tunable file,
> RPCSVC_MAXPAYLOAD defaults to 4M, on connection start it copies the
> value of /sys/kernel/debug/nfsd/RPCSVC_MAXPAYLOAD into a private
> variable to make it unchangeable during connection lifetime, because
> Chuck is worried that svc_rqst::rq_pages might blow up in our face.
> 
> Would that be a plan?

Right now I'm still concerned about the bulky size of the rq_pages
array. rq_vec and rq_bvec are a problem as well.

maxpayload determines the size of the rq_pages array in each nfsd
thread. It's not a per-connection thing. So, the size of the array
is picked up when the threads are created. You'd have to set the
number of threads to zero, change maxpayload, then set the number
of threads to a positive integer -- at that point each of the freshly
created threads would pick up the new maxpayload value (for example).

Making the rq_pages array size dynamic has a few issues. It's in the
middle of struct svc_rqst. We might move it to the end of that
structure, or we could make rq_pages a pointer to a separate memory
allocation. That would introduce some code churn.

Or, we could simply allocate the maximum size (4MB worth of pages is
more than 1000 array entries) for every thread, all the time. That's
simple, but wasteful. I am a little concerned about introducing that
overhead on every NFSD operation, even for small ones.

The RPCSVC_MAXPAYLOAD macro is currently an integer constant and is used
in several places for bounds-checking during request marshaling and
unmarshaling. It would have to be replaced with a global variable; that
variable would likely be stored in svc_serv, to go along with the
rq_pages array size allocated in each thread in the serv's thread pool.


-- 
Chuck Lever

