Return-Path: <linux-nfs+bounces-13665-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 615FAB280C1
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 15:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEB41C27CBF
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 13:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7D0303CAA;
	Fri, 15 Aug 2025 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a8yFZkgh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ztzdTPCV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DFD302CD6;
	Fri, 15 Aug 2025 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265262; cv=fail; b=fPCy+UhRTLeIPn8QI3NYrQjS2oFwa3i0TEQ6Fi1/31Y8/JFMMBnGCekO9oNFG0aOomapFuj5+iakMHSl60pS+DCheZ/q+VztXigzGFPXDZ3gw5zywYHGRGaphcjmYDvr9vG+tuxUzkbl3OXpX3edkoJri1b791Q0F5LD3nGyjJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265262; c=relaxed/simple;
	bh=UIjh6mmMWgvrH02tvz0e4z3QvQdfga8cRb0OF2UsakI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Til9GKOVpVP43acjdHf3Dv8rEQWdx4uKs1XcjFbU3vbQq4a5VTuadczuYYoJq4tokLRj+Jl71AjwryqPi0merVubEW5qVfu45awUuryHskwIRy1yxxCEslizGuKOkNklx6Zf8JHA5Y2H/LmOUny5sGss8IBF/9/0KzCnmNZLxtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a8yFZkgh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ztzdTPCV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FDN3sx009172;
	Fri, 15 Aug 2025 13:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SWuhUxkNSN8QxdQCRSPzdO8qiQBKOGmTzGJfZID5gxg=; b=
	a8yFZkghHdojGX8rsq8PF6E4CnGL6+w8Z5f5Hh2j4uws90jkVqnoUifh8E581Mkz
	GWr5zZE2kSjBA2TPUSEmyMy0+4Qd0ql14750We4Yj7Q29eREBJODmmlqoUv9XSX7
	NQ2zaL4EIR0TjcmAoRfBpfKA4nLYhjvg0AXwJ449u4fdUagpn9cjvYT8/v3R1qpW
	HuXa/Cmd7wiiu0RSJjyiMxSsZ7Y8RwC2UcvlYtaQD0eOACE4bWtfzVZ2eXbEZ1jl
	5q+SsXQJBeractijlp/9hEFWG9CByNl0sFlnGwWpvMvGZXn1gvFufSjTz+QMCC3J
	bdRkK9no2uXpLh9fvWCsdw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcfc3hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 13:40:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57FCMLoM030165;
	Fri, 15 Aug 2025 13:40:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsdyukd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 13:40:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIs5rw+i0/EDmul8yIfg65P9ALj1UiaWxvgOC89dR0MUJQyyrjqxPuEGRfYJEBqlKnOJzokSPvBRml/Yw27W4OiiXchpxOxBBToGeTw1aOPrPGyhEMiMBjdKIf0vu/NDip76H2Z336adh373p9ygQkkiEQxWfj/ualsKOtEqHrEg6olbGtKba60C3CS70LoNTCl5Prp69WTDslMU9Jk5/k2Zeo3yt3q5GT0TrGov+0GnYUKTftfTW4LL/G/lCfhojeOq7jqefSZ8lapLZllfe9i1lPn9v4+Joz+1lLMEKEJ5INjvMOV3gI2H5JnvwSeSwGWIw6iRux65W5odWjYWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWuhUxkNSN8QxdQCRSPzdO8qiQBKOGmTzGJfZID5gxg=;
 b=toDCxVVK5cO19g8KwfTGv+NAbR1GcI2w4KG5ZbDS3SNBsNMV8fOh1pjSN1QXtDjxUcefuKiceHrtuMitPO8pbrROB0KamsIMy2pLFKSucxJB4ggODkStCtzA+RQFGy+4cXAHt4U0k8seY7KNPkWg/Y6a5Mr2s7xFUgLTCYLkNtfEGdPXTHNo9+WPysRKy87RLXmTsJQB3dB3CXfcQAs4WVS1LomjrnEDE4v8MakGdzguZNAzjrhVJK8eEbtIkdF/N1vC/dkmaUWmtfajdLP3j1mYlyzOXcO4g77s8xjSX+an7zIXXhkAqw2sPVFnKwfKcPBTauRrpvO7isE6EMv9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWuhUxkNSN8QxdQCRSPzdO8qiQBKOGmTzGJfZID5gxg=;
 b=ztzdTPCVBnNRI+UYBsa8+ITjhJuACb+0XqSJIAe3w1HblaOkjgvKzqsnRGkZcHw4FAvTMt9JzDJzTDdQ+vSoWorFifgu+DhIo4w1tGHZUC+JL97jyvehm9IniAdVTVkTnLorn278FDpdmHFLa8O5xixXesiGreNBYSfX93eNYcY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4295.namprd10.prod.outlook.com (2603:10b6:610:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Fri, 15 Aug
 2025 13:40:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 13:40:36 +0000
Message-ID: <85d4697e-9365-4b9d-ac95-43e0dc31086b@oracle.com>
Date: Fri, 15 Aug 2025 09:40:34 -0400
User-Agent: Mozilla Thunderbird
From: Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 7/8] net/handshake: Support decoding the HandshakeType
To: alistair23@gmail.com, hare@kernel.org,
        kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20250815050210.1518439-1-alistair.francis@wdc.com>
 <20250815050210.1518439-8-alistair.francis@wdc.com>
