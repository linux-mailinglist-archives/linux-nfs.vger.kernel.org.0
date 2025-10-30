Return-Path: <linux-nfs+bounces-15812-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1850CC2262B
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 22:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1C8401CC5
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 21:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346E833557C;
	Thu, 30 Oct 2025 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pXDqR5Of";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="owjPhTWP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731C335569
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 21:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858807; cv=fail; b=mgpMaSOJNWBYtrku1I6N8LXigFfjCZMwGBS/o02rtAoT8JbIFSXW3ZW51sCaij10yPtsJBoQP2wcMZYvf920H8FCnempCi6OnBkdTfNOL7nkcLf/gHPqBSoeWESZjLr1kxdBZogNMeHkORL/VgnevgQtS8YhJ6aH19eRH9WOAVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858807; c=relaxed/simple;
	bh=9KcOVFIYN8JKl2UrDJaZ2ut7jYDG+B1WSkIaDmCHKCk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RCPPUoIu6Z0s+9+IhKHDV2OsBNvKKqJo3WJz7ZToZaaQViIfvUiSd8wEgpKMd7OwSbZ8wzeTo64P/6LG1h229eoLFVvJT7Wcj/U4sO936Qtz2cu2gHJ3ExL1wgDvmuoVTzn1/lkMgWGknKVnWkNjB3JDsCdsHmDaPK6BczQzNKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pXDqR5Of; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=owjPhTWP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UL9IAZ028263;
	Thu, 30 Oct 2025 21:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BCraIlUqChIaWgjzNyPzlW+9XeBYQnrYN4By/WbbuUU=; b=
	pXDqR5OfUgMCzSRK3pXKGI5OaARTchzgBxtZAf6/v1V6X2gQ/CbcZ3rNiJ96xgaB
	zslIyKaveDepS/iRbpX08p19UjeUPHSa2XD4vFurCPcyzl1tSjcxvK5hHW+587Qo
	WtgmzjDfbhM+/SeEqg3svsM/t0O79YOU1cz7lpmVEyV92RUdQ8ukmdGk7jgZb78F
	ImyHh5LHM7AB9fsH7Zx+mZ3uT4iU/oonqa9JQ2NQYCK6NgEWN6WWzxrbpk91QGpM
	Q8wajbr/VF2PFwOekxbCw8lXFjX6IpfrBd1rgmEmQvcAm4HGPCBfgLGAoVEC4fDk
	Eah7DWsHhHg2kvUXVDHvzA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4fpcg07u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 21:13:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UJef4Z004264;
	Thu, 30 Oct 2025 21:13:10 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33wn6squ-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 21:13:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iahaF60fPiCWiFlJc/a9Tn0jO0JL1YdwRE9pZjCuO/t9Aidz0c0vOPN402IT4w7VdNuR376ETkceyg1++JsVb6ZcGDixID90clWHVfRwTcPYCGhkVDUWUR4epnI2h4FsEXstv9AY2SEFIVyuv6eKBPDsj9N1axKtaBYY0odpoA84JhjTqeXz/CafZz85R/PMiIDNVU17iz5QY1bzYeoKI78EvVLR3tzkSdYTrm3sABNhgsYvA7WRfuvDcPZQEjDknb5HxNWjpjKXeTnxC1hSRA91ziO4kDLthsEYpPkKVjIkbKqdI+1VIVF5TfxoJCfCAIhMEgUYIA/df2uZn1+GPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCraIlUqChIaWgjzNyPzlW+9XeBYQnrYN4By/WbbuUU=;
 b=N/N+ge7nvkoFRpG8HGQxt8YKdtnb0Fwksd81FdaXMNKW3sbegF4camWhU1Wcu8PGbYewvrDTCuScmv6EvqBNqkYvtoEacBVmsvTya59eTimVKwg69okYHErO224mglba/lDR3A4uD+crBAgTnXgWuD5oZVyddq0pCwbcObCu+TEo9v4o3WRzrcnjTt4bofvlhXEWsonR/w7vUf6V/Z5mGjUskca4kTmw03HkpbH0OlbocNEWl6lEwIbhlUwJHQOVhxf9LhWo2xl5ICFv+BD9ZcZnXwx9OrtAvweZx9LkUbeMjTRmIazey2q66UKXVaOdLE23ru0+lPzu8XoOX8+wWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCraIlUqChIaWgjzNyPzlW+9XeBYQnrYN4By/WbbuUU=;
 b=owjPhTWPnZ8fnpUYnKN9Nr7D3fQALzOoqIOd6+XrNp2Y9SeEdhygIziS+poKPxGcwB3eXvTu/24+0z99TqSg6f/Qs/sg0H8dEgoOcp18EG3lgcMYe7UwmgN6SOgpbdkgMzvfLX4gekZmvNYDGeaj+Im7JDbA/08dtw5Xfv62zzw=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by IA1PR10MB6050.namprd10.prod.outlook.com (2603:10b6:208:38a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 21:13:07 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 21:13:06 +0000
Message-ID: <07314e0f-76cf-42d8-b729-a6b61f2fbad0@oracle.com>
Date: Thu, 30 Oct 2025 17:13:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFS: sysfs: fix leak when nfs_client kobject add fails
To: Yang Xiuwei <yangxiuwei2025@163.com>, trondmy@kernel.org, anna@kernel.org,
        bcodding@redhat.com
Cc: linux-nfs@vger.kernel.org, Yang Xiuwei <yangxiuwei@kylinos.cn>
References: <20251030030325.157674-1-yangxiuwei2025@163.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251030030325.157674-1-yangxiuwei2025@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:610:b0::12) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|IA1PR10MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ae188b-230e-4550-dae2-08de17f91ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXNpUXpkSm1ibVl3cTAzR3NwV3piODM0bngzYkpXS2lwazg5RWdRdjlhblhv?=
 =?utf-8?B?UkkzYmdKS2poSUlpdmxlbWpmUHdybVhvcjFJZ2JmYlY0N0V5TEd6bzk0bjgw?=
 =?utf-8?B?N2tzRGJNV1lseUR3a2F6WEYxelNFb1pZdGdaQlJFNG1BdjArK0t6QXpkczht?=
 =?utf-8?B?SjZvVzFTZlhRV3ptK2l6RE1DSHdSdnNGVFpETVVSQ3dyNWFZSHR4RGhrakIw?=
 =?utf-8?B?M05QL2tKeFdkS2J2NUFtaDJQTllBMTlKdE90dEttRFh4dTFaa2VQako4VWJM?=
 =?utf-8?B?ekpGVUpJS2Q0QzFscm1IUFZXM0RjOTlPcUZQSmp1dDZKbXJ5WkRkU09GbTk3?=
 =?utf-8?B?VUFhN0NGdGpodWhKZVVieEVEKzE1YlpmZlJPei96WWdQa3Z1NUlLZ2ZaUk5S?=
 =?utf-8?B?TjkwZGI1UjZKUGZ6SnhMTmxIUi9YeTdmOGUrTXVOa0I4UGRBNkM0OHJxdnlq?=
 =?utf-8?B?Tmx2Q1o1OW5BUnhkR1hobjFpRlFzMGtEYW9VSTArUE8yYlYwOFBQVEd0K09S?=
 =?utf-8?B?QWhKTUM5SWFlYThZcjFKNmFlR0VkYW1hTmtiQTZ1K0hoRjdrVHloc3hLVTA4?=
 =?utf-8?B?Zy9qVGwzbjIyM3M1N21kcjJWV3lFMTNLQU9zS0R1T2dhbjZpMGtmR2t5ZXlE?=
 =?utf-8?B?WGh0RkRaWXFYcGt0UkdFL0VCUUI2cUZSMjVINmhVelE1MW5KTVdjVC9iMEN4?=
 =?utf-8?B?dllYZTdUK29qazhJd0FJaWRkVjdyS3YzdUsxd0dZZytoOG0vb2xDeVU0dGxv?=
 =?utf-8?B?VERUMTNtdEpKUDZIdW9KUUNtZ0RuNU5Pa2xjejJLaU5wMFFHWUZ5ZklmRWZx?=
 =?utf-8?B?RDNJTjVKN0tjdTUzeHgyS3dkSXNNd1BuL21rK21hbkJoOTZvSzZuNlU3QlpP?=
 =?utf-8?B?eE9EcTRTOG9MS2ppNldzY29sTGhySENOZmNsOVJpYVRRb2trbDBxNnhQSzRN?=
 =?utf-8?B?NS9YWWZZQjZnUnREWHFRN1lHWm5rY2FSaGVkNWcxM3l5KzVhMUlURjM0dngv?=
 =?utf-8?B?U0xRbmk5QVFpdkdESjI2UU4rQ2JNcFVTNHZFcjZhQ1VuRm1Rck94WXBvT3RQ?=
 =?utf-8?B?NUdYYStyaFRQWWNNOHNlcHIvS3JKd1BPdzNFZzVpbkErWmp4YXAvOFdxSFRz?=
 =?utf-8?B?RTZGT1p4RkFBV2QxMWVrL0pPeENoS05jWlJQWTkzTGFRY2ZrNzNhSFBWOTF3?=
 =?utf-8?B?MUhXZ0tmSnR3U0FlQURuK2U3U2FBaDhOR2xCMkQxZ0JqWU10Q3Jhb3dFZnFi?=
 =?utf-8?B?YTJEcHc4VmkraGMwbDB5S0k2aXRNbEtjNktkRzM5Q0lGaklYaUNpdkRBQ2d0?=
 =?utf-8?B?c0ZiTTlRTCtEcTR4ZEtOTy9NeWlXNEtzWU42NmduWnh0UnZPY2V3WnNna2Mz?=
 =?utf-8?B?dlJXc0FTcFp5T0Z0NTBwVGcrSmp5OVc5THRaSzN4WHgrRlI1aW9heXJ6czgv?=
 =?utf-8?B?bkdBTmhsTTZFVDlaUm4rRFBqMmUxa1JLWis4dzd1aDBGVGdVSXhzVDlaRW1s?=
 =?utf-8?B?ZGpzUENZaWZxSC8rZXJhUTF2TlRMamRGSGd1YXNxUmE5WVZDOGkxeE43Z1Q5?=
 =?utf-8?B?ZkZjMS8zbm5jeXFxeGtlSEd5NUsvdVhlWXNQVUJMUnAwc2JiNWF1R1lBMDZu?=
 =?utf-8?B?S2NqZzRGS1pSOG9Ub25oR09YdXRrTjRYeHpleWI3WGpTOWxEWjVXWU9MWjJN?=
 =?utf-8?B?VDl5TnJ6WDBlbUtIQ0VHZndxcXBwUkpFbWdyV3N1TFU3ZkZWN0FTdUQzanJz?=
 =?utf-8?B?VmdWMGx2aWFCckNKOTY2d001L2tSemcwMHhGb3dtR3poeEF3bHllN3lYa2s1?=
 =?utf-8?B?VTdYNnRma244RmdxVHpCQVBSSjBSNGYxWmxTbkRFQ3IxeTMzS3RzQWlOZ2Jj?=
 =?utf-8?B?QlVUa01qY203Y0QzYUwybGd3d0dBUTc5ZExyNEx2UkdCeERIUVVWbTVsc1pK?=
 =?utf-8?Q?TiBALZiaUSMJpXR7HSHulS1dMA4g/YC7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE04aUtwRmNzWXVUTk42MVlSa0pqS1RoQVBXcVRBTmp2SUVhYzlFVDJkbnNT?=
 =?utf-8?B?Smc3RkF5cml3N2p4bDZSUUV1ZXRpWHR5a3g2TzAwMllpei9JV1FDZVUzd09m?=
 =?utf-8?B?M3FONm9tN2JIZTJENzhTVU9pS1Z0RmU5alN6S1Q2QlcrMnRpcEJDaTk1RkNP?=
 =?utf-8?B?WEVacndkMXZabVRuZDJ3eW1DVTVrbDBzL2JxSHppcVBYRXFOcHdkbEw0YWVB?=
 =?utf-8?B?NVhtVi82bHI3NG1BL3VsNVNmenY2YjQyWElKalBWWSt6V3JlT1hqTTl2UEZ2?=
 =?utf-8?B?b1RuYWlhVjNFTTc0TUh0YXkraWhibWlZK0d6N0ZKS3ZPQ1BHSEpIL1YzS09a?=
 =?utf-8?B?NUFLK1VyNDZBbnVwcXJrL1k3MWtOYWZyMDdGdFF1WEF6VHNrZDhBU3lrcDZm?=
 =?utf-8?B?OVVxTU5PaDA1RWR3bmhSaE91OHhXYVMxMEFuSnFiTDU1SDQzVWozM3I3RVpk?=
 =?utf-8?B?cE40dXVPQVEzWlIzWTM1N3VyLzdnSUwvNnVhbTYzbFRBWUxaZmxKR1BNcG1N?=
 =?utf-8?B?UmVqVHZESSt3TTFHYmdQSElGYjd1SldaTkNnN3NCYUE5dFIyUXQ4S2J2YWdZ?=
 =?utf-8?B?MDZBS1I4dDg4bmN2S2JuLzhRenZBU0RJUi93ZURleVhxZ2tYbVp4eGs4dzJo?=
 =?utf-8?B?T3RYYmM1Z1pCRENMWUkrT1BlZkNUYmRxK3hhQ3NmMGRrbnN5UjdrKzZYK3B4?=
 =?utf-8?B?UDR4bnM4WGd1c2srKzVTVVNhWXpndldESWViRFNkZnVGT2xFZHM1N1doa21V?=
 =?utf-8?B?eHhxS1drZnd6L0E5Ujc0VWtDOVFkWW9rNEZrTGwwWTdnOUZGTGNHa1J4WDBh?=
 =?utf-8?B?ZXVkbXpnc0FnYmVyZ0J1KyszMmlpK1FtcnpXVEV4OEdFOGVKS0xBRmxEc3NJ?=
 =?utf-8?B?bWVrSU1KRUhRaWlGSjdBbmpxVjFiSHFkVnhlRmNKT0F0ak9iZjZZWEVQK3lB?=
 =?utf-8?B?eHFUQlYyZWp3RFI0T1AzVlRxM29GeWxNS28vVTQ1UkN5djFvalhGeis1dlNF?=
 =?utf-8?B?UGtsMDNFTThlRHlnMG5VMUl6VFdJaVhZdlV6Nkp3QjkzUGpFUzNWSWpzYWxv?=
 =?utf-8?B?Q1JjSXpPSGVsRkJaeWZiNUFIRzhFNmJTUzFqSXprKzRJb2JlbGdoWnBSVGcw?=
 =?utf-8?B?UnpQdU9GcS96QVJPd1ROOUt3cDJ4Y0FsaHd0ekF0QnlnUzhBSEFDUjJkNTlV?=
 =?utf-8?B?Q1dBUE5sbFlMZUh1MDIwSE1YNkV5L0JlTThhSTNzdWZ4dG81QTArblFuWmVH?=
 =?utf-8?B?SWhWdmJrRC9BNXp6OEo4OEc5NmNFNGVoRzhMckpvci9zODM5aGxxZHFSN3JD?=
 =?utf-8?B?cTVvY0xoVXRBMlFJcFNzZ3BBMnoyMExJSHhQK0l4Q0hBdCtBVlI1M3RFZWVp?=
 =?utf-8?B?YVBiV0lxUVdGWGNqd1N0a0Y5aDFpNGU1S3I3YVQrS042YXo1TE1IOGNscFBS?=
 =?utf-8?B?QVgrOHE0bWs3UDN4YW1Kemc1S1o1RXlYUzFxUEh1OUZCbytSdkNTbjRrYnhZ?=
 =?utf-8?B?RkFsL0lrSmkzNm5xQkxicWpqYlQ4M1JVRkdPSjN2RDVUYmIxVm5vUE9UWGM2?=
 =?utf-8?B?Z0NYdElnUWw5dlA5bnVsZHN4ODFBY3k2UGU5TVNNbm5sNXRxQm5ESkY4eElW?=
 =?utf-8?B?LzZLK0NBYk56RXpHRzFSL3MyYzJkODhheU9MQTRxbHhuaVN4b3RCbVduQjk0?=
 =?utf-8?B?M1h6M1YrZHB1anZ2Y2YrVzIrM3dWQjZRN3lNZUNMQlV0UzM3djB6dG9MV3BU?=
 =?utf-8?B?Y2Z5ZUd1SUVJdjg3THo5eVhwZzAwNmQ3NTl4c1dPWVNCenJPa2NnMlU3Tk1S?=
 =?utf-8?B?Yjg2YjE2MGovYmRoTkdFRHk2akpIRUJpeDFNS1BKbUw3dUI3NVBQRmRxSUFI?=
 =?utf-8?B?UU95Z0wvcUNCQVlhdU93NFliaHlEa3lvMzVjTkNBM3BGZ1pUQXVqKzRjTDdR?=
 =?utf-8?B?UGFDWkdnd0dOeXdha3UxMFRoRFJpcThVZVY1TGpzQzFGMWUxdDMzYXhKUGVG?=
 =?utf-8?B?QW8rY0lMZEhIdjRHZHk0Rm8zMHpYNVp0anlhMlBOdFQvNU5uV3RFRE13aDdX?=
 =?utf-8?B?cDNKdHRXdytkRjR4TVgzZEZMbklBMW41Y3VZSUpQdTZCcUhkRDRLT09KV09h?=
 =?utf-8?B?ZHhKVThmMzZ6bkkxVFFaQW9wSlNTTVVEdk9kWC9ZcXFRSkxNN3M2bC8vS2U3?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GLfGKr04AMV5x6XGlhgSw02MLNSp/KO1p8FErr0z/kCBDn7aXCCVrdHfOW0hSjqBuyC5S1qycsCeo0xRQwv8f0ArNofsbaVS3RkbgdcjV8gVVo5Ah85//FQQf/NITJscLKFT5uALEvztwQrthAzoVYJT/y53GKLo9Txuc38qho1hybjVzNm/6D1QpFEUxmwr8jtsfwyF/4JcR/5WY2SWZJNuAP1AJAvezGzMB2a5lAoq6U+nVXmsHEiCT0dEeXhQBjnOf/iBcHEhKRnRUpGMayh+fa116y+Fsc1r5t6yaYSou/SOXMs+/0VsY2EX3aA3usyZctR4wldQHjVXfLTJV1eUbelfZBIr9Uw21UD8hWLEcdw7FHgvVJkdkVHmNBlJUak8UP9w1IQ7h8VJzbt0fXYMd9UeJaKpF+B0OpRI8yF9SVWA4Gcvd/8LGMOFZT/z06vwNxlRkugTR0OXk6mAzzhzrgBeHIFtJXZWWVcsV864ENQ/5NxWVdWRM1IVTBaoh6EPoSVNTOljNwVpUr83vLGRwMEEKCCYroyKmEStTmq4r6xFlXUDN18/zMMDOfOCN9FFRXEtmVNTWz00tEh9elhxxtjelF8TY3btizzO+xQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ae188b-230e-4550-dae2-08de17f91ea2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 21:13:06.7837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vFyTwxxBaIkcjud7LMD0qCVs/6nUOA5LtRB//4jPZPczISgA02A6gHURQDP7u5xSymcs2CCJLfdrGqTB29MZyOpsT55OI+5qWh2mNQmdcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300179
