Return-Path: <linux-nfs+bounces-15873-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6341CC2913E
	for <lists+linux-nfs@lfdr.de>; Sun, 02 Nov 2025 16:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F8E3A33EC
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Nov 2025 15:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7BFEEBB;
	Sun,  2 Nov 2025 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b45rpzMl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ii4DE5E/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E82EACD
	for <linux-nfs@vger.kernel.org>; Sun,  2 Nov 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762098417; cv=fail; b=IbXQXV4iW/gAkT6M3C5WxIdbmgHVJQdQgOhVRny/Wvn5phCSkkkJKeoAOlL33pVyDkeLj5jS/QyGxHPn7FSBBI4ILjOz1TYqaoJreWY0hKschTfWzOBv2qsoFkkl1wG3upLlL74kzWcGjQq3H/WiI73dNA8SkFrcM6dbIBFwz7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762098417; c=relaxed/simple;
	bh=rhxB6n7ni88TeZh1I34xMAeqibDOqXq3sv3LnTp00ac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=syWd4+L6Pw7r4wRKNSMGdeJm/D6772tKdZmVobj4GNgkQoerbeJiwhbxfRocBIC3fF2Fv9Sqt/A4XawlkpwEfKcsu5b/P8CdixCr+K/REFo01FHsvtI8HX3YQ7kBLPOgSltZFODKnrJbbswkBmTJ6+M+EKo+EQU1xsLPRu1yrVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b45rpzMl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ii4DE5E/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2FFxfs002760;
	Sun, 2 Nov 2025 15:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xRSbJiDctL8wRJS5PwW+puddr1buikSlJN+KxxTEAjw=; b=
	b45rpzMl7y2+kk4BS5WheTongjWjQFl2du3O9NsnpcyNAchD6RT3ZCYrgNN54ntu
	ogr4FFBaMF8tyvc24Xjaj3K4AOppHFY/T2ZBPwMUpzbwxVOFAQ07wvPEDefVjCNK
	rl2FAQiW/FrDrSYMtGutTzt/i8r4eCL+zhra9ybINtCpYvIplok4D7ZOrQY/4UiD
	EUY6toowhIG/GEu7QUImWobkikR8G2fvKycuTiP6eB0JHkZyeiex0IM4cu8v6CDz
	KfrYTJjirFf6ZNXvkKcVkCMoEss8DdhAPTpVFMUsnGd97AjKCXuLwzDMiQzBh1nh
	uQXJg/aKVM9zunNxFKDJWg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a69s1g0qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Nov 2025 15:46:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2B55Kl039765;
	Sun, 2 Nov 2025 15:46:30 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nh1qvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Nov 2025 15:46:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQnvRT+bE1z8DXFOFDDSe1uH/eUKjkb8zSSgIjfN0bm7C5rcXhNiazu7asiRNpvCl38L6G1NJLwBoYIr5o5EOAiDuyY/n/C3hQklpcN1XbgV7pICwLmQgSzC4PtBQTgOC2A14+5BwL7uH8yib8clMt1mGu5A/pwoh3N0FKars9TRBF7GI6LeXc+lRU86ZAYgATtymdLqhzBrL6OBGBZNye6za5AQopXyZ2LBl4WrAOLkHn84n2UBGUL7SEZdId+PzBYrUNh1wPWWzlvgWWpm+kbL+CElGTL7cMTTUfWmlb5upwSCPXCGw6abbQ112lrdie0ELniBBV+9aeQtHeErzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRSbJiDctL8wRJS5PwW+puddr1buikSlJN+KxxTEAjw=;
 b=jG8KBjuhrZb5uJTKw6bLda5BUE/YD9zq/oK3PFysggz/g0jd2XvetS7PklksIaA5mT0hsymBZ30/n9hQm2kdYXVqxYXdPbFW8ZPv6An6Vf0Ouu+utFlgPKnKO8380gsSU2wT3GZ1h0hKw4swXJkaAJ7uNRRWkjc6e+4bUZAaH3qkTBfDgKQ7OaP6kGh+pr/kXeULPxJykQ4sCSryS9o2y8YB5DtKPnamrOcpvgT8xRkqdSkKYHnFaA2Sl+ufP6YqnN/CgX+OXn1+SZZY6hWB3dpDvbA49XjzlDyUn3Xof1ydRA2RA4KUX+l9Lqca251MQmCoRHWn2lKPj0SBQh/5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRSbJiDctL8wRJS5PwW+puddr1buikSlJN+KxxTEAjw=;
 b=ii4DE5E/9xBnipbRdxkCBpSzzlwBaAs0ALUgmzCoIiAmnjtkEWQK0m3ZezlshXIACFxmNKmaksiM5ZcGwq5Lu+HuoIq3ZTbqD0DoDawCdhbW5YQIST3fHpghS+04I7l3TFNXpX9a2iy9b6Dc67Zw3jH6zkvlsH9F6bbtebKxIrc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6445.namprd10.prod.outlook.com (2603:10b6:806:29d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Sun, 2 Nov
 2025 15:46:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Sun, 2 Nov 2025
 15:46:27 +0000
Message-ID: <569083e7-97f3-4edf-9def-f1c526bca91c@oracle.com>
Date: Sun, 2 Nov 2025 10:46:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: don't start nfsd if sv_permsocks is empty
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, neilb@brown.name,
        Dai.Ngo@oracle.com, tom@talpey.com
References: <20251030163532.54626-1-okorniev@redhat.com>
 <bca68f1b-ca56-4e94-abd0-de4c509d3d00@oracle.com>
 <176195406890.1793333.13442574969390728435@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <176195406890.1793333.13442574969390728435@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:610:74::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 380d3236-017a-4536-e25b-08de1a26fbfb
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YmNpZFB0U1NLVlRFSG9SYVA2aVROQlFhR1I1aWFsZTJqc2VzSy9qTzBzL0ZP?=
 =?utf-8?B?UXRtSUwrVTlTc3hjQjZqeGpic1ZVaFRnekNQOEFEcGFhSTBEdWptRENOWElt?=
 =?utf-8?B?RTJjb3RpMDRJUktxRDQxTEtITUQvK3F6K3BtNFR0SC96cXkxcTl4U1JRbXJ0?=
 =?utf-8?B?b21YUHNvZTJDc1dQTkNOUGMvYllGL1hYWE5LMnRHdnduSkwrb2xSY1RwVjNm?=
 =?utf-8?B?VXlVeGJIQ215VVY2bHJveTRDWGxiMWc3OWpiaW5JZXNLcE1xejdRdE9zTnha?=
 =?utf-8?B?N1Y3QmNXYUlFcXBTVVNHZHNkQ2hXWFY2a3dQZHNoczBaUkRXZ1N1RDBtcFZB?=
 =?utf-8?B?KzJZWGorUGVIVFcvWFVBVEFSNUVHSmhiaEJHSXdBMUVrRm5JS1B1SlA5R3FW?=
 =?utf-8?B?WkpacGt3eUI3MWcyd2dXem40U0c3MWo3Rnd2dm5GMzM2SG9UT0daT1Z4MktF?=
 =?utf-8?B?RHV4My9TLzU3MDVnMUorYUpUOGJCczV3dGVpRTRjSldvckJ1RnV4eGZsRUlw?=
 =?utf-8?B?MFNlUFBqbjg0Y3l3UUZWOFdkTG0vTTFpeHFsWmxxL3FoclFTdENiZkR1WXJx?=
 =?utf-8?B?eWZDTFhDSlNrd1hxbzJ4K0ljeUo2NkFxVHZ1Z05NQThtNjJIeHd5LzFOTTAz?=
 =?utf-8?B?dHFVN245cHV3RndOTncyVU9KTXI1TEtjQnBZVFZJWE5aZm45MlN1bXlSb28z?=
 =?utf-8?B?TjV6VlZXeWxoY1BEbWlWSWJqMkN6bktXK3pTb0pFTzVTcitYdzN2cndrSmhB?=
 =?utf-8?B?bWxLNWZoNERlK1QwS0U1RmRaQWRjNVRRYzI5SXlLTS9DNEpBSkplTnU5LzlC?=
 =?utf-8?B?SGRUb1pQbjUzdXdyamx6dDd1eGl4RFUzYmR6ZmVnMGJNdlNYLzZkRDhqTmg4?=
 =?utf-8?B?RWJLczNTMU5MUzE2L09NT0c2c2hUZnZGc1piMnQvVXpmU0d3NG9GY01NRGRk?=
 =?utf-8?B?cCtkTkM5V2dMNjI5MzFMdlNYTURUVXR1enVpaGdzL1BpV2crVmJ1REFyQytw?=
 =?utf-8?B?bzVUZlBUMUJzMEZkb3NLcmVYbkJxa1VvOXU0OU9ZQVhSMW04eEt4R0Rld2tL?=
 =?utf-8?B?ZTBkK0JZQ2xyQlB0TWY5eENTWmw3Vm50VDlUcWpmSml3RVRweS9zY2JmNThs?=
 =?utf-8?B?N0dHb3RsSnlDaFFsOTFWVGpRaldid25nR2JKbWlnVEJFNFVmSStPSEZ4VTV5?=
 =?utf-8?B?ais3VEhobVYwczBBOEdpcStFY0luclBiMjhWTVk1ZGJRT0p2Y1YrV3A0N05V?=
 =?utf-8?B?L25pRlQ2MitIbWZMVURqdlkxajZpNFc2dDlSRExCUFBnVEpQdVBPRkpuUS9a?=
 =?utf-8?B?aVdaRTYzTG1sNU1Zd1l3WHJnN0ZzVHdOWlQ4VGtOc0E5bHBIRUJBamFVZjBO?=
 =?utf-8?B?Sml1Q1E0QThDeVU5VVN6MjBVMW5ROE5GVC9paHcreE5kMDgzMXhTVjY3NVFo?=
 =?utf-8?B?UGZWWHhHQW1MRWhmS3U4OGtLQnBQMEwrS01BRWV4K2ZTdGFSTitkcEt4S0dV?=
 =?utf-8?B?MVc4WEw4anNIVEo1SDI1SFkySjNjTmg4NGlKWTRxb012K21QWjJUVWQwb1Zj?=
 =?utf-8?B?ZWZDN0VhR3pDMzhsRHpxZGtSTStDck5NaWNCUmFnbG1XMENuNk9uUzdQZEx4?=
 =?utf-8?B?RVRvYU5PWmt6OXR2UWFYSTBhMDZuMXV6bllqMlY0dTVoUmNWRVc1SlhUME9K?=
 =?utf-8?B?TW5HdHZ2ZUFQcElHRGJOK0NPRWkveExBNjNIeDNyUnpJN1AzVlBjWW9yczFp?=
 =?utf-8?B?RjZPb2d2eUtRcEtJVC9zZXhMKzdVSGFGT2hieVBWdU5abnZvVEZ4TnBDY2pU?=
 =?utf-8?B?UGRzUUhKTkNhdFUvbXNvN1oyMUpUM2U5YmhWb095N3dTdnpEczZkOXNJWmZC?=
 =?utf-8?B?bXVLbkE0NWdieFJ4TGY0T28xZ0RoYkQyWk9BWS8rS0JqUjFRb0xBKzJtVG9l?=
 =?utf-8?Q?O50d9221t/rrcHZ1Xs20D610hPpUZ0ZK?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ajdoeDdKTGV6ejc3eWd3NjdNMGFEaDRJdktsaFU4dmpFdWRvY0ZzaWFIWGNo?=
 =?utf-8?B?bW0rMndvbWd2bTYxdFNkSGhXQWJldTkwZlNJWHRwUnpxLzJaQ3UrUiswZUV4?=
 =?utf-8?B?MGdDSFpzZjgzaXZkTzNjcmxGbGlLQXFVNE5OZWR2bGpkOGpsb29vdGxJV25x?=
 =?utf-8?B?YklueGhXZElsYSsvcTc4R3JVeXNUVTNVbEdBMi9JeGRDbjRBTGdVWmpJenZq?=
 =?utf-8?B?RVM1cUcyZXNzSlU5U0RRbG1mSUFpU3l6am5iVHI2UC85MUVZWE9KQmRTdW1J?=
 =?utf-8?B?VW9HNTBid1hKZVRSUm9yQ1dINS91Z0orY1dQaldyWXRmLytuZGtZUmtFSlhQ?=
 =?utf-8?B?WW0rQkNjbmxQWHRqaXdVcitNeUtSaWNOWHJqYk0wU3ovOVA2Q3ROZnFKVlJx?=
 =?utf-8?B?OExmVFpQUTdiTXFuTzF2bzlrU0RERENncW9JUmZ1dXZ5M0NzV0dQeVFSa3VM?=
 =?utf-8?B?NFA4bVdQeG43S2xmVElOalY5Q0E4R3o2U0NvSEJTWmFGVm5XNk5vYWpTSmVu?=
 =?utf-8?B?WWJkRnZkMGxxeGZSeWZqR0pHTlUwNUNGa25WZ1VDTjhJNGNEN21zdGo3ZzRv?=
 =?utf-8?B?UEQzRFF4Y0M1TG5VYkNTeXlyYk91UjkrRFcxTk13VzU2VkQ1b0ZBVVdscWFr?=
 =?utf-8?B?M3VTZ0Z3dENjY2VQZlVXM21tdEt3R21KeTk2Wjk3ZmNjNFYwVE5hbmlleGo5?=
 =?utf-8?B?R2pHNG83WVZ6eVhqWGJxSWI4bHA4bTF0UEZ6dHE1aG5XRW5zMG9yZU9MUDND?=
 =?utf-8?B?VktSNElFdkRYYmFCSXpiZml6cWx0RzNTRkVCU29ralo4V1lLMTFOWFZscUZt?=
 =?utf-8?B?aFc1Z3EvckY0M1M0b0ZRa2FES1JSczNuMHhVczVXa1gxOTVZL25Na0ZhMVF3?=
 =?utf-8?B?QTNQajJyNFlSRHRKeWFqMUhjMHpnOENrZWhtZStYcWRsWWdvUHNUZUVjdFg0?=
 =?utf-8?B?RkFGaHJENVRwNEd1QUFSTkl6Z3Y2SW1SMWhIbVBydUF2U1BBdW1IOXBDZTY5?=
 =?utf-8?B?czM1SmN4eUZWeDF2alZxcko4ZFhYTk00MnR6N1ZNVjZTZzdKN0REUHNLR2lp?=
 =?utf-8?B?cC9kYnRPeHJqd1NocndVS2p5aHBneXhmVEh5NitVVlhGcHU4VFQ0aWJSQU5Y?=
 =?utf-8?B?dzdYUnlwWURmbmdmdXZmSEt6RFFiSVpDdnFyMEV3b21IbUxrMnJBMC9UVVNY?=
 =?utf-8?B?ZkdjUkhtVHBwWlVIS2M1Mnl0MDcvYWtHZWlzaVFJL3ZUTVNZQVVRMVVrQTBu?=
 =?utf-8?B?S1ZEd0JXaFkybWJzRXlaMUtsemRRSG9HTVlFTTVvSHY4SzlBUldXYldrQytS?=
 =?utf-8?B?TUVNN2FmVlVjK29LNjZGbzcvdExYMEVIdGJMUWVnREZpU0xWbWRZeFVYeGNX?=
 =?utf-8?B?Tm5PNDlNeXhMeWs2aXBLeUZ6dXk1cTF1M3RMeS92bzNLSERuMXRtRXFqdzlD?=
 =?utf-8?B?TVVhQmxweFVtNS9DblZrUWw5UjI5Nk9Nc0E2QWFObnh6dlAxNG4ydjVjaUNS?=
 =?utf-8?B?QlJvTFVvbXFQS0IwSDFDVDBrRHplK0MvZ1hDRkpFMVFTZkw3NUh5dG1WYTNH?=
 =?utf-8?B?QmFpRUpkZGd4US96RU9qTDNiRjRoN0JBV25UaFJNOWZOMTNWbEQ4U1NpbXJa?=
 =?utf-8?B?SnZ5R0hmaTFiWTMzRGxwSHlUNjg0amZOTDNFRUI1WGhCZ2dJWjVUSWhvdURM?=
 =?utf-8?B?RTlJenUzMWEydW1OK2REVHhhK1Y0TzJSbDRRZHhlbmVoMy93MUhlYVozK0JQ?=
 =?utf-8?B?V1g3Qjg4VEthdCtJVjRMV3JYOFRzelNDWEkweWxwVXBEdGw3SmpRZXNvWW1J?=
 =?utf-8?B?SC9JdjJoL0gwUzRhOW9zbGhSbmZmalNFQnBlVjBNT0JnWlpzTHVIM0NpaVlW?=
 =?utf-8?B?aTM3dkpicjVzWThOZHFZMnMwcDc2MTloSVdETUZOMnNaNXhDbzlIQis3Ykd2?=
 =?utf-8?B?NHBrQ0tOeW56OW5BMGFZa1YxYjFRaHFiMlNaRU1ONVQ4aG5xSGh4NVo2NGlH?=
 =?utf-8?B?T0pENGptYU0rbFlwM2l5YWxGWS96MldMRG0wcER3ZGFBMy9qN3NvSEVSQmFv?=
 =?utf-8?B?SnFsaGxLMHFHZVRhdXQvQ3FRYUNzcFd4ZmhKL25DVWxJWVU1VFlUb1JUcmNW?=
 =?utf-8?Q?4nWjvj/bf1qNCvn+qPJKIkv7+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rFMtJYj5talbygmfAlBDQVUQUNVJ2aE7XeG74VCW4RK2qxJDuRzoL9WFpWcCCbqPpYJj0bbl+QDEnoqn+J+oZ8TBIVrmuGSCLhJXWFpK+9Ybw8/d57Yq7vFZUEro6UCV1ug/4RIkm0CKJJzTUAB9AAgj8iUBlaIrUAfGJWZNlUNIML0qfsGh1bmDK32L7KMIg4t55yV4on2HxBzlQ68ywLKJwSzxn/0HbuIsJJD0+OPOYe7NkrpvTTMM7O1E7GP35PiBQ/4BZ6rMtrVwN2cXk5hgogew9MXerDqQdQlVZEAK1aLOV+MyrAWarF/wjNva1sPOKUilK/fhL2zDRBMbiyrbdPyrqj/o+Vt1bZBO8ERCVSul3V26g0erb1wLKcrsciH/AshzO71z77Lz5svsvwNWRpEsQ4PDhSL0r9YxtTXPsobaQOZhY7nKLQFsUVygeYLBt1Nxpxu5xtxaPdoz4qr0PrLPVzbyxK59AacTyvvdqA0joy0BpUtuuehjPuqlGU2boq7xHeXIEY2pUIdo6q0sNtPn6Xe1FMm/LJlUhGBq12RsCSKngdw9wm1cmbJOJUkhRbE28aYys/sVqVjcRJ0GBzVcg9/fQt2dR2V16Ss=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380d3236-017a-4536-e25b-08de1a26fbfb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 15:46:27.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chWALQ2gslwSDzSDdnnlxyes+9uV8ggrECQpHMhrntMmwQAGKmBNbINXLqvVRGAG46TkoVeCBXLjP7Dvj+9K5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6445
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511020146
X-Proofpoint-ORIG-GUID: 17SwrftdRj7M9-ZlZ4ucNXv8o6vFV24W
X-Authority-Analysis: v=2.4 cv=LL9rgZW9 c=1 sm=1 tr=0 ts=69077cd7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=E-dxeyvRkYP5NT7Iqt8A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDE0MSBTYWx0ZWRfXxukbEjwFsDoS
 j3xGou6NONgFRQ+V5KFgmg4nogqUWnmopaCFO7ZAoERAoiIfqgLLAaWlmAlZVmz6wV5V6pK5w2z
 mNJd7UvsS/0ZCoYpGHCYN/fpQpvUXBr7evIvicvh6Isejmg3mAFJncvwNgay4Tdmk6w9R24OIOX
 vI4ctkDHXb6kCRb4YIgGOcEXkkJrXdBiJkffWkwYP1C/Sa2ATdOzLvTmKd/54aEnsyk9g722kEb
 8D2/4Sq8afcQ3nkqlQzOJEfK5gdSIvYo3NBTu9RWO3Z+tIHhfF3mpRZobocL89feI3VXBlNo9xI
 8S9bJug37dribtKU9pgmbaIu4OcSz8LzZLczegMdGKjVbHmr7GXI19K7BXtCf+C8nexuBI/KpzO
 47FLf03XlS1KLweDtlrFth53w+AxOqd6cyJd6q6H3l4e8ZtPgPY=
X-Proofpoint-GUID: 17SwrftdRj7M9-ZlZ4ucNXv8o6vFV24W

On 10/31/25 7:41 PM, NeilBrown wrote:
> On Fri, 31 Oct 2025, Chuck Lever wrote:
>> On 10/30/25 12:35 PM, Olga Kornievskaia wrote:
>>> Previously, while trying to create a server instance, if no
>>> listening sockets were present then default parameter udp
>>> and tcp listeners were created. It's unclear what purpose
>>> was of starting these listeners were and how this could have
>>> been triggered by the userland setup. This patch proposed
>>> to ensure the reverse that we never end in a situation where
>>> no listener sockets are created and we are trying to create
>>> nfsd threads.
>>>
>>> The problem it solves is: when nfs.conf only has tcp=n (and
>>> nothing else for the choice of transports), nfsdctl would
>>> still start the server and create udp and tcp listeners.
>>>
>>
>> Fixes: ?
>>
>> One more below.
>>
>>
>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>>> ---
>>>  fs/nfsd/nfssvc.c | 28 +++++-----------------------
>>>  1 file changed, 5 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>>> index 7057ddd7a0a8..40592b61b04b 100644
>>> --- a/fs/nfsd/nfssvc.c
>>> +++ b/fs/nfsd/nfssvc.c
>>> @@ -249,27 +249,6 @@ int nfsd_nrthreads(struct net *net)
>>>  	return rv;
>>>  }
>>>  
>>> -static int nfsd_init_socks(struct net *net, const struct cred *cred)
>>> -{
>>> -	int error;
>>> -	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>> -
>>> -	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
>>> -		return 0;
>>> -
>>> -	error = svc_xprt_create(nn->nfsd_serv, "udp", net, PF_INET, NFS_PORT,
>>> -				SVC_SOCK_DEFAULTS, cred);
>>> -	if (error < 0)
>>> -		return error;
>>> -
>>> -	error = svc_xprt_create(nn->nfsd_serv, "tcp", net, PF_INET, NFS_PORT,
>>> -				SVC_SOCK_DEFAULTS, cred);
>>> -	if (error < 0)
>>> -		return error;
>>> -
>>> -	return 0;
>>> -}
>>> -
>>>  static int nfsd_users = 0;
>>>  
>>>  static int nfsd_startup_generic(void)
>>> @@ -377,9 +356,12 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
>>>  	ret = nfsd_startup_generic();
>>>  	if (ret)
>>>  		return ret;
>>> -	ret = nfsd_init_socks(net, cred);
>>> -	if (ret)
>>> +
>>> +	if (list_empty(&nn->nfsd_serv->sv_permsocks)) {
>>> +		pr_warn("NFSD: not starting because no listening sockets found\n");
>>
>> I know the code refers to sockets, but the term doesn't refer to RDMA
>> listeners at all, and this warning seems applicable to both socket-based
>> and RDMA transports. How about:
>>
>> NFSD: No available listeners
> 
> "configured" rather than "available" ??
> "network listeners"?  "network request listeners" ??
> "ports" rather than "sockets" ??
> 
>  NFSD: No network ports configured for listening
> ??
> 
> I did consider suggesting that the message isn't needed.

I lean towards having a notice that something didn't go as planned.
My final pitch:

NFSD: Failed to start, no listeners configured.


-- 
Chuck Lever

