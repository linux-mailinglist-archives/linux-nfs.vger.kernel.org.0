Return-Path: <linux-nfs+bounces-12133-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300D5ACF1FA
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 16:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116BB3B001A
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 14:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EFA188734;
	Thu,  5 Jun 2025 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b1yUUjqh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="To4MktEe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCD31F956
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749133601; cv=fail; b=BFoYd6WonL2k66QWrfYfA1rmFx0EnCybXuoaEd1260wTcDV8PiEsT/QykFOggGxfk3/aj6pEzI1wZZtWkB2evp2SEjS6FdxrLUyRi1YYjSykFaJ0PckzFjRxDTCsKcz38caR96WJBfX1UPUF1LSebpG9TQ8IzdoLOPdeZeDfiGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749133601; c=relaxed/simple;
	bh=x1ZdMSCjPZRFgvCgZQolCpsSoJj5HISU2qS3e9G+AIY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UWdloIhmBZfgAC7eQEd+QbK44SiHaF2oj7ZJBZF1biX8ik1mfEY1o1cEVuEWKMtuAOHmD3H0PJfJLDeV4SMktL71RBeqto6hJcvAwju5uyQsX+/8M2RgPdHKPPSLmwus14jBufti0REkUAZV8gmbT/rEXa5H5HP3UQ+9olr6DlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b1yUUjqh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=To4MktEe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555AtWZZ026376;
	Thu, 5 Jun 2025 14:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=h/3Lxoj5WUEaP2vDKPUcE4M8JRCAFhhEgUFlSBeU23w=; b=
	b1yUUjqhCU96zJSCOdN0PeYl0MnbxIh/ImlAWMrQ22FjpIAEPQLLAae9PGRDJ71S
	E1u4qxCntPWs3ra4vNirIPuiGkD/zc5XsX2f59KBv4uUYMvxxw2RbypIEOFN/uE5
	RotWDnzbweHs6WudHTwu3SnKEno1v2OcFRuQ+dFY6gi+b/dtVnZr59snkymeI6aj
	6g3vxPI4Ne8sRfO3yDRJpbdQzCZ8Z9nD7xGbhwnW5hnM4JW9hF3UqVs68jejvl20
	HFKbT6mHuLup10xGJ3+kUfze4QKUObka2vt9hum/+CefdEhV6tUjSEfNJRGHGmw8
	vY71B6zgMigMM00qh2SITQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8ke9n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 14:26:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555DfQQu040614;
	Thu, 5 Jun 2025 14:26:29 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7ccmrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 14:26:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRLUwsL6TjCYl8dIC45B+eiJHCz5d6gjOmegYu9zeDPUOGBuNqKMmmJ+vPKVBRBRsdwHmgMNfcro2VMMv+nAphwBBvtt4oDDZSyv7JqX1bOW6kjn4nPeBre3jHBT3scvwQIcwRPrA0tb0T8UqQ9UDqpziXaE1taCvw0vryvNb7DMO1fQNa5leySxap+DAipNx0aXAzRlokJ8oJMphKL7pTkrge4ByXMGUbFWGWOPrtar7qp5WKZSrZBzuwMH/4cACdr/t1DL7M5Jdohp1ElovAFsSCGDs6v+3MY4i4qORu6j1bnUKBZeHP17hHFuYeGQI+n44UBnR4JQGv3QDorm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/3Lxoj5WUEaP2vDKPUcE4M8JRCAFhhEgUFlSBeU23w=;
 b=iUnj0h5xAGuAdEWY2TRlA1j5quPo7sSAN7abzcljdFm5+KIEzTMviOI/TVvjvlrXzYlxVmy6E/DFKksCBLm+HBmxzoj+CjuScOZ9BPBLMPW3509oxD+vnL0ETAuq4HqpXP9X71hvYSVVpx3f5tkAw9a28lwgEGpXzdlTsyuEAI/Qet0998u1FyIOyQcUlvZsn57hgrS4ZD4Sq29eVMwA7EKYKm1xMZTr76CNlBNO+5lmQ9CThuc2EHZrDjiXz41N4cWK403InDrWpDGNk+VO0REjVkYm6KPPzE5tBkcN93cG0e4iGEy/MQbBu8AvBZZO92RscgT7dluRPTlh+D2JWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/3Lxoj5WUEaP2vDKPUcE4M8JRCAFhhEgUFlSBeU23w=;
 b=To4MktEennGZomeq9Wfbflv5nOpUbVqOwYhMqpxwix7XAarSh46ey+1XU0tCm2J28yRlcRuPvA+vptCcqZEkrzWFzFvB0WVFJEKH5jHzAeaiSIz0UWxQDK9NK0+MBp9Kvva3v9M5r2cGN35X1RZFYsqwNXnMot8sOmfJCijO8D8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7832.namprd10.prod.outlook.com (2603:10b6:806:3a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 14:26:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 14:26:25 +0000
Message-ID: <cdb4ce81-c05f-4e60-b351-34d713a51e96@oracle.com>
Date: Thu, 5 Jun 2025 10:26:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SUNRPC: Cleanup/fix initial rq_pages allocation
To: Benjamin Coddington <bcodding@redhat.com>, trondmy@kernel.org,
        anna@kernel.org, jlayton@kernel.org, neilb@suse.de
Cc: linux-nfs@vger.kernel.org
References: <458f45b2b7259c17555dd65aa7cdbbf1a459d5e6.1749131924.git.bcodding@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <458f45b2b7259c17555dd65aa7cdbbf1a459d5e6.1749131924.git.bcodding@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0307.namprd03.prod.outlook.com
 (2603:10b6:610:118::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: de929ab8-7922-4de9-2acc-08dda43cf41e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UkJUaTBOazdFWG04SE9tSi9kSFJGaDd3RTRpWlpWRWY0WUNzaTE3SmRQYTJP?=
 =?utf-8?B?bFk0NFE1QWhBVVpWT0ZWaXNRMDlqNVBFenpPVDdqeE9EeFhUQ2pzTk5aNGZv?=
 =?utf-8?B?eERPSGlCS3FSemFQbzJEQ1R6c0pLb1FsODU2ZXloT0VuZFJQSjJ5bStzVUo3?=
 =?utf-8?B?MFJDZkZhRkJIb0dtTkRXZFpNaklBZU9pMEs4bFZ5UzFBVm5tQXE2ZjkzU2N3?=
 =?utf-8?B?T3VkWVZlemFsNk1LUEQybFlxNVN5ZUJxWERFOFNoY0wycWFRV1dyYU95S1NL?=
 =?utf-8?B?aUJLTEFtUktST3BZRGp3UHBYaDBRSGZEbllSTk5VT2t1UEZ4a0Fqa0xtZG5W?=
 =?utf-8?B?OGJ2cTFVcGlSd3M0WjZXR0F1VVRFamFtVGlSaDNJRjljcGxwNU50MmwzSzEx?=
 =?utf-8?B?NTA4MUh0MTFNSHpkc1BrWVJvVDJDMkE0ellNNzEyczBrdld0a3pZd1hyMmpi?=
 =?utf-8?B?MlVweHVQRlViU2oxTUx4MitjRENuK0dVUXA4UXdmVFc3NGR3OHJmRU1RRGhI?=
 =?utf-8?B?UkNZNHBZTXdKZTBSa2x0Yk9jREsxbk9OWWlZWTRWaFd6alFRajVHTEZHeHpu?=
 =?utf-8?B?QXRMNjZweFFQUEdCREVPWEZMaUtjL0k1YnVVVHFzVkluTmg4d1ZnZTNjem5v?=
 =?utf-8?B?VnNxKzlGOGJvVEVybEc3MEpYUW1LUUg4SUZQZXQrTHk3bm5XK1lCalRYMEFT?=
 =?utf-8?B?c0VpdEMrcU1ZVUF2QlpNVHA1d2VKSXJZV3NSM1dFUVVDMDdVUjhwczhjQTZi?=
 =?utf-8?B?T0tmNFB4Y1pnMXZ1aU11d0NhWGhsVyt6Mnh2YXQwZ2RrN2Z1OG16cC9Uckd1?=
 =?utf-8?B?MGRDYXpvK05GMzFhbStIOE9jdXZPUDFNSktpc2RyOWZ0VnEyTnVZZ2pNMzFH?=
 =?utf-8?B?ZXhLOFgrelNUdnErb0RoSy8zYmlaYW43S0RrRHhyLzliWUtmSUNvZjZEcUdV?=
 =?utf-8?B?VnF5L0JRbzU2YUZPMllGU2N5TG44YmRDQzYvaVVWcGl4TDV5Z1NQR0hRdGNF?=
 =?utf-8?B?dlVzQ1hOeEF6UXJNN0RpdXJ2bUNFNURrekF2dzRocklsU3A5UStQY05wVVFH?=
 =?utf-8?B?YTJFQXpSUklpaFlTa01vZkk5L2tWS0NqcXRKZ1dqMGpDVHJzWjloL3dCOHd1?=
 =?utf-8?B?K3VuWDdVbzlZUE1CZHhaZTJMc014K3dzaGwxL21Kd3h2Z0pqUVNmenhBbkZS?=
 =?utf-8?B?djE0K2QzMXZsTFdUMmZ2OGxIcFBaL0ZIRVVnKythWTZqcGdYaG4zVzVTdjFl?=
 =?utf-8?B?TGRUdXc2R0dHTlMrSlhSdHBTZVBza1pRcVQxTUhtTS8yeFRrc3BzVWE4VFFl?=
 =?utf-8?B?ZG80M1REZDd3cVlub1RsNXFlNjQyUGNFUWwrZnlqb096SEhaU0IyMGpjUTlI?=
 =?utf-8?B?MGRvcU9aSzdXVHlFV29DSDJQaE04b1hFdCtXaTcwRnh1SXRxd1laQ0pFYzI4?=
 =?utf-8?B?ck5zK3MzbW1DdnNIVXNHM1RaQmFMUklxeHFuaUVRbDRjL0c2VzNIT3lIZ2dM?=
 =?utf-8?B?bW14amhOczYxMVVldm8vNEVtY2NtcldDYjlxSlkzVW1MRVFhRDdIRlh3bVl5?=
 =?utf-8?B?Nk9sRU5scDRBVDRtZ2VtMWtSdW1sVHFNNDJZZE5GekFObGVBZzhaaXdQL0ZZ?=
 =?utf-8?B?ZXdDaWJxaWJ2N0ZPOWRLamZXL0M1TmkzY1BsRUFQSXYzKzE3M2gxZ1BTSnBO?=
 =?utf-8?B?K1htUGxOZVlxSjdkaEhkK3FUUjRFY3NlUUZRUEdKNDVDYXlabDJGSEFWWXNl?=
 =?utf-8?B?Q01xYitwZFdtTDFGdDQybnpRb2ZpNWJLalk2aVEyWFlCV2NDMDdDWGxPbXk0?=
 =?utf-8?B?OHpSeUF5akRYeDJvU25xalJEN2pIc0lBeUJqUFFqTmdhTFUrSGNMUy9CcERT?=
 =?utf-8?B?VzVuREhzT0Q4VG5yVVcwbkxBcm1DUnY4UHZtTElsZURWbVF0UFZmRisxMmc5?=
 =?utf-8?Q?eNsN2ZG7eao=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cEhZdlVYY1p3akJhY25TMDloL21LQlFOUCtWQ1lVKzJ2bnZDQngwMm50dlRz?=
 =?utf-8?B?d29uSGhhUkplM3dScjZ2VENZamVzZXQzRXl5MVRQYWNxcGNReEY1aUVwcW5z?=
 =?utf-8?B?dkZQV296blRsNkhzSEtRcFRZdlExQlBLQlphQ0dhL3BUNmNEekdrUE9WOG1L?=
 =?utf-8?B?TitIMmoxRzVIdks4SDJVa3BUQjk0NmxyZFhnZ3RCbXRTbEFWZ2JzNEs5UHBu?=
 =?utf-8?B?ZE56QWhKN3YwSGtVTjdIT00zTzNDbThKbzJsUDBZQVZhdS9RQlhoMmNYVTBK?=
 =?utf-8?B?TTAva0lrcFNFeDhPSU95VjR5aXo4QUdqR293ZjVKakx4eDJHWW45UjJsSmtq?=
 =?utf-8?B?M21PZlR3cHVFVTVPbWJldDN3VFk0ZnBsa0IzSDJUYU9BbURCbHUwb3RLSUlY?=
 =?utf-8?B?aWlNbEZRalFlcWRUTExTSDNucVdvWUhmbDkyamtWN1FXOU4wbHByRFBxSzZn?=
 =?utf-8?B?cDcwbmRtOWpDYXY2OTNRK3BwTzgyd3Y0NnRVdTMvTXRyWVZlWno4dE43QVpW?=
 =?utf-8?B?dkdMdkQrTWVQUUhjSjIvQkF6SkVXbEFTelQ4SC9UdmNCNDNwbGZaa2htQ3Na?=
 =?utf-8?B?eTBwSUozUDU2eXAvODFBeUxCU3BTVUdUMi9HTmtYZDVLUnBPNEIwSmVhczBO?=
 =?utf-8?B?czNoOE4zOGRwRHBxUHA3L3lpSlNWb2ExUk5QNDE0RGNZekVYVWFPM1RXVmV3?=
 =?utf-8?B?a2J2dVdTT1lsbzBVTHJYMTVOVEh3enNwNzRuUWxsSkhwMEsveGlCaXo2WGRq?=
 =?utf-8?B?UndsbDZTRHJCZGRJSXg0NGRVS2kyVlYwalRHYXBxMmZnOWY2SGZZaE5oa2Nw?=
 =?utf-8?B?MCtPQko5aVdPZnF1QWtVYmZtQzMrU3RXQ0NBUWFGdFd0eHRidStQOE5RbG5q?=
 =?utf-8?B?aDR4ZmczR2pjeW80YXhTdTJ0VlBKS2Vzcm5aTnFMSkEvWmlQdUpZSGRhcEZV?=
 =?utf-8?B?cEx5YSsrazFuUEMyb0VRTFZhU2N6TC9OYkp1VFk4a092WXd0Zkp6dGZDMHQ1?=
 =?utf-8?B?dGVqLytlQXhWNS83QTZVc1lPM0xDMlFHMGthUy9oVXdaODViT09sVDkzcFBo?=
 =?utf-8?B?NlZlb2FoQWxJTWVOY1Y2aDloWEczOWlGMUlHVXZnUnp2ZHRFRUNhd1Uwck1k?=
 =?utf-8?B?dlByTkIvN0lhNFRTVEJwQ2k2SExPY2IzUTlEUUtFUmhzQVpZcWp6ZmV6aDdK?=
 =?utf-8?B?L3dTNUcxWEFKL0FxN0xONjBJUks3WmE3Mk5HdXhGWkkxbnE5akpnOXdjSUlJ?=
 =?utf-8?B?T3FKZXZBNlVHYzZxRkdJZTEyRkV0eTJOdWJNbTU2bUtXbWJTNmVwQWg1Tm9P?=
 =?utf-8?B?ckJ3SWFpSFFTU2JOUTRHV1puWWU5cEQyL0dmdmdWR3JBK0FqZTBoY0VBS05t?=
 =?utf-8?B?cnVJZTU0TGN5OG5tR2RoRHZkRmY2M21oT3lCc0VpNC81TUJqQWJCbkxGUXZu?=
 =?utf-8?B?a1dTV2I1MVhRaDVDS0NuWHZLeFRKMktTSWswZFZKWkN4MTJqWmtUc0JlZ2lJ?=
 =?utf-8?B?WXUvOFgyZXIvejV5UHp3a2dXaEtzYXRXR3ZOeThwL05PcFRjd0ZSWHE2akpM?=
 =?utf-8?B?N0c3ekMrbXhFd3h0YnV6WWVIUEM3QXFlc0F5M1V2R2c4bTYvVkQxVFlodjZI?=
 =?utf-8?B?V1JqbnRsSVJvbUwvR3Y4SWk5c1E1d3ljNnhRS0EvdmxOMkRvT3lmTHU2R1Qr?=
 =?utf-8?B?dEZxNk9vbGhvSGNNNkg1THdzT2FJTklRNEE4a2hDN2lFaVJUSGlBMWQrZC9D?=
 =?utf-8?B?emxGM1ZXdWFQeUFwQ0QxS2VNY1F4Und5YWxnbDdDOW5DZG1WNzlaZTAwVSt3?=
 =?utf-8?B?V1JVNzROYjBqbVloTTRWVE1KOUN1bEI2UUl0aU9SVEZkbWE2TGpnQnN5Rytl?=
 =?utf-8?B?MHZlb3ZFSnUxcitKTHpaVDJWN3ByN2FIbmJXVGlQUVFlalY0TXdvYlVRR1kr?=
 =?utf-8?B?dlpXcyt3c1ZxcjN6bVpiUlhKWEQ0SEd4N01ZYkJpRUdKbEZ6WHpFVFg0bGlO?=
 =?utf-8?B?ME5pbjU1SFc3L1BSZ0xXTXczQXJmcUIwMTZPMlFFZWlRUDlsS00yU1dpL01j?=
 =?utf-8?B?TXY2YnRGWHJkTDYvbVlOWFpmYTVrVTU4VDN4bzBxR0orSXNMa09FV1FPQmpK?=
 =?utf-8?Q?oLVfE3NrauFew/aEkVp1jqOtF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9c/riNvY2rhC++SYoVRzpYomgBeOXnGGOcRo/q51RATERg2wgRT7FpUSitypm40XM/gCgcaIUsNZZwjqq/oiTxwOVHcneNlo0aM+qw3nYjpNQAemHVcR8tQpLNHCPXWZKZSwLcpa5SEVkYIchOCdPpLegMwn3LtmRPBSkmENCdtFFcp5214KcDSoaA+BOoJkLO/D6ZqNFcbdFmaN4fi5P8cLADHZkDtJe9tEKdKUSOfTOA8A/wcsmDeObObrYoQMbWkUhI2hS++biA9gYABMPNA9lD0Nax44mbn9wVh0LAwaIAsm5BIX5qeqL7xwldp46Th7/2FCYNVJI+7QZr7L+rwMXR2bxIVoLxIlSE3PRjgSm+fXMlVQKLFpYdnzww3nrfwAUhgICoYUOV6ZdLWdfEFpcovlT9m1aul51Z8wJooWltEbilX3vd5iy1KCld1bIEwmWhKRBfDvQWPR1dttHXJ31OWWA4HareF9DxE8B72aOpn+SHuopnItpt1iwBcgcGfeZA94Mgl7BcsXftqD0Q4CvQUoAlE2Zf6HRVhF3f9ScGXRj1z4Q3P4eOljpAk++UGwqQ85RrnVm9jsRBPuXnUNAACGcLpDKmq8rsSJLOw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de929ab8-7922-4de9-2acc-08dda43cf41e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 14:26:25.8835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +71vuSUzr84A62EA+m2i5xaQ3Ewb6Tvt845wN2acehcKfp5s0se1h/OeA83WaQXqgOlvf243i5n8PUSmWeKRVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506050124
X-Proofpoint-GUID: 1wZaFCs9PSBMU7QEe2EbblxQKrhwHMP4
X-Proofpoint-ORIG-GUID: 1wZaFCs9PSBMU7QEe2EbblxQKrhwHMP4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDEyNCBTYWx0ZWRfX3EWno2FEsscD 1pUGZ3LM9tuweq14vf2jWs96GLKke2mtGlsWZW1rKz5pcxNq3vwQWJSgAWazLYkdHAksuBoPOBC NLTqim1U3MpXvaO7vuoJDeWODM8ZwqaBkWFvkvCr9ykRTY82JCG7J7oIVww7j6wd1GFArldxiR0
 QbXXYSv7GRIU3Z/Ajg8vQEieDxEQZWAYBBZC+MQ6gyUk407Ij8/OnnewgaqqWybWPkDWaXfOkKx pu8xcdS5DerVJr41pJckBb1Oo05Ygki8EQ5ZMA3FC2VRDtC2bG9ZRKCA6P+htc+HTeRRC7qpsk8 kLWwbFiCLiWDwRIHWsasZWdK3gh4chaWfVLFS1F1t71exRXWreOJcC7DYZAYTbi5YMqcHA9KuGZ
 KmhmMxEQe0tzxo83Ljsv9srzQ2h/kvifd1VrQplRBpNGLlVICbnYBJJZK8wSQdxF1NdfXWpD
X-Authority-Analysis: v=2.4 cv=FM4bx/os c=1 sm=1 tr=0 ts=6841a917 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=5vPHuRZpuGujVJ-fJXwA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206

On 6/5/25 10:01 AM, Benjamin Coddington wrote:
> While investigating some reports of memory-constrained NUMA machines
> failing to mount v3 and v4.0 nfs mounts, we found that svc_init_buffer()
> was not attempting to retry allocations from the bulk page allocator.
> Typically, this results in a single page allocation being returned and
> the mount attempt fails with -ENOMEM.  A retry would have allowed the mount
> to succeed.
> 
> Additionally, it seems that svc_init_buffer() is redundant because
> svc_alloc_arg() will perform the required allocation and does the correct
> thing to retry the allocations.
> 
> The call to allocate memory in svc_alloc_arg() drops the preferred node
> argument, but I expect we'll still allocate on the preferred node because
> the allocation call happens within the svc thread context, which chooses
> the node with memory closest to the current thread's execution.
> 
> This patch cleans out svc_init_buffer() to allow svc_alloc_arg() to handle
> the allocation of rq_pages.
> 
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  net/sunrpc/svc.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index e7f9c295d13c..e14f2d5c15bf 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -635,27 +635,6 @@ svc_destroy(struct svc_serv **servp)
>  }
>  EXPORT_SYMBOL_GPL(svc_destroy);
>  
> -static bool
> -svc_init_buffer(struct svc_rqst *rqstp, unsigned int size, int node)
> -{
> -	unsigned long pages, ret;
> -
> -	/* bc_xprt uses fore channel allocated buffers */
> -	if (svc_is_backchannel(rqstp))
> -		return true;
> -
> -	pages = size / PAGE_SIZE + 1; /* extra page as we hold both request and reply.
> -				       * We assume one is at most one page
> -				       */
> -	WARN_ON_ONCE(pages > RPCSVC_MAXPAGES);
> -	if (pages > RPCSVC_MAXPAGES)
> -		pages = RPCSVC_MAXPAGES;
> -
> -	ret = alloc_pages_bulk_node(GFP_KERNEL, node, pages,
> -				    rqstp->rq_pages);
> -	return ret == pages;
> -}
> -
>  /*
>   * Release an RPC server buffer
>   */
> @@ -708,9 +687,6 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
>  	if (!rqstp->rq_resp)
>  		goto out_enomem;
>  
> -	if (!svc_init_buffer(rqstp, serv->sv_max_mesg, node))
> -		goto out_enomem;
> -
>  	rqstp->rq_err = -EAGAIN; /* No error yet */
>  
>  	serv->sv_nrthreads += 1;

This doesn't apply to v6.16-rc1 due to recent changes to use a
dynamically-allocated rq_pages array. This array is allocated in
svc_init_buffer(); the array allocation has to remain.


-- 
Chuck Lever

