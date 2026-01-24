Return-Path: <linux-nfs+bounces-18438-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 47c5ADIzdWltCAEAu9opvQ
	(envelope-from <linux-nfs+bounces-18438-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 22:01:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BB07EFAE
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 22:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6901330028C8
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215A021CC5C;
	Sat, 24 Jan 2026 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PUlFBdaa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VJE0LyWL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004C81CD1E4
	for <linux-nfs@vger.kernel.org>; Sat, 24 Jan 2026 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769288491; cv=fail; b=EG+4HXHuaS9sVEHzgbNZ1rc4RCoCya2lCwug1OepelEqAUC6keiv0afr5kMaStEEiWQIOjhEe3/a439fQkFTvx0QBY6mvjTMKarsPjXXtGFJ2AfU4j0JGFI4vPtREFvnBodqwQpmtVbaoaExakdojPESj3y24C6YANPFkF7hkbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769288491; c=relaxed/simple;
	bh=YZqKtCAZg38We1vhhpD58pFgqkIP/YSfpk+HHaINhaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KDDu2AiEpTSEL6b6WIDrxSDeIqvZC+eg+ZI8cwmxy1f6mPpO0JSY+wuTVHkjntfPhXf7tq8N1Y7oiy29p6oG6qMZLolBR+7SQiZgOFPxZFyWVpbyihtSizGAJwck9SsOTW9mmyW/j2EyObloGR1uF/ZDg1am2MlKKIbKdWJGNGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PUlFBdaa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VJE0LyWL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60OL04hU1462048;
	Sat, 24 Jan 2026 21:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0XCT7vL03D6XzljCoW
	JFD5R0ilM0a3qNlB7iAA77M3A=; b=PUlFBdaaPKFVs53n77YFYnLh6oWCv+ob6h
	VS5PbPar3PcoiUnOqVfWcC5Sc7UamrHgXrtpBj44mmbq68xdAO9Qezus3JZrTU9B
	L+f8JAL0XtHqdkhZ39q6IKgmbqXa10MRGkUeZE4oFKV9I813zOdP8q1BLGScle/7
	6iXYcqjE4C3jh03R0j8a5+rChz31ojXlj3fvk+ybHBaU9aCw0INhx4NuycJeyAli
	3QXYqfj7mS8sG+eyONzHLH7/WJMmg4PZdBt9OM/rNdls8FR41rENvUcE//DIEgy2
	MaH4mTdY49dxZALbwxsOfbLNlUUjMmoRns3g/ug4rtgtM0x2/qdg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvpmr8cc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Jan 2026 21:01:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60OIJH8B001730;
	Sat, 24 Jan 2026 21:01:24 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhb5e55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Jan 2026 21:01:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAPTtSvG3kUjIodsEj2/dyUjHba2IzzktD2PRttFKqXKBmXkQYwIngb12wNtaOkjZykfTOgBgq+m3ZDPFPw2Wm/MBaIJJNkmvAW+6fibgaGRC20gk1VLLD8eGnlrtkzRa5s+8wQzByy0/YtdTWsnOBfE7yzOhgf2zlxq//4INYPYycPP8O60KvmkB991urQ+GsxSDq/3aRn0z1BfBC8XxjUKYEKduqpLc4t4hwO7DlHL26zaKSir9tUIco/rPKwblitrrV5QNfZmoyplYv5em8KLhk48LT7YQ+w/PQ4Z5U8+s1xHEQXddP2DL3EPuyEAlxjsMWbiPoSw12MKA1JzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XCT7vL03D6XzljCoWJFD5R0ilM0a3qNlB7iAA77M3A=;
 b=YufLfGGIQVwXOaPddkz4FaMjWuuFqXC9vhct5BAusfu8upBOvGhkhI646tiMxQy9XTdp85vl8y4b5MQCBVrsu6eLKF//c9MUdTeAwYIDNU/Hi2kXYXk7OSu47kAvrFBD7SqIDzZBOMSX//HaKGNQLNBYnycWNv7rbjoNCuMkPDFGTiLEqaB8k7et+K/T1YIL02/OeCD4BTp+pvSlQSTA/9q/COdscwPt3Bj1VnJcrL0rpTLCLouEZ/T2V3INDU+JAMWe603VeFpjFRrnBvO3gvlPwLvYniQZYFAEtMBvDD24rzSFe+q7GAhQZhbBxCUWKu+VFOyxDEQjFj+S8J1/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XCT7vL03D6XzljCoWJFD5R0ilM0a3qNlB7iAA77M3A=;
 b=VJE0LyWLMP2gcZmlKRcuqGuUlZ6m/NDKDABE2VlTdw3c4qUD3Y3kEy7y66C1Uubg+3gv+nr6y/3wE3AKt9e6BHR4dFc6oM9qRjWwioB+UghvZMrn3fqQTQdM/OUKmjTtXLYfklVK8RjRn1tpKa074JTAFqNnITtuVKlMRXa2Je4=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA1PR10MB6027.namprd10.prod.outlook.com (2603:10b6:208:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sat, 24 Jan
 2026 21:01:19 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Sat, 24 Jan 2026
 21:01:19 +0000
Date: Sat, 24 Jan 2026 21:01:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/5] NFS: Protect against 'eof page pollution'
Message-ID: <4a0a8181-b0b5-4f2f-84e1-3c935273b7df@lucifer.local>
References: <cover.1757100278.git.trond.myklebust@hammerspace.com>
 <a753650aeb789a1a3f2a748bf37415b92615382b.1757100278.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a753650aeb789a1a3f2a748bf37415b92615382b.1757100278.git.trond.myklebust@hammerspace.com>
X-ClientProxiedBy: LNXP265CA0034.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::22) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA1PR10MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe2dd78-7be4-4a1d-07f9-08de5b8bb86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nqiixnJiMMGkjz78M+CriTDgieEqAqEazY5V41CvjdEOksjBNP772gJP43Qq?=
 =?us-ascii?Q?SL3UQW3gWID3qJquAFJcc92kGfK4tX1VPfn1N+8b5zA79z3fyoZzhpY1CDj6?=
 =?us-ascii?Q?XQSeQjbrzS5QTQqe9LkFuH63TCfAzK4uEf2tJhh2/RACs/QoRXnWi7pMwjjY?=
 =?us-ascii?Q?cCrzvTNmtkVjqiV4YQ6ND3kTj7dXuDO5ZbWHzi0cWTVtgcAKP1wHLFFUfbDE?=
 =?us-ascii?Q?pXLchS42EC1RC/nyTkkqhUnGKT/EaaeOK+G7JunLlN26EbRrZggJKQezVf3F?=
 =?us-ascii?Q?xRBxc1+72T/wwyo85MWoSJFwZD3Z5kl1b/SlQLkC/t/9VOu4oKQ0iz6Sjj2a?=
 =?us-ascii?Q?QdcI/W9DDt9qEcP3QO8Q04lpxu5+21kYmITejHukJ0fowgj4grXJr3Hkq/PJ?=
 =?us-ascii?Q?/GnKu6GMiUQdiTZ38bOB2nOgy/YWUWPb0uUUpWd3pCS4HC8VxEZi33djEwaQ?=
 =?us-ascii?Q?sMz8ncnqoWPb8vyjwWFdidySmymEgLxeMx+aYph6Qcyw9CCq7CvWqwd/1FM7?=
 =?us-ascii?Q?bU8GlUW4pEgzFNByLLsgJRS+8Z5YVS9FoJqNgVg6gORhIRXKzVYyoBrqdxzd?=
 =?us-ascii?Q?RMBr3nqCIfVffDzu/IT7QNX3/ont6CHKpK8CNF+7eXsQ15HoJh6FTp4h8BMX?=
 =?us-ascii?Q?CLjtxOrMILsI7JeN7+wswLj2GcVHjZA6pAluIAa3k5+TnWGm2efu5FotpUhR?=
 =?us-ascii?Q?5jZ5pTXty1xZPst2gItR9MAgHS7GYCERmrKHccKdFy2A6/4br0EMAvCqSPEk?=
 =?us-ascii?Q?63Z3nrPfBNYRpDvhEBJzPlAWcYYn/uAb53FAWv/rKGOMahMXGNnFexAQARGD?=
 =?us-ascii?Q?rYAvfMmp0rOv42fhj7JQAu2kNAQftDL9Fo3m2sAG+3aW2zJUEbRZGQmhhcMw?=
 =?us-ascii?Q?L/JwUy3jXq5/asSaxNX/UC3pYmpbqJz8HNq9YQcaVSsKQD+V/aJGMzSXZTCx?=
 =?us-ascii?Q?Vkjay1P53931uZvGR6oikxe6z+nk/oh7GCyDVQ58G8ITYVbEcynafvhxt5YJ?=
 =?us-ascii?Q?d9D3whrydlrTp359VzT9ZoXh3j4VqPVIwDr7EwItzjhB53FibzIOSdrAegjg?=
 =?us-ascii?Q?xqhmV8Ln+1Da/JxpVcl5gX1Zeukcq3LbcaKx6z4CJngw5UJQ1c3T+QKlMWNi?=
 =?us-ascii?Q?laLVor99ZxGSBwcEHhzyQzNeCyCdo8Zeh/l4cCVTl1qVnQfIlxC0rUaxpejj?=
 =?us-ascii?Q?Zc6WEghoMjZy8UEOPQQ7H74zlTsjvPmlm45tMh+VcuxGX7e+XA4GItraQirX?=
 =?us-ascii?Q?Q52fIlLdjOvUJoxmuNlgUg40l9zMFfo4hkBvnCfBO13KRM+P2hu/IxBM7suo?=
 =?us-ascii?Q?dQCAg+jIkvnvszVL/Oot0hwda+QEPZaCUQ1oggZZFx7IEM5IZe/orQWXch3o?=
 =?us-ascii?Q?PZfZjCCBCeG1qJ4eo++iBjmyqR2VIC/SvawLx6WHjPXi75kdUnUu6AQGfDEG?=
 =?us-ascii?Q?DQQ6BjQlBmiEnvRV15XekXXZBp8Ze1r1gFP7V0PV6j6cozKCqSHZ+SQAOHIT?=
 =?us-ascii?Q?Pg4IlJHDgiA6XbdJy2nXlaX9Jig/6yAIhUkxJekLnKUWH09C8hgcaAE9Yn4d?=
 =?us-ascii?Q?qPKVtmxga/gb7YAZbbs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z4DUHtwBT77ZUdB2fXlpxTAqLPEwupktezQ0TmeMAUTWknFg5dZq0Va3l0NF?=
 =?us-ascii?Q?s6OMkJVb3LUdtzBa7qTSkQzcIAkWnkmQr9BrsFGkWHbD+/U0cYtmLNoouLgm?=
 =?us-ascii?Q?JxInFuL4MvAdGFesPJqBfhLdpg0S3Dospr/wYCvQMZWD/At/rqbvARJjgPgb?=
 =?us-ascii?Q?bP7Wwz+wmPce+3pSWBqfRxweUQOy8Vydhsm3wq+dUMdqVXKvVyUmqAN5tRNn?=
 =?us-ascii?Q?/hUvYBQRFgr4YW/0HnDxo+PQkgUWEsjUqSgO0RgjI9OAOjbEdvduFEgYkweg?=
 =?us-ascii?Q?vFhe3eI3bCFQyeNn+sodQjf4WfYC2c3AG9mRl/ULv6+BIH0Uw/RUJHjWE59O?=
 =?us-ascii?Q?S2Sro4gWQsEbVu794XAbFDVSHBmk7zOvzOrYcati17NoTWKtICxUprnf6xZi?=
 =?us-ascii?Q?Kg5ZFJzg3USgLBMqGOQgGk9+OREPppiw5Oxpd+TgT+xQxTDd0nQPYyf5R36H?=
 =?us-ascii?Q?JVD4P7AlsXlaUDPnVT4hK/5I5+W89I3jZt2cHbD/LgghfTPKPfqTJSmXy6mD?=
 =?us-ascii?Q?9H1uQpZJxUtU7Fp4YAhnB7oWbJqQobf2P1kkr/zU2HEpL8ibwAeZeFI7n9pA?=
 =?us-ascii?Q?eBPGpW2CsuUKM/m3b+sm4ipNM0fY/YOP0uDA/qkJjAiJYY9FEgugUiJ+iHNF?=
 =?us-ascii?Q?0MqPYHFfiqWOOrFitNm1iTHcOxGuSnBxCyeFnVl5/Tr3QPivRe3BZbkKn/jh?=
 =?us-ascii?Q?5xiEQy8k80LZsN97ErtsfF4D3up1K1nJGjXks2C++3NuLY0nrjFuBSQNOp/D?=
 =?us-ascii?Q?G24svqgdsxKnYK95h+8+iCKXhfy1j5PvKkWfOs+oh5/YIIk9BYSxdC9jiZqA?=
 =?us-ascii?Q?zDVSDLK/MTBPQHaiRzMVhOD7JxR6bEP9Cthw2uplmvxReolytSOMfU1bun4P?=
 =?us-ascii?Q?Ch9BYWWsxU02NNYbO0uHHLY2UM3EryNKrsRt1pxXJpMGmt+BGMzbioLz4mtP?=
 =?us-ascii?Q?XJpZa/2YyX+DwtBnesN3wu28ylzjuIOGGZXnBFjJE3D1cfx+sE8gcf65Qb/r?=
 =?us-ascii?Q?zQZBr1hM4MF85aCHlCPhZ5QSdop7g/lKxZrxzyjA7m+a7l6y/JB7rXkrriP5?=
 =?us-ascii?Q?M8BVRQjTRMMR3brfiNwVd+BMOXhN7pMhydcDMMuyQHkQ5ePovEOhcTQx2ee/?=
 =?us-ascii?Q?c20+BxjYJkYx8Apw+nMV1l4ptrvHyImvtiZ8kLitxJBVofdr8uhTLj1COwAO?=
 =?us-ascii?Q?vQJ3YwAzO1GXnq9Et1GrN2FmHZUltymwn8Y+1KX4mPwDNkPvtx2LEskmNKf7?=
 =?us-ascii?Q?gWnQw8na59rMr+XpSMR+LAgV6CiB9nQzJPKlh1G6fup27NPZpLPyH22BmboC?=
 =?us-ascii?Q?klhNh63ooc+OWRmfBep3boqw1e+sHz7PDo4+9wykjCtzwwqmSGfQ9NkGnOn5?=
 =?us-ascii?Q?ENOSJ5+5S1HC63Fus3T8EdGFNNV8kWpbk8SuRaMDebIydeiLXoiq1Sm+klU9?=
 =?us-ascii?Q?d1pwP3ZPLNcRNjeVDRpIFK0E32oIahk6tEtNCvHj0a7qCzEkPlqXjAUUYWTE?=
 =?us-ascii?Q?8CWkRsBn/eTSqrOMAHcwBIF44eyiyuNNE9nrnNQ20PtrRNlTTH658SelzAhQ?=
 =?us-ascii?Q?SmYL6JrE/P7M7qEzSxa5SNeiOZZBYnPNwCxImoY4V+cAxutjGXX7IkL2F+wC?=
 =?us-ascii?Q?D/iUhNPXkwr1j1VS16toHGSHtXSZXd77oG9SDaAC+63b+M2giUb81KEHdGFg?=
 =?us-ascii?Q?+ghKyTHZ2Jp6oNlBMHK+i4K6nWYgk3mzFBL9mSrGZt46dSP4vG8WiM6PTlok?=
 =?us-ascii?Q?8sdQVJO1nH2AKb9RhMxkjrqnKehrkyY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uyOtdUjjh/J2miofsdxE6dNWysXhhgbSPw8QsJtfllj6am36/d4EpM7jlRfgBZor2dSy7roFQISbrrleoHyk57ajf3g2MnauPiK0AL2alIcV84/l4U7TaIj6PXiyoCKnylOd5M+qqqDpM5/JgS/wJx0Gd96t0xA3uAC+klEDPGBsv7zmJz1BG2Qx7nv8fGefdkdlLjLxiKYBTxbcZz9I4LILv0Ik/3EKe85pngwGWEtKU3RByzLmHvOAGM3mQ4QVLijy6W0GQlfeYH8KRVqW7no9gh2t6pagUM9tAZpvS/KlKacRs4n8PUPzoXz9QBU0yg+LVs5le586AFRXtmx1perTDLzG3Ya6DlNsmeBgNu2jx8TwZLrx9zn5gBkuB/5qEivb7y4ZgwLz9q4cF3GQXbXf1W6fXANkZKIVAG9BRfvF+/fWkZeSkPX2UYpMflWJ9LSZsr2MC2tN7KJv+htImlNQk3cAKkbvVPsorbYkHEubxPQ9Tqs8tNkKR+Hbyz4d0V4esOiMp94CFiDXqeJyWAaxiqVzWPxmO2ePkDK/AwWp27HONisP/2koAo6GzjnuEhPv/xNu+jWd6Risunplv3YxvH6tt63HKD29LCDwVq8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe2dd78-7be4-4a1d-07f9-08de5b8bb86b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 21:01:19.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbgZDNPORM/j6mJetD+I7kxH0Ll1hjYBnQR5J++3puPiF4m5xeDS7BCzDxhJOAXALgbDJYGalfSdH+Ylrc38VpbDsoL+hnwcenzXHcW+pmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-24_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601240171
