Return-Path: <linux-nfs+bounces-7106-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A799ADE8
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 22:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CCC1F2248B
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 20:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2917C1D173A;
	Fri, 11 Oct 2024 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W/5v4tKx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hQJd1vMX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C3B1D151E
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680297; cv=fail; b=X0wTaCgdpzv20TQERQhp5lOTg2bBMMedw3rMoLDZtHNGupu35kWWziJBBfCcCNtinoYhP7Z0E39RU9O1rh+uCjVgXHKMEzRTW984aUWno5aZzsXcJh6830XIb77J9jT/8I3jgC/AImYt1JFyR+OIxE6q+lB2CQnmkxBtlEFezcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680297; c=relaxed/simple;
	bh=SnelgHFC4f2BxV3EzT1dQliPbl5Cwxz6jbwrjqMCvzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fIgm0QjtFicG75fi1/mFqa/ko6igIe410K08D4qxVQgSMZ0p9sZwxvwAnZHP364Ex+Rl5HeffLyVi3vsVU4L+xi0DORGawoqghgkywbwittqpWVfAYcJW/So/9HxjPExY8KdOwsmYjtp+InB3R/i5ly2N9A3MW0YbRzNfQLbbcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W/5v4tKx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hQJd1vMX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BJSNP1007058;
	Fri, 11 Oct 2024 20:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Il6Cd235EIZOytKhC/
	q0vl2Glz7Yt/ZsqxNvaLbqzxw=; b=W/5v4tKxFljGj7348cxZ7DneqLRq9sJYyr
	GF1dHPZ6QJijyoyd+HL1mBG2M4CxpHXcwq+Vz9QekabVTFMzG96VC4AvsAOm1Mu1
	3KyVPGUp1MdNDjIE7Cuu/IPMlPx1oX87F2PMd8Hb6cfMfl+vNr0OPlOq7euAPe4b
	l1rZTL3Ufk9/hDiH79QLOdGBi54iWdwBGiXbnzCRveagEjHsPw5ZUTZ3ImYmu8WC
	Zk0UqV8SKKX+iwLmaiA1adBoXrJr5dr1JfDhCmge0a/lF8mT4KWpvbMcH9cdz2mz
	Q1JOnqxRm7HZ7mNepraYcNpJfgfOt1PDAyFESaNxARj9mpV3Rt1w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ynt1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 20:58:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BKYUkF040253;
	Fri, 11 Oct 2024 20:58:05 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwj32eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 20:58:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxQOFY8pPySWggH0Od2etw8xVEx5y2c0ugGbTpAtOjm+u30K4Mh61yYp7Krx+EIwrrYzkGVgCqaABjot1iKOsmyiszE1kC1LCXSkG+98g5gwAYu0+s6Woyz3AugE2ROn6N/nBELDiCr68UXp+pYRSo7CTYEJ5RrglqXY+SNubRgJPVStwb/nIiZu399vFv1IYVgdPU3RysEYHDNRd2JZsXvg8qPvvu0k/99RUgWIw+LdsRwMtGbce2bJdB61xaYvHNqx6MTvGYqM7vXemPZsUDqlZdx4g4EbJaHMnFTaXBbKn/KGONmfcTUvDe8EN3XKy8EQotsp/VEJmlajvSjNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Il6Cd235EIZOytKhC/q0vl2Glz7Yt/ZsqxNvaLbqzxw=;
 b=ffV7PkDvR9BUI+by5ogNvzVX/Q5ndKnPyVbAQ7itOBJnYK8JRdsj+6UybVl2fNfn8Ig/BEegDFv7Bzow2Ar/NAHv8lYm5jeUNlZj4lD9a/lU8EBUmybPFaH9uolINFvP+UbkQ8vE0+vpdBH+xzJpmRJznPzTnuJYdWvjx22EhDPILDwV0Hkfdxs588MiBa8jq5mXvAY9oB/F96LzL7sAmft2c1U2N9K5VOwlqzKrByYwuencqrC+66CeIsPPVnQJ97gK/n/NobDcmEH9sNL9OIeZ7Ypq3NJJhIdCvWGaLs+GoTw3WsNf/ntlJGgzNLJwd5ugrMuWA7NgK+T3YVx6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Il6Cd235EIZOytKhC/q0vl2Glz7Yt/ZsqxNvaLbqzxw=;
 b=hQJd1vMXxLrG09fbr/RBQgHLuE7GT8gB6M3tDfzjCruiO1PxdKh8LTw+7CptP4ZhGbnAtvyst3zdEgIRdu5AJ3thaRvo/CGS4ayxd96U+vJE36RjdQlCwV2HzUeypMSDP15nRsMuv9/Aecr1DG13noEJlyLHpCCgWQtPeAMAxeY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7375.namprd10.prod.outlook.com (2603:10b6:8:d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 20:58:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 20:58:03 +0000
Date: Fri, 11 Oct 2024 16:58:00 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: cel@kernel.org, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] NFSD: Replace use of NFSD_MAY_LOCK in nfsd4_lock()
Message-ID: <ZwmRWAmRukgOrFpt@tissot.1015granger.net>
References: <>
 <Zwkx54LAxJuuxTWv@tissot.1015granger.net>
 <172868001492.34603.7415839336713873165@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172868001492.34603.7415839336713873165@noble.neil.brown.name>
