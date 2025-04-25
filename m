Return-Path: <linux-nfs+bounces-11284-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8837EA9CCC3
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Apr 2025 17:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F3C189BE52
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Apr 2025 15:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE5B25C702;
	Fri, 25 Apr 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UoG9GjoW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vv2FpoQR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747D25C6FF;
	Fri, 25 Apr 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594545; cv=fail; b=mnJyv19pPi1cCXrW8jgmq417P0BRq51MK4rnGzLVO4G45ls9YXkxKlxOI0rCiBAY1G0RUI0KDKjyIQqUcHF0bPX3hT5k3oVuEVwG3jIDbJYdDQCl5ZKDPy0TVnhkSirUd5Hv8mSUON7nX9nhm5QEEygS0dh1Fu5o1khHelwBwXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594545; c=relaxed/simple;
	bh=4Rl45U83wdcD9cpdAuBdAc7usY7rW30uVQDPhSl9YJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kHr2+xwqD05IsQEMICG9U5U5zrl1SFvfp9PtlqYKyoc+LuLZFSC3mRKKUXrEOAzJ8z/lL/fmEpp8rJ9wYuVd7vmj7wDfOJi0dVk0yE90E3+NEbuk4Vpv4/RL/giJ666AyQl35qs1p79F0pWHoI3LHBrkh7Bx5Dl1WmYWMQyoWTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UoG9GjoW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vv2FpoQR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFH396022551;
	Fri, 25 Apr 2025 15:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0vrtDwa7Upc2xig2Zr9hPTbJbzHjxQI1Ud5jfL7nT/4=; b=
	UoG9GjoW3ua5SRBjOztFrtLB2guSNOds2JCuRC1oUr0GuZEXTpb66XaS+dKlFFm9
	p7nyU0n0F33d/HCFwpG4qxrepm2MvvZEPv9PtgYMq6BYp2L9oUBGzkCCCExIBky1
	DfcV3wmrYQ5d5VH9om0Ht2anRQDNGuL728001Cx7mINe9/sDjU+31/VjQNzyz5tY
	5bGNQ0sCPP8ePmcSKkS60pGcGJYgnXtqQv5iykxY+VUSmGqZnDxGSCIghUKoNIwl
	zyPK+XD6LeETTm3RZW9tV0IuChF6Idt1YVKTWWebkJSAFEN9IBMEYLJO82k7OEcw
	L4gr+9qPiTGq+LVHq2pQag==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468cw600aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 15:22:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PEwOdm025044;
	Fri, 25 Apr 2025 15:22:17 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011029.outbound.protection.outlook.com [40.93.13.29])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbtjcr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 15:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtcGjGgqoN/g6pU1HXp39XI64/LqFgB+60nYosE4dPiaTvLUlaIh/AXFe6j0dOjcIhaQJ19bgBjVkvsAvQrUR0HNx00SY6B8TPpabPq4oFWiw+a8KL9aIvCL8MBc3RACCmfZyxAW/krr7YyNvwo5wAwr0X69txYqAY5cxoF10uc8xBPL5wf4tpyW63qHyEwMB8ezGHfSttNAg3D44T6EfAzkc0YWb03XKeAbOkBuwgopc5azmoZMXUgKd3din+oEybBKwgsC1Kv5B1kQXMq4RuqpqueHgCTnOy6CbrYMJoLv3rg/GPpLAiFSxQ3VJWKPoSpNkvw5PUP+5o5XYxtUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vrtDwa7Upc2xig2Zr9hPTbJbzHjxQI1Ud5jfL7nT/4=;
 b=TTzwG46u2b1EbLCkzmVNqw2n7otjyyquNOsDVXzflUEN+wtTtagdid6cgb9CPM/GLARuDy3auPKA0f89c352JiZtr0y5ivMVh8pdrKPqeXnBsOLblBwdAmMEaLRT1+PJPTPqioM1bxrdb92c+eB+CTIBgku2tbWFmWXNWbcYJkaAWTvPT0nDXtSDmcAIhmxI1QRvpOdHT7U8xGlR6+C/hp+6gBC6Mu+ZnDX1GnZ1y1X3jRwpHf3mN2m0NMCZFxlzLt7VkWT82cfVLjoO8jqzg719la9xXxvHo4UujpnJukdfoiwn42AYGvZeWW+JYHfk9nYIL/iCpZDO8rbcafNDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vrtDwa7Upc2xig2Zr9hPTbJbzHjxQI1Ud5jfL7nT/4=;
 b=Vv2FpoQRkWdgmXtrnV1joNF2t6ywXbAgQ83FGdDVza4OMYLvqQU/PctT6wnahQRbkmcFZR8rpKVccyhd2MR8T7ZD+yn2BETMFOhC44D4sgT3NTubNCUT4lQNtkJAzSlme4p+REiI83jINgze6voxqh7PB+2A8tu+bTrA/8OLBzE=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 15:22:15 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%7]) with mapi id 15.20.8678.027; Fri, 25 Apr 2025
 15:22:15 +0000
