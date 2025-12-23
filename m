Return-Path: <linux-nfs+bounces-17290-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B9FCDACE0
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 00:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F5CF301890A
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 23:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498392DCBF4;
	Tue, 23 Dec 2025 23:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X457/6oI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x6LM3ofv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5B2227EB9
	for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766531447; cv=fail; b=l9un0dptUv/mMBBroUhv7sPLpCJNdHCYz0n2LRD2F4OU2r/bYmD2cq9NdapMUfRjuC7zVbw0XGHsd3ONk2jaxZ4mvRzeXLGY8NtjeqE/fenlGEwpPdaR1QGfl3fg5C4CDt/ENXNiaajeNqe9OcvZt1X0PSAJXJn2TIsYeOZoQP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766531447; c=relaxed/simple;
	bh=HQJ8tj1eK2jZa5D1h3e12MyotRPVntM/Vrzo9raKdJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fbRuvZd7nkC3i8CTo3NM4cOc47PkvFajYrDQt0i9KpgpWW0ObuCKzqVAUu+nqZXch/cxRwaL2AV1TPXbgM+HjuihtC7teo5FBUyOSIJfgWVU9bnd1RxIbDBxI+dQHozaLTx2DoXzHnhwUlIWUC7h44Upjb6Z8MFCHI/rcj6Nmnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X457/6oI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x6LM3ofv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNN306u1388436;
	Tue, 23 Dec 2025 23:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xmLz/+d3F9jAraC/jLBRgcDTc+qUrAVsi8n0igbQlcM=; b=
	X457/6oIg+LoIzWsOvwqoDUzwTDmG+OyIu4CNKwH11weK2AUzzvm3vNgQWpjsx12
	lCxzpQAXKQhLhcAANkemBqFpbgKWbsAC7o+JhbFbtjbaoNmCscTrY6EUlogxIwc6
	LUlK4r/2dKt4Uang1eEQbxMcdQk/uWc44mURpqJuM4puwLpXCeFg5nj6CwU/NWhX
	+v2ZfXIUTvXRlwcuBLR4sVa7EqBPaHOk5T6gxvydWiebiwdJh94SEKXcNY+kRPQ4
	iF3LYixf9aev2OSdoKJijAkoawG0+benqxqC+XXRiMNKgcmQYq8zg0Ik8JrbGEh0
	QpH3q7gjjopNuNL8J7gcTg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b84de806r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 23:10:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNK86q3039926;
	Tue, 23 Dec 2025 22:34:44 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j88vr8r-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 22:34:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUA3+BcNSrdlZzXyG/uSQqF0qooAMI7c7M472nx7pYPCGcPx+SEywY16SDDcNLj0pyGksdBdFcL/2infOyImV0py9Zu1G1QZLXKG/o3bJFSeUVNbQpgGgHvbhRf/jGo+QNhmr6POepanFtf9f3hStjT84NG5ptywRs+O9/X6IDcUGADX7Yeql3xjsmJ0wNhoaWKUHcBFMFQ43cDyDYK5jOu3y5Nv168eHJbhsI+O6qGRNdNu7kLhGDCFIjtu3t6X9638bA0OBBa2hy8XWgNC9PevBTuY0thNVCuI5Qv0Gdk5VlNFmDZxmoCLXxB2lOJMm2Nt6aNJYovy7wdOPqlHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmLz/+d3F9jAraC/jLBRgcDTc+qUrAVsi8n0igbQlcM=;
 b=FgVF2UgLWodII1NV3kphk+bsewNimMX42xA/Prng60R9xjGjEL7AYELrIaAnsaXdKT1V1hFMFANpsEBAoLh5+lKuf0owO2F2+4ztsNTGf9YGcyrZNTdvSkS1VKuqNYf6RqIGhefOSxIq4PXQwblEPyASFPyAG+hoH8VaDJQWdmYbuiTvjGi4CusUcQ7/+IYhIRvv6UZ8p6djkQzsMam8Nmlu/s0JHSm+xaYfRx6mFUo9zNRxu956xwRa3bO7GLPjEFO0NVLCkwIw398X5xbVYlyWy6W5SMZ0U7pXn2wZmZAiBbzuXxZYmkEghRFxi+KnEE+nhnY7rlia8unDMf2CPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmLz/+d3F9jAraC/jLBRgcDTc+qUrAVsi8n0igbQlcM=;
 b=x6LM3ofvh5pMtzT+ZkRCmefCeCEuIGRN06o1KiNhoopYFsymff0wh800GdYCu2KoP2WsoPn8B+2p2L4CASRIbtN7cyHD0l+l7YBhCjqdCycvJKsayND56VJSpNtonh6BVPVESP7k+26DvEsCjwtBKIswfAUf+wgT4k8zVGMxKcM=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CH3PR10MB7744.namprd10.prod.outlook.com (2603:10b6:610:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 22:34:41 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 22:34:41 +0000
Message-ID: <3bf448ee-7e1e-4ed8-93a7-2754084885c5@oracle.com>
Date: Tue, 23 Dec 2025 14:34:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] NFSD: Track SCSI Persistent Registration Fencing
 per Client with xarray
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, neilb@ownmail.net,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
References: <20251222190735.307006-1-dai.ngo@oracle.com>
 <6ffa2b50-c0fc-4532-908e-951b224fcb10@app.fastmail.com>
 <f1448227-ddd8-47cf-9fe3-3e1983520de0@oracle.com>
 <c55508e3-4167-4439-8663-5dd782404893@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <c55508e3-4167-4439-8663-5dd782404893@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH5P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::6) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CH3PR10MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: ffdb1a37-6ee7-4a1c-705d-08de427376ce
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dlhVZmQ2dWt3Wi9xQVZFYlk5QTJNWE1hdUpYSEUwQnRKcjBXblMwN0NXNVpi?=
 =?utf-8?B?OWZ2cHlJRUl1OEdJZ0dMZlVGYThtSkw5M2orK1FkVHpxNHpRQmppbFlmZ2Ez?=
 =?utf-8?B?ZXExVjdWR1hNamVKMmVaOENMZnZFYlE2TkxpM2gyR1BQV2pCMlcwZTRPMFVo?=
 =?utf-8?B?YXl0VzNQTUVsV0NySldFQWJrbEtNRkcwOEh3ZjdvbFZWTStsMkpjWFZVdmcv?=
 =?utf-8?B?c3BMN1VqbFp6Q1VDcnBxdXV2SmpwWjIyVFNObXloNFFpald4Zks0cC9acFhF?=
 =?utf-8?B?UDRhalhMOThnQ1JsZG9UbURGSGhSVmkxVmpsazFOZVpLUnlwWHBEcjZBMUlh?=
 =?utf-8?B?VFNqQVBvOXR5azlzV3Bxd2R5Ri9zQ1YwSHZpVElEdUxhZ3RqZk5mVE5KdllY?=
 =?utf-8?B?dlBYZEtITThZcmFuSnBQQVNHN3E4dHlZczVuSERwR1l0U2ozTU52NXJsdWNB?=
 =?utf-8?B?c2JUdW03RHVnTEd1NEM4QTh3RlJMUGlGbGp0aXhTa2VqU1FNV1FsY0tPZDEv?=
 =?utf-8?B?dlRGZ2FoUi9ISmlKeVc3WEN3OFRPR2d6M1VJVk52QitlUkxDM24vWnpGUEJP?=
 =?utf-8?B?QjZlU2lldVNTa3kxMWRWRVE3UDF2U3VrOUh1NnJiYjA1Y1Y3TUY2eVBOY0Fo?=
 =?utf-8?B?eXlJUzZnUGpLTENrbEhYZS9OeDFrVE0rOVdLblpCbU9CSW03dTY2bHA5K2h3?=
 =?utf-8?B?NkVrZ21iVjBYWGpXdzRUa3AzSFVCV1YwMm51QVZKT2pWL0FDbUUrWER6dE1B?=
 =?utf-8?B?enpKNEU5RUhRamtYNXl4N1lWRzRSL3ladGcxNTFsd2NsUXJCL29hL0tLcXB0?=
 =?utf-8?B?TmwrY3JpemFrRlAyQmc3ZlJoZVNLbW1lSFdBMzJZVm92aEtyUU1lY0EwSlZX?=
 =?utf-8?B?SzMxMnhLT0ZMNDB1bUxaeHV1SWVMRFNhNWU0RDlrSjcxSFI5VU5ObU9udU9K?=
 =?utf-8?B?Y3pvRFlWeFFuOVdNd0FlcE9YOE1HWWpOZHcrNS9zQTMzaUhQRkhnQlRkamNx?=
 =?utf-8?B?cm5EVHFUc0xJVlNPOG96N3Q2cWNFUkRiSTlFRlNBS1U3REtRS1NXUkFIbytV?=
 =?utf-8?B?YmhBY01CS252akpiSjlQek9hYkdIVThGeTY0MXB4OU95L2F5SzhSc3QzZkRi?=
 =?utf-8?B?Z3BOcVBhS2c2MEZ6RjdyZEdSY2xpVW5qOXhqV1kvc1JpYVlTNy93b0RzTXdn?=
 =?utf-8?B?VmhUZWZEUy9YZW5XSTZ4YU1tV25nVlg5bWN2VDBKaXY3L1dUVzhQeTZDSXRo?=
 =?utf-8?B?aHNhQVBZeGdtVlpEdkQ2d3VBWGJ6MDZUTjEyQVpneThIWlBuQVVhNnM4Zmgr?=
 =?utf-8?B?ajlNYUJVMHVSY2w4YWN6SG42STlmUlNIMVhtcjYvVkx6OUFxQS9peGQ0cllM?=
 =?utf-8?B?NC9SRlhGZWxXQlJTbG1EbjMyaGlHdHQxcjZ2Znp3U1ZISEZpOTU4dVVacHMy?=
 =?utf-8?B?akNSQjVoaUdteEp1V0VkVVlUOFN2MzNjaXA1M1hxbmRNdFZQcUoxZTVycTZ3?=
 =?utf-8?B?NVVBRCtpUFhEQnFNLzZjVTZpSFRNS0R2YmxFNk5kQjEzT1dQY2ovMHBlM3Uz?=
 =?utf-8?B?VTR0TFlaTGxHZVlCSHZpRU1jTFlEcVFEY3pmMmcrMUozaHA5eDY5Wk81cm00?=
 =?utf-8?B?OWxnWkg0QkRtbENMZGZBZWRFcXo2K0phWWtNZGFxZGZ5TXBDRHVJNFJUdERz?=
 =?utf-8?B?L1IvZXNlUnVDeEl1dks1M3NGTEx3a2I2NzZTdnlJSU9xRkxnVDV5QzRodXlO?=
 =?utf-8?B?dkVKYTlrSHY0ZHhEOVcwZDl6WUpWSWp1M210QzU3TnFIeWwyYlVNMXBJcWI0?=
 =?utf-8?B?S280aS9vR1ZYSkRRdFpQS010MGxsWjUxQkg0VnlvRkpmYmU0dkFOTzQzTXhp?=
 =?utf-8?B?RUw2OXkvZ1lQa01oYWEvZm1tQ1ZidkN1S242WVd4RVZBYXdtTkdyTzJxS3Jt?=
 =?utf-8?Q?abALncO7f/BQX3thOVXegn9gf0uSkIQq?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NHlUc1VKUnY0dnQ0RnN6OFFzaTZSYWgveUZzYTRsRzdMRkRzV0MxS01aczhO?=
 =?utf-8?B?Uy9Sb0xvTHBpOTJJMlFoOUllUVRNZjNpVjJEN0tBRkQ3VWtXcWROU2dnTXlh?=
 =?utf-8?B?YmlXVDdPSUltUUpBaXdwaG9scFV6Y0xFWEltYWF3OTVjeUVxTWJ4SnlrN2Zp?=
 =?utf-8?B?S29PYktXaTNuMHIxZGh1eFM2QkpONTZHZXR0bjk2ZzB1cnRIR0hjZkUyL1pM?=
 =?utf-8?B?UllKZTZUTGZWOEJyb0M1VGZaTzRXbS9SNUNOQnI0VCthVEV1S3dtdTY5eWR0?=
 =?utf-8?B?azEyUmM0QUZMM0pIYzRyMFhjUVBkRXZTQXJhRTBST1c3M0IzdU80WDhpVFNw?=
 =?utf-8?B?a25XdllWS2J5QVIxVWk5SEtrRW1iUUdMTndBbEUydnZKUjRvMTRTU0RidmY1?=
 =?utf-8?B?eEc1RGlobjhMVGtVSjR6bWo4VFBzcnI4ZU1zUVQ5d3dTNWFxN2xvT1V5MzVy?=
 =?utf-8?B?d2VoOE45WGl4WXZRVFJxck1Neis3ZzczeHV6Z01pOTNKNlJBa3Njek5EcHA1?=
 =?utf-8?B?MGJ5Zk1EOEw3dHBLVlBaZS9QVXhITXpxSkdkeFlFY0hsNjlqekFSVlREMmh5?=
 =?utf-8?B?T0NvRHVTV0NuakN1VVBJTkVTTlFvdzhhRnhxSG1EM2lHbGJEMEZyTUdlTXRS?=
 =?utf-8?B?aXlYRkgvWjJLRDNMYXlIUTBFREV2QlJGZVZsTDMrNW51MVhqZEhQTlJYTlNB?=
 =?utf-8?B?S01UbzJYNFRiYkh6bkdsU1pRcDJGMHMzUCt1cmszbWRUMTl0aStOejJJamcz?=
 =?utf-8?B?T2c3WVVVRnhlajV1L3docTNiLzRCdGVoK0I0cjBNaFFuVnM1ZjdpbXdyYlVs?=
 =?utf-8?B?eVJOdVo4UkJlV2hKOGpuT2gxYVc1a2JBbGRFaVdoTUZIT08vVmFIRHRlUEdE?=
 =?utf-8?B?TXVTU3BKWmJzRlIzY1BxdTRCRDYwN2VIWm1Yc3Vyajc3THhoMkZobHVlZUVY?=
 =?utf-8?B?VWp4dXY1aUFaSDZsVS9oajkzSzVtS3BxSEw2eHl5ZmxiUUhGclF5VHRvSVJL?=
 =?utf-8?B?enEybHQ0eTY5bDVmZHd1cDF6ZEhrSTl0MjRsakU0MGI3U3BmTVgxbjdYTC9I?=
 =?utf-8?B?d3JIeVVvR1FJQklRMVd1bDNRcnBSSTk0MUU3SlJFOWxuYld1ZEgwZ3dWR2t0?=
 =?utf-8?B?ankwV2diVTV3TGtkM08zSm8vcmpIVitDeDBBYnloZ20wNlhKV2JmTG5DZ01W?=
 =?utf-8?B?V1ljdTRCYUYzMTh3MEFMSlErV1hvQzFRLyt4QUpiTmMxaCtpRU1NTHZ1ZXZq?=
 =?utf-8?B?Kyt4M2hZd2tTbGtreGpwM1pjVXl1VUlSY29hbjhqQkxzdXdoZlg3blFvSEk2?=
 =?utf-8?B?Um00ME43V29wVWphVG43Zzd3Z1FGc0tRRFErWER2ZzIxbGI3NXpnOXBWSUpE?=
 =?utf-8?B?VUJBRnJoTjJkNjQvQ25xcHZ2VUV6SEFTd3hWZzBrQ01Mbzh2MndhK3B2eFpH?=
 =?utf-8?B?T0ZKRThPY3FwVnBPNXFldk5JRFVVdEtucW1FWlNHTllMazFMRTNZVVhVdnF4?=
 =?utf-8?B?YzU5STA5RmpkbWNKNXdJL3AyZ0xrYUQwWjhHT2NaTW4reDVpNkVmOEhDT20w?=
 =?utf-8?B?Zlg3VStkWGFOTFIzYk0rQWI3WUhHckxXZFJZcm5BQVpZTHowdjNub0VrL0VF?=
 =?utf-8?B?dm9Ba0RLU084OHNLSVUvWnZ4czJMM0xUZmNFV0lBSnZ5aVhObkdpWVF3SXZ3?=
 =?utf-8?B?V1hLZjFlYThReW1uUm9RUWw4bjFGRzVmeisvTWd6b1d2TkhhSGgrRHpRL2oz?=
 =?utf-8?B?UUhsUy90NXNrcUFwK05nZXhTcmI0N0VqYUhmVUl3WXhmRHNQY2NKMnRqNFlR?=
 =?utf-8?B?VTc3UFNkVUM1VkIwcFBsTUc0enQyNlZZQ2lnOCt2WVNIaHUrVVRIR1dmaUJv?=
 =?utf-8?B?d1FLeWdORnNHdlg5Z050azZjQjk2YXV0QURPUDJQVTlNdTBSS0Q5aktvMUoz?=
 =?utf-8?B?SFhrbDVpVzIyL0tSTGRQYnJsd3ErVGU3dnJ6a25nUGg2TVFVWmc3OHdlNjVs?=
 =?utf-8?B?WEhENnNLbFhodVhaTWhIa3JHck5Cd2RVcGtMeUVWNjQrVnljL1JITnM5bGJn?=
 =?utf-8?B?aVZUK2lLcThSbmQyWkVqc1BIblVCSXlDbGErdnZMVUtqKzBad0FObmE4VGJr?=
 =?utf-8?B?d2Q3cE1hNUlYaWRlTktTOVJkSkhRcVlMSnZISVFkOFdBVEhxczRjbTB6a2Nl?=
 =?utf-8?B?RytzSXFRenh0RDR5NEc2YTBxOGdYRG9KYnBieC9JRjZrTlBrMExsaXBkcGNO?=
 =?utf-8?B?ZTJuOGdjOXVudnhMdWpEYmVJbExHNWFDclNOMnBwQWNzeWw2Ry9FVmM0Y0p0?=
 =?utf-8?B?eVV3d2F4OCtPdUNQUWpsc29sRTFUMWpyRC9Sdkhzc01ETXJSRDhudz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0N8UFka/cFaBusHTm/E+2i/dsWnfpvmtmlsfCrFWsDArW7AcvNQloC1RR4UYBU46w8qal88Fq3ndb63jORLXIGOCVdXXue6EfFxQLKCyLF87+fAhmxSBj7kgLjuYAy/1JDZpn4KRphlVoPnTJWJTxnTOomFJvWz+OJoHat/zs/7mp5nTSCqE5Y09BTauLEuWuV4bB0X5DDOUFSj8cBsgNY5GNV2YPn+Zj97YY/5OLAKCyQKRanqH8kPXcKBPBmLC20eWUSwXkQxWocWhx9W5HZ+AzV9ELdPNosCUWT3Qlyo79aycDOxHVBicgGoEUPT8lHnSfSCl0oQQHkYK1v876VNCNSwI04A6TcSQ+SvECFHYv9z6cjshSkO0Ckd0BRq/AAkqmzFyt0+2qN2zz7YGjmYjX71HOXDkjSlDUpuVHcv1e8m81kC96bKeRn5saKWZDxLhhtUNhKlu9MK+vPYZRA+GXeigZ/mKsmrG5K+1bBirpb3MghnfuVO2blGZaqYVdINhd5ij7ihJQlLwB204VgsA3jxrbb3L7CjnzNjRyQNVvdfYqG35zLs20dcm0nVVozhxREbq1CckPxOleHTKwaz5j03G19ifJ7PIznSvk4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdb1a37-6ee7-4a1c-705d-08de427376ce
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 22:34:41.6754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrC4xijYbeQZ7NQnbp5tMvUYAUR+LdYN2UdYBYhDQV70JBOweMkZURFxiHkA6JKuf3WN3cXuqWKlhbi6AftOEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_05,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512230190
X-Proofpoint-ORIG-GUID: PyWjKHPN-V1qluiH3M6PyRGAcFa89y-H
X-Authority-Analysis: v=2.4 cv=SrGdKfO0 c=1 sm=1 tr=0 ts=694b2160 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ochsEWA4-G7QzNF1MKIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PyWjKHPN-V1qluiH3M6PyRGAcFa89y-H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE5NiBTYWx0ZWRfX1nFQfi1z96p7
 Z9WITOYGAQ3CLOKJ/kOp10HA3nIdGWmKpm4+bHskc7VsMCzFp6R1hoVKpbfx4zmSri6wKM5EoKG
 K6f99l6W6gzVrfCnFpMjX7jbWs0KkY+pMk4fy0U1PA0WwLTUyoU14N1GxHf2JYmHwYYLkLy3zu2
 CpTd4AkkpanRbExDLdHGJ0MSatq49+eZKQyJnR4m9Zp1dPaqYOmWjdyrLMMRxMcqCWgmw0Qyzfy
 a1mgZkQZ3Nc6hWXvPau4eIZv0Twr9aZoNghJ1bTuEPRwlZU41l1rhKHwUabXUtg1D479OIKnbnC
 rgM2/YOxJmM8SU8VMYuP5115jgUDfuyh8ACt8X1jH55xrrqyo0wuIPZnyXLgcyuVefeTUWb2NyC
 I/Rcn2oZm589puZOmC5Ovc0x5FsQXpqdokEHGnxqzNLKJIqjEufPUkzKNREYWdqOorQyweqWUJv
 Rp5AF52acA7dz+xfJcA==


