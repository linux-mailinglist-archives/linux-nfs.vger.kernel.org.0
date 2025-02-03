Return-Path: <linux-nfs+bounces-9837-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C459A25C38
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 15:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BFCE162B67
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 14:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC08A2080E2;
	Mon,  3 Feb 2025 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RQPDhJSe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IKSARjcz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFBC2080F0
	for <linux-nfs@vger.kernel.org>; Mon,  3 Feb 2025 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592608; cv=fail; b=jAz6vTNcl8utNBIxl7zZQCaF1dP/KdzwL9WGrd1qKsFTacQolKm4yaJKNQxAczI/6/5IDRP+hV8Q3wuDDiP29AO9HVeoYls7wFGdChBekFerzmeyyiNJcei727+w2ECCLVFcU8ITlDFYamsrb3nwQvR+Gpua3Ub0nUgiVexcHqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592608; c=relaxed/simple;
	bh=GL6Xzav9c69GOL1q9SaGZOpRxKD9C7jjGU662Asx1I8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gxc6eBknGUXn+DUDlkaJtcG4z+6RiLPoBWaLkooAF4ZXWN+JcTLvAm57ImQOYcsx/Yx1E+1pPTg4ufmVQrYKlMprqXFSVjvXMBAbB1bvt6xEne7zzTvGdbMXeSrbSLoKofSG4C14Nolilcrtuix0UACP++3MQOriDgNALvn4QaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RQPDhJSe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IKSARjcz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513EBqWC008097;
	Mon, 3 Feb 2025 14:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lqqiXOJ2fzIh87t2fPW1LRJTL/BBaz0zgLmCUnCPHUg=; b=
	RQPDhJSe3wwAS8hTro8/0c3Y1cZiqVfwP4BvAYQRIbzP2pegh+2IYsVtD1RiNw/Q
	7g4IVhMsw6mvlucbu1QDKD8mS4oBG/VgqURajWhTAjPUjrPyDMDG5MAXC+7Fwkhm
	ORgb2no7lnRpKm16yXNx6656ucMiqGxGdrPR+hAp2JdJAQjyR3PbQ5VwtVsCIhZv
	2dNI0+0wajH9mViquH93ChCvDHmLK55HP+mUqr1uua7vw74P397dyiNjuj39h7zy
	kr/vM0vtlGVihxjXR4cq1hXyuLR0owyrWczpGB4zXhS7UO9PWb8u8SXeQj/ymCoZ
	trPfxQBe6QFFoewso6O9Lg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhsv2ba6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 14:23:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 513DxMuB037880;
	Mon, 3 Feb 2025 14:23:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8gfp85w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 14:23:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x38qcKyOyDXmQLgdVJmsxBH3BdgGEs7QzVVVVn/fFXvBFcC9Clyh4SzAFMcQvjAVeToYPTUSKRGKsFotEH4o6H+4vBoe1bKGixXPBLIr2Ive9538B1pRu7hu/yQ3WDsevjtF87I/i8eeCVIEe90cVvRcr8O3POpm4Rj0GAmw/v3nhKB6e4tgqRwx52yeLN9DXTWigdEkLPCrOAawW51S0QBe7Wc1nnlI8B6RpVj9obrOPL3dRoKqomo3gtOO0sh5DKRmBsze15yeGpWV93Q4X1M923+9tmMSAgSR4MIL6am1O7Jt4Y79/4DQQ3Vt9g1GOukJvFO97dBf3hQ02t9mXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqqiXOJ2fzIh87t2fPW1LRJTL/BBaz0zgLmCUnCPHUg=;
 b=XU5oqA4hH4UXmsBTi8W3JSJiS+7UOERx6qzjCWafbBWrQLT9oH/LHtg0VNpvM2fo2WnCO6Sp0PPnrBPP4kh3c/mdFHb2KTocTBnTN3FUXkAk6HRlaiyraM+q1E/ufc+cU4MZQ83cmnCIyeY9ZUdRHY2s3z0zXxh6t9bWJKG1XTwcBpFVcz4OcVAgHNugkTxvRw/Lm6wrzfV+HdpOBPer1vlK0rArPJQftIehwmrN5tE38t/jD47pKL6FCP1OM5YpkHj2v/IzcVUTyMcLdLOfCdnWaJ61lRlM4M2Hghoh6LjtGmdBJZYl6bem0tbAJhpiMWHUTyLwkf0ob2nENVcKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqqiXOJ2fzIh87t2fPW1LRJTL/BBaz0zgLmCUnCPHUg=;
 b=IKSARjczY6S46yqzmkKCiVCUl5zlWJ08Ok1YKn7L8n6aal8aI0xyBD719ZECRGl8IDxZMe7zmlmOKu6GAWzzNfyg9bzUz3IUN08ahfZiz0hmqB64RO/asuaDz2zCOCh2cXNo9pks7FRMHKV0RZcUrGGFHXQ2sVQCgbu+7h/wTIU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6548.namprd10.prod.outlook.com (2603:10b6:806:2ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 14:23:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 14:23:00 +0000
Message-ID: <5edc9040-a69c-499c-befa-2526f2750d0e@oracle.com>
Date: Mon, 3 Feb 2025 09:22:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: `rcu: INFO: rcu_sched self-detected stall on CPU` and spinning
 kworker `rpciod`
To: Dai Ngo <dai.ngo@oracle.com>, Salvatore Bonaccorso <carnil@debian.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "it+linux-nfs@molgen.mpg.de" <it+linux-nfs@molgen.mpg.de>
References: <76a841e5-4e3d-4942-9a4b-24f87d6b79a5@molgen.mpg.de>
 <ZqVjVEV5IF_vz4Eq@eldamar.lan>
 <47222A7B-6B89-4260-AA16-EA7E7EAFBD68@oracle.com>
 <ZqjaX_uJqsJiCpam@eldamar.lan>
 <7ccb2a39-bb32-47f8-8366-b4d09895593f@molgen.mpg.de>
 <ZsBhuwLnejLo6iip@eldamar.lan>
 <6BEEE588-B7B0-40C0-BE91-4919A71ED052@oracle.com>
 <Z5z3hBaZtUM0BQ1H@eldamar.lan> <Z590k-vpFiGl0OOZ@eldamar.lan>
 <196a87b2-94ce-46bc-b6a0-c9c65f4ab34c@oracle.com>
 <e5348863-cc6b-44e5-84f0-6d15bf7fe907@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <e5348863-cc6b-44e5-84f0-6d15bf7fe907@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0051.namprd18.prod.outlook.com
 (2603:10b6:610:55::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 57dd0c02-bf27-4aeb-18d2-08dd445e435c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akp2Y2VKc2t5RGRpM2RuYWlRNERiRno4SmxQT1BEc1h4TEoxL0ZqWFpRZEhH?=
 =?utf-8?B?ZGl6eDUzWHg5cllIQVNyeG12dWFtZENic0txdFhUcGJrRDI0bmU5RTdRa0Fy?=
 =?utf-8?B?a0xYN1B4VmJ0d1lQK2NBcUtGV1F1NUY2UnY5b2lFaDhTL0dBeHMxSHhYdXVq?=
 =?utf-8?B?N0R2amEyb2FyK2JLMG1jWUxCMUlsUzNSN3lKZ204MnFkOEVVODBIOEpNYmYx?=
 =?utf-8?B?SWd4S01MMmxZQy9zQjk5S1dTOHJjcEJNbHM3NnEza2FRUE45MEl3U01nNERi?=
 =?utf-8?B?SXhqZldjMnhWNkx0VVhxM1g4bFdnbEdHbFZCeDdkWXVlUWhzWTBVdTkzcGFT?=
 =?utf-8?B?bVlhYXFEWGZDMzl3ZGc0bUhITlZzTjZCdkZBYkI2TitxbXFNcFZ4a0tRMkpv?=
 =?utf-8?B?NTV0eTd5Q2xDc0VyMGMxdUhHdWgxRzRiS0ZWNjJvdzdCUTZEaU0wMTYrY2lE?=
 =?utf-8?B?YU5rdVNNbFRzWmFwK2MrOHZVLytrbkF6MmFja3dRL0h3eG10cTdDUU94QS9j?=
 =?utf-8?B?SmFTSFdJMHRQS1VZQmhIV1diMFIxa01tbk9CSi9PRC9keXJJUWRwQXNzTDdk?=
 =?utf-8?B?Y1JmbHU2em1UalI5Q3BnbjU5bjVEdXJYdnVjc2VKbHQ2S1Y5R3dLMXlFNC9x?=
 =?utf-8?B?aVNJSzg3NXZwWTREK0RkZWRtMmsrRnZlUlJUcFZDeE1kc0c0amFLMW10bTA2?=
 =?utf-8?B?YTU1dC81Y2ZsQWJZbUFtengrSUd0OUl3NENoQlEya2p4SDd3WGNJeUhQZ0Jp?=
 =?utf-8?B?YzNySHBQem5KQWxYektvVmI3eXVQTUlPT0lydlM4K3E5SFVxc01meWJCQzdz?=
 =?utf-8?B?bGRVa0gyd09CUlBrMEx1bHRaVnJjZWVISXRjQW5ETWVleHZNY2U5enlIUTBU?=
 =?utf-8?B?UjhUUGVlRS92cENkQm83UEppSWo5UzVSYUl5ajFmV2d1MUZKd2tCazVQZnVn?=
 =?utf-8?B?aTZCRE8wYXNmUE80SnMyRTJscm9VMVhaTWZLbUI2Ylg0YjVIbDgwMlhvbnp5?=
 =?utf-8?B?cEk2VGtWNm5XeXZXRlVhbWE1WEJPNmNsWS92V0JUbnZhL1lEUHl6Zy9TYTEw?=
 =?utf-8?B?aW9mMjEzWXBxNjFLM1d0d05kWTlVU0N4V25nUm0xTHVlV2hFOUczQ0ZkNVNV?=
 =?utf-8?B?WC9mbnRjOHp4TWtWdy8xSVp5NHYwV1BvQlFhUzd0eCtESk1GYVdoVzBIVnBi?=
 =?utf-8?B?TnpiWWZqT3VCTndHSkgvS0RFRXZZSklNYThXbC83N1lham82cURRQWo5UnFj?=
 =?utf-8?B?YXRoQ2xsa0NzL0h4MU1SMXFVbWxaVzc0YUd0c0VmV1FBeEVtcytrcHVWWExX?=
 =?utf-8?B?NlBmakhibjN2WjRZd2ZjSzFaZ1FGSzRkZllVT2wzN3l2SGUvcVpwRkw3QlFp?=
 =?utf-8?B?V2kzMURrcDNjZUU4LzM3cW1SM3JxekYrWDdla1NReFExS1BSOUtWRkFXdEZr?=
 =?utf-8?B?c3JvZ3JUL3luVms0b2c5K2Urbk02L2NxaTBUdjdHNmp2Tzl4L0x1LzdkVitM?=
 =?utf-8?B?Wm9KZ3pFOTBFSHNxWDRNQVZVZHJxeklVUjdsQ3dGelBmNHY1bTZDV2JRTGFI?=
 =?utf-8?B?YnlJTmpwOW5WZVp2MVJORlZUbkExeG9pMmY1aTZ1R0dob25HbEVramt2cFNM?=
 =?utf-8?B?ZzJSQnlZMll4RlVwSko5dVNXemNhTGRIYjl2YWIvUU1xZ2lld0V4dURCYmFj?=
 =?utf-8?B?Ym5SMHcxVkgvTFVXMjZ4aFZtVi9hTW9tb21vRVlSMHA2c3dZY1BLM0RuNW1y?=
 =?utf-8?B?eWt2WU5kVGErTjcyY1pmOVBPZ29ra2t3a0tQcEtqQTErZUhKNXVCTHpFUFdU?=
 =?utf-8?B?eVN4U3lyZm5Bdm9UeGJIQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEVPc3JMSFV6TU9PckFaRnJZQWlEalhWemRTZFhqaDlOajlFQ0ZNeVRPUUx5?=
 =?utf-8?B?Mys4S3lWMkdObXo3SytQTHc0cXpwOGpWQ1BSTzkyOE5kNWwxL09QbHRWNW11?=
 =?utf-8?B?ZDBOSE9FS0tDVUdTUE9KMDdWb0NleHlHVG85RlZ6U2V3KzUrdU9JWW11ZjVX?=
 =?utf-8?B?eHh1NDdXSGV1V0FFMUswZnZZakRtd1h5UEhYQktVajlqUGhOMUNZNnE1RG9i?=
 =?utf-8?B?eEVQYkhtZGtXME9QSGkveWZ3OHFtT3RaWHFhalZSSDZ6U1NGd2hrQzltZEVa?=
 =?utf-8?B?SG5yQkYrRm0vZzN2eTBEb3VFa001LzREOEphMXAvSTFOTmtKREV5TzVNdkVm?=
 =?utf-8?B?elg0TGdKUnNZYTBIRG9kVTlpRFRiTUZBNkZBaWFPK293SVJBWjFaQy9kVFhn?=
 =?utf-8?B?eDVPUC8vVkFvREhZRnA4NWhHWGF1aHJ1d0RlUGUrQjU0SzlkNHUzUWxENWZv?=
 =?utf-8?B?ZVRzUnJIOHB3RnZPczk4MHlqZlV4MGM2TFIxeXErVElSbENYeWZSYzhLdTgv?=
 =?utf-8?B?aHhZMC9pQlczYWNqMDVDK1JyTXNMUlJ4cXZNYnQwT2hKNEFpeUZKQy9vZmFn?=
 =?utf-8?B?cFNIZVUxc3VKclB4bEsrZ3c2R2RyWU1pWEdNVkRQVG8wK1JVZ0xBaUg0cHVI?=
 =?utf-8?B?bWZrTFRKd3RHSmVtWUhIWkxGcm0rL2FFUHMweXNMRitlV2c0clZNd0dFbXgr?=
 =?utf-8?B?YlRMMU5DMkFKSGJrakxmWVJJZ3IxWmpzVjdZVEt6WE90SE0zVlp6M1dpUm00?=
 =?utf-8?B?VWZBVFZuODhnN0VrckFoMktzSnBNN3ZNcnlpTzdoOGhuUVEzK1J2OUZEL2Za?=
 =?utf-8?B?SWk2Y1ZtUFpsbVlDeGxaSXBWUzFhRjlmWlRWNVpMR3I2U0pGYU1YNGVMbk1n?=
 =?utf-8?B?S0xLK3U2NzNSMHI0NUpFUGpVc3RUS3ViWXNwSW5xcHh0V2JJQUg4aGhCVnNN?=
 =?utf-8?B?WWtkVkVFZ0V1ZXdZWldEUkxHdk9kK3JtRjBndGVTdkQ5MnBSQnkwL2VWN05z?=
 =?utf-8?B?REdFK3pFeHptS2UxUS9HNXlXWXBiRFlndWM2dVlyZ3VOcDgrRkJ1U044MFYz?=
 =?utf-8?B?SFR6b2pNRTdQcnVRSG1IWW1wSU45N29hUnhSbHM5SmtoZW1NK0NhWnJHbkI5?=
 =?utf-8?B?MEtYNkF0QnlWcWduL2R1bDBER0dLTUkyMWUzZWVzYW1jNXVCcUdnSlFXS1Zr?=
 =?utf-8?B?NVRtSXh4MVNQY1B0VHpvYnJsblBuYUczLytJOWxOWTh0clpCMkNiUXBmUlN5?=
 =?utf-8?B?UjBDUWdqUE9RRmVjdHl5eWdjenBITTNvSW5hNVMwbndRbG0ycVZFVCttZTdE?=
 =?utf-8?B?RWZGMFpqVG5OeDdtbkpRcXlTSGpxaFhJayt3Qmk5cXB4ZEx2QzM1Y2dhSUVI?=
 =?utf-8?B?eWpkTTU5ZE0vUzVkSDIrS1FWaWxLZ1BCclhvck5KY0ZoNkYvTjA3Q0ZmM29I?=
 =?utf-8?B?WEsxOElBODZja3A1Ump4UXlkdTQyWUg2bGRQMVBiQVE4RnphbjlwWXFoTW55?=
 =?utf-8?B?M0NOK0xlQjVURlYxV3BDbWFHakZlL2lBVi93Z0pJQ3NCMHpwU0FIcFo5dlFP?=
 =?utf-8?B?NEJiZFk4L0xOenplNS9ESU1VekR6bGRDQUNlK3RrY1hQSXVwU3k5NXJlTk5Q?=
 =?utf-8?B?TEhkbzYrWG4rckZtbktkdm5yaDdhNk1RNHZhb1FEYlpxaE5ha3Mvc0Q4N0Z5?=
 =?utf-8?B?TDFkRTAyU2lRZSt1TjBOa3pGV05JOTZPamZkZ3RodDhhOGRBYXRBTG5MU1Vu?=
 =?utf-8?B?emxhZXd3MTVIOXRJL0NOeWUvK2F4YS9jRjh1TjRMMzRESTlGd0xZaXZDY3hy?=
 =?utf-8?B?QlJsRDVuYzNiYzBjL1ptZFc4SG5kdjlFK3B4QS9VdWNXNDVvbnNiZ2VFVXFy?=
 =?utf-8?B?bS9oVFFYUkFHWWR5TTZXWnpRdmNvamZLNFdlNW9ibkkzWXV4Y0g2ZHdMU0wv?=
 =?utf-8?B?T1p2VnZrUDN6RTJaaEpiR09KVXk1YVZ3YjZDV1d3L1U1QzltOXhDYWtRZTZJ?=
 =?utf-8?B?K0xYY2dZM1dXYmtCUVpFSGNVUDBGbVYxZnhtZlV0dkRhaHZMdGVLOFFOOHBx?=
 =?utf-8?B?NnFQTVA3ZldWN0tDT29ZVTU4S0pqV1ZzeWd5cDgwZW52bTFOeHRSZHFldEVj?=
 =?utf-8?Q?xdCWK9J6npGfCEHef+mrLgIED?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1pVzISZALx8mD8YQKybgV8Kcrd+CliKIgTSp/foutnPFEfgMrJgtEQq3wVN/ylr4HADX60kf1D3ZbXTcnAatdSH1fo96CtwZqYIfBcD8mKXcF5BD6FkNVAn8RXUuVWSziT/Vq3h3TGDKyP5d3EjrrpWESfP0LIir/QIJsyqwA9NBc5aGv/1i/OLDOmaCUQE27MMZmJRIKqW7GXY1aVFhbi7VT01tOZwUVy2gDTZeIeO26eEMrakEl2uMIsrPMHP+qlzy9ig775wov8I6QaiV5RLryyr+Lpfar4mxHRdtID4LwEZ90wkNS60E4KaK/b33vpb0/fg2P5OkrKw3sPBKrJcciy81gPY8ExGvPZNo9KP/WdbAJTSoU2mX/SozzUQaqZTOZyvRyUMQBGuTYkpZ4JEixjcmzwLOa1uAHSXz1znWIJtSC5fzFlDN81FDjrS8U/LCBl5jCcjwUeSGxPd0Oma4yPH1F5yjm3ztQQTptNZyi0wDzjniSnhPCrFq8brBfXD7rKlI7i4W4IcWxji5jUg1Q/WEhTxt6h0NdWhYM+pUUPlSUKOJd7KI/a35vcK/9816HUBTt8CZW09bH0p89JJdl8YqKw4oSqcllbzwz6k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dd0c02-bf27-4aeb-18d2-08dd445e435c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 14:23:00.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPyLwkK/fiId4Ao64glCAxBn9A94aQLrYnGRMcfERkLzorxynDgKNQcETAdmIfq1AOX+1cJrG4TMuFdEQlT/mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502030105
X-Proofpoint-GUID: RKLIkOdWYDoZHt2dxwRaUBwqpBfNV8r9
X-Proofpoint-ORIG-GUID: RKLIkOdWYDoZHt2dxwRaUBwqpBfNV8r9

On 2/2/25 8:06 PM, Dai Ngo wrote:
> 
> On 2/2/25 8:18 AM, Chuck Lever wrote:
>> On 2/2/25 8:35 AM, Salvatore Bonaccorso wrote:
>>> Hi Chuck,
>>>
>>> On Fri, Jan 31, 2025 at 05:17:08PM +0100, Salvatore Bonaccorso wrote:
>>>> Hi Chuck,
>>>>
>>>> On Sat, Aug 17, 2024 at 02:52:38PM +0000, Chuck Lever III wrote:
>>>>>
>>>>>> On Aug 17, 2024, at 4:39 AM, Salvatore Bonaccorso
>>>>>> <carnil@debian.org> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On Tue, Jul 30, 2024 at 02:52:47PM +0200, Paul Menzel wrote:
>>>>>>> Dear Salvatore, dear Chuck,
>>>>>>>
>>>>>>>
>>>>>>> Thank you for your messages.
>>>>>>>
>>>>>>>
>>>>>>> Am 30.07.24 um 14:19 schrieb Salvatore Bonaccorso:
>>>>>>>
>>>>>>>> On Sat, Jul 27, 2024 at 09:19:24PM +0000, Chuck Lever III wrote:
>>>>>>>>>> On Jul 27, 2024, at 5:15 PM, Salvatore Bonaccorso
>>>>>>>>>> <carnil@debian.org> wrote:
>>>>>>>>>> On Wed, Jul 17, 2024 at 07:33:24AM +0200, Paul Menzel wrote:
>>>>>>>>>>> Using Linux 5.15.160 on a Dell PowerEdge T440/021KCD, BIOS
>>>>>>>>>>> 2.11.2
>>>>>>>>>>> 04/22/2021, a mount from another server hung. Linux logs:
>>>>>>>>>>>
>>>>>>>>>>> ```
>>>>>>>>>>> $ dmesg -T
>>>>>>>>>>> [Wed Jul  3 16:39:34 2024] Linux version
>>>>>>>>>>> 5.15.160.mx64.476(root@theinternet.molgen.mpg.de) (gcc (GCC)
>>>>>>>>>>> 12.3.0, GNU ld (GNU Binutils) 2.41) #1 SMP Wed Jun 5 12:24:15
>>>>>>>>>>> CEST 2024
>>>>>>>>>>> [Wed Jul  3 16:39:34 2024] Command line: root=LABEL=root ro
>>>>>>>>>>> crashkernel=64G-:256M console=ttyS0,115200n8 console=tty0
>>>>>>>>>>> init=/bin/systemd audit=0 random.trust_cpu=on
>>>>>>>>>>> systemd.unified_cgroup_hierarchy
>>>>>>>>>>> […]
>>>>>>>>>>> [Wed Jul  3 16:39:34 2024] DMI: Dell Inc. PowerEdge
>>>>>>>>>>> T440/021KCD, BIOS 2.11.2 04/22/2021
>>>>>>>>>>> […]
>>>>>>>>>>> [Tue Jul 16 06:00:10 2024] md: md3: data-check interrupted.
>>>>>>>>>>> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized
>>>>>>>>>>> reply: calldir 0x1 xpt_bc_xprt 00000000ee580afa xid 6890a3d2
>>>>>>>>>>> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized
>>>>>>>>>>> reply: calldir 0x1 xpt_bc_xprt 00000000d4d84570 xid 3ca4017a
>>>>>>> […]
>>>>>>>
>>>>>>>>>>> [Tue Jul 16 11:35:59 2024] receive_cb_reply: Got unrecognized
>>>>>>>>>>> reply: calldir 0x1 xpt_bc_xprt 0000000028481e8f xid b682b676
>>>>>>>>>>> [Tue Jul 16 11:35:59 2024] receive_cb_reply: Got unrecognized
>>>>>>>>>>> reply: calldir 0x1 xpt_bc_xprt 00000000c384ff38 xid b5d5dbf5
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] rcu: INFO: rcu_sched self-detected
>>>>>>>>>>> stall on CPU
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] rcu:  13-....: (20997 ticks this
>>>>>>>>>>> GP) idle=54f/1/0x4000000000000000 softirq=31904928/31904928
>>>>>>>>>>> fqs=4433
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  (t=21017 jiffies g=194958993 q=5715)
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] Task dump for CPU 13:
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] task:kworker/u34:2   state:R 
>>>>>>>>>>> running task stack:    0 pid:30413 ppid:     2 flags:0x00004008
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] Workqueue: rpciod
>>>>>>>>>>> rpc_async_schedule [sunrpc]
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] Call Trace:
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  <IRQ>
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  sched_show_task.cold+0xc2/0xda
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  rcu_dump_cpu_stacks+0xa1/0xd3
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  rcu_sched_clock_irq.cold+0xc7/0x1e7
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? trigger_load_balance+0x6d/0x300
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? scheduler_tick+0xda/0x260
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  update_process_times+0xa1/0xe0
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  tick_sched_timer+0x8e/0xa0
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? tick_sched_do_timer+0x90/0x90
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  __hrtimer_run_queues+0x139/0x2a0
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  hrtimer_interrupt+0xf4/0x210
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] 
>>>>>>>>>>> __sysvec_apic_timer_interrupt+0x5f/0xe0
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] 
>>>>>>>>>>> sysvec_apic_timer_interrupt+0x69/0x90
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  </IRQ>
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  <TASK>
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] 
>>>>>>>>>>> asm_sysvec_apic_timer_interrupt+0x16/0x20
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] RIP: 0010:read_tsc+0x3/0x20
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] Code: cc cc cc cc cc cc cc 8b 05
>>>>>>>>>>> 56 ab 72 01 c3 cc cc cc cc 0f 1f 44 00 00 c3 cc cc cc cc 66
>>>>>>>>>>> 66 2e 0f 1f 84 00 00 00 00 00 0f 01 f9 <66> 90 48 c1 e2 20 48
>>>>>>>>>>> 09 d0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] RSP: 0018:ffffc900087cfe00 EFLAGS:
>>>>>>>>>>> 00000246
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] RAX: 00000000226dc8b8 RBX:
>>>>>>>>>>> 000000003f3c079e RCX: 000000000000100d
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] RDX: 00000000004535c4 RSI:
>>>>>>>>>>> 0000000000000046 RDI: ffffffff82435600
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] RBP: 0003ed08d3641da3 R08:
>>>>>>>>>>> ffffffffa012c770 R09: ffffffffa012c788
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] R10: 0000000000000003 R11:
>>>>>>>>>>> 0000000000000283 R12: 0000000000000000
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] R13: 0000000000000001 R14:
>>>>>>>>>>> ffff88909311c000 R15: ffff88909311c005
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ktime_get+0x38/0xa0
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? rpc_sleep_on_priority+0x70/0x70
>>>>>>>>>>> [sunrpc]
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  rpc_exit_task+0x9a/0x100 [sunrpc]
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  __rpc_execute+0x6e/0x410 [sunrpc]
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  rpc_async_schedule+0x29/0x40
>>>>>>>>>>> [sunrpc]
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  process_one_work+0x1d7/0x3a0
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  worker_thread+0x4a/0x3c0
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? process_one_work+0x3a0/0x3a0
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  kthread+0x115/0x140
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? set_kthread_struct+0x50/0x50
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ret_from_fork+0x1f/0x30
>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  </TASK>
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] rcu: INFO: rcu_sched self-detected
>>>>>>>>>>> stall on CPU
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] rcu:  7-....: (21000 ticks this
>>>>>>>>>>> GP) idle=5b1/1/0x4000000000000000 softirq=29984492/29984492
>>>>>>>>>>> fqs=5159
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  (t=21017 jiffies g=194959001 q=2008)
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] Task dump for CPU 7:
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] task:kworker/u34:2   state:R 
>>>>>>>>>>> running task stack:    0 pid:30413 ppid:     2 flags:0x00004008
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] Workqueue: rpciod
>>>>>>>>>>> rpc_async_schedule [sunrpc]
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] Call Trace:
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  <IRQ>
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  sched_show_task.cold+0xc2/0xda
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  rcu_dump_cpu_stacks+0xa1/0xd3
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  rcu_sched_clock_irq.cold+0xc7/0x1e7
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ? trigger_load_balance+0x6d/0x300
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ? scheduler_tick+0xda/0x260
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  update_process_times+0xa1/0xe0
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  tick_sched_timer+0x8e/0xa0
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ? tick_sched_do_timer+0x90/0x90
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  __hrtimer_run_queues+0x139/0x2a0
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  hrtimer_interrupt+0xf4/0x210
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] 
>>>>>>>>>>> __sysvec_apic_timer_interrupt+0x5f/0xe0
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] 
>>>>>>>>>>> sysvec_apic_timer_interrupt+0x69/0x90
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  </IRQ>
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  <TASK>
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] 
>>>>>>>>>>> asm_sysvec_apic_timer_interrupt+0x16/0x20
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] RIP: 0010:_raw_spin_lock+0x10/0x20
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] Code: b8 00 02 00 00 f0 0f c1 07
>>>>>>>>>>> a9 ff 01 00 00 75 05 c3 cc cc cc cc e9 f0 05 59 ff 0f 1f 44
>>>>>>>>>>> 00 00 31 c0 ba 01 00 00 00 f0 0f b1 17 <75> 05 c3 cc cc cc cc
>>>>>>>>>>> 89 c6 e9 62 02 59 ff 66 90 0f 1f 44 00 00 fa
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] RSP: 0018:ffffc900087cfe30 EFLAGS:
>>>>>>>>>>> 00000246
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] RAX: 0000000000000000 RBX:
>>>>>>>>>>> ffff88997131a500 RCX: 0000000000000001
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] RDX: 0000000000000001 RSI:
>>>>>>>>>>> ffff88997131a500 RDI: ffffffffa012c700
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] RBP: ffffffffa012c700 R08:
>>>>>>>>>>> ffffffffa012c770 R09: ffffffffa012c788
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] R10: 0000000000000003 R11:
>>>>>>>>>>> 0000000000000283 R12: ffff88997131a530
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] R13: 0000000000000001 R14:
>>>>>>>>>>> ffff88909311c000 R15: ffff88909311c005
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  __rpc_execute+0x95/0x410 [sunrpc]
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  rpc_async_schedule+0x29/0x40
>>>>>>>>>>> [sunrpc]
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  process_one_work+0x1d7/0x3a0
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  worker_thread+0x4a/0x3c0
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ? process_one_work+0x3a0/0x3a0
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  kthread+0x115/0x140
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ? set_kthread_struct+0x50/0x50
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ret_from_fork+0x1f/0x30
>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  </TASK>
>>>>>>>>>>> [Tue Jul 16 11:37:57 2024] rcu: INFO: rcu_sched self-detected
>>>>>>>>>>> stall on CPU
>>>>>>>>>>> […]
>>>>>>>>>>> ```
>>>>>>>>>> FWIW, on one NFS server occurence we are seeing something very
>>>>>>>>>> close
>>>>>>>>>> to the above but in the 5.10.y case for the Debian kernel after
>>>>>>>>>> updating to 5.10.218-1 to 5.10.221-1, so kernel after which
>>>>>>>>>> had the
>>>>>>>>>> big NFS related stack backported.
>>>>>>>>>>
>>>>>>>>>> One backtrace we were able to catch was
>>>>>>>>>>
>>>>>>>>>> [...]
>>>>>>>>>> Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got
>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 000000003d26f7ec
>>>>>>>>>> xid b172e1c6
>>>>>>>>>> Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got
>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000017f1552a
>>>>>>>>>> xid a90d7751
>>>>>>>>>> Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got
>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 000000006337c521
>>>>>>>>>> xid 8e5e58bd
>>>>>>>>>> Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got
>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000cbf89319
>>>>>>>>>> xid c2da3c73
>>>>>>>>>> Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got
>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000e2588a21
>>>>>>>>>> xid a01bfec6
>>>>>>>>>> Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got
>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 000000005fda63ca
>>>>>>>>>> xid c2eeeaa6
>>>>>>>>>> [...]
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: rcu: INFO: rcu_sched self-
>>>>>>>>>> detected stall on CPU
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: rcu:         15-....: (5250
>>>>>>>>>> ticks this GP) idle=74e/1/0x4000000000000000
>>>>>>>>>> softirq=3160997/3161006 fqs=2233
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:         (t=5255 jiffies
>>>>>>>>>> g=8381377 q=106333)
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: NMI backtrace for cpu 15
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: CPU: 15 PID: 3725556 Comm:
>>>>>>>>>> kworker/u42:4 Not tainted 5.10.0-31-amd64 #1 Debian 5.10.221-1
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: Hardware name: DALCO AG
>>>>>>>>>> S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559
>>>>>>>>>> 03/19/2019
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: Workqueue: rpciod
>>>>>>>>>> rpc_async_schedule [sunrpc]
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: Call Trace:
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  <IRQ>
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  dump_stack+0x6b/0x83
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>> nmi_cpu_backtrace.cold+0x32/0x69
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ?
>>>>>>>>>> lapic_can_unplug_cpu+0x80/0x80
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>> nmi_trigger_cpumask_backtrace+0xdf/0xf0
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  rcu_dump_cpu_stacks+0xa5/0xd7
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>> rcu_sched_clock_irq.cold+0x202/0x3d9
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ?
>>>>>>>>>> trigger_load_balance+0x5a/0x220
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  update_process_times+0x8c/0xc0
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  tick_sched_handle+0x22/0x60
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  tick_sched_timer+0x65/0x80
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ?
>>>>>>>>>> tick_sched_do_timer+0x90/0x90
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>> __hrtimer_run_queues+0x127/0x280
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  hrtimer_interrupt+0x110/0x2c0
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>> __sysvec_apic_timer_interrupt+0x5c/0xe0
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  asm_call_irq_on_stack+0xf/0x20
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  </IRQ>
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>> sysvec_apic_timer_interrupt+0x72/0x80
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>> asm_sysvec_apic_timer_interrupt+0x12/0x20
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: RIP:
>>>>>>>>>> 0010:mod_delayed_work_on+0x5d/0x90
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: Code: 00 4c 89 e7 e8 34 fe
>>>>>>>>>> ff ff 89 c3 83 f8 f5 74 e9 85 c0 78 1b 89 ef 4c 89 f1 4c 89 e2
>>>>>>>>>> 4c 89 ee e8 f9 fc ff ff 48 8b 3c 24 57 9d <0f> 1f 44 >
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: RSP: 0018:ffffb5efe356fd90
>>>>>>>>>> EFLAGS: 00000246
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: RAX: 0000000000000000 RBX:
>>>>>>>>>> 0000000000000000 RCX: 000000003820000f
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: RDX: 0000000038000000 RSI:
>>>>>>>>>> 0000000000000046 RDI: 0000000000000246
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: RBP: 0000000000002000 R08:
>>>>>>>>>> ffffffffc0884430 R09: ffffffffc0884448
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: R10: 0000000000000003 R11:
>>>>>>>>>> 0000000000000003 R12: ffffffffc0884428
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: R13: ffff8c89d0f6b800 R14:
>>>>>>>>>> 00000000000001f4 R15: 0000000000000000
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>> __rpc_sleep_on_priority_timeout+0x111/0x120 [sunrpc]
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  rpc_delay+0x56/0x90 [sunrpc]
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  rpc_exit_task+0x5a/0x140
>>>>>>>>>> [sunrpc]
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ?
>>>>>>>>>> __rpc_do_wake_up_task_on_wq+0x1e0/0x1e0 [sunrpc]
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  __rpc_execute+0x6d/0x410
>>>>>>>>>> [sunrpc]
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>> rpc_async_schedule+0x29/0x40 [sunrpc]
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  process_one_work+0x1b3/0x350
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  worker_thread+0x53/0x3e0
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ? process_one_work+0x350/0x350
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  kthread+0x118/0x140
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ?
>>>>>>>>>> __kthread_bind_mask+0x60/0x60
>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ret_from_fork+0x1f/0x30
>>>>>>>>>> [...]
>>>>>>>>>>
>>>>>>>>>> Is there anything which could help debug this issue?
>>>>>>>>> The backtrace suggests an issue in the RPC client code; the
>>>>>>>>> server's NFSv4.1 backchannel would use that to send callbacks.
>>>>>>>>>
>>>>>>>>> Since 5.10.218 and 5.10.221 are only about a thousand commits
>>>>>>>>> apart, a bisect should be quick and narrow down the issue to
>>>>>>>>> one or two commits.
>>>>>>>> Yes indeed. Unfortunately was yet unable to reproduce the issue in
>>>>>>>> more syntentic way on test environment, and the affected server in
>>>>>>>> particular is a production system.
>>>>>>>>
>>>>>>>> Paul, is your case in some way reproducible in a testing
>>>>>>>> environment
>>>>>>>> so that a bisection might be give enough hints on the problem?
>>>>>>> We hit this issue once more on the same server with Linux
>>>>>>> 5.15.160, and had
>>>>>>> to hard reboot it.
>>>>>>>
>>>>>>> Unfortunately we did not have time yet to set up a test system to
>>>>>>> find a
>>>>>>> reproducer. In our cases a lot of compute servers seem to have
>>>>>>> accessed the
>>>>>>> NFS server. A lot of the many processes were `zstd` on a first
>>>>>>> glance.
>>>>>> So we neither, due to the nature of the server (production system)
>>>>>> and
>>>>>> unability to reproduce the issue under some more controlled way
>>>>>> and on
>>>>>> test environment.
>>>>>>
>>>>>> In our case users seems to cause workloads involving use of wandb.
>>>>>>
>>>>>> What we tried is to boot the recent kernel from 5.10.y series
>>>>>> avaiable
>>>>>> (5.10.223-1). Then the issue showed up still. Since we disabled
>>>>>> fs.leases-enable the situation seems to be more stable). While this
>>>>>> is/might not be the solution, does that gives some additional hits?
>>>>> The problem is backchannel-related, and disabling delegation
>>>>> will reduce the number of backchannel operations. Your finding
>>>>> comports with our current theory, but I can't think of how it
>>>>> narrows the field of suspects.
>>>>>
>>>>> Is the server running short on memory, perhaps? One backchannel
>>>>> operation that was added in v5.10.220 is CB_RECALL_ANY, which
>>>>> is triggered on memory exhaustion. But that should be a fairly
>>>>> harmless addition unless there is a bug in there somewhere.
>>>>>
>>>>> If your NFS server does not have any NFS mounts, then we could
>>>>> provide instructions for enabling client-side tracing to watch
>>>>> the details of callback traffic.
>>>> The NFS server acts as well as NFS client, so tracing more
>>>> back-channel related will I guess just load the tracing more.
>>>>
>>>> But we got "lucky" and we were able to trigger the issue twice in last
>>>> days, once NFSv4 delegations were enabled again and some users started
>>>> to cause more load on the specific server as well.
>>>>
>>>> I did issue
>>>>
>>>>     rpcdebug -m rpc -c
>>>>
>>>> before rebooting/resetting the server  which is
>>>>
>>>> Jan 30 05:27:05 nfsserver kernel: 26407 2281   -512 3d1fdb92       
>>>> 0        0 79bc1aa5 nfs4_cbv1 CB_RECALL_ANY a:rpc_exit_task [sunrpc]
>>>> q:delayq
>>>>
>>>> and the first RPC related soft lookup slapt in the log/journal I was
>>>> able to gather is:
>>>>
>>>> Jan 29 22:34:05 nfsserver kernel: watchdog: BUG: soft lockup -
>>>> CPU#11 stuck for 23s! [kworker/u42:3:705574]
>>>> Jan 29 22:34:05 nfsserver kernel: Modules linked in: binfmt_misc
>>>> rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache bonding quota_v2
>>>> quota_tree ipmi_ssif intel_rapl_msr intel_rapl_common skx_edac
>>>> skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp
>>>> coretemp kvm_intel kvm irqbypass ghash_clmulni_intel aesni_intel
>>>> libaes crypto_simd cryptd ast glue_helper drm_vram_helper
>>>> drm_ttm_helper rapl acpi_ipmi ttm iTCO_wdt intel_cstate ipmi_si
>>>> intel_pmc_bxt drm_kms_helper mei_me iTCO_vendor_support ipmi_devintf
>>>> cec ioatdma intel_uncore pcspkr evdev joydev sg i2c_algo_bit
>>>> watchdog mei dca ipmi_msghandler acpi_power_meter acpi_pad button
>>>> fuse drm configfs nfsd auth_rpcgss nfs_acl lockd grace sunrpc
>>>> ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 raid10 raid456
>>>> async_raid6_recov async_memcpy async_pq async_xor async_tx xor
>>>> raid6_pq libcrc32c crc32c_generic raid1 raid0 multipath linear
>>>> md_mod dm_mod hid_generic usbhid hid sd_mod t10_pi crc_t10dif
>>>> crct10dif_generic xhci_pci ahci xhci_hcd libahci i40e libata
>>>> Jan 29 22:34:05 nfsserver kernel:  crct10dif_pclmul arcmsr
>>>> crct10dif_common ptp crc32_pclmul usbcore crc32c_intel scsi_mod
>>>> pps_core i2c_i801 lpc_ich i2c_smbus wmi usb_common
>>>> Jan 29 22:34:05 nfsserver kernel: CPU: 11 PID: 705574 Comm: kworker/
>>>> u42:3 Not tainted 5.10.0-33-amd64 #1 Debian 5.10.226-1
>>>> Jan 29 22:34:05 nfsserver kernel: Hardware name: DALCO AG S2600WFT/
>>>> S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
>>>> Jan 29 22:34:05 nfsserver kernel: Workqueue: rpciod
>>>> rpc_async_schedule [sunrpc]
>>>> Jan 29 22:34:05 nfsserver kernel: RIP: 0010:ktime_get+0x7b/0xa0
>>>> Jan 29 22:34:05 nfsserver kernel: Code: d1 e9 48 f7 d1 48 89 c2 48
>>>> 85 c1 8b 05 ae 2c a5 02 8b 0d ac 2c a5 02 48 0f 45 d5 8b 35 7e 2c a5
>>>> 02 41 39 f4 75 9e 48 0f af c2 <48> 01 f8 48 d3 e8 48 01 d8 5b 5d 41
>>>> 5c c3 cc cc cc cc f3 90 eb 84
>>>> Jan 29 22:34:05 nfsserver kernel: RSP: 0018:ffffa1aca9227e00 EFLAGS:
>>>> 00000202
>>>> Jan 29 22:34:05 nfsserver kernel: RAX: 0000371a545e1910 RBX:
>>>> 000005fce82a4372 RCX: 0000000000000018
>>>> Jan 29 22:34:05 nfsserver kernel: RDX: 000000000078efbe RSI:
>>>> 000000000031f238 RDI: 00385c1353c92824
>>>> Jan 29 22:34:05 nfsserver kernel: RBP: 0000000000000000 R08:
>>>> ffffffffc081f410 R09: ffffffffc081f410
>>>> Jan 29 22:34:05 nfsserver kernel: R10: 0000000000000003 R11:
>>>> 0000000000000003 R12: 000000000031f238
>>>> Jan 29 22:34:05 nfsserver kernel: R13: ffff8ed42bf34830 R14:
>>>> 0000000000000001 R15: 0000000000000000
>>>> Jan 29 22:34:05 nfsserver kernel: FS:  0000000000000000(0000)
>>>> GS:ffff8ee94f880000(0000) knlGS:0000000000000000
>>>> Jan 29 22:34:05 nfsserver kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>>>> 0000000080050033
>>>> Jan 29 22:34:05 nfsserver kernel: CR2: 00007ffddf306080 CR3:
>>>> 00000017c420a002 CR4: 00000000007706e0
>>>> Jan 29 22:34:05 nfsserver kernel: DR0: 0000000000000000 DR1:
>>>> 0000000000000000 DR2: 0000000000000000
>>>> Jan 29 22:34:05 nfsserver kernel: DR3: 0000000000000000 DR6:
>>>> 00000000fffe0ff0 DR7: 0000000000000400
>>>> Jan 29 22:34:05 nfsserver kernel: PKRU: 55555554
>>>> Jan 29 22:34:05 nfsserver kernel: Call Trace:
>>>> Jan 29 22:34:05 nfsserver kernel:  <IRQ>
>>>> Jan 29 22:34:05 nfsserver kernel:  ? watchdog_timer_fn+0x1bb/0x210
>>>> Jan 29 22:34:05 nfsserver kernel:  ?
>>>> lockup_detector_update_enable+0x50/0x50
>>>> Jan 29 22:34:05 nfsserver kernel:  ? __hrtimer_run_queues+0x127/0x280
>>>> Jan 29 22:34:05 nfsserver kernel:  ? hrtimer_interrupt+0x110/0x2c0
>>>> Jan 29 22:34:05 nfsserver kernel:  ?
>>>> __sysvec_apic_timer_interrupt+0x5c/0xe0
>>>> Jan 29 22:34:05 nfsserver kernel:  ? asm_call_irq_on_stack+0xf/0x20
>>>> Jan 29 22:34:05 nfsserver kernel:  </IRQ>
>>>> Jan 29 22:34:05 nfsserver kernel:  ?
>>>> sysvec_apic_timer_interrupt+0x72/0x80
>>>> Jan 29 22:34:05 nfsserver kernel:  ?
>>>> asm_sysvec_apic_timer_interrupt+0x12/0x20
>>>> Jan 29 22:34:05 nfsserver kernel:  ? ktime_get+0x7b/0xa0
>>>> Jan 29 22:34:05 nfsserver kernel:  rpc_exit_task+0x96/0x140 [sunrpc]
>>>> Jan 29 22:34:05 nfsserver kernel:  ?
>>>> __rpc_do_wake_up_task_on_wq+0x1e0/0x1e0 [sunrpc]
>>>> Jan 29 22:34:05 nfsserver kernel:  __rpc_execute+0x6d/0x410 [sunrpc]
>>>> Jan 29 22:34:05 nfsserver kernel:  rpc_async_schedule+0x29/0x40
>>>> [sunrpc]
>>>> Jan 29 22:34:05 nfsserver kernel:  process_one_work+0x1b3/0x350
>>>> Jan 29 22:34:05 nfsserver kernel:  worker_thread+0x53/0x3e0
>>>> Jan 29 22:34:05 nfsserver kernel:  ? process_one_work+0x350/0x350
>>>> Jan 29 22:34:05 nfsserver kernel:  kthread+0x118/0x140
>>>> Jan 29 22:34:05 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>>> Jan 29 22:34:05 nfsserver kernel:  ret_from_fork+0x1f/0x30
>>>>
>>>> I can try to pick on top of the kernel the change Chuck mentioned to
>>>> me offlist, which is the posting of
>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-
>>>> nfs/1738271066-6727-1-git-send-email-dai.ngo@oracle.com/__;!!
>>>> ACWV5N9M2RV99hQ!ILxf31lSoNImIDh3FjDiD-
>>>> qFRBH8gPEQhUW31gF2NOYGPFzPscgj7S23PoaBR1MFs6VLMprfKi9g6WdEkyY$ ,
>>>> and in fact this could be interesting. If the users keep doing the
>>>> same kind of load, this might help understanding more the issue.
>>>>
>>>> As we suspect that the issue is more frequently triggered after the
>>>> switch of 5.10.118 -> 5.10.221, this enforces more the above, which
>>>> says it fixes 66af25799940 ("NFSD: add courteous server support for
>>>> thread with only delegation"), which is in 5.19-rc1, but got
>>>> backported to 5.15.154 and 5.10.220 as well.
>>> Unfortunately not. The system ran slightly more stable with that
>>> patch on, and
>>> there was a nfsd hang inbeween here, within a series of
>>>
>>> [...]
>>> Feb 02 03:22:40 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 5d31fb84
>>> Feb 02 03:22:40 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 9ec25b24
>>> Feb 02 03:23:09 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 9fc25b24
>>> Feb 02 03:23:12 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 5e31fb84
>>> Feb 02 03:23:24 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid a0c25b24
>>> Feb 02 03:23:24 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 5f31fb84
>>> Feb 02 03:23:31 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000fe9013df xid 756103e9
>>> Feb 02 03:23:31 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000471650a0 xid ef4f583e
>>> Feb 02 03:23:33 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 000000008f30d648 xid 1ec77a2e
>>> Feb 02 03:23:35 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid d0b95b44
>>> Feb 02 03:27:43 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 7d31fb84
>>> Feb 02 03:27:44 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid bec25b24
>>> Feb 02 03:27:44 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid e0be7eef
>>> Feb 02 03:28:07 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid bfc25b24
>>> Feb 02 03:28:09 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid e1be7eef
>>> Feb 02 03:31:41 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid f96ccce2
>>> Feb 02 03:31:44 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid 06ba5b44
>>> Feb 02 03:31:49 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 9531fb84
>>> Feb 02 03:31:51 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid f7be7eef
>>> Feb 02 03:31:52 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000471650a0 xid 2550583e
>>> Feb 02 03:31:53 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid d5c25b24
>>> Feb 02 03:31:53 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000fe9013df xid ab6103e9
>>> Feb 02 03:31:53 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 000000004111342b xid 9da4f045
>>> Feb 02 03:32:32 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid d8c25b24
>>> Feb 02 03:32:32 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid fabe7eef
>>> Feb 02 04:18:12 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid a1c35b24
>>> Feb 02 04:18:12 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 000000009715512e xid 29a849e3
>>> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000fe9013df xid 786203e9
>>> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000471650a0 xid f150583e
>>> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid c66dcce2
>>> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 000000008f30d648 xid 21c87a2e
>>> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 0000000053af79cb xid 49da29a2
>>> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 6132fb84
>>> Feb 02 04:49:18 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid 2ebb5b44
>>> Feb 02 04:49:21 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid 226ecce2
>>> Feb 02 04:49:22 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid fdc35b24
>>> Feb 02 04:49:22 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid 1fc07eef
>>> Feb 02 05:01:25 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 25c45b24
>>> Feb 02 05:09:27 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 51c45b24
>>> [...]
>>> Feb 02 05:34:46 nfsserver kernel: INFO: task nfsd:1590 blocked for
>>> more than 120 seconds.
>>> Feb 02 05:34:46 nfsserver kernel:       Tainted: G            E    
>>> 5.10.0-34-amd64 #1 Debian 5.10.228-1~test1
>>> Feb 02 05:34:46 nfsserver kernel: "echo 0 > /proc/sys/kernel/
>>> hung_task_timeout_secs" disables this message.
>>> Feb 02 05:34:46 nfsserver kernel: task:nfsd            state:D
>>> stack:    0 pid: 1590 ppid:     2 flags:0x00004000
>>> Feb 02 05:34:46 nfsserver kernel: Call Trace:
>>> Feb 02 05:34:46 nfsserver kernel:  __schedule+0x282/0x870
>>> Feb 02 05:34:46 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
>>> Feb 02 05:34:46 nfsserver kernel:  schedule+0x46/0xb0
>>> Feb 02 05:34:46 nfsserver kernel:  rwsem_down_write_slowpath+0x257/0x4d0
>>> Feb 02 05:34:46 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
>>> Feb 02 05:34:46 nfsserver kernel: 
>>> ext4_buffered_write_iter+0x33/0x160 [ext4]
>>> Feb 02 05:34:46 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
>>> Feb 02 05:34:46 nfsserver kernel:  do_iter_write+0x80/0x1c0
>>> Feb 02 05:34:46 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
>>> Feb 02 05:34:46 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
>>> Feb 02 05:34:46 nfsserver kernel:  elfcorehdr_read+0x40/0x40
>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
>>> Feb 02 05:34:46 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0
>>> [sunrpc]
>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
>>> Feb 02 05:34:46 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
>>> Feb 02 05:34:46 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
>>> Feb 02 05:34:46 nfsserver kernel:  ? kthread+0x118/0x140
>>> Feb 02 05:34:46 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>> Feb 02 05:34:46 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
>>> Feb 02 05:34:46 nfsserver kernel: INFO: task nfsd:1599 blocked for
>>> more than 120 seconds.
>>> Feb 02 05:34:46 nfsserver kernel:       Tainted: G            E    
>>> 5.10.0-34-amd64 #1 Debian 5.10.228-1~test1
>>> Feb 02 05:34:46 nfsserver kernel: "echo 0 > /proc/sys/kernel/
>>> hung_task_timeout_secs" disables this message.
>>> Feb 02 05:34:46 nfsserver kernel: task:nfsd            state:D
>>> stack:    0 pid: 1599 ppid:     2 flags:0x00004000
>>> Feb 02 05:34:46 nfsserver kernel: Call Trace:
>>> Feb 02 05:34:46 nfsserver kernel:  __schedule+0x282/0x870
>>> Feb 02 05:34:46 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
>>> Feb 02 05:34:46 nfsserver kernel:  schedule+0x46/0xb0
>>> Feb 02 05:34:46 nfsserver kernel:  rwsem_down_write_slowpath+0x257/0x4d0
>>> Feb 02 05:34:46 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
>>> Feb 02 05:34:46 nfsserver kernel: 
>>> ext4_buffered_write_iter+0x33/0x160 [ext4]
>>> Feb 02 05:34:46 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
>>> Feb 02 05:34:46 nfsserver kernel:  do_iter_write+0x80/0x1c0
>>> Feb 02 05:34:46 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
>>> Feb 02 05:34:46 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
>>> Feb 02 05:34:46 nfsserver kernel:  elfcorehdr_read+0x40/0x40
>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
>>> Feb 02 05:34:46 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0
>>> [sunrpc]
>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
>>> Feb 02 05:34:46 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
>>> Feb 02 05:34:46 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
>>> Feb 02 05:34:46 nfsserver kernel:  ? kthread+0x118/0x140
>>> Feb 02 05:34:46 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>> Feb 02 05:34:46 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
>>> Feb 02 05:34:46 nfsserver kernel: INFO: task nfsd:1601 blocked for
>>> more than 121 seconds.
>>> Feb 02 05:34:46 nfsserver kernel:       Tainted: G            E    
>>> 5.10.0-34-amd64 #1 Debian 5.10.228-1~test1
>>> Feb 02 05:34:46 nfsserver kernel: "echo 0 > /proc/sys/kernel/
>>> hung_task_timeout_secs" disables this message.
>>> Feb 02 05:34:46 nfsserver kernel: task:nfsd            state:D
>>> stack:    0 pid: 1601 ppid:     2 flags:0x00004000
>>> Feb 02 05:34:46 nfsserver kernel: Call Trace:
>>> Feb 02 05:34:46 nfsserver kernel:  __schedule+0x282/0x870
>>> Feb 02 05:34:46 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
>>> Feb 02 05:34:46 nfsserver kernel:  schedule+0x46/0xb0
>>> Feb 02 05:34:47 nfsserver kernel:  rwsem_down_write_slowpath+0x257/0x4d0
>>> Feb 02 05:34:47 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel: 
>>> ext4_buffered_write_iter+0x33/0x160 [ext4]
>>> Feb 02 05:34:47 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
>>> Feb 02 05:34:47 nfsserver kernel:  do_iter_write+0x80/0x1c0
>>> Feb 02 05:34:47 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  elfcorehdr_read+0x40/0x40
>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0
>>> [sunrpc]
>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  ? kthread+0x118/0x140
>>> Feb 02 05:34:47 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>> Feb 02 05:34:47 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
>>> Feb 02 05:34:47 nfsserver kernel: INFO: task nfsd:1604 blocked for
>>> more than 121 seconds.
>>> Feb 02 05:34:47 nfsserver kernel:       Tainted: G            E    
>>> 5.10.0-34-amd64 #1 Debian 5.10.228-1~test1
>>> Feb 02 05:34:47 nfsserver kernel: "echo 0 > /proc/sys/kernel/
>>> hung_task_timeout_secs" disables this message.
>>> Feb 02 05:34:47 nfsserver kernel: task:nfsd            state:D
>>> stack:    0 pid: 1604 ppid:     2 flags:0x00004000
>>> Feb 02 05:34:47 nfsserver kernel: Call Trace:
>>> Feb 02 05:34:47 nfsserver kernel:  __schedule+0x282/0x870
>>> Feb 02 05:34:47 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
>>> Feb 02 05:34:47 nfsserver kernel:  schedule+0x46/0xb0
>>> Feb 02 05:34:47 nfsserver kernel:  rwsem_down_write_slowpath+0x257/0x4d0
>>> Feb 02 05:34:47 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel: 
>>> ext4_buffered_write_iter+0x33/0x160 [ext4]
>>> Feb 02 05:34:47 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
>>> Feb 02 05:34:47 nfsserver kernel:  do_iter_write+0x80/0x1c0
>>> Feb 02 05:34:47 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  elfcorehdr_read+0x40/0x40
>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0
>>> [sunrpc]
>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  ? kthread+0x118/0x140
>>> Feb 02 05:34:47 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>> Feb 02 05:34:47 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
>>> Feb 02 05:34:47 nfsserver kernel: INFO: task nfsd:1610 blocked for
>>> more than 121 seconds.
>>> Feb 02 05:34:47 nfsserver kernel:       Tainted: G            E    
>>> 5.10.0-34-amd64 #1 Debian 5.10.228-1~test1
>>> Feb 02 05:34:47 nfsserver kernel: "echo 0 > /proc/sys/kernel/
>>> hung_task_timeout_secs" disables this message.
>>> Feb 02 05:34:47 nfsserver kernel: task:nfsd            state:D
>>> stack:    0 pid: 1610 ppid:     2 flags:0x00004000
>>> Feb 02 05:34:47 nfsserver kernel: Call Trace:
>>> Feb 02 05:34:47 nfsserver kernel:  __schedule+0x282/0x870
>>> Feb 02 05:34:47 nfsserver kernel:  schedule+0x46/0xb0
>>> Feb 02 05:34:47 nfsserver kernel:  rwsem_down_write_slowpath+0x257/0x4d0
>>> Feb 02 05:34:47 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel: 
>>> ext4_buffered_write_iter+0x33/0x160 [ext4]
>>> Feb 02 05:34:47 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
>>> Feb 02 05:34:47 nfsserver kernel:  do_iter_write+0x80/0x1c0
>>> Feb 02 05:34:47 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  elfcorehdr_read+0x40/0x40
>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0
>>> [sunrpc]
>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
>>> Feb 02 05:34:47 nfsserver kernel:  ? kthread+0x118/0x140
>>> Feb 02 05:34:47 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>> Feb 02 05:34:47 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
>> This is a totally different failure mode: it's hanging in the
>> ext4 write path. One of your nfsd threads is stuck in D state
>> waiting to get a rw semaphor.
>>
>> Question is, who is holding that rw_sem and why?
>>
>>
>>> This happend a couple of times again and "recovered", but got finally
>>> stuck
>>> again with:
>>>
>>> Feb 02 10:55:25 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 1639fb84
>>> Feb 02 10:55:26 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 000000004111342b xid 24acf045
>>> Feb 02 10:55:27 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid 89c15b44
>>> Feb 02 10:55:28 nfsserver kernel: receive_cb_reply: Got unrecognized
>>> reply: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid 8c74cce2
>>> Feb 02 10:55:50 nfsserver kernel: rcu: INFO: rcu_sched self-detected
>>> stall on CPU
>>> Feb 02 10:55:50 nfsserver kernel: rcu:         14-....: (5249 ticks
>>> this GP) idle=c4e/1/0x4000000000000000 softirq=3120573/3120573 fqs=2624
>>> Feb 02 10:55:50 nfsserver kernel:         (t=5250 jiffies g=4585625
>>> q=145785)
>>> Feb 02 10:55:50 nfsserver kernel: NMI backtrace for cpu 14
>>> Feb 02 10:55:50 nfsserver kernel: CPU: 14 PID: 614435 Comm: kworker/
>>> u42:2 Tainted: G            E     5.10.0-34-amd64 #1 Debian
>>> 5.10.228-1~test1
>>> Feb 02 10:55:50 nfsserver kernel: Hardware name: DALCO AG S2600WFT/
>>> S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
>>> Feb 02 10:55:50 nfsserver kernel: Workqueue: rpciod
>>> rpc_async_schedule [sunrpc]
>>> Feb 02 10:55:50 nfsserver kernel: Call Trace:
>>> Feb 02 10:55:50 nfsserver kernel:  <IRQ>
>>> Feb 02 10:55:50 nfsserver kernel:  dump_stack+0x6b/0x83
>>> Feb 02 10:55:50 nfsserver kernel:  nmi_cpu_backtrace.cold+0x32/0x69
>>> Feb 02 10:55:50 nfsserver kernel:  ? lapic_can_unplug_cpu+0x80/0x80
>>> Feb 02 10:55:50 nfsserver kernel: 
>>> nmi_trigger_cpumask_backtrace+0xdb/0xf0
>>> Feb 02 10:55:50 nfsserver kernel:  rcu_dump_cpu_stacks+0xa5/0xd7
>>> Feb 02 10:55:50 nfsserver kernel:  rcu_sched_clock_irq.cold+0x202/0x3d9
>>> Feb 02 10:55:50 nfsserver kernel:  ? timekeeping_advance+0x370/0x5c0
>>> Feb 02 10:55:50 nfsserver kernel:  update_process_times+0x8c/0xc0
>>> Feb 02 10:55:50 nfsserver kernel:  tick_sched_handle+0x22/0x60
>>> Feb 02 10:55:50 nfsserver kernel:  tick_sched_timer+0x65/0x80
>>> Feb 02 10:55:50 nfsserver kernel:  ? tick_sched_do_timer+0x90/0x90
>>> Feb 02 10:55:50 nfsserver kernel:  __hrtimer_run_queues+0x127/0x280
>>> Feb 02 10:55:50 nfsserver kernel:  hrtimer_interrupt+0x110/0x2c0
>>> Feb 02 10:55:50 nfsserver kernel: 
>>> __sysvec_apic_timer_interrupt+0x5c/0xe0
>>> Feb 02 10:55:50 nfsserver kernel:  asm_call_irq_on_stack+0xf/0x20
>>> Feb 02 10:55:50 nfsserver kernel:  </IRQ>
>>> Feb 02 10:55:50 nfsserver kernel:  sysvec_apic_timer_interrupt+0x72/0x80
>>> Feb 02 10:55:50 nfsserver kernel: 
>>> asm_sysvec_apic_timer_interrupt+0x12/0x20
>>> Feb 02 10:55:50 nfsserver kernel: RIP:
>>> 0010:mod_delayed_work_on+0x5d/0x90
>>> Feb 02 10:55:50 nfsserver kernel: Code: 00 4c 89 e7 e8 34 fe ff ff 89
>>> c3 83 f8 f5 74 e9 85 c0 78 1b 89 ef 4c 89 f1 4c 89 e2 4c 89 ee e8 f9
>>> fc ff ff 48 8b 3c 24 57 9d <0f> 1f 44 00 00 85 db 0f 95 c0 48 8b 4c
>>> 24 08 65 48 2b 0c 25 28 00
>>> Feb 02 10:55:50 nfsserver kernel: RSP: 0018:ffffaaff25d57d90 EFLAGS:
>>> 00000246
>>> Feb 02 10:55:50 nfsserver kernel: RAX: 0000000000000000 RBX:
>>> 0000000000000000 RCX: 000000003e60000e
>>> Feb 02 10:55:50 nfsserver kernel: RDX: 000000003e400000 RSI:
>>> 0000000000000046 RDI: 0000000000000246
>>> Feb 02 10:55:50 nfsserver kernel: RBP: 0000000000002000 R08:
>>> ffffffffc08f6430 R09: ffffffffc08f6448
>>> Feb 02 10:55:50 nfsserver kernel: R10: 0000000000000003 R11:
>>> 0000000000000003 R12: ffffffffc08f6428
>>> Feb 02 10:55:50 nfsserver kernel: R13: ffff8e4083a4b400 R14:
>>> 00000000000001f4 R15: 0000000000000000
>>> Feb 02 10:55:50 nfsserver kernel: 
>>> __rpc_sleep_on_priority_timeout+0x111/0x120 [sunrpc]
>>> Feb 02 10:55:50 nfsserver kernel:  rpc_delay+0x56/0x90 [sunrpc]
>>> Feb 02 10:55:50 nfsserver kernel:  rpc_exit_task+0x5a/0x140 [sunrpc]
>>> Feb 02 10:55:50 nfsserver kernel:  ?
>>> __rpc_do_wake_up_task_on_wq+0x1e0/0x1e0 [sunrpc]
>>> Feb 02 10:55:50 nfsserver kernel:  __rpc_execute+0x6d/0x410 [sunrpc]
>>> Feb 02 10:55:50 nfsserver kernel:  rpc_async_schedule+0x29/0x40 [sunrpc]
>>> Feb 02 10:55:50 nfsserver kernel:  process_one_work+0x1b3/0x350
>>> Feb 02 10:55:50 nfsserver kernel:  worker_thread+0x53/0x3e0
>>> Feb 02 10:55:50 nfsserver kernel:  ? process_one_work+0x350/0x350
>>> Feb 02 10:55:50 nfsserver kernel:  kthread+0x118/0x140
>>> Feb 02 10:55:50 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>> Feb 02 10:55:50 nfsserver kernel:  ret_from_fork+0x1f/0x30
>>>
>>> Before rebooting the system, rpcdebug -m rpc -c  was issued again,
>>> with the
>>> following logged entry:
>>>
>>> Feb 02 11:01:52 nfsserver kernel: -pid- flgs status -client- --rqstp-
>>> -timeout ---ops--
>>> Feb 02 11:01:52 nfsserver kernel: 42135 2281      0 8ff8d038       
>>> 0      500  1a6bcc0 nfs4_cbv1 CB_RECALL_ANY a:call_start [sunrpc] q:none
>> This is also different: the CB_RECALL_ANY is waiting to start, it's not
>> retransmitting.
> 
> When CB_RECALL_ANY is returned with cb_seq_status == 1, it is restarted
> by nfsd4_cb_sequence_done. Restarting means the callback is re-queued in
> nfsd4_cb_release which schedules a new work to re-send the callback. So
> the 'call_start' status could indicate that the CB_RECALL_ANY is being
> resending in a loop.

True, but I was looking at the "q:none". If CB_RECALL_ANY were
retransmitting due to NFS4ERR_DELAY, which I've seen in past
rpc_show_tasks output, that would be "q:delayq".


>>> The system is now again back booted with fs.leases-enable=0 to keep
>>> it more
>>> "stable".
>> Understood, but I don't yet see how this new scenario is related to
>> NFSv4 delegation. We can speculate, but here's nothing standing out in
>> the collected data.
>>
>>


-- 
Chuck Lever

