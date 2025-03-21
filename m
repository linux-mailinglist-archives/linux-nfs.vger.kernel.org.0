Return-Path: <linux-nfs+bounces-10750-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C117A6BE5E
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 16:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549EC1893E51
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEF79461;
	Fri, 21 Mar 2025 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CYyOtHxX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hyq7Ub/0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D61CEEBE
	for <linux-nfs@vger.kernel.org>; Fri, 21 Mar 2025 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742571243; cv=fail; b=H6cgbt0JH1/SIcnT3ra3NdbOgexJvcA5/Fkh9EXA7hClUbjZjd3/aw5hJfg0TEaaFqW+7LS/WYg15UtJjlN0IOjG3I4PqI3bTaaisbw5duwjVb4AookLFIBXiV+UXzlj04g/X2FpDhnjykLJR5FZwqC406e5GUyQ3QTVcnFW/Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742571243; c=relaxed/simple;
	bh=Ch96csPRXKdJB01z0swPXktDMs4tvwXhcEi4RyHk08U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LWTDc/gtoOA/2pZvDcb6EIFDv9vkp4ZUVS/IzU/NmHCG/iHJkfTbNPu9J2qmSxKYFe3oY1X9d6l0m9wuor1shwcJVKeBzfq6+ZDUpA8hzKGsAAP5FO7ECAltiIv65bo+n8XmDc/hcDD29vdDAV44dEuOof539JyTgghDULsQH0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CYyOtHxX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hyq7Ub/0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LEBvNo010166;
	Fri, 21 Mar 2025 15:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hpRKZm3tPHsqeoVh6OQqBhd7XXM0ZZpeiHc72qPMn2E=; b=
	CYyOtHxXypNn95iz/C02ZZE+QiItSAaSpZWBM8BQ0KcJXSYNlZXzmmOTuYQknbxS
	YF8GhPkaF2UT5s3unj+X47+peqJB46O4w96lXgIYpKOOt0floe9y2KhHfdhQDdAe
	cOK8UdFUFGSjSXpZdR96sXKlg3f1zZkqijOHGUmKlN23E2tVAbDRQVYlTHg6/hzK
	4dSJj2cE9YQ/Dc3FxN6WTohrvh/6KdnXoaNbQE2dzrcU2cAjendDNUv7cFQlA4qI
	HO5amIS6Pi07aW2dskyv2J4yI75nxGpJWVl4ke+EhOZFaoQD5vp21z1qd3axpAN0
	7wmuDuAOvxdkYZacpgmwOg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1hg8qgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 15:33:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LEf7Ld022358;
	Fri, 21 Mar 2025 15:33:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxca3r17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 15:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwoLtacZOXnbuDBqYx5pprVYXAhn5ryOvTSFyf/cEgCdQWGQVQMJy85Zte9JzlskVem0jRJp4ZfkDjtw59TSFhQ7ehf7VaFh++v9uCLvhHxqZ24HGQSAAu7ttP/YXKzj23rE/Lmgl61IpQAMHIAWu3852STJtXzDFqCPhUr0rmJDdBFpgApcPyvXTNwH2S5HV8qIUeznLUuqnDq5NwGCPM3v2jOoa+CmKvNM7ktuaHineHrfn3XFoKLhKKhAMTX0xHIMJXqVPjRFzcFOnrkwJAM7zHSNBt6yICIDbxHmFta9+/8mmkEtqQSBCy/8ntR6scp+FzSM+zOWOhn+TALMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpRKZm3tPHsqeoVh6OQqBhd7XXM0ZZpeiHc72qPMn2E=;
 b=amz+hS6imMjMbn1BljW3NAS+JBGUz/3b7gxZiQZH+ijP1rBeu1dQEXucjr+j0Bz3jxSkZVHtbyFFKP+PVYfik8qlv/0JxutfOTz+N5hAznDEA1v+97gUi1OuzvsLj3eTQ9J2vcBuaIU3ftc9i9BMHG2qPVEQb16ueQ0QY+rMXT0CbwGYtqLB8slt4fSvGNQ7V0tPcyZkgpzoc8kHx61fPzmT/DkiBk2f6K8szgZoX/ATPGv60ByytDnF9uzoJbkvbjhxVogGCDTKn8/3Fjfo3iaXJMTyPaAXqAkZ2R7V/oc/Dg2Hf5uW+nYWG3suDqomSNG2IdWTDUgB/Al5ePTo2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpRKZm3tPHsqeoVh6OQqBhd7XXM0ZZpeiHc72qPMn2E=;
 b=hyq7Ub/0TTetRj692zgTqIER5JKBEdjZXCraj62JNpcTE6sxW/6M2luEzMExLnvo602X+6j1hvzQRtojQHmh4cI6VllK9D0NqCCXKsvsCGe8xMm1Jv+wH6c+63pTnhYOhr+eHv+v1l3Phj3x4apVDJyakq8cLSwTHEFJPfQteRA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 15:33:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 15:33:52 +0000
