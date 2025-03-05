Return-Path: <linux-nfs+bounces-10482-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B270A502A9
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 15:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3573B5442
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DF824E4AD;
	Wed,  5 Mar 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lx0qA++l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uNVVXLIw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F21204C35
	for <linux-nfs@vger.kernel.org>; Wed,  5 Mar 2025 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185969; cv=fail; b=T0iS0noHJqr6Uigx0XzJFP53MYKrs0/xVJlxzeuNR8raFv2g5eU0kEDwkG/u30ZQo9CYCI3lfflrDX4+1jOGCg+6m3dY+KVDvBW9deMv1gLUuYlSuLH/7TvnTANMtAqfED+Z/9ZRCNRBdSBRWosySGNd+bmMSthr3zKzKesXGUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185969; c=relaxed/simple;
	bh=YtdnaydMIZBY1Nu1Tq/KOCDbvAYhfRQB+aL2O+lqwIY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S6MfOQkN4KsCZc8WH9omYc2DaZQERJ1pPIzme2gQLramcjYPNw8MCuFBgpZQ14v3VZ1Un/fAzXTdBuyczg9VVkDoy/dO82jTYleQHa1uLAJjX3qoxeaT6ddYt+ZqdZieyTP6AUWVrWsAYOk4RFR0opaAEf25uXKjX7fhq/H8nPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lx0qA++l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uNVVXLIw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525C3rxJ030568;
	Wed, 5 Mar 2025 14:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4zzFtpSxU58fE3jjnyagw4E6FmfXvQRHQ01bDneqwXE=; b=
	Lx0qA++lHTwKlCmmIcVtrmLnle6L0itEabg7vqZqFM9nYlt4YdcEUdvcu4MeziA1
	uqMfg1yqvitSp7k6ignrlSv3WuNxGVu1gp2E5M96c7bGm7Sk9JiYAtoo6jqD6lXH
	Pvw7RtnzWWDpB0zjSSvwRKXx686PcFvk1V+j/AzT6fi0YbfpGXEEPrmnhYzdwEVz
	HwVT5KkIP1OpvmtGp8COlZPxx42PIodjPRbBz88pAIXjjLvi9LkC/IdmwsLCjdvS
	BwI4toTcCHgO+mZyKeQTq4zK8z49UYUZgbM3qCg7i4jSQoQT9cjFvH1JG45qmLp3
	pjuz1zrhBK/utfuWcSoZpw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r47mkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 14:45:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525D5VHj038307;
	Wed, 5 Mar 2025 14:45:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpgruf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 14:45:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtcfFfmL2YOvFqRZr1cqSuS8DHKxAocvE/JUoilI48s1qnf9XWgMwx5dG+EKnbwi9iwXtUBbZtZiASPcOhz7FgLsqaitwfmHs/8BG9RkCvWazoGzDasJuGhZgXYFw2MZF4pjskW7Qq96zu2SikiW6hRz/96D4u4LEOEDOl1KGPSJxKBbfQkWCrT4SNndfsXlDX7rFvLKVlgGJDzkkawwe+uwFCBYVJWZEkx5CrRRi9mn4aFD8oIMibj0GVReZixy+7ER9ajEm1rthD03W1XhSHgxQIM38EeBDPbaGydGpKWaEQAwKa4jTcK+Ieq5JNlbqi/vJdvtf7k0tLtaZ+Q3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zzFtpSxU58fE3jjnyagw4E6FmfXvQRHQ01bDneqwXE=;
 b=S3gZ9r39llVsvimEnVKJ8e9W7faKMa+3WWxOcdwlsErfBc6CaHsoOXkQnUrRrykmVXUDfssN1Qmtd726OHBHsZdkAdhfx6YLXQkLk5+lXDixPzDvBEIl73KIGGzsieN9ihKKCfva+afaU6GoM0sOYs1XaNRU0E6phRTh7AEJZQ8cVCfgnIogph9VTIebsB5x0U61RF+J7sTpXVg9ueoHtxmmlj+gfN81HG0/rQPOfE0Q3YpGPOmDpi4lPEC4/cY24aJFypmOu69S5WA0xPOE9sjDmVFWk9mTYe+fbaFeIzn/6JPguEaD5GbiCAuIuMVRzxOCGcwQRDxJEjNrBFyIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zzFtpSxU58fE3jjnyagw4E6FmfXvQRHQ01bDneqwXE=;
 b=uNVVXLIwU5VVt+LXRCbbASQCS5yzgJukfzvwdXhNMTJzmpmBAGQFX25t+kINz0SE3Oq2obdhwkpQPeEOIftW7KT2oBEE6j2B7zY/viJd58ttLVdaSjLp38XQ7UP6HAA21x9S0EKz+G4w826RYagQoob3Rb5+PsOIOqqJC2FkVGs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4734.namprd10.prod.outlook.com (2603:10b6:a03:2d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Wed, 5 Mar
 2025 14:45:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 14:45:45 +0000
Message-ID: <34e7d5be-3d62-476b-8c7c-5534204cd8c7@oracle.com>
Date: Wed, 5 Mar 2025 09:45:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] NFSD: Offer write delegation for OPEN with
 OPEN4_SHARE_ACCESS_WRITE
