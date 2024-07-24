Return-Path: <linux-nfs+bounces-5041-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5191793B7A2
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 21:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D8C282311
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 19:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760FB16B73E;
	Wed, 24 Jul 2024 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ITu6ZO5Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0UbE6ifA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C54D52F6F
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721849836; cv=fail; b=RRMNchurXE6lXen6EPCCFAhB8PL07IioROMQ2yEVgDRovSds4numVObU4qJKzHfsvuG0wAbm3SvR3QJ9B4bTFvvEVeBzlAObB5/OUAkcNlpaoDSt3x05jf0y96OW0mYyav9a7+CzwLL/8J5kioDvnTA/GBH2jfhrzD4XutafvRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721849836; c=relaxed/simple;
	bh=B8TchjH6MBc3ynK1LYBU292OPGLxTm8Q+zqKwTcVQeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uvd0GT4EGxA7XuKWxnsIvQbs99sdBBn4e2DAaSdGjy8uGrW1TzQyLfxu4MLctIbkbE/s9ly6vcTVKZKqeGMqaxuYz3ywcue5VXwmYn4TJaUioca8HSy9lu6gH84tIATWSxMImNXguOjjtCrf2zTQIaEvvjnoBHQ86buYzZc87zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ITu6ZO5Z; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0UbE6ifA reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OFXW4G026925;
	Wed, 24 Jul 2024 19:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=jV0RY3x7+nRFzt3HAHFBuTqrwyM90iIxrLtxmQpk9pM=; b=
	ITu6ZO5ZGLz4YVtkfjAn903APG6C/Q9qq17rEnEwUDIlcGylEciqecQ0KdQIAfTy
	4VK9QM0owLk/YlajcgDujQ+YEm8xOiRpZLnz/e780jIiKW5KGIDyOOJ+NUQTZc0m
	v9XMbnxGZZooRYiRonvGU0kb0Z78bhSOh9flHiEG4xKzroLg3X5YyoqpuDQZ5B8d
	nT09pwZwa3FXJ2Qm8+4ssfiqhBcAGLLNPokdXSHelJRihn+bAlURRJ2Mqjmjceq7
	dJk4H7KM/SEYajo+iK4fM24VU6ksGSY/qNCabTrsEkUHIJJhUp5SizEhyGdRPPIY
	mwDQrwcbg14jlNmnueJs9Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0htcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 19:37:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46OIO8wd040109;
	Wed, 24 Jul 2024 19:37:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26pbnqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 19:37:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9XylJHWJpsQPSJGc2/sMQzBr956fA4jspKYkyX67GP6p6HEV9o6PDYQX0SX9UeHzw+WyFp3DGLjy8JMnWX/E8mCAC596AX3km+/N0trjwAdOlLYvfdfHDHt2aahvNXATsZ//mC476ymm9KNNwbT6eM+r6M70Tn82Jvr4+uTfLIHnHqHHaJ5KK4+HdV3ejx0pj9vFJ4aIrysrHrFFV4LY6YB1qQSo0eTMN5XBSlXeAsN1WOIkmlPRbQS3OnTMToDxw9axkFnPOMwURfOwXpIGcVDk7UQ90B9rnH8VO08klPftmb6d/hpiwxLjbg1MOSl03HwCZOoPm4qXBuB53Es6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEANHYYZZGBJ7ql1PX2QzoxHY3080flIx7crnR6gkt8=;
 b=FnBM6gn8w52L62k/r/6meudMYh2fBf7FdyjO2+eqsalPnSaaiDLaaelB0MglS6oYnyFXqFnN92Mffc3HGUdfQkH213vRvMwFqmzh/kMRpyer1TsSVMBd6Jn8/SVxpDL2QIXaVZV0hQB4MVbmcLG7OIsJtIf1gmk+/HIykQECUARJpy6lS+iCfLHwfl/xtCioXI40jtmsTkBMUy5Gh5cWp+BR9aa7YR5lRmTsZWSk3w6KHW2KQ6o58RaxhxlOZ8AvmdQpVQKuEcAO8M0tOBPer6DEAH4PQvbRdvK9n8XMkixDzBkI6Ts2vD8mlmblwqxz2O3S2ekIKEVfeLImGw2MOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEANHYYZZGBJ7ql1PX2QzoxHY3080flIx7crnR6gkt8=;
 b=0UbE6ifAPYnnWyW1fICP+3wknDkFUgDloKyzv/szhOjPOIZkJG3Ckj/YePagnBYa/fZg+w8zOWatBZYXOXqlFsmVW/t3gibuEAFdLIjkRVXchx97S6+pdDweeOKicns5UI5CgelLF3zGtAGlp58fqxYr/Jgxlme0EhIH1qJeAjg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7824.namprd10.prod.outlook.com (2603:10b6:408:1e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Wed, 24 Jul
 2024 19:37:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 19:37:00 +0000
Date: Wed, 24 Jul 2024 15:36:56 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Steve Dickson <steved@redhat.com>
Subject: Re: [PATCH 05/14] sunrpc: change sp_nrthreads from atomic_t to
 unsigned int.
Message-ID: <ZqFX2ECVBuQ+Xy3+@tissot.1015granger.net>
References: <>
 <cf8d0e7e1ddaa4d8e1923be8274ff0679713e471.camel@kernel.org>
 <172109362034.15471.7453960747189036602@noble.neil.brown.name>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172109362034.15471.7453960747189036602@noble.neil.brown.name>
X-ClientProxiedBy: CH5PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV8PR10MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 5818b7f6-7a78-415c-1754-08dcac17fcb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?+3oTACXGAedWWVR2eqd6JkeAK/vvd1NGL4RnqkY6KEMWZkKYTooKIrewWA?=
 =?iso-8859-1?Q?KFxzOTgK6yyVmBEpyBtNV+bPiRN2Xh/cGv72Hu354vjrDAHm0Oise2sGDM?=
 =?iso-8859-1?Q?9rEce7pMqmPdH3Bt38vV4djWQEqzVFnRKexoCC7QlVh8Id4t1BiCCUrUVF?=
 =?iso-8859-1?Q?cPgF8o37OIVGbAQKTvyc0ehCxm8/3em4mXBwPxoXX+XF5vwyhfkZJRM0ob?=
 =?iso-8859-1?Q?jPLYZEq3ZFZ5iYdX7nGgIQHVG/IRgAE466UwqgX0jH/SDR9c+DSsLxZr8b?=
 =?iso-8859-1?Q?sb8/aNerrsBz/iQTRQNOp4LPeKBjquArVcjGZ22CzjE0ljQSY50gZ9qEQ2?=
 =?iso-8859-1?Q?kOjpDCdvKaY9YRB2QDFtY7iW+WQDrSOvlaJi5XUG2ySHjetr8YJ5Xz/gQK?=
 =?iso-8859-1?Q?3tjcargne8EswHWY4L5wNIZ5rNhQnH4Vep5y9m3TplCLcqn5BSBU/CFgaF?=
 =?iso-8859-1?Q?74FAiowBNUkKMk1uoozX+E2g6KTp2JnNHhW7O9mvpZK9GeQd19q0UugRiU?=
 =?iso-8859-1?Q?I1jy9gmMai2HcxSOX+iI+tchp5gPmVx5GhQU37e047xmIxRT4A3Q2PhqY1?=
 =?iso-8859-1?Q?+hIiUmShU08tmmb2ldGwLbd5n/7QHvNmiq0ISKmcKnFzD2+pE9nAsr83lD?=
 =?iso-8859-1?Q?sA2QX2Rp2Y2SB3/7+tm+irZCJlNPjeNsLiC0CLNbglga52HCWUmWMiQgC+?=
 =?iso-8859-1?Q?Mr5tfehD06lX5HMPXNenavrn+bjfv3ugB59199ywWPHM8kgadAKV9tazGM?=
 =?iso-8859-1?Q?/5nBjG1UptIvyoo4akIkV19gnkW6N0o3BtkUqEWBKkfJDSu/pbiCT6W8u8?=
 =?iso-8859-1?Q?kUx8EBNB59Nk8omg4vj19b5KBmn+bGY0+mmXASIodHYHKJW9LQd13KjbrX?=
 =?iso-8859-1?Q?3gli4T/YNQLVMZKdVAdd1/NARC2K1Knz1xfsCV92869I67RC6pyaS8/b05?=
 =?iso-8859-1?Q?2iFCKNtJYQ6i7+bRAOwsC37xdqZ9QRQ4P5lBvUCibmILaCYqWYtDuQmpx6?=
 =?iso-8859-1?Q?JHY1ZVe9wmi+9IjNofZnOQLORmAqWF7Z2aLXTn+Zmz322bQcSqW6Mj778P?=
 =?iso-8859-1?Q?0Wb4EFi4iwdfhw8SLcvaFUl8O/qGbJEfG2InWS/CdL1QNdNuCasiYjPXO7?=
 =?iso-8859-1?Q?XRK4eM1L6bBa+OuZWISmupf8qWPhp9HDvfaMFI3ZpQa30wWgKQkzhuIKg0?=
 =?iso-8859-1?Q?G+n1WmnhkYhpVpSzuNg1ZZqVBFxdq+ZVb9dUqS8dZbsFABSPj6Zid60rs1?=
 =?iso-8859-1?Q?RzHwY6xMDSz6UCPocQGKsdXGE0JePWmnJ37k6vWnLS1ahc4OVZhGHT8P1v?=
 =?iso-8859-1?Q?O0Q5bKfwkNkjU3D8htU/QsWjGUWqkBdvNQn+JxyCECutn//hE2LNJu7leO?=
 =?iso-8859-1?Q?9zacbpNJ4a8VjBz2JATjWFbLVbStjYVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?EqqC7XXp1Z/JBk8pNWI4Z7PGxuDAfzCcf4ty67IBvGk0g5WWlukGdSKE6W?=
 =?iso-8859-1?Q?GDFHN5TsWKR6ief76COuzQb1G8DYIcyk6hX4X5BzllVI0/v4Vgfs8SjZRQ?=
 =?iso-8859-1?Q?uDI+q/ej6Rl0A19TO4yn7mBtIyUFtZus+eWvefXVN/H7c0paSQ6lfkm6qr?=
 =?iso-8859-1?Q?kr1b47mPneHWqwFL1CGSmAR0vasaQoE8gp5N6iKqyhuzNPR2LxOHJDAhjR?=
 =?iso-8859-1?Q?jfkzlhS33pUsqNBMXcuoaJGAmEG2a66PhL6S01W5x1pJ9GTnbGKWjN5oNJ?=
 =?iso-8859-1?Q?NUgXeci5QDL3ZLdGQgJG9myOZ4oQbFZIibeiyc8f8mRdk3tdup/DJ4ASH1?=
 =?iso-8859-1?Q?Egc/rPCqcAa7Zk8Sz3/hEr1BWjBwieZh3mU+0yDeQVWgsRLFK1gyoe4ou4?=
 =?iso-8859-1?Q?EAHgLP5nMEn0/WH+VPuCBAfm7JVjAYMmJcOW/8uOiRxfhK4kwHxwvNQ+K4?=
 =?iso-8859-1?Q?LNgaV8Oxm49oLzcwNRe9DavcKpQs+ZiteierfWkSJIXJL+KH0Z7kmxyUud?=
 =?iso-8859-1?Q?p0FJAGo3tIaPDL3EpAJ9Stzl4eekOobY4+VjxSJ8/f3ZZcRoNcL0tcKMXI?=
 =?iso-8859-1?Q?3ieOHp2bEUUagPizVlfZ+Bh1W4Zcp51Wo3A4RMR/uTo/RFJpjN6Yyiy+2c?=
 =?iso-8859-1?Q?kwQj3PlCT1W9saIiNB6AbrSSobtKyKx6fbjFT2d77y4tWhL1QNqaAUEX3u?=
 =?iso-8859-1?Q?N6a7vtMypnJofB/kt35xHJYKBAU8+BP3n/KWzoMyLazPsccV5yFmtxmAX9?=
 =?iso-8859-1?Q?Kq74aa8tmn5uJZ22jLIVfMnC4HkdyPMXPTb/WmNAvgi9mlGIxDFoi3sf7K?=
 =?iso-8859-1?Q?qOd7qD+unX4A7qaqBxEdVJLpAlzQ0B7fjZ0MC7P4n9doowxHL9BLOISqgt?=
 =?iso-8859-1?Q?gIy6Yvf+UBFUFF4gAxnZW6WY3Tajsz1FlwtDtkNCypHjy1RcCDiX0piX4z?=
 =?iso-8859-1?Q?qbdXpFdKwb9XH4LxLYaHYDzgMHDdtg9bt3NOF+ZGGlhEjyjnpEsVgHo8Ku?=
 =?iso-8859-1?Q?+bTZDBMN7ZtKsSXk5SzA4al7a9iNcNfWTG8ILJVUijfggATb6qA/eb9lAl?=
 =?iso-8859-1?Q?vVR4ocorKJThQ0P/6FV5Es/Yqjk2OgmuGGf0cu2Gvt1PTHnyqoA9GD8ZG7?=
 =?iso-8859-1?Q?R0Tna0o9hN8FMmBTJo9Fq6j/n76t6/BtNC/Lr9g5QN+KKrJlvPmVb1x7aS?=
 =?iso-8859-1?Q?L2yPwjfJP0Kv6D45Ka1z2RYjLfRVnXutByMEkMDxKBxgv/UG2bDEkXobOx?=
 =?iso-8859-1?Q?8K2vuT7jsHXBq72QGG5FIiRL9BikrpOMyRs7rGpxOHiuuD5DgEar5w803L?=
 =?iso-8859-1?Q?30gIaMtC+LcQLKGcyEgP61+VbkqPLVaSlXr7PiF0nu8LminowPrETDmfKk?=
 =?iso-8859-1?Q?ZFadpLcSAm4EH3D8Hx6bEhxNqFMU/D4QLrlRaAxU3jDK2fwtujH3S5x8QW?=
 =?iso-8859-1?Q?/ctbhN2/9jsAy5FahPQ4MxCtKPXSf7cm7AYt6CwPNH0q6PlckeD+RfRtg5?=
 =?iso-8859-1?Q?X2ocBzIjTnanS8GzlcglTBzjXPJ2iHgnieP7hf6dqZSKWZo8521U14Z/+q?=
 =?iso-8859-1?Q?XsZU9x/9/wTEoGXC0OpY6Y3TQESCICT9PHao7N4scCZYi2EcggOwx0Fz1x?=
 =?iso-8859-1?Q?IuP9le0D9xZsYLamkkftErC2s8vEkqpDEZxWXDmBJ5O2x+noO02ekVrg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aPJoSvPv6R9gMkXBZMNUJl8YIZNAwC5w5uq/N8+CmfcEY+LkjC39W/+z6f5toLpf0DLN5h4nD70gQxUsSAUrmh3jwuZuZ79K9feJ543W3k7G0LT03BxJT+3ikpbJvUJKfrk+kJluNwDX2XiMBbfPGo1FMdinskEZONRg7rLDfxoZBIt0tGQyDb7S98yKovQtGQ9P+Dsikm32QA8jvsZEL/6IdjhzfewqRiNpwf8f4VC4cGI6vnQHMs95vL4ioQlIagWnvfWMSdsyg268ItY3ky5YQf0QgLsJUPi8KJvauUEBW262qQeRKWYZk8tRjBkB9BNTqzl2/lgR+t5GXQiKdID4p35pC+8v+qLy4FNBNfn3Ei7I8AnW1DR1ZDbLvS+qF/nuOaVsGnY6JDTM15qlOrHRACFzyu8J8C8tZ3plxk3zHaX2ZQxL91x/CFQpXE7jvtKy+bUs6WUJpwrVYpTY6sPOX6SercsYeaG3Yy3rPRJRxI97rJWySLVhzElVFrwyUgq5SPLqHe0ZHqyQdKzVPj+jDOD9LZyZGMJGnz2oEZaLoVpdJwqpToIcW65Qgz3bx/TChG5OJiiUDIheAcGdASAUFEa5r0vWmASQ8a6juJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5818b7f6-7a78-415c-1754-08dcac17fcb7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 19:37:00.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHip5oVMxEcXRVefWNK0zgQN0labX5obnuGU7shiPhfGRqgnRPBpmkGERPWbsahgVKGk1UBFwiostWEkd8rWbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_21,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=958 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240140
X-Proofpoint-GUID: b7uN5JqEmGAH4tWpigYCiol2-Cdfc_6U
X-Proofpoint-ORIG-GUID: b7uN5JqEmGAH4tWpigYCiol2-Cdfc_6U

On Tue, Jul 16, 2024 at 11:33:40AM +1000, NeilBrown wrote:
> On Tue, 16 Jul 2024, Jeff Layton wrote:
> > On Mon, 2024-07-15 at 17:14 +1000, NeilBrown wrote:
> > > sp_nrthreads is only ever accessed under the service mutex
> > >   nlmsvc_mutex nfs_callback_mutex nfsd_mutex
> > > so these is no need for it to be an atomic_t.
> > > 
> > > The fact that all code using it is single-threaded means that we can
> > > simplify svc_pool_victim and remove the temporary elevation of
> > > sp_nrthreads.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/nfsctl.c           |  2 +-
> > >  fs/nfsd/nfssvc.c           |  2 +-
> > >  include/linux/sunrpc/svc.h |  4 ++--
> > >  net/sunrpc/svc.c           | 31 +++++++++++--------------------
> > >  4 files changed, 15 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 5b0f2e0d7ccf..d85b6d1fa31f 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -1769,7 +1769,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
> > >  			struct svc_pool *sp = &nn->nfsd_serv->sv_pools[i];
> > >  
> > >  			err = nla_put_u32(skb, NFSD_A_SERVER_THREADS,
> > > -					  atomic_read(&sp->sp_nrthreads));
> > > +					  sp->sp_nrthreads);
> > >  			if (err)
> > >  				goto err_unlock;
> > >  		}
> > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > index 4438cdcd4873..7377422a34df 100644
> > > --- a/fs/nfsd/nfssvc.c
> > > +++ b/fs/nfsd/nfssvc.c
> > > @@ -641,7 +641,7 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
> > >  
> > >  	if (serv)
> > >  		for (i = 0; i < serv->sv_nrpools && i < n; i++)
> > > -			nthreads[i] = atomic_read(&serv->sv_pools[i].sp_nrthreads);
> > > +			nthreads[i] = serv->sv_pools[i].sp_nrthreads;
> > >  	return 0;
> > >  }
> > >  
> > > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > > index e4fa25fafa97..99e9345d829e 100644
> > > --- a/include/linux/sunrpc/svc.h
> > > +++ b/include/linux/sunrpc/svc.h
> > > @@ -33,9 +33,9 @@
> > >   * node traffic on multi-node NUMA NFS servers.
> > >   */
> > >  struct svc_pool {
> > > -	unsigned int		sp_id;	    	/* pool id; also node id on NUMA */
> > > +	unsigned int		sp_id;		/* pool id; also node id on NUMA */
> > >  	struct lwq		sp_xprts;	/* pending transports */
> > > -	atomic_t		sp_nrthreads;	/* # of threads in pool */
> > > +	unsigned int		sp_nrthreads;	/* # of threads in pool */
> > >  	struct list_head	sp_all_threads;	/* all server threads */
> > >  	struct llist_head	sp_idle_threads; /* idle server threads */
> > >  
> > > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > > index 072ad115ae3d..0d8588bc693c 100644
> > > --- a/net/sunrpc/svc.c
> > > +++ b/net/sunrpc/svc.c
> > > @@ -725,7 +725,7 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
> > >  	serv->sv_nrthreads += 1;
> > >  	spin_unlock_bh(&serv->sv_lock);
> > >  
> > > -	atomic_inc(&pool->sp_nrthreads);
> > > +	pool->sp_nrthreads += 1;
> > >  
> > >  	/* Protected by whatever lock the service uses when calling
> > >  	 * svc_set_num_threads()
> > > @@ -780,31 +780,22 @@ svc_pool_victim(struct svc_serv *serv, struct svc_pool *target_pool,
> > >  	struct svc_pool *pool;
> > >  	unsigned int i;
> > >  
> > > -retry:
> > >  	pool = target_pool;
> > >  
> > > -	if (pool != NULL) {
> > > -		if (atomic_inc_not_zero(&pool->sp_nrthreads))
> > > -			goto found_pool;
> > > -		return NULL;
> > > -	} else {
> > > +	if (!pool) {
> > >  		for (i = 0; i < serv->sv_nrpools; i++) {
> > >  			pool = &serv->sv_pools[--(*state) % serv->sv_nrpools];
> > > -			if (atomic_inc_not_zero(&pool->sp_nrthreads))
> > > -				goto found_pool;
> > > +			if (pool->sp_nrthreads)
> > > +				break;
> > >  		}
> > > -		return NULL;
> > >  	}
> > >  
> > > -found_pool:
> > > -	set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> > > -	set_bit(SP_NEED_VICTIM, &pool->sp_flags);
> > > -	if (!atomic_dec_and_test(&pool->sp_nrthreads))
> > > +	if (pool && pool->sp_nrthreads) {
> > > +		set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> > > +		set_bit(SP_NEED_VICTIM, &pool->sp_flags);
> > >  		return pool;
> > > -	/* Nothing left in this pool any more */
> > > -	clear_bit(SP_NEED_VICTIM, &pool->sp_flags);
> > > -	clear_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> > > -	goto retry;
> > > +	}
> > > +	return NULL;
> > >  }
> > >  
> > >  static int
> > > @@ -883,7 +874,7 @@ svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
> > >  	if (!pool)
> > >  		nrservs -= serv->sv_nrthreads;
> > >  	else
> > > -		nrservs -= atomic_read(&pool->sp_nrthreads);
> > > +		nrservs -= pool->sp_nrthreads;
> > >  
> > >  	if (nrservs > 0)
> > >  		return svc_start_kthreads(serv, pool, nrservs);
> > > @@ -953,7 +944,7 @@ svc_exit_thread(struct svc_rqst *rqstp)
> > >  
> > >  	list_del_rcu(&rqstp->rq_all);
> > >  
> > > -	atomic_dec(&pool->sp_nrthreads);
> > > +	pool->sp_nrthreads -= 1;
> > >  
> > >  	spin_lock_bh(&serv->sv_lock);
> > >  	serv->sv_nrthreads -= 1;
> > 
> > I don't think svc_exit_thread is called with the nfsd_mutex held, so if
> > several threads were exiting at the same time, they could race here.
> 
> This is subtle and deserves explanation in the commit.

