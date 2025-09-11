Return-Path: <linux-nfs+bounces-14305-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2095B53B01
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 20:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066161CC0092
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 18:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FF024290D;
	Thu, 11 Sep 2025 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A8HHD5GQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wV2bW2/9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0796B35A2AD;
	Thu, 11 Sep 2025 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613959; cv=fail; b=I/3N3TbQ6ktmizirogBlTIvEdOdyFZnJcUgfa+WXpXpbtt+uYQxUf+cnmbvMMMEP0oiDMSG1aDXjjuCf4cy4i9F4/AjwPo3AKJ/lf8yWrkveBFMNOPDLmvrAaF+33l7zLI73b/GJFsgzbk2qX/PP8WaCbzK2q+N3Zc6Xh/UsLrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613959; c=relaxed/simple;
	bh=nTxDygqsiNDB0uWk7am+GBwFkUQ0lVX4p5bnGk6n9IM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uNsEMcSxeTldksjKeqeapncTAzh1sACKHkfwNGXf5XA9/qRk30QcBrcsgBmzDyYJwTCTMkj/Q3ZpQB94iJ/Yp9YfBi93qNZB1648Jwc+/3ICj9pqQExLXZi30T+lHGyS0bePUW90BYz42LglsTVrGGif6UK0NOkBMKZ/62DXvlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A8HHD5GQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wV2bW2/9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BHBf5J025907;
	Thu, 11 Sep 2025 18:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HIG3XhgYBP3QcNUCgGYbdmSzxtmNFGEP1SX69pa9Wzg=; b=
	A8HHD5GQ33SzWC4jBJTJY/R7FW1o2xJgLbzQvgdGMg7RVkkxXQ3lUZ6u3KaZOWp+
	A7rol291ZH2aGJ/k+pQsItJXAsuJGkOGcQQz4TtP41aVNarGmAtj2HuFT558+nsX
	DFgYBF3EpI3eqQPTA9abFd4EKzDok4KbUj1o3l/z1WcRYU3yaFmeRE7nZiMhMW3+
	vTzD3sYLHYJsDDfycVloNTSOC8RXJfQBsYBy+CreZMwgIZHBifnQbQVkC2smcedu
	cG3P3broiW5vqDYw219LeAF0QmuqZ9Mmv5wd8J4QtWKPUadi969zs734/dOzuoLB
	TfCAUw3tKxbXui7w1P4mlA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226sxu9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 18:05:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BHB1b4002945;
	Thu, 11 Sep 2025 18:05:46 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdkak5b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 18:05:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CI6MWXzmgxbSdIR2I1O85AHxWLcwuzOkgwoa0QFNGojT5vT1tiFuYUfTxrJxs5jQfDjIjhQs/bqV4lr8E7zMYNOwirXUl5ROgNf19Rwk/IAPXJiymmAIm58XL0U9AadsknoPEAeoHRZ/6bJqKriapy9bbDsT7TJ22HN9vMO8k/JAyhD1x2uxn+FHCGrj5xleY9VIBY1qvXnN3qvJOlMbnscMuJNaZigfEHfN59ePF4/3Bp97k/uce9e0vj/0jDkgNB/6qQtZa8M8snGh4LbNPR7AtE3iclkf1xifIpFDk4oJZ2VsJaV8Kx2g20TPgtQmtwQa30MZtXsdpbFUx3nI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIG3XhgYBP3QcNUCgGYbdmSzxtmNFGEP1SX69pa9Wzg=;
 b=UIvMuO0DWGrPLrcewRuxxEPJPEsjcahzTr/CcUntmBU7KkO1ihSX1jocR+5d4BDVhSE6wX2VhY2hF7fQSRLKtIyLsppasBd5cETcP/cLF/lAL16IhKw54XLdsXP/KxWNtKuoCGfadKkuhozvGmy0vAPrcdY6fftC3aBV37OBB+JEcAgl4o5i1mUs4ADy2JkHo7Gslj2PNfHpiNUhBWKQrJcgwVRsytdaNr3solav6Hc8ISiFUwAvBnnd8zC4TzClMC9rM+gd1A4hvPkR+X3V9Uumsqu7uCDftXLoIwjlfMlRb5lU4jNBUotGmdHO7XJYCTML1bKGyra6SXZ+ZZPCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIG3XhgYBP3QcNUCgGYbdmSzxtmNFGEP1SX69pa9Wzg=;
 b=wV2bW2/9g1G7De8hktlmSqL9M/sYMKA9cOxwbgSjXfe7qHFuU/9hPREc3BFuI8lqRXFcz5QGh1LU4yNkMn5coPDKD2w0wx/Xyj+3Mg/evQwVjqMQtTraehVKHIpkWdbpkY7GigIiTD4vy25LCjSC79KP/iX9VNn/Uz9mSFw1Ams=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4510.namprd10.prod.outlook.com (2603:10b6:a03:2d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 18:05:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 18:05:41 +0000
Message-ID: <73d6c14b-40f5-4546-9f87-a59595c51d77@oracle.com>
Date: Thu, 11 Sep 2025 14:05:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSD: Impl multiple extents in block/scsi layoutget
To: Dai Ngo <Dai.Ngo@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Talpey <tom@talpey.com>,
        Sergey Bashirov <sergeybashirov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>
References: <20250911160208.69086-1-sergeybashirov@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250911160208.69086-1-sergeybashirov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:610:20::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9c4059-eda5-4efe-0bb4-08ddf15dd1bd
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Y1V2aGVuTWFzclB4RzRtaHRJQkxrWWRaTnBVRWhzSndrMXNJMmtyM2dEekZk?=
 =?utf-8?B?dURSWUQ2RUEwREsvM3RZY1hKN1dzZy9pYzJ0enQzZ0ZqbFk4WWlnZndRTFpl?=
 =?utf-8?B?VHFZMnBwWXROWDVmdHdmeXJaditRY1ZycVZrdERQMWUxdXFxbUpha1AwWElE?=
 =?utf-8?B?R1kzQVBMbjg4Qm5PNURwSjhHazMyYWo5bFFKbFZKaHE5ZWxFeWh4UGtwMVFy?=
 =?utf-8?B?aEpRZFh2UTUzWkQzdGlYRHVMNnUvR2Y1K2ErUUVpckhybHMwdHUzY3FkYm9U?=
 =?utf-8?B?UlhvM0pxSzlrODRYTlJ1RVpldjRxVlNTV2xlaTQ1aXhWaWhXYjg0Vm8wQmNy?=
 =?utf-8?B?YkdDTWxwOC9zblB1eTc2TlJ6UVFEVHJEdFZvaVJrcWdidXJXcmsyd1VxcjhU?=
 =?utf-8?B?MDZnOExuVUF4eUMwR1h2c1QyWkxDanRaMjIxa1YxeE1FcXlBMVdzdWFKWWFY?=
 =?utf-8?B?bGRYYm9kOEZxWU5jN2ZFZ29lWTR1MzU2Z2F1RmVCd1FpS3V6REhyVkF2SWkr?=
 =?utf-8?B?YjNhY0QwSGV6UXdjYWsrdGJOM3cyRzVTUTFIZzJ2YzRHYjJwWXU3enpIbkF6?=
 =?utf-8?B?QnZvRWlpSVd6V25qMnBFSEgrY2QwNG0yZ1BVUWpjblFwaHVrTTk2MWhmY0pm?=
 =?utf-8?B?MlA3ZTY5T3N3K2FaUWdibXJuUXNpK3h2TDk0SGFkaXJXOUl6bUZoZnFGVnI3?=
 =?utf-8?B?RGpvVC9ZakRnRUJCVExpU2xDczFQTGR4cXJJakZHSkJjS2VyYXVja1crV2Rs?=
 =?utf-8?B?U1VFQTd0eHFvYnovWG5ha2svdHFsY0JYd25QajVvVlBoUUYvNytvZWpTWXFH?=
 =?utf-8?B?NUhRUTYwLzAyWjE2Rk04RGFxdVFEbDZ0N3RXWTZsWCs1cE85TkRvSFl4cm5u?=
 =?utf-8?B?eG8rL1RIVEZEOVhwSFdWRU9DczRkUUFsWkFTTEEvbzg0YjRTZW5aUUo0VGN4?=
 =?utf-8?B?TlluVk92L1g1UUhETEdFWEVIaXF3M1BtQ2ZFYnQxR0V0WDh3aGYxUzV3NmJF?=
 =?utf-8?B?V2Q0MkNzZzhkcEJwaWx1YVNvdE5SQjZObW1kNWcvRVlub0Yycko5U3pqMkNC?=
 =?utf-8?B?VnpUSlM5RzBQUDM2QnB1VElVakJiTStoejd2TWg5ZWtMVG9FT1VmNFlSYU81?=
 =?utf-8?B?YnFlbFhqNncwUS84V3UyNjUrejY1QVhjVmM0bVU5ZXZDL0J2Q0tZaEdxNjZT?=
 =?utf-8?B?RHZPNnFNTERURFQ4di9XU3lKTXp0bWNEU3hWNG5tU2pDSk5uUzViREJteVFi?=
 =?utf-8?B?NlJ1aW9kaVhibFJOdlNsWWUrMEFFSXV1UW9POXM5VVNqV2dnK0ROb1lBKzV5?=
 =?utf-8?B?VWE0am5zVTd1d0xSaXAvVTBiSm9NUHA3UGhYekcwbmM3VVhuVUtXUUNOMVhr?=
 =?utf-8?B?cEhtLys3RlVPRS9oQ3A3dEhmVjJoeU9Jc201eGRyeUZjZW43R0NqbjdYUWhV?=
 =?utf-8?B?dzR2ZERIakZFQzdSWnQwdURRNzh1UEs4YWtJSDFqajRmV0tOQkVsejd2YzUy?=
 =?utf-8?B?ejZYOFpxYStwTFZkSEFjaWdESXdPZUdPeTRqcGdINWZGbnBBanI1RWdvK240?=
 =?utf-8?B?WDA5L29mN0tDYjdCajhyRU9LKzAyRnFCdnNZR1VaYkc2OWc1d1ptUmpmdTVw?=
 =?utf-8?B?ZlI5ZnZ2akZJdDlpQTQ5S1JHazdDdThVREgvQzF6YllBL1o5dWtqNVdkeXNm?=
 =?utf-8?B?NXhua2NSb3RxcThPU3ZxRnN2TW9xV1k2cFZoK28yK0tvL0l0RzhabW1lcHdv?=
 =?utf-8?B?OHhHcE4zYy9rVEQyL0JSVkVVN3FIRURpK1I4U0tCckw2ZDVnV2ZNcHM2YWxn?=
 =?utf-8?B?UlhIaHVRbHBDMDU5QUMwM0wzMjR0aVhRYmhWQ00zV1RhVmNROCtQZHdRQXc5?=
 =?utf-8?B?aVBKM2l5bndkWUNubG9vZzVPRGRiSXhOMGJNYjBMR01ERnFEV2tDeUt2Nmx3?=
 =?utf-8?Q?CYpGQSGEz1Y=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aEo5VVpjWlVtNVc1M3dYazdYZWZaV2pmb0pUVFpKQ0ZNMitxeGtuVTNWMkdk?=
 =?utf-8?B?czZ5Q0tYcDEvYmNyUXBSNzJFWGtkRUc0Q3NRRy9tM1ByUHNCWk9ObkZKWkVQ?=
 =?utf-8?B?RS9UdlVpTGxRUUMwc1FmdGdZVFhVZjVPWDlsTytnRWR1ZVB2NkJiNVNIMUZn?=
 =?utf-8?B?eFdzaHQwUjBxN2l1QTdRYWRSa0hXY1Y0ejRFV0gxeWFieW14d2VUeVdaUDBX?=
 =?utf-8?B?ZkxwcythR0lSZk5yWEpwbUdacFJPQS9RckE2eE94SGVOU0JpeEZobWplWlhh?=
 =?utf-8?B?MlJXYTFrVjVkU3htTFpod3N4SmhVb2I2cElRa1M2bE8vQUZVOERpTmdtZHNw?=
 =?utf-8?B?U3JYNTQ0bXJpMVk5THltd0JEbk1XUHI0K0EyZzBPL3RJSnhENVJraXZyTzNl?=
 =?utf-8?B?c0ova0EyMGk0Y0wrdWh5TkJzRkgvT2FKQXh1a1lVak9XMXNpcStQVHpKNDVY?=
 =?utf-8?B?ai9FL1FyN0ZIYmhqRENSSVZHNnNyQngrYnBORkV6OGh3U2ZoTW5nMmtJZFls?=
 =?utf-8?B?eHozRURULzAzYUVKdnhBdms3RVZ4bDhDdWlCeFFENFFJektNbk1YMk1CdVho?=
 =?utf-8?B?ZGtORmUrYjRvanJxd3puZURPSTVtZnlmS2k1SDBkSnNlYlByUWNVczNmQmtr?=
 =?utf-8?B?WHExQW1JWHhiMjNOSWpDQjN0dmQyVTdXSjNrbHlBejd0MFU0U244VU1pV1p1?=
 =?utf-8?B?Y0diTkUzbmdRUUpqa0JHK2FVeEZHVnhrZDRLeEFuRkNidUVvNFdSZGpNMW1S?=
 =?utf-8?B?WmNrUVVHSkUzQVMxK25LYy9MRGpZQjFtemRmOGdrMHdCREcvOHpCRWkva2NU?=
 =?utf-8?B?VmVFazBGMndqQjJjWWp5SWU2K3dySklFc3pueHczTEhhOFQrVjRpbVAzaGdX?=
 =?utf-8?B?VGlQcVBtSndRWnYvZUU5Z0tVS0dQdWJ3WlNuTmYvdXhKa0MwLzd4QzE5TEQ1?=
 =?utf-8?B?aTVvaFdXT2k3Y3dRbHZ4emt2cUpkWElTNkJBbVVDc0R4SWJQUTYwRGh5T2lv?=
 =?utf-8?B?a3BFaXdmVjkzWmFFSVZ2QWpuejFWclA5K092YUo0T3JOUVM2c0hFdE1pZWNY?=
 =?utf-8?B?OHhsRllCVGtXa3B1Y3QxR1AwS2Y0aXZBeU5Jd1pzT2NGV0JpdlNlYXI1UW81?=
 =?utf-8?B?biszZEw2S3ZwWGdRejl5a0pic1pHVGZFR2kvODdsalZ0K3gyTzZiQUxXRXU0?=
 =?utf-8?B?U21pQ0RDU2traXcxR2NDZ3E2SVowanhJUEpBV3JENm9qOTNwOVZxSEtBdVBE?=
 =?utf-8?B?VndiejdJaUxvR2N1b1N1UHJnbWpWT3ZieE14YnZWeDZvbzV4d1oxa2RGQ3hs?=
 =?utf-8?B?elNwaTFzZkxCSjI2L2RBcXd5VmJIMDZpTlczWkI0Vm1qc1orYXFEZHRxK3BH?=
 =?utf-8?B?RWVTSkpFME9sVFdvQlcvNmFqQXFleWxWaHdva0ViSVY1OTI3RFVmdThrdS9j?=
 =?utf-8?B?ZWxQNEtnbjVOVS9NTm9yUzJuOUVLL21VY0JJTzZrSmZpWUVNU1FwNmhzcWZt?=
 =?utf-8?B?WjJ1T0ltT2N6RWgweUNBZ3lhWmpxNDA4eElWS05YM2hmcjhtbEJ2Mm9wS1Ru?=
 =?utf-8?B?N3d5anRFV3J1L3RkcDZsS2Vmejc1NmwwUUlncG1HdWR3V0VtWVdUK3EzTnZK?=
 =?utf-8?B?M1Q2NG1wR25CaDJNZDV1K0dPcm5RNG5BTVFVYWJmenBUcUJKcUJKald1Z21t?=
 =?utf-8?B?QVZMRWUyYkl5UGJubld0MWhONTh6SnR0dUhsV29QaEtDWW1tUWVTSkc5c3da?=
 =?utf-8?B?Y1dzMlpZOEI5aHB3WTg5aWtCMXBLYjB2Q3dkeHZOamxySHlidXJ3NGxDam5s?=
 =?utf-8?B?NjBQOXhHNmZHK3FscXZmckxvN1g1SitqUXptMFN3WkZCMmRYd0EwcDZSd1JX?=
 =?utf-8?B?ekhMNUhyMEtUSkVXTjRxNGR2ZVdSMCtYRFhiSmJaMWkwdjhzNU12OW1ocTJM?=
 =?utf-8?B?SDB5aEtHN0xMalAxVkVjeExYSzdhVC9YdHgzWUUzLzVqSnMyRDlMV1k4L0dn?=
 =?utf-8?B?YUZrNVJabURhdFZzN2pDb0E1ZXJ2a1ZIendUbis0WFRBWmw5c2x1WHU0ZTRN?=
 =?utf-8?B?cVd5aVNkT0dqOSttMGhIa01ZL0FRN2ZSTXJjQjBoTG9UOXRhZ3NHbjdTcFlC?=
 =?utf-8?Q?Qb32//hAZz7VstGfk1incvpNQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FWVgz3uuyurnfOoAOtH8mrOKp5gMyvQwylw8KfWfcyF6Ts9/IJURIjwIi7TcAnEU6x2hbBKMCMzz0e9rkQynAcIPs8gadESvQnn78demwDutRH/jPkQLFpZFHH0i2xdg0ggTtWMRHQIbGaRiuJ/6t3EpUAbInBBsDLMU0x82uRB06CoLDFVMDuizb8OFYVI7FmismNIThqRZgpUsXkZDKd1hDk4juwEdPFGGyzxduskY33NnX7kWNNa2Q7M7MXxu76Mt/NICNmuDrifHYj7MvsojtA9DWtL0+v1tJAIaiyEWnV3pWyn7Xg7QAQ74W/dlx29nuKjKo/fcqlB5Lo7kIl4ePUNVBgzxB5/ndDu/y/VPerfR1hm6Bgsnk10hBPZSmZv9WLP7YpP48DkNVYO7dYbPJ0X77QKPM5LsfTK9akvA5nKrI35hJKy2NLTcfKKmGQBhmWTAxq9f1ajWUAK26GvaGZURiuT3gS5asDWD+U+gOa83fyoq1pzVLDVPlzVn08HTJKjzXnWrPLOLDlnQHRhjqgyRPMjsj7owyZQZYRJ3A0jDC6e3PMHoXSafhu3/K/8ds+GfZERRfeHA/yqqUFjZ+Izy7bqPzZt9jRBhM+E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9c4059-eda5-4efe-0bb4-08ddf15dd1bd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 18:05:41.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyeDPTiVPuilVGNZFuHAab0v33Ig8d6XakUiDV6wedoRfK+TKHnVeMfq/xp+ThR/zSMmlxNwtXQwnQY12tQxVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110162
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c30f7a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=A0VyqqTTL0eVeDRdB8YA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12084
X-Proofpoint-ORIG-GUID: sUUvPBMrrYAK17O2lZIXD9VXDkgCSAEi
X-Proofpoint-GUID: sUUvPBMrrYAK17O2lZIXD9VXDkgCSAEi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX6C2VDypEq7hX
 eWwxy0o9kGSjoMjFwdZR5kUY0zZlxzD5wzHiNC5yzkw5ssK5IBsEDq+GthkLTPwqYanXcO+Ew3W
 +RP264xolL2vjpT/m3Vvhs48MOGS3M4vgQrbw5hcLSSvHT3JQa96tCZKa4+aHeLM4qWxvUUaG4H
 pQBUtUFhBpTOZRqO8esS4BrRzbB0slTpUxtQYwb724wGMNkcR8Ptwb1dnGOP8GWF6wjQkrw1jHZ
 ieKox0Dd3xotdYyDMsGPp4b+p3GNlqam1gAMQvHwotsrjo0Jdn9KZiYtMKp3TTSfBJR03lcPKoo
 UeMg4ylcVdx69th1CaJI5Q1cxQES4JFOiT5+gwErnpuCmRIrA0IeVmaZUp5a8LmBjKke/1Mtk6Z
 N0ZH0SEkTomUd6kABEpbIedIn/hPpA==

On 9/11/25 12:02 PM, Sergey Bashirov wrote:
> This patch allows the pNFS server to respond with multiple extents
> in a layoutget request. As a result, the number of layoutget requests
> is significantly reduced for various file access patterns, including
> random and parallel writes, avoiding unnecessary load to the server.
> On the client side, this improves the performance of writing large
> files and allows requesting layouts with minimum length greater than
> PAGE_SIZE.
> 
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---
> Checked with smatch, tested on pNFS block volume setup.
> 
>  fs/nfsd/blocklayout.c    | 167 +++++++++++++++++++++++++++++----------
>  fs/nfsd/blocklayoutxdr.c |  36 ++++++---
>  fs/nfsd/blocklayoutxdr.h |   5 ++
>  3 files changed, 157 insertions(+), 51 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index fde5539cf6a6..d53f3ec8823a 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -17,48 +17,39 @@
>  #define NFSDDBG_FACILITY	NFSDDBG_PNFS
>  
>  
> +/**
> + * nfsd4_block_map_extent - get extent that covers the start of segment
> + * @inode: inode of the file requested by the client
> + * @fhp: handle of the file requested by the client
> + * @seg: layout subrange requested by the client
> + * @minlength: layout min length requested by the client
> + * @bex: output block extent structure
> + *
> + * Get an extent from the file system that starts at @seg->offset or below,
> + * but may be shorter than @seg->length.
> + *
> + * Return values:
> + *   %nfs_ok: Success, @bex is initialized and valid
> + *   %nfserr_layoutunavailable: Failed to get extent for requested @seg
> + *   OS errors converted to NFS errors
> + */
>  static __be32
> -nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
> -		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
> +nfsd4_block_map_extent(struct inode *inode, const struct svc_fh *fhp,
> +		const struct nfsd4_layout_seg *seg, u64 minlength,
> +		struct pnfs_block_extent *bex)
>  {
> -	struct nfsd4_layout_seg *seg = &args->lg_seg;
>  	struct super_block *sb = inode->i_sb;
> -	u32 block_size = i_blocksize(inode);
> -	struct pnfs_block_extent *bex;
>  	struct iomap iomap;
>  	u32 device_generation = 0;
>  	int error;
>  
> -	if (locks_in_grace(SVC_NET(rqstp)))
> -		return nfserr_grace;
> -
> -	if (seg->offset & (block_size - 1)) {
> -		dprintk("pnfsd: I/O misaligned\n");
> -		goto out_layoutunavailable;
> -	}
> -
> -	/*
> -	 * Some clients barf on non-zero block numbers for NONE or INVALID
> -	 * layouts, so make sure to zero the whole structure.
> -	 */
> -	error = -ENOMEM;
> -	bex = kzalloc(sizeof(*bex), GFP_KERNEL);
> -	if (!bex)
> -		goto out_error;
> -	args->lg_content = bex;
> -
>  	error = sb->s_export_op->map_blocks(inode, seg->offset, seg->length,
>  					    &iomap, seg->iomode != IOMODE_READ,
>  					    &device_generation);
>  	if (error) {
>  		if (error == -ENXIO)
> -			goto out_layoutunavailable;
> -		goto out_error;
> -	}
> -
> -	if (iomap.length < args->lg_minlength) {
> -		dprintk("pnfsd: extent smaller than minlength\n");
> -		goto out_layoutunavailable;
> +			return nfserr_layoutunavailable;
> +		return nfserrno(error);
>  	}
>  
>  	switch (iomap.type) {
> @@ -74,9 +65,9 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
>  			/*
>  			 * Crack monkey special case from section 2.3.1.
>  			 */
> -			if (args->lg_minlength == 0) {
> +			if (minlength == 0) {
>  				dprintk("pnfsd: no soup for you!\n");
> -				goto out_layoutunavailable;
> +				return nfserr_layoutunavailable;
>  			}
>  
>  			bex->es = PNFS_BLOCK_INVALID_DATA;
> @@ -93,27 +84,119 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
>  	case IOMAP_DELALLOC:
>  	default:
>  		WARN(1, "pnfsd: filesystem returned %d extent\n", iomap.type);
> -		goto out_layoutunavailable;
> +		return nfserr_layoutunavailable;
>  	}
>  
>  	error = nfsd4_set_deviceid(&bex->vol_id, fhp, device_generation);
>  	if (error)
> -		goto out_error;
> +		return nfserrno(error);
> +
>  	bex->foff = iomap.offset;
>  	bex->len = iomap.length;
> +	return nfs_ok;
> +}
>  
> -	seg->offset = iomap.offset;
> -	seg->length = iomap.length;
> +/**
> + * nfsd4_block_map_segment - get extent array for the requested layout
> + * @inode: inode of the file requested by the client
> + * @fhp: handle of the file requested by the client
> + * @seg: layout range requested by the client
> + * @minlength: layout min length requested by the client
> + * @bl: output array of block extents
> + *
> + * Get an array of consecutive block extents that span the requested
> + * layout range. The resulting range may be shorter than requested if
> + * all preallocated block extents are used.
> + *
> + * Return values:
> + *   %nfs_ok: Success, @bl initialized and valid
> + *   %nfserr_layoutunavailable: Failed to get extents for requested @seg
> + *   OS errors converted to NFS errors
> + */
> +static __be32
> +nfsd4_block_map_segment(struct inode *inode, const struct svc_fh *fhp,
> +		const struct nfsd4_layout_seg *seg, u64 minlength,
> +		struct pnfs_block_layout *bl)
> +{
> +	struct nfsd4_layout_seg subseg = *seg;
> +	u32 i;
> +	__be32 nfserr;
>  
> -	dprintk("GET: 0x%llx:0x%llx %d\n", bex->foff, bex->len, bex->es);
> -	return 0;
> +	for (i = 0; i < bl->nr_extents; i++) {
> +		struct pnfs_block_extent *extent = bl->extents + i;
> +		u64 extent_len;
> +
> +		nfserr = nfsd4_block_map_extent(inode, fhp, &subseg,
> +				minlength, extent);
> +		if (nfserr != nfs_ok)
> +			return nfserr;
> +
> +		extent_len = extent->len - (subseg.offset - extent->foff);
> +		if (extent_len >= subseg.length) {
> +			bl->nr_extents = i + 1;
> +			return nfs_ok;
> +		}
> +
> +		subseg.offset = extent->foff + extent->len;
> +		subseg.length -= extent_len;
> +	}
> +
> +	return nfs_ok;
> +}
> +
> +static __be32
> +nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
> +		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
> +{
> +	struct nfsd4_layout_seg *seg = &args->lg_seg;
> +	u64 seg_length;
> +	struct pnfs_block_extent *first_bex, *last_bex;
> +	struct pnfs_block_layout *bl;
> +	u32 nr_extents_max = PAGE_SIZE / sizeof(bl->extents[0]) - 1;
> +	u32 block_size = i_blocksize(inode);
> +	__be32 nfserr;
> +
> +	if (locks_in_grace(SVC_NET(rqstp)))
> +		return nfserr_grace;
> +
> +	nfserr = nfserr_layoutunavailable;
> +	if (seg->offset & (block_size - 1)) {
> +		dprintk("pnfsd: I/O misaligned\n");
> +		goto out_error;
> +	}
> +
> +	/*
> +	 * Some clients barf on non-zero block numbers for NONE or INVALID
> +	 * layouts, so make sure to zero the whole structure.
> +	 */
> +	nfserr = nfserrno(-ENOMEM);
> +	bl = kzalloc(struct_size(bl, extents, nr_extents_max), GFP_KERNEL);
> +	if (!bl)
> +		goto out_error;
> +	bl->nr_extents = nr_extents_max;
> +	args->lg_content = bl;
> +
> +	nfserr = nfsd4_block_map_segment(inode, fhp, seg,
> +			args->lg_minlength, bl);
> +	if (nfserr != nfs_ok)
> +		goto out_error;
> +	first_bex = bl->extents;
> +	last_bex = bl->extents + bl->nr_extents - 1;
> +
> +	nfserr = nfserr_layoutunavailable;
> +	seg_length = last_bex->foff + last_bex->len - seg->offset;
> +	if (seg_length < args->lg_minlength) {
> +		dprintk("pnfsd: extent smaller than minlength\n");
> +		goto out_error;
> +	}
> +
> +	seg->offset = first_bex->foff;
> +	seg->length = last_bex->foff - first_bex->foff + last_bex->len;
> +	return nfs_ok;
>  
>  out_error:
>  	seg->length = 0;
> -	return nfserrno(error);
> -out_layoutunavailable:
> -	seg->length = 0;
> -	return nfserr_layoutunavailable;
> +	return nfserr;
>  }
>  
>  static __be32
> diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
> index e50afe340737..68c112d47cee 100644
> --- a/fs/nfsd/blocklayoutxdr.c
> +++ b/fs/nfsd/blocklayoutxdr.c
> @@ -14,12 +14,25 @@
>  #define NFSDDBG_FACILITY	NFSDDBG_PNFS
>  
>  
> +/**
> + * nfsd4_block_encode_layoutget - encode block/scsi layout extent array
> + * @xdr: stream for data encoding
> + * @lgp: layoutget content, actually an array of extents to encode
> + *
> + * This function encodes the opaque loc_body field in the layoutget response.
> + * Since the pnfs_block_layout4 and pnfs_scsi_layout4 structures on the wire
> + * are the same, this function is used by both layout drivers.
> + *
> + * Return values:
> + *   %nfs_ok: Success, all extents encoded into @xdr
> + *   %nfserr_toosmall: Not enough space in @xdr to encode all the data
> + */
>  __be32
>  nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
>  		const struct nfsd4_layoutget *lgp)
>  {
> -	const struct pnfs_block_extent *b = lgp->lg_content;
> -	int len = sizeof(__be32) + 5 * sizeof(__be64) + sizeof(__be32);
> +	const struct pnfs_block_layout *bl = lgp->lg_content;
> +	u32 i, len = sizeof(__be32) + bl->nr_extents * PNFS_BLOCK_EXTENT_SIZE;
>  	__be32 *p;
>  
>  	p = xdr_reserve_space(xdr, sizeof(__be32) + len);
> @@ -27,14 +40,19 @@ nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
>  		return nfserr_toosmall;
>  
>  	*p++ = cpu_to_be32(len);
> -	*p++ = cpu_to_be32(1);		/* we always return a single extent */
> +	*p++ = cpu_to_be32(bl->nr_extents);
>  
> -	p = svcxdr_encode_deviceid4(p, &b->vol_id);
> -	p = xdr_encode_hyper(p, b->foff);
> -	p = xdr_encode_hyper(p, b->len);
> -	p = xdr_encode_hyper(p, b->soff);
> -	*p++ = cpu_to_be32(b->es);
> -	return 0;
> +	for (i = 0; i < bl->nr_extents; i++) {
> +		const struct pnfs_block_extent *bex = bl->extents + i;
> +
> +		p = svcxdr_encode_deviceid4(p, &bex->vol_id);
> +		p = xdr_encode_hyper(p, bex->foff);
> +		p = xdr_encode_hyper(p, bex->len);
> +		p = xdr_encode_hyper(p, bex->soff);
> +		*p++ = cpu_to_be32(bex->es);
> +	}
> +
> +	return nfs_ok;
>  }
>  
>  static int
> diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
> index 7d25ef689671..54fe7f517a94 100644
> --- a/fs/nfsd/blocklayoutxdr.h
> +++ b/fs/nfsd/blocklayoutxdr.h
> @@ -21,6 +21,11 @@ struct pnfs_block_range {
>  	u64				len;
>  };
>  
> +struct pnfs_block_layout {
> +	u32				nr_extents;
> +	struct pnfs_block_extent	extents[] __counted_by(nr_extents);
> +};
> +
>  /*
>   * Random upper cap for the uuid length to avoid unbounded allocation.
>   * Not actually limited by the protocol.

Dai, Christoph - please review and/or test.


-- 
Chuck Lever

