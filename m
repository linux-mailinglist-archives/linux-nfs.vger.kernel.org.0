Return-Path: <linux-nfs+bounces-17182-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBFFCCCEA2
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 18:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16A3830AEBAE
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967D837C0FE;
	Thu, 18 Dec 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oKD9f+Dv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IdKZyXX2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BD237C0E7
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073683; cv=fail; b=rC8yYQKllWQKB0w33fs3ISMsdiNWqg+8tekxgntWyGgTjemKI48Q+zscD2FK95u4BeMNDBI2FGqoYd6H0eUWxRxXwMOJbCmLAsHxvTs30YcawDpOm7y2hEL7yCPK3RT/Ctsp51P6XiIwcYH10Q/yz6X/S8SY3dmp23jimL0+hSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073683; c=relaxed/simple;
	bh=S8H8GHnTrTX8edBEVWNrB3ft8FircWwA88jb0aI09g4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AmdoaVxYTkfnelG3pl7bHuohSsWPk160GrAD6/x+lZz8gbS2hLlDPO2F0grObQp+YfBWEFgQh03cW4NYJ8HwzXwRpaTylrq7S7ID6VAHVhyPqVN1Ipz75sMMYjVG+7coFP1DSJh41punDpuGHOJ94+7zhIUdUM2Wus70EuCsMIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oKD9f+Dv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IdKZyXX2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIDCHs41341140;
	Thu, 18 Dec 2025 16:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Pr969j8z7vCT7L+TmQa4x8HYw+zhmwFPb/M/rz3/+1s=; b=
	oKD9f+Dv03uyunhFa+ADB+6EHpD3WmyclqGFhRq22i1mYeQvJoYWgAJOyVK5qke6
	0u2263RrwwQu9Uu5voq2m1ypxxGWNT4t4NfFyvluEd17hglIBhDnvh3b3zWFScBb
	8dQyjazlASSZCJP7/4Yy0TZpBVPcfa/mq3HtNoIu9RdOqpnGJyGK4ljw2F0h0Noe
	234j3qbi9Egkp/c4VyDsvXneLbm5lPqtK6TiU3m7kggmfx/9cy0Us6wCUBkRYLbA
	eByfto3dpXHPgm/NcAPbHjG/UAop+ywuod1H06AaHdRmVc6y2CcpQ3OkOph1Mflk
	6S8cWXRZ6PSU6VL7FNnqIA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b47qprxk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 16:01:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIENu32024563;
	Thu, 18 Dec 2025 16:01:00 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkd8tun-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 16:01:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYsbtN+gxa7Nkz9iNJVnd0XAMqvLgGKbwZsHou83xQJXLYfyh54HBA1QZoa4SNBHJkJPndverDiisON/foBVm7O9Rt7Ht9kreeu4H8vFZI0AtQlsM2ulCqoZvpYa9hnq07LSw9KFPPHqn71F0BF4TxMmNbdS6hpoKfgvDELDEMqZT8TVTHWqwfN+txn8VshJJKdwmWchJZE59P8y0BSFxvp0b6x9mPgt4I7jZG/5uIaIu1nxVRD+bb5PNl6emBcgBdXuOWsvJooU4zrXs/R5FZX3mslulN1OKOaQAlJbQ4Ikb0Nimj6zSVZksLGE+hzRfEOF6w132fn77HAwGeugJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pr969j8z7vCT7L+TmQa4x8HYw+zhmwFPb/M/rz3/+1s=;
 b=XAczirtSULE6JVoXjC/WpbWUyWyVfbGn8zv0mxTlbHBS0+Ka/Ugcuv3PYmzKAl9Rh/5Ngn8FMOBVl+W+TFHBtYs7qHcMUsZ6CwKxmvvgdMb+UnBePsE7AYwtnTk9I6950Os5pkjAJMHgLYRd3myn4d+uVWJp00ClZtvIlyfAPct1NxOFPPLKC/BGv9oWEYbOOPzeuHqGiau9fvS+dPGBWa42NydFDKQPWMlpY7KxlvHQePI//FT5+DRZS7YvUJWd0LT7QUnlM8QNLFqtV9o0PMnoMvtFZyVH2/0myVyXxpKX2vCBUESuyoXgFkjWUh/HQwvckqYnB18YniaKaBy0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pr969j8z7vCT7L+TmQa4x8HYw+zhmwFPb/M/rz3/+1s=;
 b=IdKZyXX2pAWWV7I0VOdPqrdmFjLBQXmJe3lRmEUPkI0NFGjTBjf3o5daF5HLscIHFbFFwmnThkLD5yMh0a/nRTmJay3bzGDQyIpSPxL4AWEbic7dfrUfCUuaEWRyhaHrgM4fCniMCo5/wPHLAU7VpgJJcMO9KfT3Lbv1MEqtdZY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA4PR10MB8349.namprd10.prod.outlook.com (2603:10b6:208:567::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 16:00:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 16:00:54 +0000
Message-ID: <ecc09cc9-a0c9-499d-9d47-e90aa1f1815d@oracle.com>
Date: Thu, 18 Dec 2025 11:00:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] NFSD: Add infrastructure for tracking persistent SCSI
 registration keys
