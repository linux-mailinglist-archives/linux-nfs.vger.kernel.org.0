Return-Path: <linux-nfs+bounces-11918-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6692EAC4F9E
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 15:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C2E188F9FD
	for <lists+linux-nfs@lfdr.de>; Tue, 27 May 2025 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1246248867;
	Tue, 27 May 2025 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ajp1gm7Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bz+T/tp6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A3A1E5B7D
	for <linux-nfs@vger.kernel.org>; Tue, 27 May 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352163; cv=fail; b=MYYbIoZyY8xIPSA/pjY3kfnq2pg1kRLN7S3JqD6Fu0nGnsDYkilJhoQu+RSUFdPiPDIK8R65aEVwdqcmzQRFRupTgBLAu0hynSaN1VgGRR8S49f/pnrb5o6IxpOVh+rLvWuVlWIoADOVPcf0Vb0XNi+lKXzTCXLVedJbJtvVlXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352163; c=relaxed/simple;
	bh=F+BVs8bvmadvkqCMfAh0mr/XJKuXnNbkX6JSMEeFzuM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MwkduaIuWOdQxoaQtNLa017TZTZidf7oreDwK+Dz1fb5PnTWnbYl4vZs+5lgBTc8aLzyzSONGx8yM3JKEf0tnvPqNmHvzPyUd62Ze57RHlrT0uWwfZQDcnNzSZ9QkShpcPGxyvq3t838H9N2rK3+8Ug2ezeoejxToOU14u7xywc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ajp1gm7Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bz+T/tp6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCjfct031163;
	Tue, 27 May 2025 13:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tgTzVSfY1IhNYU5vZHxU9UpEqUv5oH9LoL/jmn3sAPc=; b=
	Ajp1gm7Yx4HClxwgIZyfjcnSm7e/c1lnsht0QfwzLnlKDLguf9AXb4fqwI82Wxbb
	iAQDMFoGYwlRiULQBA4ShiTqAiPllYtdaVnYfk1qEJ2pOijcUVcuDEyBJGTu9uPw
	Aj2H1bbT+rf/fg5MowPy3I2Q8vhIvjlc2a5lid8e7u2n9emEuQG5P0Ar14AzE5v2
	PymfRjRhyv1J6nu4Oq2e9K+yerRR0p7NJCj7Gqhmijf2ary4ZF5t2H13PlbLmZsC
	tLpfXbHhcLfw51nnZwChJb7R7nAMLo37Nk+tTtDq5VXY9Ni5UGSpTPgWbxWP4uvg
	8FapPaY0UpXukQDo5IMEFg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0yku87v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 13:22:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54RBUsHX024593;
	Tue, 27 May 2025 13:22:38 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11011018.outbound.protection.outlook.com [40.93.194.18])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j945pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 13:22:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pq2qp67FzWni3fZYizRzy6UCIoioI4G89az1SV2df5sy/DIBkTIav8sHaj+BdDb5P2+0icX6vLMyJ1PMnEk0eW+74VEN1AtExbXEJYH+2e/QZkjjEyNSKKR4DugLQfvBcAIAhKnI3Y0/I9mEnl6K+ZGyvyi2Zf72j7yRf+IdFKq+aLBBrH3lcgdhQ2ZH2ozS0yuqs3Hga7O0gZ0PgBQksw3TsC+7Y+2b315y8UEBq6sKtq4RJXp+zMX/D55xb0gObL76CvIylwB7BV0RlXqL6IPt2wIgKtTjWkvYB51AjA36auidx2bXZQBGJHNWghyEwOlwePdPPISsmGCU05OSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgTzVSfY1IhNYU5vZHxU9UpEqUv5oH9LoL/jmn3sAPc=;
 b=snRBfYM86Pp1roqOMewoJNiCgluK6MQgr+k2GDJIq9nQ/0+24kipofEijx0xnRYXAVgM5V72rrDD/w1gGUJZkg3fbu49fGRaiVlbuI2vtqu6dqVQ29OwEbImmKtYYSw4JARPls1vG2iMeflXRZ80p2JUg++eyefnCsfA2m7MMJoD++gIvupg5Yi+mKC4svX+YRdlYPa92bn959r89lDz9p4x0tbMXs1GJKRwZpMolMfmtwg7J5dTnjOyz9zpPyYO2tMWsaxBWyJsc9flTIiYpItI8yVn9KbD3N7oCadPA7Gi7wdrWB+x4Ysxs5aNnrZoH6Y9Bkd0bUNulEY7SLKCMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgTzVSfY1IhNYU5vZHxU9UpEqUv5oH9LoL/jmn3sAPc=;
 b=Bz+T/tp6M+M4jAl3bpB6z4eMYpC4EVmoWUZllaVCB8iBfWa05D3YPA6YRBuqcFii39mUbCM5550A20UaSiPVfCAqtFA9xq3Udznpmwiev4Hugks8NWep9INf4Z6vbKxTNOmRoAG0pIp/HlA6yaTb4aNeY2KKZXhniBs124lOT1c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8757.namprd10.prod.outlook.com (2603:10b6:208:57a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.36; Tue, 27 May
 2025 13:22:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.035; Tue, 27 May 2025
 13:22:36 +0000
Message-ID: <a464374b-40a8-48d6-986c-ed83d1d81394@oracle.com>
Date: Tue, 27 May 2025 09:22:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Questions Regarding Delegation Claim Behavior
From: Chuck Lever <chuck.lever@oracle.com>
To: Petro Pavlov <petro.pavlov@vastdata.com>
Cc: Roi Azarzar <roi.azarzar@vastdata.com>, linux-nfs@vger.kernel.org
References: <CAN5pLa6EU6nKe=qt+QijK1OMyt8JjHBC2VCk=NMMSA4SJmS4rg@mail.gmail.com>
 <2529724b-ad96-4b02-9d8e-647ef21eab03@oracle.com>
 <CAN5pLa4z-v9MSwZCxbW6oMy1Fa=b9GFEwmVxdDTnguO6_9-f_g@mail.gmail.com>
 <8b83e1ef-867b-4b4f-95b6-9dc03d6d591c@oracle.com>
Content-Language: en-US
In-Reply-To: <8b83e1ef-867b-4b4f-95b6-9dc03d6d591c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:610:b2::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 72485ce4-f179-40a5-4cf2-08dd9d218bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2tOWHdhaUM3WjRoUVR4dmY5TldZYXVZaHJBMHM3K1c0QWJnQ0RxdWNCQmh5?=
 =?utf-8?B?UXJlaElsenp3M1VOKzZlU0hkMU1NMHVpVXVHTHdKMmxUSzdWeFE3enQwdm0v?=
 =?utf-8?B?aHgraDlCanpOYTZ6YkZGY3NSbXZ2R3dMZDJCWU5iUStVQk9MRlhHRkcrb0c2?=
 =?utf-8?B?enowNzJnb3dNdTFPOU1zY1NabDE2NjkvU2V6QXFUNXBTMWVhbFpKUm9zaUpY?=
 =?utf-8?B?a2xjQnhGajZxd3ZIMG8xcVpxSzcrRnVYdVpRZngwbUtlSFpSOUMvWWsrenpD?=
 =?utf-8?B?Qkp1Mzg1ZzdORUpJVWQrQjVnOHk2dWZZdFJPMTl3TjFIVkZSZ0VzaXF0QnRn?=
 =?utf-8?B?bXhrQUhoOFQ2UDJDRU42cllDSGRBeWZ0OTNITi9XazE0OExPcEcwTlNreklF?=
 =?utf-8?B?ZWltY3FGZG1UMDlrVDVSSXVxM0VFU0E4eGxOV1N4YjFKNk54VG9nZVRlaFdn?=
 =?utf-8?B?MTVER3AwdWNBaFlHMG5xZzU2VWdtQXRpdWdKREtKazFxMDMrMGhQVHlkZU9y?=
 =?utf-8?B?bnlYcytKWEo5Rk01elAxUmZSazQzY0xuazRabnFyWlluYmFjdmM4ZzA2UGlK?=
 =?utf-8?B?TGF3aFhhbjl5RGUvYlAwVDNjMzVhSUc1eTA4Z0ZXd3dKaVk5UnNBZmVuQi8y?=
 =?utf-8?B?cjlDcjVlTjZIU2llY0NqR1krQ2NjZXVVdEt0WUtJejgxRDB6UUUrbndHSzdu?=
 =?utf-8?B?MEloL3M4bEFqcHo5MytpL0hTUWl4cTRrUnRlWk83Zi9xcHZ4TG16SkQ2NFN0?=
 =?utf-8?B?Y05HMTRwNEdUVHp2WmhHRGpIWTZxMnNwKzFET2x1MnBJNTllbkJKeExuQm00?=
 =?utf-8?B?ak1KMmZtcDJwdW5HZ2tJdjEyWU1EVkloWGpFQVhjODlPMjVRV0dESi9ENERT?=
 =?utf-8?B?ZVNNdkZlVlk3WldxcmRZM1pYK2RWcTlmTmlFazRGUWZTTE1hb21RRFpmNnNh?=
 =?utf-8?B?NU4zT0MrdjBvdysrS1U2dzRIQTk4bk0vdXRjNXhnOTRTbHh0QWk0c1FWWEtm?=
 =?utf-8?B?MG1LRFdSYjQ1TzZjcVFFUi9lUWxHWnJmSG1aY3Yrczk2OThmMU96TitlWkRX?=
 =?utf-8?B?YXBtaDBEbEtOWmd1ZTdabVRIZXlYSDdneHNPMmFjOTFvcFFaaCtRVmdJT3hn?=
 =?utf-8?B?S1lDMDdTcGUxYUhibzlZbndmRXI3T2dqc3Q1WVJkOVAyVGJzdnlUbnErRjky?=
 =?utf-8?B?L3pxcVcwWG9mK01TSmFaS21JeUN6VllxTVpmZ3JQRC9yanhyRFliYVAwa3pn?=
 =?utf-8?B?bi84Y08vN2dENjlWR0RhV0ZDMmwrbEw4bE5KUHlwanpZb1BsK2IyREpJd2lT?=
 =?utf-8?B?aEFodUl2VlZzeXoxcWsrUXZmdlVQcWIrZXBwUFQraEtJdXlSRUV0dDFTOXdu?=
 =?utf-8?B?VnhTUU1nV3NleEV3ZlE0NHAwVlMrbmswT3phcmNLOHBoUDFpWCtwRWxlTjBv?=
 =?utf-8?B?a3JFeEVrK1d3Q0JJaDIycURnd2xtNngzelA2VnlFcjRoQllIT1FONVBXMjFE?=
 =?utf-8?B?SENmeUVoTDJBTWNmMkdCTUxjZTRJZUoza1owYkRyTWc4ak1iZytJbWltL0Fr?=
 =?utf-8?B?ZXVGd2RlQ1BuV0w3a1FFQVJpcXRnajNlckFWNmZHeVUwbjdNK29UdUZESW5Z?=
 =?utf-8?B?dHV2WSt2QjdhdlpxWkxBWjJrcXNpNEFTTmlMcmlIUlo3RFh5eEN6V2dZV1Zk?=
 =?utf-8?B?VGtQZWY4Ym9VQWk3NHdzbzFncDUyUlJUQTdVZ0U5RUtpNUQyaXlJY1NCVjdo?=
 =?utf-8?B?U1BOWnpVU0ZjSXB0RzVFQTRVbHMxV1JwVnZRMHdUMUVLM0dEZVlMd29Vc0pK?=
 =?utf-8?B?Q3JwaUVJcVVTeU1ETUVPcWk3US9LSzhqN3c3VUpqOHZZYUVoUjFHSnJUTEZz?=
 =?utf-8?B?ZXRMMkw4MXoxb3BvUVJkOU1vT0JQMVR2U0l5TjlYdFFnZVZ1SVJZdGVBRzhh?=
 =?utf-8?Q?QHMo5W51UzY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OC8yOUlMR2V0TGlQWFJ0LzVCeDQ3MWtZZ2NZN0k4QSt5cVVyTnlyK3Erb0o3?=
 =?utf-8?B?bFNBbkRMTzNLaXk2czhuc0FCNlRMaVErdUUvQmpOMG1Va2FKUWVmUHZXeENB?=
 =?utf-8?B?aUV0d045VHlhYUVyM1Yvd3p6QitsMXgrSFZBcVhCcDJHc1hNdy9KcDgrUzNk?=
 =?utf-8?B?NExYSC9uOUFLTllRR3VSMkZTdTc3SnE3dGFiSmM0QlFwdmRja3lKQ0s4MW1B?=
 =?utf-8?B?b1p4dHVJWEtHeFJlNWs4bUhPbSs3MmF6S044U2VaL1Fjd1RnczZ0cW8xRkpU?=
 =?utf-8?B?M2h6ekx2b1F4Y2ozYnJmR3lGMklOcjJlRFRqblBsODdyRnJRQmtJdCtRSzRV?=
 =?utf-8?B?WG1aY1YwMmkwSWoxV09Sa1ViMjBVT3hUZkhWdGgxNklMeEo1ZGJNTmUzRkpT?=
 =?utf-8?B?aFV4SUVOcVMxTnRXcGVtbjArOGlDa0t5NU5DNlZwK1ZRT0U3VWRlS0VaR29m?=
 =?utf-8?B?MnVQdDNoTEpVVU5GbEJGK01TTmNUTUVwL1pId21WbzdmTDBuZ081VVMrL2V1?=
 =?utf-8?B?dGJ6Y1FqNUNHOXZSdTM2dkc0TFBaZWVQMzdObkhYaUdtZVNpYzgrcm02RGdP?=
 =?utf-8?B?WjhtQTdnVjZzR3ptbHQyMi9BWVVrVjVyNlVJTnE3Qy9FM2VEakFGYllaNlNW?=
 =?utf-8?B?U1l1NXAzSFB2NU1qNXRhRU9ka2tkYlI1NmZYMVBraVNHNTU0Q0kwRnVvMmVJ?=
 =?utf-8?B?N1dES0NmNkFJdXZkWXVRRldBVW1TMG01QVh1MlppR3pYSmhkeWdZRkJ3c3hS?=
 =?utf-8?B?ZG5QODRZV1Jlankwc001d1dZM1RFMnh0RjlJTHVSaEdpai9SWFVGY1BBOVQ0?=
 =?utf-8?B?SnNVU0duUWo0THBPb05lUE9HRHFtd1VkWnRDRXlEaGNGL1FqcDJ1NmNaajZO?=
 =?utf-8?B?Y1JGbGVMSUk0MFg4YjhQbys5ZHpkWFZFRjBQWnpUenZBV0w2a3Z2bUpLeWQ5?=
 =?utf-8?B?MzdEWHZ3M0JZRVBjeWM1NkpJck02ME5zK3BaQ2g1SWxuVDhNbk9sWnlub3Rt?=
 =?utf-8?B?OUpPSDNMZTFrQmJjd1kxdjhKcXUzN2JoMURWOHZkaG9KbTNtRU5MSHJzU09n?=
 =?utf-8?B?TDFLck1oc290VTJ1YTlxZVpFZE5DbW5TUXA5cHFXd1kzU0xzYzM0aHVkNDE4?=
 =?utf-8?B?bVN5NWthTmEyVUtXYVY3MVJMdGoxMEFORFNzSXNpbTdlSnRWYTBSS2FvdFYz?=
 =?utf-8?B?Rm5YL2wvSHBVdWRUMm1OZ1BncnM1VWJvVENQekwxUVMwY25zWTdKelJvZ3Fx?=
 =?utf-8?B?eDVSRExtWWtOWjlzR2pCZENqUm1xWCtyY3hsMU81Nys2OHk0aC9pamcwTmlP?=
 =?utf-8?B?RVhicHFqQlFudnZiOHR0ZVpteFRuU1NlZnhyM1lhSmNkTXhaUFdOVnpLNFh6?=
 =?utf-8?B?YnFPdFRDdXc5N1BXR2QramZFMTBRcnhrZm9lQmtpaXhFZEs5UkwxZFJsYnVr?=
 =?utf-8?B?SEdreGtxYnF1a2NMZWNJd0hoVjRQSVNTTE5Nc0RyWnhocEpzNm4rZlV2QXRj?=
 =?utf-8?B?V2ZkOWhBOElOaUJKNkwvZndvUWh6Nm45eFZtUmpGbWtpNUNhN1ZYQ3NFZGw1?=
 =?utf-8?B?Q08vYWNjcFdYcG5CemdoRUhMNExZSEZacG1vcUN6RmE1U1A4WkkvN29CZlNZ?=
 =?utf-8?B?czQwTUxPQklVY2JvaW1WdWVBZ3FzWXNGZmozcERqbFBrZ0lIUzMrV0NnK2pP?=
 =?utf-8?B?OTFNZUxkbjBLaVlWek8rNW41ZjFsSmk2WnAzMmQ1c2lZSUFxVDVBVmJIWjFx?=
 =?utf-8?B?OFl5Z1ZMaGhwdzV6WnBxbENkRE0wYUpVVXBrcmN4UDJybTljU0VPT2Rucmpu?=
 =?utf-8?B?WCt2V3drbjdmTnFZK1RMck9QdC82SUpNNFdjbWM3N09NL3hxMytBVUU2Y0xE?=
 =?utf-8?B?M1BUb3NwOG8xZnhoM2JxaVlmdHN6V3dqU1JNZ2hXSTZXNnpsZzIzeHdEMVRH?=
 =?utf-8?B?UVlXZVZwR3VLNmdYMWZQZHAzVkRNd1pDWi9nOUwwRndaUlI2SnV2QkVROHpT?=
 =?utf-8?B?RU5VSWgrZFUraTBuMXdzSnRIVzU5OUxSK2xFUGpnYzkyZVN3ZXV4RVBadzEz?=
 =?utf-8?B?ODZQbVZKYTkrM1hFWkRrSDJnOFFma2ZHMk1keFR2R0JUdTRhM1R2cG9FM0Za?=
 =?utf-8?Q?ui6tXyDvA2iovTfHW9VGJlNXA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p6zrxLCz4n0r6uGwpcJk9g4O4ln++It6av9kTernyWmYUCzfsMB9gj08/XpAYaMAzTizV+G2MEBJBK6msDal7RAQj8OYDoK4XHyxqBAyDExl0YFIY+1hezdx3GQ8z2H7GjS4Bq8WcQ20a6bQX4wWyhAucGFQea5JoafN02Ln9bnnZwZDYaDoV8DpAcP3ra1LpIajsvGBByaz3QhwvwGYhkkLlf0CdrB/ID5gKZwfC89ZFsFBjzy1fbVgZvD5wl4+O8++4iJUn0kQZ0NYyotBFUIAD1MDESk8U/xdwR9GM/ixDWBhYP3pqC+m/cBcACoktR12rVqD/aE3eZ6viILP4iAYRCrhKncpeg2sKWmRLjMlQUcg4EYuEMkLbw+cTHhAqUQ3ZoKpFl7vcBZsyIkpEwleaozBhbPjB8ckkEqKzCInbECP9kCDx3EINGDNSeaaku3qG6C+7+yZQx7zv8hp9JsLvGxlr9+m/c5LNnxGnU6pETXxOPOhnpr4j3maxsZtzcK+z4eGY23RBwHi654u8XRbuO0cmPOQhQXBRVhXh13iXul1NnOo4GlQ7g2s070rEm4bXug3lZWCdxfh/KGXq/TCp+eZX/JSDr4H98PEsok=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72485ce4-f179-40a5-4cf2-08dd9d218bc5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 13:22:36.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xPh0MWQvyyot79Pme8+PHSYrIbcss8FoIj5aJ/8ux0R7262dR4kAWJ91wq8d4DEn85HadfW2+ykBYybD7fPgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270108
X-Proofpoint-GUID: VcwNQXEsRdxjTYqT6rT5dX7yEtfCUfyz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwOCBTYWx0ZWRfX0UjD4a29MNaF 8WVNWTeozsMIHU0ZXeYJQRKcw2F/dN3tB8YDWdc6Brm9xq4VpGOZVFmNTOqyVDvAhXo9ApLVZZt RA2UalC6EYjXMBGnu05oSQ/j8mk3fXVIsZu4ewENd9Z6kYN1g6pgwEvcy9m+ccube1TEfXU58iX
 5UDGdeXpSDrnuyHM4K7U9R9dFxrBTlg/nmz9aITsHkC1rlEQNZhT32onMVqBNJqbn6yhkU5WAy/ Ckz7L6IltT+hwjV3cCYRIEm5fiwfbkzWoWSKkZSyQ9rhyslfW2WUMTAv2hkGm7wwDMxzhn2k3N6 oddvFdH8kluYP3ryd5y1jnySopuWpBgooMw2hCnFpoucqmHEfdlzFcZbld0b6snN7R28OOTXYoy
 ua5jNRn/0v/0k9r3bnUeW7TpRQHLchVP9S8q8WMv6Ftw2Fphokc0Y2qnf2pZgHZpnwQoZ2W7
X-Proofpoint-ORIG-GUID: VcwNQXEsRdxjTYqT6rT5dX7yEtfCUfyz
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=6835bca0 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=UdPGIpkBplL_K4PkCWgA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206

On 5/27/25 8:58 AM, Chuck Lever wrote:
> On 5/26/25 7:10 AM, Petro Pavlov wrote:
>>
>> I believe the following section of the RFC may be relevant to the use of
>> a delegation |stateid| in relation to the file being accessed:
>>
>>     If the stateid type is not valid for the context in which the
>>     stateid appears, return NFS4ERR_BAD_STATEID. Note that a stateid may
>>     be valid in general, as would be reported by the TEST_STATEID
>>     operation, but be invalid for a particular operation, as, for
>>     example, when a stateid that doesn't represent byte-range locks is
>>     passed to the non-from_open case of LOCK or to LOCKU, or when a
>>     stateid that does not represent an open is passed to CLOSE or
>>     OPEN_DOWNGRADE. In such cases, the server MUST return
>>     NFS4ERR_BAD_STATEID.

For the record, this is the sixth bullet point in the final paragraph of
Section 8.2.4 of RFC 8881.

Perhaps this text is applicable, but I have trouble with a compliance
statement that mandates specific on-the-wire behavior but does not have
an exhaustive list of cases where it applies. Such statements are not
supposed to be so hand-wavy.

And in any event, I prefer NFS4ERR_INVAL in such cases, as the stateid
is clearly valid. BAD_STATEID will most likely trigger the client to
perform state recovery, which is almost certain to cause the client to
simply resend the same request after determining that no state recovery
is needed. Lather, rinse, repeat.

But, a pynfs test case or two here is a good thing. The client is
misbehaving, and our CI isn't looking for this corner case. I hope you
are permitted to contribute your test cases to upstream pynfs.


-- 
Chuck Lever