Message-ID: <937be37a-9c78-4bfd-adb4-7c401d3eb626@oracle.com>
Date: Fri, 25 Apr 2025 11:22:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/033: Check that the 'fzero' operations supports
 KEEP_SIZE
To: Zorro Lang <zlang@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20250424195730.342846-1-anna@kernel.org>
 <20250424213607.GF25667@frogsfrogsfrogs>
 <20250425114406.nybdc6witc33kiae@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250425114406.nybdc6witc33kiae@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::15) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|DS7PR10MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: f58ddc63-5120-47da-1126-08dd840cf541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2dUTmk3RU50c2lxM1hCUUVPTStiVi9rWTRkZDdCYVVNbmhRRnZLejZVZEx3?=
 =?utf-8?B?WUFWWTFZc1pibFZYNXNoQkllbTg5YkUzclN1MW1xZHVWUUdSYk5vbFJuT0pm?=
 =?utf-8?B?YzVMbkdScXpUcmovV0U2elBkQ0djQzl6WW1NMi9VMjlIWk5TNDFUcWt2N2Jn?=
 =?utf-8?B?YlZTcGQyVzYzSk5PbU0wMkhxdnREQVNaN2w4ZGhMbzl3NElpd25UanJiNzRa?=
 =?utf-8?B?Zk1vREtMdThVOWVIM0FzOU53QVhvYTZ6SitwTzY1VUx3MHpKa016d091WmM2?=
 =?utf-8?B?NUNQQ3VuM0NXcktFTUpNRHRmMmMraXhxdzU1ZDNwMUZZUnliam1vMVVUa0JF?=
 =?utf-8?B?QTl5ME1yK0crWk0xbWJlU0dRMno2dVBjZGY2dE4vdlRJU2lMTm0razdMYXFu?=
 =?utf-8?B?MVkrMThDai9aMWtQRU1jMXRDV3BkdzRCNnJjRjlOTDA5allDWUR3Z2VUa0Vn?=
 =?utf-8?B?bGZOUytscm84U0phdExiRDZQSVEvQjZIakZ1VTNoNlNZOVFiM1BZcytkMkVN?=
 =?utf-8?B?ZnhBM2h3R0dMZDVib3loWTJiVmNjMWszMHV2dGNUMGhkZ01rNkRxZXBVY0Q2?=
 =?utf-8?B?RnovYUF0bldRSFNZVHp4bUx6ZVJCTDJ3QTBYZGdoTTk0aXJPbWdpa2Yzb1pI?=
 =?utf-8?B?Q3BoN29xa3VacStieDFraWJ6NkUvMDROMFg2cXExMU5yK2ZCQmdMLzA2aDhQ?=
 =?utf-8?B?T2VkaUJjUjM4a3ZaVW80VWVBMEVNMWhBVUc1dHlOWDlQVWJBdDdURzVkZFQz?=
 =?utf-8?B?TWVKUXBCejN6RmRaQjBvSHlhbDF1TTdHVEcwSGFOa054dmVtV2I4S3lRdEJy?=
 =?utf-8?B?bitYcEp0UjAzRHNRNzRFQVFLVzlKWGovSVZ5d05CZXE3M2pXUitPQ3E4aGEr?=
 =?utf-8?B?eTZjanZabDZFa3QxRWtWc3lRaStQZFpibk1DZlYzS001ck1vdTN0NDhXcnRq?=
 =?utf-8?B?UjZHUkY1K2JrWlZhUlV6R1MyU1ozd05mcFZoSEJpRHo1eHRWTjRTK3pUQndl?=
 =?utf-8?B?Z2gzeU5iV0orMllmVUVWcFV3SWdDZG9RZWZGek85N2ZiWFRZYVhLRDZ1TWNH?=
 =?utf-8?B?ZkttOWNoUWZKZlMzanZwVzB0R245V2ZLcE45N280T0Q1dlRTRnp0VUlHQlFr?=
 =?utf-8?B?a21tYnBIVVNoNXV4NlN1VlE1ZUg5RVdhNmZSYlBzRzhGWU1CZnZkUzJzRm1J?=
 =?utf-8?B?V2dabWJqQ0IxUkZ3eFNMZ240T0krNUxIb0oya0tPTlZGRU5NeGphU3p4ck1V?=
 =?utf-8?B?Nk1tbkRvZmtXcUZnRDF3eHdrOUFYTjNXQjR1YUFMZndrNjM0M3g1bEc4VWxF?=
 =?utf-8?B?S25rbTdqZ2gyTWVyM0xaK0hSRjlmeHgxUktyQnFWT0dtd2dMeG1lOThjekl2?=
 =?utf-8?B?NWZHciszak9CY0lXNFRwZHpKak15N2Jsa0hFRXRJeDg5NGN3SWhHcS9UdDQ0?=
 =?utf-8?B?NDNxTEZtWlk3OHo1K3Y1K1lBOXR4ZGRwRWY0NlJTTHRSdmc2UllOdzYrY1Iw?=
 =?utf-8?B?VWpQV0FMb1F4REN6Y3RRWkJmOUpsU0FuZE44Z3BFbnNEeXZ3UXI4MkxseWVX?=
 =?utf-8?B?N1Q1d0pBTHh5cml0Rm9ldGEyZ2ViT0oxNURRYmJqbXpYcjllTkRqZlhaSHVQ?=
 =?utf-8?B?MzNLREVjVmRZb1gzMHI3NkprUlRwVVM5M3dTUHlqRFpwRnZrV2ptaEl6MS9y?=
 =?utf-8?B?T0g3T3o2eDRYdHBRZ0JjNzd5MTZsM3lOZGltd0MrYUdLWXJVMUZTN2FlQ3F3?=
 =?utf-8?B?T1orMitlTzhtNFY4N2JLOG9rYmwveCtUOUw2WmVtTHl1dDU5YWxEL1BwTjl6?=
 =?utf-8?B?RTV1ZTY1Y3RLWXpNMGU2L3ZwRVVoUTluVjJnNS9mdjlVMGpRS0p6TCtHUkJ3?=
 =?utf-8?B?RGMvNS9adzJCRlJuOW9BcEJxOXY5dk1yZ3J1OUxLdW4zSnUwYkw3MmFFeTho?=
 =?utf-8?Q?UrNv/G61ldY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVhJVUg0VmlyTXQxd1lUaWEzZ3Vac0h4TmZYQm53bXZPVGh0cnV2dTN5cnlW?=
 =?utf-8?B?NmFTOXlQbzB1RFZHZGRRYmxZd3M2SWlDSWFON28vU052NWpKODBVVVp1Y0gw?=
 =?utf-8?B?ZTFWZnZ5SkZPYVowaFNEcW02M09hSkhTdEduQ1dBOWhEYVhocGFZaGp6Q0xk?=
 =?utf-8?B?RTBPSGtBZnhWbkRvWHlQaGJTeTJaVTBPUXUwM2JtcHN2OHE0U0hZTURqb1JY?=
 =?utf-8?B?Wlh0Tm5mYnMrOGRGcmo0QVoyQlNUY0M0UU9Gc3BrbE5jR2NRZDVNcHNVZHBT?=
 =?utf-8?B?anR1L1RzZTN1aE4xUWlqeEY1NENhbkU0ckt6SUI3MHBGNnkxYkhLYW0ydnI2?=
 =?utf-8?B?Z3lXbWhPODZENkRyNFZMNHhydW9ZUzR2YWg3MDg1UUFjRXI1cWVFZHB5YjdF?=
 =?utf-8?B?UVVMMUxIOE9xSWd4MnJQSnJGcUpBYVlRQmZ2MFdoQ25JeDlOek9iakluN1lM?=
 =?utf-8?B?Q09rS0dOaVorNEpsN3NWcjlrYzMzWjRjVUhiTWJXM0lCdWFsU29EMi9IQ1ph?=
 =?utf-8?B?eW4vSHozQTZVYjhnbjhzNHRlcWdZdnVHVW44aGdtVWJ2NUNhRWd4MEZsd0h2?=
 =?utf-8?B?ZTBZdjdTdjlYb1lEU09EWkZGVEhMWGFQOWxEczMzMG1MT2w4MzYwTS90dFpY?=
 =?utf-8?B?ZS9OeWpZMGpiWG80VTEyQmNtSEpMSHplOC9udEpVWDZHNTlKVE9TMlM2c2t1?=
 =?utf-8?B?MzJHeURjc1U4KzRKaUNSUUZhTFRFY1Mxc0FmSmlaZ08vNGNESTh1WDRHQXZR?=
 =?utf-8?B?UCt5VjF2ZjBxQm9HcFgyNUtGWDN5MVlFRU16YmV3dTZMUjJobklmTFN1dHVu?=
 =?utf-8?B?R0hKUXBwYmhPSGtXbGJVSGdUblFsM0VWN1NPSHZ4MW1ZZE12RDhQT1U1Qi93?=
 =?utf-8?B?SGJUeW1Wa0pGWUJiN3luOG1ZaEcvRW9XclNZOEx6VkRCSVRuYWt4MzNMK0Fu?=
 =?utf-8?B?Q3pMWHlLTW5FY3d6MWhlOE9CdjFRclUxcS9PVlRXZHRPWjR5dnlDajY4S29n?=
 =?utf-8?B?YlYzb0xxdHBpbkxUUG1GV3psYXRMR1RRVFd3TFhaYlNQM0o4bUpLVlFQUkRZ?=
 =?utf-8?B?ZHlMbUMrMGc4aWw1YlZtMXpFZFFSYytxaEZRTHhhWjErSElmckNiOGpodTd3?=
 =?utf-8?B?enR1TmtxQm9TdXBzMWcwUXhwYnI3QWVoNnNqN204dWVGdlhqbXZlZXI5bmpn?=
 =?utf-8?B?KzMrbGJzVExUeTVzK1BsNWZFYUVVbnZBL00wdk52Q3UvZ09FY0hqZFhIUUJU?=
 =?utf-8?B?V093STM4Skx3WlNNamhmS1BTY1NSV3dKQXJaVFVEOE5XOVV4UE16TklkYy9t?=
 =?utf-8?B?a0NSd2FSa29Ddm12U0I1SUEyVkRZRi80cE9DdjNETXlNdURMdmpMNU9MdnVo?=
 =?utf-8?B?N09tOXI5ODVxWlBFT2pCUXp0TlB2NVJKdDVnRjQ5aHczOS9OcWJ2YTh1d3Rs?=
 =?utf-8?B?ZDROaHJFZXVteUVKcHl6aUNGWDgzcGNIaG96dzBzaExEeU5pRDk0VUdTRGk4?=
 =?utf-8?B?ZFZBVEhxRnYyemZKYUwvVTNRdDMzYkF4Y3NLTmphcmNEeDdYQ1hDUGpFbzBC?=
 =?utf-8?B?emtlMkhzVnVqVnVRTFBvRGlvVE9jZUE1bTRUcXZoZ1JybHE0REk4b1Y4QUhy?=
 =?utf-8?B?UmhGRGt4VHJPaDNjb0FRL3JuNlBXakhXNTZlQVY4MkJrREdBeFBtdllpb2h1?=
 =?utf-8?B?S1EwL0tESFRrdnJiZHdTa2phUEZEazJHM2pXSEppMk1mcGtFcWxlWlIwcTQ0?=
 =?utf-8?B?TGhXV3FNK1NlVTRwUkptVHBGNVdvWm9qTm9vMS9BVlhHajJ6d3UxdjJHUm1L?=
 =?utf-8?B?Y0ZRZndoOVYzdXFIcnF4dWZmOU45UmlxT2s3Mjh1bVI2L25IVzRoVVI5NDBa?=
 =?utf-8?B?d0RubUM2WU9vQThHMjBqQUhIVnJsNXhXbWE0eXJ6U3FxVjlHdFYvdUdEVElR?=
 =?utf-8?B?Q2F6WDNNUlZwUWY1ZGRGVUtlbHRtZzZTR1E2QUt0MUYySEcvcjBjOEdFeXRo?=
 =?utf-8?B?ZUFOVVl3OHpWZ3lWNU9iUFA3ZC94d0xSUFRNVFQ0eGM5Slg3OUx6NnBpTWtM?=
 =?utf-8?B?ZXhURktrOHF2V1BKS01GVWYzbU43cVVjUzdGejZFQlpPczBVMGgzOTZiQjd1?=
 =?utf-8?B?VzI5TlBSSUFQSmdMZ3pFQy9lcEVOQVF6RWp3SGc5Q2hWNVoxWUdWUThhK2NQ?=
 =?utf-8?B?Q2luYUh3YU54blV3dEpHWXlPYnYxUyt5L0pEZitVNTNFY0QzRmE3VCtmZS9G?=
 =?utf-8?B?b0FNeWR3RjFoNjJCR05DOXdlV0h3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J6H1/RbqiHJImOF9b0rPuswbB6LRwP1Z3/x7Er4pDee9tKyfSlX2pAc9qbX7/aBUZLQ0oVmhffvwfrlqF5rz+4B1wznjLeMVYVKSjVYRAYCqfaHvj+zedjSfcdPXVebMI7hTc39vLjZ5ykPmR0xnX5fEMLTPgCdJ6hoBOvr07A9JudJfAw0oi45MM+BWT0x7FpyvHpWTqexCby0u1W8FTZOWOudoszMm43O5GMUa95GucvgYjfU5xPIlTjI4OZ4VCvkI0dVEMl84V3s3pYk8LvqC8pbGqJmzv5Sq2teZZoeJ+ljh6quv0ysuy20k1x7gjm/4VFk84xK5S2BIwzVdwBqlPienuvnQ9raAOXU416azsygrWBNUSLkzKDIg/fesSZKwqHc8+LpltCt/i5XhNiBRSkCXCvt9sfJYxZBBDVHDmCWbjRVcy29VQnG0bmFIH+Otyy32F3RckD73hMZgzbCXLBO3asMFtmYAj54h6mmEMveN8HigEYM6kjKSW9tJx5Ktz62Pu5DmrFhJvgTiuf3c5Z5MhlQI/WpZsOE/pMEj/eGBH8Aj5aTA1WJca8CJO3KmUIY+UpGh/OjQNoNQJ++zX1R1gyb+2zNubFdrn+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58ddc63-5120-47da-1126-08dd840cf541
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 15:22:15.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovBZKYoz6pfedNNGpYiqUVVZThnB/Ed9YeGgjaiYxN98g0AtBJLYLDEknIwBFocMm37KGqpzz+QV2h54qmDizikJcg5Xce6UFeJw4IkzJHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250108
X-Proofpoint-GUID: ghBPr4cHTvq9gFcYGmCcYMzmL-laiIi4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwOSBTYWx0ZWRfX0vFExaJi+3Rl wjtqARq1L4OcfAdi/+zYcxr1WDlqz21dFQivgwNCS2N9Rg0qW21m6Q5j2swyX5QwYz7ZWyDYea7 wXPp5OkNfo9ZIT8zQtEVP4Jl5ZRgJHqPh3KzA7yoUzg/BXTYZpM86UK1vKLiJD1bm1RbZL0/nXR
 jt0xouFK6l37crJ3K4y45nzgTa2mvlLwvpQFLvLdX3/IZPBXh/TPk0hIv1z1ba/mUTjLdUmJSei 7zwMnW6kHWW4YXhfAJ6gzXc8S9xLivB36xKCNE1vvGvGY650TmzWlYEjH7+ey5LSvton4NFnLze 6BghEf1yxGpSyOOv27K7ii9yscvf0TiZ01+go+G/fZ9NiBl3M8osS19Wtcf1xds4EFtmB545uKU UwBD/A/j
