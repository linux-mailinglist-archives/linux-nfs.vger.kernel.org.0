Return-Path: <linux-nfs+bounces-8313-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 601879E0E07
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 22:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210DB281BD2
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Dec 2024 21:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568CA7E0E8;
	Mon,  2 Dec 2024 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RdVBHwmT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b3Na6SWW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FCD2EAF7
	for <linux-nfs@vger.kernel.org>; Mon,  2 Dec 2024 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733175715; cv=fail; b=WXjYHNRYdoAokgJpdYkmmt48BnBAtH28Dv6B4D4Av/RxWur1McQPxqJCMk/0adY+8yWZOjFiC/pm1A6LFeMuRJrsi1h9XN6+8MwI9twhSNnB3Bwj2gG1Q4gk32coQGBES8OKOqTWTfxwcPlgZr5nstqjcn1c79uiocGBMeJXRjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733175715; c=relaxed/simple;
	bh=XgzBW1AmYnY4e5z3z5wxJBjDJBHu5nvxbtxCf/vrVRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dwP1QzyAbK1ajkKUmQOllm3SLyj9Q1fkwGQL2XjdGFxncg2FfXX8lFNOYQQIQEKjLRtjESrV/Yj9KpmXePVULAYzUaWHC3xO9a8AIt1ISFqGGS8fiKntc1bzU5qmreDgyDgvn3FadDLndSLEmMdOxagQTW/MZkpu7sNgJuvUBwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RdVBHwmT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b3Na6SWW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2KtYAT013760;
	Mon, 2 Dec 2024 21:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=f0fTc/vDHvD37KOfH/
	IIsoTVJQwaSGbjVyRoMSkpDsU=; b=RdVBHwmTv+UaiH5FZjqy08mM6IqCyFfQbh
	w/rOs/nLqDY+i6hYMOeElMTXBlOivUQFoaMD9p0SNSmE0v5W9IT6BV4oA/pmYmXO
	M04We153wZXyfkVqVlli09iJ2iBXx/zQs0dvvh1UTpVfH90YOEEQwrpC07VvOYDd
	8A3Per1SuZ+2ZOnwCQUOYNnCZ8IfaiKR+zQkqn47TLM74TNenzbOS5FnFpByKvAL
	dwkTAoHoESxSNP7OamDB9a/BrdmmoWQ/cFJgUjdBOfABDdxXpJNStLFev6hSqOIb
	JkOM3nkVe4zDJDLaEvNKSbg+Jk3JurZqEAugxhMe/Pjd8VDUVJ7Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4c4r9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 21:41:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2LR2XA031053;
	Mon, 2 Dec 2024 21:41:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437wjbpetf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 21:41:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXah6pdQK4EJVP3w7BjgVCGQ/8bNIhIPMTHxL9tbKzeDhbWM1VLetkgxP8xUEdp0X0wG+2HM/TKd0vM0mxV3YWpKD+4MFtmViltINKdrZAq2px/DWoCfE6rVwRdXIXTsu7ZnSdlqZIBH6e8nacSjVP6r1CiUBPhQ6Iy8nz81pz+dHncr62ZSNmJGrB7v43O4JFTVZvRej6JD2zJlBkWE99fuXICGFE+aYb4uuBeS97F21/ivDfosMC1O4P4U4QntMuVJFbZuJ/gbXa3ypyKoeUMEb3Yk2YiBJY3y8ls3/9L7bQmVo1gmkkhC+R5eXReUbl1ywavlTzkA8R+1/PhJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0fTc/vDHvD37KOfH/IIsoTVJQwaSGbjVyRoMSkpDsU=;
 b=jUh6WhvmxSsNxvhocWsU1ZeLzHle5X0DCeyG6djCsuA0KBhu0SCWCzTyNioGtfT/eSRA+BnfIuF0b1kEebVS7ylOKmOnMGYKl3y7YlB+tl+OFiDDKj3QSazNMO2esHWEucUGHo/v8ZdYc3c6AxGaUOzUj8xUtcpQHAvUeKAFmuO8NBcMN92mCmQoyT4wNWMPuuw5LPhAKex7DBJguykKngZX9N/kZPDDYG+FCFB4m2kv6U6857SO9WgIQM2Em6RudXfw03cdyNBwYf32AuzA9YMcqUoMF/iB/2x9jChuV3pjt/N9gnC0a6guoTv/IfeD5nkGeZAlXeOTnwQdL5WGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0fTc/vDHvD37KOfH/IIsoTVJQwaSGbjVyRoMSkpDsU=;
 b=b3Na6SWWm+Q8IOLMsIZR7tsjywJq+QRKZe2NbFNFWayDm8JWkdzhFu6582VdxN4RWWUPNC3bK3WyfuXUoblExbnpixu1jX9N21GVhydXZHNvfWMGwSFHDBfTFTMfwdFhwxwpfqCgW7iZEqe3PaNwlKaBgk3MHvC9mwLAYyN4ahM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7386.namprd10.prod.outlook.com (2603:10b6:208:42e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 21:41:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 21:41:46 +0000
Date: Mon, 2 Dec 2024 16:41:44 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Scott Mayhew <smayhew@redhat.com>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] exports: Fix referrals when
 --enable-junction=no
