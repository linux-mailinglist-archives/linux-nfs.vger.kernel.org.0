Return-Path: <linux-nfs+bounces-11742-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582BAAB865E
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 14:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1A69E29DD
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 12:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F45D2253B5;
	Thu, 15 May 2025 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rlqGJ6tN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iVpcO5Kx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835D72820B3
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312197; cv=fail; b=TNPHd3HK+tiCgcB9YxandBw5ccKTXATR4nHObmhdCRgU/JljeZJztXzfh+6VGHJ/5Q9waSwRdKnSv0apGcLYHE9PhRp7oYBPOntXHXy4BKujCjpVqYaeLto3egAh1XOYD9svhoGtLdylVBiXFNitsQ6eon+zfPn+/UFJDjUGFFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312197; c=relaxed/simple;
	bh=jT4mKdE6QJmCu1HfTNF50ZHFsMteTr6hhW5XW+HnAno=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=AGXgNLQYQro6ddzokjejWDOk7hc91KXYglPyTyZY4LoFcoA6r1PWaI/IPBf+9PsFnnh5qMSYEeoz09ubTPGyph/oMP2FenTOg7qvvoDbkUdl7isSmlTKJFlS2Wy9aY7f1N9y4aSy6AQs8bjMNJoPXNAV2tqis2zUteLB5WLmtu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rlqGJ6tN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iVpcO5Kx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7BmTC000903;
	Thu, 15 May 2025 12:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NIrhNh+0GJqdrUO/jTgbQ/t3qT4w8Xwi26w1gLs0auM=; b=
	rlqGJ6tNMEySrgMDPllRBfQSoC2TuLS4VuPAoYbKNL1uFfkPgrhidr87YunCZT6n
	xsX0hkeLe8L8nU/CjRjbfwNcjNSBXt/x7A+x2sj6HQBhxEk2KwPiOTQteSTf/jbN
	bOo03NoZ/wJ8qcS8DAPTVOoS5orRY06BaLt8Tyg6jphAKJFsp61Ip6vuMKQ+Lruk
	G3lo9BSqVSpNNgw7NoEh/LxO3SxrJx3jLMqLGpNT1lbX/5YAq9ayo5DiXQEtwlVK
	82QJiVtcN92ckXvTZKmadagrS+WbsC/eBjaEnqBYr2IMNKcM7RjHBIvjdjh5b7wN
	WvRMFBg64tZ7sIvY+6m0Gw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbchut10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 12:29:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FBs1HW016764;
	Thu, 15 May 2025 12:29:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc34qgsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 12:29:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpqlatWco4wQqOldmygybQckhXLfiB1jUrFO8QF2mfGo/TlZldsSJCQCeMf3pv6QEoOeWzbgzK3Lb5RHpF0XAE7FTEpi0ovuOrajXbjbeXZX2qeRyIXdK+MY9VQWSI+SNovaBIvhe4A0YfcDolgRuyhdcfB8kTg//yqnB3DpNtrL0WV97+O1ihIxULnrYdUKatfftv7pt0eksKOPssDZRHYhkV96CmQNPRizv4r60NSdXqlH2vLpvV5oIzX7Z+E/68YT7bxTr5mu8RXoP4tWWKO+H0ltLv8Cei8lkRSHXO/kQ1ZnDO6U+6Gf5GKdrBRRUhtb/wXsA9j4wq6OX1MoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIrhNh+0GJqdrUO/jTgbQ/t3qT4w8Xwi26w1gLs0auM=;
 b=bL5B1k8/tL0ZWkzrTJr98LB03ZiOYaS2qUmqvAB5ByygLn3BmCXVfg0LV1VY5Gbj8Gw5C2wOynwFRWmX/0QN/jtdFcQxEepI2r38AhesM13Ij9gGvcfXGHoE/3wqgzOqqQ5sQHXJG7K8NrdMdiqv5g7+lPwUH0OEyzpvdGV5XMz/JzUV9bAP9S2IeRsgjqfN65UKtCOA+tJJVe6/LlmAbNvziaL90MKYS7CKJ6y1lvif4LhPLPNiyFsxjicGYX9TE4X3lTnrRIxDAEd/3vFk7e3e3+AfuDVZ566zxzhi49wB3vbCQnPe+G2KYx8Gf5PflBIn4tL3J+6gQ0TizIXNvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIrhNh+0GJqdrUO/jTgbQ/t3qT4w8Xwi26w1gLs0auM=;
 b=iVpcO5KxwSZcPDExiT6tQHRThXiX99H8jfyGlt6zkIQ6e3F8wkkqxNAlPjdd5WO5PyhZO7Ue5gmj5i0TA/aU4Pa4Mv7O9KdVd6Jzpn0RcI7DJB0sp/drt4sqDJIDJcJbX+PKIa87YYFa+OYDDJ1P2rhQYM6nytNwaGIiM2InGIU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7575.namprd10.prod.outlook.com (2603:10b6:610:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 12:29:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 12:29:45 +0000
Message-ID: <4ff815cc-6d9b-4af3-a53a-7700a8f85f08@oracle.com>
Date: Thu, 15 May 2025 08:29:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Why TLS and Kerberos are not useful for NFS security Re: [PATCH
 nfs-utils] exportfs: make "insecure" the default for all exports
To: Martin Wege <martin.l.wege@gmail.com>
References: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:930:8::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 5229d9b2-0aeb-408a-e4b7-08dd93ac2cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ME5KaE1Xb3ZxNmV3dlVtK3V5c2t2SkY4Q3hVQmNpVnYwK2dwZzBRMzlmOExI?=
 =?utf-8?B?K3dMak5OeUc4OVlQajkwc2xncmdCbUkzRVFnYkwxVWJ3NGRMZDg5aEVwQU9x?=
 =?utf-8?B?UzllTm1IWGE0RGUydTg5akJZREllSUZGWFhta29sRGt1WXErb215Z25JZ1N4?=
 =?utf-8?B?cWxINXpMN2tTV2lCbUNsdWIyTkxoQ3NWK1Z2UTJsWmZVQ0NnOGpJcnN2ZHQ3?=
 =?utf-8?B?bmdnQnN3YzdobVhITnUwS0hibzBXMXdYaVNYMGUyWEZBZGlWMWo1YldpaWFE?=
 =?utf-8?B?amgweHBmRkJxaytkREtnWDR0YWhLN1FyWjZOZFNkcHZpWUx1cElUVDlxelNW?=
 =?utf-8?B?V0Z1N1JDOWorN0hxVlVmSEppcGg2NWF4MG1aQVcxdlE1NGxLY1NBckpZVDFD?=
 =?utf-8?B?UXhFVnFEMWczQ2FUK2VPUEhMQzZtQUhndGhoaDREVlZBb0VUODJhS1hmb1g2?=
 =?utf-8?B?SVh4RWl5cjJCaEFveXBrUk8rUG1wOEFmaXhBVWRSdHBmTUJld2J5ekxkRnp2?=
 =?utf-8?B?bkYzdDRrRzU1QWdnVWRRMWZGdjl5dDdqU25FRE1jdGJCYnZielFFYXlGRkZl?=
 =?utf-8?B?b0NJY1RNY1pvR2pXcU95anVMSmdUQzVZcS9rMGh6Z0F3Qk95c0tEN3N0REdM?=
 =?utf-8?B?NWFiTy96bnpKNGppM1ZINmRtbUkwcENDSTRZajBCNXpwajh5b3pldk5CQ2hH?=
 =?utf-8?B?ak9vZUQwQS9tdHNYQ1R1bWZBT2lWbTRvbEF2WTZ4eW9La1NUQjFDQzFHNWUz?=
 =?utf-8?B?aWFkLzBTSDBsTXkwZ3lObGhUWm1SbXlTNXNReFZWSnlZdWp2YUVRdEtCb1Fy?=
 =?utf-8?B?eE9XUjg4MGVVY3JmWWVpT05NZkhTRDg0d0xhRXdpZGVpR1FlUTFieDUyOUIr?=
 =?utf-8?B?UjdPWVI5WjQrNzgxQ29PRHozTWd4SFpaeHZESE91dEtXTmpiTXAyQVQ2QW9Z?=
 =?utf-8?B?Q0VENHVmMFZDWGxiZnRiVHNJQ2ZMZ29uTU5HYWtaZ0g5T0djNEt5a3ZBaVh3?=
 =?utf-8?B?KzhkV05GTkFsTDg4ZmpiaHM0UFNEL1hiaGExRUtXNzFwcm5WTEJrT2JpUzVK?=
 =?utf-8?B?SWUwTUUvQnZMSytOYlk3MGdudTZOYzFZYzA2cEt4K2MwaUNnc0ZRTzhSbjNP?=
 =?utf-8?B?NUNtNkZDTUk2VS9RTG04cUo4ckhaM2pvK1loTDNlQUE1RkkwUm9RSURaZ2xV?=
 =?utf-8?B?Z2YxNldjSCtRUnRyTFlQU25UN2Q3ZlA0Z2ZTN3pabWtPcjZmZkZRankwdG0v?=
 =?utf-8?B?TjQzbzhpdEVMRHF2VytURlptWjF3cE5jMjcxS0Mya2FPc2dnRG1HRGt0ZnZy?=
 =?utf-8?B?cmFaM2JER3Z2cmFVRHBQWDhCZERLckNjR0VLc1dZWkpPS01EZ2VvZ2d1ZFR6?=
 =?utf-8?B?MU1qem5PZlpRN3VZcHNlRk5rUmhCSzhzUXhlMGlHM0FQaThBZ20xQzRRYmZ5?=
 =?utf-8?B?Rkg5UVAweXRYSlBYKzZyWC8xRnd4TVFOSkVKbys5VTVlU2lrVytEcUliWWxU?=
 =?utf-8?B?Y09tdHZzOGViSndSb3hZaGY4ai9SMGZPTmVWUWlzTlE1M2h3bmw5dzhrUVZI?=
 =?utf-8?B?NVlmU0o2N1VFVkpUSm1Gb2R3NmFkZGJTbEo3dTZydDR0dklXVXF4cDNOYnBM?=
 =?utf-8?B?bWRGNTZYdE5hRkVYdjNmem5nZDFCc2ltNzZEYXIzNko5enZtMDZYdXBjMU01?=
 =?utf-8?B?cXFSN0lwa1FoaWF5cWVya3BFY1VROGtXaVdkMU9DWGpLTjFhUjRzV3pTN2V4?=
 =?utf-8?B?ZmpIOWVRREQ3YWJteUdsWXozYWdKUEw4dlRsUGRYUnBUU3lIV0tvczFCcDFV?=
 =?utf-8?B?Qi96U2hsM0lDTGFia1VQOXYrMmwzVkJOd00zK2V3VlNiTklnVnFZczNEN1p4?=
 =?utf-8?B?U29ZeUh2NlE4dmRKQXhvNlhXVytrZEpTempZUXdJUlc2R0p5U0FuOHVpNDBm?=
 =?utf-8?Q?z65gC4QtGsM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0U2NjFuZlgyNFM3L0dSam9WbytzQ0NVRUN3djJEWmJxTHYvVDIzUjk5SUg5?=
 =?utf-8?B?Q2U1cWh3VTRsR3hvbEdZT3pFYS8vSFYrRkljSzNGdnJEV3dncFNGSFVxZXdK?=
 =?utf-8?B?bms4amhkeEpNK0hGRDJoWjg0Zmh3OTRDUlFUVXJqVDNidGJ6UElIdFQzN3Qx?=
 =?utf-8?B?YnQ0SmVNWnhrN3RNZkN5ZGp4UUlhQklXTURvdWxaek5IU3VidldvNVB1SW8x?=
 =?utf-8?B?ZUVaL2RpZlBnTkJoUGwvei8xTCsxWUwzd2lYNkQwUzB6UDd6OUE3NVgxYVln?=
 =?utf-8?B?ZkxoODlqNS8yMGZCTmJZVFlvd3hRRHFIYTk2OXdhT3dxZFViZ2JYcDUrMUkx?=
 =?utf-8?B?QTZkczY1anY0Q0hyV0pwcHVOOWJBbTlFenBSdklQQm5YUmJxU25zbmxjQ2FO?=
 =?utf-8?B?THpZaEJ5UE5Ya1c4RzJZVGg2WXFZSUphdHJaN1ZleU5JVE9PTm41SkFyQlFm?=
 =?utf-8?B?SGFiZ2RRSWtaZlZvdExrTWw3RGRUU2NYZFRjaTA0THJBUWh0cWJPL05SbVAw?=
 =?utf-8?B?cXZ6K21hTnBxWU5VK0M0bjJ1Uk0rUThJRitERHpZamZBak5SSVZ0SEVvSCtB?=
 =?utf-8?B?TmxZZCtteENmUDZZOXk1bDFMRWZKUGVzNmllUEhmZVl4ZDN2R2pBanVjdnht?=
 =?utf-8?B?RzZ3QURWK0grUXk5cUZtRzUyVEM0YTdqRE85eVVlYnkwckdtTmExNzRNWEdq?=
 =?utf-8?B?SmlYT3BjaTlrZlJxSWt0SS96M3kycUxKc3hPbHZOT0toa05GR29iTHhYd2Q2?=
 =?utf-8?B?aTkzVXBVSWR4dWZQcTFmWU9UbkkvdjRFVTdlbFJNTndabHM4QU1WeHdqY1g1?=
 =?utf-8?B?NEFFaTB0Z3VOS2JYRllMaTZxNC85dmJmZkFRSFVFS0RnVURtNHJvZVBGa2tP?=
 =?utf-8?B?WVRwYm1BYlNvMFI4bFJJckRZN293VkoraGZ0Y2UyblNlV09iUGk3RDBqYUhz?=
 =?utf-8?B?Z0c0SXZMMldVM0duU2N2SmlUbURrbEtvUUdJdVBRMi9udWlzWmtWYjZxT3R2?=
 =?utf-8?B?RVJURTc5Y2pTSlRwZDkzQ1Iwc0hybE1LYkE2YUQxQTdWRmF6MElZTlNsYUVB?=
 =?utf-8?B?QUZWcGdxb0Y4QjI2R1MzMU9md1NUVWxrQm5LaURCeWNzQkhna1A3UUN6TEww?=
 =?utf-8?B?QUdtdGc0Q256L2kvblpaNmQwYm9aN1R1SXowY2VOK2UzNGN4QmQ1NUo1bTBi?=
 =?utf-8?B?MGFHanFaT2dLS0p0WGcyYkNHbThXcUFiUGlsNjVZUXBjWEsvNFpDRFFNcE1X?=
 =?utf-8?B?NzVLbFkzUkFTZTNrSFhzNFJYWnNZYzMzQjExR3NuYS9tRkpOVzMxZ2RsVmVH?=
 =?utf-8?B?cUJndWZzc2tCbmljSGh3c0t2K3A5cE1hRlZYMytzOE5NYXpMdjErcUJqM1ZC?=
 =?utf-8?B?MjFPU2x1UmJSTzFsTmxpZ01LaDNLVmtER01rMVJBU3dwWHkzRW9UcVRaKzRr?=
 =?utf-8?B?ZlczMkI1WFQ5dmo3R2dUK1dHcEhDaW0xT0txRWYyMTY5TE5NM2FFci9sT1la?=
 =?utf-8?B?Yk5tR3k1M0x4eVlRMGYxMnR4bjFWaHU2SmEybUNrMXhSRVpEelBmTmVkbGo0?=
 =?utf-8?B?ZXJ5Vk56ZC95ZDNDbzRRUVNuTlpNb3o5QVBsKzNoYzFicHlzRHI4UGcyU3hH?=
 =?utf-8?B?Ym5veGFGMWhOZk1xNUZpSVNoUmdNZ0JPUGRJa0Y3QjdaZEdvcVpMcDVLTXc5?=
 =?utf-8?B?cnc0VW16YjlJZWZKbmJQRWNBSTJkaVdINEdJOE9zVzVHSnJ4aWp2UEtLVUtG?=
 =?utf-8?B?UEl6aWxYd2lTanJWY1ZsblY4Tk5iZ1dKTmovQUJLalQ5U0RxcTA1eVJvUXpU?=
 =?utf-8?B?SzNGeGJsbGIyM3NTN1dQUjZjV1R6bmNsSVhJdmdEVlpnaVFCdGphWFJDbjky?=
 =?utf-8?B?WVh3bmgvVU9OdnNVN3lFdDZncncvUzdmV3VNcXhkVkE2bk53NHBBUERTTUpC?=
 =?utf-8?B?SkU3d3p3dEExZExnR2ZBUVhLdzEwS3diZjNDa2hTTHRFZlJmcnltd25waEE2?=
 =?utf-8?B?ZUZGeEMzNGxVVXhYaTBRd09Ya2k3V1JIbXk2VzBGN2JoZG5pbk5vR2xPSDNP?=
 =?utf-8?B?ZFRHa05MVkZOdWt0c2xvY0xnQzBRK3lMaHFPSVFhYWg5YjFKYkJWYzR3RzZR?=
 =?utf-8?B?SzVQSTU2UDFQcHhHV0VYejl2bGhLdmNlK2NDMWxuWlZpcDRTRVl2QzBDRWdm?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KdkNgBtclguOQ/S3YvkLahA/ki7DCfTyArcKQkMGU/w3W/yR1DHda7DAWrDmQPENWbn6W9Dkz7L72pJdK3+82syvabsh+8mgoTfNlrIAY0x/LMv2mfihz4EK0tzZvhjyKxT9yfLPn1Uz99cmHNK9D5Q/umZhzzHQOHzwQgWv8mFkzNc99K+0ZHa5c881XKruUzwxmHoHxbtwulGEwnSR2aCBfn8wJKC7FwI//5QqJF1A4MCD6oZ+byDbVdHtyyIVgZbNzcx0Opw4ZOvDMVD98osPLMavPYcMlF/fgRGcN8ZyTtwuYTjRlDx6ILNySfWh26OTfGngfAUK6SNReAPrP44ADdwgkNWdAtdMncxtFpai4/S/UYGGZZo5AHfJdZOpy5BMKRqpuGQRRirGS1WxaYodboz2Lhop6YmCp5OWDeaZJU+A6+a7lpMdQfmoobNlRtv1viLD5nvDsDPZjYS+dfGrRq1DygTFLPssrROppylwJad2v23NdWk8JsK8iuAwlTkV+ItMyNefFVZImOZRk9gvqnpxZo7G5/bQ6/NCXYoM3uIuY9i5e2Zv+sUT5hg2SvvLZ4jS3DJ3ay64X/6mG0olwFUVvmDHXs/yZDLz90w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5229d9b2-0aeb-408a-e4b7-08dd93ac2cb1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 12:29:45.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAhqANyVEsVGRI+igBJgMR2t7TfQLzCRVgRc3AiywXhZ4iw1Smdlxvps6gNTSFb9S4tWTw6WfuU0d50GxCJDGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_05,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=891 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505150122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDEyMiBTYWx0ZWRfX4tfQwdvNqALq 9wGXPsjARYGTTGkltxzzqrJXza62GB48mEfTDSVwMM7PFUbEyLy6QMrUod/338miCgmLv5hL40E fRTfm0jJwNhluZptSZPKLNEWpc/zo86YhpRWqeNuYRpQLnmBzbqNzbDdShWa/sa6fmzmWyOIwO1
 deYVKtJ2NmGoRzqkeLMTwSxld6sGzENOCXVMcB0D978qQ+iezq+5c0QLMK+BDUwC3pzQiXaPXxc TZo+4gMgV40eXi4pD5MijhPgzZmGvkCYoJhYJKRsmbIMo+CBYrRZ8QWsoTXha5hpi1l5iHeR8An WRn+QiUNdbTqWubl+mCDgJSZlL+QKg8mvcK+Q7lRieTxUkTBCScU5r78VuorbzPsGLf+YS6KefJ
 CM/vDiGSik2B1JcUJpgFPH3u7WbKXGjwSMsLo2cmwr7SQJeVMYd3z9av6BKdckKLzcBYy4Mc
X-Authority-Analysis: v=2.4 cv=EtTSrTcA c=1 sm=1 tr=0 ts=6825de40 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=6nNOuDHurVVFeN1Q:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=Q7vD_1zlNtzHkrZpFe8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186
X-Proofpoint-ORIG-GUID: BbHLzN9LlHvFYBfd9yyIYXLS-Wb3T7_M
X-Proofpoint-GUID: BbHLzN9LlHvFYBfd9yyIYXLS-Wb3T7_M

On 5/14/25 5:50 PM, Martin Wege wrote:
> On Wed, May 14, 2025 at 1:55 PM NeilBrown <neil@brown.name> wrote:
>>
>> On Wed, 14 May 2025, Jeff Layton wrote:
>> Ignoring source ports makes no sense at all unless you enforce some other
>> authentication, like krb5 or TLS, or unless you *know* that there are no
>> unprivileged processes running on any client machines.
> 
> I don't like to ruin that party, but this is NOT realistic.
> 
> 1. Kerberos5 support is HARD to set up, and fragile because not all
> distributions test it on a regular basis. Config is hard, not all
> distributions support all kinds of encryption methods, and Redhat's
> crusade&maintainer mobbing to promote sssd at the expense of other
> solutions left users with a half broken, overcomplicated Windows
> Active Directory clone called sssd, which is an insane overkill for
> most scenarios.
> gssproxy is also a constant source of pain - just Google for the
> Debian bug reports.
> 
> Short: Lack of test coverage in distros, not working from time to
> time, sssd and gssproxy are more of a problem than a solution.
> 
> It really only makes sense for very big sites and a support contract
> which covers support and bug fixes for Kerberos5 in NFS+gssproxy.

Brief general comment: We are well aware of the administrative
challenges presented by Kerberos. :-)


