Return-Path: <linux-nfs+bounces-16347-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EEBC58042
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 15:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12CBD4E6AF0
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 14:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E42286D60;
	Thu, 13 Nov 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hWDsMcK+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="toHORCTO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD521B191;
	Thu, 13 Nov 2025 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044944; cv=fail; b=KYeT0EN4VE63myJMBmc5gG0M0b6lp8JmM9cGf5RTaB3D5ZAXjPFCPfpAaAtUwDJtQfTaxXOabn7YC4X4UAUW+42HVg1zmjT0sZZeuB4FDgH285b8ef1my5CsUJyK1nHVfGEB2D3po16apdflEfaehaXFhhrNWQ5+JJH80M2hIro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044944; c=relaxed/simple;
	bh=b+v6DWR2o8S2wAStIowgJI9FFjNsOzCE7buue91tsdM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HstTmcuptw7cXjO7y6mc9JC6c8UQZ3MM+L7vUmXleNzgLm2ZB/q1/MrqeZQk+CWF4cUQoioYP2tQeJVxO7UVLQioZm9LJmDPXUiioslGylLTrgb70ZoiSVqFxZ3hLfBCK3ExuHHJynvU9/c0RxDsu0sExWSy4ihrtYcUdsbEAFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hWDsMcK+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=toHORCTO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9uDn023921;
	Thu, 13 Nov 2025 14:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6K8Gd5W/ZMdGscSfDokMTzGC1BYz81GwXbiXAS5Uqg0=; b=
	hWDsMcK+oojtn36ymlWBBOFC3qeFdjLYC6/MvQ0NuIpkVZv0AysQOOjNarTg1uYk
	6vtJhiPLsuRUzkwKmq32VOk9I7D7Gm8yfa1pmjI4rkrF87cUiQL46mkyO50BkAR4
	d0r0MyVwjqA//LWSm/FEI5a8H2wCNYKpqfd4Kqi3cHQ++Wa6dfKOAom0moEaWK2l
	CZeec1SUeJ9kQNjya3Ke5GGu+rCofqQ1iwxe+4IfZMdNke6G7cAr7geVJRqVJFBu
	oRcxV/2Sdhuc264NhJRpOe4SZe3gqHC1S+/iK3kkk+xRX18g9MfiPFSmvDgo6Ufc
	f/3yxnLHKrSYyS/Uc4voTA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acvsstc2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 14:41:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEDO2l000388;
	Thu, 13 Nov 2025 14:41:56 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013055.outbound.protection.outlook.com [40.93.196.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vafrccn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 14:41:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJ2unzRNKLBiqwgIFnpjK1EaYtr/h/9jGhy0MdMvfeGepXM6gZZ1JtkErNHvnH8ZASuvdO7pCFy45hN8cTcsexos/Vz7CnlvDHKt9bb1vLgnw13+PqJyBe3ZvXxwJjyOQqrWxW5CRGYl7QShQTKdd1quOtFE3gqkZZRWeIxAg9prXUtpQiUwACpaS9OkE9TEJsY+WM0qGtQgYuF8kfv8Gq68jdeSJFjsasNdZmWvx8BMD/csgTcnICuJHRXgCm4ZeNpzPTtSY8KHuQUZwiwLljBy13ySYTlqHGdUdymvNuRkSOuHXqzGOkW4W+MCbSIEQYSwT8oEau/encTJsHsdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6K8Gd5W/ZMdGscSfDokMTzGC1BYz81GwXbiXAS5Uqg0=;
 b=f3cIjpMBis7W5vf3SQXEfGwwmSQWhVBmUehBzJthioVuW2jTnRxpmr2xgU2M5A4vhbis21qh9dlyG7xPgAkU2XMsRlbkzyQEL+mNEglxlxYytibRM1AjGqgCade4nc1SZumOLVyq7kOaTu0iOGF+SHPh058QirnJO//mzR6uobVPz7I8gyLrQOVOpcjuKSybdhynq5Y5XUJppcvMAquHBy/kdjh5RUHgCJ6VYYc/nQBz4GpDw8sjrQwI5CiWRMhOjbsQChdzv5WYko8BZmZZGo41EkUJjg1kE+b4VCQEinS1XkMaStaUqT0i51pOn1hZBOvu+ZPwrmtYF7rS+kYizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K8Gd5W/ZMdGscSfDokMTzGC1BYz81GwXbiXAS5Uqg0=;
 b=toHORCTOx76DmxKh57jlQNqmP0WAjJbjWaRZCzUsZXbSccknpBvWKg8VzKcC6ycBjwZJ2eG16BVclueP/54WHGxMQRwrK9TnvPAsYfeHZ62GwY4XxbULl+FJ5X4/mPTjo4UO5+bq8xiz2FzrSI0r6UZtCVmopdaq0nK+ium6uZk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7417.namprd10.prod.outlook.com (2603:10b6:208:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 14:41:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Thu, 13 Nov 2025
 14:41:52 +0000
Message-ID: <f5178593-c308-496d-92d5-2a4b5f16be8f@oracle.com>
Date: Thu, 13 Nov 2025 09:41:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] net/handshake: Support KeyUpdate message types
To: alistair23@gmail.com, hare@kernel.org,
        kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        kch@nvidia.com, hare@suse.de,
        Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-5-alistair.francis@wdc.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251112042720.3695972-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:610:52::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d25019-b4c8-4a2c-74f7-08de22c2c8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THp6bGF4NDlBWG0zNnY5T1pseExQNUlIczYyZlFCK2ZFNTFpZmtFb1JyTVpK?=
 =?utf-8?B?UVlBdlBuY20rbFQrbStPVDhIMGc3Q0x5R0lJVTNocDdsSDZxUEJ0cHc5RkdQ?=
 =?utf-8?B?RXZXdFd1U0I0bDFJWDFyS00rbmVCdDhGdFZNRDZaZm53b2NmSDlkYklEU0Zw?=
 =?utf-8?B?ME9SVnNra0VKS0N3b1ZyTzRkZDUzTmpnd1dLcmhMcVRRNnFSc0hrSSsrKzhS?=
 =?utf-8?B?ZjZYTEI4NzVyajdoRlAxZXdKR0lGVFFQNHBvSDFLR0dkTktTNUNkRGZXUzZn?=
 =?utf-8?B?L2FsT1FrMFI5c2lNRk1TOUlIbW02cU4rend4c2dCU1lVNlUzMXN0YWkxcjNz?=
 =?utf-8?B?RGxtZjFacURFMUlOQlowRS9VWUFZUGVBZTF4L3NCM1I0d0hCbmdRdFQwSnZk?=
 =?utf-8?B?cDV6VGxNcWgrM3duYjJpSFR0RnFaWldPV3YrT3BnV05vMjdhdkMrd3pFYkJh?=
 =?utf-8?B?UjMrNVJnVnh5Z0x3QVNCQWcyZGJ1amphVkw2THMxR2ZVYTBwYXVFVkthZmlL?=
 =?utf-8?B?RXZtK2ZoTjhBeW5yYzVqb3dDeDIrZkFuOW9makFnZFVaZEZUUVJKMG5wMnpQ?=
 =?utf-8?B?QURTRG8zc1VHVFZIV2FZdDFENUpkZVI3TnN1TTYweGIwdkFJUmFCVmU5OCtJ?=
 =?utf-8?B?UFNsZ01VeGpaMWYrQUZDTllCeXBVdHYrdy9XS0JyK2EwellDcUQrbTR1azgw?=
 =?utf-8?B?Nkp0OE1LTnpTQnRxY21ja1JralA3SFI0ZmdlTHBBbkN3M0xSNFl0RTdrT2xR?=
 =?utf-8?B?ODdhZHdYWGYwUm8zQThhYnBFV24xdzM5RndrbUltUURoR21iZkRZMFJEV1Zs?=
 =?utf-8?B?cjZrRm81ZEdYeGszdUFRSE5rSzA4VWxQWVRuZUlJcUdZWGFRVzNNVENJZUdO?=
 =?utf-8?B?TURhWGZRTkZ2MFZuVVhybnRsa3QwLzN4VzRLTVZlVE43MkliekZRZmhPa2sx?=
 =?utf-8?B?Q0Y1YjA0VFRSdDgrVFB5VW1iVko5Z1pRN3JtbXBJcm40L3F2WVlDQ25WL2Y0?=
 =?utf-8?B?QUI0NkMvYkg4NkZXVnRTTTNidEdDdlkyWlExdGZ1OWpPTFJKaTRKM2xUUmp5?=
 =?utf-8?B?eDkzVk51L1Byd3FIenFHVmJnZG9VT0lXSnlLYjJxcXZaSDFBVWVHeGdmd1hR?=
 =?utf-8?B?SjVvVnVpa2wvMktaUjFBTHJqa3VHUzg4TWdCV3NSem01MVZDSDA4bGZlUmV5?=
 =?utf-8?B?NHNTNC96eE40TjNYQW9Jd0pvT3VoUFV1UUp5OHVHcDd2dERhRm11VlhITUdG?=
 =?utf-8?B?bEJKc21ZVUc3cXVnTjNLNWo1QXovTlhoNmd6cWRoditCQ2krWUI1VUJrN0pN?=
 =?utf-8?B?TEI4aGJXd0UwQ2l0QytpVGZnOUVrL3NEdElCWTJ2Yjg1cGU4aVlCd2ozeXpo?=
 =?utf-8?B?MGhFUU9GeEFXbjFqOEoxTTBuK2RjQmxJT3ZYZERvaWVKcllVSE9BSzBacGhx?=
 =?utf-8?B?MHNlYTRRYmhTVVYrcGtRQ3g2RGJNTU1ickdCblZjUGJDbkpiTERMMlRkSmRN?=
 =?utf-8?B?bUFsbE1zKzBsYmF0R2hvOElGelYwMGVFeFgxNnNDeGNIY0M5VTZTYzBYTk1k?=
 =?utf-8?B?eGh5VmFnQ2ZkWENweUd0YTFMb0NCdkhJeHRQMXBsWVZiNU1jeUxJdWZOc1BN?=
 =?utf-8?B?SXZiSlRKSWZGR0ovTHlTOEtwUFgreTF0eldVOFhPdzVESXNSSW9ubDAxVHZS?=
 =?utf-8?B?a3lVT1AxNHd5aFNXRHU3dXgwaHlWaGlCZFQrRHVKYjF3VzNNOUhxNFFOeUJp?=
 =?utf-8?B?UWpuN2YyUHZDVC9OUDZEUUdhekNjWnFvbWRPVElWaUJubEtZcy9lbTZTVStJ?=
 =?utf-8?B?RHFZaERhci9TRnBLZHpjR1AxYUpVQlYycjlHd2lvVStGM0x2eENtZXN1dGJL?=
 =?utf-8?B?N3RmQmRuaTdpaTFkRUdBWVhHb3VZZ1J5SUtHa1IzUWtiVktrNmh6dzVIdW1E?=
 =?utf-8?Q?G6yxPT+x0bFoGpmoTrKWUhAvMhRWnSU2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXhqbndLaTdpd0NHcXNWc1pWZFIxVDhuYkEwbkJEMFhLRzcranRjWTRhTUNv?=
 =?utf-8?B?U2o3RzlrVDVNSkd6WFBnKzIyN3YvcUN3SnJlMjVEVjRSczJacHZmS3E0cWV4?=
 =?utf-8?B?NjNSZjJFS0UxdGpZaTZXaDhvcEx2TWV0aXc2Tm9hU2ZTTlBrbitWa0g4SExY?=
 =?utf-8?B?NHJUVFNubENYSXRPS2dmMEJGckFxWEZrSWRpbnJEUHJXdERQUjJJK2RaRm1p?=
 =?utf-8?B?ZFFhRmxmWnQxK3lFdnNtclo5ejk0WHZ2aU5aYUpQVXVuNEJPdnp6UXFYcTkv?=
 =?utf-8?B?QmNDRU9pb3kxUmxvSkdsTWh5YlhiUUdBNGFpNSs4eGhMM3J2OVdwM2dBWGlT?=
 =?utf-8?B?K2tqR0QvWm00RGhtQVFxaUdHZUZpdEhVWDNvVW8wcTgvakE1RW1EbVNnUHlk?=
 =?utf-8?B?ZmQrY0pDVkhNMW9Pa2JPQ0p5UFhOUnFyVFc2djllK2ZqVExpaFJCRmlkNXRS?=
 =?utf-8?B?cmM0NU1GTjdpTXI1UmV1NUlLengxSFBLOTY1bzk1S1d2SWpQRUhod1JYWmFL?=
 =?utf-8?B?NlRuZWFYL1lSZFZCemZQN2txZm1MS2VrUWZuM1BrRWIrME03eHNzYzNDY3Y1?=
 =?utf-8?B?VWFaV200K24xQW9ZR3c5WHNnbStVbGZsNzdXWUlxKzBJd3NjUno0WmZkQ241?=
 =?utf-8?B?a0daTTg2VlRPMzQ5Z2pXV3EwT1EvUklRenFMRDNZczBGL2ZaOWFCS0xTTGRi?=
 =?utf-8?B?b1kvRXlZOVRXNndyRFdlczJOYmNyRDhBTDlrNHkwY2hLMXNZMHEzYUg4eUs2?=
 =?utf-8?B?U1pSSTZzY1pqbHJOUUlhQ3F6T1ZRR0todVNheDNXL2kxZW9EeU5QTlZtUXR2?=
 =?utf-8?B?bC80ZHdYTjZENXdBbDcxVmU0MVk5NVZiU0tkL0o5SUs4Z3lWMXVxM0t1NHk4?=
 =?utf-8?B?b2dZVTJ0clFBVXppK3htLzZEcklIRVZEcks5VCtNNXlwWWVzR0NUMTRGWW5K?=
 =?utf-8?B?YVNJbnNGUXVRSHZRVTdCZWZTNmlLZGxXM0RMSzZoM2tCZ1JaR1JSYlJpWTRl?=
 =?utf-8?B?YW9tdlhPekVoOUdMK3RhOU5GcUpsakh3RllWZERCc1RJT08veTNkdEJPalZr?=
 =?utf-8?B?a1l6bGZNdkJOQ2tmMHdTdE1zZC9uaXJEL21LNTJuVnVWeUlMVXVlaWxYaFdY?=
 =?utf-8?B?dU5EM2x4amFKS2paWGRZcXFjMnZ0OVFzZWx4c1FWZ1NPbnduS0ZaaldOdnds?=
 =?utf-8?B?UHYrSUFxVHFnejNTQkw4ajl5UzBKcmYycG42UFBWWkNBa21reVhVeWxkb2Jh?=
 =?utf-8?B?Z0duWHRySFI2Q2tlNHp4SjlWbmlDQVM2QjhGREpzWW5Ydm96L3IzOGFqSlNi?=
 =?utf-8?B?NTFvV09QQTd6cVhvTXcrcWhOdGhrbTlEWE1tRXF3dzVYa0VpdXR6Zy9vVGtO?=
 =?utf-8?B?TEc0TDZUUlU1L0ZiUGpac2dwUXpud0RzYUc1UmNyeldsZFBNNDZTcDg3Vm9M?=
 =?utf-8?B?OE5UZmlKL2FQV2lHWG5jOWhuSmV4Z05YdHV6UEVTRlE2RndqblVZcTFpTlFq?=
 =?utf-8?B?a1JBZnAwWk9EK1ZIVmMxNW1uNG1vcC92SEtxdnVyT2s1MTI0VkxxYXBlZENi?=
 =?utf-8?B?NDZKei95RXYzN1VlVTVQNGdKbVJXRWdCY2RRR1V2azZ3WUFnc1YyNEZCQVEv?=
 =?utf-8?B?VG5nYXY5bFRJSzJ4MExzeHhwMnpDUHhVaWY1Y2pXQjYxNnRlRGt6d0FEdHFh?=
 =?utf-8?B?b3BZTFliVWxaT2pQR2xleU5zYmRrb3pBWXM0UzBUbE5EOVBxbzhiUFpST3Nw?=
 =?utf-8?B?aU1BWXNoNlB1a1ZGN3lRTzdEd2U5c1Q1UkRXMGVwaXhEYzNWc1Z3eStzUURS?=
 =?utf-8?B?bTNkS2lBaWF2V1lGN05UZUl1dmhVMVRsK2tGRUphRzJhNFlWVWs2K3dYTzVh?=
 =?utf-8?B?SmwxNkJneXY0SC8zUXRJV3B2dFFaV2J0cGg1dXlzMTh5VndCVzZZUkU3dFB1?=
 =?utf-8?B?RWlOT2JVQmk1TFFIRW1YcVBBMWlrbGVlSHBPcmZodldLMzlJdSs4T1lWVmcy?=
 =?utf-8?B?VmRuaWx0bnFZTDlMNlpGdWtOL0pDL0w1NklIZ2RYZzRxTHpUZHB4Rkl2cTVV?=
 =?utf-8?B?dUlLV2Urc1prTGNyWmdDRzdJTUlzeEMyREZvd0pLQkdvRWU5YTJwZEFUTFZL?=
 =?utf-8?B?Y2RHWmtUUWlYbFFhWTd3MUV0VzlXSWlrTUdubEE4bENiVHRnYjBNVGcyTG1O?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cwu8KcsL6ahFi+5vO5TbpUsz4j78HZTbNx8zbq2VlljJ3zOH/H6upGCT2GrSfQHInTKFuTiSKJsiVZqzkbkROgJDUmS5+cSAruNjFEvxsA9/AeKnDiDF+FAszSuaXBnzHxGW6yoBWlbEnchZ3hi/z9n4fy7xdifD+vzNffIotSY42jRr0/iVHpDacHTIikDtNoJ5NRxH8USVL+ZBJygEhnVQOIJu7+IGYpwET2yfn6WnCEVmQZQV6NoTCdkHH9VFVhnYIhDROLguN7Pplrju02OcS8RRKYZSc+TNQxyNt4IwYa+Jxfwe4LXoDJocI/Mt49KoKTQIsw0bFNAGBfE5gdXlx1P7iQkyXR+8VZ2/DJf1nPguGRSfevstFvePZXnQyrgpmfXOLBsf6T1Ak/ztUGERwxWVMMlXRgrGOlj4AqFAQT4MN3GrdtfUgYPDnGwnpJavyM5S7HuF1/zIrwWHe4xmPfsRxdf+Oumx/4ms9fwXNmq9aKP5SmPl8+uQ2ZNjEVjfjOu2j65SbXuQVH12HKxNRGXU45f3t6ftlgDFs+TPDfkBhQjmhJuPDA7UHmfnxmM50+8OmZDNhq2WE2L7hVSY/23WO6RmC6s8k8+FC+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d25019-b4c8-4a2c-74f7-08de22c2c8bb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 14:41:52.1036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhGMGz2pIJFFRhOJ8WC+CDjfHrhLgo6f10pBgjqsTshrKdRN+RJ3SwoaPkCdfvLMAv0QSASCU8NYhoEGYTWa/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130112
X-Authority-Analysis: v=2.4 cv=bJUb4f+Z c=1 sm=1 tr=0 ts=6915ee35 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=48vgC7mUAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=yPCof4ZbAAAA:8
 a=rnpwRbQdqEPikXMJ1TUA:9 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 cc=ntf
 awl=host:12099
X-Proofpoint-GUID: WwcyhPA0nhEz_2NiRHnHjE1U6XvI5i_B
X-Proofpoint-ORIG-GUID: WwcyhPA0nhEz_2NiRHnHjE1U6XvI5i_B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMyBTYWx0ZWRfX6Wnt/UBRZMLp
 cRerXFKCDtzS34AdXG5xksxxvOVcsHvJUptqhmRsW9V77wa/dbAKOPnU/K7iQ3bH2FZigKzgsyp
 zPITSgTY9fRvGONNRxu59Gh4A5yfoWVevVOz2DeCuzEL5S5qo3/X4pVpLyCYt78FdflFasnYH9h
 +qEZdLh3XQ8XaLWHzz0gBDd2QFgXwyuF0GIk3CI+f7ZYvrBI3U5sGYubK4/s+xRWhvsT+8XKVr5
 BTz1TGTSl0Ri6ZCScJmy3p+fyQirQ2PZsIIt9+84SdjEkoUAsNP42CAFd2ubs8vVzifuRVq3p2F
 QZwzFSsJKkKuexQ39GHISnm7bhS5V2g/lZj94H764qH5g3BxAy+OAUNjekMNsoEceEPua3RQXZB
 ZxfEsh4TO413Y+KZs+0R5QUAAfEUdxsL6fJrDodXwW4ImLLH99c=

On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> When reporting the msg-type to userspace let's also support reporting
> KeyUpdate events. This supports reporting a client/server event and if
> the other side requested a KeyUpdateRequest.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v5:
>  - Drop clientkeyupdaterequest and serverkeyupdaterequest
> v4:
>  - Don't overload existing functions, instead create new ones
> v3:
>  - Fixup yamllint and kernel-doc failures
> 
>  Documentation/netlink/specs/handshake.yaml | 16 ++++-
>  drivers/nvme/host/tcp.c                    | 15 +++-
>  drivers/nvme/target/tcp.c                  | 10 ++-
>  include/net/handshake.h                    |  6 ++
>  include/uapi/linux/handshake.h             | 11 +++
>  net/handshake/tlshd.c                      | 83 +++++++++++++++++++++-
>  6 files changed, 133 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index a273bc74d26f..2f77216c8ddf 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -21,12 +21,18 @@ definitions:
>      type: enum
>      name: msg-type
>      value-start: 0
> -    entries: [unspec, clienthello, serverhello]
> +    entries: [unspec, clienthello, serverhello, clientkeyupdate,
> +              serverkeyupdate]
>    -
>      type: enum
>      name: auth
>      value-start: 0
>      entries: [unspec, unauth, psk, x509]
> +  -
> +    type: enum
> +    name: key-update-type
> +    value-start: 0
> +    entries: [unspec, send, received, received_request_update]
>  
>  attribute-sets:
>    -
> @@ -74,6 +80,13 @@ attribute-sets:
>        -
>          name: keyring
>          type: u32
> +      -
> +        name: key-update-request
> +        type: u32
> +        enum: key-update-type
> +      -
> +        name: session-id
> +        type: u32
>    -
>      name: done
>      attributes:
> @@ -116,6 +129,7 @@ operations:
>              - certificate
>              - peername
>              - keyring
> +            - session-id
>      -
>        name: done
>        doc: Handler reports handshake completion
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 024d02248831..4797a4532b0d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -20,6 +20,7 @@
>  #include <linux/iov_iter.h>
>  #include <net/busy_poll.h>
>  #include <trace/events/sock.h>
> +#include <uapi/linux/handshake.h>
>  
>  #include "nvme.h"
>  #include "fabrics.h"
> @@ -206,6 +207,10 @@ static struct workqueue_struct *nvme_tcp_wq;
>  static const struct blk_mq_ops nvme_tcp_mq_ops;
>  static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
>  static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
> +static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
> +			      struct nvme_tcp_queue *queue,
> +			      key_serial_t pskid,
> +			      enum handshake_key_update_type keyupdate);
>  
>  static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
>  {
> @@ -1729,7 +1734,8 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
>  
>  static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>  			      struct nvme_tcp_queue *queue,
> -			      key_serial_t pskid)
> +			      key_serial_t pskid,
> +			      enum handshake_key_update_type keyupdate)
>  {
>  	int qid = nvme_tcp_queue_id(queue);
>  	int ret;
> @@ -1751,7 +1757,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>  	args.ta_timeout_ms = tls_handshake_timeout * 1000;
>  	queue->tls_err = -EOPNOTSUPP;
>  	init_completion(&queue->tls_complete);
> -	ret = tls_client_hello_psk(&args, GFP_KERNEL);
> +	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
> +		ret = tls_client_hello_psk(&args, GFP_KERNEL);
> +	else
> +		ret = tls_client_keyupdate_psk(&args, GFP_KERNEL, keyupdate);
>  	if (ret) {
>  		dev_err(nctrl->device, "queue %d: failed to start TLS: %d\n",
>  			qid, ret);
> @@ -1901,7 +1910,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>  
>  	/* If PSKs are configured try to start TLS */
>  	if (nvme_tcp_tls_configured(nctrl) && pskid) {
> -		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
> +		ret = nvme_tcp_start_tls(nctrl, queue, pskid, HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC);
>  		if (ret)
>  			goto err_init_connect;
>  	}
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 7f8516892359..818efdeccef1 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1833,7 +1833,8 @@ static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
>  	kref_put(&queue->kref, nvmet_tcp_release_queue);
>  }
>  
> -static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
> +static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
> +				   enum handshake_key_update_type keyupdate)
>  {
>  	int ret = -EOPNOTSUPP;
>  	struct tls_handshake_args args;
> @@ -1852,7 +1853,10 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
>  	args.ta_keyring = key_serial(queue->port->nport->keyring);
>  	args.ta_timeout_ms = tls_handshake_timeout * 1000;
>  
> -	ret = tls_server_hello_psk(&args, GFP_KERNEL);
> +	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
> +		ret = tls_server_hello_psk(&args, GFP_KERNEL);
> +	else
> +		ret = tls_server_keyupdate_psk(&args, GFP_KERNEL, keyupdate);
>  	if (ret) {
>  		kref_put(&queue->kref, nvmet_tcp_release_queue);
>  		pr_err("failed to start TLS, err=%d\n", ret);
> @@ -1934,7 +1938,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>  		sk->sk_data_ready = port->data_ready;
>  		write_unlock_bh(&sk->sk_callback_lock);
>  		if (!nvmet_tcp_try_peek_pdu(queue)) {
> -			if (!nvmet_tcp_tls_handshake(queue))
> +			if (!nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC))
>  				return;
>  			/* TLS handshake failed, terminate the connection */
>  			goto out_destroy_sq;
> diff --git a/include/net/handshake.h b/include/net/handshake.h
> index 68d7f89e431a..f5a249327bf6 100644
> --- a/include/net/handshake.h
> +++ b/include/net/handshake.h
> @@ -10,6 +10,8 @@
>  #ifndef _NET_HANDSHAKE_H
>  #define _NET_HANDSHAKE_H
>  
> +#include <uapi/linux/handshake.h>
> +
>  enum {
>  	TLS_NO_KEYRING = 0,
>  	TLS_NO_PEERID = 0,
> @@ -38,8 +40,12 @@ struct tls_handshake_args {
>  int tls_client_hello_anon(const struct tls_handshake_args *args, gfp_t flags);
>  int tls_client_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
>  int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
> +int tls_client_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
> +			     enum handshake_key_update_type keyupdate);
>  int tls_server_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
>  int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
> +int tls_server_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
> +			     enum handshake_key_update_type keyupdate);
>  
>  bool tls_handshake_cancel(struct sock *sk);
>  void tls_handshake_close(struct socket *sock);
> diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
> index b68ffbaa5f31..483815a064f0 100644
> --- a/include/uapi/linux/handshake.h
> +++ b/include/uapi/linux/handshake.h
> @@ -19,6 +19,8 @@ enum handshake_msg_type {
>  	HANDSHAKE_MSG_TYPE_UNSPEC,
>  	HANDSHAKE_MSG_TYPE_CLIENTHELLO,
>  	HANDSHAKE_MSG_TYPE_SERVERHELLO,
> +	HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE,
> +	HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE,
>  };
>  
>  enum handshake_auth {
> @@ -28,6 +30,13 @@ enum handshake_auth {
>  	HANDSHAKE_AUTH_X509,
>  };
>  
> +enum handshake_key_update_type {
> +	HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC,
> +	HANDSHAKE_KEY_UPDATE_TYPE_SEND,
> +	HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED,
> +	HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED_REQUEST_UPDATE,
> +};
> +
>  enum {
>  	HANDSHAKE_A_X509_CERT = 1,
>  	HANDSHAKE_A_X509_PRIVKEY,
> @@ -46,6 +55,8 @@ enum {
>  	HANDSHAKE_A_ACCEPT_CERTIFICATE,
>  	HANDSHAKE_A_ACCEPT_PEERNAME,
>  	HANDSHAKE_A_ACCEPT_KEYRING,
> +	HANDSHAKE_A_ACCEPT_KEY_UPDATE_REQUEST,
> +	HANDSHAKE_A_ACCEPT_SESSION_ID,
>  
>  	__HANDSHAKE_A_ACCEPT_MAX,
>  	HANDSHAKE_A_ACCEPT_MAX = (__HANDSHAKE_A_ACCEPT_MAX - 1)
> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
> index 85c5fed690c0..91d2bb515b7d 100644
> --- a/net/handshake/tlshd.c
> +++ b/net/handshake/tlshd.c
> @@ -41,6 +41,7 @@ struct tls_handshake_req {
>  	unsigned int		th_num_peerids;
>  	key_serial_t		th_peerid[5];
>  
> +	unsigned int		th_key_update_request;
>  	key_serial_t		handshake_session_id;
>  };
>  
> @@ -58,7 +59,8 @@ tls_handshake_req_init(struct handshake_req *req,
>  	treq->th_num_peerids = 0;
>  	treq->th_certificate = TLS_NO_CERT;
>  	treq->th_privkey = TLS_NO_PRIVKEY;
> -	treq->handshake_session_id = TLS_NO_PRIVKEY;
> +	treq->handshake_session_id = args->handshake_session_id;

Should you initialize the new th_key_update_request field to 0 here?
Prevent leaking previous memory contents to user space...

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> +
>  	return treq;
>  }
>  
> @@ -265,6 +267,16 @@ static int tls_handshake_accept(struct handshake_req *req,
>  		break;
>  	}
>  
> +	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_SESSION_ID,
> +			  treq->handshake_session_id);
> +	if (ret < 0)
> +		goto out_cancel;
> +
> +	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEY_UPDATE_REQUEST,
> +			  treq->th_key_update_request);
> +	if (ret < 0)
> +		goto out_cancel;
> +
>  	genlmsg_end(msg, hdr);
>  	return genlmsg_reply(msg, info);
>  
> @@ -372,6 +384,44 @@ int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
>  }
>  EXPORT_SYMBOL(tls_client_hello_psk);
>  
> +/**
> + * tls_client_keyupdate_psk - request a PSK-based TLS handshake on a socket
> + * @args: socket and handshake parameters for this request
> + * @flags: memory allocation control flags
> + * @keyupdate: specifies the type of KeyUpdate operation
> + *
> + * Return values:
> + *   %0: Handshake request enqueue; ->done will be called when complete
> + *   %-EINVAL: Wrong number of local peer IDs
> + *   %-ESRCH: No user agent is available
> + *   %-ENOMEM: Memory allocation failed
> + */
> +int tls_client_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
> +			     enum handshake_key_update_type keyupdate)
> +{
> +	struct tls_handshake_req *treq;
> +	struct handshake_req *req;
> +	unsigned int i;
> +
> +	if (!args->ta_num_peerids ||
> +	    args->ta_num_peerids > ARRAY_SIZE(treq->th_peerid))
> +		return -EINVAL;
> +
> +	req = handshake_req_alloc(&tls_handshake_proto, flags);
> +	if (!req)
> +		return -ENOMEM;
> +	treq = tls_handshake_req_init(req, args);
> +	treq->th_type = HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE;
> +	treq->th_key_update_request = keyupdate;
> +	treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
> +	treq->th_num_peerids = args->ta_num_peerids;
> +	for (i = 0; i < args->ta_num_peerids; i++)
> +		treq->th_peerid[i] = args->ta_my_peerids[i];
> +
> +	return handshake_req_submit(args->ta_sock, req, flags);
> +}
> +EXPORT_SYMBOL(tls_client_keyupdate_psk);
> +
>  /**
>   * tls_server_hello_x509 - request a server TLS handshake on a socket
>   * @args: socket and handshake parameters for this request
> @@ -428,6 +478,37 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
>  }
>  EXPORT_SYMBOL(tls_server_hello_psk);
>  
> +/**
> + * tls_server_keyupdate_psk - request a server TLS KeyUpdate on a socket
> + * @args: socket and handshake parameters for this request
> + * @flags: memory allocation control flags
> + * @keyupdate: specifies the type of KeyUpdate operation
> + *
> + * Return values:
> + *   %0: Handshake request enqueue; ->done will be called when complete
> + *   %-ESRCH: No user agent is available
> + *   %-ENOMEM: Memory allocation failed
> + */
> +int tls_server_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
> +			     enum handshake_key_update_type keyupdate)
> +{
> +	struct tls_handshake_req *treq;
> +	struct handshake_req *req;
> +
> +	req = handshake_req_alloc(&tls_handshake_proto, flags);
> +	if (!req)
> +		return -ENOMEM;
> +	treq = tls_handshake_req_init(req, args);
> +	treq->th_type = HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE;
> +	treq->th_key_update_request = keyupdate;
> +	treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
> +	treq->th_num_peerids = 1;
> +	treq->th_peerid[0] = args->ta_my_peerids[0];
> +
> +	return handshake_req_submit(args->ta_sock, req, flags);
> +}
> +EXPORT_SYMBOL(tls_server_keyupdate_psk);
> +
>  /**
>   * tls_handshake_cancel - cancel a pending handshake
>   * @sk: socket on which there is an ongoing handshake


-- 
Chuck Lever

