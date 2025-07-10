Return-Path: <linux-nfs+bounces-12993-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E962B00F01
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jul 2025 00:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E298264274F
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 22:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09E82356C3;
	Thu, 10 Jul 2025 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O4ILDoaf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GqdAN5G7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A132236F4
	for <linux-nfs@vger.kernel.org>; Thu, 10 Jul 2025 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187622; cv=fail; b=SMPQ0ft7YCPRgQd9hXQnW/ZKX/VYtRQYdsrwj32vJxu4phquRGpegbIUG8eJ3bHy21uX85b104UPly2Ty3IX9lV7N/p7i6sEyd/BG8J805Za0MU20Og+exCsRXu+xWtnbXto5woRt3PzZhhLAfh9VJDhj4tvd73Wyg7Unco8dJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187622; c=relaxed/simple;
	bh=GUCoAXF9KRSX7nBugQ0fVRISjtMvQg+/6UOFS4IEtgg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sdl5vZjqNRpNVxrbgqWS5HDJyVYrd9cxva5kbooMQfrglSNRQt1ZppcS7QJLRvnMxlivuwgcf0cKyY6touvaMXELu7n1AtTB9qvuceGHUcYJqbcT5A4t4V4qRhHXmv89IRchazuj5IVMwGtGv/RY4teVOsOLqmadGaeFbJIcMG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O4ILDoaf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GqdAN5G7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AMgKhD003509;
	Thu, 10 Jul 2025 22:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wf1RKIIdZQc5AnGNR9pHhxRiXOVmf6HykDoDMXY5k+o=; b=
	O4ILDoafSI14jv3zLQQVmk99oNpes8j+Um5FX4AfyJELzOdo0lF5/oVO75hsu9ls
	ojJpN7qHaP9/Dt4KAHNtupZ2xJMxs8D1xX7ph2NkzwlafoZk8xbaRJoT20pusI6G
	VuS9LDe8TcUfwbVH5RcQRivBuGj4mAwU1Po4xQhXCc23sF0K8v01AElR1G9MJxsM
	1W9UTOBCADop/Vs2Pya+uA492pKF/DNNgwqKins9SHkR6v1glz420HsubDOEkVZW
	ava5W2+JNv2hLn6jSt+MsIRtZByMDr7dgbPd0xoIlmJqpNlZ5bfOXwjaFeRxDJI0
	c6WMnuqDaa//nuhpKl4bGA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tphr805m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 22:46:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AKDY2h014001;
	Thu, 10 Jul 2025 22:46:45 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcw6su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 22:46:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9pLshqbq7UA1yis7EK9MDILJpX97c8bCrGuAFxBYfA/mIyhy9/wNt4MnNEqjzNBoN/1SW4PMgQZtqzJXgivtQKioDFP95JStpIGcfD1axf1qYIXY3BRGYpi6J/Ednhd+/B+IX/8oV8RWOa8viQwzJ7I5TYzZyeG5WPvLXrYwRPb/O5Osco/QvZhZ+p8HfFh/Kwz0k6Ui9EHGFVhQl6raB4j6LhHyXDzWHM5msYQXg7obnXUc7arCYxYma8rGzWv8PqA6vXz91V7WLdr1E0IsS2iLBxyp7TWRDy9qWrVNf+5osOqjyYljfirKe8q9XJV7WL7SSWlfWsE0S+AzUU2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf1RKIIdZQc5AnGNR9pHhxRiXOVmf6HykDoDMXY5k+o=;
 b=rXfHKtXim6gzS8wOS0ikclcEVGyFOdymfJogmtpTi1CLxjSAcs4AsDqbgPiN4EKN3BzX8y6Ue19NDJoa5VxwR7GVvFnhhvi64MFsBbbTlA0xnSbC/eKv91H+9+zjZlKa/KG5hhCRVE6CNWFcaSYdWQJH+dlX0xO3AeL+iCZ4Z7ZOYjz/tDk4DZT7F0GEVo31lg6v0Od6Xqs/3MqH6VayG+VXf9DziefQi6KfBcYFBCvwQX7Z1WiguOsbYYxiec0xOFjmxda3fw6cHnhBBNHWH58P4GDgCpYnFhns2ybaMYlZ0bItQ8d8JCGo0EAVnaOCUFK45juZtCLVDApN5chGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf1RKIIdZQc5AnGNR9pHhxRiXOVmf6HykDoDMXY5k+o=;
 b=GqdAN5G7aPGfIMWijHyT/SxUPl/W5coZYd8g+x6sVCbEAgaZAdUOUmHbEPT7j1ZU8JJc9x5WLiHPeQO9y74oW4E4Dom4j0zbbG2hl2E6cWGjBAMWtRascES3eulhLdyjq92I7wkDaEQgW9ioq1BhWDsqDDKP/gNOfy4p07LAMO8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7170.namprd10.prod.outlook.com (2603:10b6:930:74::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.31; Thu, 10 Jul
 2025 22:46:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Thu, 10 Jul 2025
 22:46:40 +0000
Message-ID: <6a05d14f-dbf6-4786-ba08-c57f8f4c64e6@oracle.com>
Date: Thu, 10 Jul 2025 18:46:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 6/8] NFSD: add io_cache_read controls to debugfs
 interface
