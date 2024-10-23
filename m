Return-Path: <linux-nfs+bounces-7387-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1882F9ACB7B
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 15:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E031C2089A
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 13:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB2D1A08C2;
	Wed, 23 Oct 2024 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f5MBznpR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z8YORu1A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8DE12B71
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690978; cv=fail; b=SHw7X8ljGY3ltKSsA/uh+Ddnt7mjQd1812bpBx5Qrqa+DEW3suDTAJ7RK26NoqCixtwA671BAFZg0g2egSbd4jjKZbdjatg1qnEAnL3tvoIn1dK5XrivI3bLDl11jtcXzoNIbb8U/99i6FXGYcd04WMxe74yZz7YD5Tc9nh5Dpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690978; c=relaxed/simple;
	bh=XDPj6DO7Xf4lNxEogHyMWiT8BpLNY9obSPcM5LQm0S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=teRhxGFBrxhOni6/YjHSyuhHuv1z0jVsCVg57MJhF4PrPj0rv/Lwn2uvmrDx3VwteyKYccjmXyQnUjobgVoTmCNnlmBmRuy79/y/oB7HENqRYhbGUlQx3870Pc8O02lO1iPlAO61vkniFjOBB9VF6TWQe1uVX/dilVnCsD3E5TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f5MBznpR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z8YORu1A; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBQXGv032096;
	Wed, 23 Oct 2024 13:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=impLUWWqFZR5kT2ddK
	9KHm6IdahA8+yQHnH3uPurO4c=; b=f5MBznpRt0wCMvkSwup0Y4y2WkBjJudvt/
	5Z2ZMTpMgy6FBj9U8vL5Rxjvsyvv8vWfotTiO7rCW8iVadGaHzACcO+Ri18630H9
	LEzBudB+RkGjyAsuTSzrK9Qw8HTcb/cNnxhQq4fTh0dhUXNHNIWKBZFyfs1hW5DN
	bPP29YtvRad+mrw388zBQ3ru24sSv2tZ+ucwToiEl+Rnrpmw6M5m9StxJOd6UZw2
	nUQGx+7nbOVK6cR+Xwhj7v+5i10JdCVTA3LiShs0uv542KeZn3CGhod5GhTFdFrH
	O4olIjC8yujTKjVVuhtiEBDL0bIB9OMSuHltu/1fkOUmfj0kQ6oQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qg64u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:42:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NCGC15027078;
	Wed, 23 Oct 2024 13:42:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2uev1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ts/tWKLNcSS5ggHcpHlxzAgAM076I74HrYJb3zh0dYgo6OZ6Kc8xqAps37qRW0EHoGyHc1l0PZmm2xIMAuqOxiY10btcDmLT+0Yjxnb3qsuZjpPNL4Y5vT1i8Q0jsmjmjF2Gh84UqhqxfFghszfnyi6U57eIJiRCbHU9Pz0h36Z0P0otCmcYUxMPDvZYQuNtdWCjTNcoHxVKxWVBzNdqbPGDKLzHaMnAvtodjVoN8icFRpxXnV9/KRWyoNXaO6TVMZQRRzC0pDEDjaaNI9CQZ6yrfE+6x9Zk2uObpBf9qdtfbcLofHislMetGASBJHW/Mg1T1kAvU/J+OVreTwqDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=impLUWWqFZR5kT2ddK9KHm6IdahA8+yQHnH3uPurO4c=;
 b=BY2aQ9KZ7BIjvP8mqayU62ETPnFDO8f40vjcsWnJ91fvrv4ZIRTSfnC0qtaCO0Gf9zjDkZJwGcnN6AFABJ1Ne1nbx6xd61/Fe2gXFgEy7iTbjtDwTN+yU/kXi9QX4TlSMtYMfSb/6SQnzRen0zwbObhnzSNFr/ZVtWhkKxfTj6pBtId7OrPg8DL19F2WuRffH5MCz6zaDK1sBkLVJNL2d40QDKDRWF5BsN4SzACj006IGxMX1e8o0/C4C688Rb0+Qd5S2S5BJz1566vdoDit1sJ/HNxvUFfV/6KhtukYuFybE8wVX4uQQk3d41wnaXD5Xs+HCZ48Y1FvIesonmcWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=impLUWWqFZR5kT2ddK9KHm6IdahA8+yQHnH3uPurO4c=;
 b=Z8YORu1A//x48Zumls7CdH0Gs0P7cTsh4Lhm5Wxm8D9MGh2hMpKNgSTesewvjl+G4hQ6gX/cWcxYpHjbF3DqqVhoLvXON2vUFQhSq6Lzpi3vK6xUDX3KjhLGvjQpDCac2iQdumNvB/coxnFd/ZeaOt21904z5z4DTE39uUxvH/Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6739.namprd10.prod.outlook.com (2603:10b6:610:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 13:42:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 13:42:44 +0000
