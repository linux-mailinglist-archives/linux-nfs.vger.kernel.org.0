Return-Path: <linux-nfs+bounces-16344-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD8C57E43
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 15:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5F303517DA
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF6286D40;
	Thu, 13 Nov 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kBylIDaa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MFfDeREq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FB2283140;
	Thu, 13 Nov 2025 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043568; cv=fail; b=PQnnWZHQcaE/8QZXSv/cownzJ+VgEGWCHpOd0hkZWyYNZ9pmolKERlN8XeYuzB3icMPRd/2g69tt69v3E08RixbV31iFVA/J8m23Dn/Ox15g2q/OB5iivU6PJv4MRqr7Lu52iN6nIJUbSfL38gk5jaao4Fn/f92TAkMCeOZPTZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043568; c=relaxed/simple;
	bh=pxPekfzKIy0MbA7M9IeESmQOcZ7ZBYM5mmus9pfjXMo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rVDtbbLhmkUcfr9ztIbm7qNrwATwufnA/itWoF44qYaUS6QmCAGiRkIHFNs/N87xGrN+qCRBttC2ak/W0Gvvz72Mz9LpT40CMglhD8Gw74ScJJftRlaNOBZEZURFXcr77cmnHAfv4YEFG/F4hJ6x5j9ExQ9MxAGHCp0QLq01518=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kBylIDaa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MFfDeREq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEA6Au006315;
	Thu, 13 Nov 2025 14:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=l+fhaRv9y2gKrTWe4Wk/LafzQSgLqnblsh8c3ZvQ1jc=; b=
	kBylIDaaC0trbjOumkwlmoFqHmXkesRORgSw+kZ9+YzqUTEvt3iMpomGmfjQ0DGQ
	41essTdFqZCj2+ax8FMP4oa4uO/RY6ojZ5qbNGNABWukaxzughP4wX3ZUsM0xjc2
	4VvuK+FK28dhx5l5krhWFEcz3Bxsrf6UwEBt2ABVDz+cgenstrICytymv/M5yFsG
	/oPPyEuOSGNb9grY9JnvKPlC5nUU0zv8r1S40nxQiOKKPTIsuDAPC757FSH4zi8K
	CN3FGF2VBT3x7jvu9UY3M1anUNEUwJVnHwtray2pGKwbjAPScMQhprBqr0uPPVL6
	6fqHlCy4s2tr1+Y1UfHgkg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyra9t3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 14:19:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADC1mjH003037;
	Thu, 13 Nov 2025 14:19:19 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011024.outbound.protection.outlook.com [40.93.194.24])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacq0mn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 14:19:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeXvGZ9jAxFJ/MsVL7IrbmKF/M4zMkJlfH0ag8q8FmiEIvxrOuqNUyG9yilliYG+FZIxzm13K9MANXgbXDkRW3kmoI6mncSLrdT+EIJUqnh/Xdb4fCV8I/ilwOMt/0JqeBpvyHlMFrOSkaOAt2ceCSkMCkrGZPPIzYxBLOoRuGhknhSWesf5KYwtPSi+sBoH/yY6zSUiHGt5dvxwzTTvcLQfq/F55dYcQtX59Xhk3mJ+6K9chDRpG21zfGfjxP+ZmE1b2TUXi6noGCcVFqVDbxP3wQNJ4pNjGzVmBB347S+6t91Dn5TnhHdeJeVCtNjnXACgou0DoishwPxNZjQIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+fhaRv9y2gKrTWe4Wk/LafzQSgLqnblsh8c3ZvQ1jc=;
 b=hQRnfsM/O/We4oNLtU9fQhs3TgLNTr2J+1TTXBXz6O9dBwt8h0w1sSUZQItbnvmk9hCLV/0kU2ZlRQg2OIhnOF17SfjBtmWSgnSA+Sw1TY2NWIdFMlgJA32CxNEEubRkels2JleTuj9ylICaq8l4eBHc+AafgW3UXT1jgcSVS0TWyfiB1A3GBK5+rkfrMoR2RCv8GomMdn/Taw8FYftk870PT2SDyy++YeHjfNZpgmARD7Y2pVk9YDch/ZqoJgPTxfqSuxwi/Vw+5EyLOKGSb31KLIb2eppzC9X2inA+rcziG+WfdfdigKC31CSA3Nji5xdRLk6YW//yYYZbety4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+fhaRv9y2gKrTWe4Wk/LafzQSgLqnblsh8c3ZvQ1jc=;
 b=MFfDeREqddApQdktv7kvayaSkKixUVwRWacn3QFa12QTSxRlE3659Mu/w4nK7hLgic+Ane3glezHPKnmFGYFsdbb3BZ8uteFnFWq2w0PqyXLichJe5NnNXFSM74ra8431dEZcn8L7hnsD3E1HhntP3ZpYX6EVC5c3UR6kKCZAvw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6954.namprd10.prod.outlook.com (2603:10b6:806:34f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 14:19:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Thu, 13 Nov 2025
 14:19:16 +0000
Message-ID: <d3b2e4c8-18ec-4b8f-a05f-42bc00196e1c@oracle.com>
Date: Thu, 13 Nov 2025 09:19:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Make RPCRDMA_MAX_RECV_BATCH configurable.
To: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        neilb@brown.name, Jeff Layton <jlayton@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20251113093720.20428-1-gaurav.gangalwar@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251113093720.20428-1-gaurav.gangalwar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:610:33::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: a7aa49dd-7f8e-4b2f-c45f-08de22bfa0f9
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bzB5QzNYTUk1Z1p6YU9qM1gyV3dtOTBRZDVnc1NIbmdEL2plRzFQekQxalQr?=
 =?utf-8?B?dE9tNVVZUlpsL0tmd28yaVJPWFFZZHR4ekE3SzkrYmx6SnEvSmcrUUZNRDBm?=
 =?utf-8?B?M1QzbWlnb0FPckZSUEQ0K0tPS3lxQm5wTzJnS3Y0K1BBdWhBbEczTGtHVUtr?=
 =?utf-8?B?bHJNWEppTk5qMUxQelNzbjR3WmE4eUo2eFhTdC95dUNHVi9KN1EyUW15eXNo?=
 =?utf-8?B?ZWFEVGNrNDBwdjJDcUM3S2FGM0dzZjRwVlBpZmREZlVYTE1KbTZXL0lhWTAz?=
 =?utf-8?B?U2VNVjBFNjI2b09XVmd0SVNWWEdNTExQQ1hVRTdIdnZYM3pUWFNtRi9mQUNn?=
 =?utf-8?B?UVdDRlNTSUhPWUVNTXJ6S0N4RXkwV1pQL3kyOTJkcTQvUS9qR3VvTEJ4U2Qy?=
 =?utf-8?B?UlFDeFF5VXhQMFFqUHROdVhLYlF5UmZsOFhJM2paVHRGbzNLRCtKSElDdzF3?=
 =?utf-8?B?S01MNmVlT2NEWkt1ODczZnRLdkF1aFVSekJ0dmlXS2duREtQSUpkTG9CWG5B?=
 =?utf-8?B?Vkt0dGtZcGFCV3Q2S2kxVjUxQzRjS3NGVklUWk5FeFBjQkU3YXRWa0RXY2Ri?=
 =?utf-8?B?ZktGNlRlVVJBYVp6Z1Q2TGhqeStMZ3NPcE83aU1MN0NFWWVMOWRtWU1lZUdk?=
 =?utf-8?B?c05raWJ2WFBVSUJOMXZQakViaHFUaVJpRnA2N1c1eEh1QUJCM3FQbHo2QkRP?=
 =?utf-8?B?WnBKQWRZcWdUc1F1bCtEazBxdEx3UDJzeGZqSElCcG80WmZBcGt3bHo4TmNY?=
 =?utf-8?B?eXFUVVA1bEZZTE5ZOW9uTHpaamVRS1JmMmxvWnNJeEJQRFpaYjF4SlkrYjNF?=
 =?utf-8?B?U3ZIdFgzdGxkYWFIdW9FMkJWNVJCdSs0dEd6MCs1UnBSa3EycmthV1QzTHNl?=
 =?utf-8?B?OWRsUE04a201YytpNVBUMHpGTkF2THE5N3plNzBadnM3eGhnck9CMjFnSXdX?=
 =?utf-8?B?S1JTUmNmMWNLR1ZZZHBuMEFKUTJiRWNhdGJnV3RWOFRad3h1dndWWDA2TVZn?=
 =?utf-8?B?Um02UGNUNGR2RW9pejZGVzlzK2lrc29keTR2UURwTlNwV2U5aXh2RjduS1Ey?=
 =?utf-8?B?bVpSUEMvcnYzaTE2RG5XQUdCTzgrOC9JT0pIaEthUzRMTmx3SEhsOGhQU2F1?=
 =?utf-8?B?NXVsMVJwZ3BPd2RCRFhWNFJPaEVIdktqZVR0SlpyZ3E0MkdyM0l0ZGhZQXBE?=
 =?utf-8?B?THQ1MzZiandaWlpad05hZ05KaVY0b1NnMXlLQ2ZWdVV3UnROMXJiN0hqaEw0?=
 =?utf-8?B?eFpHN3NvU3ZMQ2FKQmR0UTltZ2RYL0xneVN1emkwcFNpMDhvV2RCb3FHUXk1?=
 =?utf-8?B?bUJGUFJhQ2plSjVYVGVoZy9WVk9jejR0cWl5OERGMDRwZGxCMUprZUE2cG9l?=
 =?utf-8?B?UU90UG1oREk3c3E3cVNJRFRxRlVvOGRMRDY1bncxMTJUZG1LdUhEL1IrYnh2?=
 =?utf-8?B?SitIQVY1Z1BraTMvekVNUWY2Z3hkQ09KYXZ0WE5rSVBKYXkrUW1uSDZVc283?=
 =?utf-8?B?SGc3MGZhV0dsSFljbENOdXM1UWNzY3V2bldPR081VGhGUVVPVVRvK25tMXgx?=
 =?utf-8?B?aGdvaHc3aEJBQmdLL1R4MUV5cmsvbExnZzhncDRUUmV1R3QxVlNVQTJoQWZJ?=
 =?utf-8?B?UWduZGtJL24vZ2JPY0UwcThMaFZ0akJmMTNXT2dadklsWEJRNzlpWFRUMXJw?=
 =?utf-8?B?N0tWOTE0MGdPSmxCT09Vbzk3UkFDdWEvaTh0SFRIcEFUSmZHS0s0U3A3M1pr?=
 =?utf-8?B?K2kzUGszZ0FrVjdFNm9oZUpKUEJYaHpxdHloL0FPUGlLeFZIWUNsRTQxY1Vh?=
 =?utf-8?B?QXdmTHFSWUJaQlR0dGJwWHNnR0YyVkZ0QkVpMDFRM0VuUC94Ky8zZFJVTzgr?=
 =?utf-8?B?dFRtRjdFT0JWYVhEdUVValpCVy81YVZqREQ0NmNTejVGL0Fud0ZLcTc3TnJX?=
 =?utf-8?Q?WD9arBGPluIdpBZyUufnoLxFTGSCdgyJ?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cGEyVnhrUWpPOUNSSXRzWk5KSlFNNFU5OHI4R2FtVlkxV1VZdkw4S3ZRT0xP?=
 =?utf-8?B?a2FZd0NCaGxXWTBBbCsrWVRPd05sbHBUdE1uZGJ4RjlHTzFCYmRSTkN3TFVC?=
 =?utf-8?B?NWtwWGZkYjZGY0lFdFdmR2pqbEdBTHg0SWV0U0sweVMvN25PRnl0RSsrUVBT?=
 =?utf-8?B?dThRUGNleURicnVJOXJHTEM4THg2NHUxaUE2azNINjNPN3BqU1djSEJoVGYr?=
 =?utf-8?B?dGJySTZxOUhVKzVlMWx4VkxwZ2JkN1Y1R0RER3JRZWpoLys5TmNEQzdWYWNP?=
 =?utf-8?B?cndlUWVOU2FrWXZWWU1yQW9LT0EzajlkcjlOd3VucTFmamhjM3hTVEh6MDZv?=
 =?utf-8?B?VUtYby9FWDFLNmowQmUrMHpzcnBjK0dXUjBXS0lwZUkyZllNVUFXNzlHYzU4?=
 =?utf-8?B?cUxQR2RuTk9MM3MyS3l3bldlTjhPMlhLa3UrcTFVd0UwaFJlUncvLzBTcGtK?=
 =?utf-8?B?emhKQ1FHak80b0NJRURoakFWN0VvT3BhalpUVithSHhIa0JyRW9KMHdYWG9G?=
 =?utf-8?B?Q25OeGJKVHU2VnBBYWVYa1hPRzJZdENDQWZNRTY3Q0JQaW9zOTJyYVRnUmow?=
 =?utf-8?B?dWF5YXI1bWk2NXlPby9oUWt6cDFrRnZqZi80L2pCKzdlVkRtdGVsNy85b09V?=
 =?utf-8?B?WDgxS2h4UHZwdmZMTmJaWCs5dnZsZG1YeUoraVVrUElmcmVGbDNDK0s5UzlU?=
 =?utf-8?B?R0N3SkRHaWhpZWYzMnhYalBmNGZrbis3WkgzT1RMMFNwV0lsVHpOV2pnN3h6?=
 =?utf-8?B?ZkNmWTFrcmpRWGpwNy9FelpVTjMxT3M1a1BnZWhkVWtzRXo4YWNxQ3d1RmJR?=
 =?utf-8?B?dFBHWHJuNlZKNHFTTGVzWThGdVhGbEFIbzdRcDJyaXZ2cUJvTmVmZHNIUTRv?=
 =?utf-8?B?blZjRi9MUk5HRVFUMi92ZG8ydVdlSWRYZmgyQWMxNlJiMUJPdXdvb3BDNXRt?=
 =?utf-8?B?Y3pYOXRwTHF5aW5aZGdRcGxBajVPY2MrSWRuUXBXZEE4Smkva0lJQ2pkR2NO?=
 =?utf-8?B?T0xUVy9EcHVqTnE4WXJzSUxJcHMyZ3I0R3hCbFF3c2IwRkR1K0NGNHhrL2pN?=
 =?utf-8?B?NlBZSXJxSGg5dWgzblJNaWtsM0RGQkI0amdqOEN2S0l1MzhSNGdKb3ExTC9z?=
 =?utf-8?B?SWlFMW5LMXd2N2FVYmpYUEhuM3pjLytWTmFMM2hkTExUR0Y3RFpmcTRWNXVN?=
 =?utf-8?B?MzRVVDNyL0NKWXh1YVBDNDc3VmZhZmlkOUVYeXg0NVdCY3JUMDJOdkNvSldy?=
 =?utf-8?B?UVp0MVBrcFprQUFYK3ZYL1VSSVpGemlkUnFxb0pPYWV6b2xDWmxwLy9kdlhE?=
 =?utf-8?B?T2xkbXN6ZU5IT3pGbmdnT0VuZjBCWmVmQ3hHbis3eTk2bG1tQ1N4TG15YXk0?=
 =?utf-8?B?ZEs1WlFhdGtiL3lxakZSNi9mQzhOR2xDRXJYbHZvdG9OQ0hoWEJVQTRJK29N?=
 =?utf-8?B?YU91NnRhRFByQW92OFJaUGEvcVkvL1U1R25iTEUxMjJpRXdKL21PMUtwaytw?=
 =?utf-8?B?UUttdEJ0M2JpQUNOSWpHa252RExHVHdjUE1SOFh0TGxMM3F1REZYQlFYQ2Z2?=
 =?utf-8?B?bFVSaU1JRVcrMndVZmszZldZaGo1Q0Z3S2tTdDRHK3ZpUUIwQ0lyT3o4dzNN?=
 =?utf-8?B?SjZhRWVVaS9tVnpnWXV5bU9rVk40RVBDT0RUbC9VWWpwRE9WaEd5MnFwMmtl?=
 =?utf-8?B?SGZNUnhUTENxM3ZhWFc0OVlVMlpyLzNrd2lFbGpITmFQQ0xEOHJXekNlaFlO?=
 =?utf-8?B?SDh3TTQxanFlUkJjd1hwZWkvdG52ejBybTNmendSNFpId0hObWxHS3lSNkJ4?=
 =?utf-8?B?WTNWVzhnbUs0alBEVDFqQ09UcjhCbXBwdnk0cnB4eWxpdzUxZlpYdm92YnNX?=
 =?utf-8?B?bzBpblYyTkdTY216ZWRYVklvSDJveERvTWxMaU5zUEYrQi9HQWlpeHJhNXRh?=
 =?utf-8?B?OFVCWW9icjltVmJsQ0R1V2NCNFBhSWhZOUZwR1RGbW1HdGNVTWRmRUcvL2lo?=
 =?utf-8?B?dUVKUVJEZndiTm5rVStUSFIwUkoxUTBITTBwQTVnbWxobGpsa2ZNMFpUNkEv?=
 =?utf-8?B?RlhzanFzdkhkN3dKNHRZZmdkaVh6bGpPejY3NjRlU3VmaGlZQVpFM1F3Rmhs?=
 =?utf-8?B?YVI0eU5kWGNGd3RSSXVjeVZJdTlJWTZRazhRMzB0U1NhMlg4VTZVa1UvRC9X?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BlgvE5X2KuH8HyVzfxolcAcnjZJTYL3BxE+W2c8gAgFO4n868ox97AhiXD09IpM/Dx4atfluk+TIdfViFFypL4xR0UeZ2DXoh7jHghIxCmjDDErWnDBJWnlEQr/ceP9UGIogof8bONmDSJCEO1FuirdeeJ4vMtHcqmrD/Cd+HJ0xi+Wm1m8gpuVRpWF/COIsMA6VgqHaXZYbZQv5FJDKWbYSEO0ORqJL3YxQ48hGstitirXb3l0U3xIaaYC1YukNwoNZP/Oi02OFzFxPweTmV6GOsnCNcOQu5zOkKTlVLJzDU4/OfHhrKy2rpmOMLV9hb7DGQMb8ccvr1W43kaN2wkfc02yoPqum5lRUZQqBkbg9qDBfdVZdp2b+MS+yYiD+bVvQVjQEIWrUZ+OOtMe1cJFc19PI4/BFR2QfwlhH1uaixoPNKJi1S7FPyy3cS0vpTVXGgNWMCpibwclhNPurb4rm/x32uJV7H+MDGNJsoMR43Q2DIOnyS4JBVU2G7FUVOTbMpteEvZ62vip8gMcyY8uryq8+QTu+PE7gNIh2WsYg7ZrJH7jb9FvnaD+JH8npL+dXCLPsle5O6EyRtK+uQCYFp126RCh3EVhze0Gj1mk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7aa49dd-7f8e-4b2f-c45f-08de22bfa0f9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 14:19:16.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52AK3J00IC7jfnQHGuBPrCKGYZtImhLTto+R91Z2LGE3skQKe7QkniIBBeFoRRruCiOfKEf68RYpkTYLx0CUlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE1MSBTYWx0ZWRfX5IQjP+AD88Nx
 dsYVnDMwFGcbTFA8KjaZm6NbsiQQPKMZ+ejMeRf5BsDapOBzMa5NuCPFpVwc0CXXQDuGOBfGD5q
 mF1qdRSvrMQ0X7vtcFFYq3K5eHPNmjRm6kBTlp4MH9rAn5oygFFHqo2gZQviYeY1tS5ogePNS76
 5mA9DzBmf68JuNeeKu4wcoG/MUO5hjgjVba6YoZvQHygfOm6Njf4UiyvGfvR08GYqMtpJdqsjQt
 1SsZf5kgryLiOLzXxkPALykNRfK5veXT8Qqu18FdIdwF+fvOzEPX/7I2l9hes4dLNwHkymOb2Dv
 /gOkmERsVoDazjVaBuAJ5qFnU1ny7evE2uHS+YdNnImHR86Vo++jUQPGsBdTIuHP0ner3hmfUKx
 lu2u9ZjgFkmPpTq3EVBDTyBo1fUEvA==
X-Proofpoint-GUID: AZ3l9cC3_Ta786mSct8fdUv_xenZo3--
X-Authority-Analysis: v=2.4 cv=ILgPywvG c=1 sm=1 tr=0 ts=6915e8e8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=E5RKnd8S-lp2Z5d71a0A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: AZ3l9cC3_Ta786mSct8fdUv_xenZo3--

On 11/13/25 4:37 AM, Gaurav Gangalwar wrote:
> Bumped up rpcrdma_max_recv_batch to 64.
> Added param to change to it, it becomes handy to use higher value
> to avoid hung.

[ Resend with correct NFSD reviewer email addresses and linux-rdma@ ]

Hi Gaurav -

Adding an administrative setting is generally a last resort. First,
we want a full root-cause analysis to understand the symptoms you
are trying to address. Do you have an RCA or a simple reproducer to
share with us?


> Signed-off-by: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
> ---
>  net/sunrpc/xprtrdma/frwr_ops.c           | 2 +-
>  net/sunrpc/xprtrdma/module.c             | 6 ++++++
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 2 +-
>  net/sunrpc/xprtrdma/verbs.c              | 2 +-
>  net/sunrpc/xprtrdma/xprt_rdma.h          | 4 +---
>  5 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
> index 31434aeb8e29..863a0c567915 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -246,7 +246,7 @@ int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
>  	ep->re_attr.cap.max_send_wr += 1; /* for ib_drain_sq */
>  	ep->re_attr.cap.max_recv_wr = ep->re_max_requests;
>  	ep->re_attr.cap.max_recv_wr += RPCRDMA_BACKWARD_WRS;
> -	ep->re_attr.cap.max_recv_wr += RPCRDMA_MAX_RECV_BATCH;
> +	ep->re_attr.cap.max_recv_wr += rpcrdma_max_recv_batch;
>  	ep->re_attr.cap.max_recv_wr += 1; /* for ib_drain_rq */
>  
>  	ep->re_max_rdma_segs =
> diff --git a/net/sunrpc/xprtrdma/module.c b/net/sunrpc/xprtrdma/module.c
> index 697f571d4c01..afeec5a68151 100644
> --- a/net/sunrpc/xprtrdma/module.c
> +++ b/net/sunrpc/xprtrdma/module.c
> @@ -27,6 +27,12 @@ MODULE_ALIAS("svcrdma");
>  MODULE_ALIAS("xprtrdma");
>  MODULE_ALIAS("rpcrdma6");
>  
> +unsigned int rpcrdma_max_recv_batch = 64;
> +module_param_named(max_recv_batch, rpcrdma_max_recv_batch, uint, 0644);
> +MODULE_PARM_DESC(max_recv_batch,
> +		 "Maximum number of Receive WRs to post in a batch "
> +		 "(default: 64, set to 0 to disable batching)");
> +
>  static void __exit rpc_rdma_cleanup(void)
>  {
>  	xprt_rdma_cleanup();
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 3d7f1413df02..32a9ceb18389 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -440,7 +440,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
>  	newxprt->sc_max_req_size = svcrdma_max_req_size;
>  	newxprt->sc_max_requests = svcrdma_max_requests;
>  	newxprt->sc_max_bc_requests = svcrdma_max_bc_requests;
> -	newxprt->sc_recv_batch = RPCRDMA_MAX_RECV_BATCH;
> +	newxprt->sc_recv_batch = rpcrdma_max_recv_batch;
>  	newxprt->sc_fc_credits = cpu_to_be32(newxprt->sc_max_requests);
>  
>  	/* Qualify the transport's resource defaults with the
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 63262ef0c2e3..7cd0a2c152e6 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -1359,7 +1359,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed)
>  	if (likely(ep->re_receive_count > needed))
>  		goto out;
>  	needed -= ep->re_receive_count;
> -	needed += RPCRDMA_MAX_RECV_BATCH;
> +	needed += rpcrdma_max_recv_batch;
>  
>  	if (atomic_inc_return(&ep->re_receiving) > 1)
>  		goto out;
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
> index 8147d2b41494..1051aa612f36 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -216,9 +216,7 @@ struct rpcrdma_rep {
>   *
>   * Setting this to zero disables Receive post batching.
>   */
> -enum {
> -	RPCRDMA_MAX_RECV_BATCH = 7,
> -};
> +extern unsigned int rpcrdma_max_recv_batch;
>  
>  /* struct rpcrdma_sendctx - DMA mapped SGEs to unmap after Send completes
>   */


-- 
Chuck Lever

