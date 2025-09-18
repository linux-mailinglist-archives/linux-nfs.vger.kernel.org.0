Return-Path: <linux-nfs+bounces-14578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFB3B8697B
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 20:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73375852CC
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 18:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8802192E3;
	Thu, 18 Sep 2025 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q5F9EOBS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xcj/jeSZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254C3C465
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221779; cv=fail; b=ZoVMTBHiQFJDlphh6kc1yQsfJIejutOlzdX1QwjiJLOpBGzjDHYtDBsR69yHJ+0JLQ2KnbIK2ha9d8dDpYtQQ8qUB8uN1UW2H5NdV5UYxgPNAFHAAO5yk/6mJQqlrTQEQPR42R07YlZ+OmqLc2w1nO5eauJFIiUIFYBLnOPyVbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221779; c=relaxed/simple;
	bh=ISJr49LUMLGKheLtSV5WBWwz6Jm1T8C5FUOOnHdksso=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mUZAp4LAi/A1ghYZ2S8Yz3tFfPAe+IN+zqQbYIUMWWK6oKhWF+9dqlxRe8/B+p+xYA6n/4BiO027NQmOK4yRk4cEMF9T/n7WflQTRVgvwbm9V+NikSIkjT1uAn2+wzbw4zlc0KganN5OjfGdEbDtvoKizehx6RDm2nwdBsKdssI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q5F9EOBS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xcj/jeSZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGKXbG029851;
	Thu, 18 Sep 2025 18:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tkkvx2fxEv9b6sLu9tajyRSnyxYiJV2enVEdn8GaKsw=; b=
	Q5F9EOBSL1fUb7uLQ92y769oEwr3mTDMoo8GE2E4XMZt49+NjwyynVPu7PLghJjX
	Zey8zsv2J0vCqaEyQp7ex6JS6xjL/eer/d9C76TPdPTYfdVGvRGkz6SBumd/d8pD
	MfDRJUFPUWqAoNo0hhCZT4TyMfTqKk0dvSS5qdYw8h9yqNKJJ8bKqav61jcxtxx0
	2RVJeLD5y0V8hMyZ6QBQTArjiz761+5f2DOPjQ6kgoMI+B6hyFia1zC716jbQAfT
	iZjqg6+nn6bNNGTrpSPYt+qzAxrvQw4FvdS/UawhQMRATOz+rkJKWru4y367OyCB
	ckzXjnWSWHHaTC/bp+WufA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx8m1qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 18:56:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IImZe9033703;
	Thu, 18 Sep 2025 18:56:07 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2fh4x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 18:56:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhSZ+wwJklvIWqE2R1raEVQntjJ6FTbw9+Wf71iSXWD/W+hm6fcOt4N8+ma0qA14uXnN9QbLQ0jxZ4j5LP3/+iESxwNIMdnhgqKV9EW3gn7Yvg/HGByw769ePbU1RFgRWj3VOl/AeVpdEQIS8w/lztWaz6YtJ/UhRVOS3kvhlbNwF/FSG00Hk18/T8UkziiHPJk01rm1goxv4c6liqoMBBbxECz1JwxAl85FZcpiP5jjbtOUW0TmqkjJU27iOEL2FEucmiVWc8izOSQVI26ldbE5nuUE1eTBPZM/6BOE2QhnlskVkcSIemztStBNuc1uYt4XquthjAsZKu6sZuuyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkkvx2fxEv9b6sLu9tajyRSnyxYiJV2enVEdn8GaKsw=;
 b=FzsVKqzrvpVudxG+H+61e+3UnSTQ6rxcBraoX5v1fSwXiXdow9vba0lpmbm8xQ92GllZiwR8BeFhOSTGYod113Ds8ERzpMn3R+ZFmPvIAHnshOSQbaSfYC/KqHf5rbGTpqkAq3tAxlHH4SqE/gpAm1dB7kCVTXcRPQgRtwD/nAkNEGGanl7lyU49YnJsv8p/lZJPw6Q/UUMvRfoe4kQqZ2Pmtv+sqi/hihYlVpHAJnDTtNKQgIao++up+IjFkftPDfLFEK16ZNSvN4ayai5LkolgYe9NjY9v2OnaPnm/oqZzAYNz1aZ1kbpI+J3JDKhaJe2NRtjT8xVi+xwjmbhSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkkvx2fxEv9b6sLu9tajyRSnyxYiJV2enVEdn8GaKsw=;
 b=Xcj/jeSZtFhGnmo2BpGFOlo3R7SCZ0Q2h37sLIeuu7ygVFQdW2Hi5OXrK2X92JO/L8VBo38uXNqQaAAkiveUbeohv5kitsLCgWeo7XC9TSUyFa8IwB/5SQAQKs1kSi8yv/IbFt6q2NjB+hjJb9+wu/q4TQEMzFJXs5BcAMFkuOw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7744.namprd10.prod.outlook.com (2603:10b6:610:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 18:56:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 18:56:05 +0000
Message-ID: <1f740990-edac-4c41-9572-4397c138e0f3@oracle.com>
Date: Thu, 18 Sep 2025 11:55:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/7] nfs/localio: avoid issuing misaligned IO using
 O_DIRECT
