Return-Path: <linux-nfs+bounces-15392-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DECBEEA9C
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 19:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC50C3E4B6D
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811681FDA92;
	Sun, 19 Oct 2025 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H2ptP4GV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fmiP0HdZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827B1DE4F1
	for <linux-nfs@vger.kernel.org>; Sun, 19 Oct 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760893935; cv=fail; b=EQIu+Gj7/lkT92HwdyQYmHRgqjBOKNw6r5LcHxR2HM+2iYjlGKhuyO6ahsHx2kzQ8895E0xNn26tFYd4YXNTHsLXjsG++3ha21qG+5Moz3HriaIgOzSJYsMsk7AyOii/Pt+GcGFaCzY0YebrcKESfJVE1fYG+fd8ulnaizo+4u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760893935; c=relaxed/simple;
	bh=f0+/5uB/nUutl3OCJ0X8c8h2Id4sSrPl7gVkQs4BnV0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gAP6XmbpOC0GDOQiBipzpDI+T5pYnGnmUbRfv77BlqAaGcLimFtebLAOxJgP6FhrXf0IHk4B9S8vYFDUcFAKU6GRij3g6M+lIGE2eEp2LsgUeera+9ftHB8+rUguDOaXn+vbHJdqJAOL9YAWi7Qx4pZ8Yki81JNTxcn4xqHTKro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H2ptP4GV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fmiP0HdZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JFWlkv023310;
	Sun, 19 Oct 2025 17:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/QaaR4xD9U2leZ4Kaq/ADMxlo3Gwwih7n+KFPtGLASU=; b=
	H2ptP4GVa4DGA0Ud8FJ+LKTYadCDrd2qFU2j/CO8/h+0tJYej/XGJDOTk09VvPNK
	X+vUe48ELG59gzgjuagqVohkh+C9Y8Dg3YF76rntRIx3Zu+h0OaV5G87d7iguHuq
	scK16S6wyrGazlxlJgZJ4u/OK7S3Kj1ZGD4kMOmzp78OgSzfIuovDHLEU8ep8rbj
	pwqmo+e6sXsm3XsC0lsppNo4G7xq2CLMV/z5WbckKBWYFtcevlPTB0jQKwZLDmmc
	b4Q9UpmC086tZnUYVgL6VkB0uFBwqBSM6Xh/OcYSowCgR3Y/W2kOzo5KrvIxAJdN
	uG/250u4O7AbRKvRb2PBSA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vvs4tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Oct 2025 17:11:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59JGJT6g013705;
	Sun, 19 Oct 2025 17:11:47 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1ba06pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Oct 2025 17:11:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kc/qdUQYutkgpxjcs4ACAlujsjbjmeeRlM+LCaI9Lx0TZk6LQAoNm5BcGQYR58L+wP+UBPSAzOBL7LzSH7JB23GEYi+W1ZXo8iqwD0jEs+mkrKKRYV9jBUzmn4ibQ24tnX+8rVQfLWrbyVBl61bdz+kXqKzItcrmNnA1lamRnizElnM1nAlDDIUasRyonWuLK4hVJmxWxggO7ftPq/HmL97rMhUswAIN2awe9/9gXX/4iZgI5uuv0kH2Jlf49BvKhr1pckdi8kghA3HhRD3J3tN5h7fO2Ll9zYrgTSdqxSHrI0PMVI5h+1KAQ9ke8P8jUr+mslF6+eIT49T4w6Mx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QaaR4xD9U2leZ4Kaq/ADMxlo3Gwwih7n+KFPtGLASU=;
 b=ruGLueAl2/su1/25l+dzu3nSizmR6LpmDbIuNhgvVX8ee7U2iQS3ULz6cwFhjrvauw4W3yU/sRRIzHxAzyzYzbS3xH7LKynmuIrVBSi7NqhVysnVDeMrk8UP9LIJrSNtcLzrvVEbt1BZMtS/UaubHjol6kJaHkC834BkSDlQF9pXDjq6/yDACivwkPFK63lWzwt+8EwP4yYfKSpZoQYeTMDXmkCx6GNv6nZ8Riyu6f2qG/GWvvwvauFBrpVoP4/z/vUT4sMkDCSz8wknNSURQ8oMh9pmSSq6SVi/duy2GeOT0SdEBCUPG7DVmrXg3tDbI7V37B1pr3zucX89N/1GvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QaaR4xD9U2leZ4Kaq/ADMxlo3Gwwih7n+KFPtGLASU=;
 b=fmiP0HdZUnkIgx0u5ulia595ShvPF6/ryoZo6Bz9k0bdVJLRUFfgS+kOK2fM3mat2gCICAf6QO0g1dJlEx6oSM7yewUkz9lyGDaFMEzU6n08X1/zs+YmQSnYjMGEp/ozAEcS52/xP+ZEcmsvmeJWKcKx52mhOPW2S67vgiNU33o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4655.namprd10.prod.outlook.com (2603:10b6:a03:2df::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Sun, 19 Oct
 2025 17:11:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Sun, 19 Oct 2025
 17:11:43 +0000
Message-ID: <8678fb71-ef4f-4bdd-b233-24c5ef3c27b6@oracle.com>
Date: Sun, 19 Oct 2025 13:11:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] pnfs: Set transport security policy to
 RPC_XPRTSEC_NONE unless using TLS
