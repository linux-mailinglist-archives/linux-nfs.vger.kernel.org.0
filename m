Return-Path: <linux-nfs+bounces-11567-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7FAAAE240
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC40189A16D
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABC228B7EF;
	Wed,  7 May 2025 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A7kpMt9n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gfk9dCFO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250DB28B7E0
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626307; cv=fail; b=D7KQ4hMVvP1TpDgRkdu6WslCOHknHKTXOmCzn3gz2N7ZqIqT819L1dUmkkKp8gvnxJxJepyGKO+BrbzcDdAoMfasH8+pSxzWwqDZ6ZHki+BIZnx9fASDP42d0Ox4+/sP2VGj81bGJqLjD+QRrck7mh7Kzr8k4EpI4N84xG4y9T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626307; c=relaxed/simple;
	bh=rr0H60r7yhwFa7gfFxCu1TDI1iY/L3bommAenu4Wz8U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=doLYzGjqu9B0sC9S2HnqX1h1zda9Aa/sknJDH5rgl31rMxRDHCWPtHVJK4mxlbHVDf6L7zZAHRdyCm5dLSnG9HOu5+XjdAPFz4LI0iTh+PGa9euZtQOBen+UopAtUb9wsPzXxcpqi+9DqSkM9iwQ7cFKVI60rNxRuJEpSWvsjiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A7kpMt9n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gfk9dCFO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547DqjhA001473;
	Wed, 7 May 2025 13:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uFmiwxSflrWtKZtE6UcjSqXJzI30AtxTN+AVxSQ+bpI=; b=
	A7kpMt9n4bYKyz+k4u1jxFVEvKxjTkhGqZ/FppRXkkwDpGnL6NCy6Oaz2AZOsEPU
	OzhNr+sUAqQKzHPETPsoVuHUtLDOiudosmuwAuLqFEEUkwTlUPKEftzJqYwZ/pV3
	KC3HEt0u9MuDbHHKa4fQx19PKuAOi2MMX4t/YlH/xTRrtU2V91GreFVTCLiYu1QN
	JZJ2/r/cFlo8NskCw2fhOkx4pkaOO+6SlypJNTbF/mDVgcIOB5wCmxY2iDH7agJV
	Sst3Nqu8NfwtvubM365LvJA+wdQJeLBbIYgW5XuEOgmL/CVBszlWkFe+N786Reid
	wsRoRC/f7M/S+oDdZeL7aw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46g8sf00f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 13:58:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547CKm3G035324;
	Wed, 7 May 2025 13:58:11 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011031.outbound.protection.outlook.com [40.93.6.31])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kaf1jw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 13:58:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ch44uxLRdrfehcGQ4MN57o0Kl1FXO4eITIt96wRxbffbA6cKD6QeGjfmx5gF7bxDsl0hbLygg89uIHkLVNgHKfwTy5LhJwMaKhUgurFMzvVSCe7VgZAxgbzGzH+ZeXfROMO50K/3za6ZLlRNbt78kkhsnRzqpWWEO5eDapDq+Ugx+SjOhEc8GNanAM4qhVY+87A88TvudxwaZM3mmIZopuJ0B27/9zubpXAuHk2bRJUeZab9RLUeP7Z0QGC1qKDTYq72Ws2uA8jvVeDR1W8zIFIVsx95Ag2MoAiGEGNbK4aB9YPQLzvX6mwRk1JcOM2NL9JD/8TC6ugLYRf9FShLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFmiwxSflrWtKZtE6UcjSqXJzI30AtxTN+AVxSQ+bpI=;
 b=gf9NtODGLfe7DOBKvEHg6RDHrHHdPEqY4/Y+9KlKgTJGXphDTnX5VMS5ERNSTP3VD6n1CjoCWhPdBOAAt6i3YsPjZj5Z2iS6QHgpaaIPxf8H49Y4IxAUl0xEX18+ibjfUpjlseKUUpxpxHHaxyOvcSOfa2lqdD5ffjxYIANNeRN/phQ0b4wgJD/lDMvHdSkGveofBFspj1gyeEkMMY8Gc4WyEU4dYO59d6E3UygzJQuP/vJbUh9qxKXo0R6DQM7MTJCUUIWdKL879amMGr0Hy59Ll5JSq52Ka4VKMw+MLQOfwz3CvqrHwaVaw/qvgloflFM6/hEoWz02KCpGTkItjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFmiwxSflrWtKZtE6UcjSqXJzI30AtxTN+AVxSQ+bpI=;
 b=Gfk9dCFOmKZU+K27oExyxwqAoH8hDfx3WRmiIltQDyPsoUSHj+O18FuYhXTuykQltyFG3IAQghM7FkgAdiXU+duKnb90kB7J6NvLXNBiHtq/+OngRHmzSPmVCqG6KGZKK1T6sz1isQF2xbmia1DIvlM9KziU7QW98gNMVl4b5TU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7805.namprd10.prod.outlook.com (2603:10b6:610:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 13:58:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 13:58:06 +0000
Message-ID: <7d6c0a09-4588-4ed8-8827-94b3027ed4f7@oracle.com>
Date: Wed, 7 May 2025 09:58:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: remove rq_vec
To: Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
References: <20250507115617.3995150-1-hch@lst.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250507115617.3995150-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:610:60::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d4c502-fcaf-4536-8102-08dd8d6f316f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TS84enpYd2tPZjF1RFNxb2srK25ieUlVMU83QnN2S2JFMm52MmZyRnk1NGNL?=
 =?utf-8?B?WkprV25oZmJNL21JblZ3YmtQcVkvT1B3RGVaQWdyVEFUbmI0YW9sS1NxUHdX?=
 =?utf-8?B?NWlqeklkSkhDdFNTRzBPR3kyaWJoZ0xWNkRZUVEyeStNVmlPYW9Wck5YSDRl?=
 =?utf-8?B?SmxNUkZKaVQ1THpGOVc4M2dJTC9URE9zWFpJRFExTEQrSHJlaFVDeVFZV0U5?=
 =?utf-8?B?cjcrU0J1N0t5UXR0Nnl3eUFoVER1UjFoNlhqYWhtQmlhYnA0eTRzS2J4OXFT?=
 =?utf-8?B?dExaQi9Iak1rUUZ0RHc2cnR6V2N6VWx6d1F0N1l2VFNHMURmSDZmU2wwSDZ5?=
 =?utf-8?B?dXR1blhYUWpISlc3bVRKVGlxY1hvZUdzM3VkMVlKOWhKbTFkeXp4QzdpTUJT?=
 =?utf-8?B?T09SSXhYYUhHUTBNR3hVQjRrd2Q5a1kxd25WQVhXc3pqRmVUN2FpNVY3OEs3?=
 =?utf-8?B?a0RmY05YaFJVUjJTUkV3cml2UzgzSjd5VHRkYXM0YVB4ZTA1QUJiTDhSTnlt?=
 =?utf-8?B?RFVJVU9KN21Da1FKNitpeThjbkg1MDRBZTFzbjlCQ09wV2J3Zk9KNDVnUDhI?=
 =?utf-8?B?Z1p1SnovVVRPMzdaVUZlcFFUQ0VNKzEzMkR3bnFlcjE1MGsvNGttemR6TDJ1?=
 =?utf-8?B?blRTdlRwSkRIbDhmWlNNQ01idHRORDJZaTFMZXNSQlhqRWdqcjBIdG1KN1p2?=
 =?utf-8?B?QWRHWmtTL1BxL1Fwc2VlbzhiVnpCdFhSLzY5Z3FqeXlaekV0VUZjK3V1LzYx?=
 =?utf-8?B?YlhtZnBMVDRBdnZhQ3ZyN3h2TlRFNGlvK1FmNXhTMzFUK3pzd0lvSFZDNFo5?=
 =?utf-8?B?bUxkei91Q3IxeHlkeEFmMVF2aVV3UmNNQ3BEMkl6THlRRkhuZzFwR2VIQnBD?=
 =?utf-8?B?TzQrNEdWTDJMa1d4dnhwNUhUbitzTHpHOTdsVmhQeFR5RDY0d2tTUDJVNVlS?=
 =?utf-8?B?RW5ZTjZORVNhN3loQ2FLVThtSzFJWWVwc05FS2c5QVNrR2xPRVlMWlR6aHJ4?=
 =?utf-8?B?QlMvVi8xY0NQSnl4YUwvbEFGN05EeEIrUEJkeDAwWGp5YzExN1JQak9taXRs?=
 =?utf-8?B?MFN5YnNCWU5OUUxobnEvVzROUHpxN2RMYXY2a1JSeUM5QXc5b21KU1p4UUdO?=
 =?utf-8?B?aE1rYUszVDhVYXBxMHF2YVpBZFViQlBhbW5lSENCUDgzeStxUDNXNW5JeVI0?=
 =?utf-8?B?ZndjaDYwSjFoT3RKWks2ak9XcUtEbEU1R2xaQUIxRTRkN0d6aEtFRmQ2R2I4?=
 =?utf-8?B?SU5LbkFxSWFlaC9KQVRvUlVOK3dYZjZMQmpsN1FwK3hPYU9Udkp3TUtjOTdy?=
 =?utf-8?B?S25iekFHTndITEtLUUpHRXQrUUQrY1k0NUFYUnhid2Nlc0ZzTDdXOUdLT1lj?=
 =?utf-8?B?dEE2T094K3pwSFNqT2d6d0FTQ1A1Z3ZpSk9wN1RQQlBnb3R6M3htTGd5bUcz?=
 =?utf-8?B?MERYWjFJd01SQU9jTFluZ25pa1R4V0pGb1R5anVnbGI5eW5pZzNPN2FMY25q?=
 =?utf-8?B?Rm9Wd05qa1dXSndhRDlvenhBSU9PbEJoRGYzTmR3M3dFdVJkVVlwbHNPbFd6?=
 =?utf-8?B?blJiNWlUTjFsYzNwc1JtWGhRVFdLVnFFSG9rbkdKNWF6Q3dqV0lnNFU4QTJU?=
 =?utf-8?B?ZDZ5WXVlb2lBVVdZcmtscFRqWnhMTFh4Unl0MThRalFESFlLWWpJQlA3UmZW?=
 =?utf-8?B?U1ZOaHhEVmlQZXNOSXpnaVlPaXFydWtETW84M3hXbk5NVE9rU2ZMWGNNRkhp?=
 =?utf-8?B?YnFDeHVpU3pkWUhUM0hCVmZlTmZJcTA3KzNKMzVSUzNuMDcvbC9KODlUb1pG?=
 =?utf-8?B?WVFSTEl6cG82SHFncllCdHpxNHpKZTA5ZURBdGt5N1JmQjFJd215dGh0b2dj?=
 =?utf-8?B?WHBYaXhPenZYZVdkdnVReVgyL0VYMmFJeHE3Z2hrZWFTcFkxUG1weDVxQWJM?=
 =?utf-8?Q?BdQ5k1HSh+o=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bXBuYU1XQ056QkJuYWhmQVBZelB5UUNFYktnVjA0bnp0K253R0gxNnFIdGFO?=
 =?utf-8?B?dmhINkt6U1BOd2pSYWNFaCsvUnZOb1FJc253UHJqZmtIaG1KNnFqejF1ODR4?=
 =?utf-8?B?cDhQYWc5a2p6SnhBUFNVbGIyWnA3cDF2WDZtOTFXbVkwV0FFdGM0ZnJtZnhO?=
 =?utf-8?B?UXlEZjdFZmV5Y2lIZXJCbUNlZk1ZZm5ZQTVUb3p6ZXZtbTk3SkFQbkNvVzlI?=
 =?utf-8?B?Y3F0MXEvcjFmakJZZXJ0R2pRbkl2RXdaQ0U4bVZKNkdKUFRIbTZEVzNOM05U?=
 =?utf-8?B?M0VLOUQvWVdhV3hkU1FZTHhQYnVOM2loK3BvUVllZVZxcFpLV2M3SnNtaEti?=
 =?utf-8?B?eEUwRkJzMkU2TEVEaWV3WTZQaE9lUFRqS1RzU3Ewb3liL2lYdXpzVnFZb3Zh?=
 =?utf-8?B?WmNUU0tnNHRBb3loTEM3T0FGWUFaUW9VMXZQNENJWkhVN2xiaWpBKzc4dmxB?=
 =?utf-8?B?THBZajBGNlNoek8yYUl1L3V5MVUzMGx0em80bXZoc1h1bDBHVFpSb2ZhczlJ?=
 =?utf-8?B?dnlhbkdBelRCemtpZXNOSTBiUmloQ3V1YTlBNytXbkNFWUI5MHJKbzhrMjRk?=
 =?utf-8?B?dTB2N1ZQM2xQWFlyazNlWisrYmQ1ZW95YUNrNjYvOFIvOHY4TmdMYS93MFRF?=
 =?utf-8?B?bk1zb2djSDcyZWRBYUE2N0ZabTN3UzBpYndudklwbFhrUk9OeWE2WE5pZTQw?=
 =?utf-8?B?Z3lSbGtERmlRblFlcm14Q1p1TmRpbXJtZy9STUVpMU91Z1I3UUlYcGovRS9J?=
 =?utf-8?B?dmhQbkRkR0MzL2lXL0FSdFpQSWpIUEd2bC9KMEJGNHROSE85YUcrQ0hOMlcr?=
 =?utf-8?B?WG44b1MrRWtQdDVOQ2RRVE9VVy9qQlprbHBPcExTaUhaVHJVdzF6cVdkYzVa?=
 =?utf-8?B?cGg2aXhQNElZS0lGZEVFUlVmREwzSExaR3FuMnYzNEJIYW1HOGoxNkhoa1Ni?=
 =?utf-8?B?Njk4Qnd3aGpBVitIVjVvNStzZGJqQzF3dGV3TlpzVWdTNGY3bTJmN3F4am9l?=
 =?utf-8?B?bHl4bjhzYkVjMkNpYUk3bFRaWTc4ekZ3SVluZml6ZllKbmdQV2tnMEJBZGRi?=
 =?utf-8?B?WEcycTdZRFhPeExGVkN2TkpYL1hoTFFwOGZockI2UFcyK1FkYmU1Zm5GNEVY?=
 =?utf-8?B?ZExzckR5YkV0WFYvWSs5NGUyR01GZzRJcDd4eUo3WVl2Y21ibjdFUUVZU2dJ?=
 =?utf-8?B?Wk1GZWFDakpsMGV2V25vLy9ldUZsU3NzL3lsTCtXS0UwaGsvRElMVXl1MEQ5?=
 =?utf-8?B?ckFKaTNDdGhYeFg0LzdTbHdFR1hjb3JPQlh4MTFzd0pJZ2RZUWx1NDFjNHRS?=
 =?utf-8?B?TWhqK2JKNXpqU2JYMEh1elVoYzFEcEdWTzhKU21RTm5DbWRHalJTR3l6a2Uz?=
 =?utf-8?B?YXhKR0I2U3g2cjBNZzYvcHlLZlNhTC9CSlZDYUNkb3BVTHhsa1BXQis5UFhx?=
 =?utf-8?B?OGsyNnB3OWp3S1lNcm51cy9IUG5VemhjQTBFQ3lDK2RJNmdTWUhEZ1R3bjNr?=
 =?utf-8?B?enhubzlxZXpSRzlYQlVjZkxLbDJnV1FxaDlQV1ZubVRzMmErOUNIbkphbUp6?=
 =?utf-8?B?RkVxVnpaSkZaTGFmM01zTElJa2F0VXAycEZvbllHOVYzeWpMZmRGTVBEMCs4?=
 =?utf-8?B?ZzBNY0JXK0lMVDJtTXc0L054NEk1M3hBbGpRMG9JdzBRSUU0SHZVQ2lPMzFR?=
 =?utf-8?B?QVY0aHBWMndqd1ZuVUJ6WkJ5V0UxbHNSejRkdDIwdldIdVhrdkEzRDdXcGdo?=
 =?utf-8?B?UGhYd3kxb3g3QkRqQktkYVVYdmlBYTJobHUxQzJOell0Q2ErRmsrSUd2a2Fx?=
 =?utf-8?B?TFdqWFVVWUZTZUNiWGVReUNlYnZUa1d5ZVpycVZ2eXRDNXhNcS9Jcm1Fd1VM?=
 =?utf-8?B?VEk0N0tuUUdDLzY0bmxmMHp5eVFpcTk2a0ZXOVIxNnFVR3V2blVKYlk4bWtO?=
 =?utf-8?B?eTQ4bXUrUGpKSzNuOUVxbWdwTDN2aUxyQlVhaU15OVkrL0g0T2h6NVhwRkow?=
 =?utf-8?B?Y01icC9XSVhyS1V0WHh1dGgweXU0aC9NaFNiektUbDNhUExJRnppL2dnaUNO?=
 =?utf-8?B?ay9WTGhFeVQ0ZzNNaEtmZU5ZYVoybFM1MGc0YmVBTG5WNUlqTnYvTUwwUVVa?=
 =?utf-8?B?QWpXa29QNWlDTDhSYURlM0IxZVZKQ3d1WGViY0dnUzJuV082WXhFcUw2SExD?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hX2np+qSJGl4ySYEK8CX9QUbCkrsqO4ITFrfO4VbTi+PhpsOrI+8HoPXjHqj3KfG7z2Bgf13LpjrvfIIQdGUzNR0FCfiM9AUeceJuO6/CHYCw2NLD+dcIiRXqzv6hY3Wfdw2FMvjKqZfDTlsgPhnPGzec6ukSD6sEd4xncZ25BAp6EQCEC2gidFUpS/GhKwgULSxZjyn1bQpSyXeQozYrcCyZOc+pQeBLIKiQl+ZrbmxYSMbRGATtnkIH4JolXkSO5W/j4P4gxjGi46s/P60queHaafzn9rhXB/NRhTTC+ZdYuEYK/5OcVHmc4GvfR14YdLFpSVjvbrdi/bE8Cu/Javnsp2V7orQbyeWzX16zgmHKo6qTj37c3xtRC3Y9qDI+uomu0JbMRmI821mdXlWr2jZ52Y7Phqtjw/p859FjXhqFB2pR7SShhRMcHYNkNsqlXRRfSBi1YLeFz55PRsT40/reCaJVlrwyAydDybVU6Wv0NPHwCeSTMZxzka8M83tvLf+eRhLkK8VckLsp1F6ocrl3PEWH4E3rsMm8qZRTI8dgVtzj4xZmeYdbTmbAUEEvZiXLQ3iQqr2t9jlPlj/aEA9ePOiD3A+7w642hwquCY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d4c502-fcaf-4536-8102-08dd8d6f316f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 13:58:06.8094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W03NPv2Odaz0PqFx01fbUB1ZQjyQYG9fRDikNXa84sCWlCeAC3EBz2I1Dgj62Z68FJc4BxzZ41OK/Wful7aLTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_04,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=811 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505070131
X-Proofpoint-GUID: -KuAYgElta9XNQkJVko2Tl0pQjUOH3cn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEzMCBTYWx0ZWRfXx/KFfLH/0e/f cuyHG9tyRKGBnlkWxAP8xkwS43THfrEKJNG3ENGCFQraSQGTKD59r65iQ9S3HDtgIsHBcxfSylt JElutk97m6lfSk6fNlhUmZU8UiGAS+fCu3G4RQt306K61ANSrsFsWNj/KlJ9GObnS4g03NozUn7
 n84MADYZwhGCQqo7q6Dz/0ztwsB4Js0KuQod+vjprGD4JtHkvFWwG9u6eG8aBUN8Fy/z5BpK378 2eAiu3SyKdQq5w4s96Yr5Tzg4rkix6X5Ou0xGQPKty5e6+xhXTb3pK8KP4A/hAw3yzWgJDL4B3M dzYk3ntO4kWcuuJg9K1R3PczJ6xwcKaY6K9AOvc4XqTLUiI96bR/Yr8bAidd6SeAdqQYwuuNLL+
 Li8+JBI7NhNnmVRfrIOR+iRAzCs3luax7/DvzT1Mc0ZsVxUqvq1frWeA8GoBlB3UY8yhJyKD
X-Proofpoint-ORIG-GUID: -KuAYgElta9XNQkJVko2Tl0pQjUOH3cn
X-Authority-Analysis: v=2.4 cv=Pen/hjhd c=1 sm=1 tr=0 ts=681b66f3 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=_0hK9XvqEkH3o8SgxPoA:9 a=QEXdDO2ut3YA:10

On 5/7/25 7:55 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series remove the rq_vec field from the svc_rqst structure and
> always uses the bvec array for VFS operations.
> 
> It doesn't integrate the bvec arrays used by the socket transport and
> those of the VFS layer in nfsd yet, but it is a step toward that.
> 
> Diffstat:
>  fs/nfsd/nfs3proc.c         |    5 ----
>  fs/nfsd/nfs4proc.c         |    7 ------
>  fs/nfsd/nfsproc.c          |    7 +-----
>  fs/nfsd/vfs.c              |   49 ++++++++++++++++++++++++++++-----------------
>  fs/nfsd/vfs.h              |    4 +--
>  include/linux/sunrpc/svc.h |    3 --
>  net/sunrpc/svc.c           |   40 ------------------------------------
>  7 files changed, 37 insertions(+), 78 deletions(-)

I already have patches to do this in test.


-- 
Chuck Lever