Date: Wed, 23 Oct 2024 09:42:39 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 2/6] nfsd: return hard failure for OP_SETCLIENTID when
 there are too many clients.
Message-ID: <Zxj9T5hn0ouG38s6@tissot.1015granger.net>
References: <20241023024222.691745-1-neilb@suse.de>
 <20241023024222.691745-3-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023024222.691745-3-neilb@suse.de>
X-ClientProxiedBy: AM0PR10CA0110.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e046aa-2c99-44c8-b881-08dcf36892cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wdZl1d/m3dYN8AgAkb8zzz0++hZYaS7L5u5s4HZHvE5UYGbmScDolHY0adQx?=
 =?us-ascii?Q?mXBPPLEZFpQX5r3WnXazh+4pXvQi5Uzd5CPyPpJr0Vf6DuxPD15expt1VkjO?=
 =?us-ascii?Q?ZNgBMPx7I6uoHbK4eV6sgSaHHsMNX8joUwnYEn5nNYcnfuNCaAxCMYHXCQoY?=
 =?us-ascii?Q?9uIYn6q39v0SAFWpveSc21pJ5IqQBDrBMrpiFawuHFO4U5Et/zUNkjCTYalA?=
 =?us-ascii?Q?tMwiCAP0yT3wcyAdMbVkC9fjGoc1bwd+JxrCtZ0eq7dsPC4rFRnvSmEkNQoV?=
 =?us-ascii?Q?umGvcTZmDKAU1G1Gxd2f/aCPSRfvNCVQ2qEOz61qTL87vhlgy5lics3/H3e7?=
 =?us-ascii?Q?YJzv95WWl0eHA6TuBawfeVieBA7aKx4SKXVJx7Mwu/D0ZHU4LI4txR2NKJvk?=
 =?us-ascii?Q?AMwCWWTpqaAhj0UO0JlkLsRUBNw05BC+RkhDq0vZDRGxFgIz+lquMiGzR1jd?=
 =?us-ascii?Q?JdwoKOW4lYVYmextiC+dXBQIL74//Z0cdt3ndjFW09nGNp5COkazUuKqfsnh?=
 =?us-ascii?Q?C2XazXoi29qvEj2Mh6WIk5k6osbQvunVwLehp81bFPWN01IVASv9862aTImf?=
 =?us-ascii?Q?67bnU49KE8LlX3yo3K79a56Yfe8FUhcjOBeWwJ21yd8oilAAP9Jx7YV+/1rK?=
 =?us-ascii?Q?CnD7ZwsB8+3mVR/o4fsOAJltHMlvTCojeJQJzRrpxfLQ5WPGw5c4vhOrQcyF?=
 =?us-ascii?Q?ZMcKUtbQiIbduu5fQs5jXRoTGfd1RgN5ZJS6sYx4Khz30tP+0tCYLLx1Zklv?=
 =?us-ascii?Q?p7thsXSiUn+48q7xin0o8vQbFrY0WUPMaxfSorUFxmLeoyZPJgItbQN9tioE?=
 =?us-ascii?Q?hZoFaPye0PD9x2nriJUYtmIPQXK6f7jb3c2HStsM31Z0bZSt/UmKxdFWJU/8?=
 =?us-ascii?Q?FftofsvIhUSOKR8EYZTnCFiAhPYD1JWRUGqyMd1S9+Bi4x1c157R9iZv9F+G?=
 =?us-ascii?Q?ySitY5FIW4VZNe26OLcP7rfto0F2Eu4a9rVUSqjXZRzDRpSggTc1g6Aho2zY?=
 =?us-ascii?Q?ERmWNoC/puy18k0bfhmA3CziHo7mF/kdiypODdFESHaB0FjNb8jOmuA9mlse?=
 =?us-ascii?Q?V3kNKRLLDHmmAi/DID34hmLZkGHPx5IXXAKzvz5ZFugLyH/qjzGqairwyDkG?=
 =?us-ascii?Q?RIGq2GMKC1u6tYDRZvjM+WkVLB7adtzl2kVh0husZgL7MfzK/oex4WBIRQs6?=
 =?us-ascii?Q?loLl/1B4eTM684Nyz9bb5FrkqryfTVDnhh7Z4BTPtcdZ9wKrwcPHvQGn/2nS?=
 =?us-ascii?Q?51lyf0jQkmh0VkWhi7pIHMH4jeScYccvXSP2ilDu6vMo+BZaXs0VX69ogPfy?=
 =?us-ascii?Q?tsU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TCnVhP46HJ+9jGtMZb1sdNBpf8drdhOkYRoXofJJIb/m7zcX2XiVw/+Jzb91?=
 =?us-ascii?Q?f4FxUb/R04HVMkpQLa3eXpMhyGSd4me3YqffPlUAqL7WaYX3sxzybzFEDtWW?=
 =?us-ascii?Q?okSuQemzQtDGl8RGM0A6gp7Zns9qqVSSytIGO1v9h5UsRfLSvXfC4S26CcGo?=
 =?us-ascii?Q?vg1RKoJjBl/OV3ub/ShKmsEZU4K+Rklahtjp/feOe90ZjQ8REB77Kj0TdVOm?=
 =?us-ascii?Q?NpiZHsxua3nnyAAIiHwFzg7KqvG/z7TC8NEBjE+oQe1eb747ssI27NnzVJrJ?=
 =?us-ascii?Q?Lq3kBOWcvhHvB/75YG0v0Xf3ltZs16tZ5nAUW8QJ7p/HQkQ1FIcxszWSnJfK?=
 =?us-ascii?Q?SLXs6QUN4xU3szR6xXATRRos9gNLJBFos7e/mqSEqyVgjprakkmvrIGVlBLW?=
 =?us-ascii?Q?pv006COdl0BfE+KcCy6jchOaUr22exktOC4Pfem0u92Dqk51e8nrpyNat6xc?=
 =?us-ascii?Q?aXFicE7Rbe72Zqz0h8NqzvUv/JrVZ/+QSLACsOcZXi+CMeknJKYssj9u+IQq?=
 =?us-ascii?Q?czVpTfXPs8im8sWDNSwjTxTcdTP0dBSsTZcSIR9QnPpuSUGF/T8Rq2mATTrz?=
 =?us-ascii?Q?Be0xsmLYi09Z1t34aF1Uexz/GRMx77T2Fh7aoqZ0CE8ezkVz/HFEgR4mmz/X?=
 =?us-ascii?Q?klA4BMXq+Tzlil5PJxJ0U97o8z6gS3i6UNkWgIccQeRzVp1EwXXwFID0ln+f?=
 =?us-ascii?Q?yMT1qz4NMTtcZ6hnwEc5Qs3pqNOWaJHpcTWVDLQEqA6VqMQvIlMhue/Qfchh?=
 =?us-ascii?Q?nbBpHty0CgzbwuG1Rktrpu52c0EijVn9VMC4mBrmGfeIIl+Rdq7lVGeC4sh9?=
 =?us-ascii?Q?bK4Rgv7vW/4wmDQb+l52iZ5aXhLaqQGEhgSg3dUPtLbzhWJJhpwA1IFwF1mh?=
 =?us-ascii?Q?iYliaiHhQUjegoGjMYjIWyiRPpZ3thyf65mYKIFkBgpDhwtvks1Od3ZqhE3E?=
 =?us-ascii?Q?4fsNAJVP+Ix6VvcSSQg4IKQ73uADO2uucR7qyRNd8/szlE2RqNaigEg5fpxd?=
 =?us-ascii?Q?vY6S0MYiVCDQJJWGnGCar+RC0dyy0QmCyC33B2Y6PAKk/WJ7rtZQhSmmInyR?=
 =?us-ascii?Q?e7dw927dyDUwaKVvEsZK0ZsHaPVfQXNOq+0PzD2PoZiwITh8BFu2EGI3ZyGN?=
 =?us-ascii?Q?UmIiNmr2+Hx6Qn6JYrfydFiYFjUKj2DBGjHl+qCoKPHVdvEM+RXiV47p/jvF?=
 =?us-ascii?Q?Tvn6VjLE7P35SVgV5esYEYxnHAslTYSFU0HDZJ+Fk4ammMP44Qjk7MI37dKc?=
 =?us-ascii?Q?8hIukvU6Ta/if2iBSpvegH3TXc5YQKAwa01186WT5EU+vSNglZbLo51Ypubj?=
 =?us-ascii?Q?eZmkUjNiJQiAV4mX1ty2gntU6msJ3lGYTMZy50Qn3pkUZ/LsAXzSHwnG/+4j?=
 =?us-ascii?Q?fPVlVw3Z7V8u0Kaob3QXBn1y/M20Vya0V4yz0oN/zn/nOTWV0vQFigxVDWN9?=
 =?us-ascii?Q?OPqPwl+44xnjeZUpRVIj3ToLlupPT6BVsWYKxg9LI4TnNTyzmh7Me0iEpxmW?=
 =?us-ascii?Q?mqgZs8DiBRZU6hq5MarmTcrHseuhhGwLT00I6YHgYAn7BO9AVMOKf5eTd0Ts?=
 =?us-ascii?Q?1PbbVj2llj4sAqdOasLZ2HBIOtCXMgIRtszFOPq2pFUSVG0FuyxFqTsd4RUJ?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qwjAr69gNQeczZcx2C6S52RyzI2W/MLrQcWh7MDwZQ6vm7pdYd7j/i+dPFbl5VOGESJyZIs9MnQ/TUWmEviH3vFZPa6yLAHG2z1ZGxpA4USYwKJkeHsIsHxcOLmUL9mDfJbtpo06eoW271Dk4e8LSqfj0dRDlvugzq0SGe5Fs5I9tDhFT7gM0bHWKqkJGqdw96L5Rvb+hsmty+qmxI/bj/V9IMUZIZbcGaEl8XZHpJ12gWRhtvVTZJ+WbP6TWlx9wcdcP7L9KQO1Smv8yc5CPlpPPf89moAK4QRYOIj22UUayWaomfIktoNY0Yo4nYfwJoS607SVZXyNRlbwqt0TMyvHEQOH4/PbOGThGHyMrvKCoPimQC1qoCAEmk2DwDi/kmiiCFpMDnzlbmNNY3LwbHSnyvZict3Q0tuM1aCDp7PtOwY0qhk59a9aWU9fjYTBzwPFjBfJuGt6pX4wI6nAfsCf0qLSoI8bzLjOSmwSpmQeIAQAVii8LtTIDipz+CDvdF5kMFTOKxyRw9iC9oQJTCYgLOzPe3+Hv3nMcE8dMGVf10ULbhyLlRB/t+FfnJ3VYdNO2kh6lmZF1W5vs78UzpyMbkm3VZZRhYX6Kh1hzpQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e046aa-2c99-44c8-b881-08dcf36892cf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:42:44.7626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONXPe1n7qE2cJcW2EJhDRez1d20VskJcvo/tOjnlkpCdn3eqbJdSkE5zwWVCPZFEM7BBqfq58ptd1tC5UvHGKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6739
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_11,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230082
X-Proofpoint-ORIG-GUID: XXo9_Xd3ty4qaiE4NflFD8gHQKcMNHtJ
X-Proofpoint-GUID: XXo9_Xd3ty4qaiE4NflFD8gHQKcMNHtJ