Content-Language: en-US
In-Reply-To: <20250815050210.1518439-8-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:610:118::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: e29aaa98-1407-4a5b-4528-08dddc0150c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bW1GUG9Bckc4Mk1KOEFoUW10SldDcERRMEtrS3MvT0x1SkthNDdYeC9laG9s?=
 =?utf-8?B?N0dmdVo4bjh0TkVDc1N5Q014QUxmd0ZGYXJNRDU2Z0xvUGFPamNuclA1MUpV?=
 =?utf-8?B?RmNNQmZXS2k1Wm1hSitXdjNxRWVSanNodXUrMng3Q2FNSlYyaUFJVVd6RExy?=
 =?utf-8?B?endJOHRtOGZBb09EdkFFdHNQZFdzK1dFV05yTjhvbTcwVVB6dERMSDE5VnYy?=
 =?utf-8?B?enZtT0kybnViMGVncFRFdmtmWFhlTENPRTBBc1VVR1NZeHhzRlZIUmlXNERv?=
 =?utf-8?B?NDdsMDZHSU5XdjZkL1VhRWZIeGIzYmNWU09jSTJMNlhhRXJmRUc2RG1kai8v?=
 =?utf-8?B?Yld2VmJpK3lXeU1lQ3VVY2ZZYjZiUzgrVk4yN2tURlJXSWFIS1BJM2dFZm9L?=
 =?utf-8?B?WHNXTFpJRmEranBsQ252WVdvUFFJWVNLNDI2MjBPaSs2OFlFdU5XcEFSdFF5?=
 =?utf-8?B?L1B6NnlkWSt5NjNLQ2p3ck5CbWNINmFObm1vWlR2Qnp0bVpIOFdmTWpyQkRG?=
 =?utf-8?B?ZjBqRWtDL2pOcTNLa2pTMm8yd0pFNDFERGRYbHZXTG5GbjUvUzZNVkIyemMy?=
 =?utf-8?B?UnQ0REs5TlgzY29NOFd4NXhrbDRaUmUzN1lHYUtnazQ1TmJ6TTk1M1JMcWgx?=
 =?utf-8?B?dmtpOTA4RDdEaGx3QzBDVFBrRi84czU4eW1XenJ6S1d0Z1paM01sUkxUQU15?=
 =?utf-8?B?NzhxNmo2VHBiK3lOUWE3REJIdWdpVS8rNThMT1NwU1hZTHZicy9VQUg2UVJ1?=
 =?utf-8?B?WDVHa3NBbjBCLzRmV2NXYkNoc1M3eWx3LzZ6akdqbGJ2alVGWWYyUTRVcFUv?=
 =?utf-8?B?TklSNWthdnVwMVBXd24xcnNMRjQxc1A3Y0l0Z3JGemJ4TU11Mng4dnAxS3lr?=
 =?utf-8?B?SDA5VXlpd2Nkek1rdnpOcXJzbTFjTjF6QkJsakVJNmpQOHNweU8wVk1kUEV0?=
 =?utf-8?B?R05rTmNlVGE1Y0gwQk9xbGlGazVyL25UK3I0cGF6S3JtMVI4WmF4UXI2V2hm?=
 =?utf-8?B?TS82SHBVZm0xeldoL1hhbk9lV2dkOTlyMjlqem5abVRROC9HbWloVGxHSGtT?=
 =?utf-8?B?RW5HQmc3dUI3bCtQc2Z0QTUwd3h4TldUM05jMXk4dkkrT2Vab0FmZzdHeis4?=
 =?utf-8?B?S2lkYzZUNFB3MFFyTGNWZEQ5QW9iQzkrQk5KSTNzRTZ6YzlvZFpQbkYxS05Y?=
 =?utf-8?B?MWppV2VXMHh0RzhzNmpXUVdPd3VJR3ZWUWRPTXFLdEIxbDFlb0hqelVUWjdF?=
 =?utf-8?B?MWJIYW9ZRndwcUxTTm0wbGZJRC8xR2k5clFnaFV1Y08zaUE3R1kycWhwbXBz?=
 =?utf-8?B?Tml2SFlUN3N3d2RTelpJNXhLZ3RMK1BEcFViV095MXRFUmswK3hiaVY2QzBu?=
 =?utf-8?B?Smo0UTUxUmRERmkxUXdqSWl5ZWpwS0dDZVIyV28rWldKZVVOd2gwc1BOckl5?=
 =?utf-8?B?Ri9MQzVwNkV1SzYwNGRJZUZKdW5aaEhZVDhzb3N4TWVNMUJKL21MemtzQ2JJ?=
 =?utf-8?B?WllNTXlXeDJJaWo2M0FHZjRaRjA3MHRaTUlzQnFKTCtvckYzRmQ1ckE4c1RH?=
 =?utf-8?B?SVFoVEEyb3kwcEYwMDBXb3NndGNpYWdVczd1SlNxa1dkMjFBaUpKeVoyT1NF?=
 =?utf-8?B?b3VNb3VPMXNUbmZmQ0hQYlkwSjlKYjFUYkpIZ0prTkFDeFRqYk0yNFpkOTFS?=
 =?utf-8?B?MXgwOVlQS3prczduQnlvWENpTVgvdmh0dXREUW9TUXRGT0sySUxmOUVEdTNO?=
 =?utf-8?B?clNPdUpFckJaTmdRZks5eSt3ZXprY3A5NmRTMm1UK1o0bUgrclAxeWZWR3dh?=
 =?utf-8?B?eFJmN1c4MDE0VWE0cEdEaUl5bVp1UEIvRm9heFJkbld3SUk3V1ZNc2ZQTm1H?=
 =?utf-8?Q?yUglx4VU5VA8B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dE83L0lQT1VNUllkcmNOaFd5d0J1SmVhN3htaVhiZVF5YUZyRjJoNEdMUXlF?=
 =?utf-8?B?bTh4U2Rjc1krazlMQ0R6S3M4Ymw3RThoY0tUeVNlT1J4aVg2emlLQWpndmVG?=
 =?utf-8?B?aVJWM3VJUXdjUUhsQlFBTDhzRFREbHZCNDdiTjAxcUZkVDVCSmZ4S0ZMMlgv?=
 =?utf-8?B?SHVyZEZ0bCtGSGY3K0F0Mmc5MHdUYnFPT0ExY2s0WklHOFRRbFFyaVB4TVFt?=
 =?utf-8?B?TWlMM05xSXgvZXdrL2NudytXYmVDdEoyUkFFS0RXN1JNYzFhU2NPdUtldTZS?=
 =?utf-8?B?aDRWdmxnVzRTdnVRanJ6YVJna3lQbFFXTmExbGR3cjViNFJRczZRSlVEck0x?=
 =?utf-8?B?VVVma2YzOXZqNXg0cXlFdVFEZkFnK3N0RnZJU0gvZ2JXZ09iaTRGWmxDbDFu?=
 =?utf-8?B?L0ttZlJFODZ5WDhrVXBMRitnUEVyY3pQYlNSWXovUSttMEZVSGdDdmhVNVBz?=
 =?utf-8?B?RE1KUnVKSjg0Z1NPckZ6cmJvRWNBUm52cEl4VFdGOVp6WDkrU1M4RitLeWZh?=
 =?utf-8?B?cG1HYUZadG4yM0xidGtUUVF6RHZ5TFpOTXMwSjY1bHBua2ZybG9ZYzdUMStK?=
 =?utf-8?B?dWJPWUJPNVZsNmhNTmJxaW5aeDJ4cDVCRHMyb2E0dUp5UjAvczdVdWIwT2RL?=
 =?utf-8?B?Zi9KWllqemtvSTVQVCt5SlNZSVR3Q0p5bVQ0ZzB2ODArZ052L0JyNFVnWU1q?=
 =?utf-8?B?QUR1R2M1UkNPODBWMExwVldTYks1elF2RUp1OERrZ0QzUHV6V0Q5WkhMVHc4?=
 =?utf-8?B?bHlyTWF4MkExOUMyUm1MN3IxTHliMlZUYjJYNkxHQjZZMFVveWJnRU1uVDZB?=
 =?utf-8?B?VWo2ejNBTFBQVmsraFZHZzVNVzRSR3J2RzBKdzdMU1d2d2h1eU81bEVCUzlY?=
 =?utf-8?B?RVMxeUMxUXR4aGJmQkhZZnk0LzFaSk01RzJkK3o1S0ZVZXQyZTB6TVcyUjFM?=
 =?utf-8?B?elU3WnZHekJXUGlSLzlwb3lCVkMyU1hOd2R0OUMxSzc0Ym1ET2o4QTdlelBz?=
 =?utf-8?B?V0ZZNlQ5d3ZoaHVKaCtwYXBkbzl6RlhuellSN2hDZVVBaEVzak5yVWVJak9U?=
 =?utf-8?B?bmdOT0UzUWdCV3BHSEpwdldXaldJNEM5UWhoTEJ2bWJ1UnhDNlhEQ0hLRHlx?=
 =?utf-8?B?ZmRTSG1GeFlGWXRDejJlUURkSytsTTU3Y01hamhQZzNkZWFYNml4THh2MzBF?=
 =?utf-8?B?Kzl3em1QVU1COEExY2R1VWlVSFJ1MDdDalc4WFFOUG81ZXZOWDdhVVdlWmtt?=
 =?utf-8?B?OStmU2d4VEROWDZHby85cFIvdEdrOFdLaHY3Y2l4WnJSRE9lcjR0ZW9Yb1p6?=
 =?utf-8?B?MDMzSTZBNlhiSkRtRWlZV0RtRHgvdDV5ZkQ4bkptMXhsbUx1TStzUWZ6NjZP?=
 =?utf-8?B?akcxSzRlblBtL3pqcUJWc2FhaXhkcjZhM2NvcUFlVzVNVEtsaFgzRnhkSCs4?=
 =?utf-8?B?Z1RZZmhYMktuZlpsU05WSWdPWDIwUDFxUDhZMmxDb1hGTVN0V0RnZ1l6bnlv?=
 =?utf-8?B?aS9VMk9yeS9abkIyTlgxaCtoejI0cERjdlNCcm1vWlhhdTlrRG84YVJzZ0R0?=
 =?utf-8?B?bVVNa1AvYkdNak1NVENrV1hhM0FuWHFKeG5rMC9ad1lkTHVST2dMQ2k1U2Ex?=
 =?utf-8?B?b2FZUXdRZG9zNjBNdXFpU1JmYjRlb29PNDh3cndyOHVsMmNYZkZPYUppb1k3?=
 =?utf-8?B?RWlYSmx1RHBUNzJDaTZodXFzejRCSEFmNDllcTkyVEdGVHVyMExzRytVWXUz?=
 =?utf-8?B?T0dNdG5wUzEvZFQ1S2djTWs0TFZkUWtBVEl5eVVUeWx4czFoMVVybEtIdVN3?=
 =?utf-8?B?UmxLRjJ2TnV6YldQaXpHdEE5UlR6QU42MUtKWVIzZ3Q0aHI4UUYyaXdEazlK?=
 =?utf-8?B?WlpUVUdyZEZnT1ZzbVNVRmdrRmJLdmRqYmRlTnBZYXM5ZFB6UG5YMWxISzBX?=
 =?utf-8?B?dmxob1Y1QUVLbzI3NnE1VHJFZ2h6MzNieEF2R1JpWXV1UklXUWFYY1RSWHFh?=
 =?utf-8?B?VWowRVZxVlA0Q3g2U2IzL0lRMmRqQWpMZ2Fka2JSRnhYNTEwZ1hOU0VsUlNq?=
 =?utf-8?B?clJPaHZzOUtWRC9GeGx5QUpEZmp3RkxBVlM1bFkwQ2FySmRUV3NGVitqSmdS?=
 =?utf-8?Q?8qAkM+tIRQ/oLR7lEEj4wbdZV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JD/yv7v59tmVnZwoVaZp7JQmaZEWmyEa9LBNPcSrSWHIrWz3teTJU2DGJFg2qQoh9vv0jTYNM6/t0Dgz9rSWNSLpeYlRHvCx9BorqV+jwXaXjt8mqdSHJVZTB2CMlCfIK8KXLYryoSbRgnqWukYLv46hclJHj3KQp+HDXgGUPU9S6EEXzXs+5hHzOlzEilD1Tlmehs2FQjF8v8GEszLTivRGwoo4fBFsBDeWWpE6liyYhzrZO4NGxY0skKBUZzNQDK323wTFih2TFbep3xj5MecHZUZJ94dWziomBPabyrl9uLkgIe3w+G6/dfR9NWVELjtgKGThtupKsBY3h2CbzYrzT3rlPHP+WMLTEp0NnKXGHFWBpQe+zjlyW8um1TkDbybDVa5kcUwjLImBbGVXYmwVlL5stUgipFNZ881e50OXAaX2YjOQ1Dk2FPF+Y/gMe8lYG+UEu5+Hp+pu0XVHmcn0ZgHd9Xe0L/U9cj+0ntOIK8EgNMHEARPlXmVnMI3Kp2oAuDjUU9nmpADL0pkyw/DT9V3AgwsIeW9eBu4IM21Unv43y6FHjUIA77P/lWnXMZCnHT0zeYLExNKdUFZUlRmWbnE7rRooORhRVC9+2Io=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29aaa98-1407-4a5b-4528-08dddc0150c5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 13:40:36.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ND7+reUfdAS7yR1+TSYtE6liqmTeAXUYPXaChhwbhwaZh1lljGep7t1IngEDNoxEF1G1z4X/xDidg273s0XWtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508150112
