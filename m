Return-Path: <linux-nfs+bounces-5415-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5A3954D81
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 17:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9F31C21193
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2024 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9A31BDAB0;
	Fri, 16 Aug 2024 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m285FUQX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bXXmvgH1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25EA1BDAAE;
	Fri, 16 Aug 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821489; cv=fail; b=gJZGlVFpnHXNjD/mf0IXwmNAjs8aunsXFxpxE5AvkJWIHf0bvU62yImAHMMNhEb8OyEKGuyUlvaoy/11Z+iMP9MYPCgIfhrDpBycDpXmrgHo1UqtBMNxZPwtSmD+2kYBxeS1+7N/f/hu4QfQpdK0uwkgAuBsn3AHIOvencOqQCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821489; c=relaxed/simple;
	bh=WJbhCFyxvNvqkIjyqVqn56nmqxwlCtvfYFLRunBoqCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PnPEFJGS67O6lXZ7zF7w1soHIWv0qesl5yNItVLqpJF7TRoQ6uL0pz5VjvEG6oGs7cRADx+1f9UvH83IztCW/AeoVa+XaRQliTIXwM6H7S+9nRoRzQiOSzsSHpY4aWzU2DvqdS8lz+Gdzkx2KrLm6HhkMmHeO2I6Rt4M9IAykDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m285FUQX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bXXmvgH1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GC8sBk007038;
	Fri, 16 Aug 2024 15:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=qUi6MzuZeHYgk5n
	nnygiRrekxrkd/RLWzbSRzTpWRDk=; b=m285FUQX/v5Yk7WcB1k2kZi0nYPjt6J
	IEKi/JQA7xTwT5t2dnhru5/d8VH5owkkKzhVfnjtxGIq4rJST2HxfOD7tTHfLfQA
	mkk9tqC927FN898Ws/uwQY397ZDgf/LhJ+l9b0jBpAds92ssi9OV4LsNoyTW6dK2
	qoOna4dlMs4vBb541D71ZFNNGqelHLH84A8dCrVRm9bVS/W92ywQHRRO4HD04myR
	E6jN4WyQqw3dYkuXt/y9qrxSNs7PZpTf2BjSEaGq0+MyYduXCOtKmu/Eu6HsPdiI
	5i0uWwkdfKm4rEBXKW9rXbS7SFzh/mx1wRT/RAhrPvJrA3LLC87hKbQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy034xbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 15:17:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47GFH3XG010584;
	Fri, 16 Aug 2024 15:17:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxncgtdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 15:17:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmmHPzYv6epgUftQtPC20CS/FPH0uQWbQBaWJICZSGZIbSEkuJSYEjBaTZn+HwNZ3QzX2AJguHlPjf8PK8Uwseptbhws4X6+T4oUP9GXe+2CXbpo3cbukSCqKwriPNWp4i0GDruFau13sL1kKeoABFGxTBVFmxzaWVcVyntA4Dd/Z6bK22QN7BIH4C+lHKVR7c9Q4aZNDuIeNo6pe/IYzKNm7K6aywSSAvErYkF/y0xb1xx5wOlS5PoaN3teXR/NtCg+jrULuDA0MEb6asA+VciaDmv3zxgtRsALnPfwKpCAIprsMCCe/0b3KGcKK78vfMWZ42NMSSx1lYvMkR/RUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUi6MzuZeHYgk5nnnygiRrekxrkd/RLWzbSRzTpWRDk=;
 b=ebD+9UmYG2UjK6rkC0zTaITqg+TjyPQpvheGor4XxS0ecDMIa2/eGNYjMI6iostMGa1fO4sC541n8S58QyIIIqLlAEfmEooVN94h8NUrGLAqsTjxRbRJES+QxqcUh4iybE7u43eUjhu3omLETOzKBflAeQJByQbhhtK2K8pN7EHOdkMYIARdHE/MrT93xmgwy2GGFPG/T3hDm47fB+5MzUZ/OoRqOVTzNne6DrRVVY4rjbM3PzmhQDJWdqPcLWylRT/gKcN6fKmj4nK346+Il4ESKOe75iQk3Ghh2NcL1iAEJsYX5Xm8gos9t5eK5GYVjNtE2eZmMw4N1TOf+ms9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUi6MzuZeHYgk5nnnygiRrekxrkd/RLWzbSRzTpWRDk=;
 b=bXXmvgH1oij4ylQw6ETkxu2atAwzdFJFI+QHZy/vP5SLn5gbVwerajSaYfExv7QXW3UrOxZ7m+xiazJf3YpF6jeehf8FMkIBEA5zcXkxqYKlPCVZQyxN/4+lb722V1J9GLCEMsTToFwGhX+kmBUT0DxU5adaPMMLE27Zc7PvVGo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6570.namprd10.prod.outlook.com (2603:10b6:806:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Fri, 16 Aug
 2024 15:17:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.009; Fri, 16 Aug 2024
 15:17:27 +0000
Date: Fri, 16 Aug 2024 11:17:24 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] nfsd: bring in support for delstid draft XDR encoding
Message-ID: <Zr9thPcPcqYQuXed@tissot.1015granger.net>
References: <20240816-delstid-v1-0-c221c3dc14cd@kernel.org>
 <20240816-delstid-v1-1-c221c3dc14cd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816-delstid-v1-1-c221c3dc14cd@kernel.org>
