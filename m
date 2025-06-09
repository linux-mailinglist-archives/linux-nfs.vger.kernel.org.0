Return-Path: <linux-nfs+bounces-12220-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6FCAD26B8
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 21:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E173A3450
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 19:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B0021B19D;
	Mon,  9 Jun 2025 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ddwKxJLZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TYNGhHjW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5137019258E
	for <linux-nfs@vger.kernel.org>; Mon,  9 Jun 2025 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497172; cv=fail; b=h2WlFPqY7NTAtFOoPTwRqhvh23HD6u9T66idm/yLLO8YhoUMyIW8EctDhE2Lk3dIKvQlxXJeqoMrU27uxDjdNZyUnUA4nv8NGPoEmAzV4LE1Oz7T/hY4K+CIRlRjdP7aepjl28M4iBpcfIXt8pDECdodv+TjYj2DILoCXZhF3mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497172; c=relaxed/simple;
	bh=yFohrmSPhhY75onKG3alRpILHfyQflYKjizne7/Qtss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JA/0Uf/yV8TFM18PJh5pQ9mq48St2kd2oCC1gS/KrKkJ3h3aPBOQYU6CldvCZZs12HJCmVxnKzNpGf5nb7xB7gKffspwMBdkX7JIOUiK0A7+rwjPMcXJPdYGvqO+Re5xxSAg/zQIcSkNE/NQchbIXgtkMSF2Qbj5G18tMM2ENzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ddwKxJLZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TYNGhHjW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559Fd802005003;
	Mon, 9 Jun 2025 19:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xqv1drwgJrr2hocpGSwB9LJ+iux72j7B7DdFZ17Pr34=; b=
	ddwKxJLZvWXP8be58yYQuuaKmbpJGyVe/ty/fBSUaVsu4yjNyNuQyNVeEG6ehMfZ
	aj2USTM5C6EvnWbATkopvdgIn3ZskbJt/eXjHfQGrfe1fbfIMrcUKHsqbaN9ovGY
	QMIMytK36mTdSkV8hdFu9Riwc9oIwfUlymgPQqRsQnDDauiBNbMyWgcG/bo+cJQj
	t8uhJ3yEMFO+tCfOJ0K0y809jHN079IYZWtiqN7dQEM50BegQADtoiKfwPX5wDxu
	Ti77IYP9bDgYx2hkcYkSUHx9H2eA1LXftoLH5KOasSzjh+ZwIx3lMDgIK/YgWT0z
	lkTXgGrM0jgGEOy2yXkeGQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dywtt2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 19:26:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559JHojW031973;
	Mon, 9 Jun 2025 19:26:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv7tusc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 19:26:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2/+e6i4PPYQji3ScojbOBI7kCwbTher2/Aaz9erIb+wQ4Wif16tLqtM7so7J8TaykQjawVtlKUZbsaW0glptdBtfm1jSY1Otjir9+o2pKXNP3nFyog/E5HEw5pFf6bJOGor4DnErNNg9lokanCwIMuGHJ5c893ViI2x/iEJb/Nqf7kZgAd8mC8rVJByVeyxVuEPI8PMGQBEUkoj0xuWXvzaZho8m5S1Tlhv8ZvB3VyAVOtc/FWQgzJdYejiOLI+OvoOi5aS75A7leYHTYF42XhLgFHt90NExMiiwyZ2uDIXrV6idMPjg+MQXtB5E+PG744BDxFXxzzUqdeCkX/GCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqv1drwgJrr2hocpGSwB9LJ+iux72j7B7DdFZ17Pr34=;
 b=bMe6CP53c213SX870CSnZm3u6UhKZaAenNz9rnlNcprXzD9U5+fE2VWt8gtf5G7f9tXIktR1VPCoZkGEADgHxZrBNRaEJdk8yttXZweV0TOZRUqYM1TOP+qQyLbJL+qbwrecZznRm8d8c0z/ji+QB+bCoOvxt0yzrCRX5UO7MlSjHcYZ4mBcac5nbIPXb5T2/BYoqkILpb+VtkCkx4UmeUD9txGiwsJzAOVTX7XEIIwaiibgwdYiw9Cp7Ef30U1PUno46RRqNH5Rr+10q1DzEm/F3JJTRI03baxGM1gSeZjHdf+QNCyEqMvRWaeDvjteJyP1Y8dl9IzKiSgQGRbK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqv1drwgJrr2hocpGSwB9LJ+iux72j7B7DdFZ17Pr34=;
 b=TYNGhHjWKalDC7FlD11nB4QsW4mx+GVCIHn+0AM4Ks0Ys9IY1dWwh/8qx1Chd1td7ydBxqZdVDhyNq3x51R/UP9cxCbfv+rRE+hbqVWw8JffviBn6gNofRg5mHNRNWqLx7MDPJox6I7IlLtu2RoI6yf4xb/h1X6lhw+Q1ty/Dn0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7165.namprd10.prod.outlook.com (2603:10b6:208:3fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Mon, 9 Jun
 2025 19:25:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 19:25:55 +0000
Message-ID: <69abb6cd-f506-43b4-ba3e-a63ba821d80a@oracle.com>
Date: Mon, 9 Jun 2025 15:25:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] SUNRPC: Cleanup/fix initial rq_pages allocation
To: Benjamin Coddington <bcodding@redhat.com>, trondmy@kernel.org,
        anna@kernel.org, jlayton@kernel.org, neilb@suse.de
