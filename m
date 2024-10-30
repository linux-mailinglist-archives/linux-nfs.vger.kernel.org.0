Return-Path: <linux-nfs+bounces-7589-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709769B6D8C
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 21:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C033BB21A76
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 20:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C5A1D0F74;
	Wed, 30 Oct 2024 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KN3FKky1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T5tpbtWw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CBC1D172C
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319701; cv=fail; b=CsJ9GHNQpM9NGKogWyJhRMOff39VpNVwipIY01Y5recZJRu5FaelkBh7R9DsK7whWDUjS+1y76npPO/fdtl7fBmxF6ANxhyLmKU8Entsobbp1frmS3U5X4sR9EB5I4FiOb1+bZFBVp45bhIPEKtSkiEIexksBenJ5syMvKSmAVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319701; c=relaxed/simple;
	bh=SwyPNEMEw0p7pLTc2cKDd7CttWBB2IqIkCHmDaBqUH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iY+ozAhJ82I0CT9cQZJS6fnSupfJSpWfyxKV+buRiUkqIfZpCmQaagSWRP1kKA9yI0Hmuzp//qDJPyv4Bgav9//I7yAZ8Lwy1ms8zoP5FOiDmVO+gfw6fnKOZMFHAew+WV7Ic8gS/7WVI9zMecbXQx7XYNzDHdEQOzKHPKWl2o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KN3FKky1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T5tpbtWw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UJBaug006519;
	Wed, 30 Oct 2024 20:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KLJnHLP6l0IGZ3uNNeTAzO1T71MDaYg1sY9oyXRjXxU=; b=
	KN3FKky1Eo9JYYvI8d7J8r6rnq7mbxYEGFWIyXrohLUpkeGI7m4TnCPZJU9O172A
	Aa3yAffHExG/PPFo6NU28TcZsSpDGd6Untal6e6EDMbMttclsupK3GgsIJ57RdLJ
	u1psm9MBiHP3x4s57KmoiEJAjSm8ajf9aERyzF/s7i8wu+9iVVZ1InYmdYXcXNJj
	8ybOQzJ+iDwg+y0yOr1ex6fDqA08bHAFczuBz34xfJpu0bdlmmxE8BDkz48PidWg
	YxpqiYLoFx4rTIUcrmgiGXppmzHx6fZrfMz6D2XwFNE5bu6Gwa80JcF/xl3tyHlH
	qmWCWYdnU7j4NE03MjM2nQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqgw6n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 20:21:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49UIUHZg012103;
	Wed, 30 Oct 2024 20:08:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnaehyxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 20:08:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QH7OP7QwvS/IzVLkEcoc1bLF+BgnZVcb2/xxGUJUW7gngn139edi5OmqmR8XeXZ6KgX3jQOplKMoAAti0M6MDqWWQpOxy++1JtWRCWJLFjvLvVsWwQ4BT/M2YNpnrnjRgrUzlTPN8nQePPhmWLhDg0Ug+8Qetnm4zaMaBoCZ2FYac0LnubFOhewVxS8C8g/fWR9kkul2Q9uWhQPhEgyGFzjLmeowccJynFDRX44/yIbMVUNu1B04kxMxWKtIpm9cVv6wFUL2pKxhDsUd9oSARvteIqzzojvWQEizSeZcq2Z34gj7dmb3Il00RocI/EOH5kswvi7XjtVmmCfHI+uBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLJnHLP6l0IGZ3uNNeTAzO1T71MDaYg1sY9oyXRjXxU=;
 b=kOOyxNdYI3hd5QgcBy2bB+msWk2gbakhoFX9W/jRntK0/6jbNYHKCfaj9/DpH3/qbt1EHwBDfBpKSBXChcVvVjsGhY6+MqQrg15lJsW5s9IZ+O9JlOswwsEYJ5lAjCscclSfrzSP4IUKtVqEQhiLIM56cmY+7jzSB7x7EKNWwDBEj9YPz4E7aYBxElGe9+5T+maGGiI+1YPHE4QH84lHlWquDi1ELqa3Anc/H8d/oBtCw3BqdQvcu35hoZMpNOhwklMmUkcC5nILyBqdJf5ka6h8QdvWRu1pWmBXjgNePvE4RJeVHKYuZ5MKOY8bKlghLII+qA9r04CjFjdeFLdMKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLJnHLP6l0IGZ3uNNeTAzO1T71MDaYg1sY9oyXRjXxU=;
 b=T5tpbtWwVaTnAmk8nroYMj05Kedn7p2Ca6iKMfCNz0FeFnu8UL//vgtD96l4hweTdj9oP67Pxibbv0H0qsW/MVv7CkGmNWcsuAWM61qyhZI/r39VArshQR0MtYjgCEqSNu5kHTcTjEXxIFxmpidWxUatVhgCAa5BTP83W/l/fFs=
