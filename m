Return-Path: <linux-nfs+bounces-7185-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8832099F5A0
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 20:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013E61F21980
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E9218991E;
	Tue, 15 Oct 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BfjZAYWh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G0aPj4wJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611431F76B1;
	Tue, 15 Oct 2024 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017006; cv=fail; b=WT2jIG+U9Oz2QveKuFEkxDHPuq9dpXWIT2YBeW+xLKNVN3naEZvk4QLiQOguzKv97FOCTDozWrJmLFKE9k1GJvM6lYIObx6RqE6WTYpOHGRaAwQYcs4dKnBJfLdtTv528h/4VIAuss760NzM6DgQgX28wRrzMKvpEYfNaRY6nQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017006; c=relaxed/simple;
	bh=AXmaeT5xZGGzB81/YhjDYK3LRe45c3EuaCF3wD/96BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RGG3KFEj47nqEH3S1ZesigEshksN/bs3XOgtoKPg2j1owxdKrP3iWa2M60lFhyXMYI9mnDde0YZkUHF0eMLwXKN4n8RpJMBmOGIcSdZcY/lcJGV6SL6sI7cCbVIC5VfOm/fqDoIuSJeHpt17QdurE5jrtoqwytsfID4LWSA8hOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BfjZAYWh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G0aPj4wJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHtdJ9011654;
	Tue, 15 Oct 2024 18:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=g2Q9Utvw3tTOnfnRSF
	tT5Io3HSLmpGdEzCI7aVDzBrI=; b=BfjZAYWhVP71fVdICWoqtsyB9BQCsgQuY+
	Ic/nrqeGa+DPG4rQuOAnGAYESeY8OBkSXLDsFSPlRbW6OU+3hNljCnKRm4ASt5kB
	Wgypxm2Mdw3Asz/r6mhvkLRIAqL2HXUXplSF/wy5Kn4xWprfufk890AjsjOThD3t
	f/GhZ0/WloAnbLfSyuSC2iDM99GohtfUv6QCBXU9hWj6VLBtDdrUq67Bb/czD5m0
	3cjlEcwgZl0PeneSBtBpQ5ZA/JITlM1bWREet576/ryyNceUbxBtEv+K9VHWoVsM
	Mzhp6YOZStsdIVu4uODpnw+5KUpweW55uDJnfNDfxEHTuWd191Wg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt1uc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 18:29:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FH3Wks010979;
	Tue, 15 Oct 2024 18:29:52 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fje4sjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 18:29:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNDZySZmHoPa4KsWSIpFFRKWH3n05unKGr8kDNHr/U7KKm3K7KcPOjVk0iMjMnAEll7jkp9gaSk4x66A7BfKWI4aZaq2uHn0UrU6uOiZWGuKDQh05YmAosgbsWEW+pOGZZEP8s/IOK9pJrJAZ1VfE+Oatl8B2zcfcLspFpogdqaIbNOk05R59GyFxquIuapZUqRgY1RJV4xqhiTlE9GZxiQd6dVExur3+7kTDcLSuP06pHK6q5wcZaq/N+1iRxHjYfg44p0GG8hV7a94Noz1Qbdx5cQLkPy+XQU6zb9+Q0aXd1actIUKL1R90Bdj/MPNVs1rPYmZlHMWKsLJW9m10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2Q9Utvw3tTOnfnRSFtT5Io3HSLmpGdEzCI7aVDzBrI=;
 b=Ga0LwdGIh/+OVaq1I6/WNwKfgA2jWz9RfL21oF1F3WqDcdsE/jgUz9VAzZh4awD9/HC0HiKUoznfIBW1aeFJAqZ4QrcxwWrBW9q+a6tXN70a7li1ZT+nQpNVlncSgauXHzPNDdNK7KNlWbhGfJpI5MmfHOzmwYASC4M5K7Rcculmv0YV9jQNaAR1UcZlpt4IAAJfXuVavN4L7tFWaRdfhX0H7Bs0udlkrC01Pf7T2fyFR3MAjoEQcqk0bZk/ZsES0DAUTQaMDqkkwqR8ubZYX53zV3+9UFfPIcXDBqjE0NPxWqfAnX/vNPRiM/lk0G+P7IPS5DJ7h/ReWeNiucjYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2Q9Utvw3tTOnfnRSFtT5Io3HSLmpGdEzCI7aVDzBrI=;
 b=G0aPj4wJTO3G6OkNAfOe1KnyGu5Fzeuer/UsNfoBeAI5gr2546Ouu+Oyr0ZxFEESEf0+v5WkD8eBw6K8WOhRqla0Riq96Lkt6ZVqnGsv6VFewAah1sRRi6ums3LiveeXHmWJ7XW/jJMWgeNWpPBWasiM3K12OkQ1WXRTDCmoXEc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4947.namprd10.prod.outlook.com (2603:10b6:208:326::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 18:29:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 18:29:49 +0000
Date: Tue, 15 Oct 2024 14:29:46 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jonathan Corbet <corbet@lwn.net>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Thomas Haynes <loghyr@gmail.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/6] nfsd: drop inode parameter from
 nfsd4_change_attribute()
