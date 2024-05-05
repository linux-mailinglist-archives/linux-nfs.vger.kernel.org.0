Return-Path: <linux-nfs+bounces-3162-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A7F8BC328
	for <lists+linux-nfs@lfdr.de>; Sun,  5 May 2024 21:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61532281420
	for <lists+linux-nfs@lfdr.de>; Sun,  5 May 2024 19:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605E527462;
	Sun,  5 May 2024 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ViitjHzD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sToxUgdv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44071DFF8;
	Sun,  5 May 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714935641; cv=fail; b=kEtojp6Ca1y9AJdBsfRvFMDRIPZc0EWyrVdUyWaGyyVzKvhJNn6b4+lcWZ52l7nit7J5QN7eWttC2IxFp9CRg4wIbe7etuMltHv8bSHnv9tqR//p00VhNorN4XYrGWsRgCzSf1s1Wia/Zkzo4yr0nKz5drlwUIn41C2GUIt1J/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714935641; c=relaxed/simple;
	bh=iZk+uPUltvr9aaTQACLCd86V+Igmgzq87OT495QefIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hrXDDZnh08cl42g+q5gPvCrOUITEKS1H1Pi394OcAZmN3lZSb1/Trz6mlI8owlapyoPc07gaanE4T5t/qpelNyFYjN3x6HbnnXgbEYvw/l17vyBVeIA7k3ATNX2yvr8jhc8U2lWnanmeoF5s5OT4VNPnQV133zoPJziCbtrzz3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ViitjHzD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sToxUgdv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 445H7dYF016874;
	Sun, 5 May 2024 19:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=oNJ5kiWnmPsMxLfE39nXw2cV8E1CasNP6egkHbPhj2U=;
 b=ViitjHzDR7NCEOsfRshdqgBq9CuJSVpb4C0AUSHX0mivHiH+2Cp4M8HWbNoCKu3LyoCX
 yN8GFP0SZbLcb2LxLLx0jPM7vzOc3l27/RdxE7zQnFWxLEXil1g7S5hrFjoq1vX63sAc
 r1OChWD4o7uFYIPQX9vyb8E0AnR2wSLvk0yzwBIvesOdFWOgXKMkJk/VzHtR4jkTeZfH
 hvbNda8BPS1YIkCfQUNNACkT9Rpzq9shEz+uBO4RasPaY/+tKyzet4mbT7XZlSjhc0/u
 Sn/bpKxP/cBbhgfVu0wsyHRa82tgj/6TEfEMbWb2dSPR/bkihqT314NajpW5VYLzLq9Q iQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbm5hft3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 May 2024 19:00:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 445F2SRG006910;
	Sun, 5 May 2024 19:00:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf5ub3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 May 2024 19:00:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fci/B7K2mArvRKy4bmoxL5FnODcNSxDg0L6/tfloP9/mSlatNTPSkZwEqOxoGiEXV8SqYb4/aWERAPPtzFdYMcv51PhpfKvuLCOVjExx2G7ITVaEu/BNSHeVIRh7BzV9aDpphVzGUWuddUFiUca2Mb9If/o8gl7eS2/+CZ+xCzKelEpjtT3XflAWt0Xk1C49ldrVGmsX94Tse1mEjD3YsPyl2spPtPBV7HA8aaD7QyzMzU9JINucytjJUJED+uZ61gt7vUvgE8appFUNEJ1VMaoM4Wwn0nTni0sH97WcClnqr4mTf8dTS0lUCGif2IAZ+5f3DMChxrMg2o3sgQPyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNJ5kiWnmPsMxLfE39nXw2cV8E1CasNP6egkHbPhj2U=;
 b=ENe5I4z1UFoP74vlXXcP/UgoUwrKPyM0QTMF9Fk5q4QoUDFPKTQtOYyeLDS6bl2PRSRcUOyEC8CzvBJ3ph5opCLA9iKVVOxJO0HGIWpRPDuc5vLDDtptmHdaFPzNrhfDEpzaSCl6f3EYCpc64Ucd6S7h/vfN9LR6h6PLe4Q1bBDG7qnYDvgrwkIn2LkKwryFh0JrHJwVW4PxfiUn4d9bzLSBg1GUAuFCy+cEi9lsSGeye925Hdc9nad5r0HkOAARj8aGNOO5XYrx7IIEa8aYgdmPWhgf7VTELdqrnPqJUEkjBOE83pLjxK48Jd/WO+L39ibwoVGS6zunOs7woATFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNJ5kiWnmPsMxLfE39nXw2cV8E1CasNP6egkHbPhj2U=;
 b=sToxUgdvKn19o3KuB1YST6V2Ks5sEIOVR/VHoj5U3Bfgs0yfgr9PM8xxTgqjVy/+l10kFlHiRsG2DNI0qhJNkWSvjIZGMvhTMO6yiqHr8HLfk+VOezxH11AIlF975scXeYoQmm1bVxCd6MZfMDMjcnw3PfaTf80a3lCQ3rj6kJc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4833.namprd10.prod.outlook.com (2603:10b6:208:333::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Sun, 5 May
 2024 19:00:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 19:00:14 +0000
Date: Sun, 5 May 2024 15:00:10 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dan Aloni <dan.aloni@vastdata.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] rpcrdma: don't decref EP if a ESTABLISHED did not happen
Message-ID: <ZjfXOiQxyGNZpHOj@tissot.1015granger.net>
References: <20240505124910.1877325-1-dan.aloni@vastdata.com>
 <ZjeZQmi7um7LDOd3@tissot.1015granger.net>
 <20240505183628.g2hhzkrtna5asz6b@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505183628.g2hhzkrtna5asz6b@gmail.com>
