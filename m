Return-Path: <linux-nfs+bounces-13119-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8B0B07EF6
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 22:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38A33ABFB8
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 20:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5FD4501A;
	Wed, 16 Jul 2025 20:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d+xWJv4d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zlc7RhJZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1161273FD
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697922; cv=fail; b=dkIbwwMyMDiggRFl9Pu9PpiJRkc24CamCW+eK+/KPSNWgNZZwXrrOhDiUZ6vruzLiGrA8yIKKzPnVFMGZeNJR6JGBr5yQ3AqjCK1aaJWHY8Ov4hRreOVcsXYZxKTQ1PzujGcLqh6oDoTH/w1G7+CjubullnAd8x1EUP3tid2YZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697922; c=relaxed/simple;
	bh=IWAjA0NmXrhNN67Tt8jv+ByqpM61Uj+QghVNupXJ1sk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XlZW0+t97cIHghM9XU3BxvnmyAHImAesHBzvgh2SdolJIAozcIDrwSol7KRznjw/0ACJnPDgnBa29YoT4AUILXIeTNW1yyVFkwzceqD+kLmsgaCRYX8bBxF1ZiW69eOrJm9Y6q32wwpSEdlmmfi/tsfMfY++tiHgXp1ctBzNLbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d+xWJv4d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zlc7RhJZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GJuMJR009340;
	Wed, 16 Jul 2025 20:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Isp+6ylATSOZtazYNr1X8k8uEkNi98RQOn1kc41plRs=; b=
	d+xWJv4d6PqyPPf9lx31LIfEfhUrkwMPZnQCMwSzh7Fb34ZFifuGRxoqr1pniJd3
	8+6PXWHdXAg0cSEQEwFfy9YCBLAs8gU7l+cvhlIGO9AiY+6aYG5AlbJqdCty8NiM
	G3doPlDgU3xCCZR7Gv7ZPkxwOEh0ymO7J+FM1YTsISaNUdwyss9GhFNvblWK1t5T
	r/zmfTF2UsX2j14e7nGk0JU/CS3F8Oiyr5zAFaFiIZ6hP4cG+h0fXBKx3hVIRZJD
	DQZcDthYpkhIS9i2avniPmrrct5irs6h64Q9Pwg6sDVgSnoPCbkK/3Gly6YxL4ot
	8+ia55vzcPUGW52KZ2+Bqw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b1rmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 20:31:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GJfUfx012988;
	Wed, 16 Jul 2025 20:31:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bbv1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 20:31:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TU3oxwDmqItwnFOkHVehePYc+GLsm1jGjhejU5OlBNqcHv9BTp+5IfVQn/ErYtCsCXw6IJk53QCP5RUmvsIe750nKIh1XR/OyI6kz/Sw27BLQvUoawXUpdwQLcZhnEs+fHJlJn/azQE5R/VaRIKn5LeIpM8f6Enz5ycXga5TJWcetze2MBzuTKuwfW54aFm5305sEOh7C+OS09jVzqNy9NvkangsuaVmpe/4KVMLFgY8CcVDFf/9BqBoWOuLIBbnYESWGB6ju2n9oI5AVCsNnjrBJM6ehFlvtoobYwtbcTzXABAAk9M6NmKi+CjnXhw0Gc9EkvVnRyBvwGkFZwiahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Isp+6ylATSOZtazYNr1X8k8uEkNi98RQOn1kc41plRs=;
 b=PIp43pLvcAs//2nPBhA0n+ELCBq7urKExbfrQpuN/ExSAxv+yjulzoVj1pRoUYMiSpjx0M/Xdsm2ti0IgtdM1sUjUy3hccUiVsuxfrZUgd2qJ15nGDM730ryrExLpTfjasnAgfUlgFAZxTygfAM0XM8paTqB/XtHTIMDjAR3WAhGtjN5LQvBVfVz74vjJQXnQj76zz5eCtjc8Mp9Es7s2BWHKmbaLcwBuSG2CHCOR5SYxRSY1agCoOimurebY23/lf+dl9qlh4ywXn2d1e3xb4FLnnCTvcObbXrqYjTqnFzN1qS3bhbhmzz21ZLlLz/k4U2tW/LeeovCd5kLk873aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Isp+6ylATSOZtazYNr1X8k8uEkNi98RQOn1kc41plRs=;
 b=zlc7RhJZsj6ZRwwsvrhyewenMqP9bO7cVA688NxScT8fLB6pDotokvOpCQohWX9ll4QMNtaZ4Qj9AJShKzaF3isjsk7xXe/lYvaywyjk0Z8WGa3bufuMEYbwVS4v6KOrJWUD+1/oINrxaDFXFs40cZf5FgTgI7R4AUBZu5dP1FM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5790.namprd10.prod.outlook.com (2603:10b6:303:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.37; Wed, 16 Jul
 2025 20:31:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Wed, 16 Jul 2025
 20:31:50 +0000
Message-ID: <34905201-eec8-4fd9-ad3e-40a9a3cdf03c@oracle.com>
Date: Wed, 16 Jul 2025 16:31:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] nfsd: Implement large extent array support in pNFS
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Sergey Bashirov <sergeybashirov@gmail.com>
Cc: linux-nfs@vger.kernel.org
References: <9892f785-e9f5-4a29-9ff7-fd89dbf7e474@sabinyo.mountain>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <9892f785-e9f5-4a29-9ff7-fd89dbf7e474@sabinyo.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:610:54::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f94963-396b-4d1d-533e-08ddc4a7cb56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTI4aCt6K3liYk91MndJTmwxTjBhazlzYzFId1poaUpyYW1pM2Y0dk1rbU1v?=
 =?utf-8?B?TENZZkw1R0RJemZzdVh1dVVXYksxZkIvR1h2UTBqNWFsSDIrYXhJbVZCLzVm?=
 =?utf-8?B?SkRQekk3cm5aYmpPMUwzODlzTnh6WkRTSGFqSDFVNDNVMXk5TFNNY1I5NGV6?=
 =?utf-8?B?d3RFeFI2c21JSDZZbG9JQytSRkJkdjJ5OGQ2NXJpSFUrbTh6b1N1TXhsdS9n?=
 =?utf-8?B?MGVHUGVtb3RGMVFPQkZhc1BhL2V4eXJJdDN1TUVvbUFxTzdqeDlIYjBkUXpk?=
 =?utf-8?B?S0NITjZtWFhuOVdlK240SXYzZm5jZ0NIdmJWVHIzNGxWVW1jODVPYVpGZzNF?=
 =?utf-8?B?MENid0VSUjN5aVdTbHk5TzFBc3ZYaWJYY2h1UFFFMVF0eFFwMDE1VU9qb3Na?=
 =?utf-8?B?QUtvYUpFNy9vK1pNaXBteXZ5a0J6M1JtY0Zld3JNbWdkNi8wSS8zRGpxVU8v?=
 =?utf-8?B?bkcyelNhelF0WFZNN0dFS29aR2cxZnhWWGRlajIrT0NJTUxpdTJZbDByYXJF?=
 =?utf-8?B?K2crZnIrOG40Y1hWaFVSeTVMQytQRzRjUTVtWGxKc21YWG5rM2g5SjVNMTl5?=
 =?utf-8?B?VEVRMjFIRGRwT1paaStiRW1ZamowS000Umx1TGhIYXZpUGhnZHViUENucm9Z?=
 =?utf-8?B?ODBFUXpndnZaSUFCL0IzbFJLTWpObkliaWdNdUNtbkp2dC9lbjRwaldlTzRS?=
 =?utf-8?B?SXBUT0dJUUxFMTZNZlUvQVhoRVlHRlV1bTZQMTJTaE82TEYxUnhGbU5md3B0?=
 =?utf-8?B?Z21DdzFaUHdmZG55cW11TFNlVGQ5MmRkRnBGTVZackhBYW5YMjhzSVFPR2xa?=
 =?utf-8?B?Ty9PYUdUbDVWWjNxR3QwVVozdjBnOXFIOTY1M1FyWFIvKytCaDh2cCszTHE4?=
 =?utf-8?B?eTl0R2pJVmhZY1RsbWtxa0xlZ0FmeUlpOExQTGtneUR3ZGc3TVJ6YzJXWUtL?=
 =?utf-8?B?aW9JL2JHOFh4MjBuWFo2Z1NpWVp2UEhaOVAvLzI0SE05dlJpOWhKQ2lHZ1kz?=
 =?utf-8?B?QlB1RldIVDVqVFpzR0hHSVBoZDBaNmdkTTdqbml3SUYxblhWTFFEUnFRL095?=
 =?utf-8?B?ejNGWkNqaVE2K3JBeEtrY3VmMjZSbGRMKzFxU0xIQ1BrS0QwblowdHYyN2FM?=
 =?utf-8?B?aHgzdWlrQ3k2NTlKMnM1T1ArK2ppVHo0SVBobFd1K2djTktMZVFBdSs2WFhj?=
 =?utf-8?B?ZVo2NHJ2UlpCRi9ES3VFWjYvTXlTUng2ZGU2c1psdklyWXBjZkcrOHpkYWFD?=
 =?utf-8?B?Q3Q5bXBaakc4U2FHN3ozcVhGL1p4bmg0azd5RXIyY0llZDM0eEU2aFp3aDIz?=
 =?utf-8?B?UlpmZ002R1BLZWlRR294bUdYWGU2MUlOM1lNUDRobVBBVi9hOE1XMGNwalNu?=
 =?utf-8?B?L1dmcDVEaHdFTUp6OGwrOG9aUWlhWnVhL2VtbjkvUmYrd3Q1YldxREM1VnYw?=
 =?utf-8?B?RTJUaGt1TzZzNTJHT2FNa0QzRE8rR3VaZHdSWkFIOEw5UVI1Q1ZQN1ZLeFJK?=
 =?utf-8?B?YzB6d09RTE13YjlYRDl4RVdUa2NBZlZsdVZMZUZxOVF6aWRXTERTN3NtNlVk?=
 =?utf-8?B?TjVSeEdSbXhqWVV1dHp4OTlDWEZLblVrK28rNlQ2bUZjc0FpNzFoeHdsMWo1?=
 =?utf-8?B?NHZOSkF3UlhJemc3eUVQK0U2V0I5RFFTNDJrZHJTTGRzL1lSdjVkQTRtdlFV?=
 =?utf-8?B?YjJBMjgvV0EzMEQ0YlNWRDBlanV5TUNyaldWUGdNaFlrbHdKS2tGZXI3c0M3?=
 =?utf-8?B?cnVtbEttSG8wVjA4WGR4dzFSMTAyNDI2bU9pZFJzU3ROZzZDWW9xekVIcXBK?=
 =?utf-8?B?c2ZkdHpXTHVrRlAzaDJIS0l0SVlHellDczVLN3p2YUhFOWxYRlJwVjc1WUE3?=
 =?utf-8?B?MW44Q2pITWdVQ0IyemVackZOMTFuSnhrSzlWWnRjR1RwTTYzTFl0bzlaUkZB?=
 =?utf-8?Q?xVLY8iQLglY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGRuclJrdGt4R056U1JwaU5RaTF0SEszem0xaVVvZFI3bDFoL2FqbDdUWWF3?=
 =?utf-8?B?VFRYa1RHdzF2YVBLVld4VnUzc1R4V2pINUU4ZlB6dmhiMWJUVkJOV0RaUTJo?=
 =?utf-8?B?dWJkRzEydWFxZXU5RU4zNlRzUHdCZk5SWDhaTkw5MzVWaEJGRXFuSGNnYmNV?=
 =?utf-8?B?aU13dE1zQzVJVDBIN1FUak1meDQyQ1E2cmtFQmEzVWhTRHBFeDRWRi9mejNM?=
 =?utf-8?B?cEhlZ0JTVEtwWUE5K3JaTFk5R2NzVlk4clcrcGxnL0NxTzVPQ2ZCTnhqenJa?=
 =?utf-8?B?MUFiS1IzK0dIY3pEekJJbFUvVUdRbVZ3cGVSTHJvaVpqQlJlZ2Noa0EzdDdp?=
 =?utf-8?B?RTlIbzFIakhJcHdTYncvbUZFa2VLalR4N0tZSTAyNDFuSkwvOEtWMG5KZXc2?=
 =?utf-8?B?cldjc0RNRjQwMUZEelhLblcyZkhEaHVTSWZhUWkyZDBxQldRUVRqM3NjUzZL?=
 =?utf-8?B?amJpVzRITnpKcjBOanV0RnRNMmk4Y3QzSUNEdWhOUlZyQUlweFF0YmtWbTFw?=
 =?utf-8?B?b0FpaDRPckZ4WnViRDVuYmZpSUdjci9MN1Z0dDhlZjBlbkJNSDdkQjQra0du?=
 =?utf-8?B?cVZTRm9wUHBsNEt2c3hnbHF3aktzZXRsM2dMMnUrOVd5aFloRmFsU2lUS3Yw?=
 =?utf-8?B?YnRubGphNWhFcFNnOURKR2U2YnRqcGhWTDZvcDFncFA5YVhBd2s5WmdMZTA3?=
 =?utf-8?B?T0lmcFJ4NHM1WUt4TUVmQWxMVVNkNU1OWGZpcXJTQXNNazZoUFdGLzBFS3dI?=
 =?utf-8?B?MndEQUU1YVkwZWN6ZVVkZS9BaWVoVUxwSkZua2xBR1hocG9KdllUOVE3b1cz?=
 =?utf-8?B?N2g3Q0ZJdDFGY0MzMXAzTFdoNTdPdWJsMHlrc1pYcXE4bkM5bVRlek9hL0ll?=
 =?utf-8?B?MkpVaksyTVpPUmVZekRpWVlpNG1oTm5tZ3RWbi9nY2YrVjh5Q2k2elgvNmo3?=
 =?utf-8?B?ajd6ZXR4SzZvRXZJejZoZnlhT3IzNFJVQVFVRnRCWDR4RHBLRWk2b3h1VjJO?=
 =?utf-8?B?dHZrRjhuYjRyZ1AwUDVvRFBaVytzSjV5ZE9KWlk0NTV5d0FIbXV4ZnRXQkpR?=
 =?utf-8?B?WmpjcXVpM3UxRFZWN0VXUVArTkFtRzdkMzFSWCtEdkZvb1hUenR1VnFxSE5W?=
 =?utf-8?B?WUxGQk9MQ1ZES2RWUHpsVU1WVWFSdXNVNm1MZlc3QmQwM3UybWJPTW1ZN3Zy?=
 =?utf-8?B?bzFaVmpEVUJMNU1DYXdNRUhFNlZHWGRSc1k1bzhtN1NKQXFwVGdZNkk2UzJY?=
 =?utf-8?B?MjJsZHFrdkI3RjFXRFRvSy8yTExuOHdYTGdzTmZPV0MyZHUxYmJZNjRibzMz?=
 =?utf-8?B?RllETi9xc0tHK3M1Y3RRazYwNFptK3MyVkJ4UVhlL2lUSjdteDZ0aXRlZkNR?=
 =?utf-8?B?cXJ4VG00M0VXbnhyMGpRdVRpa0s3bm9SK29oTHJaWExnTUxXVVNNMy9Fcmoy?=
 =?utf-8?B?ZFdSUTdKVm9JZU5pRUNXZDE1cFNsamxncWdzWE5kN0JmaThEWitqRlRZOG1P?=
 =?utf-8?B?T2V4d0lhTG1SRVgreHNKVEFRM3F3ZEsyTzJsZ2gxSzAzYlQ4SDA4b0hHdkMz?=
 =?utf-8?B?UVdQYmZ1ZVZCMmFOZmVmKzVmb3BhaC8vaDM5YkZWNmlxOUoxVnFid3N5WGdP?=
 =?utf-8?B?Y1NSNURoTDJ5ODZmdzVXT0l5VUFENmNKNVJ5M2UxU1Z6RWl0bVBDUUc2Vk9q?=
 =?utf-8?B?d3p0TmIxMzRTY1VkZVVXYXNyK3ltRjJxSWhuM0piWXpxdWlSN3cyN3JuZ2pF?=
 =?utf-8?B?L09rZm1YVjRwVVNKb2M3dk5TWHlKZ3piYmZlL1BzbG1DRTAwYXAyT2t6WWI5?=
 =?utf-8?B?WlIrNzc4Um1Wc3duVjRTaHJUSEF3VUpQWVBJbGRuUkdvSjJvRzJtSkRpTzVh?=
 =?utf-8?B?WkwydngvdDdrQWwrQzllTXg2OTRHTTJ0S1ZQQS9aUU14WTdzUFM1aWxGbFRz?=
 =?utf-8?B?d24wY2REQ0w0K3Z1Z3NVenp1SC90amx6YUpyWTRxOU50MDdhM3NGZEdlbVVW?=
 =?utf-8?B?dXRBc01oSk9QUU96YUN2akgxQi9Yd3VrWm9aMm5mcHhvS3lwUXZOLzFob1ZH?=
 =?utf-8?B?dnpYZUc1czBERCtWMHhkYXRSeXZzY1hqQi9kYkRuMUh3VTBicjRrY0J0dVpq?=
 =?utf-8?Q?oluk210fr5T3RGLAxQmKfq5qB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cN1VeEguS1TE/OGGEKI4H5e9zNEy7ipaW5KeAHVkJ0tGxAKsAqvu12Hca2o7SIUJP0XigmdUliXeQZ8GJRVKyjwl7WB/hXqOTTqgpka9liEQ+MvDz1BSn08JolysqjM+qfofjvTE5v3OVygYjYJKBYqW1Mt9D5FtmmFNWTfOWh8/zelkzSj1AmuNEZUzUZ8teFwLlnQaAUDsw12vODGzpTohxaE0X54Ou8w3SpIPWIpzYn2xpMWEqyVPBWsmOWrttCquBxxDQuqP3zpztUtvoGVpvhUO4ENZ05L0hCNfGOAKKQk0kh3HPt6D9svJxuHyLFoDYvvwCis9UPmay4JO7Z3y9Ai7qEIod+V7NUHdB1kZxMFZw953go6e8WpGvr/rhjYtxBXqXMn+qVZyobiJCGzoLZR+IWkUQWYNGHu3oOSHNzpENszeGjDjAO0bmfOXqRH0dwexqRs9OE8vG57ofMItF2HjYnPx2ULjE4w5iQ4bLPxrBlV39HtdI6huuIJTeOiy5vCfeeNWGYC/sEAjomQ1s1Be8L9kYEC9QAMxOlDG50tUPaCFvhjN8lZGxzWw+OmwfZumw4REGuS3vF9g7GTKkpXGu/8ueJ4xlxj3FqM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f94963-396b-4d1d-533e-08ddc4a7cb56
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 20:31:50.9110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hM9k4KZPUJZtoFmuX+YNMcp3lmD0YxwutLpW6nIdzRqfMZ3LxsB5JcRU1xdEfyjo+R0DX9hcBqFTuKkzJHL9kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_04,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160184
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE4NSBTYWx0ZWRfX0/yBX2yHcz7q xLRU2F5Oaubthm7Gt03MiSNRdhLRcf3/+nW9R1m+H3dSU1JltyZJTs4Z982ov2OaV6/gl/fM5uS uo5eTvqDuKuQbvo0wUSgF/7u0ZN4BmclBIFQiynIJbU9W9Fu7xhBJq4bICReU7cKYVPTKC1WMpO
 dg1rhTZMM+fgCTQwqWgQRQYIwisS7CgqaG30i9V7VrJYIziS9J/FtPUNCFCvBOc+HaVA7e0tGyp toY5GwFKX6dJoYRn5eE/Yxr4HdS3oz9hoajC0xnS8WPHNh24j7DXtFoPxPKnFwUeLW/lgckkneE v7VXAPmusZD5MTSTO6b4GBqQpO1gcDkpEMtH4McD3J+9ljdvskImZQi3gy54M7iC0APA/gVSX2X
 6hpghFJMcsM7tbEDzH3im4auIRktWiSbS8y2VHyox3oyeFvXBRLMXDcbl+mJpLebBtKJKYi6
