Return-Path: <linux-nfs+bounces-9796-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA737A23020
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 296637A15C6
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773CD1E7C27;
	Thu, 30 Jan 2025 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aeij6lRc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BRGUURH4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6B81BD9D3
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247343; cv=fail; b=jUAVN6TdR7Bz6BmWOYfmSrFJcMVrwlbXDRR+kMIGzViQc3rKhj4bwky75GYuMfwoHdS3GcMJaLZEjqaAe0msutqzi5OkDWUXZDxTbVLFFpXTfsGjwpliuJLfLWYOPbQQkzDarWEqMI/iORO5+1zYw0EalsUgLkq7p8aoeW1bBhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247343; c=relaxed/simple;
	bh=mgKZV7AUQSC5gr9GX797vXJOEY/WG8mAXsMzheagCRU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fI5mnP1TPuCjSSS89orTBUyfCXbp1cI7fj0kuvaNwR5wa7QFG95qcWWRD44Y93v7ispP6TNDPPd0/B1cAUEW3zjIoHW8EsTg/xK4bjwMsbNa4kQmPxJXlCregG9D5Kgsb2InECYTT1lbwRURCPBHyYZtUQC4uqwxXWo5EaH+3H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aeij6lRc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BRGUURH4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UALmh7019017;
	Thu, 30 Jan 2025 14:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=G4UGtdY/gEFss2lhQD8+6RmJefJxoop2dsw4ZoPDXoM=; b=
	aeij6lRcRj6K32cD99AwH5NF0pUJuh345bB3EkyntqqEOZf4I1hjc8NVd0rg8wjV
	dPEhyaTkcqZwpykxfpaRK3dRE1OpNAeXWo6dahkqx93bFA4cGVz5JnZzCrFZZIMA
	ELeIBw/zu7ChBayffgRlJzBF1ec5+2t6Eu54uZ3mOY5nNAv4ZARnMyzyZOtu2Ryw
	RqVqP2EvoYyQzLL4zat7XR/i8qAX3bD2Kf1cxd/E21djUCiLn2RjYKVsuob+eFNh
	Y8bSvXnPenKtVqcOt+yp2W6TAyLvAMMj7gDPa+BoHv+p4z+hlVjLBsfvKhLLS2vv
	JWwCHFT0Xw93LknsYr99xw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44g7ku0dt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 14:28:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UDuAnj036385;
	Thu, 30 Jan 2025 14:28:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdb4gkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 14:28:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c06fCAna14u6zuAv6F6to/Obx76c4BLXBlGAfWnUlLuOFu4GULEdU6+TpPiRR8UUckkS6OAEOax6PNnuld0MaVjqG9wKwli5pOouP53Fb17e18M5EcjUSKTCaI409AoWaBtsbWvzXs9pmQyIEQQQpngfYB+HwWywRHHURjfF1tB7nuPJ0KU7Y3f11B8hMjd4rSEOEvkBob7MX/t5QhDjB/n4LF/+WqvY2+/fnnd1nohxKsU9hNuf8Tdlv7Fr1A4ZP1RvBAmI4bC4/KUAsTKTxrdYL/GQT1hRNaFvy81ZLdS4MSC1AqwVflLsllo37kAdFIXFFkAVPSVJRZ1axDeQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4UGtdY/gEFss2lhQD8+6RmJefJxoop2dsw4ZoPDXoM=;
 b=EYZFNZXuanjFygWNZQZjOM7QiZhDAz+EpR4eReg8AImb+lplH2aVWLpmSQq6U/mT+C5evt8/APkXqVhV8EOLvgGtvmPjVNCl57YD5JUcK7ZhgwrgjcVOvJL5HHx5o/ypfG/BCIPfRPAnn/PjvS+pBU3EeSfJAQQgnGl9uP2Bs0qTMqtAo2bA4tXMZs6Jg0nGJRf6e1W5TootppnU6qzzBkv9krUf8ur0lc2qaISAk2lN+vgkulIqUPEhCHI160IjA2jtpzEerF4Ali34rgRSBRC0Pr9d0FVxqmAnBPBjxPw+1FJpHPHygGiMrjn57ksLoZU2IW2qqxITXDrjzIKMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4UGtdY/gEFss2lhQD8+6RmJefJxoop2dsw4ZoPDXoM=;
 b=BRGUURH4yos62fYACD/atGG6JLCmb+Zgw4eISjYluOOJLaxrkz7rwDLq9J/Arb26APyDbPRqhIQw7AqZ9B5eklxtw29r3L1DxIXitb59mlyfLPy8inUW2FY76+IcHuhzhnPMivlb0YJFEsOFXZNRixZYcE56oZ1aHsR0TEI9YsA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6806.namprd10.prod.outlook.com (2603:10b6:208:42a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 14:28:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.020; Thu, 30 Jan 2025
 14:28:55 +0000
Message-ID: <657ee936-abe6-4562-8e6c-b4a02e1e5611@oracle.com>
Date: Thu, 30 Jan 2025 09:28:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 0/8] mountstats/nfsiostat: bugfixes for iostat
To: Frank Sorenson <sorenson@redhat.com>, steved@redhat.com
Cc: linux-nfs@vger.kernel.org
References: <20250130142008.3600334-1-sorenson@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250130142008.3600334-1-sorenson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2e5040-3090-48b9-f444-08dd413a6d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUdmeVpKVjRwQkVUeWpSV1NreFRWYnY0QWpnSmUvSEZlcjdvaEg2UkNVUHN0?=
 =?utf-8?B?Y2FmU0lKbXVVRVpTUGk5Mjc2YUU4STlEcVlOelFoNGFSRHc0UVU4c0xESW1N?=
 =?utf-8?B?VlhkWjBxNitqckQ0V3BFQW9UbkkrcXFRdExDenNwWlNCd1cxaXVMbXpCSmh2?=
 =?utf-8?B?a1lrUm80U0h5azFpd1BmcHVGZm1qUTRnOCtJZWpYVnlzazZaU0ZiZ0pCZFRI?=
 =?utf-8?B?QjBiWTg1MERkbytsSVBjaFlNN2xQSnQ4S01IcUhrdnVLTVRQTGlwVmU1RjJU?=
 =?utf-8?B?Sll4THBoMFZ3Y3BJdXlldGtlQit0ODhrb1RKYlZ3b05jSTIvTFFMSk16NGpE?=
 =?utf-8?B?akkrTmo0dEV1OCt3bno3ZzVCUGhwUXVsaGdGT2RpZC9aaUY0SFpCNFJ2RUZV?=
 =?utf-8?B?VG9JZGh3cFdYYUFvZG44S2Vlc3BWVHFMajU5RmF2Y0FhRGY4Y3E0Q3RIWUxP?=
 =?utf-8?B?SWdLd1IvUFYrOFZ1WlZ0Q2tmU0tNZjFOYVBUVFJGWWVLWUY3ai9pNm8waE1a?=
 =?utf-8?B?a05VVWNZWUtjZVlvRER1d3hndzV3NjR6VWRHejlUZVdzTjg1M1NQclRyTVRo?=
 =?utf-8?B?dlBJT0wrZlRNZHpORUlpU3Evdk5yOFBlWHZ0TXhrM24zVmVyME1KTUZ4ZmlK?=
 =?utf-8?B?VzRhZ2xpeVQxcDFFM1RtaDNobGdDbHQ1b0NZcVBXanJzZDhIMmNHdHN6MFBa?=
 =?utf-8?B?VWxKNi8vSTE3VTlQOGwyQ2I4SGk0UDdVOVJoY0I5S29MOUxjSmFzaWdoZlJZ?=
 =?utf-8?B?WmZUYitFdmdKay9JaGo1QTBlOXFMdTE1ZncxMXZweHducGVrLzc0RDJUY1FX?=
 =?utf-8?B?YWNnQ1RJNERMZkF6YlpCdnpZaHpxMjh0T0tmNHVCZkZQV0ttUTZrZnk5V1VL?=
 =?utf-8?B?bk1zUGdBRmgrUGxBRmdvOVliak9lUm0zV1hUVjRwdzZlQlhHWk0zbGpLY2hR?=
 =?utf-8?B?MGljTWhwM05sK01nZ005Z3AxdktSb3VWbFAzZ005dW05S04ramUrSEVhb0pO?=
 =?utf-8?B?NW5jUUpDQkhZalhDU1Z6NGQ2d2huU2VnSTVtd1lyZjErNU5lV1ZmbklBdXdr?=
 =?utf-8?B?UEJCZU1EdllFalVGSE1sVXg0NXNZejJGMW9ma0NaLzdyTGQwOXU5YVVyZ0xC?=
 =?utf-8?B?aTdnYThhQjd2cldEaFRRMkN6aGg5Zit1ZVZkSnNQRDhXRCthU3JPajRuMUZ3?=
 =?utf-8?B?dTVpOHY5OEhpZkJ1VmJWMXQvZ1cxbk5tTDBlNXlJSTY3d2wrZk1OaFVaR2pF?=
 =?utf-8?B?OUoxOEdta1gwVGJJNVYxUTNOMkVPbTBmN3dDTUpjcExaMzQrd2tHbEk5eVlS?=
 =?utf-8?B?dkQyMVV3S2FWa1FqekEyZ3l5UVc0TDNtSFduNWw3S2lYNFVzeGRlM29NV1Uw?=
 =?utf-8?B?VjU0WkhCNkk5LzVIY2M1aU5lQVlVLzlTcUJPelptWktXVy9wNkZSbW8vSkJM?=
 =?utf-8?B?bENYSmZ1SmlORHUwWEFQcWRBb2s3S2FKM3BHNmYxWGxrVjdYcHJQZHBPbXFl?=
 =?utf-8?B?TTJXd01ySlI5RmMwbWMzMjFpREdtRGwwcjR0cEp1VUEvMEs1VGZSOUxQdUlz?=
 =?utf-8?B?NjMrRG1iSFdxNFIreDZmUUMvckhpSzFlTWJQamJqMlZnNFBzZ05RTWVTS2J6?=
 =?utf-8?B?ZDVINzdPQVlpVFVFZGxEZjBvQlFVQm5HdnV5Z0xJcFdMOXRXYm1QaThyQTNS?=
 =?utf-8?B?ZXcyZDNPblprOFd3MHNSbnEyWlVkUDlLTk81dUlaWWtYdHRnb1N2MGl6VzVH?=
 =?utf-8?B?YmFVMzh3TUQ4RzF5VHZUMUEyVlduOHpJSWphVzIyUFF4NDN0bFdTQ21GZTd2?=
 =?utf-8?B?OW5DT2NEOC9GaXdRUkdxT05VaTBVei9HWHBTdXpKMkhRQUw3bmdGaUhLb3Fs?=
 =?utf-8?Q?DlwSnkawu+T7Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm9HSzFYNzFsbkY1N0RvdlVPMW85dEgwRXpOQVRFWDczK01qcmE1MlluS1Ey?=
 =?utf-8?B?dGg1S0FhSmh2MUd6S1kzajJjeGpReVNVRDlkWkVGQkp5SVd0WTlBQytsMFA5?=
 =?utf-8?B?RnB0QmY3WVl1cE0zNzkxb1dTbTd1eGtRdVI0Zit6WmRPd3IzRFliZk80RlQy?=
 =?utf-8?B?M2FvS2JTQ1hQdDI1VXhIbXZKbUZOSkVKZ1doV2VLS1oyd2RYN0J2U1hBcWxE?=
 =?utf-8?B?T0V0L2pPSXN1OURkMm9Ja0owZjFLS0ZRTGtZTy9MaWlKSllXaXU1RCs3NFRR?=
 =?utf-8?B?WkR1L0l1dUxrWndmNDRURnlCdWdDZkFueE0ra0FwQWZCcExnUHV4T2JZRElY?=
 =?utf-8?B?UlFYWGpUWHdwTGZjWVNkVlE2WHRPOW1PbUxhS0c5cnBIU1dYdVFrQmkrNzkv?=
 =?utf-8?B?THZlaUdvVXVuMWJqMG9JUjV5b0VqT3VKZGJXWG5nZ3JScVFOYW1xdzNUWTM5?=
 =?utf-8?B?cnlWZmRKaDh0K1VpUHJRYld5aTFqYUloM2c3UVNVdjZjS2FPakx1VnNaT2Jh?=
 =?utf-8?B?S25hMjdmZklaM1V4TUp1OUJlVU5yRjcwQ0FUL3NQbmV4Q1pEb1dsZEVwYkNE?=
 =?utf-8?B?ZUpYcXRxVjVRbUJveCt1RGo0UFJXdEZaZU50TmtLUDNyYmt2aC9NTC94V3Mr?=
 =?utf-8?B?V3ZBc1g3TVdkbHN4QUdDdXFYa0xMM2ZMTXNndUVUbldBR1FncnNFYWU4TFFQ?=
 =?utf-8?B?Qng1S3RVWjViMVZzbWlISWozM1dobDBqcHBTcUgxWkJ4ay9QMzlOK0MwSTE2?=
 =?utf-8?B?V1hhSnRQUytLVmpmN0c1Y0p1NkJ2blhXNXdqT2tiRWtvTFlWSEhPanB3aUtE?=
 =?utf-8?B?VzJLQ0Rnb3oxS2lJNzVubEJpTGZFeEdvUTMyWkxxRlRUUnkvVU1DSWV1L1E2?=
 =?utf-8?B?TUxmbjd0YU54M1FVWGhsRjU5dHdOVU9oeHp0Wmk1MTR1QnlYRjdxSGJBVVY1?=
 =?utf-8?B?NkZpb2p2TGJrVGRHc2FiWGVNZXV2eFUrdUM4YmFrTDh4MnlmdEd6MVQ1M0FH?=
 =?utf-8?B?YXFYL0FxTlF5dlNrU0s1VG1KSFljVjlra05sWVNYME9SMFpPd0hHNTNWUUpI?=
 =?utf-8?B?eGYyQnliTFhqWWVuQUUwMTF5dXJocW42ZWNDekZWN25OVGZRK2N2dkczdnhF?=
 =?utf-8?B?a1JOZzN5WGhaNFJaTStmOXplSjN6a3U1Z084MnlaQXNrZ1ZkTEtxdWhWSVcr?=
 =?utf-8?B?Z0VnUVhBUFhvNmJOUlJwSjVUVnlTQmhFMFBqY0pBNmoxQUxlRjRCZlc2NnY2?=
 =?utf-8?B?T3Z0RFVKSk1NMG8zdm9ZbTZVYUlCL1RGWWhDd3I1UTByd0E1Z2NiTlJqOXcw?=
 =?utf-8?B?UFE5U0ZmUmYrQmo2b3N2Q2ZrY3hKTVJEaUl3eTlGRU5DY3kxWFpoeHJrNXE2?=
 =?utf-8?B?RlQwZGVWK09kaGREM1Y0dkI3dVVEUi9EVzNTZlhRZ28rOVhaYmU5TlprY2NC?=
 =?utf-8?B?K2djT09yemdUc2FUQVUwMnRDQ0Z6bEU3ekY0SGxtQ2tZU1dQWTA2VmtXbTI2?=
 =?utf-8?B?clNuVFllQWluVG5GeC8vd1o4VzdFNFg1Sk0rVmRTZ2x3c0h3Q3pwV1JTdnFs?=
 =?utf-8?B?SW9mWXlweDEwUUVoaDdUV0dGTzk3amgyaDBKajlnUUFpc3JmdUw4SWdXWGlT?=
 =?utf-8?B?akY4WTRuK21vN0ZsTkRHN0tLUzRoYlYrUS9uSExxUGdnTmliSHh1ZDJGbGJH?=
 =?utf-8?B?NDVhV0lzeEFmNmFDSWtUN2tUTXFzWjd3OCtWNkpwdWtrNkM4eGZTdCtUVFly?=
 =?utf-8?B?OC85RlFNVS8zbXEvTnI4MmFYK2JKVTVoaDFhc1ZJUHpJaGNDM1lZZ0h1VEwv?=
 =?utf-8?B?dk1LMVNtdm5vRVJscEZnMUZKVEFxUUJRYndFUTY4NmcrdmdlLzhZWFordnFJ?=
 =?utf-8?B?ZXpwRzdQOFdxVHVwVGRKNjJjWTN2bWVzOHBscXhDLzlxR2FLU0NKUFNzRE1T?=
 =?utf-8?B?cnp1Skg5U0FxNUhNeWkzaFQ5ZW54QXdsNUhqS1ErcmdvRWhKaVNLMVA3bUpI?=
 =?utf-8?B?ak5lYWNCMWtKbjNPL3BFeHFUSDV1cTF6WnlMa2dzb0U3elV1K1RsUjlTQmVQ?=
 =?utf-8?B?QW91Tzg3a29zdnh2d0xMNWZUQWlaU3JUTkxNN0JHQUlDY0lua01ya0VpTi9V?=
 =?utf-8?B?YUpiL2Qrc1BIWE8vVkM1NjlFaS9TZmN1RXVYL0JYcGhFb0tWWXhha1VQVnVN?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wMAX3mx57kaRCH6qST38IT3re9H/byf58E9ydMoqruNliL7TBsS1jcE+4hjC7YCIRyJAvR6i04IIx+kLhYEqo7H80Z21NZEx37u26mR6O7x3AbP0EK5ftgV2Fnc7PQKhdhyXvOHpPEKOocvywyMp2RWRHGNTjUSgBzr+hFyg/Yl6T7EsEiziXVk3wRekDuqHSwPP/wnYRDHR/nRYtVOh/3bplV/wsVBpi6vz2JaMRoE9+YSWgA0xE4wB12XUfUjVkz0EPShcMPzJzAfhuQs5vw08CH5g8yhhACHA04XD9ys/h0/oixwG/PFvctozmLMP/LD9Hk6viFh7J+xZQikDUJzUWw2M8Htt6RFKRwjejmH04Y37taXaeg2qS2lYHqR40MVbkJrlbtmEiadFAQUmJrndAUD2CiGdQsDH+4lCLn4CXl1ysH9EbrtTd+0OHL5yEVvxMSvMhkQ6w+fTR7FdQzOeKeR+TnPCmlrqixoFoXYqdkjyAYQHbbmNZzWHFsUTcmz1E1KvqDC0gT4Udw1dRKd0+IY6kL2/OtKQVkCLGk/V9Iqa9Z+ZVabvo5qAV9cXqjRE5G3x+/g349YTj7ekilghYPCQ1j/D3pEa8iR2v2c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2e5040-3090-48b9-f444-08dd413a6d66
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 14:28:55.7213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJaRjzn0W4a+UTUNPNp9qo1ihTdRYuxD8wYJEnqNJAVH2rdMRsYC5xmRlwkLeN8L94S5HXU6pcSUzXvkOlnLpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501300111
X-Proofpoint-GUID: GF53im__1O0ccw3jIuhs_rSo8IX9PanZ
X-Proofpoint-ORIG-GUID: GF53im__1O0ccw3jIuhs_rSo8IX9PanZ

