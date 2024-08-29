Return-Path: <linux-nfs+bounces-5976-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04799648A7
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 16:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578AC1F28101
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1C21B011F;
	Thu, 29 Aug 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P8ehvSpN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rr2/oucE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EFC1ABECB;
	Thu, 29 Aug 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942245; cv=fail; b=lFR0EWpYq6OoIcEdMsqLL4QBrbYiVQNtN50EgF8WJsVLteuW05kVfCglUHSm7lh0v+7TOwEHILUSn0/v/Swiact3uLf0U7UVA6Vyji4gbMt9AeLduO52hZ5btPDKGfWLWPDLPPKpZOgVKeZdQ8ir8A6zVhCrglIKRd9aoaJb9lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942245; c=relaxed/simple;
	bh=Y82rcOTtN95RfIz/bI68TeO9XVqzievkaNRuYdeP8qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z/nXLHZqqhPyrysVl4RzQksDo7w43IZacDFk1cL5iVkk/znzLRKSkSnyNXI8BIdYV2agSgbBxwhxoezV+95LkBNY3Ue+yFpM4Mq3OjmHug6bkfTzzVawKTfLZG7bFPUlXd+hJtVatw7VudeREHcxrapPk7Vjb4ElQrnEitEYioQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P8ehvSpN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rr2/oucE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TCaDKN012332;
	Thu, 29 Aug 2024 14:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=O89NSeKYcTmx8Mf
	8wQIOM8T0x/NloovgYl26y4mNoCc=; b=P8ehvSpNAUaegtSpnu7DS9n8mpNaYKB
	47AksNoKwb7dmATR6cT/03/A3Q67dFXoIRdh/sIaiaoo/4nUIeh34uRdhqhw28QV
	mCLQJvCgknh28umd0/W8K6AmTdx1t7aKbICBrwf+gvo3Txe5+zs8usHNqevKXuhY
	QatlhudOVX2eew8uZO0ggL4C2m0d9/nDXS7vxTSanhpgqCBEf7OOsFNtCTqIJeQT
	SVTZv6dAQBInNUFfj+H/2s26sEJW1E7qY8YALcpfFnzCqtfAWtLIOwoqWdPCvl8v
	Kqh3KcURK/LrE1ey/erzCCgFXBFD0yn/pN+1HrkXEQJg55HiV5vyDag==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pukm8q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:37:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TDDciC020095;
	Thu, 29 Aug 2024 14:37:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8qhy7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:37:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IacY/koWNBcdi7YRpTbwmMN1+Fgpdv/XZYuUOfWJ4gEeoy+X3AxWjv6qFEguDOH8hl7HJmUxVNF6NqeuTZTf7MrQOVMy9lRPuEBrP2fiEFoPuYJEGwJaZU5mYbUM0fl/LPHdXzM/Pst/RbXhkAeviFy+uWIZ+tvOEe93D0eoqldyiEjmQIp6Gv1zktU8qeyuSRki/KEKDjYcJXwp4h+f1gRnElisRUbfVMm4j5Yp1ke5vtimYtkt2QLFGLGcvOgmrQhp1l9aVkxspPfuWMMDibs5idCMGTFkQhmlcAffB63h1NAzbMaZAoKujQUpFQcDQbcMwhsqn4BHBewTpFvz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O89NSeKYcTmx8Mf8wQIOM8T0x/NloovgYl26y4mNoCc=;
 b=Z0+uFDH2I1FrCBYRBgfNQQw8rRCYh0/rzifmFhvutS8PVpBx0jWDIFt0uTCJzjrOkw1nQ8NiV5ygDLcP9bsfw1t42n3yqmDmxX2q+7nYnUx2Hz6PmRlWThNTnK/fZYbbVme33dki7oZVkM1oQGH2Qo3ROw3DGk4ZRxaQQbHxDu0I3lna2o94bCMN0FahyWWERv0pV9RRs0N7TFvfBHlWgqgeEpFm4z4Ni3PnGflV8ChDU4XtzKGvIIaZBKGD/fjFxeLA/buMdxe2TctQ6hkOpKOd2B86qp0bqg4AmXDqr0bMrX3BZOtX9gWQlm11vqJLgG96n9jJutGQhwvV0h7TDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O89NSeKYcTmx8Mf8wQIOM8T0x/NloovgYl26y4mNoCc=;
 b=rr2/oucELp3wzQpF/lRDgTwzbGM7OWc9cVTzny8CqR4izQsvfBzrtvlgFOVI6wM6g0Ed7jAjmafchTKRbKl7d4OFTgjfoJpBlNJjYIMMFT5JqFSfQ2KBZOxfhha5H91OeG0FPf4LweBn8xwXM7m9RYh5OiqU1C8KqlbwP49Rbfs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6420.namprd10.prod.outlook.com (2603:10b6:303:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Thu, 29 Aug
 2024 14:37:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 14:37:12 +0000
Date: Thu, 29 Aug 2024 10:37:09 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, kees@kernel.org, gustavoars@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] NFSD: Annotate struct pnfs_block_deviceaddr with
 __counted_by()
