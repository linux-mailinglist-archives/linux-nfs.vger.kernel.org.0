Return-Path: <linux-nfs+bounces-8145-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E849D31E3
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 02:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C05D283615
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 01:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA13A920;
	Wed, 20 Nov 2024 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mcYPJsvB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vgyraqmG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E504C168DA
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 01:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732066056; cv=fail; b=kzOUyNqFI1KsHSzySxi0D/rLwi+WDNwtLyFUgWVFjZb6+Eaeq4sXjuTTQ4Q3U6fbuJEa5IT0HhafEN6YQv1wiMLNtuVTD/kJRAK4T9fGuA6eTHZrlR+G5NclnOAL2wSQKjN0JAVMBl1yuQ/GurGCYGaMx9hux/5QEBaasIP45g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732066056; c=relaxed/simple;
	bh=SiAik3CqqTWpEzCbwZvOkqbz9upOqWYZtBh4FwH5mcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SRV+9ItD1e7SRmpTn5AflbUMUF9l4noxyJnHGC5XMopPtIIwuaTEFfmSOzDJx5tbqcLJ58DGiZEnu4+b1r1t04blwTwq+l/ovVil5dHSbZo0q9GxfHt6+iIMsNJOT7A+lbkDFZDFdCs8HlfzVK8WgaAx3lqwLG+9T8vPv8kN85s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mcYPJsvB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vgyraqmG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJMfoNc024692;
	Wed, 20 Nov 2024 01:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=d2Gh9I43VwQJTDRS7y
	DfsL5aPOdooiSVzQ/JoXfIgfo=; b=mcYPJsvBsbE8dza0wxaM0+rSAVdQWlaUB/
	8GLLIP1OR2Cn8bdLAZaD4AMC/8xQJ4LsLGKhck28kUa8bxL1FSPc0O1h2vdnaYTu
	rSSq9WruhoFq2AT8WyC8iXX4dol9MKEf1sIsN8jlofdvvDM+Lafg/fW9TDQPNgaa
	SEM6P8zIXkfcW15JH7NvpEsMdH/nQy3xd9H8DjSahukP2vX4IEMrWUWlmoAifUiQ
	SWDVLTAHFuDxNEPqsaVQ5HKvJ7Fl7Nuy8cjMSPzHDecNkQ7Wq8X3vzpn/kglriIx
	Gg+3Wo7FKXlr0a49PXZIESfbIX/G/mKNAbHJaz9gtYGbRWCX7xTA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa6d9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 01:27:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK0gdUx009067;
	Wed, 20 Nov 2024 01:27:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu9jekw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 01:27:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYdAmwptw1Xx/6Dhb+FdUuMD26sP7OgNhd+26CvbfeWdfIpS/dkExgVK/NMfFGsjcQ+i6mekgXxz8fiHLGZQnnl3NWt/SBDsCnn4GvjKnhW1zgDwFpe5jeLhT1hXqXc+MAUXI9gm0iixcL5IMWB976t++djUZweDGvuFzYgos6BGVD0GZCj5TdxZrxiBZ0ZTBT21VTLgFBZJ2+lPGhLB3VJNun50b5f8hxWOmdn1EH349nnbhid3i4YNdr69kEBiXLeI1urcIQsSPfwfmvBSJ6qDSxGb8s1PdR606UUVlkCHTWKkXpsG0yTiP7l2k1eTq0XC0wng75sjhoNIocOFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2Gh9I43VwQJTDRS7yDfsL5aPOdooiSVzQ/JoXfIgfo=;
 b=foKXY63Ujt3JwgcpaH3lrL1+Km5oBZn7fMp/r3ZXjzI8llnZ4jYGTRSNK6vGk2GDoACTq9ZVIBTfZqRL5eNlMXMPfdW21JooRBkdKxx0ZPwXR1PedSGVhMU7WRvdqEi7etTH3UysBiXPf12z55nZVdv0P6RDExvGF9iVdvtk7E+rz2RhW0IN3lHmfFNJFmP7DBIEmWeUfPDx/eiL8wtxfLHhxpBuBi/YiN4n8cdTo05Y+NE3rruB5NPNgh/dO4M+tYNttaFjsu0ajnvlZeFUpM817tTc/UbBFfqETwkRKWxEo0wD/+JdQe4oB/qbmqbgrBd1esuo3VobTDKtPQuaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2Gh9I43VwQJTDRS7yDfsL5aPOdooiSVzQ/JoXfIgfo=;
 b=vgyraqmGOke4LjSjOkn8/vGn1vLiDM8TatqsqOmFb0WVvo/8P3gQ1IIE3vQh/oekAvLwISsjNpaG91befZlUZYzTmcVHJQD/XZIg9VuL+1gbOH+9FDjlCDHPUwl6TFO6RHle7SJQGIcVUSAZvq81zCJzSkNHV0Muaa9dclgyoNQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5543.namprd10.prod.outlook.com (2603:10b6:806:1ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 01:27:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 01:27:21 +0000
Date: Tue, 19 Nov 2024 20:27:18 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 5/6] nfsd: add support for freeing unused session-DRC
 slots
