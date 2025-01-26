Return-Path: <linux-nfs+bounces-9629-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4AFA1CCF8
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 17:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2F516335B
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11179154C1D;
	Sun, 26 Jan 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g4ysbp23";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KQ1WWoRd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3371D155342;
	Sun, 26 Jan 2025 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737909735; cv=fail; b=p407pOohAHkqscGOwQbLnsm3ePLQ5GILFWfUnZ1Xo5FA3r1pUmTHEaEQhM/xdXdj/alQwpmU3ae4W9hcOs4q1YKMofACOcmU+gYdl+tD5xD0+WDcXAPRUo1IS6G4uN68YQRNcHuaUf2OaeI32oiaTln/LNdLdU1Lsxj6JzKRsUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737909735; c=relaxed/simple;
	bh=ncpgF75STf7Gsbca4UxnW3uuxte8jBI2QeuZND8Lkrs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EPQwjb7x/7d4IhyGQERt2P/199FDmRwQbRBxGqS+4lnvc4FuSrCIKWmbYHXL6F0ThMtzrlv2/BphBxa3VpTqVtxIDAkygsXS3wzpm9LnU3F/WZGksxckcbzrBgK6mE/svpi3r44r2CGjppvZEXHZptxiuK7F2Zhx6rYjqSgIErw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g4ysbp23; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KQ1WWoRd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QExj4a008843;
	Sun, 26 Jan 2025 16:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rtB2VJORgu/2VXJrhSDVDTsFbEbhDeOONrhwXquw7Qc=; b=
	g4ysbp23j3OaLqNn9KYC0MaryKPGH0s7Tt8Q5oXz/uaQnzTbN1eqtjm7kdqJk/Nl
	zhKiWOiOle+IUn8qwesXicuBere6L8e/pMbEo90GlkqoO7AJfCRbejERimlrY21O
	FZmUICTAmfePrCCn+wNKfDFxV49OV1YGlrS6wCOrN01bBqAP4XE3YY5y3E8STG+4
	wrbPR6WEZI6uFLSCGQS3SrV14RifmCIZI78/n+Y6XbB1Gf6p6LMUv+bUOzxp/2bP
	qM0UKPiAHVUZUU7X4AWKn5jwcbV2NeLb41drdgFGGS9/0t9ZN4/jnKOqz8dnBkAB
	7x1cCiX64yAiVs8/fdWNtQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44cqu8sdt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jan 2025 16:41:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50QGZAuc005528;
	Sun, 26 Jan 2025 16:41:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd67gks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jan 2025 16:41:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfIr9Nm8x5OHSnEpAxpm703qyYTgYKYIzUIvw349g2iOQyAHUCl0Mb3zRdxXx8QPMooBbOOTYMEcMqQ/VqSblGrn3snkRCZEQ5ls3OG1p7SlRSoVyIC9ilDM2bPxyYgihVysRs7I9a9jaa1DuyVMZ7L/S1JUlwH5rSaBbfL4ST4Y+ZfdDpDYeL9O+kqj2MgC+iyUWDubXh27LL51c/bzth+L0ZqLSA7hEENyPUkoYJJa6YoKrWwCg5RoBvmX4nd0IyBCFaTPCu7JNRLyGyqogKrRIK9m5VhUYiNyKaUzUjrHLnAc1S+qjXYbMmWp0ih1fISfoQh8Zdn3Z5I69GLZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtB2VJORgu/2VXJrhSDVDTsFbEbhDeOONrhwXquw7Qc=;
 b=c5PoOoG7ojSA10eDYMYWZu6gPEX4rhBPnSYn6N4BIXU1z9B8/ZqGtwZnMr5Sk4V6WmYNht1G8sHbJ9f+Gz71k+lmQJbQScqOZcrJ4C3UgxWiE73TmMHCQswdyjXbjbvtYxbxNWPrtjSXw7fqbylR7WVDLwIYSrpaXrEiYAw0hydBrWnMFelyvlWrRzcQiL0i0jodb1sG7xAThplZ0t+o07bOsBED+ytAXK/cVEQC73MZBIolD3CTTdhdglQw41B/4leGquCMkGX1R+KDaPA9BWgLyKfgAFaGSDAsYQi5GJVlh6imJUl2CFvk2sYh5cE8SB9oxPzmUu6MK1KrIsSeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtB2VJORgu/2VXJrhSDVDTsFbEbhDeOONrhwXquw7Qc=;
 b=KQ1WWoRdt81D+nbGnlYlOxRAnB73V3S34QyDeHj2OvYwlTFgC186G3qxB/3+MDAFFWFZJrXqLhUElj1xQJDMWYNY12FXLB6nDBuK+7aLBLISL05RXk1XjqHgZVmtexkVMt5CYofj6RXG//72SPynyBwxwskFPew/+vmV+DzxGro=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7321.namprd10.prod.outlook.com (2603:10b6:8:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sun, 26 Jan
 2025 16:41:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Sun, 26 Jan 2025
 16:41:47 +0000