X-ClientProxiedBy: CH0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:610:cc::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: 145fec02-d3f3-4ed7-c725-08dc6d359830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rjjo27kdBtuD/BVbL7ZPUxkDJ07JatOrAzhcM09jiF7ebzLsPZWMduSi4w3E?=
 =?us-ascii?Q?fE3Q8k/JjepJbHJtn3em9cJSdDPyONkrXKh895VwY7Jr/hD6FgKYAQCloOxC?=
 =?us-ascii?Q?V0K8mGt5Za5f++wCf7NSbFtkG58TP/EIoe+ybEndoK/cWzitKsymxGJaX2eV?=
 =?us-ascii?Q?EVFF6ScLwSLdvMMRzS63cBDEu5kZ0+/ag3kitg25JKztO9IzyQOTtAdDQ5+2?=
 =?us-ascii?Q?+LTWN7JIwG7lQnl2yI8sJ4UJVxnNwqSYZLerXhJ06q79NtOaO5LtI+CVi3l6?=
 =?us-ascii?Q?ecO9E3YNPKt9W/weT3t5R0u4ork/lt/khJivKE4wYDjWfvcHZgqVfAkXWtKd?=
 =?us-ascii?Q?BRdOMBUYbSS7ngDq69UlZG2dOhFNQJ12zlKYANsPBZywEoIFDx56lzYs1jW4?=
 =?us-ascii?Q?BG3eQ9YAD6zmJKaT8pcuiaZ656rN5QhQwkmNps5zHYdV72ODjdOVFPYm4gDR?=
 =?us-ascii?Q?ZCgQahaZYycbZ/xpis3WyznbFSBwyG7HybY6sSj7ncXW4LM88NEHpLPa0zGk?=
 =?us-ascii?Q?KYfLXLpDJAVuDK6hO/6IYo1as8K+WMSJ68K9PCa6paZGDSiLlaoFVAQ0IHhF?=
 =?us-ascii?Q?XJGWbsu+ZB5d6tz135GuEKauvQQy/PvAuwCqjp/pUH4QX9JLNaAbovA+4BTM?=
 =?us-ascii?Q?YkWagNIgY+2BC0E8e/r+wVSfj7FKiDDr/de9Iim62BO9UETt0xoJzk4EDBPH?=
 =?us-ascii?Q?IKFp3c1uhjmgvj8mnWzIQIAr9nlyuLoou43KZeE7AEPhjn7F4wHjlEuZbp6M?=
 =?us-ascii?Q?Wtkb5rEkqlOugPJ2qgxn+x/zFwx2uasXT8kuX4xVSbglNqSZoQ8RtisUxXkL?=
 =?us-ascii?Q?LVCu1Q4bDePKOGtDgh3QM2kQ00D7QLVy90MY3Po1IiuMQ75OKEIzWsXp9BR3?=
 =?us-ascii?Q?wvosKbqn9UQFV0nX90gDj/+C+MfQdx/CB2aiumipES67+gnO4R+hJ/agVfzc?=
 =?us-ascii?Q?bi3+dANJBNACC9tLxjTNx/HqZGbsBisOiYvX/T88ef/3rkcqg0QLjW75ZUJA?=
 =?us-ascii?Q?qVM5VqhtkjDWnuO2PbpMVwogNkwL3XPhTFOb3Q/Ve8jp80gJR2Lq0AteBEDO?=
 =?us-ascii?Q?6E8anAhDJpNu4w25oWQpoVzS/wjlZkghZenAyuglFtL/9FHQeOZbv7QFW6z8?=
 =?us-ascii?Q?NynAT2C72wual7EcuoaiSl4r7eGxg9sMwyjhl5XMWyOnxsz4kw5qUtWl5fIl?=
 =?us-ascii?Q?B8U3hIRtHlLNIGbVfdUqHk/z3MCaUtakawVK12g9Afhei/GoE5Dn9GtwaUS/?=
 =?us-ascii?Q?WPjuOhFRH6KLNn0w6zg80jmiZDEkPbmB7dU4Mesajg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SStPhiCAgZJom+4dZUdoEQz9NoPdglrH/2cahis1G3+6jjUN+xnsN29lU/8G?=
 =?us-ascii?Q?ngIQsnIPC20QiykHYHAlAYOBcVH9xqDIsrKNGqfhBhjH1qz10/Rwt6vQzMsH?=
 =?us-ascii?Q?7Y3CXTNsjmiL6KH/O+u2MCmhiSo+OxfHKCWHRbcaXiGKrNwiw6xR9FMWQCjv?=
 =?us-ascii?Q?5K3gu1qPblnQhnPXOujL9ROHTXoDRRMKgFSy685Aj/kKyMQlqZP++Uv2GAC1?=
 =?us-ascii?Q?hZL+BnZEbSCVX5gM5PG1DUO4ICDYVEKOiCbzIvpNYfXfulvnMd8Hj92H+Rg1?=
 =?us-ascii?Q?dWIfNqKhZWZyn6aX3nMNqOaPX4B8l6j29cqUQsyPVkDoN33Eb2g4j/c814zo?=
 =?us-ascii?Q?Slep6uqJ4g4OEJcNyvwyimZ15PtzbH+2Y69oClynE41K3J0UweuxaJHLjXbm?=
 =?us-ascii?Q?tM+hyYxbfOLyxWwGRbFlUXZNux293vPOP8iYKK6mUb7Z0HKXmj0lrW4tng+6?=
 =?us-ascii?Q?XNT8loWrDUI/pHSo0vVtCiuAtKGbFIatGuB0pCA5pMHMtoHk8qRL/VnWTwmK?=
 =?us-ascii?Q?U0a9fN6p8WSYnDfgXLxyXyL/ITDIS2HU+wJAcwWnT0Q5o3uzmCajh+kKSOlW?=
 =?us-ascii?Q?n5cnYGBpBuVs2YlE1TjwsYJEb41M4Iy4csNz9aygvpEUAmE9659E/fzOvQhJ?=
 =?us-ascii?Q?34MFgCHjP/+3Sje7DnqfwBBCWvtpd9NNPwQ0kD+czRhNtcaYrpnH5WKg/5/o?=
 =?us-ascii?Q?HAjEBP4lgNEHMPaUDtw1lFRkB16jNgY257YLI9HZw0H7uXskeOB5v2EypFhP?=
 =?us-ascii?Q?QMgrd621lkLikbENdSOXPZf6+MaA6lZ0kbgJFmxYUF3eEBlnYg7iJ1JqiIuH?=
 =?us-ascii?Q?xZATfUI/y/xgeQe31M62LM9GuUgeJtbeguowqYMs8xaF9+kKlDEaEuwKWZ/E?=
 =?us-ascii?Q?ISOa3jNWCwLBEZPDfeb6/Vk89xq+/8ZbP9b6VbVT4TBasAFXEitQR4c/6jnT?=
 =?us-ascii?Q?+RkVUS26Zyt8x88+tYnsIr7bpAYbNg9QcDiDnDcX6/lj4gw71CI934CEEuD3?=
 =?us-ascii?Q?E4Y3RHcXs0zisrns1HWU9xOLliNyWYFqcv/tpq8kp5RDhBJWf1vacemv8Phn?=
 =?us-ascii?Q?gN2LJEMnysoWafAn32fry8LYyjxAWdZWoZ+ZSjetjnJAfwt897aaJ4FwYaZF?=
 =?us-ascii?Q?HGvie4dXVni73cqSoCX5L1hSHjgfzeDUhMfNNFGP2Db0PmRro5B3t6EYT3j0?=
 =?us-ascii?Q?6n6bbQ4TpACccpmMWDCTwYUzzl3zGL8USg41Cv7d4MdqMLIjVzHxKCIiu3gk?=
 =?us-ascii?Q?7kz0Wy7mFN5yohRCTPGPSsBiH1enjq7qM/t86xR3ScO0W9Zq3Eg0PrrsXROQ?=
 =?us-ascii?Q?hVG1tkmPlqz9K5yP51zZVU0jogCv6YpQrsqJsitLwJ4jLp3dx4FFQSH7FjTr?=
 =?us-ascii?Q?Myy3c9+W2ZBo/usXPTI8OO05r13yKbkDb+EvHXWHrbGadK3O+7JqRdGEyyx8?=
 =?us-ascii?Q?igW/9Ydl9vMDuHgZ+27p4Nux3E6v00cr8hdLnM/cjbdVAenJ4CW1weEnwLx6?=
 =?us-ascii?Q?aj3eLKCdg3cYK4JEPQNL9Bc/QkTMx+A2OJeVmLvI1ngl2stkDCq1x7hpSOED?=
 =?us-ascii?Q?aui5bJ/56UPEntw5QOmE6Z3Rdpg9g8sQuKVocpGCErpqQKHnnXSpOIhu1n2Q?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YVI1ezb1OGTLMO7cQTkEZZ89ap1STKWn8QtG4c0lG9In9ppMpWMjdYih752NVe0zNpZHY3ST8JScPXfJn/JqAdfDYT6uXR5Nr+GUs/zcLOIDw9SwdJCtF0Os2BJKbA00u0K+iecKtE3924Ro2fiGGHVjvjormxrwXA80JChzI6GV5qM8cyIp3HN1yaZyfZDnP9AYq4TeRjl5ybRIVKXnwOJO14sGwNRgh8Am8HiLj1cBZ5vpuE/7Ti5DAc/8or3UVb8NKNZ7BolW7LrQ7pctHj/78QIzv6UyIekb+kV4bWy+2dtK3Df8xlVUWjaFqwVegtXBREvqPvnvvX1XQ2C+654auJ29KQ9hCPkqBkU3COEumk+7Ue0MiLOwd2aqBumUU4+Usex3tl6RMnk4LlN6oVyxXqaD1rJcow0mgBKs8YMJgrOfR58BrCiG+dB7n6RBoZcK0pFucCj82SFkJJlAPtTrnOOMxrHcR0KpZNjuYVm1wxqTFGOdkFlkFs4Sx7dH7RRf102WTfGT3hbc7l4VAVHZUhjaPoHWBKlIFeQmDJC12/4iK82VjAPW3eblQUu0QEAL2NXtxDE2SU+oCtlXP9MnJMEUXTipVtn2sOUInaQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145fec02-d3f3-4ed7-c725-08dc6d359830
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 19:00:14.7559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqEDQAtkUKZ/aO4CWmvkD/G6dzHw8hlYWp8GMjsJLwXvPnTYuwCPx4Lb5+w9BtdRnhXLnYfSkeWlgfxCmsBOmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_13,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405050082
X-Proofpoint-GUID: tHQAXycigUpO2mYJCJbNTggQdVJpBD4s
X-Proofpoint-ORIG-GUID: tHQAXycigUpO2mYJCJbNTggQdVJpBD4s

