Return-Path: <linux-nfs+bounces-7082-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D028199A608
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 16:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E001C2369D
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08A821A706;
	Fri, 11 Oct 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L7U7GfO7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NOaZgaFj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EAB21D2B9
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655867; cv=fail; b=HWCGmRFNSgm+ZmId5wiL1FfTP2neeaVF8/CxAxh63Y7LsnKaTAYDHcFJRM/w1U2KryTwDkTvqPLL/hytramlh8tXIjJZHgMIQSQLynp20bYSY1mOY9oRHus6aU7z58KtxP/eWef8aavGFcOcoMaYMHfamwLfv/nYtp/trbmNB+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655867; c=relaxed/simple;
	bh=Y6cwBEVpmoQkhihf/SAiBz8JgWaBLMH0yKx8HBL2q54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nEBGrMgnNzR3n4khUKoQObhqILutos2uIub1ijOGzo4h8FQ6QqFoWNyNy2TQ0y4Oetlt21xvVGKfCegttlorYhk52wX4vpmajuMF9/DpsC1+ggB1Wiok4/e8Zos58JNcizfzCU6VtqaWshw4lpf9Ay3aRRsoJj5H+76XOg38DYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L7U7GfO7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NOaZgaFj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCpa5S019539;
	Fri, 11 Oct 2024 14:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=NYdCE5FFl2/U8snIei
	appg5n74p5X+8+NqafQb8jqi8=; b=L7U7GfO7cJiQ8YQXCH0DdN8PUhH94Tsm+G
	5c/j/JcRr/jmysjeVgqu1d6L0cEHvdYyL3aRHidQSLqhSr07v5hA7d2lWfPDDNkZ
	jVE52ljkcty3+OjHSpiYVOhovpd5irO80qGXqZfy21hcyDW0+KnsfsAAcgDF0Upy
	773Ln/tKIyj6M0XMBS1ca4eqpKNWtu/bGNY3eTlg3fkN4wllJKObyCQanybKsO7+
	YrnwiXrvgGReAtl94YHOOyhTbk8cyrSFE+Y4E6eNjPd+gegJMwnawmDPp8Trq3+C
	9Z5gosNzGnRFRTXlaMz6ht9f7YCHTEHR45WU0WpG+y7qwh0o2Wpg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyvcyra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 14:10:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BE5djj027962;
	Fri, 11 Oct 2024 14:10:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwhnm6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 14:10:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7lB6IdM8aTcUNvzhp5GCZpa4fajOqIS0/0LlCE7o6E/3jWLRA0Svr0DFKAR9TU87dc9dEYMQ/TVOFrcSROtgateIDb/02xgSbMdmYZob09Ha5Kk02ZXGTkdc2FXMt6qTACzaz2zNuOYRqGeRAnnd+PRTHOJxrt0RK9rzQOyf6fzOsgY992O+djj588eGvSwtzgRj7cwlg7jbKkCE/2cBhTe6vBLI32ptZPoMXAgeIE+/5lztw2US2G2ZMJCB7XoxPZvnzj3HE+LDTf0ok6Jx1W8M3OarwNEBP6J6H/swph1+JnhKYd3iS+DfRXTKYxK8cXSDuhHK4a/Jxpj/rAwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYdCE5FFl2/U8snIeiappg5n74p5X+8+NqafQb8jqi8=;
 b=qdKfm4vNFztqcClx/5WXTt3TN+oOpEe/K1m15PGW+L6hTS5erl6sB3KRwaMMD5uLNocxXBz4j/5BktLLIOJrJy3ft96IxIdpe/vFjtnH6ktqh2rnl1OSpa+cFr4p1mH0+6VBovf1dcL2gwIuoIUFInM6/YcBnKZgxrYAqAFnPyvXEKwN13PchmH5NMpZ4EmMZoSZ1YIQ2RODYujhqofpO8Sr5m0COxlQTlsePt3EiRPTDumkX44fCI5NG7gpruFfxcAOLgLO5XVeltJOifxpH+CbMCDSKmLCzT+2PEjh4bnvmjafOiqs0dqI0vEuvqXWGE2CBqXUYH8NMlmfSrXkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYdCE5FFl2/U8snIeiappg5n74p5X+8+NqafQb8jqi8=;
 b=NOaZgaFj7qzzo8nU+1OCU5aB69L2SlC80TpB2t6mvBxFcB4tJkgVRY1if2cVSWcOyfIOdU+h0CjZPq5TbG592DgsjO+23+VJpH3valgi1D+kk8JkBBh7Q6Nl8OOC/tMKp6717VAr9udKWxb15xodFBXniGNu0MTh+DZqbkdhFRc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 11 Oct
 2024 14:10:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 14:10:51 +0000