Message-ID: <ac5834d4-1465-4dde-a451-b0804c537f04@oracle.com>
Date: Sun, 26 Jan 2025 11:41:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] nfsd: don't restart v4.1+ callback when RPC_SIGNALLED
 is set
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
        Kinglong Mee <kinglongmee@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-1-c1137a4fa2ae@kernel.org>
 <173784610046.22054.813567864998956753@noble.neil.brown.name>
 <d52cf9b9b83753434c1b0098afe1b77bf65590d4.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <d52cf9b9b83753434c1b0098afe1b77bf65590d4.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: b774f638-8941-49be-8be4-08dd3e285315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUdiUGlET0RoR283SzBXdExhbUx2UEZoY3ZPUlIxcTZna2U2dVJRcDgvRUw3?=
 =?utf-8?B?bkRmTnRiR3JlR0FaUnJ2OTBINk14WUdCMzUwaUhTMXRjTFh0TW0xeTZwbzBo?=
 =?utf-8?B?TG9vaTlzUjYwUkxveVV0c0Rwa3JXTXA4dTNoZWNwbjNzQWJNaE9WeGtqcTBW?=
 =?utf-8?B?RGw2VVFyeWIvYThMYzdxMkRndnV6QkFwVnlTbldGUHM4YVlXTE5HSlR6VWE2?=
 =?utf-8?B?WnNEbk9hOXY0WGlQVzk5VUk1N1BOWG5QY3FiTUVZL1M1MG10YjRhczhJNzAx?=
 =?utf-8?B?U0FXNmlxSytkUExDMENveURLVC9BQjhnNkZTL0x4WHRNK0JNaEY3UUI1b1hs?=
 =?utf-8?B?K1AyL3dvcUxveHp5N28yNGlhWnNiOHNGcitBZG54UVdEVUtIMHFxMTdIYnJ2?=
 =?utf-8?B?dnFLT29pb1BNREdEMEVXMysxWk12Z0ZjZER3OUdPSy93d1A4RWFPdEVRbUhU?=
 =?utf-8?B?eEdWMjl4YzhKZWREMXoxWTJhYW4zc25nc1ZtS0JGRUdlWG9WR25JVzRPajdw?=
 =?utf-8?B?c3Fob2lFMGZFdWVQb3ZrZWZ4b2pSTDdqYzBzZVVpa3FLSG9CSjBoT2xBWkpx?=
 =?utf-8?B?a05lWjV6RkJvb1lZcnZpOC9RS0FKbUprRWJpdnovem4yS1dNdWFvQWNwTkow?=
 =?utf-8?B?Q3NxMGVQRmI5Y2k3SzltSXpvVGhaWkVmMnRNVDZsNTdyL2RuS2VpMHVPK29Q?=
 =?utf-8?B?UDdOVnFJTjRsMVVSZVlsWnRyY0VUSWVTKzl6dU9KSWNVdTV5UzAwQzI1amtZ?=
 =?utf-8?B?bW0zZUVKd1Z5SmY2eDA1cG04WlBnZVE5SDd1RWk1QXlWNHNGWGxrVldqREs4?=
 =?utf-8?B?Y1VSTm13MGVxVDRvUENPWkpSVUM3U3FoRllITGs2VFRrdC94Rk5xK0pkT3hk?=
 =?utf-8?B?SmQrcm5sYTQ3dERPS3pmMDNJS3A0UityNVRkYWJhb0FHNld6OUYvcTRnbE83?=
 =?utf-8?B?VmJReUtRMjRSbXh1OE5PRUdoR1VXT252OE10N1l5VGtKbk5selZYL1lhRkFl?=
 =?utf-8?B?L0UxbFMvY1h2S3F4N0dGMjc2QmpVOENpdUJYamdhQ2VoU2tjTEVTS1E4MEpt?=
 =?utf-8?B?VTcxQWNPbWhKK3cwTFdiTzdnOTlBSUVCN2QzbUViRnhDV3hKQWNxMnRpbDZi?=
 =?utf-8?B?dkxFcEVuUGxHOTVlVHltekVORC9IdHhrdGNCb0xncTBPSzJiRCtTanY1TUt3?=
 =?utf-8?B?c3dXZ0pKNmQwS0VNa3pJQnM5SkcvR2JOZGtwTDR5V1U2MDdGY0R3OW9ERDlC?=
 =?utf-8?B?TWlRNUFtL01kdFpsdXRXVG03MlFQcVNOQkh0Y1JURnFvU25xWmRlR0FpenVj?=
 =?utf-8?B?RU5POURpT1BGUjVtVS9RVEpoTnord2Zyb3pGUW5ycXMxR1ZQMVllQW9MZzFm?=
 =?utf-8?B?OEZXd3FEb3BtK1l3R3VqZUxIU1JYUTg3eUdGYmRaL1RBcGV5K1VBS2VtWHpx?=
 =?utf-8?B?U1ZQL0F4bm5XV1ZBSjJ0MUw3SUxNRHNJVDliRVo2VWJEdHFsNnlJTWtjZHdt?=
 =?utf-8?B?YWhSVU45Y2ZFS3RlQjNLTHNINE1qYThRbmgrTHpkVzZUbjBOTlVzdTA2YXNL?=
 =?utf-8?B?dDlXOXVyN0RMY3BTSUxHeWZMZnAxYWVsL01LQkZiN2JyQVVZUzBtRG9UM1pP?=
 =?utf-8?B?SE5vaWswaEpUOEl0QkdHSXhlbUxwT1VrZzFqb1RidjVoaVRoUEdkL1I3aWpX?=
 =?utf-8?B?MTBmVnRHdklrT2xuekZUaWNtcHhOenVWdnlrVHRLaXZtNy9kKzQyT2RUOUJz?=
 =?utf-8?B?WXh4akNnd0MreG9Ta3FhaDhVOHlpZWZSQ0dJRUllWmhMcUFsVU1ZSU1kRkxQ?=
 =?utf-8?B?R0N4NjMrUzZ0Y1Ryb0NQMUszNDZlQnVUMXRXVXJIeDNGTGZIZDM4WTN1MGhY?=
 =?utf-8?Q?gBtbgaDOu+Q2I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnZJNlM2WE44TWpUemliQ2hlM0lTMy9DdmlPSkQvcDJEYnZRKzYzNDhHTlpK?=
 =?utf-8?B?UElhMGtDclpWNHFZOUJWYnZZcEtheTlRYmZ5NkdiTG9yZzRZNTc4dXZpNWFi?=
 =?utf-8?B?aTRhMlFCOUMxdmVEZjlwdVJDeEtaRUlTbHhYZVl0UTZ5c05RRWk2clJENm5s?=
 =?utf-8?B?Z1VOdHlXMlJnM0ZTVDB1M1YzLzNjalI1SlZrTXMxUWpYM0NlbkVLcVhlQXFE?=
 =?utf-8?B?a09tRi80NkZ1M2poNFZDeGZxMklwOHVqTUFwbkcyWlNod3krRFgzZHA5VnVF?=
 =?utf-8?B?Yyt4Rlp1VktVU0NEZUIyWDQ0T2JoV3lzWGswRlMvOXozbjJJaGh2aFZKUFB6?=
 =?utf-8?B?WEd0aENiUTVuUnduNDJWT1ZYNzdpZmVRQm1RZTQvNnFUcmVzaE1jL3NHVk00?=
 =?utf-8?B?MW9lbHhSOHJMRTZ0Z3R1VENNcDBzdkIyQXNqdlFWZTFEay9nSzRKZlpIMlF6?=
 =?utf-8?B?blFOV0lOditqWTF1TVFuL1VQazRXVFplSS9PMUJ3N0tRQUN5VkJSSnJQV0tV?=
 =?utf-8?B?MkRnbklOZ0dhdG00YUNtTGVUelFLNmQrR2J1Yk8wOS95dFBCK2NRZStpcHZr?=
 =?utf-8?B?bVBsLzgrUDZzSU1rR3J6cWZnODhyYmJQcXdnaG5xVzQ2OWMxTW5PaEpVSStt?=
 =?utf-8?B?cnZUcGtpZEFCbk9xODdObG15OFAxdjc2a01maVF4VURlNkdobk56M3dtNyth?=
 =?utf-8?B?RTVJeUlzdXFTazE5eXVKakRMVGhWVzUzT0FQZDRFRHRlcSt3YkJUSW9MTDZH?=
 =?utf-8?B?NEx6ZHJpcEZtd1JUUENGcXExWkROdHc0bXQ1dTNyVDFqREVZZjFIQlRrKzJP?=
 =?utf-8?B?Q3UreDBzVURVUHU0bUIwd1ZZd1FoQkxnYlJOZlBraEVJRzlENlpqYzFtR3Bq?=
 =?utf-8?B?MXVRNmJ4SG9NckJKM1ZCb3d6WHVmTlpGdElla29PdGtpakNxTGMyUlhWWm5t?=
 =?utf-8?B?NlBoT1BsOWpMbkZBZDVwYWMvR2NtN2J2ZWp4eTlidFI5dG9vamh2MGpoVTRJ?=
 =?utf-8?B?NXFicmlhSUxXU2wydFYxNm8vd2I5WWZXY1UwcSs2NFVjbFUxNVkxOUxkaW1T?=
 =?utf-8?B?Nk1wSVQ1eUJTSHorU0RYU3krUW0rYmlIWEpGRlVUU0I1eDMydDFRK3R1UWth?=
 =?utf-8?B?WTNoY014ZGkzME5PM0FHZHBOc2pIM09nVDAweDBKQnBKY0VoTDljdFVlazJ4?=
 =?utf-8?B?TUFYQ0wzNEpNdURWeXNOWHBnVXNvd0tzTm45MjljZFFCTG5xQ01UaFpiYUtv?=
 =?utf-8?B?VTVXMnVnQ0R5ZjNUV3RJNmFQSWw5cjBkaVVhUWpWL2xEaEl3MmZ6UE1QS05z?=
 =?utf-8?B?ZERVQnllOGFFMitwcjhodEE0VG1NTjVvSm5mWkVkNUVPTUtKUTZUWFEvSEJZ?=
 =?utf-8?B?TndCZW92aXpWYVdoUVpuOUtoNitRdllVK2orazNFUlZKakNQS0JadWljc2Uw?=
 =?utf-8?B?Q3ZwQ3ZSZEUyNm1TRlJrdVV4RG00aDVGYU9JeFcrS3NVZ0kwUXF6RU1FWnlt?=
 =?utf-8?B?dkt0R3Z5Q1FSSWREdVVKTFBqekxKOTFGR09ZMXdPOHpTNHlWdnI1SXQySHJ0?=
 =?utf-8?B?S245aU1iU2NVeTJJaVVvTlJJQWtEcmUwaW45S3FsRlNVWFJkVE1BeDZRdDFN?=
 =?utf-8?B?d2ZJeFdBRVl3OFNYSVR0NkQ2WTBBRUdEYS96bmpEUzUyc0FQSG5neWtkUUZP?=
 =?utf-8?B?SXVPQ201Q0JVVy96TWp4NkN6NGNsNFBhbXkyV2VKQnYrOEF1VHlsNk9ZUmly?=
 =?utf-8?B?MGJtTlJmamxSRmU1M1BJNm5lbXVhRTBTT0F4MnpqL2Y2YmxRN2NzdEpGV096?=
 =?utf-8?B?b2VpcDZ1WDN4aFcrTklRZVYzZWFpdTFFYlRURmRJa3J2ak4xcU1ER2NTMGkx?=
 =?utf-8?B?MkJIMlRrME96VWRxaDJaMDBPT2xOd0dyakpGSkwwbmNDT1EyOCtITWRSbUIz?=
 =?utf-8?B?bXpRSTNTZjI1T0RwMFd3MkxwdXdoWGdlY1hFRmpuUXlKUnFoWWlCQndLRVEv?=
 =?utf-8?B?RjVLSFEyMVd2NjhSVnBqNmFvcXgxaGtJaU85RDZkcitKRERoeXVCbEVHNXlC?=
 =?utf-8?B?N0dSOHFzcTdmNDhFWDV1M1haYm1RQVVUb2hpMEFjUU9hRHZoM01wZmUrcFRE?=
 =?utf-8?Q?d2AgBkPkbrRwKTAiZkTWs88Hs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7JZXv3aTK/EH3Fu1GMs6H0y4+K6Cn4ZcmOC4SJkZevLVbV8p/q+NnhP7Q379onI0Ki/yEe4kBVcVxd4HweMSXP8fsJzoWcnIg1TCpf0GXNqazZjN6GVUjuMgdDhFfpz191pDe5Zqlu7/9S+htyOWjrCHjJZDiIl2VoYuJJb5nBso/WZmWlOF2/wMH5sGtGoJ+sKvLwTwSA9jSohVzmoD7Zt+0kQphcX5HqS9bPhdaoIAn5bxDc/EuYbP7p6DOW7ryGX+HCUM1j9tqzt2421Dn3kTZZpXnCBKO74UzLLnHElm9uyg5Ahu6omk4gc8+lIzTh45rTrwOLftNKW43Bf8TqbvU65u+nnuHPaT3UxnTL7WFMcBVtJaweK8y9lozWKAfMWw9jFKI8SPjHJYOYHvrjDEWMYAqTm0SDZmMArRbHg7WkaDLODorNYGVrwVaJF0SlFBCfLNQ9WBpNPPpHMZ0IrWnl7URVt/7wpd5FWBl/k2KU/YOoL0QLvSyRGHAr5ZLyr7yYUcgQc6A6znVIVmrrPHfjPuiZmHjvyuv6pnGiAy9CxCdpSu5EJRYR2zoywdQKsfLoUd2fZEwN4WNJN8BLDytGBsCaCxpVybsguFIXg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b774f638-8941-49be-8be4-08dd3e285315
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 16:41:47.1362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0oZSpXmnktwfkylCDEt7zgeZEU9BSmtIxvWBtasl/cMJSNgUfn9IfkwN2pmVPY7pw5NIUcXvNXEgZM/azSv8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501260134
X-Proofpoint-GUID: NGRhUGHnutSJhZ7NDmCtdyDtjElm3Q7A
X-Proofpoint-ORIG-GUID: NGRhUGHnutSJhZ7NDmCtdyDtjElm3Q7A