On Wed, Oct 23, 2024 at 01:37:02PM +1100, NeilBrown wrote:
> If there are more non-courteous clients than the calculated limit, we
> should fail the request rather than report a soft failure and
> encouraging the client to retry indefinitely.

Discussion:

This change has the potential to cause behavior regressions. I'm not
sure how clients will behave (eg, what error is reported to
administrators) if EXCH_ID / SETCLIENTID returns SERVERFAULT.

I can't find a more suitable status code than SERVERFAULT, however.

There is also the question of whether CREATE_SESSION, which also
might fail when server resources are over-extended, could return a
similar hard failure. (CREATE_SESSION has other spec-mandated
restrictions around using NFS4ERR_DELAY, however).


> The only hard failure allowed for EXCHANGE_ID that doesn't clearly have
> some other meaning is NFS4ERR_SERVERFAULT.  So use that, but explain why
> in a comment at each place that it is returned.
> 
> If there are courteous clients which push us over the limit, then expedite
> their removal.
> 
> This is not known to have caused a problem is production use, but

The current DELAY behavior is known to trigger an (interruptible)
infinite loop when a small-memory server can't create a new session.
Thus I believe the infinite loop behavior is a real issue that has
been observed and reported.


> testing of lots of clients reports repeated NFS4ERR_DELAY responses
> which doesn't seem helpful.