Message-ID: <Zw60mgZaLZtGWWil@tissot.1015granger.net>
References: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
 <20241014-delstid-v1-1-7ce8a2f4dd24@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014-delstid-v1-1-7ce8a2f4dd24@kernel.org>
X-ClientProxiedBy: CH0PR03CA0327.namprd03.prod.outlook.com
 (2603:10b6:610:118::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: a06f53d2-f911-49e3-8345-08dced475a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B5YRGlOX9r1mUmYC9yd/bzPLWp05bBATTkcF9yzZGzeyT9IBPuDh9+gmPOEy?=
 =?us-ascii?Q?UXDZ6Qefu4ZxLdfk5QBKgF92d6ezEi0vs0mSeGdF1BSCfh1SbN8F5CxtyeRf?=
 =?us-ascii?Q?wytNPZZYoBkG3Ytq6TIaJ1c9GU61ez1HdwAJC7RyLVBk/WSRrJNt/fS11aSu?=
 =?us-ascii?Q?q7ZioynVwwrOhg2EKNXn+334DBQhqJw/Ce/FZvw/ScM7YZaNHPoBKbG+puX9?=
 =?us-ascii?Q?2TiuJDSNxlcfNQkXkPnyqR1ItR22tVC0pnRrLm4K/UOU/SSXzbfCyI/osSLm?=
 =?us-ascii?Q?TE9AQMpeR7VgsFNJvqvdirEECcVWE11vrjfwaRrrkaJUNCEUfcEmr4mS8CQG?=
 =?us-ascii?Q?cY8JHV6lATvnODZAl9YRUVr8ijaSJ4jJYeFieOSuCPavUWNPkdiNNOgd1fOv?=
 =?us-ascii?Q?YycenCubvqanQMBkCVHdTn6eeP2JISbJRFRKhJxzDCgoFjMnYOuFg8Co6pK3?=
 =?us-ascii?Q?F4CeJuVwALLcBcV/4tH92hEqLdCCNeTB3/DQU1KcrTnNwnT48AQQsuAjOwCO?=
 =?us-ascii?Q?P1uwWyyVw2ZH5/MRFDGGlUISsRp7wBh2JF/lIATo1VoY+mFuFpClYFPcBhC9?=
 =?us-ascii?Q?kd2H2hUkdmAKkdLO3tFMQC+3AT3T8jq5IKYTdrUyQynh8h2UmOHsza5+YY8O?=
 =?us-ascii?Q?jcx0DOJx8Me8+MREGm58f0MolgSUSDtuM5yG8K21NmlMBy3J5hPedYcZiEih?=
 =?us-ascii?Q?yJBE1+LbSbFPy+2BKfnGzrtA3E02XtxAmbCo27L8QI7a/c8X/N2BKL4FweFa?=
 =?us-ascii?Q?+OfNe5W1E/xtSyZ7is3nHPNKX2jiKHfPxFyCXQbkO4SujkLPUt+GUoSyrd5/?=
 =?us-ascii?Q?0Un0Zc1hBuLfpkKZJ8+uZJGIHrOy7awBpQWTksBjdchzUwrxPHuZupXWPAlP?=
 =?us-ascii?Q?VkU0QLDu/lvhb7RcKr6lT5Dw8jjC9nV0CE9IQ/WfOE7oqbd/2rUvPhJQVe/w?=
 =?us-ascii?Q?zlj+pVADDjSxePXdYuT9s/DbtmWtZ/D4CvrDqZxIC+aYy9kKz4j6oz3CPlsj?=
 =?us-ascii?Q?jKsNBrrPsKCQMDrNRHcUxW23Bvjbk2/Nx4X2BNVHQNGhJkSBQ/4Y4r9BC+C4?=
 =?us-ascii?Q?HB1/u/w0vLnUqnDalgfymDKkNeokzYosV4mTqM2WOntNTzG7Bv4BfJKcXQ/1?=
 =?us-ascii?Q?NAC1llYycke222gZJ7BrCKyEZjmoj5kSUG3m5evudD5ec9pcIJinddNC138f?=
 =?us-ascii?Q?v2JUBdYbPuY6PxU5XoPUB4gPYaj5xG9gydrOPd2zwEmTH3eNrB+E6v4h9o2q?=
 =?us-ascii?Q?hzcaVaRvYoZHf4rrac54j3wq61+WN2Q+udIqR3SsxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FLWAz9HxP7gKhNwLy+Lppod9DsAl1Wu8OhMbWBcfoNIwXn2i2aJ1G1Ja3NLM?=
 =?us-ascii?Q?XO+f5Xfhha0+gk3pre+AvxcEAWyNZfe6nxB9AFXx5tSc+3YpjXm7ieFJBhuq?=
 =?us-ascii?Q?wXEleiQ0a7qAqpzocXNdpbCcVKsSPHDghJnWPW/+hYGVbcV9hyB9lskS49Zs?=
 =?us-ascii?Q?GQsAeZtkSWRUODm8jR46RhYuGpYuTUQ2fPwtphkrUQbJZXdhqOVCVX3eCdey?=
 =?us-ascii?Q?neY3d4SRQCTHLSsooPVP8NRKDujoB37GIJok1KVuHQsfaKGa68d7KRy9BQjp?=
 =?us-ascii?Q?PrjXUJrQqiVSEm2iRZgpVw5kaixBegAWXB8yxnbaeuATKhCXJodfC8+QdaLf?=
 =?us-ascii?Q?ll06QEDuq3BbP7OqzZuzzYISAuCbMBD5xLxr8OF0c0RAkaAjP3U3m/FJkD7b?=
 =?us-ascii?Q?2PqOUnS6CLFyE2zEtpTrUf0Q0Q68v9LP5tIFxuflMm7APmuTT4FpoIT+7YzJ?=
 =?us-ascii?Q?JzHk8OA34LXeCAHOvuPKgHmbcW8Gd/nH5Ex7tCqolhu76dDiQCG2Ax4HN5hN?=
 =?us-ascii?Q?8Pw/zJFlOff04GQYkY0z3H90o0k++lBexIEtwrrIgda7lQlwX8uH/BT78U0C?=
 =?us-ascii?Q?OlrbWC8hN7p00Xv3d4v3a8N5NG+QY59OPkYpr9E5cG57zKAfsRXyjhtJ/J3M?=
 =?us-ascii?Q?Vn5Y4727wwh2/99wuXDiqJNWoZiUfvmu6ETu38Xnta5oq+JfPjdlp3pt/Qmc?=
 =?us-ascii?Q?+o0532yythuo1E3npyNN1VxHTbjWqnVcG9wnuOQL5S+2f9k0CTGYWOma65nw?=
 =?us-ascii?Q?Db3u8dd7sEzJFoVgD+dTlQ9XUGjjSnKLrOz8bsdDs/X5mh91ukshyJGstqix?=
 =?us-ascii?Q?mUdl3dOgpfIHvByzt6PWJqi7n1s3/Y/YeRefdtjNP8aGS8FtIh7wl+P84VD3?=
 =?us-ascii?Q?6ZRT3IB55TVm3m8dDlsuWhjJmzaUvVCYnqQWJiNU1XiiyJa38jHFBZnSybV2?=
 =?us-ascii?Q?eE+qLKk/r3K38vpz2SzGRMkdxDTj5zyTvo+U/n4ABj7a7m/cKoyKxKe8FqYo?=
 =?us-ascii?Q?MGWKNq9r3qFx5dNXnnf1H9wG6gHyd+x2YRq8RS6PJfQk8gS9Y/+T6BDKrKTr?=
 =?us-ascii?Q?tMC7YshZ6ql/EnGQEbSEMnKCSMoarAH3ftjsWZXK++fju7ihm4w8e80P9HnN?=
 =?us-ascii?Q?BKj6c8XuiFaVsvOGOODc5XuST4QuWg89ZJjRMNtmwO01gE3ArC/m4jwqd4tg?=
 =?us-ascii?Q?8xVAVPa4aQTqCxl2Dt3Yd3iIRQOyxr03Kemmd//5TSnkYwU6HWDb4KF2wFzc?=
 =?us-ascii?Q?kzEmLfjvq/9Fn4OSAvEHwSV9dFjW4YAMbw0Ix54MhTip7llaJ9IV++Pinm7d?=
 =?us-ascii?Q?ipj6kssvxTSmcZ3NchGAxUAhQ980Sc9OaYSecIj1oZ8KWFIdwPlB0qugvfEU?=
 =?us-ascii?Q?c0PaGpNHV/WiFkOd6C8tpCnXl93CDVvSkIc+bAbYGFWdVvHJd6zvYROH3ehb?=
 =?us-ascii?Q?pP3SqSUAs86FG7P3OimiZWjvZioWpHDy2mjWXJyScwvcLuyTtIhIQlcSpsit?=
 =?us-ascii?Q?5fVRpF7Ig9W9NRSLTbZ0sI+jWbrAj9n/KjmWGksByrVCgcj7ZBcxm0cxtpAW?=
 =?us-ascii?Q?F15YbYx7hgF5Ga6GupOP8UNd809x7bgN4RH0LiWz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wc2bxuaHMnGRFoBSynN9i13lUV/w3JIpExG1pZiaYfIU4vaO6YhysHK9QHM7L9+lwQeCF8/MegdX0Lhftvby6LXzN/FVs7MnYF6i5IGTND4Af4kZ3492t8rfTmaW5gMWEBw2ZU5OFkfpHFSacsi9dG39AOJmLxWQ60CI0WAlOVpRraihQECrNutCR8N6tP3deJPzqzBcUdfnt0rlqlv0aCacKdD6f/JLBwq/dGjnCS/swi9u1if7VYh+vFYbkIUApnst8gDyjw5mYbgMXUGxG4EB1VIjgP2z8LW+BdtpXIkhzV7UzVyPfWw3DkAiNUbi9ORinWDdDJFViqL/GX5RdQNYsqUeii5vR5FzeEGs3js2SNEGh4U07T2F3XQn+7tX8yIE2XI91n+vHYEcIwS+1FvXr1B2p1Gttp7WHwVQOfNzFhRfytU9Ql5V54A7MGtoA+0sRVCQVbHEtV/7NYNnEGHzV5KSTTu7CJnbdy6gQRuJp9LDw4aI3PRlvrD3laXLmClbDPMjJtYoz4gCjOF4wYIZCjV651T4hwCgUFbcC3POQIWES6Wp/jq0I67WLQY/BN5uV5a7klnJlKHdjWqGrfsGEaq86TCt0G3EHotzLNY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06f53d2-f911-49e3-8345-08dced475a80
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 18:29:49.8057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xe+YgwoWKjdqQDvYJNPPvtGpI+VRtKkgsKFfsQuNAcCpyuhjWJNRLHhyXSlQnfTae9YXCknI6MfDkN9kbcW1ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_14,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410150126
X-Proofpoint-GUID: whSES5F6-lhPpVbFE7rxVbbKuaa7G-Yo
X-Proofpoint-ORIG-GUID: whSES5F6-lhPpVbFE7rxVbbKuaa7G-Yo

Hey Jeff -

On Mon, Oct 14, 2024 at 03:26:49PM -0400, Jeff Layton wrote:
> Fix up nfs4_delegation_stat() to fetch STATX_MODE,

The patch description isn't clear about why this change is needed.
After reading through the other patches, I'm not sure I'm any more
enlightened about it ;-)


