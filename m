Return-Path: <linux-nfs+bounces-13912-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88889B3853B
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 16:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24EF2055CD
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA39621D3E8;
	Wed, 27 Aug 2025 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JCHirKhK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G66k7zZi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42AA217730;
	Wed, 27 Aug 2025 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305705; cv=fail; b=amcD77+a4qGRO2UXScgmgoOJnhBiWJrQQUIM8HabtZoQy0Qvb5QkwGyJckdHzuAsQiEFzIdBjzdZdDClgp/RNMHegKtm2oszETtUVdBqOdTeZNLa7hM90eE0EuwlL15NCNh5Czt3lQ50jXfaQLBCFMaRxspb5MgQWCpNBQdOAhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305705; c=relaxed/simple;
	bh=4nWHvRnBOvR5SAZCCRNEHEjjeBC/5TyWJSjxvFWR7v0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R7v3pAAPRNJQDgUjdbwsW8zQ31NIAaAKIs+2RQ2276fcqQGZbnIXEm57CW7S9KTBxcLot6liJAwyrfVJ8USFX/Gf7ioCenNOBFmyPOLnELLIQCMdfTx/BBN9wxLPJAI9oUIs5nLw/LRmAxpXHoSHCgp8/oFpk/GMT6NOOUBd8Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JCHirKhK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G66k7zZi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7tu18008528;
	Wed, 27 Aug 2025 14:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gxjNvQQATqUp6IMnhXyvF8tQITKql0uOxCfAoRD4sxo=; b=
	JCHirKhKKhMOgJm/+gy5sFrOxDMOHhjBUEKU6OTBuMQhfxTbdkDEYb5kJBlmkAHf
	dLRxW0wIjKzCci6u/0Q9rvSOn9wF7l8HROSU8sXqbaXRQ/RpKm8w/X0D9KBMdKAA
	TX0S1F+D8xCTNKfWVRSbSVqDBot0FALpuDJb3z6sB/Ja144VfG78zwnanIHe5HCn
	eIhtMAvCw2oseg0gYwPLgcaS1lf3H7q8Vx4C4JyWIalZDYjVcaWJqjuU04MRK9Xv
	3sA7otMfwbza4KP1uHJbkkKz7NK6oZQMtO9srXgNf4tbn7uxTGxND/VBzNKivLdU
	rmIizbkxl/bat5I09tnkag==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q58s6jrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 14:41:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57REEUj5026710;
	Wed, 27 Aug 2025 14:41:31 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43an2ys-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 14:41:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHED2YGcyLatIWWDtQB0se9+xAN/V2v9SqQ3ESPMsObr7o6Yi7K+mT+lmKQAgVzEEfh7MsW9WdozDUeTN0nKtGtREv2qtKxqrIaOHK1GPicBL79N2KGu+CDGyNe9P8bUxQ0I0uU1b7+oks6Lb+nJ512ebnSmYGpcr+nNgjVIsaiBYFOW5pZOQA9T6I1fmFPUVj6QDyQ6c9+lA8qKU/MyQY3N7x4x6J2eV6FvE2KxzFWo3a9HAadYDYEYqLxU8YMEBdnrlQHXs8AI1ZJC+PKKNQADFdi092nxcU+uKbNWeMedsoR3oXS1R4xY3yzuXai8nPOZbojgxrGqTATTfKgIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxjNvQQATqUp6IMnhXyvF8tQITKql0uOxCfAoRD4sxo=;
 b=j0tYoyDnzvFsAVmbMR5mEizBrVnoK6V0Ygrk+4Aqu2u9G1W8+Lm9dPf3gFb7EEtHQ9d/rphs8RxmSBf3CMdyP3NDApeEBsh7gwJQDZ0doxV5X3kq9QG8HAW0kq3YlB/XmVIbHYglQy6qEU5sqqWREjXrbMoyMqi8Y4S8KuOtxOG6nv9PKS6VWtLogQbj0UP1Fi3nK0soHDkMh3kDV7AC2KnTkPx4M9gxrgfpJCc9o6EN6U2Uo1midf0+YUDqm5V9IuaJzCnNyqYseJaDEpsomWb2SuWGGeGou2CplH6oUnXGb/E03wAzMByRbr/1qIJ0K5GwkMYzJMcoe63c7/hplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxjNvQQATqUp6IMnhXyvF8tQITKql0uOxCfAoRD4sxo=;
 b=G66k7zZirPD9+9zYcoY6uzDuv/T/ICqYchRO+3wPYlEtg66ezAiwkFZ+BMsEcwtf4guyDw1N9FXnH7l/cd5XwZ929Xuc9yTKTykDU72KNTvcpcmPk0A06Vemg8pqbEV+5hH+7sVd2w4pdxSrUwKHnt22r5UZBi1Ikifn5hSRG1Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6147.namprd10.prod.outlook.com (2603:10b6:208:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 27 Aug
 2025 14:41:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 14:41:28 +0000
Message-ID: <126e0fe0-a20a-4460-b9b0-19a63d02667b@oracle.com>
Date: Wed, 27 Aug 2025 10:41:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sunrpc: remove dfprintk_cont() and
 dfprintk_rcu_cont()
To: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250822-nfs-testing-v2-0-5f6034b16e46@kernel.org>
 <20250822-nfs-testing-v2-1-5f6034b16e46@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250822-nfs-testing-v2-1-5f6034b16e46@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:610:54::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 35abbd77-0a05-4464-91ac-08dde577ce30
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UTVTbEc5ZWlWNmc0TzdkZ1FyblJ5ZDV1LzdldmMxd0JETnkzeFp4bXBqdGVo?=
 =?utf-8?B?V3JqRytPVCtlRXY2NnVOVXdPSlZDR3NHSXNNZWpDQzZiaGYrYXphQTg5dDYx?=
 =?utf-8?B?eElMN0t5KzBBYnNyckNSTzVCN0JGRGFaUXRvUUEySitBWXZYMHhvcmJUMWpF?=
 =?utf-8?B?aGhkSUk5ZHlOSTNXajNMajVGaEVxVUNYNS80dUgrWVNNRXVxSkRSdWRFekZ3?=
 =?utf-8?B?dTh0bjNLeXpPTllJbjU5cWdWWkREQWYvc0tiVG4wTTlmN2lkVzlpVHkyZTVu?=
 =?utf-8?B?cmVkTXkyN2wwSUlDMDhONEhFc0ovUGtKa2hLamtlSTd0YzRKbHFuQ09XQzh6?=
 =?utf-8?B?aDlOQTROeXZ2ZWQvSitmc2QxM0VSeWc2Nml2QnNYWEZQT0wzN1YzZTIrOFBw?=
 =?utf-8?B?aUcyL0RMTkNzRFliTzJEY1E0ZTRGMlhybGU2UDB2K0VqMlJKS1ZJeXBpRXFj?=
 =?utf-8?B?MkFBSW1TQkFyYVE4dGU5OE5yUHhmbnlvOVV0ZmNnK2FoOEtLcmpYZFA4OFZP?=
 =?utf-8?B?eEgvT1hQbVhXQ3U1NTJxZ3Y0bklsUXprbFdPM29sMkt4VlhORCtpM0tjUDdN?=
 =?utf-8?B?WmE4ZVdFc3lQd29ObldaTlZBWUttdno5MFJUd0NYb3k5VnZrQmZtQVczVUVp?=
 =?utf-8?B?SXJPb01PbTI0eEhmR3l2TEt1bFJmbjJyQ09EU2QwVW1kZy9hbWpIcUhoR3FI?=
 =?utf-8?B?d21xemhicHF3UWFsSjhNd292NCtnR05Va1BFeEVCQzZnbEovZk9pdGh1NXVB?=
 =?utf-8?B?YUdIZm5iSHJadUFJZU4vdDJldWlHRm9oazEwelJ3UjA2ajBwakc2bTQ2R3BU?=
 =?utf-8?B?VFRUV2hkNUhOUnB4YTNBTEwrNGI3YTlueGFHTmNDa3NvdmVKMXlRcTN5SUpM?=
 =?utf-8?B?aktpa1pqOGFPSHg3ZkNFQWkrYUxwT2hsY0grZi82VDViVHVDckMvOGxrRVpw?=
 =?utf-8?B?RG9QeGpHbjdSRm5Qd3Uwc3pWeTM4SUw0L2M5T2NWdjBYdUIrUGFncXlpK0kx?=
 =?utf-8?B?TGRBa3NSNDAyRmxBMXhLeXZKNjM3ZEcycWtPK000RFpuUzEzYlg4VFpNcUtx?=
 =?utf-8?B?Y1NIeFpCeGQ4cGxDWENkdTF2NWFDY0N2OFFjWmRYY3M2SzlMNnRZUHJNUU1H?=
 =?utf-8?B?Sk5hRDhlYWpIVm0zTHJMekNKZzVidGwrRUgvVXhMdFlCalNIVjRFWjhOdXV5?=
 =?utf-8?B?Ly9odWx2TTFoczNFalNKQzF1b2dXb3RvTnY5bUVJc1NIMGhrYVppVlFxM3dF?=
 =?utf-8?B?RE1PNUgveDBpQUM3d1k5clcyM1FEM1pMREhKbVZWT2VOVDlkZEVCMGJPTWRT?=
 =?utf-8?B?SjhKUEdrTUFoaU5rQ0xhUjZkWEU2RVBEMXQ4Zm5RT0Z1SmMyclVVN0ZCNk5L?=
 =?utf-8?B?ZzdJQWU0aERFNGJFMjdQbCtWZlN2Wi95NTZCSDd3L0NFMEhQVmhmK2grM2pT?=
 =?utf-8?B?b1VITDBrNmU2TXAvYlVDUVVaNFJSQ3hxMWVXb2g2U1cwbU4wWU13TzdyMmNy?=
 =?utf-8?B?d3JnUlNHZG51dnNTU1dQbndDL0g0VzVjS0d5K2RUakZXNU0zK2F5QXJXZ3Aw?=
 =?utf-8?B?d1NBTW40aitIeDMwTHlSZUtWSHRIdkF6ODJmaFBjQk4yV00zdENRNENuaU9u?=
 =?utf-8?B?anpNczlOTmlXM003dnBJWHBybzNDZEtYdkJiRUdBNkZmRXN6Ymd2Y2lyL3BB?=
 =?utf-8?B?cmh0Q3FvMFN5VkV2cmRFL3N1aXMyVDFObU11RVgrYVNvTXdsTlhTRm0vOC9v?=
 =?utf-8?B?NjJaNDVjaGNjc1J5bUVHV1RGdFkvcVNLTzl0WlgyTFEzbk9VNE11SVF4aE5M?=
 =?utf-8?B?bnFvMmtVTnlSYzhZUDhFZTR6cjZ0U3JuY200RjBNNGR5bzRnMVVZUTl1Zk1s?=
 =?utf-8?B?OFk3ZlY2WDlDNm1UdFh0TGVybFR5Uy9nc053UEgvZjBiNnU0ZGtaTzkzQXFF?=
 =?utf-8?B?WXJ5ZXFRckp0d0o3dXp2MDhMOEZqYmxPK2RvbUlZS29xSzRGTWhBdDU3aVlm?=
 =?utf-8?B?THlxQmhFemJ3PT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dDV2VjhJajhDUUd0cVVlUXRyMUozODlJbU45SE9VV0hEQ1dCUGtVSitzMUE5?=
 =?utf-8?B?UGtzMW9XenpmT0hmWDh2MUtiem81V2tMUTUyM1JDemZKQlNEaW9jUUtpVk94?=
 =?utf-8?B?ZmNGQVJvejRFZis2elVnSHlldFdTNnhLdG54N1hsR1ZaT3RBczJtTTVINUhp?=
 =?utf-8?B?L1dHUEp3cm42OVAzT1N2enViOW1ENTJTejNtRzhiMEt3RXlhL2o0UXZhNWxu?=
 =?utf-8?B?QUtFdXcxc0xQdjZJOUZkbS9ueGJ4eHZGM240dC9HRlBtbi9oT2xrdys4Q2hM?=
 =?utf-8?B?OCtmTkdmQVMyTFNjOEY5eWhzNU1hS2xrZnUycVJadkl3VGlGVVlLVkU3SXdu?=
 =?utf-8?B?OUlKOTRoekhBVks2ZXVFL3Yxc1Y1MFl4Y3lhTmVjdGNUdWZrWkFqRVBhZDFm?=
 =?utf-8?B?aVhDa2I3cVdSc01LaTJMZHRzSUpFekJsSXNhUkJMQ0RvZUZLQ3lrQStaTlY2?=
 =?utf-8?B?bVd1aXF3ZkpNbmgvODQ3dGJBRkJ2L0tET2MxMWN1RHBndFBpRjlid1R2d0Yz?=
 =?utf-8?B?dmdiZzQ2eDE5WnJ0L3Rldkt1azJuNS9BTndkTlo3eTN4aVo2TVhTUlFhREFT?=
 =?utf-8?B?aDJKUjZtSllnRktkTjcrSjdJUTE0K3BUbDd5L2NjY0VjVkl0VEo0RXpLcmt4?=
 =?utf-8?B?UUJsU1FvR0JwSHVlRU5BOEFwR1l4V0tlWkYrN1VkL2VHUU1vT3RQY2VIMjBk?=
 =?utf-8?B?SGZLaEZyYnZtQnVmejFuTGZMcmM3VGRsRllrMzFjNFZnK0V2T0d5eUFobmhE?=
 =?utf-8?B?YTFRUzVLMU1hbmp3UTYyOU9EQzUvb3NaWDZhTlA4T2ZuVEtpU1g5dlplKzUv?=
 =?utf-8?B?eXE5SjJnd0VBNTBjL2M4MFBCTmkrWXJYRng2d2QyaGJqQkR3dXRZeFM2YThV?=
 =?utf-8?B?MUpFZGRwWUtpVUNMSGZEbk9yV0d3K2JUTW4xYjlOKzgzZ3kyQjluTXlsSEtt?=
 =?utf-8?B?WndmeUVTZXRqY3BwR1FrYWxEcmt1Zzdkam5kQSt3RXF0UTd3MWxldEoyS0FJ?=
 =?utf-8?B?aHVNNEZyVWN2Ulk5SHhEdzN2NVFtUXJLOFpKQTYyMVlOVlY0MytxUk80bFoz?=
 =?utf-8?B?VmJkRHE4WDI3Wm1DUkxNY1NMRWRuakhvYWNLVTZPVm9FS282SHRUZHpPa0xa?=
 =?utf-8?B?QUtOOFB6QlZZSzZlWGlQWWw3blVRNkI5dHV0bHUwWDNiVzM4QmRYSmNaM0x1?=
 =?utf-8?B?YTVZZmlqOUg0c293blN6RDFsLytwUXFQUFhLSlFmb0dROEJ2d1VpNUZERUVR?=
 =?utf-8?B?aTdqb2Z3M3k2NlZsTVdUZ2VLdE5wQ04ra0xSMlYrM2JZV2RxNU1PSDBUNDJK?=
 =?utf-8?B?d050angwUEdSNDhwb0RUYXVpd2g2UnFLVGsxazlyaGlxeVNTdXpXcjIxMVlI?=
 =?utf-8?B?aHgxTWRvcEU1LzgzQ0NxdXAzK3pEQjFMcDRKRWJ2Y25Hay9vb2VSZFhLTElN?=
 =?utf-8?B?WjVocDhFRDhTT3hBekFVV2NLcE9xVnBhemlIRlR5cXh2Z0NHU0FIUml1RERk?=
 =?utf-8?B?UXJ4Rkpaa3ZtbUJieWNJM0laNitTZEdhU2RvZENZbzJVdkZMNGtIcmZHbEd6?=
 =?utf-8?B?c2t0Tms1OUpFdVFRUll2YXlZOTU3cHFhL0pFb05HNlN2TjhCay9MT3k4eCtR?=
 =?utf-8?B?akdscWdyazRVREtoOHBKREVvWmNQQXRxNnY5dEFiK2FTN3VtMEw5bUJ5d2Ur?=
 =?utf-8?B?YW9QSUJlUE1WeFAybENRaU9qak5qUG5ieDU3YnlWY2hIZWNVSFdhYWdpL2du?=
 =?utf-8?B?bVAyQjI0dGcrcmhwZER1cnhZaFJyQkVGZHlyckhEb2ZOYjEraGZJY0Zvc0s3?=
 =?utf-8?B?VEo5QWN6b1RUdXdTRjdVSkJGaU1lSmFwN1ZBV0xvdGRBNkZxMU1Mb1RiL0Rx?=
 =?utf-8?B?M3YyejNVY3ZZU1lyWndSeG80Y0FUT1lRVzNsWk1xQ1Mrb29Ba3VFUyt6dTQ3?=
 =?utf-8?B?amU2TjdURzJLWXV5YXN3RFFBd0ZxNStsOGl3T2RBcXlXTXk4YTRidXlUNnJz?=
 =?utf-8?B?cGdXbTZxajZBdGhTV2huYTUwaE9KYmU4a2VJN1VFcVJpaTg2WDc2TjlFamtV?=
 =?utf-8?B?SmtNdnZWNjFkWXhGZjFrSHUwOGcxT2tGRlZGZ3h6aDgyTVEwQU9RUHZOdlds?=
 =?utf-8?Q?Z4FhVGEEciXNseQayJsDODoa0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JTeqpDO/7jwnDOCpe2+IHBqDfaXDV2iPv7VUHlH2SO9qJj4AqQPY52SrFv4T/ryaq1M65RnZEY4OBx7kl50b1s+gHV5ctwk0Cm4tiYBLVoLArBeTFhEQvQYbWnxfN8B6um6In7W4SlIYp5hdFqU8clStCNFIYrxbQX2Ey4McUIn6Trsi8eHYqhUymdG21XPuJGBgHaOdxz/voRAt4U+bvmoctmvTuRn2uIe2+9lsA/LGd2ry5FLeowL/w13an9ZPACQHs2PI1p6BJKgnbvQnbVcB2PL5YRhU7CnLyJzcyKB8z2JX7P5VlIHkeZ7/Fth5QRyVFe0/zjLNgNv4Kv0/+2tn3kNRBOoy4yH/ISnOuNPu49p8UJpIXJ5fjeOwIcdHU9jrsA3aXMwLHaDZmAJZn9tMNqKnPiZ7tLwkmJnDBnmd05qswv14u5UgVw32d6f2uXLxVFkSl2Iua8oO2kq+vkHiXl9mjpv0OsLN0bGl6EozCDHE7A+337wyk7Z5tD7bYvCgLTP8RhF7KR7BCqMVbUVeuAOZbPDER7tfcpG3e932jhblZoG81gzHR0iDAxlWLlWzukxhBpuLW61m128HVTuj49iCXnrc20e3uS2xIbc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35abbd77-0a05-4464-91ac-08dde577ce30
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:41:28.0919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8KTR2WM6S0G/h/EcstPitEQ73w1zhlQ3Z6l++MFRaU/KQQZxYP1LOJNnNuNyYLP+y7Vu639t1oc40bq7fGn5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270125
X-Authority-Analysis: v=2.4 cv=J6mq7BnS c=1 sm=1 tr=0 ts=68af191c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Kw0gR0y9HSH-ItZ_NPYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WhXAkS23wF4U1NTLmoErgG-Ic8z6EpQs
X-Proofpoint-ORIG-GUID: WhXAkS23wF4U1NTLmoErgG-Ic8z6EpQs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyNyBTYWx0ZWRfX4O+BhF+/Kzge
 G12iQ+Wln5d9v3f20XiKk5ZdcB/juZa0pS0+wRBmurv1xKF1zyG8BHePMTGaCp7FuCVXYDhEHT4
 gg5IKcr7eO8AIrFuARMiWMz5zV+qcjqfP7+lJMnEkSDMTILfi0rmCp9DDjvP4CmTrqShDSaFizz
 0NymdQdGTtvskQTsOj/LQLREnkuCJinrOMX7uxN5V3ySfdakgSsc0j9H0H4Sq7wC7/EV+Yqs4Ad
 7N/habnJZau1zmQJpr/xTj76ESsDtDjITYWF36kebcWRq206bmBdOVWKZRhox0AYAj/EcS5WZ65
 qsOf7hSufuVYozPmOhn+gwJDFGnFG5jz6zpL41inf2hF+1iVLOC8exv4q3eGQbMbCaEmJl+2TMV
 y86Qu4cf

On 8/22/25 9:19 AM, Jeff Layton wrote:
> KERN_CONT hails from a simpler time, when SMP wasn't the norm. These
> days, it doesn't quite work right since another printk() can always race
> in between the first one and the one being "continued".
> 
> Nothing calls dprintk_rcu_cont(), so just remove it. The only caller of
> dprintk_cont() is in nfs_commit_release_pages(). Just use a normal
> dprintk() there instead, since this is not SMP-safe anyway.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfs/write.c               |  6 +++---
>  include/linux/sunrpc/debug.h | 24 ++----------------------
>  2 files changed, 5 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index d881486d235ba042feedd2dd59d6a60b366b9600..4d5699b4a1fabff39e67998af40561620b532db6 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1862,7 +1862,7 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
>  				nfs_mapping_set_error(folio, status);
>  				nfs_inode_remove_request(req);
>  			}
> -			dprintk_cont(", error = %d\n", status);
> +			dprintk(", error = %d\n", status);
>  			goto next;
>  		}
>  
> @@ -1872,11 +1872,11 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
>  			/* We have a match */
>  			if (folio)
>  				nfs_inode_remove_request(req);
> -			dprintk_cont(" OK\n");
> +			dprintk(" OK\n");
>  			goto next;
>  		}
>  		/* We have a mismatch. Write the page again */
> -		dprintk_cont(" mismatch\n");
> +		dprintk(" mismatch\n");
>  		nfs_mark_request_dirty(req);
>  		atomic_long_inc(&NFS_I(data->inode)->redirtied_pages);
>  	next:
> diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
> index f6aeed07fe04e3d51d7f9d23b10fe86d36241b45..99a6fa4a1d6af0b275546a53957f07c9a509f2ac 100644
> --- a/include/linux/sunrpc/debug.h
> +++ b/include/linux/sunrpc/debug.h
> @@ -23,12 +23,8 @@ extern unsigned int		nlm_debug;
>  
>  #define dprintk(fmt, ...)						\
>  	dfprintk(FACILITY, fmt, ##__VA_ARGS__)
> -#define dprintk_cont(fmt, ...)						\
> -	dfprintk_cont(FACILITY, fmt, ##__VA_ARGS__)
>  #define dprintk_rcu(fmt, ...)						\
>  	dfprintk_rcu(FACILITY, fmt, ##__VA_ARGS__)
> -#define dprintk_rcu_cont(fmt, ...)					\
> -	dfprintk_rcu_cont(FACILITY, fmt, ##__VA_ARGS__)
>  
>  #undef ifdebug
>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> @@ -37,29 +33,14 @@ extern unsigned int		nlm_debug;
>  # define dfprintk(fac, fmt, ...)					\
>  do {									\
>  	ifdebug(fac)							\
> -		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);		\
> -} while (0)
> -
> -# define dfprintk_cont(fac, fmt, ...)					\
> -do {									\
> -	ifdebug(fac)							\
> -		printk(KERN_CONT fmt, ##__VA_ARGS__);			\
> +		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);				\
>  } while (0)
>  
>  # define dfprintk_rcu(fac, fmt, ...)					\
>  do {									\
>  	ifdebug(fac) {							\
>  		rcu_read_lock();					\
> -		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);		\
> -		rcu_read_unlock();					\
> -	}								\
> -} while (0)
> -
> -# define dfprintk_rcu_cont(fac, fmt, ...)				\
> -do {									\
> -	ifdebug(fac) {							\
> -		rcu_read_lock();					\
> -		printk(KERN_CONT fmt, ##__VA_ARGS__);			\
> +		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);				\
>  		rcu_read_unlock();					\
>  	}								\
>  } while (0)
> @@ -68,7 +49,6 @@ do {									\
>  #else
>  # define ifdebug(fac)		if (0)
>  # define dfprintk(fac, fmt, ...)	do {} while (0)
> -# define dfprintk_cont(fac, fmt, ...)	do {} while (0)
>  # define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
>  # define RPC_IFDEBUG(x)
>  #endif
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