On 1/26/25 6:18 AM, Jeff Layton wrote:
> On Sun, 2025-01-26 at 10:01 +1100, NeilBrown wrote:
>> On Fri, 24 Jan 2025, Jeff Layton wrote:
>>> This is problematic, since the RPC might have been entirely successful.
>>> There is no point in restarting a v4.1+ callback just because
>>> RPC_SIGNALLED is true. The v4.1+ error handling has other mechanisms for
>>> detecting when it should retransmit the RPC.
>>
>> But why might RPC_SIGNALLED() ever be true?
>> The flag RPC_TASK_SIGNALLED is only ever set by rpc_signal_task() which
>> is only called from rpc_killall_tasks() and __rpc_execute() for
>> non-async tasks which doesn't apply to nfsd callbacks as they are
>> started with rpc_call_async().
>>
>> rpc_killall_tasks() is called by fs/nfs/ which isn't relevant for us,
>> and from rpc_shutdown_client().  In those cases we certainly don't want
>> the request to be retried, though the nfsd4_process_cb_update() case is
>> a little interesting as we do want it to be retried, but in a different
>> client.
>>
>> So the code you are removing is either dead code because something else
>> will prevent the restart when a client is being shut down, or it is bad
>> code because it would delay rpc_shutdown_client() while the request is
>> retried.
>>
>> I haven't dug the extra step to figure out which, but either way I think
>> the code should go.
> 
> Thanks. That was my analysis too.

