Return-Path: <linux-nfs+bounces-16580-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AFBC7107B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 21:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A6C4347CA8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 20:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698F9324B09;
	Wed, 19 Nov 2025 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TLbBs2b0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dTp/Jdol"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E933D32549A
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 20:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763583821; cv=fail; b=Xilrfg5lE60QxkEEJs5YXfvFbAXp2HN6mIbGBPxO4dQ171ikrtmK6+0eZPFySNtN9t11wTWFuzo/LwOMQtaaZRRfKO/4kdZwzYHViHC4GtrYy+UUpQyUxI6nPn1AzL4nBuXerQlmn1PZh0z0ueGRWZ44UYYQwtICVvSxyovs7JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763583821; c=relaxed/simple;
	bh=qDTmgmfr+V0b0yd0VFF75c95iUZOvTPrJhMNYpANkaI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gyHKcNJGu+TjwHh18Y9ZEcPWDCdNi+D9D2xYqPsp3FjVC+S5eBaOvFy2PjfdHwTXsKGmRghNwCIX3pASidN4Um1jgXaEMkMAnQht9l0nif40tDY/OY9MSgg2Vcf/3Y3oEqqWhYBAd0tSvI3ym1bxpuT9y0J1c4IGhMHj7c5y3W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TLbBs2b0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dTp/Jdol; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJJCKEC003827;
	Wed, 19 Nov 2025 20:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WOE/ebLjJjgfWJ9XpVPC6nWJRQMm/zM7yqeFKKOhUeQ=; b=
	TLbBs2b0d7lIAGMVXeQZXCyw5F88Qd6ttLxLLEzRKUsaU6odjW5HevqTTVKWAgwl
	+HbUAZJjzk1IiO+EQn75inopgM2V8xqxKmM9zsTjPKf8f84MgONGlH/S4JcrRjlG
	pRS6sVXBkKGKh/wpQUlCvhogI+Z88QuhHJXUG5R7QkOIy10TVprl7ctj9EAz79Lv
	JcRuZd59m+1q79UWXvTssq38ZHV9pDGc7qQhe5AWiQ8xRFDsKJjMODNR8NJEWSYS
	e52ys1krE39ZopL2x23n/rG+RNB6j52qaWmvI60thG9gfmeZiKwg4Mq3FAx85OB2
	xc1wpgtvwl58nQQ55oVQqw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej8j7w6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 20:23:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJJCLfk007832;
	Wed, 19 Nov 2025 20:23:32 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyb4aky-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 20:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIHOih6oBhAYB9BttX9IrWTB44FFkH1yEkBJqKnhU/PhkxxrRO4nkBij7fVW18u0LHFASn8XYmdwIZdZ7+uTKBag08Cg2H6ut1n/LnYGp9nyIgB/31jwddhWanuRwTs2jMpsQx0uLkve9e6ddnLCYztHfOvFht26i0muV4t2JjLApBO1B5hjbVp4Nfo4cDg65wH2CXrx7dELkZ06rflsqfCxc2VrjITO/hhPo/WTAjVIdMI7tf8dSqeh+FpVhDmW3m1g7B7/+uMpB5GvIMRl00hxbotfpBEVINK5MGlHvSEQtCfiiYU6blGFDGq1pmGR/QndYuvfeyo2DMPWxv+fYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOE/ebLjJjgfWJ9XpVPC6nWJRQMm/zM7yqeFKKOhUeQ=;
 b=YP7MJIqehy7O19mtH72Q7ukF5hQkN/D/8nN8TmA9n0n1KGniy2Vg+/eo7aGLOHfaPmXdwpaOLVUAu819gjhlKjDvLm0Y7HZW8WrvhVTy6ILCwkvbOwnay5zLIh/RiuOYiekZ3S8MsCawXk4U8YrulJAqpoUPoFeR0ke69ClaAa9h6YHcU08IUp2X/Jw7E9Zg6oY4uX2Y4LEgz7DVr3m9UudgsiOrFYrT6V1Bwfhr0yMwO+5ixE8OEsCNhHQ5O6BPohH8jEVO99MfsHvsHt5DL6REmP39NMCvhPXPcgERKCzVlhrRXRQ8nzjiqfniSC3Mbp4c2zFYDWq0RIvNKK8nYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOE/ebLjJjgfWJ9XpVPC6nWJRQMm/zM7yqeFKKOhUeQ=;
 b=dTp/Jdol8Cg2HTxdzch7ED8Po0L+/B6XWGpc2ROCniiTkxt+vtMjvAU6T9qqX9ZubNM+GaGLCdBgvm4SeyR3jbfwAlpncYSXffvEKg24UukcZtQG4d9tHCuTmKR6y4YJcCAoyqPiGmrW2In8yc9C5qQuXOsuj3MXPlgiXh1iOsk=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CO1PR10MB4499.namprd10.prod.outlook.com (2603:10b6:303:6d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Wed, 19 Nov
 2025 20:23:18 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 20:23:18 +0000
Message-ID: <7c2e77a6-6ac1-4b32-a245-4a7a98f7e577@oracle.com>
Date: Wed, 19 Nov 2025 15:23:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/11] nfsd: simplify clearing of current-state-id
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251119033204.360415-1-neilb@ownmail.net>
 <20251119033204.360415-8-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251119033204.360415-8-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0017.namprd19.prod.outlook.com
 (2603:10b6:610:4d::27) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CO1PR10MB4499:EE_
