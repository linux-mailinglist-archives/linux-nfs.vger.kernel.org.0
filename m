Return-Path: <linux-nfs+bounces-5138-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F7993F70E
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 15:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC00281EA5
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 13:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F5914A0B7;
	Mon, 29 Jul 2024 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oB3GaN/M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mnzb4BLV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222A146D54
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261195; cv=fail; b=dRou7tLrE5u5hz0rtz9L37rqgBwQHKkXPnyhYZ5yYik2BVEQc19atfWb+g4YPQM75L3Hcu+qWRTBvZurPwWfjy7qMcpQO4vodbpROtaLjgmzXBmIEZieG5i2VpMNZ0NDh7kdySSyQBdhDrbMj56SpPU2JRKUvWFNL2Ywm8tCkqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261195; c=relaxed/simple;
	bh=vmnNNacHP3Un3DstNt9b0e9aSXuENAx6u5vmv2Aa0Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lCTWHg8jJNfRdAE9OvvuJtyCFTtPrnK7a7eVfz4ZGSvmCo7W0lEfdkBMOFoyg9fcvBtXdyJnS+6gPLaJLsi5VawdBU0lgK4CoKZuMeRqzgJcBwKLSgCN0T5FoClgDQ4nJ5N+qV/47LzxjVPFdz85hz/bYoPQa5lGZ+ekxjkoPnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oB3GaN/M; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mnzb4BLV reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MV4o029137;
	Mon, 29 Jul 2024 13:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=qkXRAPTvxkI2D/5WRlaTL8lFXhyU5BpIJJu2c9UsVr0=; b=
	oB3GaN/M7MqWuZ2PMjAjb0xjE4JN5hbRv+UcqiGjuxgDyahCnxYIVC3AHLkw3+VG
	ryFWUL+NlYDal0SfweAnmXusV/3x3VHuDF/uDi494TU0j9yutO6B1YMXe7Es7zyX
	EvpVW8FFzV2lSjCwXcEqbr7xB5CxzLcdeuI9SJuCxKyInACXyLyapdjYb7AFmxpf
	KESVm0pu5V3W2Ipwgih/UM+YtTE6ep99BiSrs5UuoNZGSkynkTTlwC7bvsdBR1kY
	142J5nAe9/024JxrN8ra489cX/7iI3qRYKb6jDDpJ3bP6BqSHw3q7Hnn98N79D+x
	4DCzW6sryi07UMqTGiVMVg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrxbtmdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 13:53:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TCNphv009346;
	Mon, 29 Jul 2024 13:53:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nrn5unwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 13:53:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqrErYtjDeJuXhl5twXmz+iWFqTeyE8uujrT4K/zy4eAYJgLwzLEBQDmngke3CkLQD++EX/i2wwPuERtugnY27/d3eHE9ZSvQvxsec/43WI9T6ITlRsr+6mBmtEDXk9cV96Iex590zdShT68cyASQs1ddsxsiqutegu6ZX5JD0X/WUR77TWxuMBh4hYBmmM1MBdWUO9M35Ir2sCyLNS9KCGt7Phc/ZdxP9HLtw2NzmJBMMk+XVhsXdRWof3+INnAQRwaUgCBYkONvDSBrd9c/AptutjOTsrml537n6M71/zkCOze7BZhPETPBtIyxxeIliYhOvmN2LqvNnHbyYQcwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poPyDLcK6AjvR2gg/UClWgmF71yIpKZVy01BSs9SLlY=;
 b=NcJ3zeYhI+NehNSQ02TEDmdKklJrr1AcwQQ8SlCu2AtluipGO6QXox+m3rEhdAKQW251EIzuMMArjFttPdtWge1qcw0QowhgvJnf/we9KkZz3ZmH4tMaWQMuDlJKU/sX9+thrCnYHDIM+LYE76hCmPLEZ3OmoMr30Irhkre7AZ8m1g10+i30sU89l7G2u5LilfNg0An32TryHETxta6pFNyOO6UzeNuqMFD57u3zg0NS8f5saaadz/2YSFQGlfIoxyKDRc5U9510dNVsD+UY2wny37CipKkJmK3zNavsR4dVZFzKEn25wlawDMvEisgMTG6v8AFM+LdacWMimKP1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poPyDLcK6AjvR2gg/UClWgmF71yIpKZVy01BSs9SLlY=;
 b=mnzb4BLVBGNwnDZTfGX1EXna3a49g4yaX4jy8r98ptaVNpEokel758+lUhyWHH075HexwNgC6/ndtZPdktD3eIOYzXnTd4ddUihZbeg825613DzGkEMtkfF2aLALBF2eGelFYWdiHiR6DodGBjdYp/Ou8jKJlwuuVgA8ODYVxfs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4437.namprd10.prod.outlook.com (2603:10b6:510:3a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 13:52:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 13:52:57 +0000
Date: Mon, 29 Jul 2024 09:52:53 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] nfsd: Offer write delegations for o_wronly opens
Message-ID: <ZqeetZx5MjiSnu5J@tissot.1015granger.net>
References: <20240728204104.519041-1-sagi@grimberg.me>
 <20240728204104.519041-3-sagi@grimberg.me>
 <81765320f56c349298be08457ef2211a581c29f9.camel@kernel.org>
 <6a78bd6b-b5c4-489c-a7dd-bd688fed8d94@grimberg.me>
 <cb6cf6834ca3383804b7bd994eeaf310cfbf8c78.camel@kernel.org>
 <0fc73dce-1ab1-4229-a81e-3c058e2bcee3@grimberg.me>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fc73dce-1ab1-4229-a81e-3c058e2bcee3@grimberg.me>