To: Jeff Layton <jlayton@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linus-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-7-snitzer@kernel.org>
 <e5a0d1e435196c55acbdc491b43b6380cbef5599.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <e5a0d1e435196c55acbdc491b43b6380cbef5599.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:208:32f::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 52452bf5-dfdd-4ee5-4aa8-08ddc003a288
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SDRKbTJwRlVNWWVFSEpaZFZxNGVUL2lzY1lISzB3QmI2aVFlQmw4dWs4Z3lw?=
 =?utf-8?B?c3NxM1h5clRjYjh5Uy90VVc3Q0M2NXREVk1GZHp4M2NQRWJFL0RKTDBTbFFV?=
 =?utf-8?B?ZWtQRStJNGJ5QUlQeGNQbHlwclEvUm14dDA4dTVuZ1FIT25Nb084OVdDR1NW?=
 =?utf-8?B?WWJmYjc4RncvTHcyWWo4bUZScW53U3pnVEFjelJXdmhJSE5oeVkwUFhyc2Jy?=
 =?utf-8?B?bElpaXk0WFp5cFhZRGRnOFZKSlFIcFBFZEp2VEh1R0ZwMnpRc1VKZDMzSitF?=
 =?utf-8?B?NGE5d0Erd09qK2dnY1RjcDV1R3IxKzdpZ3JlNEl2eGZFTSs3NVJ4N0JrMjVO?=
 =?utf-8?B?L3BmOFd4azZiaUswbUt1TUtjNTNJWCsyZVVQbnlRNFdBWlhCcTZpUjBkSzZ6?=
 =?utf-8?B?K0w3cEdFUWorTFhpTHFtbXdwWTROUk1nVDZsQmQ5YitXeW4xazgwNHBCaGZC?=
 =?utf-8?B?bDZhYUR5STIxN0RKcVZpeWUvV2QrOHdyQTdRWkZuS29KcE44KzJnZzJhWXhn?=
 =?utf-8?B?eDROcFlIVFo2UVJhQWdROEJ5L0FuZnhod1RURUw2bnlrdnBabFFxTldZVDVV?=
 =?utf-8?B?NlhvVldkZWNrQnlhN053ZHltS1RxeHRFTEI1YkgwMEl5V3l3UDhSYTd5ZHZ1?=
 =?utf-8?B?TGkrSWprQ3dhT3JLRXlLUGNKbHFFamhUeGIvYVVKUEluYlJPZnA0dTlXVlpi?=
 =?utf-8?B?S0xYa1g2S2Q3azdDQUVwRFVxMWZ4aFk0NmRKN0NWVSs1cmFkZ3QvaG5DK2xC?=
 =?utf-8?B?ZWpUdzBoWjgyNS8xU2JXRXNZSmRNMzBHK2JHSUFRNjdaMHQ2U1JqNDA4SUY2?=
 =?utf-8?B?cCtKOEI1MWpFdGNRekw2bDB1aVBITm9wcHhoRWFxVTREeHBrWXJVWTNLRTQz?=
 =?utf-8?B?QW1qV2l4b3Z5YU5lYlVpS2phalp4MjNxMjloWGpxUC94R0lmQ3FUVVpJWlRw?=
 =?utf-8?B?enhOMHJ3Y3BIWDFnQTBIOFlwaDlGZWd3K08wM09XNWJKcEVuSFdKMENwUlB0?=
 =?utf-8?B?V3Q0OTNwc3ZKejNuYkI0TEM3MktSSit0WXozZ2ZIRE1rajluR09QWVlkVW5B?=
 =?utf-8?B?SytkeTc2STNoaFByalRjclJWZENaRzlYclFDTXB4OUs0ek9iNkdSTlJlL0Zi?=
 =?utf-8?B?NS95VENHcEp4cW5LVG1CeDJmMklVeGZESHI3cmxCMTAyNityY21UZUc0bGRr?=
 =?utf-8?B?Q3pkaHZYSTJyd2drOTVLd0wyN3JWdmhFMlpCRWp5c3RrNFVIZFN3alA0VVho?=
 =?utf-8?B?NEhBUktGVG9LNkMxMEdpNUFUTjNHNUZNbXdyNEZtRTdZQ0hlOEdOYTdlUi9z?=
 =?utf-8?B?c3BsRTR4ckFUVjl2U1pqbkNOTTRPcncwQkYwZ0RtL1J4UTNYZjBxaUx6aHQ3?=
 =?utf-8?B?bEpUeWFnZnMwTFhQYWRDekJKYXd5cUJsZG4rVXlQNzltOE9OVkpERUs3R1du?=
 =?utf-8?B?QXRlcGJ5QkZDN3BxVEN3ZHRvanBFRHRXSHhrc25TUHVLQjVjOHcxZlpRRE5i?=
 =?utf-8?B?dFEyVHovUEhXSkoyb3VoMGtXdWhRT0QrK2JQZWZ3SnljaGdUSFc3aFJWRzYv?=
 =?utf-8?B?MjAvQnRrTkRGeFEwUFNLa1hPSGpFempuRjlMazk4d05saXc1R1B2bUpaMUgr?=
 =?utf-8?B?cGhCOUhjb0lUR3JySWdrdWNOQkdCYmZESlJEOXkyYkZuTm5PUHgwMkV0Ungz?=
 =?utf-8?B?QnBmVDlreDJLSjI4ZjdpTFg2d3FuMFJMOVdKdnhMdTBpZGFPbTZUY2M4OEtF?=
 =?utf-8?B?ZHBVQkdSRTB2Z09xUVl0NGFjemJLcVRwZk90d0txd2xWL3duRUxzc3hIcm1I?=
 =?utf-8?B?Q1M4TlhMZzkvRStrUGdDZnlrbDFMN3FIK3ZWdURra0tuYTJDZEJicy9QejB5?=
 =?utf-8?B?N0JDZk9mRHpWL0hXTmZhSFYzOUhjMHdMaWFEeEJzeWlsYTFuYnEwTzZSRzdw?=
 =?utf-8?Q?ehTlQHD5PBw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MWJWWXV2bXcyU25BZThQVStwM3prUHEyQkdEd09ubE5zYVFyc2FhQ21QUU9H?=
 =?utf-8?B?YnJWSmJMdFlReWFmTDd4K0hqNUFyRWhIdWg3RTM2L0dCL1FYZmtjMWowRjI2?=
 =?utf-8?B?dFlncHk1cEt4dUwyWkg5WFN6OTlQaWxuNnM3Zno1OWpHb1l4djNxbzk3VDNW?=
 =?utf-8?B?VHRVS3diZkpvTEsvNEF2MXd5dFZVL2xORWVQTjh5MTd0VDdIenUyWUJqZ2gz?=
 =?utf-8?B?bi95NnZyam5xcHRXcFNOOEdEK2lqTFo0bkFycjZ4NU1vNFFVaEc2SHZMTm9z?=
 =?utf-8?B?Tkxtdjhkeml6Um10aDlhazNmWHc4OHRGN0tPTmtMb3VpbEVUSElxWStNNHVZ?=
 =?utf-8?B?Y2RxUnllaENKcWFYZVFtL2t0bEFqTWZKMjhDZVNUSFRHOEV5SWNMR2VBeGFU?=
 =?utf-8?B?MUFaYUUzblQwZ1lZeHZEa3NOR0lyVEh2bGxzYk85dGJQVE1zRVE2NDZubmxj?=
 =?utf-8?B?aVFzaitpV09sUzVVREo2WHZ0SmNHdURDakFIVTY5blRSRVZDODdTMGdjTzIy?=
 =?utf-8?B?b0hCdXlHamlTaGFUK2swMmd2VkRMOXhyMDNVNVpKR3FNWHVhd3E3bGZJWWt2?=
 =?utf-8?B?ZzlURXVCS1NsRWgwamZBazBvNThYVFJ0VkFCczM2ZTlBTnJ0NDJWeHZzYi9B?=
 =?utf-8?B?SWFSWTlneEhzQjlHbnlBVGk5WG1mN3BUZmZPNXdFTHR5aUVJSCtuSERtRDls?=
 =?utf-8?B?VXZqeldNZzBlWlcvZkxwaDhaMTR5L3hoUjN4OFpLRDRhdVJVd1pxVEtQNU5j?=
 =?utf-8?B?cFJsNWhsZkVBZE50NzBPanVlRUVxRlptSmVMNXl6QWhyVmNldlJmSEFabXE1?=
 =?utf-8?B?SW1teVR2U1M0V3R4Q204V0NBOUtLbXgya08vcThhVVgzdXNRVWpDWWdOY1pm?=
 =?utf-8?B?Z09pWHU3R1RGa1kwMXZ5QURFTlc4cHpwTmV6cGRZSE5kbUI3MzRxenNhWGRT?=
 =?utf-8?B?aHpBQjAzdkpDZ0pVeTZURkl4bXgwNFIzeFRCMWlveE9xMWZkOWtESUt3L21n?=
 =?utf-8?B?dEJYNXhaaUNpS0llWjBVZFFBVWFQNFJJWE1ZOE9rVmJKTWlYS1JpTjgxVGhK?=
 =?utf-8?B?TlIzaG5kLzNSTzE2UVRtRUl1MDZnWHFNeGZDZUtudER4djhjb1dRbFo1dDZV?=
 =?utf-8?B?QzBIcUVWQ2VMUkMwMElkdURFQmZxZUp4SENYWXlCUEZqbzFyejMrWFM0R2dU?=
 =?utf-8?B?MHZ3ZXlBVE5MU3dhTE43bnN5bGYwazg2aHo3R3lVWXlVQlZFL1FMNk13Q1d0?=
 =?utf-8?B?ak9TcVdxS0ZzZ3JjVFN6V3lXc0Z0OVdGd0YzOXl2d3grQVIrQkVNYmV3d1dQ?=
 =?utf-8?B?RlcwWEEwbjEwTmlROVVVeUpPcm1PcnJRUGRTenEwWnZuOFBrT054V1ljRjNw?=
 =?utf-8?B?NzFhcGQyT0RuTWU3aGczUmordXlHR3ZjY2RQNkQwNXpWWkJoOHlGK3RjNzFq?=
 =?utf-8?B?UTRUdWU5UGRDN2puWjFDaGJxSEtVS0VIYzBQV1cvQm10ajNZK1YrU3ZKK2Nt?=
 =?utf-8?B?d0NMcWQrQWFXaEY1NTMzVm5zUjl6VG9qaUQwMk91YXJFVTVlclhjazd6MVhq?=
 =?utf-8?B?TjJKdzdYempBM0R4QzVyZzhiRDBZMHVHQW5EdFdoUHVhVE9GOWtzT1pEOUZp?=
 =?utf-8?B?VmdOTkc5VFRGRUFRdW9yNUlwOUNDTjN3dVJ1VUdLS2xlcmZ0YjE2RVFKMlQz?=
 =?utf-8?B?M2lobUlXWHhMWVVyZk5GMXpDQkwvR1J6YUNGTm1DaEJKUER2ci9lQm5rNFRZ?=
 =?utf-8?B?SHplRW9ackREVkN3VHQ5bDFub3ZBa3JRTmFIbVVaNFVxOGNWUVNocDdtSEtZ?=
 =?utf-8?B?MVNzWVpTOEI5SGlobW45RVU5Vm0vQlVHbThlblphTmQxcS9GVFIxenR6aWYv?=
 =?utf-8?B?T1lzSlJ3b2JrQm9DaWJ5c25xdVovdFJKNUw3VzRWeGdIR3ZBdEQ3SUQ5bmYw?=
 =?utf-8?B?MUFVMDJiSmorczlFZWlOL213aXE3LzdkUDc2UW5iNTNtZnViZElONHlZV05V?=
 =?utf-8?B?RncrclpkNWU5dGFsc1RUK1NFWGJCcGlBSnBlOHBKcGhIOEhmQnVRY3V1U1Rx?=
 =?utf-8?B?QjBiT0gzK3ZLQlJzbmd5emo4R2Q1SEkzN01JdjhVVDFuTlArOStMMVl5MW53?=
 =?utf-8?B?Z2JJZVlRRGxjT3hJUWpGRUY4K2cranZseGw2ZGoyTWc5VXQwRWV2N0xvZnJj?=
 =?utf-8?Q?PfQGOCv9BXB3CyJa6tSdUMCt/otPvW+Tu944+BBDYTkx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Dvt37T8hsfopKnPaTm2JjnkMxiEiNAjh0cZ3mHFDHBJJF6WUu30PhK05eHrQZcBYVNHkeH7RkMBczsZEXVSEEnPDa8cVShtZmML5KK1QM2exklyJOdHpg9sqqGZNTiE851HsZjg/nnnXMLmjPlY392zAjbSL3DwhIPBz0ZrsTisvFklgQ1FyoaluLIAr9DYVUK0eW5GtHtipcnx+8+GOja6QaV1EWE7RhPHsdm3LZz04u1LJYgwu/o8q/tDsIpXerf6pyNKLQK6bUHknwVyJAqvV3wYIEDdEKfYXAv//V3HfVXozAxqcvXmHdI9/mfcUYJbfN7JwaZoGEHu34j6nG7A2XlqDpbwrap7739Ku2AX3mZ1GpCbMZzwCA/6cMMMH7au8owwQpGa3kdFZVFaiWk/Mow8Ca6XRXcEkEUenv4SDh18U7y1qIZoToN0tls6KaBxk/5TWZl5/jM9SzTNpg+1ahpGytAO/1lY/HfB4tLAMKxjcDOUBtCQ0a2RpGT1iyep5x6plQF3kkYB2vOMYi6KpJ6joTIr/mLKvECYDGpkZByCzLeZcZ0hqu9VA91QBCeMa3z1N5sFQe2QMv2OcxKC20lxrzHVDqxbhqC2It/U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52452bf5-dfdd-4ee5-4aa8-08ddc003a288
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 22:46:40.3646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1AKLGmDtqwYhfia+xRc8TMxtWrUp6xsBGat2EHov9jMZVXWh0C9VyoCKtN9SP+NRzIBIFK7zxpUn0nsL3nueg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507100190
X-Authority-Analysis: v=2.4 cv=Vbn3PEp9 c=1 sm=1 tr=0 ts=687042d6 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=q8w6lXZ6CtyyEe9I39oA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12062
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE5MSBTYWx0ZWRfX48lxWNDAQFyC rPN/qBCUKAh6TzFKVyOwHZZ2URaoB63NQNg+6gJ4Vj+QnKkYVm3t5S5ofGiz0r7NvRSy6JU4THY BrXw8xgIL3d+6yXfJCoAh7QM2cFxbsDgs1KF9oWjxAdO3I3W1o0ANX5E4E5IWKU+Sdj8R6iZ5ub
 O889Y7VRMN1oQyUuk0PnM8S8SJ9W6xyUIXY6J2CaWsmL4lwk+BABs3KlPJdshKBDec+hajeV0gA aFOFiC15r30PzUjm98sPMjt8ISqW6i3r+v8NUD1Vg6111vnEJj94vVdeS1PmzkFfU4JJ8YXbqiv fzeclpawvnll4VZ9Mp0p5l627va3oIVWUPk7daC4y2LddI97NllsPAnXlQNK7jzHWnujw74Oc2r
 RP7j20THDiQG76wIkd8xUpes/mYH+4sA5E7VDF4mESWFNJHj1bjAJ/cb255srdSRhf1zoF4x
