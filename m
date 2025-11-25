Return-Path: <linux-nfs+bounces-16713-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEBDC85473
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 14:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCB73B1E79
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680FA261B8F;
	Tue, 25 Nov 2025 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FIqFQhPQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a5Maq7j0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CEB25A320;
	Tue, 25 Nov 2025 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078959; cv=fail; b=bAhbWA68978M6WH81dPhToqRdznffPbctNsWqBFb9mFzm/lIBdWueuf+8rCVQEDhSRtl8AQMt2ItX6xUEAeFbpDFnQrMW0l1PLpUETQzCIKQENXuvLKLnZpwmEs9lJjyla4JNuar2JEiwmXZfNoBxWCzR4oCP08JzbAeXRZ1BL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078959; c=relaxed/simple;
	bh=G8yVKmhywUFGOho3W37mAQvKtJcfq0H3XZlnmXwGWZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ri2Ct1+rHu1/gpRlngBOCVsh+6cmdF3QM+BNPsPzWRm3gUjSHlfzy9I5WxpVp5G7msU4KAvb63vUpXNCv9VLIz2ry78KnF7pKCc7nQbpH/HVq6tSkEzwjYca3xx0Lrw6UL0rEfxhcTc0vNmzOCcODL1guKlWKLi81l0TcY5rUzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FIqFQhPQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a5Maq7j0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APDMfWA3706503;
	Tue, 25 Nov 2025 13:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=twfOPNXIlz3Ob2f7aJKGF1W8NWZsCq8iF5WPXyiwbnM=; b=
	FIqFQhPQn/13hlXYDFxa+58KiYcILKQJpfvsX1iGekPtXVQmmMRNi1f2rI9KQvYM
	Yedb6xVeYMq2Soin0r6DxlCto2HYd7Xd5jJdzhmWuhE+oza9OUvAWcO9W6huB1aE
	J5BRMb7gyd759aeUi9l6+XXbEIH/Y8Nw53sbap6FH6CTOC7NiKAb5LxZpYDn6s1m
	hXrpyfxkDVDVU1gjoLgRfTUIEBUxvV4To/vSapAnPIat61nYmZ2HaRk+uT9FelNa
	MFqzYdeOObG8HNaL9/bHChxn4qTlyQjATfUTP+uj9KSAnxh9seHuVtP4YD7ba6rE
	7f33b0k/j59MymiR4QuHTQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8dddhj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 13:55:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5APD02Ui032124;
	Tue, 25 Nov 2025 13:55:36 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m9gxrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 13:55:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lw63BX9orctBeQUyNpN1UpV/fzBSUEgtsWAZhMHbLqMTHSSKe3kWyeUkzeecdE3tk2aFN/Nvohk+as018crBnYYIiki0PIRgoP+tm8H3WbDQTQlBtXQ1xfagiP3Jt48JUuMUW8/c7/DooRPNaGODa33a3ya3MOohMex+7b/FAQaPH7vM+krd5HK8swSRDJTn/QCIHSgyeVrvkgsZSi9rt9DWK1BgSj2tQJGZs2P3EnDsjL2B1uTMxIwccFBhO0/fKOMhSVK6g6KhZGzBcxHX4ZiQisNJKwnUky6XRljNIjzsm66Qv4sCY11iaWyAtWN15tLUY6msIZV3dDWMBvtanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twfOPNXIlz3Ob2f7aJKGF1W8NWZsCq8iF5WPXyiwbnM=;
 b=pTqrjJ1LGAW9k8eR8o/5AhD62iyj0ev4Mk1O0hrDZtP1xWFX6ToQLb8N7suduGDk5S1FxiCbcPdgqYP0s/0RWPwLqKWw7IVJUERhu3A94DpKzBWwoVnP/cyCAObxRkEAa2Gh3nKp1zifS+1IdeG4Qsqed0PGcRzLa2EbMC4kTSonAI226uSZotN41P8QcDWQvDlsSYzt2RzqGG61F6/ueyj6CNr3kaEzYEnELDmMKzo4r3NONVq7nVeoBNddX3QMJVqIY/ys/zUHreQqvWWRtFPiTwu9KkiZ2Yr9vyNwby77dLF3ZqWHTqwyAgC4qI5yAzEtWNYfBlASTg0etEm9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twfOPNXIlz3Ob2f7aJKGF1W8NWZsCq8iF5WPXyiwbnM=;
 b=a5Maq7j02CJbwJYQMy/bfe4LJM4mD0AHqkONKF3TpHWHzbyPkyT2MlIS3EPvWtgyFpb3EhGwQgnhMRxFuvVY858zN6KAPH3JcniMq5ReEKgADEhyX+2oU1R2kCCVNKc11Uaqqwt9ShurOlgCxIbmPv7EHyTTifFntK/lOl9EsXE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5845.namprd10.prod.outlook.com (2603:10b6:510:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 13:55:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 13:55:28 +0000
Message-ID: <ab5add5d-24b3-455e-b560-311b56bf73ff@oracle.com>
Date: Tue, 25 Nov 2025 08:55:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] net/handshake: Define handshake_sk_destruct_req
To: Alistair Francis <alistair23@gmail.com>
Cc: hare@kernel.org, kernel-tls-handshake@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-nfs@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, kch@nvidia.com, hare@suse.de,
        Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-3-alistair.francis@wdc.com>
 <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
 <CAKmqyKN4SN6DkjaRMe4st23Xnc3gb6DcqUGHi72UTgaiE9EqGw@mail.gmail.com>
 <0d77853e-7201-47c4-991c-bb492a12dd29@oracle.com>
 <13cf56a7-31fa-4903-9bc2-54f894fdc5ed@oracle.com>
 <CAKmqyKObzFKHoW3_wry6=8GuDBdJiKQPE6LWPOUHebwGOH2PJA@mail.gmail.com>
 <1cc19e43-26b4-4c38-975e-ab29e0e52168@oracle.com>
 <CAKmqyKMjZWAvbc23JQ358kyWyJ0ZajHd8o0eFgF-i1eXX85-jA@mail.gmail.com>
 <14f4ee67-d1dc-4eb0-a677-9472a36ae3bc@oracle.com>
 <CAKmqyKNJ3BsooptPxMAhrhQZnCVaq_gnnhCrv66+eoTpWvpOww@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAKmqyKNJ3BsooptPxMAhrhQZnCVaq_gnnhCrv66+eoTpWvpOww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0036.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f7f5ba-0533-4e7e-8c9a-08de2c2a494d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0Z3ZXUwRDFEMDJERnQzQVQrRHFDUWltdEQrUVZ6d1MrT29DTktudU9aMm1W?=
 =?utf-8?B?cG1odzYxL2tZdUVzNUg2MC8wd0JjMVpDbUZrVmtLTk44akZiQ2lSU1BINTFF?=
 =?utf-8?B?Umx6Sjk2S1hPcyszR0VZYXdCQ0tMTHJVTHpkY0FrQjI5aDdyLzA2WGhBZ1k1?=
 =?utf-8?B?c0Zqbm93Tm1vWlVOeDZULzRDcmtoNXNob0cxWG9wSjdPWWl5b21GYWp3dFpi?=
 =?utf-8?B?a0FFNy9VelR5Ujl3NG1lSDBXZTFtdzJsUGc4U25GRHY2d1ZIYnA1QlhtKysz?=
 =?utf-8?B?UTdUcnpxSDU0MXNBSjhUSitDUVRMMzlQUWtLUE1XbktPSEVUeEhrUEhuaDJL?=
 =?utf-8?B?RkcrRFNyV2VMQktvUi9zUSt5dVYwKzdZMGJTS1EzaGFXNFVock1DYWZvZGFk?=
 =?utf-8?B?YXFUTTdXSGxKYStDMGdNMmhGYmw0ZEY5RmJ2NkkvM29qVXpEcGhQcE9ybHhh?=
 =?utf-8?B?NnduQVhxZFV6Z29xa3h0L2V4MHF6NllvZGJIWEdKMmY5RXY2dldIQWUvQkVn?=
 =?utf-8?B?N2RJdEUvK0NacStra2MvOWVSY3BlSTNkNUdTb1kza1lSUjQxWkF3aGU2Zzds?=
 =?utf-8?B?akQzOGJtdzY0ZmlOVkZ4aUlvWXZSeUVCOVRVb3hUWVFiTDZwWDFMYWVWZCt4?=
 =?utf-8?B?ZFZNT21BOTNwWTl3OU42Q25ldzhmUStNYm91RUZURW9XeUlzanFZdE5xNGRF?=
 =?utf-8?B?OElLMk9VS1pKNG9wcG5JUHQxV0dNZ2FEazdWdFlFUVl2V3VRbUpBUlJuWGRR?=
 =?utf-8?B?SE1Ydm1EMjdxTlhKQlE0dU5xTDgweGl6MmJEWEp3ZVlmelp0Y29JVjY3NUJi?=
 =?utf-8?B?V2lEbi9kSExiSitsM3BZVnhoVXkzTnh4LzA5NWhJRUNGbVh6dmJtZWxXaWo5?=
 =?utf-8?B?Z2dSUnkyODlja0w3K0plV0VQQ2RKT01JWitOc3gxT042ZDB0MWtzaXVHd2E1?=
 =?utf-8?B?czB4djliU3Z6OVBMMHhRNnZObWlBbEtCMUxFYmxGK05sR0EyUVlEOHQzdEpO?=
 =?utf-8?B?VEJVTysxeW9QbHAvVEJHUldOUEozNkE0ZU91R0FFUGJUWWprVEdncEh5NjZp?=
 =?utf-8?B?MENIc2ZEaDdYL1JKN1FNRWxHOXpscWNVK05nNDV3dHFVRlR3MXR1YmxZTFRX?=
 =?utf-8?B?anJ6VXQzeE5aeHkwV3VkSEZ1S0pzWHZjVVlQQWl2dzJSYnVZR05CWWNJSEVN?=
 =?utf-8?B?cVJOTjN4K1BNUWZ2MlRaalkwdFpsZ0hNQ3Bya00yLzVsZDI2WEh6Wk94bUh0?=
 =?utf-8?B?NGhGY2lESGhMVjQycU1FdFhsemlEcENYTEZtdkJQSjhXdlU3TnAvd0svbE5O?=
 =?utf-8?B?T09KSEhuN3FHNjZBNyttcXgyaDROSHRBRkhWZkgyaGE3ZjIzcU1IL0YwY0Fz?=
 =?utf-8?B?MUNBRGs4d0ZxbHk5Zm0yZ3I1ZU9Xd0FnR3dvYXlUU0Fac1FMQVFVUk8xb1E0?=
 =?utf-8?B?elNXRllGRTZ2VS9PVWtjY3EvVzVlS2JyR1JKQ3VDM0xJeVNzUkV1bk10dkFC?=
 =?utf-8?B?R2RIU3JkUUhWaXR1amYzTEplVXdIVG1CRUpDUndiclZUbnJhK25QcS9OMXVz?=
 =?utf-8?B?UVZtODJYcHVtR3RzZ2hqWC82T1ludVpkaFJUY2NRNDUvdTBCNHAzNDREbkRk?=
 =?utf-8?B?UFVGL3VjMXFPRlRra1ZlMnF0ZDVVUHpneEE0NURuK3RvZm9iYXZxQ2dVUkx6?=
 =?utf-8?B?SXB2anBOU095ZjBabVh0RnBPa245aVFQK2ZCMEJNK1F3TTUyZTRGNkJkWDlR?=
 =?utf-8?B?b3NMRk9uVFQwZjdCSkhTL1BKYnJaa1lncWdaVDhUYU8ycTJZdWtuOVBibVFq?=
 =?utf-8?B?SlV3U2ZsZVdXN0JDWWFNR01mTU83RjkrbmlOcFowYkdqWDlFS1RQeGMvTG1Q?=
 =?utf-8?B?c01LaWRtRzlUSFc5bTBpdk9uYWt5L2ErQzhjQVVRcnNsRTdpdWlTT3BicXBu?=
 =?utf-8?Q?GR4IUUoYtoBxGAxqi3YpberOHPvmDmsA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3B0NTNxQ0RjYWNFNWo2ek5veGZVQldqbUI2dlNBRENpaTVEUTFiNUhJd1kr?=
 =?utf-8?B?OFZJR01uMmpBaC94Qkc1ekVYeHM0Vzg2cTBZaWlyRi8rb2NkTjN3MzVoMTU1?=
 =?utf-8?B?V1QxMFB2djBKd2F0L1c2QmphSFF4NGp5Vno0aG8xNUFyenFRRktnWlZZQ2ZX?=
 =?utf-8?B?VXlTMGFTQVNTUTlvYjBYcGtVY0xzejRnNFdMM2NJUmV5SHhBNUJnSU54Y3E1?=
 =?utf-8?B?dlVhdmF0cGloL0RlWXU1VlhEUCtUdVVzZ2tTSE16OS9HRDE0WlNQYjE5dFM5?=
 =?utf-8?B?MTF4VXorTDNLTVpKNzZLYjYvU3dYclZ6cFpHUmtTUkVWQlc4K3VaWU5oTDda?=
 =?utf-8?B?clRKMFAvZk5iMXJFOENwUzYvSU80Vm02U1lMLzNWejJSRWo5ZmJVUmtCOFBt?=
 =?utf-8?B?TmlNZno1MXBOVldXQ1JtbzBxNDNNUC80SHhFRkkxNW5TTDJWYnNCNGJqVGd1?=
 =?utf-8?B?eE5lQkgvT1VoRjZ5V1RiNi9iMnk3MzZoMnZKcld6RkRpUUVJazA3QVNlVjBK?=
 =?utf-8?B?WVY3bGhaZ0RrWHlQRUNqaXlQNk9RU05obGZ3TksyeE9OY05MY3c0WTNteDFl?=
 =?utf-8?B?Lzk1OUJ2STB3ZExXak41VWE2WW5Sc1RUZ09Na1lzSHZQaWZpMkdEQ08rcnQz?=
 =?utf-8?B?RzU3SnJTZkNva2R4ZG83YjdWUkNMV2tvWklpSDlpUHlzMm8rN1BpUklaVGdz?=
 =?utf-8?B?QTFLdW9qTG1EcGh2MGl0RTRrRFhqQVhsbkNCNWhUcTNNWWVHN09BdDhFSXZT?=
 =?utf-8?B?Y3RtcWVKbGJJU0F6SlMyU0FYUkh6WXZacFNTMkhZVFA2QWs4U2MxMi91RjR6?=
 =?utf-8?B?VHNQYmVpbUtVWlhpcHJNYlEyL1VCc2RzS3U1L3d5SWtFUE9nRDcvaHdYbUp5?=
 =?utf-8?B?VjMyQXNFWTF2WnNZR042MDF5Nm51ZEdUYS9QWUlndVJDVkgzQmtXVElITVVu?=
 =?utf-8?B?R2tJTVNsNDYwRjF5RUsxZHhXMHpXLzhBdlZyZy85WlVQWTN1NVNrdmwzWHJS?=
 =?utf-8?B?TC85OWNDdU05aVJ3TjJhUVVOYUFWSTE2N0ZlbUtEZWVoUTBKNjNoWHhYS2Nm?=
 =?utf-8?B?Z2ZnVERoblFHM2g1MTlkSFhSRWl1KzJGWWlyTDlhVDF2dVJXS1JzL1VnMDVw?=
 =?utf-8?B?emM3VnV0UWRqOUdVS0VIVGF3N3V5Vkk1NDhkNmNsNW5oMUsvM0luMW0wNi9F?=
 =?utf-8?B?TGp0Y3ZLaDNDSVJYRk1nWlJVVWlJYm01QWgxWFRoSWFzR24wMWM1aHlWQjBC?=
 =?utf-8?B?cm8rRnZNU0syYmN5aWV5b21uaFNNUlpZWHpwdlE1RmdxVnh6Z3BaSlp0ZW53?=
 =?utf-8?B?ZzhvRzhDTWJRV0U1djJhcFV4RFJEV1FUdHUwbFpGbU5idDF3SVZ1WUhteFB4?=
 =?utf-8?B?MkxORWVnbUF6eW9DQUpzQUtIckRZQzdnN3lIdEthT01KcmpPenREZ0ZOM2pE?=
 =?utf-8?B?VzVkVkJxN1BBeWh3Nkx5RFJhb2Z5UFV2L25jRExpTTZTamdyT2RBd1cwWkd0?=
 =?utf-8?B?dTFzUlRRckRnWDRueStRbDczWHhleDkybHdLbUgyKzhLOUZWSlc5elBjQjgw?=
 =?utf-8?B?K1NMRXhIQUw3L0I1TVNISlFWNTJsaklvamZJUEpLeUhPSW56L25UaGUzcThP?=
 =?utf-8?B?eVppemRXc0tXenZGcWRoMGJBYWVWUzkyRjJZSjAreEluRWtaMW9sVFpYQU5C?=
 =?utf-8?B?RDlLRFJQSCtqSXAyd28xNFFITXhTYXU0UTFzL20xbHBvZ3BIYlptWkk4N2tr?=
 =?utf-8?B?NTJUOVA5Szh6SWJFYlpvZUNUT08vc1B6L1FIYTk1K3huczhEUytaOWxGSEFv?=
 =?utf-8?B?S2dOTTJMSmNraHYyWk5XWVRwWU4vSW5aVUhOK2JhUE5IT200TEprM09YSkk1?=
 =?utf-8?B?dlhoVzJBWGRBZHhKakl4NlRGQ1MvL1cwRmZ2SXhmQXdTRUpEZnQvQVNrdkRx?=
 =?utf-8?B?cFNzbzBabGhwVmtoZEE1dzVjam9mbEZZdDBmUWp1enVDY0oxWkZnK0pzbE5E?=
 =?utf-8?B?U0U1SHdHUFRpZnVOSkVvaWZiaTIrc2ZZY1JEWTVpV0NqYUFjR2MwSEUzOGt6?=
 =?utf-8?B?S3d3aXZWTFh2am1NMmZkNUcvLzhuQjBsQmpsY1IydzF1QXNzNEdaSGRYNWxT?=
 =?utf-8?Q?enKdt6t+wwbH5CFegMynHG5OW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9JKMWYBvoQPXKI8ZtKojl9AJqyZViHh00JrPunKMFSn1hXXopF8q0QhP+5uDUqltoz/acF637LNqAJ2hG/y6HNucldRKMHR7ZiB8VaxuY3Ax8IUDGDDljzEPcEB0LerswIppfzDpuTQRO9ANloMjqFlSQ42w707DVV0iCM6eL8kB3BhXMzoXXmigt8sJ0ijsSJMMcDgNgvBZ84oIUHCowYJ0Aitwz/VU58gW/6DKWviZMoC8RPhUCEHQJ6wJDKaaYLbQjiGqe7JkWIkAwJoL3DKL6kfRWnspNi3K/A4HklYlftDpqzBBGGxJvwlKQ4VX3MKNsNwAP2a0HZpgsKhKSv6B0ylfWhJQPPxhMwMk4lX7rZB+zdVdSXbjEzO43FFTecBFHKxeLEJu1Iz5ZSTqRbuLk0uJd8WWyKzUFmENZjO8jZgZ442yzv9su8By0RPiM3bfod8oZ4oUvMXOppvqnOIKPqMUtQwNSgzs1/UopXYRCibhmbX9jZsLHHVE5Vgdi01KrywxLBVquXS1kTsnJzpgD+6puNGQw4YDgJneFOY5OZPAM4YjcM8uCMpdEqnIHkBqgA368uTz/3IuXvJi30vtayrCyM4he1CIaMX8KPE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f7f5ba-0533-4e7e-8c9a-08de2c2a494d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 13:55:28.1854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+gy5cm8lrUZm6FmOcTuvmxroNWO9b+zTm7elBLP70xc7zMzE2nCGX2DoU6gIwcT1MyDGRIR0Jp9vujtJQnIWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5845
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511250115
X-Proofpoint-GUID: KvZN3tOl3NSfu2sk4V-fdA6Ef0s2nffO
X-Authority-Analysis: v=2.4 cv=ObqVzxTY c=1 sm=1 tr=0 ts=6925b55a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=bR6fvlR38kIQhSPvDGgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDExNSBTYWx0ZWRfX8LLEohWyUdNw
 xrLHu+f4EWq3yF6evZxGLHEkYHlBDQGsTBuuHZu+QJwlAQQuyihK1aovUBgjFt5LLlqmmwL1wwX
 lOyrglftKbzf+pfToUCGcbSA/3Y3+X2nNhNzlcuwIwakAshYfRej+4y1EBxYwTkG+exzZgfQJlg
 uJqAU+B+Bax9b1qpsCpugG74xfCuQcH0n0M0h4MvK5TsLNDisQN53uBU12iWaTfGJaCJnGe4SWc
 PWwd/gdGtpSytC/WrO29nwlPSSvd6Sv3fj1JuvKnapYiQmAuuKecJp7W+mQldBCJoUI8k3wAm1E
 czxDlMdMgk8JCwnN30sGTy0lq4C8pZhK6GmS2Z0Jp/Z3Rs+qDe6HEgKqJErIDMU3yEwo469j1z9
 WUztqxHwWzjVket+FJihcDf7uIUibA==
