Return-Path: <linux-nfs+bounces-9579-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156ACA1B809
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FEB3AE453
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F298D13B58B;
	Fri, 24 Jan 2025 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LdA/5unk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wd+8eRk7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6FE4EB48;
	Fri, 24 Jan 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737729832; cv=fail; b=ZpLSkJ8u8cZnQqBkvkDD4eleGTdmAwOVkXi8K/VUFpQZs/nqE3PjXzttDHYYTV3t7hkQs/Wiuxo0TmmugmPjgid/jiwbM+LjVUV5Og7GZfkh8sD6BgZpCQkExUszOG35UDQ7usWYX7ZI3UFil765R/R8T7tDP/6Y2uFmfgZpkQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737729832; c=relaxed/simple;
	bh=3/eIhZRJxwbHgKdvzov4Qz3MPO3MYsdUAnYv0f031IE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uRj3lMcIQm8bY/HAhkKNgVhpj7SQ4zqFMMDsP4IidTFK7GK9mWyHSIOaA5zV8nmEPdKDFCXXLPPWdd2L71agyUO+hXiNVtbR2sMD4yuBNbYDpRwP6w69v2Nxoaw3Qj3vO55WWImJXPgoWdaycHJ/Iqhtsq5uDvGRXwnpwkZX41I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LdA/5unk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wd+8eRk7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O8fwfn018166;
	Fri, 24 Jan 2025 14:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SWcABrfKGrYJLigiWf5Jvlc1MMuk0O3CiJ/66RJ/NPE=; b=
	LdA/5unkL37X044zeQyBZ4XP+HDKh+HbfTLm5zgBohJLMKSqNJb3MuDvYemJjBlx
	6d7pexILbYez/k47j0cremU+j1Bctn2tTgvGM7lOQAsoITovje+cP+gdAlAFe37v
	v/2CmGaNDLPSAL4FJix0cNN6wvYLCC9qG/hAPoG3YjnRr5RTAo6/Qhczw6tMK9Sv
	yan8EulPq9RJJL1LhXn42cCrNieNfmftZskSudQCUP9rp/7Iz7rZl9wewLny9Ddh
	oKugWrQa4wpEwnk4cYChSBjgKlOTTRnSLfa9JJbVyfm6DVEh9K4iVvLTi47XfnxF
	vIM7yXr2zvHuGRbzYhWmtg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44b96akb05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 14:43:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OEZ3sj005632;
	Fri, 24 Jan 2025 14:43:35 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 449198cth5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 14:43:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0Ll3s8tTaC05NTKQUWRBTs8RheD/bVLYIywmqHQAbFccL+lnLuxrAzCDTyetc9Tebl6Ln9/daZPvcmK231FDE1jk4CXAqzD6x46VPjR91JbBnkwdlT7IMm05T8R/Nx5vhfQlCHiMNx2//2l61PwpNEiYZLy/VWEwP+rsVhFcvGi6o/WH7KSfNZjb5Scwu3alDoLsmxdFtwW3QXjHADQaRGBPXnM5qwFg3CrrWo3eRbNObK6lADPBNrIx1WpYHF19FM8yViy7dz1agJCOMnDuXzYSjY2WgyR22t82GSQXwpjKuQJ6B2mFj4r4wy5oa+84wZ75xE/HfVEUibCgY4Fqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWcABrfKGrYJLigiWf5Jvlc1MMuk0O3CiJ/66RJ/NPE=;
 b=XRJPVE0wi3NO1JeOiKpW8JSApICEQqwc8JB1pJXOdUEdOhB97+dxesaN+bREX8UOcBoyrqols2In2KSLuO19+7L773CnhqbEEYFzeGPKlRW2xx2pqrwvMxNfS6ivBk6DVP0FAWKCCQHmwgDeN7NIIVV+/iswOds6x7ny1N1PhvvOvKzzTbXj/NK9eQIQMRQDk+tX8SQgcROKZlVJANGktsUpX1jegnKn3YyQrsKdOiCPGr6YhmbtlgQqRSzBu1HP+gU2IsO3fuFreYAyp11RTqmyIq63JkR1meTK8EQ/THxmIvBJgWQzdAMoNhZ/M9eZHNsN3401whlBZhxqYEEb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWcABrfKGrYJLigiWf5Jvlc1MMuk0O3CiJ/66RJ/NPE=;
 b=Wd+8eRk7X5F6Nu8F/DRJcrXK+OalchzCseZI1ecKn+ud3thOjNeGT/1W2E5j4VFbxfrAT0LEDAfQeR+NkD5elOQoVE/SfbHLxzlE2KlQOcdDv81Upouk+5vg8/E0j5omly7FXP1okmX8C84pDqt7CyuGRZldV7M8Y+2c00MOyKY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6394.namprd10.prod.outlook.com (2603:10b6:303:1eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Fri, 24 Jan
 2025 14:43:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 14:43:32 +0000
Message-ID: <8a6e1930-feee-47f8-8260-874b9c47f20e@oracle.com>
Date: Fri, 24 Jan 2025 09:43:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] nfsd: clean up and amend comments around
 nfsd4_cb_sequence_done()
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
        Kinglong Mee <kinglongmee@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-7-c1137a4fa2ae@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250123-nfsd-6-14-v1-7-c1137a4fa2ae@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: c18b5db6-d814-4891-a87b-08dd3c857934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUZvUE9BTlVPcDJ3TXhyU0pOc2RmeWJlU3k2UjdmVEpuV0xIelcrSDZpeTBP?=
 =?utf-8?B?bmttcmVGRWxJMllXNVhBc05WbjJENTFraHk4bk5ENEFJU1ltOUhLNGhnS2pq?=
 =?utf-8?B?U1BsbFlMNEJUTkVsVzJIZjhIc2RHeTBnenV2YXhjQmNhVEkwK3hHUXk2MEpv?=
 =?utf-8?B?UjREeEpDcTVKMm8xUXRTeVVHQnJRdVpqRzI0aXptU3VXNHJPOHJsd241OFJ0?=
 =?utf-8?B?RkhCZVdxc3o0QnJyTW1STE1Oa0hxRk1zdUpjRHFCUTlVZ1RNd01jczNlZ1hH?=
 =?utf-8?B?aXp3YmpIeS9zT25XeThkVW9TSnVjS1FZMWg3b0VSZW1jdzFKOFRUTzIrcXlv?=
 =?utf-8?B?bWs5RlpRZi9rcUdsbkplVUZDZkcyVnBhTFRKcXR3N0RFRHI0aUFDWjB5MVFx?=
 =?utf-8?B?bFFoNUhkNEVaQzV2bXhGVm1tMHd6elltNGJKdHRqRTUySHB2MitGUlowUFhr?=
 =?utf-8?B?eStzV25BRHM1T2FzeEpXS09NM2JUWGZQanEzUXl5ZjFhU040ZzVkcEV6Ty8w?=
 =?utf-8?B?TW9heVdkNFN5bk92bXlDNkJwVzlCV3MrTk90RUpveG9QYkxidjlHeXpkSEcy?=
 =?utf-8?B?YW5QSS9IVnFaak1pbWJHRTZDTU94Kzh0YzVjcWY3SlFKbjNRUEdQRTVHbVln?=
 =?utf-8?B?UXgwZThTQktJYW5pQ3pRTXNlZy9oRUJrT2VRV0FCdTlaNHdKcEtlbW9CS2kx?=
 =?utf-8?B?azJzR0tEYUlPTlVSdTdrNU5GSkYrU0tWb2hHeUlsdlhqWkI2cHhDMnhBbTls?=
 =?utf-8?B?anFNSjkzUzN2WDdEb3ZoempKRE1DSTlhK0ErVHEybGowOVVlZ255ejRObWUz?=
 =?utf-8?B?UGwybmRJSkF3UzUwaGJjcHdzZzExWXNWR1BHaEM2dEdIZWxNbWZrNGkwdUc4?=
 =?utf-8?B?TWU0MVhORFdYWHNnMDFiQk5EVTdva1BwWnMrREtMOWFzV0Y3UHk4Qkx3OE1E?=
 =?utf-8?B?WWRQRnZQaTROcFF4TFIvdkJhMjFGanBKWk8vMjBYOS9Zamh2OUZaYzduazk5?=
 =?utf-8?B?Q0NzL25EMGhJY1dxWElLTWxvM1BtMkZBOXVZZllYbitIQ3NVVzQ5d2drRllS?=
 =?utf-8?B?OGlZWlpDQURjOGc4RnFSckw3U3ZMbnB0OXZSWkZOYVVzV3VjTlAxZXdvNmJE?=
 =?utf-8?B?U1hmWnVydk54WGJlbURCS3hXd2NiRVdxaFlJcmRtdW1Td0RvNzN5NThTMHpS?=
 =?utf-8?B?dGRLUnVyZW1PWi9oaDNMRFZodC8xWGV3eThJODNRMHF0ME04L3NremVJMW1w?=
 =?utf-8?B?bldlNHFXcU9Gc014OUlmaUhvWUNJRVVKUDBvTmVkYzIxZ05YdUQ0M3NjTFZy?=
 =?utf-8?B?cVg4akg5NHU2aDNPcEFKM0NWRXl6QXZtNW9uQWFZMCswaWkrQzQyaTZvR0tW?=
 =?utf-8?B?VndibXZDSWFpcXFMcXRsUVZnRXF3cWlBM1o2WFFoK0xsczBzQjZmckdYNlIx?=
 =?utf-8?B?anRmOFZoWG14UURyTTV1U3RkaU5QNXpndzVxTW01VkR4b1M3bnVzUm4zc1JG?=
 =?utf-8?B?MTZEblNldS9VdVBLdFNnZk9nVFhEUlY4UFpMNTBTRExqazFlV2UvYmtHZGl3?=
 =?utf-8?B?Nm50QWd0RU9VRGhHa0NmS2UzZDArR3FhNFZlSnB6M1FzUTk1NitQRUxEdjIx?=
 =?utf-8?B?cGlaSElEOGJTVVU2M3QrRmtVMHBuNERPNzZSUHQxRUxGWFl6Y3BIYWF0NmJ0?=
 =?utf-8?B?SGJTSVlrYlB1T0Z2RW9DdlFsaWwzYnJFTCs1WHlCOVRod2FKTXdhMWtxYUQ3?=
 =?utf-8?B?QWtjOWI2cU12K1J2U0lNWjUxVXBDNXAxVy9OdFJEMkdPWjZyYXRIUzJ5bzZG?=
 =?utf-8?B?MXB6WWdaSm83ZE96SFNnS2hUTGptUy85YWVjL2twTWM5Rnl4MTloKzV0cE1z?=
 =?utf-8?B?ekJBeEdBQVRJOTloeUVoMk1HT0czRDF6OVNTMXdETU9MVzVCdXpGVjliSUtl?=
 =?utf-8?Q?HDtcfu9Lky8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDFYb0tjVXpvbStWM2pIQmM1b0MySWozYzMrTzlKdW84UkU0Qk9WRWpXYUlN?=
 =?utf-8?B?Z0w3UnZSN2lJUjMvU0RqWE5XaVpaa3lnQy80aDlkRzIrc0ZEWUMyVTFmUFpP?=
 =?utf-8?B?Q28wOGxPZjgvQ0lhV1F5RW9FRXJtb1Bka3dYRXBrZ1FyYTNYWG9JR1hPWFRp?=
 =?utf-8?B?blk2NzdHRzJCQVd3NXFPWDRIZkJjd3plY2FBNTV6NWF0YTV6N1ZCTy9jNm5w?=
 =?utf-8?B?UGRZM053Q2MycG4wbTJ1Q0xmb3Zndm1IbHhsdGVMSHI5S29LYTlHK3ZtcUl5?=
 =?utf-8?B?aFFySFp0aGR3Q04vR1ZxUHMvK3UzT3RvZFZpVGRwUkNBNEt3VThqanpqajF0?=
 =?utf-8?B?dlJLMGdIZS82YlNmcXp0VC8xRmZldWR4Y1NpYTRpUGN1Tk9GSnVjUEYxOFlj?=
 =?utf-8?B?QlovRW1VUlhEZGUzaW1wdlk2V1o0d04zVzg2b1cyWWM2UmQ2SjhZVWY2N0t4?=
 =?utf-8?B?WXJ4bEtBTkJpM29kK0F1UGtxdjNlZTJjYVNGLzNpYldKZ1RpYmZTbzF6K0dE?=
 =?utf-8?B?ZGpEU01zOC9ZM3Q5cGk5UjNRTThWTjJtY0hQRVI3K2p4RllranNaVXZ6MXRo?=
 =?utf-8?B?cC9yTjQvL3ZLOXdEZDJzOFMwbVZJRnlLMHJXQS9Uck1vRmF1ZCs1WHRsTHN4?=
 =?utf-8?B?MmNSTTdqVmxiZXgwUHU4ay9vMUwrRVY0bWpPSDV5Nk5qWnBZV0NPYlhpdG9S?=
 =?utf-8?B?RVVma2NLSFVOak9TMnRBMkFVeGN6NkN6YWh1YXZycWpQQmNoSzlKWFkyT2d6?=
 =?utf-8?B?UWNDN045cjJTWFpXQzcwTXBjZ3NYK1pyRm9sSUJId2d3L3E5cktVQ2VHWVRH?=
 =?utf-8?B?SUxQaTBKclYvM0ZtTmtUeFBoYU1iREJzZEV5TThNMkpyMWZISHBqcXR4clpL?=
 =?utf-8?B?WldCZmM2ZjgyQzVEWEVlTkpCUkh3Si9IRW9teTNDOFBHY1pDV3BJcTNqdnhu?=
 =?utf-8?B?STRaTW1IUm14Qm95aGVnbzJyS09LMnR1eDlzYmdUUUVlK2hCVHVEL0FtYmtS?=
 =?utf-8?B?ZS8zbW5xL0dYM3VIcE5SM1QrVHhLTWU4alliNDA1Rzc5NHR1RG9wUFd5UjQz?=
 =?utf-8?B?OWlqYSt3NFU2UENzdXpUU1Q0L0xqUTlmODhGL0JWamM0MmMxK2RPWXp6Rlkx?=
 =?utf-8?B?OWQxY0ovT3JzQmFKZ2hCOGZLL2NlNlNGNldoa2xsZGg4WFJZalNYSWJKN0ww?=
 =?utf-8?B?Ymc4UUtrbE9oZElXa1dMc1VydGNGMDRINi9KU3lqU3M0Z09SM1pQRk4wNWxH?=
 =?utf-8?B?TU9uWkpGZDVySjJPWXg5OGFoMkZPbnE1MElWUDMzSjNMSnFNMUJ4NWpzODJZ?=
 =?utf-8?B?UTZTOTQxU2hlRlNwY1FORTF5REN5RUlIaHU0S0xSbytzb1FpWkVJNm93UFNT?=
 =?utf-8?B?b2dMOXBLMlBQM0ppeEtxMTF6TGh0UG5rYVNwYlhmUm4reHdHekMxZi9jY0VT?=
 =?utf-8?B?V0JXY3QxYU5SN0pCNWVvYk1HM3lvd3NpK1ZhU3RwWFJCd3JtMEpMOXJUbXh2?=
 =?utf-8?B?Uzh1KzBVWkxwaktvSFZ6R3l2aFR4TkpRQVR1SDJKWGJaMTZMZ3FJK3d5WVNX?=
 =?utf-8?B?cUNlUW5iMnBVRmFEclp0TGlYUXhVRkFTSHJVVHNQb0ZRNFBxcUNvZlFGZFBP?=
 =?utf-8?B?SkE4eVcyTHdTT2JoM1hrNTRQSEVhRzNjQmZTWUFaVmJYMUZzREdoeU0xVzNm?=
 =?utf-8?B?Y2Fid1ZlN0RBSVlIc1hYMitGL0FTMUxqajRzZDFzdWM2V3ozUHZIUGxUbnVZ?=
 =?utf-8?B?RjVWaE1ZdTh1VTUrU2xPelM4aDBxckI1VTViQzFGa2Nvai9hWnhDQytkeUJY?=
 =?utf-8?B?REM2Yk9nQUowcnI0dTdUSmhsVlZ4M3hVZld4dUxBUTh0K3hJc0czcUVmWTk0?=
 =?utf-8?B?N0JCL1F2clNOWVhaSFU4b0lXaHpjTkJLK1dSbUQydGZYSFBIRXIrREhxcUgy?=
 =?utf-8?B?SEVEaTJlU0s1aGtCL3pWTWw4ZjhLMzZPRXp4aDYvclpEbTVoS21sSDd2U1JF?=
 =?utf-8?B?UGZvL012c2p3aXlGUHNlYTB4VkpDcS9hQWUvT1FGR0YxRlprcG5POHFLSjhV?=
 =?utf-8?B?QlR6VDNidm9aWlZPdk0xd25xeXdGZnIyVXR1VzJIWkRvbThpNGJTalorbTdt?=
 =?utf-8?Q?Ml/z1chQLU5n63GX8j7cM1k9J?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7L4HfYpspUHJEDX1oqcqfzCjJ7aqCzewnzMMHJx9M6y9qec+HEMh+/pZn/y6VIsQ+mYgocaZ8jtDstxdeLpkyF0E56Ms/cV3H+rN+pOXmxljLjf3DVrSlpbaNqC//s4fTAAYGHISOLjq+tImo3tv/PuNrhxiEBaQxrsOAq3iTXhe9je4uz+HlE0o5a+jYoC/bB/HqDKC3xo9E2i3SRbsSzmVHjQt7GPjW9lEbb/Nz2QDM2Me2KAPy559TFyOINn+KL107Pf7D7QRvk1ZnISsq8mXZT94H/euqP8HcR7IYzLSyycGV4RLXHo3naKpyRmeyC5xvWrDZPwERp6Mmjeb6zWWmrViJH7pbbo5Ibj9P8/r80twKb4U//a3dCO+0XCBecevz/qzwsAGB2bTmxtVV37i35kUDTOxgtcmZjFyEGogkX58/lrSZnzCHAi8unvtJmiIcfmzsSbd4gqrq9/+RIvWs4HHgDDD+tC2hZXsclha6jwtVJZ5HrdvNGaFUryODYr9vVEWC4QCWs0HpytRs/JjHp2/3+DOrIwzSPbdYf2shdVt2CWGqiQkAB4NIkA+BD0tp+Zp98jQotqGTqC7u1rSpmu0NvGJ1n5zmftMDxo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18b5db6-d814-4891-a87b-08dd3c857934
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 14:43:31.9882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Id4fKI4mu/OtNMUfLMvQkCMdXu15UURe6CtJ4iAZ2b+Xh4CgiMPUrJCZ2tj6aw1B24xjeH6cSi0bid+SiZuWiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240104
X-Proofpoint-GUID: SnJCYqhk5DhnOzCP56MBTMwxClotlqNt
X-Proofpoint-ORIG-GUID: SnJCYqhk5DhnOzCP56MBTMwxClotlqNt