X-MS-Office365-Filtering-Correlation-Id: 093f2bbf-3520-46a1-e4be-08de27a9798c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dkpuc3dxWTJ5VjlXTEpnY2k0cGNwdlZEWUxnT0dWaW14TTU1aWRQNitrd2NR?=
 =?utf-8?B?S3c5WmlCalRKblRoMGU3TmRkRnZ6NWFiTHpZdnpkWWlTM0IxR0JOUG13Y0Ix?=
 =?utf-8?B?S2VvMTg1NHI3NHJ1Q0xxZ2Zraml5YldlSy9US2llZVA0akl3SnJOZHZMOGJv?=
 =?utf-8?B?YkpCOWNTVnN5cGc1bUdkUWQyRVVJa2xQVkxzSy9Jb0JTYXBqajhVdVB6dDlM?=
 =?utf-8?B?ZlNud3hRdytJd3ZOdEZYNVlaLzVHRi8xNnBpenh5WTFzak9NTSsxK0owRDZa?=
 =?utf-8?B?cFlUVHZGT2o3SGQ0cGxmdGhzalB2VmhEL2dhRTl5NW9vREYvSTFrMEl0QW9P?=
 =?utf-8?B?b3pCaG9PMkFnWmdOZGVuYUw5ZEw3MUNvN0p2VFM2UmV0bHJqNVc1MVJJL3o3?=
 =?utf-8?B?c2RieHlrQnNZTy8wcGtRd1FMUFlKTnMvNmxxUHNkckMzOVNrQVB1Vnc4T2JM?=
 =?utf-8?B?UjFvZm9KUVFYWTN1bm1rYlhRVWlNZ2VNY1gvT1NIeHBPaVg3Tzh4REc2YVNx?=
 =?utf-8?B?eEhqb1c2QkNIMHBLeUJCQlBwVDdsa0pKZDc3TDdCaXdTdCtVUEd5SnNXTFdx?=
 =?utf-8?B?TEMrSjNyMDBDbjlaTFNTQVJMUmJOeWQrN29VdWlLcE13Z0xDWDlEVTR4MU1i?=
 =?utf-8?B?Wmk0VUl3SHB3MjNCRU9zNHdzd2hlQUgxN0MyNVZzRW5zYWtSbjJqYWlsRDFP?=
 =?utf-8?B?Z21RbFpUNXdxT1hMaGE5bUJNb2IzOHJBcVhUVDJHVTRvWkJNRnRMcTJ1S3lJ?=
 =?utf-8?B?dGVBMGxJRzBwN3hFT0M2TUdkTU5NbkhPSXJQNUNYMVNqQlYzTHYyQnQ5R1Rw?=
 =?utf-8?B?cTA2QkFiZHUrSVo1TzBPU1E4T0x3Q25mOTEwNkV4OGRDWUwrZ05MZzFHYlk0?=
 =?utf-8?B?SEdnakJxT2ZzWGJRQmxSU1UrdlpFV2JlQTlnRUx6WWdGaEl4VnFzR3Fobk5N?=
 =?utf-8?B?VmRSMlhoU1JTZTdsaTRiKytFNnNqNTZHRTBDQ1NDczVkdW1zbzZtMXNrYkpH?=
 =?utf-8?B?WlVXL2h4RG5QV3Q5N29yQklnZEtsZWtUNUdMWHlQbVJoeTNXb0RLcVZHaHZY?=
 =?utf-8?B?SFAxenhmYVBiVDRGV1ZMdVBMSUtRUlkrQ09aK1pzUFN6eXJ0S0FUbnFMRk90?=
 =?utf-8?B?MFdiRTBYMy9BVlJ3bzR4eU45QzBJQzdMOWp2bDRqemNLc0tNOGtGckF3NFhy?=
 =?utf-8?B?UUllR0VDTWt3T0VmQm1ndW9qRCtINS9XMUxsL0o2YzBpZ2ZrTVRKZHo3eHho?=
 =?utf-8?B?b0V4SWVwQk9FNUVnM3pSdUExVkd0TlJTSkRVVTlKT1IwdnVOZ1NVTEZvL05m?=
 =?utf-8?B?clFIWVpWVmJxNXpmZ1NibHVPQlk4NUpJbXlIYk1nL1JnWE16RHdXdnRqZGRm?=
 =?utf-8?B?dC9tS1VWMWh1cktENDNlU1gvR0lJeitHa3BNTnIrRTg4OEhhVXNyUGx5RGls?=
 =?utf-8?B?MW5wT1FjcUVjUnA3TzZNYzVCY29TWit5dXNkcHpVSjk2VkIybGFyb21HSE5H?=
 =?utf-8?B?N3VSeUhPeW5Ja0hrMEFvN0E2ZlpxWnlLY016RlNnR2NOU2lkR2xyUURDajBq?=
 =?utf-8?B?WU1zSWxnaTdmSTErZGh3ME9wNDh1WS9RMERDOUNOeU1XbytCR2VRQnVHRGQr?=
 =?utf-8?B?OUVKdy9wUUZzeFc3S3dQcFRLVjZGZTdTN3ZseUFnVVk2UHpWYlliaHNtSVZi?=
 =?utf-8?B?MUEyak1INGR4NTJPeDlIdW1yRGlsVFFIUnNKMUlRNUcrN2pRWlpqL0Y5aDRV?=
 =?utf-8?B?MFFxZGlCZVJFS2g3NXliRGdwa2Y0bkFvYzUrYzdBWWdtQlZRR2hOWEJmV3Nm?=
 =?utf-8?B?TngxNklwaTNNQjk3N2pITXptemVLSDJMT21Ua0ZJbDg0NSt0REtta2U5ekxa?=
 =?utf-8?B?UDU2czdlRFRwWDl0Z1d1RndLaWQ5cDdiTFVXSE9hUHd3cFBhUXp6ejFuajhZ?=
 =?utf-8?Q?KAg9+Syf4JI/hh5yX91jr6wFqE7Hvo+E?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?b0pmNWNUR25ITG9DM1hkbmJ4cWd3UWNOeFZreU15MG41eFBYeVF4Zml3dnlQ?=
 =?utf-8?B?NGo5UEJwSjVjK252YzZwU1A5ZmppMnFRTi85ME13R0VFZlM2ZUNGS0pqZzla?=
 =?utf-8?B?ZFJ4MjJDTTM3SkF5QU1kT1dMbFZmUjF2YmdSTHFNM2t3SU9mNGFXdGduUVB2?=
 =?utf-8?B?eXdqTjZodEdYaHZCczlpM1FXWVptSHo0Mk94OHR6SHI0Rk5HU0dmMFpYWnBt?=
 =?utf-8?B?bjdjN1Avb0wxeFhUdkRTbXBDSk5RN2U4TXYrb1UycTVUdWo4cDhjMTRwWnFK?=
 =?utf-8?B?ZUQwSThJSDFBRThSUldCbWxqY2grS1RQdlpIYXNHZWdPZGtwSTZzRXZvSncv?=
 =?utf-8?B?MUE3MHh6bEV3VU9yZW5ndU0zV05HckVEM2N6MVpzeUM4TCt5WDFZT2FHbEM5?=
 =?utf-8?B?TjdnNjJ5TnA3cVkvWHJ2UVVKQk1JTkNsM3IrcmNmUml3YTRmMXgzSnZQYnRD?=
 =?utf-8?B?Y3ZFVXVCNFV1UnZjSXYzanUrUnhXL3VPME1EYWxhWndQN1hkNERwR1FLUmgv?=
 =?utf-8?B?VWg1aWxjTytPR0d1Tk1ublBLSjFaY0tlTnZZcHlYUWkvTzJyMjNWOXlwYUQv?=
 =?utf-8?B?ZmFHTUFoQTk1WS8yWkV3b3oxdUpnY2Y5cUZPL3FJS0hydHJmNmRDZURMSWhP?=
 =?utf-8?B?NmJMeXR0eVlSUHQ2Rlo3WlYyMHdqbFFRcXNxOGswY0pNTk03MjExbzRLTDNT?=
 =?utf-8?B?OGhSVDlaZzZMRU9SV3owVkhRUXRKcjlQTkxGeUliQVlHUzBiby8yQWl3WHRQ?=
 =?utf-8?B?eW51OFEyN050eEl5UUVMejJmS0k0RHBpRlNzUFdjUXB1RlVuSis1Ny9UeUkz?=
 =?utf-8?B?UlVPdWZnakdwdVNpVDJKSjFKa2xlblVJdDJobjl4cStRazRRY3QxQnhEYUYz?=
 =?utf-8?B?TjltemNQV2Y3b2ZDR2cxM2V0YWU5ZHlRWXBVcHhBaVl3YWRTQmNIOXBYQnRY?=
 =?utf-8?B?NGx3RWxGd29JVlY3cTYyaDdyTll6bFhWYUkvZTRJOWk5cEhxRWdJMEFJUy9q?=
 =?utf-8?B?SXBrVUVUSlNnMk1sWjhRYVJwaEJ3OWx1WkYzbjhMVlA4MnBXRnJxMm1HT015?=
 =?utf-8?B?YStWdmRUZVZyUUdyeFpaT0pqbjhmblpsNUJSYzB6RXZoUFVFYUtpQ0dSSFNP?=
 =?utf-8?B?bzQveDV0VmdyMXIvSzdWM1ZzWGJaUG9RQ0tIbzE1aVE3WkxBVkJ2aWhzcDhu?=
 =?utf-8?B?Y25WKzg3TkY3NTNRYzhkQnNnTWRWcmx2ZmxpNVdyNGRZS3UxdUxXZllUaFpW?=
 =?utf-8?B?bFVhL2tiVUh2SFV2ZkJWSGZIcTl1Qld2RnpobkpNMXd3YnVyYnRCc1B5enRt?=
 =?utf-8?B?T2ZlbHBBZlhvNU5RVTQ3YXZSOUc4WXh3ZDhpaXpoSERsNnFJZEV0M0VwbGZ1?=
 =?utf-8?B?Nk9xY3paY0dWU0FQYmFvSjJmMmFlYXpOV2d2RFI2bWwyWktRUHVLY05CV1Zu?=
 =?utf-8?B?dFlNQ3FoWm9NcDJ6bW9TbWJ2WU9nWjdFdkxTN0h4OW1JZUFQZVFuMEpIV0dK?=
 =?utf-8?B?ZTVTLzZ4ck01em5ialVKdGhRT2EySTFCQ0tJR1kwU0NtNVhNeDNTdkovUEpi?=
 =?utf-8?B?YU16VERxU2VQRmwvMkIrUXhLSTV4VVZkRlE2RndoaGNLbXcyQXdNMW1wdHJF?=
 =?utf-8?B?TXlXRFpHRC9QYzFsQ003N3d4QmZ2RklMdFVYanBHR3ltOU8vc2c1eGM4WEM1?=
 =?utf-8?B?cnZieFJMMVdDeFNRZHlGMmxhMkI2MjFCMHplUTFqai9TczlsQi9md0ZXaFRz?=
 =?utf-8?B?Tzc1NXlFb1ZlZmJMZDl4RklGU2hoOFhjcVFISzR5Y0NTemU5RkpYdzJrdE8r?=
 =?utf-8?B?R3Z6cDU2ZmJhcWxuZ0JrOUpaWFZVdWJERWQvc2ZNbDh0VEYvNVhLZHgzNjdu?=
 =?utf-8?B?MDNxSmZGUmRrRmRsOUx6Z0U5V0cxcGFOdXJRK2o2S0FmR1hFYm5kazJuUEV4?=
 =?utf-8?B?RnpFclAvVytmR1NJYXhHRno4d1ZjUkVRL2EzRjFRTXVrTDIwc05Wdm45dSsr?=
 =?utf-8?B?anNFQXRtdENFY2R1TzdSSUlncENMZy85ZFpvRFJoMSt0OE5vcUNPVk1jL2Z1?=
 =?utf-8?B?STN4V1Jrd05tUUZkQk4xVWZ4M1hwa291MHp2WVFmdVVNcDZNTmxMZHJyTlNT?=
 =?utf-8?B?SnAxVVdUU21pK0RYaURIcm9DeXNYOWxTRmxCQlpPWWo4OGVZQ040TnZ6SkVs?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VHiiwdG9/5xY7MgTiQpjg3/73QsU/LJkIbocXk7oSxylBTPConKNvfvFtklEq6sS+1/RSrBSQbql1e3Hd2GS6c2OVnSguMUgsbNAE8dCt2yGQCvB/DJvRWx4bcj4GQrRiIIbdhYvOCnvrfEyRpsfwcrFjMJYnOBOFeMri1rOnNEkreVPhb36PFyz35EgiitebPWEFCKY5Yj9B6vYGZJOsvvEdMk5csObKkx8oPViIUgPMD7Jg15+Pnr1xMo9B76R3+/8wK9Mt4YJbPsdGUIi7VUb3MGisRi8O7jPw89ndGBjSlQoRO1meB4ZT04W2lost+gFTEgYqLnAZIuAP75jGye5RhD1aF1BivqntvuG8Nj0zciEtSRTDnEySIogE7SzksWNjG3IwmTZ6hQ1mjiOVnrr/bIlme2xIhWQNUP9uk09gnPp60ZUMOtjUBWzaM53G/XNAkd6N+7QJRQ8R5lpcw2WWzBiqUpl1XXNNUTccI5r+DICGWfSxUJ/qD9Y8U34/RAS0G6G05aVciI5dBgokAnh1lxUO2Q5zi93Tn2n6ZEfiYjjKNQlkGh7dirsXhR30h/D+PWe8D/ORoIXvSJV1GR3spRllH7I50GlyQKeelA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093f2bbf-3520-46a1-e4be-08de27a9798c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 20:23:18.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uxY18iL7CO4Gsgk+6ilYdajUBQ4QGP0HklJO0owIMIvhiXwPiyd52KSrLmhDEJ8tpCZ4CxrODOcs7HMVP/x5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4499
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_06,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=863 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190160
X-Proofpoint-ORIG-GUID: VEaGaR-uZdZeXRSlNW2gwplTcc9Fv0jD
X-Proofpoint-GUID: VEaGaR-uZdZeXRSlNW2gwplTcc9Fv0jD
X-Authority-Analysis: v=2.4 cv=I7xohdgg c=1 sm=1 tr=0 ts=691e2745 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AN5hqa3IWYA_Ywky29QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX5X/6mV/yyysd
 volavXtWAq57ng0yEauHem7rFpOtp3J1vRorW+94QK6+ojyEBn9JInSgS3MgHESNhntBKlqAB9V
 5HJcp5VQciOYRJKgZ98uf2+EU/sy94b04V9UwRNf8lPH6ZvIFGkOWAdDHv029UG0Wem7YNw4bIQ
 XFT/a7GC9AVZLUw2E+O4D81dlcVicxx9KCnlTJ7UA5wP/Wp2wCsRQDHH7ps15aby6EeC6lfTjYl
 5A7UHwqoyN+0+QOg9R3H5KAmIO1GesC5qGg3mU3lyIHyElMQJjMm7s8BGmi5QeBFiP0qSBNf6TX
 Vkv15Dq6dygmFkJLily1+RGete5G6SHwYMazLNlOoeb7lAsqpYtvbmPXfMHdTg9xxrfm0X0gBI1
 DD2uCDwh337S5V9OoWdpWQFWfsDtFA==