X-Proofpoint-ORIG-GUID: KvZN3tOl3NSfu2sk4V-fdA6Ef0s2nffO

On 11/25/25 12:00 AM, Alistair Francis wrote:
> On Thu, Nov 20, 2025 at 11:51 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 11/18/25 7:45 PM, Alistair Francis wrote:
>>> On Sat, Nov 15, 2025 at 12:14 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> On 11/13/25 10:44 PM, Alistair Francis wrote:
>>>>> On Fri, Nov 14, 2025 at 12:37 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>>
>>>>>> On 11/13/25 9:01 AM, Chuck Lever wrote:
>>>>>>> On 11/13/25 5:19 AM, Alistair Francis wrote:
>>>>>>>> On Thu, Nov 13, 2025 at 1:47 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>>>>>>
>>>>>>>>> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
>>>>>>>>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>>>>>>>>
>>>>>>>>>> Define a `handshake_sk_destruct_req()` function to allow the destruction
>>>>>>>>>> of the handshake req.
>>>>>>>>>>
>>>>>>>>>> This is required to avoid hash conflicts when handshake_req_hash_add()
>>>>>>>>>> is called as part of submitting the KeyUpdate request.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>>>>>>>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>>>>>>>>> ---
>>>>>>>>>> v5:
>>>>>>>>>>  - No change
>>>>>>>>>> v4:
>>>>>>>>>>  - No change
>>>>>>>>>> v3:
>>>>>>>>>>  - New patch
>>>>>>>>>>
>>>>>>>>>>  net/handshake/request.c | 16 ++++++++++++++++
>>>>>>>>>>  1 file changed, 16 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/net/handshake/request.c b/net/handshake/request.c
>>>>>>>>>> index 274d2c89b6b2..0d1c91c80478 100644
>>>>>>>>>> --- a/net/handshake/request.c
>>>>>>>>>> +++ b/net/handshake/request.c
>>>>>>>>>> @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
>>>>>>>>>>               sk_destruct(sk);
>>>>>>>>>>  }
>>>>>>>>>>
>>>>>>>>>> +/**
>>>>>>>>>> + * handshake_sk_destruct_req - destroy an existing request
>>>>>>>>>> + * @sk: socket on which there is an existing request
>>>>>>>>>
>>>>>>>>> Generally the kdoc style is unnecessary for static helper functions,
>>>>>>>>> especially functions with only a single caller.
>>>>>>>>>
>>>>>>>>> This all looks so much like handshake_sk_destruct(). Consider
>>>>>>>>> eliminating the code duplication by splitting that function into a
>>>>>>>>> couple of helpers instead of adding this one.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> + */
>>>>>>>>>> +static void handshake_sk_destruct_req(struct sock *sk)
>>>>>>>>>
>>>>>>>>> Because this function is static, I imagine that the compiler will
>>>>>>>>> bark about the addition of an unused function. Perhaps it would
>>>>>>>>> be better to combine 2/6 and 3/6.
>>>>>>>>>
>>>>>>>>> That would also make it easier for reviewers to check the resource
>>>>>>>>> accounting issues mentioned below.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +{
>>>>>>>>>> +     struct handshake_req *req;
>>>>>>>>>> +
>>>>>>>>>> +     req = handshake_req_hash_lookup(sk);
>>>>>>>>>> +     if (!req)
>>>>>>>>>> +             return;
>>>>>>>>>> +
>>>>>>>>>> +     trace_handshake_destruct(sock_net(sk), req, sk);
>>>>>>>>>
>>>>>>>>> Wondering if this function needs to preserve the socket's destructor
>>>>>>>>> callback chain like so:
>>>>>>>>>
>>>>>>>>> +       void (sk_destruct)(struct sock sk);
>>>>>>>>>
>>>>>>>>>   ...
>>>>>>>>>
>>>>>>>>> +       sk_destruct = req->hr_odestruct;
>>>>>>>>> +       sk->sk_destruct = sk_destruct;
>>>>>>>>>
>>>>>>>>> then:
>>>>>>>>>
>>>>>>>>>> +     handshake_req_destroy(req);
>>>>>>>>>
>>>>>>>>> Because of the current code organization and patch ordering, it's
>>>>>>>>> difficult to confirm that sock_put() isn't necessary here.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>>  /**
>>>>>>>>>>   * handshake_req_alloc - Allocate a handshake request
>>>>>>>>>>   * @proto: security protocol
>>>>>>>>>
>>>>>>>>> There's no synchronization preventing concurrent handshake_req_cancel()
>>>>>>>>> calls from accessing the request after it's freed during handshake
>>>>>>>>> completion. That is one reason why handshake_complete() leaves completed
>>>>>>>>> requests in the hash.
>>>>>>>>
>>>>>>>> Ah, so you are worried that free-ing the request will race with
>>>>>>>> accessing the request after a handshake_req_hash_lookup().
>>>>>>>>
>>>>>>>> Ok, makes sense. It seems like one answer to that is to add synchronisation
>>>>>>>>
>>>>>>>>>
>>>>>>>>> So I'm thinking that removing requests like this is not going to work
>>>>>>>>> out. Would it work better if handshake_req_hash_add() could recognize
>>>>>>>>> that a KeyUpdate is going on, and allow replacement of a hashed
>>>>>>>>> request? I haven't thought that through.
>>>>>>>>
>>>>>>>> I guess the idea would be to do something like this in
>>>>>>>> handshake_req_hash_add() if the entry already exists?
>>>>>>>>
>>>>>>>>     if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
>>>>>>>>         /* Request already completed */
>>>>>>>>         rhashtable_replace_fast(...);
>>>>>>>>     }
>>>>>>>>
>>>>>>>> I'm not sure that's better. That could possibly still race with
>>>>>>>> something that hasn't yet set HANDSHAKE_F_REQ_COMPLETED and overwrite
>>>>>>>> the request unexpectedly.
>>>>>>>>
>>>>>>>> What about adding synchronisation and keeping the current approach?
>>>>>>>> From a quick look it should be enough to just edit
>>>>>>>> handshake_sk_destruct() and handshake_req_cancel()
>>>>>>>
>>>>>>> Or make the KeyUpdate requests somehow distinctive so they do not
>>>>>>> collide with initial handshake requests.
>>>>>
>>>>> Hmmm... Then each KeyUpdate needs to be distinctive, which will
>>>>> indefinitely grow the hash table
>>>>
>>>> Two random observations:
>>>>
>>>> 1. There is only zero or one KeyUpdate going on at a time. Certainly
>>>> the KeyUpdate-related data structures don't need to stay around.
>>>
>>> That's the same as the original handshake req though, which you are
>>> saying can't be freed
>>>
>>>>
>>>> 2. Maybe a separate data structure to track KeyUpdates is appropriate.
>>>>
>>>>
>>>>>> Another thought: expand the current _req structure to also manage
>>>>>> KeyUpdates. I think there can be only one upcall request pending
>>>>>> at a time, right?
>>>>>
>>>>> There should only be a single request pending per queue.
>>>>>
>>>>> I'm not sure I see what we could do to expand the _req structure.
>>>>>
>>>>> What about adding `HANDSHAKE_F_REQ_CANCEL` to `hr_flags_bits` and
>>>>> using that to ensure we don't free something that is currently being
>>>>> cancelled and the other way around?
>>>>
>>>> A CANCEL can happen at any time during the life of the session/socket,
>>>> including long after the handshake was done. It's part of socket
>>>> teardown. I don't think we can simply remove the req on handshake
>>>> completion.
>>>
>>> Does that matter though? If a cancel is issued on a freed req we just
>>> do nothing as there is nothing to cancel.
>>
>> I confess I've lost a bit of the plot.
> 
> Ha, we are in the weeds a bit.
> 
>>
>> I still don't yet understand why the req has to be removed from the
>> hash rather than re-using the socket's existing req for KeyUpdates.
> 
> Basically we want to call handshake_req_submit() to submit a KeyUpdate
> request. That will fail if there is already a request in the hash
> table, in this case the request has been completed but not destroyed.
> 
> This patch is deconstructing the request on completion so that when we
> perform a KeyUpdate the request doesn't exist. Which to me seems like
> the way to go as we are no longer using the request, so why keep it
> around.
> 
> You said that might race with cancelling the request
> (handshake_req_cancel()), which I'm trying to find a solution to. My
> proposal is to add some atomic synchronisation to ensure we don't
> cancel/free a request at the same time.
> 
> You are saying that we could instead add a new function similar to
> handshake_req_submit() that reuses the existing request. I was
> thinking that would also race with handshake_req_cancel(), but I guess
> it won't as nothing is being freed.
> 
> So you would prefer changing handshake_req_submit() to just re-use an
> existing completed request for KeyUpdate?

Thanks. That jogs the memory.

How about a new API, say, handshake_req_keyupdate() that /expects/ to
find an existing req with a completed handshake? I think that fits a
little better with the state machine.


-- 
Chuck Lever