> 2. TLS: Wanna make NFS even slower? Then use NFS with TLS.
> 
> NFS filesystem over TLS support then feels like working with molasses.

We'd like to hear quantitative evidence. In general, TLS with a NIC
that has encryption offload is going to be faster than NFS/Kerberos with
the privacy service. krb5p cannot be offloaded, full stop.

An increasing number of encryption-capable NICs are reaching the
marketplace, and the selection of encryption algorithms available for
TLS includes some CPU-efficient choices.

Thus our expectation is that TLS will become a more performant
solution than Kerberos. In addition, the trend is towards always-on
encryption (QUICv1). IMO you will not be able to avoid encryption-in-
transit in the future.


> Exacerbated by Linux's crazy desire to only support hyper-secure
> post-quantum encryption method (so no fast arcfour, because that is
> "insecure", and everyone is expected to only work with AMD
> Threadripper 3995WX), lack of good threading through the TLS eye of
> the needle, and LACK of support in NFS clients.

I believe the IETF has also broadly discouraged the use of easy-to-
defeat encryption algorithms. Perhaps this desire is not limited to only
Linux.

Using a deprecated encryption algorithm means you get very little
real security in addition to worse performance, so it's not a good
choice.


> Interoperability is also a big problem (nay, it's ZERO
> interoperability), as this is basically a Linux kernel client/kernel server only
> solution.
> libtirpc doesn't support TLS, Ganesha doesn't support TLS, so yeah,
> this is an issue, and not a solution.
> 
> Fazit: Supporting your argumentation with Kerberos5 or TLS is not gonna fly.

I don't think Jeff was suggesting that everyone can just switch
to using cryptography-based security. The point is that real security is
not provided by a cleartext 32-bit word in a network header, and we
should not continue pretending that it is.


-- 
Chuck Lever

