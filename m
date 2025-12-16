Return-Path: <linux-nfs+bounces-17120-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE9CC5337
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 22:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9118E300FFAE
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 21:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B41A221F13;
	Tue, 16 Dec 2025 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AuNrwzzM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m+qNYm8R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89428241691
	for <linux-nfs@vger.kernel.org>; Tue, 16 Dec 2025 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765920232; cv=fail; b=fmCiSbOqyw1Fm/PlN54mRhpbedAeupxmwZ8ENTV+xBNDUUMU0wABW1RxXQ3aHrrW4W4q2bW3ybiITsk7mB6oIQgse4yRUtdqknyVTz7+la8LIcXqs7Hwm2u8WR21ydf2mmxdflL4cQz9xXAt9Q7FOysnAdPD1wC0LsxuQMv3UME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765920232; c=relaxed/simple;
	bh=1qiN5sa50KziedMLARSeUrlSj9WMcV/tD6eCoxja0vo=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R0XZneYyeDZ8geMI/iz0UaPixw0Q6Vr5r531J8sUMKunThjB2Gp5RtcAEehYdUZsfoXGfZp5/wkMLE53CKrjpo5FlmGSsR4xFLRWLsmdgvm3Kx9yb936jv9BhV+95fIVFr4UGPgnxL2tnoVe9vIY1bdrsZK8rL1ltW1mNzDmB0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AuNrwzzM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m+qNYm8R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGKRCJx1175100;
	Tue, 16 Dec 2025 21:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XeuvisdM3UeMIDp93xVEZjajM2nRK0ULdBfP+jgjU5w=; b=
	AuNrwzzM9v/ajXAvqcp50hk2yiG+Li1eJth+mdXc6z+r15OIP7pZ9KF+p3BvITNl
	6bzkjDyEGgnRU1qWsgloTWvTvFlbZC5/VMrLod0KPOoKdw/ZYPyeLzgThkQp1DAt
	i4szUmALUQB2rkm/E/w+mIAUeZBlrirldpZEdRrgT2sw4lbd7ez39adzC1WzNUwq
	pBXxeXmpS44Ql023bIXV8Hm2oqbmdehsyqEh9AdAQtdtEzCh2rDpy4FnfsSBVeNU
	/36h6WBzUvp3F4cPxROpHaKdMG42MwlqQnBck7yOlFbG45/HvEZiLPBhDEoiOddB
	e9BBJt9sxDWz3PAFIUHJsw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0y28cure-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 21:23:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGK9o0l024480;
	Tue, 16 Dec 2025 21:23:44 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkaymcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 21:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRhCrqCEFd3tifM+At0CQFSin8Cn8Zy+M9v6anmg0cVJJ2f43/4+RdweU94/HfufYeyP0czVDJdHQmDbysrYX3bZsNCnhHpZcBAHNx/X99szAnIt9bfl8V7M0Ck3qtZz62DaPez+mRo/oYh0XBh5olh5NyZmae9TgATUpWKv4ISm9kLMrt4dLZxljnZH5Y3lyo3xCPvXPbgvqX6KQiau4HbiIMq6LXrXO+7U71P1hS1/bm3CXUbiJqGjFokC4sepOacxlOOjmpxicgCEtcZ6DxEv06UI9y7PVBI+s7dtKCer1Vg5sBjLvjsYV/xWwgZKZ8+K7nnz97t8tGPTK92YIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeuvisdM3UeMIDp93xVEZjajM2nRK0ULdBfP+jgjU5w=;
 b=UbBoHRftvxmoNZoraiAYh1s8Qfzx3UnIbRybbWu4J/zSt+JEiDSnqgEQrS7xrs+GvYi/jUjn/oJ+8cvtXm/ytF9QC9U2pT79ZHZYb9UW60A9k4L6P3g68/Ef6GyrAPTWonfLCvxeUqlJ14V/APCvzF++GEEbziLu+JMvkVUh9OZNShjUGXpYwg4hf/nwvtZd/EpXMao3KQEdd1+rmmwDJQJauQKujVVkRN0JW0zP0b4iKPAgWMnlyJvwz1d1ESVD8/yTB8/Puuza+uUYjQQKUhUivv0OdxQuOMJjidAtEZUH4n42icrI7hEsn+kGRHRYjQEAVIrMFS+xNGm2VD+LwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeuvisdM3UeMIDp93xVEZjajM2nRK0ULdBfP+jgjU5w=;
 b=m+qNYm8RviUZtf1mSx6CE3Z3qc4K+JDmvE+pY+fUii7hiOh/ToU480VRerdsjjVMgS6nIFCJtDXABN1fNvDC/VqbuUY6gsPkOVXmfmD2WQRQNzgmjhp9FbuyN070zxLMMqPs/hTyL9rrlk9XiLmk1khxakNeIHe0nDnXpTTMSis=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by SN7PR10MB6956.namprd10.prod.outlook.com (2603:10b6:806:34a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:23:41 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::71c3:4ee5:93a1:85e9%5]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 21:23:41 +0000