On 1/30/25 9:19 AM, Frank Sorenson wrote:
> This patchset is intended to fix several bugs in nfsiostat and
> 'mountstats iostat', in particular when an <interval> is specified.
> 
> Specifically, the patches address the following issues when printing
> multiple times:
> 
> * both nfsiostat and 'mountstats iostat':
>    - if <count> is also specified, the scripts sleep an additional
>      <interval> after printing <count> times, and parse mountstats
>      unnecessarily before checking the <count>
> 
>    - if no nfs mounts are present when printing, the scripts output
>      a message that there are no nfs mounts, and exit immediately.
> 
>      However, if multiple intervals are indicated, it makes more sense
>      to output the message and sleep until the next iteration; there
>      may be nfs mounts the next time through.
> 
>    - if mountpoints are specified on the command-line, but are not
>      present during an iteration, the scripts crash.
> 
> 
>  * 'mountstats iostat':
>    - if an nfs filesystem is unmounted between iterations, the
>      script will crash attempting to reference the non-existent
>      mountpoint in the new mountstats file (or if another filesystem
>      type is mounted at that location, will instead crash while
>      comparing old and new stats)
> 
>    - new nfs mounts are not detected
> 
> 
>  * nfsiostat:
>    - if a new nfs filesystem is mounted between iterations, the
>      script will crash attempting to reference the non-existent
>      mountpoint in the old mountstats file
> 
>    - if a mountpoint is specified on the command-line, but topmost
>      mount there is not nfs, the script crashes while trying to
>      compare old and new stats
> 
> 
> To address these issues, the patches do the following:
>  * when printing diff stats from previous iteration:
>    - verify that a device exists in the old mountstats before referencing it
>    - verify that both old and new fstypes are the same
> 
>  * when filtering the current mountstats file:
>    - verify the device exists in the mountstats file before referencing it
>    - filter the list of nfs mountpoints each iostat iteration
> 
>  * check for empty device list and output the 'No NFS mount points found'
>     message, but don't immediately exit the script
> 
>  * merge the infinite loop and counted loop, and (for the counted loop)
>     decrement and check the count before sleeping and parsing the mountstats
>     file
> 
> 
> Frank Sorenson (8):
>   mountstats/nfsiostat: add a function to return the fstype
>   mountstats: when printing iostats, verify that old and new types are
>     the same
>   nfsiostat: mirror how mountstats iostat prints the stats
>   nfsiostat: fix crash when filtering mountstats after unmount
>   nfsiostat: make comment explain mount/unmount more broadly
>   mountstats: filter for nfs mounts in a function, each iostat iteration
>   mountstats/nfsiostat: Move the checks for empty mountpoint list into
>     the print function
>   mountstats/nfsiostat: merge and rework the infinite and counted loops
> 
>  tools/mountstats/mountstats.py | 102 ++++++++++++++++--------------
>  tools/nfs-iostat/nfs-iostat.py | 110 +++++++++++++--------------------
>  2 files changed, 100 insertions(+), 112 deletions(-)
> 

Hi Frank, I browsed this series briefly. I'm not sure that counts as a
full review, but it all seems sensible to me. Thanks for the clear
explanations!


-- 
Chuck Lever