X-Authority-Analysis: v=2.4 cv=Q//fIo2a c=1 sm=1 tr=0 ts=69753325 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SEtKQCMJAAAA:8 a=BTR8e604Tx89wPjPFkMA:9 a=CjuIK1q_8ugA:10
 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:13644
X-Proofpoint-ORIG-GUID: ajYugwqs4GSQkraPFvAYaL9hBkNd5uqs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDE3MiBTYWx0ZWRfX7ppdKLzQpux5
 3knYKNcDdcVxSjL+lTcHb3HEMsJ+2DGY3Ix0p9fQk7Zdu9lL17cpsCAxlhJvDx2zbcMitAAZ2oA
 HWnKxQRsd6+huHnOHilvPMmrJ17dnP/TDVwoN+tSwb0Cl9uIQmxDOapragoFtzqCs6vF1CbxZ7E
 nulKe97tDsZI9GYo6Qk5UqjYP47Dty4vzoKbJtja+P+EuGi4hAWkjmPCQlLvG49gDOaXgq0q11Z
 PuLl5Bl/91ehmfWHnbXDGrxNWsUPxoeL4BZX9b57U2GwBvBlCOtzbUOWhrLn7KoQdXTs/whE7NI
 krgiDGmKwlLKXJ7rxMWegza8UJacGml9nr5wDsACnIFJGyvaRK4nUGbMfDv7rPepQ+TDLXwzyMN
 tNJIcePJF5bDjJrMLi5hzeAX4ROmnOA+oqv0bs8hLcVecCpkJWsF7jimbxYkb5k0hj2OOffIp7o
 eZEmx/38ChTd3xu3PqWUnRrn+RMYHaL7X07TiDFM=
