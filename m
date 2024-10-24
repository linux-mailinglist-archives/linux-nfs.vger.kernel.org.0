Return-Path: <linux-nfs+bounces-7427-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB369AE701
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 15:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676841C2136C
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D771BBBEB;
	Thu, 24 Oct 2024 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UYCfMGKF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t5EgWsdr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA41DD0CA
	for <linux-nfs@vger.kernel.org>; Thu, 24 Oct 2024 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777823; cv=fail; b=OpP5Il/MadduoiYLAKvu9mlrZgKevPSxkTc3pA6NTXGK2zhqudgZJZXLc669CvnVuEnEE9RjWLh/qxrDzF++C9gG7jNbBCsen0Irxc1vZ+o/aK+NrC1AVpdPfMNTlsU8PR2DXLWy+vyyszZTLfgWQAW2/sF6g2xqZdQ9yzJWRvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777823; c=relaxed/simple;
	bh=dVoz+p2Fvu2t26LmOT2vYYgG2zDV9RK/FkdIaxI29ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b5fI1SWi686FvrkdxEKLT6MDVtLnNIoYwZBoRWCW4IsZxpZvDS+xFfrcDBFr1WnQnPEKprh2MjSIAQ/dk8j+b4fdAsuPWivryv4cz2XXfXd7hrgAAhJpnot2J7EQy5E/0QOX6wxO3cppwVF6K+DBbiy2eIBUJ8b5JyDwfTDv82U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UYCfMGKF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t5EgWsdr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OC1Xpj030546;
	Thu, 24 Oct 2024 13:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=NNLAv5Vwp0xjiceVHz
	ZtgumI99zKSdE6gF3Jn6XEHC4=; b=UYCfMGKFrJUr6F2NsuhVkWMBT/5awwblST
	u5xl90mvXwonWv7GMTbYnbZg11EEcnGoo6XT2eUNgBtGoHL3NJ9UZtG+T7Cl2Dm6
	pIOOfhaf5ouLA4ufrr8MIPWIAQgAR3X9Af+oZ7aHP6E40QlBgeOcQIpqNlz1j5lW
	rQXk4HcE0HYmTX0u4w4jUkRUciGZ3rKgrkfutUamKCGMZ3jzlyfB/7gXV4xgNJXc
	jMAtz5RFWYn5DNO4CKh3Vye5wqii7JMlDB2xt9D7ocut31Ubq0YqBRAotgz+hmv0
	/kZNlHZsEuwGCtGuW6seEhE/3GXRLw+RWlAPnvgjlSJ0qkm7qMxg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53utn1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 13:50:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49ODhSj8027391;
	Thu, 24 Oct 2024 13:50:10 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh4bscp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 13:50:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxVXo25d8XmBSHQV8YeylxYqeIZEU5WTvSisQpLnRsNDrVvf9mLT7teMdbzzkEp2vzKkHeKQoBZ5lcR9mFgT0pHN2ZaFPFgXw34eTMhgQspLmRtxwLiiTE6wQnt4vtg8ghc9Z1WZmIco7m5SScSZkuMgucGpsOyCLJSbEjEg5LD/o6cm42SOrYWWRT+BXXezC5AZmXC28HPRVjQWBWJBpCxL3TyLuHjTQL7usQAjznrZ1X/y1QlYf11vxc/BAUJ3+NsO9z2pOdvTJi6T8T6u/3XoZivNUVv+hwRtwz281UYWvhwtFjfRXnT2mrEKAukoMACnFoUWDWMwrl9ybk4kNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNLAv5Vwp0xjiceVHzZtgumI99zKSdE6gF3Jn6XEHC4=;
 b=D8JtiQIhpv6a5Plaf9iU8g2GYsNC7/NuzXF3bmAugPH5tCSqZU6NZadkTLuf3kd8mmU4t5jelqYak5+ammZHj2KPJKuA7A1McilaQvEsPuzSarBPRJJgfZYJ2ls/Os7C4bX+qYeUCFUQswVBodjiBoR+63tWFs9RODeo34Kq8p7B9tH03os8CWFkjyxUPCcSd1XykR8xcU8xO0elIXYHlahXVO5Mk44X5WCJOvocg4eeQpdsX1wnGrPi3uNYZSQJnvVC4ARMtLSFr9BLHbkKIV5rTUAE0PnlqwoBtZ7mMqwlnbI9jwJc2fO5U7oECHuiLztWf4hF+bDGNgDxdAaT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNLAv5Vwp0xjiceVHzZtgumI99zKSdE6gF3Jn6XEHC4=;
 b=t5EgWsdr62IPyo1ADRGuuoxdr7Q488s6VEbA/9sMdam+pj1MymuNBQ/Ebc4dv2O+Hffm5A9xHZ30XNfV8CYZ2m9CQwL/hqB3ckGEKChFXaHELfUGHFElt+iu7EU0WOqPdQnlS7iRftICfSP0wbDYDL9UyjAdUekMH3xuebNxoYQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5767.namprd10.prod.outlook.com (2603:10b6:a03:3ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Thu, 24 Oct
 2024 13:50:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 13:50:04 +0000
Date: Thu, 24 Oct 2024 09:49:58 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        okorniev@redhat.com, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH - for -next V2] nfsd: dynamically adjust per-client DRC
 slot limits.
