Return-Path: <linux-nfs+bounces-11070-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9763EA82AA7
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 17:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C14F7A51E3
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 15:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E853F2676D9;
	Wed,  9 Apr 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BfvmzGIF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HW4PEi9/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3559265CC6;
	Wed,  9 Apr 2025 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213156; cv=fail; b=W3Dw0J4FXAM/vHvGcmytFYMOLvB6bUmikepGyKRNhPDRzhx6tFBtsqPdRqPzJw5sMfuHtGiw3Cp8MeEgUvXMdPaEhFFeadEwxUrBs8+UID5zoi6+3v4mz8KSftUJ+4p4Sx//OLwzihxVNyRIs10f4rQQ4C6kxRgM2yGM0274pvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213156; c=relaxed/simple;
	bh=ZkDqG0tNWX5HC6dZmBnLEoKJW5pLPYFYrlpERE3wOM0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IQ/0x+CCqOGI7qIBNXE8Ju3SykkdFi/IdrtANH8USWZOvYfzwRI8m5HNMXqXwAKZIuJam9OPLLSFfrwrhoBx2Lgvu6tFboK/dQCEDJFJ4AJxjibv3M5qZucE8oO94CleX76FYj5crtr6vDpT45/FHZ9MIBpOdzdya7/MlXpDyyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BfvmzGIF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HW4PEi9/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539EWHW7013752;
	Wed, 9 Apr 2025 15:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=l+ve+oA0UREt/yzp/RnYxu/2sD04dtKz/YXldFZKIUY=; b=
	BfvmzGIFXjzyIRxVZmX1FmcRyUVjnCQnLmUDSwSPnjM1Nea0qYzQLAcW6nE1AFoK
	Vi7Wf+x7PMbE5+S3biwHCLNInFQ627bO7Pu8T1vkNsS4Gzcv1mDCagA7zqVym2BG
	Fpfo1apz7FLxNtjvaSM8MEERySQQkpAUkCqzkUB3UR8JIZsfbygVOetY9drKHeYs
	zZMPa+Z/yMSLfFW/Fzvcj967cSDwCflPENaCFkBTQ7KeyG3m5HNxFm6VOAVMjaUI
	TbWEgVS8OTwZ47d2E/8vRVSW4uxTemTN0y3khT4YjMmIpHYHW5PZA6xLGwrAALrK
	MizdovhlCG75IIeCH3WTJw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tua2yg5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 15:39:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 539FNpoK021126;
	Wed, 9 Apr 2025 15:39:04 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010000.outbound.protection.outlook.com [40.93.6.0])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyh9u3u-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 15:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJe31O8uftVbqDW49mD8hXQTuarYh6m/BcKr7FnSaM+yKXv7o+9THsHPSoac8q0jx66Jc6F1Tif1uwSxFo6yImyW2t1OesYwHDLjShtc7SjVbO0uwC+6nkE+8z9sO/Rz5B87rsEpui9Ei3aqq05W1X/1Ur9Hpp0LoOwKoo9rEuJG6BsQ+t1q27dZSr4rFMWplUF3kkTGM+z90CJg8OwYMJTOby2lw9E1QMP/yJNNCaMygqaIagURrJy9wk9FjHUGeS5XhvWsqCpUlj+DDI7baw//gC2kHo9Jzo+UvSua1o324om4x0NFkSR6oisfsvMilnMBfdVUQ4U1/cjVhnVrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+ve+oA0UREt/yzp/RnYxu/2sD04dtKz/YXldFZKIUY=;
 b=lGQC+oTS1NC6/DdobbeOZAVTZPFBcrEW8j+tIQRD8E0Era4zzAz7zBvF2Zt2k6aJ78BRpWqYsc8NxpwNdXq9ZFANWL1AIe3Y8uRYA3w8mDqhotdK3HlFi/Mdf05lc9wVw+y1mC2jTsSm8glI6OoAqtQ6e+l7DKI7MiO1hXxGVK21n6aRTjEZb7uqu5sOJjNs7eKiTsl9JOVNKZUH7+AVgLI/lo1Y7M/anFf7r1R7NqHZWeWqTzNGLf1h8i7diTTgLyLHPcB6eX2DKz4I2wfRqMwQ2vdxXdqNSbdxppD2FjfwXAgdqrh+OdZmrEOfWo1NyUt+jSiDl8cyRwi3POrfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+ve+oA0UREt/yzp/RnYxu/2sD04dtKz/YXldFZKIUY=;
 b=HW4PEi9/+5z7hU0vzL0yBo1B7sLhBHcUBtiEvzPvKt7XjqlrcOyGN6YmA8jzute0oylI1gGVie5BgAwdfFsbCLYHtA57bmGCh2veJbcL3/kjAsrBlRC4a+zkBUAE2YiTbPSM4FK4acYnS0hXrEsMNMDsmI0ZMBzdm5xFnAXfX6M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6562.namprd10.prod.outlook.com (2603:10b6:930:5a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 15:38:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 15:38:59 +0000
Message-ID: <d0c0f6e0-ad8d-4f5e-a24e-700df88e3ec5@oracle.com>
Date: Wed, 9 Apr 2025 11:38:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] nfsd: add tracepoints around nfsd_create events
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
 <20250409-nfsd-tracepoints-v2-6-cf4e084fdd9c@kernel.org>
 <078a639b-1f19-48e2-a0cc-f861b67f34c9@oracle.com>
 <11d5010fbe14e21b614d7cc56bae1805b35f3a31.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <11d5010fbe14e21b614d7cc56bae1805b35f3a31.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: d9281369-e5fa-484c-446a-08dd777ca565
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QVd6TGR0ZHVLR3lqWDZ0S1NnWUcyWXd6Vm1EUmlGVFhRVUxJQVVRT1k0aldn?=
 =?utf-8?B?TEhXdTErWFIyRW1vZUdSTytsKzBSWVlWWjFFN1hVK054TnBnRFhFWWYvWWtS?=
 =?utf-8?B?RHdVb29nQk5KUnIrdW9tcGpxdU1nVHhiLzQ2d3BaTUd5SjlQY0hmUXpaY0pw?=
 =?utf-8?B?SlYzbFB2LzA1a0t1REhlTTVic0ZwNmx3R3l3bCtCMEdlSEVXQ2xQNDQ5cGJ6?=
 =?utf-8?B?ckIzZU9iSzFBYURKU1BCNXlJZjRXYk15SzJaMi9TaWRpVk1rQjhrZGtQS3lv?=
 =?utf-8?B?ZEVCbjZ0UG1md0JPMDlPbTg0RWVjU2tLUzhneVZEbjk0NjVHdUN1MWF6VGp5?=
 =?utf-8?B?Mm9KbjdyZk55UHVvOW14T05CVi9ubFdHNkxHT1J6KzNaTVFHVUFyRjVUVSt6?=
 =?utf-8?B?bDhyb2ZGTXdCM2pWam1sdEhaenZQdmROSXNhdThKSUVIRTJNTFlHenRpRUxM?=
 =?utf-8?B?d0J3Q2c3dTdjSlhqcWtSbjhId2cwTHhOczRrbG5KRHlZV2o3NjR1eXZxSmd4?=
 =?utf-8?B?NndGcU9idUFTUkVxZW5oYzFwNFhJRnJhdXd3VXFqNS9XR3VMMHo3UzJRVlZu?=
 =?utf-8?B?ZFlCSnhMRmJkcTdDVkpodXJvblRudEdJMURmRkVXcnZnN0lSOU1iMlp1RVpv?=
 =?utf-8?B?d1hXMzU5UVgzYVBLMVBjUWdWOGxuOGEwYnpPSXVySS9LWEF1SVRZZjM0YVdx?=
 =?utf-8?B?Q0dhbmY2VDhOYnJNVzJrK0toc2J2UCtGZHIxRkt6Qzd4eENaRkY2WGc4aDVN?=
 =?utf-8?B?cjFrK2NmVkpzeWMrbEpzTlcxM21FTEhrN1dNMWJMYmpoOGlocU5Pa3d4TSt4?=
 =?utf-8?B?Q3ZGMWFtZWR5ZHovcHFMK2lWY0xsMXp4bVBSZnhsV1dyWmRHWjBrelpHVTNE?=
 =?utf-8?B?UnNEd1RCQ2p1Yllsbzc2Z1NVSk13a1c1T1F4bWJWTjRWRGpkR1RhcHp4dUdh?=
 =?utf-8?B?Yno4d1BVNHE3TjlwOElkREFWenFpRkVLYTNvMzloTTE4S0VreEszTGx0WktB?=
 =?utf-8?B?cGgyTE43RDRGZGtXTXE0Sk9hOXZmM3hMZDFOY3ZrRjd0ZDVOSEsrMHF2RTdP?=
 =?utf-8?B?RHhkRkltTGhkbHo2S0kvSVJjTkpWdmNMU1JtWk9TQVNqTUZVRHY1YlIwNEoy?=
 =?utf-8?B?ZjhiUG0zd1JMUEVueEpSQ3dIYXNiSm9la2tHQXdXRWFiOTFOcVZGTGZrS1hq?=
 =?utf-8?B?Y21KTnV0ZEpQUTVRTDJEYURZNE9PYnlWeDV6Q3kwenBQOFYrZDZGV1cybzM5?=
 =?utf-8?B?V01MdC9qU0xEVitST3lVSkUvelNidGY4dUhjNmUvbG8vbm1UMVFqWFpmM1Vr?=
 =?utf-8?B?V0s5am1UZ2RYWXZJdllGTS81TTNmSGV2WVRNMk05ZFh4MTBQS05DeDdPZUZm?=
 =?utf-8?B?UVQrN0hOcjYzQmdRS0ROeERJWFhTbkJMYnRrZzk3bzRrZ2krVnJnYmpiMXVx?=
 =?utf-8?B?MXg3L1p4cHZDY2IzTkEwcUVlMm5hZkl6ak9DZXU4cm1qY2lpaXdNcHdzRU8z?=
 =?utf-8?B?RHJyNDhaWm5FcEg1VXdKYmZIeFlYUllMdFNUd1RaaUpmWHpYaCtkUDYxbllS?=
 =?utf-8?B?S0ZvUTZUY3U3OHdqWUlGV1RvMmJsSE4waTNpYTdMMXQxMTkxRkNqd0ZmZ2Fz?=
 =?utf-8?B?Q2hTbGEzeWpRSzc0RUdkcmtGTUQveElXRVY5VzB6TkJEbEdNUHExaTFEQzJK?=
 =?utf-8?B?VXBiMjRkK1VHaW1UdW5wWDRJNXRVRGxoMmw2NWoxK2ZCRjlXQitMcjNvamUz?=
 =?utf-8?B?Mk5qSlMrWCsyYld4WG5LYnp4WTVSVUtXMCtPNmJvejJCWng2NVRjK0FMalMw?=
 =?utf-8?B?YVU0aDVXYWs1Qzh0cmE1ZEg5VzBiUDI1VnBGeHhrMlhlR3Vsb0F4QTdYZzJ2?=
 =?utf-8?Q?/GZzpDqzGlrX+?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WC8ySHJkZDFCMGo2NzFlaXNlMnBpYTk4SHFFNC8zTWtnMEJ2bW5PdHh3Uitw?=
 =?utf-8?B?TVBwUUppR3JPY1NsTHBQOW5pL25LV2lrejY3M2JCMDdRUUhOaW9vK0hDN1Jv?=
 =?utf-8?B?bzJkaUtEOEZMaURmWDNBZDhNVWxpaXFLYmhMeXdpdTMzSWdiV3pVbEFldXVK?=
 =?utf-8?B?aVdjamtOTHdtWVNpNE9VTXFxTU1QNmVWZ3dUQXZxMmFUcjQrWkFZNHdDZ3Rr?=
 =?utf-8?B?b2xOWjJmMGlVc0dBMHVZMVJVLy9XK05KVXpTekMvTGlYQWYzVUYzMjA0TTdG?=
 =?utf-8?B?VmxFZzR1dlVvams4YnFPZDBRYVFFZWx6dWZLcHhYMTdZNlZPWWlFQS9kclZB?=
 =?utf-8?B?SlZyM1NFK0hvdmN5cmNQTHVKbm1SbHZDYXNCYklUcjlMZDh3UGNwbzVkVWc0?=
 =?utf-8?B?cHlQOG5sZ2k1RkZoZWpXVlBsVmtSZXdpKzFIVEZtODEvRWw2cUpzK2tlaEVP?=
 =?utf-8?B?MjEvRlE1SzBLaE1QNzU5SWFHSzRHUXhHZVN0d1YzVy9LMXFOZUpLYjQ2TE9I?=
 =?utf-8?B?am50YlRMYm9oV2xEZW1yVy9Ma0tpc2w4WFA3UHpkZHVXbGwzbU5yaTNUSEZN?=
 =?utf-8?B?YXR3TFVIWFpTSlgrVDMzV0Q2Q0pNQjRMV0dja3JLS0VZQ1lBeXM3OGN5ZWpT?=
 =?utf-8?B?djhqK09xdWFLRmxZTWp4ZlVuc01pdCtteE9iL1hqRUtTTG85bWN2ZnZ0MUxp?=
 =?utf-8?B?N1VWaUtoWnVpdFoyV1hTOVdsbEo2UjJ0aXBLSXU0TDhxYzZ6aDVQMWswQ1Y3?=
 =?utf-8?B?eGJtaTlqOEE2VzVwRUlXYTRKMlNpdERMY2NGL0I5SEoyYTNSZm9WYWtTWkwv?=
 =?utf-8?B?clh0SWt1T1BwMFRlY0lIL3lBbUpjUlpIaUVDUlYxQXVkanFYamJHS2huelFE?=
 =?utf-8?B?dk1TQkNVYjlqU3oybVdpajkyTlNQNUsrY20xbFZseFVIQVpydXI0YkI5T05S?=
 =?utf-8?B?bDZLMEhHL0VZSzQydDlCcXg4ZmFzN1QxT1FwU05jVHNaN3dLT3dQYS9WbCtZ?=
 =?utf-8?B?R2hPL2FxWC9TR1dkbklWS3VUWXdIM2tjTXhpbmlvU3F0SjI4K1dWYXFVZ1l0?=
 =?utf-8?B?YVVqTFNvTTFFNmM5WjF1djFVMm9JRGowU3VmT0xpVTgyZ1RwMURGdFVXaWc3?=
 =?utf-8?B?OUwySEp6SHI3R2RyRkE0Mk9PZ1J2TFRZOWxKYW5wNkNFT3I4VVdmSXBHYnZG?=
 =?utf-8?B?UHFFWmduT3FJelBQUkdkWHJVV3E2ckl0aTJKTXlNaVM2SXRXcndEUkt6NFhR?=
 =?utf-8?B?M2ZmbDUwUmd5V1pEakFnL0dHSXQ2U1M5ajU4bW1nUTZoVHpJWWFETEtKeHdz?=
 =?utf-8?B?N0hRZkVWMDZDczZHUDQ3S1hCNVF0T1B0dTkzc2V1aDB3OGMrYzVzTWFXMGdG?=
 =?utf-8?B?d3MzdG0ya2RsZURZNUh4dWs1dDlodGdlMVdHSXFyekNwM3lFeEt1cHNDTytB?=
 =?utf-8?B?UWg1TytLVEQxT2dkbHk4a2duaFplOElDMlRkTHBnSytCZVFsSmlkYThNOWx5?=
 =?utf-8?B?enE3cHhjMU1pcDliSlAwQTRzblJDMHY0MEthZVRkZEttbjRqOFBYcFQvSjY5?=
 =?utf-8?B?ckE3d1hEa3RETkxYaXRqZzJlUTRCa054aVkzN3NHSXlNWjY3cFJlWTVZWGVo?=
 =?utf-8?B?aUR2aHZ6YTlQWjV6eDFsSzVid2VMbmo5MFUvNFFhT2NBb1QyZXFDdGcvQWYy?=
 =?utf-8?B?Q1FiN2NCNVZ0SGJFZXZnL3hMZTJOb1kvd0pZekVQRjExOE5obzc1Ri9DUG14?=
 =?utf-8?B?SUdkNHB0NDBYYXlZN09nMVhLbGNxSXpXTlQycVp1cXZDM3ZrRkw4SFNEVDZn?=
 =?utf-8?B?TVNyRzNuVFMzZktPSXk5LytVcEdrQUFjMGtPSHdHR0w2UkhwRTl5eG1jcmFx?=
 =?utf-8?B?TEl4R1RMMEtmZ2YwMGd2N3pMQjcrZi83UWEwaTl3TCtSUFQrZlJXakIvRVk2?=
 =?utf-8?B?MURSVjBRTHRxMEw3eU9vRkdMZXE0MDF4MVkvbjFkTGM0L1lqZXVwZnR6dng0?=
 =?utf-8?B?RjQyK2hKVlZFa2luMGFVWnR1U1NHOWxiWUNXMWVVVVRjdWFrUXJYb0R3ZDE4?=
 =?utf-8?B?LzFCdWdkQzliNktFeEhyQ2k4VHpQYXFBc0lwZjFnd0xtbG8yQkphREpUK2Jq?=
 =?utf-8?B?Yis0QXNZZ0l2dkRKWTd1SDIxN2ptOXEvb01zU0VXUW1qWVI1YmNTMjFBblhU?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v2/lZF/pu1kPdOPc5VdCV45ML5NksuC0FOTMyh/liiJ3TbOxxulBM1JZ5GIms/HD5vvj6UuLpLo+3pTSd4aet6QHbYCx4g7De3YhegOeMuwRTtFaPXJ10e/2KkNnZhRkwuXZBdVH0yidkMRZc929hg6ua6RbiSmQ0VC7MbWFEBFZgh8s0P1ezrfA8asXBAinDX0wjdzKBQnZhMyQThfwtfr3ZnWJKS0+pgl1Tio3E9rzwQB+yk4PBK+8EhTxLIWc31Pt7YFMk+lOTcJ7UN0rCMiGwHVa/RRRZYjbmPoBkWvQbUzMI1z/zEeHHNHbBWBa6K1b5ZBrHjOSDLn2C0CclFkuU8aoaFABQwQ0aKmUJIr6QnU4UG1PVZkFSq4iYOE7cAnx/yaA+FcM/obL61980PD2XKN0tM/MeoIRwZ+m2veMIX+adWvyiheA2qt/XYt4jIAtKz5+SQflQqINnYIJRkJ1wdwJY5QVAzEpLfyJ8SC39+dxYdLBXzIiyN2zVsoMQeI+7QzNqogdgqIKQdFBCKqWv4eepD+hY1q059gAac1FnPkb/+snkU7+hjVE3ex8H9z8SQXPz4XsPlCHsME/JPZCoPyIhEuDRbNnn3MQoVE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9281369-e5fa-484c-446a-08dd777ca565
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:38:59.2421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaOAjCP95BA0vAlyhMqBtSgT9ZGXdZmcf7JcAD36GJSNnd6ZsYgmDU+joyN7/m3qNRSJj1CV+ixcv9vTHHQfAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090099
X-Proofpoint-GUID: L-SwLapic7nJTqqseMLtZ6OtxyQLl4FA
X-Proofpoint-ORIG-GUID: L-SwLapic7nJTqqseMLtZ6OtxyQLl4FA

