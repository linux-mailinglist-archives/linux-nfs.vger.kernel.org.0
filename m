Return-Path: <linux-nfs+bounces-8032-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF3F9CFF68
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 16:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE878B21971
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A5914293;
	Sat, 16 Nov 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cT0Xsqe8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hiWArOGV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2CD51C;
	Sat, 16 Nov 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731769663; cv=fail; b=dMjgUo+dAXQa95LNEve91zjaIu78Z1Zdn3ffPkq0xSO89voEWLHTfimhGjbzPk4ClltVgSeK3+nsBepgmYk6mygUsUeOsPb+UEhXyxkOgn6ZteBcrIQR4qxEHXQBt7mH/Gz5G+Ftx60jIW5uQqTN6UqzJpOi/+AjenmgeJXf8vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731769663; c=relaxed/simple;
	bh=C06AvPzzhZDADiZqk3XU6rq+TE00TzsUbOThmYrwJWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ncv/RUFUDKGuR/Yej/PPVXDK5uGdNniz8GYxmi9M90TyMSXLQYn9opsITnv8YoZbeq+NctVwFB/MXNORGCtbGUosQUsQ5Dn2c6qxVyBYV22fY7tOf6vjnCplPpR7BWgaEOr4Wq6LF2LBu0EAxcXGYxOYL9ctB83JAnyCyVBBZpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cT0Xsqe8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hiWArOGV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGBoFlP003720;
	Sat, 16 Nov 2024 15:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=SXZixXO2Kidiptj6dP
	3FUZyZc5shPa3u/E2yJY358Sw=; b=cT0Xsqe8Hl+BrFZQlY6/TmEoHrHyMvONuI
	ijvRNzbLwh11+tnyVWZP1ExauoMn7TzdZ08O5etPj6mElE90mQzu6QT2zV3RPCd/
	ksRfPO9zURsge3b5hb/sh2fBYsT9RMv2x+cbwcYw/txjc++D0ff/uS/ybkCmzYdv
	ZxAsAQzEv6qhUiAlC4ynntDdgAqeO8ZH9Dpccrt/Q7GWFDarB8cIPOdgAAhsW+BJ
	L95n1ZCyOIPpfClu28m/GMTE9HX9k5CRElcRaCS7DuzVsJpITmVJz0stBR9+1vCC
	X8dh/cje+6WTTP9i+X883aV90jd/GS1yEL7n2Lsa4+7Q2LzHERhg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc0f7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Nov 2024 15:07:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGAa1YW037084;
	Sat, 16 Nov 2024 15:07:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu5ma9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Nov 2024 15:07:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqloAtxlslDmyy/VVz/pAghVZHH8MfgVtNNtnxv313SwTwV1q62CLj07jPz2bh1YsP/c7aAGYFWtKYtSoxl6qQ/o4Cmln6cFnaqnpltksKPIVp0C4uhONfU4waazcato7FaxNxY13KTK0cky8SRRHQVVSk0q78fDnFcMbtcbsw3TazY3JVvENV2Hrblo+rg9S0PXHGv+1yOR+3SdsWCs4NyDKpLk2Mai2evPDOKfkfE+kyzUbjilgSl+GDvjAb/VkAtYjyHOa3LBte5x0eCusuZn3GavaiDs7tIAX7e16+6uyB8/YG8p6Xogbl7nCrV77Jhm3jkLqer8Wrc2Pdh6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXZixXO2Kidiptj6dP3FUZyZc5shPa3u/E2yJY358Sw=;
 b=nmSJoN1v9DV4sTGnjdEm2dU/XCV4cS8ZG5yN9K45FxV9MXHvmMQOsTMzpWqbh1w1v5oqXAV/qQUKkqawO21ScgPLIwNDc3KSNSMaYgBBcoa6XcAw8OhV8lxWAMvhutjRr9B5K0v32TS71F5jWMYZxdWp+HLJ20UaptHTJWq0Q77qXJC79w2xkpZCtW5QC5qzyAkLO4whJr0afq9bInCKhG9Zh+jUnOQYiRSe4BVBnBYaePyMj3uGQ8iFl84CAelO1qPzRdSVjnJNsSKwNiWsrfvrjNjyawtZAz0Mk7hCb+ZfvNiG3+hT2XDpsiALNWiMw/0e5oT3Q5XSJA3pZR4U/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXZixXO2Kidiptj6dP3FUZyZc5shPa3u/E2yJY358Sw=;
 b=hiWArOGVCShftpiPtv7atg4DbL8cY1b2aegYUBAqDRY4AKvaHkC69ZBjEVUBgZ5aT/GVVf7XGaIMr9Pid9DJjsW+bHuQi9nwFG788rDi++bqFnWc62RFHa4Q0cSZy15RlJ6qcr0v1lwRmB22lTDXkz5mWiNzSY265YIw/nliawA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7361.namprd10.prod.outlook.com (2603:10b6:8:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Sat, 16 Nov
 2024 15:07:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.019; Sat, 16 Nov 2024
 15:07:07 +0000
Date: Sat, 16 Nov 2024 10:07:03 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Hugh Dickins <hughd@google.com>
Cc: Jeongjun Park <aha310510@gmail.com>, akpm@linux-foundation.org,
        stable@vger.kernel.org, regressions@lists.linux.dev,
        linux-nfs@vger.kernel.org, yuzhao@google.com
Subject: Re: tmpfs hang after v6.12-rc6
Message-ID: <Zzi1FzrwmNIMIvnH@tissot.1015granger.net>
References: <ZzdxKF39VEmXSSyN@tissot.1015granger.net>
 <Zzd12OGPDnZTMZ6t@tissot.1015granger.net>
 <CAO9qdTGLn6QWJg71Ad2xcobiTHE5ovoUxSqvrDDrE_i1+uqUQw@mail.gmail.com>
 <Zzd5YaI99+hieQV+@tissot.1015granger.net>
 <CAO9qdTEaYa639ebHX8Qd0_FqOZUZLc_JvYNyxepUthGyDqw_Bw@mail.gmail.com>
 <ZzeQ1m3xIjrbUMDv@tissot.1015granger.net>
 <b40e7156-7500-5268-4c3d-c61a6382d1f0@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b40e7156-7500-5268-4c3d-c61a6382d1f0@google.com>
X-ClientProxiedBy: CH5P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a57d53-ccf4-4c5f-10ef-08dd06505619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d67FZ7l8hb5/t9SX0QC1bwdz2laf0qmC9kRBoh/HT1cwxj+zAZSiO4thsIHq?=
 =?us-ascii?Q?98B+h90s6kjW/tfPC+aNmVkK5mCHrndQudEDDtBSuFb0WWgBptvDlpbeU3oQ?=
 =?us-ascii?Q?yHn1e+kWH0iw1xDnFj8qAxfqIt+znGlWYboziIihF7zeiZMmHQZ7Dk+CIcTM?=
 =?us-ascii?Q?1x6d6+WHjgpiA6za+Nfn8/gjp0sW/wwLfvsutmds38UEiUDB8dGriADPffR9?=
 =?us-ascii?Q?2hnAW9CqCo3IYM5gaTNc4e+z/9Pu3r9i3qemRI5h18C5v/Rjdfid+fifupdG?=
 =?us-ascii?Q?puVtGdS44aDxgict5HfvIhPurZa9iOzlZCRTuzN6k6Fbf0glSg3j473eX6yL?=
 =?us-ascii?Q?DPKMmx/wcEegr7VxZVbNeJyB6LyXtzxdAMf0Tla/MJ1zb4/UT0s6v+SG6tFq?=
 =?us-ascii?Q?31f8Tb/4LYY3xSX0rX09U15yGungV2OVIIDgZVw+Kjqy2lo2Jum6lKZqQwk/?=
 =?us-ascii?Q?1TWJFDyDsENIqV6aTtbXjYkfD90dZNe2do6L5EdnMy7KWVUdhv1C3LyXSHcB?=
 =?us-ascii?Q?TJKlbruEnSWaRAjT0YUlsvkt+D0E2ulPcEWayl3Sr1nX/ftKJOw6LMHcm+cP?=
 =?us-ascii?Q?jyGRybTSBzdGB7OEeYxCblFBIxvpBgc5KWued2+C7yullbvaBuOO3BjAx08t?=
 =?us-ascii?Q?GHLy9JMP356WHc7F87+m1e7alU7fpVpT15aHZ85AoK/nLV8r5JX84Ofxht67?=
 =?us-ascii?Q?QLCm+523jNyynihSJ+JQamlfQlTUPAul++JU6+t22U0e2lJEuuMPM6MPXVPj?=
 =?us-ascii?Q?PpqqhViQzPU/aPwMoyIB6rappYqU6p+EqvZR+FYQgt+LnbSjH0C9hK1uPmVt?=
 =?us-ascii?Q?7qH2og/Di+sL4zS6U0QVxjJ4PZDFbs4ID+mcqu/m78uIacBuiWKInoOCYuAR?=
 =?us-ascii?Q?Z1SVgXeszL5ShAjbZLBVzYVUevy/4E7PXQK8sdBuZlbzZH5+Cu3scIRYuWwU?=
 =?us-ascii?Q?me24+qaO8zRlssfEhZtZUn3nmxvpamq7uSC/B9UA5ITm4uAeh7vMb0CgjizJ?=
 =?us-ascii?Q?VJBHIYIDlryGidmCO3HyDMdASfa82/kTq0Y/HrtSEFuU2tm6nn+C8r94ziKY?=
 =?us-ascii?Q?aXR8GjiQXFhAsMiTIKx7MnZvruRjE6RJcYIDNRD32VRJRRFgHjcx8qHTSMcH?=
 =?us-ascii?Q?0L8KmSnnGRYkKJQT6hY95SLJL4T6v/CozInvHsE1Uwj9qQW4q1gZukp1XFMY?=
 =?us-ascii?Q?6b/Il6FAkxlSBDtDT4/HRQXVZGG/DtpwjuEwYxsnfFh/ViaURYPoMIu0XJ8M?=
 =?us-ascii?Q?SJcN5pMuTKsbE5oRJh1Nf5L+3xtUZq7/rVSB+xZLQTBdrli1AmuYSaxqLzVI?=
 =?us-ascii?Q?uSRpLXg1kcJzi11pFyb9ePKR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0okR3eBrKJUfooicYJlLMpKGqsr+qsZohaLW+FSclqd3iw+ZE9Ds8cimYvXK?=
 =?us-ascii?Q?Qk/rlJPqVsI9W72cOsNQpLlY/O8Lw/J75CWr30h7+CIQ/YkAamURHRcjZTvW?=
 =?us-ascii?Q?nXg4Vt9qwytrMCJf864bIfD/PmXowMY4/fJWWane9pFEVpMj8lQApxfEtlvb?=
 =?us-ascii?Q?7sbQjSDuBiJEXY0VLFpDkgrLLQM9EeKTOAm/A/zXStWUzy2nThBwHh7W4iJd?=
 =?us-ascii?Q?V2elJYXIKpuQqiUhIh12G4+oPJtXnor/hU+Sp7tdpy1ECktKfo0hzgneqp+O?=
 =?us-ascii?Q?HnxWFrRp9MNmy/ztwNHHtTJQF0ZKaGvIFGXKdgyY5uzZGbwOPAi6OfNwVFjZ?=
 =?us-ascii?Q?P+9kCQHV9uuKflR0WNHu2N8Ux2QMZCDtCdABPYGzciqHDmj2gYpwmo1usKZh?=
 =?us-ascii?Q?HvzbDdKQ+HKXmRMZpdHsOu3t+UVPcsgdDca74W0/fu8dvlzZNEYZ92vTJ59K?=
 =?us-ascii?Q?Kvod5Et8EHQi7Rt/s//tyniuM93R0LI2b77a+8mm7HorhAvX7xFW29QJZDK/?=
 =?us-ascii?Q?gm3VSde9eUPMue2TwdhxcNmEGjEk/DjihBkKst0811lIhj9yRZCoyERFqipP?=
 =?us-ascii?Q?Hl0cR2Df3rJrCGO7MnZ4OqEKcA0iYDhXXLdId3pCdogrt6aodBCARvGHS23/?=
 =?us-ascii?Q?X0TrfVG/fhEgiHBvurm4afqIWeGV213YdudehxR58qRoYkVctUogRc8SV306?=
 =?us-ascii?Q?EU4Mj5yitCuwfKB6TpgGyc9EYL+4PzTn3E85UvnNRe/WOWBsqJ+CkCc1T7H+?=
 =?us-ascii?Q?JwDANu3hXXz2ejmp7hlfZ6XUhLEKdQvGnW/DiTNRUccxtrz3O+We/VJ/VXr6?=
 =?us-ascii?Q?at/kLt9mgu6FtCnRZHc9cefy7dZjUwn34BrRMi4/tzoqRH9kaPuvN5AuYKE2?=
 =?us-ascii?Q?Zwj1nRWkeZcslo/pWsq+Cq1491bUrfV52LfTXbUaGsMDdNOEIMoPr0kBsKoL?=
 =?us-ascii?Q?yRV8dGKFm1irlEzUd2Pd5LiI4Uo7FCyiKFx0LonHBYbLVr96oUfTzBlyXKP5?=
 =?us-ascii?Q?PaBfuGfhBcWYJgv9RlrNcWoBcIgFVbRjVf8fwBJM03opT+6lbI7PRoN9s6JZ?=
 =?us-ascii?Q?+lZm1J038VTw2Ygj4RO1oFoD0c1OXgNmcW8miFn4/IvCU6OCW0XF4/7xnQlv?=
 =?us-ascii?Q?bAwm21TpUattd+iv+TTaeY2as+YQHngHNwJ7AV/ciaXYZfsoaFtE1Lo+XtWd?=
 =?us-ascii?Q?b9hlMKFTios6RyVAzyqqa3ysMRfcdQjQwpq+JC2WM+tsgHl/dg4gmf3ATXnR?=
 =?us-ascii?Q?+nzAB9u1jhpcZyZwPagjXH6oULyQwR2M5Xx4ByA+KZYthTKXZCpbIxn8CO+b?=
 =?us-ascii?Q?wgkup4J9SwyaRkHjHsjmnnAgrSCy/DHxlvdZMaZclccLYGNN18ZCh98pHoeI?=
 =?us-ascii?Q?eHvagfwTAxoDokdWPEdl+qZcoZV1prguQYm752IKcfQAaoiqYR4huvMjU6eW?=
 =?us-ascii?Q?Sq3Vv3pj+/tL4pxbomdENmupopSaU/qutiDBRs5MRptQ6Gky8op3Yrxf2qTv?=
 =?us-ascii?Q?QrtwijmXXQ7Sqmif5CNzNIDgSwuvxCYh2XFx2cpRtC6diOiK/47vmW7ahcZB?=
 =?us-ascii?Q?DuEOqNKEjxy3A0HqoDx9tKfiTR2Y69XpRZ2sVWVQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LXWxataIW4RTjiklLo8dBDa26brGQTBkIzuObyXGYhof8glm53KYWCP2ooFieY54EmWl7g84QF7hgfauAh/iWLye9SBr+FEOQVzaMPgjj9KUFzhTbk/QzD6+nq4B949/rf8UmUC1xzAxLJ7JtQvzGM17u9vbXrlNwcdnOeC9zpIr8GcmwfqccID1QYRtzjJf9y+g9Da7lQnYSqA9YxOKk/HVax497BruunAlHNSpSH6/q1ow7slCDW8KZXCmKEDLbE/+mKk8lW/9qTbSkvSROxMzDY3dLNtT2E36GkSRUyOtQnxOHIaC/9jVwSMYPlBUxo01BY4C3W+fyII88Wx2ESPz1OCWI5+3RGZqQlOQpDZaMgeFNKw1zl4nXIXq/AAWQYfqdHOeVWv1O2NtLlKQW2Ht+ZXtfcpCh8g8IvvcrCPx3oljIKoeBi+oZzi8l7bEu6c0NxDa2BaJvSvlQpzgO9lKuSsCWLMwp/sGlt0uszcZ2OQ0+EL6UlVryaNwXSOHxeCKYBvpTvXEsbmBvkkjeavvO4UBixjpDbrIk6d8C5zKUw0rQRZQiPwtvjnicAaVqokR8U4Aj3aJY9QuRsurQ2CMzTCdGL+29wj9W4smO7I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a57d53-ccf4-4c5f-10ef-08dd06505619
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 15:07:07.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A77C6dYRCOhponRLjfZxrdwKIN5fw4xdegVnQ6GNB9W/Eoosj9/ueNroMMaSSp1889Jm5NoebPcQ6SBkF2Pr/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-16_13,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411160129
X-Proofpoint-GUID: ozM9C3N9OJ2fOVI2CGy3eM0BJsRj3bQR
X-Proofpoint-ORIG-GUID: ozM9C3N9OJ2fOVI2CGy3eM0BJsRj3bQR

On Fri, Nov 15, 2024 at 05:31:38PM -0800, Hugh Dickins wrote:
> On Fri, 15 Nov 2024, Chuck Lever wrote:
> > 
> > As I said before, I've failed to find any file system getattr method
> > that explicitly takes the inode's semaphore around a
> > generic_fillattr() call. My understanding is that these methods
> > assume that their caller handles appropriate serialization.
> > Therefore, taking the inode semaphore at all in shmem_getattr()
> > seems to me to be the wrong approach entirely.
> > 
> > The point of reverting immediately is that any fix can't possibly
> > get the review and testing it deserves three days before v6.12
> > becomes final. Also, it's not clear what the rush to fix the
> > KCSAN splat is; according to the Fixes: tag, this issue has been
> > present for years without causing overt problems. It doesn't feel
> > like this change belongs in an -rc in the first place.
> > 
> > Please revert d949d1d14fa2, then let's discuss a proper fix in a
> > separate thread. Thanks!
> 
> Thanks so much for reporting this issue, Chuck: just in time.
> 
> I agree abso-lutely with you: I was just preparing a revert,
> when I saw that akpm is already on it: great, thanks Andrew.

Thanks to you both for jumping on this!


> I was not very keen to see that locking added, just to silence a syzbot
> sanitizer splat: added where there has never been any practical problem
> (and the result of any stat immediately stale anyway).  I was hoping we
> might get a performance regression reported, but a hang serves better!
> 
> If there's a "data_race"-like annotation that can be added to silence
> the sanitizer, okay.  But more locking?  I don't think so.

IMHO the KCSAN splat suggests there is a missing inode_lock/unlock
pair /somewhere/. Just not in shmem_getattr().

Earlier in this thread, Jeongjun reported:
> ... I found that this data-race mainly occurs when vfs_statx_path
> does not acquire the inode_lock ...

That sounds to me like a better place to address this; or at least
that is a good place to start looking for the problem.

-- 
Chuck Lever