To: Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
        Olga Kornievskaia
 <okorniev@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <cover.1760831906.git.trond.myklebust@hammerspace.com>
 <816ed47531df15f4e64c54df181ffc59827d18fe.1760831906.git.trond.myklebust@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <816ed47531df15f4e64c54df181ffc59827d18fe.1760831906.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0036.namprd05.prod.outlook.com (2603:10b6:610::49)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4655:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a271a2b-071f-472d-a0d6-08de0f3293a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vk5wV2lEOUEyQnUzSmhEVHdFTUQ2NVJlU3NYM2VPZW5rNFBjb3QrSG9HY01T?=
 =?utf-8?B?RlpHYlowdjJmbDJHZ0JzM2hFSTZETWpYaGZreFNvc1FLa3lZWHhvRGJQbDNa?=
 =?utf-8?B?Wjk0YXR1T2p5S0o3VEZqVER1azBOZzNVYmV2ZzlCeDJwUzNkU0txNjJsdkdS?=
 =?utf-8?B?elBEQXZiWUtyUVUzNzVNTWhxb3c2QkpRbmNVM2Jmc1NuUWxZUVBCWVJDTnlt?=
 =?utf-8?B?aXFyL0JLOE9XVjlBeGN6S3ltQUh2TldRcUozdzJkem5FdVFLeGVxQkhyME01?=
 =?utf-8?B?YzM4MkJ4aW53SDZHTmR4a0VlK0l3QlhUK201OHBDbmM3eEJLTjI1M1htd2gx?=
 =?utf-8?B?VVlINU04NWJKZU5BVElpd0cwbUN1V3RJdnQ1a1JvbW8zMGhWTHh6QXpja2tE?=
 =?utf-8?B?OVd4TnpOZEx2dWJuZlh0N3lqaUVJbnRIQUM5TnAwTWw2VmtzS0djT0FGVnBy?=
 =?utf-8?B?ZkNwY1h5VitROUJIL0tIR29OQTJRSkZubE90Qmw5VDZMV1d4VThZbjkzeC93?=
 =?utf-8?B?RWxSSmZqRzYweFVsdStzUnlpdEtNSnJqZitlS05iQWQyQ3d3Ly96TE9uV3pF?=
 =?utf-8?B?cUtUS1VUMGlURUhZVnBHN3UydnZqd2pQWk1IaGlIODVXZHlldW1JRDQ1Q2Na?=
 =?utf-8?B?cFdWMEYwaCsvM1lZZWZ4d3ZTODhKY0IxMThZN2N6aEF1K1JnaC91ZFJxZ1Nj?=
 =?utf-8?B?KzZMdkt2LzFFQk1iWG5SRVlPeHd0eVBHMGNNdzVkdXBjbDlPY0JBd2hsNXFx?=
 =?utf-8?B?VTdkdXFieEUwVGJQNi9rL05jdFJGRDBaUGRUUEdGWklpQlZOQUVpYzJYVU9P?=
 =?utf-8?B?eWdHQlkxeW8wdFMzRms5UVU5T3ladGxjdVpEb044UEk4akJnTVQ4VnZVaEdl?=
 =?utf-8?B?d1ZMQ2ZTcWhpYmcwVmUzK3pBL0k4cWJ4RUNkbGo3aDd3TzhBVXBTWUJCbVR0?=
 =?utf-8?B?aUoyczZZSHhFMEFHUEN1RkNIOTZ4NGk2VDRqRTdnRGtFU054VnZaWXM0WnRM?=
 =?utf-8?B?Sk5RMDBmR0xGRFhLOEVnNDRtZ29ETFVURERJemk0VDNTR1M0Z1o0VklDUllr?=
 =?utf-8?B?TmI2ak52N05hbjRGTVU0TVdycloxY0E5Mml5cW5YbVNYNElNMXI5WW1IVUpG?=
 =?utf-8?B?aE1pcXJLalJqcVU3Wi9UZHZiUUZ4K1NEbWZrOGd0SkpyUUpKZXpibU96REpB?=
 =?utf-8?B?WnArTVN2WmphdkRpam9sRVphSjFPS1oyRDh6dkszV2wvbjhvY1JGbGFRLzd1?=
 =?utf-8?B?YzAzekpZak5ST1dBaHdMd1QxK2dpeUhLdmVIQTFBUFljQW9FeCt6aUw0SzlC?=
 =?utf-8?B?d1dMNW5DMU1MazlueXRnODByRW5OSXAzdXh4dTdFek02cy9sanl1TmlLbWt1?=
 =?utf-8?B?MUNuc2crM1lWUnZVeWdNTUJWSnR0U3c2QkMzNWRIcmZ4dW9qSlg2RlV3OURx?=
 =?utf-8?B?RE0rYk9UcFVqL3NHS3lDb1pGdDNhTjBMMjBTSWtTOG9ta3V5bGNOd1o0MGhD?=
 =?utf-8?B?eEV1UWp1dVE2MGZDYzZpeUJOaWQ3RjNEdzhlUm9QcXk1WWo4MnNtMWlhSm9G?=
 =?utf-8?B?ODZtU090VklqMm8xM1kxanJvdlo2RkZjNzVySTRENWdoemtCZTE0L3NZTG5z?=
 =?utf-8?B?dTlXSHA4OFZXNmI4eUpJNWpIYjJFR204M1VobEMwNUdTcys2K1NxbVRqTnlS?=
 =?utf-8?B?N3ErdHd5RmZzd1FrU2VwMWY5MUh4TFNjSTFqMi9DVmNhTlZpZDJaQ0U0TkJ0?=
 =?utf-8?B?T3VvVktjTitFbUZ1Y0EvSlRrNkJlNnp1M2MvVkZsaWlGdWI3dUsvc21GR2lj?=
 =?utf-8?B?ejVYWnZGaEtMeFJRVFNXdzhJUG5mcmR2OWpaemNrVW5oMmNFUU5SUHA2ZVlp?=
 =?utf-8?B?V2IzVVIxaWI1N3Y4L0ZUUFBORXgrdVR6T3FTOUgyRlg1K0k1cVV4NUw4ZStz?=
 =?utf-8?Q?BKfxoRzw0Vo0J/uXaGmkRYgcCpehrMAl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmNheXUxL0Vxcmp2cUF4RGtuRjJZMVZ1YUVkS1FBSFh1bVNtbjExTCtFU2Nu?=
 =?utf-8?B?cmFrd0xFVzdEdk9NUEN6akZlZjBVQU5lVVlPcHZ5aGxWbXp6UGI2RkIwRHht?=
 =?utf-8?B?MGwxK2RENVI1NHVQUFpKeDJuNzFCUVZVNEhWWGpWYk1NS1A2VHJHL3pkeWx0?=
 =?utf-8?B?V1BGbFRJM2k3RUIzN2J3M0lMYVRzaEF0cEJYTnYydjhDclRlMnRXZUV4UHZ2?=
 =?utf-8?B?VXo4cUhyVWtnY3ZnVFVxNE02MTgrc256WjQ0OXlabmMwNGZWZFpKOUpvMUN6?=
 =?utf-8?B?RytYZncyUDNJYnpKYWJpdXlZUGNqajdHWnNmdXNxQW15QzNIVXZsQStCMXFi?=
 =?utf-8?B?YVFJTWRNWmEvVFFKdjN0Tm8xSDVKVFRHRHRSdkFyd1BCaUk1Q0VBd0pENFBO?=
 =?utf-8?B?cFA0L0dpZkdGZFJzcUZQYlpoekRsNCtRdTAxWllxQXJiUnUwaGRmQU9OWHhL?=
 =?utf-8?B?b29zU1JqVlJ4a1ZVR1FucDVjd0VETkR5WmNJRnVUYXdSVDg5djFXYXFzd3Vi?=
 =?utf-8?B?VXU3OGN1UDZBRUoyWWtEYXFTeEpkRHFERGIzRFgyTVVQNFd5VFVzUFVuSlQy?=
 =?utf-8?B?Rm5ZbW1iTGlIbUVPeURvNHdSZHM3N3BPam54dEdIY29Ga3FnbUlYYlRURTZl?=
 =?utf-8?B?bVNZczVlVGlqOHlsZ2dpalZJUHNkRzZiK04raWFpdFlFTWsrQTJCOWFGaUk3?=
 =?utf-8?B?bU5WQ2I2RU1nTFo3SThPMDFETmdNMXZyOXJncVFRSDNFTWVwcCtHcGVNY05V?=
 =?utf-8?B?SDJ1Y2RFeVNtRlBQMkNYWmhzYUVuWndHbFBGbGVXRmdrUlJTYzVhY2tsclRv?=
 =?utf-8?B?dmZaWVhieVNndmFKMHZid1pvbDhmVGc4aVh3bTZCL1dvU1FKM0hXK0hhSC9u?=
 =?utf-8?B?Nno2WitOZnRTNFVUMHhhN3kxb3VvOTFOcHM0YU1jTEJoRTgzczlJaStIakhk?=
 =?utf-8?B?TUJsVHRCcDYyRlVkRklKMHFPcE1YTGY3aHRjSlg5NjF0ZjU0OU1WZnF3VTN6?=
 =?utf-8?B?ZW1hMFFFOEdKekJuMWhwa21VeXZsR2dIT2YxRXBCblQxU3ZuNU1tamF0emJK?=
 =?utf-8?B?Y2dwWjdkeUs1R2R4aldqc3VNYlp1NFNlVTBlNHhyek41cEU5Q0hXM2RNdEdp?=
 =?utf-8?B?T3A1dm1odVh3NWg2cjhRcExYL2xJYlB0cGFiaVdKb2E4YnBlMHcvcnV2cHhm?=
 =?utf-8?B?UjRnY1ZaMzdhemFSdHk3YjM5d0ZlVnFzY2pTOWxTOHlvd05mbGtYaFoxdnRp?=
 =?utf-8?B?blVYbkdFTFFXQUhZZ0RpUHI2QkhzcmsrckxMcUtCUDNDSnA5Rjh0RUFwRUdI?=
 =?utf-8?B?WExEbWNYeG85ck8yd25ZMGlWdFlseUQycVZWRmFUUlNKY3JBeDNjNlhYSlo3?=
 =?utf-8?B?YktmZURCb08zMlMrSkFIeDJ1WTFzbXdJSG9zUlFZQnh1RmRybHRxQURpVTV5?=
 =?utf-8?B?elFQcFJ2QWlDQ1RDNkYwZkNkSmlabm03aW5xNHlXZCtCT0ZCeUI3MVUrdHhK?=
 =?utf-8?B?UWtDcnUrWW5OZVFpWG1tUFNGUklDRGNtQzM4R0FSenBqL3FwSXlqZmtyQTc4?=
 =?utf-8?B?eHhZcDF4Vm5uZUpnZmZ3eXRhVk1mOGlVTWFOa1VjK0pXSkpKU3pUSDRBekRi?=
 =?utf-8?B?TjFkcE5jSHB4bkE5b2lOL0RzaWdEOUdtYXdZWjZDUXBJMmJyc0l2Nmc3dnpk?=
 =?utf-8?B?eng5SXg0aXpsb28wUlVZeE9UT2xXVVp2a3o3ZlY3eVdlaHFIWU1NbmdpeDJO?=
 =?utf-8?B?WUxGWEo2S2Y3dmIwU216WldadXMvQzFPOXZVa3VzU0lPR3dZVE9jSmFjRUlN?=
 =?utf-8?B?MDR1L05CdkIreDQzcDVCUG94enZIUFR6T2l4YitXMHZscjVjSE9WVU1uSDMr?=
 =?utf-8?B?NnA1c2I5YzlVcEFpQk1XOEdWenlXR3pRRndQeU12c29OR1doNHY5ejIzSFJu?=
 =?utf-8?B?RnJqUE55MnRGZU8vR3R4bTZ3Zm96SS9kVGY2dlpCWG1zY2JOTENFZlRZZFh6?=
 =?utf-8?B?YXpwYUFhZy9QajhLakp6MDJET3F4TVJtNnpwOVpqTUFwZmF2WWZhaE1KT3lR?=
 =?utf-8?B?ZlMyVkcrc2pxZWxKdlRSaW9xdDVBVkppV2UveHBKS3VGZTI2bnUzOE9kcWpm?=
 =?utf-8?B?NDMrcUIvRWY1dENJRE8rUzFiMkR6N2p6VDF2bVNPUWdLSVVhSVZOdE9ZOC8x?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e+WcI74e4NdAMB706oR6yoKbGzuwvQiYQUj6vltla8x0YWPziHmJkrKo0wdkhBo2Z7t3nYCjPPvV4KDYTj+sqE+sv0WQ9J7xZsoBF3jbmroQU88HqNk7NPk/68afsWLu39mBNthc6oO7Kk4QSvRNw0ZrvtVQvn52OD1AarWH8MXJjNRsHVTIrc34+zr9fA1UUJ4gyjAT7ptmyxMw2rER5oInHOVdVsCRXjNen277tiW6NAA9h/GBE+7pJrQIelsx41BKCk2TEqtZOsyuLDSfsCzTTERfmvsTR4rY4OTrSlkkGhpwHt08UTLm4iQyaTEvS1a1SCujviZihJojYznnQsld7kZExyTm3Y+RL61Erra24iGBWyOE/YT5yQAuwBVmxxyIt+iRszYZ18d53BZD63Amr/kMsaEmyKEDNMmeKMn8P0Cghzrnp6Usc6BinQmm18YKRNqp67+NcGp9NV881krrPSN2PdtWSC3CN2ShoJZ5TQhc28feukOFSz4wtPpSo10GsxFd87lQEFjjSN8AxbDCOXl5xLEvgB/Rou1GkWbzFV9769wWX1ecWm61K9vBr0xDcywZJGh2yYueZeDLEgRRIlBjZOTs1BZ1+++m5IY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a271a2b-071f-472d-a0d6-08de0f3293a1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 17:11:43.5862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dv/z5c6oG2txJeL7xYd/7Jll/1yUOZXjkvbVPdbKIomS9M7gd8XWSYEIbFhObQESBYWTGWBAabmJjgnpTwbMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510190124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1Zp23f+NrM48
 Ecff+1HKE8bE6mY9JxP7KxAOf9CwCYcvD0XfsIN9NDSHAv9lVbPA5jANcxEmb4YoiF+hskttWpW
 tTFHVY4ibaHMsswis67GqJxW8eORguagx1+b28BdxscbTbaxFBul24spAsoSa00lEFUHrc/BsT4
 nbsAE+o3CTlNgA+U6icg3JoN5zZdnkjvw/GtvHeV7RgzTKLrowV3eV8w5ZnaVrm4mSo4FBzTNqL
 esmikDqFJ9sbDqqFFZd6X2AWfFUTsqi7/7eRtXjGrV7zH4wAcH13HTrMutEycft6Y8HF3T341TF
 MslL2gr4cox5gO4SaFlwYQe5wx60kPBEvEuHJosueIqhR+4fiOpz/k2nx3FtzmzZ2fqEPFI1Zmq
 ZiyNdGAwx1aEqkxFp2dCbG40rMBF2Q==
