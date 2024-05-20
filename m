Return-Path: <linux-nfs+bounces-3291-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE938C9F23
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2024 16:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721361C20D11
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2024 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D888136673;
	Mon, 20 May 2024 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZTuZUWDa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NHbOYeDa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF31E878
	for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217068; cv=fail; b=g041b6BtO66YMGfH1dITZ7Fg1hSBSZWZpkGzmAMwjvl5FPB6k140wlQGtdYmwfjKVMX8I1CMRw5NnD32OSnMFiXAMDH/0A53z2/ZRiOtpaaMkQrSg/jTwc1f40SDCrIo6sihkFub1nmC35epi5ATJbvlJUk4d36u8w2cmN8SQgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217068; c=relaxed/simple;
	bh=ctKUedLPgPFcr1MRsbxzdkQAFwrSiH1tjjgGg7//ww4=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=LHJJaBU0rJCoAET4E+7rAH4P6QZ38aZftovPWEOraNOo+pfFH2jhEaLWU4nT1sftubVxOFRn49wWvb11nK/bpd8myel1cIDuMKwKFJ4tly8Fd05/Nv6w1HR3bBkgj12CxfM2MAyinw0EnCzuxaMx4mrY19E2CqLY2/NLN8/wm4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZTuZUWDa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NHbOYeDa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KEISQ5012943
	for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 14:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=NWfLMfHkYYVi35BbnoF6LVcUDUDpKSbl/evAiz3vLkg=;
 b=ZTuZUWDaMcSqdJgwfwZOdkpu000zxs8Lu+ojYHFT+dWN/w2PfM50gLrAeT+j4AHzGTKP
 PMSHCy5cpS965ugQVZ1UCPytwhdfnohUQuekTQZievSZwWY/8HTMP7UHM/Eppnpyj3Do
 UCOslATWnmjPDf+QmHXTE9VU4zy9vBGoxnMuleqfhCKzo6QJ+jB5S+BHF7QcQ+qvHDJo
 cPkgzUVCNjoJ0JoAcmph3UVZehPGCPsFYMI4hhxtreZ2MAr0DD2JKZmtO0pCjxU0CHzL
 L6EwNqQ2gkT+3a6aFxWAoLyI3ckm0oDFIoOKypozK7AVxDuFfaMv2dLTv3WOeKFW5tpi 0Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k462wdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 14:57:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KDZ4VE019529
	for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 14:57:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js6d5bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 20 May 2024 14:57:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxS90NDXTfK2Y0RpI5zQBfJldINe1tCzWbbghH6s3lUbSOOtjKDahczeTOEP5GfTS4SGll0y8YUvemQvLKCvkE+oncldakQSg+Bs/DHYrEx+U/F+0dWHZuLfg/OkYlJ41ZEYBPZHrtVzZqnl9no8uQO5syAPsjcD0otHASiTEapWOk865iv6KcviAl2MqewIMe9SDRgUvnRRyLAneXhoSYkvK2NzqUB4OnZztt0XUvLcHgtoDhWkx1yot2VZ87Cpd4Ftv2JHrfro6yt15zAq8ebJErYzMbxQelZ1vtABQsmC3Q6/F41qeDpU0yccrD5Jpp6MpagjJ898VsnrBjmqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWfLMfHkYYVi35BbnoF6LVcUDUDpKSbl/evAiz3vLkg=;
 b=m+6rGRvmr/SfouKRt+VfK0PaboZp7NYgHuXeKKrJ4FZnp2V/uKHRgrQHzftubEPOBCqIRE7r4hz7WzsAXk3ojwyxx0bGCjoG+g7gCk7AYCCZAkFRSPxg46IrQ+P/gXmvtvYQlMnoGYQh1Pn0JAra4iynhncDc3g3EmeoJ9LXvvFQujoxlPlwEgJKHfCLHEXgRYddB1IMVpRHFMJOi6SGNhM3sZWfWBOXcnaH+s4tpycldjLXao0rvNW4gamZ8/qCPK+pqv6a6SpCzoE73JRz5zOwq1jwi+98s2iGGzBkGMVnUgbaEe+JpoKYOO/Q6Ve5AlKAts2JWI9KjbNYlnJIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWfLMfHkYYVi35BbnoF6LVcUDUDpKSbl/evAiz3vLkg=;
 b=NHbOYeDaiUZWmGL3PnCueypLMqCXt08p1hps2MYQAMsNpSoM6EdhodBTh2v0pDZ4cHXffi62gzuqsQMrjcnvAaDJSElyKkNWg82YZyX4nsSsGl1bV+MiWZC/4D/Sxll/NBBUeNIIdsiyFOLDTK4BHQtUPXtCuJ6sApSOAnmU2ME=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7433.namprd10.prod.outlook.com (2603:10b6:610:157::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 14:57:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7587.035; Mon, 20 May 2024
 14:57:39 +0000
Date: Mon, 20 May 2024 10:57:37 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <Zktk4bffDPUe+lUE@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH5PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 8362e074-38da-4019-7d30-08dc78dd31af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?W4Wt7dy9rcYIXVN5NP8Zv0V+u3jPGYqkyI8JiC9TF4imcB0ULJQH6kyE7rXv?=
 =?us-ascii?Q?X6rSJ+Xd6sf1TaxURhooV9/0TPhPuXq9SERMGofggSoA9RqvANYbAStNulTS?=
 =?us-ascii?Q?TljefP0kAlkYnvDeYhbngL6XULzF2/7v6T6gB3D8cZ1vhvW3oEacleYMlO5L?=
 =?us-ascii?Q?CvtLbt2fR657WJb+9n6fScZRW6+I/Djq9oIETXDgbIjYTX7wuQJ2TmHZL5bs?=
 =?us-ascii?Q?pt+HzD6ZPsnbPWK291WchshWfN93A8RR2xR5Z/O2S2XcJQ9chBqQuj1jrTnh?=
 =?us-ascii?Q?4aymE+/X4tZLf2Qf0a4Im1JMRkQmJZbQhwZxxGImngH9nbE/nchr004BStZu?=
 =?us-ascii?Q?TWXna3miJHOz4W2l69oXEiCNL0NJKiNPyEF6nvcwatfaR7vT7N9C5QfSaZIU?=
 =?us-ascii?Q?okaIYLtWcyI6GaW6kOfT9vyV5gYSWjGDbJSQpeRSjW+PeqwoRvMWV6NvzdGo?=
 =?us-ascii?Q?wyKxVnrZrfhenNe8qKo05YpuxyQMA/YeY0oc1gRmxMBCa7hI67ky97W+eVgu?=
 =?us-ascii?Q?iAoFGlHVyTNHShJfY71tVZXcSDaw90SJV4T0Cr8Y01yAM+lYXN+Xha9ALwJc?=
 =?us-ascii?Q?KxRIimWJHxCapzIkpArSfVDdduExN0pQ/mM1iogG2Z6gLQyVgWUKUXqw8ihx?=
 =?us-ascii?Q?4avPMlEXCbmDDWmo0QWpPqhcKg/EpC8nW9TOr7l0B1vDaffsiHqHg/kV+s0M?=
 =?us-ascii?Q?uhGFYAVRnkz/IbkJ1kfuHC6CMCSk4aVtLxhSAUVMW8xJ82Zn66BOdortvHsr?=
 =?us-ascii?Q?+SkhT1KjWTTngN5moZHrO+yS3MtCadZurVu/QmPWVJyviFtQANJhG2s3XxZo?=
 =?us-ascii?Q?4cDLaLg7m66saLWLeguwoFmioiqX4k3uKfb0iUsVEn8rSLCUQwjq9C6mWRkf?=
 =?us-ascii?Q?RE0fhCfXaz4/ZtQu9wKd9ZXHunYxLYWQqwSmo8/X0r4xbuXuHLxtuH9oo8i5?=
 =?us-ascii?Q?9X2W9OC4OeGD1TDybDwGSCQJch4ptEOouF4ZjlyoLUEfDCrMTjYCmFhpJGWw?=
 =?us-ascii?Q?RBSOeaRAJshveMvRCJDngvS07hkEFBYyGr5QBQHyPT49aSu4y19+X/8i5NMg?=
 =?us-ascii?Q?7lmP8XV5Cf6KRBkHOC0jqOkin4Xwja/7MaV2LiCRpqw33Jh30l5Yv/GsbZI0?=
 =?us-ascii?Q?2CVysIy6pDH0IK/352GcG8CxnsUhQZFwjcOpDIbs5oTOSPy+H9UmGXrc4tMh?=
 =?us-ascii?Q?V2u4xj0chmnjKSrO/Z9avTmyZYGWyDkqNsVl2turVFR4ppZTTOzqs8Q4PIk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AjpniEe/zwzZA0buB+mHE4rXlIcKSLABdNV6kLMhCB36J/7F9/CvaEGGNFSh?=
 =?us-ascii?Q?cxOwnI1MS//0ibcLz7r/rBL6WzDMaPrMaXcPsoYtVIMV4KBsNAbmXVUmLi+X?=
 =?us-ascii?Q?TAh/5gDG1O0+9VX2yEt0gAQjUWPSV8l/zaruMsVoyajwuwEG28WiN7CpHxwg?=
 =?us-ascii?Q?jWGDRx5ogLQu9eU7Hof0EfDOhjAuyT++5bZPk346Vdl8xQixZ5MDz9ZkktHr?=
 =?us-ascii?Q?4TAN5RnCqypokNXt+xDyH/c4iuvae9DxNVDF6pGXrXMYg416/ETkz5C/Fjiz?=
 =?us-ascii?Q?MZVRYsdn6LPBPJmoNbbvZ3qcBybqxmf7Q2wmOCSgbG8etqP6hnQWY14kbXFn?=
 =?us-ascii?Q?VYLFCyN6H3aC8KO53H2MRgsg2kzHI40tRzhAeBPdQ2VWyPcpoLqrzqfpXtVp?=
 =?us-ascii?Q?f039fsR/dgF4RvbhwwO+EKvOl13KjD7V4/hTgGQBYB7mLNGNbo7f2426IhlK?=
 =?us-ascii?Q?io4HZwNm756RyyTOAPEqVE+vEOsYLX6EgJPE2p02rytVjbMVI4Ne6wJSn4HQ?=
 =?us-ascii?Q?wWm/o/nFFaVCbREKrdYpZnShAhNi4xIhoRfnHfIky8/AKTAKILQZhI20LsbH?=
 =?us-ascii?Q?f6bdxILeekl0chxybGezIw5/neHU3+VfXi3aiUCy9Ercx+7IAbPBzaY+IR4O?=
 =?us-ascii?Q?StP8jLVp4tV5fAVpfGQlCy5fmu5r9cUlhHC+3UVxNCyIwiBH520OechkF/RV?=
 =?us-ascii?Q?2Lgc8UFU+bHGpxOIpssD6chctDumnpT+iivojxC3RMbO7qGbJaYbpNesTUX4?=
 =?us-ascii?Q?QpFrdeH7+rMM62ZXjYNUJynCLC1qoPIj1xBSfXs+8ppOOfB/O7lAFMmF0nzA?=
 =?us-ascii?Q?ehapLhoS8wxeVk3qsLUC2MJ4L5zUnz8ZzcNWhl64cUg7FnP852HoOOZt5mpa?=
 =?us-ascii?Q?a27uvGM1IflN+LIFA5GkFktzxLhmTDgMQ7El66i8xk3b+dRIHv026ALaGuFC?=
 =?us-ascii?Q?pwwWmFiP4DpP8BfHXwlQLqW1tXQI6rCdUYNrRJsf2Hfg5FImqyeSraKrZ+XR?=
 =?us-ascii?Q?cC82EfZz6r5FbOWE4Rtoiy34IDa+cmvD78GW/lnDfWfu+zBxeSMBxv7R7Fpr?=
 =?us-ascii?Q?Gl+fGgk/cD8RiY8mMM+XvbTpweiDifdaAiBEBYIKbgao2XPlttZ+VgTQj06z?=
 =?us-ascii?Q?/VtBBWwXKfCLtVcTW7ag/HxYqNzuWU4nkltr5w8LKNmYdg0IpM/9EDSR5h2X?=
 =?us-ascii?Q?3qiGvBM5hfB4IzRLFaIIvXYmPZ7Z27zvBN0QDCfJjzB3zjIqRekqYSzjsGHz?=
 =?us-ascii?Q?hvrhY0ihBbT5rdAft38ki74OK0PR1nuo3HRNIpsF1n679RJE084z6/V5qBjh?=
 =?us-ascii?Q?KvxJg7CapTGpZ1qTbIarluon2vB1QYMtscxMWnybcIK1SNzV74ZljrOKI7Ys?=
 =?us-ascii?Q?NEEmqoTUWpk8ksqW4RT4FLmy3r8CkDe3OjqcYI26YPoL6QwYj7mIGQFpjAYb?=
 =?us-ascii?Q?eKgjyn48424i6RbEKrJpNOGTrY3e6erXkS43qUkBjrvmejSxqyPG8q9q3XQR?=
 =?us-ascii?Q?tX7u5X7Yqp9Er/dQUTrMF3VEqiWMiUlbJZ5GDILSW9b4lMrtVfbHe8ts+loF?=
 =?us-ascii?Q?iN3WhnapZ3U7JRzZESr8/8H68bySu3hn1Xe90khUTIRktFKrIJtmcstiz6U0?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZDZjJpqodsotpDLfksTSENP6zEhmmM9ea397iji7VFaoAKuJYBJ2bndrEtDnirtG+0XPlDpX75TovC/ys4K6xETQ2Sw9eYGo0uUgyDURjBqZduzxfIgbPtr21MWKiExEb4a/SkRomuJeLdXrNZl8M9KLjAaRa6vxbOhGiSRoIdXBzROSF8wScAvszAJnw97X61SqlDg93Hx1XrAc4SVFKvfx21zojtdpyVMZqoZyYOfiSEoJggbg1OTZeT4cEvQdjVZlWKHTY316FI3uLvUyxBoCuY3TjFMm8QVVgFTQjZONs5rkiTc3VsJrosXJ/v4h+hfRIBlFEyhcbEkfqEBwaM9Hj9FxffkOu3DlgWG9fz5fcXwr8Y/xBTU99BQJNOecstZDFeyDSpefG5CYor67jOBWX3oSc6K48lAAB4rCLfC1OzH2RPHGreabBtx6EtuwuC8M18KOgezj7+9u9rmit8BZPR7jUO4GAoubj4eF5NJDSDvXSJkXyLgJh18XSHaj4EyGL3n+OmVCOOmU7qLgM8Fq3IfCOwYQOtVvEEwebiTAFEDQp4MCfCS9D+wwSnzen+JiXN82bc3Pnw1FvrAkTBYrH7ILpM8JUTlZRDiX09o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8362e074-38da-4019-7d30-08dc78dd31af
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 14:57:39.7274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avjBxhpkPO4LJWaC0jX1XGGWlsC8jqzYtnpaHnkGFwV5QuNXjYQaCVZ2KE6OWTNf3YTIxouPF5mCJKdGgbgGgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_05,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=816 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405200120
X-Proofpoint-ORIG-GUID: dVP35C0Gc3Z_x46sB3tZz2qNq3NOeK9Q
X-Proofpoint-GUID: dVP35C0Gc3Z_x46sB3tZz2qNq3NOeK9Q

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. These backports are destined for the official
LTS kernel branches so that distributions can easily integrate them
into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v5.10.y

I've found no new issues in nfsd-5.10.y, and have continued to
build out automated NFSD testing for this kernel and
origin/linux-5.10.y. I plan to send this patch series to Greg and
Sasha once the v6.10 merge window dust has settled.

You can find this series in the "nfsd-5.10.y" branch in the above
repo.


-- 
Chuck Lever

