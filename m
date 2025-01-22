Return-Path: <linux-nfs+bounces-9504-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2506A19A79
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 22:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87605188DB6C
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 21:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9801C5D53;
	Wed, 22 Jan 2025 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XmjaGN48";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rx24PVMG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334831C5F33
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737582078; cv=fail; b=Ws6Gg7Oee0qS9mJHD11JqWGP8VFdC8ePNXNl5s8TATNY+Z87VCDYM3V0k+TWc4Zl+OFHbaFjjrAlQhBFe5hE09aX9LtjH7geSSh8fQPK7mbrae/X49lz0vp+ixRDVwyBHW+EezdJm/M565cRHA2f5eFPh45qhi9lACAtDtpn4qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737582078; c=relaxed/simple;
	bh=FW15gow/qTUU5WSpH63/INLsCRQTkD6Sjrz0EVvjyjw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NE1vaDh0TkJL73DOMeHfa4i3RbFKKgHthipzLCzJBeOzYR1uM+vKGVz2z5blTn76aZOe8RJboJulcwIrZ6qZzoeK5wTjibMbyezjmG2Gt6v8RbH+VjobPcytPxUwnAXuHe0g2/I/YdXUVuxxfClf+VHaAibH+yjcU2dhVmWhwpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XmjaGN48; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rx24PVMG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MLdmeG017237;
	Wed, 22 Jan 2025 21:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dMAdGB8qlDI3I/u/FXDbhNdV2BhpQrwvdXYrXMzC8S4=; b=
	XmjaGN48PYIGchehYzK+fQpzufalwlzYS4v4YW7FFnyuoUEMskiNv/6mqoCJZ8Mb
	pc7HwW8etvOeiFqJzgblQueH2+kWEg7dhC9mYBTnzt4Xnfja4l501yAMDqfXBny3
	8oCfeYAb/LxAfZnj/EUU13q1b5HTqqDygS/u/3KmfU5uejAbIlrapaLBBBy821Jo
	31cMPTeHj/p9rMvOz/i/xda8BvshwppNkdgGEptfEYZdcVDtdaS57oUPd+7violj
	QVbZoOa1hWMtPj5GNVK2fXSerU4IuyvQG2BoIBi90wNhnQ3dwAUi5akmPmoYZS8c
	9+tFTXhXcC6bOhmiFyVx5Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nsgky1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 21:41:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MKNGM1038202;
	Wed, 22 Jan 2025 21:41:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4491a1vq6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 21:41:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7FYv8O6bRs8LhbOO5ROmTGpM3jDLWs3EA89CJGgqdpynyq9Jw6Ygkqe8Wzwhw1QsfkMYKW42kFP7wvycXv/R/S5xL6CDTT6jk3xKTjNpbhkc8WxxHah7FrUOL0O1eozgZIsTu2ZiPLlEJjayYnXQGS6EZeC0T9Vud849hyIqIKrQ8eChClYO+PZci8PaUqmNPWuGR2BK/bqA2bm8ms8Uq+GbJbB45e0W/ypvexH1oUaLiDqk76Z9oQyWC/WAaplhU+NfgfRQWES27BcmFNE6kbrzkOXZnWEztP7UXJecWNstoi6r0lzazFgHWv039x2pwD1mjUyQcKcJa/7wWzJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMAdGB8qlDI3I/u/FXDbhNdV2BhpQrwvdXYrXMzC8S4=;
 b=CVQJdxBJGvQmtXSsB8rYrHfuVr8kaz5PL78pMUieAaubNVKjtlHuTkU2KX3Ry4SQNZfVALxttSpCa/Uj43+G3RuUXb3gSJDg9h1/kEd4c0xJ9eMYXRyWmo54CC6MQF+lRq7XyKhqVXXns0NhBhmlnVH72x1+tsE3KUxvVoDbPoVDdvOJtuRqbEecytRyKCQHGtomtdXBR0NfJeARtYP6z9+1Ta6bzMLV8XBVGdg88fEpxd+b+Js6fEfwMOESLYjuqT4wIvRT88Y0T5s8SRSqFPMC3157KRX/8iI0C074nACCrXOBHkhgQqDhYpSmIPNWAiX9IX1IPGIgB2SsfS5sUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMAdGB8qlDI3I/u/FXDbhNdV2BhpQrwvdXYrXMzC8S4=;
 b=rx24PVMGHBZ13jdLURvfpF9np2vT2u0vlQu2s6r46ux3T5kjLzJFz59X4/nG5Aq5qMaUfLUktKIqGVzdYZhFdc78kJBqUHiV1x9zQOCLqu4VWR2D/+87HQ1Pit67UF4n5dx8UUbK79WcIZkAvWm0XVcgQsPxccrbOOhfZMqABXw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB6794.namprd10.prod.outlook.com (2603:10b6:208:43a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 21:41:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 21:41:02 +0000
Message-ID: <e24e9a9d-1416-460b-ad22-b15f9e9e5e6d@oracle.com>
Date: Wed, 22 Jan 2025 16:41:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nfsd: filecache: move globals nfsd_file_lru and
 nfsd_file_shrinker to be per-net
To: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
References: <20250122035615.2893754-1-neilb@suse.de>
 <20250122035615.2893754-3-neilb@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250122035615.2893754-3-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ded0174-58e2-43e9-8ece-08dd3b2d779f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REZIYWx5b2NCV0tVVjMxTWI3SEFEd2FXTGZKQkFoY0hRYnNWamhaUmxrZTdw?=
 =?utf-8?B?eFFXNDR4NjNUQVQ2dDlOVkQwanNqNlZGaHdPa2xUSXpxUlRGM1F2WFZRQm91?=
 =?utf-8?B?NDk0V1I0eXE4S21qQ240TkRSaGtCTnhXQ1BPajhvMHVnbzh1V3hUK0NVNC81?=
 =?utf-8?B?Y2Y5ZjV2RWZaVXlzTjA4STB0bktxUEJ2VjRaamkzTy84cjh4aW1QYW9tUFc2?=
 =?utf-8?B?dmlCQzFIMDBZUnBzUmtNUHdTTzBoeHhGTHdsMlhGSGRGT1p0SEg4aGFpdDVi?=
 =?utf-8?B?Wnp6d1Fjd3pRZENlMVNkbzkxa3NJd0luQndGSTR5K3B3T2t6RFNERWJaM3VZ?=
 =?utf-8?B?RVlIYkRIdWV2YlFMR1lPYnRwUW5lejQrWHI0cE5XNjY4cm9hcXBpMWF0bnBV?=
 =?utf-8?B?WDV6NXl1ckt4NnU5aDF4T2ZOd1hRQzcvODU5MlZnUTQ1enNYeDN2OERWd0Fu?=
 =?utf-8?B?ZFNWc1hDaWsvdFdsUno5RGxlV1lQV21XdnpoVVU5ajI1em5zZm1qQlM0Qjdm?=
 =?utf-8?B?RFlKSjl3Q2J2bGtJRkdoUy9aeG1uUUVSOGhmQmNvUktFWUsvU3pxUW1IbFhJ?=
 =?utf-8?B?bFI4R1h5MEFuR1JMNmpDTmsrR0IrVENBYlNrbWRoVUxPeGJXWUN6OGRrMytT?=
 =?utf-8?B?NG03UGlmRERJYzVoRnNvNnZnOFZPaDI5enZWcGpVRnMzVWVEd25KRmlYbDBC?=
 =?utf-8?B?QzZOZzRFM3k2NmRRQmp1UHJSK2xFeStQSzhjYTRYbjU2d0FPcHEwZGtGTjhz?=
 =?utf-8?B?VFY3b2VWR3FydnhKNUFiYjRuMW8ydGEzVGVFT3NiTVA0VDA0UDRpNEZDVS9j?=
 =?utf-8?B?djc0L1VvdXdYSlUwMkxTek9OSnNiYVNNWjZzK2dDeFRwancyRWxNRUtCcHdq?=
 =?utf-8?B?SjhEUFJoYzBIbkRySXpCeGRSU01TT3cwZUwvdjJrR3NmL0NsL3l4M0RPd2E3?=
 =?utf-8?B?emdTcVFGeFFNN3I1Z2Fvc1dUbUhCNlp6dmpTY2NLNm9sY3V1cnMvbW82TnEw?=
 =?utf-8?B?RFJZaW9XVm1FYng3ZVRCR213R1NSN3lwSjlidWhSUnl0Tmk5VHVPemRYNFhK?=
 =?utf-8?B?bUxsbk8zV1lvLys2TFFmSURFMVhGeC8rVHEyYzBEV0VsVVVxWE1PaGttK3pK?=
 =?utf-8?B?TTFGejFsSlh1em1ZNGJTTFVESHcrUHhMU0ErQjczY05rcVh4TE0wMnR5VHhJ?=
 =?utf-8?B?LzdrSzFIUDdVeVF6bm5RRXRyZmE0RC9RelNvU2J6ZHlsTFFJeFhGZVJVVU45?=
 =?utf-8?B?dXF3cFh0TldwQUVLei90bVdDcnp4dXVrWWFhcGxQTzVtQjlGUnFhLy8wVkUx?=
 =?utf-8?B?bytHOHBEcno0bzJ6M3FWdTNoYUZEc3l3eS96dlhHQ1hVT2ZRU01XU3BTUlRU?=
 =?utf-8?B?Unljdk5ONmU4ZHlIY1dRV0xOZGhzUXhxV1p4cGhBYVdIYUh0Y3NMU1JKVi9T?=
 =?utf-8?B?WlJkazFhblBKem1OMmI3TTAzTUloWjFWSnZmMlRnNlJ0bGd0ZER0NHEzVGNn?=
 =?utf-8?B?QnJBN0JkcEQ1dmVjaEdYUEMyOXJBN1AxL3pSYXptUWRlN3piL21rZ1NQRnpF?=
 =?utf-8?B?QVpNYTRCTEFyZzloNnlnNzYrSTBPOXVZZEloQ1RZSmMwZTV1eWpnVFB4YStX?=
 =?utf-8?B?Y3VYSW1CeW9CcVhWWWZRSHZmdmZlakxOV3IwMzJkeFZqeVJyWGhNNWhZTS9w?=
 =?utf-8?B?N2pMYVluZlF6Q2IvekVzdUlRQ21HOGR5WFdrQzFuRXZ3eUtxYzhFd0VleEZL?=
 =?utf-8?B?Z09SWDk1M2JHWVdqdnQ0c09XbUFsVmtKaG5JU0kvYjJmdmxNQ000cFVvYkgz?=
 =?utf-8?B?UFJqaURBb1BCc0YxcnVZV0lHcmFyUms1L3pLZmRUMGZsVFlpdjNJZjRoNmdt?=
 =?utf-8?Q?SQs6c1IicrTR5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2NIL0tkNGhRNkhQQnRVbjBBTW5nWXdjdGFVVWlFWEZaRU9qTy9Nc1B5UjA3?=
 =?utf-8?B?bTZYd3ZBQXVNMmlweEIrQTdYTmZlZUkwbnNGWUdDb2toT0JBK2FhT0l2a091?=
 =?utf-8?B?R3FlVnlCOHRGd0RRSnZORGFPeEhzWWFVeGxkZ0hWSld6K05Qam41K290bU5L?=
 =?utf-8?B?TWVrUHBwMDVaZFd5ZndMWGs2ZW94Zk9MaTQzdkJWRmlMSVFOVHEwVmhJZ2ls?=
 =?utf-8?B?OTJ3dkxCbi9waElZNm8yck96M0xNOE43cmg5S3d4ekZoTXRSaHduaVBxWHJF?=
 =?utf-8?B?cXpMMmhucEhCYW1CUzNVQ3JGalp5R01PTElLemdxY1dJNFhDclRGc25WY21v?=
 =?utf-8?B?VFpyL0hLbkx5ZEJlMkVoRTByVmV4NVdTNnMrbWJvenFsZk05VS8wUHJja2tS?=
 =?utf-8?B?OCtlMGtOWmxRN1pjNHBNUkpnRTVON05TWWlvL0JNUG9KU2diVk0reHZvMjF1?=
 =?utf-8?B?TXpYNlBOdkJpU2doTk5VOHgrQ3hsaW1JWDNzbm9PU2kwSnk5RCtaellVcmI1?=
 =?utf-8?B?b3V3b1cxd2JHb21QTjRnaCtlQ2NMcGNNcG5QNjZlRFBzT2JTYm1YdTBFUHBB?=
 =?utf-8?B?S1U5dWk5ZzhyNm12SXBWOVFOempmSC9NbE1SMXZoZFpPUzVzS0pNTHFoMTE5?=
 =?utf-8?B?UFFlaUZkTVFFZzhpWGF6M1d6OU9mK201YU0wMXdWT1R5L1NQbU5kZzRLd2Jn?=
 =?utf-8?B?V05jMERhdVFWd2tza0VJQ1dSbFdYUlNzZHI2QUlFZDFXNTFObDNsTTFUb09U?=
 =?utf-8?B?dEZ5cE9SMk1zU3lxQVMyaUYwWUFlOUJOa2svUTR4UmpwNnJkWEMvbjFUQk5a?=
 =?utf-8?B?NmNKblRUY3QwMFFuWGUrZXNhZUMrWThyaHllRm5KM3dDVVJDZmJjUmlQNmpJ?=
 =?utf-8?B?N1JuUlB5N3REa01xVTBXZDJhVk5lUStqUWU4MUJFeUxBT0liWmQrN0d5Smsx?=
 =?utf-8?B?SzNDK3NaMkdRemhSSU96MUtTa1NIeVhJNTh1aHlYU29HZWs1UVQrRFhhRFc3?=
 =?utf-8?B?SGtnTHlDR3pMQjFqVncwMVZqSVdxRS9SMC94TVQwUFk4RnpWektnaXFpUXRz?=
 =?utf-8?B?b1hJOUNEOVE0MjVtSXlzSFR6TWlsWjl5YldGRGpIdDNUbWZqT1VGeDBuU1Z0?=
 =?utf-8?B?TndFWVBhWVJpa1h4L0RmUUJ6aENxbXJIVnF1eVo3S2t6MDg2YlRtSzZodkRF?=
 =?utf-8?B?UDJQaTMrQXNlTU1ONTltd1pKUWtRRGVCRElFbXNJN2tpZ2xwK0daMlBVOVh3?=
 =?utf-8?B?VExqWWJBVERzV0lZSklxY1J6RHRPR3NiaFM2NGMwbE9DZTF1NFo0Mk9ucVU0?=
 =?utf-8?B?YTcvamErTWhTRlJHUHZ2OUgySTJJR1hFNTBUTE83NDJHdkI1bUZQNkJDZ050?=
 =?utf-8?B?MmJUczE0SHFBK3Z0SUJTMEpoVHlRcmhBM1VJYlI2YTNFSUxrSFg2Mm50bVZW?=
 =?utf-8?B?NjBqNnRlK1pFV0NiSlpmVWZFcG9wU3FuS1FrYSs0YStTeVVKWVBHOHBKdDNm?=
 =?utf-8?B?ZDFmMlZBeHo2Q3VQMFNUWTlCeG4wSnJXWGVtUHF3MXEySzMxR29jbFNaR3FC?=
 =?utf-8?B?QVhFLzQvdGVFK01ub2dTQVk1QkpSU05helY2NXkxeTNIQ2FKTWNnZ3prU1ZD?=
 =?utf-8?B?Z0l6dk1NU0RqRWdjRVBhNmFoQ01BT3BFYjVTL2pyUjMySERIck5jalZhb1Y4?=
 =?utf-8?B?am9VVjk4N2MxTUNrY2dFbENTWkJ6Vit2bXArWHZxbkpHcTJWTXFmRmVPMVNS?=
 =?utf-8?B?NUlHNDBmajg4K0xsYkMvQWxVWXVNejRDQmhtcllQMnQ0VkZVNnorUFQrd1VH?=
 =?utf-8?B?bUtmeGRHcDhiQ29vOU1laks1cVZxSjhoRFYxTDJNQUYwSVE4c1FENStnVjNN?=
 =?utf-8?B?WVYxVWxrMkdTYVZMUU53UFMya2IxbXlhT3BNWjZYbWp0bTlCWFVFUGhlUndM?=
 =?utf-8?B?MTZoMytlZENBVVJ1SzdqTjM2T3kvdmlVOTBrM2hXSW9BZnZLazJubzIyNi9H?=
 =?utf-8?B?MFJhako1cEZSTnBYTDBZTWdXRkJDaDlacm9VYTF5YllxdzdMVmhxQmMrNFZr?=
 =?utf-8?B?NDNqWVpLdFUrbTlOY2lPckhDa29uVVVFSTRCbjdDelFYdTBvSjZuRGxKaE5n?=
 =?utf-8?B?dUg0KzVkVko1WmwxK2FacHBTdFo4dFJGRzlieWRNMkhsUkh6NWppL0ZHZE5s?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8nO09nBQU4LZPHCZK2QipjBIV+0Ny+npOZXTJkepY1hsneg0YDPHwC4B2SjRjGsCpv22+UjumFWecnMFCJRj6I5yGTR9eUTAiY1AD97Q9YT83dgTbu4/DKpe/6d5ZXemrznGcPNLNCUKi3P/22uqLUf8ZV3uASb7Z6A94POzMZ9xRw7wP9J3BpQ616c1c3+fmbT8YJfg7ZuXkjwh+56kwH2w6eK9K7H+O6rN1M+zYXXxf2uAN3fTHxH1DtKdBVCY0lHFDtkbWVB42Llne77qR3rOESs8g709Ce01Krcv7KkBQcGRr5DakgmJoHRij7D+GetbMkT3Q8u+/a55QJM10nqUr9TnJovJZ8/Kbnh9BhAyOnyGeILEcyYoN++lgtY8uzhrlKQZgd6ErMITFaPxQPRyXewExOrcEkMyyHUMvH6NYiiD0L5PrSzG4T2gM89mZnjHopoEFxCHQKWpnewuB8z6Rco6AJw0dLJsMthmidCbu2rZWWt2n3BAyJmtSJfKh/cPM9OOBq9Hbt5sTnKltaNpgEgHrXDUBM8gHgwtOaJlmb6RdTwYjaCfnKc3EhZJH4/Mn2Sy/7u9BCtu/VH09RZESqfZIZYtOSjLjeWYwlg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ded0174-58e2-43e9-8ece-08dd3b2d779f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 21:41:02.4134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTXsJoxxTFR7Lvu3R8onOB69I4B3UsB4OdWcT2tumKtV9G0BsSf7rBCoN5K8ZlH0fd+f3wmL3zTM65gTgfCdSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_09,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501220156
X-Proofpoint-GUID: hxTQ49mV417FDHnfeILHeEDjNKvneQxu
X-Proofpoint-ORIG-GUID: hxTQ49mV417FDHnfeILHeEDjNKvneQxu

On 1/21/25 10:54 PM, NeilBrown wrote:
> The final freeing of nfsd files is done by per-net nfsd threads (which
> call nfsd_file_net_dispose()) so it makes some sense to make more of the
> freeing infrastructure to be per-net - in struct nfsd_fcache_disposal.
> 
> This is a step towards replacing the list_lru with simple lists which
> each share the per-net lock in nfsd_fcache_disposal and will require
> less list walking.
> 
> As the net is always shutdown before there is any chance that the rest
> of the filecache is shut down we can removed the tests on
> NFSD_FILE_CACHE_UP.
> 
> For the filecache stats file, which assumes a global lru, we keep a
> separate counter which includes all files in all netns lrus.

Hey Neil -

One of the issues with the current code is that the contention for
the LRU lock has been effectively buried. It would be nice to have a
way to expose that contention in the new code.

Can this patch or this series add some lock class infrastructure to
help account for the time spent contending for these dynamically
allocated spin locks?


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   fs/nfsd/filecache.c | 125 ++++++++++++++++++++++++--------------------
>   1 file changed, 68 insertions(+), 57 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index d8f98e847dc0..4f39f6632b35 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -63,17 +63,19 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
>   
>   struct nfsd_fcache_disposal {
>   	spinlock_t lock;
> +	struct list_lru file_lru;
>   	struct list_head freeme;
> +	struct delayed_work filecache_laundrette;
> +	struct shrinker *file_shrinker;
>   };
>   
>   static struct kmem_cache		*nfsd_file_slab;
>   static struct kmem_cache		*nfsd_file_mark_slab;
> -static struct list_lru			nfsd_file_lru;
>   static unsigned long			nfsd_file_flags;
>   static struct fsnotify_group		*nfsd_file_fsnotify_group;
> -static struct delayed_work		nfsd_filecache_laundrette;
>   static struct rhltable			nfsd_file_rhltable
>   						____cacheline_aligned_in_smp;
> +static atomic_long_t			nfsd_lru_total = ATOMIC_LONG_INIT(0);
>   
>   static bool
>   nfsd_match_cred(const struct cred *c1, const struct cred *c2)
> @@ -109,11 +111,18 @@ static const struct rhashtable_params nfsd_file_rhash_params = {
>   };
>   
>   static void
> -nfsd_file_schedule_laundrette(void)
> +nfsd_file_schedule_laundrette(struct nfsd_fcache_disposal *l)
>   {
> -	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
> -		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
> -				   NFSD_LAUNDRETTE_DELAY);
> +	queue_delayed_work(system_unbound_wq, &l->filecache_laundrette,
> +			   NFSD_LAUNDRETTE_DELAY);
> +}
> +
> +static void
> +nfsd_file_schedule_laundrette_net(struct net *net)
> +{
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +
> +	nfsd_file_schedule_laundrette(nn->fcache_disposal);
>   }
>   
>   static void
> @@ -318,11 +327,14 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
>   		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>   }
>   
> -
>   static bool nfsd_file_lru_add(struct nfsd_file *nf)
>   {
> +	struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
> +	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
> +
>   	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
> +	if (list_lru_add_obj(&l->file_lru, &nf->nf_lru)) {
> +		atomic_long_inc(&nfsd_lru_total);
>   		trace_nfsd_file_lru_add(nf);
>   		return true;
>   	}
> @@ -331,7 +343,11 @@ static bool nfsd_file_lru_add(struct nfsd_file *nf)
>   
>   static bool nfsd_file_lru_remove(struct nfsd_file *nf)
>   {
> -	if (list_lru_del_obj(&nfsd_file_lru, &nf->nf_lru)) {
> +	struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
> +	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
> +
> +	if (list_lru_del_obj(&l->file_lru, &nf->nf_lru)) {
> +		atomic_long_dec(&nfsd_lru_total);
>   		trace_nfsd_file_lru_del(nf);
>   		return true;
>   	}
> @@ -373,7 +389,7 @@ nfsd_file_put(struct nfsd_file *nf)
>   		if (nfsd_file_lru_add(nf)) {
>   			/* If it's still hashed, we're done */
>   			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -				nfsd_file_schedule_laundrette();
> +				nfsd_file_schedule_laundrette_net(nf->nf_net);
>   				return;
>   			}
>   
> @@ -539,18 +555,18 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
>   }
>   
>   static void
> -nfsd_file_gc(void)
> +nfsd_file_gc(struct nfsd_fcache_disposal *l)
>   {
> -	unsigned long remaining = list_lru_count(&nfsd_file_lru);
> +	unsigned long remaining = list_lru_count(&l->file_lru);
>   	LIST_HEAD(dispose);
>   	unsigned long ret;
>   
>   	while (remaining > 0) {
>   		unsigned long num_to_scan = min(remaining, NFSD_FILE_GC_BATCH);
>   
> -		ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> +		ret = list_lru_walk(&l->file_lru, nfsd_file_lru_cb,
>   				    &dispose, num_to_scan);
> -		trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> +		trace_nfsd_file_gc_removed(ret, list_lru_count(&l->file_lru));
>   		nfsd_file_dispose_list_delayed(&dispose);
>   		remaining -= num_to_scan;
>   	}
> @@ -559,32 +575,36 @@ nfsd_file_gc(void)
>   static void
>   nfsd_file_gc_worker(struct work_struct *work)
>   {
> -	nfsd_file_gc();
> -	if (list_lru_count(&nfsd_file_lru))
> -		nfsd_file_schedule_laundrette();
> +	struct nfsd_fcache_disposal *l = container_of(
> +		work, struct nfsd_fcache_disposal, filecache_laundrette.work);
> +	nfsd_file_gc(l);
> +	if (list_lru_count(&l->file_lru))
> +		nfsd_file_schedule_laundrette(l);
>   }
>   
>   static unsigned long
>   nfsd_file_lru_count(struct shrinker *s, struct shrink_control *sc)
>   {
> -	return list_lru_count(&nfsd_file_lru);
> +	struct nfsd_fcache_disposal *l = s->private_data;
> +
> +	return list_lru_count(&l->file_lru);
>   }
>   
>   static unsigned long
>   nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
>   {
> +	struct nfsd_fcache_disposal *l = s->private_data;
> +
>   	LIST_HEAD(dispose);
>   	unsigned long ret;
>   
> -	ret = list_lru_shrink_walk(&nfsd_file_lru, sc,
> +	ret = list_lru_shrink_walk(&l->file_lru, sc,
>   				   nfsd_file_lru_cb, &dispose);
> -	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
> +	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&l->file_lru));
>   	nfsd_file_dispose_list_delayed(&dispose);
>   	return ret;
>   }
>   
> -static struct shrinker *nfsd_file_shrinker;
> -
>   /**
>    * nfsd_file_cond_queue - conditionally unhash and queue a nfsd_file
>    * @nf: nfsd_file to attempt to queue
> @@ -764,29 +784,10 @@ nfsd_file_cache_init(void)
>   		goto out_err;
>   	}
>   
> -	ret = list_lru_init(&nfsd_file_lru);
> -	if (ret) {
> -		pr_err("nfsd: failed to init nfsd_file_lru: %d\n", ret);
> -		goto out_err;
> -	}
> -
> -	nfsd_file_shrinker = shrinker_alloc(0, "nfsd-filecache");
> -	if (!nfsd_file_shrinker) {
> -		ret = -ENOMEM;
> -		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
> -		goto out_lru;
> -	}
> -
> -	nfsd_file_shrinker->count_objects = nfsd_file_lru_count;
> -	nfsd_file_shrinker->scan_objects = nfsd_file_lru_scan;
> -	nfsd_file_shrinker->seeks = 1;
> -
> -	shrinker_register(nfsd_file_shrinker);
> -
>   	ret = lease_register_notifier(&nfsd_file_lease_notifier);
>   	if (ret) {
>   		pr_err("nfsd: unable to register lease notifier: %d\n", ret);
> -		goto out_shrinker;
> +		goto out_err;
>   	}
>   
>   	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops,
> @@ -799,17 +800,12 @@ nfsd_file_cache_init(void)
>   		goto out_notifier;
>   	}
>   
> -	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_gc_worker);
>   out:
>   	if (ret)
>   		clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags);
>   	return ret;
>   out_notifier:
>   	lease_unregister_notifier(&nfsd_file_lease_notifier);
> -out_shrinker:
> -	shrinker_free(nfsd_file_shrinker);
> -out_lru:
> -	list_lru_destroy(&nfsd_file_lru);
>   out_err:
>   	kmem_cache_destroy(nfsd_file_slab);
>   	nfsd_file_slab = NULL;
> @@ -861,13 +857,36 @@ nfsd_alloc_fcache_disposal(void)
>   	if (!l)
>   		return NULL;
>   	spin_lock_init(&l->lock);
> +	INIT_DELAYED_WORK(&l->filecache_laundrette, nfsd_file_gc_worker);
>   	INIT_LIST_HEAD(&l->freeme);
> +	l->file_shrinker = shrinker_alloc(0, "nfsd-filecache");
> +	if (!l->file_shrinker) {
> +		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
> +		kfree(l);
> +		return NULL;
> +	}
> +	l->file_shrinker->count_objects = nfsd_file_lru_count;
> +	l->file_shrinker->scan_objects = nfsd_file_lru_scan;
> +	l->file_shrinker->seeks = 1;
> +	l->file_shrinker->private_data = l;
> +
> +	if (list_lru_init(&l->file_lru)) {
> +		pr_err("nfsd: failed to init nfsd_file_lru\n");
> +		shrinker_free(l->file_shrinker);
> +		kfree(l);
> +		return NULL;
> +	}
> +
> +	shrinker_register(l->file_shrinker);
>   	return l;
>   }
>   
>   static void
>   nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
>   {
> +	cancel_delayed_work_sync(&l->filecache_laundrette);
> +	shrinker_free(l->file_shrinker);
> +	list_lru_destroy(&l->file_lru);
>   	nfsd_file_dispose_list(&l->freeme);
>   	kfree(l);
>   }
> @@ -899,8 +918,7 @@ void
>   nfsd_file_cache_purge(struct net *net)
>   {
>   	lockdep_assert_held(&nfsd_mutex);
> -	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) == 1)
> -		__nfsd_file_cache_purge(net);
> +	__nfsd_file_cache_purge(net);
>   }
>   
>   void
> @@ -920,14 +938,7 @@ nfsd_file_cache_shutdown(void)
>   		return;
>   
>   	lease_unregister_notifier(&nfsd_file_lease_notifier);
> -	shrinker_free(nfsd_file_shrinker);
> -	/*
> -	 * make sure all callers of nfsd_file_lru_cb are done before
> -	 * calling nfsd_file_cache_purge
> -	 */
> -	cancel_delayed_work_sync(&nfsd_filecache_laundrette);
>   	__nfsd_file_cache_purge(NULL);
> -	list_lru_destroy(&nfsd_file_lru);
>   	rcu_barrier();
>   	fsnotify_put_group(nfsd_file_fsnotify_group);
>   	nfsd_file_fsnotify_group = NULL;
> @@ -1298,7 +1309,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
>   		struct bucket_table *tbl;
>   		struct rhashtable *ht;
>   
> -		lru = list_lru_count(&nfsd_file_lru);
> +		lru = atomic_long_read(&nfsd_lru_total);
>   
>   		rcu_read_lock();
>   		ht = &nfsd_file_rhltable.ht;


-- 
Chuck Lever

