Return-Path: <linux-nfs+bounces-4067-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 724DF90ED7B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 15:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059A21F213C6
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 13:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E5012FB27;
	Wed, 19 Jun 2024 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fVdA2E0v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hbxC3t3Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2028582495
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803120; cv=fail; b=Uw9tZvvNtGLjkSXNZwElHms+eMOcHv7SODRD3WkzLF6nSohldHSR8irvNLINBax2slJsJUpZodvNy6DJ6HELnrS03104Nt7l4DPakBrPsz3vlm6DiEce3QaEVixtzItLOswDHDdGAbcPbV5Mit1Aq+iCzZv7Q9K4EZQ/n6OcPRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803120; c=relaxed/simple;
	bh=qd+54UFqRkaWnMAUXYh0u1AhGu1vw2hZVdNh7HW4+20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JYUsOVcYxz9srrS6BfuU8IRYj6Tq2JHMEJHkzmVCs5Pg3BmdLL7OkXn1rOc1B//Nc/703YEW5bnt3R4r3dV6Ea+aZnryh/TT35rBMB74iC4iDI4qzCrlqA2pGDZkxahSCw0hkjitb74hDRlUy1/8bJgv1fBC9p3dfDpPVXd7oI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fVdA2E0v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hbxC3t3Y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J1tlIC028445;
	Wed, 19 Jun 2024 13:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=qd+54UFqRkaWnMAUXYh0u1AhGu1vw2hZVdNh7HW4+
	20=; b=fVdA2E0vro7P2/EsPYPBYhE5BJ+e/jHjpVNXM5TOrGVxgfZegIM6soa6P
	gyoQpYnWwF+BubJpkYeVq99kRyzN0KnZzfocznBHUEsomIjb3cKT1uMWEBbXrFO+
	zUz31gul+pGDuECUTgReg+Oa7fFcKAQX3MXxrrg8WP51yBhvap3f3afSYM52WWMC
	OaR7aomesuCRjj27iDDwlVDGRKKD+HnOAejY1dFTmKN4lkrQPFFxzQlIQj9VW74k
	oDIvg/8WrRe2q+9NvkZk+BjAH/+EdNLMKwE9bTdSLkS3/aiW19hq7JWAMwNSKasI
	epeF59LAasyVjYg8uzYd+IrV3jrEQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yujc0985r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 13:18:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45JBeFmq029125;
	Wed, 19 Jun 2024 13:18:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d9kguq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 13:18:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g57PhXfUB+LgB1YZsbN6WwsK4rmdrL+NsIZBhu2GL8UenWW/1/8LEkYzIYUJmFGU06zcKHhaJwspQ4ERSRKTIPn06Tqa3kYIyJQYEQQcsbwD4EFnI547CGTjh71z678OC+zp7HPCSvnosHHvXANr7uZcm5CfC5fbgTzrOQ5mNpAqfsPFbcV7BK+XytIWSBPTG4k5+F9VJRE3LRqIvr/44IwJM0eJyE7qWzYFDGcwmbEGN3agrVxhUZrfp3W7AJnUJBkHOILmj79oQw/di2wfv0vUIZKL+geRgACcEJl6g5uo57KbM+Nz7bw1/TZv/eFqbY9ROmMtG0e13PGdttFQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qd+54UFqRkaWnMAUXYh0u1AhGu1vw2hZVdNh7HW4+20=;
 b=jaUbsnSn/08QDvTFTXT3tie03KdSlOVIk42VHmfRSIEMxlybPWStrS/U4jaJuiLjD2o8FR3aCusEyQPFG0b59sn4j7Yy9HMcp5vxUAoKHEsFFCNGzsrCN1dO9ia55URAltGVID9zdo1yQeO+W+0aqHUY10mFFq8n/NgP/fm5b09qbzyNa7snEY80MF5RDZCyxEGB6SP2J/ATCoB+DPPmCET3w6pD1lP/JCpfBVrOeHS//XChZIpgBuK4/7bxuYVzLjQbzqqgJoRIVP2aL6ouR4QKIeOdq9rIR3GuN/9gP4AA+gNoW/L1H6sW/kvzMT7ZlpmyMChaBpnpoWjOh6MOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd+54UFqRkaWnMAUXYh0u1AhGu1vw2hZVdNh7HW4+20=;
 b=hbxC3t3Yf5Rfj7W2o3Ers+V9usGJJ0doxE+LKABTtZaFwAgU67BU3M/IFE4dLia48Ys0NBqz7XpE+kuOoc+UEViRxuZCySVbPwgtu7t78NB0bKq+g/vcVBDM/eN7eGJTYVEO2KALn/L81bgH7tuhqPDnpPqh3nCsbDg6QHY0qA4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4459.namprd10.prod.outlook.com (2603:10b6:806:11f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 13:18:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 13:18:24 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>, Mike Snitzer <snitzer@kernel.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton
	<jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v5 09/19] nfs: implement v3 and v4 client support for
 NFS_LOCALIO_PROGRAM
