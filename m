Return-Path: <linux-nfs+bounces-12440-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F009AD9054
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 16:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 997357B1AD5
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F0319D8A2;
	Fri, 13 Jun 2025 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p96c5jLa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JEPFVmd2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0105418EFD1;
	Fri, 13 Jun 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826625; cv=fail; b=PyXDV4odcbYl9+Oi2jUiqvUggZdAsvJPec5uFGqhFwfpve7mRKK7PBkbZhrBI+k2KU8DJfsLVt9HXQ5FuHy6zQjXeh74d9qE4opafvWSfPRHE4RnD9mJp5SSbtfv4sp3C85hzfshS3JJPp8uRQguh8Pa83UuRFn0fq1Gn1pPUk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826625; c=relaxed/simple;
	bh=ZAITxxptsFKOLy4siS41VSXzJ3SJDE4/HtgNfehWw1U=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DYsGfDYxxpFFU2qFDgenPodkMslGE0nDIbOdYTqj9NreyTHOREx1QW9ec/3qy4hCngwW49AUpAfC0HTCNDhdqzVImNR0C/pfNOWRZ9R8Iea/GyhV41Kfyc9HsriEhrK3vtIuuE/dXwdQGtn2YL0m/05T9JduBzuiYJo2oI2JAJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p96c5jLa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JEPFVmd2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DCtckX007753;
	Fri, 13 Jun 2025 14:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QyeDua4hB1GCPZPa1UNznwR9rLy4QX19Qzhljax+498=; b=
	p96c5jLa/wfl18rurI/v/WaPXY29Js+zS4O8QtdMPVFnger27aAyiSXTmvOM0AGF
	7WQgxjMhMlsxPOXyMVPbeRP0cliJlavRffqVshASKGWoLvzTw5p1Yt0/AglCr6be
	qMEjrhZfAlP3phmV/vk7eSAaBTHCnNByIS499g9GqqnO3ipMMtnWJMEsD0NGmuOm
	s/YdnMheaDBePBi04uYISno+FHBuXQLZqSbjJiaqBuHqa5TDEX+UQ/ZNZOVX3I+D
	pjyOYSV2wVCQw200GvZuCTwkNVL8siat0luz7IdQZjOZvkVbwxt491+gsF0q9b+O
	ddONQK5fkbsUS8n9aB2DHA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dyx3tvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 14:56:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55DDv4ED032045;
	Fri, 13 Jun 2025 14:56:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvd0jkc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 14:56:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=km47EUNqVySDOtAkE4O9SX0En/0W4Bl0WUxm1L8+PTDlkYvVi1dDk547nAVSVC4FfAgqNR9emPYTny5OtuRJ1VeTHppZRTLunLaFHZIecV8fs6gKZxKrMtuW2U1zEpqzYltYOjoC3DFWhq2G8bSGPlRiUIxbmPeAsdA8RtziI2D3oEloMsZf0P+MVs8NukbD3scX5N2fYpuY5RgvNStmkj8rpkwbGFZLhIdQuUwjCQdliVl1TAUF+Qmtg/naXZhTPf1EMCuk1hTLCyPaagT9c9/4E93G6OtpTiNHQlmbrgqQVVgukKmoc2cNDJhOyoojuR2uijo0MobRIKlywsCEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyeDua4hB1GCPZPa1UNznwR9rLy4QX19Qzhljax+498=;
 b=rcHSoOBulLhtuwh/uCDJFQe+/ebOCcfvuGkGw+0oLp4BFfiMUiWSoXy8hfQ3aWfRwJ76mrbR1ECmuuEx+fzcylwRF0MLRot/LqSuLKdAnQs7C0fT3F7x5tCPOUafyr/aZJtba9BlnHFomr4qFsfjqflBB/4ZPZmja265nv4wIxkMKI5GN+i/oFenYi7+VfC+jVIhyGsPEuvuPUvKygnuA20GhTp6Hp0PckQHEmoSdg9R9SbbIrjPg8EnfG33i+hiJVgqNQwKWAVoiAurxD9+MvY/rk/iLLT7sp3aYmYlOyw+1Pmx+OyjZZPvgY1wvj5va1RU5nHMhvcclPqkCH440g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyeDua4hB1GCPZPa1UNznwR9rLy4QX19Qzhljax+498=;
 b=JEPFVmd2aKFn1htPSn1ETCDep2T3fgipa/k7WW7sgfL6/VQh+fp2PflplQyqkV+ZQJbnn7ooW4RRLH3pTBj+QbYsZ7Q/2cXKLx2ANA7SIlX2QFzY5yqhXN9Ggz6fTbpM2pBDdGkSZDOQxBtky7ReKBhpXmrFsvWYW/1Kpj+hJh0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6548.namprd10.prod.outlook.com (2603:10b6:806:2ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 13 Jun
 2025 14:56:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 14:56:44 +0000
Message-ID: <df0a6fc5-6ef9-44b6-b6c2-e3cb4a2d1512@oracle.com>
Date: Fri, 13 Jun 2025 10:56:42 -0400
User-Agent: Mozilla Thunderbird
From: Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/2] nfsd: use threads array as-is in netlink interface
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
 <20250527-rpc-numa-v1-1-fa1d98e9a900@kernel.org>
 <a8d4c4cffe1a35ea831110ce1c7beea649352238.camel@kernel.org>
 <ae18305b-167d-4f27-bc3b-3d2d5f216d85@oracle.com>
 <1cd4d07f7afbd7322a1330a49a2cc24e8ff801cd.camel@kernel.org>
 <38f1974c-f487-49b0-9447-74ed2db6ca7e@oracle.com>
 <7DCDEBE1-1416-4A93-B994-49A6D21DC065@redhat.com>