Message-ID: <Zz069lQT2WOgR4EC@tissot.1015granger.net>
References: <>
 <ZzzmN2ZTPkvf+Vl8@tissot.1015granger.net>
 <173205570058.1734440.4487071386768199899@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173205570058.1734440.4487071386768199899@noble.neil.brown.name>
X-ClientProxiedBy: CH5PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5543:EE_
X-MS-Office365-Filtering-Correlation-Id: 84baea3e-94bc-46d6-1baf-08dd09027ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xrps5K3n/cTzGHoJT25hx2kJEk3GEGe3d7IXt6HFFiNPBL0vTjpYQVX7ogoc?=
 =?us-ascii?Q?aMEyGyHBF5l2U124C2AejcoMJayE0kuDMV2EDmSzdsDY9hsdHFhIFbrHRL0b?=
 =?us-ascii?Q?cuCnaQb3zbi9vEhL/40Zjuh/ateBMPPmeT2BCTCyF33GUmRDeuBJ2R1nkgZV?=
 =?us-ascii?Q?BwUZyQySPHC7295sHiXMkWsOfMYdMmok5CDNWMB749sgfw2PwSar09RygkXl?=
 =?us-ascii?Q?jjt4zIWmSq8ShThgb+xvvMGGyxNlDyz8PIrsIZSMXtcGfFMtsXxAGsxkf5DF?=
 =?us-ascii?Q?NqZt2GjSu0pSs58GLOqC6uroLB8jTdC3RDmAD4fITrL2AMa5WmvG21WN81V5?=
 =?us-ascii?Q?hcpFcPS4+sg8vWRSm2ovumURkxHp5Btpn9DFXqKCbpQmKnp4v6q7NGSqrrgl?=
 =?us-ascii?Q?0rnwP/OnfFH7VN4QFEKgv2q5b2aLV9TDkAMbd2uM0j/r5VUViwLIkr/thOVL?=
 =?us-ascii?Q?20Mtj2nf1rFsbcXdV7ibZo3IJ5r7GCL8poqf2enAValGq9OscU06ArLjPV14?=
 =?us-ascii?Q?fNU7l18iMTptM5r7OKYOOKqugXXnHLDxvHYhsXg7j71AStZ+aQvOEQriZ/kJ?=
 =?us-ascii?Q?HNwKjeEkSVxaVi0kZENIO+oop9VaFHtu4pyWlnPf6vmzwbedhGtB3xAhXyQk?=
 =?us-ascii?Q?vJiOXYqy/aspql0gYDmd/y/0p3nuaMM4eweX7HRrDMx7RXdnxcMPdJMg2zNQ?=
 =?us-ascii?Q?DhAv/9FiIIuUIMWcqPkn2suDkcOlEqB3BtxYpGsnHffNNqIoy0qDvcWYcTxB?=
 =?us-ascii?Q?R7FYXRuJpfJc9kyb9ISmSOM0f3YWBzGWu6BaKm1mqae/oOzKKjZ2Gzm8GboJ?=
 =?us-ascii?Q?TIc/orN5RaZHi6CAc+NSTuPVRHGoQbq/BjE/A2FPqb6aQavtyTuRzVxAbuY+?=
 =?us-ascii?Q?95Cc2HlWSP9bRKamm++GCzdJMNrENTjBu3SzpUEChLEZ7eKZvES6Ov74CRIU?=
 =?us-ascii?Q?OEkswR90j02WQiRS/51qvMZ4UuOp2pyS+/r6q9pmH/JO6ikUiD11/M3lE0gw?=
 =?us-ascii?Q?6DpX6DpREp/V77TlNbZN/5cTVX32Z2fWUepoxCMbGiZ47M4+ZwjuHu+dL3KQ?=
 =?us-ascii?Q?HW2c4AwHZ5XRaaHLPiPeLw998CbLCgAZbPLvH8EAppbKXGK7LRlI8qy82bpe?=
 =?us-ascii?Q?WwvrSoC9qgOqClZdW4NaFve4G9qIBkOoLrRx0wz/S9k0mXc3my07Cgbbnlgv?=
 =?us-ascii?Q?NEfXndGiDyt41PB+i4klxoMqUdjqZQsJzV523aespcsB3MPDtN2sYzqwdIfD?=
 =?us-ascii?Q?Nc2k2jDkg6W7bHtCRrjYCiXUdcqIY4Q3Vj0p1656ece/TT/3dm53hs9BAtZY?=
 =?us-ascii?Q?HawsURp2woBI/BlWsnH/a5oh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i2X4FDrDKhLkIFj58uvwazBK2fwAH4wJd1WD5xOwxqpynjWtSj/o28GqgCxC?=
 =?us-ascii?Q?/P3BjNGTvv6Ksk4G+2EzH3XZpgIf9ThTn15mhRhFigO+vkebZhpXJZbZsYMY?=
 =?us-ascii?Q?/Sp3J2iaP5Iy59MnFxdQ8tsxrydS8MFwPs1G2g7aGfmi8OVUPVYmrE2bup5/?=
 =?us-ascii?Q?Eq+8+PGpIMaoKwVLMidXtV3Mucr2Krd8TxJwU1mQDsY3/Ox/yGWywedmTFno?=
 =?us-ascii?Q?4yq5VSJy8g5haXXbpCc5Ho7pHZYGe6w0t46Tm69K4+RJ/vmwveQahqAaaaKl?=
 =?us-ascii?Q?6sBJD9F/7poYRrfbNufOeyGwl73hWx63xCgbEb3zGhOxMHznP0PCssa+scz2?=
 =?us-ascii?Q?djw4Wd1R5XCfg3e/HyNBWFLy/6JSZ2Tg0OEyBqoJ38rZwYyGSXxFu5HH5xMS?=
 =?us-ascii?Q?4pWidbCotx7ctNwSmz3jgufrjNtrBlPy5JSERaglajiPHdET4xUY+hifZ8AF?=
 =?us-ascii?Q?SwahP3hmHAA01LhBU0GyXPH9JDdOeK542ZFKJ+CANgN/t++wQIOAGsp3B2cV?=
 =?us-ascii?Q?C9FQL6ow1su8AfcouOmOyr/J2DYc44L2uPpfEULI7unJ6OS7JcO7KZqcJPs8?=
 =?us-ascii?Q?8OXZvI2vqPOgsRwijXGreVafqAha9eDsZYp2JmUy8tYQ1BcgWF4iYGW3ROry?=
 =?us-ascii?Q?ksZjId77FWRsgnKv2bUwX46H71ibI8uiGWqGPXUyVWuTke++bzA7W3Lcpp+a?=
 =?us-ascii?Q?X7j2Dcmm22F57HTpqfAiIklxnPbeAKZYMd52gOb62zpor8fkjvcbG0NgJby0?=
 =?us-ascii?Q?mdMGUtybra9tcp/PJBcvpPCPLrd1Bkcpvb1hkKBDYDrGiEhFUBcf5M5I8jsn?=
 =?us-ascii?Q?VOWynDXUrBzuCx001KYO3fXEJnYj3m5KwTIq8+QrZndUoDOdCso+kSkNaLQi?=
 =?us-ascii?Q?+Ec5HcMvMvliBRM1+8muoswZvIqDGkBkd0+v0Z8x16YPTsPJb4q7hL89SiK7?=
 =?us-ascii?Q?ecJZOdGRbt64qNLDB4rcbTbuq/ZwqtzqSazkF9vWLZj8yzBjUwG08NX6u+xC?=
 =?us-ascii?Q?HpXE/mh/lKQKlfIkgFzMLfNSKrf7NkGP2bMPJt8AKr6O7G5QPHfDT+wVzsmx?=
 =?us-ascii?Q?4h3CITdUhoBbZe/K9jg0uMwjmiOijTyNPYo78XhIraP6CjMHTJIQkof29uQk?=
 =?us-ascii?Q?y3aKO0aTN6MaQnXKeStvAvE+yq+9T93q42/F6tihzRWZY1VJoyth5DDkzK2a?=
 =?us-ascii?Q?F68YUvaNPReKqmPuN3r1QEUSfOdFPcFLVypbs/WxePAblULlx6uQ92CEmOj0?=
 =?us-ascii?Q?TWVBYgi25FKOHFgN+G5PeBHPpKps4znK4XK/qM2yNV9nK4fqzhozrkENZDhJ?=
 =?us-ascii?Q?QxiXly2G7/1fAxl1orF+Bro1jWnGWNCYKhSjuilL4Er2aVMFn3abJf5XM26d?=
 =?us-ascii?Q?e7A4m10jqs7RyH2SD7SIsVuEXtAdcHQX4Lm3sV41GzS/chuRfkR/V3plgdUf?=
 =?us-ascii?Q?XhWSqZ+mC4cEu4rReIbsWccvmYkoMbkSIyTT/Y8ek8wVgyS1k8yx3qmL2Zlt?=
 =?us-ascii?Q?ZeqGo79GD2ym9PkAwArF5w5p7pmY7yfr5dyzsU7zBEVsVVdrkrhp+dXNGPjz?=
 =?us-ascii?Q?MkuUUYbvTCfyTImb4QQQkiHpdBKROTOf+zrEyppeuu3uRPOFNcU6k8RZTXWn?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+m/8mZ2xO0NjzK0RGmgmEuqKqdYClXFeaml/83b8qJbSRSfl8hhbmWj4ROREjHxcYeyZ///F6RsoptgrFQOyqFO3Kz9BWSVk9p5jTSV4U+c4Ibvtagj76Wqpb9r8sdz0SCiTDzxl9UNe68/Ubba0alTT7iuWCV9VffiyUmigqCvwpINfD652PlwJi9Lj9pxr83XuhJwsfDqsZBohtq+YoMqQ5je86DcG3RMQSUvebIOFkByAoCHIwE4jGhxUCxs4VJeI+1zb95Afp9j3ScBRiSIRvk3XANCa+CyWLt+A6QOUrBG6khARS+zn6LmKv2cn9x5ewPsBq55VMsruKoap9mVPN19bqLPIXasFriroXfw/N3p9Ev7b5yVk5G1ZQ1t4KFM+qVMNEtkw8TyAdW8IlLvImIsFhO32FTicK0zZNDHKhwEd5wjN0k9Tr61gbIx3yMcB+fnz0vuncsGqwSkrcVdeHU8v0ex6McgE9JZ2Ei9sM1J4RuIqVJZHQk+Z7pZUoimJd0u35+14xLa4H/fK/zTlXdGUOrngOataPeoHScsmyXtpFL49DUz/C3tpgOw7oAhugLHSNoL7J2Jq330wbAtDCoO6cXifaU+1mmaqtVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84baea3e-94bc-46d6-1baf-08dd09027ada
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 01:27:21.4981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0BEQhEFDFQGM5fQjMvTHX9j6YiDqo0h5Tnufolhf9DOOXkhYl7vqBuioMQytCIW+9GVLkHfyGEuIyhF+eezDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_16,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411200010
X-Proofpoint-ORIG-GUID: BAlvR0GtAosQV5bonaJ3Irh19hD9lGvR
X-Proofpoint-GUID: BAlvR0GtAosQV5bonaJ3Irh19hD9lGvR