On 12/23/25 11:47 AM, Chuck Lever wrote:
>
> On Tue, Dec 23, 2025, at 1:54 PM, Dai Ngo wrote:
>> On 12/23/25 8:31 AM, Chuck Lever wrote:
>>> On Mon, Dec 22, 2025, at 2:07 PM, Dai Ngo wrote:
>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>> index b052c1effdc5..8dd6f82e57de 100644
>>>> --- a/fs/nfsd/state.h
>>>> +++ b/fs/nfsd/state.h
>>>> @@ -527,6 +527,8 @@ struct nfs4_client {
>>>>
>>>>    	struct nfsd4_cb_recall_any	*cl_ra;
>>>>    	time64_t		cl_ra_time;
>>>> +
>>>> +	struct xarray		cl_fenced_devs;
>>>>    };
>>>>
>>>>    /* struct nfs4_client_reset
>>>> -- 
>>>> 2.47.3
>>> Another question is: Can cl_fenced_devs grow without bounds?
>> I think it has the same limitation for any xarray. The hard limit
>> is the availability of memory in the system.
> My question isn't about how much can any xarray hold, it's how
> much will NFSD ask /cl_fenced_devs/ to hold. IIUC, the upper
> bound for each nfs4_client's cl_fenced_devs will be the number
> of exported block devices, and no more than that.
>
> I want to avoid a potential denial of service vector -- NFSD
> should not be able to create an unlimited number of items
> in cl_fenced_devs... but sounds like there is a natural limit.

Oh I see. I did not even think about this DOS since I think this
is under the control of the admin on NFSD and a sane admin would
not configure a massive amount of exported block devices.

-Dai


>
>