Message-ID: <ZxpQhkpsk3NOnWAg@tissot.1015granger.net>
References: <172972079577.81717.6397186554656127040@noble.neil.brown.name>
 <172972088601.81717.17711026200394256822@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172972088601.81717.17711026200394256822@noble.neil.brown.name>
X-ClientProxiedBy: AM0PR01CA0105.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::46) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: da9dd28c-fd31-44c8-b62a-08dcf432c31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GMbcUgFMueuNiek+HhIUIsd1tasRy6D8BTU49k+/h6Fo73+IUp/N5gxjLYdd?=
 =?us-ascii?Q?r12M2SHdbttBJ4KqxxXMoSANaYMrJD9npV4McWjwg6Lp1URSFvw9ZluRjdvl?=
 =?us-ascii?Q?DUfvCL0lHBVvvACN4mkqAWCj9DDWWwOr3wADxKFw3qjzu0wzLUEH+g41GDpp?=
 =?us-ascii?Q?q+lYEG8R5ML+FJKUUI3Jnt3ZYfcw7YvPPSs+ro2+daMl6cJfJif+bnyT3hK4?=
 =?us-ascii?Q?QOGALwKWDTf8N+Ny/4YiQ9sZ/aLMxqRKo3/6ONXJLuk5A0QfZN6LCXZ5tDMb?=
 =?us-ascii?Q?16mjQf2AiqEHmM8qPuREUQOmCbie8f1OWAGMVUE9LAGSFIjq5ZcIP8HofFc/?=
 =?us-ascii?Q?uOtAJLA3TggVtdP+zuV2eYQuKy5tQkdcmoTzyGUo1Msz65L7dAWOvD9936QV?=
 =?us-ascii?Q?wZ5WmGvqtPnHzbMwSCzqZage3RVchXvsJuNen2FGyP6epugxLZRfTb86Jc+O?=
 =?us-ascii?Q?Vu1mbUJZARat1YHTTls+cZ/t2W9E/GAgnIyX7V2vKNKc0Jc3zOy5Qaf/SR7l?=
 =?us-ascii?Q?BuAXBWT21sdcuyO1Qf1gu1uaaxPWo8nygaLzEZpouijTIQANQPte6OeovTAS?=
 =?us-ascii?Q?h0v3KEU4kf0BVEVbvPEd/n7QNHwEaWRGjPXTJY4BH43gTZYVljqmLwxRa7mS?=
 =?us-ascii?Q?VpDriIfzYTdWdtFKif/JLbd0KT7rs+uiVWwssW/zeSHQu/FTeH+56jBnZgq/?=
 =?us-ascii?Q?6mG0qkynBOroUapyApATH0Lt0CILJTQP3GhAF6JtUIjSR5jJJfmi5l34f1Vw?=
 =?us-ascii?Q?8SDVbDvDuPDIYXqXfgzJUUsCWEbxDPBdAhdGbByL0cRyWz9A3gXRsTb0Uali?=
 =?us-ascii?Q?r8/CplcBiQc4lzVQ5b4zSZFgiHVVGty3seyt9309qrr0QDVjE0bdo525Y46D?=
 =?us-ascii?Q?BfRR8nZ7MyXrDPnNrsKHHKcwjak7UeFm5ld2jlpQudTCO4CVtqCCM6bVFk4b?=
 =?us-ascii?Q?XE19wCDFKcQkENyRrWHKrrWW+Nhm2KzgERbwejq91SEM9wKGBr5G8OH4SRLY?=
 =?us-ascii?Q?oDPjRqSkD15iwAXVTU7y6T/7ZEXMrRx2DAYRwmj041Y5x1ro0TdO8DRnphiN?=
 =?us-ascii?Q?IN7wviYBCXOJ+NfmNk/aEsaKkf06UNkH6l68mTgvQEPOy8zZ11/OGqDrGDlU?=
 =?us-ascii?Q?5UrhOwsDqR5fwV5AhgBkqtNQ79lK+eIdmAKO0PMcsSFYn9S0qiX/X0rsmqBe?=
 =?us-ascii?Q?BmNNdGA/SzYHs3fd0OH7iAXJf8+EqM+irDBsDWX4PMjLA9Sny23EoSgEcWJ4?=
 =?us-ascii?Q?C/ZxNgbL8XUT8/wPIIgXiXSs2/e4E4TrPYhixJgu2lXjetmOhEw4ohYNJd6y?=
 =?us-ascii?Q?yZE97h+xAubvV3t0HxWoSinA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OWwQi8/Hhd0zE2ZNxRU78J6wyklPeczrPRWLLM28P1f1oIBkh+cJxSFxu1Va?=
 =?us-ascii?Q?DR7w7yw3a557+5Js2YVa5V9R45T0qJzlW4T76TjQOV9mxqR2mWn+k0r6NjUQ?=
 =?us-ascii?Q?07gQDD0dVVWqds12S9wQUwXgWzbyQQnPRVevWSyjmefRB3dRErffjwAyYp9V?=
 =?us-ascii?Q?W7FSB1rVDsYpFK1XuxOXA992Ti+grfw/odOcMPNbDLppUg9iRK16yhZHJxXS?=
 =?us-ascii?Q?8dLAAUbiL9bN51Is0ezD8Uod6wY8e4l7zcNJ5s1jMhhpnpLyK/h37CTNBxvD?=
 =?us-ascii?Q?ihwg1FdB006QzxcapjD4y2yQsGcHco65htlsPpJqFWKaxEw5mm/X29h2KgVa?=
 =?us-ascii?Q?+FIz6+oIlN9/ElcV1mTfXlrrDfJK1KshijIyxt0AzRLy/Y7SUcvorgO83XrU?=
 =?us-ascii?Q?usYy/qrmPPF53EOOVKO6l+fVJOKPgyauIG1wWmH0ntoAihkLPHQJ2HNZNZQp?=
 =?us-ascii?Q?59LVpImgihCbk+pfZCo+D0HGM8au1Y0m6AP4INAw8P7gVaakZRt59gJvgo0q?=
 =?us-ascii?Q?Rlti85mwDGs0Mtgt6l2cjej6leCEjHumAVda7/pDAM6GkOw1KyHme9LSHFSe?=
 =?us-ascii?Q?4diVc3rseFkqu68IstRKS7cE8ce/bMAU2xJ0Z1sALIiemXQYjemq7UdmoV9P?=
 =?us-ascii?Q?MsBfsedoxB8QvViW9tRY0+uohOnYYUcTKTht3Y32oJW1EFYJplNeBokEi9Cg?=
 =?us-ascii?Q?WGGeBlAT9tBvW/Mp6EtImSHgZ9ece7dUIGNOMONul6b1PF4gfPm0T6xASi+c?=
 =?us-ascii?Q?h0Nb2Y4yIZhKt1GXExoQQ0ntbWWQxTqqQcIQA2BD5tcfPwBrIVZSB34UWuUO?=
 =?us-ascii?Q?4/SQ0utRS12HVgdyE1RYTHWPajf5fBb7QzshUjydr59JrSq1VY++J/KdaryH?=
 =?us-ascii?Q?ZWQI68DELrnzS4TwXZ66Bv0EtsZRJKzRAonv30JGscv7WdMnvZofvpWhGNpq?=
 =?us-ascii?Q?5p+mNPkyXHIv6tSZR5DkZRe4znUyTVfCaxjwkYwLpQzBASpkM1iYSdLDnhMf?=
 =?us-ascii?Q?ns15fYlIGD303RpiY3sfQMqHOvCj9eydSelFD10Tp+294apfH55fEwjpCfne?=
 =?us-ascii?Q?od741DKC3ZkgKptg6mlLEhAtWdD8oH6u4NIqvd+TCJDoc/v4kHxYIE9bMxDz?=
 =?us-ascii?Q?+0KaOxLkMK4l1zYmoU9nH+bpd9G18mt/6ZMGFZUPSVGrX82nSSF/OOYatGqq?=
 =?us-ascii?Q?5Lt0tL9zxpRe5nodIadzEl46gwA2yZe4co/fZru9vk+Poiv3j/JtjZpa+yWx?=
 =?us-ascii?Q?dE0l5iYM/f6a//RQDePLhcHc5Cy/HYpt5/nkYbQyC/xN2ThjPU+6etIM9KEm?=
 =?us-ascii?Q?uVQZlvY9dYx2Xb9MDQRF/P7woU3QqJ7wIYYkStgvUpVQRTOcbDV0i71Cuuqr?=
 =?us-ascii?Q?gsaHhy/fHCNacoIXOGoG2s5dZerz6xfdKASKIf/GesXslNRQFZC6RtPBuJ4F?=
 =?us-ascii?Q?T25j7tuP2Qvzn3W2eGguYZztnuDLk/i8dIElQk0sGI3nPolFHdaYa5ExB5wI?=
 =?us-ascii?Q?PCJxnWRtLd4uuSLXHMJ2OAWJYeeRg+fubE6wLjRTikg1b01iiehsO7UMGyCm?=
 =?us-ascii?Q?U1SlkkUPSMFnb39YFWgGsA12SKFZMDC/8oq+2c/H9wp+ZzG6IrlX/Zw+lDDH?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S5oYSd0YqJVi0vftlXym3D5nrekcq1p+HPj3kjxLbTyuNBxXnMrr4clgNlWW6/taKlpLwoCy/GdrNtQAHoK+rgcU4WDFoRX4cnxYeDMkgmGwnrhiBAygx3a7yZ2AkcxZ888U7Tc/5G3itpaHUDjDZUO3gQAtIfgpt3M3/GolschDgrkpG6ulmwwpIYH20UGWLL8WfFM+b5rqmOLFXzG5zVoK/4sKyaT0wRBz+j0g4MoLsQbIwE5mRm1ryi0lDRn/7+QndrG/+9ymDwppTsp6IOvxCYspMxV3v05zG0Ob/Xh4JZFppvb+hYiPYGKexPCNBzoBd70SEpH1WNkZm+TNWR2oAwJ3Xrgu36MjIOXeCPEG8C8pNYuMY07EK3GlnYHiZ8EfZ3X/KeyaQMEmpXYiYy3DrQbWCeLEL+XCkubyp4cY0+tKptRvBPCojnUJINu/71qgfl7upEE4QOGtFpH2WC0U13/6EUbItHLV3RVLVwb+vuK+F/Dgdl7o32C1aTmmpdqmAnG2153I9EPkiEAGPLyjHf8sjlxM3OokGzRTmgtjgAOCWjRDprwndgPYkM+j6az0sLMseXzD+E9g/yiCO1YPtG/3mtGKLVD3nuPihqM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9dd28c-fd31-44c8-b62a-08dcf432c31b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 13:50:04.1141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lviabIZTIYjoPvFy83Q5/nX3MUtc7eAnkJgC8pqyclFQJA8y4v8njigS+ie8ci7l+d9QesJmq50W1lHi7xNnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_15,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240113
