Return-Path: <linux-nfs+bounces-6054-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD7696644D
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 16:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97F21C214B7
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBD41B2523;
	Fri, 30 Aug 2024 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OoGCC8Rc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ecQHAcAB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B61B1D5A
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028729; cv=fail; b=KeWxRhdAzdagrJY6xv/FgwlKVa9W8qns9DZUVsEDdr6twa8phypL8AAtvK668vPiyWJyl+I/qkPLj+1yb5B7BeS1PP0Mlt1xMIRG9n+5Q+W7JobbRH0/TJNhss5RvVttxa4kaQtN6KhPDwfMy1ObBSPVperG9FHa+gX5AsGQw/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028729; c=relaxed/simple;
	bh=R0DvBqbatnzeN1JdOhmWV1b5m76EWZRnVkK3IGOEclI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=alR3BgpxoJBqegkmWV1m38DZm4yv0YhKWFcdvtvWjfVUjtSlTxerHRZGkpvl+O/rqf+DKp8f8Vfr49N2Z2Q78MsozoEdjpPeQUMfC8SqTC9zeaf4yACKWnrSGWeSLEUz+er9MpbdJjM/hk3naqkGw30zSa8FP5iIXe4tcgRQdSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OoGCC8Rc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ecQHAcAB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UE0YID024991;
	Fri, 30 Aug 2024 14:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=EP58I5ihLwYxlyA
	NE0fDZavUfSsWmeTO2x/Ol18B/HY=; b=OoGCC8RcV14g4vogreNPjh3EvRrH+78
	DJxWXSyvDvzhNpNye7Lol/oc3gf9T6J2D816o1dweJ8+pr0eWQZJbzugvMMqDt9m
	nvvHAUmZIHWyHrge+2lqUuoWKCQC0MHd8tGw3svs3Iuhd8CAKDHhYKHU3RHjvbt9
	dc9LZZYHst5PgQXQEtH8cD9HBpI0KV9UhJFsgbdckgBeDt5VcefyTCuak1KABxxs
	nVaJtn/5txtF/qBeQyVQyj6dLP4BTah7rvPbrJwK1+ObpDUZkLmKvwW8x/bI8nB6
	hyG3KPcguk0CcvfG0GhULnJTYv+TaiYv4qHBVPjHjlaP1ZWLOQwE9zw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bfe704j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 14:38:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UCqVQX020166;
	Fri, 30 Aug 2024 14:38:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8rw8fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 14:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZF+3HaIBjnD/TSX3AbnTDNaGMzF7AliDxt+bbo5/cUFB0MUUufviwdWj+FqgumYtmO+EQXszvkfMLdz+HzdtmOKzPZ+DcfQKePkhqiWK2jSOuMgdMDeULByCM2ZY8Cs0RlWVILuc+El+KhaLAeNZUUODNW7WMA1goXYkrCONGAPK76cmZtLh1OQfxNu4Nii1QrKMARs4Ii2Ry63GJiuYPEZNDfiaZp7DAduS40gl2gx4tnNfhq/mmPkSOQmAdn35X8ycZGOKV5vCtpcA/eKZ/VruWIzqDkX0tuGTiMQSBuAQIxjoDMSMZeK7PuXNha8ad2gkmzSEevDfn/vW9sfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP58I5ihLwYxlyANE0fDZavUfSsWmeTO2x/Ol18B/HY=;
 b=faNi29IssMVzFAuCFpcV1an8U/iQZCNF8/NHtG0FgA8VzpJCPvSs17hCllLtrQmBbuliI36qG6E7uG38aJfwqKfiprwiEa5/Wxatrwp06oFqDhLsvGhhK/aSN4ro2vWs0J589ihwS++QwOnQN5Z/ThIQEToK11bk1WlFXKphDueY/7HdxFUAxQU0F+R9NVZ2mN1mEJdRFpVhjyi691SAmXANd4rGKSgKin4DRokkG8ToDztK974kFnkIZukZOBd/1pV8mfan1kreSam9c0phCLRiN98eZhYG3DQZq3y6q6ItokE4sxPC3hFLCm0uxc0EAqGgUDZp7CLr1jk4wTGNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP58I5ihLwYxlyANE0fDZavUfSsWmeTO2x/Ol18B/HY=;
 b=ecQHAcAB+m9dOjXcqCKHq8iIB7sWe4RvsPkYK3KF7dv1PX0ebgypp7dzLzjuSGodiyUKJkJiv8FkpsLelIHk/R9aE0oKsqGyLrEXGhsj/MNaDzhtVmZ1wX8bHMBnaRJrIv9b8OwCtGVf3J8DAupYe5MlAyFoSw3Jw8mqGqRrxrc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB8048.namprd10.prod.outlook.com (2603:10b6:208:4f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 14:38:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Fri, 30 Aug 2024
 14:38:38 +0000
Date: Fri, 30 Aug 2024 10:38:35 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2] nfsd: improvements for wake_up_bit/var
Message-ID: <ZtHZa+ww1Ec3nkxg@tissot.1015granger.net>
References: <20240830070653.7326-1-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830070653.7326-1-neilb@suse.de>
X-ClientProxiedBy: CH2PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:610:52::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 87173b95-6713-4df9-cfa7-08dcc9016f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cqulrd9qF6zdnDYgdAyDRYcD3+SPuLCdziIWWamcs0kbMPNxhr70P8UEK2mp?=
 =?us-ascii?Q?UebMV8ZwSGhG+jT9wg9ivOKbLsd1vLge/ve7S5Xu+Dx1d6ZqvRrFozfnhoJ6?=
 =?us-ascii?Q?JM656Ewdb27NNzcjTqE1OMQIvDxuQ3ZOoy4r/gkvyLUgHE28E/DlYFzZs6wc?=
 =?us-ascii?Q?32oDHuIPWQYn/2iBQ9P+CBkw3QesU4c2k8Y+31APl3Ir9+PmMgATIojgRY0N?=
 =?us-ascii?Q?TIraOkJsK1R3O3znw8Uk66HRN2D3NcctpEwfmZpfn8PfUTkMR+i1t8w1d5YE?=
 =?us-ascii?Q?re6yWjcXjogyl714eD664bN/z79/UQB0CT1pCJd8gzvoBjpVHNpS+CrajtLg?=
 =?us-ascii?Q?GU56PLEvXiw9BiVnYnMiVtzNdRb+DorfHURLKbnxVrEMkkt9ASXAMlNf5E3X?=
 =?us-ascii?Q?yFhkmHgFhjns5uI97kWERliXyO98RlBLN5mhOgU1xgDGHYBRS4TLEF4SPgXY?=
 =?us-ascii?Q?f6xOkUthWyHme4CdKGz5Mu+URABlvIw88eVVyD3Rl+bmME7uf1xSnuJGBqCw?=
 =?us-ascii?Q?x/JG4J0pTUmqSLcVGNubKfxVbfCeZtgMJB6IpYkkMZxWikjItHvhNRvzPsrp?=
 =?us-ascii?Q?VLRFuH5VhS+dySEydjqSDwFc+iWybWnrDbEf67iQPpkYeqYc7EBc1JLVBXkO?=
 =?us-ascii?Q?XQGikcInW8kcKT4xniCB5c7B+xrGnmU7sIDBs8UY/GZBChyOvOYrylM2NxRy?=
 =?us-ascii?Q?aPzl5BRUocnJL4tSOKQ35mWUDc2uLKVbi3vP/e2PNsZgiM2OXoMN/OnBFWpJ?=
 =?us-ascii?Q?ju/4Fgeyz5HdvopBgEfPBhyuiz9PeICYbt6hPOIFPh4LQhdDJ7bA1kVUGm77?=
 =?us-ascii?Q?32c5jj9SxE6APX+EouAI9Cv76saus13b5487CAyX85mzAOKrzJPFrbi7RUKz?=
 =?us-ascii?Q?gIowPWhF9HcrNfZd8w9GKCPh1HpkZmZqz53SlCUSbG2PlMmiVUL2AHEVw33w?=
 =?us-ascii?Q?gRRwMnzz3UV7Rr8Pfvg4e+1wMtdw7z5KRRofn2I44AqWv9J48f+HlXHoKP0A?=
 =?us-ascii?Q?5K1nUW00DvR6JkSWT50rhYHb8gcKts8gzRoc+74M3S1k1sVl5LCGp4+Y6cBG?=
 =?us-ascii?Q?OnWvohTlwehpbAHvLbdd37ZBPqUzTnyJDh+KLWXHQdD0vf+kZsxNwoiZqHO5?=
 =?us-ascii?Q?3CsJKexrXA2kUmgn2nvzZwJVi0vYYpq8S8LOjGbCJvQv4ejnJL2ePMU0iMe5?=
 =?us-ascii?Q?SiwIVfZbd22kEyMCeHfXbdLGnxD3V5XAfwaHHROfN4yGqwA92bFsy4qeJiCv?=
 =?us-ascii?Q?xskwyF+SUujGL3JV1oL/RAauF6zmiz4FhCP6OML4zIFK23RzbT0nrfyYLPSc?=
 =?us-ascii?Q?/mmZ7elnAzQ7mLl5CG6PzatHDMazruA2mp7qt+yVzv9aUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U3u7u2GaGYeJ+HL94FUK8iBAZGmsPAHDbOuIl2XMoI1OjSrKg3VCKYU99bc9?=
 =?us-ascii?Q?JnRRLI1pfMysGgnIx+i6P0D7qw9+gDOCFhC4iM+z0KECMH7lPzC4BPxf5YfL?=
 =?us-ascii?Q?apY7f0/xs5ABwf7MgujlOj8L4fOxTK8bGBVYRTxcUSbz231HAEIKOGvqbBlV?=
 =?us-ascii?Q?BJHkvzc98fa56qsD67y7nfuPk1iTWD6KyJzk72js1yqLfA5WdJI/4zl0rX1h?=
 =?us-ascii?Q?BX/Zc7E8Wuk2FCKHsxP92VNKKhN0/EpRoXAut8xSEjYCiYK0UVRgn33h/8m3?=
 =?us-ascii?Q?jynHcYmGEVaRW3LM5a6Ko326XUJQ5gR5zIr123ICS13EPPoHeL6brykh0MVF?=
 =?us-ascii?Q?fWLQM3paI4yb/2t7xJyNoQGxo8Spsr108alODUWKGbm5j47T0PDk3WLRPQ2y?=
 =?us-ascii?Q?KIlY/u34mszfla3phXwbvO4Fv5lesb2TjCevKBcfZluDugNAxeH42WEAqc26?=
 =?us-ascii?Q?dXKftGidZ3QXl8cK7hP6NKSBtuZgWPam/tCL8sVBCzLDdCwYcS0+EIFH4EyD?=
 =?us-ascii?Q?0fa1I0rPKUEQCBS9YRctW3XeWMO0tRSv3j3z3q4cHTn3hGSwwWjuer/2MKV4?=
 =?us-ascii?Q?8mJmgXkOvb0mTnVPjk5cNj0Ggcb8gwZ9bGaVQoc62LoyVgrkqUb7y1ww9nO3?=
 =?us-ascii?Q?GSS1UrpqSObcWnT3S+3dmqdGUtDzCWnxmwuwjMjChYdYWFy8oYSieDUEF67j?=
 =?us-ascii?Q?gNqjk2IGAsExJ2qo8VbFbTyOfv7Kz8RIUgpRm6TG3lwvu8HGSo7Lri/AuP18?=
 =?us-ascii?Q?Zgy53mC19BZSIfryLhMPexdPwFLIfeSOHzXzs3cvPedcywiB2rdFJuO+FFVr?=
 =?us-ascii?Q?zJLKWJtCwa1mQ7LsbdF1+XeEuY8X6/UMrTS/m2S0QkHZN+qydRw0N0jHchun?=
 =?us-ascii?Q?enC+p+QpoypMhZ37VGPCD5ermdgv0q+r1De6RE5EA5cikfHtSdSrkcO+ciu1?=
 =?us-ascii?Q?RJFN8P7KpJeDiJauBgioDk3gupcMl4ZpIxwPNk9CbhGHW4gIMNbA0netmZF8?=
 =?us-ascii?Q?Zm7ipSMF6qZGA4B1w8dmlG2BjymyaWX3FoFsdbmX8xqIcuovgqqegfX4ilW6?=
 =?us-ascii?Q?YLbm5P4hnIdpVpN9Pu12QZzfim+FI3zC6NJe2CBIWa3N7jhCrbyMWeGCqzSN?=
 =?us-ascii?Q?uA8figlrU6B+MsQS1BqGgU1zadSZH126ZnMrfjBYPOdgYtHW0ZAt4wdGJW+z?=
 =?us-ascii?Q?qZapIyqSOZ38Z8jq/C2tCFDl70I2dXWDpDx/SYBZmyRUv2uLPaLIQj9nKgrA?=
 =?us-ascii?Q?7mYbO3r+97bbYH04v1cm6UqVrXw3o46/9OgC9Iz+59UIdzUNOgWZrunF4GIH?=
 =?us-ascii?Q?nEfsszXvWY0X+AwHv5QE+lMVM4Mce6B95H3VIv+IuD9XeoTU7KutIEzYVRzg?=
 =?us-ascii?Q?ofoCU1akQeHZeZvwzC5esoceey2fbIuc+A3E/tqao/4g7W2QRaB/r9XPDfTH?=
 =?us-ascii?Q?CtUuH69RxRIJVEAY8JuJaDJRqoF71Vbc547LZT2gB5Ej2kcWXHyl39pVqGAp?=
 =?us-ascii?Q?mTo1ZS/NJ6eJ++7fCCEJwnp73tBVkmIREqlIqxk6oPffxfnUJrfhWSUNSBNu?=
 =?us-ascii?Q?HqurDW/fLdgZIyQ2oX3ufe6aWRai9l9q1ls23n2KjFYcpn7XSyWo9j4mT9aW?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ak0DfM3eKwvOk9AKrgthmMTinqwFLVFnOoGFVtc6AvBfsJ3W2XG8sYGoDxcMbiEr4XRTvbnJOTP0646TaqE1nudkhduJOA3D0HGP9nbffC2suRGCBNyBnzKErVTjmNPk092oJ/+LOc65IwwGsTmLfxrao+Xdv9T/TILAiEwpzyA4Q+YzD02CcWISLvHZVPAMO49St9BRV+/hMM5m1WxBLJPR2cTG/4FemzzkO4Ba9rcvIFx+ukp8Rsk+YaqVj1Im3QhjCJAnqpvykxbb7aGIABLFBUPObNV+fIETCJcYgeMb9rrtF4T43PY/EkqQRvLW+vM9ke9M4YZc/hC7zS5spOUzllkyObyw/NILVIxOI7DV4SNjhiTUSrWOoii/cAUAlZcr4BD3npMK9hqVx+cIeJOI+LRc8s+hA8BsaPBHsMFsJp/DURhTtIEvIDWm/4bFdi/j3IIa1OwDoY320OHNdIoww+w/xJVQTA133Yw1nwrWbab7EeHgLg+2W3zvNs6bN4dtGiwLcuvejQrZJ44O7PXZTZrql99FovXgdr9xhYrqj6gPkh+eIIyPeICPiKKhz1Tw3lFK/yOz7zwrYPftm8AvufWWcA/gALTWnCOoick=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87173b95-6713-4df9-cfa7-08dcc9016f9b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 14:38:38.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVkATN3VJshLlVV44vq9k7wCP8rtnQTBND+/rrFw3E0TUjhDzGvKnXJc6zCdoLe+BqE8cCQPukQHTpFvs/ApHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_09,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=943
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408300112
X-Proofpoint-ORIG-GUID: NU95F2C2W8bQRlxq6kSxYf4InbZyNsdu
X-Proofpoint-GUID: NU95F2C2W8bQRlxq6kSxYf4InbZyNsdu

On Fri, 30 Aug 2024 17:03:15 +1000, NeilBrown wrote:
> I've been digging into wake_up_bit and wake_up_var recently.  There are
> a lot of places where the required barriers aren't quite right.
> 
> This patch fixes them up for nfsd.  The bugs are mostly minor, though
> the rp_locked on might be a credible problem on weakly ordered hosts
> (e.g.  power64).
> 
> [...]

Applied to nfsd-next for v6.12, thanks!

[1/2] nfsd: use clear_and_wake_up_bit()
      commit: 2b9a19d16beda1b2ca5edab47d74b73d4d958b12
[2/2] nfsd: avoid races with wake_up_var()
      commit: a2bf7d13821603fb90c3f6e695bd5fb4ee19de71

Both of these patches threw compilation errors. I corrected those
issues before applying. Please check my work.

checkpatch.pl complained about the lack of comment on the added
barriers. I felt the code was self-explanatory so made no change.


-- 
Chuck Lever

