Return-Path: <linux-nfs+bounces-16346-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBDAC57F91
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 15:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 749CC350823
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D300281532;
	Thu, 13 Nov 2025 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DltT5UjC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yef3hnbt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABCA1A83F9;
	Thu, 13 Nov 2025 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044695; cv=fail; b=HYl89j9ytDUs3cxq+zT8i+X69km8LJm7ytnifc6+2dmUMHRZLrYKKC4GvzrucQnJsHyuCpVu/mSAk3P17dbML4PyJ5DxY+8tRbtEld8PoV7y8mRK7xY3uTcpOItuNGyZ8MvmLu2gSfwGrPOlILylDRO+9gnfcL7SE8q2hzwMy9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044695; c=relaxed/simple;
	bh=HWTOtY9vycMBySJkbh7bJ7WzwQm8UHEoSdOpLOECCO4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hW5RGXGF7lb9QVECNrtkI1+kbiTSiMIdVpwmq8O7YvD+7lg1MLCSePHkiUZiE7woJoE7co+Dc3LVQeZRrWNRo6XVh+y9ooi0Aq8OYysdTjQKNTgtrdfv8YCL5EExgGRDo2VlpGiJn5+OskvRN2SZnruBaiYwcNniXgIK9rdFWJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DltT5UjC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yef3hnbt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9thX027934;
	Thu, 13 Nov 2025 14:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rm2rxRQpWyflX4FGEZcK4FqqI8MD1SnlPDeag/d/VIg=; b=
	DltT5UjCDQDdkFZG+h7t+7Uf/xsHHQtjf1mAvkF2r+BE8qqKywxbGa9Ha7bd4ejI
	4VR6WSchlwRc+DawJs4uccB2VXgOpXxmcwft2cUM7bG8nNmcJd4zR8LRG/aQ/EVi
	ryc5pbVwINe5s8X1IQlNBb2bLbhFqLblm+NjeHTW/m13OGUxQSv6eCpL5MoiWgyt
	Y1iH75OmOf3Beol0Zlk6nwvqMD48Q0q6F6lJW2sSCbZkov4oPW5qmIB+8FOaHq3J
	KM6kQ36jtXhb4VbCdWVgEuYZ0Ki6lkZzWrSGr05GqmMpgSG/nb1fmjGph0YZl1x0
	VfMSWs0lDs7qEQpahuFTXA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjs9wcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 14:37:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADDwO8t027744;
	Thu, 13 Nov 2025 14:37:47 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vag8rss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 14:37:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwyTk07LHL4fFWPgSugpAfJVB2RtyahiZMXkaMNB7rs9JQwVQ3jyy3AOLBhsOXg8J3E/92nOfoHpdVKrr19FaHx+O2zASKobUp59eaPWXP3gcvV9qpeRVDGBGezSbNcsHesrDMGSLcAnevuDFKGmRKPtzCzqM+V5qGdIAGSSE5jPL7eCB+khp6NYslGcuVORpCMpdoCqqitomB5FIk/FRM0leI+ltBZqVSHFMJwox7q4BD3wB3Rf22P4KLRvAhZpUKf1KyTEG+kmqYd2uIMmoEXJd4TfMvr6AfR9ItJduJgohfT6eDSDAqIR0UElOiQOFaN99Uoy5FkR3s8l6oHpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rm2rxRQpWyflX4FGEZcK4FqqI8MD1SnlPDeag/d/VIg=;
 b=Zdu9MNH/tSeFIaHApmUqzAVYkpTocWS9NN8dYYvMlytlFKhY8LfcAprwNJxrVacc9mCMComhHurrgRwmxWQlbslT8p7rHQehCKV7CbPARmPEiUy5G+yJpv7U7vGsTxaW8Eind1PrdSeQb0izbUjZ/kM8zbmXRjwcJB7lcMWMIrb8+OP4CUxnefEAi3Usups00eK0ECDgtL/K3ai4WfQkWkwB/QBZVS6xwbxnoU2F/QxnhH40ZeX3tOTnCpWLulg+LDc7GTtnqMGp5Zk3Um7VqZGc8JdvB4N3A8GQ7//iSMzZhr3suSFkkClhnUZCrig4g6/7yuDiQkyslAJBSAIntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rm2rxRQpWyflX4FGEZcK4FqqI8MD1SnlPDeag/d/VIg=;
 b=yef3hnbtlBopul1kye5Cc77z3+KnsZy5Avb0Tc8Y1egON+QnsPTmijhfm8ctuWwhj9TvrOG+LXzouGiCvic1rjoJcXI7v++HK6e+3kw84fwppJhtens5xWsqBX4Av7WwLEfGpcwQAAojvMZatrz1vMeCmdQLoleb5OHLo0uCu9g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7298.namprd10.prod.outlook.com (2603:10b6:8:ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 14:37:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Thu, 13 Nov 2025
 14:37:43 +0000
Message-ID: <13cf56a7-31fa-4903-9bc2-54f894fdc5ed@oracle.com>
Date: Thu, 13 Nov 2025 09:37:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] net/handshake: Define handshake_sk_destruct_req
From: Chuck Lever <chuck.lever@oracle.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: hare@kernel.org, kernel-tls-handshake@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-nfs@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, kch@nvidia.com, hare@suse.de,
        Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-3-alistair.francis@wdc.com>
 <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
 <CAKmqyKN4SN6DkjaRMe4st23Xnc3gb6DcqUGHi72UTgaiE9EqGw@mail.gmail.com>
 <0d77853e-7201-47c4-991c-bb492a12dd29@oracle.com>