To: Christoph Hellwig <hch@lst.de>, Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        linux-nfs@vger.kernel.org
References: <20251215181418.2201035-1-dai.ngo@oracle.com>
 <20251215181418.2201035-3-dai.ngo@oracle.com> <20251218093434.GB9235@lst.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251218093434.GB9235@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:610:51::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA4PR10MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e3e285-fd47-4664-a3c8-08de3e4e9fcf
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cG93TzBFNlBZdjBpbEI4UWkrKzk5SzV1SXZXWmE0RDVLMHprWUQ2NVdkejVS?=
 =?utf-8?B?NUtqQmNPWktTV2ljdDYxbkxXQlRiWGdDREJ0VHlzOTVMRm9IRFRkMHFoR1B0?=
 =?utf-8?B?WjdvdXQ1eWZNNTZvUWNUT1oxTm41bU5aMXI3VU5KMVovYTRGbU9pMTdwSmQr?=
 =?utf-8?B?QkxvT1R5Z25WTUhWeG9EdzhxV0VpTERaRnhJZVh3bEtzeWkybGxsSzdjTENC?=
 =?utf-8?B?NEtaSXFsVFZVaXBYL2pMRGxzTStSc0pRdjhIbWZrdHlzWlJDUmt5VGFxb3Z0?=
 =?utf-8?B?YWpqSXdneVdnRDUyNHVleXU0UEZUYzFNYk1rODJ6bjB0T1hCeGpYL3NHeXJK?=
 =?utf-8?B?cWpnZTU4cEZ3U0tvL2FwdEpuTWxvaDVsUTBiQURBR1JSbUEwQnF1WGNIQ0Qy?=
 =?utf-8?B?eE9oc25QakFuamZidnFzVjZaTDc0Yk9nbWsvNWkyUXN3NlZ1THVwbkY1NHF0?=
 =?utf-8?B?cEUrclR1RWpZeURSZXpwNmcxamlORlJQR2hFTGtnQlA1RE0zMXdYMXlXZUdp?=
 =?utf-8?B?RnMyMkthUmpNQllpQm5aUGFMMXJCK0MzSDg3M25UTkNUK1NnZ1dCaFdGc0RU?=
 =?utf-8?B?ZHMxTE55eXN1dzgydTE5Ri84UE9tZGtmNWc4RHdrcTViRUxNeW82NTQ0cEhV?=
 =?utf-8?B?WW1iZnVqN2ZYNFI0b0o4eStKY0c0TTZYUUd0RXYwTWJJelg4L0prNzZBYmVJ?=
 =?utf-8?B?ZVpBcS9vaWQxQUdSRWtmd0o3Zkh1bFZick04dVZIV1ZSMTVOTHMxSFpSTDBa?=
 =?utf-8?B?QXdDUnBXNVBxQVluaFIrMWsralA1TnVYWndNblpjOCt5WjRsQmJvaTJtbDV0?=
 =?utf-8?B?Q3JVNGZFZGZRM2VDRGx1dHY4bFB2UUJKYzdwK0kxbHZ0UnlqMGlqTUg4MXRH?=
 =?utf-8?B?UFdyRzNpeEljSHd3T3NDSng1RU5NYXBsV1JyVkxaYWZGbVo0VCszZ1N0alc3?=
 =?utf-8?B?WmhFYXJXL2Fxc2IzMUpaV1ZqOUJyRUpzdFVtb2RMS0JWZlRDbldlRGROM0d5?=
 =?utf-8?B?M2prTlE1VUFiaXRsTkVNdEl0MzBIekdqRFZJRllnZFRHUGtKWE95dWMxZGU0?=
 =?utf-8?B?ZGFyRm5YNThROWZrZThGcVJYTkRlcVJKV1hRTnZBUENHRWxuTFN0MDhwUW5i?=
 =?utf-8?B?dGNGQ2RTcVBoSGRFTmMrcTQ5YnR4TEdKamFMT2ZCMXRlN1B0K1kxODh4NWt6?=
 =?utf-8?B?eGdabktNekFmV0xqV0dHNnd1QmxXTSthSm9kRGZwemNyOWN5Slp2RG9xL3FO?=
 =?utf-8?B?S00vU0RQYXZSbGZ6bzRhWVVYN0dYbkJ3Vm9sSGJraUdRRnAxcE9zZGVGMnYw?=
 =?utf-8?B?K0x0bHRYalc0dzFpeUdqMzZpYXRpYzFpTHJ5eVhyT1NndSt5OXM4T3ZuQks0?=
 =?utf-8?B?aVhYNjQyL3dsZEtBaXhPVmZzdVh5bU8wcVdERVR6OUttRHpvOEFHUnY2MjhJ?=
 =?utf-8?B?WGJzZkpnc2hsQkVrOFY4NGFJb1hZbkFvaFJFbVFzK0M1L2RmSTIxV1d3c1N3?=
 =?utf-8?B?RVp0S0xJN2JPSEkzT0Z2QkV4UVZMWTVidmNSZThLMUhXeGZWenFhMDZSRkZ5?=
 =?utf-8?B?dzJQYkNac1R0TEo3VGxEMEtFYXB2RXdsb2tuN3FaWGpqcTBRYUwxN3Y2WUcz?=
 =?utf-8?B?WURXYWxuL2RwREhCbEtsUm5hS1QzbVdIczBPc2crTlVleGVieVNRUmtTU3pm?=
 =?utf-8?B?NExET1g2MkdVdXY0N0hNd1dYN3FTZlhGK3FXcmhmOE15RTRadHQzSUpJRG9l?=
 =?utf-8?B?aGhwU1RWWGovWTk3TURJM2NubEhkcWJSY1c1K0V3aHRzQ1RVWGRaN0YwdSt4?=
 =?utf-8?B?eWVOb1FqcHRPdnBmQ0p1TWdhdlJRU1VCQU91V0k2YVNYRXVQdEhVUVZORE9N?=
 =?utf-8?B?bGMyYmNLL1h4TGlBcnE3RnZTL0dhNk1EZzBVU2p2SFFpd2hGekdsVEt1djNz?=
 =?utf-8?Q?zUm41Fkoe/9a/U/++09K42CBhjM8D43m?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aTBpNFZUNnBqSTRxODlqendNSXBkNDBxMjVERkNYaGpqZFpFZ0dsT3RLeEJZ?=
 =?utf-8?B?UVQ3ZUlTV0xabWFQY0VzQ3R2bS81NXdmbU1wMHZnWGlsdm5TTWdZdjl4dE9a?=
 =?utf-8?B?akJpVDRkcGI4VlVrSWllQWZDYWx1S3BMZVFTdENvMmxxbm9pUUIzR2E5Y2sr?=
 =?utf-8?B?bVNMSXhqU3Uxd0FCdkd0cmNieGoyOUZnVGt2QVVBQmYrZTRFRzVsUTZLZFBq?=
 =?utf-8?B?aUI1Sy8yc2UxWkNrZ0ZGeTMvbXpleXpsUUFOdVprWC9hZ010Y29LenhRbmpZ?=
 =?utf-8?B?MVh2VU1GTGR5d1MyVWpPMk1sajNFY2dpWXdiMm9NR2ovQkVsZ3lJaHorNTlq?=
 =?utf-8?B?UWFuSmVYT1ZnbDh3NFNaTm5LOWxteGRWcXFlTG1ZWno5ME53eTZpd21nRzA1?=
 =?utf-8?B?bXVCRzZ6UFJuZ0FFK2RVOFZQTkNHSzBhK0k5MXVvREtmeVdJeUxxTnFrK3Zu?=
 =?utf-8?B?SWRZZEhqV1R0cm9QUTZkWXZkaTlQY2l4L09RaFdaZWpoT0ZGNy9wM3BtZW9S?=
 =?utf-8?B?NWJ5a3lYRE1JWllOd1ZTVjcrWGRhNnlqRFNjWXhxWWNJdk92TXJUK3RncXJJ?=
 =?utf-8?B?MkxlREFVMFp0WXcycGVySHY2YWZsSGQxS3hMTmVMbm4xeUQ3SnNDci9KM3Av?=
 =?utf-8?B?ekhoR25PMVZRSXhjaktDY21DUnBVaTVpNzVZRW4zV25RelpmWnlvZWMyWWsx?=
 =?utf-8?B?ZHZTY2pVajIzKzJsYU0rU3ZFbkNrL2hOVkt1L0hrbnZ0Q244aDFmTnhodzNz?=
 =?utf-8?B?MVozb2M0M2NmQmZ2WEkyaDRxTmxQcHpHekpLQkdlYk5DcnhHdDRybXIzUDly?=
 =?utf-8?B?VmZZSVQ5YTkzM3g5YUd5TzM4SkpUYzhJekE2Y1psdk4zMEtrWlhHZlVHUVJm?=
 =?utf-8?B?SDRlUWhvUDQ2NFQ5Wkk5V0FnMkJaam1pUkdnOGJ5cm9TdHlGM21CeUM4cWk0?=
 =?utf-8?B?RjhrZEZyMk9LWWt4aFpWeUpCLzAzWlBvSHppRTEweWlRTWxFYWVUS1l0VFow?=
 =?utf-8?B?WmJsMGRxRXVZVzQxbTdNKzFrdDkreVVWdmZNaXQ1SzgvMjVZMUVoRUd0RjhX?=
 =?utf-8?B?cExUNm5HOHhheFhIMHJqSmRxV3pyc1M5Vmw4T1RRU3BoZ3lPeTlqNC9aNTly?=
 =?utf-8?B?MHdYVE1xdTg2Uk5yMGpxdXAra1JsSTNuaEl2MHZST3czbXlheEVEUlh2TmdB?=
 =?utf-8?B?SDJsNDZqa29KUC9BWG00clNEamJpTFh4SGJIODlUbytkdUttYnB3UmU4VFlN?=
 =?utf-8?B?b3VycXRuMllKVG5yRzQ3Nkd1Sno1ZXZGV0h4UHdsRS9pSW5kc0NxRG9NSnlJ?=
 =?utf-8?B?eGlGRkhRUjBTei9xL0VTL1lZSkowVnJTRFZQUFJrR1pXRGF1SEZTbm9wOXVG?=
 =?utf-8?B?d2tuU2xGOVlVS2dRaHNJdElLdEJyMjZsc0pIaGdjL3dSU3FYTU1PMFRrODVo?=
 =?utf-8?B?eVJuWGxURDZkNXJzMldhV0hhWnpqTWhtazNKcVZPOWs4bkJudnY3cThqV1FH?=
 =?utf-8?B?SlRrdDRyeTVkNlJyQlo5QnMrK2REMXZ6NjI1S0c4OTNlS3BYSUdxZFVNOHlw?=
 =?utf-8?B?THhGQjVwaU9LWkdzNUZmYUN4QzVLRzFLOU5nQklYdEgwdThTYXdZYVdaOTk0?=
 =?utf-8?B?dW9GNXB3dFpubk9ZOTY1NUxxVGtNUVpjcWpOOGVLRTNGcGJnY0dXNWdzTTdz?=
 =?utf-8?B?ZHBYT3M0UTFIYmZNU0tndTNkd2xyMlNpWER2MTZyamdtR05LckVzVENPalhl?=
 =?utf-8?B?SlpzOUJqNkliVWV6SGwyZWUzOVl4Ym5NN0VCODNRUHIvUk1VQkx2STNlanlG?=
 =?utf-8?B?Y2ZqU1FNeXhmSy9qdkpiL1BiajVtcndoNGN4U1p2V0p2ZVVhQjFUM3FTcnY0?=
 =?utf-8?B?RG1DdTVBWmpGaWs1YnJWemJXSTVvQUZid21jT2RhZjRPM3k0b0FmbVBHWlpT?=
 =?utf-8?B?WDVieWgrN2NScFdNZ0RBZkJmRkIwdkR6cDMvUU4yai9mRDl5MUR5bGk3U2Va?=
 =?utf-8?B?K3V2V0ZsZFR5UUwwM2p5QXdhMlpLWUFYSzJBN2ZKWE5NMGVLdEZoblRWaGdO?=
 =?utf-8?B?N1JBNThFZnBCNnd2a2orWHdpMnh3OExSOG1YQWUvRXpiUzJJb0lpanBrak1P?=
 =?utf-8?Q?w//rcdryd+G6hh2CHGWBvEyAP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yjmHtahuCc4PfSaM1Z0Wp3bP4ahT5jsaHQnIvzDPt2ZW18biLBDJDCRXa5nFgA4yvXMe0coC/SE5Eqp0dFS8aDuYqG542hioRw8lIkEvBF37LuH7PvQ8JRdERA5f7UwbHee467Obbda4uxQCIyYiJoBJYQBhnSgbrGeg61ebEfBZV2jOVVer526eLAB8N7ojfYAugVDUVXzKFtv/fB3p5rE0SwwcKNajO/vrTVlf91SWVQMzxAvGfdspVIvIyMSjknsQPEV82jxEYhuyvQx89OrFHFoLyIt/BeiWYRkwnxC57s6Ojck+OvLrONIG3EP14hdWWAAM3622cTnoc181NEfMrWLyaf4GS1s/sEsoCIWEu0LiZQpcV6Nl9W9YIdRJFYxhd7zpRRu+9H8nBo56sp66Sr9nAZiq7g6RV293dquf9LZej7IpYDyzG9xWV0QroI65tmrfssf4rJ3a5U/lsa+vIcVswZxjk4XJPx7xrgrC8Z9DrAt8ib2G1nmyexPZTxzpWZ13lxKQeJRtXXC5vRUz0/bxbIUcZafUHsUXEJZOvdRluqSKchHoh7WcTw4U42yzXdMNNxsxMKiExQGIiaSsFWB4gaoXagV1A2xlS6o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e3e285-fd47-4664-a3c8-08de3e4e9fcf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 16:00:54.5143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpyWgZASbGDilfl6xGPWw1tiWBERlTRQFMefZQmI30HASJgR8mP+ASG+8sfpvUCgfr5QSyvvTCng0zqSQO8XWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=821 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512180133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDEzMyBTYWx0ZWRfX0APl/5kMZ409
 2QQxvXicraUr62DGPkxoWK807HhLBLnjcCJ8Y3RpmW6EUvV8V0BEW69B10GfgzgjCzvrCR+yNOG
 HeoHoIeGrXadxAK7t/8Hy9uG4CYUXkQKVC7FdpRaWGeDOW4mKvBmG4CXosgC7zr7F/lcufos8+e
 XEWBB/4FRVXlbVyIRy6Ew5b3mZmQVE3ap5dnLFlXADh+iYH0kP1G9z+WOiZL+1namWpThhkolRX
 P5nGEQNwZ9hThJ32t6MTA0nERp4jwxXeVRp/89uL22a+JMvji8tBm+/Up++fe/Lh9Rdp063ITyE
 YfIhCIktwq1TxsWkF1y655Rpb9QosGiKXNWnCRzt0WRofFp2Z/Bc2dcUf1/ghTlJnXU81THFTH+
 Fefhkyt+XYybhxz1lwypYF4Y5qqcNQ==
