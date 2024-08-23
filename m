Return-Path: <linux-nfs+bounces-5655-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5CE95D5F5
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 21:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715A81C235A4
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 19:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01D718A6A9;
	Fri, 23 Aug 2024 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aHNLw1Ug";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a/JwT6oE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294C13A265
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724440548; cv=fail; b=kELEq48apQKgzCDokhYyShF+qWRH5Cr0eSqb8S8PvPWlEtb67uW3C3qDiGtY4rhQ28KLuRLDJ2L4E/A1JI1b+t5WQHLS+mIrycM/kn6rvyWU7/rFK9Lb20cSGjWBbACjDF5xM+O5q/UPN7YAcTk/gRia6zJy9kb49HI4vnqA27E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724440548; c=relaxed/simple;
	bh=cmt5h3bTvqKT2uV/w+7xLliYKLzG8xdeI06DOJ09jHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CXJzUJXltrifgemTkA7bR5jJHPOZBj8TLUNEJcj143tyxgxS54bdUQUcuSQMutjQ9XdP3EW7SigvbYJRsLVupibjsQ/UQcTDYThll7BDQkesRIIEyNP//soKaCo4zVI9pgefmTVWc5wpbL35AI5HNGaXN3WBTP+ga7sbVu5gUdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aHNLw1Ug; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a/JwT6oE reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NH0V5J010835;
	Fri, 23 Aug 2024 19:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=4qOYOQAvk545LfmcryWILx6TcygMecU2/7GQDVUFu7U=; b=
	aHNLw1UggX8bCOUNsVxmJ7wyQPzzqRjZ8cyKSOQkriAg29kl6A2fRepTOdPtLQ/F
	RMyOhdrGdLZGy+XoHNywXwgmtYArVpFWif6zToDgymecYHA/QFc0JaSjQdZfht6y
	T5F2cLmou7CpgwncZzZPL088gqepYgAulRhpSugYuQAASi7hAmEyuwNzaNXPWK/0
	NGkdMmejTJabP7HDnzS12EK4QBwPYgc1xczJQyO3qpDETatlZwKKkhFyeej5o5ec
	am35vpUaeCthzNN6MU/JHGandw1h9xofzR0JXgZsNXojbpYiKUSAT5xYPFmuumKQ
	ubHSqWjrgj/FEHp1qThVCA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4v54bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 19:15:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NJ4dkO020515;
	Fri, 23 Aug 2024 19:15:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41708tgcqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 19:15:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZHelUMp5Rm0wp5qPM+uHZne2lLy0cbIT01NUD3YJGuAF642I1/d8E3Iqz/CQPwPsqeV8MfoJ2IM2+0WzdsMMdCnRe9BsgLpqJlzE6JKv27Z8ywiZbXc+j8CQUaK4hbMLHw64WSDfoVly2ki3n9/rlEzJuzTugzdDQzXuCs83GjapRjibHv6opHd8uStApQKP9zyH4fAMgXqOWKhjI5SPzgNQOhGu7oZbgP6RhJ2C6o4q+CIYHlJu1NGMeIPW0RnaKT5DCS5U8x3h40a0xCPMBa+eU2QQGdMmGauPbnwklNFmIjIS06uFBiXU2GaSbS9wwO5WPjgd11OdkBU4taehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQQxFNoesA1lvDxlWynRwlXWqGgsOIlXmLcKiQMW6ZY=;
 b=e1+nEAcLuTxiL/6/P++57xflqBbZu4OQGnLBk6U8fDTWcRR7s1pp/8sifBhejFwFnfExAykBBArHo/eD+6DStXUWKNOm0YQMRjYxPRnMjXlU+dymGT8W803rpIET5j7TS/fwVEqZnFVKy8VAySyrQse5fzOr19FkhCUTGwUR3ojOAbl7SQ1atR5Yurg6GtJiCwIys7s7/sfDw3/aqC//B3q77acfFhDxgt0yMvN8Jz2sb/9+pEPu4av9Um3LHK7TyHKBhJvdtKQqGhR8BJqKqC7LtD+KCqxnk6o6yvbHK8LibLl3tPb1Mm/zXwLD9x5z3YHwmDnZo+WY0MTjEsGrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQQxFNoesA1lvDxlWynRwlXWqGgsOIlXmLcKiQMW6ZY=;
 b=a/JwT6oEmSFBg5rbXjSNEr2xZ723mj4WwVfgNn7HoerXdy5fxNMgK6uU9kY/RL3fW1avgBUYRy64rE9JzGtVswxvn14zdZ2KGQQ4dxhCX4ib1e7ejsjCM0tEEaPSKud6V/ha1g+tZngrxATxQNMHo6J428gNKGFf+ZKZZEA2iqw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6585.namprd10.prod.outlook.com (2603:10b6:930:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Fri, 23 Aug
 2024 19:15:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.006; Fri, 23 Aug 2024
 19:15:08 +0000
Date: Fri, 23 Aug 2024 15:15:04 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: Donald Buczek <buczek@molgen.mpg.de>, NeilBrown <neilb@suse.de>,
        Chuck Lever <cel@kernel.org>, brauner@kernel.org,
        linux-nfs@vger.kernel.org, it+linux@molgen.mpg.de,
        Hou Tao <houtao1@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>, chengzhihao1@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>, lilingfeng3@huawei.com
Subject: Re: [PATCH v1] SUNRPC: Remove BUG_ON call sites
Message-ID: <ZsjfuIKIWoapNKH+@tissot.1015granger.net>
References: <169513768769.145733.5037542987990908432.stgit@manet.1015granger.net>
 <169516146143.19404.11284116898963519832@noble.neil.brown.name>
 <793386f6-65bc-48ef-9d7c-71314ddd4c86@molgen.mpg.de>
 <65ee9c0d-e89e-b3e5-f542-103a0ee4745c@huaweicloud.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65ee9c0d-e89e-b3e5-f542-103a0ee4745c@huaweicloud.com>
X-ClientProxiedBy: CH5PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: c8738d85-7ba5-4121-e4f8-08dcc3a7e6e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?oqBjOhOfUW3qAgh5bcksRgpgkPpNBM7Gzb4Yg5egKaU2EcBWuXM0ERFnMk?=
 =?iso-8859-1?Q?BTOgzRYB/UBFQGKzc60rVUnWEf1s26nZGxV7LPskhYUdpVzMlG5H1UzAIv?=
 =?iso-8859-1?Q?w9MIZBW1qgJduzuRpGnmJKHhO16K7Gvtk3FkDlTnnJT+ccjftxTWS35SOJ?=
 =?iso-8859-1?Q?TIGlo8nr05V53SJOwBA0hKQJAoYe5yQDBZ2jZ3hHN8pQoXacS/t6bn2Q9T?=
 =?iso-8859-1?Q?C/e0lnM+X1vOPRErXjc20YrC5G1atI5yu2COLi+TPx4X/03wpf+qYgy17q?=
 =?iso-8859-1?Q?Q1MDt/BGbUrUXspzZBNwDPH+eKEj2k/W3Mrq4853uXYDFLhHw+GozyX701?=
 =?iso-8859-1?Q?pIke6dH3EFk7j4ZLrHubfG3XMELrbOc6dmKlPPmxMVHrOMDEhWASNNt7HS?=
 =?iso-8859-1?Q?lZd1o63UNSX624pJ3yRfkJkWQHNCmaoRvmEMgrTwjVvjE9XqxhuJEfMRer?=
 =?iso-8859-1?Q?LT6zeXpmgrP7fJMMQMa1Wp/Kc/sbV9Btp5WDCgcjOHc0wtGu+ysXnrYgAT?=
 =?iso-8859-1?Q?nV3pPmuDVDvbY82IcKDf1fKdq33qmieNCnwZgxIAEtyWhd72suOslGVQMG?=
 =?iso-8859-1?Q?E6QTy4Q+3E8tyEa+l5KySQR+nKM2H1Btt1jv3lT6fcB3i5Vn1oRcNv4J5Z?=
 =?iso-8859-1?Q?rsvPob9/L0MT4GYt82agCpEWcL9NDwrW0Hw28pEuIAq5jxNegfuAbxddsh?=
 =?iso-8859-1?Q?nuq7fjWCFMDLGnYCnINJec8+JWw7DZ/hlTj9pGpEom2DeXHPoURcnIYgAR?=
 =?iso-8859-1?Q?mkU15p1pnjx44yctGE6U0YO/IipsyFdSXrUd1ArOn31KAX9lq7B4H2WIEq?=
 =?iso-8859-1?Q?FWo+9Icj05IZ1MqLRfmk1Y7vP8irBrVn74yFGTmP6LDi4/y+SwolccSx+g?=
 =?iso-8859-1?Q?4LPqla8nnRdLZVc4WcJpD3bqq5SnjoY3eiVfq/MBtL646FoYo28qxNrD31?=
 =?iso-8859-1?Q?lvNBKxxxWqwJXcrCxgkf8UaQyPUXLvyzMg36qurQWew2NopyPo5k1snfkX?=
 =?iso-8859-1?Q?h/b2ccuc/Cr48vi2CS+ELKXOr44IXMWYb8Oi3v97JPXze8btBnZ1tUP3/K?=
 =?iso-8859-1?Q?/AcEeOC8M32P3TPNIch1k5nUERcQ06jNDbJYB9YR5NCR4Hod7fRre64gRZ?=
 =?iso-8859-1?Q?iq4HxFxDkvyCx/EDpve7u3f3qNj/aMKYOggO8KLQBehNGSIaDcLqqsakdg?=
 =?iso-8859-1?Q?JWXYgJ0saE/3aMINLP7TZJE/9p4eQ6ZyXz5JffJMz7xjUde3bptor0anol?=
 =?iso-8859-1?Q?9wZavf1or5cZKvXyzmgvANYQwOQXEq7ASi2o17emOYXPePgRLpHzKJdmMx?=
 =?iso-8859-1?Q?hPn5hO6SnJXb0uERbpn/fBqpn6VK3nvVtXCrLnLYV6NbkzhY6v/YCzCDzP?=
 =?iso-8859-1?Q?OD/zTdbUDrhE6K9zXz8CxH7D+02EPR1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?oZJw8CSFiNGlpmcGTkCsHMOaykJa6DjqagjODC+6l0uW7s0pgRkoogj63b?=
 =?iso-8859-1?Q?ZcHrXDyvmUthA1epg+5qXQ+7pcqePkQREvoWbXz/2Knwcole3xJ4Cyyh/H?=
 =?iso-8859-1?Q?hL/NaVjPz/ANmtfBGXtrIEiiUODgYYjAO/TCXuazBMmwEfrUCx2qhFy8Pk?=
 =?iso-8859-1?Q?oS7612GECUl9sqJgPnuNNucZwa9YUmi0hmwe8Tv6yLPIF2fvB2LiP+8SWY?=
 =?iso-8859-1?Q?FLXXH+tmjlVklVHbdjPcC6Nk25Cl5auqh1PfWL0OQ20PWIDRaUea0F44Ue?=
 =?iso-8859-1?Q?PJgC+9ESMliXKebXxeyxS/HZ2ZVFcRjqVaG19QpuYm805dA/4g8bcZ0hgp?=
 =?iso-8859-1?Q?JWvBRKQA6RfaaR3zneH/vUdsNkC5BHBjF+/5lBiJG8GCvNwQJhowpQ7DdM?=
 =?iso-8859-1?Q?OdF1oAS8MLGgEjP0lhEyWF+vvim2lv9/oSDsH0+9GNMTcLSvLJAlmtIR4d?=
 =?iso-8859-1?Q?6MUEuKy5s9duoYICGTfwUIQjH0eIo1yiKW4JE8eJJsgu8GrCDnnqIRTgY1?=
 =?iso-8859-1?Q?4yAmc7lp+wddsYzfkOrVYmZdkZj5n8JrbDWEzMIVorOo5uXSRUBPcijepR?=
 =?iso-8859-1?Q?d0PUC+Iycz6VX3DR5656LgI8iNdycpwCyJ9IdSt21/QpDeDrfY+i4Ff3tD?=
 =?iso-8859-1?Q?fgNQGbQNhHElRiigx/ffhFrquXfj5zhORnVL/JHxCRrYZPg+Yft4X1iEkn?=
 =?iso-8859-1?Q?Da18aHlOy/Pf4VU1949QS9T5hrKMFCYq0SYSPZtWzWmOktMPvvJYx0C0z3?=
 =?iso-8859-1?Q?mWoJrYpYBM7pY6vRL4V7Gj5SxP2guIAvP1qW6XYR1q3w9pfhUD3vdYAIa1?=
 =?iso-8859-1?Q?xDCR7ABQoV1N6r3T/HLGz94iLV1l7FMlZI/4dINOSLwsyKVl3X4RoZV1pJ?=
 =?iso-8859-1?Q?o+akKmw9sL64ptgdsmAsmQrJz+9emtovc1GJX7YinvcGK38AAMyRQIuCue?=
 =?iso-8859-1?Q?YUw9H7Twx9eNXa66EdrTN6eA6VrvFYXSXjBFujSKXThzOGEJLqzIWLTiO+?=
 =?iso-8859-1?Q?+35RuVKulE41+C/jAM3+XfQsEC40VGS88Rp58rAoTg0SU4Mcamu3El6Kjc?=
 =?iso-8859-1?Q?rUc5I60s3DhBeOzWJ12E8PO1ipsYfdSpvvtU2Txwe1yhnFb7VaBeTTFfgg?=
 =?iso-8859-1?Q?4AVMQnmL4tlbJF2bOoY1oRmbEbvd4iwn6aOgJbu5iUFGN3/KsR+TMrBLCT?=
 =?iso-8859-1?Q?+necXWAwjQ6mR4RH6s7r49dn0/tvB74HulBI82So7Avtx5bbb8KItTM1Ii?=
 =?iso-8859-1?Q?AE4JnXv8SRJA6vMig5+nrCF3/ut/gz2dTggenNAbgtrcu8IkfK59a408bv?=
 =?iso-8859-1?Q?ox0X/XvN67VwR1GBGXmKiOjFEySQB8pM8se2sGtrLQ6ePmkV/SJZr0YvUH?=
 =?iso-8859-1?Q?2OZrz6Bv0wIAPR6XWBvzoKZQNhn2pW5JsfTI3qSN9UHECQvNJZciuJFyqM?=
 =?iso-8859-1?Q?6xVn7BQLQDWisxo4tRVKlXR3JkTecldjgn4A8Leyv+bpVbaZMHiLf+dLO1?=
 =?iso-8859-1?Q?/4TXFgxD0ALem5G2U0sfTQs3NSOIG5VrrYP/lFuFjolcZhm6wMYDoI2uWn?=
 =?iso-8859-1?Q?2TP0+oaqUd6wctDfHL18DRb6qD4HiKv+dfEXhrvqF9zTPUJkQ/55vXDAJ4?=
 =?iso-8859-1?Q?QAoIH/51Bw5wXBwQ+45YNn5N6y0a4XJlvq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n2NB1tCwr0cm6mvb35DKglpFmyoFEC4W5fdVL5nfF5UKB07RlO6RZQ9TqY8DACYYMGlzxZcucpAAEdkZ7poXepBBrIKx6MTu+35kwWes9skH7O/ktN/8sREOhOVFZLPOR2DchISWo8j7z5RpPd9FI6nRoYp4OXKf9WLbiCmfyI47B15kM6IWfnfx+XdMn3HuKg4OOIoieNzx4VmnAwPIk4kMyY2i738x2jsTaoA63va3xQiNSNBWyEPGkJm5k4WEg0riBMzPpYuKE2GNQ85boB4P4o6IZNrf3Kan4H5uYW7fU94AGyF5thxkdiQELa10Y1RNobmCU9UubjXimDdTaIvjY5m+0FmQI20W7jj59DdeibrJLa28Dm6Nj/S+UiB7fuVXIIdxjrkwWYj5in/PLJXu3fYO/4l/RDaOiqDYQvl8srRIpGikblj6v6wdVPEtZSqy8fkCA42ZWGJb0M5wVhZz4QW+4nOB/RdHKIlZvswT3E6ROrpJtRO+kffQ0PYbz7Qq+SFvFZUh1e0tdmnPyra+X8zKBGkkG/nEA/zT+PW1vvDJRq8W6snq7Ij/6THUwDPeCi8EMmYeZR6tb9Vmsxm9ERfiOLqI65Ha6q76xH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8738d85-7ba5-4121-e4f8-08dcc3a7e6e4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 19:15:08.2552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRyMbVD7U5r6TzMWNRAsytfDgPbAqeDPNdTvw7oR5hP9lZr4EB+5MiGRltwTR30dEiHMhGhobBFcyn4r2HmGeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_14,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230141
X-Proofpoint-ORIG-GUID: PRzRuDmidvQAjYu0yymVT6bFjIOsp8Ph
X-Proofpoint-GUID: PRzRuDmidvQAjYu0yymVT6bFjIOsp8Ph

On Fri, Aug 23, 2024 at 11:35:28AM +0800, Li Lingfeng wrote:

	[ snipped ]

> [   91.319328] Kernel panic - not syncing: Fatal exception
> [   91.320712] Kernel Offset: disabled
> [   91.321189] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> Both of them were introduced by commit 9f28a971ee9f ("nfsd: separate
> nfsd_last_thread() from nfsd_put()") since this patch changes the behavior
> of the error path.
> 
> I confirmed this by fixing both issues with the following changes:
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index ee5713fca187..05d4b463c16b 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -811,6 +811,8 @@ nfsd_svc(int nrservs, struct net *net, const struct cred
> *cred)
>         if (error < 0 && !nfsd_up_before)
>                 nfsd_shutdown_net(net);
>  out_put:
> +       if (error < 0)
> +               nfsd_last_thread(net);
>         /* Threads now hold service active */
>         if (xchg(&nn->keep_active, 0))
>                 svc_put(serv);
> 
> They have been fixed by commit bf32075256e9 ("NFSD: simplify error paths in
> nfsd_svc()") in mainline.
> 
> Maybe it would be a good idea to push it to the LTS branches.

To be clear, by "push it to LTS" I assume you mean apply bf32075?

I have now applied commit bf32075256e9 ("NFSD: simplify error paths
in nfsd_svc()") to nfsd-6.6.y, nfsd-5.15.y, and nfsd-5.10.y in my
kernel.org git repo, for testing.

   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

I will run these three against the usual NFSD CI today, but feel
free to try them out yourself and report your results.

Now unfortunately 6.1.y is still "special." It appears that commit
9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")
was reverted in that kernel, and the fix you mention here does not
cleanly apply to v6.1.106. Based on some previous comments on this
list, I think I need to fix up v6.1 LTS to be like the other three
kernels, and then apply bf32075.

-- 
Chuck Lever