Content-Language: en-US
In-Reply-To: <0d77853e-7201-47c4-991c-bb492a12dd29@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:610:4c::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: af79b02a-1cad-4519-7d33-08de22c234bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXljSDZCYlBHa1E2bXBsTVI3M2RreTBHYmtucXdPc1VuamJGbmkvWDJDa3M0?=
 =?utf-8?B?Mk4rU1dHWUdBdzUzWlhlVnlwVFg0YTMyTEtOWEF6dUZtTld4bW9ZMFdoRzNr?=
 =?utf-8?B?c3VLYStmMEVxdklRWDF1OFFXbE9NNGdSWTlOdDg4TXRrN3pRa2U5UkNMZ3Vw?=
 =?utf-8?B?cmNaZndjWEpST3JFVVRQZFlKcEgzc2NpTmlTY0lGWmRjWFFwelg4WEtmd3Nu?=
 =?utf-8?B?ai9rbURCL2JsYlFqK0lidkM1Z20zUmttRmtBVTlUNjVhWGlKMS84eWpwS1hC?=
 =?utf-8?B?UFRDdzZXQnJLbkpjeDdNR1Z5d3FpRUtPUWVwS2FjUDRhK0NsYzNyekhTZG1a?=
 =?utf-8?B?V1VSK3hhb0RBSEp6KzFpSVY5WERoYVcwQ3o5cWpCNHdabjY1MlZPU3ZvSDg4?=
 =?utf-8?B?NzI4SnNTNSs1TnlkSGJER3BsL2oxMzZhY1BrSktkdWlSUUR0NVFqcHdUbUNG?=
 =?utf-8?B?T0dvbzl2YkRMYU1MMWNoM3diN0UzS0N0NnR3b2FEVjB1c25oTnFnTTY3RWs1?=
 =?utf-8?B?RUM0aHoyK2VXSlUvMHRkREJvUVU5WTVYVWNTNmN3LzJweXBNN2tvOU9YdUlW?=
 =?utf-8?B?T093WFpLcTN0TVhIQ0tKdlVLdEppU3B1aUNmT29BMDNGcUliV2J0VkRCRXV6?=
 =?utf-8?B?RERiUjlNdkVDcmRTYS9yWEVNSW8zZFA2YkRPYkREWEtBdjBVSTJvbyt1MGlZ?=
 =?utf-8?B?VzVSZ0U1SVFaRHhpd0tXN1hOMEZRUkNuVUROc1ZRSnhhakk0aklueVBMOVlU?=
 =?utf-8?B?Z2o4dzZKT0MyS3FCbEFYQnBYRHptMjFRdEVlZ1FXV3J4enoweVlUY2hEdWt4?=
 =?utf-8?B?TVdFMGg2Q1NHYnF6dmc5QUJGampYa0tSWjVDZDVWaE9sb1lrY2hSNGZ1Y1pD?=
 =?utf-8?B?cnVoY0FKS2hxYW02ZmhvOWxWemxXdmgwUDlBMmtVbmx6TGtPejIxdFQ4RlRM?=
 =?utf-8?B?TnJmc1drOXJNN2FCeDJ0S0YxR0FZNnVVaGxmbzE4aHdxcnBEd0pEamZPclZJ?=
 =?utf-8?B?MUJNRUk1cHY1dGxwaU4rNDdrN0xCSnJzbkdoNHR6Sllid20vSGhLQWY3dEl1?=
 =?utf-8?B?cmhzRXFvaFhSSEh2bVViUHEvZ3R5M1FmSTk4Zkd4QmRmNmFzVjlRM1hjeUxW?=
 =?utf-8?B?V2k2dGRBd0JxbjhnNjloYWtpalFORTJYVkVJOTJabTh6aDdMTGRLOStYR1dD?=
 =?utf-8?B?Q0N1L01BMjBXa3ZHY3lsRDdCbWNYdWs4dVhPU2txWERNNFRaR2ZmY09XK1dh?=
 =?utf-8?B?QjV5V0lGSnYxOW5SbGN0ZWdFODd2ai8xK0ZKWGY4ckhHTzlrOG9uNVE2ZTZu?=
 =?utf-8?B?QlRJZXYwVGV1WTVzWHJHbE1neXZJYWJzb3JLYnIya2ZYTmU1bTBFSGV3UGpM?=
 =?utf-8?B?OUpRTEpOZ0w3QTZpU3R5YVZ6Mlc1THoyUThEMnpWdzUyYmZWd2pMWE5PTjZM?=
 =?utf-8?B?ajBGWFgvQzhQaG91a0QwbXF4L0hLT0lYd3VXdzJwbTM5ak9CemtMcVlrdTdt?=
 =?utf-8?B?ZnV4VlBwdU80dmMyejJnS3l1TlhIb2hDekVVbWhxTEdRQUtIek5GOCtrNnpV?=
 =?utf-8?B?K3IybUVBWnFUakV2TEdTTzJ3cTBReFVPRjhkS3RNS2U0MHZLbld5ZUdkRWJn?=
 =?utf-8?B?QjNPSE5nOWRxVVc3dGNjRmJuTWVzQVVjeFhnU2Mzc1ZkUkxQOVZtZDVsaUIr?=
 =?utf-8?B?RHJjUVJMNEF6VDNhVHRkRjdtMFc5L2poandoQ05PTTdEMzgvSFFmeWpHb1Nw?=
 =?utf-8?B?dnZkaStGNi82TURNS1loUmRsNWgzaEF6MXJubFZLY3RvOExsNS9OR0tWUUM5?=
 =?utf-8?B?QUlTaXFBTktNcVBobWpidkxiNkl5QWxBVVFyZzVTb25ZUjBZZ3htZEh4bVlK?=
 =?utf-8?B?S0ltMlMxNWlNYnJZMURCN1NYZDc4OTdFK1JVZVJQSXlHZ3ZjUzN1SE5GQ2x1?=
 =?utf-8?Q?0oILMzkgc81GbxvHjV2ToWxC+SzWGKHZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WExSMnpWblkvazJiZ3B0aysxZkFyZmc2VU5DcFYrbTI4L2NVelpaT0lOaFpt?=
 =?utf-8?B?ZzEzNDF4TWVuV1NsV1JreldWSklZRmUxWFdDUVVzTnRmUUd0cUgzQjB1ZDlB?=
 =?utf-8?B?bE9yZkZhTXhQNWdjYlRweStmNElSSFNlcFhZY3VTQjRvNUZYTjJLRmk0UkMy?=
 =?utf-8?B?aXhtZnhzK1k5d0NDaEd3VlBmZ29iZ29LNVRxZjNlY1ZERHduWU9ZWVF0VWJr?=
 =?utf-8?B?R0U5dW1GdEZVb09lemxWbGxvOTVCeGlKOXA5NnZuZHlaemNCeUx4bTFkZEpO?=
 =?utf-8?B?SFo4WFZvaUtBYlBkbGNwaG0zeGdRQWJLazN1UzlRQmdzYUxpLytzVXp3UUxC?=
 =?utf-8?B?QWZaUW1WamtNUXpTc1hrZ1M2ZlhHamY2MHNVd0ZMbXNZazdaK2FUd1pqYWhy?=
 =?utf-8?B?T3Y3bmhkcmNVTjNEOENaTmFhRlM5ZGZNaDBJWXM5RWpRRmM3dnA2MUhSYTVp?=
 =?utf-8?B?ZitRUld5dFNBRmp1TThvYXZhQWUwK2JFTmVyaWxJOENBSXRuR1VJcDZRM3c2?=
 =?utf-8?B?M0hKMlVSejQ1RFdNakJsLy8vbFYrK3JEM0xIM2hhUzFBVEgzdHJjWG5YOHFl?=
 =?utf-8?B?MzlySnJBZ2RKb1p4M1ZoMHlCYWZLMlROY0JhbWJiN2xOMTZTZ2ZUMHczZGRp?=
 =?utf-8?B?UlgyaHh4bWxJZmJsMWNGdDVzMnNDQTJ6ajJOejlwaFYrWWZhOHRQblNvcFRp?=
 =?utf-8?B?MEhDdnBWd1h1U1RudXpZbXk5ajQ0ZTU4TEJkeUtwSmJVN1NsOGJKQkNEYWNY?=
 =?utf-8?B?UXluUm5aR3hvU2JWRlFRNkV3b2xyZXJNN1M0S3NWL1FwS21oNGRyNndMd2pu?=
 =?utf-8?B?R3FzRk1JOS8rR0JtSUhreEdtalFqdGZvZTFWZnU4R1VpN013N0VQY2dhYUVF?=
 =?utf-8?B?T3hyMElKNDI5Z0JwY1hqdkoxVFg2T1dxMXBNV1NIS2RvZjJaWElrUFFDekh6?=
 =?utf-8?B?SGJ4R25jaVVCZm0rZ2U1d2FqV3hmeE1LRUhkTTUxS1dBTDJGZ3NmQ01xVWxu?=
 =?utf-8?B?ZEVZUDdzdFpWL0o1RWpLTGdrNFJ3a01vbWpONkpEa21iK1R5WUNqRGEzb1dy?=
 =?utf-8?B?bDM5T2dNRTYwK0lkaDdJZVpjK05KNjU5MHcxa3hlS1l6VkpuNHc1ak1NOUZ5?=
 =?utf-8?B?NE9UZ29kTzZJdFh5NWhZcWtpcUN3UWdja0R3dUZPMDJJZWtzNnRIVkJLS254?=
 =?utf-8?B?SU4wRWN1OTEvT1ZjTFpDR3NoUXBvcys2MWNHMzFqVU40Zm5nK0ZYU3dEMjBn?=
 =?utf-8?B?VVE1c2hNVTVTUXZ4dHU0Sm9GaldVRjh6OHllRXQ3a2MwaEFYTlkyMFdhRlE4?=
 =?utf-8?B?RWtZNEFmallyS0Q0OTBWZ01jWHZlMmI4RlZPa2Z0WjJrRjdrSUlmUXFrL0xh?=
 =?utf-8?B?ZHRGWnF2VlhXNkhJRzhvbWFESWlzbXJPd0tOdHNTc1V3Z0hMT2w3Vyt4VXdO?=
 =?utf-8?B?SXMwUGh1bUpGSlVWT3pPaHhoM1o1UGJkNVVkTjBtdm5ReGxlMzQ2Smh1ZkNU?=
 =?utf-8?B?cFljdjI1T3FRV2hYQlp4dDRRSjk5Vnc1VjU2Mzd6T2htd0ZOcnA4eWZ0U09G?=
 =?utf-8?B?b1U0VVE2SDROZTZlV3lxNGhxVmE3M3UvbTV4YVVQTnd5cmorS2t1NnUzSlpp?=
 =?utf-8?B?U3ZvVmtLaWhWQ3dOVmE2WndHNVdFRE1ST0NBOE0xZWdadThDdUpWNkNvbDA3?=
 =?utf-8?B?bW4rQ3VEYUFENS9wUEQ1SG9tOTF0ZGtTKzErN2JRUkNDMWYrQ1JsU1dHRHhI?=
 =?utf-8?B?Ky9aaVBXbFZzRWxIZmpuY251NVl6YXA4SEdzNitncjFnZmt4ZTBSMjhLUXFV?=
 =?utf-8?B?VWdGQlVIVUNYak1jdE5aRG9DdmQ0Nmd4cllTT1F5TWZueTM2aXdzeDNMTFRR?=
 =?utf-8?B?RDJobEpWSnB4dHZLd0tqczNFU0xySzZnRVFzQ0h2azA5RCt0L3JQSnUyaFpv?=
 =?utf-8?B?bHF1WnFldTZTd3g0QlpWZUtLYmc5ZEQ5VVNUa2svazI5aVdPN3JLMjNYS0JQ?=
 =?utf-8?B?Y3JmQWtpNXFUZStIbE9NdVAyQ3RsZ0YweURaT1ErTFJLdGlGb28yRi9DcDZ2?=
 =?utf-8?B?SVJqaGpvZUR0cVdNVzZlbFc2SmY0RlAxbStSYmorZlpKd2tiUWp0aFVkTUVX?=
 =?utf-8?B?MDNrR082NXg3ckZWQ201VFRvMGJZQS9VcXFwY3N1SlN2aFQrSHE0eGVxazZB?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ByEo06UnbGpiuNfjewVntVn+N5HfeB6QQ7wmiMW6auFG1RbNVgXRz5jIaGDuBBeH5F0Q8fLPpP2nTbIISc1AbxFvVKFi9cPapbpI7OICBzUjjEToB+qdMR5obOQhMNTPNZ99g5NcRRc2tbCnYhoKxF8Cuwjkkvdj+qi15rUmyHxCsUC+hWMulAMZa1sEs7jgdPy7iDhwE7aKDO8CX7w2iVyHBWiFW+s1Vro0hc6zTj1UddCkgSBCtNNRrgAaSOVrQOmrgcpROufOH5GVkT7Fq+n6bFSSENWfknWbW24yA+3aDzKT13/Dm/qXQ97icdakBJfEM2//IPV/xD4m2BZJxMeuNe0k67XEeALoNTdS+Ve/5MEDFxow/FxjS3FzhvKE2n5s0NXGugf4gkEhUSV8Dlc68KsgiKAlM3iaOBYzKlGgHiT/iBFUxO9bo7ECJpr0M++xUQZOmR8TRRMOSfHl8/VRHlceoan0NFzOyA8DgJY9bWjz0ksWEphIOXf5iNw5t+FepH4wtmtMjRKcc55vCYL3DjKw4mDoZzknO6/m1l9T6L4Bz5f+T73sYoMEaAdRQWoS1Qt2J5zsVuFUlxFihBDAeUGbug470i2xmZj4oJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af79b02a-1cad-4519-7d33-08de22c234bc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 14:37:43.7931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pe7kYEwrBZrqOG7HbHDByxTsUr3p2RvpIYb9n4dzTYmFj+E940Fzf2Bz4wmp3GkIUwDDkfrRsU86rS9a8z2uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130112
