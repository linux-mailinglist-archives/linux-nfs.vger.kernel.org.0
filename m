Return-Path: <linux-nfs+bounces-9754-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6921EA21F6F
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 15:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1421884937
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66261ACED2;
	Wed, 29 Jan 2025 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FBu3ofln";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="quCz4Ps/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13542049;
	Wed, 29 Jan 2025 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161777; cv=fail; b=pn1oOq+WozDUC2me9QnAiFWzkJpZk7q6lL/p9F7df7mqtnIzaCfn7eop2iWiWNVpgZKoUN6Qo1arTLy+6F3fSM+yIj7gNnnqtwQsTrFXH8AG9eJ/f917Lu87zxZ5IfaxbjZMgtUcWDlg2ER2P9/A+brAdEmDjx6CPAvu6KfWF/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161777; c=relaxed/simple;
	bh=uuCqHvB605Gpue6z82W0IeLn37OtxzA6DVR8S7qLfJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KAJ//s/C+FnyiQ0c1Fy13GMtFTr88VmoAvtHUcdbK+6a5/CyqXJuLD8cKqqGmOzIoBn5JXZfFCSXWqc8G9f5We4BIgVkSV1NkPj1a+gQm238+QVv0MGaZDMAXY48KPeEENDwwBFXWWSIUSJsXt9hTLtLkT5YxWba0foXWJ2fuZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FBu3ofln; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=quCz4Ps/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEbAD9007542;
	Wed, 29 Jan 2025 14:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mddhGzTHgaXrek4NwtHLKYI2rAaAX54vDMilHvJ/p9Q=; b=
	FBu3ofln9UVY8DkWh1J6MkDSr4aJB4ad42b1rtc3u/VGkoxL+q1fVBUrQKek+V0Y
	VNydzL43JWGxCPt9I4l1llt6Tsf3++VtWreDAa6CcKURbVeBtnEnZqWrDI7bfhVt
	bDfdbEz7oxfJxA22UL/eJwwKMSaW7Hjx9jPn5TgI14jxuTfpLEYYmIJKB4g0LDrl
	Qe3HHWCXbowPnaJ/QUEKrZ4//2ZklPuBdI5I0a9/SAq4X4rouQw2502RRyoGVLa7
	YK9OBJ87Rv8fkDrEdjapuy7QIeufeZWdYVzhotjBTWMPWEYVSM3LGEOtZvFqAttg
	bVs4oOX1Rw4cG+u75HoeaQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fp8e00hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 14:42:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TDH00u036137;
	Wed, 29 Jan 2025 14:42:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd9sgqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 14:42:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ci+0uO/k7S4IYgoNkmx4r7W2D2BwSRLzoDc+xgtEhTD858VlfvR+R81ACzS6GD+Qj8+WZpwbYu/IW8cJuDkTz2qTzZ26iVyz0BYuzyLYYzOvC+R+KOtDtOfs6qt3ktt43ZE3j1Pj8IUsrtBYKYiSSEC3Dywy1Ddm1DIQvjO9ad50970CZLq1dQXyaOsZSYHE6ffRO9KU+LuEmu236Bw7foJq7fmgpoveLDEurDnJ9Mckre4MBh9uZz1IMO4QCYMWiJgDUOHCNoP1njdYsSWfKQAoBN4k7nqrGqQ8hVh5oNmwEVnxhFH2DhvjD2QKPu6CoszAqxBgXwOoENWQoaH1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mddhGzTHgaXrek4NwtHLKYI2rAaAX54vDMilHvJ/p9Q=;
 b=G7nud/yNINbARu/jZkmJQhKnSCc+Z5MKh9lPuJPfBxyZ+5awMSvz7z/kE6gM2eMgwIeiZTXlJRQktVG+m+9RCTK07feeN9SuZ7CTVOa5BNErHJ6ycwLKp7LiE/qzzGFyfiUgSYXRwIwDBfNU8aOM83EyLJ/mcE+84iscykjOgT7UoLjLzm3tTlQBJBOoiuWrCkSH1tj089K9s6+/R2BCele2Fd4oQ43bethPyBnFdTb8GUw4hUfdbPILgXMwJ4jy+Xb2xFOrTa6lGIhW/8d2MuXMRnSHCY5LymGEuybJ6uQTFfu/hWMwiKSdYsuF1isHMTn9vUPfxlwGJ0pLDgx+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mddhGzTHgaXrek4NwtHLKYI2rAaAX54vDMilHvJ/p9Q=;
 b=quCz4Ps/XwnaWRuKOLE0RlyHOmNNdCn8OIB1h4boBR09Lk6CHNF6ZRWYbbvlZ2Big1t9hQ5MtKHwIGriRCZN5iSU+b6TazXbm9yeIJxCP+7pujy9CKb6RhWycCny1z7pymIVMgg+eH0I+rYQ6VV+n1wkOE6ddgFjnBtMaoDyqVI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA3PR10MB6969.namprd10.prod.outlook.com (2603:10b6:806:316::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.24; Wed, 29 Jan
 2025 14:42:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 14:42:41 +0000
Message-ID: <c3b73d4a-12fc-469e-8b54-ba714dbef54e@oracle.com>
Date: Wed, 29 Jan 2025 09:42:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] nfsd: CB_SEQUENCE error handling fixes and
 cleanups
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
        Kinglong Mee <kinglongmee@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
 <2f2c7a8b-d44b-4f41-99db-f3401108198c@oracle.com>
 <e7bac9378168056a7000959cd920e8c703b0c7fe.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <e7bac9378168056a7000959cd920e8c703b0c7fe.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0394.namprd03.prod.outlook.com
 (2603:10b6:610:11b::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA3PR10MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f364c5-1c61-49b4-7b3e-08dd40732f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDlQUW9CNTBYWjVmR0UzdUQxK3dVMGhobWxnYWFNVDVQVFkwY1dSVElZMGlp?=
 =?utf-8?B?ckJtZllaUU9OTGtFMWUzN2Q3QkZzRmQ4OTZ5dUdiOWlDMUkyUDRJc3IyQUdS?=
 =?utf-8?B?dElnSmJySzQ5bUg5YVV0WjBNNk5iS1VneHJqUVl4L1FFaERTaEVzRmovSTYr?=
 =?utf-8?B?SUt6cDVha2JscVQzL2VRSUlBNmcxNXMzai9sNG9pNFFHbmdFVkpFTzRBSVVq?=
 =?utf-8?B?MDlBLzJhSm1xbXpOYkpzRDFGb3VsdUVrNHFxNXEyT1RQQTM2OTJJREVWOHJ0?=
 =?utf-8?B?dmxOajRBYmQ0YThWTzM5N2d0WU1XVCtTNGNwcE9KSGJIMU1Ec2IzNWdVc1Fi?=
 =?utf-8?B?NVp4QkdrWEZJeU5zYTRjYkpLc3lYclhwSVBLYmt5UTBBK1dXV0FqNzhqajdT?=
 =?utf-8?B?NnY0Sk1FMjNqemhwcVFNeDR0MFRhS2IvbDM4eDZQQlY5UkEzRURpeEkzeGVl?=
 =?utf-8?B?azJCNVZmeHc2bkJlUnpyb00yTlhPZkhZUUtKa2xCZWpXTkhSTEllcDJhalBu?=
 =?utf-8?B?MHlqckNzbHRMeEtLaEVFQTgxdkd1YmpKeFNiN2EyTHpBWGJZTlpUcDRBVDdH?=
 =?utf-8?B?NlNTdC9xenpteS9NKzBSQlhqUUllL1JGcmdTSThGYkxMbFRBa0FaU1ZzZ25D?=
 =?utf-8?B?c2pYMHAyZzlOemhKVFh4Q201b2R1ZGorbmlYanpXdm02ZmNkWkhNOWkzTDVY?=
 =?utf-8?B?NHpwT3RpYUJVd1BjQUpuUXg0aFhjV0NqL0NIWkF0SVZ2YktmZ1g1WU9oZm9l?=
 =?utf-8?B?Ukp1d2pONm12b1lSdmhNR2NXSFJPUDBObXN2UXZUVVhyM24yd2dwWEpxcmcz?=
 =?utf-8?B?WWluc0ZSWmJSNnE5U1lqRk82OGZUR2ZDcVlCc0RHWU1WaFVjTzdHNUpSMVhi?=
 =?utf-8?B?U1NMaWY3TXJaNWtTTllUVWdpQUlDdWxlNFVrZ3Bxam9ZelMwVDZNcTFSYjdE?=
 =?utf-8?B?R0NROHFHQUpUVUJOWHJkb0VYV2RWUGh4ZGNpUDRySDVoSStrcWkxS2pIMzZs?=
 =?utf-8?B?Z09keHlMUW5SRjMyUFk2ZzNNQTd5QWVOdnF2dHBwTUc4SGFkQ1d6UW1PMXRB?=
 =?utf-8?B?WTZDWmh6V05vaVNSRXBtRVJaQkp0UXBDZ0MyUFFsdlRQT2c4NlM5dmZabTBx?=
 =?utf-8?B?aEhVMkkxNVpkZjZQdzk0RnBlUGtwN2FOb2tWVTVBTVZSWmJPQlhuS3g4L2ha?=
 =?utf-8?B?UDVTOEV2QkgzcHM3bEx2ZWpuUk5qK0U4dlNYcWE5UXBhOHdFci93elJxSWdD?=
 =?utf-8?B?akxpK29idEJ1ZHF0ZWpZeVJmM0NjMU1ZMDBiNHlLamFrcnNRTkh0b2pGcXRK?=
 =?utf-8?B?b3BSQUdTRURrUEhRcTN2bzdjRExPVmoyZUhOZ0VueSszSFNDM0pKMU9HMlZ3?=
 =?utf-8?B?Vzl2YUd6bTBlSUJ5d1BXRkJBTERQRUVPbHlwR2VCVW5UQUFqbXZtU0xaVHA5?=
 =?utf-8?B?YTVBbG1Zb2dFTXlyUVNlR2FHWlBoeWg0K05GbEtqUk1sR25MaUdvdGhaRU5h?=
 =?utf-8?B?K2lBVzJJelYrb3I5VzRqMCs5bWlER0hzN2V3N0swK3NhdE1TR1grYUY1L25P?=
 =?utf-8?B?ZS9yYXZ2ZFFaL2hqb0tKcUxEbGlUTkpwRU1vcEtwTld4RWVvQ1o2cWVmbU9Q?=
 =?utf-8?B?SnNEWmlZT3FWTXdOTG1MUkRkMGsrWWxGWEQ2ZEc1eWQra0dxanlicDh6akFZ?=
 =?utf-8?B?NENiYlN6RjVPUFhGMkxWdmZGckl0a2tvVk5YdWZLNWF3MW9lTXVmckU2dHZC?=
 =?utf-8?B?d01mMG1OZGlrVkhkcGZvblB2bHBRYlErbG9zTS9kT2ZuajJodko0eWJGRCtz?=
 =?utf-8?B?bmZZSlZxSXk2UTZEczg2REJzVStCZ0huOU9zSjlyTVQ5YnI5MXViSnZiTE5y?=
 =?utf-8?Q?168qXQKyXUiIq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFNLUlVxUnNPMTVYMjBTRjRPZXY5MmNzODhPQ3AwQ0FFRTI4akVJMXhSRmlY?=
 =?utf-8?B?STl6MnVleEduS3RyMnp1YmFUWG1KMDYrM1FGYUJObkd2Tk8wVzQzU1huWjA1?=
 =?utf-8?B?bXErcVhyQzlSN2Jwc2pYN3NHN2tGTEM3YjhIMWVWYjE2MDlTSktWc1J0eGJh?=
 =?utf-8?B?K09tZG9xUGYrMWVsL2Q1ZmloMi9KNEhOK3ZKL0ovNW5RYVJXanYrZDZxa3dt?=
 =?utf-8?B?WDFHdG04dU05a1c2MHFjTnBuVURDQ2xPcXZwNGVVRkxVckZvMFNIZ0Q5dnVC?=
 =?utf-8?B?d3ZBRzdXRFJubURGTXVGOVRNWXB4TDlsWXYzMUV1WjVQOFFCMDVxTDdEWE9U?=
 =?utf-8?B?ZzJWY0wzVXBDOGhGb0lHZDg3UWhzTldDZkk4Mk9ONys0czVldXpaY2oxZGg2?=
 =?utf-8?B?US9jRlJpNjV0SnNoeDdNOHU1U2FyN0s3Nm5Vakx4azF2dS9oVVQvUGV4OVM5?=
 =?utf-8?B?N1pvNkVFQUxKb1VNUnZCRGVtSFNqNEtGYW5rK3ZUSnFrc25leU1QRDBlT1Jo?=
 =?utf-8?B?QTRNVndSbkdVZVBydHl0SFhCUWVKSzM3amZ5NDc4cm50NElzVksxbEJpSkZo?=
 =?utf-8?B?d1owaUl5YmY2V081WjhISVAweHljdVFpWUdIdVVUN2N6T1Y3YytqUGlYU2Zm?=
 =?utf-8?B?eHJDdGpqZkZyQVRTVW96a01vNklwRkF1UjY5aFluRHJZdzFKN0xlMS9qaG1C?=
 =?utf-8?B?M3NlUkhqK2V3N2xjejl6akk0aEdzWEdTeVZuampjSldZOEJoVUxYQVdBcmlI?=
 =?utf-8?B?UUVhdVdrU2hjK0UzdlR4dHEwbVhQVnhhMmFaRzdrYTd5RkVZRFpMVHFXcTJ3?=
 =?utf-8?B?bVFqaGRXbHE3Mnp1bUVjSGhYeFNrNjlzQjhRalAyZ2NNS2Q3bUpsYXkxTk9y?=
 =?utf-8?B?enBMNkljNkNMLzkyL3FYczkvd2xjMU5Ic1dud3NIRUlmdnRiT2lpbWI5K1Ft?=
 =?utf-8?B?TTdhcjkzVGVqZXVYWW5MVUlQa0NVWXNyVVFuVzBISnNjZUppcXFNeEdBdmgy?=
 =?utf-8?B?OXIwS09Gd1lGQ0ptSzNWUkNzandoZ2hvRjluY0RxeFM3alViZ0dDbEd4d3lE?=
 =?utf-8?B?Tkp4emFVUmd6dWlsRDhGSldWVzRrTW4vMW9zMmtGZGtpSE5TZi9GdW9XV0d6?=
 =?utf-8?B?aUVzR1ZZMTgvTTI5cHByWHE1bFBMdW9tRS9vQk81cGpkZUVEdmRybVFwK1RM?=
 =?utf-8?B?ZWtSa3VqZWl0eFFuN1dIV21jdHNMZEhudHZwQ0tvK0RMVHIzRTQxTHhPQnY5?=
 =?utf-8?B?ejZ5bmlrNGxMOURWQlVXeGExSCs0aVRXSi9uYm56MjArTjQ2T21maC9sYndI?=
 =?utf-8?B?cnZNd2ZORTQwR3hmeklMdy9wVkVOVkF1TkN4bUM4S0ROeWcvVE5oY2FNc0tH?=
 =?utf-8?B?QnpWaHdHQklBcnpPTVpSVldoZ0FyaHMxa3lCR0xJUHp3Q0N4dUxJWUlqTEhk?=
 =?utf-8?B?YjQzUWJwSGU0YVZYODFBcytWR3cvb1YyUExUck1QbXNlWEpJVTdvR09JODZG?=
 =?utf-8?B?OFdGOUp6NnVRZEE4UFpTdU9aVXMxWEw1bnpLSkh4dmZaQ1NNQXVYK01BRWI3?=
 =?utf-8?B?MCtKQStBSVJxZXZBUzY1MkR3R3lkMVp0ZkRuZDFRVTVGbERibEtSb2RSK3ZP?=
 =?utf-8?B?SlhoZVQya3Y3djk4R0VDMktVTWpieGNianpNU0VVK2tPRFdkN2htYVBQUVk0?=
 =?utf-8?B?TVRZSW1PeHJUa0FQMCt2anVlZHpxTDUvV0tuVVZsNHlFUzlKSjhkenc1Wnph?=
 =?utf-8?B?N3lWNmlTRDdMNTZ3UFo3Z2V0RHJHaTQ2WTBucjlvYnZqWFJvckh4RVRkQUNJ?=
 =?utf-8?B?dDVlNlhCaVZXb0w3cXE4ajA2L0Y5ZUpvcGZkL1FjQmhrWTAxdHg5enl0b1Nv?=
 =?utf-8?B?R3V2ZXdQUUkzZEdzTmJiem1aYlFlMUc5bVFWT1hhL2Q5U2VEU1VCcnF4UEJI?=
 =?utf-8?B?ZlJMemh2U1A5a1VlUnEvbnVrUUxQMnJhVXYwQ01Hci9JVW02RThWa3hjdGU2?=
 =?utf-8?B?QVoyOUVRd1l2NWJqNGRKdjVTV1lBRm1WTzV0YU5kNHk4WER6Sm1VTWN2aVda?=
 =?utf-8?B?VE0zdFZpVXR5NTVHRmtQMnRhRFkyV1dvQXNKRTFsSUVOYXdHaUIxRnQzYWFG?=
 =?utf-8?B?REFiVnJIdFVoRXhvbCtvUHQ5Q2lhdFd5Y3BjLzIwaWo3Z1BUclU4UTk0aWpa?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	etpZ9OoQmZo8333nbatlN9GyomuN8YULECR/w+W7jHv4GDdXZjarn4lxbWLJIptNnp1XJuduL50Lkn9VkN6TG6VYEbFUTtOgMX/GfE0ID7HgXGLxQhrGCpPjZ7tuEAQPEGXt9SHxtx88Ly6sxB1Rcq24K6j5prMapQQhdRn+rwNwpsdM4rtm8H4waalymZtgyXehivr2ROBNT7ZoPLrq81TpmqnjzulsFAs/uXMd0ahQq5Nw2HpVR2fbrXHfowwZeY0zjleGMcWqzH1DKceWIxw/KmG9sGN6NTvjOVhvnhTBsxfiqo9s0u+TBZHlOyuWjQvVx1oEO7u4m0VkbxqRPOycUbDglJOafOxWX2aeVsZhvtuaoERuB0pvuVynx12hOigSaSxhl0C72wk6PetMOt8ZT4d4FP/vPyWiBhboLK/ZE1lRR/KPeoH419pV+cr6iempb9bVgri/lbCZP1LoBDBbsUjkWbr/hiBLtS8PzZz05CoID00gsYSn2vbNm54ufSLI5/kJuS1F/DlhqcjQkD7p3AoY76gchzw0+VbJbgVXc9sP5L1SvbLdC2CoX38F4/V4pSSm57YuyCgFOU8u8PEX6hje6bKHsSTJC4OywWU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f364c5-1c61-49b4-7b3e-08dd40732f39
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 14:42:41.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpLKh1b3nLINW6ouL8bc/+5FdQFfadZXYgAjzpFDECdzKmYe+2kCA6OvisJGDKDMj1nrryAfrXo/U6D8O+plWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290118
X-Proofpoint-ORIG-GUID: ylq-J4SQk3yuNxuxDhWYYRiXpgCtz3yV
X-Proofpoint-GUID: ylq-J4SQk3yuNxuxDhWYYRiXpgCtz3yV

On 1/29/25 9:39 AM, Jeff Layton wrote:
> On Wed, 2025-01-29 at 09:22 -0500, Chuck Lever wrote:
>> On 1/29/25 8:39 AM, Jeff Layton wrote:
>>> While looking over the CB_SEQUENCE error handling, I discovered that
>>> callbacks don't hold a reference to a session, and the
>>> clp->cl_cb_session could easily change between request and response.
>>> If that happens at an inopportune time, there could be UAFs or weird
>>> slot/sequence handling problems.
>>>
>>> This series changes the nfsd4_session to be RCU-freed, and then adds a
>>> new method of session refcounting that is compatible with the old.
>>> nfsd4_callback RPCs will now hold a lightweight reference to the session
>>> in addition to the slot. Then, all of the callback handling is switched
>>> to use that session instead of dereferencing clp->cb_cb_session.
>>> I've also reworked the error handling in nfsd4_cb_sequence_done()
>>> based on review comments, and lifted the v4.0 handing out of that
>>> function.
>>>
>>> This passes pynfs, nfstests, and fstests for me, but I'm not sure how
>>> much any of that stresses the backchannel's error handling.
>>>
>>> These should probably go in via Chuck's tree, but the last patch touches
>>> some NFS cnd sunrpc client code, so it'd be good to have R-b's or A-b's
>>> from Trond and/or Anna on that one.
>>
>> A few initial reactions as I get to know this new revision.
>>
>> - I have no objection to 7/7, but it does seem a bit out of place in
>>     this series. Maybe hold it back and send it separately after this
>>     series goes in?
>>
>> - The fact that the session can be replaced while a callback operation
>>     is pending suggests that, IIUC, decode_cb_sequence() sanity checking
>>     will fail in such cases, and it's not because of a bug in the client's
>>     callback server. Or maybe I'm overthinking it - that is exactly what
>>     you are trying to prevent?
>>
> 
> That's the best-case scenario, but callbacks can run at any time. If
> this happens at the wrong time this could crash or cause more subtle
> problems than just a spurious ESERVERFAULT. IOW, we could pass
> decode_cb_sequence(), then the pointer changes and then
> nfsd4_cb_sequence_done() ends up working with a different session.
> 
>> - In 1/7, the kdoc comment for "get" should enumerate the return values
>>     and their meanings.
>>
> 
> Ack
> 
>> - cb_session_changed => nfsd4_cb_session_changed.
>>
> 
> Ack
> 
>> - I'm still not convinced it's wise to bump the slot number in the
>>     ESERVERFAULT case.
>>
> 
> It's debatable for sure. The client _did_ respond with NFS4_OK in this
> case, but it is a bit sketchy since something else didn't match. I'm
> fine with removing that seq bump if you prefer.

I'd remove it: if the session/slot/seq number don't match, the NFS4_OK
is pretty meaningless.

Flag a session fault, and requeue the RPC.


>> - IMO the cb_sequence_done rework should rename "need_restart" to
>>     "need_requeue" or just "requeue" -- there is a call to
>>     rpc_restart_call_prepare() here that is a little confusing and
>>     could do with some disambiguation.
>>
> 
> Good point. I'll change that too.
> 
> Thanks for the review!
> 
>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> Changes in v2:
>>> - make nfsd4_session be RCU-freed
>>> - change code to keep reference to session over callback RPCs
>>> - rework error handling in nfsd4_cb_sequence_done()
>>> - move NFSv4.0 handling out of nfsd4_cb_sequence_done()
>>> - Link to v1: https://lore.kernel.org/r/20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org
>>>
>>> ---
>>> Jeff Layton (7):
>>>         nfsd: add routines to get/put session references for callbacks
>>>         nfsd: make clp->cl_cb_session be an RCU managed pointer
>>>         nfsd: add a cb_ses pointer to nfsd4_callback and use it instead of clp->cb_cb_session
>>>         nfsd: overhaul CB_SEQUENCE error handling
>>>         nfsd: remove unneeded forward declaration of nfsd4_mark_cb_fault()
>>>         nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
>>>         sunrpc: make rpc_restart_call() and rpc_restart_call_prepare() void return
>>>
>>>    fs/nfs/nfs4proc.c           |  12 ++-
>>>    fs/nfsd/nfs4callback.c      | 212 ++++++++++++++++++++++++++++++++------------
>>>    fs/nfsd/nfs4state.c         |  43 ++++++++-
>>>    fs/nfsd/state.h             |   6 +-
>>>    fs/nfsd/trace.h             |   6 +-
>>>    include/linux/sunrpc/clnt.h |   4 +-
>>>    net/sunrpc/clnt.c           |   7 +-
>>>    7 files changed, 210 insertions(+), 80 deletions(-)
>>> ---
>>> base-commit: a05af3c6103b703d1d38d8180b3ebbe0a03c2f07
>>> change-id: 20250123-nfsd-6-14-b0797e385dc0
>>>
>>> Best regards,
>>
>>
> 


-- 
Chuck Lever

