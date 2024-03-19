Return-Path: <linux-nfs+bounces-2401-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA37880316
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 18:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9152C283B52
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 17:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D33E2B9B9;
	Tue, 19 Mar 2024 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DUKPCmKr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N2KXKPTg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE7D2B9B6
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868326; cv=fail; b=HntCtamhX2gGyyB83YEEAE2FfJBC6y6FWa/J1R7jhZZOXfilVinKr6Et16/ERRML86B4rcdPOLKokxmTiUFkJVWzad4MgvM/HA3bmS+HzYvOpBadT417Wbl2zqUP98Aiz01YcILlgwCjdlhq0HBVa3LKDrfh3Hdg9W+xglzciUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868326; c=relaxed/simple;
	bh=28WUMo1Lg0Wquvkl7/IbpkhVjRGVNBw6OGMB2ZAfwAk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H19aLg6Z+mZSqf4gFsLmgXF2AexzrzD2tH7g5mY2td/pLLkPaEvZHp4YznKN8kycns8ArqVPyxlldPz42hdLkd3XqM+hKMB/F3mCGYqJN+DfUwIQrIOsOAXOXbYr/jYmvp9lLlO3W5grLwffmjV/5VdFeA7vnK4CHw8Oly2DgSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DUKPCmKr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N2KXKPTg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JH0Dnc013393;
	Tue, 19 Mar 2024 17:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tq8XWOYpFN8V65cSFdPyK4/q8qer4KZjlOS3dwl9ogs=;
 b=DUKPCmKrV30vsoG6rCyKinFAEqz43mxQOVfxkgsLR62eHmkjxjc34MWHDitaC2ssfMGE
 fDzBFfZJYVOw/ritHVYP/1/SbtIZzG5K4LboIpWJZDY/6Q3hX0v6dhIFyjZ4FsZEDrIe
 FtitjihV0ezmodt9iqHT5zBjgU2p3U2qdbuVdrmwdXfZuMPzv4Nao5ZxHZsYgrOiw68u
 daIi0pDdbBn+hY+tNtKP52nMY9831hYz7QwgVQHpez9tsDhjLbcA5YHSu5ydCgMe+ue5
 7SVPu/WhZyiftcBl302P/fnH/Ff6bjm468Lr1yD8koL97YwbnVZfjyNC03465Vpo/zh6 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww1ude46e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 17:09:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JGJIPa007250;
	Tue, 19 Mar 2024 17:09:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6jbs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 17:09:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGzWXiFTtC7AtoUzh4EGMXx8AclQSgXoZVj3heDTYWlbXmMsMj+mWM9VmIirSBVXuhYxJLRRL7DQbGM+iXkwiCCL9z0jBC/ZHOKUqY0wFp/S/VQod55Ji+Wim4vEP7ab3fB1gW0CMvUYUbxxOIILfoig550DP0Wrazpf7YV+m96GYYwDCgXjrz68h5wHpSnNzIPPM5DsTUqxFV1yWEMObnhEEFL2+9ZwdaVBXk09K1HXwo8OyrCRhqH95bl5mEWQCSRNrHitLdcPYfBj4f0O6ntVGHbVA3vlJKZeJ5Ny5Ub7bY9QDgv1ujeh40wGWWmlGpHRZT+qowD2MrX6rpSxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq8XWOYpFN8V65cSFdPyK4/q8qer4KZjlOS3dwl9ogs=;
 b=K1NPp3KYyYJy+9XeoLs2TSVE8YpmNMLAzUSBCvgN+tKz4ziLQY3uJk/irIC4R5fJFJCJ0IKpQnY/lKh5lRYSkhNofGIY1WD+TO8/Sd36m2XonFXMOhYjD8oQCjHMt0rRyVGNV9Ca7mEGrkUbTjUoSMo7EO11+HkkNmIta6W5fDvckSm4hYRALZ0pX+RSdyHwIL4Pd/w02lNuRUybWX9RO9IjHx8mzk8fsurehEfdHqyxfHGGXwoqaOdDtWnKEW8qrIISJhNPJSh6OoEcnF9JHHa8HdpnJkr+2La5k4oA7CUL2+A2+zjrhRHBlKbIVPvsgPXVJJdrVnF/kmEAF+xYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq8XWOYpFN8V65cSFdPyK4/q8qer4KZjlOS3dwl9ogs=;
 b=N2KXKPTgcC5TJZt4Mcv/EjjCsyjITmMJEP2gmfzKwnZC6LTq1Bn+YF7IzTzWH71XTH6vIgcS0WK+ZNB/jzqS6ZXsCqdqm2kTyKXLu9EYn9HwYwOSAh4pdnH+UiPU6s6AhjYc5BnAEhTvCy8ek7AiC8naZkpIZzi2IJA1huHlKQQ=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SA1PR10MB5686.namprd10.prod.outlook.com (2603:10b6:806:236::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 17:09:38 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 17:09:34 +0000
Message-ID: <50dd9475-b485-4b9b-bcbd-5f7dfabfbac5@oracle.com>
Date: Tue, 19 Mar 2024 10:09:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd hangs and nfsd_break_deleg_cb+0x170/0x190 warning
Content-Language: en-US
To: Rik Theys <Rik.Theys@esat.kuleuven.be>, Jeff Layton <jlayton@kernel.org>,
        Linux Nfs <linux-nfs@vger.kernel.org>
References: <66c98f4c-5e52-4fa3-8a2c-9379cfec2a9a@esat.kuleuven.be>
 <44c2101e756f7c3b876fb9c58da3ebd089dc14d5.camel@kernel.org>
 <e3ba6e04-ea06-4035-8546-639f11d6b79c@esat.kuleuven.be>
 <41325088-aa6d-4dcf-b105-8994350168c3@esat.kuleuven.be>
 <7d244882d769e377b06f39234bd5ee7dddb72a55.camel@kernel.org>
 <c7dbc796-7e7d-4041-ac71-eea02a701b12@esat.kuleuven.be>
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <c7dbc796-7e7d-4041-ac71-eea02a701b12@esat.kuleuven.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:208:23c::15) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SA1PR10MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: e974c2e2-1b99-4ec9-18ce-08dc4837595d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7E3EUv8Czzb98UqMgm6DKfAeu5EGj01EXy2zMqbYnfvEp4NgC6DLOtJogVopeyuPrFbGWJgXjbqgcmPZInjqE872ybMiYMhfi1FV0UlgNNVjdqluX1vlGrPnGBPx3jEICjY2WP2BmqDd0FrN98ceoosbJYPeEbUMAidjmsfv0huTrlsu8rOSCWuRIq2yLBRNw/lCw4BHXcI7Y9tOesKlK9tkxa6slI0VCrrHFeHJI977q7SScE95bRgt2K1gDfa7UnyAYkaF6iyWUGL1/KH2jIoQzjFXj/METdHxGAG/eUCIXD3e06adjgqMu66Z0j6pvPijKVA5Bc1tduY09K0+m5NxVxNtyU0N/pmrZGQHHatJHuNIDunscKNoEYTyBOXx0ot7/rZfh+fIK+zjhPPvuDS4PuxgC+JZv40459D87DIa0ZKc2BaO+ymS1NFMUN4TsK/LO79DsfHxl+2S3aSYsP3z3vOkmPRoUt7x/dIt8agXGF0Zdm5mAeBTe0zH6bC2U7tFKkpJZQSKax6B8I7ZEwSXEvqava3D7JHiuqySIsoxQHqUrpVh7ObdB+bywadfOStOqm7UdiQyd76Dmz50sg/gZ4JhUH+FyuQbCQ/lPEQwKQnOh2mGiDy5Ra6wurFN
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OXNXODliYzRCbzVBWThjMVRPZHl6K0Nzc203MWVkZ2loWGJ6YkJUZmxNYUhK?=
 =?utf-8?B?UDdpYWdqSFFBRDZ4NmRWREdsVEJQelNSYmIyelB3YWZQZG10c0NqeHAwdHBz?=
 =?utf-8?B?OTJhajNza1RiTDlSQnZLYVBFVDUveEM4MVFuNWZvNGNTbWN4akF6cE9wdzhy?=
 =?utf-8?B?NjNUaXp3N2hMZzhSRWVabW93d2RPaEdMSEt6QlVVcGVUODA2dVZMdmlBcnVJ?=
 =?utf-8?B?clJ3ZzNmTE5WeUM3MjdCQVBEeERwbFRVUi9jNXRvaTdQWFZFVURjdm9LbzJ5?=
 =?utf-8?B?YXFpQWoyRXhSdlBYTnd0MCtsR0FNQ3pWcHJOaFRXQlN3N3E2eXRVK21PRWJG?=
 =?utf-8?B?Y1Q0M2g0UExhSmxxcFBaMk1KdzRrWVIzQldCTXhDSFlUcEFnWk1tcjNkSVNo?=
 =?utf-8?B?MnN1dEVBL0RXZ3dhL0FaMjNtVmdxMEF0ZjVzTC9zL0dpQTFvRURSVWh6Y1ZP?=
 =?utf-8?B?ZHhndEhsOG1FZzduc3dtSzhqWmdhWHYxbmNMaW9GajJ4Vk1QWUlDY0xCdXgw?=
 =?utf-8?B?cDcyc1hLcVpEcmlVUW11UHhUQkxsQXh0TnFGblhqTk5wL0xiai96WUZvVFRN?=
 =?utf-8?B?QnpwaDUwb1Z6SUQwcEx0aStYWkZGUjBRRzZkT0REY3QwSUNKSGVBQytKVHlo?=
 =?utf-8?B?NE5vNDUrY3NtWWtYRkl4VHJrTDNYU2dGUFloL01YTlpnNUgvMTRBSHJjemNV?=
 =?utf-8?B?YU5OeVN3VmRsMDJiNDJkdnRaS1JEeGhMUmpublZhZjRKQXJzakp6UHZTdnVE?=
 =?utf-8?B?bTN1UkR0a3JyVVBtMHUyNXowV2VzRm5nUElHNVkwRGlWdnpDU2c2REx5ODh3?=
 =?utf-8?B?Q21rRWdwcWpadEoxdkd5dmlCU1lCTjI0K1ZhS1V1dkRRRFdYVGxvR0VKTU5O?=
 =?utf-8?B?NStHSHNHNGZDdW5yMFlIK2Q2U1RjcWZTMHlpOC9MQTJIbndxdEFIM3dGbHJL?=
 =?utf-8?B?MFpqRmRSaXJnWTZRM2tJL0pDWTdUd295dmkwY0RXK09FZjMxd29KOU9GaG14?=
 =?utf-8?B?V1Z0d3dyTGdBUjNhaTgwSjhhbGRCUnNIZWRqTkJxQXppdVd6WllIZDVwejZk?=
 =?utf-8?B?N2ZqMEc5NzVHcGNnYmxwRHNWOE1HQU85bmQwa1lIZmt5UVV5ckNDbmx5ZTQy?=
 =?utf-8?B?bzRicC8wOE5iUkx6SFBBR1V0MUVjcGNZKzdJUDZFektvQmJIbkxnTkRrWUZ6?=
 =?utf-8?B?a0dycTZCV09vQWtmRjRDK2RiUTNDNjFFa042RWFDaHR1MjJHVUVzZWNDYkdP?=
 =?utf-8?B?czk5NnoyN2tiTTRqMGo4a1pvSUkzSDVnQ0JHQWtKMG5sUFNkalE5TmhTdkl1?=
 =?utf-8?B?VVdJUi94ckxyODVuY0RzV1M4dTlFSWUzaXpkalNPUzhyVEtIc2hjMmRoUWpD?=
 =?utf-8?B?MG1PSTk5SmluQmhUQStwaExVUGhnYUZKZmd3Q1N1TnliZUFQRFdvQmZnV3ZH?=
 =?utf-8?B?Vk5SdVlvYkVvemJMYmhBd1Z6V1dRbmJ1eDJVVnNwOG1CUjEwWU42cHhmcTFX?=
 =?utf-8?B?c3h5VHV5NHhPUGlGVEQwV2dOTURYQXdDNGpXNm1MemFQMm9Nbnk3Q2lNQk8z?=
 =?utf-8?B?dHJLODVpKzVBN2dUeWgxL3dmS2xQSk0yMkh0Q3FwZmE5QW1vRVNyRkFHUG05?=
 =?utf-8?B?MTlZVGhPS21FYXA1Wnp6VTZBWERhdnNieUhqYWxBMjBvdzRia1hIYnRRTklj?=
 =?utf-8?B?ZDdRREdES0o4RXd4Tm5XTHY1MDJVNzcxZEhTK1BmaGg1c2o5YlZxSmc0bW9v?=
 =?utf-8?B?ZFpMTU55ZFpiSlMwYUZEcVFvV1FvOG5uL3VtQmhJdVBJMXJhTjJNSi84RDZI?=
 =?utf-8?B?OEplNUxHWHNlUTZkVGJqSnFwbmUxNWU4VWFtdnczSFhiYWZSVW16Yk1tVWRW?=
 =?utf-8?B?ek0xSXdFTmttdTYyN094MDkwaUQ5ay9uUTZqQUg0NGwxVGtTODM3cGVWL1pX?=
 =?utf-8?B?MUwzL2VlVnQraEx3V0dUTVRPVlZUcm9FWDV4Tkhmall4TjFJS0tJVno3d2NL?=
 =?utf-8?B?cEZEOUVjUU8reTFsNlJaMFE4b1pwMVBtRlhtVWp5NHJmQitoMGxKcWsrVVFF?=
 =?utf-8?B?S3RHcjZmWitPckxzYlFuUjkrOUJyL1Jlcm15aDgySzdTRjRqZ0pSYlY4T0FT?=
 =?utf-8?Q?ePtus5FIjRdzHUYgwUSJMme01?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oe58MzYsyBDWjs6msX1rycj+O6QqP/GtM8sCEbHvAuKPmnC0mKKTGDAm6atfP8hyPkdP76zV1mxThIdhPR4RiZwTNJ29eANG60R5mMAusCfN0t22kHBUe7/L/09sDLXkBBfAPsw+QLKY3PStGuVZGi6JWbUqRoaaITpdd0+bwbPG5++dBYYmo4scQUGP4btqcdL1AN+Dok2Kw1SK86JYAG+eAHRVf1NA+umHiBld1xh95HPERKepB14I+1XVBjq2V5r8LnBXXvDkiA85jwT3qRFX7wOQvvqb3McKnYSNN/M9QB4Hoe2S55IewGz36kXEu0J0F72qRik27bEoqv3tRanR1PIQTrWHqkeViWYaVP5Dd4HR8Xt8a6Jqunl/UJpBv325YLO98NESbMfrtUoauCci1YUMpGLzw0/eBipYjih2GxknHJHLccg0xU8l4BZyKRGG7iC04MFIHnA+WhLN1iK7jV9JqNKlOX4QyzWXmiRAST6bGCAzoqU9zmqPV0trFnFRmV5zSVJRllJAY41j0SoAmj46QCEqd70MeGAlvy+NJJsHcyutb6irzp+XG8h2aofXHI1u0gBfjsieK4jBGbAqE3IjR4TQKjRHZQQ5bTI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e974c2e2-1b99-4ec9-18ce-08dc4837595d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 17:09:34.2293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baVGgOQLTG0JL9iZWuMB2sy4vW8nXiu57Hm4jE4NyaCzYKeiSTgIS1k2E2RFec4QzSifK9QBvcgLwJrEttVBYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190129