Agreed, this code is problematic, but it appears to me that some of
these problems are not resolved by simply removing the signal check.


> rpc_shutdown_client() is called when we tear down and rebuild the
> rpc_client. nfsd does this in setup_callback_client(), which gets
> called from nfsd4_process_cb_update() (basically when we detect that
> the backchannel is having problems).
> 
> There are really only two states: We either got a reply from the server
> before the client went down, or we didn't. In the case where we got a
> reply, there is no need to retry anything. In the case where we didn't,
> the tk_status will be '1', so there is no need to check RPC_SIGNALLED()
> at all here.

Fwiw, the "cb_seq_status == 1" arm skips the signal check in the current
code.


> The existing code could lead to the call being retried when we had
> already gotten a perfectly valid reply.

Here's a case-by-case audit:

  - NFS_OK: SEQUENCE was decoded and passed sanity checks. So this should
    not ever requeue in here. It might be requeued during subsequent
    processing.

  - ESERVERFAULT: SEQUENCE was decoded but failed sanity checking. The
    reply should be dropped now, and the session marked FAULT. No requeue
    is ever needed here.

    [ I question whether the sequence number should be bumped in this
      case -- the client's callback server replied with the identity of
      some other slot. And anyway, this session is about to become
      toast. ]

  - 1: The timeout case. We want a fresh session here, so it falls
    through to BADSESSION.

  - NFS4ERR_BADSESSION: This needs a requeue so that the operation can
    be retried with a fresh session. But it should always check if the
    rpc_clnt is shutting down before doing so. This is a problem in the
    current code.

  - NFS4ERR_DELAY: Skips the signal check, but shouldn't. If the rpc_clnt
    is shutting down, this RPC should not be requeued.

  - NFS4ERR_BAD_SLOT: Skips the signal check, but shouldn't. I need to
    think more about BAD_SLOT recovery best practice.

  - NFS4ERR_SEQ_MISORDERED: Does one retry with a seq_nr of 1. It
    probably should terminate if that fails. IMO this should check for
    rpc_clnt shutdown before requeuing the retry.

  - default: I don't think this case should ever be requeued, but it
    appears that it could be if the rpc_clnt is shutting down.


>>> Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>   fs/nfsd/nfs4callback.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>> index 50e468bdb8d4838b5217346dcc2bd0fec1765c1a..e12205ef16ca932ffbcc86d67b0817aec2436c89 100644
>>> --- a/fs/nfsd/nfs4callback.c
>>> +++ b/fs/nfsd/nfs4callback.c
>>> @@ -1403,9 +1403,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>>>   	}
>>>   	trace_nfsd_cb_free_slot(task, cb);
>>>   	nfsd41_cb_release_slot(cb);
>>> -
>>> -	if (RPC_SIGNALLED(task))
>>> -		goto need_restart;
>>>   out:
>>>   	return ret;
>>>   retry_nowait:
>>>
>>> -- 
>>> 2.48.1
>>>
>>>
>>
> 


-- 
Chuck Lever