Message-ID: <ZtCHlVZSea/M7oHT@tissot.1015granger.net>
References: <20240828214254.2407-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828214254.2407-2-thorsten.blum@toblux.com>
X-ClientProxiedBy: CH0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:610:b3::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bae3ddd-b6a2-4348-6b4b-08dcc8381214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4uUcRmUPIkzVk4q/IfXQbFBmG4TIvkmNwix2UvE9zlzESzzZyOlWNefP5Cmx?=
 =?us-ascii?Q?eanHweQZnOIj1EMLPxuGSqLxNi4h0lGMgrbblwG3mNVzgCeuaToXwWG0wYXC?=
 =?us-ascii?Q?HpJMD1S0mR34WSSG8a/dyz9xjzPmpd88Syqt4O/WFKCTxFx1XZ17sDaZG4LA?=
 =?us-ascii?Q?wPj/wJ5GS3DZvgjbyXs8aAmbTMDvZJlIBnX1vMwkDedT4GJPGLPBYJ6xCoJ5?=
 =?us-ascii?Q?3ooGkMYd5zkYkduYPmjNzRp7SE7O8tJKY43f5EQpuT3S6bNmhOciaMLHUv3r?=
 =?us-ascii?Q?r/NoYqolxUup+OiIPcMN+4NPn9XCEGbKEorRk7a0f2cOnqW/4J+FmiqClG3O?=
 =?us-ascii?Q?I/V9nZMLZn0R9OJbofH3WFChaqVZXh+icFl4wJtbtUPHaLQtIENyDgu4beL5?=
 =?us-ascii?Q?YIUO0oTrB77RVtKeKuBvfG0UxNS5UVKVFelbCRpPv6OD3xX9hQYO7GTzewIp?=
 =?us-ascii?Q?Iz15BmAOG0IhSBY7ZPl3v7U6a174vIb4uaBL7s2RHTBd7R0YhL//DnKg6N3P?=
 =?us-ascii?Q?CB3Z7ZXkumsS2icsyyyVwMqW+eeg+FuenWtDznPXYMQzX2S2S2g+e7numfKn?=
 =?us-ascii?Q?3Y9+NaRdhtvSjUC9OCvV33FXnBCzeInbm95n7kFmfB3yzL81v8NPdrvr6K3m?=
 =?us-ascii?Q?pRvcG/veEz1/RT5xlRaoJwky4HHCIt42WubmH8LjEwN/zEH2hN6lZfoqdF85?=
 =?us-ascii?Q?llmTjzRScBOqaymXsHqQ/8y+qGsw9JP2R6z8HwkgE7Yv7hqeRsFyd0biRHYw?=
 =?us-ascii?Q?U848vrHXM7IZFFdHV2QpQPZrmn3nEQxoSaa9K3OznvnPywCxUHDJDBR0giJX?=
 =?us-ascii?Q?HHflqQOgFf4mi9g7C44sHWF8YxWfonH4Any4dZ88uX9+CMPowf7QvtLjZpSQ?=
 =?us-ascii?Q?nKku+klriDDIt0x9p/rw/f0vY4UldH/XLLrvw2V/5tKTCLWS5WEHPPD+7t8Z?=
 =?us-ascii?Q?jLIyrgyzKUce+qDcCqGhZp/xt0PSThCH6ad5QHZy6D3scgztka3HZYKvEgFV?=
 =?us-ascii?Q?tH+64aKXrgMx2lKIJ0mPwwj+lb/Pr8KGTNojodm7Fm9H9Oeeyb6GsQd/PPaC?=
 =?us-ascii?Q?dfX3amGgSTNsJ4auNTJFhlHmhSqLU0TKBNLeIza1YegeFjeVAYCc2AYZB4q9?=
 =?us-ascii?Q?fiZJEdMfGS8y0PJYxoFlEor3GQ2jNQ6NaQ5LuYuujjiwlwqRux+XOtivRwYe?=
 =?us-ascii?Q?PZKfz6TmjqMV046k1AA5KecKqYFJ1bXWi9QKJ0XaKLdly6NkzkvTP0xbZ2px?=
 =?us-ascii?Q?Jq66d81JaU622ksxFHdX9/FWnpsFSebs7ObzPwdS7HNMBad6C3YYJonEhDQI?=
 =?us-ascii?Q?AV7U3i+lf7GI/Q9dWs6OZLwvbgX9Bwr+yEEhtudCE3F5dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kK7T7L990TUuKEWiE/zVB4kI5KFaEKpyAfYj+3NuuAXcs4f+CF+t2vVCWD7k?=
 =?us-ascii?Q?BA86xx3irZ9el+cwoonsaDu7I0EDXehEXqojaE385LoplFH63qHTTMXmCmEq?=
 =?us-ascii?Q?ZgQ3bPxgFWy3oUxOOMQa4iCgwxgWWuEnHLhUC2cjOq5v1Ml8+fwVbJVuI7HA?=
 =?us-ascii?Q?yb4luFp0LTiCWlKLpIWymimXJwhwz25sYWp5YS3EDzWv6b1JOhRGSwPawh5j?=
 =?us-ascii?Q?vBrHgSZpoNUxIGWg8tgMGaEl/fD3KC2rSKtLNqmphFGO51muEEJxSDlZxsXi?=
 =?us-ascii?Q?kIkqvmCEZC2EnzHk4Jtrex6n03QSU7qKCDfD8Z+G5CkH6Opuco1pQE/Qz6e4?=
 =?us-ascii?Q?9vVXcJb8A0PefJHbYgvq1M0BQeo5PBuQhNq1BvbjrlHvMBFcXKxRkQCMsXUB?=
 =?us-ascii?Q?jtudoz78xxeAXYBMJY2HLNLBHBHBe/V8Ge9VA5osHGTotEpo5oupp4jp1/Ci?=
 =?us-ascii?Q?Juaj6AijDQkmdz3gcBlbHDbIPxHIycwPEJq3VGi/vNkjFlVO7w6UUpJ8QG/a?=
 =?us-ascii?Q?JieD9m6r5XaKzbdA38xcXDpxuPlkwG6RUzqhEFh4IOOAjUB/93Jp7lLdLp9m?=
 =?us-ascii?Q?PBEBBau2NqXNZrRCj4SnrYMGxpsNCgg/F0wojbN42+WfmYZzel1i8+Gh9Rl5?=
 =?us-ascii?Q?RVtSbN80wuzoNMe7V0dhsZfRNPXieWJtnRHYfhmIDimQlOb8E7U0RjTNqemD?=
 =?us-ascii?Q?V5VtIviD4xyV7g+RITRCSGO37ghRwtXY2xXTTr67Thi1lIAZW1m2AiJ24+96?=
 =?us-ascii?Q?lHa4vDq9WQIiQuFSNr5Hpo5whBg/oHY1xR5KLJFvencjzhuEXqsD7Y3nMaiy?=
 =?us-ascii?Q?ZIZ1GSIawhu4CbV/we6sG36/Zg27b6kYJiFev327h63OJFVE2IGkE0LMZgoT?=
 =?us-ascii?Q?gIdrskDXjVT0Lj08rRW0oqru+PGa+MmOyff42fqZNoZcntII/jD+PmaTr9WZ?=
 =?us-ascii?Q?1BhnAi4Ov8bR19UdsapHgG20eCqvrJEQNObik4S4861SOjwnj/aUx8BJ/H6H?=
 =?us-ascii?Q?mSaD+vZH3GKS9ZSCEIz535oRVCz9QQUtsTbHwvWlvVEjUuo51Bfk6d+CD3Fn?=
 =?us-ascii?Q?+d7jDh+ixYMcwd6UnaPVTL5HSxsHd74a711Aszoe8sVH1vbObfIjy+7QOxdy?=
 =?us-ascii?Q?qNZvMkoHGnwdTZbRdX8fjmMajkcooAH8kVjuk8QUfMO4v3Qdqz5g8/fD7mfU?=
 =?us-ascii?Q?Edx0EwtpFxprfNkNFA86vG2TbrYT9LZ3ThU8mDb+6do3O26qUnj3lO4HZJol?=
 =?us-ascii?Q?ndrZZAjIyRQWfdtsGiAWW6FPGMMDunENKBYo6nX7XbcDT7G8mdkvk3CNv2FQ?=
 =?us-ascii?Q?zEPqMDNcaXHmCLjce+tIh4R51iuCtE+Gs5cpO34klb/aoX2YV/puXiUrvJvl?=
 =?us-ascii?Q?lkc8Yoa6yO+bq2UVAXotfZ/C3Ku2y0ChzbJfcixePkgjVZ1yUIz9kGCrykqn?=
 =?us-ascii?Q?vvQKhlvsKh3qGvg5rTylOYVk8FIPW9X0t+5eoH0kfY7u0rzfqLQ+w8Lr11FG?=
 =?us-ascii?Q?UIOYnoM0ZlVVzQEXS3s6QE68Bijmzh2EwensA5rN0g1USj1OHu21k60ovnAt?=
 =?us-ascii?Q?xT4ZgI4qOzcbBUSGFf33pwXUCXDAdy5hPnAYrZRvqkJini1PvtW0JN3sRLYN?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pVCJ9AaN9JesJ1cGyea2SdHu2Jmt4UURubQo90Z2nY5gygoG0rUhwDuFghBdQyKodw/FDpSjop9ngdrRr2cQlSRK/RtqL2s0GXsIt4qFGyVgRXvQx/Jv24944fpMVVCVQuN8FrM0UqBIVKj53vl8Z9Iij7mQzobago38eEjeua+tcVvLyFeFQPXQTviHqk+Exd8/wOkjQtY0R6F9Uu4gQKpPsD2antAeJvluq1SJYSmCjzaT2aHiT3RlrBtl0oHBaUXfwYDlB4AnEt03XFclra6U5Pow+xrvoFSxKTAS4uPKVxrhn7u1DINoV0nGEO2F59AQlKB/tZ6qw+Oakk4rZ8XiFjQzcHQpFM8ulOB55Wvg4S2NYGHlezEn2l641uKMEDJw8AOjfGQB0ijF4JPwVuau0V8ZpqgUG1WRRpw9Wg2VQaJmDkKT5ZwO7fcaLKS+GndPaZB0ky55x+JTf7MUuh3uApRDq50uvRnMOfhbS0wqfwYH9cg5bKoeRqkao1YwpcXenq4P5l91nidL7fGypYIIkPlBBozTb/fMbKbuoZxFih+qXgHjp9XH3g2II9NI+RycDR0PcGjiXzzbYsxeL3uT0Z74RqDtOgnTIQhmeQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bae3ddd-b6a2-4348-6b4b-08dcc8381214
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 14:37:12.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LF0y3xkQn6Ot+xRDxW01yrOqblK04qJxQo178PlJ/zwq9wrR6T9QrMTFj0DGzWcKA80XcDNhqyF8Wx0cCxdjbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_03,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408290101
X-Proofpoint-GUID: Ug945decQLARO0Fh2RiRDgkb12TRSvqy
X-Proofpoint-ORIG-GUID: Ug945decQLARO0Fh2RiRDgkb12TRSvqy

On Wed, 28 Aug 2024 23:42:55 +0200, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> volumes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Use struct_size() instead of manually calculating the number of bytes to
> allocate for a pnfs_block_deviceaddr with a single volume.
> 
> [...]

Applied to nfsd-next for v6.12, thanks!

[1/1] NFSD: Annotate struct pnfs_block_deviceaddr with __counted_by()
      commit: 7dd2311b21ef121d0ce9f9b2e56d3e42b2534991

-- 
Chuck Lever

