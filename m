Return-Path: <linux-nfs+bounces-11193-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BB0A94538
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 21:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165101899E42
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 19:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D871DD866;
	Sat, 19 Apr 2025 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lAZELPvn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AgkV17hE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793011CEEB2
	for <linux-nfs@vger.kernel.org>; Sat, 19 Apr 2025 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745089838; cv=fail; b=NlCEKyS6dL+IodhXcZYmkF/uiU/sxiN4aQQDD7nMgtYniwBEGfZUH0boAhx8YNDX9kjwRFlsUgouMu/nGInkLCE1GbAGepKvENJFwlFGGlbx2R0mJM0XLTf0Ql7fT8MKnKA9CVIEEa286rzJNzT50DC33evgWmfC2AV0rW3PZY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745089838; c=relaxed/simple;
	bh=Ueha+zfLDMnEccNdw/xCeX1fI1e6E5uJKRW2aCMnW8M=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=bwTKGcp3PhN6ehhpSP3NNLc7M1JRrtg3gkeJudfG4OrmtbyVMWbffmWBUYYh2SVT1tMpp8T5/WRksN26DT3GIFDQjxTIvA5+92QJ6c6sNsp5auo1HVhUM5HBOykgzsM+QsuPM47f6Fjier0F9EnpqfyQ4ITSORbjdSPtMa/nQXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lAZELPvn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AgkV17hE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JFFBOY023334;
	Sat, 19 Apr 2025 19:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=qfVJPOn3sXjYLy3t
	e3f3TlXEyXW1ReLmQamAGrRCnk4=; b=lAZELPvnBnShXrOONBoc8uMIS3ssZtgW
	gb9FM+hriTvBz4wK3xPH74IlEgH9ZEV57PEIV97rJvuFoViFqtfg+aHNUIPYvQXW
	/cghG7K116v5NfLGZe6tMvwcnYgNjsAYYC0T4AkyQPxhwRzJeoikeQ+tRikUkb/g
	mD2Cbpev8HX8WKsUzbsd0Swsnn/eb6wDfRO8yYTW1PjVsGAE9TowokaF7pelEpzS
	z9ZSpbHJJQIfMKBxSB3iZURdNnZY99ob2LZpDtkQPNiNyfy3DPF5rvbyzu6WP8Tk
	pXg7q1vLikQiYvV1kGD4LHa8vuco/ajeioeek6hFkCdbpSxFti/DmA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642m1rhkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 19:10:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53JHUa7B005884;
	Sat, 19 Apr 2025 19:10:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 464296xxv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 19:10:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLghO+p5pNC1bEPIbkc6jL+3sMHfdtDv9Rc7mgzYHmU+hPaXnWwcnhWmKVmt5DlLPpLqTC1k6a8RgQCdBbdQLjJhyWlyw3yRzc8zYf7VWRCzzQ2wWiBhEpo8V3PQ4cXNEuAiE6luVVOHfLVLBNfoKfOUqUR34/HC2gt+7ZBYqWMZsetSvvnHBZs9VSW6DXKgrIgkNDDHtX3hLV0oZMW/AxzH9yJLB5aZNg9pjQ1igMbhZtIbrzqaXtMIdIyScc6Rvr4Qnu7U5svdgNGy8UyBr8XCiehf3qYf7NRBtkKp1bohyeybRBhnjHm3jzfQqO8Dlkl9ygjtpWm+pjKpI4As5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfVJPOn3sXjYLy3te3f3TlXEyXW1ReLmQamAGrRCnk4=;
 b=Li/SkyLuwHL41MNB2wQFUeQwK47b7GU2iIJXd4rS3dt2DHoWgNBO/taRLSeMER9QsYKmSkQpF27j9HHYDSkIDz51+OPsc6Q27PnQMN93AJzVbPD1FUAhqt0yJVphPZS+UOOisjI6hpaFWksKE4FQs7rvoTuyMzc+GPXN84c7g6f0jhELTy4ky2LfyHNmPUPgT3wiAv+Ccl9uJrJKoWw4iM/fxnMn/XcwobDn+pZr8sAejEq9fEs3XGgkkJtCHLu9bc7u3QV8rUHvpjO9NPmfA8tHNy3Et3j/79S7l/9KjNOf1LpAEd4OfoedZauxO/ZaKWZa5tSaWxYGVpVcDQcwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfVJPOn3sXjYLy3te3f3TlXEyXW1ReLmQamAGrRCnk4=;
 b=AgkV17hEDYvAnlf7hWQ/2G+6H4EnHZaqoH4S372xNouZSEW8Z9YZrpCcruiiSrpIyvi4KT7IHQFNOJGXHl8z7dmbIMGEFV138iGKMvxHAWZX/aGP8QCddXAcWidMaM8FjG4WD7uaEiVCStKOf/HQFj+TuPNHs4C65Gh7l7K9+P8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4493.namprd10.prod.outlook.com (2603:10b6:a03:2dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Sat, 19 Apr
 2025 19:10:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8655.025; Sat, 19 Apr 2025
 19:10:30 +0000
Message-ID: <d25420eb-88af-4836-8839-2d5b54d6ec11@oracle.com>
Date: Sat, 19 Apr 2025 15:10:28 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, nfsv4@ietf.org
From: Chuck Lever <chuck.lever@oracle.com>
Subject: [Final reminder] Spring 2025 NFS Bake-a-thon
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bcda4eb-c890-4263-df82-08dd7f75da20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlRzM1grRzFyM01SNHF4TlR2NDRmOFFkdWVGWmxwNFJTdjZSMm9vY1R5eEU2?=
 =?utf-8?B?NGFkVlZPV0hKWnpTaWVNMy9TOWRTV3dLZVVjS1FaMlloMnNKV09XU0ptcWR2?=
 =?utf-8?B?NzFQcXJkRDc0UUZhUkNPeXdzd1V5WThOb25TKzdQUUVvQTVFa0g4dS9tOEZU?=
 =?utf-8?B?cmhqNnZBWXJ5b1B6ZzY1QkFIMlY0aUM5cE5pRGo0QXFpT2RuNWN0Zk5jSkFs?=
 =?utf-8?B?Vm5DN1VlcmFjR0Vna2phRzl2alpaNzMxUEx2eDkzMTU0dzhQSXJKcnBtdy84?=
 =?utf-8?B?VXNDRUY5RitNOVhLaXl0dkhvL3NLNXZseE9TdlJDVVNkQ1VSdmRndXF2TFZo?=
 =?utf-8?B?QnpYNGNLQld3TEJWNTVBampubHJmbDM2WXd3MVJ3UGpjL0tLakdrNk9NZXVK?=
 =?utf-8?B?Q2E0SlRKZGpHb1ltYlJ0WWU3L3VuTjJLTllpRzhLYzNZZlpueGh3YzN3bHd3?=
 =?utf-8?B?aFhtY2l6UUpUNElzMno1eDc4Z3Nmb1JNL0Z2eTRmZjg3WWZkMXpSQUg1NEZv?=
 =?utf-8?B?STFvaWpNRE11MzU4aGFDaWhwWGh5M2JuYW9WS0dYaVo5M1RiU3RoaElMZW12?=
 =?utf-8?B?SWh2dm1yaWV6NjN6SklwVm41d2Q2V01ma2drWTlCa00rcHJCU3ZWL0lVOFZN?=
 =?utf-8?B?UWR4NmVFY3Y3dFRkTkdjcE5PMnhoaUpSV09wRGE5SXl1aWVWMXlDZzdHSGNj?=
 =?utf-8?B?QWp2Tytyb1VubW5kdkx0N1BKOXRsbVlQa0hrbVg2MHVzYzloTFY2NWpMbmFT?=
 =?utf-8?B?UC81RmNvakVwUFJBSHY2NG0vUk9LTDRmYTU1WDBON1RVeVNNTFEwMStISUhL?=
 =?utf-8?B?ZlZveWRMdUkrVWk1MVhYVEtxUnhOZXFMemc1N3NqZmNjZ0VxMzJ0T21vSkJt?=
 =?utf-8?B?a0FWSFRENEw5ZGgwWU1iSWJPcVd3NDd2c2FCd3V6ZzVmTm9VVjQyNG1GcGMr?=
 =?utf-8?B?c0hVQ2pzcThpeW5wQklHVmxGWk5FbjdpYitCdmFLVythSUgvc2RRZHpyOUlE?=
 =?utf-8?B?QmhPOWo2dEx4eXRDd0duanNBN2hLQ3FHcS90SzZGeXZESkx1QXQ5eEtvRFZk?=
 =?utf-8?B?Q1pvN3RXN0JxL2MySXZnSHR2TzFTRXJmTm4vZ0VIT2gzS2ZTcXRhL2ZEYnFT?=
 =?utf-8?B?TEl0cm12RFpRVWlkTHRxd3JxR1dYS3ZoZGQrNFlYajBqYWRBb0FGK1gzQnJB?=
 =?utf-8?B?WUpOWmFweWxuS2dsaU05VFVvZERYWGdzSWRaREhvVXYvUEFmU1lvTmNxRWRI?=
 =?utf-8?B?QmV3YlYwWTNtS2R0SjNPN3JxcWlrbkkrVjgxODNMb24wVHNhZEo5UmtTSzN1?=
 =?utf-8?B?WURZODJZVElRKytIb3lWUDNudkJiMFhsYUhXcEVhWW9Tb0pvUnRVbHRDaG9Y?=
 =?utf-8?B?NTAzKzhXVTlSaFJIMkpobndIdzdMZjZ1ZUxYdFVnc0l2WVovSUpGRytqd2NT?=
 =?utf-8?B?NHFGNjNza2NPUEhMRkIxSm8xUXdKSFM4RHZkcEp5alBWa2pzVStldXo5aGhH?=
 =?utf-8?B?MW1aWFRualNQdmdJajIzNFRmbXlLY3BrZUZTR0lZWktydExSSFpHK3BXRVlv?=
 =?utf-8?B?UFdvRDNXVElTSER6ZDRMY1RWaStKWUZGSytHWGJZSjV5NHVRNmFaWXNCeEJy?=
 =?utf-8?B?SXhuTjVlZUFRVlhiSUFGMStaNXUrUG1meDBQOFBEZXBiL01kcGR5OTBsMmVj?=
 =?utf-8?B?ODRoeTBMMEZpTUROd0Z5WlhrTDdEZXAzRkhSUFlJaUY2SUNkL3p1OXFZN3JO?=
 =?utf-8?B?WkxVbzNaeC9STmhOT3ZwczBKc2RaSU9ZTDI1WDlySTRxS3VoQWtJQzNtY0V3?=
 =?utf-8?Q?VsPt6p2gVN2q76+qgUXSZzJdMuF9a7XatFSRM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzVJK2ZYZDgweHRnMFpkYlh6ZmpEelcrRzd5UDU1WThPZTg0MU1jZStTbnJy?=
 =?utf-8?B?OXZiMjdCTW83VEg4UlhBVGg3ZzVseU5aclM1cythL0lRSHc4TDdGbW9GR2V3?=
 =?utf-8?B?OW5zdVo3WUxjbERtNEt5UUluc3RmdW04SFdLK2R6c2N2K0VJd0prQWZRT0NI?=
 =?utf-8?B?ZjVQQ05KbldPNm9mZWQ1WWtZZkdyYU82S0RIVHVhbjJ1S2FIMzFmcWUySHdG?=
 =?utf-8?B?ZDg4TkVqaWk4RWJoOXZrRkY5Y2VNZXZ5cDZXZXVTRnpKOG1TZU80aGhobThw?=
 =?utf-8?B?bmxwYXdYOUdEWFpwTUk2RUVmZTBpdEEwcVlXUDRqeXZzcEYxbDRjRUhmU3Jl?=
 =?utf-8?B?eVA2TXhHUFNFUG9DL3JrUlJtdXZPbUx5aGNIQitEQ09xcUVmZGlVSFNzUjMy?=
 =?utf-8?B?MENrK092WmhDRnFXcW5mcGZVOVZGT0kzTmtCeDFZSVJOZnpDNDJUSVZkcTlL?=
 =?utf-8?B?Zk1zSmVpYWpTM1ZCRzNLYlNQL3lqclYzeG1nOWJ3blVuK2pIR2Y3T0lKc0V4?=
 =?utf-8?B?UmRJUHlMeHU1WUtmK21mQVdWVkdBbEdKeldKS2lKejN3TzlVL0pyc1BRSERn?=
 =?utf-8?B?K3o1RnpWb1FYR00xN1hkanhSMGFLbDJKK3grSmNvNENFZzZiaE1uVHhQZzVi?=
 =?utf-8?B?YW1EdS8vMlJ6MjJxNWcyNWtPRjNyb1BxN2YxS2VqQkhPRVBIRG5oeDkzSWxp?=
 =?utf-8?B?N0ExeGlYeFY5b2p4Vm95RElySU1sKzhjaFRVaFVGejR5MEVzSUFQdnh4ZHRp?=
 =?utf-8?B?RWhFTWNUSmw4RFAxUUIwUys4RXVOandSV1hQSjZyc0s3R2hxY1VzU3RpZHBh?=
 =?utf-8?B?VFJqZGJIY0lLWGpoNVVBWWxFL1pLTWRpSGRlTXE0SnBoejF2MVA0aDFxOHBh?=
 =?utf-8?B?OVZDMVBEY29RRUI1dUtxQ0R5MUFzRXJuNjFudmpjQ2lUTTc1SmtSQW4ydWZu?=
 =?utf-8?B?ZmJxa0hyMndRYzZCWDF3K0JiMkJvcUJjOVVZN1JLREUwcTJxT3ljTldEZjFx?=
 =?utf-8?B?QXBMYjU3L3NBR0VYTnpIV2ZMVzJ1Z05vTkx6MmVvVGtGWEhtTjZsc3pLamZh?=
 =?utf-8?B?bWF5empGUGo1bjN4UERObWNaR0NmZW5pRUV4VWM3bCt2ZWZqYjJpNFkvL1FW?=
 =?utf-8?B?bjIxdzNlbkYvcWVqcTluUE5MblpXT0pPS1o5UDFvQ0lVeWdmU3lFVFVYVExJ?=
 =?utf-8?B?czhiQXRFM2xWb251MVNtbFBYQ1lvczJKdTlHQ2xDbW9HcjdyNjVZOHVUdVpD?=
 =?utf-8?B?UDdMM0JyOWpRSVJmVTRmUHhaRTJUTTllNUtHNFZEbGkwZXQ2WUIvRGlGRzJB?=
 =?utf-8?B?ZlBCcWk4NGUzQk9oSkJxWmxkbEsxRG1nb0gwYXpaQklSTlNMWEQyVFVTMHJP?=
 =?utf-8?B?VVdEQ2tzZnNCWjBqTWpGWUhYd1NhTEttZThlV3lZdnNrbkJ5VW5rMy9XRUgx?=
 =?utf-8?B?b1JCVDgzaG5OUlJGMHlXSjZtbklFMm5VVnBlMGQzaXBvOUpYQUV2QzNHeGh1?=
 =?utf-8?B?WGgxYkJnQlFmeiszSndETSs0V1BSM1ZJVTVic1FiN25NaVpBY2NTeFl2MW5G?=
 =?utf-8?B?REVYSnRhZXJ5V3NUN3VsczI3bmdvc3R0ZnI3SFgxck9PSXpoeUlPdEdmSWtm?=
 =?utf-8?B?RS94cnZsUjllUGt1R0hZNVlrRWJSREUrWWhzbklnNHBGQ0ZDSDlyYXl4MUNu?=
 =?utf-8?B?KzFBR0U1cjY1V3pJbEQvazY0Nk0rb0JoWVBhN1ZTYW9WVWNOYVB3N1lCeXB0?=
 =?utf-8?B?ZlRLbHgrVVhUdEZnZmREUVEzbElKTDR4OGowcUFGVUJRSU5oSE5xVGZ6OXRs?=
 =?utf-8?B?TnA1NzZudkVsYk9OYTgxNCt2Qy9IOFUrYzNQR1c3eVRNL1lENi9ONXduTzdN?=
 =?utf-8?B?TnY4TFhNdVEvRERLRUJDNmtRT29wM1cyU0ZXNmdXSTlMMTgrYjVQRnk3S1hN?=
 =?utf-8?B?S09BWTlpVkRkTENwRUZIQnZvSVM4SUdvWHRFR3hDVmNldVlWREt0K1l4RDU3?=
 =?utf-8?B?clFRUmF1MEpueG1yemp4T04zYjExb3VmbDJrWVNMWFdPTWdrZ0R1N1NQaTBJ?=
 =?utf-8?B?WitnWW8xR242ZFhQSlhmblc0NHMweXN0Tkt0NENoNHdOTnRTSW9mOXNybnoy?=
 =?utf-8?Q?GfUilfiEwSo6MVyxewhQiov+3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2BNyq17xfjzDIXor0DNyUSgE9Z1PDC7Wf5tClXGOldtUHtoyA/nA9PGCVhOyVdI+MFhCZxX0LSYBKchUXUYP9pQFiP5ROZ08Ww62V4gZhJy87o+Rwub3jomIrF/sGQZMEE28rtKo+6snKpO8BNyy+wPMiXqU+d36JpMysmOFowidMm7hrCpjmB44R3+ppWp7x67m7XQv0wnLGhoUgefBYVqrhHagPxlN/f02GXPFnXzYdnkM36lr6cAmXyWb2JuTC9ev1seH3G3s9jSO3EHtv/WRk0rpj7OVAU84jl7wa9hyIHsqEOIjj3DdObr0k86Eqw3KsI4diV48b1M3xBJRBtpuPhV7oTNoiu4lPCvN0yjgGylTejFITkQefnApDxXSW+Mf0Q3kDrYDl0De34OklaFvuoc7jtCuZdOfe5RWTz32n5xxJ2MO076HcveQ1fQD+r0YqnxS4RiQxlTJMC1NZhIIdUZB5GK4O6iXyOf49x4wO/j+yoBWZ3E1U2PFKJzc7a3Tt1qqmuL185MFD+Wy0c26bVbLfHhsdp3hHk+bHfHuTucxMFOy+SyuA8JzzEGwm6b7SPEhNTcS3VGTjmk3H5msvkEcnVU7jnKPnqE7aLw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcda4eb-c890-4263-df82-08dd7f75da20
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2025 19:10:30.5632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fX5sxd5J7k4zPZMVYZABZ/FjuFAZwrFMX0OZjvoqHLAYUgqxY+ABPKDEYZMJtCEfxK7pycTjC+3xQCAJ47EPuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_08,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=732 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504190159
X-Proofpoint-ORIG-GUID: HXqqc0mZMFSHBJRIODodkonYjiy66yJI
X-Proofpoint-GUID: HXqqc0mZMFSHBJRIODodkonYjiy66yJI

Greetings,

All are invited to the Spring 2025 NFS Bake-a-thon event, to be held in
three weeks from May 12 - 16 in Ann Arbor, Michigan, US. This is an in-
person event that also includes secure remote access to the test network
via VPN, enabling virtual participation in the event.

Event registration and network, hotel, and venue info:

 http://nfsv4bat.org/Events/2025/May/BAT/index.html

Please let us know you are planning to attend face-to-face or virtually,
or ask any questions, by sending email to:

 bakeathon-contact@googlegroups.com

-- 
Chuck Lever