On 4/9/25 11:36 AM, Jeff Layton wrote:
> On Wed, 2025-04-09 at 11:09 -0400, Chuck Lever wrote:
>> On 4/9/25 10:32 AM, Jeff Layton wrote:
>>> ...and remove the legacy dprintks.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>  fs/nfsd/nfs3proc.c | 18 +++++-------------
>>>  fs/nfsd/nfs4proc.c | 29 +++++++++++++++++++++++++++++
>>>  fs/nfsd/nfsproc.c  |  6 +++---
>>>  fs/nfsd/trace.h    | 39 +++++++++++++++++++++++++++++++++++++++
>>>  4 files changed, 76 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>>> index 372bdcf5e07a5c835da240ecebb02e3576eb2ca6..ea1280970ea11b2a82f0de88ad0422eef7063d6d 100644
>>> --- a/fs/nfsd/nfs3proc.c
>>> +++ b/fs/nfsd/nfs3proc.c
>>> @@ -14,6 +14,7 @@
>>>  #include "xdr3.h"
>>>  #include "vfs.h"
>>>  #include "filecache.h"
>>> +#include "trace.h"
>>>  
>>>  #define NFSDDBG_FACILITY		NFSDDBG_PROC
>>>  
>>> @@ -380,10 +381,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
>>>  	struct nfsd3_diropres *resp = rqstp->rq_resp;
>>>  	svc_fh *dirfhp, *newfhp;
>>>  
>>> -	dprintk("nfsd: CREATE(3)   %s %.*s\n",
>>> -				SVCFH_fmt(&argp->fh),
>>> -				argp->len,
>>> -				argp->name);
>>> +	trace_nfsd3_proc_create(rqstp, &argp->fh, S_IFREG, argp->name, argp->len);
>>>  
>>>  	dirfhp = fh_copy(&resp->dirfh, &argp->fh);
>>>  	newfhp = fh_init(&resp->fh, NFS3_FHSIZE);
>>> @@ -405,10 +403,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
>>>  		.na_iattr	= &argp->attrs,
>>>  	};
>>>  
>>> -	dprintk("nfsd: MKDIR(3)    %s %.*s\n",
>>> -				SVCFH_fmt(&argp->fh),
>>> -				argp->len,
>>> -				argp->name);
>>> +	trace_nfsd3_proc_mkdir(rqstp, &argp->fh, S_IFDIR, argp->name, argp->len);
>>>  
>>>  	argp->attrs.ia_valid &= ~ATTR_SIZE;
>>>  	fh_copy(&resp->dirfh, &argp->fh);
>>> @@ -471,13 +466,10 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
>>>  	struct nfsd_attrs attrs = {
>>>  		.na_iattr	= &argp->attrs,
>>>  	};
>>> -	int type;
>>> +	int type = nfs3_ftypes[argp->ftype];
>>>  	dev_t	rdev = 0;
>>>  
>>> -	dprintk("nfsd: MKNOD(3)    %s %.*s\n",
>>> -				SVCFH_fmt(&argp->fh),
>>> -				argp->len,
>>> -				argp->name);
>>> +	trace_nfsd3_proc_mknod(rqstp, &argp->fh, type, argp->name, argp->len);
>>>  
>>>  	fh_copy(&resp->dirfh, &argp->fh);
>>>  	fh_init(&resp->fh, NFS3_FHSIZE);
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index 6e23d6103010197c0316b07c189fe12ec3033812..2c795103deaa4044596bd07d90db788169a32a0c 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -250,6 +250,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>  	__be32 status;
>>>  	int host_err;
>>>  
>>> +	trace_nfsd4_create_file(rqstp, fhp, S_IFREG, open->op_fname, open->op_fnamelen);
>>> +
>>>  	if (isdotent(open->op_fname, open->op_fnamelen))
>>>  		return nfserr_exist;
>>>  	if (!(iap->ia_valid & ATTR_MODE))
>>> @@ -807,6 +809,29 @@ nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>  	return status;
>>>  }
>>>  
>>> +static umode_t nfs_type_to_vfs_type(enum nfs_ftype4 nfstype)
>>> +{
>>> +	switch (nfstype) {
>>> +	case NF4REG:
>>> +		return S_IFREG;
>>> +	case NF4DIR:
>>> +		return S_IFDIR;
>>> +	case NF4BLK:
>>> +		return S_IFBLK;
>>> +	case NF4CHR:
>>> +		return S_IFCHR;
>>> +	case NF4LNK:
>>> +		return S_IFLNK;
>>> +	case NF4SOCK:
>>> +		return S_IFSOCK;
>>> +	case NF4FIFO:
>>> +		return S_IFIFO;
>>> +	default:
>>> +		break;
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>
>> Wondering what happens when trace points are disabled in the kernel
>> build. Maybe this helper belongs in fs/nfsd/trace.h instead as a
>> macro wrapper for __print_symbolic(). But see below.
>>
> 
> If tracepoints are disabled, then the only caller of this static
> function would go away, so it should get optimized out.

AIUI, the compiler will complain in that case. If we need to keep this
function here, then this is a legitimate use for "inline".


> I don't see how
> you'd make this a wrapper around __print_symbolic(), since the point is
> to pass in a NFS version-independent constant that the tracepoint class
> can use as a type.
> 
>>
>>>  static __be32
>>>  nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>  	     union nfsd4_op_u *u)
>>> @@ -822,6 +847,10 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>  	__be32 status;
>>>  	dev_t rdev;
>>>  
>>> +	trace_nfsd4_create(rqstp, &cstate->current_fh,
>>> +			   nfs_type_to_vfs_type(create->cr_type),
>>> +			   create->cr_name, create->cr_namelen);
>>> +
>>>  	fh_init(&resfh, NFS4_FHSIZE);
>>>  
>>>  	status = fh_verify(rqstp, &cstate->current_fh, S_IFDIR, NFSD_MAY_NOP);
>>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
>>> index 6dda081eb24c00b834ab0965c3a35a12115bceb7..33d8cbf8785588d38d4ec5efd769c1d1d06c6a91 100644
>>> --- a/fs/nfsd/nfsproc.c
>>> +++ b/fs/nfsd/nfsproc.c
>>> @@ -10,6 +10,7 @@
>>>  #include "cache.h"
>>>  #include "xdr.h"
>>>  #include "vfs.h"
>>> +#include "trace.h"
>>>  
>>>  #define NFSDDBG_FACILITY		NFSDDBG_PROC
>>>  
>>> @@ -292,8 +293,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>>>  	int		hosterr;
>>>  	dev_t		rdev = 0, wanted = new_decode_dev(attr->ia_size);
>>>  
>>> -	dprintk("nfsd: CREATE   %s %.*s\n",
>>> -		SVCFH_fmt(dirfhp), argp->len, argp->name);
>>> +	trace_nfsd_proc_create(rqstp, dirfhp, S_IFREG, argp->name, argp->len);
>>>  
>>>  	/* First verify the parent file handle */
>>>  	resp->status = fh_verify(rqstp, dirfhp, S_IFDIR, NFSD_MAY_EXEC);
>>> @@ -548,7 +548,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
>>>  		.na_iattr	= &argp->attrs,
>>>  	};
>>>  
>>> -	dprintk("nfsd: MKDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
>>> +	trace_nfsd_proc_mkdir(rqstp, &argp->fh, S_IFDIR, argp->name, argp->len);
>>>  
>>>  	if (resp->fh.fh_dentry) {
>>>  		printk(KERN_WARNING
>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>> index 382849d7c321d6ded8213890c2e7075770aa716c..c6aff23a845f06c87e701d57ec577c2c5c5a743c 100644
>>> --- a/fs/nfsd/trace.h
>>> +++ b/fs/nfsd/trace.h
>>> @@ -2391,6 +2391,45 @@ TRACE_EVENT(nfsd_lookup_dentry,
>>>  	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s",
>>>  		  __entry->xid, __entry->fh_hash, __get_str(name))
>>>  );
>>> +
>>> +DECLARE_EVENT_CLASS(nfsd_vfs_create_class,
>>> +	TP_PROTO(struct svc_rqst *rqstp,
>>> +		 struct svc_fh *fhp,
>>> +		 umode_t type,
>>> +		 const char *name,
>>> +		 unsigned int len),
>>> +	TP_ARGS(rqstp, fhp, type, name, len),
>>> +	TP_STRUCT__entry(
>>> +		SVC_RQST_ENDPOINT_FIELDS(rqstp)
>>> +		__field(u32, fh_hash)
>>> +		__field(umode_t, type)
>>> +		__string_len(name, name, len)
>>> +	),
>>> +	TP_fast_assign(
>>> +		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
>>> +		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
>>> +		__entry->type = type;
>>> +		__assign_str(name);
>>> +	),
>>> +	TP_printk("xid=0x%08x fh_hash=0x%08x type=%s name=%s",
>>> +		  __entry->xid, __entry->fh_hash,
>>> +		  show_fs_file_type(__entry->type), __get_str(name))
>>> +);
>>> +
>>> +#define DEFINE_NFSD_VFS_CREATE_EVENT(__name)						\
>>> +	DEFINE_EVENT(nfsd_vfs_create_class, __name,					\
>>> +		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp,		\
>>> +			      umode_t type, const char *name, unsigned int len),	\
>>> +		     TP_ARGS(rqstp, fhp, type, name, len))
>>> +
>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd_proc_create);
>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd_proc_mkdir);
>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_create);
>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_mkdir);
>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_mknod);
>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create);
>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create_file);
>>
>> I think we would be better off with one or two new trace points in
>> nfsd_create() and nfsd_create_setattr() instead of all of these...
>>
>> Unless I've missed what you are trying to observe...?
>>
> 
> I'll look into doing it that way.
> 
>>
>>> +
>>>  #endif /* _NFSD_TRACE_H */
>>>  
>>>  #undef TRACE_INCLUDE_PATH
>>>
>>
>>
> 


-- 
Chuck Lever

