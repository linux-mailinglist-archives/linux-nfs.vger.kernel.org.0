Return-Path: <linux-nfs+bounces-10601-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40736A5FFD7
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 19:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4383ADEC0
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 18:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C003F1EFFA9;
	Thu, 13 Mar 2025 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bDnfLhhi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dlM4rcCV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1A1DB54C;
	Thu, 13 Mar 2025 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891462; cv=fail; b=DXQPaYMj8ZTJjO3PSQFl2X/OOZL7cUpKwBWfd2k2p4tGWbOQOgM+7YPVxDlWaAyxF3TTXtXOhcSYkZSVIRO8uJXLKmYE4yxONO8Cm3rvojJz15z92qR2FIMP9q2/AE2lu2bliYLoJXfh3JzTbpcZnIeGu8sNGXKiL00lAEItt48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891462; c=relaxed/simple;
	bh=PiuCRdo2y8/+eppAyBIELHqU4UnXF035seSiizCvLG0=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AJKlsMLT32XkA/Y+lFEnArI2ImAmLzygubWtBH0eTApZWeVlyeUr7OrUFJsMbaLXeJ+htzWudcNdGOlSiGw/WHvnw+Ym6cC7LA41bWabl3T82jWGyVLNdSt9ZgFO0a9/+uw2GPVDunGPOoDBHPMzm78BgPced8+MLzbL0VIbGek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bDnfLhhi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dlM4rcCV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DIfliZ025031;
	Thu, 13 Mar 2025 18:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tSdFI+O7PXoYl4bP/KNJEubeOWo8t5Vi7a32BTkVbC4=; b=
	bDnfLhhitKRnoljDTkYN2rVyyUYUtlEiDP5v9OkqVlzsvIPndSIH2dJdOIF3O7Hf
	T2jyHd3YOVDVsZ86tFqQhn/tvaXQTaHehvgt8nOX9/QMbTF6Pxt+9aajoH7FtFW+
	UYIuS49wMgiOHGYOfMHVcH2gZlOH4o/tlG6Y31P1CkWYqhSEBVd1hbiDCJEvL+0/
	ZdcUN+zrQBirXx/MWf9s/20g4CEXIGnIp5J1EZj+50jVQzLwy4hPOex0OeYPzVmN
	3bxM1o4EBvqUaQ6CmCLTcucph/kAvWlR/gPq2wuIGkQn/6lNEHIjtcwpdgFff2x6
	39MwNwXQRTY0Nso6Qi7DJg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dmy4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 18:44:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DHQugS008618;
	Thu, 13 Mar 2025 18:44:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn53n9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 18:44:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3G7E+zH+nI4MCpt0oKPT8+y5tSbL8X/Aw8zxnVuRDImBOKe1YONSpYNixRuH9L1se0iW7w8AD9IvB0bCnOW/uCeDI9xHy/GNM2xqaj4HnT8tihjSShwYOMFI3Xf/HCuusG6Pk1sfqtvPNpB2soRjxbU51MMeatjGU3LdtTXThGP5Ssv2cviWzQsZKyPBFqW0Cno+5cAUuZc9CZxYAekCSGj7z4XBkokm7PtR91NZV7bN9gLDYexLpEqIPAsoT6y1WAfp+R8oYjacxuh82tu0HIHes3glUhIzICAvwWu/tUJBEq0KystRsZhzlQQiySsKGnfOhTSGSZ2svpLbiShwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSdFI+O7PXoYl4bP/KNJEubeOWo8t5Vi7a32BTkVbC4=;
 b=TczVVBTfTPyv5msiQ6gga/lHYEJYmWoyx4bdsZNEPixQOSxMDlECzuRbxqqGJaqo4hEKclFoSATfjL8GoazHA2ZABxA2IOsA2oOxV1EVg5gk+ZkZhu703xfPU5udpulrz8cpD6//DRm2SaHgM+f1UXPw9QVGCvbNdRTdemsXPA65eyxqK7euGzzjFtNxfAalEusd33c8K2sePtKQVkkSjiuSor7j1upMzta9mIslQ9USy0AgX2uBKbkXUSjpkCiFZV73sI3eByQbd933uqFAPf3w+4o09sKHj+DikVUTtCAOfwT0u8SgJA+1xBlrT+T5XctC7V0jFZLxvhz2gy3Pog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSdFI+O7PXoYl4bP/KNJEubeOWo8t5Vi7a32BTkVbC4=;
 b=dlM4rcCV8vSZiORNEtgc/mCrSXsMlDxSX+2m1VW+f7ORZ9MFW/dlWn1So3qithBzr3CUUWIfwDHdfL8PMST98/3ewXeAwM+gZjwwxoz9r1dA3pOkqTqGaiA6+/Cu1kCFW6/9ZxFUZZ53i+VxfnoMBjj/5+4snBmidEaqOn/mcaU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7147.namprd10.prod.outlook.com (2603:10b6:930:75::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 18:44:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 18:44:14 +0000
Message-ID: <7285c885-f998-410a-b6a6-f743328bf0b8@oracle.com>
Date: Thu, 13 Mar 2025 14:44:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFS Server Issues with RDMA in Kernel 6.13.6
To: Lucas via Bugspray Bot <bugbot@kernel.org>, jlayton@kernel.org,
        trondmy@kernel.org, anna@kernel.org, cel@kernel.org
References: <20250313-b219865c0-2a34cbc6e249@bugzilla.kernel.org>
Content-Language: en-US
Cc: iommu@lists.linux.dev, linux-nfs@vger.kernel.org
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250313-b219865c0-2a34cbc6e249@bugzilla.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: 3620ac20-b1c0-48ab-c8e5-08dd625f0d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjV5OWxselAxclRSajYwdGttbFo1TDNKOEhFc3h1L3gzTzBjVDlpUENkT0VE?=
 =?utf-8?B?QjRVclU5OVJhUmJZU1M5dys1dzB6Q29LVVhkVU0xNjlsa2FLeFgwUHl5YjdT?=
 =?utf-8?B?QzNiL0o0YjBXZFFCUzNCdDhDeENkbEdpSjNkcmNFRXI2blZtS3JvQkNkWGlI?=
 =?utf-8?B?WVhqRU50ejloM3pPd0ZPdTNVaDJ3S1l2cHhncHVlNG45b2lSaVhDcEFDV2dJ?=
 =?utf-8?B?eWhJLyt1Q1E1WmdMR205bEdpQ3AvTGFZRWhGem9SMGtZMkFoRGNGSmdzVUhL?=
 =?utf-8?B?UngzSTh6SUJ1WnZLTHRBdFgyOEU2TUROQUJDbnowQXpZVWh6aHVZdVVmeU13?=
 =?utf-8?B?ck1XVy9EQ0F5SXJkdGtoUlBZOVh0MXpuK1JpbEhCNWpGWVlvOHJhVjREWGRv?=
 =?utf-8?B?RjVPeU9aaVI0OElmSExiV0RqRHhFekpjUmcvL3pBcWRlZ2RjalU1cG9XWThO?=
 =?utf-8?B?M2hLdExMcnY2SkJRR2hSckhxMnVMc1Y2SzdXT2w1eFRKcUpSdE15ZWo3Vm9n?=
 =?utf-8?B?dVV2WFdqOFBaMWxjbkNnTVlJTHRXUjBLOFlPdlhvbGgxWVJjMFc3V2pwOFNC?=
 =?utf-8?B?aVlPYlhnNzdXMXNrTnRrKy9Ya3EyY01FNExic3duMlpOaGZjWnZUZmdSTkpO?=
 =?utf-8?B?Sk1aOU5QeGZUTCtYL3llV3dMa1hWNlloM1J2ajRoMHo3aFVHME9UcTlqK2RU?=
 =?utf-8?B?TnNQUDdtVEt4NWV5ZU00M3ozVDdhSVVNT3NqMFh3K2YzTUhqNkVrZ3ZzRmtw?=
 =?utf-8?B?SmYvRWtvcXFGNVA3Y25KQ004eVVEbVpHZFZtZmkvRUF3MUpnTDJaZHE1UTlm?=
 =?utf-8?B?T1pYaHBkaVYvbGJCcFlnMklCT3FkWEJkQmFtbW9idE9yY1lSa04wcFU0bTFG?=
 =?utf-8?B?bnRiUGllRExlbWRCdlkvSHo3dExnVVNhMUVKbE5ic3luOWNsUUY3d0xjNHhL?=
 =?utf-8?B?OXhFWjhmYzFsTENPQmV3KzB2cHR0RVdVSjBFVTFjdXNIYkJCRnVzVVQ4SUlR?=
 =?utf-8?B?UVp5c0dHYy81SEpOVUI3TVJTYjJ5YlQzMmpqRnVIZ2dsUys4SS9TQ0haZk5a?=
 =?utf-8?B?NVhMVjdPTHEwb1VnaG14OXhMdnc4ajAzVkpPb29NVU5EZzlDRllKTlhIbzlL?=
 =?utf-8?B?U1FwdWRET0hUdCsyVWxnNTdSNlpCSnRRUUNBUCt3SU1hVU1QQlVRUDZzRG82?=
 =?utf-8?B?YWR0bHErQ2E3M21GZzJUK1Vuc1NySGRoYUxtRmlkcUJyUFhlV1lwNk1nSnZH?=
 =?utf-8?B?NkVLVTh6eFRXaHlubFY0QkRzeU1NakpjMStlb2p1bENZYk5BdFJYUXJwMDR1?=
 =?utf-8?B?enVNMkZyQ0hrYUc2T2czWmNIWURlMG02VWMwMHU3NGFIRG5QMklCOGZkRFZ6?=
 =?utf-8?B?ZEU4WUFibzgrWEVWbHVNRWY0aTRmU3NoemVjN2Q3ejc5T1ZqME1ZbzB1NWNP?=
 =?utf-8?B?eVA3WmZScGJUQ1ZTNkdhdlIxT2M4YStGZ3NJMXFXK2JwZTA1YVI4MlF2OUht?=
 =?utf-8?B?VUh5Q0ZnN21Nc01zQ3JkV3FqbXV5VlZZMWtrVHhzYWtnU1Y5V2RjUkdHRnRN?=
 =?utf-8?B?YUpudnVjdVROWkhxWWxhNTAxWloyZzVtSkhaZ0FNT3JHeWxUejV1dVdDT3VF?=
 =?utf-8?B?WUY1bGhvVG9KWHUvSlN1TUd4Qnl6MVAvR3BrMjNmQnExQWJXa1dXNk15dVNB?=
 =?utf-8?B?S2dwa2R4MmlkUjdyRU5XNVBPSjJ3ZW9oUHZSNTczMHN2a1JJNkdaQkZnMVAv?=
 =?utf-8?B?MFErMVd1di9LTkpHZWFqSlkyRHpRVVZFN0ZtQ28reVlQWEdNRGZSeHZkN2ky?=
 =?utf-8?B?endTVmtVZm5qbzBDTUdVeXFZYVVMQnlHRnR6elNtMWFtZUZTTnFiQUd6L2xk?=
 =?utf-8?Q?CJACqaK8+x8B7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVZSbWZMV0ZIZ0FSSVNwS2MwcHR5diswT05NQjVtTjdjeWJPcDN3aE16Rm92?=
 =?utf-8?B?VklNa2hQM090ZHJyQnFDaENiZjE4YWhsUWorNi9BUTg0RmN0UVNSME9lN0l1?=
 =?utf-8?B?UEVQK1FBMm1BTE1YNEt0Z1pzUUR1eWRkUmlvUTBPMTNJcWNLRDFtNGw3elBy?=
 =?utf-8?B?Z0ltWWpnUTUwQTJpOHd1ZzRSd1B0bmFSSFI4NXZlMkhzZU1mdzcxYTZTZ1NE?=
 =?utf-8?B?R2hHVWhiTXBXdUJOVFRTOXJLM1V5NEVUQlFvWnEvRUV0WEkwUzdGN292cGF3?=
 =?utf-8?B?UFFYb2xTdHRicXBWL0c0cXRCSGYxWEJSZ3BYTXloTWhjRVlFRUFjRjhraFkr?=
 =?utf-8?B?S0MycjhJQ0xaYStmZWt4ZHZ3VEZaY0t6UXF1MnFiNjhxdzNqQkZHcTgvTkw5?=
 =?utf-8?B?UVo5aEl3TkZlMVlvNWpQSzl5Y09GNnpPNUFTSW4xK3NjU3ZEOGdUS1JFVEpJ?=
 =?utf-8?B?MjRyYThiOGVRdHlmSGhGczhuRDJNTWVzbjM5eWRORmx1bW9jQ0xCKyt6KzN6?=
 =?utf-8?B?VG4rTmNrb1NiT2VNdEJzQ3dTRFdDRUlWTk9tcFZnMHMxL1AxVWZRZGo1Z1po?=
 =?utf-8?B?WnF3RWZQcDkzRkJmTHd2cDdVcDlXVGdyLzdBbDFDRnBFcHhGOVNoa25wY1lN?=
 =?utf-8?B?SFRpOEJDY1BFamJ6cHB4WVV3akYvTFc1WVpnbW5DU3VmbkJMSFg4ejJNSkFJ?=
 =?utf-8?B?T1Z4OHNUbWQrSUxPcCswNTR1VnhVRy91TWR0QkY2V0VJOFllTGJ5aFVoL1VV?=
 =?utf-8?B?MnUrRDM5T283emFZUWRKOEh1KzQyK3krdmRycERSOEU1TGhPUDNjUXpUblQ0?=
 =?utf-8?B?YjAzTTRUaXdZVkRZRFgzSzNzZzcwYnFwTUtPem42NUR3akZyRFJmdVYrcUx5?=
 =?utf-8?B?WHh6TnpQM1g3eVRNVXVqaU5SN0xpRnNSWnQrNWk1NlY0NDM2UXhkSjEvRnNC?=
 =?utf-8?B?cFdDNGZLcU9hdHFwOEVnSVRLUzNFdFZKanYzT3dmMlZBVFlXVURTSTkzL0s5?=
 =?utf-8?B?Mjk0RGwwYStNOTQwNU5YV2xDZ0w2VXNUSUs0a2RyQUFiZm5OVDF3MXVTT1Rh?=
 =?utf-8?B?M1JXZjlGWEJtdXBrQ0U2R2ZkNmF1WXFqUHJvWUREdlFMNnBFTk05TFh4VjFL?=
 =?utf-8?B?czR5bjFjZkp2Wjlpa01rSGVMQk1ZRWFKeGxOM2hXR0w4b3h6UVo1MEZKZ21i?=
 =?utf-8?B?KzY1VDF5WWx5eGdSdnA3OW9wT0J1TTQ2bGhKbjZ5clc1b3lHR1A0UEMzcm9m?=
 =?utf-8?B?UTVOOVljUllkTWFVWlh6aVZ6UERHalI4ZmVHenJtekd6WDErVUFlYU5zUEdm?=
 =?utf-8?B?Mkw3WHRMOEVqOTdUT1U0QmNTVlBUc0cxS3F6MHlXTkdDOVhLSFloY09MQzVG?=
 =?utf-8?B?eGRLV0FEbVRHT0tYSkZRdFVWeERMSFVYWXNmTzhkN2NJekdHZHkzVVkwNVZV?=
 =?utf-8?B?YjlpODcwU3ZFbklSZFdxU2RUVlFhK0w2Zk1yWmQrbEdnNS83V0RBa3pNR2hH?=
 =?utf-8?B?dVdjQTJ5NkRQMXh3N2hpRElCYXhLSWV4VCtkZnBSTjFyc1VzUk9OaktpNDM4?=
 =?utf-8?B?MTBDN3Bub0FVL3UxNVB6dW9zY2ZPaVlCOG14SGRXU2d1MllrekNzNmR4cWdH?=
 =?utf-8?B?VUNLNWNPcWcrVk1XaTJvY1RJYlZxcjRxdjA2U2sxNUlqUWxwMmRCemdic0My?=
 =?utf-8?B?em5iajhSS3d4VDZlQTM5TkEvN25PMEM5S2hBcEM5aUxnakdVUElQU0QzSHpJ?=
 =?utf-8?B?RGhuOUl3VTZnSXo3UDNaMGk1NTVxTjNkSlFtM0oxRnBQVjdsNHJyRUJUMVF5?=
 =?utf-8?B?TUxwZ1RJdVVNV1g5Smc0c3M0ZGpCYnBnbFBpcXB5OFo5ZnhIUmhkUU1lZDlP?=
 =?utf-8?B?c2E4SHNxcmRxN0l0STlUNUNHTnhNcnFPRXpWRXZUWmNBQU5nMUdJWGp1ekFE?=
 =?utf-8?B?Z1NST0haekZGUlk4dmFMVjBNL1ppWmZYeUh6dkxZYWhkZ0VsUG0vVzZqTmVR?=
 =?utf-8?B?eHRrb2lLeXY4RzJIekNNckszcWFPYWZBQ3ZFcUJsWDBYSWpEVkdTTHNSZ1pI?=
 =?utf-8?B?M3BoZTE0ejUrZFEyRldUQ0h6ekduZXBsK1pSRWRtNkNRKzVPNWUycHZYZnNy?=
 =?utf-8?Q?Ou0xuODhaIkHeynypqCwuS0VH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DyrwKLryHk6X9xKeLGnmLwIGcGMx5I9QZAsF7rXB/v2OTSrkefcKlXUl8DQ/C0cSbQ7ytebxrCkrhDx+L9m3CfYfsjhSRRqWIeMfZtXCwZYdJsn/r/5hzr/yT18iDETqXF5zy/9rWSvgQq16dlLWKQlFuYk3nx7KEc67uAxFfItHVCIp6VNmZcMU/EwSyVFgsao1I05Tgaen7Sgw1gdxDyu94YSrlSIV7i55QxC5cWNAdJOaELbQEdYq/rjir4Yjfs9P/1ueazGmjCn2lK/z1fw78jzN/zi0XUV9uMoH+BqFR3P+mMIW8PMVG1t0qvPsC6dwacjHWYbhW/HvjS6jypQocp3pupM5BV8dDlhP9fJZK9ZsoRELAit70yhVwf0FCyB2AaL5cG0oQ9qzR/B92I0e6VOueImT/E9hFdyNJwP+WuNJ6It0B1DFOKX1FVRqvHgonoVkZBJfWUZanePNOblVOUYoKg/p/uJ+inI0T4f3lMr+/Y3VMepn9BHMZ/IxFPZMSQlGt7PvLUTxpu/ZtUlyA7TRzUukJ31+KVU1Au3Kw+aGy2W/FTIDfLCG6NNlOsxsyq2fsfypGeyJY/xehDl2nCoO/Dn+UsnPov0ht8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3620ac20-b1c0-48ab-c8e5-08dd625f0d4f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:44:14.2708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noOtwl8VOpppzBTRGxwEOm/seyKxOKEPHNULEuRyuw/qZXMAZwpuwmaDKlc9ehtbcsvrWUA4JB+GeYD0caUmJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130143
X-Proofpoint-GUID: 8NryZNQ1yOrrTL_D9tuC4SACL6AhuhAt
X-Proofpoint-ORIG-GUID: 8NryZNQ1yOrrTL_D9tuC4SACL6AhuhAt

On 3/13/25 2:35 PM, Lucas via Bugspray Bot wrote:
> Lucas added an attachment on Kernel.org Bugzilla:
>=20
> Created attachment 307819
> NFS over RDMA - Watchdog detected hard LOCKUP on cpu
>=20
> Hi
>=20
> I am experiencing stability and performance issues when using NFS (kernel=
 6.13.6) over rdma protocol.
> All what I need to do to trigger the issue is connect client and start re=
ad / write operations.
>=20
> Fastest way to reproduce issue is by running fio job:
>=20
> fio --name=3Dtest --rw=3Drandwrite --bs=3D4k --filename=3D/mnt/nfs/test.i=
o --size=3D40G --direct=3D1 --numjobs=3D18 --iodepth=3D24 --exitall --group=
_reporting --ioengine=3Dlibaio --time_based --runtime=3D300
>=20
> Dmesg says: "watchdog: Watchdog detected hard LOCKUP on cpu "
>=20
> [  976.676922] watchdog: Watchdog detected hard LOCKUP on cpu 182
> [  976.676931] Modules linked in: xfs(E) brd(E) nft_chain_nat(E) xt_MASQU=
ERADE(E) nf_nat(E) nf_conntrack_netlink(E) xfrm_user(E) xfrm_algo(E) br_net=
filter(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) xt_recent(E) =
null_blk(E) nvme_fabrics(E) nvme(E) nvme_core(E) overlay(E) ip6t_REJECT(E) =
nf_reject_ipv6(E) xt_hl(E) ip6t_rt(E) ipt_REJECT(E) nf_reject_ipv4(E) xt_LO=
G(E) nf_log_syslog(E) xt_multiport(E) nft_limit(E) xt_limit(E) xt_addrtype(=
E) xt_tcpudp(E) xt_conntrack(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag=
_ipv4(E) nft_compat(E) nf_tables(E) binfmt_misc(E) nfnetlink(E) nls_iso8859=
_1(E) rpcrdma(E) amd_atl(E) intel_rapl_msr(E) intel_rapl_common(E) amd64_ed=
ac(E) edac_mce_amd(E) sunrpc(E) rdma_ucm(E) ib_iser(E) libiscsi(E) ipmi_ssi=
f(E) scsi_transport_iscsi(E) rdma_cm(E) ib_umad(E) kvm_amd(E) ib_ipoib(E) i=
w_cm(E) kvm(E) ib_cm(E) rapl(E) bridge(E) stp(E) llc(E) joydev(E) input_led=
s(E) ccp(E) ee1004(E) ptdma(E) k10temp(E) acpi_ipmi(E) ipmi_si(E) ipmi_devi=
ntf(E) ipmi_msghandler(E)
>   mac_hid(E) sch_fq_codel(E) bonding(E)
> [  976.677035]  efi_pstore(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E=
) blake2b_generic(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy=
(E) async_pq(E) async_xor(E) async_tx(E) xor(E) raid6_pq(E) libcrc32c(E) ra=
id1(E) raid0(E) mlx5_ib(E) ib_uverbs(E) ib_core(E) ast(E) drm_client_lib(E)=
 drm_shmem_helper(E) hid_generic(E) mlx5_core(E) mpt3sas(E) rndis_host(E) i=
gb(E) raid_class(E) drm_kms_helper(E) usbhid(E) cdc_ether(E) dca(E) mlxfw(E=
) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E)=
 ghash_clmulni_intel(E) sha512_ssse3(E) sha256_ssse3(E) sha1_ssse3(E) usbne=
t(E) psample(E) i2c_algo_bit(E) scsi_transport_sas(E) ahci(E) drm(E) mii(E)=
 hid(E) libahci(E) i2c_piix4(E) tls(E) i2c_smbus(E) pci_hyperv_intf(E) aesn=
i_intel(E) crypto_simd(E) cryptd(E)
> [  976.677112] CPU: 182 UID: 0 PID: 20143 Comm: nfsd Kdump: loaded Tainte=
d: G            E      6.13.6+ #1
> [  976.677118] Tainted: [E]=3DUNSIGNED_MODULE
> [  976.677120] Hardware name: Supermicro AS -4124GS-TNR/H12DSG-O-CPU, BIO=
S 2.8 01/26/2024
> [  976.677123] RIP: 0010:native_queued_spin_lock_slowpath+0x244/0x320
> [  976.677138] Code: ff ff 41 83 c6 01 41 c1 e5 10 41 c1 e6 12 45 09 ee 4=
4 89 f0 c1 e8 10 66 41 87 44 24 02 89 c2 c1 e2 10 75 5f 31 d2 eb 02 f3 90 <=
41> 8b 04 24 66 85 c0 75 f5 89 c1 66 31 c9 44 39 f1 0f 84 97 00 00
> [  976.677141] RSP: 0018:ffffa16f2de8b948 EFLAGS: 00000002
> [  976.677145] RAX: 0000000001d00001 RBX: ffff8bfa8e937bc0 RCX: 000000000=
0000001
> [  976.677147] RDX: ffff8bfa8bd37bc0 RSI: 0000000003340000 RDI: ffff8bfb9=
fffbe08
> [  976.677149] RBP: ffffa16f2de8b970 R08: 0000000000000000 R09: 000000000=
0000000
> [  976.677151] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8bfb9=
fffbe08
> [  976.677153] R13: ffff8c3a8e037bc0 R14: 0000000002dc0000 R15: 000000000=
00000cc
> [  976.677155] FS:  0000000000000000(0000) GS:ffff8bfa8e900000(0000) knlG=
S:0000000000000000
> [  976.677158] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  976.677160] CR2: 00007fb9b1da66b0 CR3: 00000003e84bc000 CR4: 000000000=
0350ef0
> [  976.677162] Call Trace:
> [  976.677166]  <NMI>
> [  976.677172]  ? show_regs+0x71/0x90
> [  976.677182]  ? watchdog_hardlockup_check+0x1ac/0x380
> [  976.677189]  ? srso_return_thunk+0x5/0x5f
> [  976.677194]  ? watchdog_overflow_callback+0x69/0x80
> [  976.677198]  ? __perf_event_overflow+0x153/0x450
> [  976.677206]  ? srso_return_thunk+0x5/0x5f
> [  976.677211]  ? perf_event_overflow+0x19/0x30
> [  976.677215]  ? x86_pmu_handle_irq+0x189/0x210
> [  976.677225]  ? srso_return_thunk+0x5/0x5f
> [  976.677228]  ? flush_tlb_one_kernel+0xe/0x40
> [  976.677234]  ? srso_return_thunk+0x5/0x5f
> [  976.677237]  ? set_pte_vaddr_p4d+0x58/0x80
> [  976.677244]  ? srso_return_thunk+0x5/0x5f
> [  976.677247]  ? set_pte_vaddr+0x89/0xc0
> [  976.677250]  ? cc_platform_has+0x30/0x40
> [  976.677256]  ? srso_return_thunk+0x5/0x5f
> [  976.677259]  ? native_set_fixmap+0x6b/0xa0
> [  976.677262]  ? srso_return_thunk+0x5/0x5f
> [  976.677265]  ? ghes_copy_tofrom_phys+0x7c/0x130
> [  976.677274]  ? srso_return_thunk+0x5/0x5f
> [  976.677277]  ? __ghes_peek_estatus.isra.0+0x4e/0xd0
> [  976.677282]  ? amd_pmu_handle_irq+0x48/0xc0
> [  976.677287]  ? perf_event_nmi_handler+0x2d/0x60
> [  976.677290]  ? nmi_handle+0x67/0x190
> [  976.677295]  ? default_do_nmi+0x45/0x150
> [  976.677301]  ? exc_nmi+0x13e/0x1e0
> [  976.677304]  ? end_repeat_nmi+0xf/0x53
> [  976.677313]  ? native_queued_spin_lock_slowpath+0x244/0x320
> [  976.677317]  ? native_queued_spin_lock_slowpath+0x244/0x320
> [  976.677322]  ? native_queued_spin_lock_slowpath+0x244/0x320
> [  976.677325]  </NMI>
> [  976.677326]  <TASK>
> [  976.677329]  _raw_spin_lock_irqsave+0x5c/0x80
> [  976.677334]  alloc_iova+0x92/0x290
> [  976.677341]  ? current_time+0x2d/0x120
> [  976.677348]  alloc_iova_fast+0x1fb/0x400
> [  976.677351]  ? srso_return_thunk+0x5/0x5f
> [  976.677354]  ? touch_atime+0x1f/0x110
> [  976.677360]  iommu_dma_alloc_iova+0xa2/0x190
> [  976.677365]  iommu_dma_map_sg+0x447/0x4e0

I'm assuming you have IOMMU enabled on the boot command line.

Can you share your hardware configuration and RDMA NIC?


> [  976.677373]  __dma_map_sg_attrs+0x139/0x1b0
> [  976.677380]  dma_map_sgtable+0x21/0x50

So, here (and above) is where we leave the NFS server and venture into
the IOMMU layer. Adding the I/O folks for additional eyes.

Can you give us the output of:

  $ scripts/faddr2line drivers/iommu/iova.o alloc_iova+0x92

Should look something like:

alloc_iova+0x92/0x1d0:
__get_cached_rbnode at
/home/cel/src/linux/server-development/drivers/iommu/iova.c:68
(inlined by) __alloc_and_insert_iova_range at
/home/cel/src/linux/server-development/drivers/iommu/iova.c:184
(inlined by) alloc_iova at
/home/cel/src/linux/server-development/drivers/iommu/iova.c:263


> [  976.677386]  rdma_rw_ctx_init+0x6c/0x820 [ib_core]
> [  976.677525]  ? common_perm_cond+0x4d/0x210
> [  976.677532]  ? srso_return_thunk+0x5/0x5f
> [  976.677538]  ? xfs_vn_getattr+0xe2/0x3c0 [xfs]
> [  976.677700]  svc_rdma_rw_ctx_init+0x49/0xf0 [rpcrdma]
> [  976.677725]  svc_rdma_build_writes+0xa5/0x210 [rpcrdma]
> [  976.677746]  ? __pfx_svc_rdma_pagelist_to_sg+0x10/0x10 [rpcrdma]
> [  976.677767]  ? svc_rdma_send_write_list+0xf4/0x290 [rpcrdma]
> [  976.677790]  svc_rdma_xb_write+0x7d/0xb0 [rpcrdma]
> [  976.677811]  svc_rdma_send_write_list+0x144/0x290 [rpcrdma]
> [  976.677834]  ? nfsd_cache_update+0x57/0x2c0 [nfsd]
> [  976.677889]  svc_rdma_sendto+0x99/0x510 [rpcrdma]
> [  976.677912]  ? svcauth_unix_release+0x1e/0x80 [sunrpc]
> [  976.677968]  svc_send+0x49/0x140 [sunrpc]
> [  976.678013]  svc_process+0x166/0x200 [sunrpc]
> [  976.678058]  svc_recv+0x8a1/0xaa0 [sunrpc]
> [  976.678101]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> [  976.678144]  nfsd+0xa7/0x110 [nfsd]
> [  976.678183]  kthread+0xe4/0x120
> [  976.678188]  ? __pfx_kthread+0x10/0x10
> [  976.678192]  ret_from_fork+0x46/0x70
> [  976.678197]  ? __pfx_kthread+0x10/0x10
> [  976.678200]  ret_from_fork_asm+0x1a/0x30
> [  976.678210]  </TASK>
>=20
>=20
>=20
> Full log attached.
>=20
> File: dmesg-6.13.6.log (text/plain)
> Size: 407.10 KiB
> Link: https://bugzilla.kernel.org/attachment.cgi?id=3D307819
> ---
> NFS over RDMA - Watchdog detected hard LOCKUP on cpu
>=20
> You can reply to this message to join the discussion.


--=20
Chuck Lever

