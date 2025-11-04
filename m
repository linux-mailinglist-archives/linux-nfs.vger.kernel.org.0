Return-Path: <linux-nfs+bounces-15999-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7115DC316C1
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 15:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A493BA2F2
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9A131BC96;
	Tue,  4 Nov 2025 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZDlyF20y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xOfOM808"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF671329376
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265168; cv=fail; b=moUKzD+E5NFD7L9g4EQ9oJfzeq6Vl6rfiBRrwrJQ5Zc7HkzF9C8ma6SdyZOzJa9uQ/ij9tAE6yrkccIlnt4meMHp5LkNTx2PtdKi8wMKfDvflHm53dxnlbpEYjS/IdG0O/5YT8COFkL4/fhV8ngDeTMBEOzX9u4NpURmujkeZIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265168; c=relaxed/simple;
	bh=vgyHoUzhI3DKiLY9V0zDdI0GtBGXEvYgMHyGorF/ymU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JDLj1FQ2Wp1+sv3UralEUjDbkpe09rgDKM6fcsD/HjnKDlEDgp33QLbO83gNzY7x7fdjqcVtFCdUjJL/8eLTJnwNlSE/7u8PO8YXD2vmL7GwdgPf0OBdnfMJWzz5L0HmwUX2FTgCBhO+V9RrhCWykb3zUjeY60cp63s7NY9cUAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZDlyF20y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xOfOM808; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4E0Gn4017809;
	Tue, 4 Nov 2025 14:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xjvi4d+prnj3wjB/HhT+dcOYF8+OB6WT226jY+OMyL4=; b=
	ZDlyF20yyOEcUxlB8+w2GcmmwAkSPnNR0tDZEt2oIynpvobCaf9pBOu/m00mLZ+g
	0QhWZbC9i8SZu+gXHIwglkdrFQyyiYx/VH+kNl62YRdBp3KLp7Gn7yMiveJdJtfo
	XQP1WpsgF8rF0tCRQbHSjFCnx7YTPB9JKKW9ke7oZlBNWYoTEp6bHETz7NMVTb/I
	wvBwtCuRLrGWqdH8crEiNQ7SNV2M9/psFgwBjv2VDiM6dMLKajmeuK5rgLVHmFiP
	Vzb3WtmeSGJFmjNu5cly1uwAZnuNUYpGO8orfi86D1IYovTvh4JIr3CUzA58hMTB
	nQFfp/c8WCdwbJ5FJGSNcw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7juug0h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 14:05:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4DmiA2017890;
	Tue, 4 Nov 2025 14:05:54 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nd5sa0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 14:05:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAKYB7I32WXsmPz6oB/v5QxoyLLKtyeZ5ggWa0nBEcGCVU7DcONJbGLKBnOg35OK2ZJjlHlOidb6OIUTBQACA4EJ8C4dJpx2Px613wbTkacXLfmT+hxoDXfYSvdqLW5ZQaQf8K21OQQGcsB10UC0RSrT/7QvvVE+eyvoXQsnLP0uiskaAD09xENYFC1TPpYWmnC3hGBYkr2sdC9TstsySuXTiL3CwooZ70VEcCKuwr1yZhRzm7UEbaamv4NS+d8mZNGcT11fY0eqdgLZQtp4OnnT95NjoogpuSMV1D7KDGoCaMRVDH91DDTBdwbdciJ/1p1FeEdnFWcD0HtrMhlG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjvi4d+prnj3wjB/HhT+dcOYF8+OB6WT226jY+OMyL4=;
 b=aPJZmuJfP09QsWUUT2KKz50Y+TnB7F+saGMhhWcTNvB8Sn5yX7xqRqhdxVA+QEpKEFwacg2yezDFTYzghI7GGpUpewrJla6fIqJCFf8LQBm4WwjefLiy/mc/SC6PxF629WKKxvTYHvgWco/1P2JyA34wJ+tIJrVEGCfiWG9vUOzgfQQybNgdTTHAVbfc86uX90sK6oULtW57esESoGC3d1clZVdhLq5HzNowYgBBKwlWpmDps3pNLSldIBjOLJz7rZxkAkiQIN3uDz9wQL26CfWcguEqRgoGjzx14Jl+PU7LfLlWJY7qP3IeYVhLeNpwOBoG7eqWpdThOZajA2IaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjvi4d+prnj3wjB/HhT+dcOYF8+OB6WT226jY+OMyL4=;
 b=xOfOM808CtVVFhZWzCj9VeFeE0sSMF5PAwvKo9T8kfTqbySQSbAqFI43/2ZdI+oRiXToovsvjodgHQeXmv5haGYrNPCRlqZ6hGkWaApIysynDSfiYgaucl6q365dLgOjGFIjWwDTMJQH3S4PGw2CyPpWCAV+dceu3b2gdpzd+zY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4437.namprd10.prod.outlook.com (2603:10b6:510:3a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 14:05:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Tue, 4 Nov 2025
 14:05:51 +0000
Message-ID: <285c4ab9-ebac-4a04-ba34-00e53836263c@oracle.com>
Date: Tue, 4 Nov 2025 09:05:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] NFSD: Add trace point for SCSI fencing operation.
To: Dai Ngo <dai.ngo@oracle.com>, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
References: <20251101185220.663905-1-dai.ngo@oracle.com>
 <20251101185220.663905-4-dai.ngo@oracle.com>
 <b8a55017-5bff-49f0-a2bc-6bea6df7d658@oracle.com>
 <9f5a24bb-0f19-4feb-b687-0a78844c8bb1@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <9f5a24bb-0f19-4feb-b687-0a78844c8bb1@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 54406e33-1123-41db-5703-08de1bab4327
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SGhXMXEvc0EySlB6dXRKSi9TeWw5MldNTWs5RE9WVkEvbzN1MnZmTkZLckFY?=
 =?utf-8?B?VjJvSlJjRzVQUVQ0QmE3WU5ZdHhaM09mZzRKL1oyMmtmQUdLWGdqMGxsSVdq?=
 =?utf-8?B?Vy92LzBnMG9RcytjaTI4cHVwRnA0ZVFWOXAyN0ZtNmt4cjdBakhWR3F3UkJn?=
 =?utf-8?B?bG1Iem9yWmRBTWdjQjhvMUFZck1DbmRwaVp5YU1MZmVldjJ2M3llaGdNdWU2?=
 =?utf-8?B?cnQ5LzZkZ2xTcnhRZlp1UnJldTJUd3ZaZ3Q5NmpUWk5udHZKNFdicDlzdm5I?=
 =?utf-8?B?VXJwNERpQXFNMXpEd2NGa2xlVnJOS3lFSnd6MjNRd2M4b2hJMytzLzNmTzF3?=
 =?utf-8?B?SzJtWlZZejlDeFc1cXhqZitZbVRpdXJZOEw4WGFxeThuZVRPQWJDdVJTNkpr?=
 =?utf-8?B?Yy9sT2VxaEdzMk5PT1dQMnhVS0hBclZuSmZYQlVhcGNWQS94OStTcjBGYVlW?=
 =?utf-8?B?UjEzNzlrRUN4VEVOL3NQZlFQQk5oYnRjbzVuZDZ0UW5kbXBGRlJGUkZBRURM?=
 =?utf-8?B?eWNJMDk1WVlUeFBBc0FTMjVVYXJCS0M1ZnpNcGpKR1J6SHZkUEhQTkVyYjJ4?=
 =?utf-8?B?ZTE0S3pPMXYzQ3BtNmJEVXRxZnU5b0lBUnpGRHNMTklDbHk4b1ZYY09NMG0y?=
 =?utf-8?B?RUZEalFIU2FoVGdVekI3YkwwUC9PY1htbXdubnNheC84T2JYbVkyMGUxZmJH?=
 =?utf-8?B?R3RoYndFWTZhTXpsTk4xcTZheTRzRHV0YUhWSGtsZFBrblVkR0lld3JXRFdK?=
 =?utf-8?B?bm9EMEp4MmxXK01qNzBWb1orWmk5YTFJUndnVEhIZ2M4cWJCMFoxcVIrcFRL?=
 =?utf-8?B?eXBVdXkxNUpPVzlqREkreGFXdDEyLzVGU0lSVmZHUzVRUWQxUzJadXM0SGZN?=
 =?utf-8?B?WEU1RE4xUW5zTmpQU3BpOWJTcFYwSkd3bDFjQ1ZwZGZmRkNOK1RlRllScXY0?=
 =?utf-8?B?VlNhSjUxdnp1YW41N3JhaVZ1UW1iOHlhRXpVTnd1ZmtQVEJOeVdRTmhmRmk2?=
 =?utf-8?B?U0pYcnFWTWdqQ2tNSmh1aXg0dkxqV2JPVjdYY1dkY3BSWmw0TlJFRWxxM3Vm?=
 =?utf-8?B?dG9yYXdlZUlsYzNtMDFZQ1ZDa0Rqd1pSMTVNbG1XU0F3LzJvUTBncWE2Tk0r?=
 =?utf-8?B?TkhsVW9wY3VmVnNqek5MZnhSd3g0Mkk4eStpWjlUUG1TNzJLYW84VXluWnNB?=
 =?utf-8?B?WURuYjcrZlBydzVIWFE1QXdwQlNIVCsrMUhSVUg2UU5xd2V1YzlCcHErQk1i?=
 =?utf-8?B?UUR6dmVMNHVLOTB3YW84Nkl4TzFRZ3JKb2Q1UjY2VHk4ZXk0S0gyZ05GSXRR?=
 =?utf-8?B?VCtOSkR3eW1RVU1kZWgvQjBsclBPVTl3VEVaRTBscDFMYTRZSWNxR2RhM0x5?=
 =?utf-8?B?WmJhN2NPMS83NlN4VHJYNWxmSnYzTUJSV2E0MldtWTlFbzNpQ1RxN3gvOTBH?=
 =?utf-8?B?SzFJcEJjOE1QdGNDbnhKSnhwWEFyZjVyMHdlaVc4OEs4OGxXNHlGRTZ2TzJ4?=
 =?utf-8?B?TU50cWRIekVXSzhHL21kQ2RrZGRsdm5VeFExOGJHUWlmbDRQQlZobm0xRWRa?=
 =?utf-8?B?T0w4YUkxSDM3TUplcmxCV1dyRENrRzhOYlczaGFKMWgyUVpUbEF6VFZuNk1W?=
 =?utf-8?B?S0daejluV3BxTDlPUTBGa0JTenB6WDExSDJheTJHN2czblhnOSs1WU0wbkto?=
 =?utf-8?B?OW56dEhvYjVJZ3UxYlR2MG9CZFBlSnlOK1F4dEU3VndKc0RZVlBhZk9aajZ0?=
 =?utf-8?B?QVBuM3NaT3VyUkYvOHVYRVVKeTE2ZXlDRFh2SUg5WW5uNjZJdHA5dk9hOWNK?=
 =?utf-8?B?SWwybHQ3cVpnNDNJY0xZVzJlWHZRZ0FIMkRTRVRmR0ZqT3RtK0lWell0TnZ3?=
 =?utf-8?B?Z0VZKys5d0dES3FjZkpjVTh3WjF6bHFnMXRvek90WFJpMys0ZVJGSEJ1M0lu?=
 =?utf-8?Q?lrv1YACvh+7CW2VtSi2tNwNKXsUCr0B6?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NlpIbmNBb2xhVmtuWGppT2xaazg1Z0JleDBkeXR2cGlHNklFWE1ZamIxSEdN?=
 =?utf-8?B?YlVVLzJtTG1yTitOM0VRWmJjTG9BdXlEMU8vMkNqcjBuWFpBT3FTZkFqUWVX?=
 =?utf-8?B?UmJKTUlaUS85eWVKRE5SUVI1d2RFT2tLV2ZadXJvVUExSERYeWtvcUVNZWRS?=
 =?utf-8?B?TFFhblFEeWdldVJVM2o1VjBTdW5KVHFYR2Q1RXN1c0RzNXBoR1RlenhpQ0pF?=
 =?utf-8?B?T1RMM2E1Z2xRVFVyNHl5M2RUYytXWWhuTVgwZTJWTmpsMnVHMmVEVTFvTDJQ?=
 =?utf-8?B?TjNRSVhBYno1azJZNzJldEMreFFFRlBYeDZYU3Naa25xTm53eDZwRU5JLzRB?=
 =?utf-8?B?ZE5ScHB1MGVZbUczc28yVmMzTjJUcmViVWZMV0dvV05PbTloc3VWdDVvcldz?=
 =?utf-8?B?UTFoR0ZySUZqdUtrVk9RWE5maTEwbGF6MTZhYzlrWlV5dWVZVHZCcGVwRjFp?=
 =?utf-8?B?bGNlaTBxWWllUGhMWmlLa2Q2VEFjdjZlOTNHMjZCeXBzOGQvOGc4Mkd3d01K?=
 =?utf-8?B?THNuSVB5cG1xU1dXbExSUTN1NWM5K01jaEpST28vbklxczV6ZmlISFNHR243?=
 =?utf-8?B?V29qaElTYVJOdEN3REtpbDYzSk1FZnVocVUyYWM2NlIrSmFnQkZuaFJvK2to?=
 =?utf-8?B?YUJOd2lTeFM1RjlwQUw0OTV6Z3RwVWpUZ0gwWXJKbTNpUmt1RUtJWC8vT3BG?=
 =?utf-8?B?alpUZ1htdnhGWEErV1dvSTZMNGhhMnZlZis1VkRCb0dKNHZEUlVybkd6dDli?=
 =?utf-8?B?UzBzZFBzalgvU0E4UDhmNWhrb29TbFhLbG02Szc0bzgxMUQ1NkgvMERjZStK?=
 =?utf-8?B?bStaZUc2VTRXTDUxdXdTSEhNSzdEMmRVaFlLTUtIZ3BLa3ltOFplTWtrQlNX?=
 =?utf-8?B?aVV1enJTWmNZWldRb2wrVEQyVldqcThPMTVhbFQ4UVZlbHVHcm8zQk9lNzc5?=
 =?utf-8?B?MXVZb1NOYml1QWY4MjYyRzNrQjRGSUVtclp5aHhGVkszL3FPNHBkcjEvWDBF?=
 =?utf-8?B?WmtJYm1FNWNqMmpwOFE3YzkyR0loNkJQdWRhZU51alYzeVpFSG8zOG5CNWE1?=
 =?utf-8?B?ZkYzSHQ1bkIvZCs2cGhPSVdYRm9OcGM5cnMrRG8vQjNWR2NnT3Q4Z2pkaURR?=
 =?utf-8?B?QWlkRnZuR2dNNVp4RW9VcWtWQko1WE1FRy81SWtldGtreTgxVmwrRmY5ZjlN?=
 =?utf-8?B?YzBuVGNCK2plOHFJSUVIR3QydlZEMTdxU2RtWEpKQTQ4SXF1QTRlMkNtRDU1?=
 =?utf-8?B?MHlBUnhEdEM3bTBrbXJGdzB1T2Z6N0M5OVhZbmdGSTB0ZCtmYzBkZWJBalA5?=
 =?utf-8?B?M21JSEtsbnVCZlJ4MmpBMUt6RXMwREdWSzViNkhEMm5pNE8wOVNWYlEvVE1U?=
 =?utf-8?B?eEErajdOMmFYdDRQeWRpd3RwWE82MW92V25PaGlIZjR3cDdGWkE4SjJiMEo4?=
 =?utf-8?B?b2lGWUxFV1RUVVFxMWFNbHZKUjF3dzJ4QkZ2cU9DU2FZelMvdXBGT0lXOW9L?=
 =?utf-8?B?NXZ6RkJUK2RqdUdYa0svZEFZN2JpRUovTmZqQ3YvNThjZlUwR3ZTZ0k2b3Jn?=
 =?utf-8?B?TGI2LzNlQ09KU2dmZEl5U01KRHpMdzRDb2RPblJPaXpNMWk4Z3dXS0dKaXBk?=
 =?utf-8?B?OHdDTkJxS1ZPS1JnSFJLczdXSDVFaklRdXFTMUp2VHFSWk9pem8yUGtVT3dV?=
 =?utf-8?B?cUlaOXFsMmM1U3NHWW5VTnJPN0M5dEhkSHdIMjl1T0E0VmJTM01HRXhzZHU2?=
 =?utf-8?B?aG1FektvRHRDVm8xK3NzREZISXNLSGF5aDJFanNLRUlwTzhMTEpGUW5FbHBp?=
 =?utf-8?B?MGdqQVlFeU1KSkZGYTJsenZWVFI5TENxeVJ3VU1CeDNta0pKQVNCWU8xVUJ2?=
 =?utf-8?B?MDZvdjY3ZlRiNDdsd1E3UThlV1Brb2Fyc1hFZHZqZm1OZ2duM0NkZWNJb1dS?=
 =?utf-8?B?bnZvOXVWN0pBQ29KM2tGcStRMkdmOTg3WVVneFlPVUpRZE1WSEZOL3psSzFM?=
 =?utf-8?B?VnNMQVJxRWdHQnF4UlkyVVlFQlpsM1VHSDRNUGZsK3A0bTBmSEYxTXpsVDR3?=
 =?utf-8?B?SFZrU1ZvYVhMZ3pTd01GZVZUb2FXa0xtNkM1YUxNcFVRam1aZ1pjU3p0bzFM?=
 =?utf-8?Q?5ouP4pTfqmjP2fO6APIDHYSjc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kXHn44bg8bdW9hV5fxNwW2Jnqx0tpR09N4tvKQVaOV/b1YicLcuxMSmjkv+awl1fCsEju9j/rf1tKLFkBIKaP9rCNVIYEwE+2nmerseHGwEbJVuISuZXXu8la0sP/xADoC9A0W0QmJlfOGDwX9XBoIBUA4z0YZV2eMdJ5ISoXg7X3f5oq4BPjNvjgOnBiWKMYwfR9zjGkUn6tbSDl/nZ2hZcUWz4M1Ea0dANRGliXCeah5JDFQSSoOiq5RSd6hyX3fUnsJrot8KOE0sT6osd++hw3i6K68Y604V/HlrmzCZVeK6l7C7P0jJMrojc9qgGEOr5zMbmyLzTsIEM3gSSKv65+nNZxnMIu2SSLjbJsGhiuvNxhJjnL4aAxWp1b2cBAti6+tEaSCJzM24ChieNp8x1RVlP/6gdrGnqt4nztBNXj7744nLFhUl3Kl/MIwz3ZUaRmjkW463rY+3O3T7eT5nxXw8eGpVyLBHycoTWfBKfZj3Ad/IDwIVDEUMUgkjFm5Lykv7Z1iUmQ8SW1fwkIJ9b+nND961GC8MmZ1qHfeiulYqKhz63Dg0kC4gK1w8cjY3mhejMK/LXDNNWP2vt/RCkGI6VeJh1T9KUy/t9i3M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54406e33-1123-41db-5703-08de1bab4327
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:05:51.5199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htvzw+3yeQBerxRgzWABVfpvNc7l1DvcjmGzfQ/nYxzpa4i/JRUDh+Flfz6eH9lj8WIx5xWTuBMqd4ptOY3M7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040117
X-Proofpoint-ORIG-GUID: 7myM3tciNcrhJy0mJJwC0ydLmB-BB7o9
X-Proofpoint-GUID: 7myM3tciNcrhJy0mJJwC0ydLmB-BB7o9
X-Authority-Analysis: v=2.4 cv=M8pA6iws c=1 sm=1 tr=0 ts=690a0843 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Jvt3mcMbGSRUHR9EgVQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13657
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDExNiBTYWx0ZWRfX0Srq48sxNZh/
 sBW5sw5xSdukyvakf08nhN0tTPBQZVGVlCvtHsA+BvgBjXnbsQpvYCjjekPeKVS+Iw6nDsqD5ro
 gXiXvPHORIM0rWlD9pO4P8URQ1WEssSpN88kx8Kqfksl2FxDEgBcw/6K6xY/StWTOY1YjWV4ElB
 wEE9fYuSSyDbSuGiyh/+ZGztqh1Lq+wJqiPpkZeg4u0+riC7gjycJubCFnPxa0uTfD0e+RKdrVU
 AgZMzp7riS6lahn9HqdoRtvqOf1oM7rMHccb0Lof/HqIhwoq8B8otNjSon7lM0vO6Rlhe5KGv2Z
 f9ZGXkbKKBGMYMtBke2rovhkhYUXfwRv+aQSKu7qSDibymQr+V3VV7w90RztPXKi9heTSpINuYf
 PI9r0eHwzcFztgGk6lcw/e2XGTDHw1JPJ0PQ82Ckacabei2QIHQ=

