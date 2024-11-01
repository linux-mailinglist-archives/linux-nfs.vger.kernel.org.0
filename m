Return-Path: <linux-nfs+bounces-7625-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 235049B9576
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 17:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7750CB2138F
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2024 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C577A1A2643;
	Fri,  1 Nov 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UpkUgC/3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k9ewc3K9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4208A81741;
	Fri,  1 Nov 2024 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478775; cv=fail; b=PGJKqAOYIhgv1epFz1pCEEvKl7YPPKj5eRfJfOIRiKJXyGsnNVDPgfWoulKHAthK9BqWDwWKNb/E8aa5MvETkqW6ofzEBK55BMfK3iW7jZjk1Ycc9oL9xW+WogyqNasxz9pF8Ma6JCt1p8GhstoOE5feldlsCXDVcD0zgPL63Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478775; c=relaxed/simple;
	bh=c+DlgEAEUJpxwysHfbxOEtLLuKkR/j5I4ynYkn+nJj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ryTI1/GRMNq2z1K0VrKpcrS6wOjEVRB7FEGhYSgnfqukd5fSjTnYKGao0OuGRL6T7x8Gu51oHU4///hYpxlQVPVAn2qPLA8h3uoiClGJ4qNEETS9Jrf8GVjdnkqSu3DNHs6Sk5TyyrqPoN0cbq82JNtR5QTpvei8lyyAnSmi/Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UpkUgC/3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k9ewc3K9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1GBoQc019754;
	Fri, 1 Nov 2024 16:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TseTCXAMulraY17I6x
	VZDelZMEqtsNl9fVjn1LojDLY=; b=UpkUgC/3+4GPo7z/XTPEcQIsh+TO7urCjZ
	93C1RDZ1LPCPlCCNjWUzANlZa70fDCPDT44Fg2S+SU3vanNSkiyvKlofCABa+H8B
	7ZSLURVV00/biv9BTQcQRXLjBdcLQ3KhYglEBdmchDLLRXfNFvP7zV1S0YLHz6Tt
	nxGEV0+F3Rf3HS7ZIMAo0uDdp4ULwIAy88o/KHkmZ47TQ9jZ/2r6hpANrj+btb5g
	LXlyss6B16Om4EMB+p906sQvYpsTYr1zjnOGzHWAh0/1vv9XiVJIZF9kawwXQ8a/
	dYToGhDUESm+uIo8xkvg7n31G5WMTbfPuD/mf5gJAapGwPLuBTyw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdpcm7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 16:27:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1Fua90034748;
	Fri, 1 Nov 2024 16:27:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hndbq9v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 16:27:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uq+5ddi0Hwz0zR46KpeD8Q2lYRjhM+EPoJs1c2ZyRvFpx61icldE9BoNQEiPsADR0ZxPNFzRmpyhcM4jV8zRBZqaMJLdLVmAKP9ugduuLqgTWQ+W9e3LfzNlcvuklV4KkvfPXVxYhR5u9QSRYnsV7JeCX4E/PZwTKUPum6m/94uWcvixUF2EBwJHa5wDFOjY8lpvulv5zt7X8ZlOIQIwfpRPbzBt5Q0uPsh1Sqtz8jGwjK1jNYsiYPVB2tcy6EHiPZd1Jp1dAcdtKpN0OLpvp+t6ZLWqNiSnSeevsgAc0WyU1dy3BA9KJhzny1XIxk3bf2ilJbKo25fj2etBzLrIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TseTCXAMulraY17I6xVZDelZMEqtsNl9fVjn1LojDLY=;
 b=NDqtgjKhGvuurx/gwG3KoKwJUg8xhu3/OX5YUZi0JzljOEk8/uLllU4NeRgZZyb0xxYuG4SJTU7OaCLDxBhBrncAwV2pQgEo1BcpP1NDRNtzXDe6hcYY3LcipRDh0OKxZD/GFVKPSSKnUU+eBvWiu4ei98mE2DQH0gzjrWjIFdt146DKhDEWcmAaqG/2/11kqCii/a0FnNUWlZiQTzfNE8cyNfPlagggNZI+57FKE4CMB0ANDhapbtmrsjokG+Mma1idc8xHuoSXC+iPZjjoPOmf4oCzZmysXrkqvzTsiMzz3CW7NUSHqJU5yy6N/Gj7mqiXzGlyDRrJvOUuBDieLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TseTCXAMulraY17I6xVZDelZMEqtsNl9fVjn1LojDLY=;
 b=k9ewc3K9bUBq1HtVTCLxlpVhPziPTNzVOTxNKPZtYZ4oF/9TcwNH3y9Y2OKfl4ds8cw8NzRsSyjXwEPi7WiG+SdnFaaG3tnZ40dlnUp/EpqL7lXktSEKyVmSPmBNXUd9Y4WWSFtL4vBivx71fEujxd+e1bQ/jTeREuu3oP7PmGc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6256.namprd10.prod.outlook.com (2603:10b6:8:b5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.20; Fri, 1 Nov 2024 16:27:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 16:27:18 +0000
Date: Fri, 1 Nov 2024 12:27:14 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Simon Horman <horms@kernel.org>
Cc: Ye Bin <yebin@huaweicloud.com>, trondmy@kernel.org, anna@kernel.org,
        jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com,
        Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        joel.granados@kernel.org, linux@weissschuh.net,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org, yebin10@huawei.com,
        zhangxiaoxu5@huawei.com
Subject: Re: [PATCH] svcrdma: fix miss destroy percpu_counter in
 svc_rdma_proc_init()
Message-ID: <ZyUBYpOuHHHc2NoZ@tissot.1015granger.net>
References: <20241024015520.1448198-1-yebin@huaweicloud.com>
 <20241101115511.GA1845794@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101115511.GA1845794@kernel.org>
X-ClientProxiedBy: CH2PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:610:53::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 4799cde8-3901-4e06-7417-08dcfa920da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ZCxtdVo0fKqPG9cewsAfk8e3trMMZ0JneO8yNeAv4z/spR2xD1C1Rj+J6ar?=
 =?us-ascii?Q?XLPDQf1t242TO/1VbcFb99jcfFhs8YRxP23CPPiiHQHMZl8zvQ65P3TwZWJr?=
 =?us-ascii?Q?IisFoh11MVBcV8tuYMBvUJninl9ClZlhqf96017vnukc+20H3gMmLlTbYktn?=
 =?us-ascii?Q?Ijpl8W1PRK5sO+Wc6q6gOas9BU5z+paLBCxY0ajdx/g7nF9UXLyXXAyZzTUK?=
 =?us-ascii?Q?kPRImCaWNNc/oS88Th4tSkd6J+BxaT5XuQR0ffDG0q1msuoZBZxO6vNusRqw?=
 =?us-ascii?Q?5HT286TDLlBGNQDWCy5BTeCmzAvOgc6Wr8KgpJsoGOUUwPHW7VpfRykkSABG?=
 =?us-ascii?Q?a3N+7zBOHG77rPAfnaUlL7K0IibS7PEUMB3Ty2XB3/bTpRpQrbswH5XQ80nP?=
 =?us-ascii?Q?NI9VEnrA6LjEhkkO217vAkwoxY0EpDIOfmPEKMlde8IZA2ZMKE2tANY8eeC/?=
 =?us-ascii?Q?BxPirjMUF2OMFHh9YUpSL0A4OsFh4qTJXqCkhLMCz59jVwIjdBxxQriySi9m?=
 =?us-ascii?Q?dPjAqFeIAkwyqKAPW0ckQHCdNTNCdaJjO5y7N1ydu/26d/mvP1Zq8do5GXFQ?=
 =?us-ascii?Q?JLbHfAnyQg6kjUu0E+rQp2hWFtT4Q/LB7np580IUrFvu6wNdzwH+EusFe+X0?=
 =?us-ascii?Q?69FjMkMsAacjKkbsWZe9Jd7wM1KNeL/lNpIIW5SJsNi0efNmm8IfY+rx3bds?=
 =?us-ascii?Q?5FB5wYGfrYhIzU5Lm+O3K+ahOblApFduOKVVmI3vcKSkdVtpMc2BhueUTWSh?=
 =?us-ascii?Q?ywrUtghTzNBmjA45qWF56AsRNm1oFi/APpzAO7sICIc72G92ueCGDGvrzoH1?=
 =?us-ascii?Q?lKYWR9LHx040FhFydNIqgydOF3t6lhjd1eKTo+6UcMTtZtBoRQiznbWiVxlh?=
 =?us-ascii?Q?ZYiAtvyqgrXkA5KDkW7N+PheJI7VP1/Ml8OdWDoF8bNDcFl5GGRSV8NO0Usy?=
 =?us-ascii?Q?RmDXcqZZWB1UelssheYEaNwB+oXeRNNPFQ+u8C/knVhFayuStxMiusW7YTD0?=
 =?us-ascii?Q?WKnidNFXYGru5WUH/sCnJ16RlehldlLY18oAPaoMFh74EnslWUq3x1SPNWi2?=
 =?us-ascii?Q?UZ22aeSaRkjAqlODNXk3eNyZtDiFa26NgQpauOcXPhQoymEEz51T2PUZtK5W?=
 =?us-ascii?Q?tkbHQCTvEXjQau80IVg/I3jUe4QQQBL7c3peRYQs/7FB0+4May4QnXyjcHAR?=
 =?us-ascii?Q?/QojZOm7jmHz9LKahUD9ZLjx6CuBJPtFIEFpbKV61paKAwnl3o3fDBq+HhfV?=
 =?us-ascii?Q?B4mFPSYqubZSo5Ll6q7nVoGiLRtBWuy31tDEUjmN2mvFZ5Xnyf0EOxvX6ppT?=
 =?us-ascii?Q?5qq1zZluzchUNY/E7dcbrjUa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rPD1aSXmtvwWnvX4dL/XPGZ7azTwEoLUh1rt3Gkb2cpUq62oWb2E+Iu80F60?=
 =?us-ascii?Q?/80gA9eZbJ0GrIXoKE0Y9SWRx+SkpnOM9QOdc30fs2ORTaIr9ibuHrSO7QJt?=
 =?us-ascii?Q?CJqdLQ9bwN5fyuIWKB0MgOKjjKfzV5wU++H8bHweYaQ3i+uF93pM4tlAaoZG?=
 =?us-ascii?Q?IZbDf3bE9FYuutpZdrJeCFAoQGZfiskVFYeMc6tUM5BUwT4PNui2gVZ4rXcU?=
 =?us-ascii?Q?GRYzUJwIZGuMgqphLMcNa1X9XMgcOEgnIKyTVvrt9OOs6bMKfvBODHMtkWD1?=
 =?us-ascii?Q?yGONhnGSyzp849gYe6IBIkdd1Ilegs7SeMqV5R1w7n3ojg4ijwg8h/kSUq+W?=
 =?us-ascii?Q?VoC67aiMYPMB2QUXbPvvh33/YK+AQ8XB7CsgU09iQVAb2iXkGN+DU7XhB/0x?=
 =?us-ascii?Q?2dwPDIbdHZQXftLMgWNFaxdSQojEZHJ2eDTUlbirukkOV75O34kMzqgKbTVk?=
 =?us-ascii?Q?PdJqD1OAnhsK0MXBYxNuIwXoFzQHHzyRDRYEfd0tc2VnlWf9OBZoxZpG+XVu?=
 =?us-ascii?Q?5cOzEFCyI+dKBlpMJm42Ps1ZS5HHKWZ2y62p7QudnRAba9z+akA60bayw7Pf?=
 =?us-ascii?Q?lnYZthT/lLfWq8nqiZGND+pihS2S+WGeCZr3Oa6oJkIQJwPD0YSD4G0EWlas?=
 =?us-ascii?Q?+c33U3401yuxqSrFftf8CbHso5i15o7fP8+Hw3K7Fyi7EMkprW4YyL5Cup4v?=
 =?us-ascii?Q?JxoqrSmXJ/uSlR7Ws4eKakidFtTEzm3sg9zUaJ/J34XpB+HZXvpZ/1iKMSTh?=
 =?us-ascii?Q?42o4wdSHpgs21a3DSHdQzxLNKqISkKuFSPOWkfELHMLN6KetHIIjJh1TQlwN?=
 =?us-ascii?Q?YAWq5NvdvSyc+ge7YnjeNepLXg5imgxWJDKERoAmFfGCh4Az45R27A7Z3kE0?=
 =?us-ascii?Q?6iteiyLQFLyH2kvwBkHO5ewQH2pyEP4lrxcXslepvoE0t1RsDQJzQ82rdwu4?=
 =?us-ascii?Q?QE7W8v9leMgfDAPCHbuHhOhs4RQdFhr+unAd7pNpPQOhB7DCBNaNFw/9IZC5?=
 =?us-ascii?Q?PZtx7MBe4f/Os2LkFQYXkmK0rWcURGrh6uFxttIaPnC72e5vTIuijlbZ3J73?=
 =?us-ascii?Q?Pge8A3mbqSxNL9EiDwRaAXyiuRLyoxlIBKVxgsEdnh1lVuElPTF+xJeB2ehM?=
 =?us-ascii?Q?1iSROQZfPANPdRGQHKrPahraXObHjnj52pwW01cz33WZyPcwtY8D0fpzC3fk?=
 =?us-ascii?Q?e5U4rL2YZZd6pDYr7BrMnS28GNoWmj+7nBWyogbnRekaBSpEYYl6nXaPaTLV?=
 =?us-ascii?Q?zz4vHY9k4grrJi5T/ID0oYGfNGSWZWuVfx9rEgdlPm/9x72zhNPwIA5WtiAB?=
 =?us-ascii?Q?0EBvIndywxP16O/oJZe3nGHekShc8ZPggwFnkSEvZLNe/hKtz/6xvzlDsfVI?=
 =?us-ascii?Q?QidTCCao11r8oUy4dninJq2jwrxgzWPrOVpEvGHrFHmNilZQ68KGVsONTcgG?=
 =?us-ascii?Q?XTK6UPc/PFljr46wNmmaRdfGo8JWJi8/49BgBdGF2NDxW9MTIPLtgH1MwBKx?=
 =?us-ascii?Q?nyKXBqUDVSZai2OVKZ3kszuR7A0IakyEv3kEe5hU9Y6MfwkS43KqmTkSjUn/?=
 =?us-ascii?Q?a3mvHzGiJ05C9YTX8w1B5I8muNfil8MryyKjVSeO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aaXcQzLRfz0Z3xQfMEPbUGdmXKMWY4UpvtP7CJraF0gGorF+sVsAMyVOd16S0SbNVQYsREDuRgxryU+rOFal3c0rfQTtZ48dp261h3f+5yZVvW5xCQ3NyJSjGArlmWzH+G1qidhygX+FwPouRV9pbH6NxTo1m8dkPh00/k8bH0Rn/HNAjxm/bpB7DFbG9NnUi+VOojGo5B5bXyK/8aEyH5iQw9fhbS/X6GKeBstEkjWzbhyAIZILhi2SyjIZkbfVW5VY0rw/0JzJ7hUF9Y9LYJuFH2CqcW14aLeflOEz0E5rW9GpV0GsvEIe4uLbo9CknnGsQVi0aHWuODIcLRf73PUbPb/5uEhTMVHPb8DPc9bDbe+qQbUw7ikLviLIpZdEEy/e27f9L6UuU0k7tXomMiEl7F6Vk5GS1NUv0qUHEnQuHD3iidwAxiLpAFdBZ9IO0fnK7ER2/J8mwMFQlaa8N7Y4e3kqAr3qufAv9anfzVleRHfUVKF/olZ+T38q9dJDR2hBkjRjjS2GSf1z11Cz1cTeJbLv1YGAt3benRtcN+RMoT6VBa0kY/833qAMkjBOXZYViXbDSgdawd221jwNk0HLp/jmdeJefoZD/7j4W7Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4799cde8-3901-4e06-7417-08dcfa920da5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:27:18.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lU9K3M0hvOvocmbAQeivTtinD4d5m9zHqvLRZFUumR1oa/j+YFZJ0yKyNJ99gsgF1phbFDOLW0Xtz9kBTZ4rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6256
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_11,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010119
X-Proofpoint-ORIG-GUID: XaYvWJo_OuyybAmTTp_bWLqD0vzNuqPh
X-Proofpoint-GUID: XaYvWJo_OuyybAmTTp_bWLqD0vzNuqPh

On Fri, Nov 01, 2024 at 11:55:11AM +0000, Simon Horman wrote:
> On Thu, Oct 24, 2024 at 09:55:20AM +0800, Ye Bin wrote:
> > From: Ye Bin <yebin10@huawei.com>
> > 
> > There's issue as follows:
> > RPC: Registered rdma transport module.
> > RPC: Registered rdma backchannel transport module.
> > RPC: Unregistered rdma transport module.
> > RPC: Unregistered rdma backchannel transport module.
> > BUG: unable to handle page fault for address: fffffbfff80c609a
> > PGD 123fee067 P4D 123fee067 PUD 123fea067 PMD 10c624067 PTE 0
> > Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > RIP: 0010:percpu_counter_destroy_many+0xf7/0x2a0
> > Call Trace:
> >  <TASK>
> >  __die+0x1f/0x70
> >  page_fault_oops+0x2cd/0x860
> >  spurious_kernel_fault+0x36/0x450
> >  do_kern_addr_fault+0xca/0x100
> >  exc_page_fault+0x128/0x150
> >  asm_exc_page_fault+0x26/0x30
> >  percpu_counter_destroy_many+0xf7/0x2a0
> >  mmdrop+0x209/0x350
> >  finish_task_switch.isra.0+0x481/0x840
> >  schedule_tail+0xe/0xd0
> >  ret_from_fork+0x23/0x80
> >  ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> > 
> > If register_sysctl() return NULL, then svc_rdma_proc_cleanup() will not
> > destroy the percpu counters which init in svc_rdma_proc_init().
> > If CONFIG_HOTPLUG_CPU is enabled, residual nodes may be in the
> > 'percpu_counters' list. The above issue may occur once the module is
> > removed. If the CONFIG_HOTPLUG_CPU configuration is not enabled, memory
> > leakage occurs.
> > To solve above issue just destroy all percpu counters when
> > register_sysctl() return NULL.
> > 
> > Fixes: 1e7e55731628 ("svcrdma: Restore read and write stats")
> > Fixes: 22df5a22462e ("svcrdma: Convert rdma_stat_sq_starve to a per-CPU counter")
> > Fixes: df971cd853c0 ("svcrdma: Convert rdma_stat_recv to a per-CPU counter")
> > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > ---
> >  net/sunrpc/xprtrdma/svc_rdma.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
> > index 58ae6ec4f25b..11dff4d58195 100644
> > --- a/net/sunrpc/xprtrdma/svc_rdma.c
> > +++ b/net/sunrpc/xprtrdma/svc_rdma.c
> > @@ -233,25 +233,33 @@ static int svc_rdma_proc_init(void)
> >  
> >  	rc = percpu_counter_init(&svcrdma_stat_read, 0, GFP_KERNEL);
> >  	if (rc)
> > -		goto out_err;
> > +		goto err;
> >  	rc = percpu_counter_init(&svcrdma_stat_recv, 0, GFP_KERNEL);
> >  	if (rc)
> > -		goto out_err;
> > +		goto err_read;
> >  	rc = percpu_counter_init(&svcrdma_stat_sq_starve, 0, GFP_KERNEL);
> >  	if (rc)
> > -		goto out_err;
> > +		goto err_recv;
> >  	rc = percpu_counter_init(&svcrdma_stat_write, 0, GFP_KERNEL);
> >  	if (rc)
> > -		goto out_err;
> > +		goto err_sq;
> >  
> >  	svcrdma_table_header = register_sysctl("sunrpc/svc_rdma",
> >  					       svcrdma_parm_table);
> > +	if (!svcrdma_table_header)
> 
> Hi Ye Bin,
> 
> Should rc be set to a negative error value here,
> as is the case for other error cases above?
> 
> Flagged by Smatch.

I can add "rc = -ENOMEM;" to the applied patch.


> > +		goto err_write;
> > +
> >  	return 0;
> >  
> > -out_err:
> > +err_write:
> > +	percpu_counter_destroy(&svcrdma_stat_write);
> > +err_sq:
> >  	percpu_counter_destroy(&svcrdma_stat_sq_starve);
> > +err_recv:
> >  	percpu_counter_destroy(&svcrdma_stat_recv);
> > +err_read:
> >  	percpu_counter_destroy(&svcrdma_stat_read);
> > +err:
> >  	return rc;
> >  }
> >  
> > -- 
> > 2.34.1
> > 

-- 
Chuck Lever