X-Proofpoint-ORIG-GUID: ghBPr4cHTvq9gFcYGmCcYMzmL-laiIi4



On 4/25/25 7:44 AM, Zorro Lang wrote:
> On Thu, Apr 24, 2025 at 02:36:07PM -0700, Darrick J. Wong wrote:
>> On Thu, Apr 24, 2025 at 03:57:30PM -0400, Anna Schumaker wrote:
>>> From: Anna Schumaker <anna.schumaker@oracle.com>
>>>
>>> Otherwise this test will fail on filesystems that implement
>>> FALLOC_FL_ZERO_RANGE but not the optional FALLOC_FL_KEEP_SIZE flag.
>>>
>>> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
>>> ---
>>>  tests/generic/033 | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/generic/033 b/tests/generic/033
>>> index a9a9ff5a3431..a33f6add67bf 100755
>>> --- a/tests/generic/033
>>> +++ b/tests/generic/033
>>> @@ -20,7 +20,7 @@ _begin_fstest auto quick rw zero
>>>  
>>>  # Modify as appropriate.
>>>  _require_scratch
>>> -_require_xfs_io_command "fzero"
>>> +_require_xfs_io_command "fzero" "-k"
>>
>> I wonder, does this test even need KEEP_SIZE?  It writes 64MB to the
>> file, then it fzeros every other 4k up to (64M-4k), then fzeroes
>> everything else.  AFAICT the fzero commands never exceed the file
>> size...though I could be wrong.
> 
> Hmm... I think you're right, the code logic is:
> 
>   bytes=$((64 * 1024))
>   $XFS_IO_PROG -f -c "pwrite 0 $bytes" $file
>   endoff=$((bytes - 4096))
>   for i in $(seq 0 8192 $endoff); do
>           $XFS_IO_PROG -c "fzero -k $i 4k" $file
>   done
>   for i in $(seq 4096 8192 $endoff); do
>           $XFS_IO_PROG -c "fzero -k $i 4k" $file
>   done
> 
> So looks like the offset+len isn't greater than the file size. So we
> might can remove the "-k" directly. What do you think ?

I quickly tested this with my NFS ZERO_RANGE patch, and didn't have
any problems. I'll send a v2 removing the "-k" argument in a few
minutes!

Anna

> 
> Thanks,
> Zorro
> 
>>
>> --D
>>
>>>  
>>>  _scratch_mkfs >/dev/null 2>&1
>>>  _scratch_mount
>>> -- 
>>> 2.49.0
>>>
>>>
>>
> 


