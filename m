Return-Path: <linux-nfs+bounces-3175-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160A18BD331
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 18:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950FE1F25F0D
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9541C156C62;
	Mon,  6 May 2024 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fsvxav52";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pxM2DHgl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193F156C5B
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014349; cv=fail; b=JdKTkKXF3lKPHx1N9pakmD8mHTtC5ceP+gcWG54yBjHhEkNSOW59gyB0B1804xuQiYNrhW+e5n9AJ2hbMsdz7t+GN/H8Eqgk3Gw3AmVxXow2llWwM4Fo9v/kl4sa/2LgWvgMltKAgOnam5AHhC293v2Hpo4cd21P+h1VLhQgPpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014349; c=relaxed/simple;
	bh=XI/0pVdfttj6IlWPkps1OSDRFsyXHVAT1foIn9SAVvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LYGhDs5vk+jvTdkq3fyKvBdCNNo2uYNV3NcFZSjRu9LYgjyd62xS1xJZ7NHuSzgFTkQfi4m0MjslojNcqOoT1BS6erdsbVsSep5T5mi9u7lARGsnTU7VMEyOxTAMlmVwOiADAdOExNrFCyf37tIjHKkr9A0QrnZc+od2m3Jw+o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fsvxav52; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pxM2DHgl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446ApcQ6018813;
	Mon, 6 May 2024 16:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=orZ/Q/2cOHI9ATxsn8pibc+LPKx5k8ClHlXpXRxGYi8=;
 b=fsvxav52h+OpF3ck8gq3/gRjdbn6UFnt+eajvOI2ooaFgTFmJFVF4+tD1KmnmHbaGADe
 2/IG0CzcKxiz4nKPKnEY1SdFcYwu5Yd5RiIOHWZj11NyMw85SlVdzzHm6iZ2Jq4tUeGt
 SCMYz/kyDE+tJcfFvOqf3fD4z1pY21Sfj9z1cckGpO1E7SA9cs3EUvNgqwEvxkcv9hpO
 ZvW/um2kxC9knkDLX9oQatBeAnOtYPl397jUC4QlJOyicPoMuuhPueubWc5lvhHOMKcv
 a0pkaYyqN3OMQBie+gKTWg0M5Om+kOohZHo7PcVUvx4yZZ9+qHD/F9Xe/2LsPtuWe6Ns Bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbm5k3gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 16:52:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446GMQq7040871;
	Mon, 6 May 2024 16:52:23 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf63u74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 16:52:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRJneY9sQbRlvHRcZx1QKIragGmoNWFdVafDnTOTbYQE+NSeAk3HRsmpP+2k8WqtZPJ5Z8mObKc6YHCXvB5tU5y+xIgndzsZw5Rg/YRdkHP/Ro9AKH2VUD8+u0LjDzFRCsWhdJZa1nZCwzzEcEz20Al0zoGs1eX23KCB2eZdyV19BogcwBY/BUGZ9z5TBc/gAqn2a8SdP29Myh36T/VDxC3J3bkkLeDTNtH56m5jiMayy7tmRmoINWfXhlYa6ntEDfvcsfkyT5kKnmIi4fkdjSisl47vletAjt+ZxxwaTm3quFiEXNa1ov3ggvLnsPJ8PVOnBRy+CXeZQZ4KvOm+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orZ/Q/2cOHI9ATxsn8pibc+LPKx5k8ClHlXpXRxGYi8=;
 b=UB1QXoNeE+CNO/Ou9goz8HdBrbnm69nFB4zAMf28ySYhYGsfcH2DPpdCxQETlvc6cajgNSjJvpkHAG6RDR+dYd3Pu/EH17HzGXJxBJ1NU+S8byKHXEbjBiBkRPjBFXiMMQBw5IZoVtciddh61fX6FnWcCh37kPAEMlTCGhYpF2Gc83SxX9jn1GwZJucdjtdRSSUJu0genH+tRQ4uR5tnt/cSp6dKireY+bpck2LzeZRhujmttcb3e/4CGN1jU/Lzc5W/dOxohtuTQZxz/vROs98xfScZ6ghHgKhNUhaDIi8sQ0vstvP/xfQPefgQ3crWmBG6ZXt4HHjlrx5YGUdpdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orZ/Q/2cOHI9ATxsn8pibc+LPKx5k8ClHlXpXRxGYi8=;
 b=pxM2DHgl+IdJLd/CMlZtQVHpyNEwhdOiOny5Cr2/veFxRDqcSbg+xdZ6mhm59V3wyZGCudtC2++ODn9LwfQuTHpkIby0ot5jUW3wYeagIuED84Smcbp6TUbehVXqD3rAVEAzFYy5OIhBMJlVbEjv9NrxK2M7OUrqeSejJz4d7Gg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7538.namprd10.prod.outlook.com (2603:10b6:208:44b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 16:52:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 16:52:22 +0000
Date: Mon, 6 May 2024 12:52:20 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] knfsd: LOOKUP can return an illegal error value
Message-ID: <ZjkKxPSV+iyH8Rer@tissot.1015granger.net>
References: <20240506163005.9990-1-trondmy@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506163005.9990-1-trondmy@kernel.org>
X-ClientProxiedBy: CH0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:610:b0::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 89601f56-fbec-4164-a09d-08dc6dece657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RislS/vHUNjeBgF7gAPppUaTTLzBEL6qhpOXu5SMMUlBHJT6bGdToGtNZQZ9?=
 =?us-ascii?Q?X9GQo6TM16x0lrHU0/ucElunn9iC73kSL2kvbuBanDbhq+pER74GLI2KRfh1?=
 =?us-ascii?Q?xYjEoUp+gwtu0MB4h7zC9pAThpSL9tPPlouwgmFEDt+9WM1xiGaFv18byTk3?=
 =?us-ascii?Q?AUjM82hEwBd5OG/k2Jd7FYEwtzoVB5AV3cye/1vthS/c5vB5PiDCI0HJLucZ?=
 =?us-ascii?Q?Ymdfo/NHsyEWX7ohPfNOlvNoN4AE9gwMtgKR8c8ALB5RAb9LtGPW0Xs2DL1x?=
 =?us-ascii?Q?Yvwj9HCJfaIpkio076MUdR48RyXcyHF6LZoIAKaAIp4gr7h6J0aVBcRWHIoX?=
 =?us-ascii?Q?vHEZuiYpT6au/4mT5BCHwf86PJ+8zLBt23OVaX2lh0quVLbcywScAnJZh1qD?=
 =?us-ascii?Q?EEvJsaMwrvp8QRP6MbgZj+NnJsJBMHG/t5Gek7FoBpF3Eq8A5V+70s5qkfp2?=
 =?us-ascii?Q?GbFRWx4LCaywDbGXgPQv9DpMBAFoSQUph3Qbku0uYGywgXqUr8237dchCqhH?=
 =?us-ascii?Q?01jZYtVgQRBXqwkJXjz7id0EWI6jYyCrDw6dyZcw3VEJveCOzpNecV1hhwaU?=
 =?us-ascii?Q?PT4DHqGfqZamIaU2rovnvUvdeMi7XDy8SS9h1LUs4hgnRh781jkdJqsdoYKb?=
 =?us-ascii?Q?WdicAPwEEVTOTvMgQ0OwxQ95yCMiPUyEWFZgzX6c0Zvmfeb+o3uhVnO472GZ?=
 =?us-ascii?Q?A5pkZT3OZQOFdjjkFDg25qMZWBJc9h009BD2LI3lyxN3+CxIEp/UXPNakI5L?=
 =?us-ascii?Q?LWtr9hlpcvA7hrb0/ZN0r6OEaGXwskPeD1SDzenGbDFMMVGeLpw6oscn/AmI?=
 =?us-ascii?Q?TOufzb9VKnQhPeEfljLB2lGaYNbQq//J29NpHwS/CnjHoOmlAzMPSXZR2UNP?=
 =?us-ascii?Q?HYpUXxIxmas6BYg9/EaQDAcA/QyO8G6G+uJQAntfdjMmVdiUA6E7S9R8jk9j?=
 =?us-ascii?Q?9UcvVEPzIDHFc4MawcO7Unq2opKJDUSnS4R5LO6aZ/weC4xpt71MIVg+10Rw?=
 =?us-ascii?Q?aTdosP1Fxn1cjq2ozRD1sJdzDwJNj8lPiChisbcFomB2/Y624xDgh2mxJBF4?=
 =?us-ascii?Q?SwkagHFQrtKkjF4AxF8TDP2XDhCi9jqfh3dOeH7xXFm9j8M3vZuOcxUnUZSa?=
 =?us-ascii?Q?L3Ea7wYL7+P/RgJM4bHZfCiPm1gLoRvdxRbalakRyxhvh02QXWIXG/KpdGZD?=
 =?us-ascii?Q?wI443rYqS/1y5AvG/EdkluFC7pSfPux3l04qyMjJf0Rvwi4lU2dmtum4G33r?=
 =?us-ascii?Q?991vdFm1YdGdtGzRZrQg6Mlggi255TiNtjySlhIhtQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PE4kD4jivw98RolAFPPc6/UQxysWDe1wU7RePYhFCGuttwr33zIGfkob7oFG?=
 =?us-ascii?Q?wkp8nvBhBkkPxFBFN5GH4gjnTlGvaJL1SoNL/AM+07kuYQpb5odiT3EnF/05?=
 =?us-ascii?Q?JOmgHeUpOvf1KHtxPNWBCscnNvufSy3biWqsDgOeAb8ewyCO1GyOVlye51qq?=
 =?us-ascii?Q?vxb6ovSGtSkTO8YaXrnllLX70tO/JGCg9KttJXmRE/9qi2VZvEsDvMS9IBmN?=
 =?us-ascii?Q?8cAVq9pvQDurKjZVG1OCaKbuFpD8z6/FMuE4cnGiEE4dlcCL2w5CH4f7M9dj?=
 =?us-ascii?Q?CkTbgq0T76Bxbzum+BvuheRgvznqyW0XvDSP1zM9KVUn30xqEYXz4tNimTxl?=
 =?us-ascii?Q?mcwRhHpManIecFQZAezJBlBX47RREZfmYMQUcDuA/gwySAyIM2pZePiTPMnU?=
 =?us-ascii?Q?Ym2X9CZpudDgwYcxYY1njwmhAcaKEQGsDDCsk2Rv3hVe3zB0B8Evlf6bWZni?=
 =?us-ascii?Q?gQXETaHJMiSj3QT8NH91qTb/b1hY7qDVvWCabgolhfQT6BOa2P+qOFpj/G8X?=
 =?us-ascii?Q?I8VMLYBw0D+j//tz7xTjwuICZd3lTp2nkWIHBB/9j/1n/EO8Gppkh3MrMyLu?=
 =?us-ascii?Q?BcIvDxULWk9MSFVDzX+D96+a4aSCCCvvAb4bkimJTEZvl4jy6ci6A6AAZdUe?=
 =?us-ascii?Q?T1YJhZz7yCGNQGH/qSo8Z1DH2tJdS1RK1aXujECxpSb6H8AP/jNaUclXZOjP?=
 =?us-ascii?Q?8MjcSCLdBcml+GBGaZremNu/Tb9fTrhXPgw2dcMFRSIKpWqhKUiud4rXCBcx?=
 =?us-ascii?Q?BXzVwZqy0RPzRv2bFbQWACEn2kxERzPBR+5d5Cm4ocXZqHniYBdPMww8RKP6?=
 =?us-ascii?Q?oKNaTf0ydCmjzt3TS2MVo2F+PWYjZ/ZRpgQxTr2j5wsIcWBbw6TCfkisYQD/?=
 =?us-ascii?Q?rJPd1nOwIYdObX1Wg4M5uXvToZ6JT1mNu6ryz9OI0u5ddL6iQxpK6LMogc0g?=
 =?us-ascii?Q?09w46iWfv2YQqLRdEA5+0/eXvIN4bGzCgtTGzaudyfJgbx02q/tcrMtV9I4a?=
 =?us-ascii?Q?C1z0SKIGyul6i9FaG+Sa6fY6ffsRCG7OChg5vhK61pf5gMZD1xYiuGUPfKu5?=
 =?us-ascii?Q?e9PVjqixbQhIDpdkbVUfMQxhCHeI/xJsY8cFZL+LfUxl9LZ+xnKYHDsc6XlG?=
 =?us-ascii?Q?nM8g2xCJvnCpqMd9KMbvuAvB3ugfAkHfRdKewO0SydYxnZhkZt1hrKGjFkYQ?=
 =?us-ascii?Q?iJUUHSkZyJEhaUTtaIcmuRZ2TcSdO3ASokTsxOyZyzLmtztV43ZaykkCGgHy?=
 =?us-ascii?Q?JgdcgBxuZoGwSjv3sztgJzszUvG5j4fCmlJmr43oF+SrzYrM1m/n9GL2tm/m?=
 =?us-ascii?Q?boRfl616QUFYrOt3aKqhAZUPiF+St3F4RCJ+07yHpnumuk8BW73s4jIODP2h?=
 =?us-ascii?Q?8kpWETT50lv3ggOxSxjysrBuTwtvuN5rh3dzS7/lNvu/Laf6kVtQTS3MeaF2?=
 =?us-ascii?Q?g5HMttx3jg2zLwqRPl1qe7xABlv0XEACdOQEwLOqNFc0giZrGTmD0qrbV4i+?=
 =?us-ascii?Q?Gft582IbagAdztuXwQ7l/4TNWfBqjtFSRjfboBVC3KRCrE8Ekyu4j413ZDWF?=
 =?us-ascii?Q?8xC1NofU70XQu2IrqyxtrxfJEHpNshD4UMos5XTqDko613y4NjhYoRs3p9CE?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	p8xnslCHBfQGLykHCKDtKxlVos7sJbUwQFYvS3Pt74vc1ruiAH0poPWsTJnh7PrRfGE9X3VppvbQ4LiLgcOd29Q5mnjgRXLNPkEOA9f9dQ4GCTLiyZ0bCsPur/Ypeh8v59CpmhmgBWLspdJui/wr11NOM2IBsW9tVfooDUIh+9rQGJMQfHXQcHRy9BP08DNzddY7hMFxGX66HpOV9wU5RTSryeJuIYsjexzcef1ekQSEtIoWpTgZgrecCxxzUNnBPWIBrAu72s3fmqQUSQQdGOlyjuM5zdbqf+dgBNepfYtzqpEao5VHlZpEGwCxyuBJc5fw+EHzgH6HQ8ZSlQKuLM3NZ8PqxOBo1y0zcrFcVM5Otg6I2eNZrnEbyM+RTb0uFTtv9M/Q7N/WYnN6UqWzacUGi2jLevyA4PycLV9Wcc+Dp/358pJ3qXbjx2B/BsTdLZjGBo+vrqmPz7BpnqXoyFBPakoAOL5FdPlnKXtKZxao+TcUVxc4n4SZng58FRsrmCgeL68hcl9RAOgt/JEWzNTiagk3qY8DmKRUJAJkAisOsbxOkYTx2a8roGEHBn+8n31XTM39lXwLHLgWhx/rb8BvlKYAhzUm5K7svXwb5vM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89601f56-fbec-4164-a09d-08dc6dece657
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 16:52:22.4903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJvP3++D0w7YN0pP1/VVJBBroVUWubO33kJgiJSZbfCX4v2wmkaVgqllR3ftlg1GIIfM0+krWVEprBzwLtYFFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_11,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=906 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060118
X-Proofpoint-GUID: aprUWHiKx9_aPwtIYu4OWUjYKUU9QtdR
X-Proofpoint-ORIG-GUID: aprUWHiKx9_aPwtIYu4OWUjYKUU9QtdR

