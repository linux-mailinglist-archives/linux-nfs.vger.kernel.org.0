Return-Path: <linux-nfs+bounces-7389-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30E69ACBD1
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 16:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF04282245
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 14:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B5C1AB6CB;
	Wed, 23 Oct 2024 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CUdvaQMZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="soFVIwXs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8891B4F15
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692058; cv=fail; b=iy67M9saXZKCSFRcitkcZAoz8RdOm5wYyeJKRi+yPAUnYiOmDKvhPHBqKzy+AvDB9fVPig5yeduX51i1LJvD0D9CL+Vh7vJuLvNPXSVnQ2MaCwC++X2+EWaRS4AujpnkdCxZNJQlcVyC9TvoLYhMKFXLt6jnERBgRJwr5Ha6ltg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692058; c=relaxed/simple;
	bh=AMiEpY7Ghk7O7xribFWXuxe5ZLpNLqoKubvwcqHJJ5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gz8sWN4kukhskaPI14YsrPQ2E2dCrdMHmegBad5kNh69VpcZxSfuH1DLGex/a7l9lAN1T5WZuwX2gdeZjZfIsENoj74qen4s6Y3jkkNdqGV0yg/I1sMuGAtmY1rWWay1yP3LyKFMNyahtib8zKROEYF+mOPZxURzVg/LtHD+wvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CUdvaQMZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=soFVIwXs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBQXJi032096;
	Wed, 23 Oct 2024 14:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=u2S1TKy1HUuwm0IkWe
	kL0ZTMgeFw7Na13+TTyA5gtRw=; b=CUdvaQMZRzJgqLhCzF0Xz2O/uee6vxoRpy
	FeZGcQ+E50/wARKbVq1Q77+ib28+pMZYgORFujmD5Yf978sMEjvl6jSVCEjwtmpe
	yODW2fa+NeGlZnyALON0X0wxIcmpQ5Dblf+qymd6TaHNak5kMLo8ewwvvMFHFlgU
	nl9jzzvPV4OmIOccaJtPSkvOswxGqQ5GFgDFAEo9wOGNo18kgpNcRE0a7jue/Z4U
	0tfcXznT5663scjIEjc5EAxAKYsdDxoWWMzYYTFI+sDqUhRxMhll5EA52XLLmZ5c
	CSkzK32Qi9jeY/Aw34DrTt0MQV38Z0tj82U6K7JVpOB2BpYyso3g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qg7k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 14:00:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NDo57n036049;
	Wed, 23 Oct 2024 14:00:47 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2jjtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 14:00:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVgANWPMUpDb44W876Gc24etoKw5YfWjYTUQLGpuPOn8OVbvTMFVCEbe1+2exzAJchY+mWtkwsEial8vOwUNPDPF2zaFcdSR/14vNYfsoZwhXNDbeWvGxCiSIGfYx9EXD694Zt5QAdpVnMGJ1llBacc9cv2Cq4uBTZJjeYOHmBWn8CU0pQhxuRNPlz4xq2MnL6ip2mcV2T2BQa7v9Pdy116b9bOyVg7bQoLrb6tTLZa3YOeWJgf/gM0GCMljSWlz4Zt4KqgpUQ8mppQ/SbbuXpElLyEWu6VeCKL15ENDvUMIJV/YRve9r/6FGb1Z+2+5bfDL1USkABeOrlsRBu3QMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2S1TKy1HUuwm0IkWekL0ZTMgeFw7Na13+TTyA5gtRw=;
 b=CHjX/pmQLsX5K3fA8xLn23RH24j8FU7ash59GE+am7gqGpEFjXHjHVNqce5lMFdqWjQRrGRderIsrT1klbtZ9a+o+CYSUsW1IdwgY/XJuFDvsfI5f4LoVjGF+/JeBbbv4fFVSbDceW/WkKmDVRUzEUnH3sHO/j3CGN8j5Vp5g/NItmNJ1vGJl4slyO3W7Kl2tJNkJHHcWiRxwN1o1ciQboGDriConZWi/88k0n77PnZ8EwCg8V9Q1akQaiePdQvTpyBN29W5B53MeTXWJQq8wQ0TwtHCaiB8+1s+PFHn77r1tNYbk15La6N4xXTs74GzCUXfx5XdzwSxGNk8XNq5cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2S1TKy1HUuwm0IkWekL0ZTMgeFw7Na13+TTyA5gtRw=;
 b=soFVIwXssKPDeoqQlcddU8/KMG/tgXxjcwgvr7wGhLIPDfj4slAOhHAzwDBPpbdh2nL92z3sNUKp5USqXtO3rIdO7umxQ5Qd29tp1nF4oyFimfK1f19NE4exk4m4D9DLhZoaq0+khfIc32ttlwFDLOGOvn2NSv52+PHJFdxZUkM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5658.namprd10.prod.outlook.com (2603:10b6:510:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Wed, 23 Oct
 2024 14:00:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 14:00:44 +0000
Date: Wed, 23 Oct 2024 10:00:39 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        okorniev@redhat.com, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/6] prepare for dynamic server thread management
Message-ID: <ZxkBhzfMT2ORAFGX@tissot.1015granger.net>
References: <20241023024222.691745-1-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023024222.691745-1-neilb@suse.de>
X-ClientProxiedBy: AM0PR04CA0082.eurprd04.prod.outlook.com
 (2603:10a6:208:be::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8f38ac-68df-412d-f9a6-08dcf36b167f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kzDgEawtqm9whPoJvdrMeLaOvxlSbxFTQ2bk4UShxjGgnF3rE37nAtnaLMas?=
 =?us-ascii?Q?qe8Dtd48viPTnBbDVU+NzFlb4OrY4jvfAqG1CRZkbUsNoN0Hw8zoc6cHhOgJ?=
 =?us-ascii?Q?LotW8XjjqSBewnCrQpR464orvaDdGSWcN0oKvwNucmI58+R614hGk1SB6fXm?=
 =?us-ascii?Q?AS28Y6oW/9pBA633JXkDIJ6adtcYcelH/m/AMbgLDFj4O22+/eQIP3LKtHE5?=
 =?us-ascii?Q?5X42lth+JiE+0aVUllxnZ8uEDOAL4R/mfvwpCxEDmP/VmQNoH2Z3YMXbTLeD?=
 =?us-ascii?Q?I5uG+L6KMmmiTcFmZ2bFwyzfkAMxxvJhwKu456pLSLmxatzLFI2b8ZZXIzP1?=
 =?us-ascii?Q?wVUMhez2okM0fkQyMqTm4u30AsEdkcYoEyFzwTpGNG7FCF2jt3fKxzkNlPxz?=
 =?us-ascii?Q?tolgN6Wy+nzgYVxr8eqLiFKxoz7NHwlMrVqlwMv6uunrhhsE0AtVS6tCukBW?=
 =?us-ascii?Q?OxNWFbJfghOUxyGgnqMZk6+hweJYerxH1JWrcWRq0UD1DVucSdKeiaMWF6AQ?=
 =?us-ascii?Q?i/a9D5KKsElH44qrfmylCPy1nTFPFVtH1iZ0QrmJP/vYy/HrSQ0zFIBOQUu/?=
 =?us-ascii?Q?JlYXB/p7I+rz46lo827nYEVvjAN8kgtZ6E5Qwoi/RkhCdYa67CHje5oWm4Ue?=
 =?us-ascii?Q?gtNLKdJbd6pflpJZajlc9ZXrsXTZL1qOFqtYMYs1nF7NXfOd0V8t+yofDx+Q?=
 =?us-ascii?Q?nWPhdzdGoP36xBn7NdgsANKk2oD2/982BhJ+PcgF+H8YNwXIrVa3Du0Ue1sd?=
 =?us-ascii?Q?E72mt4G7cGjOxX2GA+g0s2sL9fDo//a0bnQxaLCVjW8Xuug8x0G+zBZ22muG?=
 =?us-ascii?Q?5TDKvgPs/YbFgGKf7kG5Lp8hSVW3YMkzheZENmvBjzCIi6Dos3FHXh7oZmi4?=
 =?us-ascii?Q?doDFKR+hki41ZudmEkf1m5C2MvdVtgJJj8cOeRiIS0D9vXBu6Gdntn4+23zx?=
 =?us-ascii?Q?FJzvHsH99CPMveaoI8FKsqTXBRSX36phjc0iKHEMhhgxjtcKw7GGrnpPmdjm?=
 =?us-ascii?Q?Y4G0GTUqpz0dSx3tj9c6YY4VYAviq/BwwreSJn+20HShU7r85rt7nsSxzNXq?=
 =?us-ascii?Q?t8zTcNUy8b6YwIIsr9c42LS2OzEQ2p82dv+y9QLxiGjPgVagl48mwfQhnD13?=
 =?us-ascii?Q?6eecVvRNhqdw2bqQDbgA+WHPkfH/eyKEkvC7BuogNZYZTIKRr7dkTdaDBrXN?=
 =?us-ascii?Q?jMdan7WH0KUuVN3IAi9sBBLKBK9jhV1kk0K2qkmljb9tXp5mtteUqwE6byda?=
 =?us-ascii?Q?DHliyJHN0NnODpF2qtxy80sLJ2LZ0uGBEez3o9s5nxvVx/Q0bS4t1lyE3FbF?=
 =?us-ascii?Q?sBw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kOXhrtpmGBzz8s0I8Qtp0iGjjrAya+6RjyiRnSxCu9F6/wQPT3BjLCSfFVKx?=
 =?us-ascii?Q?ajfzdk59ZkV73IWElZ9ueYBXdnh1Ok4NUPfdDwEcSiahrs7bv28vLbLRKsO8?=
 =?us-ascii?Q?9u1LniJbQ4uSC3wQwOokk6jJ+bk4mWQGtcJzR2VEqMfxOLE/BOJ56YaVjA+4?=
 =?us-ascii?Q?UtjilmnthiZ4JnSPC8yTM90YM2y+6pb+o5mdtLrJV8kf2bBGTlJI4kl52ksT?=
 =?us-ascii?Q?TLhf0uj3pP2SrrB46IVZCfNbWzJBcwsP3bjlcb2XB78hBCO/I2OPjg8zJNTc?=
 =?us-ascii?Q?rqGaEco5Tv5EcaLpLqtoTS2s/wGy+EOzPvUr+WVrPdFnO7dAVJDaT3iFs/lV?=
 =?us-ascii?Q?ifqAwahrCeVMmvCeWCLrIxXecfTTCxbcxhdc69xptKI+YIkXHK42/X274Ast?=
 =?us-ascii?Q?CvIO1ChxHAYa7VugrnVZOtGVItmSENtL9NTzDgVxawo8abFyUYNsrxhY+BxL?=
 =?us-ascii?Q?qyFiUuLaaRNLazZCrk4EbUepwhCdcgiuiM+R7alCQkxqjQ57OgXx+yjerHYZ?=
 =?us-ascii?Q?n3Gs8VJ9b4Nkb7Dj0qeWMd32hVu9EeZM5+yuXq2UR/qUGUW1T5eVWQ8s3TQE?=
 =?us-ascii?Q?Q/cKxPk7afEf/ropv50xH1PhBhE0JnN209HU3Y+NgXjnpZUxYYg7T9fkLm+Z?=
 =?us-ascii?Q?e73RFvHUPuFnkTWoq2lfXDKQapxKDSFWffSnWIsC9KqYUBwxChXXrsP2NCWJ?=
 =?us-ascii?Q?oAx864As69EHBhs/9RuEOJDmXKkwiwBcQR6PrXH7BdeoXC6ubzgg+828ceZT?=
 =?us-ascii?Q?/uxqMdjtWVagOZyFZNtM8xgZolb71UL3HLCxH7hSwQAbQAK/WMhJSMjwkd5s?=
 =?us-ascii?Q?rcdHhN6qtVZnx0eLc7kgYa9r84T4uwwzZPAggp4CuZS7RTYqfBnsW14rw+lt?=
 =?us-ascii?Q?UlUCU0Cl9Fa9r93/WLYcQf84QLx7NvRyuwP4dH8wwEQIxx1GxPVA3rfpocJv?=
 =?us-ascii?Q?+FOXxtYE9g5Up9jfE9oo9au/kQ5sVYhXIQ4RcFXRABwI3kxiPAPqnWHit3AA?=
 =?us-ascii?Q?jdp4uxkMXknDtk6Ds98sGN3eT4BpXH/9kWMBmN9lO5MucCBSr5kqvuddWatg?=
 =?us-ascii?Q?b6urf/F96KLFfqPH837ZLP1tfpGf7k4WlttIGYu1O7HTA8wkKJ2SUXCN4FoT?=
 =?us-ascii?Q?XTkvfVVdhfPWjK1BNop4WkX5YlzsNQVF1SFuH8rymuABERCXG9YlVnLYVVY0?=
 =?us-ascii?Q?EW57X2pA+nxHemp6vCyxVtQIm6kjwUEZNDVdX/hXnWNgyrSQ+EzbIktv1MsX?=
 =?us-ascii?Q?2ahKBU/O2KxXmy5ijf09jFDCfvLXe1komoBN6xGoJQb4nJF5I293+9n795kh?=
 =?us-ascii?Q?+WXvsbsUnwixLBuDBaeSn1Edja7MzPeQyHbxkuT8u+xo3ZH7i75FRVwVChye?=
 =?us-ascii?Q?40JUmFRYDmNx7yICKoO0p1Pxg8ERTgjUmvqZK9z3+YlcZHV+W6Yci/+0NQGD?=
 =?us-ascii?Q?/aTS4Ujw0JJb+QQqyc3JQH2/ffay0rDugOPreTXkMsT/hMSzgfgM+RByFfCe?=
 =?us-ascii?Q?rKt9VCq/WE8GQr+IMS27awDk30gsYETNZW11c1ETgULIAS9zYg2UjWsq1zwy?=
 =?us-ascii?Q?NGOcl+GZuXhm5IRqchwiOUguO2vmrHJmk3xiZb0Xg9XByXEHs9t72pTE7Tra?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K2HfIkaf+uAZOILGOTT83M6LrLKzS0R6UDy7yEAgR75JkUUNZcxSR0+JJEhnhrZhggVTgR9L5u50+yd0UynOdmqBtLHDZJFJKUeCGY/EbE2Dsd8XGWlvh00Y6l1ZCkRyzVibOY4e/+h/w17GGYmfkvVoI5B6h3yOv71emjtgidai8Q2oAijeXXjQnpOK8WJNykZgawND0ms81+kku+L+VxX/Wbsnqt67tBtv+F1Lq+6/joRZNC0gnW0BsAjCEhs2Ndx4XDnX/yrSg4oHxFZCSggjXYuqjci/TO3ztCjE/YjXTzalSKJZMkm0zi/xrObAnHfze++rAs7F3p70kcpl4UvCX722Ikw+h4eFjj6Xej/a0hMSA6qQqaomHaJGU3xAlijDcFeYoxmCemQW4rrAdHODVzFUiGPo1oJ9CLiEzY98peGY9vdF5QLC1PPOoJkg2bDk7RsUXP6bf5+BFFBNuDLRemJQxwthvCx7qCjCK0A/I4x8WF1uEMf8q+81SFoWYhhFaTsf9Vahq5gm1+OHPTq7A2t5LZ+NgHbGHBa2wtoQKizggOZ4Q8cH0x+27EtRqbpvxPJRm8Ie0wuA90MbKH+gsI71+0AQ8HqfwG7idKk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8f38ac-68df-412d-f9a6-08dcf36b167f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 14:00:44.6550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJv1wxc+U2RPT0NAt4eZtdB47rW1uVhxnWVOyNb+a/btEAMbbZaxWXhaLh1ejKxhww1BgSz6fy9k9swm8gqiIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_11,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230084
X-Proofpoint-ORIG-GUID: e5gTnDJJ8K-7pLIxIPbPToZX_s8JVhe9
X-Proofpoint-GUID: e5gTnDJJ8K-7pLIxIPbPToZX_s8JVhe9

On Wed, Oct 23, 2024 at 01:37:00PM +1100, NeilBrown wrote:
> These patches prepare the way for demand-based adjustment of the number
> of server threads.  They primarily remove some places there the
> configured thread count is used to configure other things.
> 
> With these in place only two more patches are needed to have demand
> based thread count.  The details of how to configure this need to be
> discussed to ensure we have considered all perspectives, and I would
> rather than happen in the context of two patches, not in the context of
> 8.  So I'm sending these first in the hope that will land with minimal
> fuss.  Once they do land I'll send the remainder (which you have already
> seen) and will look forward to a fruitful discussion.

3/6 seems like the star of this show, at least it's the change that
is most important to me, and could have the most potential for
introducing behavior regressions.

I know this will seem like I'm introducing further arbitrary delay,
but I've found that testing and soak time is still valuable for
reducing risk and disruption.

So, for the moment, can we focus on the details of getting 3/6 into
nfsd-next?


> Thanks,
> NeilBrown
> 
>  [PATCH 1/6] SUNRPC: move nrthreads counting to start/stop threads.
>  [PATCH 2/6] nfsd: return hard failure for OP_SETCLIENTID when there
>  [PATCH 3/6] nfs: dynamically adjust per-client DRC slot limits.
>  [PATCH 4/6] nfsd: don't use sv_nrthreads in connection limiting
>  [PATCH 5/6] sunrpc: remove all connection limit configuration
>  [PATCH 6/6] sunrpc: introduce possibility that requested number of

-- 
Chuck Lever