Received: from DM6PR10MB4300.namprd10.prod.outlook.com (2603:10b6:5:221::8) by
 DS0PR10MB8197.namprd10.prod.outlook.com (2603:10b6:8:1f8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Wed, 30 Oct 2024 20:08:52 +0000
Received: from DM6PR10MB4300.namprd10.prod.outlook.com
 ([fe80::2b16:46d:bc55:874]) by DM6PR10MB4300.namprd10.prod.outlook.com
 ([fe80::2b16:46d:bc55:874%7]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 20:08:50 +0000
Message-ID: <846d9547-7cf8-486d-aaec-c0346732a578@oracle.com>
Date: Wed, 30 Oct 2024 16:08:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: nfs: avoid i_lock contention in nfs_clear_invalid_mapping
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
References: <20241018170335.41427-1-snitzer@kernel.org>
 <e25a451540d8eb63f35b82652e197b6e207d4317.camel@kernel.org>
 <ZxK73l2yAOcLe_jl@kernel.org> <ZxLVDC_C2CrWvXT7@kernel.org>
 <bedccb42-4e8a-4b9c-a0d4-982abb7a318e@oracle.com>
 <ZyKRDKeAd0m19pt_@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZyKRDKeAd0m19pt_@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:610:32::19) To DM6PR10MB4300.namprd10.prod.outlook.com
 (2603:10b6:5:221::8)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4300:EE_|DS0PR10MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 730d440f-f52c-466a-98d5-08dcf91eab9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXZ4MXNIUVdXTEs1bnpxM2NyV3BwUkRudlhTZUM0S0Q4ZEFpUHpUNUNobTQ3?=
 =?utf-8?B?QlpGeXNDMU8wV1kyam41Nzdmblo1VFdsVS9NNzhnNDY2dkdkMWRKSVN1TGUw?=
 =?utf-8?B?VllmbzRJelFuQmc4V2pnV0J0QXkzOFVZVlZRZjB4SXZZSFQrSitEVjVhZkZP?=
 =?utf-8?B?VTA3NzI4VGgvc3ViNmVEVFZSTlhPRTVsZGJtdWFFVERZTFdIaGFOWGZaTmFh?=
 =?utf-8?B?b2dEK2Nnb29rc1BtTW5ZOGljTDFJT29VRkxjdkp6OEcwWDFJdjBpQ1A4bUdX?=
 =?utf-8?B?bmgxR1FYcktDdXM2djZscm9YUmtaUEVZNlNWMEg1bkxtM25sQzZMZUdnb2ZH?=
 =?utf-8?B?bktNaURVTUE2TFV6UGlWM1pYSm5LOVFLZ1d0RVZJeSticHlzR1h0eGZDQkZK?=
 =?utf-8?B?NFNVQlhTTlJsQ21TN0tMbUNwWlZFODV2Q0Nic2tTR3ZJeFdZVUk5dHRLcEcw?=
 =?utf-8?B?Q0ZrQ2FqUzBDa0JYYzl1Q2g0SC9HcG5RdlIwU2VJNkd4MC8vdmVHQTQzL0FH?=
 =?utf-8?B?WWZNaTRocXh1bWFZdDRMeVAxc3VDYnJ2TThoVHNZamRjK2ZBT3BUclZ5bzA3?=
 =?utf-8?B?RFJqSVNwb2UvVW55d0J5K1lCUzc1emI4UEQ0QnQ1eDRJelJUZkU4S1p6YXQz?=
 =?utf-8?B?Z1lYVFZ5R0lwbmxXSEVnamMvbGd5bVdzWG9LbEd4eG1FUUJ0ZU1HOGVwbmxY?=
 =?utf-8?B?YUxzSldiSDBEcjZBQzdXVXhJakFGbStTQk56V1krVHlDamFyNTNoZVBYRHA2?=
 =?utf-8?B?TlF6eTdtVjBVRk9XZEtDRnFwZWxicysvRW9BNmMxa1lYTHhvSzkzN3lJdy9i?=
 =?utf-8?B?NGh4dkx0OG41ZXFGN3pHckJkYjdsc1N2L2YzSVA4dE40RFVnV1dtMzQ0YjR6?=
 =?utf-8?B?MmRrZFpNSFduYWg3ekY3T25PTnUvWVFHK2cwS0lGUmFwdGRrcUllOHNtTDdV?=
 =?utf-8?B?cGZjZC9DZ21oa2hRYlpDUEdQc2NVRFg2cDlCVkxTcWZMR2UwMGFFSVpINE0z?=
 =?utf-8?B?WjhmamlTUkhpaE9wWUNOckY4Y2VnMkJReXk2bE92bUlYTDRZVHBNOVFqK2Zv?=
 =?utf-8?B?cFk3N24zQlBmbmVUdnhSTHFaZ3lMZE5ZcFhPalMwVDFKU0c0TFl1c3ZsSXhk?=
 =?utf-8?B?RVRXUSt6S2RmOG8ydDhPKzBvRngvNzNGTDdiSjU1TU5VRVNVQkNqKzMwNVlY?=
 =?utf-8?B?SzZRNlFTcmxoV2NZZndFdmxyM25MdnpUY2ZIOWxSM2ticUJISy9yNk1RcXg0?=
 =?utf-8?B?TzBuSGFha1Y3ZnptRCs3UmpuLzY2TDF4eXNmNmFxYWJtZGNNYW5ZQnpkRjds?=
 =?utf-8?B?UTNtSDFONVp0YjBJeU1CTXkrVGVPYk5jMlEvUi9PdTI4SDcrdEtKY0hqT3Q3?=
 =?utf-8?B?SDFMNEtGZk4zOWZtVnlENjdLL0dYVHNjVDJVajBKS1hCanZYcVVxMmFlZnFp?=
 =?utf-8?B?Z2p4YW9JSFNMam15SHdWTnZMRmJuYkc0QWtaM0tzMEYvTzIzMFZyd1pFRDE5?=
 =?utf-8?B?bnVtbjV3alVTOGpDK2xKQ1JhbzBGQkRKbkExL0F1czRtcXIyUEtuRlJ5Qkt3?=
 =?utf-8?B?ZEYxNFJEM0dObVBWMWNFT1duSkUybGEyTlBwaFJZSDlCczkwVncxQTJYaEJF?=
 =?utf-8?B?R1ppTHRWemVtR1p1dDlTQjFZcEE5Z1hxTml3ZVAremxtYW14cFF4eDlFa3NU?=
 =?utf-8?B?WVhhZHNyV1FMREVjKzI5bVBjS2x0M3l6S0JGZDR5cmp3WXBkWDRoYmNyRnIv?=
 =?utf-8?Q?033IwMRwX1gOT0OKfe0v6D5qexy8Lhh1LXniS5F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4300.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkxXZ04zR29Tc0pWaHRtN3BKRHk1WTNCQkRPVzlDQVRmbHowdkhCNkc0eDNV?=
 =?utf-8?B?elFzRnJRMUk2Uys2TGZ1Yk5pQmFOTUtyQktyTy9mU2V1aFhDc2NOL2pScUVF?=
 =?utf-8?B?aS9HSVRvdkZadUZKcXErNllHYWQ1Z2c1WmNSTFhJMjNDbkppdG5zMFhPaTYz?=
 =?utf-8?B?T3g2NUZvVllyOCtkZ2FkWmtSSVlLYldpWCtrN0M1SzZYc3d4RFU5OU14bGRO?=
 =?utf-8?B?Q0V5eWF4U1VuNTlMMzlHTUlORDRBc0VQM0NScVYwN2pKeXRoT1MvMk92YWJF?=
 =?utf-8?B?eGlYVk5LNC9JNzZHMnRMN0ZFK2NsZk5CdWRaVCtZTTdrTHdlNnQxNFpaVldu?=
 =?utf-8?B?aklTUExnL3RDenViUVF0QWw4VVRkTFp3Qitya256WUZLeGZ2YTJhcklPeFlt?=
 =?utf-8?B?dWFHRmZ4eXZvSnRPbUlYeDBRL3ZldlJ6UklPOG5lLzkzVC9LcGNuVnJHbDBu?=
 =?utf-8?B?cG5oQ05DdHliMjUwVTdQUFEraUkrWGtmRFppSWNJU0NUOFI3M29jVEduSzhY?=
 =?utf-8?B?YWpzdlZKOXRLeG5NVWVjR1M4aDhBV0pvTG5SVU9abXRZYndZYWNtdFphNVFw?=
 =?utf-8?B?RVZzeDR6Wk82SnlvV2lSbjQzVUxNcFdBNFlEcUFlZ0FlaTF1M0laR1BwVkF6?=
 =?utf-8?B?QXBndUZMazF6ZUJsajRVeUVBK2hpU1VvbkdPVlFIWDk2R3N0U21xUzVGZTgz?=
 =?utf-8?B?c2U0NHdIQzVtMjArNmpnMkxCSnVIOUtIY0Vsc0xGakVLWDFVZmhaU2NmUlgv?=
 =?utf-8?B?WEU3ZCtKd1hJQzJMZkc0RnJieGdGelJlejBqVWh3UjVLQlZicnBpcm9mbTZw?=
 =?utf-8?B?Skw3VW93cjZBY2dxblF4ejlGQkNFNFRJOHB0WjB6WkVDWVJueU0ySXg2MWp3?=
 =?utf-8?B?Rk9TWkdXNEYvNi81ZFFzNTBMNE5FSFpoN1Q0a3M1OCtVZk42OThucEViTWRi?=
 =?utf-8?B?dDNMYXMwS0ZldXFCTFM5bVp4NzVTSHVhT0Q0U21JeVU2SGxMMSsyU1RTTW1U?=
 =?utf-8?B?VmhWVUE2QXlpbVprYmRYcDA5eEJGU3JsSkNaL3VYellVZkN4Um8xV20yZGpP?=
 =?utf-8?B?dnE3djdWQnhmWlUvN1pPVzJISWk5bDM0SFpGV253bVFDMk52dXpKaWJiRHcv?=
 =?utf-8?B?TU5oSEtyclVRSEpVZ0VqcGF2alJHeHRRRFlVQmJ6UUlOcHFMbEpEcjFlRU5N?=
 =?utf-8?B?Ri9JY05memV2U05vMDNCZVExQzFzMktqbkkvWVhsdkJxaHJqdGdtTWJzbDVv?=
 =?utf-8?B?MGxGZStob0dLS1RLcGFPU2dzWEFER2NhZDViRUpGR3BZdWZTZjNDcUpsbWxS?=
 =?utf-8?B?ak1Ldmx6RG5rMElSNU5reWFQSk5NbWN5TkpjODZqSkd4N2FqTUJxL3BiRlhp?=
 =?utf-8?B?RGdiaVlIem9vcGVnVm9UeDRuaTF2Q0xMcjR2UWF5V1hEY1doTmRIL2tIOUxT?=
 =?utf-8?B?OUo1ZGVjVExuUjM0dTU4MVB1QTlSZ0V6NytSNFRHNXNRM3dYeUZWMXBJVmdM?=
 =?utf-8?B?V3l1Ykh0M0wzbXg1bTVvYmswRHI4dXg5Wi9SRnNmNE11WXdvbkp0aEswNWNM?=
 =?utf-8?B?bFdmaVUzekw1VTBNam9ua0lPZlBFOVpOcFAyNkFOUzlWeldsNThhTTllVkZX?=
 =?utf-8?B?dVhNcEZJSHVpSXFuR3B4SVhSUGs4Z0dyV1BZYWJUemwyTWNyNVFqS0JKQUlX?=
 =?utf-8?B?SnlTbEYwUGJZT0IzNEExUEdWQ1V5WDNoNk1BRFAzZVdzZ09NWlY5MWtseVNI?=
 =?utf-8?B?OFVlVUNiTnhKSU9LenlrOGJOcklUL2YzTUlRQmE1TERJY3A3RzM0VXExNnYr?=
 =?utf-8?B?d0ErVkxIVkdFWFM0d05Bc2ZRU1cyUFZNbHh5VXhkWEFWWjB4WXV0YWhiR1NJ?=
 =?utf-8?B?NnZiRHAwdGlOelBhbUdLdVpPb3NUKzk5Wml4OHJnWitsOVFkcGp0eEpHYXh3?=
 =?utf-8?B?Y3gzRkhpQ2thNzJsZmhPcTZnOEJaL2RqVUhONDZNLzFmN2wvcm5HYWxYTU1M?=
 =?utf-8?B?Q1hXaG9nZEUrUDhrWFVxWTJpZ3huVXNhK21EL05qd3RRVGxHbkQyVmJlQ1Ar?=
 =?utf-8?B?c3R6b0hlTWFvOXlERHU3bWlybEx1b1RlSnZmYmxoY1pzYWhjRUZqK1paNUUx?=
 =?utf-8?B?UldmR0tYL2lsQ0FiMWFlUzlCNEowMWlwOXFPRm8vVkRESkl2VXZwSC93Zy9k?=
 =?utf-8?B?eHBFU1pEMDgrLzF0MTJqTUUrbloySStENUlUUkJFV2JmaVA2aWk5VjEyYWxW?=
 =?utf-8?B?ckRmL3NQRlR0M1lhRHZtTmpOOUlBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8fznxPGzTTj3okI4VfCbcn35ysl79PPLyPiCdXKJd02GhzjRVxZ7m+vd1Hlywn3d8oZKFY8DAMAXUWI9JXJ2oMhjQr+2slGqCAmNKCcpf+ebiw8UxxGp15M/JfFZHLtpnPT3HOXKcyVFPXwMCdhCrwrhGMuWe/lgwm3qaEfLHtMFU14X55Bs4inuJJy98FbbWvx0+aASyDyLGKxa1uZ27FuYQ/NoqB7/u+BfnzqGpbHTXyMycfkvDR5Ij1B7joU0Ot1Rjl22a5K4xtWtZftuwGh6+JqpbXCZcDdMJbVTudouMi0RsO1LFIqEgVB4yVanzR3lQh3x0fwSGnPd59AsMoWrtVNR54Z9od+azWnWA+MUBvA5dSvBHfa4i2v6hmXCuFd/5yYmkGhCO07KxFcSFV064jTEXlMrjryY+V5P+kWbwdqafwVNnLFlPrP2+VdQceE/TzPCBhbOnkLxVNeAf5ouDJ5gfbXbKmEbPcw+PqwmeQjvQVvmX3/NvEeCRSDByHPZX4Z9ghyJnCE9HZ+LaUYgnm5yWvOra9YB9uQ08YWpBBv4H9Y+NyZ2uQaX3ZsN5VfXpk5xWTY1/acsEdTg+bIPO8+zsAK1NPJe6mdgxWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730d440f-f52c-466a-98d5-08dcf91eab9b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4300.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 20:08:50.4138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfdEL4pSm7zrv1DhqlvHRtF/MAtrGpV7W+tLAgTSiOyXznHUS+Mt8Rwc07CTlDSerVmPakkPtD/2C0w8Q7VBG7WzPt5oFGSRWjFliKJFJjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_14,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300159
X-Proofpoint-GUID: kZ9y_B52TWllahCSH1vTwI7mHpieh-hJ
X-Proofpoint-ORIG-GUID: kZ9y_B52TWllahCSH1vTwI7mHpieh-hJ



On 10/30/24 4:03 PM, Mike Snitzer wrote:
> On Wed, Oct 30, 2024 at 03:51:44PM -0400, Anna Schumaker wrote:
>> Hi Mike,
>>
>> On 10/18/24 5:37 PM, Mike Snitzer wrote:
>>> On Fri, Oct 18, 2024 at 03:49:50PM -0400, Mike Snitzer wrote:
>>>> On Fri, Oct 18, 2024 at 03:39:13PM -0400, Jeff Layton wrote:
>>>>> On Fri, 2024-10-18 at 13:03 -0400, Mike Snitzer wrote:
>>>>>> Multi-threaded buffered reads to the same file exposed significant
>>>>>> inode spinlock contention in nfs_clear_invalid_mapping().
>>>>>>
>>>>>> Eliminate this spinlock contention by checking flags without locking,
>>>>>> instead using smp_rmb and smp_load_acquire accordingly, but then take
>>>>>> spinlock and double-check these inode flags.
>>>>>>
>>>>>> Also refactor nfs_set_cache_invalid() slightly to use
>>>>>> smp_store_release() to pair with nfs_clear_invalid_mapping()'s
>>>>>> smp_load_acquire().
>>>>>>
>>>>>> While this fix is beneficial for all multi-threaded buffered reads
>>>>>> issued by an NFS client, this issue was identified in the context of
>>>>>> surprisingly low LOCALIO performance with 4K multi-threaded buffered
>>>>>> read IO.  This fix dramatically speeds up LOCALIO performance:
>>>>>>
>>>>>> before: read: IOPS=1583k, BW=6182MiB/s (6482MB/s)(121GiB/20002msec)
>>>>>> after:  read: IOPS=3046k, BW=11.6GiB/s (12.5GB/s)(232GiB/20001msec)
>>>>>>
>>>>>> Fixes: 17dfeb911339 ("NFS: Fix races in nfs_revalidate_mapping")
>>>>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>>>>>> ---
>>>>>>  fs/nfs/inode.c | 19 ++++++++++++++-----
>>>>>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>>>>>> index 542c7d97b235..130d7226b12a 100644
>>>>>> --- a/fs/nfs/inode.c
>>>>>> +++ b/fs/nfs/inode.c
>>>>>> @@ -205,12 +205,14 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
>>>>>>  		nfs_fscache_invalidate(inode, 0);
>>>>>>  	flags &= ~NFS_INO_REVAL_FORCED;
>>>>>>  
>>>>>> -	nfsi->cache_validity |= flags;
>>>>>> +	if (inode->i_mapping->nrpages == 0)
>>>>>> +		flags &= ~NFS_INO_INVALID_DATA;
>>>>>>  
>>>>>> -	if (inode->i_mapping->nrpages == 0) {
>>>>>> -		nfsi->cache_validity &= ~NFS_INO_INVALID_DATA;
>>>>>> -		nfs_ooo_clear(nfsi);
>>>>>> -	} else if (nfsi->cache_validity & NFS_INO_INVALID_DATA) {
>>>>>> +	/* pairs with nfs_clear_invalid_mapping()'s smp_load_acquire() */
>>>>>> +	smp_store_release(&nfsi->cache_validity, flags);
>>>>>> +
>>>>>
>>
>> I'm having some issues with non-localio NFS after applying this patch:
>>
>> - cthon basic tests fail with NFS v3
>> - cthon general tests fail with NFS v4.1 and v4.2
>> - xfstests generic/080, generic/472, generic/615, and generic/633 fail with NFS v4.1 and v4.2
>> - xfstests generic/683, and generic/684 fail with NFS v4.2
>>
>> I think the problem is the call to smp_store_release(). It's overwriting nfsi->cache_validity
>> with the value of 'flags', losing anything set there but not in 'flags'. Could we instead do
>> something like:
>>    smp_store_release(&nfsi->cache_validity, nfsi->cache_validity | flags)
>> ?
>>
>> Anna
> 
> Hi,
> 
> v2 addressed this issue like Jeff suggested with:
> 
>>>>>
>>>>>     flags |= nfsi->cache_validity;
>>>>>     smp_store_release(&nfsi->cache_validity, flags);
>>>>
>>>> Ah good catch, sorry about that, will fix.
> 
> I think you must not be using v2?

Oops! It looks like `b4` grabbed v1 of the patch from the mailing list instead of v2.
> 
> https://lore.kernel.org/all/20241018211541.42705-1-snitzer@kernel.org/
> 
> Jeff also provided his Reviewed-by for v2.
> 
> If you are using v2 that'll be weird (because I'm not seeing any
> issues with xfstests, etc).

v2 does fix the issues I was seeing. Sorry about the noise!

Anna

> 
> Thanks,
> Mike