X-ClientProxiedBy: CH0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:610:e6::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 41bdb4ff-3c03-469b-0b18-08dcafd5c090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?NLJDerkQYh/9ufnMF5BXRRItNHe4azPtiFCvp2krCt//ZmUOA6AUH9fezv?=
 =?iso-8859-1?Q?yJX2dit3Z0Wb9YJfsGbbYUMhD6D5F/v9K6/gGO66cqL8fxSR+XbZEwgHq6?=
 =?iso-8859-1?Q?uD39iSDVTiQq9c5gAbGKfSjI5J0mPkJLa8TCSjm48JyrQYdgQCIb3tAa7G?=
 =?iso-8859-1?Q?9mJ0nRxDN2/oV+I0sv2jUxhTwgK1qxQBbNZ7dEc4gcvzTRWQa3fwbvzdpV?=
 =?iso-8859-1?Q?HyDMDz8yHrQM4KvFFYZZ1hP8ms2ldpOpj4eofQQ4t1Gb4Zj1PE3Lnq743z?=
 =?iso-8859-1?Q?I1AWo+YxuPUqRG6Npy1msiEQ9Ohc9eZz/5nQCk6LZw+oED/KYBpIxc2QBo?=
 =?iso-8859-1?Q?gdM/5nyk/hqqeLHEp67KBGy19sd1s9WqMj1BzgKfMOQVkwkGKT4lVPgL5C?=
 =?iso-8859-1?Q?4kxpPMwPnLnbAj75edJAwRUS4FVA5q6VuZMbRb3clWJk4qO5/EexA3vCwu?=
 =?iso-8859-1?Q?MmlBlAsE/Vnf6gcpXxpHO75+tsLEIEVFNMM8U1t+yieEIruYA9tCi8zPOl?=
 =?iso-8859-1?Q?S0iz0ci5plEyM78Ck2nR18nKh1mxb1IUBKGZDEQryxU1l04zxNGGsUSTl1?=
 =?iso-8859-1?Q?CYWPfUVjyYRYzlf2MYka8CyB/OHt8zVszEO3b03iKafmFos4icgGqqPcTK?=
 =?iso-8859-1?Q?YhYwxTi8y7F/8qUlgPV+8oAoScks4LoYdhocpWCIkgvXKjiNtEHAYbK1rL?=
 =?iso-8859-1?Q?pTzpzeqCSsLNACO1OeVUstUiosKb6Z7m5M8ylHBajrarLpyBw8h/pMqIY3?=
 =?iso-8859-1?Q?UdJg/G3OYjsHq4aKV/YfeZiFzYRPrj3K30MwmhLZPVKJKcJZ4ZjtAqZGKv?=
 =?iso-8859-1?Q?+NAo9UgdzVY+RePvg6NtICNtUZodNLmJ5R0xNzi5C1/TcI/e8y2MTCjQXn?=
 =?iso-8859-1?Q?58SR1X2oNVk1Qj4bvo6a95b3uwqxWHneJgEn5i0Ay8g6Ri0sozEX2b1Sf7?=
 =?iso-8859-1?Q?9qyFjinhudi2UUXs3GBshkl2aazLwu1aPv1MdtcDPJNmU67EoJ074D/fbs?=
 =?iso-8859-1?Q?LDib+z6w/Fm7Ift8kDsRgREV3PkjHlbtEWtILlye5G4hEu5A/QfU61Xam8?=
 =?iso-8859-1?Q?mouzApiUoc2Fidf+Ojt9g2wGSAEh73bQeNjNmsTErQlBD+a/SHdkCXaFcP?=
 =?iso-8859-1?Q?2qK1YK6o1r2iSC8NNYdgMzgXaV7Io1O8Hw25LjfjK3JDerXgQOOE9VzWsQ?=
 =?iso-8859-1?Q?GWVbOhlGD9r+OP+QHG8K4kKmZ0dXab5e6jvZxDBBtf4BJdPz4629aBGJvA?=
 =?iso-8859-1?Q?XaIPhI9o6FkOdCEKYkFgyVXwYVKl1gYVGUaZb/abf5ZBpH8x0LxnH8XmXS?=
 =?iso-8859-1?Q?BxDpwFAq7iHVV6LcVbasCeysKyV+k8h8ykdAvRDyRXwKMwlpqrG2Qs0jDY?=
 =?iso-8859-1?Q?d3IqrBaG08ir6SQiCZHmLo1CLlwOGhlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?hNqnbi+9bqt/cO/0eeS1xOTJBkRxNdLx04EI4zU080pGSnf8u5ZcVxzJtf?=
 =?iso-8859-1?Q?h0n03K1k4lt8/Lxh8w27TAjaaS5tb6uFSMqwZGxJoAjce5DlVzXijVpKT0?=
 =?iso-8859-1?Q?47/CJcxsZL02tpNtmXDu19AyZzu3PlzK7f7RpH8jhcAhKahZBczHkr65Pz?=
 =?iso-8859-1?Q?jFPQdIIaY/Oz4uNil8KBVlG7njmn/3BEb1tLUA+sNyWyjYo9e+XrDSCv9b?=
 =?iso-8859-1?Q?EQvsSgcS8TwHi0Q9MIFtWFCpWoFXsTFxybJpNWf1s/oQmJVHaxBOCdqX/c?=
 =?iso-8859-1?Q?gHi4t2GkDFfJcuzt79Nuoak1E/e1jIzCIYqf53xLXrmNLa1libEGXrrTyU?=
 =?iso-8859-1?Q?R1DWNNjx+FWfGcxkdhXy2qURGK7Qs70HW6it1MZEyBpSkCPB9hPG1yzDEq?=
 =?iso-8859-1?Q?Xb23ZyQq/F8CSBgn/7h8INVfw1Tc/YbxKWZ+Jgn1w6RG04ZbLDPdVWl6ar?=
 =?iso-8859-1?Q?x/s2MOk6+Ib4pKuhfc8LoQvErbqrm434ZjATyULEKPQeMFNEH5mv1nxKAv?=
 =?iso-8859-1?Q?vU7hL9/JKKNm3NJPIWNNZAdRJT8jnZn/FnofCui0HweKsFIGey48ehayFP?=
 =?iso-8859-1?Q?4yM+oYY3AeUpakmrrUAxRWpQU9qKFYVUVMcD/TktV/XTslFFdHcnFkd+Sk?=
 =?iso-8859-1?Q?L3muvI0KKTNDA6uo+u6WJ59lXfUMmcR/A+bLPjyIxknVbJwQL9dnqfwEBV?=
 =?iso-8859-1?Q?VTySWSWkgJueqDMHRqy+FLVp0VOmJneBE9y/2aicMekbHIQ+e0gCkyeYVU?=
 =?iso-8859-1?Q?TjiuVUIkrSHIkFKJxdQtaawsyx2UVt0WZaCQVWa2gLJ2gb/htIHDAzyGJK?=
 =?iso-8859-1?Q?7XCnQOGur3/V1nbtbdjyMa6TEjhHKFNgiHWFVmKXG3yxanua4LnkvdUl9j?=
 =?iso-8859-1?Q?cxiS5z9C1J7Ha0NonslxyZXLutf+pBELsuv5lWwktErgJJ8AVx6j4JEnkU?=
 =?iso-8859-1?Q?6jWK+Ryf5LzcJGdDbGhGgsvfm7GqfEDKHNvaBPlCXZl1khNWpstWAxo59B?=
 =?iso-8859-1?Q?uq84x3HYZDVq+4zf4lAKd4esQ0/4RypKiKSqpMIq6/E4cOiNQYgTFPaLUs?=
 =?iso-8859-1?Q?DW01q4eWCy0w9/Cz5NFU8eJgi3kndKw0vskyG2zDOng9E4yLrSi/iRLfv1?=
 =?iso-8859-1?Q?rVzx/ZvW1nsVtawFLChwM66cpjI7NGOGd/1LpvOZUqW1sOs0ZaojKj333m?=
 =?iso-8859-1?Q?4GjxqSbAszHkD7zdaeb0qbh19lQOAGDbGaf3e2HJvm18yFLS/s5/iV6B49?=
 =?iso-8859-1?Q?cUmzfcmu/EyXcDrFltwJhR4u+JDCq95ApezwZy41Qs+myG3xCG/AQuML/g?=
 =?iso-8859-1?Q?Yjy8Dh/oSG9IE5X/Dup2mUvnCEBsUWrqqOPtU5EeU8AxODqcrWosaeM8iW?=
 =?iso-8859-1?Q?859DFysPqlXu+y2X0okDltMzW4k2qQ0whK59kvqKBdLrPUbbqOoQu0kX7p?=
 =?iso-8859-1?Q?Yh9CsqwFYnhhWpQN2c1s0kRFr29SE5rHjmW71u9UwYwUcjVd97G/K8m8w2?=
 =?iso-8859-1?Q?/BYbIcxo1Ufu6BuF5f09r7i9z1Mn8+ylbkPSEfhkDXkzeQX31OHR1mKyq6?=
 =?iso-8859-1?Q?q7IB84BYYQQa3eoHOyLaN/J1QySafi4nRQI6uM+y30dVoP7MBDYhUytF60?=
 =?iso-8859-1?Q?wD09u2+W3x/L0aIRfQ+O2FUCeUL6wA10Fm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wiPG1O1GHzEhwm+BnPqx9+E2cb61unBmrdvAAmeaM/E+D6PoyWc/ceCPShWOXioEvOXBNIBPGLnFXaYDgx+E9LKK6PRsfukg4Ywfth86pjmWCcbNSG8E9KqIrfzrVc22nJNSZ7zjE1tyYJsXp9G6y/ge7JTtTI+Aj4rAzrzmHipgMSr3HXT2zcKIFelcOwOzBN8pUxQvgdJ4fGIIykJdILLqmKYlA0LKBOxdKM8hIT4lOHvCrgUieVRg1B4R4YKxYEArRVEqdDpfV7o9gzBdtxm7AG+g5oWdTehA0kHAN6gO1BPwSIIMaeVpz9v8iIF8flzS0s5l/xUmrYnUqUHXpYVYc08T4AHHTQDUounRvmr8n1zq9eY+qx2e43045Dn79YRPvbW5IX5XFXvpZEX61Pa5xYlQUATusCBlEFwaeEp1mVnK1a00ipPFwT3UB5Dw6E+rbzdcVgvBzqXdrTibBs3ckMIGrJqF+7FaqRPnyiUBzz+ViRXmQ0zjk9RCf4JpW9QqsFChrNizqXzxv+DsaVtPtrEy7qoBBtVMJdpOS1hzfFwTb3DidD6PCh8UGgdq0HPfAD1P/jTNnS7MwRsMMJ2hjq0gYcrv4sG7KhV9NpE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bdb4ff-3c03-469b-0b18-08dcafd5c090
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 13:52:57.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRTxYZZHMqeK7jvAXZPB12Xh74/xCRDqsi4foz9/QDiI5U8hVMAw3CgL91XXdAwrKDbCACPnTO/4L+z6ws/f7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407290093
X-Proofpoint-GUID: 3q7FZIinOEibRsa8bcx-GYWIq9CKN9xD
X-Proofpoint-ORIG-GUID: 3q7FZIinOEibRsa8bcx-GYWIq9CKN9xD