Date: Fri, 11 Oct 2024 10:10:47 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: cel@kernel.org, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] NFSD: Replace use of NFSD_MAY_LOCK in nfsd4_lock()
Message-ID: <Zwkx54LAxJuuxTWv@tissot.1015granger.net>
References: <20241010153331.143845-2-cel@kernel.org>
 <172859365233.444407.16539980656364255099@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172859365233.444407.16539980656364255099@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:610:50::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4863:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7d279c-b829-459d-85bd-08dce9fe830f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rGCRNsjDUE9g+yMBwYY5Kd7OpSPThItxEfuogtHhNKk/hSQaq8h9Q7G9GVGm?=
 =?us-ascii?Q?pBdiJuK9QA/SL7d+qs4QlOKtDBVwjBj+AjGBYPkQ3YANLc9NK8I3RyPebVoR?=
 =?us-ascii?Q?2jbG0XtcX3gItJF1rYGAxwKfxPKZ4Qd6U7ljvu2yihbJwzSqoc2MyB8xI0nk?=
 =?us-ascii?Q?mhP/5vxNCOzzlywBiDm0ZOeda0re5tx4gus3DdiBRvyULXGDWQslo+ko65dI?=
 =?us-ascii?Q?Ch5n3CyqcRRLgxfOcb+pVabR3Wb4mnX7g4YvYc235Gj37qAT+xHUowhpW42o?=
 =?us-ascii?Q?3hnblWvpsESAsd0CpM05SaIipZBCVKYFoLJKWZeWA5LDgaxvks740G73oYiJ?=
 =?us-ascii?Q?1KIIGDZDnVpDsHwsHPiOcIsTOetnHtFLePTSaSQAkV1EmoKQFLaQf4zSP9oe?=
 =?us-ascii?Q?ZGQSkeh8yF9isYGlhElfHEL9CakdIIrs2iVbyD/8qzgrszrzA9L9k6XG4TmK?=
 =?us-ascii?Q?VuRuc96f+4DSW7ROlAVx8iOCJG0OyL2C7yQYKjqxvpgG8U5/65KlxjCLV60S?=
 =?us-ascii?Q?2yyfdAPiDPNhkIWl2PoIk1SfVi7jbelOL8P0nUBXjZqekyK76V28OpiLfDlb?=
 =?us-ascii?Q?KtAvvQqUxxihE8sF6PBgI1T3D0kVzroohUHHkBoWlWtosy2qGz2dTtc0XHCT?=
 =?us-ascii?Q?NLuM2aMqkdOm/EsCZ4vkeJcQ9ZMRXs8NAte+FLKsAl4trAmCYLWW+F6+iWvR?=
 =?us-ascii?Q?q5Stt5GdEO9GkPt1bw+Sj88FPBja56mH6dnT1y17EtCkP7GA5P3WBUDSOlrC?=
 =?us-ascii?Q?Ee0iEA9uhPG4sPMQj2A4Y+LG9eopg6/tAyPxMgRtshZhEGEDS3B24S56nm81?=
 =?us-ascii?Q?tIhWIoGfZIpjbq3839tPmPIaGvz7pKle3TJly7zH8sjyQcT/HLK9NOqEGddT?=
 =?us-ascii?Q?1wk3vMyCyNFjEL+XYgJ6AxdUwKoMufwav9uT0hVg+WzE9gAzm4QcqdwYfhC/?=
 =?us-ascii?Q?F8+gLF8QeH/A/PMje0Jjk6gutMnlkJP9khK0dCbIhCmkGccEC4/xYmq4uIL9?=
 =?us-ascii?Q?T543N9ZU4u8QXeifctWQDWfQ6GuPAx8OAkx2+8a31kKMyLk2t1oyr/DhAnZW?=
 =?us-ascii?Q?hpoKtGAxAj/w04Okx5RYaiQZ1RPceWdq6zaiAk46I/jj5C6vALdU2XgejcOC?=
 =?us-ascii?Q?VUf5836nu0S1TN6FYB1E4nt9BT56cV09RXJ/2rx4RTL8iS0/JrfTJNNnBMNT?=
 =?us-ascii?Q?1YfaNfNocnTdMRZbTp35/MgxYfnuJBH/Wjt8rOrCGKq9bqsesQIBHmjUMUEI?=
 =?us-ascii?Q?qNGk9gg6iA+fSGKWJ0ndFtXzVYq3LFv/Olm6n1kx+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OLy4ycNffJnBGY4TBQQY3MnAQXnh8+1O13xU7ky+PyzaoV/Qf/Xe3IFhGO0+?=
 =?us-ascii?Q?/YPhOKWxmKDT3TFKblml98soJOX2nO9Gbjabh4CqVj/gI9ILkd5gyfmTvHTv?=
 =?us-ascii?Q?2c7HW0i01cJlL9C0lEQRSMAC/VcbeLPlUYgGUxvoaaRENhdbUm43DfZ2sKt9?=
 =?us-ascii?Q?MNh5RprxRWqpZ88JdOUOW35sJER9GPVOB7qbI5ZAG6u+ABCJ3Tcm5+G/caqK?=
 =?us-ascii?Q?YbyBBACgT/e55LOGZhDtZWWcA0fMkcDI0hmvSoe+2lmoHuDvV+WqfKvI5E3C?=
 =?us-ascii?Q?4iPX4qThJCkNNt4asehj+9Zh+8uRwLbeiIWvqv0rEOS4WnxtUsI0DPjS+3Ir?=
 =?us-ascii?Q?4fddcu+k2c67+yBFQzJk1ZbhZUW3PlqrYqC/+SarzPME3qGRiku+8a82KTJW?=
 =?us-ascii?Q?XQJNdEl21dl9PVBfi0Vbxx/0+s09Ug1PBOkz8ONguLGL+bZ8LeNgEsFleKWd?=
 =?us-ascii?Q?U0PouUHgotbI5HzHRFGr1iHzExKmUlQ4EKYJvFr05+CiNDFIE4yGt14kqatw?=
 =?us-ascii?Q?pxbXzFoUzlHtoHO+8hkvRAzQWMcMZlDJGHKv2rMyWJ5gmdbboSt/9SVYOXh0?=
 =?us-ascii?Q?hnWmFsIuOY1kuaedWaoSMO42P5UySgd05s+ByKl+Da4OnvBYCaiSNq++Rwuq?=
 =?us-ascii?Q?8GE9mq8QLbj/TJ9qgU/cP8ayJgyz8JG9vk+FoR6q6inDO1d1ns/t0ihpFpq9?=
 =?us-ascii?Q?xXeaR/aveaPWsIuHVoZGhDgzn2rmFGljAO8zPfMOtUICPYbu6K8DagtGB/Re?=
 =?us-ascii?Q?vpoLNyZGx+P+PYgniqQ+QISaGVzez43SK0hxHOk/phyhtMQQ9QcBKajWfIvN?=
 =?us-ascii?Q?cGu99pmnQaGAAMCHvNnLS8VgTkvyMiskZMlIlCkv2UnpqxnhUCg/tf6Xe7Ew?=
 =?us-ascii?Q?SMUCf0qwvd0TfYN2HiKd3PIqQaWmBvNIfnWVz5/OSCOqJtNYwecxZ8/L8+t4?=
 =?us-ascii?Q?KPiqZuR6KCyIXv072OCZ/irve2IRN9czpa50hdDfDd/Mo1ipy0fqRnhRk1lq?=
 =?us-ascii?Q?tza5dDBOWNuYojeghj9HugGFblMt+GGxu9YEp/HNygW7PJVnhLNJE+NoeiuA?=
 =?us-ascii?Q?yMCm4MKnTwOC7cbsqKLdfbgJqiV9J3oQWhRvrG+c0Ql2s3I2gLW8AhygP1Kr?=
 =?us-ascii?Q?TWMRb4h/Fc1xCBbq9+b60ox/bmy3CwBlwQRoWnG4r1SqNof5tC7AI7NYAo+t?=
 =?us-ascii?Q?2Kzz+xt7ZAKqKyfPiwTrUlPKXrAZKoaIHzkAdr465lGs0dnhnD2JGZ3fsE5h?=
 =?us-ascii?Q?6cDmP0gfWJgqfTWAukeOxUUVnJ/Q1HHGoPPe0z3Sbp+cpYzQXVdc8+VxCiXd?=
 =?us-ascii?Q?zlGaXL+YuMV7b57cy89Gb88vaYY1NlFIXfj7FwgU6C9XcR1mWJ6sSEG5ZgL+?=
 =?us-ascii?Q?/C/ZMug29XVmJa4CN+wpy78uS1q9mpZNGRFwiGCIhkpgY6ESZk6lxkrFfK5b?=
 =?us-ascii?Q?fvPknPO9H0aOtCGsCeQX29BerBLvgQIEPdS9BBJITnxrDVT0dW/zViAcgOmt?=
 =?us-ascii?Q?CI91xZ9OqCXTPzf/o/QWqgKNOEOwj654hco0oH/nmPeApssaXTGHUPrGcA3d?=
 =?us-ascii?Q?xnOPyP8AQgGofzwCMeeRoXTRs9kCu93OzqvCoVgz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5BRN3OJof6wHqpio5vul0GRNawS8iiEJGsIpvJzbVGoiA1TppV9QENRW3AQ5hJJZICXuiq1Fa3ujMLEqrqiIIn2NXUcIHBPcfs67vHWzvMwypYw0BcDtIMphyW2kg9qLQpSgME8igHtOd48gvfnjVfeMPqnCpnidCRkmxg+r8HzJNQ2a4i26zwAmN01hO00vFfMyVOTBdbAwwVP5rklcEBeOX3Dx1uW1YMC1FC6Iu6M5AMCd99XYnfn3comKi51kIL0hWZljczQlEtvZLUahUaI0dDySzaz2noCO4CbP81wpdHV6TOVcDy6fKXzucoldmNJZvX/FBiWgMeRixkxdVr0f7Jy7YICCAuCxbl9IkU39bydlALWIoH9WTkP73Mve0ogzXuIxhBf/p/CmeVAOPb3/y+bYdRiPkw9C/LDIjG69Mgy9IVr41SGsi7t6tLmzY02+tM5hH2v668Oz4F/bBG6lDhBKzeNlB0c7UGcZv5QCzkSSXhI22ijr6J6glTn3Z0+w4JsOskX3Vee+wZtIKyL9Z+IzSfFB83XPDwg9kS42XP5YZKkdmaFbPoud3X79f090XNRroDG5SFIDEAwf7uafAzU6mQvhuAOYtvocQ9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7d279c-b829-459d-85bd-08dce9fe830f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:10:51.1224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sh5UKWdYZHvgazr2vRyMDHRNwg715Sv04ID1tXC98gx+uS9FCJCiL2/X9L5qcWe3WiMVIAHGy+6wDa3nklX8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_11,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410110097
