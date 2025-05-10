Return-Path: <linux-nfs+bounces-11653-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB51AB251D
	for <lists+linux-nfs@lfdr.de>; Sat, 10 May 2025 21:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C651017E441
	for <lists+linux-nfs@lfdr.de>; Sat, 10 May 2025 19:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6701C3C08;
	Sat, 10 May 2025 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JscbOH9s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K4g3DLGh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE031428E7
	for <linux-nfs@vger.kernel.org>; Sat, 10 May 2025 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746905031; cv=fail; b=Wcn+LvTkvS4mcyVN9snvgbDqZam9KDaeTzCv4eHs8unxFvm16QarhWqko7ucY7h8eo/z9D8RbxTSuMd9XTDPdlT8S5V/hW+5BiL35YpfMJaifXJGvK4ijSLf3ukV28YL1NU9/+dLrYJucB7tbkux4Z2rt/INTERYJ9q8Q+yJJc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746905031; c=relaxed/simple;
	bh=0kHU3DUPy5FDRR3Mh+0Y6bR66lp5gKnO0Q4jdRWKBnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VuPsQxlgM5pe9Yxd/UBNYglAVyHSQ97jjWgTc34plL+32HTIRbtmjzXbSjpGJQXld3YONANu1Qf00wWkKZaaRYf1/v1C2/u3+/dlDpuBlBy7bmK+WWsX93Ct6vyl3dlScW3Doo7EDfK2VUC2jXPgm20kx4qiITNFJvPmXrG07fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JscbOH9s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K4g3DLGh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54AHaQRW024384;
	Sat, 10 May 2025 19:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JckoP6GCpMdTLUEX8ao+MglQV4TKI/a8RvI3Cw2C2S4=; b=
	JscbOH9sems5zHsgk6tcwo4JZkgQ+1x4ISibIjfoEJp3O/M8cCo4t4qBRwuTkG4K
	F4Ui7Cf3U8ZbkYeXMW4zfRomD2zrt0SUBgTvtFHseVnaiIu1+uPxtQEBL4aJ4uFi
	KP1tYAOBas/9uL3nm82Q17I8y/IHMh2mO8OsI+LBonyKzbwV7DKHYCJ8rH+yEMnm
	grNXk7oYJQmLYhPOMyrc1FTpKUmzqVsAjwSUToXFsbHtS2UqmtniIdeBrmI8a9GT
	mffqFvytqQuWjQIF2aqG1jeW8xZGJy21eQT4XFbdVmk4Rk+CHUkoey1NwpnP32zP
	RecFhYIe4l8VznZaYrAdoQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0gwge0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 May 2025 19:23:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54AGBwDQ037380;
	Sat, 10 May 2025 19:23:32 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010006.outbound.protection.outlook.com [40.93.11.6])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw865108-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 May 2025 19:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNDR2Rnzx50OrhbVB6rDx7vjji8aiOSlilIy0wliwwcFYM1yreGOrg5VxQGIqh+mO1b517QVCcvVg6S6BXgyvXVhOWo8VRsp4hI/kJ3fGu4GU45RZsmZToLPi1gzw8m362pjP+4BGU9kWdG9n3hDRN/d6P8COIsc4azHj1gZScO0wToBFoRgUChv49AlxTlIyx7JakU8+32eMWj2PKjIVMBKBw4FAK6BXYiVbo7NGkEv7r/2FzCiiBAao1XQS4O5jq66+RFwpviuZpygYOW5U4pfXVOv9g2VzJHabO28qCuDS3k1+4rwcb9pyqlRWx28DSArtrDLVS8R3x3ljr0yVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JckoP6GCpMdTLUEX8ao+MglQV4TKI/a8RvI3Cw2C2S4=;
 b=TWdVEANSWf7DYBzSPQpD7La0uerL3WKjm75UGKjF2fQex9T+3yLhicu3LCl/2IPp4urjRFCmdIMvNOJWHr2hnBhEw5/6hAvWbPWlSEs66Cw0dg9AoF1HhHYafjeUeWABYq8CwhlOy9BsXH1tCS/8OecXGeO8kE8QzOtrK6U8TEKFY3QNWgE4aYxEnw7n3qTMdE+5agGmVo5ha8TwY3i1BBHzfiKtoAkte1B0J2c6VrmveF67rQCYHDhGir+qPdxRGO63ushK8tTm3UXhMF9C1rOLsYv1ZaGREf+N4MucG6veT0w+EfTj4a+IwrVQoU0LR16p3DcNYwVlLkNhfSdn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JckoP6GCpMdTLUEX8ao+MglQV4TKI/a8RvI3Cw2C2S4=;
 b=K4g3DLGhd18/IjH2ZKPi25/r6fW5BPdvoIi7qqmxa/AH1BXk6kiVJwTJoW/0MLJ/Srl0nwhKLD3g+lYL0OkuLz4wExNpT+i+h3Dc/r4XZLQIuM5nnp4SNJG9k79IU1S3YsYGNEFHdZe5Tai+8pdiZuQhooAK1RX+xwlPndK0GBg=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM6PR10MB4361.namprd10.prod.outlook.com (2603:10b6:5:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.22; Sat, 10 May
 2025 19:23:28 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.8722.024; Sat, 10 May 2025
 19:23:26 +0000
Message-ID: <2f2babf7-7d70-4c81-995a-1a671590b08f@oracle.com>
Date: Sat, 10 May 2025 12:23:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 1/1] NFSD: Offer write delegation for OPEN with
 OPEN4_SHARE_ACCESS_WRITE
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1741289493-15305-1-git-send-email-dai.ngo@oracle.com>
 <1741289493-15305-2-git-send-email-dai.ngo@oracle.com>
 <ac9d076fb33f7ad5d536ac593a2eb6afd09015b0.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ac9d076fb33f7ad5d536ac593a2eb6afd09015b0.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM6PR10MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb4413d-d0c8-420c-a29b-08dd8ff82373
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TURST2s3cjhGMGE1RGpHc0xNVEczSXRidHgxK21nNHhKL0tvZlV2U3RWRW9V?=
 =?utf-8?B?a3RCME5LVy9iVjdqdHlnRGNoaWgyL3U3UG84R1BrZVM4OVVzOXNEdFhYYzBP?=
 =?utf-8?B?eGQzVW1EUWVqc09JSFlSVTlJRVNNK1hrK2RVS2s4Zmo0ZXBqeWNOdFZadENh?=
 =?utf-8?B?T3ZERVVRcHAwZlRSNTJmc0JpUkhUVittelUwVmg1ZnNmNkZwd2RMOG42d2VH?=
 =?utf-8?B?QzY5b3ZGVlJFbGxpWGh3cEpIOCtqUGZBSnBFendhQkZBc1AvUVF4aHFUQW9F?=
 =?utf-8?B?WFROWWpoUVVaNUp1R2xaS2p3djg2THViNmxtb045V211T2ZUZHdxaFlPdVhs?=
 =?utf-8?B?UFJCak9XS0t6NnY1dGIzTDhjdnFwRnZ6Ni9OdkVqRHJjOERtV1ZUTGVucXNz?=
 =?utf-8?B?dmdLOGJLWmh1MXBhdExqWDk1K2plcVgvZERGczVDQnlUdURmWTZ6QUNQN2V4?=
 =?utf-8?B?aVRaQWFYbkV3dndacHpCdXB1NEdGNFB1Z2dBbVBpRHlzVUcvKzVEWE1RVll0?=
 =?utf-8?B?SHZwTGFwYzFTaXNHam9OQlVDQUNWRzFNc204N2VJR21TazNNbVFWdWJTSUVq?=
 =?utf-8?B?RHVrZ3VqT2Q0ZytuOTVvaitPOUR6UmV6QlZTbm9IVmNvRzRabHpsUWRhMkI5?=
 =?utf-8?B?UEEyMS92OWFzZGpsOXlBRCtXS2toVHlzWC93L00rbkIxNWY3bFdZWFBJYklQ?=
 =?utf-8?B?MjU0TnhKU2MrYUtDUnlUemJMT3JjU282bHdPMzEzZHFZSnFtQ3g1elQvVmpG?=
 =?utf-8?B?eGVGMGlxUVVZRDlWMmJQZzdOVGxKRHhYQmRIZUNoK3BZN2ZaMnJSYjZCUjRq?=
 =?utf-8?B?SWhQUUJQRjh3SHlJYXhXLzdyL2lxTjVWVlFlbXhnMU42T0xIRS81Vm83NDhX?=
 =?utf-8?B?bEErdkt3TFhHdW45b1J5UVpnWDVnQkdad3NUL2NxUFZFRFd6ZUVpeDdVcXA2?=
 =?utf-8?B?NEd2Tk5KWmtKZzgyem5Ic1Z1aHIxbDZEUllCeG4yWVg2STVSY202YkpMc2dM?=
 =?utf-8?B?Y053OHE1UGxka2xhVDRYU1BRR3MyeTJPSitheU5TbkpPYi9IQmhJR3pIS2RJ?=
 =?utf-8?B?YnROZ3FkaTlJQTFrTlorb3F6T0VPNW05WTZ2a05DQ2laUnZBYUdsYXZDT1dH?=
 =?utf-8?B?bDFDZlZ6NEdGMkh4UUlYUnh4Wm1JNjNYMXdBYmZQb3JzUFJTaVFrZ1RWcEhI?=
 =?utf-8?B?OEFncXpBVGtkWDBUVkhudDVUK2trWFJ6dEpUdmp1UGZNMjQvdmc4bFRRNmhN?=
 =?utf-8?B?WXUzVDJUTGs1eDhsZ0lDVm9IZFZaSVoyYTVIdGpIcGJkc2VaZ09JSjROYlFZ?=
 =?utf-8?B?WDdqTW9WUW9qN09pS3hFS1ZHZ0RSMzNhK2ZReGNheXg0bjNtZkQrMHkrNlc5?=
 =?utf-8?B?UXU4OXdjK0M2TXdBOVRaWU1OOXhjZElTZm10TjAremVHMlc4dVoySEt1aGg0?=
 =?utf-8?B?OUZxeTl4N0swb21Od3UycUhOa2RFRXlrT215VXBQR1VRRXc3WW1RTHRwR1Zk?=
 =?utf-8?B?QW1FNmR2dUJYemYzVFpNS3gwQzdSdFgxeHdkMzlZOTRMQnpLQk5SVU5PVFlp?=
 =?utf-8?B?anFJNlFqT3pISVIxTjFFdGJDK3lmZHpUYmtJWGF1ZUYvbmdiUXBZWUhqZmJi?=
 =?utf-8?B?M3M5QjJXSXVxV2xiTmNWd2Q5alEzYS84NTRuNnlid0NTV1M3YW1rb09lMjdp?=
 =?utf-8?B?ZCtvZmxjVENDS2pPdWMwa3llU2w2QWZsYzc3bXQxUEVKU0FOZzdxYW1wYlFP?=
 =?utf-8?B?NDhqTytlS2hnTzlqd0t4cURJaThRWTA1NURiOENCVDkxbWZKTlNtbDVVZEIw?=
 =?utf-8?B?aHFCY05wejBKMEtNOEEvMjUvTGppN2VMQ3BiWU5GamRROFRtVHgwYUhWODdq?=
 =?utf-8?B?SjFBeDIvZGtHVUN5TzhIdGJndVZ0YkgyMDFGdmpmSUVFTEFlQmYxYW5XdUVI?=
 =?utf-8?Q?+Hk2SvQa4K0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TW9nSVNkd0RjbzFuby9XbjJEVmxYRVg1WVRWTy9DYUorYWNTSHRXTnZ3UmZU?=
 =?utf-8?B?WXJ1Z0p0bFFkUFAzdHpXWFEyM3ZOa0RRaVRXeHdqY2FnRVNmNEZrY2xLeG03?=
 =?utf-8?B?Q2pYNFVDOTE2Tk1yVk5DZjFueTQxMkgwSXFpUlJlNEJHWDE4d3pZdDAwdUlX?=
 =?utf-8?B?YmVmYXBzb0pNOEViN1N4RFcvcThuN3BPNnNXZHN6SFdxdE9MUFFINlZCRllL?=
 =?utf-8?B?UFFJcUI0YzNYU3VJSWFWZGIyYWwxL3pVL2Y4dm9oOUh1c01TREZ6MHBVVXk0?=
 =?utf-8?B?eldmeHIybXQ0SVhwMUxuOUgwdG5vWFZQbzd5SERZbERERmVsRVlxZnhRWjZU?=
 =?utf-8?B?UmRVMnZzc3lGaUJRajFXUVdOQml5S29JZGV3OHZralBTdGNPYkxpNm9uS0wz?=
 =?utf-8?B?WWdySXQ2SW9TN2oyNEkyaExUdmI0aEdRaFF4R1F3STA4NTBCekhOMWZmTlZx?=
 =?utf-8?B?bVRqQ1JML2Judjdoc1g1U1BlL3lUVFg4Z1BDMXJBYnhQMkdDVjFFRGthSytG?=
 =?utf-8?B?MnVrbER2aFJ0a2RPdXVkSVV3NXA4TlNQcHFEM0Fmcjg5dGRtV0Z4MCtuUTNi?=
 =?utf-8?B?SUY1eUU0ckcrS0o3QlRzRUdZSDM3YjFHNm52TzVkNzl5ZkFQeGxRNkVEclZo?=
 =?utf-8?B?cDVEUFBaWVlzdWNLMy9qZWxMKzdUQmhnVXNYdndIL2NTZDdoNkFHT0xPTXl4?=
 =?utf-8?B?aUNNZ0J3MitzVkF4cWUwL3ZEMWRReFMwYWtUckdTZnByMmZtOFk1TG5kaUM5?=
 =?utf-8?B?NE96Q3JBbXB1K1NPNjNpWCtaYk1kaTlRd1ZIWXhtR0QwYXRGYldjZlIvWHpl?=
 =?utf-8?B?WVRYdFplVDQzWGd6VGlLZnk4T3VXS2JQUVZHcWd2Sjl4R3MxVW1CenllblF0?=
 =?utf-8?B?QWMvN1ZZTktuakF0V0I3Ly8yR3dPMDhWNDhNV0FnazZCRW4yTWhsTjNYNzlv?=
 =?utf-8?B?eWhiN2ZvaFp2WWhScERrdGhDTWtuN0V5QndWYTA1Rzk5THNsdDE4YWZtOGhJ?=
 =?utf-8?B?Q0w5K1hCNVNMMGlmSThwSm4rZUZPY1U2OWZsQjY1N0VwR2hYWUlhbDVUUUNT?=
 =?utf-8?B?NDNWQ0JPVUNJcENMd3ZoTkVHckNBZjBBVyt4bDFQd3ZVUllXZXpzYU8xVWxq?=
 =?utf-8?B?RTVHNE52eVJtTmFOZDF5aUV4emhVcXZYRlFLYjlRVHlnd1BkWDljVlNvNzNt?=
 =?utf-8?B?SDlFakVOa3Z3MUVWN256bjl4aW0xQWlqeWh5ZXJzZWVzcEJTOFNMZFJoSTk3?=
 =?utf-8?B?Z294Rllob2ZUeEFxZHo5L2tiejZGOWFLYU1uZENGWTBIVTU1bXJ6cUdsWTdS?=
 =?utf-8?B?angwVkUrSzNlTmprZzU5bTNoSUxuYXpVUWs1ci9vYUhGYmh5cVJqTWN2cy9L?=
 =?utf-8?B?OGtOTjZta0NzMHQ1ajNpSkNXM0VDb1A3SlAxNk5FaUxvZjBsK1k1RnIwT3Rj?=
 =?utf-8?B?WVhNdTlGM1k2bTFmZHhsa1FVQUpvQU0rejZvSGgycXNaZmVHT2dLV2xTQW9r?=
 =?utf-8?B?U2RGQ0c3K1I1QlNxSkxTY1hJeTcxN0cwQmd2QzcwV2lEMnVOT3VkR3ZVVlBV?=
 =?utf-8?B?elNXSXZsK2k0bU5NZkdidjlxK1dpVHlFOWY1bE5kcUM3RjFtSzBEaDFsamdy?=
 =?utf-8?B?d3ZZTGdFZlBIclhSTFYrYjc4TFgyVHl1SVN1bTZQOHUzMGI0QU5pMVowQXFL?=
 =?utf-8?B?NlFHWlV1RmZjQlFkRHZLRld5MWRmemdvS0hEUEpyL0EyUnpqN2pVbkpndlFz?=
 =?utf-8?B?L0hpRVNBWTFwNitva1JtQzRTUExYckR1OHpBbll4czltODFyQ2hpZzYwMlAz?=
 =?utf-8?B?ZUE3TjljNzVreXJQS2M2YUd6YUR6a1hQa2VuTlB5aHREZEkvUDZ1OWNMdytt?=
 =?utf-8?B?TzhjK1NvMVc2ZFY5Tm15MlBWMkZCOGZBcVJtNVFsaGhxRnptVGJRcXZLbmZR?=
 =?utf-8?B?STVWaWhEUXJYa1duTFlqT2ZFYTdVSVY2aGR2bU1hdm9naGZiQ3poazNGeFIx?=
 =?utf-8?B?R2xYbGtwd1hYRDRhRldBTG42b3prdEVlWFcrRzgxU2RSWndlc2puMWlTR1o4?=
 =?utf-8?B?akJVSjB0eEw3RzNKa3hDczYzZVRSd2NYTFczV1Q4TlVxV2VEUjZoM1Nkelht?=
 =?utf-8?B?VVpsMFZjaTBZYjZrVGJpRVJkZE1mUis3eDc3bDdxbUZMUFMxc1BTSGw1RDY1?=
 =?utf-8?Q?PIQ6Q/h13YypjiKqZ8lu2bdUQm1VdmJtiQh0QgZj9b9D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KJBnpZ+rofapuvRNo1d0Es0pVJyI0b48NGQnYx8pU3y76FBUinBt7bIvfMz6/5369b8bfzzG4TkYWhrn3+KXBlv819+W9eH20xH5RkrJSD0OVAIto+CQIcdJZI6jIX1jNWnHecLp1FvF36rNePy2KxWAUdoixXUV7cP7NrIHJCg1Q9gItOmDye3ZTnYh0GUc8tW13p7++BYEph4PYYoYeLvabU4r1mMOvAPn3dzgwWUMrxShzwCvSkvBi+2KNlgG3bZlxdBHcuuuA8RPCUxLwd/qV3q0wHPsVgBcWEEZgB5WvKz25aZQC3JOKbZmvN7zC3rU667tvNcLK/kmqhlJbik/8qZANebVbdbpPiDYod9HkvLv7c66BYjXy5/kAC0N3VoB9QwUC12nJwRf23XYXRJccKodQK/2k2ggOsTa8Y/LNY7dkeT8vt1TW1oygKP4Bn8N3sLNyzRf13H+ZOkkMnNpfqc+K/TNtryn8yPOObrL18J6PVw3LcYNcczy8UGNw5/7izIbFOaM10jKnEqZC7u+CxC38Zszqo4MhEEnz9O/gbd8bGjmaSIMXfLkdofc6/H6aimsNA2O5StbzkiNwgz+HBb4WUWe/cO/mXdfOyE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb4413d-d0c8-420c-a29b-08dd8ff82373
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2025 19:23:26.7269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: un+axPKe2AsQMKSxbT8FcKD3pyYYHiouFGYYrEJUVB8ytn2HS28bRMOip2F40vv8OlRndyHHUKI4tKp7Rs4kZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-10_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505100200
X-Authority-Analysis: v=2.4 cv=M8hNKzws c=1 sm=1 tr=0 ts=681fa7b5 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=Jimbt-Yi6WeFDXW9ZTAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5TtOBqczQjReSizUB5y8Net0FKXbDVs0
X-Proofpoint-ORIG-GUID: 5TtOBqczQjReSizUB5y8Net0FKXbDVs0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEwMDIwMCBTYWx0ZWRfX1Bt0p3PKuw7Y ct3OhSW6ZoZ+AodJW1Iccv8Fg6AwT3/CUzI7/dOL/+DXhaixWvRnUDXHdxblwrsh8Bl8Y/HGEke QOIAzCzF/DCnCegFH1HcYBuqgdFaHJdjLJM8UfCY6AG1uPQTcNlU5j6+K4D+GZlvl+FjHa6OjTU
 V3iFSeSbnz9GUdeDj697k7aKLDmJ60KIpmfZLCGc14JiSmWNsI6uA5HZrFMoPTxbIhckrkbZEha FzgkbA6oqJbNKslcC6vUsGONbPyCQlGR0msUpaxAIbbzbt1N80oKTEB3IWrSjqpT5BqPl/k2Ms+ JPwN20Uin9T+B9wb6VKEethNcpcFZJMKADGfMVcwsD2xN6vjLz2iyaw5vo9UYaOzX8stBqZvuOS
 wr9q8xhpyz0hUa/ADBKxMd8TC6KKFVoAyoTo8Yrp5QSouKK2KRanjVfSfnsEr2+fhB0GPWLG


