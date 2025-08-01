Return-Path: <linux-nfs+bounces-13372-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F63B18268
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 15:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CED1AA139C
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944802E371B;
	Fri,  1 Aug 2025 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gw5pK7FU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XpkvF2/k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5724676C
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054694; cv=fail; b=uZ1NMW5wIbZSVMrsO3C7v0vMokWarIKA+17vATudxOQD+gv0FFwJ7XKEhLhVV8222kQ/fJCH88JnevpAFjU2juMVIpd60jyAoC5XheU7ykL2pXMLqb1mltcsfCJ713jsOQjLkg2pFvxVrzfAPzfnpvdx3PryMq0qgEE5GgQBpww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054694; c=relaxed/simple;
	bh=LYuaboE7nAro01DdpEZgRYXMg4imIrtHBsFJ4JIPVlk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tj6eQ12aE5yd2hChElrWc08r8pcS4aZrmxcz6fJ7JizFxP8VSL9NejVKKMBo0JnRoRvonx12nOCTF5IjAASQzHmrwEFpV4+DN8+Nahvp4YCE4oidHJMmFEprZ86DODpcODa/odeulCbyvPGw7gsRWDjhT/rMk2naxLGuGtn11xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gw5pK7FU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XpkvF2/k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571BKVrA022916;
	Fri, 1 Aug 2025 13:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wD42SytfhTPX1PqcixxlrnN2xIcXYBkiSVua0seNMMc=; b=
	gw5pK7FU32q/b/TjV+8YphT9lUYOFJ6cs6jr7bTz/2XTn41l20rMi3PdJyEUvuuC
	83BG+1oLhpQ4endoftvKf7KacDiMcG4XRV2D3L1vnFdumSR7joapdpHYku66xr9p
	3P6ZsecEkhp8ScvMPLz3vcJ+vEgt6GuyuFUnPB4Cx/L8n6u/MHsQZEMg0VJMss9v
	K9v0i2WuyEA8nZg5D1TH1t6xJv+9OjOFmgyw5nJl7erEVbsITB26veX8/AR5dVEo
	b1vu2EgBVts9XnV87mN1XPHG9++Bvz1p09Daz4QH4OSygRs+8L0GiQS9ULxFaXMT
	5VIO7YcV052RZQX/pwvKtA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q29xbuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 13:24:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 571CQ9kg011130;
	Fri, 1 Aug 2025 13:24:45 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfdpft4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 13:24:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOTlhnmZbdbqEQ2Wtz6uuWT460X7Qs1Q5qxEBVf6yVeHyoVv0rsL2R42vZASxsiNlUAI7Ji/5RvEkUd1euM9m1cuovStkfWOPtB8x0XRwPHFP49B+Z9QkmKWb37m6n1J8Ml93gsFWOvfvptrB5SeeXYioRAIHUJubrUh6myBH2etq5/1c6fkgF0eB2cWqVvND0Sh6+x7pOrqC2mreDI+P6KECRDuoE1ZUhL9EEAwr3NrU54C9HvdngDFI5L+ec9ggiXu/NgMgVLwo8V+gZC8uUe1FRCHTAf+Zm+ERmZV/85MKRRU85+ORvAQPJI8hQXM7SGw31haWk66kSI6he5P9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD42SytfhTPX1PqcixxlrnN2xIcXYBkiSVua0seNMMc=;
 b=oPL05E36ODf3c9xBExOq4hXlbh8LS3rnCP7oz82R+HUl0ryIpDBhfBPPCxyOXakjyDlA5BkWkNM/IA4Fo+ovq0O7phpVG2lW7SwNUYm3ek33rBIITqUFn5SYrKGYjaNnNZ+SNuwaWJ2DTHoQJSsGEupz2sDAxHsEuRXWjoMqQpazfEZF4rYfd+i9FUy0UPSwMc4qc4DSWK9ThWjI7SooygdNzMgtuuJr+jiX5xxTHzZua5kWCVaP6ax1xe/i42Hc8ap9w4Z52JkqwaLPq2JUurg6i9uRrg1ZgeuBKy69/CJvaEL+tn15/inr4MQHQWhJncsqopJvw0KIGPEUPBGLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wD42SytfhTPX1PqcixxlrnN2xIcXYBkiSVua0seNMMc=;
 b=XpkvF2/kQHW+oNlLaWiOMKgep9Bd/rFYcK37xGkKSjXxpylN1mQboCODD5D4mOS7gUT138zYGni9XvOAiM2YrG5WLdF9rzXgC1M7bnXTioQeGvo8CnetN7EzUDjdqDq+wxh2EKdyCHjqfv0E5eLHZ7bw1fTIleV8UE+joE0ln7Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4610.namprd10.prod.outlook.com (2603:10b6:303:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 13:24:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 13:24:42 +0000
Message-ID: <3cd2b16e-d264-48e0-ba20-0c666d88d39c@oracle.com>
Date: Fri, 1 Aug 2025 09:24:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: decouple the xprtsec policy check from
 check_nfsd_access()
To: Scott Mayhew <smayhew@redhat.com>, jlayton@kernel.org
Cc: neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
        linux-nfs@vger.kernel.org
References: <20250731211441.1908508-1-smayhew@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250731211441.1908508-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0326.namprd03.prod.outlook.com
 (2603:10b6:610:118::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb41201-8472-4152-bb17-08ddd0fec63f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RGFsL2xoQW1tb2pUTWVXV2hkb2o2ajJPOTQwRW83SWtjMFg3bDJsVkRSR0cw?=
 =?utf-8?B?SUdFUTBidnBwaUpQNlk3eUxKYytXNTN6bHNhV1l6ZjJmN2h1VzhhVnNRRjVB?=
 =?utf-8?B?TXdicjFXUWVrYk9GOVdudG82RDJWMnhCRTB6NmgxRllyNW83TmRPRzFGR21u?=
 =?utf-8?B?WUR0R2RZRCtxR0xnQ0hIRlhGMHZpbW5lVEx2U1NWTmRmZHF2ekpVWXJ6THZo?=
 =?utf-8?B?Y0g1RVMwTWxiMythckZaemVKS0tkOWJydko1Ymx6L01oR3ViSFpTcVAvc2Ny?=
 =?utf-8?B?UGZ0VGlhVXhYM3JJeFZjeTA1eHdPRnJyeDd0N2pmajNGS0FiMnZjS1JvQ3ZE?=
 =?utf-8?B?K1dYMW9iMjQ1QXRYK2krTjF6elFJcDcrMWJNVkpDRzJySGhFTjRYVGVCdWJP?=
 =?utf-8?B?S0RhWlR6SlMrT0VOZGcveDgvZjBLMnNDVHU3QkI2MFE5SHB4UHU1MWlyNnZQ?=
 =?utf-8?B?S3JsU3F6SnlJTFBSa0ZqdkxmWjR5ZFlBU3RpdzUvRGEvS2JSUGFReS9pQnJa?=
 =?utf-8?B?dDJhOTA0bzV4VlJDRG5vT2FPd256cWlhSDF2cVk4V013bnB5UVZhek85dXN0?=
 =?utf-8?B?SmFjWUNWbWNiN013ZWFWQU45aG9veVhTbEZFZmNTbDRFTEJaRlc3ZEk5R1pi?=
 =?utf-8?B?UHZKQTlQUGVwN21YVno4eXZ5ZEtQd0RraVhjc29FY2cvUDhJODExaU1YcHo0?=
 =?utf-8?B?NUhmVzU2eURnU1pGcStkeG0xcFdJdXg1aHpLY2xnVCt0bHk3ckFRYlBZK056?=
 =?utf-8?B?djA0Z05nc1V3Tnh6aFE4RlFtbW5na0pQN2s4YzFWUUprQlRELzQvdFpaMUk5?=
 =?utf-8?B?bFBMTDdQUExPdndlbktTN1YrYmU3Lzl0NTloRDc3MlAvaFJ4TXEwODJaSk5S?=
 =?utf-8?B?akN3TXRWZ2ZjTkZ5cmxnRGJlcmh2eUxteEM3WExBQ0FiNnR5U3poRlhUQTV4?=
 =?utf-8?B?ZENlWURQbHRlK2VhcUJ3Z09GdTh3QS9YUDRVd0dYS0NlNXM5c1NRZlUxUldI?=
 =?utf-8?B?TmRtS29tMVdqWmJZVjBPTy80dVN1enFGRTg3cy9abWFDZklYUk9FdjhWd2ZG?=
 =?utf-8?B?RUUyVGh0ZHZ4anp1VHBpNHUrdjNETlZ0UWtWMXE4cisvT1A3QTgrNDEyZGIz?=
 =?utf-8?B?UTR0ZDdlSnc2MDRDcGlMODg3R3N3YlVHbFM2V2hUSmJxWWVRWVdmMkhyNXlD?=
 =?utf-8?B?NkFuS2liTy80djgrVDlHelJjcm9KTDJRbkM3K0tkekVuV0ttZzM2MlRtandp?=
 =?utf-8?B?NStXbFJsMWdrSjlYWEU0U2JnODBGUlZYTFB5aHc0R2NqYi9JZy9vQnBMMFlZ?=
 =?utf-8?B?Z1YySjVDRXZsZzdEVXJmbWp1VnlTc1JaSyt0UFBPWTRneXhuTGxmaGRvREVh?=
 =?utf-8?B?VFRNL3ExcVJORFRnTXRzQ0hRLzZDcFp2Z09ZVjNFTUMrejM0bk5MMG42VXQr?=
 =?utf-8?B?dHFEYnBLdGJDQ0k2eGFua3ppRzRCWElKZnlaOEplR0pKak5CakJNYU9abGNk?=
 =?utf-8?B?L1B6MithUkZQMVNWTHpKek1pM0JwdW1WQlhjaVlQaWhLZXJpZGVMeFFFSHRp?=
 =?utf-8?B?c3I0OWtWelpNR1cvQ1NtQlp0emExOHEwRGNRQlZqVHpOVkFxR1crZmt4ckNV?=
 =?utf-8?B?R0lWbENSYmxXU2cvNkM2U1ZXWGptNVBzUWptOEMxUkI1eXhJQ2g5dXdpL2Zn?=
 =?utf-8?B?T3NjaEFCWDNVMzN2VHZTczhnYSsyeExteVg3aWFsMmNPc21YTzdDdS9tK0Fl?=
 =?utf-8?B?VW1JbGpuUXdnZ2lwdEdQTEU0c3hQcFY3dDhpcTIvanU5UnhZWDFXMDdORUtP?=
 =?utf-8?B?ZTdXU2JBdC9rUXhnb0VmMVJMWEVkZXdJNDYxSDZyWmRETUl6RjV6U0YyNDJS?=
 =?utf-8?B?RlYyZGIvb25rMHpOTFFPTGRPWStFOC9qaWF5TGUzdUp3NlhYUWNKT0grbVY2?=
 =?utf-8?Q?gaMms3bXfTI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eTArSTVJak9EVVpqL2JVTWo2UytpQ3I1STN6L042aFhtTDIvNi8xSFF3dHZX?=
 =?utf-8?B?N2xMOVd5WklhTFRsWFNkQkk4R1BFYUdKR09oTWhRb2ZDTzZRUloxSm1vOHpZ?=
 =?utf-8?B?TnFZdUNlck5LajRTczA5ekRKSW54cTBMc29HZzVnYzh2bklIa0NENGd4bURt?=
 =?utf-8?B?SjY1cngyajJCMWdXRnlPcy9QRFd1a3A5bWIyb211SndwWVN5U21zMDExK2pT?=
 =?utf-8?B?Z3U0cStYWUtRaGk2SVYwUUJOOHJ5OS9xZGtHY2cxaWUwRytpV2FaV056WVY1?=
 =?utf-8?B?SE1pUHZFZWRpWVNtcXFmWWNHaHBjUUxQdXFkWU1aaUY0QUR5cjNvand5K0xv?=
 =?utf-8?B?MnZ2MWMwOEFRdkp1YjZwWXZneWpXanRERUNVTGhXci92TlBoZ2RNYkZQZ2Fs?=
 =?utf-8?B?RXFsRVZYUjRVVDI4ckdRNURLRVcrNXEwM0RVMXhEU2VRd0ZrRXRXR0FITXBn?=
 =?utf-8?B?VmcxV2gvNUxIRnFaN2tJMW5iZ1k1ejdaOHRjd1lQbHlkejhlWWZhc1FMQ2Fk?=
 =?utf-8?B?OHVqejdScVJDZS9mN1NEclBJYkJ5eWY0dzZyZk1tdEVKdUJkM2hkeEZEV21u?=
 =?utf-8?B?N3RNUnh0MjNpODJUTi9JT3V1VFN6QWJOUURYeUwxbXVhcFlSZkMxakw2b3pZ?=
 =?utf-8?B?azhHK0N6R3poSFM5MjRBczdLTjI0a2JtM1RHU1BvSXY2OVZFUlU0Ujl5TlJo?=
 =?utf-8?B?VDZmL3BPemRQOUVuS3JsVjI3OEJ6cEpmVVFLc1YralQ2blhaRGFBN0szTk05?=
 =?utf-8?B?MnM1a0xZb2daL201eG5EREpacHhobmlLdnZ5alluV2pWdDVUYUZVRTgvVEgz?=
 =?utf-8?B?b0ozTjltaFVvZUNPbUEwYjJCR20vUVJnTjBFT01tZDFDN3hnc3BVRDFEK3Y0?=
 =?utf-8?B?ZkdlK2VBWitkdDFZQjU2MHdOL2ZqOTg4QmF1UXJEQjB0NWorT21sdCthZHdJ?=
 =?utf-8?B?VUMvVmJEcHhrejFCN1lvRm9IWmpxMmdXZDNleDRHc0NaRVNPWlJ0ZkxQcXJq?=
 =?utf-8?B?WnlVRWg1VDRudFFqc08vZTQvQ0c0UDFTZW1rVUtjS0g0SmplTnlmeThKaVU2?=
 =?utf-8?B?S3BOcklCSDFrQkpob016MUZCNHp0bXJTdmtKSVZ3TG5GZnc0Tm5JQnVaTTJ2?=
 =?utf-8?B?ekpwZ09vLzU1dC9ua0hheVZiWDJMR2xacGdsNzMwbGx2UVl5cmJVQXR2NVd1?=
 =?utf-8?B?TUlVbkh1MmxucHg5Mi9zejhYMEhZNStsS0xyenprUnRhRklTUEJUbVZKSnZ2?=
 =?utf-8?B?N3RkYWNEOWw2THFXVXkvc1NWSWp2YVlnVTVXNUh2QmJ3YS9kRi9TSktRMWN4?=
 =?utf-8?B?TzYyL0ZSQjB1TWVWaHdvbld1RVdVeS9LTVpRSGMydmp5dy9jbGZMcDZFaUNs?=
 =?utf-8?B?cUR1Y2dnUHVaWmd2K285RnVTL3JTeHJ3M29qeHRhNHdNMkNkd0VydEltWDJk?=
 =?utf-8?B?bFQvQ3IwYy9zRGplMmJlcnE3Smt0ZkUzb3BlT29COE5RQWpVN1JlLy8vOHB4?=
 =?utf-8?B?MHIrb0p2ako4Tk5abnRFMEh4U2FuN3ZJR3JqWHlPcWFlWWx3VE5VU29CZEJh?=
 =?utf-8?B?RHVOMlFjVisrVUI1eVVPa3EyRnhWa3QrMWJ2QkJsWXNKajVTY0U2NXBvUFdk?=
 =?utf-8?B?QkJ1WDN2OU44L1hhc1FGTGJKb3kwY0NYcHRTUVFINGF1WDJhNTZMekNsdVZ1?=
 =?utf-8?B?NCtJRzhvRnMvLzhYM2ZrVnlLdzBIeEFsTSthQjh6UmpJWjhydDJ3N212dmQx?=
 =?utf-8?B?RXgxWXNrclFhUEs0MTg2dWRDaGtONVRlTzk5RGFsdVpTVUhBT3VETDVrRFhW?=
 =?utf-8?B?UXgwMUlMZUswWkRzWXdWcEFxd3V6Y21xbUE0eGw4dkYwYlZXQ0pKek5yaFNS?=
 =?utf-8?B?MkR5aUk3VnNZT0IzR3dqZnZiK0U3QWx4by9TNHdTTW5XTHV4RDZ2SHU3NVdE?=
 =?utf-8?B?NEhrLzdtNlUrNTErdS9CN0J6ZEdsd2VxTFdVZ0toWm5pWGIxdVNhS203VGdm?=
 =?utf-8?B?RXREbHBGL3VOTXhsSHRSN0hxSXMybW15aVJPN280YkRxMjBJcDVYV252YndR?=
 =?utf-8?B?ME9PcU14alpaM0xXR28vQ3dMZzgzd3psbE12d2lidUs0VC9RcitURmRGVUZG?=
 =?utf-8?Q?a67Pj6tgDqWTaJn8gEuQPsFk2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xgEy+YZuqDK1Bb5lnh7AlcHYSMOd3P06nkjQBclsy8hKwQs+xK8+MwGHYDRd5YqRmT/ltGabJ3QfYQATT/oKbdt78Gaxi5ZUluwkrHabngYgOxRFOj6HBhnXJUF4RXgqYXejycH1bN1nzeFSaEEdk7xEQl+v3HX5Zr9uCImLpBsIdbqYWpzNH3nS31Y/5cNNA5dsSX2nE2YStWM12ZKxHHeUcPKT0lE8p2/G/TXtfdBq2qB6z+acS5a/kDr+dr0fTI1RLCWiyDncEzzvAxn3KrnZ239XZu7PUyPXLIxasn53uQEg06tAw/tqP5wlnHXGQq+Gw6sY/rsGK3jVNb3eF6Dlhhx6NniDAkjQvbLyafRAbv2H8VwtAoRHzVv6qZot+ZHQ2BdkAMfzxv5OAfZcj1FkcHUnfMyf9dNA3Au3T0s7+jBK/xHzdAQcO3dMDc94naH7ZNZGAwTqMYd4PMndGJSwa0mVpl4qXPr/ulqSNmfJnflMjKhffaKTrTAHCLWNimG74E1Z/BCE/Utf/qNCBaxVj/n4NwN4nT70Zbfuqg68D5MscajuOlYD+OwxcxySVpkC+CR+U02JToBOi/7N0KoEYIhh2pZJmg+g0xLXjzE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb41201-8472-4152-bb17-08ddd0fec63f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 13:24:42.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6WZIvFnzUcSJ9/ORDcfYmOy8DC4MrbQ0xS6nzycP7c2nnMu/uIsotGVMLhKqdzj6iRjv0sLmu5BmwSdzKLw4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508010101
X-Proofpoint-ORIG-GUID: dxKq_yzeX2qEmXc0oLLY5McyU0OktJRS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwMSBTYWx0ZWRfXyd53czlz668E
 7uzi8Gx5GBXX/flKssB1PyFDw6iJ6E1C8Hkci/291oTlGuMlah1HGGAoaHCj4VrtN7MpbfI0BAT
 uZxu/IcyR9UhpTRZPOthnydEeFzs415BOlXUgfADuei8miNA6kH5AhHIfGFOD7rqkIwcEt/wrAE
 OLhr9Oo2vjgDLp0VUCBJX4f0OhhZUID15tGQbYMYYtvTlyFW0+nx6R+iMNHjIW2xe42LedpPlYn
 c0NKncdtjkSbBjNyh/debB/2RPFw3/b9hJ7P392ieQMbCoBdn9SjKx97rleucf617nAHK2otk5s
 2QwxllfHzAgiWGXkp3dnvLj1S8FvbvBTKV2CRuR/0UG7OZBxIlCHC5bO3ZQ1dXnWTeUlVIprZ8L
 znjx90M7wyFaPnAyf2Oyj7ITfDX4Hp+nczVVw0iIAZVxSkixx5IEgE1zh66fMPWtWIzOtyQU
X-Authority-Analysis: v=2.4 cv=FvIF/3rq c=1 sm=1 tr=0 ts=688cc01f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=MJoskMjacLkOFJjSTlwA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13596
X-Proofpoint-GUID: dxKq_yzeX2qEmXc0oLLY5McyU0OktJRS

On 7/31/25 5:14 PM, Scott Mayhew wrote:
> A while back I had reported that an NFSv3 client could successfully
> mount using '-o xprtsec=none' an export that had been exported with
> 'xprtsec=tls:mtls'.  By "successfully" I mean that the mount command
> would succeed and the mount would show up in /proc/mounts.  Attempting
> to do anything futher with the mount would be met with NFS3ERR_ACCES.

I agree, though it doesn't compromise access to file data, that's not
the most desirable behavior.

Can you find your report on lore, and a Link: to it here in the patch
description?


> This was fixed (albeit accidentally) by bb4f07f2409c ("nfsd: Fix
> NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT") and was
> subsequently re-broken by 0813c5f01249 ("nfsd: fix access checking for
> NLM under XPRTSEC policies").
> 
> Transport Layer Security isn't an RPC security flavor or pseudo-flavor,
> so they shouldn't be conflated when determining whether the access
> checks can be bypassed.

Fixes: 9280c5774314 ("NFSD: Handle new xprtsec= export option")


> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/nfsd/export.c   | 60 ++++++++++++++++++++++++++++++++++++----------
>  fs/nfsd/export.h   |  1 +
>  fs/nfsd/nfs4proc.c |  6 ++++-
>  fs/nfsd/nfs4xdr.c  |  3 +++
>  fs/nfsd/nfsfh.c    |  8 +++++++
>  fs/nfsd/vfs.c      |  3 +++
>  6 files changed, 67 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index cadfc2bae60e..bc54b01bb516 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1082,19 +1082,27 @@ static struct svc_export *exp_find(struct cache_detail *cd,
>  }
>  
>  /**
> - * check_nfsd_access - check if access to export is allowed.
> + * check_xprtsec_policy - check if access to export is permitted by the
> + * 			  xprtsec policy
>   * @exp: svc_export that is being accessed.
>   * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
> - * @may_bypass_gss: reduce strictness of authorization check
> + *
> + * This logic should not be combined with check_nfsd_access, as the rules
> + * for bypassing GSS are not the same as for bypassing the xprtsec policy
> + * check:
> + * 	- NFSv3 FSINFO and GETATTR can bypass the GSS for the root dentry,
> + * 	  but that doesn't mean they can bypass the xprtsec poolicy check
> + * 	- NLM can bypass the GSS check on exports exported with the
> + * 	  NFSEXP_NOAUTHNLM flag
> + * 	- NLM can always bypass the xprtsec policy check since TLS isn't
> + * 	  implemented for the sidecar protocols
>   *
>   * Return values:
>   *   %nfs_ok if access is granted, or
> - *   %nfserr_wrongsec if access is denied
> + *   %nfserr_acces or %nfserr_wrongsec if access is denied
>   */
> -__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
> -			 bool may_bypass_gss)
> +__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp)
>  {
> -	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
>  	struct svc_xprt *xprt;
>  
>  	/*
> @@ -1110,22 +1118,49 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>  
>  	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
>  		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
> -			goto ok;
> +			return nfs_ok;
>  	}
>  	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_TLS) {
>  		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
>  		    !test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
> -			goto ok;
> +			return nfs_ok;
>  	}
>  	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_MTLS) {
>  		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
>  		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
> -			goto ok;
> +			return nfs_ok;
>  	}
> -	if (!may_bypass_gss)
> -		goto denied;
>  
> -ok:
> +	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;

We recently spilled a lot of electrons trying to get these version
checks out of the generic security checking paths. For one thing, this
particular check is valid only for the NFS program.

Returning nfserr_wrongsec unconditionally, as check_nfsd_access now
does, should be sufficient.


> +}
> +
> +/**
> + * check_nfsd_access - check if access to export is allowed.
> + * @exp: svc_export that is being accessed.
> + * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
> + * @may_bypass_gss: reduce strictness of authorization check
> + *
> + * Return values:
> + *   %nfs_ok if access is granted, or
> + *   %nfserr_wrongsec if access is denied
> + */
> +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
> +			 bool may_bypass_gss)
> +{
> +	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
> +	struct svc_xprt *xprt;
> +
> +	/*
> +	 * If rqstp is NULL, this is a LOCALIO request which will only
> +	 * ever use a filehandle/credential pair for which access has
> +	 * been affirmed (by ACCESS or OPEN NFS requests) over the
> +	 * wire. So there is no need for further checks here.
> +	 */
> +	if (!rqstp)
> +		return nfs_ok;

Is this true of all of check_nfsd_access's callers, or only of
__fh_verify ?


> +
> +	xprt = rqstp->rq_xprt;
> +
>  	/* legacy gss-only clients are always OK: */
>  	if (exp->ex_client == rqstp->rq_gssclient)
>  		return nfs_ok;
> @@ -1167,7 +1202,6 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>  		}
>  	}
>  
> -denied:
>  	return nfserr_wrongsec;
>  }
>  
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index b9c0adb3ce09..c5a45f4b72be 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -101,6 +101,7 @@ struct svc_expkey {
>  
>  struct svc_cred;
>  int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp);
> +__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp);
>  __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>  			 bool may_bypass_gss);
>  
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 71b428efcbb5..71e9a170f7bf 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2902,8 +2902,12 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  				clear_current_stateid(cstate);
>  
>  			if (current_fh->fh_export &&
> -					need_wrongsec_check(rqstp))
> +					need_wrongsec_check(rqstp)) {
> +				op->status = check_xprtsec_policy(current_fh->fh_export, rqstp);
> +				if (op->status)
> +					goto encode_op;
>  				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
> +			}
>  		}
>  encode_op:
>  		if (op->status == nfserr_replay_me) {
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index ea91bad4eee2..48d55c13c918 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3859,6 +3859,9 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
>  			nfserr = nfserrno(err);
>  			goto out_put;
>  		}
> +		nfserr = check_xprtsec_policy(exp, cd->rd_rqstp);
> +		if (nfserr)
> +			goto out_put;
>  		nfserr = check_nfsd_access(exp, cd->rd_rqstp, false);
>  		if (nfserr)
>  			goto out_put;
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 74cf1f4de174..1ffc33662582 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -364,6 +364,14 @@ __fh_verify(struct svc_rqst *rqstp,
>  	if (error)
>  		goto out;
>  
> +	if (access & NFSD_MAY_NLM)
> +		/* NLM is allowed to bypass the xprtssec policy check */
		/* because lockd currently does not support xprtsec */> +		goto out;
Every check_xprtsec_policy / check_nfsd_access call site now has two
function calls, resulting in duplicate code.

Why not leave check_nfsd_access() in place, but replace it's guts with
two helpers, and then call the two helpers directly here in __fh_verify?


> +
> +	error = check_xprtsec_policy(exp, rqstp);
> +	if (error)
> +		goto out;
> +
>  	if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NOAUTHNLM))
>  		/* NLM is allowed to fully bypass authentication */
>  		goto out;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 98ab55ba3ced..1b66aff1d750 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -323,6 +323,9 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
>  	err = nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
>  	if (err)
>  		return err;
> +	err = check_xprtsec_policy(exp, rqstp);
> +	if (err)
> +		goto out;
>  	err = check_nfsd_access(exp, rqstp, false);
>  	if (err)
>  		goto out;


-- 
Chuck Lever

