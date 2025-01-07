Return-Path: <linux-nfs+bounces-8943-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7614AA042AB
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 15:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB253A1224
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8C81E9B00;
	Tue,  7 Jan 2025 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mTIVLb61";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uSFd6igy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478E1F236F
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260522; cv=fail; b=ukm5ifWg4Ot56l0ntau8EP6xzI1utpocy9fRIWn7f2pzBcj8V8YVl0boJD3iF12Cv5Ai1YiIW+9AfPdi8auGOQKk0OMZH6QiWUw23W/hMMBW8um69LOHXJbw2HrsWQEP0QiY7fSw6Cd7tWIH4aV1I67kAt8uMAdnaIDzFDnKQyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260522; c=relaxed/simple;
	bh=r6kyISBYp2W9r52yWqdQdHjCD9QnEixtJeOHHpMzkuU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Og7RGsHCzijgy8Q4QVtuWiaPZk9pkV7rc+AQ52CkkO3ekHrlzyzkyrb9Rz0Gb0RyHDtsJucxCfIxwE37jImWWoE+kneaVSOTGmI9roofPVEJE4QKOi2QvuAsjYPROoMpxpwj4Zk77Cqqryw/W0JXcrk3UV3vvdvruvQik3eFbvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mTIVLb61; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uSFd6igy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507DmHME009861;
	Tue, 7 Jan 2025 14:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uC8l7vmx0lPfWXZuFtq5a9KooTaFDI0XA+ac2LE2j/U=; b=
	mTIVLb611LO58o1kfvRh+BMpG4scDo5bd0JsBjdRPfhxzI2dUc1knHfmuWE1G6s7
	LS+6dBvRg5Vn7RaKfnfLwMBPtzzjtPszjN7swYnYv8aAvjGPSqjhpG/yxMbKefYf
	T1vRZ8NT9hFfB1ezex+kQLoBjkewB5pD6bJpq4qv2JR5QQHLeYoTdDFI0ni0A4kN
	Y4Z15JRLvWPlQURixplzl47bhJ1PIN5IBjXSp+jT6IKly5xPIn1GFqsvIBJYj+70
	bi8+4vftdtNMwQ40Gwd4wH9tqGMtBZCZyAX+SzCX6MJodTJptjbCErUYOwnrCKdL
	NwSfp9T8bMegZKV8SguLwQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xvksvkkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 14:35:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 507DpiGQ025491;
	Tue, 7 Jan 2025 14:35:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue8t6px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 14:35:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVM67KGi2FLfS7t5yx0WmHvwMqMId1yiwPE9G1EJQ0pZFLgrIr+5gJE9HLP0xFq7UDpysMEVPwXD2CbUktI0Tp4ruA8mAnFz7BKH317j7n1xgKFWJ9K58XgL+pwq9PX71E0VmSUwTDqMblkBLAM7Te0ncOP9a9AfO2Y6s9+OJXtMGFUh9RH2ukcscpYrisPTN7Urf17Hz2zLWwsL/RMm5Fun7KdDNS44bcxUWSdIC3HwS0OMVMPAqYLoJAdFoGrVEhKGosuiPhe3WsZF1gQfwborvMbQbYxLuHNRHx2/v8d59qGQmXhCMUh5l7XNTzbfFJWqmhU5yOj/UMuLY9A0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uC8l7vmx0lPfWXZuFtq5a9KooTaFDI0XA+ac2LE2j/U=;
 b=fdWOzxPxd26uUUOqPrAhWnWLj7yNSWUZC6zlL+NLMT1hlDvvzkTIWlnXQan7sywZuXc7riNrNzAPNX3HT1Tmqnw2d7/lD2IbwcrBsNd+Py0evH/foarDJ3eUP458eLlMLnvmKunJRnVLru0KjqMpmxLbfS05CBdP8YgxDkTRLpgUXhy8ZTAzwwyhX1N5uyu+X8BpWGUS6KcmzKwpY52sbgd4CFQBn0FIHAQvM0Wesa6b5J6ncL5qs1YZ9YDq6tM1gOi/DhJ1eQRUJFSAc7MUvEGmizGU2TGKG9QGXq7lZ77G4qCkp5/hsCeubEX3CrUtwQY47HiYI/RgVuD9ijac8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC8l7vmx0lPfWXZuFtq5a9KooTaFDI0XA+ac2LE2j/U=;
 b=uSFd6igyuV/Uq5zWIzucBjLkzW+rhgtl6aWENW2b37MYPX0uyBwR2NE3gtko6855EE8WF08woLHxABAEu1TWn1LbMwxvPJs6OWdwhd1v6OBytJGJECmD4/bVvz1PaaOCATIjrSCaR1qSjCNw8ih9z+/HhX1au6ea0EkvfxRvD2I=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by CH2PR10MB4231.namprd10.prod.outlook.com (2603:10b6:610:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 14:35:11 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%4]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 14:35:11 +0000
