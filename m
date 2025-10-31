Return-Path: <linux-nfs+bounces-15850-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F59BC25481
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 14:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314D5425AE5
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD74220F2A;
	Fri, 31 Oct 2025 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cNoScTMT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F4Oe5DNd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF798221264
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917916; cv=fail; b=uPxXcQgkq7Sa3sZwhiVK32dpA+GRHNdBTIXMp2K7ltU9oiQwgz1UsdOUeAEP83YQfsoCKwb6h3H4JwBzvU5xHvbeD2XDFD/8mA24ha/v9/SqweBkg2prXXnIx7qyW824R0YrkoK8ggkOQq5unPA4lh4ra+0BH9e3aXrETRs8u7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917916; c=relaxed/simple;
	bh=gyQfudQbU5kbKugdk3setHxbNbx+aUqe7OL4yzK4JoU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BQUuuzuFLOTQZiDO+LryExSVZc9smO+gN9CezUCt9oTOOWPnuExfrcgGGqfg6KSv4fgX4Yxg2fdwTPG2LOAdXhPc+JOwUJK5kEsjmPsi6T5uW8fEqYIXqxH7i37RDN7B0DQ51pI/n4itNmcONxVrgkwbK9GGby8v6CwyE+f+2/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cNoScTMT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F4Oe5DNd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VDTOVZ001532;
	Fri, 31 Oct 2025 13:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dV8DWNtKqqJr1IqCLiVEgwhHOiNHKn0jT7YE3YEhy1s=; b=
	cNoScTMTFCsKCRhSzaG2zSSszxm50TTD8KPZaLD0PkymOSRL+smouGwmv+B6BPv9
	fMPLtB+pGbuAbSE0+E77M0HI9kxTLHdJu6Yx/3BR63Hjp84rjbzzDDjZM1fDr/QH
	oiUkyevlKABzHitKQ9ErnneWN2ZxthjpmIyK3Jg46aoRY1W4m48M0R/8B45yKIJx
	4LmKTQJYsql6rjUj3Or6GotVNH36qVAwEIw7t7GhGtKp9Zv4jDZqMaNMgAYWHXAM
	Maizcv/7nLOZ3DomYqXENSC61sXDn8T4Vdx0XgH8OIkd/vw/YxrOL4hOPB6vkO4h
	gM4EvKFkYmgB8bmL2oWhNQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4x1s80mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 13:38:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59VCSUpq004264;
	Fri, 31 Oct 2025 13:38:17 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33wp12t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 13:38:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqpEDopyIMZf9wDlpuq4PKLt1DwtSiAtwVEq14fO+shRjX6rNaKp4kS16Pd87qJ4s/CESFZeTXbdXDCmYe25pqPr5XZxrRO5neuY9gGmi1gi9HVk663GlAKhd6HeEIASswhg8ObyTImm+gQ8hXXBEqe9wa4f/k67W5nFUb6d2SRyy7cteJhNaKoOmHwgYEEx9QeB3vioD3agN79AA3QmfOZAua3Ayy979/cJBimwyTlz2otjH6pF63cHTJMG+LPU7Wz1zoTX4aMCAEwleARDKgpdi/gRa4uhLOixlucVwOxHqNR6RNeyuxBrYHcF+TG5VyGr7G16VmS1i5AQxaXqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dV8DWNtKqqJr1IqCLiVEgwhHOiNHKn0jT7YE3YEhy1s=;
 b=dbPU/w5e1cipApZ3rU2w67nO6To5xxyeHBY3WDGK1VVOGjdkSYO3RjByCgQ9Ht8WTMlzmPy4+3EWZCFwt0NWXms2GiuNxYTSoOXCQECgh9mwDME6LOI8AuxeH7tftocZ+FepGM7AVgVUslVJ7uj5+6GPo/yM925kdJnN+Z+QMQaZjB9Qw+hnDJ3lvv1aLfo+97ClPp95a/n5CdXFK3At1zPIIBqKsJOx+iGOYgKTg4Gt+dhw6I6XBL4kMemoLMoSL+xGUNyTxvdP8VNEBN9evadfKRHbGhZCes9InfN+QB1PMwLEN+zoig9nrP8AmU0KYdyW3BkVz5kK0hqf4gHOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dV8DWNtKqqJr1IqCLiVEgwhHOiNHKn0jT7YE3YEhy1s=;
 b=F4Oe5DNdaxojhE/IlLtnsyUO/dx4T0x1F8iP+VAXFsE3y734NGNQAU7UWxhbRAgxhl+7pmRbyh4NCAuEGfRg8bL6KUOwB7GS7/BsuZ+wbdlsanNG0+HjudUp7WS4nDg5g5qEWRE+OyNovXQ0RBIKck9M4B7E4Qll+G1HKh3E+Bg=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by DS0PR10MB6776.namprd10.prod.outlook.com (2603:10b6:8:13b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 13:38:00 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::c86a:40f1:7833:ef3c%3]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 13:38:00 +0000