X-Proofpoint-GUID: 9jHVllpkIXS6kMZhQ-fivAyoEPlipuT6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfX5FW4VUQ4hbAu
 4SP/A9+SRQcb6oPRriU4CaHnfClLE2Pm06SSnzincPUugujsqyCY78t0XZoaPqD23BLwRH0A/dV
 upahQ1EcCTkq4jGXxyn7YobUL5dgmb64y866v7vmwYhHCivN/TQyvvMF1tODB9FJxvDFMiZhh12
 wTUuJ/mJq7y8H1q0vmY/ML5Ny2SZtYpBSzSe832lJQnKzUwXD2oc2SZjwEgnUbLnpkaxQhrSugj
 zvV4UqLJDEuTGfvqIQCkxzfttos7qJIAIJkTEhGBzzVkdj39nQwAPg1a5KJvsVDKrWy6yVKqcaB
 x3vtfoMmFH8EfFHevqQGly6fGgrNqkMVUpELAamdaB7YJuo5ZFSId57627Fl7sHgrDfBhF6DWVH
 j5hwbyLwYZ6miZL/glNBoXnQca3QfL0zWb29TIOrFCACQ6Gmg50=
X-Proofpoint-ORIG-GUID: 9jHVllpkIXS6kMZhQ-fivAyoEPlipuT6
X-Authority-Analysis: v=2.4 cv=HLzO14tv c=1 sm=1 tr=0 ts=6915ed3b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=_OaH9TiUWISvIOXzOnkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 cc=ntf
 awl=host:13634