On Sun, May 05, 2024 at 09:36:28PM +0300, Dan Aloni wrote:
> On 2024-05-05 10:35:46, Chuck Lever wrote:
> > On Sun, May 05, 2024 at 03:49:10PM +0300, Dan Aloni wrote:
> > > We found a case where `RDMA_CM_EVENT_DEVICE_REMOVAL` causes a refcount
> > > underflow.
> > > 
> > > The specific scenario that caused this to happen is IB device bonding,
> > > when bringing down one of the ports, or all ports. The situation is not
> > > just a print - it also causes a non-recoverable state it is not even
> > > possible to complete the disconnect and shut it down the mount,
> > > requiring a reboot, suggesting that tear-down is also incomplete in this
> > > state.
> > > 
> > > The trivial fix seems to work as such - if we did not receive a
> > > `RDMA_CM_EVENT_ESTABLISHED`, we should not decref the EP, otherwise
> > > `rpcrdma_xprt_drain` kills the EP prematurely in from the context of
> > > `rpcrdma_xprt_disconnect`.
> > > 
> > > Fixes: 2acc5cae2923 ('xprtrdma: Prevent dereferencing r_xprt->rx_ep after it is freed')
> > 
> > Hi Dan, thanks for the bug report!
> > 
> [..]
> > Second, I wonder if, when bonding interfaces, there's an opportunity
> > for the verbs consumer to take an additional transport reference.
> > Cc'ing linux-rdma for input on that issue. Can you show a brief
> > diagram of when the ep reference count changes when bonding?
> 
> Not sure we need an additional reference here.

