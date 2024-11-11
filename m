Return-Path: <linux-nfs+bounces-7855-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 269149C414A
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 15:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498F11C21835
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B7B19F105;
	Mon, 11 Nov 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xq6FQxOp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u3j3jG3i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FEB1BC58;
	Mon, 11 Nov 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336959; cv=fail; b=J+DmTQsvIBawjCbX/JyR9YFWmw6MMs8ShXgIUgbS9h3cgrjq0MmyjImxTo0HBxmrsJX9VuIRReBP9QoXG82Gk/8DVMCQra7p29QFT4rnDPGgrKLzC5ij9VPZ/ekSp4YgxShfeFu3QQsY62kO/jOegZ08mBClwFAzzdrmIM7qcxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336959; c=relaxed/simple;
	bh=jPg0cYM9OtolP+fN1671gJRCj/UrNrsqutxN0xH4OMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cIX7pEEZAe8yK4vDLZ/0LvC01UhbTwsLQnfm4Q5T7/NN1q/KKWQDHIrMxUUdxEOMWUU2hCapSec2hfxSMYfeq6Ah5ePXM4XjYRVPacEQ/Xi218LOCWUbNuXlRuWeuOFw/SgEmn64FS0rE0nqgGgJ2tGkqCRKBoCKmOHwM9okVVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xq6FQxOp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u3j3jG3i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9smiP002320;
	Mon, 11 Nov 2024 14:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nnVD6645XV3B/MY7cTj6cjrITeaNVVWe8BmPH3MgHJA=; b=
	Xq6FQxOpF8Mma1bRialQ5Ccx15SCnU79Vxn31ziHfvmcp7z8gq6J/f1KIBTvQ4mY
	+03kUv9FsSqZJhRsdRu8HS5dDeBiRauE1UnyqWenH2cP0O6FAmFgk5vk5qFos4nk
	TrTJb9uHtspTEYu6G2ww3rKR+6t1zSJB2xv04O/QMqxyyz/94+3v+haaKPMsm1P8
	LMp7RdhXmlA6GNmqHMXqsiqrH0+OZPS2SResyp7KGdrSZjXS3voqin8l+kFEWMJo
	eDmx/NeCKPTVhsXmrWtckxmi+6Ax+aIhNqHne8c5zoLCdgKOuD/N0LNH/nyO9NQO
	NerO/6g6AFePvA51oJtztA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hejhkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 14:55:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABDADKC028353;
	Mon, 11 Nov 2024 14:55:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbp66xrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 14:55:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1wJsnbWkhLNB70oGZD+wXi0kdCVsz1sXbYA47AHWML6MpbEfoidFQgBKTAFEVutoyhEEQ5ZQ63tuNj+CVpGEuPFtzEOQGzMp5WqfT72CLp4M+iGvOscrfPLlKquEZZX4HXYjpZL1V0sE+UQz5qysjlG8NuGBcKwxju+03IFZwrFQJ1+YRU7XNY6ghgj68+VG0igt+dvJ2+bc5Scnqt2/0yhB9pcpw0hwUj+HQbcJspG/3+X7UfkolKR+zve7Z2XzZCLw9hd2Np+jNfQpzOtWSBjoloQ8uj3/qnE4Eq5a83dw8lmtcs7UCAXlaks+ly1J5lZ+Hzeq3u4B6goSR/oxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnVD6645XV3B/MY7cTj6cjrITeaNVVWe8BmPH3MgHJA=;
 b=NyjVD5Ud5kJ+EdSa1qAH1QNb1VdErpQ2IhbpRgo5GHoh1rjQgnGsQDnhbuZEhur3mwF9iObPZTRA2SsYgI04OhmMb13tSCwN5Ayjtga5H/1jPW7jRo519WLZSah9EzmVdP7WImkAxd4waTBHT5sEXDl2yAIKBiCodsIxSK24Ge+eugOwthadO5B/ILFRUKfOk3Pod1hqfkdGJ0cLpV5UI+fCL0+yB6nurQm0zLCW1y/PasVN7TYwqUv/zijefV3eoD95bj+G4/boU1/h4KOj8KlcrFwfDEwEhmbA2rd07UbzhyWWzPUPH5sze6uF3lF9AChaG33dSOFGRXpV4ULO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnVD6645XV3B/MY7cTj6cjrITeaNVVWe8BmPH3MgHJA=;
 b=u3j3jG3ir24wH7HsfB0TEI71GVQE9wNyPtKS+v2iY5oZSCaojW5NA3w4J1r2q/byYBktOcL9HiplCZLmM6PuvrPGqk8aTpzY+aZnzZqTmZG1jD2tB6bTz3a5R5LwHKyywGLas7rkRoID3t+VWuy3RKxOPvdVgeasyAbZen1OM7M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7680.namprd10.prod.outlook.com (2603:10b6:610:179::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Mon, 11 Nov
 2024 14:55:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 14:55:38 +0000
Date: Mon, 11 Nov 2024 09:55:34 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <aglo@umich.edu>, Neil Brown <neilb@suse.de>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
Message-ID: <ZzIa5q8cG5LYW5D7@tissot.1015granger.net>
References: <20241105-bcwide-v4-1-48f52ee0fb0c@kernel.org>
 <CAN-5tyEEfJ5p=NUaj+ubzCijq+d9vxT9EBVHvwQYgF=CMtrNTw@mail.gmail.com>
 <59e803abae0b7441c1440ebd4657e573b1c02dd2.camel@kernel.org>
 <CAN-5tyH8xw6XtpnXELJfrxibN3P=xRax31pCexcuOtBMZhooxw@mail.gmail.com>
 <b7f6454176746f5e7a8d75ba41be71e46590a08c.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7f6454176746f5e7a8d75ba41be71e46590a08c.camel@kernel.org>
X-ClientProxiedBy: CH2PR12CA0014.namprd12.prod.outlook.com
 (2603:10b6:610:57::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f8027e-1581-4748-5ff3-08dd0260e767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejBNR1prcERVZ2xrVWIzVk1sZzgrd1EzV1lydkNCRzlRNE9pcElwZFJ4VWJS?=
 =?utf-8?B?dEhQWnRQOFpiT3g2NjA2cFFzaFJkM3JodktVdnZlOVYwUm9wbjlqUnF5Q0V1?=
 =?utf-8?B?NHI4WTZzOTlGNzNySVRWZ0pzcWVlSk5DaGt2Ti9iRklkb0w5bzNFN0x0bDlV?=
 =?utf-8?B?SXVoRHB2VzBUMm9BTjRnTnZCanVaczF5ak9tTVdVcjRzOWtLMzMrcktnNGRW?=
 =?utf-8?B?OHE1cHJwV0poS0lYL2lKQm1lb0RNZnJUU0xIU1o4SGN3bVY2d3ZoSHBUbUpn?=
 =?utf-8?B?R0VYSzlPTDJVU2x0N3VWYVVOSkJXUzNyNEZ1SFg1R0U3bnd4VGFYdzZGOUw0?=
 =?utf-8?B?ZGVGcUlpMC9Ma1F3V2dCTHVFYmVQUFliVXd5YmZyMWxVcTJPSTNwWU9WbHB2?=
 =?utf-8?B?dEw4bGdHYS9NTFhVSTBnT1FLVzJjT0NKVktydjdVNi9ZVUZXaTVFSlpvZnRN?=
 =?utf-8?B?UFFPZ1JNdXdQZGR5YjF4MlBXU0hRY0pwaUQzOEgybGhNdmtJa094Z3AyWU1M?=
 =?utf-8?B?amNsUjMwV0htdk5EWks3cTlzSWZsbGdmRk5PMEFZK1RIY2JNdmJqWU1xeDhE?=
 =?utf-8?B?UmZROURXU3BkbU9SSWMrQ0dLVlNzaXZGRVgxZDFuanVMc09COGJEQy9CeW5x?=
 =?utf-8?B?UlVYTXpTMHN1WkxodGh4OEhEb2xFTHJCQWNVRFErUE94Ym1yZlBvTTZGNU5a?=
 =?utf-8?B?TGhZMXl2MlBxRENvZzBXdEJZYS9TNExucENsV2tHYml5QU9FSWlRbVl6MDJu?=
 =?utf-8?B?dkF0aUtwVHE4M2d5V0c5NjJSSHpZNm1lWGR2QXN3VjFIYVQ5Yk1EQTFGKzBs?=
 =?utf-8?B?SkRyaFJxN0VNRWEzalFsWVNsR2NEeWxxTjNwa1lQc1pGV01ZTEp6SWFSQVlp?=
 =?utf-8?B?T3FnUmd3OFhMVzFVc3J3b0cyYzV4TkpmUWtScUpUNUNwSG1jY1QwMU5yWGUy?=
 =?utf-8?B?Q0psSm5ZN0p5MVRPd0Q0K3ZpS29jZFlJYzF1VkJ3cnRzbWhYZUNaTVA2aWdJ?=
 =?utf-8?B?Nms0bnIzSHIvVGE2WmptUXEra2tBWWtYZmQvN05JSlowR2gvOEhoUnhVTFpX?=
 =?utf-8?B?MGZ3amI1MjY3R1prSEIzTUhCOFZIekNCcUlBbkU5UUF5a01jK3Y4WW1ZMHJz?=
 =?utf-8?B?M2YvMEhBWFpmRjBwd3pVckwxWHg0RkhubnRpQnBkcGpJa2orWFZQY2x3NTlW?=
 =?utf-8?B?ejlZR3B6RkVSa0lNR2kza2dMaFBuMmpGcnJCSTZqZzcvMjNoM1hYYzg2cDRL?=
 =?utf-8?B?bTRqbzhxTDVzejJUK1JHVXRDQkx0VERlNk1QRm1Qci9DOW1YQkZpOVd4Z3hU?=
 =?utf-8?B?MzEzTUFGOE9sdzdmY0NML0p3blRvUDUvUUdyRVZLUlpjVUlCM0p5MElEeTM3?=
 =?utf-8?B?a0tQM2xlMWJHQWFGMmc3T2NXNldIK0h4Z05BTGEzY3ZncmczakthcmJYRG5S?=
 =?utf-8?B?VzhtK2RsK0JlMlFsRDQweEV0U3Z0QndzcHRSYkFnSWh1ODliZml2MllObVRG?=
 =?utf-8?B?a1ljUEdFM2N0OWpsMXovOHBEc1JSWGI3N1pTbTFCNWlhT3FSQWJUQWRoNlRk?=
 =?utf-8?B?anhLc21TbFJvS0xQOEo3MmhydTBVQXA1cTEwLzViSzljbmlQK3l6VGQwRE45?=
 =?utf-8?B?R1IrbzQwRjBiNHZXa2Z4c1NFTXV5L2pGM0hIZ3gzc3E5UEFWeXlHZGh5V3Q2?=
 =?utf-8?B?RXRtRWhUTDdHM2k4Z3hhMUNrZUdMZm9rYVpVZ2dUczBLZDZzMkU2WGQvSUNr?=
 =?utf-8?Q?5quAUxLWT0pu0HBHMT9atxUSWYJf9ZF9iJMrlGE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTIzcEpsdzV6M1YvckxyOXIrdjN6T3RadlZyRlhZYnhCeVZIN1FvVXpZNHNV?=
 =?utf-8?B?bjN2eXRVZjh2NzZGdC9wamlZU2tsRHgzcnpvdFBkRklWYjNmUW5ubEtTcVV1?=
 =?utf-8?B?SExsdHJiOGRJWVRCWHFVcSt4UmVPM2RvLzdDc3hUUVdyNFN2QWlZVnhQU0F0?=
 =?utf-8?B?UkdvSUhndFpCaC9ESURhWkVKMDI3KzNyQUZvdldRc2paWkdUbCt4cVg5SmF0?=
 =?utf-8?B?Y090ZEthUzdaMjU3SVdsL1pyQzRUY0pVUHdvd2ZsZHRWNHJmMHZaaGx5V0x1?=
 =?utf-8?B?Q1RhNVl5d2hKTzlRM3Fydm95QnFHVmZ4NEhvQ3Qvbmt3MXNaYmM4THFKZEFT?=
 =?utf-8?B?VUZIL2lxeWQ1b29nYmpyL1hNak5KY2hTNG5pWEZmdXViTG5nK2pFZXNkZmJM?=
 =?utf-8?B?Mkh3NFlaMDBjdnJDU0JIUzdHdEJ4RjVneE04VzEvam9DeTJTQXlBR2dvV24v?=
 =?utf-8?B?NklNTzFCaTZqeDZSSnQ3a1BxTnc2ck1XaGs1akllbXpRaTVhbWhpOUttVGJI?=
 =?utf-8?B?V08yWHhWRGgyMlhLdXpXVW55NHRNVHZTLzlDR3dPTWlwSkJSNXRzTDB1NGM2?=
 =?utf-8?B?WVlqS3g3ZWVzTVdvb21zOHpIYUQxZXRBVGdvdm04RGlRZlh0ZTRxcFMyR0xC?=
 =?utf-8?B?OHJLa2ZrRFZycHRFYTBoVDRTNGgySHRjaE9FS2pzS3Q3Ry9wSWJHcEdGVlhS?=
 =?utf-8?B?ODFFM2Qxb1h0T2JlMWF2MUliaEF1cTlhYktlbmkxdjFTWmdHKzlYaXJVQWpS?=
 =?utf-8?B?Vi9rRyszaERFd3QvUzFTSmpwUGxPMXhnUjRidm8vVGpBZjFYTXRUSW9zVFUx?=
 =?utf-8?B?Q0NuY0YwRVhwL2NYR2w1ck1mZ1NqRW0xYThLakMrbTMyQ1gxS2dqQ2JRSTFv?=
 =?utf-8?B?Rm5ob1MzYUVJTkZ0a2RuUzduSm1Xb0xzaHF0dzQxSkVPWUY0QkRWZE5QZXUr?=
 =?utf-8?B?dzRrK2gzS0pPUU1BcEk1cVNOekpuUFpabkwxVzlHU2tEZkh2VUd0SGNwQmF4?=
 =?utf-8?B?ZjJ0ZEM5eHlxNDk1SUZrcW5UaDAyWkxHMCt3K0FNWnNQS1E4VUNrYnlJV1FF?=
 =?utf-8?B?ZGp4ZDhLQXV0Mjg3TUZBKy9qSW9QZU9mRDk5RXM4SDRIWnF5T1RoR3BYYU81?=
 =?utf-8?B?cmZhS0pqOFV6ckdMY0hwajIrZmJZamJHRmk5MEFuMW5hejF6K0FXYlhjekYv?=
 =?utf-8?B?WDdBemlYZWx4ZUhQSENFNUdNQ3h6NWs4ZnIrTFBic0p0eTRvdUdSZmdZWExK?=
 =?utf-8?B?QlBxSFJEaHp3ajRUNFluR2dORlNJOXhsUmMvOVpzaTBkZWwrV2tzRTJsSTlu?=
 =?utf-8?B?WUpDRCtCQ3lpdG1MT21VLzltOEd2bVhmQk1sVG1ZZC9HbFVZTnJLbU1Qd2lt?=
 =?utf-8?B?eThqTlFHK0hSbnlUL0tIVnNHNHJnUWtTQ0xJdHBQMnhZaTBKRld1R3VlN3BF?=
 =?utf-8?B?OE9DbWYyaElscTBhWVZ1RzR3VjNZU1oxMEtINXZvbll4RDNrRmpQMkV1LzlQ?=
 =?utf-8?B?cTQvSHlhcEtvWHNzRFVDNHBvRWZtbWtsRXQwSUtqazYvYXhCaWNCSG9UbUE1?=
 =?utf-8?B?WFJRQkpwbmJtU3UveGhRNmI3QjdYdmpKY1NXRUZ6RFM4UXNYbmU1NTVtVEsy?=
 =?utf-8?B?SXpHNjZiUEFaWGFpWWJ1RDJQL0pUR2VRTVh3d0tWNnFKaGJRUUtldGU5ZGVI?=
 =?utf-8?B?TE41SUxhYWx4bmdta0t1RWRLenlQUnV2cUZJTUNPRFFlRUpKV2NJM0JDckNa?=
 =?utf-8?B?UVJWbHZYYlpySkl3YTZJS1VuWHozMmRuUWRoT1ZHZzdpSFMrYU9kT2Z6alpx?=
 =?utf-8?B?Q1RVdGVLZ0o5eThHQU1KNm9zSDJlVEhFZWF3VzNjd0FiNjJEZUIyZ0ZHVWR6?=
 =?utf-8?B?WDNSdWIrTmp6Uk5WK1loVFhqOE5TejEvL0dYVFdvM2t4dUJCSlYrRjExcStD?=
 =?utf-8?B?QXNZdTFwRmVRUFB0QkQyZ1FEVmZna25oOEJCNEtCNFArVFZ2NmZFZlBoU1RL?=
 =?utf-8?B?QTlLNmpVNll6RW5wa25ia1hvOVdjejN6djY3Snl5emxTbndhaFo5MSt5WENK?=
 =?utf-8?B?cVhuK3IycFU3T0pNS0l6bjBWK2pFZTRZVWpzV3hGTkJOcm12MFFrMzVFOXAr?=
 =?utf-8?Q?Xrk9VydI5WWaZyx2TK226Ae+3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wS0Z/YhiAD2NDvinqa1mcbGdivfIhjjP9LvnRh881ugx1cCRbFVF91wm+vr+WvXhzhuKNbjMFPYAErdyLkpCFtycB8W3FO0zDaWeGN4+1e8GtN2LpBJa0kkd4l2JPDyowg5+9+y/TiFXNJj6SOBe1D9GA2pUjFh49bvc8ogTwRYjupsWzWFAAsl7FOvrneESTZ8pMIIXwXG/LQg2hUUZCBjh8uPvRlWy+zm8W54OHeIg12TK0Nx70afeyZikwBxJ/1+3n1/0kZDetK5QjhPomnYx7PBiCsAAlQ8PjNp3j+8VZD4+gXHdtGAm+rB50J6VpVaWOGRfdLfzgdUbv/Uz80di8vPTbKZtH2p8Op+PNWG7OPQBsh/0aJQ71KD4qEoSEcZo2U4VyGxjuiv1EhY7V3VvYsUL5MYs5hyk7r8cD95jMqs6ScKL55bctCtcypPQvl+YY6LYYlXEVRm05IpnhbSpfebZhhjBNFFsVyN/oTiQqWGfvJ8IGr8JyHAW8wyVSuODlAjc9wwHwVXmDyc98hcYfmzgbeETOonqY8hTNRIlN6oSV1i081bGdBg0G8PLpczjlNFwHc9ZygLyqnoZ+NhwfLQhW/lZ6AZn4s9adCU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f8027e-1581-4748-5ff3-08dd0260e767
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 14:55:38.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOOJvK/P62L2+GrS1li6nKcX1a/ZcbxgmSx/8DkAhaOWKz6aTJynihntIxdDteXJEYBasBtAW/JF3nDoSkEAkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411110123
X-Proofpoint-ORIG-GUID: 15ViqLIUaLVfhjlPspBCsm8eWnkhYPe0
X-Proofpoint-GUID: 15ViqLIUaLVfhjlPspBCsm8eWnkhYPe0

On Mon, Nov 11, 2024 at 08:22:07AM -0500, Jeff Layton wrote:
> On Sun, 2024-11-10 at 21:19 -0500, Olga Kornievskaia wrote:
> > On Sat, Nov 9, 2024 at 2:26 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > 
> > > On Sat, 2024-11-09 at 13:50 -0500, Olga Kornievskaia wrote:
> > > > On Tue, Nov 5, 2024 at 7:31 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > 
> > > > > nfsd currently only uses a single slot in the callback channel, which is
> > > > > proving to be a bottleneck in some cases. Widen the callback channel to
> > > > > a max of 32 slots (subject to the client's target_maxreqs value).
> > > > > 
> > > > > Change the cb_holds_slot boolean to an integer that tracks the current
> > > > > slot number (with -1 meaning "unassigned").  Move the callback slot
> > > > > tracking info into the session. Add a new u32 that acts as a bitmap to
> > > > > track which slots are in use, and a u32 to track the latest callback
> > > > > target_slotid that the client reports. To protect the new fields, add
> > > > > a new per-session spinlock (the se_lock). Fix nfsd41_cb_get_slot to always
> > > > > search for the lowest slotid (using ffs()).
> > > > > 
> > > > > Finally, convert the session->se_cb_seq_nr field into an array of
> > > > > counters and add the necessary handling to ensure that the seqids get
> > > > > reset at the appropriate times.
> > > > > 
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > > ---
> > > > > v3 has a bug that Olga hit in testing. This version should fix the wait
> > > > > when the slot table is full. Olga, if you're able to test this one, it
> > > > > would be much appreciated.
> > > > > ---
> > > > > Changes in v4:
> > > > > - Fix the wait for a slot in nfsd41_cb_get_slot()
> > > > > - Link to v3: https://lore.kernel.org/r/20241030-bcwide-v3-0-c2df49a26c45@kernel.org
> > > > > 
> > > > > Changes in v3:
> > > > > - add patch to convert se_flags to single se_dead bool
> > > > > - fix off-by-one bug in handling of NFSD_BC_SLOT_TABLE_MAX
> > > > > - don't reject target highest slot value of 0
> > > > > - Link to v2: https://lore.kernel.org/r/20241029-bcwide-v2-1-e9010b6ef55d@kernel.org
> > > > > 
> > > > > Changes in v2:
> > > > > - take cl_lock when fetching fields from session to be encoded
> > > > > - use fls() instead of bespoke highest_unset_index()
> > > > > - rename variables in several functions with more descriptive names
> > > > > - clamp limit of for loop in update_cb_slot_table()
> > > > > - re-add missing rpc_wake_up_queued_task() call
> > > > > - fix slotid check in decode_cb_sequence4resok()
> > > > > - add new per-session spinlock
> > > > > ---
> > > > >  fs/nfsd/nfs4callback.c | 113 ++++++++++++++++++++++++++++++++++++-------------
> > > > >  fs/nfsd/nfs4state.c    |  11 +++--
> > > > >  fs/nfsd/state.h        |  15 ++++---
> > > > >  fs/nfsd/trace.h        |   2 +-
> > > > >  4 files changed, 101 insertions(+), 40 deletions(-)
> > > > > 
> > > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > > > index e38fa834b3d91333acf1425eb14c644e5d5f2601..47a678333907eaa92db305dada503704c34c15b2 100644
> > > > > --- a/fs/nfsd/nfs4callback.c
> > > > > +++ b/fs/nfsd/nfs4callback.c
> > > > > @@ -406,6 +406,19 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
> > > > >         hdr->nops++;
> > > > >  }
> > > > > 
> > > > > +static u32 highest_slotid(struct nfsd4_session *ses)
> > > > > +{
> > > > > +       u32 idx;
> > > > > +
> > > > > +       spin_lock(&ses->se_lock);
> > > > > +       idx = fls(~ses->se_cb_slot_avail);
> > > > > +       if (idx > 0)
> > > > > +               --idx;
> > > > > +       idx = max(idx, ses->se_cb_highest_slot);
> > > > > +       spin_unlock(&ses->se_lock);
> > > > > +       return idx;
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * CB_SEQUENCE4args
> > > > >   *
> > > > > @@ -432,15 +445,35 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
> > > > >         encode_sessionid4(xdr, session);
> > > > > 
> > > > >         p = xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
> > > > > -       *p++ = cpu_to_be32(session->se_cb_seq_nr);      /* csa_sequenceid */
> > > > > -       *p++ = xdr_zero;                        /* csa_slotid */
> > > > > -       *p++ = xdr_zero;                        /* csa_highest_slotid */
> > > > > +       *p++ = cpu_to_be32(session->se_cb_seq_nr[cb->cb_held_slot]);    /* csa_sequenceid */
> > > > > +       *p++ = cpu_to_be32(cb->cb_held_slot);           /* csa_slotid */
> > > > > +       *p++ = cpu_to_be32(highest_slotid(session)); /* csa_highest_slotid */
> > > > >         *p++ = xdr_zero;                        /* csa_cachethis */
> > > > >         xdr_encode_empty_array(p);              /* csa_referring_call_lists */
> > > > > 
> > > > >         hdr->nops++;
> > > > >  }
> > > > > 
> > > > > +static void update_cb_slot_table(struct nfsd4_session *ses, u32 target)
> > > > > +{
> > > > > +       /* No need to do anything if nothing changed */
> > > > > +       if (likely(target == READ_ONCE(ses->se_cb_highest_slot)))
> > > > > +               return;
> > > > > +
> > > > > +       spin_lock(&ses->se_lock);
> > > > > +       if (target > ses->se_cb_highest_slot) {
> > > > > +               int i;
> > > > > +
> > > > > +               target = min(target, NFSD_BC_SLOT_TABLE_MAX);
> > > > > +
> > > > > +               /* Growing the slot table. Reset any new sequences to 1 */
> > > > > +               for (i = ses->se_cb_highest_slot + 1; i <= target; ++i)
> > > > > +                       ses->se_cb_seq_nr[i] = 1;
> > > > > +       }
> > > > > +       ses->se_cb_highest_slot = target;
> > > > > +       spin_unlock(&ses->se_lock);
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * CB_SEQUENCE4resok
> > > > >   *
> > > > > @@ -468,7 +501,7 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
> > > > >         struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
> > > > >         int status = -ESERVERFAULT;
> > > > >         __be32 *p;
> > > > > -       u32 dummy;
> > > > > +       u32 seqid, slotid, target;
> > > > > 
> > > > >         /*
> > > > >          * If the server returns different values for sessionID, slotID or
> > > > > @@ -484,21 +517,22 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
> > > > >         }
> > > > >         p += XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
> > > > > 
> > > > > -       dummy = be32_to_cpup(p++);
> > > > > -       if (dummy != session->se_cb_seq_nr) {
> > > > > +       seqid = be32_to_cpup(p++);
> > > > > +       if (seqid != session->se_cb_seq_nr[cb->cb_held_slot]) {
> > > > >                 dprintk("NFS: %s Invalid sequence number\n", __func__);
> > > > >                 goto out;
> > > > >         }
> > > > > 
> > > > > -       dummy = be32_to_cpup(p++);
> > > > > -       if (dummy != 0) {
> > > > > +       slotid = be32_to_cpup(p++);
> > > > > +       if (slotid != cb->cb_held_slot) {
> > > > >                 dprintk("NFS: %s Invalid slotid\n", __func__);
> > > > >                 goto out;
> > > > >         }
> > > > > 
> > > > > -       /*
> > > > > -        * FIXME: process highest slotid and target highest slotid
> > > > > -        */
> > > > > +       p++; // ignore current highest slot value
> > > > > +
> > > > > +       target = be32_to_cpup(p++);
> > > > > +       update_cb_slot_table(session, target);
> > > > >         status = 0;
> > > > >  out:
> > > > >         cb->cb_seq_status = status;
> > > > > @@ -1203,6 +1237,22 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
> > > > >         spin_unlock(&clp->cl_lock);
> > > > >  }
> > > > > 
> > > > > +static int grab_slot(struct nfsd4_session *ses)
> > > > > +{
> > > > > +       int idx;
> > > > > +
> > > > > +       spin_lock(&ses->se_lock);
> > > > > +       idx = ffs(ses->se_cb_slot_avail) - 1;
> > > > > +       if (idx < 0 || idx > ses->se_cb_highest_slot) {
> > > > > +               spin_unlock(&ses->se_lock);
> > > > > +               return -1;
> > > > > +       }
> > > > > +       /* clear the bit for the slot */
> > > > > +       ses->se_cb_slot_avail &= ~BIT(idx);
> > > > > +       spin_unlock(&ses->se_lock);
> > > > > +       return idx;
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * There's currently a single callback channel slot.
> > > > >   * If the slot is available, then mark it busy.  Otherwise, set the
> > > > > @@ -1211,28 +1261,32 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
> > > > >  static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
> > > > >  {
> > > > >         struct nfs4_client *clp = cb->cb_clp;
> > > > > +       struct nfsd4_session *ses = clp->cl_cb_session;
> > > > > 
> > > > > -       if (!cb->cb_holds_slot &&
> > > > > -           test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
> > > > > +       if (cb->cb_held_slot >= 0)
> > > > > +               return true;
> > > > > +       cb->cb_held_slot = grab_slot(ses);
> > > > > +       if (cb->cb_held_slot < 0) {
> > > > >                 rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
> > > > >                 /* Race breaker */
> > > > > -               if (test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
> > > > > -                       dprintk("%s slot is busy\n", __func__);
> > > > > +               cb->cb_held_slot = grab_slot(ses);
> > > > > +               if (cb->cb_held_slot < 0)
> > > > >                         return false;
> > > > > -               }
> > > > >                 rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
> > > > >         }
> > > > > -       cb->cb_holds_slot = true;
> > > > >         return true;
> > > > >  }
> > > > > 
> > > > >  static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
> > > > >  {
> > > > >         struct nfs4_client *clp = cb->cb_clp;
> > > > > +       struct nfsd4_session *ses = clp->cl_cb_session;
> > > > > 
> > > > > -       if (cb->cb_holds_slot) {
> > > > > -               cb->cb_holds_slot = false;
> > > > > -               clear_bit(0, &clp->cl_cb_slot_busy);
> > > > > +       if (cb->cb_held_slot >= 0) {
> > > > > +               spin_lock(&ses->se_lock);
> > > > > +               ses->se_cb_slot_avail |= BIT(cb->cb_held_slot);
> > > > > +               spin_unlock(&ses->se_lock);
> > > > > +               cb->cb_held_slot = -1;
> > > > >                 rpc_wake_up_next(&clp->cl_cb_waitq);
> > > > >         }
> > > > >  }
> > > > > @@ -1249,8 +1303,8 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
> > > > >  }
> > > > > 
> > > > >  /*
> > > > > - * TODO: cb_sequence should support referring call lists, cachethis, multiple
> > > > > - * slots, and mark callback channel down on communication errors.
> > > > > + * TODO: cb_sequence should support referring call lists, cachethis,
> > > > > + * and mark callback channel down on communication errors.
> > > > >   */
> > > > >  static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
> > > > >  {
> > > > > @@ -1292,7 +1346,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
> > > > >                 return true;
> > > > >         }
> > > > > 
> > > > > -       if (!cb->cb_holds_slot)
> > > > > +       if (cb->cb_held_slot < 0)
> > > > >                 goto need_restart;
> > > > > 
> > > > >         /* This is the operation status code for CB_SEQUENCE */
> > > > > @@ -1306,10 +1360,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
> > > > >                  * If CB_SEQUENCE returns an error, then the state of the slot
> > > > >                  * (sequence ID, cached reply) MUST NOT change.
> > > > >                  */
> > > > > -               ++session->se_cb_seq_nr;
> > > > > +               ++session->se_cb_seq_nr[cb->cb_held_slot];
> > > > >                 break;
> > > > >         case -ESERVERFAULT:
> > > > > -               ++session->se_cb_seq_nr;
> > > > > +               ++session->se_cb_seq_nr[cb->cb_held_slot];
> > > > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > > > >                 ret = false;
> > > > >                 break;
> > > > > @@ -1335,17 +1389,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
> > > > >         case -NFS4ERR_BADSLOT:
> > > > >                 goto retry_nowait;
> > > > >         case -NFS4ERR_SEQ_MISORDERED:
> > > > > -               if (session->se_cb_seq_nr != 1) {
> > > > > -                       session->se_cb_seq_nr = 1;
> > > > > +               if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
> > > > > +                       session->se_cb_seq_nr[cb->cb_held_slot] = 1;
> > > > >                         goto retry_nowait;
> > > > >                 }
> > > > >                 break;
> > > > >         default:
> > > > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > > > >         }
> > > > > -       nfsd41_cb_release_slot(cb);
> > > > > -
> > > > >         trace_nfsd_cb_free_slot(task, cb);
> > > > > +       nfsd41_cb_release_slot(cb);
> > > > > 
> > > > >         if (RPC_SIGNALLED(task))
> > > > >                 goto need_restart;
> > > > > @@ -1565,7 +1618,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
> > > > >         INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
> > > > >         cb->cb_status = 0;
> > > > >         cb->cb_need_restart = false;
> > > > > -       cb->cb_holds_slot = false;
> > > > > +       cb->cb_held_slot = -1;
> > > > >  }
> > > > > 
> > > > >  /**
> > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > index baf7994131fe1b0a4715174ba943fd2a9882aa12..75557e7cc9265517f51952563beaa4cfe8adcc3f 100644
> > > > > --- a/fs/nfsd/nfs4state.c
> > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > @@ -2002,6 +2002,9 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
> > > > >         }
> > > > > 
> > > > >         memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
> > > > > +       new->se_cb_slot_avail = ~0U;
> > > > > +       new->se_cb_highest_slot = battrs->maxreqs - 1;
> > > > > +       spin_lock_init(&new->se_lock);
> > > > >         return new;
> > > > >  out_free:
> > > > >         while (i--)
> > > > > @@ -2132,11 +2135,14 @@ static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, stru
> > > > > 
> > > > >         INIT_LIST_HEAD(&new->se_conns);
> > > > > 
> > > > > -       new->se_cb_seq_nr = 1;
> > > > > +       atomic_set(&new->se_ref, 0);
> > > > >         new->se_dead = false;
> > > > >         new->se_cb_prog = cses->callback_prog;
> > > > >         new->se_cb_sec = cses->cb_sec;
> > > > > -       atomic_set(&new->se_ref, 0);
> > > > > +
> > > > > +       for (idx = 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx)
> > > > > +               new->se_cb_seq_nr[idx] = 1;
> > > > > +
> > > > >         idx = hash_sessionid(&new->se_sessionid);
> > > > >         list_add(&new->se_hash, &nn->sessionid_hashtbl[idx]);
> > > > >         spin_lock(&clp->cl_lock);
> > > > > @@ -3159,7 +3165,6 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
> > > > >         kref_init(&clp->cl_nfsdfs.cl_ref);
> > > > >         nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB_NULL);
> > > > >         clp->cl_time = ktime_get_boottime_seconds();
> > > > > -       clear_bit(0, &clp->cl_cb_slot_busy);
> > > > >         copy_verf(clp, verf);
> > > > >         memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
> > > > >         clp->cl_cb_session = NULL;
> > > > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > > > index d22e4f2c9039324a0953a9e15a3c255fb8ee1a44..848d023cb308f0b69916c4ee34b09075708f0de3 100644
> > > > > --- a/fs/nfsd/state.h
> > > > > +++ b/fs/nfsd/state.h
> > > > > @@ -71,8 +71,8 @@ struct nfsd4_callback {
> > > > >         struct work_struct cb_work;
> > > > >         int cb_seq_status;
> > > > >         int cb_status;
> > > > > +       int cb_held_slot;
> > > > >         bool cb_need_restart;
> > > > > -       bool cb_holds_slot;
> > > > >  };
> > > > > 
> > > > >  struct nfsd4_callback_ops {
> > > > > @@ -307,6 +307,9 @@ struct nfsd4_conn {
> > > > >         unsigned char cn_flags;
> > > > >  };
> > > > > 
> > > > > +/* Highest slot index that nfsd implements in NFSv4.1+ backchannel */
> > > > > +#define NFSD_BC_SLOT_TABLE_MAX (sizeof(u32) * 8 - 1)
> > > > 
> > > > Are there some values that are known not to work? I was experimenting
> > > > with values and set it to 2 and 4 and the kernel oopsed. I understand
> > > > it's not a configurable value but it would still be good to know the
> > > > expectations...
> > > > 
> > > > [  198.625021] Unable to handle kernel paging request at virtual
> > > > address dfff800020000000
> > > > [  198.625870] KASAN: probably user-memory-access in range
> > > > [0x0000000100000000-0x0000000100000007]
> > > > [  198.626444] Mem abort info:
> > > > [  198.626630]   ESR = 0x0000000096000005
> > > > [  198.626882]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > > [  198.627234]   SET = 0, FnV = 0
> > > > [  198.627441]   EA = 0, S1PTW = 0
> > > > [  198.627627]   FSC = 0x05: level 1 translation fault
> > > > [  198.627859] Data abort info:
> > > > [  198.628000]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> > > > [  198.628272]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > > > [  198.628619]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > > > [  198.628967] [dfff800020000000] address between user and kernel address ranges
> > > > [  198.629438] Internal error: Oops: 0000000096000005 [#1] SMP
> > > > [  198.629806] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver
> > > > nfs netfs nfnetlink_queue nfnetlink_log nfnetlink bluetooth cfg80211
> > > > rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd
> > > > grace isofs uinput snd_seq_dummy snd_hrtimer vsock_loopback
> > > > vmw_vsock_virtio_transport_common qrtr rfkill vmw_vsock_vmci_transport
> > > > vsock sunrpc vfat fat snd_hda_codec_generic snd_hda_intel
> > > > snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep snd_seq uvcvideo
> > > > videobuf2_vmalloc snd_seq_device videobuf2_memops uvc videobuf2_v4l2
> > > > videodev snd_pcm videobuf2_common mc snd_timer snd vmw_vmci soundcore
> > > > xfs libcrc32c vmwgfx drm_ttm_helper ttm nvme drm_kms_helper
> > > > crct10dif_ce nvme_core ghash_ce sha2_ce sha256_arm64 sha1_ce drm
> > > > nvme_auth sr_mod cdrom e1000e sg fuse
> > > > [  198.633799] CPU: 5 UID: 0 PID: 6081 Comm: nfsd Kdump: loaded Not
> > > > tainted 6.12.0-rc6+ #47
> > > > [  198.634345] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS
> > > > VMW201.00V.21805430.BA64.2305221830 05/22/2023
> > > > [  198.635014] pstate: 11400005 (nzcV daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > > > [  198.635492] pc : nfsd4_sequence+0x5a0/0x1f60 [nfsd]
> > > > [  198.635798] lr : nfsd4_sequence+0x340/0x1f60 [nfsd]
> > > > [  198.636065] sp : ffff8000884977e0
> > > > [  198.636234] x29: ffff800088497910 x28: ffff0000b1b39280 x27: ffff0000ab508128
> > > > [  198.636624] x26: ffff0000b1b39298 x25: ffff0000b1b39290 x24: ffff0000a65e1c64
> > > > [  198.637049] x23: 1fffe000212e6804 x22: ffff000109734024 x21: 1ffff00011092f16
> > > > [  198.637472] x20: ffff00010aed8000 x19: ffff000109734000 x18: 1fffe0002de20c8b
> > > > [  198.637883] x17: 0100000000000000 x16: 1ffff0000fcef234 x15: 1fffe000212e600f
> > > > [  198.638286] x14: ffff80007e779000 x13: ffff80007e7791a0 x12: 0000000000000000
> > > > [  198.638697] x11: ffff0000a65e1c38 x10: ffff00010aedaca0 x9 : 1fffe000215db594
> > > > [  198.639110] x8 : 1fffe00014cbc387 x7 : ffff0000a65e1c03 x6 : ffff0000a65e1c00
> > > > [  198.639541] x5 : ffff0000a65e1c00 x4 : 0000000020000000 x3 : 0000000100000001
> > > > [  198.639962] x2 : ffff000109730060 x1 : 0000000000000003 x0 : dfff800000000000
> > > > [  198.640332] Call trace:
> > > > [  198.640460]  nfsd4_sequence+0x5a0/0x1f60 [nfsd]
> > > > [  198.640715]  nfsd4_proc_compound+0xb94/0x23b0 [nfsd]
> > > > [  198.640997]  nfsd_dispatch+0x22c/0x718 [nfsd]
> > > > [  198.641260]  svc_process_common+0x8e8/0x1968 [sunrpc]
> > > > [  198.641566]  svc_process+0x3d4/0x7e0 [sunrpc]
> > > > [  198.641827]  svc_handle_xprt+0x828/0xe10 [sunrpc]
> > > > [  198.642108]  svc_recv+0x2cc/0x6a8 [sunrpc]
> > > > [  198.642346]  nfsd+0x270/0x400 [nfsd]
> > > > [  198.642562]  kthread+0x288/0x310
> > > > [  198.642745]  ret_from_fork+0x10/0x20
> > > > [  198.642937] Code: f2fbffe0 f9003be4 f94007e2 52800061 (38e06880)
> > > > [  198.643267] SMP: stopping secondary CPUs
> > > > 
> > > > 
> > > > 
> > > 
> > > 
> > > Good catch. I think the problem here is that we don't currently cap the
> > > initial value of se_cb_highest_slot at NFSD_BC_SLOT_TABLE_MAX. Does
> > > this patch prevent the panic?
> > > 
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 3afe56ab9e0a..839be4ba765a 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -2011,7 +2011,7 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
> > > 
> > >         memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
> > >         new->se_cb_slot_avail = ~0U;
> > > -       new->se_cb_highest_slot = battrs->maxreqs - 1;
> > > +       new->se_cb_highest_slot = min(battrs->maxreqs - 1, NFSD_BC_SLOT_TABLE_MAX);
> > >         spin_lock_init(&new->se_lock);
> > >         return new;
> > >  out_free:
> > 
> > It does help. I thought that the CREATE_SESSION reply for the
> > backchannel would be guided by the NFSD_BC_SLOT_TABLE_MAX value but
> > instead it seems like it's not. But yes I can see that the highest
> > slot used by the server is capped by the NFSD_BC_SLOT_TABLE_MAX value.
> 
> Thanks for testing it, Olga.
> 
> Chuck, would you be OK with folding the above delta into 9ab4c4077de9,
> or would you rather I resend the patch?

I've folded the above one-liner into the applied patch.

I agree with Tom, I think there's probably a (surprising)
explanation lurking for not seeing the expected performance
improvement. I can delay sending the NFSD v6.13 merge window pull
request for a bit to see if you can get it teased out.


-- 
Chuck Lever