To: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1741120693-2517-1-git-send-email-dai.ngo@oracle.com>
 <1741120693-2517-2-git-send-email-dai.ngo@oracle.com>
 <81bbbea01bb478cad8eb2ad85e10f13e4b433e34.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <81bbbea01bb478cad8eb2ad85e10f13e4b433e34.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0021.namprd12.prod.outlook.com
 (2603:10b6:610:57::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4734:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5665b6-9e6e-4050-52e2-08dd5bf4691b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTJWb0ZWWDVtVXBON21NbC9DTlU4YzQwK2FFUEFyZFMvM29Mei85VFBGVE9p?=
 =?utf-8?B?REptRnMxQWZYL3BYMEs3RVRHUnNib1c2bmNiUE43TUFwQ2Z3S2hDSjNxeEd4?=
 =?utf-8?B?UmJUS0h6QTYvSlUrT1IrZU12RjhTK01qNVVlL0dCQjZ3S1J6TGNNby9xUmpV?=
 =?utf-8?B?ZWFpSXZuUUh6cjJkSnluUzVSb3czamQ2UFp0RkdNbUVPSnNrcHVaVURQY3NH?=
 =?utf-8?B?ZXJwUjJUQW5oL0NXejVNcHZ0MW13Z3pPYVNsaHptY05USHZxQm5EQzdtTHRP?=
 =?utf-8?B?RVRRUmhNWUNOODg2clZZMHdyNjBWd1h3elJVa1owUHlWangwTGI3U09LdXVy?=
 =?utf-8?B?enhiNWQ3OTdDRnlXejdpR01IK2J1b1p4OG1HYTB4Nk10VzhTVGtJS05SOTBa?=
 =?utf-8?B?TEJFSWpHTStvWlBNVW5qTXRnZlFpbUE1bFJpSmZCc0huZGpqSjNlY0gwYTFD?=
 =?utf-8?B?NkU1WS9PclIrbzVUdHBPOW5nbS9EQ0NkSGptb3dJMVJWUDh3c3JsaGJsSlJ6?=
 =?utf-8?B?dnBNRExPZkF3ZXlJQmM4K3NUdUlOYUx4dTZ3dGxMbzdpODlNbkt3K3VneWtP?=
 =?utf-8?B?c2ZsdmpWVGY1MEl4SDNDNWNVWG5aQ3VvVmJJU3Q2amJQdk83enM5d1d1SjJ4?=
 =?utf-8?B?bEUvTW40d0tNc3ZweFYwUW40bkhBWUg5WFIvR0JUckZQWjJMaEw1Q3hFdVNY?=
 =?utf-8?B?c2VXOGZyZkNuSXRFZmFGMmgxc1VwUFd1Q2Fad0pSYmVCVWIxbnVJVGhSTzd4?=
 =?utf-8?B?TFV4dHNVREtCOGtKR1ZCQTVmOWt1OVNOOVZENTFqemNlTk1MZkFvcm02TkNp?=
 =?utf-8?B?bEEvVUg1M3hMV3ZJSnJOam5wL0VVakNwUW00UDNsaFhOeVhncFB4R2tqMUZZ?=
 =?utf-8?B?TzVLeEF2RTZuaXUyZGJ0cE1UV0J2KzRoQytSSER2NGNIZ09zZ0s4d2R3Z014?=
 =?utf-8?B?NERKdHhxS0podnhBaGNxd2t1TlJwTytSME15WG42NHdCRzZRVkV2Nm5PY2tL?=
 =?utf-8?B?NUJYRVBJRjEvaFFndmRHR2xCZW9wR0VDaDJzZWVHdnlDbURHdVpKd2syU1Rr?=
 =?utf-8?B?SG8vNFB0NXE4SnU2cWNZRldmWU9OZWNZZmlJb29oWDB4Y08xdXpGUGhCekZ2?=
 =?utf-8?B?UkptbXo1V3JaWkV3V1BoZC9CYXhteW1LQVNjMG1nYlc5RjVrRXNrY3dSVVAv?=
 =?utf-8?B?cnN3bmE4aENid1d5RTNVQ2tpaVc0UVZIMUZMdXkybkg5R2ZnRWcwTitCaWtF?=
 =?utf-8?B?ZHgwZjdJcXE2cjczZnRRZmxwU0NIVGkzMlE0TGFOeEN4RXBtTUNabk9raXdH?=
 =?utf-8?B?aU82N2tLRmZIMWp0RHFyN3FCU0JnQ0FXR0w4RmpqN3FncllldHJnOWJmczEz?=
 =?utf-8?B?ZGFSSzlRSjFLSzA5SHlRWm9Jbk1CajBxaUJjeWhLd0NpcXZ5TmQxTjFjb0Ni?=
 =?utf-8?B?Z1V2bmI4ckhzRFh2d0FvU2F0NTM3enRQUkdBRXVUSG8rMHdtb3J5bmdVbkNR?=
 =?utf-8?B?R1ozajVMZFpVMlZ2elpUbkRicjdPWDduTlJpNDFvNmNhaGl6YTRRZEJUTWo3?=
 =?utf-8?B?MXhzSG1Qdi9vN1hCMTFSdFdJL0NzYnJTMmljZUsxY0tyZzU5SHVqS2FDeStw?=
 =?utf-8?B?UGs2a3BhZnUxVW1TS2x5SHhIQ0NMakhvVFVET2I3bUxPZmdPd2sra3E2dUVL?=
 =?utf-8?B?OU1ObkRUa0h6ZGlpeDNONjNYNDdmdHhwL0poT1k2bmNRYU8ycDhhMzAyZ2NJ?=
 =?utf-8?B?eS92c2tDQ3MzSEhQZ29kUHc4WVRHajdFMlVGVXZJRjJoU0MyVldzNS9COFBz?=
 =?utf-8?B?bHN0bTRmMnVCa1hjdkd4Q2pGbGxZUHFaT2NrNnJTbXZ5dVRFdWhhdFlKNDF6?=
 =?utf-8?Q?UJ2f+oKKLwGJx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUU4Y0t2eWhMaHN1Qi9hbVc0dEYraDNRZDNxWHpOaUJKbndaTFg1Q0lvZFgx?=
 =?utf-8?B?YTZVTWMzcHBlWUdyOWQ5TGYyZnYyQ0gxTjBjTW1lZGl5MWROSVovRmlacnBV?=
 =?utf-8?B?VGV5ajAydHlxVm04UzNTbGt5UGhrNklGU1ZvMTVEWk8relBlTlRMVGd2QU9I?=
 =?utf-8?B?T0tJcCtJSzlKd1VqMW5JM3dTRm5PWmFkMUE0Vm5mK0VMeHlDNnFpM1JJTFov?=
 =?utf-8?B?K3haYkRLenBzRFM3dHRFSm5YaHp0UmlnNkR2d3NzTmZkTjgzZnFSVCtvQTA0?=
 =?utf-8?B?czRRYVZMRk92SG8xaVZ0SWhncTdYVmRBN1RwWitEemhHYlhPUUw0OFhncVM3?=
 =?utf-8?B?MVZJMWI1RytnTUt1eHNsWlVCeWFKWTFuSDA5dVRZNjh4WnNuNnhtOXhKTC9w?=
 =?utf-8?B?Vzd0VFpMY01xVVovNGM5ZjcrL0czS3pGVXp5MDljMm96aWRjdTlxNjk3ak9K?=
 =?utf-8?B?cWpHNWdSZHRzOHNNZFFOMk1qVlgrdTRqcWlRQU5odDVyRE0wemdXQXJnSmFE?=
 =?utf-8?B?MlpsMnZYMHYvVFQ0T0dJaGdFR1B3RkU5MEdSbTBBcE5nYjlLK2E1Sk93dzJk?=
 =?utf-8?B?MkxyMjJjRlVqS2VmNzNlaVdlaElqRDVKM0QvQXhCQS96U2EvTDNZMFlEU3By?=
 =?utf-8?B?S1llVDhCS0tYeUdNelAwT3V0UVZXZGRMT0JZWVgxZFdoS1V2TmxBRFJ0R3VI?=
 =?utf-8?B?bXRZaDJocWcvTUtLWWgvaDRaRlE0bGdnWGZXeG1wZFdMM01VeEMxRTVBSURx?=
 =?utf-8?B?ODJ6NnpaQlYrTzdvRlJ5Q2FON3FJTEVxRnlMRGE5TWxXSzM4dTRwMTBoUjVH?=
 =?utf-8?B?ZFVSaXZ5SE5QYTA4Z1JlVTk1Wk9WaHYzSmc4aDRCaFEvNDVQeVJrNHNmRGhB?=
 =?utf-8?B?d3hRZHZyTXkvakFXMk1iL0MxcFo2anlrZVNUSy8wVGphOWdIOGRLNFJ6MnJh?=
 =?utf-8?B?RnpRUHRsRFpvWFZPb0lyRGVHdmcrSmErU3hnNXBVZkg1akZpTHZ3dUtYNUpm?=
 =?utf-8?B?ZlVVT2Q1OXp1OGljdWIzelMvellUWjB5Z1ZQTkxZRkNJc3Y5cFBERm9saHRE?=
 =?utf-8?B?aWZXYkFmZlNZeDdPUW5tN0QydkN6NG1RME1MNk00UDBGa05Rc1E2WFZPOEpJ?=
 =?utf-8?B?Qml5U1FRbFFiTHJ5QnRvemc0ODFIZVYxZGVUV05acndzTnErUDJ2N0VMb3lp?=
 =?utf-8?B?Y2VQZWNxL1ZhYmZ0RkdQWDRwOGkyN2JIYXNGS05YVXdVY2R2YXh3d1FuNGRU?=
 =?utf-8?B?ZjE1TmJHY3JLUlpZbHNNWWozaENnbFNxaVRqWG5aSCtZYm5lUEZhRWNtajVi?=
 =?utf-8?B?NC9OTm1FY3ZSeWpIckdhWE1OQ1YyV0s3QUU2STg1SlpRRjAzVHV4TXFibmpt?=
 =?utf-8?B?TzhYVjM5V3NvUS9tNXp2VzRFYjg3eG9SWUoxTzJ6YjgzemsxVjdMbTRQVTMr?=
 =?utf-8?B?YU13Qi9nNWE5YUYwMEpnRWtFeGtWT29Ma3pYeEU0L1BSRUpSMUxYRHE1S2M3?=
 =?utf-8?B?bitvL3huZVgrajBSUFAyVWVMU0x1U3djNG9FTHEvT1ArMFJuMGE2Ukl2MCsx?=
 =?utf-8?B?elVRTW5HcjlNNlYvaDVYS1V0ek84b09IK1FwRVBtdzVSU3FKMXlmZmdIL2Q0?=
 =?utf-8?B?SUtpVVNWSldLaTVscWZ0K1hPZDVGUTdhNk1MelE2Z3VVTytxQW5LWnFCQnhm?=
 =?utf-8?B?UHRBT2RBb1g2akhtTzF0cUErRGYzOGQzVFFRNFBxazhHNXgwSDJwRExEa1BG?=
 =?utf-8?B?YkZVdHBvWHVGZXUydkZ3aU16UmZwK0piNXYvR3pZWDdzZVEwb0JDcHlxRHlD?=
 =?utf-8?B?VW13RXQyZ2FzMGtQbnFHWWQxRktpSkJXdmdwaVE4UWdLc1RJcEIrSGtzbnht?=
 =?utf-8?B?d1ZVcDh1OVhmczJDcjVuNzgveGlLZy9tSnBFaWRSWnNoTXVzTTRHRkJ6bHhP?=
 =?utf-8?B?R1laTU14MnFmYmJaemd2Y3Z3U212UlZwOWlhSjlTLzZCbmY3L1M2M1UySjYx?=
 =?utf-8?B?OHpqcUpsQTVQWEh2aE1KTk9sYUNnNisxZ3Z0UjE3aU1uOEhiMEFJeUJWMWJn?=
 =?utf-8?B?VEcrYjdNOEFmdllFc0lEUFVNK1ZiZklyb3ppMTBLeGttK2dsQzJ3TTBmazFD?=
 =?utf-8?B?dVdtdmJmOGdxUUd1bG1LVDdBbzNLakphazZ0VEMyUGZFTDd2b0hxdWVSK2ZL?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qpz5WnOOM2eJhpLzk6A+HAYoRhBjjDOPFNDmYl5JkVwUb6tXr39DcfXwt2Uptj8tg8+hjlNKBxC8mAS82VqltoQ97x35Yye+FicQ7pClqn98rkYtzShkX5Ayc78BWMp2qDkzOmYyM85dZU3Lv4oKYPxez2iwe5PhW1NlJJA6osDJrhlJGXzhFhUfVM0nCEfnX9xxDXjOGcYDB5icW84WqpJw38/Cj8Dxd4BOO8NsLFe5i/oo/qd6z0HD4qYQe0bepptC8XArZmvAKiu6ydx07+zAaY+/zVhS/Gd0bidhfp1ZV7qr4yNGbq1JM10iT951R9+m5BP+4HiIQCKTKeEEZg1DlzrlGdaEd1gwcsSJ5+Jm8tQtjzgBxOxdiLCFMmaAh4Yz+3JxP8QApezLQbi4+Bh2RkUH3viT9egnvoalF8R5Hto6shqbXzWD3RADVzmkm1ZJliuN4jHdt/arRorCkDZPmaCRokajCwH90YhZJustfX+HSt6pC4LhyWsGtWKAjAG8YBl8fscPRFnSHOv0l2KAOrR7UexTGMr8m8yqfpeMosLbykyFOlxjV/MlEpNW/xpzhtyBCUuChWR4bmAf8cT13My/5qWKgmmiswp/90c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5665b6-9e6e-4050-52e2-08dd5bf4691b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 14:45:45.1591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hig8Y8yoAtLAF0EmOH0FOp71T4OShyX7KmlzNngBk0FKp3jFZ0GpA0vGlWxOSgBRAYgkn0hcU+19zFH3ygOunQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050115
X-Proofpoint-ORIG-GUID: yP3xGbc5vfKqO1CDHHeZuQf3BFAm888t
X-Proofpoint-GUID: yP3xGbc5vfKqO1CDHHeZuQf3BFAm888t

On 3/5/25 9:36 AM, Jeff Layton wrote:
> On Tue, 2025-03-04 at 12:38 -0800, Dai Ngo wrote:
>> RFC8881, section 9.1.2 says:
>>
>>   "In the case of READ, the server may perform the corresponding
>>    check on the access mode, or it may choose to allow READ for
>>    OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>>    implementation may unavoidably do (e.g., due to buffer cache
>>    constraints)."
>>
>> and in section 10.4.1:
>>    "Similarly, when closing a file opened for OPEN4_SHARE_ACCESS_WRITE/
>>    OPEN4_SHARE_ACCESS_BOTH and if an OPEN_DELEGATE_WRITE delegation
>>    is in effect"
>>
>> This patch offers write delegation for OPEN with OPEN4_SHARE_ACCESS_WRITE
>> only. Also deleted no longer use find_rw_file().
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>  fs/nfsd/nfs4state.c | 34 +++++++++++++---------------------
>>  1 file changed, 13 insertions(+), 21 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 0f97f2c62b3a..b533225e57cf 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -633,18 +633,6 @@ find_readable_file(struct nfs4_file *f)
>>  	return ret;
>>  }
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
>>  struct nfsd_file *
>>  find_any_file(struct nfs4_file *f)
>>  {
>> @@ -5382,7 +5370,6 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
>>  	if (dp->dl_stid.sc_status)
>>  		/* CLOSED or REVOKED */
>>  		return 1;
>> -
>>  	switch (task->tk_status) {
>>  	case 0:
>>  		return 1;
>> @@ -5987,14 +5974,19 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>  	 *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>>  	 *   on its own, all opens."
>>  	 *
>> -	 * Furthermore the client can use a write delegation for most READ
>> -	 * operations as well, so we require a O_RDWR file here.
>> +	 * Furthermore, section 9.1.2 says:
>> +	 *
>> +	 *  "In the case of READ, the server may perform the corresponding
>> +	 *  check on the access mode, or it may choose to allow READ for
>> +	 *  OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>> +	 *  implementation may unavoidably do (e.g., due to buffer cache
>> +	 *  constraints)."
>>  	 *
>> -	 * Offer a write delegation in the case of a BOTH open, and ensure
>> -	 * we get the O_RDWR descriptor.
>> +	 *  We choose to offer a write delegation for OPEN with the
>> +	 *  OPEN4_SHARE_ACCESS_WRITE access mode to accommodate such clients.
>>  	 */
>> -	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
>> -		nf = find_rw_file(fp);
>> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>> +		nf = find_writeable_file(fp);
>>  		dl_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG : OPEN_DELEGATE_WRITE;
>>  	}
>>  
>> @@ -6116,7 +6108,7 @@ static bool
>>  nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>  		     struct kstat *stat)
>>  {
>> -	struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);
>> +	struct nfsd_file *nf = find_writeable_file(dp->dl_stid.sc_file);
>>  	struct path path;
>>  	int rc;
>>  
>> @@ -7063,7 +7055,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>>  		return_revoked = true;
>>  	if (typemask & SC_TYPE_DELEG)
>>  		/* Always allow REVOKED for DELEG so we can
>> -		 * retturn the appropriate error.
>> +		 * return the appropriate error.
>>  		 */
>>  		statusmask |= SC_STATUS_REVOKED;
>>  
> 
> This patch also looks good.
> 
> The only other issue I have with this is the patch ordering. If a
> bisect lands between these two patches then delegations won't work
> quite right. Is there a reason to order the patches this way?

I also wondered about the patch order for the same reason.


> Reviewed-by: Jeff Layton <jlayton@kernel.org>


-- 
Chuck Lever