X-Proofpoint-GUID: 9NMQuwIPSFcUTemaI9AbWN6_LMQ39a8U
X-Proofpoint-ORIG-GUID: 9NMQuwIPSFcUTemaI9AbWN6_LMQ39a8U


On 3/19/24 12:58 AM, Rik Theys wrote:
> Hi,
>
> On 3/18/24 22:54, Jeff Layton wrote:
>> On Mon, 2024-03-18 at 22:15 +0100, Rik Theys wrote:
>>> Hi,
>>>
>>> On 3/18/24 21:21, Rik Theys wrote:
>>>> Hi Jeff,
>>>>
>>>> On 3/12/24 13:47, Jeff Layton wrote:
>>>>> On Tue, 2024-03-12 at 13:24 +0100, Rik Theys wrote:
>>>>>> Hi Jeff,
>>>>>>
>>>>>> On 3/12/24 12:22, Jeff Layton wrote:
>>>>>>> On Mon, 2024-03-11 at 19:43 +0100, Rik Theys wrote:
>>>>>>>> Since a few weeks our Rocky Linux 9 NFS server has periodically
>>>>>>>> logged hung nfsd tasks. The initial effect was that some clients
>>>>>>>> could no longer access the NFS server. This got worse and worse
>>>>>>>> (probably as more nfsd threads got blocked) and we had to restart
>>>>>>>> the server. Restarting the server also failed as the NFS server
>>>>>>>> service could no longer be stopped.
>>>>>>>>
>>>>>>>> The initial kernel we noticed this behavior on was
>>>>>>>> kernel-5.14.0-362.18.1.el9_3.x86_64. Since then we've installed
>>>>>>>> kernel-5.14.0-419.el9.x86_64 from CentOS Stream 9. The same issue
>>>>>>>> happened again on this newer kernel version:
>>>>> 419 is fairly up to date with nfsd changes. There are some known bugs
>>>>> around callbacks, and there is a draft MR in flight to fix it.
>>>>>
>>>>> What kernel were you on prior to 5.14.0-362.18.1.el9_3.x86_64 ? If we
>>>>> can bracket the changes around a particular version, then that might
>>>>> help identify the problem.
>>>>>
>>>>>>>> [Mon Mar 11 14:10:08 2024]       Not tainted 
>>>>>>>> 5.14.0-419.el9.x86_64 #1
>>>>>>>>     [Mon Mar 11 14:10:08 2024] "echo 0 >
>>>>>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>>>>     [Mon Mar 11 14:10:08 2024]task:nfsd            state:D stack:0
>>>>>>>>      pid:8865  ppid:2      flags:0x00004000
>>>>>>>>     [Mon Mar 11 14:10:08 2024] Call Trace:
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  <TASK>
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd4_shutdown_callback+0x49/0x120
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? nfsd4_cld_remove+0x54/0x1d0 
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ?
>>>>>>>> nfsd4_return_all_client_layouts+0xc4/0xf0 [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? nfsd4_shutdown_copy+0x68/0xc0 
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  __destroy_client+0x1f3/0x290 
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd4_exchange_id+0x75f/0x770 
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? nfsd4_decode_opaque+0x3a/0x90 
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660
>>>>>>>> [sunrpc]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  </TASK>
>>>>>>>>     [Mon Mar 11 14:10:08 2024] INFO: task nfsd:8866 blocked for
>>>>>>>> more than 122 seconds.
>>>>>>>>     [Mon Mar 11 14:10:08 2024]       Not tainted
>>>>>>>> 5.14.0-419.el9.x86_64 #1
>>>>>>>>     [Mon Mar 11 14:10:08 2024] "echo 0 >
>>>>>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>>>>     [Mon Mar 11 14:10:08 2024]task:nfsd            state:D stack:0
>>>>>>>>      pid:8866  ppid:2      flags:0x00004000
>>>>>>>>     [Mon Mar 11 14:10:08 2024] Call Trace:
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  <TASK>
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? tcp_recvmsg+0x196/0x210
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd4_destroy_session+0x1a4/0x240
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660
>>>>>>>> [sunrpc]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>>>>>>     [Mon Mar 11 14:10:08 2024]  </TASK>
>>>>>>>>
>>>>>>> The above threads are trying to flush the workqueue, so that 
>>>>>>> probably
>>>>>>> means that they are stuck waiting on a workqueue job to finish.
>>>>>>>>     The above is repeated a few times, and then this warning is
>>>>>>>> also logged:
>>>>>>>>     [Mon Mar 11 14:12:04 2024] ------------[ cut here 
>>>>>>>> ]------------
>>>>>>>>     [Mon Mar 11 14:12:04 2024] WARNING: CPU: 39 PID: 8844 at
>>>>>>>> fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024] Modules linked in: nfsv4
>>>>>>>> dns_resolver nfs fscache netfs rpcsec_gss_krb5 rpcrdma rdma_cm
>>>>>>>> iw_cm ib_cm ib_core binfmt_misc bonding tls rfkill nft_counter 
>>>>>>>> nft_ct
>>>>>>>>     nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_reject_inet
>>>>>>>> nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables nfnetlink vfat
>>>>>>>> fat dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio l
>>>>>>>>     ibcrc32c dm_service_time dm_multipath intel_rapl_msr
>>>>>>>> intel_rapl_common intel_uncore_frequency
>>>>>>>> intel_uncore_frequency_common isst_if_common skx_edac nfit
>>>>>>>> libnvdimm ipmi_ssif x86_pkg_temp
>>>>>>>>     _thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
>>>>>>>> dcdbas rapl intel_cstate mgag200 i2c_algo_bit drm_shmem_helper
>>>>>>>> dell_smbios drm_kms_helper dell_wmi_descriptor wmi_bmof intel_u
>>>>>>>>     ncore syscopyarea pcspkr sysfillrect mei_me sysimgblt 
>>>>>>>> acpi_ipmi
>>>>>>>> mei fb_sys_fops i2c_i801 ipmi_si intel_pch_thermal lpc_ich
>>>>>>>> ipmi_devintf i2c_smbus ipmi_msghandler joydev acpi_power_meter
>>>>>>>>     nfsd auth_rpcgss nfs_acl drm lockd grace fuse sunrpc ext4
>>>>>>>> mbcache jbd2 sd_mod sg lpfc
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  nvmet_fc nvmet nvme_fc 
>>>>>>>> nvme_fabrics
>>>>>>>> crct10dif_pclmul ahci libahci crc32_pclmul nvme_core crc32c_intel
>>>>>>>> ixgbe megaraid_sas libata nvme_common ghash_clmulni_int
>>>>>>>>     el t10_pi wdat_wdt scsi_transport_fc mdio wmi dca dm_mirror
>>>>>>>> dm_region_hash dm_log dm_mod
>>>>>>>>     [Mon Mar 11 14:12:05 2024] CPU: 39 PID: 8844 Comm: nfsd Not
>>>>>>>> tainted 5.14.0-419.el9.x86_64 #1
>>>>>>>>     [Mon Mar 11 14:12:05 2024] Hardware name: Dell Inc. PowerEdge
>>>>>>>> R740/00WGD1, BIOS 2.20.1 09/13/2023
>>>>>>>>     [Mon Mar 11 14:12:05 2024] RIP:
>>>>>>>> 0010:nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024] Code: a6 95 c5 f3 e9 ff fe ff ff 48
>>>>>>>> 89 df be 01 00 00 00 e8 34 b5 13 f4 48 8d bb 98 00 00 00 e8 c8 f9
>>>>>>>> 00 00 84 c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be
>>>>>>>>     02 00 00 00 48 89 df e8 0c b5 13 f4 e9 01
>>>>>>>>     [Mon Mar 11 14:12:05 2024] RSP: 0018:ffff9929e0bb7b80 EFLAGS:
>>>>>>>> 00010246
>>>>>>>>     [Mon Mar 11 14:12:05 2024] RAX: 0000000000000000 RBX:
>>>>>>>> ffff8ada51930900 RCX: 0000000000000024
>>>>>>>>     [Mon Mar 11 14:12:05 2024] RDX: ffff8ada519309c8 RSI:
>>>>>>>> ffff8ad582933c00 RDI: 0000000000002000
>>>>>>>>     [Mon Mar 11 14:12:05 2024] RBP: ffff8ad46bf21574 R08:
>>>>>>>> ffff9929e0bb7b48 R09: 0000000000000000
>>>>>>>>     [Mon Mar 11 14:12:05 2024] R10: ffff8aec859a2948 R11:
>>>>>>>> 0000000000000000 R12: ffff8ad6f497c360
>>>>>>>>     [Mon Mar 11 14:12:05 2024] R13: ffff8ad46bf21560 R14:
>>>>>>>> ffff8ae5942e0b10 R15: ffff8ad6f497c360
>>>>>>>>     [Mon Mar 11 14:12:05 2024] FS:  0000000000000000(0000)
>>>>>>>> GS:ffff8b031fcc0000(0000) knlGS:0000000000000000
>>>>>>>>     [Mon Mar 11 14:12:05 2024] CS:  0010 DS: 0000 ES: 0000 CR0:
>>>>>>>> 0000000080050033
>>>>>>>>     [Mon Mar 11 14:12:05 2024] CR2: 00007fafe2060744 CR3:
>>>>>>>> 00000018e58de006 CR4: 00000000007706e0
>>>>>>>>     [Mon Mar 11 14:12:05 2024] DR0: 0000000000000000 DR1:
>>>>>>>> 0000000000000000 DR2: 0000000000000000
>>>>>>>>     [Mon Mar 11 14:12:05 2024] DR3: 0000000000000000 DR6:
>>>>>>>> 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>>>     [Mon Mar 11 14:12:05 2024] PKRU: 55555554
>>>>>>>>     [Mon Mar 11 14:12:05 2024] Call Trace:
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  <TASK>
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? __break_lease+0x16f/0x5f0
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? __warn+0x81/0x110
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? report_bug+0x10a/0x140
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? handle_bug+0x3c/0x70
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? exc_invalid_op+0x14/0x70
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? asm_exc_invalid_op+0x16/0x20
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  __break_lease+0x16f/0x5f0
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ?
>>>>>>>> nfsd_file_lookup_locked+0x117/0x160 [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? list_lru_del+0x101/0x150
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd_file_do_acquire+0x790/0x830
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfs4_get_vfs_file+0x315/0x3a0 
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd4_process_open2+0x430/0xa30 
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? fh_verify+0x297/0x2f0 [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd4_open+0x3ce/0x4b0 [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd4_proc_compound+0x44b/0x700 
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  svc_process_common+0x2ec/0x660
>>>>>>>> [sunrpc]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 
>>>>>>>> [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  kthread+0xdd/0x100
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? __pfx_kthread+0x10/0x10
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  ret_from_fork+0x29/0x50
>>>>>>>>     [Mon Mar 11 14:12:05 2024]  </TASK>
>>>>>>>>     [Mon Mar 11 14:12:05 2024] ---[ end trace 7a039e17443dc651 
>>>>>>>> ]---
>>>>>>> This is probably this WARN in nfsd_break_one_deleg:
>>>>>>>
>>>>>>> WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
>>>>>>>
>>>>>>> It means that a delegation break callback to the client couldn't be
>>>>>>> queued to the workqueue, and so it didn't run.
>>>>>>>
>>>>>>>> Could this be the same issue as described
>>>>>>>> here:https://urldefense.com/v3/__https://lore.kernel.org/linux-nfs/af0ec881-5ebf-4feb-98ae-3ed2a77f86f1@oracle.com/__;!!ACWV5N9M2RV99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56CMpDWhkjjwSkdBV9En7$ 
>>>>>>>> ?
>>>>>>> Yes, most likely the same problem.
>>>>>> If I read that thread correctly, this issue was introduced between
>>>>>> 6.1.63 and 6.6.3? Is it possible the EL9 5.14.0-362.18.1.el9_3
>>>>>> backported these changes, or were we hitting some other bug with 
>>>>>> that
>>>>>> version? It seems the 6.1.x kernel is not affected? If so, that
>>>>>> would be
>>>>>> the recommended kernel to run?
>>>>> Anything is possible. We have to identify the problem first.
>>>>>>>> As described in that thread, I've tried to obtain the requested
>>>>>>>> information.
>>>>>>>>
>>>>>>>> Is it possible this is the issue that was fixed by the patches
>>>>>>>> described
>>>>>>>> here?https://urldefense.com/v3/__https://lore.kernel.org/linux-nfs/2024022054-cause-suffering-eae8@gregkh/__;!!ACWV5N9M2RV99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56CMpDWhkjjwSkedtUP09$ 
>>>>>>>>
>>>>>>> Doubtful. Those are targeted toward a different set of issues.
>>>>>>>
>>>>>>> If you're willing, I do have some patches queued up for CentOS here
>>>>>>> that
>>>>>>> fix some backchannel problems that could be related. I'm mainly
>>>>>>> waiting
>>>>>>> on Chuck to send these to Linus and then we'll likely merge them 
>>>>>>> into
>>>>>>> CentOS soon afterward:
>>>>>>>
>>>>>>> https://urldefense.com/v3/__https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3689__;!!ACWV5N9M2RV99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56CMpDWhkjjwSkdvDn8y7$ 
>>>>>>>
>>>>>>>
>>>>>> If you can send me a patch file, I can rebuild the C9S kernel 
>>>>>> with that
>>>>>> patch and run it. It can take a while for the bug to trigger as I
>>>>>> believe it seems to be very workload dependent (we were running very
>>>>>> stable for months and now hit this bug every other week).
>>>>>>
>>>>>>
>>>>> It's probably simpler to just pull down the build artifacts for 
>>>>> that MR.
>>>>> You have to drill down through the CI for it, but they are here:
>>>>>
>>>>> https://urldefense.com/v3/__https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/index.html?prefix=trusted-artifacts*1194300175*publish_x86_64*6278921877*artifacts*__;Ly8vLy8!!ACWV5N9M2RV99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56CMpDWhkjjwSkaP5eW8V$ 
>>>>>
>>>>>
>>>>> There's even a repo file you can install on the box to pull them 
>>>>> down.
>>>> We installed this kernel on the server 3 days ago. Today, a user
>>>> informed us that their screen was black after logging in. Similar to
>>>> other occurrences of this issue, the mount command on the client was
>>>> hung. But in contrast to the other times, there were no messages in
>>>> the logs kernel logs on the server. Even restarting the client does
>>>> not resolve the issue.
>>
>> Ok, so you rebooted the client and it's still unable to mount? That
>> sounds like a server problem if so.
>>
>> Are both client and server running the same kernel?
> No, the server runs 5.14.0-427.3689_1194299994.el9 and the client 
> 5.14.0-362.18.1.el9_3.
>>
>>>> Something still seems to be wrong on the server though. When I look at
>>>> the directories under /proc/fs/nfsd/clients, there's still a directory
>>>> for the specific client, even though it's no longer running:
>>>>
>>>> # cat 155/info
>>>> clientid: 0xc8edb7f65f4a9ad
>>>> address: "10.87.31.152:819"
>>>> status: confirmed
>>>> seconds from last renew: 33163
>>>> name: "Linux NFSv4.2 bersalis.esat.kuleuven.be"
>>>> minor version: 2
>>>> Implementation domain: "kernel.org"
>>>> Implementation name: "Linux 5.14.0-362.18.1.el9_3.0.1.x86_64 #1 SMP
>>>> PREEMPT_DYNAMIC Sun Feb 11 13:49:23 UTC 2024 x86_64"
>>>> Implementation time: [0, 0]
>>>> callback state: DOWN
>>>> callback address: 10.87.31.152:0
>>>>
>> If you just shut down the client, the server won't immediately purge its
>> record. In fact, assuming you're running the same kernel on the server,
>> it won't purge the client record until there is a conflicting request
>> for its state.
> Is there a way to force such a conflicting request (to get the client 
> record to purge)?

Try:

# echo "expire" > /proc/fs/nfsd/clients/155/ctl

-Dai

>>
>>
>>> The nfsdclnts command for this client shows the following delegations:
>>>
>>> # nfsdclnts -f 155/states -t all
>>> Inode number | Type   | Access | Deny | ip address | Filename
>>> 169346743    | open   | r-     | --   | 10.87.31.152:819 |
>>> disconnected dentry
>>> 169346743    | deleg  | r      |      | 10.87.31.152:819 |
>>> disconnected dentry
>>> 169346746    | open   | r-     | --   | 10.87.31.152:819 |
>>> disconnected dentry
>>> 169346746    | deleg  | r      |      | 10.87.31.152:819 |
>>> disconnected dentry
>>>
>>> I see a lot of recent patches regarding directory delegations. Could
>>> this be related to this?
>>>
>>> Will a 5.14.0-362.18.1.el9_3.0.1 kernel try to use a directory 
>>> delegation?
>>>
>>>
>> No. Directory delegations are a new feature that's still under
>> development. They use some of the same machinery as file delegations,
>> but they wouldn't be a factor here.
>>
>>>> The system seems to have identified that the client is no longer
>>>> reachable, but the client entry does not go away. When a mount was
>>>> hanging on the client, there would be two directories in clients for
>>>> the same client. Killing the mount command clears up the second entry.
>>>>
>>>> Even after running conntrack -D on the server to remove the tcp
>>>> connection from the conntrack table, the entry doesn't go away and the
>>>> client still can not mount anything from the server.
>>>>
>>>> A tcpdump on the client while a mount was running logged the following
>>>> messages over and over again:
>>>>
>>>> request:
>>>>
>>>> Frame 1: 378 bytes on wire (3024 bits), 378 bytes captured (3024 bits)
>>>> Ethernet II, Src: HP_19:7d:4b (e0:73:e7:19:7d:4b), Dst:
>>>> ArubaaHe_f9:8e:00 (88:3a:30:f9:8e:00)
>>>> Internet Protocol Version 4, Src: 10.87.31.152, Dst: 10.86.18.14
>>>> Transmission Control Protocol, Src Port: 932, Dst Port: 2049, Seq: 1,
>>>> Ack: 1, Len: 312
>>>> Remote Procedure Call, Type:Call XID:0x1d3220c4
>>>> Network File System
>>>>      [Program Version: 4]
>>>>      [V4 Procedure: COMPOUND (1)]
>>>>      GSS Data, Ops(1): CREATE_SESSION
>>>>          Length: 152
>>>>          GSS Sequence Number: 76
>>>>          Tag: <EMPTY>
>>>>          minorversion: 2
>>>>          Operations (count: 1): CREATE_SESSION
>>>>          [Main Opcode: CREATE_SESSION (43)]
>>>>      GSS Checksum:
>>>> 00000028040404ffffffffff000000002c19055f1f8d442d594c13849628affc2797cbb2… 
>>>>
>>>>          GSS Token Length: 40
>>>>          GSS-API Generic Security Service Application Program 
>>>> Interface
>>>>              krb5_blob:
>>>> 040404ffffffffff000000002c19055f1f8d442d594c13849628affc2797cbb23fa080b0… 
>>>>
>>>>
>>>> response:
>>>>
>>>> Frame 2: 206 bytes on wire (1648 bits), 206 bytes captured (1648 bits)
>>>> Ethernet II, Src: ArubaaHe_f9:8e:00 (88:3a:30:f9:8e:00), Dst:
>>>> HP_19:7d:4b (e0:73:e7:19:7d:4b)
>>>> Internet Protocol Version 4, Src: 10.86.18.14, Dst: 10.87.31.152
>>>> Transmission Control Protocol, Src Port: 2049, Dst Port: 932, Seq: 1,
>>>> Ack: 313, Len: 140
>>>> Remote Procedure Call, Type:Reply XID:0x1d3220c4
>>>> Network File System
>>>>      [Program Version: 4]
>>>>      [V4 Procedure: COMPOUND (1)]
>>>>      GSS Data, Ops(1): CREATE_SESSION(NFS4ERR_DELAY)
>>>>          Length: 24
>>>>          GSS Sequence Number: 76
>>>>          Status: NFS4ERR_DELAY (10008)
>>>>          Tag: <EMPTY>
>>>>          Operations (count: 1)
>>>>          [Main Opcode: CREATE_SESSION (43)]
>>>>      GSS Checksum:
>>>> 00000028040405ffffffffff000000000aa742d0798deaad1a8aa2d7c3a91bf4f6274222… 
>>>>
>>>>          GSS Token Length: 40
>>>>          GSS-API Generic Security Service Application Program 
>>>> Interface
>>>>              krb5_blob:
>>>> 040405ffffffffff000000000aa742d0798deaad1a8aa2d7c3a91bf4f627422226d74923… 
>>>>
>>>>
>>>> I was hoping that giving the client a different IP address would
>>>> resolve the issue for this client, but it didn't. Even though the
>>>> client had a new IP address (hostname was kept the same), it failed to
>>>> mount anything from the server.
>>>>
>> Changing the IP address won't help. The client is probably using the
>> same long-form client id as before, so the server still identifies the
>> client even with the address change.
> How is the client id determined? Will changing the hostname of the 
> client trigger a change of the client id?
>>
>> Unfortunately, the cause of an NFS4ERR_DELAY error is tough to guess.
>> The client is expected to back off and retry, so if the server keeps
>> returning that repeatedly, then a hung mount command is expected.
>>
>> The question is why the server would keep returning DELAY. A lot of
>> different problems ranging from memory allocation issues to protocol
>> problems can result in that error. You may want to check the NFS server
>> and see if anything was logged there.
> There are no messages in the system logs that indicate any sort of 
> memory issue. We also increased the min_kbytes_free sysctl to 2G on 
> the server before we restarted it with the newer kernel.
>>
>> This is on a CREATE_SESSION call, so I wonder if the record held by the
>> (courteous) server is somehow blocking the attempt to reestablish the
>> session?
>>
>> Do you have a way to reproduce this? Since this is a centos kernel, you
>> could follow the page here to open a bug:
>
> Unfortunately we haven't found a reliable way to reproduce it. But we 
> do seem to trigger it more and more lately.
>
> Regards,
>
> Rik
>
>>
>> https://urldefense.com/v3/__https://wiki.centos.org/ReportBugs.html__;!!ACWV5N9M2RV99hQ!LV3yWeoSOhNAkRHkxFCH2tlm0iNFVD78mxnSLyP6lrX7yBVeA2TOJ4nv6oZsqLwP4kW56CMpDWhkjjwSkWIqsboq$ 
>>
>>
>>>> I created another dump of the workqueues and worker pools on the 
>>>> server:
>>>>
>>>> [Mon Mar 18 14:59:33 2024] Showing busy workqueues and worker pools:
>>>> [Mon Mar 18 14:59:33 2024] workqueue events: flags=0x0
>>>> [Mon Mar 18 14:59:33 2024]   pwq 54: cpus=27 node=1 flags=0x0 nice=0
>>>> active=1/256 refcnt=2
>>>> [Mon Mar 18 14:59:33 2024]     pending: drm_fb_helper_damage_work
>>>> [drm_kms_helper]
>>>> [Mon Mar 18 14:59:33 2024] workqueue events_power_efficient: 
>>>> flags=0x80
>>>> [Mon Mar 18 14:59:33 2024]   pwq 54: cpus=27 node=1 flags=0x0 nice=0
>>>> active=1/256 refcnt=2
>>>> [Mon Mar 18 14:59:33 2024]     pending: fb_flashcursor
>>>> [Mon Mar 18 14:59:33 2024] workqueue mm_percpu_wq: flags=0x8
>>>> [Mon Mar 18 14:59:33 2024]   pwq 54: cpus=27 node=1 flags=0x0 nice=0
>>>> active=1/256 refcnt=3
>>>> [Mon Mar 18 14:59:33 2024]     pending: lru_add_drain_per_cpu BAR(362)
>>>> [Mon Mar 18 14:59:33 2024] workqueue kblockd: flags=0x18
>>>> [Mon Mar 18 14:59:33 2024]   pwq 55: cpus=27 node=1 flags=0x0 nice=-20
>>>> active=1/256 refcnt=2
>>>> [Mon Mar 18 14:59:33 2024]     pending: blk_mq_timeout_work
>>>>
>>>>
>>>> In contrast to last time, it doesn't show anything regarding nfs this
>>>> time.
>>>>
>>>> I also tried the suggestion from Dai Ngo (echo 3 >
>>>> /proc/sys/vm/drop_caches), but that didn't seem to make any 
>>>> difference.
>>>>
>>>> We haven't restarted the server yet as it seems the impact seems to
>>>> affect fewer clients that before. Is there anything we can run on the
>>>> server to further debug this?
>>>>
>>>> In the past, the issue seemed to deteriorate rapidly and resulted in
>>>> issues for almost all clients after about 20 minutes. This time the
>>>> impact seems to be less, but it's not gone.
>>>>
>>>> How can we force the NFS server to forget about a specific client? I
>>>> haven't tried to restart the nfs service yet as I'm afraid it will
>>>> fail to stop as before.
>>>>
>> Not with that kernel. There are some new administrative interfaces that
>> might allow that in the future, but they were just merged upstream and
>> aren't in that kernel.
>>
>> -- 
>> Jeff Layton <jlayton@kernel.org>
>

