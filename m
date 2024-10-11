Return-Path: <linux-nfs+bounces-7087-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635E599A687
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 16:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E64A286121
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 14:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A8D194A66;
	Fri, 11 Oct 2024 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AJm4uHty";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yx26fgpG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D261917D9;
	Fri, 11 Oct 2024 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657573; cv=fail; b=CiXu8vfKcsXMfqeAOg1eWenP57q/KnbB3cwquJidSRYZh2ekARUpRgxksxGNeVF2xjcj74jF5QFnJ+TnOVbqKAUM8d3qN/cOgPPCqHFHHFJRxT/21pGkqSpnNXAYoh/VVjlJFwaCm8DupvwRHBSm7Nd+LQJZFfdlhSgyzwBD56w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657573; c=relaxed/simple;
	bh=nSoBqSi/Mw6akD1RsfxDb9wd77C4Rdgjf3nYQWKIgc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NHAxP1aTlyuBcc19sX5ozc+4XzOfriOCbo7WDggG62nEAaDyWULfLBU29HYlVeitGsvwVpIC/1Mnl3RqLJxvWLtx6te3JfZxw39opR6YXGU8F1OdT3Gp/TXNaE6RBbH774eJSCoy49KQR4ZodsHEyWb65rm+s/HxNRlCb+7BrLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AJm4uHty; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yx26fgpG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCpYb1025422;
	Fri, 11 Oct 2024 14:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=sC8XvH/tZTNRHxviEc
	FLo2Egpnhz8ZxbIRzfztLpxs8=; b=AJm4uHtyzsoRzucgFfaLV4lwb/p9DICKWI
	A0tOoOo+qn2tJtzs8mItAIh4zgry1g3bVTjNbAKFfo6WgB59N4mACPOD+5hRayJd
	iNYWVVJBDKk7UVQXzaXGACYXIuTZ3oc8vhuWbW4gITKBJD0XR4VnrboVPuaZpF3v
	GHCpwDctrWvUx0djxOWNHQODrQiKf7sR/dlFfoctT1yurZPuu4WuQaFyVWK0bPyb
	bMWCiyhSV3xVejou+9zAv7Oa9rj7BqnCleYvFLtPMZoVlLYzICnkJDTQceW7P9ly
	t8YHb2BqHGpH7QdOq8tPvm63ufirGn1isxKS8SML2DZm1ZoyjWeg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pmt6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 14:39:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BEBq01033310;
	Fri, 11 Oct 2024 14:39:26 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbc27h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 14:39:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fq7HP745MdYC9ccIVpaF9xX/M7l37Lt/IwgiEswIaMKBvgHuWdDvdV2zkYJGfFpGrukY1o+J5Asp1NufkhJvSCQw0Y0OirVW+tW0luxBEhWw2kPBhinLQvNh/DyLEpDzes4hpFl7jCuvBxTClVgIX3nrpfZ4qFb9GrpHxjwUAQyTN0MVqZLSni6rKAXvHDRj9TMAIxIkW4im1i69AKRjDWedhouufC0hITlnKmVD+X49mhA81Dt9sEtUj4oz0a0fVZp4NFiqFyc2Kgs1dTuKMuZXOoX0RYJkkYqUFLUv/aI17nMXY/YQqNk4sg0u4epqB9L2l9f3Pw78YAAxZ4N5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC8XvH/tZTNRHxviEcFLo2Egpnhz8ZxbIRzfztLpxs8=;
 b=lNr8FWtYCUAZQHSc8/BudSZEhrwbIcQYLDkMYT+icIGMeAuwmZCjbETm9hBuMxCapwIeYKWkVozoJ+hndttXOkjtM8E1zhsY/i5XNVTsRcInqzEGnrS/8K3nkhipeSD+yS5rQZ5TKxfK1Tr6UQhdjrkihk6jXvz089rHmhBbs5rBpu5IJqk2jHvTASRvg6RvM+j8PJjbB82F2QQFuXtm4eB7lV2T3sseF0C8zlE0b1/u/w2hzyOtx38bOtIgN/LkJBMCkeZ7TKz9lqDT2rLTqvuYkDuVrUo8yl79+/Hz6j6uaQoDx7/HrQk44sQ47XkBVEETSAF//q6TBVyTz/qVbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC8XvH/tZTNRHxviEcFLo2Egpnhz8ZxbIRzfztLpxs8=;
 b=Yx26fgpGGxuGz7re84xCp7qYjt66j3NQJt5Sa0+A3bZlJEcH6nuaICwJ90jiHTiDTyOaH7XZlTaVWO/4JOKM8Z3rVncJHRz2pUjB8tIyjaUp7IYWByjM7E/AFiY3faMPSAPMRfYfZgX+wDrHv3kgHZA0L7sZvMYnix6GKlOedTI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4359.namprd10.prod.outlook.com (2603:10b6:610:af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 14:39:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 14:39:23 +0000
Date: Fri, 11 Oct 2024 10:39:20 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] nfsd: fix race between laundromat and free_stateid
Message-ID: <Zwk4mAhnaoFe43Gy@tissot.1015granger.net>
References: <20241010221801.35462-1-okorniev@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010221801.35462-1-okorniev@redhat.com>
X-ClientProxiedBy: CH0P221CA0031.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: f14f1c69-c48f-4c33-1bce-08dcea027fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/J3T4/oK4mteCHeKc3PUhOS5NuEdgzZn8oPWvC8qroWh4laOlGLwdSrIq7CR?=
 =?us-ascii?Q?2IO51mRlWNpyBOrGbSdW/FNCQ231womLU92KImfguJPRVydUQtqzzytDkI0F?=
 =?us-ascii?Q?u2J9SYc6iAiNTkmXaIvPU28Qtp2kuzvhTGfIgtYA2YuxGhEnzTCD0dGTkBqD?=
 =?us-ascii?Q?YaxQHI2soLYnS3jLTczOacpuNrrf667w8Rp9nGP0noPvCqE4q/r422RQBBpA?=
 =?us-ascii?Q?B3NiUwD0aebnsYnwvosx3OIBAZkSdbZNGsbVErlOncGQzdO7KswPRqeb55P7?=
 =?us-ascii?Q?FWuHyAfHqLxonNvCJPDte/3AxY8p1w4XGTYrtw+ZN9pDp22/JYYa4rUi+N5T?=
 =?us-ascii?Q?tQCvqj/tS9oD+9o7cjWx5k4tSqyKFpLmSIZQFNWE91tiLY3ZiHeWtG0NSqHD?=
 =?us-ascii?Q?BcRqdlOGGo313HXK0+47gXGwI8xJABiOZB7qYlyzz/VT06d8Xnv05vxIGR3E?=
 =?us-ascii?Q?jKlv2jAEXOos5P501xwnEcpxGb2gl+dywM91jMHhR5qt77i0H9jlrkwXWVCQ?=
 =?us-ascii?Q?oTjXEmjp2i/k3IsjIpp1cSDE+TuWG74xJY9MlEE/s9cVyO+pUBBOdjGrXI8r?=
 =?us-ascii?Q?msyaomEdk7DFAlxsgAu8X/tsicl+pdBlbON7sxWLwNXgcioHBUyN9NviAseA?=
 =?us-ascii?Q?z+3BBiCchHZdmPbo4k8mgjNrWc4QsuRTPUTCEi4hdDt966+4WruHkXmOLTWf?=
 =?us-ascii?Q?/h6eSAkP5X+snIqKD0iCTkugMCm2OIe7DAaKszZ5sfUG1EZfpm2Oo0b2y389?=
 =?us-ascii?Q?NYPddjWX3vFOlXFcLRkNxP8lVzDJbKSViLwqhKg772qmGwXR6dgPERzIyUQm?=
 =?us-ascii?Q?hTdYmWlhSLYD0EaKmtXrt7+rs2jpsuJqrC1VGNhnJ5ENbNeN5+a+g8y5WTU0?=
 =?us-ascii?Q?x6aEcmpHUH8K1UUInNTQqPWh1Rf7ezw/hR/aiyZsxxCvm4uHESjNH0rAPCdi?=
 =?us-ascii?Q?MfUwxiqazV+vf71gDW/IDhaN6cK/EDk9gOJ1vj6oGq84vsTo1uc+2aqBaCcn?=
 =?us-ascii?Q?6Q+O4LPkaoVymOcPrqyG7gJJ17EHUyCk0FCeuNFpF3SMWRqsEcw5i4Lm9gkf?=
 =?us-ascii?Q?3uXPdSb14jv4waVslqh/+U+PSVXQeAmgFbOMV9Nl59rybWSwqXR9mkhjcIHQ?=
 =?us-ascii?Q?Bre/mQ67qCWtp/S/b4MS9rBHZkDK7ayecEdrVXFydTefdvsG8t6tAQD5e8YC?=
 =?us-ascii?Q?WbL104fMtGY2vvHU/oF7lWYspIUCrI4iRLwBY9qo1B9YC4dlu9ijHr5+t5ht?=
 =?us-ascii?Q?HEop5eM8a7g11XI4LSETgjGemEkPI5a7hx6pJV/DLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?euZP1rgdAs3Ta2vLHQrj3FNjAW6Hp0Ll4hYoSMhpzn4n0VC8gxyOEqjO7sd1?=
 =?us-ascii?Q?sLXG4kWvOMa+DTKL5QbSREtoSeNthXz4M1RIY+SrW3LFVD47FtUlu9rjxuvY?=
 =?us-ascii?Q?LuO4IeexZSIZiFBrow9YzlXjypRttJNgcJ4/I4Su9mS8waTB0p8RlyhPxmgq?=
 =?us-ascii?Q?2rlRjfravot8xsimRqSP0FKsMvQYSJ4a04TWdX2jM63Lf/1/CZS6gYgEKNHz?=
 =?us-ascii?Q?8OH+9/jpKPFcHcY9D9RLz4n/jP1UkKmHt1AavHEIqRyHo3noqUqcjt0eHFSU?=
 =?us-ascii?Q?WytEo2KNCEXHZ3Do0xaGkb/2fE/aq+JaJe0FyZKuZS0C49PhN8XWuYMSNNPP?=
 =?us-ascii?Q?wAkp4p6+3E/VANUUb3xbsTHkEGaurVIJkoM+UNfKehwnN5+Lk56keNveqWgh?=
 =?us-ascii?Q?UhOW2kwcJBb6Tx2LpCTPs0wKRk88109iU2i+NhqwW5e2NtHLlO4jOd754IGU?=
 =?us-ascii?Q?CKHsY33bAd99YXZ47vuN/jYd5u2Eq/NKrZO0Z8YVym3NtexhOWgVYsKVRfPH?=
 =?us-ascii?Q?CtuDMWv8o9D8y/0fAxNvlXB4j8ERd5OrgEH/FdYjqxwQu5j56SJ9SV0EClBR?=
 =?us-ascii?Q?T9noVLREmsUXj/sBz+/5gtG+eXq79M1/LGgp4whHQxg5Q4HZyEW5H+1A/olE?=
 =?us-ascii?Q?C6CgrKm8s/dxO8tu/duGuPZ+X1nS338WECi6Hju0Be+O+6VqsybYl8yRzZUL?=
 =?us-ascii?Q?SwvT1GHG8N6/TZm3IwfvxFRGCL+oQa3Zb7S+hadmIZn9xS6fE2+kbzPPfA2a?=
 =?us-ascii?Q?F3NCnQe/gxGGWtpZzsj9YaG6RvlaW3IbzdPFlX5RJoKOla1LE19F/Arb+FGL?=
 =?us-ascii?Q?QWlVaOXzp791XvUcdmFvnU/aRHl+GphDOp8sJ3T2eBlRcUSMAd4VmNgkXZGi?=
 =?us-ascii?Q?m0KhUkiyXKlvzkCQ7dRTm14YW5+NIYGqToCMwJAY2lcKsBePm+UADTq65YX/?=
 =?us-ascii?Q?Kxf+k7XvV/tTKGcAC2pjZ4IgEqvyVuqXv/G9fmATWR7vyCJc+fU5dcUf1V7P?=
 =?us-ascii?Q?OiJadm9xi0e4rC8ahshdE4wj5U6L5D5VTyfHUh6m1Nqe7uqjHkI1rpTXLQGi?=
 =?us-ascii?Q?JDzK4YsWNVa7r0T5g+Z7Td1L+ZP1dSWhFO12CBxwOtwRH4BvleT8rXpekfQM?=
 =?us-ascii?Q?wx+accM3eVYoCfrCFUMGydtk9UWLR3dGDMIH/n+vpBe/jK2u5hOVVfotsJdt?=
 =?us-ascii?Q?N2fmne4qnpg2Ah+7IOyxK2II7roqTB9hQrhiWc2czY0qBd+6yKNyK+5lfW9V?=
 =?us-ascii?Q?tfAv4GKJ6XPmGLqCCVuu1CK8k5WYj8WdXWW4nftlrgQqIwKmEwRsvtfnYUJt?=
 =?us-ascii?Q?kQld2M5P7iSQhH0jGJZdOBv7hpF1Fsd4ITfhbwAhUh2aQr/aA0RdrVq/tmoV?=
 =?us-ascii?Q?VhOj7jI4DPDkugyinrsLnzOig+Q2ushQf/HnAd5crV0mOF6Q+snhF9JZcrjc?=
 =?us-ascii?Q?1NMVcn7yZxMOcT8Fqf0b8okG1m//+bCYWaAo/gizgmmz5vIVGSR+JL8l2G3A?=
 =?us-ascii?Q?fDyUunm6bgKKP5xv7MlsRJD9ki8Fm6/7hmzSaS3JTdi9IwAiaqi3Ke4q35Vj?=
 =?us-ascii?Q?1FBzqTacKWV3HzkJIDD6G2WBxcaurvl8330QG/QJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5UwUeNf3twriP9tzniMBBwQeFgZfED/T+NljhWxKSYVqaD26AWVmrN+XSVZFZeE4+uI2H1CgDVaZyEhdLOfsqF7fRE5Ib/hdrongtDJC5XhcyGCUV/w/WK7enPnJE6bu8pvjyiTWFCYUihDfiQSnMpgMsPNWluUJ/ygyY02OIMOeV0LjcygDiVsVLiO6Jf1NmCEmpsSBg5wgW1S+V+Gyu339THTsIMJXx2DQUhV6ZRUXglFETDVuwoerAonFHnWNL+MD225VPENyErcY/w5Taj76GHYiLhcRgi3vzERvaIdi63ECiiwUMRNDna/Ch9hvAnNzouTg+3GXDLBn8HhC3MAOV4em5R8OZzXSO6KKJGF49F8Npo7OxBhplbfaSYinTYY6DlrYqXsjZSheFyDzkyoT2LJXBRWsUF40WZgLQgcnNJa7UK75XyJcv/dT8PfH7XgUyGmWojrhROcFRyBAvk0Sl+dkDaqijfqSjhAtI8YXZ+nqUn97Yz1WqIsqRqaMfExPP7T3uo3YhF3P/3QfqLFtok0WdtuEGbMM0oNOZw0M/O3G8ozdohFVUb6WKZX1KGdfaOCoWc1fnSj5cy4DDG3TB/w2cu/O6vYEdmdr/jg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14f1c69-c48f-4c33-1bce-08dcea027fba
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:39:23.4849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SQnF6I3L7NBbt1D40q1tN2Q9Q570lPr2CKhtZGMOPcwOOGUsfQa7P3As1Cvm5UgFkxbgO6kraylQJYfAHOauQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_12,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110101
X-Proofpoint-ORIG-GUID: ghIWZgFuL7U-4KxfWwYblfiWb9aiEG5V
X-Proofpoint-GUID: ghIWZgFuL7U-4KxfWwYblfiWb9aiEG5V

