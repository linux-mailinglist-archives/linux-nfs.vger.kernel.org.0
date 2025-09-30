Return-Path: <linux-nfs+bounces-14830-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ED2BAEA04
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 23:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABFF189E522
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 21:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F45F22259B;
	Tue, 30 Sep 2025 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XBINiXCn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xhgtWIoY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C61C860F
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 21:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759268510; cv=fail; b=n01QLo9ebr+UDmvX4ZaODp7wY6CvoByVJcBtPCDdVG/eiT0dComMM6N+q9q4Ycr0a9NbCDzbrZ4ByeCyDaq0KtBny9yAYI6UEwMrqkqfvh8aSn6JGYqGcrlOnjzqDpSlsQsHxkHxRZiXRTViJrgtxs1U3LKdiPXCnewgF9SE5ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759268510; c=relaxed/simple;
	bh=+reLmzS99oUvLnotnSlB7MkXA/+lleY4Nytywpr12so=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AriYUTQYas/TPoVth25Z5TSRHobFGEy00Ct8raYSxXMPwCtoNjPhgQeCZ3vsd1z78yHCc+/V4orpxmUaYxEY1HqZXJ/BVGIllvdoN5aQJEZ5XIxGSpjguqnKZADoIbQcl7nNqZ8nX1f2S7y1LslDqGvbrt+71uvCtEnfunFqXT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XBINiXCn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xhgtWIoY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKMkK6012633;
	Tue, 30 Sep 2025 21:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=F7voOY1Lxz81hE54gzfM5Z1ZKFRf8t2fN0PLIRcMvFU=; b=
	XBINiXCnqXQ1pJ4gsr9EZZ+B9ZMtwa7OIVaVCQyR5LbFYJlMoRzoY2ehgk2AAV+O
	MRO2pZGUaPYb2vJ4EKwz2e+6QoCcPl4EB75Zz2zwGk1ySNnmJ1KR6NRUKwDnQmL0
	qdNvVxM5uEy2wkn6jwkUtqfQ71rukKr9tlzSY50FiBeeydI0KmAcHVUO/dZQdTek
	YhdRscK5w73VKsnfpxUyGDwc5FX2AyKh3Y4z0/IyT2ukGeUZgkw9lhIJN5k0bSh5
	+WIbAQL1tSWTMilb6OojHsM6huZbHdus7/DNuHE/AGpNAdZ/3XO2gsI/mWmzo4se
	cN66Ktnpf/0YYK+kERJ1kQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmacrbhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 21:41:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKmSBh001989;
	Tue, 30 Sep 2025 21:41:37 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6ceydau-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 21:41:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWGr4IPknFm/4NvUXxVc5h9NBV5RXkYzS1trAljXhN+5YeFp0BudfaW/Bh8uBd6k4shWpnsf+P54DP7wA9SZtPyq33YV0rP/0/GkH213jdp/Dx8sMcmgpdz6mG0wj1MIQ6uST9UlD0GtxIYyPx1x94KyZAAMDRIfst9ahl46BLZsHJjrJ0SG5LH5fzBGQftIdWXx8xYKwSVOZ7v11EvWIozLmqt92i/i8AV6iYeEgQTjxAJlS6nLjkyUpB43tYjSUzkup00erIbYfs1tVKSrkb7W2hVxpnSau1EdRnvJ9O/GHsPCilXdavG8+yWEskhxUZiFsOxKELctJfnRHOYmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7voOY1Lxz81hE54gzfM5Z1ZKFRf8t2fN0PLIRcMvFU=;
 b=IBGVDjlix8jZgDFpm2ZGTE9XSJY+xg2rHAPpLowQBkW73mXKAxetlJjcU3Mre8e9kJMUD/fggmWiYlaAQhUjeYi1ORoO6tgLORedCQ0k/tahZmxnHmeG0IHathvUC8lIp+wQ9l3QPKAqAblGHOoedV42mMHZHjGBVPxKsd3Q6U29O3lKUjY16Rxy818CCFVStjGsrFQXpio5OhG4wdrLiO5cQUSYrQNsHaJcnQV6zORftnZMfrvZ8rm2Tf/KjvYCUhdF+v4YDkllHPQbbKqEm3k/FAdvo6J9g/KuxBKv7XUZyJFE3Y2yoI1CvpH2sQFDkdA2esdzcPGzSad2sDmBQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7voOY1Lxz81hE54gzfM5Z1ZKFRf8t2fN0PLIRcMvFU=;
 b=xhgtWIoY+gf1QR4t+zuh2/DByaAJk94gN2GrzJ8DxJzUHLDEUgame55PqYGNsfg67CBqLv20X18iCN8BiEsjZAvJB6bd/kpSmlcMTnlVvJ+hL9jjtMMxUrVzF8ranc3MY1ob1svLTNghWcWeFmOLged8kFNLphkMFrYzShK95ZI=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by IA3PR10MB8186.namprd10.prod.outlook.com (2603:10b6:208:511::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 21:41:33 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 21:41:33 +0000
Message-ID: <ddcea773-3d9a-47d0-b857-087655b2ec13@oracle.com>
Date: Tue, 30 Sep 2025 14:41:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Fix SCSI reservation conflict causing pNFS
 client to revert I/O to MDS
To: Benjamin Coddington <bcodding@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com, hch@infradead.org,
        linux-nfs@vger.kernel.org
References: <1759249728-29182-1-git-send-email-dai.ngo@oracle.com>
 <475D1227-CB10-461D-9EC1-A303B74A701E@redhat.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <475D1227-CB10-461D-9EC1-A303B74A701E@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P221CA0056.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::11) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|IA3PR10MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7df6f5-0076-481a-56b8-08de006a1faf
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?c1dZQTRuMC9uSitYZjhWVmxTRExRNm50dWlLVzRpVDJ4R1pNSCs0THZ3Qmxv?=
 =?utf-8?B?VWRTclRPZlk4RVY2UXUyYzM0aU9oNDc0RkpES0VycGl4cFNPOVRGVVFCRjNo?=
 =?utf-8?B?QmExMFBQR0FTN0htWjBraktVdklRWnV2YjM4aDNUQUxxc1N4VzZWOWIwK05P?=
 =?utf-8?B?b3pmMndKc2p4b0FXSVY2b3UwKzVZODY3dDBUS1A0NFpJNmlVcFB1ZkZ0d3Bk?=
 =?utf-8?B?Mkt2Nkx0czZQNWw3ZCtmWWV5NE1TcWpIeE51K3RlU2sxM20yR2U1M2FmUHRE?=
 =?utf-8?B?aWlGbDlXOHFkNHFWQ1AycWo2R0F5c0Nqbzdwd3B5eUpicTNxeWkzZXl5YnJS?=
 =?utf-8?B?UG5lOWVDNE9nVDhNd1RBWVpFaHRiZDYzNmFVeWxrK3pIdzJRQ3lMSTF0ZWlK?=
 =?utf-8?B?MHpFYlFTSFhPL0plT3NmcDdSOS9Tb1NBdmZmejlBVHY3TUpCeFhpU09uNi90?=
 =?utf-8?B?SFQxK1ZSZE95TW1oMktTYS92YnVpWkZuSnoxTUNxc0x1SjlZYjgwV1ZHWi9w?=
 =?utf-8?B?bVRVaEs4VVV2dy9SZGNRZGg4Sjl1TVhMdmE0bFg3eTdCOEtsTlhDbHpFR2xn?=
 =?utf-8?B?L254bndMLzlLaTBCL3NRVEttUTVZOTJ4b2o3d2pmV2lXMnRJQ2RtVjdrY21E?=
 =?utf-8?B?b01ldW5ib3AvVGZBNEhtdWUza2dVQzJGeCsrcnN3QnhveExlNUZvaXcvRzhU?=
 =?utf-8?B?T3hIS2hackpsSG1ObG03OTM0aUl5UHRVNkk2MXdrNTVRK25Xa1NuOVI0MkZr?=
 =?utf-8?B?bWF2QjI0NVlqamgxZWZQM1QvWTlnT1FSUHJ3UGxpNEZtK0I3TjZuQzlZMzVk?=
 =?utf-8?B?ckxkYTBxTXJCa09LbzNNemYvc0E2bXVkREJNNWplcHhsQis1eHpEUXk5dEhF?=
 =?utf-8?B?WDlxb3MvL0VjMGM0ZDJzUHhETkpoZUd1WkR2RmtOcDFPaCtmeWtXRHoyR29D?=
 =?utf-8?B?ZXVaVVJLNmYzMmZnVHdBeGV6WDR5dWx5QURXaUlwYndHSnhIeHFJdUZ0QlpN?=
 =?utf-8?B?SElhVnJVeVpicHZQalEzcDNOUFIzRjVjNlZuemhwKy81WUZoM2wzeUQwSUo1?=
 =?utf-8?B?ZXp6Z09TWUNtV1BYTGlOckZvS0tsMGlGYTcreFR0bXJvZU0ybFc0SWh0RVlB?=
 =?utf-8?B?Q0o3WnNSTXptUFV5azVtQVJvK0VCOWRuZDdSQ1lmVlhpMU9XMlYwdnJCdmo1?=
 =?utf-8?B?MkhzN1R0bEtsWTNwelY2dmsrSUxpT1plNGJVQzBTQUg0NWs3RnRVcHF0ZSt1?=
 =?utf-8?B?WHlwVlhEa25OUzBtaHlNWjdzb2R1RHFWWmRTdm03NnNscHU4akVnV1NZSysx?=
 =?utf-8?B?VlZua3d4UmZ6VFg3ajUyNzFvSGV4ejcyWDZ2My9zMnFMSkN0NG9wRVJnODhF?=
 =?utf-8?B?VkcwQU5jNXFPUnRmMFQzZWR2N3Njc2pUUjk2c096RHhFcFRZMFdFajRLd1l1?=
 =?utf-8?B?bUNIcXZHOXFuR0doVHZHL0pTekZLc09COFlmOTJnZjVQSDNvMXhXdUVFNkIz?=
 =?utf-8?B?NVhjNFFtRnpiWlFULzYxMTEwT1FiWTcvaGgrckQ0VFllZmF1dWgzZlVMUW5o?=
 =?utf-8?B?NFdwYklkTzBEb2dwa2VOb1ptSHRGb0ZNV0dHRlZQbWZYc2taMVZhTXh4R3J3?=
 =?utf-8?B?alErbGFhUnM1SXFZK3Z3ZTd5NFVpZnZMcWdPTjVwb29WM3dkeVVVRm53eERz?=
 =?utf-8?B?Z3JkQXhaV2duQURyMlQyNG56ZDdVRVBhQUhNYlJDMU8vV2FnbS8vUDZNMEMw?=
 =?utf-8?B?N25tck5rQWVTNVRBaHFRNHB3VWtWRnNOT3FDeWg5cERWWjlKc1YzbXdNRUVX?=
 =?utf-8?B?K1dMWDErS2s5YmIwcThoZ1Z0T25VYldmM1dqb0dHeG1abGUzS0cyWHBkTWtB?=
 =?utf-8?B?dXA1emtiLzZpcmRVQ0NOb3dBL2cwWCtXODRheEhYK0RrYXQ5aVFoNFlBMDc2?=
 =?utf-8?Q?tQaUkctrYto+YXBdRlcFKyNheNogO+hg?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Rlh1NXVqajZrYWhYVFUyM1VlY1lMcVRqQ1NWaytVWTRRV0NoQ2t1Y3JVbGJv?=
 =?utf-8?B?SWxJY0tUS1JISVpTVGlWNHhuaVZKSG4xRUNQYXNacnA1blVCeGtkY2RrbTU2?=
 =?utf-8?B?VDloT3cvWEkvRGJNR2RQQjc5S2REcUVXQ3ZwNnVZKzc5NnJzMzc3VnF1TGF1?=
 =?utf-8?B?Y2owV2Z0c3htdXcvRHdnZFBlQWdOaloxb3U0TG9rdG5DV0w0ZzBSWUpDeDN1?=
 =?utf-8?B?Mk03YlZZT25pVVJYbEV5dnhXRExGazVHK3FvYVZrWHdQK1hpOTVIQnhuZTRL?=
 =?utf-8?B?WjlGV3FWNE9ycmwzS3JiR2lNNm5QRnppMHM5c3BEd1hqRFNSSzk4djNFb1Ry?=
 =?utf-8?B?ZU9heXRRUU1ERUp0bmxxdDJkNWdsbU5qZ0FOUVM0cnY1M0hWdG1ZeDdzTm5S?=
 =?utf-8?B?VlhzOURuaFNvSFdiZ3lDTUpOV2llZXp2bjJSa1BUUW5WMTVMbXZQa0FRR2I2?=
 =?utf-8?B?K3dtNDgvVWs5T2Rkd3JpcVVSaThjajNmN01BRmxnd3VORldXUkZTV2M3bllq?=
 =?utf-8?B?Ukc0WGJrNWdJZlg1WnJWRzdkd3lLd1BsYlp2WWg0QmV4RXVja3Q1NjZBYU8r?=
 =?utf-8?B?RlVGS0M3bzdhaFB3LytibXZ4ZEtyMXZmcTlrelh3NlBzV1BhOHd6V1Z1bk1m?=
 =?utf-8?B?MUVDekNmQVo2QVB3MGtGSzFDY2V4NXVsV2V0NDU2NnYvc1pKaG5MV2hCeE41?=
 =?utf-8?B?cHc4UFZMK2pOYjlTSk16bzdQU3YyY01CcjlZTnRvb040b2gvcEcxTDdFMXJH?=
 =?utf-8?B?dm1kU2NvendHRFd6dnowWVBUcUw4Y1Z3WDQwN3RDVkI5VU9DSmtHYjZUblhl?=
 =?utf-8?B?cVE4YUtJaXJPYjJGek16VEpiOEVpRDhjMFZ6OEVTL0V5T0ZjV2xEYWRPb1pl?=
 =?utf-8?B?WW1TMm9WS1RiWHlDL01kdjBQNytSTEtoQmJLazBTUWlzVm5HbHl4bjRuamov?=
 =?utf-8?B?bGRzWWgyZlBZVXl3STRtUXZlYjNJQ2JrcnVVbUVqRDFrRjRBZUFZSWx0Zzdw?=
 =?utf-8?B?dGpUMllLbnJTeHhkd0tUbitwaVB5bW1lbjZ6MGJZNkliTzNsME16RldIc2Vp?=
 =?utf-8?B?NVI5ZER0cEd3YklEL1h6L1VxN1EwOUdwZmYxSUlwekprWUJFbmc2cjFFV1o5?=
 =?utf-8?B?eDJva2VQN2dmUUFIMHVGNnJwQ2daUkxWZmRZWWNjLzR4U1RnZGt1YkMvcnM5?=
 =?utf-8?B?d3FoQ0FxUVcvMWdNM0x5TTNHWVl6cXRFTDBDNEJwSUVWd3F6bVorc3M5Sm9T?=
 =?utf-8?B?c1Vyc2x0bERXaVRSZTBCVTRDUDNldkZiZmpTTjFKNm5QUzR3VEwzZW9ja280?=
 =?utf-8?B?cXlKeWRETDdMd0psL2JFN3Zqa1FKN1g1K2dzQ2JrK21NQlU5NHdjYkxrTjM0?=
 =?utf-8?B?eTM1bmdVc2ZuMVVmeXVWYlFBTlcrMTBNcFpYQk1lYVJqd3pUUkk3MXV1aG9t?=
 =?utf-8?B?dmdYekVRdEI3a3hkbnQ1WHhwTXV6bzMybFRSbHROb3lKNzIwT01jMFl0ME5P?=
 =?utf-8?B?RWZnRGplREVoUnc2UlRDYkZWN214RFFwMGdsTFpBSkpTSFdOekdLcWxEWTNG?=
 =?utf-8?B?L2xReWd3RDNGcnBaeTdxeEtPVHJyTGZPRzU5OUE4cCt2QTh4NkxrR0FzQjlM?=
 =?utf-8?B?U3BKVGVoMW1IZE9nd3dxWHd6MXpQa1MrZnQ4anFZczFMK21iclBsRjc0YWtQ?=
 =?utf-8?B?T0wvaWZ3cVpLY1A2STAybitrVWxsUUs0YjdodmJOM3ZWMnF1UWZDM2RZZGEv?=
 =?utf-8?B?cjF1enBmdmZmeHFuUTZZVG5POC9CZEVLcmdGWHpKdlNMMENjRkc2VFNYcitF?=
 =?utf-8?B?QUZILzE4MEpHZ3kwL0huU202UVR0eVBqT0d5QVFrYW92eFFRMURJMWNUdE0w?=
 =?utf-8?B?UVBmQ0NRMVYzWkRGVWtGOWVXWlFERElVRFJFV1BzL2k2bnBWQzVzUUg1QXJ2?=
 =?utf-8?B?bnFtRjJKNGsrN3lOS3RaZ1orS0FBRFVHK2tsS1hPWURVUkZRbWxuK3dJQ3Bo?=
 =?utf-8?B?eXd3YUVLU0ZVWWU3TGhsRmZxdTFaZEVJemRrbXZxd2NUWFRtYUlXcElFY0N1?=
 =?utf-8?B?dXJ0bzN1ZGltZWVNSGRmQ1ZHMFNZR053Qk1VMklxUy9hWFEwTHlHdzZLUVhI?=
 =?utf-8?Q?vk8QaYCDmhlanIz+BQK0X2+Z/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0KS6EPxgwJmR+gx+2YtUjVRV4CBVOzLqh+w88plBYBzFY0iICLZcu7gJS5lAvPgD+z2pCLq2Mj6e4h0DnLtX0VK0ntgVV2jRR7Xd0MlRWoxr8WO0/lCtBEMus2Vp+1eAJ7++PlzsEZs91FF5ivRjAqYG9DBGbd5RwBvoiktKwFxvJv5iJeCIh+kiFGMQPD6XHD0y+mqvvPKnFstI+5TLo9L0CeFeYCaOD4yENvcDaseiYwFQ3uhIlSMBOs7FRQmfYUBbDlSIpYGkM4wCTGhDd0eI+C0oc2EWp6BqFOs55wBNzWNLA13sBTX0VF4u+nNa4BEqkAVkyDyfPetB947CFfU307jDMlmpLyr16pPIHhfOOYfV7I6hRcsvQ1o5rpaw09/5smBmWQOQgH9IMJheKi7NinrWyEK0cYd/e3A2N20hbq+Qw/S9Txst5hw0lHPG3vmjlXZm+7fpZWxMLHAMEo33JHmboZUma6Xbo5JFE5S9pNu/xuGx9cydZNfGpGgb2xlwSGG8DzbsQcrzJy+Ke7IpCD7uPHtYcS4ewfKMro3XTYp5uQKb50vaXfJ6CFRr40ZiNy9mT1pHx5o+Nql5nrhxc4QxOOZPqsXP0a7mVkM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7df6f5-0076-481a-56b8-08de006a1faf
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 21:41:33.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09J/5LoQFopO6hoqhxVp/1ItfidSO4ZfhMgFnJjrrVliCOFFhZ/kngIJmyCWLuVbM0q3qTBfCLsDqIzPh91zuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300197
X-Authority-Analysis: v=2.4 cv=P5I3RyAu c=1 sm=1 tr=0 ts=68dc4e92 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=cTMn-MkfAAAA:8 a=mFk139CMfleDqCBqFjAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=07REm91lqynEFC2MfXjm:22 cc=ntf
 awl=host:12089