X-ClientProxiedBy: CH2PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:610:5a::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: a4214840-9c14-464b-76bb-08dcbe0689f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oiLEr1gzJgzAH3rHP3dXHbXmdS2dsH3B5tIz6LOhfzZ+REEkt4T7hLKKWY8k?=
 =?us-ascii?Q?2Kv22VVHVze/pw5BU1RWAKUra/Y/ObASm7GKXtp6soDJIyz/7guLA2QdqfFo?=
 =?us-ascii?Q?4/TcuNLQlDOO4W13tvzSSt/ogqrmakHLrdoswZWyeLzZnY2xLzQT7YU+FZUi?=
 =?us-ascii?Q?MAEgT8fqGJehVWFOmJCJFL3AIUjAOeHdd7XUvrv0sP06lepyfHK3IZKVjOan?=
 =?us-ascii?Q?GZ+ubDA4oRKP7RDi4dCwIN0dBFXysMetJEqMzUFSJTG8b3W1h/C8Ky2a8Cwv?=
 =?us-ascii?Q?z4Qj7HTGUqcKLjZ5lFN8oGFnAWGxaqdLUeszW79Jqoy3McR+gSIoyqprWGbh?=
 =?us-ascii?Q?DnvX/jag6zqlxSNN1khf0garV7DvbmzIRqfF01Z3QAU3v87XpSdnufF9Cniw?=
 =?us-ascii?Q?D1eB6vtM8TZYKLQB7NWssGGZDbw+l2o3UF/lqddyk5iq1tDAqBfecrrTvtd9?=
 =?us-ascii?Q?LaQna0gCOCkFHZA0/uVh0z+EkE/QfnqOy7DKv6oLHlHkx8Cin/a436pyEcIW?=
 =?us-ascii?Q?CnTLBNe/auwCWJkrTmxSM3tVKbs9u/56dZhnYNifHCyD3Yy+YUxNsuG2HUkz?=
 =?us-ascii?Q?LnbsBjIGIkR663j5Rjj06xdVkCwyRainX18S+emT80eoHmPjpa6uurVfZkin?=
 =?us-ascii?Q?B/s/UwOUVYepR/pctXaiCwTAZv4M/+Ajei7XGcorLJ5dVQTvEHX7nukxB6X5?=
 =?us-ascii?Q?nkuZgILppMas+c43x63Aa5VqfJBQoE0yF0rL6zYx8gZIA+5bcMRSaL/QaLFQ?=
 =?us-ascii?Q?0Vv2BDNCCo764Yu7Pbexmz05Tm6MW67iM+pmUumFnusSt/3FEIMnR1m15B8K?=
 =?us-ascii?Q?GwNy+CUI3I3MMkGy81E9CzS1UMN0GtpKL9Cn6ig2HclUOOrlH2YPmKu4Ke9D?=
 =?us-ascii?Q?bVO1yYL7nIoCh2ykYvXDLSLzhPdngb2A46kMKxYTU/epJ2a7hq99lPBR4+Q3?=
 =?us-ascii?Q?VsCr8YjUb/zWgaEs9SPilwzZLbqWuL/vSLa47fLwN/Q9Xj3DyWp8AuPT1iKn?=
 =?us-ascii?Q?H3NEA5FSIcCt+O7Mb5gtX9ZkhJ7lO38lrb3/lvzgTLz6Acp/Hhopt07ly++D?=
 =?us-ascii?Q?bppQ1dxwbFU5zwbjngQ6fufVmD64UcPvLi8NNkYggoqYJJI7rEmtCYPpdKu7?=
 =?us-ascii?Q?NC3bQAkAJAiaTM5sbKTg845UU8/K1L7IOqBzgZsWD+xK0QgEofZac983e35c?=
 =?us-ascii?Q?WWz27mS+9pNeYh+0Y6U4tqS4wZurBIrNuJQv0/SPDNJS5RFpw/4whJgq46Zw?=
 =?us-ascii?Q?PvhwcLvQEhDydGRvACKW7BttxK9TP4CjgWUfSlO/KCOti1GdorOzOExlmd0T?=
 =?us-ascii?Q?hd+QAxGVMHesVdKa6+MsXtfOYM/WfjNLwfR1g7VWMBRx5gPpQ+6ds2H4NOHy?=
 =?us-ascii?Q?eqiXWdw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EknchEUQ0QKP2OuZnmKRB6EozPkYvkrp7Bv7BS8D0almeXVNtRlQMFnbsxAy?=
 =?us-ascii?Q?gS8J4+WQGsk0ICfG1hSCAkTZ107fVQqbg2aSTe/X5CAmF3baQCHkXmuEMhne?=
 =?us-ascii?Q?7CqbEdEz2DIkAcVsqosTN53hb3r361tgwBdXg5vLJ1KebEX/xFIJJhwB+aIn?=
 =?us-ascii?Q?bgkPaM+hxM3VkXO8UuaVf3ERSijXOgoesffYDluL1Yqwi4BW4ieUaQixNGaZ?=
 =?us-ascii?Q?qtJ081uLO9/C+ee47m1+jp8ozbSc4QK97MSeOVF5hFK9Wd+VhfN7ZeHUrJtq?=
 =?us-ascii?Q?SNBQoaMr89CaKF8LV+xrGxEBoYuZIDu8okwPSw2Jv28wD2ODEZhSInpb8igU?=
 =?us-ascii?Q?6svU9Q8+04Aj5Kl9VJoFzaZsvmDax2CxMb+OB1BlOqeugD2YPhKu/ACKPVgd?=
 =?us-ascii?Q?zTF3JAXByoxTwCuX815TcedoKQKj/CLWjbnCDbHrzT1l3GyLdw4LIY+672F6?=
 =?us-ascii?Q?Kf8QA+9jlq/maoOFD7wbYL7SxcTA0x7mKE195inHBm5oGfQVNsYp9JEdkMD0?=
 =?us-ascii?Q?s+IepGPxv4t6Oq0X/BnO/WkhHV51Zelg+1vZBNTrGlfdML3JjK1AU/gWo4Xy?=
 =?us-ascii?Q?VXFWl0+nmovD5VkfaaCb3lEc6nRXYKK/jCucstJ8McAQA1Blxh4p3sFiN7nC?=
 =?us-ascii?Q?K4+7nVBKe3SLbOmtQPKSkBtoHwXL0oeMFaxGD9bt1Qmu+D5Ac/LA92V6u3aH?=
 =?us-ascii?Q?E+5Fx7Xwtzxfu6/KajJrD8A9tVKQfvQqCXBv/8+SQd63T+dk/q9ZUAEfy3Vx?=
 =?us-ascii?Q?9dfjWILamcigBYVczgpztyzoaXt2Av1JGuX/l3kHlbgVww71CtAYNv33FsJo?=
 =?us-ascii?Q?Qai7KqGKoPfMATY7tS72+qYnA2504Ru5ItiQz38ersAZET3dPOmNmDH3U3ve?=
 =?us-ascii?Q?ZIsUljfPS8HCkOXq3nQ8C3yq87COIfuPR+V9XJj70t8YHTFIklUqYPJtBC9t?=
 =?us-ascii?Q?ShNM0ZQwdjVwIkQVUKgIAI93Vgx+p5VK0oY7OiAU1Oqs28yU5YyHDcGjPq5Q?=
 =?us-ascii?Q?ElflUCJda2aQzvQ7kiYM5CcHvV5KCk+lsq4UAWdvCMzNgHE51qFSNm8Um53u?=
 =?us-ascii?Q?nCXY4zl48NVevYJ+E/MrWNJOrdN9SuLAvcnuHTNB0dDoRRGZI8+7oP/CN2h5?=
 =?us-ascii?Q?aZTiSsmMrdnXj4hymho9vFlQVRvkTe/3lupXgvmKG/3P7B1SeWC61jN3djKY?=
 =?us-ascii?Q?7Ox8OBd0IvCiO0rRbeO3d/TcNtfiBXt1uBlF/z/6yCv+knbpwt9uTZL70cZq?=
 =?us-ascii?Q?jFr5ZadlYBLeXmsI1MJvzYBwIQyS4OseZasYO4nt5wGJQuoNOYNPtbb0gwnJ?=
 =?us-ascii?Q?1xYDC6nCsnUpxOXmTYv/2kDNDuW0Ir4gNCdQPmVuYUFRm2zgk40koApdITun?=
 =?us-ascii?Q?SQiew/+ak2ZQU6bialmqyS5sJaUcJlQxGLMcxa8CkrMhWQcJcVbrerUo6uLc?=
 =?us-ascii?Q?+/JgjZp1Fm2FvlHxz4WmNC91X0TCS7HiOi6qgrBfLGQMaMy3efknre7RBRPo?=
 =?us-ascii?Q?APyEYOU+k16Ld9c62sVtK6+QchKu2zXPHpKo8MgWAzOEQXVBWaLOj2iVplzF?=
 =?us-ascii?Q?qssEzt7WFKdPAywBGzkmhtdAwzLwYho5YlTB2stH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RH2giVKK5cQ+1Tv+ihYV0x/M9VDTrNfcFbSoLhavz1ni9QCgbgI3LC6iEUiOTcMoFfDVeBWSaFcQxf8TD0pcDmetQ+tKlMOyQPUh+Jn5yDKafSDC0ab4Q9NCCkaGDwB0sbbMj7kHBymFBe00Y36Jp8BxC85YShy05ba2qH/msotQDiGqHO8Glw8X9F17nIWgjbMo712ueXEEJ91kIOUQQNktxWFv6NqH6DV75NwvPYHqdwhQE1JtK4JjqeWGleb4NjoNlLsFO9Twzi0zc38VLva9zYKM9iXddQlQdiD9nXc0em+zvC50Mwtjig+qD+EBVMbx+MSiqnQkWhnvdDoZatwtk6UR2mKVTuNOTY1FIzgsZhR7nMZMyNp6AV9uShj66ri8hc3ghouKEHn0jtfiIWIAzNPfJ/kSMGlxpm0vpB1AxzKdboMajCbDj6+cZPv/z9L7JeGdMT0Bv9cu6oHHKTFfDEPSqdwny/TxeX/wxPTTRkmUgZ3UwPfi7x6OKN/9Iq6unK2gXy5hrzc0OKNpI8z8q326L+ssd6TTVh44bVb5ZYCgdnHPydSbWGDaz1jXfDobIs2o14LMDKKgl27vVur/Ao3V99ovrewKaC8s5+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4214840-9c14-464b-76bb-08dcbe0689f7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 15:17:27.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePHJ0EgRUmEcnPWa4uaQADtio4Kx3kdHOWHSy9IlzpzIjs6ABj7nEWFI9nc8F7dCXY/+wehwnWoykwPbTGxCcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_09,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=921 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408160110
