Return-Path: <linux-nfs+bounces-19429-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MHiJkLhoWlcwgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19429-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 19:24:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B3A1BBF40
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 19:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F06073034DD7
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60693348445;
	Fri, 27 Feb 2026 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A022KrA4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lN276ftc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767E362135
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216435; cv=fail; b=L2pnXlBP2adWY6mTLYe4VY3gH4obJLtTBVBqmIeK3WlVvR87C5CjMLHmBQ+aIxGBqSmWCXM1D3DTGpbNYnQ8oK1yugTUqclc3gyU0uiCdBAcZMtNwLonTUmq//+GKuShbeKgr8Lm0znrndAM1FLpBLa1eeDw7vIXwe31Y5rTCWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216435; c=relaxed/simple;
	bh=sW0HXLh0xnzwjVI0bsvNlzhi2OrLrqgo4cWen8qAxig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mnfzXlt8keUo/rUdtmsT2Z9c3OF87yKXZvxVxuFwy7GXTxMHmV8x0Gb5kbV46T119Yr0JrCMeCKAwuICYEjD51kDng7OUJp8Q9F9mMrDfIjDuqtCbFPrEohZMb1Lc6VrhOD2QwW7LfUzhVFIEyxABn/gpmWr16okCtOrHukpdhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A022KrA4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lN276ftc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61REupTU2251827;
	Fri, 27 Feb 2026 18:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jN8+T20HLSs/GrijfuWX4bVd7JBiYMj1gezfHrPalJE=; b=
	A022KrA41DwnJFY+8BanycG6CGn5GmHLD6NswRyQZu2ITBysJU42fV0cDAt6c6iC
	cBrIWnv5CjR9FETWsvzHybprVHsdf+Qpxk5BB9hlP6AkZ2gujF/Rqf8sxRAUoN1U
	xx9o/+FDX9tz4UGdC7vZFAzim+1HmqNDPhA87eXV2+FhjPQzVmz5bBa3L6UyFVEq
	fOvZqdw6ndFiRjwitdEWqCsRvV4lAqhULgfUrTF9ShpoJirdjQdi5bBSu5Z1WmTc
	iD2UMO/3IYSW+bBsV1x2y53M4n8OiyUMPaKBN6OJoBQ9hXeEf3Ps8R9t96cPHxnt
	H+HageEjGf3aYPLOQ8zcog==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgg3v3cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 18:20:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61RGm0PN002249;
	Fri, 27 Feb 2026 18:20:14 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35jgg6a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 18:20:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HY+Ibm/W2lKRlq939qY4nfhOgbNLPjqlcNqAYvvbuuHOqsUdPGb1qqsc2Rc6j/qLGO/FcuGQ/4HPpW5gk4BHSow4F3NSzNgmchlIvu46EhVy8JZpVOlY/hHyozFBf+/ubXttXqKv0aKoQqpMMSBRGErFtuUpNXkqaVbolEbk6LjRpTQW+ONhk0VdOyzvrC7B2r8Ewpt7BrIx5dDUt4VpH+xzVnITw3W4ayTQ49Ffc7Uvz5wgbttKEfflcZhkKeOpgEsXITHbCt6EWLuzhHiGm7wjfn4oJYNaLUz/vE5Qa1JwElP3hQYiaSgBw3rGp7mw3/VTJeh+ZDOGVk/de5Cc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jN8+T20HLSs/GrijfuWX4bVd7JBiYMj1gezfHrPalJE=;
 b=FRCaDdQX8so6W2Q28zxWU4ZzpNsj5iG5Ow6JCp+lvzD9u0Alx4i3o/S+OpZ4ep5IKLE7ytlo6fEsSrpk3cA7Tv802jcPl4Gi13h0+B9zAtXlFhg1Y0OCX/QOZTTH98UsneL1nhvddKT2bxTtR+igKB2LsUDpJ3HzBxPVSuFGKht2A6qES45z18z8N2Da4rCh+jQGhHaLLpS+Ho0p+haaizhquvGkODM+G2BpU/WgTrKSq9IzsxzS0/fH49hec8pNcMexTBD6RyahrYtASRMxSfhH1PaUIysw8Qd4FYZberIsDyJQBX5vvKJrOaCdBpEo96G+KorsUD3LmDfZkUKwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN8+T20HLSs/GrijfuWX4bVd7JBiYMj1gezfHrPalJE=;
 b=lN276ftcYxL8PvK7QtLc9cAOJwiUuatbDLria4VnvBzV33HhzCg62R68inZ8ITz40QF0ZFwT+/ucd3OWH0bHBq5cGTIOUKNCiZqgal+arJboPVq1l/4pxLR2/tRsaUT6vd2bhU5P8NAadImDODzBZ8kLgZqwEjlVgfr5AXl8QBs=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by DM6PR10MB4137.namprd10.prod.outlook.com (2603:10b6:5:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 18:20:10 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 18:20:10 +0000
Message-ID: <e4b79d8b-ff77-4e1c-b2c6-8408b8310c5f@oracle.com>
Date: Fri, 27 Feb 2026 10:20:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] NFSD: move accumulated callback ops to per-net
 namespace
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
References: <20260226193611.1038076-1-dai.ngo@oracle.com>
 <a4bf76dc-2805-415e-be50-5501ea1ebf9a@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <a4bf76dc-2805-415e-be50-5501ea1ebf9a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::28) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|DM6PR10MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df3f558-2b32-4bdb-3960-08de762cd739
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 9G1a+70wvCbSF6frKF+ALei5wiFo7Qw5/+MvuJX1xuF2or0HCbqmI3dXBEYsDzh1DjpS4715f+s6T6vFsRASB0QxVyHRmZ1aV+5feX+hZPGTRaG10CFFTYnSxVr6FiR0Cttcue0P9etFF7eDhtfpVKpKrqTqe21N+kkUfdt3QZR2Z8BViu8BncoC5SUTMrzdzWRrUtkvY+jKnyjO+k5xgNTqCRTUbx9Oq41Agraq9B7vPC6pIwTxS4g4+A3cgCqX+/T9u4fgxwX1rAzLI399NlgfRZAhEeEcmCGrg88Y+KYokwYWpkNCugCudc/FrI20ep0H4S/YOcgGu2rCX6KHVhSOUsNF5kwr6960JIEz5H2Oss6CM47Q6ExUgbbpOZNLipFwKvax1g0xpk8tllP2fGSvn788qld+mkvCrE6QiuPCmjuNNPTF01+c0c1WUEX8fD3I/3Rzj7zhUxykDn6HVfmPHaPk1t3I+MGVIUUPwHeGZxTDR1M32F9JhiERoYekiqb4H/64kJ+nv+FXkiCKMryjWxcLdf/L+vdTyhfsPliOp/Plccu5bOIryYnzvA0rhVTToirsON0dJHMqKhOix89zPaTRFc3L1J1Vqp7w4FkWkwDJtCmkxAepnCSagMX59ZLnQvHJis7T1d1WN9zvTZbd7it3z+dHRABtkYfbSTtFtGB/tHxFHI1Z4RmYqB6rFrYIYCCQ8PZPuqaWoK6TF11/bx2/PNIhLc5Ma3ZkHEg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?S0tZelZMRXBPTTU5R0MzRUl1WUJlYThyY3FITmIyay8xbjhNSTUxbUYrdTMv?=
 =?utf-8?B?cXhtdzFCMFN0ZUhSc1NRK1hMVTU4Q2xkM0tadlBwYXVuZEUvYXFBYUdwZkhV?=
 =?utf-8?B?bnZsTG50WUtRZTBYN1dQRFFoaFBPNUM2eUQyWXI5NjZYTTN6U0YxdlcrY3ZM?=
 =?utf-8?B?UzdMTnhRMUF0anBOZFZkVXduVGtYVmNkL2VQc0FDU1ZKd2N3RGdBbjFGUWxl?=
 =?utf-8?B?bFN6WDJldzJxcTdVTXJNRHlBMVBMY3BvNHlod3dFU2RlOFRWQSt4MEtsc0lv?=
 =?utf-8?B?M1YzWnRtKzNkQkVtWjVUTU5VQXNCV0RwRDFxZGZTaHNQRnpEaVpPK2pEMGFz?=
 =?utf-8?B?S2NCSWZFcnY5Uy8xbFRaS3pMNkc3VUNRL3JjbUdka3kwVGZ4eURwQVJTa0g5?=
 =?utf-8?B?TWs5MFlIT0pEYWRTUUpMZzJQaEk0VWZ6a0JuVzJxUDBkQWhPVUF4clpRYkhi?=
 =?utf-8?B?QXhqK0l1VmE1QWV4VTBoTjhUNXhwMnpodlZHbUFZNm5rL1Q1RmZ2azJwUGsw?=
 =?utf-8?B?QXlGUDFIZzQxK1UvQm9vazVQSEYrUkR5UlptMUhvS0NlcmF4V2VWZG9YL2VE?=
 =?utf-8?B?OFFYallSUW05U1FZQmJvdm52TkF1M2o0K01NZ0lBelRqbklCdUt1TFA0ejRO?=
 =?utf-8?B?SGswWFZpNjdveEJjMjc5Q0hMMVZ2TUVCaDFvbEhMbk9XVVFVZkRyd3prZURi?=
 =?utf-8?B?cEtBR3E0Wi9lelFtcmxFY3d3QkhBYkxWcCtKSjdwVjJIdEp5aWhFYXduZ0pZ?=
 =?utf-8?B?N3Y5VzV4RjBuZGFOVnNqVFFXcm03M01vU3ppbmlabG9HSDVhNzBOamx5Y0ov?=
 =?utf-8?B?NjFQQUY0Q0dBYkNRVmpwaEtveTVJUE5Gci9QSHRpWHZKWCt3STlEdFdWZmVk?=
 =?utf-8?B?Zk1ZSHlNVkRTcDMzbmk3TytLbmo4TWZiSjcyWnV3NklySURzdGdpUk1vN1NR?=
 =?utf-8?B?OGxiZy9nNWpUUWZ0VGpzSGprTlpsZHhFN00wNmlyZHp2UXlNK3BKSGMrODU2?=
 =?utf-8?B?RlVpbkFoNW8wREpGWFhlekpWd3QzeFhTM294SUNSQXJ0Z2IyVGY4d2N5emow?=
 =?utf-8?B?SkF3Sjh4eStTdXhjWVpzSnc4a0RVaVU1dkl0UnJXSXNtWko1ZmZvR0R2RkV2?=
 =?utf-8?B?Zm94V1hRalpGUGhQVjRSeFRFeHFhUzRZK3dEbXUzS2tPZ2VJZWFPdlpkOXRt?=
 =?utf-8?B?djJMRDUwTEZvaUtlMWZETERndXBzekJvNzRyNURnS2sxcjdRbjY3THZVRnFh?=
 =?utf-8?B?bTBGaEFiRXRxZG5CenZuQzNPdXNGcjZ3eFVENlBuUVFYUllOdTNjTUZBSHkw?=
 =?utf-8?B?R2VCd1FxREFjSnMyRnlnNG9JQnV0cHNycm83VElQRlNnRzRHVk5BQ2NKcTRV?=
 =?utf-8?B?VVY3bEhNZXFWT2RIS1hjTUJHTkxXdmlWa21Db0R1ZkVrUDJMbjB6TFNLN1Z3?=
 =?utf-8?B?WHZkZ3ZaV2xKZFgxQlA1WktBSVJEaWoxckpZNXAvb0JPN0NQVlJGVksxK2dX?=
 =?utf-8?B?N0ljOGlabXJYdXNiM21MWTlkMGtnNFd0Vmc2S3hlSVJvVVdEaS9OM1FPc0ND?=
 =?utf-8?B?d2hPcFhsYkFIa3QyVmY3YWpHS1l6cmZJQTRESVQ0ZC9kYVVOOGhRZUxBKzNl?=
 =?utf-8?B?Z0JWYmZuT2tVcXJURzhXajU1LzVtbVdNQlRxQXR1OWdPZDV1SUhDbG54TjRL?=
 =?utf-8?B?U0VaeDBFTGpUM2ZnaEJMM1BaS3V5ci9zTzliL0IzN3llbEZXY2JkUjA5MUhZ?=
 =?utf-8?B?RlRpZU90VzVDQUF4SkREblJqOWNLcWdTU3l3eEdNTEIxUGhXR0IrZ3ZyM3Fm?=
 =?utf-8?B?enlGSTB6ZGViVFBLZEpkbVBmN0IyektPVkkwZEtrem5NTVRrL3hTRFA0NGpC?=
 =?utf-8?B?NDdIL3dCS0YrZGxPOWtxNmNrOTVBeWxuWGVXWXRlVFZ6d3Y5WnB0ZDNyUGhG?=
 =?utf-8?B?VnZYT2pOaWZpTUc2aXlWR2xJUjZ0bkpJblExOVVNYlV3UDVxSHlCSnhEakMx?=
 =?utf-8?B?TW9uS2NuUVg0SGYrNndqYkVnWENRbWVnMFc1bHJKZ2Q1MjBTNmR3UUl4NUF1?=
 =?utf-8?B?V0dGNXFrVndad1ZGdEF3OGk2WXV3aTlxMlhwZGRqRzFBYW9CN0VlZTFLNFlY?=
 =?utf-8?B?MUJLTkZoMFI4V0o5UUp6TmhlSE1GaGdISkpsQVFpUTYySktjQTlMeTVaSUNF?=
 =?utf-8?B?YVR6eE5vekMrNUtNWWZjMjlUOXVKYndYOEthNWRtL00zL1dwSll1WElMclRC?=
 =?utf-8?B?T2s1NGFIaDIrREZaWXIrMVUyL255WEQ5TGcvb1EwaHd4bTFJSmVCWTZ3WWs0?=
 =?utf-8?B?SkRTUzNMRHBwQXh6cGRENklKRUVHMXNvUkNQQWJHZXNwOWVUdldLdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yoOoiLsvwqaWJlxF7F9399ck7DPONh6/AFjFbpjMXbiNwP1dLdTMvwT7BApzxyEgkue6kjjHr7UtOZgxvzBDTtbSF/E0tqn6/vmkv+3BdLjd+1lSNwixGOiCK3lfmPFKV2V4v05n9MuAzK2ExwVB99+Y72PZ2Kth1JT3uzSqDbQqGoKWbDQ8ax3D44c4Cp7/ErzbIfSSRG0/Czn/f/Ps6o7OMZfg2oPcOwNqdXWnArIMDFLa1bDcQD3IuARUde4fg+cSVyDScP5lut8xKWVOoEvN8BwWx+QWs4UngOpsu3f0bZrg8AVGcFWInaVPNdhcq7QRXjAtQadbvys8ixOMa6utw1FF5R0MdZomeSF0xTX4jOrrnoVmrx9fXpQ4x5bEJr3JFkuxfDjahGE3C+cvsc2BB8MJTmrRvHbHn1w4+aIsM8VbCsYJbwfSCCX1F35Wee8GdEhUjOuBpEsWQKqT+PilFHwQF1l7UHfCzNh/G5tkJFEWd5bPnZ5tga82hgBWUgrt0c47HqU9ruYJKhCW7lB60ICEScJUjfmpatP3Bql2ZwLqrLEskgkDXgDrt8wn5PIIlg5qIbKd2jOSe7DTVXTcAN6pNMrJMCRDP5Mg5A0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df3f558-2b32-4bdb-3960-08de762cd739
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 18:20:09.8205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5a/YkOIgvF4wn/RB6+l43DZsC2dMrV4PfiD9OEUVLCcbMb95372hOkoJjZnfTlZgz+4DQmuHX7UNs9OgqVQXiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602270163
X-Authority-Analysis: v=2.4 cv=XZqEDY55 c=1 sm=1 tr=0 ts=69a1e05f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=78EKqg5yKWq2jDG2GpYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13810
X-Proofpoint-GUID: tLB8ZMN8xWAIzCFK1PJAv1pMXCjfjpXO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE2MyBTYWx0ZWRfXzeoYvgN/x31U
 tR4Lz4M5Fldv2FP/9K790qb6r3cgVTP5Fd/O9SPGlmQ+EYEn7GklI2kV3LoRQoPcDLv8+lOin3J
 5zEZ9BxQaNE4Bd61NTGAEr6jikBIKrWm2C+uf7UjSEOVjptuW+Z8fFqPIURMm/amObP/09E0LwB
 Cpt98c3f2dZ5vlbBXcqZ0ie71ghb+4eAxBCvubPShKKIwFW0j8f8raSNGLqWlWl9LKxlXq7yRfC
 UaYwq2OVYPrz0NwOQ6lUR1/v5ZjYdFQtCTmpv1qPFYXxgLgbxjoaCIuXCd2H1UNQeM7f0Ss3lrO
 MAdrBinPNBvgN6hJLz1KUfQyuV3omotlyzPsC/BXMwoHpzIRXZkgKtCWLE1cCRb+S1rUl1+syFW
 BBWtoeDi/JGuQ/WGQ4VXFGGE4LXADvkUpo0JmjAN5k0G8ONBLCaaVpUV7IFnctW7v4NpTlS9Ubf
 LEpL9P5HrF7N/JdkkdNyJcxZ/xP9NTH7zmm4jC24=
