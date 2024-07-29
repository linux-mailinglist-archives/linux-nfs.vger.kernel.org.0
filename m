Return-Path: <linux-nfs+bounces-5144-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F15793F85A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 16:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE11B23066
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 14:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9798315535A;
	Mon, 29 Jul 2024 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SqJLmnmq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iLRzBqTz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E768D15530C
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263782; cv=fail; b=bv1grfOoPrlgKcKepvW6CSNCb6H09IkwICkRru80kltfDDBCamuz53VkolAHGID70o8kKXgstQ79Y+xTwXLYSrG/D4ArMjtlDORR/rr1nZOAwUwhuKr/k68LBzH3Dp2sS+XijB6g9k1Z6KGdv9J1cyvew0VbGHqIbeOGviw683Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263782; c=relaxed/simple;
	bh=NgY3jW4iZIDL7ncqHiSiQyPsYigcCp7BB7Gaemyagas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CEbOQO1neWeN7BT5WYD/NkmjSb9jEysCPY5h3XCGy0tSaYavC2opZe/b1ke0DqZAWMT5sA1nvF/l4F5dQVIdgAk4a5Sh2rqxTy+FZg6+2e9+osUcJqJ3BrVKLixdj6+ddTh7HeJjbG0ojJ7zwBwe4QQRwbu449/Zo0SnohFY1OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SqJLmnmq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iLRzBqTz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MbQM028863;
	Mon, 29 Jul 2024 14:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=pxycBREz+LEjold
	J276c88Hve3gg5Mt6bn0obol5TCc=; b=SqJLmnmqIa0Jy9v+vh5gpnApbH+zv7g
	8iB+8kQbhQZCr+yCTAbgd0VomHjEpJ1HuA6p3/olccQFdSSYft3OEwMuCN9SI7vp
	NQYS9B0nO2yXvA/MwOOxLf7BoPk/ESUjMMmGgnjifoN1T6Au1Ol5Pj4m825iLNdn
	ZLbTTKb4sm+GhxKoY5ZpFLN7ta005BQbjMoVFOLI+r7odDFAtvqcIfBfCJI+Piu8
	/PGH9bHrwYNlUDaHAU64qspXULXh1lc5TOzGFilU5yDB5jcGMuHu0rkylNFEqFzZ
	c2pXRjs4MrJebbbxpr0kMk7OvpR6qr+2kglk6VDx0PgM2rfDv6ZGuYQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrs8jpys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 14:36:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TE9KUg009279;
	Mon, 29 Jul 2024 14:36:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nrn5wj3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 14:36:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6OLAvZ8u3eafOg4T9K7RvoRbcXnYAZJCG0Tm+uZiWKd6JxEqt4o3l0HqoAEuItomVBNrmghG4yp2xWECoZYWexfCSXBQMIb9mJdgvXhaus+BylfluH7HzjfHxnM8UC4ioUrzmwn0SJkQNcFkoV/GlyNlrUN3q/2vUrYg4DNu+/UMM4hwmka79fEeB7XZTNe1sKR8tVfPnkqZkgWiFJpV8rnxTwMuqzj3Ys9s2Tn1cj+rVytwwsCigzvj7YwKgNierwO6NgFAVeR3EAckr7MBcdcNxf8JdRndU6jd5oK7G5jW+BqIDvn0yNE1gRFLN1B4de38TMyTVpxQLrTTgFbig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxycBREz+LEjoldJ276c88Hve3gg5Mt6bn0obol5TCc=;
 b=ppnJd/RnMgDSw/Mk54+oCF5ydcehPIlR1fJap2kcgw8l23fmcBaYcaBBunvty/32RTGC9oxK3fC6izVElW6LDCl/+appbeGNOV//gioC/SQKVuvjmC2PUknTFHzw4IGMDUhoejt0B3LMSUrtUDfB2DQre9sqJvidvsm1dOkwMfDvt0NHVy6O2cLmn+161dI5HJc9nuUmF1boShs2h+WbxLhKs48Ba8oQdsh4hsqJW1DjNAAXh+nIUpAZ9m+Ps5pm+diwx31MLU5XAKsBcqXDpmK2FDzjAr/Sb5PlwfuCjnaAVmGVyxIYF5MjmX5qqblR26K7H8/Z67pjYcKEitNqFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxycBREz+LEjoldJ276c88Hve3gg5Mt6bn0obol5TCc=;
 b=iLRzBqTzs3StMMAIPmScGDIJjCGcA+x9c0KuWIaQvW6JS08HPpqjqfo/oi3nPhRaPkpUotm7q2FuXq8MU9rXsnZmkh3mNUGCm/jvHomKmqb10dcYhYxs73Ek7l2RvAVvI4SdNpbUwHrunMjp1+AfH2+jQ6Or95GcWUrqwhM2Mgc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7296.namprd10.prod.outlook.com (2603:10b6:8:f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 14:36:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 14:36:08 +0000
Date: Mon, 29 Jul 2024 10:36:05 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/2] nfsd: fix handling of error from unshare_fs_struct()
Message-ID: <Zqeo1c37E6xDDgSA@tissot.1015granger.net>
References: <20240729022126.4450-1-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729022126.4450-1-neilb@suse.de>
X-ClientProxiedBy: CH0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:610:b3::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: c33ea7b3-3ce0-431d-09f2-08dcafdbc8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pdS1yPF8f8jL3FckX56COaKzswiG4YSPIeP0OAvZ3tiHAF0mxwNVmgb4N7FP?=
 =?us-ascii?Q?YLZ1a3aNOA9e/3cN7QKTjpB+KXDTrGFuo8MMh6pvXN9tKtk09+y7VqHNVidc?=
 =?us-ascii?Q?Vl3L25ltR2ryQ2UfFADK9UBJUX733BHOre7nLrNL2/ACgSmsNO83xsEfVy45?=
 =?us-ascii?Q?kmUxTm+ynDZQwTI066CKeqIw5ORqCOE5b3NnWKIewBgT4TotoaD7+8NEdZsP?=
 =?us-ascii?Q?GB74zhyYPiIxvRhzPrQn+ReNKzBRr7JemaWLxKew6+KsFBYpLEXDZRRaOtl+?=
 =?us-ascii?Q?zvKIj7CCNbbYLs3mqheiSwaYImjzY58cX3myEpVhKZF+V0mWqL60aZxobfsi?=
 =?us-ascii?Q?GCoSVLfNyKqo/bM+DQiRau0U++vX2zj6DvqZM1YX0HZRFHY+/4vadrjc5ifD?=
 =?us-ascii?Q?5Zuy1+OfW7QThgpkxLgKlBeA5qkPxwlHOxrIAI4FDjgmVhPlVOT8R2KqHxzx?=
 =?us-ascii?Q?9d6ngTeiOQ32UUYoWI2g9mVPivVr3Wy6nEWKurW81gjlVSTbM4D284sko6ah?=
 =?us-ascii?Q?Tv7SA7U+hx0x7SkWfgnbaRI3nsZgz6q0XyHp82c+5ihfKyuOg4tBVMFhnlDP?=
 =?us-ascii?Q?eH8erlWgtNZBSwc8h1OKywEiYhDQa7yvTrDjL38CUVWy63IauZTRreI1qDjD?=
 =?us-ascii?Q?BiO5NJB0KxV3spKEBGIY77EpotTJlO7vNLGmGa35Gj5uqvDoL6Ea1TOU9et1?=
 =?us-ascii?Q?rmcAgN5vYCPT0XynQc1ZPNPgyRc+ACE/9fSYgZTCW6LmgQ16j81NM5u6ZQzS?=
 =?us-ascii?Q?VlYYDQoYcj6vIj4JwDyV12fQmNWnjGTVKTjlteCb1uc/OU3HSVscImIMFqjS?=
 =?us-ascii?Q?QNR+lmtH4gNp8gQJ7gOvgePxNjI6lAEw0pJQLPjwLJWeE6nm4OChcwYxvcuU?=
 =?us-ascii?Q?8JJ6yK2tK5pgIk0p75gdbUfCfnDxLUbfWK30pD/HgJnahLO+hvYYQ9YKC0wX?=
 =?us-ascii?Q?sd26Ch/lNjI0Ev/nlVoLJ6JS6DA2Eng81SPi9iF3OXPRzfQE8Gf6jQtIC/TP?=
 =?us-ascii?Q?NmSH2KtcobQcnHUghH9o+sGJ/TpY0Ggcvuub42goAL7YY0tFV7QHMWhZqmfM?=
 =?us-ascii?Q?7UEGuVhJ8NrbWKAvwVJBVFPzS7R0HSmdRogEpxN/5Ani6nD+s2pDjX+hxIFB?=
 =?us-ascii?Q?VXPHXhONmY+5CmkNwDZa0Fx21NurVPBAPwsnpF6e0amqdJTb2BUjVm9bYagC?=
 =?us-ascii?Q?qZWlESY9FYpxnL//LsC6KqQESC/FNuWODJq/KHrqqjI7nWlUWf+uD3QfSWiB?=
 =?us-ascii?Q?6AVm7XlQ2/+OXIods9Oj2D/KUrhfuIVzb5o+hGuEuxvqnMW0lUwlFXA5dzvJ?=
 =?us-ascii?Q?xnwN5YYPwJQDJ3PVdRea4zM3QGD69z+c+uUSR75aZUQvKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GsFqh9dbgfse2iOsWzZpxFIUUiJp9ocI9AcAHp8yX6HsnqqWd2JzW4vivnYx?=
 =?us-ascii?Q?7ORL7d1tcCifZZpw0flUJG5e6kb7sYYHz90NJ0+FKW0o3wR9lTwaoRqC8qfK?=
 =?us-ascii?Q?IBHVBKJx7m9Qq6LL2DZU1CzVulvs84/xTozIMBaa/HrsWymEWz5Me8T0ExGB?=
 =?us-ascii?Q?s70CY2ZxdtbgaUNUkngBP026hSMcj8gSHjyOSii9g/Qi0j2Gvj5qykusf6O5?=
 =?us-ascii?Q?xTiiAlRdzGR509C2d4ZOVY2TFbpjLLp8ymcTzwuLIzEmvKv+ybXGYqnNdd7l?=
 =?us-ascii?Q?TMJHzkdCsN4rOTI39DYOXIDZ+3zhdt4kKb1d2JpXcd+pQaxGCP+BdOrUBD6x?=
 =?us-ascii?Q?Ny24Z/GQOrGrNy1WXpOHUDet2Rjl6KZL7wDepfPa+VWAEbL5IYcQxCP8GLf/?=
 =?us-ascii?Q?vc+rTMmNXjpxhdSzXXsyq1DLGeQCtAZ1XzWOoYY6MkKHHXTGLYUQlyHxXCNR?=
 =?us-ascii?Q?oHEdtSz2tzSTvZBQ1PyfdXLvfXXak/RMjt2w6ct6KanuvoVYu0y7urX864eQ?=
 =?us-ascii?Q?8eHgkhQBh97x76+WFX3NgyRNLtrzBtHfuQFnWeSwN4FBoXoI/xiC1mQvy4nl?=
 =?us-ascii?Q?MypZ3eufQzzstEWw7PIrVa8RnULMTwcwg3ByJAg1qpIJebESu/BYZud0HI6a?=
 =?us-ascii?Q?tC4NGxruLWs46Kf+FGsYBvrCvhG1c1TtZh9q2pFIW1YaB2ACz8a2LDVM4F0k?=
 =?us-ascii?Q?7rUBlLG1UbRTdp90U2b2EdRze1pCWy7/g2MeZSh3UgE1UvTDpFkaxW9xXy1G?=
 =?us-ascii?Q?N1OR1/bCFga9gZyGE+UW1qabwoLJx+UFUfz5e2d6HxncWMDQhMnUsEALsbFq?=
 =?us-ascii?Q?bb2BDiRxagmtkFNEMM3cJKtV8ff5/wgJ3Q/QcVr6SgX/osdaexeWLe/Dr+x6?=
 =?us-ascii?Q?TlK1FMQfc2QFCslYxbzZqtMx6DMauEr7u9oenssmn6HIPYV7MDB3ePN7EccI?=
 =?us-ascii?Q?IAXSQyvrzpfZOEKr/jApno1JfTl6sRtDm10mndqLuqFvy/jY0rE4OxzLDhXU?=
 =?us-ascii?Q?LftLq41yr4C1yBXqe5HVPOpoqkPsEQIJC8ZBtCRak2Sm91qwQyKuSAsEdTD2?=
 =?us-ascii?Q?CKL5m2UVS5n93pqtxRO4NmMUQUrurQ61qXZ/0PJGhqDW4Xt7soKRJBH4FLZX?=
 =?us-ascii?Q?k7X1zM5PpFYGd+JFUenc6HUg/7xm7PsF6GIFef6CBB3CZRMwhDH0KzwsHTgl?=
 =?us-ascii?Q?SVUfo76r/a+pHocM+LJUPwBtjgEGGwBS4q6akwacCO5O4OrnpUOTEd94AAfb?=
 =?us-ascii?Q?bAOegIptX/LAq1WQGwVD6xIvrntLwmw7lMy367Df0Dwqt0cmIPe22MwwuSiT?=
 =?us-ascii?Q?bBSzqF769QKNErXDP8Gsky5ZS1ME9ZUvU6dRIWatmVuUJGYovHE/Yyd3aQjz?=
 =?us-ascii?Q?3/HU44zfpPKkc7UwWCJqVEsRuDXwkifRCp3JE7G+sPJOg588Rny/7kUjX/qC?=
 =?us-ascii?Q?n0GxcEULuBUXiUSnxp3rILOBLv95M/FecIrRp+Dlauv2vMH9JwZC6wWwsK6s?=
 =?us-ascii?Q?wVQup6ca1McS5XpDtWFfzp0ATVFFtll9emzzCBSdNDdJVNq5HyOTvQSis1Hm?=
 =?us-ascii?Q?IH+hen8YtrMWqkfgeNnRoPycpRLKObT+IoF/IyOk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PwX8EXaJ+FXmqT8CzX8/A0bMVfL0T3wqO85qz5cliIg25KAneGSh+fXYTE56eWLUmpL7KCJQR6JeIuoIESVa03bbbSogKGYoOaaXSZ60eRdplj4hkl3iKGNtmU3szI0zvFAVOoPauSkddwT7g3nY2YgjKoug6kAPV+vLm2cZkl9cONHgxEO1zDZ2gDuKupm95oYWGPABGxkDwYmx2Wex5a3PAC0zTWjPgUyrQ3AeoW3i7iMgo66Wm8gPMR/sHW9sy9EqnEalcKkZFVBH0c8owrTo1b9mPTv1UGSFqKhiT1W6n+rPIPt20onAV65dLuayiHgfHxfWgHv6PhA65Y0vdlWcuj786AE8Ms4RX+/ER7W8CpEwJ0Pc0ddyPnt+I3TRbMKNGjWD0DtN2bECy4T0rcS/6pilvaKSudjq1DqJvyPbks0IW4aU7vmCjRxarTnb50o1JMq5u4zWko8PsjWVS1YIhobLx2RpyDwNBV6TFp+INp+u0xbp2QizBXz9BSB2YfW8fX//T4qN3XG4e2833Qydv4Us0iNK+thQVRWJ7/IGIxEwWkaDBVcxBBDUcv/FQWqva0Mh4zYdD7KaCAKIHeue5BA4/iBJvEk/thSP1nw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33ea7b3-3ce0-431d-09f2-08dcafdbc8e0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 14:36:08.4078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnjImytu4G0b0TTxtEQbCIH4y6Y0eY3xsj5ZTA3ixmU1pYNJ+m4QZwzRPsEeLzGkO0Pg+AIzM4USJTOs/I6icQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7296
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=669
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407290098
X-Proofpoint-GUID: rAawIx5e_iUCMYJ7JrPfGlwaQh0puQCu
X-Proofpoint-ORIG-GUID: rAawIx5e_iUCMYJ7JrPfGlwaQh0puQCu

