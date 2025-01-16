Return-Path: <linux-nfs+bounces-9320-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE83A13FB5
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 17:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1276816A71A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 16:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB12522B8A0;
	Thu, 16 Jan 2025 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IAPTtSUv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ir3Czaxf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77181990D8
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045855; cv=fail; b=VW7apcMoOs6/ZBDES8TmQ6MYbltiVK66m1K39bU0jhhhJw+u0uiHxGH8dQV3AeYVF/IBAbt8NM6qAJZB3qdFt9b300ah7qdQTsvUjAfLiJy/OLeZmUwp2zQbqIAxe11jPhFPadv5Y3YRPneqU2KL4Bi35anLFnLCwVwIHywlyaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045855; c=relaxed/simple;
	bh=YetNGJHVg77U8Ut8ZIezimHpA6AySSDmdAlsWsCmEAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KGZxkU8QHOvQ0CNW6CtRzjjyZaoMafD8kmXcrEj7RnIeq9BhYjOynRqbthKAYi+oUtTpMoGURhqg5E24+5RCPWdpmiCtt8A83L5/MdWcnTQ+zp3OQCqQySMG17bF14mrkOOXEzc2xQAK7cu7AF9ZRVADjcTk33Iqecr1ql0UsnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IAPTtSUv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ir3Czaxf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GGfqxl020742;
	Thu, 16 Jan 2025 16:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZbCudIE/E6B8ZsD7Cpckc/UHaJUJE9erJw3sWR+nyXE=; b=
	IAPTtSUvSwk9zkQa1xgs65pwSepYIqyQM7pMpi8OEKSMH5hWBXazOiRgY2DouyhW
	3EbZHTRkG4sL+iahYlO70pUO5yZ8GV4MLBd3r0GKWaAIe/t/oYtsIWzvY7v1ZP+D
	211PmUXTktRjC/EZqHspP67irAtdqNMTt91j+GZ1uLytYjyRThYdzRIrH30N+33w
	SwLmgJiOVAwq0rDQ0xM8J3Cad/ZQ6qGkkl0NIJFl88799MeSkgn2rO9IjAayjpq5
	oVFSjlAwR00qYQ4z/ppRp2FOdO8+mCSbFoPpcxK4d9j6kF5vb4GrIrC1EsQAIXdh
	g6qfcsmagjs3BhZhCCQX8A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 446wtp8ytm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 16:44:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GGcUks020411;
	Thu, 16 Jan 2025 16:44:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3hcpcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 16:44:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bgv6Qi9LcOiJsvumxH9giPrrWuuYpKzEM1n6IzNnreMat0aQSjOC4+5YV4Py8lrBISfRDtVncubJMCIFU1aAq4tUo84pRaRY7xa9EyJORrie04vOtKTNIwG/ut9AxAFHRs0n4/IBFfn21qYFqIwo3KNf3inqUI+e+FdV7xHcvlPFAE7oB1zBfXlDp7u2LX8fZBSJmbI3Fq5vWgekvRpxSp4aPTS7+lZjx5P5vzHIdl7oHoPgQx3WfxEyWz2o/YZndt0VB6ZIm9TGDkRBI2e0axHWzo3PC0NM0aff5mRlZTXgiy0FsK76/2OJ41K7InVU+9tujqRmVqxwpXM80itzyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbCudIE/E6B8ZsD7Cpckc/UHaJUJE9erJw3sWR+nyXE=;
 b=qv83zzqVCInCMj0TAMO90gKTWvskxcogpPED035VMiR8NlWq/X2DDrm48mi+ifk05CxGoyYI+qyRzjzy39wn6A15ApCAnOqzBM2VlAV7GlM/pArydmI3WjZFP6jEgK47WJNxe06SL+wcq1sM8R8t6LtCx0OcEUGlAzh9BJ0XeeLBqXZvEl+CLjQrI9o/LTgdCh2+PBnZhi+HLOD6dW6gVhgfeuzXN2ADGcJda06JCIFbM4ZiAtZV6OR5VS+bcYT7cWxYqC5Z95GiM8+i8xNFBNmUC2/jU8rvffT8W/wxOcIGvPVtlDzEnwZ17OZN3d2w1+ViwULSs7pPycBC1K2NLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbCudIE/E6B8ZsD7Cpckc/UHaJUJE9erJw3sWR+nyXE=;
 b=Ir3CzaxffCfNar0VF9cc42oa+avHKshGv4OWvqUaPmMVla/Pfb2BBq2/KzrBR/ypX/S6Cpap661LTSw3f4anmdR2cSVj5mm6IimYMd/YNic0SJMXtfKc6B/BidTAMXo6pnTKX/qJ3OxuPNMN1pBEtUl4HtLCmNHz6AJ59fdnxio=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4797.namprd10.prod.outlook.com (2603:10b6:a03:2d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 16:44:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 16:44:05 +0000
Message-ID: <1c00785c-a90b-46d4-ba65-a3267d53506e@oracle.com>
Date: Thu, 16 Jan 2025 11:44:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] llist: add ability to remove a particular entry from
 the list
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20250115232406.44815-1-okorniev@redhat.com>
 <20250115232406.44815-2-okorniev@redhat.com>
 <b469204c-adb7-4cc6-a8e9-dfd19ee331df@oracle.com>
 <CACSpFtAgN7+7Bwa2dQckdC++QF-zP-ZBPyiphqoV2VgPatQt1g@mail.gmail.com>
 <f2c87e35-2ce4-455b-bd1b-e567123b368f@oracle.com>
 <9757da07ce21d1c1275c637ae49cbe69a9c83a71.camel@kernel.org>
 <b4b38fc9-3a0a-4324-b7c9-5e080ef492a6@oracle.com>
 <CACSpFtB-uLB0kTvggQ6KvEMQe7xKP04SkzaAfcadQkFsMBtgQw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CACSpFtB-uLB0kTvggQ6KvEMQe7xKP04SkzaAfcadQkFsMBtgQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:610:58::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4797:EE_
