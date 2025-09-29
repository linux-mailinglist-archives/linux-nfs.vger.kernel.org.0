Return-Path: <linux-nfs+bounces-14791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8A7BAA7CA
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 21:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F501923E2C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 19:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB6723BD13;
	Mon, 29 Sep 2025 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HrMUlyxY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OgKilOs5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E0B1F1932;
	Mon, 29 Sep 2025 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174884; cv=fail; b=PFXESah65TF9Y9BYhtKeXu0k6cc54lTSwfceblifm81To3vGMq0mZE7t2PYdLdciz3f3Rl+FmcwFXXCew+FlV1g1nH7VLZqYsDmsHmZUrjMF8HUCTjmaWpBnmUDHQVHNYcuCjeROJLs89zNN0m27P/pXFu9XFtAB+49uBF15lAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174884; c=relaxed/simple;
	bh=5Lqz5W+TN8qsFLVmLFfwEmTfwSqlJHjJn4VIy1l52VQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rueHJmesJ1KsCIiPXlcE7wGYrGo8inHu8vnRSVEm9OoM0wVdXhj7/LnKUxkWQufQRvf37r/2LOKcuuFfQXDGEMdqSsq2bFMTjG+NDyAfLwJDib7MjkUz2ozkadSr57hY+hdWIT/o8d4hWcSS6cKpGR+uf5MFi+Bd2danIZjs2zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HrMUlyxY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OgKilOs5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TJEhcc028491;
	Mon, 29 Sep 2025 19:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HyR07XPM53OdR1iLIuq6BocEF2gZ1NV2qZgEkrwn8T8=; b=
	HrMUlyxYgBz11RnsS3K8T991QwYoW0XbYdt25dwbpCNzyzE8PymH9LlEpAe6IXI6
	uNclAIiroDo+ImDtEfb3ZlWTDL6Jyb1i8ZnmfYMJllgCjMhC5K8km2CshP/VFXre
	u005WZFNO1vkStHg8NOtHs5Fk7W9PQ9Z2vVMw2hfznzf4hK4lPqx/Gi1PA5yYlKv
	aUE8+uFwcVhNzJUL+DOdqPaJza2bOlIC10hLull2l/bVIDoiAkR5oq6rOn8lx1oE
	2dEmvBgAmvJvAvZC8q7Q3rj3nZMvYbFK0/eTJwC9UrLdsBt3UaccJevp+obYWIUU
	gaKVV6bX7ANA4P9Z+NdiEQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49g03hg1dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 19:40:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58TIINCt036461;
	Mon, 29 Sep 2025 19:40:55 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c74qj7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 19:40:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWkiha36ZAq6zxOIT4APT6uOWXXSVtXz6SLv5quH4UPzY0O5+e/GXLfZ3K6mqgBUMnoHozzLXVnJyH4DVEuWqv859vkqbisg89aiFfzmd/ZbOrJQ6+VmwTu49RhKLfne/ls8Z989L+Ese51Pt/p7c9jIICjkQSaa1FQ6rfC8a7Nv5jcRYngs6+FKnmIDcZbtg08hnpF8+ZLUBA2BgmHn5mk5m8IAaL9onc8G3dTB0AMmkWtrD7f9zuVCVeDKgtt411C7IZ63KEP44d43XUzDfSYmOpVTaXJ0TC0+oAcfBJV9GnATAs8g9TCyQjUm94TL3OtjPHLeqH3bntF38Uj+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyR07XPM53OdR1iLIuq6BocEF2gZ1NV2qZgEkrwn8T8=;
 b=oSQDY3c08stCtVHM9U2WyH0HE2z58NogqLphbMF2/SeMxEDr/L0VhtN+M/2AIxj9j04OxeH+wxlWaJpNHdJK3JeLWlGpiCJR4pgXUflPYijoqC5PJZqrSFCjKTzVz28a24uMLkByWeM7TpDvDeGXKCQlOsDBFcZuy1dsMvtyjAHAMJcg27miHEEyUbMHbF3Kr16uPrlgJa6i1pXlQgMO7MD818k8XKAy58b9VG6njY6U8LDv3iji4m54isRBN4C1JCq8NI7EJ+2ni0OltrN+MJINyov+/j6WHE4jnmbkulY4y6hMLFljdiWKAczDQBX/SufMeqcwhnSFaaGYpt035A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyR07XPM53OdR1iLIuq6BocEF2gZ1NV2qZgEkrwn8T8=;
 b=OgKilOs5rUI/VuoWIcHDWssWZ6HPHwmdLW5VZOzXxSf6A9eiV3hAs9ZaGNs9o0Qlpht0zZdFs599IO4npdsi23ZvxN+1bS/ENplmuGIsuXOO+/XBcXc1EZFe7oct6UyfWsR7vSwhJP5KVvJSLClEnqwWVnSZ9V/vUfa/gm6MvKY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7606.namprd10.prod.outlook.com (2603:10b6:930:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 19:40:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 19:40:49 +0000
Message-ID: <8646ca56-a1ef-403a-85ce-18b90235ab99@oracle.com>
Date: Mon, 29 Sep 2025 15:40:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nfsd: remove long-standing revoked delegations by
 force
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com,
        zhangjian496@huawei.com, bcodding@redhat.com,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        tom@talpey.com, Dai.Ngo@oracle.com, neil@brown.name,
        jlayton@kernel.org, okorniev@redhat.com
References: <20250905024823.3626685-1-lilingfeng3@huawei.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250905024823.3626685-1-lilingfeng3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYYPR10MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d93c18-494f-47dd-50bd-08ddff901791
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RkhZenZXUXZ3bkMrTFlvbk5Pc0lacXZHK05TRHRnRXJhYVFiSWM2MkROS2dj?=
 =?utf-8?B?T2duckYyVkZGZmZPOEhQcGV3aGFLMXZteUNXY3JOSFQxaWdZWVpLd1loZ1lN?=
 =?utf-8?B?bFFwcjRKODhqSE9uOWRtRDlHc3FHT2pmRTlvVC84aWxYdlJDcGllVHMzWkdD?=
 =?utf-8?B?bmJzTzh0ZnpXY0VUNWdOaHRlS29jeDVkY3BlZHNEQjFiS3l6NnFlYnE2aHVO?=
 =?utf-8?B?VGlPNVN2K094KzgxMk1iaXg4SHRyeThxcVByTHZteHF4MTMxUHZFK3RZTWcw?=
 =?utf-8?B?c1J4a2pkbzBmUTBSR2swT1RjelhxM3ZoZVIwWWVVRWYyU1VjaStwMUhWTlAy?=
 =?utf-8?B?bVZHbXlCRGh2L0FjTlg4cmVlMVFQYW9Xcjc4VDhTbmcraEJSYjErTzVVSzdh?=
 =?utf-8?B?aHVzclV5UHFFUHNJREZ2OTU3dkFtcStWY1J3a1RxR0FqbEdFbkx2VzN1R1hz?=
 =?utf-8?B?UG5qcTV6MDFVNVllbnlZeVl3dERxcHg2Z2hINDJJSkJqTmlrVVdRbzdoSncv?=
 =?utf-8?B?K2VtVW92amEyY3RENUNFcHNHeG9mOUh0d2pGYTR5S21kM3I4Z3BkV0RRVDVt?=
 =?utf-8?B?TU9RcWY3T2RkMkFNS3NaV21sN0RnYmJlMS85K3QxcGtpVFBxeE84eXBGVnYw?=
 =?utf-8?B?b01YbFlPcjY4SjRReEV3c1dSS0o2Mys4SFBwOEVlVDRUS3NZck56SlZpZ2pr?=
 =?utf-8?B?a003b2wraGZhR2VQdC9oakJWV3BNVThNb0poN2VETWhvL0NUbmtqam0wTTZp?=
 =?utf-8?B?UlI2NG9mUURURlhqaHd1dWN2d1NjMm9WM05yTmpPbUNBQ2NLWXNpdVVZblRC?=
 =?utf-8?B?VUxVNGU4cUEvY2Zqb1NPWit2YTJYbC9rb3FoRWRnUWEzMVRLRUpaemFFYm02?=
 =?utf-8?B?VVE1S0dwWi9aRzBnT1VDUjIzMXVTbVlKNFlyR1RueGRvc2FwRExWbVlObnY1?=
 =?utf-8?B?S3Yrb3JJVTNqdFJkVDdkWnpjMURJelVnTEszWFU3UCt1SnRMaDBJZWF2aTVt?=
 =?utf-8?B?Mmpyb0hGMHduTGtuN1ZXQVhlVjN1RTVMRzBUcHV1a3RaOURPS0RSdWFpa2RC?=
 =?utf-8?B?VkF5d2REdFVLckxoSVN4V0FQVjlXakFRdXJPVE9lVzJoZnRjOWdSQit1a09T?=
 =?utf-8?B?Vm1UMW5xV3graURYaUpQUEU1OThGR1htRGhYU3RCNldmNnUyMEFkTVptYzFo?=
 =?utf-8?B?YmNwMlViWm1LdmpwRjErZzZkbTB3ZlF0aVkzUGd4cFB6SW1Ub0c5WUpXM0lU?=
 =?utf-8?B?dWhNNFFUVWFqNUJUM1BjSGV3K1pGWkZKV2xLVm4wclY1a1JJUW9xZzUrc3JR?=
 =?utf-8?B?NzZDSDBCVW12SzI0NHYxN0dSdWQyT2Y1SGxkSU1iNkdSNVd4ekwrV2JKUW03?=
 =?utf-8?B?bkJEaTRPU0NKZ2Q5dzhmNXJJTXcvYWpZQ2x3S2I0VjNXMFptem1TK3JxUnR1?=
 =?utf-8?B?eE1rRDJFSzVYRlVvclo0NUREVk9qbHlBM25xUkxXNVdsVFB1QVEyMFZtYUda?=
 =?utf-8?B?NjN1R2tIb3FjWVVRQUluYjZwTHpMRVdhTkxtMVgwQTYyazZDYnRTUC8yelV6?=
 =?utf-8?B?Vnp4WjdpbDN4anRxMzF4OGh1QUZPNUN5Znp5blZWbUhXWXg2MWZWeXg4UDIv?=
 =?utf-8?B?T3NubWtmaFdZc2xEemxMeDVhMEJmWVcrM21pbEpRb1dlOC9TQmVTR2prOVA2?=
 =?utf-8?B?OW1nN3dFMVFtRThCNWtoK2k1blRyWHZDRjl6OVlzUzRKVFBINGZEc3dGNEJN?=
 =?utf-8?B?eE0wVUlHOWlFKzRIK3hWLzIrT3RHQnRpWVVkWjdjbHF4TU9lRlozbnd4d3Qx?=
 =?utf-8?B?YWNRYitHZDZyY3F3aGJuK3pCelRtSjBTbjRGY0JZajk0MG5RdkV2TVF5L2w2?=
 =?utf-8?B?VUd5TGxpNmdlVUVzM1FyQWxMdlJ6cUQ1c3VHNUg5b2oxdnU1Y3FXT1ZxM0hI?=
 =?utf-8?Q?Z0mMxec6RNeL+lzPWsBDuFWqeyFYlRxS?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NFhqbE9sbXRnZEV4clh4YlZURmpXbVJUZDZaekV5dzdBbXdPa2VUbTRmMEpx?=
 =?utf-8?B?OEZBOGdyK2ovZ05iOVI3L3RvK2gyTHhJRklqd21NcDcxTW1zUDA2UDVnaFln?=
 =?utf-8?B?elRLeUNzTzl3NFFDZGtOSU5oZlh2emMxK1hwaksyWVpnUGZjSWpIdkpVS09E?=
 =?utf-8?B?Tlp5d3JYbWNlOER2NG1FNzNOcVU4YWNrSFhOWllTQkk2UE5DWUJheitobGhO?=
 =?utf-8?B?SGxlU1ROSy9NWFZKSVJoOEpCdzhKZDBoTFFYRkJ6elJIWVZNYVJvVENuSUdt?=
 =?utf-8?B?RTFBTE16MWo1THkvSEEzaXIvNCtXV3llRVRWSWpLOVIvYi8vQnhYb25QSGlF?=
 =?utf-8?B?TGtXbm9YdjVpRG5TenQ1dUpybE5XMWZURHM2NGc5T0UwWm43ZzUyRkJHeXU3?=
 =?utf-8?B?bGIyVUZxbHpwQllJbzBWVXJkUjN2MlJFK1lOZG9pWnVYdkozVnI0aExMQUNv?=
 =?utf-8?B?NjVObHR3eGVJRm9JcEZxL2FnUmFEMzYxNkJsZ0V0Y0pkK1NtVFlQaFZrNU91?=
 =?utf-8?B?VnBQaGlWK3VGUnlvb2YzeUNiejRzVmcxVFhSWHBlaEJOVnAxMjlnUDg3TFZy?=
 =?utf-8?B?ek1rVjhkL3RMdnpNNUNkYkdaVTZEWWRsdGFuOS9RaW01Q05sUkVwa0NmMk9s?=
 =?utf-8?B?ai93VVdMTlFaaGN4RE9BeHl2QVZsbFQ1U3dIQW8vN3E0UlVYUVZwajIwellT?=
 =?utf-8?B?azBEVG0zejByK0FBTDBEV2ZPRUM5UHJ5RDVGUnVxOVNrWnJkMTVGVEt6TTFy?=
 =?utf-8?B?c2JtbHE1T3NLL3dHL01yNTFZRVdJaVFJSGNCU3hVb3dVNWJySlJjM2hMR2Ew?=
 =?utf-8?B?UjBlMEVySUVqZFd5akV5U0JOZUl3M08wSWtoVTVPVmVDOWUzNlpIMjhZSFJN?=
 =?utf-8?B?TldkUzhQWGRzU2dHQ3pFNEpmMWM0dXZtMHFpYTdiUWNyTkhySTRiOHlNVmh1?=
 =?utf-8?B?c21ZWUNCNFZzdjczWVl3Y2ptSzFvSld5RGZmTnJrRndhd1dVdTIyQ3JUSmFI?=
 =?utf-8?B?cHRsSDRzaW93QWxCT0NOSURnNDVQS3ZldDlhamdEZ1Y2NzlzRGJCK1oveHVW?=
 =?utf-8?B?aktpd0d2YmppTHUzZ3I4Wjl1UDRyTWFMS2h3VWFvNFo5bFZNZFJpRVhid28v?=
 =?utf-8?B?ak5PbGc4MFcrV1BvZ3JRV0l0eUc4RTduS2VtdHZFTEhjYUxwb3k3TzRyWG1T?=
 =?utf-8?B?UmMwVFg5U0ZlMkxRT01uQ0Z1ZDJVKzVneThBZDRPeEhQcER0Y2FNMXRpWWlD?=
 =?utf-8?B?T052WGpORWliUFhWZ3c3a1A4SDNkdXZGeTZHdWp4SThaa3U0a093Wldybmll?=
 =?utf-8?B?YWNqR096aDU0MlZFdzNSMnVNMUtxSFUzOHJ1WVZlVWhVaHUvR3UrTlp1eEIw?=
 =?utf-8?B?V1VDa3djTFpra3YwUkRhZEpneUlpV0pWN1RUQUF3ME5vVzdWWFhtc0V4Y0JY?=
 =?utf-8?B?RG9mSWpFOVFid293UzBKeVlxQldQa1dQYmx1b05BNzN4Syt2aWlRRHV3amJF?=
 =?utf-8?B?OTVNTWNkOEtVVjBFMXpMTTcvZy81NHgxMHJScmVNc3JaM05IbW1ibUoyQTBQ?=
 =?utf-8?B?R3JmZGpvcnZKblhVNXRHU1BHZlNRZll6SXl4NVpqTzRoN0VPV3NmcWRzOWx2?=
 =?utf-8?B?aFlDQW1seDFXVzVzbTU4bVpJTUJtMUZqMloxNUdxdGtXTUgyWVJpUU5EUmts?=
 =?utf-8?B?ODhwaHNPdVVmN0FPaERBeDRRUzAvRDNzVDQrV0JxbVBCeVVWcDJCRWZGK1ZW?=
 =?utf-8?B?dXpzdHRHYTdaL0IzYU1xTjVnRHRIVVdvMm1EYkQvcFJuL1JMeHpDenM0ZElj?=
 =?utf-8?B?b3IwM2hnaGNHZEcxeThCd0ZodFBnZFdXZ3hGVmx4MzluUEpYM0F6WkRvYnly?=
 =?utf-8?B?bjhuYU5Ta2hjQkZHL1dsajVIeFBqTWI1amt2eHQyQVc5SElRQnZGQTFxTlZh?=
 =?utf-8?B?bTAzZlFza0ZTQjhScnozbnM4NjFxdzdkeVdNNkFuV21WQzdUc0tyM1QxR3VG?=
 =?utf-8?B?UEVOalhTamYvbXNUSmFaTVpNYVkvKzZ2NWpPQ1o5MElKaGQ0dW02bmJjclpL?=
 =?utf-8?B?L0ltaXVlWlF4T2gwQ09KNlJNMFFlSk9GbHZXbm5rc0QvWi9ic2F3aHA5Nk1M?=
 =?utf-8?B?aDhBWmVvMWg2aHI3eHNMNlRhQTRRTjBlZWxKcGNzcUQrMjRWMGJBZlYzcDE4?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O++1wrAB60viLkyi59QbnJ8d73MbfO4gZtgb91nZkRIWeNYWDCdl6mVUXtpceOGzUzqSnOo4RBea/8fxyUN4ka2cFNpl9YfkvUCoPV7Wxzf8RC0FwFLDQ8ykosaurjLjhqniRe6z+aOGsLMAV4NDAjJL21IkU+fWRWw/VFMu/0A2yptG3ZYNsJwjrQzjyZ0arTD0v3h/esyzZotyWs/KRne0Vt/+D8/rxJatT/zMmfIlaJQ2+V59pKg8Qk1T3IBuO2k1PS7p7j75Qrm458RVMGUZe1yTX8O16iQHF6ucspkksaFK8jauIVQzma/QQ++Nzf8VijDd1REyJXDG880ZfFJRHy1FU2/buw+rbHBPU+LtS7L12IrrTRbPSWs59Xacua1iOBbDjZ11fjlCUXpZdQE5ecWuJOaEctamDUCxNnHiSmuaSaE2goxmQ8Rn04ltdSwgDiVrZ158IcyxjsEjZespwuGWi7YAMf5qeJ6rt2fBWDfh472WFKiki4qtkxpZ38Ded7uR+oYTh17ilQdA//rjWCgEPsKCygqSDCwEj+Qpi2WhugGi7lUNztHb8AAczFIx3BV4cOROC43GyT7BpfS+fPJULcLSOAhCln2tYsQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d93c18-494f-47dd-50bd-08ddff901791
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 19:40:49.3790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGSmKQKRYDf6BdCwH4X8HHeyA/cDSQk07FDzHinyB/W1cxb15hdQrM/4OxSQr52/yrPYGkSLFv4kj08D0VrZpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290182
X-Authority-Analysis: v=2.4 cv=EtvfbCcA c=1 sm=1 tr=0 ts=68dae0c8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8
 a=a4wTRwnHMjmUIoW935EA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: VEP3XHrw2Ai6xX5Dpqln5CiUv5SteCP0
X-Proofpoint-ORIG-GUID: VEP3XHrw2Ai6xX5Dpqln5CiUv5SteCP0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3OCBTYWx0ZWRfX8SGMXUzLghP0
 EKC8Upgl4ihTZUnmYNVIXCYW2omzmTZ4ydL+dmheX4zBsSDTpH2phCwX3R137p/LZnNTfTR1hIF
 CckDUMBShilXUalnJFCIRGXobG2yXBHccBrKqKi0ul5Q9GCHrW8cHbFBRL4eEn3ydrfqTxyQ8so
 bUTm8wh6Qr32vxh9OPbi/ZuscjhhrlMpWMZQNA1A4OFNagdhH97A/AlY2R0pGFoqnOnbUpBsFOK
 V+hiMdLI9AsVL0n1sTGfUgQwZbP4qo9Ak5SuZbNbrqaQZu2UBufi/6Ip73osF9noMCqGi0zAv3f
 wnUjRXJ3MYUCPSYnjsaJU3ucsBoJz2vDiA9iAq06P/6+hA2Z2WH31L+RHqdn0rzUZQ6aDQLf69F
 jGQJEwf0f9M5cwOTu7U4qK/fKHZqLw==

On 9/4/25 7:48 PM, Li Lingfeng wrote:
> When file access conflicts occur between clients, the server recalls
> delegations. If the client holding delegation fails to return it after
> a recall, nfs4_laundromat adds the delegation to cl_revoked list.
> This causes subsequent SEQUENCE operations to set the
> SEQ4_STATUS_RECALLABLE_STATE_REVOKED flag, forcing the client to
> validate all delegations and return the revoked one.
> 
> However, if the client fails to return the delegation like this:
> nfs4_laundromat                       nfsd4_delegreturn
>  unhash_delegation_locked
>  list_add // add dp to reaplist
>           // by dl_recall_lru
>  list_del_init // delete dp from
>                // reaplist
>                                        destroy_delegation
>                                         unhash_delegation_locked
>                                          // do nothing but return false
>  revoke_delegation
>  list_add // add dp to cl_revoked
>           // by dl_recall_lru
> 
> The delegation will remain in the server's cl_revoked list while the
> client marks it revoked and won't find it upon detecting
> SEQ4_STATUS_RECALLABLE_STATE_REVOKED.
> This leads to a loop:
> the server persistently sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED, and the
> client repeatedly tests all delegations, severely impacting performance
> when numerous delegations exist.
> 
> Since abnormal delegations are removed from flc_lease via nfs4_laundromat
> --> revoke_delegation --> destroy_unhashed_deleg -->
> nfs4_unlock_deleg_lease --> kernel_setlease, and do not block new open
> requests indefinitely, retaining such a delegation on the server is
> unnecessary.
> 
> Fixes: 3bd64a5ba171 ("nfsd4: implement SEQ4_STATUS_RECALLABLE_STATE_REVOKED")
> Reported-by: Zhang Jian <zhangjian496@huawei.com>
> Closes: https://lore.kernel.org/all/ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com/
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>   Changes in v2:
>   1) Set SC_STATUS_CLOSED unconditionally in destroy_delegation();
>   2) Determine whether to remove the delegation based on SC_STATUS_CLOSED,
>      rather than by timeout;
>   3) Modify the commit message.
> 
>   Changes in v3:
>   1) Move variables used for traversal inside the if statement;
>   2) Add a comment to explain why we have to do this;
>   3) Move the second check of cl_revoked inside the if statement of
>      the first check.
>  fs/nfsd/nfs4state.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 88c347957da5..20fae3449af6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1336,6 +1336,11 @@ static void destroy_delegation(struct nfs4_delegation *dp)
>  
>  	spin_lock(&state_lock);
>  	unhashed = unhash_delegation_locked(dp, SC_STATUS_CLOSED);
> +	/*
> +	 * Unconditionally set SC_STATUS_CLOSED, regardless of whether the
> +	 * delegation is hashed, to mark the current delegation as invalid.
> +	 */
> +	dp->dl_stid.sc_status |= SC_STATUS_CLOSED;
>  	spin_unlock(&state_lock);
>  	if (unhashed)
>  		destroy_unhashed_deleg(dp);
> @@ -4470,8 +4475,34 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	default:
>  		seq->status_flags = 0;
>  	}
> -	if (!list_empty(&clp->cl_revoked))
> -		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> +	if (!list_empty(&clp->cl_revoked)) {
> +		struct list_head *pos, *next;
> +		struct nfs4_delegation *dp;
> +
> +		/*
> +		 * Concurrent nfs4_laundromat() and nfsd4_delegreturn()
> +		 * may add a delegation to cl_revoked even after the
> +		 * client has returned it, causing persistent
> +		 * SEQ4_STATUS_RECALLABLE_STATE_REVOKED, disrupting normal
> +		 * operations.
> +		 * Remove delegations with SC_STATUS_CLOSED from cl_revoked
> +		 * to resolve.
> +		 */
> +		spin_lock(&clp->cl_lock);
> +		list_for_each_safe(pos, next, &clp->cl_revoked) {
> +			dp = list_entry(pos, struct nfs4_delegation, dl_recall_lru);
> +			if (dp->dl_stid.sc_status & SC_STATUS_CLOSED) {
> +				list_del_init(&dp->dl_recall_lru);
> +				spin_unlock(&clp->cl_lock);

Does unlocking cl_lock here allow another CPU to free the object
that @next is pointing to? That pointer address would then be
dereferenced on the next loop iteration.

Might be better to stuff dp onto a local list, then "put" all
the items on that list once this loop has terminated and cl_lock
has been released.


> +				nfs4_put_stid(&dp->dl_stid);
> +				spin_lock(&clp->cl_lock);
> +			}
> +		}
> +		spin_unlock(&clp->cl_lock);
> +
> +		if (!list_empty(&clp->cl_revoked))
> +			seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
> +	}
>  	if (atomic_read(&clp->cl_admin_revoked))
>  		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
>  	trace_nfsd_seq4_status(rqstp, seq);


-- 
Chuck Lever