X-Proofpoint-GUID: nyZ9Plh0iu17OSS243Cq4SXtP2Up7c7p
X-Proofpoint-ORIG-GUID: nyZ9Plh0iu17OSS243Cq4SXtP2Up7c7p

On Fri, Aug 16, 2024 at 08:42:07AM -0400, Jeff Layton wrote:
> This adds support for the "delstid" draft:
> 
>     https://datatracker.ietf.org/doc/draft-ietf-nfsv4-delstid/05/
> 
> Most of this was autogenerated using Chuck's lkxdrgen tool with some
> by-hand tweaks to work around some symbol conflicts, and to add some
> missing pieces that were needed from nfs4_1.x.

I haven't read delstid closely enough to comment on the approach
you've taken in 3/3, but I do have some thoughts about code
organization here. I will try to study that draft soon.

And, I'm assuming you are continuing to evolve support for the draft
and will be growing this series. So I will hold off on careful
inspection of 3/3 for the moment.

First, I'm pleased that you found xdrgen useful for rapid
prototyping. That's not something I had envisioned when I created
the tool, but it's a good match, looks like.

Here you add a separate set of source files for delstid XDR...  That
approach might not be scalable for adding subsequent new features in
general, it occurs to me.

We might end up with a bunch of these little code blurbs with no
clear understanding of how they inter-relate.  Thoughts about how to
manage these are welcome: xdrgen could generate only header files
and then we would #include them where needed, for example.