On Mon, Jul 29, 2024 at 04:39:07PM +0300, Sagi Grimberg wrote:
> 
> 
> 
> On 29/07/2024 16:10, Jeff Layton wrote:
> > On Mon, 2024-07-29 at 15:58 +0300, Sagi Grimberg wrote:
> > > 
> > > 
> > > On 29/07/2024 15:10, Jeff Layton wrote:
> > > > On Sun, 2024-07-28 at 23:41 +0300, Sagi Grimberg wrote:
> > > > > In order to support write delegations with O_WRONLY opens, we
> > > > > need to
> > > > > allow the clients to read using the write delegation stateid (Per
> > > > > RFC
> > > > > 8881 section 9.1.2. Use of the Stateid and Locking).
> > > > > 
> > > > > Hence, we check for NFS4_SHARE_ACCESS_WRITE set in open request,
> > > > > and
> > > > > in case the share access flag does not set NFS4_SHARE_ACCESS_READ
> > > > > as
> > > > > well, we'll open the file locally with O_RDWR in order to allow
> > > > > the
> > > > > client to use the write delegation stateid when issuing a read in
> > > > > case
> > > > > it may choose to.
> > > > > 
> > > > > Plus, find_rw_file singular call-site is now removed, remove it
> > > > > altogether.
> > > > > 
> > > > > Note: reads using special stateids that conflict with pending
> > > > > write
> > > > > delegations are undetected, and will be covered in a follow on
> > > > > patch.
> > > > > 
> > > > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > > > ---
> > > > >    fs/nfsd/nfs4proc.c  | 18 +++++++++++++++++-
> > > > >    fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++------------------
> > > > > ----
> > > > >    fs/nfsd/xdr4.h      |  2 ++
> > > > >    3 files changed, 39 insertions(+), 23 deletions(-)
> > > > > 
> > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > index 7b70309ad8fb..041bcc3ab5d7 100644
> > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > @@ -979,8 +979,22 @@ nfsd4_read(struct svc_rqst *rqstp, struct
> > > > > nfsd4_compound_state *cstate,
> > > > >    	/* check stateid */
> > > > >    	status = nfs4_preprocess_stateid_op(rqstp, cstate,
> > > > > &cstate-
> > > > > > current_fh,
> > > > >    					&read->rd_stateid,
> > > > > RD_STATE,
> > > > > -					&read->rd_nf, NULL);
> > > > > +					&read->rd_nf, &read-
> > > > > > rd_wd_stid);
> > > > > +	/*
> > > > > +	 * rd_wd_stid is needed for nfsd4_encode_read to allow
> > > > > write
> > > > > +	 * delegation stateid used for read. Its refcount is
> > > > > decremented
> > > > > +	 * by nfsd4_read_release when read is done.
> > > > > +	 */
> > > > > +	if (!status) {
> > > > > +		if (read->rd_wd_stid &&
> > > > > +		    (read->rd_wd_stid->sc_type != SC_TYPE_DELEG
> > > > > ||
> > > > > +		     delegstateid(read->rd_wd_stid)->dl_type !=
> > > > > +					NFS4_OPEN_DELEGATE_WRITE
> > > > > )) {
> > > > > +			nfs4_put_stid(read->rd_wd_stid);
> > > > > +			read->rd_wd_stid = NULL;
> > > > > +		}
> > > > > +	}
> > > > >    	read->rd_rqstp = rqstp;
> > > > >    	read->rd_fhp = &cstate->current_fh;
> > > > >    	return status;
> > > > > @@ -990,6 +1004,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct
> > > > > nfsd4_compound_state *cstate,
> > > > >    static void
> > > > >    nfsd4_read_release(union nfsd4_op_u *u)
> > > > >    {
> > > > > +	if (u->read.rd_wd_stid)
> > > > > +		nfs4_put_stid(u->read.rd_wd_stid);
> > > > >    	if (u->read.rd_nf)
> > > > >    		nfsd_file_put(u->read.rd_nf);
> > > > >    	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > index 0645fccbf122..538b6e1127a2 100644
> > > > > --- a/fs/nfsd/nfs4state.c
> > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > @@ -639,18 +639,6 @@ find_readable_file(struct nfs4_file *f)
> > > > >    	return ret;
> > > > >    }
> > > > > -static struct nfsd_file *
> > > > > -find_rw_file(struct nfs4_file *f)
> > > > > -{
> > > > > -	struct nfsd_file *ret;
> > > > > -
> > > > > -	spin_lock(&f->fi_lock);
> > > > > -	ret = nfsd_file_get(f->fi_fds[O_RDWR]);
> > > > > -	spin_unlock(&f->fi_lock);
> > > > > -
> > > > > -	return ret;
> > > > > -}
> > > > > -
> > > > >    struct nfsd_file *
> > > > >    find_any_file(struct nfs4_file *f)
> > > > >    {
> > > > > @@ -5784,15 +5772,11 @@ nfs4_set_delegation(struct nfsd4_open
> > > > > *open,
> > > > > struct nfs4_ol_stateid *stp,
> > > > >    	 *  "An OPEN_DELEGATE_WRITE delegation allows the client
> > > > > to
> > > > > handle,
> > > > >    	 *   on its own, all opens."
> > > > >    	 *
> > > > > -	 * Furthermore the client can use a write delegation for
> > > > > most READ
> > > > > -	 * operations as well, so we require a O_RDWR file here.
> > > > > -	 *
> > > > > -	 * Offer a write delegation in the case of a BOTH open,
> > > > > and
> > > > > ensure
> > > > > -	 * we get the O_RDWR descriptor.
> > > > > +	 * Offer a write delegation for WRITE or BOTH access
> > > > >    	 */
> > > > > -	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
> > > > > NFS4_SHARE_ACCESS_BOTH) {
> > > > > -		nf = find_rw_file(fp);
> > > > > +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> > > > >    		dl_type = NFS4_OPEN_DELEGATE_WRITE;
> > > > > +		nf = find_writeable_file(fp);
> > > > >    	}
> > > > >    	/*
> > > > > @@ -5934,8 +5918,8 @@ static void
> > > > > nfsd4_open_deleg_none_ext(struct
> > > > > nfsd4_open *open, int status)
> > > > >     * open or lock state.
> > > > >     */
> > > > >    static void
> > > > > -nfs4_open_delegation(struct nfsd4_open *open, struct
> > > > > nfs4_ol_stateid
> > > > > *stp,
> > > > > -		     struct svc_fh *currentfh)
> > > > > +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open
> > > > > *open,
> > > > > +		struct nfs4_ol_stateid *stp, struct svc_fh
> > > > > *currentfh)
> > > > >    {
> > > > >    	struct nfs4_delegation *dp;
> > > > >    	struct nfs4_openowner *oo = openowner(stp-
> > > > > > st_stateowner);
> > > > > @@ -5994,6 +5978,20 @@ nfs4_open_delegation(struct nfsd4_open
> > > > > *open,
> > > > > struct nfs4_ol_stateid *stp,
> > > > >    		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
> > > > >    		dp->dl_cb_fattr.ncf_initial_cinfo =
> > > > >    			nfsd4_change_attribute(&stat,
> > > > > d_inode(currentfh->fh_dentry));
> > > > > +		if ((open->op_share_access &
> > > > > NFS4_SHARE_ACCESS_BOTH)
> > > > > != NFS4_SHARE_ACCESS_BOTH) {
> > > > > +			struct nfsd_file *nf = NULL;
> > > > > +
> > > > > +			/* make sure the file is opened locally
> > > > > for
> > > > > O_RDWR */
> > > > > +			status = nfsd_file_acquire_opened(rqstp,
> > > > > currentfh,
> > > > > +				nfs4_access_to_access(NFS4_SHARE
> > > > > _ACC
> > > > > ESS_BOTH),
> > > > > +				open->op_filp, &nf);
> > > > > +			if (status) {
> > > > > +				nfs4_put_stid(&dp->dl_stid);
> > > > > +				destroy_delegation(dp);
> > > > > +				goto out_no_deleg;
> > > > > +			}
> > > > > +			stp->st_stid.sc_file->fi_fds[O_RDWR] =
> > > > > nf;
> > > > I have a bit of a concern here. When we go to put access references
> > > > to
> > > > the fi_fds, that's done according to the st_access_bmap. Here
> > > > though,
> > > > you're adding an extra reference for the O_RDWR fd, but I don't see
> > > > where you're calling set_access for that on the delegation stateid?
> > > > Am
> > > > I missing where that happens? Not doing that may lead to fd leaks
> > > > if it
> > > > was missed.
> > > Ah, this is something that I did not fully understand...
> > > However it looks like st_access_bmap is not something that is
> > > accounted on the delegation stateid...
> > > 
> > > Can I simply set it on the open stateid (stp)?
> > That would likely fix the leak, but I'm not sure that's the best
> > approach. You have an NFS4_SHARE_ACCESS_WRITE-only stateid here, and
> > that would turn it a NFS4_SHARE_ACCESS_BOTH one, wouldn't it?
> > 
> > It wouldn't surprise me if that might break a testcase or two.
> 
> Well, if the server handed out a write delegation, isn't it effectively
> equivalent to
> NFS4_SHARE_ACCESS_BOTH open?

It has to be equivalent, since the write delegation gives the client
carte blanche to perform any open it wants to, locally. The server
does not know about those local client-side opens, and it has a
notification set up to fire if anyone else wants to open that file.

In nfs4_set_delegation(), we have this comment:

>       /*                                                                          
>        * Try for a write delegation first. RFC8881 section 10.4 says:             
>        *                                                                          
>        *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,         
>        *   on its own, all opens."                                                
>        *                                                                          
>        * Furthermore the client can use a write delegation for most READ          
>        * operations as well, so we require a O_RDWR file here.                    
>        *                                                                          
>        * Offer a write delegation in the case of a BOTH open, and ensure          
>        * we get the O_RDWR descriptor.                                            
>        */   

I think we did it this way only to circumvent the broken test cases.

A write delegation stateid uses a local O_RDWR OPEN, yes? If so, why
can't it be used for READ operations already? All that has to be
done is hand out the write delegation in the correct cases.

Instead of gating the delegation on the intent presented by the OPEN
operation, gate it on whether the user who is opening the file has
both read and write access to the file.


-- 
Chuck Lever