X-Proofpoint-ORIG-GUID: fcpuMptBFkT2yJ3jW4J-aA6e7LrJVlvw
X-Proofpoint-GUID: fcpuMptBFkT2yJ3jW4J-aA6e7LrJVlvw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NSBTYWx0ZWRfX3DETua3LcS/E
 PkUQ8j9D6CsbdCtuX7B67TjxTFRzS525XlUY82RgbmvOw6BmcN+9ve1X2VuaAf6akFdJ9Cxqdvj
 7XRHrnm2sZ8JI7Axdpn2BPc549iNyt/s9c1F/9dbQ6w0eP80x7lFLZr2YoH1Y6MLMWPELY/U7SW
 3UZLhkSY3pGeVQ7U0AxuUpTCsVqp3yNk6S2UrMM+fA28672uDNw0dQ6z1SXkFbCVbVPjlD2aQc5
 ZaJBOenaBSu2wCd2TZtKt7OpJF6ak/ybN6BL6exBkwA9+FiHtfrvhFtxmrQKA2iNufAF/x+mXlK
 4kOvhtdgw98KEOxRn1x0odWtSp1QYUxIqTZ2vJ0nAdoP2wt7RLtmBbmq3hfP/pP5HdbMHCgBT9Y
 I0n2SIg3hgMjs6PliP2eSIAGFo+T22cYQAOZ/GbbtlSts/GzcA4=