X-Proofpoint-ORIG-GUID: tLB8ZMN8xWAIzCFK1PJAv1pMXCjfjpXO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19429-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 87B3A1BBF40
X-Rspamd-Action: no action


On 2/27/26 7:56 AM, Chuck Lever wrote:
>
> On Thu, Feb 26, 2026, at 2:35 PM, Dai Ngo wrote:
>> Track accumulated callback operations on a per-network-namespace basis
>> instead of globally, ensuring proper isolation and behavior when running
>> nfsd in containers.
> Where are the consumers of this information? "Subsequent patch"
> is an OK answer, but that should be indicated here in your patch
> description.

Should I first expand the output of /proc/net/rpc/nfsd and then follow
up with a netlink-based implementation? Or are we trying to avoid adding
anything new under /proc at this point?

Also, is there currently any user-space utility that can extract nfsd
statistics via the netlink interface?

-Dai

>
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/netns.h        |  5 +++
>>   fs/nfsd/nfs4callback.c | 75 ++++++++++++++++++++++--------------------
>>   fs/nfsd/nfsctl.c       |  5 +++
>>   fs/nfsd/state.h        |  2 ++
>>   4 files changed, 52 insertions(+), 35 deletions(-)
>>
>> v2:
>>    . free memory allocated for nn->nfsd_cb_version4.counts in
>>      nfsd_net_cb_stats_init() on error in nfsd_net_init().
>> v3:
>>    . reword commit message.
>>    . fix initialization of nn->nfsd_cb_program.nrvers.
>> v4:
>>    . fix merge conflict in nfsd_net_exit in nfsd-testing branch.
>> v5:
>>    . restore commit message to the original in v1
>>
>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>> index 6ad3fe5d7e12..c101bf2c24c2 100644
>> --- a/fs/nfsd/netns.h
>> +++ b/fs/nfsd/netns.h
>> @@ -228,6 +228,11 @@ struct nfsd_net {
>>   	struct list_head	local_clients;
>>   #endif
>>   	siphash_key_t		*fh_key;
>> +
>> +	struct rpc_version	nfsd_cb_version4;
>> +	const struct rpc_version *nfsd_cb_versions[2];
> I know this is copy-paste of existing code, but can you find a
> proper symbolic constant to use here instead of "2" ?
>
>
>> +	struct rpc_program	nfsd_cb_program;
>> +	struct rpc_stat		nfsd_cb_stat;
>>   };
>>
>>   /* Simple check to find out if a given net was properly initialized */
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index aea8bdd2fdc4..759f24657c34 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
>> @@ -1016,7 +1016,7 @@ static int nfs4_xdr_dec_cb_offload(struct rpc_rqst *rqstp,
>>   	.p_decode  = nfs4_xdr_dec_##restype,				\
>>   	.p_arglen  = NFS4_enc_##argtype##_sz,				\
>>   	.p_replen  = NFS4_dec_##restype##_sz,				\
>> -	.p_statidx = NFSPROC4_CB_##call,				\
>> +	.p_statidx = NFSPROC4_CLNT_##proc,				\
>>   	.p_name    = #proc,						\
>>   }
> Previously all compound-based callbacks mapped to statidx 1
> (NFSPROC4_CB_COMPOUND); now each operation gets its own counter
> slot (values 0–7). This changes what stats are reported, IIUC.
> So bundling it here means a bisect on a stats regression cannot
> isolate when accounting changed, and reverting either change
> forces reverting both.
>
> IMO this should be a pre-requisite commit with its own
> rationale.
>
>
>> @@ -1032,40 +1032,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
>>   	PROC(CB_GETATTR,	COMPOUND,	cb_getattr,	cb_getattr),
>>   };
>>
>> -static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
>> -static const struct rpc_version nfs_cb_version4 = {
>> -/*
>> - * Note on the callback rpc program version number: despite language in rfc
>> - * 5661 section 18.36.3 requiring servers to use 4 in this field, the
>> - * official xdr descriptions for both 4.0 and 4.1 specify version 1, and
>> - * in practice that appears to be what implementations use.  The section
>> - * 18.36.3 language is expected to be fixed in an erratum.
>> - */
>> -	.number			= 1,
>> -	.nrprocs		= ARRAY_SIZE(nfs4_cb_procedures),
>> -	.procs			= nfs4_cb_procedures,
>> -	.counts			= nfs4_cb_counts,
>> -};
>> -
>> -static const struct rpc_version *nfs_cb_version[2] = {
>> -	[1] = &nfs_cb_version4,
>> -};
>> -
>> -static const struct rpc_program cb_program;
>> -
>> -static struct rpc_stat cb_stats = {
>> -	.program		= &cb_program
>> -};
>> -
>>   #define NFS4_CALLBACK 0x40000000
>> -static const struct rpc_program cb_program = {
>> -	.name			= "nfs4_cb",
>> -	.number			= NFS4_CALLBACK,
>> -	.nrvers			= ARRAY_SIZE(nfs_cb_version),
>> -	.version		= nfs_cb_version,
>> -	.stats			= &cb_stats,
>> -	.pipe_dir_name		= "nfsd4_cb",
>> -};
>>
>>   static int max_cb_time(struct net *net)
>>   {
>> @@ -1152,14 +1119,15 @@ static int setup_callback_client(struct
>> nfs4_client *clp, struct nfs4_cb_conn *c
>>   		.addrsize	= conn->cb_addrlen,
>>   		.saddress	= (struct sockaddr *) &conn->cb_saddr,
>>   		.timeout	= &timeparms,
>> -		.program	= &cb_program,
>>   		.version	= 1,
>>   		.flags		= (RPC_CLNT_CREATE_NOPING | RPC_CLNT_CREATE_QUIET),
>>   		.cred		= current_cred(),
>>   	};
>>   	struct rpc_clnt *client;
>>   	const struct cred *cred;
>> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> Nit: Reverse Christmas tree ordering -- this new declaration
> belongs close to the top.
>
>
>> +	args.program = &nn->nfsd_cb_program;
>>   	if (clp->cl_minorversion == 0) {
>>   		if (!clp->cl_cred.cr_principal &&
>>   		    (clp->cl_cred.cr_flavor >= RPC_AUTH_GSS_KRB5)) {
>> @@ -1786,3 +1754,40 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
>>   		nfsd41_cb_inflight_end(clp);
>>   	return queued;
>>   }
>> +
>> +void nfsd_net_cb_stats_shutdown(struct nfsd_net *nn)
>> +{
>> +	kfree(nn->nfsd_cb_version4.counts);
>> +}
>> +
>> +int nfsd_net_cb_stats_init(struct nfsd_net *nn)
>> +{
>> +	nn->nfsd_cb_version4.counts = kzalloc_objs(unsigned int,
>> +			ARRAY_SIZE(nfs4_cb_procedures), GFP_KERNEL);
>> +	if (!nn->nfsd_cb_version4.counts)
>> +		return -ENOMEM;
>> +	/*
>> +	 * Note on the callback rpc program version number: despite language
>> +	 * in rfc 5661 section 18.36.3 requiring servers to use 4 in this
>> +	 * field, the official xdr descriptions for both 4.0 and 4.1 specify
>> +	 * version 1, and in practice that appears to be what implementations
>> +	 * use. The section 18.36.3 language is expected to be fixed in an
>> +	 * erratum.
>> +	 */
>> +	nn->nfsd_cb_version4.number = 1;
>> +
>> +	nn->nfsd_cb_version4.nrprocs = ARRAY_SIZE(nfs4_cb_procedures);
>> +	nn->nfsd_cb_version4.procs = nfs4_cb_procedures;
>> +	nn->nfsd_cb_versions[1] = &nn->nfsd_cb_version4;
> Could you add a comment explaining that slot 0 is intentionally
> NULL and slot 1 corresponds to the CB protocol version number?
> The original designated-initializer syntax made this self-
> evident; the replacement imperative assignment here does not.
>
>
>> +
>> +	memset(&nn->nfsd_cb_stat, 0, sizeof(nn->nfsd_cb_stat));
>> +	nn->nfsd_cb_program.name = "nfs4_cb";
>> +	nn->nfsd_cb_program.number = NFS4_CALLBACK;
>> +	nn->nfsd_cb_program.nrvers = ARRAY_SIZE(nn->nfsd_cb_versions);
>> +	nn->nfsd_cb_program.version = &nn->nfsd_cb_versions[0];
>> +	nn->nfsd_cb_program.pipe_dir_name = "nfsd4_cb";
>> +	nn->nfsd_cb_program.stats = &nn->nfsd_cb_stat;
>> +	nn->nfsd_cb_stat.program = &nn->nfsd_cb_program;
>> +
>> +	return 0;
>> +}
> New non-static functions should get kernel-doc comments.
>
>
>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> index 032ab44feb70..5daa647ef0fa 100644
>> --- a/fs/nfsd/nfsctl.c
>> +++ b/fs/nfsd/nfsctl.c
>> @@ -2216,6 +2216,9 @@ static __net_init int nfsd_net_init(struct net *net)
>>   	int retval;
>>   	int i;
>>
>> +	retval = nfsd_net_cb_stats_init(nn);
>> +	if (retval)
>> +		return retval;
> Does this build if CONFIG_NFSD_V4 is not enabled?
>
>
>>   	retval = nfsd_export_init(net);
>>   	if (retval)
>>   		goto out_export_error;
>> @@ -2256,6 +2259,7 @@ static __net_init int nfsd_net_init(struct net *net)
>>   out_idmap_error:
>>   	nfsd_export_shutdown(net);
>>   out_export_error:
>> +	nfsd_net_cb_stats_shutdown(nn);
>>   	return retval;
>>   }
>>
>> @@ -2286,6 +2290,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
>>   	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>
>>   	kfree_sensitive(nn->fh_key);
>> +	nfsd_net_cb_stats_shutdown(nn);
>>   	nfsd_proc_stat_shutdown(net);
>>   	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>>   	nfsd_idmap_shutdown(net);
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 9b05462da4cc..490193c1877d 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -895,4 +895,6 @@ struct nfsd4_get_dir_delegation;
>>   struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
>>   						struct nfsd4_get_dir_delegation *gdd,
>>   						struct nfsd_file *nf);
>> +int nfsd_net_cb_stats_init(struct nfsd_net *nn);
>> +void nfsd_net_cb_stats_shutdown(struct nfsd_net *nn);
>>   #endif   /* NFSD4_STATE_H */
>> -- 
>> 2.47.3