On Wed, Nov 20, 2024 at 09:35:00AM +1100, NeilBrown wrote:
> On Wed, 20 Nov 2024, Chuck Lever wrote:
> > On Tue, Nov 19, 2024 at 11:41:32AM +1100, NeilBrown wrote:
> > > Reducing the number of slots in the session slot table requires
> > > confirmation from the client.  This patch adds reduce_session_slots()
> > > which starts the process of getting confirmation, but never calls it.
> > > That will come in a later patch.
> > > 
> > > Before we can free a slot we need to confirm that the client won't try
> > > to use it again.  This involves returning a lower cr_maxrequests in a
> > > SEQUENCE reply and then seeing a ca_maxrequests on the same slot which
> > > is not larger than we limit we are trying to impose.  So for each slot
> > > we need to remember that we have sent a reduced cr_maxrequests.
> > > 
> > > To achieve this we introduce a concept of request "generations".  Each
> > > time we decide to reduce cr_maxrequests we increment the generation
> > > number, and record this when we return the lower cr_maxrequests to the
> > > client.  When a slot with the current generation reports a low
> > > ca_maxrequests, we commit to that level and free extra slots.
> > > 
> > > We use an 8 bit generation number (64 seems wasteful) and if it cycles
> > > we iterate all slots and reset the generation number to avoid false matches.
> > > 
> > > When we free a slot we store the seqid in the slot pointer so that it can
> > > be restored when we reactivate the slot.  The RFC can be read as
> > > suggesting that the slot number could restart from one after a slot is
> > > retired and reactivated, but also suggests that retiring slots is not
> > > required.  So when we reactive a slot we accept with the next seqid in
> > > sequence, or 1.
> > > 
> > > When decoding sa_highest_slotid into maxslots we need to add 1 - this
> > > matches how it is encoded for the reply.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/nfs4state.c | 81 ++++++++++++++++++++++++++++++++++++++-------
> > >  fs/nfsd/nfs4xdr.c   |  5 +--
> > >  fs/nfsd/state.h     |  4 +++
> > >  fs/nfsd/xdr4.h      |  2 --
> > >  4 files changed, 76 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index fb522165b376..0625b0aec6b8 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -1910,17 +1910,55 @@ gen_sessionid(struct nfsd4_session *ses)
> > >  #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
> > >  
> > >  static void
> > > -free_session_slots(struct nfsd4_session *ses)
> > > +free_session_slots(struct nfsd4_session *ses, int from)
> > >  {
> > >  	int i;
> > >  
> > > -	for (i = 0; i < ses->se_fchannel.maxreqs; i++) {
> > > +	if (from >= ses->se_fchannel.maxreqs)
> > > +		return;
> > > +
> > > +	for (i = from; i < ses->se_fchannel.maxreqs; i++) {
> > >  		struct nfsd4_slot *slot = xa_load(&ses->se_slots, i);
> > >  
> > > -		xa_erase(&ses->se_slots, i);
> > > +		/*
> > > +		 * Save the seqid in case we reactivate this slot.
> > > +		 * This will never require a memory allocation so GFP
> > > +		 * flag is irrelevant
> > > +		 */
> > > +		xa_store(&ses->se_slots, i, xa_mk_value(slot->sl_seqid),
> > > +			 GFP_ATOMIC);
> > 
> > Again... ATOMIC is probably not what we want here, even if it is
> > only documentary.
> 
> Why not?  It might be called under a spinlock so GFP_KERNEL might trigger
> a warning.

I find using GFP_ATOMIC here to be confusing -- it requests
allocation from special memory reserves and is to be used in
situations where allocation might result in system failure. That is
clearly not the case here, and the resulting memory allocation might
be long-lived.

I see the comment that says memory won't actually be allocated. I'm
not sure that's the way xa_store() works, however.

I don't immediately see another good choice, however. I can reach
out to Matthew and Liam and see if they have a better idea.


> > And, I thought we determined that an unretired slot had a sequence
> > number that is reset. Why save the slot's seqid? If I'm missing
> > something, the comment here should be bolstered to explain it.
> 
> It isn't clear to me that we determined that - only the some people
> asserted it.

From what I've read, everyone else who responded has said "use one".
And they have provided enough spec quotations that 1 seems like the
right initial slot sequence number value, always.

You should trust Tom Talpey's opinion on this. He was directly
involved 25 years ago when sessions were invented in DAFS and then
transferred into the NFSv4.1 protocol.


> Until the spec is clarified I think it is safest to be cautious.

The usual line we draw for adding code/features/complexity is the
proposer must demonstrate a use case for it. So far I have not seen
a client implementation that needs a server to remember the sequence
number in a slot that has been shrunken and then re-activated.

Will this dead slot be subject to being freed by the session
shrinker?

But the proposed implementation accepts 1 in this case, and it
doesn't seem tremendously difficult to remove the "remember the
seqid" mechanism once it has been codified to everyone's
satisfaction. So I won't belabor the point.


-- 
Chuck Lever