Hi Ben,

On 9/30/25 12:15 PM, Benjamin Coddington wrote:
> Hi Dai,
>
> On 30 Sep 2025, at 12:28, Dai Ngo wrote:
>
>> When servicing the GETDEVICEINFO call from an NFS client, the NFS server
>> creates a SCSI persistent reservation on the target device using the
>> reservation type PR_EXCLUSIVE_ACCESS_REG_ONLY. This setting restricts
>> device access so that only hosts registered with a reservation key can
>> perform read or write operations. Any unregistered initiator is completely
>> blocked, including standard SCSI commands such as READCAPACITY.
> SBC-4, table 13 shows that READ CAPACITY should be allowed from any I_T
> nexus, no matter the state of the reservation on the LU.
>
> Is it possible that your SCSI implementation might be out of the spec?  Also
> possible that SBC-4 has been updated, I haven't been following the SCSI
> specification updates..
>
> Ben

I don't have access to SBC-4 spec, t10.org does not allow guest access
to their docs. Can you please share the content of table 13 here?

I found the "SCSI Commands Reference Manual" from Seagate. Below is
a description of the reservation type, apologize for the format due to
copy & paste from the doc. Based on this table, code 6h (Exclusive
Access - Registrant only) seems to state media-access commands (I assume
READ_CAPACITY is included) are only allowed for registered I_T nexuses.