X-Authority-Analysis: v=2.4 cv=L6cQguT8 c=1 sm=1 tr=0 ts=6903d4e7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kNeNu6tDznI5UGyEEqcA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: DC5Mf5xSWx3h2JiYxcBNZ9DILnYqfoxe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE3OSBTYWx0ZWRfX07jqC9/Uaoll
 z3RsRs9HSwERneX46MwAyj3eV+dWLwgikerhoDPko4c+9vJhh+KCSod8F2R+uHUxfYvUY21bFlp
 w951mAsEBV7RCM2fakP7bU6anaLBW6CxUoO/iWShqnXKoyWr0WRse96wEfN/rJQlaUEfcX+GOxm
 nPSo7Fw5M72/X+Uq/gwb/43jfJC86n8Ms7FU78pT/VoKgeiMlH82I4eIsSR3Y+UTgP+nwTX7+Eo
 PBP9UrlxZvhxDtQvmIfrBeyDxeeSLKWm5hbXDEsSjUWGlFvdU9lztP1b3pmgsAc2rd2WwgOtKNs
 nJc/y549ZTtD1bAuXworQa0u7NsIHU5K2ooEq0FGznfkr+ZB2Azv+e5toUs1LdRJIXUmxjV9Ue+
 XHH97LfpmMTnB1H6GMGzD77QwfDMgg==
X-Proofpoint-ORIG-GUID: DC5Mf5xSWx3h2JiYxcBNZ9DILnYqfoxe

Hi Yang,

On 10/29/25 11:03 PM, Yang Xiuwei wrote:
> From: Yang Xiuwei <yangxiuwei@kylinos.cn>
> 
> If adding the second kobject fails, drop both references to avoid sysfs
> residue and memory leak.
> 
> Fixes: e96f9268eea6 ("NFS: Make all of /sys/fs/nfs network-namespace unique")
> 
> Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
> 
> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> index 545148d42dcc..ea6e6168092b 100644
> --- a/fs/nfs/sysfs.c
> +++ b/fs/nfs/sysfs.c
> @@ -189,6 +189,7 @@ static struct nfs_netns_client *nfs_netns_client_alloc(struct kobject *parent,
>  			return p;
>  
>  		kobject_put(&p->kobject);
> +		kobject_put(&p->nfs_net_kobj);

Good catch! But I think there is still a leak here. Don't we also need
to call kfree() on 'p' in this case? And also if the first kobject_init_and_add()
call fails?

Thanks,
Anna
>  	}
>  	return NULL;
>  }


