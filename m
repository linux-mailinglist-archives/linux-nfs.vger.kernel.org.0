Return-Path: <linux-nfs+bounces-5150-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E25E93F93A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 17:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25091F22FF1
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B34146D55;
	Mon, 29 Jul 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TI31L3Tz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PDHj1RxH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330561E4A2
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266207; cv=fail; b=WbkFLWgCPYZRPKFyqx2WHuFfqY6IgJo5cwKUBvGVJNfO6XCKZgaWYU8o8qC2Ma9IqfTyf+JKsMMhxV7CQKyHneH9DMvZTEmcImJwUAF84+G2uoAo+imoUZJqA69ru6UxAoHTOZxPjkZ7+NmVxLeoSJHkqLLhJrUG9tDO9yIg3FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266207; c=relaxed/simple;
	bh=Rpm8v4WRzyf/ZF7exfJhUP+QWjb99/3CpyYUN2hYoZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z/6HBtwe8tG+Ubcyu7iVTv5FpvGzsyWekLeAXY7GlJmV3IaqOFtDAe/V/olroG5yg8Vm8+O04BUwdAeUHf9SJd+3np5AakGdTDUDvDOrDtef14hMOImumcnBZkj5wh38tTuhB7CsRF7u+W3rVQ11s05jdJJrLjEk8Ar/0T+lOLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TI31L3Tz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PDHj1RxH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TEsM1E032655;
	Mon, 29 Jul 2024 15:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=7kXTFAPpB/y5PBP
	WdA5zOX1gFcA6xmYOiairOG6hef8=; b=TI31L3Tz9xfdiigWjHWLu79J4QPy975
	XRT4WiO1gaqiNZeCt0AXOqTA/zcANk2q0hfP8EnxlQskCjzd8maEg2qpcu0XY/n2
	FHX9Np55a7hGx2rQRj/5zazSvAEy9bQAuo1J0QdLdvBVRBmkgbg61u+X2SlQcdh4
	fkitr5C//BI4hjpbaft5NgDcdpFJhZo4z4BN31x9KRr6TCI+NLWGnUrLlZC5hKOm
	SqZaYrhgGlK+0VjyOvQDf1oq9eKDxmvCx1C4i5SpeHB8JnNhwG1EzcR5K5BVoUr3
	XWPrUQKbFlo8sLq35vpNtK+j8ZPj/hPtnPqjMdLPxIMXeXlAXH32HGQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqtajw6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 15:16:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TEcddU031193;
	Mon, 29 Jul 2024 15:16:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nehrrtvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 15:16:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1EJMkS5W3xuyTWxjPwtpxFYH0GD2vlGSnTd+cOQfLVSaZ60+nP7/QMvPj6gtuytmtoK4c3MHbgsZeXVaVshorHLROC8yt3i3WAiCTIE53X/Al1A6MSklZJ1ZFLVW8o0C14gYqzFC9AU3mIRRMdDTpoJo3rHWSZdD14O6KEU4UfZNcG6jORwZh4DUro7Tc9T9lS6IX/LB8l48kqFO/Y+l/f6AG6+QZ9Qw/+868DTb+qzUzyAdam/daQ5cIYLdA1GurKqxA6FOsp1FKrKXBxmHTNh78utg5sP4NSAqTYFS9q9pb0ohD7QNojTiJmjJarZf2QMC7VDcRNPY6Q38PdIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kXTFAPpB/y5PBPWdA5zOX1gFcA6xmYOiairOG6hef8=;
 b=modGLDd7NECgDOUOLLWInkIR+kctWek6UbGmQppcppcpbzjGmht/UXsE5ohZow8i9qU55OuyLv2eOJdtv1wmiWCzFSNsIFk5rZ+necJjhSHSoa2xbkEXG6HMmVwj/IY5hTy54r8Bppj1UQkVAxd1i/xrRS73ONKyBt0s0/jrWWzAKxgJ3vTPxee54FECawvmQVrErDX+H9pC2uEZzXsywB+mTfmvufgyyEyKaNBnrtOAFV1hrsYIKqZX/UQdWDPs7WbM6HEUyxyTiogBb+H+JOE2NRbGP4ZWuQaptguUp5f14SCB2g2A08/2FpmI3J8N+h5vpTUoW7ZAXn/Q6C4dFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kXTFAPpB/y5PBPWdA5zOX1gFcA6xmYOiairOG6hef8=;
 b=PDHj1RxH393clkkw1oZyqCABVjVhtLlOi0ByWsYgnVMbhh+6gIlyxMPXnWC64jctANz/lABgqe+J5GJoiC/YTRoBUGNiuNdkoiu8tqi8tCCATS2MQOQzCW5Z6D7bInaRNHl6yVWlSOOjlmKf2Skfx3pmErrpUuJvysGVunHU9PE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 15:16:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 15:16:32 +0000