Message-ID: <beeb6d6d-91d2-4017-82b0-294c762e929a@oracle.com>
Date: Fri, 31 Oct 2025 09:37:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFS: sysfs: fix leak when nfs_client kobject add fails
To: Yang Xiuwei <yangxiuwei2025@163.com>
Cc: Yang Xiuwei <yangxiuwei@kylinos.cn>, trondmy@kernel.org, anna@kernel.org,
        bcodding@redhat.com, linux-nfs@vger.kernel.org
References: <07314e0f-76cf-42d8-b729-a6b61f2fbad0@oracle.com>
 <20251031022906.1381844-1-yangxiuwei2025@163.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251031022906.1381844-1-yangxiuwei2025@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:610:38::15) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|DS0PR10MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: c6326508-fa25-437d-95e3-08de1882b5ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVI0MXBFdmVoTFF3L1BYVUtyV2d1NFJ3MDdmaXpZTFI5QzF0N0tYUDM3OVJh?=
 =?utf-8?B?a25IL3NzNTZYYlJUR1RpU1FXVG94aDJ3Qnp3M0EyUEJoc2Y1cWJuK1B5Wit3?=
 =?utf-8?B?c3lBWlFBZUdrbG5FV0pySXhWTlpFdlJ2LzdJWTV5bTVBdzVTazlDMzlhWW5L?=
 =?utf-8?B?bnFqMDVUbjB3dFJxTUVtdkVQaFlqOUNUcjl1a1l1bHpNbEwwVFRwNFJkNmF0?=
 =?utf-8?B?NWdZVFlBOTBIM09KQzRUTVBsTDlXTy9ld25NbGNVWjNlU2E5ZUY5SGlPQTkv?=
 =?utf-8?B?ZC90cE1RVXkxZUU1c1BXdWoyUHdUVW9iVnl5c3hwRWpPK0FLTTBUUnJueVo5?=
 =?utf-8?B?dzdRamQwWW83TFBTMjVsSWYyM1h2VCs2Y3BNV1RRbFFhZTlHaFQxN3JNRktI?=
 =?utf-8?B?VjJPdGRLT3VmMmhYNWp3RDFvdW9IM1RDQTdxUWM5aUEwaVhrakc1N3psR2Zr?=
 =?utf-8?B?ZEFIeFdYT3A4TnN1ZzJ1dk1qTjJjMENLT0N2cUlkWDN0MkVPVWNOY295TjJz?=
 =?utf-8?B?Uk5BdUxHalB2RTBvWWZMWnEzSE5rTzY5OWZ1dVpuNWhKSU9PRHB6UnJxeFR3?=
 =?utf-8?B?TEE0UnExSjdXL0hJYjJ3VktMZXd2UXFyeklaYmIvcUtzSlVyTlEvZmxZTUtl?=
 =?utf-8?B?b2VqUTR0UFV1Z0VqRnVkRjZFa1lWbENpMWZPVUhOczdhRzYva0JkQ1VSTzJ3?=
 =?utf-8?B?Nk9QNjNSMk5TT3FlRlhXL2RnemJHL3krQnFkdXdXVElSbVdmNEZqQ3hSblN2?=
 =?utf-8?B?RnNTNEJqb20xWDdQY0lqMm0yZlBOYkRvYmJWL0plYjdPaHhTc29RT3VuaTVX?=
 =?utf-8?B?LzlEaGI2ODJ3bGhnM1BmQjJYeHYxS0JIOWdkK0IydkgrY0lZOTRxb2xZM0p2?=
 =?utf-8?B?aExSVTJ1cDVhUG00WDRxekVzOERxM3NoVzJrWGtnTDIraDhtWkJia2lMcWt3?=
 =?utf-8?B?a0cvZXhhTFh0V3NmVWxGR1MrNUY0TWFXTWhDem91Y1J4RHpOaCtmOTBGTExK?=
 =?utf-8?B?Umltdmh0b2w5ZCtQU3k5akpOVmFxcE9ZczhkWDE4VVlWR1VGME9YOFpwVTQx?=
 =?utf-8?B?ZGVITXJiSUxMcEViTmJSbm5nN2djMkZVT3hmWUZMZlJVdmlIaUcwWkdGTTBX?=
 =?utf-8?B?cVo2MFZwNTE1VmlrTGNIMTlQN2ZTOHJLY29KOU90QkIxdlR2TmtLT0pGRThS?=
 =?utf-8?B?OU5jZHBNZ29TYWNlQXdXbnFGMDc2V0RQR3ZVdU5TWHVIaDBBd2Vud3NGamhj?=
 =?utf-8?B?WERUU1lwUW9qSTQrOE9TUGF4Y2tHbVpVUGd4UnhUTDYzaDZGbjBRTklCeWx0?=
 =?utf-8?B?aVBWMlN1Y0ZlSkhCZWVqakhDamxKM2ZwN2plaWlrRGNYeUJ1RDZCdXFPZHJQ?=
 =?utf-8?B?MEROR3RoaFNpOE9iR2hqd2RFQWhybTRCK2JBY0U3bUdDV1Z6VFJIK0UrT2Nj?=
 =?utf-8?B?SCtiNkNDWGZWTzFQb25lUXNUUmR1Sm1VVDFlOFFXNEdzNGFNNmdkWlNJUitl?=
 =?utf-8?B?NTIwMU1zS1R2TWpaeWJmQ2pibGpqNURJZWNmRDJNTW5RNmJpZGp3aXorL2xl?=
 =?utf-8?B?VU95YXlwdTZaMlQ0ZVpYTTFrRGEvbHJOMEJVR2tBN2pWVHZlcktEMnJ4eHh2?=
 =?utf-8?B?dHpoMTdITDFRNE1zQjNNTkFCSzB2R1ViVDBTaFlETTI0ZkQ0aVFUK01RaGdJ?=
 =?utf-8?B?d2NCRDkrbXFWQk1BMVhTWlNYRGZaaGp4MHRCcCt6aHFOL2hCUlo3SUhzcHZW?=
 =?utf-8?B?aUw4Nk9WNWprZkZFb0gvbklNbGkrWmk5b25qV2RLTXlXcXN0bWJvY3MvWTBo?=
 =?utf-8?B?NmMxVHY0NDRRQzlvMENwT3R0NjlqSWVjL1E3UC8ySmhpMEZDZ0lpcGlZS05B?=
 =?utf-8?B?SGNxb3hOQnZzeGFwMWl6ZUFBSmFZdGhvSzZPSVVSOXYzVEhRVG5nNE9UUnVo?=
 =?utf-8?Q?PQscraigA+kPN00CpwjFYoW53k9Wc/VW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUIxa2xtSnlvWkJEaThMdzA3NTg0QmcycmJzT2t3L25STUVXbjlOcFUxV3JY?=
 =?utf-8?B?QVR4K25JbVhuTW5FSVlGMWM4eXh4SmpJT1RrU25tSHNJRStLZGRDY0IvRkda?=
 =?utf-8?B?MDB1Tm9CQlNyS3NpUUtqMWduSVJYa3dvMHBUL25qOWpsVlNiSTJha2d3MHVN?=
 =?utf-8?B?Szd5OHl4RTFZbUpBdkVRN1dEOHdTc2dWZGpQL1NVRVZSTmhIekFpa2kyVEE4?=
 =?utf-8?B?VGtJdTBOdHJ6RUEzU0F2U29nVGJVUW1lZ05hU0ovQzliUUhuS1A2cTNSSXZ1?=
 =?utf-8?B?cHBocDdaOElWWVRvbnJjcUQxRU5nYVBzT1hqd0hsejc4OGFsZ3RTWnYzN0FN?=
 =?utf-8?B?elJMdEo0NG1IU0phM3A2Zm1DQitzVUl4eHZHaDB6Y2prbmhqdmtTRWtUYmtD?=
 =?utf-8?B?TnAwaWo0UDdMNHQ0eXRhR243S1EyeW40UCt6TlZEVWNTcTFwNFIzM3c3RG1L?=
 =?utf-8?B?eTdscGxaVmVzdFVIY05Vdno0akNpZ2d3U29DdmVhOWRPZlpadWZoRDVKcWlW?=
 =?utf-8?B?Ulg4aUtwN0o1UWQySnBSMFlnTWc4TjNsM2NiN3N2MGFOaWZZeWFyVEwzNFpj?=
 =?utf-8?B?K3RRM1c0S1hscmUyTm8xY3k4ZFI3ZFF0YWt4VUlLeHRtUU9xbXh1MENoYUVx?=
 =?utf-8?B?YyttcEZ1RkRNclB4YTRSYVU0M01WNzdxVXhuaDVrcnpaaEJvaEM3citxdGh0?=
 =?utf-8?B?QlVJSitCZ1JzTVdWd0hTMENINW5hWGJPVUNGWC9kV0sySlVMRkdSZE4vZ2lS?=
 =?utf-8?B?QU5ROVZFaGkvVEhydDAwd2dWRFVtYUltbHJTYm94TzVSa0V3YkgvODE5RGg4?=
 =?utf-8?B?a1l1WHdPQ3dGTkxDTmV2VWNhcHduWkhCR2xKRVJTY2V6WW5yNE9EN0sycFRB?=
 =?utf-8?B?ZVk3U0xHbG1ySFQ1dFpSTmp4bERjM2pxdDdhVlNYRXp3MkV5TEN2cUNzTzRr?=
 =?utf-8?B?YXFBUjhRYTc0Q1Fzb1dQeUN1NXlqbVJWNjdkbEVZYnluZ2R5T25GL1B6Umwv?=
 =?utf-8?B?VlJSWXFxV1JiU0hXYXdWeUNDMFQxV2t2S25oeTMrcTZqeWpkbkNqS0ZCb2hp?=
 =?utf-8?B?cEs4bEE5ZWRXR1R6cnJxUVBxMzhyMEI2Nzd3b1ZrZHB5YWkvNGhTK0wrdnRY?=
 =?utf-8?B?OWd3ZVNjTmYyZUh1cExVTit0UHJ5bTRZQlE3L2Z0Rm5KMnlPK0Q5VmRVUG1Y?=
 =?utf-8?B?c2pyOTVnajVBWFIyNHg0OCswcUV1cnJNNHhJY1NLYXllZ2VHNFFIUEN0M0RM?=
 =?utf-8?B?cTF1b3pkeTV0WDBPc1VUNzEwUTNWL1gyZFZMSlV6ZlkrTmZzNmMyYURrSGdx?=
 =?utf-8?B?UDMyMmRtTERxeTQ3L3c2N01TblhpRm1MZDBCb2J0MTRwV2pUTUpYb2FiK1FN?=
 =?utf-8?B?dU5rTytxMGFZMlNGbnZrbUR1cXg1U1Fvbk9Zb095eEVkT2dYUTdiOWZOSXRo?=
 =?utf-8?B?RnA4RGtvaFdoUG93VkN3aXlKSUQ1eU9zTmo2MEtDQ0pCRGNPTFE3TDYyRnB3?=
 =?utf-8?B?OFppSUNkUThuNjVESE0zdEVrT3E1L0ltT0xraWk4RWk0d3hVS1ZoWm1uOHho?=
 =?utf-8?B?aHc1emdvaElOVjR3bWpyOTIwOUw5Snp0RkNFejZNaWdOUlZQa3BvaXAvRDZL?=
 =?utf-8?B?NkN2U0pUV1hINUVzemwwa3kwWEt1SENib0NyQ2t0dzBrZk1xQTBtclRoUDhi?=
 =?utf-8?B?QWx2MjUxeDJOSXNuRG5hLzVlRHc0MUVHWWRSUnU4OTIrcVlOd3lQZ0crUkJr?=
 =?utf-8?B?d3VtZG0xTHF5NTlOMmkvNk1xY0djYVQrbEliK3VNc2RoK0Q4MGs4bkVXS1Vi?=
 =?utf-8?B?Qk8vN3VDTkR4MktXQU90cXprODFzNWV6NW02Nit1TFZDVWdkcXE2NS9aaUFp?=
 =?utf-8?B?VHBydGVqbVBtWkU1YjdsUmJleUNiM2NJeTZDSGQ4QlBuNFg4TFpIYmVlckZu?=
 =?utf-8?B?Rkd4a3hkam9LOXFIV3NzelZ1WSt2T2tqaXFqRXZoWlRtTzI2MTBuS3dHVHB0?=
 =?utf-8?B?WlZDVnhFTXJSZ21qRWVwN1pMc2cxS3VycGlEN1B4WHdzeFRuV1AvVmxWUkgx?=
 =?utf-8?B?eXBGRDZseVVCYXFmK2p2K1p2aXV3Ukxrb01TcW1NTGkydGtGVHZtOU1GOEdF?=
 =?utf-8?B?Y0hKZE1vSjhNWmxtZVZmREt6SHYvQWZHNDMxRmFTVWVTdUM4OWtHaTBhYlNs?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SyN9/QC8p8OBO4zJNYSO6Z/AkjTv5pPFufPTKYV0t60bDKtDPEReOdQXN4ePiOQDdQJUMiwXvRoCh2+S4WbxHIgyfkyGe/uc0DmpnBsZDMY5Q3Ioef1epQckZztNNipx0DkYHrYm+O9WjhoRlp3sxW8v6SbwawcwurDg96PhFTNjGdy0qe108DZcqAxy1L5WDFP25RpIOi10FGWIn7a8EfSdpUAtMo41TTAlcRAFwZHmAnLKYzOWk/htkdX23EwrHnBq9qD8sFOk5pJkwGhQHoRIpVvn4AOgYAzKiB3gXBJHlPPSeagLc8tyChHappVnmptaMNutETRZ87FfTcFB9YGwjTNAdQfgJFhIqh0/SLbkzr14VY+kCzKsnm93bhTUl6pWx0aUmnM27izpfTPuJyVxzZsvwwi6OjnFRMhzkPK5RSlyjwu6ATmSuirnl/TtcMmFbw9fNBZxY4hhoRhQYxW/hBxFcDD0/St67Fmry5+w4qFue6lDG2bZUymn1bNqm/i5kDHjAmo6ty3SeEfD72jVVVxPXkyrOMV9hP2vj4zxtfs0RLo2EYxL9cL7afPzmPV+IJlfd368VWHNK3y2EgkEAm6o50vzrzCRMe2WaKk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6326508-fa25-437d-95e3-08de1882b5ae
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:38:00.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyU2NqsVQGguUJrEb4KwQjgacrw+wnZi0HD36/Jnysyu4p8tyl2TMYE6zc9gc5MgBYPWcEgZtxSNFAjdemlAZysL8olcpIUfVZbREvcaLBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6776
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510310123
X-Authority-Analysis: v=2.4 cv=Us9u9uwB c=1 sm=1 tr=0 ts=6904bbca cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Bn0Dk3kZXEeKybvmwP8A:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 98LNjRChg8USaTZB8-TitA4mm5lvaNdf
X-Proofpoint-GUID: 98LNjRChg8USaTZB8-TitA4mm5lvaNdf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEyMSBTYWx0ZWRfX8gEAfGyUBKnC
 QnICWAaIGBlXqoj7+vAgy1k4eHNC63eXJxpSJT9sh8gklDIror+SvSxd2WsNOVMuTRzzlOA651b
 aXcj8RQPCvRLncj7r8z4ZsfZLTtDFDKbKJUSiOoKc3runMpsGV2hQSOdPBZWGw4RlpGY+eOyejm
 FRWBxPUnMKRZMa01VSyPVBuiasLWDGp5AFDCozqPAd5PgA/4zc+5vRbSX9PLZVDpaagUwQeXhg2
 i9Ba8eG+otgn622c8w40guYa6SlZxKLOtEno3Z5hGsEM3yzv6sGON6OTVPldXaJCm9Gg9VVItua
 TIf2M+D/JKa3UP3uX3CL4rYNrsTdcbhMuyt/1D6Xa3W1YzCjzBqbWVPn3oj0ZSQVikp0EGhp3cy
 cqI3LBpugo/hoyTISwwg+vg1CvfQjw==

