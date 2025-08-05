Return-Path: <linux-nfs+bounces-13432-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2EAB1B6E9
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 16:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B31517D8FF
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87E22475C3;
	Tue,  5 Aug 2025 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jYVEwWwv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DRii5tsV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C32264A0
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754405721; cv=fail; b=Zpms5RQK3Oi2BwdnJO7opKCPFQC2O29WCDyUlLEpp7JYOdSCxwEklP3cTJw8zNKIeg4u73jt/2Y1AnWsds33nOp+pabd4Zsg+CW86SG09XiKs2F/uNQm1CnqevOsFqfJmXTQdOrwm+9mTFPNrbyO3tEcSZxSitKMN2cKK2wanuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754405721; c=relaxed/simple;
	bh=uKhSBs5rynmrMtRJUwnklWkttJXsqpGsEZgZZE2A7YQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pQAxGBObyxtv0C4UjfqEHf7yQvReSvzCNRPbcifcpmradAhdUlrl0iGsw7OotbC3kwpLH1+NGK67pUK59VwMo/sM6o/f7rqkCf4oPaYsCVllihMuFAn/YsXfPUcdAiHyzCl3hRHLcbIoZfYI960QB+UOX6DOszPsOG4q/vk7dYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jYVEwWwv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DRii5tsV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575EpVN6001536;
	Tue, 5 Aug 2025 14:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+XcxDkJeuPT0zz6NDG0F1uGuJtrVIyQ37VFDCDjIoOE=; b=
	jYVEwWwv30SU4gNzkwVPDQatz6NCLRHZfHiI8jo5pkrnOpaB/SiHOTgbJgHf8qRh
	Dt4DKJcvdXTUtb02IHhJtG51UHhBnUgKkdRIpRhPSuVBVezbM9pdPv57Kn7ws7/Q
	q9XE3yjo/M2MHsTBRFxaQGOxdk5F/5uw2VzasmgyD4nDzErjOswUikXZCMuezNL2
	0U0OYJb9WNmfjT+6aN4d389Gb0VwsCABAkr3p596eYQleFIbf8UigM4eejo558sQ
	2rJNFbt6sKLx78w+2D7kFXDCX/MGfw6hKheror1M3bMzY/HxuPFECjRAJywuKt/S
	WdRm5NR7qR/Z+uZrdN4K0Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489994n0bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 14:55:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575EkMB4022267;
	Tue, 5 Aug 2025 14:55:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48a7qe1hfg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 14:55:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4MVbdPWHZ2sVnpcUiOe5rgvPK9PLQNFA32TsPrXwLwyd0xRxTAfhV/zyx9TNBEBEbjkvrzVMGn+DmlH8rgYR7+nENFQlpt7dsJOz6vyktwN0RU15uegT5vKq3Vb1+UOSyS2rGuEQWS1r46gGM4KJXRTquMyboDq0IiI4eFZmqfYjXA5drqCVgWtKuon+Dv8A+tiW7o4nPQ69nRycGcHnoS/n4V16sttZPmidvxpjkwNqXsMSo2+k2mmVMWPN1SQCpGsu3g6ikrdvMoiIMK0sVH6RiS2XcyzfzvZjAm75ZQxl8RCOs3sf7yIhq4k41LGMnaNhNabYRY2eZTwPmNO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XcxDkJeuPT0zz6NDG0F1uGuJtrVIyQ37VFDCDjIoOE=;
 b=aqdB3+EkI6+XQ27T+Kv2ibntrk63AZtMPaN69dsqAh8sZ2vkURaVb8d1ppfNJGZcVaepGow6Z7J6z3QERu10JDGZfr2SBwvQarxuwaBSn9/LMF6RMQXIoD2Bpoka660ODml6fgetTm5VxhutV4BsYYACb11E/iIp4eb1kGEOi9nMZWEAfDXjlEobvJAV0Wa2Bafa0yLjzMNWP50OZsuGVO0QQ2i+2kKYogK1GKgWMDbx2Fi19A46uAM/94dNdb9t8JI3FGD4gkHdLJCr9ycJKzvY5XIZdcnjWgfUFiWPX6Oh45HAdE6XQuN93FmbOXS2bZrZwyOc39cZT4AoqJUz8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XcxDkJeuPT0zz6NDG0F1uGuJtrVIyQ37VFDCDjIoOE=;
 b=DRii5tsVy7j2n7ybPb9U9/ZMJNmVAQ4JZ6dLBjVawU4/MjZlLrK7Qbt7T5MnmonWULp7l26sSgRQRrx81eyLrN65bt4nwouBjQPicYJs9PQSQTv6aZiNHqvDdhPLwCqe3mvymXkv+2jxSQbV1/piemzu0W+G5nXKhuY566bBgl0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS4PPFF3A3AE169.namprd10.prod.outlook.com (2603:10b6:f:fc00::d59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 14:55:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8989.017; Tue, 5 Aug 2025
 14:55:07 +0000
Message-ID: <04595f4b-750b-4b8e-a36b-f26c8939d2b1@oracle.com>
Date: Tue, 5 Aug 2025 10:55:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] NFSD: issue WRITEs using O_DIRECT even if IO is
 misaligned
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20250731230633.89983-1-snitzer@kernel.org>
 <20250731230633.89983-4-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250731230633.89983-4-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:610:b1::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS4PPFF3A3AE169:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c78323-2cd2-44a7-af12-08ddd4301168
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SXJsdkRlZDBjdmZ0NlpjQ0h5dXRmdExFc0lRRXJRYUYrV1dmOFVxMzJFS2d2?=
 =?utf-8?B?T1M0T0twenp1bEp1YWpTRENra2ZaR2xJcE9aaGx4eDc4dUNVQjBLYjZuTEhW?=
 =?utf-8?B?b3JWR0VmV2NnOVZKbG9pQlRES3M2THMrQUdkaFUyd0trR013SXZkYXRkeVQz?=
 =?utf-8?B?L09ham84TFVkS1I3RjVjaVRFQUlraytkeWVnNGxheTVOWXV5ZVFWcVR0TmtZ?=
 =?utf-8?B?TXVtZnNEOVdXbHJqV2F0UnR5bEljWk5Cd3dTaUJ1d25OeVBzQlc0WTdrV3Zp?=
 =?utf-8?B?bElQRzhCK3BqMzNROFQ2T1dTMFlubjVxWGM0QnkrSnh3VGl4UTdlTHZpbE5D?=
 =?utf-8?B?ZGx4SFpVa09MekFyNk5iWVU2WUcxbDJUUEZiODE4ZHVyWWQ1MHJyL2VmTFR1?=
 =?utf-8?B?Z3J0TGl2Sll5M042U3M0YXVLSFVyYXJXcWt0cC9CaUlHL1dlRFBSWHdNNStW?=
 =?utf-8?B?aVd4UVQ4SFZGaDM1VUUwMkV6VnJ3N2htYmt6SXI4QStLRE8wd05kckFOVEtu?=
 =?utf-8?B?N3RZNnVCZzhiQ1g2OGs3aGpxT0tpS2tJMzRmODFrU2dqYWlVUm9oWU4wTUhO?=
 =?utf-8?B?K3VIaGgzbitZbUxnZjR0UzdodmZGSGNQS01ieXhmR01YdnpJMnUyb1FZcnA4?=
 =?utf-8?B?M29SeXNjcFVxQVhHdFRpajdOQWsxOU5iWUZPeGpZNHE4eDdsQ1k0WHptbTdM?=
 =?utf-8?B?bFZFZEdsblBHaUFodGVyVUk0SzFaUWZtMCtiVGs3N1Q5NTdKbGZROUVDRlk1?=
 =?utf-8?B?Q3ZESURkMHpuRExQYnFmZnRXSEhKMVdSbG55QTNRQjFQL3ZYS3ZsK1BOZTFh?=
 =?utf-8?B?TTN4endQRHVhZ3hzdEJDQTFMWVllNkhPODVUcllLUS84Z1FtdWZlN2NiM2lT?=
 =?utf-8?B?dVlXU3FuQWN2ZnBnN21KU3RXYUxjUGR1ZFdWL056Vm84S1FtZmxhVlQrWm1Y?=
 =?utf-8?B?MDJmZjQ5eTZYcG1pVjBaL2RkRGU4SzdGRnpOUG9UVHo4QWtIcVFYUzVtY1Ay?=
 =?utf-8?B?RVZQMTBOdDBBUEZUQVVyVlp5Y1c2TGJucXhNZVVkVGIyUmZtU1pNckxsMFpE?=
 =?utf-8?B?anpROUVUSGNqeEhURE5IZGwvazBtcDZKRUJXTmFpRnRiR1RtTXlZS1I1U2ds?=
 =?utf-8?B?WGpTU1RjUXZuNHBiUkdhM1RSNUdOZmgvNUpjakUxaHB0WXB1Zm1zV3Fab25S?=
 =?utf-8?B?WXhXK3YxemVBNlRPRFFUWDVEWXVPTkxOT2hoamdnc3NOVkpJN3BkTUFDaWg4?=
 =?utf-8?B?b0c0WmRQOWZBUHZCUS9LR1VKcHpmcVVoTG91a2k2NEk1UHErR0FvS1d4Sy92?=
 =?utf-8?B?OVJURzF6VzYyb2tyVGgweVYxWDdaNkRRTHo2OFNKdVdiVlBjdXlGS3VrdEto?=
 =?utf-8?B?RXo3cVl1ODZwU3JkWDU3RDd0M1ZRd3dNenQvMGxsSEZKYWFUT3pLa1Jwckp3?=
 =?utf-8?B?a3dRc0hTQ3pnWXlVeExjcG9kWnNkd2FWYjFFZ1kvMm0yTVY4aHNxZzFOOTgv?=
 =?utf-8?B?blBKQ1VEZ2lhU1JaQWJhRlFXdXh6UDU2WlFFaWM5U1dTT051RHJYMjNpUGMr?=
 =?utf-8?B?TUlmMkw3QkxXZ3FCQUxYaDRVUDhoOExEdXVBYitNb0hES2pSMkttRm01MjZC?=
 =?utf-8?B?SmlUbGo3OXNsbE1STktKSGdGSVk0UWhoQzV5cWEvS01YdmhHdXE5bDFHZ0Vv?=
 =?utf-8?B?Sm5TMkh5QU1nNWh2Q2FlMlBGbUc5cFhtVTlETE92dGFTTDlKOWxIQVhzRUQv?=
 =?utf-8?B?STdCQkFRbkdPeTFRKytOaWljYjZWanF2bWlvUk1YdUxiZFRkaVAzOGVWM3Ji?=
 =?utf-8?B?eGo4OTdaMUs4MWk3MWwrb3I2cUlHRmFFMm1tdHh2S1ExSjZpeHVSOG1sUXZS?=
 =?utf-8?B?bWJPWkgzTnNZVC81RWdIZFJRK3Z6b1RUZkNCMTk4Vm9FaVdWRG8wLy9qM2ZS?=
 =?utf-8?Q?j9IT5rJeVCo=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VkdFMW5YZFpHYm1IbG9QV0t6bXVpeGp2TzI0RGZ0OCthZHFPYjl4N2FNNWYx?=
 =?utf-8?B?enpWYjQ0OEVPUzRPczJpTFJBeGRNYlZkNG1GWFVqcFNoRGxtb0RZdkI2Nndl?=
 =?utf-8?B?dVh3QUE5aDF5TkhiV05LUlRWbCtmaVQycisrdTR6M1BVVjh3T2EyWmtDdUlD?=
 =?utf-8?B?a1d4V3RVL2ZKSHpQeXZsV25rKzNlV29wT0xoVE9pa3BNZDRHbzMwWEJ6c0VZ?=
 =?utf-8?B?RUZWaS84dTFPclh6OTNkd0lSbzliOXFHQ0xacGF5NjV0b1pzcGcrMW9jcTh4?=
 =?utf-8?B?NHpQUXJhQVZScVQzNXRpckFhdXBPbzc5Y1BBU1RIRTZaUWRBSjRWeUN0YjBs?=
 =?utf-8?B?V1JsaEtESWhxZTRWVldZQzhMcmVyemppTzNCRUh0STMraURSSG1yeG11K1ZV?=
 =?utf-8?B?aHF6Ylh5WklienpTcXBEQll2aTZvenJIcW1pT1NoL1dEK1NFZ1hBa0VtSGFp?=
 =?utf-8?B?STVIdmJ0c3lNMXJWQXpDZ3FiUitUL3pLZTlWV3NyZVpuQjZZbTM2SnRhSko0?=
 =?utf-8?B?My85RzNaYU1vMXBOejJ6ZFNKem85M0dXZWFTVlJZV0F4NDZqbFJYVWI5Z1NB?=
 =?utf-8?B?TXI2ZW13NmkxVkIzQlZCWnRFbnoyc3dsT2wrWHNjWWdtQkozMmZsaVlYdWZP?=
 =?utf-8?B?cnhTb3F0NTlvclZDeXBYT1Uwb1VkZnRyWVRIZldkNEtHUVdXdjNaUzVVOThO?=
 =?utf-8?B?VmhSamZFVktmSHRVL0NKUnVrQnY1NE5zSjRyQWdYaklZcmNQd2VYcTR3Qi95?=
 =?utf-8?B?TTNFSEZncythY0lpa1BRbEw5d0dzeW5RUjFHbGJFTVZkbzRHeS93YWpNUEVX?=
 =?utf-8?B?cTFPTjhLNnNGcndqc0ZzYVlJSlhQd3NyS3NqVnlmOVF6Ykx2akRlcGpuQTQy?=
 =?utf-8?B?Znl4amxaKzdrdFdpRmw2dWpva1FvdUpQcFVhdkt2RWEyU0cvTVRJaVV0anVT?=
 =?utf-8?B?YnRyM1BoREJyYkMzTVVaQjdDa1VPajF5T3NuZnFBR0hlU3d1TEJnTVNYK3B6?=
 =?utf-8?B?MHpOMEJ2UUJxR0dLczdqZC9FWTIzRUVTMXBDdFhMSnhneFRlK1FZbEFNSSt6?=
 =?utf-8?B?RU1nSDNpcnFKRXhIb1JLLzBaQ2NkMEdaNkxsOXd5ZVRwTnlJR3FhN0w0L2Qz?=
 =?utf-8?B?QW5ReVdkTTRvUzh6WTBqSGN3TUd0VFNjN0hVNDJ4azRyV0ZyUjFRUVk1bW9W?=
 =?utf-8?B?eHdBUmJjZVZkaVhqWFg5ekc0dXc4QS9GNDN6TGxMN00wTUlOY3BOdnl3LzNS?=
 =?utf-8?B?UE9rdjU3S2hKeVlsUUlONG1kOFExZGxIdm5XZGd4U2dXbTVjTzM2YUwzeE5n?=
 =?utf-8?B?R2RwYlVjdVRqTEpYakVPN3E5ZlBDRUh1MHBkVmFoY21MUG5Rci9Hc2VRUzR6?=
 =?utf-8?B?RnJzTEVHaUdiMnZnVXVYQnpQN0IvRWVqK3ZlUWFUOGQ4cnlTOTJxRTM1dFFC?=
 =?utf-8?B?TFkraHRNUThtM2RjMWRld013YnRiRWNWc2FhdlhtZEFscEpoSTFNM1pSMXl6?=
 =?utf-8?B?VEJkeFBaK0dTT3B1VmtsdFNHWkx6NndyZHRBYTBLVjlLR2htamxiaG5nVGVu?=
 =?utf-8?B?Z0RKcWZlaDVBSUVuN0t6RVRCaXNrMU1TQm1oQnRYZUw0aXFtMXM4ZG1XejF6?=
 =?utf-8?B?Y1VZV01NUHJHcUxGSDFXOTlqc1RjZVNxYTZaQ2NGZ2ZHTkd0YlVJS0V3WWlv?=
 =?utf-8?B?K0NDN3dTYk5BVjVMbFBlekVOOGI1K2J5eTVFZlo1eUVUckQreFJWdWlpQWdO?=
 =?utf-8?B?RVQ2Ykcyb0FsYjRYK0VqY1c5eHpUZTNMTDI4b2QxSHdnaDNXOWxpOTM1S3E0?=
 =?utf-8?B?bW02OVpaNm9IcE1JemQ4Y3IrblNUUXlnVUE1V1NFVUtlZFZHQ0NCQ2QvZ25o?=
 =?utf-8?B?bmd0RTNzd3pidVBaalZxRDZEVzNnVzN4bWVlTkZBUDVxK3Z3Tm5uSld1ZkxS?=
 =?utf-8?B?S0hhdjBrTVI0RFZYWE1MRVVmSG54RzhhN0RrU0cxZ1BnUE0vR2huVGZpVHdk?=
 =?utf-8?B?ZVlqV2JBdU9jaE1RSXpnRGhaeFdQbURHZmRvZ01vV3A5dWxUdTJmOERBS3Uz?=
 =?utf-8?B?LzZFbFZITnlwNXdYem9FWmxTSFJrRzFzYUJzc2QvU0czRnovdSsyRVhjenlC?=
 =?utf-8?Q?cF7fis8L35oGgsfZgQeFZvxas?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cJVPT0ev15xqMXpX2Cy0tQgvTj+I6ipSygNGf4fA4/ulOmLva+p8DpuUqKF/PljIJ2te/SKm6YXlkveaeGtRVSwMkl1uB7ncjXQpcKRI6JbxfO7Nv6AVfYe/PQ0VVcZHrXcy2pFRd69fGNxcAVvL7CFef0pwI4JF42cO3N68FVJwfH549Hai7OVFLzTZcWLHHKbsO6Fz2MkSTfUAL8vtXsOgNL8yg4i/UUiZfdWebrBcnslJMekXA9jIVwLPnrA6uM+eB0mSWAWnOjli15anUNiXUwP+37w8jC4w0s+z27hJCw2XnsSnCNlV42AGYUWyDKdkkBG7DHHloOxcvJF2eGq+CCnqisSrfSt8fPVvnN+sKBejA9QYrEJP1r6JAP571qT2bikVxmvTw/j6spLSb7vIZKFjAZROyY7ZuL8+2L7HYfk/tDpjPU3JNGc82ZIDFh0YyGh419KGUg6vxA4tIFD0CNyxHK34gskeotdQ6zJ1sarin4pb9pyGjAYzISK9E1djk3VXg7AKg8iUuLv4l0l8QEOw6ZqOIgrMKXjZ67uZAQU3k+2yeQNM5PDvCbToP99ohPfTg/NE/Es0amUCGeuw1b20szgOpeqkDx8FIBI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c78323-2cd2-44a7-af12-08ddd4301168
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 14:55:07.3083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDyCskZ8P6nP6U0JN6nCrxBwqzPAd9nO9mEtveTvsQ6vAxajGxtK9X0+Emf3nAEDL8GFSSEZoUE3hg1fvMPvmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFF3A3AE169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508050108
X-Proofpoint-ORIG-GUID: foBL9JpROXdH2rdSGWht7PVBHZ5qF8BD
X-Authority-Analysis: v=2.4 cv=HY4UTjE8 c=1 sm=1 tr=0 ts=68921b53 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=v-GLa0sq8sOw5hhTj74A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNyBTYWx0ZWRfX8Z9XuBYL0bNq
 Q2SKT4WJpOCVS+n5GhT6GBW+7NGGHH+EN993BZ0bEEf9tk/kin7OJczmuHCAXLhkkPBjTXlYYoM
 +IUJiYnXo0HZcS6AOg+e3Eymslgvp1hLAI16cBu6UPyM0XXy5xkblsxCnqqGNvfxO3yiVkzvGS8
 VLrmS8WBmSP4aC5qdbg9cAOVTaXrZ/WKSElbMY13gjzoB1enVSgZqakIG3LiXOLyhMjOh5rApxY
 UWkwEks65/JkWWcezFnE9EHqs0XHTSRUJpEbhxGBmcEC2KVdRXqD5iJrYK9n+amj9/lGLNcFWLy
 hOhWDawdCsJS8sqYI46GE75bvSoIP+ZTBrcgK9QQoHIgZR7hOcXExedmrhQS+vA9dfjsX+NmYcQ
 x5ti1+aNVH1lpjl3fr+fDplAa8OCGIQUAmON8G6KxzCgwvghrMj+1xUfHKDF374WMk4BNzUH
