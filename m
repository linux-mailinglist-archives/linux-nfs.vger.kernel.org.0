Return-Path: <linux-nfs+bounces-11898-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9ABAC35F2
	for <lists+linux-nfs@lfdr.de>; Sun, 25 May 2025 19:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC9E171BB2
	for <lists+linux-nfs@lfdr.de>; Sun, 25 May 2025 17:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4CE1F4611;
	Sun, 25 May 2025 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NV2Uc4W3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VWHvsEL3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC0433A5
	for <linux-nfs@vger.kernel.org>; Sun, 25 May 2025 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748194195; cv=fail; b=SjUsofgUz7WqpEH3B9ruBHoQdPGMBS+h6/MYvou6taFXNjWe3bWr8KhOa+H8IlEif/ISbipNM8jXVuoQvlNE3VI0Z7FDm33wuMvMWKWhecoSAakGLa4zE/CDtD8iSBVa0E4rmh1IHeJLbrpwGYGwGCfs3bydeWd38kk3qoOfqbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748194195; c=relaxed/simple;
	bh=mJnmI81vrR6msdtNJdLxHlWIyuzjmbqq374HOkWXpcE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rokhemxdBGJ1UgCKNmMXiql7a6Oz9XK+fLHrH3PCZylSOLisA8KXUiOvUqLlDcPmFYG3LB1jXnXFPryKCDSgtZ0zhIpRQGCYwQTFYTt46ty57cuBBrD8t2Vn8lXxo2Ot7D/pQQDMVc3dtvCnhUeglxq0S19jEyFC92hwDXlfMT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NV2Uc4W3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VWHvsEL3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54PDjjug000663;
	Sun, 25 May 2025 17:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ojwPdKyn1r47YYCoLzpkpW9hmp1xUwc4H038qKRTzxI=; b=
	NV2Uc4W3oPW/FEsEB/LHBBYq6YWlNuKyNbHyTcEK/tTt9J3jhohnwizfDyPfPcBO
	6B6ZCe9/ywgzjcrVT/gDqPtKStkUSMpO1dKWinuhi1m7egVQ49GBV00Mr0b4VID3
	L2P2r8hn/Gb0PNlrBY2PaXKwDK4+Rp8YiMw1zdO+J8nmaK45wz+8UUl471vSjaYC
	8yHA4DP61ISLVBFfDrRgfn+qcCRwBUfY+aaJ6Ym5O1pEJM89Gp5p5gAeFav/oQKr
	2ziZVGzcbIrzkJgv1vsU9FyN/N9zrwNlDOFQMaHumW5WXT2b1zmOB5TUrjJWSkL/
	ZFtzunFFKLLyydyen7YkqQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46tr4e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 May 2025 17:29:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54PFhjs0023126;
	Sun, 25 May 2025 17:29:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j73810-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 May 2025 17:29:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8XPa/xqL5UeEm+hrtioI/ic7SFSSNBwiuMLHGMo2JZJ1GXCzoPXVZ71TYbTcoOnvX64EuoIY60CsrhrsfUpxpgLBDuLtkbGMYyj/tn4XGSfDQoVuk/wq1cj2JvJfivABcFjT3or7DrZ8e4dn7E9rGvHf0YE47lZ9ffu6gRSG4QJWdOnV7tXcZU4d4+MD5yAsZ3Tfyl/ya0AxduqtUr+EtUVAdbfH/edFMwlnlq4Ba/QxwP9sjN+yNVnhVTVq6UbnSK0xacu9/RYWEr5dVMRytYhs/ZMN9GZFXc6JKoxbHVxCtCweyE0S7jzIg2f61cFVttQr4W7uRWAsMSTu+CcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojwPdKyn1r47YYCoLzpkpW9hmp1xUwc4H038qKRTzxI=;
 b=WQjA+OHc9pZum+Y66Ub4KwXZXHr4kFTX9fmiI+hmTfrTNZwaj8Iozqzb0iAOb5zcNpskWYQv4eimuqHuxCsco/ZtTl5UzPciC/vYwjxj3Z7M0qsXVyXXfP5SLniai/GyUtRuEkSv9UOCr8c6cEhOhItnXw8Yf4ArK0QIRsqtpPuztzO9vXl2dPPENS4E1qRYrbqsVAT1wt+wKbHtLmH42Zzdk4lO+AUOogtIS3SvK9dPaRyzAL44s/+yjPsy7YiA6Pw96Z2bicS2W39B5ths6YYFdErko13YFznUDxQaKBsoUx6zGBrDMOr3czxVwTEmINWJ/Frqd38ZAsYJmxZQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojwPdKyn1r47YYCoLzpkpW9hmp1xUwc4H038qKRTzxI=;
 b=VWHvsEL3QvxAwFRFoJvcSZgsRyDQaRhNoLs0lXUt+3zLRVZo+At3L54bM2pJ2oVsVS7bs+4dfBDEkaEsA/rbQz/SmZjnlyGokrAZVn73LZVWy5lVCCBJk2RfEVdeCVCLmhwAhEAE0zJY5rZ4Y3/h1IuYMNR89jwRnKL/6sRjb7s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB7475.namprd10.prod.outlook.com (2603:10b6:8:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 25 May
 2025 17:29:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.031; Sun, 25 May 2025
 17:29:38 +0000
Message-ID: <d539c502-e776-460f-852c-8af9722ad9f8@oracle.com>
Date: Sun, 25 May 2025 13:29:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
From: Chuck Lever <chuck.lever@oracle.com>
To: Rick Macklem <rick.macklem@gmail.com>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
        Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>,
        linux-nfs@vger.kernel.org
References: <02da3d46-3b05-4167-8750-121f5e30b7e9@oracle.com>
 <174763456358.62796.11640858259978429069@noble.neil.brown.name>
 <780a7e7a-b8c4-4ebf-ab79-d1480afb6b6f@oracle.com>
 <CAM5tNy5Utc5NYbEY+E_g91Hsfa6QiZsEo+MEwKHzvryQxe+j7g@mail.gmail.com>
 <8aa0e4bc-c95e-469c-9aeb-59e2f103a604@oracle.com>
Content-Language: en-US
In-Reply-To: <8aa0e4bc-c95e-469c-9aeb-59e2f103a604@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e901195-fb66-41ed-2f2c-08dd9bb1b9dd
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UUs1MHovNFg5b0xwcmlLckl0MENqM3U2NnBadUUvTDVmeDdEeFYyWWQ5RnZG?=
 =?utf-8?B?QklXdUlrWm1uL0IzOTRibDFKTHFrV3RPY2Z4UExxTi9ZMkJKVGVIcUwwbnNi?=
 =?utf-8?B?RnZTdTA0M1A0c05NNjFWeEI3alRJeHV3VHRPd2dORmNJNnJTL21zZU9KNE1N?=
 =?utf-8?B?NW9zYjF1WG5NL3R1dEVreE80OUNCT1hLVEhDbWRWczQxRzdKd0lOUEJvMHFp?=
 =?utf-8?B?aVhxaXo1cWlMTEV4K2x6dEJPNVZFS0NQQU04dWhiSjB6eGZDQnF1SkFrcUFE?=
 =?utf-8?B?NU9nWmhEeHB3WTF3MnVLWjZMbXIyWUJEUEpvblI3RGFxNlFXOVZUZUQzQlZD?=
 =?utf-8?B?WGFBeFhkbFFLRnlBSHhhVEpwbTBrOGtWc3Nxc0ltSVpzQXhHMUhyNVhKc1g2?=
 =?utf-8?B?RENqSmpReEIvdkdvTHJuQkVFUWMzTHE1RWovSWpnb2JDdzlKTzR3SUhma0FW?=
 =?utf-8?B?NkR6RTBvMkZFdkVoMElReGoxWUI1MWxYU3o3NUxOTGFpUlIzdW16U0hwWXd1?=
 =?utf-8?B?aG0vcUVBV3d6TnY3VWlOQ3ptQ3NVUkVZRGxraWNPOTZDZS96cXZsUXBOT3py?=
 =?utf-8?B?TXhVNk1vaUxsWlVDUHhaZG5MR3FCditiaFN2Um44OGtLRkdJVlZTemJEK1Rn?=
 =?utf-8?B?RngwMXEyK0xpZklreEFjV2k5WEtsOTl1L2lLeXp0RDlXemt0MGY0Y2hLKzVN?=
 =?utf-8?B?ZE96Yzg2UDUwRDlLTmVvdVhWT3lDbU1DaUFDVmNIeW10WnlJb0w0Tk5KZTAz?=
 =?utf-8?B?WHBxeUJJdlM1VGVRdzloeU80TUo3ZWRqdk9pNGQxbzJaM1Q4UkxmOEhMU2lL?=
 =?utf-8?B?bzZwYWxZT01nRVZocG5RRHFSWjV6YWxxQmtCNG9PWnhzTUFsVjVZZkg2U3hI?=
 =?utf-8?B?MmZ3QUs1S0w5UmtQWnpoZkNhbHpocE5pbFB3SWlpOHVjL3NaNEFOZGZYOG5M?=
 =?utf-8?B?eHAxNldXRnRqMCt6M0diMmtnZ0Q5cDVtSVppY1gvZGU3SzRUT1ZqL2JrMzlN?=
 =?utf-8?B?dGxQQkNmaDhVcUV3UGtKejlzVENOd3RuQ2JXdnE2YWVUZnNVZmJCK25zOVJQ?=
 =?utf-8?B?V1VLRWNva2hTbjluR0MwbzRFa2Q3aXNaWXZRcVRZVm1EZGU3NndoQjdxMi9O?=
 =?utf-8?B?NkFGdk8wQ2VxRSt5UXo2TmxJRU0zZUNGQmp2dnhtNlE4RG1BYTFTa0hPd250?=
 =?utf-8?B?YmNKVU1RVzc3UmZqRzQwMmRJdHpUSzNrR3pQRFk4a09id0dnTHdvbjMwbEhr?=
 =?utf-8?B?L202TndVaXc3V1VKbFVMTnRwTmc4RnIveVpwb2lQd3BLRkpBYWc5ZGg1SFJH?=
 =?utf-8?B?U0Z1STN1a0Z2RVVFQWNMN2VwZ0JVdndRZ0U4aUJLTnRzUkQydFBreG9KL2lK?=
 =?utf-8?B?N05sU2ZDRHhlVGtyWDZ5aUhpMkFETlNwUVdHNVYrWVl3T2xOUXBrV1R5VDFv?=
 =?utf-8?B?TmJKdC9WUm93MDVLTytvOGdFaXdMSzhJelFRRXMzNUtTRzNXNEkyTVRoT25h?=
 =?utf-8?B?RlBKVVpoTnc4R2ZjaC9Fa1hacmVGWE1kY1N5VEdEcG1hM0lpS3lYQ1VLZkd3?=
 =?utf-8?B?QStrb1FTU0VOeGt4R2VGQTRPU2MrRDkvOUE4OFAyTDVxUDRxUjJCTE03cDVF?=
 =?utf-8?B?WXExdUJsMXJmRTE2RWNydWpENERwZ2xzM3Y2dmg1WmhCVitMWCtBd0d0TW44?=
 =?utf-8?B?djdrNEFXc2NxY1JiaytiZlgwcHdMK2RIWm5MdHJybXh3K3JRdWxvV0tTaXR2?=
 =?utf-8?B?bzVvL2lXVS9QQ1dxZWl0eUFFaGNlaEdRbFJyTkdDVSttSWc3Q0R3d2pqa0pJ?=
 =?utf-8?B?S21qN0FWWE8zQXY2bEgvdDRxS1hqL0hycmpFaksxc096RVNXWUFHQTU5aXhI?=
 =?utf-8?B?amVoU1kvbG9JbzZUQjFUT2tBL3dKRzhhd2w2MTRRL3lGUzlXd20xcHFDQW5o?=
 =?utf-8?Q?lUb/r1vUYMk=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZGJJZkliU2kzblU1ZkVUUm44OGVQa05iQ2pVNGpxTmd1a2xoZ3kzT09rNUZX?=
 =?utf-8?B?VUM0Q0xLKzBJcHRZYlJiVUx6R0JKbVFFSVJvQ3NMaC95U2pYcTkycWhubkJC?=
 =?utf-8?B?T0tGY0MxbkF4L2ZjK01aeDRna1ladlprd0poWnVmWW1MNXp2OUdSZWJKVEpW?=
 =?utf-8?B?blBWYzNoTENnZHZTQVhwcy9ERFB2QjliTldDaDAybjBid3VQRGlqSTFBdkFK?=
 =?utf-8?B?eS9MMjdEY2JVS29zN1U0M2JzVSsvbVYybDNvLzVJTW1xVG9JTUFhL3R2R0x5?=
 =?utf-8?B?aG83L1d5c3V6WCt6RkJFajFlR1pBUDlkZGV6OTVrdmZnbXB0QmJZTTB3allM?=
 =?utf-8?B?ZDhlTm00RXp2RHpPMWh3eW1yR0RyVExIVDZDQnB3WEozNWE3MmxUdHZvZkpO?=
 =?utf-8?B?THhzYnhOQjFYNXpTRTd4ak5iNENDaDl5MlUwWHJiUFkzbldoc2NkbHZlTjBF?=
 =?utf-8?B?N2FTUmNYZ0ZuZjZjRGloZVZjK0g5N3dZbGkrOGtsRXUxQjg0SkYvRGREa2ZB?=
 =?utf-8?B?cit3YzZ2MnJMYlhkQXJlSENvWEVreTZoZ09PTkxmNUhaTzVLNDJHcGd2MnM3?=
 =?utf-8?B?YU9OUmQxV0tldGZpVkxSYXZBNG1QUWw3ZklQSGh1dlBMWktBRW45T3NIaldi?=
 =?utf-8?B?SEFYZURGR2xOZ2ZxM2dJLy9QM1RSeE1QaUliR1F2RUdGSHJnN2JyZS9yQ2Ny?=
 =?utf-8?B?dk1LdTNIWlJEQUJIRGJBaCttdkkyQnFwM21kRm1Hb0plRXVwbnJjLzB3bUpK?=
 =?utf-8?B?bFVyaW03NUd0dCs4a0xiZGs3UlFSNVFXOS9VWU5GYUlMUEU5WjRWZWpzSHo5?=
 =?utf-8?B?aS9hL2Z1eUJVdEZRUGFXV3V0WWdwMS9yMVZndmVoeGpNZmo5aHd1SGo4MG91?=
 =?utf-8?B?SXhPRk5TRW9LbFpSMitTNUI1R21vaUY5a3RMS0gxRmFyb1Z2V3I1RU5HbWhv?=
 =?utf-8?B?Q0tyOFM2ak5DN3M0UUQyVlNCTlNacjlvR0Z2RnZjM3ZGeTRZTHlEazdjVnNM?=
 =?utf-8?B?dXU0OUEya2JVUWMyd3g2NWNSZVBSN2wwVUQxWG0rb3dUUFo1M2E0cjdYVGZt?=
 =?utf-8?B?cHRmMTRGa3ovTzVwUy9raHV6eTcrdnFEOEM2UmxCM3h3OThJaytqZlJxQ3ha?=
 =?utf-8?B?RWpLaENqdmIwZ1kvbWRvNkExaFdnOUFyNG1PUDd3bVNOcHZvZXAwa3cxNC9D?=
 =?utf-8?B?eExxWHRzckxPOTBIcE5zeWJ6d0ZzcXF4L1p5R251R3FuZlVaRXFBeWhOSjNm?=
 =?utf-8?B?Y3ltYitnSVdlMjhYUHFuQmtwbzdFdlQveHdVZ1dTM1dUVGRNS0ZVY1I1bWda?=
 =?utf-8?B?TDU5VlNJRndXNkRqQytHa0N6WmRQVTlSTUsrc3EvcENDaklEK0pQMC9KY0Yv?=
 =?utf-8?B?UXdWQ2FZL0M2cU5rRHVveS9TdkVIVEJvaitZMFlybjRKOHliRFV5S0tmSzBy?=
 =?utf-8?B?VUZINkFvdlJxOVZ0RXpPKzN6YXJVYi9vT0JYQTFncHpjVUk2TkFlREt3Tm95?=
 =?utf-8?B?T0FqMTVXWVVSWG54ZWFFSjNYRzdvVmpjV3h0aGRBUlJ3dGRlcFNDYUl2UFZN?=
 =?utf-8?B?K0NhZEdkYVBsZUZuL0tsTE1LQ3U4MTFCVzY3M1lMSHlRTWtrb2hxcTF1V1hl?=
 =?utf-8?B?dFRlZm1YSXBNSlpNc2FZS2RwQUFvRkJYUFVWSVJ2S1R1ZU5zOXRNcDUwWDFw?=
 =?utf-8?B?cEFNMmUxTHdyV0NZelFCcGp0TVVnS09LVEkzdnlGcjlLeW9EUDBJRDdUTmEr?=
 =?utf-8?B?Y1NwOFRRbi9kZWcreEJ1VDIwRENyaFdEaHV1RlhHYk9Yb25YdFBNZGkyOEtw?=
 =?utf-8?B?a01zUC95MU1SaFFlTnBmU1ZHQ0Y1eW83bk5HaVZoQXdqL2FyWEJUaVIwNEFT?=
 =?utf-8?B?N0gyR0tId2pYMDB5QXl4K1JBWDAwZFN0dnl4c2tNMGlCMTBqVlRLVFg4cVF5?=
 =?utf-8?B?ZWdJZTlZVTRDMUVwSS9yWmUwZk9GREo2R0dJQjA4S1p6YzJsNjVEVGF3NWlG?=
 =?utf-8?B?aU9tNllubVFrYjY1QjF4ckpoVmdrbW5xa0NZaGVXbGowTlVUUFN5YjhhVmlv?=
 =?utf-8?B?dHBPbklReHEvekt2WDhldGt0M2dUWEZpekhOOWN0ZVAyc05pb0RNbmIxc24w?=
 =?utf-8?Q?r3fHRtIjNgYOVwK0JId908Fij?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ltddVCdPy1t112WHqA0A0DUi4EeZQ4y0EmIfZn31mhAPHhN9dZgSJa9egIXJhKgyuI8+GUeTi6wdi8XrWG83r+OFoXzz3zGTHxmihCwfhi8L0BoqLPL8vojISxXhFLUfyndAT0oqqcvI/3kExVpkI3v8HsblcH+Uj5K+hPV4f+VVxCOab+eKBFr6m/yhTQNZ93zwRaPNU8cL+wDDKv5CvIR896+V82/xUeBT75Qmoxztequ3JIOkucsf5Sy1R8CCMbrYQWwsrh5jIvH1bigdFVdyqTMiv42KLo5FTRoRxbQxXbyS9wFhzcFSOPQpnXlOkESbJMYNkt/t95nS9A9Vg9tF7NWkC76Sv4aHmRmGH25oLvYjcfmjqK47EmqxEuNgISFu9kwd77WGpMY1LGohFinDYa29t8jL0/i0RZ8mFu6GCVLuCFm0hnc+vH0+trW8F7r/MJGtyIuMYZcmCOPuJ8NfzgOUDV8Itn2dM2rPO7GsrA/+NaGPkU0p34pTn2QkswEa97mU42Oh+X4XZeGcSENkptlQThENb4hUhDelBlWcxGTaZCqiygpC0+u8cFPxyyHVEdVz/nAuu+/Tj9+/8guYSC2MzwBltIz8kiDtymg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e901195-fb66-41ed-2f2c-08dd9bb1b9dd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 17:29:38.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XlozNHlCixyay1IQTMLXSq6DXYIH2JXRnm7NJL5kkgKlL7WfUxLqLedPPl8D4hSGXSviabA1Ez6vjxTbJmC5VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-25_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505250162
X-Proofpoint-GUID: tOfSUtnIDbgSA6tt-xq4w1IqWYvilEa6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI1MDE2MiBTYWx0ZWRfXzU6Y2XZoVV2c hfMDrtgMT+qsie6nea0vvB81ZtVnsxc5ZHqSSZcUl53SNcLqgzW0DH9mKASneGBpzYBWv3529jv RVjYI9/RpJOrE9b14AW/lIAbKa+rDNuOOVSrXkl0I/R8qljK3xwNI045u7XWSEef89MsmDCNH8e
 72D6aMsvKY80dck36qyZ3c5qAy2OO20PLteTkyW8oA+qKampzkN1gtretl8vw1CaFa3yewqYvQ/ xadUTjF2cPPGTvniMK/3F/NotzsrRg7qaDGdLBUGCHPPaX4HS/1gloObydOFUiiCKpQC0d/7Lmo T2HzmTzQRl+lV/m/clK5eSn5PWad+zY/w7hub1YIHdAhLoavMRuHvJieUp0vaBcpDWRnRmQNLIS
 cq+NA2T81Qnn+m0Cn1vQTlt1aZLq8XRmCTWAZ7+aVC/BXNqi39CH6rqHq76QserqbjoXsCWb
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=68335387 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=mCzft_UWohUE8tB21RwA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: tOfSUtnIDbgSA6tt-xq4w1IqWYvilEa6

On 5/20/25 9:20 AM, Chuck Lever wrote:
> Hiya Rick -
> 
> On 5/19/25 9:44 PM, Rick Macklem wrote:
> 
>> Do you also have some configurable settings for if/how the DNS
>> field in the client's X.509 cert is checked?
>> The range is, imho:
>> - Don't check it at all, so the client can have any IP/DNS name (a mobile
>>   device). The least secure, but still pretty good, since the ert. verified.
>> - DNS matches a wildcard like *.umich.edu for the reverse DNS name for
>>    the client's IP host address.
>> - DNS matches exactly what reverse DNS gets for the client's IP host address.
> 
> I've been told repeatedly that certificate verification must not depend
> on DNS because DNS can be easily spoofed. To date, the Linux
> implementation of RPC-with-TLS depends on having the peer's IP address
> in the certificate's SAN.
> 
> I recognize that tlshd will need to bend a little for clients that use
> a dynamically allocated IP address, but I haven't looked into it yet.
> Perhaps client certificates do not need to contain their peer IP
> address, but server certificates do, in order to enable mounting by IP
> instead of by hostname.
> 
> 
>> Wildcards are discouraged by some RFC, but are still supported by OpenSSL.
> 
> I would prefer that we follow the guidance of RFCs where possible,
> rather than a particular implementation that might have historical
> reasons to permit a lack of security.

Let me follow up on this.

We have an open issue against tlshd that has suggested that, rather
than looking at DNS query results, the NFS server should authorize
access by looking at the client certificate's CN. The server's
administrator should be able to specify a list of one or more CN
wildcards that can be used to authorize access, much in the same way
that NFSD currently uses netgroups and hostnames per export.

So, after validating the client's CA trust chain, an NFS server can
match the client certificate's CN against its list of authorized CNs,
and if the client's CN fails to match, fail the handshake (or whatever
we need to do).

I favor this approach over using DNS labels, which are often
untrustworthy, and IP addresses, which can be dynamically reassigned.

What do you think?

-- 
Chuck Lever

