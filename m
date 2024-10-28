Return-Path: <linux-nfs+bounces-7541-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CEA9B39F3
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 20:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7F0280C4C
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 19:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08111DF267;
	Mon, 28 Oct 2024 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HN2ahKCw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CofYRExE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736E18DF77;
	Mon, 28 Oct 2024 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142338; cv=fail; b=tgx9f010QRHAD8rwGnFddaPPpwHY896WKooE7PkMKZaBqxzU70+Sa4dJVjEqiU+ioUHwUJ2lCgYwhs7VsnVwqUvi6KeCWLLBErJ/oMi9aE6X9i9ThA7IvGZy/qnrwUBfUqvmBj1viXbtD/coWfa+6Ffq+qjarFhsFrbKAv6PwlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142338; c=relaxed/simple;
	bh=TuZQVWZ10BNNKhVlRxVM/kMXwajEJ7s34d8UhTt8Vjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I4dgWDHFxNYN9LxbYzVFstzwhl7XgwSU4PAN/RrROm8M6Mk8QXfqwI7HcYzjnEPdYMgMjw42WVp1XVMs3iMwt/nyS2jHBFVLTI7U6IozhgH+5vXxJcjB8EFKkZvIuVgdWqE3dHvhmj3MJdosU/DqsGwtTZF63NdTdieJMWb65NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HN2ahKCw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CofYRExE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SEtdgj031463;
	Mon, 28 Oct 2024 19:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=5HlwkyaZs1wj44R2D8
	VOvmlEVth3mh3B3d9YtL99MZI=; b=HN2ahKCwj1/vHU0vUtYO9GYzgHMdoEp04/
	qE4U6TQsTC9HTVSQ0Us3pJTqfX9dBiCR7ZGctuNxNMSzc3qupuE41FlqFBtsU1A+
	ZEgHB+Pmuv42UEEU6xS9s54fcP8uXRYR/lYwoloF7jLKPldeaOuHAZW03MlbuJAx
	Gc8Qg1gsz7eNpQ3Ch+mpZuOiUfoQdtyFd51uuRa3JnQOB6AQwiuSHjljAdna13eM
	64HFxQrOg9WPf/OKJBBIF4dV0VsFjgCFMT5DD2wtoWTCpqF4f5V6nc/RS3q/VEPO
	Iz2vA/6vvE/k3pmnzpTyVmuQVihk/2pvvn9B99T/pFVD/rj/GZgQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxkr2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 19:05:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SI1Fue034965;
	Mon, 28 Oct 2024 19:05:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnd6d4sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 19:05:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPVdFwJkkGsrRgH30K9E7oyMH3joxt4MxwDXYoy4+cN5RSKpWheVYQfuH7Ip3SEjKQFz3HBpzjx6KDHTEJjSGINIehcW4N55z9H5qtnrroP5zLN2zIwvBv44U/Z/dMP13fduiqeShVpt1x4tQyvGRitZWvEZPHpydE1JP23PiRGyDh5cALSqcGTUetUjs3KxFRbULkrBNqs90/1drPpoZGck58WLO54djgpTdgiV2VBFWwQl/zIhGD6tL01xsmXBcFGke6useuAXo075N6KohSjj5SXuGhH+26vnHawmLZvA1zCZihaTNZASL/UrRFvh4/Fg8RJClbXdIOyq4D50EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HlwkyaZs1wj44R2D8VOvmlEVth3mh3B3d9YtL99MZI=;
 b=hA2rpj0KU147Rf6e9gP5YZLUErKeEDpS/FphlYNsD8lTTA4ClCopP0CzmsE4f6ARBjN52pyF9xkC4FbDCpnE8vN8+SW6311cg7xp2SAK3pjQih8yIcetuFkEaXjMKhcntIsXqniy4JxnGrCVuwZkMUFr+0SxlwPhxQ7V5/TiZHPc64T6Vdf9fj2vKZKm/WcxLY1Bv+Y1oHNbgKmGEhRrXMG0//taroTxTYnK/leuEWhhP61ublSi8N/tJKpZQr4TbcC15fOKTflBLPFU9+/vkscjEJP3LQVni1ekO7tBNDOPKJgnbvHSiW5eTc0UYEOq7x1xISBs8ZWMHS36nJFPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HlwkyaZs1wj44R2D8VOvmlEVth3mh3B3d9YtL99MZI=;
 b=CofYRExEw5D0PZYy/FCInKQbRM1UaU7GGl2Mew97/17aBI2LnPABeh6AgpN30VRCpkLOfyW8anY21RHBpL/jkpZzgZrZbt6Q94G/4Yj6jE5Wn3aoMKlQVUvI7gA6W9PlWMuWraWtx71P46u+SG1WD0kRd8R2CFUKBOyEJznVXpo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6594.namprd10.prod.outlook.com (2603:10b6:806:2aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 19:05:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 19:05:21 +0000
Date: Mon, 28 Oct 2024 15:05:17 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nfsd: allow for more callback session slots
Message-ID: <Zx/gbQmNS1vXw2Jq@tissot.1015granger.net>
References: <20241028-bcwide-v1-0-0e75a8219dc0@kernel.org>
 <20241028-bcwide-v1-2-0e75a8219dc0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-bcwide-v1-2-0e75a8219dc0@kernel.org>
X-ClientProxiedBy: CH0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:610:cc::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 391c94aa-69ac-4afc-4b73-08dcf7837881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6SCtLFLHPr4PFYNg2U/6PZQ14HAij/cDHDllln0rDEKSu5tk99Qdg824XdyS?=
 =?us-ascii?Q?cuAGMse8CCB8Vz1FV16JDds+nSpkrtI8LmB/2PxE2+qdOYxZa8U9XP+B+SHb?=
 =?us-ascii?Q?fBNvit0pyVVURqxUV2tts5aQcXHXybINpXFtOBNdnzkcOcbxifZQjl66XcN2?=
 =?us-ascii?Q?byM49z6G6aVER2P/lYJkxRtUSy2o5HkxY57lrwj3+GW+bOFwnMGJ/mKjAldF?=
 =?us-ascii?Q?1ScSg2jYqCSgxa/wWDacIlee9E48r7qlyf9q+vRBXwjjJDBOxQ2lEFz7hvJ7?=
 =?us-ascii?Q?MnvilSUbjM/olivzmq7fz2QH7LyAXc1lcczXRrVodIcX6EqG9k18lNW8BH2E?=
 =?us-ascii?Q?fo5w7jBnmKz8HTEqf8Scie3ZlJFR02a0VP9qWMd2R2Ag58U8Wjw0+Tw+u8jR?=
 =?us-ascii?Q?3CHtHgQeCVsmEnt+8PRQmTeoa02B7y5d7MBDwU4GaloHCAFU+11yzDmhNC5p?=
 =?us-ascii?Q?nznVzrsNZ1a5Jxiyp7cIcxK0Ny3JznLtomLtUE03gr3+N8iMDsXoJRUGOHex?=
 =?us-ascii?Q?SsWj8EdfMq6WdBQJg/tZ4xYY9VICqXs8aiPcDdtWIyhgX+3v4kLsn58xnXrL?=
 =?us-ascii?Q?z4oPtDpY2mveVdWQLih5TXYr1vKPys1cbr59EMLFo8p+G8N9Qc8NhC9pQbzN?=
 =?us-ascii?Q?LztsN/mSbSyK0l/vR711JBQQ9tEU65kAVe538BY9JMpfWmlnGOBnME08868T?=
 =?us-ascii?Q?0n35wfhnx1XAynUozCPqQvZXtJDFLLb5AHS1Vhc6s+cO1eQqa+m/xkgIUEBa?=
 =?us-ascii?Q?98Eg/Nkp01/a4UdPy1prCo2ltqDTlsszhHVqJYeqHnmHBE7IjvXO80+0AYFS?=
 =?us-ascii?Q?U1ohXu/qneAW3NlGRDq/Dz6dezQy00SmZ4c00bQthJ6zuYYm/oZUCrhIMy3h?=
 =?us-ascii?Q?/J7Tsq3d4GLXKWCWvsCiYg1Jq+vJYv1EXsm3eNLxNWQ0tJuythd8ZBSohJlU?=
 =?us-ascii?Q?q2d5LzSlyfNLy0n00gDyfl31gXwHMKGONfCbR3PBA5QuS0ke44MM3Bcc2053?=
 =?us-ascii?Q?OYMV2+ldVEPjAhQ/3GRXsFfmckL5HOpaiYWuw5P2uO+TMg632VFYlUeN24ss?=
 =?us-ascii?Q?rfvhfz+mMgVo1WxbTZkE89vXzmuictklfKOXaAnj6ltVO1XFlevlzC7ztBkd?=
 =?us-ascii?Q?qR/hJBc7mkpu60t3KAeLUp989/Z/SVyPiW9FtJbyleq9kkDd9K0J/JsuRj7s?=
 =?us-ascii?Q?iN7CgcT3tvFPpcxAJ1GqpROn1Yxf6h/TCGC1cH5D4mS/qjYOscq/sECI858y?=
 =?us-ascii?Q?zUsY8XWkCKRGaHKzTwanjGPcH0UOJ5Am0PnCAAxj+fT+bvg3uENXlGJAqydQ?=
 =?us-ascii?Q?sfZX5unhPL8yNXcnwKIW6EMo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F7AAtUXPpvgmUJd6niWKMsU1CHeNe7oy0dcBBKAGyvINpw56gIUFSTznD9Zs?=
 =?us-ascii?Q?6xaByTeyEaZBF4+K+o4yHZ1OBip2VgDx8puHfmYkZojXQH8yTpPnxUzhtgoT?=
 =?us-ascii?Q?wbRpM0WJkJf73Jk8hpXO6/Elj0mPK0xBRp9mFHITmtbNd+1CQsw+9SkBhlVW?=
 =?us-ascii?Q?aSuMHnpysjgypVAMyjATzzTn/k3tC0p+mYvIl+2KTvbWY+lEJrIgv+Mjwres?=
 =?us-ascii?Q?IzsW71yQGS1yL5T3SVGPykDLfCYaw87buGbit7c5GKNb87mQStMC580KevBH?=
 =?us-ascii?Q?TcaHq1IyvRC8HBMoVIwkQnsmXInw57qBHNcRHGCLIB0E6VxnZ7NtCTOmY/yw?=
 =?us-ascii?Q?KIwg6WTn6xGRPct69OU9Ec5ciDbegLlYgqbMRgMAVvd145VFA5EPy1h0jpIl?=
 =?us-ascii?Q?p9xu8Av4bNUnLCtXLpYMiIl+UeaYur2myketOSjwKkiNJOPSk5QAgPnG3WE2?=
 =?us-ascii?Q?EMqDAGGtewjdKwrC5ClpUBfsQN7LLePPPDoA6y52VkHqh9/PO/aFTzSghLpE?=
 =?us-ascii?Q?b6qOv61gVUVy2xxkuL7NeyyjBoaN55gFvbywT+KOmBjsqiKA6qJ9CbGi/Eff?=
 =?us-ascii?Q?zcYnpk7xqQRB/IKHcB56Tlyp2r3NdEttvpuP1qSLSh7rVlWfnuRf06JIXKhH?=
 =?us-ascii?Q?rBIZ//kO5LDs/minGq8hueihADUWNOsuG2hDIO2bef+1t1iuytdV3186C8Pk?=
 =?us-ascii?Q?wnIPXzReKm4HHta7K2jF2GSBp7JITE8wJcy/oKKlt61Xis0BkIIpnF3wgTcr?=
 =?us-ascii?Q?Uklw0wQAYhSkyWMkwpfec168YM0jmJBHoe3/5ItYRj6Mg7IOHt/4XfMOmTuq?=
 =?us-ascii?Q?D4RrUHTYtOsG3omkPjhmJKlxPPE6e3QzdDkk2cwvH+o7t/gTdxHkwshfVBrk?=
 =?us-ascii?Q?KdiRiP+bVr6W70FOyBEKf+dW7K14K+6VNRb3uyPjHsINZ5v/DUMXIVYV07kv?=
 =?us-ascii?Q?b+EnFMnTzDtHYssfIjEnNQRUdTyFIkM5MEGS54XrD/7A/TAyjGFkT+Do8SAA?=
 =?us-ascii?Q?9TtTbrv/jIllVBeNAoLHDUJA5T3DGcYyOV6HnwOj4pQhDQlMF8Glagd7Q1NN?=
 =?us-ascii?Q?GIbxys2Dbo/dlW4qY/NLvuxmJtdfAq9AWuEJ8rAr4fDCzx2tWhJ/wfwlPewg?=
 =?us-ascii?Q?wnJBx6ja2qTjbFiD1EzgcZSCSEruEP7AOfHc7YkJOQcX/snjC4uYMMxjEtzq?=
 =?us-ascii?Q?JYpkhf05sD6IE65vivCNGaNvdPBNb5MVlsgRnEWWxQxe/w79d8NRONFoThKN?=
 =?us-ascii?Q?uE6fusaYjJ3BoNOdVnbOxNyB2D9d0nmi93Jwyi2KqUM4GEigBdJ4XSMi1tdQ?=
 =?us-ascii?Q?OGOgt0uAzJycARXrVLMklxGYkrEbKfgAnR8aWKyGTBYWh6Wg1OWzdcWdf4H4?=
 =?us-ascii?Q?Q+7MOEpKVa5tR6Ml4A55r1KkUJdXH8z5Vg5vmBRruAG6kJO71jrJiw5E57Ju?=
 =?us-ascii?Q?mbVOcVRhFXtrzC6j//0eWuLrq43Tcpdf9XQglXgLDqKX706jMMuaUecQFPaf?=
 =?us-ascii?Q?x8gYCv6mtC5dXbTTkVyeDUr+ZnPgjwnBNLds1sm6L260aNbz/n3VmTrQrGZf?=
 =?us-ascii?Q?Y7GmpDFqbnoyPtc7puJOLIbV4AF/IV1wRS+9BGsF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZZU8zhTiGN/i6TJBjeA0lB7PGwdpAKtefDPN/ns/GFMQuwyAxSr57WxMkOBYHj7avfnnaISMcs9butP+bf0dJy5naocNFu+lHjRiBDJf3bZTVHts4mPq/OD2caFgKFRxsZyx0FcR9XaHCNl1II+H/87azgR7hBdQqPM5jp8VpN/w2YiR8HwN45RLnRKdZVFjAiurs8G2QHfqfnuSXEXTPvuF5XAdjWriNtxmzKLbdMDEltbwPpUPu3vEVjS29NUE0Vlted9VnOQNBL69j/zyFjC3o25gbQU46u4fzigK5+5krDQT+GHlHDWulPuEoBE7ngBXPb5DvoXPgDCiJ0R0PZ3/wr8bptsy8K5EyQzyCLCVHoRtWwQUOGS1/MOfyQl3elDhMx3ZU++XIv2crVqWT+1g5BH81qj+yFgVlTjewQ1HxEPYGu5J4mngIiND/g3VDKNOcgA9jZcZh9rGHPZRstGoLE2amf/XVkZOs8rJed0iHa388djKPsvW7f/VKQEcAlQm1KW931LYZlqnw/TYHIpeg6enxTMpJUiSkHuLHd66WEVjl4K+t80t/Cpq1AuwpWwcXSqzRyd0+3n2EQEIoSiDGuNGpCW67wvRN37MMlU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391c94aa-69ac-4afc-4b73-08dcf7837881
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:05:21.6374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAdb2KTwOo3ZkDNoSpfYUhpUFfP+7XyWwY+HEzt9jcAOvms4LWAaseuNNieHDa+xuwGBij7ft3Pc0tD965vi9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_08,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280149
X-Proofpoint-GUID: 0qly-uJHKtzSRKG7T0AgKhNu50Qw3u7B
X-Proofpoint-ORIG-GUID: 0qly-uJHKtzSRKG7T0AgKhNu50Qw3u7B

On Mon, Oct 28, 2024 at 10:26:27AM -0400, Jeff Layton wrote:
> nfsd currently only uses a single slot in the callback channel, which is
> proving to be a bottleneck in some cases. Widen the callback channel to
> a max of 32 slots (subject to the client's target_maxreqs value).
> 
> Change the cb_holds_slot boolean to an integer that tracks the current
> slot number (with -1 meaning "unassigned").  Move the callback slot
> tracking info into the session. Add a new u32 that acts as a bitmap to
> track which slots are in use, and a u32 to track the latest callback
> target_slotid that the client reports. While they are part of the
> session, the fields are protected by the cl_lock.
> 
> Fix nfsd41_cb_get_slot to always search for the lowest slotid (using
> ffs()), and change it to continually retry until there is a slot
> available.
> 
> Finally, convert the session->se_cb_seq_nr field into an array of
> counters and add the necessary handling to ensure that the seqids get
> reset at the appropriate times.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4callback.c | 107 +++++++++++++++++++++++++++++++++++--------------
>  fs/nfsd/nfs4state.c    |   7 +++-
>  fs/nfsd/state.h        |  12 +++---
>  fs/nfsd/trace.h        |   2 +-
>  4 files changed, 89 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index e38fa834b3d91333acf1425eb14c644e5d5f2601..64b85b164125b244494f9805840a0d8a1ccb4c1b 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -406,6 +406,16 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
>  	hdr->nops++;
>  }
>  
> +static u32 highest_unset_index(u32 word)
> +{
> +	int i;
> +
> +	for (i = sizeof(word) * 8 - 1; i > 0; --i)
> +		if (!(word & BIT(i)))
> +			return i;
> +	return 0;
> +}
> +

Isn't this the same as ffz() or "ffs(~(x))" ?


>  /*
>   * CB_SEQUENCE4args
>   *
> @@ -432,15 +442,38 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
>  	encode_sessionid4(xdr, session);
>  
>  	p = xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
> -	*p++ = cpu_to_be32(session->se_cb_seq_nr);	/* csa_sequenceid */
> -	*p++ = xdr_zero;			/* csa_slotid */
> -	*p++ = xdr_zero;			/* csa_highest_slotid */
> +	*p++ = cpu_to_be32(session->se_cb_seq_nr[cb->cb_held_slot]);	/* csa_sequenceid */
> +	*p++ = cpu_to_be32(cb->cb_held_slot);		/* csa_slotid */
> +	*p++ = cpu_to_be32(max(highest_unset_index(session->se_cb_slot_avail),
> +			       session->se_cb_highest_slot)); /* csa_highest_slotid */

This encoder doesn't hold the client's cl_lock, but does reference
fields that are updated while that lock is held.

Also, should a per-session spin lock be used instead of cl_lock?

Is locking even necessary? All of these calls are prepared in a
single-threaded workqueue. Reply processing can only free slots, so
it doesn't need to exclude session slot selection.


>  	*p++ = xdr_zero;			/* csa_cachethis */
>  	xdr_encode_empty_array(p);		/* csa_referring_call_lists */
>  
>  	hdr->nops++;
>  }
>  
> +static void update_cb_slot_table(struct nfsd4_session *ses, u32 highest)

