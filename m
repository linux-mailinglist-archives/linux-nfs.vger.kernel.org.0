Return-Path: <linux-nfs+bounces-11522-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF17BAAC843
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D4C7BB750
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7344318D656;
	Tue,  6 May 2025 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nomxRWGS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rAC00GwJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6D3145B3E;
	Tue,  6 May 2025 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542355; cv=fail; b=m/lu2rLfEVhZW05fTF+Cu5Z+Tq9cirOBLaP5seGCzNwMLs3mxq2trFB8Bbv1ifrvStW7ToIPlaGN+qVkLQKeuwhCvDPKpHht9QgCaEs2UvkSdvix6do4k5JxmxAOWZTN/PuAJYcHWgehSQfZFbwudm0hn2aV5lVIDp8p9ZPYOgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542355; c=relaxed/simple;
	bh=qemS5X4I08dnZuAxmnhVErJ1suph+NeKR+VWiRESPGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZYa8ypD6XUmDHY6lk3o3uLPA8Llb3SQaf316z3mkvlLtVwRVZxZpgZYov3n/O+FrNuQzcxdhIKYxUg6hOBTiX6BPJuk3vVzSsezwRMzVePC2Tql+yTFXkm4y93MLjQs5Tptl07NoJ+09Yq/a7YRqDBXg4mRV6f5MVQR7w+Rq5hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nomxRWGS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rAC00GwJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546EWsxK030879;
	Tue, 6 May 2025 14:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W1XSbmgDjl6JZn09C27hO7LRO0tpvSSYjbdIDogTzzg=; b=
	nomxRWGSIzs5hoxEgyJ6OK+Lww5PfcZL2Ji2woH8kunUyIsagRHnrI2bGqdujceX
	s6l+yJeqHe/lb0XTANeFbUD6GO4oMD8G6XrBYDvTJYes/iG8sYg9XH4czZFXq9St
	pjva/u3RKRwjp5s98KnKX5o9VDnON1TRidO/EzlLG2wilUeD1sHURRpOMbuqqWHe
	1H9xcu1eOvZl+GY2z4MdGVWxNzuIuYVCLh/RdKEdG033jVuP1wX1RL8Uyg8QXab9
	8jqZc9VgjCHRldaZTImfZGJoCouP/uUoWYTjDV5ZyAt9GQu56A8cFJjRawQ2c44K
	D6xZeff87QnAK4uQ0K3eEg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fm9780m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 14:39:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 546DVvrB011397;
	Tue, 6 May 2025 14:39:09 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010003.outbound.protection.outlook.com [40.93.1.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kfbw99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 14:39:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNAE/G2otWzFnV/xOT5Y+lf++xroEfXrITtbyVD1GhQfkA7cfHqui5hIVYs1HhjoBa/ZNvA4qjIdNvZJVpStXVjecFqpP7/4Ck8fjvGKk9bhCcRxY1zmq9i7TfFqo3st/znRaXb1DymJfsYZC/jO+ZAmpU2KxnZ6vHLR65HN8pWfgzYzItWumNqcWsolH/mdmES+vFl2afYXfgDx6c+UartbSKjoYHOGtqBEluEOcBzEMWO3NqYXj4ZXeKru0gR61q9zLmj+5gZikNN6kRagdVu24TBGZrViV9wh6HQ5N9Lt7wWYdCHRUsnC2jD2MEwtk/UhF+eqgsSgsBJ7J5rJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1XSbmgDjl6JZn09C27hO7LRO0tpvSSYjbdIDogTzzg=;
 b=v6IKzu+cuS3hJIP8U1zlj001oIxkJt+CaCdX1WuByJh9gdAz5AWlqulI8LVv3GJmP6on/VOserVX30lBuHF4SIDaVJIkBvS4KnJRHjSVJVrmC+4e1aMtPH4vZgsas6TjeC3KW5k92t5mFKZXZwavL4ZD23UJz6LcAwEsW051WxYhvcwiOl7s2se2tr3eVjl1ZaUTjSb2fPNSLPZfyEd8oWoO4v81Ax+vVfvcT6Yps+zwM2P4lZk3+EBaQuCAC7mgP+XP6t/u6C3LDz4sE6qH/89hXyU6YorMV3o4QA8elrQ2SGgYjIGFBLhQ9Q9h4syP2yO6Ayy9tl+5y9FgX/wiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1XSbmgDjl6JZn09C27hO7LRO0tpvSSYjbdIDogTzzg=;
 b=rAC00GwJ3bX2alzyTGk662CwiTXgHfTLd6EvkU/k9754g4GN9taQWLyujESchDoB0x9e+4b+pmFR48TEKZE7QEjukPTB1R6daPTntga9wvimg+L+PLm8LFWzJhw2I2szr4Is45dhEE63qMh5ICj1N5j3U4nTzpRkwUms36iN+Y8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4412.namprd10.prod.outlook.com (2603:10b6:806:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 14:39:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 14:39:02 +0000
Message-ID: <8ad8cced-c5eb-45b9-b3d1-7409b3ae507c@oracle.com>
Date: Tue, 6 May 2025 10:39:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
To: Christoph Hellwig <hch@infradead.org>
Cc: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-nvme@lists.infradead.org
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <63b16277-d651-4f37-9e32-965dc6d1e7b0@oracle.com>
 <aBoYDS84d8N5STLq@infradead.org>
 <fb8862b6-97aa-43d0-882f-f0ab9f873e16@oracle.com>
 <aBocWAKRbttPeStt@infradead.org>
 <8094c0f2-3f83-45c0-9b1f-0cee682997d4@oracle.com>
 <aBoddkwEbyqGllOh@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aBoddkwEbyqGllOh@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:610:38::47) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: 983339f5-98a7-4f28-7763-08dd8cabbe9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WStkQ2pyekFUWERvaUlTUW13QUJtWGJ0RFNWUTc4K2thUFlSS2UrcUd0RU40?=
 =?utf-8?B?dFRVa0VMdTVaL2hJY3c4NUNoUTlMUUVrSGt2NStUWmp4Z3IwMGlobnFWSzBG?=
 =?utf-8?B?bGNuVnN4ODBMQVorTmdibVFDUFlpTE9KY3E2a2ZpMzRZWFU1YnB2ektPZm9G?=
 =?utf-8?B?VHVzZEJQcHNOeUxTZW5jOEhreHNpdVloTnVjUHJmNVpIbjhDNHhFa2E0aVls?=
 =?utf-8?B?QjQrTXB6Z01Qb1lYYjR5NkpwZXI1bU5IRlArK2RvREU1SVZUaXlsSjhzanZV?=
 =?utf-8?B?NmxVZVM0THVEVEx5c29ONE04Uk5HZ3ZidlB6Rk0wS1BmTGc4RUV4enQ1dXpG?=
 =?utf-8?B?b05xRlQ1dVBmbVdZNkN3elIvY2N6RzlhVlZxclVBS282RElDZ1FpNWs0VzQz?=
 =?utf-8?B?bjc0YmpyeFFGNmZZSER6Y1dybVJlczJ6cVdQZmV4THFRNjkvcENOSlYyRHQ3?=
 =?utf-8?B?NjUxZkx6cUlJZldGSmUvKzNHZlRMSkx3dVVwenVXZ3hTMm9VOXUwcFRTZGNu?=
 =?utf-8?B?UnBlZ3ZsNDFDVEFaemwyZzBvbkhOODArOTlUSEdMN2xxSEFkaG50cFJxU0dy?=
 =?utf-8?B?dkZta1V5cEw4M0NCVGJDcHRCcm8zdUNHUkJJUEhVRUgxc09QTGJlUXNzQk1s?=
 =?utf-8?B?NEVlRFJsSDhwMFpMdTN1YnpSM3FTSnJ1MENpOVhYeUpQL1NrVnRGZGtPeXlN?=
 =?utf-8?B?d01iQjBnZFg5RU14ZmExUnNFRTZ3VlJsUERlRENtRHJ6SVRCWEVaQ1hXQ2E5?=
 =?utf-8?B?RFNjVFM1anpHUlZQYjMvUGpjV1V6MHhHK0Q1d0JuODJ0bGV5VVdBTTIvdENx?=
 =?utf-8?B?TWlHZGw3QmdEU3VERFpqek9BU0taWUg1YjlUeTdEUVJjUTdNOGlGWFVtcGpK?=
 =?utf-8?B?eHRNbEwyVGllaDAvdWFKYjFTdlFXNUVrYUx1VmREd2RGTWZlNk9KTjVXTDhu?=
 =?utf-8?B?bTk4cGcwQUVqdlAyNUVmcWtVbnZQUkJoR045b0NyZnFUbW00MVQzOU1XMERF?=
 =?utf-8?B?cWpiVE5Ldm5jVlJuM0JQQThyeEhPTVpTKzBpVit2aStSTU8yN25MZ05pNmIy?=
 =?utf-8?B?UFhQcm54OGdlZDNYSUV3N2VkcVdveC9BK0E4TXkyM3hmZWVZQndzV2JDc2Zi?=
 =?utf-8?B?UnRvK0NrOE0xNkJVZDNFaktCOG1WbDg2cW1zVEN3TDZRVUdjQ1VhY1RMeitC?=
 =?utf-8?B?Tk93TVVzTVZCSW1KaWdUdnFVMzN5TEFQYVdtYnF0SjlaRTc4U293VkJtMi9E?=
 =?utf-8?B?bGxqK2RodFRSVTQ0ZVlaVFpKVjE5TDl6b0tFc25VUXB6bkVJM0pTMEZ3Unoz?=
 =?utf-8?B?RWQ3VlEwamRrYmdJRktXMFczL0QwUUN4Vmx6TTlsVHNyQmtTZnVha1MwS1BH?=
 =?utf-8?B?WXBkQmxYUkIzcmJoQzdmczdMUUR2VGV2Y0RhRFdLRm40R2NuOGlOV2kyVS9a?=
 =?utf-8?B?bEN4WUtEQ2l1QVE2b093NzlyaW15NmQ3dUwvUFl4a2FwamJXZXZuZVFDMkpZ?=
 =?utf-8?B?SzhId0xFNysrRWZQZFVIRU1qeUNUMU1VQ3p2YWNGKzU0Zk5qeTFzVlUrU3Jy?=
 =?utf-8?B?STNKVlZFQXJrVTNVZk12azNsa3NINlVCcnJTaFppWUoySmM2My83S1FZSnFr?=
 =?utf-8?B?aWJEdEF2K3FFeURoVkJaaXdiTjJ3M0FQRjh1OGNqTmlaNjJ4WUtwTnpVUjRZ?=
 =?utf-8?B?dXpKejduSWR0R05sTk1heUYxYmRaMUpIRG1ibTh2RCsvTlAxT05SZVp2bExF?=
 =?utf-8?B?MnFrQlFiTDNuYU0zQ1Y5MW5FOHFiSDhEWmI5NmdiTEZycVp3NS9qZElDeUxv?=
 =?utf-8?B?MHIzb0I5akxRRWg4L2VmODhGckpLQnFPbG9rTDBuSEUwYkVSZUFOcXJqY04w?=
 =?utf-8?B?UXJuUWdEdzA0RXNxMmdFMnRwSjhVb3I2ZzRxSUNaR3AvTnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlVHbS9tWlA1eE1DZFdzSlJURXhjdWRubytjeko3allMWkJ1STBid0g3OFho?=
 =?utf-8?B?V0xiMHpCTnhXZXlYaS90d1dDaGxRbVF0dEQzSk9ad0VENFFHSzNNN3BvbUF0?=
 =?utf-8?B?NEZUbTZtQUJDNUtXOWNBcC85REVHZnJmZU1rQlhKWmMrNTF0aCs1WnlxSGUy?=
 =?utf-8?B?NWVFNWVlWXRqL25ZclZ3aXV3aDdHdU5DVUxGZEl0SVY5RWNNVEs5djQrWDg4?=
 =?utf-8?B?S0VlU0dWUDl4bE5HejZqWUdaa2pXbmJHdDRLNDk0T2FmS1VDbkNHWkZwaU9H?=
 =?utf-8?B?dFdFUHpmNGhXVnhIQkl1WVRXVnh5Zy9VRm91eGV6bXBsVXZ4eDIyWk05ZENh?=
 =?utf-8?B?TzZYeUJCaUpyMEZuN0VWVlJZeXcvL3Fna1d6UUNSeWV4Zm1vRHZqQ3hnQ2c2?=
 =?utf-8?B?bHhLcVJNWXlLM0NMSW9TaDFiUTZvZWEwWWEwSENDMHVkVDhGdTdvcXRIWWVJ?=
 =?utf-8?B?bEtFbWpuRVFOcWdXSi96UU1pZG9iWWpCa2NIcGY4OTl5bkNmUjIvTzZ3ZHRL?=
 =?utf-8?B?eG9xVk1ZaFBvVFJTNFJxcU1mQU9naXZKNUhqSVc5V1pnRGhvSlBRVTd1ZGJs?=
 =?utf-8?B?SWxqRUJISFM3Ky93eTZwd1B5Nm03d05WUTVpWVNLU2x2bFc0MGJ4a2FmSEVE?=
 =?utf-8?B?MDlGZEN5WENQc0R6Z0hlb01Ld0JIblJPODY4NWdTTDFCcDRsdFl5UHJvTFBZ?=
 =?utf-8?B?UjdkRlpPbTM4L1BlNWRaSHFYSDJ6dzFGblluZHJmenI5czVuaGtxZFZtSW43?=
 =?utf-8?B?cmt2R0NjZVNjUEsyZG4xUG9ROHFCZUpibm5VNVhNN2dzai9XbEVQQ2s4ZXAy?=
 =?utf-8?B?WSszcDZaOGJpMXNkeG9GbytZUnZrcGtOMDF0NkZMK0pUNkdGZWVhV3JMejZh?=
 =?utf-8?B?cUw4alIxV2YzcXMvaVBPaXJ3SVlZZ0NHc2VoSytOdHpLSkRuVnZuSjc1WWc4?=
 =?utf-8?B?V3I1TnppOUFTeW11TjhJTDBEV3Jzc1hPNm0vUjNVWDA2VUk4Vjk3L2R4UGZi?=
 =?utf-8?B?N0ZPTDcrRHpDVXo4TVhGSTFhUm5OMVJ6bDhMTTYzNG0rall6MVpSdjF6L3l3?=
 =?utf-8?B?N1hnVVZySHROZDJLV3NtbGN2ck1Ma1Y0VWRXWUEzZ2hETzhPclFzRUliSGg0?=
 =?utf-8?B?bCsxWCt5NWZjblI0RzYzdGZjZVVCOXliR1ZVb3lKL0ZOWDNmTkd0R1VrMUpq?=
 =?utf-8?B?MGtRbmNpN0o0V0t5aUZvNGxib0xyZXJrSnZXNXdFQnowaFBBRnpmWFRsM1Bi?=
 =?utf-8?B?T3NTaENNOUJqS2x5Mm1nWHY0QmpFaDlzWFhrVCtYanFGQUpsVnZqRk1BMnNS?=
 =?utf-8?B?SW8rVGRvVUdJKzZXUWFYa3lJWEdBbTRQeTdXdWV1VGxac21UQTBTU0JCVG1k?=
 =?utf-8?B?WWxYbnZBemk3WXowOVdrK1NFc0U5SkpQdXc1NFplc2MyNWk4b24rekRMZDlm?=
 =?utf-8?B?by8zZWEzVCs4aWhNWHpNS0FjOUVjdlRCaUdWMEg2NjEzRVBjcTNlWVV5M1RS?=
 =?utf-8?B?VDFYdldIemUvZ1dqWDhMbXgrZm8rdGxWR0toRWwycFc4OEw3SmRkdHhGSTJl?=
 =?utf-8?B?cmRVSjNWTE9WTTRROHRtYWdFSFVzb3JvYzM4R1IyS2ZHMHh5czVRd1pOdnl5?=
 =?utf-8?B?dHZsQlN3SVNHWFRiRHpSbmp3MGdvS0ZyOHVSUS84dWVXMUNoL2tYL0JIMXJW?=
 =?utf-8?B?TGZiMTJpNHRqc3Y3Q2l2aXBSbXYrSDkvMW5jUTNCeEtJZDhCRjVWWkVobFRl?=
 =?utf-8?B?WCtsN084U0FFZHFncFFmbXk1bCtNenVvRHZycitjdG5DbDNDUE9JbGE2RU00?=
 =?utf-8?B?MW5LMUVoYTlHRTVTYkRFU3BHTUk3VjlOL3JtdkZwZTE2N2szdHAzS1RuNHpI?=
 =?utf-8?B?MTVHOFBiTDhxVXBwak1Ua0FzTW1GdU9qUTk5ZmtrVjNTWTNjMFJMTXBDcE5l?=
 =?utf-8?B?OEFnT1ZEak85SUpQc0ZoSmVtcENmZTZwZTBqSDNQQzlEaFMwUDFXZy9YQ1Bw?=
 =?utf-8?B?alM0K3RiOVBiNy9aaXZJSmFQdEsvS0JkZTVoMkhIMG1VZitjZ2p2cElkQkVG?=
 =?utf-8?B?Z05TUkQ4ZTZOSWtQZmJHMlgvQm9sTGlZZVF6THk4MTFFVmRVM1FHbWxBU2lN?=
 =?utf-8?Q?6t+NjQC0sjYniMXl8j800qXMa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1nrhT8gBZ5IIfFV/GFIzaxJkB4MORX4SEP47XCaSuL/EGlQD4cGpYYZDIXaeD+k4pxvFo4ZwTzQCqJqM1rCQA4nSjPdZz3eTX3FxAjU+2+UPfTH8Z//I4NaRg1WmIWizjLu9UkWDqPd/5gqAfjbhijlQrB+E42I4XxpC4RPkeqGSE4/4P351n03I8DKmojtne+xgubSH7QbP4Zml4NHWZ9HDGa4jgtrZYndwgi21POHlUmyvG/H13+AsewJcqiYx7Zg/WblBtVYV6lKLnK+LbFrwRJcgO3QpHObnBHlFo/ZGfdQsZ7G6EIUrZpWYBtD9Vetr1sSedjjTIfH0S8fv2xntAQpgvcUE216vdHWgGunh+GH7YSsiTBfv81w8DyFKzxfCy+2JUhbjjg0EOsfBFEt/fNjusamrP4q1/ecxaiHUzgDZHiuIAYbXlnIWWos/Hn1A5A2+xzG5EvfxSrQVT0gmai1n3xLp5cLWfisX9vS9DUgw3YQIgs0hkR8kjhm7+m+jkE9RR0jXcMbHs+L+kZvtoHCzj1mHAn0JYsSrgtjlALhZiEsXEInxlwTzn/jNDXcRYkycf+GLym3juOkNs3dfYHIiq58ixp1Wwbe3cn8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983339f5-98a7-4f28-7763-08dd8cabbe9f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:39:02.2938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzLoxc/MLN7u5lQ6SMSgjvA+9sTMTnnQov/eM9un0KaCMqfz3wKiMMITAGz5azcCHma+66/h7nk94TJR5gDxJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060141
X-Proofpoint-GUID: gyW5hWiMBFdKE93faCz0Su00Qv9P9XwB
X-Proofpoint-ORIG-GUID: gyW5hWiMBFdKE93faCz0Su00Qv9P9XwB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE0MSBTYWx0ZWRfX03HR0jjgJaf7 2e+wDFW8EAIUVwXJ5u9+FX4fzxYL/kz7wyV4qHkKOUk+Gf723qK2c6TQc1OCtVKnJXu8hG71bWD wQrwc7cISitFS4dKbR9KJnFUygzKL/pCoh27ZLNYfawComS7WFpHdA9mFNVMDgu1GhJfstTWMry
 cT7Z2EC8VVfQ4nAIrvgm/RaHqv/27L0PbC8lhYE+g/GeBJkPN3JL4EyL2Smv2OpSyawX5QXpmoO draoBPORDfyXV1fugLGIMDeJRgJ0FUDNY7GmTwYBlw1eXqaa5xAavzySp/AbfBm6XnnG0CW2bqO tWpMx7WAaJdYAhXXOchcONLUQsJq29ErCLi2MyFoRzpZUq+RlCXnrasyLLIobcP/LmYO4O+yDKi
 GSblgtqu94IYa1PIN+ULQD/L3WzUTR1+tOw2t8eeY7T7HMFqNhtBhCHGtY/XFEwEeAwioAYk
X-Authority-Analysis: v=2.4 cv=Vf33PEp9 c=1 sm=1 tr=0 ts=681a1f0f b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=pz2D0245Hh88dVfWTM4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14638

On 5/6/25 10:32 AM, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 10:31:04AM -0400, Chuck Lever wrote:
>> I do. I can't burn that bridge and stay employed. So calm yourself,
>> sir. Let me ask around.
> 
> No one expects you to support this.

That's just the kind of detail we need to decide before we can "just
fork it" -- who will be the maintainer going forward?


> But you should also not expect
> much support for a project with a silly CLA.

I respect my employer enough that I think they deserve your feedback
first before the rug is yanked. The best outcome would be that we have
their permission to move this project somewhere more open.

-- 
Chuck Lever

