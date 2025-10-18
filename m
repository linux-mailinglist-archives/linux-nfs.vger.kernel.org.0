Return-Path: <linux-nfs+bounces-15369-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AE9BED87E
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 21:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F50585FB2
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 19:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722D87263B;
	Sat, 18 Oct 2025 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T6iIobVf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qasa2+oo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6328312E
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760814754; cv=fail; b=fXAIoP/v/+laXrOsxbRkddThyXuwWYLWeklsAfxxiftVVLCHDk98QcmJDu1pGNWMDpqo1DYrrTi8HGkD5sAl9xtigdNELgn2Kb6YGFtvTM+uO6jHE5ldystP8mds3IKYKSBqQv9Ay8ApTDrt1nPBxTqCN+jpaYrAKWB0mGmxg4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760814754; c=relaxed/simple;
	bh=/dhekrWeE0ciYsMSW2lJZsDUnAc9hkQZRLJTduxx7+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lHtzUode+GGWUXuPsQoYZwNTnOn/G447K6hYUP3suY2LZgYxiatqd+3pK1t7dpAikJeUDL2RUI3DzNZDiI+uhPw9M4P6SVLUD/XnUrzTPfD3DKtfFy8tqL/mTLmSfgoplGHNIM9GFZ3ZN3qbKG0CXss73IGgJA0VwnH7jJMYYBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T6iIobVf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qasa2+oo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59IFWmw1025020;
	Sat, 18 Oct 2025 19:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4Ps91ULpm/sPbDVzbW9xRrAnsTl8LpiJsP0+XYGpDto=; b=
	T6iIobVfz2/JDyNyFkU5p+a2TkTLu5ofD0ycW3xFceW0haAX02ERgY0pf5xUFRDD
	TyopmKbSnqubxMGh5juR7RtTpyQ3kuAzLPiMD5htICAM6YT9D8U10aJtzcsApvpc
	BZuBbqPe8/2RTef3dEPM9aaptbB+uMKpAW7gTtDttIVA9VEqgxR/3t5Oq1AXjH4C
	sXY5N5recseddVgWBXPFFtXKU8cnxLB4nVOTDv0iQ0JMu0nVf9QNSXA2znBU/N6E
	GD60p+dA4eI3okWlwN3QOyaxx0bZ+/Zqz5My9LuBOWAO1Z+G7PNegeboyBJOUwMn
	2vJitFro6PEwFrtlMAHyhA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v3070fpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:12:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59IJCCVD034892;
	Sat, 18 Oct 2025 19:12:24 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013030.outbound.protection.outlook.com [40.93.201.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bafm5r-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:12:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMlzdTptZ6w2n5uqrzZRpBAHLhmWiH4F0BZ7pwXT6347p/RHTTDAyjfTDtTaAj5kdiaO3pwcUtv9XxSaa1S9mstZd058XTkEgsY73+TP8442D/e/O0BPvCTfHD99I4oZUN6kqFb4/F3US/SzH+bGbz6rIa5GYlB235pfxoj92ZsNoymQ4EJgS+JSKo1UvnnNJfL/yNuuHU3PlyoC3IT2Te0lTvkHdDX2qQkoHM0oUsHw4jAzJ20UnwOMxvJi838on2suEzPFFnO4IO4PQua2D1LLL9XA4sMOyNmnFCzoZQqoaXMzqW0QCLbVEYQk4NaXF3jupAatvONhBKF/3YG+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ps91ULpm/sPbDVzbW9xRrAnsTl8LpiJsP0+XYGpDto=;
 b=rDDEnRyawsSDUj1qU9NZ0IbvOJWct+D3lB4lJ1jSXQwA6pbdf+VsOitnFZT3NVqgLk61tIpoEtyhBtPWVO+oO7QVV1gwCtR3RX43Agg49wxVlwGcc+9mUSiTFKPO3x1nianXPADUWgpdQKPNgbrlzkWB4vWbbMQrRTLEjR1CAnJpkmtSS+3iz11JcJZOS61IZD3tFxqIth35rooenxWQgGvFIgTP+LSbUkH/3zdt4rptn2C8nkZYBVLBiIwsGrZMFvTJJ2DRyCg3fnyuzxxTr/b+OgO7HGCYofrQtcw/Aec8r4sWW8gaUwiLNZA/K0D7AuahM0J/n9YOWalSCHq5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ps91ULpm/sPbDVzbW9xRrAnsTl8LpiJsP0+XYGpDto=;
 b=Qasa2+oo1UOJL9Z8bDPbIySUqE7WLuePlBJgW3+zauztAJA8bTC9XfugWu5+CWyWfT6ZMz7FJBJDExmXDZI2NfPgPya90bJ+JtOXX1/xA7kHXamKTrZ4ui27m0cpprvI8EjAaynI0IMEPiWbCI0rfFKIx4M/VTrnvl2cRoEsG3I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7054.namprd10.prod.outlook.com (2603:10b6:510:276::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 19:12:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Sat, 18 Oct 2025
 19:12:20 +0000
Message-ID: <95073b7c-39df-4c5f-80c0-74655a7289a0@oracle.com>
Date: Sat, 18 Oct 2025 15:12:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] nfsd: discard current_stateid.h
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251018000553.3256253-1-neilb@ownmail.net>
 <20251018000553.3256253-7-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251018000553.3256253-7-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: 899df567-c192-4345-c518-08de0e7a428b
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZmJmdW5CeXhIN0IrL1U3bmNsTkdjMURTMVM5L0NpY2kvMDhMQnhHMjdUcG12?=
 =?utf-8?B?NDR5bEFxSEZoSFZVSVdCZS9sRUhmR28wOTZ5dHZTUEhOYjBJQU5KdGNPRVlW?=
 =?utf-8?B?bktseVM5MXRTQzhhVnJpOHZSVlV4Qjk1ckVEa0VuV1BzVzU2cThDV0dGVXJr?=
 =?utf-8?B?UXgxL1VnSkNxNGpVbDhoUGJKaFArRy9qVGwvYjBoM1pFU0Q4MytGMmFWcHhM?=
 =?utf-8?B?WnZpR3EyaVg4eXBlem5oM0N3RHlVM3BXMmNudHg0cjFRYWxPb0dEdXVMRjdq?=
 =?utf-8?B?SXZhZU5Rb3BHTDVpYlU3RmFQNUFYcnBYd1V5M0ErWHZqa2k5aHJGWDlTM0ow?=
 =?utf-8?B?czhXM3FxL1NTYjI4NzFvUVBscG9admNoSTg3b1p1bkhCeUs4UXRFT2hleVVX?=
 =?utf-8?B?US9KRnA1UlREOWZhVis5L05mZUVkcHlOUkJJVFZKcHlVd09wWXdLSmI0QW5r?=
 =?utf-8?B?S3lzRVFJZlEvdHFJeEM5TFg1Ni9seHVFc0s3VEk0R21vbitQU2N3NG5KTCt5?=
 =?utf-8?B?bzBPeWlUU2ptUjlaUHZtc0Z2b1hHN2dOcHJpU2tNSU01dVRtVVJwZWxsbmd1?=
 =?utf-8?B?T3IzM3VWRDVDdXlVWTVlMmxiY2VjMEtQWm05akNSRGxEbUNWSWdPeEY0UTlX?=
 =?utf-8?B?ZVlGcTBoK2NDN2plajM1OGVrT210UjZUTEtKTFBGU0pnVndteFpRZEpuaGs2?=
 =?utf-8?B?aCtKMC90OGdsckQ2dTcvKzgyVnE5OGJRS0NmbjMxQlRnL3EyTXF6STFkRTlC?=
 =?utf-8?B?Vnp2SzVDd1IrNXdmekhVVWtwY1VXeTlSTit5b3d4TzM2b1FqSWZkQU95bkw3?=
 =?utf-8?B?SFhyNDJUMnBCWlRLTU1KWVlNM3lnT2lxaFRJbWNqUFVlOU1YWTFuK05mQTV4?=
 =?utf-8?B?UEozeXJoRmliSDMwZ3Z2WWg1Sm0wZHVHVFJYbUZoYXFJU2dhUFMzKzRKakRx?=
 =?utf-8?B?SVVOYlB3eFN2UFVIQTh0eGxvUEFhNUVGeHI5eXlQNmtzeUprRVJXenZtZzJl?=
 =?utf-8?B?NWRER0hiMERpUTJ4U1BlQ3lqb2lKZ0NEcVZMR3RMODFQenpvdE8xZGU1VGpx?=
 =?utf-8?B?QlNXdWVXVXBVeGRrTDNKRmVaY2xEMWtYa3FpN2Zrbyt4c0ZmT2Q5eXp4OUhn?=
 =?utf-8?B?eXBOZW94S1U4WnRNTHA2a0k1MG9NSFZoSFErWndVRWswblMyZW1DVzhlK0NJ?=
 =?utf-8?B?U3IzeFdCckxWRzZTWWVpVjFzYXlNQVo5YXdyVUNjSEFwdml5RFgwNFZwNlpX?=
 =?utf-8?B?UGVlcStpaGYyWTRhdFlGWVUveVRCR2xSbDdkbFJ2RWxoay85YWRVeTdZTDBT?=
 =?utf-8?B?TmlUMmNsT2JtRmZQZWhPWHZTRVRCNVNyVWU5OFFrdDBuOEN3M2d6Y0NnNGtO?=
 =?utf-8?B?emdyYS9xdmZpbVMrWnFmblNsckJLOVp6THBhNHd2UGZ0aUQyYTV5Yk9PSWNF?=
 =?utf-8?B?OGU4MDF6Y3cxMURDejJ3M0V6WWZ6Y3pMQjQ2WHUxZWpVYy9FVEduWGRZTWpV?=
 =?utf-8?B?aHBYRHV0YnJGQVVNc21zVGhlczRtM1BBM1hxS3V1SXJ5OFgrTFludzdLZXIr?=
 =?utf-8?B?cU43MG9PLzF5dFVQL0ZSd280NzRHbi9kLzJuenZDcENBWEZKaVhPZFlPL3RP?=
 =?utf-8?B?eldBbU9LQUNvTi80bmpDd25CeTJjYTNzdlVHbnpJaDNKcTJqSnlhblVHUnd5?=
 =?utf-8?B?RENjdTJ2WFMzYjBUQW1CZGErdUVZOGxpeEZyMU1WM3VDQVVUMkNQMmJMbm91?=
 =?utf-8?B?eHltRFlWODRrK1Y5aUlpMFYwMy9jV1hTWWp4SUlXWkh1ekhGZ0gxU0lQR1pB?=
 =?utf-8?B?YnNSbHZHd2xveUNGczdkdW1UbFM1M3NzN3pzc3hqeGZXK1ZwS1F4cStEelA0?=
 =?utf-8?B?ZmZ2YVEwSitOT0RFYjRDcjJZM3A1WGRaTXVkcEVWcHNZeFJDYkVsTld0QWZ5?=
 =?utf-8?Q?C3Q+TN9s5A1vyupbQ4TKtdz7gdieZs/A?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cFpuQ3JMdXl2dWlYbm5qcXVLVDZUNVBHbDlFY0wvQWJpdnNZYUZsVkdtYkhI?=
 =?utf-8?B?SmFGbGJUT2l0T3VVUmhEbm9NOG5MVWhpTkJLYjl4ZStZYVk5MkptMmdETUVV?=
 =?utf-8?B?M1JPTXk2ZENSV0phQlZRT01qYllDS1FOemhTVlgwVmdYSHl0NXJEUld4WXFt?=
 =?utf-8?B?MmFrNFpFdFZodXRoYmFDeFpvbTVGeDYyeWJpQzdwRlN1TzF6YjRrcUIxcnNO?=
 =?utf-8?B?cEMvWGVNNDhXVmE0c01mbTFWZElhL0EwZE5PTi80bVdBcHBKQzBtd0N1Njcr?=
 =?utf-8?B?elF4QWpEN2Z5OXpLM3NkSjY2YzJiWTZNMjBZTllIK3cva24xSkh0UDlOeW01?=
 =?utf-8?B?dzJZZ1JhSmNSenJ5NVJlZld1UEFua2pPYTZ3ZkZKVnNhUHVwTHR0UmpYMlhM?=
 =?utf-8?B?aE5nb3lweDY3K01kUTV2ZUEvV3pMcDNZUHE0aE1GaldoWVhCRVNId3Uzc0xU?=
 =?utf-8?B?SkpGVlMxYmQ2TWQ0dkhaVWVoWkE5SmVCc3RWSVl2bm5rU0pkQXNGc1QxNmlr?=
 =?utf-8?B?RmJqUC9DSUpyTzV4V3BtMGhTTTJXVjRQY1FnMWRhTEZqdk8xUlZscWViRzh3?=
 =?utf-8?B?WDlqbzZVK2pxTmNiaXRUQXNCVjFHRkNHOVRRWGgyVVAzZ0t4cXM0dWh1R3Nh?=
 =?utf-8?B?c0E3bElDZXh2cW4rK3BRazgra0YxUlNrcTE4dWFyekJ2OVNzcERaU2ZCWm40?=
 =?utf-8?B?eVZ0RUtRSDV0YXNYcXRUNHZyUUFXSDFtVmdRbEV0Q3oxODUwUGU0Z2pucWVn?=
 =?utf-8?B?UFV0Sk9idTlhMTZtWDZESVJnclJiWEIyMTg5VFB1bHF0MDZyR0N4a1N3V0hY?=
 =?utf-8?B?eTJuQVVHK0duQ0w1ZThHYmVwb0hZZGxsckVFalhaeHJvQUYrVC9Eb1QyeG4r?=
 =?utf-8?B?amN5OFlEMHpuUDY1encxSVdxbEt6NGVDT29BUnBrdG94MGZHTUI5M3g3QXFj?=
 =?utf-8?B?SEE4YWkyVzdTZ1RtWFBIV2F5dzFSZ1ZCS1JDcU5RRUhHdXhjNnF3cWdPWEpD?=
 =?utf-8?B?MWlBWUl5YUlQY1RTVUtnY2JqZmJidmo4VndWRjZHcUxwY09XTUs1K0dSVWM3?=
 =?utf-8?B?Z2xMckFRQVNQV21jZjVXeUhKNHEyZ201VklhYlc4ZWFsVXQyL05meEFFd2J6?=
 =?utf-8?B?a3ZYVFZ2TlFXNGNkOGNnYThmOVEyUWQ1Qkt4bG9SSWpCRVJhdlc2aGk0ZitV?=
 =?utf-8?B?dkJYcGtySVcxVmRtZVA5eE54QjdUeEVCUmVXMzBqemhUTzhDR1dCemM5MXRZ?=
 =?utf-8?B?MlZ6cTB0dTRwMTJuRHdLN1dvS3RXRC9oN1oxM0pnbzViSWhhUG03VlFMd3VI?=
 =?utf-8?B?NnVVdjVKNGVWQ3A1S2RCbFN0MStpZ3RLbnRNTzZYSzh6WFlBOVBDZXBPNUJ6?=
 =?utf-8?B?QVpMZDIyVDBvMW5SZDk0WTgzVWovb3BWbTl3SEZsZ2dwKzA2RGl4dWpBSU1W?=
 =?utf-8?B?MllWZCtUQitaeXFwOUxRejV0U084T3B0VEoweXNCR3dFTVJJVS8rblQyRGhO?=
 =?utf-8?B?a0p3azdZN29KR0pWbzY4RW9seGRGaXAyb0FJRXNZZU11NzJoTDVoSnhKQ2hU?=
 =?utf-8?B?Vk5SZUJTWjlRTERUU2QzNVpVNmpSV0Z2U0hVOHZOUjY3cEFsZGdHV1BHTTRv?=
 =?utf-8?B?RVRkWnNibmJ5Q3l6UWs4Snh4MWMvRWNRa1d4Vnd0NERHc2tBYzQvZmZ6dTNQ?=
 =?utf-8?B?K01WcTBCYWhmaDRnaGdrSzJ3c1d2YVlHL0VhT3h1UkNFdk9sZmgzYkYrQTBI?=
 =?utf-8?B?QlBENWRwK2JnVnFXbWhiR1ZqSVZJRmFhZDM4b3FrTmpRMGt6THl1dEEvemdF?=
 =?utf-8?B?L3p1Vm8yVG5CZnpTUEdndU9nN0xab3diWW42ZmJqTXNSRko0Njg0U0k5aWlR?=
 =?utf-8?B?T0p3cnQ3a3BDNS9OV1hLTjZyWFFDMWkrTUdYMFJESXQ3NUxDSWpHTUg5Sjc3?=
 =?utf-8?B?a3dIWEVHZzNxcElXNjFSNkpyMllFR0p2UkR5dmVOaXE5b3hTRXpyampwR29r?=
 =?utf-8?B?aFlGQXFWczQ1RlF5RVkycjNGQlhCa0I0eWdXNWEzNzZRZnFNNFNYQ3V2c20z?=
 =?utf-8?B?cSszenB1MWNYUHZqZE00K2R4MTV5ZHVzamVqWXprMEtqSzNRWU5RMGlMakt0?=
 =?utf-8?B?OVMxdWYyQXpEWHBQbmxHVjQ0TWhIMHJaTVVPbnN0YnJVWmR1Rk5MdzZxNVB3?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uS1wHQeUSgQzd+uefJVZ5Ojp9efk5PsJ8Cps0KnLS/TdtSXaARwCWU9o9QdF7UlCusyTccfrP61dxBsEezaXhsQQFWUbOs7n5iXafcgQmJc0xJ99pK3a9eU/Fci4qB7VmoRk0NMM50FESGoDzSyN5U7b194mZOwfEsepBrlMhlh+4hM4HRO0aB3cI8X9hq3pv69KNZkDL24uJ4Ypt0YaoqDP82MdwK/EEZstBx3e5cG8mU7P3he4YsI/t/xHoFxkE3HPxdjhEqi6rcoGvJLGwLKxGeE/q3P5XpX3YF6nzo0H3aODbIgCPeqAl7XGCsghF0XUx20Xgx4jj8K5U7l+PWtapBbH2wdIUiMtA1xPw4TB4WzNDpn+zjwIemMuvrA4zmXhithG70izewKpZTmMB/d2zWfLU9DGgdZsALPwSaG4SHltqfjdAtNjEkDzIVU6u1A76maLmzmnEoxA73WbVdjk4WghiKMTpZY7ZrQ/IjyDYN+pGIqRUPt9RotJ52MpkI9+svtsO0YOrAeEPzU5GPyNVncPvzfQsOhf0LoIyboP6Q/zU3w4D+kebvpRhjyVFJsf8CI/M0vkFWgX4m7puTpNsX/K9rgpTItewaHOF+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899df567-c192-4345-c518-08de0e7a428b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 19:12:20.0261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l04b2lWpMqgKxPbnmvRoPk562CfHTuDhiGpdx9aU0mN+3ZXZl3kfPYOJFNH3XlGmOA3VaB9wpIX7Pz+bkIxFwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510180138
X-Proofpoint-ORIG-GUID: ja4vkP_oZrYVkmFEkmLDW1l7X_OiLypv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXwL6Hn5tUKJfr
 RRWAUuC3twL1cy1UM3SJp+5U//tGzJE7DXEn09tbRvVdhucP/l1u/KmgfB86vlgxlmqu1I+v7u4
 xkPZZfcIOLv9nhagDEjpusd2gCaXvs9qmHo5mQDTNWPO6KDs3dJP5WfCn77AzzQHY0AtJxbrD9d
 gnsiKRonE111jYGb89SMJ+10gf8zthDz5JQmiaBJsQQkmPtRGjFQjIqilKxmvT+M30kOkOBiHr1
 9NhVwc69zXTN9pVkbleIaK/bd7VW+NSRwvjnWVs8S7Ei4BUqXp0Khki3F5MYlie0ZL8GnQSPGNy
 ItOTnXcWVJCZhq3KAOPOb6ppoj1mS5UBjGq7xaP/nnKPtMH17bxfgEWhRFvkO4gkzG+zQg9Yruc
 PYg/b4yk0K2/rT1glXHefosfmtY1syF26C+9oTu6ehwgDQTgje4=
X-Proofpoint-GUID: ja4vkP_oZrYVkmFEkmLDW1l7X_OiLypv
X-Authority-Analysis: v=2.4 cv=csaWUl4i c=1 sm=1 tr=0 ts=68f3e69a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=dpoOVraXmkD51IMECHMA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12091

On 10/17/25 8:02 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> current_stateid.h no longer has enough content to justify its
> existence.  So remove it and incorporate the content into xdr4.h.
> 
> clear_current_stateid() is moved to xdr4.h and made static-inline.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/current_stateid.h | 12 ------------
>  fs/nfsd/nfs4proc.c        |  1 -
>  fs/nfsd/nfs4state.c       |  7 -------
>  fs/nfsd/xdr4.h            |  8 ++++++++
>  4 files changed, 8 insertions(+), 20 deletions(-)
>  delete mode 100644 fs/nfsd/current_stateid.h
> 
> diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
> deleted file mode 100644
> index 8eb0f689b3e3..000000000000
> --- a/fs/nfsd/current_stateid.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _NFSD4_CURRENT_STATE_H
> -#define _NFSD4_CURRENT_STATE_H
> -
> -#include "state.h"
> -#include "xdr4.h"
> -
> -void clear_current_stateid(struct nfsd4_compound_state *cstate);
> -void get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid);
> -void put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid);
> -
> -#endif   /* _NFSD4_CURRENT_STATE_H */
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 7b6a40cf8afd..bb432b5b63ac 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -46,7 +46,6 @@
>  #include "cache.h"
>  #include "xdr4.h"
>  #include "vfs.h"
> -#include "current_stateid.h"
>  #include "netns.h"
>  #include "acl.h"
>  #include "pnfs.h"
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index dbf5300c8baa..635c7560172c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -50,7 +50,6 @@
>  #include "xdr4.h"
>  #include "xdr4cb.h"
>  #include "vfs.h"
> -#include "current_stateid.h"
>  
>  #include "netns.h"
>  #include "pnfs.h"
> @@ -9093,12 +9092,6 @@ put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
>  	cstate->have_current_stateid = true;
>  }
>  
> -void
> -clear_current_stateid(struct nfsd4_compound_state *cstate)
> -{
> -	cstate->have_current_stateid = false;
> -}
> -
>  /**
>   * nfsd4_vet_deleg_time - vet and set the timespec for a delegated timestamp update
>   * @req: timestamp from the client
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 7218c503e5fe..76b828a50ece 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -196,6 +196,14 @@ static inline bool nfsd4_has_session(struct nfsd4_compound_state *cs)
>  	return cs->slot != NULL;
>  }
>  
> +void get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid);
> +void put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid);
> +static inline void
> +clear_current_stateid(struct nfsd4_compound_state *cstate)
> +{
> +	cstate->have_current_stateid = false;
> +}

What's the value of keeping this inline function? If there's something
interesting that should be documented, it needs a kdoc comment;
otherwise, can we consider replacing its call sites with just

	cstate->have_current_stateid = false;

and then removing it? Thoughts?


> +
>  struct nfsd4_change_info {
>  	u32		atomic;
>  	u64		before_change;


-- 
Chuck Lever