X-Proofpoint-GUID: foBL9JpROXdH2rdSGWht7PVBHZ5qF8BD

On 7/31/25 7:06 PM, Mike Snitzer wrote:
> If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
> middle and end as needed. The large middle extent is DIO-aligned and
> the start and/or end are misaligned. Buffered IO is used for the
> misaligned extents and O_DIRECT is used for the middle DIO-aligned
> extent.
> 
> The nfsd_analyze_write_dio trace event shows how NFSD splits a given
> misaligned WRITE into a mix of misaligned extent(s) and a DIO-aligned
> extent.
> 
> This combination of trace events is useful:
> 
>   echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_opened/enable
>   echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_analyze_write_dio/enable
>   echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_io_done/enable
>   echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable
> 
> Which for this dd command:
> 
>   dd if=/dev/zero of=/mnt/share1/test bs=47008 count=2 oflag=direct
> 
> Results in:
> 
>   nfsd-55714   [043] ..... 79976.260851: nfsd_write_opened: xid=0x966c5d2d fh_hash=0x4d34e6c1 offset=0 len=47008
>   nfsd-55714   [043] ..... 79976.260852: nfsd_analyze_write_dio: xid=0x966c5d2d fh_hash=0x4d34e6c1 offset=0 len=47008 start=0+0 middle=0+45056 end=45056+1952
>   nfsd-55714   [043] ..... 79976.260857: xfs_file_direct_write: dev 259:12 ino 0x3e00008f disize 0x0 pos 0x0 bytecount 0xb000
>   nfsd-55714   [043] ..... 79976.260965: nfsd_write_io_done: xid=0x966c5d2d fh_hash=0x4d34e6c1 offset=0 len=47008
> 
>   nfsd-55714   [043] ..... 79976.307762: nfsd_write_opened: xid=0x67e5ce6f fh_hash=0x4d34e6c1 offset=47008 len=47008
>   nfsd-55714   [043] ..... 79976.307762: nfsd_analyze_write_dio: xid=0x67e5ce6f fh_hash=0x4d34e6c1 offset=47008 len=47008 start=47008+2144 middle=49152+40960 end=90112+3904
>   nfsd-55714   [043] ..... 79976.307797: xfs_file_direct_write: dev 259:12 ino 0x3e00008f disize 0xc000 pos 0xc000 bytecount 0xa000
>   nfsd-55714   [043] ..... 79976.307866: nfsd_write_io_done: xid=0x67e5ce6f fh_hash=0x4d34e6c1 offset=47008 len=47008
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/vfs.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 124 insertions(+), 11 deletions(-)

