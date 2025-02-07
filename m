Return-Path: <linux-nfs+bounces-9941-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EF3A2C68D
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 16:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7500316A8E9
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 15:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDDF1A9B48;
	Fri,  7 Feb 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kMetxfIh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NZp+OCSk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8BD238D29;
	Fri,  7 Feb 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738940932; cv=fail; b=n1YAGIRdmw+7V3aCFvY7m/s/zMdeD7jsc9jQxrM/SF4jGe0CQLr4R7/wMsnVkiy5qW+rV1rSu4nYF9ivR95AA6+fjV3AJQUMeC6lMPdcjN9HghjpUQhTH5fk0egMpUBmH3taNozRZWEIozxlJuyVmfCzuv+Ehv0DJItopTNPCmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738940932; c=relaxed/simple;
	bh=QqXvHaBsAJdeObrEUGUGzHN3fepsl5B8dU4Nvj2EcIg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YHGj2eWoRJ4J6DNtYXsUy807/glC9JFNbg3Rs4sUQHDELKnrv4pKYgkFzXKZ/+reyUhsTHD5pRExfxLuB04VmG4Pmqa+dh33hlQQPeZyoBni6n9a5ZEkfleBLO66UxT76I7O54l+hn/STDy8ARrjpZb2D3QLBrRZMTVithOgykE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kMetxfIh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NZp+OCSk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517EpNUQ031635;
	Fri, 7 Feb 2025 15:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=W1XaNPDITIUrgeQ9lQ9/1oB5UKwQNAAC07F0WhRHyDU=; b=
	kMetxfIhJRmwVLbCjWapd3Q+7JRucF1bobv4PyPbZh+upr8FCsxF82Hyg/ZZ2sWZ
	bh/bT2hfU27e65VuuFs2GSWqvYjj550OffcGHwFiCIQhFnMUxWrwAhgBPXOUmvC9
	blraFOqJf5/1/RiE0syRzUSJsJMbOxgcGcBVI5ImFOdjc9Lm13d+njjhwTxaOiPe
	9EeqPBDhhD5dFgMI2tFCdGmDrnufumcOowd9UkVrhWm1pBJ32unJ8oKFV1x5S7K6
	3pwAhccNHu28jyPD2lS5vFiZYgJ+8AJ7o0N8rhoLn2koWq7/V6NuvklEoVAMofhn
	eBPfOFcA8IDv2IVtkVHluw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4xtpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 15:08:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 517Dwr6J020654;
	Fri, 7 Feb 2025 15:08:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8ftc4su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 15:08:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mq1rJHo0qXtbMoO5ZqmCjeJN59xoHbdWBS4e8eFJzFYzfPngegk+dDsqnE9RZO2aNzX/4CT04tDNXrXVVJ2zUE/bn2CCA8y5CbyU1x5I7SB97v+jUn9IsvHnt9i5b3ASUpo2z7ew2SOjf2LRInIg/6JvTzorfjBNkY+a4YOiBIH0FRNyVpR1M721v1R+vfhJZsl8mxqPYVuCpap1kxqBlu/DEQD4EVORtLuK9d7SazDx+50+BxQLwI7lBEYaEX+qOudeTpI2Dq6KERFWNaA42bRe4UMp2Gxi/WL0GolXsbxiFS38khvsW4Xpq04hyT7YNp9bPm6xwj85iZfbfrooTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1XaNPDITIUrgeQ9lQ9/1oB5UKwQNAAC07F0WhRHyDU=;
 b=j9ykauaz682EUsu1SkYxRgI9AZ+zN/Cb6sSXSvscl6cfFQRGz0i5WezRrvmdv1NDRaQt11ArgWbpvZRFhfrPapGnsWWVN7QgCSfGALj/YU6kY3/a4+DnueyR7dlIzjAN2qafvJMgAJn/9QlclEgY7Dk0TnxQFctkBBcDZrYSn1EREA32RNZyzMQvemyE/3I5ok7EUuRfFgeFEapVuGV/SJbfAANPssH3Ewkfa/xq3L+gWCEoZ42t2/xBc7+udbF/WYUnpIf+ZjP2lJO3JO9BISkZpp4bABORxOVKFZCN35qZwYPz9lCUFfH2PQAn+TgT9F1Mo82jXe5QyTyJrqwZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1XaNPDITIUrgeQ9lQ9/1oB5UKwQNAAC07F0WhRHyDU=;
 b=NZp+OCSkvaeMCBgeQyzjfiR+N7owYKjbz4xoyOJEyB+zZYweAZsh4LlfsrO+CZdNfSpMpf+ABMMBiwArH1bhpWLimHBLuScGCk2x2vOUOn5dqtqZtyXXjTeDjzrXqay7P+gwYu7ZrGrug99dDPCn0K+kVDHThv9Sl5al23A7qyw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB7101.namprd10.prod.outlook.com (2603:10b6:806:34a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 15:08:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 15:08:35 +0000
Message-ID: <7acd540a-d086-4ae6-b249-8f921e5d5240@oracle.com>
Date: Fri, 7 Feb 2025 10:08:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] nfsd: CB_SEQUENCE error handling fixes and
 cleanups
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250207-nfsd-6-14-v4-0-1aa42c407265@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250207-nfsd-6-14-v4-0-1aa42c407265@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b92b185-8910-4941-e9a8-08dd47894b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bndMQXhJRzlUaWVmblRPOEl6WTRTakh4T1I1R0xEK1QwSG5ReEpBVTBsSW9t?=
 =?utf-8?B?R3BTSzE2TnRPSTU5TGM5Ykd5VTNZc2JjTW56N3lvZlZRSnNxNjloczNXUFVy?=
 =?utf-8?B?KzZKQnBaQm9GbGFqckpnR1JqaUNOWDdzb3c0RXFRUkhaZXRWc0ZMTkR2bzA5?=
 =?utf-8?B?ZlF5MmpTSE5ZRlNYZXBXUy8zdUJkUkFLK0Ntb1VrMXgvc0R5Q01yZEtNQXFI?=
 =?utf-8?B?Z3pKeFhsVUxEZFJ5VGIrdzhDS0lQa2VPdDM0SDNHZTNVN1MxUnNyMG4xWVU4?=
 =?utf-8?B?dWpPN0MreGNWQzdDNk1aMFlTcnpySE43aE9LWG1IM0VEZ3lZQkVTQzhZN09K?=
 =?utf-8?B?NEhyRWhNVjVlZzZuYzhteFN4dzc2YnhyNFdJOEVLdlZvV2NxOS9Dd0NXcmRF?=
 =?utf-8?B?TlhGR1Nkd2pmR21sV1pWR0cvZGlBQVdreUxHT0NFZWlQYkpSMUh0OE1JZjZx?=
 =?utf-8?B?VVRxQ2tVdGdDWHlKRjFGSjlVN29JR1pXSlNPbWVHRDQ5TWljcEc0S0JoalA1?=
 =?utf-8?B?UWdxWm8zY1crdmZ0RGJUVGZSSDdYUVF1VmVhRmxRSVZONzkra0NHQWZkQXpV?=
 =?utf-8?B?MkU1aFllaWUreE1DR01RZkFvS2lDOTZhaUxXb1ZweHlqNENQN1I1WVkxMC8w?=
 =?utf-8?B?U21XUGhpakxvNGdJcFZrV0ROL2QvUUUwaktKV3FOSm10Szl1bW4xaXFxWWw3?=
 =?utf-8?B?Y2cwbnF5VkdDTytlN1hVWnpRSlhYamhFdTVJd0JNN2QvYTF5bjFaNkdiWFky?=
 =?utf-8?B?ckFMZ20yaG5CNWpsRnlZMVNUOVRqTHZPM0hIZkZyNUhoYVBjeUdza21sLzhq?=
 =?utf-8?B?aWp5cUFKdlQxeUhYRWdOQVU1b21DdC9hTDlZc3I3cXB5L1NROFVvUkZDaHdr?=
 =?utf-8?B?UkZmUFNzVWZjRCtPNGVDNUJkamZkSWVDNFd0a0lFUDA3QUJDTkdub0VaN3hv?=
 =?utf-8?B?eWhRRDJhOHNBbDVWNnRJeXhqWDNzMmtob0Q5eW16R0RueTVKK0R2dmFTYlZL?=
 =?utf-8?B?MHd6VlJodCtIdjB0V2wxSE82aHQ4SmVLTTlVSytzc2RXenNuMDNERzBsMk95?=
 =?utf-8?B?UG5VbFhyWWJrQ1ZnQlp3QkVuRHR5THJFbTUrYllPSzM5K2x6ekZRMGdUZ3gr?=
 =?utf-8?B?RzZBeFdQK1N6bUNTbU1iVVpBTS9tM2V2LzFma25iUEQ4ZllydURHSzUxTUR3?=
 =?utf-8?B?dW9MZEhCSWREOW9keTlnYmhheXMxZ1puUjdneW5WY2FoS0xMNDhxT21aK3pa?=
 =?utf-8?B?Wk5kR2pIUkJuSHplSDJPL3hPem9kYlpMMGRPYjA3REZ0cXRGMGtHNHJpaHV1?=
 =?utf-8?B?UEwvUnVsckRlVGcxSXZ4ZkduTXVEZlBKcXJZV212VEowMWxubVB0LzZPencr?=
 =?utf-8?B?UUFLWDV1VnQvUnRZNnhXUFRISGZveVpzVithSW05VmRTaytiVUlPRjlaN3R5?=
 =?utf-8?B?c3oydTFOaDR4WGpHTnIzb2I5ODZhQjE0SGNWV3JwQ0haWjFZRFhUa29DUzlU?=
 =?utf-8?B?eXN0bHlNczFlQkdzeC9HUTFURVlOT3lEMlZSbGFtWlpvdFJUQ1UvM1VFcFJ3?=
 =?utf-8?B?Z0dkTFhiREtJUmw4Nk9mbTBvaG1wM0o0YzlGUlhaSUdpVk5IdmgrdWNYQm5P?=
 =?utf-8?B?b0M5bUQybmZobkZrQmlwNFlpUlNSaFVsOTMveXpUY1pSQkozbGhNdlhIVElh?=
 =?utf-8?B?Mk8rVCtIQitoTkdhd2dHV3NKeVZsVEdlcGJzV20wOVRJdE4yeWtjSTg3S0Rq?=
 =?utf-8?B?bVZ4RnVmMXljc29MK1J6UHQyS0FQYXNmUDlzdVRLcENKRzJkbEZhWkh2dVlp?=
 =?utf-8?B?VWV1b2dSNU1LWjBmUzNlZXp3WW1xa1hrMFJHNDJnSmZjbnd3Y1JCMzNQc1li?=
 =?utf-8?B?c2dRWlN0MVBqNUloSFcwY2liWjE0L2hyVk1PRVY5c1NraEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXErMDNNeU9YeGFkNkp0U1hpY0tRSjJZN0YxSG9Ob3JrSUgxQWhtbjNRTmhS?=
 =?utf-8?B?dU9CeHcxQ2tKYXRrM1Q2UGh6Y1VuYXRPODcybk5BMWtISGJqMHJpa0VEcys5?=
 =?utf-8?B?bENnMGR2M2x4cGtweC9MTVFaZktNZ3BtdzNsNnVRL2RCeEhFTlFBWGJGWjVS?=
 =?utf-8?B?WWZTcWFnS3dlMUNFWks1MlJXRXhtREZtV2c0d0VuRHhKVXRCQ3RBYi85UUoz?=
 =?utf-8?B?UzZNZnBINGtoVUppMVNFYkNObldWTkhaUWV1Qkp2Q3hWS0ZiZzE3dkhpemVT?=
 =?utf-8?B?MmVLM0ZUTmh6ajN5ZVhJbFIyTlU1bk10aDRCMzJveVVsMUNkZE5pTEhUbUd2?=
 =?utf-8?B?MDl1d0IwMTFsd29CVXhNU29nUlJGdGg0dFlvVExEOUFGUUhrblZ4bWYzZW9F?=
 =?utf-8?B?UUJmTVZRcTBqVDJ4WTZ4WWYvVmFzZ2VGOENOdWtZemRCdXRXT0ZQQUpIWlFD?=
 =?utf-8?B?aUpxUG9Cd0VHRmROdjdlS05EbzhiR2JSOGNIZjVKSVQxSGg4eGt1d2FpYTgy?=
 =?utf-8?B?T2dLZWFGQmN2NDVlaFlqL0tFUTdGRUN1YkVqcGNRd096UDB4UVc1dWdqQ281?=
 =?utf-8?B?UjQ4U1kxOThna1Q2clJ6czR0SU42U2RPWHNSSXIxMnJwNU54U1FURXJpc2tZ?=
 =?utf-8?B?Wi9JQzZTR2FWb1VXWmtBVC9DbTl6NzRCUGU2YVUyMTJMSDBKc2FVVnQ4WTdG?=
 =?utf-8?B?MmExdENDbTF4UmR4ZGN4aVpwa3Rzd3ovcjFIb253NW9SMXpicTFSa1dHcU84?=
 =?utf-8?B?Vi82TmlSd1BHNGFtRTR5MzNUbHBsWjVnVDE2QkhpSW5OWW91S0Z4bDIwZGRN?=
 =?utf-8?B?OTBzZ2lOcGNqSjg5T3ZFR1JxWXNnMlM0cThINitZMjVWZnVLV1Q1bmprSjE1?=
 =?utf-8?B?QzZLUkpZbWQ1cjRiQVZucjZMcDJWUnc1R0xJcEF4T2srWnVrOC83eWVPRGxi?=
 =?utf-8?B?NzB3bEh6S0l0Y2tzWU5DdStmcWdmUTJGaForN25pVE5DVGZWWkRSUjNFNGhH?=
 =?utf-8?B?Zi91RTJoTW5WV3BJak1wbkU0SDQxRVFTNXcvRURtVjN2SkdIcnNQVlFTM0Jm?=
 =?utf-8?B?TXhwRDUvQVJIN3NmNWYxMUxYYWg5QkJ5dDZxaGNSRDVIaFZ5MTJXZjljL0Ns?=
 =?utf-8?B?K1Z4MW9zK2JqdEoyYjVPNExySENRUnZBYnB5YWxmclQ1QmxNaFdUWkdlVTRC?=
 =?utf-8?B?TlBZc0JKbkRWeXRyWTM1c3dTS0U5RHlHcXlnWVQ0cUFCVjhzdXhxbnQycGt2?=
 =?utf-8?B?RmhEd1dLaElEaEFRZHN6SHlGOEUxRjQvNjBudG94bVVZdXRmdCtjcGljektp?=
 =?utf-8?B?bUlBdHo2WDYwV2tXdE4yNmxTNkFhb2hTMVA3MUtjTFNUcEo3SFliWWF2NGs1?=
 =?utf-8?B?b2RiVGIrUkFsVHFYc2tucmUrNGVjdU5GSlF3djBQNGVlaVBNZXgxR1VZdE8w?=
 =?utf-8?B?WWgyUW4wZFQ3RTNDWm4vdUZoMUVTR2xjSWZnTnlGcDYxd1BVN2VMRkw5c25B?=
 =?utf-8?B?R1BNQzBrbVAwVGYxUXo0T1k1dGw4cWNUN0xiYnh2MGlHOVdxeGxVMDAyd1Jv?=
 =?utf-8?B?eDFOR3R3N0pZa3hrc1dDRno0dHJQZkMwMDhlamhUZW1YVEJMMnoxSmlHY1Nt?=
 =?utf-8?B?djl0Q001OENyREYxNTdNUndVVCtmMVV1QU5BbmxpdklhdmI2ZHNtaVM2ODlq?=
 =?utf-8?B?REVWbFZFemQweU1VUWhpOHc4ZDFOWjdONFYva3BxSUdyOGMzV2lDZTNhZ0gz?=
 =?utf-8?B?UXgvN1FFblUyNDZyQlY1Mkh6UlBtYnFyckdUMS9XeXZIc3ZzVTczS1lxNmll?=
 =?utf-8?B?ZHFjN0ltaE9BSUduVGpkckhTZEtUNEhqVG1QQkh0MmdXYkhiZHF6TDJ0WXJC?=
 =?utf-8?B?YnBtd0NoTzJibFplV0xUb2tXRVRBVjk4K2E5dkxtSUprYzFiTDlOL3lDQXZi?=
 =?utf-8?B?anBvRyt1THROWU5kSHpGNHMzZWhSbVBjdkJ3RFk1UGRvTkdkNEhZYTRmY2Zm?=
 =?utf-8?B?eVYxOUM4UzVYbVU1SkMvSk1FUGRCSnRlTGdvdkxleG1YQVRRMWFBV0Fhekcv?=
 =?utf-8?B?SGlDVlNPZm9qakd3YVZQY2NyZHRVNE95MlNCdW9tRmdnL3Y2YjlZM1FSOXNC?=
 =?utf-8?B?UlZEMnAwNHJPaVRCZytZQ0Q1NEdDL3pNeCtDOVlMUmtVMmpOZk56dlVmOW5a?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E0UQfzHnyKH0uOebfLAaKgWlSN/19J8GHDT6rv2gsjhUQ93rfQ27k78Hxbv4Eyv9fPBCg07KvL0Y5yop4nRYuj3D/ieq+eyCWy1HyeN1Ih1IzISyOowOhuolPKZkfGp539Gs9Drbtse7ImMux9swIlbmB1/P1sVIxUhKbrVB1mqoy0vsmVNTkaa8M/B4l7sOGxJ+Yt4iS9VauNtlUm5bwqfxXI4zEMmx09ozR/Ykiwpka6afuEbF86mfZti6LM+t4h4PZtMSKGluHXUw2wO/P5f+83FR+fgKlSomdZS8IY9M76oOgw97KevFBYHxd+w2Y7jSP6BTLX0KUUoaY8UzmuaQ86EyURHI+SKue5LD1BNt/iATdFWndwJSjr6mdViCplZ/P/OxthU03Zt8AltN6FdH2TkIgQ2fI65GdDQ61+qgtvWbooTeOcpHlwYonKrgPymNQMtDgaoqXFvnf5RJhy3dWnQ8Ggoda+mo0bSoCT87BKz9tCOidfhmRFpaFajwGxCJ8uQLevC6e5FpMGWZmqUwuVYTdsbnOeIDO6mm/Bj0lHExe7rfuXmoTTQFwE7Np2Vrag0zwlEYeb7uOMRoplaFUFv9P+Kx/IxA8eDRHBU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b92b185-8910-4941-e9a8-08dd47894b4f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:08:35.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XA+Cj8w0QuihVCFTZhpQoqaVutLEJyYejFKkihXRX0Gw7Q9mxfvFDl9AivTKvzoj8s5JAAiFobKWiKOuzViFqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_07,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502070114