X-Proofpoint-GUID: ajYugwqs4GSQkraPFvAYaL9hBkNd5uqs
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-18438-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,hammerspace.com:email,lucifer.local:mid,oracle.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D7BB07EFAE
X-Rspamd-Action: no action

On Fri, Sep 05, 2025 at 03:35:16PM -0400, Trond Myklebust wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> This commit fixes the failing xfstest 'generic/363'.
>
> When the user mmaps() an area that extends beyond the end of file, and
> proceeds to write data into the folio that straddles that eof, we're
> required to discard that folio data if the user calls some function that
> extends the file length.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Hi Trond,

Sorry to dig up an old patch but I wanted to ask about this change:

> ---
>  fs/nfs/file.c      | 33 +++++++++++++++++++++++++++++++++
>  fs/nfs/inode.c     |  9 +++++++--
>  fs/nfs/internal.h  |  2 ++
>  fs/nfs/nfs42proc.c | 14 +++++++++++---
>  fs/nfs/nfstrace.h  |  1 +
>  5 files changed, 54 insertions(+), 5 deletions(-)
>
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index 86e36c630f09..af2fdbfcbbf6 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -28,6 +28,7 @@
>  #include <linux/mm.h>
>  #include <linux/pagemap.h>
>  #include <linux/gfp.h>
> +#include <linux/rmap.h>
>  #include <linux/swap.h>
>  #include <linux/compaction.h>
>
> @@ -280,6 +281,37 @@ nfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>  }
>  EXPORT_SYMBOL_GPL(nfs_file_fsync);
>
> +void nfs_truncate_last_folio(struct address_space *mapping, loff_t from,
> +			     loff_t to)