Message-ID: <8eea52b0-834d-4c6e-b668-ef9e884d0955@oracle.com>
Date: Tue, 16 Dec 2025 21:23:38 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, Frank Filz <ffilz@redhat.com>,
        Rajesh Prasad <raprasad@redhat.com>, ffilzlnx@mindspring.com
Subject: Re: [pynfs] Proposal to fix CB_GETATTR handling in DELEG24 / DELEG25
 (_testCbGetattr)
To: Suhas Athani <sathani@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <CAHZzugbT9vuoAaR7L7jDoPsLUtrrS3J052i-M=bL9O5nq4auqA@mail.gmail.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
Organization: Oracle
In-Reply-To: <CAHZzugbT9vuoAaR7L7jDoPsLUtrrS3J052i-M=bL9O5nq4auqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::9) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|SN7PR10MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 30040fda-d1ee-4b5c-81f8-08de3ce9629b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YitEdXJEbVVnWGlTZWcwcWlHMjV3b3B3ZzBQY0Z4cFZpdS9ZODlaUitIOEFE?=
 =?utf-8?B?UForNEdWTlBkWHczZW13cThLNlo1aWRvd1ZOaElwdVk4cDYyQ3JpcW05dmh0?=
 =?utf-8?B?aTNza2VTcmVjNVEzUlZXQjVobi9nQ3d4dkk0RzdTS1lia2ZEZFoxZWg2V1cx?=
 =?utf-8?B?UHJReGZmemZOUzV3dFRySXYrS3IyMGFqWlRiSFc4d2luRFVFbDJ6bGFyeGM4?=
 =?utf-8?B?MHdCNFp3OWg5clBPM1ZScEw4clluQjQyZXdoNW1KdnBCVlhtZUV3L1NLQzJR?=
 =?utf-8?B?UTh4NGpEaWV4aExCWi9FdmZQWTdtRmNXRHprdnUzMGJacHlYWnpaTlpWOTJR?=
 =?utf-8?B?MngyemcrSy9rY0haUnM0S0dTUTFkMU5hQUlWRmZBWG1SSC80WWV5VDh5S0Z6?=
 =?utf-8?B?Y3AwUGVtZmRnQjhnL2RFaHBsK2lIcHoxY0tYWXY2T0xsaVQ1Zko3empYUURC?=
 =?utf-8?B?UTRvMFV6aUx1VVhYRTJRdUNkdzJybWg1TW9rSXA3eGVtaGcvUFhzU1NZNWh3?=
 =?utf-8?B?djVESnV6a280L3ZmcnIrYXd2ZEtRTVh3dG5BUXNxbnNhY0pvSnpzSHJvUUFM?=
 =?utf-8?B?cGJVZlBESjAyNFo1RFpVVjJVRFRwZjJNbmVBYncxM3dxdkJqcEpsT2QrM0d5?=
 =?utf-8?B?N0JLbC9za055eDN1eFpuTEZYRFdwVFVSa2p4N042MXlGT3ZJeVBDWjNkd1dr?=
 =?utf-8?B?R0h5dXFyN3F3bmd0elpTbUEyTVBZNGpNYVpJS0tmdDNjNVltNlRjelc1T3kz?=
 =?utf-8?B?MTl6dmN0MHV0ajVBNXQ2Y0Y2azFycW9xZGYrRmJoWFRiTzZoTEw0N2pFbjFv?=
 =?utf-8?B?VFc5NWNBRHorVXNXUmlnZ2ppWC9RVHVTOE40K0VsaitsU0tEZnhaMEZOSEZi?=
 =?utf-8?B?RzViUUtoajhaT0gzWWJBZ2M5dFNCcmhxZ3FVQWYxMnc2aGxqZG9IN0d6L1lG?=
 =?utf-8?B?MERSVmhZRkw2dURiZ3dydnQzNnZwUFdpemJiM3kwMFFxanB5ZWxjQVlQSXhX?=
 =?utf-8?B?NHZpallVK2JUbFE5ZWIxbE1ZdWF4R1BMUnErTjBVdEJBOTAxQ1FhSVlicm1T?=
 =?utf-8?B?QUFqV0dUaWxVMWZwbENzQnRFZ0hmRHUvNy9TeUk2U2ZjZC9DcHNTL05CZlA1?=
 =?utf-8?B?Q3I2QVJDV0tJUENkT2lzMWlBelVvampqZU0rZ1djYlVkZFk4YXU2ZzN4clM0?=
 =?utf-8?B?UlIrclMybkJqb0RkWSt5TmxOTnNpK0ZpQlRMcnVoZ1Qyd2tLQlhzVC91RVBI?=
 =?utf-8?B?c3BpTEZOR1VKN3gwY09uRzZxYkxPQ2trZ2VydURCREx3NFhNMU00dkQxWHVi?=
 =?utf-8?B?RmZBM282TVNKUUhWQjJkUFlES1BYZFVjWnI0aHhsQVRKeDhDVElZNHlRVDk5?=
 =?utf-8?B?ZlBnNXFRcGJrWlcrS0pIS3ltUFc3c2FKSFQvNm11Zmg3NVpBWE9aY2w4YmpZ?=
 =?utf-8?B?R3g1MlJVdGpWYm5pZ2dmV3NSWGM0UmJ4L0VBQWR2N3J6b2FqS0hHMFRLcmxm?=
 =?utf-8?B?SGQ3RUxkNWhLMlZmYnZCYjV6bXNYSG5TRldBbmhTUHRPckd3RHBYeXF1eDdl?=
 =?utf-8?B?QnpQQ1ZRSWF5ZTJ0UUp6aXJYbi8yamVHMW5GYnltRjRxV2dDbWFoa3ZMS0ZK?=
 =?utf-8?B?clh0Mkc4a0VScTU4bVNpNFZBaGVLVGwwcUluV0lSSmh4NFh1aDZOeWpEV1ZF?=
 =?utf-8?B?d3U3ZTltSDJ2L0haWmpxZmNkVkpieUd0a0JHUnB2NEo2Zlg3RlA0YTlSV3Va?=
 =?utf-8?B?Nzc0STlPQWphcmFnK2dobVE2LzFlbE9qZDhFOFV2b1QyZGtjaFdwdG9mVjZx?=
 =?utf-8?B?cmRhOTFzb21WdW9JVTFTMEpER01xaHJKQjBicXpNWkVOTVZkRUkvVjkwYUtN?=
 =?utf-8?B?VXpoWUIyWTNJTE1Vc1VDOTZ3YSsrT0dPS0s3OXp3UDljY21NSDZxTGtQaEsw?=
 =?utf-8?B?bkdtNWt2OEtOeGZlWTA1NEE4Vy92cVpSdFpkZkFoYkhpN0kvNWl2WUhlVkVI?=
 =?utf-8?B?TGhGbEprY0wrQ1Y3UXFKSlFVYUdOdmtXTW92VXZLZmtDbTBVbVRXbkgwM0gx?=
 =?utf-8?Q?eR8oSu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZElOVGc5S3NXWkVSVlhIbHMzY3dDNkxVMURLM2VBcnlIaXN0akl5d05iL2hF?=
 =?utf-8?B?am9NR3BLODYzUmd0Q2IyQ2Ewb3pEaWxXcWdYeHpyVVFieDk4TXlzZ1luU2tq?=
 =?utf-8?B?U1dURE9QcCszWjNjVG1saVhYMStMRG5IY3dxcExheUdNL2hnSHVGMkZZOVI4?=
 =?utf-8?B?TC9Wb2JkZ0VlOGtBc0NCdXhyZmEvUnhyZnNQMHFMektjSzAyc1NHbytOdWVy?=
 =?utf-8?B?RTUzQ2xWVFN0TGh5dEI3WVREMml4Z0VRUy80dDNGbGF6VkY2eW5ZNG9nQnVs?=
 =?utf-8?B?d09UZmZJOXFDV0diN1A2dUZJOVl5YTNSRUNMcUpsU0FWbW1oZzZ2SysvNWgy?=
 =?utf-8?B?REtmdkpndm5Tc29vbDliMzhtMzhkNUtsSUxIUWFIa2FvS3QvOWZ1cXowT0JK?=
 =?utf-8?B?TEpkRkcwaElPQTF0OTN6VVpsV2djWXlMN0lXY3NmZE1RUXFlZzdsVGpqOHJC?=
 =?utf-8?B?eHdwV0NUSG9KeXdXNHd3Zk1lYjRWQURxT294ajVIREdjWWNCTXZVeFJhWGhS?=
 =?utf-8?B?U0V0a1IvcDhWeTA3akNNYkdWS21FR2NUWkpEMFFSVzFGaG9yd2VsaGNWSXlW?=
 =?utf-8?B?Y0QwWnNBZEZiTGlwUlNxdEJIQ3RDejJadWpDV0VCNTFqWGpUVGJscEdzOHNI?=
 =?utf-8?B?NWgvWHkwWENSdkxTVVR4U25FVDlyRnlDQmtyV210THNxc1ZLYTdJTWpxRVN3?=
 =?utf-8?B?RDdRYnIxQlNtOGFxQVh5OStINTZVVU54RVFXMjJveW5LWFlvN1ltY2hYUEJJ?=
 =?utf-8?B?SXJIRGgyMmI2cFpZRnFGOEYxRkhKY2dXOTM2Ym9sNXFabEFIRDNNWVk0MVFX?=
 =?utf-8?B?U2JEOWpINC9HQ0MvejE2cEN3NHNUSHlyUGhFdHFpQTZja0JkSnhlb29WYVFk?=
 =?utf-8?B?bHNUekJIYURXVS9zYTA2L0kxZW8vcTE3SDJaeEJxcWkwc2dkcDBENzBraFhM?=
 =?utf-8?B?NkQxVHFTOUdHQnNSN3B0VHFUUmZLM05uQ1ZycXpCQjNtenI4aGw2NkNzeEQ4?=
 =?utf-8?B?QlN1YjFwelcrbWs2Vm1SaU5NV3NpN3I1UEdDSlo0elRrbjhuVlppRHVPdjRa?=
 =?utf-8?B?TGhlMDRzWGVxVER2aDNFWlR6V3ZFQnlWZ3hNVnZORWdCM3IydmdtNXFCeUVL?=
 =?utf-8?B?S0J1aDdkUWpzUERINEwxdklpellJaXdLOHhHRXFMeUdMZFNhY3N5aDBCamFj?=
 =?utf-8?B?RzZqbDNxN0tqeUdrS0pyZmtNRXliT01qZlpQZnJ4OXQ1djNVSVRPeUJYZ1V1?=
 =?utf-8?B?QTZVTWZxUkRvcjZVTWhUd0UxNGJkN2QyWnFQd2NFeG9BSUQzTk0rMk8vcmVI?=
 =?utf-8?B?REJjdUFObDNxMDBLUVRmY2owU1VHRHRQWUw5U3VSNEREcElJYjBRU1lqa09O?=
 =?utf-8?B?dDJieHg5OTFhbGVoZmtFbk55R0RlbEpMVHloR3FjZmRURzVKb01zUXdNbXBr?=
 =?utf-8?B?Tk4rQlZlYmxwcHhJVERIckx2MUF1Y2diNWNoOGFTRjk4TW9TR1FXOWZVVEJs?=
 =?utf-8?B?RFVZeGt5SEhtK0RDcUVCR3ViUHAxY0ViczkxWXhnb2RibStOSXA2cER6QzBW?=
 =?utf-8?B?ZUptd0JveDRYcHRqbFRZMWFRQVhGNTBnMXU5bnROcVJqclpWeVUwVDlpSTVW?=
 =?utf-8?B?cW41SkhQb3ljQVdDM05wSjl1Nlh3ZmZWNnZlS29KVjRVQmQ4OU5lSnpYOHE1?=
 =?utf-8?B?RjJBY0ZKaWYrNG1vMWhIcXE1OWJtMTZ5OCtBbXV0YnFmVjlCbjBBdFRPd2Zw?=
 =?utf-8?B?cmRSN0hScFBtR3pxbHpNTzRJWHVldytrMWFyR214bXRKK1hzYUdSTG9mQTNN?=
 =?utf-8?B?bGRxam1wL0pnekN0YVVub0lCRnV1Sk5wQmg5VXRjTStwYnNoZmV0VkJzVnd4?=
 =?utf-8?B?L25tN3Y3L0phcXEwcDhvNFd3VmVzeC9KMisxMVdBZEJyb01rSUVydkt2dVYr?=
 =?utf-8?B?M3plOUlGUEZ4QmhmQllya3ZPSTNwcEtJRHhwU0dzNENVTUxOWGphNkVuSXkw?=
 =?utf-8?B?ZGltYXUzbkpyNXVpT2RaaG1Tb2E3c2hoZCtqRU8raklDbkNNTkw4SjBmWWxT?=
 =?utf-8?B?SWRuUHU3VU90cHRSQWJCMjUxdnZBUnNEcWZjQkJNTW90S2t6UWZUWE1DczJK?=
 =?utf-8?B?dE45RVZzVTRMVEkyNVp2aG9EL0ZPUjNMRTd0S3dhNXF3Z3lyTU5qOFkyZkZG?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X+wt291Z/sS92qJiqJYTgqaINzC6pSnWRV/GDQCzPTCka4XQJPFlfUh78JuC1Q5Svgvf3uToRckuDjxmFsLq/kmKyE5TNRrKNqMkaJoSwZNttPjdLGGCIniYfcd5iSiO4H9nMlZm0f/Bb1CJnHPKCj3CUbaM83gsFdhprclBqT6MlmnWCtMSnuxZWgTSPQFFYbiN7WViDW1RB8MVAUpaya6ANMS5vjekVL90Xtaq/RQQV93WW1yMUmzW3GDI1zHEqEZqBOdkVT6BNhBnA+4max3YudV7e5OM7lpUEzHyTMSEPYW9kXcDbLX5VIw+97mj9Xth/7tEWV3hT45wO6SMmyojnyunn02xryxB4cZ0UsIk0dYh8AEhfEnJ9TlpNTFEgvqBmhV8R7ZhakCJyDIZMzbq4KOeBm/rz1Ks5hJMjS+TAiOHWr8goTFVhzcnWmaNR3sH1eml2Fe9Ccpb5/ms1fM9hkf1fPbQLV0AW2aw603zcZ8wecOPbhYQZESiTyjWxsYBKq8jJHl53BNnWx0MVff45TdbmiOm6a6VjBHWmZKknmoGU6oBeDijjxq5VQ+IKrYnkcm3Z8LrwQ+Dtlx1YaRrw2YTOw4DDNOk0zgCQqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30040fda-d1ee-4b5c-81f8-08de3ce9629b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:23:41.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjMEOpiRTdW0xlwU+G7qFxT4G2X0mQEvL5ddk3teXJvoar+0qtG6aqoZ50Q5Xoaq7ZvURTid4wvT7mR8fldckA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160181
