Return-Path: <linux-nfs+bounces-10030-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27078A2F965
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 20:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD17F160C2B
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 19:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A80C25C6EF;
	Mon, 10 Feb 2025 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BlUggtZu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NYPTop6N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA5A25C6E0;
	Mon, 10 Feb 2025 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216936; cv=fail; b=fNd73y1qNKspYaQNuICrM07Cpmep2w9LzZmvVwhIjW85ms6iV4ZeIGiijZPPiW+UFRqobuuYv7a1n5ZBvzw/mIdCXMamTTYV9I7QWpFiRWfCn+RmmS1E+GUbSpL1+8GeuUL8xbkbMI+Qjksl9lny9aLuQ8LVr6bZ9CStOVvwYKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216936; c=relaxed/simple;
	bh=c9uDye5zGgWJoGnuDkoJfAELi6FvJTByyZmDrbaVTEg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g+AewIAYmQ5w/X454dM0yC2JuAJ2HNMRQ+BrCRG+4R/7qHeXAjgRdaYq13TgQTlcV7RlnjdsSGz43MtKi2LqtA4I+VpXf8LjMVpFBCebhvzg83HeCEALiX6SgNNZhRPKy3ZRzfmjA8s3SpMoTUwaXFvEbkz8p8gaLHKFa2IzkCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BlUggtZu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NYPTop6N; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AHMVrW000790;
	Mon, 10 Feb 2025 19:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jkNvVYAc2NGwiAqVqTE0WmhzibA/RvEEb44YcyRcDlk=; b=
	BlUggtZuuRGkjyUQyrn+1LK6kL1kux1Se+vxfpjjuNNZtQo6YJ5dRARQGACscevy
	oc70mrTjCoJEjTHselzU6XUpmi2T0oQO1vbtzPla5S4lOh5DliIkj8rOsn0oK74m
	JlPb3e8tQ82XosDQYB7hwhyKq4bj1Rcy8RtC99n/E5iF5NltBwjRvEuR3c0hM1dw
	EnmOaXEY8LQn88WMkwaEYEK+7xDJVRYROds0mLIYJXgFcrE8n34lJPWJiXvQ0zK2
	Hi2MwJSVivrMCDV1kZvhjzVvD6s7SvKFWu9panznHTt4fsEbvKGdgYJKxIvhw1Vw
	z782ePjJe0dO85v08shuig==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2bs0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 19:48:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51AIu9WT002402;
	Mon, 10 Feb 2025 19:48:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqebux6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 19:48:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5tB+XMmO6c51mLIj9Ko2WAC34PRhIJxXYt0Zdbqj82BXlCWbdLEGVH+RvqLvYX/nJkQiTLdlhlgRgSDb//cVFy18u9pQT3JO67hUoxUQKKxcwvNQaQPHJ/tnJ9aTEQiPqRRIcn5WzgRKOD4t7fthoqqSgrrVsuFTUfIC0lTb5CzxOzqbjaYFJY7ouQ3Yx8AVx6aY2vGllBfnEvo/FUkdVSb38ox5w5PjlR+q2StGotj1PTIU+cpZ+3gMhmigf7spDo1VRDTMl9iFBu37/AZQ6FlQf4n65bXg+INimlhBEOAHMncnthZ7G5uQK7jzzDxYXLGhLnztplq/tqcVdrw9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkNvVYAc2NGwiAqVqTE0WmhzibA/RvEEb44YcyRcDlk=;
 b=rJ4tiChZA3WsLrAzcpWt5BmO7NBlZGRT9EiztG4FEBH0/+yr1InwURGV4OlaTrgMNx08lF2ubPBTebple//mrTULUuCxc/KcNjdFmvmBGbeBW3TliS/DxT2Dv11kRGllls2p6VHPEULvZRKG+vopLH11Vlyh6tJlskusIBwGQL/JbbQFbzbdC9GXptzr+2WeOm6JIebjbHg8AO0J0lF3JM2fsUCp87QiG6Od94cGZ2OlwMOeZDrJpW4a2hvrxuHMQgU8WjS8lwwsua9BmVio5jnNwK+VyQWgEsain95r55JDfP5suBRi6UNsCZkaM9x/RiuC2d2NmL5RJisweUS65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkNvVYAc2NGwiAqVqTE0WmhzibA/RvEEb44YcyRcDlk=;
 b=NYPTop6NGYWYb0wW/KjQXaAlDSVmqTL5FiK6C3RcWcumcsYDHaVwoHRVfGZwXamYifqeG2Mk+TUSQuN6ZSZN0g5nlZ2fGfblFpJDxZ4zgYPRoF5PkLluKvrCjvyNpybcE/oCq7fVxorkLk5ebXUvumJGYnZA1D8MHyWwwBVWUzc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7135.namprd10.prod.outlook.com (2603:10b6:208:401::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 19:48:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 19:48:41 +0000
Message-ID: <b16ac12f-166a-4d25-bf33-b1ccf6e0dac7@oracle.com>
Date: Mon, 10 Feb 2025 14:48:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH][next] fs: nfs: acl: Avoid
 -Wflex-array-member-not-at-end warning
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva"
 <gustavoars@kernel.org>,
        Dai Ngo <Dai.Ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Neil Brown <neilb@suse.de>
