Return-Path: <linux-nfs+bounces-16558-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F27C700D9
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 17:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 070C0353BA8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 16:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB172E8B66;
	Wed, 19 Nov 2025 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SOsf7Dpy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RQDlAb5J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278A2C11EB
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568556; cv=fail; b=RUGqNQuj7MQTeFdZVNgZeFNWKkiTfNfhDZIvXFdfDbCJqIrZNSNTq+K1XUxPH+ipXQmin2aulxG6FUCskiw+gwU8jCjXrQ96u4xx1o1Cg1gzt5kzm1TpTtdwV2kQJpqDSzeMrhXT0uMy0JBPmq15fH1jlcA0vEauxw73YgnGUIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568556; c=relaxed/simple;
	bh=Gg6MFT0HM8KJcQjLFLcRlMv7cG8bN7Unk3WrJfZaXpA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZIdwOU+pedDtNY1uwWophP5Asc7XzoHOm59ZxSMjBeEKtSVu0oX+uMjpwTXsZfckrbt3MMFl2I7BXgSEeapzf9Id0ceaoh8lt2ZIP0Dd6vZ7YlzQIFEkq8xJBa8mlSWYt+kgOcRvc8MwqzqfIpj1a/QYPCgvReR2/seMnPNp1HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SOsf7Dpy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RQDlAb5J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEg2Ok005162;
	Wed, 19 Nov 2025 16:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yJzQmPkoHES+dwyMVIJVsUp1J5TLRnJ3Zd8f7fTKBbM=; b=
	SOsf7DpyKGKKeID0uAodUIPafKpKkiASDMaVTfB3OBugOdb8HQY4CZaXqweqZ2JA
	8GbGPufhXnL06o30ef+KMgSnIJeMcyUvtXWeV7FSFDau73dKe8Q3vKkMQpLa/trq
	+b44zMIkYgCI/HGhC5bbxWalSmqbVSuB/XM3QSQ2k8tcKiemGMg3qx9PQ6tm21yL
	bk45aP5bJNXPuLsYiKskgYy1XlTLvug5ZV9QgLhKngziamUhI/jLD8owgV24QRzr
	xYhbAWgG7w15hKBSUpY5MfL35rO1ChnR5BYb1bJ+9j5R8s3WzbUFT9o3jo6FuIRe
	OHw2l4GW2H+MkDJnB42twA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej907ej3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:08:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEvfXV039958;
	Wed, 19 Nov 2025 16:08:58 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyn3tdk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:08:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkaPEHyXHdWE1pnT7e9yJwHopkZcPdsZi1cijiM/SAadHT5C6at7bx8g59L+Y+hHi+MDQrbv1ceUwN/2vul4J5BEA8/SvKy/aUJObueP9aVWrhht/TdHzQSipWKnlnmsQHooetzp6ht3kTOke8Ih1UDHPY8AztDyUA8pRAJqUICqaPeJAz2F9OS7EhQW/Y7rIp5A2rOwXwNJpMiuSGjwh4GE7rBqgahu/NH5dsKXfFavOdiYmTaxku2PZYrbCCFbG//KdNxyHm1I4XQatTSuyApQ6pmQ6XuQf/3hB8P6wIwf9cQICDqVD/GU8wCtDqAWacUJCUUwOfDfjLMaSc8E1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJzQmPkoHES+dwyMVIJVsUp1J5TLRnJ3Zd8f7fTKBbM=;
 b=l2BTcENBvl3QWHI6HYKSKZ0v4ipsvgXhJ6zTNv98Vpp/tQPxQnlLO33uhlr8W8tUp6SZrdGghVGj9NS2e5GmNUvUCXaQRSXhfC8RdhDVSSUCGv0QRLqISPUU6DP7bC+mVI+EXalf9t54vfEgqv1ms8zttexZUWMScSP04n4UH4UAaKEzf6o4XlkUPURU+3qT20QBWi0vyuqx2BsNLw/6ppN1Nfqk7AvNK7xbU2j9TPqS/Lif1gFhKaOzJWClk88qvQ/Z2q1kzZOiYxQ04w6ic2daDibjK2jyphMkQgfSq64oIUSeTq5MJ+5IeQK+c8McO0Pk5OLpuOFMveDmBvwPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJzQmPkoHES+dwyMVIJVsUp1J5TLRnJ3Zd8f7fTKBbM=;
 b=RQDlAb5J8VZR3VndEGXrUhja/3r5T02AobgOYRHvhN2vh5tXqB/7s2nW/+Nwaocpam1WMXsw9qKXUFEEDU/vRbpIdZ8xMdV/DSRXOoky/MimSyC4bhtptAKGjJ1volE080DfPHrrL3L2N8zaRDVZJXGW2++0MOIk8kEFqFP6T3U=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SA1PR10MB7830.namprd10.prod.outlook.com (2603:10b6:806:3b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:08:54 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:08:54 +0000
Message-ID: <f7701fcd-c71e-4d51-a36c-f99cdd981bb8@oracle.com>
Date: Wed, 19 Nov 2025 11:08:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sunrpc/cache: improve RCU safety in cache_list walking.
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
References: <176074628319.1793333.3387532760794075868@noble.neil.brown.name>
 <27844685-0132-4f65-b8cf-3ea058d783ae@oracle.com>
 <176082518104.1793333.5226398922398910122@noble.neil.brown.name>
 <e33efa39-2a6f-4724-8fa0-bf881dca01a7@oracle.com>
Content-Language: en-US
In-Reply-To: <e33efa39-2a6f-4724-8fa0-bf881dca01a7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:610:58::18) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SA1PR10MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c8ebd7-6d96-4e1f-4678-08de2785efb2
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UDkyMlpSQ2h2bUZ3Z1A4WldYekdrS2tQUWRCdVVHTDBFOWxxV0tGYzU5TVc1?=
 =?utf-8?B?UGJ6bzRhUGZZNnpLeGhUckhjSzNMUzlXcnFuczdQUDIwL3U3dU9Tdkd5TndO?=
 =?utf-8?B?NkN0a2I0OFFPb2QyZzlNaFZHVlVqSW9LamlsaVlCRE9aclBpYThmLzZDN253?=
 =?utf-8?B?Y3ludnVXVURkanVnOEhqSnlGUFBZbmw3NUltejc2QWNpUkhjSElucmE5SWNj?=
 =?utf-8?B?RU1HVlcvU051aEE2RzZwNUM3Si9KbUI1QU83SmJNMzJBeWYvRGNPQzYvcnlY?=
 =?utf-8?B?cWhlWjAyYkROZzh0blRWTEZYVUlrYUNCY0ZIYXM2QUlhZ0x1QkZGOXMzdUlN?=
 =?utf-8?B?WmlZdjZ3M1lEVTVJRTVwdEZYU2ZaVytBUG8vQzloVm1xaFhocG1GMGdqc0da?=
 =?utf-8?B?VCtJU0NnUG9qTURDbUpscEt0NWxvc1BEN2xicHpaSmRWcUdPZTh2bmpCWFVG?=
 =?utf-8?B?RkhGaTF0NDNGQjdCK01MbFlTY292UUlLSklrMXpnU085RVZWZjRYaTZrSVZQ?=
 =?utf-8?B?cG9aUEZRcmdKdHc0SzJNMEdXcWlyNGdDNENOSXdBemloTGxXZW5RSDlYU0cz?=
 =?utf-8?B?UHhRYlBnQ0dQb2ZkWHBOL3QzV1h4cXY3ZTlzb3JpRi9uUWV6di85U0VCMVlH?=
 =?utf-8?B?TTRUdHdFVkJHTEhsSWJBNDZ5akVRVU5wMnlzaUw4ZjRhTnlvcU5WMW1nUUNi?=
 =?utf-8?B?TFgzbnpqSitRVTB4VTZNWFh2NVltRXVQdERKNTBGYkdSakg3dUlMbFBmSHNk?=
 =?utf-8?B?VEpzZ1lHL0tvdm0yZzlPNEpBRnJNcC9ZazA1ZkVOKzVrS08rMzR2QU1zdmNP?=
 =?utf-8?B?QjMzNlQ4amdMd2IzNWRTNEZPSFhLQmJ2WUdBQ1dodzdjS2V4dU1BNmwrOERq?=
 =?utf-8?B?Y01IaGxZMFkvUnpuTHJaeTBPVU0rWmdGcWVLYSt4RngwTFJScTdiQlIzSDZL?=
 =?utf-8?B?V2JwbVlWeUhVNlZBQUtITWU0WFB1dFVybkpzQy8wQWc4dmFVVlBsTGRiUE52?=
 =?utf-8?B?blFna0s3MXJIenN5V1QrWDBjc3g4dUc0czNrZWt3NUMyYTB0d1NyOXEvVEds?=
 =?utf-8?B?ZjF5U3FIRWZoTVNBRUhWamRXNVBBTm9wOW1uNkdWZ2FkT2d3ODQ1bG1INXhT?=
 =?utf-8?B?UjNBV2MvWUF5UTUyVXdYZTRPSzQyamtNWm9UZXlmUFdCT1dQOTBGTWJrazQ3?=
 =?utf-8?B?RW1Sa3YxNEx3NlJ6YWxFbE12Vk53VlBiYlZ4enp3SkJMN3EyaHVZSFBqUVJ0?=
 =?utf-8?B?andZOFRFRXNaZ0VTai9pNENPS1hDYUV6enhYTFhldDAvR2N4TTV3cFdKOHVJ?=
 =?utf-8?B?dFErRSt3Ujh0MHlZOVZka3Fpci9oa0wyY1ozVTU3Sm9IMkN0eXY0NWt5b1Yw?=
 =?utf-8?B?V1BYc3JRdTVWOUEyNmdqTFZDdmRKMXFoNlh6a2YzckJLRDlKWnlaMEVKcWY4?=
 =?utf-8?B?bExmZzZkREVXeFNieHNKcUpJdjFMWWpOQm1samJNeE9RTFo0ZmwxZmYxdWZG?=
 =?utf-8?B?SW9VN3UyOTNVMXd5U2JWT1AvdEttNmlDczU2dmtYWEJjSWRaeXJuR29iN2Ix?=
 =?utf-8?B?SE9XdWtlOEtZRlpYc2pVL2VLUGRqREJGYS9tKzF5MUhwYXNqNmFwSFlDUWlq?=
 =?utf-8?B?eE95QlNMNjlBL2lRWXpwbE52NUhWdkhQcU9pc25kVVFIK1ZSd1FLdjQ3VFpk?=
 =?utf-8?B?a0NQK1lFZHFrYTFHS2d1WkVWdXhUVDdYdXNwNlhhSWxnMlhxT29tS0RhUHdo?=
 =?utf-8?B?bWFXK0swdXZDc2tzdVdvNThKVUdJSlpQRDdockZBUnUvUXZieFQ2amRRa1dE?=
 =?utf-8?B?M1ZybzdCNmRUektxQXFXYnFsVmMvblNOMEVkbDBkeXM2TUprTHh3dlpxUlh3?=
 =?utf-8?B?akNvQVoyS09DWitTVlludWVXRWdDaC9rWWV1Q0N6bzVTY0hzVmpIWElheDJN?=
 =?utf-8?Q?/qM4g0TQTkWn09xlb0tgBgVB+jT/KB3Y?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OHF3UWlKWkRyU2ptQ1REa3NaOGlPRUhrUWVneHMyNFJqVlUwZHpqVG54cE9y?=
 =?utf-8?B?RGhueDVacG1mUzJzTnFNZGtES0dsZmF6cmdBL1QvbFlHdUwrM2NzRFVjc1RL?=
 =?utf-8?B?UDRrV0krUnlqcGhhVUh6MURzS3d0VXhFTUJ6WUlpakpKNlJoazd2ZFFraTZ1?=
 =?utf-8?B?T2ttcm9oTytYM3NxQTRuamJYb3V1RC9FRVlsTmVEdzVuQy9KM2ZtVEVUanBB?=
 =?utf-8?B?aEhETUI2UUJqNUtXanNoOVlUd2JvcnhrR0JGS1RhODYxcmllR0NLMDBKZ2xB?=
 =?utf-8?B?cUNRak1oMjZTaUdWY21qZDZiaGIvdHlwZ1RlTmtnZVAyNktuYWZKU0NHNXBJ?=
 =?utf-8?B?YlpySTR1WDVRNEhoazdudjQyZGw1NFhWVjRxVld5cHQwYUUxUVZRcFFIWXJQ?=
 =?utf-8?B?blN4RkpIQWI2OUtDS3FNYjZFb0VzN2hiaUNrdFo5U3pOQS9BblJxWUdrdktF?=
 =?utf-8?B?WVZ0d3VsVXV5dkdCMlJ2bWcvMldTMEJrZS9QckEyZEpEZmZZUTlkcmUwWFVo?=
 =?utf-8?B?WHN2S3BvZjM5TnJnanVSL3ZScXpRUGwzcmFqWnZlYWsxZ0Z0UFY2djBuUXlG?=
 =?utf-8?B?dUpOWEllWVJXVTFZQ2QvNSttaUlmUEZ6TFJ6VVdhRjZCblJTVk9aWDJLT0Z6?=
 =?utf-8?B?ZlNGR3ZsZTgvYis4ZUl6UzA2elhoSGNpeXFwYWpYL2VTTjZYaHhrME5DZEg2?=
 =?utf-8?B?bjNIK2Z1ZHhsZkEzcG9LVzFESUFnUXhnMktIUVM3MWhQbjdjV1BEKzd6eWJN?=
 =?utf-8?B?SHZyVnpJUERvZXh1U1dPUWdsK1pNUzZpeWs1WjdBSG9mSmd1OG1mdnV3V1pJ?=
 =?utf-8?B?UmxwMGFHVENhRFdrMlFFRy9DbjY5K0gzLzllcC9WTTZEMXZkb3hSL2h3WHBX?=
 =?utf-8?B?TDJ1eHRpZThYcS9IMXNuN2NqYStTL1l2ZTUyZGZwMGdCNzJiZTJvQlh4SUhW?=
 =?utf-8?B?d0pCOHMwOS9WZ2MyUTVaalFnZDhuWmhiV0cvZG10a0dmMzk3LzB6RWJDem5q?=
 =?utf-8?B?dVpUQkU4UHZlY0NNYjFWWWxjNktZRDN3QnZxenIzMk1TZzZTVUdaRmdqUUMz?=
 =?utf-8?B?RUJHTXFYS1Y2dTZlQS8zc1cwK3F1cnpOODREQmNTaFhOZTB0cWUxVXVwaUMz?=
 =?utf-8?B?YkFYSUFPWEdvTHFzU09iSEFuTGdINTQ1eG9ic0d5MFBqcHg1VCtJQ2V3MVFu?=
 =?utf-8?B?MlRXZm5iV011bTNKbS9Gb0UzSTJQYms3REZpQnhIcXNoMnpINDRvR3IwekpP?=
 =?utf-8?B?UXJlQTZ6NmFaMHRVK3dMbmhKeTQxYU8rN3RyU1YyalRrYkQzL3kxMHk1Q1Vh?=
 =?utf-8?B?TzE2aGk1QjdNb29VQksxZGViL0dzVHp6TENDKzlrOWU3Ym1JNjhVeGQwdEJT?=
 =?utf-8?B?K0lnT3ZyYjhFdnRJeWlmTXVNMk16UEJmZmpUUlZISXY5b2JHSzhUTzcwQllF?=
 =?utf-8?B?T2xsN2JoY1BnTUUzSEVWVmw1R3pQMmxLVE44U3B0T1VWZlM0YXlVQkE4eGdv?=
 =?utf-8?B?TWphK21QY3l5QUE1ZmNtNTBtY2paTXZoK2FVTmVLaVFCbDduaDY0bVVnOVdV?=
 =?utf-8?B?eElyUktpd0FaemZ2WFY5eGY1REwxd1JydWxxV0pZVldqbmw2WDVRaitCdnN0?=
 =?utf-8?B?MFI3MWNHUlpNdktSdXF1dy84NHBwM3I2cHVmSWNkTW1SNmZyT0c3cEZnMDlm?=
 =?utf-8?B?OEF4WkNlNmE5MExuMDBycmtPelZVb3lsb0dxcjc5NGt2TlhxMnlUa1RHS25Z?=
 =?utf-8?B?a1FCcmIzVFc0TE5hM0o5UklXVVNPajd3Ry9OdG93cURYVGM0M2Z6RGJHNThp?=
 =?utf-8?B?c2hNUEQreC96aU1CT0k1SnpRcHpERHErWTcrSVQ2cEhXVStIVSt5WFZINFhS?=
 =?utf-8?B?SlhSZzlHaENrMmYvV1J3RlNaUHZMNXl1Q1B0SFdUZFkyZGQ3eW5wcHpwYlZF?=
 =?utf-8?B?OG5rUWhQNCtCS1B5alIvWDhCaGMrSlpqVjE3RGsvbSt0d3BoSVNES1Bocmtn?=
 =?utf-8?B?UTFTV1FPSWkzaG9HVmRyeERqVU9yNFF1UjRoTmxNVUQ1eGlhYUZHMzdKZmsv?=
 =?utf-8?B?MnhDWm5PcUpRRTBYdTF3N0dJUFprNi9rWkJYaWhSeXNVenU5a3pzRzFkaWNP?=
 =?utf-8?B?dFVWVXFqc1VrOTdjUFAvT3NHUGxpN0M0SmcyQmpmb3lReitNOHV6QjFzM0ZU?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	97l51ok1WPgg4mz9X+/b/9r4djy4tLzFo0OGiHuKc4DPlYvebk7fTm/2sE3LOGqMy1holV72bIqe2cyNtGEnOCWiZLpQu8vR9ZM4zBGqJIO3HeMIpsmEtLiOE8mVAl18zNle2utW3nDheO4drVOMQwygAQlZQ7I1HXgO9xQvat/i/qb5CHWPcdoVIm7lnQwHm82gAh8WHZ/Lr/qOaktLerEWn1Q7gqY+31yoYEULkLfKk8MGlR5hd/nroumcUF20DCxQX4Sq3JGafM46Ma75G19Wj0CYCX6mCiGtCfzjKMusvDQ8sl5qLfU7bOZj2o1BZa+474CX2uJYsvKg9lCSSC/Ssma3hRKga1M+rLIsaFpQy0n2Lq36xu4Iq0vQ0XCWmrBcukd7X6mBcmZwU9kFdop65QDp6ztYsFF4ROGbBRIbdeBOj99TA/R2Q3/X71TH7LJVVXWN2v77d6NHmXdB1Z2kAUYUFy4rE8/3wWVT2TmIe5ipuxJuzgOyV+hychghc/cjJcvQCMh/z37j/rV2xYUtBWCkH92ywZmU1OjD+GgnWu9ADMU1kNxHkscj8+Rzx+jblgBO1FSWekHDSDBuAI2EaEE6qHXN7Zc4/n+Sb5s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c8ebd7-6d96-4e1f-4678-08de2785efb2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:08:54.1554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7uZPHfnCsCHFrajm68DhtzZuMdXTpC9+dv/G8IwuId1jCg3/i6BXbgDzXsm1+qvhQEW31V+JXfMCEHsHki5uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=949 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190127
