Return-Path: <linux-nfs+bounces-7339-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7864F9A70B4
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 19:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995411C226C9
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93B21EE02C;
	Mon, 21 Oct 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AiH+O6KT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UVkLeHnE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB851EB9EE
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530695; cv=fail; b=sU+Ga8DUCEPYLbyPHywcxKzMkiiwhqvbHiXJsiE1EE35dmyh63jH0zCtDbiQiavy6GVpDHPT16BIWs84PC688N9y+xF6Np/e6qQjvDvdzxsONcOY7oKjOqh/DPhuE+qiIs+G+6unQxd1i/0VCcOIRLJVeYmTnBOb7xHzOy7diH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530695; c=relaxed/simple;
	bh=vHQKZFVpYFnvspCSCfqCOM4iatLbl3Tg0vgKG6WVq2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qrs5l72u7WoYkXymMlW0Og3pZbwUhFRrB7otacZYkaLnGNGiPnFgb77smDqM8zAFcC+eSUqme5jIMp1Rt3pWFihxXFjxw1HLItR6PupCFb5KfnZGzNShDGPEyBgWeCAAPhwLyVGJA5Xg66veM6PFo8gEx6wv8e8JGkoETb05Xxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AiH+O6KT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UVkLeHnE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LFuFSh003472;
	Mon, 21 Oct 2024 17:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=LoFhg8lPjXZ+81g7qd
	9qr5J7QPQXsXwUhWWGj9bDS2w=; b=AiH+O6KTJVyVBBO+JEwXserWMyul50MbZj
	VhQQxB/g1bg59NgO5zvT+n5hGiSoShfql9x7dUn2XjpRlMHOpbwFbdWK2yBa7aEP
	NowR8pnOH60P/QdDU5bBZvwddaKqLoa52vr7PEH+rW1YxwO1q2HRHEXySCuzipwY
	+xSz1CtzM+71LYvBnOO6UFe9s6CE/oqdTA4pebHq2Z3e5iygHGQ2d3EgEQ1hQZZU
	MOuCsOVUgDUSjwmpq7Gewevc7Jxh0CyZxIewcFsqX5DlhVWH6kTsvECvAcEh1N92
	mc28ez5QGx8oC4yhOm7tJ3aD7MLvYKLrToQnTKJMvQJU/wOmjX5A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3atfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 17:11:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LH37Us026247;
	Mon, 21 Oct 2024 17:10:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c376kw01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 17:10:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkvfdK13qyN1RE6u5YsE57dQY+FDKj0LCIq4/rUhUtEt0MhCdwPYDlGUyH+QHtMAhmTqbxefbAihpqk6ulflYycoiqn5xYRnGkXgQFAc2gBW6KI2PJCZWo7hY2AQkG7DhfQ13kGTxKtyAXX8nzADh9lnK0MhbRsIiGf8GZwvCD62K4eZF+0mRXcsNxS9l214M297w4SJ27NvUYbf7qqLd8SqgyjiU80EjuFStx5TpWwi7XbNHmxfDD9tA6IYRtruGlsyHUE2Jx3W8Nd4kf5wH+ligLyjsh4tSwfa5IAnfVOuMfKg5ln/syJvvSzteuwKe9TWIMth63K+iOUn6kj3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoFhg8lPjXZ+81g7qd9qr5J7QPQXsXwUhWWGj9bDS2w=;
 b=u1lHlpH7DapoxXXdJsj4v2ZjFIukEzz2OArC1Qm0fjkp0/uhnzdx4WitaFzmT61FCRYqj2XX9tEiGfl2ltV2OQmiqueIZfm2e7+YDH8Z9gbzZXKezNcMgA7VatoCCyF8SjhNFbW5Tls3QzSZdWYBAZS/dWw2ppuYR7/V/1dRXIB+ZCJohSCrNMmUzfW5gHg5BaZeZAovaBI1nLXIR0NvMFwii68/DDKch5VhzkjM8B7Q2vKlMH0Z12CYBc2UhE9aacXOtPxCsgDQI2gKDmybEFh6E0CQ56oZv0yvbr9J7KCL2Xj8uQQyReRispSSjnTShn57BaGT1Jcbs9sHIAfSuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoFhg8lPjXZ+81g7qd9qr5J7QPQXsXwUhWWGj9bDS2w=;
 b=UVkLeHnEgQK5saju5WdqgYUd6y4hhG6mGb2nj0QCNPd+oQJK/linKKx5fAwq60GYiF7DaIl8tFIt9In3yWLIt5Bpeb+5bbgJ2vvQ+cXXXnC5fWE+DnU6I4hOpfvO8cLvlyJFU3J0KMuYTzmxBlAfZL+fPc0kWmmQAHG7bMirdtU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Mon, 21 Oct 2024 17:10:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:10:56 +0000
