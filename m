Return-Path: <linux-nfs+bounces-2511-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046FB890140
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 15:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280B91C29090
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77968288C;
	Thu, 28 Mar 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oPh8Bk3L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wesh8l9u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA57CF37
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634907; cv=fail; b=MwavXD/S9pURejoJLwcM11jvvJR8645EXXVqsdnt94R0p1VhKzcbh1lcGiFsAt6yFBc6VnyDcedDeV2ITaZzd1N7IKzQhuIE7jbuhaFKQKYgxYVUBycyDqn+DVi9OV+feLWxZwPOnojuTpkxe0BjyGNjfHhtkK8Z9oA120SLCxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634907; c=relaxed/simple;
	bh=VJAt6FMWMifgCUkFbwwLbZEG9GItLeu3BXtrZIn9e8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UxZDzINlDCBAvTMBBgPRLiT7pqnpoORME9i2kwY3FMl96BNAfvSs50KhYeDKX1jL0TLTsbZ+5OgEPY25k7VrPO+kjfYcxj3qBpD8EHVQ+89heLTB8O7ussYH1zYmnNVUYMcw2VQzuZnfMER41Rmri9zdgXpxdRSj7k8r6/2ojAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oPh8Bk3L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wesh8l9u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42SCfm0i012679;
	Thu, 28 Mar 2024 14:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=My3aJzOOuOJieeQgSs00D4HMjCXcEYx4Vt+HuEWesBQ=;
 b=oPh8Bk3LrdgcM5MKxx3ftZLXS63DtYUE1bTdmjEjAggb7GYUjGEUlIOgHgjKfFFmY+Rl
 0GqYia98LUoSauAXlhjYg33P7CTE6ekfwwlgCVJFG+UUmZ+eo0mi/b25yACMmRLPcXHt
 dIK62QQmFxlPvRyVtjqkzBY26DhN6POSK/PDs2dlY/2aCb2CCb/IZJAgpo4GrbXvfsZu
 HetH8aKlbsGR4qUOSVKNdEylW23g+6+aaQE0TZZwhFesNwKI8Mwc1yPC9Lgw0dvWm1xb
 lOvVJI71BpDfhWssnKnaSpFhQ1qDi2HnUkB88uWNNhKHLGy2+8gs8833CqIcLKKh0QOi ng== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1pybsna1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 14:08:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42SD8iBJ018111;
	Thu, 28 Mar 2024 14:08:21 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nha85vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 14:08:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UORl19GBaOkQI/yuEPQKRxj96bMZv7ljHuLkWtvX3EZ1RrO0bUzeD1fh6TNNv7Ytku3i7RsV8GCR78ST483Kn9Pte3Wrc7NCizI6MXKLmLkt8lquAY8IF48DFpbtDTV8yMNAePV5/65duzv399BdjU/doAUTdJg/+JGKsMR2xqGdbtcvB4BkH+0HxAKmQBgeQaxmxXBm/6fQNYi9b3fZIQX4VMHj3U8sjRi/zE+DF/c6WeweUjQXpQ6xYupSFCzCoIpkxm+QNVnrK7eIkcfPoTtZoc5Oh6DRtd0RN3xiRRq/+EJVhy8YHXX6S2fYVSy/lsrwczhN7NKWL93Vc1Ok1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=My3aJzOOuOJieeQgSs00D4HMjCXcEYx4Vt+HuEWesBQ=;
 b=UWTlR41fvqp0Gga7MwO8obxpcduhutdZldvoaFyhh/litEF+D2/pC9DNz6N7vlZJnujbbac0YDG0doiTJAJ4diNCPd0cLSDxqBF3JpE/+POFzEEdY6jJ4HEsryuDsHGrJEvQM6JZxmudTa+QXCcs989kxqIR+JGUw667jYK2UWRjOo+TYkDlXw7Uq4jbUvmJPqvPh0AgyQWHBxrtr2Aq7vujCQqrF7keYZYR4ggmFhLRTuMszfiIcwTsE1DnjJIO3c1fF/k0t5FTRfhQQss7l6dDMga+iSoBc1KHvYMcuEBUeU/jSi3B6wTKd1bsTyAFAJmlxRZi4BDalnhjQBpyaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My3aJzOOuOJieeQgSs00D4HMjCXcEYx4Vt+HuEWesBQ=;
 b=Wesh8l9uMu39KwMsr+6VGhUK5dgR/98c88PeLo2T3FPtOhJ0wwT/0cVcUDeTyns/yt0Nz+nUebW8Y6rrkfxsFie443nfojBgqn10/xAcKfCScn8PJxKgV/bZ/4z8XUQkVFXiA2Mw5Yhb57J354k1OLY1fYHi9d0fZBg4Fhr89A8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7378.namprd10.prod.outlook.com (2603:10b6:930:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 14:08:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.039; Thu, 28 Mar 2024
 14:08:18 +0000
Date: Thu, 28 Mar 2024 10:08:15 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Message-ID: <ZgV5zwR0q/vjBAtI@tissot.1015granger.net>
References: <1711476809-26248-1-git-send-email-dai.ngo@oracle.com>
 <ZgMToHNkkGEHNb/y@tissot.1015granger.net>
 <69914825-e9d5-4859-a5a8-60d17e8e8bf6@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69914825-e9d5-4859-a5a8-60d17e8e8bf6@oracle.com>
X-ClientProxiedBy: CH2PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:610:57::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 663d7af6-cd37-49f2-69cd-08dc4f3084d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7HrpaD1VIY+GaQYWcc+Tfbs5hxXuThAwuYCG9Kb5PlknHSEApmbnIpNWjXoxInahK10lst4UUCP0G7d+OteTKfQObiTl7j5Cdn5sipLe4swB0hmWcn5qyPKUiknDhMDprso0NV0prn3QZuYJiRpHEX/9vTirJZOYpi4jvFrIUTOuMEoCK0OkBmJNMDB25fUu3PjAA4NMZPGe0ZfV0wThPi04/12RvQitbflIB8WjYAef0ZXQNfg5/V17eowYaK+wIoH396S4fTv4vqBiuma2ICEqcAx4/HhMZEJnuPNRMBznf+LeXMON/khh240ezO2LrZb+arsY2vYLvSH1/O48I2UDaec/F0TFgxkfrc7mXONKzGqp/KM/2jpHnFyyn67+lOqM8X/SK0U6rgfkPRYvJYWjlhPoeZpJfuOFG4D2wrm5UKaWBF2RmMxFYVzFmkq2BJ6kW5zeTOkAhUte+I5kGkzW+0EiqNK/84QlDZuGzm6soY+/KZ8FdIZJ4PxNz8p+yKz6XnlqcLtAf1ww8oLB0JnB05n3u+3cP5nULIQ56PT0kBPgYtAM/4X5mrCrbI9AzNqKysh6akGIeoBCfUnaOWljmiq7lt9wgS6ZM9feQ9uSv3HuhCyqHMe0cJOWs0oTnkVYQqQZE7+ths+eugkWd92/633Qv3MAINGh4RJZtok=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TChtCRgK5VQb0NjvcYbaBLs8oxMDWvn6e91tH0Hp5NwkCq7ZuFDkr8Ta36Ac?=
 =?us-ascii?Q?50MHiN3fjekDxAvAnY8i3k2plFfzTEv9qdsfeAoFNAme0ZvlIJPMjOgdMP7p?=
 =?us-ascii?Q?RWPOL6NFhIHOAga86g1wYH3bHMwVRyUFp5t2yTkhR5ck4bx8BKlfW0XjNK73?=
 =?us-ascii?Q?OwEtY6FmKm+3T+PziNaMzEtXMZi2YVKF+HdhxtzO8htUhu5tXAivEGOqj2dr?=
 =?us-ascii?Q?nhDzcIMbdNSoB8nRLNBpHXzgsZ+a3flPkMzTP8eA3HNAagX5nW8FcGgHF1K3?=
 =?us-ascii?Q?N4iLDUJGNlp2/nH2qTq98VKdsRQcXfoQ6WTGtmZMPdj1IfgebFn7duL+dYgJ?=
 =?us-ascii?Q?ej5E9eq9Omomzyed6oDs95M+pabYODiwB2C1KsK6JJAak3i0KLdS3XF7qA7a?=
 =?us-ascii?Q?WwuBWNUZC1ZfVo4CgBtiGmWyfAR5eJ4Rqjm4nRCJFf5RcjVWHUC+kq1l9mnl?=
 =?us-ascii?Q?ZIs+xgLu16EymCdr8eT97M4ji2oZmjw9cs+lWji3mRHCkI5KyK5RHuXPhO0t?=
 =?us-ascii?Q?TistJKojfDpM1wfoVO09DqP+BcPPilbCLooPrQoz3JVNkm5iZNt7xnZiiNJj?=
 =?us-ascii?Q?4sgSGQ8T05Ut727/D+gI8qujZqXgsSGLMPLq6IzdD5dmVCTDiDx1hw7EXHpC?=
 =?us-ascii?Q?f3EYyST6K+Q8cj0YUtCSiS/WQgvxVgomYSODqOLmKH/jlKidf7ub7MtEhW0r?=
 =?us-ascii?Q?TInZZ7OyhrvC6AgPn9pZ8dcSevPw7luOtRXKj5kaTfu7XHvAj9gusR55jFJl?=
 =?us-ascii?Q?XqVsNy81xU+5mPb4IK4RHFGe2clhva8xh5MZM3hLDB38/19Eb5TNNadyDQxp?=
 =?us-ascii?Q?wkukPBs0FJeb1+PQMzYaLKcBMyaAkLYFGg2EsvTC4oKUpdLh7W+K8gmBwmNc?=
 =?us-ascii?Q?lAt6dcwyvxsutgw/A81jJp7HUo1T05vQWU+LbBaeNRoq7SlB9Ici+DWOOBWu?=
 =?us-ascii?Q?oE/VxzJbu/4Ddjnnk3ufxQG3jMYmjut1m9bMD8C2JyKVUmenwQpihT1pXgyE?=
 =?us-ascii?Q?ZXJw95HYxEYj9Oo2jmO+d7TZTx9FlWLofyK3OZtso4EfPbkYn0pQ5hBoAXct?=
 =?us-ascii?Q?D0wAN0iNFVm4L4510qLP3Q6zLuUctlCQIrhRtuc/uHytMo94El7xXUHIz10s?=
 =?us-ascii?Q?TmQMu66F8UpmBKHjg1K57Uj/SIokJmRD2Gjj8RDOUDh1ab1USpLdrUqnPevn?=
 =?us-ascii?Q?rONGt4Ef6TFO/JIuHugYXVASUC+G/UrQEizmjcKo7gx3WnjTGcWHxvh7y397?=
 =?us-ascii?Q?tKJ9lfkd409cfAIQUSGTPx6o9zbvsTC3r8CLl0MH29WWv/+2hnkj7p08YMQg?=
 =?us-ascii?Q?nTKNFqrnJxPH28O0OQGWVuKTzAsjDjmWsqe/Ix6ZXi0RpGoz48s+f6ldDLku?=
 =?us-ascii?Q?r1f30ScqAErJ58r3cAC5Qq6Biu38i+to5pDFtW/fFml4Qf+LmiA/gKzJr+HE?=
 =?us-ascii?Q?A6/nHAsMgeHGTF2veHUWNCf+DIRAlqLaNSN3/odZzrpnuRuZ3rOdxnGnUKkc?=
 =?us-ascii?Q?2gtzT0qAJ6wtJxp91u6BJOlmzJHQvy1itKntRiAj2wkP0VMwWLPsN4A7mkxA?=
 =?us-ascii?Q?l410JNFqzRp8Kn0soDKYoW7CWAJSs8ndKDGYaVW+T8eOnfCTbuK67FZloLbT?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cfji9tN8sg8Fa8e7YwspDvVOKpS4EWCsCcMRRCkxPvoJo6Srpkr1m7KsHrxAfzstE6hcPpMjicEIlKE6kCjxJzJ/M3rJAlkxEn4OZl8wn5wa7z8V6Umwx0nmhTpJnjK1GeEeg51DVHI94G2tZhPx5qE3U6mc+Pgnc4eELQY1jcDfpKMsR3OAJaYXJl065JwamPW50BxGwykvLbtgzRccwI3SC2ZzKmkYbYxxv/EZY0e8r55SAe+DIyiWlw7usStmMYUNGJRYFmVBuTaVIUFeRvsR9ywhhdGCCDuvsqNeewgvEg8HS8E2Ova8QRyn9VYL0j77Mq0zJE4p1sL2fyFSVO5hBl7lKI1c4dDy86rTNLY7Pqi1/uCOh8zZapVR/eCauNp47RrJrIn5nwf2z9x4CprisE1okmXiRA03KggUHYYcRl59iApxUs7RX8OrV5WUNg8d5itAQ56WF1Vx3I39FYNbOm19uQyyA1sK+fAbVX9pSMUvEgTfs1rYb8QYEuoH6YZx5WX6q9T8WR/OABZnsgBLbrFSHU1eubr3SoSfl+lYdNhRRCe4qmsDYWtzglqWtzjj0mqErjxC0/EzopDZPiQjDiyL3dIpRUnlKgtYoB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663d7af6-cd37-49f2-69cd-08dc4f3084d1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 14:08:18.7485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/A1bsauNUKxFYjt83aoO5b2dGb3vZ10X1lj/Xrm3JyljXpC16feggBHCNlJRiIMCL7XXw9wjriTpN+Aq4qmcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7378
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_13,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280096
X-Proofpoint-GUID: KdUE8kRjhKb4hGqQnbpjQBJpt5khBv-b
X-Proofpoint-ORIG-GUID: KdUE8kRjhKb4hGqQnbpjQBJpt5khBv-b

On Wed, Mar 27, 2024 at 06:09:28PM -0700, Dai Ngo wrote:
> 
> On 3/26/24 11:27 AM, Chuck Lever wrote:
> > On Tue, Mar 26, 2024 at 11:13:29AM -0700, Dai Ngo wrote:
> > > Currently when a nfs4_client is destroyed we wait for the cb_recall_any
> > > callback to complete before proceed. This adds unnecessary delay to the
> > > __destroy_client call if there is problem communicating with the client.
> > By "unnecessary delay" do you mean only the seven-second RPC
> > retransmit timeout, or is there something else?
> 
> when the client network interface is down, the RPC task takes ~9s to
> send the callback, waits for the reply and gets ETIMEDOUT. This process
> repeats in a loop with the same RPC task before being stopped by
> rpc_shutdown_client after client lease expires.

I'll have to review this code again, but rpc_shutdown_client
should cause these RPCs to terminate immediately and safely. Can't
we use that?


> It takes a total of about 1m20s before the CB_RECALL is terminated.
> For CB_RECALL_ANY and CB_OFFLOAD, this process gets in to a infinite
> loop since there is no delegation conflict and the client is allowed
> to stay in courtesy state.
> 
> The loop happens because in nfsd4_cb_sequence_done if cb_seq_status
> is 1 (an RPC Reply was never received) it calls nfsd4_mark_cb_fault
> to set the NFSD4_CB_FAULT bit. It then sets cb_need_restart to true.
> When nfsd4_cb_release is called, it checks cb_need_restart bit and
> re-queues the work again.

Something in the sequence_done path should check if the server is
tearing down this callback connection. If it doesn't, that is a bug
IMO.

Btw, have you checked NFSv4.0 behavior?


> > I can see that a server shutdown might want to cancel these, but why
> > is this a problem when destroying an nfs4_client?
> 
> Destroying an nfs4_client is called when the export is unmounted.

Ah, agreed. Thanks for reminding me.


> Cancelling these calls just make the process a bit quicker when there
> is problem with the client connection, or preventing the unmount to
> hang if there is problem at the workqueue and a callback work is
> pending there.
> 
> For CB_RECALL, even if we wait for the call to complete the client
> won't be able to return any delegations since the nfs4_client is
> already been destroyed. It just serves as a notice to the client that
> there is a delegation conflict so it can take appropriate actions.
> 
> > > This patch addresses this issue by cancelling the CB_RECALL_ANY call from
> > > the workqueue when the nfs4_client is about to be destroyed.
> > Does CB_OFFLOAD need similar treatment?
> 
> Probably. The copy is already done anyway, this is just a notification.

It would be a nicer design if all outstanding callback RPCs could
be handled with one mechanism instead of building a separate
shutdown method for each operation type.


> -Dai
> 
> > 
> > 
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > >   fs/nfsd/nfs4callback.c | 10 ++++++++++
> > >   fs/nfsd/nfs4state.c    | 10 +++++++++-
> > >   fs/nfsd/state.h        |  1 +
> > >   3 files changed, 20 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > index 87c9547989f6..e5b50c96be6a 100644
> > > --- a/fs/nfsd/nfs4callback.c
> > > +++ b/fs/nfsd/nfs4callback.c
> > > @@ -1568,3 +1568,13 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
> > >   		nfsd41_cb_inflight_end(clp);
> > >   	return queued;
> > >   }
> > > +
> > > +void nfsd41_cb_recall_any_cancel(struct nfs4_client *clp)
> > > +{
> > > +	if (test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags) &&
> > > +			cancel_delayed_work(&clp->cl_ra->ra_cb.cb_work)) {
> > > +		clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
> > > +		atomic_add_unless(&clp->cl_rpc_users, -1, 0);
> > > +		nfsd41_cb_inflight_end(clp);
> > > +	}
> > > +}
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 1a93c7fcf76c..0e1db57c9a19 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -2402,6 +2402,7 @@ __destroy_client(struct nfs4_client *clp)
> > >   	}
> > >   	nfsd4_return_all_client_layouts(clp);
> > >   	nfsd4_shutdown_copy(clp);
> > > +	nfsd41_cb_recall_any_cancel(clp);
> > >   	nfsd4_shutdown_callback(clp);
> > >   	if (clp->cl_cb_conn.cb_xprt)
> > >   		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
> > > @@ -2980,6 +2981,12 @@ static void force_expire_client(struct nfs4_client *clp)
> > >   	clp->cl_time = 0;
> > >   	spin_unlock(&nn->client_lock);
> > > +	/*
> > > +	 * no need to send and wait for CB_RECALL_ANY
> > > +	 * when client is about to be destroyed
> > > +	 */
> > > +	nfsd41_cb_recall_any_cancel(clp);
> > > +
> > >   	wait_event(expiry_wq, atomic_read(&clp->cl_rpc_users) == 0);
> > >   	spin_lock(&nn->client_lock);
> > >   	already_expired = list_empty(&clp->cl_lru);
> > > @@ -6617,7 +6624,8 @@ deleg_reaper(struct nfsd_net *nn)
> > >   		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
> > >   						BIT(RCA4_TYPE_MASK_WDATA_DLG);
> > >   		trace_nfsd_cb_recall_any(clp->cl_ra);
> > > -		nfsd4_run_cb(&clp->cl_ra->ra_cb);
> > > +		if (!nfsd4_run_cb(&clp->cl_ra->ra_cb))
> > > +			clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
> > >   	}
> > >   }
> > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > index 01c6f3445646..259b4af7d226 100644
> > > --- a/fs/nfsd/state.h
> > > +++ b/fs/nfsd/state.h
> > > @@ -735,6 +735,7 @@ extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *
> > >   extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
> > >   		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
> > >   extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
> > > +extern void nfsd41_cb_recall_any_cancel(struct nfs4_client *clp);
> > >   extern int nfsd4_create_callback_queue(void);
> > >   extern void nfsd4_destroy_callback_queue(void);
> > >   extern void nfsd4_shutdown_callback(struct nfs4_client *);
> > > -- 
> > > 2.39.3
> > > 

-- 
Chuck Lever

