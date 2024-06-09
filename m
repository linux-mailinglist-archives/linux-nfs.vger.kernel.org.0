Return-Path: <linux-nfs+bounces-3625-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CB2901684
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jun 2024 17:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4B21F21343
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jun 2024 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF73542A91;
	Sun,  9 Jun 2024 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kYVgL6Ce";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o+6J3Bc+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C3A4436A
	for <linux-nfs@vger.kernel.org>; Sun,  9 Jun 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717947880; cv=fail; b=QMKuz8anw994PCLjfu0IA1rDnFwGw0RLB/JYCx4HjW/5XZxj0Ou1M0NGURwTQdkohk0heNvzmYHaoWi7VWlzHPbCWuqTtajhGUXkZ0WHtIVUw+6FnWnrFV7FO2lGeLo+rzM7VfU68lng2HOn5HRLKnibRnxzCvL+uNbnRaMdOtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717947880; c=relaxed/simple;
	bh=co2mCsJe3rsb9SYwkc5EKNIZQKGs22RHG2eSpy9LlWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bya2fxC6I5vAfzjP0ldvgmO+75e+xhus1IU2aHB2H5NT2pt2m4naY9A2kmfHVDjfL0OAJNdgLF2xlHyiypM7xXPtxNbJZOYXqZzE9UKGnmsEBrMZRkBdcK8UePODtZ1ykFhXexVCFlpUAPZuG73wHaIvdAQJCWOg/YcwFKv0eOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kYVgL6Ce; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o+6J3Bc+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4595kclo023183;
	Sun, 9 Jun 2024 15:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=p2MyCOPVmafke9g
	WYH5weqDTl+23wQWvb8ZE6saRV+k=; b=kYVgL6CeGMCIQUVGUpLMB4DLAjrK4gj
	NX4PyLdSliUCow/HNb71/14irG/UzGSZMjxia4ssqSYEDxFvfyNh5AzhRuE/g+zL
	jx04EGMdQmzpb8BkI7QuN0BeD4MfARJc2MsTvdb74Tl5b0BUl4c3TbnAVUigpxVF
	UQPwwZAdku6UygMDUHSXKwbm5TMeGLSLBHrnrGXw5GGZBgD0rzU1ffr1a4f7EwCc
	kRb31Uib4YxROe54iiV3tqy1uV61WtdHRIGl8Bnag/HOrY61EZk79mxTUcjwv3I2
	B5WSqBqLLNVP5EqjIG1bCacBP7AjaybzozWNyBC2n0FvmjdnzXi7/+g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1m99ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 15:44:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 459CRZq0036693;
	Sun, 9 Jun 2024 15:44:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdtu64u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 15:44:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+9zIkFg09PRQhdvE5f7tAasubevuV0RRr+aQJjbn4LSM7fOslzpkpF63lmyLdsdaxqA6ecPmm1d1+rPu4Ybnpi+uXpoHJ430KCeDYq2KP3Qhedfdv1FUQy+PxK+4Gwrq062AMfUWwEKvmqdEv5bF4WDFj7rHNZl89P7qOaryF6ChKyt3PwqPwfB2Cwj+rI10p28CM3Xdte5eYrXGmcnh7k7YA+WYSu3CXoFIjJBG/PE+109b8UGKpxGr3kwcQ7dRiGnkEXGqevq6rIhGeyYhRGW/0X7E20DBA5EEvhL/HOVfGH+FVPESAaVR6BdSyrR+qbYRHgsUl//nONST7fgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2MyCOPVmafke9gWYH5weqDTl+23wQWvb8ZE6saRV+k=;
 b=LIR0DovEtfMJXyzraDt+oKrwOIUhHjwbdz5v2TbzHACJki28X712oR/TGY0RmZpWtnYX7Ztj1bM2Ot/LLDIeOYRxeDHtPXQDe2nyrSwXn+pxuoiObkEAbE5GMLGVGC1PGgh/18lPi7hAF0qXHJ0LfKp1D1zcADQlbSJBZGK+Y6izM5qYIIDSwJskr5j+L52sqlAqDvskP8/LlpfhWQXlibzKX3w9Zs3RDMxumsKnj6i4TXzyl8eclW817fQkbUZkIAjXUiWpshv4zd1d92MEs+0rT/40rcEbaNrMafFQG8++OEy4p8SxM5F4qnLmPNnt5FazzXuQ7g667hrtm5lNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2MyCOPVmafke9gWYH5weqDTl+23wQWvb8ZE6saRV+k=;
 b=o+6J3Bc+qJ01rZrB+ZGVC/VfCqRibc9TMrj0oyMN/h6qSH3A57+JOg+0wCvdkt3UrwErkCZuO4CAYHsPIPRyRGEB5m2yUH7KD0RzTk9/vYuz90+A4da8wvsY37qgwrYq4sf2OMSZSXYRpG98fcYniv1ZYAH4XBRjMQwXoPPIsZI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6135.namprd10.prod.outlook.com (2603:10b6:8:b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Sun, 9 Jun 2024 15:44:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7633.036; Sun, 9 Jun 2024
 15:44:30 +0000
Date: Sun, 9 Jun 2024 11:44:27 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [for-6.11 PATCH 30/29] nfs/nfsd: ensure localio server always
 uses its network namespace
Message-ID: <ZmXN2/e5FmRXsvIG@tissot.1015granger.net>
References: <20240607142646.20924-1-snitzer@kernel.org>
 <ZmNMCejlYlDgfA1Q@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmNMCejlYlDgfA1Q@kernel.org>
X-ClientProxiedBy: CH2PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:610:53::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8d7103-9946-428e-0e8d-08dc889b0d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?shPWYU6tKA3rXotNkW1NxbEZg0X8uPhlGBdy0X0f4FvyvOx6mwEh6KfQx17y?=
 =?us-ascii?Q?72A9AePpIyvQ3dUFWfmAFTjxNGjBqIJ8s+2Fi0SpUcVGdkNIn92yoJB3IzoF?=
 =?us-ascii?Q?YKnrXgk03IA0uWcaIEK9xXuRtKzq/LxDKSuaUyEZniykk2BYhcPoBFaXswpE?=
 =?us-ascii?Q?IlTuv49oOMGdK58V93PrxeC0FsV6R76dk5Ib+X1JaE7Fwjs3N/wrEgMGvSbU?=
 =?us-ascii?Q?f0jfFTGK61NxOG9Ofi5KVXEnf36F9prPsyHkWFloqO/jBaGDwjEL1WKPq4BP?=
 =?us-ascii?Q?zsygkD9qZRNloe/TX95YLAfaoyug5x1xTRi5ShoiQCj5cR3O7yBxbE3vquN2?=
 =?us-ascii?Q?Z/wzMYfWkqjkQWIND5Rkt94oVEtRi89cd99tf8WNBjPEZZu8RoImupsmsnQw?=
 =?us-ascii?Q?qtpXKXbz7HjBqjcdOllkgoDVPmwS4igdRt95kQERgiEyTZ26BHkzyvLdd+20?=
 =?us-ascii?Q?I77MvpfUQ+KyC48S+fGWcaj2mjeW2gYaxEF/pup/qWvm0Tshv1fgvuSmexUo?=
 =?us-ascii?Q?nMJQI9ACiJr6z6a1daUdQRGk4dIGM8lc7XQ8KJgRvxzvQ0C04Cd9hMQgJG76?=
 =?us-ascii?Q?bEJjmaPh3F1fQylX44eWA6IVMhzEF8XilMoV1fMdnVogpOis4CQdbR0R2hIR?=
 =?us-ascii?Q?tUo/BOk6cTcLKFQHSKd+R4pacQTZ9F1HWHqyFxQaYXpMxyqrCmjdJJeHnUp6?=
 =?us-ascii?Q?fNlrfHHB7sMx59YhyymlkMIlaLU1ZNpdsFdVRsC0o7sXZJGFYPQDjGcxQ9mq?=
 =?us-ascii?Q?tG9B878zTcLs66AWtdKey9odj3Qcq9z2u0roG/Q2Z+gKwwdEWZOsfI/17bKf?=
 =?us-ascii?Q?y7rqOq5qJ4A68CThb0tX9EfYiqokniE6bvi9N0iXeaUGxBtPpXx/3qEjPtG0?=
 =?us-ascii?Q?UybYEfybKjQAFsA6lUOte4MG+q2cHw1yJPt00WtiHGL6ZA4m2NKBCI0V5//t?=
 =?us-ascii?Q?ra6b3C9QwD6QOkU1bZGlz7orTRyIiuK7TugB9SmpNN0isS02mG1cFte9hUIe?=
 =?us-ascii?Q?RZMwa/n4gsh3QA89APxmD64nW8tVQSv+5Ma9VsgZnFsBFy70XkOc/6AdBBEz?=
 =?us-ascii?Q?tWeXLMyEbCMMMhsIBPjSxRQ5yg6Svro1vQmS1b22Q3UsfAjfYJLdWjP3xXqv?=
 =?us-ascii?Q?3HPiq2QuRHDV934yvRfYfAiY3NMw/VjwfyrpdV3FKmGtMehlv9OzX6pL6SiG?=
 =?us-ascii?Q?8Uz5YeperWte2nDezT2D2odCU202gtUQ7BhcdmwAGLw2OL7Aw/gNrltmM3ND?=
 =?us-ascii?Q?tTmFJYya0OQpU1izIrKAG7gRX3La8Nk9CznRLwbZgZQGqFZmr5ElgNuJ3EfY?=
 =?us-ascii?Q?sjRkT9jq98LiSUroi0JeydMw?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sPC3sQDkMVZ6iHZgekgJx50jVEi2GXY5laxMApzwv0SJ/zgaoyKgxnkgGEfr?=
 =?us-ascii?Q?sNQnsbIN4JfRhhx4Qe3UKH9eI4HRrQPDwT+26lH8xdj4nm/EL6RxjN0Mlhza?=
 =?us-ascii?Q?WShmm6ETfny3JsIg98GQo9bO/rGqR4q5+KBKx0MJ3J+ud06wTIEXMbV1iiEZ?=
 =?us-ascii?Q?KZiNkwKsS1j9HslqUWmcT7B6RfUs2GZ+gQsvc7JaRvw07leUu1w1ZcS9Kfdz?=
 =?us-ascii?Q?lD5QvSqGfARcMlHm8lRxsInlSjlAnYclMB7CvgLJWhfNpy4893/CaVF6j0Ji?=
 =?us-ascii?Q?xxl+BUuU4JqQ4nMmJ7ENse4FufdOkM+fMiXhfbH+y3bIFC9BiJFyNOfYkiDV?=
 =?us-ascii?Q?9ZRHFOUu3vCcEDpADLAhE3hrJ9CTt/f9CzstkTsRwrVSz+21Mq0nqlpJaTiH?=
 =?us-ascii?Q?ZSnaRkjHqRDvN0AYn2mWwjAQ+8E+k9IgUNq3q3omXbJl5VvnpvMCtdSoM3hn?=
 =?us-ascii?Q?4v6glYwrX/aYnlm+kNBx5yCFHI6Oo81FtQJ7SvTh1NUmnaVsO7vwiPTGhAmx?=
 =?us-ascii?Q?dgz98ce/Bam9MyreNJf9WxydSUSHEeYBSkNp3aN1wRv2DE9WR0GqezkTu8Ot?=
 =?us-ascii?Q?LKqrfDsPWIc2EKn0ZmEqg2q6nP0o8v/TTpDe1LvDVJurRAw8xNzDiJSuTbVO?=
 =?us-ascii?Q?txvKaMg4wsNOU6+ZlrkKu2+THgZ46El4Lf4/RaN/dQLCC18BCCgdM0Anh9/j?=
 =?us-ascii?Q?vuPcYmiNsN7zv6baq9dg4tckKF0xQ8+XJjDdmK/ONUe8IctejOE/5OUsdg5R?=
 =?us-ascii?Q?VgPP4ORGgmW8N+3yFQo0f8vplH13v3ndkugylBe4CawvrHzChorUk9a4f9Y/?=
 =?us-ascii?Q?HkrGukvzsnl5bFozn5moibPqqmHcMGe+slIZ9FH1R1jNiB4LLD8NRAm/eUnw?=
 =?us-ascii?Q?cogr2v8tHcHyAVlmG7Q4kdq6vYQb8WiyPLBcwOVQy7Y9vRkgC6IVA3fcFdDq?=
 =?us-ascii?Q?mgvhSKW70JyzZNyTf+yWnDC+Ztr+eTG021dMJ99qjL7UMPNUYrLW10MUcUpQ?=
 =?us-ascii?Q?fEttJlmfPqCe+pb99WYNbDcU+2lL27XV5lRVOq+f5O0tOqQXRWWQg44HKczn?=
 =?us-ascii?Q?4ahUNjm/k0jYIi6z1MQIzVZ3Cey4pH48HumO1Faw0DUJ1vVJacaFOEJ0oWGw?=
 =?us-ascii?Q?338N6jWBEf0+FaQML/d0Mr1wsr0qwqxdW2JQyCM2zQAgGmgZYi2+9vGoTqM5?=
 =?us-ascii?Q?AKey/cM586ZENqVFEoNmeIp6ioB+mFKXq8bFt2RXtrXTsa9nlTwm55sX+iHp?=
 =?us-ascii?Q?TDu2ONp7U6rzQMXPLcYe0ioajEF4WDdIQT4AOc/T3/b7Csz/XIQF0MC6vHMu?=
 =?us-ascii?Q?4hTq4+z2N6YA126WOwuIccCTaUI62FS5szMhGJ9QyujY4v0CYvtPDvKYlZ2J?=
 =?us-ascii?Q?F+CIgqJtWmf7ibGi3KFJ690SCmjo481XtZ1TRZCSn1TJQNhT48qarA2m0edL?=
 =?us-ascii?Q?1xR1KmMw5PkPoBHFy9O4w5QY9yrEFkrVhKaxwbGJiidUqI5dMuoTkom8/vN8?=
 =?us-ascii?Q?K66rlPDPYP2f2YlUIRkLMCw+B1QbHPrGT6tY81iksb3gMCkAtwzaSzYJayN8?=
 =?us-ascii?Q?HeFWFPfGaAUarZqbDyY4If1eBI7xSrx6+sFkh25qPFGK3yV7z2/oHJc9DW29?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3yOTPTIu4wNPdnKLHPyr99jQqtzkl04dY9UvURUclv2JAUSRtVYKhZg8TpntWrQlq3GcqtIML1vId/pKaiF5NN+Mai/YAzIROc/jqJbsPgBp9aBESm5vasDrvg4MOkSC7SvxuyqDiI3K6vNGGQTnZKYnoDpamUECjmmDgtvlQwQfVX3O+MfEv8bS4xVpcYHmV/7ZBaS1+sIwlrPaukQuvOnxleoK5rJIznxXrqO8i12JRB9L2GdTr4AXUwQo4Gf+LhJUdXX/9t/eZxcXmBVfRjavUfzwfDAjlSEtCBSj4OlZPpNGIdEYP6Ai81YHMNBsDW9nK+EeQbfVMELGnu0eKafKBhcVSdYVxt+hBoBswaXD+pmaLadugpv/pYDDezFReA+7EZdlSPU5IJXCyXi7LIaRGMTPqXCcRZqRGGc+hoJ0rcYjaFiMoTRHL5zmSYGOD98XBgHRvXtxK187mAP7bdrBHUZuNXU7i+diaB2HI5ked+xMF3DXXP/zHk8+NgkQFvQ0ThTt1A2iPrKeUuoTE90MviaPqMKlLhyj4zb/qBLBV3F+kOJE4r8wljBWr7olRGR42gCvhpHY4xYu2yEcxJy1CSp+eS7PNR+0g29FvF0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8d7103-9946-428e-0e8d-08dc889b0d43
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2024 15:44:30.4488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORjYyvykGuvuMZ9wlicZ4rsm8cbQ++JTf3z6CaqRXFCQIdFpGJWAFAGXFj5tBwpAVg6qf5l625exKf42iTK5WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406090124
X-Proofpoint-ORIG-GUID: FnvlesFj5PHaQp18tAjs5Kc0R4vZBq6P
X-Proofpoint-GUID: FnvlesFj5PHaQp18tAjs5Kc0R4vZBq6P

On Fri, Jun 07, 2024 at 02:06:01PM -0400, Mike Snitzer wrote:
> Pass the stored cl_nfssvc_net from the client to the server as first
> argument to nfsd_open_local_fh() to ensure the proper network
> namespace is used for localio.
> 
> Otherwise, before this commit, the nfs_client's network namespace was
> used (as extracted from the client's cl_rpcclient). This is clearly
> not going to allow proper functionality if the client and server
> happen to have disjoint network namespaces.
> 
> Elected to not rename the nfsd_uuid_t structure despite it growing a
> non-uuid member. Can revisit later.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/client.c            |  1 +
>  fs/nfs/localio.c           |  7 +++++--
>  fs/nfs_common/nfslocalio.c | 15 +++++++++------
>  fs/nfsd/localio.c          |  9 +++++----
>  fs/nfsd/nfssvc.c           |  1 +
>  fs/nfsd/vfs.h              |  3 ++-
>  include/linux/nfs_fs_sb.h  |  1 +
>  include/linux/nfslocalio.h | 10 ++++++----
>  8 files changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 3d356fb05aee..16636c68148f 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -171,6 +171,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
>  
>  	INIT_LIST_HEAD(&clp->cl_superblocks);
>  	clp->cl_rpcclient = clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
> +	clp->cl_nfssvc_net = NULL;
>  	clp->nfsd_open_local_fh = NULL;
>  
>  	clp->cl_flags = cl_init->init_flags;
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index fb1ebc9715ff..1c970763bcc5 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -187,6 +187,7 @@ static bool nfs_local_server_getuuid(struct nfs_client *clp, uuid_t *nfsd_uuid)
>  void nfs_local_probe(struct nfs_client *clp)
>  {
>  	uuid_t uuid;
> +	struct net *net = NULL;
>  
>  	if (!localio_enabled)
>  		return;
> @@ -202,8 +203,9 @@ void nfs_local_probe(struct nfs_client *clp)
>  		if (!nfs_local_server_getuuid(clp, &uuid))
>  			return;
>  		/* Verify client's nfsd, with specififed uuid, is local */
> -		if (!nfsd_uuid_is_local(&uuid))
> +		if (!nfsd_uuid_is_local(&uuid, &net))
>  			return;
> +		clp->cl_nfssvc_net = net;
>  		break;
>  	default:
>  		return; /* localio not supported */
> @@ -229,7 +231,8 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
>  	if (mode & ~(FMODE_READ | FMODE_WRITE))
>  		return ERR_PTR(-EINVAL);
>  
> -	status = clp->nfsd_open_local_fh(clp->cl_rpcclient, cred, fh, mode, &filp);
> +	status = clp->nfsd_open_local_fh(clp->cl_nfssvc_net, clp->cl_rpcclient,
> +					cred, fh, mode, &filp);
>  	if (status < 0) {
>  		dprintk("%s: open local file failed error=%d\n",
>  				__func__, status);
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index c454c4100976..086e09b3ec38 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -12,29 +12,32 @@ MODULE_LICENSE("GPL");
>  /*
>   * Global list of nfsd_uuid_t instances, add/remove
>   * is protected by fs/nfsd/nfssvc.c:nfsd_mutex.
> - * Reads are protected RCU read lock (see below).
> + * Reads are protected by RCU read lock (see below).
>   */
>  LIST_HEAD(nfsd_uuids);
>  EXPORT_SYMBOL(nfsd_uuids);
>  
>  /* Must be called with RCU read lock held. */
> -static const uuid_t * nfsd_uuid_lookup(const uuid_t *uuid)
> +static const uuid_t * nfsd_uuid_lookup(const uuid_t *uuid,
> +				struct net **netp)
>  {
>  	nfsd_uuid_t *nfsd_uuid;
>  
>  	list_for_each_entry_rcu(nfsd_uuid, &nfsd_uuids, list)
> -		if (uuid_equal(&nfsd_uuid->uuid, uuid))
> +		if (uuid_equal(&nfsd_uuid->uuid, uuid)) {
> +			*netp = nfsd_uuid->net;
>  			return &nfsd_uuid->uuid;
> +		}
>  
>  	return &uuid_null;
>  }
>  
> -bool nfsd_uuid_is_local(const uuid_t *uuid)
> +bool nfsd_uuid_is_local(const uuid_t *uuid, struct net **netp)
>  {
>  	const uuid_t *nfsd_uuid;
>  
>  	rcu_read_lock();
> -	nfsd_uuid = nfsd_uuid_lookup(uuid);
> +	nfsd_uuid = nfsd_uuid_lookup(uuid, netp);
>  	rcu_read_unlock();
>  
>  	return !uuid_is_null(nfsd_uuid);
> @@ -51,7 +54,7 @@ EXPORT_SYMBOL_GPL(nfsd_uuid_is_local);
>   * This allows some sanity checking, like giving up on localio if nfsd isn't loaded.
>   */
>  
> -extern int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +extern int nfsd_open_local_fh(struct net *, struct rpc_clnt *rpc_clnt,
>  			const struct cred *cred, const struct nfs_fh *nfs_fh,
>  			const fmode_t fmode, struct file **pfilp);
>  
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> index c4324a0fff57..0ff9ea6b8944 100644
> --- a/fs/nfsd/localio.c
> +++ b/fs/nfsd/localio.c
> @@ -35,10 +35,10 @@ nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
>  }
>  
>  static struct svc_rqst *
> -nfsd_local_fakerqst_create(struct rpc_clnt *rpc_clnt, const struct cred *cred)
> +nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
> +			const struct cred *cred)
>  {
>  	struct svc_rqst *rqstp;
> -	struct net *net = rpc_net_ns(rpc_clnt);
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  	int status;
>  
> @@ -122,7 +122,8 @@ nfsd_local_fakerqst_create(struct rpc_clnt *rpc_clnt, const struct cred *cred)
>   * dependency on knfsd. So, there is no forward declaration in a header file
>   * for it.
>   */
> -int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +int nfsd_open_local_fh(struct net *net,
> +			 struct rpc_clnt *rpc_clnt,
>  			 const struct cred *cred,
>  			 const struct nfs_fh *nfs_fh,
>  			 const fmode_t fmode,
> @@ -139,7 +140,7 @@ int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
>  	/* Save creds before calling into nfsd */
>  	save_cred = get_current_cred();
>  
> -	rqstp = nfsd_local_fakerqst_create(rpc_clnt, cred);
> +	rqstp = nfsd_local_fakerqst_create(net, rpc_clnt, cred);
>  	if (IS_ERR(rqstp)) {
>  		status = PTR_ERR(rqstp);
>  		goto out_revertcred;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 72ed4ed11c95..f63cdeef9c64 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -473,6 +473,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
>  #endif
>  #if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
>  	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
> +	nn->nfsd_uuid.net = net;
>  	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
>  #endif
>  	nn->nfsd_net_up = true;
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 91c50649a8c7..af07bb146e81 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -160,7 +160,8 @@ __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
>  
>  void		nfsd_filp_close(struct file *fp);
>  
> -int		nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +int		nfsd_open_local_fh(struct net *net,
> +				   struct rpc_clnt *rpc_clnt,
>  				   const struct cred *cred,
>  				   const struct nfs_fh *nfs_fh,
>  				   const fmode_t fmode,
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index f5760b05ec87..f47ea512eb0a 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -132,6 +132,7 @@ struct nfs_client {
>  	struct timespec64	cl_nfssvc_boot;
>  	seqlock_t		cl_boot_lock;
>  	struct rpc_clnt *	cl_rpcclient_localio;	/* localio RPC client handle */
> +	struct net *	        cl_nfssvc_net;
>  	nfs_to_nfsd_open_t	nfsd_open_local_fh;
>  };
>  
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index b8df1b9f248d..c9592ad0afe2 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -8,6 +8,7 @@
>  #include <linux/list.h>
>  #include <linux/uuid.h>
>  #include <linux/nfs.h>
> +#include <net/net_namespace.h>
>  
>  /*
>   * Global list of nfsd_uuid_t instances, add/remove
> @@ -23,13 +24,14 @@ extern struct list_head nfsd_uuids;
>  typedef struct {
>  	uuid_t uuid;
>  	struct list_head list;
> +	struct net *net; /* nfsd's network namespace */
>  } nfsd_uuid_t;
>  
> -bool nfsd_uuid_is_local(const uuid_t *uuid);
> +bool nfsd_uuid_is_local(const uuid_t *uuid, struct net **netp);
>  
> -typedef int (*nfs_to_nfsd_open_t)(struct rpc_clnt *, const struct cred *,
> -				  const struct nfs_fh *, const fmode_t,
> -				  struct file **);
> +typedef int (*nfs_to_nfsd_open_t)(struct net *, struct rpc_clnt *,
> +				const struct cred *, const struct nfs_fh *,
> +				const fmode_t, struct file **);
>  
>  nfs_to_nfsd_open_t get_nfsd_open_local_fh(void);
>  void put_nfsd_open_local_fh(void);
> -- 
> 2.44.0
> 

For some reason, I received only patch 30/29.

-- 
Chuck Lever