X-MS-Office365-Filtering-Correlation-Id: dae0b926-0b27-47e2-9c64-08dd364cfd30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUVoaHFDYjlyZHQ0MkpWTmFHd2hRZzZJVUlhYis2VG1FT3YrQ1hYNWtKNFVD?=
 =?utf-8?B?dkZvZzJqUWhCeE8zNVQ2NkdhNFF1OWtvNVBESGtLRTNrSm1mK1NGQUhJNS83?=
 =?utf-8?B?cFA4M1d1SWNRb1RFd1BSZ3FlS0VjSldOdjFhTzlxaVlhbFJCdmFkK3owbXF4?=
 =?utf-8?B?UmtlYlhHNTkzc205U0NLVm9WSjhhdnVOL2VYTlJORU94V2U1azV5dVEyaXNx?=
 =?utf-8?B?Tll0MzZXYTB5ejIvSVVnUlFITlVFNmFNaVczdEZzeTlWemh0Tm1jbTVpeFA2?=
 =?utf-8?B?YWFJRHliSGVtR09BUXJ3VEV2R1dDcTFiWHVQWnQrM2V6WEU4MkFtWjBGTHB4?=
 =?utf-8?B?U0I2alJyd3o4RHpwNlZrZUQvM20xMVF2dDNRNVBlMGxlblBWS0UvVUNjK21F?=
 =?utf-8?B?WWUyeno2VlRFWjBwMUdYZnRqUDF5WW5mWWYxR0lkckRaRjRNbUdvU1ZVaVZw?=
 =?utf-8?B?VGtLeGIybXRwTEM3TnpWSXJ2Zldkc2FCSzVzVmxEM0pHNkFuZW5rdDVEbEdL?=
 =?utf-8?B?RTJHTDlKaXZoWG9WOVJZdlNGRUlTQW1IYWx3T3NzelpUQjlPSWQ0V3VoL25Q?=
 =?utf-8?B?cDJpTmp5c3JaK3pPekZwM3ZlUW51OXpoK2RIR0Q4cDRTbngzSDZYTzFncDVO?=
 =?utf-8?B?SlRCc3o0MzZVVFhheGFzTHhRRCtUa280c09FUk8vYy9ZR2FuM2xYSDUvdGRx?=
 =?utf-8?B?ZjNqM0ZFV2dMRDhPYk9aOFZlUmwzbmhuYlR1RnBabTIyZmFrY0F5aUxTSTBE?=
 =?utf-8?B?WHRydi9GRGg3VWZxc0Y5Z09NdzYyMjVXTzZHYWlhQUtodTZpNzhxSmdRUFlj?=
 =?utf-8?B?bjZTNG82bDJuVGlycnZ5aHc5eThWeXlwcEVFKytDSnJqaGQrNUdNNWg4OEZ5?=
 =?utf-8?B?YWVWOGJYLytWZk1PdDVsZlJQeHpacDRCVHllT2oyYmZrVmdXUGpiUnNIc3Bn?=
 =?utf-8?B?Y3VydU4xaXE2d2wvRE9QL2hIaVU2a2lKdCtSMjAwU0ZUeTFCK3VReEVrUVM1?=
 =?utf-8?B?VFlTcVJZdTVsU1VZc0ZHOEhRcGFPRnh5UFBGZTZGNUZGV204a0xkUm04bWFK?=
 =?utf-8?B?U0F2VUp5eUFnQ2ovbmcxY0VxTWxkSisvSTlzcVdaQ0VXa1RXTEdBd25GZU5a?=
 =?utf-8?B?Ykt3cGYyU2s3RDNTMXJvQWU4ZEhQOGNackFBdXpqYmlDSldRNnZHY1Z4NmlD?=
 =?utf-8?B?VXZ1bmN3cUhmYlpUNS85a3JIZVdjbEREazNWYjB2WlJya2tnZ1BPVzUxZzdo?=
 =?utf-8?B?VE1ZMFc1dmxQNUhDd0l6K1ZiaGtRYUpRUlR1T0I3N2JsZGdHYXh5bm10a3Ix?=
 =?utf-8?B?VWJ6bWZtSVBlN0xpNERuTWprei8zR05remt4anI5WkxUUS9KRVRKYTR0S2FO?=
 =?utf-8?B?NGtjL0xvczJoemM3ZkxFVXoxNWZaZlpLR0ZrbGQ2SE56S1h2WVJ0dm9WUEZv?=
 =?utf-8?B?MjVDdDk4cU1sTlZFUkhkUk9KYTFxdENESytiK0ZRbTZmR1ljWFgwc1JveHda?=
 =?utf-8?B?NXNkckhkYmN1czNHM2JyQ0V5b1FucVRTRUtaVTN1NmZlVVB3V2lUbWhVNUtT?=
 =?utf-8?B?Y0x3VXhmYi9PQ3Y1S2pra3pKVHR0UTBjUFZnclJNdnVQb2dqSnZoZmswak5M?=
 =?utf-8?B?OFBETXR0Y25ua2FpeVZWRFZRUWl3YTNzaUppdFdVUkI1bjY2SmZVWmN6R05I?=
 =?utf-8?B?OTV6Qm93dmVZTFAzcnRzekRONmpPUFE1cWJKMnNZSm51bzQ0NllGdkl6Q3BP?=
 =?utf-8?B?eFlDa3kvbEtySlBqRUh2clVPM0gvd1pJTmRLS0FOdFRGamthektYREx5TlQz?=
 =?utf-8?B?ZTV6eS93cVE2WU81TEM0dnlVZDRoOG1FMmlyYThzRUM0TmtOZ243eXJISWRv?=
 =?utf-8?Q?RqoWlatOVquq9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THk5MEswcVJsMjlXdW5wOUhxL25kMjlwRDlIU0FEN292dHZUOHk4dlZtYWpJ?=
 =?utf-8?B?Rm94TDFvSzhmMjFaSWtwaFBFdFVBOGdFOU5EaVYxNlNPWXZRSmJJUlJDWits?=
 =?utf-8?B?ZTBqeHJuWXo5WUFIQzRGSEpmZHlYRTBLWGhBMjdTNzlKaHlheks1WkNGV3FG?=
 =?utf-8?B?bG5UQ05qUVZwWWZPRDNXNDV2NVdDek1LeDhVaGNmV1Z1aXdaczFRaTd4UDJB?=
 =?utf-8?B?R3g2TkRyRENGRFdUZ2NObENjYTN0dnRMSnVuMkZKaTRXUWFSQTNRWnRiUXYv?=
 =?utf-8?B?SzhscDMzdkpLaExBRVE3cXA2WXBuWS9rVHorcU9LTXdNRlFNRDFtMUJ1VmlW?=
 =?utf-8?B?elE0YkczK3NuTDBmVGc5blpPeVN0QklVMUZJN0RoWUs2SWowbkJERHZWVWJi?=
 =?utf-8?B?aXI5SWRMT1BFdjBCc3c2akRhMlE5ZS9RSE5CeFJ2ZDJHTkIwbHhpeS9kc3F0?=
 =?utf-8?B?WWdsUUxaRi9LTVM4Zzk0NEJOMzZvTytsa3U1aE1mMll6bEZjWWVSaUhmc1Qx?=
 =?utf-8?B?WVQvdk1FNDl4em4rLzNlSG85K0xFeStyejZMazhZSjc4ZWRzLzgxcWlINkxy?=
 =?utf-8?B?K2dWR1JNdFd6M0lvVlE5TG1Idm13dWpaLy8yckczelF5NjN3RFpiNmYwQUdk?=
 =?utf-8?B?c3FJSVBkQmJqKzJKcUJtSWxnYldEOEhwZFRjQkJQOXJRdkpBSFJNM2NUTEJG?=
 =?utf-8?B?K1U1NHVab0dPTy9kUFJFZlF4b3lUZ3Z3UVNMSU9PNTg3MWhNY2Ftcy9samtz?=
 =?utf-8?B?SytaRm1aWVJXbERweEx2RVF2ZURVRnViK01aU3poODgrejhnM3dCdHlFazJH?=
 =?utf-8?B?dndTZ1BjaHhFREVLQmNFSHFSR2pUSlhvWk5nZjF5ejg4RGdycmdUU3hPcUFk?=
 =?utf-8?B?QmlkdzQ3YjBGY3l1azkrSzg4djhaY1ovdDQzc2owY0Y2UXZmUlBvLzh5T1pt?=
 =?utf-8?B?aW1BTmFDVHRsbjFwelljTUdKL01jWmljelo4a3ZBVUFyUU1nNlRkcE5kdW81?=
 =?utf-8?B?TURROHRLalkzNjdyMFBxUWZrK05sczBKTHRwZ2VrUm8vdDlKMjdNTVpZUk9s?=
 =?utf-8?B?LzFlYy9jdzZHN3RCaFd6cGptbExHYUhEd0s3a0tESDN0L1BqWkRzRFFQMmNP?=
 =?utf-8?B?YjdONmdTS1pOMVRGQlR1Y1R1Mmg5NWlOVSswZm9obkQ0aDFuaWVwTWc5VG90?=
 =?utf-8?B?djdidFJQaFdWYWliWWhwc0J3aHJudnBOVDYvZi9kakhMRnN1RzQ2V01TMnBL?=
 =?utf-8?B?NTgrTGpoa3R3ZVBwbHNsZVEwRGRzanh0bWFLaGRmR3VlZGNZVlVpeG5OWVI5?=
 =?utf-8?B?cmp1dUZzSEhwQ3EzdTJJM2RjTytLUDZmQmRoVVg1YWswaDVvZVMzcGQ1RVdO?=
 =?utf-8?B?L3AwdVBLK3lqblRGV3FPUi9XMGVMMHoyZTh3eHBXdENObVdUWm0rY3k2ZUZC?=
 =?utf-8?B?Q29UVVQ2Y3A2d3g2NzdpSTc1bkhYbFB2OEFadmU4RlVpTkVKWGJPVkJ0OFhF?=
 =?utf-8?B?VVdVandmV3d4QytlUCt4czlhcFd6NXo5ZGMySVRFNUVBdWUzQUFjTEZRclJ5?=
 =?utf-8?B?YkpYR3NPcE5KQ3ZTUjdyNDFWd3hHazlzM0FHZXhtQkRXVHh0TnBrUkE1VVVl?=
 =?utf-8?B?RmduSk9BS2J0ckwzMnZOaGIycFlBYm5MZzdHV1Rpd3ZjTFBxK2tMaU9zZVV1?=
 =?utf-8?B?OVVQVmRpd0dTSk5yM013OG5uV3NZSyt4SCtVQlBoU2pBeXFna2V4UkpGNlJF?=
 =?utf-8?B?SUlVR0ltdlAraUVvKzJweCtRSXZjbnY1S0pybzNuMFhhSkdxUlNYemZUU1FD?=
 =?utf-8?B?dmdEVUloeTB5c3hxV0ZvbEc3REpFQi9IN1gzYVREUGF5aDN3M2hrZHZOTDlG?=
 =?utf-8?B?bGoxUmNkQkJoa1pwWXFKeXFreGhaK2JFSjF0U3BzWkxUT3NRNlVieGt4Yzd3?=
 =?utf-8?B?Qkk5Rktnc0VBSlBKa1F4SFluOEM2VmRvdnhHTll1OTc3MUtBNGZPK3JGVU45?=
 =?utf-8?B?WTV4UjlDQ1hJeUhTMTN1eDBDMTVnVnhZUlFGditIcTREcWNCdUkvYUlHdHlp?=
 =?utf-8?B?SWk1cnYrMEJYZXdzdHFvV0YrZU5XTGo3M25oWGx4UVNNc0JGSEtzTnNvUFBx?=
 =?utf-8?B?Q3ZiZkVsRkYzNmhxUXg0Rlp2bStsTjhFUkFNNk5DOGtBK1NNM01odjZKUk1j?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qVKSeRGfc5Wcty8HDESDTDXCuM6jGjk2aJ0wxoDSwdib5w1/XmsPzRgNye9R6DokuR7mdMqzNCCht9+Jm23CLJEhh3bFnNfbGY6akXJQooMUjmwS/C1CH7adEiS0X8B/2YuMI4xtuFSqGPt2Iavc6hm6Dg6LudK0sgElr8DJv5MTbN7g9UgY3XYW94C/uTDCZWRTkfTihyGPkYzCl2e838xsa0WmzNfxjlhmGVyRfETLYl2H//zHklR7949OisxSIEbcgzMJ0XTx7tKe2MJGvd6lKKSQXpRhA3sKH69MOkwRs04hbPGuDXZeK8PQSME33oglwKz5E+hc6F6+nw3SilhZfLDrrGLX6kK4at2GordfKMMwfvcVvDVIykltaVsHK9J1hvqcFKozk6gaShR0yvEs/iAm2+2ColCdFwwVeqd7NOV1mDkmzfmZtwR2sdYDpkYnox/faLPELUu9GYRtOy36OnX+Era5DZoR8UyDQUQAxmMqb31qqgVqwir9gol4QLDcc/KMR2n1LLyWSrTJvJqqz3Gnjmi8MQJGXRC0PUnhSM86rj4i3Dez5vibvPFKUxeM3rQNdJSeSo4FdcRt7GmUjCsPDRaBXdVYKU7s8G8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae0b926-0b27-47e2-9c64-08dd364cfd30
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 16:44:05.1468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bcf1qdBJDjD9H0eW8Jtv2ZqdRESpUKUGB+UjchUD2uI2neUr34hhvkvzdH9y/GmalAAYCdYunVGJGBEZ5K5Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_07,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160126
X-Proofpoint-ORIG-GUID: tF9OXpTehmhp3QWquaZtXDF9LLzCG7d-
X-Proofpoint-GUID: tF9OXpTehmhp3QWquaZtXDF9LLzCG7d-