Message-ID: <4a6fc718-aced-4f02-a4b6-bdc8fccd329e@oracle.com>
Date: Tue, 7 Jan 2025 09:35:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: cp(1) using NFS4.2 CLONE?
To: Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALXu0UcAfYN4z9Wmr0SA6DRUt7RmasN2qq9wSZTt50yBs4hP9A@mail.gmail.com>
 <948ffb91-caa5-4244-b0fd-19f460ebd7a6@oracle.com>
 <CALXu0UeMT019gHRW0GpiQBn1vh0TTRqEg50CFUyKLHUoL8BJSQ@mail.gmail.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CALXu0UeMT019gHRW0GpiQBn1vh0TTRqEg50CFUyKLHUoL8BJSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::8) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|CH2PR10MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a70d55-fdfa-4ece-b1f3-08dd2f287d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWRlUXFLYTJ1SWJ4RkluY1ozOUpUT1g0YlY3OTVBc3g3QWg2MTFFekFUWkhC?=
 =?utf-8?B?V1U0WGRyR0NXR3hSTTg1T0xpdXZqK1V2bnBEWE5ZdXBHQmRJbXQ3aSthbG9j?=
 =?utf-8?B?R3kwZlh5SkhOb055VDBUM1JFaWgwUUVzR2tDVHJWYzBlSGw5U2p5T0JQR1hC?=
 =?utf-8?B?ZWhSOHZrS1VLSUtUbzB1NE80ZVZrZUNnQ2lwczZOUWp3MjhCSTIrQjB1MUNM?=
 =?utf-8?B?NDNnbjMxd0tsWVJEdXk1MUdkLytFb0NhTjd5TURlc1A1MEtIbFVTM3gxSW9P?=
 =?utf-8?B?bG5oYXljVGRvTEM0RFFkdkpZWjNqSXJ5WEZmbDBVajY2MWRNdER5djUyek8r?=
 =?utf-8?B?MG1IdWFRVnZrT0RyTWZvVGROT0kzeitVdmhYLzZRbkFCR3dtb0xEZ0VsSEFM?=
 =?utf-8?B?ZTVkZ3VrWHpNQjRPQXUrKzVsYXlHUUhORzVST01QUy9XUFFXVStCRjd6Zkt6?=
 =?utf-8?B?WFI5U09QRmpmbndDK01WTnNNb2tsYnBjSVFyM3YrRXhSSTJEekNSV2lFZC9q?=
 =?utf-8?B?ejFneitGZFNGWFRxSy9mQ294Yk1GWEtuQklrZTR4TGRhK2cveDdSVFd3WWVt?=
 =?utf-8?B?RzFvN0JNTEtyWlRRd3FtcVRjanJEbUhzM214LzJuMkNjR1QzeEl5UnNXNk5k?=
 =?utf-8?B?SEwzMmhaMHF4NDBhZnNwSzB6Y3p4eDlWZnB3UlIzTUc3QWNKU3Vzc1ZhdTNV?=
 =?utf-8?B?ejFraGI1TE9Vb0JmdXRRcUg4Q1BjckFKdC9IV3Q4aHgrTUhqSnFEUUlWcCtP?=
 =?utf-8?B?VHF5d09QK2UweG5CMWNsVjZoZW51REdCZW1SYjRvZ1RyTTlxc2lUbjVUVDBj?=
 =?utf-8?B?anVxaGlBM3U4d2VLRFdUUDcva0pzVVlLT0xGcG1xOTc3cEFNMWFydGE0ODBj?=
 =?utf-8?B?a1g2a1RubmQyM2pjVHNyYWRoY3NKZkVJd3l5M0xFV0dtVlZ6S0crM1hWdUd0?=
 =?utf-8?B?ZDhZTHJ6L21hVzlQVFY4eTJLZS9nbGhGUFNMVjFrOE04d1lKS0VzeG1Kc0Rp?=
 =?utf-8?B?L2phTDBsNDVhc2wvUFMvZThsbHBvSFNxQlVDZm5GeTA0T2pRMG8xM1dMaFcv?=
 =?utf-8?B?bm9NUFl0UG9IYlpEbklCdk9ZZEJTcnRudFZZY0Z6cjAyK2Mya0ltTE0zbVRB?=
 =?utf-8?B?NmNXWExGMzU5N2d2MXF0ZEVSVmIyTWdIbUY0ODhCY011OWx4Y0RZZ2MxRFMz?=
 =?utf-8?B?dnVGeUZIajJhWVEvclEvQTBhd0tRcnl4T01HM01Ta2xvWFpwbFBOZVRsVHNJ?=
 =?utf-8?B?alVSZmwzcEJxL0VQeDV4Z0d1TC81WFF2RWNzbG5YeGpHTERDdjJOYm1BUUlw?=
 =?utf-8?B?bDRXbnd4WVRlazZ6aFl3QVRtRDZuNVZ1d3JRckhFVnVaWjlZV2FubDBBcVY2?=
 =?utf-8?B?b1VVQm12TXoyNlJvV1g3WkVsaVZNWXA4Z0tsZURldUdNbFJrTlhoUS9uLy84?=
 =?utf-8?B?YVl4MElLUHIwSE5vVzNXMTBSZVdFM3JVVnhKK1dTbXZDcHh6aXUxQ1BJdU5Q?=
 =?utf-8?B?NXFiVll3N0FLaDRsSkR4Vlc0WTJ4Y09UQUI2QXRTanU5R2VPTVdqTUM3VUhv?=
 =?utf-8?B?SU50TU1kd3VnZW5DQzVOTStiK0lGZWZOL1ZmWUwrSGZMOFJEUnVpcUVxNU1p?=
 =?utf-8?B?UGt6eVVZVlZwY2tVMnVETnNFSzdCYlozRVhKRXpEZElxbzE3elRCcTk4M29r?=
 =?utf-8?B?RDcyRmRXVDJRdE1NdXRhU0JCbHE4L2NnRkIvRGlOSWpPTWI5RDc1bVRnbjh2?=
 =?utf-8?B?b3ZiV0NmNzVKMDdpbjBQa1JXSE01eCtMWUprVHY4Sit5bmpyaGo2RDNzNEdJ?=
 =?utf-8?B?QU1TaXUrR2lPWnhPVHk4ejdmZWc0eTZWZlZ5ei9MZjBRMlliYTNmTllhRVk2?=
 =?utf-8?Q?NC3HVSz7kYOto?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekV5VXFpSlM3MEtZbjlVWmpTQkRLNnhWc0lOT0RCNlpxWWdyb1RzU0VzdGY4?=
 =?utf-8?B?bkhqTm5HbDhFNHVMVTU0WGlKWVRFOWsxdUpocEgyWFpSSFhZeEllU3ljQUtP?=
 =?utf-8?B?QmxKck9ZN0M4VFUwZHozYnFFOGRXZWFzWm14STBiM1p4bm1MVUtwQlc0ZjVo?=
 =?utf-8?B?VGJ0T2srWVBCSnBvajJKNmdlZSthZ1pnakxTZzZJalBlSEU2ODdVZkF6aEI4?=
 =?utf-8?B?ZTZGc0J3d0trbVkxSmx6T2g0cVROMm5NTkoydmx0bUhkY3QwU1JVbFVMQng0?=
 =?utf-8?B?TUxTVEtCckh2RGtjbU9WbTNySE1hNEZZcW9ZZHhCeVRFYlJwY2FHOTNvT1hJ?=
 =?utf-8?B?c2dEaUdFVmFNZlE1aHJldzFJMFRwbDlHbFBMK2I0dGJtNkFSZWUvNXFlcFhI?=
 =?utf-8?B?elF5b1JPdUs1UXpNd2ZtTHFjVUxTMVJ2WlRUY3ZKMWxhNkVudFZpd1ZaWGNU?=
 =?utf-8?B?Y3dvbnN1cVVDQ2RRK25wcCtMUDdjU0ZIVlduY1BuVjFDdk9FYmRrUzFobGFM?=
 =?utf-8?B?NFVmc3hibVc3U3VwamE5OVZsRW5RbUY3ZUs4RlZkdUhDYWhaN2VNOW1uKzlw?=
 =?utf-8?B?ck1sZUtTRmg4RFozODluQlVnaGM5WkhFckxidXN6OEIvOUZ3V2NuL2h6aGxD?=
 =?utf-8?B?Nlg3SmdVWXhkQmdVemZFbHovTG54NHR2dzdEQm9MdE5MZGJIbkowejJET3U3?=
 =?utf-8?B?VFAwT294OThKZk8ySm1YdEJ5bUZzWCtPYXZrWWhQZ1E2cUROOWdOKzhueEFy?=
 =?utf-8?B?MjVsd3pRUWcrZ25iVGptcWNzak9kZTVOakNheGJrMS9PSUtIckl5V283dG9S?=
 =?utf-8?B?U0JKUkJ3WTQzWWFtZTdOTndxeGQxSWRjNFY0KzViUG83b1dyc2RoZk0zTHpo?=
 =?utf-8?B?WjR4YjdkaEhtSWlOd0ovRmxLRTVOU3N3dkhndWdWVElqdzR5YU52Z01mMlE1?=
 =?utf-8?B?ZXdNbDJ6SmlhN2RXb2tiWEhBVzVmWU54TDJkb0tLSE5iaUtGbmFhenFPK1Y0?=
 =?utf-8?B?UjVoSFZaMldxV3VveEtpNDMxcmpqU3VkR3dEK3Vpcy8zUXBxVVRXSzN3emJZ?=
 =?utf-8?B?T3BoVDNHdkZOZUp1SUw5Q2RpbjNxbmswbDk5MjR1SzYwNnpDaC8xUmNSWVo5?=
 =?utf-8?B?aXVHT0hhOTY1cWR4MXpGSVp6ZEhGNHRSbU9ROFVvTng4Vk1SMXJzR1Awc29h?=
 =?utf-8?B?Y3VrNk14bFhHVDF2NVMyTm1wQjVOYUd3OUxtdE9BSlRGdUpzUTNqWC9EaVFl?=
 =?utf-8?B?VXBBYWRkQnJXOTdNUFpLRXZZREczYWwvV3ZoR2VEazdGcFhua3E1SE9abUpt?=
 =?utf-8?B?Nlc3Mmo0dml4QjJiZFhqWERLb2NuUVlKN0FtWW12ZHRNUDZlbXV2ZTdmbERh?=
 =?utf-8?B?QU5kcnJVWnd6Y2hUdXJHQ0hieUhDZlBmSTZPZlQvVEFacXpTRHdYNGUvOXNk?=
 =?utf-8?B?dGdMZ05SbWRaWkpPNTBTVDkzUmhIZTZBeWhodXI3WG1oTUoveVRrMTNpRmhT?=
 =?utf-8?B?cFhGVFRvUVVhU1p4TnBIZ2hkWjNsazJjWXZTQmFKeDMrZXg3cUJxV2V0aFhR?=
 =?utf-8?B?UG1BY3NzYTdrSnZ4blQ2R2JGV2xuWXF4Z0c5V3hiMGlYY0t2aUFwK0RoS0hN?=
 =?utf-8?B?YkFjZjEvTktxK2MvcXNwVTQ4S21oVGswb3djU0taV2QwN1pQNXE5ZVpvbSsv?=
 =?utf-8?B?WUY4ZEVudHBkTmkyanY2WDZ6d2thbnNxZ3daTmhqUWxHM084NDkvYVRWZ3FI?=
 =?utf-8?B?WmpSTHB3QnhaS2NENzRCbXRoRWhnWFZsRFQvNXJFOUs2cUZrOENNUGNlUUd4?=
 =?utf-8?B?ZnkyOElpMkhtQ1REUmdISG1wMXBCQlpGREVKVE1KeG5zS1I5MnBzWUNRNGV0?=
 =?utf-8?B?bU52bmltRWlGZmQveHM0YThpZHpDZ0lrZkxHQmw4STBBWCt2STJ5WnZwbHpD?=
 =?utf-8?B?L1NVbS8xamhORDRSSFdybEU2c1lxNmdxbkFMNTU5RURVYUdGYWRldlZrVCtm?=
 =?utf-8?B?elozaEMzcmd3NGRiQ2lKSHM1ZlRDY3pKK3JRY0JyWkRwOXpPTmJGd2I4SzhF?=
 =?utf-8?B?d2lNd2pnRlV4NldxemorR0dsc2wraHh6UUllTVZmZStQczI0UDZMak9oTE50?=
 =?utf-8?B?YmV3eDRRNU9xaGlhODFJWGxmcnpQRXdjSVRzSTRIRFpJWEcwV3h2WHA3bWxo?=
 =?utf-8?B?YVdnamZhVnd0M2c0MGNna2UwWm9BR3YvL0lFVHByc0JkbEtIOGF6NTN6dmtE?=
 =?utf-8?B?RWp6cXVBYVc0WnV0aGV0UmM2UGR3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MWU0KaGLX5ODLHbT99tFMWeVZ7xjB1nbA7A9BZzdiZ+SLJAs+Wr8KCvt/kmoQmXHvXBXFxX11vI3YYW48irt8NIloMuN9u0NR2CCZixWh3MH9R53UkFDhNbYh4eLL/KmaGIjZw8nyVnFo7lF0e9ghsW1++y1oG9bhENC1yGf4+cZnJmWN9q+vZzFKbxsuvVpkjwUQAmTot475mFx2Db3bhqIBE1yCICq7ZcNU5n5lU0bjanC63UJIICmmVeAa/cKNMXiEmitawbpjgLoga8Gju4DPM1zcUFoV/gGRbnITpT4fIAUuUFUywCNSNGD0zNN+SvBeTQtzObp2Qi0cD2ZpsClLOlKBwIshAahi1D7ih0PHEkpxg4pD0XPbqsTWRgLgpW3QfbeVobQvvAkqpz5vOIaGcY7ivOYFlmk1fZRmdLL9mp8UcPNqvHy0m2eSyDivwXKyQran2ayhXshyob8P7aoqIVC06SMucq7rgpd4BT+a289ydHXQlZnyFGbTY1cLYcgbV/D9ABBN9YM9vU3mcPoyE9YD4NjTcwTgCl73PQDAqfAE+3YLd8fOwhDrxh7J52Npx4Hgn1jKpAwVnjKEaLots3+Zdh9kkzZA2t23uk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a70d55-fdfa-4ece-b1f3-08dd2f287d98
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:35:11.0282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vrZYqbUepprY4OMyevqK4uiCjwUUKRqUJclJkphq/bUGTEMN6bm5rrLeTIAzmPgeBB50F2FSxAuoIzsVKqRT5KukzC73JOreKxvw9j1I6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-07_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501070122
X-Proofpoint-GUID: sOUnJMiPNKZdWJ3QhomUTyhi3r8dO3xW
X-Proofpoint-ORIG-GUID: sOUnJMiPNKZdWJ3QhomUTyhi3r8dO3xW



On 1/7/25 2:10 AM, Cedric Blancher wrote:
> On Mon, 6 Jan 2025 at 18:30, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 1/4/25 10:44 PM, Cedric Blancher wrote:
>>> Good morning!
>>>
>>> Can standard Linux cp(1) use NFS4.2 CLONE?
>>
>> yes, use option '--reflink=auto'
>>
> 
> Why is this not on by default?

That's a question for the GNU coreutils people, since that's how they implemented it.

I thought that the copy_file_range system call would try to do a clone first, but it looks like that behavior changed a while ago. Now the system call will only attempt a clone on filesystems that don't specifically implement copy.

Anna

> 
> Ced