Cc: linux-nfs@vger.kernel.org
References: <151437c300ca8eb4d8d9a842c9caf167cb32b6ea.1749489592.git.bcodding@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <151437c300ca8eb4d8d9a842c9caf167cb32b6ea.1749489592.git.bcodding@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0034.namprd05.prod.outlook.com (2603:10b6:610::47)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 6368278a-8402-46c7-42a5-08dda78b74ae
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RTVhVDl3RUpsQXVQUmZhQTIzU3gwMzZrQlE4OFdWQVhRY0JkeDhHUUJyR2Jy?=
 =?utf-8?B?eEZGS0w4YUJmU0tZTVFoQStPeTJ5WElXN3J5eWUyM2cxTlBwN2ovdm5GL1Vr?=
 =?utf-8?B?OEZqUldnemhOLzBRWGhjdEJwVHJ1T3dkOUlRQ0doaGRPTnVSQTJUM0JvUkZH?=
 =?utf-8?B?TFFhK1E3dDVLbTlrc1UwL1M0VFFaSTlJWDlvd3MzVytFbHZBNnh3bFkzK25T?=
 =?utf-8?B?d0ZFZ3Y0M2xabnRjV3V0QnppNThESFRhVjRzUXNwbVMxdXhiMGZUYXRiaFQ2?=
 =?utf-8?B?OGUzV1dlaE9jT3IrVG5ESnJaSFdYdDI5Mm1ReU1MU3liaDVIRk5kWVEveUtC?=
 =?utf-8?B?SWpsYTJ6a0I0ck42Y3lKaU10YkxucTN3OU1wOVRVL1l4dUF6bWZnSmR5KzVv?=
 =?utf-8?B?ZnRJUWxWR0ZZaCs2THRjNWovb2NTZ0FwYVFTM3VnVlhNNlZMZDFPVXU0ZzF1?=
 =?utf-8?B?TC95QkF0SFQxRHBKcTFtQmVaN1ZDWGNBanhxRVdKREoxQ2hVb0orQmVOVUk1?=
 =?utf-8?B?M3lpQWFjaWNDd0JiQkNsbE8rMWY5dHJjT2tNNkw5cjNuVHRUNGxhMmkrSFIz?=
 =?utf-8?B?NHlTMzcrZ2VxdUhYV3AvOExIaytDUS91blJCSCtaN1o0eHJzUnF0bkpBYnRD?=
 =?utf-8?B?RUgyWE1KaE54MnBzdzlZcUs4UG16eVJsTkRtOFdQZHB6UUpmZ05qN0VkYXFw?=
 =?utf-8?B?ZGJ0RHFDZDlTQ3IxaWtLTDZuOG0rU2lnOTlLT0RMUDgrZDAraUptZDllemR5?=
 =?utf-8?B?Wmt0UTIzcElNUFg1TDRXVUxhbmR5WTYzN3NWcG9aUlZ2R0tVY0dyRGdyeUZD?=
 =?utf-8?B?aFV5K09GRFY2VHpMRlEzdjZIVm1JZmRjZFlLTStRdWFVbnliYW13RnYwL0tv?=
 =?utf-8?B?MDQ0Mk1FY0YvajFPNHhPVkczbDM5YjhJZ3JpaVBOaS9aM0xVYVliSWpvVG5R?=
 =?utf-8?B?WVJCSkxLSnhnYm02RjJrSVVtckg4VGNHczNYc2JMK2lDNHRKaFRaSnQ0OS9Q?=
 =?utf-8?B?Y0U5UWlWV1hzeVpmS3p5cHMyNUU0alUzc21ZQTdkalpxd1NjemZnUGoyYnp3?=
 =?utf-8?B?dWRTWTBSZS9mSCs5d0R3ZVAwNDRKSHhIa2JhaW1WL0M0aDNhcThoSjZMR2tX?=
 =?utf-8?B?TzhLRXpCZlNvZ1dJRXBnUHhyNks1ZXRyWnR0RHFNNjhoc01LQ0FjVDRySDBF?=
 =?utf-8?B?SEdVQ3hFYXpzNysrRlFzWWlwazhjZG03VThrM21JQ1dlZkpOYndDSTZqVS9h?=
 =?utf-8?B?cTNQd2lmckwzZ1V5M1Z3OGMrU2pKU3pKQm5taXBBeFU4T2FZQVpQbytKVjkx?=
 =?utf-8?B?SSs5eTFseGhJSGdpUkJPeFBIS3BrVEJVKzlzM1RXaENpVWc2ZCs0QThybE9Q?=
 =?utf-8?B?cWpOV0tXOXBuMFp3Wm9WQkN6OWo0K2hvNXAxaWMzbGMrMUpOSWhjTzJTYXpB?=
 =?utf-8?B?TnN3UVRrNXZoSC9yODRDVkRLZnVLZEo0T3ZqcWRPL0kyTDhxbFpRRVViVFVM?=
 =?utf-8?B?b09VZGcweE82S2JSZ0RVUnRzRzJTR3VaVFE3K0p6SnBCeDZzK28vejlYdkRH?=
 =?utf-8?B?M2UrMzlHSXcyTzg4UWhrb0c1ZHN3SEdqYTZzVG1UbjV1dk4wVUp4T2FQSmVX?=
 =?utf-8?B?OE9STFdaUHZ6Q1h4UVJHN2VDSExLY3ltcVpzRDJJbWFRc0lBbHlwZnNyUDhD?=
 =?utf-8?B?alltcEx1OTNLQVY2dTVtcHpDL3BJT00xUmM2RnFoR2VleUJKQWNabmxyRmJZ?=
 =?utf-8?B?S3NabDRNNGcyYVlhZndQaDc2T2VJWVhONHp5bFNCclFrcHJlTWxjSnp3SU5q?=
 =?utf-8?B?TzUxcVhZaVJCWjdHbzl1dWdGbkgvMUtuekc5UWRMNjdWTlo4ZWhmS2NUdXdj?=
 =?utf-8?B?R1UxY05KM1pZY05ZZmN2VmdRSnU4UDB5RXpsR3d3blpJczlGVkhNWTlrV0Js?=
 =?utf-8?Q?nEqwx7CAdOI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eERpckVmbWZGYnc3ZS8vRXBtejF1ZGJVMVhoeGRLc0l4cU9OWlRWeVlUSVNi?=
 =?utf-8?B?RkRPL3FLb2FuY2Z5aGZwa0wwcTlyNDRUdlhIZXJ6SHc4NjNOMXdYM1YyMENC?=
 =?utf-8?B?Wk5VSEgzT25jaUJYVkV1WitaQnpibHpwcEZ1N01MSkh0dndDU3ZwYUtGVzNv?=
 =?utf-8?B?ODB1OFNicHJkT1BzQlU4bkhrQTVDbldTRnVFM0ZPcjV1VEhXRm9vcXRHbUJQ?=
 =?utf-8?B?eFlnbkpmNTNMOUhkTCswTzV2Nk1BUzNlV05WaG1OV1RJQ0dic3ZpTG1kNDdn?=
 =?utf-8?B?NWJxcEYxUjJGeWZ2ODBjQ2YyYWRzYWpRTmtrbFczVkQyNVJSM0RnbHkwOTl5?=
 =?utf-8?B?R1h6ZWJ0YzgrRm5jc2xjemoxcHJac2h6Qld4RzRIK2ZvT0thak91NE1PMEdi?=
 =?utf-8?B?SlhCYnNIMnBzREJ4TFRBTFJ6VmIrYU1vcTM0Ky9PeGFtbCtlQ2ZpR3UyTW9z?=
 =?utf-8?B?NDg3QmVjS0lFbGdQVE5IZ0FWdHZiNmlmb3dubmgyUUF0MUlLNWg3Ry9rRmxK?=
 =?utf-8?B?c1FObHFObFFGSEtoN2NOVWM1dlEyeWllRGVMV1hPRkZWcXk4dkhqbFRPM2RZ?=
 =?utf-8?B?NDBEcFd2dEYzZ0NHYTV5Y0kzRmI5bE9meVNuclpFZHlybWNYeVd1L2M3eVJq?=
 =?utf-8?B?YnNHQytPN2lOeGx6ZkpPdk5lTUVsajliaEp4ZzduRlFUU2R0dGZQUHExSDdt?=
 =?utf-8?B?TDV6N2UrUXVhbldLampJVEFpVU5FRks5VCtXQlFCb1FLWk1Ub255cit6bHdq?=
 =?utf-8?B?T21sZlhURTBuNURJS0xqSHVaRzl5cENpVDZKSWtURnZYd2VBM3U4MzYrNEM1?=
 =?utf-8?B?U2M4MVRDbW5QMDdvMFZuT2ZLWlNhOCtqTW0zUkFwcE9KR1Y1QTJBVWgxWnZx?=
 =?utf-8?B?SStMNmwybHlVRGlmd2JkK3hRd3lCZDM0SnJDZGVlMUhiWHVEa09yd20rdTdP?=
 =?utf-8?B?RUxZVENpTE81WjJkRjdoV21uUnc4Y2xOeGFaKzc5UlJVdWNhdko1eEtHV0sr?=
 =?utf-8?B?VlQ5V0JHRFJKQlp3Nmk2YU9VSFl6RHZxNzFoWjB5OWhtam84MUNyaGJkYzVH?=
 =?utf-8?B?RS9FTGxCYjZzdHA4L3V1c0grUE1tTHQ5ZWp6YzlEdHYwRUtpa0JibU1rSHFw?=
 =?utf-8?B?Ty9hVTNCUFhtNkh4MHhWakJoWjF5TWg0b0x5eDdrWm9nVis3Nm4ydFdLcFBE?=
 =?utf-8?B?c1FLeXIwSHFFTWJjMnJyS1hWZ2RReDV0Uk5lU2o3cUc3d3dtY1p2MmJRZzZ2?=
 =?utf-8?B?clNsRWpmbTBkaUlnUTBCb3Z4NkxNclQ1YlZuNUQzM0RiYXdNM3RaYjg0WGZ5?=
 =?utf-8?B?RHhXZVpjTlZCd1lGcVVUNkwzNi8zSzRPdUtld2NiUWd1Q1VsOWlyTkJwVmRQ?=
 =?utf-8?B?UTlkTFlwTWVEZGxORWJJVWNOdjZ4OXpLeTFWcU9lNHNpWUFnVXE0Y3hOYlly?=
 =?utf-8?B?T1R3UnFKTkJsN1dObTFHVVlIL0tjSmVONlJTd0ZpYlhwb2UreHpGcXpCeHVu?=
 =?utf-8?B?VDdFdHRFREw2QlFSRUY1RUdBd29ZSUJFRXZQYmZIUkFtdG1WVmN2VHVkS2Qx?=
 =?utf-8?B?dTM5U1g2ejhRakZrT29WN2N1Y1pBanlNMUdEODZEVE1ZMDloR1NDWGRRN3pL?=
 =?utf-8?B?ZXR6dmZGYklSWHpPbUlkbmszQUl0RGpoeWs0OHltdDhtSHBPdWM4NkJmenNh?=
 =?utf-8?B?cHcrejJlMXZNL3NKbVBiUEwralFTYmpsNTZRRERoVTZIQUR3SHVlV0ZCNURx?=
 =?utf-8?B?am81UXY3TlU5VUU1OUhoYkVxQit5WDkzNm8zOXlIQWlYNUROTWRUMWlmUkR2?=
 =?utf-8?B?cy9EUlEwdGsydmp6R1VibnA1OXBrajhubG9yMUVHZU5BMVJKa1B4dVM4b2FD?=
 =?utf-8?B?Q1F1U2JXMkZJYTJPdis0MEJpZGhuTnlFanFOU0NTZWJ0VUhmNmsxU2lrT3FK?=
 =?utf-8?B?azAvNmU4Q0tJY09kRVpKWnJJOGdzVTUvNm1IUldtRUNZRE9hSnFsME5VWC9u?=
 =?utf-8?B?ampsQjRPQUJNT3NzbDdtZTIwb2o2MUxPZkw0N0VXV0pVMXFoeFBFRHVPMUlU?=
 =?utf-8?B?UkR5UEx6TWRkYlJQVXMvc2R2cG93aytLajVQVTVOMWZwNG9RcC9RZWU0SXpM?=
 =?utf-8?B?UjBYRmI1RlRzc3lCTVo3K0FTQ1c3NU44MUxJMTBGc0NoRm1GL2lsVVg5WFBr?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zMwb9K3yYcSpAedX9mqZGv2gUa5S8X9+5Sy3qTB29roe2X+FwHhw2cIDCdptKooF0sI3O1NnX2ThZG2dv/Sm/MOxRojllXp7GiJKWcvpl8D29UUPGQC5OJnzcoLJGIGDv7q8oD6DbD70JgUjpNyHosS9VOFF7LnwkLjvJoqFxPFooCk9cz3pn0YdSXn2St3kj24xZmf+z4Dh7IY5bCXa+BDB7wFOzlgj5rk6NLmHjwJRKO0DsWIFb72BoGxEbT9vvRZTChWBwAZuC5lOUOE+i8oZc8UIHqa1FHMhjNPz8Hg1qJS8NFPZITPIWdVdu+EnUFsVUe8HvhG/Jt2ydxZiTedXfYb3Qs+meGcNtbrmIX8QEqVfLyWFiuS2KvtGwkNBTrMAzv/V06SmBGxHXwHYit5aHkBJgeoFpACt6FUarJim2WqArCfNN1vR5OuCv37AypD8DpNygKwddM5O+Kvt3B3lFgmx8Vsr0sBxjjXpALD9X/qqbtkqDj9qf+GDIQv+kqoTW7s/x5Oz4wP3Y//jQms1gmu/zqjyDoVPcvlqVvqEGxRtR1QHezhHrUWn+pC0HciJXqdBsEDUANdl3CFq7tGVgQbxZeWoitbYsUrT0/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6368278a-8402-46c7-42a5-08dda78b74ae
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 19:25:55.7330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7gfjo6sYlnunUGfIg/c/Xnn5dkqjb/NpwpMnT+qi63ZPS6TEPZGdA4m+cfmcUVAFo2RjUuc04EzCUXMLA8oIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_08,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090147
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=6847354c cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=ThUPQUJpMK9mcTJM-PwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Xywuqi_wJ_c8U9aB8SO3UAm4MdQv3I69
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDE0NyBTYWx0ZWRfXyFpxzLyEInOH hxiCvEcBxwjmk4KGJ9wtdYIYs4dwdg8j24M/6Cohl5jnuYKv2twjVcDEiICjQZE7SeJfGlXicvI AwXkPwSVgxp8jh/ob86jVljoxLsSgD8FiIWqYBHfaN3+R/4kEnUvcipt76ywG+pYSB6W2lddiJ5
 QEXcZRCQn0uFROUIsmRUMwEHfMU3vAGqwZ7OdUJkNt6m2poc6fd65qfnsMkE2ehYR13Og8j3dJt Pqg/HGBJbx4UnzGbcX9kncBpDbNHCLAzINSmcovwiZcuY2Pgs3V7m7crcy6C84g7bnOHMq4LDYx kLMLWfp6unrTip0teznUfXajNSpM4eS+2rYGeT8+9HMyii+43vwp8698cTDva8hlwzPBUqRGkZg
 boMsMevRXtFhCB6Mfj1NMtnNygb7rhsoAmPpKtZ+IxZwMWvTOxf7+nihblFyek5Np+D68d6z
