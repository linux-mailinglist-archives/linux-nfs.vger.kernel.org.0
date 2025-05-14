Return-Path: <linux-nfs+bounces-11720-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1190DAB6BE4
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 14:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DD41894B9C
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 12:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF67225795;
	Wed, 14 May 2025 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pMKJphB2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DuppCtgj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4AF1DED49
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227405; cv=fail; b=pvr5appm24Zw9Vs7z+AZhuI29P5UnFKvVfTUvPLNBQ1xQNB2JBPs5p3vdvbOJLJ1gclG9gMhrHSlPMuHFWSsNsR2Y+RxirBktDgjtUrlo4f7z6Gs3RaNXU2315oHLfNiGiz8bCy6drL01XkWwjkT4BhJ2SWagpW6t61I0fgr5hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227405; c=relaxed/simple;
	bh=J2MZkqbUPMVb/DFHCuDB8Iy6Z7xqfe7rjZ7k1yQjc2k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BY3jcSn8Cy+J+Jwrptq/kc6jGUcEt0Ng0w0yIDOeYNORVBju0BPcJvyxl7AtpIA9a13d6l3j7/1anG5ej+Ax3sC2yPBfGBb/mBV/hU3n5w6AaEGXB+JsTyL9WGiH41G1DXOeUvrndn/cfZ41dBZh1uXjKr/LBG4zUNCkeRUVSv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pMKJphB2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DuppCtgj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54ECc8fE002505;
	Wed, 14 May 2025 12:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3pfDuDQ2sJCCrLTalX5y7GbfFafyEYVUbcm62VvvT+c=; b=
	pMKJphB23VKUw1GKwsIHYHbJ9b7bDXz1ZFaOWhCVk2/re5+DOmacxdZ5UAXL94VU
	ERdVldd4YwLWLVA8AvELQwhbWbGRnbD53yBGwW8qZtwbiWy8eUdOuMbmWxQ4Gjd6
	6MB3LSF+SERx+KEfL38KN2hbivMCH5gQkXJM1xW6WtIcDG2yX0fSTEXnq6dxQoGR
	ob51NC0RIZH6xxfizdUGDGtPl/CoK/tcTWSgBqNQbh73+CmiVu8vGnuT7eKGUvuP
	QZao7q9BahlLmr1UEl4kBy5rNjOZ7Qa6sdfWwjgbirllP4zdkGTJjIdWHhP+OR4p
	B8I7newxv/dbsFjhBwumdw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcm1hr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 12:56:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54ECnTWm026160;
	Wed, 14 May 2025 12:56:33 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010023.outbound.protection.outlook.com [40.93.12.23])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbt7wywj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 12:56:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8NBECiv/MLL6qM3jKdp24CkHTPLPbXm3HxS7pdNhl6n9oDMXReRaT9YMcktIn8XdXFwxq6Bj9c0kdWY7S+BeycJnvi36bbB8MdooaUMFU/9oZ30kFSJ7vB0b4gbSOXmKEEaqjrFtDMTYpyb3zZSp6OBgT0wbnUxSL4N3ZUX6UE7va+cZAStP5KuObV4v3UA5XAyOI7TSAMDeX6kcL/a7MR39nsU1kiMEsvdngSPOIrk4q9oKpXmCKzXASlzavs0cxR0mHyO0rCZZ1dCijNGBKCke4Os6CMtkH2ZSS1+vuK5Y7jV9PWrGhybQOaqW+ErPYyZ/xtBLruDxjF1e1wQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pfDuDQ2sJCCrLTalX5y7GbfFafyEYVUbcm62VvvT+c=;
 b=LG1zeDtbFOaxsTfDX274lLXW0tzgz27TL6Sw0eH50LBrvbMW4ZbtAEHdeTR68XUeptzgN1BQPtnbih8xV//r/aGGQWBQSYvB+eQkj6+8UbsKXrkNccjbFKKHvLGGnzjaPrrkQDcBAeFFDrbJFlOqi3bGENKrJsS2t96SdagTEq20fPTTW/SnlK5MDnpEjpVtTQzVmiwnRuyUcfXTYKOqN/GaDWlevOU8/7tEd8iE9yuz0B4/LKvb+FaBO7VKDJ/5ST3E37DS+CZAKimijysrdtvfTImtPCUdqcj+rhJ4HON/l0uYd1b/27bGalgkgy2SfZL27Y3jgk5WcuJVg78nEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pfDuDQ2sJCCrLTalX5y7GbfFafyEYVUbcm62VvvT+c=;
 b=DuppCtgjW++kOad29QWKlNTRvHaySHd/md77cnf6OlG6WZsJ8JkeiMwURHOCdM7lLDhio54MIVLbu6XcOQvQgYGwC9MpEO5mJBRx6tQNuivt+6r3Vx9q0YkAtKBfAngrFxVveeErQpMhGZaLdAkQaM/wqKMvVRSvnHPwAoKxYCk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6762.namprd10.prod.outlook.com (2603:10b6:610:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 12:56:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 12:56:30 +0000
Message-ID: <9a75be59-fd60-4183-8853-f7fe541c4f14@oracle.com>
Date: Wed, 14 May 2025 08:56:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all
 exports
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>,
        linux-nfs@vger.kernel.org
References: <> <91b04852a612c651533c62f6f9fc4bd61e97be62.camel@kernel.org>
 <174722301596.62796.971181010409022860@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <174722301596.62796.971181010409022860@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:610:5a::34) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d3b948-52a9-4d66-278a-08dd92e6bf41
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WG5Ub1NwTUhMWGphaFBJRllmN0pQN3d3emd2d0FXT0ZiREtXd0hjdG1oT2gv?=
 =?utf-8?B?b2FMK2g4Snl5ellTejBDMzg5a3hFUGZVZk1xRTFPQkRNVWY3aW1rSjJoeU0z?=
 =?utf-8?B?RmVkazNRR0drNDJvZFRpMjhLUDlCNXpnQStFVkNGa2lIRTRZSWluMytVSnhU?=
 =?utf-8?B?VkN0dS9WSzQyS2NmL0VMeUlDbWRvelhhZ2hWNUV2R1dMSnBnWFRaTHp4QTBQ?=
 =?utf-8?B?YUNqR2NCRkVCTUM0bC9Uc2ViUzBTd0xUUHdBL0RYcG9taXF6SFVCL2o1VCtn?=
 =?utf-8?B?Z09CNXJNTFE4U20zMWdjZlgzZXdQSko5eHpvMXcxZU5tRUJNUWkxTDk3anQ1?=
 =?utf-8?B?WEJQTFNOWDM5SVZUb3FLeGpqdHNhLzRCMXhyLzVtRmJCbWRrdGNiaFFWOUhv?=
 =?utf-8?B?aHg0TGVDOVR4WGJydVUxS1NtSU42QkRPQXNpalFjQ2xxOG5zK2xoOHZOUFlx?=
 =?utf-8?B?d2JFcUI2OTFHcG5ydjNKcUlmRW9lUUx2eHBJUW9ZTXM4YjlsdHRKc2pLRUlM?=
 =?utf-8?B?d3FtZEhraDVnUnNUU09uc0FlV1ZjRk94b0xnY2FWS3NHc2pqTlVRMEVWaWhT?=
 =?utf-8?B?T0l5L1Y1MUtLaVdDRnNjQ1hPRk15dUJJNHp5SittODZsazhGVU9GSytlSDZy?=
 =?utf-8?B?aEZ5dE1SZERHVVZ5R21BQUdGOXlGYlkwU3RDRnRoOE11RHFXWWNEU2pqN3kx?=
 =?utf-8?B?ci8zR0JqUzBDWko0cGVWcEpOa2djbU53QWVVSk84TnQ2LzROeXk2ZHArZXlL?=
 =?utf-8?B?ZjZOb01lS3Z1MkUwRzZ4SXh5dW1lbjFsQ2phdzZFcUpEZVZIOCsxZ0ZKaVlx?=
 =?utf-8?B?YmpxeWE0ZVBwK3diVzlJS1Fib1c5UE1KVFh4T0xyZEhoM1JNem90ZERyNTBZ?=
 =?utf-8?B?S3EwNlEvNjBNRmNzNzVEUjBtdUtOZXZSa1M3WVhaU0hYSW9PdTFnYnFtUWZF?=
 =?utf-8?B?SUYzQzE0MFdrUTBSa3FRRmdPMGVoODdHbTZZcjd6bmZ3YzVvWStQdmQrRkJr?=
 =?utf-8?B?ZFJlTGlFaFFaeU8wejNxOEtPdEFKM01zM0Z4N0NTWnZNa2RVelF4ZndGUXZH?=
 =?utf-8?B?MkpQb2JqcE9zUGt3d09UNVByTDViK2tDRFAycDNTTlRWUmVGSUdmbUt2cmpE?=
 =?utf-8?B?MG9VSE1RYVFhUk41YXFLajEvSjBmQlNtYm40b2lJYmZFcHhtSEordCtBeDFX?=
 =?utf-8?B?Um5sZWVKQm8xcTBwVG5wdG0zYk1UVzc1WE5kOUt3M0FydUx2WEhWdm1YdU1R?=
 =?utf-8?B?NmhNNnA4SlIzVmVOWFRjUHhob2VvdnNBMi9iNFZZaC9ZZkpJYXhNWXVBTUQ2?=
 =?utf-8?B?b0dMUFlRNklDSWZjVFJkbmdtZHhZMTMxS2ZkUWRybk9WelVWTENZY0x3RC8r?=
 =?utf-8?B?cnlUVGorWkpkRnJWaHJQYU51SnRRZERvZjZ5MVB6ZTdYWEh1SXh6QmhMb2Fp?=
 =?utf-8?B?YXQwU2UwYTBHY0poSzR6Tms1bzVXQ1NIOTdlYnVYYy85dXNIZGJmWTRhYTFZ?=
 =?utf-8?B?U2hWMGRXekRjOG9ueldaYzNLOWFRb1RaaWExTmZ1ZXR1Mnh6OWlLQks4RXhk?=
 =?utf-8?B?bkJCNzE5WFU4NlRpZGY5djhEOW42MVF6UHoyK1dLeS9zSTRiZnFYWFJMaCt2?=
 =?utf-8?B?TUtlWTR2V2RQeFkrUVNsL0lsUS83NXJvN3loMmZvOVRvZmFaS1BTenBCazlP?=
 =?utf-8?B?TEdKTUphL1hPR01UTXQ0K3E3RnQrNnJvNStjVk9QMmErQTZIZzI5R2tlSVpi?=
 =?utf-8?B?aEU2QkNVYVYzTkgzNkllYUNjM0ZGVWRITDh5UWNZSVF1amFRY1ZQaC9qV2NN?=
 =?utf-8?B?QWpURkJOWlhaQVU3WXVhYmd6REswL282dTNnYXZKMXNvNTRGWFFZazlreUZs?=
 =?utf-8?B?SEV2MFNJRkYzdmFqRForVm14TFdtaHRCWTV1NXNhclo3UTlpeWtyMkdTUkFC?=
 =?utf-8?Q?DbxSReoVSiE=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NlBDa2Y1WGw4TGhrMnFZaDNsbEtlTXpxTTU5VDBxRUZ6SUtzYXFKU2pYbXZv?=
 =?utf-8?B?aEFkTWl0VktTdDBCZlpsdFlrOUhZdGZrbld1OUw0SjFSRGpPZjlCMTJHemdR?=
 =?utf-8?B?UHFzelUrU2NyQW1lV3kvOU85bFNRQnBVMFFNVk11UjFZRFE3T3lNSG95djZE?=
 =?utf-8?B?eXVVaDhNSzJtampsYXVMSW51ck5YZkM5K25uc08rd1l0N1RyeFl3SVNBQy9a?=
 =?utf-8?B?WWJlWllLc1llMGg3Ynk2RVgrRHlscW1MaTc0cEN1THlGWGpGSkJIVTc3cFBj?=
 =?utf-8?B?S25pK2d0bSsyaVZXbGRLcW9Nai9rMDdidFl4QXBZdVNGQnFDK09mS2ZmR2J0?=
 =?utf-8?B?TE5ZUjNRdlJKeEFRT0szNENER3pPcUlYSm9odERRTlNKUXRXOEpIRnNBUGFM?=
 =?utf-8?B?Q1hFSzl1aFIybUg0TExXM200K05HOEthRDd4SDhkYmFwNzhnaTkxS2pudFl6?=
 =?utf-8?B?aFFTNUNDQjlFQUpSbWx4TjNVdDBrMW5nam9wTkFCOE4yRGZjYkZCOUlrLzg2?=
 =?utf-8?B?S0tFbWprMkZHeVNaL2VlV3VxN1JacmNKdXo1OW92YWtVTEp5U3B1aXJrSzRB?=
 =?utf-8?B?ODJTeWo1QTNWVXRoNEp1cWdLR1hLdjlLNjZqai9rbi9QdTQ4UDV0Y1pmWlds?=
 =?utf-8?B?U0xWRjQ0NGxMM1NNNnJjQit4Vm04dmo3VmY2QXM3L3Z4VlNxeE00L2ticzJ2?=
 =?utf-8?B?TVNScGlIMGFUcmxUQWg2S1U4cHZpb3JtQkhtWldxU0MreHZPclJOTWVHVnRH?=
 =?utf-8?B?QnlsYWlYZUtKK1F5U2crclF4akd3eWVNMUVPeG1DQTVuYkdHN1MwWTZlZTdS?=
 =?utf-8?B?ekdNdUxPbjNpTUxUUHZabkxwaE9ZaGlRdjdSbzhzZC93Tng5bFR0eXMyRzl2?=
 =?utf-8?B?WTk4UjdqdkdLMXBFcWliQTRTMmVscWYvUVNNNTZ2QlNIeWFtMDY4RGZwaVkw?=
 =?utf-8?B?ZE5NV21ac1h2ZDNHRmdwMGlhb3BmK0hnSS9JbmFiTWY0a0xjdHJJOVhZVFNC?=
 =?utf-8?B?T3ViTllKOUFSOWZ5VjYzK25rYkkvWEpqbGxYUEl6V1paYXJBc1M2VTJOYkhL?=
 =?utf-8?B?aFg2Q2U2Y2srazYxVFBENW1CNDMvYWhIN2tUYjluaWQxREd4VVE1T280V3Aw?=
 =?utf-8?B?QjhXRDlycG0yZU9MNlZhVHhwY3hXR2c4bUE2Ty9hWkZsT05GNDc0R1NRVUNG?=
 =?utf-8?B?MWVudHRLMHpPSXgxV3VTdGlmQmRPQy9sQ3RrRnQzQzNoc0taajZQSWc2SkhE?=
 =?utf-8?B?alRlV0wzZ1hLM1UxT3BrSkNGN0hON2dMUFdaQjZhVGs3OW1HNEg1Q0xCdlhp?=
 =?utf-8?B?UkhUTk42bTJxUjdVcFN0Vlp3dGlTYW1HNWZXcnZRekFNR0h6NkFQcktxc1lo?=
 =?utf-8?B?U3hTR3VGUWQvZ2lYYXdPdDlIQzVxVDZHdmhqOVRnZ3VyRE1rM2JsQzRwVWRk?=
 =?utf-8?B?K3hHQlRlYlVNcFFBNU5qTHFrbEJxZmVNVVdqREQ5OGRJM1YwdmVacURGdVFh?=
 =?utf-8?B?U0RxUzNQKzRJdGoxcmxxVUVEcHFKbWN1SWNNNkk0SnZJaDVJQzUxZ0YyV25m?=
 =?utf-8?B?QnZNUFlGTDIzMDk0aHc4R08vcHJtMzNPQ3ZGZjZHdE5CeTAvUnMzb0IwZEVK?=
 =?utf-8?B?VHVabjBqZmxNZmhtM01VU25WV0lVS1hpTFBlTk5XV2dMSjIxaElYTUJ1OUFa?=
 =?utf-8?B?ZFp0eVI1cTI2bTJOUUVIZ1lGNmtxNWlSZ0JGRENFb012U0dNZXFBd29QNUpl?=
 =?utf-8?B?UWJsSStCWEdKcGdiZkpoQmhBUXNNVDdqOVhSVmhzcEVQYmk2QzhVclJrNHN5?=
 =?utf-8?B?N0FLYkJqTkU0TFFZK0xLcnloOFR5YnBmY3U1N0ZqUXlwd09Qa0VvTVRaVXNs?=
 =?utf-8?B?dDZVaDdKd3QzVHkvWW1OTDE0RENxNFc5cWFyV1pua2grNGxoMDM1OGE0b3lL?=
 =?utf-8?B?a2RDMkhubFpZU2xYc200aWR5TC9RYlpJRWJpYUdnK2dLN0RGSDdjdzZuaWl0?=
 =?utf-8?B?bXJKZXAzbFJkem5lTXZyQXowQUcxR3E1d3pYaC94Y0QvYmlqNGFhcE9Xc09s?=
 =?utf-8?B?RSt0QUNXZTRxdlBuY05qdjJqeFlkeFUrVjk1bzY1d2VRZmx6TmRMLzNPdXFz?=
 =?utf-8?B?K1RMbENxUmk5VGhxaERKRVB4enlWRUpob25hanNhRlRwRzBkd0x6QVJZRCs4?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OpAimi/48n2+jUGciBvD2fOoUs0mpuHY+V4441VI8dS9A8loXV5anfeBEGORwtbDmgKzXM3Pmf2L/dDUJBs/ekBB4ps5JBs7cZ/99Xd7qnK/lfrh/ROBzkilSamCBbzDRpFL5Cms1uxLoybVCWjSKuo9dAVifUCSLHWlrCJlfqn7U/RNdM121Yeu+w0ESE+ce9ER0/4Gy4hI6S+BlZsdUCil4CQZKnXpws+dGKGdT2aI4eImpfmwmL0dif/c9GNwarSeGVgeoFr3XaJILXpECP9vV2di/5HGYEzeWIAyue37s1MO3xjX02mx9lUUhatv9r0dRXgPIPTfJAJOrrrS1+oDbfX1q6cNHqzEpyBX2Qj6Cxoinl3/noiL6VDk67M/y1mGE0laIj5EFo+c3eAj6e8TpwlSbHlKpE3B50EweE1N9k7gTrZYGGu6Vbms129UJv2Oc7SUFimaVJ5MIYYJ9DPm38EZO3MfNxs1/IFSwksTBo/WBnqO4IHbchEkaWED9yO1VKUkC7hKnpdjp8KQ8/CkADJYh/nlxZNItsaHidCgddG0TtBV8Vq4emIhukS8WAzG5d48v+TPFAZhjHks+8XmeC35WfWl10FTLV8xLD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d3b948-52a9-4d66-278a-08dd92e6bf41
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 12:56:30.8147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEAQVGX1JUFO3O2pCoQrboZ3yxZKpBS96wF9MDfNSlRle/n8GAjp/mZxEB0V6H52RP7oPmgxjaugTIHUM/Hzjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505140113
X-Authority-Analysis: v=2.4 cv=DZAXqutW c=1 sm=1 tr=0 ts=68249307 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=6x643OkSufUkAv03FNUA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDExNCBTYWx0ZWRfX4HoNbrPZ0ZhZ FfXpmg5nU7pa+jwy496qqNzmSF9sCLvFLf+MRBPR221ZH6qUJQ4c1AG/JTo0X2KU43xMkj3bZKb wHtC8FoR6R5H4QpOwo0f1K06W+NfeNA1FuXVWn1gN0Rtd2O/2cqGnAzGN889JSIeZFp/SWqc3rR
 uFnIzx0fuoQe2hQPS5QkRp2Vy3jRIpEqel2mA/flg0CuxmKNPO6F6pnK66tkjPlQtn+aFPUafga KXfsLkLC4S2Ihqh9fQt14fpmabEnHIQ1u5oGGeS1sbckfdogNNMqPs5Pi0rVD5e0tMbz3Z3Nlxp 2qrOcZmsAeZKr0NBJipaq2/d9zSwOkKJ0YfRS/wVKq0IynfAEDh577xjU5lWVG8QKqqnDukGVKU
 uNEKgywdtAg8NnyQWG0IalooI2iLA2a4/XoJYaF7+9VF8jEer2EJk58/7aBMb/RKPfTsFIUq