To: Anna Schumaker <anna.schumaker@oracle.com>,
        Mike Snitzer <snitzer@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org
References: <20250917181843.33865-1-snitzer@kernel.org>
 <20250917181843.33865-3-snitzer@kernel.org>
 <404a4c49-9e16-46d1-8901-f7a8a6a9701b@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <404a4c49-9e16-46d1-8901-f7a8a6a9701b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0199.namprd05.prod.outlook.com
 (2603:10b6:a03:330::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 4439cde7-2315-4df2-58d2-08ddf6e50513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjdzNjJIUXBSb0tWU0I3bDJzbFA3VlJCS3Rjd1dtSTE0RTUvZDloL2tJajM2?=
 =?utf-8?B?SVRrWlVGbjdCaVBHUnhGRjlsSEZKSW55RXp1YlV2OUg3bnlLendtVmZvcmlM?=
 =?utf-8?B?Ny9Cbm9HMnptdzhjUkZrV2hvTFluOTQwNUNNUlFqdzFLSmJhMDZ6ajlqYnln?=
 =?utf-8?B?R1FkRUlUcmpsWmhFL2owODNaNC9IZHk1RHpsRGRQT2s3Ly81S3ZjK1V1cVND?=
 =?utf-8?B?dVB4WklvNUxHQUM1SHIrWHBPd2x2RWtzbXdac2ozby9DZGJLYXFOcFFBVm9X?=
 =?utf-8?B?MVp4NmIzbW9MaEk2amhmYUwvWDdYeTZpcnd1TWxHWXk3d2lvaDRtV3h4clJI?=
 =?utf-8?B?Ti9aR1Rlay9NMXZZa2kvM1liNHVKeXlPK004RzBCWmVSbUJnZFlCU3VXWG9B?=
 =?utf-8?B?NjNoZlZRTjVtdkJxNmRFL05ZV2ZvS0tXSThRZVVZeWpaMWdKQnA0c29TN0Ew?=
 =?utf-8?B?TGJvaFpnOGN4L0JQbVN5amkvVGxlSVpUaGE5WHRnVkthRVMxczJFZVFNaHlT?=
 =?utf-8?B?aSswUjJrTjI5V2c0bkJtT2RtZ3Y0Qm43Z2N2TlBOc0J0KytsYTh4by9wQUha?=
 =?utf-8?B?QVcvVDRoblBhcWhDakNhcmFzVzJHNTZkNGwrTTV4STc0UnVuVUFPY2psV0lp?=
 =?utf-8?B?dk1NaWxSR29aTVpJaWJuUVdhM1RTMlV1WURUS252K0lPY1ovNmNNM1E3TnZJ?=
 =?utf-8?B?amlHY29VOVZIMmV5UWF2VG5HUW1aTmcvK0pSSVE0bHhBNnY4WkxNRDFjK0g4?=
 =?utf-8?B?TEZCQ1hLeG1samFJL0xMbFpMK25pL3o4SUtoYkRKcC9JVmVnSXp1N2E1NXBX?=
 =?utf-8?B?aFp1Q09ZbW9XQU1BKzluNDc3M05tNkdQY1k5dDFSTGhpcTRDTHd4TUVIWXJD?=
 =?utf-8?B?aUZxNTExbmNpcGRXQUxrUFRTcUVhQjZIWU1IZ0xDc0dQb0owajNrb1RwN1Iz?=
 =?utf-8?B?T29odGdNaUpJNFJ3R2dacm9RclgwTVhNVVdXMkRFMUtSUTBLYTBFMnNTQ1pk?=
 =?utf-8?B?REIzK0NqYW1BbExMSlBmeTBURGNROW1naTVIY0tiTDc0ck5Za1BjV3FLNGsz?=
 =?utf-8?B?OEswZEcvUUFBeFU3S0dRSzBNTVM2V3UrYlNYdlI4dzZYREQzSWo3MklNMzQr?=
 =?utf-8?B?RkU1Mk1qWk4vN1h1UjZMY0pQQ050MlBNbWhwWnpjRWJwcXVtb0h6VGdjQVMy?=
 =?utf-8?B?RUo3cFBLZHc4VDdZRGJqNEx5Qll3d2Q1SFJDL0Ixc09aTm53Q2lPdVphQmMz?=
 =?utf-8?B?anlYS3oxakhvb3JXbER1VFFEdm9aeFJYUUtKTGJQVjhiSmlhVElQOFJiaEFI?=
 =?utf-8?B?c0dBSlVUWVp1NE5xSk1IQmNPLzl2SXF5bG5xV2hMU2k3eVFUOWpPQkJVck9z?=
 =?utf-8?B?QUNZdGdGc29NaHorbU1CbUxLb1NVaU5DSE5MR1NhNzBrRGUyU1BZaEVMZEN4?=
 =?utf-8?B?VENnUTVqUEtlY1dzaXBuSTVGYnhodkJqVlIxaHNMYmhFc2tqTWVhK0lVc2JC?=
 =?utf-8?B?VjNLY2JVRVF4bTZqNW1UZ2crWFlrQy9qWFoveVVqY0pGalgvYU5hYi81QzZq?=
 =?utf-8?B?dUdRaWxBM3FpQlJ3R0p1YjRSNG5jdmZmTlo2dk9DZ2FhQVFva0MrK3h0Z0hS?=
 =?utf-8?B?NjZVVUU3SlhGbGxJNVJjWjhLSFdWb0ZwSERIYTFHT2Qxb1JtR1p1WGFjSHJS?=
 =?utf-8?B?a1JKenpkQmNseVpsRTc2V0Zmd3RFdU9ualJTTkVlWTlDZzRKYmU3TitZYnNv?=
 =?utf-8?B?dzltUVBiNmJrN0p0N2ViL2NvaG1ibTVCczQ1Q1Y3S1ZyVHFGbVBrNmV2Zlp5?=
 =?utf-8?Q?Bmhwrm4aEUWBs92zgf9W9T7OQ/pyOs0IR4Mug=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWFFR3kzUXBNeXZ3S0RYcjhGMDdlT2lYb0VQd2FkUUo5L0V5anN4UFRCbnBI?=
 =?utf-8?B?cEhjSld4Tm5XZmtQMjM5Nnp5K1R1ZmJOZHlrNWRJa0FmNUlxNm82TFZOT2x0?=
 =?utf-8?B?Vkk5N2JxakdVUWV4MXZnOUZjaVVsWlpwSzMzdUttM3JXY3NTb3l3OWNhdEg3?=
 =?utf-8?B?Tkx5QUxFRDdlUVZ1a0J6SlJJUkJ5Q3E0S2JxZXhZWUY2dWJ6Q1Vpd3FPNEJZ?=
 =?utf-8?B?T1ZXZWFUbS9DY08vWmZaRnNxRDlTZkN2WUhGaURlVFdaNEswK0wrWWJkbHlS?=
 =?utf-8?B?RGxvbDNOWmIrLzBSUlZVb3VrTTJqS2ZhSXByYkdTblh1S3JYQ09jS1JlRWFD?=
 =?utf-8?B?dkZmdDZpbnRSMm5WUlBTNG1RRFphaW9DNUozWmlMSHNrTmpHNlZaMEp0K0pS?=
 =?utf-8?B?cGNCRm93Wk9qcmJ4dDE3UEpOclBHWEVKcjJHNE5KMlVuNnRxWnlrZ1k0RFNZ?=
 =?utf-8?B?cVF5S2ZMWmFTWmlKSGErdnRyV1ZQelJvREJnOTJYd0hrMEVvaXpEVk0yenNj?=
 =?utf-8?B?YmJKZ1RpUXluZGJFOGlndzhVcDNMS2tkdHY3VDk2MXZQNDVKY2JpYmhBV3Jo?=
 =?utf-8?B?cTU4K1NCQ0JSNEhpWEtyaG84bU9YeXdYa0lGWDRXL1IyR2FhVDRIb0RwNkoy?=
 =?utf-8?B?aGU4Z2kyT3hQbkpyR3BzNlZkYVJ4THV1VjNXNnByRGt1cXl1MmVhemtoZHc4?=
 =?utf-8?B?L202ejFyMmpxbml3SDcxVDh5VDdobytmUm9rcnU1ZXZDSzIxZGsybUhjQjJC?=
 =?utf-8?B?bGw5OTRoSVV6ZkdiWUhabEEzMElvS2hwc1lvNTg5VWRJNGVhTEc0cGo5UDRC?=
 =?utf-8?B?SGVuSU9QNFozUTlOUlNJci9pNjYxYS9LSnNwYW4ybXoza0hsVnB4ZU45UWFr?=
 =?utf-8?B?czBLK0RabEMvNm1Dc2lDc0QvblByYlhhWHNGV0JZN0JyTzdpMmtWZStZRHB6?=
 =?utf-8?B?YkxjQlZJS0NzSFF2ZUg4a2NZc1FwWW9QbTFBRk1IRkNzUG4vL25mLzcvYTN6?=
 =?utf-8?B?aWxwUHZnQ1dySmlud0VWci9qYk9EVk9aL0xFTHFSL09qU1BENnFvZWdaRXVs?=
 =?utf-8?B?UDh4WlZFZG44Wk10KzhlNm1IeGF0T1U3MTFORjJKbUk0bk1aRWk0N1o1SFBl?=
 =?utf-8?B?eC84Mnl6ZGIwbWdvMUM4Sk8vZ1VPQ1ZJd2gvckxsRFBxSDI5UFhYUGZ5OXA2?=
 =?utf-8?B?eU1IOWFxUUdHUHJ4TUVjSFFGOTNDN0xNVTVVaDZmVytJYUwzRndCaHJmLzVk?=
 =?utf-8?B?emEvOEdYcHJuN0ppT1lnak1nQmlnSFdNWm9oU3B0cGxNSWFQTjJ1RnFBMXNS?=
 =?utf-8?B?eHJibEtGUDhiU1dIcVY2b3JrK2F4RXFpdGNXQWJmcjhZQlNvL29QNE5ybFBZ?=
 =?utf-8?B?MmRBOXl2ek9VdFA2aDhWRGhvTThtbGROUXdWSEhOeWg5SXRrL2lZbCtVYWwy?=
 =?utf-8?B?b1FDSWxMSW1NbGhWWUJVRy9kTlhYL1Bma1pOcG9CUk9TU3FmQXQxa3ZYMnhQ?=
 =?utf-8?B?Z0JtRlc4YUYyZ25vSC9sM1JaN3ZTMDJCaFIySStqelcrODUrZHhDRFNUMkE3?=
 =?utf-8?B?NDRjbmFOaFJvaUdWM0luQ3d5aUhTeENHY2dPNUtVRnMxcTkzQ3pKSUx6Q2RB?=
 =?utf-8?B?QnRObmhzUE5Wd3A5NUlsb0tkSW5ZMXIyNDMyeTdIaVRWcjNuVlN3ZTVIby9w?=
 =?utf-8?B?VE1xV0xFR1hDUC92dGtrQ0JyZlFxb2dmbnhPWlhEWGVINlh3dFFiN0dSOGlq?=
 =?utf-8?B?MHBKQ1Nmdk5MMUdGL0tBeFJKN0RPYmdKMnJLQzVGVCtPRUNleUJRYTNyTFJo?=
 =?utf-8?B?NlVVMEZyTWxnejlwTlg1NDQ4Y1c3bkd5SHhTRUpkbjhHV3ZBbVV5R2xVdVhs?=
 =?utf-8?B?a0J1NjJ1QmRSNGx3SmJaSHRSOGhLTG9ncEJ6bGkwQWZGcEwrVEdteThXKzlQ?=
 =?utf-8?B?eU9EUnZGbWtIMGxzN3pGVi9lb1VNNUpvaythSmZ1WmZuOWg5RVE1RlEwN0dR?=
 =?utf-8?B?OWFiOFRDVnYrVk9pVy9zT1ZYUkVhWHRaeUxjVVdXdjU2N3dESFpQYlgrOU1N?=
 =?utf-8?B?cW5sc0ozWFJZSWlRUWEwL09xcWc5djhuQmFxNFkzU2wydFNRRjNSMnM3T0Fz?=
 =?utf-8?B?eDdaektjV0MveUxlYlV5ZFNPcGZWOHNjOHBQTXhkcm1oU3hHUk00amFVUWl6?=
 =?utf-8?B?Mkc0MzB4aEtMdGFhWUUwNnBjNEh3ajB2NUlLejk2aDlwNzFqK3htUGNOMkRZ?=
 =?utf-8?B?c0U2UjRJK0tRL0hwQjg2cUtTaGR3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BT9eHs9ahJIEtINylRPamtmRTZbLsQb4V4wJhB7kXlWqhgmo5iL/HFUsJbuRrukieAu4bNLLzwg/JkI4aj9qVqJZGgbGrV0H9MM6Ui6Hh105tQHV05Y9+ir3WDti86kOZgu2xYvhOp37sz36SJZkcN7HfS21vhxtWYvgubvHepqTx9080A0l4T6e8rX84d2zX42MVBIykJN4qLoWkAAqHxth2sBOLEFSjH34Lf9yx9ac0iGxsEZ3sxbpkZxa3yKksXYCpiIubCF4HDRCee6bIws12LJJHMZo0O8o1m3VeCbQT0JAMaqKEOqeKPCx86yWMMb7MuQUT750A/OyEppqqzfqZE5uXOD7DPgrudOupIg6BwVGn44IE8UwS+N76Qxcb0oG1XQs2YEYO6XcCNYD4sonq0ANoNf8G5iGdka+7G+Non3HuwWJAjDc3O21C315MqUtqEdCmK7Gt6EY/wUlpxbr4NqMSOQ1effT2Y7aiezyLtPaTOUJxcQGXySQchSFLb5MPJGAsjx8fBJ0ktSXPKcAby/3RJRSojLhsaNlxIycu0k65kFml1MOd1uwMfTMSBvMYdzZ6YLX0awZH1qpK8QBpkx3DhVzRMMCnFrbsfU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4439cde7-2315-4df2-58d2-08ddf6e50513
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 18:56:05.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfpRz70gkYLp8sPZXwyPF3S1lxJqTvt2g7Ew9GPVe65OdiudiWoEdZ88zoMczekRm0g/zdevgOZXfuQ0BeObxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180168
X-Authority-Analysis: v=2.4 cv=JNU7s9Kb c=1 sm=1 tr=0 ts=68cc55c8 b=1 cx=c_pps
 p=sXVJkoLBAAAA:8 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=H8x_XAZoVeySfZP9s-cA:9 a=o6swlW+DH2mjwupe7J+dRiw8Iko=:19 a=QEXdDO2ut3YA:10
 a=1v-fjV8wc49bR92hP86t:22
X-Proofpoint-ORIG-GUID: lA0mP2BSir1MIoXh-Pxfp9fEvh-T_liO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX28yK2NKcbF46
 6dNjrUqYFC4Pby/XvMruZ6qxZEXbK0eMHvuiUKGMc0vTEWzDunGVWxflh39HL/V9B5yZyvuYad/
 fMQXm8cQvcuFXt40sVovkpjSztwfqMxDszTy1RFCbioElO4AuCIkVMtSEzZ8mviyhlLnGozcvvA
 CmMKNPCk7hGB/SlFxjOJswkMTfG2HrLparGc0FrXktDEoc7Bksvo76Nt7m51TQxqOtWPDSVPtOy
 11L6MoPHkmtbdY3s+kah/+C3bwhbmPNuJNsxDpvr1YFwMnv36qS0LaWQ4sm4ht1MVJQDBnzAfOk
 KaMFXKNerRvZeOfRjTZM2jX77fBjN9GeZWY6qE6mqKiwaXNpL63kkudKayJ91NhBMkO41xqoAIg
 bnimdLIs
X-Proofpoint-GUID: lA0mP2BSir1MIoXh-Pxfp9fEvh-T_liO

On 9/18/25 10:15 AM, Anna Schumaker wrote:
>> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
>> index 269fa9391dc46..be710d809a3ba 100644
>> --- a/fs/nfsd/localio.c
>> +++ b/fs/nfsd/localio.c
> I'll need an acked-by from Chuck or Jeff for the NFSD portions of this patch.

Doesn't this series need

https://lore.kernel.org/linux-nfs/175811950708.19474.3966708920934397510.stgit@91.116.238.104.host.secureserver.net/T/#u

as a prerequisite?


> Thanks,
> Anna
> 
>> @@ -117,12 +117,23 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
>>  	return localio;
>>  }
>>  
>> +static void nfsd_file_dio_alignment(struct nfsd_file *nf,
>> +				    u32 *nf_dio_mem_align,
>> +				    u32 *nf_dio_offset_align,
>> +				    u32 *nf_dio_read_offset_align)
>> +{
>> +	*nf_dio_mem_align = nf->nf_dio_mem_align;
>> +	*nf_dio_offset_align = nf->nf_dio_offset_align;
>> +	*nf_dio_read_offset_align = nf->nf_dio_read_offset_align;
>> +}
>> +
>>  static const struct nfsd_localio_operations nfsd_localio_ops = {
>>  	.nfsd_net_try_get  = nfsd_net_try_get,
>>  	.nfsd_net_put  = nfsd_net_put,
>>  	.nfsd_open_local_fh = nfsd_open_local_fh,
>>  	.nfsd_file_put_local = nfsd_file_put_local,
>>  	.nfsd_file_file = nfsd_file_file,
>> +	.nfsd_file_dio_alignment = nfsd_file_dio_alignment,
>>  };
>>  
>>  void nfsd_localio_ops_init(void)
>> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
>> index 59ea90bd136b6..3d91043254e64 100644
>> --- a/include/linux/nfslocalio.h
>> +++ b/include/linux/nfslocalio.h
>> @@ -64,6 +64,8 @@ struct nfsd_localio_operations {
>>  						const fmode_t);
>>  	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
>>  	struct file *(*nfsd_file_file)(struct nfsd_file *);
>> +	void (*nfsd_file_dio_alignment)(struct nfsd_file *,
>> +					u32 *, u32 *, u32 *);
>>  } ____cacheline_aligned;
>>  
>>  extern void nfsd_localio_ops_init(void);

For the above hunks:

Acked-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