Date: Mon, 29 Jul 2024 11:16:29 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/3] nfsd: move error code mapping to per-version code
Message-ID: <ZqeyTcyiwwr99vVM@tissot.1015granger.net>
References: <20240729014940.23053-1-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729014940.23053-1-neilb@suse.de>
X-ClientProxiedBy: CH2PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:610:4e::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e75db2-9bc3-4931-fa34-08dcafe16d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xyqjX3recQ7Ymlx/MlqlXv1E222LVBqLha41e3DQSsnxCsCDChNfndJMj5PI?=
 =?us-ascii?Q?ck6NtJmBN5fEplQ0UCkyx81nuY8s8rDkktXbdGaDSnFSBYcjh6a4YOlpBLNj?=
 =?us-ascii?Q?D1OgaqrjRHdHCFssXNCIVkmtAf8S6SPctV+6iw2Ezc88Bv/NNJREsnq/8vcS?=
 =?us-ascii?Q?qGj1L8YmmR4xCr1pmD5qfMbuWsqMg2MXRECDTbl41gwyaOG+mcbEpYLzsSwX?=
 =?us-ascii?Q?fOkrYyJWrmqgnQA4TIE5YEFNQ8vGhKpoj9lJxOHp29M6qe87UEogQt86E9eO?=
 =?us-ascii?Q?dPMugW/iZYDM0zIJiVz/okeoO3drymZvi0iypCpwBkPSHY94SdVpIMg5xLlD?=
 =?us-ascii?Q?PNdZ1/yam5Ney0VoKTumYAnP8ZOB3TyiUUhY3tipAJpc77jMiJMnRll+NCpz?=
 =?us-ascii?Q?dQ3Q2qg+0+YAX3KdaOPZG4LMXGJhx99gOh6RwmFmmiFuzrywD6uysIiAwZ0u?=
 =?us-ascii?Q?OypngiOPBtNsJPRNgtbNtgZTxhCObxoawTsWdB39/XLgPzhCPQyvK0aSc+AW?=
 =?us-ascii?Q?By9N/VHI2B2jCpmD6Va15R7WInVi8D97VC76HAznprsRUJckH0Lkqj5ZrjrN?=
 =?us-ascii?Q?RmoNOx4XArbbjbxjmcMCgb+3CGMhgKAUmyrAyvWPfjNWJSpUpjbz1wH83jOj?=
 =?us-ascii?Q?W0IboV54834Vu2EDbeK0Xb1NKbD+itYJwKMo1jWejTJwxrF7+4ctiepoqf25?=
 =?us-ascii?Q?1lRjp49s50Urwz5PGHtmFSfcL0m1UMHHlwC5eJfF0oCPY1I73eUvb5AT/iG1?=
 =?us-ascii?Q?eAMxTURMHinAZ8Z9rW+bBXLQCmSJHVezBb34KZaU52Thcl3H7fuiWkf8GB8l?=
 =?us-ascii?Q?a9X7js+T1dpvily0owZTyFf9I5CfOL+0L4eDUrGX5oxqNNbOUBqHovg3FOwp?=
 =?us-ascii?Q?5jMCIlvchwS5O4y2cw+n1p9MgFGq6WcsQEa8oek0lw4/ryi5erVFqm7bTab0?=
 =?us-ascii?Q?hAuzQcYT5leV/+i/Hho4QF2rCzI5A4un93yCAqGWup7vcvfpCvYPeZPZtI3u?=
 =?us-ascii?Q?PARnwn/MLX0QvBWskfr369hj/Clx3ObEATtHZPNdf/W+Kt2PIS8zB+cL6vpN?=
 =?us-ascii?Q?W43neiSmYxVuW/0Zg50M4GZp5CSnr1pb4dDTOzKRSeRksLIdt7nool8STbra?=
 =?us-ascii?Q?LGe/MCsRFB80JH9ige1pgaYT0JCW80QFUed4L0WK02hVfEHUMfmM0cmoTMRB?=
 =?us-ascii?Q?Jz3brw4ZtL+6CnlpKxdTrVjvMavVPl297G28dzSnshQYeAVVYo4DH0w0pjup?=
 =?us-ascii?Q?aUsDnMye9qvu3o6zRZHHDlDDXZC/xZzUYPDAgDH2WdGSMmvobIjxcUpieD1j?=
 =?us-ascii?Q?36wnuaHaxp6FfWxQDqYAawWT6CvN9pTu9qVGRY0n+0V0JQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VPjkhk2USkROrJC964C2C9/0E5fzyXY8RDCS7mDW7Fsi60TcQp4eXiRp329o?=
 =?us-ascii?Q?dIgZQ0flzgBSaUEWZQtKqSUnIZyo48Dsf9u97XpYWsbFXfyLX+MBdPwvMh2t?=
 =?us-ascii?Q?cN9xkgvQ8+1+3AZwrJamYcYrQaQe8+Fb7zmiI9qpakRhKyZCjffQPx9+RNXp?=
 =?us-ascii?Q?xas30ACr38QPXcCNYnDFE1XhLChny/g+lNRnhipI226RrN3LIiLs3SPxMjP8?=
 =?us-ascii?Q?PFRjTcowpAAxYlhSvqi6M6fRvr0OVLjTAkIhIZ9Mgh6u/ftt6bBtgn8qxfR/?=
 =?us-ascii?Q?vbugCj8Rq5Ib6D5U1DhOHNnRDNHAntSyKO9Y3Xcl6RuYVs+eSplPDbLJxwg8?=
 =?us-ascii?Q?324Tp79Rfe41isaCAX11Y8TaB3EFkMqQ5OQFTy2hZDPd7lafzFde6GSWNbyS?=
 =?us-ascii?Q?HeHgPoBeSr0t8AmTYJ3u60Y5n40NgHrwQrKTf2FBN477NVIWlrpeKBCxSH+5?=
 =?us-ascii?Q?uHHMwUagPiYLGYh4ap1u19Mt5TAvrDsQ3NIZu8hvbL2t/aAZkFASS+zSHN4y?=
 =?us-ascii?Q?xV9EVJyxdAXD4D13DhesT8gjq31r+n55+DZ+Zsa752/DQDP6aUQnHiWngIgm?=
 =?us-ascii?Q?9cR16QyaPL+wpJtCk2gb27V17rdqwzMC3JmusHQFDCGjrykSp8jLdFZKJmdt?=
 =?us-ascii?Q?B94GFh65U7dHpYxhwHZZo59OkgRuVCfH1WegqoEYTWFsL7JyMDmozyXt4FTg?=
 =?us-ascii?Q?YUHpyy5Y4kysmOEWJ5+tjawYP9JNvPJdGG4swPih/lJ3A4hFkgAgXyQwYc3j?=
 =?us-ascii?Q?riPU/vKxsmBuhr0ufYzHLBZuKyk+NTEgmrBmbRbv+C9SUqlRHuJhXux3Gawc?=
 =?us-ascii?Q?nmYaPRm6TWRYHdBLdQz752WDt64VbzQGqSPWRN0+iuuZaSIX0xhVg/8oGv2V?=
 =?us-ascii?Q?LjPIejlOchKq+1CA/r/o2b7/D7o2Y1c1lapNX6yrAQTUp0APhhF72ONk/AaK?=
 =?us-ascii?Q?jNEfRWLnGLds1tMEF7V0I3q1+dDbLuPaiaJmISaJZGMPxHiL0jYJK/f8Aq0U?=
 =?us-ascii?Q?lETBFZj1G+eUQSVOTdiadbAIbjjv1ZmX3DHx0vwh4nuQb2IMFdfqXYPG0EwB?=
 =?us-ascii?Q?BwVwN/PlDCtLG+eh+Tz45W9njd4GAc5mLsVh8wwwiSTPobXj08NspRwnAL+O?=
 =?us-ascii?Q?k2Wv3OXI1YRtXjkOCzlGIL4O25NOPrKIA28WqRw30pifq7TaDuIs42Ch/sVq?=
 =?us-ascii?Q?keuD8OMwgAxjuTf91Uq2YEzjceOTpsJDs4+KDlkq08SL34ureZOmJtFSfIOR?=
 =?us-ascii?Q?EUJRtTD3/VU9aqse57tJLeXRRTN1scKAm+a1S6ERTff2Fn9cUo506jzhYmC+?=
 =?us-ascii?Q?OqMqwnJXxvISwGurd1DaNXvIXacjtEeWGdBZND0F2APhlLwdmV3FlnyExBaU?=
 =?us-ascii?Q?xZOw5OVewSysPN6eervrTBxOlUlpWAjLaWEj0CGFly69Eue+JR3oddHbIC1l?=
 =?us-ascii?Q?cMYz12SNu/0YKlYQ9l/PLZt9ENy+26BLaY91SuMfiTMkfZ4LxqHLkzpfMrQn?=
 =?us-ascii?Q?h7rbWpAXkvx0jajRTVclPBV08M18Q9sU+o1Kqz+nvdCxhNb7EGqT8ksq/nZN?=
 =?us-ascii?Q?+E8BLgijeTJjpWXy3NleAWTMMkinnNflsL540UqY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7xrNj2mNTfbaAcDwSXjj+qP0DC83Zxj7/j7HZUfTz+qFwv5DCpjRSLxBjUFIxhcRv9bQH9dCQO9myNHxqVJ99tiHHmo+YICpeB+heTvM1+4LXfWcYFHTuUbS9VTx6Jl6JMBK1W77NrIOYAmQxjS25+G42fJNXkK2nMaVzSyPVitqdbe4xReWqLysVYse5yWBQGmz3aTmE++RrnLqAJCyL+kcPImG27bTmUla4qcZasXROnQ4EjS4Ta9JBz1ORQhMb8f+MO/z1Dqp2s6K9MMgpp+AvklnaJRmKHXJgYRoPpoYKP+EZZUW7ELo/Z1/uaXLu9ehvbnUNJBE2v26hl91X3zGTm/wISkiSHAL1mM6PcrlaBtsscjhwPZpIPleWUY4P6rXco38tZ6srxlngSMF9c/PHBllU2ucW9l999QG8TUZI/Q4Wjfea+lkGp81ZzJI6GhsBPogRg8hl0ixWkTYmcQHWvqw5bo7hS8TMXQ3BI5lcyNii7vQu6HZXFznV+1Z6nPqiGgtg25LNNAzxVlgxhIqrGOVkntBLri4ciuqhKl5txQOaUZJw1kn8SfDZ0CGvRkPVdNRT+D1lCaghaMFc/kpieZLqswmF8fSaHNPlYw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e75db2-9bc3-4931-fa34-08dcafe16d7b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 15:16:32.2775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbSnq+p6IcpvpAOBv8l/gGNFZnULeGNSrg2MyczXhtORfZCki1JBQf4JsO8Ku+2g/Pz7CRhq5lhGG6Y0slwoGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_13,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407290102
X-Proofpoint-GUID: D-ovfrv0mmmyhOWYLtD1PgYVKXMCWeRc
X-Proofpoint-ORIG-GUID: D-ovfrv0mmmyhOWYLtD1PgYVKXMCWeRc

On Mon, Jul 29, 2024 at 11:47:21AM +1000, NeilBrown wrote:
> These three patches replace my earlier patch
>     [PATCH 3/6] nfsd: Move error code mapping to per-version xdr code.
> 
> The mapping is now in proc code, not xdr code.
> 
> NeilBrown
> 
>  [PATCH 1/3] nfsd: Move error code mapping to per-version proc code.
>  [PATCH 2/3] nfsd: be more systematic about selecting error codes for
>  [PATCH 3/3] nfsd: move error choice for incorrect object types to

The code duplication in fs/nfsd/{nfsproc,nfs3proc}.c is a little
jarring, but the trade-off is the code is easier to understand and
far less brittle in the face of major things like disabling or even
deprecating an NFS version.

I've made a few minor edits and optimizations and applied these
three, with Christoph's nits addressed, to nfsd-next (for v6.12).
Please check my work (it's been pushed git.kernel.org).

-- 
Chuck Lever