Content-Language: en-US
In-Reply-To: <7DCDEBE1-1416-4A93-B994-49A6D21DC065@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:610:e6::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 91bdcd3e-d79a-4583-7985-08ddaa8a8367
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NHo5NHZwRzlkcDhJcnpOWklKMHZvR3hLR3lKUERiZkRwSDVXNTFhTmF5NVRY?=
 =?utf-8?B?MmRzMWVQUDdCWVg5VkpJZTJlYVZ0NkZBbVBOYnpiclV2ZDRoTmh5aDRSRy9k?=
 =?utf-8?B?QmNxVTZUenpUc2dZVlg2dllzd1FFanUrTzMrL1RyRWRwZTF3cFVsbzlHNVNw?=
 =?utf-8?B?M3FzZEJ0R3luSnpNUGpXalRkVXRrYTFxdUc5RGEzempTa29sV1lmR3l2a0Vl?=
 =?utf-8?B?QWhJSVhaTnZ1MDJNRTRyZnhEVnVJY0hDRTlpL2RndjRiVGV1WnhMbEF6eWU1?=
 =?utf-8?B?OXY5RkF0WXVyblJHZC9nTXZQUzlYNVBPLzh0eTA3VjdpZ0NwazMvcU1ISE9F?=
 =?utf-8?B?cW1vaEYyS1dUczJLai92dEVhT1pKV21DaS9pYUdiaFpHRnkwNmVaZ3dhUkdB?=
 =?utf-8?B?aUFPS1RLNy81MDVIc0k4NldTb0xhRlp4aU9FSkY1c0tYK3hBanRjTTlGclk1?=
 =?utf-8?B?SGxZMXNnWUdFdXdQZ2ROR1hKdEc4YjlDQWJGTmM4b0RPZVpSc1B6aVJCaW1X?=
 =?utf-8?B?L1A1aVA4LzJuZzhtMExrQysrVVZBSGdSUUZmSDhUUVhSRTkrNTJReUhiMXpJ?=
 =?utf-8?B?VjNaczl4M0xaRXNiRVhnWkh3WHhXdnl3azdHYXg5d3FXWlJtYm11L2lrS1Fu?=
 =?utf-8?B?RlI3eWZ3dE1Nc01xd1hWOEhMT1ZzUlZMVHZOdTl5WTM1cGx3RlE3T1VDMkRM?=
 =?utf-8?B?bTlkVmtZeFFaOGFwVlMvT215MFpQMzQ1OVVOdkpGdlptdUlNb1JjeDV4Y1FS?=
 =?utf-8?B?dDhEWUFwQUtBRUgzUG1YZ2QrVVB6SjhjWkdtT2dLczVNZmxKTjlBZ2xINjYr?=
 =?utf-8?B?WngwL1d4TllQY2tnL2hIbWRoSmRBd0ZuYVM2MG94ZU9XbytGdUVnRzl4eHNE?=
 =?utf-8?B?d0Z0MFRRUGJzWHhUVzR0Q0U2WXNQdys3L282Z1BOVFNSRDIzQk5LcjRuTGRO?=
 =?utf-8?B?RHNnNlJ1SXRHZUhuK05DS21hdWlpWm1EWU16SFo1QWFUUkVxbWd4L2tNSTIy?=
 =?utf-8?B?YlRRcjlSb1lGeWFIbUxJZEtERXVJWk9ZV3ZPRWxsaDRVeFJURUFuc2ZYcXQx?=
 =?utf-8?B?dTFLemxoYlpTaDBwaGRrYzY4WlM2eVNoYW15b2NLTTdhaWtyVXV2bHdzWHBV?=
 =?utf-8?B?TVhJSVdZTmM0Y3hhZlBlM05yTkc5ZlBIcW9jYkpUVzdtUjBTUkp2angway9R?=
 =?utf-8?B?Q1AxOVNzd3FzRmZ0dFcvV25mR1hSSjduWjg4R1lWbVdpUGJ2czhCY1E0M0k0?=
 =?utf-8?B?UFdMVkJsc0l0anZ2RWpXSXJDWVNqVE56bnlFbjZmQ3ZKQ3A4VlhVSTl2RWlF?=
 =?utf-8?B?VlFlZmd2N1dOYjdpQ3BNd0ZybFNIczlDNmxON3NDU3NYNERIdys5b0owUWtz?=
 =?utf-8?B?NVBoL3F0cExSOXNuSk9SSi9mWGdvdTFVbnh6MVVCQzluRmxobHNRR3dQSFV2?=
 =?utf-8?B?UzBkREl0WXE0VDZMWTQ4bHpEZmpFdHF0ZmlVWE1CdkFxK2hqM293cElRZXFm?=
 =?utf-8?B?MlNqNlVKOThIYkRHTVo4eEx1NFNMa2pRUC83NkJmOU53OEowNFRjTnB6eTZ2?=
 =?utf-8?B?UzZETnZvb0xqYTZ2THh1L2hmQUs3YTcvRW9ZVmRpTjl0VzNPaHNwNmFsekdo?=
 =?utf-8?B?RVJURzdzQlMzZWdaVmErUk94V3NpWWorcXVHRVpQdktxRFYwN3ZENnhVRGpI?=
 =?utf-8?B?T1JGVkkwYi90L3cwMU9yOWRZR2ZTeVRBWlJMTE43ZEpPVEtia2pBaUNrSEJL?=
 =?utf-8?B?cVpRa00rcHVSY0UyOHV5L0RzSFhqTEFCSytVMkxncEVTVjA2dW5NTlUra2x2?=
 =?utf-8?B?dW9XaWpCQlpZdXVkVmVvbHdRejJuMTdieTVsZmFPZnBtM1cxV0Nib3F1OU1q?=
 =?utf-8?B?TGIwNHNzWmgzOUtCWEFnWUJOc3d6d0N1QmF6SExaTjZaUWRrQVV3TFBacmxE?=
 =?utf-8?Q?D1wpZqTWsis=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?b0grclB5TFNjQ0dhbmpuUnYwYkJ3NFZ1Tk8yL3BrOHVNMUYvZWVCV2lzdFVB?=
 =?utf-8?B?YSs0bE9mU3BaYU5XM2xWQnNxZGl2WXlpbGY2Mkh5Z0E5OEo5SlVCWjE4MGYy?=
 =?utf-8?B?bFRzclFSQnFzRFpCQjRQc0hQVWRzR1BkVXQwcURvS0p4QVl2RDJuaGJsTHdj?=
 =?utf-8?B?OFp3QzhQQVd1emFYc1NPV1gra1dZU2RGblZKM2N6UUszL3FWaXBHYWVad3hs?=
 =?utf-8?B?ajBueWtPaytaaEUvM2gxbUxhUWtmcFZxWFVtdjBNcVdqSXhzaTRtejNzYVBP?=
 =?utf-8?B?ZHR5aDV3bmFuajlJQVdzVVNjZUJRVkFGZzl2UXZ0cHpYSWxhelNjelBlU0NI?=
 =?utf-8?B?MkdxZnhIeFBNaTVnaXY1aklVTVJIY0ZsWW9zSmFYQXlTalQrb29jUTBuanJx?=
 =?utf-8?B?RkUrL2FuMEcyZGFjbTdXVTlOZVRSV3FJTW81ZTIzMnR0cmlXeVlEMDBzVi8v?=
 =?utf-8?B?R1pZbC9hc1hqei9SVUlIK3haY2Z6U2ZQSWQ2YUhuQmRLRDlUTXVDUHRwRkUz?=
 =?utf-8?B?Q09ZOUh2ZWdDRlBSWlVYWHlaRTIrczZlNnNjRzU0ekt6SHlHQytrTHIxSnFE?=
 =?utf-8?B?eHlvS1pkaWNHc1ZKM1h5TTBsTVU5K1l2b2dKWm9oZUN3TWlkZkt1UEIxTnB4?=
 =?utf-8?B?T2VlR1BOYnh0V05ENE9hTVJGOVFDS3MwdG1yQjFUaWpDcFJwWlZCK3VXZnV3?=
 =?utf-8?B?Y3YvR2hielVtckZLeXo1WjE5VnpYQThOOVhlREFIWlMwR0ZQOGtGeHpBLzcy?=
 =?utf-8?B?RFZmWGtqNzN1OS9Yd2o0dU10OTNEQ0RTdDE1TENnL240QXFxZWx1Z2h1L1Y0?=
 =?utf-8?B?NnBWdUNjeG5hcmVKL0tBa0lUVlFlajFFOUFYRmdKSE5KODJCOGJaQzRJL0Jk?=
 =?utf-8?B?MDFWR1dEOW5RTytDTEE4eGtZNzFtbXlpcmtqbzZLSWdDdWp5Mktxb0Y1VE1E?=
 =?utf-8?B?Z0hwWE1iSWpuL1JNUDRGYmFQd1htQ0N4czlzMTYwSmdzYlZGdEhPY2pVbkRT?=
 =?utf-8?B?VVArL0tYcnpPUU1hN0IxZUQ1Vk53NmNHczVvYnA2M0FwKytEY0RHdjJCTkNh?=
 =?utf-8?B?anZLMjVMTzFka010Z1IwOGNRUHZGSy96dW1LU01GUmkvMmFXcWhwblZKVFJo?=
 =?utf-8?B?dDNrM2tVbEtVVEppZzg5L0syeXpqMDhiVDZNaEJHUDFUMGlNWEd6VThqdUNX?=
 =?utf-8?B?K2VrMkUwTUNSdjltL0g2KzBuS01wWlgra2FRcWg4ZDljUGd1QnlVcXZUQ3dS?=
 =?utf-8?B?VW9GSDhXSFJZNEdJUGgwdW5sZnJ5dkw2TzJYYWJvT0wzeFJkSmRxMGJVa0Vj?=
 =?utf-8?B?M2FUQU5ZV0N6V25xN1B5NGFGQjNLM0hjUFplOVJuclA0bXlRS21XNUsrdzda?=
 =?utf-8?B?RmQycnhYSnpzZHEvaE91WEttTnRuSDFrQWt6eE1HUSs4cmdpQjlYaUFLZ09r?=
 =?utf-8?B?WmZCMHdCY3Mzbk9iSjJnQUN0NkZqZWloU21CV2lkN1R5UkVESHdGeUJROGhs?=
 =?utf-8?B?MEp1b3gzUHhYWXVIL0dGUXNtSHZ3VzFTOW9mOEd4MEJUNW92WUJTODd3SThy?=
 =?utf-8?B?TmVTL09qYzV1VU5zUlpZeE51NDlKQldhRmwybFJ3VmwyY2ZBU21JTGNwckJE?=
 =?utf-8?B?L0NoOFFvRU1NRC9GVUkvdmpJUDZMTW5QOUtudnVkdG5DS09vRjhKTDFTYUtK?=
 =?utf-8?B?S0VQRFZPbHRlbkdZUmJ2aW85dFhDTWhIcjBMMkNISXAyQSs4dkJjb0NhZERr?=
 =?utf-8?B?bFBoYjY0ZU5yTXI2cXQrK3ZQbzJMWWNwOTRDbFh6bUZ4Y3VGWWp0SlJwTWtR?=
 =?utf-8?B?RDBhRDd1cGhYQUxMN3l5MlFmTGNJVVVocmg2QU1HZUR0Z3VqcWkyUVN2eWhj?=
 =?utf-8?B?WUdjVVF0RG1vMXF4b3BDZFJ1M2VSY1E3RXdOenk5cGZpTzBmOWtWRktZVU9u?=
 =?utf-8?B?UDg1cFlkbEVwc3pXOXZUcUw5RU5UeWI3eG9iMUx6ZmUwenNoaFBIeHFnejVQ?=
 =?utf-8?B?UlVUWEdpSFZ1SkFrUFlsdVFpa0c5RGZyQXRKMUU4T2drUk9Rci9wNktra0FL?=
 =?utf-8?B?V2RyczVJTVVQK3g1NlBMbW4vK2hXNldXckgzV2J0N1BFZ0MwcXdzcGZCU1VP?=
 =?utf-8?Q?x751VibptdBa8DiDIb5894vUC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9jD2NeKimKCFYCEHx2gJ/BZlfBL3SxU5Y0NPt2Mtoa/zIIJfWIGkgqrt/IUT2HjLfQtxThfNMOsJAEI+wn9cLwVxpxOhVm0PRtjVO1meLwXzD1II03uDT9YzN5sg92zXzVaQzHLtj4hW2hOlIoBGh6x/wyLdfZ9I6QtedmhBALLUVBPW4tTQHMWOR6bzIN7fveWC//+XbfvFj8V60LKVjBGkfo/cdkk719DFaBsG5T5fVIHhJyLS5bFCnu7Pfadkgmk+IiRC4hvBLfwxp8hmzRyGqpLF9sWptTnOEYXZTiXjuB1PWB8xLSnTxbyvMshoMPybiXUuOF3q0rNy/Qn/UW/Mwgr3p5El2wDTLVGD2en5+QvDNA/ZmU15R4C92Hvijwl1tBYt3rK/F4yHHt1nR3sQ3qxLugir860/U7sLzGtb854NzynTe4sMHyuZuAdmFh8z8/Typt3/767cgfrBwSE60OzIzXvqdfOsMey/TK1suz7bZTVKTXbfVdcVVtCrjJn+WXbM7Ea8wc7qOt7VTpDlGvOTdMguhIh51ZMIMsKJXMkBByeUclwtDm0aOd7pf+Cd1xk/Xe8wtYGmNN1rED9Da836Ep/6QiDVaNBrcnA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bdcd3e-d79a-4583-7985-08ddaa8a8367
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 14:56:44.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5C8KyORh3XAwcBZe+3q0Vx7qkfylLzxNLFFrW8lyd5URgL/Y8h+ODvDySnKciT66Xu+SHcvYTVd+ms8Vjfr7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130108
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=684c3c31 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=0j1ZA7yqIOdzp03hHgAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oGP2J0Znyhu3M_3wme8RuvcRAJMYUk4q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDEwOCBTYWx0ZWRfX+g0CQ1PxS9Xy 4e9LydmQmFR451UVtNgSH1/1KciMlh2gnVQqdvPtY3Tf/Zgnwf91bB76+kO9YIvLCK94Ghdw3hu l2ngyVGDLYzTITU13WoUJKmdBjMqvXNOCHAfUWH/AAuZJ3L+WSVnYLPRcU7/m1d2xBWYnU5vxtR
 WLIUDmpEkOQDcd0Flde+2sixbDcNVvpYwb6ViULVzd+LchHaNYHfs1V/DGYxdPvqS+RGpNKhKen J8jCosnoQ6kmb4Sa280l+rGYpD4qDBVjmLX3bBXC3NsnMu94zbTtfmfARwjm2aV7bkgylb2xtWy 0X3j03ujP/im7aLiD3fMj3h+Ytnr85LEpLTkL/2nfZoVitZMLnlCV8u/C7En/nr2487YxkuRQDW
 i8jlLixpCH16SeMd4bqhgEoldc8DXpDywplHt9OBTFzd4CEvba/8ZzX4S3gXxtTQIXsfpApK