Hi Neil, assuming you mean "commit message" here, are you planning
to resend 5/14 with this update?


> svc_exit_thread() is called in a thread *after* svc_thread_should_stop()
> has returned true.  That means RQ_VICTIM is set and most likely
> SP_NEED_VICTIM was set
> 
> SP_NEED_VICTIM is set in svc_pool_victim() which is called from
> svc_stop_kthreads() which requires that the mutex is held.
> svc_stop_kthreads() waits for SP_VICTIM_REMAINS to be cleared which is
> the last thing that svc_exit_thread() does.
> So when svc_exit_thread() is called, the mutex is held by some other
> thread that is calling svc_set_num_threads().
> 
> This is also why the list_del_rcu() in svc_exit_thread() is safe.
> 
> The case there svc_exit_thread() is called but SP_NEED_VICTIM wasn't set
> (only RQ_VICTIM) is in the ETIMEDOUT case of nfsd(), in which case
> nfsd() ensures that the mutex is held.
> 
> This was why
>  [PATCH 07/14] Change unshare_fs_struct() to never fail.
> was needed.  If that fails in the current code, svc_exit_thread() can be
> called without the mutex - which is already a theoretical problem for
> the list_del_rcu().
> 
> Thanks,
> NeilBrown

-- 
Chuck Lever