We already have two mechanisms in play:

- the ep reference count
- the re_connect_status value

I would prefer not to add a boolean here. Seems like
re_connect_status could do that job if we need it to.

I seem to recall that when a device is removed, the verbs consumer
doesn't get a DISCONNECT first. Or does it? Having a sequence of
CM events that you see in the bonded case would help a lot.


> I understand regarding rpcrdma
> managing its internal EP refcount, that it is having three in total: one for
> init, another one for ESTABLISHED mode, and a third for 'outstanding receives',
> so the mishandling of RDMA_CM_EVENT_DEVICE_REMOVAL seem only internal to me,
> and I found some more about it, please read on.
> 
> > Also, I note that the WARNING below happened on a RHEL9 kernel:
> > 
> >    5.14.0-284.11.1.el9_2.x86_64
> > 
> > Can you confirm that this issue reproduces on v6.8 and newer ?
> 
> Some context: I originally tested with a version that also has implemented a
> timeout in wait_event of `rpcrdma_xprt_connect`. You may say it is somewhat
> 'culprit' in the negative decref, but there is the other issue and second order
> effect of likely not handling RDMA_CM_EVENT_DEVICE_REMOVAL properly which causes
> the unkillable transport, so we are not reaching teardown at all. With both of
> these changes applied both problems are gone.
> 
> As for upstream version testing, with the elrepo build of 6.8.9 which matches
> vanilla, I don't see the negative kref but I do see the other effect of
> `XPRT_CLOSE_WAIT` transport state and provider stuck on teardown (like below),
> which does not release even after ports are back up online.
> 
> Testing 6.8.9 with both the patch and `wake_up_all(&ep->re_connect_wait);`
> for `RDMA_CM_EVENT_DEVICE_REMOVAL` works for me, showing proper recovery
> on bonding, I'll post in a reply.