X-Proofpoint-GUID: MIHFnoTIP3zroEdJfQdUEbweY7ZGrO_7
X-Proofpoint-ORIG-GUID: MIHFnoTIP3zroEdJfQdUEbweY7ZGrO_7

On 7/10/25 10:06 AM, Jeff Layton wrote:
> On Tue, 2025-07-08 at 12:06 -0400, Mike Snitzer wrote:
>> Add 'io_cache_read' to NFSD's debugfs interface so that: Any data
>> read by NFSD will either be:
>> - cached using page cache (NFSD_IO_BUFFERED=0)
>> - cached but removed from the page cache upon completion
>>   (NFSD_IO_DONTCACHE=1).
>> - not cached (NFSD_IO_DIRECT=2)
>>
>> io_cache_read is 0 by default.  It may be set by writing to:
>>   /sys/kernel/debug/nfsd/io_cache_read
>>
>> If NFSD_IO_DONTCACHE is specified using 1, FOP_DONTCACHE must be
>> advertised as supported by the underlying filesystem (e.g. XFS),
>> otherwise all IO flagged with RWF_DONTCACHE will fail with
>> -EOPNOTSUPP.
>>
>> If NFSD_IO_DIRECT is specified using 2, the IO must be aligned
>> relative to the underlying block device's logical_block_size. Also the
>> memory buffer used to store the read must be aligned relative to the
>> underlying block device's dma_alignment.
>>
>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>> ---
>>  fs/nfsd/debugfs.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
>>  fs/nfsd/nfsd.h    |  8 +++++++
>>  fs/nfsd/vfs.c     | 15 ++++++++++++++
>>  3 files changed, 76 insertions(+)
>>
>> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
>> index 84b0c8b559dc..709646af797a 100644
>> --- a/fs/nfsd/debugfs.c
>> +++ b/fs/nfsd/debugfs.c
>> @@ -27,11 +27,61 @@ static int nfsd_dsr_get(void *data, u64 *val)
>>  static int nfsd_dsr_set(void *data, u64 val)
>>  {
>>  	nfsd_disable_splice_read = (val > 0) ? true : false;
>> +	if (!nfsd_disable_splice_read) {
>> +		/*
>> +		 * Cannot use NFSD_IO_DONTCACHE or NFSD_IO_DIRECT
>> +		 * if splice_read is enabled.
>> +		 */
>> +		nfsd_io_cache_read = NFSD_IO_BUFFERED;
>> +	}
>>  	return 0;
>>  }
>>  
>>  DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
>>  
>> +/*
>> + * /sys/kernel/debug/nfsd/io_cache_read
>> + *
>> + * Contents:
>> + *   %0: NFS READ will use buffered IO (default)
>> + *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
>> + *   %2: NFS READ will use direct IO
>> + *
>> + * The default value of this setting is zero (buffered IO is
>> + * used). This setting takes immediate effect for all NFS
>> + * versions, all exports, and in all NFSD net namespaces.
>> + */
>> +
> 
> Could we switch this to use a string instead? Maybe
> buffered/dontcache/direct ?