X-Proofpoint-GUID: dFMTxst9XBP5qAtrcgaQ2ocTBlSWTtRx
X-Proofpoint-ORIG-GUID: dFMTxst9XBP5qAtrcgaQ2ocTBlSWTtRx

On 5/14/25 7:43 AM, NeilBrown wrote:
> On Wed, 14 May 2025, Jeff Layton wrote:
>> On Wed, 2025-05-14 at 12:28 +1000, NeilBrown wrote:

>> True. Anyone relying on this "protection" is fooling themselves though.
> 
> As above: in some circumstances with physically secure networks
> (entirely in a locked room, or entire in a virtualisation host, or a
> VPN) it makes perfect sense.

On a physically secure network where all the hosts are also known to be
secure, source port checking is wholly superfluous. It makes no sense
there.


>>>> I don't see any really motivation for this change.  Could you provide it
>>>> please?
>>>
>>> Or to put it another way: who benefits?
>>>
>>
>> Anyone running NFS clients behind NAT?
> 
> Maybe that should have been in the commit message?

Agreed, the commit message should have more beef (sorry, vegetarians).

The commit message should also mention that NFS clients frequently
exhaust their privileged source port range, causing new mount
operations to fail sporadically. This is a well-documented problem
and the main reason we started moving Kerberized mounts to ephemeral
ports.