So this seems to be a slightly adjusted version of pagecache_isize_extend(),
what was it about that that didn't work for you?

It seems the main differences are - block size alignment (surely you still need
that though?) switching folio_test_dirty() for folio_test_uptodate() (I'm not
sure about this change though?) and adding the trace line.

> +{
> +	struct folio *folio;
> +
> +	if (from >= to)
> +		return;
> +
> +	folio = filemap_lock_folio(mapping, from >> PAGE_SHIFT);
> +	if (IS_ERR(folio))
> +		return;
> +
> +	if (folio_mkclean(folio))
> +		folio_mark_dirty(folio);
> +
> +	if (folio_test_uptodate(folio)) {

Really I'm confused as to why you are using folio_test_uptodate() here
rather than folio_test_dirty() as in pagecache_isize_extend()?

Wouldn't writeback have already handled this if the folio is up to date, or if
the folio was never dirty in the first place?

Shouldn't we only need to do this if the folio is dirty?

I may well be missing something here as I'm an mm developer not an fs one! So
just curious to understand this change.

Thanks, Lorenzo

> +		loff_t fpos = folio_pos(folio);
> +		size_t offset = from - fpos;
> +		size_t end = folio_size(folio);
> +
> +		if (to - fpos < end)
> +			end = to - fpos;
> +		folio_zero_segment(folio, offset, end);
> +		trace_nfs_size_truncate_folio(mapping->host, to);
> +	}
> +
> +	folio_unlock(folio);
> +	folio_put(folio);
> +}
> +EXPORT_SYMBOL_GPL(nfs_truncate_last_folio);
> +
>  /*
>   * Decide whether a read/modify/write cycle may be more efficient
>   * then a modify/write/read cycle when writing to a page in the
> @@ -356,6 +388,7 @@ static int nfs_write_begin(const struct kiocb *iocb,
>
>  	dfprintk(PAGECACHE, "NFS: write_begin(%pD2(%lu), %u@%lld)\n",
>  		file, mapping->host->i_ino, len, (long long) pos);
> +	nfs_truncate_last_folio(mapping, i_size_read(mapping->host), pos + 1);
>
>  	fgp |= fgf_set_order(len);
>  start:
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 338ef77ae423..0b141feacc52 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -716,6 +716,7 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  {
>  	struct inode *inode = d_inode(dentry);
>  	struct nfs_fattr *fattr;
> +	loff_t oldsize = i_size_read(inode);
>  	int error = 0;
>
>  	nfs_inc_stats(inode, NFSIOS_VFSSETATTR);
> @@ -731,7 +732,7 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  		if (error)
>  			return error;
>
> -		if (attr->ia_size == i_size_read(inode))
> +		if (attr->ia_size == oldsize)
>  			attr->ia_valid &= ~ATTR_SIZE;
>  	}
>
> @@ -777,8 +778,12 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	}
>
>  	error = NFS_PROTO(inode)->setattr(dentry, fattr, attr);
> -	if (error == 0)
> +	if (error == 0) {
> +		if (attr->ia_valid & ATTR_SIZE)
> +			nfs_truncate_last_folio(inode->i_mapping, oldsize,
> +						attr->ia_size);
>  		error = nfs_refresh_inode(inode, fattr);
> +	}
>  	nfs_free_fattr(fattr);
>  out:
>  	trace_nfs_setattr_exit(inode, error);
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 74d712b58423..1433ae13dba0 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -437,6 +437,8 @@ int nfs_file_release(struct inode *, struct file *);
>  int nfs_lock(struct file *, int, struct file_lock *);
>  int nfs_flock(struct file *, int, struct file_lock *);
>  int nfs_check_flags(int);
> +void nfs_truncate_last_folio(struct address_space *mapping, loff_t from,
> +			     loff_t to);
>
>  /* inode.c */
>  extern struct workqueue_struct *nfsiod_workqueue;
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 01c01f45358b..4420b8740e2f 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -137,6 +137,7 @@ int nfs42_proc_allocate(struct file *filep, loff_t offset, loff_t len)
>  		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_ALLOCATE],
>  	};
>  	struct inode *inode = file_inode(filep);
> +	loff_t oldsize = i_size_read(inode);
>  	int err;
>
>  	if (!nfs_server_capable(inode, NFS_CAP_ALLOCATE))
> @@ -145,7 +146,11 @@ int nfs42_proc_allocate(struct file *filep, loff_t offset, loff_t len)
>  	inode_lock(inode);
>
>  	err = nfs42_proc_fallocate(&msg, filep, offset, len);
> -	if (err == -EOPNOTSUPP)
> +
> +	if (err == 0)
> +		nfs_truncate_last_folio(inode->i_mapping, oldsize,
> +					offset + len);
> +	else if (err == -EOPNOTSUPP)
>  		NFS_SERVER(inode)->caps &= ~(NFS_CAP_ALLOCATE |
>  					     NFS_CAP_ZERO_RANGE);
>
> @@ -183,6 +188,7 @@ int nfs42_proc_zero_range(struct file *filep, loff_t offset, loff_t len)
>  		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_ZERO_RANGE],
>  	};
>  	struct inode *inode = file_inode(filep);
> +	loff_t oldsize = i_size_read(inode);
>  	int err;
>
>  	if (!nfs_server_capable(inode, NFS_CAP_ZERO_RANGE))
> @@ -191,9 +197,11 @@ int nfs42_proc_zero_range(struct file *filep, loff_t offset, loff_t len)
>  	inode_lock(inode);
>
>  	err = nfs42_proc_fallocate(&msg, filep, offset, len);
> -	if (err == 0)
> +	if (err == 0) {
> +		nfs_truncate_last_folio(inode->i_mapping, oldsize,
> +					offset + len);
>  		truncate_pagecache_range(inode, offset, (offset + len) -1);
> -	if (err == -EOPNOTSUPP)
> +	} else if (err == -EOPNOTSUPP)
>  		NFS_SERVER(inode)->caps &= ~NFS_CAP_ZERO_RANGE;
>
>  	inode_unlock(inode);
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index 96b1323318c2..627115179795 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -272,6 +272,7 @@ DECLARE_EVENT_CLASS(nfs_update_size_class,
>  			TP_ARGS(inode, new_size))
>
>  DEFINE_NFS_UPDATE_SIZE_EVENT(truncate);
> +DEFINE_NFS_UPDATE_SIZE_EVENT(truncate_folio);
>  DEFINE_NFS_UPDATE_SIZE_EVENT(wcc);
>  DEFINE_NFS_UPDATE_SIZE_EVENT(update);
>  DEFINE_NFS_UPDATE_SIZE_EVENT(grow);
> --
> 2.51.0
>
>