X-ClientProxiedBy: CH5P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f0f6dc-356b-4ce6-dc8e-08dcea3765b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ENB23wfzoAJC+IkKfuSjdrvj7wSjmvyVb1C3ZFI8XzYwb1FelGvbN5KGVkEO?=
 =?us-ascii?Q?GAmOxuLJWJjU5oXZXMwcrRWhDSrT8TruM8v6on36O37Wvy++kf+SoehOZRw1?=
 =?us-ascii?Q?DaxOxLslIGPdI65yhYuG2lgycXiL3QTGKsomQg8A7BSyukFi1Nfeja0pB1rG?=
 =?us-ascii?Q?0yq7d47tI+f5SD5H+2JiQmrvoFb/cf4D1nNuDMioTDnjMdgDHjO8rNvBrW8l?=
 =?us-ascii?Q?lxtXsRzuHd8irNfnTwmfkpE8Qlw0M2ew03OcOrEx88omMwfH15JnCnKSf4YD?=
 =?us-ascii?Q?pyhq4ABQgf6r7xK2YlWL3IMPByoA/3CnGJEE5j5S5Sl4+lWf7MXiyUQDHmHm?=
 =?us-ascii?Q?PtyNWsvtUtFFQGojvKII0X7/k2jtNis3dcBcTpo4D2zWgn5quOlHUzJVnuWo?=
 =?us-ascii?Q?YOl0gqfvXL4l5pgV5t039xE4Nb4vb9hVYGe2Xa1tWM7KfyvuyV/gnaI6jir7?=
 =?us-ascii?Q?sF+8rQjVMGAFKzkwL4JpWztK3pMmIMDIf8ia8H/97WsSx96PVk/PPTazWEfO?=
 =?us-ascii?Q?9p9S3LV0y9twklK2w8ObH3ltY8XZngKxhQUgPQpj5Zjnx2iHtnqXQ4U13BOp?=
 =?us-ascii?Q?ldX4OsqjBdRFDz0Vtj5K1pi9HVsFrDXHGhBtdpOEv4DDQgNe3jHTa4+MhRwr?=
 =?us-ascii?Q?/6z6e+0kygo73TO3AZGrStoG1DLXLdhUh2wc2Z5nm7mVMKTFqpjLVLlnUuBD?=
 =?us-ascii?Q?rPpftBKu6L9iuY86HWgEJmVARwL+PIuhElTfvHL7FN/TstBeEgnFyByNh59N?=
 =?us-ascii?Q?wpaXNG3nXbdmFLBlrIe7MoLUJ3xS/CkBBWv7x+q/b394EVYHGxDHUIHGADyw?=
 =?us-ascii?Q?bb05ShYxG/DRcfELmjqQHNx3K1ui/PJjaVEdS9r8oG2P9UgjVdPP+rGsZFVE?=
 =?us-ascii?Q?bCOSv3a26baLmdbfQBRq7rdhP8cdiHkgcsHOpW60eurk0lh0Z0ZtNgqKnOHs?=
 =?us-ascii?Q?p20XCBghtIA+eVMjaQ+yQgjL8ASGbIG2NR/iJA6ILqTGuGjFWXzqBeOibDYo?=
 =?us-ascii?Q?t2xpGs+uuFxyMZe4lk/yHzdjWHc6+XuQcVnHLfG8sa2cbD1rLoAG+Qk+Bult?=
 =?us-ascii?Q?274Q3j9OJHA4bCvvlhP/BPvJDnImJp7m4oUsn/6m0vVs3ONJcKBciZikt9Wm?=
 =?us-ascii?Q?qAtAFuY2nVTWm9/mA4XqoZGbVCqLESkVKFaV6wi7FilOJp34Et1B8WRmhibv?=
 =?us-ascii?Q?Kn2oybqIJ+nxGQYFJMt4di9yXj51Oxk/jgKDftXwAbVbCvcaQTKvDOF76cCm?=
 =?us-ascii?Q?XacTQ0BIDn8Vu+iyu0dozlfH+oN0fL9kYS/mh0J8xQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?01MjJLylVANDJeToexCbBIEzVeJss8Y6svGWYDi8PUw3k7RnmMbIWmWWX+JZ?=
 =?us-ascii?Q?YFKaG2oawiIJqKShX5oYuScGofmy8hWF+ZRQfHl5j8tQ3DfuL0GhXFuOeS7C?=
 =?us-ascii?Q?Yhankh/LBwfM2K6Z5RxWOtY9n4GG/vNf75NR+AokrVqWurvXBnpq8yTL5XP1?=
 =?us-ascii?Q?IUuT+GYhI/ePJ+cp5Qcn0VzllI0hzPBsD0hEXrxAv5Gu+yS1huD55UlC6nay?=
 =?us-ascii?Q?oG3pw6YTRUzvrqkHY+uI0oppvnPUjTIgBoXRnhxztmAyjVWl7uYQyIqpn5fY?=
 =?us-ascii?Q?ljRGGGaj1VntZKoIqCqPyjJ379NtKxk2kGjwikq7ecEbp42fjFRKGKhvzL2A?=
 =?us-ascii?Q?TpDrbcoEXSrv2PtymBqpOiElkPwimhgmRXnVfhtlXpZta5usdKhe5xL68Vg+?=
 =?us-ascii?Q?spePHLef2QJjZEZYjWhas/Uk4Sr3zDqohyfVJzgxkHTmXKBVPcDGjPMip1gP?=
 =?us-ascii?Q?oH7IU4aoOnu0QAqAZVDDwCj5jvZ7Y1B+iUwqv6d9fwkP4eGAvxTTCHNK6fRH?=
 =?us-ascii?Q?vc8ga5i9cSFtYMeZBQx+vPzx9YuYjsUHYlKqOfTBD2OQg3ZTI6qiNUmNME2g?=
 =?us-ascii?Q?gghTlfqaee8IM2dqJU32vV8OjRY/iR4X4oXz/2Vr5XjRfVze+veBq2wBgsXw?=
 =?us-ascii?Q?eOmg9MXDf0mTvO+rX0MJdy8W1IPaFs5w8Yqiwf/QkWJDdeWwYg4T1xoHz2EK?=
 =?us-ascii?Q?0fvlHXl/6aQ2NmfkLot8nbnqyYVoH66OVnv8N72cz/qOTsGN1FPiiFkE1ZIv?=
 =?us-ascii?Q?NgB8CTXoccviyRfTF3RhAU1cbN2iW2i9Q/ZTVaajexi2KpgFcxEj/Mier3VL?=
 =?us-ascii?Q?d9l16yegpp+IFL8RUqFjKpkwWWkSOnAFCMbSS/DjVFpx2q0syTOsTs1T1Kzg?=
 =?us-ascii?Q?9jqETzdlxf9kObiBKByibVTpU5j9ej+phl0FWiP66lZEhad7MxkCtQfKjch1?=
 =?us-ascii?Q?vGb0gi90iHCsxqFflcR5BHtquvx7uZbYVxdkkwSyjOFI3CAqkNpiiVR+W49d?=
 =?us-ascii?Q?RW615AjMeVhhXWLgUwuwzLVuBlP8SHCMMI4itnfBY3cnEqALKF6GTSZ0BSt/?=
 =?us-ascii?Q?7fSsV10C6LYxZ56okCdqoO8ju4U3VJdSTvGF0+bhrjB/z5pkJoPFU+30nNoT?=
 =?us-ascii?Q?07VPDrovcg+PoEk36RXs9BlwzABDB1FZFvWkmcY4IuhC5EF+coepHk1eJ4Oj?=
 =?us-ascii?Q?4+Z8sKys6gFeiYGrVA3CtMR5KHpfLeGkHcFdAeAQVNu4Hl1BfhrXWPu0WKCM?=
 =?us-ascii?Q?g566ByfXoHGxgyk9LKWwscjqBRMlc9QIxyPH1RrgR0UrE10tQGphPNsgnQLO?=
 =?us-ascii?Q?WZfhsi+iQfRUYlJENxAzVCpze48c2JGl1S4b2LFMjoJ7oklBbROSv9zOUD48?=
 =?us-ascii?Q?m5BnIBf0IFcaCE8tgX4W29NldTV96n4LwUXHpDr+oHRMFPYr2d7Df4mAfNHr?=
 =?us-ascii?Q?YvPw046cUesHE3tiXP8UUGnpnAvsD+9lpi1ma2qW1my3uwzaz5T1X60J94Gh?=
 =?us-ascii?Q?7yICmV/cmp28cLT5BzeHKCQCWrUnylSpzPqnLilYum+YH6DZgv8LeMmqTJGe?=
 =?us-ascii?Q?6i/CeVld17VML2t+w7vlLZChK+1HGA0JRB1hRZeY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r4CJiDAcfKhhXKSf1AuVzFRan9CLEH7R4ngnLEW0Vhz9YsX03MWYYJmXlhJNRhPn9YMsCnKLKe9TiiEhcJWgcKwkMSdksXkKmz3l5FPhxIkEfsHrWnmhRCahON00fUcu0ezyP7X0SZiM6+Cc/GHNzPl/2QKQ1ZNTf3Le/FhLxhNgzxXal2Hgek2j+Oad7wYhCBI2Vuj2jW0te/DL08LMB7/JpjHTsyrODdcnyeS4SBvHh9VUhQEEvMIynU1AujSmV3mHvVfrpeft+Q4wpCgiLJoJThCnGkv0XMG35yF3uIPInlEoEk51HofZ2pHD1HEZBcZTnVE9p0Rmb3+qm2wXVsMDsahTkLk23sOCXNYCgwfwZGdGgPXTHtTZkDicX8a52LZ43Xdu1qi+EhrUp5frH4ixX+iyBX+aIHbuWuXM/5lL2MsenPQpGG4YJffksOe2VL/k95PxMg50FeSdDXsyqLcTbOpIjcozk8fu3HwdxKjhUiM/c+4OYboF/PvBXYhsjTCJOMCGCOczWGD6/w0PxR4S+DInwvzgmVbh/UgEb5yvIy9fyaZizXOVOzbaUrBLLq9iZiw99OQfoqr7hNo9shww5ZM6FPvlyEW50iszRWU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f0f6dc-356b-4ce6-dc8e-08dcea3765b5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 20:58:03.1263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87Ht3ublR6A+lGbPMkNIQ2/ywaM7zjQoFIPc9/PkQ4Ki0oM7BB+PNoHVFGRmxgsOV7TjqBu25KC1YfUmOeXdoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7375
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_18,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110146
X-Proofpoint-ORIG-GUID: XlOZjF8SVScsizmo378hNPUtkMCXKwxA
X-Proofpoint-GUID: XlOZjF8SVScsizmo378hNPUtkMCXKwxA