Message-ID: <2a37ba5a-f212-4456-a7c1-3f96b1148b3b@oracle.com>
Date: Fri, 21 Mar 2025 11:33:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Containerised NFS clients and teardown
To: trondmy@kernel.org, linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>
References: <cover.1742570192.git.trond.myklebust@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <cover.1742570192.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:610:33::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 95fd8dcf-b556-44db-b479-08dd688dc882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXdpTEVXQlZna0tSeWZjTlhuZG9Xb0taaS9sRHl6MlVjQUgxVXR5RjFxd3Fm?=
 =?utf-8?B?QWhTMmtvTVJKS0NydnlDNXRna2hkVjdidW5pVlVlK1F3cGhhUHBXdGlkSUFo?=
 =?utf-8?B?U2MxVGRCS3l5Zm5zcURYclVFcnFndTlrMnhGS3hVY283SGtpYWlldHE1NEJW?=
 =?utf-8?B?OTZkczBQTkhZSVdFaXJBMkRCSElOWDVhR3dpTUFuTjgwV2NyWUkyaXdtWWRs?=
 =?utf-8?B?bGI5RFllNVRjR016YzcyOG1PenNuT3Byb1RpWTI2RHFyaVA5YjhkSE85T0Mx?=
 =?utf-8?B?aDZJL2J4cUNIWXdCTkUzT1RqZ2hHMTcxRVNRaGNVaTNhQVAvQVl3VStWRS94?=
 =?utf-8?B?dlhPSE9jelFONk1HdHJCOGhvQzBtbUtxMkNsZVZFaHFvenBhaUIvQUYrbVFr?=
 =?utf-8?B?ckhqR01aczdGSGs2U3VIcEVlZkJDVlBpSG52ampVekxRWnlqRWZhOWJnR0dE?=
 =?utf-8?B?Z0RTOFRzWXBiR0dqTElVNDRnUVBPZkgyazRqeUtPWGgzTHdyRThJOUhFSGUv?=
 =?utf-8?B?RFhjWVptRG9TS29SU0s2S1A4eUpUZzB2MzJzOVpsN2hmSkZFZGpQWUo1NTB4?=
 =?utf-8?B?OGNOMzdVZ2syb3pKOE9OK3hybThGYzNtTkk5SHpzZnlObHFVaTA5c1pIeUJ6?=
 =?utf-8?B?Um9uOWRrZVB3ZTdqMERjRS9ZY3VxQlVCRWhwQVJCTGJ5MTY3M0xRYmZHbVlt?=
 =?utf-8?B?M2RyTzd6UGZGaG9MSW5aa3Q4WEpTU3gvdzhlWmtwdkY3WDF2Nlgrc0hpUnZ0?=
 =?utf-8?B?dE1nczlmdWwrSjZTemgwSVI2QjNPMjV3dnY5SC94OHU4UWVGTXlJNmhrOWsx?=
 =?utf-8?B?UTMybHhTZDhmcGFTc1R2OVR4cCtPWjhOTld6Z0lrZmVpeHNMWW03R1ZTUE9u?=
 =?utf-8?B?cU9FVStTdzlxQ3JhY3ZTNGVlZFRyTlVtQlhkVzI1WWZZRDRJMWVqdmZSUnVi?=
 =?utf-8?B?OXp2TkdkcEZ3eGNVcUJ1Y3dIT0F3NTZhRDRDN2ZYSGdYTTB1U3puaDdsNk96?=
 =?utf-8?B?MGRNSGo5YkdlcUp6dFVlcjllSzVHT2ZSTTJXdkowTWpwWHFSV1NsUTlReGs2?=
 =?utf-8?B?Q1hsUW1JcU5oT2g5V3BQK29MbndkSlQ2OVQrNk5TcHhzN1l6VjJ6ZkFtMUd1?=
 =?utf-8?B?QnhuTTFGMDVzaTJ0QjlDN0pFUzhyQlpia29JQ1gxbEdna1VJeFQrQi9DK1M0?=
 =?utf-8?B?eHZRVnBBZDRnWEN0SDJEZklobitwc0dIc2FLMVhzZHYwU0szTzFibmk2cjJR?=
 =?utf-8?B?eU5abnZkM3JhcjU2N2N2V0lwTlN5YWFUdkFwZThSQXppUWVJOERoUDRwaUZ3?=
 =?utf-8?B?Y3IweUFGSWp4N2lodERnWk80M2hqVVRRTGt6RTBnUlAyd2lodGlybk9mVWwy?=
 =?utf-8?B?aFdUWCtoUTdORlE5N2ZUMXMzWkNoVVRqSU5qYnJZamRDM1dFNHd2ZHFaNi9H?=
 =?utf-8?B?OU9meHFKR3VxdDhab3NCMGwvaklWTUtwWUlTdXBnUENxekppQ1pYeitmRmtV?=
 =?utf-8?B?dWZXeURkYTZGc0tyaEo4Qi8vdmx5ZnAzY2tmNHIrazVMVU95Rk9jdHBvMmQ0?=
 =?utf-8?B?TnJlMmFwa3laS3o3TFMwUWN2Qjd1dUsxYWJuQ2hENDlEek5VQU44NFZ5UlpE?=
 =?utf-8?B?amVaQlg5MjFhQ0wxNFYyWEhOZGRzMFhHUThqaGhOQlIrZW14bjl4RjNDcURZ?=
 =?utf-8?B?ejhSbC9WbTdyMGg5dVptWjNRTldsekRjOE9iTXhOYmUzamo3OE55QjVxYmJT?=
 =?utf-8?B?aFNtKzlkWEY2T0xRbHlKSEtxSXg1ZlQzUjcvRlJYNGJyZ2g4RVp0dU9jc1F4?=
 =?utf-8?B?aWl2aGphWHFpUUhTa1FhMWg4N1ZmZ0Z4U25aZlMrYzFEYWVRUlNFcC9KN29O?=
 =?utf-8?Q?1PvP+FiD6zcr6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFVrM1dIemxYaE1kQ0dva1NRTFVtL2NObkIrYnlsK29aZFdrdW5xWnlhYzJt?=
 =?utf-8?B?YnBLTENvYk1qSDJmZyt4Q0RjK0xFNXNVZy9lazVwdk5RdXI2dEN2b3lEMXFz?=
 =?utf-8?B?L0NVSEVrM2hjcnZ2R3R6NnJpOUNGcmoyYUdreDdFQmNvdHkyK3ppOVUyQUVP?=
 =?utf-8?B?N0crSkRHcjZIZG15SHNGNjVidnoxK2h3YkNpRHNYNjNqdXo1NVZkbEl4dFlE?=
 =?utf-8?B?WmN6eWFIemk3QXdPMHB6ZlE5TCs0M29CQXBEdGNNM2VWMmxKYS9KN3VuY3VS?=
 =?utf-8?B?U3NRV3F2V2ZtVUJ6b0J1SWJWRDgzUlZZNU02ZXk0UHNqT1V4TlpGT3FZcXdZ?=
 =?utf-8?B?V1ZxaXVxUkVUbXlwcmJUR3FSdkh0eVBzRHB6bnVMS0h3ZldVTWpQY281ZHNa?=
 =?utf-8?B?Qnp1NEd1MGFXK1ZJeUcwa0doaFhBVnNZVGR6cnN0cHY0WnI2NlVMdEdjT05W?=
 =?utf-8?B?WW5laGNGOHJ1b0Erd0F4ZGlnem9tYXdRbjg0aTBXVUhjRHhBcFhFTmFrdlQ5?=
 =?utf-8?B?MmorQ3UyOTNNczdLeUdvZlR2V3dRNEpXczJOQmdKbnZra1IybWR6QUZMU0s5?=
 =?utf-8?B?UHpOWEZBZE1qZFpDOHhCQzgwQmJNNGVnVERYTVZ1UnRWRnU4RldEZUFHd0ZE?=
 =?utf-8?B?NDJZeStIS0FSUFBQd1VDaGRMQTJlWVUweWdITVYwaldmT0JDaFlBWnNpV1hR?=
 =?utf-8?B?b3h5OVFuRks3THJyWWNkcGNncytXd3lrRFl3WllJY0liV1JoVHZLTlZNc3o0?=
 =?utf-8?B?azFkaUJVOFJEZXNDRGdrOS9zWSt1OFNvT0lBVFVtb050eWwya2ZPVVpWejBO?=
 =?utf-8?B?YjJKRjlLcGNPU1loZGFQb2orb3BNekpzWG9qZ2FFWE5sMGsyWGprSi92aXd2?=
 =?utf-8?B?WjNPa1VwbjNQUXVLSTBNcDVIVlY2R2w4RUk2TVNzNW9mZUsyRHlaUjlGZEFF?=
 =?utf-8?B?dmdVTko2N3VkSWpqb1VISE0yTWpIOEoxWnJxUVJQcXhCQzE1NzBmTGlkSHZm?=
 =?utf-8?B?djB4TjlnUm5lZ1lNS2hnMzFDZ0dIVm00S3JNcno2M0FpNjl5RVc4WkppbGha?=
 =?utf-8?B?azlyNmVodkVGaUJGekt4dERmOGtSMU53NzFxdi9adko1NGlsWjA4TE80U09E?=
 =?utf-8?B?ZUJmN0s4YmRyVGpkeFJhcWNSbUhyY3pIa3RtQ2xoWUFaRFZwem4zR0V2Sy93?=
 =?utf-8?B?Z0dpdXlnSEFLWGJWbXdNZWVuR2tjdkNzK09ZRjFpL3dMMmlWcmsxRk1kdXZl?=
 =?utf-8?B?bU4wY0hzSHFYWW5UeGFITzFyNUhTa1kvR1VBcE43WlZlYXMrOG5MOWxmZXZ5?=
 =?utf-8?B?M05oMGxYUEpTNS9QSC9aVE5KSFFCQnU1UXV0akRtVklJc1ljMVBxV1VkNXQ2?=
 =?utf-8?B?N3NkS2JaY0tnRUp4YTY3dmhZUVI2WVE0R2lnZVovaGIxMDVBd01ZUFJzd2cw?=
 =?utf-8?B?TmpoWGlmVGhQdVcycWhNbVl6dm5mMHRmVkZqQlhnTE5CN0dnRlE1YmlQb3Rx?=
 =?utf-8?B?WUgzRy9zWEh0dzFCbU8wRE8vaHd2bytvVmpVakFGeG5lWTM1Q0lVNlBGdXlq?=
 =?utf-8?B?YzZlK09mdU4vZHZVei9sR0ZUUXhqTlBVZjNTWlFLSVNMTFBmU1EzRzVIVi9Y?=
 =?utf-8?B?QkUyd2pLZkRBNlBSczIvWUY4Ykd5ODdEUXdDOUFwQVpMdmMrQ1J0am0vUTBz?=
 =?utf-8?B?N3hnaHJoVlpialphYVBhS2NRekgvOVRxKzR5OXJlQ1ZlUW9UcVN2Q3VWTnlu?=
 =?utf-8?B?NGdBMFZBMUZPRzlVMFArZHo1aCtSUnY2T1FwdnZwQjU2elNoY29valM1bG1X?=
 =?utf-8?B?Ync0M2QySmVybEloWUxiSjgvY1c5MmVNT01WNGRoYldOR0Y1U0dJb1U5aFZu?=
 =?utf-8?B?bXVLOERzN2FxWEJGeXpiLzdibFlFRUYrdExMVEh1eVdmMHRwU3hhRGkrcEV5?=
 =?utf-8?B?TklpU2llYXpvY01KSlc2NkF4bE5JUCtLZXNUQXBQRDdMUnBjTmFaelZrREUz?=
 =?utf-8?B?NzhtVldQR2QwUUlNL0R2a0gvL0lWVXZFKytzMkYybk15VklYRkx4OHVHdnBP?=
 =?utf-8?B?VzN1MUlPWlNkSjhmdERZYW92Tkp6MTVranY3anRweDJFeGV4KzEwV2RFT3M3?=
 =?utf-8?B?TWZsYTFHcGZZNmZFaXJuajRNMDdFRUNYQTBQN1BDcUVHVVJNblAzeEpTa0R3?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yk9rEqblEMd/deypU3WZs92Ge1H6ItG5IV//WRlxFKj2FKKKZdeFZRshHY+BuXPH2nXdU79J1RCndCZXuU9/Z+0/r3MADC+HFeSGAuw/S96AwDK73uXGlQTNHE3RbSBanKdK9NOQRsaicVvw2H5WdmFdMhMhD2ezquKrSUZeQOj4t1UltsRamf289Qg3Z1zFp/TdUTcKr1NOw4BmTuzrkHhkgRZgZvctSl1Aen5mCGBHha/pZFIyHrwGiJrk3lU4ryW8psFkVCtIL0jw5h6d6MDpJOmkUzI/+QpDTtsptPmZiLiXbGt26C/z9hlJi7RSu94ax7tS6T4e0NHa5W57O5PXjX8216ziHINMtik6L+oWRasNG6XVLPunjYG6f4rID7PVdFvitkzauIllQ9IUbq/u1L513JuKqA/6Yg/wP6M+SDHrZ5eWfxDuu9Vbv6Ny6B5kgIjy8X2yB/xhAXKbGeMkA2L+hrfO/kwNdmedqdAZvPRSkvzK6QGT828IKpPYVqtrEDP0EKotrstI6dOVkcSkLywq5kgu8sMDcJZwhtqXXErd4npDTCMoWucAbfisUdb4ydQVxPkN+GpSqZ/2c3KpuDqQ952tXL7DTS0g4gE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fd8dcf-b556-44db-b479-08dd688dc882
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 15:33:52.1578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zemqUpmVpmgKDUB6f+WIcr8ZslF/EVpVzDNF37/3usJJZSbNrycfxlrsCStuq0rTaaPqr4koDrfsUEb3xAs+Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503210114
X-Proofpoint-GUID: Q29gYhHLuKsXlAyJfzYmIV3ng_UnjnRY
X-Proofpoint-ORIG-GUID: Q29gYhHLuKsXlAyJfzYmIV3ng_UnjnRY

