Return-Path: <linux-nfs+bounces-2629-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69304897125
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 15:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF371C2742D
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF490149DF6;
	Wed,  3 Apr 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iX/uxvsn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dTPkl8xt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB69F1482FA;
	Wed,  3 Apr 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151044; cv=fail; b=rkXHDsSjEOnMN4l2nLCquC1TUvMgADB8bSyyxDKjFpYooUBftMZiB+9mKskQjAxMvLf+FgHg+KzimukBMRguc8LtTNyoqux967/VUlSpq5FhA+5vzk8e4EW+EScBztIQ4UQ+X/kLS9zGZoqT6aL6rjNLi9rWxG37Z0NILbPvdG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151044; c=relaxed/simple;
	bh=nzEYbknDGVLNVV12G8z7oxXq9rUKdIZV1KOa7dd1Gew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=axJcYtHluiIle5IryuwmmNLvrjKmK85pOsrTFr2m4SXultNaG5cVYEimk/sAMMs2EcQtoMDS5imNx0uU5oBBCK4WtqLt4ORu3CLiH+4wFcEpIFGnFNO6T6sugViMWEC0FFEzRbRc1YFqwpoEneydbhzBvJCQIhGe+KZwVYVAKF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iX/uxvsn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dTPkl8xt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4334pQUt019411;
	Wed, 3 Apr 2024 13:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=j1BkO2/s/yKQeVUr7tvilKQwSdtpvCLOd9wIxF8KPoc=;
 b=iX/uxvsnIF+qgdLKiiPHtBPYHbdqBcpphllvjrDIbAttk4Tj+DtVZ4oZ9tiZxxmXjpDH
 1Ce2a59+r5XLyX7ZGs01ywuaNp451/TO58jicEZkdOSsSpSzAIlGA2L0mnLlBjqUi/KR
 dDbIbPTVnjpqQlDF6GBXK9JxePweQjwRVZQDLaSMMJt3WoLRQAOv9j90WrxtqwDHjYCo
 fZ2/0+BgDsHz5pNEfzeDlH4VSe+klvInm9fvsG0lzMjoQpPiYNsvcNn1m6ixioLNTCE1
 AwQeFoeb0iYdQoRlnQNQMQ7m0xd0qiiFrt2cwbUQhXIyqUYLcIzIK+O2AaQpcJZzSYux bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6b9vf3ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Apr 2024 13:30:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 433CtsYf005658;
	Wed, 3 Apr 2024 13:30:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696ej5a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Apr 2024 13:30:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKvK7WW4zvCiytTnjA/GKBlOmc0PAOm3ag79/SNEDjAUYZAKkMz5myaTdjX2RsA8NXnSuWbOXOc86EclmF5+IXJ+PX9JsykBx9SgRseQ7IXJJN+rwA2eKrkH/Fexn1EHL4k2zAH094mNAVbF0r76hTsD3DHiuMFVveVsw3+1KqpEBfWOkPtkb6e9N9H8cQEXCkbr5nmbOSvk8VQn1A0PEfOJfWKJ0F1/zmk19BKZzvQFkWzZyBxs7e3HdewyJL6vEn+lfXRuRvU+MCMX+kBqP4nGKOX22HKmXLTqB8eMA2MwbofYK6drsLZTLimjW/r+4amDrPxusRmXI+k+zdZG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1BkO2/s/yKQeVUr7tvilKQwSdtpvCLOd9wIxF8KPoc=;
 b=dlRoaoB6WZ/zXa67gXqmPwYNLj6WVQ53eFcTRArQWEMCZmqfbva0ONqQwmKzrfRsUXp3vb4n5VSWfjBygJt5tCsykETrWWSxuSET62fSnmnCKxR2EenPBH5fCBW6vTxoUqQNFFOYFWdDUXUbiCj4rQWsd3CKA/OL1TGATEncgK694erUmYx5AF1mQg4iq8iN5VufzkYnE2uXJNa/Gfp2hj7jddjahGkvAcBtA9XHb4zPw8jX6vdCzCNasJ+QmpkHt2RWnZ07L7MSAgMLccg/LBiqRMWcv7svZ5WlqlewbQBV3KBWBzXEvN09TG8aQB2EAboN3f/QZ4ZL4+42w7o8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1BkO2/s/yKQeVUr7tvilKQwSdtpvCLOd9wIxF8KPoc=;
 b=dTPkl8xtNSzSz8WaD7nmyZrg7ULuJYD330Z9DUEa5UR+zmqgfgeOlDsVYZ3rtMgjgOrKkg+falXdxi+k26s0Yk9cJLVyN6ZmCzLnaoUM0josDemjIpV0HIPy4IsgdYQ6L10f5VeALYxXJoGrp2r+sX9GH+QL/e4qmw3XMvPw5Ps=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7869.namprd10.prod.outlook.com (2603:10b6:408:1e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 13:30:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 13:30:10 +0000
Date: Wed, 3 Apr 2024 09:30:06 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] trace: events: cleanup deprecated strncpy uses
Message-ID: <Zg1Z3ujvAgmbFdnz@tissot.1015granger.net>
References: <20240401-strncpy-include-trace-events-mdio-h-v1-1-9cb5a4cda116@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-strncpy-include-trace-events-mdio-h-v1-1-9cb5a4cda116@google.com>
X-ClientProxiedBy: CH0P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV8PR10MB7869:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lP5ZoJva62AEWyZGNESEQpL0ZQWqqFwczVUiffpJgNl165b5rHQWvnpLkVilH88XcXzFtVujlkMbXjilDCZmPEN1UsH0W1066GJ8W6YfRHVEY6+gf2I++cz7q0ArZamfHFltT91heNRFSenXgJrGMbsxbsa77QG2bJK+yiXY+6i8OKJ3qjvuxNtNHWC+KPX/UvuiKJ+FTXiuvkvzsEOXZSpqa4LO522A5JWe/spriqAM6wfggYtx/UWDOzcLBGzZ2heeR41q2LPbSRXRWKv6sPgwvv2riiX0Dl/tDEhdlgOC6JneBIP9koPQLNPMXuDHxw00mAG2QZJLT3+anyI7YDK5Y6z5IRuz3hzuAOzVrOqISQmt2UpcKdLzzVWOYd+iGx4uuMps7K1l57/ONsC1DknaCTV1SWrGM92gsOdjlVSTvkT/1tk6TZkda1IORyrFqh8S5RroJoZUlUUUvB1fBRl6vlFpRE7kG14qckr9psK7IS2j/5lvclDvEvC54RCnWCKFliZaJjKp+kZU02L6if3up+G8DKt/qHKfvFgdI2JWLnr4+Ju6SgJ5ro+/qr/orDEGdw3dyTkTZMvRVX947Xq5Wf4Xu3x/5q7JZm4R5mgLEq9EXlJDjyDIPdsMrcN9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?V2u3T5W7dLs1svZLozfFo75dfxCc7u5ezw3U3me5KoltbkPqdksb9umeqAHI?=
 =?us-ascii?Q?gSYwSGZb9pNpdEaL8Zi3xqrmRyHkl56KQB9vGuD+hZPDnx6oYp+a/uNJcv39?=
 =?us-ascii?Q?Sz87dsiEjEkdjID/DCQScLcuCNL1I4zGOOd+wSkCJ729Mwxk9aD34tpNlwKT?=
 =?us-ascii?Q?E0coS1hP33JrSGyUelaWuhwlVwzkYUwYLbllKInfbqA1lUjZMYnsHt0ashr3?=
 =?us-ascii?Q?DLB28ymLTiZcb6Vd2EfyFH7lfV6VdKOlGKccjyFpqTB+RSq78BnA5aXHksZW?=
 =?us-ascii?Q?wS7ggijBiPEVvBYiaBcZLjqcW/WQTubxsQe6iHfZcpRjoC7qbcRg1uZUaQJe?=
 =?us-ascii?Q?b9byZAHC/sfBZzRijz4TQEZVjboWsMsm6G9UYYQip9Sn2Hwfff7wCa2xcD/6?=
 =?us-ascii?Q?Pcw/pI/rpFeRmYrOSZcI2A1VVM8iF3DPgKDXUiOK+8TF8PBXTpJX2r/bRVCf?=
 =?us-ascii?Q?TPZibWVHPFdwgijx37OBm/3dohdDCg9/JwOhQIw4w6HmkJp/l4fahEpv5Sbp?=
 =?us-ascii?Q?aSgOE9wPU/a6ZJRUHmyOfkHFFmGoG8psYKPRABEBMGGRy5kIV/lnohTX2BDu?=
 =?us-ascii?Q?XBCSFMhpWlyw+5xkHjNHXEyr6oMDZlRuG2lN8wKU8dRcxdTaG+zCq8LWTR2v?=
 =?us-ascii?Q?ZV/qS5giDESxfY5mUZPlN7aCeSZYSi+V+TpkpoyD/nnfau8GTuha99VDrb7W?=
 =?us-ascii?Q?TtFjBwOvinuzr0JLrp/HP2SMxPJ0ljpvE+2EKhejE1o9ejFRWinFBlAPKCfU?=
 =?us-ascii?Q?0LZKw21h+23KLOj8wgkfwDJ80R/tEWOpDDOJoZocjTOTttAsk+sVIXwMQOXY?=
 =?us-ascii?Q?fp/1NnJ18/AcRanfB2GWO/hgcoTx7dmBx11WJPejET2+lWqAvMZgck/1syG+?=
 =?us-ascii?Q?w68RE8tkp3XDqC+4BbVlqpLvXc4KKzFlcOXW9GA4VeXY0JTPK6+dzc4wzQwf?=
 =?us-ascii?Q?k1sTaNqr1JpX4i+b8bV7YNISsW5blNxLxNLK9p1/1XW2iiSZpSRUv68R+EvP?=
 =?us-ascii?Q?BBn9q3A2CDgLn5AKTeCzkHajYioe3hykq/989mb1UXTJRvE+0U3DQ68AkfYI?=
 =?us-ascii?Q?EX6bMxmo3Y1MjJQbbJ1AtMswrLQyI4/33oGeMwOU04mjlowic1j6iuDP4lcp?=
 =?us-ascii?Q?L6spL0CtxvKGCTCyi2gHU+dauYu5YNhCCiv72li9zUqClNh01c5kFvVv5lcl?=
 =?us-ascii?Q?RfUqRoTS9qdSxOKrz3vDjmrpzjFwGV81Jw0Pej7BC8fC4hPhb3J++ibJ5F6O?=
 =?us-ascii?Q?PIwO0tvUyjFE2vjwe5gAhfSDYmI++wG9aqFAr+Zao6/hOTquBNw0+VTSW4kp?=
 =?us-ascii?Q?pRxxQ9t36cpRPP+a5mAnlbSld4dguTHlpB1tjtQ/F+9UrRkUDXYd+YLFvxNT?=
 =?us-ascii?Q?ORiLjcnig8oqrG2AmvHW1XZuRW+vmvA/3/wPw7j0hWA0A2lBf1krSk3fVRC7?=
 =?us-ascii?Q?a+Kv8Ix6QkZtFqzSznDRAsApARoTGJFK5Ge0AgqpSq061oO3rZ2EbA566OcH?=
 =?us-ascii?Q?X8z7su8JizMK+dJetpswjP0fYixjagTgAIxY8Q4EK1++blsQ5UrMEsB2fHw8?=
 =?us-ascii?Q?4m5AYy/IhySezNC5Uc6YmQ5VjxnO/i5GQMSn7euj7zA2rY90MBCV/vqk3FUl?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xDIPmTL7c41w5ixQt1Z3EH7zPhKyBzSxJ2A4VXtUt7xD1RzoJG4wlEqpGW/+Lo26LApWYpZbmJuaJVqlm3S+b3PJ803cI6rRnRYOsrKAVWEIiNnvz63rP5zJdB8ahMlzN/XRdlV0fbIUXCpM5hAMYP5InSHhkAkVnuCDy+E0g6n7SOEZ1GCf6gzNKV5JIb84nkmLQ9rIvdq+UnVegRR6U3CKaxBsYwFeF3gV57Mt1OCGAXRCuTjKtYxIMNx55SRItUDnEfS2uGHgtC7bb9LBIMSKcGH4bCKDo7XYbB5nx0dAw20QKD+ajZ0WqrMqXmQUgkIJKYtDz0HT5n90xYFgpwXQa0XfF84gzUMiVN12dU0uvfjHoPvnzWtD6Rpl9IhKTZ80aUj9hfpZup5QjQtW/ztOfuYElxejRGY+cr6pvGd4VytVbspDj5gbW+nflVRrBKs7JR2Nxo/hA9jBWmTSyRT3ZeHb7a0Qz2FJkmfLA4hLp6qMPpG8USJJIG7B6tzZH1x3/WAlT3xIkII8EFrEvEoCJWbNCDCGPEI5p21IxTqx2rrj7ViEswIrDkjxS5rmABKC60Mngur4lWd4pKeWPJMHa21I89Ae25qbfOkKImA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f53783-1317-4ff1-00df-08dc53e22f26
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 13:30:10.1035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmjaLHpogWurfg7TRZgOvw5mYShQB0IfJPm43MhIAnWkl+J4ARKQfkLK0le47G8wPfClGQZG8VkhMq2AiXmvLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7869
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_12,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404030093
X-Proofpoint-ORIG-GUID: vEz32wN6acQqqx2nUwXqAiWL2wzAACCa
X-Proofpoint-GUID: vEz32wN6acQqqx2nUwXqAiWL2wzAACCa