Nit: Can you use the name "target" instead of "highest" ?


> +{
> +	/* No need to do anything if nothing changed */
> +	if (likely(highest == READ_ONCE(ses->se_cb_highest_slot)))
> +		return;
> +
> +	spin_lock(&ses->se_client->cl_lock);
> +	/* If growing the slot table, reset any new sequences to 1 */
> +	if (highest > ses->se_cb_highest_slot) {
> +		int i;
> +
> +		for (i = ses->se_cb_highest_slot; i <= highest; ++i) {
> +			/* beyond the end of the array? */
> +			if (i >= NFSD_BC_SLOT_TABLE_MAX)
> +				break;

Nit: why not cap "highest" at NFSD_BC_SLOT_TABLE_MAX before starting
this for loop?


> +			ses->se_cb_seq_nr[i] = 1;
> +		}
> +	}
> +	ses->se_cb_highest_slot = highest;
> +	spin_unlock(&ses->se_client->cl_lock);
> +}
> +
>  /*
>   * CB_SEQUENCE4resok
>   *
> @@ -485,7 +518,7 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
>  	p += XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
>  
>  	dummy = be32_to_cpup(p++);
> -	if (dummy != session->se_cb_seq_nr) {
> +	if (dummy != session->se_cb_seq_nr[cb->cb_held_slot]) {

Nit: Let's rename "dummy" as "seqid", and add a "highest" variable
for the next XDR field (not shown here).


>  		dprintk("NFS: %s Invalid sequence number\n", __func__);
>  		goto out;
>  	}
> @@ -496,9 +529,15 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
>  		goto out;
>  	}
>  
> -	/*
> -	 * FIXME: process highest slotid and target highest slotid
> -	 */
> +	p++; // ignore current highest slot value
> +
> +	dummy = be32_to_cpup(p++);