Message-ID: <Z04pmCa0es/DH8WS@tissot.1015granger.net>
References: <328fdce3-a66b-4254-a178-389caf75a685@redhat.com>
 <20241202203046.1436990-1-smayhew@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202203046.1436990-1-smayhew@redhat.com>
X-ClientProxiedBy: CH3P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: b09e7f97-0159-4486-7716-08dd131a1f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/vR113P9ob5milp4bn82HpiVpNVutiaDOifqAQ9f3jEzAkTNrr1DrwZNJtSv?=
 =?us-ascii?Q?jBC5dWigGKFFOvaxHfXYvj1/bqS3ZGIjCwzz8yNXqa/XgG7IDZQU/l65/l4A?=
 =?us-ascii?Q?e/SBcC5WiU13grKj/fb/rluR1qrQXEJT3loZopPdKR4XjfjMJ5Mx4OlPYPdO?=
 =?us-ascii?Q?6ELfMCESfzLo57u5MYR222o75aT1hyvBC5xp2zpbKlwymPOyDDsabFznHPHT?=
 =?us-ascii?Q?UF6lqDuIqKeIMkC1ROCBkuHKrlVaOjU7uyqgewQqP17J0+GrOcHSDJsDxY6M?=
 =?us-ascii?Q?F82OJjrlfEdVXFAs6FOe1aejIX2nd6EfX+s5MQiFYaRZOshuqf1puWDf15zR?=
 =?us-ascii?Q?Dv4yMztEDMjFBIYTF9FoUgUqPaDXCuUVW4o+VsVZzj5AF53x9xo0j/wnAyFC?=
 =?us-ascii?Q?DpfswhxL2REQSIK+EONJ9GQt5oRL1e1UsEnmVXVKfw3A8iCHwcr4vkIaEavm?=
 =?us-ascii?Q?Kl071HehJa7DNpW4BmviLVvxDJ9Bj2jAs4CIBWFG5UldjXcf7zpbP6ZtYF3n?=
 =?us-ascii?Q?tt6+LOjo/u9DeXGT9Ue4bmCXPPERHhJ49tORbOhcDJTZwY2o1Zkb07SbNZtv?=
 =?us-ascii?Q?Pjoi30ugWW7yDXEK8gKGd9A8qPPuGZMWlvYJG48eGbCv2w8fPhb2Ot4Df6Mn?=
 =?us-ascii?Q?mtSYmlPVNsTz/x2eZZmMhVd+vjasi9LAcKfu/6q/glNyD3x2h5BGTBA90J2C?=
 =?us-ascii?Q?/tSiNrqJgamH52b9TyNHkN7E4m7/HTm1Maw673aZ/xxnbakoMjJEuroFtUUs?=
 =?us-ascii?Q?9puee3ZKdwzQtMjt4Q0Ow9EmIEYUJCQB+lPGdkCi9tenDWSArCBIkGFK1oGh?=
 =?us-ascii?Q?FhysqtBXyDF0mJvNcnpdeaRkLGHgdTNqRbaz4WI6U0dWB5XX+ei65D6Gjnv6?=
 =?us-ascii?Q?+cC3wJAiQ9URNUqLts5d9wmPkStgedW4DaenL9OViIcLKxmhrjAnzZFxXnYm?=
 =?us-ascii?Q?NdEWpW+OX7cdiqfwljXUF1iiajT5cAts4TmXtLFneUftP5EXvqa3Xy4IULvb?=
 =?us-ascii?Q?Gp8mJSliirDw5Zlcdf6u1dL6UOewPi3u6cij47AjCuC7d0RQABQZrZkkhmdJ?=
 =?us-ascii?Q?aItnTTPJMDhDvNzKctQp6j9hsMtV1Wg/QCpWbkDKK1LlD+Dbn7lhuwgI5XVb?=
 =?us-ascii?Q?O2aBR4b/jGvL8Uhb3kVJY3RekpaQ8yRW8U+mydCsJunAGWvnLWOnfD2hWHlv?=
 =?us-ascii?Q?r6MV0PLmW22GBOO6ZYWwRG2b+05Cc/ISt4XNiSjx6J7jLyvngudScnIEqLSl?=
 =?us-ascii?Q?VAMvMF7I/+NXl7CtFNEaKZmLkRTFazLW/4NhVdsqtt1z0s9enidHk+VeUKwI?=
 =?us-ascii?Q?I+shPu0tVQiZIoAMPpi4nJmswoUvAJbS+tLHifWyR9d49A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zLhlJqToLYYgpI+pWYcO6MR4Q7kUJMjLWmOpOwxjHemp6UPhi+T9KqaK5XZa?=
 =?us-ascii?Q?VgMHXxH9pAf8KUT8FCluM6X/7oY9aa7Mh32k6owVIixyhXrA0OKnsIQK3xYN?=
 =?us-ascii?Q?gpIqf0wfkD6U5jLHQ0F9RCNI3evc3P7QHc/9cmJU2nrT0dRVr9t1DG+WkHLl?=
 =?us-ascii?Q?PZspEWWIqn/Nlk79X3p0BdsZaI5KU4+iFr1cir5BNEGdm4JLOrfzFiz3zamf?=
 =?us-ascii?Q?oTKFtgU4TyfoVMPjy/N7KYFfevMnoP2d9SNynKl2XcnHchXFyYCn7FV14A2X?=
 =?us-ascii?Q?/931T3greddfhSxGQ7uZJiaKixdWuQvIwTpm44skE61It+G2Ea7vy8hpUUYD?=
 =?us-ascii?Q?/M3GSJBsB9czYzlA4RXGTPxTaofMOKhjHRTcDlBbI0kM+hIaHjOD7qxRYwD8?=
 =?us-ascii?Q?4/VKS+iLEOJfGKftH6036tdslkTYvmXyDjQ7M4TBVed2NhKUNY2NRe5jLLx8?=
 =?us-ascii?Q?y6/hPnx+KmoUH1ME85y0kmcQ9KqRnjiuv2SdFoeEHFyVtT9aQ7EsqlNDOjBf?=
 =?us-ascii?Q?Ps0Jx0RWot7FYOjGwMWkCy4YQtAo25DCUF7za1nYW+94nleghdOdrdydtm1k?=
 =?us-ascii?Q?Klu5zs33M6TTLDjopYFC1MGvWQM3sRPI21rteb8kQLVfRW4f6t4zIa9xj3aI?=
 =?us-ascii?Q?iioGp0xLf/NW+QcYbj2cBm/u6B9L5oTMh9AsvGVu/8Fm8QBQAa4Bx1Pxiiq0?=
 =?us-ascii?Q?UMTfmB8vRa2bDHLViG9gLAMKyw8YvmOYZiwGkOmnSAZQnA1o95BknKr1lzum?=
 =?us-ascii?Q?a3ChvBdB82waTvZKStSdfO0qG/VE0wh0OdCot8AenyCa43h6t8JgTuQQYm+c?=
 =?us-ascii?Q?OMLW1TNivwLi5j2voOgNYFSvpWDFjbRDBj33kWU9SEYVNou61GVaLtpv10dF?=
 =?us-ascii?Q?pX4Bg12KcARfoYhCqnMyw4WbJR5MgkByOCV1RcL6sRf3CpLjOBclKfL33GFP?=
 =?us-ascii?Q?czB5Kjd5wQWpCW0jQ8jKRUomcTZrWI5NibwE8tq1rebgFO47AOyFK9eJqbsG?=
 =?us-ascii?Q?4y2sEnS7g7e3UqpFVZS4L/csmLC56WtzpUc5U9plKDweemSfWRMjNyNuM+l+?=
 =?us-ascii?Q?QuNYUhZ97zuDgP7V+Di4CXl3xVTu3XXlQug37jY7Jl5hZHB13MMS/n9BxchF?=
 =?us-ascii?Q?W5DLKRDMpCAjO5d+O1gh0O8LX5tiktV6vIR7+6alFnPgSYeu7UDWk4hJQJAF?=
 =?us-ascii?Q?xtRCd88siD19ZM+mSKW7oMVI8WSiwVovJgxew2KgM23JFPiDJ7L0DwPXE6TI?=
 =?us-ascii?Q?xG8NGRlvWvScCHqjkm3hnRYKfnms5OdMHBsUCoGB2WwPRQwUAmhFxynDHzoA?=
 =?us-ascii?Q?LdquKh07EZU8mlwT5pfmsE0gOnO+MbT/5zir6GJgM9U5U2y6idVqgWaoVqBZ?=
 =?us-ascii?Q?+8EPV06SV2fmkRS9VhFf+zX/Eo1qgsPH0L6+D5l9i68TXE5jQuI9VV777mc6?=
 =?us-ascii?Q?LB5hr5OSYJxYIp+8MWgXuz9oKniKveGJk2+b1YmumKqr+tJStR3YsXHnvHo9?=
 =?us-ascii?Q?UISm/rm/OsqX7UOICjGhTSWVpQzECwdb4n8aa5N64MKv23Hv+o4M+njpsAUX?=
 =?us-ascii?Q?4Bxvhb6ef20/z4r15bzAgcA/Yo4yVNpgkWksZlxKek285qusW3McuCjqijYi?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3JufPEcTZMvSzAmYq6RSCUg1aCkZGF+LGrRpt5pQvdPhgIuKvJodpC+fMJIsddIVrl1et74CdBbXeY14NdwxJIi/wpf5ml8RsmNoJZUmx28aaeg7fAPtTvc+VM48aWxk79WgS+iufCkBvyV7NDjmU4mWaLXPocdAwonilqIfKO4crBUDQy6Um8A83Pzc3UZxLadanBvpnbTI2miFviJDoOiCHVsmdXza2yuwAU1XXpmhnH3wIdH4hHIznxTXmIxMfh3djt1tvWFz1hKRoybTO7u8D4tNKnvE5QdZHS0julwlEENRvmuJ06ZoiXsP6a5HLeSxsPb0hdgsL83a7yJdvLq2Zgsp+cQxdVKYZzKv9roS1S9YOu7/iGihNTj2sg7Cr48U868X0u91bLbjK8qcsg9iYIYjZLE5VvgAkL3vGRUlc8Tab6SeQzzCFDn67l0KGucSDh827ICYssiHrLeasqEHhRl73iQhtb801RR7pKE6lhbZgev6pydjoiX+cNy+KQT9/jZG6qBslmXeQi9+N5tbwN6c9OSlLHlmmChI8J71cMNgKN4Moub/21ZxBS3u9Dq0apYpo1U4HxbcpT9wky+0r+zjW6PwxFuSaSx3FNo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09e7f97-0159-4486-7716-08dd131a1f07
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:41:46.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mu4X96Bc3AWrxUBKYs+fOADEG0opef5p2u4SnyDBq9Cig4S72oNIdFdx9ZfW2pTDg+wurRssuyzUa6PJfj9kAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7386
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020180
X-Proofpoint-ORIG-GUID: w-cn05pRYGbrzPRJxpgulZGIV5ah-E3j
X-Proofpoint-GUID: w-cn05pRYGbrzPRJxpgulZGIV5ah-E3j

