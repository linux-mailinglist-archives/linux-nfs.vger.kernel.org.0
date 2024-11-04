Return-Path: <linux-nfs+bounces-7655-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E00F69BBB3F
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 18:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00B5281477
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 17:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541D91422A8;
	Mon,  4 Nov 2024 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X1deX6gw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e65qDOjd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9AD1F942
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740539; cv=fail; b=TxxjQPqkkZ2wTOHPz1/wtcbCNkcPz1U5X3wc7TR3Nrl/NrgBZ8hVDSBmslzK93ZQmN5xYnqc4GkiFZaZe+prQSoHnY24oIf/z0qPauGHPDKCoXLPmX9PWX10Hvx2jrTclGrpPEHMka0fgqoEMb+dgrzQNOFfd7ago9lClgQZ+lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740539; c=relaxed/simple;
	bh=6xfY5XojpeEUizWkyt3pSZy6zIi53ziozRz6fd/0X9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BL5Kyo5H6BpSxfXCZr8VOnfaKioLCkhyFJV7l7xZP3kMzmEncmWFudxjm44DelYU6VnAvfluJclm3a2JS4x/vZkHG6WBFl/C2bG9CoJgmCCSixIQGjc2LuEsuxCXlvEOCbeLRLqWU0WNPoeUNcKXLQ/msAb4N1YKNjR6Io6baqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X1deX6gw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e65qDOjd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4GMb4W015500;
	Mon, 4 Nov 2024 17:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=/KNPusOUDjMVYeVEBa
	7gu0xAVkfIEcZ0qCrcLGq9qfc=; b=X1deX6gw1B+GlPVvROVETdwKVqBImpcU1R
	fdPVrXCbQMxr3Suxkk9CLEs8hOw2FDg/p/t2p4ipq1HU5Y9j5tpZ0BFiurYdYJUB
	xSULgLaFE7Adcr/CzOmvFVR5PaeA2Tg9Ex5AcJj9CX/XMAXM8VkBbJ+J7yQDKEsz
	IQ6unV08Yva+xweNuwS+TuDl60yf5/Gx1h1qR0767C62ywc6o6EZ9+giABuzZSb4
	2RtFBSQCrJu4ZqbxcjXc10qMY8u3BA1uUEraDm8w3K/P3t1VVJh2svEPtWak4d4H
	wh/SGf+ALknWINzH0P1OopP9piUq6rNQY4ElaLxuurt90y9+8iIQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nagc3anr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 17:15:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4GLL2Q009108;
	Mon, 4 Nov 2024 17:15:28 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahcaxaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 17:15:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmgh1xipM04EZBnlS7NxhgxsiZtko2nvxmV20dhgKT84nb4dYLHD3PRTs2k/0w4kQ1NC17tVf+1anJQTTKT25ownq0MP96vxU36wDtNue8KCNYB6d51btXWIOtjF4se8GNW254WXtWyYWwaRCetlmLUI19Wn+//s9Jws1IyT+f8vXVp9QpQTRDjQb54PWpNdn7WAWDE5TZOKRdoxfqAqp7qNnMyuCG5RmiKY1HxCCxIRaNJpHUSPdL92AkW4JnZux8qFGtcut+zDxoJMT+FIaP2W5//3krMWNkRApUU3FncA9kBaG2Lwfl+hzC72dutrisW4+lkx8ymjagKX409HYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KNPusOUDjMVYeVEBa7gu0xAVkfIEcZ0qCrcLGq9qfc=;
 b=UaDPbogFhA7/NAx7yOe8KU//AcloJrg4RvEToTcEUT1Rm2Oy5lf0B3n/sHWzVylsD/mOx82O3t8XkCaVJRJNbP0OtR2FHjWO2cOVmI5zm4ZBwsbXlBMH5zvwpLHEeqNlgoAQvid689PVOTrkRYsZsiMRUN4Nqohi9xxQjQX5Zdgl8XS51g2qiMODOjfzgxD1HEWm8YGKQDCF6jnQkCITeyRi3K6HmnJFcs9mvSIkCaWRlo87i09eq3UQ7aBhYoT5UXg+b96p4R6ouIllFdC8W+WKzhUU1qHj7zQSvBlsQZMY/vyXSzfpq32NLZeGs1tRltqkzUAz4lp/WTEDLobJQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KNPusOUDjMVYeVEBa7gu0xAVkfIEcZ0qCrcLGq9qfc=;
 b=e65qDOjdRE8P8DQ+UMU08SWbaIy5fAJqRJnoId3zuIfErHRVKwweFk7G4vE8huxSNbsIyv8ULmVGsjwOUr9Y2a2N47iovXtP9hPnTgeThSJOUv3ZkDbGIsBajV99Ua4+4Y31v4z7xi2xEqgYVAjoaJS04DQALgH/v6dIBliYnAA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7778.namprd10.prod.outlook.com (2603:10b6:610:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 17:15:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 17:15:24 +0000
Date: Mon, 4 Nov 2024 12:15:20 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fallback to sync COPY if async not possible
Message-ID: <ZykBKNcLudUySOXZ@tissot.1015granger.net>
References: <173069566284.81717.2360317209010090007@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173069566284.81717.2360317209010090007@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR15CA0010.namprd15.prod.outlook.com
 (2603:10b6:610:51::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcead62-308f-403a-af24-08dcfcf444e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zVIHJW/Nd7Fh21a9F0RzpZITkbiXHDJBm1mSCOvW0WT092LbWsr0j0a7OznR?=
 =?us-ascii?Q?KKbODplmSSxII10itrfzW7JflniF/4HAEzKhvIrJ3HiRUb4x0fD27FQJ/DbT?=
 =?us-ascii?Q?8duszu9Ueq1C4m5bbOBgSKJ245lDhIhCQOap8JPpWT5CvbWsuVx0PpeCERPN?=
 =?us-ascii?Q?1ieHU+ijMGDvZR4buy1Q8mr3qIakmfzzlJpdKTELr1OvwjVUBOjJ/69yN9S5?=
 =?us-ascii?Q?mibuLyx9is13p1e0BDDeWh2iWBhs9JEvNRIPPYjblqehee9zV2X39Ic1ernm?=
 =?us-ascii?Q?bjVnfXnF/tM974yrhb/qDOZR/PkcAHKul63xeFA4P4HK054jwY7u33KvUVNK?=
 =?us-ascii?Q?z8dOSTdl/TGLr7gSBMF+gncrxyq5p8M9hsfyYnRVBDPlZcdPUTJHWa3nJwwq?=
 =?us-ascii?Q?IA2iMxAHMya8fPIZpDACAFGhtYSUWsRsVtObhHq5FwEhOEtU3z1/9lCZWfoR?=
 =?us-ascii?Q?p1oeP8czY2g+QF//+z+HbeSQfCzWks5JfkI14mhxEXWpSHC21laEqH30euEq?=
 =?us-ascii?Q?BqF1Q8EHE9ieL5mxuaKG1EexSjonyDN3cFXyRWdA8SopivXbTSx1v4p9dDVw?=
 =?us-ascii?Q?dnYAMwa4nNl8uc2YsiSB2hxkefRL33Nlg7BW/XhHbPK81o3sIlNtty2v945Q?=
 =?us-ascii?Q?yLObFsxtk2IJ+yRL2oPmFo+slOYuGH1L+mpv8iAQUgSDa9ofPavWkSe5ZE4L?=
 =?us-ascii?Q?vC4kTC6XvOIoVv9OPPVan4hRXaH7O9pZMGnhmu0YNOOQLXAOBUzo3lLU9CrE?=
 =?us-ascii?Q?kZOw5Jb7fAz9xDCuLCid4ednZB45vxzdeiLH+YTRrZMJMNZwuxqiT34mOanQ?=
 =?us-ascii?Q?R+e8Fl5SBuy0C6xD/b//Mj+mmQHrhaqwp3w518EADmqeZt/a+FG7x0M1UXe8?=
 =?us-ascii?Q?MGIDUJaXFaJvwNSCbMBwENzBdb798HXOWEGjhM8Bjp9pj2Ab6yatPMkc3bus?=
 =?us-ascii?Q?Pr/PeCgYqNnBjgUz4QK9OR7hyYeze4zu1evWGERaM6Zc2PtIRcAmNkbzOyTg?=
 =?us-ascii?Q?DMU7dHYmhEoIo+RhZB6f3njA4nOEOrS2vjluyx+mMwrWrsE4ZjISYWNqUdIx?=
 =?us-ascii?Q?tCFwP84tWePBAX0GG6kDe1XViiUOgZYu7T4XPSftPkzGQ7jGf7nCKUqXEDLc?=
 =?us-ascii?Q?62sApxB28sZ8Epq++y5cQx6VJOOM1X78Oyvzja1TkNoIUHl57brzQqw4hOWK?=
 =?us-ascii?Q?/HDLmVU6UpYzjeBkuF66ZOf4WeN234nJUbwNf937L5Y/Dt73jeJAKKdMbVBX?=
 =?us-ascii?Q?xSUediBC1BzqNnbEJwBJdE48u9UUF7p66Po9OoBqCXF76FKJ+AIsysWLbp7c?=
 =?us-ascii?Q?jE+RgIp/7ibKcZamOLmKlNjr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tmqBQpQqfO15/kYnHqMneUFztSM4bXEYytAx1LI/WMopYWJV87Y0aSR5VIRa?=
 =?us-ascii?Q?p90Y9ZLl7yMsYwODNfKFaGxwVOaNO76YBMNWmp0OrIlU1fxciAVtAavQBRBy?=
 =?us-ascii?Q?XerK7AeVdw28OKIL4celCJ/aIGk5JK3LZjIIpAusf6E63FzZgqXZcw3Mhifu?=
 =?us-ascii?Q?uGwxUC7l1P9PY/a9hWlLgBctz1II/Gdr41trrPwxp1e3lxb14ZpSXs0m0Onr?=
 =?us-ascii?Q?zlqcewxHx8e2pxbdYWoqCU/1+6FoyolsDvhhpQsaNgFHYF0ceoT5/PhkqO1t?=
 =?us-ascii?Q?ddRtV/MWJOztp+y2/q9/8S76ULcNzWkUeEOMzNiu0Jr5399+nDNcmtV2PtRz?=
 =?us-ascii?Q?mNW4blayAXWXhXukWDq4qVygPY5l+xd9jufOzku22FSHClLXXR6aHIvYOCc4?=
 =?us-ascii?Q?53AgMQNmMEdZ48mshCCj+anjIlK3w8rtiPIL1p5AaU6a14HJCEl8C8QLJR9G?=
 =?us-ascii?Q?qmD7foeK2vTjn6l8HBUGA6XjEehORiUxUXsaQTwe6Kw6d4nruSuXZlunA15Y?=
 =?us-ascii?Q?NRSMw3jt4ySali6giuYm7GX7BkGtTA5xc9eu4BwplAtHjJJ9G8QW+1ZxpjOM?=
 =?us-ascii?Q?InOa0kOn9sNR2fuBE+CDEcdH7//3OzNUC5uSWD0sjdn1ocXmwnbKt+7VUERv?=
 =?us-ascii?Q?SFqT6wb1buP22MPpsrdsTHlNbQXMebeCjQ6KJUtesq2jQdXmCWHwY7UObrbk?=
 =?us-ascii?Q?KVWyJftrDeNtarbKpMmcVJleQCFbDlDpPKHL4pgvMSVMhnGQU63hsRCIRffy?=
 =?us-ascii?Q?arW6hnORAlKQJUnUj06OmzPFBscG5cLDK9LbWQ71BiBorhzG+jrcmdofVscp?=
 =?us-ascii?Q?+VdLBcFXwq5rKt/lE6OzFObCicGtmVatIkzXrw3TqQM7zKr7P/a7P+ld9bGy?=
 =?us-ascii?Q?ihGliMHJvZjcJylfMkgKO3MwsIx/JG2POTvr5C2yWa6t0m7uEANqyIzwBqxa?=
 =?us-ascii?Q?ZC5fd3XixHUylLIXH6CJ+vNo0OE05fFhYEqvwR2sXJvLIyJEx6ANumeFpuFp?=
 =?us-ascii?Q?lC3WVErzgVzPKMaxlG9TEA8KOCbitfF7VuFoYLgxE6m55uVB1Qp3rkA5FR8Z?=
 =?us-ascii?Q?dgypL7NQ1SH6I/mBUAia+xtzdqy2SmSWGbQ7NiCoxx/TPlZQmzyGBKp/io2z?=
 =?us-ascii?Q?BMrCvl8sKR2q6dauK1z4097irYCmG4O0K5N0XjtHfuLXqlw1a1M8zDTAwASR?=
 =?us-ascii?Q?JO63oxSb5peD/pwCaTneC8RDais3/uXj7RHcKsYc8UwwGSAM+0wbVqSKe6zv?=
 =?us-ascii?Q?bCPlcqIEVukDkypnMsp4U5UydALfVv8dBtmZ2Y3GTYY62y+MseabsGUwJ7qZ?=
 =?us-ascii?Q?nWzFmLBq0sjs6dynAbgiTt6it94Fp0D9ArxOTYyEQ/TmVymWmKUK6qYx+CQq?=
 =?us-ascii?Q?IiT0EAf0+klR0mx4oL/SvHsIs9tJWvpO0Gh3xlTnXA0M0yhNMndt9Z2JAN61?=
 =?us-ascii?Q?Wu7fiChqr91OpULwM+gv3T6TCR/hE8GMC+d1pjrL4P0rVJDMU2Tmht8b8TAl?=
 =?us-ascii?Q?Yy9tXfhMZxUVv1aZFyQKLux/o68R67x06fsDmqUTGNmC01o2gqS3LiraxG4A?=
 =?us-ascii?Q?6i5m5B4OxP9oLTB9oNnt44ugLYXiGp1MN5BVR6PlrrMvLdzujuBxrJh+WtHy?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CBmlT/JGH0lJfgNZd7j5XYkZQj/oHY9TBb5mZ/N3x8jzvlweGGDbJax+Ib8y2Ojxgi5HyUpd4zBICZ+aMzHuQqNAshHJTouTaMMKadM6lI+LqbmcfLTxSpQ/inmW76m8DQx3eE9Uzfe4c/H4hkCwGhXOgzWCL8a1M4B6AZK7zKuUP05Wh4TjMqU2wEfB8t/8+VZmjJpoayP0S90A8BgLlqovixSdxPMtAHlxuQlJlnrIbUSVi3aCpK39BQa7VwRrWPTJxow/bFUD1CTRbx6kaZsQIWUpFUN09CvAa89Zi3MWDXmac20meQ5jrvKWG/wJQFQ1LbelZgwVHNY6VbU+wXxNNhUs4nXWQzGANfvkjT7B7UBgzRlZ8ukWZ7vneMu3WoALrNp+9trKDqnm+IPs8j+/zlaGgwN4p0aqS1hfJaW86+PlwuKBy235JE3ZM80sAWAJWHA5s+hA3d3myWdjupYnjryZFZTfvr6XaIDDjLPLDbUS+x4Dr3IwJsoQIZiK5YJ+yKn+bqBSsjfWQUwqGgSj7rjrEhI2qwMvZuZ5fmqZQNJ/4qEJ+s+JbHPQYwgxP1d9HFcs6nttPGwtOqrOD+u4O+BPTyMMPlmWBsi2hAc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcead62-308f-403a-af24-08dcfcf444e9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:15:23.9789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4GSmhkoIMuVikYMkxZYGIm41TyHRcS962dh1Yp5Np4xV1QsULVOi7i2E9thgfEduZq2MBzaQKmSy66pGRD78w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_15,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411040143
X-Proofpoint-ORIG-GUID: 0us7S5Pd4xRkakXcrvxlA-iBAlvJJelJ
X-Proofpoint-GUID: 0us7S5Pd4xRkakXcrvxlA-iBAlvJJelJ

On Mon, Nov 04, 2024 at 03:47:42PM +1100, NeilBrown wrote:
> 
> An NFSv4.2 COPY request can explicitly request a synchronous copy.  If
> that is not requested then the server is free to perform the copy
> synchronously or asynchronously.
> 
> In the Linux implementation an async copy requires more resources than a
> sync copy.  If nfsd cannot allocate these resources, the best response
> is to simply perform the copy (or the first 4MB of it) synchronously.
> 
> This choice may be debatable if the unavailable resource was due to
> memory allocation failure - when memalloc fails it might be best to
> simply give up as the server is clearly under load.  However in the case
> that policy prevents another kthread being created there is no benefit
> and much cost is failing with NFS4ERR_DELAY.  In that case it seems
> reasonable to avoid that error in all circumstances.
> 
> So change the out_err case to retry as a sync copy.
> 
> Fixes: aadc3bbea163 ("NFSD: Limit the number of concurrent async COPY operations")

Hi Neil,

Why is a Fixes: tag necessary?

And why that commit? async copies can fail due to lack of resources
on kernels that don't have aadc3bbea163, AFAICT.


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4proc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index fea171ffed62..06e0d9153ca9 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1972,6 +1972,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		wake_up_process(async_copy->copy_task);
>  		status = nfs_ok;
>  	} else {
> +	retry_sync:
>  		status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>  				       copy->nf_dst->nf_file, true);
>  	}
> @@ -1990,8 +1991,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	}
>  	if (async_copy)
>  		cleanup_async_copy(async_copy);
> -	status = nfserr_jukebox;
> -	goto out;
> +	goto retry_sync;
>  }
>  
>  static struct nfsd4_copy *
> 
> base-commit: 26e6e693936986309c01e8bb80e318d63fda4a44
> -- 
> 2.47.0
> 

-- 
Chuck Lever