On Mon, Apr 01, 2024 at 11:48:52PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> For 2 out of 3 of these changes we can simply swap in strscpy() as it
> guarantess NUL-termination which is needed for the following trace
> print.
> 
> trace_rpcgss_context() should use memcpy as its format specifier %.*s
> allows for the length to be specifier (__entry->len). Due to this,
> acceptor does not technically need to be NUL-terminated. Moreover,
> swapping in strscpy() and keeping everything else the same could result
> in truncation of the source string by one byte. To remedy this, we could
> use `len + 1` but I am unsure of the size of the destination buffer so a
> simple memcpy should suffice.
> |	TP_printk("win_size=%u expiry=%lu now=%lu timeout=%u acceptor=%.*s",
> |		__entry->window_size, __entry->expiry, __entry->now,
> |		__entry->timeout, __entry->len, __get_str(acceptor))
> 
> I suspect acceptor not to naturally be a NUL-terminated string due to
> the presence of some stringify methods.
> |	.crstringify_acceptor	= gss_stringify_acceptor,
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  include/trace/events/mdio.h   | 2 +-
>  include/trace/events/rpcgss.h | 2 +-
>  include/trace/events/sock.h   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/events/mdio.h b/include/trace/events/mdio.h
> index 0f241cbe00ab..285b3e4f83ba 100644
> --- a/include/trace/events/mdio.h
> +++ b/include/trace/events/mdio.h
> @@ -25,7 +25,7 @@ TRACE_EVENT_CONDITION(mdio_access,
>  	),
>  
>  	TP_fast_assign(
> -		strncpy(__entry->busid, bus->id, MII_BUS_ID_SIZE);
> +		strscpy(__entry->busid, bus->id, MII_BUS_ID_SIZE);
>  		__entry->read = read;
>  		__entry->addr = addr;
>  		__entry->regnum = regnum;
> diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
> index ba2d96a1bc2f..274c297f1b15 100644
> --- a/include/trace/events/rpcgss.h
> +++ b/include/trace/events/rpcgss.h
> @@ -618,7 +618,7 @@ TRACE_EVENT(rpcgss_context,
>  		__entry->timeout = timeout;
>  		__entry->window_size = window_size;
>  		__entry->len = len;
> -		strncpy(__get_str(acceptor), data, len);
> +		memcpy(__get_str(acceptor), data, len);
>  	),
>  
>  	TP_printk("win_size=%u expiry=%lu now=%lu timeout=%u acceptor=%.*s",
> diff --git a/include/trace/events/sock.h b/include/trace/events/sock.h
> index fd206a6ab5b8..1d0b98e6b2cc 100644
> --- a/include/trace/events/sock.h
> +++ b/include/trace/events/sock.h
> @@ -109,7 +109,7 @@ TRACE_EVENT(sock_exceed_buf_limit,
>  	),
>  
>  	TP_fast_assign(
> -		strncpy(__entry->name, prot->name, 32);
> +		strscpy(__entry->name, prot->name, 32);
>  		__entry->sysctl_mem[0] = READ_ONCE(prot->sysctl_mem[0]);
>  		__entry->sysctl_mem[1] = READ_ONCE(prot->sysctl_mem[1]);
>  		__entry->sysctl_mem[2] = READ_ONCE(prot->sysctl_mem[2]);
> 
> ---
> base-commit: 928a87efa42302a23bb9554be081a28058495f22
> change-id: 20240401-strncpy-include-trace-events-mdio-h-0a325676b468
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

Acked-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

