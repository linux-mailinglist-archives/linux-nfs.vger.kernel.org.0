Return-Path: <linux-nfs+bounces-6899-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A097499201D
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 19:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6DF1C20B80
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 17:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52FD82890;
	Sun,  6 Oct 2024 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EIoRvdmC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="avs4lp0m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F79A2D;
	Sun,  6 Oct 2024 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728237055; cv=fail; b=iddlbXDM/I9fBQKpRls5RhX6iJ0FHJZD9f8iafga9MMJo4i/scORwbK0ulWQQdXXLGFx5YkQTge20+M/Fh9pP7ZQMCXsAfmqfeOztOEJu19dRqqA7mcM/cBqZHTREQU1LDXiWGzmBSEsVnqJZ2zBc5RJPwf3ns/xU5GDMh4qmDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728237055; c=relaxed/simple;
	bh=YufnyiMeZo1tlpkp8i5zNtXHis8i3EavNRN7vppMMPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DnftroJkLy8eyHcbWQ7V0nhwHaQcvKcYN/3jRzpeBvRg97fBf0oYOpSsmD6EEmNjYAKerNUFSHPuPUY8bQbXoaCKIZ+51VaMdw83xKDZENC4QbbZjQ91JkQzlSI+Lb1TSVGLhQzSVHO5pP3j3/8nTQ+JUDJJhdhbdZsXqGvd6xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EIoRvdmC; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=avs4lp0m reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 496AqUnt031329;
	Sun, 6 Oct 2024 17:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OJMd9qFlZkTRCa5jgqqNgPWuw9D8/bfXaCuQlNseKaE=; b=
	EIoRvdmCRJF1TKdUFAZ7l+zBq2bUKK7aGscb33A+N6RcSs4jFQE8oh+fqp1n5Wrs
	FuULG9rnqTlUAbYhYRam+r/jBqdZcBOpw32ve7NxiDp//TLQLUlNMOQJSHA3vg5F
	BCULMJP4GGPMgQKt+Zd09d8JgYT2QMb8C0/sxqvDlaUIitJWasJbJm9IwvTHqXnS
	F7+bYneiJzrh5fX/Z2teCVHpjK1r1jEvOx++3+hAtGXM28dAzy2CPL6i8U1pLpKV
	FCX4VFwd8HWAr8QLPoiEbFv3+iiDK99uzNvjO44bRSlJv+qRuou4+jYa224rTXHL
	m3fTVSjaMeoED3gKXk08zA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034hccw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Oct 2024 17:50:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 496E1nBJ001255;
	Sun, 6 Oct 2024 17:50:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw50yuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Oct 2024 17:50:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyTKQ2d3LmooFruDaj9SC6/nixqEaJFsTq235cvEDjBtzABpEkVo4CkPURSJqUDvLQqh5g5LiYMlOocsQ978wMFr1LNAMfP6V4r8I4rZvY4/GFXqIZdudktEqLVU7Ri367grboh1d9aqRywJ89sxIkECb8jOK8oNFeUS+9f58QW/JaKZG0I3nSDsesSGysX8vZenaqD28qgSzyXd2lIAJl5puu46jRLhiAp2Tg54ocUXMUpIt8e920aQE++QtJG2uA310KgixO7d/foPtOoMbGOPp2ubmPEqGVGHQSff3z4RS/mROrQtcyVwf6UUIeX1hGZ4QrWx69XIwg0dRS8wSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ll0Dut+vnf903YZw9fGKWsbTWeD7WoKvoof5Mag1gNY=;
 b=DMhl2FpCT9ixSV8dueNj4j74NUuw2KfjBzU1kL3OHgsmW2XVj98PBBNzKdDUp1c59PE0a74GFzxFNlOLqa9l+Dik6gqrOcqBfGcPaY3QPoTx1lKJ5OJhUj+oMk7Lw6Dy2PPZao4bylcpBC10ZgVXHa19vP2RLMofphp6jooS+az2BVDO/16Bk07a83//ZXMRkUcENizuwDQqn5RXX7YcBt3CSibZ6raLZI4O6EiwPp33/CjPkigov6W0HxnvstwI+FDXc1hXfdc4wIqKAQECpC1DvY09NmD98LcotjskZzfSZHstI1nf1RInPxVnewaz2Dv+iFCtCdr/NqZrNnExfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ll0Dut+vnf903YZw9fGKWsbTWeD7WoKvoof5Mag1gNY=;
 b=avs4lp0maMSVyac0/kTwxwdqy7F5THuJEUJMS4Q88d3nlJTE1kC7WOEmDhXAtUMaMg6Q9WGLqe84LPGKcRXMM+BkANgTaqic1NFpSf89tA86JGYSofjxWQYXfBWufy/cKYQpWw0C+WiVYTFEwTE7MYu3oDXquZsJ0eUECxItviQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8098.namprd10.prod.outlook.com (2603:10b6:610:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 17:50:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8026.020; Sun, 6 Oct 2024
 17:50:36 +0000
Date: Sun, 6 Oct 2024 13:50:33 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and
 NFSD_MAY_BYPASS_GSS_ON_ROOT
Message-ID: <ZwLN6RtYwVIkUfaL@tissot.1015granger.net>
References: <20240912221917.23802-1-pali@kernel.org>
 <172618154004.17050.11278438613021939772@noble.neil.brown.name>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172618154004.17050.11278438613021939772@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:610:b3::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH4PR10MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 07566c03-ee10-4ce3-1c43-08dce62f6237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?a6sIcexK3RPOyWaQmvHQSjt3NXPr6Vi+UcS8mIddRmNTArcXJSrIeNaLKE?=
 =?iso-8859-1?Q?Qwcb3lk9OUXKGJ5BqQvua02KU002xAUMY/DCVHU+TvyH2rgnufbd3J1qoI?=
 =?iso-8859-1?Q?i2Te9izZa6iOal3e3T8EvqRZ9p5ygHbtorIxQWjSlMCY2youPRn3Pjmir8?=
 =?iso-8859-1?Q?nA5dF4zU9OeIV8N1XK4QuyMbTfsDLWd66j9rplHvgauduIub0eSiMFREBH?=
 =?iso-8859-1?Q?fYNrO3TSCgiAaok0DSLXJV4iBHLIjWXtZjuAR7YsMlEHQliznXuPZ47UOU?=
 =?iso-8859-1?Q?WxeGzVCO31ivwluhMn4Nw+/gfF+qrcVjgEzaJmy8Y7R+0wvj9Xq7YEh/bw?=
 =?iso-8859-1?Q?co2ltFY11oyqUPA+bClBtBaRTzdCFThmEx6A51/rwuQ2bfdXlQ4jGeeBi1?=
 =?iso-8859-1?Q?jQRAoXgH6CNGcUiQxVi0yt49uk4QzAwJSoEhtH+IwzVYvBa58Rr0e4jWPn?=
 =?iso-8859-1?Q?y54j+bP7fRs8ph/y4uAmMeEg7FDiDdBmnjEwjU/xEy+4oOn1OWFrtU2W0U?=
 =?iso-8859-1?Q?gQCgfQvtxUfZNSClGj7pxakOtnsa9lim8X8K0vxQpik6HjH7SpLBw8KxNc?=
 =?iso-8859-1?Q?aOlpWFmbXaGcMFE+sDCRbDQBZML5BM3/3m6MhV+6spa6Nm6qs1aSekJqot?=
 =?iso-8859-1?Q?YTw1rkj3mKJx0HSSqY86mKYF3lVHzgLf1HK4S18zJbQQDvM6N8aS7smrm9?=
 =?iso-8859-1?Q?igcAHGT+QjTdYtx778Y7SAO4bLK0ZZNgjiAvhZ92pXRjjqAiau3FknowgR?=
 =?iso-8859-1?Q?Bv0xsvcTq0I1JFgSl/3z3R/gV4Z8Q8LLDHiqu1JWEyQIbVH8kyukpELRFX?=
 =?iso-8859-1?Q?fitdDre8+ky2Bi+A2gV9W4+eGTobj1/XrX2i/ETLnZzVgMrM/fC7g1lNu7?=
 =?iso-8859-1?Q?PUNEfQT111l/rJHwL2LD22Y04+UltVzJjxCbJ3u2IsZz1GSMhBnfeNjARX?=
 =?iso-8859-1?Q?AmeJYMpRkaAGL6XtzijKXBc0AFBvv8ortKs5MkHrIKO1i+bWqQZbEBileZ?=
 =?iso-8859-1?Q?LF1P3IOeIf2ZHFQIg0XjDkoyIHs15iEF68xs8CIzjKKaB17OjCZ5lBWz0K?=
 =?iso-8859-1?Q?walE5wYMbgmK457dR+EBsB1W1xgrZarLQbY00AEYtwrNRfyJpOCwHtcWsd?=
 =?iso-8859-1?Q?pNoUciGj5vkM3z8myPy7osfdXlelAzcIV4Nkw/an9/9QiD/vrpl949KRen?=
 =?iso-8859-1?Q?2wjMhDTRXlcR7f1W3gkK9nap+R9XjgplBgJltOdIhMx4pJ+OseYBGHM3T8?=
 =?iso-8859-1?Q?USfoiy2UQZwIDGxQkMtibi8QTGgiL4pk4vmBYifQm0ANbUvnIkGlGO9Wxp?=
 =?iso-8859-1?Q?wXv6nNn2Y284/tcSDGyqmo0Nlg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?bce5iWfL50Ulebpfxru5DwpolQ79eWhEaJgYAThbsTYNWt7i5BSLHxjs6I?=
 =?iso-8859-1?Q?paZTb/1GFUZ7M7WmrKA7z2EWIeyxLWJjdzx1zecgBDS5nSBMU5hoD1GcBv?=
 =?iso-8859-1?Q?9LZIlo01dHBs2os/BwekXy7VHcTaztMbag2b6/fqZ4/PAKNZYpVPvUnyws?=
 =?iso-8859-1?Q?/35m4chEy/UeRvs8SEy5cTM+e4A3BWln7bcxk3VOx3AuA4YyXbcYybKag8?=
 =?iso-8859-1?Q?4JgMsOZYitOhDOiMa2mOScQFJyu0WZcxyLP0jP9RzVlCRAEna+QsewzeGJ?=
 =?iso-8859-1?Q?14TxwpLAjTMj7bhXwbqmBGbCdoAW891yFlVQdAqnE9QEpDr8ocWvFL1pmd?=
 =?iso-8859-1?Q?mEHF1aVNxQh6QE3yxVvkxKituNEiusgh/FfNi7gElI/h28nmcBAeue1fq3?=
 =?iso-8859-1?Q?a6c6+hVEblnId0PgboEcJbM0j3AGUrGjixRT/SdEmmgRZSrjRsue+Zkqjc?=
 =?iso-8859-1?Q?rn4QvbRWIzBnlTHXGyKgJ4UcfHifdeAOprIPLSMRd0ajhTAmFDwwHdY3rj?=
 =?iso-8859-1?Q?BAJgOJRO/2CtclLRKglrqhbZVg5GHumcP2948TFKu87kl+aoF0fxrpwmlQ?=
 =?iso-8859-1?Q?hanJV7SUnL2t9ImPL8E1iD5DuRCzsk4vJJRaowy3A7eyE+FtvdlTO7yvlz?=
 =?iso-8859-1?Q?OzbjNSkuOUeMztyhYyeQ1taLvHpC57dTvNA0pWMpd9nsBZsQ70KtFVoSbm?=
 =?iso-8859-1?Q?JCgfSZztqXL6Stvxz0GjHwR+Tp+xz6NGpRoiT9cHqoSsAAye1XUc70zP4I?=
 =?iso-8859-1?Q?ewj5cwJ/AOae59ofsgdvawtsK/CsOLD7XnNDqOEUiB9sUgHQLHv4y+IgR+?=
 =?iso-8859-1?Q?OnDp/eMxgDWH08bU2nAOxDS9S+XYlXguGI4V68pklmXteQVIJgwPBuDNeC?=
 =?iso-8859-1?Q?j00B/fUaVss8IAB1DAcsPD2vvAgDQgPFrqBpbUsbP1fuSpaIOM9ph9YoVl?=
 =?iso-8859-1?Q?KY5SjM4R5FIRkqonp9cgQSI3pl7S/ZJTmoahWfESv0bEqJKo6GYX3SQP8e?=
 =?iso-8859-1?Q?FUAxGQgwF1MLqoCTsUiGiRZTDAs/XKLtmEn6YL8TfA80ymGuQkSZAs7YGa?=
 =?iso-8859-1?Q?JU/+WY3sfNQ7i1YmcoJyvBlOMyHduUcXi+Zc6aiANP7LL36/OQuVz8Yr9h?=
 =?iso-8859-1?Q?NHw4GJhA9d6/1BzBLM5qJ56KvJXiIUkHnly4bZvAP4Y8wtSMFg+Bft7NQW?=
 =?iso-8859-1?Q?iW6ZPFrkr9qjTshmJMej4T4j1+3ZPkMA0kMr3k4iuMpP2I4Vp5WblKuDOw?=
 =?iso-8859-1?Q?2IqhmNptckkCFIo1b/VqIWRoAwDPmpzOiobglwU1TvNxtNzRgyWWwH+c8o?=
 =?iso-8859-1?Q?Adzrw0UiQAiEymP9C9Fayvmc0Nzhw0c+f/Gk0P73eW/B9DmAtGhMBsCUmc?=
 =?iso-8859-1?Q?pwDT/M7VErafQTz4zQhbyaT8UurnsNo+E5QtLs+1PX1V4UUqGEQUw+R9if?=
 =?iso-8859-1?Q?NiSmYO15US5tgxkMfTUiJB5lpP1qtNyZdeqVeDFBBKwf8cV+xtB0pepq41?=
 =?iso-8859-1?Q?nVzzvZZLF+3yyTK9mBwIgjbTzm9mYJCmiEtWAqZQoBQPWAArTSmE6wWVz5?=
 =?iso-8859-1?Q?spW0B+et8vc06IznxXQULFIFBUC3KOJZA0kg948ZW0tjerlUNQaGIo3A8G?=
 =?iso-8859-1?Q?MX2OlU/bHVMB40wzPi86rEiekrKw5mwHn/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7m3HmhYV9dib9ImRfJS44QmFa2E/xtQaTgeYjylCNQ79Y8FJuBAW3l4DxhiPR5o+D+cjciF/Kcxa/smMBGIL/rzX4z0iqy78Xbs0Mm0wAuqRFfSqevdxkdsDyZ/g1aOBpPMuIr2CJ+63Dylsp1faCVr1vP+FPf//JD3UvUlFDQl364au6FGXq80DhjyAlPmhmMJEepChtl0n57JslbxVl8ff+zibDHvfuzuSV7qhXCDq6a0nJoHTTwfJ0wZAE5bd9qTGYPpuks4NLwxXA4WuGDAuaJE1q32SNhmbiwM6vgPGZWA+zw3qj/e9fZ0LyOk2P+kOx+kX0PVgwMEK5IGSIClwnOoOVKxYLznX0sOaPrGA3BumbqvVU0pvo5AQCJWRYDgDGfSXUFNnVrTqWXTPwm9WnpNkvnwZ3XN9SRgfPSP6eREdCoy49K8SDQNgR7KqYWQd/uh53rmutQL7KIk3efgjPWPlsZEO8RcrxSFmYPdTdUJE6I457tSxWA6H4hkkwxhFjk7P8TZZzOlYVsJeScRaqrlnN/V7TIDvxqLmKH+KLlaxVHM0bmSbV8VLJu5uLchjm9f1vdZZ79I+TsUpv5RXUp4XPnzwFzr9RaOluY0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07566c03-ee10-4ce3-1c43-08dce62f6237
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 17:50:36.7898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MITQ3Q84WJOdOEEkOckC6Jdm0vJwzQ53KaxT5EgLMmaowwEbl+FDawWRouRcLS5j6FOX2qGDSqw53JFHsB6Sjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-06_15,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410060127
X-Proofpoint-GUID: KbkFR4ShBHPJBGSZt86yEG1ONIRXtlR_
X-Proofpoint-ORIG-GUID: KbkFR4ShBHPJBGSZt86yEG1ONIRXtlR_

On Fri, Sep 13, 2024 at 08:52:20AM +1000, NeilBrown wrote:
> On Fri, 13 Sep 2024, Pali Rohár wrote:
> > Currently NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT do not bypass
> > only GSS, but bypass any authentication method. This is problem specially
> > for NFS3 AUTH_NULL-only exports.
> > 
> > The purpose of NFSD_MAY_BYPASS_GSS_ON_ROOT is described in RFC 2623,
> > section 2.3.2, to allow mounting NFS2/3 GSS-only export without
> > authentication. So few procedures which do not expose security risk used
> > during mount time can be called also with AUTH_NONE or AUTH_SYS, to allow
> > client mount operation to finish successfully.
> > 
> > The problem with current implementation is that for AUTH_NULL-only exports,
> > the NFSD_MAY_BYPASS_GSS_ON_ROOT is active also for NFS3 AUTH_UNIX mount
> > attempts which confuse NFS3 clients, and make them think that AUTH_UNIX is
> > enabled and is working. Linux NFS3 client never switches from AUTH_UNIX to
> > AUTH_NONE on active mount, which makes the mount inaccessible.
> > 
> > Fix the NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT implementation
> > and really allow to bypass only exports which have some GSS auth flavor
> > enabled.
> > 
> > The result would be: For AUTH_NULL-only export if client attempts to do
> > mount with AUTH_UNIX flavor then it will receive access errors, which
> > instruct client that AUTH_UNIX flavor is not usable and will either try
> > other auth flavor (AUTH_NULL if enabled) or fails mount procedure.
> > 
> > This should fix problems with AUTH_NULL-only or AUTH_UNIX-only exports if
> > client attempts to mount it with other auth flavor (e.g. with AUTH_NULL for
> > AUTH_UNIX-only export, or with AUTH_UNIX for AUTH_NULL-only export).
> 
> The MAY_BYPASS_GSS flag currently also bypasses TLS restrictions.  With
> your change it doesn't.  I don't think we want to make that change.

Neil, I'm not seeing this, I must be missing something.

RPC_AUTH_TLS is used only on NULL procedures.

The export's xprtsec= setting determines whether a TLS session must
be present to access the files on the export. If the TLS session
meets the xprtsec= policy, then the normal user authentication
settings apply. In other words, I don't think execution gets close
to check_nfsd_access() unless the xprtsec policy setting is met.

I'm not convinced check_nfsd_access() needs to care about
RPC_AUTH_TLS. Can you expand a little on your concern?


> I think that what you want to do makes sense.  Higher security can be
> downgraded to AUTH_UNIX, but AUTH_NULL mustn't be upgraded to to
> AUTH_UNIX.
> 
> Maybe that needs to be explicit in the code.  The bypass is ONLY allowed
> for AUTH_UNIX and only if something other than AUTH_NULL is allowed.
> 
> Thanks,
> NeilBrown
> 
> 
> 
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  fs/nfsd/export.c   | 19 ++++++++++++++++++-
> >  fs/nfsd/export.h   |  2 +-
> >  fs/nfsd/nfs4proc.c |  2 +-
> >  fs/nfsd/nfs4xdr.c  |  2 +-
> >  fs/nfsd/nfsfh.c    | 12 +++++++++---
> >  fs/nfsd/vfs.c      |  2 +-
> >  6 files changed, 31 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > index 50b3135d07ac..eb11d3fdffe1 100644
> > --- a/fs/nfsd/export.c
> > +++ b/fs/nfsd/export.c
> > @@ -1074,7 +1074,7 @@ static struct svc_export *exp_find(struct cache_detail *cd,
> >  	return exp;
> >  }
> >  
> > -__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
> > +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp, bool may_bypass_gss)
> >  {
> >  	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
> >  	struct svc_xprt *xprt = rqstp->rq_xprt;
> > @@ -1120,6 +1120,23 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
> >  	if (nfsd4_spo_must_allow(rqstp))
> >  		return 0;
> >  
> > +	/* Some calls may be processed without authentication
> > +	 * on GSS exports. For example NFS2/3 calls on root
> > +	 * directory, see section 2.3.2 of rfc 2623.
> > +	 * For "may_bypass_gss" check that export has really
> > +	 * enabled some GSS flavor and also check that the
> > +	 * used auth flavor is without auth (none or sys).
> > +	 */
> > +	if (may_bypass_gss && (
> > +	     rqstp->rq_cred.cr_flavor == RPC_AUTH_NULL ||
> > +	     rqstp->rq_cred.cr_flavor == RPC_AUTH_UNIX)) {
> > +		for (f = exp->ex_flavors; f < end; f++) {
> > +			if (f->pseudoflavor == RPC_AUTH_GSS ||
> > +			    f->pseudoflavor >= RPC_AUTH_GSS_KRB5)
> > +				return 0;
> > +		}
> > +	}
> > +
> >  denied:
> >  	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
> >  }
> > diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> > index ca9dc230ae3d..dc7cf4f6ac53 100644
> > --- a/fs/nfsd/export.h
> > +++ b/fs/nfsd/export.h
> > @@ -100,7 +100,7 @@ struct svc_expkey {
> >  #define EX_WGATHER(exp)		((exp)->ex_flags & NFSEXP_GATHERED_WRITES)
> >  
> >  int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp);
> > -__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp);
> > +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp, bool may_bypass_gss);
> >  
> >  /*
> >   * Function declarations
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 2e39cf2e502a..0f67f4a7b8b2 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2791,7 +2791,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
> >  
> >  			if (current_fh->fh_export &&
> >  					need_wrongsec_check(rqstp))
> > -				op->status = check_nfsd_access(current_fh->fh_export, rqstp);
> > +				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
> >  		}
> >  encode_op:
> >  		if (op->status == nfserr_replay_me) {
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 97f583777972..b45ea5757652 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -3775,7 +3775,7 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
> >  			nfserr = nfserrno(err);
> >  			goto out_put;
> >  		}
> > -		nfserr = check_nfsd_access(exp, cd->rd_rqstp);
> > +		nfserr = check_nfsd_access(exp, cd->rd_rqstp, false);
> >  		if (nfserr)
> >  			goto out_put;
> >  
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index dd4e11a703aa..ed0eabfa3cb0 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -329,6 +329,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> >  {
> >  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> >  	struct svc_export *exp = NULL;
> > +	bool may_bypass_gss = false;
> >  	struct dentry	*dentry;
> >  	__be32		error;
> >  
> > @@ -375,8 +376,13 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> >  	 * which clients virtually always use auth_sys for,
> >  	 * even while using RPCSEC_GSS for NFS.
> >  	 */
> > -	if (access & NFSD_MAY_LOCK || access & NFSD_MAY_BYPASS_GSS)
> > +	if (access & NFSD_MAY_LOCK)
> >  		goto skip_pseudoflavor_check;
> > +	/*
> > +	 * NFS4 PUTFH may bypass GSS (see nfsd4_putfh() in nfs4proc.c).
> > +	 */
> > +	if (access & NFSD_MAY_BYPASS_GSS)
> > +		may_bypass_gss = true;
> >  	/*
> >  	 * Clients may expect to be able to use auth_sys during mount,
> >  	 * even if they use gss for everything else; see section 2.3.2
> > @@ -384,9 +390,9 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> >  	 */
> >  	if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT
> >  			&& exp->ex_path.dentry == dentry)
> > -		goto skip_pseudoflavor_check;
> > +		may_bypass_gss = true;
> >  
> > -	error = check_nfsd_access(exp, rqstp);
> > +	error = check_nfsd_access(exp, rqstp, may_bypass_gss);
> >  	if (error)
> >  		goto out;
> >  
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 29b1f3613800..b2f5ea7c2187 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -320,7 +320,7 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
> >  	err = nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
> >  	if (err)
> >  		return err;
> > -	err = check_nfsd_access(exp, rqstp);
> > +	err = check_nfsd_access(exp, rqstp, false);
> >  	if (err)
> >  		goto out;
> >  	/*
> > -- 
> > 2.20.1
> > 
> > 
> 

-- 
Chuck Lever