X-Proofpoint-GUID: yNI8f-kM_V9JqjExKLM0Vd-e9W5mr8y1
X-Proofpoint-ORIG-GUID: yNI8f-kM_V9JqjExKLM0Vd-e9W5mr8y1
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=68780c3e b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=avLaCuES8_ObiVX0sE4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061

On 7/16/25 3:40 PM, Dan Carpenter wrote:
> Hello Sergey Bashirov,
> 
> Commit 067b594beb16 ("nfsd: Implement large extent array support in
> pNFS") from Jun 21, 2025 (linux-next), leads to the following Smatch
> static checker warning:
> 
> 	fs/nfsd/blocklayoutxdr.c:160 nfsd4_block_decode_layoutupdate()
> 	warn: error code type promoted to positive: 'ret'
> 
> fs/nfsd/blocklayoutxdr.c
>     135 nfsd4_block_decode_layoutupdate(struct xdr_stream *xdr, struct iomap **iomapp,
>     136                 int *nr_iomapsp, u32 block_size)
>     137 {
>     138         struct iomap *iomaps;
>     139         u32 nr_iomaps, expected, len, i;
>     140         __be32 nfserr;
>     141 
>     142         if (xdr_stream_decode_u32(xdr, &nr_iomaps))
>     143                 return nfserr_bad_xdr;
>     144 
>     145         len = sizeof(__be32) + xdr_stream_remaining(xdr);
>     146         expected = sizeof(__be32) + nr_iomaps * PNFS_BLOCK_EXTENT_SIZE;
>     147         if (len != expected)
>     148                 return nfserr_bad_xdr;
>     149 
>     150         iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
>     151         if (!iomaps)
>     152                 return nfserr_delay;
>     153 
>     154         for (i = 0; i < nr_iomaps; i++) {
>     155                 struct pnfs_block_extent bex;
>     156                 ssize_t ret;
>     157 
>     158                 ret = xdr_stream_decode_opaque_fixed(xdr,
>     159                                 &bex.vol_id, sizeof(bex.vol_id));
> --> 160                 if (ret < sizeof(bex.vol_id)) {
> 
> xdr_stream_decode_opaque_fixed() returns negative error codes or
> sizeof(bex.vol_id) on success.  If it returns a negative then the
> condition is type promoted to size_t and the negative becomes a high
> positive value and is treated as success.
> 
> There are so many ways to fix this bug.
> 
> #1: if (ret < 0 || ret < sizeof(bex.vol_id)) {
> I love this approach but every other person in the world seems to hate
> it.
> 
> #2: if (ret < (int)sizeof(bex.vol_id)) {
> Fine.  I don't love casts, but fine.
> 
> #3: if (ret != sizeof(bex.vol_id)) {
> I like this well enough.
> 
> #4: Change xdr_stream_decode_opaque_fixed() to return zero on success.
> This is the best fix.

Since the XDR field is fixed in size, the caller already knows how many
bytes were decoded, on success. Thus, xdr_stream_decode_opaque_fixed()
doesn't need to return that value. And, xdr_stream_decode_u32 and _u64
both return zero on success.

Since there is only one other caller, modifying the set of return values
of xdr_stream_decode_opaque_fixed() seems sensible to me.



But, I spot something else amiss here. Note that "sizeof(bex.vol_id)"
is the size of

 595 struct nfsd4_deviceid {
 596         u64                     fsid_idx;
 597         u32                     generation;
 598         u32                     pad;
 599 };

This is a C structure. The compiler is permitted to add padding, though
it probably doesn't in this simple case. Distributions are known to add
padding to internal structures to enable additions of new fields without
breaking ABI compatibility.

Thus there is no hard guarantee that sizeof(nfsd4_deviceid) will always
be exactly 16 bytes.

To ensure that the XDR stream is incremented the correct number of bytes
while decoding this field, the decoder needs to pass the size of the XDR
field, not the size of the in-memory C structure. Thankfully,
include/linux/nfs4.h has:

800 #define NFS4_DEVICEID4_SIZE 16

So let's use NFS4_DEVICEID4_SIZE rather than sizeof(bex.vol_id) when
rewriting the problematic decoder.

But that doesn't guarantee that the bex field (of type struct
nfsd4_deviceid) is large enough to receive the raw 16-byte XDR data. It
probably is, but why not write code that documents that assumption.

Maybe what this needs is a type-specific decoder for deviceid4 fields
that will take a char xx[16] off the wire and decode it properly into
the in-memory fsid_idx and generation fields in a struct nfsd4_deviceid.
We already do something similar for file handles.


> regards,
> dan carpenter
> 
>     161                         nfserr = nfserr_bad_xdr;
>     162                         goto fail;
>     163                 }
>     164 
>     165                 if (xdr_stream_decode_u64(xdr, &bex.foff)) {
>     166                         nfserr = nfserr_bad_xdr;
>     167                         goto fail;
>     168                 }
>     169                 if (bex.foff & (block_size - 1)) {
>     170                         nfserr = nfserr_inval;
>     171                         goto fail;
>     172                 }
>     173 
>     174                 if (xdr_stream_decode_u64(xdr, &bex.len)) {
>     175                         nfserr = nfserr_bad_xdr;
>     176                         goto fail;
>     177                 }
>     178                 if (bex.len & (block_size - 1)) {
>     179                         nfserr = nfserr_inval;
>     180                         goto fail;
>     181                 }
>     182 
>     183                 if (xdr_stream_decode_u64(xdr, &bex.soff)) {
>     184                         nfserr = nfserr_bad_xdr;
>     185                         goto fail;
>     186                 }
>     187                 if (bex.soff & (block_size - 1)) {
>     188                         nfserr = nfserr_inval;
>     189                         goto fail;
>     190                 }
>     191 
>     192                 if (xdr_stream_decode_u32(xdr, &bex.es)) {
>     193                         nfserr = nfserr_bad_xdr;
>     194                         goto fail;
>     195                 }
>     196                 if (bex.es != PNFS_BLOCK_READWRITE_DATA) {
>     197                         nfserr = nfserr_inval;
>     198                         goto fail;
>     199                 }
>     200 
>     201                 iomaps[i].offset = bex.foff;
>     202                 iomaps[i].length = bex.len;
>     203         }
>     204 
>     205         *iomapp = iomaps;
>     206         *nr_iomapsp = nr_iomaps;
>     207         return nfs_ok;
>     208 fail:
>     209         kfree(iomaps);
>     210         return nfserr;
>     211 }
> 
> 


-- 
Chuck Lever

