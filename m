Return-Path: <linux-nfs+bounces-4157-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0B5910A27
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 17:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9771F22B1F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 15:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB32A1B012A;
	Thu, 20 Jun 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ghDfn8KC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KnXa2hDJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2590C1B1402
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898000; cv=fail; b=UFjFYSnTemsBwvzlrGl7Uz34Bp5gogM3JUuTud+3KY2/Z22qdXTh+y/mp02zisqguDSbTPPBpKtVD6Wy1FxUc+ITdUUuy7/CoW7f62oKT2O3wmVJCkKuImTcyMKEs6YLgSmVJgOF2ovVdVUsBwSiUpOJWdPfHdkDYdfId/3hSBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898000; c=relaxed/simple;
	bh=RuUVeOs6wD+PE9FrORX6B/DitPMQklKouXQsC8n/HEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PRrRfo65NZeVLVdKHNq/+HRbkuMYY363kHGTQhNjEMVJRmco4572zbkNuJgTsObezpW7yIF54SLqK8I7OhFzVCj++DXW46sDNzB+nlHSmd79IpPacMh0F4I8kPE165stt5SfNVchAxoUx39fzJKIOfQnbU+rwpxxibAX220vkNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ghDfn8KC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KnXa2hDJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KE5ChX014411;
	Thu, 20 Jun 2024 15:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=g6EvLNUUvonXhvY
	HhbmA+bKWdQLs4zrclO3mcizrmH4=; b=ghDfn8KCJHjy+RFPa20pE1DTmiTJw8k
	hk/DRO5+phUFrAGRNxd+TDKAa59+jFjghX+6OO4tEfoF4vSnskkLGKM78FRduQnn
	jpYs6+rFNMYWrpMeDHQC3AFqVXObcxjl7Nh3So86hMhpVakhUAGQ0IGbsIlL+1IA
	5gTijLctig9Z2wwvn0qg//D9iRIoLaqoaeu2dQV2rWT1K6gj7bDHU5kMpXeNzOBa
	8sw0XyHB5a05kye9Rd7RYcMXCEUuG2LoZhVcFo9wB0RP2kvp1FRu8Y4Ej9ZfKNvR
	ZhKjQup4qBolxlAA13sLazYexNHto46e24L5ZAe9GSRZ3KKGKPBLh+Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9gkjjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 15:39:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KF9wVc034458;
	Thu, 20 Jun 2024 15:39:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dh7e24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 15:39:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGQ/U4H0pBGrFBZCoRN0TICld8B61rBarWTxYWltbb0EjRndIFxLNwq0o2yPmtVXqMQRgYBuN1cC6xzddz2VmvdfNRzUvpqG9hpBq+xNVwfhQ2PbI8k3FGFbT/FusL7oT7M78Cf/MW8P2raF6az+ECSyMoo5r5hLAtXl6vaQZ8hYWE1ZL4Yn0WevcBksvwCYArCfzHFfWyCLSPC4zqaVMNpxJqVrgEimkmdR6jX666hpWdHJSRW2p6evz3Ju0CNdpJJPQ5AgxkeHwN5B94O/CN8Ufqt7mugAqT05zLZR+elSgH/LD8/HamAnI1yKf0DKewTTG5j1MosrgPBN6oc8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6EvLNUUvonXhvYHhbmA+bKWdQLs4zrclO3mcizrmH4=;
 b=WfWgyAvC8kayUXlZphYDrTWIRDDxJM13lka+iozLBYtEq0jrSC8DMDoPZOtO24dWFHd0aZQAHMl/m12PeWG37yab2rhiD8Gr3OwMvKLek0hdr9wr6RdryWd1uQGjJYrRGIYi28LJVnR0O6rUKPd+hqmX8wzhA6/cT/ezoEadqdnDiLvEMhNgu/q+Rb33s0/rpAfVAbG3P+1A4/MgeLyYn9XjLXbfOWpe/ybA8ZYI0tVMqdYDqWozMXVjn/XvNqii5jkLGt8ym16OhjdJFRYe1EeJGCLi342KdRsXlL/vfwsQpHsCPm0DCpSpCcxuEs8RHxGLmXJ+swyA8psdm6mcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6EvLNUUvonXhvYHhbmA+bKWdQLs4zrclO3mcizrmH4=;
 b=KnXa2hDJf8taHrX9+erWan6fCemH01s7wAxfd9YfwkEFuGcYheOqjYLlaKEKo5JZNkL8PJk2U1QJBVMjGvjaA92aF5hGu3/nPrYR3aKmSvOia3xWccmMJg43/kr+Bxi71LR+VPp45hMwurWD36TIPyTAaCrJH0sc4rmb2ONX4bA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5137.namprd10.prod.outlook.com (2603:10b6:208:306::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 15:39:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 15:39:36 +0000
Date: Thu, 20 Jun 2024 11:39:33 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Message-ID: <ZnRNNZvQM7xqF5Mi@tissot.1015granger.net>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-9-cel@kernel.org>
 <20240620050614.GE19613@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620050614.GE19613@lst.de>
X-ClientProxiedBy: CH2PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:610:57::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: acd094d5-9ef2-4374-828b-08dc913f30ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aDxhLrioJwTPlgs77QoLZ46gC4EnJcLkfHdxqmaqbZt5DXZckSwsSZj6KBsD?=
 =?us-ascii?Q?DkCpx7jEd39LenurLwJcU3WOKPqPdyFlejAhJyanpn1gFtSjY/hRqHeVspXz?=
 =?us-ascii?Q?WpRhw664+rVZu/Zhz4+qRjTQta2eTfPFCGgw3ivMa9YmEIWF2YPCYeBCqgn+?=
 =?us-ascii?Q?JCIh1e7ZK67nigD32xw+pY6K41nD4BrMyb9PkMNbSmNIHBblhllp9RQzfSG0?=
 =?us-ascii?Q?NnLkivN3xlt/lUiFcrWAvWaPy9btCNOXI+L324CqXqZShkD2sFJQWgRZDb9b?=
 =?us-ascii?Q?RJI0rHOBwnMvLasRqIYYg4wUKkwmA9f7MIrNXrLJG6JQK4EhwSYk+7GYG1Uw?=
 =?us-ascii?Q?iL12AmhX3d6Mwmr5zlhbvIHUhcPy3KyhQX6i7biBPyNvvKjCG4yv1lLUmoMd?=
 =?us-ascii?Q?9aMo2f70lTJsP1wyeoaZkqmyGa+Dc8668D1YGkq5JeQx4e2gC2jOxCEpOaVD?=
 =?us-ascii?Q?lo5Jc+DiCjFm8VHeeLZWfjRAi3S+61SD/idMsoSSo4BW4dmFJJfgq+5xsU4i?=
 =?us-ascii?Q?G6h/qA3QrBX8u+u5qA26Mlpx01CyzZMmfk6rTNDm7FrETJLUnzmA7Sqs6toq?=
 =?us-ascii?Q?L2xXjq1rvU6z8voAbtLoIgGWTnOxcHa+Z/dLUFQN4rfzmVVu5xGi6DxBOsmm?=
 =?us-ascii?Q?5XFzVbM0Howto9fni34+x5JTDeDl+ZZ10kUfqzyygibczfbDrjLwhC+2RCpY?=
 =?us-ascii?Q?wTMn1otkT6X6XYpuoZatCppOWezsX6vwOh3M92xGv3c9UeD1uVTPQRVDsNq9?=
 =?us-ascii?Q?DmN+SPuBM2LkrqiZcZUOKDFqHEUF+tSk/izL/CVronwf5k7CP7QPFD7C+mc5?=
 =?us-ascii?Q?b40y7h6q0Ibzu90U2HkXG3GvfAdMPoyI8krtV9YQc2iPlqQYu0G39NZ0hSgQ?=
 =?us-ascii?Q?pfVcc0IopuDIFIhF8ap/b7VZrLzkfmbzm6bo0bJd9NLtGgFCTtiAoUOMgi+1?=
 =?us-ascii?Q?xtfjH96P2KJukPXNpSS4+uKw+zowQykUpvEpi/kNp0YibXql5ZmNA7HwWxAb?=
 =?us-ascii?Q?mXgshD8ECbj36UFK0OxurJXPP8RhzsmJgfEWHOFaw6Al4i9V4yP6sM6I+kad?=
 =?us-ascii?Q?KNEJHkdL76s+uid0ZqXeWVaf+AF24ArlL3gKYQ7EUGPxaLLexCdDS2wmUhVF?=
 =?us-ascii?Q?FbQlt6IbSKqcWM3R5BscqXNKqVHOshHac1NhOq+9Nx5aZ9PDeBQxZqE55WpJ?=
 =?us-ascii?Q?yxDj6m4bXNyTUsD/ShN6GmZWwr4yDRPVtfSBEZvIoUC4fa6Y70YAszUbvo7b?=
 =?us-ascii?Q?IsJeEHnG0HLgdv65FTcCvyyBn2EA8PzdwkzmRCqCviSQUyw2eVMUpjsVl0TY?=
 =?us-ascii?Q?EhVT0HBmn4k68DC1OZBGE5/c?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qjuLEUMcPslHEQarv3Zjc3gfTUjlgKiTgA4tmEz944TXlcsNR1XtV+WJ49hI?=
 =?us-ascii?Q?8dJXCJSalmZHob7KHJK5dUPO30HzY3ThzTt5fwDkFUuJB9fdv/HcQ1Rq8o8e?=
 =?us-ascii?Q?wZiVSXLg9Lnzc2cN2ZHOi2IDtzj1eXz5zaBnVMugJxJH15MXP/fQzndVKVhR?=
 =?us-ascii?Q?AvTH0SO01SvST4DLn5ZhHwVvp8I9uAHIWbuoKOuqv2j3vveOd2ZXGRCVJPPy?=
 =?us-ascii?Q?C15Nq35MC/PW8m4qRjFL4idv7TzkKCFKSH5+8hYnTj2QO1ssXVfriebaQ9V4?=
 =?us-ascii?Q?E6G+sfuoLiyyrAIuLxbO89Ba3kNV6ZuK7txMVLOag+bDaemNEmu4mcm154U/?=
 =?us-ascii?Q?szpeDGui6F2A0o+neGL1aWd8Un5smhi1NiDOq8tLno9jshTikClC0A98AFyl?=
 =?us-ascii?Q?Zp+/az1DC9B389kaSkwww+gcKHRg4BkfkHMMozIUTlCsgfTjU5avBMsiiQrU?=
 =?us-ascii?Q?tqaqRi4bZxDLwReLZ5xhfukJeZnahi+ml50R99VN5QrAvmQTEv/rIiLa7eFw?=
 =?us-ascii?Q?vlHeuNBd9QQpOpe9OREMGSmKwkOUgowfKMhjbX04i1jxgaMe7n2ljQFrKCSL?=
 =?us-ascii?Q?MXVEnbIRkDDZ7adpTiuqazcvXbCBIiNLOX4w1sch1/V/6QqcOktONi2ujeZC?=
 =?us-ascii?Q?yOdqXd2Hgn9owy0sCFtS2mZD5tiEWnGPSrODA0iSa7Hw/SOf+wiNs+nXnV52?=
 =?us-ascii?Q?0ePDWTWZ8I7AG8JDwt0K3GfQyRJ4NXdEN+xHxAWOYZX9Qnz2x5SKX9lwh1cO?=
 =?us-ascii?Q?eAYC70kPOtW6F1M6RX5VJJlGcmuXKW0XF0Am7j5MALsXQMzI+fDm9Nh9Two7?=
 =?us-ascii?Q?36CS/AL/3LTtoo92lAAcJYQ7wdXFaHtFR14Ce+i/NWik0KnajeqPIOkXr4a/?=
 =?us-ascii?Q?sH8N/CCrmArxGZR2P3faEpfWlnTWvKvSZupr8fkczFJTKRuM2NitiAugBRR6?=
 =?us-ascii?Q?iUQzLe5b1zb7yf1xqvrNSBviXF7SKmnMFOGeP/EmNbIn+Dujuw+/1U7F+aw6?=
 =?us-ascii?Q?Z38NeN70ddUhxukdM/5am38REl/6emb15DT47+TBWiPtaMUpDuuEWekSZs3Z?=
 =?us-ascii?Q?M7VjHLsTjCn1sRAuxlx+PVQpzgkCxUFnrha2tVrYSR33WuHPyF/HuB4AZBAC?=
 =?us-ascii?Q?nmE+GVCDbCXfRgTI4RpPJKyTKRNbIdE4T+P4HqnkC7EqXorrb6gpxv0bevDc?=
 =?us-ascii?Q?qb0oz62AR6wqOEKaLklWHI6Cb6viwW415jAg4uGUO2bf7m2Z1ZtslUQQo7fs?=
 =?us-ascii?Q?epYEYoS8blfzYnfc7LCTITO3gDbLk3DdH1p3y7mqQ27tKyz3oUobiZkhLK0q?=
 =?us-ascii?Q?OebA5qFSWUt18nBV9EOw5eVh1VHW2sSLOPN0RPyhGZjidCZs/QblvKnsX6D4?=
 =?us-ascii?Q?EmkLMXjfj2vt93HyMf0zVZewLTshUw7WecXV7b+kspmTQVWDV4+64QXytHsc?=
 =?us-ascii?Q?3M1YIyZnlpOEqpy3q4BIhdKmHBSgl28vRHjjUjWBjcj4TQCba0+wK7aY90QY?=
 =?us-ascii?Q?uA+Fq5CTSQ7/kJO+T6CRzXLqMa1eIsU3yffmE3rmeiYpTkv3ALfiNMwdjnt3?=
 =?us-ascii?Q?1NsABiEW1BOaIXrYHzvEKxDNaiwy7Ichz0J16rDT8f8vzyIsxOpMvWGrYi9A?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0wqWriIPShf7hKyBcdwlSTFp1VAh5cbsNrkQ5jkVRY52poOldYp3K2SMqCD0OgrwU8GJTEDiw2dTVa93xsTr8Etae6GcIqHvN3XsUz/auKgUwMyIEAv/miAoXalpnTmz6omvDkAPDBoKb1fu60Ql2Qh6TQlGc53ztJMGFzkiLKnAFRr/oHmTQPdJ4Q8zNKzyiW95j1P5NHD7xXXmQTqViw7RW2x9zbehKKZaMEQgw0BvAaXSbW2rdFrTD/zbb5lcejkjap04q+U31gHg5FS908CLydo0cXMVbYvHV0KYGz8nVse2Ll3664FfkC0cOfgODUqRDe1OhNZr7mMZMefWaxhjlWKRmxlTOsybgicEOe5UJ7qu0R/IO5zXGQdZKh6as/2JB3D+7St8e8pIuM91Li1je+N6joOckAAI/jL99K3LBp6naWxeXattCNIYFAKFK3FdY5vDP/ZW47IEmnPc18Rz3xciF597EHB/Xa88ZecR2XQQ9T3NFBYw8lL0+slDSZsr1v0ZOiLNr2PM13jtCWoWKR7sJfpQb5YsCyRqD2qW3axGGCrcF2XFCQj8QAg3+UQ0hzBOx8iamK5n2++6k8PsqYP+6eR9Mo3CUgZc0E4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd094d5-9ef2-4374-828b-08dc913f30ad
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 15:39:36.6642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lAYP6z9Qf6pVpjqRJICV77b4WrBpQVbJ8OXcnAscpT1cCk+1SQANAvpcMKuwWISw1jkxfIGixDrjVlN+AeRZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=628 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406200112
X-Proofpoint-GUID: rG2aKQQNOKzmrxFBEAEc4eY6vkzT-tg4
X-Proofpoint-ORIG-GUID: rG2aKQQNOKzmrxFBEAEc4eY6vkzT-tg4

On Thu, Jun 20, 2024 at 07:06:14AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 19, 2024 at 01:39:33PM -0400, cel@kernel.org wrote:
> > -	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0)
> > +	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0) {
> 
> It might be worth to invert this and keep the unavailable handling in
> the branch as that's the exceptional case.   That code is also woefully
> under-documented and could have really used a comment.
> 
> > +		struct pnfs_block_dev *d =
> > +			container_of(node, struct pnfs_block_dev, node);
> > +		if (d->pr_reg)
> > +			if (d->pr_reg(d) < 0)
> > +				goto out_put;
> 
> Empty line after variable declarations.  Also is there anything that
> synchronizes the lookups here so that we don't do multiple registrations
> in parallel?

Is there something (more than d->pr_registered) that prevents that
today?


> > +
> > +	if (d->pr_registered)
> > +		return 0;
> > +
> > +	error = ops->pr_register(bdev, 0, d->pr_key, true);
> > +	if (error) {
> > +		trace_bl_pr_key_reg_err(bdev->bd_disk->disk_name, d->pr_key, error);
> > +		return -error;
> 
> ->pr_register returns either negative errnos or positive PR_STS_* values,
> simply inverting the error here isn't doing the right thing.

I don't see pr_register() returning a negative errno, but I will
remove the "-" and document the expected return values.


-- 
Chuck Lever

