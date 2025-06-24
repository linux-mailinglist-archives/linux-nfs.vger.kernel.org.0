Return-Path: <linux-nfs+bounces-12728-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2B3AE6A41
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 17:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7041BC1FD7
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jun 2025 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E9A2D8768;
	Tue, 24 Jun 2025 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JL7KU+on";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y7sc0Ad8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B852D6629;
	Tue, 24 Jun 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777645; cv=fail; b=b9zm9ImLOPxRNtTWxIqxNrUQWtoiePHuKjCg210e1T/nOknp8Kt++KtqjWppsrPGXKbT72GcVyurL1kgC/+bc8JC5BVx6+jgGFwaAN15bztmwZDg54+9t/kMfwv/C5IgqibfAT3xOJZX2y1+bqzHeqx0Ky1gaGIUUQo2vYWqkNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777645; c=relaxed/simple;
	bh=I2o5lwmDmsiBhHe9Ohl1UU7zdhkRLRar2JdSLNTKktg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZtoOVNCZy8DmKE+c0dbp6XfqjRPB/LDNNH+iYdieFs6ElYOQ2l6+thjvY5rPPYAJdwHJbqxqk8iEnbQfqFjsdAzGrFx/2zZIFxt9ICPSC6yc941XXk97lIV8nps3XLy4vHEqNK1gjP1SGD69ZiHr8qGr6keF5+WIlEvGVKej7Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JL7KU+on; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y7sc0Ad8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OCiGZl025836;
	Tue, 24 Jun 2025 15:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=quDws25qwmmTWwmxze7p8xUi28HtVJMPbrk2bTueHuo=; b=
	JL7KU+ongAUFlFuP5MbUHx7zhB4zMHibh2+baezpdiOWEuq+ijbA9rYLNWFQ2+N6
	1X15fExpl8g/BSWt/Z2UBulhUR570tithTvJnSSc+0rResf0UgJ41z3hWktTeZDS
	kcubzImwjoAOJBkstHlGMe1aFu4EgYmg9EoayEb3/8y/QsAl26MxzlADqVIBSQtu
	IBxoYqOVPb20A6pRP48sY0MU3SYoMt72Z2iufEUVl6Tt2HOiVda2IwrltPqOhy0c
	bkDLlwBkyvaVcttFpd0CjdvClNu0xEdxh/B08v4w7OuQfUOFNvAm242BorZImH1N
	BqBbxFHH+E7PzaeYcobnpw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7uwd7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 15:07:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OE59xU024401;
	Tue, 24 Jun 2025 15:07:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehkqs066-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 15:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8VG8Fo8hBd2gLc1FW3GOkPeahJIyBG5rbeT4iJoRlDNbDrkV8WLo2iwMBOdQC/4gvC10meTVYOyLeaw7wkLS0pRIUHLcSTYYU6AcjpBE9Ftmrg0XLgsduvbQVR57i+r2X2RFau2zeKBkzBsWSoP5q6qPoCS6uAU7mf6ep5FZR+7VsOhyNFLP4w7zSiqaik9I98bjVd2pQ7qk3aPyGtYu6L2zXjBKoUuyqGVXfM5gSBtmYAGtj1jqg2USDC6duLMWfzhNW6LeNSmGh76CL9icmUGHfXwX8fVIcE+1kGbTQ9+1y9UIkX42y+oe2+VLe5qUh90JfSrXDesPfDGE8Bz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quDws25qwmmTWwmxze7p8xUi28HtVJMPbrk2bTueHuo=;
 b=O5fWA7YENlFW9jyAUeKumhPYSD29j8q190peybNDAmEMP0W8sQFTf+aLvW/0+7lNQFiaviB4xTeIl5od+m4jy8vG6+ueZT9iBYwFJKJYglEk1KTrNyuD3kqu3AoWcgUXluv3X1tUUJWhYxTl1k6zuiT8Hj4rhZ7pFmr/rlEZSEsyFOyBgMusK5EVKoJVYRbkIGMo0+Ii9cTdJhcM2mW6uAOvYjvpua1UB9pCaxW/Bh/XCD8UIpL1L9f6CoR879jM4BIzvym56TnrzqgCOTi+S3lp0IpqZ1InPZ436mNOednB6Grrplc4tejv956ztZxvVwiQPRbqTPCloKX4zaDdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quDws25qwmmTWwmxze7p8xUi28HtVJMPbrk2bTueHuo=;
 b=Y7sc0Ad8AjxR5fidZg6qSauQPkiZSX0b6ADm2M5Tw4hEyNDbJW/rCP69IfZLshxKoL0pPZMQp88nxTiEnQXMaJIowPnUbJjdv+yFC+UJ9bmU3EdwwoAo1j7KinjysS4YSEwkk+ejnjws927tldIxE9jN1OlyyAHdAOKY61jPil4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5762.namprd10.prod.outlook.com (2603:10b6:303:19b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 15:07:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 15:07:09 +0000
Message-ID: <cecf4793-d737-4501-a306-0c5a74daaf30@oracle.com>
Date: Tue, 24 Jun 2025 11:07:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Using guard() to simplify nfsd_cache_lookup()
To: NeilBrown <neil@brown.name>, Su Hui <suhui@nfschina.com>
Cc: jlayton@kernel.org, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20250623122226.3720564-1-suhui@nfschina.com>
 <175072435698.2280845.12079422273351211469@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <175072435698.2280845.12079422273351211469@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:610:5a::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: f8089e43-c9ed-4154-c04a-08ddb330ca78
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YmxHamp3RVBDMng3WVFhSVRUYWR3VUgvN3ZDYVJWbmxwdm5uU0lVT0NuYTFv?=
 =?utf-8?B?Y3hnK3RCQnVNLzRoTjFhQTFwY3FiN2lOS3kzMTg1a05mMVJwZElGTkVzSXF4?=
 =?utf-8?B?blNrVW9wYVdoTDdMWXZOZElsbUxYOWFSYjh3T2ZhekRtKzdsY1FicGh4bWUr?=
 =?utf-8?B?anpiZnNmbCtyWTJJd1ZLdVdCb21zY3IrL29kaHpMSE82S2tTS2RXUzByUFdy?=
 =?utf-8?B?Uk92R0NDcnlTTCtpQWJIN25uV3o4aHRzWHhqalVhUWM5L3FoUlh6ZlNjTTgy?=
 =?utf-8?B?aTNUaWthMFdkUXpmakdaZ1cvTDJnQ2FGdDB3bEFnVDhmLzFDTnN6SGc5d1Qy?=
 =?utf-8?B?d2JLSkJCcUpQQUFxZjUzYUdUZkJHbHgxZUVZRzVFemlkN3NWemFtS1cvdFFB?=
 =?utf-8?B?WHhnaWhLWDBKQk5nZzFmK2JmbDU3YmlHWkRKZSs1MlpHM0RUQ2ZQb0dxL2dK?=
 =?utf-8?B?a2xNU1VVUTJaeWxYNGhubHBCMzlIcTdWTkRMeDJpY3V2U2RXdStuLzdMSy9C?=
 =?utf-8?B?Y2p3R1RoVlY0SWdtMXI3dzNzWm56c3pWNXUzRm82T3plWUtPcVp4aTNHcXRL?=
 =?utf-8?B?cGFJZmpvQWdMU0lXdTh5QityeFFBMzdjbjBPcm13bzZOUlVnNGwrcExTUFpm?=
 =?utf-8?B?MXhDZHg2VDNaN3BUbUJWaU42YWdqUUc4emJacnEwSE01Y1VsTWdqQ0s5Wnhk?=
 =?utf-8?B?bm9NWlBFL3N1OXl6M3pUZVY5dGVDREZqdlZzaVdIZm4zWjdMd1VLZWN5Q2pU?=
 =?utf-8?B?Q0k5UWpWOEJsTzY2U3ZYSHlWTW9OclNBRUtxeE15djBQT20rd0ZFZ0VoNGtW?=
 =?utf-8?B?RTlYNUM4VUN0eUI3VkhPVzFQR2hxN0MrcVVpK0dSYWdYQm9IWUJXaVJ0VnJP?=
 =?utf-8?B?TVhPSEZjWWNPTnJ3UXJueG1SUkk2Zmt6VzJSQUllc1VwejJ5bWRGRVZOdlFz?=
 =?utf-8?B?ZUdLUGZHU3hlV2FYKzBBYzB4bWFvZlF5a0toMlBKZC9kTk9rZ09VU056WWth?=
 =?utf-8?B?RlFvdUI3OVRqY3FWdE9TbnZoN0Y4dmxiMU9icFpXVGgwdTI4MSs2WXJBSGFG?=
 =?utf-8?B?bnNnSCtJcWVQTHk0aW1KamY1c1B1dDVSVTJNZHJKc3oySi9LcTlQSmwyTlZJ?=
 =?utf-8?B?ZzNvSzlJVTl2cmcrcTAvSHdxVGxmTEg2WDNzYmtGV0VwaHdwaXJMUmlUZnQ4?=
 =?utf-8?B?aDd3QnpBa2g4RHBpeVh5ZVZneDFuMG1lN1RhVjg1V0hVTHhpdEFNcWRHNFNJ?=
 =?utf-8?B?UWNaZnpPQzNHODY5TDgrVGZ6RCs5YWk1WWsrZlB6Q0gwcEFmR3hBTU9jdmlr?=
 =?utf-8?B?UFdlMUtLQnh6T3o1K2x5SWVRYUsvd0hmamtkbXRubGwwbFNOeUgzTnFTbVls?=
 =?utf-8?B?cDZnVElMSjlRZEZUcXowRDM0clNuZ0hXRllzaS9uaWlrWlNZVlVCS1lzRXpN?=
 =?utf-8?B?bUNWM2Q4L0ZUVTBjTDc1NzhRdzgvVkZrMEtVN2pXb3gvMzQ5Mis3bjlrMDBi?=
 =?utf-8?B?SHh1TDdqYTBVLy8yQW40VjBZVk5NU3lWU0F5eU5tU3FuckozRjcvUHdyTERn?=
 =?utf-8?B?ZEYrazR6UnpweUxPdG9Bd0JnRjFyL085dlFiMHE1ZlNCV2I0KzNBNjREWi9r?=
 =?utf-8?B?TlNKbS9qeDZVU1Ewb21HVUhTaGpzSjBET2ZkbUZWUmtDMXR1Myt2UEZBSVE4?=
 =?utf-8?B?QWRqMFhPSUVHc1g5SHlKRmJqSFQwRk5Yb25RSkVWTk11TThOcHI2NG5HREtw?=
 =?utf-8?B?eHFsTUU0QTBSR0s4eU1Ib2Y3WWk4RUE1Qk9YbEtkM1RUWFY0RnpoTjdSVGVU?=
 =?utf-8?B?bk9ub2Z3WWQrOFNqeUREMnNNTWFicmxKVEV3blkrWE9VaFpHUGlVNVg3MFdV?=
 =?utf-8?B?eTRKc2VzeVRCeHdzVkY5N3VYSE9SQy9VUno3UHlOUWdMWklKL2ZOR3pwOVFD?=
 =?utf-8?Q?qwhSjh8PGzc=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?REJmUnk4RFd4akxjRFZNRjVvQWZaNjJHTUhpUm5VU1ZiVk1oak42WFArcXpO?=
 =?utf-8?B?T2xNVlorL2Y3b2ZCbkllOUJNdS9Pbk1qTHRBNWlFTUwxdXNuc2hKRjRWWlRu?=
 =?utf-8?B?NmdEelUzcVBIS1lWcEk3RGN1RGorK2gwOVZuamdEYW5BNDFUTDkzMnBXWGJo?=
 =?utf-8?B?ZGlQb0V4dEhrMGRGbjd3VFpkRnBUNVExRmNoUzZOTDdUcGZHemxsVll5Qit4?=
 =?utf-8?B?eDk1cUh3UURxTXZBQWcyS2Vxbkc5U2EwSmU4VzNSeUpRMEdscnlwcTNBdldV?=
 =?utf-8?B?aXBVV3FRckZUd2NGWkdRN1E3eExFMFVIMFpTQUI1cmZURDA4cDdianlPcnpC?=
 =?utf-8?B?eVZFR0NoVGtCMVlkRGZ5d21YdXk4VmUrVEtKZEZab0diMFR3d3dFZWE0K1FS?=
 =?utf-8?B?TEU2SE1uZW0xK2xkOEpGTUlHTFZBRWdUc0NVR1VRcHhSdG9ibzd5bEZvZWFo?=
 =?utf-8?B?a0YzSlJMMWd1d2k1eGxuTDk4NmdGR2FDMEY1SHdJZnBsS052MDNCU3Z1bHBw?=
 =?utf-8?B?d2h3WDZ0MnBmUUlka1VqZFlhYlRrcjB6bTFhNm1MMmFrUWxGZDVPKzRpcHdS?=
 =?utf-8?B?bXovUHRNQ3J0bEZJRDJzaENlK2lXeXgzMHZBblpMQStad1N3SW5odjM3eVhI?=
 =?utf-8?B?UmRRbnhadTYyVFZGSnI1ODczNGtCZXViOVh5VGc2cUVFWHJzeXVtOXVObTd4?=
 =?utf-8?B?Nm5LaXFQU2NpbUk3MFdYaGovdmRld3RkYWNoVm84bjF1TXp3QVVJVlMxSWFw?=
 =?utf-8?B?MGJ1UkhlR1V3NE5RV09udkxWWlgvbkFYODNFTEkvK2JzeVBWcGE4b2dpVnpu?=
 =?utf-8?B?SmJucDVDWGNaVWVDMkhneGRmdkhQbTRDSlJmRFNaMGlhZCsxWXdJTm1XTGQ4?=
 =?utf-8?B?a0ZPTUJLMUNic3dQMVpVdkhtSm8zLzZ6YVJFU3BqOE55RkkrQ3BZbDNIamFh?=
 =?utf-8?B?ZzUvY2Q3eUVLencxNmpMaExKRjNvb2FiRlhoSUc5NllhMTRISkZjZVRxTFlm?=
 =?utf-8?B?TmMrdm9lMloweG81d2lsQVh5WUlEaS9GNk55NjAxVUVvNWJsNUt4Qmg1bGly?=
 =?utf-8?B?Z05WL3NRUnlNR2pMR0I0b3R3ZDIwZno1L0RBTnUxbUoyN2NiV3RZcndaY3BK?=
 =?utf-8?B?VExlSTJ6YkQ4L05BZVNXcWlad0txdmhEamh1UThiQkFUWkJOSHc4ZjY3U3Br?=
 =?utf-8?B?c0FZL05tTVQ2d0VSdE1WN3dsakNJQjBLRitxek9SYy9pdzZKckxkUWpKR0g1?=
 =?utf-8?B?WkpWSjVnT0thVmVYL3V3eCtPbElGaFJ2ays0NlN4MjVnSmg4Q0Q3NmdmWm92?=
 =?utf-8?B?OXZhYllFYUQ2aVRNckswTDVwNzZlSzhpQ1YzNTFyZlErdVVMOGpDYnBOYjh0?=
 =?utf-8?B?RzI2VjVYTEN4QVI2NUVjeFFpdGRab25vSUVEZnZzM1g4M3JzaXNNOUw5NHIz?=
 =?utf-8?B?Qks3dTZta2lVaU04bVI3M2s5Y3ZuRWhpbkprcHlsajNObDM0ZUFvV08zazE3?=
 =?utf-8?B?V2g4aDhvOS8xRXZzVHRIalJ2ZUJjVVFabXNkM2JjQ1pwTzd1d0ZQZjdTa1Q5?=
 =?utf-8?B?bC9LWjFKU2JxdWNsN1UyZ2FZSkFjMHVXMThEYXAxMlh0MWMya3d4L1JTdXRM?=
 =?utf-8?B?WmNRY25oUXQyTnQzNXNWdmY2REtxUFc3SFBXMXk2SjFVWEFaRTNhUjJrejJu?=
 =?utf-8?B?eDBtUHNiMEx0S3ZpNEJCNVhFZ1RqZWFZUnlJSk5Bby9zWmFCTHpqME1STXZM?=
 =?utf-8?B?dzl0RGhSeXNMSllzTWRWOHJMRkQzY2M0bFozZHhaMWsrVVZaYnRZTWFaRXoy?=
 =?utf-8?B?Y3ZpU2l6dXBoOXI5NnR1MlowMEJSN2Q0TDVsQ0hYNFV0UTl5OFAydmFpYU45?=
 =?utf-8?B?N1E1Yi8xZHpsUGE1N3h6WDlIUTdjcVpyekdZQVFCNUM1MnRCdi9PZHp4cmIw?=
 =?utf-8?B?ci9hbk12TUZ2YVBkSmkvZjVUMWNFZkM4b29SaGkzWlJXNWhrTEVSTWRTeEZx?=
 =?utf-8?B?UWFXejhFT1pXYkNUMnBZajVvblNRdDV0Z0dRTmhvWCtaNCs0aDB6TGx0c1Bi?=
 =?utf-8?B?NlU1ajVSN3NOVDltVGpYNXhsM2wyQTk3M1ZUd29WMnhYZmg3U1NQSkdPblZa?=
 =?utf-8?Q?URJvJUVDj+tLby2Wy9hRHiDPO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lanczDv3PChPh6VgxvFh4zejJiSVuZi4kNWtXSnImOXAxg/hTuM+4NkYQMmGkahNhUgh+Te2GJTokL5hSvgk1gu4bwdDgw/km8pENYHFGpwDdokMKQsJHERNGXUMZd8FbSzUL1zCpqbjgzEYbJxXYlMGcLY3mxIzje+iWGlq3RNvcB3/tVHhnp98xPoR3CAD823/dNnd/gIk8zvCwlM0hgHfJJ2cqJowY/AE3q771gqYi3mh2lvkBS0Ou9jVZJ4v4mMeYVg/zsstcoJj+rs54QwwQfdjQzh6shc2CUuW7C23Gn0BeV3uY+hISgO2EwBehS1XPeFHRgiPhiiwYZtAlgZleZ+QJIAFJ896Yo2TKLl1Xi1+EdBfesQA43Z/YI7SrYAW42bjL6o0EHHF7LVcyAPoi4ZFmHnzInx80gyTejy2idl3j2dQf35hwo4/dEEeSWlvaeHFMAtyV668DtxnLlFbRHYYSN8p47M0CN9kBnXtDfrLs3zntrQEcewaeNLXix/NNS/VlDzoYIu9be/Xiv/LL/scf4taqJ1V+AAFXiirEvCmitfz4AYihxoFBRiSIms3hN83tAYkWlTKgFUPZ5+fwifYd/NVwrrAxWZE2Z0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8089e43-c9ed-4154-c04a-08ddb330ca78
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 15:07:09.5447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USv1uvhDbkH7DfvS3MIXOr4ueS0cZwIreLye/lbRIDvFPFnkdsucFD3vYwxCXr3PxR/sKXxnWSbiQZFff4C9vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506240126
X-Proofpoint-GUID: f1PvPwNpQjCg0NpLqFkBWK0TbGeTadcp
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=685abf23 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=SlVAvriTAAAA:8 a=f-KLSe5CiN4XqiWFdGkA:9 a=QEXdDO2ut3YA:10 a=qesGs21RGGeVIEdTuB6w:22 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: f1PvPwNpQjCg0NpLqFkBWK0TbGeTadcp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEyNyBTYWx0ZWRfX9If6aUE/HIZt QDUKMVeREdgjI5ci8g0wRO8rGSB8kzoANDa3pMasr4QJgwvYjoYTpRdmrPlZtBrVmD219SSiQxP du6akyrqppajUWxMVCiceInIngonoVioHeNBfbj2CQqFG//U+OkNQqkxngQpOwbso9w+anWecOo
 BDLbj6CenuDBKTx74iIYuP3nWKbY84ot+72x5IFHId7UOLKTtPnP1Plsi8rLiz7SoY0TjTyzhyF 77bFb6Gfv/d4+hH/3bM93RI9+1YNYMHSAt5R3QqKd+NBHLnCVVM8YAkVu3ysKG41J7mB0U35d2B h7hDwjN2xqBp+vma84GzOm4EqkMMwJQH0dPcRI3hrA++1egY7K7Fy6RieB4o+qCz4stBZXas4tx
 RRikACKV5iGKlKMhM4q5HL95US/HtRugMcbmn8piFDOm/427lc3aOVUQ0ZqgSuk6TvuE1b6E

On 6/23/25 8:19 PM, NeilBrown wrote:
> On Mon, 23 Jun 2025, Su Hui wrote:
>> Using guard() to replace *unlock* label. guard() makes lock/unlock code
>> more clear. Change the order of the code to let all lock code in the
>> same scope. No functional changes.
> 
> While I agree that this code could usefully be cleaned up and that you
> have made some improvements, I think the use of guard() is a nearly
> insignificant part of the change.  You could easily do exactly the same
> patch without using guard() but having and explicit spin_unlock() before
> the new return.  That doesn't mean you shouldn't use guard(), but it
> does mean that the comment explaining the change could be more usefully
> focused on the "Change the order ..." part, and maybe explain what that
> is important.
> 
> I actually think there is room for other changes which would make the
> code even better:
> - Change nfsd_prune_bucket_locked() to nfsd_prune_bucket().  Have it
>   take the lock when needed, then drop it, then call
>   nfsd_cacherep_dispose() - and return the count.
> - change nfsd_cache_insert to also skip updating the chain length stats
>   when it finds a match - in that case the "entries" isn't a chain
>   length. So just  lru_put_end(), return.  Have it return NULL if
>   no match was found
> - after the found_entry label don't use nfsd_reply_cache_free_locked(),
>   just free rp.  It has never been included in any rbtree or list, so it
>   doesn't need to be removed.
> - I'd be tempted to have nfsd_cache_insert() take the spinlock itself
>   and call it under rcu_read_lock() - and use RCU to free the cached
>   items. 
> - put the chunk of code after the found_entry label into a separate
>   function and instead just return RC_REPLY (and maybe rename that
>   RC_CACHED).  Then in nfsd_dispatch(), if RC_CACHED was returned, call
>   that function that has the found_entry code.
> 
> I think that would make the code a lot easier to follow.  Would you like
> to have a go at that - I suspect it would be several patches - or shall
> I do it?

I'm going to counsel some caution.

nfsd_cache_lookup() is a hot path. Source code readability, though
important, is not the priority in this area.

I'm happy to consider changes to this function, but the bottom line is
patches need to be accompanied by data that show that proposed code
modifications do not negatively impact performance. (Plus the usual
test results that show no impact to correctness).

That data might include:
- flame graphs that show a decrease in CPU utilization
- objdump output showing a smaller instruction cache footprint
  and/or short instruction path lengths
- perf results showing better memory bandwidth
- perf results showing better branch prediction
- lockstat results showing less contention and/or shorter hold
  time on locks held in this path

Macro benchmark results are also welcome: equal or lower latency for
NFSv3 operations, and equal or higher I/O throughput.

The benefit for the scoped_guard construct is that it might make it more
difficult to add code that returns from this function with a lock held.
However, so far that hasn't been an issue.

Thus I'm not sure there's a lot of strong technical justification for
modification of this code path. But, you might know of one -- if so,
please make sure that appears in the patch descriptions.

What is more interesting to me is trying out more sophisticated abstract
data types for the DRC hashtable. rhashtable is one alternative; so is
Maple tree, which is supposed to handle lookups with more memory
bandwidth efficiency than walking a linked list.

Anyway, have fun, get creative, and let's see what comes up.


>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>  fs/nfsd/nfscache.c | 99 ++++++++++++++++++++++------------------------
>>  1 file changed, 48 insertions(+), 51 deletions(-)
>>
>> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
>> index ba9d326b3de6..2d92adf3e6b0 100644
>> --- a/fs/nfsd/nfscache.c
>> +++ b/fs/nfsd/nfscache.c
>> @@ -489,7 +489,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
>>  
>>  	if (type == RC_NOCACHE) {
>>  		nfsd_stats_rc_nocache_inc(nn);
>> -		goto out;
>> +		return rtn;
>>  	}
>>  
>>  	csum = nfsd_cache_csum(&rqstp->rq_arg, start, len);
>> @@ -500,64 +500,61 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
>>  	 */
>>  	rp = nfsd_cacherep_alloc(rqstp, csum, nn);
>>  	if (!rp)
>> -		goto out;
>> +		return rtn;
>>  
>>  	b = nfsd_cache_bucket_find(rqstp->rq_xid, nn);
>> -	spin_lock(&b->cache_lock);
>> -	found = nfsd_cache_insert(b, rp, nn);
>> -	if (found != rp)
>> -		goto found_entry;
>> -	*cacherep = rp;
>> -	rp->c_state = RC_INPROG;
>> -	nfsd_prune_bucket_locked(nn, b, 3, &dispose);
>> -	spin_unlock(&b->cache_lock);
>> +	scoped_guard(spinlock, &b->cache_lock) {
>> +		found = nfsd_cache_insert(b, rp, nn);
>> +		if (found == rp) {
>> +			*cacherep = rp;
>> +			rp->c_state = RC_INPROG;
>> +			nfsd_prune_bucket_locked(nn, b, 3, &dispose);
>> +			goto out;
>> +		}
>> +		/* We found a matching entry which is either in progress or done. */
>> +		nfsd_reply_cache_free_locked(NULL, rp, nn);
>> +		nfsd_stats_rc_hits_inc(nn);
>> +		rtn = RC_DROPIT;
>> +		rp = found;
>> +
>> +		/* Request being processed */
>> +		if (rp->c_state == RC_INPROG)
>> +			goto out_trace;
>> +
>> +		/* From the hall of fame of impractical attacks:
>> +		 * Is this a user who tries to snoop on the cache?
>> +		 */
>> +		rtn = RC_DOIT;
>> +		if (!test_bit(RQ_SECURE, &rqstp->rq_flags) && rp->c_secure)
>> +			goto out_trace;
>>  
>> +		/* Compose RPC reply header */
>> +		switch (rp->c_type) {
>> +		case RC_NOCACHE:
>> +			break;
>> +		case RC_REPLSTAT:
>> +			xdr_stream_encode_be32(&rqstp->rq_res_stream, rp->c_replstat);
>> +			rtn = RC_REPLY;
>> +			break;
>> +		case RC_REPLBUFF:
>> +			if (!nfsd_cache_append(rqstp, &rp->c_replvec))
>> +				return rtn; /* should not happen */
>> +			rtn = RC_REPLY;
>> +			break;
>> +		default:
>> +			WARN_ONCE(1, "nfsd: bad repcache type %d\n", rp->c_type);
>> +		}
>> +
>> +out_trace:
>> +		trace_nfsd_drc_found(nn, rqstp, rtn);
>> +		return rtn;
>> +	}
>> +out:
>>  	nfsd_cacherep_dispose(&dispose);
>>  
>>  	nfsd_stats_rc_misses_inc(nn);
>>  	atomic_inc(&nn->num_drc_entries);
>>  	nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
>> -	goto out;
>> -
>> -found_entry:
>> -	/* We found a matching entry which is either in progress or done. */
>> -	nfsd_reply_cache_free_locked(NULL, rp, nn);
>> -	nfsd_stats_rc_hits_inc(nn);
>> -	rtn = RC_DROPIT;
>> -	rp = found;
>> -
>> -	/* Request being processed */
>> -	if (rp->c_state == RC_INPROG)
>> -		goto out_trace;
>> -
>> -	/* From the hall of fame of impractical attacks:
>> -	 * Is this a user who tries to snoop on the cache? */
>> -	rtn = RC_DOIT;
>> -	if (!test_bit(RQ_SECURE, &rqstp->rq_flags) && rp->c_secure)
>> -		goto out_trace;
>> -
>> -	/* Compose RPC reply header */
>> -	switch (rp->c_type) {
>> -	case RC_NOCACHE:
>> -		break;
>> -	case RC_REPLSTAT:
>> -		xdr_stream_encode_be32(&rqstp->rq_res_stream, rp->c_replstat);
>> -		rtn = RC_REPLY;
>> -		break;
>> -	case RC_REPLBUFF:
>> -		if (!nfsd_cache_append(rqstp, &rp->c_replvec))
>> -			goto out_unlock; /* should not happen */
>> -		rtn = RC_REPLY;
>> -		break;
>> -	default:
>> -		WARN_ONCE(1, "nfsd: bad repcache type %d\n", rp->c_type);
>> -	}
>> -
>> -out_trace:
>> -	trace_nfsd_drc_found(nn, rqstp, rtn);
>> -out_unlock:
>> -	spin_unlock(&b->cache_lock);
>> -out:
>>  	return rtn;
>>  }
>>  
>> -- 
>> 2.30.2
>>
>>
> 


-- 
Chuck Lever

