Return-Path: <linux-nfs+bounces-16554-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC5CC6F7AF
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 15:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 3E64B31137
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 14:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D17365A16;
	Wed, 19 Nov 2025 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bj54bze7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mK4ILuIY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770732D0ED
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563790; cv=fail; b=CSIz/dUxp+xeYCbFps82LT0WGOTp3tXttj0alE8ExMwxWAU/B8Bm9i2RSrmxF4ny3DqltBpIpOKeNSkyovN0xTybBlrlkQAYhdMSWSaiqdAOteTfmccvUmjpEzzdKGI2as/wLdsFeVrUUsmEAabqOnZUq33wk5/0tACEpJbkmds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563790; c=relaxed/simple;
	bh=fM9av7RBhdt47s5511Cfk8gzd8iZ/8YBbAK6+pZkBQo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DU/ruHQHGhnZ3U9QM8XbJOOmjyE0Z9r5V/089K0327ehlKTO0HAJPQ+4jzCFESarTouHw7BgTUO8i7ydnTTIKRlamTt8edt/TyVPG83vzSEdeVSZOSKi9g+xlZ8KpP9cJqz77lhQoN0ymz0uN3e2+KRxidH7rwot1auWttf12uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bj54bze7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mK4ILuIY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEg0PH022768;
	Wed, 19 Nov 2025 14:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=y9QKYDapmSAFB+3QzrdoYh7M7/rxGK4QvuIxSL8NS9M=; b=
	bj54bze7ZDTJURiQ8DZoRNNoZnCOzBbL6AWF/CSXMdxNKjh098zqR+R15yiIOrVr
	zqytMhISAtNJ0SYdch64C4XwqqQYcTbJaWy9gM+LyfKmeDC10zjs5owLYMKKPcwJ
	H+07uqPwAdMlEKrP+EQ6I/hd2tfM8VVJ/BTnEMIOz/2y4Pojipax5YGL9w733m0c
	J7aqe8nquu+r6W/MF4/N/Vb/FtnuBKWJ4ziPAthmGuwtab2hskKDc4NUbGGOrMna
	xImanEIhN3H1V4i+Sip7fhgMkaxfLH97pY0PcmhLUPk3ZaNVy9jjVjoVlZZQf3aM
	GnL38lQrrn9O8/BVaI/W5A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejd1f39t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 14:49:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEcntQ009691;
	Wed, 19 Nov 2025 14:49:23 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyer2j8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 14:49:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2x+dxwjcC4hbpxl1Owk9EpVjea1j6Wzz6G0tJ8Y0difnb6AeX0/XFKPbmpRb2RNli2pbJRlFstlrETO3RkAb7zt3UOj6G/5DZPbGIVKArvmeB7B3R7QwAX7x80kpiOlWSuhs9DWdXwHpTEEu41ty7pQMrvB/djZ8ivB6/qibcNOFbZ7Edhy5rgQUtMUQ/dg95yy1/Rn8WHPCFxccIC6axZFDJZRvbTpNItzr3eUNRF9I8hAk2bo7Zs8T+C8ThFYywa7uvHPYZU6iruBl5yL5huESMRk1/Da99amPJPXoE0s0aCTpO2zd6A6AYtahTPTOEdaedDtzXu1nUIOt9iXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9QKYDapmSAFB+3QzrdoYh7M7/rxGK4QvuIxSL8NS9M=;
 b=fdjFiyKFV56WtyMacELOJ3fZ+aMXT/u6ePLmA3V9mRb9/sU6qNJKx1I5xgkPnallhSfBoz7S66NXbzo3wVXUP1c4XzTqU/Q05TiTziStOlrv/zby876kwHThTXdZbLQvcLJIfaj9TwTG5AHObPllgnX63doxT9/rbr+ox2LndiEiLL9VA2GlWjEK4Ouhii3dmspV543Hxl80VUrSXyWP2p2eWswCT3pVQz0cHM/Z4pQWY1PNR7Xx7TRHYoT/PQRH1JlECH5SwR/KM2xJYcBdMdIzi+E4I1XhQ9PAM0LyWrO0BMc9I4z9DF3mgdR/g3xKm6Q9vGDnu26c9+GXZoxzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9QKYDapmSAFB+3QzrdoYh7M7/rxGK4QvuIxSL8NS9M=;
 b=mK4ILuIYMRw4GmF3wrkLE3K5Nm85sITKkWzFmK4ewz4n0dTaKzCDzohIwaULYFEmRHT5m6iSReMDN5YhEQEipCd6VndiOFoGq/DsACVo0Qsp2rhpu2CnHuX0oK6yvVovP5O9zZeKD2FBfpfVmalWkuJZP7u6eWRVA/YEdoc8Ggw=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 14:49:18 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 14:49:16 +0000