Hi Yang,

On 10/30/25 10:29 PM, Yang Xiuwei wrote:
> From: Yang Xiuwei <yangxiuwei@kylinos.cn>
> 
> Hi Anna,
> 
> On 10/30/25 21:13, Anna Schumaker wrote:
>> Good catch! But I think there is still a leak here. Don't we also need
>> to call kfree() on 'p' in this case? And also if the first kobject_init_and_add()
>> call fails?
> 
> Thanks for your feedback. The original patch should be correct:
> 
> First failure path: kobject_put(&p->nfs_net_kobj) triggers nfs_netns_object_release()
> which already calls kfree(p). Adding manual kfree(p) would cause a double-free.
> 
> Second failure path: The patch adds kobject_put(&p->nfs_net_kobj),
> which triggers the release callback to kfree(p). This is sufficient.

Looking at this again (only with more sleep and another day of recovery from the
cold I've had all week), you're correct. The release callback should be handling
the kfree(p) just fine so there isn't anything else that needs to be done.

Sorry for the noise!
Anna

> 
> According to lib/kobject.c:443-444, when kobject_init_and_add() fails, 
> calling kobject_put() is the proper cleanup method - it will trigger the 
> release callback to free the memory.
> 
> If there are specific edge cases where the release callback isn't triggered, 
> please let me know and I'll adjust accordingly.
> 
> Thanks,
> Yang
> 