On 1/16/25 11:31 AM, Olga Kornievskaia wrote:
> On Thu, Jan 16, 2025 at 11:00 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 1/16/25 10:42 AM, Jeff Layton wrote:
>>> On Thu, 2025-01-16 at 10:33 -0500, Chuck Lever wrote:
>>>> On 1/16/25 9:54 AM, Olga Kornievskaia wrote:
>>>>> On Thu, Jan 16, 2025 at 9:27 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>>
>>>>>> On 1/15/25 6:24 PM, Olga Kornievskaia wrote:
>>>>>>> nfsd stores its network transports in a lwq (which is a lockless list)
>>>>>>> llist has no ability to remove a particular entry which nfsd needs
>>>>>>> to remove a listener thread.
>>>>>>
>>>>>> Note that scripts/get_maintainer.pl says that the maintainer of this
>>>>>> file is:
>>>>>>
>>>>>>       linux-kernel@vger.kernel.org
>>>>>>
>>>>>> so that address should appear on the cc: list of this series. So
>>>>>> should the list of reviewers for NFSD that appear in MAINTAINERS.
>>>>>
>>>>> I will resend and include the mentioned list.
>>>>>
>>>>>> ISTR Neil found the same gap in the llist API. I don't think it's
>>>>>> possible to safely remove an item from the middle of an llist. Much
>>>>>> of the complexity of the current svc thread scheduler is due to this
>>>>>> complication.
>>>>>>
>>>>>> I think you will need to mark the listener as dead and find some
>>>>>> way of safely dealing with it later.
>>>>>
>>>>> A listener can only be removed if there are no active threads. This
>>>>> code in nfsd_nl_listener_set_doit()  won't allow it which happens
>>>>> before we are manipulating the listener:
>>>>>            /* For now, no removing old sockets while server is running */
>>>>>            if (serv->sv_nrthreads && !list_empty(&permsocks)) {
>>>>>                    list_splice_init(&permsocks, &serv->sv_permsocks);
>>>>>                    spin_unlock_bh(&serv->sv_lock);
>>>>>                    err = -EBUSY;
>>>>>                    goto out_unlock_mtx;
>>>>>            }
>>>>
>>>> Got it.
>>>>
>>>> I'm splitting hairs, but this seems like a special case that might be
>>>> true only for NFSD and could be abused by other API consumers.
>>>>
>>>> At the least, the opening block comment in llist.h should be updated
>>>> to include del_entry in the locking table.
>>>>
>>>> I would be more comfortable with a solution that works in alignment with
>>>> the current llist API, but if others are fine with this solution, then I
>>>> won't object strenuously.
>>>>
>>>> (And to be clear, I agree that there is a bug in set_doit() that needs
>>>> to be addressed quickly -- it's the specific fix that I'm queasy about).
>>>>
>>>
>>> Yeah, it would be good to address it quickly since you can crash the
>>> box with this right now.
>>
>> I'm asking myself why this isn't a problem during server shutdown or
>> when removing just one listener -- with rpc.nfsd. Have we never done
>> this before we had netlink?
> 
> Removing a single listener was never been an option before. Shutdown
> removes listeners and then frees the net, serv. proc fs only allowed
> to view listeners. To change them, you had to change nfs.conf and
> restart the server.
> 
> The problem here is new code that didn't handle a single entry removal
> correctly.
> 
>>> I'm not thrilled with adding the llist_del_entry() footgun either, but
>>> it should work.
>>
>> I would like to see one or two alternatives before sticking with this
>> llist_del_entry() idea.
>>
>>
>>> Another approach we could consider instead would be to delay queueing
>>> all of these sockets to the lwq until after the sv_permsocks list is
>>> settled. You could even just queue up the whole sv_permsocks list at
>>> the end of this. If there's no work there, then there's no real harm.
>>> That is a bit more surgery, however, since you'd have to lift
>>> svc_xprt_received() handling out of svc_xprt_create_from_sa().
>>
>> Handling the list once instead of adding and/or removing one at a time
>> seems like a better plan to me (IIUC).
> 
> I'll attempt an alternative that creates anew.

