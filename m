Return-Path: <linux-nfs+bounces-12143-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED16AACF755
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 20:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83581188A966
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 18:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3759318A6AE;
	Thu,  5 Jun 2025 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nC8JiEoY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wONm+2+w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D80225405
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749148889; cv=fail; b=uf8nIPCYmnFz10VFMutaf4dZ7ljOYig7U/baqm3/7DGqo9gP2/DrTkA/4LEonA1T1Xz2QuCD5IywDSeC+UddZD0v74B0sp5e9zMob84fWQ4Wl/NKKkiL7nbxOtq4EBwk2jgCqaf+scwqBh0xzpqEElLuQB16Y0nVy9ExlqMs7O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749148889; c=relaxed/simple;
	bh=VImtxZ3Nlo55mQveUyCc9ZS86v6vnKN6gGWmvzFk/68=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A1mLJmFdsZQR/BnQgcNYS4q/SeF2E2zsF3JnmYKQZE+ayvuA8Pkc1bxzxl+/FiUj3UrRToWiPveW9e32lzo33UzbvOMrHq6RW9a32dKxBVqvoekU3SP4qKKGBFqUTrQaUDBH70izucgST7J0J8HD8hVrr5AuMGVGYg0DURh1Q/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nC8JiEoY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wONm+2+w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555FtS7a017685;
	Thu, 5 Jun 2025 18:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=82zXpVqkH0GdqWe2S13R/QMY2dGYd/WPlnHTG5aQIPY=; b=
	nC8JiEoYvQCynmTNTfD146uFrc2cCijrN5m/l0v0efbknBsU3mrBYJxF1jqzodyG
	GenPficwzHM3kGCs4ojwDgYTS83zYiMsgJNki90y5Uipg2lO0xORddJl5EGU/HYx
	an+xEMB7eR5hF4IK02Hc1VxYMgSGShKTrC4P4HFygLFko52jOY5v4iG47QWwwMBV
	Y0QTJfFLsAa34IaJSU1W5xwK/0wIQ1ZRHkNK6QTRAEc3w3eVkMW9dmuc56nKuJ0i
	8fOKBHoN43uDXMpPQiijJeTcsQC4pMKx9GYiK7ttPUXyRYUfehpGgKs5YXBqHL+2
	XqTJaH1IiNc3k6QjaI8IyA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gahetqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 18:41:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555Hncc4038506;
	Thu, 5 Jun 2025 18:41:20 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11012009.outbound.protection.outlook.com [40.93.200.9])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7cf8bp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 18:41:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeIihuheESb+7AhtrcRlk7Vi+EFrgMUC8DVJFPTjE11dfupYFfZP4YLhVRUBLgTk9HScHzyd8Dxme8OS6gmwAXDdVNpIQ9b+xndGgCAXseC8Ia5i+oyQrWuQ9RtFvGDxluj6yUKm6I8LOSsPQaei7m404WwEOnZ1m2giGvUwdKnxo0vGT04SylrTm63tCbh/fVVgofd6XytFmkyqMPczdujZkTYyGXQ8d1VwHdxWUuY8fj/BLdh1yjFZ36RHsfARPn11Ew8GVdRnvbjQvOvq2CIn1pmx93i4qOBEZ2LWSQyxNlMo6k7WZXV59/9U0g8E7sGZEnt5z/AHkIrIdn0rVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82zXpVqkH0GdqWe2S13R/QMY2dGYd/WPlnHTG5aQIPY=;
 b=uxWHO+fNCT9lUqLnru0C4Gak1LSuMB4+Vutq+wYXdJm1n6MzLrbtH4H1wIw3j8AYkajzZzAxkowQvo2IvX045zCmb5rAEWiVAnbNkqZbXPAmLLZHX+u1ogWizDYUTR4vATMcUt/qkofjghpuSKffznLjf9zzosPoZVfOSJ8qWdnvfn7Jx0CvmYjOQa7Me+Sq8sgWY6ueWuKDHarw4LvGUQpF/Vo/irndZXRgBG+9D0pb/kBhlSMBcJnttJs3CLEGtJ4a5wQM7u03JCqLmPnW3xKkXMFA1UJ6efOioq+TwYxtruODmVNh44PZu7Erfjsx54trqG8YeIUfwHGSmnIyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82zXpVqkH0GdqWe2S13R/QMY2dGYd/WPlnHTG5aQIPY=;
 b=wONm+2+wU6H0vRFzGDh3xieBm8VpRildH+SgixpDIDVebH9djw7hZ7SjkgBNOMYFZzrDX4H3uvSVUrnVzZ9O83nmeA/0ocit70uJkGxHx8UhtIXPPnXs4Oszzq9SegLxt6PUVvNLEFASpSCmx5w98g97b5UV7979PDpivwjJlJM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8491.namprd10.prod.outlook.com (2603:10b6:208:576::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Thu, 5 Jun
 2025 18:40:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 18:40:45 +0000
Message-ID: <8d9e0e67-4a64-46db-9230-7927013c3fff@oracle.com>
Date: Thu, 5 Jun 2025 14:40:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SUNRPC: Cleanup/fix initial rq_pages allocation
To: Benjamin Coddington <bcodding@redhat.com>
Cc: trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org, neilb@suse.de,
        linux-nfs@vger.kernel.org
References: <458f45b2b7259c17555dd65aa7cdbbf1a459d5e6.1749131924.git.bcodding@redhat.com>
 <cdb4ce81-c05f-4e60-b351-34d713a51e96@oracle.com>
 <80457CF6-99FE-4EB5-BC07-F4A8D9A8D8D1@redhat.com>
 <272781a5-bbe8-4181-972f-4b76eb93b1ee@oracle.com>
 <52C7396E-E5D5-48BA-82FA-A5B92EECA46A@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <52C7396E-E5D5-48BA-82FA-A5B92EECA46A@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:610:32::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4dba86-d625-444c-d669-08dda4607b3d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TFdlRWloY3BITjRFcjhqcDVpUEV4MWNjVWVScHp5OTQvdnBFeWxKcEh0bFhQ?=
 =?utf-8?B?UHVnWEs0L3IxaW44ajRsZEZJV2FPR2FmbkxpUnR3b2h5UlhWQlBlcHlrVERY?=
 =?utf-8?B?dVhPVkduaXFob043ZGlYb2xlWHhZOHh6YXlTY2hualhvcXlKM3dPUWpreW1V?=
 =?utf-8?B?eG5UK0tVSGE1R1hpTWVWcFluYXNHdFpVa3Y4R3ZvUmdFaW9zeHd1N3lhTmF3?=
 =?utf-8?B?dUFNNk5ETDNyODUzSVoyVks5UVNNNUpwcFRHVXM5QTJOMmUyN2I3SVdkOFAz?=
 =?utf-8?B?Ym5QeGRBaGNrNmZudWwveFNabnFBODVMM2xHUUt5alBHc0NYZmJCdEVhQVRq?=
 =?utf-8?B?NzBaaE5zMGljRTE3SFBPTm5PN2lZdXNheVQ2b01hdzhhemRGdElyb0xvYmds?=
 =?utf-8?B?Z0xRKzZWREcxRnZidkFGVDFkZEhmT2ZROXVQMngzSGdrNHM4UDRnT1JaTnRH?=
 =?utf-8?B?UncrNFNUK2lYNWVDeWcwSUFlUy96NllpK1FHRkRmb2loaHFnS0ZsTVVaUnhp?=
 =?utf-8?B?QTd6NHY4ZmZzb1dkNXIyR3ZqSkZnVzg2dWo2US9OYjdKZWZiVURpSEZtUG52?=
 =?utf-8?B?UXNmSlRlNjdYQTB3TDIxc3VURnJST3RmVEd0L20zK2M0L2dxeVpOWXVKRE5j?=
 =?utf-8?B?NUVaYkZ2MTV3ODFPS3FQZ0ZOMXJJTkdyQUdrUnZFNTM5ZkNTdUdLY2wrb2tR?=
 =?utf-8?B?THRUNzQxZW1nQ3BTZHRCNHc1RjFjWmxQQlR2SjFQRnNFWHZWWVljTGNXU2hK?=
 =?utf-8?B?SWg0amdXRUdoYmoreTB4QUdlbmdka2FSd1llT3NtcjUzS3NBMEpuQk9OdDU1?=
 =?utf-8?B?UWRrL3BUK0ZNYnlLZmx3SEl3M1A3TXRxUVp2eDhMRXZsZXE4NDBNRndWMTQz?=
 =?utf-8?B?anM4WjhlSXdaYTlmb0NlRk5SV0pETjRmUjRjT3lBcVBWMjNGV2VZQmROSWdL?=
 =?utf-8?B?QngvNUI1aHJHMFg0a1crRnVVbWRIMlRISFJ5TXpNUVBiLzIvaThhbFpyb1hB?=
 =?utf-8?B?TGptZlNzSlMwc291Yjlyd3VJZGEyTzg5QWhZQytNRm1PWG11VFgyZXVhU3gv?=
 =?utf-8?B?emJlcTVLNDBoQTBSYmQyYWJuQSsxL00xRlA5NDNTVndOTm90MVZRSW1YT1Mw?=
 =?utf-8?B?ZlhJNXhmMEMwYUliZDlIbnREMWZJNE1pWlJ4Y2tBdnJHcHhEc1orUlErZTV4?=
 =?utf-8?B?b1J4dVlURXJ3WXI0cklmWitvRXA0MlJSZ0VpVEhBcDdGcnlCSDYzY1c4Ny9W?=
 =?utf-8?B?dUtSa0dBV1l5M1lGVVYwWGlsajR5bFUxQUN4ZWVJL1BBWHcxNENTVkdEUW11?=
 =?utf-8?B?VG9pcTg5bkdzcDlpbDhqTitFWnBaRmNjaDNqNkJzeHp5TDdiaEs3UUhURDBL?=
 =?utf-8?B?WXRSOUNOVTlPazBYVkgzajlLRldSN2VCRWF4Ri9Xb1ZtOW4va0g2WFJlZlhB?=
 =?utf-8?B?L1ZsR1kyUngrYVFIRjNaMGxJS1dkelI4YW91b0t1YkxVYS9JVFVqVWNuWXZY?=
 =?utf-8?B?UWVmRU8rbjU5ampXTURTQlh4MWxSUHU1NUZwc2FBV3NaMnVhMmtyUmlZYTVB?=
 =?utf-8?B?RksvaUo0WE5LVnhraFNDSTRabzdYcmVJM0VVaVgrUXVaaEZqUVBweUVYbk4x?=
 =?utf-8?B?a3lQOG15dzZ6a3FrZFkvS0tqaFp5VXlQbitTLzY5Vm1IOHQvTXhsTnI2N29r?=
 =?utf-8?B?dTF1b0Jsd2U0SWRSdWxRVFIvZFh6enBXVElpdVhZTnlIOW5RY3J2ZmZTS0FW?=
 =?utf-8?B?N0hPcmRBNU1TZE03UWliMklvblN2ZFVxcGFFTTE3VW5rL0FnbHdmdWVZaHZ0?=
 =?utf-8?B?ejd5cUJvQ0hOS3NTSTZMR1JpOVB2a0xkb1paTzZYZkVjUjg3VkFQdHB6ZE5P?=
 =?utf-8?B?VHpka2ZpMFU3dzU0a0pXZjNCSHlHeEZ5ZENBVjZPWTd5ZHI1cXhKS1hpQ1BS?=
 =?utf-8?Q?V9FgS2EaO+E=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VGIzelVRaDQwdHkvcDVQdHFIU2lWSWQ1Q2xIMVF1WmduT3RER2U1QnpNVlJz?=
 =?utf-8?B?dzNYNzRXM25iYjRTU2RvUHR1RTN0Z0Zaek4rMGx2K0ZHN1hFL2NmZnR1NFlQ?=
 =?utf-8?B?UFNNdU9JOXhvVFBxc2VBN2NXYXRxOTRKQnM1V01iTkpEWCtkVzNrcThoMDVX?=
 =?utf-8?B?UlE2c2Y5WXZFQmkzRVI2SGtpMnlraE5Qc3hGa3c1QWtoVU9pWXl2RWMvNDdP?=
 =?utf-8?B?V3YyQ29XQXlXRTBPdVkzeFJpOFEzOStCZDdESjdXc0xOV2svTkM2KzFRbkZR?=
 =?utf-8?B?UVhDc1RuMkVpam8yVk5YVlphUm9lTzZDWkgvaUQvaXZWQitvdmFRV1pHRnF5?=
 =?utf-8?B?b05BNlRIVFZHU0lYcSt3b1JVWnNvSkp1aEYxRXFjTFRxbTBBekZWYmFuVVhK?=
 =?utf-8?B?eDJ0S24yNktCTms4RTlFTE1oaThUN1I2RXV2YndLdVpMa3E5Zlo4MmZicWVj?=
 =?utf-8?B?ZzFkSGpNVlA4RGFqTnZ0ZlpOOWgzWS9lQ2U1c3hEUnc3ejRRTHBxT2tSeGps?=
 =?utf-8?B?bGpCTmszeFU5Mmk4RXc2WkZXVDZTbHFRVzlnRmdYQjM3QmpCb1hSWjlMM0NG?=
 =?utf-8?B?V1hYOEEwOE9QWDY5OW5Ud1k4cjZBOFMzYXhydUdtREFzU2h1ZjFPWDdOakdQ?=
 =?utf-8?B?TlowWHh4UXBmY1F4Zk5ZeURESG1MbTlVeVJoMTNOeFZ1a2hVSFhlYi9jY0xx?=
 =?utf-8?B?d0t6VEk3TVljSTMxVUpIU05aajZYenJPNXNxdHFQemIxVFZzTE5pMGtDUDQx?=
 =?utf-8?B?dzJyTVdZUUZQNDFCTjYwdDhtNU03NUVlTm1HUENHb0hKMUVLRnNqTnFoaWJh?=
 =?utf-8?B?ejkybVpTUTVzU2VXRWZ0WHdOSTFYVk8rRklRYXMwbjhQRmUzUERUNHpzZncz?=
 =?utf-8?B?VXdERzFGQmtTdFNTbUNjK29UeHBiRHQ0RmhZelZWcUg5K1Fnbm5ldzV2andz?=
 =?utf-8?B?UnhLdzVhQzhkaG5PcW9pM1pYT1cxeGE3WFBjSnp4ZExuZGdRUUx6RWhRdDgz?=
 =?utf-8?B?cHF0cG5wMVNmMjZWcmRiR0pFU1ZiTHRzRHhKeE44Mm1WUzdlcHJZb0xpV1VS?=
 =?utf-8?B?dy9KaXRJTWV0ZDRYc2hZaTZHZ3dESUdZR3VuTkNMTkRvZ2hxenVFcGRNUmN5?=
 =?utf-8?B?Rlo0VXozZTBBVHpESlVhZTY5NUFjdjRieFJsUnhSQU1jM0xMZlV5WXdndG4z?=
 =?utf-8?B?enJaVTgzL1MvOURVV3dMd2hXRzR0RisyUGpCaHJ3SU5UL1JXaDdLb1VFZDhk?=
 =?utf-8?B?anZvcy9vdWZ3b0NlSVNVZW9wZFIwYzV1QUVNZE1YVDUyanYzNW12MndaM1l3?=
 =?utf-8?B?NnF6UTAxOUNTK2x2UmFmSVFaY0wwOGVSR2tNUjNhS2tpTDFvdVFoT3BoWGZ2?=
 =?utf-8?B?S0kvVVVnZUU5Yk9tLzYwMGgvN3AwbWxib2ZBQ2xVVEl0UTgvbUV5bTJWNlhy?=
 =?utf-8?B?bEtVTVVQV0dBeHRQMUM0NTUyaUtyamdleHZqeG9wVVBzUXdSZldnRHRtcFd4?=
 =?utf-8?B?SVFJcjF1TmFSMXVKa0hHNStMVDNGMjNIOUMyVVR1NEZSOFNnOXVtY2ZmTWtT?=
 =?utf-8?B?QmF5QUh5aXZ3UWRJWWF4NzZLc09jSmJ3S242ZVNvb2RNSFZKaWh4MGszTmJB?=
 =?utf-8?B?NElCQ1VDWlBXZzM4UCsrd3RwNkhPRlgwcmVpY1NtYmJ0Sjl3MHdNSDYxYkVq?=
 =?utf-8?B?UnhHRXlkMHo5RDY2MHBlbjZRSy9CSEhZMnhPcllzUG5adzJ1aisyZXlna29R?=
 =?utf-8?B?WXJ5aXFCa1I0SlU3QnhqbVdqRCtZOVYyRCtLU0xpeXZQd3hyeTVHRjlRQTFv?=
 =?utf-8?B?c0ZmUnZoZmtwNklzSzh2RjRkNEVweVpxU2sxT2RhQ1FoOHpxdkNsbUhzZ29D?=
 =?utf-8?B?cklkN0dkWWdUbS92WGpBTWgyNG9YaEg5c3hQcW9KSDBYM2NFV2dsMVpkSGpx?=
 =?utf-8?B?UWo2V3I4NkYvTExYTDArWW1LYnhlbTZuYnNPcG5VdmpycGtlUFZjalBXeStN?=
 =?utf-8?B?dGNpTkU4YUh3RTZhZlBSbnFmY3Njb0lTcGRZREhTSGwxUEZuWTI0WG8zdlBC?=
 =?utf-8?B?YXF0Q2w5cUJ5NUlnOHVlamZINWFaTW9ZNG14UE5MSGZIT3h5WFZxNXN4QW95?=
 =?utf-8?Q?GCoJDdENKtDBAp1q1KrnKq8y/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zzm9s3VP6JnTmAz6xpJJBSKNsXAqiKI50+vqNwheMFjIe5fjbzL958rYWXyniKh7KIV5+7pmOQLvELgxToRkZT5Tvh8pZZdZeat7raz5Ujtcf1en2WxaHX+CAttKq0VLCWvrmZhXck3AMaMM/kKcg2i2V1zra85pLxlAOoLq1w7QkvzqiJdR3hnpXPELuLse/yw0psXPSj7vNtTLcQckygnc/moF26Zmrhsiw2bmS9iJnEGQ5Uk9npSdWc6QbiNBC2Ve7S9rjGiZG4oLJXoXKOnrMO6/JDzq/NHdWZ/sivVA2k5MizpCOkx71hfeHqGbv1HbAwiQS6pGgGgXKliOOQCdW0jEAFOMJ0vUKYcZ0OArFxbS3Wy5kXNPzousj/O+ybOhwTYOt8eGwRoJMSVjNTo8neWwWa7l879nsrUIkAoAEvgJzTFjcaw2qdYk3+yGFN/9O2i/rZWb2sR/NRlpBahFh4fCFcgpiU5043cPHayN/LA2GEbyXiiASEQpqqeWH97npDacy0w14yE5wMRQpqVbVCKjH1qGLGiGzgYNsmHfOFMkLPdteyDYp/VkxCzNz1u9bSzF22vsgb8a7Z5cVwlKwjZfkf17t/OsEeQPtIA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4dba86-d625-444c-d669-08dda4607b3d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 18:40:44.9591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjICfC7WFNOr3kCw1Sq6WieFvHrlLeNrF9zBnCOXNlkH76v2ZXAjL2svTgDCXcrl6h9rCFiuALSelx1buoCPag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506050166
X-Authority-Analysis: v=2.4 cv=aqqyCTZV c=1 sm=1 tr=0 ts=6841e4d1 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=MyZMA4w3bcq-ZLtrsG8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7nPUA943m-UP9jmK2Q-_sYWncIErT7RD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE2NiBTYWx0ZWRfX64ZVYz2mXZ6J MXfN4XGEph1nfkrbVgcwDELlXDU8/UuEciUw3cXrtODC5k4WEN1wDdD3u81uzgc8E77MzSyTyk2 j/0/dtOn5q7sKaPuixXNvk9Ns1cbBz4qwEYKaOUlfGVHRfcNKnSBFXkdC0d6h4Lf97ApMtIWN42
 1VBcTDlZ31g7AZ/fiqGDWQ0uEeBHI8T81A0orDKCrMZYejJlMNsF5MsTiBPHcnXfNmp5hxYAOoT +z9hY8RfSki70c6mnfwTKzWAGPufuMfxmHWy6pxy8WHjUlM76g1B45JnGdqD1obIJXvnnXGo8ds i2zadzfImTVQA0Tk63Fen+/m0HS8w91lRJScuPoDfo53Nno8XBKnfiyjMoHuvny+SvDvi/G5V5r
 hkxYlteDc34HbUo3mwsVXAHDkHK/uA4qroxyckLPgECpdGiVMwZU8DigXLBz56zC4A9kJu2Q
X-Proofpoint-ORIG-GUID: 7nPUA943m-UP9jmK2Q-_sYWncIErT7RD

On 6/5/25 2:30 PM, Benjamin Coddington wrote:
> On 5 Jun 2025, at 14:08, Chuck Lever wrote:
> 
>> On 6/5/25 12:54 PM, Benjamin Coddington wrote:
>>> On 5 Jun 2025, at 10:26, Chuck Lever wrote:
>>>
>>>> This doesn't apply to v6.16-rc1 due to recent changes to use a
>>>> dynamically-allocated rq_pages array. This array is allocated in
>>>> svc_init_buffer(); the array allocation has to remain.
>>>
>>> Well, shucks.  I guess I should be paying better attention.
>>>
>>> Can we drop the bulk allocation in svc_init_buffer if we're just going to
>>> try it more robustly in svc_alloc_arg?
>>
>> Maybe!
> 
> Ok, I'll send something.
> 
>> I would like to understand the failure a little better. Why is mount
>> susceptible to this issue?
> 
> For v3, we're starting lockd, and on v4.0 it's the callback thread(s).  It's
> pretty easy to reproduce if you bump the cb threads to something insane like
> 64k.
> 
> Customers have a really hard time handling this on autofs, its not
> like the system just booted - instead the system will be up for long periods
> doing work, then the automount fails requiring manual intervention.
> 
> I think the bulk allocator can be pretty sensitive to some conditions which
> cause it to bail out and only return a single page.

I see, it's client-side initialization that is failing. I didn't get
that before.

So, there is already a logic change in v6.16-rc that defers backchannel
set-up to svc_alloc_arg(). Either that will fix it or you can piggyback
on those changes.

The problem I see is if you want to backport this fix. The bulk of the
rq_pages changes in v6.16 are not appropriate for stable/LTS so we'll
have to work something out.


-- 
Chuck Lever

