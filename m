Return-Path: <linux-nfs+bounces-5421-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A25955317
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 00:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB181F20FE0
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 22:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A299143C6F;
	Fri, 16 Aug 2024 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NV/HAfmw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HzK5nUUm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88CD127E37;
	Fri, 16 Aug 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845982; cv=fail; b=cjnpoIBEBBkhS1Ebx3l4RrRqEL8Vfjfd617huUxcNx0hFAbMZDDqfw/mD7qVGS+LMAvVEh1oS1+Z8pdpkQXccf3T2CSktdNN/WHeu3scPaohgSdG2UPoOFTLEgLxVoUJIR/JvNFJ/LAf0YTjPHrKoJJM3MX4U+1TaLJxexG+42E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845982; c=relaxed/simple;
	bh=CZZKjJjJuiiylvAGQTbHHcne2q+Gmr8EacD5wAqGeeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KmcRSjz8+w+UMmLVQvGNU8oE8Cj8wp1hWDH70fHPyWVm98ye+NWI/ie97bqtGXg2SGQg9E3U/+pBEOU1+Ix60Ysr9nnNryOzajbXszM74CmdbURMyT+cEg5GXEuTrqRyCNX8CHd6WtTmjOpveaKbwBuRr7Fk14OPJMmxCVEC3OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NV/HAfmw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HzK5nUUm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GLBti8027085;
	Fri, 16 Aug 2024 22:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=+l3ZoOESN4UNARCV+Z5YeM3dQbEI+2heGLvI7UW/hwU=; b=
	NV/HAfmwk03alosD3tVD3D9UQKFx3pO586J182cxd77BF5tD4274xwC6cN6ixGOb
	50WZcRe+vRNM7uBNAmULMw1QEoDZiBOuyr5yxLHkMNpUFEMXWBUCiGeeeQ88mRbU
	VxdDX1EOQm+LjN8Hbk+UxqFVaCnOjeZo+bLK3FvOLjHxnArnaJwXe2cAxp8PUDTk
	9RFvEArjO7zxETUr6yOOnpovpDe/OOMklwxF0RNrc7QJ+eIe0nlj/LNTmj5iDf/o
	5/oyrTMFhesPIHke1zMdnVu3qcJNMyF1bRHBiqIYXyA4JyVsvz9PYTk48Hiw0hs7
	VEOGBvzkwPSpbBJh/ij5UA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wyttngvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 22:06:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47GKKSmd021228;
	Fri, 16 Aug 2024 22:06:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnkdage-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 22:06:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/1e6yA4cfpnF+sZkC/V7tXag5liRJOeLWu1Fu0nh8gAzbVy21wUleC6nBCwHP0v2GNiuSIgSanIXYTMyDgCRvgVHcW0/3P4Mhw+hPZiWUJbOBAW71wCkD0Q+WB3kHDjUx42jFKS5KNGRbRwLJ6/zC2WT23H3gR+3upapEUq91toxLL24HLiGvkP++CjGZ3f1bJ7VYOgr7CYRmP8FJLMPtVjwPUoXKZaAWbRjF4+l4F0xJDvpCF1ng1cVLaWLld1OoTZ+pQ/5qdkaim07pesvz6AqfHRSLuaxzqVgiPo6Q0j8Cqj/jYzaWp+VH0igMVDNWieDbu/OwzT2AeJcMVnkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+l3ZoOESN4UNARCV+Z5YeM3dQbEI+2heGLvI7UW/hwU=;
 b=egaNWPxyl2gn02BnHa3FahT2rV2KFP4eVbt3U9UlMtLoPa4oPW4278VKdWA1TtBMO/bpiHYjIF6MGJ/mJEMHJAzhYNyt9UUpmyUIemDPOnCJEgEHwU5YoSVRoyi2S5fV+JocP6DFzI+WF2L5nl0znhq3Vpimt7eYbq8zE5sY1INTyhJNx/wzg2BNROyy6wNwRzBrrPtwmQiK5QYd3OAoHN6vIlUey73WMJSi5MkY86s6JASRtrW4KPwat6oRaS3OlJiR1rBh+B2D6yns18+yvZZpmu9h0srMfHQaogXJI0WSA7qS4Qqc9RdH1K64zAD4VEUpiTaJkuC8H7k5bIX8ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+l3ZoOESN4UNARCV+Z5YeM3dQbEI+2heGLvI7UW/hwU=;
 b=HzK5nUUm9fAU6YlyRRR6+EoYjGwLPSehQuScw1F4bQddz2titQolJBZ6gBbtifmt9DW43XpKic5a+UBDUw4esaVl9m2hLdUGPDUQOanLtS1vuD5mCEyN0xYB6tXY9WBJfVwKoTP6R636dw2IwLBo/OGDmsP4XNUEk8yx1z7Xpus=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA1PR10MB7683.namprd10.prod.outlook.com (2603:10b6:806:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Fri, 16 Aug
 2024 22:06:08 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.7897.009; Fri, 16 Aug 2024
 22:06:08 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Tom Talpey <tom@talpey.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Dai Ngo <Dai.Ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH 1/1] SUNRPC: convert RPC_TASK_* constants to enum