X-Proofpoint-GUID: Xywuqi_wJ_c8U9aB8SO3UAm4MdQv3I69

On 6/9/25 1:21 PM, Benjamin Coddington wrote:
> While investigating some reports of memory-constrained NUMA machines
> failing to mount v3 and v4.0 nfs mounts, we found that svc_init_buffer()
> was not attempting to retry allocations from the bulk page allocator.
> Typically, this results in a single page allocation being returned and
> the mount attempt fails with -ENOMEM.  A retry would have allowed the mount
> to succeed.
> 
> Additionally, it seems that the bulk allocation in svc_init_buffer() is
> redundant because svc_alloc_arg() will perform the required allocation and
> does the correct thing to retry the allocations.
> 
> The call to allocate memory in svc_alloc_arg() drops the preferred node
> argument, but I expect we'll still allocate on the preferred node because
> the allocation call happens within the svc thread context, which chooses
> the node with memory closest to the current thread's execution.

IIUC this assumption might be incorrect. When a @node argument is
passed in, the allocator tries to allocate memory on that node only.
When the non-node API is used, the local node is tried first, but if
that allocation fails, it looks on other nodes for free pages.

This is how svc_alloc_arg has worked for a while. I tried to make this a
node-specific allocation in 5f7fc5d69f6e ("SUNRPC: Resupply rq_pages
from node-local memory"), but that had to be reverted because there
are some cases where the svc_pool's sv_id is not valid to use as the
node identifier.

But otherwise, IMO de-duplicating the code that fills rq_pages seems
like a step forward. I can take v2 and drop the above paragraph if I get
one or more additional R-b's. This is probably nfsd-fixes material.


> This patch cleans out the bulk allocation in svc_init_buffer() to allow
> svc_alloc_arg() to handle the allocation/retry logic for rq_pages.

Fixes: ed603bcf4fea ("sunrpc: Replace the rq_pages array with
dynamically-allocated memory")


> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> 
> --
> On v2:
> 	- rebased on nfsd-next
> 	- keep the rq_pages array allocation in svc_init_buffer(), defer
> 	  the page allocation to svc_alloc_arg()
> ---
>  net/sunrpc/svc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 939b6239df8a..ef8a05aac87f 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -638,8 +638,6 @@ EXPORT_SYMBOL_GPL(svc_destroy);
>  static bool
>  svc_init_buffer(struct svc_rqst *rqstp, const struct svc_serv *serv, int node)
>  {
> -	unsigned long ret;
> -
>  	rqstp->rq_maxpages = svc_serv_maxpages(serv);
>  
>  	/* rq_pages' last entry is NULL for historical reasons. */
> @@ -649,9 +647,7 @@ svc_init_buffer(struct svc_rqst *rqstp, const struct svc_serv *serv, int node)
>  	if (!rqstp->rq_pages)
>  		return false;
>  
> -	ret = alloc_pages_bulk_node(GFP_KERNEL, node, rqstp->rq_maxpages,
> -				    rqstp->rq_pages);
> -	return ret == rqstp->rq_maxpages;
> +	return true;
>  }
>  
>  /*


-- 
Chuck Lever

