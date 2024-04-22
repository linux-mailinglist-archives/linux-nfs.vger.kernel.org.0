Return-Path: <linux-nfs+bounces-2916-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D07B8ACE58
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 15:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142B2281272
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355BA746E;
	Mon, 22 Apr 2024 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YFbqRWR9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="siVi4cxa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8ED502B4
	for <linux-nfs@vger.kernel.org>; Mon, 22 Apr 2024 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792906; cv=fail; b=ZvFT/Pumxy9pKNjjJsg3MicHCqZf9n4LN1Oc0hNV4owi+BsuwJFa8keFDc6bZFb7bu/GXn4BYW0zUjJftodE2piY+B3EVwFKsglU3pV5RpiKZT+QQq0nCGdIdGBqCT0KJq5ntTgx2b/cPccrMRKB0MzJWStPUZgU7N9Uw3N84Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792906; c=relaxed/simple;
	bh=zuN0+5PHwWRYrXUASn79EBKg/G0Dj0kja1hjwBmxcm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j69n/U9k4Z95zwaS5WLYH34rOTvNv34Cp8bfLImjpti85qUCNBL6ipWVF4Fy9ACiQiusJvj5XUZalT5W60F31LyDrWe72x3iYqboaC4eo9EJ1OwANJdsJxZulGLKZCbpV9ygB1+YWLpnUtliMSD0UJxSmf8Zrkb2WVuVeud6ZDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YFbqRWR9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=siVi4cxa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDXvlI027794;
	Mon, 22 Apr 2024 13:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=xr51ktK5Nt/IL2FFUBD+2AfqwQkBar5Eb8dtlhyuZv8=;
 b=YFbqRWR98549FHJCAKY5IaohkPa9BJbq9Da4J9zANDPgAXbaI1XFH6WEyFK7QQVNHsRH
 pecaUxvS0p3wl0F/61ftpBwnGUgSO2e0jnBElDC1aoakBxCEiTwmQXGcwgpX1H0si3IB
 HnO4lt/HIAuy+uRuHnhMzik2IMyEKiKYpQ434bvOxUFGV1gn5TLW870PAIa7UKirY3oH
 UhK79f3IqWtUqwwdUC7EyKkVqduS7UcjM+sb7KwdibMd0d5E2/i70snrKhgN8TRaoa7j
 lEHoZaeXsCUIpAcQpLPxAfLtXdTZhwIbn5d6+WQWDT6y3WeCwStRcP7tSLcL2air4pjD Rg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5aujm4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 13:34:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MCkXec034434;
	Mon, 22 Apr 2024 13:34:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm455m7ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 13:34:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQwHWBz8Q/4lKNf8CmunrkwYwJ3xIGdfEpF9xm8caqFRXDxwdiUAlEJgzaPZqq3XSUk0wBd44uW7AUsXKrBAJRwbGeQFplEZCcqw9hwR3rj8Rl6oKqGrYCTcVWUP5lz3h28ZRE9INALHmd9iH6ljh5+Q+/VbDxG8wKxzqPWwgntf4wQmAWN85U03NJlllg9WePBWrjLUxMvH11T27DbICeawWlgr9N/zS/x0JFI5eHTW5q8bZDmW9S7czbpWchVDloSzDL7xIKQP98Fxf2FBMI8Hpfdt0YBHh0w0UcUa/4HDs3gnzKXe9mmS5WbWluu4VOfxKG6efkuU+hzF0gs0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr51ktK5Nt/IL2FFUBD+2AfqwQkBar5Eb8dtlhyuZv8=;
 b=JXhvJS1u74RSIDDfulb917eL+9S3XMM0BuCW7NGpJBz49AjDl0v7Ov1Z/uF0aOMZh1UbyU5ZBPLMhQXobYVNt/T/PriWCiXVNUbdCV47BbpZVYqgFZsFp8ZgI7cnoK18L6Oms1mWkgnf2pFkWkM1r7ucAoqyDii0rZ4b5aRbLgL2mKb52o4z+msy5wF8wMFXCqzU5A9Pf7YdV+B9U8NqC6BQaLs5Lh01lcDPLGapfPKUZrCSTZ6E5drHbBXm0fGpJLp79xS/2mbZIqopwBqpN9GklruWSUz+nUZsX0jBWz8qj7yuO1F67k1nu7I7Xl8JIlaH3B29M95/db/d1X6eBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr51ktK5Nt/IL2FFUBD+2AfqwQkBar5Eb8dtlhyuZv8=;
 b=siVi4cxaAA64Dagg4rtbA2YTJFRVH+ivBZkWed50YzvAeuE8OYhvD8TSycLjpnBjDFfY5OYgUVwak9A96k4UlMUSCaL0jF2WiU67kviYulvuOBeSnaR2TBG7eUHTiXcZdqLNifiBzekI1r5kQ4Y7u9k3T0fBTXLUIyRkN+iJns0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4223.namprd10.prod.outlook.com (2603:10b6:208:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:34:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 13:34:40 +0000
Date: Mon, 22 Apr 2024 09:34:37 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: don't fail OP_SETCLIENTID when there are lots of
 clients.
Message-ID: <ZiZnbV+htcvGuGQl@tissot.1015granger.net>
References: <171375175915.7600.6526208866216039031@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171375175915.7600.6526208866216039031@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0444.namprd03.prod.outlook.com
 (2603:10b6:610:10e::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e849de-d364-4680-dc36-08dc62d0f66d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+Wr//qKeahJjn3RnXnS8dLCuHGEQW/XNkbfCqdSbpq44pEIhyEbcJPFOf+vO?=
 =?us-ascii?Q?n0rv8ngZ42w95IGk41Qcednx3NROcW/Dlqp4irJImTq9bHsXbwloL4Rh5lxq?=
 =?us-ascii?Q?hr3e3H57rHLOkFVI5XiLi1IUmpxq3WuVd0TMJUnVJahB5lTdMG6269ieYaJR?=
 =?us-ascii?Q?Dz8V/diHYfGcMc4DEC6IzYjClLwEw91DswhXUSZLq/TQgnGB4U+in1wjRU9Y?=
 =?us-ascii?Q?BDuqFWf2CKw38PsDaQMI3JYCml1FZbIFOjh0YqsAO9WqFnwKDtDWKHIy94E2?=
 =?us-ascii?Q?JPTsiCeLRYL8Y7JNZTpf5dia65/HgGv8d+gQif5o4J01uL+yY53X0F1XSXCr?=
 =?us-ascii?Q?YDLoC5f13sjJFiYZc0QQaFqxt3YyXg25Qk/fS87ab4VbIktavn36H6ByyPTX?=
 =?us-ascii?Q?sG3/JmwUIsQ5qKYYoeyG2I3FUhwRlBDl4jAhOuGD49on4NCf35demvd7ixi+?=
 =?us-ascii?Q?lDQPKwiDIRMEN5y3BpC6XSYnfQkrfvuIKYC8xEng3vZPFTZkCvTuTknq9Ter?=
 =?us-ascii?Q?GlalhZC5rQUGtjsF+NwjsH/oamKbor/W/+wY/kR2qNiRge4+vaXaxBSZrXC7?=
 =?us-ascii?Q?hzSHPGQ5kL3WNgjKraLoI5fpICPrXqvqmZCABO0P3Pr1300eUB/z+5mvYzKT?=
 =?us-ascii?Q?qPqDDMjkRwV7U9UZo+C/YjLYmIqeoHJes7XMSHV3jK0DKAjC+Wr//wEQ79SO?=
 =?us-ascii?Q?yaBOW/9CHzTbes3jYFtFgGH5WefGC7ds4Wr3ipFmivpUVXYPDnzFZge0CgBv?=
 =?us-ascii?Q?eUhwzgMibd5dcbNmhXQ0lznNbFaDcurecYhle5u2SBcFqjYWnGEe8iob+wNZ?=
 =?us-ascii?Q?iR93jK5xfNrjfslpdJvcv4lGm5jq6R6oZZti5YYUNmdrg2QiauXaD4uwo+gg?=
 =?us-ascii?Q?i/4P+2crx3lpPOl4ooP/zjYEpkgjOgd2YRu6NQ71iLkVRIkwsMy0i9w8Rmn3?=
 =?us-ascii?Q?Sn22Q7K4vS1diH7VUomM06hOt4KuT9E4UGNrDjx83oBn7G2dR5bzHo/tbJuY?=
 =?us-ascii?Q?ZxgqI1VfuqKj0+qQMsrx3o+VDohM0h2mTIr8SvsSLY/wGUE5EStllt3BvWle?=
 =?us-ascii?Q?m3pOrCdF2PuQDlFAVU5/58U5yhiR2N1QzQIK/kx32wW1m0Fx7IGhAPe8LRZI?=
 =?us-ascii?Q?q4GZ3tTLzn3ztNfuvADEw+hHtPA1g4heT48RZLLNM57L+FQDfv3QrWtGor2z?=
 =?us-ascii?Q?Q7zlnltfglK5ar9lPBsdSCHIwUpWKcXQ9WmwZ/bRgaha5xSX2WBMaeoOJC7H?=
 =?us-ascii?Q?BnGsPqx4MoWuzOg5scKU1yEX7kWyX51Uc1RfpHPVYg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?etd7/yuW8TemS+C3IfEi9aM+uREZLI1xfdDkEp9DEoU9ERmnrNnglO7kqJNL?=
 =?us-ascii?Q?CtnP3AQeD9jtL7Lu/8TINeNIJENb7f1Ari72cZTBCpkJKkFyE1HrQ4tV4Tuf?=
 =?us-ascii?Q?dWab6n+nM6t/jm+PkP9wW5EJdyPNer49Lyd78DdVx7CWy9RWCmh2rZYjqgaE?=
 =?us-ascii?Q?ozGDmqtPT9hsmdNO+nyfApd5WIsuiVLlCT+MRJB8PK7F6SywpWSSn7qDTuI9?=
 =?us-ascii?Q?guu8OoATn4uoTdwVEP2U7s3hYDJ3gGFvCpwkKi1KR9st+8lnsqN3eVJ87Hge?=
 =?us-ascii?Q?ctiIAFRhqQmqXdI23WNqxVXIvYLD5MKbh8kB7nEvzTNB8RPBuyzRfO5mvFdU?=
 =?us-ascii?Q?TOWjb10p1b1ghkzv7c5eIEqGMlIon1jGqxjMGsl+e3vakqiizsEfNT3s0iNA?=
 =?us-ascii?Q?YdAWo/+elIMLUFbfPBegJ8T7VqUsLJMSpM6umAfi6iUmMJnIfopZflYv7lmI?=
 =?us-ascii?Q?Bg2hL1dntnKTiIh91QjeoOA6ommMF2ywQeG7b2oqJLWOH1QK16H3wqicxf+t?=
 =?us-ascii?Q?XgLy2NwkReC0q1CPfInKyqP8beHVjhuAOubOJyaq27I26u+oVDf5YEbM3yJ9?=
 =?us-ascii?Q?9aqXoer/5TgO1cvFGIznNPTwRCjW0dkKu+Gpjl3pqT90cFwemPChMhvyXip3?=
 =?us-ascii?Q?+rwIO1XvGt6b1h7HdAnzvzItnHjMJYauirIrQ4hxZEIN7F/7CRJy1C59BG14?=
 =?us-ascii?Q?r7Mnrd1sqkJNzflilauLHNNL+es585gLKOAsZP4Bn590TCS4e7rlMQ03Zykx?=
 =?us-ascii?Q?Vl68zvH+gR5v7Tcls5zJRWbX/gEi1Q0vXuzLy7gq878BIITV6EUge1p6euEM?=
 =?us-ascii?Q?ZDRVGbvmYuGNRx9Znikdmxqd1ntNYLA6pToWrBLwvxEzeoC5lyXDy8kbR8CK?=
 =?us-ascii?Q?iWUX/WG43Z4XBjLmJLFwKrLsanupAsmZVLmdABSkq5SoFpLrgamZfA/M0TzE?=
 =?us-ascii?Q?2OnhFPl0MhOoycvWh0ZZ7yMbb+2w79/HfOEji8efy0phULgunQvCRl3br72I?=
 =?us-ascii?Q?Tt1zA28xALiYz5G7y1pwRXV5JnLknNXtT+MmKfG79+E1IHhItdGnD4gSgzkr?=
 =?us-ascii?Q?1sTpnHT3pCcMTJPOi9GbahM+5Z9QQOV3wuOWaulANNcxtGrqjp81Vh/SyNEl?=
 =?us-ascii?Q?JgKS6G8WZzuZOipD6xFTuzH2Uh7J9f/FCeJFdIxoTBsFFUtJaKz2B9EZck87?=
 =?us-ascii?Q?c64KEi3xlSULqtL4borYUYzoS4D12T82nL6PYIn9V/7igy8AOWaj/v0D83Tz?=
 =?us-ascii?Q?6envaZbpr/LxQ5SpGIc8PFngqcxCxd5SGlZA1AlXV2N7cSDvGCVV+t4CWJuN?=
 =?us-ascii?Q?NxNqM55bd9o8in0jn4uWYFawfxnI37LpCn2KltUOuI9TdeWcQ/WVCtAT1MG5?=
 =?us-ascii?Q?1G8HCQmvQFwl5wSysMhAIEHp74buxsJ3GCqx6FyWc6jKseppZda0+lptiuTS?=
 =?us-ascii?Q?S9ooNxAJTLjjyx/moLAhTr2H0LvQvrKL/OpSAbThkCOliYQ9p6ajqHXxa+N3?=
 =?us-ascii?Q?Xl8e46aA64xyFCdC+0yyxkGOYAqwxrZPPf6MuKG1vw4jt/mtu8LYvLDzzlzb?=
 =?us-ascii?Q?jIKGQ3pSria7YSEl3+p64PLaNVbfWy9y1s7EZfdooajglnoc3tjeZ7I4uHm6?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UctqDFOOxWEyT5QLs7Nt7lSqdqmJiZNuh3hmcXxoMDSLumRkzd92X7vmmqM8/tBHfckbFzYvssD+wkr37PsbEdO31Ff58tylvCzg2/62/9QD4CRcmF4u4oFztD40VOcRJtZyWcI1N/hLOryfkoLF1OvSINsmrYg2igg2F0pOchGQexfg/s8GWzwt57DLezTXb5CA7MQ8HQ3Y2PCLRgpvvyODiimo7LGaLqOW6y3LrS7s3HvglbL1SXsVkuutC0rBN/dm032O9hRVMXjcjmdTJ+7t0cqKOjx6zcv448RSYrYi8sYI765l1UifLzUdjUBsbFx9O+OEOWetg8qWrwJVng0S+vhfYm6zW3mmPzbzoWQq3YlDpHy9AzFIpMftk7LYp96czfGTVrq+bZm/KWd47TPVDvmQGuE4OptMe+M19LQEqPiGcDAn5ccZOcAvl+smF9RN4lhMVw2HQkzMEKDKlRt4Esvx8thpGfYmoXir3Wd4BykRRJXMf0ct68m9Avm/+AwFzfv+TiS+gwhqE4jov5VzrnquPWbdwYllKj7XCnxKB24sqlYFcp57j41Y0F5ZEeg7zaMEgHUg4CWu2aREn2bPg3BTDCSD7FoeaQIpWyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e849de-d364-4680-dc36-08dc62d0f66d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:34:40.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44TtBuVfIT8uzSY/ND7cEzBIgkvzUyKm8DTv5kIVXIbKbzGIrI3bP8Fq9Tr46wgEDkpPtDCbAzj8Bx4WFsaufw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=954 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220059
X-Proofpoint-ORIG-GUID: 7j6gR9KAuxO-ZBhgJvQVeFfedl9bZB3L
X-Proofpoint-GUID: 7j6gR9KAuxO-ZBhgJvQVeFfedl9bZB3L

On Mon, Apr 22, 2024 at 12:09:19PM +1000, NeilBrown wrote:
> The calculation of how many clients the nfs server can manage is only an
> heuristic.  Triggering the laundromat to clean up old clients when we
> have more than the heuristic limit is valid, but refusing to create new
> clients is not.  Client creation should only fail if there really isn't
> enough memory available.
> 
> This is not known to have caused a problem is production use, but
> testing of lots of clients reports an error and it is not clear that
> this error is justified.

It is justified, see 4271c2c08875 ("NFSD: limit the number of v4
clients to 1024 per 1GB of system memory"). In cases like these,
the recourse is to add more memory to the test system.

However, that commit claims that the client is told to retry; I
don't expect client creation to fail outright. Can you describe the
failure mode you see?

Meanwhile, we need to have broader and more regular testing of NFSD
on memory-starved systems. That's a long-term project.


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index daf83823ba48..8a40bb6a4a67 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2223,10 +2223,9 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
>  	struct nfs4_client *clp;
>  	int i;
>  
> -	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) {
> +	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients)
>  		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> -		return NULL;
> -	}
> +
>  	clp = kmem_cache_zalloc(client_slab, GFP_KERNEL);
>  	if (clp == NULL)
>  		return NULL;
> -- 
> 2.44.0
> 
> 

-- 
Chuck Lever