Date: Fri, 16 Aug 2024 15:06:00 -0700
Message-ID: <20240816220604.2688389-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240816220604.2688389-1-stephen.s.brennan@oracle.com>
References: <20240816220604.2688389-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:408:ee::33) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA1PR10MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab0fa6b-7540-4064-80d5-08dcbe3fa17b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aXEdwxcQGDiE763aODYBmHgVP2vgtSSe/f350FaaHYc0zIVmTHTf5UhC4jEo?=
 =?us-ascii?Q?y5RrJI6rUuS3sOaM/lpmQX5cM3k0JrP2/KkTN2Ow1flnROF30VsS8NBk5oJL?=
 =?us-ascii?Q?Lx+8eRMhKCL7x/w7BJhIbe5oDya2LPeam5CS6EttEh9jCvwEUcIIX0khXK7u?=
 =?us-ascii?Q?A3pKCeDQJE/RoJhASOW5XmeadDOTTgWUJAH3AO7xGXzm7ZqC+XuSuBVxE90Z?=
 =?us-ascii?Q?AtTFJoACZfR3Ute27a3mDpT4FxuS3Pvcb25PpRy0GazztnDQGI0B2R5F7tUI?=
 =?us-ascii?Q?zg2xaoAzZiicmTDvDBHt3/Sn3gZfqFiQFaYiLev2JRZSsj1MQ9DwWuLhjntS?=
 =?us-ascii?Q?n5+0Ghe82zhwLclptc/4KWnMw89DxqH0PnncGqrV4Mtwuo7q2OMyPZLRfw0M?=
 =?us-ascii?Q?HzxlFhqmsz0Xp3QZ/YjU6SIXmZjyL1owEyeJwUdd8re25NqiJvmMvRyjdcyp?=
 =?us-ascii?Q?ZqRPn3fgaInGaaBS1NKtP4plnkugNbyOjORl+WjN2xgVHZRK2qo00VOkptrD?=
 =?us-ascii?Q?vvC+wvqZmZGY44eVnbVTmBlLFWy7Mh5yCyLHnv8MXa0SH9sxndVB4CRSFT9V?=
 =?us-ascii?Q?eDD9on/0FUs8T7YqgYWRHapNj3RbmJWZuXkg+aGI15Tw2sqKU8RSWbrPooMr?=
 =?us-ascii?Q?wXT/gZN36RgajUyB4Wq6LLZ+4HMCPowca6Ythr+jYcdTlTch64+1h4M1bG6X?=
 =?us-ascii?Q?YY5/m1l8rnzu5cTWIujTM3VyoUkSDhIiGLsyM4ZDKRLag8ey7ulyoE/IIyDr?=
 =?us-ascii?Q?qlWz5EtoeBxShkH1NYQP1uXmG4j08/c9tRdYWbiWN5MHK2b7oOwj3+jnTLZ1?=
 =?us-ascii?Q?z9FnSvJtPpKGIdB0Qyp97BuhmmCQ+xgYI9nhFVnqGOrkggIjNDrazxrfDTFS?=
 =?us-ascii?Q?BMjK584sWFePoueresLLkm+EG+6JJE8Q+czYtzPtW37GiLvmEKivu5LFy/G+?=
 =?us-ascii?Q?uHZQVHRQuwHXfUGZJZRQeTqMVJiqcahfQabUCe5QzA2wec0UnsKCbqOEcJ6B?=
 =?us-ascii?Q?jy3Q0y3DodWQHnQ58gKFxCzA8mcwbWtpfb79pj5bBdKrbPnOOEHhpdm6qTan?=
 =?us-ascii?Q?jlsbR3gWalSmnAjTcvKLJx6FtuQFO3mC85ErA0m0ETUdra5fsX5uGpPRdMpn?=
 =?us-ascii?Q?NV52CX0VLlUYd1ZFviSxdSUgvRV0tcpaeTnHvB7Q1vcu/0zATllXMe01gJdI?=
 =?us-ascii?Q?7FgdHuKOzxTmMyLBgHv9IBDhwg5ThxNp564OyDlrt06a77Cd/3Wmwtvo/KyP?=
 =?us-ascii?Q?Lh86TmNZd8zTywOfjZpt7RyXjNErTJCP19iGwXqd0mWA4VXOHYNKLh0ZMaCA?=
 =?us-ascii?Q?TlRRhX2EkYI+wbnPYgLtuoTBAcqUa6QurgS2GcCkJneucw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t2P7mZjwhzFr/CpkPt82NwcOVGXDGtjxAufzRQT3FP8GLuaRlrl+u/ztoKmm?=
 =?us-ascii?Q?nh9WDjgzIJr1bYAYN+ucuHNctBFAKrD9ExyIYs38Z3FlXx9ZgapLgYWQG6UM?=
 =?us-ascii?Q?R0690rNZH8yzgZ2fun8tlfakl8cDBvK6DrIifjQRiH6q6ZLOSwvKbHOk+BsP?=
 =?us-ascii?Q?fVkyXQYjE/KfwB4B4t4j4yvtnSGk77IJ99BZGx7CWXDxX5Lw1+Lfs1KoZYLN?=
 =?us-ascii?Q?M43djN2FC0OP9CwXxuEekK5t1dDPm6v+/465FLHlYyPmqOLL4jB80I59wP3o?=
 =?us-ascii?Q?C74OBHoaq8TuYvf3BWc/hcN/RVPAobMHxAN8Dt6yjerx5b5Yy0rn0KPlKqV2?=
 =?us-ascii?Q?cyJ/bgVEdAauYrIj9s/GDzLitPR6Pa2w91a1pwFH7iIszyEVZfEyu03zTmwi?=
 =?us-ascii?Q?ISIrPfiuGp25oHkXTY4wJoTtWu9Tl7nn/maziuRL0YEofFs4btZRQkSsvDeR?=
 =?us-ascii?Q?0bfhH8wufCmDD4nr/CQYR3gu8peAYvtHWh2eywJ2w60v3pFsYO+bVf54fiY4?=
 =?us-ascii?Q?y7BWNZOk9wQdzB3WfjeSUVVfoHF7JHS0AT8tQIMImIHm/ob7v200gYtMxpmr?=
 =?us-ascii?Q?+Crsk4Lh//FlDMQnwShEqi+hGTajVgv1g6xu2AkZsO9jjk7sn+ud0JN2dtqC?=
 =?us-ascii?Q?7p0SE83epjqYai6An5J8+UGb/luQjNhGQg1U+UnxTWWzzmNR1UYWBU0+zvkb?=
 =?us-ascii?Q?IlHAujzvZEmv7YM2KyndFIe1i+rJ+5wSW+ChrgnxOeYxRaOxRp5kC1bb7c4e?=
 =?us-ascii?Q?ttCxNey8ZxbwE2R1y44EIqUA3N05YUxNvRpPgGA5t3ujCP6RFwrk8ss4o8eu?=
 =?us-ascii?Q?hD6VTUu4j9kkaayVMC3rfmpUO6mK7F9K4IjhX4VQWXDR+wowi+/gHqJ2gFk/?=
 =?us-ascii?Q?By3qzRvKx/vGZl1m1oIcfM3PS3uh4wXozRDh0u0cilvK8FZGDTqkoUXOQILg?=
 =?us-ascii?Q?57LvTgdKu3Cv/fqAhTwKoAu8ecNumbg1s5S6/3mLXq9Vin60ftKSswuYFLRg?=
 =?us-ascii?Q?B2KVMdy593j3ef5eCF9JPFS2zim8enBWnYaaer3+RDYhz8MTJ5CbgSJcnxDV?=
 =?us-ascii?Q?gRQtQ6nyNultNFzxhBcrr97EywBmHlr4Q67Y2z/V6JBU9ABrgjynzGxVRLQv?=
 =?us-ascii?Q?lS+bfcwaujZHlQRFFQ/vALdsOb+/swA+AnHOR7yECqaQKDmCX42fpwa5ShXI?=
 =?us-ascii?Q?o1FMsM87y5P6fZgqQle2Sb5waaTiwbwEcZSCA+g6iyGXaK+baraGVqAHBdIp?=
 =?us-ascii?Q?/atxuqCJ5pDu4pO/iitUftvKacc9AnbI2slBekOMZLl4Ew7/rwgDHs28mkjz?=
 =?us-ascii?Q?lH38agHEKS7LWGgveLijA7PY0kqJYQJQI/QEy4mUinhyrBrcAKHzt1NDkNYN?=
 =?us-ascii?Q?l31rfmgXotqCkzShUf9x7cb+xiuMbUSPaaWu8MRVtKWkTn/OS5hS0nHXO8qf?=
 =?us-ascii?Q?yRYk7iZ2W6Ke6/sWwzpU2t5KBv4bjwcRgpJiC7PBANMzBSGK9ASof8Qv8Spn?=
 =?us-ascii?Q?och0QN6dxIwnKNDxv6V21YSfr0UM0y8VtgR6LLMzqS3QWRfWpmlM9X57cM8p?=
 =?us-ascii?Q?tYijTuHddvdHXhQhVc36eyGfhBMiafKRxzmu1FC3cULo8uZN9CgoA/ZEjt5/?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x5UT4KQ0xeXkVtQXeBEXZobbqFt0ssZRl1tzAY5IabSo1UP1ydpIOa4ClthIq+WkQ93gB06KsGFSTWn4rAWBnj2s/QcxSr3NYnSmpKqNMAXP+hl6J8VFp/hZC1DTk8V/yIBzqdHo/VvYWzLQUOZobEyDrg3HfAL6W4qHYC+XjziZ/NqxekC7tFXGHkAg2R9RAAKEq3IqnL3+Vp4ffYCUCn4BLDPkKTRcYGEYRp+5ZqUvKR+oiAJ9mM6ujr6EwHeXq9XPfUYjIB0Az/d/S/QuuV6si6mDdnaswHz5Bkn3jvxhA4gPsIPdSM3WzcOSEA1TGSAd8L+YXDSmZq9oUEoSEB9eGVSTXIciTgp2FOlLulJap1chYmT6xtkAE96EMiG+J8OMCEWqBoCHopx6KdHX+D4k4a0bBzCxpo4n0tjZE9YokiHQtxNyXEU5yTSbK+Eovu3oWFVoSJ9bm+RThb9NC7ye3BGMrxvCH5gFnOqGD9YaFNa/Dvt4zfvJ4CO8N2Szx2V40IsX1P4dK40xxkFzdLMzXymzgfaUXmQEaJ5NKhdrjYpTuBxBiM9QJv/71G1jyDvnDNYZLsTVArj+5L/b3zj9Fta2k6JauRwCqzECttg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab0fa6b-7540-4064-80d5-08dcbe3fa17b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 22:06:08.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1POfpwRlTZ/3ViaxVqOoazsWdN3c/aPP0Gx7z1tyrwcNkvwZM/+FoR59yTpR57nAQvOdFVMq+7gdbRpzbLR/8/d43L+j3mbSmwpGzULLbCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_16,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408160157