On 5/9/25 12:32 PM, Jeff Layton wrote:
> On Thu, 2025-03-06 at 11:31 -0800, Dai Ngo wrote:
>> RFC8881, section 9.1.2 says:
>>
>>    "In the case of READ, the server may perform the corresponding
>>     check on the access mode, or it may choose to allow READ for
>>     OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>>     implementation may unavoidably do reads (e.g., due to buffer cache
>>     constraints)."
>>
>> and in section 10.4.1:
>>     "Similarly, when closing a file opened for OPEN4_SHARE_ACCESS_WRITE/
>>     OPEN4_SHARE_ACCESS_BOTH and if an OPEN_DELEGATE_WRITE delegation
>>     is in effect"
>>
>> This patch allow READ using write delegation stateid granted on OPENs
>> with OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>> implementation may unavoidably do (e.g., due to buffer cache
>> constraints).
>>
>> For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_WRITE
>> a new nfsd_file and a struct file are allocated to use for reads.
>> The nfsd_file is freed when the file is closed by release_all_access.
>>
>> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>   fs/nfsd/nfs4state.c | 75 ++++++++++++++++++++++++++++-----------------
>>   1 file changed, 47 insertions(+), 28 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 0f97f2c62b3a..295415fda985 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -633,18 +633,6 @@ find_readable_file(struct nfs4_file *f)
>>   	return ret;
>>   }
>>   
>> -static struct nfsd_file *
>> -find_rw_file(struct nfs4_file *f)
>> -{
>> -	struct nfsd_file *ret;
>> -
>> -	spin_lock(&f->fi_lock);
>> -	ret = nfsd_file_get(f->fi_fds[O_RDWR]);
>> -	spin_unlock(&f->fi_lock);
>> -
>> -	return ret;
>> -}
>> -
>>   struct nfsd_file *
>>   find_any_file(struct nfs4_file *f)
>>   {
>> @@ -5987,14 +5975,19 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   	 *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>>   	 *   on its own, all opens."
>>   	 *
>> -	 * Furthermore the client can use a write delegation for most READ
>> -	 * operations as well, so we require a O_RDWR file here.
>> +	 * Furthermore, section 9.1.2 says:
>> +	 *
>> +	 *  "In the case of READ, the server may perform the corresponding
>> +	 *  check on the access mode, or it may choose to allow READ for
>> +	 *  OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>> +	 *  implementation may unavoidably do reads (e.g., due to buffer
>> +	 *  cache constraints)."
>>   	 *
>> -	 * Offer a write delegation in the case of a BOTH open, and ensure
>> -	 * we get the O_RDWR descriptor.
>> +	 *  We choose to offer a write delegation for OPEN with the
>> +	 *  OPEN4_SHARE_ACCESS_WRITE access mode to accommodate such clients.
>>   	 */
>> -	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
>> -		nf = find_rw_file(fp);
>> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>> +		nf = find_writeable_file(fp);
>>   		dl_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG : OPEN_DELEGATE_WRITE;
>>   	}
>>   
>> @@ -6116,7 +6109,7 @@ static bool
>>   nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>   		     struct kstat *stat)
>>   {
>> -	struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);
>> +	struct nfsd_file *nf = find_writeable_file(dp->dl_stid.sc_file);
>>   	struct path path;
>>   	int rc;
>>   
>> @@ -6134,6 +6127,33 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>   	return rc == 0;
>>   }
>>   
>> +/*
>> + * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on OPEN
>> + * with NFS4_SHARE_ACCESS_WRITE by allocating separate nfsd_file and
>> + * struct file to be used for read with delegation stateid.
>> + *
>> + */
>> +static bool
>> +nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct nfsd4_open *open,
>> +			      struct svc_fh *fh, struct nfs4_ol_stateid *stp)
>> +{
>> +	struct nfs4_file *fp;
>> +	struct nfsd_file *nf = NULL;
>> +
>> +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>> +			NFS4_SHARE_ACCESS_WRITE) {
>> +		if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ, NULL, &nf))
>> +			return (false);
>> +		fp = stp->st_stid.sc_file;
>> +		spin_lock(&fp->fi_lock);
>> +		__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
>> +		fp = stp->st_stid.sc_file;
>> +		fp->fi_fds[O_RDONLY] = nf;
>> +		spin_unlock(&fp->fi_lock);
>> +	}
>> +	return true;
>> +}
>> +
>>   /*
>>    * The Linux NFS server does not offer write delegations to NFSv4.0
>>    * clients in order to avoid conflicts between write delegations and
>> @@ -6159,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>    * open or lock state.
>>    */
>>   static void
>> -nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>> -		     struct svc_fh *currentfh)
>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
>> +		     struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
>> +		     struct svc_fh *fh)
>>   {
>>   	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
>>   	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
>> @@ -6205,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
>>   
>>   	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>> -		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
>> +		if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) ||
>> +				!nfs4_delegation_stat(dp, currentfh, &stat)) {
>>   			nfs4_put_stid(&dp->dl_stid);
>>   			destroy_delegation(dp);
>>   			goto out_no_deleg;
>> @@ -6361,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>   	* Attempt to hand out a delegation. No error return, because the
>>   	* OPEN succeeds even if we fail.
>>   	*/
>> -	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
>> +	nfs4_open_delegation(rqstp, open, stp,
>> +		&resp->cstate.current_fh, current_fh);
>>   
>>   	/*
>>   	 * If there is an existing open stateid, it must be updated and
>> @@ -7063,7 +7086,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>>   		return_revoked = true;
>>   	if (typemask & SC_TYPE_DELEG)
>>   		/* Always allow REVOKED for DELEG so we can
>> -		 * retturn the appropriate error.
>> +		 * return the appropriate error.
>>   		 */
>>   		statusmask |= SC_STATUS_REVOKED;
>>   
>> @@ -7106,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>>   
>>   	switch (s->sc_type) {
>>   	case SC_TYPE_DELEG:
>> -		spin_lock(&s->sc_file->fi_lock);
>> -		ret = nfsd_file_get(s->sc_file->fi_deleg_file);
>> -		spin_unlock(&s->sc_file->fi_lock);
>> -		break;
>>   	case SC_TYPE_OPEN:
>>   	case SC_TYPE_LOCK:
>>   		if (flags & RD_STATE)
> I'm seeing a nfsd_file leak in chuck's nfsd-next tree and a bisect
> landed on this patch. The reproducer is:
>
> 1/ set up an exported fs on a server (I used xfs, but it probably
> doesn't matter).
>
> 2/ mount up the export on a client using v4.2
>
> 3/ Run this fio script in the directory:
>
> ----------------8<---------------------
> [global]
> name=fio-seq-write
> filename=fio-seq-write
> rw=write
> bs=1M
> direct=0
> numjobs=1
> time_based
> runtime=60
>
> [file1]
> size=50G
> ioengine=io_uring
> iodepth=16
> ----------------8<---------------------
>
> When it completes, shut down the nfs server. You'll see warnings like
> this:
>
>      BUG nfsd_file (Tainted: G    B   W          ): Objects remaining on __kmem_cache_shutdown()
>
> Dai, can you take a look?

Will do,

Thanks,

-Dai

>
> Thanks,