X-Proofpoint-GUID: oGP2J0Znyhu3M_3wme8RuvcRAJMYUk4q

On 6/13/25 7:33 AM, Benjamin Coddington wrote:
> On 12 Jun 2025, at 12:42, Chuck Lever wrote:
> 
>> On 6/12/25 12:15 PM, Jeff Layton wrote:
>>> On Thu, 2025-06-12 at 12:05 -0400, Chuck Lever wrote:
>>>> On 6/12/25 11:57 AM, Jeff Layton wrote:
>>>>> On Tue, 2025-05-27 at 20:12 -0400, Jeff Layton wrote:
>>>>>> The old nfsdfs interface for starting a server with multiple pools
>>>>>> handles the special case of a single entry array passed down from
>>>>>> userland by distributing the threads over every NUMA node.
>>>>>>
>>>>>> The netlink control interface however constructs an array of length
>>>>>> nfsd_nrpools() and fills any unprovided slots with 0's. This behavior
>>>>>> defeats the special casing that the old interface relies on.
>>>>>>
>>>>>> Change nfsd_nl_threads_set_doit() to pass down the array from userland
>>>>>> as-is.
>>>>>>
>>>>>> Fixes: 7f5c330b2620 ("nfsd: allow passing in array of thread counts via netlink")
>>>>>> Reported-by: Mike Snitzer <snitzer@kernel.org>
>>>>>> Closes: https://lore.kernel.org/linux-nfs/aDC-ftnzhJAlwqwh@kernel.org/
>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>>> ---
>>>>>>  fs/nfsd/nfsctl.c | 5 ++---
>>>>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>>>> index ac265d6fde35df4e02b955050f5b0ef22e6e519c..22101e08c3e80350668e94c395058bc228b08e64 100644
>>>>>> --- a/fs/nfsd/nfsctl.c
>>>>>> +++ b/fs/nfsd/nfsctl.c
>>>>>> @@ -1611,7 +1611,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>>>>>>   */
>>>>>>  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>>>>  {
>>>>>> -	int *nthreads, count = 0, nrpools, i, ret = -EOPNOTSUPP, rem;
>>>>>> +	int *nthreads, nrpools = 0, i, ret = -EOPNOTSUPP, rem;
>>>>>>  	struct net *net = genl_info_net(info);
>>>>>>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>>>>>  	const struct nlattr *attr;
>>>>>> @@ -1623,12 +1623,11 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>>>>  	/* count number of SERVER_THREADS values */
>>>>>>  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>>>>>>  		if (nla_type(attr) == NFSD_A_SERVER_THREADS)
>>>>>> -			count++;
>>>>>> +			nrpools++;
>>>>>>  	}
>>>>>>
>>>>>>  	mutex_lock(&nfsd_mutex);
>>>>>>
>>>>>> -	nrpools = max(count, nfsd_nrpools(net));
>>>>>>  	nthreads = kcalloc(nrpools, sizeof(int), GFP_KERNEL);
>>>>>>  	if (!nthreads) {
>>>>>>  		ret = -ENOMEM;
>>>>>
>>>>> I noticed that this didn't go in to the recent merge window.
>>>>>
>>>>> This patch fixes a rather nasty regression when you try to start the
>>>>> server on a NUMA-capable box.
>>>>
>>>> The NFSD netlink interface is not broadly used yet, is it?
>>>>
>>>
>>> It is. RHEL10 shipped with it, for instance and it's been in Fedora for
>>> a while.
>>
>> RHEL 10 is shiny and new, and Fedora is bleeding edge. It's not likely
>> either of these are deployed in production environments yet. Just sayin
>> that in this case, the Bayesian filter leans towards waiting a full dev
>> cycle.
> 
> We don't consider it acceptable to allow known defects to persist in our
> products just because they are bleeding edge.

I'm not letting this issue persist. Proper testing takes time.

The patch description and discussion around this change did not include
any information about its pervasiveness and only a little about its
severity. I used my best judgement and followed my usual rules, which
are:

1. Crashers, data corrupters, and security bugs with public bug reports
   and confirmed fix effectiveness go in as quickly as we can test.
   Note well that we have to balance the risk of introducing regressions
   in this case, since going in quickly means the fix lacks significant
   test experience.

1a. Rashes and bug bites require application of topical hydrocortisone.

2. Patches sit in nfsd-testing for at least two weeks; better if they
   are there for four. I have CI running daily on that branch, and
   sometimes it takes a while for a problem to surface and be noticed.

3. Patches should sit in nfsd-next or nfsd-fixes for at least as long
   as it takes for them to matriculate into linux-next and fs-next.

4. If the patch fixes an issue that was introduced in the most recent
   merge window, it goes in -fixes .

5. If the patch fixes an issue that is already in released kernels
   (and we are at rule 5 because the patch does not fix an immediate
   issue) then it goes in -next .

These evidence-oriented guidelines are in place to ensure that we don't
panic and rush commits into the kernel without careful review and
testing. There have been plenty of times when a fix that was pushed
urgently was not complete or even made things worse. It's a long
pipeline on purpose.

The issues with this patch were:

- It was posted very late in the dev cycle for v6.16. (Jeff's urgent
  fixes always seem to happen during -rc7 ;-)

- The Fixes: tag refers to a commit that was several releases ago, and
  I am not aware of specific reports of anyone hitting a similar issue.

- IME, the adoption of enterprise distributions is slow. RHEL 10 is
  still only on its GA release. Therefore my estimation is that the
  number of potentially impacted customers will be small for some time,
  enough time for us to test Jeff's fix appropriately.

- The issue did not appear to me to be severe, but maybe I didn't read
  the patch description carefully enough.

- Although I respect, admire, and greatly appreciate the effort Jeff
  made to nail this one, that does not mean it is a pervasive problem.
  Jeff is quite capable of applying his own work to the kernels he and
  his employer care about.


>>>> Since this one came in late during the 6.16 dev cycle and the Fixes: tag
>>>> references a commit that is already in released kernels, I put in the
>>>> "next merge window" pile. On it's own it doesn't look urgent to me.
>>>>
>>>
>>> I'd really like to see this go in soon and to stable. If you want me to
>>> respin the changelog, I can. It's not a crash, but it manifests as lost
>>> RPCs that just hang. It took me quite a while to figure out what was
>>> going on, and I'd prefer that we not put users through that.
>>
>> If someone can confirm that it is effective, I'll add it to nfsd-fixes.
> 
> I'm sure it is if Jeff spent time on it.
> 
> We're going to try to get this into RHEL-10 ASAP, because dropped RPCs
> manifest as datacenter-wide problems that are very hard to diagnose.

It sounds like Red Hat also does not have clear evidence that links this
patch to a specific failure experienced by your customers. This affirms
my understanding that this fix is defensive rather than urgent.

As a rule, defensive fixes go in during merge windows.


> Its a
> real pain that we won't have an upstream commit assigned for it.

It's not reasonable for any upstream maintainer not employed by Red Hat
to know about or cleave to Red Hat's internal processes. But, if an
issue is on Red Hat's radar, then you are welcome to make its priority
known to me so I can schedule fixes appropriately.

All that said, I've promoted the fix to nfsd-fixes, since it's narrow
and has several weeks of test experience now.


-- 
Chuck Lever