Nit: I prefer a name for this argument variable like "target".

The compiler should be able to combine the usage of these variables
into a single memory location.


> +	if (dummy == 0) {
> +		dprintk("NFS: %s Invalid target highest slotid\n", __func__);
> +		goto out;
> +	}
> +
> +	update_cb_slot_table(session, dummy);
>  	status = 0;
>  out:
>  	cb->cb_seq_status = status;
> @@ -1208,31 +1247,38 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
>   * If the slot is available, then mark it busy.  Otherwise, set the
>   * thread for sleeping on the callback RPC wait queue.
>   */
> -static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
> +static void nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
>  {
>  	struct nfs4_client *clp = cb->cb_clp;
> +	struct nfsd4_session *ses = clp->cl_cb_session;
> +	int idx;
>  
> -	if (!cb->cb_holds_slot &&
> -	    test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
> +	if (cb->cb_held_slot >= 0)
> +		return;
> +retry:
> +	spin_lock(&clp->cl_lock);
> +	idx = ffs(ses->se_cb_slot_avail) - 1;
> +	if (idx < 0 || idx > ses->se_cb_highest_slot) {
> +		spin_unlock(&clp->cl_lock);
>  		rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
> -		/* Race breaker */
> -		if (test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
> -			dprintk("%s slot is busy\n", __func__);
> -			return false;
> -		}
> -		rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
> +		goto retry;
>  	}
> -	cb->cb_holds_slot = true;
> -	return true;
> +	/* clear the bit for the slot */
> +	ses->se_cb_slot_avail &= ~BIT(idx);
> +	spin_unlock(&clp->cl_lock);
> +	cb->cb_held_slot = idx;
>  }
>  
>  static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
>  {
>  	struct nfs4_client *clp = cb->cb_clp;
> +	struct nfsd4_session *ses = clp->cl_cb_session;
>  
> -	if (cb->cb_holds_slot) {
> -		cb->cb_holds_slot = false;
> -		clear_bit(0, &clp->cl_cb_slot_busy);
> +	if (cb->cb_held_slot >= 0) {
> +		spin_lock(&clp->cl_lock);
> +		ses->se_cb_slot_avail |= BIT(cb->cb_held_slot);
> +		spin_unlock(&clp->cl_lock);
> +		cb->cb_held_slot = -1;
>  		rpc_wake_up_next(&clp->cl_cb_waitq);
>  	}
>  }
> @@ -1265,8 +1311,8 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)

Nit: This patch should update the documenting comment before
nfsd4_cb_prepare() -- the patch implements "multiple slots".


>  	trace_nfsd_cb_rpc_prepare(clp);
>  	cb->cb_seq_status = 1;
>  	cb->cb_status = 0;
> -	if (minorversion && !nfsd41_cb_get_slot(cb, task))
> -		return;
> +	if (minorversion)
> +		nfsd41_cb_get_slot(cb, task);
>  	rpc_call_start(task);
>  }
>  
> @@ -1292,7 +1338,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  		return true;
>  	}
>  
> -	if (!cb->cb_holds_slot)
> +	if (cb->cb_held_slot < 0)
>  		goto need_restart;
>  
>  	/* This is the operation status code for CB_SEQUENCE */
> @@ -1306,10 +1352,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  		 * If CB_SEQUENCE returns an error, then the state of the slot
>  		 * (sequence ID, cached reply) MUST NOT change.
>  		 */
> -		++session->se_cb_seq_nr;
> +		++session->se_cb_seq_nr[cb->cb_held_slot];
>  		break;
>  	case -ESERVERFAULT:
> -		++session->se_cb_seq_nr;
> +		++session->se_cb_seq_nr[cb->cb_held_slot];
>  		nfsd4_mark_cb_fault(cb->cb_clp);
>  		ret = false;
>  		break;
> @@ -1335,17 +1381,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  	case -NFS4ERR_BADSLOT:
>  		goto retry_nowait;
>  	case -NFS4ERR_SEQ_MISORDERED:
> -		if (session->se_cb_seq_nr != 1) {
> -			session->se_cb_seq_nr = 1;
> +		if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
> +			session->se_cb_seq_nr[cb->cb_held_slot] = 1;
>  			goto retry_nowait;
>  		}
>  		break;
>  	default:
>  		nfsd4_mark_cb_fault(cb->cb_clp);
>  	}
> -	nfsd41_cb_release_slot(cb);
> -
>  	trace_nfsd_cb_free_slot(task, cb);
> +	nfsd41_cb_release_slot(cb);
>  
>  	if (RPC_SIGNALLED(task))
>  		goto need_restart;
> @@ -1565,7 +1610,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
>  	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
>  	cb->cb_status = 0;
>  	cb->cb_need_restart = false;
> -	cb->cb_holds_slot = false;
> +	cb->cb_held_slot = -1;
>  }
>  
>  /**
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 5b718b349396f1aecd0ad4c63b2f43342841bbd4..20a0d40202e40eed1c84d5d6c0a85b908804a6ba 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2002,6 +2002,8 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
>  	}
>  
>  	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
> +	new->se_cb_slot_avail = ~0U;
> +	new->se_cb_highest_slot = battrs->maxreqs - 1;
>  	return new;
>  out_free:
>  	while (i--)
> @@ -2132,7 +2134,9 @@ static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *new, stru
>  
>  	INIT_LIST_HEAD(&new->se_conns);
>  
> -	new->se_cb_seq_nr = 1;
> +	for (idx = 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx)
> +		new->se_cb_seq_nr[idx] = 1;
> +
>  	new->se_flags = cses->flags;
>  	new->se_cb_prog = cses->callback_prog;
>  	new->se_cb_sec = cses->cb_sec;
> @@ -3159,7 +3163,6 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
>  	kref_init(&clp->cl_nfsdfs.cl_ref);
>  	nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB_NULL);
>  	clp->cl_time = ktime_get_boottime_seconds();
> -	clear_bit(0, &clp->cl_cb_slot_busy);
>  	copy_verf(clp, verf);
>  	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
>  	clp->cl_cb_session = NULL;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 41cda86fea1f6166a0fd0215d3d458c93ced3e6a..2987c362bdd56251e736879dc89302ada2259be8 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -71,8 +71,8 @@ struct nfsd4_callback {
>  	struct work_struct cb_work;
>  	int cb_seq_status;
>  	int cb_status;
> +	int cb_held_slot;
>  	bool cb_need_restart;
> -	bool cb_holds_slot;
>  };
>  
>  struct nfsd4_callback_ops {
> @@ -307,6 +307,9 @@ struct nfsd4_conn {
>  	unsigned char cn_flags;
>  };
>  
> +/* Max number of slots that the server will use in the backchannel */
> +#define NFSD_BC_SLOT_TABLE_MAX	32
> +