References: <Z6GDiLZo5u4CqxBr@kspp>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z6GDiLZo5u4CqxBr@kspp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c7fee7a-1f0e-4638-49b0-08dd4a0bebba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXg0cWpmREl1RVRrSXdBMmt2TmtOM0s0QnRFNTVEUTBqbHBlRS9EYzhsMW9k?=
 =?utf-8?B?MUdON1Q4cVMyYitwTFF0OWtpYjNPUkxYcC9ldGFIQmpEWTFVWXJFd0MyN3d6?=
 =?utf-8?B?NDVGZEdMbmJqckMwVzBGTVdtRGpWa1JoeEJTRXBzbGZ6SGJSVXEwRzMyY2Ri?=
 =?utf-8?B?WEYxQUFCR0FoZTIzZ0lrbWdCRW9yYUhPYUJ6ampDZXdwdHdUT09rNnJ3b04w?=
 =?utf-8?B?U3N3WHA2VnVXUElsNDYwZVpSWTBpQlVPMXRzZnJuTW9jbDFZK1Fwb0p5Nktp?=
 =?utf-8?B?NVJWYjMzTS9BYk1rYUs1czVxTFBxbm82clc3ZEJIT3gxMXcrWUhTWml4WWla?=
 =?utf-8?B?VVN1TmtTVm01cWxHeFhlTUhFd0tOVEREaTI0eDlGNHBlYzE5TkRya1laTS8w?=
 =?utf-8?B?NVViSEdRRGNGNG1sNDRNNkcrbG1DQXU3VXJzZ2J6b3NtVFYvcldUc1RzQUNH?=
 =?utf-8?B?bUZwWHp4Y1Iwd3ZSYzJIN0ZiS1dBZmpMbEduVURPNW5qYXJweXhlUjdGVktN?=
 =?utf-8?B?Mi80dFBMNXNrQ0pSZnRNcDhtRFNrcTdJbXdGbkp2VThRZmwxOWswQmV5dm9U?=
 =?utf-8?B?Si9jZUx1OW50WmxoNkxJelJuMXdOMkJDVjFVZzlrdjRnL2ZWVVc0ZXN5YWFj?=
 =?utf-8?B?U0pjYVpyZUhERlNYRkkzb2tacTRwM3R2bHhIdVBFSVRMSVJjNE9YTlhSSjgw?=
 =?utf-8?B?RHcyR1hLb3ZHaWhrWEI2R1ZIdHJGY3RadXdVQ0x4S0tmOWNyWjRQQXNmcnVr?=
 =?utf-8?B?cUJoRTVHY1N6cUx3V2NhUys5RlRsbm5mSHJnbC9uM3FmcWtWcGtVdzkwRllv?=
 =?utf-8?B?SmpKNCtkLzJSekMvVHcrNVI4bGYwMEVZNUVQdWZ4NkFGeldJQnljSUZkSWVw?=
 =?utf-8?B?K1VpT1hrQW4zNEVXYXA5QU9ML1M3Zm5ucEJMLzBFM2R2eVBrVVpqZE5tdHEv?=
 =?utf-8?B?R1Z0N3RkeFhsbnV3bndwc0lRYVlSaGJpWU9WUjlSK1pGeVYxbXpsaWtNMUlx?=
 =?utf-8?B?OXZKUHNNOFBkckQ4a3lOZXJMZjJtYW8vNzVUT2kvb0tOMUhRcjlmZGJNTSt6?=
 =?utf-8?B?TVRja2R5RkRQK05vdU55SzE5VlhEVlBQV3NNa0VXNTRSRThndENoaGxwSDFL?=
 =?utf-8?B?bHFUaUhyYm1RMy96RWc1ZDhLdUhLQlZyZGxGVGN2N1lmNjBycEovSVR0MGEy?=
 =?utf-8?B?QklqS1dZemNXbWpzZ3Z5bDJIRWY4eXk0WCtPYW1qZkxFQ0V3djVkZEc5dWhW?=
 =?utf-8?B?QnF0Y0pJNHBGSCtkS3VYZ2lGbDNlMXY1RUlOQkg3U2tPV3JZdDN5bDhhR3N2?=
 =?utf-8?B?U1Zhb1hobGVlQ0VIM3ZQUGZOK2hzbHVoMFBoSXFQSjBSdjQ3dER6ZTdaeFZ3?=
 =?utf-8?B?SmJ0SmNER3hUM2twejhtRUhUamtheCsvak0zc1gzUUhPdUxadjV0TlY1UnhW?=
 =?utf-8?B?MVpDQ3h2Tm1NMUxPZDNMZEF5ajZlWWlkZVlrOUgwOGcydHZtWUh3bng4aEVT?=
 =?utf-8?B?b2hra2U2T0p2RzA0OVZicWpSL2oxTTAwRU5FajI1akZaaU54QW5ZSllacyti?=
 =?utf-8?B?V1NzOWJxNHkybUJsNU5TUFdrT1NacFBUaExIWGJ3S0ZXdlNrUUN6MUUySjRu?=
 =?utf-8?B?U0FjNnd2MkNrS0x3eEVoTjMvdXlFTjAyMWduWXV6bXhkcmVZckZhNVZ0d0pz?=
 =?utf-8?B?cTZ1VkxCU0hxSnhJVjN5WDVoMXlyU2Y0RllDM1FLYkxVZHNhY1p5QjdtOVMw?=
 =?utf-8?B?Sy8xcmVEWVpyRDN1TTZ5a2t1YmRkdDRCUmkzUzJZcWozYncwa1A4dzBHYURu?=
 =?utf-8?B?VzJDdnhNS2VQT1NwQWJFa000Um9yMGJVOTd5MUg1S0NTNUFnQTJ1blZaRFBK?=
 =?utf-8?Q?O8D4VYVzlBI4D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2FBSHc5M2dSU0IvM2FSOGNBR3JiMnFTak5DMUZKWGRNUG5lRm5lTmNOK1dR?=
 =?utf-8?B?WEVRRy93VGtLL1ZKQnptRkJUaXAyZXJSZEhYcXBUWmRmSC8vMzUyTkxWRkVR?=
 =?utf-8?B?WDY3WERzRVlvWnU0Sys2OFBmY3VqdU9GVGVBVnVac2lRTWY5M1p2a1VsNUtt?=
 =?utf-8?B?cW4yWjlzeXZweUZQb1JMOTJWWjRKK05ROU9oVDJJemFBQUZLYnFxOXNtc2w3?=
 =?utf-8?B?R2lZOXI2N0pLbzY5OWxMRW9QK2M1Uk9zZTZPaFpWdWhpcTNYMUVubFAxd2Vp?=
 =?utf-8?B?NTk5SHZ4cktrMUFNMUcybHNrRVNRMllPUTRMeE0vYVY4THlKa1Z2VW5IZjd2?=
 =?utf-8?B?NXhKNndqVUc5b0JNYUJpM2RCUzlHZWxKU2tDaUZkM3luNDVhaTBESzFSV2l5?=
 =?utf-8?B?aWFtbnV6TWJMYmQzNWVYbnBnN2Y1WnJzSGM1b05OTElkK0x4a2phdWgwVG40?=
 =?utf-8?B?V0Y2UjRQbmZxNG4vVjdNWVY3WGh2b3FMNHJzMVd1RjRONndkUDlxUHhxNEs5?=
 =?utf-8?B?TVFybVFyamxOc1RDalBobnRZR2MwcTJQY0YyL3F6aGxnT21YTWQwcC9LUTlH?=
 =?utf-8?B?VVZac0N2akY3UGdEMFpyNlQ4bk5DYmI4TzRsN2VyaEZXQ2xEVVZWb25zV2Vi?=
 =?utf-8?B?SFRVY3BxbzlCRk9DemFxOTFBMXhXTzRHNkNleWVjNE9XRHVPNkJqOGJjaEt4?=
 =?utf-8?B?bytqTFh0T0NxVCtnYXhFTHpLNWlGQll3dm0wUG5KeHdzdHF2WndFbkhtYUhr?=
 =?utf-8?B?NEE4bWg0YUNRT3JvQUwrTjFSdmtsWnRTQjF2K1Q5bDZucU1zbnoyZVp0NWQ1?=
 =?utf-8?B?RUNsZGVOT2xYZkhrQ1BLYlBRaktKMnAvdDJvVmhrNTV0cXIxWDh2L1JrODBp?=
 =?utf-8?B?VlA0dnJ6ZjRNNnB6eHM5YWVqeDJMUGtSenNOWFd0R2VtdDluWENCSDdtN3I0?=
 =?utf-8?B?SmNsSVdvSThPeXllYkNXWVVWeDRVd2lvbC9Sakd6UzhleDl3WmZBQXVwdnFG?=
 =?utf-8?B?WXl0MklPMitJZzhjVGcvNTZaNGc5TXE3UkFVUWhLNXY4ZnIvc0YvaXFYdXZE?=
 =?utf-8?B?MWRNckFRU3c1Mm5tZnE3aTNXVlU5RHZKTGhadEY4cUNCUU5KMWlTT3dETzVK?=
 =?utf-8?B?ZHdjNWptWnJNRnhIcGtaNEM1MnhaRyt3SGtlMHM3SXl5bFFwdkw4K3EySS9j?=
 =?utf-8?B?dytEVlduT1J1dXArYWlYTEE0WFFXTWpZdFpRTVRaaGVDdUw0RE1OUXlRcHdM?=
 =?utf-8?B?NEpiMDFnUjdrakRaN1FMWERaeXUxM0ZRWkZUZWlDV0lKZWNvUVI1ZHZiTU5T?=
 =?utf-8?B?VUZpY3FTY3doNTU3OTArL1k4SVBFV09rTmsvc1oyYVlGVzhpMmR1QXpON3dK?=
 =?utf-8?B?endCanpFQVk5VjBBcDdTUkwyTlN5MUVwS0Exc0svM2VOYlRtWmFuMkVReW8y?=
 =?utf-8?B?cWg4VVp1Nlo2bk9Jd0pOWWtoNm9oN2xhY01PNG92RXhQeXpqR3drVGIxNVow?=
 =?utf-8?B?TUVHeDNnZ3JNQ2RSOTdLMzZoaUI2OUJ2RXI5c29NUzRQZGppczF5UVBuNzhE?=
 =?utf-8?B?UjhlSk1PZnJJTzNwM0Q5TEt0aXkrcmlqRTNvYk5LaFdkWUhSUGk5Um15dE51?=
 =?utf-8?B?bVE0QXJPTzZVb2lVZGpBbjlKeUwyakljcEJVTnVYWWZERFlMODZHenlWczha?=
 =?utf-8?B?QzNoTHR4a2F1d0ZwdlJsZm9wOHIvNk5jSkord01TeFFxMkdNSXNEMTd5a0tj?=
 =?utf-8?B?R2JXOUhZbHJWdXczcFRWb0JQUHAyQ2VsOEVockZNWnBnL05NcE42dG5jMU03?=
 =?utf-8?B?SFMydFRSMjBKd0VxRDJETEpQMGNxWmQvbVFzYjlOVis3Q2E1Y0JHMERXMHlj?=
 =?utf-8?B?aEJ6Wk52S1F4YmkzS2lRMlpnOWFybHc4bGZIQ2ZRb2dLNi93dkIwbG9jci9E?=
 =?utf-8?B?ZjdNQVFvUFRvakdsQ1k1Q1ZVWVNlT1Y5bVQvYXRXc3JEenNYbTdvN2w0dElG?=
 =?utf-8?B?QUxSb3pVOVFJZXNWVDRkRjdEQUh1V0RjZXRNbVRsUjVwVU15YTJLRjI1VGx5?=
 =?utf-8?B?Vi9CanF1WkJZL2ZLVjhCZGV5dEpJeVJJRVBOdXpoeis0SE9XZGl3WXl6YmhE?=
 =?utf-8?Q?+OM2j9fBNdHrzbZtgoBxXTx9p?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bay2h5FaM7B7JxPOzbBwSLZr4V6HvFJpHneJAuGtQ7sTzAjXEYY2MEJbG9/RnZHFq6RpFFRdKT5xDQZOCzfcP9RWBBaUHASqTnrdvFQR6WIp+QAH3a8iHuZdSXDoUoKwtMbE9lcpSX7AKiubQ6svwXcl8GIAF37rqESXpMlwN5xC5rNkddzNdcUWHdqmAh7VQlp71ORUhP8tqNvpys7G0dtCAJh2MS3HzwDtKF0jaIiW+Kqx+qQJO5WH6p/SdtoOgqKyeEB/6kewL6GU2dYQTAK4TuytXgct1JcyzHmCTgiplFKl5gWYCRR4naMYZqAbKNTS0SSiRniG5+ZHaEx7PBicwa4rpIqF3/lKGcLlxwAMX9IGFl0H8hVievZBq/8ZA80z/8QVwCPN22AEi3P0P/OfOzhfYNlejCXQxx+KEFBACrKyfIOaa2ibXE/ZyGNDsxb76A1a6rZypyBC6ifMyoDCeut7/iPBCF7n1kbs8Td7cDAh9SgK0egpqzPBDi/YmYMVouBCE6a0AczU33eVHPV7mORMsJJEnb2E1SDVDfCmsarvNk+fa8X0WOS6zQvY8Uu1r/fkZpTKYh/EzU43+QiZQECy+o+u06VDj0jxeTA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7fee7a-1f0e-4638-49b0-08dd4a0bebba
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 19:48:41.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnhCcs6xoCd0kEVLN7UYAJUbg4NM+nRqnQW1RlET6LLOh4mUQMLlxHNN//WJhcU3fmziJvmxTDvYg4NqRXyIMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_10,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502100159
X-Proofpoint-GUID: dbtB6HGiwGF_XhZViXAuSLWCJHi7MDld
X-Proofpoint-ORIG-GUID: dbtB6HGiwGF_XhZViXAuSLWCJHi7MDld