X-Proofpoint-GUID: IbuCZvbOX5-GRukM2cfv7emS7yyf_QgM
X-Proofpoint-ORIG-GUID: IbuCZvbOX5-GRukM2cfv7emS7yyf_QgM
X-Authority-Analysis: v=2.4 cv=fOQ0HJae c=1 sm=1 tr=0 ts=6941cde1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1_HS_F9FfTo7p1hO-aYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDE4MSBTYWx0ZWRfX6eiej6frELSF
 tkY0YZQ3q1N1iYjhMj9I8xu/AUOBGctGeaB6Es9CXY+r+eG+uxBrcQYk4v96cuvevXlptkyhro8
 YQg4FraNs3h9juZj7IPWqHMrGas5ud6O2Fqv1KUhcpwH9F3MiZUU8Dn1xLDi7kOx8emg9WRa53a
 0aMRC6jYF2ltZFtU5wi5pvdB6w/70wRRMpwLCEfZlvyW9I9cVEFRKwWuttPe2tW0hjFNXqtTRP1
 JbYz2JT0D4mvo7Y58vZGIM9HZ1yu1nQJCa3Vh3ish2zPD1PMI9zvrVaRVaM7tFeAeNBPvNmnGuM
 8cOQEtKZDzAcLLIAoAxROnCLVbix0RTeewZzmp5ZuVamvIClYuVHnp5sznZNi9MzwdJesW9ueJo
 8l0Yened5sSZJiQSw6HZ3QyvYuB7+w==