Message-ID: <d1bc454f-bb51-4892-a8ae-bcef9bf23aa1@oracle.com>
Date: Wed, 19 Nov 2025 09:49:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockd: fix vfs_lock_test() calls
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
References: <176351137459.634289.99556130353777712@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <176351137459.634289.99556130353777712@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0011.namprd14.prod.outlook.com
 (2603:10b6:610:60::21) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb689d5-f2ec-4c2b-d041-08de277ad017
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Vk1TTTU1Tk1ab3hjclJydlhNZXNDa0lFU2hvQ1hyVEVwamVUSFlKRVoyTDRi?=
 =?utf-8?B?aWE2UUJVVm5aS29nQXNvVjlZRG13SHZaeTJqSUhYY2xVRnA1alJzVTQvM2wr?=
 =?utf-8?B?NURoN2FBR1NSbEN1TitTRTh6Q3J6ZnFORENka1JlMkFjbTh3aUFIT2FlMVBh?=
 =?utf-8?B?ZkRXbjdmQXJlQ1NFU0YxU2NGajJOVkJKbFhYSHNoNmVkYUtVREZzcUhobmVU?=
 =?utf-8?B?LzUzZElkN1pnbkNFSlNuSDhQa0NEdjYxWHIxV3Z2Ni9yTlpyaHl6NDgwL2Rn?=
 =?utf-8?B?ME9jYSsyWDVHR3hpTmpLR215Z2JMcm5PbU5OUUo0N3A5TWJZU2k0N3hZaStZ?=
 =?utf-8?B?OHdHbnN6RFlQVHBzUU53bmtwc05JK002a2t6ckxleFpzSVBXK3h1aHVTc2Jj?=
 =?utf-8?B?NzUrNzVoVGgzZnZ6bVR1eUFML3RLUVBJRlRJQUVGTVQ0WEF5ZHByc2Z6aVRs?=
 =?utf-8?B?VjEvU3pPUkdFeWlmS2N1bzNIT0JSbWlUcWlCaTZta08wUVlDSHZ4WVo5NjYw?=
 =?utf-8?B?dWVMYlQ5M2FlSjhTQ2Q0ZytBK0tHakhjZ1pOUlcyZmlFVzY3dUxIMDRvQnhH?=
 =?utf-8?B?cFcxODluYWNMa2N3ZCtCTTcrNDZMZzJqSW4rTXo0UktLMnZKZ25RNzQyaFZX?=
 =?utf-8?B?UmxLSk1qQmgzOHRsZ2x6SDgxOVhZOFRYUG90Vnk3em9WWWN5OVRRYWtKMG03?=
 =?utf-8?B?WDZiZjZSOWJsTHdVTkx0OW1OWlBVSkFwNnM5eVRYM3g5KzIzOTdVSURDVUd2?=
 =?utf-8?B?Y1VvdldpSzhhU1JkTy9TUmhXTWlnSkRtT2xMaHJUR1dDY0crZVlsUzE1R3pD?=
 =?utf-8?B?anpiZjFkbkx4NDRBTGJoSmp5ZHNUM0dQRzhPOW9Ea0ZCd3JsbzF5SWhwY1NK?=
 =?utf-8?B?Y0puM2hRTTlBTkZkUzhERjNDWkZlQ1duSTdoN25jdFcvQWhram00cU9UZmQ0?=
 =?utf-8?B?RkVHQnZhY2R1L05EaFVPVkV3ZE5iZ2hGMnVoR1FMMUdYWm1NMlduSUtZdlpu?=
 =?utf-8?B?SUU2TFVSdURud0k2RVpRV1M3cENOZ2pNRzQvSklnYzZFSWRxWk85YkxXaWlK?=
 =?utf-8?B?NGc1bisvdENrQThaVCt0cjhJQ09pRnIzenlZQTV1dnM5Q1QwRnFWNGNMQTNK?=
 =?utf-8?B?NFc3ckZpS2cwVXozNmJkZFVaMDNYVGJhaGY1QktaYkV6TElHZjNla0xFa1F0?=
 =?utf-8?B?NVFJeTcxWlozeVBpa095TjRhMG9YR3VYOHFjbTMydUR1c1FIVHErV3ZDdkNu?=
 =?utf-8?B?cXR0cFJDZ0QwZU5FV0VmRkc0dEhiL3lhYkwvR1pNYW1uVXQvTFhKS2VNaTN4?=
 =?utf-8?B?STJEeTFlL1F2ZXZ3b3pzNzByZW1xMXhSMlVqamRIWG9ZM0RFQXBpZWNyNHE3?=
 =?utf-8?B?VUl3eDE1Y0Zad2lZU1pFd1F0cEV1MmRQS01hUzFNazZHNGV3eFVJVUNNZllh?=
 =?utf-8?B?STFpdHZMTVVtTXdjbVl6QXFSMTRrdTU2TkJhazhVVUZFZm16dmU4a3M3OHhY?=
 =?utf-8?B?dU1jVlNiQWpPeG1QZDNRWTFrMm93Ujk4UURBbC9ER05ndFVIRW1BTWNyNGlY?=
 =?utf-8?B?UWZYOVFVN0hCZ0w3aGF3TUNWSEFpTVVqSG04NVdoS0puUWxpMVBySTd1am5r?=
 =?utf-8?B?Vk9BQkRiSVRWNHNWbG9jZXlFL0RjRHFVTzJRc0xVNWVIMlYzWGVvZmdXRzll?=
 =?utf-8?B?Ymszc2VwdnAyUHNqZ0prK29PUHFyay9pYk56NnMyVENCbjNlWjNWdktrdlNy?=
 =?utf-8?B?QXNaV1AwNVV0QzBrblpleTkzOW9CbVNIRjRISXVnS2pCbEZHL2dqRTlncTRz?=
 =?utf-8?B?UmFVK1VubEp1SG5BSStIS2IrL3B0eGsyaTc2eFBVZXdJMkdsNmJUd0NMTGpI?=
 =?utf-8?B?dEk3SUtJQWltbmwzV1lkeG1WS0gyZ3FKTmszK0FNU2RwWkNuTGJ4b1c0dmxo?=
 =?utf-8?Q?gf6P0ILcfWU4EAiXAkicGo3ZQu3AWc0g?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eG1UcTdxa04vcHhWRDMwTEQ5UnpsUE90Zm9KVjFqZnZMYkNPQlFyaURTWXQv?=
 =?utf-8?B?bVdHZTdBTGs0cDhpZUR4VGIyRk9wWUovcDgyeWdzS1FuNXZSSkk5NStBSGgr?=
 =?utf-8?B?QksycjZPYWdZbW92amZWMlFMME5TOVRhbFVPc3RxRU1LYUk2TUpVRVZlTkxU?=
 =?utf-8?B?NnRqaHoxbWpNZHM2c2NsSEZqa0RVM0Y2Zm5nb2MyQnlTdE1LM2tKZUZneThZ?=
 =?utf-8?B?eVZDWUptZ0pLVlE3czRXV0xuc0VRclVlZVFhbko3T2ZJczFQTUl6YmptclRy?=
 =?utf-8?B?NHVFajYvVWpoN3pNcE41TVFzMWY2eFAxRFZuYWZLbVloN0trVkk5U3FqMHhh?=
 =?utf-8?B?MDlKT0x3cEl4dWVLa2k1ZDIrK0NrUVN3QXQwN01mYnI1V0d4ZENGZCtKK2dt?=
 =?utf-8?B?ekJUK28yZWRITXdHNlR6YzRuT21Va044b2VJMHBtYmJINmxkYlpkdlZlMHZr?=
 =?utf-8?B?TklFV3Z6SXpaYmhYOXlHRy94Z2FoZkZGSEZXVFZKUGNOcTR1TEtKZlZPREJR?=
 =?utf-8?B?SFF3MXNRcHF3YmtCS1U5OE1ibGpYb2Q5UXpsVXQvTzNWc25JUG1ZcDNrU2g2?=
 =?utf-8?B?TFJLaXU0NkNnTDdRVkh3RWVNVjBUT2dweGJIUzNERXliTVRETE9oT3lMVTdo?=
 =?utf-8?B?UVBsVjNJemVlc01qRXBCZWxjUkdNQUlFNXE1QTRHRUlKbGQ4MHJCVWRHNko1?=
 =?utf-8?B?YytTOFNVRnczeloveXA5MGdYcHR5WTFodlpBS0g4OUtLRW8xZDNGN3dwQmFn?=
 =?utf-8?B?SWRPWFBkTWQ2a1NGVVNuUGd1clVBYnNzd3VSQ21GeDBobjFlSkpveDluV2VI?=
 =?utf-8?B?cXkvZTZiN1pEVFAwdHdjNkdMMXlWVlpXRFRoSzV3SWJ4SHdDWm9BVXZCQ2ZV?=
 =?utf-8?B?d1lnNU1IZ251TzN3NkVSVzB1aWJqaDgyWWJ3TWxMMGlTVnhpd3F3VUtvQlJU?=
 =?utf-8?B?aTlKK2JEVVZycG1KVHdzUUkyL3ZNeVlTMzF6Z2hMYVQ3cC9KV3o1VDFuUEs1?=
 =?utf-8?B?ZFdRQUJpYTVCV3VUWnBLa3NiZ0RZRThObzZUWFFpUVk5ek14ak83dml1b1ky?=
 =?utf-8?B?bys1dzFvVFZGaVd5TjdqeXVBSHdqZkhOVEdjTTVCNFR1clJJaTBxM09uQlRk?=
 =?utf-8?B?ZW90MzM5b2xLK2FWbzZDUU9rdWNMQWMzL0ZSWVBDQmw0cEFZUGJhR1V4c0Ju?=
 =?utf-8?B?a1MvUkVVRkoraGxOQlpUZzM2bjZPbnRicHloOTB1bTFMbXorOFZZdVlsSmtI?=
 =?utf-8?B?WG8rZHJSNVlIWGZMNGhMV0FRdS9zSHVIQmVFMnJSdlU4Tis1cEtua2RqVU5a?=
 =?utf-8?B?UWJ5QktQN3JtM0x0WUFIcExpV01LZUlZWCtQRUV3SVdmQTR2eU1salp2dG5u?=
 =?utf-8?B?TklNTnpoT2F1WXlXd1FTTE9vWVRHQ09HVTk2WVgxR1N5dUdrUTVkRHNFbDdV?=
 =?utf-8?B?TVJ1RWcrRDd3QjJTdHg3amhyYkx4WXYzUmdQeTNXTTZUUGZWdkNaaWt5NVZL?=
 =?utf-8?B?SlJHUWwyRTl4QmFVdEhZYjVmTTg5S1NNSElpanAvVjBxSDU1V25lZktqVDBW?=
 =?utf-8?B?M0YxNzFtU1RPOFBzekpQZmRheHR2N25Xb2ZSMzJsdWdXeWdZMzNLZHlEWGVF?=
 =?utf-8?B?ZUR1ajlMQW81SUhEWlFObDFmaGVscy82SXBJVmVtbTg1UXJyZURIM0c3R01m?=
 =?utf-8?B?QTEvYzhVeGs2am9BN3RMa3RVZ3AzQStmTHorRjNXTU9FdkdwM2E2dkxlUFll?=
 =?utf-8?B?MWVERTNVc1FpVFpUTmlWK2E5SW5pYjlXOWgrVTN0NkpCODdCc2l2OFRhZDZ1?=
 =?utf-8?B?TjQ2UlU2dTRDMkNOZklDVW10d3hJVmhnYXdxQzM1cG1pbHd2TFByektaMTlZ?=
 =?utf-8?B?WDB3Z3RidUxXWTZmRDJlTDV1U1grOGdHWUpjamNTVWVMdlBrYi9CSFVjbnMy?=
 =?utf-8?B?RGdFcXpRNlFhQSs3T2J4RUJxeFIvSFdoT1l5MDZYVW5YZGN4RTVBOXVVcFJM?=
 =?utf-8?B?OWV5UUptUFRoa2VKdjFJbmZMNEFPWWgzTVJpb2NjVnV4eEJ5SUMzcnRKMGth?=
 =?utf-8?B?dzhYQk4vRTZGL1pDSk9aelBPc3NQSCt1VWNLRzJRRHRBcjNXUFlFa2JrWllT?=
 =?utf-8?B?RS9xU3B5OFp4dHVkeG9oUjNocERJR1d4c0pkOUg1ZXhpcnBCaDkzSzByNmdz?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BSqcjbi5Tk8WEtG4lZ+CH0JytR4aVi9KMjM1u3O+rx2aEzR2nb6Q+lBzAIZmMAKkBwRTq9v5WkUsd3tvQEv+wxPau4+yMAeckrLmbSracxkXV5gUeQBwVv4+TvhM771uiZRzbOsPh0RhyGpjEmwsqVl/veRP5JZlewQK0gH6cSy9IbrzqqxRIdH6pTh0LVlfOooxgkZ8XZIR4VCaV92wcjHDaFH+FpZdII5gPls1jeck9pWGrgZsFjlNoEK7Qy4LYo7TOogoqJeAsUdsVWbB+LBRri5mPafz/HMiZe2ENCaPSYVIRit34oqgyJ1BMszuhpDmxBqD1ozRTDluHRAkvcHD4zvoubrArnSuhDNNKSheu3s7Qwr20muWVF7Cyr5U3NbRUT3DyUhoI9+3mHL+/vbjsWrMXiElCrx4EUDan23dFfC8CZnajq2/s3EgPOVuvYl35rNkDpDlfFVTMYzspWLmFVaCDAnQ+LcU6iB6IKpps+PdzVmAlPiAX5xHM2kNlALejg3cbfWPWGiL0HbvgTUoGdZrhAzdVlYwIypaDDR25f16Ygw+VRsa4sqpDoMDfQWz/AMxvws+vD94svhGZTSM9mw4B1S/5OWiYTcWl4M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb689d5-f2ec-4c2b-d041-08de277ad017
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 14:49:16.5754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6i7DnuucVrKrYDSwFffDEH2vJqGeQGjnOK96yfAIqgsPEnQlh8NeIKD4AcR8bygXActnvirPltTHwL87x0FIFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190118
X-Proofpoint-GUID: vtbHJVyE9qWVzlzLyFY8OMNCUKyxjRE2
X-Authority-Analysis: v=2.4 cv=Z/jh3XRA c=1 sm=1 tr=0 ts=691dd8f5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RUyqAx4qIIQun9qSod0A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13643
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX0n04XnlQBfqK
 u0TUnYLPNXpv+QmhBsUC2BHAeGC87Kz14mvGLKDclhAIWSmdQsTpA/UrPevw8jRvcWZ3QuTKRHZ
 nOsZfWvjnzZyQJr8hb8ENTOQmNm+as5JS7fC08mdA94Hb/M0bNRJVu1S7xFgapdQ5Yg7RCIXFr0
 m7OqM8wMgG+orpVMo5iqWFzuMk0d7ipgG0NCifiGEKNZ0GK9u6v42nhWtt3GRyZwCU2NGcYT76k
 uxcHm9tZY/CUIBs8GfglisTA1XY7vv+JCia85bw3Kkb31QhiuWS2INfrMiaBrSrhO2EcsAQPcln
 eqCkd2KwYzs5GXMsTILiBz/Gr4BXR2+kta3/LTlnWuXez1yEd9oqevvKzaJjLu8FhcRgi5nfuEW
 pKvBCB/IjSN3E3/AmZyyFJTWjrCDAkK7HwHOR2MEKO/marXe4tM=
