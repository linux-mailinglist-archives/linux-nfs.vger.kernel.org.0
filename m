Return-Path: <linux-nfs+bounces-3151-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F578BB36A
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2024 20:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30424B219D1
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2024 18:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848AA5029A;
	Fri,  3 May 2024 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O14msnzh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rdKVLjEY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF12D51A
	for <linux-nfs@vger.kernel.org>; Fri,  3 May 2024 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761898; cv=fail; b=gzlTUfXqDXqOKcuQoG4OJlP91xw2zgnofq/R318U+inHn4gVy6+HOv7T3eXmsE/Fjsv6tew4BDwh3My0a2Fbe2dKf6kwvPLgW9GZMlQ9IUSUDMc87SbMTk3ILV1le7u5WEOSnRxd4+2oTTgl4M6Bxp/YH6dGF2sS9dUfYGEvohs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761898; c=relaxed/simple;
	bh=4KQUbcsI4RO+W0PLygzyspxy1UiWIfRYM0NpifKgIQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gk+tB0f0qPCJ/KAYjwtV57EGkP+HFds5bdVfjRDCbtv58cA8QZldb/wUZIbqWATEWwsL4C2M8QFz/VvEoR+XLE6IL6oEop4ZMjWKNUSquQEcVBgNkZ45ivsnts6u9ke8ish1DFJ+0s6t9tEtx0VfYuT3H7rJdqLrvGBsR3qETY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O14msnzh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rdKVLjEY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 443HkEe8010913;
	Fri, 3 May 2024 18:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=M7N/BLJDzctpHPX3FBtT3+/tlNjJuJiHSbvgp+JoJyQ=;
 b=O14msnzhQR44UWL9RGRPtAiLzBGraQq/DXEp/SrfepysKOm4Niq+An4FJJTRTu+W+TCO
 BO+uRS/qsZ67HgYGngzL1hpcIbhVPCgT7cxL065FfLMvXGKzo3LTKgvsLy3wUCZOEVau
 Y33SD9AL6Tnc5uBIZN3H/efHolnyysSZ+Fw1WnbVQCYYr2K5JJp96QCdzypNtT3GWMua
 JJh4SVFTsInivCzQRc06kDWQNJCTGRQILtajR9ZsSCKoUA9y+j/cV2/m3wHL58lZbtCC
 WTwjOPrs8u8/XEunLXutHSaVgKBsRyWL+uM0fu3M2hhHk3XY4V/eiboiMIKCbcQfMhuT ZA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdf2pn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 18:44:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 443IU4R5002188;
	Fri, 3 May 2024 18:44:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtjqpv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 18:44:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PD9BMTttlo5sAcdK71n7Q5Rs1s6gGNCz4DtBvs7yLLYvo/fwINfb6cr4ABJ2exOEerk3S05dK0ikdggpN5gPuo3w5d3H3dsVfnhKtN0jek3FwOjCfLae7ZOThfZsVKmkKw7/zdMjsOYrz+XLLuiBQv2PgCMFVEMmLxoD5jiVgJg4xrKm2wQQrgRlAW5oKW2QU/TMP6LRRYb7BC2RYKVWK/UaSsOFXM/ISZqiY0SNTrtDNOG08lLNeuVbiqKGkQldULDcxT/nuGN90A/oHBgPP+79FajbTXTRzyUondcaZp8UhmPVRF8xTurGf2Y0/knA4uwLQZYRoY9JBtcGx77r1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7N/BLJDzctpHPX3FBtT3+/tlNjJuJiHSbvgp+JoJyQ=;
 b=Y89xVD/a195tdoEFSAWHzj4g3+I6KhjfNs8LjBMuJ8Y5g2wHIyZz1UQ6OALuZ5yvBFRX/e2CXNKn2VUJ/BEiz4DTFG07Sj3kNGd6vqlaD7OjyWc6Byo3t5bdOZteBr5hf5DD40U0+mSKIzfAsN9SOilEsjIDE+Z6l1CIu1fxRkHgtpimc/sKDCnUEN00L+btVvqAWbyMKWto0iZMz9TR9Qcqgry5iCuLttuxp72+8M7+CDQGRmIPnpSAp8K59lCmd9kVJ2rjf3kzgrNvWqFqJ5tZOeISggX4bcE9+6T9kasOT4NIo9lOm0yjffx5zbsdXLbU+DzF18gUdBNt80/b9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7N/BLJDzctpHPX3FBtT3+/tlNjJuJiHSbvgp+JoJyQ=;
 b=rdKVLjEYnzcxDhI2FAGeK+ueDbm++mICNnc6oQZRm8QqHVV5xZ/kSgQIILFaBKGND06LzbgNcj8MnNNILaZ/p8IZ1XSlpQllMQGm750HxBcbhU4zrnsVpiSwCY0G7JeB5qD08tuzwzYha6LWGPokkN3mR6Ibjof4UOG9QCVQbGc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5804.namprd10.prod.outlook.com (2603:10b6:a03:428::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 18:44:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 18:44:44 +0000
Date: Fri, 3 May 2024 14:44:42 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Scott Mayhew <smayhew@redhat.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv3 and xprtsec policies
Message-ID: <ZjUwmthoBkBLaW/I@tissot.1015granger.net>
References: <ZjO3Qwf_G87yNXb2@aion>
 <100A1A35-2B53-46CA-A448-F82A95CA1EFA@oracle.com>
 <ZjPPZmBZJZVmBuA6@aion>
 <38C9B493-2A43-4691-A19A-8998F0DFAED9@oracle.com>
 <ZjPgq-xA1G6Z2_aQ@aion>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjPgq-xA1G6Z2_aQ@aion>
X-ClientProxiedBy: CH2PR05CA0009.namprd05.prod.outlook.com (2603:10b6:610::22)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 195c261a-c26f-4c5a-4f5e-08dc6ba119d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WTBoVlFTY2xmcDk5L3NqU25TWXU5VE1qckNGT3pXNWtXaVpKLysycElqamM2?=
 =?utf-8?B?bWk5VFRkQm0yYWduZ3pqYVdUdzNGdHBXb1U5bDVSTXoxdXFRZUJQc1RiQXpI?=
 =?utf-8?B?Sm4xVk1LYVlMOGZ4OCtsSSs0Z3dydThOK1JIaWlDZmloTXBvYU1LTVByMVBk?=
 =?utf-8?B?N2VZMHI1ZnZ1eVBXWGJXREZxc1gxdzBmYlhWZC9QaDBjWXZMNE5MN05sd2Ro?=
 =?utf-8?B?OWwydHpsdWIxWW9iZTVJdlM1VzNkaXRxZnp2Y0VMdzc5TDZGNGtDeGRLOGpr?=
 =?utf-8?B?MFdhMlNtRG11aktQZnhmdlJoN2s4N3pNTGZOb2RxQUdlZkRvQ25mOUtUbVJz?=
 =?utf-8?B?Vit5ZEpQMFl5a04rbVV1cVJEbjRTWkVjUnJNN1phalhJTmNTLzNRcnlPTkFa?=
 =?utf-8?B?bFJ6ZXZIcDdBYlpoVmE4djJtK2lYWWQ4K1BtWEdwc2kvZmt1SjRmWEdmYzJy?=
 =?utf-8?B?d3Zha3Foak91aFVkWmFzcXMzZUV1N2RQRC9uRDE3QmpVNHl1V0lKN2VRbGw3?=
 =?utf-8?B?SFhlNllIS2M0aWI4QUhYTkNkNEFZcjFwR3IyeUdUMnV2V0pQM21DNFdqc09u?=
 =?utf-8?B?MU1Ycy9kQ2FKVC9mZ0NzUlVQZnBxYmx1L01meGx0NVdwREFrdURXd3JLSGd2?=
 =?utf-8?B?WHlIWFBraGlyRVR4ekRNaDArQzlybGVlaVNGN1YxeDdkSDJtb3F2cS9DUGVh?=
 =?utf-8?B?NVd0RDU3bVlqcjl5RjQyald2UFhZdjFOaXd3dDJhQTAwVjg5L2xtdE9TSTRr?=
 =?utf-8?B?azd2Tk9lSG95Ti9qWW5JT1IwL3lUZFliSU5Va1NJdHhPSVluWXNYdHFrRVA3?=
 =?utf-8?B?ejJJb2tqNlJ2TkN1M201N3hra3BDbG40RzhVbjl3dlQ4ajJUMkRpakZ5ektu?=
 =?utf-8?B?UUdwbm1EYjg4UzNSTXhFSTNoS2R0Y2k4Tjd0NW5BclU4YXEvZ1FFUzNzVHgr?=
 =?utf-8?B?WVpWdVVUWkN3anVUOG4vS1NPL21xZGdUZXduU0JudTQ3dmxuOSt6UDY0ZmlH?=
 =?utf-8?B?MnNHcjE5RXNqOXJVVnBYa1hwaUVkSzNHSXRhMUNLd3cxMTFxdDlLTEdqd0lX?=
 =?utf-8?B?UkR5TjlsdUFaTDRWczRDSDZNYnhsWHlUYlpmQ0hjZUpQanhqK3B3c3NsaDRX?=
 =?utf-8?B?WkpEWU5vV21hVjRNZ2p4dVhRazZLdlMwVlExM3lTQlBDN3dhNVZBWTBJUm4v?=
 =?utf-8?B?cTk5WTI2ZTE3MmREQUFtV01pR1d5V0J1b2FScVpDZ0Nuc0I0cEtMN3lDRkRt?=
 =?utf-8?B?R0FoQnpRNUZ1TjhOS3BpLzNGdXAvL3lQa0wvREdXV3Zxam1VZnZCZDJIWU5M?=
 =?utf-8?B?NFBHOUVNa1NBZWFQL2FXSWxhdmFnNkdnSmpKcmh0aUdpenh4QkdOU3N4T0pq?=
 =?utf-8?B?Z0VoOThuQmxFUGRZZDJaUzZIQ2dJSjFaZ3N2bXNCMXMwd0xUVTE2SlZsVlpa?=
 =?utf-8?B?UkZlWHNZZ1B3aXQyTmROLzFWQ0lJWXlYalNvT1hhSmxVSk1QUUs1Y1dBcGUv?=
 =?utf-8?B?VU1IaW12ZkYvTVd4YW5iVXk2V0RzK1YzU0k4VG9pWWxMK2VJSGFpQzZBcUx6?=
 =?utf-8?B?QjNiMjY2YU4rNWFhaVVWS0d3VU1BeW9ab01mdFhqaFpJOUlwdkRUOURoYzBY?=
 =?utf-8?Q?fFxMdYRp/Kx8e6EXoc3x7SpLMcTKv3op0pzEemM9gRhU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFpKSWpnK2tid0d1cHRmbS9iTTBkUmRzOGM5eGhKRXdlbldtT2g3NE9QRUQz?=
 =?utf-8?B?bmVNUUF2Q0RJVGRFNk9MUWI5OVlaN0lnNWduWm1lK1F3VWN3YU9RNDFkOW92?=
 =?utf-8?B?R3pUckdUMGpOYTJFWE1VbDFPU0M5djZYaTUyWTZYWmZxRndCODJmQndPOVV1?=
 =?utf-8?B?WXBsMS9OUllpdGl3RkF0eEZtV0YreEluWnEzWlBZNWZkOGJnMVZxaEk1dmF3?=
 =?utf-8?B?SE5Ib1NySnJjWFdHdEtjc1ZCMnk2dFlyOWUyQUdpemJsUDArR3RodXA0UCtJ?=
 =?utf-8?B?UjlvNGo0aWlTbHNxMWIrcVVhdzN3N0VHMUdEcTk5U1J5YjQzU2xqN1k4Q0lM?=
 =?utf-8?B?WHJnTGdRdE9VUWpaNko2TG50UTJJSjdnVG5KUzNNZXJGS2ZlQXl5eFpmd1dC?=
 =?utf-8?B?KzFXZnRqSzBMMVEydUtoQ3doME1FYzlMVVppcVBnNzZpejVDMDZUQWtMTEZj?=
 =?utf-8?B?N1VtaGVRQUFQSGZPd0VxemVFUkhuZVBtUHZVanVkTzJ5KzlCQU92Rm5iV3A3?=
 =?utf-8?B?clVaVWJ5MmpPZjJEZDJNaGNnTUI1OVYyZ1g3V2lEaHVrTE45M3NtbGczSnI2?=
 =?utf-8?B?bTBRWFNvOVRHU1dlb2xqWGVvQnZGNDBueEZ1MTRaa0YvWVQ1dnRJYVlDbTdC?=
 =?utf-8?B?QkJ4c055SkZobmpZYVAralZuMHpCeHJMNE5SaWxTUCtmczBiMVRudm51S1hK?=
 =?utf-8?B?NjVsQVdYMUlLQlRxL3dpWnExWndYZWdxYmFCU1ZEb1EwTS9jWFZTbzMrRlBD?=
 =?utf-8?B?Tjd1VzVrODFBNk91RE1oUGxyWVkvYmYwd0Eva3oyTUZWRDRKYm1mOUpZeGxF?=
 =?utf-8?B?RkJBcnkrWGxlYVBmYVRyWmh6THQ2dU14aTB2K0JwZFNZcFY1M1IrbjhTTWJO?=
 =?utf-8?B?bHhOalFQeGg5YU16SlJFUGJUWGJRNVlYQ1lqTDUzWk1VQTRrdlMyN1U0RG5v?=
 =?utf-8?B?RGZSelE3TDE4OGV1VWtqZm5WVGlJVlVkOE14SzN3dG5oanNKbzZMVlNSa1I0?=
 =?utf-8?B?RkNwaWxteHp6Ti9yQUZrMFFmdHpLZlBvbGV5UW5JeDd4Q0N0enVXalNNeVNk?=
 =?utf-8?B?L05KdnFqUVpIcjdwSGJrdVQ3UDFSck1zT1ZWUFpnVzNmaHdCZzVIUXVkb3Ax?=
 =?utf-8?B?V2RWR2NLVXR4OGhzbUxqRTJzZ05iWUJmbTB6M0lGNnRxZ3RhREx5TUlEQ092?=
 =?utf-8?B?ekhSd2dDdXczZE9PVkx0elBjVXc5ZmhpVHBTY0JzU2F4ZHgxcmlXTCtEbkhX?=
 =?utf-8?B?MVBiaXpqUThPditmanovZ08zb3pMR1hWWmJYc3g5YThuc2dEUUx3Q08rWkhY?=
 =?utf-8?B?THNnUmdKTlpqSmhPMm1YVTd2YXFpS2FwU0Jxa1pkTVpNa2gzUjg0SkxOWDBS?=
 =?utf-8?B?SzR0ZmprT1JrL0JVMFl4SWlUbXNaV1JCRFhRK2srNzVteHFQRHJXNDBqa0dI?=
 =?utf-8?B?aFFVV0RHb281bHVMdEZXTnZ4WHJXUjR0YjRNU05lR0JXcnZlaitOeThFL1My?=
 =?utf-8?B?WURNSEZrNUhxRzNieG5RNlZzTmZVZytldThDUFpKL0xZL055Z0kwVzV0NmlS?=
 =?utf-8?B?Q3JyR041VlRMVnNSZzE5VCtTSjhlOExFNmU0Rm5vQVZORDZkeXNZNTh0NE9U?=
 =?utf-8?B?MTl0YU1ybGNqRkVPUzQ1SXYvbHF3V0dHVkpNMGMxcGJYYm1LbVFhWUl4Yncz?=
 =?utf-8?B?MUZuYXVYclRWMkFBQjQ0VTNoMTZBa1p3QVhCNzAwSk9QTnFLR2d1WHRMRThz?=
 =?utf-8?B?UmhxcTE1b1YrOTZCc0NjY3RGcVdRN2dYYVpOZ0htUXNIZHFFeFFWZXBZcFl0?=
 =?utf-8?B?U3hveTBLanVxQ01XanlUTVBuNUZGRkt5cHlmT2RXL2VxMGxXZXJaOVJLQisz?=
 =?utf-8?B?Y09BcEw2TzNMbXFOREQwQ2I4MnJaZ0JEcXBmcUowRUVwNnVqaHB6MTN1Undl?=
 =?utf-8?B?eHF6YklOUGtYUmVDUUVqcnZZRXZrTHVJK2xkUXdTd24wYm0yYUJTcStyNXhJ?=
 =?utf-8?B?bUUvVVM2VDBQRElEZGF6K3puYnpJcVVmTUNNUjBoRUlzOXlIbXpnaGhhRVl4?=
 =?utf-8?B?Q2hrdWZuZmdUWHM1Q0h5M0pFMGJ3Sld2d1VBell4U0Q0Ukh4VVR3YWNRdzR5?=
 =?utf-8?B?TDhIY1diSDQ4eUhXQktHVjIxUWNTd0FMVFhXcTk2SVFQVUFEYVptN2FoWjgx?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bqk/OLvdSiYs1NEzgj8tkMYlLMAGRjLkpzxEaYW8JNxDeVoH8qyxlmBkQbPAnAwOkvQwQTh3WtdwY5L553DlD9WpXNOjboUoskfmXKDf4vLV6xl/DW6KmlOvIVpJBlXe1rwItzA15QrBsNsGGg3jlfwpaFFul7Y4w+Dz1YALrDft/kS2qQgahvij8sutK/COQ0KbxmMzLBEyePJ4YIYsgdjpOW/PmScrPHY7TIghjR1gGWrnBKI2ELLxC7YbLjRowwyikywx8oJlfBddFfjt5wi0yBBxcNWskBBpnN9bWCc2zpQmCIbU9VRwMR1C51Cp5BgaNfQo4F8Ke7Eh1hnhT5H3mSRYwQWb/nRX28R8Z7T4u6FVd351guEl9HwaPsXctfKS4MuWBpJEXwcyvGVfuS417Q7O3HHgoHzO3F+XfjacdlFH99w0Ca/sup2vJTcv2IBuCW7h7iLFhrCFM314BxdVLbgC6QZdJWA97hgzunZuKG2haJ4iUvYnQllBDBc0VBrXYJkDBxFF0gd09TcU64WMoBnwYsLKwXBrPTLMt+8n/Wz3TeCMhnk3if2jLRn01fN9Ta3y7XM/1auRQ/Q7tEgMwwedib1jVD910ZnXnCM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195c261a-c26f-4c5a-4f5e-08dc6ba119d4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 18:44:44.8715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6f4uPICiIjp0HKrYJGwin3+MnUlQSSDkjhAYeYh4MkdsWvZPSGvDi23NWilqsEo1FQVvsY4mWn3BQNyRcJ7Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_12,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030132
X-Proofpoint-GUID: lgf-mXDhGi2gR1j0Vx0wBIc15doWGB9t
X-Proofpoint-ORIG-GUID: lgf-mXDhGi2gR1j0Vx0wBIc15doWGB9t

On Thu, May 02, 2024 at 02:51:23PM -0400, Scott Mayhew wrote:
> On Thu, 02 May 2024, Chuck Lever III wrote:
> 
> > 
> > 
> > > On May 2, 2024, at 1:37 PM, Scott Mayhew <smayhew@redhat.com> wrote:
> > > 
> > > On Thu, 02 May 2024, Chuck Lever III wrote:
> > > 
> > >>> On May 2, 2024, at 11:54 AM, Scott Mayhew <smayhew@redhat.com> wrote:
> > >>> 
> > >>> Red Hat QE identified an "interesting" issue with NFSv3 and TLS, in that an
> > >>> NFSv3 client can mount with "xprtsec=none" a filesystem exported with
> > >>> "xprtsec=tls:mtls" (in the sense that the client gets the filehandle and adds a
> > >>> mount to its mount table - it can't actually access the mount).
> > >>> 
> > >>> Here's an example using machines from the recent Bakeathon.
> > >>> 
> > >>> Mounting a server with TLS enabled:
> > >>> 
> > >>> # mount -o v4.2,sec=sys,xprtsec=tls oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt
> > >>> # umount /mnt
> > >>> 
> > >>> Trying to mount without "xprtsec=tls" shows that the filesystem is not exported with "xprtsec=none":
> > >>> 
> > >>> # mount -o v4.2,sec=sys oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt
> > >>> mount.nfs: Operation not permitted for oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls on /mnt
> > >>> 
> > >>> Yet a v3 mount without "xprtsec=tls" works:
> > >>> 
> > >>> # mount -o v3,sec=sys oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt
> > >>> # umount /mnt
> > >>> 
> > >>> and a mount with no explicit version and without "xprtsec=tls" falls back to
> > >>> v3 and also "works":
> > >>> 
> > >>> # mount -o sec=sys oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt
> > >>> # grep ora /proc/mounts
> > >>> oracle-102.chuck.lever.oracle.com.nfsv4.dev:/export/tls /mnt nfs
> > >>> +rw,relatime,vers=3,rsize=524288,wsize=524288,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=100.64.0.49,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=100.64.0.49 0 0
> > >>> 
> > >>> Even though the filesystem is mounted, the client can't do anything with it:
> > >>> 
> > >>> # ls /mnt
> > >>> ls: cannot open directory '/mnt': Permission denied
> > >>> 
> > >>> When krb5 is used with NFSv3, the server returns a list of pseudoflavors in
> > >>> mountres3_ok (https://datatracker.ietf.org/doc/html/rfc1813#section-5.2.1).
> > >>> The client compares that list with its own list of auth flavors parsed from the
> > >>> mount request and returns -EACCES if no match is found (see
> > >>> nfs_verify_authflavors()).
> > >>> 
> > >>> Perhaps we should be doing something similar with xprtsec policies?
> > >> 
> > >> The problem might be in how you've set up the exports. With NFSv3,
> > >> the parent export needs the "crossmnt" export option in order for
> > >> NFSv3 to behave like NFSv4 in this regard, although I could have
> > >> missed something.
> > > 
> > > I was mounting your server though :)
> > 
> > OK, then not the same bug that Olga found last year.
> > 
> > We should find out what FreeBSD does in this case.
> 
> I thought about that.  Rick's servers from the BAT are offline, and I
> don't think he was exporting v3 anyway.
> 
> > 
> > 
> > >>> Should
> > >>> there be an errata to RFC 9289 and a request from IANA for assigned numbers for
> > >>> pseudo-flavors corresponding to xprtsec policies?
> > >> 
> > >> No. Transport-layer security is not an RPC security flavor or
> > >> pseudo-flavor. These two things are not related.
> > >> 
> > >> (And in fact, I proposed something like this for NFSv4 SECINFO,
> > >> but it was rejected).
> > > 
> > > I thought it might be a stretch to try to use mountres3.auth_flavors for
> > > this, but since RFC 9289 does refer to AUTH_TLS as an authentication
> > > flavor and https://www.iana.org/assignments/rpc-authentication-numbers/rpc-authentication-numbers.xhtml
> > > also lists TLS under the Flavor Name column I thought it might make
> > > sense to treat xprtsec policies as if they were pseudo-flavors even
> > > though they're not, if only to give the client a way to determine that
> > > the mount should fail.
> > 
> > RPC_AUTH_TLS is used only when a client probes a server to see if
> > it supports RPC-with-TLS. At all other times, the client uses one
> > of the normal, legitimate flavors. It does not represent a security
> > flavor that can be used during regular operation.
> > 
> > NFSv3 mount failover logic is still open for discussion (ie, incomplete).
> > 
> > Would it help if rpc.mountd stuck RPC_AUTH_TLS in the auth_flavors
> > list? I think clients that don't recognize it should ignore it,
> > but I'm not sure. What should a client do if it sees that flavor in
> > the list? It's not one that can be used for any other procedure than
> > a NULL RPC.
> 
> Maybe?  After the client gets the filehandle it's calling FSINFO and
> PATHCONF.  The latter get NFS3ERR_ACCES, but nfs_probe_fsinfo() isn't
> checking for a negative return code from the PATHCONF operation.  If it
> did, it could maybe use the -EACCES coupled with the knowledge that the
> server had RPC_AUTH_TLS enabled to emit an error message saying to check
> the xprtsec policies (but I don't think that would be as definitive as
> what I had in mind) and to fail the mount.

If Linux is the only implementation of NFSv3 with TLS so far, then
we have some latitude for innovation.

I would like to hear from the client maintainers about what they
would prefer the client user experience to look like. Then NFSD's
behavior can be adjusted to accommodate.

In this case, Steve would have to sign off on an rpc.mountd change
to return AUTH_TLS in the auth_flavors list.


-- 
Chuck Lever

