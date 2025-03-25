Return-Path: <linux-nfs+bounces-10870-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C64A70B64
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 21:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71D4189151A
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 20:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8E523E35E;
	Tue, 25 Mar 2025 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CISbtRv9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P0SHKRYR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646AE19CC34
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934084; cv=fail; b=CIoMpiyIOkZ9w/Wg/92IBSr1s1lJkcRmc/JBsqKhYuesOqbmfs2pDrvH8b4JjEEn5rx3wz2rBVN8EP40lU9EFgTFcnarV3ff2NnUE//YFEzbvY1d4/N5jdfUKeKvfU20NVSBCBQyHJb2IrmDpr4iLFINEIj0IhzR6UpctiWauK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934084; c=relaxed/simple;
	bh=k6lbTH2OQCnlfhcOhlNY1nfnQzQR8qh9wQGSMOrL/fU=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l5avE/5a8MRuDGkaknfER5uyMx49Y8qWJpXqBGXJioWQN6gOsocv3w1/JU/8R9l9Rv9gLTvM83UfZi1uApcoj06cXuf6js2oykTxmDyvLeLEn8hwIhZE1XKUIjgLxi3iFF8sI70jdhvUtZi2Y9JfM/CiUQyyXnUL8/z5h4nupag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CISbtRv9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P0SHKRYR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PJXqPi012177;
	Tue, 25 Mar 2025 20:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9plM2xws4K39DgPubmdSDrUMqSopy8TCh5cQbc9El+Y=; b=
	CISbtRv98GXythsvhMlUF9IOMLApvWOzpK8vwouJkez+XgRBf8HnGaqsr+Vg2U/5
	FvWvOV1ZzJB/p0+cCO0WNzU6c/+S+OFavrslI6ygQE/zqHuiJrvxIQ+V7vXwfaoH
	Zs36Ag2yd3WlayboqyhZciJFRNzhrrNfGcQd1dnhacKVGzByrtJVNYopWpX0rBqq
	c3pbrC91kvv9uyHblV8Cy07P6x1u8BZgB57/I1Ot3gg63ATFhaBim4zdxjqL1rQW
	7Nip08sO2VqTEP6q4y/aO+ABuNLwtlkBHDt65LX199P2Cg3eluVAP4Ukjn7Z3xZW
	k+AZfJnBNfh0ARQCsflbPw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnd6805t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 20:21:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52PJdRsj015144;
	Tue, 25 Mar 2025 20:21:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj92ewrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 20:21:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROitWikqDgjpIwTwYW3w3qWZJEs7plo6l6DvLGEJETS+In6jUkOa5a4EybXFQgOLxcsSZ5zeeicVp7OH4TEMZjBHkPA16l9/yPEUupUWatfAEckLQce4XOnmVlmr4qKAoyMhnzmTpuCdstYTohdtGlaWCrAKDZyc7cOszjFzoc3ySmFm/D+z0vNPJAnGDKgvmosIx/ERoJYPVQFCOOnJ4baaEJBEYDn9EiX/9K1305R9WRAuolt2pcGWU4nC3r3JZtP5P7UgyVWBgLRo2l7WBzaz020vVw7F+yZIg+Ixov8cjbg05tjN+lWU+kwVioHZTMM6e5OgCqnm3XfCMUsGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9plM2xws4K39DgPubmdSDrUMqSopy8TCh5cQbc9El+Y=;
 b=NAgyGCS1AqQhBBNEpxUyvw+M1OYrya/Z9Y+1WQhw2BGCXH1rYwXgiJdPXtmZ0vjM5AihR1L2pId1IuweXAt2qMvj0ePoI7xtHFEW0cZHXHejpqOiQlCeqIh1HqvunCJnFP1J+ufaZQYUGXdR3gSNsAts8VQROk5ZhtTRpaPEPPqMndY/pHbObV5FZc1od23KWykYj2Sbdojnp/BIFIF/CkqV3kBQt5/0K8JeRWax2JSRlO4p1DFq3joA62GvWWmHz06G3qPaDXa7NfSZ6P8uMofff7TxpyD4/jOPDrkwTUS+9ieWsHaPD4PwiqNX1pgVT50xnRBiU7T6OyVuGhaKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9plM2xws4K39DgPubmdSDrUMqSopy8TCh5cQbc9El+Y=;
 b=P0SHKRYRnV5lSnnAtuBXUcqoZ8PA/vRpYCTL5k/zmi2fnIDoVTyZhbbTQwAE5R4JmyR5HsTnn0WXv4dAuiMTcZ6hTF5Ds/GdaAel/1JrBzFUVjBssIukk3u6+OKFlVWIf+1raNxluw4eGsnjTzHODXJ3ZqPFZskvefmNEH1tiGg=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by PH8PR10MB6551.namprd10.prod.outlook.com (2603:10b6:510:225::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 20:21:17 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::783:503f:ea07:74c7%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 20:21:17 +0000
Message-ID: <2dcce01a-dc4b-4e0c-b652-dee46eddb209@oracle.com>
Date: Tue, 25 Mar 2025 20:21:14 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] pynfs: fix key error if FATTR4_OPEN_ARGUMENTS is not
 supported
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
References: <20250319032402.1789-1-chenhx.fnst@fujitsu.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20250319032402.1789-1-chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::21) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|PH8PR10MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b7ced0-2746-49a9-dd4e-08dd6bda98ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDRuUk9ndjRyd3hic1ZsMEoxbkhNTHExZ0N3S0x5eTNNclZSQi9uak9ybEth?=
 =?utf-8?B?L3lwODlZMk1pUzJJcXNvNDcxZkZsaWNlYWtsOGlkVnpOUlVBa29HK3FwS29n?=
 =?utf-8?B?aXVhOE9scVhwVU1LMjJVNEhPT0VMNk5PTFhwRDZCOTFXcnZSNjNGcEwySW9j?=
 =?utf-8?B?R3FUcjBLNVVHdWxESmJLcmdlTHZ5UWsxV0JwWmhJWGNJZ2V6c3EvNkd3WXFF?=
 =?utf-8?B?aWIvNlhSY1orVU5VNzR4RlVNZnRNS3ZGZ0pUckRob0ZyRS9LTUpLWmwzQzdO?=
 =?utf-8?B?VGwwMzJqa1RGdWNGTGxKRU01bllIT3JPak5aVFhvWUtGK1VWSEEvb3dOcHZF?=
 =?utf-8?B?K0JIZmR5U29jbGx4SFViOTdoczFLY0svTTVuMHU5S0ZFU3k2Uys4VTh2TDZ3?=
 =?utf-8?B?WFkveDhheEVJQ1poV2t5UmpPWnYrNUNsTkVYekEzSVRFb1JaMEwydXlLS1lV?=
 =?utf-8?B?S3ZhNFIxcHZNZHN4a3diVENKUGFZRUdRZGl1ZFNRbStCbFdKdkpSOVBPRFMr?=
 =?utf-8?B?eXhYSzJzb3VMOGx3RUtnVVQzbVVseWlXOU1HcFYzaU45bVBmSXk4ejc5SzVr?=
 =?utf-8?B?MTdWTWpQRFlRZ3h5aVNHQmtXWnNidlN3NmxFN1F6ZGhES3ltbU8vRnZtSUU3?=
 =?utf-8?B?ZlAyOVM2NkxoVXBTN3Z3ay9TK3FOWEtxRkFGKzFUWnUraVdoWEFxMXpVRjJS?=
 =?utf-8?B?aFJQcDJPanA3MkJtT3g5RlRQbk5Pc3VWbUF2Ylpsd2gzNXA4cXFpMVRwOGg1?=
 =?utf-8?B?NFpEOUdIT1hZM1JTQnkxc29PeE8vZUZxMDhmQzVrOUphZmlBWHkxVU80dVlv?=
 =?utf-8?B?d1BnVmVzaXk5TXdCUVRRNld1UHlocHVaSDBYdmxka0JGVGVidWRXcjdVZ1d5?=
 =?utf-8?B?eHF5KzlPZVZJbERPdE9sOTlUQ0wwdWI3NGdDMlE0TG9tR1ZrNzkveE0zM3Fn?=
 =?utf-8?B?b0JCS05JUVNWVGVxQ1A4NDVTVmE4Sy9Fby9vK3ZmTkVkaGxpV2hybXluRnMw?=
 =?utf-8?B?VzNIZXVDWDBHbng5MWU0aTRkd09lUTE0YUJmQkp1T1Foa0JFRU9sSDhLY3pn?=
 =?utf-8?B?alFkdHZHQk1NSnZKb0ZaL3RTZWE5YVp4ZlFLZXB3UWdxbU90RC9ZWWg1Rmpy?=
 =?utf-8?B?cEQ3bElsTk9uTXFmcTJJMnIyQ3lMZjZtZmh3bDJjVzRtNWJUWVltenBuZHpV?=
 =?utf-8?B?QXRsQkJVci9IaXA0NGE5Y04zOVNxZDQ5WXE4cjQrVzA4R3Y5bEdBNTFkbnk1?=
 =?utf-8?B?ZkZoN3B5ZVBBNTRTTGY5U01BL2xucE51czk5Z1ZDdmxTVHpVWUZmYk5jNEdi?=
 =?utf-8?B?QmdmYmt6MGVkR0ovaWlJWExJREU5Rk5KVzdLUTNraGZOazF1ODdMNHBNTkps?=
 =?utf-8?B?eWdBempOdnpKN1cwaXdrYS8vZlNzZzBkZ3hTQStFUUU0bnFBMWMrbzZSUnJq?=
 =?utf-8?B?U2w5QVRiZlpVVE1lYWFZb1RhMVc4bzd2ZlRKTDZxWVc5dXo2eE90UFowUmhy?=
 =?utf-8?B?ZlBxeUhPZE9SYnpDVWdJQXFxMVBxZkNNWS9IRlJESXdUeXlhQjZrS3Q5UmlV?=
 =?utf-8?B?dUgvN0FncFk3WGZDYmlYMEtFbTZCaE1Uei83RVJwbmdwRkpPVlZ1UE1xMGFs?=
 =?utf-8?B?MTArV1NEMW1pUFhSSTZydDJ6VkUwbUp3WTNMQ1pvM2x3dDcrVjV4eFJna0VG?=
 =?utf-8?B?dzBsdzQ2RmNqSkhEM3dVY3AxakR0NTd0UlVhZWNxVkU1emtvSnh5eUszVGlx?=
 =?utf-8?B?cHNxU3B4WThkN0FLSTkxTVh5R2tXN213Q1FTMDdtbnRQMjE1TzhaZVErUVRv?=
 =?utf-8?B?eUc3b1lqNGkzQjNPVVpEY1lHMHFkQnhQclFLY1FkN09LNDRENFFqdkxVVWN6?=
 =?utf-8?Q?+Bb3ui8fZCcVO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjBQbkUvNlNKM1l5ZndjeUhnK1RNOVhDdGdoSkF0OFBnN1RQZjJqNTYrdUE4?=
 =?utf-8?B?VlJZUU9lYmIwMUJQUjBxTEt0TUcxU3IwdjJDRXdUQWhHeUlLVkJqQlhYaVkw?=
 =?utf-8?B?cmdITTQ0VHlraW95OFVrOFRsajJUN1lBSDZJcEMrV1pwT3ptcGdVUFFFbk93?=
 =?utf-8?B?R1o5Um41OU1zeVhEYTk5YzhLbm1GWkRLelRhT0dQdllzTmxPK0t3VnpsK1oz?=
 =?utf-8?B?YmluVFBNTXF6ZHZ5d3lqNmVKQlAyTGpnQUx1bnNjT3V0STVsdDBPN0FiTTVk?=
 =?utf-8?B?SU5Eby9reENKR1l1cXNpTnRCUFZpMWVrYTBubytrUHQ5azBaWUtmaWR2U0JJ?=
 =?utf-8?B?SDRWM2JhaklOM3VCTFJHeGg2ZllTZ0UxYitxYytYVzRRWUoxSFY4Q1czdGt4?=
 =?utf-8?B?SWV3UjYvNWh0eU5NL2JTZnNZY25vZlEyekV1N2JqMUNDMi9Od0g4blFMUGxp?=
 =?utf-8?B?b3kxaHAyNE16UnVNc3l1bnpvQU5wSVlrRnBSb1o1aG9QU0ZuR3dSaFlYT2Zm?=
 =?utf-8?B?ZjExVkNqTWt3MmNLbkxta1Y4Z2wvUnR2bTVZMnlkcUpiUGVNSm5RNzNSMFhF?=
 =?utf-8?B?R0ZtdDZ3SmdweXFHVUIxZFdxWW1vcUhvOUxxM1NFMHNZV2w2akxVRjJ0bTZR?=
 =?utf-8?B?MDBrOUMrbzVadmlxbCs1VzM2eUZlN0x2UlNZblR1N2JONmNNS1dCbzRwdUEv?=
 =?utf-8?B?aTg2Mk53WTRPVWtVQWlRd0dwRnV5ZHE3OTFkTXlYN0FibDdOamVSOHJpWWZk?=
 =?utf-8?B?SklZaDNaZmltQjF5V3VjcHhqamRNblJMb2V5amx0TEYzRmQ5OXduZFVlU3Fp?=
 =?utf-8?B?WlppeXpUaG9keXNrSmNNMFVYTmE1VW04Z014cXFaMDFJaE1rVWhDRmNWdFQw?=
 =?utf-8?B?NEh0ajVKaGpUKzVNYWZ1QjNkbGxNZ2pIR0lWU3Z1NUhPL1l4bEo0aEducm9D?=
 =?utf-8?B?WWxkdkFEbnNGQ0tuV1FCQURnZW42RlRkd2dLSEVhTWIyUU1zWlp5KzJ3Uzhw?=
 =?utf-8?B?NlpMN3orZkthWWpudVJNNG91b3czREduRE9jQWl0cHQyenJ3Z2haVCtQUlky?=
 =?utf-8?B?VHk2WUFOa3ozbWpBc1ZOcHNGd3N2MmEvazNwVFh0dG5WWWhKYjlsK3FyNDNL?=
 =?utf-8?B?OWpRYk1uaDFOOTlXS1ViaGlrcXh4WDFNcWZ4QkowN0xjZWFVZU56NjZJanRR?=
 =?utf-8?B?QTNxTWI4UUNvTVdrUkFqVE1XRmZhb3AycHNqWU1GVmQ0QmEzV2d4dzB1WmNL?=
 =?utf-8?B?T2wwcHA1ZVJMV2Zwb01SRzFCclJwWDIyZFpnYmp0eEV6VmVObXpCWjRvbERy?=
 =?utf-8?B?WktQVGRBRXpYcWUwZ1ZFalEvN0RxSERpeDhRNUs5bGhRTXh4ZUR1RlprZUdS?=
 =?utf-8?B?cXFIQU90N1JhUE00OFRKcWUrbUpJS3BaRDE1UGVZRVY5VnI2ak0rQmFvTHpt?=
 =?utf-8?B?RzhBNXhBZWorTGFhVHlBRlFMNzg4RkNpalJZR0tubFpZcTc3cmlCd3U3STI5?=
 =?utf-8?B?bHhMVUJodlhZMDBEVlJnK3lHdVdNQTRXSGFYRW1sSDU4UCttcVZIUlpWdUpS?=
 =?utf-8?B?UFVobjh5eFppdjBlNnpoa21FZGgyTGZXRmo2M1NMbllBZmVmc2lkcjN5RXhT?=
 =?utf-8?B?Y2thMHE0Q3l1TjZQV3hEZUlFUW1vTGJrUkJYbFNBQlAwUFJxeDNIMGtkeVJ2?=
 =?utf-8?B?UnM4N1lwc2hkTE1wVWtqT0pla0VvWVhtR3pMTmRyUTd3V2VBSDZ3TnBqdnox?=
 =?utf-8?B?d2JOOG9PdWZJZWVhK3g5cEkxdGlJL0ZKc3FDMnVobDFJeTJQempWYng5MSsy?=
 =?utf-8?B?THFXU3BmQUdEaHIrUUsrc2lwTzdZMXBTSm5RTXJkaFhCNmRVSkxMY0V0RkVU?=
 =?utf-8?B?YzY3TEJYSHlJMUJ4cnhvbStCaXlVUGI5ZU5mdk1CM2RWVlM5T1dscmFhZXFF?=
 =?utf-8?B?N0dGeGkrRkVDMGM3SEVmdEt4aHppRnpPQmxJeFdveVdLbkVIRllQR3pXQ3RF?=
 =?utf-8?B?c3k3MW8yWFRFYVBmVWQ5UEMvMGZWY3ZpOUFzSy9JYTFGQzlKUjVRQnJpR2VC?=
 =?utf-8?B?dGx5eUVDNXhBTG5UZzBPdDl1TXZGcnZSZjV6Q2pZeXRjaDhYL2gyWTJiaDJo?=
 =?utf-8?Q?y75I2bbzbSYyTgymETzxHlmC+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JDEcUfZm5kNO2tBKzKI+lFdFxSsQ6uXqJ7PadaJ5oQdve8wXb++HW+iMa8jq3tNlgJ68WF1IoxhVGF7oxvhA8InWC1Q9B+NkTJE68J4MpUx1SA9bkIOj/INyaAg0e9jSet9RYSRMN07B6yhOHrPo79/1ZkCh6bniDycuCsMiAtitkrtFHGeuKki/cwU6ufLfXWS7nc3r0rTFJT5W3dT/v80MuXDtTvAy0ga3Ir1G64+DZ5QBHZqqth0TH/0IAowpicO8+OsZh3NcPTItsgDaXPgqT36+mD6Q/56u0mPcxRCv2SO3Hm3ydld7NtmjNZP2iwHvUmey1JyAKxWaOrJ1zSHXidQSymssA4+g7KL6mW+zKEl4Zrblb3lCWPximZRQHChKyI8v/msA5RhFOHlda0bMLryttrPAEj7lLErF18JZiYoy6cbSSEt2uQq/VesPjPrtPQD1/kUKodXqKNtLft3kS3XOYcz3NJJtddmLiS1fSR8GzzvD0dRpEGh1lo8HlyVFhIDQSIqFEhMzn0nqqi8OO+wA9ZQE0piYcnoaLH0IUHwGTyHedii1nD+Fuh6oUeeTKFw5KDHkXKnCxuBk8lE0m7npAF0VBEu/f5+xCD8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b7ced0-2746-49a9-dd4e-08dd6bda98ed
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 20:21:17.1723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDPze3hmblDZdlkO9OxpHoN5XgyiRz1XarVWqQx/VRI47HX0tl+MB6dmPYpFPKU1pNPdy/a75RVI2C2Wz71CDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_09,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250136
X-Proofpoint-ORIG-GUID: P_ujgbfBGp_HhToPPBa9Ee100320Ut81
X-Proofpoint-GUID: P_ujgbfBGp_HhToPPBa9Ee100320Ut81

On 19/03/2025 3:23 am, Chen Hanxiao wrote:
> If FATTR4_OPEN_ARGUMENTS is not supportd, DELEG24 and DELEG25
> will throw:
> 	KeyError: 86
> 
> Check FATTR4_OPEN_ARGUMENTS in caps from server

That's great, thanks very much.

Applied; tagged pynfs-0.3

cheers,
calum.

> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
>   nfs4.1/server41tests/st_delegation.py | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
> index fa9b451..f27e852 100644
> --- a/nfs4.1/server41tests/st_delegation.py
> +++ b/nfs4.1/server41tests/st_delegation.py
> @@ -311,6 +311,9 @@ def _testCbGetattr(t, env, change=0, size=0):
>                   OPEN4_SHARE_ACCESS_WRITE |
>                   OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG)
>   
> +    if FATTR4_OPEN_ARGUMENTS not in caps:
> +        fail("FATTR4_OPEN_ARGUMENTS not supported")
> +
>       if caps[FATTR4_SUPPORTED_ATTRS] & FATTR4_OPEN_ARGUMENTS:
>           if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want & OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS:
>               openmask |= 1<<OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS



