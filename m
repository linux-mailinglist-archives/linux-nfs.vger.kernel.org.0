Return-Path: <linux-nfs+bounces-2138-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A650686E2F4
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 15:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33AC91F2245D
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Mar 2024 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB196EB6B;
	Fri,  1 Mar 2024 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DODafHFb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uos4l+ZC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E7138C
	for <linux-nfs@vger.kernel.org>; Fri,  1 Mar 2024 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301948; cv=fail; b=Y75Mvz1ooOxQPGuvPb4s5Q3HAWTaTr2u3Uj0jhOqtShxs2WZiyeSx4jSr+yzrTQxSDf6pExTjKJhj0Ma4oxixGxW7za7ENOYw104VaK5+CsAXlJ2Z9z+AcN/uZHs70SulcgrVBOyvPhnPlhPErg/d+tl7JsDEE6PaHMl4OjPCbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301948; c=relaxed/simple;
	bh=iV4xNL3M2lG+/1YKnSYl/IwHSqVcwrQXq/SCOiGCpmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=svLcGKzI+gURWKqm3iRSWD1j3Z/cyyno4dQnI128YBYl/SWTr1EQJZg8oNeXznAjBZ5L5363kiw7ysv4rzBQfWD0E8SoLR43dB1CfVW5b7BahGK9S95zG8a35IOruj6XCgfdajSHa2bcTvTVi883JgaBfDiHpgaTI91QVyh4QlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DODafHFb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uos4l+ZC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 421DuH99022513;
	Fri, 1 Mar 2024 14:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=O9a/wUM48fe4HLFU2L0mbUNov3VWPI4AH+wwtfZhvJY=;
 b=DODafHFbpO5UoZVbbRepBwqbR2vHu5JsUnTnjVSgHw8v+izWcevUkzTfDa4fPOZeZ6cA
 wKM4DZJOzXE5k6vdue/ODMjkox/3aA8ax7DnBOTBT+fAZq+q+pdiVmF9NpvoBceVFZr2
 Vx/C1EE9+3LnFQOBW2nuD+YvpK27GC65MZcX6FjqfEoIyPukntSQ3RIPWj2lEjjxMoaq
 Odgh4GKIKsmEN/T+fxoUDdo1wS87pPBSlKJNBq3+x9MT3exUgtN2q1jo4vzJjfPcw7L5
 fW9LGGaun8RCWK0Whcp3r2p2o3JkNzW2gHmHjUUw13Y4rhKNxqUVvSydTYlks0dfyRun tA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7ccry7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 14:05:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 421DRSHr004734;
	Fri, 1 Mar 2024 14:05:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wjrq7us20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 14:05:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgyCOnY5/tGntL6/hws5p9DNHjLLxXG+1LnciwI6P7yiV+WU34L+iZQPakLEf8sliN7+V/vvh7RHqQsHw+ielDVsClKEBcbV5B8I56VG/mBL7br5ecq1gOWEsxESQUDIosph3QTGjgpdXeuuXII1s66dqhrrTycMDNXcBtXfX+QjAv+A490l5jOfPrcBdi6pBHXuczKnI+4D359ownRD4Vv9HGZn3d2YEhEvapuhtFZ8xI5Ad1kC9ZDT9anvkwTPJVdDpnvOAUZOK6E4SNdSRZFIeGA0JaumdixBAgOLfuPI1ImPnbRsuD8dL6XO1wQZIYkfvYAJFvGlIPrIXeJGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9a/wUM48fe4HLFU2L0mbUNov3VWPI4AH+wwtfZhvJY=;
 b=JdvsZ0F7qpCHUr+081fZJskBRkHLoQyedTl9lgFDXhkdLx+539yakkhcRDh+K83sFWDLE/Ol0TuXeeGsMgVWv3oR6c7LlPhmYvzXX632MozH1KErJJBSApH4SysBP3bwWknCUWO4CZEahcuS6CYiYZSWkYzKUwhwZS1A3cYyPrUG9yAc4FhUU6YmLtW2/Jz3K7gJpxQPJMrYcLhu8Vj6qsYrjAB4cbX0BFUwbqKC/J6X/ZTb85HXyliGhp6Lu5GzHEdyr/SmcjX6rEH84ftcUSrW5TFVy1fVVdKUBirlNwO0Lf6sXN8x9X7QTW4K7ZtZO+v3sBlnUDN87dbP2q9UDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9a/wUM48fe4HLFU2L0mbUNov3VWPI4AH+wwtfZhvJY=;
 b=uos4l+ZCafnPu3KT2g5eKcgMUcuGiEK7aAg590UK8NA7RHm87DOhHI+sKYOmG9GmrOnMjYBvvdjAv/pOBVv7P1yF9sjMoBrSFLtYG2/PSAwsgFXULyTUOYO+VvFl+8OGvp6TxqIElvq+M3Q5K82dEujPR1FH6atOv3k7E9UNr24=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4953.namprd10.prod.outlook.com (2603:10b6:610:de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Fri, 1 Mar
 2024 14:05:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 14:05:29 +0000
Date: Fri, 1 Mar 2024 09:05:25 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/3] nfsd: fix dadlock in move_to_close_lru()
Message-ID: <ZeHgpS1fZveRg2bF@manet.1015granger.net>
References: <20240301000950.2306-1-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301000950.2306-1-neilb@suse.de>
X-ClientProxiedBy: CH5P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d4110f-beea-4bac-c169-08dc39f8a67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2x3y8S5yp8vnq9wQPiazcXCF3ovddPQsNVkH/PxGspFTp1BMIXTGHFDuIRzmT2iELhpeaLqTX7QygfMLBbn9AIJy7JDQqJi2dt1iGmAEV3Ov1Gn6cI/6zeWcC/bjQ3F75qq8DvOBkF6phJTMwefmIwPiG4flzBXL1k0rGo0Fe7M9eU5S5oPUy9i64mFs3J/I2FGiAlkKfwYT9PbCsefKGnJWbXenBjPs3PefaoZghLqMvdmYnx/jHnHtD/uCs/gu3uQHzyKY4Bz05CVR3PWdF7F0SUzp/SPME1MGvlMV/lWbiTU2lv3ViWl5qQLDYAzoHY8I/Dpkyy19XmoABvNRVyP4Hi4C8Ueafs6jlTQuvAk03RVb+xfZWdv55XI2KPMF1e43HH1+0oa3VGHselglV+365qRALjCqPDEYrHTjkY2DI9R6hz4rVB9gVlsvxQrlcMYW+85J4ufivubvvjupvqMdZ08ahKRdyx5yVaGbRbI5mWlur/o2Un5deSK3XSQcdi3hBNLNtxUagCmDaXHP1SHOJ3veXJuUmvN52ExCedQH2movGejGuwy0Y3ZA5X3iDOqYGEaHyEVCfyi3RaxEZtRdTRLuXfAfaeCvuynfg+xUAiLP80lmhzg/ZrGhB1mQeSsCGdMqrgz7KfpCuUDlTQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JDXr2hLgpOx8LDpghh6lvtUi84drMoYnezIvf86k3M2lGQLre8UJ699obM/B?=
 =?us-ascii?Q?m4TT3uVn2giF0u2z4TSvlx1+nLNCehc7YGLb1NFrY22Wd6nF/CxvN9aFhKox?=
 =?us-ascii?Q?aiUtRGLu9G32PcWlXxTfwiXe4RwsEIOhiBdn0Gf6d8XyU70ssnstxOAyunsc?=
 =?us-ascii?Q?2In6PXRm8QgvA3isTV35O86Z+NKtmRdEyLME5o1C3ZVm0d2d5VblKvk2L8JA?=
 =?us-ascii?Q?RmRelqWcIMBYlfYizBmD37i7tMsw+fHPeguNI5OzbTcLQkVHGy3ckG4slxNH?=
 =?us-ascii?Q?UA49XxloWw5oxZRtDzBIjH1uLHA+zKqLwFbYz0lagz9X4W5FQYMyXnfLsFF+?=
 =?us-ascii?Q?ee8np99QfnrXt6fTbsFzF6IE84+1AZj9mMpPjb0g5G5cNVyeAdtQFnhTi3kz?=
 =?us-ascii?Q?M5vfLzQZ3kOy+sqkcD33QTbftNU0SYdU/4tmcbmgZpv8lTcBtTGAbdFxFwxe?=
 =?us-ascii?Q?PGyTc59W4HQq+B7yqUYp6pn1YEVnbSfLwjLSV7VJuLm6Y8peBGHBljvjNpg5?=
 =?us-ascii?Q?vH8Dm/XP0dBKsxZa4KX3k01E8V5FUJT1f4adX6cpyVTsQs8NPi0NqYsb+lGA?=
 =?us-ascii?Q?A6+SFXcyebmr6gMQRawSvrQrIiuxSspVFf09Ek6yXoC2eFGpvrSdzh0yUMte?=
 =?us-ascii?Q?qOjBIE2XREy59I13iuMM353wJA0kTNGggYJM0GfgR8XziETjEopI8hZA5Snh?=
 =?us-ascii?Q?YzLLBkB+zSViQTnwoXGzYCFZpdzvcotFdtuoT76fmcFGFhxgFm7X+EluZpY6?=
 =?us-ascii?Q?uzCScpicRrZVHEI8ID2eT07EQPIKniQkRfZbBSmaOj5rdYlUYcMUgq6WnZ+j?=
 =?us-ascii?Q?SkRrE9sEgv8hfEQMfgJ28vqP5McIpjr0eQxgjX0pCnFwjIk1mwWlYFne0NJW?=
 =?us-ascii?Q?dwKIjl2owSaVXw+T6+s1DimBwrXHj8rIpBfn8xrkhMhw2IMiZ2I6p6LLO/J5?=
 =?us-ascii?Q?wUYyYW+9aAvfpO044BkbNHxVB+i/Gr2uh+GhfqgXpJrbK3/CpIQ8WJaNmVxR?=
 =?us-ascii?Q?Vn9176tNUa9yeXJfqHpunVEkDQuSFl/xpO7CuSGefDQO0zE78+ew3e0LciOD?=
 =?us-ascii?Q?hR7aEeIzGTRba6zrj73v9XoN0hj+1ThAaVYGGUzlnQhJ8h01CExYNvKkW8F+?=
 =?us-ascii?Q?OecqWK8zZYS++LT5TNhIB0h9LWF5BOZOkAlPEf1oKfYadR7+H42EJS0UY5Mh?=
 =?us-ascii?Q?xCWMDP7xLldekgE8ju7fIqZkZthRhNmz+nRKTXhTNO3sOXZT8nbfDoLHOnUB?=
 =?us-ascii?Q?35BUOy1GWe0xFjvvOyxAPnBVCkCOu3xe4yVx0B/83BW77CN3N7rfTtizQ/Q1?=
 =?us-ascii?Q?YtY4YqQJ36zQscweG7W/lrrc4WIqipn+0kKe0JgP5jJOXfut5xxNuacKMQ9C?=
 =?us-ascii?Q?beXf+ZKMFCHlsLFvdauO6j9eGCi/ecqPKZJRSwaxLOQ6snaX8HumfjHZ9orc?=
 =?us-ascii?Q?J2bFZFNmiLZI1Q3DPFxeuFFgPx1+Zcajx1MeyBARc7qZA5opJsFKYLP6Wi76?=
 =?us-ascii?Q?HehXsMLzubNYGQNIXVqp9TMJmhhLxoTx7a/BzqkqAbVKI7xc5nSoCzybw1sN?=
 =?us-ascii?Q?rqC8TlUy3wsidMPFVv+s6YMiwsXyXxdMu77wbPWKjN5HkeqfViLtuAl6aAAq?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	21FR5nF8VZjXsniezZCCn6xRDnKw6VEGObcYsQgA3XBKAdvdIsNsFkHZgmVPZBuN+fNPoyU06sdRaa6u72CsTQCU1AjCQwQzHqg7Ju6efQD/xMW4cGdIUNdB1v8uMVUbTzyHWw5ss1Hj+RvJIS7UlPhIyg+osTE9IkMPYVzNfCsYd798abRlRvo03kJvnST5+xBkRUGoFhdLRT901vLV7ilp5pU34bXIUd2cHPRRhlPTCPu0gjQrhK9VRFOY1ozslvnRcqxMOX2b/hlHfovoJFL4rjzzQpJDZXYA+KSSohCHc74e7O581V8uRtHYBOxSrCNy4cRJb5YN8FDVgn2/xxhAwvBYYT8ds30o6y/Af8IowrMSFb7VVoCg4HtIfZQAH3gLazYvIqYmlWo25wOhst4dO4VdxLp9KSlJjkUAENYYPAO0hjVMp6KaQHwGA1mWYHqBFZsoKPz/xVESR1ajY9XOW7EGsZrsR90yK+J1Xha9Da2+Flq3UkoMwe5pKsUNxKMucSolLuubQCgpOA+67BwsmUVsIkcKoo9PUWRxwxvKT993Oh8PaBog0K5lfhwn8Qr4q3dwNHlrtYKu13hC+QojL5nCRAGQg0AlKZJ4B+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d4110f-beea-4bac-c169-08dc39f8a67b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 14:05:28.9542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOdbfuPgmjD1y0+aUUalK5UU1aTvYTEPls7VsPcJNxy4tBZt+qtdPyCD7L8s9ddB8PBKoiXrC6yzLoVijo5FUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_14,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=792
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010117
X-Proofpoint-ORIG-GUID: rYtf6GAFfzfl-RE_VnRVWl3elc9ya-Qt
X-Proofpoint-GUID: rYtf6GAFfzfl-RE_VnRVWl3elc9ya-Qt

On Fri, Mar 01, 2024 at 11:07:36AM +1100, NeilBrown wrote:
> This series is intended to replace 
>  98be4be88369 nfsd: drop st_mutex and rp_mutex before calling move_to_close_lru()
> in nfsd-next.

Hi Neil, I will drop that patch from nfsd-next now.


> As Jeff Layton oberved recently there is a problem with that patch.
> This series takes a different approach to the rp_mutex proble, replacing it with an
> atomic_t which has three states.  Details in the patch.
> 
> Thnaks,
> NeilBrown
> 
> 
>  [PATCH 1/3] nfsd: move nfsd4_cstate_assign_replay() earlier in open
>  [PATCH 2/3] nfsd: replace rp_mutex to avoid deadlock in
>  [PATCH 3/3] nfsd: drop st_mutex_mutex before calling

-- 
Chuck Lever