On 3/21/25 11:21 AM, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> When a NFS client is started from inside a container, it is often not
> possible to ensure a safe shutdown and flush of the data before the
> container orchestrator steps in to tear down the network. Typically,
> what can happen is that the orchestrator triggers a lazy umount of the
> mounted filesystems, then proceeds to delete virtual network device
> links, bridges, NAT configurations, etc.
> 
> Once that happens, it may be impossible to reach into the container to
> perform any further shutdown actions on the NFS client.
> 
> This patchset proposes to allow the client to deal with these situations
> by treating the two errors ENETDOWN  and ENETUNREACH as being fatal.
> The intention is to then allow the I/O queue to drain, and any remaining
> RPC calls to error out, so that the lazy umounts can complete the
> shutdown process.
> 
> In order to do so, a new mount option "fatal_neterrors" is introduced,
> which can take the values "default", "none" and "ENETDOWN:ENETUNREACH".
> The value "none" forces the existing behaviour, whereby hard mounts are
> unaffected by the ENETDOWN and ENETUNREACH errors.
> The value "ENETDOWN:ENETUNREACH" forces ENETDOWN and ENETUNREACH errors
> to always be fatal.
> If the user does not specify the "fatal_neterrors" option, or uses the
> value "default", then ENETDOWN and ENETUNREACH will be fatal if the
> mount was started from inside a network namespace that is not
> "init_net", and otherwise not.
> 
> The expectation is that users will normally not need to set this option,
> unless they are running inside a container, and want to prevent ENETDOWN
> and ENETUNREACH from being fatal by setting "-ofatal_neterrors=none".
> 
> ---
> v2:
> - Fix NFSv4 client cl_flag initialisation
> - Add RPC task flag trace decoding
> v3:
> - Fix a copy/paste error in nfs4_set_client() (Thanks, Jeff Layton!)
> - Fix the mount option name to be "fatal_neterrors".
> - Capitalise ENETDOWN and ENETUNREACH in the fatal_neterrors parameter
>   list to make it more obvious this refers to the POSIX networking
>   errors.
> - Always display the "fatal_neterrors" setting in /proc/mounts
> 
> Trond Myklebust (4):
>   NFS: Add a mount option to make ENETUNREACH errors fatal
>   NFS: Treat ENETUNREACH errors as fatal in containers
>   pNFS/flexfiles: Treat ENETUNREACH errors as fatal in containers
>   pNFS/flexfiles: Report ENETDOWN as a connection error
> 
>  fs/nfs/client.c                        |  5 ++++
>  fs/nfs/flexfilelayout/flexfilelayout.c | 24 ++++++++++++++--
>  fs/nfs/fs_context.c                    | 39 ++++++++++++++++++++++++++
>  fs/nfs/nfs3client.c                    |  2 ++
>  fs/nfs/nfs4client.c                    |  7 +++++
>  fs/nfs/nfs4proc.c                      |  3 ++
>  fs/nfs/super.c                         |  3 ++
>  include/linux/nfs4.h                   |  1 +
>  include/linux/nfs_fs_sb.h              |  2 ++
>  include/linux/sunrpc/clnt.h            |  5 +++-
>  include/linux/sunrpc/sched.h           |  1 +
>  include/trace/events/sunrpc.h          |  1 +
>  net/sunrpc/clnt.c                      | 30 ++++++++++++++------
>  13 files changed, 112 insertions(+), 11 deletions(-)
> 

As my UK colleagues say, I'm extremely chuffed to see this feature!

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