It looks like you are trying to fix several issues in one patch. So
I need you to separate these issues and the fixes, and let's focus
on the upstream kernel (v6.9-rc6) because there's nothing I can do
about the RHEL9 kernel, which is clearly a different source base
than the one I work on.

If we need a "wake_up_all(&ep->re_connect_wait);" during
DEVICE_REMOVAL, that should be a separate patch. And you need to
figure out if ADDR_CHANGE needs the same treatment: the v2 you just
sent changes the behavior of ADDR_CHANGE too but does not mention
whether it intended that change.

Without a reproducer or a detailed explanation of how the ep
reference count changes in step with CM events, I can't properly
assess your proposed fix.


> ```
> INFO: task kworker/u128:6:1688 blocked for more than 122 seconds.
>       Tainted: G            E      6.8.9-1.el9.elrepo.x86_64 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u128:6  state:D stack:0     pid:1688  tgid:1688  ppid:2      flags:0x00004000
> Workqueue: mlx5_lag mlx5_do_bond_work [mlx5_core]
> Call Trace:
>  <TASK>
>  __schedule+0x21c/0x680
>  schedule+0x31/0xd0
>  schedule_timeout+0x148/0x160
>  ? mutex_lock+0xe/0x30
>  ? cma_process_remove+0x218/0x260 [rdma_cm]
>  ? preempt_count_add+0x70/0xa0
>  __wait_for_common+0x90/0x1e0
>  ? __pfx_schedule_timeout+0x10/0x10
>  cma_remove_one+0x5c/0xd0 [rdma_cm]
>  remove_client_context+0x88/0xd0 [ib_core]
>  disable_device+0x8a/0x160 [ib_core]
>  ? _raw_spin_unlock+0x15/0x30
>  __ib_unregister_device+0x42/0xb0 [ib_core]
>  ib_unregister_device+0x22/0x30 [ib_core]
>  mlx5r_remove+0x36/0x60 [mlx5_ib]
>  auxiliary_bus_remove+0x18/0x30
>  device_release_driver_internal+0x193/0x200
>  bus_remove_device+0xbf/0x130
>  device_del+0x157/0x3e0
>  ? devl_param_driverinit_value_get+0x29/0xa0
>  mlx5_rescan_drivers_locked.part.0+0x7e/0x1b0 [mlx5_core]
>  mlx5_lag_remove_devices+0x3c/0x60 [mlx5_core]
>  mlx5_do_bond+0x2cb/0x390 [mlx5_core]
>  mlx5_do_bond_work+0x96/0xf0 [mlx5_core]
>  process_one_work+0x174/0x340
>  worker_thread+0x27e/0x390
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xee/0x120
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2d/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
> INFO: task fio:10584 blocked for more than 122 seconds.
>       Tainted: G            E      6.8.9-1.el9.elrepo.x86_64 #1
> ```
> 
> -- 
> Dan Aloni

-- 
Chuck Lever