X-Proofpoint-ORIG-GUID: vtbHJVyE9qWVzlzLyFY8OMNCUKyxjRE2

On 11/18/25 7:16 PM, NeilBrown wrote:
> Usage of vfs_lock_test() is somewhat confused.  Documentation suggests
> it is given a "lock" but this is not the case.  It is given a struct
> file_lock which contains some details of the sort of lock it should be
> looking for.
> 
> In particular passing a "file_lock" containing fl_lmops or fl_ops is
> meaningless and possibly confusing.
> 
> This is particularly problematic in lockd.  nlmsvc_testlock() receives
> an initialised "file_lock" from xdr-decode, including manager ops etc.
> It them mistakenly passes this to vfs_test_lock() which might replace

s/them/then


> the owner and the ops.  This can lead to confusion when freeing the
> lock.
> 
> The primary role of the 'struct file_lock' is to report a conflicting
> lock that was found, so it makes more sense for nlmsvc_testlock() to
> pass "conflock", which it used for returning the conflicting lock.

s/it/is


> With this change, freeing of the lock is not confused and code in
> __nlm4svc_proc_test() and __nlmsvc_proc_test() can be simplified.
> 
> Documentation for vfs_test_lock() is improved to reflect its real
> purpose, and a WARN_ON_ONCE() is added to avoid a similar problem in the
> future.


> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index a31dc9588eb8..381b837a8c18 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -627,7 +627,13 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
>  	}
>  
>  	mode = lock_to_openmode(&lock->fl);
> -	error = vfs_test_lock(file->f_file[mode], &lock->fl);
> +	locks_init_lock(&conflock->fl);
> +	/* vfs_test_lock only uses start, end, and owner, but tests flc_file */
> +	conflock->fl.c.flc_file = lock->fl.c.flc_file;
> +	conflock->fl.fl_start = lock->fl.fl_start;
> +	conflock->fl.fl_end = lock->fl.fl_end;
> +	conflock->fl.c.flc_owner = lock->fl.c.flc_owner;
> +	error = vfs_test_lock(file->f_file[mode], &conflock->fl);
>  	if (error) {
>  		/* We can't currently deal with deferred test requests */
>  		if (error == FILE_LOCK_DEFERRED)

                        WARN_ON_ONCE(1);

                ret = nlm_lck_denied_nolocks;
                goto out;
        }

        if (lock->fl.c.flc_type == F_UNLCK) {
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                ret = nlm_granted;
                goto out;
        }

Since vfs_test_lock() modifies conflock->fl.c.flc_type to contain an
actual lock, should this check also be modifed to look at the returned
lock (that is, conflock->fl.c.flc_type) instead of lock->fl.c.flc_type?


> diff --git a/fs/locks.c b/fs/locks.c
> index 04a3f0e20724..14dad411ef88 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2185,13 +2185,18 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
>  /**
>   * vfs_test_lock - test file byte range lock
>   * @filp: The file to test lock for
> - * @fl: The lock to test; also used to hold result
> + * @fl: The byte-range in the file to test; also used to hold result
>   *
> + * On entry, @fl does not contain a lock, but identifies a range (fl_start, fl_end)
> + * in the file (c.flc_file), and an owner (c.flc_owner) for whom existing locks
> + * should be ignored.  c.flc_type and c.flc_types are ignored.
> + * Both fl_lmops and fl_ops in @fl must be NULL.

I can't find a definition of the flc_types field referenced in this
comment.


-- 
Chuck Lever