X-Proofpoint-GUID: LPa-62wU3Qkri9x0i_eHLRjQzLqGco7F
X-Proofpoint-ORIG-GUID: LPa-62wU3Qkri9x0i_eHLRjQzLqGco7F

On Fri, Oct 11, 2024 at 07:54:12AM +1100, NeilBrown wrote:
> On Fri, 11 Oct 2024, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > NFSv4 LOCK operations should not avoid the set of authorization
> > checks that apply to all other NFSv4 operations. Also, the
> > "no_auth_nlm" export option should apply only to NLM LOCK requests.
> > It's not necessary or sensible to apply it to NFSv4 LOCK operations.
> > 
> > The replacement MAY bit mask,
> > "NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE", comes from the access
> > bits that are set in nfsd_permission() when the caller has set
> > NFSD_MAY_LOCK.
> > 
> > Reported-by: NeilBrown <neilb@suse.de>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfs4state.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 9c2b1d251ab3..3f2c11414390 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -7967,11 +7967,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >  	if (check_lock_length(lock->lk_offset, lock->lk_length))
> >  		 return nfserr_inval;
> >  
> > -	if ((status = fh_verify(rqstp, &cstate->current_fh,
> > -				S_IFREG, NFSD_MAY_LOCK))) {
> > -		dprintk("NFSD: nfsd4_lock: permission denied!\n");
> > +	status = fh_verify(rqstp, &cstate->current_fh, S_IFREG,
> > +			   NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE);
> > +	if (status != nfs_ok)
> >  		return status;
> > -	}
> 
> Reviewed-by: NeilBrown <neilb@suse.de>
> 
> though I think we want a follow-on patch which uses NFSD_MAY_WRITE for
> write locks for consistency with check_fmode_for_setlk().

I think this patch might introduce a behavior regression, then.
Instead of a follow-on, I need a v2 of this patch.


> And I'm wondering about NFSD_MAY_OWNER_OVERRIDE ...  that is really an
> NFSv3 thing.  For NFSv4 we should be checking permission at "open" time,
> recording that in the state (both of which we do) and then performing
> permission checks against the state rather than against the inode.
> But that is a whole different can of worms.

I see several sites in NFSv4 land that assert OWNER_OVERRIDE. But
point taken on taking the permissions from the state ID instead of
using a fixed mask.


> Thanks,
> NeilBrown
> 
> 
> >  	sb = cstate->current_fh.fh_dentry->d_sb;
> >  
> >  	if (lock->lk_is_new) {
> > -- 
> > 2.46.2
> > 
> > 
> 

-- 
Chuck Lever