No argument from me. NFSD takes the current approach for exactly the
reason you mention above: there isn't a good choice of status code
to return in this case.

Nit: the description might better explain how this change is related
to or required by on-demand thread allocation. It seems a little
orthogonal to me right now. NBD.


> Also remove an outdated comment - we do use a slab cache.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 56b261608af4..ca6b5b52f77d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2212,21 +2212,20 @@ STALE_CLIENTID(clientid_t *clid, struct nfsd_net *nn)
>  	return 1;
>  }
>  
> -/* 
> - * XXX Should we use a slab cache ?
> - * This type of memory management is somewhat inefficient, but we use it
> - * anyway since SETCLIENTID is not a common operation.
> - */
>  static struct nfs4_client *alloc_client(struct xdr_netobj name,
>  				struct nfsd_net *nn)
>  {
>  	struct nfs4_client *clp;
>  	int i;
>  
> -	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) {
> +	if (atomic_read(&nn->nfs4_client_count) -
> +	    atomic_read(&nn->nfsd_courtesy_clients) >= nn->nfs4_max_clients)
> +		return ERR_PTR(-EUSERS);
> +
> +	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients &&
> +	    atomic_read(&nn->nfsd_courtesy_clients) > 0)
>  		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> -		return NULL;
> -	}
> +
>  	clp = kmem_cache_zalloc(client_slab, GFP_KERNEL);
>  	if (clp == NULL)
>  		return NULL;
> @@ -3121,8 +3120,8 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
>  	struct dentry *dentries[ARRAY_SIZE(client_files)];
>  
>  	clp = alloc_client(name, nn);
> -	if (clp == NULL)
> -		return NULL;
> +	if (IS_ERR_OR_NULL(clp))
> +		return clp;
>  
>  	ret = copy_cred(&clp->cl_cred, &rqstp->rq_cred);
>  	if (ret) {
> @@ -3504,6 +3503,11 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	new = create_client(exid->clname, rqstp, &verf);
>  	if (new == NULL)
>  		return nfserr_jukebox;
> +	if (IS_ERR(new))
> +		/* Protocol has no specific error for "client limit reached".
> +		 * NFS4ERR_RESOURCE is not permitted for EXCHANGE_ID
> +		 */
> +		return nfserr_serverfault;
>  	status = copy_impl_id(new, exid);
>  	if (status)
>  		goto out_nolock;
> @@ -4422,6 +4426,12 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	new = create_client(clname, rqstp, &clverifier);
>  	if (new == NULL)
>  		return nfserr_jukebox;
> +	if (IS_ERR(new))
> +		/* Protocol has no specific error for "client limit reached".
> +		 * NFS4ERR_RESOURCE, while allowed for SETCLIENTID, implies
> +		 * that a smaller COMPOUND might be successful.
> +		 */
> +		return nfserr_serverfault;
>  	spin_lock(&nn->client_lock);
>  	conf = find_confirmed_client_by_name(&clname, nn);
>  	if (conf && client_has_state(conf)) {
> -- 
> 2.46.0
> 

-- 
Chuck Lever