For now, I suggest folding the new generated XDR code into the
existing NFSv4 "open" XDR code in fs/nfsd/nfs4xdr.c, when you have
some time for cleaning up the patches. An alternative would be to
leave it and I can fold these together before committing.

(The long term, of course, will hopefully be generating all XDR code
automatically, but we're a ways out from that, IMO).

The generator adds __maybe_unused to some of these functions to
avoid having to reason about which encoders/decoders are not needed.
It assumes the C compiler will simply not generate machine code for
unused functions.

But that clutters the source code if you plan to mix it with hand-
written code. You might remove that decorator to identify the
functions that are actually not used by your implementation.

----

On an unrelated note, do you know of a plan to add delstid-related
unit tests to pynfs ?


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/Makefile      |   2 +-
>  fs/nfsd/delstid_xdr.c | 464 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/delstid_xdr.h | 102 +++++++++++
>  fs/nfsd/nfs4xdr.c     |   1 +
>  4 files changed, 568 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index b8736a82e57c..187fa45640e6 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -18,7 +18,7 @@ nfsd-$(CONFIG_NFSD_V2) += nfsproc.o nfsxdr.o
>  nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
>  nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
>  nfsd-$(CONFIG_NFSD_V4)	+= nfs4proc.o nfs4xdr.o nfs4state.o nfs4idmap.o \
> -			   nfs4acl.o nfs4callback.o nfs4recover.o
> +			   nfs4acl.o nfs4callback.o nfs4recover.o delstid_xdr.o
>  nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
>  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
> diff --git a/fs/nfsd/delstid_xdr.c b/fs/nfsd/delstid_xdr.c
> new file mode 100644
> index 000000000000..63494d14f5d2
> --- /dev/null
> +++ b/fs/nfsd/delstid_xdr.c
> @@ -0,0 +1,464 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Generated by lkxdrgen, with hand-edits.
> +// XDR specification modification time: Wed Aug 14 13:35:03 2024
> +
> +#include "delstid_xdr.h"
> +
> +static inline bool
> +xdrgen_decode_void(struct xdr_stream *xdr)
> +{
> +	return true;
> +}
> +
> +static inline bool
> +xdrgen_decode_bool(struct xdr_stream *xdr, bool *ptr)
> +{
> +	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
> +
> +	if (unlikely(!p))
> +		return false;
> +	*ptr = (*p != xdr_zero);
> +	return true;
> +}
> +
> +static inline bool
> +xdrgen_decode_int(struct xdr_stream *xdr, s32 *ptr)
> +{
> +	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
> +
> +	if (unlikely(!p))
> +		return false;
> +	*ptr = be32_to_cpup(p);
> +	return true;
> +}
> +
> +static inline bool
> +xdrgen_decode_unsigned_int(struct xdr_stream *xdr, u32 *ptr)
> +{
> +	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
> +
> +	if (unlikely(!p))
> +		return false;
> +	*ptr = be32_to_cpup(p);
> +	return true;
> +}
> +
> +static inline bool
> +xdrgen_decode_uint32_t(struct xdr_stream *xdr, u32 *ptr)
> +{
> +	return xdrgen_decode_unsigned_int(xdr, ptr);
> +}
> +
> +static inline bool
> +xdrgen_decode_long(struct xdr_stream *xdr, s32 *ptr)
> +{
> +	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
> +
> +	if (unlikely(!p))
> +		return false;
> +	*ptr = be32_to_cpup(p);
> +	return true;
> +}
> +
> +static inline bool
> +xdrgen_decode_unsigned_long(struct xdr_stream *xdr, u32 *ptr)
> +{
> +	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT);
> +
> +	if (unlikely(!p))
> +		return false;
> +	*ptr = be32_to_cpup(p);
> +	return true;
> +}
> +
> +static inline bool
> +xdrgen_decode_hyper(struct xdr_stream *xdr, s64 *ptr)
> +{
> +	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT * 2);
> +
> +	if (unlikely(!p))
> +		return false;
> +	*ptr = get_unaligned_be64(p);
> +	return true;
> +}
> +
> +static inline bool
> +xdrgen_decode_int64_t(struct xdr_stream *xdr, s64 *ptr)
> +{
> +	return xdrgen_decode_hyper(xdr, ptr);
> +}
> +
> +static inline bool
> +xdrgen_decode_unsigned_hyper(struct xdr_stream *xdr, u64 *ptr)
> +{
> +	__be32 *p = xdr_inline_decode(xdr, XDR_UNIT * 2);
> +
> +	if (unlikely(!p))
> +		return false;
> +	*ptr = get_unaligned_be64(p);
> +	return true;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_decode_opaque(struct xdr_stream *xdr, opaque *ptr, u32 maxlen)
> +{
> +	__be32 *p;
> +	u32 len;
> +
> +	if (unlikely(xdr_stream_decode_u32(xdr, &len) != XDR_UNIT))
> +		return false;
> +	if (unlikely(maxlen && len > maxlen))
> +		return false;
> +	if (len != 0) {
> +		p = xdr_inline_decode(xdr, len);
> +		if (unlikely(!p))
> +			return false;
> +		ptr->data = (u8 *)p;
> +	}
> +	ptr->len = len;
> +	return true;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_decode_string(struct xdr_stream *xdr, string *ptr, u32 maxlen)
> +{
> +	__be32 *p;
> +	u32 len;
> +
> +	if (unlikely(xdr_stream_decode_u32(xdr, &len) != XDR_UNIT))
> +		return false;
> +	if (unlikely(maxlen && len > maxlen))
> +		return false;
> +	if (len != 0) {
> +		p = xdr_inline_decode(xdr, len);
> +		if (unlikely(!p))
> +			return false;
> +		ptr->data = (unsigned char *)p;
> +	}
> +	ptr->len = len;
> +	return true;
> +}
> +
> +static inline bool
> +xdrgen_encode_void(struct xdr_stream *xdr)
> +{
> +	return true;
> +}
> +
> +static inline bool
> +xdrgen_encode_bool(struct xdr_stream *xdr, bool val)
> +{
> +	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
> +
> +	if (unlikely(!p))
> +		return false;
> +	*p = val ? xdr_one : xdr_zero;
> +	return true;
> +}
> +
> +static inline bool
> +xdrgen_encode_int(struct xdr_stream *xdr, s32 val)
> +{
> +	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
> +
> +	if (unlikely(!p))
> +		return false;
> +	*p = cpu_to_be32(val);
> +	return true;
> +}
> +
> +static inline bool
> +xdrgen_encode_unsigned_int(struct xdr_stream *xdr, u32 val)
> +{
> +	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
> +
> +	if (unlikely(!p))
> +		return false;
> +	*p = cpu_to_be32(val);
> +	return true;
> +}
> +
> +static inline bool
> +xdrgen_encode_uint32_t(struct xdr_stream *xdr, u32 val)
> +{
> +	return xdrgen_encode_unsigned_int(xdr, val);
> +}
> +
> +static inline bool
> +xdrgen_encode_long(struct xdr_stream *xdr, s32 val)
> +{
> +	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
> +
> +	if (unlikely(!p))
> +		return false;
> +	*p = cpu_to_be32(val);
> +	return true;
> +}
> +
> +static inline bool
> +xdrgen_encode_unsigned_long(struct xdr_stream *xdr, u32 val)
> +{
> +	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
> +
> +	if (unlikely(!p))
> +		return false;
> +	*p = cpu_to_be32(val);
> +	return true;
> +}
> +
> +static inline bool
> +xdrgen_encode_hyper(struct xdr_stream *xdr, s64 val)
> +{
> +	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT * 2);
> +
> +	if (unlikely(!p))
> +		return false;
> +	put_unaligned_be64(val, p);
> +	return true;
> +}
> +
> +static inline bool
> +xdrgen_encode_int64_t(struct xdr_stream *xdr, s64 val)
> +{
> +	return xdrgen_encode_hyper(xdr, val);
> +}
> +
> +static inline bool
> +xdrgen_encode_unsigned_hyper(struct xdr_stream *xdr, u64 val)
> +{
> +	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT * 2);
> +
> +	if (unlikely(!p))
> +		return false;
> +	put_unaligned_be64(val, p);
> +	return true;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_encode_opaque(struct xdr_stream *xdr, opaque val)
> +{
> +	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT + xdr_align_size(val.len));
> +
> +	if (unlikely(!p))
> +		return false;
> +	xdr_encode_opaque(p, val.data, val.len);
> +	return true;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_encode_string(struct xdr_stream *xdr, string val, u32 maxlen)
> +{
> +	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT + xdr_align_size(val.len));
> +
> +	if (unlikely(!p))
> +		return false;
> +	xdr_encode_opaque(p, val.data, val.len);
> +	return true;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_decode_fattr4_offline(struct xdr_stream *xdr, fattr4_offline *ptr)
> +{
> +	return xdrgen_decode_bool(xdr, ptr);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_decode_bitmap4(struct xdr_stream *xdr, bitmap4 *ptr)
> +{
> +	if (xdr_stream_decode_u32(xdr, &ptr->count) < 0)
> +		return false;
> +	for (u32 i = 0; i < ptr->count; i++)
> +		if (!xdrgen_decode_uint32_t(xdr, &ptr->element[i]))
> +			return false;
> +	return true;
> +};
> +
> +static bool __maybe_unused
> +xdrgen_decode_open_arguments4(struct xdr_stream *xdr, struct open_arguments4 *ptr)
> +{
> +	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_access))
> +		return false;
> +	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_deny))
> +		return false;
> +	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_access_want))
> +		return false;
> +	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_open_claim))
> +		return false;
> +	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_create_mode))
> +		return false;
> +	return true;
> +};
> +
> +static bool __maybe_unused
> +xdrgen_decode_open_args_share_access4(struct xdr_stream *xdr, enum open_args_share_access4 *ptr)
> +{
> +	u32 val;
> +
> +	if (xdr_stream_decode_u32(xdr, &val) < 0)
> +		return false;
> +	*ptr = val;
> +	return true;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_decode_open_args_share_deny4(struct xdr_stream *xdr, enum open_args_share_deny4 *ptr)
> +{
> +	u32 val;
> +
> +	if (xdr_stream_decode_u32(xdr, &val) < 0)
> +		return false;
> +	*ptr = val;
> +	return true;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_decode_open_args_share_access_want4(struct xdr_stream *xdr, enum open_args_share_access_want4 *ptr)
> +{
> +	u32 val;
> +
> +	if (xdr_stream_decode_u32(xdr, &val) < 0)
> +		return false;
> +	*ptr = val;
> +	return true;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_decode_open_args_open_claim4(struct xdr_stream *xdr, enum open_args_open_claim4 *ptr)
> +{
> +	u32 val;
> +
> +	if (xdr_stream_decode_u32(xdr, &val) < 0)
> +		return false;
> +	*ptr = val;
> +	return true;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_decode_open_args_createmode4(struct xdr_stream *xdr, enum open_args_createmode4 *ptr)
> +{
> +	u32 val;
> +
> +	if (xdr_stream_decode_u32(xdr, &val) < 0)
> +		return false;
> +	*ptr = val;
> +	return true;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_decode_fattr4_open_arguments(struct xdr_stream *xdr, fattr4_open_arguments *ptr)
> +{
> +	return xdrgen_decode_open_arguments4(xdr, ptr);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_decode_nfstime4(struct xdr_stream *xdr, struct _nfstime4 *ptr)
> +{
> +	if (!xdrgen_decode_int64_t(xdr, &ptr->seconds))
> +		return false;
> +	if (!xdrgen_decode_uint32_t(xdr, &ptr->nseconds))
> +		return false;
> +	return true;
> +};
> +
> +static bool __maybe_unused
> +xdrgen_decode_fattr4_time_deleg_access(struct xdr_stream *xdr, fattr4_time_deleg_access *ptr)
> +{
> +	return xdrgen_decode_nfstime4(xdr, ptr);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_decode_fattr4_time_deleg_modify(struct xdr_stream *xdr, fattr4_time_deleg_modify *ptr)
> +{
> +	return xdrgen_decode_nfstime4(xdr, ptr);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_fattr4_offline(struct xdr_stream *xdr, const fattr4_offline value)
> +{
> +	return xdrgen_encode_bool(xdr, value);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_bitmap4(struct xdr_stream *xdr, const bitmap4 value)
> +{
> +	if (xdr_stream_encode_u32(xdr, value.count) != XDR_UNIT)
> +		return false;
> +	for (u32 i = 0; i < value.count; i++)
> +		if (!xdrgen_encode_uint32_t(xdr, value.element[i]))
> +			return false;
> +	return true;
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_open_arguments4(struct xdr_stream *xdr, const struct open_arguments4 *value)
> +{
> +	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_access))
> +		return false;
> +	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_deny))
> +		return false;
> +	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_access_want))
> +		return false;
> +	if (!xdrgen_encode_bitmap4(xdr, value->oa_open_claim))
> +		return false;
> +	if (!xdrgen_encode_bitmap4(xdr, value->oa_create_mode))
> +		return false;
> +	return true;
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_open_args_share_access4(struct xdr_stream *xdr, enum open_args_share_access4 value)
> +{
> +	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_encode_open_args_share_deny4(struct xdr_stream *xdr, enum open_args_share_deny4 value)
> +{
> +	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_encode_open_args_share_access_want4(struct xdr_stream *xdr, enum open_args_share_access_want4 value)
> +{
> +	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_encode_open_args_open_claim4(struct xdr_stream *xdr, enum open_args_open_claim4 value)
> +{
> +	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_encode_open_args_createmode4(struct xdr_stream *xdr, enum open_args_createmode4 value)
> +{
> +	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_encode_fattr4_open_arguments(struct xdr_stream *xdr, const fattr4_open_arguments *value)
> +{
> +	return xdrgen_encode_open_arguments4(xdr, value);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_nfstime4(struct xdr_stream *xdr, const struct _nfstime4 *value)
> +{
> +	if (!xdrgen_encode_int64_t(xdr, value->seconds))
> +		return false;
> +	if (!xdrgen_encode_uint32_t(xdr, value->nseconds))
> +		return false;
> +	return true;
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_fattr4_time_deleg_access(struct xdr_stream *xdr, const fattr4_time_deleg_access value)
> +{
> +	return xdrgen_encode_nfstime4(xdr, &value);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_fattr4_time_deleg_modify(struct xdr_stream *xdr, const fattr4_time_deleg_modify value)
> +{
> +	return xdrgen_encode_nfstime4(xdr, &value);
> +};
> diff --git a/fs/nfsd/delstid_xdr.h b/fs/nfsd/delstid_xdr.h
> new file mode 100644
> index 000000000000..3ca8d0cc8569
> --- /dev/null
> +++ b/fs/nfsd/delstid_xdr.h
> @@ -0,0 +1,102 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Generated by lkxdrgen, with hand edits. */
> +/* XDR specification modification time: Wed Aug 14 13:35:03 2024 */
> +
> +#ifndef _DELSTID_H
> +#define _DELSTID_H
> +
> +#include <linux/types.h>
> +#include <linux/sunrpc/xdr.h>
> +#include <linux/sunrpc/svc.h>
> +
> +typedef struct {
> +	u32 len;
> +	unsigned char *data;
> +} string;
> +
> +typedef struct {
> +	u32 len;
> +	u8 *data;
> +} opaque;
> +
> +typedef struct {
> +	u32 count;
> +	uint32_t *element;
> +} bitmap4;
> +
> +typedef struct _nfstime4 {
> +	int64_t seconds;
> +	uint32_t nseconds;
> +} nfstime4;
> +
> +typedef bool fattr4_offline;
> +
> +#define FATTR4_OFFLINE (83)
> +
> +typedef struct open_arguments4 {
> +	bitmap4 oa_share_access;
> +	bitmap4 oa_share_deny;
> +	bitmap4 oa_share_access_want;
> +	bitmap4 oa_open_claim;
> +	bitmap4 oa_create_mode;
> +} open_arguments4;
> +
> +enum open_args_share_access4 {
> +	OPEN_ARGS_SHARE_ACCESS_READ = 1,
> +	OPEN_ARGS_SHARE_ACCESS_WRITE = 2,
> +	OPEN_ARGS_SHARE_ACCESS_BOTH = 3,
> +};
> +
> +enum open_args_share_deny4 {
> +	OPEN_ARGS_SHARE_DENY_NONE = 0,
> +	OPEN_ARGS_SHARE_DENY_READ = 1,
> +	OPEN_ARGS_SHARE_DENY_WRITE = 2,
> +	OPEN_ARGS_SHARE_DENY_BOTH = 3,
> +};
> +
> +enum open_args_share_access_want4 {
> +	OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG = 3,
> +	OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG = 4,
> +	OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL = 5,
> +	OPEN_ARGS_SHARE_ACCESS_WANT_SIGNAL_DELEG_WHEN_RESRC_AVAIL = 17,
> +	OPEN_ARGS_SHARE_ACCESS_WANT_PUSH_DELEG_WHEN_UNCONTENDED = 18,
> +	OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS = 20,
> +	OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 21,
> +};
> +
> +enum open_args_open_claim4 {
> +	OPEN_ARGS_OPEN_CLAIM_NULL = 0,
> +	OPEN_ARGS_OPEN_CLAIM_PREVIOUS = 1,
> +	OPEN_ARGS_OPEN_CLAIM_DELEGATE_CUR = 2,
> +	OPEN_ARGS_OPEN_CLAIM_DELEGATE_PREV = 3,
> +	OPEN_ARGS_OPEN_CLAIM_FH = 4,
> +	OPEN_ARGS_OPEN_CLAIM_DELEG_CUR_FH = 5,
> +	OPEN_ARGS_OPEN_CLAIM_DELEG_PREV_FH = 6,
> +};
> +
> +enum open_args_createmode4 {
> +	OPEN_ARGS_CREATEMODE_UNCHECKED4 = 0,
> +	OPEN_ARGS_CREATE_MODE_GUARDED = 1,
> +	OPEN_ARGS_CREATEMODE_EXCLUSIVE4 = 2,
> +	OPEN_ARGS_CREATE_MODE_EXCLUSIVE4_1 = 3,
> +};
> +
> +typedef open_arguments4 fattr4_open_arguments;
> +
> +#define FATTR4_OPEN_ARGUMENTS (86)
> +
> +#define OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION (0x200000)
> +
> +#define OPEN4_RESULT_NO_OPEN_STATEID (0x00000010)
> +
> +typedef nfstime4 fattr4_time_deleg_access;
> +
> +typedef nfstime4 fattr4_time_deleg_modify;
> +
> +#define FATTR4_TIME_DELEG_ACCESS (84)
> +
> +#define FATTR4_TIME_DELEG_MODIFY (85)
> +
> +#define OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS (0x100000)
> +
> +#endif /* _DELSTID_H */
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 643ca3f8ebb3..b3d2000c8a08 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -55,6 +55,7 @@
>  #include "netns.h"
>  #include "pnfs.h"
>  #include "filecache.h"
> +#include "delstid_xdr.h"
>  
>  #include "trace.h"
>  
> 
> -- 
> 2.46.0
> 

-- 
Chuck Lever

