Return-Path: <linux-nfs+bounces-4993-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40639378DD
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 16:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A21F281845
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 14:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2CB1DDC5;
	Fri, 19 Jul 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hSb/RxEI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qmvJrcVk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AB39FF3
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jul 2024 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721397674; cv=fail; b=UcwJM3IAQiGapDM/YM58exwBYIYBcSzr7NmjnORT4IGmUjfV8jx8bDByiWsTwePwr+cZEq73ANh2zLe+aVyRM7EvWu/MdQ1b9SOp0VqLcuu9vnO8RVZr2Gqk1OJSrgHYYehNsLkD+5TgX/CBe/hi/WczzbjwEeUHJwGnlglVfmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721397674; c=relaxed/simple;
	bh=SNhYPxvGe0cal1Lku7XO5YHRjr1IMw6QGgX69w94nKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U4F3QH1tTgR46Cv0LM0TAjOuZYMskr1j/Bw74kg6/z+2SHdCBgGcxmbZd0o6I5pB0+4WzieqdkxivQZwZPE1TfAS419MIA/WeatRFuHgwEHZXL5FdGQu0YZn4m4ODaSBNvBUB54YaLyzIUgBw/B+t8IVzRLN3RQMvVaSbCRyoco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hSb/RxEI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qmvJrcVk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JE0WJw012555;
	Fri, 19 Jul 2024 14:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4093QRnBJwOoUBW
	QP8yvGKsvQswGGSH1oy0KyV7eIhQ=; b=hSb/RxEIx+YANU0bGCVY4q4Hg/J0eRT
	qhODWLakP5nYgpOCGLygXrPMIBdoaQl4nFUsiFa8jh/ro6/C+3JSFfeTsVrIreSv
	wZ4qNj0JrUzlBRCj/okadxiMYm5yErcZq2O3Y+QgvsyaiDp9zlY4+q2u007gCYsu
	5deaWfUv0qRRwAt4B4eWq0xrUSl489MUPtsY/8XaPKzXgBx5TXkbccaxO80FsHjz
	hbMoynZQ2ZsEilhXEgBUoUauwZPaK9+LBf1yyFBzeJT+nT9bLBQ9OCooVAenjXlw
	Av6ZrVXskrk6OjzWdSST0s6mIXksHD2WlXR5OFcgcdPfIfhjc0sSGZA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fsh8r02g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 14:00:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46JE0pxx031570;
	Fri, 19 Jul 2024 14:00:59 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwf178q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 14:00:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hxq7FsVCwbGkRAEkhAL6mZ0VZmihGhyX6JtlSyvB9P5QobfIAMrrXD1wHMw8nQiM/40sgJquEFR550azOupb26yVOXixPrBIIZZFKvLAtfDDPm+7NOrbSP0LUdGIwvRHpfVTMXmEKwmNjteQjM6IMtpFFy0rm1gVUFP1+8By/oK5Jz7VTuQ/mT/tfPcLz5RB0HQ7ApGujgHQHiW0SgtLMuAUV6TE4kKeoztbj2TnVN5biuByzN2X2iQo4T/5NT5bGf81wwk7BS4d8fQi5rWmCe9sm+BhgdmO3YucjcybLKi01DBWzz9Vov3Ec2kPY4eMRyANVBE/Gn2P9EHH+Gnccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4093QRnBJwOoUBWQP8yvGKsvQswGGSH1oy0KyV7eIhQ=;
 b=g+178yzRRg8Z1/TJIlVg4LabK7rHcQn0uIwPcvdw5/wEAN0EEzOCKJK9ziP3SiZsJ2sm21HxLN7m1CBGlflp5qYdnT1/DB3It7NFn3wS+kfR8/tk/dogpQKkrr2Gq5sWLzAsE/AkwpmnRS6lys0a3akjdEget9fmq+W4LvALPLdsZJHJUaLUHpMH9eZjq0h2daAMo1npICLe/MRfcL2Ubzg6m9sclZqvOX0c1YdEbqGPsltqaqaplLyc2dzDjpAcFPntObijbjXUQnQ5kPsozFlCmzmHo0vFeaD0tnXDwZ5SYav2s/UgtrX6FBjbI75Dx9K070Lm0SnMLemkGOLNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4093QRnBJwOoUBWQP8yvGKsvQswGGSH1oy0KyV7eIhQ=;
 b=qmvJrcVkTBtFFFZqOBQGRe4RJqiN3XNyRkzmDvur4v3km9s2/dbCW5a0FfmfESgewGytYNBeHkpWLOaU6z2iXKhZiAIiqf+0sUc4iST9riuvuj3H2YPeRha74qkUdk0Uw2g/H93Z3VgoH3AFixAspsOAcB08CVIPhaX6NaXQQVQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6625.namprd10.prod.outlook.com (2603:10b6:510:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Fri, 19 Jul
 2024 14:00:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 14:00:56 +0000
Date: Fri, 19 Jul 2024 10:00:52 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: trace: show TIMEDOUT instead of 0x6e
Message-ID: <ZppxlFI8Yt2jUkhZ@tissot.1015granger.net>
References: <20240718070640.1913-1-chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718070640.1913-1-chenhx.fnst@fujitsu.com>
X-ClientProxiedBy: CH0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:610:b0::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa23f58-8a04-4bfa-a070-08dca7fb357c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KXdOGeMQ213q5HY4qj03YGycJwq1TXKTHvv3o5yErOX6EH5gaRcr/JrffwgT?=
 =?us-ascii?Q?/c/1coBWNk0Yz98WE+TjzndLle3qmieX6WT+qi6t9p1YA4jSCVVLfH7v7S7U?=
 =?us-ascii?Q?h84V9tmBp4GP8Dv4ki65fBPpxpx/kkqaVYtBSrmuPbEsd29yUwpiUl4OJQnY?=
 =?us-ascii?Q?+xHPu2mduyMMd8pdLny9Sow0q60vblCWMTnTJ9wUZaNc1Ega9aicngAfimBH?=
 =?us-ascii?Q?Ka9SfmGhOahp2PVBEJINz7L58DM1aUVt56gYN2f9KqC7nWoJbAIj+gCQLbZM?=
 =?us-ascii?Q?kIY4vYBxKZf60sspy5lZETl59BYcddOo7NC4daLSw0/D23tQuBXfNXkQepeS?=
 =?us-ascii?Q?4d9VAU4YJGA1R65LapzEUQ2U0okNbNjltZY53rD1lSfORByHubGBr51y9tGq?=
 =?us-ascii?Q?q8wYi69ubSaLsb25Xtoru5eVicfQFibC7jTLcIwqLSmVL0Kq9MNzCoo3imr3?=
 =?us-ascii?Q?aLmS7TdoaNwiPeASVQIPvS7DzXxTYn3qyoi4TDNQ+eklH/CVeoSnAvyqgRbS?=
 =?us-ascii?Q?o8PnFxD4ZZhDC9XgK/i5tBMNdi9flLq84Ne/o9o9M6/Fhp/Ch3FE7e4dYpwt?=
 =?us-ascii?Q?pabBw9l4m4VpQ+yPkFZsrdJ3H+wVMK2kJhPMBygltQpct0HJRy0IYSIHs+7P?=
 =?us-ascii?Q?omLeid0fgFBDHyuV1rJNXHGPIKZiX7Vz7RgOTYKg/7BFxhkWYp5T00asBe5n?=
 =?us-ascii?Q?cmasNFe1bZHtTppXO8uzEGkbjjGEAQ4obCFjToVRRCa4t77EBFx2IaHIyD2u?=
 =?us-ascii?Q?0zlHqvWDCvFP6b/FpJwssrCaSKO5U7GisnGi0qNATJp3ftxKfBrOrUMPkdEd?=
 =?us-ascii?Q?DFaaPMs5SQ5p9nYb27Iq2Hnkz/NmEwQLoYNN+I9Fyu7jyXrLj5QqKz/cGSSa?=
 =?us-ascii?Q?j+9Aa/ooLGHG0HI0xS89jWDyWrblvUQdykYc+pv1HAJ8UF0j5SUNyNl5gAtI?=
 =?us-ascii?Q?JvDUjL+vn0c3DAZe0yyuFfk4IAXM94+cKjxjfsdIaVQzOUmgFUKjWBtMoTHM?=
 =?us-ascii?Q?aIb3dqE5zJb3YRTDuEBbpM8YOQeWxQ6UwHQHtz50Hm8uwMiq3JqKD6yc5Y20?=
 =?us-ascii?Q?m092ugDj7itmonqf/WdV2UoalVE0j9GgeSePjeFDZdVmHsVr+WGU356M1l/q?=
 =?us-ascii?Q?ucrD72d34zO/BDgK8Guu7gMXpiJtJuwbb61BtEDiPAxvTzHD6ourvL4/8j5R?=
 =?us-ascii?Q?UAxcY1//a3eCk8jOp3W8Gyt1HIjVohHM3yE0VrYan4eBDYHCDs4wJSn/oS95?=
 =?us-ascii?Q?pvx2sVjqRouPF3fYiJsQ3qAauTJMS/DNX83ffP2WocedLIaqiw1sYbgCHHc2?=
 =?us-ascii?Q?s8pVZHwHonGQfiKejiT525aLAthH4kgphuiyUAVLIOUpeg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OkmUvS07rW3kalfUuyYCCyqlcm/wJUMQc8F8iPjhWrRFOmdO3VxQFp+MsqA+?=
 =?us-ascii?Q?bfRCnwfBeOJnTvZjNdlDHpC6hDYazWogvucXH/CFh9e1uSTeTAL/eP7flx7d?=
 =?us-ascii?Q?qj8mwTnR/GMpeiG4FWK0bV58mt/4GnrkCEez2+ruNYatU8RhfngWpPrrH5RD?=
 =?us-ascii?Q?j8exGA3sLao2vHktz1HIJ1jGQQI4j+RKe0kfRVIBqdU85/3O84TuFRuj5mb0?=
 =?us-ascii?Q?xzPeRzRyeFo22qEVQRuCNZijuo/W2iEW1ZurBC9SaIPIy010FkTP1w/ZhtEJ?=
 =?us-ascii?Q?vfMFwgO+ikYdlz/HGR7jXYWt5/SDBdHUpl9hK1Gj4MZcBO3fazR6aFlZeWiJ?=
 =?us-ascii?Q?2+ZHTef7SeyaeWMk2nEn/8U7hICO4Eyf09v8s+7Of1If+G0djlrrmhEm9snC?=
 =?us-ascii?Q?mf67KCgbp08UpRtGS1nf+2l06ZH3zIUph17qvtjsVX8UGTm3sa7+fYRw3Eih?=
 =?us-ascii?Q?1+mCd8hWFDuwEdTskIQpcYanTnGUgterbDvi6SUkbxdND76cvb0D2mW2Sr2z?=
 =?us-ascii?Q?PC16N26cildaAzLJ2/jcJriAKMlTrAL7GBUbZj0oYZjRYuXg2pdcbOTC/Wru?=
 =?us-ascii?Q?AjbhiST16HAzpNXzcfBumP/Plv5bQyNYT0QI2bhMxbBnbEqRk7/0VUtZF3Jw?=
 =?us-ascii?Q?xBf4HqrCr5+mPZ7y/WhyoG1n3sF6L8oqDoJZXNyrL+eMo0oEc9GAHzmJLfpo?=
 =?us-ascii?Q?fiM3iWUFF2k2Gu2+KkfVUBtSXlOry7rTeXRP/BFUTqm2Kv16GazneJdp9lnN?=
 =?us-ascii?Q?+AmmHVlOb3DlXWykAKJNxqMyRxEcxCt9uZm9oDs0f6cWR1eRHt6g9B1DEIed?=
 =?us-ascii?Q?dklHbEFe1tepqhGifXNCulpmnEGu10cIV3Nh9WEtt087kkGZWtVNrd334aBv?=
 =?us-ascii?Q?Z1H/94FfdZxfJynr3ztMPJlVLlgN2UKLDUVBYigWB8aNx0O+gYMHFI6dmmYb?=
 =?us-ascii?Q?b7d14AxTXE2gY8Zsr8PkEOYd10pfQSzE80Ve71wFaVk8uFvDTvwnumHK30oU?=
 =?us-ascii?Q?5v1ZZ3zPocixkyEp7lHw3WXtONCalE5rbMT0ZeDAKSdvFnYl6xD8DDknRL/8?=
 =?us-ascii?Q?yYdzVEm8fdurxKPk0Acc/Uc9LhOZtL4Wn+HeKgTiNlzF2BObqa3aq291g1V4?=
 =?us-ascii?Q?QQ3Yh+CL2z91xKaGBeLXvng97WYXE3unro2Z+kCLwoQW0ASvL/mtUQBoVuVA?=
 =?us-ascii?Q?HAIeNZwOeQzDx1Qm0VpmUu4CS67yuNuH7FsvupOdeT6PSWTQzSQZFmkYESlg?=
 =?us-ascii?Q?zvnqS6Y7oohnMwQ+EHupYphSZLdfzwr38R0FJomG/fNveIVtsDTtp9xILsJv?=
 =?us-ascii?Q?1prnw99t5vy+Eyp3sRZGbeYICtlVl5vX9LCb1SuJqo0OcYqUqCpWpSKwkZrI?=
 =?us-ascii?Q?lKgl+cWQNHDjKXAYAMDmB5gmOyJfVNF0jrhqjhbcRZgMBpEPaZyFz0dqeCUi?=
 =?us-ascii?Q?K55hNcErwOnim5UWgIXUChMscmqnK+ncPqXXhmTrpm325D7zuj43shpvjAoy?=
 =?us-ascii?Q?LyJtEaf9c2c1aih8gZX7HdOLdVZueSywAYH9EIbfiA5Oep0MXf3tvVnSuQgC?=
 =?us-ascii?Q?VbLJRxIdIBryncrevnoEWYwYfUFJVK/LEZUrXCNl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yJfCzPLImoZQc8z2+u/SbuGxkx7yPR2wIeSAVVe80k0hjg74N2Q8uY0H36523/TpnqJ2DE5sIvt8cMY82k04jD/p8NgN9txDDr6KnxJ4T88foibj7nA6UpeI2drtyaj4EmX68EcgZhBySLqWyyHVAyexOd4V9hbWhkCl45NlxykMjWVKccxJ9Bw1dwFFU9fa405UPbO0Ft32OC+ckVmkMfiO2wDq4x8aZZCh0UiRPd/2D/OzWNLNFmB1hy46abwRzKqZvr8MHzFrMl67lUTj3FUZF3gKYSFSSDGWw14xC+iBWh1YE4XFolfuZ4ts1tWOLTVvIatDVzmy03E2wI7mNrjpFHg+76ygmE1y8IE38ReGWbvx0N9NjvZhKPYbLNq9QfLeJS8nvZjiprK4BSw2jzX31R1gY6raDnSPID3wkFBdfXt9dKly64Z5vQwXDvI1ypdGduHH40hSDC24/7QxGAGLUdb1cEl85H8yAYEqVJU+GQW0Axprfy+9KtLNi4WMmiLMtsTOBXBci26eVGyN4y1sPl+MdDCKRJthBnw4W0iCYWLCSDDQIQIb76vsD5vvUVDv07zrC1UZrxLjsEfO9KHXaGEkBf8/lytk7qoKzPA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa23f58-8a04-4bfa-a070-08dca7fb357c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 14:00:55.9460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgS/pH8bxm1L18Dg6CJWAD7J0H4eE6WBIZKj4WYC6SIaUESsPmdIfHpHWtkYR82m98buBQeAs0bdZrm/o1/ZJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=850
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190106
X-Proofpoint-ORIG-GUID: IQXUmQlucO4FehIl1LtpsOBn9tyVwORo
X-Proofpoint-GUID: IQXUmQlucO4FehIl1LtpsOBn9tyVwORo

On Thu, Jul 18, 2024 at 03:06:16PM +0800, Chen Hanxiao wrote:
> __nfs_revalidate_inode may return ETIMEDOUT.
> 
> print symbol of ETIMEDOUT in nfs trace:
> 
> before:
> cat-5191 [005] 119.331127: nfs_revalidate_inode_exit: error=-110 (0x6e)
> 
> after:
> cat-1738 [004] 44.365509: nfs_revalidate_inode_exit: error=-110 (TIMEDOUT)
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
>  include/trace/misc/nfs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/trace/misc/nfs.h b/include/trace/misc/nfs.h
> index 7b221d51133a..c82233e950ac 100644
> --- a/include/trace/misc/nfs.h
> +++ b/include/trace/misc/nfs.h
> @@ -51,6 +51,7 @@ TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
>  		{ NFSERR_IO,			"IO" }, \
>  		{ NFSERR_NXIO,			"NXIO" }, \
>  		{ ECHILD,			"CHILD" }, \
> +		{ ETIMEDOUT,			"TIMEDOUT" }, \
>  		{ NFSERR_EAGAIN,		"AGAIN" }, \
>  		{ NFSERR_ACCES,			"ACCES" }, \
>  		{ NFSERR_EXIST,			"EXIST" }, \
> -- 
> 2.39.1
> 

Applied to nfsd-next (for v6.12). Thanks!

-- 
Chuck Lever