On 11/18/25 10:28 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> In NFSv4.1 the current and saved filehandle each have a corresponding
> stateid.  RFC 8881 requires that in certain circumstances - particularly
> when the current filehandle is changed - the current stateid should be
> set to the anonymous stateid (all zeros).  It also requires that when a
> request tries to use the current stateid, if that stateid is "special"
> (which includes the anonymous stateid), then a BAD_STATEID error must
> be produced.
> 
> Linux nfsd current implements these requirements using a flag to record
> if the stateid (current or saved) is valid rather than actually storing
> the anon stateid when invalid.  This has the same net effect.
> 
> The aim of this patch is to simplify this code and particularly to
> remove the per-op OP_CLEAR_STATEID flag which is unnecessary.
> 
> The "is valid" flag is moved from 'struct nfsd4_compound_state' to
> 'struct svc_fh' which already has a number of flags related to the
> filehandle.  This flag will only ever be set for the v4 current_fh and
> saved_fh and records if the corresponding stateid is valid.
> 
> fh_put() is changed to clear this flag.

I don't see a hunk in the patch that implements this.


> As this is called on current_fh
> in each op that currently has OP_CLEAR_STATEID set, this automatically
> clears the stored stateid when required so OP_CLEAR_STATEID is no longer
> needed.
> 
> As fh_dup2() already copies all of the svc_fh, it now copies the new
> fh_have_stateid flag as well, so savefh and restorefh are simplified.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/current_stateid.h |  1 -
>  fs/nfsd/nfs4proc.c        | 25 ++++++++-----------------
>  fs/nfsd/nfs4state.c       | 10 ++--------
>  fs/nfsd/nfsfh.h           |  1 +
>  fs/nfsd/xdr4.h            | 13 -------------
>  5 files changed, 11 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/nfsd/current_stateid.h b/fs/nfsd/current_stateid.h
> index c28540d86742..24d769043207 100644
> --- a/fs/nfsd/current_stateid.h
> +++ b/fs/nfsd/current_stateid.h
> @@ -5,7 +5,6 @@
>  #include "state.h"
>  #include "xdr4.h"
>  
> -extern void clear_current_stateid(struct nfsd4_compound_state *cstate);
>  /*
>   * functions to set current state id
>   */
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index e61b1ee6c8d8..ae4094ff12dc 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -737,10 +737,7 @@ nfsd4_restorefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		return nfserr_restorefh;
>  
>  	fh_dup2(&cstate->current_fh, &cstate->save_fh);
> -	if (HAS_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG)) {
> -		memcpy(&cstate->current_stateid, &cstate->save_stateid, sizeof(stateid_t));
> -		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
> -	}
> +	memcpy(&cstate->current_stateid, &cstate->save_stateid, sizeof(stateid_t));
>  	return nfs_ok;
>  }
>  
> @@ -757,10 +754,7 @@ nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		return nfserr_nofilehandle;
>  
>  	fh_dup2(&cstate->save_fh, &cstate->current_fh);
> -	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG)) {
> -		memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));
> -		SET_CSTATE_FLAG(cstate, SAVED_STATE_ID_FLAG);
> -	}
> +	memcpy(&cstate->save_stateid, &cstate->current_stateid, sizeof(stateid_t));
>  	return nfs_ok;
>  }
>  
> @@ -2954,9 +2948,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  			if (op->opdesc->op_set_currentstateid)
>  				op->opdesc->op_set_currentstateid(cstate, &op->u);
>  
> -			if (op->opdesc->op_flags & OP_CLEAR_STATEID)
> -				clear_current_stateid(cstate);
> -
>  			if (current_fh->fh_export &&
>  					need_wrongsec_check(rqstp))
>  				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
> @@ -3401,7 +3392,7 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_CREATE] = {
>  		.op_func = nfsd4_create,
> -		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME | OP_CLEAR_STATEID,
> +		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
>  		.op_name = "OP_CREATE",
>  		.op_rsize_bop = nfsd4_create_rsize,
>  	},
> @@ -3455,13 +3446,13 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	},
>  	[OP_LOOKUP] = {
>  		.op_func = nfsd4_lookup,
> -		.op_flags = OP_HANDLES_WRONGSEC | OP_CLEAR_STATEID,
> +		.op_flags = OP_HANDLES_WRONGSEC,
>  		.op_name = "OP_LOOKUP",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_LOOKUPP] = {
>  		.op_func = nfsd4_lookupp,
> -		.op_flags = OP_HANDLES_WRONGSEC | OP_CLEAR_STATEID,
> +		.op_flags = OP_HANDLES_WRONGSEC,
>  		.op_name = "OP_LOOKUPP",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
> @@ -3494,21 +3485,21 @@ static const struct nfsd4_operation nfsd4_ops[] = {
>  	[OP_PUTFH] = {
>  		.op_func = nfsd4_putfh,
>  		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
> -				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
> +				| OP_IS_PUTFH_LIKE,
>  		.op_name = "OP_PUTFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_PUTPUBFH] = {
>  		.op_func = nfsd4_putrootfh,
>  		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
> -				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
> +				| OP_IS_PUTFH_LIKE,
>  		.op_name = "OP_PUTPUBFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
>  	[OP_PUTROOTFH] = {
>  		.op_func = nfsd4_putrootfh,
>  		.op_flags = ALLOWED_WITHOUT_LOCAL_FH | ALLOWED_ON_ABSENT_FS
> -				| OP_IS_PUTFH_LIKE | OP_CLEAR_STATEID,
> +				| OP_IS_PUTFH_LIKE,
>  		.op_name = "OP_PUTROOTFH",
>  		.op_rsize_bop = nfsd4_only_status_rsize,
>  	},
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index f92b01bdb4dd..7ffe0b8e44de 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -9106,7 +9106,7 @@ nfs4_state_shutdown(void)
>  static void
>  get_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
>  {
> -	if (HAS_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG) &&
> +	if (cstate->current_fh.fh_have_stateid &&
>  	    is_current_stateid(stateid))
>  		memcpy(stateid, &cstate->current_stateid, sizeof(stateid_t));
>  }
> @@ -9116,16 +9116,10 @@ put_stateid(struct nfsd4_compound_state *cstate, stateid_t *stateid)
>  {
>  	if (cstate->minorversion) {
>  		memcpy(&cstate->current_stateid, stateid, sizeof(stateid_t));
> -		SET_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
> +		cstate->current_fh.fh_have_stateid = true;
>  	}
>  }
>  
> -void
> -clear_current_stateid(struct nfsd4_compound_state *cstate)
> -{
> -	CLEAR_CSTATE_FLAG(cstate, CURRENT_STATE_ID_FLAG);
> -}
> -
>  /*
>   * functions to set current state id
>   */
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 43fcc1dcf69a..0142227c90e6 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -93,6 +93,7 @@ typedef struct svc_fh {
>  						 */
>  	bool			fh_use_wgather;	/* NFSv2 wgather option */
>  	bool			fh_64bit_cookies;/* readdir cookie size */
> +	bool			fh_have_stateid; /* associated v4.1 stateid is not special */
>  	bool			fh_post_saved;	/* post-op attrs saved */
>  	bool			fh_pre_saved;	/* pre-op attrs saved */
>  
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index bcaf631ec12d..b6ab32c7b243 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -43,13 +43,6 @@
>  #define NFSD4_MAX_TAGLEN	128
>  #define XDR_LEN(n)                     (((n) + 3) & ~3)
>  
> -#define CURRENT_STATE_ID_FLAG (1<<0)
> -#define SAVED_STATE_ID_FLAG (1<<1)
> -
> -#define SET_CSTATE_FLAG(c, f) ((c)->sid_flags |= (f))
> -#define HAS_CSTATE_FLAG(c, f) ((c)->sid_flags & (f))
> -#define CLEAR_CSTATE_FLAG(c, f) ((c)->sid_flags &= ~(f))
> -
>  /**
>   * nfsd4_encode_bool - Encode an XDR bool type result
>   * @xdr: target XDR stream
> @@ -194,8 +187,6 @@ struct nfsd4_compound_state {
>  	__be32			saved_status;
>  	stateid_t	current_stateid;
>  	stateid_t	save_stateid;
> -	/* to indicate current and saved state id presents */
> -	u32		sid_flags;
>  };
>  
>  static inline bool nfsd4_has_session(struct nfsd4_compound_state *cs)
> @@ -1030,10 +1021,6 @@ enum nfsd4_op_flags {
>  	 * the v4.0 case).
>  	 */
>  	OP_CACHEME = 1 << 6,
> -	/*
> -	 * These are ops which clear current state id.
> -	 */
> -	OP_CLEAR_STATEID = 1 << 7,
>  	/* Most ops return only an error on failure; some may do more: */
>  	OP_NONTRIVIAL_ERROR_ENCODE = 1 << 8,
>  };


-- 
Chuck Lever