On Mon, Jul 29, 2024 at 12:18:19PM +1000, NeilBrown wrote:
> These two patches replace my previous patch:
>  [PATCH 07/14] Change unshare_fs_struct() to never fail.
> 
> I had explored ways to change kthread_create() to avoid the need for
> GFP_NOFAIL and concluded that we can do everything we need in the sunrpc
> layer.  So the first patch here is a simple cleanup, and the second adds
> simple infrastructure for an svc thread to confirm that it has started
> up and to report if it was successful in that.
> 
> Thanks,
> NeilBrown
> 
> 
> 
>  [PATCH 1/2] sunrpc: merge svc_rqst_alloc() into svc_prepare_thread()
>  [PATCH 2/2] sunrpc: allow svc threads to fail initialisation cleanly

This series does not apply to nfsd-next. It looks like 1/2 expects
to see the EXPORT_SYMBOL after svc_rqst_alloc() that you already
removed in "SUNRPC: make various functions static, or not exported."

Also, 1/2 is From: your brown.name account, but the SoB is your
SuSE email. (Maybe that doesn't matter).

Can you rebase and resend?

In 2/2, what is the reason to make svc_thread_init_status() a static
inline rather than an exported function? I don't think this is going
to be a performance hot path, but maybe it becomes one in a future
patch?


-- 
Chuck Lever