hi Suhas,

That's great, thank you.

Would you mind please submitting a patch with your proposed changes?

I'm a little behind with recent pynfs changes, but will get to them asap.

thanks again,

best wishes,
calum.

On 16/12/2025 8:50 am, Suhas Athani wrote:
> Hello,
> 
> I am working on NFSv4 delegation testing using pynfs and recently
> encountered a failure in the delegation test cases DELEG24 and
> DELEG25, both of which rely on the helper _testCbGetattr() in
> st_delegation.py.
> 
> After analysis, the failure appears to be caused by two issues in the
> test logic rather than a server-side protocol violation. I would like
> to propose small changes to the test and get feedback from the
> community before proceeding further.
> 
> 1. Incorrect bit test for OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS
> 
> In _testCbGetattr(), the test checks whether the server supports
> delegated timestamps using:
> 
> if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want &
>          OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS:
> 
> However, oa_share_access_want is defined as a bitmap, and
> OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS represents a bit number,
> not a mask.
> 
> The correct test should be:
> 
> if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want &
>          (1 << OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS):
> 
> Without this shift, the test may incorrectly assume support for
> delegated timestamps, resulting in mismatched OPEN arguments and
> incorrect expectations in the CB_GETATTR response.
> 
> 2. Handling of NFS4ERR_DELAY after CB_GETATTR
> 
> In DELEG24 / DELEG25, the test currently accepts NFS4ERR_DELAY as a
> valid status for the client’s GETATTR:
> 
> check(res, [NFS4_OK, NFS4ERR_DELAY])
> 
> However, immediately after this, the test unconditionally accesses:
> 
> attrs2 = res.resarray[-1].obj_attributes
> 
> When the server returns NFS4ERR_DELAY, the compound reply does not
> contain a valid GETATTR result, which leads to an exception in the
> test harness.
> 
>  From the server side, returning NFS4ERR_DELAY is legal and expected
> behavior while:
> 
> - a write delegation is held
> 
> - CB_GETATTR has been issued
> 
> - delegation-related state is still being resolved
> 
> This behavior is commonly observed in asynchronous server implementations.
> 
> To make the test robust and protocol-correct, I replaced the
> single-shot GETATTR handling with a simple retry loop:
> 
> - If the GETATTR returns NFS4ERR_DELAY, sleep briefly and retry
> 
> - Continue until the server returns NFS4_OK
> 
> - Only then validate obj_attributes
> 
> This matches the intended NFS4ERR_DELAY and reflects how a real NFSv4
> client is expected to behave.
> 
> I would appreciate feedback from the community on whether these
> changes are acceptable, or if there is a preferred alternative
> approach.
> 
> Thanks for your time and guidance.
> 
> 
> Regards,
> Suhas Athani
> NFS-Ganesha Team
> 



