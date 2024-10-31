Return-Path: <linux-nfs+bounces-7607-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC28E9B7E29
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 16:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE22280E97
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4EC1C7B64;
	Thu, 31 Oct 2024 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AfeuUnea";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E1UnpZDs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE2B1CC157
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387719; cv=fail; b=fWts+x3zQG0qz20hs8Fs2QE52QqjttGzf0uvjD0O20xeKqsg3HdppqLeRlj7Ny67yQqDXvEpkQsQ9eWojp3bH9ZpBRLSFU126uTEPMVRR4s7EqjU0b1sgPd2IrY8jQapN7kcpwl2ZX8oj30KwJ3WB6Kj1v3wJoDkGeBwiiwD4IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387719; c=relaxed/simple;
	bh=w4GhoItb5BsyIg7cekwaxrxyv/vvl7/vA+OlCbOHBI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FTo5na4CQEvA/kETYmqcWQvyU2KhshcP7vPEnC/+pcI1Zr9WFh6bfwxOHgBPmfAWRlmR6bMRFJV11ZDIgNn0sbz4KsCKTYkT3YSGER/0dlV8IPw7+z8dxTSYb5y3ql2XYBi+ftyKy38X7f1AetT465MA6GOY8PVUHX1SdbOHLGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AfeuUnea; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E1UnpZDs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49V8u102024524;
	Thu, 31 Oct 2024 15:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=fEgXjSXG30+nZtE+uH
	k74arLDk2F26K9q1OCpi7LwLY=; b=AfeuUneaYi7MO3FBDgAu0UVbGSBjCER/du
	jeWBY+HUChnbkcg1mXDTkwqPF01pC9UFAMnVv7fKMGsOqlCyF/afIG29ghWSnhWP
	rpebt98o1d6qwMSZavdiToZeGG52ZhTAEWIKclpD2EL7wW4DF++Rrh163pX88gq/
	rGEj2HbzzjAeGEn3dq0EyM3EjWh4d3eRIl34QuUemg8u4INzJ2FodxoXpuJ3IUwW
	eqMJ2lEodL+h3oDGZItdRKiyuZKyhu0vRciahnnujT/FgOLD73cjBmRiZsBR0slw
	L2qLO2iB07CsIKGcWw5kmFwiPGvw6vPOmwUUQAnA+yt6Um2UjqmQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgwjdvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 15:14:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49VDeSOs008435;
	Thu, 31 Oct 2024 15:14:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnecfea5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 15:14:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOCLKGtJo6w6JujXIUU7SIm7GTrR5MusmOYiytQebDF008LeT4QEfofXL6J0jh2kCvfPAm5D01ajMNNJNIbt6G/i6lSKBHnjSgtoaf763GgL7STuyIAtDh0Kxa/8ZibAocRPFir+KIdeA5mZtreQTEEsU7LG7uCDVczeATVFMKuvL6e3usuDxKdEnOLLFYceNb7hBHqHkvRexlCyXESBQCu6ccsd8M8ibRu2gzFtABCVQLs9iD5+1pfsN7a4r6vK8YBLHanmc9unotWkTC5ZFBz/9bE2BTC9ItO+hGlpjabvjnACYSnEz7MuVkUwp7C3FYUEwvlzVZloOpBV7D36dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEgXjSXG30+nZtE+uHk74arLDk2F26K9q1OCpi7LwLY=;
 b=oiwymDT/0er5NFxTeIx6FfxUNGs7d1xdvte3Muay4oYBnr7+7L6Tkb0BWpePWrEHm9nrg2Zp6Ni9v2GUIDo/LZfuVn2Cun+7YqStbodVr9wRlbFrjvEq1ufacOsIkRoipJwrTe7x5AO3JVBveIrXB3vZs1ZPe6jIhYbjvxts8T0vJGyP+yxwG1MZ3h4do4oRn06lLn9YSq3HbravNET9eUQkXJiKihm3pJp5NOD2Sp0OUDtKuXmxuNxiIdxwiFx5n6hCOHkOEFYpTBqsg3C1Os2ZzmskxKgITZvPvFQb94aEq6l75Zq9HVGEC+UG8fvwrNQa1giWCit0OfsTN3zN5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEgXjSXG30+nZtE+uHk74arLDk2F26K9q1OCpi7LwLY=;
 b=E1UnpZDsMavnS+Tk/6aVox9J3R1kS6Etc0iuv1bWVeOrCw5hFnTrWkhAWEluglaWf9L+W3FjFAp+kCiSTDIBy3+z5Hp6me1lZPGGp3ZwdVZz0TsaK1TagFS6WD1+ZfvDXtD+1DdwX5XjcS6Du9r+fGPQeavOuxgjey/Bae5N2FE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5140.namprd10.prod.outlook.com (2603:10b6:208:320::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 15:14:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 15:14:54 +0000
Date: Thu, 31 Oct 2024 11:14:51 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4
 reexport
Message-ID: <ZyOe66m0BbAOWOyI@tissot.1015granger.net>
References: <20241023152940.63479-1-snitzer@kernel.org>
 <20241023155846.63621-1-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023155846.63621-1-snitzer@kernel.org>
X-ClientProxiedBy: CH2PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:610:59::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: f14b51fc-3a4f-4c27-be1e-08dcf9bec5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qdlR4TtnOvJ/WnPtwGoR77DsfzTtHw1ET7fgmvqkqSCWz272nsES1mix2kvd?=
 =?us-ascii?Q?CMrd2Ug3aI58T6D99HYgP8xCDucQsv0lY9HxhjlGf/s29oo0RXVkhW3dR09G?=
 =?us-ascii?Q?fNkG37TNKHtg9aww3xZ71+opiHY+7a12kmKOtQK1yAEuxf0W593A7MpFDZP7?=
 =?us-ascii?Q?5MF/9U1D37810ldx/bekrlMcf0qUmDTLqoSBcLmP1AKWkNW26X/nUKW8E3qt?=
 =?us-ascii?Q?QOweCK3yVCzVs4VF58lEEkT4ihtBqSV2KIbMxmk3CA+t+0v5hfSG5BVbSW5l?=
 =?us-ascii?Q?FGB9ALn9P7f+h/XZT110OgsSs8rjkmE3N9x2W5Xyp9ek5N5p2L7ao9/O9eVY?=
 =?us-ascii?Q?j4ugvg2uvhrAPhcfaZKESdOQGBiZtnWrmet8JZIQk4UXq3mAQ5fxvKC9xAue?=
 =?us-ascii?Q?Nk/4hXwzRIarwG+2Pv7n1GiDO38xzPkbXi6NznW2UFpK0Pa8ZEpF0O5Niiq3?=
 =?us-ascii?Q?ZczKBS1thCEi+Zpa4NR4i7NsrtGm/rZSoGmw9j/rDJDPdzA52YwqHMpZmbjW?=
 =?us-ascii?Q?FsOl5aPQhGdNFqHTGqTsmcA/n82/K2ZZEyoBb8IOpGyoFtc8GyvQMa7Mc9w1?=
 =?us-ascii?Q?PvpQ6JJ9uD70sukyMAbdUUQDxvLe3xsgO/NecZ09uIgbgIqucP/G3dpkeVCv?=
 =?us-ascii?Q?pnBi2mXxx/R6l5i+BVdDsunidbS5xF/I0NeffdvGAHzX68ei1nj6GpiriArB?=
 =?us-ascii?Q?Ygm+KysWhIGULmkD3Y22i+EoV2+BUTS5TC36UZY9RU0vIM/qIPiThyyUx/3X?=
 =?us-ascii?Q?x9FZIDv3HeHVdnv9TBhpcjtLC88MYEy2d+SSKDtmsB0JEo0NZttYuQKo4rKB?=
 =?us-ascii?Q?/SBNT6DX2GmuOPXZdlsddA6aG8d97P9b/yuGI3KrhrmXRvz147wsRspAvDEt?=
 =?us-ascii?Q?8U5XEKrnhiC3kunms8oFRtGNu+fsSDmbHjx9WYlNtA8WCDxc9AxQ+MYuslh6?=
 =?us-ascii?Q?CazXziDHefCyCaFVrXID/LUwittrooeXvDl18KDHWAZrHTir6KjdFmsb2Wlf?=
 =?us-ascii?Q?zeLZhAzqyCs5KFtZBMRByGEXZ8Eay2M4QCiaU00WniOWY4NQdWZWBIv96SLx?=
 =?us-ascii?Q?+e3kWRpt9CkjBx3wzQWrADKb4mysfvjhcDIR8vUXe0LYguhZb2xDOgQiiGvs?=
 =?us-ascii?Q?K/Y+prrDfIVGCbBwKuKkLVz9S3FIGJunK43y/1NydTpV5DZ8e0wscawBff2L?=
 =?us-ascii?Q?dK1MbY10E0ucMrtSMDn5YC9XDKypreJntcXGZlp2AwfukWJStLSGTQ9UFJw1?=
 =?us-ascii?Q?Srjc4IwToSA6d9CmTQVBkE2roqAb10uNTYH49tAFOnMiZq2gjCfqxGFtJ98g?=
 =?us-ascii?Q?c0YUPYkoYF0uKm+6ZWnBANhM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C8nD/gyCUO+AN8Z0TuZop+qa3OMPTOEmPBMw/fKAqJAyNN5wov1vaQ0+8K1z?=
 =?us-ascii?Q?OiD3MDErNBdvLMG/gjmgMxe9xfasXNoQ3S69WVfgrfgnCp7ren2MbXRrHLEQ?=
 =?us-ascii?Q?qGpHGUTgZE4KpeSRSVYXqiZ3K9XK2/sAxRsFYmmule126ttVEuRKYEv5JGgC?=
 =?us-ascii?Q?RlcRSmnoZGyoYXHV3E6myS2an3O83jAEuwrn0gK5s43CwH/yqW8jtj7x+EET?=
 =?us-ascii?Q?APx93vLtrAKaUB2L79u4+EW7D2lHqViHUrouT+o3psrAoOtvdVxsH5LV4O/d?=
 =?us-ascii?Q?9ISEGtX4+9AZdtDeMLvU+P4H5pszW0ETBiQ8ZNLYGSbAIxuRYbhvDUUYy8QA?=
 =?us-ascii?Q?C357CNAppL/srF/HTjOChQIMF5NKk5Q9mcutAMnnr+08BNa0fp5iu8H88Jmh?=
 =?us-ascii?Q?WJgL2LD1tIl9AePW9AXo0gUYja2yUYQt+R3dUZpjfUf6mgr7uB7fFfdULlzK?=
 =?us-ascii?Q?y7DVAcS8WFifK22eodDaZZeh3WM/zR6AujhcSvHwPuGr6jKJiadN7kR22Hqo?=
 =?us-ascii?Q?dcz73nuJs/cpT2TzAtH1LMw9frRcoV7ILr2YMrzyhGWMmzThADfuMocyQm75?=
 =?us-ascii?Q?rwPwG9o7TXYZxnS3MXa6a50E7sM4lLBVsKbFH3bgNajKD6+T77mnmIjPvR7X?=
 =?us-ascii?Q?Q/bzAj/1ZBmFgIZPCjMUBDDwiFXq+aQWiBfNE0nNtTjh5OjMr6/bIuYJn4Sp?=
 =?us-ascii?Q?tcNbDS7KI7HeoYkyme+95c1/LbGOirzFU5c7ZfXBBBXRy3CN3vaM82lAz5EY?=
 =?us-ascii?Q?PaXWlUuFlL+blZfgPDRtS0Aj25/YXxUIcA7OoKRPFYLOZyc9ZhKQL84ge5zE?=
 =?us-ascii?Q?4DciZOsFmlE8mMnsCy/Cb6kWL1dk635QmpJ86GP0l3pBf3qlXsNFMv9XIe6/?=
 =?us-ascii?Q?s44ed8CX+ZhmbenUD1AtVFKn8Z9cflkWyRSmIRDBRJxe4OHqfE2kAhxjTIQP?=
 =?us-ascii?Q?POb5QNAStcYf0Pm4nZxiM6Yst0mAAqjnX+nQvm8MJLA5JvAn7NTYpOBx5Mm7?=
 =?us-ascii?Q?4CmZ1lVlx2JIpa3S0b0COn4QjR52RMsVbIObMYIgQxuxlrZkrNyX0VfbYjXR?=
 =?us-ascii?Q?/zp28OssgQiJVY4NQAJCQOQ7hElQZpXo2VCaJhAF+N7OQti/VfBGvlPe+HT7?=
 =?us-ascii?Q?Lqr8VTf67H4spziMOKBFOGSRPUVwUue612YB6XfjS45//ASHUxPD8ZyeYICl?=
 =?us-ascii?Q?sQTDVb+xsoYeHBFOrC4UimUkHaiiM2yg/6WrfKiXlwH/+ovWwVToSF2djF6G?=
 =?us-ascii?Q?/YQtuPijmyfWUQuCBb+8f/OxIZQqKG39wo42QEDzAFsNqz7SIMXEjWckeC0Y?=
 =?us-ascii?Q?ylbXducPFABi6a6rpRdCbkbDfrlwrp8lEvZxLEiQUVFM5DbWSaO7yG9qn+hS?=
 =?us-ascii?Q?mCy/KCQV+Xi6qpjxPW1bFu/BrXazRQ2AvdnGAK67uv3fvWbk84p0WO4Ww8oe?=
 =?us-ascii?Q?SJkgn/ADLeQ9hg0GpdoyQ7QLfK7hj+yLecqEHP2PSTZ3rULbq0L0yxaksfL2?=
 =?us-ascii?Q?+fAjIT6MmGC87iQgwPVVwXnino1lks4w3PHxAoX6yAiC5NXFqnyxG7qwo87D?=
 =?us-ascii?Q?E9UF0vxZbKYST3aGGMCqED5c0X8/s/PwS5MWC28X?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	19dxRTuG+gmzQXwUdHuGpEEPfjmqSGATtVUk1Q+PVagSMY8oWWdYe1So1BRTJO0vS9a01FKjVhX6suFgoJLwvpP0l5aiQnkTYKwvCkRGEgJxR9XIdEskP3QYJc/Dw/wijStYPR3jyXzqOIgT46b4cfs0Wq4wnx8pZXsOs/vxtRusEKJRkFUzUh39Mn9dhEVP7GTB8M/FZL2zKFe27SQnCBi2ZfT/OUxCsMTyQ3ZQMy9xsHeYZ1UOcqcDr+ApTS0TCiTVQi3mWyexklv06RAQnIYoRsElRmSZHA1lOxKAl3Icg8KLBtqutcU92eZB8K9O+qTh18auSBK2puuIMREfx9eDw/AjAFNm8nY8fRV1DPbAxJsu92LbcFqfP8jbqoNOC8wrdVLjv/1Ezc57WloKs6SkrnLYb9yyWcYePWnVfRbVdqoM1MWbjWn/vtHpEmGAaoqUgIzD2PbF6wQ8gGopb3TSwOh3dBgB8mi8ZPirfXR5hC4mbc+YcWqM3dcan2GcZOeV50sYN/2L7MeED6aO+7XObWUANO5ZYJTZKOdOZbDpMXUWAerOcE8JNuTdVwb8TPuP5xFg7CugGcJE4QommSXYC8839RPetZypxeiWClo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14b51fc-3a4f-4c27-be1e-08dcf9bec5e8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 15:14:54.0695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxEozEpOpKPQ3Yv2qxp/O5G2aM9ErJjd7nPoOQH4bTfqx6TR3XsRXHttj7jCFoZBlsyvMb2E8WtkV6UzSELiQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-31_06,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410310115
X-Proofpoint-ORIG-GUID: NdyJ9dsLZY9J8jRDqIXO4E30_m_FJNoI
X-Proofpoint-GUID: NdyJ9dsLZY9J8jRDqIXO4E30_m_FJNoI

On Wed, Oct 23, 2024 at 11:58:46AM -0400, Mike Snitzer wrote:
> We do not and cannot support file locking with NFS reexport over
> NFSv4.x for the same reason we don't do it for NFSv3: NFS reexport
> server reboot cannot allow clients to recover locks because the source
> NFS server has not rebooted, and so it is not in grace.  Since the
> source NFS server is not in grace, it cannot offer any guarantees that
> the file won't have been changed between the locks getting lost and
> any attempt to recover/reclaim them.  The same applies to delegations
> and any associated locks, so disallow them too.
> 
> Add EXPORT_OP_NOLOCKSUPPORT and exportfs_lock_op_is_unsupported(), set
> EXPORT_OP_NOLOCKSUPPORT in nfs_export_ops and check for it in
> nfsd4_lock(), nfsd4_locku() and nfs4_set_delegation().  Clients are
> not allowed to get file locks or delegations from a reexport server,
> any attempts will fail with operation not supported.
> 
> Update the "Reboot recovery" section accordingly in
> Documentation/filesystems/nfs/reexport.rst
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  Documentation/filesystems/nfs/reexport.rst | 10 +++++++---
>  fs/nfs/export.c                            |  3 ++-
>  fs/nfsd/nfs4state.c                        | 20 ++++++++++++++++++++
>  include/linux/exportfs.h                   | 14 ++++++++++++++
>  4 files changed, 43 insertions(+), 4 deletions(-)
> 
> v3: refine the patch header and reexport.rst to be clear that both
>     locks and delegations will fail against an NFS reexport server.
> 
> diff --git a/Documentation/filesystems/nfs/reexport.rst b/Documentation/filesystems/nfs/reexport.rst
> index ff9ae4a46530..044be965d75e 100644
> --- a/Documentation/filesystems/nfs/reexport.rst
> +++ b/Documentation/filesystems/nfs/reexport.rst
> @@ -26,9 +26,13 @@ Reboot recovery
>  ---------------
>  
>  The NFS protocol's normal reboot recovery mechanisms don't work for the
> -case when the reexport server reboots.  Clients will lose any locks
> -they held before the reboot, and further IO will result in errors.
> -Closing and reopening files should clear the errors.
> +case when the reexport server reboots because the source server has not
> +rebooted, and so it is not in grace.  Since the source server is not in
> +grace, it cannot offer any guarantees that the file won't have been
> +changed between the locks getting lost and any attempt to recover them.
> +The same applies to delegations and any associated locks.  Clients are
> +not allowed to get file locks or delegations from a reexport server, any
> +attempts will fail with operation not supported.
>  
>  Filehandle limits
>  -----------------
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index be686b8e0c54..2f001a0273bc 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -154,5 +154,6 @@ const struct export_operations nfs_export_ops = {
>  		 EXPORT_OP_CLOSE_BEFORE_UNLINK	|
>  		 EXPORT_OP_REMOTE_FS		|
>  		 EXPORT_OP_NOATOMIC_ATTR	|
> -		 EXPORT_OP_FLUSH_ON_CLOSE,
> +		 EXPORT_OP_FLUSH_ON_CLOSE	|
> +		 EXPORT_OP_NOLOCKSUPPORT,
>  };
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ac1859c7cc9d..63297ea82e4e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5813,6 +5813,15 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	if (!nf)
>  		return ERR_PTR(-EAGAIN);
>  
> +	/*
> +	 * File delegations and associated locks cannot be recovered if
> +	 * export is from NFS proxy server.
> +	 */
> +	if (exportfs_lock_op_is_unsupported(nf->nf_file->f_path.mnt->mnt_sb->s_export_op)) {
> +		nfsd_file_put(nf);
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
>  	spin_lock(&state_lock);
>  	spin_lock(&fp->fi_lock);
>  	if (nfs4_delegation_exists(clp, fp))
> @@ -7917,6 +7926,11 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	}
>  	sb = cstate->current_fh.fh_dentry->d_sb;
>  
> +	if (exportfs_lock_op_is_unsupported(sb->s_export_op)) {
> +		status = nfserr_notsupp;
> +		goto out;
> +	}
> +
>  	if (lock->lk_is_new) {
>  		if (nfsd4_has_session(cstate))
>  			/* See rfc 5661 18.10.3: given clientid is ignored: */
> @@ -8266,6 +8280,12 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		status = nfserr_lock_range;
>  		goto put_stateid;
>  	}
> +
> +	if (exportfs_lock_op_is_unsupported(nf->nf_file->f_path.mnt->mnt_sb->s_export_op)) {
> +		status = nfserr_notsupp;
> +		goto put_file;
> +	}
> +
>  	file_lock = locks_alloc_lock();
>  	if (!file_lock) {
>  		dprintk("NFSD: %s: unable to allocate lock!\n", __func__);
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 893a1d21dc1c..106fd590d323 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -247,6 +247,7 @@ struct export_operations {
>  						*/
>  #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
>  #define EXPORT_OP_ASYNC_LOCK		(0x40) /* fs can do async lock request */
> +#define EXPORT_OP_NOLOCKSUPPORT		(0x80) /* no file locking support */
>  	unsigned long	flags;
>  };
>  
> @@ -263,6 +264,19 @@ exportfs_lock_op_is_async(const struct export_operations *export_ops)
>  	return export_ops->flags & EXPORT_OP_ASYNC_LOCK;
>  }
>  
> +/**
> + * exportfs_lock_op_is_unsupported() - export does not support file locking
> + * @export_ops:	the nfs export operations to check
> + *
> + * Returns true if the nfs export_operations structure has
> + * EXPORT_OP_NOLOCKSUPPORT in their flags set
> + */
> +static inline bool
> +exportfs_lock_op_is_unsupported(const struct export_operations *export_ops)
> +{
> +	return export_ops->flags & EXPORT_OP_NOLOCKSUPPORT;
> +}
> +
>  extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
>  				    int *max_len, struct inode *parent,
>  				    int flags);
> -- 
> 2.44.0
> 

There seems to be some controversy about this approach.

Also I think it would be nicer all around if we followed the usual
process for changes that introduce possible behavior regressions:

 - add the new behavior, make it optional, default old behavior
 - wait a few releases
 - change the default to new behavior

Lastly, there haven't been any user complaints about the current
situation of no lock recovery in the re-export case.

Jeff and I discussed this, and we plan to drop this one for 6.13 but
let the conversation continue. Mike, no action needed on your part
for the moment, but please stay tuned!

IMO having an export option (along the lines of "async/sync") that
is documented in a man page is going to be a better plan. But if we
find a way to deal with this situation without a new administrative
control, that would be even better.

-- 
Chuck Lever

