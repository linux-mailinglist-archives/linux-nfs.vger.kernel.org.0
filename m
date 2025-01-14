Return-Path: <linux-nfs+bounces-9197-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0B6A109EA
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 15:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4AD3AADE8
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CE514658C;
	Tue, 14 Jan 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OIpIwMcC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DacD0MLv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1613D520
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2025 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866305; cv=fail; b=mP6k2bVrS8qo8BM8WpTFZ+u94TwG5qGaQZeMt1LCzQWm4Nf80ASMkTBlnHTzgkbinzFm+epuNTa9d7zdUbA1x2QAjF4TxOgpjBmgu/4TFkFKNbvgW9MefRZMQUJVUD4Cb8AdrGEMWQD4QUApQq5jj9kpEJpAIuQunpBPt26+CbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866305; c=relaxed/simple;
	bh=EvdwqBaE85MmiEDhBSzgAiks9Fd3IfoQYRpp7hT59YI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dzqjmUiUBCZTWeZG1SUJC16NyjButiFZvh/MCiPpyU8iz0ckDeMC5LkUgs+cH1HoBqz7rwIShyXFrafIyN81gRpQ3eMR76mZ+iTxateuN5MqdN6xW0PSxeRb6zB1wTU4W/44KVpRDuyztDfsoSuusjKkDawmfkklH6CXRrSCe48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OIpIwMcC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DacD0MLv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EC0ol3020932;
	Tue, 14 Jan 2025 14:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XO8eeeDNbcr7W4EK8N2M7Z+jM5sOBxXvVwYyRWy6pps=; b=
	OIpIwMcCxMs4KXF6EFMxR+m/gWGL8hsgXprMc+89tUJPRNYfGLjtrE+yXlzbhDIQ
	imwhuVVZLJo389SReOOUdyR1yMjIIXYuV2c9JGF5x4PB2abBS4mPHIzyRR63EUPj
	jl6qzHZ/+5W1nDzBJvOWNNm3uJJz5QXmsefkVvm99vUbuWAeBQyIOZe5Mgigq4uj
	VReiPpowAMvLMwLFCixuXaS3BgIUDBz0lUSxKse/7mbfnefx1mYH+r7nNpZdDEq1
	8ua8d5ctx/2vKxo57avm2Xfvi3xZG1avvr+uWBjut6e00WL5mm76NSmthvnNpaQ2
	9QJZ/xQCOri7Tga6OFDdOQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443h6swsq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 14:51:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50ED2G2L020261;
	Tue, 14 Jan 2025 14:51:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3eh6n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 14:51:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfchZmc+hFhm/38T2SRgAezUmlXlpNZlxwrlwCwBAQ5FKY5TJGYvMoUZ50Qf7GcJI5edqeFoWU98OapMt9CS3imyBSLowlQD8ukIG4parYO4lp/A4jCQLtRPkdkyx+qDD+p04FbDXpGzdXbB2C3Xr2NVBfABcb6yPOJ345NaGG4R66B9/FMqGDYW+GN/lc1P5/w/0axTsBnjjMH6wz/vZkVvPL8MQ0KRl2k8BZlrQ6NsE8jI46z3sIzaFwjA5MBWg39+ZzJpIzdMq6snhywV+/kwdV3bf2sbHpvjGFLhloV9pU7shh6SveqK/1p/1ZzGB/EAJr7+zgZ0mR+9Ne4IHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XO8eeeDNbcr7W4EK8N2M7Z+jM5sOBxXvVwYyRWy6pps=;
 b=pFKNFlDcsI2HHAdLVWwQimio3NSgYMWzj6AckPmZ+yE7+Yc3pHyP8XA5cs6vDt62dw5tpXtM+6sb3peanVbbWAZ0KLcz3EkAAv/+fit+CHos+Gp7Ya+uFVZfnoITFcg1eRW8DRxy1lJsDqZej5KCW4+IUHtq6ZTEbmQd6h2L+1b0ajmGie1lL9n+3qXQmz/9hzl2zYkqQfxcNDt8JRyISjFTvoPamsklO8wBLut7eYW09opxzdBSlDHDVmyBHUQtr5PDaqFp2jR+RgJO5mPxq/9hxfAaW6Sn8VqBOiMouwowR5zWf960izMRvEbQ6f5SbdlwuerxgiFFMwv+YS7bug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XO8eeeDNbcr7W4EK8N2M7Z+jM5sOBxXvVwYyRWy6pps=;
 b=DacD0MLv6Ur2zc7s8HWJohdvEpQGfl8jylRHFh86F/Zn2otEf20eh9MtXHhFqU82Y/1n8oBxrHad/0MCJ3QUIsAn0rKL0y31bQRkaukgDCP1p0mPJx1lWafbWpX1m4yfA7UGX/SZiN0srOgEUpW53BBOUGUGLM7ToiQHNxL8Auk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB6008.namprd10.prod.outlook.com (2603:10b6:208:3c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 14:51:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 14:51:24 +0000
Message-ID: <75633e31-53ae-4525-ae84-1400ae802359@oracle.com>
Date: Tue, 14 Jan 2025 09:51:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd4 laundromat_main hung tasks
To: Rik Theys <rik.theys@gmail.com>
Cc: Christian Herzog <herzog@phys.ethz.ch>,
        Salvatore Bonaccorso <carnil@debian.org>, linux-nfs@vger.kernel.org
References: <CAPwv0JnSQ=hsmUMy0VY-8k+dANBLNkJdFJ75q9EEE+Hj0XXB8A@mail.gmail.com>
 <d54d71f7-9bdb-49a4-8687-563558eca95e@oracle.com>
 <CAPwv0J=oKBnCia_mmhm-tYLPqw03jO=LxfUbShSyXFp-mKET5A@mail.gmail.com>
 <49654519-9166-4593-ac62-77400cebebb4@oracle.com>
 <CAPwv0J=ju3fZ8C_FFeDnzzKT-ppXaLCde64hQof3=g641Daudw@mail.gmail.com>
 <cbc55c4a-ac98-4121-b590-13f32a257d65@oracle.com>
 <CAPwv0JmA+29fujmmrugY0AFdtDDqjSvn6RTHzwYNR9a4skXfeQ@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAPwv0JmA+29fujmmrugY0AFdtDDqjSvn6RTHzwYNR9a4skXfeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:610:4e::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN0PR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 665244a2-7c2a-4ef4-eb84-08dd34aaea9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akEwcG1IRE93bHdSSSt4dmdsL3Zpd214K0RUSUFicEVpalJIczd5cTFtaXVo?=
 =?utf-8?B?QUhqL1BPekJuNlNjbmQ3YUZUK25PUzZ6QlpxQUhrck1aemtHR3dKeVNvS0pB?=
 =?utf-8?B?L1dORTZ6WHNZYUxTYWkxN1Ara3JSNVRqdHJVT29HUEFOQldLVDZNT3FXL1g1?=
 =?utf-8?B?Z1pPZUNkNkNIZkV0VE1nZ1ZzdU02QkJHUkRnd25BRjVlWE5YUVNmdFIycE5s?=
 =?utf-8?B?KzRFa0c4NEtQQUl0aTR6d2ozcWNKV1A0ZGlJQU4ySjJzMzZEbHI0dGlibXhT?=
 =?utf-8?B?ZFZ5dzR1eENPMHhJT01iVEdnaURjRVlITE5ieGxaNWUzRURQazdDYlpaUElm?=
 =?utf-8?B?akpVbTNIV1hwdFl1THhtUGcyeElRY09tWTkwQ3BudGs1NWplSkVVVUdPY2RQ?=
 =?utf-8?B?d0tUOW03aHNKWXJTOWloZkRoZHBlYUNvZnc5enVPc3RRSHhGcStXRjR4Nkow?=
 =?utf-8?B?R0p5WTFDRnpEWXgwS2k0QmplVnEzbUJGc0RiNGUvZnREcTJXY1pzYzNkVTND?=
 =?utf-8?B?OVF3cll4OXpGbEpYM1U2S3ZQWDdweFV1MUxDRWprSkh1TnBKR0MvVktyb2p5?=
 =?utf-8?B?NDhHV0I2Yy96NlNBRjRkZWZrK2YzeS8wM3paV2hITzJqZFF5anRsUVZzK2Ex?=
 =?utf-8?B?NXpXeHY0ZXZNeVNFQXo4VmdtaGpUNEFFVmtWdUNnMFVqMjZiQW9aOWNuNENz?=
 =?utf-8?B?WDZLRy8zcDhYczJMRGIvUXg3bGt4V05tUC9KSEZHV2lqQjNJTXRrQkJXSkpQ?=
 =?utf-8?B?ZzB4aGptTlBkZzlkVFJxenhTMVB5YUFybDgwQ2ZpRkY0U1NCbUF1bEZkVnRZ?=
 =?utf-8?B?V08zU1F0WTd2OGFVbXpGRTFraGFHbG5tallFdDRRQUxsbVh2c0xCM3lhYzNl?=
 =?utf-8?B?SkdWTWxoQjRUaElUNFFMbDNUSnF0K1cxc2pnQ0pVeERSUGRsdjZmWk5CcU9F?=
 =?utf-8?B?c05pWTFFdFhpekhnVldRVE5ENGlISFVTSlRSMzRURHRTdC9YYjRxSWRiQUZi?=
 =?utf-8?B?TWhWZDN4TmdPdGE0QWdBc2lmWlhKR0oyeFliSXFxYkNtOEptRHlKQUIzcFhH?=
 =?utf-8?B?ckpIMmhmdHBYWWhKa0RzdWVuV3JvdEZDVy9ha2lXUVcwdm12WE1oRU9USjdr?=
 =?utf-8?B?SzFPeHZXOVBqajQ0dnFSeUpkNm1BWXZZYTBNc0kzZENwMVdScjF4TUdYZmJq?=
 =?utf-8?B?dE1ReUx2aHYwTVhJQ0FqNkd0SlZyMDZWTXQyVzVkUEp2TDJQUFNZSUtObURX?=
 =?utf-8?B?SDBmMzhDOW1wTkthakJHRUJUckhoUUZ6NjA2REllWWorajlIYi9OVi9nM3px?=
 =?utf-8?B?Y3ByMDRyRzFVOUdtcEY5NVM2Z3hkcVcveXc2ajV1QzlNNmpvWWx5QUhGdGZk?=
 =?utf-8?B?SEZ6QnFjQkVwRzVFQ0IvajRValY5ME5KYjNLaFdGUVBsMStpRmJEeXQwczJr?=
 =?utf-8?B?aFUwN2lDSjR6cnNyeGNLOUdxOExJeWtHclRqUG44MUVYNXh1b0VSd0d4RTVo?=
 =?utf-8?B?eTduNmQ1T29tcVllbXVqNnZORVFnMnlIWGE0amJQUHBxUnorYzZmZlQxV2Uz?=
 =?utf-8?B?MUNZQzArN1A2VFlWYzR4ckJtbDM1V0w1NVZrdlR5NWdxeTlNVm16R1NOUHhR?=
 =?utf-8?B?YW9TVWNCbzVOWERub2Y4OGF3R2VScDV0bVR5WmFUdFdkbWtheTVuY0NOYU9t?=
 =?utf-8?B?Z0tHU05RM1k5OTVXSzh4eUpMQW1KTGlkV04yRXBWZGtZU2Y0UmNKeHRsb0VW?=
 =?utf-8?B?K3dlbXg2SGxlNTUvRGdSVHRkWFZ3bktCeFlJamN5b3VObVBjZkJBekI5ai9a?=
 =?utf-8?B?RGU4bnFjSTJtVUk3Yk1Odz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFErT01qdUU4cUlxOFA1cFdZWVppUDhqczFBZHpxZGo5VG9sdm5LY1Rtem1k?=
 =?utf-8?B?RkQwY2dKMW5aZWR5dlJLN0QvUVMvV0h3VGhHMWtaemFMVFJ5bVFzaGxqa21M?=
 =?utf-8?B?Q0NKMG9ZOG8yZ3R6OFpjeWdnS0VLRGNLTVljaE5NNFRCZ2x6TGNoclVHeHJy?=
 =?utf-8?B?UUNFbXMwejhkb0hZZGFhODhYdi9rMTRvdmNtK2pCZjNzSWV0bjlqSVpYaG1R?=
 =?utf-8?B?SG1hVXlBcWxKTStlcGZLZ0Q2UEhKSDVYRXZ4SWYzeWZLdDBuOXBvUlpsc1Vm?=
 =?utf-8?B?ZkQvVmVBclk5d3FhQk5SVmppNTZidlpSRmJ3bjlaM0YveUhlSkZsUFE0ZDNZ?=
 =?utf-8?B?ZzRVR1NDUDNsZmNCY1FPbFlNOU1nNnBWWkZkNC9kYXJGWFVVYlFxUXM0WUtM?=
 =?utf-8?B?dHNTNnlDODRYSVpBWGh5cmFLMEpVaXQ2Qkxvd2daSGJOWk1xY29KbWV5R3Q5?=
 =?utf-8?B?b2dqR29aa01zaWhMODZNYS9IUWVvUWRMenR4aVVVblIwVWZnMVI5OTQ4K296?=
 =?utf-8?B?bGM3NlE4TzY3M0dEK3h1cDBrSC9sSnh2K0x6Sk5LM3FsT09EMmtXejdQaUZS?=
 =?utf-8?B?Y2NIRWJpWVVXbGY1dDZ1R0JhcUN2c2swUHZCcVpyQ2YwVkx1TTZJdXk2QTMz?=
 =?utf-8?B?dlE4b0F3ZGRvNmNUeTJJd2NwU21DNU1VYWpreGo4aU5MUkxuVnlvbWJHN3Ru?=
 =?utf-8?B?Q0s3bHowWXlvZEdJSnQrYzMydWw1TmszbWVuQnBZaHVrbHNVdWpiTVFuanVX?=
 =?utf-8?B?Y1IxczN1OG84OURDMUVsL1V5a1A4a2tGdkxxSFZwRnZmN1VienBzNHBuZmhT?=
 =?utf-8?B?ZjRGRzFpd2NucXFiLzNtelFsdzBYMTZRc2VQRmVrZHh0QVkvbjNOZ1UwYnl4?=
 =?utf-8?B?Q0IrMm9hcm4yYlNiUGI1aEEwOGptRkFNRDdYQXFqUy9MMjhaVGx0aEJZOERs?=
 =?utf-8?B?YTlzdTNONTRtZnhiRVRHdFJZME9ZRGowRk54ZHIvZ0RxMWRGZTgvRXVvN0dr?=
 =?utf-8?B?bDBPSlF2Qm9IVDRSbHVqeHVxbTRIRXJNWG8zcE9rNkRIMlNVb05BV3FrL3ds?=
 =?utf-8?B?K1Z3UzU0MlpZdW1zZDU4Ry9tS2c4M0RWd1lObTFYc0RLNkxqK2tBQytZMGQy?=
 =?utf-8?B?anZMWHhOY056cDRKdGh5Zm1rQlNTdm5sL25hcFBFRjlHRUNOTHpJVkNMblgz?=
 =?utf-8?B?Mmw0L3Znb08xc2wzb0ZDSVZvb0xVc3JoYWh2NEpOWXdIMGpLdHB1NDVxTG9I?=
 =?utf-8?B?RTRhc1hqbzFqeDVmUUtESHFXdVJ6aFdrOWh1NWFGL3hzQUVZdTFtTGNJNkdu?=
 =?utf-8?B?U0RYTVFnSjdWc2dXV2tPT3BzSUlhWEhGS0NlWmFRd3BFV2VMNXZzNERyZDZR?=
 =?utf-8?B?cE4rYzh2eHBkKys1KzJudzZLTCtRSzljR0V0cXVWWWx3WW9wNHp4V0d4Umt4?=
 =?utf-8?B?ZzRuZWJ0VU1LaEdxbm9QdkltQVBXRnllK0crM1gxTXc4WHI0N0xHOHJDNmpJ?=
 =?utf-8?B?cWhoUGQrdmRyc0dpakM5cW5wbFJlT1VaSXlPcW8vSVR2alg1SXJtbmhTUGl0?=
 =?utf-8?B?QVlXSmd3MTNZQVdvNFZFdWFmWHBaRjFkclh2VTcrb0hyendLQTYvWm9iZElv?=
 =?utf-8?B?K21DSmZQcnVvTXZCNUxlekZlRmkwMG1zVE1LaWR0YzF0OXhxam0yd3pVaS9y?=
 =?utf-8?B?bm9Zb0JOR05TMktzZm5WS1lQUklDWHdkTWo0V0w3dUNWSUdCcE01WnRGZ3ds?=
 =?utf-8?B?cTVqN0YxcGNvVnVNRXlZTVd4bnp3SmVudTdZYzErMlc4ODlkUjA2clc4Nndv?=
 =?utf-8?B?ZitJN013YUNVR0xqMDZSKzRmZmZIWElWYi8xdkgrYmRBd0U4ZUdsK0VhR0c5?=
 =?utf-8?B?Wm5VSTNTRm1aYXVycFNXMk1xYW9TRUpOcWtENjMwQjZkWjlaa0I3WVYrbHFt?=
 =?utf-8?B?VjliNy92b2MrdDZGZlV3MWxrUFhqRU4xM1lud3lkQjdKTVVnRkcxbWdZTVg0?=
 =?utf-8?B?Nm1ibGN2VGRkaTZDS1ZhY044THBBRW94TmJyRmtNVVBYS0JyczFNSVhCakVB?=
 =?utf-8?B?V3lXQkJmc2N1NjlHOVd2S3RzVjR4TUpSUnpxT3liSXU4eGU0Q1JDVEVlMUZP?=
 =?utf-8?Q?WZz8U8TDbgMRKONBLbA1s+CSL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q5z79MphRKZsUiQTbMvNq+nPWgj95qMrRMyxTsMkaFF53uiuQRRE2pJcGGsiYtCeaO1oZS12iLAJv8oM4TgbooSM4v9ziHtquVtj8zzk74L6FggKrdNyLnZwKKT7MJ21AWg2MhsZycQ1O36R3vncYg0HqO3sFJoUN255HUHeZ3tO0ZsAmPECu9FJ+PvsZapOAd14BrBEPFiyi7c7Mx5s/GWdBsKmdh3aUU7qL0juQ1fuuQ0jEedw/3ZXGF1pOzEdopsumgvE+mcykEUrBZdkTu86ovU3eQUbcG3CJK6fv3hDMJEtIU31yKhuZW5gWG1+5G5dck5Ze6sppAdOCE3tYMq3y8J92apmRL4rN4Wq+EL/6zxxmzcpGNH8jNhwBPuEBGS5HFTvOwjwRBmH+sVcbz3MrEXEUbbUq4cuQPf2EVt8hKxUFi52OnVvJXgLmGMWBJQznWsGGlilbWljslsUkxRgAJpLIX6eADiwatvB8WPFU+kEq69JaJ+v38RGh8/yyU8x0L28F9KaPS8OW/rHbx1y1VWUtG28X1O3oFyX+OlIWz+rBEW2lLg1McrDZSmFcj1RcsaSitGbEETRim9lgxOpQPZyzppTWShLjWM7BL0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665244a2-7c2a-4ef4-eb84-08dd34aaea9d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 14:51:24.3755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMsGcmKNeBqEenwypiPMH057aaD7S25b1GpsJF9PdDdzP8d9klFHgzvZ4yLTfL3J5LPCSEKFZYUd9zKq7bu6cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_04,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140117
X-Proofpoint-GUID: iXx9MPvIKm37CYE4-r9mFraKNe2TY-Ha
X-Proofpoint-ORIG-GUID: iXx9MPvIKm37CYE4-r9mFraKNe2TY-Ha

On 1/14/25 3:23 AM, Rik Theys wrote:
> Hi,
> 
> On Mon, Jan 13, 2025 at 11:12 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 1/12/25 7:42 AM, Rik Theys wrote:
>>> On Fri, Jan 10, 2025 at 11:07 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> On 1/10/25 3:51 PM, Rik Theys wrote:
>>>>> Are there any debugging commands we can run once the issue happens
>>>>> that can help to determine the cause of this issue?
>>>>
>>>> Once the issue happens, the precipitating bug has already done its
>>>> damage, so at that point it is too late.
>>
>> I've studied the code and bug reports a bit. I see one intriguing
>> mention in comment #5:
>>
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562#5
>>
>> /proc/130/stack:
>> [<0>] rpc_shutdown_client+0xf2/0x150 [sunrpc]
>> [<0>] nfsd4_process_cb_update+0x4c/0x270 [nfsd]
>> [<0>] nfsd4_run_cb_work+0x9f/0x150 [nfsd]
>> [<0>] process_one_work+0x1c7/0x380
>> [<0>] worker_thread+0x4d/0x380
>> [<0>] kthread+0xda/0x100
>> [<0>] ret_from_fork+0x22/0x30
>>
>> This tells me that the active item on the callback_wq is waiting for the
>> backchannel RPC client to shut down. This is probably the proximal cause
>> of the callback workqueue stall.
>>
>> rpc_shutdown_client() is waiting for the client's cl_tasks to become
>> empty. Typically this is a short wait. But here, there's one or more RPC
>> requests that are not completing.
>>
>> Please issue these two commands on your server once it gets into the
>> hung state:
>>
>> # rpcdebug -m rpc -c
>> # echo t > /proc/sysrq-trigger
> 
> There were no rpcdebug entries configured, so I don't think the first
> command did much.
> 
> You can find the output from the second command in attach.

I don't see any output for "echo t > /proc/sysrq-trigger" here. What I
do see is a large number of OOM-killer notices. So, your server is out
of memory. But I think this is due to a memory leak bug, probably this
one:

    https://bugzilla.kernel.org/show_bug.cgi?id=219535

So that explains the source of the frequent deleg_reaper() calls on your
system; it's the shrinker. (Note these calls are not the actual problem.
The real bug is somewhere in the callback code, but frequent callbacks
are making it easy to hit the callback bug).

Please try again, but wait until you see "INFO: task nfsd:XXXX blocked 
for more than 120 seconds." in the journal before issuing the rpcdebug
and "echo t" commands.


> Regards,
> Rik
> 
>>
>> Then gift-wrap the server's system journal and send it to me. I need to
>> see only the output from these two commands, so if you want to
>> anonymize the journal and truncate it to just the day of the failure,
>> I think that should be fine.
>>
>>
>> --
>> Chuck Lever
> 
> 
> 


-- 
Chuck Lever

