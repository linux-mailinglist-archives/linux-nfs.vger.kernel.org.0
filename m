Return-Path: <linux-nfs+bounces-14134-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D564B49A92
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 22:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B13205D9A
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 20:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941492D77E2;
	Mon,  8 Sep 2025 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DwboFt6i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mDSfh3Pk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5766219A86
	for <linux-nfs@vger.kernel.org>; Mon,  8 Sep 2025 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361777; cv=fail; b=LZiVEg9Epyqt1mAaSn23KQ9EVZMo8/dRNq2BAF76W5zciZ0rKJR1HV0sSyw7uSIXplR8Z44redwjElmMuDp88fhrtsPtjF7SvDAdDQzFEDEj8QJUirsgN1cfHKHKxoEnK8wF8w3MUqKtSwdbILQ1jWvEgMKiKCm45QlagNk5qjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361777; c=relaxed/simple;
	bh=DoLhnp1mzcRXMpM47siz3TF7qHmH/XkrrbZJgNWFnJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KGyfdXy0hSMSeFAvf0Ayh6SvLaVSzOzTbfVq52qSBRD4W2duBdr8ZjYP7ft4p4DvN2dqoddxSCQ3Ra7gFOJQ0u20mDPlNKcOqovq9o6VROY4UdO94+v6+Fy2vldWpxpBBNSB+oJyhwMGwwGWLoYFqJEoU8wwRAEddXNfPVyvyG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DwboFt6i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mDSfh3Pk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588Hfcvh030099;
	Mon, 8 Sep 2025 20:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W9UZmMVoeUdVMGfUI1MXobF6GplNkOIDfemHdoCMrhc=; b=
	DwboFt6igd9H3kYOGO5C3An/xuZxF5lbAfUPKhODnwq7K4eQ/a8QJfHUYwff3/Eo
	gvX5naSmsWrNAH799nGBB1H5nI/xPlKqwOvaZgHNwHa0MrBC96bD2xVw7P/LtyY9
	UzeXSPJgCpCsCPq+3sbCQmAQfLqQOSfRPsJcvSM0H7QPidyLJe4cMfmFj4xeLYlq
	mMMgfV5XzqfH6cH7SYFkPc9GJ+5ZpDCeWItJR/LE6ABQKwkh41+Vtjx44JEGIIYy
	UsDZJ5fZctmkLZXbWADeUbGge9oGoAgAG+feNdufG0CTgOr35jPxlX47HOMd0tls
	RAWaAzewciieHo/MLtv6WQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shrcfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 20:02:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588IWOk5030716;
	Mon, 8 Sep 2025 20:02:16 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd8nd2j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 20:02:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yb7/8auYo0e76TwcOSdjdMP26zSsKp3UI6sTDhnOl/ogdZNLygoIXRaoy819+gyLV9InWdSyWDvjfnPXTzlSlS3+JAyDn16fC1pDJ8tmOOuh6RII5Q1ore66Qr4aiCt6rPkinVrlcZzh8viXo0AoM/KqGVfKQDPi5BBIoLN94vDM3bMasf2T1YILs9YJg7Azs8+stwfPN1iYU/RnHoRcIlwYS8ib56ZcbmRMNv5j4xz5imykdXMl1M2yvyYgNlHrTPYVfAxlcncn6cKvw205lxSkD2FIBL6wP5s8XOwakIMypCMOKe8gKY/8wayyySFiS0XQDuRnKMVcGTGzGSWieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9UZmMVoeUdVMGfUI1MXobF6GplNkOIDfemHdoCMrhc=;
 b=YnCb/fbFpWYd9mCT7CL/9qYC4U/fWc7eD06uKConFkF5KeIIZAk21QwfZRwFwTToutq8qE1c964TkL5iCWjhrP2izG+myDXtbBTmy9vaN2KfXF58EnMOFCXG1Vp6A47Cp9pFIyi8o8eX1xjLJQTVRZGpMpZ24cERZ1Gx79v07+of5yKc5xCfPAOJm6/ENf1drISW1YHV73IwahCF7ztNjKklkaqJPV7hf3VF233TIFwGz++S4/NRP7u/aJsNJY7p8xMmu6ST3d2pYCCeO5ODmtA+ECkeOl1pX+czSWyp9416qHKqPmqxjAbArPOo8zukHKyg9lqaYvUJS4xD7Jm/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9UZmMVoeUdVMGfUI1MXobF6GplNkOIDfemHdoCMrhc=;
 b=mDSfh3PkBVUFRTkvYs2Gq5rjJv8rtBJOkU40LZ3xlGa+kDAnmmb5y50cinAlGn6yiIYyFn0z05LF1LKdUPM3h8B+Hj5Q+HfnW/Ou8s9NFGxilo8OuuP+UX2Ttlx+nOIwULPT04pSI7v8lBnw0IjSERu4X6w7t2DuGujpM3st6M4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5888.namprd10.prod.outlook.com (2603:10b6:806:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 20:02:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 20:02:13 +0000
Message-ID: <5337d2d2-2690-4f5b-bd5c-d41039c527a7@oracle.com>
Date: Mon, 8 Sep 2025 16:02:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cleanups in nfs4reovery.c
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20250908014348.329348-1-neilb@ownmail.net>
 <4af61e35dc3a3af9bd25e10c1c02d9d4f43f5db7.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <4af61e35dc3a3af9bd25e10c1c02d9d4f43f5db7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 08771569-1438-419f-6cb3-08ddef1299e2
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TXgvYjVtOVZ6aG1tbXFPbHpReGdaTE9OQlFRcUJEYUY3OW5QNEcrc0JnRDJy?=
 =?utf-8?B?SDFRaUxvT21iVklFbi8wNHBiVFJaS01qSFNjWnFDQ1pNVVJFdmI3Qy93cWRI?=
 =?utf-8?B?aXRlMG42Q2V4elVYQU5QK3QwaWtzQkJxeXhvMm1ydzFWblEzYWdqMkRBQUlP?=
 =?utf-8?B?Y1hPaS8vejc4dXBZYlRvSkNTNkpqblBHeXR2MXQzaU9sK2V0YlZmaytZTEI5?=
 =?utf-8?B?cnByTzZRVHVQY01iUmxhSkI1U3A1Rnk5UC9JUFlGZU85Sk5INDJRajF5eVgr?=
 =?utf-8?B?TGYzUWxMblJrd3l2MGswaFo4bE9Fd1hVRjEvc0tzdVJGWkxCL2hablJ6WGNu?=
 =?utf-8?B?NFJoUm5xb0hqZEhrYk1kZ3RNTWs3OURLcHdlSjRlZElXU3ByWlRTVXpJdWZz?=
 =?utf-8?B?QjVRNU9oUmZFazNOckpKM0xzK1BqQVQrZTc3TFEzUHpNVXF4dTlHVXdmckt0?=
 =?utf-8?B?K25JckZSd3UwY2NwVnNhU3FlZkZhSmdaTlRidVZ1VmJhNlpLRlo2NkVQQ0gz?=
 =?utf-8?B?REx4NHlUVjJ0TkwyMXlhSUk5dkYvUzNTdUFFckJZRVJpMVNBL0t1Y1E5WGtG?=
 =?utf-8?B?VXg4S1pkcGQ4NTFNWlhKL0JVUU1VUHc0VitBN2N1YWx5SVFGazdTTVNvaU9M?=
 =?utf-8?B?MWZNSStqbklORTJaVlZTSkw0bC9tZWc0eEJEZEVoVTZXd2RHMUNpRlk0RDZS?=
 =?utf-8?B?TkE5QjVEME0zbWU0UnY4OU5SaE0zUGNtTlFKTG5rREVJLzVqQVluZHZVVzVM?=
 =?utf-8?B?N0FONjM4V3RtVHBRdUpXRWxZdzR0VnZCWG5TTjRVcHkva0hyTEptTnlvRjJ4?=
 =?utf-8?B?ZmU0MmV0dzZ5S0hPWlZ2YWlDRG9HRURvQUVnTEtwWVZ4aVJ6Tkk1cUtwcHVK?=
 =?utf-8?B?NGUwYnNvUSthNUF5ZnIxWEtQbGw5OGFhbXc1UmF1K0xBRlhpMWw0OTJPYi91?=
 =?utf-8?B?L0VzbWpmYzdUVkNKVXVjcFFBLytVMHRNNHBxeUJzSVc3UjJ3M0Q2RjRSendt?=
 =?utf-8?B?VE5PdWRnNXpRVHpXUkFWVU1Vekw5VkVVbE5ZU1I3Y0YvVjJMNWZSeW8vWWVW?=
 =?utf-8?B?VXFGdUMyTDdmWGVibllaRk9Vall3TVhwQ1Q3a1VSblB2cXB1QU5BNHNHVnRa?=
 =?utf-8?B?YVZVelUrL3FPalFHcitPdzY2eHB0RkNJUWVhekVPWXZBRkU2dHNDbGFBVWRE?=
 =?utf-8?B?aHV4bzBWazlqdkpKU3FucVc4YUErZGZQeTNGc2VNN0ZvM3IvZXJ6amtGQitz?=
 =?utf-8?B?YmhGTHNGSTZsUHlrY0NKNGVDMU5pc3UrTjNuekJsNjRGSDE5ZnhlcytRQXF2?=
 =?utf-8?B?eWFGTHNnRDJ6a3JmcFBFeXlKa2NwTXE5c2dudkV5a0V1R2pyVURPc3VNOXRN?=
 =?utf-8?B?ZGJHdVVxYXVDdzU4Z2haTWJHU254VERiTEt3ZnlWMzZJRGUwRlM3VENsWG1H?=
 =?utf-8?B?K25JNG11NitZOVJSMW1CeVNuVURUY1pib2hHY3RoM3hhTmhlL3hYbUtDRWlq?=
 =?utf-8?B?US93WUFKcUdPV2E1WlRzV0dyaXMzQlBINWc4OGFLWTg3eklOMzYvNGpTeDcr?=
 =?utf-8?B?ay9SV2NSZEpadDdVNndVczFVVmt6TDFkaGxLNHVMTXE1QXU1bmg2V002aEFW?=
 =?utf-8?B?aDlzODVkdFN2Z0s0bHNJbDJXcTBzRnRpbWViQS9rMG9ZdjA1ckVRa3ByOS9x?=
 =?utf-8?B?bWUwUEMrYWVjblAzbTU0QmVmSkhoMHQrbUlWQTdvVFRQS3lXeDY4WjJvSkZw?=
 =?utf-8?B?WC85Y2dJNEpLbUJCb2pSZWZsRjlqTCtzSjJvZzFWWkE5ZkV3WXZXVU8xRTdT?=
 =?utf-8?B?a1ZFUjNoY2JXeHJZKzhCaXZIbVY4S1k2bVF0S2FITDlyUkNFVEJSdXFYQndT?=
 =?utf-8?B?cGZCQXgzek84OWdGZlRLb2UzZm1DdnRTYXRHa0haYmdsVnJtSVJIOGNna1JR?=
 =?utf-8?Q?CFlPsj1UIDg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dldkbFd0T21YWEZjSXRnREJxSjFIYmVRN3YrdnhUbnR2aWxUditGOVFXNmNW?=
 =?utf-8?B?RE9Sbkkwa0VRWG1KOW5kbGpWVGZOc2F3czM4NjNaVkQxVW54NzZiazRvYlVi?=
 =?utf-8?B?RkdrTGlpTlpvWldPeS81NmFuSnZsclFzNkpUZ1QvLzJ4VVVhK050RmpnaFV4?=
 =?utf-8?B?anNjbWY4amlkNGtWd0EzL1YvcjFtYnlvNTBPVVZUOUFlYXZkRUVGeFA1SGk4?=
 =?utf-8?B?d09qZHl0bjlKQ0xFdXlhT01DQXpKZWpoRFJUbnRMZktwSDk0UHdRNm1rMzQv?=
 =?utf-8?B?RG5vZ1BhYnhtazQ5cUlDRW8xc3JKM2xiS1pROVNjamRaYlE3Y09MOTAxeHZZ?=
 =?utf-8?B?cy9GblF4YnZHOTFKeUlpK0s1TVhLbVkyZmxxYmF0SU1LQm9SclNCZVFEcTdT?=
 =?utf-8?B?cHRvREl0ZGhJdzg2NGZMNy9DSXJndDFxbXFBT1hRcTkrdWxHb2xHM3pXZ1ZP?=
 =?utf-8?B?U29NQ3ZSOUtNL1FWM1pIKzhoazY0WG1NbDZTaTFoUXNQV0phWitmR1pMZUcx?=
 =?utf-8?B?SDFZRVhLZVRGMEtGL1NUYklBQU0yL1JjWUFjWWxUMENWYm9CWjhKMkF3VWJU?=
 =?utf-8?B?R1dMWVpMZm1qeTM5Q3VXc0Z0amFZUHVUTGo3aExqaG5NUnB2ZHdwbTQzSGM5?=
 =?utf-8?B?bGRWSTI2WlBkZkNQdFF1R05yZkdmRXNPOEFPQ3JtQllibFVnZGphSFhsQlQv?=
 =?utf-8?B?S3AwU3BWcFZVSDZsYit5MnVUc2FRVXJoS1lHY3Vsc1lSUTAzSTJXemhFbkdN?=
 =?utf-8?B?dkFrZG51eUxWdjE3WGkwaDJVVTZBdUQyYnp4QTh0TXV1U0JPenJYVCtjS3VL?=
 =?utf-8?B?b0F2VitlakhSdmlwbm13Y2FZOW9vN0QwRWF1KzVqcWEzR0dMRWRoQW45NXRx?=
 =?utf-8?B?UWdSVTA3dEJ5b3NYOUhOditSVkhHcDU2aXl6UmRKVmpKUGY2TWlvRWdtc0FC?=
 =?utf-8?B?Uzl1cW5md3RDaVVoR1FEclpNS2Y5OUdOVXVjT1VDa2V2UlpKeE1RUzltSzZM?=
 =?utf-8?B?L3FuNEE2QlZqOGNRL3k0MSt3T1pUOEs1cFhRNkRxOFVLMjJSQTdvR2dML08y?=
 =?utf-8?B?bWNXSGY5Z2E3a01vRW1sN2ZTQVJ4czUvRDQ2dGkxREU4aURPcnFaaVpZaklw?=
 =?utf-8?B?OUxqVmJNUFVUVUxvWXlJZGNRYzh0WFRjblpZY2x0aFA1RnJ2QUtwZGJPWjRC?=
 =?utf-8?B?WkZjV28rLzkzWTI3eW9SZnlNRVZySzdHTFZaSG5jei9sdGJnZ2Jpc3UwSzY4?=
 =?utf-8?B?UUlsZGdOYnptVGRKaFdGazE2RS9rM3o5L0M1UzFNUlMySzdWcXV6WTd2SlRn?=
 =?utf-8?B?cldVdjJ4aUpNK0JZMTZqbEl1dkxHeWN4WDgya3pFVkJwTzFGazdCRnNscGhk?=
 =?utf-8?B?ZVg1cEdXalNOamhJTSswR1VJeXhIMzRYTFJab3hSNHZEOUpiek9lNmE1VWQ5?=
 =?utf-8?B?NURQTkVWTExBNkNmTjBNd3NGV016TDd6aHZQbzQvRUVYWkN1Q2ZHbXkwNTd0?=
 =?utf-8?B?akFxR1NyUHBxSEVtSWlDUm0xRnBRSDE1cmFSQjVFbW5pcmtSa3hQSXlzNFlW?=
 =?utf-8?B?SUNhbElEZURUVzRyOEN6KzVORlhQdjdxcGhtMFUxdG04SGtrU2t5d1pDazg4?=
 =?utf-8?B?d0FWMVpTeVJPR0FueFdoRWIwR3BicnhMTmF5YXozYUdXWCszd3lId3FWMXpx?=
 =?utf-8?B?Y0o0YU1CanJIcXg0ZG5OeW1zZXM5cjh1R3N3Qzg1NUdZOWxnK3Z4OTJKcEpM?=
 =?utf-8?B?VktZV0xUajZNZjk3WEhYY28wTU9FN1J3RzZKVXpkTG14SmN3bCtlOG5JUWJK?=
 =?utf-8?B?aDYvSWFMOExweTlGT1M3OHd3bk9wZlRrbDkzUDVsbm92bkxXUmJua0JNSjMz?=
 =?utf-8?B?UFBCaGh1NEdvU1VpYWczYkEycGEwdGZJb0wxekMyY2hvcnBGblVjOG1xWVlk?=
 =?utf-8?B?c0ZoWFZjV01jR2hISzNUdVBMazcvZGlyZ0xuWCtJN0NweFoxWEppYW9FMlVC?=
 =?utf-8?B?WGI1MlZ6UzZqS1V4T1RPdVU3K3ljOGFCZFA2SXJtcUJ2VXlISHdNY0E3aity?=
 =?utf-8?B?cGVwU2NCbDBQNnk3MTVkK1Q0L05aREtRL2IybXBhaHcwZ2JLZ3pvVGt3Mjhy?=
 =?utf-8?Q?Mk91OdB6ao7bphAmQtt0wW7Gv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aZuO0HzT6UQUHF5OWyto0p4qw0hpTdy3gBgcA0r3tbAvDiiTZAlTWVmf6WpYCe3F9K/x3b0P/2bI6tzJLsFfZQJAmQHH4eXLGkYElTEpSOVXBr6frYppLNG5wltgGBDxWBREwYbcwlgNlkjUqt2ujTpcqRLhSj+NJwH5Ly4FC+AfoPHbfrEsTGVGqjBu9/56fjLb8OVoCG16JZlw4WJ1D24rf5Bi0gddD+T5/ZbK/dN0k7WWn48Gp/itPzkLCsfFLZx9Eq15u4L/aKK2n018+ybmKBoKEO+7qS1kZOTRh9YA+v5XVs8IVHmc2FXFGHNZnT07H6LUxTk/UZdPSJQwiiJc+otMjycJUtfADwL3v4elfzI1sejOsBmShCOG2HYgNxfz8y5bMLtGOFBR7IJAUYyf22lnlP+DMmZHFnDlLzYrfKYEQHt+gs0z1W7QOELgHLwmsRJGhOP/sVoapcDYHVuOZHitqi8wOLI5Gwf5AufPjLrXU7IKzKIPa80ORv7h7fLclAcTPHQlZE7ao1CLfUTinGXQsjN9xf3P90CAmRSj/4aIb3G3dhBY+0BgTz/TnONonij8PEXFBEaqdQHqwETWmCJenKb4yB7KOUzgM1E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08771569-1438-419f-6cb3-08ddef1299e2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 20:02:13.1280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4yBtDdll6yt5Ot4KbiLjg4v6jTEZBnaiSm9wU7s9FYllqBrxtyAasd5CC5gZn6CcvbrT0sd7m6+3T+R8SwY9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=935 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509080197
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68bf3649 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=_dU2O9QwaDJqOXRGMtYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX1uf3ReIeqeAi
 yhnRtdaIEfwN12a4Hv6QyxL4nkq8MsssNLW33h1yP0n+XJj2MiiZZBUnZWZK9YODRF5ZSPodG64
 iygkr19/ySW2Rhk3cMTWfQg8HUirka9MNSKgVejAkiv8p/aI8aFSTdwxV1xC85Df53BVDdi1v9q
 1YPi4TarduiIFUpmd/RJkmocir6Hw4TvNn+SZjIaafrdUSLZ1S54ZzskUCK/Gh52VBltQB/w2Mw
 M7ZdUHXmm1zrO42bcxONpfU6ir7N5wz6dKLfcufSTRN5Ke2r8BLhbaxgBrfroOF+ES8GmzYmOk0
 5m3qz6x3W6pmP/MOM5/mYgYilZbdXqBgLU59pMRrsbMGJw9iYmK5p4Z02C40aZv++420CdMB9Kv
 eYLPe+D7
X-Proofpoint-GUID: YKzKoPZkTIPLyCVqDiQ4bLRPqtD4QVt_
X-Proofpoint-ORIG-GUID: YKzKoPZkTIPLyCVqDiQ4bLRPqtD4QVt_

On 9/8/25 3:40 PM, Jeff Layton wrote:
> On Mon, 2025-09-08 at 11:38 +1000, NeilBrown wrote:
>> This first of these patchs is part of my work to change how directory
>> locking is managed.  That will involve moving the lock as close as possible
>> to the operation being locked, and using some standard interfaces 
>> which combine the lock and the lookup.  Then changing the mechanics of
>> taking a lock.
>>
>> nfsd4_list_rec_dir() currenty locks a direct and performs a lookup
>> in a different function to where the lock and lookup results are needed,
>> and does it even when those are not needed at all.  So the first
>> patch moves the lock and lookup to where it is needed.
>>
>> The second patch (arguably) improves the calling protocol for
>> nfs4_client_to_reclaim().  If people don't like this second patch I'm
>> happy for it to be dropped.  It is the first patch which is particularly
>> important to me.
>>
>> Thanks,
>> NeilBrown
>>
>>
>>  [PATCH 1/2] nfsd: move name lookup out of nfsd4_list_rec_dir()
>>  [PATCH 2/2] nfsd: change nfs4_client_to_reclaim() to allocate data
> 
> I'm fine with both of these, so:
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> 
> ...this does remind me though:
> 
> Is it time to switch the default for CONFIG_NFSD_LEGACY_CLIENT_TRACKING
> to N? It has been a little over a year since we added the Kconfig
> option (and had it default to Y).

<shrug> Send a patch? I'm not opposed.


-- 
Chuck Lever