On 2/3/25 10:03 PM, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of other structs, we use the `struct_group_tagged()` helper
> to create a new tagged `struct posix_acl_hdr`. This structure
> groups together all the members of the flexible `struct posix_acl`
> except the flexible array.
> 
> As a result, the array is effectively separated from the rest of the
> members without modifying the memory layout of the flexible structure.
> We then change the type of the middle struct member currently causing
> trouble from `struct posix_acl` to `struct posix_acl_hdr`.
> 
> We also want to ensure that when new members need to be added to the
> flexible structure, they are always included within the newly created
> tagged struct. For this, we use `static_assert()`. This ensures that the
> memory layout for both the flexible structure and the new tagged struct
> is the same after any changes.
> 
> This approach avoids having to implement `struct posix_acl_hdr` as a
> completely separate structure, thus preventing having to maintain two
> independent but basically identical structures, closing the door to
> potential bugs in the future.
> 
> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure, through which we can access the flexible-array
> member, if necessary.
> 
> So, with these changes, fix the following warning:
> 
> fs/nfs_common/nfsacl.c:45:26: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/nfs_common/nfsacl.c    |  8 +++++---
>  include/linux/posix_acl.h | 11 ++++++++---
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
> index ea382b75b26c..e2eaac14fd8e 100644
> --- a/fs/nfs_common/nfsacl.c
> +++ b/fs/nfs_common/nfsacl.c
> @@ -42,7 +42,7 @@ struct nfsacl_encode_desc {
>  };
>  
>  struct nfsacl_simple_acl {
> -	struct posix_acl acl;
> +	struct posix_acl_hdr acl;
>  	struct posix_acl_entry ace[4];
>  };
>  
> @@ -112,7 +112,8 @@ int nfsacl_encode(struct xdr_buf *buf, unsigned int base, struct inode *inode,
>  	    xdr_encode_word(buf, base, entries))
>  		return -EINVAL;
>  	if (encode_entries && acl && acl->a_count == 3) {
> -		struct posix_acl *acl2 = &aclbuf.acl;
> +		struct posix_acl *acl2 =
> +			container_of(&aclbuf.acl, struct posix_acl, hdr);
>  
>  		/* Avoid the use of posix_acl_alloc().  nfsacl_encode() is
>  		 * invoked in contexts where a memory allocation failure is
> @@ -177,7 +178,8 @@ bool nfs_stream_encode_acl(struct xdr_stream *xdr, struct inode *inode,
>  		return false;
>  
>  	if (encode_entries && acl && acl->a_count == 3) {
> -		struct posix_acl *acl2 = &aclbuf.acl;
> +		struct posix_acl *acl2 =
> +			container_of(&aclbuf.acl, struct posix_acl, hdr);
>  
>  		/* Avoid the use of posix_acl_alloc().  nfsacl_encode() is
>  		 * invoked in contexts where a memory allocation failure is
> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> index e2d47eb1a7f3..62d497763e25 100644
> --- a/include/linux/posix_acl.h
> +++ b/include/linux/posix_acl.h
> @@ -27,11 +27,16 @@ struct posix_acl_entry {
>  };
>  
>  struct posix_acl {
> -	refcount_t		a_refcount;
> -	unsigned int		a_count;
> -	struct rcu_head		a_rcu;
> +	/* New members MUST be added within the struct_group() macro below. */
> +	struct_group_tagged(posix_acl_hdr, hdr,
> +		refcount_t		a_refcount;
> +		unsigned int		a_count;
> +		struct rcu_head		a_rcu;
> +	);
>  	struct posix_acl_entry	a_entries[] __counted_by(a_count);
>  };
> +static_assert(offsetof(struct posix_acl, a_entries) == sizeof(struct posix_acl_hdr),
> +	      "struct member likely outside of struct_group_tagged()");
>  
>  #define FOREACH_ACL_ENTRY(pa, acl, pe) \
>  	for(pa=(acl)->a_entries, pe=pa+(acl)->a_count; pa<pe; pa++)

Trond, Anna -

Let me know if I need to take this one via the NFSD tree. If not,

Acked-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