On Mon, May 06, 2024 at 12:30:04PM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> The 'NFS error' NFSERR_OPNOTSUPP is not described by any of the official
> NFS related RFCs, but appears to have snuck into some older .x files for
> NFSv2.
> Either way, it is not in RFC1094, RFC1813 or any of the NFSv4 RFCs, so
> should not be returned by the knfsd server, and particularly not by the
> "LOOKUP" operation.
> 
> Instead, let's return NFSERR_STALE, which is more appropriate if the
> filesystem encodes the filehandle as FILEID_INVALID.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/nfsfh.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Hi, both applied to nfsd-next (for v6.10). Thanks!


> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index dbfa0ac13564..d41e7630eb7a 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -572,7 +572,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
>  		_fh_update(fhp, exp, dentry);
>  	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID) {
>  		fh_put(fhp);
> -		return nfserr_opnotsupp;
> +		return nfserr_stale;
>  	}
>  
>  	return 0;
> @@ -598,7 +598,7 @@ fh_update(struct svc_fh *fhp)
>  
>  	_fh_update(fhp, fhp->fh_export, dentry);
>  	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID)
> -		return nfserr_opnotsupp;
> +		return nfserr_stale;
>  	return 0;
>  out_bad:
>  	printk(KERN_ERR "fh_update: fh not verified!\n");
> -- 
> 2.45.0
> 

-- 
Chuck Lever