On 11/3/25 7:32 PM, Dai Ngo wrote:
> 
> On 11/2/25 7:40 AM, Chuck Lever wrote:
>> On 11/1/25 2:51 PM, Dai Ngo wrote:
>>> +    TP_STRUCT__entry(
>>> +        __string(dev, dev)
>>> +        __array(unsigned char, addr, sizeof(struct sockaddr_in6))
>>> +        __field(u32, error)
>>> +    ),
>>> +    TP_fast_assign(
>>> +        memcpy(__entry->addr, &clp->cl_addr,
>>> +            sizeof(struct sockaddr_in6));
>>> +        __assign_str(dev);
>>> +        __entry->error = error;
>>> +    ),
>>> +    TP_printk("client=%pISpc dev=%s error=%d",
>>> +        __entry->addr,
>>> +        __get_str(dev),
>>> +        __entry->error
>>> +    )
>> Have a look at the nfsd_cs_slot_class event class (fs/nfsd/trace.h) to
>> see how to use the trace subsystem's native sockaddr handling.
> 
> The native sockaddr handling used by nfsd_cs_slot_class seems
> to be broken:
> 
> [opc]# trace-cmd record -e nfsd_slot_seqid_conf -e nfsd_slot_seqid_unconf
> [opc]# trace-cmd report
> CPU 0 is empty
> ...
> CPU 15 is empty
> cpus=16
>             nfsd-2784  [011]  1205.355839: nfsd_slot_seqid_unconf:
> [FAILED TO PARSE] seqid=1 slot_seqid=0 cl_boot=1762214337
> cl_id=3172331794 addr=
> [opc]#
> 
> After changing 'nfsd_pnfs_class' to use native sockaddr handling:
> 
> [opc]# trace-cmd record -e nfsd_pnfs_fence
> kworker/u65:0-7458  [001] 933.253811: nfsd_pnfs_fence: [FAILED TO PARSE]
> addr=ARRAY[02, 00, 02, f9, 64, 64, fa, 2b, 00, 00, 00, 00, 00, 00, 00,
> 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00] netns_ino=4026531833
> dev=sdb error=24
> [opc]#
FAILED TO PARSE is from the user space library. It's far out of date.

-- 
Chuck Lever