On 1/23/25 3:25 PM, Jeff Layton wrote:
> Add a new kerneldoc header, and clean up the comments a bit.

Usually I'm in favor of kdoc headers, but here, it's a static function
whose address is not shared outside of this source file. The only
documentation need is the meaning of the return code, IMO.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/nfsd/nfs4callback.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 6e0561f3b21bd850b0387b5af7084eb05e818231..415fc8aae0f47c36f00b2384805c7a996fb1feb0 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1325,6 +1325,17 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
>   	rpc_call_start(task);
>   }
>   
> +/**
> + * nfsd4_cb_sequence_done - process the result of a CB_SEQUENCE
> + * @task: rpc_task
> + * @cb: nfsd4_callback for this call
> + *
> + * For minorversion 0, there is no CB_SEQUENCE. Only restart the call
> + * if the callback RPC client was killed. For v4.1+ the error handling
> + * is more sophisticated.

It would be much clearer to pull the 4.0 error handling out of this
function, which is named "cb_/sequence/_done".

Perhaps the need_restart label can be hoisted into nfsd4_cb_done() ?


> + *
> + * Returns true if reply processing should continue.
> + */
>   static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
>   {
>   	struct nfs4_client *clp = cb->cb_clp;
> @@ -1334,11 +1345,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>   	if (!clp->cl_minorversion) {
>   		/*
>   		 * If the backchannel connection was shut down while this
> -		 * task was queued, we need to resubmit it after setting up
> -		 * a new backchannel connection.
> +		 * task was queued, resubmit it after setting up a new
> +		 * backchannel connection.
>   		 *
> -		 * Note that if we lost our callback connection permanently
> -		 * the submission code will error out, so we don't need to
> +		 * Note that if the callback connection is permanently lost,
> +		 * the submission code will error out. There is no need to
>   		 * handle that case here.
>   		 */
>   		if (RPC_SIGNALLED(task))
> @@ -1355,8 +1366,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>   	switch (cb->cb_seq_status) {
>   	case 0:
>   		/*
> -		 * No need for lock, access serialized in nfsd4_cb_prepare
> -		 *
>   		 * RFC5661 20.9.3
>   		 * If CB_SEQUENCE returns an error, then the state of the slot
>   		 * (sequence ID, cached reply) MUST NOT change.
> @@ -1365,6 +1374,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>   		ret = true;
>   		break;
>   	case -ESERVERFAULT:
> +		/*
> +		 * Client returned NFS4_OK, but decoding failed. Mark the
> +		 * backchannel as faulty, but don't retransmit since the
> +		 * call was successful.
> +		 */
>   		++session->se_cb_seq_nr[cb->cb_held_slot];
>   		nfsd4_mark_cb_fault(cb->cb_clp);
>   		break;

This old code abuses the meaning of ESERVERFAULT IMO. NFS4ERR_BADXDR is
a better choice. But why call mark_cb_fault in this case?

Maybe split this clean-up into a separate patch.


-- 
Chuck Lever