X-Authority-Analysis: v=2.4 cv=OMAqHCaB c=1 sm=1 tr=0 ts=691deb9b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=R44_1uiFYqgKcWbswvgA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: qTjmhdBh4joR_SWRuuEKWkW1PKEmePUs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX1ao3V3gnRQHL
 lIH8ClR/z1CHAYKds1yElt6Je7GhKSiE2C0yczOCgnv8orN9axHoHmYRZ+J6G3SIgVo6+T+mM0J
 PDhcDTTsz+sfux3MomgKj4RCdUMFPHjrkgxlU+Xjg4UZer9azQwQJBrK2e2DB828pWGY9j77OHd
 a6+ZFjNQFxf+FipMJbkGxWRB3YMj3DMXl+kRY51d0JG7v8vh5ABuq6kxe92HyOGbHCCKhxQ6zEC
 o8yTFE0l+XK9l4p4hKSLORwNvE+T2pPDKI29NVpzWaX+5BZ7dfpmuY2vYHSvGVZywBDTV85nGkK
 eea2J6AltuhnKVecvEMakBmwoOpxYVgIWlNukmSqYFheWeEYsO1F6sD0IUltk3tD+aAKM1JX9ja
 c2mI4HDIq4Zb1RBytjc/51ueaDbGo6UJWfHtIscMnexf/PUPGZI=
X-Proofpoint-GUID: qTjmhdBh4joR_SWRuuEKWkW1PKEmePUs

On 10/19/25 11:01 AM, Chuck Lever wrote:
> On 10/18/25 6:06 PM, NeilBrown wrote:
>>>> I was looking at this code a while back while hunting for a bug that
>>>> turned out to be somewhere else.
>>>> I notice point 1 and 2 above and thought that while of little
>>>> significance, I may as well fix them.  While examining the code more
>>>> closely as part of preparing the patch I noticed point 3 which is a
>>>> little more significant - clearly a bug but not particularly serious (I
>>>> think).
>>>>
>>>> NeilBrown
>>> I wonder if this patch should be split for better bisectability.
>>> Are the changes to the *ppos calculations dependent on the RCU changes?
>> There is no dependency between the various changes.
>> Did you just want the *ppos split out, or did you want the 1, 2, 3 also
>> split apart.  I considered that but wasn't convinced it was worth it.
> 
> Ideally, since you had listed three items in the patch description,
> there should be three independent patches. But if you think that isn't
> worth it, I'd be happy with the *ppos changes in a separate patch.
> 
> 

Following up...


-- 
Chuck Lever