Thread-Topic: [PATCH v5 09/19] nfs: implement v3 and v4 client support for
 NFS_LOCALIO_PROGRAM
Thread-Index: AQHawbzudcjcZ1PWYUG0qgNc11Pd4bHOkEGAgACCjAA=
Date: Wed, 19 Jun 2024 13:18:24 +0000
Message-ID: <BC9847A0-4119-48E9-AD41-B6B1F490F0E7@oracle.com>
References: <20240618201949.81977-1-snitzer@kernel.org>
 <20240618201949.81977-10-snitzer@kernel.org>
 <171877505925.14261.8038886761089867261@noble.neil.brown.name>
In-Reply-To: <171877505925.14261.8038886761089867261@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4459:EE_
x-ms-office365-filtering-correlation-id: 88070c82-4b3e-49d3-98c9-08dc90624ccc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?b0U1a3IxVG9IK0YxUjVkaE96N3ZmanpjcEtQVFVkejFWVGZsY2JuMU5FL0Ry?=
 =?utf-8?B?QlNJd1RZSi9yMVpWTmJiWHFwUGw2cVRFdWJMNlpYdW1DcFNjbVRCZFNFWE1N?=
 =?utf-8?B?aEozYmNwbXZBT2VZODB1L0szRFNzbVJMYngvQk9ZRGlGcGI5MUxOL1g0RUV4?=
 =?utf-8?B?QXhxNWhzZjh3WG4wejFCa2ZSUDZtdWtrU3RnNExGV2FGa2g2cTMxaUsybW0w?=
 =?utf-8?B?UTMvUElib210a3BmUUt4azBsZzQ4OExDZFVhU2FWN3hYd3pzSXIrL0YvdzRx?=
 =?utf-8?B?ZWo1OXAwMXJpd0tFQ1Q3WkY3UGxuMGIrWFE3VEQvSTlTV3JCVWY4eUcycXh5?=
 =?utf-8?B?STVjR1l3OXRYNHVjTTR2SDF3cFpYUW83elNYNXRpRnRiZWIvSEVWWmMrb3cx?=
 =?utf-8?B?bWhQRFkyNDIwd25XN09DejJlSlRsbEZ0bTd6bFk5b1J2TStDdEttejh4U01F?=
 =?utf-8?B?YVR5dEJZdi9Gc0hyZjhDTFV1cEhBdFJXaFNlRFZUalR5a2wxR2loQzRHZzBp?=
 =?utf-8?B?VTdLK2Ira0J3SnhNaTRGc2g0TEdTSkVkY0ZTVkNxdEJlTk80L05TUmc2NmQ4?=
 =?utf-8?B?YmkzQkk1aERRdzhZUzczUHY5RHJYTXY3ZVpBWVJ2N1pFcEhqbnJJNHRSWHVu?=
 =?utf-8?B?bGU5VDladnl2ZFYrZm9nS2d2SHQwNmpVRkNja0ZVUTRxNUhITm1sV1gxb3gx?=
 =?utf-8?B?RE5YS3p5YnVPY0p0MkhTQ2JXL3QwNTRPTk9KV21Icmtyb0pXWHQyZDVWL2d3?=
 =?utf-8?B?Mk9Xb1k1eEovZ25kL2s4a2Z3cmNRemdDa3Z6d24rekpWTy9aWW1JeWJndlph?=
 =?utf-8?B?T1YzZWN2MjBPRloyWG5pUXdjWkZiNUszMCtzQnpOaXg3TUNxc3N5d0xraEpG?=
 =?utf-8?B?OStWbDYrVGlYbldSUnZOTUNCcFFub3FUcFJJK1FFdEVTRmk0RmJUZTdjNjh0?=
 =?utf-8?B?allwbjBZYThpUG1hYVB1NnloMWpLZVZjblU2VEJ3ZVd0WWl4cG84UXZsTnBF?=
 =?utf-8?B?ZFU1R1ZUWW9vdjlqNTArU1U1bDJKUHhMZmNUdlBsQnArVUZFSlNkcGR0OTN0?=
 =?utf-8?B?anBDTmdONEdOUGFYZkVYMXcxNEFNZFZORkFTUXZCaHRlZ3Q1L3luOVp5c1hC?=
 =?utf-8?B?NURWLzZybUdMUlFxWER2OHZKa3lCU1JsSUF6enlKTFBCUzh2ZWxicHBOdkdN?=
 =?utf-8?B?dERaVlNrOHZEdkdWelZhMlRZSGROaVArY09jQk5DZXNLUHlHZXFpb29sanNp?=
 =?utf-8?B?OWZUa0JFOVVVTnFHVkwzK3c4SlRVaTlOZ01qazlQb0ZEbmhDMFNXUFVpUGxW?=
 =?utf-8?B?LzRaeTI2T3ZrVDdsMkNvZFk0TjZ0Q3RiQ1NpWm5VMmJMNnF5N1BQR3U5Ui9D?=
 =?utf-8?B?MndLQUxkc3llZjhYRkNOZ3UzTlR4Mk1NbE9IOFVNd1FUNHhGYk1mR1RRVDBE?=
 =?utf-8?B?cm1WUktVdU5Bb094OGFwWTlLdXVaWkdmY3NRZXphejhBZXZtNTA3bHViZU5J?=
 =?utf-8?B?N1Q4eVY3cVVUWUJ5ZDVQbFJhN2VhQ0pwQnNkMU9xRWJiNWswek5ZZmtzUjlO?=
 =?utf-8?B?S2Nxa29FdlgyakNGUHB4dXZBSlNvenJTMDFTRVpXT01kNFdQMTFrL21SQTRu?=
 =?utf-8?B?WUlTeTRhem5WQTdDQzgvUE0vMWNub0twME5ubUJFdFpaczl3L2E1ckxYUE0x?=
 =?utf-8?B?cU9QaGxmZ3d0N2lMeGJzWFA1ckRXL2pCLzhadkdLbmNwOURiL0ZsbHlUaW13?=
 =?utf-8?Q?15ffY5DL4FGnz6aO8+XS0TmITx5CiAHH5gSiGBL?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UGttb01sTGhPR1FsRS9JNVNOdjRPQlBFV0YzbFVpYWVnbVhrR01SRHcxeWR6?=
 =?utf-8?B?LzZQNDlpT0x3dWJPYlpvWEd2Q1U0MUlvR3Nxc2dacThxSGxUdTFhd01ZdlBR?=
 =?utf-8?B?RzJGN3FuOU9KVXgyN3F1aFZmWEkyTDlWaW92VnE0TGhPSVIxOG0vZTVlM095?=
 =?utf-8?B?ZUIvaHFuRW90TFMzVkZybmYzMjVxb21jU2tmL0tWTTJya2Y3cXRkRWpUYlcz?=
 =?utf-8?B?SkV0eXl4dXlQYlRjUk9FU2lVak4yekNDaEhMa00zd1BWRk02MUllcW1nSnJl?=
 =?utf-8?B?emI0YkdPTExMVDRkbEpLajNyeUZwdE9xSVRWNVVNQmdyUTlzUGlXdjRDV2Vx?=
 =?utf-8?B?NEtSbnpoVkcwbjdKbU1tN3ZMZDR1bGhGSTdQRkhMZTJsZXN4QTBRbVd5SGEw?=
 =?utf-8?B?SG5sQWhJREMwendEdWZqaW1YOUcxOEYrTGRDcVc3U1RWTUx3SmNjZTNZV0kx?=
 =?utf-8?B?N0F3Nk5ISDdWRVo4cmJhOEtSNjZLcEtrZUZmQVlSY2plYm9ZTThUM0VhOUlQ?=
 =?utf-8?B?SVlyMXVPNGlsNnJXazNvWEVJRWdvRndVZlM2OGJtYkE1Rk42R3RRT1lHeGgw?=
 =?utf-8?B?V3JqT0xnMTN3cTVFeEFndXBYcVNvZU5sbnRPR2o0MEpjeXRrbTk0d1dValVh?=
 =?utf-8?B?c2VtQ0lYM0VsdjZ6MXVyeTQvUVJrcEMwWWs1OEhKUXdnSS80UVhUMVZFdVYy?=
 =?utf-8?B?QmorSzh0d25uODVvNDJtMnQxaUcvcHdSQXRSRGUrK0JQWmRkRHliL25WT05V?=
 =?utf-8?B?RGdmVHFSWnFHd2lFc0NBOUU3a2ZhcGhySmhOcFJsYzVyb1JzZ1VsYVBsbjBw?=
 =?utf-8?B?WG5FQWtsMXJwQUhrVjdvSEl6SkVOMHVGRGxHeE9IWjFibWFnMThVd1pranVS?=
 =?utf-8?B?Rk5zd2xROUx0MmZpbEVkK0JLWk9ZMmZwYXZVbkhpdlVCV0Z1RGZVSGFxanJl?=
 =?utf-8?B?ZmlIS1BZc01tbzRuWlZ5K2IwM3dHRUFtN3I0UlYzSnY3Y0ppM2Y4MUxzdUdq?=
 =?utf-8?B?aFJ2RW5kWmdVRUFBYmo5b05SbDZmdURkS29XMG9YbHNRMkxvZXF0SFVGa3dB?=
 =?utf-8?B?cmVQK2tROCtkL3ptZ3lNdFZ4SkpiOTl0STJTQ0I0S25pVDl1Rk1JdzVhWDND?=
 =?utf-8?B?S2F2L25DTkd6VHZGMkZzdzFWRVRnam1VVWFaLzgwYWtFUTRSK3F6Y01NaG5P?=
 =?utf-8?B?Y3MzT2NwZGhpaXdVcVlVNlFpYkJmMHJab1pLbEFwZVBMZElGMk1xNGYvbDhj?=
 =?utf-8?B?OGJoTm5XNU53RWp1UWRvb28wWVovMmNNVlNtQTlGbmh3NVhmREdIbUl2V0lu?=
 =?utf-8?B?N0U4d05SWUYrSytmZ0haUEJwc0FyRzZSdGlqV2lMWTVqNFZ1QmpCNnRjN3dB?=
 =?utf-8?B?VmttdVpwZjhQMktZSnl6OEw3akVIZXU2cWo5WTVVejJGU0UzZzlZZSt2SWpO?=
 =?utf-8?B?Ky9mamIwV3F3QlQrMk1BeHY4Q1M0eTBaSk9HRVNiMUJkdi9mR0N0ajU1TzFH?=
 =?utf-8?B?M2xPa1ZtcmJWRzFlYUdhTjZvQVdEK2JTWFk1OStFRWN5NU1CbGZhUXZyNmxG?=
 =?utf-8?B?NHlvRkFlZCtBWUNBUHVtRE1MZU5VT282cUozMTNjZFNuaDVNN3BGYWIzWTNv?=
 =?utf-8?B?cVZ0NmRuNms0QnYrTXoyS1libUwwOFl6R2ozdVRGYXR1ZTl2djFOc0YvTFV6?=
 =?utf-8?B?bFRWVEJMdFoxR21LMC9ZWDB1dElEb3Nqa0hCSUZzUThpYTlRNkNaT25pcHpO?=
 =?utf-8?B?dmJ5VUFVSFZDVGVocVdLQnR0MTNwTkVnN1dlMjFvK0dnS2Q3RUFiS3ZVRGR4?=
 =?utf-8?B?MGpmWkhVeExoTER5SXVDRmVNSmpjUkVZMG83NXJlTWpmd1VSTDBSWDFENGpa?=
 =?utf-8?B?OURYSXFqY1NhVXRNcVlTODJUZU5oejRsNndMdzdrcDZsdnpJOEVsQy9iYVJs?=
 =?utf-8?B?WHJZZXZiZ2FXa05neHNvbzBxRm5nWVJmcHVTTW9kd0d6bjluZVExTHRlbmNJ?=
 =?utf-8?B?Z2pwZWN6Z2tuR2h4WHBybFJ6OUpMV0t3UFRzbW1LaU1jYWNROC9PNVpYK0JK?=
 =?utf-8?B?TVdPSytjWlY3K1Q4WlJCeTN2ZndtN0ttOWwraU14Y1JwTzFjdWVWcHNwMkxx?=
 =?utf-8?B?Mm1JV0tWc0c5ZFNEZ0FlL3JuRFd2blNOMUU5NjlLRUZDdEdtRDF0SkFmUFUz?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C32A17AC0B460D49A12366D371686E20@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OXxWzhKP+huVN28dGFrm4xRd6CIOC6+h6WCk0Fj8lFfcgpeg6tinIeVVtFU3Hxo7Rl5dN7ZTfpUnnAGzO1fDhxhl2Api7b67fcQN6bkgvR62rzeVHiZd7rXJKHs+/QAliLfQtF/F0H2LdUP6HeA4EDalT7SGHkSZkZPGbzcICtc02URe1VOzZsErQrdJoWzIn9Rikw5dsyAYiEOTj+uS/gStzRvp/aY8WcZ9Fh/B9aKAzmhTqxSAhd15K4NPVr150cOaCK1WEG0s2796o33zUmFfcW4mOesacs//m4XChgXs6kzoM8izU8ZF+kQwKGRRp3DY8e12KxyMT30+VH5Qj/+42Rp1wrOsjFe8kfhTCi/MnZ/ZYPeULVoUKlhAijs01IUWhTUbEyoyR8GFrubmnKPz8ydNz8qPlHIRpH1D3ayNM5wDOAnOxskQme0EILHN9qm/uZKsrMtP4GpECG+6J3YQkbEgHdfHsmZte+Q4j2EwXYvcz0fGWzrLeZ4Zw0JRkIhZlJN3DrRt06KHreTA8662an1Ce6Mzcx3p90cE/+oPlFFSW5QBTQurttz/8pDSQnPDLTIX0W6Dwoe9PUbaXjOQbmzZp/nZSx4oK7SbylM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88070c82-4b3e-49d3-98c9-08dc90624ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 13:18:24.9242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rEEz7OsyOHZH4eL0eHqvSJcs4CxhM2JAn9phnj98+kBNUCvMBBU5l7tjHqDDt7ghNhNpyAlxx4u6w0DKbYdrEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406190099