On Sat, Oct 12, 2024 at 07:53:34AM +1100, NeilBrown wrote:
> On Sat, 12 Oct 2024, Chuck Lever wrote:
> > On Fri, Oct 11, 2024 at 07:54:12AM +1100, NeilBrown wrote:
> > > On Fri, 11 Oct 2024, cel@kernel.org wrote:
> > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > 
> > > > NFSv4 LOCK operations should not avoid the set of authorization
> > > > checks that apply to all other NFSv4 operations. Also, the
> > > > "no_auth_nlm" export option should apply only to NLM LOCK requests.
> > > > It's not necessary or sensible to apply it to NFSv4 LOCK operations.
> > > > 
> > > > The replacement MAY bit mask,
> > > > "NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE", comes from the access
> > > > bits that are set in nfsd_permission() when the caller has set
> > > > NFSD_MAY_LOCK.
> > > > 
> > > > Reported-by: NeilBrown <neilb@suse.de>
> > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > ---
> > > >  fs/nfsd/nfs4state.c | 7 +++----
> > > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index 9c2b1d251ab3..3f2c11414390 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -7967,11 +7967,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > > >  	if (check_lock_length(lock->lk_offset, lock->lk_length))
> > > >  		 return nfserr_inval;
> > > >  
> > > > -	if ((status = fh_verify(rqstp, &cstate->current_fh,
> > > > -				S_IFREG, NFSD_MAY_LOCK))) {
> > > > -		dprintk("NFSD: nfsd4_lock: permission denied!\n");
> > > > +	status = fh_verify(rqstp, &cstate->current_fh, S_IFREG,
> > > > +			   NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE);
> > > > +	if (status != nfs_ok)
> > > >  		return status;
> > > > -	}
> > > 
> > > Reviewed-by: NeilBrown <neilb@suse.de>
> > > 
> > > though I think we want a follow-on patch which uses NFSD_MAY_WRITE for
> > > write locks for consistency with check_fmode_for_setlk().
> > 
> > I think this patch might introduce a behavior regression, then.
> > Instead of a follow-on, I need a v2 of this patch.
> 
> This is not a regression - it has always been this way (since 2.3.42).
> And both NLM and v4 suffer - I was wrong about NLM.
> 
> If MAY_LOCK is set, then any MAY_READ or MAY_WRITE flag is ignored, and
> the 'acc' passed to inode_permission() is only MAY_READ |
> MAY_OWNER_OVERRIDE