X-Proofpoint-GUID: lThstbOtZQlBGuY2wdsCeWAmp7b4OSNR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDExMiBTYWx0ZWRfXxmpLR490+uIh
 AK6IqRa8BKn/1RD1kQOgT3YiyfvC1CN1i+emqHkkfu0tJXGC8wZdZ3FZctKl9YQakkNe7lqqMJ4
 jjU+mLUZ+R/29LCD8eWMkTJZAThttVvGtHljPvoRC19et70z6ClOkb7VkENmLKe0DKw2MRA4+Jn
 gZJmd0CTnNJwwFx+5Yjv99QJtovymtYCfLknP7TJNnw/EfPYq+aBPbfXLI0Ihbf/ZgQQZbqdSB9
 epS0rmPhiXVrf1L4/5c90CtYRWPxjclsh0pCzd+9FRcQ1vOJlsjJ9m2uUQ7juAEAN//4XO0km+w
 pEgmilDGGbCOg6usYD1GeSPTMOC3yUNR5GjOV5H341rhHFOmJsAS5/22pHQ3n75b/FPpYR61lqi
 Y6+jZIv6nym9FZRcJxIEcG8XaVg4pVgahJD2/gT0npJ5QeqsGGL/6HUVFQEcSTuNiU27VC08
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689f38d8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=48vgC7mUAAAA:8 a=I0CVDw5ZAAAA:8
 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=nWDESCXXDqufb46ehH4A:9 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: lThstbOtZQlBGuY2wdsCeWAmp7b4OSNR

