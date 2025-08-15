Return-Path: <linux-nfs+bounces-13683-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2FAB285B5
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 20:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20F65E3410
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349E3219315;
	Fri, 15 Aug 2025 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F0kB6A7g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dEOHaklj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480DB3176E2
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281940; cv=fail; b=iTWI2EsuNrdNyd521NlZW59y/GH5DffeZ+h0KKy5jRtsDnyZaLA4oqFJMUSQYeb4txZLvzfM5vMWShJwqNAYjtf2W4logZ0ioSrR7dk3f0iszEpXalvUFmSF5tJ/lb02p+HjJ4ppj6puoLpk9JQ9uxB/u8RyIMTK1e5N7Ie9tJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281940; c=relaxed/simple;
	bh=pF09apw8feSurXp7FZzsegxXq7OosYkIiiMkD1NhxS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HKNEUA+bLIsTkMvSvHbPQXlZRHT0P52rV8dVYie9usA9werxXcQLEjGLYmQj+MLElmxJQyJZp0g105FkTIL/OZjiCE7OhJ2aGb+rhQGH9jXhjA9SlDkGI0GIKA5oJ4wkhz3tqKN9zv8B9mQsWppKtYnu5KapvyexAbbyWt8I4RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F0kB6A7g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dEOHaklj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FHkO8w002448;
	Fri, 15 Aug 2025 18:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SzswNhINvu2zSDce0E+TjV2MUCjshWEEZXWI/YBdpMw=; b=
	F0kB6A7g+Ssi5p5I9aRdYZaourO+uU8DMjf06ACArAUHxlidtLKDTjGl9Txa0gR5
	O9R2kerCSALoGY6Qv4UZyANM8SerBTVWJCCVHYNjj3lWPpT5y7n43gSUwwLDiqtI
	0hd8EkXLrggD0CIC/inV/SU9jwU8lnoXiyVv//mcbfs5QI1oreRcI50/KgCS5Oh4
	LCUm3IAqfFduaq3dBKAvgiegWpns92QaPGPSh1B+Czd9myuiYM7CZ2+fbYchxJ3z
	MUd+MZbTyhOMGkMEttk0XM0vqvGrAp90aNnJrzBXCdFX75p8ZiMBIO07doAAKJwp
	je9Pm8+xrsZRWhBX3S3U2w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvx4a3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 18:18:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57FHxnS3006338;
	Fri, 15 Aug 2025 18:18:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvse3r81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 18:18:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6DJKeuMrx8OTO4EjbxTJ4gZJRIn2koetAAQ45vc4ImDTFUQxxXWOW+vRdayYWWBIjX3lLmwPAwAJh8HnADh7EqC4Jj85aPr51P+B/ZUO0buYjG6hsj4/vqlttGzzMfk1iP6AzzEuEJP+UTqCSHgS1SeZqWSZkOAR+9Xeo8iLJT8nD1pietFIdY0YSVwjjyDQ3SAaU6dbaMrc+KZ+OEilW4g7jswtcNyjfQhnUr71b+1VYu8RIQVOb8EuzK5CP5I9iSOjROiLpGFiAXyxljGVSfSOzv115Z6FhSqwKU4c5PxRM3jN9HywnjUYMrBXkwFBg6Q15PpfrbL2JQ7nsWt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzswNhINvu2zSDce0E+TjV2MUCjshWEEZXWI/YBdpMw=;
 b=PU3su1gA0/DNBagWNuXA0eLnclmq3P1+OlaOY+cvVXdPSCGMR4yf0CXaPCgt07NNpNmrGo9XwhF+Iawq9tke4DAlnbh3fSWtc6ciPY/2xSNc3MbxksAlHhjwTpSeN0nZOI3fmTttSNNMhcqJWNc4H72tN9QYJXkqeVqSNlM+i6j2GDwk2y6UJA4insCPh1NLeD4iF5VunlHz5jZzo7VBsP3zOovofbqU6hXRybNBgwwxP9e8EDQ0O/2sVl65TRM3OM+ZEb7l7Wh69/Ff1y3jdQrIAp5XjSToqoBIp4wI55NhA9wgE1SZP9drIpar8/EJtLWrFWYa1Fo0Jzrdeafkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzswNhINvu2zSDce0E+TjV2MUCjshWEEZXWI/YBdpMw=;
 b=dEOHakljUVRYYF43wuJx/zRaWpsrslIopigFPDplNWYppVPNxLV/sJULK/CFBHNI7FpH5ldcTKn81eVAdhhrZ/xnCTZGzi3m5U8e3QSDrkrecHYADWBDW5Z39uKnzEBrTpxliFrUgahjgocisT+/QMNWneY6b+ouNW8gshAf098=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4887.namprd10.prod.outlook.com (2603:10b6:408:124::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 18:18:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 18:18:41 +0000
Message-ID: <ad23a6d9-72a4-4363-bee5-e52164e3ed17@oracle.com>
Date: Fri, 15 Aug 2025 14:18:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: -Wold-style-definition warnings
To: Steve Dickson <steved@redhat.com>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        libtirpc <libtirpc-devel@lists.sourceforge.net>
References: <482e394f-67bc-48bf-88e4-3808f508737e@redhat.com>
 <9d84391f-d724-4693-90d9-c56d54ece17e@oracle.com>
 <42121eeb-6e7e-4138-9520-8ee81679ddac@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <42121eeb-6e7e-4138-9520-8ee81679ddac@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0006.namprd18.prod.outlook.com
 (2603:10b6:610:4f::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: 0539e51a-022c-4a97-4fef-08dddc2829ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTRHRFIxRGtHdnArV1l3ek1sSE5RRjlnem1YZ2NNNzJqL3V2Vy9qRFZHbXo2?=
 =?utf-8?B?Ny9jOCs4WHZ5RU5tRG8yWlMwOGd0WncwYkV1TWVGVDNLRE5iZ0VUNWxndU54?=
 =?utf-8?B?L2tHYjRQTzJUYzF3akp6WHJZZGxnN012ZDRCK3BlUWV1TTVvTFNrNHNFR2VC?=
 =?utf-8?B?S21lUGtJRmIrNWJ4bzYvbklhcSt0YVlXSjlkRHdkeU84a2RKYm42d3F0SXln?=
 =?utf-8?B?bW9HY3dMYU9aOTdmWnNOekp3Wm1hRFhvMzNHSGlVKytpajZzOUFrM1RraVEr?=
 =?utf-8?B?OExFQjRiUG92UDFRcmQ1cnZGbmsvNURhRnBINXNyUmNUTzdnckZ6eEd2RFM5?=
 =?utf-8?B?eGcrQ01VOXh0UzBqZGlRY2FMQ3hhQllPWVA1WHI1MEVIdlZTOGdYVVVVb2JV?=
 =?utf-8?B?d1cxTW1VbFRhRk5jREMyL2VCR0xkS21pZFZUL0Zhck44a01rYnlGSlpkR1Rq?=
 =?utf-8?B?MEhlSWRMR1FVY1NlNnhoN2huZ0hFOVpxL2dtVjQwVm00TnQ2dTZHY0xDWUhF?=
 =?utf-8?B?dG04WjAvQzZ1eCsrV2YrTGxKS0g4Ulc1UlNFdjdMUldqSE5zOGhCaE5zRHZH?=
 =?utf-8?B?TjArOHBEcWp6ajJVT0hwMENYTGtGSEliZXRPUStlVzFYR004cFJxeHRkZnFs?=
 =?utf-8?B?bE9hY1pRU2dPdTZsTkhJdmh5djY3NU5JakpyTEIyUG4xYS9FY3dnd1RZWVBL?=
 =?utf-8?B?RmgyenVWMWlBYTBTVmJHSm1yRkZObngxZ2N1Z2hGNkpDVGU4QXFRN2hNZjBz?=
 =?utf-8?B?RjN3UnVjZWRlZk4rWExETjBVM2pWVCtEZno1UVlYeGdkVGNoL25JaVV6ZTZO?=
 =?utf-8?B?aFBhdnV2MURjZ0dXenVxbmxMaS8yaWJiSlNZczloTVhWblpEUkZqczNPYXBT?=
 =?utf-8?B?cnRmZ0M0YnNEK1ZkT3hKczIxaWMxTGVnUzBpclphTFBLdHcrNjFBTDQwT3V5?=
 =?utf-8?B?NjgxckIvZk9adVYxRXJlSFZsMDJVL0QvWDRFU2xnNVdPdWtlT2wzZjU4Qk9w?=
 =?utf-8?B?eGU4YS9RR0ZRODArUmlHS2JxVTN3bE9tMnllVElHbmR4ZTNXYmtaT2FpbzRR?=
 =?utf-8?B?Ulk5bEp3czNpY1EwOWhkTjQ3YlE0M0dDMXBOcW5SUC95ZUVkR1d4cHFrdFZ6?=
 =?utf-8?B?UWhZWTlza3ZxZi9MUzE4MWVrdTFQU0JSbUhLQ1NFWktkM2ZyYVN1NW9PZ2Ix?=
 =?utf-8?B?eE1BRGExcGdwai82S25MciswbDExdXdXOGZjVjNON1Z4KzFiM2krZks2SW4x?=
 =?utf-8?B?MHdIYjNhdHVZaUVzemc1UWNhR1JwWktENGEvcG9FUkk0QzRPUXUraW1PZnN2?=
 =?utf-8?B?Vkkzamo0U2NKdU4rUCtHcEpXRnAvZEdhaEw3VmRIdnFPSmJNODg0UnJkNHk4?=
 =?utf-8?B?VzBLanR1WHpOa3dEdnNVSzR5K2VKVHVyMmFWZmFudFpXd291SVEySlNLcWFx?=
 =?utf-8?B?S1dYSk9hMkxSd01VQzZFMkdnMmdzZFBXcEVRakdRcjdxRUVESE5yUUZwQjQ3?=
 =?utf-8?B?T3ZwZjRnSjg3aUNGVGZhbWE5RmFVVUV1Vk1HaG5aWEdZVFhuMXE0Rm91aXVS?=
 =?utf-8?B?OFhrT3BiT0RTOU5ySHQ3SmdHcmZYRk5wbjVWaW5WZmRuUStoQzNWK2QvaDA3?=
 =?utf-8?B?aDNGbEE4S0JocFFncThoaHhlYnhRTDlVbEtCSzVGVXo1b2E1dDRzaW03S1RJ?=
 =?utf-8?B?ellMa08wbVZpRmxOazhvdmYzOSttS2M4NXFRY29WOVh2WkN5NTFCN3orY3ZF?=
 =?utf-8?B?SnQ2RlQ2R3dKSjZGcjl2cmNwZEcyZTArSDA5WHVSL3h3RHVoNGpxd1czbElq?=
 =?utf-8?B?TElnT2VzL0lUWHlpOHoyak56TWFDd3hLT0RuWUF2SWZqREtMYks1K3dGQVg0?=
 =?utf-8?B?WjRkRWhFb3lQbUkySm1KYmxXYW1neDl4Njc4ekIrcHFpeVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlA4NHVnd2lGbm5DckFKR1FmN0FxWGZ1eXFUVFIwNWhyeTJXc0xDRXNZRlNR?=
 =?utf-8?B?L2dyYmJnVWRpRWNpZER2ekdWcU5RalRySXlBc29GUnpzTkdmSDdMM0RqdXBh?=
 =?utf-8?B?WUloZUc1alVhMk54cmtaZGlVYVF2YmkxL3dROGRwNEtSTzZWTXl3bWNuMm05?=
 =?utf-8?B?RTlNWFFIYmFJUTJjckorVGJjblVWdnZzS0RsTCtKNjVyaGJ6VU9wZ2ljZXRT?=
 =?utf-8?B?SEsvemxNYTNXTmlna2l2TEJqNmkrZnVYc1I4UWhlZG8vYUFQRlRaK1FRK25B?=
 =?utf-8?B?YVcyMGtqOFFpbUNUOUN2dm9MM01JZVlBUkdaaVRLTnpVZHlFd3JQQm5MaTM3?=
 =?utf-8?B?aUFabXdBNmhnamxuWlRRck4zd1JiM3VMSGV2WHEyQ3FOVzUyNHZsaUQzR3Vp?=
 =?utf-8?B?YjFSQ281WXVoek5SWHlJRFhUdVhNSEpIUm1KNW1QZGplZlhtTm0yUVBOckNY?=
 =?utf-8?B?Qlh0bmJ1aWR5Q0pZc0xJdlo5ZnJRd2w2UHlOb3BNMTdZYVRvZUgwdFhOeHJi?=
 =?utf-8?B?T2pGc21wTDRWY2ZqeDJycytyMXFSL1Q4cDFMQmtIRzVFWU9FTXdlR3FCR3lN?=
 =?utf-8?B?YTQ3SmsvNk55QzhLY0w3aTNFa1hqa2d5OFdCUXYyRjNmaFhuRDBlWmk2a2tG?=
 =?utf-8?B?NWJmZTFVQmE5SFZWbU04TzRQdmQvTTV2Zi83cGRlSDMza0p1eDJVTFkrNEJ2?=
 =?utf-8?B?cnJwRW5JdXRsUnM0a3pmWTVJeFdLeGtjU3RPMlRMbjMybHpmRDVPS1VlcG9K?=
 =?utf-8?B?dmR5MnBBR1VveW9BZzF6QUFldk5wWDlpai8yYkRWWnYvS05UL291TWI1MUt1?=
 =?utf-8?B?dzlMTURoWEVSYm4vd0lCQU1CYXcxVTZvSXlKbGhCM1B2SUNVbmxkU0FmUk1l?=
 =?utf-8?B?WE1HTklrcldia0kvbmphMDhEdGYvNVRTaGtzakF0dEcwdkxJb3NEZ0xLb3V2?=
 =?utf-8?B?VXJYN2VGbm5EU1hGWUVaQ0k1UHd5RnArd2xsMEZ6NWgrNEhWSTVOaEtBZUls?=
 =?utf-8?B?Uzg4V3BrTFNhdk9xcUZNTHJ3WlVqdWpINm04U2UxVUZ5OC9KaXdOOEVJVjlx?=
 =?utf-8?B?cjkvS1JsWTh0aFllcERsWFhTVVRJVElFSVZPTFN0UVFJaFhGSFdFUmxrZXkx?=
 =?utf-8?B?RjBWWG9jbkNFWUlwL2RLTEdHalY5Yy9QWXVNZXY5Nk91M3Zxc0cvZFdTaCtS?=
 =?utf-8?B?cDVNM2tudzlaVFd2dUUya2xQRzRwZ3FKNXlqWU53dStwUHZ3dlNaMCtpcmdn?=
 =?utf-8?B?YTJ2b2pya1RtRkV0QjJ2alYzcEhKbUYrZE1BdUxRWFhRZW4zNUF3bnJFTjZV?=
 =?utf-8?B?dzMwWXVBZXNjRC9LdlZtRk5wSiswL29BTWtqeU42bkdPNDhwQW0zTjhIY29Z?=
 =?utf-8?B?NnNGTzhWaE5EdnVmbERLS2NaN1kzNEJPR0VnOUp0a2ZKc0t3LzFxM0o2OGdY?=
 =?utf-8?B?OHdzN0tKK21Rb1dobXU5WW5Nemo0MUsvT1U5Q250bWs0dnBMbHBQcUFpZHVJ?=
 =?utf-8?B?cE1aOVVKSmNUZGRBRjlhRUl1K3ptYmhFWjRRRGNqK1pHVUp2NThsZm05Zm5O?=
 =?utf-8?B?SnZ0YXQ5eXU2K3Vib2JFSDJ1MnhoUmx1M2hXOCtoWVlaWE1ZdlJKOUJ5Z2Ry?=
 =?utf-8?B?YUpEMzk0TmVtRm1zc0toWXpsYTQ4bVJMZnVJZzNNQURyNTZxa2R1WUMzUFh6?=
 =?utf-8?B?RzJ6V2tPRzBYTG9kU2F6Q01rRThuZWFJbi9waHZRdHZ1UUtaODlFNFptTCtw?=
 =?utf-8?B?cGZMSWp3ZTlGdExVa21XcG9ENy9sMVc3TmJ5WXN2Y09Rajh0Tmt3aTVJWmtW?=
 =?utf-8?B?dWU3RmFRaGZOQk11bTF6MHFKU29nbjhEM3c0VUEwQVVOT2JaTXZxb2V0UFRV?=
 =?utf-8?B?YSs3ZHpER0VtRzdGWTdSNTFiVGVFZXZoSndvMlJLSy9zK0NWbm5UOGFiL0Js?=
 =?utf-8?B?bjhsc1F6VUtFVElxZ1RiUDRuUkREUGpFWXdYQ1UwdVRhcFEwL1ZndWFNaGJZ?=
 =?utf-8?B?OWRyNERmNFNhTCtnNFpabGIxd2RtK0t5bUNDeFdKbjAyTkswUFVBOW5mc2lx?=
 =?utf-8?B?ODdWUEFNVGJ3RVcvNTZmT0E2SllrdC9tRmtwbmlCeUcyN1dyVGJFeTFWN0lD?=
 =?utf-8?B?b09aQ2xCWTdYMkQwNjZhN0libk1UQW5nSEF2SjR4b1FMQlpGK3Q5Nk5oVXVS?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zoquTAKQjFKrgIzzuWzkkykR6xq6CiRosB0aPIAKo0/T2Hf+GBWmDu0YctEoYtduwUQWQ32rwm2RtEqdECsytvWjbST3TkmM9d2/d1SmyToLOgfa1Kv6zAYDNlZ/nadv7hb20TC56E3oKE3h9w/Pj+/an4bd8/uQbnlALdEJhHfVapB+xn/9JB7JUD/LMK3S7zMikHU9OKvlFIV0/fHESuO0jb9NEkxuQVXV058V89vxo/pFheo+s/QO0x8DQTccm5BgW0GpJ7Ema617N0jzwH7XgV8TpCpdFCn26pRK9Jp6d6dO3uFNJUn8lYSbDHpKieU75b4DBfid1N/LXqmxbyQcWUQ2YPFfR8YcERmubMw+Ky1Cu4MLJqpTDHVhQjdQ8nHxwWqT84BRSw1abcyICHETTQpPpMgMNzBF7OYzoTVCthwTqS5fmVAR8oPWmpNMR6xHjq1eSC4O8HogL71iGmm8o4TkDgr96DbjDXnSyZ0POPQirmxicYqTzuCHLxvj+sdWl0Ah9QMbxReaw7uFtVZ0IY7Tx2JXsdh/7huWBpd78++azIATsLarlPzp9q/KBR/8EMm+L4GN2o68joPg6i48IvIprA47FmqGfoOSD3U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0539e51a-022c-4a97-4fef-08dddc2829ca
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 18:18:41.5683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgDxypISA1p4rsT3Xwlff6nxRhAl8/YljtIsLUkjoxTghiTHmFExjOr5bzGMxcZ39PqMg9QEuL1AECa58mBeog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4887
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508150154
X-Proofpoint-GUID: _A-EXW4vJwXUk7jkrcU_Vn7T9aPwEOpI
X-Proofpoint-ORIG-GUID: _A-EXW4vJwXUk7jkrcU_Vn7T9aPwEOpI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDE1NCBTYWx0ZWRfXwnG6NfXqGoBr
 82babxeklRYC13UnlSNeCup7vnx2u3qRx6dDD2Q0nPaKY3VEapeRC3jfAfipiTZgSp402jA/zgN
 2Ko8Elsotu1hOWwmP3vfXLVN8V2Tts2LE3NxBAuPJuWinj1GdoN5oMcUx+fwkgb7vPNOxVN8msQ
 6TTR3YGzN6ThnOUHXCYpIf3KUPH91h/UFLpq3DdanaT0xdieXPXaIW0khsRagbqbJMijhrx1RUq
 eXqYNTPtZPqC6OUJQD29FOidKf44Q0H2JqzDMhf8Ux4StXVMPIgH2wpTsIBTB4yAubnahnr0AiP
 QIIpVv5sCYZSMwKkmoOFAskxwTbw/TfIumVa5CYsUyQSIc/4JebDAmox3FE5uEKa/TAwO0Ye3ll
 6zB4CJNvEMpeYgCDV21nU2PNLZU1PI22fBv0ALZ7HdKfGMZbXNJVd8vfOARbk0r018U7eoZF
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689f7a04 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=0kBUVbQVBYTPaAnSXtkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600

On 8/15/25 2:07 PM, Steve Dickson wrote:
> Hey!
> 
> On 8/15/25 1:26 PM, Chuck Lever wrote:
>> On 8/15/25 12:23 PM, Steve Dickson wrote:
>>> Hello,
>>>
>>> On the more recent gcc version (15.1.1) the
>>> -Wold-style-definition flag is set by default.
>>>
>>> This causes
>>>      warning: old-style function definition [-Wold-style-definition]
>>>
>>> warnings when functions are defined like
>>>
>>> int add(a, b)
>>> int a;
>>> int b;
>>> {}
>>>
>>> instead of like this
>>>
>>> int add(int a, int b)
>>> {}
>>>
>>> Now I did fix these warnings in the latest rpcbind
>>> release... But libtirpc is a different story.
>>>
>>> I would have to change almost every single function
>>> in the library to remove these warnings or add I
>>> could add -Wno-old-style-definition to the CFLAGS.
>>>
>>> Now I'm more that willing to do the work... Heck
>>> I'm halfway through... But does it make sense to
>>> change the foot print of every function for a
>>> warning that may not make any sense?
>>
>> I recommend breaking up the work into several smaller
>> patches, and posting them here for review before you
>> commit.
> Not quite sure how to do that... at this point it
> is one huge commit... growing as we speak. Even if
> I do it by file... it will still be a ton of patches.
> But I agree... trying to make it easier to review
> would be a good thing.

Yes, making it easier to review is exactly the idea.

Possibilities (that you are free to disregard):

 - Write a cocchinele script or two?

 - Ask an AI for advice on how to strategize the changes

 - Change internal (non-public) functions first

 - Stage the changes across several library releases


>> Maybe you could also pass the result through a C linter
>> or clang-tidy. But don't go too crazy. You get the idea.
> No worries... I will not go crazy! ;-) But if I do that
> God only knows what would be found! :-)
> This is old code... but point taken.

Yeah, ignore the complaints about actual code. Just look at function
definitions and declarations, etc.


>> Out of curiosity, what is the test plan once your
>> conversion is code-complete?
> The upcoming bakeathon?? In general I lean on the
> Fedora guys to do the regression testing...

Are there critical applications or packages that build against
libtirpc? I guess... rpcbind, nfs-utils, any NIS packages left? Do you
need to build libtirpc with alternate C libraries? On alternate hardware
platforms?

It's hard for me to imagine functional breakage if the code is still
compiling.


-- 
Chuck Lever