X-Proofpoint-GUID: CZPo875dXaPEmYVvcB3wKKi-DlTAsXfI
X-Authority-Analysis: v=2.4 cv=ePkeTXp1 c=1 sm=1 tr=0 ts=6944253c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ueSUOykb6m-dbeX-A0UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CZPo875dXaPEmYVvcB3wKKi-DlTAsXfI

On 12/18/25 4:34 AM, Christoph Hellwig wrote:
> On Mon, Dec 15, 2025 at 10:13:34AM -0800, Dai Ngo wrote:
>> +
>> +int
>> +nfsd4_scsi_pr_init_hashtbl(struct nfsd_net *nn)
>> +{
>> +	int ix;
>> +
>> +	nn->client_pr_record_hashtbl = kmalloc_array(CLIENT_HASH_SIZE,
>> +					sizeof(struct list_head),
>> +					GFP_KERNEL);
>> +	if (!nn->client_pr_record_hashtbl)
>> +		return -ENOMEM;
>> +	spin_lock_init(&nn->client_pr_record_hashtbl_lock);
>> +	for (ix = 0; ix < CLIENT_HASH_SIZE; ix++)
>> +		INIT_LIST_HEAD(&nn->client_pr_record_hashtbl[ix]);
>> +	return 0;
> I guess there is precendent in the nfsd code in using this fixed size
> hash table, but they are not very scalable.  And using the rhastable
> API is actually relatively simple, so it might be easier to use that
> than rolling your own hash.
> 
> If you stick to the fixes size open code hash, you should use a
> hlist_head here.  There is no advantage in having a pointer to the tail
> entry for hashes, and the hlist saves half of the memory usage and
> improves cache efficiency.
> 
> But taking a step back:  why do we even need a new hash table here?
> Can't we jut hang off a list of block device for which a layout
> was granted off the nfs4_client structure given that we already
> have it available?

My question is: how many items will this table need to track,
on average? at maximum?


-- 
Chuck Lever