Thanks! I appreciate your work on this.


> I don't understand this
> suggestion to "wait for sv_permsock to be settled". How can you know
> when nfsdctl is done adding/removing listeners?
> 
>> Also, nit: the use of the term "sockets" throughout this code is
>> confusing. We're dealing with RDMA endpoints as well in here. We can't
>> easily rename the structure fields, true, but the comments could be more
>> helpful.
>>
>>
>>>>>>> Suggested-by: Jeff Layton <jlayton@kernel.org>
>>>>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>>>>>> ---
>>>>>>>      include/linux/llist.h | 36 ++++++++++++++++++++++++++++++++++++
>>>>>>>      1 file changed, 36 insertions(+)
>>>>>>>
>>>>>>> diff --git a/include/linux/llist.h b/include/linux/llist.h
>>>>>>> index 2c982ff7475a..fe6be21897d9 100644
>>>>>>> --- a/include/linux/llist.h
>>>>>>> +++ b/include/linux/llist.h
>>>>>>> @@ -253,6 +253,42 @@ static inline bool __llist_add(struct llist_node *new, struct llist_head *head)
>>>>>>>          return __llist_add_batch(new, new, head);
>>>>>>>      }
>>>>>>>
>>>>>>> +/**
>>>>>>> + * llist_del_entry - remove a particular entry from a lock-less list
>>>>>>> + * @head: head of the list to remove the entry from
>>>>>>> + * @entry: entry to be removed from the list
>>>>>>> + *
>>>>>>> + * Walk the list, find the given entry and remove it from the list.
>>>>
>>>> The above sentence repeats the comments in the code and the code itself.
>>>> It visually obscures the next, much more important, sentence.
>>>>
>>>>
>>>>>>> + * The caller must ensure that nothing can race in and change the
>>>>>>> + * list while this is running.
>>>>>>> + *
>>>>>>> + * Returns true if the entry was found and removed.
>>>>>>> + */
>>>>>>> +static inline bool llist_del_entry(struct llist_head *head, struct llist_node *entry)
>>>>>>> +{
>>>>>>> +     struct llist_node *pos;
>>>>>>> +
>>>>>>> +     if (!head->first)
>>>>>>> +             return false;
>>>>
>>>> if (llist_empty()) ?
>>>>
>>>>
>>>>>>> +
>>>>>>> +     /* Is it the first entry? */
>>>>>>> +     if (head->first == entry) {
>>>>>>> +             head->first = entry->next;
>>>>>>> +             entry->next = entry;
>>>>>>> +             return true;
>>>>
>>>> llist_del_first() or even llist_del_first_this()
>>>>
>>>> Basically I would avoid open-coding this logic and use the existing
>>>> helpers where possible. The new code doesn't provide memory release
>>>> semantics that would ensure the next access of the llist sees these
>>>> updates.
>>>>
>>>>
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     /* Find it in the list */
>>>>>>> +     llist_for_each(head->first, pos) {
>>>>>>> +             if (pos->next == entry) {
>>>>>>> +                     pos->next = entry->next;
>>>>>>> +                     entry->next = entry;
>>>>>>> +                     return true;
>>>>>>> +             }
>>>>>>> +     }
>>>>>>> +     return false;
>>>>>>> +}
>>>>>>> +
>>>>>>>      /**
>>>>>>>       * llist_del_all - delete all entries from lock-less list
>>>>>>>       * @head:   the head of lock-less list to delete all entries
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Chuck Lever
>>>>>>
>>>>>
>>>>
>>>>
>>>
>>
>>
>> --
>> Chuck Lever
>>
> 


-- 
Chuck Lever