On Mon, Dec 02, 2024 at 03:30:46PM -0500, Scott Mayhew wrote:
> Commit 15dc0bea ("exportd: Moved cache upcalls routines into
> libexport.a") caused write_fsloc() to be elided when junction support is
> disabled.  Get rid of the bogus #ifdef HAVE_JUNCTION_SUPPORT blocks so
> that referrals work again (the only #ifdef HAVE_JUNCTION_SUPPORT should
> be around actual junction code).

I agree, this looks like an unintended regression in 15dc0bea.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

I suggest adding:

Link: https://bugs.debian.org/1035908
Link: https://bugs.debian.org/1083098

> Fixes: 15dc0bea ("exportd: Moved cache upcalls routines into libexport.a")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  support/export/cache.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/support/export/cache.c b/support/export/cache.c
> index 6c0a44a3..3a8e57cf 100644
> --- a/support/export/cache.c
> +++ b/support/export/cache.c
> @@ -34,10 +34,7 @@
>  #include "pseudoflavors.h"
>  #include "xcommon.h"
>  #include "reexport.h"
> -
> -#ifdef HAVE_JUNCTION_SUPPORT
>  #include "fsloc.h"
> -#endif
>  
>  #ifdef USE_BLKID
>  #include "blkid/blkid.h"
> @@ -999,7 +996,6 @@ static void nfsd_retry_fh(struct delayed *d)
>  	*dp = d;
>  }
>  
> -#ifdef HAVE_JUNCTION_SUPPORT
>  static void write_fsloc(char **bp, int *blen, struct exportent *ep)
>  {
>  	struct servers *servers;
> @@ -1022,7 +1018,6 @@ static void write_fsloc(char **bp, int *blen, struct exportent *ep)
>  	qword_addint(bp, blen, servers->h_referral);
>  	release_replicas(servers);
>  }
> -#endif
>  
>  static void write_secinfo(char **bp, int *blen, struct exportent *ep, int flag_mask, int extra_flag)
>  {
> @@ -1120,9 +1115,7 @@ static int dump_to_cache(int f, char *buf, int blen, char *domain,
>  		qword_addint(&bp, &blen, exp->e_anongid);
>  		qword_addint(&bp, &blen, fsidnum);
>  
> -#ifdef HAVE_JUNCTION_SUPPORT
>  		write_fsloc(&bp, &blen, exp);
> -#endif
>  		write_secinfo(&bp, &blen, exp, flag_mask, do_fsidnum ? NFSEXP_FSID : 0);
>  		if (exp->e_uuid == NULL || different_fs) {
>  			char u[16];
> -- 
> 2.46.2
> 
> 

-- 
Chuck Lever

