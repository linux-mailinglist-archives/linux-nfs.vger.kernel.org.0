Return-Path: <linux-nfs+bounces-18655-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NPFGE0EgmmYNgMAu9opvQ
	(envelope-from <linux-nfs+bounces-18655-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Feb 2026 15:21:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF584DA7BF
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Feb 2026 15:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2379306ACF0
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Feb 2026 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA9C3A7F76;
	Tue,  3 Feb 2026 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pM8LJ6mC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C4N2evnA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC733A7847
	for <linux-nfs@vger.kernel.org>; Tue,  3 Feb 2026 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128294; cv=fail; b=kUPh6zX0+twQaDllvlq1t+yHP5hRLNlEQWTN2UzEH+Keg++59Xn5MahswcQxFzLXcV4FmlVDCUgmX3tvuA9MhGCZ4vgTI7dsO/pkaNYibvN0M79PEJCRLAUfBPetwrRPdBRnCtKDmjNVxaRRyzC0pwpSRA9JyHiBCeJByisokWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128294; c=relaxed/simple;
	bh=il0aX3C/6RM61GJky/r8qVopkH9HFcs1eggW8XnpIDI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FJPOCsoYo0W6nmLNmS+Vjju2h40d1kVRvTpy4TF83PvAeM+qxNJk8H7kZmRW+zDQaKcAJadm+KhUhrDVwKBBhhjQJ0BtZ0DGqGJewLQsciGWH6aAZYG0qRxTH6wNleRknNUqri1ib3SqBSiGeKSoP/a+qKNzFlESAwn60mVmjUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pM8LJ6mC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C4N2evnA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613E97ZF3593958;
	Tue, 3 Feb 2026 14:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6FQ3mHrqKCfrLpykv8L9J4XnGS4pxPmaB8+ym1s2gxY=; b=
	pM8LJ6mCziHEYFcwGH0IIZa7b6y6iFoVppubE+2HlOTEIJf18Wgj2iMIGQlHVCjg
	g8dQRQhHsHjZZ6o87Ncb/RHCpbPEMKGt/8dJaVaPikUISTRTukEcGpAfPigjzDmm
	ahFXa/G2G5iCH7qPek3TyePi4eJqCIrsHyQUJTFz6PiAun0NoqwCwIM/dwWEKWQK
	J4Wra3FdcKsDveJJvBXt72X8rMy703EMuPngURro4fRlfNzqG/LG7SxiIGwAoesh
	b4QtECrvT9So3iZ5oAhUgvcyQE+RkUcO6u0e/ZPyoj6alYZIwfifkcSCLGTYYoPk
	3qVavzivcX79XsQ1eG9SSw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jhb00hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 14:17:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 613DQ8ek025830;
	Tue, 3 Feb 2026 14:17:58 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c2578g8vv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 14:17:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETE3a0RfDUbS9bL1LyziAWz58GTbL4nXqbHSQT1N5E9jIt5h033Zu4TxncWEAJP2GAHQpQIsX/GLslyXehLu4iadC2VFqOtZbftUVjOngp4HuNEOex5JLSsyZpEz9rt2TTRfY1L7c7XKdCol9Rp8S8yzPs4KAfECnfBoGy+Ez2x9Xe/OfXSKLzpvvIQEbpFmCZAqipsYLPT8O1RVnhJlbk9G53HA4HmMB04vTWE4foKGxwUJAgMpuG/2oAX7tKAMwHMxmQC/Ny9M8bwlIZRdVVYaM0Noq3OXC2I9hQFTAu+QKkL2gICGggJbRrvUIj/j0iVy2ZKN6WuyDH0XFBXj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FQ3mHrqKCfrLpykv8L9J4XnGS4pxPmaB8+ym1s2gxY=;
 b=fk/z4UKq4tzC2qVbKtEJDNuJfcus7zr3zl3I3Sc679VJzHuscFLlHVlj/spCGZYoOU8w+ZW3GXneHn2dWy6jxBPuOpoZhwJTknNqn/091yu/9M9X7xin5AuIxhMBTdY+yPD0XQlN4sDt9xUMcvUySSsbm8/fEa/0CKaxE3bIkLzKdpe0Ic3nplEm+KqOdKQPCCygGqcj6g+pPSrglseMAE/7tvlOb4DjlJy5gMNzRtWMrSCN7zPIbqr6lhc27lHfRSHU3VUqeaAGRSx47TEMuXZgCNYz5bGns1D2GaUDmyMqGR6UUcn0A8BCmrOPLRJpHEZnGBZQMNEJSCXFQhXeGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FQ3mHrqKCfrLpykv8L9J4XnGS4pxPmaB8+ym1s2gxY=;
 b=C4N2evnADyOwWW05QOqXGeBV8uUBOBzQbkJQ4DnLJHpnrMgiKNPmYCe0J+dRoajf87BlQddAWDKIcd8RJMPLaZznVzZx5jFKInjYbYU1eIBm5AF+Fvq8X0cRaYUCdT2uO0r7Cg6FfiFyOUktMzKA5x11POI8n0TBI69h82tVcEI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8020.namprd10.prod.outlook.com (2603:10b6:208:50d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:17:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9520.010; Tue, 3 Feb 2026
 14:17:54 +0000
Message-ID: <b303b933-530d-44b1-a614-c8bb91ce9f34@oracle.com>
Date: Tue, 3 Feb 2026 09:17:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] exportfs: Add support for export option sign_fh
To: Benjamin Coddington <bcodding@hammerspace.com>,
        Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, NeilBrown <neil@brown.name>,
        Jeff Layton <jlayton@kernel.org>
References: <cover.1770051230.git.bcodding@hammerspace.com>
 <60b48050a0998ca214526bbfec406ed084305617.1770051230.git.bcodding@hammerspace.com>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <60b48050a0998ca214526bbfec406ed084305617.1770051230.git.bcodding@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec6d0b0-8b56-4a85-fae5-08de632f05e1
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7142099003|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MUxjNDVSUkxXVVd3SlE5dGJsSndIS2VDR1dnRmxwV05FMjN2YUs0N2x1a1Zm?=
 =?utf-8?B?VUJYRlV1Y0lSY0VCdlRBVDZVbmtsK0p3U1I5YVRVdU5ybXk0OUJQUjhESk1U?=
 =?utf-8?B?TTUxRzBiV0tlOUxxMW52emxJNUR0RU5wTDdFQ1Nmc1I5Zm43NGIyMFhOa0M2?=
 =?utf-8?B?NHJOUW0zZEk2SmRIQUY5WnBSbUpucUw2ODFpTEZnUHh0RS9LcHdTUlp6TWxu?=
 =?utf-8?B?bW5UbGlJMWdBcWNsamxHOG8ydDdGSUtuQUZBa254UGVwWXk0TjMzalBMZ3Ir?=
 =?utf-8?B?VEZRK0NNK0NVSjQydGZaUi9uSnFVeWNUNkVkOXo5ai9kaDhaQWRVTmExbDR4?=
 =?utf-8?B?TTlOREpRcndKR0ZsY0lpYjZWbk04MzRNNllleFpGWDhZTExqNXBJOHZPcGMy?=
 =?utf-8?B?aEs2dFNKTU5KWUlhek5lOFpQTytzMnZvMDJpSFJKZUVxYkg1bW1PRUZGM3JU?=
 =?utf-8?B?MzR6Ny9TRjZyY1g5SndDSmJjOEpWSVlGamJVaGNicCtxbHVqM1lNWWlmbVNX?=
 =?utf-8?B?QUxNd1prS0JJTW82TWhEQ01zME9aNlZmM0kwdjN2UUdBUTFlOFRrV2NBelVa?=
 =?utf-8?B?dXJDeHJzck9ReE04M3BBWXVGUFlWSHhOTTc0a1IzM3J3c3NLOElPN1FIZjJQ?=
 =?utf-8?B?K2VYTFBYZk4zSTVrMXZsbnR4RG54aFZZck1pZjFQQTRyRG9DN3QvKzltSU9G?=
 =?utf-8?B?M21FVnhiS2s1ejJ3SkNIRFppSEU4UGU4bkdVR2xtQVM0SXN5YlExUk5OZEJa?=
 =?utf-8?B?cFNRWlRrTXBxZnJiK0haZkMrODRvVzZ2RXBGYlJhdTFBM29xUnBESlhVQ2c0?=
 =?utf-8?B?S2cyNjBhaHUzN0xxUTQ0NW1wdkxaQm1qVkdqVHpxQ2JYaFBwaUJWajdoZW9j?=
 =?utf-8?B?V2FIUWdYNFVadzVqRDRyQTNjaS85YjFxQ3hhNFNJMEMrZDVhWVF1VmNMQnh6?=
 =?utf-8?B?akJDOTU2TURLV3NFVDNhemVuV204cTNnQ2JpZ1k3NUROVjhUcDkzVjFoUThK?=
 =?utf-8?B?S3dpWTRMNUJUSGI4bFJGL0pZVHBWc2hMakRxcmVyRWxDSXZlUldHY0ZMZGJ0?=
 =?utf-8?B?dHJ2UkhsT2F2cUI2WkRiU2V3VkoyWE1LeHJ6ai9YTDlQM29NNGJrVmE4OUEz?=
 =?utf-8?B?OE11TWxFVWZnWmhQMUE2VDFESDVxdHpFbEVhRFd6NDh5bHZTOFZUTjlDVHAr?=
 =?utf-8?B?Nk5oZUFwTE5YRHdhRXA4Yld2WFRRVDFkeGVDTDRXcGVqc2s4ckdRa3kxMStz?=
 =?utf-8?B?a29udGdWSjNiR1VyWEZjYjRUNVI5bGhGbzBpZjh5cVMzb0xTSmdqcUxmRkhB?=
 =?utf-8?B?OGlzWUJ3aHh2bWIwSDVQbXplYWRyb1QwR0xQRmFoNktydm1jbXNYcGozNUhG?=
 =?utf-8?B?aFhQN0RpVlEvRmY1cm5SdS9sejRnK2EzZHg3UWNPZk4wZVQ4bmJ0aXVLRGRK?=
 =?utf-8?B?WW1Wajd4amlEM3lYMHY4ZUoyNUd0Wm5Fc21mK25kUHIwYlhDTUZ6RVdMMkVw?=
 =?utf-8?B?eWYyNGwvUU5yZFhiNjhlSllsWVo4YTZ2Y0tUMHFXdnE0U3NQSWZoaTZodW9x?=
 =?utf-8?B?NVk0NzMrR01Ccm0zV3JTV29DNEcvdnMwZnZDdlFmOGdUZE5LM2lKd1pLNGww?=
 =?utf-8?B?NG95QUdRQ2JCa1dkbjAzR0RSeGUzUjdKbVA3VUlJWlYrd0hWblJ6N0xMVDBG?=
 =?utf-8?B?RUxtQjdNY1B4ODhLVFVnekE0UHhLSXNMVHZZSS9DRXN2T2Qxb2dYWHR0K1NK?=
 =?utf-8?B?UGJoMkQ5UTZXTkgwOFpKVS95OWxPYUxsbEsxUko0Tmt3S1hROXRYOW41Y2JQ?=
 =?utf-8?B?MCtBSnhEVEFEOFAwRzMwL0cvV1RRZnBnaDdsVzFSMnlvNkpkbFFZUmhhUGlt?=
 =?utf-8?B?RFd1aDc1SW52b09QeldsYVVxN0cxOTNrcEsreEVpNzR4ZlBJQzRSSmR2K3pV?=
 =?utf-8?B?VlZrTHgxNVZlMjRGQ0lLUElyVlNNWnB6UnJ4UTJVcGEvRjJzUmV0eXJkaDE0?=
 =?utf-8?B?RWppMkpVQXF2Ly90VDM5R1N2Rzk2Z1BrZDFNRzNuUE52NEVPaWJyMFVOR01v?=
 =?utf-8?B?cHdxVTk0ZllPTW8veFdRWEtOYWlnZDloT2QzWmp0aDZ4czVEUlRqQzZna09l?=
 =?utf-8?Q?IM4A=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7142099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eXlKWFhQcVoyOTV5Q0NBVStYVUN0dk9yQU1PV2tXK3RjQVQxbkFQU2k5dGk5?=
 =?utf-8?B?UnNlS3JXNE15dzZrMlpCWjdOcWNzSjdGVncvcHp6K1k4d3lMQTdDVUF2WUNx?=
 =?utf-8?B?NUtOZmtnWkFFQ28vNk94aGNwWDcwR3pOWC9lY3ZHZVpuTkwxZXdEcFZMT04r?=
 =?utf-8?B?MmJJN2o2MndBeldzaER4bmZXV3NXclpjYXdzbkNLa0VRNllkYmdrTlBMM2VK?=
 =?utf-8?B?QzBkMW0vSGZlWGtzN1VhRjVtTS9lMUg2V0dOR25rRjlmREJoK3JxVVZxM3p2?=
 =?utf-8?B?RTNXcHYya25MWWhyYytQSWZlMWFRcW5zYXpqOTUremJBSUszVGlMOHRzaXNz?=
 =?utf-8?B?QWpEQ0VKMnJtZGp4UkFkMXB4aytjVlVFeTNDQ2lFcDc3V0R4ZEdDcDk4MWsv?=
 =?utf-8?B?VEVEZWtXL09rRW91MlhRd2E1a3lJM0thUXZNSWtzTmJzdThLMDl0K01URnhu?=
 =?utf-8?B?dWVIZ2dOS2p5NG9XNlhpR3RENGg0WEw2cE5FU1R6aW5FcXpzOFBRbEFQWEh1?=
 =?utf-8?B?NUIyV0dlaExvYlkzMlB4MXlEWklQam5zTno3bWxxeWhtdzExK3ZlREE2cXEx?=
 =?utf-8?B?eC9oMUVJVTNmQ2lPNUxrQnY3R0YxMGkxQmt6MWtYUGFhaTR0T2JzVzFlYllJ?=
 =?utf-8?B?WUx0SngzcU9MRkdKMnF6dFFBNmp2NU92OHpjTXRNRVBqNEhJR21OSk1mMUlp?=
 =?utf-8?B?SXZyTTM1L2Z1V1BtdWM0VmNoajNHb05tY0p1ZDF5SGhaTUI3TE9yaks5bllK?=
 =?utf-8?B?ckxXLzNQdXNaY2Ntbmg1N1FudkgvN0RrdlBHczUyYm5yTW1nek03dll2anpp?=
 =?utf-8?B?NnhjYW5pU3Fzd2VuYklpaWlVbU54eWdvS2w1aWVUbWttK0ZlY002UkhkeW9Y?=
 =?utf-8?B?dVFRVjlTd1FoWUhDZWpldFc3MTVzU2NUVjU5SFo4RUNTenVqSDJVQ1VuYSt4?=
 =?utf-8?B?cmRSNDRXOHJGRWxqWnQyVHBQdi8yZTlKaU1hV2wvb1A0ZEdPOE9FVmdsT1BU?=
 =?utf-8?B?RGRwQThoVExWSzF3N0MwZlpFZ1pLaFlzUGROV3dpejk3a2hRZ3QyNWloQUxD?=
 =?utf-8?B?U2lzMTNGVUdxVTFCOGxNWmtUL0VTSy95T28zQkNuOTlrZ0p1TVU2UnpvY1g4?=
 =?utf-8?B?MUZ0M2RSdU0zbXp6NlUxVE9xOUVjTTdaV25jWlJyNmEyUnZ4SWZaWmxhTnJw?=
 =?utf-8?B?YjVJRE5aSTJVTmo4S0VyMUtWU1BRdUo5NGp1SHhVODQ0dmM1ditsSUNIRXg4?=
 =?utf-8?B?bmp5NDhyVW1NVXc0VFhZZnRWM1lSajNRaVpqam4rdGgwenpZUHdRU0xOT1dn?=
 =?utf-8?B?cURxYUg5Umw2aFlpRi8wc1gvc2REVGk5dUUzWXVvUlRDS1lGTFlrRTh2Ui9r?=
 =?utf-8?B?dFhLTFlHVWJpVWFBbS92YlY5NlAybW5LVmM4YzRaaGhlL09SZDdkYk5qOUhw?=
 =?utf-8?B?b2pqcWlYc2d1UFplMkVkbjZ3dlJ0U0FZZmh2cit1TjRvNTc3TUUycHdqY1hR?=
 =?utf-8?B?eitFYVp4am1iTDUrbWJGNGhYNjhma3JtYkg1Y1BYbHJYQlNobGlkUUpkM3Va?=
 =?utf-8?B?enBjbGtQNGxsNy9tWmZJc01NWHpHNEhpMW9HNEI4Y05rNHpycXZaMGp4NDE3?=
 =?utf-8?B?RzBIZ2RLdHdlRVB1ZXFXeFBqVEc2YmZsZTlyT3pNblJ4UWJ3TnRxZDJBV0Z6?=
 =?utf-8?B?cHNCalB0Y3dJWUNJeGJqT2FaZzd2WDlaekhscG1hdEtubWp5dlNNcnNVdXJ0?=
 =?utf-8?B?SkgyMGphakU0dk13N0xkWmRGM2lvZnZQVEx1N0xML0xOaWs0TUdyRE55eDRh?=
 =?utf-8?B?SmZsNUlxNFRMS0wyUDZRZUtSdFh3QVhONEFRMk5KcGdXTGJydnQ4NG9nNlpE?=
 =?utf-8?B?Mk1KenBoc09Od3BkdG9MVzZGajFRREdid3lGZUZKd25rRm1DOU9IbmpFN3BX?=
 =?utf-8?B?ZGpyZ2d3bjVIQlA2dGZpc0tiUFZ2OGVxaFlOVWZYWDVucVJzZ0p1Q205TEk1?=
 =?utf-8?B?cmZnN0VpeGJ6TWF0OElhWkNQN05wMlZUck1rQUdVdk55Y2xWTW9wb1hacERI?=
 =?utf-8?B?Y2hxNWozN0cxOHh4dytUVVBkVkxOOENLUnZ0Lyt2ZUVoTUNlZUQ4YTRaUWhU?=
 =?utf-8?B?cERybFpqT3NpNGREM3BxSVJDZGlXbEpURXg3YldjZWQxY1ZSMFNZTW4wSWZo?=
 =?utf-8?B?Y2hWNzlOeHJHMDF4bXByUW90VllVejdRTVdaeDdKTVFlWnphQU02RjlBV3dm?=
 =?utf-8?B?QWErazhNdVpzd3hVSkFZSWttbE1SVGUrU0g4TkxkSXdzU1Q1Vms2Z1hscjlp?=
 =?utf-8?B?QXBvZFIyWFl6eVE3ZTRrZjI4a09zYkxqa0hoaEVJMVl2Q3BNMjNEQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	59YuHS3Qweun4txXsGenlLPkjuX+91wLln0pENcB55OZIMIHifVPhdM3L79DdtcbgowNEGEPf15ShN3F+KwXh7c7DHx6xgQau3GBR8+GGtgG2sotQGvBNvx46eVSI6j3YWLN2CSGJKPmDJszFO+RrPshc3PnkK9P5aQi83hKkzBmvfVJ7Z/By+r915qhZxHESFLnHK9jd5j8SeE86ATNWY/Dh9U5+2tVm7PgsQPjNQqt/acg9IGyabzAMD6C/bK8kot+/YnzuS0kkcEn0PyY9dTsz6yfKxiENlgo0BLBiVYU1QXyBuLprsf8mLsPG4PDpJxvM0GLgZHVrZNCatxwubp6ytxhaAIGRnrmwm3Xx0BAGubQ0Oax/7T49zulysaY0Jh/eOdn7lzAWZ0jfzD9paRiBRk9rgX/5/VppWCUGz2AUBKxBXfBVxrsUipgrS5lNrKI2CsC0dtPc3FamrP61LIk01IkOmA2jEssXY/YMKp0OTNcxwtfzoRztq2Ry9ha+H51gQIZZffWMUtyyaw6PLSVMR2S5xbzHyiUNL67+KLpRQPzLsPk76Uuh2h9/i2GygOp0Ts5rm9bfYk9hvOAgJcJh5QaGNHNEY3WGnN+oHA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec6d0b0-8b56-4a85-fae5-08de632f05e1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:17:54.8180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqYiCFxacxfRfkN6aAOVmEGTg07f0b+bDjFN1VckM8Dxt4hQXA0YB+GYbm7LR69oguoNndlmotwLtqBvqf0sVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8020
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDExNCBTYWx0ZWRfX6wgi/QSUqUIT
 p8kTYQASowbFE7OxKyNSBujVzXbaXtCMPpfDnI/xzla8Kk+MZbG3+RLKxYI1SQr9i91Vzz3k5UU
 6cCR9ImTrBo1OEHWs3YjjMa6IJNUeRHypOpSQ5EXxm4gengMzcoQZ4p4Jy4WDObAIW3gcByEhlX
 p+rNIrvMlyHO+LVGrNUD8KqukfnKPpwvg9xbQkbMMByRJYdNFR/4DTklN1dm9xTkdpEAxi0otml
 LuNeRLENoGonhWBu1jmo4e3xkcJ37jyGnjPF9VLYTJbIRu7d6HmdkN/EWRd+JUycYUZgVhz3Xds
 hbFxziRA/R+xL7DhzxT7NKY5pkLdmWz9qfmw7mUI4FkCKNU1IqQNPT9QGahj3a0X+6+IK8HgUL8
 3t0cnYWRZhJhH1eJMjJdSZFq43K9YCAZXngu1SWO1vRggAxF/is4rtHzL7f8JEx262bfQMygQxA
 txKzOhucUrQoCzP3BExDUau920JdyxykX8VKnhjI=
X-Proofpoint-ORIG-GUID: MLW-52nYZSP6KKUW7MqfBU4hRptk7xOb
X-Proofpoint-GUID: MLW-52nYZSP6KKUW7MqfBU4hRptk7xOb
X-Authority-Analysis: v=2.4 cv=CaYFJbrl c=1 sm=1 tr=0 ts=69820397 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SEtKQCMJAAAA:8 a=gMDyz9f4IXGEU6hZFB0A:9 a=QEXdDO2ut3YA:10
 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:13644
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18655-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,oracle.com:mid,oracle.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DF584DA7BF
X-Rspamd-Action: no action

On 2/2/26 11:59 AM, Benjamin Coddington wrote:
> If configured with "sign_fh", exports will be flagged to signal that
> filehandles should be signed with a Message Authentication Code (MAC).
> 
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  support/include/nfs/export.h | 2 +-
>  support/nfs/exports.c        | 4 ++++
>  utils/exportfs/exportfs.c    | 2 ++
>  utils/exportfs/exports.man   | 9 +++++++++
>  4 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/support/include/nfs/export.h b/support/include/nfs/export.h
> index be5867cffc3c..ef3f3e7ea684 100644
> --- a/support/include/nfs/export.h
> +++ b/support/include/nfs/export.h
> @@ -19,7 +19,7 @@
>  #define NFSEXP_GATHERED_WRITES	0x0020
>  #define NFSEXP_NOREADDIRPLUS	0x0040
>  #define NFSEXP_SECURITY_LABEL	0x0080
> -/* 0x100 unused */
> +#define NFSEXP_SIGN_FH		0x0100
>  #define NFSEXP_NOHIDE		0x0200
>  #define NFSEXP_NOSUBTREECHECK	0x0400
>  #define NFSEXP_NOAUTHNLM	0x0800
> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> index 21ec6486ba3d..6b4ca87ee957 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -310,6 +310,8 @@ putexportent(struct exportent *ep)
>  		fprintf(fp, "nordirplus,");
>  	if (ep->e_flags & NFSEXP_SECURITY_LABEL)
>  		fprintf(fp, "security_label,");
> +	if (ep->e_flags & NFSEXP_SIGN_FH)
> +		fprintf(fp, "sign_fh,");
>  	fprintf(fp, "%spnfs,", (ep->e_flags & NFSEXP_PNFS)? "" : "no_");
>  	if (ep->e_flags & NFSEXP_FSID) {
>  		fprintf(fp, "fsid=%d,", ep->e_fsid);
> @@ -676,6 +678,8 @@ parseopts(char *cp, struct exportent *ep, int *had_subtree_opt_ptr)
>  			setflags(NFSEXP_NOREADDIRPLUS, active, ep);
>  		else if (!strcmp(opt, "security_label"))
>  			setflags(NFSEXP_SECURITY_LABEL, active, ep);
> +		else if (!strcmp(opt, "sign_fh"))
> +			setflags(NFSEXP_SIGN_FH, active, ep);
>  		else if (!strcmp(opt, "nohide"))
>  			setflags(NFSEXP_NOHIDE, active, ep);
>  		else if (!strcmp(opt, "hide"))
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index 748c38e3e966..54ce62c5ce9a 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -718,6 +718,8 @@ dump(int verbose, int export_format)
>  				c = dumpopt(c, "nordirplus");
>  			if (ep->e_flags & NFSEXP_SECURITY_LABEL)
>  				c = dumpopt(c, "security_label");
> +			if (ep->e_flags & NFSEXP_SIGN_FH)
> +				c = dumpopt(c, "sign_fh");
>  			if (ep->e_flags & NFSEXP_NOACL)
>  				c = dumpopt(c, "no_acl");
>  			if (ep->e_flags & NFSEXP_PNFS)
> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> index 39dc30fb8290..bd6669f431ba 100644
> --- a/utils/exportfs/exports.man
> +++ b/utils/exportfs/exports.man
> @@ -351,6 +351,15 @@ file.  If you put neither option,
>  .B exportfs
>  will warn you that the change has occurred.
>  
> +.TP
> +.IR sign_fh
> +This option enforces signing filehandles on the export.  If the server has
> +been configured with a secret key for such purpose, filehandles will include
> +a hash to verify the filehandle was created by the server in order to guard
> +against filehandle guessing attacks which can bypass path-name based access
> +restrictions.  Note that for NFSv2 and NFSv3, some exported filesystems may
> +exceed the maximum filehandle size when the signing hash is added.

Now I thought NFSv2 wasn't supported.

NFSv2 file handles are all the same size, so there is no space to add
the MAC.


> +
>  .TP
>  .IR insecure_locks
>  .TP


-- 
Chuck Lever