On 8/15/25 1:02 AM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Support decoding the HandshakeType as part of the TLS handshake
> protocol.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/net/handshake.h |  1 +
>  include/net/tls_prot.h  | 17 +++++++++++++++++
>  net/handshake/alert.c   | 26 ++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/include/net/handshake.h b/include/net/handshake.h
> index 8f791c55edc9..d13dc6299c37 100644
> --- a/include/net/handshake.h
> +++ b/include/net/handshake.h
> @@ -54,6 +54,7 @@ void handshake_sk_destruct_req(struct sock *sk);
>  bool handshake_req_cancel(struct sock *sk);
>  
>  u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *msg);
> +u8 tls_get_handshake_type(const struct sock *sk, const struct cmsghdr *cmsg);
>  void tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
>  		    u8 *level, u8 *description);
>  
> diff --git a/include/net/tls_prot.h b/include/net/tls_prot.h
> index 68a40756440b..5125e7c22cb3 100644
> --- a/include/net/tls_prot.h
> +++ b/include/net/tls_prot.h
> @@ -23,6 +23,23 @@ enum {
>  	TLS_RECORD_TYPE_ACK = 26,
>  };
>  
> +/*
> + * TLS Record protocol: HandshakeType

RFC 8664 Section 4 describes the handshake sub-protocol. AFAIU the
handshake type is part of that protocol, not part of the record
sub-protocol ...

Also, it appears these numbers are managed by and made extensible by an
IANA registry:
https://www.iana.org/assignments/tls-parameters/tls-parameters.xhtml#tls-parameters-7

Let's cite that URL here, and can you include the additional numbers
found in that registry? Or, if we're adding only the type numbers
needed for KeyUpdate here, let's mention the registry anyway and note
that there are other numbers in use.


> + */
> +enum {
> +	TLS_HANDSHAKE_TYPE_CLIENT_HELLO = 1,
> +	TLS_HANDSHAKE_TYPE_SERVER_HELLO = 2,
> +	TLS_HANDSHAKE_TYPE_NEW_SESSION_TICKET = 4,
> +	TLS_HANDSHAKE_TYPE_END_OF_EARLY_DATA = 5,
> +	TLS_HANDSHAKE_TYPE_ENCRYPTED_EXTENSIONS = 8,
> +	TLS_HANDSHAKE_TYPE_CERTIFICATE = 11,
> +	TLS_HANDSHAKE_TYPE_CERTIFICATE_REQUEST = 13,
> +	TLS_HANDSHAKE_TYPE_CERTIFICATE_VERIFY = 15,
> +	TLS_HANDSHAKE_TYPE_FINISHED = 20,
> +	TLS_HANDSHAKE_TYPE_KEY_UPDATE = 24,
> +	TLS_HANDSHAKE_TYPE_MESSAGE_HASH = 254,
> +};
> +
>  /*
>   * TLS Alert protocol: AlertLevel
>   */
> diff --git a/net/handshake/alert.c b/net/handshake/alert.c
> index 329d91984683..7e16ef5ed913 100644
> --- a/net/handshake/alert.c
> +++ b/net/handshake/alert.c
> @@ -86,6 +86,32 @@ u8 tls_get_record_type(const struct sock *sk, const struct cmsghdr *cmsg)
>  }
>  EXPORT_SYMBOL(tls_get_record_type);
>  
> +/**
> + * tls_get_handshake_type - Look for TLS HANDSHAKE_TYPE information
> + * @sk: socket (for IP address information)
> + * @cmsg: incoming message to be parsed
> + *
> + * Returns zero or a TLS_HANDSHAKE_TYPE value.
> + */
> +u8 tls_get_handshake_type(const struct sock *sk, const struct cmsghdr *cmsg)
> +{
> +	u8 record_type, msg_type;
> +
> +	if (cmsg->cmsg_level != SOL_TLS)
> +		return 0;
> +	if (cmsg->cmsg_type != TLS_GET_RECORD_TYPE)
> +		return 0;
> +
> +	record_type = *((u8 *)CMSG_DATA(cmsg));
> +
> +	if (record_type != TLS_RECORD_TYPE_HANDSHAKE)
> +		return 0;
> +
> +	msg_type = *((u8 *)CMSG_DATA(cmsg) + 4);
> +	return msg_type;
> +}
> +EXPORT_SYMBOL(tls_get_handshake_type);
> +
>  /**
>   * tls_alert_recv - Parse TLS Alert messages
>   * @sk: socket (for IP address information)


-- 
Chuck Lever