Date: Mon, 21 Oct 2024 13:10:53 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Yang Erkun <yangerkun@huaweicloud.com>
Cc: jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, linux-nfs@vger.kernel.org, yangerkun@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH 1/3] nfsd: make sure exp active before svc_export_show
Message-ID: <ZxaLHfBo7CbjQ1jx@tissot.1015granger.net>
References: <20241021142343.3857891-1-yangerkun@huaweicloud.com>
 <20241021142343.3857891-2-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021142343.3857891-2-yangerkun@huaweicloud.com>
X-ClientProxiedBy: MN2PR15CA0038.namprd15.prod.outlook.com
 (2603:10b6:208:237::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e2dddb-62f7-4cff-8b9f-08dcf1f353a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HbTVsJaQqwOrK1EbkP5ndB5BV4/M3RVy0f1oSyVfIia6XbHSJR7SK6DWhuae?=
 =?us-ascii?Q?vff9NdXMBAMxLEI7NyomKON8T++FrN7srlhzRcnZIrc5uMfnE7UTmi91jDcP?=
 =?us-ascii?Q?GqThOC/k6ApJpaqiRaNLV0yJ1knDj8t3j8AoowVv9oWpgXdeqiVCBSV9xz8+?=
 =?us-ascii?Q?cOPifghol/1ioewyda2zUDRuf40As+zfS98cl7QB/QHM2pi/DqmJmUpb1YKR?=
 =?us-ascii?Q?vY72eSZLVEU0tpB57SviVGxZ3UJ/JiirklDdy47kTNeJeRMMPWvVTS5po803?=
 =?us-ascii?Q?Hqlb9YH2w+9xXD6xhchaxqIDJQw0DHGNCxiCpwwne4+y3v2cXx4mqMzjpz/4?=
 =?us-ascii?Q?EwSHVgsApHX5u8xkuw6yWdZw+/wg/xb6lD6mQVNtbhorcan/IhgCEl/Hmvjt?=
 =?us-ascii?Q?6OlyHF5IrmkUyMBj7A/qVBfQMKf+uHmhsEg7rkhpse5H661tCgff7EIvsvYy?=
 =?us-ascii?Q?1u7xlXSoUSQw89DohjyAo6F9lPWss/GAZpfkGKVM4kroQIrfm+xQJTnKiuCs?=
 =?us-ascii?Q?f3B7GYjYISlRa2VGo2Rl1kzLxa8jnqpezcUzSMp2fCOY2EtSOSsU+uM+59Bz?=
 =?us-ascii?Q?I1Bj87BfqUOs1Wb1S27fgwld/T6VV/zRrI1io8iFGhH6AnvMHrJ5OBy+Baf8?=
 =?us-ascii?Q?txvb9KdffTLNfLmMqspwFJIrhnFZ20BYP4g/7ao8sjWhz4sX8mO31t7u1ggD?=
 =?us-ascii?Q?EyMI0UnC8d2j10EE4j8HC9mnzHc9FTX02Wfgg6kxlV7s1ncTZOK60WxTGeCt?=
 =?us-ascii?Q?k3tTiEIumhXFOz68qhRAk4R8dsM1W7ng8E+w4y4/ZnxLv4CfmEYNGs03SXaw?=
 =?us-ascii?Q?KXD4ZjG5TixEEJ51ruuZ9XhhDlxygjIN7016Rm8/FHke8isXLcblseZq1SPk?=
 =?us-ascii?Q?msUR4jMZ5LK4iQb2aG1aYaOqpTE8ookbbs+0tHbkis4zWFX8j8Pw/8MksctY?=
 =?us-ascii?Q?nZLtwDUGmve0t3vwVre7ZJcZYG5p5fTxZjdGJpNHivl9eeEaDj8jHmTdDS/U?=
 =?us-ascii?Q?6XqMwyHH967FDHtH4UhgnSoGdvbiJ8+H5X/sbU2Ub8mNYq8IC/khcSU4Acjy?=
 =?us-ascii?Q?itrpSz2oIP9Id8EoQVL2FgHIeHZQ9sdygV4DGXR3L3GE6TmHtDSZwXTYCwRr?=
 =?us-ascii?Q?3b/BpmatHy2KOta0PvJWLlKxRUETZoDMtyRjF7lQ+pq81QQmLrJ5SEdN++Zg?=
 =?us-ascii?Q?FqfkfnRjfcHf0i1kA194C3g6HcYygwalmAyFCs61UaUDwMIC/brrgCw4smyP?=
 =?us-ascii?Q?FSJq3eH8JGwG+lrc0y+2W0QWgFTyo8oIrTsGMzaQ7ffVzGoORvnbtrmVv/rG?=
 =?us-ascii?Q?9xK/+W9yz7rNiyypoMF3lQXm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+w2Oqcg1k0jABFYOWmn30KZ/d7YdHHqL+mDDDLoYWNfMmv1342GN13WmsVgY?=
 =?us-ascii?Q?yH0jRDpWchrlzObaW4qoZdsjxr98HAN3yb0PlSCxXF/NKk2EdyeHlOMmvmm4?=
 =?us-ascii?Q?j5pIax56jln1/Q9veKgGEGmH9aqs0fHp6Zcp3ASu4HbKfPBg3AbA2YyaKvjW?=
 =?us-ascii?Q?em/izYS0yX0v21inL56hzZ4xMn8WQZnoodAsi99U6gmeHumUBwO+gUGNS1ss?=
 =?us-ascii?Q?0m47h1x7fxjME9HeKdFMSSc3+Aawj08NEIhQzk4NMwXk5DbuCp8JGxyB20ra?=
 =?us-ascii?Q?Vtmnql/2pwx0PKPDoW9pF+1YpMnmSTUrPIHOYQhzm7qX2U3daFavU8hpEr6K?=
 =?us-ascii?Q?aWyVhx9Gk8+xYXHxIs7+t/5/Z0zmWipQNElYEduiP8s4J87lDClbjz6cjmch?=
 =?us-ascii?Q?jsM+VmIr4xn9GZcWa99GA0/Wa1uNlDnkzd8HTIsvLzB1teS+/xIxh1ZS3qmi?=
 =?us-ascii?Q?zyvCtrEBUhBx5N/JFPKKmDTzVbrNdnuJ8ZIYMfw46sf5D4tBGMRoUrEI7tBX?=
 =?us-ascii?Q?YPuEWVWFkmXH+HZUAYkEdqs/022Hyc7AlvDzgRb1DoTFXCUiNYiGmXsoifGY?=
 =?us-ascii?Q?BGJfHV3OVnlUqTsDh8ezEs1JgT8RC/Tkr4BmTKFa0jy0g3xZkQnqm6w6s26T?=
 =?us-ascii?Q?ZXFHgP0mG2xRHrJhIttbhnmssuuSg2nz9PVJG6RJwp5fIZOPXFYv4bih/Fmx?=
 =?us-ascii?Q?kH4LxZKyVKJiFW5aqL9NMRS0rejskGF37l90AcxwM+OAeP9EBLf8FypemmRp?=
 =?us-ascii?Q?T0FDjXAcCHoPFaUkSSBFYXcgEZpqqe735h1HXWlB369L1pRRqI9HJnVGvkur?=
 =?us-ascii?Q?vVuNfCaNaBLZWdAVP5AXKln+BzAVeZ0txxau5+Mnj7Z1I2pRi3kDF0vFujBD?=
 =?us-ascii?Q?49U3z44TQrhErmZCkz95UNv6rqcY6qBI6Rro7BHCpnQtRx71/VxwaIaFd5Uj?=
 =?us-ascii?Q?BDDHKg3loh/LxEaeNgJ4GlLwCNPmmZQJviK/7xK3hu08jhPUQ2fWr/5Smq7H?=
 =?us-ascii?Q?3z/vgVxN17SR8TztLwtzdjIa8XyZezEAD+M8ck+OKlSv9lHWcGcRAE+QkY55?=
 =?us-ascii?Q?gNogzA0Sba1PAFnqwgHGWsm5t7odGssfVCkPknpo1W+IdkdacpJeIb9mG/Rs?=
 =?us-ascii?Q?WDcttqVz17yTMup8xI+uNlKPwnE6BHrCOzf3aNZkadtuSTcrx1hAu8bFfAEW?=
 =?us-ascii?Q?+mTTeRMBfSwvGC2EDjY13vWdIuWNlzRc7xBFji+Tap10j7jxcLwBXIb3+oOq?=
 =?us-ascii?Q?ujUh4aHA6l1x4bEf/exczqTPMsAZADbafkWRrzQKzspr/hbQ5yZXrmDZw/n2?=
 =?us-ascii?Q?+8gsZ1bAMORW0z5m/0CORpiNaF8+9vxro4zE0hskFSG7Et4aLEz9EVQt/1B7?=
 =?us-ascii?Q?sQJN3bIEuGeW2Guzqsa+FKsiL50jPO6Pmo4rQLVSXHBViQ54J3IVSqSYbIBP?=
 =?us-ascii?Q?6lbaSSkT/RGYUkaYdsznMbm8E/k/ijuzBFyCicuErXptqsOBcXSVgCiDi1Ao?=
 =?us-ascii?Q?s7dVEp6KNoYbpimpVIUHLvJg0s2ztbMKBHLSCis7hO5qyIoA3U+JGLH2rf/j?=
 =?us-ascii?Q?N1KgDxjD/fKT2Ecj2s5ahb1qIxt2YaG7ydAe98HdIitvi0skGCkCiHTg77xZ?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qucBqz+jYkNyi/9pMH7mzVNnIVrAfypBNvZXqZ0Lr+taVXQfJ1FKu2AnbWsVapaAXSPC4M14EsKzRi4kQmMbCwCsax+OYrHXNRSG5399o34prwNzNCbvvYRs6OOMbCoy479ehaqtihr9EroG1jpStwwG/7fX+qLcp6lUjxJfSACLlzc2exLIVGKfs213ZLWB6SW5h4sm8ge9jrhpMAu8DGouBULWfATahYCtnqqjTWElJkgtGsMnYddLnzPEo3bnp0LHyz0a1RgOMJWbqCS+H3XrlhxlGeKz88NNHG5b1ip0N5DVv/xnPS5FotcJ65/qUbvKQjyN50oumVOKwBcOunmho1NewbIl8F9loZjc3i+3I2TlWuiGCMq2vMoYvhuufop6Opa3I4Mc79mDee5uzItFHC7WDuJ/0UEQuNR6rpgE7/bGcFL0NKsR9mXx8rdoCamKwUy43H1Srx6Sg1bO07CI/UddkOfwdxvPOTNJVt53eD3E8SxO6K62z3OdFluKQ5KGzqpQqyowjArKL5NQXCaJULjEPypWsBq+gQ3gz/GrQVqFCMxrGkfe73Hew0XfO84mt8+8WVVFgh7IerAgdViGds9NbtjR6/5XxJGlLC8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e2dddb-62f7-4cff-8b9f-08dcf1f353a4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:10:56.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hr47eKxIsXhdEk08eqALtd046PouuJzT/I7GBtNlSH/OYOU3H6yqIWEojlx9MyTIgLtH6kXA1ZixyCKjQdlP5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_16,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=940 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210123
X-Proofpoint-ORIG-GUID: VW3KQQabxiqOpwfw6gEluRF7hr9DywgO
X-Proofpoint-GUID: VW3KQQabxiqOpwfw6gEluRF7hr9DywgO

On Mon, Oct 21, 2024 at 10:23:41PM +0800, Yang Erkun wrote:
> From: Yang Erkun <yangerkun@huawei.com>
> 
> The function `e_show` was called with protection from RCU. This only
> ensures that `exp` will not be freed. Therefore, the reference count for
> `exp` can drop to zero, which will trigger a refcount use-after-free
> warning when `exp_get` is called. To resolve this issue, use
> `cache_get_rcu` to ensure that `exp` remains active.
> 
> ------------[ cut here ]------------
> refcount_t: addition on 0; use-after-free.
> WARNING: CPU: 3 PID: 819 at lib/refcount.c:25
> refcount_warn_saturate+0xb1/0x120
> CPU: 3 UID: 0 PID: 819 Comm: cat Not tainted 6.12.0-rc3+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.1-2.fc37 04/01/2014
> RIP: 0010:refcount_warn_saturate+0xb1/0x120
> ...
> Call Trace:
>  <TASK>
>  e_show+0x20b/0x230 [nfsd]
>  seq_read_iter+0x589/0x770
>  seq_read+0x1e5/0x270
>  vfs_read+0x125/0x530
>  ksys_read+0xc1/0x160
>  do_syscall_64+0x5f/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

This seems better:

Fixes: bf18f163e89c ("NFSD: Using exp_get for export getting")
Cc: stable@vger.kernel.org # 4.20+


> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>  fs/nfsd/export.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index c82d8e3e0d4f..49aede376d86 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1406,9 +1406,12 @@ static int e_show(struct seq_file *m, void *p)
>  		return 0;
>  	}
>  
> -	exp_get(exp);
> +	if (!cache_get_rcu(&exp->h))
> +		return 0;
> +
>  	if (cache_check(cd, &exp->h, NULL))
>  		return 0;
> +
>  	exp_put(exp);
>  	return svc_export_show(m, cd, cp);
>  }
> -- 
> 2.39.2
> 

-- 
Chuck Lever

