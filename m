Return-Path: <linux-nfs+bounces-21615-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBYsOzEEBmq1eAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21615-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 19:19:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B6545278
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 19:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6937E30143C0
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 17:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B390D38AC8E;
	Thu, 14 May 2026 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kxFXWgRl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z89pZq6v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF13876AF;
	Thu, 14 May 2026 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779183; cv=fail; b=pzr4qdWgvp7sjuZB1heGWP1o3FEbD7M5qgCVhYSruNP25AkbM9jzXyn++4nE9SiJzfnxyU15JF6+WIo33XJGAX672GdXJbILM721nxLZVqLtATiw+jlswkz6U2UWmPG/JjLfmiRk/GheTOyChRYzox9EUoS8wgWsWjH4HfUfqVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779183; c=relaxed/simple;
	bh=MTPDR9EDDSQjZnbp1gvYYHnw2hDZZq8JAwRP1F3da+A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CTkncNyVRe8mfy7E1a3zScI/hiuOOEh8SdJO4FtwL90EzrYQPHdCsjYAya+h3yESQudQmHjL56rb3nzLS89YTBQOVzXaHgDlYTluMwUNSkGj00izb8tXxu92mr+PS6WrC5CD06bxDw5pCupHRMaGhp7WTDOwz1Ncp0mC0WWySOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kxFXWgRl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z89pZq6v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EAMtms025347;
	Thu, 14 May 2026 17:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tTIZU2B+FqMdVtGZkNE/0BCuFWnqdce345ixTLPQabg=; b=
	kxFXWgRlROTsKXDHi5C3K8Uvq0Xm84g0OLdNRKMZHRryAlp8xGNAduQxSfMjLcV3
	ughSG14X6wosFJPdQWC/ajwBo8WElwDo2/GZd+R1718EZraQb3b1s9rgFlgvE3FJ
	vgS1+T27WYlhdjlTnOqKGT+6VTMGdQF0iKqdiEvUCdUdBP+dTHZlJPLFlDczH85V
	7rjK3//hw86Q6yfoBWxGjWjj79TrigNnTN06D3e2bmshHoJTFEWDxCIU0qzNndXR
	sVyMFTOLZ4yjGJgA7atZM05Sx12qc0qX4elqHVvR0bp/G2Z1cTcYxNr+VgxPaR/j
	y9jU30kJUL/3eXZrRTFstg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e4c95kr51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 17:19:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64EHEvST004613;
	Thu, 14 May 2026 17:19:25 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e3nem84y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 17:19:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcwUTNHKHj6pwyHRaQa21a0ecHkxKYbubLKSi6I2idDUTG6TksSyBXS3p8wh/kkwj46b+WN7GnCa2cEybt/g8AT581WCkYbtZPLn6X9BcNFusADwOGjwPGbUnxeRtrfyBdYWVVSoevuHnWOHwElmgLIp0/6c51NQsxepVp6uAGTVKO0GOdGhLPe7J4CSRwPcE39O+VQJ/Y/7H1nEB7D+Y+1xj2LO7w9bNj+mgSQStydzEBYZV6p9i2NY6+5jld4C40mTKhsVw8XhbjTNqoVIko22E7RZZwZ0iAwXCsnv+7djz7Afv80iSc0OeQ1y6/cfn1eqdat1PbPDyplK/jcUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTIZU2B+FqMdVtGZkNE/0BCuFWnqdce345ixTLPQabg=;
 b=C+rlhXYDJYXCvzsI3/8nUCj3CAw8TTlaMOH8nFfSXLGtxDrkWW2RdN98tZ3rf6BIfxPs1oesCUQGcSGU+gMl9oQrIN482HOAN5CSi1jbY1Tssj6fzYqbnlgxaPI9ZVWfqT/0EVg9SQ4J6rpkHHmOA3QgPxiNJu6OJru6VdyCHlzz/faj4hZVGcsGuQTYnOmxHiHgv6cfVB3ViSYoPV4i8PUFScdmthT44dDwHln1Hmrz3qDcA8f+2zd2ZmicHOfbV8srBO+sFOQem0abIw7YUp9wMPXgG3fK8GMBpYdPHcHhnlgXjT1Q55Vxf+MJ+86WSAYDRK8UJB2AjJMrChz9GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTIZU2B+FqMdVtGZkNE/0BCuFWnqdce345ixTLPQabg=;
 b=Z89pZq6vGHe+cekjvlLPfqEgXVwlN1BOE2gGw/1xA00fjDuWW64ozPfqjm46FTDX3taJ5y9VKRtzN3cTL4o12eWwM40MfiA0M0CpWbUb8BKooBY/OQApP+7RzfPL2Nu1o61KkNb5aizjRbbnG0lxiVlshVtrNwTs3KA7rmIDbFY=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DS0PR10MB6848.namprd10.prod.outlook.com (2603:10b6:8:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 17:19:18 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 17:19:18 +0000
Message-ID: <26365a46-bdac-4e8a-a951-de904c3e5606@oracle.com>
Date: Thu, 14 May 2026 10:19:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260512172238.2495085-1-dai.ngo@oracle.com>
 <agQhzg-0aeISwOGW@infradead.org>
 <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
 <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
 <20260514002513.GQ9555@frogsfrogsfrogs>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20260514002513.GQ9555@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0415.namprd03.prod.outlook.com
 (2603:10b6:610:11b::26) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DS0PR10MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 8677e581-e944-4d19-9212-08deb1dcedf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|4143699003|3023799003|56012099003|4133799003;
X-Microsoft-Antispam-Message-Info:
	ikLPpUz4h7/N17IneDPmfYhgOgLRXpCZrjgGPREZvbUrMaBEmsOYnf5nrMq/E8Tj/WEWnq9sB8ECNTLhGtc1czciatMko9442yfxSOYetRHiZP6hJVrXKXzUWn8hldYW5hv1kmhX2mvkk/KuDNxpmcitDV//H+C+t2dAYfn4D+IFjmbTMT7Q4xIxxpF2ESUjpRkNdj4rcFO6c+ckVM8evQSCConPSYWuIU5F5Ws70UsnCBS/yIXNB2ZN98YRREzhH9hpz1kVAPFbRVhu6XeSt3GQmuQyGCzSQzK6NIdxgq6KCUdM45i1xM4iwx2GDeYTa0sXJd22B/1kgWo729ZavZO/zwOaJL7SYSAMs5vC9FZiOevxEPWWXgHr+3UQPNWoPjq2h1K67M4+afD1gJ8BVdjCsP+0kQdjIx6ihNYglOb6+xTihIfBfKc+Y2qgIcZq5FMd99KMdsEGQNHVMT8VJ9ELl766AFBDeR9jQET4XFS6PR+4IgYHRhrdDL9eLSDHHddNewQJLvEY6Wb1jrNaAa/VgLe/SzoVJBek0LktWIJO0SaNxXDBiR5HtZCds1VjLp5RvMi/6XkqvcgcfhjuMTpvyps46jM3kGDzLnvII7PJhjKDQV+81RjCV54S2Fnh3/A006j0x6gR+GdGde7EN+5dhwAm7xHrDOPij5Z2DmB2FAcTTgpGI3SXAefzaEbY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(3023799003)(56012099003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mmg4dlNpcytYdXJCZ0dBUGlGMGIwOUwwU1p0WjhXWC8rb0V6Snhibzg4V0dD?=
 =?utf-8?B?VzNRWk1rekIvZHBrVXlNdjM2RytxNlFjVXFTbDZ0TVV5MkVVaU1QMllaUTdw?=
 =?utf-8?B?TlpjRnRXMG5ESy9oWkEzcEhiSVNmRVVhSmVFQmdOMVF5Q2NQVDBGOEo1cW8y?=
 =?utf-8?B?TTZSSXVST2hXSHJEb3k1ZE80WkxCMXBNU0puSG56eWpJTEFWZ0I1dmNldEhZ?=
 =?utf-8?B?K1V6bDdkRGhrSzRGSXIvSG00VnpkM2ZqQ0tWbFFqVWd0VWwxaG5vajBHYWZU?=
 =?utf-8?B?cUMxUHM2emlUU3Z0b1FGTFJyOFllNTZTM21pU0xLWnNQQXlDR1FLZkszKzFr?=
 =?utf-8?B?d3p2dnY5dW5kaXpKKyt1ZHFVcU56d3RhTU9CQlpQS0JXRkNianIvQ2FNSmhL?=
 =?utf-8?B?cjlkcFBPVk80WnF5NWRMK01SZm50OWNnWnlTL0cvS0U4TnE2ZUNSNUwvblZV?=
 =?utf-8?B?cnVTTDVkZ3hySThXbGFpYS9wUU9DNUdSL1RUTXdIelB2QUVJQkRQRHg2b0hI?=
 =?utf-8?B?NHpodjJ6UkY3WDQvUnZxWndBcmVzMjNHNjBiUS9ESlhoQUgvL05Ta0RMdnZ5?=
 =?utf-8?B?OGdEVFpqNG5ZOXBmZGpVRUZubTlWdVEzcWlZWVlONTROb0svVTBWRi93VzAz?=
 =?utf-8?B?dzRxSGNqODhYRENqYkRxS1lmTisyT3ZVUVA0WGYzM1ZSb0RkTlRCRlUzTXlW?=
 =?utf-8?B?Q2Y4MnpCeGRIUVlHVWU2c0hDaVUwZXZFV3R0QXRRcFp2OFVEb3BYbE53ekxz?=
 =?utf-8?B?OElZZWcxejZqV1UyQU1xeUJ2WERuVFZNb1Aza2M1TmdUMU1lQ1hPc2RJWkdl?=
 =?utf-8?B?RTRBUFJ4a2M3OEZwZXJ6RzlOMDh0ck5ISnVQdXJnRUdnOUlzbkY2L29aTUpQ?=
 =?utf-8?B?TXlGNENyK3orUW5vM1dLQTk1R2ZuZ3g1bG1RQmRZRm9oTEJCMlhxck9VQUNM?=
 =?utf-8?B?bXZTQ0E1L3FJemxWSWtmNXpXTlMvM0k0eTJUdHZ2ekR6WGhEL3RsSmFNSHlJ?=
 =?utf-8?B?N2NPU2YyOVlOYWVuc1F5S09BR0crRnY0OEVLUk5rY0FOZ1Rlb2liMjBuQ2lI?=
 =?utf-8?B?OHg2RWRuZWQ4ODFXZXFTcFJ1Y2hRTVVBdVZwUmYrQWxwRDFBRytGOTJaOUNL?=
 =?utf-8?B?QkJNTXRxVU5tTFdVL3ZlbEwraG9qOFdhU1hsd1FWL3M1dkxJNzJ3RVNycU15?=
 =?utf-8?B?NGluOW1KZFdYOUVRNWVRVGlTZXNpa214U01qUHByOTR4VG1xTDV3RGFaVGhY?=
 =?utf-8?B?d0MyREdKaVlleUoyMUwvaW8xRGNGMVNoK1VlVXlrQXQzU2Fxc3IvcFkxMjdP?=
 =?utf-8?B?NmtzTEZUTWhmVkZtSGV6bXIxb2w1R0daSXovOVZhTHYwMXFCNStPSzlOMU1i?=
 =?utf-8?B?T1RYaTdIWHB3WGJEaUxCaG5zK0NDNlJtZkpSeUh2U3hDOEdLUXpodlhibUtw?=
 =?utf-8?B?dWFIOGRjVEpaUHViV0Ria2lSSW5yaGY0MlNEZ29ZTUNRdWxBMHVHNGE0czRv?=
 =?utf-8?B?TTFJN3FRU1JCWEpTeUxwSzQ2T3BWYTU0YlFPcGZaTlFZbUhadU5ITUVoNi96?=
 =?utf-8?B?YlMrNTM1T1NxQWgwWUcyZHptSkZETUI3R0YyRm5FM0h2SlhZTFVxQ24xV2hI?=
 =?utf-8?B?a3V2OGFZOWM3Zzh6dTBodjR3UUZGV2FhM3ZGSnphR0JSUW5pWGdzTHlablhT?=
 =?utf-8?B?OHJDSVZJaVJjRnlaRm9CZHBaUW9ta0V3TURVbTQ3c00wUndhdkNGV2tKQnBo?=
 =?utf-8?B?M1NVdDBXRlZtbldOb2N2NVhPTzRxVU1xVWlxR0tMWjdKdUk4VmZWZC9FVjd6?=
 =?utf-8?B?VU9peFVLbmhCQjRrSW9ucWVOUXlTYnI0a3pSSStpT0ZIWWdKcG9zdWlpRzNn?=
 =?utf-8?B?SHlvbWNsZmdmdHlpUFdiZ2UrSkpCeWpicGUycHNsMTM2MVhIWVZCYk9QQ2E2?=
 =?utf-8?B?cVh2QzNlamVEODdYWmJOemUvZTFtSjFaUWtDZ2ZUNTRuQTBUNHRqUXk0T3Fx?=
 =?utf-8?B?Z3I0c04zelU3Y21uNjZpNkN3djhnNDkySjNoOXpiSUxBclFHTWtMN3lCQUUv?=
 =?utf-8?B?NU8vaVNvVUFGOHR0YUZZVmpkaytVY0FFK2phTDVmcDhqWEtiZy9QQmdMb1JT?=
 =?utf-8?B?V3ppc2dYN0UwSnpZSHNYbUpkTk1kL3RqaTB3OFFhdng4Ym1SeTNVSVVPRTJm?=
 =?utf-8?B?UEpubTdCVXRxbDVVSjJ3L0tXUmtaUU1TUm95OUZuV1pwLzNxS0hXU0tWeHNM?=
 =?utf-8?B?dkpFajlsMC96YVJmSm9KTVdoUzU3VjdXODBQNlR0cmcwY25uTE91NnA2WjJP?=
 =?utf-8?B?eEZ5VHA0MjlQeUhkMHUrR1BHZkEvdTdoamFFdXN2N3VPSTA3NDBCdz09?=
X-Exchange-RoutingPolicyChecked:
	bM2FUbQy4agw+L5lUxp1LHakJcdDESdN89zDCOnFEWgtzcOOyUwNhz4rxvRNIH/uO8W7ZyxfmTJ7IO7MLuoBUGAQYG7gZ6kzNztthTWeqKGR83QdJxGVhUAT5qWY8IjXYAdGbdPWgruUF9QhQtkP578nRkFMC77rq7AOcgGow4U6DgybtvZUlV6PiV81rQRm1oFrleKr8/JyOoin24zmjGgeUwpzQT8CwhjY8IyU77gL/4uY14+F4OZyDB8QPNEvd6sb+Knz4RLLWGDNqbpD4qzdkHZ2iZvW8Z4edm7HbqCnV7aHxZeY7nXkh7r+/Vgu9hqk+SfUDXortBkG1ITGZQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W0nhpdJ7dmrjamyTdY4h0XpEexUKrZhtd3qgDT2fjfN3k82tIhgRGtM3fSRGgLdnae6uoc7lKjVBnCfHY3BBU/47OQqXPHCN90V/tGl4Hz2ac1giSYeWj/oNvbwVnBzFlnmd75O0esIt3BfbucM3WsTshItQhAMn5LybfRP1BJUQnI4K+KoyDJdY5ou+WbMOZ+UNB0XJRuF+yMXkXlUTbl9HTE5f/KNxXliym0IWNBs2vSOU0qyizlCrOWM8Ej1o1I0V2U8+0HWNg+ImVrZ3QVJUXtg7rwPYNL/8nD1uHBJ1AkWXjMQwLQcGIWXsIGnaQfYEeyYZzBZNQQgsuonWqvEA28GBqWxSbsynFIBfycLr/tBs5Dn8yZhWDgqOsvVdFztAVMT5wDGSNoAQlDWKV/EaXv57FGIhTOXnwHqtDMgKW+aDXGYjX9JY+eNcEgtIYG0ooImvwnWcCiLwlXg14DjIDQ9rajquodF2VKPgQQAIm367bL4gIWB+9tY4WUT+S71bBvNIutFlqxu6yBdEgvom/D9CkX1hQTqeh9YP4T1HJHlJb8fdiaADcrJTbRtg8NSzKeQppaJ3HwVdq9Y6WyeASVsdLVJvuvZHtdq9M/M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8677e581-e944-4d19-9212-08deb1dcedf6
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 17:19:17.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxl5WU5LA15aVtUhvpKnVEV81geuYd1QBUa0At4ntq1TPCx8aYeHyE+xrRAnBq/YQo7ZkxGaXw2RcqghIJetdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605050000 definitions=main-2605140173
X-Proofpoint-GUID: IUmdUPEgE00_P87hi_rcNuF9nsE1HJQS
X-Authority-Analysis: v=2.4 cv=OOwXGyaB c=1 sm=1 tr=0 ts=6a06041e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=mSL4vKgbci0i8IzKtOcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12299
X-Proofpoint-ORIG-GUID: IUmdUPEgE00_P87hi_rcNuF9nsE1HJQS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3MyBTYWx0ZWRfX1BTQx54JnGSt
 VkvYWCuXKCDwBDKSXKPWIyUdmF98F1A+S7ZhGXv8XOZRyLPbzG8o7a7v/y6h41e99PyWzJnm9nj
 x6mWBh6aYhVyuwPaeLSF2GoZq6yZuqbmiWu0Zt+SsPcLhE70roh90xsAQKcXJPcmXzqu5tLclJb
 bapxqzbzzFrWG1QN+9ViYYUGc+HmEmrRCeSBT1HxQ2rBm84OQc9E9u2sICM6hjKzhlJqubYy0Cl
 KD74FKkDEKqdmYM3XUIBBaGeCYa3rGft+e4RAi2JLn/iq3eb89IgdliDyF4//s0nz6Odw50r7tu
 9gFlZj3GV9fRRJtHBth/QtSN24vpdzXxvn3uZyhrIDQOwe41kZQq/0HCADMgEBGCKvPkSslQcET
 ihv3rHMExMGmYZ5CR/VckbCebmeoePZc/2n9V26IEZQ+DZtD6lIP3oSClbSlUiBJoiLkCdeUYtU
 d2sPTIzqdgH+cpi5Dg1oNxdlRECYt6BUChvn8V60=
X-Rspamd-Queue-Id: 652B6545278
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21615-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid,oracle.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action


On 5/13/26 5:25 PM, Darrick J. Wong wrote:
> On Wed, May 13, 2026 at 10:28:31AM -0700, Dai Ngo wrote:
>> Hi Christoph,
>>
>> On 5/13/26 8:50 AM, Dai Ngo wrote:
>>> On 5/13/26 12:01 AM, Christoph Hellwig wrote:
>>>> On Tue, May 12, 2026 at 10:21:53AM -0700, Dai Ngo wrote:
>>>>> A single LAYOUTGET request from the client can cause the server to
>>>>> issue multiple calls to xfs_fs_map_blocks() for different offsets
>>>>> within the same extent. Because the use of XFS_BMAPI_ENTIRE flag,
>>>>> these calls can produce overlapping mappings.
>>>>>
>>>>> As a result, the LAYOUTGET reply sent to the NFS client may contain
>>>>> overlapping extents. This creates ambiguity in extent selection for a
>>>>> given file range, which can lead to incorrect device selection,
>>>>> inconsistent handling of datastate, and ultimately data corruption or
>>>>> protocol violations on the client side.
>>>> Please also add a check to the client that catches this and doesn't
>>>> use the layout that has extents outside the requested range. And maybe
>>>> warn about it as well.
>>> The returned extents cover exactly the range requested in the LAYOUTGET
>>> op. However these extents are overlapping. For example, here is the
>>> on-the-wire capture of the LAYOUTGET operation and reply showing the
>>> overlapping extents:
>>>
>>>      Network File System, Ops(3): SEQUENCE, PUTFH, LAYOUTGET
>>>          [Program Version: 4]
>>>          [V4 Procedure: COMPOUND (1)]
>>>          Tag: <EMPTY>
>>>          minorversion: 2
>>>          Operations (count: 3): SEQUENCE, PUTFH, LAYOUTGET
>>>              Opcode: SEQUENCE (53)
>>>              Opcode: PUTFH (22)
>>>              Opcode: LAYOUTGET (50)
>>>                  layout available?: No
>>>                  layout type: LAYOUT4_SCSI (5)
>>>                  IO mode: IOMODE_RW (2)
>>>                  offset: 122880
>>>                  length: 65536
>>>                  min length: 4096
>>>                  StateID
>>>                  maxcount: 4096
>>>          [Main Opcode: LAYOUTGET (50)]
>>>          Network File System, Ops(3): SEQUENCE PUTFH LAYOUTGET
>>>          [Program Version: 4]
>>>          [V4 Procedure: COMPOUND (1)]
>>>          Status: NFS4_OK (0)
>>>          Tag: <EMPTY>
>>>          Operations (count: 3)
>>>              Opcode: SEQUENCE (53)
>>>              Opcode: PUTFH (22)
>>>              Opcode: LAYOUTGET (50)
>>>                  Status: NFS4_OK (0)
>>>                  return on close?: Yes
>>>                  StateID
>>>                  Layout Segment (count: 1)
>>>                      offset: 122880
>>>                      length: 77824
>>>                      IO mode: IOMODE_RW (2)
>>>                      layout type: LAYOUT4_SCSI (5)
>>>                      SCSI Extents (count: 2)
>>>                          extent 0
>>>                              device ID: 01000000000000000000000000000000
>>>                              file offset: 122880
>>>                              length: 53248
>>>                              volume offset: 339460096
>>>                              extent state: INVALID_DATA (2)
>>>                          extent 1
>>>                              device ID: 01000000000000000000000000000000
>>>                              file offset: 122880
>>>                              length: 77824
>>>                              volume offset: 339460096
>>>                              extent state: INVALID_DATA (2)
>>>          [Main Opcode: LAYOUTGET (50)]
>> After reviewing ext_tree_insert(), with assist from Codex, I think this
>> function handles overlapping extents properly. The only issue I see in
>> ext_tree_insert() is the accuracy of the return error code, EINVAL instead
>> of ENOMEM, when kmemdup() fails.
>>
>> Since ext_tree_insert seems to handle overlapping extents fine, do you
>> think it's worth it to fix xfs_fs_map_blocks() to avoid returning overlap
>> extents?
>>
>> IMHO, I think we still should fix xfs_fs_map_blocks() to avoid any overhead
>> and complication in ext_tree_insert having to handle overlapping extents.
> I don't know enough about the nfs blocklayout code to say for sure, but
> it seems like you want to upsert the mapping returned by
> xfs_fs_map_blocks into the "ext_tree" right?

This is currently done on the NFS client side by ext_tree_insert(). The
question I have is should we enhance the server side by passing '0' to
xfs_fs_map_blocks() so the client does not have to do the work of
handling the overlap extents.

>
> And by "upsert" I mean "clear out any mappings for the (offset, length)
> range, then insert the new mapping", sort of like what the fuse iomap
> cache does:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tree/fs/fuse/fuse_iomap_cache.c?h=fuse-iomap-cache_2026-05-07*n1682__;Iw!!ACWV5N9M2RV99hQ!LP7Lgbj10myml6rtWPCyBcfoKlvvpS39fLQ4Dy8puJ9c8ZQbxV6ToyYupyVa8TrICy--mS-sUwGxrA$
>
> or I guess the xfs scrub bitmap support code does when you set a range:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tree/fs/xfs/scrub/bitmap.c?h=fuse-iomap-cache_2026-05-07*n395__;Iw!!ACWV5N9M2RV99hQ!LP7Lgbj10myml6rtWPCyBcfoKlvvpS39fLQ4Dy8puJ9c8ZQbxV6ToyYupyVa8TrICy--mS9n7W3nLw$
>
> But as I said before, I don't know if "two mappings retrieved in rapid
> succession that overlap" is actually an NFS error.

As far as I can tell,|nfsd4_block_proc_layoutget()| correctly advances the
offset and decrements the length after each call to|nfsd4_block_map_extent()|,
which passes the arguments through verbatim to|xfs_fs_map_blocks()|.

-Dai

>
> --D
>
>> -Dai
>>
>>> -Dai
>>>
>>>>> Also drop the check for (!error) since it was checked after call to
>>>>> xfs_bmapi_read().
>>>>>
>>>>> Fixes: cc6c40e09d7b1 ("NFSD/blocklayout: Support multiple
>>>>> extents per LAYOUTGET").
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> ---
>>>>>    fs/xfs/xfs_pnfs.c | 6 +++---
>>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> - This patch is based on top of the patch:
>>>>>     xfs: fix use of uninitialized imap in xfs_fs_map_blocks error path
>>>> The error changes should go into that patch, so please resend it with
>>>> that fixes.  Maybe as a series together with this patch to keep them
>>>> together.
>>>>
>>>>> @@ -172,6 +172,7 @@ xfs_fs_map_blocks(
>>>>>        offset_fsb = XFS_B_TO_FSBT(mp, offset);
>>>>>          lock_flags = xfs_ilock_data_map_shared(ip);
>>>>> +    bmapi_flags = 0;    /* return map for requested range only */
>>>> Just remove the variable and hard code the 0 in the xfs_bmapi_read call.
>>>>