The new comment is unclear about whether this is an implementation
limit or a protocol limit. I suggest:

/* Maximum number of slots that NFSD implements for NFSv4.1+ backchannel */

And make this "sizeof(u32) * 8" or something similar that documents
where the value of this limit comes from.

>  /*
>   * Representation of a v4.1+ session. These are refcounted in a similar fashion
>   * to the nfs4_client. References are only taken when the server is actively
> @@ -325,7 +328,9 @@ struct nfsd4_session {
>  	struct nfsd4_cb_sec	se_cb_sec;
>  	struct list_head	se_conns;
>  	u32			se_cb_prog;
> -	u32			se_cb_seq_nr;
> +	u32			se_cb_slot_avail; /* bitmap of available slots */
> +	u32			se_cb_highest_slot;	/* highest slot client wants */
> +	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_MAX];
>  	struct nfsd4_slot	*se_slots[];	/* forward channel slots */
>  };
>  
> @@ -459,9 +464,6 @@ struct nfs4_client {
>  	 */
>  	struct dentry		*cl_nfsd_info_dentry;
>  
> -	/* for nfs41 callbacks */
> -	/* We currently support a single back channel with a single slot */
> -	unsigned long		cl_cb_slot_busy;
>  	struct rpc_wait_queue	cl_cb_waitq;	/* backchannel callers may */
>  						/* wait here for slots */
>  	struct net		*net;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index f318898cfc31614b5a84a4867e18c2b3a07122c9..a9c17186b6892f1df8d7f7b90e250c2913ab23fe 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1697,7 +1697,7 @@ TRACE_EVENT(nfsd_cb_free_slot,
>  		__entry->cl_id = sid->clientid.cl_id;
>  		__entry->seqno = sid->sequence;
>  		__entry->reserved = sid->reserved;
> -		__entry->slot_seqno = session->se_cb_seq_nr;
> +		__entry->slot_seqno = session->se_cb_seq_nr[cb->cb_held_slot];
>  	),
>  	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
>  		" sessionid=%08x:%08x:%08x:%08x new slot seqno=%u",
> 
> -- 
> 2.47.0
> 

-- 
Chuck Lever

