Return-Path: <linux-nfs+bounces-2725-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6310089D03E
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 04:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBBC282591
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 02:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797954F883;
	Tue,  9 Apr 2024 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NV/MIi4S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K7xJNuBA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E974F881
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628556; cv=fail; b=WShwyleEX6gz7UL23NdHIM0TIMso0fVizDzsZmYSgG8CJ47kNXWDKbrIRw/Cc17wb6et7nSX7NA0mCIGmprBj9lp1h2bmy0ETJknLypFjkZuHjAyBi4XOomqnfluW5UXvvVBcPiyFXfoolwU00bYlvDkPqkYPY9sMmxjxiGSlWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628556; c=relaxed/simple;
	bh=wvPm/NpG6jRaVRa1BM1oHXIHwVZrkHaYrFJhLPjRxXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YWR4o0qa7JEDDIFeOp11pcgyHnhStk317Vz2SNmMWSy6+ax5rVDaer49KIwlcltybRh7gxRLHNVm1b8hCXD9AboJNBG1gKZmxcxlWFmpvwgqgQMBLr6tACs81NtnicWyXq8jsvnYEGDQafBOmE/aQViYuzHCsrD6aRn37hi3bsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NV/MIi4S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K7xJNuBA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438LnN7w007121;
	Tue, 9 Apr 2024 02:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Jp9I7KxtPU06pzIFKIg51NOuzVi1YNQDx/Oz/ijdocc=;
 b=NV/MIi4SCUTMXC+jCbqmRPSgatqlR1zeH84IMv13SaDxuAAfA7kskVfO8R4KGyBGbzoz
 ymeICCPKTh1j5OilYzhM7v2arQC6NUeF1NFccEX1fI9YqEIRFHFCvXpOis8AiKGoR7BH
 khGjBPwcvwB4xJCDqHI3oBgantuk/TyN3xl6tQOXlaCkHvVCQePs7KBNgg0I2ZffhkZM
 YVqH6NxfKZHrZ/WkWt7kuL990rJYl1GtXtrqusJYJfxUx+nJTbRxS3liwEgI0bJ6d/6v
 Tf0LYnnNVejoULU/QLjY76KHJNagyKhe3w5I+5IkNnNp6Ad6Ob9QZvQRAvOm9GmAXBLM Ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxxvc279-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 02:09:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 438N4rO5019974;
	Tue, 9 Apr 2024 02:09:05 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuc91jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 02:09:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLvzW59MFxAfU/n6qE+uOwoyWtMq1tjTSt75+sc8nuWjxVgF+XJLqGx9uwA0sM83oV0bBCluYzrvNq6aAj/sbhKcOcvRRxZP5Idq9G7/nkEoZWxCxzDQmAT5AnVWasax1eTwbhXjY6LGKOEayl98+bk43/xpQUS3ZfQOlREHrnITZGcHn+45cm7uMciZv+Jl9PEpMiFJ1bHRw39lJEHh7cQCoFiLtiu296x4i4kUIwSAFBsF6UpbhZtO88TPrnbrdv7VPco3faXNbEZ9UXA7aRHQ6GDOv43E07vFpSiX/sMWkk6wMzS6//dRds6LSrPWuKdFhqSy00JP9EzowIRM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp9I7KxtPU06pzIFKIg51NOuzVi1YNQDx/Oz/ijdocc=;
 b=RSW9HNWUoI6emjqBq5SxpKEMQ1GETeqtiOKLsyFGt2UW9WP82AimRox8tUiF8GZj7dHN9mDtOndiZHE0i5bj2WsoC9kaI5SjZNiGL2zq1Vhb4Cl4syokL4T8MPqrnnqAPwDZLJqSM/P+64gs/g9YhBCCSpx1bPKqnu1Ih1nV59S3MvtnpYv39LmofoRz9A5U51+VLpfwFu08f2V/ZHqe6NaFeh9krhJX4pce/CphoVx/T9D2L/HNIHogpXX6jFPvnGXQ1Kx8QfMLe+LZpCw/LaweM4BkJwXTtq4yDUmXqBIY6zv90MlnBT8IXREM69VomUX2NKTPVxIW8tb9tbv1lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp9I7KxtPU06pzIFKIg51NOuzVi1YNQDx/Oz/ijdocc=;
 b=K7xJNuBAjci4p+iBJ6m2oR7BM35S49iznPUfRtYKLBKITYSyLeodr9EqNuE+0rgGGfEPXwD2FSymMAGFMqUlzun0LMkddjs2VUldP6ThsEDjaqZ9jlUrk23sZbAm0g9U9wPdaOVPezuNca4Ck0toXbVIoqtsCVXaPjzQOSQeK2E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB7439.namprd10.prod.outlook.com (2603:10b6:610:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 02:09:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 02:09:03 +0000
Date: Mon, 8 Apr 2024 22:09:01 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: optimise recalculate_deny_mode() for a common case
Message-ID: <ZhSjPcVMJ4BBm/M6@tissot.1015granger.net>
References: <171253979210.17212.5851835299179227478@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171253979210.17212.5851835299179227478@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:610:52::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB7439:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6ckk/4cujrVVTqlXatYMI4A0gg3vNlOttFEJEqs0ib3/uiiJDKYx2un3qTWdyIJXiWwRYPCrmqUz4ZPLodJLkK1/kdj72vy0Fjz/IYv6H4ehtBHNfmzSe0rCsR9rdT90z/cRrPpuusKOk+fGEDLv0ViNIgNjtKKr5IutZOSi+U9YaTpcG91e//VDuFI9H9eU2klOdtvfKlSu7MMMutcRl7DZfgdoa3Xe1em/6A0CxEmQ6/WgP7o6MHaSDOfqt2TGHAxohZnKHqK73lrfVTxzdLe2ImmCtKip/yUFk7NejegTnQjiLruhCxDfh10mIOWa0iVqBwDFp3wYck9ct/+zGk1qaljaSbCSgkEbkxS/ttQiTKGc0dNui38OPO2U+1C0PCWnCDK1n7FtzLT0oUct39yOyYFutXSx5Yozr24lKvY8169TgVVtAx/SSWSmRN8FjJItiKgoBTG9R9b34ruZ1RSqjOXpU5+kbDDOBzBdDNsEdHcnkc/gmNpFc6IPUsGbx6E2uRnMzPBN+gsb7lgvNcwAS3DikG0yVy0Rs9RvFb2eUYZTNfXVX2XVM0mni2NP+qpIr3MCqjun3zwsEYjcPKTcLDpvDFgBa0vncfOPEPS2OqdnQ1QFf1Mm5Jb6UXaER9EbUgUsgCu/01ZGMr1vnm6b8vAskNT4lHkxCt+CX8A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vBu+JtJhXtcx6a5Q1Eunt6r3opaxYgrd1fKUhnDUzmF0bR9h1yf5HpSPASSq?=
 =?us-ascii?Q?oAbVsJyf/rSqZa7+Czcjn06FjLpSID7V4atdi7fLVQArXavPuDjMd6p5GUjk?=
 =?us-ascii?Q?t68z6Zo56hTc7p0YZQaznopR3OA9t+9P0PWydyS1rnyqDjcz50/iNnx0HC1j?=
 =?us-ascii?Q?tReveivBADARoJeOtG5T7kzgtWDLaGqZhwrtOO8bvPrNuF4R4W1Tgvv5qLPR?=
 =?us-ascii?Q?Wgm6rySQVU0Ab3RAuUF1fdkKUIsP9VmTYjI5td0U6TeB7rRtnkBne3GBmH6Q?=
 =?us-ascii?Q?TIeX7WkIGLm0txKUVzkPxTA7Xdw2VfhMVABwVzCP1ibZSQuBikaDhcM/T0+5?=
 =?us-ascii?Q?TIrRIVurhZ7G5aBChET7c2xra0nrMP/62cZy00itunperwYX45zwRjCgwutd?=
 =?us-ascii?Q?WT34H+MDRHqbx2wiaNE8TnsMbRLOf3d1ZeTCTdlGuGXLjIn7FeENJzk5NFw/?=
 =?us-ascii?Q?K6W8wtmbAPjAC3+JxH3q//2BBJ8Ts1MEiMa7mMvlPGQNRAzzJ4/YteNKI5JM?=
 =?us-ascii?Q?qRzjjkHmG0iCQtkw4gg9JnEB3kk/5H+YsWVw6usPrnkpytI42mpb7yYmwgI5?=
 =?us-ascii?Q?ePj6/gAvanGKMP/3WBJiD/6W8LNNOAb6lxsdL0zweY7hyGdnQ6DoSISZ9DaO?=
 =?us-ascii?Q?UB2gy7ACxY3pDyQjFcV+SyQgsOgCnLW3K+2Xlzsah4DTMt88rASlHfL0wOGA?=
 =?us-ascii?Q?fbEJoT0LfDVzYYfJuCNP2Bg6uJHbcuIfcVNE0wSAGossvTepc2rL3gBSRRoC?=
 =?us-ascii?Q?vTKVjUo+USDZvJ6TmoREKXWMYQVzAu9iAZAcIKx20FNQrm0KAbkuclXmKXLd?=
 =?us-ascii?Q?xzXBKWpxygRpoIy2L7Uid+DoMe9JQLYU2Ej/iJO5TZsqiBPTwX9gjD6iCvh8?=
 =?us-ascii?Q?S47hUGesC2xCNC4B04eAPAKlJ/0BOjLFX5y7TUm7BdsX1qX6BK7JxoNnsmhj?=
 =?us-ascii?Q?pML3vb3DHjz3ggUbL/XPCpPTAd+Hk6gmP09Kdn5DIDIlCj2mZ/p0kjXzjqWt?=
 =?us-ascii?Q?VPPVuPWdy/gWL3isypwj5V1X6ufP9k+PbdDtoC0QwO3+3VWZCVfGeB4QH9Jr?=
 =?us-ascii?Q?26fxKZ9kXGzcB/uuvckSN1Ga91xC9FpdzjUlWuBkNBNScq5SQYCKo+8t8M7h?=
 =?us-ascii?Q?tRukAcyncm5YsWKYoKbiyePSbCKNrRvZX/dFDd2fbSjj2tohXu4I9NXCW2Bq?=
 =?us-ascii?Q?/2XBnyIFKrgQ8hCfMCyzHS9Fyt5h8RKqKcoKJt94m20RZKR7t5u51WSgmrs/?=
 =?us-ascii?Q?kIN/O12kk/gipVA9+9iIM5URv1DxbVUhCVvhqt1jV55vepcUJvivhrfCkpPh?=
 =?us-ascii?Q?E09E/R/T8N8VwiM5hjy320rXdgHfTbcILt6opflc72DbWOxvSdIJCDtUXFPz?=
 =?us-ascii?Q?rEEqEItePkNM0A/RNEEmJvtup/4t5t7nM69nMmzmGyDauW2idNZ45mObKarH?=
 =?us-ascii?Q?62daB0G4OR9Hp8jD+nc8j/8+PIJz/htsSgPcZ/SEQxoJze14V76e7lJPAZIr?=
 =?us-ascii?Q?wrxcpjQFeRQlotJGyprOan69VkjhtAP9FmpSTvPZmhBwZB2c6UyOvZ1hz09s?=
 =?us-ascii?Q?M+CGlv6lEl1yI6nfuVEamyWR++IAXf99G+Sn5k1h5VcdWfEtCDu8W6nuBBai?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6pGLVIChOA+dUl3A8Tdgg+izjSM5UnFdxG6v3YgtvzcNpHD46DbOXDBxlF5NfkMUlJopSH4kGpq7RvfabPAT/skXScA4a7JBiEJVFBoMPY4OdSqT85uwed30lafObtATpVsVU/Ij6bPAAmpcm0X3qb3o9Pq3eiD8cWql0ca36FAWZ1P0irOYmLdQm0JDabU0MeU1uIa37ZbqVMlYmr4/PTsdxDM64STh2yhK4WdSN0GjFfjfIrTE2DIV2LkNUW2QQqEzsOQddIELfNBPVf37p21Xk24fj2kkOCCImCCWw11ARZsAcD+X/os+hHPARUPMH7dBHiNABqkHWlXKlq2wskj96PBcf1ifLXxZn7MbBsHwHdIfhYVlqKfB4rHXulkWAaIqcRGdToSz/G8dKQwQVUbRDLw+XrNDnPIGhn2teE3wFORwqvNHPI5YvExUYGxeR5aCnOpGcTxEF/kNDTjqkaiIO8UG8RuywDZu528Y0gEkkTRul1mTUfh0OuTM6PgbIc03R+Csip0sd38utDJZuC5qIX3JmhTmRI/Iwc0o53BGLQzQK0UKT00kkhD3Y9l4/l+j7sgzYaReFeOlkoGGCcGb1wU++Jb/juVoMtVw+mI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2088a593-3e2a-4c9b-4c90-08dc583a074e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 02:09:03.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YwkGcLdAzplesxluYuuY1NG7DTsSWUDFhDyO+xV7lkRoovw3w870FjG7dqvPO69OBTmvxXXF+S5PUWaX6BzPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404090011
X-Proofpoint-ORIG-GUID: x8KXdpOPMS0wRMYpO-SBknV5AbBzv8tM
X-Proofpoint-GUID: x8KXdpOPMS0wRMYpO-SBknV5AbBzv8tM

On Sun, Apr 07, 2024 at 09:29:52PM -0400, NeilBrown wrote:
> 
> recalculate_deny_mode() takes time that is linear in the number of
> stateids active on the file.
> 
> When called from
>   release_openowner -> free_ol_stateid_reaplist ->nfs4_free_ol_stateid
>   -> release_all_access
> 
> the number of times it is called is linear in the number of stateids.
> The net result is that time taken by release_openowner is quadratic in
> the number of stateids.
> 
> When the nfsd server is shut down while there are many active stateids
> this can result in a soft lockup. ("CPU stuck for 302s" seen in one case).
> 
> In many cases all the states have the same deny modes and there is no
> need to examine the entire list in recalculate_deny_mode().  In
> particular, recalculate_deny_mode() will only reduce the deny mode,
> never increase it.  So if some prefix of the list causes the original
> deny mode to be required, there is no need to examine the remainder of
> the list.
> 
> So we can improve recalculate_deny_mode() to usually run in constant
> time, so release_openowner will typically be only linear in the number
> of states.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Applied to nfsd-next. Thanks!


> ---
>  fs/nfsd/nfs4state.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 1824a30e7dd4..a46f5230bc9b 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1409,11 +1409,16 @@ static void
>  recalculate_deny_mode(struct nfs4_file *fp)
>  {
>  	struct nfs4_ol_stateid *stp;
> +	u32 old_deny;
>  
>  	spin_lock(&fp->fi_lock);
> +	old_deny = fp->fi_share_deny;
>  	fp->fi_share_deny = 0;
> -	list_for_each_entry(stp, &fp->fi_stateids, st_perfile)
> +	list_for_each_entry(stp, &fp->fi_stateids, st_perfile) {
>  		fp->fi_share_deny |= bmap_to_share_mode(stp->st_deny_bmap);
> +		if (fp->fi_share_deny == old_deny)
> +			break;
> +	}
>  	spin_unlock(&fp->fi_lock);
>  }
>  
> -- 
> 2.44.0
> 

-- 
Chuck Lever