> and then drop the
> inode parameter from nfsd4_change_attribute(), since it's no longer
> needed.

Since nfsd4_change_attribute() expects @stat to be filled in by the
caller, it needs a kdoc-style comment that documents that part of
the API contract.

I can add one when applying this patch, unless you would like to
resend this one or send me something to squash into this change.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c |  5 ++---
>  fs/nfsd/nfs4xdr.c   |  2 +-
>  fs/nfsd/nfsfh.c     | 11 ++++-------
>  fs/nfsd/nfsfh.h     |  3 +--
>  4 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d753926db09eedf629fc3e0938f10b1a6fdb0245..2961a277a79c1f4cdb8c29a7c19abcb3305b61a1 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5953,7 +5953,7 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>  	path.dentry = file_dentry(nf->nf_file);
>  
>  	rc = vfs_getattr(&path, stat,
> -			 (STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
> +			 (STATX_MODE | STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
>  			 AT_STATX_SYNC_AS_STAT);
>  
>  	nfsd_file_put(nf);
> @@ -6037,8 +6037,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  		}
>  		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
>  		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
> -		dp->dl_cb_fattr.ncf_initial_cinfo =
> -			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
> +		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
>  		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
>  	} else {
>  		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 6286ad2afa069f5274ffa352209b7d3c8c577dac..da7ec663da7326ad5c68a9c738b12d09cfcdc65a 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3621,7 +3621,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  		args.change_attr = ncf->ncf_initial_cinfo;
>  		nfs4_put_stid(&dp->dl_stid);
>  	} else {
> -		args.change_attr = nfsd4_change_attribute(&args.stat, d_inode(dentry));
> +		args.change_attr = nfsd4_change_attribute(&args.stat);
>  	}
>  
>  	if (err)
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 4c5deea0e9535f2b197aa6ca1786d61730d53c44..453b7b52317d538971ce41f7e0492e5ab28b236d 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -670,20 +670,18 @@ fh_update(struct svc_fh *fhp)
>  __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
>  {
>  	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
> -	struct inode *inode;
>  	struct kstat stat;
>  	__be32 err;
>  
>  	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
>  		return nfs_ok;
>  
> -	inode = d_inode(fhp->fh_dentry);
>  	err = fh_getattr(fhp, &stat);
>  	if (err)
>  		return err;
>  
>  	if (v4)
> -		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
> +		fhp->fh_pre_change = nfsd4_change_attribute(&stat);
>  
>  	fhp->fh_pre_mtime = stat.mtime;
>  	fhp->fh_pre_ctime = stat.ctime;
> @@ -700,7 +698,6 @@ __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
>  __be32 fh_fill_post_attrs(struct svc_fh *fhp)
>  {
>  	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
> -	struct inode *inode = d_inode(fhp->fh_dentry);
>  	__be32 err;
>  
>  	if (fhp->fh_no_wcc)
> @@ -716,7 +713,7 @@ __be32 fh_fill_post_attrs(struct svc_fh *fhp)
>  	fhp->fh_post_saved = true;
>  	if (v4)
>  		fhp->fh_post_change =
> -			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
> +			nfsd4_change_attribute(&fhp->fh_post_attr);
>  	return nfs_ok;
>  }
>  
> @@ -824,13 +821,13 @@ enum fsid_source fsid_source(const struct svc_fh *fhp)
>   * assume that the new change attr is always logged to stable storage in some
>   * fashion before the results can be seen.
>   */
> -u64 nfsd4_change_attribute(const struct kstat *stat, const struct inode *inode)
> +u64 nfsd4_change_attribute(const struct kstat *stat)
>  {
>  	u64 chattr;
>  
>  	if (stat->result_mask & STATX_CHANGE_COOKIE) {
>  		chattr = stat->change_cookie;
> -		if (S_ISREG(inode->i_mode) &&
> +		if (S_ISREG(stat->mode) &&
>  		    !(stat->attributes & STATX_ATTR_CHANGE_MONOTONIC)) {
>  			chattr += (u64)stat->ctime.tv_sec << 30;
>  			chattr += stat->ctime.tv_nsec;
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 5b7394801dc4270dbd5236f3e2f2237130c73dad..876152a91f122f83fb94ffdfb0eedf8fca56a20c 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -297,8 +297,7 @@ static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
>  	fhp->fh_pre_saved = false;
>  }
>  
> -u64 nfsd4_change_attribute(const struct kstat *stat,
> -			   const struct inode *inode);
> +u64 nfsd4_change_attribute(const struct kstat *stat);
>  __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp);
>  __be32 fh_fill_post_attrs(struct svc_fh *fhp);
>  __be32 __must_check fh_fill_both_attrs(struct svc_fh *fhp);
> 
> -- 
> 2.47.0
> 

-- 
Chuck Lever