I'll continue to research for the official definition of the Reservation
type.

Thanks,
-Dai



----------------------------------------------------------------------------------------------------------


Table 82 Persistent reservation type codes


Code Name Description

0h Obsolete


1h

Write

Exclusive

Access Restrictions: Some commands (e.g., media-access write commands) 
are only

allowed for the persistent reservation holder (see SPC-5).

Persistent Reservation Holder: There is only one persistent reservation 
holder.


2h Obsolete


3h

Exclusive

Access

Access Restrictions: Some commands (e.g., media-access commands) are 
only allowed for

the persistent reservation holder (see SPC-5).

Persistent Reservation Holder: There is only one persistent reservation 
holder.


4h Obsolete


5h

Write Exclusive –

Registrants

Only

Access Restrictions: Some commands (e.g., media-access write commands) 
are only

allowed for registered I_T nexuses.

Persistent Reservation Holder: There is only one persistent reservation 
holder (see SPC-5).


6h

Exclusive Access –

Registrants

Only

Access Restrictions: Some commands (e.g., media-access commands) are 
only allowed for

registered I_T nexuses.

Persistent Reservation Holder: There is only one persistent reservation 
holder (see SPC-5).


7h

Write Exclusive –

All

Registrants

Access Restrictions: Some commands (e.g., media-access write commands) 
are only

allowed for registered I_T nexuses.

Persistent Reservation Holder: Each registered I_T nexus is a persistent 
reservation holder

(see SPC-5).


8h

Exclusive Access –

All

Registrants

Access Restrictions: Some commands (e.g., media-access commands) are 
only allowed for

registered I_T nexuses.

Persistent Reservation Holder: Each registered I_T nexus is a persistent 
reservation holder

(see SPC-5).


9h - Fh Reserved