On Thu, Oct 10, 2024 at 06:18:01PM -0400, Olga Kornievskaia wrote:
> There is a race between laundromat handling of revoked delegations
> and a client sending free_stateid operation. Laundromat thread
> finds that delegation has expired and needs to be revoked so it
> marks the delegation stid revoked and it puts it on a reaper list
> but then it unlock the state lock and the actual delegation revocation
> happens without the lock. Once the stid is marked revoked a racing
> free_stateid processing thread does the following (1) it calls
> list_del_init() which removes it from the reaper list and (2) frees
> the delegation stid structure. The laundromat thread ends up not
> calling the revoke_delegation() function for this particular delegation
> but that means it will no release the lock lease that exists on
> the file.
> 
> Now, a new open for this file comes in and ends up finding that
> lease list isn't empty and calls nfsd_breaker_owns_lease() which ends
> up trying to derefence a freed delegation stateid. Leading to the
> followint use-after-free KASAN warning:
> 
> kernel: ==================================================================
> kernel: BUG: KASAN: slab-use-after-free in nfsd_breaker_owns_lease+0x140/0x160 [nfsd]
> kernel: Read of size 8 at addr ffff0000e73cd0c8 by task nfsd/6205
> kernel:
> kernel: CPU: 2 UID: 0 PID: 6205 Comm: nfsd Kdump: loaded Not tainted 6.11.0-rc7+ #9
> kernel: Hardware name: Apple Inc. Apple Virtualization Generic Platform, BIOS 2069.0.0.0.0 08/03/2024
> kernel: Call trace:
> kernel: dump_backtrace+0x98/0x120
> kernel: show_stack+0x1c/0x30
> kernel: dump_stack_lvl+0x80/0xe8
> kernel: print_address_description.constprop.0+0x84/0x390
> kernel: print_report+0xa4/0x268
> kernel: kasan_report+0xb4/0xf8
> kernel: __asan_report_load8_noabort+0x1c/0x28
> kernel: nfsd_breaker_owns_lease+0x140/0x160 [nfsd]
> kernel: leases_conflict+0x68/0x370
> kernel: __break_lease+0x204/0xc38
> kernel: nfsd_open_break_lease+0x8c/0xf0 [nfsd]
> kernel: nfsd_file_do_acquire+0xb3c/0x11d0 [nfsd]
> kernel: nfsd_file_acquire_opened+0x84/0x110 [nfsd]
> kernel: nfs4_get_vfs_file+0x634/0x958 [nfsd]
> kernel: nfsd4_process_open2+0xa40/0x1a40 [nfsd]
> kernel: nfsd4_open+0xa08/0xe80 [nfsd]
> kernel: nfsd4_proc_compound+0xb8c/0x2130 [nfsd]
> kernel: nfsd_dispatch+0x22c/0x718 [nfsd]
> kernel: svc_process_common+0x8e8/0x1960 [sunrpc]
> kernel: svc_process+0x3d4/0x7e0 [sunrpc]
> kernel: svc_handle_xprt+0x828/0xe10 [sunrpc]
> kernel: svc_recv+0x2cc/0x6a8 [sunrpc]
> kernel: nfsd+0x270/0x400 [nfsd]
> kernel: kthread+0x288/0x310
> kernel: ret_from_fork+0x10/0x20
> 
> Proposing to have laundromat thread hold the state_lock over both
> marking thru revoking the delegation as well as making free_stateid
> acquire state_lock before accessing the list. Making sure that
> revoke_delegation() (ie kernel_setlease(unlock)) is called for
> every delegation that was revoked and added to the reaper list.
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> 
> --- I can't figure out the Fixes: tag. Laundromat's behaviour has
> been like that forever. But the free_stateid bits wont apply before
> the 1e3577a4521e ("SUNRPC: discard sv_refcnt, and svc_get/svc_put").
> But we used that fixes tag already with a previous fix for a different
> problem.
> ---
>  fs/nfsd/nfs4state.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9c2b1d251ab3..c97907d7fb38 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6605,13 +6605,13 @@ nfs4_laundromat(struct nfsd_net *nn)
>  		unhash_delegation_locked(dp, SC_STATUS_REVOKED);
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
> -	spin_unlock(&state_lock);
>  	while (!list_empty(&reaplist)) {
>  		dp = list_first_entry(&reaplist, struct nfs4_delegation,
>  					dl_recall_lru);
>  		list_del_init(&dp->dl_recall_lru);
>  		revoke_delegation(dp);
>  	}
> +	spin_unlock(&state_lock);

Code review suggests revoke_delegation() (and in particular,
destroy_unhashed_deleg(), must not be called while holding
state_lock().


>  	spin_lock(&nn->client_lock);
>  	while (!list_empty(&nn->close_lru)) {
> @@ -7213,7 +7213,9 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		if (s->sc_status & SC_STATUS_REVOKED) {
>  			spin_unlock(&s->sc_lock);
>  			dp = delegstateid(s);
> +			spin_lock(&state_lock);
>  			list_del_init(&dp->dl_recall_lru);
> +			spin_unlock(&state_lock);

Existing code is inconsistent about how manipulation of
dl_recall_lru is protected. Most instances do use state_lock for
this purpose, but a few, including this one, use cl->cl_lock. Does
the other instance using cl_lock need review and correction as well?

I'd prefer to see this fix make the protection of dl_recall_lru
consistent everywhere.


>  			spin_unlock(&cl->cl_lock);
>  			nfs4_put_stid(s);
>  			ret = nfs_ok;
> -- 
> 2.43.5
> 

-- 
Chuck Lever