On 11/13/25 9:01 AM, Chuck Lever wrote:
> On 11/13/25 5:19 AM, Alistair Francis wrote:
>> On Thu, Nov 13, 2025 at 1:47 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>
>>> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
>>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>>
>>>> Define a `handshake_sk_destruct_req()` function to allow the destruction
>>>> of the handshake req.
>>>>
>>>> This is required to avoid hash conflicts when handshake_req_hash_add()
>>>> is called as part of submitting the KeyUpdate request.
>>>>
>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>>> ---
>>>> v5:
>>>>  - No change
>>>> v4:
>>>>  - No change
>>>> v3:
>>>>  - New patch
>>>>
>>>>  net/handshake/request.c | 16 ++++++++++++++++
>>>>  1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/net/handshake/request.c b/net/handshake/request.c
>>>> index 274d2c89b6b2..0d1c91c80478 100644
>>>> --- a/net/handshake/request.c
>>>> +++ b/net/handshake/request.c
>>>> @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
>>>>               sk_destruct(sk);
>>>>  }
>>>>
>>>> +/**
>>>> + * handshake_sk_destruct_req - destroy an existing request
>>>> + * @sk: socket on which there is an existing request
>>>
>>> Generally the kdoc style is unnecessary for static helper functions,
>>> especially functions with only a single caller.
>>>
>>> This all looks so much like handshake_sk_destruct(). Consider
>>> eliminating the code duplication by splitting that function into a
>>> couple of helpers instead of adding this one.
>>>
>>>
>>>> + */
>>>> +static void handshake_sk_destruct_req(struct sock *sk)
>>>
>>> Because this function is static, I imagine that the compiler will
>>> bark about the addition of an unused function. Perhaps it would
>>> be better to combine 2/6 and 3/6.
>>>
>>> That would also make it easier for reviewers to check the resource
>>> accounting issues mentioned below.
>>>
>>>
>>>> +{
>>>> +     struct handshake_req *req;
>>>> +
>>>> +     req = handshake_req_hash_lookup(sk);
>>>> +     if (!req)
>>>> +             return;
>>>> +
>>>> +     trace_handshake_destruct(sock_net(sk), req, sk);
>>>
>>> Wondering if this function needs to preserve the socket's destructor
>>> callback chain like so:
>>>
>>> +       void (sk_destruct)(struct sock sk);
>>>
>>>   ...
>>>
>>> +       sk_destruct = req->hr_odestruct;
>>> +       sk->sk_destruct = sk_destruct;
>>>
>>> then:
>>>
>>>> +     handshake_req_destroy(req);
>>>
>>> Because of the current code organization and patch ordering, it's
>>> difficult to confirm that sock_put() isn't necessary here.
>>>
>>>
>>>> +}
>>>> +
>>>>  /**
>>>>   * handshake_req_alloc - Allocate a handshake request
>>>>   * @proto: security protocol
>>>
>>> There's no synchronization preventing concurrent handshake_req_cancel()
>>> calls from accessing the request after it's freed during handshake
>>> completion. That is one reason why handshake_complete() leaves completed
>>> requests in the hash.
>>
>> Ah, so you are worried that free-ing the request will race with
>> accessing the request after a handshake_req_hash_lookup().
>>
>> Ok, makes sense. It seems like one answer to that is to add synchronisation
>>
>>>
>>> So I'm thinking that removing requests like this is not going to work
>>> out. Would it work better if handshake_req_hash_add() could recognize
>>> that a KeyUpdate is going on, and allow replacement of a hashed
>>> request? I haven't thought that through.
>>
>> I guess the idea would be to do something like this in
>> handshake_req_hash_add() if the entry already exists?
>>
>>     if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
>>         /* Request already completed */
>>         rhashtable_replace_fast(...);
>>     }
>>
>> I'm not sure that's better. That could possibly still race with
>> something that hasn't yet set HANDSHAKE_F_REQ_COMPLETED and overwrite
>> the request unexpectedly.
>>
>> What about adding synchronisation and keeping the current approach?
>> From a quick look it should be enough to just edit
>> handshake_sk_destruct() and handshake_req_cancel()
> 
> Or make the KeyUpdate requests somehow distinctive so they do not
> collide with initial handshake requests.

Another thought: expand the current _req structure to also manage
KeyUpdates. I think there can be only one upcall request pending
at a time, right?


-- 
Chuck Lever