X-Proofpoint-GUID: hgGlFipIKzbO7LErgeF_wbW3Y5q7NB0m
X-Proofpoint-ORIG-GUID: hgGlFipIKzbO7LErgeF_wbW3Y5q7NB0m

On Thu, Oct 24, 2024 at 09:01:26AM +1100, NeilBrown wrote:
> 
> From 6e071e346134e5b21db01f042039ab0159bb23a3 Mon Sep 17 00:00:00 2001
> From: NeilBrown <neilb@suse.de>
> Date: Wed, 17 Apr 2024 11:50:53 +1000
> Subject: [PATCH] nfsd: dynamically adjust per-client DRC slot limits.
> 
> Currently per-client DRC slot limits (for v4.1+) are calculated when the
> client connects, and they are left unchanged.  So earlier clients can
> get a larger share when memory is tight.
> 
> The heuristic for choosing a number includes the number of configured
> server threads.  This is problematic for 2 reasons.
> 1/ sv_nrthreads is different in different net namespaces, but the
>    memory allocation is global across all namespaces.  So different
>    namespaces get treated differently without good reason.
> 2/ a future patch will auto-configure number of threads based on
>    load so that there will be no need to preconfigure a number.  This will
>    make the current heuristic even more arbitrary.
> 
> NFSv4.1 allows the number of slots to be varied dynamically - in the
> reply to each SEQUENCE op.  With this patch we provide a provisional
> upper limit in the EXCHANGE_ID reply which might end up being too big,
> and adjust it with each SEQUENCE reply.
> 
> The goal for when memory is tight is to allow each client to have a
> similar number of slots.  So clients that ask for larger slots get more
> memory.   This may not be ideal.  It could be changed later.
> 
> So we track the sum of the slot sizes of all active clients, and share
> memory out based on the ratio of the slot size for a given client with
> the sum of slot sizes.  We never allow more in a SEQUENCE reply than we
> did in the EXCHANGE_ID reply.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> 
> This time actually with the comment change.
> 
> 
>  fs/nfsd/nfs4state.c | 82 +++++++++++++++++++++++++--------------------
>  fs/nfsd/nfs4xdr.c   |  2 +-
>  fs/nfsd/nfsd.h      |  6 +++-
>  fs/nfsd/nfssvc.c    |  7 ++--
>  fs/nfsd/state.h     |  2 +-
>  fs/nfsd/xdr4.h      |  2 --
>  6 files changed, 57 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 56b261608af4..d585c267731b 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1909,44 +1909,26 @@ static inline u32 slot_bytes(struct nfsd4_channel_attrs *ca)
>  }
>  
>  /*
> - * XXX: If we run out of reserved DRC memory we could (up to a point)
> - * re-negotiate active sessions and reduce their slot usage to make
> - * room for new connections. For now we just fail the create session.
> + * When a client connects it gets a max_requests number that would allow
> + * it to use 1/8 of the memory we think can reasonably be used for the DRC.
> + * Later in response to SEQUENCE operations we further limit that when there
> + * are more than 8 concurrent clients.
>   */
> -static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn)
> +static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca)
>  {
>  	u32 slotsize = slot_bytes(ca);
>  	u32 num = ca->maxreqs;
> -	unsigned long avail, total_avail;
> -	unsigned int scale_factor;
> +	unsigned long avail;
>  
>  	spin_lock(&nfsd_drc_lock);
> -	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> -		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> -	else
> -		/* We have handed out more space than we chose in
> -		 * set_max_drc() to allow.  That isn't really a
> -		 * problem as long as that doesn't make us think we
> -		 * have lots more due to integer overflow.
> -		 */
> -		total_avail = 0;
> -	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> -	/*
> -	 * Never use more than a fraction of the remaining memory,
> -	 * unless it's the only way to give this client a slot.
> -	 * The chosen fraction is either 1/8 or 1/number of threads,
> -	 * whichever is smaller.  This ensures there are adequate
> -	 * slots to support multiple clients per thread.
> -	 * Give the client one slot even if that would require
> -	 * over-allocation--it is better than failure.
> -	 */
> -	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
>  
> -	avail = clamp_t(unsigned long, avail, slotsize,
> -			total_avail/scale_factor);
> -	num = min_t(int, num, avail / slotsize);
> -	num = max_t(int, num, 1);
> -	nfsd_drc_mem_used += num * slotsize;
> +	avail = min(NFSD_MAX_MEM_PER_SESSION,
> +		    nfsd_drc_max_mem / 8);
> +
> +	num = clamp_t(int, num, 1, avail / slotsize);
> +
> +	nfsd_drc_slotsize_sum += slotsize;
> +
>  	spin_unlock(&nfsd_drc_lock);
>  
>  	return num;
> @@ -1957,10 +1939,34 @@ static void nfsd4_put_drc_mem(struct nfsd4_channel_attrs *ca)
>  	int slotsize = slot_bytes(ca);
>  
>  	spin_lock(&nfsd_drc_lock);
> -	nfsd_drc_mem_used -= slotsize * ca->maxreqs;
> +	nfsd_drc_slotsize_sum -= slotsize;
>  	spin_unlock(&nfsd_drc_lock);
>  }
>  
> +/*
> + * Report the number of slots that we would like the client to limit
> + * itself to.
> + */
> +static unsigned int nfsd4_get_drc_slots(struct nfsd4_session *session)
> +{
> +	u32 slotsize = slot_bytes(&session->se_fchannel);
> +	unsigned long avail;
> +	unsigned long slotsize_sum = READ_ONCE(nfsd_drc_slotsize_sum);
> +
> +	if (slotsize_sum < slotsize)
> +		slotsize_sum = slotsize;
> +
> +	/*
> +	 * We share memory so all clients get the same number of slots.
> +	 * Find our share of avail mem across all active clients,
> +	 * then limit to 1/8 of total, and configured max
> +	 */
> +	avail = min3(nfsd_drc_max_mem * slotsize / slotsize_sum,
> +		     nfsd_drc_max_mem / 8,
> +		     NFSD_MAX_MEM_PER_SESSION);
> +	return max3(1UL, avail / slotsize, session->se_fchannel.maxreqs);
> +}
> +
>  static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
>  					   struct nfsd4_channel_attrs *battrs)
>  {
> @@ -3731,7 +3737,7 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
>  	 * Note that we always allow at least one slot, because our
>  	 * accounting is soft and provides no guarantees either way.
>  	 */
> -	ca->maxreqs = nfsd4_get_drc_mem(ca, nn);
> +	ca->maxreqs = nfsd4_get_drc_mem(ca);
>  
>  	return nfs_ok;
>  }
> @@ -4225,10 +4231,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	slot = session->se_slots[seq->slotid];
>  	dprintk("%s: slotid %d\n", __func__, seq->slotid);
>  
> -	/* We do not negotiate the number of slots yet, so set the
> -	 * maxslots to the session maxreqs which is used to encode
> -	 * sr_highest_slotid and the sr_target_slot id to maxslots */
> -	seq->maxslots = session->se_fchannel.maxreqs;
> +	/* Negotiate number of slots: set the target, and use the
> +	 * same for max as long as it doesn't decrease the max
> +	 * (that isn't allowed).
> +	 */
> +	seq->target_maxslots = nfsd4_get_drc_slots(session);
> +	seq->maxslots = max(seq->maxslots, seq->target_maxslots);
>  
>  	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
>  	status = check_slot_seqid(seq->seqid, slot->sl_seqid,
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index f118921250c3..e4e706872e54 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4955,7 +4955,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *resp, __be32 nfserr,
>  	if (nfserr != nfs_ok)
>  		return nfserr;
>  	/* sr_target_highest_slotid */
> -	nfserr = nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
> +	nfserr = nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
>  	if (nfserr != nfs_ok)
>  		return nfserr;
>  	/* sr_status_flags */
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 4b56ba1e8e48..33c9db3ee8b6 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -90,7 +90,11 @@ extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
>  extern struct mutex		nfsd_mutex;
>  extern spinlock_t		nfsd_drc_lock;
>  extern unsigned long		nfsd_drc_max_mem;
> -extern unsigned long		nfsd_drc_mem_used;
> +/* Storing the sum of the slot sizes for all active clients (across
> + * all net-namespaces) allows a share of total available memory to
> + * be allocaed to each client based on its slot size.
> + */
> +extern unsigned long		nfsd_drc_slotsize_sum;
>  extern atomic_t			nfsd_th_cnt;		/* number of available threads */
>  
>  extern const struct seq_operations nfs_exports_op;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 49e2f32102ab..e596eb5d10db 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -78,7 +78,7 @@ DEFINE_MUTEX(nfsd_mutex);
>   */
>  DEFINE_SPINLOCK(nfsd_drc_lock);
>  unsigned long	nfsd_drc_max_mem;
> -unsigned long	nfsd_drc_mem_used;
> +unsigned long	nfsd_drc_slotsize_sum;
>  
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  static const struct svc_version *localio_versions[] = {
> @@ -589,10 +589,13 @@ void nfsd_reset_versions(struct nfsd_net *nn)
>   */
>  static void set_max_drc(void)
>  {
> +	if (nfsd_drc_max_mem)
> +		return;
> +
>  	#define NFSD_DRC_SIZE_SHIFT	7
>  	nfsd_drc_max_mem = (nr_free_buffer_pages()
>  					>> NFSD_DRC_SIZE_SHIFT) * PAGE_SIZE;
> -	nfsd_drc_mem_used = 0;
> +	nfsd_drc_slotsize_sum = 0;
>  	dprintk("%s nfsd_drc_max_mem %lu \n", __func__, nfsd_drc_max_mem);
>  }
>  
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 79c743c01a47..fe71ae3c577b 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -214,7 +214,7 @@ static inline struct nfs4_delegation *delegstateid(struct nfs4_stid *s)
>  /* Maximum number of slots per session. 160 is useful for long haul TCP */
>  #define NFSD_MAX_SLOTS_PER_SESSION     160
>  /* Maximum  session per slot cache size */
> -#define NFSD_SLOT_CACHE_SIZE		2048
> +#define NFSD_SLOT_CACHE_SIZE		2048UL
>  /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
>  #define NFSD_CACHE_SIZE_SLOTS_PER_SESSION	32
>  #define NFSD_MAX_MEM_PER_SESSION  \
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 2a21a7662e03..71b87190a4a6 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -575,9 +575,7 @@ struct nfsd4_sequence {
>  	u32			slotid;			/* request/response */
>  	u32			maxslots;		/* request/response */
>  	u32			cachethis;		/* request */
> -#if 0
>  	u32			target_maxslots;	/* response */
> -#endif /* not yet */
>  	u32			status_flags;		/* response */
>  };
>  
> -- 
> 2.46.0
> 

I've applied this to nfsd-next while we review, to enable broad
testing.


-- 
Chuck Lever