The diffstat tells a worrying story.

For the READ path, nfsd_iter_read() is the fallback -- the hot path
right now is splice reads. So adding instruction path length in
nfsd_iter_read() is a concern, but it's not an immediate problem.

For the write side, there is only one path, which is ballooning with
this set of patches. This is bound to have an impact on page cache
writes, which are still the default write I/O mode.

This is why I'm hesitant to apply this series as it is currently.

If I might suggest a possible action/recourse: Perhaps the patches can
be restructured so that the default cached write mechanism retains a
short IPL. We can leave the de-duplication and other optimizations until
we have field results from our experiments.


> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index edac73349da0f..f0cfd7b457240 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1314,6 +1314,113 @@ static int wait_for_concurrent_writes(struct file *file)
>  	return err;
>  }
>  
> +struct nfsd_write_dio
> +{

Nit: checkpatch complained about the style of the struct definition. It
prefers

struct nfsd_write_dio {

Same problem in the read-side patches, which I fixed as they were
applied.


> +	loff_t middle_offset;	/* Offset for start of DIO-aligned middle */
> +	loff_t end_offset;	/* Offset for start of DIO-aligned end */
> +	ssize_t	start_len;	/* Length for misaligned first extent */
> +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> +	ssize_t	end_len;	/* Length for misaligned last extent */
> +};
> +
> +static void init_nfsd_write_dio(struct nfsd_write_dio *write_dio)
> +{
> +	memset(write_dio, 0, sizeof(*write_dio));
> +}
> +
> +static bool nfsd_analyze_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +				   struct nfsd_file *nf, loff_t offset,
> +				   unsigned long len, struct nfsd_write_dio *write_dio)
> +{
> +	const u32 dio_blocksize = nf->nf_dio_offset_align;
> +	loff_t orig_end, middle_end, start_end, start_offset = offset;
> +	ssize_t start_len = len;
> +	bool aligned = true;
> +
> +	if (WARN_ONCE(!nf->nf_dio_mem_align || !dio_blocksize,
> +		      "%s: underlying filesystem has not provided DIO alignment info\n",
> +		      __func__))
> +		return false;
> +
> +	if (WARN_ONCE(dio_blocksize > PAGE_SIZE,
> +		      "%s: underlying storage's dio_blocksize=%u > PAGE_SIZE=%lu\n",
> +		      __func__, dio_blocksize, PAGE_SIZE))
> +		return false;
> +
> +	if (unlikely(len < dio_blocksize)) {
> +		aligned = false;
> +		goto out;
> +	}
> +
> +	if (((offset | len) & (dio_blocksize-1)) == 0) {
> +		/* already DIO-aligned, no misaligned head or tail */
> +		write_dio->middle_offset = offset;
> +		write_dio->middle_len = len;
> +		/* clear these for the benefit of trace_nfsd_analyze_write_dio */
> +		start_offset = 0;
> +		start_len = 0;
> +		goto out;
> +	}
> +
> +	start_end = round_up(offset, dio_blocksize);
> +	start_len = start_end - offset;
> +	orig_end = offset + len;
> +	middle_end = round_down(orig_end, dio_blocksize);
> +
> +	write_dio->start_len = start_len;
> +	write_dio->middle_offset = start_end;
> +	write_dio->middle_len = middle_end - start_end;
> +	write_dio->end_offset = middle_end;
> +	write_dio->end_len = orig_end - middle_end;
> +out:
> +	trace_nfsd_analyze_write_dio(rqstp, fhp, offset, len, start_offset, start_len,
> +				     write_dio->middle_offset, write_dio->middle_len,
> +				     write_dio->end_offset, write_dio->end_len);
> +	return aligned;
> +}
> +
> +/*
> + * Setup as many as 3 iov_iter based on extents possibly described by @write_dio.
> + * @iterp: pointer to pointer to onstack array of 3 iov_iter structs from caller.
> + * @rq_bvec: backing bio_vec used to setup all 3 iov_iter permutations.
> + * @nvecs: number of segments in @rq_bvec
> + * @cnt: size of the request in bytes
> + * @write_dio: nfsd_write_dio struct that describes start, middle and end extents.
> + *
> + * Returns the number of iov_iter that were setup.
> + */
> +static int nfsd_setup_write_iters(struct iov_iter **iterp, struct bio_vec *rq_bvec,
> +				  unsigned int nvecs, unsigned long cnt,
> +				  struct nfsd_write_dio *write_dio)
> +{
> +	int n_iters = 0;
> +	struct iov_iter *iters = *iterp;
> +
> +	/* Setup misaligned start? */
> +	if (write_dio->start_len) {
> +		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> +		iters[n_iters].count = write_dio->start_len;
> +		n_iters++;
> +	}
> +
> +	/* Setup possibly DIO-aligned middle */
> +	iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> +	if (write_dio->start_len)
> +		iov_iter_advance(&iters[n_iters], write_dio->start_len);
> +	iters[n_iters].count -= write_dio->end_len;
> +	n_iters++;
> +
> +	/* Setup misaligned end? */
> +	if (write_dio->end_len) {
> +		iov_iter_bvec(&iters[n_iters], ITER_SOURCE, rq_bvec, nvecs, cnt);
> +		iov_iter_advance(&iters[n_iters],
> +				 write_dio->start_len + write_dio->middle_len);
> +		n_iters++;
> +	}
> +
> +	return n_iters;
> +}
> +
>  /**
>   * nfsd_vfs_write - write data to an already-open file
>   * @rqstp: RPC execution context
> @@ -1348,9 +1455,11 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	unsigned int		pflags = current->flags;
>  	bool			restore_flags = false;
>  	unsigned int		nvecs;
> -	struct iov_iter		iter_stack[1];
> +	struct iov_iter		iter_stack[3];
>  	struct iov_iter		*iter = iter_stack;
>  	unsigned int		n_iters = 0;
> +	bool                    dio_aligned = false;
> +	struct nfsd_write_dio	write_dio;
>  
>  	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
>  
> @@ -1379,18 +1488,12 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	if (stable && !fhp->fh_use_wgather)
>  		kiocb.ki_flags |= IOCB_DSYNC;
>  
> -	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> -	iov_iter_bvec(&iter[0], ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> -	n_iters++;
> -
> +	init_nfsd_write_dio(&write_dio);
>  	switch (nfsd_io_cache_write) {
>  	case NFSD_IO_DIRECT:
> -		/* direct I/O must be aligned to device logical sector size */
> -		if (nf->nf_dio_mem_align && nf->nf_dio_offset_align &&
> -		    (((offset | *cnt) & (nf->nf_dio_offset_align-1)) == 0) &&
> -		    iov_iter_is_aligned(&iter[0], nf->nf_dio_mem_align - 1,
> -					nf->nf_dio_offset_align - 1))
> -			kiocb.ki_flags = IOCB_DIRECT;
> +		if (nfsd_analyze_write_dio(rqstp, fhp, nf, offset,
> +					   *cnt, &write_dio))
> +			dio_aligned = true;
>  		break;
>  	case NFSD_IO_DONTCACHE:
>  		kiocb.ki_flags = IOCB_DONTCACHE;
> @@ -1399,11 +1502,21 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		break;
>  	}
>  
> +	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> +	n_iters = nfsd_setup_write_iters(&iter, rqstp->rq_bvec, nvecs, *cnt, &write_dio);
> +
>  	since = READ_ONCE(file->f_wb_err);
>  	if (verf)
>  		nfsd_copy_write_verifier(verf, nn);
>  	*cnt = 0;
>  	for (int i = 0; i < n_iters; i++) {
> +		if (dio_aligned) {
> +			if (iov_iter_is_aligned(&iter[i], nf->nf_dio_mem_align - 1,
> +						nf->nf_dio_offset_align - 1))
> +				kiocb.ki_flags |= IOCB_DIRECT;
> +			else
> +				kiocb.ki_flags &= ~IOCB_DIRECT;
> +		}
>  		host_err = vfs_iocb_iter_write(file, &kiocb, &iter[i]);
>  		if (host_err < 0) {
>  			commit_reset_write_verifier(nn, rqstp, host_err);


-- 
Chuck Lever