That's what I thought when I looked at nfsd_permission() again.


> So any locking over nfsd currently requires ownership or READ access to
> the inode.  This is slightly different behaviour to local filesystems
> and it might be nice to fix but I don't think it is an important
> difference.  Importantly your patch doesn't change this behaviour at all.

nfsd4_lock(), IIUC, thoroughly examines the stateid just after it
does the fh_verify(). Maybe this would be OK:

	status = fh_verify( ... , 0);

This is what the other NFSv4 lock-related operations do.


> > > And I'm wondering about NFSD_MAY_OWNER_OVERRIDE ...  that is really an
> > > NFSv3 thing.  For NFSv4 we should be checking permission at "open" time,
> > > recording that in the state (both of which we do) and then performing
> > > permission checks against the state rather than against the inode.
> > > But that is a whole different can of worms.
> > 
> > I see several sites in NFSv4 land that assert OWNER_OVERRIDE. But
> > point taken on taking the permissions from the state ID instead of
> > using a fixed mask.
> > 
> > 
> > > Thanks,
> > > NeilBrown
> > > 
> > > 
> > > >  	sb = cstate->current_fh.fh_dentry->d_sb;
> > > >  
> > > >  	if (lock->lk_is_new) {
> > > > -- 
> > > > 2.46.2
> > > > 
> > > > 
> > > 
> > 
> > -- 
> > Chuck Lever
> > 
> 
> 

-- 
Chuck Lever

