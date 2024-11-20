Return-Path: <linux-nfs+bounces-8143-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722B89D3162
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 01:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B7C283C43
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 00:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334C84A3C;
	Wed, 20 Nov 2024 00:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X0n6Mdug";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GFS2Y7UV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5432C647
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 00:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732062336; cv=fail; b=R7crTmnghlc8tZtw3G3nHgNJaKMxjdVxzyogl+lmJ0nyCJGxG5N4ghZ7YqvRjtaGWEemlj7FO1v0t10Z0QnNHQzIV1zNH6Qtj/Fs6W4plwQTilWMlz4UFQ5KzJOiv6n+Y64pRSHAl5SIg2EvtxlHjyldhmmpvKvsjaUQwlSF7Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732062336; c=relaxed/simple;
	bh=bw+MPOztovbOwELBQ5hNcqNXW3AvoOUx0cT2m8sB9SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iIufm6OM61lcaT5gvCxBBkF4ypTRaw67J7Nj/oKfZD4vC9p85FWntL0WxS/161Hp1koTe561Jl37v6nqcYfDB7PZRV42P1S3ol9J6RUBbe4hhLvrLaLwZJy20D2Ehbm8kjp3YHFbsf6ldxKLA+e/QWIuCV2UE4XKVTVyUSV6X9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X0n6Mdug; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GFS2Y7UV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJMfYw4029460;
	Wed, 20 Nov 2024 00:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=4Z+5i3d3Oyc3NDQ9A4
	IrQReBlVTheds8d6D6GcZMtLw=; b=X0n6Mdugj2uQM7AhmdE3pLhdtufnCIBRuL
	r81SjxQ2RirVvYmcYknBNjJBPxwpKL/K9xZNc7yqklGraW39cnGGfWC6o6Gc/Nfz
	6YsUsx3YUWusa25RbT6CzPr+FiYLqWYzaYzDCEYeqkVJwV7MtGwgBm6xHSXMe2c3
	yN7FvVyRYe+5TFNxcMEQ/WTyZHSrBK5LGGxdjXs9OIsiMjfkvWQRtcD2rwGmM/Ot
	0CgWXA4VK9NGrbAt+JyOmcmRZ8C3xeNOT1HpWcYg2LVt9Ghi5uCk5XYQUb5Xuphl
	P3iBq45IWtJHTBsjcD7pKAqW2zwickXcMP3leHI3KpCXZRSjOb5A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0spahm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 00:25:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJNFYs0039276;
	Wed, 20 Nov 2024 00:25:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu98h0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 00:25:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3aZRAmvKuYWs2IflaSTBJmipSNV2SqmvPp7EAUTAj18t77kpNjrHwsPuauINFBsBLwlT9NoqWIeLb1w8plVDWZ+xkRhHvu4nEcZpsagV6DjTj+xSDuiUhLWhKA7aDkmwXCJnE3a0Z37sOlBIn1/KAl3rvY69YIaHyIkAT1Lus7A9Mj6OvHbYriSEa4oq5+nxH+klEDb5VQKJflUFgvduugfVvWlG6O2xDN56vOmEAOTySbEznleGDca5o6OwqPKfMqdWKIvYZHpMcK/SmEWIpMlLMbM3mxyR/qcTHX/EEAVgmoHge9UhB8madXbAYZh7opPEYDB7qzVx+ntkOW4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Z+5i3d3Oyc3NDQ9A4IrQReBlVTheds8d6D6GcZMtLw=;
 b=ysTF5/UIEx34zDFEvgSg8c4OwkCITrnYwKOud/8daBiukT3DkhPhcIEdiRy6gf2u/QO8AuC8bKRXG7riQNdpJUSaVdvGtRY8Xv18JUXMQWrCgz+2yOlfL6OB+oPWmJtKxW+dPh+XGRYOUeff5oMs709hl5TXK7B0ACkXj8Dq0ol/oQnb9ZTHubRmRrupv95R+CsJtc8XV+Nv73Qm3mYtR0Uy06p+Vd+zJgFivkyOgiJpJ+LRIEhA1rD23Oxxh7bqvuA+mvIDzk+Nf+4ov5ypzxyEU6H9gq8Wiz3WJxvsK9SpQoxnoTKm6zPHeqI+SzSXw77gXiiH34V4+BuCggyeBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Z+5i3d3Oyc3NDQ9A4IrQReBlVTheds8d6D6GcZMtLw=;
 b=GFS2Y7UVSyZde5Akxleuqui1c2F8+wZjXfTLqSpcmYfIKi+7UfLuW4IywpWdIwq75WwMA+4UjCkfjy+JT35VkDdTmEXR1nYG4nkWfYIGlPIpLl2xQDNa7V1COOLMVG99hqgezDkw5rFUwMIWcOqM6azfjTdJSBBGBCZPBa4BMcs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB6959.namprd10.prod.outlook.com (2603:10b6:510:28f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 00:25:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 00:25:19 +0000
Date: Tue, 19 Nov 2024 19:25:16 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/6] nfsd: add session slot count to
 /proc/fs/nfsd/clients/*/info
Message-ID: <Zz0sbK49PELT7HpN@tissot.1015granger.net>
References: <>
 <ZzzlMXO1mteXdtWj@tissot.1015granger.net>
 <173205509210.1734440.10921571462363976751@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173205509210.1734440.10921571462363976751@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:610:33::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d22fd76-9675-4e69-4f94-08dd08f9d048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cAihqnRcD9HG/DKyeROUElVYfFpIa66Tyds4GeT5g/laMlQp9fQXimMeGtid?=
 =?us-ascii?Q?tH5PK7PXd26OR8Z4x0vPWwOBThx6zZt91SQS3adZgpVdjKnoenHpoMTbKVIj?=
 =?us-ascii?Q?afDIddvuJRLSWUT9jK4UmMLMBfrhM+q5q1Z6HOWz+3xgu1HXIUp1lKj5U85j?=
 =?us-ascii?Q?GswZpwRPoKToSSvFf05LTfXXS6YPj6hGDsw7gunyjTHVJ9oYltnO5Yff42e3?=
 =?us-ascii?Q?qm0bfcibiPC+C8tzlfzCYC54QuhezblRlmg/JbykSW9lpjW/O3GpMula1xrX?=
 =?us-ascii?Q?ZnkG1uzHr25bUyp//HMwmnedRqQwVEdL97nj0vLjYKag3qRKRsWlZ6QF5mkm?=
 =?us-ascii?Q?y1Qj7dMKdrLQTXfRJpaUN3odqel/GrAGa3aAQu2C1adWvWWLKkClLqtT5lOO?=
 =?us-ascii?Q?5SCQyIXnjS83bp3m+BmrqIRHHg397vHlvyPsWXV50xhb/Ji25AsRnFxPoyhk?=
 =?us-ascii?Q?tes3wVS8UaW8fheJDFv1LBOl6o5HFjVX6UDUG7Dzru7eBMe3/2MUhfOay4w5?=
 =?us-ascii?Q?DW9dxQ70r5AsvU9zZgjcA4bzN1ZXX+XLfzC54+mDKyTd6YzdVxtOZIDa79lA?=
 =?us-ascii?Q?6h8Ihudc1DL90w7Jl8G7zBGsqVOwIjmeSJx98eInzbjeYw1Euqsi26/ABdcw?=
 =?us-ascii?Q?Zz33P0a9JubIXGLjCry88g9BgNYSwRuXXWWslIf5WxeSLngGpf1bHAVPvQd4?=
 =?us-ascii?Q?G7xbz0cGDFX++NJuDAMnT1GF2cMYJw2FlLWiGIm2vQSAMj7Lb7GNVmaH9BuM?=
 =?us-ascii?Q?L1VVyjPiQkAFjEK0nRxKHGGj6mZT+xRBjbOY87OFw2gxrBCmk1x3pt1S7Gzm?=
 =?us-ascii?Q?82OMT0UMRM07+XwqU5Gle9wylojbb09W6WCy72gQSF3efbovgzWKDVcCxqNX?=
 =?us-ascii?Q?UeVqxQsLyw5Hbg+1Iy3Rzuei6W+1yvFY9zmjcDwGvwIKUCZPg9m1dc2abIA1?=
 =?us-ascii?Q?hHlvRwSoGMAM8py1lSg03cJaMN4Gxdim1eH+M39BJnh150VK/P99k2r6t0NG?=
 =?us-ascii?Q?oz+rBD2ALOzBln9zFFH7nKSkE931yVFnzlbq4u4kmSELspCwdUqZ3fd4t8dz?=
 =?us-ascii?Q?k6+hOFxjjDMNERlka/HsBwXUGy41vmhHpfcxQC4TLbDQgCnLdkPq748hoNDS?=
 =?us-ascii?Q?ZnA7q/tDDVHPR7MoTfu2YU6Xma+USsZB6nboE/23Ef5q9OTxRh72roKSYsVZ?=
 =?us-ascii?Q?bWLe97PDkM862s+DhR+xycl353UFYBUvBV7tZsVXAX3gvymSQOctLDu2+3e8?=
 =?us-ascii?Q?lfGt3wLsTSBg9m2OHDsUX4bRbTZ2t1SY67KA+YbLHqvbL1NLJksNkRe3H1VL?=
 =?us-ascii?Q?QN3zt3mAemHyS4wzD69bmtLY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MQfynqfb5DHboi5YPqwmeAFN5VK+XaPT3sKX4yNN9IDp8mTIRTsoYZD+2yQL?=
 =?us-ascii?Q?TlWZksqSw80dBM2sq70KXkcD3cPps3KUP+1FBXDmW5Xm/Gy2rgvCKTzjr2cU?=
 =?us-ascii?Q?mV0/+AGEU72lJNrV8Rfi1VUDSlB8ct8UDtQII0dgqJp13k1HZ5qrqwcROaSp?=
 =?us-ascii?Q?XnCTGIG6YdeYctbbO3D12/KEHuFbmG1bYsfuFbOBBTbiIwTDCiKz77WJ8Zzx?=
 =?us-ascii?Q?k779nTcGPNVsig21oYYPnBSINCyCCSVJnq5G2hC/AvzMQ7dHxCFZAv5+2dN0?=
 =?us-ascii?Q?9+QxCwYA5JoD4EPLQzG4SXVNoLpqAqmi7xgmNHupcgpTcuDv/K0drhiXQAT6?=
 =?us-ascii?Q?rwlnmoNCuouw4dI3R5uexxqvkPrjWM1qGyVuVWaDao5XsE+PadmvaigvHJ6T?=
 =?us-ascii?Q?wQQxmgK9DV/8pwsHIovL80vTgpccpsxgOv28g4PVsARW6k8xTnb89+sHcVwf?=
 =?us-ascii?Q?HbvzUlCAyVxt5w29QoPGwdimzetkQrgcrwps+6UvBb/qIZtlf7auSW3XKaTW?=
 =?us-ascii?Q?meHQPHqX1O+NT5Kf35XrQgi8An2+oh18A32T7awLvWj+l6tt55qM6LfjXIcY?=
 =?us-ascii?Q?oOK1HPzFVSi7n4ZR9/wjPBRPRKeomWwJNDEw68gVk8v0saHfVhTRxTi0MdmL?=
 =?us-ascii?Q?4NB3TnOyJSQ/80O6Tg6OvoBrLV+2sv8D4kWi+xYljr2yn77aXV9Rcig/vct7?=
 =?us-ascii?Q?4l3egYEVYOFEEn1BlWSzxheCsfSks+2NLWXJVVw/KrpdLCB36da3+96MHOiB?=
 =?us-ascii?Q?t1Ge0aFGaQ87Kp8g0+BpQ5mC9159/vqaYZlEKCOBtIMrDPLQHdHTvP7t1pJV?=
 =?us-ascii?Q?iIXU05jGGqxwppgXnwjmoQPzncAip2nlbvOXWdNd830SfHskHlxHwUpHfKy0?=
 =?us-ascii?Q?+nC8KUr5WCBlchIAx9V4qBgPzx9Go5qlhzJbftNb9/ASZLpjy1wphIYTGBc4?=
 =?us-ascii?Q?snVFMlp2lwG9hj8/g8meZpSm/xJmHl5Xudd2nOBqv+8qRQIBNmSDXoZp9K9Q?=
 =?us-ascii?Q?BYy26MiZ1HMjo43iVRKIEGD4Js3vEfwbiArqS/YBZKStCBweGJI1mJbkssEw?=
 =?us-ascii?Q?7IZV2x/m1kecBP4tv5mG89rVnLNAkFYXP7oRgsIrjPdcJ3ztm3td3WUUZ6Gz?=
 =?us-ascii?Q?7AIsRIEYoAm0PQGcVGux3JYGgg2kMMX0tqlUZBBh4xzfm40ZZQt2QNpQrkIB?=
 =?us-ascii?Q?WsoOVRIsZPCQP8kLS4YXbQ+8uJSOcgcTNnhYGhMU54FPXLQujq91KUz3RIUv?=
 =?us-ascii?Q?42JjpaBgSYHjhOQe4a1MVps+Fhm4JKhrslIhccqKZMPzqyaVRagOcSC6A1/h?=
 =?us-ascii?Q?sYN2htUUChaWixlG+dZueHy0DrvGzqYNEZvS/arpoouBokw3mVZpLziHfdbX?=
 =?us-ascii?Q?kILVEXWQzPbVBbMBRNss08Bd2hp1FhYBrWbwUcbJ0y9DWkH96oH13UxFIR2p?=
 =?us-ascii?Q?Dz4Al8slCp70uJEhsHpOwrWmbjRvPbkPRVFsD893oDiHa7PbTxZ5Jt6SjOKH?=
 =?us-ascii?Q?TmQsrbFM3ugi33NxSsdfiSt+bIl+mfFNsPsXRdvX1hhAmMcNo7xF4VXxUMi/?=
 =?us-ascii?Q?FDWWn952o5AeecQoHZd9o4nehWr0Q6itoc3b+SmCk91IcTeush7f3IXbOSsA?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mToY0X4h5xFBov5brDYwyqxvnjG3KtQR3lRUNbcu1p2qy+Y7WVCEgcf9k8fON2CnRQyQmMdAWpQa7mEDWYyUOf7mfOyW31Yul1bFNZ+ZFIfgZMM5CZjurCF658Gstob+kUMJ5E+PGHulwp9cauITwROch0rXZP6UtNGJsdE2dGbSAgyCglUMAXAWliJfhhDx/VSJC7DatxaEGLr/X4CAMzooOPpuRW7MvZl+ZDhI4wao5CWMTq7cuiu3L1QFycSnOQneWwBUv+M+TfLuMG5NH/htmIZ4x7/cKllWblKoYIJlUdc1Cn3gSGvLcCh4fiMvMA/r7pR1cK39yZKZtbaRkF/z6MDiYshLvJ3JnfDGB++QU1UPX2ED30J11OdTX7XIasujPno+CtAV6IS65NUqmYduKEoq8ZENz/mZZ50OwtKFHl8budDWgjW/+nHjGuJma1WWhuhGZFT2umsodYATRZgFgkKDpA4vMzS5twQjhft5UMq/405vSAMhqueZemdAhB/29Yw3P4AT4OsPvgMhKf41jnIhslZoQ8GQB2YOJOf9i13Ghk4Pk/bBF66BkNRObxlpvXX+lCqPDmGenok+zleSgaQ38w68uo7wJ+TQp1c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d22fd76-9675-4e69-4f94-08dd08f9d048
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 00:25:19.1914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0QitdP1qxjbdOK9nooC/mqJkTSrkvxofH5ZQnlSfwpvlqqHLbCDjL9aStlhnoSP0A1zSDwKVxHFmt4A3MOL3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_15,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411200001
X-Proofpoint-ORIG-GUID: yi6uJuh82V7Lps1Jcd2HqGrbSZoJE6ty
X-Proofpoint-GUID: yi6uJuh82V7Lps1Jcd2HqGrbSZoJE6ty

On Wed, Nov 20, 2024 at 09:24:52AM +1100, NeilBrown wrote:
> On Wed, 20 Nov 2024, Chuck Lever wrote:
> > On Tue, Nov 19, 2024 at 11:41:30AM +1100, NeilBrown wrote:
> > > Each client now reports the number of slots allocated in each session.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/nfs4state.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 3889ba1c653f..31ff9f92a895 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -2642,6 +2642,7 @@ static const char *cb_state2str(int state)
> > >  static int client_info_show(struct seq_file *m, void *v)
> > >  {
> > >  	struct inode *inode = file_inode(m->file);
> > > +	struct nfsd4_session *ses;
> > >  	struct nfs4_client *clp;
> > >  	u64 clid;
> > >  
> > > @@ -2678,6 +2679,13 @@ static int client_info_show(struct seq_file *m, void *v)
> > >  	seq_printf(m, "callback address: \"%pISpc\"\n", &clp->cl_cb_conn.cb_addr);
> > >  	seq_printf(m, "admin-revoked states: %d\n",
> > >  		   atomic_read(&clp->cl_admin_revoked));
> > > +	seq_printf(m, "session slots:");
> > > +	spin_lock(&clp->cl_lock);
> > > +	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
> > > +		seq_printf(m, " %u", ses->se_fchannel.maxreqs);
> > > +	spin_unlock(&clp->cl_lock);
> > > +	seq_puts(m, "\n");
> > > +
> > 
> > Also, I wonder if information about the backchannel session can be
> > surfaced in this way?
> > 
> 
> Probably make sense.  Maybe we should invent a syntax for reporting
> arbitrary info about each session.
> 
>    session %d slots: %d
>    session %d cb-slots: %d
>    ...
> 
> ???

If each client has a directory, then it should have a subdirectory
called "sessions". Each subdirectory of "sessions" should be one
session, named by its hex session ID (as it is presented by
Wireshark). Each session directory could have a file for the forward
channel, one for the backchannel, and maybe one for generic
information like when the session was created and how many
connections it has.

We don't need all of that in this patch set, but whatever is
introduced here should be extensible to allow us to add more over
time.

-- 
Chuck Lever