X-Proofpoint-ORIG-GUID: gVj9vEUgL3sQam5VG0WOUSer5-ns4znQ
X-Proofpoint-GUID: gVj9vEUgL3sQam5VG0WOUSer5-ns4znQ

The RPC_TASK_* constants are defined as macros, which means that most
kernel builds will not contain their definitions in the debuginfo.
However, it's quite useful for debuggers to be able to view the task
state constant and interpret it correctly. Conversion to an enum will
ensure the constants are present in debuginfo and can be interpreted by
debuggers without needing to hard-code them and track their changes.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 include/linux/sunrpc/sched.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 0c77ba488bbae..177220524eb5d 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -151,13 +151,15 @@ struct rpc_task_setup {
 #define RPC_WAS_SENT(t)		((t)->tk_flags & RPC_TASK_SENT)
 #define RPC_IS_MOVEABLE(t)	((t)->tk_flags & RPC_TASK_MOVEABLE)
 
-#define RPC_TASK_RUNNING	0
-#define RPC_TASK_QUEUED		1
-#define RPC_TASK_ACTIVE		2
-#define RPC_TASK_NEED_XMIT	3
-#define RPC_TASK_NEED_RECV	4
-#define RPC_TASK_MSG_PIN_WAIT	5
-#define RPC_TASK_SIGNALLED	6
+enum {
+	RPC_TASK_RUNNING	= 0,
+	RPC_TASK_QUEUED		= 1,
+	RPC_TASK_ACTIVE		= 2,
+	RPC_TASK_NEED_XMIT	= 3,
+	RPC_TASK_NEED_RECV	= 4,
+	RPC_TASK_MSG_PIN_WAIT	= 5,
+	RPC_TASK_SIGNALLED	= 6,
+};
 
 #define rpc_test_and_set_running(t) \
 				test_and_set_bit(RPC_TASK_RUNNING, &(t)->tk_runstate)
-- 
2.43.5


