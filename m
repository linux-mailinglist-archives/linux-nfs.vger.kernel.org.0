Return-Path: <linux-nfs+bounces-21703-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB5HL+VqDGo8hQUAu9opvQ
	(envelope-from <linux-nfs+bounces-21703-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 15:51:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 375DC580069
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 15:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB8903089B4D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 13:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA8F33CE88;
	Tue, 19 May 2026 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DpZQMQ4M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="exsyzgpy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF65E24DCF9;
	Tue, 19 May 2026 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198310; cv=fail; b=RJ4ev0pKLdKJ8OUWHaqLM64YsUR6Lujp+VY4JYlvySZvhB8WQJfEIi+MNKkCBwtBE36w+rlPcngcIC+fHNGd/oTl6CCkCeXhlPVzoJQxHChNMZHXslVYnFP1tgNidirSGYO3OrEsg5YJzhkwW8l5peaAMaBPhxwrbQj5EhCOnFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198310; c=relaxed/simple;
	bh=ucqLe/rhi895I/e8FX4crIzTGtJzizPg9SqsLJhoNe4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FQryzUJ3cHeYHq2jnZzXcUBupJkws6PXXgZRKxzuJhx0oNrBulWGi1YUN9ss8O37lRfLedz+kA6IuMZJikfNtQ8vrfym1EVTt+7bSc/XzCoUJlaCnVQDOhPG8t26bszCQ8U6iZI39xVFeZgfTWuBxb6zGf9LnebU6TdDMVsEM2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DpZQMQ4M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=exsyzgpy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J6d3DA2172375;
	Tue, 19 May 2026 13:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=c+SJRxDPoOhdf4JO5fKDBtL/h0+t0VVyCj/vE4O7u/0=; b=
	DpZQMQ4MYQEWqo1vXP9iE+66tBggM1ZyJ5kQrLrJ1GYxJV54z84MYx6AM2CIE8vk
	S76ajHhXY8IDUY0IsIAsWyj9u0cAL0OOoe9bk79zgNAZBelLanTIpg1Hgqo25x+y
	Ry/rPaopdX8EBSkzBL87EyOF1+uRRvWbZ2PiiupQ+ivtnONzajtugEAc0l1zYuTA
	8EVrLq9ZuKEkn7Y9QW7eBQrsDsZxSIYaZiA+FSPIFuXtc/H/MWNAWXWabGXXaeMD
	3ym77H/Wf5QLzi61slnBtSQse429mdWmapFbAYhZ7neANdzg2BSnSczQvKWfLpyX
	wQnh1j1ae5vbskbx8y511g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h2sbys4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 13:44:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64JDihV3010909;
	Tue, 19 May 2026 13:44:50 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1atchv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 13:44:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KortBJcItry/edYAEpneDIZv4HvtoxbgU74Ber2TR1TR5re5wVQmVuxa2bcRHf9KWY1a0n49tmfYQRLZRambo+O+qHSEHDQC8Rx95FvZwnYzDzEQJGj9kRgq41MNI1oxLfGyY5S/35tOdzLMIQXOpBlo6d05JyM80TfMiHxia2PTPUuUarcAIOsuuoutm5wQ9CMPZSqjxU9Ka3MLVvTkmw4380PEZFKTotBVjiRA4JlkY9waRNOtxukM4ZPYT/mZBc3jMNF2S7FtajJXSsKy95ePfBvWLXDht7CulUJpwu6sMgL/0QOrK7qEbWrEUg8WBdF8AbMMSHzB37DM05l+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+SJRxDPoOhdf4JO5fKDBtL/h0+t0VVyCj/vE4O7u/0=;
 b=cmPuSSbjWryMvq7uJiirA7GS54IfCvbpNrYqfjYDIGjAbpDHVXvc/bxBvDJeIqJKjBAqqSnnjsfYUgvm4+G5DNv9d4/tRkBs7dwFCs02kxzqVrOqcHfosjDT71u1Y4L09bl/qQOxKPCO3aFNnQSEC8ND3rEhEtKPiNyvmk3AXi1Kftos/q5r83Fo094YX2cezU6P/4oHBLvtfH6hGL6JvkO0dpinGOl5yo2p38pTtNKkaPImWnmwMX/qbYeBVOZ049KiAwFaUr392Z8ovFziESTLM6knzyFVsG4rpAW+S77yAskPVqmQTYMzJVoWyZWxbQWHZsc0JHpUgBeeXvLgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+SJRxDPoOhdf4JO5fKDBtL/h0+t0VVyCj/vE4O7u/0=;
 b=exsyzgpyMWNP7jnxALn0Ws+Ierj/pcavrlkSpQCzbq7V2KX+u05io5mb6kXq4VdcQ5FitkGH4jjcIPmEH60AXvqX2ZICJWli4jvewxGTnIAC7pgt0iM5n+0XwCcK5UoPWL73juxi9sbi7XV9KXG3F25aog7k1eqTpRS/m7GeMt4=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS0PR10MB8005.namprd10.prod.outlook.com (2603:10b6:8:1fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 13:44:21 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 13:44:21 +0000
Message-ID: <55c7c22a-8edb-4833-be3f-1f6555ba90ed@oracle.com>
Date: Tue, 19 May 2026 06:44:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <dgc@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
        cem@kernel.org, linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260512172238.2495085-1-dai.ngo@oracle.com>
 <agQhzg-0aeISwOGW@infradead.org>
 <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
 <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
 <20260514002513.GQ9555@frogsfrogsfrogs>
 <26365a46-bdac-4e8a-a951-de904c3e5606@oracle.com> <ageSguSyf2kBY33a@dread>
 <b9860332-7b1e-448e-869a-ad59d8d5b7c0@oracle.com>
 <agqfBPRWXQDR2ImG@infradead.org>
 <606c4cea-70d2-4601-9db2-611cd35c3687@oracle.com>
 <agwDhixPAAA0-cTa@infradead.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <agwDhixPAAA0-cTa@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:610:50::36) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS0PR10MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 67488ab7-021a-4b51-31f9-08deb5acbb15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oIcZzYkJTIRYXcEvU8r7D7/jQh3XzRmX4c3qsp+/56Pl/8XuRFJRe4YBMg8qYIy9IAnuJInuQwnUTnlkInck/Ncr8JlcYpI3ZqcEQJbvFO2bRggGTE+pC08FIEugslIR+1NRo5NA4+yFGz5sFDsWr3D7uhBI99vVdv13GDAmI/4fwlqafG8ywKNO08sElcNntercNX9BwDTWXMjxPR7fIGws0DisVRJsxcLGHMrsc1Z4Nnf/GL4bPfvs2JihUtPhGAGZnxPrzYH3uoPE6kZwt7erZLZ+2dLvbVYh/8Q2JeuK2NQe7isicBAV272MRW4FOf4BJDjZLB4xMHBM4NTssh5/8VTlTO8I8Kg/06oxkugbJ3P3LO76R2zWj3+Nz8TfksUc6kmcwZu/Os8acEsPqzX4Qs8CPAD8DC+RVOIDwX5NS68ni4zqI77rMxVX97n4D3xsMrI8TeNrXqJQsRVY892HsfO0gIMrdYObcRHeJMHXAQaYpT/eyfHV6D/oWqdXtEtkE/2GNvt1MQE7CgBtzTNj8ejTlo+LEmXUwKYoX/L6XtPUzW9x1LhrXH3lBQfjSpcMk43AEvfQ4DGgITn8zOqGbYGu39+RI6OtDhshDzdqeo6QoUFA6nwyjaViN5e3p17wNx23reiSgO2VW4kutP2vqUBsg5hNQjnjwPKxTuUttFUyulmaxXVoZE26SapI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elRaZ0Q2dnJwL29ZMGtFRDhyLzdqTXpQYStMSTJ3V0RCODltbGduVHB0cFcw?=
 =?utf-8?B?L3JCdTJDREpBaGtOY2JHOEVMNG90b1RTeGN1YVZaTnZHTjZPaHR5MXdYTFBu?=
 =?utf-8?B?Q09lQ3pLL3NDcmdKVTdkQnA2dWlyRGoyQUdtaDVRcXhxWHFvaE1QZFdOejFG?=
 =?utf-8?B?RjgrRiswcU5tSFRsUnJXQTJiQklVb204SUlQbDFyUXV1RzJnTVFaV3U4bWp4?=
 =?utf-8?B?SjZ4UmlLdEhaQ3NZMXMzUUZCMlN2c0huK2dOMUhOZHBRZThqNHVkeEhncUFs?=
 =?utf-8?B?WVEreWFINVhJR0tsSFZyOVhySWpqQjhVZW5BRkpLRWt0dWdGVWtNNUtjSmhr?=
 =?utf-8?B?YnZxS1I0SFRrcGw1dnFMdzRPK004NmhGZTI4QTNlMlBjbDJYVkJST09ZY0dy?=
 =?utf-8?B?a0kvTWNxd2NzWG4rbU0rMVJoNXVkZlZBSXE0dDZtTEdtRDJvdWp2azRoRlJI?=
 =?utf-8?B?YkR2Q295aW80VUo0YTAvSmtoMWM4STZQamdqZVNvTk42S0w5cDc0WWk2NlpV?=
 =?utf-8?B?d1pzTzVabVc3NTlENzhEam42a2FGdkMyN0dXZ3orazY3RFJ5ZWhsK2pBRGcr?=
 =?utf-8?B?cjFLSFpWakJvU0d6K1dFMXltZkxkYXk0YVZZR3RLVW52My9TWEVNbWI0UmJJ?=
 =?utf-8?B?eUVKRTlzZjNxMkVxOWx6VWJkalZlWnhqWlhUWCtZOVNVamh0Y0ZLNTNic0tl?=
 =?utf-8?B?SUpUOUJLN2tyTVB4RW1oT29BQWRZQktMdEVHNU5DcXIyQkpCaUV2MDY4Tlhv?=
 =?utf-8?B?WUFZZkN0TTZRa0Z2TGxUSmhsZjRySE1ySGhFQmJqeGEvMHBodVo5OTlWcHZZ?=
 =?utf-8?B?amhqbER1cDBTTm9zc2ZRK0VXYTJpRkdjVDdsRmNZYVFtS0Q1VUZ5V01wdGZU?=
 =?utf-8?B?d2J3d085OGhlWE9jN0t6c1JMQ2NKRHI1UkhPZUZMcTk3L3gwK1JQMU1scWsw?=
 =?utf-8?B?bHp6QUhIdytCOW0rbytMZGRmczA5SUJxT1FubU45b2JXa0lZT3F6NkpCSDZO?=
 =?utf-8?B?ZDRuay9hVmhqVm1vb1hHMVQwZ21KUENVeFN3dGdwclFSZXF3RjU4SkFtOUts?=
 =?utf-8?B?WXNUNlRJTkdpM3dQYnFxY2Y4YXUrYXVRWUZPYmdtSE84ekpZWDZLV3lFN21i?=
 =?utf-8?B?NzFsTEM5Z3hnSXo4RjVVZkI1YlJ2eEREazNDcjI0QjhuMStWdzBkSjRtVXVL?=
 =?utf-8?B?YkMvaWx2OE5zSHU2N2dYS29yaThnV3BzRSs0aUp2ZEhjdFBnUUtHeW5ja1pr?=
 =?utf-8?B?VkpoanMxU0RuQU51QTdlL3RPVkQxVG5YMVQ0bjlabmxGRkhhdVg5dzZMSy8x?=
 =?utf-8?B?a0JuNG1SOXhHVjI5QUhSV3llTDE3NDZlbVRMSDZ4NWlYOVZrTVVQajRMdDda?=
 =?utf-8?B?Z1U3TldST2QzZU96M3JZMll5V0FYWEc2cmM3bFh3amg3TTBDODdldUNsN1dr?=
 =?utf-8?B?WTdETHdWZldNN01vd3dYZ2J5ZUZ0Q3dDTm1tMDZjNHRubVNBeHlFUTFuakJJ?=
 =?utf-8?B?VWVNZklqK3NWUElmVlRNQW5UTUVtK0JlNjBweUw4akcyTlpLaGYxUURqUXBr?=
 =?utf-8?B?K0RTeFQrMkNRelQ3RjZzYUcyVy95UEpkRFI1Z1JKM0M5NHVmMVRhbjRXc2Fa?=
 =?utf-8?B?Zkhwb0JDZFhCbVFNUWdxYkJnVERYQWlFcmFGaEFZZSt5cTFpVXRRNjZuTndQ?=
 =?utf-8?B?UkRjUXdkOHB5aWhSaGhhc0pEeTlvMVlpb1kyWEZhNmJBUW5GYWI0azFTc0Nh?=
 =?utf-8?B?NXpkZWZtc1FJdnNrMS9ldWNWbllYdDFWWkxFUm1vamRVYkhJZ3dFN1RXNll2?=
 =?utf-8?B?VFFPdW5YVGszWm9MRkRuZ1NOM1QxemxhTEhlNkdCVlc5UWZYR2Jvc0ZER2tD?=
 =?utf-8?B?aWtPc0lYVC9iRHA3NGxUV2xrR1h6UU1hbC85WjZ1RCtveDZaVXdUNGE3Zkht?=
 =?utf-8?B?TXFqUHFZNzdabVc3b3pGRGo0NDgvRndIdU5DMHJIWVMwd0QyZTQyNGVRWFk3?=
 =?utf-8?B?aktpWjhtbVM1QnA4RDZVUDc3cVRhUDR2SUZoOTN1WFU2RkdSVzJoL1k3SDNN?=
 =?utf-8?B?TmNBTEJJQzViK29xTVdEWXJKSkdVdld1NWhGT0RzSGQyM0FVNlZvRGFxWFpS?=
 =?utf-8?B?NE1lQU84V2kvZlNlcFY0YzRsT0Eyb3QzV3c4RmluSkFpWENRWUlwbXVYVjVw?=
 =?utf-8?B?bVB2dzFvS21GdmNCSzlSMndsdXBUd2RTOUJzMWhTZVZMVGRHa2poa1BITHJm?=
 =?utf-8?B?V1FmSzhhZ0xGVldTd2VZYXhzbzhydU0vaFBIT0FQV1VUcnRpUk5lZWlPQ04x?=
 =?utf-8?B?cXN3YXppTjlrdWpkVHNIME9Meko2cHNpTWw3V1dBbVpvelEyRGJwUT09?=
X-Exchange-RoutingPolicyChecked:
	JgFMN74prI7BeTyZDe7pXsRwCC2KanqLClWIkWbglVaLQuqGBJ5vuMaOWQB0022btz98tgdPEAkA0HLaxxRdJTAGtWATUM6aqnkYpV+5gsKbN0859Osu2HyPKGBLmiku8fSS2GF4L16Ww4jLJIkxcCxkuMYUoO1Qd/mN6JzvisyWSzW+lf+lCXSPGvXhM2y7t5IRDv9ICTMsmLiM3ZDRwYL3zUDvibXYYYE1Rh9L/U/iH9Jsk5K8rf6+sgCUpxavJWfJjCB3BxVrqBHm7eYP3hNeYd1rnlT/divvHVOoXEsjdswtOYM5ZppeMobup5au0fITLMJh/sLKaXEeN6SK1w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aeJKtQUitVrIb6RhSssIGHstkRdoM7lyQDsFSIp84qKTSZrcoMJp9IfOyhT115G6l73ulHbZbOoTOFRUJcrA3+HJf057QIdFRTmaAVvGgdDUaeOeH3bU+lBdq/Vnlcjy3R/pPSnZXjKg2kvQR56HT1LnR9ipQc5Up0roushjwYTRBBY5Yg9h3V/gSGK0tW2+l/CSUFq6i/bObZKxzOLRu/1Ec5RkbKFfbn8HD5dFBFSK4IYBgWm9tUUJfKN81/KstY9SKh68g2EmlSlHVGQaLdXWQh+8K8zkC2dE6dDxkJ5RCvPZp7n+vyGKqHJGfz8lep2lYBv9TavgEUEYcNxM6Belee8NK6iLYMsoczU1feCgthYXm4vNHwoMt53WSuQxD1wob4Inayiwmwtm4VH9IZorQuF8Odf5k5sbeh+BRH+rGgP0Guh9IB03kDPETJkUDSajUZqUn07hPhhptTCaC4FHGn5OtIVz+NRXk0HzBD/b16OZ11aA9ukiu0lcl7wjOaAx5FXcC8NB3TGx2JSmadBSZ+cdwgc1MdQcPFIh/vCDFEg3MBoPeCT9Zppd+VsN5RfB40sR9aYpf8569/RrpwGQHzmXoIXAJS7uJs4cxZM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67488ab7-021a-4b51-31f9-08deb5acbb15
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:44:21.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvKuv5kB7t/ce096VagCVbR+S9s/dkum3jWV1nIlSzFLBmcxPWitCBruIJD6YH55xM2urEQKFdEsPltxxl7wnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605190136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEzNiBTYWx0ZWRfX2DrJ7ttXqTUF
 7+iWzjUk8kbK+mJlh0azTQWU4LalhL/jtjqQ4chVO8nPrg7wS3GjSkzuHFiC0hs1AQrzg2KqdAU
 OGzkbXJIqbCMtPwF3ay1KSWpOlXka8vHLZoTHqMvji+q6TrRXo1zqG4ChvWaG0ZmpINoo6eKHHP
 /VCRJTOSzeAqU8kgD6IGXUkBXJ/GyMRkgVCIsb/aSDVd5zZCpE2s8nPuUBn8uCN3JZo1zp8xiCW
 aICyTLTHbwIiUnQy21JLcEM2QZrnXMfmZccaVfwtsCtV1RAHQe3njkbjJCNb6xZdevkl38VkON9
 i22dQKZFgQdN8uH7IHNhMxzCpMADgjECoYWuNEM/ZoVLKlFY7QEr+/vFdfIRCx0GHYSv9tSC6z/
 MOgpvYs1CTiWU3ahwO+OPA+C5aw6hG5CWeCEMBrRmK7+3sfO2aJBuWOEqRkzf6raIvuCn4NKe9Q
 WvJmXuv6btyowL0/GKw==
X-Proofpoint-ORIG-GUID: Ot_T-0nXR91SGv7Fv5rcnTX9lTGuq1UW
X-Authority-Analysis: v=2.4 cv=dc6wG3Xe c=1 sm=1 tr=0 ts=6a0c6953 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=e-kE-dbBpctwjOrh5kAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ot_T-0nXR91SGv7Fv5rcnTX9lTGuq1UW
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21703-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 375DC580069
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/18/26 11:30 PM, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 12:55:17PM -0700, Dai Ngo wrote:
>> As shown, the file map changes. Entry# 7 and 8 before the NFSD calls
>> merged into entry#7 after the calls. So there must be some activities
>> that cause the map to change. I don't know whether the activities were
>> triggered by NFS or something in XFS or the block device layer.
> Hmm.  We only insert layouts (and search for conflicts) after calling
> ->proc_layoutget.  So this might be racy against unwritten extent
> conversion, or other writers, which is a bit of an issue.  I guess
> we need to fix nfsd4_layoutget to insert an in-progress layout before
> calling into ->layouget.

I can't quite see the race condition regarding layoutget here. Could you
please explain?

>
>> However, based on this data I think it's better to change the bmapi_flags
>> from XFS_BMAPI_ENTIRE to '0' to address the overlap issue.
> We absolutely should be doing that as I said from my first reply.
> Still trying to understand what is going on here at a higher level,
> though.

I'll resubmit the patch series with both fixes combined: the uninitialized
imap handling in the error path and the replacement of XFS_BMAPI_ENTIRE
with 0.

Thanks,
-Dai