X-Proofpoint-ORIG-GUID: yNSd1hbNf2aE3gNEmmwhRGzEwELFf3Dc
X-Proofpoint-GUID: yNSd1hbNf2aE3gNEmmwhRGzEwELFf3Dc
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68f51bd4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SEtKQCMJAAAA:8 a=yPCof4ZbAAAA:8 a=krEpux_Mt0BFDu3vp7sA:9 a=QEXdDO2ut3YA:10
 a=kyTSok1ft720jgMXX5-3:22

On 10/18/25 8:10 PM, Trond Myklebust wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> The default setting for the transport security policy must be
> RPC_XPRTSEC_NONE, when using a TCP or RDMA connection without TLS.
> Conversely, when using TLS, the security policy needs to be set.

That matches my understanding.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> 
> Fixes: 6c0a8c5fcf71 ("NFS: Have struct nfs_client carry a TLS policy field")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs3client.c | 14 ++++++++++++--
>  fs/nfs/nfs4client.c | 14 ++++++++++++--
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
> index 0d7310c1ee0c..5d97c1d38bb6 100644
> --- a/fs/nfs/nfs3client.c
> +++ b/fs/nfs/nfs3client.c
> @@ -2,6 +2,7 @@
>  #include <linux/nfs_fs.h>
>  #include <linux/nfs_mount.h>
>  #include <linux/sunrpc/addr.h>
> +#include <net/handshake.h>
>  #include "internal.h"
>  #include "nfs3_fs.h"
>  #include "netns.h"
> @@ -98,7 +99,11 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
>  		.net = mds_clp->cl_net,
>  		.timeparms = &ds_timeout,
>  		.cred = mds_srv->cred,
> -		.xprtsec = mds_clp->cl_xprtsec,
> +		.xprtsec = {
> +			.policy = RPC_XPRTSEC_NONE,
> +			.cert_serial = TLS_NO_CERT,
> +			.privkey_serial = TLS_NO_PRIVKEY,
> +		},
>  		.connect_timeout = connect_timeout,
>  		.reconnect_timeout = connect_timeout,
>  	};
> @@ -111,9 +116,14 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
>  	cl_init.hostname = buf;
>  
>  	switch (ds_proto) {
> +	case XPRT_TRANSPORT_TCP_TLS:
> +		if (mds_clp->cl_xprtsec.policy != RPC_XPRTSEC_NONE)
> +			cl_init.xprtsec = mds_clp->cl_xprtsec;
> +		else
> +			ds_proto = XPRT_TRANSPORT_TCP;
> +		fallthrough;
>  	case XPRT_TRANSPORT_RDMA:
>  	case XPRT_TRANSPORT_TCP:
> -	case XPRT_TRANSPORT_TCP_TLS:
>  		if (mds_clp->cl_nconnect > 1)
>  			cl_init.nconnect = mds_clp->cl_nconnect;
>  	}
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 6fddf43d729c..bb4c41ad7134 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -11,6 +11,7 @@
>  #include <linux/sunrpc/xprt.h>
>  #include <linux/sunrpc/bc_xprt.h>
>  #include <linux/sunrpc/rpc_pipe_fs.h>
> +#include <net/handshake.h>
>  #include "internal.h"
>  #include "callback.h"
>  #include "delegation.h"
> @@ -982,7 +983,11 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
>  		.net = mds_clp->cl_net,
>  		.timeparms = &ds_timeout,
>  		.cred = mds_srv->cred,
> -		.xprtsec = mds_srv->nfs_client->cl_xprtsec,
> +		.xprtsec = {
> +			.policy = RPC_XPRTSEC_NONE,
> +			.cert_serial = TLS_NO_CERT,
> +			.privkey_serial = TLS_NO_PRIVKEY,
> +		},
>  	};
>  	char buf[INET6_ADDRSTRLEN + 1];
>  
> @@ -991,9 +996,14 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
>  	cl_init.hostname = buf;
>  
>  	switch (ds_proto) {
> +	case XPRT_TRANSPORT_TCP_TLS:
> +		if (mds_srv->nfs_client->cl_xprtsec.policy != RPC_XPRTSEC_NONE)
> +			cl_init.xprtsec = mds_srv->nfs_client->cl_xprtsec;
> +		else
> +			ds_proto = XPRT_TRANSPORT_TCP;
> +		fallthrough;
>  	case XPRT_TRANSPORT_RDMA:
>  	case XPRT_TRANSPORT_TCP:
> -	case XPRT_TRANSPORT_TCP_TLS:
>  		if (mds_clp->cl_nconnect > 1) {
>  			cl_init.nconnect = mds_clp->cl_nconnect;
>  			cl_init.max_connect = NFS_MAX_TRANSPORTS;


-- 
Chuck Lever