X-Proofpoint-ORIG-GUID: 83RZPfxOCFbv5zNFtLfE9IOvTAHBKUGb
X-Proofpoint-GUID: 83RZPfxOCFbv5zNFtLfE9IOvTAHBKUGb

DQoNCj4gT24gSnVuIDE5LCAyMDI0LCBhdCAxOjMw4oCvQU0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDE5IEp1biAyMDI0LCBNaWtlIFNuaXR6ZXIgd3Jv
dGU6DQo+PiBMT0NBTElPUFJPQ19HRVRVVUlEIGFsbG93cyBjbGllbnQgdG8gZGlzY292ZXIgc2Vy
dmVyJ3MgdXVpZC4NCj4+IA0KPj4gbmZzX2xvY2FsX3Byb2JlKCkgd2lsbCByZXRyaWV2ZSBzZXJ2
ZXIncyB1dWlkIHZpYSBMT0NBTElPIHByb3RvY29sIGFuZA0KPj4gdmVyaWZ5IHRoZSBzZXJ2ZXIg
d2l0aCB0aGF0IHV1aWQgaXQgaXMga25vd24gdG8gYmUgbG9jYWwuIFRoaXMgZW5zdXJlcw0KPj4g
Y2xpZW50IGFuZCBzZXJ2ZXIgMTogc3VwcG9ydCBsb2NhbGlvIDI6IGFyZSBsb2NhbCB0byBlYWNo
IG90aGVyLg0KPj4gDQo+PiBXaGlsZSBkb2luZyBzbywgZmFjdG9yIG91dCBuZnNfaW5pdF9sb2Nh
bGlvY2xpZW50KCkgc28gaXQgaXMgdXNlZCBieQ0KPj4gYm90aCBuZnMzY2xpZW50LmMgYW5kIG5m
czRjbGllbnQuYw0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBNaWtlIFNuaXR6ZXIgPHNuaXR6ZXJA
a2VybmVsLm9yZz4NCj4+IC0tLQ0KPiAuLg0KPj4gDQo+PiArI2RlZmluZSBORlNfTE9DQUxJT19Q
Uk9HUkFNIDEwMDIyOQ0KPiANCj4gQWNjb3JkaW5nIHRvIFJGQzU1MzEsIHRoaXMgbnVtYmVyIGlz
IHJlc2VydmVkIGZvciAibWV0YWQiLg0KPiBJdCBtaWdodCBiZSBiZXN0IG5vdCB0byB1c2UgaXQu
DQoNCkkgYWdyZWUuDQoNCg0KPiBUaGF0IFJGQyBzYXlzIHRoYXQgYXNzaWduaW5nIG51bWJlcnMg
aXNuJ3QgYSBqb2IgZm9yIElFVEYgc3RhbmRhcmQtdHJhY2sNCj4gYW5kIGhhbmRlZCB0aGUgam9i
IG92ZXIgdG8gSUFOQS4NCj4gDQo+IElBTkEuLi4NCj4gaHR0cHM6Ly93d3cuaWFuYS5vcmcvYXNz
aWdubWVudHMvc3VuLXJwYy1udW1iZXJzL3N1bi1ycGMtbnVtYmVycy54aHRtbA0KPiB0aGlua3Mg
U1VOIHJwYyBudW1iZXJzIGFyZSBvYnNvbGV0ZS4NCj4gDQo+IFNvIG1heWJlIG5vYm9keSBjYXJl
cy4NCg0KU2luY2UgdGhpcyBpcyBMaW51eC10by1MaW51eCwgaW50ZXJvcCBpcyBub3QgYSBjb25j
ZXJuLg0KQnV0IHRoZXJlIGlzIHZhbHVlIGluIHNxdWF0dGluZyBvbiB0aGUgcHJvZ3JhbSBudW1i
ZXIgdG8NCmVuc3VyZSBuby1vbmUgZWxzZSB3aWxsIHVzZSBpdCAoZXZlbiBieSBhbm90aGVyIExp
bnV4LQ0Kb25seSBjb25zdW1lcikuDQoNCk1pa2UsIElNTyB5b3Ugc2hvdWxkIGxvb2sgaW50byBy
ZXNlcnZpbmcgdGhlIHByb2dyYW0NCm51bWJlciBwcm9wZXJseS4NCg0KDQo+IEkgd291bGQgZmVl
bCBtb3N0IGNvbWZvcnRhYmxlIGFsbG9jYXRpbmcgYSBudW1iZXIgZnJvbSB0aGUgcmFuZ2U6DQo+
IA0KPiAgICAgICAgICAgICAweDIwMDAwMDAwIC0gMHgzZmZmZmZmZiAgIERlZmluZWQgYnkgbG9j
YWwgYWRtaW5pc3RyYXRvcg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IChzb21lIGJsb2NrcyBhc3NpZ25lZCBoZXJlKQ0KPiANCj4gYW5kIG1heWJlIG1ha2UgaXQgY29u
ZmlndXJhYmxlIGJ5IGEgbW9kdWxlIHBhcmFtZXRlciBqdXN0IHRvIGJlIG9uIHRoZQ0KPiBzYWZl
IHNpZGUgKG92ZXJraWxsPz8pDQo+IA0KPiBXZSBjb3VsZCB0cnkgcmVnaXN0ZXJpbmcgd2l0aCBs
YW5hbmEub3JnIChUaGUgTGludXggQXNzaWduZWQgTmFtZXMgQW5kDQo+IE51bWJlcnMgQXV0aG9y
aXR5KSBidXQgSSB3b3VsZG4ndCBiZSBzdXJwcmlzZWQgaWYgdGhhdCB3ZW50IG5vd2hlcmUuDQo+
IA0KPiBXaGlsZSB0aGlzIG1pZ2h0IG5vdCBtYXR0ZXIgaW4gcHJhY3RpY2UsIEkgdGhpbmsgd2Ug
c2hvdWxkIGFwcGVhciB0byBiZQ0KPiBkb2luZyB0aGUgcmlnaHQgdGhpbmcuDQo+IA0KPiBOZWls
QnJvd24NCj4gDQo+IA0KPj4gKyNkZWZpbmUgTE9DQUxJT1BST0NfTlVMTCAwDQo+PiArI2RlZmlu
ZSBMT0NBTElPUFJPQ19HRVRVVUlEIDENCj4+ICsNCj4+ICNkZWZpbmUgTkZTX1BJUEVfRElSTkFN
RSAibmZzIg0KPj4gDQo+PiAvKg0KPj4gLS0gDQo+PiAyLjQ0LjANCj4+IA0KPj4gDQo+IA0KDQot
LQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

