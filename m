Return-Path: <linux-nfs+bounces-13088-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3D3B0649A
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 18:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE065656FC
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8200E233148;
	Tue, 15 Jul 2025 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z5i5VtHa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uLW3EgzX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C752F2376F8;
	Tue, 15 Jul 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598001; cv=fail; b=Pgs83mqjtL/tSn8G3guQQlhIaW1oQlLg4PQEHlc99rB9Su1MXdGQ/G/YDn7WkDNqoNntLwFfmq1PMkFavqi7L7pZOQglp6NLszqvlb4F2BO6cubXYC0tX9AD0HygpacCxpZxVgQ+4kWeIFARoypWpCs6KAZP4KiO/hR0yqEJwzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598001; c=relaxed/simple;
	bh=spAq/nnDKro3DtUz2aZq2dk8MoIXBowpNtfUZ0JxoaM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ElkAZqsrKV0VUWhK/R2ssFljlW9ysATWB1aTorpTQyO2+d+AsM+dVnjAksUd+Z2LtYOprSxp+T0k/jirxITiDUeihETLDtVbR9VQK1pS7frBfx2rRsW3RvQGfWEebbBQAFjZTL392Y8DyxHfaqddlqg5vA3jA8x4k2DtvYXM/kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z5i5VtHa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uLW3EgzX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZFRq019168;
	Tue, 15 Jul 2025 16:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZZ/cXtbk5M8jLTER1F1pnUK6xVu8mrlsVnnOARwRge8=; b=
	Z5i5VtHaES1JvyOaGpEiEc7m+Hftr8xQdaJzTz4uyb/If7iuqSE9QrfgyytcecV/
	1ms+BzBJallkU+cbX85UyjCxJRhXbweoXt5rW/aSsmhWX7cLc5zhT6brMr3AR+5F
	+20EIssONiF2Td46evx3ZuJ6HMpQl7KJA0dYXJ5gbIuFFUutQUxaRTvKj9LwhpIl
	eT6V8KRHjmAU2g0KB8C4h9HiBmKx1v9BF9TNN5TF0j6AZ76hjj3iSyr+g17Y5esS
	OY3QgsY0oPQnIccN0UZ3xQjAYLSGTa4H9Wo0ufTxOicSo+LH0eR6/MzBm8DRmB2/
	SeOaITZSaAETJPSfrvXhaw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf7kyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 16:46:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FFVWDl030319;
	Tue, 15 Jul 2025 16:46:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5a7bnq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 16:46:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3Ovo+HJDX6qSoJ/nssUPLcv1bmPMeG0GDLCeTF6Zi5605csNHKRNVFS6TQaBxvUNXI/OzyXoObJieplLLCY4qOfxcFkc9/Cu3obzeLKJtgbNrVEcxyb8iN8bE/LYT9vcuhUXiqFHkYrkxdmwEx6WrGtPEPgIRhEqduVfxufCYnuivk+1Yjyj3sPWFsSfcQ/ACxlmtVGVaNLHNNabLrW+tfS3O635p4NJXFh/D4tA+1xIUKEw96UeJ/zhL7inGFQd9OT2ra8s9Ybj6XHPK5hq2vMjMEYbFUJkLsDqvs93iHlQu0pHHP2QlYMRR+IWn0eICBC3uCvRP0jVIe06fiI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ/cXtbk5M8jLTER1F1pnUK6xVu8mrlsVnnOARwRge8=;
 b=v7LFfktI3BpWlxbztbaPklqcQcMlO9K3tEMfLQf555FHe6jbH+baEV2JAUUu/4n1GP4ntQVtBCaePkIhMu5+vDRT3cZAqQT8YyTrFd9odmVR0NZUF3+/ic6QTVbIRHT6gO73TNMiKxXqAIs4OAmKlg0vgBd3g8gsQxC57quuGnSql2hOXtt2ZKEXq4O+zbb6H8ATrLwmeyB7IVYZ+1qClWVxw7sr/ETY5ZWY2vbRK1biT+XzdjvwJWpLH08aiybIRcNzGIVQXkYpzyIC1H7xdS3DEL5ii6bGkwK6XDnw4AnnlG1+Yf9F5KOCFLeKgroCcy3wak9f/oYeSQOmMnp5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ/cXtbk5M8jLTER1F1pnUK6xVu8mrlsVnnOARwRge8=;
 b=uLW3EgzX42AzZ+oOJSLkyJKU9zApcnsK+AM2QBhss/HqFLFQxUrfCUmV9ji+dIAHa1g8vs9CZhoRaxYV/9Mv20PQc+EX0L4Dz5KL/eh/6XYZ88cPzzsQjca/3kZxYINaMWrQvlU4hQ853JyJQGdXQVJlf02mXs35re7izBAZFC4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB5983.namprd10.prod.outlook.com (2603:10b6:208:3c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Tue, 15 Jul
 2025 16:46:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Tue, 15 Jul 2025
 16:46:26 +0000
Message-ID: <479201d1-f153-4264-812a-2f0e084af268@oracle.com>
Date: Tue, 15 Jul 2025 12:46:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: don't set the ctime on delegated atime updates
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250715-tsfix-v1-1-da21665d4626@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250715-tsfix-v1-1-da21665d4626@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:610:cc::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN0PR10MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d11c7b-7ba1-48ce-f088-08ddc3bf23dc
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YlJ6OVhFeDhXell5SVlEZXpRS2FhdUZMTDNIMXhTL3ZpQlNQQmdRbUxFLzVC?=
 =?utf-8?B?V29paUJMUTRWSnNvSkhudDF6bEtvMERlUktEMFVDVHMxdVc1U00zQm1vOU1z?=
 =?utf-8?B?Y3dIZThTUHFzbFN0b25KRllvN1JSRlAwRXZFUC9lMjV0a0FIY0xNalMvUTF0?=
 =?utf-8?B?eFA2Ly90b2pFY3BrelNtTllaRUkvTUp6d2NxYS90M2VuQW1zSnFXMHFLV2My?=
 =?utf-8?B?bVRNZkhmRTh3L2JtNlBxcC9vRGpreUl5OTQ4c014ZHNsakQ1djhVTGFVcmNG?=
 =?utf-8?B?Zmh0Y1BnV2lNVkF2UFQ4VStWU3FZYzlobGdhc1FzZ0U0TVBPUnc4TGVQVHFN?=
 =?utf-8?B?a0dwOEpIUEh0Ty9CZlNJai8yWTJCOHZUWTgrMUNKT1AyOTkyd2dycHVpc1l1?=
 =?utf-8?B?ODgralJ4eXNINjdxZTFOOE52K1YzODh3VER0TkFRRVJhWHFTLzFVaXJaRzQz?=
 =?utf-8?B?ekRrcURmeXlOdWJpbFhRdHJTV0Foa2ZCWGd6U1Qwc29ROEhlRlBaWEZQZDZG?=
 =?utf-8?B?NEhmWUF4Y2JYc1BQMGg3WWV5Sm1HVk8vdFM4NVdyQnVnRkg5NHcvbnRrQUxS?=
 =?utf-8?B?R21xVCtFdjMyQ0d6R1BORWFyTFNjMGhORTNrcHVTR2JDY1FJN2NBRU1acE81?=
 =?utf-8?B?UEU1TE9ZU3RnZzNINzBYeVh0WXRVbTI1aEcxN3A0VXNiTUtBL2lkVlVLMGpo?=
 =?utf-8?B?eXIyQTA1eTFCQ05WRHlzRFB0N09VT1NTN0FXRTMwQThUQ2ZVa1YvU1FiaXVS?=
 =?utf-8?B?OGxOekRweFpnMkxSSWJNaTNna2QyQ2srMDRxSTZPNDRlQ0VkQTVEZGZGMG5Z?=
 =?utf-8?B?M1poZVA2Q0xPTU9zaVdRdEhyekxOSkRJeHAwanRUQzk5Rzg3NHN4d1BFcDFF?=
 =?utf-8?B?ZkVLVksxd242eUZIVGpja1gzYWk3RExmWk5JdHk2TlJnUzN6U0kwZ0EzWGVQ?=
 =?utf-8?B?cXBDdjFLcHE0OFUzc2NSc0Vwc2lkdDhoK0M0L2w2K0dnT0Evbmt5bmVZMjU3?=
 =?utf-8?B?TjZQTzZNWDlzdlQxK3YzVmVoelVYai9FckJicTdXbVpEU3l0N3BWQURLQ3Jl?=
 =?utf-8?B?anNDRWVUNWx4bkxhMTNtNjFyTEl6WlF0MTV1Y0w0a1hvblVlUnlpZjBwaEFV?=
 =?utf-8?B?SmlmS01SaFhXLzFHcjRkUXlFTTZ4QWF5Wll0WitjUVExMEh2dE5TdWtwekZn?=
 =?utf-8?B?N3pKYTBhRm91SnhFVjF5WUdZWWd4TGtYQW5mYjd3SUw2bytkWjk2VEpvUHMz?=
 =?utf-8?B?cmM0Y2REZTcrRGdSZUE0Yk9vR3VWdUlsK3hSTnhUYmdJc2hzSFVzd2NjMzBM?=
 =?utf-8?B?bDl4cmJ0aVlHUExOaDl6MEg2UjJWR3VyUDlvT1paRlBKYkl1SURQTkNZOGFZ?=
 =?utf-8?B?bGNNME5EWVd6aUFyYTh5blJ1YVpGbU9hbmxEbmVxTWMrc3dEemVReXJCOXFH?=
 =?utf-8?B?SmQvRjkwbnpIZUNJbFh6Qk9mNmY3aG9rZUIzakh5dXhSaXJzeU8vcXZoc3RY?=
 =?utf-8?B?VzdCejVKV0hNK1dqNXVINUJrYnM2T1NNOWdBaHRwdS9QaHd6S2RkQlZiemVZ?=
 =?utf-8?B?amVWQzdqaE5kcWltbzBWRmRaeWNZd2cvYTBJUTAzMCtzSXZaaVNQdDRacC9G?=
 =?utf-8?B?ZmNPWG1mTkdDajNQUTdCdXg4aFB1OHdxN0RVUW1tSTlKRC9CdXg0c3RVOEJK?=
 =?utf-8?B?QjBRdUVTK0tzMGt4bCs2TUQ5S3lldk5DWG85L1UwOFVtS3I5S3BYSkZIR21O?=
 =?utf-8?B?UEdsMmYxdEcxajBnZEZmWWt0Slc1OGJpMU9IdmdCeU1WUVZuQ21qMVZVZmY1?=
 =?utf-8?B?akhnb2FIbCtibGR3UVM4ZHdGd3FLVlA2NUxJQWNTSWQxWnYweUlvNG44bVJn?=
 =?utf-8?B?dWNoV2FhZitzeVdlWXN4S0RTTWlEdG5FdEJUNFNvZThFUnVtbmZaQUpibkJr?=
 =?utf-8?Q?ddq1kMw4pWo=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?akNmSjVjMUl6eGFWeStKTkxXNkdZR3M0aWwyU3VHRS9vdThMODd2WHRvSXpD?=
 =?utf-8?B?ZktrZWZhbk9xRE1wc2x3Y1FwSys5d3VUMnp0OGp6bXhGeUpMa1g4NVEvWXZp?=
 =?utf-8?B?Qjgxd3BPdU5ldmNNL3FJcFVMV0J0ZnZVRGJoOXZTNXVhSEhFR3A4aVNqemo4?=
 =?utf-8?B?Z0cxMWx0eXhhcmpyVmI1STFleE1PMTlweXFvdzBQbUQyTmcrSFg1eGx5a1Rm?=
 =?utf-8?B?aWJPSVFINGRxYk90Rmx2ZWxmSmlsMmhLeWc3RG9vTm9Zc0haNWc5azJ3aDdj?=
 =?utf-8?B?TlJ1RS9YWjRGMmcrT2gxRU4rWVFXV0NUQTlYVVBxKy9CVVVkYXhnRXJPM1hN?=
 =?utf-8?B?cVhkTHd4THJuWVUwWWhUTy9XUjBVLzNweXllSHRaRWxJU2lPQzZhMjRRSHhX?=
 =?utf-8?B?SUpHM3Zha0hBU0pDeXpBUzZ1dTJGOGJJTWYvU3BWTk5CRWRkYTNRNVlWR3li?=
 =?utf-8?B?dDkwMklYSU5IbkNlSmpRbjZYTVZ6a3I2bHJZVFJBcDZmWm56MWoyb0l0Q3pm?=
 =?utf-8?B?cXBkS1Z1RGdkRzJZNHQ1aGdmSm1NU2l4RnRjY0c1ZlEybHVTZnlLU2krT1o3?=
 =?utf-8?B?NVpGblc4aVNQL3RsYWdtc0lNQTlIKzFxZWQ2UkZqaHUrTXEwY2RJNDJTLzJY?=
 =?utf-8?B?UnozUVozRG5yaC9tdzFoTm96Y1Y0NEhHcmV6NzJxRTFOWnNWTVUrb05yelR6?=
 =?utf-8?B?S2R2TlZvMDJsOXVodDh5RU9rU0tuNkxWd0RKa21BSFVYcXRZVnVDWEI5Q2tl?=
 =?utf-8?B?REI5M3RNeVFyenpvbDNVN2VMUDJ0dHh3bW93Q2FhSHRIb0cwVk9RWGZiN081?=
 =?utf-8?B?ZjV0Vlg5MUEzYmxBZUdOKzJJa2tZdXB6bU00citIdG1sM2svNEowL0tWVGts?=
 =?utf-8?B?SFhBQ0QraVVCYitoZ3dnVkN4SU10bTRIUzl6SVprZXR5bi9Xc3YyNXl2K1ls?=
 =?utf-8?B?cHJ2NzBNd0lLTmd4RjBtRkJYTHJZVndkQzNqL0cybjIveVl5dHRjamQwMWRX?=
 =?utf-8?B?Z01KdU1UOVhxbFdFTXpoem40YTRDd0JhQk5lVVNtUGI3ZWZKSS9KU05kQzE4?=
 =?utf-8?B?WVdmTmlBYklzZUFyWTRiUEpma3hZTG1jRFlBQTdrNzdBL0xmSWNVdzA1RThw?=
 =?utf-8?B?M3RockJrdHI5b1ZnWnpMTmE0cUQ3WXQxNVVlbkVlMDlIWi9LRCtBWjRwU0c2?=
 =?utf-8?B?akhDRWpFT2hHaEdYNnFiRFRqbUxZK2cvUFlkT2hJcC9RZFNBSlVrclNEUnJx?=
 =?utf-8?B?VDNzbGZJcWlzblZ2aHdicnZZcW0zN0hsYTNSM2l4VTk1MUdmR2NYd1VlalRx?=
 =?utf-8?B?SEYxTkpDY2Z5c251N2FoK2tQbWZvbzlFUFJMYllwNGV3S2FGVktnc1B0MzdQ?=
 =?utf-8?B?aVFEblNKbkl5Z3BEYVNhWkZnWGMrRWhJL3ViWVQ1eUFGd1VvYXkwS3BiTVJE?=
 =?utf-8?B?QTl1bXJhY1Vmb1QyOHJuc1RXcW9DVFpvSUxTVmUrRENVYy9ZMWgxZ3hQSXl5?=
 =?utf-8?B?MzR4bVVLZ2trMHcxZHhydWNNUmpUQ05haWRVSzRmdW1xUFE2TytXWFcwaVpJ?=
 =?utf-8?B?andQcnFtV3U1cFJzR1BVL0ZRenppeUs4MFkyZENDSUYrUnpDMFRYQzNRdC9y?=
 =?utf-8?B?WDVZOTZYb2grMmNZZ2swWlB6K3JIZjgvaXBtVklQWkM5amxOZzdLaGxKMG5H?=
 =?utf-8?B?K0U3YUs4Qi95NngrV2h6dU80LzBYc0VWd1dURUoyMDcxdFV0U3pSb25XTC81?=
 =?utf-8?B?NEs2YUZ4UVFWVVB6NmRDbDBKT1FLeDBkQ2hSTDA4b2U1K0tvS1Y3S0IxU29j?=
 =?utf-8?B?T2Y2T3V0d3JkS2dyaVJZZTA5d01sUGx4K2pzYktra3ljMURHTjJpMEx5am5N?=
 =?utf-8?B?TTBYUkJHdlE1SVJMdXgxZ2k1TWc3R0x5djJWSmtDcW1ObW5WNzZ1Nm9wVEFq?=
 =?utf-8?B?b0hrSlArcmJpMk9zOFRjQTd2aVFOZ0xac3haNWg4OFNEK0M3QWdGa3FTQ1hV?=
 =?utf-8?B?cE4wK3laMFpKTmN4SUx1OFl4SjkvZ0xXdlN5WWZzUEZ2L0JiNFlrZDZzQm5w?=
 =?utf-8?B?MzFJQVVCdTFENTlZM3k3Y3hzN3M1QVo3ZmVJTGxnNVIwYUNEbXhvaDNoTDlO?=
 =?utf-8?Q?/ML/jaIbF6Atj00fb4xY9tfal?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WjpSlkJvrwrNXkRKS2eHG2izmuDTaiXtTT5H6xYUvMXBNNekzzwQwBoHw5Mte18RlYnZkbrjC2pbSDfvyH+1byh7mRKO38afDOdGTujLR/CWsIAlvhb+JcBE5tXJIuxJxqvUE7t9Pf5Xx2avs4MmR91ymXH8xT1dX4Nu2Vc8Er3fT1Ge1O0uH/pT3P6Hw0um46Cb6p1YzH37Tsclh7hxNQyRu4wDm9WCpMhoAq1QnFCQ7l7m4OEaq7AvjneX7gX4UU1JQmHmhP75GTsGIfVR9weNuHkc+TO6goX993UFyNicIO8Wcfx1NfOPGcNf1ET9Pajoe+AWgEOIs6EgDas2Q1QQp3dGDEkp76a1+wfTr2WkiZJUQl+UNMj41qsB+0FCvEKj3rsOhJaX8U8MhKtwpH+qd9nsy06QTQCfjMcDPh9g3fpm3hkTXeH9L2M5gJ49SPTUCGJiJTIsoEAbSNFubRPSjiJGcljbpnhFN5fhiFS5oPsqBSzfl0HTFW+PKSU1Btiox2ZLiENtBWotjMf3sn2aC4p7JZjLPaAONmQi2FO1IM7jFIXTukqhuq3pT8l7uIUqMApU+rEPPvvyCx9jBqA+AIQMwC6fl7d+nlnz9aY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d11c7b-7ba1-48ce-f088-08ddc3bf23dc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 16:46:26.6397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZzH67FXCtsIWQH/saZI8I2Sz3psgU03O+QOcr9jhAJ0urnhwed1Gz5/ZGccaG+IBKT9t76Til8MQJaJEldFhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5983
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507150154
X-Proofpoint-GUID: o5mdRQaDmZuytIYy1s5smO_Ca--Xf8CC
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=687685e7 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=M60aOioUbIvQXvu3ETcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: o5mdRQaDmZuytIYy1s5smO_Ca--Xf8CC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NCBTYWx0ZWRfX3zwrAY3KdBZ9 m/EK0jk1QSx3kFC4nRpmotRgFwXx/Jvom/X8preQPXeTdjvmhGmuXLIcucxGtLdMuUul2hG/TeW ntgrftxeQ5XRXv7dfCEZlPDGb/GQPdlTXEcJ6cXmdblUjuyI79xOzgErpMDWxIxO3sKug1/6tsh
 F0AjuJChiw+eJrUNXiKj0ksBQTlBAXSuGxmRYWkZbqjC6xNmVpEYQ/P4KpGa68xkjtzodru1W5V G2958Bej+vDtl9wISiNnXGaDVWj0/hBRmn8Lah/pYonXZxryIT3r568sPzHfzQxYnvA4PHSMSby UyvesZ642HlBWCd67B9NBbmMtoJPW44U5Rec4STYrH/ubPNrueSGunc5H0CqsRWeg4H5CzW+HO3
 pJ9JZWeJ1LOt8PvhdEHD2o7e+/zmu/vMJfQdKUQlSsIa3K5UR5l+ZFGqsSOXSxRkFHwM+Fat

On 7/15/25 7:34 AM, Jeff Layton wrote:
> Clients will typically precede a DELEGRETURN for a delegation with
> delegated timestamp with a SETATTR to set the timestamps on the server
> to match what the client has.
> 
> knfsd implements this by using the nfsd_setattr() infrastructure, which
> will set ATTR_CTIME on any update that goes to notify_change(). This is
> problematic as it means that the client will get a spurious ctime
> updates when updating the atime.
> 
> Fix this by pushing the handling of ATTR_CTIME down into the decoder
> functions so that they are set earlier and more deliberately, and stop
> nfsd_setattr() from implicitly adding it to every notify_change() call.
> 
> Fixes: 7e13f4f8d27d ("nfsd: handle delegated timestamps in SETATTR")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
I was concerned about the description making a claim without reference
that modifying atime does not modify ctime. That claim has been somewhat
contentious in the past.

Search engines suggest that IEEE 1003.1 does indeed specify that an
atime modification does not require a ctime change. POSIX does not make
these standards free, however. Maybe a Linux-specific document has
something on point.

Even so, I'm comfortable taking this for now and putting it through the
normal set of regression testing.

Thank you for pursuing this one, Jeff!


-- 
Chuck Lever