Generally that's a situation that is sticky for a couple of minutes
while TCP sockets proceed through TIME_WAIT until the source port can
be re-used by another connection.


>> The main discussion came about when we were testing against a
>> hammerspace deployment. They were using knfsd as their DS's, and had
>> forgotten to add "insecure" to the export options. When the (NAT'ed)
>> client tried to talk to the DS's, it got back NFSERR3_PERM because of
>> this. It took a little while to ascertain the cause.
> 
> "Change default to fix configuration problem"....???
> The default must always be the more secure.  "fail safe".

Sure, but this option, although it's name is "secure", offers very
little real security. So we are actively promoting a mythological level
of security here, and that is a Bad Thing (tm).


> If we want to make this configuration problem more easy to detect, maybe
> we should log unprivileged port access (beyond the few requests for
> which it can make sense).

Logging this would be a potential DoS: A simple user space program could
connect to 2049 repeatedly and fill the server's log.

But again, not worth the trouble: desktop file browsers connect from
ephemeral ports. Why log those harmless accesses?


>> Note that Solaris' NFS server stopped checking source ports many years
>> ago. We're only doing this now because we followed suit from how they
>> behaved in the 90s and never changed it.
> 
> I wonder why Sun went out of business.....

It certainly wasn't due to the Solaris NFS server's port checking
behavior. This is a red herring.

I see very few CVEs or other security advisories that describe the
Solaris NFS server behavior as an active exploit. That suggests to me
that source port checking is not valuable as a security mechanism.


> Ignoring source ports makes no sense at all unless you enforce some other
> authentication, like krb5 or TLS, or unless you *know* that there are no
> unprivileged processes running on any client machines.

I'd be in favor of, first:

* exportfs emitting a message when neither "secure" nor "insecure" is
  specified for one or more exports

* Updating the description of "secure" in exports(8) to explain that
  this option provides little to no security, and strongly recommending
  the deployment of cryptographic security mechanisms (as described in
  the "RPCSEC_GSS security" section

Then later change the default to "insecure".


-- 
Chuck Lever