X-Proofpoint-GUID: JxKNlpS0P4ANhOj4gQS082TgRUtRJZ0e
X-Proofpoint-ORIG-GUID: JxKNlpS0P4ANhOj4gQS082TgRUtRJZ0e

On 2/7/25 8:45 AM, Jeff Layton wrote:
> Bruce convinced me that the single-threadedness of the workqueue and the
> fact that the RPCs are killed synchronously was enough to ensure that
> the session can't disappear out from under a running callback. Given
> that, I'm breaking these patches out into a separate series that can
> potentially be backported.
> 
> I think this rework makes sense, and I've run these against pynfs,
> fstests, and nfstest, but I'm not sure how well that stresses the
> backchannel error handling. I'd like to put this into linux-next for now
> and see if any problems arise.

I'm good with the proposed code changes. A couple of general comments:

- I plan to put these changes in nfsd-testing first to get some local
  NFS testing experience under our belts before exposing them to the
  broader community of testers.

- nfsd-testing is not automatically merged with linux-next or fs-next.
  These changes would not appear in linux-next until I move them to
  nfsd-next.

- I prefer having the first patch broken into smaller changes to give
  bisection a little more leverage. Eg, the "restart:" and
  "bool = false" changes are fine in a single patch, but change the
  recovery actions for each status code in separate patches, maybe?


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v4:
> - Hold back on session refcounting changes for now and just send CB_SEQUENCE
>   error handling rework.
> - Link to v3: https://lore.kernel.org/r/20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org
> 
> Changes in v3:
> - rename cb_session_changed to nfsd4_cb_session_changed
> - rename restart_callback to requeue_callback, and rename need_restart:
>   label to requeue:
> - don't increment seq_nr on -ESERVERFAULT
> - comment cleanups
> - drop client-side rpc patch (will send separately)
> - Link to v2: https://lore.kernel.org/r/20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org
> 
> Changes in v2:
> - make nfsd4_session be RCU-freed
> - change code to keep reference to session over callback RPCs
> - rework error handling in nfsd4_cb_sequence_done()
> - move NFSv4.0 handling out of nfsd4_cb_sequence_done()
> - Link to v1: https://lore.kernel.org/r/20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org
> 
> ---
> Jeff Layton (2):
>       nfsd: overhaul CB_SEQUENCE error handling
>       nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
> 
>  fs/nfsd/nfs4callback.c | 107 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 66 insertions(+), 41 deletions(-)
> ---
> base-commit: 50934b1a613cabba2b917879c3e722882b72f628
> change-id: 20250123-nfsd-6-14-b0797e385dc0
> 
> Best regards,


-- 
Chuck Lever

