Return-Path: <linux-nfs+bounces-16397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 670EEC5D8D4
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 15:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 296D0363A93
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7913C31B100;
	Fri, 14 Nov 2025 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VckZCOhw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="az/S/JXN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79FF30E854;
	Fri, 14 Nov 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129689; cv=fail; b=OS+Ca4Bo6DObgOPI4hJheGtYT4LoFqzNKBmt6NwqLTnTjNpMWCTuDfqsBi6t3jR+me8EPWw3q++yE+kxU7P6AHnb5EQ+JPr6DoLGKzmeAf9PjxDKQk9KiXfQyU5IDx38GNusEqM4pL/Io8rkeBPYU34s93+memGL8UmXcmUJtUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129689; c=relaxed/simple;
	bh=fLk2XHQsxUQCEjqt+QCDHwPpz4Wr0VZqJ/BHX4o0KOs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JiXLvELYb1JZgdUeW+LIOpuvqNXlv4M/dRm3EGPmrAEkIFIKC0j6EBBPUmg2eZYENVWo5GYMfsmDYN8EfBUxcvgx2JpJzUZRDbsKUC7I3cUh9d82GcjDjAVjUPIotqDLI+B5HmFkwhz4B4Ekn2jWnFOb1rRs8kYcv9uTTzT+3RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VckZCOhw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=az/S/JXN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECuT1U018333;
	Fri, 14 Nov 2025 14:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MaZfqdw0glTGMNAAu0l402AnRfLm5bYtWWjcQAsWb7w=; b=
	VckZCOhwAFYAn6+bYHtJdXwAqShoSYXQbbaUcQ+IM20WE6l9EoJa8YrxVb9r0CoM
	p6+sgzOSjszPTh9KG/DxC713Y945zIVL1rDVIvpjyMg7o9OU03Dpv8LvLcSdSEr+
	qOrTukxrf8/ttVIJQ/b3orhz4+tNj74tz4CVXXj57TbHpvvczCvn8Cq5A/n0ZONy
	8ITat+0nCrmW3nI02YLmoDBr3C/+JTXCNZ9aM76N4wgzNBJB15kgCkSPxc2XoE7y
	Fmbou7EZlVBfTK1cLOGWAHaC2Q/g5HPA8QPQvBxyPQ/bLjEkRtKR0f2l0MenItlR
	ruC9PDt3yyPRzyYEUueH2A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8ss7nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 14:14:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECf39q038510;
	Fri, 14 Nov 2025 14:14:22 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vadje98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 14:14:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/kENu5G7r4rDmlcGcBlgp+BfOYhMva52zLAFX6ygVE48Z8fo55Z1TglT40hqxClPcMG88tGv88HRYtBmg0uZKiBIeVOeON717i5ZPPIQ1ua0IRxqgksBcb9l64fkGY6bhD8eLczYZ1FMVxbmlOAOss5qnnU4B77YgR/06IW92QVskyb0bHtVC4QKytkk/8Ur/pkQk4T/2U+dN4vKSDWL10WD9++vgIKbLjHdOCEJxLYbOg++f2a3xXjTYZ6F+6BOtcs/kWprvXfDc9zbYgg6oeifJr1Oaven1xg/RxNfDq/8cDUfOtQifhviWjglgAqO4NExxt3poyYXa48BaT7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaZfqdw0glTGMNAAu0l402AnRfLm5bYtWWjcQAsWb7w=;
 b=nf6ZmPt6oUgwsQ+/1QHD8AfP4E4C8PuNn8j3BYdV5Lnd/FzK0uxB2rRfhLVkX93d6H2l4OnupSXkvdFqvUSyZINCWziS0JOolZX9YqYIXWyAErNucROPYAZJ+o5u5jyHwNoBQJzbpOJxdRRV7O0AE1gFyXNmY6nC3oUXjf8QwI0PgQ0VH0lebqBCZc4Uur4f7hfbY15iN1mDUevO24z03mokFkuBZuHGMW59UoOonlM5FLa+ACmH2c0H26z3slUII96ESR2X5WEFXgagfqjNR+BMVfhwFI1Ad4obL+tfh6pFH0yl5rhvF1QfZwErPhYOH2AaWkTohCA5PoyB8h5S8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaZfqdw0glTGMNAAu0l402AnRfLm5bYtWWjcQAsWb7w=;
 b=az/S/JXN7ICKs+604YTcdxd7fKExKAlO+4osqiNu2u43l+GiRmxnrgsY32NgCGpIvViX/q4+2tHor83r78MdZbN9ZrYBkw+qjvPL2jtQlrGh8B5k4+6VtjpPRlP3r6K1dZuCNB3x7U8ULP+UA3T8a2bI1r6+4o9PnTfhNVler4M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7770.namprd10.prod.outlook.com (2603:10b6:408:1bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 14:14:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Fri, 14 Nov 2025
 14:14:16 +0000
Message-ID: <1cc19e43-26b4-4c38-975e-ab29e0e52168@oracle.com>
Date: Fri, 14 Nov 2025 09:14:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] net/handshake: Define handshake_sk_destruct_req
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
 <13cf56a7-31fa-4903-9bc2-54f894fdc5ed@oracle.com>
 <CAKmqyKObzFKHoW3_wry6=8GuDBdJiKQPE6LWPOUHebwGOH2PJA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAKmqyKObzFKHoW3_wry6=8GuDBdJiKQPE6LWPOUHebwGOH2PJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0437.namprd03.prod.outlook.com
 (2603:10b6:610:10e::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d841d6b-2be7-4fcc-04cf-08de23881883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b25RaFd0ZGw2U0JranVwV1VSOW45akV6ajRxYmJnalpTNXphWGx4MGZjL0R0?=
 =?utf-8?B?ZGI3VFk4MVlQcWp6MnBURFhXU0ZLWEdmSThOQkRpellYQnNTSkVBUE1LTG1U?=
 =?utf-8?B?WlV1dUxEUHVKblRDV1lRaHNWV2JpQnFPVXBKc0RNZmMxelNlSmF6YTAxb2Rn?=
 =?utf-8?B?OW1zRUNWV3MwTGlKQjI2NURMY29iZEs2cHpnVzFQcVhMcGVrWm9BQTZMMzFl?=
 =?utf-8?B?VllqNDBhTW1pVklNdGM2QWZLNjJ5T3RhK0tjR2c3WWxEMi9qZ285SU9jaXBo?=
 =?utf-8?B?aFp1MmJGWlp4VThYek12R1ZIeWtKRUV5K0c0SERhUVdYRE1wYWRWQVZBY0JJ?=
 =?utf-8?B?bHRlTFgzTEYxa2hqQVJlNm1sOGlEdEF5THJ6Q2V2dlNBOU1DYUtMT1ZLUkdo?=
 =?utf-8?B?T3NBQ2dqUzc0QVR0dy9Ta2RXTWVFVTNKVUtObE9ZVzBZNlIvNkxYR0VCMEpE?=
 =?utf-8?B?eXRXaE9naXVrZk1ybDBGdndtOWdidzgvTnJRaFRCYlVGcnkxb3UyTjRpV1d5?=
 =?utf-8?B?b0dWL2RaNnhyU3g1Wmt2Y3RHMUZHaitYWU5hMVd6Snc5aFRwQUZxV0NRV0dH?=
 =?utf-8?B?aGhqMUZJcGNhWFF1bnlZSnRPcHBzYjAyVjEyZDhiK0xMTW1KVWhtSUFVS2Zn?=
 =?utf-8?B?eGZrNDBmOVRVR1d1b0xpTGR3ZWVJMDBiUHlrTEJ3Z3BrLzVGZ3RlL2xFcjZT?=
 =?utf-8?B?VmUvclN6dnVCTm1yVE45MDV1Z1JjR2krTjZjdkNEUytvOGVTbUc5VStWdHo0?=
 =?utf-8?B?YWp1eDhnaExwaVFMMklTQ28rZWxtTjQ4Q0QzVGNhaVhha1BHcjFnbEVpWUJP?=
 =?utf-8?B?Q2RLTXRqa1FLVENiTVpYeHpCSDZJbm04b1pXdnU1ZGVuU1JWVUNmNDM0Mm00?=
 =?utf-8?B?YUNzTlErRTVGSHBxWTRiS2owYXRUMmxZSXBzbndta2ZjMURPTFJsMThHN2Fo?=
 =?utf-8?B?RXVIT2VuYk5XaytRMUpaWVFXNFVHdThSamdlUXJUMXVhMFJYRWhVMS9SZlZZ?=
 =?utf-8?B?V0hTVTZXMFpjQS9aakdtN1FDNXA3endManV1eWp3dWM3QXVndEEvZHMvMkJJ?=
 =?utf-8?B?LzZRbmVpUHozRjVvVUhUNHNYUmhIcElwYWM4RFNWdDF4bVVMK2svZ2xRcEhN?=
 =?utf-8?B?WVpBMFZmYWRYaDRUS3JLRGsyVmNsbFlZdW1FcWRRbmp0ellmaUhUUTIzNVVX?=
 =?utf-8?B?ZThWOU9hb2dFT0JyeWdKNEpkMzVoTGJEK1pHN01DMmlpM1dEM2htTzl6RkND?=
 =?utf-8?B?WGV5NkdSSE9UOXQ0NFFtUFc1MVVxZGgwQ0ZOOWVEVmNEZElmU0Y5K2Nqd0l2?=
 =?utf-8?B?cE55SmRMUy9qQllsbFU3eURKME1ic3ViV0lhU2w3ODZTSmVOOFNySDRtdnVD?=
 =?utf-8?B?SU52L094STVkRVpUcjB0TzJMdHlBOWR5cUQwRjlLSVdHcVg0RWV1c0RaZDB0?=
 =?utf-8?B?WEJweUYxMGV4cjNkRzY0YnVRWHZvRTVzNzV1MHJ3MXd2aXRIWlZEZHRkYSt6?=
 =?utf-8?B?NzJSeEh2d0pJKy94dXdoN2d3T3luOC8xVkY4dElhMVlRYkVwZ0V5NTdWT1hh?=
 =?utf-8?B?cFR1VHlmMzZ3KzVZb1FxekNYT1dpbHNhQzl2OTY3aXdiWTdBL0FUUGwxTjlC?=
 =?utf-8?B?YlVoT3AwQURhLzlPL2lsbGJNeUlQdzB6UTdkRDM1TlFZUG5keW1KYmZ5OTdD?=
 =?utf-8?B?UWlrMDhPWlRiWUxmN0lDaGxBTjZMbUJFbCtuV3Zmdnc3RkhpK0tFOFFhVTU3?=
 =?utf-8?B?U0dUaTR1MDRwa2Y0WXFHMXhheUJ3VHZVaFowUWVkOUJpdzlCdlBCaENHaXd0?=
 =?utf-8?B?MVZIVGhwZ1haREcwVEx2UDZsajR6VlVOVVZxTmNveitYcTF1QW42alN0bGdz?=
 =?utf-8?B?c3lDTTVtb1NaV1lRZk1NajRPaWphWmN0ZDZWd3Z5K041SEVPcTFqUDNGMW1G?=
 =?utf-8?Q?YX/IZwCCD/NGIFDX/EnkJoWhWGcKH7q8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkNYaFFOc2FCRTJCSzZqV1NhcGk2RDFtOEo3UEhjVnB0c0dpWnI0VnRsbkZD?=
 =?utf-8?B?UWdndTBKV21nVi9Hb2RwNS9QeUl2bllQQW1qaEVTa3RYWE9PNWNBT3ZSOWpj?=
 =?utf-8?B?OS9KSmQ4aXcydEdPY1UxSm95bU9EdTFnRm1WQkJPSGR1ZHJSUmZiRGMxRmJr?=
 =?utf-8?B?ZVRMVGxQU2tUb0tvTDBPQnM4ZXFoWnpDZndKYVlhclZVYmI2WUgvNlgwMFV6?=
 =?utf-8?B?QXN5VENjRTB5REM4NEQzQzduL0lNU085WCtyTHppOFNHOFp0K3kwZWpXWmJa?=
 =?utf-8?B?N0t1cmx6RnkyQmlkRkU4WjZDeDFCR21ITzYxNXZ1Z3hicFhSZG53VSt5YVAr?=
 =?utf-8?B?VG5reTA2d3hLd0dOYVdxTGlBUW51T0k2VG9iOTVRVU1YRjcvUk1ySVFLWDA0?=
 =?utf-8?B?ZkZJRXNUVzBJaEpIN0laWTVnK243OG82VmJqMUNLbTZCOS9jUWRTZmV6MlpM?=
 =?utf-8?B?dDFvbVlCVnNpeVIxRzJvcmZNbndoMTJCS3gyamVOaDV6RWE1dmtzb2hjZnVt?=
 =?utf-8?B?MVFDUjBVWEROaFdHekUxdGRnMXM0MEV1dWoyTlljNVBpTEltSUd5OUFwN0Q0?=
 =?utf-8?B?ZElnYkpnY2h0aVc5QUtGbC9hSFBZUGpzMXkzYjFFVDA0bU5vbWF4MXJDZTVL?=
 =?utf-8?B?Ynh6UTVSdXlQOXlLNmloUEZmNEVGa3VpcnR0YXBBR1JzNW1QMTVmYngycHNv?=
 =?utf-8?B?NmhCMEFGcm1BMjlnM2dDVWUyMHdKd0lvNEhBem9Rc1BTL2EwaVZZa3RjVlRZ?=
 =?utf-8?B?dkxDbmc1OWJ4NHpVR0xsL01HNkdWTkxIbXNjUE04ZGVnUVdSZDNGTXN2Ti93?=
 =?utf-8?B?TmkrVXdRVjdKelRPaGpVeHBmbHdYWForNGtqZkdQRXJzdStLTDI4aEFUZFFZ?=
 =?utf-8?B?b2FyazlRZW5LK0dpYUxtalo3dXR3MW1oT3JtOHBhV2l5bUpHZVRkZ0tiVC9r?=
 =?utf-8?B?WGVMckFwZW9nWTZvYWliSjZxblkyWWlLd2VsWWlmWUFuVVRhNVFmZGhLQjVN?=
 =?utf-8?B?NllVcm1RNThFeFBlUlpPZmQ3VzZoUGE0TWYvalMzaGJtZGZnRlFoODAzbElx?=
 =?utf-8?B?b2hGUkNaZGZFZjEwN3JSUzR6MkdnYXorMmxWMFNDRkFXMXYvVFJmT3BkS2pa?=
 =?utf-8?B?MmRRMmVPR1k0V1dhTWxORlk2TjRWSytONW1XOXovYVZXdmhmQ3JvbkFqY0tp?=
 =?utf-8?B?OVo4MW1OT2RIWG1LakNFUTRWRnRJRUErTnJUc2RkUDdraW5MdVBMcTE1UDZa?=
 =?utf-8?B?cjFrck9qWEkzclBsbG9XcEduN0M1b0NKS1JEYWFwejRBOVFaZE54MERSd2tU?=
 =?utf-8?B?d1Q5MmRCajdwRUxBVXU0WWE4VWdZOHBzd3cxY2VqSWFmbUIydUMyVzRHWklJ?=
 =?utf-8?B?d3JwcEFZRW94ZStMejVjdGVqdVJQSXlkelJqUHBrY0F0bjFWbUNVVTRzVm02?=
 =?utf-8?B?R252OTJwTFJFUE1sY1VDUStrVWdPNWhUS09pYmYwcHhXMktxUTlobWRDSm92?=
 =?utf-8?B?Y01qTmFmTkY0U29mQ1BwdS81NzIreVhBcXdoQTJYSjJPTjJvd3BubXo4K1U4?=
 =?utf-8?B?S3RCTVUrbnNjR1BDQml0azlvN3ZBWHE2SUFGaXNpM1NiWjlIK0paRHRjUkk2?=
 =?utf-8?B?MHhQYmdpdm0rNUFHa0xTdHhNZTJBc2U4Rk05VkZrcGFJM1p6c0RWV0N4OUJa?=
 =?utf-8?B?Tndnc1FvUmJNY0lvZ2dSQTlaMHVXOVdWMENINFZFTnJOYWhOeUE3UGtyRGJx?=
 =?utf-8?B?MW5hWEl0ZU5tUEtCbU42YzJYbkpGY0dSajF4bXJIMWp2OGYycHN5YnFRUktr?=
 =?utf-8?B?NnpMNnd4eDNCTDRLSmdBOXBXbk92M3NFSDJYTEd6ZWRWMS9VbTcyM21GeWVa?=
 =?utf-8?B?Uzl6UmRnby9GMU5ldlJTQzZhVEVsdlZ2TDB4Um9iZEN0MHJWejB6dlhVNEFU?=
 =?utf-8?B?dzloWDFsQjcwZVJaRUJsTXoxSDZhZGJkMURGUTFWZU1OUlFLcWtjZHAvOWw2?=
 =?utf-8?B?V2RrdXhNaGthckFOMHoydTN6Tm4wenhnN2xvMEQrZkhFVkIzb09mekNOVVhm?=
 =?utf-8?B?ZGZ2R2UrSVE5UWdaZlNxSFdxeDFSUnpXbjlBcTBLZjREa3VjSytBT0FtVjZs?=
 =?utf-8?B?MmdMUkdVcG0rMWZvNFU0Ti9TRVRTZG5LMzUwZlUvSWpOK2VsTnA4bklNQW1o?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y/gZsOH4ePr9D0Kp5cfMe4/PslSiPDdjaw7HYpUY06ew9iLnYDtzd8Ebw2knppNW0oTu1wzsBNLZhmBrLdLtCv0iQmARW7XSMnNRfvVSC9avpBoQLaix3/m3Z7iORn7qUuQFnZxuhNR1T0duev78rcLHKUWoMSJvHl0os0cVkQ1JVyqpQM2GzwTgZjrYGUJZe18js1JfHmC7eivi5Tp8r5cM/+YWTidkGCQZ7Lc1Y623ZCdsvpIFfVAVSdWIY3NVv2JP8cji9ajafDObWVup+ZfiTO2OOojPwnJg7rbCxfYvHSgTOCjGexnQld0636RZ12AKRiaiM5DUKwxr+0qEwz9GHO9SNeXmU3q+z4EGf70EacxfZBS7D0BCDxFGQKmrDsrBSbpx7B/m27NoiK04KgHKRwO1CsxDZgrIvmvgztL+UReVk2o86AFTamt6uL+E3/tjWuzLBqsnXx7ZGeKHYLiynAZW/3UPK82KOD15tjULHDUzQwSAencG6IRo/Myi6Qevr7WvTchN+vmJENdKbIsqncln7UUnre9yN/rBTv/UehkcQVT0t3DhGs0C2wZgc1E8hB0AzcQBwkWtKP8JYHk61jp9gTfeHGBg7HYQcN8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d841d6b-2be7-4fcc-04cf-08de23881883
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 14:14:16.8188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Za/f/NgUPsysayIedVf10n48XZ0yvZwiPtmjmnbZBwovdMz/vIEmoWBk8pJTttyMmTpgaK2w1bqWzPWca7jxeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511140114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX1AmipemE4qI7
 /yt9fE+89ZpwohqP/Gc9RHbdCloOoWrwJ6iMb6pJWt59A6u5gLJX0YUh57N5Ax8zkLRc/hMQrHl
 o8oFJXYA76e4SwQvTVr+JUAJAfKU1X5/QWX5ddv2KilL3O+VfoQfnLmXwzcBoR5DN5+d1cvvs++
 Si7kM4j24iWA3+dqVBJ6aGTISFu6qB7WJaZ+6s1omVKgqPUt4CF/xeDEiYFsskdhuHz/Gq1goQ6
 MY0rhE7M5oN3fiCmw/BFvKOGqMDwEb6YgEpdH8YGygzAvfK2aoGltO+xSROosddALBtklXGX/PG
 RFX5bRJjHE9VA2pmd7s16lJMJaNLqGfxh8vI3BvEdd8ywPoqtHVHOaM3GAiZAUMnzo2kcw/dm97
 UYwiSgE6d1RvSfgUi+ByaDecSpZZJQ==
X-Authority-Analysis: v=2.4 cv=WuYm8Nfv c=1 sm=1 tr=0 ts=69173940 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=M0aLRt5kWmW5QjQc5YMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ucQDMbgBR-CTzSJ1iXwFKIYuIUwtGtQq
X-Proofpoint-ORIG-GUID: ucQDMbgBR-CTzSJ1iXwFKIYuIUwtGtQq

On 11/13/25 10:44 PM, Alistair Francis wrote:
> On Fri, Nov 14, 2025 at 12:37 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 11/13/25 9:01 AM, Chuck Lever wrote:
>>> On 11/13/25 5:19 AM, Alistair Francis wrote:
>>>> On Thu, Nov 13, 2025 at 1:47 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>
>>>>> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
>>>>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>>>>
>>>>>> Define a `handshake_sk_destruct_req()` function to allow the destruction
>>>>>> of the handshake req.
>>>>>>
>>>>>> This is required to avoid hash conflicts when handshake_req_hash_add()
>>>>>> is called as part of submitting the KeyUpdate request.
>>>>>>
>>>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>>>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>>>>> ---
>>>>>> v5:
>>>>>>  - No change
>>>>>> v4:
>>>>>>  - No change
>>>>>> v3:
>>>>>>  - New patch
>>>>>>
>>>>>>  net/handshake/request.c | 16 ++++++++++++++++
>>>>>>  1 file changed, 16 insertions(+)
>>>>>>
>>>>>> diff --git a/net/handshake/request.c b/net/handshake/request.c
>>>>>> index 274d2c89b6b2..0d1c91c80478 100644
>>>>>> --- a/net/handshake/request.c
>>>>>> +++ b/net/handshake/request.c
>>>>>> @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
>>>>>>               sk_destruct(sk);
>>>>>>  }
>>>>>>
>>>>>> +/**
>>>>>> + * handshake_sk_destruct_req - destroy an existing request
>>>>>> + * @sk: socket on which there is an existing request
>>>>>
>>>>> Generally the kdoc style is unnecessary for static helper functions,
>>>>> especially functions with only a single caller.
>>>>>
>>>>> This all looks so much like handshake_sk_destruct(). Consider
>>>>> eliminating the code duplication by splitting that function into a
>>>>> couple of helpers instead of adding this one.
>>>>>
>>>>>
>>>>>> + */
>>>>>> +static void handshake_sk_destruct_req(struct sock *sk)
>>>>>
>>>>> Because this function is static, I imagine that the compiler will
>>>>> bark about the addition of an unused function. Perhaps it would
>>>>> be better to combine 2/6 and 3/6.
>>>>>
>>>>> That would also make it easier for reviewers to check the resource
>>>>> accounting issues mentioned below.
>>>>>
>>>>>
>>>>>> +{
>>>>>> +     struct handshake_req *req;
>>>>>> +
>>>>>> +     req = handshake_req_hash_lookup(sk);
>>>>>> +     if (!req)
>>>>>> +             return;
>>>>>> +
>>>>>> +     trace_handshake_destruct(sock_net(sk), req, sk);
>>>>>
>>>>> Wondering if this function needs to preserve the socket's destructor
>>>>> callback chain like so:
>>>>>
>>>>> +       void (sk_destruct)(struct sock sk);
>>>>>
>>>>>   ...
>>>>>
>>>>> +       sk_destruct = req->hr_odestruct;
>>>>> +       sk->sk_destruct = sk_destruct;
>>>>>
>>>>> then:
>>>>>
>>>>>> +     handshake_req_destroy(req);
>>>>>
>>>>> Because of the current code organization and patch ordering, it's
>>>>> difficult to confirm that sock_put() isn't necessary here.
>>>>>
>>>>>
>>>>>> +}
>>>>>> +
>>>>>>  /**
>>>>>>   * handshake_req_alloc - Allocate a handshake request
>>>>>>   * @proto: security protocol
>>>>>
>>>>> There's no synchronization preventing concurrent handshake_req_cancel()
>>>>> calls from accessing the request after it's freed during handshake
>>>>> completion. That is one reason why handshake_complete() leaves completed
>>>>> requests in the hash.
>>>>
>>>> Ah, so you are worried that free-ing the request will race with
>>>> accessing the request after a handshake_req_hash_lookup().
>>>>
>>>> Ok, makes sense. It seems like one answer to that is to add synchronisation
>>>>
>>>>>
>>>>> So I'm thinking that removing requests like this is not going to work
>>>>> out. Would it work better if handshake_req_hash_add() could recognize
>>>>> that a KeyUpdate is going on, and allow replacement of a hashed
>>>>> request? I haven't thought that through.
>>>>
>>>> I guess the idea would be to do something like this in
>>>> handshake_req_hash_add() if the entry already exists?
>>>>
>>>>     if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
>>>>         /* Request already completed */
>>>>         rhashtable_replace_fast(...);
>>>>     }
>>>>
>>>> I'm not sure that's better. That could possibly still race with
>>>> something that hasn't yet set HANDSHAKE_F_REQ_COMPLETED and overwrite
>>>> the request unexpectedly.
>>>>
>>>> What about adding synchronisation and keeping the current approach?
>>>> From a quick look it should be enough to just edit
>>>> handshake_sk_destruct() and handshake_req_cancel()
>>>
>>> Or make the KeyUpdate requests somehow distinctive so they do not
>>> collide with initial handshake requests.
> 
> Hmmm... Then each KeyUpdate needs to be distinctive, which will
> indefinitely grow the hash table

Two random observations:

1. There is only zero or one KeyUpdate going on at a time. Certainly
the KeyUpdate-related data structures don't need to stay around.

2. Maybe a separate data structure to track KeyUpdates is appropriate.


>> Another thought: expand the current _req structure to also manage
>> KeyUpdates. I think there can be only one upcall request pending
>> at a time, right?
> 
> There should only be a single request pending per queue.
> 
> I'm not sure I see what we could do to expand the _req structure.
> 
> What about adding `HANDSHAKE_F_REQ_CANCEL` to `hr_flags_bits` and
> using that to ensure we don't free something that is currently being
> cancelled and the other way around?

A CANCEL can happen at any time during the life of the session/socket,
including long after the handshake was done. It's part of socket
teardown. I don't think we can simply remove the req on handshake
completion.


-- 
Chuck Lever

