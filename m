Return-Path: <linux-nfs+bounces-10632-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C57A65BDA
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 19:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCF8189ED98
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 18:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ADB1A4E9E;
	Mon, 17 Mar 2025 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SFeydnL+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xcbI3Cfi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40471A7AF7
	for <linux-nfs@vger.kernel.org>; Mon, 17 Mar 2025 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234569; cv=fail; b=RZFNFpbStuRBcZjBOd8ep6FGLibdf1wiMRT7CVfTYtgHt3A9yl6UC7aCAATplWK9z7pM65lyaWZF55CL3NNtE61yxusDGxuGN4njLottmY4WTR7BG2aJbihAT1Fo7Ef5WwmdZM0nSfXIkeDdJu0SmlEYbNPij1sSeOkPjTa9Y4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234569; c=relaxed/simple;
	bh=8GXDJqfgag/YRbZOH54FHxLlubn3XeByHskzblrJW5U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XeDaeI3jG4LPIp1bjBMD4U2yR6HDZlojx0BFnGcyxAG8E3Qoq/wrPZo5FNI2mruu+BlYbg6W/b/wL8NjXT+6wzs8mEzyHgJi3jfl4+nrXrcG8h/NOVW8RsHUyaHjxc5euYPWJ/gh+msA+nW4xhGb2e5/bDnkFcPFlJz8AI9vEs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SFeydnL+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xcbI3Cfi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HGBq2q021775;
	Mon, 17 Mar 2025 18:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=naYxoK6/gFwjDoArkPzPoP3FjQv5qi8ZyTravqI9r7Q=; b=
	SFeydnL+nDeHp0tzwf9Re8nTWrnSTmskI9VOd9McJ1K0KoddsW0Q4GcjO9RgI1nV
	sqC2GR+2WQBxvbCFwM0v7j9EhJVRcv9uTTp9IdVz8HLvKMZNt38ZRwevtZfN6rxF
	jRHsEy1QdtXyg2Lf/6nMKoBrt+StrycuQXvTmOMPnXl8c5O83vbKHzrihAVrdvZL
	bJPFvibQA3/ZKshDovsKwhKFz8M3xlb+4ElDH+834IHZwRpnD0lFHKdeDmyZUZRE
	nnxjgBnmNOzA0Z0hPL3DAsC1C3FBEdh9QgyCTm2EXo1WesderLrnXKQUP6Q3twcj
	cKgNsNJMz3C57KTU3or+RQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1k9ukep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 18:02:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52HHgOGQ027957;
	Mon, 17 Mar 2025 18:02:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdc9v7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 18:02:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMO+uZoA+krO1AF52t51j/mxCu4C05CoeoYrIbKJcPQ44mZkQzTo5YMOk4/tH43U1Y/LE133PF8M9f92PE/50fKaCEifeQrckUvVphg8EwavQOgQ3CpgpMm5fhOPT8DnceJlknpmD1/LRwU8ol0t7ghULnxsK7mGWhcPCaRFAF0jkxsqCLtitaGptzY0H5sMDS1Dc8NlLWOE/F6+hiP6CpEVYD/cTXR7ZgcdVaXsCCigLUgQphNU5cZsgq0pN3szjUF3xunFUyi9xBopUd6/UEql4NC/fOqOehcU5FR8AB8Wzpc5/TZ1xrV8F/Tbrj5qTTh5mCp0dHXVdGBeQOgEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naYxoK6/gFwjDoArkPzPoP3FjQv5qi8ZyTravqI9r7Q=;
 b=b8t0ISzT23Ncf25fw4sFewMq+Jnd8Np8FvBkFxe+srHzJs4ag8lC+rd49qbR1F3AgpA8Dl68Qf1swSFsJcXHC/GrssFbNeeEUYfZA06rl2VvTtm1Xlwl+yhP+f9vaI+CijGfqUQLPnRz8MH4lNnf3khQWKs7wt18KwsUHiB3kmuiUqTnkFVDDnhjtGRiFPYx6qZI3cqPCPluCijv8AtLG8Wa2ExGlTOoYpjAGoXLh7OFLI6oWjmK9J9Th+KFmyMygAlWJqU0SEaXpF3Jgo2DRQH4j6mtPHcpSSjhbvhlm10T8PAu3GOcdgSXTiYHcyV2NOQVTjMnwtagJeBXCuE0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naYxoK6/gFwjDoArkPzPoP3FjQv5qi8ZyTravqI9r7Q=;
 b=xcbI3CfipjbzxjodVCyZOenc0mRxP82b9YVoV/30sydjgITb0pPbuBJh+eVuoStiL68VOKlV74TTOpNiBbhYcb/mqAmvJJoemhxbGBgk3EU1StSh4AjnoPJIHQbk5xE3B3URvIaw1x5c41NDMvieowZMY9aVRNWZDzY2E4S4WVM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6894.namprd10.prod.outlook.com (2603:10b6:8:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Mon, 17 Mar
 2025 18:02:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 18:02:25 +0000
Message-ID: <37cfb723-d29d-48a2-b10e-53dd58daab2c@oracle.com>
Date: Mon, 17 Mar 2025 14:02:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: refine and rename NFSD_MAY_LOCK
To: Olga Kornievskaia <aglo@umich.edu>, NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
References: <CAN-5tyHTpHE6QEtZkU74Y__XwaNLW5U-5hRNQLe4J18TyvcC3A@mail.gmail.com>
 <174182457214.9342.16141018787964898862@noble.neil.brown.name>
 <CAN-5tyELfjOfqg+u_0CC8GFFE8rJ0xudynfHs4OLr07t+zaaRg@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyELfjOfqg+u_0CC8GFFE8rJ0xudynfHs4OLr07t+zaaRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:610:77::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d46956-67ac-4198-7b75-08dd657ddfa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGlEYXV3MDZKd1A4RVd0VktFNi9UK0Y4d3J3Z0pzNHh6V3lRRHNpWWhpK2c5?=
 =?utf-8?B?VnRDK1p3YUVCN1RMU3p1SGpPd1ZqQld3eUw1RDRwWVdYNGxMSDlXbzZNc2dr?=
 =?utf-8?B?SjBEREp6bkovQ092VTNNT2VoMWpPRENwaThjT2UxQVdnN2VxL3VoSXdOM1VO?=
 =?utf-8?B?ODlKdjVVN1YvMWdQVTZ1d0EvcmJ6QXlBbkRQVHU1TVBPVC8zMlJ0aTF1Nks0?=
 =?utf-8?B?OGVnUWV2SmNreHZlODdoZnhaVjkwWWw4dTk0dUU3WE1TVU9rT0lZQVUyTU5z?=
 =?utf-8?B?NmxrTmU2Y28wUGU0QWJ1ckFWNnZPWVFEQTh5VXdzOHkxR3V0NThwMlZLc3Qy?=
 =?utf-8?B?MEh0bVNTbVZLRlMzcmd0NjA4VzZxZ3F4cC9YdDM2c2tuVHRJb3hxZDB3RVUw?=
 =?utf-8?B?SnplcXpoT3R0a3RJbjVLRC9lc2dMVkJTdkNTamtzcXRONFdIRVIvbzFyQ1Fs?=
 =?utf-8?B?TXZ5ZGtScTVpMEVjekh0cWczYk0xK21OaVNpay95WVpTMEhsQVQ1Y2YyZFZ4?=
 =?utf-8?B?MjNEQVRHSlBNVXByYVZhYU9ITmg2Wis3WTFpNGVtUXIyRWJLTXY1aVc5bGRv?=
 =?utf-8?B?THNJWkJ0cmlnbFNqRXowb1kvNlMyajF2Z3NvUUdHSFRHZkx2eWN4aEcrMmRv?=
 =?utf-8?B?cXlnTFpPaGhqM1R2VVdUTFVkbzJubi9XQWFyNlBrMWVLSmtzRTBDcGF1UW1y?=
 =?utf-8?B?RkxkMGVveXdyWUNneU1FYUhCWXhxRkRqb2svcVpDY1ZzRUhlTE5nWlNudFVJ?=
 =?utf-8?B?QjN1azJ1VUtrYU9wL2JXVDExbUFIMXZxSlk0RnFUQm5MUmtNNVhoOGF3N2cv?=
 =?utf-8?B?M2pXdmRPeVNWYzdHZ1N6UlA0S29ack1NVnphOS9td0NoeE1XTnkzY0JBVVdx?=
 =?utf-8?B?WTFyQkpHaHZnaUZoR0NVbnhJMUtqMEtpUjAxd3hEbVd3NmFuUGQ2WkhZSGJC?=
 =?utf-8?B?SEJKMDBNVlduWTJYeFdtQk1MSDNLUjg4ZEl5SUs2WG1yd3FhZmlZUFRGbUgw?=
 =?utf-8?B?SWZSQVlYamlsTHlSZG4wU3VkL3J5TWl0TnR1Y0V6TkpFRDU4NW9KU01uSHI1?=
 =?utf-8?B?K09TMlBTcWF5YjlhazV3NFlxY0F5MzVOR0lZQVRhcCs3Q2xvVDVxOXFsNGE5?=
 =?utf-8?B?TWd2czY5SUZOT2ROeXpYRFpUdG9LSHJaN1M5b3hySlhRVjNGcWUzekFIenFF?=
 =?utf-8?B?bGZ6emUyOVh3SE1QSkZIQlF4RHRoQzBXeUR5SVRtRU1LZWVPS0JFMG1mTWNt?=
 =?utf-8?B?RUl2U1l0cW1GUWpvTG1PYnJsc2FUVUhaL09yNmg3US9iRmRTbnZRM2VvdkdP?=
 =?utf-8?B?ZGpHZTE5bjNydzY5MFMyWVZSbk5PSnhraDE3R2NhZmR4RG9CWWhnenpYUUZk?=
 =?utf-8?B?RWMxQjZudmFFWUJRSENjVkxKWkVmRWtRUFNNY0RDUkxSd2hqckR5M25xZXJG?=
 =?utf-8?B?bHZjU3lhcVFkLzBobFErZ3E2SDlVVVgwZ1krekE2eTZUSXBRQVNIOUlGdi9H?=
 =?utf-8?B?WWgrOFdPTzVsWGhkclpjT0xMck9aWTg2Nk5ldlVsZng4c21BMFI3UXNUVy8x?=
 =?utf-8?B?dFA1RU15OUZ0M2N6TVdocGdrRm5yVVFodVp4aWZqd2ZQME1rSHhuTFFXMUVr?=
 =?utf-8?B?M2F4VWF6NEFudnJKbUhhaG02RGtkM2djVEsvcDYvRnpwbWdNaUdFMEMrWk9P?=
 =?utf-8?B?MXFkRE4vMWJueHpOZkZrK0NMdXpTVEhPNGxvSmlNV2FMTW05aGhrZUlqVzZz?=
 =?utf-8?B?ait1T1JIOG1oTVJCU2dLY1E1ZEpheG1IOFN3azljWURtSzZGcWNpclhDN0JP?=
 =?utf-8?B?ZWxpT1l4Z1V0VW1MQlhNNVM4a1NpMCt6YUlMaGF6TkoyUnNvR1JIMnRLOWxF?=
 =?utf-8?Q?aUoWwjJWR1Ozm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTFYcFhIOGVQMlBMTFYveStDUXZsSnRwalhDTU9QdU81ZUFTSzgxSkNzU1Uw?=
 =?utf-8?B?eG4yVFlnYWxxei9qbGdUZ2RIVEViUUV5VkhublY1TXljRWFYbjFISXVJWFlh?=
 =?utf-8?B?b09WNWp0NmtvTlRjalBObzl1dStCNGk3dlRwMHJyaFVVcHJwdVdFWU8wRVVn?=
 =?utf-8?B?YXVZRXJBeExDeVYwd3pQaG05WTZLaTdCL0ZBNHJ0ZktudWk3eEdyaHBlUllq?=
 =?utf-8?B?SEZFZzhwOGlBa1NaanQvbjlXTGRra3gyMXpsdlRmNC9RL3RQa2wxektRSWpU?=
 =?utf-8?B?cExZbnFXUVQ2KzJHaWY5ZWJBWTFBSjMvU0YyN0NGbTl2NkYvdmlTZ0tCVkkz?=
 =?utf-8?B?Q0VxMXZtMW1ZMXZndVcyaFprOFpLRkZTcmlCM2ozMTltVm0zNlBmN3ZRbHVQ?=
 =?utf-8?B?dVFYcWsyelduRU1odGFocXhmOGZSVFYxaTFnNzNpME56dVltbnlPZnhnSUhB?=
 =?utf-8?B?VndWRjNMN2VEUjVUVGtJR0xrWkJvTWlQQnZKTmIrcjNydTIxYW5zTlVLeWov?=
 =?utf-8?B?Qk0yZytJamd2bEZWVnh0TXNjc3A4dHA0TTkzbW1BeDdMdk51Mi9tc3NVS3lk?=
 =?utf-8?B?cXdNb1ZTMVNUTGt3OHVtcmNqbGc2d1B5SVNVTStROXE4M1V0aWxKdm5zZ1Q5?=
 =?utf-8?B?QWdYeEIvS29wU0JDVmhMc2gvZzYrRTFTc1E1bTkwZ0hkM0RTU2NlOEdYTFJW?=
 =?utf-8?B?L2FaeXNRcWhDekRnU3pCN1p4bjJqTHFyRzUwck5Sb0t3SCs0dG9oSSt3RklU?=
 =?utf-8?B?OXZXMDVCY3c1NDNSQllRenVuYlp0YmRlSGJQblRPdGp2bGtxM1l0NE91KzFK?=
 =?utf-8?B?YkwvZ1NFNHZSR1h5Ky9BMXExaExqNjQzK3hxT3VLVmhKOE05R1JPeHdmVkJE?=
 =?utf-8?B?U0hEY3FXd0ZvcENUMEFvSm1ScWJFUWpPQnFWYmZINnhneXBiN3NlSURhNTdu?=
 =?utf-8?B?OTM4L0I3S1FDU2QyZEdJY2Fmd25tSXBqaWJrZVAxcHNFRVNyQVdTVXVYQUZO?=
 =?utf-8?B?U1VWbzlrcG1vbmNIRzMwN1NYaWpwRmZYaGwyeWZpUVI3bGxha2xjeTZsaTZT?=
 =?utf-8?B?dlhaNTVCcUl1TmYzL0JkbzMwM1krU0hhMFhsd21Rc2hUNnhtZE10U3R3ZHZT?=
 =?utf-8?B?T3VzQmY0SmVQc1djZktHSmpVbGh6blNSOFpjMGxGQm8zMDl1Z3pRcDd4c2ZJ?=
 =?utf-8?B?bVJ6QWZ0Q0IxNWlnVzlLcHNkSDVTS2NLQU9wNU9iSU5NaFd1UHRrVDdJc2FH?=
 =?utf-8?B?STZzazdncnVRWGlPcC9sNWh5dU9XR1doSHpVZVZRL2FzRDhOWVdyTnlxUEtG?=
 =?utf-8?B?VVYwemNvUTRScU9lUTRZQWswUGJoSHBDNmlXMGViMVI4VFB2OGt1amFSMGUy?=
 =?utf-8?B?S0xaVjJ3WDNUZjg3N3JBbS9mRzU5U3BwdjVseTBmajlQV0ZQS0xIeng1ZjlY?=
 =?utf-8?B?UXNuVnNSZmdsMDkrSGg3SzI0NVo2RGFONkp4NUZZYkxLbGZ4ZTdUSVFtcWZE?=
 =?utf-8?B?Uk05MlRLU2l3MFplblRJcFVIQnluMXFSOUV1cWpDK2tEcDNtZUxET2JoNjNr?=
 =?utf-8?B?dXRiM2lnU1hqZnhLcGFFM1RCYUV2QlN6WnFtdGVvdEMveG9NYXFUU0llby92?=
 =?utf-8?B?aEpVWXZBVzhLQTRsbEt2eWt1MFVpcFZjakxPOXlVNUJKbi80Zlo4UnVkbmlr?=
 =?utf-8?B?dERPSTZYdW1lVGw5Q2VJaURiRzBzRGtsbnMvK3Q2N1JNNVFubk5hTnBxMS9S?=
 =?utf-8?B?cEJuNDZ4am9hQUk5d3Uzb2x0dzkrTjhYSGt0QksxOUFUSW52L0txS2VmN1BW?=
 =?utf-8?B?a3BVWlhuL1QwTFk3eXRMVTQ3SU5xeEZWOG4xcXdlejlMQk5wTHI5U0c2MStv?=
 =?utf-8?B?QWpxVjU2TzkrTGVlTnpTM0F4bHcwSVVZZHlVNDNUNVF5V0t0OVBoV3BEZ0Jr?=
 =?utf-8?B?SjBZR2M5VGNSMWJKci9SWVM3b1JrREhGRmhicmdBYU4wQkg1QTBpQUNSTUky?=
 =?utf-8?B?dHl3ZTdTY3BacXQzRTZDWTM2bkpBYi9sSVp2RWJVR0lYYUc3THV4Q2RVeHhx?=
 =?utf-8?B?OHdrMFd3dXJFemlHVE44MEJRSWptQTFLSTlBRkIzRXUzK1c0aVdtM0I3VUEx?=
 =?utf-8?B?cFRaTWtMSlU1Um5qaFF4T3kyWDc3WVBqbW1TUng0ZlJyS0JLTElVY3poYnBD?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V4+xvKl7YIiA09d3MKa3Sc+aE5Riz45chLbYVpfc/pCgAGGzZcfvaNB+lKH1cSJOnc2uPS6y7poLS6p0EbWxdRwQUGA2ai1RpBL7uHm+ZcVdVGDEtv/ImMvIpU3vdeBRyv6FA6kJ9j9G/MHf0f3S1Ux34j/bNF0F24IsXsVINKVD2ZSSOMWa/tz+ozYYidOxTfqABPEE6I2wyVl+JpOkT4AQp//YIyRWSsCgyvgGamdbWUZtWLZWA8KWw/yuNRDfuWHLf59xIKTDSMXd+eC5mRPo3ciS7Qt6PinN6aDshNn7lJqGTHvSP+Z264llHSmt0h46EwBzoL1/7NFnKQlvJt3DI3Wp8gKypBiPnBlKiuTQmufxnZNH+N4uQI+i6HKZvc0xeqQzZQV2TAQ+5vSSHQlUjPVbkQIYdzEIYIT3Hjaw/VXAc7dOJckGcJho/YZy3WsBPLMgEMRwR+3ZLm9WRG72MkJORgPyi0c67LxGn0XrbJDwMRNYXvGTzdPzf6djPcKfQ86lvAG533QVA9QHEnqsdIZ3tuJskQfoqVAwXFGoQnxsGVJ7M6CPNoa+hLc9vqcKxNQOCvBVD26YrPfeZq0P6JsfAfARm2NZBOof2Gs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d46956-67ac-4198-7b75-08dd657ddfa2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 18:02:25.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJWsqOZWYm3k2Jz6PjzspsTCW/bUIHp3t9ZRzfIXBgakJOUSHt43vc/duu0t6oW+9c9L0TyNBz1gqIy4XoicAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503170129
X-Proofpoint-GUID: 1sgVuSsyczDjeR-kgfIDCGPyLyDe371P
X-Proofpoint-ORIG-GUID: 1sgVuSsyczDjeR-kgfIDCGPyLyDe371P

On 3/17/25 1:48 PM, Olga Kornievskaia wrote:
> On Wed, Mar 12, 2025 at 8:09 PM NeilBrown <neilb@suse.de> wrote:
>>
>> On Thu, 13 Mar 2025, Olga Kornievskaia wrote:
>>> On Wed, Mar 12, 2025 at 9:22 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>
>>>> On Tue, Mar 11, 2025 at 5:42 PM NeilBrown <neilb@suse.de> wrote:
>>>>>
>>>>> On Wed, 12 Mar 2025, Olga Kornievskaia wrote:
>>>>>> On Tue, Mar 11, 2025 at 11:28 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>>>>
>>>>>>> On Thu, Oct 17, 2024 at 5:42 PM NeilBrown <neilb@suse.de> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> NFSD_MAY_LOCK means a few different things.
>>>>>>>> - it means that GSS is not required.
>>>>>>>> - it means that with NFSEXP_NOAUTHNLM, authentication is not required
>>>>>>>> - it means that OWNER_OVERRIDE is allowed.
>>>>>>>>
>>>>>>>> None of these are specific to locking, they are specific to the NLM
>>>>>>>> protocol.
>>>>>>>> So:
>>>>>>>>  - rename to NFSD_MAY_NLM
>>>>>>>>  - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm_fopen()
>>>>>>>>    so that NFSD_MAY_NLM doesn't need to imply these.
>>>>>>>>  - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission() and
>>>>>>>>    into fh_verify where other special-case tests on the MAY flags
>>>>>>>>    happen.  nfsd_permission() can be called from other places than
>>>>>>>>    fh_verify(), but none of these will have NFSD_MAY_NLM.
>>>>>>>
>>>>>>> This patch breaks NLM when used in combination with TLS.
>>>>>>
>>>>>> I was too quick to link this to TLS. It's presence of security policy
>>>>>> so sec=krb* causes the same problems.
>>>>>>
>>>>>>>  If exports
>>>>>>> have xprtsec=tls:mtls and mount is done with tls/mtls, the server
>>>>>>> won't give any locks and client will get "no locks available" error.
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> No change from previous patch - the corruption in the email has been
>>>>>>>> avoided (I hope).
>>>>>>>>
>>>>>>>>
>>>>>>>>  fs/nfsd/lockd.c | 13 +++++++++++--
>>>>>>>>  fs/nfsd/nfsfh.c | 12 ++++--------
>>>>>>>>  fs/nfsd/trace.h |  2 +-
>>>>>>>>  fs/nfsd/vfs.c   | 12 +-----------
>>>>>>>>  fs/nfsd/vfs.h   |  2 +-
>>>>>>>>  5 files changed, 18 insertions(+), 23 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
>>>>>>>> index 46a7f9b813e5..edc9f75dc75c 100644
>>>>>>>> --- a/fs/nfsd/lockd.c
>>>>>>>> +++ b/fs/nfsd/lockd.c
>>>>>>>> @@ -38,11 +38,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
>>>>>>>>         memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
>>>>>>>>         fh.fh_export = NULL;
>>>>>>>>
>>>>>>>> +       /*
>>>>>>>> +        * Allow BYPASS_GSS as some client implementations use AUTH_SYS
>>>>>>>> +        * for NLM even when GSS is used for NFS.
>>>>>>>> +        * Allow OWNER_OVERRIDE as permission might have been changed
>>>>>>>> +        * after the file was opened.
>>>>>>>> +        * Pass MAY_NLM so that authentication can be completely bypassed
>>>>>>>> +        * if NFSEXP_NOAUTHNLM is set.  Some older clients use AUTH_NULL
>>>>>>>> +        * for NLM requests.
>>>>>>>> +        */
>>>>>>>>         access = (mode == O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_READ;
>>>>>>>> -       access |= NFSD_MAY_LOCK;
>>>>>>>> +       access |= NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NFSD_MAY_BYPASS_GSS;
>>>>>>>>         nfserr = nfsd_open(rqstp, &fh, S_IFREG, access, filp);
>>>>>>>>         fh_put(&fh);
>>>>>>>> -       /* We return nlm error codes as nlm doesn't know
>>>>>>>> +       /* We return nlm error codes as nlm doesn't know
>>>>>>>>          * about nfsd, but nfsd does know about nlm..
>>>>>>>>          */
>>>>>>>>         switch (nfserr) {
>>>>>>>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>>>>>>>> index 40533f7c7297..6a831cb242df 100644
>>>>>>>> --- a/fs/nfsd/nfsfh.c
>>>>>>>> +++ b/fs/nfsd/nfsfh.c
>>>>>>>> @@ -363,13 +363,10 @@ __fh_verify(struct svc_rqst *rqstp,
>>>>>>>>         if (error)
>>>>>>>>                 goto out;
>>>>>>>>
>>>>>>>> -       /*
>>>>>>>> -        * pseudoflavor restrictions are not enforced on NLM,
>>>>>>>> -        * which clients virtually always use auth_sys for,
>>>>>>>> -        * even while using RPCSEC_GSS for NFS.
>>>>>>>> -        */
>>>>>>>> -       if (access & NFSD_MAY_LOCK)
>>>>>>>> -               goto skip_pseudoflavor_check;
>>>>>>>> +       if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NOAUTHNLM))
>>>>>>
>>>>>> I think this should either be an OR or the fact that "nlm but only
>>>>>> with insecurelock export option and not other" is the only way to
>>>>>> bypass checking is wrong. I think it's just a check for NLM that
>>>>>> stays.
>>>>>
>>>>> I don't think that NLM gets a complete bypass unless no_auth_nlm is set.
>>>>> For the case you are describing, I think NFSD_MAY_BYPASS_GSS is supposed
>>>>> to make it work.
>>>>>
>>>>> I assume the NLM request is arriving with AUTH_SYS authentication?
>>>>
>>>> It does.
>>>>
>>>> Just to give you a practical example. exports have
>>>> (rw,...,sec=krb5:krb5i:krb5p). Client does mount with sec=krb5. Then
>>>> does an flock() on the file. What's more I have just now hit Kasan's
>>>> out-of-bounds warning on that. I'll have to see if that exists on 6.14
>>>> (as I'm debugging the matter on the commit of the patch itself and
>>>> thus on 6.12-rc now).
>>>>
>>>> I will layout more reasoning but what allowed NLM to work was this
>>>> -       /*
>>>> -        * pseudoflavor restrictions are not enforced on NLM,
>>>> -        * which clients virtually always use auth_sys for,
>>>> -        * even while using RPCSEC_GSS for NFS.
>>>> -        */
>>>> -       if (access & NFSD_MAY_LOCK)
>>>> -               goto skip_pseudoflavor_check;
>>>>
>>>> but I don't know why the replacement doesn't work.
>>>
>>> As I mentioned the patch removed the skip_pseudoflavor check (that for
>>> NLM) would have bypassed calling check_nfsd_access(). Instead, the
>>> problem is that even though may_bypass_gss is set to true it call into
>>> nfsd4_spo_must_allow(rqstp) which now wrongly assumes there is
>>> compound state (struct nfsd4_compound_state *cstate = &resp->cstate;)
>>> ... (but this is NLM). So it proceed to deference it if
>>> (!cstate->minorversion) causing the KASAN to do the out-of-bound error
>>> that I mentioned. It most of the time now cause a crash. But on the
>>> off non-deterministic times when it completes it fails.
>>>
>>> I really don't think calling into check_nfsd_access() is appropriate for NLM.
>>
>> Why not?  What is there is inherently inappropriate for NLM?
> 
> I spoke too soon. It's not about calling into check_nfsd_acces()
> (though it's a problem for v3 because there isn't a compound state!).
> The real problem is "access" content that's being passed into the
> nfsd_permission() function.
> 
> I don't fully understand the logic. But before this patch, "access"
> (acc) was (re)set to "NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE" before
> calling into inode_permission():
> @@ -2534,16 +2534,6 @@ nfsd_permission(struct svc_cred *cred, struct
> svc_export *exp,
>         if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
>                 return nfserr_perm;
> 
> -       if (acc & NFSD_MAY_LOCK) {
> -               /* If we cannot rely on authentication in NLM requests,
> -                * just allow locks, otherwise require read permission, or
> -                * ownership
> -                */
> -               if (exp->ex_flags & NFSEXP_NOAUTHNLM)
> -                       return 0;
> -               else
> -                       acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> -       }
>         /*
>          * The file owner always gets access permission for accesses that
>          * would normally be checked at open time. This is to make
> 
> now it's doesn't get "reset" and passes all of what was set in nlm_fopen()
> 
>        access = (mode == O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_READ;
> -       access |= NFSD_MAY_LOCK;
> +       access |= NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NFSD_MAY_BYPASS_GSS;
> 
> which ends up being "write" instead of a read and inode_permission returned -13.
> 
> Here's my proposed fix for one the problems in the patch.
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 4021b047eb18..eb139962ac4c 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2600,6 +2600,9 @@ nfsd_permission(struct svc_cred *cred, struct
> svc_export *exp,
>             uid_eq(inode->i_uid, current_fsuid()))
>                 return 0;
> 
> +       if (acc & NFSD_MAY_NLM)
> +               acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> +
>         /* This assumes  NFSD_MAY_{READ,WRITE,EXEC} == MAY_{READ,WRITE,EXEC} */
>         err = inode_permission(&nop_mnt_idmap, inode,
>                                acc & (MAY_READ | MAY_WRITE | MAY_EXEC));
> 
> Now the 2nd problem. You mentioned checking for version before calling
> nfsd4_spo_must_allow for v3. So something like this perhaps but not
> sure if that's right?
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 0363720280d4..0106da76da89 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1148,8 +1148,9 @@ __be32 check_nfsd_access(struct svc_export *exp,
> struct svc_rqst *rqstp,
>          * don't support it
>          */
> 
> -       if (nfsd4_spo_must_allow(rqstp))
> -               return nfs_ok;
> +       if (rqstp->rq_prog == 100003)

<shudder>

I guess we're stuck with this because this function is used for both
NFS and NLM file handles.

Let's use a symbolic constant here, at least.


> +               if (nfsd4_spo_must_allow(rqstp))
> +                       return nfs_ok;
> 
>         /* Some calls may be processed without authentication
>          * on GSS exports. For example NFS2/3 calls on root
> 
> 
> In the end, I question, why not revert the original patch instead?
> 
>> I agree that calling nfsd4_spo_must_allow(rqstp) isn't appropriate for
>> NLM, but it isn't appropriate for v2 or v3 either.  We should add
>> version checks either before it is called or before the minorversion
>> check that it already has.
>>
>> NeilBrown
>>
>>
>>>
>>>>
>>>>> So check_nfsd_access() is being called with may_bypass_gss and this:
>>>>>
>>>>>         if (may_bypass_gss && (
>>>>>              rqstp->rq_cred.cr_flavor == RPC_AUTH_NULL ||
>>>>>              rqstp->rq_cred.cr_flavor == RPC_AUTH_UNIX)) {
>>>>>                 for (f = exp->ex_flavors; f < end; f++) {
>>>>>                         if (f->pseudoflavor >= RPC_AUTH_DES)
>>>>>                                 return 0;
>>>>>                 }
>>>>>         }
>>>>>
>>>>> in check_nfsd_access() should succeed.
>>>>> Can you add some tracing and see what is happening in here?
>>>>> Maybe the "goto denied" earlier in the function is being reached.  I
>>>>> don't fully understand the TLS code yet - maybe it needs some test on
>>>>> may_bypass_gss.
>>>>>
>>>>> Thanks,
>>>>> NeilBrown
>>>>>
>>>>>
>>>>>>
>>>>>>>> +               /* NLM is allowed to fully bypass authentication */
>>>>>>>> +               goto out;
>>>>>>>> +
>>>>>>>>         if (access & NFSD_MAY_BYPASS_GSS)
>>>>>>>>                 may_bypass_gss = true;
>>>>>>>>         /*
>>>>>>>> @@ -385,7 +382,6 @@ __fh_verify(struct svc_rqst *rqstp,
>>>>>>>>         if (error)
>>>>>>>>                 goto out;
>>>>>>>>
>>>>>>>> -skip_pseudoflavor_check:
>>>>>>>>         /* Finally, check access permissions. */
>>>>>>>>         error = nfsd_permission(cred, exp, dentry, access);
>>>>>>>>  out:
>>>>>>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>>>>>>> index b8470d4cbe99..3448e444d410 100644
>>>>>>>> --- a/fs/nfsd/trace.h
>>>>>>>> +++ b/fs/nfsd/trace.h
>>>>>>>> @@ -79,7 +79,7 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
>>>>>>>>                 { NFSD_MAY_READ,                "READ" },               \
>>>>>>>>                 { NFSD_MAY_SATTR,               "SATTR" },              \
>>>>>>>>                 { NFSD_MAY_TRUNC,               "TRUNC" },              \
>>>>>>>> -               { NFSD_MAY_LOCK,                "LOCK" },               \
>>>>>>>> +               { NFSD_MAY_NLM,                 "NLM" },                \
>>>>>>>>                 { NFSD_MAY_OWNER_OVERRIDE,      "OWNER_OVERRIDE" },     \
>>>>>>>>                 { NFSD_MAY_LOCAL_ACCESS,        "LOCAL_ACCESS" },       \
>>>>>>>>                 { NFSD_MAY_BYPASS_GSS_ON_ROOT,  "BYPASS_GSS_ON_ROOT" }, \
>>>>>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>>>>>> index 51f5a0b181f9..2610638f4301 100644
>>>>>>>> --- a/fs/nfsd/vfs.c
>>>>>>>> +++ b/fs/nfsd/vfs.c
>>>>>>>> @@ -2509,7 +2509,7 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
>>>>>>>>                 (acc & NFSD_MAY_EXEC)?  " exec"  : "",
>>>>>>>>                 (acc & NFSD_MAY_SATTR)? " sattr" : "",
>>>>>>>>                 (acc & NFSD_MAY_TRUNC)? " trunc" : "",
>>>>>>>> -               (acc & NFSD_MAY_LOCK)?  " lock"  : "",
>>>>>>>> +               (acc & NFSD_MAY_NLM)?   " nlm"  : "",
>>>>>>>>                 (acc & NFSD_MAY_OWNER_OVERRIDE)? " owneroverride" : "",
>>>>>>>>                 inode->i_mode,
>>>>>>>>                 IS_IMMUTABLE(inode)?    " immut" : "",
>>>>>>>> @@ -2534,16 +2534,6 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
>>>>>>>>         if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
>>>>>>>>                 return nfserr_perm;
>>>>>>>>
>>>>>>>> -       if (acc & NFSD_MAY_LOCK) {
>>>>>>>> -               /* If we cannot rely on authentication in NLM requests,
>>>>>>>> -                * just allow locks, otherwise require read permission, or
>>>>>>>> -                * ownership
>>>>>>>> -                */
>>>>>>>> -               if (exp->ex_flags & NFSEXP_NOAUTHNLM)
>>>>>>>> -                       return 0;
>>>>>>>> -               else
>>>>>>>> -                       acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
>>>>>>>> -       }
>>>>>>>>         /*
>>>>>>>>          * The file owner always gets access permission for accesses that
>>>>>>>>          * would normally be checked at open time. This is to make
>>>>>>>> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
>>>>>>>> index 854fb95dfdca..f9b09b842856 100644
>>>>>>>> --- a/fs/nfsd/vfs.h
>>>>>>>> +++ b/fs/nfsd/vfs.h
>>>>>>>> @@ -20,7 +20,7 @@
>>>>>>>>  #define NFSD_MAY_READ                  0x004 /* == MAY_READ */
>>>>>>>>  #define NFSD_MAY_SATTR                 0x008
>>>>>>>>  #define NFSD_MAY_TRUNC                 0x010
>>>>>>>> -#define NFSD_MAY_LOCK                  0x020
>>>>>>>> +#define NFSD_MAY_NLM                   0x020 /* request is from lockd */
>>>>>>>>  #define NFSD_MAY_MASK                  0x03f
>>>>>>>>
>>>>>>>>  /* extra hints to permission and open routines: */
>>>>>>>>
>>>>>>>> base-commit: c4e418a53fe30d8e1da68f5aabca352b682fd331
>>>>>>>> --
>>>>>>>> 2.46.0
>>>>>>>>
>>>>>>>>
>>>>>>
>>>
>>


-- 
Chuck Lever