That thought occurred to me too, since it would make the API a little
more self-documenting, and might be a harbinger of what a future
export option might look like.


>> +static int nfsd_io_cache_read_get(void *data, u64 *val)
>> +{
>> +	*val = nfsd_io_cache_read;
>> +	return 0;
>> +}
>> +
>> +static int nfsd_io_cache_read_set(void *data, u64 val)
>> +{
>> +	switch (val) {
>> +	case NFSD_IO_DONTCACHE:
>> +	case NFSD_IO_DIRECT:
>> +		/*
>> +		 * Must disable splice_read when enabling
>> +		 * NFSD_IO_DONTCACHE or NFSD_IO_DIRECT.
>> +		 */
>> +		nfsd_disable_splice_read = true;
>> +		nfsd_io_cache_read = val;
>> +		break;
>> +	case NFSD_IO_BUFFERED:
>> +	default:
>> +		nfsd_io_cache_read = NFSD_IO_BUFFERED;
>> +		break;
> 
> I think the default case should leave nfsd_io_cache_read alone and
> return an error. If we add new values later, and someone tries to use
> them on an old kernel, it's better to make that attempt error out.
> 
> Ditto for the write side controls.

+1 on both accounts.


>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
>> +			 nfsd_io_cache_read_set, "%llu\n");
>> +
>>  void nfsd_debugfs_exit(void)
>>  {
>>  	debugfs_remove_recursive(nfsd_top_dir);
>> @@ -44,4 +94,7 @@ void nfsd_debugfs_init(void)
>>  
>>  	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
>>  			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
>> +
>> +	debugfs_create_file("io_cache_read", S_IWUSR | S_IRUGO,
>> +			    nfsd_top_dir, NULL, &nfsd_io_cache_read_fops);
>>  }
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 1cd0bed57bc2..4740567f4e7e 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -153,6 +153,14 @@ static inline void nfsd_debugfs_exit(void) {}
>>  
>>  extern bool nfsd_disable_splice_read __read_mostly;
>>  
>> +enum {
>> +	NFSD_IO_BUFFERED = 0,
>> +	NFSD_IO_DONTCACHE,
>> +	NFSD_IO_DIRECT
>> +};
>> +
>> +extern u64 nfsd_io_cache_read __read_mostly;
>> +
>>  extern int nfsd_max_blksize;
>>  
>>  static inline int nfsd_v4client(struct svc_rqst *rq)
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 845c212ad10b..632ce417f4ef 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -49,6 +49,7 @@
>>  #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
>>  
>>  bool nfsd_disable_splice_read __read_mostly;
>> +u64 nfsd_io_cache_read __read_mostly;
>>  
>>  /**
>>   * nfserrno - Map Linux errnos to NFS errnos
>> @@ -1107,6 +1108,20 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  
>>  	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
>>  	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
>> +
>> +	switch (nsfd_io_cache_read) {
>> +	case NFSD_IO_DIRECT:
>> +		if (iov_iter_is_aligned(&iter, nf->nf_dio_mem_align - 1,
>> +					nf->nf_dio_read_offset_align - 1))
>> +			kiocb.ki_flags = IOCB_DIRECT;
>> +		break;
>> +	case NFSD_IO_DONTCACHE:
>> +		kiocb.ki_flags = IOCB_DONTCACHE;
>> +		break;
>> +	case NFSD_IO_BUFFERED:
>> +		break;
>> +	}
>> +
>>  	host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
>>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>>  }
> 


-- 
Chuck Lever

